Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794184492;
	b=CK2fPBJ0NB08+ecqXuCRakj4IF0XXhj8gW8z8Ufi+6VMgQ1gTtsPSVj6URBLrJ7iMu83
	 CqnBSsPgfWbR/EZ2wfnqQXAAiqYu/KP8+kOnNpQz1nKbvQHmgA4yN6knasv/9iMo/lH7r
	 7I64Aj19vixhTUnq+1iZTB0E206Hp6/GS9CFOJKDBawJ4uTQP0G9Wfn3Ag0L60xjHSqbL
	 xXReHzqYcE7PoZA+FFqYxEiWhfB7v35vZVXaIw3a8imPcUoJtv3wRxz7r/oLBcXf+0gTc
	 q4iOf3MJUQjCldh1MtJ8kT+8n0+h+ECvkakIvwUU49V6TEdx8epSy2OzJdYKV8Egdtg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794184492;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=bqalaJtZ5/g9y9/6SBPqjpN1E4M1h8fqL8PuTjv/KSk=;
	b=lc7glplSL7qld0AhC72hsVoEYwMNYstnlu6a3cxxop0u3SccxLk2WeE0fn5a6gCU1P2z
	 sKS7OZtsFctRkgamNdFdcf9S2OsUjtj8cEXonwCiGapk6goG2xzDQ7VWlcirGr1McCE0M
	 Nh4CJbv5RqsRXP+jX5ACE3whLPPuhTslQbMd00xqGO607GLBPMdnxjPx0MTZqArK6ptDS
	 VgMiqKRGckyNDSeTHNLWhK4kBT7FlzPVB0dUpNWx5g+/jVQ+qgTjw6JeHV80nwMAaXENO
	 pL8eEsJu8Hno7uzVMt3EnGVRpLDefA5lb5s7l0aim2kyXWnIDzC+0nQW8KbLzN9zPCA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=c+hjMSFA;
	arc=none smtp.remote-ip=209.85.128.50
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A317E60A263C
	for <iommu@lists.linux.dev>; Mon,  9 Nov 2026 00:34:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A317E60A263C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=c+hjMSFA
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4a549cd7fd2so2796505e9.0
        for <iommu@lists.linux.dev>; Sun, 08 Nov 2026 16:34:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794184490; x=1794789290; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bqalaJtZ5/g9y9/6SBPqjpN1E4M1h8fqL8PuTjv/KSk=;
        b=c+hjMSFAhoNVH0t9UNJ7JY0Rq6oYBP1/A776brQSm1Uls8wQjj+FZwYXJniJ4eCyxZ
         ejoFgD1/ZCXMefrdOHtcDa8WednXL4OOzM9QhmDL2Aofyts5ONkdcrdLgerna2vp422+
         4Hqw+zN8RG1xkkTKIzhwgfr+pIIQNtWu+ke8wCH+csmTL7AtW2ytIveqWV/Y+kaqAEOk
         aqskx0QX36J/I4h/VS3U6y0rhwkmK4aYNszWGVSRI5o4YE5aK7SG1V0uC98VUwByQ+se
         KPyb9llIiprsy6f+427c3LAa8ZPzwz7mrugVltEwNPz3kwHHQSECk18juR9DOCri7+aj
         A87Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794184490; x=1794789290;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bqalaJtZ5/g9y9/6SBPqjpN1E4M1h8fqL8PuTjv/KSk=;
        b=AfeSiuqHiiL3xtk+1lvrLVn0duFoYooLI23Zyqdzu7pUdJEYaOdDDRS7jbQCiQfJae
         0WICoDe/+6zq+KpYZZm9Pqdg06Ib/SY1EJ/uJGkMvu9cHrvyekCFDuapInq/Ptzk1kM0
         nrHGs7DiTOz8GW5Y/TIue2qRU1UhkTW1sp6kOP31QNlagx0BxxI6iuASJzR1uUSUpQRO
         ZCRjwRkGU8qZzQ9OumHmFQ1+tt9KdebI7nnj5j8hra+IdYgSwD+9u9FFWKM0M6RT5GXk
         /9MhHSLDKWVB72chiTBxAbHr7j5ChO6JIgZBdOAmAM1wlsmskfAlL0QsPoxZMEyCsK+w
         pj5w==
