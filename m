Return-Path: <SRS0=qGVY=DL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F00FC47423
	for <iommu@archiver.kernel.org>; Sun,  4 Oct 2020 01:42:08 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8D8020691
	for <iommu@archiver.kernel.org>; Sun,  4 Oct 2020 01:42:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="eCdalJYn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8D8020691
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id A600685516;
	Sun,  4 Oct 2020 01:42:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lkTcGqaAoavF; Sun,  4 Oct 2020 01:42:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 25AD6854C2;
	Sun,  4 Oct 2020 01:42:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1C590C0889;
	Sun,  4 Oct 2020 01:42:06 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 058D3C0051
 for <iommu@lists.linux-foundation.org>; Sun,  4 Oct 2020 01:42:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id F302A863D0
 for <iommu@lists.linux-foundation.org>; Sun,  4 Oct 2020 01:42:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UwcyL0zwJvhh for <iommu@lists.linux-foundation.org>;
 Sun,  4 Oct 2020 01:42:03 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2088.outbound.protection.outlook.com [40.107.93.88])
 by whitealder.osuosl.org (Postfix) with ESMTPS id E134686230
 for <iommu@lists.linux-foundation.org>; Sun,  4 Oct 2020 01:42:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KkvzGWPAzG1+0PLe7aNZl/ybHAInLjAWkpNxj7Bdv2akJ2u+CPpaDgFQAZ1i6vssTmeDA2e1AMFevhr+4RJv0U2R6+2ILG5viXE8giUpKPwjeVneoFZ6XovtKFNVrPTfCFdM9AFGadbKP6l5nPa+A5Cgc9wivdUVgM6bcKl8PPP9+8R5BwdSsjZaugMNjfmqcVH900uY/JG180l+oaN68SaPWaCKaCi+TLl/UYh1kJdZFwPIcApMaLpavetopGevEfeBoENaxAa0OleF+OfydS/MgwJgvaG2E3CRkPCTHBrsx4U6s/ltr2qJqY9SWDjSHYTE0wKUOoU08VjbUpB1yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CRLcur5LAEIrdvdY33GnUVP2YesbGVUAiCxxHaMnsR4=;
 b=bXSD/y8QI8/DEq1pGiizoEFJ34Q03047259oLerLPjsDMK9+X6Iu9ecem5AuxHyWno48ke1VJeoRNaHEsbASHcw5l9Yf2A2H72fo7V7HqOjsnq0oEoAR9RlpszG5SIyY1Feu4w671ozKwZhHUEZfK7/4bj/w9jvHaioeMgkzfSDY09CbJL3rchzCrryYJ3jWWsuEaZhafIxGzdJlzr55McObFipy60QiEPlU5Ll8t1oy1l4e8x2uYTmHBxijJofcfFLXOMYFFddutjXoYSZIKjYcuZWP26rpBZVgXJqL4P6n5BWslmxlg2JS+vrQp69MnhfiIbVlBmk756hPb6D/Ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CRLcur5LAEIrdvdY33GnUVP2YesbGVUAiCxxHaMnsR4=;
 b=eCdalJYncbK8/Ac42dmxupHqSzKCxpjVW+Ia5BvxCKT9K78Rhj+GPcTchr/6VjsDuzCbqZHw4qkpzzZxCgtJI3HYdfdPbSoF+xSpUqZ5E5zcqdJoLLUboO0t03Wt/E5kbTagIAmgG9npPYuuELVXKkEiKMonHTFgcD4hQRE9aLA=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1163.namprd12.prod.outlook.com (2603:10b6:3:7a::18) by
 DM5PR12MB1451.namprd12.prod.outlook.com (2603:10b6:4:d::12) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3433.39; Sun, 4 Oct 2020 01:42:00 +0000
