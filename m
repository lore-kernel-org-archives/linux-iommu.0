Return-Path: <SRS0=8938=FT=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E1B0C4361B
	for <iommu@archiver.kernel.org>; Tue, 15 Dec 2020 07:50:51 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D534F22273
	for <iommu@archiver.kernel.org>; Tue, 15 Dec 2020 07:50:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D534F22273
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id A754B8759F;
	Tue, 15 Dec 2020 07:50:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hNyPW5PQ+q2C; Tue, 15 Dec 2020 07:50:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id B7041875C5;
	Tue, 15 Dec 2020 07:50:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A32A8C0893;
	Tue, 15 Dec 2020 07:50:49 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2E04FC013B
 for <iommu@lists.linux-foundation.org>; Tue, 15 Dec 2020 07:50:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 1D079873FE
 for <iommu@lists.linux-foundation.org>; Tue, 15 Dec 2020 07:50:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0bilCE-TZ1SE for <iommu@lists.linux-foundation.org>;
 Tue, 15 Dec 2020 07:50:46 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2058.outbound.protection.outlook.com [40.107.223.58])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 49081873F9
 for <iommu@lists.linux-foundation.org>; Tue, 15 Dec 2020 07:50:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U3ResMgmpyFw4AIhQHLCIZw0yQXGWnF4Qo8isGoySCCWt3xYxmjfqwqvBtDj5M/jd80lVliwB7wARxQGzKYK2nq9VgA/RfF3cOB8nqwFstesTc2avqHmGfRhOIxlLiiCfvwx9vIC7+GF9KxAXrbAqaRtuUGbElnbblPje0in6RPJKrsYUMp+VpfJpe7h02Vdmavps9v+QqNe8S3lziegtmc/fnMXi8tcGZHAPa+ILfQNC0fusO2jZhsAoSfu7/Qs6tGs247EeSmDeqFZW1jPqEZqlyuVidBUfXFalWxF2HltCQqKEM88jj0oJKTWAm/1AKuG8r8GiM2PnN1i/rA2Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eeXyi1ciE14UVkTcq4FyRAfePPN5CB8fblkfoZf1/Zw=;
 b=hdDvUQXLZB+KFNJf4pQPf16bubdvWcmIDcIe/kUTUWlV5dM4VYdDjuGlylkNw3Gu52GT6zJppsExxltkS+0IxRvyJ6IHVRJY58q4y8Q5gaGOp65p3YEIyZCzBYZMO8DiWAPKXwnbuhyvcxWsfcYihBlhjkz9f8t2jiZozEsWyrxE/YZCa03cGCV2+edYYQNBxV06gy7hLLXToObUD72FgGKk5mOHI4x359fJ/dQL6r0QiTX76c6fV9/ryJAT4F5HiugRfKjGGhF1q7Ihhu4n+N+fkQzVZIyvPRF46GZYO+esgQE5InsDL3SEq83xj3abM6pXpzmn+ydzrPLuXCcJ2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eeXyi1ciE14UVkTcq4FyRAfePPN5CB8fblkfoZf1/Zw=;
 b=CnrK4dO5VO3sITmXgEwnnC7ErtvqUdYNZBRNjmbD6xrhO22aDu982pgg+I5sGSU9d2SxrLJm6BCHd8mx4gFlz/OjuPREQ544ftoEFeCtLI61dvas7ffPP6EldJxRxO3wil2MeCI0XipEWAB66wYaoDo+PT94wQK3/hsmCdy2y6Y=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4597.namprd12.prod.outlook.com (2603:10b6:a03:10b::14)
 by BYAPR12MB3127.namprd12.prod.outlook.com (2603:10b6:a03:d8::33)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.15; Tue, 15 Dec
 2020 07:34:48 +0000
Received: from BYAPR12MB4597.namprd12.prod.outlook.com
 ([fe80::dd10:efd2:e325:53c7]) by BYAPR12MB4597.namprd12.prod.outlook.com
 ([fe80::dd10:efd2:e325:53c7%3]) with mapi id 15.20.3654.021; Tue, 15 Dec 2020
 07:34:48 +0000
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: linux-kernel@vger.kernel.org,
	iommu@lists.linux-foundation.org
