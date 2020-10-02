Return-Path: <SRS0=Fz8+=DJ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFFC3C47423
	for <iommu@archiver.kernel.org>; Fri,  2 Oct 2020 12:25:01 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 78EB121707
	for <iommu@archiver.kernel.org>; Fri,  2 Oct 2020 12:25:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Gnxm5aec"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78EB121707
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 3DC9586672;
	Fri,  2 Oct 2020 12:25:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZT2z2BcgM4eI; Fri,  2 Oct 2020 12:25:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 41F2B8659E;
	Fri,  2 Oct 2020 12:25:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 18EDFC0895;
	Fri,  2 Oct 2020 12:25:00 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6B99DC0051
 for <iommu@lists.linux-foundation.org>; Fri,  2 Oct 2020 12:24:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 56537872E5
 for <iommu@lists.linux-foundation.org>; Fri,  2 Oct 2020 12:24:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 59JwRx6r+QzF for <iommu@lists.linux-foundation.org>;
 Fri,  2 Oct 2020 12:24:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2049.outbound.protection.outlook.com [40.107.237.49])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 75B58872E8
 for <iommu@lists.linux-foundation.org>; Fri,  2 Oct 2020 12:24:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bFC+7pkD1YOY67o/A56WzStzwpX+217M6mWiu092nep5Ecz6U4Sz45DWtfsmcpGZYXObZoQ4MI46ZgIERYpXX4aZ3SzZWs9aHvU0v8qNw5OasoZP63T6FD+4X1QNodT2naPURHn6fFk+BMZu8Hj6nMqb2UhZpOGYNx8jK4yolZUxmnQhsIYIPpcl1BgU8z6sUxSQgrZsbjufo79+7gIjkwwwZ0Pl6h1n8er0SnjkZj285DwgAXz5Qyplsb+JhBftdXaN7vHfzXQ1bmqLJmqVrcv/ONkFvvsLzH66GLnVIOZPETcCtTw1uJ/ImRryXclf1Nu2ThISAUL3iBMk14+PzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IlxHvNUgzb5RRU3QZPYnpxraByvym343QtS+7HD5uhI=;
 b=jAbzSGMKTBVCsS9y7LHBFkYaJIjWjB28bXPp7llRHm1Rn6LDm2LHazrtADZUbcr2LzMQQ/+OaWFsvrBP3H/5B8HGJj0b/h9BCKflkYPeiHNC7dE1FT1MVCIEIExiC32NSEi5VamQg4pQ83qQxpqsQz9O7O4OMriFCgH0boNnJwUvgrmOoxc3z2hI48IlK0gsyii1SWBIq2KlfYQdny+Sd03hIl/ksQWsN0YP3Qfdxw1SMMoWzYmIPJiALSaYLgao67THPs3iytQ4y4qfDmMAI7yaOn32m9IMF4uZgWf/WWiKybHawEkTNM4i3wPMQpn+hJllydFzwel4pCRdXIdjnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IlxHvNUgzb5RRU3QZPYnpxraByvym343QtS+7HD5uhI=;
 b=Gnxm5aec1b/7gVo7rdkgTXId4+mqsHDU0xgn/KU5iMxuzIbq0kH9xnzNQ3YxKBeXEAWLuHBb+Yy2kEgcfLF9/fUKIZ9TmpYru/P88L5UPIEozg/vlqHl2QSL7FBcaZEK7irh1v5GeDaBchJMH7UlzG3OPrGMqpcsiLi5o0WbjHE=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1163.namprd12.prod.outlook.com (2603:10b6:3:7a::18) by
 DM5PR12MB1163.namprd12.prod.outlook.com (2603:10b6:3:7a::18) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3433.32; Fri, 2 Oct 2020 12:24:56 +0000
Received: from DM5PR12MB1163.namprd12.prod.outlook.com
 ([fe80::48cf:d69:d457:1b1e]) by DM5PR12MB1163.namprd12.prod.outlook.com
 ([fe80::48cf:d69:d457:1b1e%5]) with mapi id 15.20.3433.039; Fri, 2 Oct 2020
 12:24:55 +0000
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: linux-kernel@vger.kernel.org,
	iommu@lists.linux-foundation.org
