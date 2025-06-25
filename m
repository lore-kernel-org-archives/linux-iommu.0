Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDAB72E11D4
	for <iommu@lists.linux.dev>; Wed, 25 Jun 2025 09:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750843402; cv=none; b=Agp8hqS2Ip/IdveqVselKL4SoredRR/whjVUEMoaJNwcoH2NVe4JehtXLDpFKaKTRoo0Ni5EkKVmI34mEvyX4pAQjKA0Gu9idknhaIZoiOHGS66X1RunApliSTJhjUnAfeRGITlck1TBIFdp9NDr6Y9kePmUC0cLEQ74VczNkkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750843402; c=relaxed/simple;
	bh=QF6zOzPisaNRx6UkDEnfUjzHboUeRh3pRf3riJuZ07g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SnWVQAsTMhM0vK3V5ozwoLlNLKYx3oMgEQaBRktxvi8A/a/w7URTp0KppQkpa68zfEZ54kQO9JPzkQ9k3w66d1JfPcPZbzMZVIbIwbfxz6mgW/BBiEHtLKW31xO3TBDrrc1r8t6uAQjAb30ABIxxKIrQJMwsDWRDnYorJNp+E+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=CuNCx1WK; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="CuNCx1WK"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-604bff84741so2833740a12.2
        for <iommu@lists.linux.dev>; Wed, 25 Jun 2025 02:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1750843396; x=1751448196; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TKX5DuiO7AzJ1dwZVvAVxWI3Xdt99v9P0wOhJICwjbk=;
        b=CuNCx1WKYKom1FoSSs63UA+7TAwFCvqZUFfSmDjKX/HXdgatzRlFa05M83vY8bj2FW
         Dqm7wDPnt5OOJRwglnLsSBNcqsW48g1drr/6cDdUfOwnp+E4XAGDEw6pf2Z19roWjjXf
         +/tpIuyBSQ56HVhDprsRTSglWRZMVWVFpt2HBWveySMTXXxB7A2P0W2fbb5L5kpEH4EB
         8WKlXFc0cTJuPOvBxkWMs3e9gmwqkeo3x7vo8/cZAv58oDRDCEBR8JWXgvVGvomWSAjb
         8GzjRHKqVW3zOamBf2TTi3bjMzoHnbdBFGr30VhbPZ/zDs6Xol5fTHbHDayl2WpmZRVL
         3gkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750843396; x=1751448196;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TKX5DuiO7AzJ1dwZVvAVxWI3Xdt99v9P0wOhJICwjbk=;
        b=iVg4mxXxh58pRSEBasm5Ufe65nkvvilbfczKmigEqvnXphbdLRJ7nZLNX4DgNvixMm
         ReThTwbtrULFXnz3uJ7nd2EaEUUudbmca75jbY8qVn8jV+1+OVL0G6PN9cMLuyuTlUob
         haCKE1FgaK9chCUhKGT1JSwGVrnnsEpQ1nBspotKIqm2TMwY7EsecVRkuVP63WZrx0Ur
         jUWJ/tXB5cNjKPY/OLwYDFUDzOesFsEDWn87AWLiz8cDGRhYiOxPR+EHlsFn9hHqD4gn
         QQlUXAMegL7sf4ShKKA37jEK9PGSCV3lp66zme3js9/+DusGSA/xzmIqR9M/1v0itnEW
         J88w==
X-Forwarded-Encrypted: i=1; AJvYcCXKHLLMtnt8T6DU+rzNGOjORfufeGcN6THjkNZgBiAkNmlL8G8s6EPMM17dFX8usI0FCkkfzg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yze+2DyFf3yekgrenN8zQIW/rhJzMsLQRXqXCG/gruQk24LUm3E
	Uu/j2m0skuq/Af8lkzuj4IObwXXEgs8CEWyHvOQCQaPIIwOPki6Itezr0keZy2JGZYQ=
