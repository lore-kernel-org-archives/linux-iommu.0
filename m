Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2062.outbound.protection.outlook.com [40.107.94.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 309941CFA2
	for <iommu@lists.linux.dev>; Mon, 16 Oct 2023 10:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="TC7tcKtd"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jvJXkY9Z/fDAPx0Z54HgNL5XTz9OPshwd5QWe0wBbZJUwV83acJWWZw8pgKsMCZLtChpGrAqQfqKShZZVtLjB6TVLVNda128ESAZmN7bmyUzo9Nk1PtVMoUxZrnurjfua0Jed7cVGc8h5b01PlSO+6qd1MOgvNyiFjO6OzfVxcY8JR1mb9Sg/uLq9xcpo0vpLbBYMunxlPZ7Fi724xrTfHnIUNCiPB97DSNu8JBUORO8v7/UnMHXfp0jTJpwlsSwEfGazVocZRoKhxKUtBXSrFgobYqVF2mDmw78Q/hcoXEc31gOFsUjZ1akKsaLYcbCehVYe+40MeFDZLPOJLvIRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=69+sZ8+lobHtZ0+mrw/hjOgIeJ+qyXsCuMMIqp6Krq8=;
 b=hdkPyDMIYI/4yHitZfAo5QnGMg0u/rsFWQyrl0A5QlMxvy/Z/Ke8AJCt5/wZ/XmXUcJKq4zri34EbycjKmPTMvtgdejQdY03uJeFRyNDTR5Riy6t8ARFeIxL6l99ZvCjVPp70PHFr7L49zx8+1Eq78kLD7r4Rp5uSkSkPeWrRhvbnZlo996gFLqfrZwB30byLkyHLOX/xfrhXnXd7x83ndmb7eyWaWeYDJjKj37KxmePAvlXkyrftItAgtSlu01AtA5YhAcaBTyE2dtBoZi2w2scemHEvlSL7XPHzRCNPCbOdGEH5z45WgEO8sUbBP5XIlKxVXG5IoFolwVfuNJnmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=69+sZ8+lobHtZ0+mrw/hjOgIeJ+qyXsCuMMIqp6Krq8=;
 b=TC7tcKtdKJ+zOXIfUdQgtjhk6dKijH0FR+gsMbJAirt0FEv6ydzaawAnp5/b8sMiNx+5EhAWWBxT5JbM5JB8Bi3B4ZLqmKxhwUwcUzfyw9QMOR+QOIYJXLxOxztp3EO9Pl3+toMfaeddDN5KKCcQF777ecNQsgoAXXzOCR4d3hM=
Received: from BLAPR03CA0053.namprd03.prod.outlook.com (2603:10b6:208:32d::28)
 by DS7PR12MB6215.namprd12.prod.outlook.com (2603:10b6:8:95::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6863.47; Mon, 16 Oct 2023 10:50:32 +0000
Received: from BL6PEPF0001AB76.namprd02.prod.outlook.com
 (2603:10b6:208:32d:cafe::f0) by BLAPR03CA0053.outlook.office365.com
 (2603:10b6:208:32d::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35 via Frontend
 Transport; Mon, 16 Oct 2023 10:50:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB76.mail.protection.outlook.com (10.167.242.169) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Mon, 16 Oct 2023 10:50:32 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 16 Oct
 2023 05:50:03 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v3 12/12] iommu/amd: Introduce logic to enable/disable IOPF
Date: Mon, 16 Oct 2023 10:43:51 +0000
Message-ID: <20231016104351.5749-13-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231016104351.5749-1-vasant.hegde@amd.com>
References: <20231016104351.5749-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB76:EE_|DS7PR12MB6215:EE_
X-MS-Office365-Filtering-Correlation-Id: 1378f972-4e30-4b7a-050f-08dbce35b849
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ri3FaUzbRZpiSm3uGNatAm6lEwIrxXWJRzL0a4YDhBXin1NR+qgQ1lflGgRHBqzRLXmqx8fjX7j6fALl5mBkhpo8q04zWca1oaSlXVSCAGMjifl1C6Ihktoj5rOc3a6Jgl8YftxQR8WlCOqq8ry/35JYk3A6JlvsLQZiM4ry1O3DTBBqip632omYmzsCLewq09aYWZn82RdiSvECRl2QOp1ta6wduMptrOofAp/VNFrolwKWc/D8DhC2EzeXGhtYaP4bf91rIQSp/WOJc28WNkPN0fNRUoVS8aFyCkC5qzINnHw+5EWPXOnqPMll7eg2aslylC/Hb30EiSoCqSwz3h4eulQE8prBrx/pW6HOaJ43w8fh1GYGROZVFz0hMu6qhQy/iQ62W6sI5QqM8nYtpGSf32nAWkB59EG3RQvP89puyK5NGxfbEPl++XyRA9W7FLKdkelarHPy6jBFYAKOjnBZ4lVgTAZ36AR4InscUMpzDA1KsVMAXeAGabCYW3kLuVorDQxMRkqNPI9aVnZPKsBrS+d3VW17NVrUrZLIHdlgbW9hRo6Xko4mv2KajJnS/D5yjlrHlLfGYbv6DnXsh71Iocytgck7kJtZlL67Y49qknnHzgLsYC/4ggJx9I8ibIjiRRO9416tc/zEjnQqsV6+9Jacv4hyRiIxV9tMk8UGMu7pOtdRrpQ+AdeHOQI8Vm6hKT2zxY6ctr1G7oXjziQkgDAFTXs4ovu0j+KwH7QFcc3s4Or6TVQqf2qxYMdyouhi1a9IvIcG2GWC7mEWMw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(346002)(396003)(39860400002)(136003)(230922051799003)(186009)(64100799003)(1800799009)(82310400011)(451199024)(36840700001)(46966006)(40470700004)(44832011)(7696005)(5660300002)(83380400001)(8936002)(36756003)(8676002)(4326008)(47076005)(36860700001)(86362001)(2906002)(70206006)(70586007)(110136005)(41300700001)(316002)(336012)(54906003)(426003)(1076003)(40460700003)(356005)(2616005)(81166007)(40480700001)(82740400003)(16526019)(26005)(478600001)(6666004)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2023 10:50:32.2970
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1378f972-4e30-4b7a-050f-08dbce35b849
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB76.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6215

From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>

Add support to enable/disable IOPF feature. So that PRI capable device
can make use of page fault handler in SVA mode.

Note that this patch enables PRI while binding PASID to device as I was
told enable_feature(PRI) interface is going away.

Also add IOMMU_IOPF as dependency to AMD_IOMMU driver.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Co-developed-by: Vasant Hegde <vasant.hegde@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/Kconfig     |  1 +
 drivers/iommu/amd/amd_iommu.h |  3 ++
 drivers/iommu/amd/iommu.c     | 15 ++++++---
 drivers/iommu/amd/pasid.c     | 31 ++++++++++++++----
 drivers/iommu/amd/ppr.c       | 61 +++++++++++++++++++++++++++++++++++
 5 files changed, 101 insertions(+), 10 deletions(-)

diff --git a/drivers/iommu/amd/Kconfig b/drivers/iommu/amd/Kconfig
index cabf4ccde1ed..22e33179c593 100644
--- a/drivers/iommu/amd/Kconfig
+++ b/drivers/iommu/amd/Kconfig
@@ -11,6 +11,7 @@ config AMD_IOMMU
 	select IOMMU_IOVA
 	select IOMMU_IO_PGTABLE
 	select IOMMU_SVA
+	select IOMMU_IOPF
 	depends on X86_64 && PCI && ACPI && HAVE_CMPXCHG_DOUBLE
 	help
 	  With this option you can enable support for AMD IOMMU hardware in
diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index d14cfd16f125..541121718ccb 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -63,6 +63,8 @@ int amd_iommu_iopf_remove_device(struct amd_iommu *iommu, struct device *dev);
 int amd_iommu_page_response(struct device *dev,
 			    struct iopf_fault *evt,
 			    struct iommu_page_response *resp);
+int amd_iommu_iopf_enable_device(struct device *dev);
+int amd_iommu_iopf_disable_device(struct device *dev);
 
 struct amd_iommu *get_amd_iommu(unsigned int idx);
 u8 amd_iommu_pc_get_max_banks(unsigned int idx);
@@ -76,6 +78,7 @@ int amd_iommu_pc_set_reg(struct amd_iommu *iommu, u8 bank, u8 cntr,
 /* Device capabilities */
 int amd_iommu_pdev_enable_cap_pri(struct pci_dev *pdev);
 void amd_iommu_pdev_disable_cap_pri(struct pci_dev *pdev);
+bool amd_iommu_pdev_pri_supported(struct pci_dev *pdev);
 
 /* GCR3 setup */
 int amd_iommu_set_gcr3(struct iommu_dev_data *dev_data,
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 4d0dbb37a548..c434abab1fda 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -351,6 +351,13 @@ static inline bool pdev_pasid_supported(struct iommu_dev_data *dev_data)
 	return (dev_data->flags & AMD_IOMMU_DEVICE_FLAG_PASID_SUP);
 }
 
+inline bool amd_iommu_pdev_pri_supported(struct pci_dev *pdev)
+{
+	struct iommu_dev_data *dev_data = dev_iommu_priv_get(&pdev->dev);
+
+	return (dev_data->flags & AMD_IOMMU_DEVICE_FLAG_PRI_SUP);
+}
+
 static u32 pdev_get_caps(struct pci_dev *pdev)
 {
 	int features;
@@ -2760,11 +2767,11 @@ static bool amd_iommu_enforce_cache_coherency(struct iommu_domain *domain)
 static int amd_iommu_dev_enable_feature(struct device *dev,
 					enum iommu_dev_features feat)
 {
-	int ret;
+	int ret = 0;
 
 	switch (feat) {
 	case IOMMU_DEV_FEAT_SVA:
-		ret = 0;
+	case IOMMU_DEV_FEAT_IOPF:
 		break;
 	default:
 		ret = -EINVAL;
@@ -2776,11 +2783,11 @@ static int amd_iommu_dev_enable_feature(struct device *dev,
 static int amd_iommu_dev_disable_feature(struct device *dev,
 					 enum iommu_dev_features feat)
 {
-	int ret;
+	int ret = 0;
 
 	switch (feat) {
 	case IOMMU_DEV_FEAT_SVA:
-		ret = 0;
+	case IOMMU_DEV_FEAT_IOPF:
 		break;
 	default:
 		ret = -EINVAL;
diff --git a/drivers/iommu/amd/pasid.c b/drivers/iommu/amd/pasid.c
index f064d0ed1138..c6764421d6c1 100644
--- a/drivers/iommu/amd/pasid.c
+++ b/drivers/iommu/amd/pasid.c
@@ -71,6 +71,27 @@ static void iommu_pasid_disable(struct iommu_dev_data *dev_data)
 	spin_unlock(&dev_data->lock);
 }
 
+static int iommu_setup_pasid_pri(struct iommu_dev_data *dev_data)
+{
+	struct pci_dev *pdev;
+	int ret;
+
+	if (is_pasid_enabled(dev_data))
+		return 0;
+
+	ret = iommu_pasid_enable(dev_data);
+	if (ret)
+		return ret;
+
+	pdev = dev_is_pci(dev_data->dev) ? to_pci_dev(dev_data->dev) : NULL;
+	if (!pdev || !amd_iommu_pdev_pri_supported(pdev))
+		return ret;
+
+	ret = amd_iommu_iopf_enable_device(dev_data->dev);
+
+	return ret;
+}
+
 static void dev_pasid_remove(struct pdom_pasid_data *pasid_data)
 {
 	/* make it visible */
@@ -163,12 +184,10 @@ static int iommu_sva_set_dev_pasid(struct iommu_domain *domain,
 	/* Use SVA protection domain lock */
 	spin_lock_irqsave(&sva_pdom->lock, flags);
 
-	/* Make sure PASID is enabled */
-	if (!is_pasid_enabled(dev_data)) {
-		ret = iommu_pasid_enable(dev_data);
-		if (ret)
-			goto out;
-	}
+	/* Make sure PASID/PRI is enabled */
+	ret = iommu_setup_pasid_pri(dev_data);
+	if (ret)
+		goto out;
 
 	/* Add PASID to protection domain pasid list */
 	pasid_data = kzalloc(sizeof(*pasid_data), GFP_KERNEL);
diff --git a/drivers/iommu/amd/ppr.c b/drivers/iommu/amd/ppr.c
index 63dcf46c2533..7c4b7766c602 100644
--- a/drivers/iommu/amd/ppr.c
+++ b/drivers/iommu/amd/ppr.c
@@ -303,3 +303,64 @@ int amd_iommu_iopf_remove_device(struct amd_iommu *iommu, struct device *dev)
 	raw_spin_unlock_irqrestore(&iommu->lock, flags);
 	return ret;
 }
+
+static int iopf_update_device(struct device *dev, bool enable)
+{
+	struct protection_domain *pdom;
+	struct pci_dev *pdev = dev_is_pci(dev) ? to_pci_dev(dev) : NULL;
+	struct amd_iommu *iommu = get_amd_iommu_from_dev(dev);
+	struct iommu_dev_data *dev_data = dev_iommu_priv_get(dev);
+	int ret = 0;
+
+	if (!pdev || !iommu || !dev_data)
+		return -EINVAL;
+
+	pdom = dev_data->domain;
+	if (!dev_data->domain)
+		return -EINVAL;
+
+	spin_lock(&dev_data->lock);
+
+	if (enable) {
+		if (dev_data->ppr)
+			goto out;
+
+		ret = amd_iommu_iopf_add_device(iommu, dev);
+		if (ret)
+			goto out;
+
+		dev_data->ppr = true;
+	} else {
+		ret = amd_iommu_iopf_remove_device(iommu, dev);
+		dev_data->ppr = false;
+	}
+
+	amd_iommu_dev_update_dte(dev_data, true);
+
+out:
+	spin_unlock(&dev_data->lock);
+	return ret;
+}
+
+int amd_iommu_iopf_enable_device(struct device *dev)
+{
+	struct iommu_dev_data *dev_data = dev_iommu_priv_get(dev);
+
+	if (!dev_data)
+		return -EINVAL;
+
+	if (!dev_data->ats_enabled || !dev_data->pri_enabled)
+		return -EINVAL;
+
+	return iopf_update_device(dev, true);
+}
+
+int amd_iommu_iopf_disable_device(struct device *dev)
+{
+	struct iommu_dev_data *dev_data = dev_iommu_priv_get(dev);
+
+	if (!dev_data || !dev_data->pri_enabled)
+		return -EINVAL;
+
+	return iopf_update_device(dev, false);
+}
-- 
2.31.1

