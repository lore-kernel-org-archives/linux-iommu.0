Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794184441;
	b=vN6q1aEG2JLMKoKRQ0E7hByH+At+uEoM8I2lzeKN+FtPxNiKaW4QhOgmFA1JrMDuB7BM
	 Q4YzWvFPH47sNNdotWxdIhty0jEq/XFTfUswOlH8I95kqS2bg3n2ROx8RX9y2unMj0MKh
	 wiGpnqP+VRfnEppB5ggTI5mZaAQSxQ1TxU0UfqW0LkcT6a7wGCc/nNu9uTB+kLc6fnFTW
	 qlOLRrF1qw5Pkw5H7J8HOP6SEm35H2JPe7EelBWAPL2KLseGP5hFoELVa4mdCydCaVDuW
	 cCNZuSNcpy4kseWFcWhhfDX6UcCetLxXVwAgTZURbxH3oXByo+4y2/f2kEHZ2q4y+fw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794184441;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=ro51FgAwM27DOCsfxJX1DqcXySD2o72+3qO5nSN9dQg=;
	b=vJKNCA8h8Au+sQpp7ufURqpmRH9dJxlQxlJE2BiygfOIQSZTJFJ4YEi7L1ZWL+ZnGwUE
	 6maShjFJ2EVh4cfaP/1tzqkDkLZ9QlMOZl3IETclwRRe4+agwbCtvU2jnJ7e1bw/myZ2L
	 GYo9HM9EPsGLcazeY2KqyDT4mvyU86YkeozA9pzurpYVRXxDup66J15mj2kUSsB/udQyK
	 TDO93uWiX8kAZnQD6Sc5ZrzDZpHxDvhMSF8hkZYhZo0/PWu/nOKmnCPW9g19nIPPmxmwi
	 eTAqi+FeRZZmPB9NfjJ69CFGxc0VA5SOraI9PYDVc/ybHXXTNrx7K4BgUfco3QdSaVQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CoCixarF;
	arc=none smtp.remote-ip=209.85.221.43
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B0C6606D81C
	for <iommu@lists.linux.dev>; Mon,  9 Nov 2026 00:34:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1B0C6606D81C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CoCixarF
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-4919a880834so164960f8f.0
        for <iommu@lists.linux.dev>; Sun, 08 Nov 2026 16:34:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794184439; x=1794789239; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ro51FgAwM27DOCsfxJX1DqcXySD2o72+3qO5nSN9dQg=;
        b=CoCixarFqCoCmrDzO/G8fqVirIhnPsv50HwJ/s6HFbDkcoiNxY+oNL+2NBlpXyQCQW
         /1OJ8N6CQd61wHFy7o4kodMUazZ9PcMOW9kAYSZacBPlecc7DGw5QjRZnVsir79BU7CA
         ceYSJvhsB2yyXFOPZF0dm/RWbaNv6vLlOvPiLOvIh6AGgZKyAaHk/YqhQRhFwN+XiSHG
         segKkObPRaWOtrNsLz2dLoluZLlXFs+/fpkBzlm/W+3jxTBERpy5XE5AFWF+yXR4oO6g
         Zi8sLyL0XX5T1c8tMdUovHb6IBQFScFSod+2k/qlxaRQqxQTaFldpDuktl8GGLssnV9Z
         gutA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794184439; x=1794789239;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ro51FgAwM27DOCsfxJX1DqcXySD2o72+3qO5nSN9dQg=;
        b=iEifigsRzzw9/p/N7U6yBuanQA5vgBdoS8tvqxAm1sCgt+B6vroUMzmOb8b9uWH+Km
         ovdu0f6fuoyap3idgQwSGvgvSxSJu1ChOKLDRXyScR0EqqufTF0XPN2CLfIw5aiq9Qtc
         qKdANyHVj5mYaNmDvBOyEI7Nn5RhzP4OdGi0raPPJPvquLhkQCGPV/KhAX03o0aAnzHi
         NjVkzxl4kvZpSJJtlm4r3QBVzRaM3+wwl60Bgm710dCobmWuemGQ7ojeOvnx7Te/x84N
         y8TGKkHjQSp5vl88z+AJ4zh1PKrW0BNbvdkKTYRfXJ09pYnWM80CNBIUsIVLi07XljKU
         qQSQ==
X-Forwarded-Encrypted: i=1; AL+hErETRAuk81DFgoUq8KUS/TAuspPoUOPIyzLpv843G47suxe13uPUa2S3CcH6Ja6JHjePHX4mqA==@lists.linux.dev
X-Gm-Message-State: APuU4Z8QaCmXkcOBQBx5k1cn84TKF5lKOqOJv9VxxbLredxqOORo3R/1
	8SfIJYg5K2jpD9ONl1Hx3sqfSAMHjm+4xpLZmgaQr3l2FLW1GYrCgw8P
