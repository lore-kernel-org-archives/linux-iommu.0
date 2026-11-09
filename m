Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794184466;
	b=obikpzb9/lW9dcPcA9tNmUKLtXyvWeoYZ57g+A1YD+LAf5jYWdFxVu2TGsjf1/ks2jjQ
	 B44BMljl8Gl8au9nggHepFDaYmp6O6PsjY+s/PHQbeoXShryQXSPMxFm/0PD6HRVsnFYk
	 tmU2DQo+gJqrGsnktWMH5ps2uWECMgCkk3hLCe2GJcB3wZuic2fGlFWfTzXAG0OUzJWtG
	 2LgWX5L+KG/GYElqo5WTif16Clh8TlEM1A6RNNqqITlxpI12Y6638FJV7XN78ymnL5gLR
	 8G+oX4yGdGR3R8/KBLqI0Gcf0+c9wX3w758zUB0114L9VuwFpmyQdXAt5H1ntdhkZPw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794184466;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=UNI0IawohcjDnjoicCHviRRe2GFEz6OyLASUQR+3Ovw=;
	b=UVaY2Fa5OUVgKw1b9uaFu3pz8PSMIXCY4VOw0ScrsPlqYybo0JF/MwdwQp2iCy8Rfv4r
	 O3/ITSm0XU5K8W0NCGe/+ZPuzsTEV7JLMXNamowlBKOjd9jBBOHF3v21EEaZjoTVNusdW
	 I9/8YFs5kyMfR4sxOB8DAaIX9JVh/wv4c1rIwKKI2sgWA6H1pmVzofKUUvXMJxxaJL8MU
	 zy8MaI/0FLyYHK02ez/ieJTrX9T8ft+uIaEKc/DCfHtrpRudE5AFnNpawZM0xgrbCf71t
	 7isDLYxeMxqVjh0yWYPgCwr4s+Xx1Ih6UOVoGSvM7kE4Zvr4ONWugn6dAHH9rYsv+ow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Seat8WKG;
	arc=none smtp.remote-ip=209.85.221.51
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B9F6606EEB7
	for <iommu@lists.linux.dev>; Mon,  9 Nov 2026 00:34:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1B9F6606EEB7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Seat8WKG
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-490c3ae81d3so187654f8f.2
        for <iommu@lists.linux.dev>; Sun, 08 Nov 2026 16:34:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794184464; x=1794789264; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UNI0IawohcjDnjoicCHviRRe2GFEz6OyLASUQR+3Ovw=;
        b=Seat8WKGzmMs68x3d9uGDTCWGW8g3g6b0F2H7aDDyQ8X9GQi6gixZDnl5IlKb5EKqr
         IBHEdmkRi6c86A/tOhnT0qZtPD/3HLoQNOJxpKtrPmxXp2PrVoEdgPcqDVZ679yjbE8q
         5kfHX3XbTvitX3/G6njX49jgFcqfVsb4foMcAW6leQIbTNTu8gq6LXHgkmy7Rm4ohyMG
         h2TYQuOjKZi6HUVWORtpnquml0NPDS9okNGcjOphg7tdS0asJpJsjhagMzmSOojTTPI1
         nCwl6ct25SmrW9Xgoc+xG3Q0+ENV7uv7TN6qfp6qoGqFbf0QciXc0poHVWRPAPSPYDQ+
         ZBKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794184464; x=1794789264;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UNI0IawohcjDnjoicCHviRRe2GFEz6OyLASUQR+3Ovw=;
        b=pK1CZ4pEkhJzwnVLQwvkof3t0s09R/uqcSRZnyY59zFk12inxNJJXbJ5rh89eU1YGS
         r/9rIXE+6CoxS2PfIWbN2w5nD3i3MfFNMIVnTetZocLtLGsA6WQTrTZ0UyzS83xFWlbp
         Tptf7Siu2vdsERg2cNqr3zCWsfKD6XYU7c4QC74P4jRTGXsz4nYkct1X5ieVWHfyheXe
         5iTIAMQdKpjBvOimz/N5ggiIo3Xy0573cM+fb2P2aW7Rs1/8WfR8gTynxW6MwgNChCXL
         PzFiUjJzYBuMuRhNUbmoGR1fGO7Q65D0ounwJG/Sknx+cmDtKq5VjoXVMMFEFG+0FvWw
         pWjg==
