Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794864401;
	b=UKOgXvnOB6T7RYbcHErAlUpzb3etA0jntskYVJqp3eLALMqZziifV8siLz6El22fT5tX
	 xEYSiiY47VK6o8AST3EPrm86GaxcElqcaZ6p3H93+5WorGZBGXVVq532L/W1vS5MB+705
	 2QE2pVTUcXEiiBZr/iarALq2h/M2zQ4CIe4lY+Q/V8XdRp+l8J1Zc8NhJTpcjbd4fqcgy
	 zXRuGBaiC3wwWcN/V5o6S7q6SV8KtU7+HhIMazBEL3XZgGZ/DuEIYjMAYThJeFReZxBQa
	 HPDvdKg3eKoaO48eU4Cfwss19urFA4ReM/cowU41fFDDD6LoXi0/jOZa3ljrLU35cxQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794864401;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=drwleRdoQE3pkKiq8NvL3TA0ZreOLUUT7TR68lPFDhc=;
	b=jIGayYc35532jjAbIJWd7jkDZ5H7TwEor0pmwq41hF9CoiEc6JtYJbm6FAX6Jg5VG7QA
	 VzbBfwZU8ZSLpDRiWso7XadC6+sm61P9QxU3AU6x2GWgNfCK8+qR7dcfAV9cP6qmAM0Ft
	 LURTLBWo2tvdL19qVGf3iawIXcdNAMb6vIvp+dEtHM5aePwZ0B6iBoQlImxV0WC7R2Hxi
	 HW4Rl5dBRtYDi8PYAQXe7Ih1SAtUQQ8sC1CG1NEASFbJWtq1L1SEnCBNUDXPnXmxMXrId
	 yHx8rFPyTq43S1H0II2yC6IJg27bGEJD6VaafDIPg//80cz1qivfWJo4nVzVtT3yG7g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LwAS9Utx;
	arc=none smtp.remote-ip=209.85.128.49
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2600606A337
	for <iommu@lists.linux.dev>; Mon, 16 Nov 2026 21:26:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A2600606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LwAS9Utx
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4bb64c99d2fso27226365e9.3
        for <iommu@lists.linux.dev>; Mon, 16 Nov 2026 13:26:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794864399; x=1795469199; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=drwleRdoQE3pkKiq8NvL3TA0ZreOLUUT7TR68lPFDhc=;
        b=LwAS9Utxr1JAjy9FVtB99u2prOHGcT6/jW1if9eH5xMDyYRk3FOe/yMNPzvp4793n7
         ve+ZcFFCuzcis42chcju/A50hHU4/x1JsgWWAumKh7LlABY5hZZH95Ov7WgCg5sa7QGu
         1HIu9dvy9CpX+t9hMj84Fy+/00jWXgwnDoSLHYGKpOoqqonPobxqqfTv5YJm5rkpVL2o
         1Nh87uNGF+0h/w+gH0gI5o2kQ3f0YBJXI8ruFIjv5h9dYaOnwuE6QmbES14c50llBbAP
         i9vAF9r4KdNbhhzlGJNVApE9dn7yBsVm+kbp5boUCYBgJB/FojkfeXNeM4n9/dRPQki7
         D0lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794864399; x=1795469199;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=drwleRdoQE3pkKiq8NvL3TA0ZreOLUUT7TR68lPFDhc=;
        b=gR6/B/OXim0LjbSD64IeVugVAecEPivl+l9DyOIanUhCotI56ITdfLd5Z6/4W1j/yC
         APzThIIdk4NmCn15fBvNBZ8nXUAvpWe3PbCg170iciBh2Ucj3uCwEr1mwvcFheMlcdKZ
         iBGQktMK+/Bbv43NfeCgQRahMEH/jpmi+oNEaZPRu52RrivXuV3Gn2xueRJ0KNNnvzjn
         55mI9l6YnnYDaI/K/q1cDMdE9U+fmfL7PG7AbUI3o7n34RA5a/ct/u0mVBkD1FDm59f1
         jcjKuBunRoMHqd185HTOwl7/QgrToIoPsn0YMKm7eFGpx5KasKKRDT/VHJPXhDa/P9Qi
         +rrw==
