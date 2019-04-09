Return-Path: <SRS0=aFDh=SL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA900C282CE
	for <iommu@archiver.kernel.org>; Tue,  9 Apr 2019 20:54:36 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8FF4721904
	for <iommu@archiver.kernel.org>; Tue,  9 Apr 2019 20:54:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FF4721904
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 25DA7F47;
	Tue,  9 Apr 2019 20:54:34 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 0A702E39
	for <iommu@lists.linux-foundation.org>;
	Tue,  9 Apr 2019 20:54:33 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-oi1-f195.google.com (mail-oi1-f195.google.com
	[209.85.167.195])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id E500CF4
	for <iommu@lists.linux-foundation.org>;
	Tue,  9 Apr 2019 20:54:30 +0000 (UTC)
Received: by mail-oi1-f195.google.com with SMTP id w139so14775358oie.9
	for <iommu@lists.linux-foundation.org>;
	Tue, 09 Apr 2019 13:54:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=wJx3jX3H/L03QI2KqoZ+dONi+zcUCuOwmQkdB2K1xHg=;
	b=cA6eKEQBXR6xyXa5YNALnNdfe0CUQChA/X6cEDUBlfZMt/iVOPXLOmKEK7hrOQTV/A
	zg5p7QlQXO2a+PAf78Ov3RTT8aYErn4MwTY4W2IGNiZ/6AS+d87HEpFxLav0EGcQBnP0
	sKEC2/nnctGTXwpx+yuzxM/YrCZP1xD6R1/Nyq/UTG21qqpOxeogCULvmOq7LU7hv57+
	m0l6gJKO6xkBxeJHMILTq1jeFNCV1+K3wz+Pl53as7ggHIYlhNm9Yq30MFtFJnjROi1I
	KyyCmXfVpT+CT7xiFuNKtU8IyL7KKutJk/0K41oUupGPrI44xatSCBkO7tEAAhB5yILf
	vdOg==
X-Gm-Message-State: APjAAAVKqPVxXSu8gKy7HvwmOnF7XHsve7TVYaKsNiTYocVWx0+rtq+6
	TNbMV2QKBuR0v4VrFI/pUQ==
X-Google-Smtp-Source: APXvYqwWxw0XHtiAWy9X2yctnHdh90MK808T1ZqPSYYqMc2pVluOfDaeI8FPX4VXDzDKJMxciVt0Iw==
X-Received: by 2002:aca:f189:: with SMTP id p131mr199045oih.89.1554843270003; 
	Tue, 09 Apr 2019 13:54:30 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net.
	[24.155.109.49]) by smtp.googlemail.com with ESMTPSA id
	o66sm6472175oig.11.2019.04.09.13.54.28
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Tue, 09 Apr 2019 13:54:29 -0700 (PDT)
From: Rob Herring <robh@kernel.org>
To: dri-devel@lists.freedesktop.org
Subject: [PATCH v3 1/3] iommu: io-pgtable: Add ARM Mali midgard MMU page table
	format
Date: Tue,  9 Apr 2019 15:54:25 -0500
Message-Id: <20190409205427.6943-2-robh@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190409205427.6943-1-robh@kernel.org>
References: <20190409205427.6943-1-robh@kernel.org>
MIME-Version: 1.0
Cc: Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org,
	iommu@lists.linux-foundation.org, Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Robin Murphy <robin.murphy@arm.com>, linux-arm-kernel@lists.infradead.org
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Development issues for Linux IOMMU support
	<iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org
Message-ID: <20190409205425.grzn2tTspRxCO9EI5CLer5A85MdMmwihbaj4z4N7fiI@z>

ARM Mali midgard GPU is similar to standard 64-bit stage 1 page tables, but
have a few differences. Add a new format type to represent the format. The
input address size is 48-bits and the output address size is 40-bits (and
possibly less?). Note that the later bifrost GPUs follow the standard
64-bit stage 1 format.

The differences in the format compared to 64-bit stage 1 format are:

The 3rd level page entry bits are 0x1 instead of 0x3 for page entries.

The access flags are not read-only and unprivileged, but read and write.
This is similar to stage 2 entries, but the memory attributes field matches
stage 1 being an index.

The nG bit is not set by the vendor driver. This one didn't seem to matter,
but we'll keep it aligned to the vendor driver.

Cc: Will Deacon <will.deacon@arm.com>
Acked-by: Robin Murphy <robin.murphy@arm.com>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: iommu@lists.linux-foundation.org
Acked-by: Alyssa Rosenzweig <alyssa@rosenzweig.io>
Signed-off-by: Rob Herring <robh@kernel.org>
---
This is really v4 of the patch. v3 is the series version.

