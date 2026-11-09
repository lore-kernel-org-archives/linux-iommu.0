Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794184461;
	b=HwEEoBFVShZgvCb7+0Vgl50ZwvkuXjIfl8PU0zmAiwzAdaOxydFh7m1OuMCspzveChT+
	 1TJErLV8cG1mixMg5PGMW8U/jN6oXU+RRJCZzawwX3YtDLjFBCtwsjqAXJjWnOAxmKmKU
	 GvYliJgj3OgQFpsPjKLGp3q+XhGDdAgKzbaWF2KRAI8k8eag2pSYTPoPR/AntT30vEl53
	 LrN0ub7+JHkZY73MvE9FIP/pItyiSwxbmKnS/9Xue9TxzV07B4rh1vBUoyhoe3HRtH0dU
	 e+M5Vz0a34UMT/+z1mR3G0HSRmSRoTkkKupYD3b/EEgBSFbVB/kX91qb9nqiQ8nKaig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794184461;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=w98VdCA9EtnwfzZZ4SHf5Gk3YVXSBdJ/uT/O1NuBZJI=;
	b=bP5G3uZi41YwyQo/T4kb4kGXiVuE3fcUMbuGvXQX3nYj8eqB/psM4hiIBAEkq16IQM+C
	 eJQSWFVX/BPLBWZEEP4BFvYp4ICIWRtTFIYlb73bpYhplWyOUQCck40GVjw561/kuuKzb
	 YRVEHwmPQ8E7egd3qNTbT1P//m7vSFgonBvpewQMV9VUmdOClgTO1xsInkW+nfIl7e25E
	 skk22mkZ5fugnrhEKKIQinY9+YL3MAp5nXraEh3JYyYNf8MEavGYnOLpMB+ARmhqA04OQ
	 U6fnU0US2P8R1T+oNnyGp01OGR548+0ZIa7BHiVM67v9DW/ehhE2f5y2eS0F6E/0vVw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=moNWhKiw;
	arc=none smtp.remote-ip=209.85.221.47
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9D27606EEB1
	for <iommu@lists.linux.dev>; Mon,  9 Nov 2026 00:34:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D9D27606EEB1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=moNWhKiw
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-4910b863b84so218851f8f.0
        for <iommu@lists.linux.dev>; Sun, 08 Nov 2026 16:34:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794184459; x=1794789259; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=w98VdCA9EtnwfzZZ4SHf5Gk3YVXSBdJ/uT/O1NuBZJI=;
        b=moNWhKiwqhXacD4sp8Ce1qMeeZuh5/9AoLOvk63g2UpAKW7sMQVpeS5lc+atnaHzet
         FPi1JA0xl2fu739HoksfQQI/5WL0NTNeWMA0Y5dGy+z3VpsWcO+0O4wZ6MhUYmxzA369
         xv86PyHSMB2PD3AMT1B5x8RScDcKQm27zgBmmJRaHrOU16ssdaeexod2oTZB1dUPv0FH
         Ti0BCrQy15LbrwOR+Eh/8JojZ6DS9rSPeJ71NqvMH1CZ/+Tv+KxrtxflSLpvyMtlbJy9
         amo/jcl36uhMoVDI6nZORPa7Y9Oki4l8rBG4neh1kIflEZdZj0V3Twt7dYCFQw6pYD4q
         9ExA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794184459; x=1794789259;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=w98VdCA9EtnwfzZZ4SHf5Gk3YVXSBdJ/uT/O1NuBZJI=;
        b=1MrG1ltEXXky1pp8wggzh7ywlxQ9bOesJ2D0IqDf8qGSyy7HC0aXZbyL11/al4KKR0
         qwr0UYXnACWI6qj7cohWTjn79ha9cKyz71vpGyzQHDgvFBdzjVfk2brI9xFtU1PGzTMB
         IFXngf5KRNmhc0jr/aDRN6gZ8tOGik99thVhlVVSIpj/wWmp3QshmirkfWTW3uSe5q64
         ilB9dnkxeI4KIBhZO2r2L1OUHvSHoFDiqKXviFX0IkYS/y3JuFyRxqgMKj8fol/pKXyA
         bRRt+fnmHgpaujtrh3ePoCawXUowpij1tUJOPG6d+8Y4sgYpb0kpzehe57RE8Jg4fu68
         dQTw==
