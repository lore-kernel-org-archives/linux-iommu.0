Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F62115C6
	for <iommu@lists.linux.dev>; Fri, 31 Mar 2023 03:31:57 +0000 (UTC)
Received: by mail-pl1-f171.google.com with SMTP id n14so4179784plc.8
        for <iommu@lists.linux.dev>; Thu, 30 Mar 2023 20:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680233517;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z+9ZPtRrjL6zYn8USHZp7DIBp0J7SJ4SjTl0hBaFZwU=;
        b=DCa6KQxGG6AzMQVouFVFhw+hOgFCcmaF1zjXTSBVZFn3cRWwVJMldaTcDG/bcHarIn
         wKN527uYemylzJGjuDKerFk0a1H1DxfYo0pWhoAM2XeqMrO/zWP7A4j2eKcsklyP5nYO
         6iLv41misbE4Ld549/Mpg0xZ0xvDmWDPHdldwhJ0tKWt8eZteEbQaixaP83kHwVdThhX
         FNYYiN/01zrYghz6igEjQwEA47ScJQf/uEjLsppkLDXuoWrkLBkMYRStm7guSPHSL0Ve
         WKhcgrWCVPP4yZOltI4ItQJGBVwY39oGinS+lAAVzuVw6H1dj8B8hbE1qmAghoPRhWgZ
         aFCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680233517;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z+9ZPtRrjL6zYn8USHZp7DIBp0J7SJ4SjTl0hBaFZwU=;
        b=klWWUUYF6vvlTIfSVJ2FyN+RoD9B+qDrAtkFLtnrC7IGptwrYpJhil+pnA/aT/Ya9K
         pCkK2LPdLeX6WWlYrJdUESxehunOaaUEigvfqfY+D+Tm+wUWzxtYn1q+PQKb57Lg8QGc
         Y+AOneSDCk5s1SsOA+bGpgytjqraty7lRZU7S6KgzLpzI2bDeKA6bIb0T1t5mn3UGCmZ
         LPt2AEElsBgMZWmNn54trlyxtznCjsp61avoUS94sISw7MYTl0kEp5eVm4ADWl7XBcWV
         1Fa/p4lew6kL9jWYcjVC5Z1T2pk06z+WrnU8Vn2W+q4A88GYkkW9ZOdoI3COi6dyLway
         8/tQ==
X-Gm-Message-State: AAQBX9dVaet0PiRKbQRM8Qc7RIaVbHtlwJVUPfgCXv5/SsEmzu2Mabk1
	wYNsZW7cPVK/Y4SuHNlWvGY=
X-Google-Smtp-Source: AKy350YKL1xfmb6bn3n7spfcte0bMvhxDHTazP/SFUMAnfe0dfrEdD/Hy8m6gTAtym+NDyPM1lg3XQ==
X-Received: by 2002:a17:90b:33cc:b0:237:40a5:7cb9 with SMTP id lk12-20020a17090b33cc00b0023740a57cb9mr28369711pjb.5.1680233517522;
        Thu, 30 Mar 2023 20:31:57 -0700 (PDT)
Received: from ubt.spreadtrum.com ([138.113.14.245])
        by smtp.gmail.com with ESMTPSA id p4-20020a170902eac400b001a239325f1csm449128pld.100.2023.03.30.20.31.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 20:31:57 -0700 (PDT)
From: Chunyan Zhang <zhang.lyra@gmail.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>
Cc: iommu@lists.linux.dev,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Orson Zhai <orsonzhai@gmail.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>,
	Chunyan Zhang <chunyan.zhang@unisoc.com>,
	LKML <linux-kernel@vger.kernel.org>
Subject: [RESEND PATCH V3 2/2] iommu: sprd: Add support for reattaching an existing domain
Date: Fri, 31 Mar 2023 11:31:24 +0800
Message-Id: <20230331033124.864691-3-zhang.lyra@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230331033124.864691-1-zhang.lyra@gmail.com>
References: <20230331033124.864691-1-zhang.lyra@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chunyan Zhang <chunyan.zhang@unisoc.com>

This IOMMU driver should allow a domain to be attached more than once.

If IOMMU is reattaching to the same domain which is attached, there's
nothing to be done.

If reattching to a previously-used domain, do not alloc DMA buffer
again which stores address mapping table to avoid memory leak.

Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
---
 drivers/iommu/sprd-iommu.c | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/sprd-iommu.c b/drivers/iommu/sprd-iommu.c
index 7df1f730c778..3513b2b108bf 100644
--- a/drivers/iommu/sprd-iommu.c
+++ b/drivers/iommu/sprd-iommu.c
@@ -62,6 +62,7 @@ enum sprd_iommu_version {
  * @eb: gate clock which controls IOMMU access
  */
 struct sprd_iommu_device {
+	struct sprd_iommu_domain	*dom;
 	enum sprd_iommu_version	ver;
 	u32			*prot_page_va;
 	dma_addr_t		prot_page_pa;
@@ -252,15 +253,27 @@ static int sprd_iommu_attach_device(struct iommu_domain *domain,
 	struct sprd_iommu_domain *dom = to_sprd_domain(domain);
 	size_t pgt_size = sprd_iommu_pgt_size(domain);
 
-	if (dom->sdev)
-		return -EINVAL;
+	/* The device is attached to this domain */
+	if (sdev->dom == dom)
+		return 0;
 
-	dom->pgt_va = dma_alloc_coherent(sdev->dev, pgt_size, &dom->pgt_pa, GFP_KERNEL);
-	if (!dom->pgt_va)
-		return -ENOMEM;
+	/* The first time that domain is attaching to a device */
+	if (!dom->pgt_va) {
+		dom->pgt_va = dma_alloc_coherent(sdev->dev, pgt_size, &dom->pgt_pa, GFP_KERNEL);
+		if (!dom->pgt_va)
+			return -ENOMEM;
+
+		dom->sdev = sdev;
+	}
 
-	dom->sdev = sdev;
+	sdev->dom = dom;
 
+	/*
+	 * One sprd IOMMU serves one client device only, disabled it before
+	 * configure mapping table to avoid access conflict in case other
+	 * mapping table is stored in.
+	 */
+	sprd_iommu_hw_en(sdev, false);
 	sprd_iommu_first_ppn(dom);
 	sprd_iommu_first_vpn(dom);
 	sprd_iommu_vpn_range(dom);
-- 
2.25.1