Joerg, please ack so we can take this via the drm tree.

v3:
- Incorporated refactoring from Robin

 drivers/iommu/io-pgtable-arm.c | 91 ++++++++++++++++++++++++++--------
 drivers/iommu/io-pgtable.c     |  1 +
 include/linux/io-pgtable.h     |  7 +++
 3 files changed, 77 insertions(+), 22 deletions(-)

diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
index d3700ec15cbd..4e21efbc4459 100644
--- a/drivers/iommu/io-pgtable-arm.c
+++ b/drivers/iommu/io-pgtable-arm.c
@@ -172,6 +172,10 @@
 #define ARM_LPAE_MAIR_ATTR_IDX_CACHE	1
 #define ARM_LPAE_MAIR_ATTR_IDX_DEV	2

+#define ARM_MALI_LPAE_TTBR_ADRMODE_TABLE (3u << 0)
+#define ARM_MALI_LPAE_TTBR_READ_INNER	BIT(2)
+#define ARM_MALI_LPAE_TTBR_SHARE_OUTER	BIT(4)
+
 /* IOPTE accessors */
 #define iopte_deref(pte,d) __va(iopte_to_paddr(pte, d))

@@ -180,11 +184,6 @@

 #define iopte_prot(pte)	((pte) & ARM_LPAE_PTE_ATTR_MASK)