X-Forwarded-Encrypted: i=1; AL+hErEy+7G7VP4QVDANaMw9zcAmRrDEGTeSOQdA3vjetgEEweP3mW5VzYv6SiEOxnkgDgOc1J19og==@lists.linux.dev
X-Gm-Message-State: APuU4Z+84n6i+Pju4rdHcLVNq/Tdk/RBuxPDn/3QSBVhCkmnegsCoDgS
	kequ/hUB8AR7iTjaas4lu8aB9jv5o1TgTwedkH+Gd+iNaZ3KapKylvqX
X-Gm-Gg: AYBFou28Wl6yY2sElhnvG4mZZe2Xx54rtus1E4kzirF9RZnxOB+eey6RRR32cYBkpuQ
	QBvNYhTmbdbBBBMq+IulroqrQ3+yVhEXcfS6MuVhusB0slvp8nMOVlqPKiLSAXDImiJt3ueW35b
	qNuaH+v6NZ6TkRDCI0uoxM6uShai6NsINBGxnqASFrqSBfbMIMfBL/DFbOhU4MiWcztXnngUVig
	RoqZn0ogT6knNYQoVKctjh6mPUwp2G5Jyi+VV4Ja1OBkJ0GgRgkZncGnBkxHJF8W5/z5++c8OEC
	MDoEBhOotEdKXzGRfPNbRxei5hyGnrcKaSoV57/4e1HKZd6+HNJ6Nx9deHD+wNVpjv0rVf8TG2I
	K+r/pvOojXj86/oTbohs2FiQhCDl1ZgvtRqLelJckmxfKlWBOyuL9ophoFYUwRq7+F/KxuhkmUJ
	HFl4k2Huhbx+c/oisyNraiZdhq+nuh4QF5Lr4kOX3Sy8KaljoPD/ehz4aTF75JGapqa6+D3gUot
	N7PL+ilUqf43QjIGiqxFfYnQ2YuSvMNLRIPXFra8wYJkHDAJK+MTbCBdESp8tZ5S97sENfGKujZ
	0Kc3AgZR7CbnugRwo8eB2vhDKBUDq7fdMYhdFOh6
X-Received: by 2002:a05:600c:3509:b0:4b4:262b:88a2 with SMTP id 5b1f17b1804b1-4bb559f3633mr229913355e9.1.1794864399079;
        Mon, 16 Nov 2026 13:26:39 -0800 (PST)
Received: from [192.168.10.105] ([212.58.121.92])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4a378138cfdsm1260150f8f.58.2026.11.16.13.26.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 13:26:38 -0800 (PST)
From: Stanislav Aleksandrov <lightofmysoul@gmail.com>
Date: Mon, 16 Nov 2026 21:26:17 +0000
Subject: [PATCH v2 01/16] dt-bindings: interrupt-controller: qcom,pdc:
 Document Halliday PDC
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
Message-Id: <20261116-halliday-dts-v2-1-2c92438c6c46@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794864382; l=910;
 i=lightofmysoul@gmail.com; s=20261108; h=from:subject:message-id;
 bh=TIEe9N/cyAzKgpuoZBtDZhrBfZnBIMsVZBId/jMf7sU=;
 b=dpF7p0w+OJpIxiGvX34+YlsXwN/di/jZgfYFaXfY2LGvx7anrS9naa9DX6XaW0R3KAm0CLz0p
 0yoxibSkrgQC5/lkQjgDmvTXyvnDrKaMbIZimtpZ/81OcVIj7o3EQjp
X-Developer-Key: i=lightofmysoul@gmail.com; a=ed25519;
 pk=jeRUlfmkhE53CJPoeIIXgu7rTE0ybDRH0HQrEwbydzg=

Document the Power Domain Controller on the Qualcomm Halliday SoC.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Stanislav Aleksandrov <lightofmysoul@gmail.com>
---
 Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.yaml b/Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.yaml
index 8401d3b48e0f..cf20041e86c8 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.yaml
@@ -28,6 +28,7 @@ properties:
       - enum:
           - qcom,eliza-pdc
           - qcom,glymur-pdc
+          - qcom,halliday-pdc
           - qcom,hawi-pdc
           - qcom,kaanapali-pdc
           - qcom,kuno-pdc

-- 
2.55.0

