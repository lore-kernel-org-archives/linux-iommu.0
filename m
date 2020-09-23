Return-Path: <SRS0=5N08=DA=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C443CC2D0A8
	for <iommu@archiver.kernel.org>; Wed, 23 Sep 2020 10:12:03 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6465021D7D
	for <iommu@archiver.kernel.org>; Wed, 23 Sep 2020 10:12:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="vUVRqVOa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6465021D7D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 301BC86135;
	Wed, 23 Sep 2020 10:12:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id StAiFDUh3z9J; Wed, 23 Sep 2020 10:12:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id E734D86148;
	Wed, 23 Sep 2020 10:11:59 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D0FD7C0893;
	Wed, 23 Sep 2020 10:11:59 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 41C38C0051
 for <iommu@lists.linux-foundation.org>; Wed, 23 Sep 2020 10:11:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 31100867CE
 for <iommu@lists.linux-foundation.org>; Wed, 23 Sep 2020 10:11:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KRQDjqBvRUYJ for <iommu@lists.linux-foundation.org>;
 Wed, 23 Sep 2020 10:11:56 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2064.outbound.protection.outlook.com [40.107.237.64])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 7CC86867E2
 for <iommu@lists.linux-foundation.org>; Wed, 23 Sep 2020 10:11:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=faDofOLRfIaUIY+qtEpCkR5E2nJrgm3W1Nz5uO5NhMl2Rjv5ltISDKsET6pfz5f0Q//WQdl8Hjh3Tw2D+tFITTcjMe13dSs5nJ4XPSlKawPabNvaGYycwRoGQIe4jSGki11hM24x/x13kzBvCPtPNVvx7sYIk5CERIYodz7hFAgs9LiSYMcy8wpjXXupB8X4Lyx2VOnYMeeAlBcHtLWwwbdPySOQinA6Th0pK7GOc8omTHPtjlWQVI0hz2gtujjrHiCd+oDWB1lszgWq9l2DY5qbu5qtHmqFuGqbsdv4hP1rTJnZSRIOY0StH0Aw8uCNk+64txo6Q+V+UfMw/5hqew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0XNoRUgCleyuBDohIivahfwA1LvVtNfxQrFsT2R4bCc=;
 b=DoalUhwAwp3wmKh7kxgY42M8ES2SuzB/ageGZgRywiR/GvKACFzbKuphMFodzkMZgjTRinqSEPlgQm6OXL0F3W1L2BxzNJtXcNnQSYDicBHQG5zResIDphjC7QaEY4fRTMTJLtlylrwKSNgt7FY4hIQCiIzYJmvGW/h59viYhx771ULbtPaieXKHAMRy5tPlGmWH+qhW8oMMWGDIUo9Gy7UlikKqKsbnHnmd/0+bImBhZz/ayuaVcly+txCwbflXPx2juKWVrYQ+ra0kmIUc3LyX+dHtNR98qviRnKXpSL0cO8bKFZ2O43AF7QwxOkGx6NpR46HRTQxrH/Ar4DZh3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0XNoRUgCleyuBDohIivahfwA1LvVtNfxQrFsT2R4bCc=;
 b=vUVRqVOaAWvmr0u3G5iVr1cNCakwar+rUg2Egzmxevm9TG8rwL5SyfcrbjWpQvqkc8GR2AyR+Mt7E7aj7n7k1nyvv2nhKzCE0mCgVgE1kPTIW29AYEfryyaCDUCjLB59FWr0mfMEvRodqv2k5hJuUVrN36m9JUTL29EMsFo8jXE=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1163.namprd12.prod.outlook.com (2603:10b6:3:7a::18) by
 DM6PR12MB4217.namprd12.prod.outlook.com (2603:10b6:5:219::24) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3391.11; Wed, 23 Sep 2020 10:11:52 +0000
Received: from DM5PR12MB1163.namprd12.prod.outlook.com
 ([fe80::48cf:d69:d457:1b1e]) by DM5PR12MB1163.namprd12.prod.outlook.com
 ([fe80::48cf:d69:d457:1b1e%5]) with mapi id 15.20.3412.022; Wed, 23 Sep 2020
 10:11:52 +0000
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: linux-kernel@vger.kernel.org,
	iommu@lists.linux-foundation.org
Subject: [PATCH 12/13] iommu: amd: Introduce iommu_v1_map_page and
 iommu_v1_unmap_page
