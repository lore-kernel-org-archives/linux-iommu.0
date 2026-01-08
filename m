Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A6B1472DB3
	for <iommu@lists.linux.dev>; Thu,  8 Jan 2026 11:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767872337; cv=none; b=mo+ssCvrkvBzQpCVdZOi8tmE+4lkZz6hqG5032BuiRaCYDky5qw6mVc+/cJlgmlDnyCAX7PlDAshf2/AHD5B8po0Am0BcRvJT/ebkIwRDxyib6NtXKLRheOMRbAag7mjSp7p66tSUlv8rscmlAhaU/2VXoQ+OAIAY41kqvMejsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767872337; c=relaxed/simple;
	bh=Fx6BCdFN7l0mjaIYuJOQklh2nn/iWgHSBjgfKrDUd3g=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Qx6T19aNeShncwZqrBRsWRF6ui1c/nns4rT/+nAoWt0jWTJ8VWjCJt9MMfRtndIt6ysCKM7eiDp+jz05yO/E2MCHQZ5DF7rbZvYuCQ5xWmkAKFoyweSKNEaaiMdTVKSdcMGkY3uFLgVQsz5kvybhrGdHj20LKbhQokb/eEgmJ1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aUQFAfof; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aUQFAfof"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-47a97b785bdso24873225e9.3
        for <iommu@lists.linux.dev>; Thu, 08 Jan 2026 03:38:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767872331; x=1768477131; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=h+PD5I1T9SWnu5gQJxf6wuZ/2pTtA653VoNBiXR/ZCw=;
        b=aUQFAfofzGRMRV6wrJwGF3GBNX/SlW/+XK6u+tR08HuxmKGKExxgFP6P9isu73O0ia
         A3Vcc08LDJ5cZdfE7dad83HzyGKGXD2gyzkLSoGs/JMmNsk+fUd40m+5NqghSH2oZPe0
         VMRsWjd6Ky2jVOq46sQuxD6ODYtfmzKrFMokMxUHhg5cXkw4+r5jSRESkYjvvKZFYiT+
         QPqcfZj9/+r5bA9Pe5nRf4lMBMQtAf/5+kZK9WtZE2XzavRwU1ZH3OqdLDyx6muWthY0
         3/WnZE/AzxrwS0UCkP46SWUiZDsqwAPId7HhMxIhpeLxXhGmgUGyWTLWDT11JP6yiPmR
         FfSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767872331; x=1768477131;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h+PD5I1T9SWnu5gQJxf6wuZ/2pTtA653VoNBiXR/ZCw=;
        b=bW1Yu8ehttMVoRnSzdVa2MFCboQyhGaQL63FQ6gzKzMwH4bIV08W040fCAFTyi+BnV
         RWGa/jaawN8Rt3oxkkYgSM1i3vy74GaDT7jX+5jLRno2otaDehPc7lwQ956aN1pCYcE/
         hIHByEzpNJE5+aEc8dh7A4ABDLRKXX35tTrF+b3bdFx22DOWJiLnWZGoSJF5Kymhu94C
         L8TAoFx8PgcZmqSSNWZQGj79sxyoItIB5tex9mQx2AgCQdjwcejO2ZrJbOkHbExJ0C9x
         KK39WJMoSYuUneplRqK9DfwmqK6wtmvr7mO2RnQ4TnD/mjftmvCT1jBtx/jiLRMSujSE
         q+mQ==
X-Gm-Message-State: AOJu0Yxax+XbdDYphKwSYIpBQmVJoqNOEsjuyYHs4F4z2KN3oP/sCG+w
	pYxnfDH3HUzVBdgB3l72Gj464o8U+/aXXRkuKZ58zM1fu4yeV4ffUNCMV/biuZcwBVgndYkJcyj
	h4Sr+kaqpDOifaTCZy/WeT4/kmt2lbQESKxfxrPapLGLYfGbzkjIo6nCm08wJIsAOOGLZpHMfeo
	y6xXHdLzYCs9oToiOJLyQIcCjUrHQ3Btd4yRC1BYwb7S6ihg==
X-Google-Smtp-Source: AGHT+IGr16gVlj0tGy6ZbPOm8QxP8OJb1ECy1Lx+gySYdlsvpdFscKv8yCc/e9t5dZ5OMMD/GUP08duGuCyGKw==
X-Received: from wrbfs2.prod.google.com ([2002:a05:6000:25c2:b0:430:f5a3:57c8])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:4e51:b0:477:7af8:c8ad with SMTP id 5b1f17b1804b1-47d84b39850mr75537675e9.31.1767872331602;
 Thu, 08 Jan 2026 03:38:51 -0800 (PST)
Date: Thu,  8 Jan 2026 11:38:46 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
X-Mailer: git-send-email 2.52.0.351.gbe84eed79e-goog
Message-ID: <20260108113846.56179-1-smostafa@google.com>
Subject: [PATCH] iommu/io-pgtable-arm: Drop DMA API usage for CMOs
From: Mostafa Saleh <smostafa@google.com>
To: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Cc: robin.murphy@arm.com, will@kernel.org, joro@8bytes.org, 
	Mostafa Saleh <smostafa@google.com>, Jason Gunthorpe <jgg@ziepe.ca>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

