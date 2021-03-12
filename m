Return-Path: <SRS0=dgoC=IK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68036C433E6
	for <iommu@archiver.kernel.org>; Fri, 12 Mar 2021 08:55:27 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2822A64FFB
	for <iommu@archiver.kernel.org>; Fri, 12 Mar 2021 08:55:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2822A64FFB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id BB0C384535;
	Fri, 12 Mar 2021 08:55:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DPG4tVz6hI1H; Fri, 12 Mar 2021 08:55:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id 56E048453D;
	Fri, 12 Mar 2021 08:55:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C8973C0018;
	Fri, 12 Mar 2021 08:55:22 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A1288C0001
 for <iommu@lists.linux-foundation.org>; Fri, 12 Mar 2021 08:55:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8E8314ED64
 for <iommu@lists.linux-foundation.org>; Fri, 12 Mar 2021 08:55:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=amd.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CoEUH8ixroeB for <iommu@lists.linux-foundation.org>;
 Fri, 12 Mar 2021 08:55:20 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20611.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eab::611])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 1CF7C4ED67
 for <iommu@lists.linux-foundation.org>; Fri, 12 Mar 2021 08:55:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qoe/ZSHKmgp4OpOYHS2o/oucuPT3mZuJFLzWiz3g1GqmTk7V9w8TDEHnfCd+SY4yL8jGfymCWjUdslYd3rDFxXWg6qgP53/aEtrvesPdN8wpYVDYff42k39BfPJL/sVr3Awbae6gFko7MVR+KkCZk0z+KPVHTcSmOwb1jRn8RAtpuuhDDDYWYdyBmAC+vpstxaxFmT2rva8BUu8EUhb24ILSfknz6LHOI8/IcYKHEZwOp6BFoOyQ/egd+EGBu8vhxMQmrF2LRv6HtHbSsRFjOxOieXVWNkQTJydjIj7w34BPI6+N9+YxNI2P7Oaj8OljfUkGLS0yHwa9dwgdYGY+cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=34hYoeHiA/oyMdwTB8jZDnp9L9ptveDwkb/TtlfKU/4=;
 b=TZIm3TsGVPQyo7z2Em7vAw2FznQi5ZoMNuS5hUWran3B6b3zj1nWkC6NNbgWpfhLyNSjBdn0znVk/1bOPWkhZGl9J37Yr1KhWboqBWpixDfcel5muCLqDro9eH8OFQdHTcNoUea6TVknt3BwT3W2/itauJpyDsV9hFs6XDvmsAKs07GF7FIWM9gqMU625hSEMTiu75EmiCvp3vCcniBZrG30LDUXo3XLP8LTBqBO6kNCd0ia2de7EcCFc6s76uzp/fx7B3WGNTTsZaxV30I1NyRgonzsQhNgVVaQsHXxTUfFqadbidMp7dCyK7Cfb39YiQoqT+70g4bpnuRTNpk/og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=34hYoeHiA/oyMdwTB8jZDnp9L9ptveDwkb/TtlfKU/4=;
 b=j2MgNTmFOgxwytW8m5RnCupWIHae3abU6xy5jXpvs15147eFYLuvTRsAS1L8/SKc+avrCktxVWMk1aaaZfCGMggrKfI52sYM7KrGK7zZOLEXSMhg34o+zSuge6A+sk0fGsEg8iLP4fmP2ByiQxYzPUiyBnlJ+NpcGaeahTCfBO8=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4597.namprd12.prod.outlook.com (2603:10b6:a03:10b::14)
 by BYAPR12MB3144.namprd12.prod.outlook.com (2603:10b6:a03:d6::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.31; Fri, 12 Mar
 2021 08:55:18 +0000
Received: from BYAPR12MB4597.namprd12.prod.outlook.com
 ([fe80::a95a:7202:81db:1972]) by BYAPR12MB4597.namprd12.prod.outlook.com
 ([fe80::a95a:7202:81db:1972%7]) with mapi id 15.20.3912.031; Fri, 12 Mar 2021
 08:55:18 +0000
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: linux-kernel@vger.kernel.org,
	iommu@lists.linux-foundation.org
Subject: [RFC PATCH 4/7] iommu/amd: Initial support for AMD IOMMU v2 page table
Date: Fri, 12 Mar 2021 03:04:08 -0600
Message-Id: <20210312090411.6030-5-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210312090411.6030-1-suravee.suthikulpanit@amd.com>
References: <20210312090411.6030-1-suravee.suthikulpanit@amd.com>
X-Originating-IP: [165.204.78.2]
X-ClientProxiedBy: SN7PR04CA0040.namprd04.prod.outlook.com
 (2603:10b6:806:120::15) To BYAPR12MB4597.namprd12.prod.outlook.com
 (2603:10b6:a03:10b::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ethanolx5673host.amd.com (165.204.78.2) by
 SN7PR04CA0040.namprd04.prod.outlook.com (2603:10b6:806:120::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.18 via Frontend
 Transport; Fri, 12 Mar 2021 08:55:16 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 040da038-f487-44a2-8d1a-08d8e5348f30
X-MS-TrafficTypeDiagnostic: BYAPR12MB3144:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB3144140D3B5AD431A5B9AF6BF36F9@BYAPR12MB3144.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2803;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tDDrpiSImqTYW+8tRWMahV+dPLNZ36ysOTxF57joqx2riQQQLgtdURmUJWuMF+nM2qEkOVqpMjNInh2pz02ka5gtCaQHi/QM3y+zPxmXIrFKmPaKBZ/f+ejKXeXvQtpDPPoXSyIcfaD6snSENShGBLDGjPLrbd8uNXEX5sYz5IQAH21dNV9dk5mIRnwD+F6pDdncychekykAlVCY5/B8TpNqNtUcwY3kxWLxLCq+xtYQq9CTwCzHfrmdDnmNfW1x2r8FDHSv7k3YMt35EAQYLlkk2aBRbYXAIXBrpM9K5ffX7CBUV9L5HwkZrDF8nAQ1JaiPHQKj+/+LOIXII+S+IpCzPqK0qMn4eAUWwqjSFaT/9+KJlch4BjUxvjxVFwdc8Bwphi5m5VWdNlBeFkv8pZmXu/mJh817VRfUZrQuO/LzgufQ90pTOSfFekqvYR+v00dRkPRIkPskkvaw+r0WpiHEjmL2QADh17SltJLdvXFTJ8ts5N/MjdbmCR6sHzwSDXSYr+ZhTWmBgAS6xAlFBBFyaC3bMXeKfR+7Ck0wLYmWrmJXU5fpqB41wm6BebH1
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4597.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(39860400002)(366004)(396003)(376002)(346002)(6486002)(6666004)(316002)(7696005)(8676002)(16526019)(1076003)(5660300002)(956004)(66556008)(86362001)(52116002)(478600001)(44832011)(2616005)(8936002)(66946007)(36756003)(4326008)(26005)(2906002)(66476007)(186003)(83380400001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?Ogs8wGHFy8k3Nz7WwdYsUf0+aq5lCne3Dx7d8KZ54TUpEqNC8E9FgBjWOQ40?=
 =?us-ascii?Q?xr5fOdwQKj6EWgW2bv801PH4IEhKT8OsDZ/2QfgegURt48KQdKzNSl++ZZbe?=
 =?us-ascii?Q?ahp3ednB9IEy3GvuTGNO7Qeb1BqZebE3Csj2Ut2XtkfaQGSfrFWH5J9xHP+6?=
 =?us-ascii?Q?l/A6G6dEsCtAirXIahrsEc57kslg80p2jwf/s6DfKdxa1u+ROarCiXSgZu3S?=
 =?us-ascii?Q?H7IwjZfMFfTLCfp0adJcFoeBeOJjR4G9XEZ4ohjaib0xB7fFVd+UpZZlWzWK?=
 =?us-ascii?Q?AZll2Vt8spKy2wekF91JzwxsMLfWjKlNihGCSICy2C8q/2wWGvdmy2ID87fD?=
 =?us-ascii?Q?oXBedOZ+mKF1ESM4lVDhTSfd49BKKTlmQf0JEJ5YxNz0/LXCGSVwkilH4slN?=
 =?us-ascii?Q?AeLnAGZVTwAf40I0/rUmqQRiLAbuXyOTBoI4dRrAooBflP8aVEack93Qc19U?=
 =?us-ascii?Q?se3y/peJNEN3Ws/bDWe9G0KSzbE/cbafNqoBkDuRB4TcObpX7IUuwg9ISBWq?=
 =?us-ascii?Q?41dNAmBW4mROHLHEidTbmIITkr9R4mLk7yxBE0CJ8YmVchIOVt6x6B/NdPS5?=
 =?us-ascii?Q?+gYkCs+OregifzDEJJD0Kqz8p+obg3MYcPjzf39h//yyJWxOY9rBQQv5e7BP?=
 =?us-ascii?Q?rycCsIqhm0J2TNSDgB7wXfFZg3gzt1TmA8un2/asJx96my/2pZ1v14DC5cpl?=
 =?us-ascii?Q?upvUni403F14CZ2aDua7IAQyLBAno819or4dswHNf2EIuPInF+LSq/FoPlTV?=
 =?us-ascii?Q?X5Fu+lQ0kOumlULRByCZL91LL8DmrGis0pH/StzAHpOiiGwPIdLsNq51dYoB?=
 =?us-ascii?Q?WE5rxxFNZfkEAin05BpRfIgg63p6reHGcI6rOU63H5Q0OqqXjHMPw+7AUy8V?=
 =?us-ascii?Q?0QB5NZcbobColO0vLmyUOjhvKjpD5j1I4R2EYY/775VMxZ2Z5EcZ+fp48ix9?=
 =?us-ascii?Q?CzEZxIuotLd43/35u2ubVfsfta34ekAcyvJOmO5mxzKNlJYHPqljAvAVmufX?=
 =?us-ascii?Q?nHUhwUS7mehYBkmKkk8I/TxEPerb+iJYQe79AllmCtKmFluhjvAnAKkiqh6N?=
 =?us-ascii?Q?Pp6TnwVwunKAybi0nKf3/0EcXhltLR6LH0V/sbbTcot5Lk900zLPgnGNT2K+?=
 =?us-ascii?Q?Alpa4huN4/2MDYNYuvgJUosVTx/d4pvNwsgd1daCzIPerziT48uo4fzpG7ja?=
 =?us-ascii?Q?mbuCUmb7+DTVOemUzDhjOZQKC/Utf2Dbrxs47g/6IqI6PbbQTKd94AFi3F4Q?=
 =?us-ascii?Q?h/vqN26Ntb2u1ww6SPtNDOgRnl/9S9JzFlJdueBnXSXQZAsu8Msc1w3rugSA?=
 =?us-ascii?Q?J5k5igOvHepHiPss2B7aQoDL?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 040da038-f487-44a2-8d1a-08d8e5348f30
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4597.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2021 08:55:17.9657 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TzTuCjpYGNe/X9lelNK4ppF4MBvVjyiOb23q/xlQFEoEcY6D11m7kw0B+AKke1l9TtMh1RemCnCdRyyTXsTeCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3144
Cc: Jon.Grimm@amd.com, Wei.Huang2@amd.com
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

Introduce IO page table framework support for AMD IOMMU v2 page table.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/Makefile          |   2 +-
 drivers/iommu/amd/amd_iommu_types.h |   2 +
 drivers/iommu/amd/io_pgtable_v2.c   | 239 ++++++++++++++++++++++++++++
 drivers/iommu/io-pgtable.c          |   1 +
 include/linux/io-pgtable.h          |   2 +
 5 files changed, 245 insertions(+), 1 deletion(-)
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
index 6937e3674a16..25062eb86c8b 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -265,6 +265,7 @@
  * 512GB Pages are not supported due to a hardware bug
  */
 #define AMD_IOMMU_PGSIZES	((~0xFFFUL) & ~(2ULL << 38))
+#define AMD_IOMMU_PGSIZES_V2	(PAGE_SIZE | (1ULL << 12) | (1ULL << 30))
 
 /* Bit value definition for dte irq remapping fields*/
 #define DTE_IRQ_PHYS_ADDR_MASK	(((1ULL << 45)-1) << 6)
@@ -503,6 +504,7 @@ struct amd_io_pgtable {
 	int			mode;
 	u64			*root;
 	atomic64_t		pt_root;    /* pgtable root and pgtable mode */
+	struct mm_struct	v2_mm;
 };
 
 /*
diff --git a/drivers/iommu/amd/io_pgtable_v2.c b/drivers/iommu/amd/io_pgtable_v2.c
new file mode 100644
index 000000000000..b0b6ba2d8d35
--- /dev/null
+++ b/drivers/iommu/amd/io_pgtable_v2.c
@@ -0,0 +1,239 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * CPU-agnostic AMD IO page table v2 allocator.
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
+#include <linux/mmu_context.h>
+
+#include <asm/barrier.h>
+#include <asm/pgalloc.h>
+
+#include "amd_iommu_types.h"
+#include "amd_iommu.h"
+
+static pte_t *fetch_pte(struct amd_io_pgtable *pgtable,
+		      unsigned long iova,
+		      unsigned long *page_size)
+{
+	int level;
+	pte_t *ptep;
+
+	ptep = lookup_address_in_mm(&pgtable->v2_mm, iova, &level);
+	if (!ptep || pte_none(*ptep) || (level == PG_LEVEL_NONE))
+		return NULL;
+
+	*page_size = PTE_LEVEL_PAGE_SIZE(level-1);
+	return ptep;
+}
+
+static pte_t *v2_pte_alloc_map(struct mm_struct *mm, unsigned long vaddr)
+{
+	pgd_t *pgd;
+	p4d_t *p4d;
+	pud_t *pud;
+	pmd_t *pmd;
+	pte_t *pte;
+
+	pgd = pgd_offset(mm, vaddr);
+	p4d = p4d_alloc(mm, pgd, vaddr);
+	if (!p4d)
+		return NULL;
+	pud = pud_alloc(mm, p4d, vaddr);
+	if (!pud)
+		return NULL;
+	pmd = pmd_alloc(mm, pud, vaddr);
+	if (!pmd)
+		return NULL;
+	pte = pte_alloc_map(mm, pmd, vaddr);
+	return pte;
+}
+
+static int iommu_v2_map_page(struct io_pgtable_ops *ops, unsigned long iova,
+			  phys_addr_t paddr, size_t size, int prot, gfp_t gfp)
+{
+	struct protection_domain *dom = io_pgtable_ops_to_domain(ops);
+	struct amd_io_pgtable *pgtable = io_pgtable_ops_to_data(ops);
+	pte_t *pte;
+	int ret, i, count;
+	bool updated = false;
+	unsigned long o_iova = iova;
+	unsigned long pte_pgsize;
+
+	BUG_ON(!IS_ALIGNED(iova, size) || !IS_ALIGNED(paddr, size));
+
+	ret = -EINVAL;
+	if (!(prot & IOMMU_PROT_MASK))
+		goto out;
+
+	count = PAGE_SIZE_PTE_COUNT(size);
+
+	for (i = 0; i < count; ++i, iova += PAGE_SIZE, paddr += PAGE_SIZE) {
+		pte = fetch_pte(pgtable, iova, &pte_pgsize);
+		if (!pte || pte_none(*pte)) {
+			pte = v2_pte_alloc_map(&dom->iop.v2_mm, iova);
+			if (!pte)
+				goto out;
+		} else {
+			updated = true;
+		}
+		set_pte(pte, __pte((paddr & PAGE_MASK)|_PAGE_PRESENT|_PAGE_USER));
+		if (prot & IOMMU_PROT_IW)
+			*pte = pte_mkwrite(*pte);
+	}
+
+	if (updated) {
+		if (count > 1)
+			amd_iommu_flush_tlb(&dom->domain, 0);
+		else
+			amd_iommu_flush_page(&dom->domain, 0, o_iova);
+	}
+
+	ret = 0;
+out:
+	return ret;
+}
+
+static unsigned long iommu_v2_unmap_page(struct io_pgtable_ops *ops,
+				      unsigned long iova,
+				      size_t size,
+				      struct iommu_iotlb_gather *gather)
+{
+	struct amd_io_pgtable *pgtable = io_pgtable_ops_to_data(ops);
+	unsigned long vaddr_end, vaddr_next;
+	unsigned long long unmapped;
+	unsigned long pte_pgsize;
+	pte_t *ptep;
+
+	BUG_ON(!is_power_of_2(size));
+
+	unmapped = 0;
+	vaddr_next = iova;
+	vaddr_end = iova + size;
+
+	for (; iova < vaddr_end; iova = vaddr_next) {
+		ptep = fetch_pte(pgtable, iova, &pte_pgsize);
+		if (!ptep || pte_none(*ptep))
+			return 0;
+		pte_unmap(ptep);
+		unmapped += pte_pgsize;
+		vaddr_next = (iova & PAGE_MASK) + pte_pgsize;
+	}
+
+	BUG_ON(unmapped && !is_power_of_2(unmapped));
+	return unmapped;
+}
+
+static phys_addr_t iommu_v2_iova_to_phys(struct io_pgtable_ops *ops, unsigned long iova)
+{
+	struct amd_io_pgtable *pgtable = io_pgtable_ops_to_data(ops);
+	unsigned long offset_mask, pte_pgsize;
+	u64 __pte;
+	pte_t *ptep;
+
+	if (pgtable->mode == PAGE_MODE_NONE)
+		return iova;
+
+	ptep = fetch_pte(pgtable, iova, &pte_pgsize);
+
+	if (!ptep || pte_none(*ptep))
+		return 0;
+
+	offset_mask = pte_pgsize - 1;
+	__pte	    = __sme_clr(ptep->pte & PM_ADDR_MASK);
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
+				  size_t granule, void *cookie)
+{
+}
+
+static void v2_tlb_add_page(struct iommu_iotlb_gather *gather,
+					 unsigned long iova, size_t granule,
+					 void *cookie)
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
+	struct amd_io_pgtable *pgtable = container_of(iop, struct amd_io_pgtable, iop);
+	struct protection_domain *pdom;
+	pgd_t *pgd;
+	struct mm_struct *mm;
+
+	pdom = container_of(pgtable, struct protection_domain, iop);
+	if (!(pdom->flags & PD_IOMMUV2_MASK))
+		return;
+
+	/* Update data structure */
+	mm = &pdom->iop.v2_mm;
+	pgd = mm->pgd;
+	pgd_free(mm, pgd);
+
+	/* Make changes visible to IOMMUs */
+	amd_iommu_domain_update(pdom);
+	amd_iommu_domain_clear_gcr3(&pdom->domain, 0);
+}
+
+/*
+ * Assume protection_domain already setup at this point
+ */
+static struct io_pgtable *v2_alloc_pgtable(struct io_pgtable_cfg *cfg, void *cookie)
+{
+	int ret;
+	struct amd_io_pgtable *pgtable = io_pgtable_cfg_to_data(cfg);
+	struct protection_domain *pdom = (struct protection_domain *)cookie;
+	struct mm_struct *mm = &pdom->iop.v2_mm;
+
+	mm->pgd = pgd_alloc(mm);
+	if (!mm->pgd)
+		return NULL;
+
+	ret = amd_iommu_domain_set_gcr3(&pdom->domain, 0, __pa(mm->pgd));
+	if (ret)
+		return NULL;
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
+}
+
+struct io_pgtable_init_fns io_pgtable_amd_iommu_v2_init_fns = {
+	.alloc	= v2_alloc_pgtable,
+	.free	= v2_free_pgtable,
+};
diff --git a/drivers/iommu/io-pgtable.c b/drivers/iommu/io-pgtable.c
index 6e9917ce980f..6494657e4a34 100644
--- a/drivers/iommu/io-pgtable.c
+++ b/drivers/iommu/io-pgtable.c
@@ -26,6 +26,7 @@ io_pgtable_init_table[IO_PGTABLE_NUM_FMTS] = {
 #endif
 #ifdef CONFIG_AMD_IOMMU
 	[AMD_IOMMU_V1] = &io_pgtable_amd_iommu_v1_init_fns,
+	[AMD_IOMMU_V2] = &io_pgtable_amd_iommu_v2_init_fns,
 #endif
 };
 
diff --git a/include/linux/io-pgtable.h b/include/linux/io-pgtable.h
index a4c9ca2c31f1..17951204126e 100644
--- a/include/linux/io-pgtable.h
+++ b/include/linux/io-pgtable.h
@@ -16,6 +16,7 @@ enum io_pgtable_fmt {
 	ARM_V7S,
 	ARM_MALI_LPAE,
 	AMD_IOMMU_V1,
+	AMD_IOMMU_V2,
 	IO_PGTABLE_NUM_FMTS,
 };
 
@@ -250,5 +251,6 @@ extern struct io_pgtable_init_fns io_pgtable_arm_64_lpae_s2_init_fns;
 extern struct io_pgtable_init_fns io_pgtable_arm_v7s_init_fns;
 extern struct io_pgtable_init_fns io_pgtable_arm_mali_lpae_init_fns;
 extern struct io_pgtable_init_fns io_pgtable_amd_iommu_v1_init_fns;
+extern struct io_pgtable_init_fns io_pgtable_amd_iommu_v2_init_fns;
 
 #endif /* __IO_PGTABLE_H */
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
