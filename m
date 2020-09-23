Return-Path: <SRS0=5N08=DA=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DF7EC47420
	for <iommu@archiver.kernel.org>; Wed, 23 Sep 2020 10:11:49 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0522E2076E
	for <iommu@archiver.kernel.org>; Wed, 23 Sep 2020 10:11:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="I2Oyxyg2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0522E2076E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 8F53386142;
	Wed, 23 Sep 2020 10:11:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id giKcBxJm6_h8; Wed, 23 Sep 2020 10:11:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id D2CD386103;
	Wed, 23 Sep 2020 10:11:46 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C39D5C0890;
	Wed, 23 Sep 2020 10:11:46 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 22D68C0051
 for <iommu@lists.linux-foundation.org>; Wed, 23 Sep 2020 10:11:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 11818866B3
 for <iommu@lists.linux-foundation.org>; Wed, 23 Sep 2020 10:11:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BMrjCZtwU+Cc for <iommu@lists.linux-foundation.org>;
 Wed, 23 Sep 2020 10:11:44 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2046.outbound.protection.outlook.com [40.107.237.46])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 315FC86DA5
 for <iommu@lists.linux-foundation.org>; Wed, 23 Sep 2020 10:11:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hulnqJZLTGtl6M/f7AN7fDC2EXRklN5s4NTc/ZEjb1ZNzuHe2SrP1L34ZoJYgS/y2dIqSbSM3X6zM9QvBIx29p4fcjN0UR+0lfXy5ncmQKeUXf8CvnE6ofQ5AS+6dCDM9ojFVdWq9kF0We8YXqFQU7qxitc3SwYhA8S5Asz63ajtIRGncHw+IS5PFXSeAX9xC11GV6CNKP1HDdSu16YjrIeKBNgcpZVOZoSnbj/KgDkS0AQBxKhg8X1J9HzctOjG1YpfLugEsmG0/6Zxfxbia+fI7SUcC8icTFKBkZT+pct0vfgs3twln2KuTlqFwcGw2VG2n/zJeIjI9TFoeCpJeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vwmbF1ogO7KzJyRQ3TXhcCD6BAmMj9mEVkyUE/OiCh8=;
 b=DONK+kQyjUsRkLNwsO1XiLLkAQutl6SUfjzV+setAF1LiaeFibpp+CePadeguWzsLI2Rjo6biGBtCldEle1XVWB5X8LEHdy86xmeHFs8g9y+oC8Rl0DOULrzQI8hxS8azpqr+j2M2S2l3Re2thyqO43c2MhWjNe35qEiIK/7o/hzjW780LmonpIlom3JzmrrVo48f3ei5XqCt4ig//o0V1R02Z2fSmS30nZu0FNtGKRKjoy//Y89+um50dp5qVnOwNCOvAk1JkxeRrhY+XnxswmkS8khoN42RqrBlz2vB6dXJZasHjrtqze3kRGVcDlcIWekBnwt0/d7rRU5uB4Scg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vwmbF1ogO7KzJyRQ3TXhcCD6BAmMj9mEVkyUE/OiCh8=;
 b=I2Oyxyg2rii/oyYAJgIxPtUoqlS0Z0dMX9DIudUNLTam/pmLIL7u/dtDXcF7XB3nBvRRf4FCkXi7Fn/5wcYKrW8dAVHFCsUZ45RFjPpvnpVq65nqyp/+fckF8AEvgusLRq2XhfPG6M3pgaM1Htw2+sCIcegImT3EgT8yVdpBpu0=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1163.namprd12.prod.outlook.com (2603:10b6:3:7a::18) by
 DM6PR12MB3466.namprd12.prod.outlook.com (2603:10b6:5:3b::33) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3391.11; Wed, 23 Sep 2020 10:11:43 +0000
Received: from DM5PR12MB1163.namprd12.prod.outlook.com
 ([fe80::48cf:d69:d457:1b1e]) by DM5PR12MB1163.namprd12.prod.outlook.com
 ([fe80::48cf:d69:d457:1b1e%5]) with mapi id 15.20.3412.022; Wed, 23 Sep 2020
 10:11:43 +0000
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: linux-kernel@vger.kernel.org,
	iommu@lists.linux-foundation.org
