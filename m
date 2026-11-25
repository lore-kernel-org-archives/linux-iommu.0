Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795578260;
	b=znO7Q+SWOV2HmVgh1V5ZvdBZ1V08RAPKwmRpc+tqRDmEY8/zbu4y/kWp/tuFSl00eVsz
	 79M2dkbHvqJMKInaQ40IfqPQFM1JndRfkVyeyY2O0+9F5y6yTh132aJHigQ6k6KJjQeZ4
	 S0HzrMvvh0cZyFgcsLFFuVhNGCU8xaTuIMfaNFNjbcAqZkgx5KPM+uHyHqjmdwoxyxJuQ
	 DT125rKC5nkdcjMF2AoBZj3HnDy+SQVxIn6vqmRAP/ihru9PY5hRhKbZpnoNtJvmm8w8d
	 eDpWIw5EfFIwEi02NZkGdHqv3cvT60ayWnnPKdnTxkl/pUFqDUAiAJEgiIZBzjM+6kQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795578260;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=W2b0VXMdCxwEqSCTP3OlO/X4AxL36r2Zoj510JVt9mk=;
	b=ZOLmkwhxyzsMS1Aec3YQa4rBaf5J+Rm04w1wuRUpm9qPLQzr5MfftDZ336KZibdgnSjP
	 dsz1+uxTuLj5Y8SElShFOatGFrq6fDtEyDkBbClJBTjZAWMoWC70gvujRc1MGRlxJb1Or
	 vShVa+DDzJpsJWSaBTPfgv2ty0XXrehdrw6SikSYANqtQl+GHTr3pWbkjmcJhhgQcIRgR
	 9NCF4vnUD5jG/Pu3UygB39oR4ZDOOLfHcKJhNEdt2/MQC2VyGJKwIQ40gD1RrIi+2EFSf
	 4h576Oxxm8mXlaMadYMNPOPJFJFhCoUi0h7TuLDOpXoGRM1kAwUADEij9ju6jsLLxFA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lAStlfOF;
	arc=none smtp.remote-ip=209.85.128.46
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34B7E606A332
	for <iommu@lists.linux.dev>; Wed, 25 Nov 2026 03:44:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 34B7E606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lAStlfOF
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4ba013938d7so48473825e9.2
        for <iommu@lists.linux.dev>; Tue, 24 Nov 2026 19:44:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795578259; x=1796183059; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=W2b0VXMdCxwEqSCTP3OlO/X4AxL36r2Zoj510JVt9mk=;
        b=lAStlfOFqVVc79BPht2sB1GRuDW9asd0EcIy6SONEPEaYMN2vXip5ElnvGo+x2oNce
         Iudi0gknpG+ODAl//LRIAp6R8JB1LVIpMwhKzeJGsJF0uZU1WrxSt89iRFL+4lJGTOjT
         xBb8ULbSHpwiGG7pBsMUDRT/zlef6BplV8j4qBtCqN5Uqxdz0Ye27/VyxvP6N9CSZMqX
         Cd7WeOQQ4Gw0TEKlQgHoTnsobfIGUNV4vofVobeHWC5kJdMdxbDeaUpDqMDDAZwglbmJ
         al89/i+NeHu7Nc2KccFqrgbkDHawojXap6IHw8wwa8DFj2aKU3ksUYTevJXrgMFTo9ML
         1Kkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795578259; x=1796183059;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=W2b0VXMdCxwEqSCTP3OlO/X4AxL36r2Zoj510JVt9mk=;
        b=j4Nfp9wX3SLEDQqEPnSvAS+Xf1F93+CbswlA8LFsPqRrizFML8217Ee6iKOwJ+ojfj
         74ZaDNijBaCszAcJGDKebtJIiYcpzINYwYRQCVSc269jEQj4DkU6a4MRwFKfarmvWHO9
         2STzHN56aJAamJS/GH1tDOk6oGV/v6SWRD1R0yaxyorGTNcn0dt8Fs5Ma/iXj90hPkXu
         JQE0K2oGlAEhJ2qJUWwCouxsXQSZ6zYPVnFmLUuivaQ0Qr435YBL0P99vxMha46GZXA+
         fmL0AdEu5+fGcC1h+lLPTUQ6XFcY//WJPhSeXj4QSWm8AsjzIVLRUXWm/HCAdLwYEEKC
         U+kA==
X-Forwarded-Encrypted: i=1; AL+hErE3lS0ybHBa2ZFD83yXeVcGuURwvHlF8kyMsWPyNrTGXoK54Y7/md0/sh0xGCia93uHey75Ew==@lists.linux.dev
X-Gm-Message-State: APuU4Z/pkETGs+9ELrjR34YZcSmVXkMGjVpko9vPWdjMGi0KYZDVWozp
	EKn4zJP15X74lqda4ehvQsnGKtQhEXksXIcgMVfO0hF+0NcwaXWPuQUQ
