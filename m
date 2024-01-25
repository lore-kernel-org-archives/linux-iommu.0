Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2081.outbound.protection.outlook.com [40.107.243.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B2FE4502F
	for <iommu@lists.linux.dev>; Thu, 25 Jan 2024 12:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706185015; cv=fail; b=JyX/ezweEBfps5jGg4zRBLW3sL3SNRZzGRzGoVG6bXe8ZkgxusB7HOgulwPuAPwrJcXpu6OuJoDpWM3zt7UxpJaaENCfbY4N+LLtgTemkVuNNAgmqUz/Kpurb5foztx4gCN3ZqajpwaHGsOw8nu3pusrXJyGhN2VcR0mk49k3C0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706185015; c=relaxed/simple;
	bh=E0i5wpnvk59IDhNyvabPdzrMGJqyYUVrE/hXjcnjtf8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UdJEtXDC2/tpHyfygG/dqPSzU/mYTaiVSRZGMyH3MumGPjj5IPvVUutVL1Rh15ZCmIPx1XCp0D+73lBOO68ejll7vqP9C9lNnSuCS5mb1Pl9b7U4a9VLXpFadhp5XdNjVdvoxmeY4IGH6uS9G16RxyB+aEsWocGBWmvQNcBDo4Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=WWILZJdq; arc=fail smtp.client-ip=40.107.243.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="WWILZJdq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U9BRj4gPQXMRb71BZ679w9k2C0rPb8xTiV+pQyzx2qTbe2OtR8kYCaN+OCWnAoUqA20OUiutsbiwIYnnJ6T23orRNFc2LtGj6jf5AN7bBPJT6TO8gC7X06gzGaN0QCj4KXQFBhExDogeFiBSl7hYSfiw1ZTk8rZ+nPyeOiX9aRNSBeJn8r1vd7WGNm1b3rpVpdDvWBEqW9yR9N/LcWEQT9i2d7gFu2Szv3flIKF4cXjVNO6atdOtTjxow0UwAVHAgO7ITtO2sw09Jy9scC4M7zuW+W+s5w6gv7MH/yWtQsnpELDe+V+1AF7IJ/RtQCz9HHIM9YU78PLAoRPW9gaApw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JxlnjuGpZdvF4OTwLEaVqO6XbKO/nMqzXXMYjlp+zic=;
 b=EsWbm3TgkOAYhXENBoXuYc1L3tS6ky60bd/LU+utvSh+xA0v5EOzvVpb0yxzaZI3XwIV+qalhqv5LlWMcsHtG1h5leFFFS3dl2GicPCP+lqZQceI9B1kNduC1+1FqHppC9KTzJydpmH3SCtwNQbmYyfZ6xJgTNtmPJ2h+oBzdvEVaGMee1z+6bmvBD6JhxnE98CYXwoe9bM+k4UHFPeyzg3If3w7flD9frh7UJCsd+pmYiaIOMWjh1+ARF5o/fz/+T0ReTYy0wpAAeyVwwug8j6DYGdCn34LvWMcDApw1e5wsnxw2jnk5FYxwykw/h79YDfZ6t6Uz6DP4E9JcTZd1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JxlnjuGpZdvF4OTwLEaVqO6XbKO/nMqzXXMYjlp+zic=;
 b=WWILZJdq3kv5AjQ82tIx/gjGsZggvn9oR9Y8zMF0dViBlB21ZaCZuBvBGVHuJDyYNVvSzlttlRWoXxraIQMCdjMS3wQz6r7ktGB82DdjI+Ca6qjnnaVIQIHl2j4heG6jrsK8oPJGuOkKtzsPis/AXEyyM/BxklujMLO2BOfPl8g=
Received: from BY5PR13CA0002.namprd13.prod.outlook.com (2603:10b6:a03:180::15)
 by SN7PR12MB7299.namprd12.prod.outlook.com (2603:10b6:806:2af::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Thu, 25 Jan
 2024 12:16:50 +0000
Received: from SJ5PEPF000001CD.namprd05.prod.outlook.com
 (2603:10b6:a03:180:cafe::da) by BY5PR13CA0002.outlook.office365.com
 (2603:10b6:a03:180::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.21 via Frontend
 Transport; Thu, 25 Jan 2024 12:16:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001CD.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.16 via Frontend Transport; Thu, 25 Jan 2024 12:16:44 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 25 Jan
 2024 06:16:41 -0600
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v6 10/17] iommu/amd: Refactor helper function for setting / clearing GCR3
Date: Thu, 25 Jan 2024 12:11:28 +0000
Message-ID: <20240125121135.8217-11-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240125121135.8217-1-vasant.hegde@amd.com>
References: <20240125121135.8217-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CD:EE_|SN7PR12MB7299:EE_
X-MS-Office365-Filtering-Correlation-Id: e7d99b1b-debc-4f03-1188-08dc1d9f7f28
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	JE8fpY9frq2LMO2IUx7SimkIJ5jss8+U8Ajz2/2WnoTLsvPmEoLILo2HJ48+LW7Aa2Ah7M18/n67tjXkd+yE9wxVaNojvaMjcJPvwF5NUFiw2MZj46OTYyonu1AEdIAGz+hu/b+N6PiXIY4w11oCXBm7I3Eo6TqfOKdnQlf8IvzkjrMM6q0dqjXScbi5BoCWevReTcGTUuo9FXTrT0HEhhBCv3gTidAKiFQAYDAWRaGbhA/y4taHKTse5OpVPxxqf2S9fiKvpPjUESD6VbUlcHbO9N3r4/eLZmndFTpfhk5Qm2UitlFy9Ol1mFrs6VwQMpSUCbNDT3MZqpeDsCynOjyGtvI06uqDVq6juPwgFh8ols4GsZ6CkXkxWcgp2Ggk8+LbYuH97RjMheG4KRVDV+cs94q9y1N7UVzN3LrWAQs/yI3MDcb6tnB/FsEFUAjxumco6QFqRWzGRhCPQCPqV5aCfOdeUyrA3n1JhpiUKER1+Y/uKhyc6+pxn7mRtwLDmGC0bRn3cPIci+oDNqFOhvocZ48wopApuHboz0H/gEwyrZNO/IV/Gnc17tn13c+jlReP4cY84NpmmVE3zP+4ph4d3wTzbnPc2uepNf6o+bjYBPUMkZYTOwT8wDtoS/2k8oTPtLtG9d8MWL9kcTp4HASS5gzxnB7y4FT/u8BcvPkDKtRSXEVHRSguTWu+Mxt2p3afzq1tApb9GHpEb1HpLeZu8v3S7dk0CjcWBOwX69/Zf56rN03FOLFJlqN570aD1axqcbIDO2GJUIY3iZi8rw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(396003)(346002)(136003)(376002)(230922051799003)(186009)(64100799003)(451199024)(82310400011)(1800799012)(36840700001)(46966006)(40470700004)(2616005)(16526019)(26005)(1076003)(7696005)(83380400001)(426003)(336012)(4326008)(8676002)(8936002)(44832011)(6666004)(70206006)(316002)(70586007)(478600001)(54906003)(110136005)(86362001)(36860700001)(356005)(81166007)(82740400003)(47076005)(41300700001)(40460700003)(40480700001)(5660300002)(2906002)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2024 12:16:44.4324
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e7d99b1b-debc-4f03-1188-08dc1d9f7f28
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001CD.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7299

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
index 5367346250ce..c1bd152df9e7 100644
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
 
@@ -1750,6 +1753,54 @@ static u64 *__get_gcr3_pte(u64 *root, int level, u32 pasid, bool alloc)
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
@@ -2774,66 +2825,6 @@ int amd_iommu_flush_tlb(struct iommu_domain *dom, u32 pasid)
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

