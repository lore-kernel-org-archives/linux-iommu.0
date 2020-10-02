Return-Path: <SRS0=Fz8+=DJ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 620A4C4363D
	for <iommu@archiver.kernel.org>; Fri,  2 Oct 2020 12:57:10 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6DED206E3
	for <iommu@archiver.kernel.org>; Fri,  2 Oct 2020 12:57:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="AZE5gs1v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6DED206E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id AB38086A14;
	Fri,  2 Oct 2020 12:57:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BnbqQ7BE73fg; Fri,  2 Oct 2020 12:57:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 817D7868FF;
	Fri,  2 Oct 2020 12:57:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6F6DCC016F;
	Fri,  2 Oct 2020 12:57:08 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 49970C0051
 for <iommu@lists.linux-foundation.org>; Fri,  2 Oct 2020 12:57:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 3EEBC869BF
 for <iommu@lists.linux-foundation.org>; Fri,  2 Oct 2020 12:57:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8NSxbOD8qXrh for <iommu@lists.linux-foundation.org>;
 Fri,  2 Oct 2020 12:57:06 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2060.outbound.protection.outlook.com [40.107.237.60])
 by whitealder.osuosl.org (Postfix) with ESMTPS id C9F48868FF
 for <iommu@lists.linux-foundation.org>; Fri,  2 Oct 2020 12:57:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e1e5VyyraElrBpviJUebeO5xrG8236F4FPDUzR/Ui9goOF+7VxSYKsoTj36hX8J6pxr9+PEyMdcGSFr8Tn0sd3Aicax1jW1TJXsxFq/hsz0bEFHzztQI26v2GLXdMvNp1fHZAia4v++4kei1T2Fzy3EwxV5TEAZmw10iu4XmI3jO4gwoM5Wsi+dL9MqAeOSdfpx43HDBIMTdxaV1vpjJdu54pN87FgYwLnpTWZQTOitqxNSdLewhXOasRN5sBtO8PfqPRMbM64k+bWgejoUmZjtaJi7kSsPO5B3WCrDkMrUjnIgUXQhrgZ0ftBMVZy81OLF31SDUuqTKPHvKT9DV0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zPKzhS6iiPk5pGaFSw3lh/6B96SqachZfBS3GsXGFBw=;
 b=aDAjhEl33wtC6EbovOCO//8/9jAsZrLFR8i9cHDDd21ozddf7LnNf41/SF0VhpNoZsu033vmN23An/l4DBCaETOKbI+RcSXE2RywE2y+eSS0ZzVAmUVTYba3h+ioSbEThWz6HjipzhyYxgxwsr1dRCt2GJFi+CM1v0BStgZRc7b9ubhQjtFceZkxAQnftCy2/siGlGfyntZXHyt/qAwArLxvAYMHj7tFQyKm+dU+Atbp7ft+7DtEJKGge4CLUGEQ51xTaCbu363WldBThfqrsIqidqHJmUmMR72Y4B0THjyskF6PnmGtDQk26BYqaBYS6TmfiAPKLb3Ygx10QXX/tQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zPKzhS6iiPk5pGaFSw3lh/6B96SqachZfBS3GsXGFBw=;
 b=AZE5gs1v/S8tv5HwRIJ9kakdpUZLK0NTjcc6WHJikiw776Ka859dGAMixNUd+J6Rfk6skZBNgybN1JDXq+CyKr6V3WLHUmul26fVo61e3+hKDXmY9tCeQWyA2fxZKd8hgAj1r6hfy4LLV5o5/Pq9KHQJEiMj9RkHacyQOlCISLA=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1163.namprd12.prod.outlook.com (2603:10b6:3:7a::18) by
 DM5PR12MB1163.namprd12.prod.outlook.com (2603:10b6:3:7a::18) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3433.32; Fri, 2 Oct 2020 12:24:49 +0000
Received: from DM5PR12MB1163.namprd12.prod.outlook.com
 ([fe80::48cf:d69:d457:1b1e]) by DM5PR12MB1163.namprd12.prod.outlook.com
 ([fe80::48cf:d69:d457:1b1e%5]) with mapi id 15.20.3433.039; Fri, 2 Oct 2020
 12:24:49 +0000
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: linux-kernel@vger.kernel.org,
	iommu@lists.linux-foundation.org
Subject: [PATCH v2 02/13] iommu/amd: Prepare for generic IO page table
 framework