X-Forwarded-Encrypted: i=1; AL+hErH/R91S821FpB/ot97Hod6L9D2r7HhzR5KUpigFKa7no1eMRHWGrSDQV82Wy+AdxM/egYo8jA==@lists.linux.dev
X-Gm-Message-State: APuU4Z8MRCOKXlXIVEsv7wM0VMB2Q3zR7N2PFIAwM4VsNwqJEuj+e+ew
	ICoWmP7cEXr3W8XcR12SzzvBXAQpOxNDBrrz8Hj/Y90m/eqyRqZG8KyY
X-Gm-Gg: AYBFou21puA7tCTCr/mnxGZOAAV9wjhDivxZ+XGQsP9nj86yzJiaTKVFp+TYFXNQGcr
	CnUchtezASOCgUOQ6ETJz93TtKYpoO4vLDDNHQrjiwgM3JhPXm9fWWE1zTOkjtijLAjRWMtlR/q
	32WAv2E/9yBUfXDz06vRyuNMAL/DI7XVx4wEw8aIqCK68feX0HDmCJxs3ouQqwWeN4sVzGE1yPp
	aY9X3lYtnyesHk1nJCV2dPVjZM1+C15BIV+4/7icPBssOszFI9EziQQuvSP2mAoaNmwXBLAsMsw
	P16056/e6fGoJ0UNgqABoPyQjRWNZyj7sIqfm30//AoQjD00KNzBPf79Uqf0Rw9Id6CZGJurpVE
	95YMZGRcO0BkXfGsouj9cpraypSGy6i1/8nrP/3pw69OLahaLGvFfaVRJvhqBvrjJo8FX+mQpCu
	eKuqUMPiSKyJmIM9qLhIRoCYooOTbuXHLVd8eRET6HWqFO9v1hD7z4umCit413oPi4URBbfoQmP
	XzrTbo5yOar2SCwKn6HIkiyxrHCsP3mPOIqLX07n70vzIjUmw1blGfHbz5mdO2p/04+6+eDl1UM
	9vXpVfrJkQjS3o53K8+5c9gcop641P573WFBX1rX
X-Received: by 2002:adf:e19e:0:b0:48e:44c7:bf0f with SMTP id ffacd0b85a97d-49588ce1818mr4774036f8f.25.1794184464442;
        Sun, 08 Nov 2026 16:34:24 -0800 (PST)
Received: from [192.168.10.105] ([212.58.121.92])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49592f39c8asm6541675f8f.7.2026.11.08.16.34.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 16:34:23 -0800 (PST)
From: Stanislav Aleksandrov <lightofmysoul@gmail.com>
Date: Mon, 09 Nov 2026 00:33:23 +0000
Subject: [PATCH 11/17] dt-bindings: crypto: qcom,inline-crypto-engine: Add
 Halliday
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
Message-Id: <20261109-halliday-dts-v1-11-289114ab8197@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794184395; l=921;
 i=lightofmysoul@gmail.com; s=20261108; h=from:subject:message-id;
 bh=LNBr+b73CKCaJq+Lcoy2dBwwEKE3EuPIoRzvD97HKJ8=;
 b=/dOrZ5kbZXiJ0bcfGwkBHl7a+YAKGn1bUTdYux1Y38RVDKws5L13g0SU1+8SFR4l0gLQgTvYS
 wprUB1wAKuOCKc4gs9aCLEB0eoMZXLaWUvR2Qma/3ofWIp9EDkckTFe
X-Developer-Key: i=lightofmysoul@gmail.com; a=ed25519;
 pk=jeRUlfmkhE53CJPoeIIXgu7rTE0ybDRH0HQrEwbydzg=

Document the Inline Crypto Engine on the Qualcomm Halliday SoC.

Signed-off-by: Stanislav Aleksandrov <lightofmysoul@gmail.com>
---
 Documentation/devicetree/bindings/crypto/qcom,inline-crypto-engine.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/crypto/qcom,inline-crypto-engine.yaml b/Documentation/devicetree/bindings/crypto/qcom,inline-crypto-engine.yaml
index 23bf98c2b9fa..1512fd1d7471 100644
--- a/Documentation/devicetree/bindings/crypto/qcom,inline-crypto-engine.yaml
+++ b/Documentation/devicetree/bindings/crypto/qcom,inline-crypto-engine.yaml
@@ -14,6 +14,7 @@ properties:
     items:
       - enum:
           - qcom,eliza-inline-crypto-engine
+          - qcom,halliday-inline-crypto-engine
           - qcom,hawi-inline-crypto-engine
           - qcom,kaanapali-inline-crypto-engine
           - qcom,maili-inline-crypto-engine

-- 
2.55.0

