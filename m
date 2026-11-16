Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794864421;
	b=4wjBb7ym276fqyJrL66H/noeIWRaK5xP335ABwQclYZZ15Yeba1vhxvwGWI2QcqKIBd1
	 hNd1BNq3oCshr+8jhdDa/k47bMu8YN6k2K8S87RFDPMliMyNK8zOuPKwfScSWL1ffeOEe
	 zpIFkd2pFexb5Sh7BXRTrHAGVqM9hCjZaiCb2WdJw1po1osBOyOEBQosF7pSn6oRX7rUn
	 pzkdUyiYvaCmnep/dMcrQuA3PXuwlFl/MnfE1X21L5AB31v6c/ISpo7530MWa955uzo+S
	 V0KCRhsSAJ6GmNTS4vSI1IPc9Tyuz1pCG80yFske8CmcgaacdwQCamNPHL0V/3GlctQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794864421;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=LnAQsJm0J9tjLLptwYNMgJxavVvbhamVp2XrX/3IRso=;
	b=N5UJXuklppTkTDaRLuOewxbC0VpcrAWqlXE/ow4n1jolLfUP+ZFmCAhSAp1jCwCx6l4x
	 7khFT6+1A8jROsLfy9A4Dy/T7NX8ulH1qoBSODvFM/B4XWNSw5wPD/pFoFT9shb3/Fusb
	 jXUAwIeXs55NRQ0ztWKdIAGoF3cWHvDVo6xfLwWnoYlOahPZPJAM7ILilK40b6Dz5xCSA
	 BJ5NpNUm+0Ju0bxWq+VX8qq5hJSVGHDS/eS3K7LOiYUU96xSvLZAbPTuIltTq4mSZzlAR
	 ocRXZHwE1C1d1YNyx46KHPhZV6HgiD4oROoqs7ONj5kv5T2dtUN8x2q1a2SHQ2fyAvg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Q2xy9Ocv;
	arc=none smtp.remote-ip=209.85.128.48
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF947606A332
	for <iommu@lists.linux.dev>; Mon, 16 Nov 2026 21:27:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EF947606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Q2xy9Ocv
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4a35d5d4a20so48110365e9.2
        for <iommu@lists.linux.dev>; Mon, 16 Nov 2026 13:27:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794864419; x=1795469219; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LnAQsJm0J9tjLLptwYNMgJxavVvbhamVp2XrX/3IRso=;
        b=Q2xy9OcvY28vTR7lTkKqthZOT/12FvBEHW4eejMuo9ckP3wMDXglm9yqQNfGCqVHXY
         krrqd7XprD3YJMGOKSM5/8VNRgcU2nG/RlcH0L0kS7Ycgo9m8v47YIeYe2PNcXocY7w4
         TbWcTt2D2XVskTLxQCR6NbhjGzgEfQAoEEVnaQlkv9RkttkNuVHuqhAI+mNP0lwgP9m9
         lO6OxUCH8nHV221+PA0ovHyW/GnMpXQbbWrRDeHhYRIWt1ojXVdJZ61kKnCFhYZWk6V6
         JJM/O4yX/XQ3dohflC6T4oabdyYQqiXHS4+auPtniIYXevsKw1vEEUAZCHz+Ur99q3SP
         TS7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794864419; x=1795469219;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LnAQsJm0J9tjLLptwYNMgJxavVvbhamVp2XrX/3IRso=;
        b=OfR5tQvVzg0AilIEAormAtfdcEBynUKf/WMcFe/NEhULMIc/01XdW1IT8mFHxQl7kT
         RiQqUAjBND85bpsf+zd0d4Ht7iH96hUQC8wQhsldhCkgayVjo+8Qh/8OOsUVDNfdo5XI
         lD8vs7R3CDRBrVGSCW/aEMgYTTnwwXy71cplqhbhiuIcVT6QnuxG8yIqVv3/Zx75JuBF
         iOoCSGhgEAm525qaTcjL8vU69j2bY3C0vo1Y4lIurTS7CuVJRYvbv1uJLluD9tngRHuV
         h8xo8J4/yfhUh7zha71KmWHUFQ3CXm2WGLrv3cnMlxPKK6iq+Xl7LTZyKlQR4SW4nr0u
         PxAA==
X-Forwarded-Encrypted: i=1; AL+hErEwGddIxUYVaas1T5Gt0CWgNaB1vjFQN/e69hwJGvJHl0uAAXXWQbV7xCXXtPSV5ESsbRqXPw==@lists.linux.dev
X-Gm-Message-State: APuU4Z8esZfuAsQwJSkezXaEa9pgig+OJkXtdwytIlVEOWwxjQeLRUgb
	tsYMnCQUaEenn3xiL6jBVgLXBbXTr1vpQZIv5ARi+ZiopjW6Rw2MFq2D
