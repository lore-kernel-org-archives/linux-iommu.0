Return-Path: <SRS0=Fz8+=DJ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97A6AC47423
	for <iommu@archiver.kernel.org>; Fri,  2 Oct 2020 12:25:09 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 496232074B
	for <iommu@archiver.kernel.org>; Fri,  2 Oct 2020 12:25:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="lrdbHrSK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 496232074B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 37FA6865AB;
	Fri,  2 Oct 2020 12:25:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XNnSd9XC0xJR; Fri,  2 Oct 2020 12:25:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 323A886672;
	Fri,  2 Oct 2020 12:25:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1EB91C0895;
	Fri,  2 Oct 2020 12:25:08 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 71602C0051
 for <iommu@lists.linux-foundation.org>; Fri,  2 Oct 2020 12:25:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 5F54E86B83
 for <iommu@lists.linux-foundation.org>; Fri,  2 Oct 2020 12:25:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NUBH43WE8G4W for <iommu@lists.linux-foundation.org>;
 Fri,  2 Oct 2020 12:25:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2074.outbound.protection.outlook.com [40.107.237.74])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 3894C86B1C
 for <iommu@lists.linux-foundation.org>; Fri,  2 Oct 2020 12:25:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=io3PstFboAeZoA03NE9sI79tBdHcld0fMu23B1f2+Ww0hGyqlTqG7bw43uEbzSXH830Qm6fmZa07RERMEgrDDsY60lLIcKef+vGwfKvUOkPADthJEWgWOt2ZeRGSPh4KC2kvnjcb6Hhg3gBCKZWOKc5lJuz0kROYh2yMNvoiQqZzuoH8O9w/yoDTxNhXeGX9fuhkVlocZflpcbtTodG2QADQppLpCkTgDzTdAxHhjL5En44304/1h2hE+BPn6poTq/oXsn0RWO7VCsNye37IF6zFzjdTdgpVmaSxWGqD+OAqz+ZvTmeD0wCims8O7IGsxlk7ewAZ8JBv7uOf44G5Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cTAbI7jrr95rsYOsRF61W8b18duQvKDXDcH/1IcUsZw=;
 b=oPIgM3jZoPHlNzZOBXJPXktyyQIK/7Liacv6wmGFnFdispg8qu0Kj1nq9xFk+3xAIbhhNHcyllNDx4XnthX4ghdcx+Jm1X3qE+7sjOAZzi4gIfW+7LUULenw+BE5VJPu4jesur6J0liSdKhER0xp3q9J8rwxtUfQi2BO1tIHPyYqUTU1HXE3fATShhH6dDqAVKNj/n51Bmc9WBGEfrUH0Ms8zUswXutO6BFLRFodWEIgNDFR9zJs3Phw8sC5UEGsR1OvcHCmjXoi1BwU7jpucUywAebI2O3Shichg2bUmUm6gUSH7FU6UiMmXtCDHgmFEVotYCcznmcUUJkTzuNKVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cTAbI7jrr95rsYOsRF61W8b18duQvKDXDcH/1IcUsZw=;
 b=lrdbHrSK/MUSJCoNYSomcrbYqeoTz8UtXMgQTE7cLMUw5ReFnAVfhC8yEqK547su6f6tFP2G+X/grYEQz9ghZfETkBMHv13yeHX6MRQzBF0C0zdH4b9a47l+QKbfoQBZ5PuW63baGNbT4TWN4reT7QusketADndcINSCEmkhC4Q=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1163.namprd12.prod.outlook.com (2603:10b6:3:7a::18) by
 DM5PR12MB1163.namprd12.prod.outlook.com (2603:10b6:3:7a::18) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3433.32; Fri, 2 Oct 2020 12:25:00 +0000
Received: from DM5PR12MB1163.namprd12.prod.outlook.com
 ([fe80::48cf:d69:d457:1b1e]) by DM5PR12MB1163.namprd12.prod.outlook.com
 ([fe80::48cf:d69:d457:1b1e%5]) with mapi id 15.20.3433.039; Fri, 2 Oct 2020
 12:25:00 +0000
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: linux-kernel@vger.kernel.org,
	iommu@lists.linux-foundation.org
Subject: [PATCH v2 12/13] iommu/amd: Introduce iommu_v1_map_page and
 iommu_v1_unmap_page
Date: Fri,  2 Oct 2020 12:28:29 +0000
Message-Id: <20201002122830.4051-13-suravee.suthikulpanit@amd.com>
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
 15.20.3455.13 via Frontend Transport; Fri, 2 Oct 2020 12:24:59 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 387989a4-793c-4dae-2320-08d866ce2e34
