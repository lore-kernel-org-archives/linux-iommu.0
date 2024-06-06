Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8604195979
	for <iommu@lists.linux.dev>; Thu,  6 Jun 2024 13:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717679718; cv=none; b=Wt4NhUhM+ISWEkHbHp15h+aPCfZJyXeDEoyy0pjJtdwVtlyYI+T/mHZixVDgFVP8DWGsFm4suJKDPhiiVUpNO5GoRpaDQZnt2BSzqzfl6qXpSGX3OfYvAxA7VqPvn1oGTAoqqVTjYDqMsB/2HrJXPz0fS0suTn9vZWFP/7Ns4Nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717679718; c=relaxed/simple;
	bh=ifgqih26nGwEUb+VADWix3TIA1A7UraZIFOAnjNBJ2c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=eIifIG8Kl22i7GNuQJD1+WE9oX6ZMKnGbC5VHlJPDZ4DFaFRhbtuU9xF1nB3V+I3ZxOrh9YzYlHIDr+7vZ7JgmDTyAgfS3TeZ2AfdMJslzAzi4CY+g9STTS5TQH6n5+vYQKgda3K1wrt33CQVZF/B7c8fwOp8Zu4VCT0G+ss2Ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=f42MDrZZ; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="f42MDrZZ"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-35ef1e928c9so1102302f8f.3
        for <iommu@lists.linux.dev>; Thu, 06 Jun 2024 06:15:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717679715; x=1718284515; darn=lists.linux.dev;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MutauDGZ5LvIHf1GxJ/Kkch8vYilJF3OfUKPFD5XiLA=;
        b=f42MDrZZXuCMQcHqxZvIYCtgItYEfdKl7VlO60v5I5lmVORqsdh4vZflcpZzPB+ttJ
         QEkxepm/31eSvwaQ7uABZwQuIaE4VO6qqeel2uldo3f5wf43aQArwE4TRujx3woTJG8s
         Ks/LvVVH2FE7ZiVZPUBGqDiBU8/B2DlWSW8IVbnP6ezWl0wLqUZ8LasmT8WQLqD57eBX
         OSbfIXDHytDsfIPR0FwOQ3RB43BbCoMSDLxtHpuwAv6RYTNBmPCnvG/XLWsdxYllB2Dy
         MnPX+pa/X5mg9trjzVEfPhmIUKCo4nTxLyziKsJSgTkcNLPKY+pahRdkXkepd4joO/+V
         Iqdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717679715; x=1718284515;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MutauDGZ5LvIHf1GxJ/Kkch8vYilJF3OfUKPFD5XiLA=;
        b=KwrW66ecDrwPt8Yp/Sxg4v6IBzCg8aYOL7krGnCsZ2zxX9uajOrZrqDa2OnOLFXIFe
         tj7gl7+96/b/19vg3QxQzYzSzelaEJo3c6YDxvGf+FgepUYzPJPip/mSSTA2OmLkK+dC
         7W5PLyma5kK9WK/O8A0+/PaCKXrq/VGBm0OD1hGVCxVT55Nq7U/CcRGyF2hV8dLsRpVU
         WaIBP50E/uLeXeULO0i5YZ+fbIEnUVTZURVppPgxT+uwgUrYCcso7l+dMpqsgNKryKcW
         cKmGE9a1JxDyFQ9ozoaBRs1sKKbytGeOK61+/rN0oGeN7WwnBsKGlwizJVm8b47A308F
         sLmg==
X-Forwarded-Encrypted: i=1; AJvYcCXMisY3fsOxtD774zfXyEhWdZ7FYjVou48nOwI7gRbhurzWF3M5jZHWgEqesEPEihw7qZl9i85yLEEQso6lzUDft6mNasc=
X-Gm-Message-State: AOJu0YxNufvkv/cJo8ep2MnbqGMGQd0XvOrFrymDsfcLup25xRHoeKAZ
	CNKDPgu0oNRxnV6WQpF/D9bJLZ5q8QzWzn1VwQeT3RZyRCkAxN5ysmXA8WSfAwmtZhdv8AVgP26
	T
