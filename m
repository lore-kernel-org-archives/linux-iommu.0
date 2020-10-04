Return-Path: <SRS0=qGVY=DL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23C74C47420
	for <iommu@archiver.kernel.org>; Sun,  4 Oct 2020 01:42:07 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA5ED206A5
	for <iommu@archiver.kernel.org>; Sun,  4 Oct 2020 01:42:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="B82u95p2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA5ED206A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id B1B1E85569;
	Sun,  4 Oct 2020 01:42:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VgYbzFLCsQDo; Sun,  4 Oct 2020 01:42:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id BE602854D0;
	Sun,  4 Oct 2020 01:42:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AEA66C0895;
	Sun,  4 Oct 2020 01:42:04 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7A674C0051
 for <iommu@lists.linux-foundation.org>; Sun,  4 Oct 2020 01:42:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 752A12033B
 for <iommu@lists.linux-foundation.org>; Sun,  4 Oct 2020 01:42:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id aIqa05gCzGA5 for <iommu@lists.linux-foundation.org>;
 Sun,  4 Oct 2020 01:42:00 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2058.outbound.protection.outlook.com [40.107.93.58])
 by silver.osuosl.org (Postfix) with ESMTPS id 0A9B8203E7
 for <iommu@lists.linux-foundation.org>; Sun,  4 Oct 2020 01:42:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AJDCPYtA+1ELQWNGl5TRBnOdCrw2RKnYJILZkbBZAhnSHq6pTiywi9b0csukeiyQ2LImW2lWeQEkyA/JTwReYxCnPNckrM6TfdEjxEddqmCAxHevtkhrzp09z23Syg6nSZ/5LDvqnS2HPXCWYnwG7Gq3zQwg8LtYHZqo6kKCSi39tsLAXuBcVWaDedlFSDxcHN/Ed3eXj4r8bLiLMRG2vPH4lM3E18ApxOIm/EDCShxRqjkyWoVn4UqzOG59cg77guuMyigHngLYxMHO28OTYSLQwHgaL+AzKbnVYgO0RxiCbsTPOmxymFQz6LER03BiZp5rT3YxYIbSw51cFhMHMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+ye6EVW760IjaRQaUxKr9shJ+0Yua7JywTDih7BmGnU=;
 b=dqMUHkzwUiBwn6fSeWMiiKsx2UfwxBawp15N6ESMBD+vmDOoQ0yXMWUqcBYQHje1mt4DmS3Cx6sinCShI+/7/kmkUD1Q8Hqq7qjiiQJUZmIwkAArDk+olsnlatrzW3eoUxoFViM9et9k2DlBGoJmpb9QHmqV19yrLErcoEAyBPNYDudGjKG8csUrjuQmLY7rP1Z8gNEB7JrZeGaAUxTyQznBv7Thp/lY4jQ6yq9ns8HtK1Rpu+C0h7+x/a5OolhiCxJe0yPOK+dxJhngMXcFZaL2U8Ls/qObJkHYDBURaiIZhh44i9gkI1Oh5r1sklI8BxQLpwlknAMjFt+K3GC4Gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+ye6EVW760IjaRQaUxKr9shJ+0Yua7JywTDih7BmGnU=;
 b=B82u95p2I9jifznuu2lOcsqGqXia9Co3O81f5FcmGYFnCVJBfRYnXbmD923e861bhEqLfUW9wimcs/zgAc8ceqyZw/vDrM9u2zqXsw+YjCHd//aiG6EMsE/WWVO2yEH2YQEkTR0anO1w/yr56oMmGzLrjUHTwhAh8qDjE7qw0Rs=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1163.namprd12.prod.outlook.com (2603:10b6:3:7a::18) by
 DM5PR12MB1451.namprd12.prod.outlook.com (2603:10b6:4:d::12) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3433.39; Sun, 4 Oct 2020 01:41:55 +0000
Received: from DM5PR12MB1163.namprd12.prod.outlook.com
 ([fe80::48cf:d69:d457:1b1e]) by DM5PR12MB1163.namprd12.prod.outlook.com
 ([fe80::48cf:d69:d457:1b1e%5]) with mapi id 15.20.3433.042; Sun, 4 Oct 2020
 01:41:55 +0000
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: linux-kernel@vger.kernel.org,
	iommu@lists.linux-foundation.org
Subject: [PATCH v3 02/14] iommu/amd: Prepare for generic IO page table
 framework