X-Gm-Gg: AYBFou2E8RmyfcO8rJaO96ZDZYYRE2Ldd41SMPaNLE4d6r0IUSgMTYco4PKBOs8L+Gu
	IULpQKRWba0CrIyCZ81X3im5KgQErYveowX5hKpD+J8TU2ScbGjambHen+F8yKMLENisCT42urp
	+rg3gS+A7PnUYkqkyptfRiwDKwLQ6x2xcDxdR7eNB18NWMW7GlwYKyPqdEr+Q504a08YW22OFHR
	BqvZoi/AVkDArt53I8Zu50TK9DNwkYdFkYjvCBTi3ewNc21ejcVVMFFFT7O2fPNZC5I4Jw6uBc0
	HwauHIZKO5RbOogEpuEOZDFbeJ/rkfAtv+CvvxPNpraM+nXw4uByw02933JeXGLiHXMYAkadXNT
	d3QhsyPC8Lyi+ur7H258yfKs4JKOFyTxzGsDUYig/3aFtZgPpd257AeEdzgiFLDgoUBNu5iP0MJ
	kEes7V4BzXeBNQYDQ/fDXf6/vCiDEHnQrYDgxW3VC6/hH/PQ7zoBC/fSAa4kJX9xpWdQvZiqec7
	2x9iGDjG6RDlkW3MOPTf0FoMHh0jsfLEHvNMAtsDyFKBOWjASDO3UeckbaDbKAgFzbx2MZiSIFV
	dtAChKlQChiYCVAnnu69r51zDOH5p61nlGxSIWgtu2mw6rBRsGvFAH4VGkGuFA==
X-Received: by 2002:a05:6000:3c5:b0:493:2376:81b7 with SMTP id ffacd0b85a97d-49588ecc152mr4851434f8f.27.1794184439552;
        Sun, 08 Nov 2026 16:33:59 -0800 (PST)
Received: from [192.168.10.105] ([212.58.121.92])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49592f39c8asm6541675f8f.7.2026.11.08.16.33.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 16:33:59 -0800 (PST)
From: Stanislav Aleksandrov <lightofmysoul@gmail.com>
Date: Mon, 09 Nov 2026 00:33:19 +0000
Subject: [PATCH 07/17] dt-bindings: usb: qcom,snps-dwc3: Add Halliday
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
Message-Id: <20261109-halliday-dts-v1-7-289114ab8197@gmail.com>
References: <20261109-halliday-dts-v1-0-289114ab8197@gmail.com>
In-Reply-To: <20261109-halliday-dts-v1-0-289114ab8197@gmail.com>
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
 Sibi Sankar <sibi.sankar@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, mfd@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, 
 linux-usb@vger.kernel.org, linux-phy@lists.infradead.org, 
 linux-scsi@vger.kernel.org, linux-crypto@vger.kernel.org, 
 linux-pm@vger.kernel.org, Stanislav Aleksandrov <lightofmysoul@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794184395; l=1289;
 i=lightofmysoul@gmail.com; s=20261108; h=from:subject:message-id;
 bh=cCyX7eu7E67i1+mb+zFb+/V3MZ2Z8Bvs+BbDvfy8HQI=;
 b=HQwzvS1g9UbQKH8v0/XpwTYPPGyIcJ129Y8yti74NjNwgnbgo8LwZJmaOxKeuHMuvgkZ+EP/2
 IP5h1J7SLhzC0/e/TSquB9CwBZEDq02qBgUbIWpMHDatD8Y+sZaCkxU
X-Developer-Key: i=lightofmysoul@gmail.com; a=ed25519;
 pk=jeRUlfmkhE53CJPoeIIXgu7rTE0ybDRH0HQrEwbydzg=

Document the DWC3 USB controller on the Qualcomm Halliday SoC.

Signed-off-by: Stanislav Aleksandrov <lightofmysoul@gmail.com>
---
 Documentation/devicetree/bindings/usb/qcom,snps-dwc3.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/qcom,snps-dwc3.yaml b/Documentation/devicetree/bindings/usb/qcom,snps-dwc3.yaml
index b77c02c64d45..7a8b72d2929d 100644
--- a/Documentation/devicetree/bindings/usb/qcom,snps-dwc3.yaml
+++ b/Documentation/devicetree/bindings/usb/qcom,snps-dwc3.yaml
@@ -27,6 +27,7 @@ properties:
           - qcom,eliza-dwc3
           - qcom,glymur-dwc3
           - qcom,glymur-dwc3-mp
+          - qcom,halliday-dwc3
           - qcom,hawi-dwc3
           - qcom,ipq4019-dwc3
           - qcom,ipq5018-dwc3
@@ -209,6 +210,7 @@ allOf:
         compatible:
           contains:
             enum:
+              - qcom,halliday-dwc3
               - qcom,hawi-dwc3
               - qcom,ipq5210-dwc3
               - qcom,ipq5424-dwc3
@@ -570,6 +572,7 @@ allOf:
           contains:
             enum:
               - qcom,eliza-dwc3
+              - qcom,halliday-dwc3
               - qcom,hawi-dwc3
               - qcom,ipq4019-dwc3
               - qcom,ipq8064-dwc3

-- 
2.55.0

