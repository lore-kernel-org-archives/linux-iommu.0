Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DCB4C433EF
	for <iommu@archiver.kernel.org>; Fri,  3 Jun 2022 11:22:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3554E607D1;
	Fri,  3 Jun 2022 11:22:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WWCXusvMVcJy; Fri,  3 Jun 2022 11:22:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 9B13160BFF;
	Fri,  3 Jun 2022 11:22:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 76556C0039;
	Fri,  3 Jun 2022 11:22:37 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CF110C002D
 for <iommu@lists.linux-foundation.org>; Fri,  3 Jun 2022 11:22:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B01CA416ED
 for <iommu@lists.linux-foundation.org>; Fri,  3 Jun 2022 11:22:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=amd.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gJAP23JSzeKZ for <iommu@lists.linux-foundation.org>;
 Fri,  3 Jun 2022 11:22:34 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7ea9::600])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6FCBE41608
 for <iommu@lists.linux-foundation.org>; Fri,  3 Jun 2022 11:22:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LSc2OBWKApDF4m1/j3b01nRh0qzaE0P2IAfhOCu6fCIv0GzpAPZ+G3nTj+A+q+4VbShgFAwxIugkvCpQFzxk74KuOwpCRCfQJCuAPHqL4Uqcbn7PwQvbRA+PtcQjWO2CWqRvxzVmQ6pN1jSGdBTFhdJdhvfbi55+LbkwttfzPgSakOawZ2vI24Z5y976N7jHQ/SAJYAvBRMq+r+PxmHlqJUSb2Ropn2fsu0+iA8vFuv+nQghJHXEmYqKxcBouaeb9mv471VbKqgBYf0EUE9FFVj1ivo1RNF2qa/c5yx3xqzu3zF8tHSv6nhUNicrJZgosaViUaAXsFByXMUAVbh+QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kHr33XE2m2j2LsguVdzMfNKa975oSkwsaedgTFgnrmI=;
 b=K+7YGsXXt6h6EglDVrUYsE4FZhNPZBf+szrLNzvhZDylBoVdu2H6f63M1mOnGiEob+N7okuqU4agJj82O7ytXYwe2kjajEqGLK+uNxsO+TfExdgXnK0U5ljt3EN7yizLDG6IcmjubMHg3/O4LMtXQAcw3nBi3z23/uZgGnwA1n8eZM4xGLmk6iLkdgCQin68l2BBO5i9qbkdiYKUhEY+Iyn+n9KnAgaXMtAWvsg5mUidcV7Ekraq3hf/dR3s6Fo3H8Xc2RAj1YeB7VBtsUEn368uR52vz+ia84NZZ7+mzhrW+Kd/qBNnvWmGPDlzp9DvVmlWFulK+KH2AIO0W4hDtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux-foundation.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kHr33XE2m2j2LsguVdzMfNKa975oSkwsaedgTFgnrmI=;
 b=GUx3nHoCXe8PVO6qmKSoF6LUQyZxVyEnXOg1zf/p42Q1nWq1P/GMogQchHjp6wZVJOx2sfe9CLAQY8i0xF3HXmcki6RHKUkJ1/PlOUw8WFQ9p7LeRDCEaYewukQuhjJ9SvXRdERtVktbbSInRngV5Xg4MqGyKtOu1kgtZlHfIM4=