Subject: [PATCH 02/13] iommu: amd: Prepare for generic IO page table framework
Date: Wed, 23 Sep 2020 10:14:31 +0000
Message-Id: <20200923101442.73157-3-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200923101442.73157-1-suravee.suthikulpanit@amd.com>
References: <20200923101442.73157-1-suravee.suthikulpanit@amd.com>
X-Originating-IP: [165.204.78.2]
X-ClientProxiedBy: SN4PR0601CA0003.namprd06.prod.outlook.com
 (2603:10b6:803:2f::13) To DM5PR12MB1163.namprd12.prod.outlook.com
 (2603:10b6:3:7a::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ethanolx5673host.amd.com (165.204.78.2) by
 SN4PR0601CA0003.namprd06.prod.outlook.com (2603:10b6:803:2f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20 via Frontend
 Transport; Wed, 23 Sep 2020 10:11:42 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7bbe7f84-e0f1-4d26-7dbe-08d85fa911de
X-MS-TrafficTypeDiagnostic: DM6PR12MB3466:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3466F77F39C18374873F971DF3380@DM6PR12MB3466.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4H5pmPvXm2Qhk5QXmmus0NqLajJ/KbAzIHaDnoh06GtRIepUGsJGLKWRDfLkwzCGnSucFLUQ6LXS3QCZM/w6lYZeM3uDyjGPCbNbxTcw3zPY9x9vscvdzaYLe4gckK+W4YM08qGBWXkUCHPp9QJdJIa6psnzT19VQAR0mMsQ4rD6XcJjsCaTC5yJpQIunngHU23hLhupkWjp9wFA0xjGZDB+gtvFEgoSoM2RPddcK9C5jddXc1vEKHHwXMVW+doCkUG9mpOHX8J8pH/EEsTAN6LzxnaWvO2LF7poPKd/Y/uxy4aOHBY1r7qWnIpOSjOcwcWSqys/vI/FjwcJ+TOd6t1YkNhdskULq4dfFGwA5bQEWXVan9ys/lLrvuqwsgPL
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1163.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(366004)(376002)(346002)(396003)(44832011)(5660300002)(66946007)(66476007)(66556008)(83380400001)(6486002)(86362001)(36756003)(2906002)(8936002)(4326008)(26005)(316002)(1076003)(956004)(478600001)(6666004)(186003)(16526019)(52116002)(8676002)(2616005)(7696005)(41533002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: huaUM7h/q+O5TkrhBeYCCIWfxesuyHJowL8cqWi5Im0cKiq0yIjXmrfi/dfwtW/m+BHv08lQDCBhXEnGXDEaihWRaCmsvIwDzM8M19S9g86VO3tX3cHxUYBVX+b7IF2wQvig5gZWc3xGFpr6V6spIwlo4Nr7f3SNibGdMcoIeH0lOnLTXayloi6+HogFgRT1aXXzFWApZzEa17bnK/AnFrLuJ9rctrMQFwaroYpDq1UowK2TXi3YB3F2sqe4dxm35zKqIUwzwb3P4QB7ArYB3GDz2q1Y7ywPoTBEind5XsaOAfEJtNEN0HZj4FYk4UPATR2Befbo17hJaQ1Iake8H7wc83cPX/hSvh2KA+Jad93Hk0sbbdodbau18WVcqboBZ/RMg8vEkQh4pzmaUdj2wgR/ml7hXAxCowcn99xl2fF76JkqwRzSdQUs9pboejmsvmOQA5NGwI6t66r4cot5vdXcoUqAJlmeCrnX/cGNHMuD9rEOnL4GOgkrpRrSzuLf2GxxfheAZoYWCaX7MC0mNpzERWmq/zZ4yEF9XXFDCwLrrP/0zUnbva1C193nneQANlZ5QwM8Bg1B25i64EcjRUVh77U69fkwSoYo7HgNi3vK3mHm1FmdwcIwuwfvGaoFWTXEY8iCi2KKDuplnp5ErA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bbe7f84-e0f1-4d26-7dbe-08d85fa911de
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1163.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2020 10:11:42.9779 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ozM3Suo0I+T9PB2WQXYEiEsLDmqw/tYbka8myCO3h3lF98Jd4lFw9k96b9DUioIbogy/ACkJa246kDZ+kP4Qtg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3466
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
 drivers/iommu/amd/amd_iommu_types.h | 32 +++++++++++
 drivers/iommu/amd/io_pgtable.c      | 89 +++++++++++++++++++++++++++++
 drivers/iommu/amd/iommu.c           | 10 ----
 drivers/iommu/io-pgtable.c          |  3 +
 include/linux/io-pgtable.h          |  2 +
 7 files changed, 128 insertions(+), 11 deletions(-)
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
index f696ac7c5f89..77cd8d966fbc 100644
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
@@ -461,6 +475,23 @@ struct amd_irte_ops;
 
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
@@ -469,6 +500,7 @@ struct protection_domain {
 	struct list_head dev_list; /* List of all devices in this domain */
 	struct iommu_domain domain; /* generic domain handle used by
 				       iommu core code */
+	struct amd_io_pgtable iop;
 	spinlock_t lock;	/* mostly used to lock the page table*/
 	u16 id;			/* the domain id written to the device table */
 	atomic64_t pt_root;	/* pgtable root and pgtable mode */
diff --git a/drivers/iommu/amd/io_pgtable.c b/drivers/iommu/amd/io_pgtable.c
new file mode 100644
index 000000000000..452cad26a2b3
--- /dev/null
+++ b/drivers/iommu/amd/io_pgtable.c
@@ -0,0 +1,89 @@
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
+	struct protection_domain *pdom = cookie;
+	struct iommu_domain *domain = &pdom->domain;
+
+	iommu_iotlb_gather_add_page(domain, gather, iova, granule);
+}
+
+static const struct iommu_flush_ops amd_flush_ops = {
+	.tlb_flush_all	= v1_tlb_flush_all,
+	.tlb_flush_walk = v1_tlb_flush_walk,
+	.tlb_flush_leaf = v1_tlb_flush_leaf,
+	.tlb_add_page	= v1_tlb_add_page,
+};
+
+struct io_pgtable_ops *amd_iommu_setup_io_pgtable_ops(struct iommu_dev_data *dev_data,
+					     struct protection_domain *domain)
+{
+		domain->iop.pgtbl_cfg = (struct io_pgtable_cfg) {
+		.pgsize_bitmap	= AMD_IOMMU_PGSIZES,
+		.ias		= IOMMU_IN_ADDR_BIT_SIZE,
+		.oas		= IOMMU_OUT_ADDR_BIT_SIZE,
+		.coherent_walk	= false,
+		.tlb		= &amd_flush_ops,
+		.iommu_dev	= &dev_data->pdev->dev,
+	};
+
+	return alloc_io_pgtable_ops(AMD_IOMMU_V1, &domain->iop.pgtbl_cfg, domain);
+}
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
+	struct protection_domain *pdom = (struct protection_domain *)cookie;
+
+	return &pdom->iop.iop;
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
