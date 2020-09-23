Return-Path: <SRS0=5N08=DA=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 592B1C4727E
	for <iommu@archiver.kernel.org>; Wed, 23 Sep 2020 10:12:06 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0ADCC2076E
	for <iommu@archiver.kernel.org>; Wed, 23 Sep 2020 10:12:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="qPZxAkgP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0ADCC2076E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id EBAFF86F97;
	Wed, 23 Sep 2020 10:12:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id igATFF3BF02b; Wed, 23 Sep 2020 10:12:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 1E76986EB1;
	Wed, 23 Sep 2020 10:12:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 18B89C0859;
	Wed, 23 Sep 2020 10:12:05 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3FCDEC0051
 for <iommu@lists.linux-foundation.org>; Wed, 23 Sep 2020 10:12:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 1D2A220411
 for <iommu@lists.linux-foundation.org>; Wed, 23 Sep 2020 10:12:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id c3J-bM56iPcL for <iommu@lists.linux-foundation.org>;
 Wed, 23 Sep 2020 10:11:53 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2048.outbound.protection.outlook.com [40.107.237.48])
 by silver.osuosl.org (Postfix) with ESMTPS id 15FCB22E96
 for <iommu@lists.linux-foundation.org>; Wed, 23 Sep 2020 10:11:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iLHGqz4Ed6YQRMhu6XcFPqjGBM4eAjeig76rw940ok1tbOM1NtZ6pXlh7PryojXxkyKmo8WAX/JYSh2Vy0GH42gJDxgMPnDe81JJgI2D0NyY3bSObubxi+GjPBKcipi3udKqrQf1nBBw/uD/Niyevz0MbsArb9xTR5mUI0+l07jTYol1ah8VcCSq5UvzbAxa9X/yBAbmxrZw9C/KRO0dTCv4itcA/lZiZVhA00hqIDyuuLDEYlEPS8tHGdbEDurpfmXlRC9ZCP0vjo5fS8itE46ay0vzpMyFgtvhYWoHc02KzI3VhDV4CvvDEshfoeHGMYkgcM58knhlSaGUcyiq4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v0j5Gmxfx5+O3wgMM7qtQFj9T2WihQNMMQUpfmE5WAg=;
 b=bYx4Ymd8DWX/Hw1gb4m3kzMON4LypbCliD4L0pFe56hP378yKLWUEb70f5GMXNMs+IARUCFjM/Wbm1a9Be5KAo1va4TsmAYNMNqWDUHDmeuXmEQmoZy3+vxuVTSZNukl7F4BrNO1FtqgsMyiHq3ABUcCbkIutSRWlJi6I3UpJbh1rWdJF2UXaVHZApwomRkswm5VGnFPMuPymX8nGobRRh/m26PVZOXPdbna6k0/Fopha3yW4q8Bc4BPnW6yZdHDB/t7M7wVTLrbbgboxjGKTxZkhbvqSFfwHBz4noFiUeSUsx039M7TQEgdT5J5BzPCGaocWsvCUM885/0K0FHfYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v0j5Gmxfx5+O3wgMM7qtQFj9T2WihQNMMQUpfmE5WAg=;
 b=qPZxAkgPJvlNHn1+6XI8PBc9JrFOhaZzUgTToNCgk+QIUBEPy19d9awHL6su3zmwwLnuHzuje/peEAN+4dVkFbpPYTXo/GY7Xl0FNAV2mW84zif/7tDih98S7tYQeTSiYS5bPsGQez1NCSNYm2jzfuGvo8SHn2DlK7zPbWDV+Pc=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1163.namprd12.prod.outlook.com (2603:10b6:3:7a::18) by
 DM6PR12MB3466.namprd12.prod.outlook.com (2603:10b6:5:3b::33) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3391.11; Wed, 23 Sep 2020 10:11:50 +0000
Received: from DM5PR12MB1163.namprd12.prod.outlook.com
 ([fe80::48cf:d69:d457:1b1e]) by DM5PR12MB1163.namprd12.prod.outlook.com
 ([fe80::48cf:d69:d457:1b1e%5]) with mapi id 15.20.3412.022; Wed, 23 Sep 2020
 10:11:49 +0000
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: linux-kernel@vger.kernel.org,
	iommu@lists.linux-foundation.org