Subject: [PATCH v4 08/13] iommu/amd: Remove amd_iommu_domain_get_pgtable
Date: Tue, 15 Dec 2020 01:37:00 -0600
Message-Id: <20201215073705.123786-9-suravee.suthikulpanit@amd.com>
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
 15.20.3654.12 via Frontend Transport; Tue, 15 Dec 2020 07:34:46 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ecff399b-8064-4474-b754-08d8a0cbe69a
X-MS-TrafficTypeDiagnostic: BYAPR12MB3127:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB3127334345936DB06B51CC32F3C60@BYAPR12MB3127.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NM4sTHH2NJV7AJwV/e+0/2H9OPHCoQpb2PJX8ZHYU0nlpdtdReUkaoeEW0QfBxV7EbUtNb8cMAcicaqUZ0p0CDVik9St0998TntqaEH6V/UpCgpheEGLEwXniAIjMc13fCS9ZvrteNF4eIz9EhSqW7NaVChV71w6UuAIrMVRXljTULImFRGGGnidmQoLkahOcDhJfx8hwO+Cycx1jYwXSYXafuWcgyUEAi0QFqvsldagMC26fLjOOogUP9d+h6kYeci2ve1aR0rZ/TFFNcb8dnfBYO3bzKbYM6bUZvxq4s59NFbbKDrmEQTrcwLbLHlfvpS5KToEqaJ1Q21c3yq773GW5st94jyIMiXvHyT6s4G8Fj/6EBJY07GPqxdqCdNm
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4597.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(346002)(376002)(66556008)(66476007)(66946007)(6486002)(34490700003)(2906002)(186003)(4326008)(508600001)(8676002)(956004)(6666004)(86362001)(2616005)(52116002)(7696005)(44832011)(36756003)(1076003)(5660300002)(16526019)(26005)(8936002)(83380400001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?b6KyffLcoV/dAzvu0A7SvLZDvET4IAJpS96KPS1UW7Oi3PR2UZZQsDqisdck?=
 =?us-ascii?Q?Vk12Kt/VTT/Q03iUCGpVzgzAUvcB4jn19lRhOMva7ogYnpoHHAGVWqwlvSP4?=
 =?us-ascii?Q?0H0Ocpd/q1EWvPt6Et7LGqwi8WfNRRfrHZD6na10I3aLpydqNZMlZtl38uZG?=
 =?us-ascii?Q?bWLEOLVEOX4CGVXW6WyoEUV3MLK4hYygRnW8kMPTjbKTSIo4UEdkNx35z9AG?=
 =?us-ascii?Q?kErai4sbRRRh9DDs9gX4VqnPb7RyDq8JxEK7l+bf6cIW/KwGZixHwYe+i8mu?=
 =?us-ascii?Q?ooBXnWZn7PAXxViGnthFc6ODa4UdPj6b9bZa7XFKLdANnfBlOdLseCUURpUV?=
 =?us-ascii?Q?NMONBfdknxaHWNBsVuUqJgdPloLRc4Y29z9//GHbZPYsb4nSYO0Q6eFkwgLX?=
 =?us-ascii?Q?NtLc1ED31Zh7tUtPLs0KGpdsIZaUpt3dGM2p/9gc+j1ZdfwJy+pVhJVAXbor?=
 =?us-ascii?Q?Vvl+xa3az/baM50NgojQQWIiqDJhBLAnZw0BJvHPgaekws+ASryuuDHiIrjl?=
 =?us-ascii?Q?jjcopKuDHx2OvdalDvCIM9aGn/fjv+PmHe/N8J5LZxeDPN4o3Lx60EvyAozH?=
 =?us-ascii?Q?y08yeb7sfuFht+du6T++WQS/8m/noc4ITHbzF6xI8s6ebXURP6v5yl2yR7XV?=
 =?us-ascii?Q?jNxaBP8ISQtxQXqgvfqlEi+/5N9tzmTz0MSdgjKnxuKnjW7njf5yJ6GD/Uv3?=
 =?us-ascii?Q?OGjTs/j0nVtIDJJbakWVbZbInLWm8brEkXleUVVAoITZx2oMqHE+WRTXJPrV?=
 =?us-ascii?Q?Gnyhu2sTzP/OlHBvTWkosJhd2NUHqqeU71APU0OlsBMuvQgSh1kryNVqhsZT?=
 =?us-ascii?Q?MBK0Yjuw308ggbEEiZLzkRJKv/PLnP8uyZoNqbcyfDT6TF7Uvltfehc3Fbak?=
 =?us-ascii?Q?4fA20N3lz89NJB8nJB2q8gJcismD/Seb4C/s6E7+EI1yu4AjN2sHWx/dRDlj?=
 =?us-ascii?Q?q6xpBoQpDXLz5fGcCqCgqqS2tiHMjvqeAiXIRsZ/90s=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4597.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2020 07:34:47.6621 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-Network-Message-Id: ecff399b-8064-4474-b754-08d8a0cbe69a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2GZfacovfiRDodl0xnzLo/9mJrdqbiQuaHSVuhxDYADiCGHHRsO6XmiWYm4JiGJR+l6BKhgH5NAq29RDm09ZCg==
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

Since the IO page table root and mode parameters have been moved into
the struct amd_io_pg, the function is no longer needed. Therefore,
remove it along with the struct domain_pgtable.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/amd_iommu.h       |  4 ++--
 drivers/iommu/amd/amd_iommu_types.h |  6 -----
 drivers/iommu/amd/io_pgtable.c      | 36 ++++++++++-------------------
 drivers/iommu/amd/iommu.c           | 34 ++++-----------------------
 4 files changed, 19 insertions(+), 61 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index 91d098003f12..76276d9e463c 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -110,6 +110,8 @@ static inline
 void amd_iommu_domain_set_pt_root(struct protection_domain *domain, u64 root)
 {
 	atomic64_set(&domain->iop.pt_root, root);
+	domain->iop.root = (u64 *)(root & PAGE_MASK);
+	domain->iop.mode = root & 7; /* lowest 3 bits encode pgtable mode */
 }
 
 static inline
@@ -144,8 +146,6 @@ extern unsigned long iommu_unmap_page(struct protection_domain *dom,
 extern u64 *fetch_pte(struct protection_domain *domain,
 		      unsigned long address,
 		      unsigned long *page_size);
-extern void amd_iommu_domain_get_pgtable(struct protection_domain *domain,
-					 struct domain_pgtable *pgtable);
 extern void amd_iommu_domain_set_pgtable(struct protection_domain *domain,
 					 u64 *root, int mode);
 #endif
diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 7c971c76d685..6897567d307e 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -518,12 +518,6 @@ struct protection_domain {
 	unsigned dev_iommu[MAX_IOMMUS]; /* per-IOMMU reference count */
 };
 
-/* For decocded pt_root */
-struct domain_pgtable {
-	int mode;
-	u64 *root;
-};
-
 /*
  * Structure where we save information about one hardware AMD IOMMU in the
  * system.
diff --git a/drivers/iommu/amd/io_pgtable.c b/drivers/iommu/amd/io_pgtable.c
index dc674e79ddf0..d4d131e43dcd 100644
--- a/drivers/iommu/amd/io_pgtable.c
+++ b/drivers/iommu/amd/io_pgtable.c
@@ -184,30 +184,27 @@ static bool increase_address_space(struct protection_domain *domain,
 				   unsigned long address,
 				   gfp_t gfp)
 {
-	struct domain_pgtable pgtable;
 	unsigned long flags;
 	bool ret = true;
 	u64 *pte;
 
 	spin_lock_irqsave(&domain->lock, flags);
 
-	amd_iommu_domain_get_pgtable(domain, &pgtable);
-
-	if (address <= PM_LEVEL_SIZE(pgtable.mode))
+	if (address <= PM_LEVEL_SIZE(domain->iop.mode))
 		goto out;
 
 	ret = false;
-	if (WARN_ON_ONCE(pgtable.mode == PAGE_MODE_6_LEVEL))
+	if (WARN_ON_ONCE(domain->iop.mode == PAGE_MODE_6_LEVEL))
 		goto out;
 
 	pte = (void *)get_zeroed_page(gfp);
 	if (!pte)
 		goto out;
 
-	*pte = PM_LEVEL_PDE(pgtable.mode, iommu_virt_to_phys(pgtable.root));
+	*pte = PM_LEVEL_PDE(domain->iop.mode, iommu_virt_to_phys(domain->iop.root));
 
-	pgtable.root  = pte;
-	pgtable.mode += 1;
+	domain->iop.root  = pte;
+	domain->iop.mode += 1;
 	amd_iommu_update_and_flush_device_table(domain);
 	amd_iommu_domain_flush_complete(domain);
 
@@ -215,7 +212,7 @@ static bool increase_address_space(struct protection_domain *domain,
 	 * Device Table needs to be updated and flushed before the new root can
 	 * be published.
 	 */
-	amd_iommu_domain_set_pgtable(domain, pte, pgtable.mode);
+	amd_iommu_domain_set_pgtable(domain, pte, domain->iop.mode);
 
 	ret = true;
 
@@ -232,29 +229,23 @@ static u64 *alloc_pte(struct protection_domain *domain,
 		      gfp_t gfp,
 		      bool *updated)
 {
-	struct domain_pgtable pgtable;
 	int level, end_lvl;
 	u64 *pte, *page;
 
 	BUG_ON(!is_power_of_2(page_size));
 
-	amd_iommu_domain_get_pgtable(domain, &pgtable);
-
-	while (address > PM_LEVEL_SIZE(pgtable.mode)) {
+	while (address > PM_LEVEL_SIZE(domain->iop.mode)) {
 		/*
 		 * Return an error if there is no memory to update the
 		 * page-table.
 		 */
 		if (!increase_address_space(domain, address, gfp))
 			return NULL;
-
-		/* Read new values to check if update was successful */
-		amd_iommu_domain_get_pgtable(domain, &pgtable);
 	}
 
 
-	level   = pgtable.mode - 1;
-	pte     = &pgtable.root[PM_LEVEL_INDEX(level, address)];
+	level   = domain->iop.mode - 1;
+	pte     = &domain->iop.root[PM_LEVEL_INDEX(level, address)];
 	address = PAGE_SIZE_ALIGN(address, page_size);
 	end_lvl = PAGE_SIZE_LEVEL(page_size);
 
@@ -330,19 +321,16 @@ u64 *fetch_pte(struct protection_domain *domain,
 	       unsigned long address,
 	       unsigned long *page_size)
 {
-	struct domain_pgtable pgtable;
 	int level;
 	u64 *pte;
 
 	*page_size = 0;
 
-	amd_iommu_domain_get_pgtable(domain, &pgtable);
-
-	if (address > PM_LEVEL_SIZE(pgtable.mode))
+	if (address > PM_LEVEL_SIZE(domain->iop.mode))
 		return NULL;
 
-	level	   =  pgtable.mode - 1;
-	pte	   = &pgtable.root[PM_LEVEL_INDEX(level, address)];
+	level	   =  domain->iop.mode - 1;
+	pte	   = &domain->iop.root[PM_LEVEL_INDEX(level, address)];
 	*page_size =  PTE_LEVEL_PAGE_SIZE(level);
 
 	while (level > 0) {
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 37ecedce2c14..2963a37b7c16 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -139,15 +139,6 @@ static struct protection_domain *to_pdomain(struct iommu_domain *dom)
 	return container_of(dom, struct protection_domain, domain);
 }
 
-void amd_iommu_domain_get_pgtable(struct protection_domain *domain,
-				  struct domain_pgtable *pgtable)
-{
-	u64 pt_root = atomic64_read(&domain->iop.pt_root);
-
-	pgtable->root = (u64 *)(pt_root & PAGE_MASK);
-	pgtable->mode = pt_root & 7; /* lowest 3 bits encode pgtable mode */
-}
-
 static struct iommu_dev_data *alloc_dev_data(u16 devid)
 {
 	struct iommu_dev_data *dev_data;
@@ -1484,7 +1475,6 @@ static void clear_dte_entry(u16 devid)
 static void do_attach(struct iommu_dev_data *dev_data,
 		      struct protection_domain *domain)
 {
-	struct domain_pgtable pgtable;
 	struct amd_iommu *iommu;
 	bool ats;
 
@@ -1500,7 +1490,6 @@ static void do_attach(struct iommu_dev_data *dev_data,
 	domain->dev_cnt                 += 1;
 
 	/* Update device table */
-	amd_iommu_domain_get_pgtable(domain, &pgtable);
 	set_dte_entry(dev_data->devid, domain,
 		      ats, dev_data->iommu_v2);
 	clone_aliases(dev_data->pdev);
@@ -1827,10 +1816,7 @@ void amd_iommu_update_and_flush_device_table(struct protection_domain *domain)
 
 void amd_iommu_domain_update(struct protection_domain *domain)
 {
-	struct domain_pgtable pgtable;
-
 	/* Update device table */
-	amd_iommu_domain_get_pgtable(domain, &pgtable);
 	amd_iommu_update_and_flush_device_table(domain);
 
 	/* Flush domain TLB(s) and wait for completion */
@@ -2080,12 +2066,10 @@ static int amd_iommu_map(struct iommu_domain *dom, unsigned long iova,
 			 gfp_t gfp)
 {
 	struct protection_domain *domain = to_pdomain(dom);
-	struct domain_pgtable pgtable;
 	int prot = 0;
 	int ret;
 
-	amd_iommu_domain_get_pgtable(domain, &pgtable);
-	if (pgtable.mode == PAGE_MODE_NONE)
+	if (domain->iop.mode == PAGE_MODE_NONE)
 		return -EINVAL;
 
 	if (iommu_prot & IOMMU_READ)
@@ -2105,10 +2089,8 @@ static size_t amd_iommu_unmap(struct iommu_domain *dom, unsigned long iova,
 			      struct iommu_iotlb_gather *gather)
 {
 	struct protection_domain *domain = to_pdomain(dom);
-	struct domain_pgtable pgtable;
 
-	amd_iommu_domain_get_pgtable(domain, &pgtable);
-	if (pgtable.mode == PAGE_MODE_NONE)
+	if (domain->iop.mode == PAGE_MODE_NONE)
 		return 0;
 
 	return iommu_unmap_page(domain, iova, page_size);
@@ -2119,11 +2101,9 @@ static phys_addr_t amd_iommu_iova_to_phys(struct iommu_domain *dom,
 {
 	struct protection_domain *domain = to_pdomain(dom);
 	unsigned long offset_mask, pte_pgsize;
-	struct domain_pgtable pgtable;
 	u64 *pte, __pte;
 
-	amd_iommu_domain_get_pgtable(domain, &pgtable);
-	if (pgtable.mode == PAGE_MODE_NONE)
+	if (domain->iop.mode == PAGE_MODE_NONE)
 		return iova;
 
 	pte = fetch_pte(domain, iova, &pte_pgsize);
@@ -2493,11 +2473,9 @@ static u64 *__get_gcr3_pte(u64 *root, int level, u32 pasid, bool alloc)
 static int __set_gcr3(struct protection_domain *domain, u32 pasid,
 		      unsigned long cr3)
 {
-	struct domain_pgtable pgtable;
 	u64 *pte;
 
-	amd_iommu_domain_get_pgtable(domain, &pgtable);
-	if (pgtable.mode != PAGE_MODE_NONE)
+	if (domain->iop.mode != PAGE_MODE_NONE)
 		return -EINVAL;
 
 	pte = __get_gcr3_pte(domain->gcr3_tbl, domain->glx, pasid, true);
@@ -2511,11 +2489,9 @@ static int __set_gcr3(struct protection_domain *domain, u32 pasid,
 
 static int __clear_gcr3(struct protection_domain *domain, u32 pasid)
 {
-	struct domain_pgtable pgtable;
 	u64 *pte;
 
-	amd_iommu_domain_get_pgtable(domain, &pgtable);
-	if (pgtable.mode != PAGE_MODE_NONE)
+	if (domain->iop.mode != PAGE_MODE_NONE)
 		return -EINVAL;
 
 	pte = __get_gcr3_pte(domain->gcr3_tbl, domain->glx, pasid, false);
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