X-Google-Smtp-Source: AGHT+IHE2iU8tD9EQLBqF698RfYd9HC+NNoZVPGXSGg54w1e5bsfBfjfLQEgMhsbn9rNCiOKOGu97g==
X-Received: by 2002:a5d:464a:0:b0:357:7590:921d with SMTP id ffacd0b85a97d-35e98099153mr5147467f8f.66.1717679715117;
        Thu, 06 Jun 2024 06:15:15 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35ef5e989b3sm1558378f8f.71.2024.06.06.06.15.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 06:15:14 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Thu, 06 Jun 2024 15:15:12 +0200
Subject: [PATCH v2] dt-bindings: iommu: qcom,iommu: Add MSM8953 GPU IOMMU
 to SMMUv2 compatibles
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240606-topic-sm8953-upstream-smmu-gpu-v2-1-67be88007d87@linaro.org>
X-B4-Tracking: v=1; b=H4sIAF+2YWYC/x3NQQqDMBBA0avIrDsQRhO0VyldmHQaZxENGVMK4
 t0NLt/m/wOUi7DCszug8E9UtrWBHh2EZV4jo3yagQwNxhmH+5YloKZxsj3WrHvhOTWnijFXJG9
 HCv3gg3fQIrnwV/734PU+zwuIgLidcAAAAA==
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, iommu@lists.linux.dev, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1218;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=ifgqih26nGwEUb+VADWix3TIA1A7UraZIFOAnjNBJ2c=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBmYbZho8agAAwKO4MpxitX6pjWoQ65Lw/7Hs2x+Ol3
 1mW2wZyJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZmG2YQAKCRB33NvayMhJ0VHWD/
 0ceqrd0qGn9q8+TkXtxou9bRW/zUapvB3Xpo6idXcnSxBxwl0CNEfj6EsbyZ/80pIgD1xPAUxO4oMS
 2/NpMJEM6fU6+17ma/KGOG0GEER2uttsNGq1t9M48V5cu4uMt5M0eveGjNZFI5buwNyRHxWCrt6LF6
 RJH0UbPxr1r3JFwTHcpMcZGsI2ORKYZvvktQN32CFpoFBh4CCpa1huupwIr9oiKGtHgVNcHUDBE7Ou
 qffaPARY0rzZq6nmLpHBC1u0lYIq5UgbYvgWMhU2H3fRL+axM2qiaJKnIrxilbVJmBIHPHTMLSwAKz
 yk4BW456MjBBpTUxd3BXv5y5ux4+EvXP2WwDkxPYiDFQIUCmZ4/4BA+WBQRrYI7T8nIV8LEofAqV7W
 7iMOk3I5IZZQmfG+6LZWQ3Ica6mS1h//J2udiu5RF91QrJyfxonXYu43aeDYPABsw1K5OJTbLkARHZ
 CyiSrlUAQwt5QXFGI4gZhQI9u+xga1LMDUsxx+9+mGJoTZ2hyFrn+E6lGtXANezCuP7qBRGxSMermS
 lPOHV9mCqypqAbpIZdgfa/btTQix+HQJLJ+pS2BHcrwxr7n4jGXPDpEV2J2FxmZnvl0b/zSLV0JhNe
 aW3v0+lSfICep8aXLG6hKBUMYIDHOGV+4j7pIzF50+qKeBQF7lPTeQDO8zdg==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

Add MSM8953 compatible string with "qcom,msm-iommu-v2" as fallback
for the MSM8953 GPU IOMMU which is compatible with Qualcomm's secure
fw "SMMU v2" implementation.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
[1] https://lore.kernel.org/all/20240523-topic-sdm450-upstream-tbx605f-v1-0-e52b89133226@linaro.org/
---
 Documentation/devicetree/bindings/iommu/qcom,iommu.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/iommu/qcom,iommu.yaml b/Documentation/devicetree/bindings/iommu/qcom,iommu.yaml
index a74eb899c381..571e5746d177 100644
--- a/Documentation/devicetree/bindings/iommu/qcom,iommu.yaml
+++ b/Documentation/devicetree/bindings/iommu/qcom,iommu.yaml
@@ -25,6 +25,7 @@ properties:
           - const: qcom,msm-iommu-v1
       - items:
           - enum:
+              - qcom,msm8953-iommu
               - qcom,msm8976-iommu
           - const: qcom,msm-iommu-v2
 

---
base-commit: ee78a17615ad0cfdbbc27182b1047cd36c9d4d5f
change-id: 20240606-topic-sm8953-upstream-smmu-gpu-2b582c34bcb6

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>