Received: from DM5PR12MB1163.namprd12.prod.outlook.com
 ([fe80::48cf:d69:d457:1b1e]) by DM5PR12MB1163.namprd12.prod.outlook.com
 ([fe80::48cf:d69:d457:1b1e%5]) with mapi id 15.20.3433.042; Sun, 4 Oct 2020
 01:42:00 +0000
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: linux-kernel@vger.kernel.org,
	iommu@lists.linux-foundation.org
Subject: [PATCH v3 07/14] iommu/amd: Restructure code for freeing page table
Date: Sun,  4 Oct 2020 01:45:42 +0000
Message-Id: <20201004014549.16065-8-suravee.suthikulpanit@amd.com>
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
 Transport; Sun, 4 Oct 2020 01:41:59 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 558806f1-7f5e-46ab-f018-08d86806af5f
X-MS-TrafficTypeDiagnostic: DM5PR12MB1451:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1451F58D95521E93D273594FF30F0@DM5PR12MB1451.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1zQlQ/UjPDCcme80udjm9rLIlcahwy1S3YbHbOrLgj5KH4qs1CUFEUkfkX6+tnj+riZ3pJ8RdFBV6t+BV+jGuWiQACeqzlZ835x7dDtGR6/7oopYO75rLR/YYUFxBft3OXYVqqXoyVor//1vYgnt1KRSe+upwLILSX2HSPrI1qv9m6q5h9bhWBwfAafCyIoZJ6lD04ITQLJQnYkHYwQn8Ubt9Av4kdS+MrL9t/pq2RcoSZ8nLMRvly6DK/fyVmUbefH5nFoJvhbZfHTJMKphW3EE4aoVBJLMi6ZeSaH7/kMl1hnSKlqQ+46B/2JkY9Xf087X6tyl/YCxKEigVYYCvg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1163.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(346002)(376002)(136003)(366004)(39850400004)(2616005)(956004)(6486002)(316002)(66946007)(66476007)(66556008)(6666004)(478600001)(44832011)(1076003)(5660300002)(86362001)(8936002)(7696005)(52116002)(2906002)(36756003)(16526019)(26005)(186003)(4326008)(83380400001)(8676002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: syPmI27RUBdZSrQzsl92q+5o/MpDyKJnHDcsJPBTnFyQ3Ghl74pFX0jqctcRD2z5Ylg0r+M93xOIxYV/MuR0Sts44k5BfPicQjXJVxR0uqbe841+0uH6Q2+exqTSxOFTBgu+2P038xXksVWidzIKnY0bLi23rwO3MKPuI3GK3ZM3hhpG9Y2NSExIa1IG8p+Q68cXJ/9yDushjAcCdWqmPeyalD44Qg12m6w52HHxf1UxA9/xnT2CKgFGd3RlU9QdBZIaUYb3kfLsuQOdLiUvnWHvF4BvoweMInUqLAY31tbyywm9/0iVqI8uW3//wyUFPXvmq9FuBL8QP9mIcOs8VtVkrby5sWI+JY0iioFpqnWg3evceTDIVv0We/jx0TwbGNOIh1IgEe1j4OpRWVZehT7YDuIKDRFUnwmaA4HqxMzQabtejV1Z10cF2nslLOK+CrYOXuG5cdvONUnABIyRCrmpWXH0wXszr1y8/AEOPC+CG9JxgaW29e2ubr/rqJL4xzMhiu8DtCuGRx2Ei3t4zLHrmXDigi6etZIx6P+iWgsWe3HTvjT16oUSOKBukoXcKlHEmw4KxKlIG0Qty2dtXzzftwJv0pJQiqNHpbS70KvPjGw6JSoOgm6SyPIfra7L+uwAp9D08cJdyYeSs8hxGQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 558806f1-7f5e-46ab-f018-08d86806af5f
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1163.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2020 01:41:59.8416 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0lfuzngJ+dG5AQIrjDffxylp8Hy8h8z90Wux0KhuaLMCaUgW1AGJgrBRg1efy98xPs+RUPAkatj5lQyWYQwJ1w==
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

