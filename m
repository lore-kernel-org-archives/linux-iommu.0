Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2063.outbound.protection.outlook.com [40.107.220.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 126231B957
	for <iommu@lists.linux.dev>; Mon,  5 Feb 2024 12:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707134461; cv=fail; b=NwvlsFLyMcxvvV7Q6Qowt0bnnGrs6M7JPhYAt9ZmJLGjXNE01Hda5K07cb/dS0heCofZjsBwO4rE1V1YwwjWIXBQxZSZNzDQw4dwVkzRsegXITxWul2TuzEvdJuUT6LpQY93KDx2Hrw2mqY3VnwBI+JgXFDbMIvc8H6VNio3ZUE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707134461; c=relaxed/simple;
	bh=Uxu2JHrrVKiVHDdO+0XMPB9d+sykjXJC8Y6jYCOAF9s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g9q7ENcqaZFE4jfqi0ZtlbXEw3ci1Sqa+xjog6L62l3Bl16To7NagET8cpN3+Og7cGJqJ16f7bdnKxVoJAKNzkyjQ7qBVUl4/tkwCj3XX2zzOY6B2x+WOTyD13eXMKhFonnwpgdkCdFjZlpODqMuxH4fyTtAQ3SxaLFtNDXiYI0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=nUjT7P47; arc=fail smtp.client-ip=40.107.220.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="nUjT7P47"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=efeJluoFWm1ezoxmSf9GFf9XFAEEG57Vk6/iwBdsnHeMDl4WzUhh5YJ5yZFbicBpfJC8o1D5bazx9MV7MWxuc4WD5zP8jdFTOWjffZ2NP13r7o61vFURT/8pEfFSwmjUYCdZ9tcWuyEc4ZS3V9jiAL/7GXLg2tFYYs1Av+sCSALxWSmPP3dj8RBbziiDunE3qZfKjTs7WEFBzPPmnNlmflpQmy1QRyCI7tFdAlGhu/ISn+n+Vd0wktNb/8cKZAbSvcXQT9ryTEH3jVNlOxZfQSqXeDHT7uBw8SkqYUUn5U/eUu61IPCzD+2a2y+MlvzZD38xuTaqpJCw5MoHrMbAKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U5lkW0nTRIlzfbEdwi+QrPjp/k/3TUVF5VFKgkRa6Hk=;
 b=kno0rwRxu1RDhXPdyCe1jr0eW90f5cbAvfOr9FppPnq9SFP6eNsIPG0Y5/RGjeVVeuzEWKF1iMPuJNGvXPpDf5pC9xd/GSa32gQPKuJDnbBRj+choSTTovxR6wsRkT2SD7+glV7vRc8UzARz6zjonnPLURg+4Oq0Jf9L1sy/33T9wxWrP6F3C4wo5ToOE/MOCiABPy8AO/n+R+c92ucgAkFexYtA/fC+OT44fGVZJ4U/b1zcbaMkJKSgISDivL+0IhfWsWlEuCB7KZ69dSh9zCPAasWSR/VMqS3C3Lzq6GHF3My76wpwi7Cjr37LiyCnFqYm/Viq9OUC6QqhLZK3pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U5lkW0nTRIlzfbEdwi+QrPjp/k/3TUVF5VFKgkRa6Hk=;
 b=nUjT7P47MgG1dMMzZg/p0a3Rs3mouRlTyAxYNcgp0ex1X/7bIysBsyoln1SB5Yud75HVp5vy0nu5wjQ5nxWrdrkGxqJXHaEHEQEL2o+TLUc2RG6Qf4njEMQ5JWO/vweXzco8+MWZ7fCUdT8zBwQf/gyHWHSOMatFfzGSH0pHmwo=
Received: from BN0PR07CA0008.namprd07.prod.outlook.com (2603:10b6:408:141::35)
 by CY8PR12MB7732.namprd12.prod.outlook.com (2603:10b6:930:87::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.16; Mon, 5 Feb
 2024 12:00:56 +0000
Received: from BN2PEPF0000449D.namprd02.prod.outlook.com
 (2603:10b6:408:141:cafe::d7) by BN0PR07CA0008.outlook.office365.com
 (2603:10b6:408:141::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.34 via Frontend
 Transport; Mon, 5 Feb 2024 12:00:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF0000449D.mail.protection.outlook.com (10.167.243.148) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Mon, 5 Feb 2024 12:00:56 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 5 Feb
 2024 06:00:53 -0600
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v7 10/17] iommu/amd: Refactor helper function for setting / clearing GCR3
Date: Mon, 5 Feb 2024 11:56:08 +0000
Message-ID: <20240205115615.6053-11-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240205115615.6053-1-vasant.hegde@amd.com>
References: <20240205115615.6053-1-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000449D:EE_|CY8PR12MB7732:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d5ac98e-108d-4edb-f48d-08dc26421c3b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	E4q3XrLpylgrD77jxvl6dTAeXy2OKqvdtPJ8byUeCyPiaEm076GvUUBDSQ7BltDUgBDRDbRv02bHIhTS8DgFd+pV/qz/plQm2nu2x3pYhfPOOxFt0EXWZyb1BkPnPSdkndLlQ83rN+FGnPVkLlJSWyMMK0YwwEhXCNp4/Ju/PuWTQiuemsaaB3CrmeRc7Yu4bMbLfjg/hD2raMdKm76WQpQQBoZ6RgeFv+l/1MYZLTzOC4puP6k/HseGb6ee00fX3q2y3aTNGTBMoL1OM0cYTiMQjNQdyl/XAm1/twgzdFPFTjfWVJpYrdVAKG8qR4MS5e/eUGgVupeVa98kOlzXJmSWioNLxpfzVLPUtLQYJKYH7oMRd2KUPfHlb2QdoFyVKepj+xWNJ4NZ1Bhc6iHjyNh8viVpJlx1EqwcwBKacF4Y210DxQVe8KZMY+Prza29S/GncWJocNHrxoeRVjK6FJrxsV3ad65Bw8NnR8AveZ6C2CXj3mbtyk1ddy4p84ks65X6vDBG5AkspxWHPxLNXFsjbmqXh59nzqH+KiYji74gsgpdU4h7ZVbpDftqlg5hIcSNoifNv8jVFGzI4JVBX5fCq1f8HCCGkkQxVxoDSXjSeMuygB95lEfyA1t+9kIhGhL5Mz3LbQA4OPm28aAsx52rYnbZoZ8DdQI3uKBsTR65UxujotzHWXddHs2Yf/RDXk05I3sOVJ9KBZJ/LHecJzMIqRhKhSIXwyLYvPwB0OeNpUfVrKe3VjUQ0EvEzHLifEi6PUOJddR1rnKbAklqlg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(396003)(136003)(346002)(39860400002)(230922051799003)(64100799003)(82310400011)(186009)(1800799012)(451199024)(46966006)(36840700001)(40470700004)(40480700001)(40460700003)(36756003)(478600001)(86362001)(336012)(356005)(83380400001)(41300700001)(1076003)(2616005)(426003)(81166007)(82740400003)(26005)(16526019)(47076005)(6666004)(5660300002)(70586007)(8676002)(70206006)(316002)(44832011)(2906002)(54906003)(8936002)(4326008)(7696005)(36860700001)(110136005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2024 12:00:56.2531
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d5ac98e-108d-4edb-f48d-08dc26421c3b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF0000449D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7732

From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>

Refactor GCR3 helper functions in preparation to use per device
GCR3 table.
  * Add new function update_gcr3 to update per device GCR3 table

  * Remove per domain default GCR3 setup during v2 page table allocation.
    Subsequent patch will add support to setup default gcr3 while
    attaching device to domain.

  * Remove amd_iommu_domain_update() from V2 page table path as device
    detach path will take care of updating the domain.

  * Consolidate GCR3 table related code in one place so that its easy
    to maintain.

  * Rename functions to reflect its usage.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Co-developed-by: Vasant Hegde <vasant.hegde@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/amd/amd_iommu.h     |   8 ++-
 drivers/iommu/amd/io_pgtable_v2.c |  21 +-----
 drivers/iommu/amd/iommu.c         | 115 ++++++++++++++----------------
 3 files changed, 61 insertions(+), 83 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index 5e4614dbd435..3a9b32ad1411 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -52,6 +52,11 @@ int amd_iommu_pc_set_reg(struct amd_iommu *iommu, u8 bank, u8 cntr,
 int amd_iommu_pdev_enable_cap_pri(struct pci_dev *pdev);
 void amd_iommu_pdev_disable_cap_pri(struct pci_dev *pdev);
 
+/* GCR3 setup */
+int amd_iommu_set_gcr3(struct iommu_dev_data *dev_data,
+		       ioasid_t pasid, unsigned long gcr3);
+int amd_iommu_clear_gcr3(struct iommu_dev_data *dev_data, ioasid_t pasid);
+
 int amd_iommu_flush_page(struct iommu_domain *dom, u32 pasid, u64 address);
 /*
  * This function flushes all internal caches of
@@ -69,9 +74,6 @@ void amd_iommu_dev_flush_pasid_all(struct iommu_dev_data *dev_data,
 				   ioasid_t pasid);
 
 int amd_iommu_flush_tlb(struct iommu_domain *dom, u32 pasid);
-int amd_iommu_domain_set_gcr3(struct iommu_domain *dom, u32 pasid,
-			      unsigned long cr3);
-int amd_iommu_domain_clear_gcr3(struct iommu_domain *dom, u32 pasid);
 
 #ifdef CONFIG_IRQ_REMAP
 int amd_iommu_create_irq_domain(struct amd_iommu *iommu);
diff --git a/drivers/iommu/amd/io_pgtable_v2.c b/drivers/iommu/amd/io_pgtable_v2.c
index 6d69ba60744f..93489d2db4e8 100644
--- a/drivers/iommu/amd/io_pgtable_v2.c
+++ b/drivers/iommu/amd/io_pgtable_v2.c
@@ -350,38 +350,26 @@ static const struct iommu_flush_ops v2_flush_ops = {
 
 static void v2_free_pgtable(struct io_pgtable *iop)
 {
-	struct protection_domain *pdom;
 	struct amd_io_pgtable *pgtable = container_of(iop, struct amd_io_pgtable, iop);
 
-	pdom = container_of(pgtable, struct protection_domain, iop);
-	if (!(pdom->flags & PD_IOMMUV2_MASK))
+	if (!pgtable || !pgtable->pgd)
 		return;
 
-	/* Clear gcr3 entry */
-	amd_iommu_domain_clear_gcr3(&pdom->domain, 0);
-
-	/* Make changes visible to IOMMUs */
-	amd_iommu_domain_update(pdom);
-
 	/* Free page table */
 	free_pgtable(pgtable->pgd, get_pgtable_level());
+	pgtable->pgd = NULL;
 }
 
 static struct io_pgtable *v2_alloc_pgtable(struct io_pgtable_cfg *cfg, void *cookie)
 {
 	struct amd_io_pgtable *pgtable = io_pgtable_cfg_to_data(cfg);
 	struct protection_domain *pdom = (struct protection_domain *)cookie;
-	int ret;
 	int ias = IOMMU_IN_ADDR_BIT_SIZE;
 
 	pgtable->pgd = alloc_pgtable_page(pdom->nid, GFP_ATOMIC);
 	if (!pgtable->pgd)
 		return NULL;
 
-	ret = amd_iommu_domain_set_gcr3(&pdom->domain, 0, iommu_virt_to_phys(pgtable->pgd));
-	if (ret)
-		goto err_free_pgd;
-
 	if (get_pgtable_level() == PAGE_MODE_5_LEVEL)
 		ias = 57;
 
@@ -395,11 +383,6 @@ static struct io_pgtable *v2_alloc_pgtable(struct io_pgtable_cfg *cfg, void *coo
 	cfg->tlb           = &v2_flush_ops;
 
 	return &pgtable->iop;
-
-err_free_pgd:
-	free_pgtable_page(pgtable->pgd);
-
-	return NULL;
 }
 
 struct io_pgtable_init_fns io_pgtable_amd_iommu_v2_init_fns = {
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index c0c5f6b3d4f4..2261a6914bb5 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -1718,10 +1718,13 @@ static int setup_gcr3_table(struct protection_domain *domain, int pasids)
 	return 0;
 }
 
-static u64 *__get_gcr3_pte(u64 *root, int level, u32 pasid, bool alloc)
+static u64 *__get_gcr3_pte(struct gcr3_tbl_info *gcr3_info,
+			   ioasid_t pasid, bool alloc)
 {
 	int index;
 	u64 *pte;
+	u64 *root = gcr3_info->gcr3_tbl;
+	int level = gcr3_info->glx;
 
 	while (true) {
 
@@ -1750,6 +1753,56 @@ static u64 *__get_gcr3_pte(u64 *root, int level, u32 pasid, bool alloc)
 	return pte;
 }
 
+static int update_gcr3(struct iommu_dev_data *dev_data,
+		       ioasid_t pasid, unsigned long gcr3, bool set)
+{
+	struct gcr3_tbl_info *gcr3_info = &dev_data->gcr3_info;
+	u64 *pte;
+
+	pte = __get_gcr3_pte(gcr3_info, pasid, true);
+	if (pte == NULL)
+		return -ENOMEM;
+
+	if (set)
+		*pte = (gcr3 & PAGE_MASK) | GCR3_VALID;
+	else
+		*pte = 0;
+
+	amd_iommu_dev_flush_pasid_all(dev_data, pasid);
+	return 0;
+}
+
+int amd_iommu_set_gcr3(struct iommu_dev_data *dev_data, ioasid_t pasid,
+		       unsigned long gcr3)
+{
+	struct gcr3_tbl_info *gcr3_info = &dev_data->gcr3_info;
+	int ret;
+
+	iommu_group_mutex_assert(dev_data->dev);
+
+	ret = update_gcr3(dev_data, pasid, gcr3, true);
+	if (ret)
+		return ret;
+
+	gcr3_info->pasid_cnt++;
+	return ret;
+}
+
+int amd_iommu_clear_gcr3(struct iommu_dev_data *dev_data, ioasid_t pasid)
+{
+	struct gcr3_tbl_info *gcr3_info = &dev_data->gcr3_info;
+	int ret;
+
+	iommu_group_mutex_assert(dev_data->dev);
+
+	ret = update_gcr3(dev_data, pasid, 0, false);
+	if (ret)
+		return ret;
+
+	gcr3_info->pasid_cnt--;
+	return ret;
+}
+
 static void set_dte_entry(struct amd_iommu *iommu,
 			  struct iommu_dev_data *dev_data)
 {
@@ -2774,66 +2827,6 @@ int amd_iommu_flush_tlb(struct iommu_domain *dom, u32 pasid)
 	return ret;
 }
 
-static int __set_gcr3(struct protection_domain *domain, u32 pasid,
-		      unsigned long cr3)
-{
-	u64 *pte;
-
-	if (domain->iop.mode != PAGE_MODE_NONE)
-		return -EINVAL;
-
-	pte = __get_gcr3_pte(domain->gcr3_tbl, domain->glx, pasid, true);
-	if (pte == NULL)
-		return -ENOMEM;
-
-	*pte = (cr3 & PAGE_MASK) | GCR3_VALID;
-
-	return __amd_iommu_flush_tlb(domain, pasid);
-}
-
-static int __clear_gcr3(struct protection_domain *domain, u32 pasid)
-{
-	u64 *pte;
-
-	if (domain->iop.mode != PAGE_MODE_NONE)
-		return -EINVAL;
-
-	pte = __get_gcr3_pte(domain->gcr3_tbl, domain->glx, pasid, false);
-	if (pte == NULL)
-		return 0;
-
-	*pte = 0;
-
-	return __amd_iommu_flush_tlb(domain, pasid);
-}
-
-int amd_iommu_domain_set_gcr3(struct iommu_domain *dom, u32 pasid,
-			      unsigned long cr3)
-{
-	struct protection_domain *domain = to_pdomain(dom);
-	unsigned long flags;
-	int ret;
-
-	spin_lock_irqsave(&domain->lock, flags);
-	ret = __set_gcr3(domain, pasid, cr3);
-	spin_unlock_irqrestore(&domain->lock, flags);
-
-	return ret;
-}
-
-int amd_iommu_domain_clear_gcr3(struct iommu_domain *dom, u32 pasid)
-{
-	struct protection_domain *domain = to_pdomain(dom);
-	unsigned long flags;
-	int ret;
-
-	spin_lock_irqsave(&domain->lock, flags);
-	ret = __clear_gcr3(domain, pasid);
-	spin_unlock_irqrestore(&domain->lock, flags);
-
-	return ret;
-}
-
 int amd_iommu_complete_ppr(struct pci_dev *pdev, u32 pasid,
 			   int status, int tag)
 {
-- 
2.31.1

