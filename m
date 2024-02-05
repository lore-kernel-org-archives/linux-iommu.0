Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2057.outbound.protection.outlook.com [40.107.243.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31325199B9
	for <iommu@lists.linux.dev>; Mon,  5 Feb 2024 11:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707134286; cv=fail; b=ciuk4F61c3AqiMiS4c30CXaMJKjH5DXpvHYVtYvUzlBnpynLpF4DWD/m1r/fqE3tWiMh6zrmxs+bPN+NbXxd3W6bcP7Xol9On//AgI9NmSBtKLjky1AKiZnyivTV2GH5vtkHbQGFE1UgKHBqoIO5h32kEne0oQHMOxxf4Unt/8U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707134286; c=relaxed/simple;
	bh=vCL5Rsrqs4GizAxiq0clPEOUzVRiV2YKA1VYfmJMHQs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J5SYQLxOEZytCY3FVd13u+MKa0mkfuitDp3koF7/V1NMAU1Pr5V93J/bfXHu1Z4rkiItaaJFaOgYYGsxS9EFV6VDlgZhxp/kmqQxITejN9ECvLCWQ6W9yj1tJ6A9EddCXmt5zRWBFT2PIKEip5r5c0vGHw4XGNysWJ1stqRMpnM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=GKBl5a7t; arc=fail smtp.client-ip=40.107.243.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="GKBl5a7t"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=McGTLpZtjv/pxNpAqqgzV/ealcu7BGrXEoj1f+9o82W4Zq+GjyFpLuI+PXloYWxzqpLbtp94shcCcRAuPeYfBn8gNwE1iJbpXjuZG1vsAGDRws4OAChy+yls/3sPS3Zk745VJ+ho6XR6rQS4tiXjNdUfR5c3xNCDBM88cINEkEgzc4fuWMmld65U4sEmzaRSkv8oMA7M6ic8Fe5hedel+rT5g6J9fTY1KkuEdUAMKcNIZwO7UO/3+ZoOf5rQIy0+mVenLBDBG4MPK2jyGyJg/O3Z7p5tbfGjSzYf6VSKmILfHc/6QRyhkoeBR2aUbQd6XDfcJRnOwkeRaM3GNFg4Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/+NsjC0V2Y3ztxLIv59LKqjZBMDGKVFS1dz8KH+ZOTI=;
 b=EoLuK47mRqUT0X8rkfyVv5XWuxUHEDM5v1vsfxOq1BnvAFYBCG5AX9Yi4iYrQzZMCw/eopW0gQPTMcYxar4snQxt7ixt+M9LYdncNTQj83fYKg4zhdgL02R0JLFCQQus/qbOuDc6ItQ918VPPtEF83DZiYOxKZsGkYvobt9hyYfqkbjGAMNESW2Bi0LQ4eSCXmi4vF75OYa/sXKdnLJ2ZxP9UAbZW3Q9SiM2AKm0+4nIJFA/92haePAd7k+J/gmL39zUJV7B65/l0OZFlBGXEsy7Fj4ugFNqflYgqlUkui/aBi0nNXnNnXNPokIEDNpnb1P7++HMZyO4XZ+BkiIL9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/+NsjC0V2Y3ztxLIv59LKqjZBMDGKVFS1dz8KH+ZOTI=;
 b=GKBl5a7tGQmxLDwasMyzkG5U9yg8ppsPjFpm6cRTUNuOy8bHz7NOeeqxM1pfk/2cpMPYOA25yyTGq1CMtaiKuRks4LYEDWzfD1YbhlvYyzKmwH1Jy/vk2e2l+26hrz/K/1apPjdXh7UAKi3WkL5u6W2Fo0ogrwo+172TVQY43hk=
Received: from DS0PR17CA0006.namprd17.prod.outlook.com (2603:10b6:8:191::22)
 by SJ1PR12MB6099.namprd12.prod.outlook.com (2603:10b6:a03:45e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.15; Mon, 5 Feb
 2024 11:58:01 +0000
Received: from CY4PEPF0000EE32.namprd05.prod.outlook.com
 (2603:10b6:8:191:cafe::20) by DS0PR17CA0006.outlook.office365.com
 (2603:10b6:8:191::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36 via Frontend
 Transport; Mon, 5 Feb 2024 11:58:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE32.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Mon, 5 Feb 2024 11:58:01 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 5 Feb
 2024 05:57:58 -0600
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v7 03/17] iommu/amd: Introduce get_amd_iommu_from_dev()
Date: Mon, 5 Feb 2024 11:56:01 +0000
Message-ID: <20240205115615.6053-4-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE32:EE_|SJ1PR12MB6099:EE_
X-MS-Office365-Filtering-Correlation-Id: dcc817d3-7f42-40cb-817c-08dc2641b41e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	AHaRGQD+7KGkyJtjo0nEwLBbCBoJOtGnWj9REYX/d3asxPMQ3wHTU6NNjxyAvk1J7fUvJY1rrTcU6ioNAkAeRwnbWHV0Tddn/VEi/U8piyXcPIcRvNco+hvLyh8wlBIlFClAlOXxMkl2nxe6P/A2euRZgIAemE2hPRmwPymA7BeebsvPsJZhfbwyPaENasxS8mxrShs+ufMJhwsxsdaDRwEw3c8tgrWW3osjgMgN4rX6lZYh+lngOmYPFoF0vzmPjlSN0CeB47gzXLFHJGUENcwoXPLQ4XScLw9TIlX7RHOPsh0mFUKcGNgxZbaZa5ecybuia+4H8YKbqtx3e42l+aOuFWWvG/nfL5KSFK3vjEtwWXCel7yUn7+jZOCLrIYentS3QbFhMDBJvbQbtk9xk5+lkHoZ5LMgBUbJMMlLEBhrQT8RyE/piiW6co4Y1Km5nL7Dob+2A1vU/wl4Apd1WQvKZAnnO2/KYHct9+zgNBhtmWmOuTE5oqOr6xJvDEbvAx2e1cC+KbMqiuUWAhhNKlO99w73AGhLFSL9TgJvH2wrKBrPr5cK5C9cHgAUlRiiPnFJcqqOXWpFqGkVZ7oSBBIOPd9BhaULbrwktW9RoRs8Kpd+GbJIveF60EX3tQldak6cEQE1QkKwuP0R25nmhlFoysErF+yI1y61b9qfe9WHCQ3tOCzEJ3S46ERo3RXgYuLzcBQVqFclZ2SyzMYodZZRG8JSpb/ppBrCgL3PBaMDFAL17MdQC29tFvSRFaPD/hRuT7B9pCwI+b/0WOk8xw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(376002)(39860400002)(396003)(346002)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(82310400011)(40470700004)(46966006)(36840700001)(41300700001)(47076005)(26005)(7696005)(426003)(6666004)(1076003)(70206006)(4326008)(8936002)(44832011)(5660300002)(8676002)(2906002)(86362001)(70586007)(478600001)(16526019)(54906003)(316002)(110136005)(82740400003)(83380400001)(81166007)(356005)(336012)(2616005)(36860700001)(36756003)(40460700003)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2024 11:58:01.4833
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dcc817d3-7f42-40cb-817c-08dc2641b41e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE32.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6099

From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>

Introduce get_amd_iommu_from_dev() and get_amd_iommu_from_dev_data().
And replace rlookup_amd_iommu() with the new helper function where
applicable to avoid unnecessary loop to look up struct amd_iommu from
struct device.

Suggested-by: Jason Gunthorpe <jgg@ziepe.ca>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/amd/amd_iommu.h | 15 ++++++++++
 drivers/iommu/amd/iommu.c     | 54 +++++++++--------------------------
 include/linux/iommu.h         | 16 +++++++++++
 3 files changed, 44 insertions(+), 41 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index 8b3601f285fd..31275bc6e9e4 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -150,6 +150,21 @@ static inline void *alloc_pgtable_page(int nid, gfp_t gfp)
 	return page ? page_address(page) : NULL;
 }
 
+/*
+ * This must be called after device probe completes. During probe
+ * use rlookup_amd_iommu() get the iommu.
+ */
+static inline struct amd_iommu *get_amd_iommu_from_dev(struct device *dev)
+{
+	return iommu_get_iommu_dev(dev, struct amd_iommu, iommu);
+}
+
+/* This must be called after device probe completes. */
+static inline struct amd_iommu *get_amd_iommu_from_dev_data(struct iommu_dev_data *dev_data)
+{
+	return iommu_get_iommu_dev(dev_data->dev, struct amd_iommu, iommu);
+}
+
 bool translation_pre_enabled(struct amd_iommu *iommu);
 bool amd_iommu_is_attach_deferred(struct device *dev);
 int __init add_special_device(u8 type, u8 id, u32 *devid, bool cmd_line);
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 5edde7fa3c63..b82650a01060 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -1388,14 +1388,9 @@ void amd_iommu_flush_all_caches(struct amd_iommu *iommu)
 static int device_flush_iotlb(struct iommu_dev_data *dev_data, u64 address,
 			      size_t size, ioasid_t pasid, bool gn)
 {
-	struct amd_iommu *iommu;
+	struct amd_iommu *iommu = get_amd_iommu_from_dev_data(dev_data);
 	struct iommu_cmd cmd;
-	int qdep;
-
-	qdep     = dev_data->ats_qdep;
-	iommu    = rlookup_amd_iommu(dev_data->dev);
-	if (!iommu)
-		return -EINVAL;
+	int qdep = dev_data->ats_qdep;
 
 	build_inv_iotlb_pages(&cmd, dev_data->devid, qdep, address,
 			      size, pasid, gn);
@@ -1415,16 +1410,12 @@ static int device_flush_dte_alias(struct pci_dev *pdev, u16 alias, void *data)
  */
 static int device_flush_dte(struct iommu_dev_data *dev_data)
 {
-	struct amd_iommu *iommu;
+	struct amd_iommu *iommu = get_amd_iommu_from_dev_data(dev_data);
 	struct pci_dev *pdev = NULL;
 	struct amd_iommu_pci_seg *pci_seg;
 	u16 alias;
 	int ret;
 
-	iommu = rlookup_amd_iommu(dev_data->dev);
-	if (!iommu)
-		return -EINVAL;
-
 	if (dev_is_pci(dev_data->dev))
 		pdev = to_pci_dev(dev_data->dev);
 
@@ -1809,11 +1800,7 @@ static void clear_dte_entry(struct amd_iommu *iommu, u16 devid)
 static void do_attach(struct iommu_dev_data *dev_data,
 		      struct protection_domain *domain)
 {
-	struct amd_iommu *iommu;
-
-	iommu = rlookup_amd_iommu(dev_data->dev);
-	if (!iommu)
-		return;
+	struct amd_iommu *iommu = get_amd_iommu_from_dev_data(dev_data);
 
 	/* Update data structures */
 	dev_data->domain = domain;
@@ -1837,11 +1824,7 @@ static void do_attach(struct iommu_dev_data *dev_data,
 static void do_detach(struct iommu_dev_data *dev_data)
 {
 	struct protection_domain *domain = dev_data->domain;
-	struct amd_iommu *iommu;
-
-	iommu = rlookup_amd_iommu(dev_data->dev);
-	if (!iommu)
-		return;
+	struct amd_iommu *iommu = get_amd_iommu_from_dev_data(dev_data);
 
 	/* Update data structures */
 	dev_data->domain = NULL;
@@ -2008,10 +1991,8 @@ static void update_device_table(struct protection_domain *domain)
 	struct iommu_dev_data *dev_data;
 
 	list_for_each_entry(dev_data, &domain->dev_list, list) {
-		struct amd_iommu *iommu = rlookup_amd_iommu(dev_data->dev);
+		struct amd_iommu *iommu = get_amd_iommu_from_dev_data(dev_data);
 
-		if (!iommu)
-			continue;
 		set_dte_entry(iommu, dev_data);
 		clone_aliases(iommu, dev_data->dev);
 	}
@@ -2192,11 +2173,8 @@ static struct iommu_domain *do_iommu_domain_alloc(unsigned int type,
 	struct protection_domain *domain;
 	struct amd_iommu *iommu = NULL;
 
-	if (dev) {
-		iommu = rlookup_amd_iommu(dev);
-		if (!iommu)
-			return ERR_PTR(-ENODEV);
-	}
+	if (dev)
+		iommu = get_amd_iommu_from_dev(dev);
 
 	/*
 	 * Since DTE[Mode]=0 is prohibited on SNP-enabled system,
@@ -2277,7 +2255,7 @@ static int amd_iommu_attach_device(struct iommu_domain *dom,
 {
 	struct iommu_dev_data *dev_data = dev_iommu_priv_get(dev);
 	struct protection_domain *domain = to_pdomain(dom);
-	struct amd_iommu *iommu = rlookup_amd_iommu(dev);
+	struct amd_iommu *iommu = get_amd_iommu_from_dev(dev);
 	int ret;
 
 	/*
@@ -2416,7 +2394,7 @@ static bool amd_iommu_capable(struct device *dev, enum iommu_cap cap)
 	case IOMMU_CAP_DEFERRED_FLUSH:
 		return true;
 	case IOMMU_CAP_DIRTY_TRACKING: {
-		struct amd_iommu *iommu = rlookup_amd_iommu(dev);
+		struct amd_iommu *iommu = get_amd_iommu_from_dev(dev);
 
 		return amd_iommu_hd_support(iommu);
 	}
@@ -2445,9 +2423,7 @@ static int amd_iommu_set_dirty_tracking(struct iommu_domain *domain,
 	}
 
 	list_for_each_entry(dev_data, &pdomain->dev_list, list) {
-		iommu = rlookup_amd_iommu(dev_data->dev);
-		if (!iommu)
-			continue;
+		iommu = get_amd_iommu_from_dev_data(dev_data);
 
 		dev_table = get_dev_table(iommu);
 		pte_root = dev_table[dev_data->devid].data[0];
@@ -2507,9 +2483,7 @@ static void amd_iommu_get_resv_regions(struct device *dev,
 		return;
 
 	devid = PCI_SBDF_TO_DEVID(sbdf);
-	iommu = rlookup_amd_iommu(dev);
-	if (!iommu)
-		return;
+	iommu = get_amd_iommu_from_dev(dev);
 	pci_seg = iommu->pci_seg;
 
 	list_for_each_entry(entry, &pci_seg->unity_map, list) {
@@ -2843,9 +2817,7 @@ int amd_iommu_complete_ppr(struct pci_dev *pdev, u32 pasid,
 	struct iommu_cmd cmd;
 
 	dev_data = dev_iommu_priv_get(&pdev->dev);
-	iommu    = rlookup_amd_iommu(&pdev->dev);
-	if (!iommu)
-		return -ENODEV;
+	iommu    = get_amd_iommu_from_dev(&pdev->dev);
 
 	build_complete_ppr(&cmd, dev_data->devid, pasid, status,
 			   tag, dev_data->pri_tlp);
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 48196efc9327..6400bd52507b 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -752,6 +752,22 @@ static inline struct iommu_device *dev_to_iommu_device(struct device *dev)
 	return (struct iommu_device *)dev_get_drvdata(dev);
 }
 
+/**
+ * iommu_get_iommu_dev - Get iommu_device for a device
+ * @dev: an end-point device
+ *
+ * Note that this function must be called from the iommu_ops
+ * to retrieve the iommu_device for a device, which the core code
+ * guarentees it will not invoke the op without an attached iommu.
+ */
+static inline struct iommu_device *__iommu_get_iommu_dev(struct device *dev)
+{
+	return dev->iommu->iommu_dev;
+}
+
+#define iommu_get_iommu_dev(dev, type, member) \
+	container_of(__iommu_get_iommu_dev(dev), type, member)
+
 static inline void iommu_iotlb_gather_init(struct iommu_iotlb_gather *gather)
 {
 	*gather = (struct iommu_iotlb_gather) {
-- 
2.31.1

