Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794864452;
	b=iChXMagkWF80zZ2X66nDCtxdKMXgaLN1O1+Wh6e5DE/dHdWozklC4LpWjWy/o2NApweC
	 27pveFVjFu7HqrXRCtycM+jlLd5rkF0TwJEhrPZ5tmPCKZyM7bLTKDDoaCJoGZ8w1YXMJ
	 oAKQMCZthM7EXNZF+RGtWENOCBi7i8V1PtDz6ZGRF+g4Hx3a4Xxf9E2niC6See1cea9Dq
	 bru8/4Kn1WEl9qV064v5HwGzsmSV23t0OlD8D/su7JJ8Hz04RHiW/BXL3tOwEirQ5hxKP
	 +Wx9d6hg7E29xJrbJZXnRZaZOzIoqSJIvJh3Or3MkjmcF/mjMapp2CvvlP/lM/gX8GQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794864452;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=UNI0IawohcjDnjoicCHviRRe2GFEz6OyLASUQR+3Ovw=;
	b=ReiAXaSeHSRBSvEz8+sydnIetA7u8CNwduUO6g4ewRlK7TGcXWwg1eSJJEbJS/JPZR6u
	 b6Tmx91vwsKz5IK5bfjboRROFTHGAX42YbCPNOg+muTCbZcScVGxpcOOE5lIPOB0vrTwG
	 MPFwLVfsjA/ipZEFUi69gP1qsPwUObGfVlO9N9sbLPep2cgqdAnb0kIHLblI1E7Mu3UIL
	 8JlKK1UgilIgPE8AnweNOc8GyFDUPfwZ1X4EkHDAX2Ywm1Tn8oxIWuFQZ4r84GWLr9B6A
	 Ah6bGd6J396rL0rI1TgW+kynKHrd3l7qvpd8FQw8uKCKH1T+VhDhIcRx6BcLtb6JICA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0NTp5ucX;
	arc=none smtp.remote-ip=209.85.221.50
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5DC2606A334
	for <iommu@lists.linux.dev>; Mon, 16 Nov 2026 21:27:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C5DC2606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0NTp5ucX
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-48e20ed3b9dso4246218f8f.2
        for <iommu@lists.linux.dev>; Mon, 16 Nov 2026 13:27:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794864450; x=1795469250; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UNI0IawohcjDnjoicCHviRRe2GFEz6OyLASUQR+3Ovw=;
        b=0NTp5ucXBhXc9yLfeVPCOzGMoNeE+rPYbrmrY0xSdqAWwbhmwHQg+lm0PGYC9qy70U
         URFRF/KfVUA8RPa3i2M4w2GsZe0y19hiKmN7wy7jko3U5DkNRKPNE/uLv+ajQVcI76YU
         2Hlw25aMN84wHTgCSV+GhTn1a5+Te5AqTk9lfz1oT+DZNY9/u2RGwkzmrh3Bg+0vO7xG
         jfGRHJnp2ky6VxhWRb/k75tO5yFI5ORdRCstCrbhiWpjFeP/4hZfEOebaMg9+35zknNJ
         yWCX8wDHdzo4KPP/pSt0ye6WfSBbQVu1DZVTnfDTW5q63ixmimteojqghWbU/xP/knyM
         AwbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794864450; x=1795469250;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UNI0IawohcjDnjoicCHviRRe2GFEz6OyLASUQR+3Ovw=;
        b=VVkUnUXp+SlMWkpzaqyphUgl6+pDrqmw7QUPFvk+0kXDOFvs+TMKfS1AEXTvRJibTl
         dIEKdEHYLO/3RcMA96SMaSRplVaUUHUfSLhXvMbEpmEUkyNbQFLIxWZkS8kpwXAeUomC
         7nTS5/mUfyV//50GGcz94esDuzZecuttMsH3SSP6BvJzZhNEum8OoZEl7NXslb4Lc0eX
         HHYBWtj9xs4DIpV9t2P/HcqSdMebw1favsh9Ovzhy2JuIRxnEQ7woQX2Jp0vOj6VbOz2
         /YjkHM4BXtlRpH0Mh3Yc46s4UoCU7ULcnl/NHLx93blLtMkuZmUaWDm0FThmSftFEFxf
         tMow==