Date: Sun,  4 Oct 2020 01:45:37 +0000
Message-Id: <20201004014549.16065-3-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201004014549.16065-1-suravee.suthikulpanit@amd.com>
References: <20201004014549.16065-1-suravee.suthikulpanit@amd.com>
X-Originating-IP: [165.204.78.2]
X-ClientProxiedBy: SN4PR0701CA0004.namprd07.prod.outlook.com
 (2603:10b6:803:28::14) To DM5PR12MB1163.namprd12.prod.outlook.com
 (2603:10b6:3:7a::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ethanolx5673host.amd.com (165.204.78.2) by
 SN4PR0701CA0004.namprd07.prod.outlook.com (2603:10b6:803:28::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.34 via Frontend
 Transport; Sun, 4 Oct 2020 01:41:54 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b69245c1-f8b4-4a0d-95ca-08d86806acf0
X-MS-TrafficTypeDiagnostic: DM5PR12MB1451:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB14512226F742D832A3B8E10AF30F0@DM5PR12MB1451.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8QwUTcE8Nac5U3CvT5wM0qkmaaWNvHG2VswKah9SOJf3F/avKND83z49B42eyw3RzoOO4Zh5l8Iii1iB9E3qoDkhelLRSDtC2v/ha/IAbK2/98prv3yAyEvDVTmDQURTrx0Mvv8NiMawCukzq3i3RLula+rQyHnK6mzyE2km6LD4EWFHA6jJV4WNXMmztSdYP44elXwNkEZPW/pXx4IRmMEe+Rg5PxoiXEWy6dhUkBwN9dxYXlOXfs3d8S69QDZ8cMWFwf87g9dCptQUtBf3o5v7+XbMCN+Pb/51DcUWYDSm6dv292/Wss9cTJURk9+mLUWprRroLX0Ftm2moLZUgVGSgtdqZyGcBZjsx7OIs8rBWCBwvjq6S6i31NLOAIWz
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1163.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(346002)(376002)(136003)(366004)(39850400004)(2616005)(956004)(6486002)(316002)(66946007)(66476007)(66556008)(6666004)(478600001)(44832011)(1076003)(5660300002)(86362001)(8936002)(7696005)(52116002)(2906002)(36756003)(16526019)(26005)(186003)(4326008)(83380400001)(8676002)(41533002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: p3hhVNchN/SLtcJKhtCrXP3LNUgT8cbEZtc+mXc2t0qYN8ZKMFgWopSKbVsXulIh75ZC3O+X01nkrvcNeVmmMqzUkWilcqMfUmrveHeu65LD00NvLl790s1c5MhU2etBUtpFRX0YA0txi4TiFa25+7afHsWn2zpY7Bwr0tYL/nmyTlbRP5ZZMuEawtX3ujrjeJQ+kqrCIBNkpzI+1Dv0k+iQt9kB8eB8kHUAg8pOSPILVfkHddql41brZBPFsckxx94oouYl/SiZOCKB+3/fIuj2Tf8ao2xLySrTM0GdBh+OJiRP3jJznaSzwQ0ayqS/4f7qvUeSmIwqR8gjXt4hLvMFuNbahkM1maOzbrKyUhCs7xic3HFf1qaeQnLYNXA0AikWsIo820h/MsMPBfgD1cAxEupSacpez2amlYYYWtcsfZaPrX0sICxNLrKvj5oUyQ+edG46mwvnaEXz96ZNkd/lWB5X8Q7lCy+y8mLyzCLhqhTPH+b0gkabyQL8a7M5mTiLR2oA8L6hdQW6E3VTqK9rJMhmhULSw9BtasAZreYTKveRXbAGdmfJEu/k2WUSPrNckJBO22iwNSfXZmtjjDYqyre39uxKw4SSIk8S0zGQ4Z9py3iAfrfcVgHqmgwbI9UOqJA+nyyO3PIuDXlVxA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b69245c1-f8b4-4a0d-95ca-08d86806acf0
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1163.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2020 01:41:55.5414 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o8bSnvAdS3IZdK3YrYFcAVrQ+PuMVSca+HvNrCbSDIyBj4xFcOOV+Sz6Tq7SIcr7+5zQG2jRuXJb62moc/ISpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1451
Cc: robin.murphy@arm.com
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

Add initial hook up code to implement generic IO page table framework.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/Kconfig           |  1 +
 drivers/iommu/amd/Makefile          |  2 +-
 drivers/iommu/amd/amd_iommu_types.h | 35 +++++++++++++++++++++++
 drivers/iommu/amd/io_pgtable.c      | 43 +++++++++++++++++++++++++++++
 drivers/iommu/amd/iommu.c           | 10 -------
 drivers/iommu/io-pgtable.c          |  3 ++
 include/linux/io-pgtable.h          |  2 ++
 7 files changed, 85 insertions(+), 11 deletions(-)
 create mode 100644 drivers/iommu/amd/io_pgtable.c

diff --git a/drivers/iommu/amd/Kconfig b/drivers/iommu/amd/Kconfig
index 626b97d0dd21..a3cbafb603f5 100644
--- a/drivers/iommu/amd/Kconfig
+++ b/drivers/iommu/amd/Kconfig
@@ -10,6 +10,7 @@ config AMD_IOMMU
 	select IOMMU_API
 	select IOMMU_IOVA
 	select IOMMU_DMA
+	select IOMMU_IO_PGTABLE
 	depends on X86_64 && PCI && ACPI && HAVE_CMPXCHG_DOUBLE
 	help
 	  With this option you can enable support for AMD IOMMU hardware in
diff --git a/drivers/iommu/amd/Makefile b/drivers/iommu/amd/Makefile
index dc5a2fa4fd37..a935f8f4b974 100644
--- a/drivers/iommu/amd/Makefile
+++ b/drivers/iommu/amd/Makefile
@@ -1,4 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0-only
-obj-$(CONFIG_AMD_IOMMU) += iommu.o init.o quirks.o
+obj-$(CONFIG_AMD_IOMMU) += iommu.o init.o quirks.o io_pgtable.o
 obj-$(CONFIG_AMD_IOMMU_DEBUGFS) += debugfs.o
 obj-$(CONFIG_AMD_IOMMU_V2) += iommu_v2.o
diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index f696ac7c5f89..e3ac3e57e507 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -15,6 +15,7 @@
 #include <linux/spinlock.h>
 #include <linux/pci.h>
 #include <linux/irqreturn.h>
+#include <linux/io-pgtable.h>
 
 /*
  * Maximum number of IOMMUs supported
@@ -252,6 +253,19 @@
 
 #define GA_GUEST_NR		0x1
 
+#define IOMMU_IN_ADDR_BIT_SIZE  52
+#define IOMMU_OUT_ADDR_BIT_SIZE 52
+
+/*
+ * This bitmap is used to advertise the page sizes our hardware support
+ * to the IOMMU core, which will then use this information to split
+ * physically contiguous memory regions it is mapping into page sizes
+ * that we support.
+ *
+ * 512GB Pages are not supported due to a hardware bug
+ */
+#define AMD_IOMMU_PGSIZES	((~0xFFFUL) & ~(2ULL << 38))
+
 /* Bit value definition for dte irq remapping fields*/
 #define DTE_IRQ_PHYS_ADDR_MASK	(((1ULL << 45)-1) << 6)
 #define DTE_IRQ_REMAP_INTCTL_MASK	(0x3ULL << 60)
@@ -461,6 +475,26 @@ struct amd_irte_ops;
 
 #define AMD_IOMMU_FLAG_TRANS_PRE_ENABLED      (1 << 0)
 
+#define io_pgtable_to_data(x) \
+	container_of((x), struct amd_io_pgtable, iop)
+
+#define io_pgtable_ops_to_data(x) \
+	io_pgtable_to_data(io_pgtable_ops_to_pgtable(x))
+
+#define io_pgtable_ops_to_domain(x) \
+	container_of(io_pgtable_ops_to_data(x), \
+		     struct protection_domain, iop)
+
+#define io_pgtable_cfg_to_data(x) \
+	container_of((x), struct amd_io_pgtable, pgtbl_cfg)
+
+struct amd_io_pgtable {
+	struct io_pgtable_cfg	pgtbl_cfg;
+	struct io_pgtable	iop;
+	int			mode;
+	u64			*root;
+};
+
 /*
  * This structure contains generic data for  IOMMU protection domains
  * independent of their use.
@@ -469,6 +503,7 @@ struct protection_domain {
 	struct list_head dev_list; /* List of all devices in this domain */
 	struct iommu_domain domain; /* generic domain handle used by
 				       iommu core code */
+	struct amd_io_pgtable iop;
 	spinlock_t lock;	/* mostly used to lock the page table*/
 	u16 id;			/* the domain id written to the device table */
 	atomic64_t pt_root;	/* pgtable root and pgtable mode */
diff --git a/drivers/iommu/amd/io_pgtable.c b/drivers/iommu/amd/io_pgtable.c
new file mode 100644
index 000000000000..6b2de9e467d9
--- /dev/null
+++ b/drivers/iommu/amd/io_pgtable.c
@@ -0,0 +1,43 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * CPU-agnostic AMD IO page table allocator.
+ *
+ * Copyright (C) 2020 Advanced Micro Devices, Inc.
+ * Author: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
+ */
+
+#define pr_fmt(fmt)     "AMD-Vi: " fmt
+#define dev_fmt(fmt)    pr_fmt(fmt)
+
+#include <linux/atomic.h>
+#include <linux/bitops.h>
+#include <linux/io-pgtable.h>
+#include <linux/kernel.h>
+#include <linux/sizes.h>
+#include <linux/slab.h>
+#include <linux/types.h>
+#include <linux/dma-mapping.h>
+
+#include <asm/barrier.h>
+
+#include "amd_iommu_types.h"
+#include "amd_iommu.h"
+
+/*
+ * ----------------------------------------------------
+ */
+static void v1_free_pgtable(struct io_pgtable *iop)
+{
+}
+
+static struct io_pgtable *v1_alloc_pgtable(struct io_pgtable_cfg *cfg, void *cookie)
+{
+	struct amd_io_pgtable *pgtable = io_pgtable_cfg_to_data(cfg);
+
+	return &pgtable->iop;
+}
+
+struct io_pgtable_init_fns io_pgtable_amd_iommu_v1_init_fns = {
+	.alloc	= v1_alloc_pgtable,
+	.free	= v1_free_pgtable,
+};
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index e92b3f744292..2b7eb51dcbb8 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -59,16 +59,6 @@
 #define HT_RANGE_START		(0xfd00000000ULL)
 #define HT_RANGE_END		(0xffffffffffULL)
 
-/*
- * This bitmap is used to advertise the page sizes our hardware support
- * to the IOMMU core, which will then use this information to split
- * physically contiguous memory regions it is mapping into page sizes
- * that we support.
- *
- * 512GB Pages are not supported due to a hardware bug
- */
-#define AMD_IOMMU_PGSIZES	((~0xFFFUL) & ~(2ULL << 38))
-
 #define DEFAULT_PGTABLE_LEVEL	PAGE_MODE_3_LEVEL
 
 static DEFINE_SPINLOCK(pd_bitmap_lock);
diff --git a/drivers/iommu/io-pgtable.c b/drivers/iommu/io-pgtable.c
index 94394c81468f..6e9917ce980f 100644
--- a/drivers/iommu/io-pgtable.c
+++ b/drivers/iommu/io-pgtable.c
@@ -24,6 +24,9 @@ io_pgtable_init_table[IO_PGTABLE_NUM_FMTS] = {
 #ifdef CONFIG_IOMMU_IO_PGTABLE_ARMV7S
 	[ARM_V7S] = &io_pgtable_arm_v7s_init_fns,
 #endif
+#ifdef CONFIG_AMD_IOMMU
+	[AMD_IOMMU_V1] = &io_pgtable_amd_iommu_v1_init_fns,
+#endif
 };
 
 struct io_pgtable_ops *alloc_io_pgtable_ops(enum io_pgtable_fmt fmt,
diff --git a/include/linux/io-pgtable.h b/include/linux/io-pgtable.h
index 23285ba645db..db25d436cabd 100644
--- a/include/linux/io-pgtable.h
+++ b/include/linux/io-pgtable.h
@@ -15,6 +15,7 @@ enum io_pgtable_fmt {
 	ARM_64_LPAE_S2,
 	ARM_V7S,
 	ARM_MALI_LPAE,
+	AMD_IOMMU_V1,
 	IO_PGTABLE_NUM_FMTS,
 };
 
@@ -254,5 +255,6 @@ extern struct io_pgtable_init_fns io_pgtable_arm_64_lpae_s1_init_fns;
 extern struct io_pgtable_init_fns io_pgtable_arm_64_lpae_s2_init_fns;
 extern struct io_pgtable_init_fns io_pgtable_arm_v7s_init_fns;
 extern struct io_pgtable_init_fns io_pgtable_arm_mali_lpae_init_fns;
+extern struct io_pgtable_init_fns io_pgtable_amd_iommu_v1_init_fns;
 
 #endif /* __IO_PGTABLE_H */
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
