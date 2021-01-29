Return-Path: <SRS0=1cKf=HA=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A00D7C433DB
	for <iommu@archiver.kernel.org>; Fri, 29 Jan 2021 09:10:57 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24F5E64E25
	for <iommu@archiver.kernel.org>; Fri, 29 Jan 2021 09:10:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24F5E64E25
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hisilicon.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id DB58886962;
	Fri, 29 Jan 2021 09:10:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dyrdu1h4DflX; Fri, 29 Jan 2021 09:10:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 2693986985;
	Fri, 29 Jan 2021 09:10:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F09C8C0FA7;
	Fri, 29 Jan 2021 09:10:55 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 86AB4C013A
 for <iommu@lists.linux-foundation.org>; Fri, 29 Jan 2021 09:10:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 7FC938706D
 for <iommu@lists.linux-foundation.org>; Fri, 29 Jan 2021 09:10:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CSf1WnGZhTq0 for <iommu@lists.linux-foundation.org>;
 Fri, 29 Jan 2021 09:10:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
 by whitealder.osuosl.org (Postfix) with ESMTPS id D26E387039
 for <iommu@lists.linux-foundation.org>; Fri, 29 Jan 2021 09:10:50 +0000 (UTC)
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
 by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4DRs3Y44s9zjG2L;
 Fri, 29 Jan 2021 17:09:29 +0800 (CST)
Received: from localhost.localdomain (10.69.192.58) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.498.0; Fri, 29 Jan 2021 17:10:35 +0800
From: Zhou Wang <wangzhou1@hisilicon.com>
To: Will Deacon <will@kernel.org>, Rob Herring <robh@kernel.org>
Subject: [RFC PATCH 2/3] iommu/io-pgtable: Export page table walk needed
 functions and macros
Date: Fri, 29 Jan 2021 17:06:23 +0800
Message-ID: <1611911184-116261-3-git-send-email-wangzhou1@hisilicon.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1611911184-116261-1-git-send-email-wangzhou1@hisilicon.com>
References: <1611911184-116261-1-git-send-email-wangzhou1@hisilicon.com>
MIME-Version: 1.0
X-Originating-IP: [10.69.192.58]
X-CFilter-Loop: Reflected
Cc: iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Export page table walk needed functions and macros, then page table dump
in later debug interface could be used directly.

Signed-off-by: Zhou Wang <wangzhou1@hisilicon.com>
---
 drivers/iommu/io-pgtable-arm.c | 47 +++++-------------------------------------
 drivers/iommu/io-pgtable-arm.h | 43 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 48 insertions(+), 42 deletions(-)

diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
index 87def58..920a92b 100644
--- a/drivers/iommu/io-pgtable-arm.c
+++ b/drivers/iommu/io-pgtable-arm.c
@@ -24,35 +24,12 @@
 
 #define ARM_LPAE_MAX_ADDR_BITS		52
 #define ARM_LPAE_S2_MAX_CONCAT_PAGES	16
-#define ARM_LPAE_MAX_LEVELS		4
-
-/* Struct accessors */
-#define io_pgtable_to_data(x)						\
-	container_of((x), struct arm_lpae_io_pgtable, iop)
-
-#define io_pgtable_ops_to_data(x)					\
-	io_pgtable_to_data(io_pgtable_ops_to_pgtable(x))
-
-/*
- * Calculate the right shift amount to get to the portion describing level l
- * in a virtual address mapped by the pagetable in d.
- */
-#define ARM_LPAE_LVL_SHIFT(l,d)						\
-	(((ARM_LPAE_MAX_LEVELS - (l)) * (d)->bits_per_level) +		\
-	ilog2(sizeof(arm_lpae_iopte)))
 
 #define ARM_LPAE_GRANULE(d)						\
 	(sizeof(arm_lpae_iopte) << (d)->bits_per_level)
 #define ARM_LPAE_PGD_SIZE(d)						\
 	(sizeof(arm_lpae_iopte) << (d)->pgd_bits)
 
-/*
- * Calculate the index at level l used to map virtual address a using the
- * pagetable in d.
- */
-#define ARM_LPAE_PGD_IDX(l,d)						\
-	((l) == (d)->start_level ? (d)->pgd_bits - (d)->bits_per_level : 0)
-
 #define ARM_LPAE_LVL_IDX(a,l,d)						\
 	(((u64)(a) >> ARM_LPAE_LVL_SHIFT(l,d)) &			\
 	 ((1 << ((d)->bits_per_level + ARM_LPAE_PGD_IDX(l,d))) - 1))
@@ -127,34 +104,19 @@
 #define ARM_MALI_LPAE_MEMATTR_IMP_DEF	0x88ULL
 #define ARM_MALI_LPAE_MEMATTR_WRITE_ALLOC 0x8DULL
 