Received: from DM6PR17CA0030.namprd17.prod.outlook.com (2603:10b6:5:1b3::43)
 by BYAPR12MB2728.namprd12.prod.outlook.com (2603:10b6:a03:61::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.13; Fri, 3 Jun
 2022 11:22:32 +0000
Received: from DM6NAM11FT030.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1b3:cafe::2c) by DM6PR17CA0030.outlook.office365.com
 (2603:10b6:5:1b3::43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.13 via Frontend
 Transport; Fri, 3 Jun 2022 11:22:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT030.mail.protection.outlook.com (10.13.172.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5314.12 via Frontend Transport; Fri, 3 Jun 2022 11:22:31 +0000
Received: from kali.amdval.net (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 3 Jun
 2022 06:22:29 -0500
To: <iommu@lists.linux-foundation.org>
Subject: [PATCH v1 4/7] iommu/amd: Initial support for AMD IOMMU v2 page table
Date: Fri, 3 Jun 2022 16:51:04 +0530
Message-ID: <20220603112107.8603-5-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220603112107.8603-1-vasant.hegde@amd.com>
References: <20220603112107.8603-1-vasant.hegde@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e34d8002-2d5f-42ca-1fc3-08da455359d5
X-MS-TrafficTypeDiagnostic: BYAPR12MB2728:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB2728CF8702859F72A86E16D687A19@BYAPR12MB2728.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JdOvJyp0RjIEQNr2Llm99f/j2wz4dUmzHb2QU16L55qjX53pjT0NRp7PFklzusZZx4ZLNJBDxSQ2YnKWMaSY70kq+GX2RoUJCzOFypX9cVlvWXSsQaFt7Ybyj7JHbBmr2VbKYuq6WtbbSp4udKMkQWXpvv4LoIOrtCwFFtN2dBP371+WRcAAp7LaEoV4Vi3cJCK0AXYamYQNIqGkRCYOu6SF/rMCPCT39fHxlQh6Mkp/610HLpsq9S6ckhDX0prhyBsJlsmyXtfI503N9A+fNtIgR8ZRdB0R0Aqg3a03vE/eQoqubMULqcOxkMWf+inuH0dUY3EJSOKI6GE/9oBwB2GRO4fNoQENBnrl+KQ8aDA/mpFAUoUuj70QNrOLujYOmlG49DOfUZdyrQ3U10n92kFMkiVg75O2InRWxF8gCvnsdd8Dj3CzDP2ZmFXXkg8dKcLubHDrAeP5+lVA3n/gMVAaMbqMao7G14zot2a8hQvA+dvJRgmrLPfmzydWVjkOSDK0G/pC/wX+9YiNvEZ05rp3LcfKRgmSCBVxelokzZ8h1kNEopZz/mB1xC+9b3kiHj5LBeaf5ffEnKK+esIagxHIIf2v0ajOesblqCB8epAAIkx05xUU2Dil0EIoJddeIACgT/D+RFPVCzu3mpKC9nQ119l26f6SHsfGqY1DSvwjd4hwVb6SE9jzdaiFeUKlaykz5DiKxrsQrLGZNpJRWg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(30864003)(508600001)(44832011)(5660300002)(26005)(86362001)(40460700003)(6666004)(36860700001)(81166007)(356005)(186003)(8936002)(82310400005)(16526019)(47076005)(2616005)(336012)(426003)(1076003)(2906002)(8676002)(83380400001)(70586007)(36756003)(4326008)(316002)(70206006)(6916009)(54906003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2022 11:22:31.7150 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e34d8002-2d5f-42ca-1fc3-08da455359d5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT030.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2728
Cc: Vasant Hegde <vasant.hegde@amd.com>
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
From: Vasant Hegde via iommu <iommu@lists.linux-foundation.org>
Reply-To: Vasant Hegde <vasant.hegde@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Introduce IO page table framework support for AMD IOMMU v2 page table.
This patch implements 4 level page table within iommu amd driver and
supports 4K/2M/1G page sizes.

Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/Makefile          |   2 +-
 drivers/iommu/amd/amd_iommu_types.h |   5 +-
 drivers/iommu/amd/io_pgtable_v2.c   | 407 ++++++++++++++++++++++++++++
 drivers/iommu/io-pgtable.c          |   1 +
 include/linux/io-pgtable.h          |   2 +
 5 files changed, 415 insertions(+), 2 deletions(-)
 create mode 100644 drivers/iommu/amd/io_pgtable_v2.c

diff --git a/drivers/iommu/amd/Makefile b/drivers/iommu/amd/Makefile
index a935f8f4b974..773d8aa00283 100644
--- a/drivers/iommu/amd/Makefile
+++ b/drivers/iommu/amd/Makefile
@@ -1,4 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0-only
-obj-$(CONFIG_AMD_IOMMU) += iommu.o init.o quirks.o io_pgtable.o
+obj-$(CONFIG_AMD_IOMMU) += iommu.o init.o quirks.o io_pgtable.o io_pgtable_v2.o
 obj-$(CONFIG_AMD_IOMMU_DEBUGFS) += debugfs.o
 obj-$(CONFIG_AMD_IOMMU_V2) += iommu_v2.o
diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 328572cf6fa5..4062313a2407 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -268,6 +268,8 @@
  * 512GB Pages are not supported due to a hardware bug
  */
 #define AMD_IOMMU_PGSIZES	((~0xFFFUL) & ~(2ULL << 38))
+/* 4K, 2MB, 1G page sizes are supported */
+#define AMD_IOMMU_PGSIZES_V2	(PAGE_SIZE | (1ULL << 21) | (1ULL << 30))
 
 /* Bit value definition for dte irq remapping fields*/
 #define DTE_IRQ_PHYS_ADDR_MASK	(((1ULL << 45)-1) << 6)
@@ -514,7 +516,8 @@ struct amd_io_pgtable {
 	struct io_pgtable	iop;
 	int			mode;
 	u64			*root;
-	atomic64_t		pt_root;    /* pgtable root and pgtable mode */
+	atomic64_t		pt_root;	/* pgtable root and pgtable mode */
+	u64			*pgd;		/* v2 pgtable pgd pointer */
 };
 
 /*
diff --git a/drivers/iommu/amd/io_pgtable_v2.c b/drivers/iommu/amd/io_pgtable_v2.c
new file mode 100644
index 000000000000..4248a182a780
--- /dev/null
+++ b/drivers/iommu/amd/io_pgtable_v2.c
@@ -0,0 +1,407 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * CPU-agnostic AMD IO page table v2 allocator.
+ *
+ * Copyright (C) 2022 Advanced Micro Devices, Inc.
+ * Author: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
+ * Author: Vasant Hegde <vasant.hegde@amd.com>
+ */
+
+#define pr_fmt(fmt)	"AMD-Vi: " fmt
+#define dev_fmt(fmt)	pr_fmt(fmt)
+
+#include <linux/bitops.h>
+#include <linux/io-pgtable.h>
+#include <linux/kernel.h>
+
+#include <asm/barrier.h>
+
+#include "amd_iommu_types.h"
+#include "amd_iommu.h"
+
+#define IOMMU_PAGE_PRESENT	BIT_ULL(0)	/* Is present */
+#define IOMMU_PAGE_RW		BIT_ULL(1)	/* Writeable */
+#define IOMMU_PAGE_USER		BIT_ULL(2)	/* Userspace addressable */
+#define IOMMU_PAGE_PWT		BIT_ULL(3)	/* Page write through */
+#define IOMMU_PAGE_PCD		BIT_ULL(4)	/* Page cache disabled */
+#define IOMMU_PAGE_ACCESS	BIT_ULL(5)	/* Was accessed (updated by IOMMU) */
+#define IOMMU_PAGE_DIRTY	BIT_ULL(6)	/* Was written to (updated by IOMMU) */
+#define IOMMU_PAGE_PSE		BIT_ULL(7)	/* Page Size Extensions */
+#define IOMMU_PAGE_NX		BIT_ULL(63)	/* No execute */
+
+#define MAX_PTRS_PER_PAGE	512
+
+#define IOMMU_PAGE_SIZE_2M	BIT_ULL(21)
+#define IOMMU_PAGE_SIZE_1G	BIT_ULL(30)
+
+
+static inline int get_pgtable_level(void)
+{
+	/* 5 level page table is not supported */
+	return PAGE_MODE_4_LEVEL;
+}
+
+static inline bool is_large_pte(u64 pte)
+{
+	return (pte & IOMMU_PAGE_PSE);
+}
+
+static inline void *alloc_pgtable_page(void)
+{
+	return (void *)get_zeroed_page(GFP_KERNEL);
+}
+
+static inline u64 set_pgtable_attr(u64 *page)
+{
+	u64 prot;
+
+	prot = IOMMU_PAGE_PRESENT | IOMMU_PAGE_RW | IOMMU_PAGE_USER;
+	prot |= IOMMU_PAGE_ACCESS | IOMMU_PAGE_DIRTY;
+
+	return (iommu_virt_to_phys(page) | prot);
+}
+
+static inline void *get_pgtable_pte(u64 pte)
+{
+	return iommu_phys_to_virt(pte & PM_ADDR_MASK);
+}
+
+static u64 set_pte_attr(u64 paddr, u64 pg_size, int prot)
+{
+	u64 pte;
+
+	pte = __sme_set(paddr & PM_ADDR_MASK);
+	pte |= IOMMU_PAGE_PRESENT | IOMMU_PAGE_USER;
+	pte |= IOMMU_PAGE_ACCESS | IOMMU_PAGE_DIRTY;
+
+	if (prot & IOMMU_PROT_IW)
+		pte |= IOMMU_PAGE_RW;
+
+	/* Large page */
+	if (pg_size == IOMMU_PAGE_SIZE_1G || pg_size == IOMMU_PAGE_SIZE_2M)
+		pte |= IOMMU_PAGE_PSE;
+
+	return pte;
+}
+
+static inline u64 get_alloc_page_size(u64 size)
+{
+	if (size >= IOMMU_PAGE_SIZE_1G)
+		return IOMMU_PAGE_SIZE_1G;
+
+	if (size >= IOMMU_PAGE_SIZE_2M)
+		return IOMMU_PAGE_SIZE_2M;
+
+	return PAGE_SIZE;
+}
+
+static inline int page_size_to_level(u64 pg_size)
+{
+	if (pg_size == IOMMU_PAGE_SIZE_1G)
+		return PAGE_MODE_3_LEVEL;
+	if (pg_size == IOMMU_PAGE_SIZE_2M)
+		return PAGE_MODE_2_LEVEL;
+
+	return PAGE_MODE_1_LEVEL;
+}
+
+static inline void free_pgtable_page(u64 *pt)
+{
+	free_page((unsigned long)pt);
+}
+
+static void free_pgtable(u64 *pt, int level)
+{
+	u64 *p;
+	int i;
+
+	for (i = 0; i < MAX_PTRS_PER_PAGE; i++) {
+		/* PTE present? */
+		if (!IOMMU_PTE_PRESENT(pt[i]))
+			continue;
+
+		if (is_large_pte(pt[i]))
+			continue;
+
+		/*
+		 * Free the next level. No need to look at l1 tables here since
+		 * they can only contain leaf PTEs; just free them directly.
+		 */
+		p = get_pgtable_pte(pt[i]);
+		if (level > 2)
+			free_pgtable(p, level - 1);
+		else
+			free_pgtable_page(p);
+	}
+
+	free_pgtable_page(pt);
+}
+
+/* Allocate page table */
+static u64 *v2_alloc_pte(u64 *pgd, unsigned long iova,
+			 unsigned long pg_size, bool *updated)
+{
+	u64 *pte, *page;
+	int level, end_level;
+
+	BUG_ON(!is_power_of_2(pg_size));
+
+	level = get_pgtable_level() - 1;
+	end_level = page_size_to_level(pg_size);
+	pte = &pgd[PM_LEVEL_INDEX(level, iova)];
+	iova = PAGE_SIZE_ALIGN(iova, PAGE_SIZE);
+
+	while (level >= end_level) {
+		u64 __pte, __npte;
+
+		__pte = *pte;
+
+		if (IOMMU_PTE_PRESENT(__pte) && is_large_pte(__pte)) {
+			/* Unmap large pte */
+			cmpxchg64(pte, *pte, 0ULL);
+			*updated = true;
+			continue;
+		}
+
+		if (!IOMMU_PTE_PRESENT(__pte)) {
+			page = alloc_pgtable_page();
+			if (!page)
+				return NULL;
+
+			__npte = set_pgtable_attr(page);
+			/* pte could have been changed somewhere. */
+			if (cmpxchg64(pte, __pte, __npte) != __pte)
+				free_pgtable_page(page);
+			else if (IOMMU_PTE_PRESENT(__pte))
+				*updated = true;
+
+			continue;
+		}
+
+		level -= 1;
+		pte = get_pgtable_pte(__pte);
+		pte = &pte[PM_LEVEL_INDEX(level, iova)];
+	}
+
+	/* Tear down existing pte entries */
+	if (IOMMU_PTE_PRESENT(*pte)) {
+		u64 *__pte;
+
+		*updated = true;
+		__pte = get_pgtable_pte(*pte);
+		cmpxchg64(pte, *pte, 0ULL);
+		if (pg_size == IOMMU_PAGE_SIZE_1G)
+			free_pgtable(__pte, end_level - 1);
+		else if (pg_size == IOMMU_PAGE_SIZE_2M)
+			free_pgtable_page(__pte);
+	}
+
+	return pte;
+}
+
+/*
+ * This function checks if there is a PTE for a given dma address.
+ * If there is one, it returns the pointer to it.
+ */
+static u64 *fetch_pte(struct amd_io_pgtable *pgtable,
+		      unsigned long iova, unsigned long *page_size)
+{
+	u64 *pte;
+	int level;
+
+	level = get_pgtable_level() - 1;
+	pte = &pgtable->pgd[PM_LEVEL_INDEX(level, iova)];
+	/* Default page size is 4K */
+	*page_size = PAGE_SIZE;
+
+	while (level) {
+		/* Not present */
+		if (!IOMMU_PTE_PRESENT(*pte))
+			return NULL;
+
+		/* Walk to the next level */
+		pte = get_pgtable_pte(*pte);
+		pte = &pte[PM_LEVEL_INDEX(level - 1, iova)];
+
+		/* Large page */
+		if (is_large_pte(*pte)) {
+			if (level == PAGE_MODE_3_LEVEL)
+				*page_size = IOMMU_PAGE_SIZE_1G;
+			else if (level == PAGE_MODE_2_LEVEL)
+				*page_size = IOMMU_PAGE_SIZE_2M;
+			else
+				return NULL;	/* Wrongly set PSE bit in PTE */
+
+			break;
+		}
+
+		level -= 1;
+	}
+
+	return pte;
+}
+
+static int iommu_v2_map_page(struct io_pgtable_ops *ops, unsigned long iova,
+			     phys_addr_t paddr, size_t size, int prot, gfp_t gfp)
+{
+	struct protection_domain *pdom = io_pgtable_ops_to_domain(ops);
+	u64 *pte;
+	unsigned long map_size;
+	unsigned long mapped_size = 0;
+	unsigned long o_iova = iova;
+	int count = 0;
+	int ret = 0;
+	bool updated = false;
+
+	BUG_ON(!IS_ALIGNED(iova, size) || !IS_ALIGNED(paddr, size));
+
+	if (!(prot & IOMMU_PROT_MASK))
+		return -EINVAL;
+
+	while (mapped_size < size) {
+		map_size = get_alloc_page_size(size - mapped_size);
+		pte = v2_alloc_pte(pdom->iop.pgd, iova, map_size, &updated);
+		if (!pte) {
+			ret = -EINVAL;
+			goto out;
+		}
+
+		*pte = set_pte_attr(paddr, map_size, prot);
+
+		count++;
+		iova += map_size;
+		paddr += map_size;
+		mapped_size += map_size;
+	}
+
+out:
+	if (updated) {
+		if (count > 1)
+			amd_iommu_flush_tlb(&pdom->domain, 0);
+		else
+			amd_iommu_flush_page(&pdom->domain, 0, o_iova);
+	}
+
+	return ret;
+}
+
+static unsigned long iommu_v2_unmap_page(struct io_pgtable_ops *ops,
+					 unsigned long iova, size_t size,
+					 struct iommu_iotlb_gather *gather)
+{
+	struct amd_io_pgtable *pgtable = io_pgtable_ops_to_data(ops);
+	unsigned long unmap_size;
+	unsigned long unmapped = 0;
+	u64 *pte;
+
+	BUG_ON(!is_power_of_2(size));
+
+	while (unmapped < size) {
+		pte = fetch_pte(pgtable, iova, &unmap_size);
+		if (pte) {
+			*pte = 0ULL;
+		}
+
+		iova = (iova & ~(unmap_size - 1)) + unmap_size;
+		unmapped += unmap_size;
+	}
+
+	BUG_ON(unmapped && !is_power_of_2(unmapped));
+
+	return unmapped;
+}
+
+static phys_addr_t iommu_v2_iova_to_phys(struct io_pgtable_ops *ops, unsigned long iova)
+{
+	struct amd_io_pgtable *pgtable = io_pgtable_ops_to_data(ops);
+	unsigned long offset_mask, pte_pgsize;
+	u64 *pte, __pte;
+
+	pte = fetch_pte(pgtable, iova, &pte_pgsize);
+	if (!pte || !IOMMU_PTE_PRESENT(*pte))
+		return 0;
+
+	offset_mask = pte_pgsize - 1;
+	__pte = __sme_clr(*pte & PM_ADDR_MASK);
+
+	return (__pte & ~offset_mask) | (iova & offset_mask);
+}
+
+/*
+ * ----------------------------------------------------
+ */
+static void v2_tlb_flush_all(void *cookie)
+{
+}
+
+static void v2_tlb_flush_walk(unsigned long iova, size_t size,
+			      size_t granule, void *cookie)
+{
+}
+
+static void v2_tlb_add_page(struct iommu_iotlb_gather *gather,
+			    unsigned long iova, size_t granule,
+			    void *cookie)
+{
+}
+
+static const struct iommu_flush_ops v2_flush_ops = {
+	.tlb_flush_all	= v2_tlb_flush_all,
+	.tlb_flush_walk = v2_tlb_flush_walk,
+	.tlb_add_page	= v2_tlb_add_page,
+};
+
+static void v2_free_pgtable(struct io_pgtable *iop)
+{
+	struct protection_domain *pdom;
+	struct amd_io_pgtable *pgtable = container_of(iop, struct amd_io_pgtable, iop);
+
+	pdom = container_of(pgtable, struct protection_domain, iop);
+	if (!(pdom->flags & PD_IOMMUV2_MASK))
+		return;
+
+	/*
+	 * Make changes visible to IOMMUs. No need to clear gcr3 entry
+	 * as gcr3 table is already freed.
+	 */
+	amd_iommu_domain_update(pdom);
+
+	/* Free page table */
+	free_pgtable(pgtable->pgd, get_pgtable_level());
+}
+
+static struct io_pgtable *v2_alloc_pgtable(struct io_pgtable_cfg *cfg, void *cookie)
+{
+	struct amd_io_pgtable *pgtable = io_pgtable_cfg_to_data(cfg);
+	struct protection_domain *pdom = (struct protection_domain *)cookie;
+	int ret;
+
+	pgtable->pgd = alloc_pgtable_page();
+	if (!pgtable->pgd)
+		return NULL;
+
+	ret = amd_iommu_domain_set_gcr3(&pdom->domain, 0, iommu_virt_to_phys(pgtable->pgd));
+	if (ret)
+		goto err_free_pgd;
+
+	pgtable->iop.ops.map          = iommu_v2_map_page;
+	pgtable->iop.ops.unmap        = iommu_v2_unmap_page;
+	pgtable->iop.ops.iova_to_phys = iommu_v2_iova_to_phys;
+
+	cfg->pgsize_bitmap = AMD_IOMMU_PGSIZES_V2,
+	cfg->ias           = IOMMU_IN_ADDR_BIT_SIZE,
+	cfg->oas           = IOMMU_OUT_ADDR_BIT_SIZE,
+	cfg->tlb           = &v2_flush_ops;
+
+	return &pgtable->iop;
+
+err_free_pgd:
+	free_pgtable_page(pgtable->pgd);
+
+	return NULL;
+}
+
+struct io_pgtable_init_fns io_pgtable_amd_iommu_v2_init_fns = {
+	.alloc	= v2_alloc_pgtable,
+	.free	= v2_free_pgtable,
+};
diff --git a/drivers/iommu/io-pgtable.c b/drivers/iommu/io-pgtable.c
index f4bfcef98297..ac02a45ed798 100644
--- a/drivers/iommu/io-pgtable.c
+++ b/drivers/iommu/io-pgtable.c
@@ -27,6 +27,7 @@ io_pgtable_init_table[IO_PGTABLE_NUM_FMTS] = {
 #endif
 #ifdef CONFIG_AMD_IOMMU
 	[AMD_IOMMU_V1] = &io_pgtable_amd_iommu_v1_init_fns,
+	[AMD_IOMMU_V2] = &io_pgtable_amd_iommu_v2_init_fns,
 #endif
 };
 
diff --git a/include/linux/io-pgtable.h b/include/linux/io-pgtable.h
index 86af6f0a00a2..dc0f50bbdfa9 100644
--- a/include/linux/io-pgtable.h
+++ b/include/linux/io-pgtable.h
@@ -16,6 +16,7 @@ enum io_pgtable_fmt {
 	ARM_V7S,
 	ARM_MALI_LPAE,
 	AMD_IOMMU_V1,
+	AMD_IOMMU_V2,
 	APPLE_DART,
 	IO_PGTABLE_NUM_FMTS,
 };
@@ -255,6 +256,7 @@ extern struct io_pgtable_init_fns io_pgtable_arm_64_lpae_s2_init_fns;
 extern struct io_pgtable_init_fns io_pgtable_arm_v7s_init_fns;
 extern struct io_pgtable_init_fns io_pgtable_arm_mali_lpae_init_fns;
 extern struct io_pgtable_init_fns io_pgtable_amd_iommu_v1_init_fns;
+extern struct io_pgtable_init_fns io_pgtable_amd_iommu_v2_init_fns;
 extern struct io_pgtable_init_fns io_pgtable_apple_dart_init_fns;
 
 #endif /* __IO_PGTABLE_H */
-- 
2.27.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