Introduce amd_iommu_free_pgtable helper function, which consolidates
logic for freeing page table.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/amd_iommu.h  |  2 +-
 drivers/iommu/amd/io_pgtable.c | 12 +++++++++++-
 drivers/iommu/amd/iommu.c      | 19 ++-----------------
 3 files changed, 14 insertions(+), 19 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index ee7ff4d827e1..8dff7d85be79 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -123,7 +123,6 @@ static inline void amd_iommu_apply_ivrs_quirks(void) { }
 #endif
 
 /* TODO: These are temporary and will be removed once fully transition */
-extern void free_pagetable(struct domain_pgtable *pgtable);
 extern int iommu_map_page(struct protection_domain *dom,
 			  unsigned long bus_addr,
 			  unsigned long phys_addr,
@@ -140,4 +139,5 @@ extern void amd_iommu_domain_get_pgtable(struct protection_domain *domain,
 					 struct domain_pgtable *pgtable);
 extern void amd_iommu_domain_set_pgtable(struct protection_domain *domain,
 					 u64 *root, int mode);
+extern void amd_iommu_free_pgtable(struct amd_io_pgtable *pgtable);
 #endif
diff --git a/drivers/iommu/amd/io_pgtable.c b/drivers/iommu/amd/io_pgtable.c
index c11355afe624..23e82da2dea8 100644
--- a/drivers/iommu/amd/io_pgtable.c
+++ b/drivers/iommu/amd/io_pgtable.c
@@ -136,14 +136,24 @@ static struct page *free_sub_pt(unsigned long root, int mode,
 	return freelist;
 }
 
-void free_pagetable(struct domain_pgtable *pgtable)
+void amd_iommu_free_pgtable(struct amd_io_pgtable *pgtable)
 {
+	struct protection_domain *dom;
 	struct page *freelist = NULL;
 	unsigned long root;
 
 	if (pgtable->mode == PAGE_MODE_NONE)
 		return;
 
+	dom = container_of(pgtable, struct protection_domain, iop);
+
+	/* Update data structure */
+	amd_iommu_domain_clr_pt_root(dom);
+
+	/* Make changes visible to IOMMUs */
+	amd_iommu_domain_update(dom);
+
+	/* Page-table is not visible to IOMMU anymore, so free it */
 	BUG_ON(pgtable->mode < PAGE_MODE_NONE ||
 	       pgtable->mode > PAGE_MODE_6_LEVEL);
 
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 4d65f64236b6..cbbea7b952fb 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -1882,17 +1882,13 @@ static void cleanup_domain(struct protection_domain *domain)
 
 static void protection_domain_free(struct protection_domain *domain)
 {
-	struct domain_pgtable pgtable;
-
 	if (!domain)
 		return;
 
 	if (domain->id)
 		domain_id_free(domain->id);
 
-	amd_iommu_domain_get_pgtable(domain, &pgtable);
-	amd_iommu_domain_clr_pt_root(domain);
-	free_pagetable(&pgtable);
+	amd_iommu_free_pgtable(&domain->iop);
 
 	kfree(domain);
 }
@@ -2281,22 +2277,11 @@ EXPORT_SYMBOL(amd_iommu_unregister_ppr_notifier);
 void amd_iommu_domain_direct_map(struct iommu_domain *dom)
 {
 	struct protection_domain *domain = to_pdomain(dom);
-	struct domain_pgtable pgtable;
 	unsigned long flags;
 
 	spin_lock_irqsave(&domain->lock, flags);
 
-	/* First save pgtable configuration*/
-	amd_iommu_domain_get_pgtable(domain, &pgtable);
-
-	/* Remove page-table from domain */
-	amd_iommu_domain_clr_pt_root(domain);
-
-	/* Make changes visible to IOMMUs */
-	amd_iommu_domain_update(domain);
-
-	/* Page-table is not visible to IOMMU anymore, so free it */
-	free_pagetable(&pgtable);
+	amd_iommu_free_pgtable(&domain->iop);
 
 	spin_unlock_irqrestore(&domain->lock, flags);
 }
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
