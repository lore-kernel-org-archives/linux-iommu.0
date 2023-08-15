Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2065.outbound.protection.outlook.com [40.107.223.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B169A10788
	for <iommu@lists.linux.dev>; Tue, 15 Aug 2023 10:26:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CAkjS4ia9b5mI88aLKhxOnhAtrxNFkFvKUrx3sXivQaciDcx3Wg/CHk2DW4621KOHogIC4NZ5ZDCpVcXZaMTqdrSso5iWzsTInnewOkCe+LxV23ICRYh0zf2Ik3Bf+LX7ePqFO1BTybiVheluYsI68N9+GZWAwmC4qJN45RbGbFg5Ze92QLOnQzfeHVcEp5fdLg84SfVnlfA9Advyfmt73xTP0uvPthdNS/bMSRXzoqO7A34q1L+E1pXw7RPjSTBiGJLFd0aJYEvcygnGv2DaARLWUaja23LgsRqcSJfmmzAZH6hm9zj1Q7U9kqY0WLNrJH0FjRDIg2qvCKGdjT9Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kiEHE3sxmyeF0gj1b6SpmJMuF+2yX1/wO/tKqZX1NAo=;
 b=HqyeoGZW9Y86vsN3xFRpEQAj3vthhLrms6MLvTWLCplK+Dr6Oj/DhP2eduIDcUpWXhK9AoHNddhuFllw1WzqIXuoBlbJrxC56DAZWCZoWJNDHhEEkDmAIgtSgfNxp2PCT4jW3B6p2Di8788HDCeFeED1VZUbyvwvCDArTYUdgSwgc3m75nQrusq653fE6vgOGmV18g2/+KpGDQVVlMU4g4534+VFRv6fgYfZHpxRi8wAMtlUex0fZ0DhyiTZ08iDZiwv5055IHun0MkELT+tFZbUPqZowXzMAWZoRNc/MKqV+Q2f8k0Z0R4N9RO1+30BbYztIQT8QxOasgqTP4mPJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kiEHE3sxmyeF0gj1b6SpmJMuF+2yX1/wO/tKqZX1NAo=;
 b=KFi+9bAt/eeuDxwH3B9lJ73rEdxqLQZ2UlccOt90f2C7AqfaYr7TFa9/lfzGwdd2bhLc3mnvQFpFIRuQj5+2i3TgglnilpCJYUqLf6gQUHfBA+6Z1lJ4HLJVgr2amX4odDzdGWiS4Mr7yMki2z33dBRGqik2UeVlmByMFA+vHNI=
Received: from MW4PR03CA0147.namprd03.prod.outlook.com (2603:10b6:303:8c::32)
 by BL1PR12MB5334.namprd12.prod.outlook.com (2603:10b6:208:31d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Tue, 15 Aug
 2023 10:26:31 +0000
Received: from CO1PEPF000044F8.namprd21.prod.outlook.com
 (2603:10b6:303:8c:cafe::1) by MW4PR03CA0147.outlook.office365.com
 (2603:10b6:303:8c::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.14 via Frontend
 Transport; Tue, 15 Aug 2023 10:26:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F8.mail.protection.outlook.com (10.167.241.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6723.3 via Frontend Transport; Tue, 15 Aug 2023 10:26:30 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 15 Aug
 2023 05:26:21 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v4 13/14] iommu/amd: Enable device ATS/PASID/PRI capabilities independently
Date: Tue, 15 Aug 2023 10:22:01 +0000
Message-ID: <20230815102202.565012-14-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230815102202.565012-1-vasant.hegde@amd.com>
References: <20230815102202.565012-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F8:EE_|BL1PR12MB5334:EE_
X-MS-Office365-Filtering-Correlation-Id: 80bebdc4-dedd-481d-08b3-08db9d7a1753
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	m1f1W3wxtdbttGFchrTDu5jS0G9FW1QWcJ306n9JHVX4fiQ6U06Ulj6v769WCLuqHn16bRPnhDlKQUkABaR6sJ/4XXAK0M1JLSVa814t/iyz8+ArNoHiLJOinXi8S9ohoOEuONuBy965AhlZo/ojfkzE5mdC/X9LviQJa512qo17SsC7QJQMP/wjJug21G3SjR19yuCrb6JXbe/qrSfSZutrmxltduWiJqACSlW2ShETeN7sF9Sfvyj6cn8cxO0W/q0JWr5dimI51kdxF7cjKdjr6fUAEYOIwAz4Stp0+9gHYcsNiJ6cEW+UqMdRSvZV/GOMJL37iMXZY8HSAlJMkcGff/FXtpPT/TEvH+fdS9ph+K+LQSfJRhKSTLyaUzNkYaVRjqfUg25xAl1P3TXa1ibim3+Lo0MSyf4wxSG2+EClm27gkg/YPkMdcA1HzlYwwsNKJaKOgM+QtOeAOl8bdynPqDxDrQoUNkKK2M14ZuqfqzgHjFJlL5ydumjW4CTKoJF15Zmf7UMKAx7qhJ0Mq7NUV4/n8pfoeb26Ff3PFNTuCG1dpTGsNvZkVJ7G9IQW66fNqQDJU6CIHMcVEZh+359TrNqaZ9M7o5LHO1RdwKw+ZGHSMORZ7ztgxqc0FrjpVbqRv1L/fXjcigXNeanIKx19a3bTkvfamIn8r67EPkCn0XLZCepNfWWc6g2hDXFChnaWuGKfX+L2V1CzkVn7q5pN3rvwV4fAHtwZBbk3Eej6Pz+HRO3Vtd+2WAukKwqwLt4UWUTrGlmxUTwBW5Hrmw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(376002)(396003)(346002)(1800799006)(186006)(82310400008)(451199021)(46966006)(40470700004)(36840700001)(40480700001)(40460700003)(356005)(478600001)(81166007)(82740400003)(8676002)(6666004)(8936002)(83380400001)(110136005)(70206006)(4326008)(41300700001)(54906003)(316002)(70586007)(36860700001)(47076005)(7696005)(2616005)(1076003)(26005)(426003)(336012)(16526019)(86362001)(2906002)(5660300002)(44832011)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2023 10:26:30.4383
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 80bebdc4-dedd-481d-08b3-08db9d7a1753
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F8.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5334

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
index 69cdcac76a06..88a05f1a61e0 100644
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
index c93f9482d3c1..1d001ca11fc1 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -815,6 +815,8 @@ struct iommu_dev_data {
 	u32 flags;			  /* Holds AMD_IOMMU_DEVICE_FLAG_<*> */
 	int ats_qdep;
 	u8 ats_enabled  :1;		  /* ATS state */
+	u8 pri_enabled  :1;		  /* PRI state */
+	u8 pasid_enabled:1;		  /* PASID state */
 	u8 pri_tlp      :1;		  /* PASID TLB required for
 					     PPR completions */
 	bool ppr;			  /* Enable device PPR support */
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index b1a99b7d1956..26e09b584e70 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -349,6 +349,113 @@ static u32 pdev_get_caps(struct pci_dev *pdev)
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
@@ -1777,48 +1884,6 @@ static void do_detach(struct iommu_dev_data *dev_data)
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
@@ -1827,9 +1892,8 @@ static int attach_device(struct device *dev,
 			 struct protection_domain *domain)
 {
 	struct iommu_dev_data *dev_data;
-	struct pci_dev *pdev;
 	unsigned long flags;
-	int ret;
+	int ret = 0;
 
 	spin_lock_irqsave(&domain->lock, flags);
 
@@ -1837,45 +1901,13 @@ static int attach_device(struct device *dev,
 
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
 
@@ -1923,15 +1955,8 @@ static void detach_device(struct device *dev)
 
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