-#define iopte_leaf(pte,l)					\
-	(l == (ARM_LPAE_MAX_LEVELS - 1) ?			\
-		(iopte_type(pte,l) == ARM_LPAE_PTE_TYPE_PAGE) :	\
-		(iopte_type(pte,l) == ARM_LPAE_PTE_TYPE_BLOCK))
-
 struct arm_lpae_io_pgtable {
 	struct io_pgtable	iop;

@@ -198,6 +197,15 @@ struct arm_lpae_io_pgtable {

 typedef u64 arm_lpae_iopte;

+static inline bool iopte_leaf(arm_lpae_iopte pte, int lvl,
+			      enum io_pgtable_fmt fmt)
+{
+	if (lvl == (ARM_LPAE_MAX_LEVELS - 1) && fmt != ARM_MALI_LPAE)
+		return iopte_type(pte, lvl) == ARM_LPAE_PTE_TYPE_PAGE;
+
+	return iopte_type(pte, lvl) == ARM_LPAE_PTE_TYPE_BLOCK;
+}
+
 static arm_lpae_iopte paddr_to_iopte(phys_addr_t paddr,
 				     struct arm_lpae_io_pgtable *data)
 {
@@ -303,12 +311,14 @@ static void __arm_lpae_init_pte(struct arm_lpae_io_pgtable *data,
 	if (data->iop.cfg.quirks & IO_PGTABLE_QUIRK_ARM_NS)
 		pte |= ARM_LPAE_PTE_NS;

-	if (lvl == ARM_LPAE_MAX_LEVELS - 1)
+	if (data->iop.fmt != ARM_MALI_LPAE && lvl == ARM_LPAE_MAX_LEVELS - 1)
 		pte |= ARM_LPAE_PTE_TYPE_PAGE;
 	else
 		pte |= ARM_LPAE_PTE_TYPE_BLOCK;

-	pte |= ARM_LPAE_PTE_AF | ARM_LPAE_PTE_SH_IS;
+	if (data->iop.fmt != ARM_MALI_LPAE)
+		pte |= ARM_LPAE_PTE_AF;
+	pte |= ARM_LPAE_PTE_SH_IS;
 	pte |= paddr_to_iopte(paddr, data);

 	__arm_lpae_set_pte(ptep, pte, &data->iop.cfg);
@@ -321,7 +331,7 @@ static int arm_lpae_init_pte(struct arm_lpae_io_pgtable *data,
 {
 	arm_lpae_iopte pte = *ptep;

-	if (iopte_leaf(pte, lvl)) {
+	if (iopte_leaf(pte, lvl, data->iop.fmt)) {
 		/* We require an unmap first */
 		WARN_ON(!selftest_running);
 		return -EEXIST;
@@ -409,7 +419,7 @@ static int __arm_lpae_map(struct arm_lpae_io_pgtable *data, unsigned long iova,
 		__arm_lpae_sync_pte(ptep, cfg);
 	}

-	if (pte && !iopte_leaf(pte, lvl)) {
+	if (pte && !iopte_leaf(pte, lvl, data->iop.fmt)) {
 		cptep = iopte_deref(pte, data);
 	} else if (pte) {
 		/* We require an unmap first */
@@ -429,31 +439,37 @@ static arm_lpae_iopte arm_lpae_prot_to_pte(struct arm_lpae_io_pgtable *data,
 	if (data->iop.fmt == ARM_64_LPAE_S1 ||
 	    data->iop.fmt == ARM_32_LPAE_S1) {
 		pte = ARM_LPAE_PTE_nG;
-
 		if (!(prot & IOMMU_WRITE) && (prot & IOMMU_READ))
 			pte |= ARM_LPAE_PTE_AP_RDONLY;
-
 		if (!(prot & IOMMU_PRIV))
 			pte |= ARM_LPAE_PTE_AP_UNPRIV;
-
-		if (prot & IOMMU_MMIO)
-			pte |= (ARM_LPAE_MAIR_ATTR_IDX_DEV
-				<< ARM_LPAE_PTE_ATTRINDX_SHIFT);
-		else if (prot & IOMMU_CACHE)
-			pte |= (ARM_LPAE_MAIR_ATTR_IDX_CACHE
-				<< ARM_LPAE_PTE_ATTRINDX_SHIFT);
 	} else {
 		pte = ARM_LPAE_PTE_HAP_FAULT;
 		if (prot & IOMMU_READ)
 			pte |= ARM_LPAE_PTE_HAP_READ;
 		if (prot & IOMMU_WRITE)
 			pte |= ARM_LPAE_PTE_HAP_WRITE;
+	}
+
+	/*
+	 * Note that this logic is structured to accommodate Mali LPAE
+	 * having stage-1-like attributes but stage-2-like permissions.
+	 */
+	if (data->iop.fmt == ARM_64_LPAE_S2 ||
+	    data->iop.fmt == ARM_32_LPAE_S2) {
 		if (prot & IOMMU_MMIO)
 			pte |= ARM_LPAE_PTE_MEMATTR_DEV;
 		else if (prot & IOMMU_CACHE)
 			pte |= ARM_LPAE_PTE_MEMATTR_OIWB;
 		else
 			pte |= ARM_LPAE_PTE_MEMATTR_NC;
+	} else {
+		if (prot & IOMMU_MMIO)
+			pte |= (ARM_LPAE_MAIR_ATTR_IDX_DEV
+				<< ARM_LPAE_PTE_ATTRINDX_SHIFT);
+		else if (prot & IOMMU_CACHE)
+			pte |= (ARM_LPAE_MAIR_ATTR_IDX_CACHE
+				<< ARM_LPAE_PTE_ATTRINDX_SHIFT);
 	}

 	if (prot & IOMMU_NOEXEC)
@@ -511,7 +527,7 @@ static void __arm_lpae_free_pgtable(struct arm_lpae_io_pgtable *data, int lvl,
 	while (ptep != end) {
 		arm_lpae_iopte pte = *ptep++;

-		if (!pte || iopte_leaf(pte, lvl))
+		if (!pte || iopte_leaf(pte, lvl, data->iop.fmt))
 			continue;

 		__arm_lpae_free_pgtable(data, lvl + 1, iopte_deref(pte, data));
@@ -602,7 +618,7 @@ static size_t __arm_lpae_unmap(struct arm_lpae_io_pgtable *data,
 	if (size == ARM_LPAE_BLOCK_SIZE(lvl, data)) {
 		__arm_lpae_set_pte(ptep, 0, &iop->cfg);

-		if (!iopte_leaf(pte, lvl)) {
+		if (!iopte_leaf(pte, lvl, iop->fmt)) {
 			/* Also flush any partial walks */
 			io_pgtable_tlb_add_flush(iop, iova, size,
 						ARM_LPAE_GRANULE(data), false);
@@ -621,7 +637,7 @@ static size_t __arm_lpae_unmap(struct arm_lpae_io_pgtable *data,
 		}

 		return size;
-	} else if (iopte_leaf(pte, lvl)) {
+	} else if (iopte_leaf(pte, lvl, iop->fmt)) {
 		/*
 		 * Insert a table at the next level to map the old region,
 		 * minus the part we want to unmap
@@ -669,7 +685,7 @@ static phys_addr_t arm_lpae_iova_to_phys(struct io_pgtable_ops *ops,
 			return 0;

 		/* Leaf entry? */
-		if (iopte_leaf(pte,lvl))
+		if (iopte_leaf(pte, lvl, data->iop.fmt))
 			goto found_translation;

 		/* Take it to the next level */
@@ -995,6 +1011,32 @@ arm_32_lpae_alloc_pgtable_s2(struct io_pgtable_cfg *cfg, void *cookie)
 	return iop;
 }

+static struct io_pgtable *
+arm_mali_lpae_alloc_pgtable(struct io_pgtable_cfg *cfg, void *cookie)
+{
+	struct io_pgtable *iop;
+
+	if (cfg->ias != 48 || cfg->oas > 40)
+		return NULL;
+
+	cfg->pgsize_bitmap &= (SZ_4K | SZ_2M | SZ_1G);
+	iop = arm_64_lpae_alloc_pgtable_s1(cfg, cookie);
+	if (iop) {
+		u64 mair, ttbr;
+
+		/* Copy values as union fields overlap */
+		mair = cfg->arm_lpae_s1_cfg.mair[0];
+		ttbr = cfg->arm_lpae_s1_cfg.ttbr[0];
+
+		cfg->arm_mali_lpae_cfg.memattr = mair;
+		cfg->arm_mali_lpae_cfg.transtab = ttbr |
+			ARM_MALI_LPAE_TTBR_READ_INNER |
+			ARM_MALI_LPAE_TTBR_ADRMODE_TABLE;
+	}
+
+	return iop;
+}
+
 struct io_pgtable_init_fns io_pgtable_arm_64_lpae_s1_init_fns = {
 	.alloc	= arm_64_lpae_alloc_pgtable_s1,
 	.free	= arm_lpae_free_pgtable,
@@ -1015,6 +1057,11 @@ struct io_pgtable_init_fns io_pgtable_arm_32_lpae_s2_init_fns = {
 	.free	= arm_lpae_free_pgtable,
 };

+struct io_pgtable_init_fns io_pgtable_arm_mali_lpae_init_fns = {
+	.alloc	= arm_mali_lpae_alloc_pgtable,
+	.free	= arm_lpae_free_pgtable,
+};
+
 #ifdef CONFIG_IOMMU_IO_PGTABLE_LPAE_SELFTEST

 static struct io_pgtable_cfg *cfg_cookie;
diff --git a/drivers/iommu/io-pgtable.c b/drivers/iommu/io-pgtable.c
index 93f2880be6c6..5227cfdbb65b 100644
--- a/drivers/iommu/io-pgtable.c
+++ b/drivers/iommu/io-pgtable.c
@@ -30,6 +30,7 @@ io_pgtable_init_table[IO_PGTABLE_NUM_FMTS] = {
 	[ARM_32_LPAE_S2] = &io_pgtable_arm_32_lpae_s2_init_fns,
 	[ARM_64_LPAE_S1] = &io_pgtable_arm_64_lpae_s1_init_fns,
 	[ARM_64_LPAE_S2] = &io_pgtable_arm_64_lpae_s2_init_fns,
+	[ARM_MALI_LPAE] = &io_pgtable_arm_mali_lpae_init_fns,
 #endif
 #ifdef CONFIG_IOMMU_IO_PGTABLE_ARMV7S
 	[ARM_V7S] = &io_pgtable_arm_v7s_init_fns,
diff --git a/include/linux/io-pgtable.h b/include/linux/io-pgtable.h
index 47d5ae559329..76969a564831 100644
--- a/include/linux/io-pgtable.h
+++ b/include/linux/io-pgtable.h
@@ -12,6 +12,7 @@ enum io_pgtable_fmt {
 	ARM_64_LPAE_S1,
 	ARM_64_LPAE_S2,
 	ARM_V7S,
+	ARM_MALI_LPAE,
 	IO_PGTABLE_NUM_FMTS,
 };

@@ -108,6 +109,11 @@ struct io_pgtable_cfg {
 			u32	nmrr;
 			u32	prrr;
 		} arm_v7s_cfg;
+
+		struct {
+			u64	transtab;
+			u64	memattr;
+		} arm_mali_lpae_cfg;
 	};
 };

@@ -209,5 +215,6 @@ extern struct io_pgtable_init_fns io_pgtable_arm_32_lpae_s2_init_fns;
 extern struct io_pgtable_init_fns io_pgtable_arm_64_lpae_s1_init_fns;
 extern struct io_pgtable_init_fns io_pgtable_arm_64_lpae_s2_init_fns;
 extern struct io_pgtable_init_fns io_pgtable_arm_v7s_init_fns;
+extern struct io_pgtable_init_fns io_pgtable_arm_mali_lpae_init_fns;

 #endif /* __IO_PGTABLE_H */
--
2.19.1
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