Date: Fri,  2 Oct 2020 12:28:19 +0000
Message-Id: <20201002122830.4051-3-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201002122830.4051-1-suravee.suthikulpanit@amd.com>
References: <20201002122830.4051-1-suravee.suthikulpanit@amd.com>
X-Originating-IP: [165.204.78.2]
X-ClientProxiedBy: SN6PR05CA0010.namprd05.prod.outlook.com
 (2603:10b6:805:de::23) To DM5PR12MB1163.namprd12.prod.outlook.com
 (2603:10b6:3:7a::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ethanolx5673host.amd.com (165.204.78.2) by
 SN6PR05CA0010.namprd05.prod.outlook.com (2603:10b6:805:de::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3455.13 via Frontend Transport; Fri, 2 Oct 2020 12:24:48 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 0b758c59-d76e-48a3-f01f-08d866ce27cb
X-MS-TrafficTypeDiagnostic: DM5PR12MB1163:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB116331E294F82C63F9C560E9F3310@DM5PR12MB1163.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UlTLME7bpFpOD+neA5Ud8sLgTHxzi2HSZ3G+p20QdNSVa6T+zI4Ot8MCBcu23I5B0OmcVJGUgjZdwywa2vWv3kTDIwdR5Yd7P3DFeBW/VndoTJAxhPKh3LMqKQAKIChIq3SbmPnp7qedEJa/QWBQ4fn2Kn0nn2lLXhbW9WqYjVSY0oDxXs9J2xPfScgHz1kVKttHRIkb1I0ueDhgtlQZMQCXp4k9V/597KpHnnZWpi4B1niVGnl8JAhG2yhvIQ+o3RQLvWU3Vtmsp1IPQa/jLHv0l/BrRFZHtd/21lO1FjOpo1if33ddlkT8gI8jnF46VBeFQRJHW5ye4ryQFb9FBoMgirMGbw34BE/W758m8fqX2zl0SAmVpNTBxl1sh/NI
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1163.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(39860400002)(396003)(346002)(376002)(66556008)(52116002)(66946007)(66476007)(7696005)(5660300002)(8936002)(4326008)(6666004)(1076003)(26005)(6486002)(16526019)(186003)(44832011)(316002)(2616005)(36756003)(956004)(478600001)(83380400001)(8676002)(2906002)(86362001)(41533002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: TqROGkY4MmcX05qFO7H6nRTis6tJ+58LU6Qs0ccwJ2UytH7LIw0yOrbONvhhYZ+ILejmOttpvcHbZ4S+hCZdc9Q+UzE25LHsLvYt3kaRZSDhcuv5lFKjA7EXBklpizs669jzJiUWFAi4BYTzdciL+TTXhm4S3zGxE07HqDiq9dXAAubq74gCw2Su22yeZNS2JWarQwqL6mz9lzlBiIeI/gBaUrUJpgyWrSV1/1xoMofLGofysvRcrVI2UkPGNAkO7OYbzSPQYV29OyM/ZmizJaqeW+1+vThlB4iSo+dLfLnLXjSsKSGCQ4kq9fEyvnJS8leodKytqwIQ+8ZSiZQNYcAkDgnG6XbE0hVOyLuoB8QzNOv3yJBUIX1F+a5QyxqM8yMiS9E8+Bs89WimAEogICphhWDqx0AoqAU0wawmmq16wbgsUq8M9hFT4oxiYoRCTsfkEMxRECAtClQvekMQy8YyhQg71w72S8MhvROoTYoUFA+kMnA0+qQQiNLPOK50AmHO/8SwSvotz2X1bZb5HdVpvoa40yYSBuozLbL1IUb6SSpnUyLhS6i4eRT8byp3fO3diuvM1qmHEko+SkZv9Rq9C2GpXS9Qdr1tCpxzYf4NExRIofZ+8y9TxjCnA8Tga+scFABMKelT1kDPCvTmBQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b758c59-d76e-48a3-f01f-08d866ce27cb
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1163.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2020 12:24:49.3456 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 04mlrAtz5Mb5YH3YCMLA57sOvlyIT3oqoXo1SyWjFx6NW3anUXpuTbR+3fqtSlLx4re/REsS2ImQb3aiqrxDzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1163
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
 drivers/iommu/amd/amd_iommu_types.h | 32 +++++++++++++++++++++
 drivers/iommu/amd/io_pgtable.c      | 43 +++++++++++++++++++++++++++++
 drivers/iommu/amd/iommu.c           | 10 -------
 drivers/iommu/io-pgtable.c          |  3 ++
 include/linux/io-pgtable.h          |  2 ++
 7 files changed, 82 insertions(+), 11 deletions(-)
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
index 000000000000..f123ab6e8a51
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