X-Gm-Gg: ASbGncsN2NOcRorS4a4NCbRm3+UyzWgRWEY6e4jaRCpnE+3uRrHmEy5Ga5CElvNJsur
	Z7QWbLR9eobfEb0Ece5MBdsKsGHM18sIdIjlaBiRZNxWYrLSBH/nB1kw+nY6FS4K+yrQI9RWLur
	De4YP4hnDrwrTiO9hRf6/tpMEd6X7N++P7XFuPzz1/RxuHnH6XYhcI8t9vQuGQ6Nw99pVi5Lojf
	86cfE/toBebrBW+H4yYsq5OvJSIXQEGdSuQnY+Gx1nH7Y1oowl346i6l4E671D5c9/6ANXtBFGs
	LiVm1rsYafKY484RLyFTNI6HFbL2ps8rTRwcpVgOGYD3pwV0On7qNH7pzLcvnOre3QkElmG5G5l
	xtRRAmaC8yRb7K+HRy8MIIV5wyesKDQbF6AIOqr9h3Fc=
X-Google-Smtp-Source: AGHT+IGiDFBoDucTPjUqqaMImeHSSI/9lZCbdCTgquH7Z0S3KEgQQwP7r3gJyT916kpPzaeBdGItbw==
X-Received: by 2002:a17:907:9808:b0:ae0:bf55:5c48 with SMTP id a640c23a62f3a-ae0bf55634bmr217592466b.7.1750843396185;
        Wed, 25 Jun 2025 02:23:16 -0700 (PDT)
Received: from otso.local (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae0aaa0a854sm270277766b.68.2025.06.25.02.23.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 02:23:15 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Wed, 25 Jun 2025 11:23:03 +0200
Subject: [PATCH 08/14] dt-bindings: thermal: qcom-tsens: document the
 SM7635 Temperature Sensor
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250625-sm7635-fp6-initial-v1-8-d9cd322eac1b@fairphone.com>
References: <20250625-sm7635-fp6-initial-v1-0-d9cd322eac1b@fairphone.com>
In-Reply-To: <20250625-sm7635-fp6-initial-v1-0-d9cd322eac1b@fairphone.com>
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
 Joerg Roedel <joro@8bytes.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, 
 Herbert Xu <herbert@gondor.apana.org.au>, 
 "David S. Miller" <davem@davemloft.net>, Vinod Koul <vkoul@kernel.org>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Robert Marko <robimarko@gmail.com>, 
 Das Srinagesh <quic_gurus@quicinc.com>, 
 Thomas Gleixner <tglx@linutronix.de>, Jassi Brar <jassisinghbrar@gmail.com>, 
 Amit Kucheria <amitk@kernel.org>, Thara Gopinath <thara.gopinath@gmail.com>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-crypto@vger.kernel.org, dmaengine@vger.kernel.org, 
 linux-mmc@vger.kernel.org, Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1750843387; l=884;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=QF6zOzPisaNRx6UkDEnfUjzHboUeRh3pRf3riJuZ07g=;
 b=u4p3k6p/2j42YHb4XwcyOL+Rq/CqQjib4+cSu01z968A3xXWkhEPGtNDUd9b2G12MuzVho+Uv
 4c01+k5CLJPAHJpvg+Bz4qlPQ4Hme44CNKKgFxwQ8y5DARbiLPoZmDF
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=

Document the Temperature Sensor (TSENS) on the SM7635 Platform.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 Documentation/devicetree/bindings/thermal/qcom-tsens.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
index 0e653bbe9884953b58c4d8569b8d096db47fd54f..76b3d4ab5a793a9bd675e52a348ca2d62077cf58 100644
--- a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
+++ b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
@@ -65,6 +65,7 @@ properties:
               - qcom,sm6115-tsens
               - qcom,sm6350-tsens
               - qcom,sm6375-tsens
+              - qcom,sm7635-tsens
               - qcom,sm8150-tsens
               - qcom,sm8250-tsens
               - qcom,sm8350-tsens

-- 
2.50.0

