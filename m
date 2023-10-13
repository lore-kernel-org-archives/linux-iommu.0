Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2069.outbound.protection.outlook.com [40.107.92.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3559A11CBC
	for <iommu@lists.linux.dev>; Fri, 13 Oct 2023 15:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="0fsk4pVC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XoReYGLYUiFh0ItME8cJOLGg30H/Mg+ZLrw3MQdM4EJUGgAhDlp1IzR/x76hAyvG0QRtrK1MaWXtVOgwQou87KUeTf2HuFvbmrXsUGGYEKPEgYqFh7/3bpfj17t34yPdvWINeUZzFl+Rqya+aw+CMPYjb0wQzW3oUX4N4isztDyxI8l+Hyhv18IwE6e8IlU1F0mSpu9GKZhlE0u1vsUnoXA5DAEggX0y6m678D/RFIsVVzK+ZkCmQqNNVAK3j21w5JDGH0+Qpk7puNwe1hVFi1m4bXMWsc1pFeZBWakInkTcqKRvmRTl/g3oOqbmi97WncVNh30P7ztaoQzHqeDetQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RW9c3sU8MS3YKJdopAdSV7m5J6c8P7DTb/qB7fN4IiA=;
 b=X+mBWyqR3VzO6tDhxCxDOWCuAF3vboK1hoAJoLIHhDjlPPR5Dx3qfc+dimnfLn/XS+LGg8g4RDQSEKLB0/DUKVJMRGD9e2BCjy44wL6iy2h86BxNXp4AXr5Zo9l/izehE8an+sTMQBMi2DRrBfyjTDo99N7rO939CUOlqfan5RsSCAXjy/mj/uw5SgUWk5zqIvUjd43bugLLewYZzd6+S/2Vd5M2BgxvNefQBhQtbZlyD1dpbzBYmb3nO/N9cxDu8uDGQi7QfzmvXXFGnw1hv0fCPw4cD/I1aXOw/+zqIM8FDEbR0Xx9dsiQoWDkEub9CIvs/in+97UwlGClEne6JA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RW9c3sU8MS3YKJdopAdSV7m5J6c8P7DTb/qB7fN4IiA=;
 b=0fsk4pVCbPiz1t7MVfQTf3zngetmwP9Jwc/o10l3GWEEqt3E6kXfnbCiMiljXG/SeZIbYbt5BAG/zxUbb08Iyj0ZNsF3bTK0/FdMoaLtFGV2G7sFxGhDrpS4wpRMxkr2CJ+ZfKtFcvWoFFsXnkSXiI2MiYjjNVfz2UZGGFnyNpI=
Received: from BL1P221CA0028.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:2c5::18)
 by DS0PR12MB8525.namprd12.prod.outlook.com (2603:10b6:8:159::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.45; Fri, 13 Oct
 2023 15:20:31 +0000
Received: from BL02EPF0001A0FF.namprd03.prod.outlook.com
 (2603:10b6:208:2c5:cafe::d5) by BL1P221CA0028.outlook.office365.com
 (2603:10b6:208:2c5::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.30 via Frontend
 Transport; Fri, 13 Oct 2023 15:20:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A0FF.mail.protection.outlook.com (10.167.242.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Fri, 13 Oct 2023 15:20:31 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 13 Oct
 2023 10:20:26 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v3 09/13] iommu/amd: Refactor helper function for setting / clearing GCR3
Date: Fri, 13 Oct 2023 15:16:48 +0000
Message-ID: <20231013151652.6008-10-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231013151652.6008-1-vasant.hegde@amd.com>
References: <20231013151652.6008-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FF:EE_|DS0PR12MB8525:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d0f5155-fa00-4c2a-4a39-08dbcbfff097
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	fWxSl7n2WmHTjLYRgf8ABOZgWuI9DzHuX8nigzZsraqkdv+2VW6vQXmueb+xoSbFe/k5WCumMjN2EB0zatR05erx7WdApbL1jNFejnxQ1byXhnrfdbJNIRuUEeaP9I9QtYy4zsw0j4WFO/JHEyCrl0/bROhT3wPpvs0WfZ2J7i8yKUUPCPVjDtk8Od2kbF4m/66EzvbTO6mYGgm+v+PDgyFnrkIzS8cHMOiaw72D4mckWv3wIH1bYR5GVZUCU/EUCZNv1Xj3GGws1NtmjmOChLSGLMwSBdV1jz5gF3vqfpSYM7CbdmOzZwTx/BViJXlp80qnd4dVxtxRn+4yUXTLt4FOSQgMSwy2gm/rdH4JMjrmOVKefKfmbU4w5PWFQbkUU29efB7qdOuHWvHT8ddsjRSHi520t1K8Hjq+0LTcZFs5C9sID11FXlaThtrAH1VadKfkimcP1W+hN3QqX7KnnxusYR6z6v/uUXJkC1OCmWyP6XiYlq1SJ7vtiglwhBGtm7jIuhvqD2fZyTld7fCIiNlU8DDstnVDNeubayenNXxGLqgqZhYruhknzXqYgmnWUDnjwM0YpJNg9a2Cr6xqwYFzJqymz3C5qOBp1HQvElwa8PrW/QLTEkXdP2tSCoqPhGKqmFd4+SMfVDnxj+GAbhQc5oBk1aaD+4lG5noqog4Sq9zgvaSiBKAX8+vING3O0SWfBtJ22Iv6Sr2mXo4YxdJstae8qNvyyzBBYYYXOnXHxeUoeqRui0zfyE7+2N1wFgNlttxJQvqS2L0+r4uzkg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(396003)(346002)(39860400002)(376002)(230922051799003)(1800799009)(82310400011)(64100799003)(451199024)(186009)(36840700001)(46966006)(40470700004)(40480700001)(16526019)(26005)(2616005)(336012)(40460700003)(426003)(81166007)(356005)(82740400003)(1076003)(478600001)(5660300002)(44832011)(8676002)(4326008)(8936002)(2906002)(70206006)(316002)(54906003)(36756003)(41300700001)(70586007)(6666004)(86362001)(110136005)(7696005)(47076005)(36860700001)(83380400001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2023 15:20:31.5978
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d0f5155-fa00-4c2a-4a39-08dbcbfff097
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0FF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8525

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

  * Consolidate GCR3 table related code in one place so that its easy
    to maintain.

  * Rename functions to reflect its usage.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Co-developed-by: Vasant Hegde <vasant.hegde@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/amd_iommu.h     |   9 +-
 drivers/iommu/amd/io_pgtable_v2.c |  21 +----
 drivers/iommu/amd/iommu.c         | 133 ++++++++++++++++--------------
 3 files changed, 77 insertions(+), 86 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index 1f8dde87a287..1fceaf4a8229 100644
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
 /* TLB flush */
 /*
  * This function flushes all internal caches of
@@ -68,10 +73,6 @@ void amd_iommu_dev_flush_pasid_pages(struct iommu_dev_data *dev_data,
 void amd_iommu_dev_flush_pasid_all(struct iommu_dev_data *dev_data,
 				   ioasid_t pasid);
 
-int amd_iommu_domain_set_gcr3(struct iommu_domain *dom, u32 pasid,
-			      unsigned long cr3);
-int amd_iommu_domain_clear_gcr3(struct iommu_domain *dom, u32 pasid);
-
 #ifdef CONFIG_IRQ_REMAP
 int amd_iommu_create_irq_domain(struct amd_iommu *iommu);
 #else
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
index 27486b905b6b..1ef6cbf71926 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -1849,10 +1849,13 @@ static int setup_gcr3_table(struct protection_domain *domain, int pasids)
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
 
@@ -1881,6 +1884,72 @@ static u64 *__get_gcr3_pte(u64 *root, int level, u32 pasid, bool alloc)
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
@@ -2664,68 +2733,6 @@ const struct iommu_ops amd_iommu_ops = {
 	}
 };
 
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
-	domain_flush_pages(domain, pasid, 0, CMD_INV_IOMMU_ALL_PAGES_ADDRESS);
-	return 0;
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
-	domain_flush_pages(domain, pasid, 0, CMD_INV_IOMMU_ALL_PAGES_ADDRESS);
-	return 0;
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
 #ifdef CONFIG_IRQ_REMAP
 
 /*****************************************************************************
-- 
2.31.1

