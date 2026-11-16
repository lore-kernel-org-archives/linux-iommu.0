Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794864465;
	b=sT/57eTNMCSqyG6uGfAJrrt3/k7CeKr9DyqkCPQI4EdSOkIeSQ5fHR7eDuQJo0C5kw/R
	 pzSVDEp7xdNXYgsGpkvzMum6PW/XobeJ130f1VAIcjtiuKKMOukch2GtCDEiS5bcWqOyf
	 K3CllO7juKNylJPVmA9pJ8oDxn3NxWhjHokgaOy6qNdxeBdzq6O8GbcQHYj9tjmwnkRQU
	 RxTVd7e3ZhM2ejXrdPCsP0LGRpkzvrCMRVOmfLKp4wxBGDz//1UtB4gdLIfZbYGWKACFZ
	 A3Ry6cVAAV1daDaJ93tOPF4aZZrX3Z4TRby0IksJyXXSshfp0tjytVA+0vwCfs1JePQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794864465;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=+ZKraDRr1i3pFiLzoYIEWaHhHBRYyhj/gKsvyx4GUpo=;
	b=GYANA4wGKRZZvQcPXMlG6Xf2MzQ+4LfmQDHf1obuQGE8zTmM2/HfhHvnysf/0A6hOTFl
	 aTLAi7/yH+CqpvqVtF/302oaGQRLd2a/WZKunBWpUjBZlbOgRvpK068PMrkD6ocPglaZO
	 N7oBxuDyK3XUjngQT5x/rol95aqPrw5FB/OOMk7zPNjnlcIw6BBLKxWXFC5VSsUwl8pR9
	 8TApm80iY6OkjsVqAvkP/z/BocKC2AN2jaSJ1HsG8VRMP7nb819EjglXx1SreH2AKoSUh
	 ZTqLDebFbKQeiTPhPJWJIVWZ09db1yhsMCmftRARAGVmIEW1JqbckAHjwcM6lYSvugw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LzfNjXbV;
	arc=none smtp.remote-ip=209.85.221.46
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B124606A329
	for <iommu@lists.linux.dev>; Mon, 16 Nov 2026 21:27:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3B124606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LzfNjXbV
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-49412eb1474so2016070f8f.3
        for <iommu@lists.linux.dev>; Mon, 16 Nov 2026 13:27:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794864463; x=1795469263; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+ZKraDRr1i3pFiLzoYIEWaHhHBRYyhj/gKsvyx4GUpo=;
        b=LzfNjXbVJeiFNn/MvG1ijUm146bvj8LsEZN+fpkx2Mc7T5FND8BeT/HHc4/HiJNY8M
         E2BgC5TUF14dR27zm/A8jgXDgSO6T4fuh9vugRyVAaY3+9zG4QTB5jHAqQ13qs0VDa4D
         nfRQIG8Y9auGhp2hmPwyDVGDrymjpwjPR8dYNSANG0JK1qP4xc704TqhnYtMTno2sCa2
         Yq/89mLdncG2hf88euKTbCt95LVMKR/1iuN0gwZurBwqMpH7p+01vBhXyGR+wgb3E3Hl
         iGzyS4bx4GzcOONVsV0U2t5TPlUZh8xm4TMsd8XfkluEeqJ8qGtHDoAjYHW5sjvbs9VI
         8iBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794864463; x=1795469263;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+ZKraDRr1i3pFiLzoYIEWaHhHBRYyhj/gKsvyx4GUpo=;
        b=k+AnzePOWxE85v2u1JEj3A8PtidzXCpWn1/MCmdR1MzJA73X0IHvlMbrVRaGXJLAhF
         OOOEF0stJuAxgfov8cUYGxPOGGcQkViTWx0CUFifH+yBQYaLjhd+DrfnBip2sCeN4bPD
         iumxrYkb2dllvw516dc1xOqRZm7tZheGBmq/LWMA9fX7c2WXGz6JgV7lBockzEfzfhVi
         SP8B6FK/S1rLunce1ji03/dynkpEk6kVQ/yKBCh2AxNPa9iqs920onLgto2Ax5OgpE6m
         Mv77oGn95RCM7iKD3ikTCr1EIisF4C2yQGeOx9S/umQCDS8fDj2gL6D/r2nM5jkH6rfV
         b29w==
