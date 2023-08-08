Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2059.outbound.protection.outlook.com [40.107.95.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84CEADDBF
	for <iommu@lists.linux.dev>; Tue,  8 Aug 2023 10:06:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MuST6Jxpgv3dcw+994tp1R/M8cMG8dBklsGUBQTCJyXq0geLHXJIOgU3p4/btmnce7s9iVTlxQPFPNwwr4jgQsUvWPFSN/zspYUleIqCgvjgnyKC3e0kvIpfdrjRt3Kx8aLla/VDFQiB770/g2ZGEsNyGCm5bWW+N0uVG5UfGuDsZFqftL9cGHagfYtT7Zuoy4uwbMzGL33Ej55l8KRg/Hy+lUhVCm3JHWxqzt4SybjWYeW+EhjWRrGcPAy+K2J0nj41GVGPwET54kS7FdKNgeBop48YgY4B0ajhi5fp+D9nZQv4hPvX8Q8MQG61hbTY5oE4IaKqU5YwvwfdEEgJ8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aV2v8Sjx504QYHypF5Iq2TfPPX60LISz9I4VnumVg+I=;
 b=AJm8vsBiho116Qbo9Jg6mQIYfHFPjcRKJuin9UVTU/nGNtx5a/EWFqvNGRrF04RsOL/i7YGkKsY1fcVq96LV+XqI7P8fEn01omCdL2xbrlNcxCQ75n6mdHP2sQfkSAdF0W/kqBBMqysufJWoC+AY5che/M5YDOQgNaxkUFWleCBrGityrmwBPPweZQtFESaDiR9g1Q11MCcNgK5s+hdIf3aBg6aUymafxQNb29xs0TVtGXlutBV/3W38mwYnaNdsrxtu3tZW3QDgLhNQpVayziwraRzOP8mf7hcNw+bZ+/sKjDhIF+vAZIr2PRm7NSXnrKNI7jftLttRDs+4NE1s/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aV2v8Sjx504QYHypF5Iq2TfPPX60LISz9I4VnumVg+I=;
 b=vsj+MpItZO8L/5MgJRuKt/eJdlIWzS1LINN6grCqKEPMDcn30/kNEdVbRruwps+KGQJJkq764n7qfZRUAMQEVTU/Ql53o7gP5IiuvOcR2RC1B3dVa3r4Va61BYYOwm42fdV515EA/hC/ikIQcG1KC0X5NoYLqZ1VezzcWZeKwwg=
Received: from SA9P221CA0011.NAMP221.PROD.OUTLOOK.COM (2603:10b6:806:25::16)
 by CY8PR12MB7100.namprd12.prod.outlook.com (2603:10b6:930:60::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.26; Tue, 8 Aug
 2023 10:06:17 +0000
Received: from SN1PEPF0002636B.namprd02.prod.outlook.com
 (2603:10b6:806:25:cafe::95) by SA9P221CA0011.outlook.office365.com
 (2603:10b6:806:25::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.19 via Frontend
 Transport; Tue, 8 Aug 2023 10:06:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002636B.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.19 via Frontend Transport; Tue, 8 Aug 2023 10:06:20 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 8 Aug
 2023 05:06:17 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH 05/11] iommu/amd: Refactor helper function for setting / clearing GCR3
Date: Tue, 8 Aug 2023 10:02:26 +0000
Message-ID: <20230808100232.5977-6-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230808100232.5977-1-vasant.hegde@amd.com>
References: <20230808100232.5977-1-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636B:EE_|CY8PR12MB7100:EE_
X-MS-Office365-Filtering-Correlation-Id: c1cd4165-bdad-43ba-ef20-08db97f71d6f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	T903Cm4hLqIEkLfMP1k3+BCPdI/o0Am+1tmLFedsaqlFcbAjhnDFYERWh8mrPBv+FtA8NraeqGBSGMefuReQFuz6MY0jNXSZSvyJdcYU9snJ5V4nwMbwRsXZrpQdhZq39eZbgbBLLNG5mh/ZxZTJmJNIxZTmkXxBp4fi03Cd2fzKyrzp+Cvl9uPnj96HEAgIXwSxHPVd8/cBOmT9KXh3IYjnnboryzCC+TBKNI71VQ9OfsbFw3XpqVtQ+80FTWn0sxV2riO+ZdByzdapY4SQjsrVOvV3crYq7tF0WqN+c6HlRCA9RWTlBkkZZnEuzcg4oyiSqAazTqi9H5o8XiVlQ1jaZELJyI2AkmgxhbTnSO5mdk9y8RiJBZSlDaFV3nPhB7uLfGKqUOcaWCump1Lp9la1ol9J9LNGZkcjq6duhDKoyXdLjR0N7HN7/XJEmyiLkhQ9GJ463yOHaAZKb3KHllCs2D+5R93tKTCj6BhC5pWRWETRPNzWrPOpvcDnNyx1dX0UsqqLbupAJxIKlJNKcDoHoXxod5DqmaDCDiSZ2y8VdmVN7MTl35vigO4OL/FRCZTV/Hv+Y6ZwKYOcieAb/G+TVA8zvyLEfYDVRye3yiuoCkFS+lFxPsUhNd77FqApmz70rIILlB38FWwJTW79sGga6bf224KbJAzYB0s75POrXg0VS4bjnNkBBttugBVMAvVHzMgyFmBmYZOBNrmb3dCXPGIuFo44Sjnzk7v3ZwkK14xDgEwlII5DgeDebADN6MxMBcDzdyItmz2k6wLKQw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(39860400002)(346002)(376002)(451199021)(186006)(1800799003)(82310400008)(40470700004)(46966006)(36840700001)(40480700001)(336012)(16526019)(2616005)(40460700003)(81166007)(36756003)(4326008)(316002)(356005)(110136005)(70206006)(6666004)(86362001)(70586007)(478600001)(7696005)(54906003)(82740400003)(1076003)(26005)(426003)(8676002)(41300700001)(8936002)(47076005)(36860700001)(2906002)(83380400001)(5660300002)(44832011)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2023 10:06:20.9023
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c1cd4165-bdad-43ba-ef20-08db97f71d6f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002636B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7100

From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>

Refactor GCR3 helper functions in preparation to use per device
GCR3 table.
  * Use new per device GCR3 table to set/clear the gcr3 entries.

  * Add internal functions which will be used by subsequent patches
    to set/clear default gcr3 entries.

  * Remove per domain default GCR3 setup during v2 page table allocation.
    Subsequent patch will add support to setup default gcr3 while
    attaching device to domain.

  * Remove amd_iommu_domain_update() from V2 page table path as device
    detach path will take care of updating the domain.

  * Rename functions to reflect its usage.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Co-developed-by: Vasant Hegde <vasant.hegde@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/amd_iommu.h     |  8 ++--
 drivers/iommu/amd/io_pgtable_v2.c | 20 ++------
 drivers/iommu/amd/iommu.c         | 79 ++++++++++++++++++-------------
 drivers/iommu/amd/iommu_v2.c      |  7 +--
 4 files changed, 59 insertions(+), 55 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index 1471ab2dddd1..c9a35b6e2a87 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -59,6 +59,11 @@ int amd_iommu_pc_set_reg(struct amd_iommu *iommu, u8 bank, u8 cntr,
 int amd_iommu_pdev_enable_cap_pri(struct pci_dev *pdev);
 void amd_iommu_pdev_disable_cap_pri(struct pci_dev *pdev);
 
+/* GCR3 setup */
+int amd_iommu_set_gcr3(struct iommu_dev_data *dev_data,
+		       u32 pasid, unsigned long gcr3);
+int amd_iommu_clear_gcr3(struct iommu_dev_data *dev_data, u32 pasid);
+
 int amd_iommu_register_ppr_notifier(struct notifier_block *nb);
 int amd_iommu_unregister_ppr_notifier(struct notifier_block *nb);
 void amd_iommu_domain_direct_map(struct iommu_domain *dom);
@@ -69,9 +74,6 @@ void amd_iommu_domain_update(struct protection_domain *domain);
 void amd_iommu_domain_flush_complete(struct protection_domain *domain);
 void amd_iommu_domain_flush_tlb_pde(struct protection_domain *domain);
 int amd_iommu_flush_tlb(struct protection_domain *domain, u32 pasid);
-int amd_iommu_domain_set_gcr3(struct protection_domain *domain, u32 pasid,
-			      unsigned long cr3);
-int amd_iommu_domain_clear_gcr3(struct protection_domain *domain, u32 pasid);
 
 #ifdef CONFIG_IRQ_REMAP
 int amd_iommu_create_irq_domain(struct amd_iommu *iommu);
diff --git a/drivers/iommu/amd/io_pgtable_v2.c b/drivers/iommu/amd/io_pgtable_v2.c
index c17cda83bca5..8c588f93cbed 100644
--- a/drivers/iommu/amd/io_pgtable_v2.c
+++ b/drivers/iommu/amd/io_pgtable_v2.c
@@ -360,34 +360,25 @@ static void v2_free_pgtable(struct io_pgtable *iop)
 	struct amd_io_pgtable *pgtable = container_of(iop, struct amd_io_pgtable, iop);
 
 	pdom = container_of(pgtable, struct protection_domain, iop);
-	if (!(pdom->flags & PD_IOMMUV2_MASK))
-		return;
-
-	/* Clear gcr3 entry */
-	amd_iommu_domain_clear_gcr3(pdom, 0);
 
-	/* Make changes visible to IOMMUs */
-	amd_iommu_domain_update(pdom);
+	if (!pgtable->pgd)
+		return;
 
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
 
-	ret = amd_iommu_domain_set_gcr3(pdom, 0, iommu_virt_to_phys(pgtable->pgd));
-	if (ret)
-		goto err_free_pgd;
-
 	if (get_pgtable_level() == PAGE_MODE_5_LEVEL)
 		ias = 57;
 
@@ -401,11 +392,6 @@ static struct io_pgtable *v2_alloc_pgtable(struct io_pgtable_cfg *cfg, void *coo
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
index 6f6311e8b004..cc42732820dd 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -78,6 +78,11 @@ struct kmem_cache *amd_iommu_irq_cache;
 
 static void detach_device(struct device *dev);
 
+static int __set_gcr3(struct iommu_dev_data *dev_data,
+		       u32 pasid, unsigned long gcr3);
+
+static int __clear_gcr3(struct iommu_dev_data *dev_data, u32 pasid);
+
 /****************************************************************************
  *
  * Helper functions
@@ -2735,65 +2740,75 @@ static u64 *__get_gcr3_pte(u64 *root, int level, u32 pasid, bool alloc)
 	return pte;
 }
 
-static int __set_gcr3(struct protection_domain *domain, u32 pasid,
-		      unsigned long cr3)
+static int __set_gcr3(struct iommu_dev_data *dev_data,
+		      u32 pasid, unsigned long gcr3)
 {
+	struct gcr3_tbl_info *gcr3_info = &dev_data->gcr3_info;
 	u64 *pte;
 
-	if (domain->iop.mode != PAGE_MODE_NONE)
-		return -EINVAL;
+	lockdep_assert_held(&dev_data->lock);
 
-	pte = __get_gcr3_pte(domain->gcr3_tbl, domain->glx, pasid, true);
+	pte = __get_gcr3_pte(gcr3_info->gcr3_tbl,
+			     gcr3_info->glx, pasid, true);
 	if (pte == NULL)
 		return -ENOMEM;
 
-	*pte = (cr3 & PAGE_MASK) | GCR3_VALID;
+	*pte = (gcr3 & PAGE_MASK) | GCR3_VALID;
+	__amd_iommu_flush_tlb(dev_data->domain, pasid);
 
-	return __amd_iommu_flush_tlb(domain, pasid);
+	return 0;
 }
 
-static int __clear_gcr3(struct protection_domain *domain, u32 pasid)
+int amd_iommu_set_gcr3(struct iommu_dev_data *dev_data, u32 pasid,
+		       unsigned long gcr3)
 {
-	u64 *pte;
-
-	if (domain->iop.mode != PAGE_MODE_NONE)
-		return -EINVAL;
+	struct gcr3_tbl_info *gcr3_info = &dev_data->gcr3_info;
+	int ret;
 
-	pte = __get_gcr3_pte(domain->gcr3_tbl, domain->glx, pasid, false);
-	if (pte == NULL)
-		return 0;
+	spin_lock(&dev_data->lock);
 
-	*pte = 0;
+	ret = __set_gcr3(dev_data, pasid, gcr3);
+	if (!ret)
+		gcr3_info->pasid_cnt++;
 
-	return __amd_iommu_flush_tlb(domain, pasid);
+	spin_unlock(&dev_data->lock);
+	return ret;
 }
+EXPORT_SYMBOL(amd_iommu_set_gcr3);
 
-int amd_iommu_domain_set_gcr3(struct protection_domain *domain, u32 pasid,
-			      unsigned long cr3)
+static int __clear_gcr3(struct iommu_dev_data *dev_data, u32 pasid)
 {
-	unsigned long flags;
-	int ret;
+	struct gcr3_tbl_info *gcr3_info = &dev_data->gcr3_info;
+	u64 *pte;
 
-	spin_lock_irqsave(&domain->lock, flags);
-	ret = __set_gcr3(domain, pasid, cr3);
-	spin_unlock_irqrestore(&domain->lock, flags);
+	lockdep_assert_held(&dev_data->lock);
 
-	return ret;
+	pte = __get_gcr3_pte(gcr3_info->gcr3_tbl,
+			     gcr3_info->glx, pasid, false);
+	if (pte == NULL)
+		return -EINVAL;
+
+	*pte = 0;
+	__amd_iommu_flush_tlb(dev_data->domain, pasid);
+
+	return 0;
 }
-EXPORT_SYMBOL(amd_iommu_domain_set_gcr3);
 
-int amd_iommu_domain_clear_gcr3(struct protection_domain *domain, u32 pasid)
+int amd_iommu_clear_gcr3(struct iommu_dev_data *dev_data, u32 pasid)
 {
-	unsigned long flags;
+	struct gcr3_tbl_info *gcr3_info = &dev_data->gcr3_info;
 	int ret;
 
-	spin_lock_irqsave(&domain->lock, flags);
-	ret = __clear_gcr3(domain, pasid);
-	spin_unlock_irqrestore(&domain->lock, flags);
+	spin_lock(&dev_data->lock);
 
+	ret = __clear_gcr3(dev_data, pasid);
+	if (!ret)
+		gcr3_info->pasid_cnt--;
+
+	spin_unlock(&dev_data->lock);
 	return ret;
 }
-EXPORT_SYMBOL(amd_iommu_domain_clear_gcr3);
+EXPORT_SYMBOL(amd_iommu_clear_gcr3);
 
 int amd_iommu_complete_ppr(struct pci_dev *pdev, u32 pasid,
 			   int status, int tag)
diff --git a/drivers/iommu/amd/iommu_v2.c b/drivers/iommu/amd/iommu_v2.c
index 4148cbf069dc..8453b2d9d27b 100644
--- a/drivers/iommu/amd/iommu_v2.c
+++ b/drivers/iommu/amd/iommu_v2.c
@@ -271,6 +271,7 @@ static void put_pasid_state_wait(struct pasid_state *pasid_state)
 static void unbind_pasid(struct pasid_state *pasid_state)
 {
 	struct device_state *dev_state = pasid_state->device_state;
+	struct iommu_dev_data *dev_data = dev_iommu_priv_get(&dev_state->pdev->dev);
 
 	/*
 	 * Mark pasid_state as invalid, no more faults will we added to the
@@ -282,7 +283,7 @@ static void unbind_pasid(struct pasid_state *pasid_state)
 	smp_wmb();
 
 	/* After this the device/pasid can't access the mm anymore */
-	amd_iommu_domain_clear_gcr3(dev_state->pdom, pasid_state->pasid);
+	amd_iommu_clear_gcr3(dev_data, pasid_state->pasid);
 
 	/* Make sure no more pending faults are in the queue */
 	flush_workqueue(iommu_wq);
@@ -605,6 +606,7 @@ int amd_iommu_bind_pasid(struct pci_dev *pdev, u32 pasid,
 	struct mm_struct *mm;
 	u32 sbdf;
 	int ret;
+	struct iommu_dev_data *dev_data = dev_iommu_priv_get(&pdev->dev);
 
 	might_sleep();
 
@@ -650,8 +652,7 @@ int amd_iommu_bind_pasid(struct pci_dev *pdev, u32 pasid,
 	if (ret)
 		goto out_unregister;
 
-	ret = amd_iommu_domain_set_gcr3(dev_state->pdom, pasid,
-					__pa(pasid_state->mm->pgd));
+	ret = amd_iommu_set_gcr3(dev_data, pasid, __pa(pasid_state->mm->pgd));
 	if (ret)
 		goto out_clear_state;
 
-- 
2.31.1