As part of the KVM SMMUv3 series[1], we are trying to factor out
the kernel specific code from io-pgtable-arm so it can also compile
for the hypervisor.

Jason pointed out that the DMA-API calls are not really needed [2].

Looking more into this. Initially, the io-pgtable API let drivers
do the CMOs using tlb::flush_pgtable() where drivers were using the
DMA API (map/unmap_single) only to do CMOs as the low-level cache
functions won=E2=80=99t be available for modules.

This was later moved to the core code [3], with possibility to
convert it to full blown DMA-API code if there was a use case.

However, no such use case appeared, and we can simplify the code
slightly by doing CMO directly instead of going through the DMA-API
functions just for CMOs.

Although HTTU is not used at the moment, leave the
arch_sync_dma_for_cpu() in __arm_lpae_free_pages() as this is not a
hot path.

Removing the DMA-API will also remove some extra checks ensuring that
the IOMMU can deal with physical addrs. we can add those check at
page table creation time (Something as use_dma_iommu/is_swiotlb_active
However, that seemed a little too much as Linux doesn't support such
topologies anyways.

[1] https://lore.kernel.org/linux-iommu/20251117184815.1027271-1-smostafa@g=
oogle.com/
[2] https://lore.kernel.org/linux-iommu/20251216005834.GC31492@ziepe.ca/
[3] https://lore.kernel.org/linux-iommu/7c5584d3efa61ee6b0b87efb72f24f32852=
aafb7.1438195011.git.robin.murphy@arm.com/

Suggested-by: Jason Gunthorpe <jgg@ziepe.ca>
Signed-off-by: Mostafa Saleh <smostafa@google.com>
---
 drivers/iommu/io-pgtable-arm.c | 39 +++++++---------------------------
 1 file changed, 8 insertions(+), 31 deletions(-)

diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.=
c
index e6626004b323..0da9195155ec 100644
--- a/drivers/iommu/io-pgtable-arm.c
+++ b/drivers/iommu/io-pgtable-arm.c
@@ -15,7 +15,7 @@
 #include <linux/sizes.h>
 #include <linux/slab.h>
 #include <linux/types.h>
-#include <linux/dma-mapping.h>
+#include <linux/dma-map-ops.h>
=20
 #include <asm/barrier.h>
=20
@@ -254,7 +254,6 @@ static void *__arm_lpae_alloc_pages(size_t size, gfp_t =
gfp,
 {
 	struct device *dev =3D cfg->iommu_dev;
 	size_t alloc_size;
-	dma_addr_t dma;
 	void *pages;
=20
 	/*
@@ -271,32 +270,10 @@ static void *__arm_lpae_alloc_pages(size_t size, gfp_=
t gfp,
 	if (!pages)
 		return NULL;
=20
-	if (!cfg->coherent_walk) {
-		dma =3D dma_map_single(dev, pages, size, DMA_TO_DEVICE);
-		if (dma_mapping_error(dev, dma))
-			goto out_free;
-		/*
-		 * We depend on the IOMMU being able to work with any physical
-		 * address directly, so if the DMA layer suggests otherwise by
-		 * translating or truncating them, that bodes very badly...
-		 */
-		if (dma !=3D virt_to_phys(pages))
-			goto out_unmap;
-	}
-
+	if (!cfg->coherent_walk)
+		arch_sync_dma_for_device(__arm_lpae_dma_addr(pages), size,
+					 DMA_TO_DEVICE);
 	return pages;
-
-out_unmap:
-	dev_err(dev, "Cannot accommodate DMA translation for IOMMU page tables\n"=
);
-	dma_unmap_single(dev, dma, size, DMA_TO_DEVICE);
-
-out_free:
-	if (cfg->free)
-		cfg->free(cookie, pages, size);
-	else
-		iommu_free_pages(pages);
-
-	return NULL;
 }
=20
 static void __arm_lpae_free_pages(void *pages, size_t size,
@@ -304,8 +281,8 @@ static void __arm_lpae_free_pages(void *pages, size_t s=
ize,
 				  void *cookie)
 {
 	if (!cfg->coherent_walk)
-		dma_unmap_single(cfg->iommu_dev, __arm_lpae_dma_addr(pages),
-				 size, DMA_TO_DEVICE);
+		arch_sync_dma_for_cpu(__arm_lpae_dma_addr(pages),
+				      size, DMA_TO_DEVICE);
=20
 	if (cfg->free)
 		cfg->free(cookie, pages, size);
@@ -316,8 +293,8 @@ static void __arm_lpae_free_pages(void *pages, size_t s=
ize,
 static void __arm_lpae_sync_pte(arm_lpae_iopte *ptep, int num_entries,
 				struct io_pgtable_cfg *cfg)
 {
-	dma_sync_single_for_device(cfg->iommu_dev, __arm_lpae_dma_addr(ptep),
-				   sizeof(*ptep) * num_entries, DMA_TO_DEVICE);
+	arch_sync_dma_for_device(__arm_lpae_dma_addr(ptep),
+				 sizeof(*ptep) * num_entries, DMA_TO_DEVICE);
 }
=20
 static void __arm_lpae_clear_pte(arm_lpae_iopte *ptep, struct io_pgtable_c=
fg *cfg, int num_entries)
--=20
2.52.0.351.gbe84eed79e-goog

