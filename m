Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17E2119CC2E
	for <iommu@lists.linux.dev>; Thu,  5 Sep 2024 12:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725540609; cv=none; b=HlAH6DivB8fu7lmCfTazNT+YulbIjGDVsAlh/xikhbg4nz10/hLVUfs+4pvk8KLpbxOSGDnh6a5KzDCoBUK4jcnxt1QXtbDG8OPtD3VcRiuTjDyb+GLfKxWW339wEp/atKiRx9XnHKl9N0qfjo//rBbMgATWyIzoKj9Aj9O2bU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725540609; c=relaxed/simple;
	bh=qce84B5NvR44kujqZ9743ui8j6Mh4hdIIbcIDgaypKY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LGM0cozJTmjk2XBqqCRZLJN57O8uxFtPPP+wrs2X/+qNQqnAEirciD6Mmar1+1aJ9tOmU1hRhqY/exyuzE93hUHWNpxj6RC+ddTim6mV6OT58b+yRqj5DU0WZbJIePh0kxEWERJiniIPdRULD4fPOF1dAB4o7GPhBzQxA7D34nQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SvO7MAyJ; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SvO7MAyJ"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-7c6aee8e8daso588914a12.0
        for <iommu@lists.linux.dev>; Thu, 05 Sep 2024 05:50:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725540607; x=1726145407; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AbIcFL6KLZXMYP15JMSrziSxqWJs9UyvqU1aIaWK9pI=;
        b=SvO7MAyJnGAOCjj5YjZpTj+vnQkMthV7cZJ6DuzGvzk2zuKl2tZPlWUtsBZRHtMYfk
         Fow0Qq/rhS1Mau/4tCrLk20VyVjPgjnrjsvKThmyZ+G+4MKqOmLXMiuh9KLjYPoU5EeL
         FebEU0BgwcYhR1OAO59832paP2YGiO/xxfvPpRjK2qbM4y8noiddBH/bGU9Ds69uch4q
         /Jp1vujn0JdYzdzzeGdz+rHXaEDGWJ0gSv+xeX2p354SbFI7XAXiFo72YoDz4fNwPQ9n
         NaKu36hIU0NPhuN23W0wrXkNRG3rf63HR043wgMOPrvQV8gzCgbfc5Ew8XAC2spa8O8+
         Eg5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725540607; x=1726145407;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AbIcFL6KLZXMYP15JMSrziSxqWJs9UyvqU1aIaWK9pI=;
        b=lrK9C+evr6wQPfwSvWi6nmh50w62Ot1EJSnJg4HX3AAii1Nkc5kaOQOK1G+IYuFA03
         PmAb6xFvKG5DeEu1vu93Z38Rd0SGiY0tVJasDQE3cH5vpJ3J5dgJrOLhjpGpvnl3ehUf
         F+mc87WxrkJdX9m3DWqMSR4Yur5aqjP+W2t6EEUmD5OVCcjRxwUY6z0/gPZSSxIw7NZl
         ikrc+GFVg3WrzGDf4SnU2ZImQVzVF6wF2LEBG/5iuLlcxIL60qeDUsjAikcgtg7Lqswd
         kH4tw9v09tO4X6XziLEfv8J/mmerqz9Nsu8R7CsqK80C5HszToj0JPx/oRbIw2BsUd+/
         G2iQ==
X-Gm-Message-State: AOJu0YzPZBOvHpgLvuV8S0RrOqcbeDnlOxYU8d9cFXcjwI/3qts0Bdql
	YNZpteoLTUrAsJqdcc0LCh4Gcj51Flv2BDdrflBPhC8SSlaGjjxNTfwTWA==
X-Google-Smtp-Source: AGHT+IGWH67j9Ae4z1bWCKkTMqpdz15WdakR2Z0nl3EE0ssMBp8RIbo+r/JoS6LCLi9xCGkqsJVTDA==
X-Received: by 2002:a17:902:ecc3:b0:205:6a9b:7e3e with SMTP id d9443c01a7336-20584230d32mr143491935ad.56.1725540606654;
        Thu, 05 Sep 2024 05:50:06 -0700 (PDT)