Date: Wed, 23 Sep 2020 10:14:41 +0000
Message-Id: <20200923101442.73157-13-suravee.suthikulpanit@amd.com>
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
 Transport; Wed, 23 Sep 2020 10:11:52 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c64ca583-3c47-4784-3238-08d85fa917a1
X-MS-TrafficTypeDiagnostic: DM6PR12MB4217:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4217EBD94D07882AD78481C5F3380@DM6PR12MB4217.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ANClqXyQ+a+9wFUYgvgmdZ6Cjd4EkOqoGB55SQEJaPyOXVo6g+0dsKC9JOIN5C+nv0PZiMxd7NNKMubjYQKGJS/rbHriYCdnmG8LfgCUXKKBVyBWOEsx8TwbyQtfFCpoqucf5u7bcP6Dfhq9R8D4yPzrpsJw6RI0OolaLiGwoRYLQ4Np8E+WRu7sylToPc00oWrKXauNW/b7Rc6RHn8H/x8Gc4n3HFSjKpJzPiK3/vUUL4/MhnPmvzmw6upKPMsTuXzqM4AG9vbBaMhvOHssA4aC40T4+D/JkoNgkd8sBFnsgAOZOIGpTj3jXjgwZV+qqV/wE3tBs27XrAWQYcwocoTiladPK6Lm0zSdPEfBRo1MOYR5VGGA4B0W58hyq6y5
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1163.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(376002)(396003)(346002)(136003)(366004)(8936002)(4326008)(16526019)(1076003)(186003)(36756003)(52116002)(8676002)(7696005)(5660300002)(66946007)(26005)(86362001)(44832011)(316002)(83380400001)(2906002)(2616005)(6666004)(66556008)(6486002)(956004)(478600001)(66476007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: P7h5KTTiAnrrDmijpGveFfY3BnIsTGvJzzS+jYcBtGo893558xzm09/Be6k6vq1DMgSCStoMFC8IQEvVSPTlpVU9hHEg34OswMGqXQAj5Cw7Qek/E3/+BRjIvDy4OqP6tCZ+2XGkKtIP7KqHfA0wFHSbiVmH9B2kCops4MQ4kQoZoDnZxL4ob30Nm4jQHx4IKJhvkFPG418+QsE/OAfi/evGhVfLLB7nPntPA3V1RrVsPTVx+BhxuASQT9kc1WNLARWJrWIwxbNqFg667HAnUR7NfqWBYohWKaaty2+11apdWMMb92fPJ2nDOHQpdEThrQ9s1OYr++OfO4Zi0sJ/REriM5SX8SXCdxAgPW3hrXCIi1wr62BMO1CIa3N/aZCMj2BxBPHbO/dxuffLdDPIYYCVBwCDlwnc2Ju9E1VIIfg5X88cFMnpnjDRcRhTmOAbuceUSUxwJpJYOG+WXLpR9hDWQl4S67IsDviTcUCpXS5CMN05zmwaZ1CmQOk8v2zRgejHOxkFOw8dfm2sLnon0cuxN+/MQoOWLrolCNvnPksDltlDU4iD4ARQ2Lt3hcV2dipdGjZdryzpUUFBSahbW9LJxUdOP+fb2jOdVq3+jlm3vOWU+mgvpj/1GAcMEiSRoQ3C3jZM6ZrDSb8qG2qXrQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c64ca583-3c47-4784-3238-08d85fa917a1
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1163.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2020 10:11:52.7515 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r5QlCVt9/Cnn2zLQ7K6wNyZaijZWM88WjPsBpaBbd9n4w2lsTb+kjoCo1zEQTyEgF9+/PuRNpjmPqlDRaOaTVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4217
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
index 2f36bab23516..7f7be302c538 100644
--- a/drivers/iommu/amd/io_pgtable.c
+++ b/drivers/iommu/amd/io_pgtable.c
@@ -348,9 +348,9 @@ static u64 *alloc_pte(struct protection_domain *domain,
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
@@ -423,13 +423,10 @@ static struct page *free_clear_pte(u64 *pte, u64 pteval, struct page *freelist)
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
@@ -492,11 +489,11 @@ int iommu_map_page(struct protection_domain *dom,
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
@@ -571,6 +568,8 @@ static struct io_pgtable *v1_alloc_pgtable(struct io_pgtable_cfg *cfg, void *coo
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
