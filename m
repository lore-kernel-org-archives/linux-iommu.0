Return-Path: <SRS0=qGVY=DL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CF31C4727F
	for <iommu@archiver.kernel.org>; Sun,  4 Oct 2020 01:42:11 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5606D2067D
	for <iommu@archiver.kernel.org>; Sun,  4 Oct 2020 01:42:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="IEhYPTNK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5606D2067D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 3D92E85566;
	Sun,  4 Oct 2020 01:42:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SBZF7vphW9Sl; Sun,  4 Oct 2020 01:42:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 49B3385570;
	Sun,  4 Oct 2020 01:42:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 31273C0895;
	Sun,  4 Oct 2020 01:42:10 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3F411C0051
 for <iommu@lists.linux-foundation.org>; Sun,  4 Oct 2020 01:42:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 2361B85540
 for <iommu@lists.linux-foundation.org>; Sun,  4 Oct 2020 01:42:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id c8_BGET0NzBh for <iommu@lists.linux-foundation.org>;
 Sun,  4 Oct 2020 01:42:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2041.outbound.protection.outlook.com [40.107.93.41])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id E6FD885570
 for <iommu@lists.linux-foundation.org>; Sun,  4 Oct 2020 01:42:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W/0CbynM8V7P2O6v+swWXSYdZXpZ5I15aaONCZzUj6MWv+LX9M2sBpx5cKJBnl3RxT3UoGdHs5sDaVyLMpGgpGyKfK5y9PU2iGMgsL6itE1bthEEkoWfc5GOpjB/uRVQI73D/HPI+rp+6bb9aRF+86E7OpZS74E/5rpigcAE5FODN5FK1t2S9tmsrKs6zs94ATkeZGLLyXErLtnmncH22Ai0HjDuK0SG9Lsx/DLixg8UngphoMPfrIV94AYIO6YI43LIMXWdIp491rCnE1Gsbn31h7uz4Y1Q2SAFxrllthb1DO1NzGmboahnMlJyHGALQMP7/WP4tz+dFlrc/xx5aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v5JbFcQn57DuIMWydwfAr6Qg9PG5sCOIwoZH5I20CcI=;
 b=Jwyfow9BI5IApqL4Gb4/D8zXTcL7WvmlEmzEiT399bXx+iv+oaVAHi9Z9FXrLTs0MZQFkMMec/NMiaDwIr3Bhr+DtRroh3YsDcXB82onEfHQKYfNtpVWsdyCIsFZzOKiy5jwmE07hxRMn3/UZZx29/fMDeMhK1Xg5PXPtE/8K7Cu1EXskDjzDJP+kl5kwtNd4lAC9Ic24/Ik37DJ5klEm2v9Y9RCvp+mzBVs2TMC8pdrDpvt0zoiW3R0XtH+JMmhMF4g44dQ1FMz7UXrjLonhH9EFhGcOmPJdO+CXkRp+SlEnA503k9dYbWBw0K0slaHhrvGLkvL2l/6ULqqK32hWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v5JbFcQn57DuIMWydwfAr6Qg9PG5sCOIwoZH5I20CcI=;
 b=IEhYPTNKYfLt0ySkPJPAwap+k/gqPqEcebnRfOMT8IgWrlpQ/+rKahDZMpcWRhK2b2MyLNS4Wx0Jhntsao4vjvceCYdtcvd3zePNpUdwdKaPijayjAUePIfftR/imo9eHK2BaeDWmLtmAXBcIsOrSxZwKXLYaA/JLs5uoPGv/XY=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1163.namprd12.prod.outlook.com (2603:10b6:3:7a::18) by
 DM5PR12MB1451.namprd12.prod.outlook.com (2603:10b6:4:d::12) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3433.39; Sun, 4 Oct 2020 01:42:05 +0000
Received: from DM5PR12MB1163.namprd12.prod.outlook.com
 ([fe80::48cf:d69:d457:1b1e]) by DM5PR12MB1163.namprd12.prod.outlook.com
 ([fe80::48cf:d69:d457:1b1e%5]) with mapi id 15.20.3433.042; Sun, 4 Oct 2020
 01:42:05 +0000
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: linux-kernel@vger.kernel.org,
	iommu@lists.linux-foundation.org
