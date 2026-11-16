Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794864441;
	b=Prs9FZy1AtNkoJmVHRrQX7TLCUEz6ylK4RoPF0UXLzZ9jeoMPnvG3qTt+q/tBJhDkXcW
	 1neNSq19fVi3vykj30oY+ggHxGRJmaxtsDmsrO0zYFW3aPBd61xA+/W6sEvboov5ETQUS
	 FTCGU2NKkZEIpsMRRVP+bZewVJ0Nb/CO/eOkLYlXmuNZjXn3PIDx43y3NAYH6P/aljYKf
	 eG/rssitqiokh5MGVzvmvZDNfprMdfRtda3Kr8DqhHYl6JajXYvWGcMPmO4C0HN+mgsxv
	 pbrpq2YC0XKzNdAU75YZHF7VIku0TIHk9/55t4oYPIexFUDONmzwReFWzFsfqcIpPqw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794864441;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=w98VdCA9EtnwfzZZ4SHf5Gk3YVXSBdJ/uT/O1NuBZJI=;
	b=sse19oCb3WDBCt6gaDVcKUOk5tJQCiQE3zg+LriemDwIGZWh6bSZuWGagdBYEjsO9Sh2
	 pJgc6zggv6YpbcxRSzQ5E+mcXL2/noQvilamTlP2phdIW8zQxCoYDtotGR3qbVMSCfs/m
	 0QKAGnkM5eBl9SAXNt4DU6+qwLD62hj2XMO2QeJAlxDTGF5+vs5r2tngXNFPx9L84s9lX
	 qOj+8WnLwygonYAaifZNSlmtHvzvoJCcXiDyqXjhR1270tWjIs2ZSBGg6arC8D4l7DyvB
	 BZsQ/R0axZuUCz+MAiN+tm2/BMDQEVwL6J0B1RD0ky2qGOrh1x/N69XxYbM37KTpGKQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ulfunO6S;
	arc=none smtp.remote-ip=209.85.128.51
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E063B606A331
	for <iommu@lists.linux.dev>; Mon, 16 Nov 2026 21:27:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E063B606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ulfunO6S
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4bb6ba3b244so15980905e9.3
        for <iommu@lists.linux.dev>; Mon, 16 Nov 2026 13:27:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794864439; x=1795469239; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=w98VdCA9EtnwfzZZ4SHf5Gk3YVXSBdJ/uT/O1NuBZJI=;
        b=ulfunO6SoQNiSEA/+MU6dZfsBsbTjXbHSTQc+srGKsNzRvVM86xWxD7nR8FAEmCurl
         w/j2NcdRyDXQ0QUuLnqlvPs9doQbTZB0OhGchoWCmAyiw4BunBBGTNB4CRyKbab7FLBl
         LZhh0NJYyzxRZPbk1CXLs0c5XeLg7SK7UCEtpuNpQ+ccLLKPxhpIb13odOGZdfrEVZqu
         Srd8zbP726v0nFVvQdmWp1CUMh0RdvEeBL3bJXvJcX956QeIRYb3ciriM7VJ9iPNWd6R
         t7Gkb8DnpSfBaWVjK6aFqSsOkAqiuW135sm6cWt9cHXeqS+NKd6dr9N6u0usnEUPCgwq
         Vr6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794864439; x=1795469239;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=w98VdCA9EtnwfzZZ4SHf5Gk3YVXSBdJ/uT/O1NuBZJI=;
        b=VUFDYvVs6WZktK/GT/FrzL3WfxVQKCRLbVLv/Zj/R7V1AqZ7LM3dmpTHrHp2/y8zi/
         Gx5gsde1ZCE7zZXb2lLK5L55Mwv3K3ERtKU7PP/uZwLZHjqgGGq/l/psc0fiX6P5DvCQ
         gScZXQeI4fFwva1hEVKVWD6XLjRNCEeebYa/HkKnWMm/tsVk+DH8J4shTkCf/Vozll+3
         u+nvmX8kZr2GETcUX5feJNvhuhfra1Sng4pFc+skvQ0Psf7HfJjAJkJpiNYawKvQVYnk
         SQ8jyPqO2QfPz+2volqFkkJ0JhwvTCBZ+3EOeNyVSIwNC8HP6RD4Y7mJuMBFJpQ25dM9
         an7w==
