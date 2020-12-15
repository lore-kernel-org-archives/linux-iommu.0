Return-Path: <SRS0=8938=FT=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97269C4361B
	for <iommu@archiver.kernel.org>; Tue, 15 Dec 2020 07:49:53 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17C1422273
	for <iommu@archiver.kernel.org>; Tue, 15 Dec 2020 07:49:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17C1422273
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id C666C8738F;
	Tue, 15 Dec 2020 07:49:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HZ+rMu6QQuGU; Tue, 15 Dec 2020 07:49:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 27E8387389;
	Tue, 15 Dec 2020 07:49:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0EECDC0893;
	Tue, 15 Dec 2020 07:49:52 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2E9F1C013B
 for <iommu@lists.linux-foundation.org>; Tue, 15 Dec 2020 07:49:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 1D828204A9
 for <iommu@lists.linux-foundation.org>; Tue, 15 Dec 2020 07:49:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MRiP+QqTzbSd for <iommu@lists.linux-foundation.org>;
 Tue, 15 Dec 2020 07:49:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2077.outbound.protection.outlook.com [40.107.223.77])
 by silver.osuosl.org (Postfix) with ESMTPS id 716A620004
 for <iommu@lists.linux-foundation.org>; Tue, 15 Dec 2020 07:49:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O69bnAqEyrfmAblAVcRPWoHUj+SLA6wPL4U5ZnmRF/L2W1Ml7l+jHG/EdL3t9jV5rbaHdrBnqDhUW9oP9741LwM5jANfPfIlQsUm7grBx4GIh61XLrle9tWDHRss1037o7J44kwbZzAmXLL9UPabY22iLiNa78hOobdKRazqmczDJcil5CbjOcAmO903+0X91Tg5EznUV+NROsLjpqBI/i4q3Mo95vE64sul3dAPHhUZT1JBvLQY//eXk9o7af9lHFMEABMBxSEjdT2PyOGI3GY2ZE9dD9KWTlz/rfBDRcH2yfQv6xhFHkMF7cPS43t/oqcSv3JcC7FNimJxJo310w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m3goTFNqyZuMoSJtcY+jPdOd2fiBVYAz4XE6BC+anTM=;
 b=LjzADGvo/T760dNwQNdxr9tntDeuyYLlTrROp5MtBDcYXeqvte0PjXahMJ1qZB0QXf4vhgtKa4/zqsYgxYWxotW3UsV648p5QemYIv8V7yDQ2AOyMcM7trilFXPAUlaCUs1U6k158JxjZe+JruU6PlNPBPEFIiAZUbxaCLn8Q397YpQcBjrDuh/9HQhtECNSeobN37YTpB/KMI2qJ0rfQEOgQa6NUBK7HVaW+hAJGDU8m07lUjRHaAMtbud374/G1Fp/o4PFWpm9cBBBJdLmZc4akMMh5bX4wIK8HyMGAE5EvWgFaQJsOCnMiKQqHcX1Qtou7nsAgYfA2DbHXdVP9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m3goTFNqyZuMoSJtcY+jPdOd2fiBVYAz4XE6BC+anTM=;
 b=30PZhAf+AWP85eRBJ+GqF2czs5IL9j13JFVrHQ+x+q/qAHNdDz4/GJfwZMvWhgqe9O4urZhVMyW7d0se1CU6a7czGMBa2RP4IWmt0qfQBuq8cXti72OsBT4UmEexolQwtfSQt6GmkewzyF458M2nFg01k9mc5ruJDM1Wa6p/33o=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4597.namprd12.prod.outlook.com (2603:10b6:a03:10b::14)
 by BYAPR12MB3127.namprd12.prod.outlook.com (2603:10b6:a03:d8::33)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.15; Tue, 15 Dec
 2020 07:34:50 +0000
Received: from BYAPR12MB4597.namprd12.prod.outlook.com
 ([fe80::dd10:efd2:e325:53c7]) by BYAPR12MB4597.namprd12.prod.outlook.com
 ([fe80::dd10:efd2:e325:53c7%3]) with mapi id 15.20.3654.021; Tue, 15 Dec 2020
 07:34:50 +0000
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: linux-kernel@vger.kernel.org,
	iommu@lists.linux-foundation.org