Subject: [PATCH v2 08/13] iommu/amd: Remove amd_iommu_domain_get_pgtable
Date: Fri,  2 Oct 2020 12:28:25 +0000
Message-Id: <20201002122830.4051-9-suravee.suthikulpanit@amd.com>
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
 15.20.3455.13 via Frontend Transport; Fri, 2 Oct 2020 12:24:54 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: da9a234c-f28d-4869-04e3-08d866ce2b7e
X-MS-TrafficTypeDiagnostic: DM5PR12MB1163:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB116376572DFD3D02D729D20AF3310@DM5PR12MB1163.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1TfUJgFd53jThx+5WrUD1xg5CRPuopSo1CLXOUEUF/i/1989R+lViuZd27pYcU8pWQuupyzBnG8qKZWb953JPnqwvhviUzI4ThOaxTY1E81/4aj9JYoBk4TuzjzqdZcT84GD/VkOQ2fGDjbh7ANXd7uDdlw0Qr4Cxc2YYbNYI6XfEEKOVH/+6195wG9Ds+5tvAwUJfOGf/z8CQ5PlwaOb2W+2fmWDO/8xErI5wQUuA/KcSWN6y9ns+Z26Z5QjlZyRl/vCHO0T0lRSYzCnQgh8C23qeH02rMQhKN5rwzbpRexyF97d/GG7s/rTep8I+Tg
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1163.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(39860400002)(396003)(346002)(376002)(66556008)(52116002)(66946007)(66476007)(7696005)(5660300002)(8936002)(4326008)(6666004)(1076003)(26005)(6486002)(16526019)(186003)(44832011)(316002)(2616005)(36756003)(956004)(478600001)(83380400001)(8676002)(2906002)(86362001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: RHWntWo2Xk/z+pQoGINHda5Gs4AcgQZXG2ArNXgVGT1iqK0mzI1Woq8CyMC2+hGK6aE78fILND68IOtXed+NciAQ/m7KZBNWfIsDKhHVd7bhtaMC2MPkKx4W9F5MFYkW7DiqLs43klXQ7FQGaP5pVSlpB26Vgjsfk1JZA5xj7RPc5JP6GWrHtm2GVv3LObLiByDg0uTNbJmZDMgNCRZAkGXAiKq95OfAFm9mnY0xEPy2kp70X/TLuuZzqKjTRmLPGdTK5XKOQWfglHFbd7A/hEiMh07QumX+zsMOpnjV4k3kYdtGXZ5QeqvGNZVJjqwGcw0U3JSvPulj8dQkSvwqA5Iqo5u9UbRRQKtQYiLOTjCG9SZQTGgoqs+iTqLQb+rb1OXVcktaVfJg5HoTwQcbz2PR2U3pG6p1Cibvy6rfi02DwCju8oHs4uaBBGLXn2yv9yj7Tf09Y1IZJekgGEDVm+OPUK7pFob5nLbk/8dQHMuOBa4XtskP2i//tNZ1/y5Ip848QpmYOI07RRlAksN/dYlVZPxtGp7NNmrRyo0VxrGAI4Be45mFv5uee8R7sn5O8O2swRri/g0tUSGha82Mp92eZTzg88btvb7kMZyztqmFixPhYYTr8EtKfWefj0Vv4Km3Znn8+Oemc1lLjn+swQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da9a234c-f28d-4869-04e3-08d866ce2b7e
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1163.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2020 12:24:55.8437 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IKexBIzAIGxmMAVsj/D0mtk6ev9hq3hqZR10l0o2DZLlhS9WDDudTa6rSovMuSBch9RnW2Nou7ngDTCWWYgiUw==
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
index 8dff7d85be79..2059e64fdc53 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -101,6 +101,8 @@ static inline
 void amd_iommu_domain_set_pt_root(struct protection_domain *domain, u64 root)
 {
 	atomic64_set(&domain->iop.pt_root, root);
+	domain->iop.root = (u64 *)(root & PAGE_MASK);
+	domain->iop.mode = root & 7; /* lowest 3 bits encode pgtable mode */
 }
 
 static inline
@@ -135,8 +137,6 @@ extern unsigned long iommu_unmap_page(struct protection_domain *dom,
 extern u64 *fetch_pte(struct protection_domain *domain,
 		      unsigned long address,
 		      unsigned long *page_size);
-extern void amd_iommu_domain_get_pgtable(struct protection_domain *domain,
-					 struct domain_pgtable *pgtable);
 extern void amd_iommu_domain_set_pgtable(struct protection_domain *domain,
 					 u64 *root, int mode);
 extern void amd_iommu_free_pgtable(struct amd_io_pgtable *pgtable);
diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 5d53b7bec256..a07af389eae1 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -511,12 +511,6 @@ struct protection_domain {
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
index 0c886419166b..a2acd7e85ec3 100644
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
index cbbea7b952fb..3f6ede1e572c 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -140,15 +140,6 @@ static struct protection_domain *to_pdomain(struct iommu_domain *dom)
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
@@ -1464,7 +1455,6 @@ static void clear_dte_entry(u16 devid)
 static void do_attach(struct iommu_dev_data *dev_data,
 		      struct protection_domain *domain)
 {
-	struct domain_pgtable pgtable;
 	struct amd_iommu *iommu;
 	bool ats;
 
@@ -1480,7 +1470,6 @@ static void do_attach(struct iommu_dev_data *dev_data,
 	domain->dev_cnt                 += 1;
 
 	/* Update device table */
-	amd_iommu_domain_get_pgtable(domain, &pgtable);
 	set_dte_entry(dev_data->devid, domain,
 		      ats, dev_data->iommu_v2);
 	clone_aliases(dev_data->pdev);
@@ -1806,10 +1795,7 @@ void amd_iommu_update_and_flush_device_table(struct protection_domain *domain)
 
 void amd_iommu_domain_update(struct protection_domain *domain)
 {
-	struct domain_pgtable pgtable;
-
 	/* Update device table */
-	amd_iommu_domain_get_pgtable(domain, &pgtable);
 	amd_iommu_update_and_flush_device_table(domain);
 
 	/* Flush domain TLB(s) and wait for completion */
@@ -2058,12 +2044,10 @@ static int amd_iommu_map(struct iommu_domain *dom, unsigned long iova,
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
@@ -2083,10 +2067,8 @@ static size_t amd_iommu_unmap(struct iommu_domain *dom, unsigned long iova,
 			      struct iommu_iotlb_gather *gather)
 {
 	struct protection_domain *domain = to_pdomain(dom);
-	struct domain_pgtable pgtable;
 
-	amd_iommu_domain_get_pgtable(domain, &pgtable);
-	if (pgtable.mode == PAGE_MODE_NONE)
+	if (domain->iop.mode == PAGE_MODE_NONE)
 		return 0;
 
 	return iommu_unmap_page(domain, iova, page_size);
@@ -2097,11 +2079,9 @@ static phys_addr_t amd_iommu_iova_to_phys(struct iommu_domain *dom,
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
@@ -2470,11 +2450,9 @@ static u64 *__get_gcr3_pte(u64 *root, int level, int pasid, bool alloc)
 static int __set_gcr3(struct protection_domain *domain, int pasid,
 		      unsigned long cr3)
 {
-	struct domain_pgtable pgtable;
 	u64 *pte;
 
-	amd_iommu_domain_get_pgtable(domain, &pgtable);
-	if (pgtable.mode != PAGE_MODE_NONE)
+	if (domain->iop.mode != PAGE_MODE_NONE)
 		return -EINVAL;
 
 	pte = __get_gcr3_pte(domain->gcr3_tbl, domain->glx, pasid, true);
@@ -2488,11 +2466,9 @@ static int __set_gcr3(struct protection_domain *domain, int pasid,
 
 static int __clear_gcr3(struct protection_domain *domain, int pasid)
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