-/* IOPTE accessors */
-#define iopte_deref(pte,d) __va(iopte_to_paddr(pte, d))
-
 #define iopte_type(pte)					\
 	(((pte) >> ARM_LPAE_PTE_TYPE_SHIFT) & ARM_LPAE_PTE_TYPE_MASK)
 
 #define iopte_prot(pte)	((pte) & ARM_LPAE_PTE_ATTR_MASK)
 
-struct arm_lpae_io_pgtable {
-	struct io_pgtable	iop;
-
-	int			pgd_bits;
-	int			start_level;
-	int			bits_per_level;
-
-	void			*pgd;
-};
-
-typedef u64 arm_lpae_iopte;
-
-static inline bool iopte_leaf(arm_lpae_iopte pte, int lvl,
-			      enum io_pgtable_fmt fmt)
+bool iopte_leaf(arm_lpae_iopte pte, int lvl, enum io_pgtable_fmt fmt)
 {
 	if (lvl == (ARM_LPAE_MAX_LEVELS - 1) && fmt != ARM_MALI_LPAE)
 		return iopte_type(pte) == ARM_LPAE_PTE_TYPE_PAGE;
 
 	return iopte_type(pte) == ARM_LPAE_PTE_TYPE_BLOCK;
 }
+EXPORT_SYMBOL_GPL(iopte_leaf);
 
 static arm_lpae_iopte paddr_to_iopte(phys_addr_t paddr,
 				     struct arm_lpae_io_pgtable *data)
@@ -165,8 +127,8 @@ static arm_lpae_iopte paddr_to_iopte(phys_addr_t paddr,
 	return (pte | (pte >> (48 - 12))) & ARM_LPAE_PTE_ADDR_MASK;
 }
 
-static phys_addr_t iopte_to_paddr(arm_lpae_iopte pte,
-				  struct arm_lpae_io_pgtable *data)
+phys_addr_t iopte_to_paddr(arm_lpae_iopte pte,
+			   struct arm_lpae_io_pgtable *data)
 {
 	u64 paddr = pte & ARM_LPAE_PTE_ADDR_MASK;
 
@@ -176,6 +138,7 @@ static phys_addr_t iopte_to_paddr(arm_lpae_iopte pte,
 	/* Rotate the packed high-order bits back to the top */
 	return (paddr | (paddr << (48 - 12))) & (ARM_LPAE_PTE_ADDR_MASK << 4);
 }
+EXPORT_SYMBOL_GPL(iopte_to_paddr);
 
 static bool selftest_running = false;
 
diff --git a/drivers/iommu/io-pgtable-arm.h b/drivers/iommu/io-pgtable-arm.h
index ba7cfdf..45e6d38 100644
--- a/drivers/iommu/io-pgtable-arm.h
+++ b/drivers/iommu/io-pgtable-arm.h
@@ -2,6 +2,8 @@
 #ifndef IO_PGTABLE_ARM_H_
 #define IO_PGTABLE_ARM_H_
 
+#include <linux/io-pgtable.h>
+
 #define ARM_LPAE_TCR_TG0_4K		0
 #define ARM_LPAE_TCR_TG0_64K		1
 #define ARM_LPAE_TCR_TG0_16K		2
@@ -27,4 +29,45 @@
 #define ARM_LPAE_TCR_PS_48_BIT		0x5ULL
 #define ARM_LPAE_TCR_PS_52_BIT		0x6ULL
 
+#define ARM_LPAE_MAX_LEVELS		4
+
+struct arm_lpae_io_pgtable {
+	struct io_pgtable	iop;
+
+	int			pgd_bits;
+	int			start_level;
+	int			bits_per_level;
+
+	void			*pgd;
+};
+
+/* Struct accessors */
+#define io_pgtable_to_data(x)						\
+	container_of((x), struct arm_lpae_io_pgtable, iop)
+
+#define io_pgtable_ops_to_data(x)					\
+	io_pgtable_to_data(io_pgtable_ops_to_pgtable(x))
+
+/* IOPTE accessors */
+#define iopte_deref(pte, d) __va(iopte_to_paddr(pte, d))
+
+/*
+ * Calculate the index at level l used to map virtual address a using the
+ * pagetable in d.
+ */
+#define ARM_LPAE_PGD_IDX(l, d)						\
+	((l) == (d)->start_level ? (d)->pgd_bits - (d)->bits_per_level : 0)
+/*
+ * Calculate the right shift amount to get to the portion describing level l
+ * in a virtual address mapped by the pagetable in d.
+ */
+#define ARM_LPAE_LVL_SHIFT(l, d)						\
+	(((ARM_LPAE_MAX_LEVELS - (l)) * (d)->bits_per_level) +		\
+	ilog2(sizeof(arm_lpae_iopte)))
+
+typedef u64 arm_lpae_iopte;
+
+bool iopte_leaf(arm_lpae_iopte pte, int lvl, enum io_pgtable_fmt fmt);
+phys_addr_t iopte_to_paddr(arm_lpae_iopte pte,
+			   struct arm_lpae_io_pgtable *data);
 #endif /* IO_PGTABLE_ARM_H_ */
-- 
2.8.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
