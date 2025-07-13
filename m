Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D651C1F91C7
	for <iommu@lists.linux.dev>; Sun, 13 Jul 2025 08:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752394049; cv=none; b=MLeyL+UbMwYZrwJq9Lf3rCYETpy4QdO4f59nFInwz/tRk2yVrImyFLY1DbDqC3MJXHCfbEpVld9IuCK3nl8sTkrGaQC7s4ixmMtsQfOfymjBo+1h1oZA7hvAGwgkyLGSq7JMOAOq00LHF89qAnjVm5TcXcb7HyyhmMRNwrLFJtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752394049; c=relaxed/simple;
	bh=cmEjmUIEwJdszNuha6SGlHW2o0fXW5xz6+LSWPvZsgg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NSuAkQPPGGBEHDEdT/YABzilPwghztrTLlZMiczP+oeX9+ZEtisECXimB80fVin+VcAl7iNMsKMzixaR4906hI3BFeQMqEMV65saqgCvqG84P1jfpUxk1NeEsMX8VUXIpy6H4pZCkX7Yu1iCgpO/Jl6EF0mzCYdTEJeDF90r1T8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=0wtUH989; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="0wtUH989"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4560cdf235cso3972165e9.1
        for <iommu@lists.linux.dev>; Sun, 13 Jul 2025 01:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1752394046; x=1752998846; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HAOuh0e5PjdM5Thiks9XcjQnZt1mrG00zqw/b7U8tlE=;
        b=0wtUH989Hr1As/dZsyP8ZGFtXtxhjT7mN43ymeB1f4C+G+biPb/LvIjgAyD5zHXUUU
         G4PgkVhQOiwD7gqbz6+mFjUQDt9Imd05nBKnENOhq309UTmlGlOi+njuPPLgXv3+9avc
         gvCTkbul7Km+qkh52usONe6pinm0I5TdASEnEkpHtirNoStgSV/YikMZjPxgnzyY4c4i
         vd+6RCwZiv9iLDHq3FEAcue84NCgtnTKj5+3r7GiFwnB5zkyI6Kl7c8WD78YSQC74ciJ
         syD9Cg3+D3AlUMCzXi66ew6Z6kRCiLMYWmn+/hMKHvjyTf3NNyfe/aB2MTYIOl5041f4
         QiJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752394046; x=1752998846;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HAOuh0e5PjdM5Thiks9XcjQnZt1mrG00zqw/b7U8tlE=;
        b=gOQEqTq/Tu1ThBilJJ3esSfhRLe8NKg8SIe5fsUF83rWAydk2NPjZ3HkXPaYNa1z9o
         ButT347391LxYXTTLo3QvAbsMOEcygV0H07mudn0rUb2pL7IeTI6us2+UYUoI/4oGbRu
         cqSuMYYh4maETNG5B5XdqRjgh6M6jAMttlEfd/0HWbS5h+kPt5ilWZbeqt39Yt9tN+EW
         yRhIrF+FlzdBkBCduy0RI5+rJBAv+UGRj36tyOyS2GMtXd/MIoBAzT3CZ3UA0rq2SkE4
         KRvll+LpH6lUmM/b7CDOxkQMJ4h31T11jrG0ugnzE/piXxst5muSyP+AstECtpyYc8Jq
         Vnwg==
X-Forwarded-Encrypted: i=1; AJvYcCUIhWYhcyok+LtehE3fKafbjux5+SEEiuA3YR4iMVnoHRkd/obnxuT65YlO10BkXbyVU5yaDg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyNeXSFka23MKmZdaUqNItmYYT8N0Q1IyDSIjW/8tmWC+n/iDpN
	dhXXUfjBlZzikGPanl8XeRKknn5YKyYrDPpGihuHSvdQZcjG14l7BT22re6OZ/mORCI=
X-Gm-Gg: ASbGncuKDK6v5nJOD/CfFDPmArwUCRmwsrmigY54sI59YvcwYoCbj7TNRCPXFPfJBAa
	ggs9Xu6p3qKq92PU9aogB8B/jYMeo9WSl5mzxUYTwuzv8nH7chxtOwi90XgDKcGBJE98Q5N3Nlr
	jAwWrSwpsOMFHFB2rOmPV3fS3onuQTr4SDlzglEy+i6Mk345Cmz/cdZLJX5pgnTasaRkjcYig5P
	fXV7tvGSdKXZGMVR/6XrE2NERKVFKXRqQcWtHwg307qrFhw0oVjwgKsQwaMO3ikHWOvupiCXu39
	B0epefWiffNYcvPrPNcCjXGJpGtJtsnxLPSR3xovzrEoBrPcMvr9g9Zv/SAayoD12HzIM1u2OzQ
	Lw7yB1Dj8X5cWxrGHdtEoYJ7gmPx/BOgXT4TH
X-Google-Smtp-Source: AGHT+IHNat+zEG/luHBNIINd5V8v6XlcBVNxebQV2Q9VeRLv4kxzRp8ULT+stMytttEuuhYWEbWuVw==
X-Received: by 2002:a05:6000:2086:b0:3a5:67d5:a400 with SMTP id ffacd0b85a97d-3b5f18b3eaemr8361545f8f.33.1752394046075;
        Sun, 13 Jul 2025 01:07:26 -0700 (PDT)
Received: from [192.168.224.50] ([213.208.155.167])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8dc22a8sm9386608f8f.34.2025.07.13.01.07.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Jul 2025 01:07:25 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Sun, 13 Jul 2025 10:05:31 +0200
Subject: [PATCH v2 09/15] dt-bindings: dma: qcom,gpi: document the Milos
 GPI DMA Engine
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250713-sm7635-fp6-initial-v2-9-e8f9a789505b@fairphone.com>
References: <20250713-sm7635-fp6-initial-v2-0-e8f9a789505b@fairphone.com>
In-Reply-To: <20250713-sm7635-fp6-initial-v2-0-e8f9a789505b@fairphone.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752393945; l=809;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=cmEjmUIEwJdszNuha6SGlHW2o0fXW5xz6+LSWPvZsgg=;
 b=PdARDzzFMZy7Ut6DdJtISA7htSoj0AT2jFnSpJ6mCPR7xKdPfXUdr9NJCuHBaBjbgQNs+Hcav
 9Qi/8P7T+qNBz/thYmFy0Bn74Jp3O9N12GTa6rI4xDYY/rk8g6EpebR
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=

Document the GPI DMA Engine on the Milos SoC.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 Documentation/devicetree/bindings/dma/qcom,gpi.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/dma/qcom,gpi.yaml b/Documentation/devicetree/bindings/dma/qcom,gpi.yaml
index 7052468b15c87430bb98fd10bc972cbe6307a866..1655f21a4f64c588851c48381a18965c946e2df0 100644
--- a/Documentation/devicetree/bindings/dma/qcom,gpi.yaml
+++ b/Documentation/devicetree/bindings/dma/qcom,gpi.yaml
@@ -24,6 +24,7 @@ properties:
           - qcom,sm6350-gpi-dma
       - items:
           - enum:
+              - qcom,milos-gpi-dma
               - qcom,qcm2290-gpi-dma
               - qcom,qcs8300-gpi-dma
               - qcom,qdu1000-gpi-dma

-- 
2.50.1

