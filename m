Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2088.outbound.protection.outlook.com [40.107.100.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A51FD1FC8
	for <iommu@lists.linux.dev>; Fri,  4 Aug 2023 06:47:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WPU6AQ3lQ4hR90B7LJojIg/ywO9+QDDfGRFfm8tF+sqXWBdUZQKYumqSYEILHItnKU4vNps5nNNIE7paFvKOSkq8V2EDcAW5RGJPmzQQIHU1nxQmOk3nugTuaolzYkIvlwviaoVA7Qc/x28IokM1kPu+C4ePNF5qD7eQeomIHPhQRS7GNSIq/i58zsiXZ+Rn5UH4O0I9ssMuFdakO/xCwicqj4bWhWEMujP+/ygFYoBj8b/JwJ1Ujdn73r0ipfeXraVv1SNinnWMLPsX5MO6hDaYGsEC7TrumfSLSOnAlW56YrZZ0GbNvThCz6lj7t58hnI4DfiXldKXBy8HvrtNqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rFdMeIBoca/NWeNnJ6Hu5w4g3QGOspGm+e6DzgQsgtc=;
 b=AYvnfGCizTwmptexRhGt/jfkGl9SdnFHxWDtS6Js2uCkQ+iYmAU8VVlXoYLpelLr5yOEVr+xmYX0wCCwBZ7iHI0B9SD/1rgW/ronqWOx6m9T7Iv0yXvZP93r7rVU6G6zg+UZ43hT0fmnpItka7852qT56KkEwhsAz7+OkVC8biREHdZceQpP/+WEKdpLqfpZ8w2jssz9qYPUhVGDnXZmCAM3Kw+DbHxm3q8gUmfJvnDdXUM2UW7cVE6gfDROhcXt50C6cwa2MudgO+kMFnYIEhG+olzApVN9RhZkEx367wdT8EyW5T7ewnf84kLPTzOuPXM3SH5L4ufQ6yogk+oDng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rFdMeIBoca/NWeNnJ6Hu5w4g3QGOspGm+e6DzgQsgtc=;
 b=AH2OUZDncRguzpbKpXTAMfiwXErOVwRS3gRRl0Ckb/DVYx4dwVrVlNHQ3JrBrKccQ4dYrv4+rc9AWSa1lcXag+KUR1RhMupn11myExcmSYZ0aZwgNKrCXJOzZQ04XoDrbaCuyOsCLqH+2hKPyN5EjUzVLhfaw7T7KY6ZbWvMo30=
Received: from CY5PR20CA0023.namprd20.prod.outlook.com (2603:10b6:930:3::32)
 by PH7PR12MB5688.namprd12.prod.outlook.com (2603:10b6:510:130::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.45; Fri, 4 Aug
 2023 06:47:00 +0000
Received: from CY4PEPF0000E9D0.namprd03.prod.outlook.com
 (2603:10b6:930:3:cafe::48) by CY5PR20CA0023.outlook.office365.com
 (2603:10b6:930:3::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.20 via Frontend
 Transport; Fri, 4 Aug 2023 06:47:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D0.mail.protection.outlook.com (10.167.241.143) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.19 via Frontend Transport; Fri, 4 Aug 2023 06:46:59 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 4 Aug
 2023 01:46:56 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v3 14/16] iommu/amd: Enable device ATS/PASID/PRI capabilities independently
Date: Fri, 4 Aug 2023 06:42:14 +0000
Message-ID: <20230804064216.835544-15-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230804064216.835544-1-vasant.hegde@amd.com>
References: <20230804064216.835544-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D0:EE_|PH7PR12MB5688:EE_
X-MS-Office365-Filtering-Correlation-Id: ace9fd19-f91a-4ec7-94ba-08db94b69a8a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	v15oDkzTPZvWJNXEJngFEh7s9mEi4VWVr5/lgnzKYcnXvQCxx+yYKPjgTQcwHQjJAY2zM2Ldmdo5sa4+UP5IoCKnwiTqlE2Gf0WAXQAFrVynC4Y8YWzYPmuWaTTIf+SlYZIGgK/hPO1qdHwSXkjuhWgS23dkaAc+jFWo9cNecakMVzf5mmi+03YwyMIfDprEG5IuSBPkDZql32kTqIoIYaSOKHCAd0s3WVFRBhGBzd6Bx8+m+ue8rYY+99ZLqdkcYBjHzS2evcSyMF96G/xdMDcMPN6Zt62zRbe+m17nXaNMprnnqRtgi9ebweRePmXd5+M+Vv+QRlEb9FOzrvHcb9IUmm7EWW1oYk6KnFtu4WXmSgb7fsIjKCVXAEmOcA7fk2KIArptrkCEz3B1oU1tSaXsEhcgzwA1dev9ReC2ZchqOW/8sT0Eunt1Z/XriYqTzxL7wLqHK1u4sZyRHdCd7rhQ7f2FncjXTYmiPvgiTSkZZ/9wRGXYs8GONgn634GGhHTOKbgQajHmh753VWad+ZXucXwrWrfbNbJep5dE+AuziGCIIAKhk0k2dqAIY9qiu2+5IZhw22TVefm6fZxUwH2Jrcdo7OQ+9NzXaM6aTrsCiK3ONOU9Zjwe+UNHFdKkHZ4yV1jP2vyu3NLExcMt6xm0+6IkoW+1ylhAYma3H4VQStyFYjg60S+CMF62R8IW7Ce+Eo95f4cA0h6VKem40V2L6+uGYtjb4F3IY/0F2jtmK4m16+4obMfBU88JhY9q2X9gifxVVNyI6kLLBBgYhA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(396003)(376002)(136003)(451199021)(1800799003)(186006)(82310400008)(40470700004)(46966006)(36840700001)(40480700001)(336012)(86362001)(478600001)(16526019)(40460700003)(2616005)(54906003)(36756003)(81166007)(316002)(110136005)(26005)(70206006)(70586007)(4326008)(82740400003)(1076003)(356005)(6666004)(7696005)(41300700001)(8936002)(8676002)(426003)(47076005)(83380400001)(44832011)(36860700001)(5660300002)(2906002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2023 06:46:59.9695
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ace9fd19-f91a-4ec7-94ba-08db94b69a8a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5688

Introduce helper functions to enable/disable device ATS/PASID/PRI
capabilities independently along with the new pasid_enabled and
pri_enabled variables in struct iommu_dev_data to keep track,
which allows attach_device() and detach_device() to be simplified.

Co-developed-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/amd/amd_iommu.h       |   4 +
 drivers/iommu/amd/amd_iommu_types.h |   2 +
 drivers/iommu/amd/iommu.c           | 203 ++++++++++++++++------------
 3 files changed, 120 insertions(+), 89 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index 0605f02fa711..56996dc2868d 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -54,6 +54,10 @@ int amd_iommu_pc_get_reg(struct amd_iommu *iommu, u8 bank, u8 cntr,
 int amd_iommu_pc_set_reg(struct amd_iommu *iommu, u8 bank, u8 cntr,
 			 u8 fxn, u64 *value);
 
+/* Device capabilities */
+int amd_iommu_pdev_enable_cap_pri(struct pci_dev *pdev);
+void amd_iommu_pdev_disable_cap_pri(struct pci_dev *pdev);
+
 int amd_iommu_register_ppr_notifier(struct notifier_block *nb);
 int amd_iommu_unregister_ppr_notifier(struct notifier_block *nb);
 void amd_iommu_domain_direct_map(struct iommu_domain *dom);
diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 89eb65117c1f..e114e4af0f05 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -824,6 +824,8 @@ struct iommu_dev_data {
 	u32 flags;			  /* Holds AMD_IOMMU_DEVICE_FLAG_<*> */
 	int ats_qdep;
 	u8 ats_enabled  :1;		  /* ATS state */
+	u8 pri_enabled  :1;		  /* PRI state */
+	u8 pasid_enabled:1;		  /* PASID state */
 	u8 pri_tlp      :1;		  /* PASID TLB required for
 					     PPR completions */
 	enum ppr_handlers ppr;
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 490c19284a4b..208d69e7a6b4 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -335,6 +335,113 @@ static u32 pdev_get_caps(struct pci_dev *pdev)
 	return flags;
 }
 
+static inline int pdev_enable_cap_ats(struct pci_dev *pdev)
+{
+	struct iommu_dev_data *dev_data = dev_iommu_priv_get(&pdev->dev);
+	int ret = -EINVAL;
+
+	if (dev_data->ats_enabled)
+		return 0;
+
+	if (amd_iommu_iotlb_sup &&
+	    (dev_data->flags & AMD_IOMMU_DEVICE_FLAG_ATS_SUP)) {
+		ret = pci_enable_ats(pdev, PAGE_SHIFT);
+		if (!ret) {
+			dev_data->ats_enabled = 1;
+			dev_data->ats_qdep    = pci_ats_queue_depth(pdev);
+		}
+	}
+
+	return ret;
+}
+
+static inline void pdev_disable_cap_ats(struct pci_dev *pdev)
+{
+	struct iommu_dev_data *dev_data = dev_iommu_priv_get(&pdev->dev);
+
+	if (dev_data->ats_enabled) {
+		pci_disable_ats(pdev);
+		dev_data->ats_enabled = 0;
+	}
+}
+
+int amd_iommu_pdev_enable_cap_pri(struct pci_dev *pdev)
+{
+	struct iommu_dev_data *dev_data = dev_iommu_priv_get(&pdev->dev);
+	int ret = -EINVAL;
+
+	if (dev_data->pri_enabled)
+		return 0;
+
+	if (dev_data->flags & AMD_IOMMU_DEVICE_FLAG_PRI_SUP) {
+		/*
+		 * First reset the PRI state of the device.
+		 * FIXME: Hardcode number of outstanding requests for now
+		 */
+		if (!pci_reset_pri(pdev) && !pci_enable_pri(pdev, 32)) {
+			dev_data->pri_enabled = 1;
+			dev_data->pri_tlp     = pci_prg_resp_pasid_required(pdev);
+
+			ret = 0;
+		}
+	}
+
+	return ret;
+}
+
+void amd_iommu_pdev_disable_cap_pri(struct pci_dev *pdev)
+{
+	struct iommu_dev_data *dev_data = dev_iommu_priv_get(&pdev->dev);
+
+	if (dev_data->pri_enabled) {
+		pci_disable_pri(pdev);
+		dev_data->pri_enabled = 0;
+	}
+}
+
+static inline int pdev_enable_cap_pasid(struct pci_dev *pdev)
+{
+	struct iommu_dev_data *dev_data = dev_iommu_priv_get(&pdev->dev);
+	int ret = -EINVAL;
+
+	if (dev_data->pasid_enabled)
+		return 0;
+
+	if (dev_data->flags & AMD_IOMMU_DEVICE_FLAG_PASID_SUP) {
+		/* Only allow access to user-accessible pages */
+		ret = pci_enable_pasid(pdev, 0);
+		if (!ret)
+			dev_data->pasid_enabled = 1;
+	}
+
+	return ret;
+}
+
+static inline void pdev_disable_cap_pasid(struct pci_dev *pdev)
+{
+	struct iommu_dev_data *dev_data = dev_iommu_priv_get(&pdev->dev);
+
+	if (dev_data->pasid_enabled) {
+		pci_disable_pasid(pdev);
+		dev_data->pasid_enabled = 0;
+	}
+}
+
+static void pdev_enable_caps(struct pci_dev *pdev)
+{
+	pdev_enable_cap_ats(pdev);
+	pdev_enable_cap_pasid(pdev);
+	amd_iommu_pdev_enable_cap_pri(pdev);
+
+}
+
+static void pdev_disable_caps(struct pci_dev *pdev)
+{
+	pdev_disable_cap_ats(pdev);
+	pdev_disable_cap_pasid(pdev);
+	amd_iommu_pdev_disable_cap_pri(pdev);
+}
+
 /*
  * This function checks if the driver got a valid device from the caller to
  * avoid dereferencing invalid pointers.
@@ -1764,48 +1871,6 @@ static void do_detach(struct iommu_dev_data *dev_data)
 	domain->dev_cnt                 -= 1;
 }
 
-static void pdev_iommuv2_disable(struct pci_dev *pdev)
-{
-	pci_disable_ats(pdev);
-	pci_disable_pri(pdev);
-	pci_disable_pasid(pdev);
-}
-
-static int pdev_pri_ats_enable(struct pci_dev *pdev)
-{
-	int ret;
-
-	/* Only allow access to user-accessible pages */
-	ret = pci_enable_pasid(pdev, 0);
-	if (ret)
-		return ret;
-
-	/* First reset the PRI state of the device */
-	ret = pci_reset_pri(pdev);
-	if (ret)
-		goto out_err_pasid;
-
-	/* Enable PRI */
-	/* FIXME: Hardcode number of outstanding requests for now */
-	ret = pci_enable_pri(pdev, 32);
-	if (ret)
-		goto out_err_pasid;
-
-	ret = pci_enable_ats(pdev, PAGE_SHIFT);
-	if (ret)
-		goto out_err_pri;
-
-	return 0;
-
-out_err_pri:
-	pci_disable_pri(pdev);
-
-out_err_pasid:
-	pci_disable_pasid(pdev);
-
-	return ret;
-}
-
 /*
  * If a device is not yet associated with a domain, this function makes the
  * device visible in the domain
@@ -1814,9 +1879,8 @@ static int attach_device(struct device *dev,
 			 struct protection_domain *domain)
 {
 	struct iommu_dev_data *dev_data;
-	struct pci_dev *pdev;
 	unsigned long flags;
-	int ret;
+	int ret = 0;
 
 	spin_lock_irqsave(&domain->lock, flags);
 
@@ -1824,45 +1888,13 @@ static int attach_device(struct device *dev,
 
 	spin_lock(&dev_data->lock);
 
-	ret = -EBUSY;
-	if (dev_data->domain != NULL)
+	if (dev_data->domain != NULL) {
+		ret = -EBUSY;
 		goto out;
-
-	if (!dev_is_pci(dev))
-		goto skip_ats_check;
-
-	pdev = to_pci_dev(dev);
-	if (domain->flags & PD_IOMMUV2_MASK) {
-		struct iommu_domain *def_domain = iommu_get_dma_domain(dev);
-
-		ret = -EINVAL;
-
-		/*
-		 * In case of using AMD_IOMMU_V1 page table mode and the device
-		 * is enabling for PPR/ATS support (using v2 table),
-		 * we need to make sure that the domain type is identity map.
-		 */
-		if ((amd_iommu_pgtable == AMD_IOMMU_V1) &&
-		    def_domain->type != IOMMU_DOMAIN_IDENTITY) {
-			goto out;
-		}
-
-		if (pdev_pasid_supported(dev_data)) {
-			if (pdev_pri_ats_enable(pdev) != 0)
-				goto out;
-
-			dev_data->ats_enabled = 1;
-			dev_data->ats_qdep    = pci_ats_queue_depth(pdev);
-			dev_data->pri_tlp     = pci_prg_resp_pasid_required(pdev);
-		}
-	} else if (amd_iommu_iotlb_sup &&
-		   pci_enable_ats(pdev, PAGE_SHIFT) == 0) {
-		dev_data->ats_enabled = 1;
-		dev_data->ats_qdep    = pci_ats_queue_depth(pdev);
 	}
 
-skip_ats_check:
-	ret = 0;
+	if (dev_is_pci(dev))
+		pdev_enable_caps(to_pci_dev(dev));
 
 	do_attach(dev_data, domain);
 
@@ -1910,15 +1942,8 @@ static void detach_device(struct device *dev)
 
 	do_detach(dev_data);
 
-	if (!dev_is_pci(dev))
-		goto out;
-
-	if (domain->flags & PD_IOMMUV2_MASK && pdev_pasid_supported(dev_data))
-		pdev_iommuv2_disable(to_pci_dev(dev));
-	else if (dev_data->ats_enabled)
-		pci_disable_ats(to_pci_dev(dev));
-
-	dev_data->ats_enabled = 0;
+	if (dev_is_pci(dev))
+		pdev_disable_caps(to_pci_dev(dev));
 
 out:
 	spin_unlock(&dev_data->lock);
-- 
2.31.1

