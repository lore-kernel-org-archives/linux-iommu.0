Return-Path: <SRS0=8938=FT=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEF41C2BB9A
	for <iommu@archiver.kernel.org>; Tue, 15 Dec 2020 07:34:50 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6CEDD222B3
	for <iommu@archiver.kernel.org>; Tue, 15 Dec 2020 07:34:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CEDD222B3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 400AA86C7A;
	Tue, 15 Dec 2020 07:34:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MGCDzJjJ2xOp; Tue, 15 Dec 2020 07:34:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 73EB486C6D;
	Tue, 15 Dec 2020 07:34:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5C4A7C0893;
	Tue, 15 Dec 2020 07:34:49 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 61A3DC013B
 for <iommu@lists.linux-foundation.org>; Tue, 15 Dec 2020 07:34:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 4DB9C86E6B
 for <iommu@lists.linux-foundation.org>; Tue, 15 Dec 2020 07:34:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ocJ4EgZ2VkXK for <iommu@lists.linux-foundation.org>;
 Tue, 15 Dec 2020 07:34:43 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2074.outbound.protection.outlook.com [40.107.236.74])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 50E5586E2D
 for <iommu@lists.linux-foundation.org>; Tue, 15 Dec 2020 07:34:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YtFmXdfozJPckyNnvs723BEORLJA1peNwUsMxrTYeJpJFUxpLGlHQZNjPOniNhybkZm7Kp2KyS678C+JCELA98bfV3cKUOXPNH+sUR/D9MdINoq6z2+HaFqp5MU6SfDcZHEkcxXxNyOCTL8xzTwNse/M46yMhCLASh8pQM6RLsY36YAxeY16LTNKH7QbsaUo1NEElotts1nprA2LRtCOKRtyotD2Auw8qrMEjPojevWOjiGFhDnTV1Wu1J5ERyMYeP8c9AU98i/jhiMI0tjF7nXqKdJfrUu7JmO75BJUiQxn/BfznwwyuGLYsgq7FZtCGbsXVPbFS715zRg2zUchEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wrEI3KE4YTPFYB862EIpkEBKyHGiFjXJsQBpID1sVmg=;
 b=OjmOD2+VheE2sJhbEDS/dIy4k7GVodIxXiX8gZqHze+yLMeJzo2ZndhsxEVd0JpqxP+N2t9wvNdtv0hrEWtqRnU01Yvc04sHzcAgHxNuEyRZ9XFQ2OjwKu9Y4zMmcapytezSnH5aeo3ZbyqRPf4JVT1Dq9pX0Yz9Q5mdi8uO9GByCgk1JL+dpPx0b5AagPVbcYQmcR/gcCjbGPsIAv6U0FdUsS2Lrn0vOBdah2JygHtopmQY2IBkN0DSz8FHiqelITChEOyKxSng9U7ZjX9fJA1NCOROpbP1DN+5gB2ieYfm6D8exFdD6LRhFKq8or3CmChZkTumSxR6YqT2fQsoHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wrEI3KE4YTPFYB862EIpkEBKyHGiFjXJsQBpID1sVmg=;
 b=tKKDHVW2OQEkOHmUTrwMUH/+wLh0fk8LHTuf6UmXBMdPzfz93299vRCbBRRVb+N19FXksBmCDUGvknyozD4BQkq+yOeWUot/76X3SZGpUfK7HnKsXQiN7EFeOJIShOgZT4yE9IlmzyZ/gpo3yCQKYE6YGbSZuzc7l2yO1ScOhtc=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4597.namprd12.prod.outlook.com (2603:10b6:a03:10b::14)
 by BY5PR12MB3794.namprd12.prod.outlook.com (2603:10b6:a03:1aa::28)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.12; Tue, 15 Dec
 2020 07:34:39 +0000
Received: from BYAPR12MB4597.namprd12.prod.outlook.com
 ([fe80::dd10:efd2:e325:53c7]) by BYAPR12MB4597.namprd12.prod.outlook.com
 ([fe80::dd10:efd2:e325:53c7%3]) with mapi id 15.20.3654.021; Tue, 15 Dec 2020
 07:34:39 +0000
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: linux-kernel@vger.kernel.org,
	iommu@lists.linux-foundation.org
Subject: [PATCH v4 02/13] iommu/amd: Prepare for generic IO page table
 framework