X-Gm-Gg: AYBFou3sbNu2ofojLV/7mDVK7iLphY/uqAbEFwjyiRaPhaDozYixRoDJehlpg5VdsUC
	edFtBjjbgwt+j4WZflWq1RNfJki8U+3P32MH3t8Ct6Zy2K+UqOTirmpGB0RcnIzYi9HyJGshcJZ
	7l7w+gGu5mNvMMnftKBw5SnWE6wkddn1VQDZHKKd6HytrXAH7ld+TKkj70eG0dqzt/feyPHsv5r
	c04T+4ekDPgh+NGeyvg4qOrtVnfNhLMzJcxHQK2AN6el4W31dRrpPeOtVqE9A8lGtfdqnoF7YU6
	Q1I5lleWrrjSLG8rGMF8lTKJo1GGylT492/dJ5mhiWJJjF4wKdhWig+vm+4RwiRZr2J+NVe3s+d
	3T39VBthGTi9SMk5VGP43lVBxYG3IlYq03tOz9AnQAmU55nIZG09WGDFXSMy11iKcaIQIkn0vG9
	JC7/70mEWtXLoi+eh+XuGP3tyb/LSK1zsu10J5AuGVlDOkuV2wbcOHWwKgcZuU1OelNhguUIMit
	kif/9ONveWkrJxInrXGwKLpB3BHK4i17l6V/yVtij3Qwmddjb1BLUxkY3mVZ9NMK1xtnFl+7Ze0
	StatFLyy59bAM96nYeFQx2aP3dEYbtqWOHR3UVB0
X-Received: by 2002:a05:600c:482:b0:4a5:75d2:c104 with SMTP id 5b1f17b1804b1-4bb55a59c9dmr184592375e9.22.1794864419406;
        Mon, 16 Nov 2026 13:26:59 -0800 (PST)
Received: from [192.168.10.105] ([212.58.121.92])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4a378138cfdsm1260150f8f.58.2026.11.16.13.26.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 13:26:57 -0800 (PST)
From: Stanislav Aleksandrov <lightofmysoul@gmail.com>
Date: Mon, 16 Nov 2026 21:26:20 +0000
Subject: [PATCH v2 04/16] dt-bindings: arm-smmu: Add Halliday SMMU
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261116-halliday-dts-v2-4-2c92438c6c46@gmail.com>
References: <20261116-halliday-dts-v2-0-2c92438c6c46@gmail.com>
In-Reply-To: <20261116-halliday-dts-v2-0-2c92438c6c46@gmail.com>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Robert Marko <robimarko@gmail.com>, 
 Guru Das Srinagesh <linux@gurudas.dev>, Thomas Gleixner <tglx@kernel.org>, 
 Radu Rendec <radu@rendec.net>, Lee Jones <lee@kernel.org>, 
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
 "Joerg Roedel (AMD)" <joro@8bytes.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Wesley Cheng <wesley.cheng@oss.qualcomm.com>, Vinod Koul <vkoul@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, Bart Van Assche <bvanassche@acm.org>, 
 Bean Huo <beanhuo@micron.com>, Stanley Jhu <stanleyjhu@google.com>, 
 Herbert Xu <herbert@gondor.apana.org.au>, 
 "David S. Miller" <davem@davemloft.net>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, Amit Kucheria <amitk@kernel.org>, 
 Thara Gopinath <thara.gopinath@gmail.com>, 
 Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, Georgi Djakov <djakov@kernel.org>, 
 Sibi Sankar <sibi.sankar@oss.qualcomm.com>, Ulf Hansson <ulfh@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, mfd@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, 
 linux-usb@vger.kernel.org, linux-phy@lists.infradead.org, 
 linux-scsi@vger.kernel.org, linux-crypto@vger.kernel.org, 
 linux-pm@vger.kernel.org, Stanislav Aleksandrov <lightofmysoul@gmail.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794864382; l=1185;
 i=lightofmysoul@gmail.com; s=20261108; h=from:subject:message-id;
 bh=48k8tRM2Ds8B2KdX/k6MNHyKgJdAqOSEc8lLmnEqak0=;
 b=jdhSJvOgnkWCr3N/XewHYvU/DMh7fs9E9l4PMB3CyD3bi1r+fHKz+jcOeuCkYmmgxW1wl/a9T
 LhE9PjP/kP5CRKJpxWsTiZqjVGzsx7uCz1lP4rAnXmBZayBQqDt+vzF
X-Developer-Key: i=lightofmysoul@gmail.com; a=ed25519;
 pk=jeRUlfmkhE53CJPoeIIXgu7rTE0ybDRH0HQrEwbydzg=

Document the SMMU-500 on the Qualcomm Halliday SoC.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Stanislav Aleksandrov <lightofmysoul@gmail.com>
---
 Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
index 6748351c7812..925afa8cca8d 100644
--- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
+++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
@@ -37,6 +37,7 @@ properties:
           - enum:
               - qcom,eliza-smmu-500
               - qcom,glymur-smmu-500
+              - qcom,halliday-smmu-500
               - qcom,hawi-smmu-500
               - qcom,ipq9650-smmu-500
               - qcom,kaanapali-smmu-500
@@ -629,6 +630,7 @@ allOf:
             - enum:
                 - qcom,eliza-smmu-500
                 - qcom,glymur-smmu-500
+                - qcom,halliday-smmu-500
                 - qcom,hawi-smmu-500
                 - qcom,ipq9650-smmu-500
                 - qcom,kaanapali-smmu-500

-- 
2.55.0

