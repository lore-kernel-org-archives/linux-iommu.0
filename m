Received: from mail-ej1-f74.google.com (mail-ej1-f74.google.com [209.85.218.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C84B1DA612
	for <iommu@lists.linux.dev>; Thu, 17 Oct 2024 11:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729164044; cv=none; b=ibPwbhND/JDn+du2QPtgeC/FD7K83fdFMxVDmnNMD4pMDpeUWbfgfmksghayPBwq/mI0UuSuyftzkDVdZLUNc0uWoi3yjqL0XsVqiVrzHlyRXayMQkUJOIBh0kaxxb4kjwvTXE5e8RKmfz58ou5yrdMv9dVNLPukLj8xJ9KuGQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729164044; c=relaxed/simple;
	bh=KAP8sNYlHg395CZvSk4JBDKQWzF0UsR5MdlwWexgn+c=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=sB8hgFPZESjFlb831Z8nJjPa5sPyJsJIVqup56qfurME70zS2Bgy0xNG9QAcktAFPVYtj7HKOwz3msudH7EG06cvLYLZFwUDDYMyGtC4FJrIfpzbGnTztkHi0S/P43A0hIkvg0HY4A/slp6yt+ixRPW5Yrg+qWwrN45e2RBoXig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--konrada.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tenODPFC; arc=none smtp.client-ip=209.85.218.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--konrada.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tenODPFC"
Received: by mail-ej1-f74.google.com with SMTP id a640c23a62f3a-a9a194d672bso56463866b.2
        for <iommu@lists.linux.dev>; Thu, 17 Oct 2024 04:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729164041; x=1729768841; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=n8lX1GmEtOr6LjU6fqL4HANwkfAPHfX1qh42rxSH5WY=;
        b=tenODPFCKUCwDcHBj6mQLL9POTuRbV5zATsTPbNu+OVA5c8x71douh/szS8D2SLugI
         FBWJ6l9fxFoELtTkR22GrcKjbRo4Eu9yN3BRwvtKUhh7k3zN3fYiLd7DYdy3r54rm61l
         l0O1pGma6NQ9dczNwdonl7KuErmPPeH3edqA0AnwzS6A3PLlEcrFKO3ULbEE2Sbd+qdR
         LvUJ17reC7A+bZFh7AUqVFPc/3FCHSuhN5u+bl/nts2BWL5m32J0LkW8aU4i7mCQamON
         iQQ1TG4hssO3LmYbfeAbC304qg7GTCG7OVp1nUt4JKoQGVJqYAWvHeiOz3dMSG3MxU6Y
         MVhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729164041; x=1729768841;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=n8lX1GmEtOr6LjU6fqL4HANwkfAPHfX1qh42rxSH5WY=;
        b=cBfRmKD0EaJM1hfRpdBI7WhQX3/AOWraZVqIuRZ4QFqlAVDlgP9mxfHaY7EF5bpwnP
         SSx+bYVSNJ8mpwg+SY2w50BPWkpjTkqzlxly6rcO5o1Y12AzLK6P6BKHcI2WKSviOfXR
         qh2qG1dFk0SAlEjEndIw0NuT/jFcmGPzMDOs3qIsIxjXrj5Y+ubYClix36Mtp5U2LWqB
         UWL+ARbjiFsrQ0LC25SaWjplOdzZEc2z0xh9eEfmssw/TSy+uoNP3bYz0MvMUlUUtKJ4
         f3+mqQC4Zkf0d/2MTMRoW1vbKRc8o1t+0jdqpxPz1lSBMIMUPtVOnKzHFOgFJe2b8QV0
         NX8Q==
X-Forwarded-Encrypted: i=1; AJvYcCV57qU4fK1UxNj8uzqD7egbAqcd68NWmPSGwpcsl8bjyY2c6JBEjqt0iwgpfOv1zn1PRD4zMg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyt4Dk/wRS/K/Cok0Uuwd7SsnrtqX+MAo4ZNL5K+8O+/Tlu+qZh
	LH2o3/+Bvseys+sDSkPMHOS057pD6tp0oaxusnvCji/ACKAM1/hIUtrY2CeMIhLPgpFrRmgetU7
	eznbVNw==
X-Google-Smtp-Source: AGHT+IEDyt+T9WSjQe2tPO5YQX5MHOujfHpdD7iqlf6ce9MuLBoasfebCTsbGQEpakvLtWeTyF2ZgqEh5dA8
X-Received: from al-for-all.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:545])
 (user=konrada job=sendgmr) by 2002:a17:906:bcc5:b0:a99:fe61:adcb with SMTP id
 a640c23a62f3a-a9a34c7ac36mr210566b.1.1729164040346; Thu, 17 Oct 2024 04:20:40
 -0700 (PDT)
Date: Thu, 17 Oct 2024 11:20:36 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.105.g07ac214952-goog
Message-ID: <20241017112036.368772-1-konrada@google.com>
Subject: [PATCH] iommu/mediatek: Add PGTABLE_PA_35_EN to mt8186 platform data
From: Konrad Adamczyk <konrada@google.com>
To: Yong Wu <yong.wu@mediatek.com>, Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, iommu@lists.linux.dev, 
	linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org
Cc: Wojciech Macek <wmacek@google.com>, Konrad Adamczyk <konrada@google.com>
Content-Type: text/plain; charset="UTF-8"

The MT8186 chip supports 35-bit physical addresses in page table [1].
Set this platform flag.

[1] MT8186G_Application Processor Functional Specification_v1.0

Signed-off-by: Konrad Adamczyk <konrada@google.com>
---
 drivers/iommu/mtk_iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index 6a2707fe7a78..c45313c43b9e 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -1599,7 +1599,7 @@ static const unsigned int mt8186_larb_region_msk[MT8192_MULTI_REGION_NR_MAX][MTK
 static const struct mtk_iommu_plat_data mt8186_data_mm = {
 	.m4u_plat       = M4U_MT8186,
 	.flags          = HAS_BCLK | HAS_SUB_COMM_2BITS | OUT_ORDER_WR_EN |
-			  WR_THROT_EN | IOVA_34_EN | MTK_IOMMU_TYPE_MM,
+			  WR_THROT_EN | IOVA_34_EN | MTK_IOMMU_TYPE_MM | PGTABLE_PA_35_EN,
 	.larbid_remap   = {{0}, {1, MTK_INVALID_LARBID, 8}, {4}, {7}, {2}, {9, 11, 19, 20},
 			   {MTK_INVALID_LARBID, 14, 16},
 			   {MTK_INVALID_LARBID, 13, MTK_INVALID_LARBID, 17}},
-- 
2.47.0.105.g07ac214952-goog

