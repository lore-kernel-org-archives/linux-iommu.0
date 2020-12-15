Return-Path: <SRS0=8938=FT=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 474A5C2BB48
	for <iommu@archiver.kernel.org>; Tue, 15 Dec 2020 08:08:06 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5370222B3
	for <iommu@archiver.kernel.org>; Tue, 15 Dec 2020 08:08:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5370222B3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 8DABD8740F;
	Tue, 15 Dec 2020 08:08:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id B1wvP5WYclDQ; Tue, 15 Dec 2020 08:08:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id D53FB87401;
	Tue, 15 Dec 2020 08:08:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C789CC1DA2;
	Tue, 15 Dec 2020 08:08:04 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BBF34C0893
 for <iommu@lists.linux-foundation.org>; Tue, 15 Dec 2020 08:08:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id B1A3386F67
 for <iommu@lists.linux-foundation.org>; Tue, 15 Dec 2020 08:08:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GRgzmhFX8Vbe for <iommu@lists.linux-foundation.org>;
 Tue, 15 Dec 2020 08:08:01 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770041.outbound.protection.outlook.com [40.107.77.41])
 by hemlock.osuosl.org (Postfix) with ESMTPS id CA26487038
 for <iommu@lists.linux-foundation.org>; Tue, 15 Dec 2020 08:08:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dLWVLoiznIeyix2ummtI6JFq2yAq49ROJ4/feGyQ0Mhg90JlepBJpwIjN1BcLWp+kIWcGDHXe0dbN2ldFYwixwyMpgLSX1tIkbEyqTfJQXdk8ySI3+4+2TqmRX5401W9H0G1qpTtI35NAA4GG/JYfS9TaCGpaGYGCpzDBG+HZ3XQ9VJ4YIybA0sO0ApoZrDP1Vk+NCWTeNI75mcYnIeS+xzy3RZINW0CfdQM4VgK8hM0jNARtb12WIVvecABxoRVxz9LK+CGrKXbOtT/XgDwaaC9EeBC8rWM7gjvS/wqEwEtisTQtcg1GtKZ1Q89ylzD7LytAHN5TLnx6eS7lyCx/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s0Iwc/dus5JcVcjE/rVwsfPp+Le8bkSF7b+ndBqkUxw=;
 b=Qov75OiJRtVU/+5yIICZ6rCcjqWVH/L1pZQWz1/yM24gQRIJxLyf3tHHv9AoySJRYAiKmLh4tYCVHtk7QZOL/SuFzilVNx7qIj825kgAff38pw4YZfqjcB+4mmFrS54NeTTy1SbzlvZeiXgf60ygC6nWEIA4j2rP/4vp558cJp9NoqH/hq9LlIXoqaHg+PXZiwbC9X0UW03a0lRmKz7oO3shpEDFf/LS83McsIGhK8aSJTHrEqYlzEdAejMgvxFqU64TyWLG3y6iGPcj2sxgeDSJ1AJ9EnQUK+tHnp80NjZ6pcLf6L2SbQoyinm9yxDKuPmjZQTFNT43MLabDX93JA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s0Iwc/dus5JcVcjE/rVwsfPp+Le8bkSF7b+ndBqkUxw=;
 b=EsOUy5vTBd+MpqPhQNJprsQ96dWEZ96bYd5DzI7Tk7dQVgc2Znejhugo8fm/V2JA6pNf8jwiOloAth2i8LYOxqEloxagujEwabpcgx6pIOhYAKqEjW7HwWao+rmqfYWYNV9qpSPMXCYLuPt4gI9VUgtv64ZqFni6lQECnFXQ6NE=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4597.namprd12.prod.outlook.com (2603:10b6:a03:10b::14)
 by BYAPR12MB3127.namprd12.prod.outlook.com (2603:10b6:a03:d8::33)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.15; Tue, 15 Dec
 2020 07:34:49 +0000
Received: from BYAPR12MB4597.namprd12.prod.outlook.com
 ([fe80::dd10:efd2:e325:53c7]) by BYAPR12MB4597.namprd12.prod.outlook.com
 ([fe80::dd10:efd2:e325:53c7%3]) with mapi id 15.20.3654.021; Tue, 15 Dec 2020
 07:34:49 +0000
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: linux-kernel@vger.kernel.org,
	iommu@lists.linux-foundation.org
Subject: [PATCH v4 10/13] iommu/amd: Refactor fetch_pte to use struct
 amd_io_pgtable
