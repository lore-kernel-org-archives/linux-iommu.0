Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1703E2EF283
	for <iommu@lists.linux.dev>; Wed, 25 Jun 2025 09:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750843411; cv=none; b=p+00w6/gtQPmu7tFIAYIcCu4DL8nEQH3ZerK8+hNR3GSrVQHLIPNVMh5yXxgOvlZFIxd4mvIMAwNXokIYI93AhHB1PvFp3nD3q1bf/hue0lW64lD4qoJL1GEK5eYpzH9cVZx0ACL2GAzq6qEkO4iQFAVWQVpzLHB1kUOjve/Itw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750843411; c=relaxed/simple;
	bh=jj4FXpnaY2L8qRW5W5/06pfPaCeBVQY5CbMDnnBtNOA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Iu8hxnpJo11vFoq8T0rM0lNJB0EeJw9Cu0vVX9fkzUCdsDn2Yak0OWOVWsSVjToi86L14PpZh8fbbLYHggOYrSstwZNpw52TJJ1Rfoz2BQUb2eibYJHwcnpzG01uDPydQxTDml7fTeBNXHcM5c7dilEAwzsPT/EQFuoBA+Z6460=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=O39k4Le2; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="O39k4Le2"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-adb2bb25105so1004408066b.0
        for <iommu@lists.linux.dev>; Wed, 25 Jun 2025 02:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1750843400; x=1751448200; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PueVIxrY0Lhx5OoYalpVzj7TJ+cyHwt+DTi/ni2FBMg=;
        b=O39k4Le2yB5a1HY5hgzBXe15ZPfO92/GCP9sTWfPZ+tNC+X32xt7hP11dYWirH0J6Y
         cnpyKw6+1+Q8AzpIGhoBqDkK1wA4wL2nYS9aZ617zHLweK2yWNeHEB6i43qLRsda1KkW
         z6Jg61ad7a61A1LRQb3t0ipqQztUG9GO7jkZfv6qVni/rmWu4XAqXlMYZPekT3cnuIq/
         k/4+0lCajdDKf2fMZi73laUemb/zRyq8fbIF13fHxdrqET4wuZLdAevPesa8OiCWal/o
         4Umnlzj51izajCpLujmUy8p201gRH1zr4ZYmJXABCHp5cifkQBnocngTQWQC3sMqRlIE
         4uCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750843400; x=1751448200;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PueVIxrY0Lhx5OoYalpVzj7TJ+cyHwt+DTi/ni2FBMg=;
        b=mZBOc2VtQvB+0Ip9lXShirapf1pRxf1Gs6i4IhXtsLwQ7fb+AJ5gwCEOHmH5CMsgrg
         rhs9renR5iTycypOZYuXVI5yECeFZSd9jZlzUXCws4egEp7Ltz+gfwtbDAnk6PLI8WME
         ApTNEqOkO1bvenUUaUYotdElD98vtZyvSTtQDsp+VCoGoEaZeZa9IlRfOtmu2s3pvR2s
         lu3CFEHPudnMRhdsAjgijc9/wQ4hEWRQaTBU5UnGPG3nPmk+r1+I045K2CdKxNeq66nE
         hAA/0yQi6on+7D3f+MAB3OFRHUoHfZ/d8eKjVTwG3uHg367r0p3gYuOZ5R/kog190I0x
         /uvg==
X-Forwarded-Encrypted: i=1; AJvYcCUA5gmPIHIq2B7FV+/T/LlxImS4Z9NYGLcw529h7dACuqn8rmt6yLrTf39BtcqP0n0FeaqxCg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxvdCyycsNGGPoAdQLgAmWFBucPth8KmgcHzrvo/RjhZeSkaDwq
	bjRTLOHOpjgajXBNnrK+A8gtg3aE5jIiZfikuYkDkp8qsZFcF8EzUsSnIzgd1DMJlYI=
X-Gm-Gg: ASbGncvkgvi/dPWLX6HKM8vSwHcksbT2eS0NQp9dYt04cvxhSbLIve/G5fmzU5VCzP9
	Sjtrp5AzPCZDFOTdpNt5QQRwlYLIcmJ//1blCcCq14yR+EgltqI1HN0W/6MkzJkD30nBJvXERLq
	g8VF8SXFNW8/OSHMRTwPjdev5NrgL4jZRkT4zBNj7MLYgmrD/ViJKm5tyzYCSU4qxrg5jztvQmd
	3yc01ruKvQdAmh7XoC1BJnsb3hJ5ZM1SKeVoaEosaqLVh4Arrkjrg7la3Sw0zV9peQHEGPkGG4Y
	9P6HbIyWhsDKLxg+DdYqBuT23E5Q5ndx7e3//VfM4NO4NrDX07fR/r70dm6T+9u0twW7DzJ4330
	9CLpLieWkXQQq07DFLEWh2sDlbe9cpwGI
X-Google-Smtp-Source: AGHT+IFufR/i6s8bQEjNP+fAneYyap2WFk8eT5JzaxB2nRH9U0X06huQYHvxc1UIF4P5JtCVtPmAUw==
X-Received: by 2002:a17:906:6a12:b0:ad8:8529:4f77 with SMTP id a640c23a62f3a-ae0bea790d5mr233626966b.38.1750843400340;
        Wed, 25 Jun 2025 02:23:20 -0700 (PDT)
Received: from otso.local (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae0aaa0a854sm270277766b.68.2025.06.25.02.23.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 02:23:19 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Wed, 25 Jun 2025 11:23:06 +0200
Subject: [PATCH 11/14] dt-bindings: soc: qcom: qcom,pmic-glink: document
 SM7635 compatible
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250625-sm7635-fp6-initial-v1-11-d9cd322eac1b@fairphone.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1750843387; l=920;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=jj4FXpnaY2L8qRW5W5/06pfPaCeBVQY5CbMDnnBtNOA=;
 b=QKOjYfcAGy5ZXnCmFyoCw5qgS3UKBJcYTNOrXIfiYw6DV7itFoCGZHGaadZiBNtQHiCfzjhFV
 Na8qSuO8OQ1DyaQjIxXMBvzPUgOVhYUCHVfApprHUM0Cz5utU9EaZ19
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=

Document the SM7635 compatible used to describe the pmic glink on this
platform.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 Documentation/devicetree/bindings/soc/qcom/qcom,pmic-glink.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,pmic-glink.yaml b/Documentation/devicetree/bindings/soc/qcom/qcom,pmic-glink.yaml
index 4c9e78f29523e3d77aacb4299f64ab96f9b1a831..2b77021b278dd9dca604cf31e39d9eca98f2aa7d 100644
--- a/Documentation/devicetree/bindings/soc/qcom/qcom,pmic-glink.yaml
+++ b/Documentation/devicetree/bindings/soc/qcom/qcom,pmic-glink.yaml
@@ -37,6 +37,7 @@ properties:
           - const: qcom,pmic-glink
       - items:
           - enum:
+              - qcom,sm7635-pmic-glink
               - qcom,sm8650-pmic-glink
               - qcom,sm8750-pmic-glink
               - qcom,x1e80100-pmic-glink

-- 
2.50.0