Subject: [PATCH v3 12/14] iommu/amd: Introduce iommu_v1_map_page and
 iommu_v1_unmap_page
Date: Sun,  4 Oct 2020 01:45:47 +0000
Message-Id: <20201004014549.16065-13-suravee.suthikulpanit@amd.com>
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
 Transport; Sun, 4 Oct 2020 01:42:04 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 862c440f-04c7-4554-5b71-08d86806b2c8
X-MS-TrafficTypeDiagnostic: DM5PR12MB1451:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB14510A12E505561A6D83AAB4F30F0@DM5PR12MB1451.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uh7abBTS2FC7BGppO2dPjpgGKkFEiS/3PwnH202bDlLkn40jA61GNM97ETlUkQhzk7RlGaCUqo/2g5qHa2Rgqa+oIBTDJP60mwrPRxZEwguJ/Z10vKiv0mbxgm1ZpsbKmVnpYKGUPaHzOFm31FTfeUj79t/q1LupJkMAIVUlepxVebfEQZbPX007XqOYt3VqTHg4VMb/E7HZfGkSO3U/oJXuUUO+3dijxw2lDojIfDZcpmm0gz8iUiaY68v61qSouijM4+auxS0NjTnzRSR/c+bF5WzCur5uOxEluF8TxrXfv1Ei52VLuz2l6pkHXZeOd7KExXVje6fnhzYiSmYPcw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1163.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(346002)(376002)(136003)(366004)(39850400004)(2616005)(956004)(6486002)(316002)(66946007)(66476007)(66556008)(6666004)(478600001)(44832011)(1076003)(5660300002)(86362001)(8936002)(7696005)(52116002)(2906002)(36756003)(16526019)(26005)(186003)(4326008)(83380400001)(8676002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: C2ZwR87g/H8JEu/DTHZnYbgkj/cW7tI6Lc/o6LspdFsj164+lGc1tlhaiZmMqyHWcT8ljt47IYn/INK9oY1d6TfvrApS5lg/4fLRQuN2QRrEYrJ4p7M0N9nULZEpfUUFBZraaF0X8eMYPABsl5KdiIcTbkAbADafjWi9GEu1OvW7AmOQN8GHQOZaTE3WfnuyyWU/dmxmLvlpPaRP1QxyFxZxhp9w9hgUrIC6cFCpSGRSgRblYmiU//Ia6ri2O0bWbBexRM3/X/gD516iEhdrrv3yyXVEKsLguXxs4d2XnHZYeoNGdPLs0hrfm9E3ooQ48qqr8dWGozXXazuD1awmbtt0N/eHt+TAzxWwuR6gb5a3djhCtbsbNO6kafFGm9KeqjlJHfS73EdmttAG5m4fVs+UNGJhuD4qMPq18vekdokBjc8sGDCP30CbHqrK2MkkUq+wdcfnvSWbnXWgQyVRHoRu7kRW8RMx59oOq3vTn4HlDxyIqxmWYa7X9X04K1HCdqJzIZsLViys1kBWjqwPPPdr7kskVs4KV+i68lJBaradUF5xDrg5G7hvAerXGPRoLca8OPKijnmmIFWuMblTLYgFDDZ9NT643DydgcXfEmV1blhr0S69v0iPzRpeAOMbSW5hssut/EI3vUk4RM7E0g==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 862c440f-04c7-4554-5b71-08d86806b2c8
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1163.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2020 01:42:05.3201 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8C8oxewRshoqKSGg26jtO2ftwxvQKW0kRdA8YGUZU/UFEkLtYdtlYgdSpJnJDXLcX9bP6W0HU/uYfljjPt3PzA==
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
index 7841e5e1e563..d8b329aa0bb2 100644
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
 	struct amd_io_pgtable *pgtable = io_pgtable_cfg_to_data(cfg);
 
+	pgtable->iop.ops.map          = iommu_v1_map_page;
+	pgtable->iop.ops.unmap        = iommu_v1_unmap_page;
 	pgtable->iop.ops.iova_to_phys = iommu_v1_iova_to_phys;
 
 	return &pgtable->iop;
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
