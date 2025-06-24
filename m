Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9CEA27C16A
	for <iommu@lists.linux.dev>; Tue, 24 Jun 2025 12:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750767764; cv=none; b=kLmoMMqCfOLrPgrCQrtwD9/Sn040+Neq1NY/ZhzB9qkvjQFSYyO2criAeZw/qFQx8sTwEaSneiHsI1i+2MiVNBS614gc6ojuvTc9kCXGGt1rcmNBWkaehTEWB/swLC+2Jzqsetd5lQNCeLRohx2v/t3mQtdQCsssXNVKy/5SaXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750767764; c=relaxed/simple;
	bh=RvFdNy6eRq3jk+TGzSf8jssUcNniJlHcLRIQMwrb/Io=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=DtT63A/9nSeGmUBs1vPArIFKBT2CVmQa/831qEbWZNEK1n4tEJyRSBXUDTjfKc2PIa4BwYi/K7pTUl0er/shXbChDZhYIhXaYhSBiRheoLLgYtjGIVdpx254Qf37bbrBmKLpYBL+pjiYWwKDOQNz2BUUQ2Z8elfb8eUUwknjVWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hVv8TBvI; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hVv8TBvI"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-ae0b2ead3c6so5160966b.2
        for <iommu@lists.linux.dev>; Tue, 24 Jun 2025 05:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1750767761; x=1751372561; darn=lists.linux.dev;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GIOHrhTp/mewrh9i9oK1S98LI5rxY1dc4uYp1wgAtk8=;
        b=hVv8TBvIlOYZLsefvZ3dJkyj0GaMe+4C4UknWp2wA7rLcklxvtQyr9VLWWdFp94hG6
         aqJ0ejo38RGZDJ47m5VSp4WErvRZ1bftM3XhyK53kHg0P2oHvEBXxA8wdaFfSgUtxIkl
         ANqEcHVhXyW2emuinL5SjhkEBQTyP+Iqrart+P8ynAO7s1YTT8ratR185BKry6G9v9ij
         +bYjpTSXvGJh+mbNGtjiPoGZpQgUIr2kizqJJq44pAV8ga1aeQN8xknq+d4Bdz8+uqb1
         9N5i8+wG+J3X9PyYd4QMibnBsai0obDlnOKwRLf/SUdaffG7V8R6api/xiFKuEl517VQ
         30hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750767761; x=1751372561;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GIOHrhTp/mewrh9i9oK1S98LI5rxY1dc4uYp1wgAtk8=;
        b=nJRZdFV6Mefr0fYt1vfqDRg+598pnzz6iart5yH35OfzQ6zab5eBV3Wnpl9otlunVU
         kFge2TDWQKAaM4v5+DaEkd2lql8Cu2QV1F6K0ArMokVogzEbBNwNR5AQe4WKjGIf6BR2
         jfHVuIeCSaB1yXq8ieJ+OLVRLIB0oowoqrQueJZdPhP+ULfNb0OOzHUPbe5UXVe+ViTT
         TOH2ciB+G2aBKxpt4UxeGOpLFa3zyfWHsjuT8844Z4rH3aBXVnRHH+i7tAeN+zgb8jtJ
         UBlyDPXyv08LCfTSWRTwSTKR06+zc3KBBlf/vxqoSqV8MdfU+bnxJst7CO4SxI2koZZD
         Gnag==
X-Gm-Message-State: AOJu0Yy1RnNuyAf2spdKJWwFUxRhcaTGqjN+7wAAjaKElxnAq9Y00g60
	DltehzZZn0k9yMBQtPeOWKVCccThlw/XjZvbGqw/5pfkU4OWq4FN0r62bGcnXKhZd2o=
X-Gm-Gg: ASbGncsi8DpY3193DeheezU7zfB0C4iTgWJ02PzMyITeFg5aoc1/mid35mQoFmlndOe
	JY/U9OMacE6XGHLjmZKIXGgf2n3hKGqt63D36+zvguS37dDhnQvSANFOmlRkEFYV/GnqEIFJgF8
	PaeGJr2Y2KrPpk1Aza62RnfKe8g1+eU/ld/a+kfcphHuNd0UawBQNMDVAPUV/slxhqmGpYtfis5
	hp7nrPAZyHtgYK7NQabxgz0TBZaMDhzZ5cnlKSdgfUbs7AW5xGLckfV9THF2KjxrsKsQth1cLU5
	CTXibdG8rR68TyXSsjxOFSNr3YKVpUJJietXohI+gT+ivFihaCYFDm+D7L+rtoG+WQdZ+ykr/kL
	fIGvRF4mfySezXPAk
X-Google-Smtp-Source: AGHT+IF4Jlt2QDiei0JDT0YVWn9adcZO9qMwWDinm6xPhvNP3a25MLMFZSlajNLltiKpdAK3V8gtEQ==
X-Received: by 2002:a17:907:94d0:b0:ad8:cd31:5c31 with SMTP id a640c23a62f3a-ae057a6d22cmr544529066b.11.1750767760957;
        Tue, 24 Jun 2025 05:22:40 -0700 (PDT)
