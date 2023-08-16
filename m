Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2046.outbound.protection.outlook.com [40.107.243.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 103DB174D0
	for <iommu@lists.linux.dev>; Wed, 16 Aug 2023 17:42:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nOvPHifGaoOuQVGXM4178H1ogV82XVPCGFQ8+EoV+ZZuMznu258peN+jA+TXMxQ0OKsChCq6IPjB56sj1gekQHv22L08FsW5ggZxkAOdX7x7gxHLA4s1/HAF5pIqa+0V4uAOGdjUPXRAnLtfrG7PUX683y6LTUePfeMhivjalDFXJ8nCX1hWSnGhJ1hquWOBLCHbkOKVhfcjCDaaOJTcqlqZOKFhGyMDdOB+1+QWmnjrFjhl6NzEzt2/8dLKxZu86riLzg+E8q6kPVCApAgf6+4uAiGUe4qs666tVpvmMlzMSKWbsPIdM07Kwsn1AY25UYhFFznuPILjMc4QFKwUTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ga0EWqjry6VpSyyOfPVPc8M8TtRMODWxMWi50cdeJL0=;
 b=nQZqTnGk+UtNowd4/i6Y4zAyCblqFrUIX4xw1u+YWSZpoNDgeya8+YdFt/rP5e0zebddBripIKwa/dXLJOV/FZRKVHqF7AVKOULgJY3spr9Lbo4Hn03DNL14VZP97VTrFllUIP94IHRdc9k7P3zhpnC9wNlZizP3q+QTYPx8aXssuixG2LY/DdxQRaC5ajQMPr/IHRd4KseHnc9TNrJSKFcBYvJK3Ehl2fRDX3c2MFvAYxA3S9Q8a48qyXTYnlQ6WK81lODQRSERdLkHCGclXra4zedPVmvp5qbFA3xxuczxOeWmx+0Ts5O5AiMoDKsM4opUIwwDs5ggokJizOlBvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ga0EWqjry6VpSyyOfPVPc8M8TtRMODWxMWi50cdeJL0=;
 b=ivFy4TO08RXq/kEEir328reZ5AGOBWo7t4wkk5ARB5qGtpmMLHBf713gD7YT4eFmyyA9H0VHSigXk4c1KApZ8rFxWI2ZWTt69a2yaH8g+EMaFUlkabAbFEh2v0qoZa+oHHzlTX3BJLiEDSV40v9od7Mp1Y+fpseywM5QqoB2TD0=
Received: from MW4PR03CA0298.namprd03.prod.outlook.com (2603:10b6:303:b5::33)
 by DM6PR12MB4169.namprd12.prod.outlook.com (2603:10b6:5:215::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.29; Wed, 16 Aug
 2023 17:42:30 +0000
Received: from MWH0EPF000989E9.namprd02.prod.outlook.com
 (2603:10b6:303:b5:cafe::35) by MW4PR03CA0298.outlook.office365.com
 (2603:10b6:303:b5::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.14 via Frontend
 Transport; Wed, 16 Aug 2023 17:42:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989E9.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.15 via Frontend Transport; Wed, 16 Aug 2023 17:42:29 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 16 Aug
 2023 12:42:26 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v2 06/10] iommu/amd: Refactor helper function for setting / clearing GCR3
Date: Wed, 16 Aug 2023 17:40:27 +0000
Message-ID: <20230816174031.634453-7-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230816174031.634453-1-vasant.hegde@amd.com>
References: <20230816174031.634453-1-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E9:EE_|DM6PR12MB4169:EE_
X-MS-Office365-Filtering-Correlation-Id: f2e781e2-13ef-4963-d0e9-08db9e8029da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	oVbf/zWRb76re0kxRxhCbEJ7IqADdIp6XI6MZweAp09WehAtZ47q4U6ki/w0eQmAh3tf3qWG03ZmZOqdzZi9TK2RRRX4LEFAW4+nbb544O4/vzpLZAa0DwKuNgIDmL1fxvYv+hhWv6wsPeVcpSnoxZaLY52IUtpa+cV2qXuCxMPkpDRz2KpkID1VyADPnFg7PMz0ePVKviri0S5PbXt9h6FCpRzpo2kLxc1wPqJlWBghYL1b3RJhIMNtzmZ2Nq7zeNavvyrt1/qrvMCEgpMp0dfoBoeuApLFd+/E8x6CoDV3GkrNqslTcFE697GDrqc+YlJYKwRvxaetdNY93s564/S985nNvriu3OAQm+HMu+1/JRDj9699oE6FA6Rh3/jcDlMZnsiB3qerdOGXxF5xRVDNCYrzF9FPXd9SBlktA+JkiTup1nsuV5Zu6zJ7YO/9CDrX7iFWywnAwRMNeUpDIlQ3K7nHnMEb5xUK77hm5DSsDY9ZGDeA4seF9mnoXsruwcpX4xya9GhVADbeSaAiwfvgVFkhUpP1jiEB9oCA6n30sudV2gqmLu9sWpGIThE1RiWRHcgG2RWgITyrvkUX+YQtRA4N8Puwz9IAw+hByUUgI8ViDrNUg6g8kcHKeko8vmv1pFuBPWuoP9NYUxynclsv8rngEMz6OdnT+nafo/x13Bvt1JGQGJfZ4EBdaimfpGWfH3DL4ieW/ER7GidScmlGs1vRHDpnJtrOAYKHcgTsvi9kSpsWLhRL0JUUQhO1Q7ZF3yeWRdC6EdPhAGxuDw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(376002)(39860400002)(396003)(346002)(451199024)(1800799009)(82310400011)(186009)(46966006)(36840700001)(40470700004)(2906002)(40460700003)(83380400001)(86362001)(40480700001)(478600001)(426003)(336012)(36756003)(7696005)(2616005)(1076003)(26005)(16526019)(5660300002)(44832011)(36860700001)(41300700001)(356005)(54906003)(82740400003)(316002)(81166007)(70206006)(70586007)(110136005)(8676002)(8936002)(4326008)(47076005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2023 17:42:29.6703
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f2e781e2-13ef-4963-d0e9-08db9e8029da
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989E9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4169

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
 drivers/iommu/amd/io_pgtable_v2.c | 20 ++-------
 drivers/iommu/amd/iommu.c         | 75 ++++++++++++++++++-------------
 3 files changed, 53 insertions(+), 50 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index 639d82295797..92fba9bda3d2 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -55,15 +55,17 @@ int amd_iommu_pc_set_reg(struct amd_iommu *iommu, u8 bank, u8 cntr,
 int amd_iommu_pdev_enable_cap_pri(struct pci_dev *pdev);
 void amd_iommu_pdev_disable_cap_pri(struct pci_dev *pdev);
 
+/* GCR3 setup */
+int amd_iommu_set_gcr3(struct iommu_dev_data *dev_data,
+		       u32 pasid, unsigned long gcr3);
+int amd_iommu_clear_gcr3(struct iommu_dev_data *dev_data, u32 pasid);
+
 int amd_iommu_flush_page(struct protection_domain *domain, u32 pasid, u64 address);
 void amd_iommu_update_and_flush_device_table(struct protection_domain *domain);
 void amd_iommu_domain_update(struct protection_domain *domain);
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
index ca092b128402..b54d4a0e2f4c 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -77,6 +77,11 @@ struct kmem_cache *amd_iommu_irq_cache;
 
 static void detach_device(struct device *dev);
 
+static int __set_gcr3(struct iommu_dev_data *dev_data,
+		       u32 pasid, unsigned long gcr3);
+
+static int __clear_gcr3(struct iommu_dev_data *dev_data, u32 pasid);
+
 /****************************************************************************
  *
  * Helper functions
@@ -2651,61 +2656,71 @@ static u64 *__get_gcr3_pte(u64 *root, int level, u32 pasid, bool alloc)
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
 
-- 
2.31.1