Subject: [PATCH 08/13] iommu: amd: Remove amd_iommu_domain_get_pgtable
Date: Wed, 23 Sep 2020 10:14:37 +0000
Message-Id: <20200923101442.73157-9-suravee.suthikulpanit@amd.com>
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
 Transport; Wed, 23 Sep 2020 10:11:48 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: dd6b1e58-48b5-4a96-e92e-08d85fa91568
X-MS-TrafficTypeDiagnostic: DM6PR12MB3466:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB34669755321A39440BFED22BF3380@DM6PR12MB3466.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8ynVDpALBNZFz15Qs3NRnK2gswosHSsqAvUldPkm5K6nZDa9GGN/y5Ky7lgoSUvdU+mBA0CrsQdgzCzqmXUDCEIYkqiHx8DcxHkrUKT2jjInwivKWLDNFILHx02b4+T7tAcYn/rquPaa+UXh+I3wMAs0IItgpKNCa/iq8iK9ZjYE4QI/FXFHyoQpAc4KN7VyNCg8k6ohQfMosUUGtaIOQuJKvIO5ZAH0RN8L5sUD2709i5vC/73yw5w59ugspxViKzBH9r/M+B0lBKhfRin6XqEdj/zVim6yg4tn7llCXNdNAYWtFDvzcKipGmQIL3Qv
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1163.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(366004)(376002)(346002)(396003)(44832011)(5660300002)(66946007)(66476007)(66556008)(83380400001)(6486002)(86362001)(36756003)(2906002)(8936002)(4326008)(26005)(316002)(1076003)(956004)(478600001)(6666004)(186003)(16526019)(52116002)(8676002)(2616005)(7696005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: gTvJEZOJcvqy2tM6EBjujHqaGybIaJVyqhRg4+CKc4qtznLXae7sslg4kpHMxe89nNG4ULyHV/1mo4huz2qLO6PTciD7XmSw2J9dbS/BBC2FFjZ3y3O3SYnus4Zp3QN5ie/LW7POy4hjcMG810DDOlXiv1A3qmFL0guJn1gWMMj/H4cjIezFXYGJrE9n7lF3qUdF03kIH3ZDyVcPWOmWooBAgGf/wNCZjFj1jZHG4EUkfH1cWUrbi3CPByKwb6AcOKUcBxG80nV5eh+nRzANzOEasj3YxrNbjZKVJLUaM6+z2TKmxZykknbITzm1Bo57sevTsy3AMuWaqwEKH8xVqlho/aFbPH4SolB6B6kAw0QDZu6I1sJx4fabd32OYZc4vR7WxzB+nDK9smx2Tu3upxePSyxou8MnWQLqyZDA7/QwKkL3el/qBY2VT04TSZEl2VZpAk98H/PAhCe9GwG1v58oUD+iUWOywmtCFLFfAx2jTfeZXUz7AR2wA3miAFoAFGaE5/xscI2sXRrQP5r7YvCODNzeUHphQNaFqgeNzdr2itJEVRKNZ/4a1O/ift620Ay9T460y5VGkoShpKj6tdmD8JpfF0R4M3Aff37G3K78lnbMkL7wWilz0oTwAUKSE3wOpd6+9eVELrGlPQfpTQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd6b1e58-48b5-4a96-e92e-08d85fa91568
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1163.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2020 10:11:48.9122 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rEognm4EmHPymE5+1j+r7NZxBspTzMS1NB1Dh5XNk0idxg70KPoCYMV0ltP/744hDE2Bnn5BscuyyhvYBB3kAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3466
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
index 8ce2f0325123..524c5406ccd6 100644
--- a/drivers/iommu/amd/io_pgtable.c
+++ b/drivers/iommu/amd/io_pgtable.c
@@ -215,30 +215,27 @@ static bool increase_address_space(struct protection_domain *domain,
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
 
@@ -246,7 +243,7 @@ static bool increase_address_space(struct protection_domain *domain,
 	 * Device Table needs to be updated and flushed before the new root can
 	 * be published.
 	 */
-	amd_iommu_domain_set_pgtable(domain, pte, pgtable.mode);
+	amd_iommu_domain_set_pgtable(domain, pte, domain->iop.mode);
 
 	ret = true;
 
@@ -263,29 +260,23 @@ static u64 *alloc_pte(struct protection_domain *domain,
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
 
@@ -361,19 +352,16 @@ u64 *fetch_pte(struct protection_domain *domain,
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
