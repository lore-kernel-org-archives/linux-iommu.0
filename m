Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 009CC2E0B69
	for <iommu@lists.linux.dev>; Wed, 25 Jun 2025 09:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750843401; cv=none; b=a7ZXt+0CeIPmjOHE2omVX53+0nmR9ybY918pC0WKNSYG1iH8DRtUNnPXEPq6b3OdFpRHtjGHb2mCyHIUyDfq8WaiUKDvcqTBtC/J8/wNyof3MeucRXNeozauo1yqhoPvt6vgYz1gUo/51hj8VyeW0tR5QEs0Pd6GYybG0MyQmsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750843401; c=relaxed/simple;
	bh=a9FLQid58ZrqwhwDBssnIOsYiwypbHIyY+vO7BVtkJA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fcGfhQDQ64PaJD1JA5uEJGoKLpIeoAt2gBASKLdgDhKsu84SS4urR+9bMap8yWqqR7FViFY1mLhoY74K4Upld45PPxPstZOUlW14+B9mI4UeYd8le7aOV2+efYkVY68ZkdAoyYanyE8h0TccbZU3flIfH0s5WIV5EIxcekTUv7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=WsC0Cfzm; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="WsC0Cfzm"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-addda47ebeaso282522466b.1
        for <iommu@lists.linux.dev>; Wed, 25 Jun 2025 02:23:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1750843394; x=1751448194; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GFd2WA4jaSsi6eBpJft54R30VZiUHUNL0WjIOmacH+w=;
        b=WsC0CfzmbtGH4x+0/cf0SDOBKk6iqIhUzbrWi5lmFsD9GW//FdgMdrVlEZMevxTWHt
         O8bT2qYs8GgxGVKJJWJhAJIjE+YiXSFtmEt3H9wiWt5fiBidlJ5aoEcHKvbLfOvN2Zla
         hdLXbFj7SVPK25JZ3haDmOwPuM6/CXOsVBJwUGdHAmZfOJieGlzBcZrVMa+XEoAuesWT
         qyna5RrJYVkXUzXWKFQifaDVJ8cRC9wNPkZ4rOqlBAUm74lzyzhhXuTnb4HS3+TzZmxp
         Tm9ZQadXbzhN943gbNH8KdQixSG0VQ+2l3MbkeiTkBSVUrXbxOm4UwbmNt0IkeZLI38W
         YpVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750843394; x=1751448194;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GFd2WA4jaSsi6eBpJft54R30VZiUHUNL0WjIOmacH+w=;
        b=DlxCMeYIS0Hyv5ldU8fgZPOnmVBfvOWNw8y9IbH6tKgV/T3f6U2Xd7pkWVeqczawC2
         VXpHGj+PSmBzbdiEUFemz6fxvuFvaRrvVwb5tKOODfk2XGtPv96qwJ++9l9YchUR4w3x
         tKuSgywM70DZw89eJPaJiKL7nH1tJrdYhUkgo9jZPa7VKESNZJ2gLLEDIOIZwH9q51Cj
         0Idsw4jJqpWcaxXi76uhYCimMcn75NM+flhZRThVLb7k2+Z82e84U2I8+YMHQeUokovs
         y2zSo7SUcVRc8DBLm2/jhRkFY9W8wZe4R9EX5Zc+j0vH+8lbcZyUzkJa5W7JRh32dJ7P
         eR8Q==
X-Forwarded-Encrypted: i=1; AJvYcCW76hXsd7nX9rsc3nWzIF2pZKb64uChRDophkmScnEPrwcT/cWFIb32STeq2/MvtYhn3HuRyg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwVTK253M0byN8fuL3+xFmO8NUxLGhnlFOg7r2ZA154JXGm8LDI
	EMoeGl5GtLkQYX2CKwUztvBkgEmzE03TTx6sycFcrVflQHyYlni6OiC+CgFqxY6Y0bk=
X-Gm-Gg: ASbGncsSeIU8qWRhD9wqiBt4Yp81xnFfHiMgGn4mncpdYMgHBvmszUSYiuZ2ngoLnDV
	++ggzP68pSUpLjPlKyxvvnfEK1tRSZepVvek4A5FYqNPmfGB+mUk4P3BDjRSevQBBblR74eaJ+F
	OTcP6/6xRrs6pHvct8enQIhlvrxJ1zROYEX1Q9ZtHNZk3mY4svoC+UpOcRH3OvoB/zixYtY/naO
	eyS57k/THPeAubpkKINlB3ezi2qM6oBz0cDEK3i1bCH/m5AnE2grDX3/o6RUkswBJYrGmVoxWor
	ZR4Tm3CrmKVC8Egda3k9TFwXy/tSF0OybQ2kRPJYQx9usBs6uExsp+T3AYwbB4iDTYA0pEZ2qXM
	zCfpXSug3D15wIn+wiB37Mr8nlKq7RMwG
X-Google-Smtp-Source: AGHT+IFjoA9LH+UlMYELvwOrDva8TbPECUBoKhrTSDmX1S6yeylMCFiLfASmbkP/9St1GzH8r2022w==
X-Received: by 2002:a17:906:6a12:b0:ad4:f517:ca3 with SMTP id a640c23a62f3a-ae0be88335cmr241931166b.20.1750843394339;
        Wed, 25 Jun 2025 02:23:14 -0700 (PDT)
Received: from otso.local (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae0aaa0a854sm270277766b.68.2025.06.25.02.23.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 02:23:13 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Wed, 25 Jun 2025 11:23:01 +0200
Subject: [PATCH 06/14] dt-bindings: mailbox: qcom-ipcc: document the SM7635
 Inter-Processor Communication Controller
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250625-sm7635-fp6-initial-v1-6-d9cd322eac1b@fairphone.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1750843387; l=857;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=a9FLQid58ZrqwhwDBssnIOsYiwypbHIyY+vO7BVtkJA=;
 b=M++/VIb7y2T3gKskIlMpYOFvxwe+pfbHdhyU9gVdbfRegUxNj4iL+n141nUA1eMcP60CaNCwr
 IDMwEV8uYYeB8lGGvP/UKlrX7LWLDpIcdln/9pd8d17sYlzfKKWktV/
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=

Document the Inter-Processor Communication Controller on the SM7635 Platform.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 Documentation/devicetree/bindings/mailbox/qcom-ipcc.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mailbox/qcom-ipcc.yaml b/Documentation/devicetree/bindings/mailbox/qcom-ipcc.yaml
index f69c0ec5d19d3dd726a42d86f8a77433267fdf28..6e86ec36a82254ebd73c3067de495795c36c6bee 100644
--- a/Documentation/devicetree/bindings/mailbox/qcom-ipcc.yaml
+++ b/Documentation/devicetree/bindings/mailbox/qcom-ipcc.yaml
@@ -34,6 +34,7 @@ properties:
           - qcom,sdx75-ipcc
           - qcom,sm6350-ipcc
           - qcom,sm6375-ipcc
+          - qcom,sm7635-ipcc
           - qcom,sm8250-ipcc
           - qcom,sm8350-ipcc
           - qcom,sm8450-ipcc

-- 
2.50.0

