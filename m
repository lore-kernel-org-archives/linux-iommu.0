Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2066.outbound.protection.outlook.com [40.107.92.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FF3A56B93
	for <iommu@lists.linux.dev>; Tue, 12 Dec 2023 08:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="LFrow6DD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FpFn5HbveV07VFUVZ5E39CEgFva7YCHUcjssxUXybiYvStmFnC90S3udz8jSVgHRZPnBgEBMpTZaYCObJ9Ehuno3a5oUZZ2szafufQlKS5bEYDBPQt5McRVK2hRliSnRTpgNAgReyOkYnIirebY0SbBCa7f9lMMAomyooy9V+rLj8RXvRIIBYGBG6C0qWbhXxaB/nshR4sPSba4jFBkpCYZvIHX3JzDKFmaCM/n4FEPigugFzWYZB02FJ1F8aONKLVo0mJ8wYOUVM13zFL96XvVUZHzMboQwC3FJJOzxKJd5lMnCEEDBcsJ/3Czv3DHbXFwZyGMgLtEf7HAiPeG0cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j/Y0ofKBFPx3TxnaCeN+veQKRSdg/VxKVrDtREA0mZg=;
 b=esjzKlPOR9Ydbe2zzo6Qwkk+XUHhbjjjQe/y3ZZQFcNEZ4qvOlERoGEU9vz03+vkAOaqlggDrCU6KJqG5Uor9WE3zGRfEq6auxB6OkxTYvaekoTiSifmFS8BgE4gUQvD+QHVK5UsK4+5dFlJsZlugh6gEJBIa1PAXOR5+lHUyu/9emjM6lGDm06rWgZm9ZUDkBty2480bGMAihpUfxaDDE60TGlOavB2mffRA0diQfWZmBnY0MsBz8NhsZDjK+hD3b2HSq8OUXy1nsPZMrtsUvKfrHvdbyIiuRfI8mFgVQ9CEaEj//7foXQ2x1/yIwa55aJezoDZt0gx9AgF4fcU0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j/Y0ofKBFPx3TxnaCeN+veQKRSdg/VxKVrDtREA0mZg=;
 b=LFrow6DDXKR2GtMHtKPatgVJFAra8HTglSObWp2r7POT3PGWjHwJfdUrlRsYIl/wMeTxi+K/kttn57KxhX/P6lHEKT+uCKpiOtzxZSbiS4sv/Zd8cTVQhnieloUPbNvdetQU/yzmrNF4gP//dGU8ucHrXuAlg2Gom/wKod5vgBQ=
Received: from BYAPR21CA0021.namprd21.prod.outlook.com (2603:10b6:a03:114::31)
 by MW4PR12MB6705.namprd12.prod.outlook.com (2603:10b6:303:1e3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.34; Tue, 12 Dec
 2023 08:56:59 +0000
Received: from CO1PEPF000042A7.namprd03.prod.outlook.com
 (2603:10b6:a03:114:cafe::b8) by BYAPR21CA0021.outlook.office365.com
 (2603:10b6:a03:114::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.4 via Frontend
 Transport; Tue, 12 Dec 2023 08:56:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042A7.mail.protection.outlook.com (10.167.243.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7091.18 via Frontend Transport; Tue, 12 Dec 2023 08:56:59 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 12 Dec
 2023 02:56:51 -0600
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v4 10/16] iommu/amd: Refactor helper function for setting / clearing GCR3
Date: Tue, 12 Dec 2023 08:52:18 +0000
Message-ID: <20231212085224.6985-11-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231212085224.6985-1-vasant.hegde@amd.com>
References: <20231212085224.6985-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000042A7:EE_|MW4PR12MB6705:EE_
X-MS-Office365-Filtering-Correlation-Id: 09419ebc-095c-4dc4-baa7-08dbfaf04cee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	bZczYg0tjFcDRCQ+mTX1inHBkrrgp5rFGepNKXyjWm0Q4tTBzSbGyLiXRVSnao+tySoO7QYm2A6XlLJflDomj/gbVMuXPIbnwdjNpkLizHAoHO+6+5ZMXakXDkIqt+elxRWNjn2TUrzwA3jPXcsnjPUkIqKphpHMTxgLLUvEqY5710bVpyxyH9J0uvnfQNyScF4sADOu1fuazDv+lIweFjxbRavSK+N6Caqhexq0FaUAH/nlAI70qt5lwvZ1wbx1OEV67YMMBxZWPult0MA1HfGTVeqN4RniMHaMq6YZsOtHCooEqGJtoqpUNQFJAI/aCX3bMoeXvzUYpPstOySUj40cZnkXgVM8/dBMVj3LhwO0l81w9abJq40SCAs+J9QlNInwL4hdq6us4qloQYuIj+aprPCX7OgE2wqxeAW96sWKAH2uC5Y+9yQtUFfmQ8oyXXkiVGp9rwUZIUcnI/UJf+zFs5OClyvigt8JzdglwMyF9Hg7i2fog6Rpwg/eAsS35H+CGcgKHTrJDNo+mD2NhZk6Hilw0JuXkqMfkaeOyFQZsgaCtc8MTu02LOxv77daac6t+jn9kacs+Doyh/oKEGEssyqnXo4RyZqNUmtuHbccjTi4/TrvMh28tLaauanPEtXx4GY0NofdrtVsFoCApC3w0QeKx6NtPBrUYEI65EvZQf9lWvP8z9k7MX1TTDDW0ldfPDZiR6Gpa6JWjNlKUCFfzWKf31fNJQJ+9nCwrOOXTmTO/l5yJs3efN/smKMainf1yLBVlcb42QUD3OmeTQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(39860400002)(346002)(136003)(396003)(230922051799003)(451199024)(1800799012)(82310400011)(64100799003)(186009)(46966006)(40470700004)(36840700001)(40460700003)(426003)(336012)(16526019)(26005)(83380400001)(7696005)(1076003)(2616005)(47076005)(36860700001)(44832011)(5660300002)(8676002)(8936002)(4326008)(41300700001)(2906002)(6666004)(478600001)(316002)(54906003)(70206006)(70586007)(110136005)(86362001)(36756003)(356005)(81166007)(82740400003)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2023 08:56:59.1303
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 09419ebc-095c-4dc4-baa7-08dbfaf04cee
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000042A7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6705

From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>

Refactor GCR3 helper functions in preparation to use per device
GCR3 table.
  * Use new per device GCR3 table to set/clear the gcr3 entries.

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
---
 drivers/iommu/amd/amd_iommu.h     |   8 +-
 drivers/iommu/amd/io_pgtable_v2.c |  21 +----
 drivers/iommu/amd/iommu.c         | 131 ++++++++++++++++--------------
 3 files changed, 77 insertions(+), 83 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index ac95481f2339..c712cd086286 100644
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
index 85a30b1614de..834c0a79fc17 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -1764,10 +1764,13 @@ static int setup_gcr3_table(struct protection_domain *domain, int pasids)
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
 
@@ -1796,6 +1799,72 @@ static u64 *__get_gcr3_pte(u64 *root, int level, u32 pasid, bool alloc)
 	return pte;
 }
 
+static int __set_gcr3(struct iommu_dev_data *dev_data,
+		      ioasid_t pasid, unsigned long gcr3)
+{
+	struct gcr3_tbl_info *gcr3_info = &dev_data->gcr3_info;
+	u64 *pte;
+
+	lockdep_assert_held(&dev_data->lock);
+
+	pte = __get_gcr3_pte(gcr3_info, pasid, true);
+	if (pte == NULL)
+		return -ENOMEM;
+
+	*pte = (gcr3 & PAGE_MASK) | GCR3_VALID;
+	amd_iommu_dev_flush_pasid_all(dev_data, pasid);
+
+	return 0;
+}
+
+int amd_iommu_set_gcr3(struct iommu_dev_data *dev_data, ioasid_t pasid,
+		       unsigned long gcr3)
+{
+	struct gcr3_tbl_info *gcr3_info = &dev_data->gcr3_info;
+	int ret;
+
+	spin_lock(&dev_data->lock);
+
+	ret = __set_gcr3(dev_data, pasid, gcr3);
+	if (!ret)
+		gcr3_info->pasid_cnt++;
+
+	spin_unlock(&dev_data->lock);
+	return ret;
+}
+
+static int __clear_gcr3(struct iommu_dev_data *dev_data, ioasid_t pasid)
+{
+	struct gcr3_tbl_info *gcr3_info = &dev_data->gcr3_info;
+	u64 *pte;
+
+	lockdep_assert_held(&dev_data->lock);
+
+	pte = __get_gcr3_pte(gcr3_info, pasid, false);
+	if (pte == NULL)
+		return -EINVAL;
+
+	*pte = 0;
+	amd_iommu_dev_flush_pasid_all(dev_data, pasid);
+
+	return 0;
+}
+
+int amd_iommu_clear_gcr3(struct iommu_dev_data *dev_data, ioasid_t pasid)
+{
+	struct gcr3_tbl_info *gcr3_info = &dev_data->gcr3_info;
+	int ret;
+
+	spin_lock(&dev_data->lock);
+
+	ret = __clear_gcr3(dev_data, pasid);
+	if (!ret)
+		gcr3_info->pasid_cnt--;
+
+	spin_unlock(&dev_data->lock);
+	return ret;
+}
+
 static void set_dte_entry(struct amd_iommu *iommu,
 			  struct iommu_dev_data *dev_data)
 {
@@ -2838,66 +2907,6 @@ int amd_iommu_flush_tlb(struct iommu_domain *dom, u32 pasid)
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

