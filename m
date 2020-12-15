Return-Path: <SRS0=8938=FT=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D070C4361B
	for <iommu@archiver.kernel.org>; Tue, 15 Dec 2020 08:08:06 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A1C202228A
	for <iommu@archiver.kernel.org>; Tue, 15 Dec 2020 08:08:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1C202228A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 7090986C9B;
	Tue, 15 Dec 2020 08:08:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HFmyXShWzxn8; Tue, 15 Dec 2020 08:08:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id ADEC586C78;
	Tue, 15 Dec 2020 08:08:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8D094C0893;
	Tue, 15 Dec 2020 08:08:04 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AE72AC013B
 for <iommu@lists.linux-foundation.org>; Tue, 15 Dec 2020 08:08:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 98E4687053
 for <iommu@lists.linux-foundation.org>; Tue, 15 Dec 2020 08:08:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id c+CenG24T-Z7 for <iommu@lists.linux-foundation.org>;
 Tue, 15 Dec 2020 08:08:00 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770041.outbound.protection.outlook.com [40.107.77.41])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 7E23086F67
 for <iommu@lists.linux-foundation.org>; Tue, 15 Dec 2020 08:08:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EQafFmmuGJcqnQRCyodvHqxFfCuNvy/aXSx71Goy41Wr0u7Qo54fki9QinK/pbMFYHLCMRd6GDksdf7Z+xZiRAgwAHUZdHgHUODwix/QCGyqzUHF3gAAqrOtDKyGq0bcsNA//eULD79wWfjWOkydS484MKdmJ4e8zRUj+3DobiZY0x/kfKEGywNmoPyWWva67zj2Ghuma4wEyPqwYuVo2svVtDMkCgEE9TupHRo7/Sg+tp2VVBKR6gJfI2khFb0FEg+ym3TDMuB3tpV+hwLvZAXkG+AjiLoOMs7edaAmo2FB2GwbG6qN22vGHZ2zvNWLfaiQ6DlUia+q3QYKrZjzYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BsWgUNdpjsVLM8rtXnJ+3cNCPxgXfA+tG+jRSI/qRBU=;
 b=NjfDhEKfh6KEWQUrDpE+x0iQNewsswMlkbUcpIw+8C6wGLOVA6ClfKvTHWExe1HCRoFg6o5PlgRGAp6bQRqKhyvqpiRPd57xisu84H9jXAJvrRcXfkfk3M62vQ497mKgtJ/l3uaCy+X0SPQk6JTrSHVkVCweRqnAjbEPmtwTbdfUKtMS6kVkwugxQKBKinxXvhUGF8cGUs2NpkA71Y2gjzY4A/4cqQFZu+lqy3rklx2Eka4BcMiPq0DPuq1a5GPKiRiQLNinrFgEvMx3/21GoiXn+2AhPCpApqQqEdz/uf/zUFZKhndLjwQkjmeZjdLnq+9Hkdp4QqPUFtXBTmW2YQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BsWgUNdpjsVLM8rtXnJ+3cNCPxgXfA+tG+jRSI/qRBU=;
 b=UjqPvcis0QuLo8ma5/G/duUsPnWE21uw2tVTl2URe41AcmY+yZheYamEZpNRSMdqwXniTtdmcfT72AoFhT5+l3hv/TburJfvoJQtAvAXUMDN3bQSU9KmIvuLYvGbkdt+NtusplkonK2si/LyyzcJMFLPHS0HlJGsmC2AE/Ow6BQ=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4597.namprd12.prod.outlook.com (2603:10b6:a03:10b::14)
 by BYAPR12MB3127.namprd12.prod.outlook.com (2603:10b6:a03:d8::33)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.15; Tue, 15 Dec
 2020 07:34:53 +0000