X-Forwarded-Encrypted: i=1; AL+hErFn0zYAKcQbW2P0IbmU7Z9BjUd1l6vuChF78DE8GgIqWBP2WSY6giqFfXZaLnRNR/zfFrTJ2A==@lists.linux.dev
X-Gm-Message-State: APuU4Z9iOdCjK+PP9kSyO4zbA4W/EvwGt6eldXLJWZ0oVnFtTWIp1IqQ
	OmVFn4Jaf2/pT0jsqeyB8OYS/ok4dK0mPCNfTtUXUKHGdzfymTpyqmEl
X-Gm-Gg: AYBFou0eX+EoOwo+uzDEd5UFmKjsGJ9yq4R/VTKbowiPdzQwkd0y/0wI9RHrDqS7HHP
	hDM6KNpbS+vr6Qo8G1O7oxabJPxanTVaZih829ELB6AQCkTVk5Tef1j4gprCxDFOEfXP23uEvUp
	bdImsVMR/27HpkOAHqIrteMI1bLY9yT5fJ5lk8skusLpKuMxkRitMVbIG+Alfsk28DmQH578thx
	udwi2OdDSlRUh2us7fp/sLvP3RVhYW9qRiRQh1/wo8XZMqR3m/3ckelKYVo87kddMfcQkgrPq4y
	ks/WuPik5dpSx4xXr1m7jZ/lW42TcVCKC/NnR1s2nT+MzRC/tWiry1UlSbHejC3T/C60yhG9Nfz
	KDyULm1Or8z+1etDxeiXJKDdoDImnnNCZbeZM7wamdqD+ccddsRJwxr/ZNPHm7rMkk9bJAUhHu0
	Jmqzq/Ix8+uRHd9XwozNZoDx5J9C/Wo/j78KMpXbEIa/8qDZyp8aGiS/P/qUZdOoOOcwcT58KXI
	m8QWBruEuvZScwE44zHDt9pGzkcleq1+tSD9EkWB/H0FEZ5Qus0mmxjTNtjtwlH/HP/7n4ypwvu
	/NLbAqWkYP437Bff/zV2ZvThniQSJHYN2ZF0ih0t
X-Received: by 2002:a05:600c:6218:b0:4a2:1002:223e with SMTP id 5b1f17b1804b1-4b8205955e1mr111833455e9.7.1794184490117;
        Sun, 08 Nov 2026 16:34:50 -0800 (PST)
Received: from [192.168.10.105] ([212.58.121.92])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49592f39c8asm6541675f8f.7.2026.11.08.16.34.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 16:34:49 -0800 (PST)
From: Stanislav Aleksandrov <lightofmysoul@gmail.com>
Date: Mon, 09 Nov 2026 00:33:27 +0000
Subject: [PATCH 15/17] dt-bindings: arm: qcom: Add Samsung Galaxy XR
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
Message-Id: <20261109-halliday-dts-v1-15-289114ab8197@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794184395; l=822;
 i=lightofmysoul@gmail.com; s=20261108; h=from:subject:message-id;
 bh=GR/L35KkjRTQHIwoej6N0ZVQiPJDeokJdA0dH1/xcVk=;
 b=+pMC0hU92qIlScFgbvyLG0yeciXJR70jYMcQsgbMkAruvtq441EcqoAR24w8+H8PddfDvxdW7
 NeEMu0FiaHdAmbbpArcsFtCmr29OynUnIXhIC1Struq0XQSLzW/yMcu
X-Developer-Key: i=lightofmysoul@gmail.com; a=ed25519;
 pk=jeRUlfmkhE53CJPoeIIXgu7rTE0ybDRH0HQrEwbydzg=

Document the Samsung Galaxy XR headset, which is based on the Qualcomm
Halliday SoC (SXR2250P).

Signed-off-by: Stanislav Aleksandrov <lightofmysoul@gmail.com>
---
 Documentation/devicetree/bindings/arm/qcom.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index 121ca557ce1e..b96ee339956d 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -94,6 +94,11 @@ properties:
               - qcom,glymur-qcb
           - const: qcom,glymur
 
+      - items:
+          - enum:
+              - samsung,xrvst2
+          - const: qcom,halliday
+
       - items:
           - enum:
               - 8dev,jalapeno

-- 
2.55.0

