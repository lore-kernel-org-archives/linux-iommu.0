Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2045.outbound.protection.outlook.com [40.107.220.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61CE11B81D
	for <iommu@lists.linux.dev>; Tue, 16 Jan 2024 16:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="RS0OFGQy"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sueu/hY1XyPrTJusUZxtqjdLECX3GyBTHL2rJ5r8ij+vSivxVS+oIMf8WV4oqaGjZc1sEZqTgzymS5Kr+ZH6CTGSp9oOBiVyl/Z5ceQMIjGScEMlbX9ZkKp6NTnaBVHJzBDm+tJqoD+xRuj8MZETJvdPtG7VO5WuQKms8+sZNnYr4vw6NZ6N2npJeHHQco0YmORHjXPWW+h270lnm/deDL4CaB/IX9EkXFLdCUIrcAlq/Ych3WV7vkNRQ87179U9k0gF4V2690eCz4WkedEyvfMZQPcS2nOgVvF5OE/fv1+Jqd6OodQ2FBWE1Emx3lTzYzKGtecgTq/ab5SpXXfELg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qWchD7vXCkca/6E4AOBleMPRF2+HSkk+gY1da2vPWwE=;
 b=Zx4wntfSmaKi+KBKa+qRDTpMWc1g1YyYpPFIwK2jz14aNNmHC3Xwd++qh/V8ZviwO4Oosze3Zdhl0Np2QM3ymaomN4SLKbkASkRYS2YqrL33P42GiBk2q7dwcABNlcEsK8GXEOLi/hcHkZ5AXoCJ7RBEklO8+J49nha4E5AraI9/+X/iRL5d/inNh0IQQt8pzPOW8tT98k+KTJZfKhi2Q5F0IAKWsWyWoMefLqnVN+fcsXTvmvq2fZN2X8coYBDUZfJizj3MyP7cu5/KpdAumidghs9MxhuyAzMSATec+zmHhTllV8PvzJFQGOgxo8brayIdkNZlv1+m3HbDj25RaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qWchD7vXCkca/6E4AOBleMPRF2+HSkk+gY1da2vPWwE=;
 b=RS0OFGQyb7DE7Tn9VfJABrDL/aAhgRINiWzq74FoEu/v7qTPtKjSd2MLcPkOv/O30P294CT/DA4QVdkw68qLtheOk28qYlT/gThScetApB6DKdVQ18viyoBLsqlw0XHwU9ltJVAaYVJOjIv9rDsGGMtQRsORMfSRQ5VbXKNBVzU=
Received: from SJ0PR03CA0383.namprd03.prod.outlook.com (2603:10b6:a03:3a1::28)
 by CO6PR12MB5426.namprd12.prod.outlook.com (2603:10b6:5:35d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.29; Tue, 16 Jan
 2024 16:54:46 +0000
Received: from CO1PEPF000042A8.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1:cafe::ce) by SJ0PR03CA0383.outlook.office365.com
 (2603:10b6:a03:3a1::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.23 via Frontend
 Transport; Tue, 16 Jan 2024 16:54:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042A8.mail.protection.outlook.com (10.167.243.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.16 via Frontend Transport; Tue, 16 Jan 2024 16:54:45 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 16 Jan
 2024 10:54:42 -0600
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v5 03/17] iommu/amd: Introduce get_amd_iommu_from_dev()
Date: Tue, 16 Jan 2024 16:53:21 +0000
Message-ID: <20240116165335.6043-4-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000042A8:EE_|CO6PR12MB5426:EE_
X-MS-Office365-Filtering-Correlation-Id: 575e02a8-5102-4f1a-8369-08dc16b3d7e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	/0FHpXmujjuI1lEI8LDNjRaSJ1piLdLYdpoic9LeaLJmBZddi56/KZ2YCrFLIAx0ppnOzYXHcGeW9OHQO2I9fEI3RRpRGBr64rDIrX9x6uowt8z9+j7ezwHgBdDnVfhY8eQ0wFnzLzSWq0bGKvM6Lyk3Q2T35fNX7FWPrg08oa03uRZPl+teeYQDthDcQK8tgaV3kJDuVc1oPVn6KwUcpXGnquQeVrh5Pj8tVXkeav/2+tZ6GyrhkbY6PxzwEwy5sx2YbNZSBZcho+6YNg0MtvVoaW1ARJFYhIn/WzZ2l4a6f/i2osaa4l1icRm/kLuvcy6he2CIkyd2C+acqg85ZrK4QFemBFfVTdv64xSRUIE9by9q8LKRIKvGu+3pI97z8hK5B7WDN0DsDcltcewabSiFrfdo8n/qdYIveBs3669jCMSFgDug1cP+H9x6RSvWUvhaxHhi0owO/2dDiCNwDM8La4oiismkmL0VBXaWJqyIP7CthZwaBbJkzdcc5UoycbyUIO6SxO9bFdl5jPrEge9aOBgabYHrf/916D32W5VgxrCogxWmAyVIkkKuGLo2nzB4JwhqRKgtfnMtams1rPwOcPtauR0qkhvUssJ4kHanD9oK1Sieosn6wJZ2U848KRoknlQsQTfR6uThsXjzgLyF9u+TyxIWneA4YSYPoISBXkplMmrgb2LUHcC7TC/MfWJ/Tjvf8bsrA0SIwz7AL9MhGB1AB5oRfHPCZKQo9gCKg7IAsNtf/B9ruJAyJbtceL+vLwva0Lw1xY4cKltM1A==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(346002)(136003)(376002)(396003)(230922051799003)(1800799012)(82310400011)(64100799003)(451199024)(186009)(46966006)(40470700004)(36840700001)(4326008)(8676002)(5660300002)(8936002)(54906003)(316002)(2906002)(70206006)(16526019)(26005)(426003)(336012)(1076003)(2616005)(81166007)(356005)(36756003)(86362001)(44832011)(70586007)(110136005)(7696005)(6666004)(478600001)(40480700001)(40460700003)(41300700001)(82740400003)(47076005)(83380400001)(36860700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2024 16:54:45.5042
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 575e02a8-5102-4f1a-8369-08dc16b3d7e1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000042A8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5426

From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>

Introduce get_amd_iommu_from_dev() and get_amd_iommu_from_dev_data().
And replace rlookup_amd_iommu() with the new helper function where
applicable to avoid unnecessary loop to look up struct amd_iommu from
struct device.

Suggested-by: Jason Gunthorpe <jgg@ziepe.ca>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
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
index 77612142f436..eefd399c5086 100644
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
index 2f765ae06021..7f6342bc71c3 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -675,6 +675,22 @@ static inline struct iommu_device *dev_to_iommu_device(struct device *dev)
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