X-Forwarded-Encrypted: i=1; AL+hErGgSw1y/43KmXZT+2Cp7velUqDRTpa1k+0+9IF+HXyvlQaIXxP0KrqgwsdCBwHi4EZBtQ8nHg==@lists.linux.dev
X-Gm-Message-State: APuU4Z/4/ZabbiSWQACzI1EsB6z7+rJH3rrJRXwFd1ShxeZIAJDbgWQZ
	54NK1KYluhExhU5HOr1tMQLza2EGWfeKvFsA7lGnAWe/35szkzt5mW8Q
X-Gm-Gg: AZFdTZeujdgL5umbDBQ07SqQf/DJJBZM/8+Pv4sRXpHqfA0RKegiED7KFoAOQIV/Esa
	a7oeWV7oLO4ykglA4EsfA8Ub2eTj7ynb+IHXabgbCRD9CDAv61QWiW4UxxcfWJYEj2gzEV/FfxI
	QZrqqCDvakOifpEeBOx8splRWG5HMXIMELlPapFGM332042v6g5+SGILJXe9ITepRk/Yy1FSKb9
	WRbUL38XiL6sihsuiqxX2W25SX6gV0E0zFtmqc9LgtdsMw47Ak7LgcjvPG19E7VUsCeg1WNlWOc
	defVcmxYRj9fI7/A8Gskrf8sM/JdkmTEVju1DRiGW6SjbSSr8CQqkjaKah40xVC6R/go46zgnJa
	vfiWhf3Xxikn5cLkPdRcqapRYSUhvehU1yGaV4uU4TZGm4EF666YVCKKPLG+Bl1oKK6fuJlZJLd
	1+4IzSBedDBQE0lejLMl6THDDXTmiq1kCBhxXze+XndKijIo8zdQbGNOxIWxSsgNLYRHWPKRHat
	fBZowoWa25NjYFyofqJCi71nyStjkVLzEVtOeAmFvCZF/G8yYu+M7vbypgzpQPHfQ+R/EoZD4aA
	aBgCp0xab7alglczQWhiJRiF+N6O+Ik/qZdaI1fW
X-Received: by 2002:a05:6000:438a:b0:491:36b3:22c with SMTP id ffacd0b85a97d-49c6e68dc41mr30686056f8f.1.1794864462819;
        Mon, 16 Nov 2026 13:27:42 -0800 (PST)
Received: from [192.168.10.105] ([212.58.121.92])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4a378138cfdsm1260150f8f.58.2026.11.16.13.27.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 13:27:41 -0800 (PST)
From: Stanislav Aleksandrov <lightofmysoul@gmail.com>
Date: Mon, 16 Nov 2026 21:26:27 +0000
Subject: [PATCH v2 11/16] dt-bindings: firmware: qcom,scm: Document
 Halliday SCM
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
Message-Id: <20261116-halliday-dts-v2-11-2c92438c6c46@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794864382; l=1106;
 i=lightofmysoul@gmail.com; s=20261108; h=from:subject:message-id;
 bh=OQO+LwEeY64jVYcmV4r5bBUUpcSQt6/n4JPVT4Z/sxw=;
 b=lNijzEKQlyljkWzaxIS9zrys8uC5qiwJ2YpuyG3Kr+5tC+QMb+R4Db6kOwLBwj0GYnOv/QX+7
 5U/HlbRtrBQBhLGehnhSLzxDVWEhcpke2OLw7yIeYTlC6a6mrQFU5kI
X-Developer-Key: i=lightofmysoul@gmail.com; a=ed25519;
 pk=jeRUlfmkhE53CJPoeIIXgu7rTE0ybDRH0HQrEwbydzg=

Document the SCM on the Qualcomm Halliday SoC.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Stanislav Aleksandrov <lightofmysoul@gmail.com>
---
 Documentation/devicetree/bindings/firmware/qcom,scm.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/firmware/qcom,scm.yaml b/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
index 40a267c54b00..fb3da66443ed 100644
--- a/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
+++ b/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
@@ -25,6 +25,7 @@ properties:
           - qcom,scm-apq8084
           - qcom,scm-eliza
           - qcom,scm-glymur
+          - qcom,scm-halliday
           - qcom,scm-hawi
           - qcom,scm-ipq4019
           - qcom,scm-ipq5018
@@ -225,6 +226,7 @@ allOf:
             contains:
               enum:
                 - qcom,scm-eliza
+                - qcom,scm-halliday
                 - qcom,scm-hawi
                 - qcom,scm-kaanapali
                 - qcom,scm-maili

-- 
2.55.0