X-MS-TrafficTypeDiagnostic: DM5PR12MB1163:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB116358FFDBE5E403193C3CF7F3310@DM5PR12MB1163.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: v5qE5T/dCmH8cuPRD41ARPL5Ik7UsQLR5Rv1/OrX3FrtMaMwdv5DxHKBt09F0Bk+JFxIj72RgO7T+zEHGsoDI0Px9bivOLugFNB9WH98w1wYfyYZR31xw7Z9Aw51t3B5xgqqxt/BlwWi/Q0yCnHjorTQBTc8Yw2Siuy/4hkTnWSlf+/IrKsKhN82BvzGe5Mkd0rn9NpAsQk6JqeMkcpp4js/T1DMW3TK9lcshQCBaKcwVEadMVDyT5XreY1IAkVBNUA+eJLyWHR/57ckgFZbGzG/o32ILxMSGWuh6023gIj8AFbLTBI99RKbJJKF1xLesaaoJrC2iJbfNaCvV5e8+g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1163.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(39860400002)(396003)(346002)(376002)(66556008)(52116002)(66946007)(66476007)(7696005)(5660300002)(8936002)(4326008)(6666004)(1076003)(26005)(6486002)(16526019)(186003)(44832011)(316002)(2616005)(36756003)(956004)(478600001)(83380400001)(8676002)(2906002)(86362001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: +aaFaC9zHeRoaApfKGuTqKBvF6oB16BS8w5PrSJZwaTQZ7X5XnU3PDFN5RP2ThJpM+SINsWk4FYdXG7VStS213nCWjUFIlZXQBiY0ONadtL46SwxpPByYZw1Ri3m2i85pXKPIvFpqVibv7xGljz+GDytT85555jF6rDdN1dS2QF0XBXSDby2vG9OWRUp4gu0yhGuwMgRE6zg0+hZe2yReOtGCdr9WXK4q7W37sxIn2CR5Agu/UUKmhSfeupZ/ONsXMMJk8r2NcjUnw+6p4rEimuRT6zlsoK4wQptU81QoQKLG+wCqjc/KG8xvhxNijt03g0OMWaPiPKOwYJh5zR3Q5GjyT17vEMbEZg/fcvSsSCHwHSDW5XBRIvfwPnOJNYEiwiUaydJdpoNnhOOioVtxzUlC1hHQVZqFfsG/dHb3KkVE2pqQQEXfW6nULofWMykH2PZ2nSi0IQVqGp+adNQ8WYLJHnEjnw/Q+nuo7KH6tggnAZn+4UX2t9RlcsSxjYruIsQnke4vNYCuW0NIru2b915Xvyeh5mmgjb1d894Ajt5wz8Wf4nlVF38h0giPbgE+xL6Wmv6uHXdX9FxYorCtJoQm3tJAgGHKeeNOx0YnGsFaOAzGq7n8EtnaGMnv5Wugts8RoNnHnLxZkXFC2Lskg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 387989a4-793c-4dae-2320-08d866ce2e34
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1163.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2020 12:25:00.3117 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /wUbZmsjRLyfoiqRXKf9wpljONBTeVTWGNT+yDM658dQRYW95I3OV3JdFHprRFUoRaMRxhVcuGfXVYSFrtbuSg==
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

These implement map and unmap for AMD IOMMU v1 pagetable, which
will be used by the IO pagetable framework.

Also clean up unused extern function declarations.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/amd_iommu.h  | 13 -------------
 drivers/iommu/amd/io_pgtable.c | 25 ++++++++++++-------------
 drivers/iommu/amd/iommu.c      |  7 ++++---
 3 files changed, 16 insertions(+), 29 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index 69996e57fae2..2e8dc2a1ec0f 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -124,19 +124,6 @@ void amd_iommu_apply_ivrs_quirks(void);
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
 extern void amd_iommu_free_pgtable(struct amd_io_pgtable *pgtable);
diff --git a/drivers/iommu/amd/io_pgtable.c b/drivers/iommu/amd/io_pgtable.c
index bbbf18d2514a..a5f8d80a9d35 100644
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
@@ -525,6 +522,8 @@ static struct io_pgtable *v1_alloc_pgtable(struct io_pgtable_cfg *cfg, void *coo
 {
 	struct protection_domain *pdom = (struct protection_domain *)cookie;
 
+	pdom->iop.iop.ops.map          = iommu_v1_map_page;
+	pdom->iop.iop.ops.unmap        = iommu_v1_unmap_page;
 	pdom->iop.iop.ops.iova_to_phys = iommu_v1_iova_to_phys;
 	return &pdom->iop.iop;
 }
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 9a1a16031e00..77f44b927ae7 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2044,6 +2044,7 @@ static int amd_iommu_map(struct iommu_domain *dom, unsigned long iova,
 			 gfp_t gfp)
 {
 	struct protection_domain *domain = to_pdomain(dom);
+	struct io_pgtable_ops *ops = &domain->iop.iop.ops;
 	int prot = 0;
 	int ret;
 
@@ -2055,8 +2056,7 @@ static int amd_iommu_map(struct iommu_domain *dom, unsigned long iova,
 	if (iommu_prot & IOMMU_WRITE)
 		prot |= IOMMU_PROT_IW;
 
-	ret = iommu_map_page(domain, iova, paddr, page_size, prot, gfp);
-
+	ret = ops->map(ops, iova, paddr, page_size, prot, gfp);
 	domain_flush_np_cache(domain, iova, page_size);
 
 	return ret;
@@ -2067,11 +2067,12 @@ static size_t amd_iommu_unmap(struct iommu_domain *dom, unsigned long iova,
 			      struct iommu_iotlb_gather *gather)
 {
 	struct protection_domain *domain = to_pdomain(dom);
+	struct io_pgtable_ops *ops = &domain->iop.iop.ops;
 
 	if (domain->iop.mode == PAGE_MODE_NONE)
 		return 0;
 
-	return iommu_unmap_page(domain, iova, page_size);
+	return ops->unmap(ops, iova, page_size, gather);
 }
 
 static phys_addr_t amd_iommu_iova_to_phys(struct iommu_domain *dom,
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
