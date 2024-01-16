Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2068.outbound.protection.outlook.com [40.107.220.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8343E1C6A1
	for <iommu@lists.linux.dev>; Tue, 16 Jan 2024 16:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Zven0cKj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M9a7HDZYEmM0kQu/ioZ6KRbpJdewUbKqJA4O6gXwVAqD1YtxHxegB/WGmQIZo1u2JSFq7wYoO38oD06oDHYwtN/N6KTXovC0guCUO06IHh028aNoOMiVq4q63m1SHv826gsKrieedgzFopZzhyZfZI/PNOFxrLLOeHwpCXXlaRqxAiMl3QCm5gZh8QQCjmXahfxgMBdslaNbh8u1yL4jQ5SJMyo29GxC7HJqHpf6TCd0mAK2kz0LHOQHGlX7y6kkTrlI5iOkKaLbI+9oRuh0cISCE+mxki0QAXMaEDK/0ElVp334yphy83ajs9LCU6yq7pmcwFJwt4Es+cQuOslF7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X/m8U6t/NAeMxf0ymwgtpD5yc1F6W+SNBDfWRlfYUCY=;
 b=jpuSvbUSZYZ+8/mCQyqutV1uOxPCRStHEc0B2jy3KUyOApfL/Hk0jOoGStQeF1lw2chpyRnTycGQQ+kmN26v3YDY6OybRhyNHV7YOAkD4kQu5GsZ8ekdUiEAapBk6PEQPa8KXSYFOwZfagGs1hwVbYk5prGWxmqFi7B1E77YAzkcsUihDK18/iP+oUSU2Ax3ecEzixR954LOPk85U4cnZaaRsPdturRcdvwvRmNKrYrS+QU+ETJ27eU9KLOOQss9oQaX2UuZzubFWUnINlOHj/bIjAy5rl9AH6ypV7q+VoYuQXgVtBopGApYu8j+sawiH/FT1J8XEW1Uigwr8IbM8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X/m8U6t/NAeMxf0ymwgtpD5yc1F6W+SNBDfWRlfYUCY=;
 b=Zven0cKjBA/yvhqko82q/DVRTJtWhoMfARA+mXlS5d7dD/S3xg7NpnIQxZJvQpDRO0k1roJBsoUPXgvGYrAT+LMH3n+h1cCknp2TTApFCIISYGgdUEiMUOBheqd643EaPP2yzAfLFlbjpLo7EDAfsKCSqNeigEDSSEEaabZtZVU=
Received: from BYAPR01CA0016.prod.exchangelabs.com (2603:10b6:a02:80::29) by
 IA1PR12MB6139.namprd12.prod.outlook.com (2603:10b6:208:3e9::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.30; Tue, 16 Jan
 2024 16:56:52 +0000
Received: from CO1PEPF000042AD.namprd03.prod.outlook.com
 (2603:10b6:a02:80:cafe::31) by BYAPR01CA0016.outlook.office365.com
 (2603:10b6:a02:80::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.30 via Frontend
 Transport; Tue, 16 Jan 2024 16:56:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042AD.mail.protection.outlook.com (10.167.243.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.16 via Frontend Transport; Tue, 16 Jan 2024 16:56:51 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 16 Jan
 2024 10:56:48 -0600
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v5 11/17] iommu/amd: Refactor helper function for setting / clearing GCR3
Date: Tue, 16 Jan 2024 16:53:29 +0000
Message-ID: <20240116165335.6043-12-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240116165335.6043-1-vasant.hegde@amd.com>
References: <20240116165335.6043-1-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AD:EE_|IA1PR12MB6139:EE_
X-MS-Office365-Filtering-Correlation-Id: ac002afc-066c-44ad-3aa5-08dc16b422f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	WPRRNcSsQPJSZmxUVx7HeGG0potJc/gcxoVUEPtjpzesGCjfta3WOnS6tBP8WO4VBEzdNPlNncZ31QNXv0fn/tFPKvkNIW3xTqpxlzejcUPSBRHm9IJUyUC+sMG+gjp5eMxx7no+l62EVytLvrMzS2dcBntm3S9I3hxXxwU2Zenf1MggiOJ6NO7PcZsB9+U1NGLtM+/Nw6A6GreJ7SZEZXTMatmBZuOKMyI6pP/uU2Cl4HinAs8uIdSYIk+k252k5Blln8Uvk7YqbMC6j1DO1TguJAkp8PB1pzeiy0C1tfa4cqf2jvKFW7HpNXj9sWOx35GyF0KRamfx0YQOSHxvxpCfi2MF5nVDEB57521qiGFFVHX9ufEpJtDut+c9CifwybNVmkS20gvhfBg0DLewz5vhlRbtbYBAiIEtfAQOm3rGSpZuMhuHbOsJnV2QAE9D/VualMqzggy0rucUrDJuxSpfH9wj+MWClvbTsvoMAJJVhUcvPV7F2obUNBj2lKuZKtVHmVu3nMoizguSVcL+HxKJ8HWkXCLkMk3cWxL1lMMQGh01A0yihmLXxCycGaP3Sk5ZQcPxj9O8/oaivJMslWufNyBk/KJOCBQo6s3Pa2ltkIH0lgLKDNVZZ5AIQ0Im25+GpJrs3P6A8PeF7V6UJFUPxIZJwGjymw+25G01O2EPmBsR+TJ2+JxpVXIo3aJBmzqzgj5SjA0xNUFXapd5hE7/8yBm69YeCVUROYB58O1YrduINrMebFF2l4ZT7z5SsussCyUu34c8hAegI7IItw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(136003)(346002)(376002)(396003)(230922051799003)(451199024)(1800799012)(64100799003)(82310400011)(186009)(40470700004)(36840700001)(46966006)(5660300002)(6666004)(2906002)(70586007)(70206006)(54906003)(7696005)(8676002)(8936002)(4326008)(316002)(44832011)(40480700001)(40460700003)(110136005)(478600001)(41300700001)(36860700001)(47076005)(83380400001)(81166007)(82740400003)(356005)(336012)(16526019)(26005)(426003)(1076003)(2616005)(36756003)(86362001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2024 16:56:51.4520
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ac002afc-066c-44ad-3aa5-08dc16b422f1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000042AD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6139

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
---
 drivers/iommu/amd/amd_iommu.h     |   8 ++-
 drivers/iommu/amd/io_pgtable_v2.c |  21 +-----
 drivers/iommu/amd/iommu.c         | 113 ++++++++++++++----------------
 3 files changed, 59 insertions(+), 83 deletions(-)

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
index 22092e741121..c9cf5fd03d0d 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -1758,10 +1758,13 @@ static int setup_gcr3_table(struct protection_domain *domain, int pasids)
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
 
@@ -1790,6 +1793,54 @@ static u64 *__get_gcr3_pte(u64 *root, int level, u32 pasid, bool alloc)
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
+	if (!ret)
+		gcr3_info->pasid_cnt++;
+
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
+	if (!ret)
+		gcr3_info->pasid_cnt--;
+
+	return ret;
+}
+
 static void set_dte_entry(struct amd_iommu *iommu,
 			  struct iommu_dev_data *dev_data)
 {
@@ -2828,66 +2879,6 @@ int amd_iommu_flush_tlb(struct iommu_domain *dom, u32 pasid)
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