Received: from [192.168.1.29] ([178.197.222.89])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae0b3448efbsm56794966b.177.2025.06.24.05.22.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jun 2025 05:22:40 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3 0/3] iommu: omap: Simplify few things
Date: Tue, 24 Jun 2025 14:22:29 +0200
Message-Id: <20250624-syscon-phandle-args-iommu-v3-0-1a36487d69b8@linaro.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIWYWmgC/43OwQ6CMAwG4FchOzvDOjbAk+9hPBQosAQY2ZRIC
 O/u4GK4qMe/Tb/+C/PkDHl2iRbmaDLe2CEEeYpY2eLQEDdVyAxiULEQgvvZl3bgY1hWHXF0jef
 G9v2TA6HQUABITFi4Hx3V5rXbt3vIrfEP6+b91SS26T/qJHjMZarTikhlCvW1MwM6e7au2b7sB
 Aj4RZSyxiLJdJHAgdiaTfBpE/p8oyBQCmWJBeQ6T+FArev6BnZF73tRAQAA
X-Change-ID: 20250111-syscon-phandle-args-iommu-2ea162b223a4
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>, Yong Wu <yong.wu@mediatek.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
 linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1270;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=RvFdNy6eRq3jk+TGzSf8jssUcNniJlHcLRIQMwrb/Io=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBoWpiHrbqzI4XtvWNg1LD7hn/LUZqgGqbo4sCCr
 Zd0WoSazmWJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaFqYhwAKCRDBN2bmhouD
 10GoD/98RHydJ68XUE8URRl8Cvud7c5JUY4F8J8UvqOe0IHaznPrl6ENd2e+5imRRDCKx60zez0
 lBvmfvH0frs1Escs7BrTcDT0b7GijKtMUsIFDrIq5QfEPY0cge1hijJXgPsrXz7aAEtXUevetcf
 +Htv7A1ovlxGVVJSJHqCELxOj3kxH92Se8HKhrADEUt7NHOq+wPwjh6BxHstmdgUqnBGhcbaGAP
 l2V1xQ1aeHO6zsWhE1wikgp+ELRz29G+A7VBz6DS1VFp0NA1y+1S3DApBPF9Ej5LxegzaePFUJO
 bjwEUHo+GW+prxw5Q29539xnPMP6cwwt3AprX9Mc3Z9R/JmRE6doEiTLu8V/qihWajenLuu7S4K
 RZbeuY3nDmKuPzurPU+GJl2/DbospvmYNBndkl4QqpewpB6xS4pDCc5DRheDv6nnwOpz5aA5N7H
 +Z595DGPrElY7rSDw8ZaCD8NRK1KE9qEcWwDNlsq/ZBCTWxhiaYdZ1jmJKcSuCSLLbmjHnxiz+W
 AcTQOr314cVPQ8+cZNzHyWcxfHj8V6H7R+GjcjQFDR9viZ7sBu+jBQ3RFRZMtcOoeqyHsekkxND
 cGxfkKfQpvNaABGRY+aloO3BMlOwhVRvFWsITX4aDwJVVLNM6L0DUYJZA1Uw/Pg2bphuN9VtOxb
 OmjDc18i3BBuuhw==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Changes in v3:
- Rebase
- Link to v2: https://lore.kernel.org/r/20250501-syscon-phandle-args-iommu-v2-0-5a3cab296972@linaro.org

Changes in v2:
- Combine patches #1 and #2, add dev_err_probe() and drop the comment
  (resolving Robin's comment)
- New patch: iommu: mtk_iommu_v1: Simplify by dropping local 'mtk_mapping' variable
- Rb tag
- Link to resend of v1: https://lore.kernel.org/r/20250212-syscon-phandle-args-iommu-v1-0-c3fab486b426@linaro.org
- Link to v1: https://lore.kernel.org/r/20250111-syscon-phandle-args-iommu-v1-0-3767dee585a6@linaro.org

Few code simplifications without functional impact.  Not tested on
hardware.

Best regards,
Krzysztof

---
Krzysztof Kozlowski (3):
      iommu: omap: Drop redundant check if ti,syscon-mmuconfig exists
      iommu: omap: Use syscon_regmap_lookup_by_phandle_args
      iommu: mtk_iommu_v1: Simplify by dropping local 'mtk_mapping' variable

 drivers/iommu/mtk_iommu_v1.c |  4 +---
 drivers/iommu/omap-iommu.c   | 24 +++++-------------------
 2 files changed, 6 insertions(+), 22 deletions(-)
---
base-commit: 2ae2aaafb21454f4781c30734959cf223ab486ef
change-id: 20250111-syscon-phandle-args-iommu-2ea162b223a4

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