Subject: [PATCH v4 11/13] iommu/amd: Introduce iommu_v1_iova_to_phys
Date: Tue, 15 Dec 2020 01:37:03 -0600
Message-Id: <20201215073705.123786-12-suravee.suthikulpanit@amd.com>
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
 15.20.3654.12 via Frontend Transport; Tue, 15 Dec 2020 07:34:49 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: cafd9b72-cbec-4285-16fe-08d8a0cbe813
X-MS-TrafficTypeDiagnostic: BYAPR12MB3127:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB31271ECB830EF9DE5F866FEDF3C60@BYAPR12MB3127.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fIs1e/De00lrZ6jsPaM1C0TqZ9nNZgwkPe3ZZmKjp01sRC38DQZy8vmoSoKYvZnKfchHECeE22IFylRYbTMi16T67zhR8izQgG5rCT7WspywqxYvSyOExtLlBT1FKUGy/ilaVt4VGfkmoIiqMtg3ttgIhmvuM9F7VpIFSlmMEG50L2W5gbA7SGa2AG+S1vDTxceXmQptmOzCYLDtDViI8FnETJ8ZnHWjheGQhiGVvVgySWR0GZijXnvsFSFAIRuvk5rKJfw4A0kKOxCKiHGQtp2xSSi5Mp1ALwKU8mUqvOBF92W+qC/zw4PUdx4LzMftiVkoXOLNvFjo/eg+ihaZUYLD2IPZKZ+10UBjKqM4mgxtxpuzPs09Bt1ay3qy2a9/
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4597.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(346002)(376002)(66556008)(66476007)(66946007)(6486002)(34490700003)(2906002)(186003)(4326008)(508600001)(8676002)(956004)(6666004)(86362001)(2616005)(52116002)(7696005)(44832011)(36756003)(1076003)(5660300002)(16526019)(26005)(8936002)(83380400001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?tbAvmBk7Jfz0qj0DTWOziScdzFy5ctbP42tyLkyAaQsaaMqG5wev5jXQS3eb?=
 =?us-ascii?Q?ScuiPpDfPlAq4OwHKWJ+QApqoNGxcuCt/of4fw4WjwO2cmX5s6dVlmdjgZDV?=
 =?us-ascii?Q?sQLlonIHu3k0FMRSv9skb6Qrg/xOySZHFwTjz7EQxcG1fRAM41y8kJGha0Lu?=
 =?us-ascii?Q?8k9PCzfIEQNpsAhGTAiMbFrNsquPvRsiU21vLTnr6Vbv862quzpu7ymJfFu/?=
 =?us-ascii?Q?qssA2x/+m2ZSrq6ROlgkuxPFE0ssvcOxKUbq4zX6X4YgBmAV4YhOpEx2ZS5F?=
 =?us-ascii?Q?v3Z1+tHg3u2KC3TfiOCa6icNfK2+cmgvhvly864tYKCUoTjsJFNeKN/otHhx?=
 =?us-ascii?Q?SeVuKZ4zLV4pPh8BbysN2IaxS5aDOg5f3oER2M7/Jp/Um5VtFhgkMUREkLuD?=
 =?us-ascii?Q?9pSxaKz/5llky9dYm7aGuLivEbVORGgWmR7Fv9L9eqiFP6msHX39bvKhTFBy?=
 =?us-ascii?Q?nXurpvQ7QeBzenu84iKTNZjkPPYMjZ8XoYsEVPsn1vm6++Og/VSlb44a9xbv?=
 =?us-ascii?Q?SISnxENmv02MCKqHdh0Aqj/q8EbwIxwEYftTGS08HDSKV81FlEXUIl/t0XUu?=
 =?us-ascii?Q?F/BuDxBXMxDTgplS09X7U0UQua2mats3MxjNTnGt75kE4ECLau1RptGWvks8?=
 =?us-ascii?Q?JIykNphSiATxMyj8VOdkZ2YcTqZjtZfe8FG6HJBNgllzmi2S6J64PZr6YuHk?=
 =?us-ascii?Q?1Ewk1WMB9VPDtBKYNfanRsB/iKR3diYaIch2i8qqjBupzRr3VVMnDIKJ8gYO?=
 =?us-ascii?Q?udr0uCRJxb8abJtGp3YiAX7ngIGQw/1dE9oeR1ZHaNv1i9hTyhSWqvE7JYW6?=
 =?us-ascii?Q?aKLPST4t93BzxItlY+R7Iq5cgRs9eWYWmGNJTeJMH+IFiFrGD39/l0/V3t8t?=
 =?us-ascii?Q?6cTl6b2fAWe9AlvvLrbLOcqe3u/HDdvrips6MymOpLGAiIjVS/ZluJdTS6P8?=
 =?us-ascii?Q?vqjFXAPBKS8zoYh2YZkac8LkxcFt2im4PcwQEQupQCiH1jlBxFh3kwHi8wxj?=
 =?us-ascii?Q?mu5Q?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4597.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2020 07:34:50.4615 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-Network-Message-Id: cafd9b72-cbec-4285-16fe-08d8a0cbe813
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hJz0SdJJHXCEskLABHYquQwfO7cbsdcjMPTN0ELrIAD8SdFKtIzwExL8DyQIQhQ2yt1XoXbmzMnSAGrZ64iG3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3127
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

This implements iova_to_phys for AMD IOMMU v1 pagetable,
which will be used by the IO page table framework.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/io_pgtable.c | 22 ++++++++++++++++++++++
 drivers/iommu/amd/iommu.c      | 16 +---------------
 2 files changed, 23 insertions(+), 15 deletions(-)

diff --git a/drivers/iommu/amd/io_pgtable.c b/drivers/iommu/amd/io_pgtable.c
index 87184b6cee0f..a293b69b38b9 100644
--- a/drivers/iommu/amd/io_pgtable.c
+++ b/drivers/iommu/amd/io_pgtable.c
@@ -494,6 +494,26 @@ unsigned long iommu_unmap_page(struct protection_domain *dom,
 	return unmapped;
 }
 
+static phys_addr_t iommu_v1_iova_to_phys(struct io_pgtable_ops *ops, unsigned long iova)
+{
+	struct amd_io_pgtable *pgtable = io_pgtable_ops_to_data(ops);
+	unsigned long offset_mask, pte_pgsize;
+	u64 *pte, __pte;
+
+	if (pgtable->mode == PAGE_MODE_NONE)
+		return iova;
+
+	pte = fetch_pte(pgtable, iova, &pte_pgsize);
+
+	if (!pte || !IOMMU_PTE_PRESENT(*pte))
+		return 0;
+
+	offset_mask = pte_pgsize - 1;
+	__pte	    = __sme_clr(*pte & PM_ADDR_MASK);
+
+	return (__pte & ~offset_mask) | (iova & offset_mask);
+}
+
 /*
  * ----------------------------------------------------
  */
@@ -534,6 +554,8 @@ static struct io_pgtable *v1_alloc_pgtable(struct io_pgtable_cfg *cfg, void *coo
 	cfg->oas            = IOMMU_OUT_ADDR_BIT_SIZE,
 	cfg->tlb            = &v1_flush_ops;
 
+	pgtable->iop.ops.iova_to_phys = iommu_v1_iova_to_phys;
+
 	return &pgtable->iop;
 }
 
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 76f61dd6b89f..29b7fefc8485 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2101,22 +2101,8 @@ static phys_addr_t amd_iommu_iova_to_phys(struct iommu_domain *dom,
 {
 	struct protection_domain *domain = to_pdomain(dom);
 	struct io_pgtable_ops *ops = &domain->iop.iop.ops;
-	struct amd_io_pgtable *pgtable = io_pgtable_ops_to_data(ops);
-	unsigned long offset_mask, pte_pgsize;
-	u64 *pte, __pte;
 
-	if (domain->iop.mode == PAGE_MODE_NONE)
-		return iova;
-
-	pte = fetch_pte(pgtable, iova, &pte_pgsize);
-
-	if (!pte || !IOMMU_PTE_PRESENT(*pte))
-		return 0;
-
-	offset_mask = pte_pgsize - 1;
-	__pte	    = __sme_clr(*pte & PM_ADDR_MASK);
-
-	return (__pte & ~offset_mask) | (iova & offset_mask);
+	return ops->iova_to_phys(ops, iova);
 }
 
 static bool amd_iommu_capable(enum iommu_cap cap)
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