Date: Tue, 15 Dec 2020 01:37:02 -0600
Message-Id: <20201215073705.123786-11-suravee.suthikulpanit@amd.com>
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
 15.20.3654.12 via Frontend Transport; Tue, 15 Dec 2020 07:34:48 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 05b86f93-9aa3-4eac-54b6-08d8a0cbe786
X-MS-TrafficTypeDiagnostic: BYAPR12MB3127:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB31277C43B1695F9C5248AF0EF3C60@BYAPR12MB3127.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rhl0jiYs3salZzo5uB5eV32vIOhUL6uEWbmO/IBKQwZbmU3uRhNrfWorIQoSgn32nFHgnXZzWSdG2wRlh5pC9cAhsdRnK8+XwuxpUK+OnXAaNnP7HHRNv9AeIQe6f290w33B63I75uSDzY1RlEzMgSAeRPSvLqbOAYpSZe6EgF5Fn+rx+/Zga9XhiD/pZlA2IiCWMy58tdnsA10GRioLpM+8Ipb1pzhcXFGKbn3ApsE8C1fzjR9jqiUrYA7NFlaWnlbIhZnXCCwyWHFomhK0QsZyzF8vgbwiIL/FCBkm3fQlI+twpFBeZ/k/HGPrLHKAj7jXCO4Vwo5/cg9KdCDU+6M8esC52OoCmDxwubOQGr19FkZblCVIT5CE0LipqLwM
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4597.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(346002)(376002)(66556008)(66476007)(66946007)(6486002)(34490700003)(2906002)(186003)(4326008)(508600001)(8676002)(956004)(6666004)(86362001)(2616005)(52116002)(7696005)(44832011)(36756003)(1076003)(5660300002)(16526019)(26005)(8936002)(83380400001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?NT4qswGcF5LhcpyVR5qJynoGP/Le9Ibc8i15aInkpB9RpcAapm7hJUD2j4Sm?=
 =?us-ascii?Q?3MpxGMEPRjoluIIZhIwbw6z18KPIbxyzs+vZMAJtimFNFsFzcYWwcEKFxetl?=
 =?us-ascii?Q?J1VtWYE/2/lPkYuWRc+R946fgYtF7uSTh4+21uxzluBw+oj/kpFXYDlTvscO?=
 =?us-ascii?Q?nAockN3+56GqhywpKQPEZp9Cd4Az4Lz458zZ7q00h+Q1cKy0Dei64FvYkUgs?=
 =?us-ascii?Q?AkuGD8dAg+MomyvV4ajRsQ30gM+BoR0vHT4zFe4+pTn9mKXWoY19EM9eRNIe?=
 =?us-ascii?Q?iJj2C1Sz+31DV6Q7zliL2+2Md26KdUEWC634XW+yyoGJT9W5DZwtJZ0YnVHE?=
 =?us-ascii?Q?bNSlKoIWqxhKP2cfVYd3Mps8XIv09O1yiE1n487l5vLtKLPnAQ9Xa+4dBEJX?=
 =?us-ascii?Q?yQllw2jKRFuaao9JZuKUgzagGGqFZjvNnl1jDlSuSGO087KZcsbzc2Z2FPFZ?=
 =?us-ascii?Q?A33cAk76Za2bdHlX+BJlkeNznCHDFKtRnGltoF+gml0uzFod22mt2Nq2gnuC?=
 =?us-ascii?Q?M2ru446/X5gWdEeOuy381pEZDQ2JSHdGBixnCqab/1ne9Sc4myp10Ae+X46N?=
 =?us-ascii?Q?2R/JGiLmfRlyYZeCoc0svW3PWtmin3kWXnfsf+sR0XF6Xyi+neLyrvnaKDW4?=
 =?us-ascii?Q?DWgIUfIjbahpMT8KQE3Z5ZSyKL6aiTL7R2aPiVHatMT9A7Kt+KPiWqbFvY6b?=
 =?us-ascii?Q?P2kBgNHcYrSQZr9FCm6TSadXgNxPiGRTBlf1tBc2gPqbqtRi5+46daJKw/lw?=
 =?us-ascii?Q?//bErij+Fe2AH3E1zOIhvFecignFsvdqdZ369qTdOgtoewg+f8+hnVS1SHVp?=
 =?us-ascii?Q?yP+7n2EGiLyKCLMGRBUuTw65txNVGuWoGXP+WDLlfojtT7Fe2jJKyBuRg9hL?=
 =?us-ascii?Q?68DZG6dfnQ44ZIl9tEOI+1UOv+UtpHb5ihWSg42qoY0FBCI/Za+AGvlOB6rU?=
 =?us-ascii?Q?SojDiLnzRv5GZkiD+sBC7sifGJ1vZp+I7Vr3QpRecNWuv2uJJueA0w4SYRY+?=
 =?us-ascii?Q?tLwV?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4597.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2020 07:34:49.5591 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-Network-Message-Id: 05b86f93-9aa3-4eac-54b6-08d8a0cbe786
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6Id+trp1fMyFLR/5o7NTfY748vM2v+4rVthvJJToBZQPsPltcBQhJ69N/mQz2oigsITlr2KvCYOs7Yzz3crkaQ==
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

To simplify the fetch_pte function. There is no functional change.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/amd_iommu.h  |  2 +-
 drivers/iommu/amd/io_pgtable.c | 13 +++++++------
 drivers/iommu/amd/iommu.c      |  4 +++-
 3 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index 76276d9e463c..83ca822c5349 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -143,7 +143,7 @@ extern int iommu_map_page(struct protection_domain *dom,
 extern unsigned long iommu_unmap_page(struct protection_domain *dom,
 				      unsigned long bus_addr,
 				      unsigned long page_size);
-extern u64 *fetch_pte(struct protection_domain *domain,
+extern u64 *fetch_pte(struct amd_io_pgtable *pgtable,
 		      unsigned long address,
 		      unsigned long *page_size);
 extern void amd_iommu_domain_set_pgtable(struct protection_domain *domain,
diff --git a/drivers/iommu/amd/io_pgtable.c b/drivers/iommu/amd/io_pgtable.c
index 35dd9153e6b7..87184b6cee0f 100644
--- a/drivers/iommu/amd/io_pgtable.c
+++ b/drivers/iommu/amd/io_pgtable.c
@@ -317,7 +317,7 @@ static u64 *alloc_pte(struct protection_domain *domain,
  * This function checks if there is a PTE for a given dma address. If
  * there is one, it returns the pointer to it.
  */
-u64 *fetch_pte(struct protection_domain *domain,
+u64 *fetch_pte(struct amd_io_pgtable *pgtable,
 	       unsigned long address,
 	       unsigned long *page_size)
 {
@@ -326,11 +326,11 @@ u64 *fetch_pte(struct protection_domain *domain,
 
 	*page_size = 0;
 
-	if (address > PM_LEVEL_SIZE(domain->iop.mode))
+	if (address > PM_LEVEL_SIZE(pgtable->mode))
 		return NULL;
 
-	level	   =  domain->iop.mode - 1;
-	pte	   = &domain->iop.root[PM_LEVEL_INDEX(level, address)];
+	level	   =  pgtable->mode - 1;
+	pte	   = &pgtable->root[PM_LEVEL_INDEX(level, address)];
 	*page_size =  PTE_LEVEL_PAGE_SIZE(level);
 
 	while (level > 0) {
@@ -465,6 +465,8 @@ unsigned long iommu_unmap_page(struct protection_domain *dom,
 			       unsigned long iova,
 			       unsigned long size)
 {
+	struct io_pgtable_ops *ops = &dom->iop.iop.ops;
+	struct amd_io_pgtable *pgtable = io_pgtable_ops_to_data(ops);
 	unsigned long long unmapped;
 	unsigned long unmap_size;
 	u64 *pte;
@@ -474,8 +476,7 @@ unsigned long iommu_unmap_page(struct protection_domain *dom,
 	unmapped = 0;
 
 	while (unmapped < size) {
-		pte = fetch_pte(dom, iova, &unmap_size);
-
+		pte = fetch_pte(pgtable, iova, &unmap_size);
 		if (pte) {
 			int i, count;
 
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 2963a37b7c16..76f61dd6b89f 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2100,13 +2100,15 @@ static phys_addr_t amd_iommu_iova_to_phys(struct iommu_domain *dom,
 					  dma_addr_t iova)
 {
 	struct protection_domain *domain = to_pdomain(dom);
+	struct io_pgtable_ops *ops = &domain->iop.iop.ops;
+	struct amd_io_pgtable *pgtable = io_pgtable_ops_to_data(ops);
 	unsigned long offset_mask, pte_pgsize;
 	u64 *pte, __pte;
 
 	if (domain->iop.mode == PAGE_MODE_NONE)
 		return iova;
 
-	pte = fetch_pte(domain, iova, &pte_pgsize);
+	pte = fetch_pte(pgtable, iova, &pte_pgsize);
 
 	if (!pte || !IOMMU_PTE_PRESENT(*pte))
 		return 0;
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
