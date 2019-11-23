//
//  BarcodeView.swift
//  Bookeun
//
//  Created by 이병찬 on 2019/11/23.
//  Copyright © 2019 Lizardmon. All rights reserved.
//

import UIKit
import AVFoundation
import RxSwift
import RxCocoa

enum BarcodeReadError: Error {
    case canNotGettingCamera
}

class BarcodeView: View, AVCaptureMetadataOutputObjectsDelegate {
    let captureSession = AVCaptureSession()
    lazy var videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
    let currentCode = PublishRelay<String>()

    let coverView1 = UIView()
    let barcodeGuideView = UIView()
    let qrcodeGuideView = UIView()
    let coverView2 = UIView()

    init(barcodeGuideSize: CGSize, qrcodeGuideSize: CGSize) {
        super.init(frame: .zero)
        self.layout(barcode: barcodeGuideSize, qrcode: qrcodeGuideSize)
    }

    override func attribute() {
        [coverView1, coverView2].forEach {
            $0.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        }

        barcodeGuideView.do {
            $0.layer.borderWidth = 2
            $0.layer.borderColor = UIColor.white.cgColor
            $0.backgroundColor = .clear
        }

        qrcodeGuideView.do {
            $0.layer.borderWidth = 2
            $0.layer.borderColor = UIColor.white.cgColor
            $0.backgroundColor = .clear
        }
    }

    func layout(barcode: CGSize, qrcode: CGSize) {
        addSubviews(coverView1, coverView2, barcodeGuideView, qrcodeGuideView)

        barcodeGuideView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.equalTo(barcode.width)
            $0.height.equalTo(barcode.height)
        }

        qrcodeGuideView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.equalTo(qrcode.width)
            $0.height.equalTo(qrcode.height)
        }

        // 둘 중 height가 더 큰 View를 기준으로 coverView의 constraint를 구성한다.
        let targetView = (barcode.height > qrcode.height) ? barcodeGuideView : qrcodeGuideView

        coverView1.snp.makeConstraints {
            $0.top.left.right.equalToSuperview()
            $0.bottom.equalTo(targetView.snp.top)
        }

        coverView2.snp.makeConstraints {
            $0.top.equalTo(targetView.snp.bottom)
            $0.left.right.bottom.equalToSuperview()
        }
    }
    
    private func setGuideFrameColor(success: Bool) {
        let color: UIColor = success ? .blue : .white
        barcodeGuideView.layer.borderColor = color.cgColor
        qrcodeGuideView.layer.borderColor = color.cgColor
    }

    func initialize() {
        try? setCaptureSessionInputOutput()
        setVideoPreviewLayer()
    }

    func start() {
        videoPreviewLayer.frame = UIScreen.main.bounds
        captureSession.startRunning()

        bringSubviewsToFront(coverView1, coverView2, barcodeGuideView, qrcodeGuideView)
    }

    func stop() {
        captureSession.stopRunning()
    }

    private func setCaptureSessionInputOutput() throws {
        let session = AVCaptureDevice.DiscoverySession(
            deviceTypes: [.builtInDualCamera], mediaType: .video, position: .back
        )

        guard let device = session.devices.first else {
            throw BarcodeReadError.canNotGettingCamera
        }

        let input = try AVCaptureDeviceInput(device: device)
        captureSession.addInput(input)

        let output = AVCaptureMetadataOutput()
        captureSession.addOutput(output)

        output.do {
            $0.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            let types = $0.availableMetadataObjectTypes
            $0.metadataObjectTypes = types
        }
    }

    private func setVideoPreviewLayer() {
        videoPreviewLayer.videoGravity = .resizeAspectFill
        layer.addSublayer(videoPreviewLayer)
    }

    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        guard let object = (metadataObjects.first) as? AVMetadataMachineReadableCodeObject,
            let codeObject = videoPreviewLayer.transformedMetadataObject(for: object) else {
            setGuideFrameColor(success: false)
            return
        }

        // code가 guide view 밖에서 인식하면 filtering한다.
        // 코드 인식 타이밍
        let codeBound = codeObject.bounds
        guard barcodeGuideView.frame.contains(codeBound) || qrcodeGuideView.frame.contains(codeBound),
            let code = object.stringValue else {
            setGuideFrameColor(success: false)
            return
        }

        setGuideFrameColor(success: true)
        currentCode.accept(code)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