X-Gm-Gg: AZFdTZfz7B1OilepXGRAeRpyqAH2EGmjbYaKVuTeJDKJTwj/bWAOhtybxhv0L2yffdC
	fyVORXwtIFJLADEmhKDUBsJtMS3WfJ8HKsxJOtSN/NOEIdaflmPv4cHiOYtzEnTTVO0RsoZkU95
	SDHUEU0Zx9UyXX7Wvvi9vo3GqjnCOJICiTKMmfMcRqkvi2kZPcFIdjBScpjhgMdpchKSgOgjX+g
	2hOgL4xrKZB65LRflskCRGbA07apH3XHz9DBe4wi4B8f3LoLfasWzWNO3lwSolaeQOznpPNduAO
	8xfrF7jF9bSwj/39nF9DGb38bIiGVA78m7wUwzr14njpRmCe17+ubtdj3ItOa0x/VqndYBto2co
	ihxo2h+BKA9HwE/Y6E3/XsnL+BeAa5sVNwr9wRqJUT6Of+66j1vP4hxh3zYFwih9QR/gUaoKJY/
	IyIerO9N3w2xTQPsHycOpYi4s34/LdM+R40HTnt2qi65MecuQkuSbP6ioEgcgF7MPvdyyCoo10K
	HVfHUi9NReUm5B3R34pFWwPSzdbnf8ojpq2Xouefz0BRFYOu9nnCJ2QC9vNNfci5hBHrLON+WGV
	cIcdR7ZI/fU/yJSTpcihUY7PuGWIGdGEXpICGA==
X-Received: by 2002:a05:600c:b85:b0:4a1:f720:74cd with SMTP id 5b1f17b1804b1-4bb8892ca5amr333720795e9.24.1795578258707;
        Tue, 24 Nov 2026 19:44:18 -0800 (PST)
Received: from [10.32.31.239] ([212.58.121.92])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb88402ce9sm391107925e9.0.2026.11.24.19.44.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 19:44:18 -0800 (PST)
From: Stanislav Aleksandrov <lightofmysoul@gmail.com>
Date: Wed, 25 Nov 2026 03:43:05 +0000
Subject: [PATCH v3 09/14] dt-bindings: thermal: qcom-tsens: Document the
 Halliday Temperature Sensor
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
Message-Id: <20261125-halliday-dts-v3-9-5c8311c0b70b@gmail.com>
References: <20261125-halliday-dts-v3-0-5c8311c0b70b@gmail.com>
In-Reply-To: <20261125-halliday-dts-v3-0-5c8311c0b70b@gmail.com>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Robert Marko <robimarko@gmail.com>, 
 Guru Das Srinagesh <linux@gurudas.dev>, Thomas Gleixner <tglx@kernel.org>, 
 Radu Rendec <radu@rendec.net>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>, "Joerg Roedel (AMD)" <joro@8bytes.org>, 
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
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 iommu@lists.linux.dev, linux-usb@vger.kernel.org, 
 linux-phy@lists.infradead.org, linux-scsi@vger.kernel.org, 
 linux-crypto@vger.kernel.org, linux-pm@vger.kernel.org, 
 Stanislav Aleksandrov <lightofmysoul@gmail.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795578204; l=899;
 i=lightofmysoul@gmail.com; s=20261108; h=from:subject:message-id;
 bh=Gu7LEPVBsHDlbEA7f0+bCh3HrNIpvCrq8874bMnEMyI=;
 b=LwuvM0V2lFpMa4PY9K99qzfFeTZgXvTT9zRsWf5xnLCKTkxZox/BBQLcveRV+2SwtDIXcUnAz
 dTyT3erZvMTCCtObEN8DKkAXoSDLM9Igo6aZR3InSklVdITD6tCjFp8
X-Developer-Key: i=lightofmysoul@gmail.com; a=ed25519;
 pk=jeRUlfmkhE53CJPoeIIXgu7rTE0ybDRH0HQrEwbydzg=

Document the Temperature Sensor (TSENS) on the Qualcomm Halliday SoC.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Stanislav Aleksandrov <lightofmysoul@gmail.com>
---
 Documentation/devicetree/bindings/thermal/qcom-tsens.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
index c78074fbcecf..3b440f395fe8 100644
--- a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
+++ b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
@@ -57,6 +57,7 @@ properties:
           - enum:
               - qcom,eliza-tsens
               - qcom,glymur-tsens
+              - qcom,halliday-tsens
               - qcom,hawi-tsens
               - qcom,kaanapali-tsens
               - qcom,maili-tsens

-- 
2.55.0