Received: from BYAPR12MB4597.namprd12.prod.outlook.com
 ([fe80::dd10:efd2:e325:53c7]) by BYAPR12MB4597.namprd12.prod.outlook.com
 ([fe80::dd10:efd2:e325:53c7%3]) with mapi id 15.20.3654.021; Tue, 15 Dec 2020
 07:34:53 +0000
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: linux-kernel@vger.kernel.org,
	iommu@lists.linux-foundation.org
Subject: [PATCH v4 12/13] iommu/amd: Introduce iommu_v1_map_page and
 iommu_v1_unmap_page
Date: Tue, 15 Dec 2020 01:37:04 -0600
Message-Id: <20201215073705.123786-13-suravee.suthikulpanit@amd.com>
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
 15.20.3654.12 via Frontend Transport; Tue, 15 Dec 2020 07:34:51 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 722a5ec7-f56e-42e6-4630-08d8a0cbe9d5
X-MS-TrafficTypeDiagnostic: BYAPR12MB3127:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB31271FB9C918ADC9DBC08156F3C60@BYAPR12MB3127.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wm/ejjcWQvmQLTEWxSV+1Z84TvZy23sSZtyU5q2SS/P1tZKUqNR4HKFmaqB8LXIzyIkaR50Jxday7piRct9OEYJdRYTB8KYiQIfKUqm4LX2wGVn1gywEyvGcX055+eni8s/JD36dagmV4uXDpA9+TyzqWIDcf9tpKy9x2bT8DrydgmdaVXLusPQ6mRsAEy10ZjJV5hh6rAOCqJIrxyIGV2xBiM8puuhkV1cJL2MQq/wB9kojZPTxuo9D5P78cMp6/PSXvX/x6ejoPLqQyhZAP5FHPCHqQxEJ1+w7Ou88iCk0KE2pNHn9p6DEsXbLhO5ZRXihxtqRgLJTbGI9+pHdbizGMaLIXRL1GyQr9vexAQYDrUjC56DeQgqUg/tK1ur2
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4597.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(346002)(376002)(66556008)(66476007)(66946007)(6486002)(34490700003)(2906002)(186003)(4326008)(508600001)(8676002)(956004)(6666004)(86362001)(2616005)(52116002)(7696005)(44832011)(36756003)(1076003)(5660300002)(16526019)(26005)(8936002)(83380400001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?pJclH9+X5jYAUtQWLAjMYSYmOeKgzZvUGGzpl5vwL+lwWYgOTW8n2LCF8h3k?=
 =?us-ascii?Q?FyTvOoWXws0fcS8Q9TYSpKIigkFvvmeUDtm4n2qvv9kQxVdMSqquD0815DVX?=
 =?us-ascii?Q?ZHvcfscX7AQwoRV3jMPCfZ37kLjTdC0YynN28M5tnT+vWUlfJSgRez68DbKf?=
 =?us-ascii?Q?YAWJMvrYI5gx0m1dg/ggeyKh6//vuMKdCxPFHsdxRCh4imMdUsvdBg4+rObS?=
 =?us-ascii?Q?oaOwfkKI6YdsUSYUGzBpi2d5kwrZo2jsfealn69uHWNPehaBfWXq43ardTbm?=
 =?us-ascii?Q?YQOOLA3yrBUt765O1juuCCng4fLWA0MdyvURfSCeApu5qqPKCWCPGkLaOkoA?=
 =?us-ascii?Q?Zmx3MUYV0rv2qTqbp4IOKKQbVNvlFw8yPmwsctpNLS7ykL8KRkB7qDL9+yxH?=
 =?us-ascii?Q?HxmH+NxiVmJtcCNU7lEw4OVqAyzfwbcoLjxa5C3SJCnUFmweHHAbcjp51m/2?=
 =?us-ascii?Q?Xwy1nRe6w3FDCh/gVxwojH02oC3fdXhrqX8Cs+nxzdbvpmmr+P3BHnYTvMk0?=
 =?us-ascii?Q?SsSRscB/+1imnkymprYeL2ka9K/UKC8nBxZISxTIFt/PESxt+mOvJoacxnRu?=
 =?us-ascii?Q?+hQ8qsbAqmriqvPdbz6O1xZmSV/lHJxwbJ1yOuWZ8C6RYyLMxn8o5+ADtMG0?=
 =?us-ascii?Q?S9DEp1Hrjkn+Zf/B6INPPPoJcW8T8IE8eY/ufqeLFc9Y4qvSZRiKQFO9UAR9?=
 =?us-ascii?Q?iL6tuS7/ycC2RpIAV6f/rYg4Zdgr8x1jkuJZS7OspGkToaHW60Hx37sV50zb?=
 =?us-ascii?Q?iDRhKEEVZ+knP2v4UCP1/h8ZaD7z9fs2nWBCKM82pGLViWvTK4+BSHOHVUFf?=
 =?us-ascii?Q?tKP/3RnO9unQZZQgrnuVz2EfxxuA+k6RJW1paFROOlx0TcV//ZQ8CN+0gzhy?=
 =?us-ascii?Q?xmD7PCS2GdJAX2d4w1+IVJwd4IO7KLhknuAjWbwi0D/FgjUAkRCLHm2Xn5Wh?=
 =?us-ascii?Q?21T9O64Al5FHutkDG8qCV2zfkgdoOcPk+2gVzYxRPldp6MNkbyF+s3sL9UTE?=
 =?us-ascii?Q?gA1d?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4597.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2020 07:34:53.2120 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-Network-Message-Id: 722a5ec7-f56e-42e6-4630-08d8a0cbe9d5
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bxDZdKtIKhDyW6qJ2ennYwhYBEjc4P1pPHQ0RBu8RAY0h0bNg6tF4tguX+b1oIiuoUYhCotohh+FYNZ2+fpiEQ==
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

These implement map and unmap for AMD IOMMU v1 pagetable, which
will be used by the IO pagetable framework.

Also clean up unused extern function declarations.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/amd_iommu.h  | 13 -------------
 drivers/iommu/amd/io_pgtable.c | 25 ++++++++++++-------------
 drivers/iommu/amd/iommu.c      | 13 ++++++++-----
 3 files changed, 20 insertions(+), 31 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index 83ca822c5349..3770b1a4d51c 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -133,19 +133,6 @@ void amd_iommu_apply_ivrs_quirks(void);
 static inline void amd_iommu_apply_ivrs_quirks(void) { }
 #endif
 
-/* TODO: These are temporary and will be removed once fully transition */
-extern int iommu_map_page(struct protection_domain *dom,
-			  unsigned long bus_addr,
-			  unsigned long phys_addr,
-			  unsigned long page_size,
-			  int prot,
-			  gfp_t gfp);
-extern unsigned long iommu_unmap_page(struct protection_domain *dom,
-				      unsigned long bus_addr,
-				      unsigned long page_size);
-extern u64 *fetch_pte(struct amd_io_pgtable *pgtable,
-		      unsigned long address,
-		      unsigned long *page_size);
 extern void amd_iommu_domain_set_pgtable(struct protection_domain *domain,
 					 u64 *root, int mode);
 #endif
diff --git a/drivers/iommu/amd/io_pgtable.c b/drivers/iommu/amd/io_pgtable.c
index a293b69b38b9..d91964e98d58 100644
--- a/drivers/iommu/amd/io_pgtable.c
+++ b/drivers/iommu/amd/io_pgtable.c
@@ -317,9 +317,9 @@ static u64 *alloc_pte(struct protection_domain *domain,
  * This function checks if there is a PTE for a given dma address. If
  * there is one, it returns the pointer to it.
  */
-u64 *fetch_pte(struct amd_io_pgtable *pgtable,
-	       unsigned long address,
-	       unsigned long *page_size)
+static u64 *fetch_pte(struct amd_io_pgtable *pgtable,
+		      unsigned long address,
+		      unsigned long *page_size)
 {
 	int level;
 	u64 *pte;
@@ -392,13 +392,10 @@ static struct page *free_clear_pte(u64 *pte, u64 pteval, struct page *freelist)
  * supporting all features of AMD IOMMU page tables like level skipping
  * and full 64 bit address spaces.
  */
-int iommu_map_page(struct protection_domain *dom,
-		   unsigned long iova,
-		   unsigned long paddr,
-		   unsigned long size,
-		   int prot,
-		   gfp_t gfp)
+static int iommu_v1_map_page(struct io_pgtable_ops *ops, unsigned long iova,
+			  phys_addr_t paddr, size_t size, int prot, gfp_t gfp)
 {
+	struct protection_domain *dom = io_pgtable_ops_to_domain(ops);
 	struct page *freelist = NULL;
 	bool updated = false;
 	u64 __pte, *pte;
@@ -461,11 +458,11 @@ int iommu_map_page(struct protection_domain *dom,
 	return ret;
 }
 
-unsigned long iommu_unmap_page(struct protection_domain *dom,
-			       unsigned long iova,
-			       unsigned long size)
+static unsigned long iommu_v1_unmap_page(struct io_pgtable_ops *ops,
+				      unsigned long iova,
+				      size_t size,
+				      struct iommu_iotlb_gather *gather)
 {
-	struct io_pgtable_ops *ops = &dom->iop.iop.ops;
 	struct amd_io_pgtable *pgtable = io_pgtable_ops_to_data(ops);
 	unsigned long long unmapped;
 	unsigned long unmap_size;
@@ -554,6 +551,8 @@ static struct io_pgtable *v1_alloc_pgtable(struct io_pgtable_cfg *cfg, void *coo
 	cfg->oas            = IOMMU_OUT_ADDR_BIT_SIZE,
 	cfg->tlb            = &v1_flush_ops;
 
+	pgtable->iop.ops.map          = iommu_v1_map_page;
+	pgtable->iop.ops.unmap        = iommu_v1_unmap_page;
 	pgtable->iop.ops.iova_to_phys = iommu_v1_iova_to_phys;
 
 	return &pgtable->iop;
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 29b7fefc8485..1f04b251f0c6 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2066,8 +2066,9 @@ static int amd_iommu_map(struct iommu_domain *dom, unsigned long iova,
 			 gfp_t gfp)
 {
 	struct protection_domain *domain = to_pdomain(dom);
+	struct io_pgtable_ops *ops = &domain->iop.iop.ops;
 	int prot = 0;
-	int ret;
+	int ret = -EINVAL;
 
 	if (domain->iop.mode == PAGE_MODE_NONE)
 		return -EINVAL;
@@ -2077,9 +2078,10 @@ static int amd_iommu_map(struct iommu_domain *dom, unsigned long iova,
 	if (iommu_prot & IOMMU_WRITE)
 		prot |= IOMMU_PROT_IW;
 
-	ret = iommu_map_page(domain, iova, paddr, page_size, prot, gfp);
-
-	domain_flush_np_cache(domain, iova, page_size);
+	if (ops->map) {
+		ret = ops->map(ops, iova, paddr, page_size, prot, gfp);
+		domain_flush_np_cache(domain, iova, page_size);
+	}
 
 	return ret;
 }
@@ -2089,11 +2091,12 @@ static size_t amd_iommu_unmap(struct iommu_domain *dom, unsigned long iova,
 			      struct iommu_iotlb_gather *gather)
 {
 	struct protection_domain *domain = to_pdomain(dom);
+	struct io_pgtable_ops *ops = &domain->iop.iop.ops;
 
 	if (domain->iop.mode == PAGE_MODE_NONE)
 		return 0;
 
-	return iommu_unmap_page(domain, iova, page_size);
+	return (ops->unmap) ? ops->unmap(ops, iova, page_size, gather) : 0;
 }
 
 static phys_addr_t amd_iommu_iova_to_phys(struct iommu_domain *dom,
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
