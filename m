Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70FCC2DECDB
	for <iommu@lists.linux.dev>; Wed, 25 Jun 2025 09:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750843393; cv=none; b=sNv5dvWhUxsQhjKnFHbBuzNL7+GBBPDQnwWR99fw8+iByUhMQwsl6ux9lWYT4mko+IZZWaFI79zKRvtpJSJlaDV4pNjVUibTyqWvSTs+21Ht4fCHg09+o+epP3zwdmz+jZLWGo4uNTUQhxHujXj6MuRWsdWivZy5PTSF+E4yr10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750843393; c=relaxed/simple;
	bh=eQWT5rynZ1PMaMurlFu0xtL6k2P+7npo9dOzB+6rBOg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PGJuf/rID9u1qvFQlcurNjB4FFx7am1L0nkd16jVOJl/qKqR64f85E4nPL+UqGorCYyi1o6FHGGDLBY/6i661ytK+yqLYp0+pi51r+OuIqPcWA7/ocFgOmV/igxYAT5fVOQrs88mQppDYxLsMuDvvfNCMvSoEagHRj3Y8N4s15Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=dp2DFmL3; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="dp2DFmL3"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-ade5b8aab41so1284608066b.0
        for <iommu@lists.linux.dev>; Wed, 25 Jun 2025 02:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1750843389; x=1751448189; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DgqZI7oI1+Rtsh8AHih668v9LL7u8KNYlhdavj5r3Pw=;
        b=dp2DFmL3xh1jnmJh4uF+/2LY13OcBuok4JjEVY1AapStMci4xYXBBS1/l0qTGOfSEZ
         M6m/Gz5sx6hCE4zPQDBNVNhWZAOuGhagGMOZp0lQsgCQJxkTI1bi4cdytlBvfS9D3Jfa
         U4IAesPapNKMY0NZn9kF4FYwo/XGlzUFwsQZbjQy2tH2dZmIAHswThIwN0MG4O/1cK0q
         nW1wZIzqslGFkO7XFUjmvt54kiVPVcHfL6LcIPzrFumUl6f9lTKfYgb8cZQIHMvawoa8
         qos8Mr3Hywxv1l9daEqHS7HPKnA0r090ZJ51gz6ZEXRbJ1jtkI+wn/WUZgYFO4e32HyP
         jT7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750843389; x=1751448189;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DgqZI7oI1+Rtsh8AHih668v9LL7u8KNYlhdavj5r3Pw=;
        b=bybf7vV+MBSLpYTYEuiCmjNBwVH/71/Y9xc5SpmJatGBgQcDqNrK9ZC5WdPJC0/wms
         vSjne6FXhAwY2HpU5WWz2Q2VYmySUxrlA5IPA7Yq8AKG45Pshq3JrMHcq8tcYauvSAdP
         K2+1+WkNRsnJ8nLaRswd/RPOVOMDEuluFOjgVrk1U2g8cn/tGZ3HrYRYP+Td/WnmpMaX
         7KvhCMiTjYpG6CvHWdrPwZqdGM4RPmM5wAoBw9DziE0KdnCqWgvIPHw6KgbZqVfQL+Qx
         pB1jpveBo3UOk1Vjk2rPAZnphobn6rqZHMpd9q7vtHamLxWmXcxhiuDbYJy/cbTHkBF+
         os2w==
X-Forwarded-Encrypted: i=1; AJvYcCUuI7qXkq/9T59j35Nub2GQTRQhP2gvI3d/abr6fgepHlZ4s4Gt2o7LZf3n5nkRROrzFNNJkQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywz1IdQrpyi20Nqnf/MeLYS6VJ3uuQBAFy76jCewcJtL3M5zukv
	mHipwU67ceXQXGlpS2/IaHazcUC86QOF3m1KMrvpgdA3D2IlHXnoI7TWZA1yjVats1U=
X-Gm-Gg: ASbGncsRRTfM1TLP74dtIFZFts0WS7WdAdNJ1meXgrFoGUeAElSsy37Qf94Ma83Eluj
	iCPMHP11/wDXOeUcZ6Mu/IwX9naralX5XLwt+4b+aZ42X2C8D4b1o6o19ij8e38q15MOeySn5iF
	L72QoWzMMFZ298r98NFGcnAYV1YeSYLS+W2qJHUYgEm2lVe1k+24+pn+COYuB4fpgU4I80t67el
	hxcYBrEaadrpccLdja92cqSs44Cf8BYlRrshk+GaxCgb6K4dmo3SWsRZ9v7COZ/AQifIl01kHFC
	N9aCPrXm4HGtiredfHJyIAjmZz9niTxKykCQBhaN0mOdQHw0gam0JUCpmPeLsEFLyJAiHQFg9Zu
	uBB2i47HJSJz9EMWs/4SsRUF4LAdbaCVF
X-Google-Smtp-Source: AGHT+IEbu2f/7cXyJsOb3QqXP0wh8TgrbA5ZDl76nci0eiAzw3s+R0MtL3pVIqORzpzq/cBkmMRAoQ==
X-Received: by 2002:a17:907:6088:b0:ae0:a597:2959 with SMTP id a640c23a62f3a-ae0bed8e8acmr247450866b.32.1750843389413;
        Wed, 25 Jun 2025 02:23:09 -0700 (PDT)
Received: from otso.local (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae0aaa0a854sm270277766b.68.2025.06.25.02.23.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 02:23:09 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Wed, 25 Jun 2025 11:22:56 +0200
Subject: [PATCH 01/14] dt-bindings: arm-smmu: document the support on
 SM7635
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250625-sm7635-fp6-initial-v1-1-d9cd322eac1b@fairphone.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1750843387; l=1465;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=eQWT5rynZ1PMaMurlFu0xtL6k2P+7npo9dOzB+6rBOg=;
 b=gDsmUgdZBFiEdwrYEbZ8pi64XslJKaJrZmQirkFpqMll05JV6aPCYeaepteR65EJtYCQZk9aa
 7x2FpL//Q9vClR/bmMVFhIADOJuoW9AUJVzbXxYdMo+K4lm7WiiCaKO
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=

Add compatible for smmu representing support on SM7635.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
index 7b9d5507d6ccd6b845a57eeae59fe80ba75cc652..8545dd8e886b265caa333188c031f19a44d7fa6b 100644
--- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
+++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
@@ -55,6 +55,7 @@ properties:
               - qcom,sm6125-smmu-500
               - qcom,sm6350-smmu-500
               - qcom,sm6375-smmu-500
+              - qcom,sm7635-smmu-500
               - qcom,sm8150-smmu-500
               - qcom,sm8250-smmu-500
               - qcom,sm8350-smmu-500
@@ -99,6 +100,7 @@ properties:
               - qcom,sc8280xp-smmu-500
               - qcom,sm6115-smmu-500
               - qcom,sm6125-smmu-500
+              - qcom,sm7635-smmu-500
               - qcom,sm8150-smmu-500
               - qcom,sm8250-smmu-500
               - qcom,sm8350-smmu-500
@@ -535,6 +537,7 @@ allOf:
           items:
             - enum:
                 - qcom,sar2130p-smmu-500
+                - qcom,sm7635-smmu-500
                 - qcom,sm8550-smmu-500
                 - qcom,sm8650-smmu-500
                 - qcom,x1e80100-smmu-500

-- 
2.50.0