X-Forwarded-Encrypted: i=1; AL+hErF4eY867/52SE5zVfkULUHPCVVC4SGoX42WDwEkBwzg8cRtsYcP9kNiRA1oUrCsFXkCU5H1lQ==@lists.linux.dev
X-Gm-Message-State: APuU4Z8AKF8Y+kp+H6rZJZTLofTPfg8Say51V6luBNnSH6pzsCPfH0iT
	wZ/TY6/tjtiP7QkiIEV0po79TwrJ/QhDf//e+J12Yhg953N9a7MFmcbj
X-Gm-Gg: AYBFou2MiZQsTh6vG+W9zNkiaN+wXocrdsQIWnxine23jOz9Lure1hRH+e2W9HclWW0
	SZ8BMh3Q7aDMWsAS5rEfpqL9+jKchBETIigL0aU0ywqfCpqad0/nI6+BoMq8KxtopIMM90PwgNo
	RPdzexsRHk6/Iu9C/rI1Ve9qPSXX19rE5Wl1kaZLAmpLWxHPlXuhPghrASGUJ6ZiPvh30goaBg+
	qg5rrU+hPEy277nW+yebYtoV8K72l0fXi6yLOJfZzDjeYZCOshj0ICqSjxMmuepaAif/GT6xTAY
	rSNasRy3QVZKJL6DvJZiQ32zHcNOEE/l6EqsIata5KstQ/tolrg5fmxBu//doPFm3C0fWHA+jfP
	F5hxJ28e0Qg87mq4TJG9GQxuqAabWQJAA51sI2kJGyyrVABSvZRjDx+L+YcVFRSyGsTgA1K+E1/
	E7bR2LkTt6frxZozUWr0kF9cjeeO8EruxmyIzUqaJfn1FYzrPW4QdMo/LP2JsVE3aYznXIxeE6v
	934kgT6HSYRUe9zLD1HagqYyPrsJpeBx/AjAlAGugflij3CRgKCMWDhvLthVYVQw/iEtzLbHi1Y
	0wCVHWn5xDmWFz5MHgcLUbELeXPXmylW79dTum3H
X-Received: by 2002:a05:6000:2511:b0:48e:d7c:4bc3 with SMTP id ffacd0b85a97d-494248ee013mr10847131f8f.21.1794184459219;
        Sun, 08 Nov 2026 16:34:19 -0800 (PST)
Received: from [192.168.10.105] ([212.58.121.92])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49592f39c8asm6541675f8f.7.2026.11.08.16.34.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 16:34:17 -0800 (PST)
From: Stanislav Aleksandrov <lightofmysoul@gmail.com>
Date: Mon, 09 Nov 2026 00:33:22 +0000
Subject: [PATCH 10/17] dt-bindings: phy: qcom,sc8280xp-qmp-ufs-phy: Add
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
Message-Id: <20261109-halliday-dts-v1-10-289114ab8197@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794184395; l=993;
 i=lightofmysoul@gmail.com; s=20261108; h=from:subject:message-id;
 bh=Os3dtyGi4Umq8bQ7AEz34h0NK9e+Ws6GY42XJz6qujA=;
 b=whHNXCMkWBlbyRe6Xqxsfmk8vbhGS1Ie1Ck2sCxfwGhqRMBxKE4lbZ1T0XWovH16DltXzjMRT
 ok60qvi/6qNA6DJ9tcvRYuZUzSKXMRRZZv1H2XgMMF2zBm+cXxEQ/SB
X-Developer-Key: i=lightofmysoul@gmail.com; a=ed25519;
 pk=jeRUlfmkhE53CJPoeIIXgu7rTE0ybDRH0HQrEwbydzg=

Document the QMP UFS PHY on the Qualcomm Halliday SoC, which is
compatible with the SM8450 one.

Signed-off-by: Stanislav Aleksandrov <lightofmysoul@gmail.com>
---
 Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-ufs-phy.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-ufs-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-ufs-phy.yaml
index 10435a0b5230..a42bba9b550d 100644
--- a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-ufs-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-ufs-phy.yaml
@@ -28,6 +28,10 @@ properties:
           - enum:
               - qcom,qcs615-qmp-ufs-phy
           - const: qcom,sm6115-qmp-ufs-phy
+      - items:
+          - enum:
+              - qcom,halliday-qmp-ufs-phy
+          - const: qcom,sm8450-qmp-ufs-phy
       - items:
           - enum:
               - qcom,x1e80100-qmp-ufs-phy

-- 
2.55.0