X-Forwarded-Encrypted: i=1; AL+hErFS4+IUhRS//n9rtnAA2WYjmQo1P4PCSxDpRfsrTEyA1ipJBrngH6J3KuI8npqJNlu7V9YupA==@lists.linux.dev
X-Gm-Message-State: APuU4Z//CYL1oP+Mbr1pfhyHVdi56fqopDF4oPKX3ywtLIAmcTKeS6OZ
	6Gd3BYBDmSdxJWGqZuK0eK8kNl8S3xLvz7RqqI30IHtjwtgXntWVj64L
X-Gm-Gg: AYBFou3uvZJr/OwHlEHzb4aV565KDbc87ft5/KEiCrDamPvT2Jp31+5uJzoF8CV7U0z
	pUbFA5+YabgAOEdVNlNP3I0u84/QxUIUE9OBa2TsFIGA2RsCqL/FWT//gVwOi5Mp92u97unoOwu
	OiqDhOm7hjYpWkzyPVOosilDu8BIdS5iWEE0x/6wF/xb382JA4lAP6IvF/dqzLq3kGLwz2GGSQ5
	Y2vMHztDJBfJwKCCYNtIQjSalEZAfQ3b3SybeZFH4Xh1hl2hZxr7Q1zDhmUkX7bcXcL9fH9Kp2Y
	wy0CHuQq+O7axoedQn/coEB1ziCWYYCDAgxarLZdxEJlW/2UVAFiqqu+gQHQQoyTzqUP5IP8TAI
	uWRL97jimne/wBQ3SMyb01YEK0Iy9C3eAGqfmX+GgovPJ2fizmTxMG70NWUcRAxzbp2/NS9+PIV
	dfOun/hIm+I9SkrO0U9zrDQYk+qc83lcwWH8xOiJFD7QYkmuRWxQIryUxWkk44t6QV9S5UAiZyN
	2/S3TaBio4uKRz43oPyeUnYtPYa/86L2MPHIfzKU1330OTj9Hud2SMGCI/sV6QPOmCtiugFjlkT
	f/mAX3JXNQUgQXuIrTJzFoSfgd4yKncDP7iQ+hDu
X-Received: by 2002:a05:600c:3487:b0:4a2:526b:d410 with SMTP id 5b1f17b1804b1-4bb55a4f1b4mr255653315e9.13.1794864439353;
        Mon, 16 Nov 2026 13:27:19 -0800 (PST)
Received: from [192.168.10.105] ([212.58.121.92])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4a378138cfdsm1260150f8f.58.2026.11.16.13.27.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 13:27:18 -0800 (PST)
From: Stanislav Aleksandrov <lightofmysoul@gmail.com>
Date: Mon, 16 Nov 2026 21:26:23 +0000
Subject: [PATCH v2 07/16] dt-bindings: phy: qcom,sc8280xp-qmp-ufs-phy: Add
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
Message-Id: <20261116-halliday-dts-v2-7-2c92438c6c46@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794864382; l=993;
 i=lightofmysoul@gmail.com; s=20261108; h=from:subject:message-id;
 bh=Os3dtyGi4Umq8bQ7AEz34h0NK9e+Ws6GY42XJz6qujA=;
 b=JAnPagjMpge0X10XiR/LbxFcl9vIwvXlY8rdMR3b7TnG2zjS5Ef/3pOUFBSYZcopY2HJ+t+/s
 qtEtnXV/IW3BvhWLgk5yEo8YJikc5cpwNQrDqesXNsRHoPh2k6l5Th3
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