Received: from localhost (c-73-37-105-206.hsd1.or.comcast.net. [73.37.105.206])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-206aea38c91sm28345915ad.169.2024.09.05.05.50.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 05:50:05 -0700 (PDT)
From: Rob Clark <robdclark@gmail.com>
To: iommu@lists.linux.dev
Cc: linux-arm-msm@vger.kernel.org,
	freedreno@lists.freedesktop.org,
	Ashish Mhetre <amhetre@nvidia.com>,
	Rob Clark <robdclark@chromium.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>,
	linux-arm-kernel@lists.infradead.org (moderated list:ARM SMMU DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] Revert "iommu/io-pgtable-arm: Optimise non-coherent unmap"
Date: Thu,  5 Sep 2024 05:49:56 -0700
Message-ID: <20240905124956.84932-1-robdclark@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Rob Clark <robdclark@chromium.org>

This reverts commit 85b715a334583488ad7fbd3001fe6fd617b7d4c0.

It was causing gpu smmu faults on x1e80100.

I _think_ what is causing this is the change in ordering of
__arm_lpae_clear_pte() (dma_sync_single_for_device() on the pgtable
memory) and io_pgtable_tlb_flush_walk().  I'm not entirely sure how
this patch is supposed to work correctly in the face of other
concurrent translations (to buffers unrelated to the one being
unmapped(), because after the io_pgtable_tlb_flush_walk() we can have
stale data read back into the tlb.

Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/iommu/io-pgtable-arm.c | 31 ++++++++++++++-----------------
 1 file changed, 14 insertions(+), 17 deletions(-)

diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
index 16e51528772d..85261baa3a04 100644
--- a/drivers/iommu/io-pgtable-arm.c
+++ b/drivers/iommu/io-pgtable-arm.c
@@ -274,13 +274,13 @@ static void __arm_lpae_sync_pte(arm_lpae_iopte *ptep, int num_entries,
 				   sizeof(*ptep) * num_entries, DMA_TO_DEVICE);
 }
 
-static void __arm_lpae_clear_pte(arm_lpae_iopte *ptep, struct io_pgtable_cfg *cfg, int num_entries)
+static void __arm_lpae_clear_pte(arm_lpae_iopte *ptep, struct io_pgtable_cfg *cfg)
 {
-	for (int i = 0; i < num_entries; i++)
-		ptep[i] = 0;
 
-	if (!cfg->coherent_walk && num_entries)
-		__arm_lpae_sync_pte(ptep, num_entries, cfg);
+	*ptep = 0;
+
+	if (!cfg->coherent_walk)
+		__arm_lpae_sync_pte(ptep, 1, cfg);
 }
 
 static size_t __arm_lpae_unmap(struct arm_lpae_io_pgtable *data,
@@ -653,28 +653,25 @@ static size_t __arm_lpae_unmap(struct arm_lpae_io_pgtable *data,
 		max_entries = ARM_LPAE_PTES_PER_TABLE(data) - unmap_idx_start;
 		num_entries = min_t(int, pgcount, max_entries);
 
-		/* Find and handle non-leaf entries */
-		for (i = 0; i < num_entries; i++) {
-			pte = READ_ONCE(ptep[i]);
+		while (i < num_entries) {
+			pte = READ_ONCE(*ptep);
 			if (WARN_ON(!pte))
 				break;
 
-			if (!iopte_leaf(pte, lvl, iop->fmt)) {
-				__arm_lpae_clear_pte(&ptep[i], &iop->cfg, 1);
+			__arm_lpae_clear_pte(ptep, &iop->cfg);
 
+			if (!iopte_leaf(pte, lvl, iop->fmt)) {
 				/* Also flush any partial walks */
 				io_pgtable_tlb_flush_walk(iop, iova + i * size, size,
 							  ARM_LPAE_GRANULE(data));
 				__arm_lpae_free_pgtable(data, lvl + 1, iopte_deref(pte, data));
+			} else if (!iommu_iotlb_gather_queued(gather)) {
+				io_pgtable_tlb_add_page(iop, gather, iova + i * size, size);
 			}
-		}
 
-		/* Clear the remaining entries */
-		__arm_lpae_clear_pte(ptep, &iop->cfg, i);
-
-		if (gather && !iommu_iotlb_gather_queued(gather))
-			for (int j = 0; j < i; j++)
-				io_pgtable_tlb_add_page(iop, gather, iova + j * size, size);
+			ptep++;
+			i++;
+		}
 
 		return i * size;
 	} else if (iopte_leaf(pte, lvl, iop->fmt)) {
-- 
2.46.0