X-Forwarded-Encrypted: i=1; AL+hErHHX+Qz2dhE9apqoz99+DPQgz2v+jUojqThE76gbVVCvZJ7z45hpPYRSfqEmTfuSgTnuJppYg==@lists.linux.dev
X-Gm-Message-State: APuU4Z/54AKGeW/RJJODoOpgax8F+WR50AbLyMLEhFrfnhDv5lSnikUt
	PleKnb8Xpxq0dlFcnBidcN4HuNDxpOxUoC19sI6pE+RqWHyzW2KdIrMi
X-Gm-Gg: AZFdTZe5DXUVO+bqdRVDDNAFneWV1aBgMb0rsWLLvfkPOukYSI/wLmpioiDoWCalnMW
	xrBTCXQT9WHMJ0Mzo2XuL0mUcqBKzi5NMFuc7qSAbj6XAo8hxmDLOE/eUVu1h4juDPWuUeHbY52
	aD99hjZGrCiO6KgnwVx/s1rA+ldTd/qVJNR9MWJ5zH73mALLysnAEUK9knPhJfnlYkkZGqg0hDW
	yD8ZzARrWZuQKOlwefv6q8d/aCcYP80J3TJim2YnbIrt9bn+u6xWHF6Vxf/Me4i68Y1jRpYCj9c
	5OWlSX6eWF5chAQi0aLfcNf5XqJjPHCwZsUwMW3uD1fQGVucRZ/Heok8UFJrNStPiyLshX9m8if
	8ey2W+/gZnzbiMIFcekESmk8pMLlmwyflUjlfQTzdsZjGlLVud75hwyZewPhdg1kaWv3UkUr0GV
	vWzUKII3RYlZ2uXadeLoGEAsxMm5SNx93JbK3bVyuevLKhDyHADhKaciEI34PaQJAj8UwtmP3Dr
	oHg2gN2tCxd1nBk2ArTLmykdB1181zT07Xw5MDF0pnfCazpAsKh/H0BQsM8IB3oMYKXUvMSywWa
	yC+o99PIvOUziO1XGUWlrswHUhBbY2xe+2Xe9HSY
X-Received: by 2002:a05:6000:1a8f:b0:4a3:8b21:51c1 with SMTP id ffacd0b85a97d-4a38b2152c6mr1214677f8f.53.1794864450317;
        Mon, 16 Nov 2026 13:27:30 -0800 (PST)
Received: from [192.168.10.105] ([212.58.121.92])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4a378138cfdsm1260150f8f.58.2026.11.16.13.27.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 13:27:29 -0800 (PST)
From: Stanislav Aleksandrov <lightofmysoul@gmail.com>
Date: Mon, 16 Nov 2026 21:26:25 +0000
Subject: [PATCH v2 09/16] dt-bindings: crypto: qcom,inline-crypto-engine:
 Add Halliday
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
Message-Id: <20261116-halliday-dts-v2-9-2c92438c6c46@gmail.com>
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
 linux-pm@vger.kernel.org, Stanislav Aleksandrov <lightofmysoul@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794864382; l=921;
 i=lightofmysoul@gmail.com; s=20261108; h=from:subject:message-id;
 bh=LNBr+b73CKCaJq+Lcoy2dBwwEKE3EuPIoRzvD97HKJ8=;
 b=Oo5JC5eiOukaaqszf2JD96qfK1gjo4Z88L7lhFkJnmKZtf8EiRQqPApokWBgoFrRDRq84oEys
 dN0aV0Wol0LDOOw0PtPKsKDeYZp8RCTw6bkJAf6hQZCCV8VanxNS3ZJ
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