Date: Tue, 15 Dec 2020 01:36:54 -0600
Message-Id: <20201215073705.123786-3-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201215073705.123786-1-suravee.suthikulpanit@amd.com>
References: <20201215073705.123786-1-suravee.suthikulpanit@amd.com>
X-Originating-IP: [165.204.78.2]
X-ClientProxiedBy: SN2PR01CA0060.prod.exchangelabs.com (2603:10b6:800::28) To
 BYAPR12MB4597.namprd12.prod.outlook.com
 (2603:10b6:a03:10b::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ethanolx5673host.amd.com (165.204.78.2) by
 SN2PR01CA0060.prod.exchangelabs.com (2603:10b6:800::28) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3654.12 via Frontend Transport; Tue, 15 Dec 2020 07:34:38 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 75034cf8-70c6-4c9a-b432-08d8a0cbe199
X-MS-TrafficTypeDiagnostic: BY5PR12MB3794:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR12MB379424E82881A7523E5A30E1F3C60@BY5PR12MB3794.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TklhD5MPJLYf0vMLhzruuRJ0QMOFn2JyIHIOPavc0xx7pAIxWsKdxkPfAJIHnhTcjw7XoruOfPC7qu+wtv6Z6L3owv2kfLc18/SosbK+vqXvU9Lw8cTBY0YUMGE1cdyn5gP7QyMGIcs6yHgBRMLn6DKjnhlUv2Kr3zetyyK0ETVjRtepuUY6ppOUhG3jKeuFukoJ4eLHwmGTwCLMBPFKvzDR8SeTTMU0u/DziXkK/1/K1Lm5+mDHJsMgRsQwD8gbVZ7aFGXJpX0pbp4zjGOlCFDMkUCdDVM2KLxiK1QO+JqhOz7yOlMRgr8XMBxMGgK/KtMO29xPGuzhDsIAuQgwfzxYwxPi0Gbf6E6qcHTlRT4pD8JtZncwnWh38FzcHUBHSXWjkF4Uy8ytAYhxdb7m+w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4597.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(346002)(376002)(6666004)(2616005)(66556008)(16526019)(86362001)(956004)(66946007)(6486002)(34490700003)(26005)(52116002)(186003)(66476007)(1076003)(7696005)(36756003)(83380400001)(5660300002)(44832011)(2906002)(8676002)(508600001)(8936002)(4326008)(41533002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?7PeZ/pKjS0UXW+EpRRvTBKgSEFG6LkvLyz/DaHD0flpNSbKq64/cUfbvTtFm?=
 =?us-ascii?Q?BfH7/32azel4Dro16UdCdA0fxgrkkHzipsPv+ZfS+i7oVsw+ApzHQ691bgd8?=
 =?us-ascii?Q?s8r97gHo+mc7esOo7RcD5KZ48++TEFe9UGNTCWYYM5Qbd2/wlpsWa2H/7yi8?=
 =?us-ascii?Q?AzawHJtnsfw+s7og0aAa/jbYC5TfQxQNJPco9hj5IVtkmuMLX3KBtWY1HgGz?=
 =?us-ascii?Q?fhqaiGtkG6/bQnKKcNT88Le+J0amSUfK9qzzUVMyLgq2/k0zt1K+5K6AInOK?=
 =?us-ascii?Q?NCoc16MI/8Ok9byXkuasrj+SZ5WzJzjfM9Qx7qKqJ8U7M+rpzyi7fGiWJcmi?=
 =?us-ascii?Q?3iPclrNx0+jnWBlUBkQ/liItdi5vmKSGbV9RL1+XTtuyKX8XRoxuXPMPOjdM?=
 =?us-ascii?Q?b7iQTIa1xP/+Ojl2inrZ8sENQLuZJAKiGjdE+2tMKJDjqN3Hnkw0IAG0Hhfj?=
 =?us-ascii?Q?u7PYqHQMTI1DeFSMKBTZorxaw9euwlA1G4FwjpHLwXMPgqlPU/ox3SlTri7g?=
 =?us-ascii?Q?sJVUx4tfhmPABVtCW13rw2GOLDXkNooNxdm/w58gFh0maZhWM+1EXLWzq/yz?=
 =?us-ascii?Q?CVIRB+TBOkidwinpdHX7S83NyAPvI2EyY1/D7VAhVM2x2tDO59NR30AZKlle?=
 =?us-ascii?Q?n71CdCoBnSNQAPVQr7xH3T7NwhX8ClVVpENXP3PHlfjFoeuU6dLRThSqwXzd?=
 =?us-ascii?Q?kDRp/VqSvt0v/uXYBTGWOzkpXHwulPQs5xVajo25Ui6bOIOz7oBO8C/wMomy?=
 =?us-ascii?Q?5wC/ForI+qY/YqT2bAjqjCvuG+w9qi/OH4HP2+BPtrcr0tZQ0/0INbgXy4pC?=
 =?us-ascii?Q?UKDbVboHracH0UAKSxlcCS7JllAPIDsN+GYp7VYH90xTxmllrJ8cWwnbp5av?=
 =?us-ascii?Q?MpdQmaDSDeN0raRw4OhmwmBQEYEpMlhz20WwjhvHaKqpWf+lo+4X/+UI8zse?=
 =?us-ascii?Q?MrBeP4UAb6G4G8q7r2HsIeEtmdSV71YQquRWsr49VIqyT63tJ9a/2/upIPzZ?=
 =?us-ascii?Q?YH2n?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4597.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2020 07:34:38.8391 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-Network-Message-Id: 75034cf8-70c6-4c9a-b432-08d8a0cbe199
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a1bnju04pqFi3bEcxRJcYhyG3J6IIN/rIH2iqraAHKW6LrDBHfuxkO2K5kqI+Zl/vxQLr1eHNaWWIwzshE8jeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3794
Cc: will@kernel.org
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
 drivers/iommu/amd/amd_iommu_types.h | 35 ++++++++++++++
 drivers/iommu/amd/io_pgtable.c      | 75 +++++++++++++++++++++++++++++
 drivers/iommu/amd/iommu.c           | 10 ----
 drivers/iommu/io-pgtable.c          |  3 ++
 include/linux/io-pgtable.h          |  2 +
 7 files changed, 117 insertions(+), 11 deletions(-)
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
index 494b42a31b7a..5d77f34e0fda 100644
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
@@ -465,6 +479,26 @@ struct amd_irte_ops;
 
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
@@ -473,6 +507,7 @@ struct protection_domain {
 	struct list_head dev_list; /* List of all devices in this domain */
 	struct iommu_domain domain; /* generic domain handle used by
 				       iommu core code */
+	struct amd_io_pgtable iop;
 	spinlock_t lock;	/* mostly used to lock the page table*/
 	u16 id;			/* the domain id written to the device table */
 	atomic64_t pt_root;	/* pgtable root and pgtable mode */
diff --git a/drivers/iommu/amd/io_pgtable.c b/drivers/iommu/amd/io_pgtable.c
new file mode 100644
index 000000000000..aedf2c932c40
--- /dev/null
+++ b/drivers/iommu/amd/io_pgtable.c
@@ -0,0 +1,75 @@
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
+static void v1_tlb_flush_all(void *cookie)
+{
+}
+
+static void v1_tlb_flush_walk(unsigned long iova, size_t size,
+				  size_t granule, void *cookie)
+{
+}
+
+static void v1_tlb_flush_leaf(unsigned long iova, size_t size,
+				  size_t granule, void *cookie)
+{
+}
+
+static void v1_tlb_add_page(struct iommu_iotlb_gather *gather,
+					 unsigned long iova, size_t granule,
+					 void *cookie)
+{
+}
+
+static const struct iommu_flush_ops v1_flush_ops = {
+	.tlb_flush_all	= v1_tlb_flush_all,
+	.tlb_flush_walk = v1_tlb_flush_walk,
+	.tlb_flush_leaf = v1_tlb_flush_leaf,
+	.tlb_add_page	= v1_tlb_add_page,
+};
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
+	cfg->pgsize_bitmap  = AMD_IOMMU_PGSIZES,
+	cfg->ias            = IOMMU_IN_ADDR_BIT_SIZE,
+	cfg->oas            = IOMMU_OUT_ADDR_BIT_SIZE,
+	cfg->tlb            = &v1_flush_ops;
+
+	return &pgtable->iop;
+}
+
+struct io_pgtable_init_fns io_pgtable_amd_iommu_v1_init_fns = {
+	.alloc	= v1_alloc_pgtable,
+	.free	= v1_free_pgtable,
+};
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 7f6b0f60b958..45d3977d6c00 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -58,16 +58,6 @@
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
index 4cde111e425b..c9794671dccc 100644
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
