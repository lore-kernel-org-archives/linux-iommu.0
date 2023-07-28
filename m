Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2047.outbound.protection.outlook.com [40.107.100.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1691C5696
	for <iommu@lists.linux.dev>; Fri, 28 Jul 2023 05:40:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lP8K/Xb48tvLiDjFY0ZwtRSxDSDmZHSdi853ahuXhUivqc8QW8y9fdOOUjUemerWva3YBYnTymp3gB0fnl/w1dh6B0rANz91xyyB46wdV5/6mR85SuH62Ljz+Uw+EtdFlHsHO4g3Ia6ZzNw4kbT/g4YTu7TPN5W2a7AvOzjIfe+ONEgOs+FIjcXCZy/iuWJwIHAgnzLdjz331abDFveaubG+kEdw4Vo2Aqz+nmdvFHmrLaiJz/f180MHhqpmo+sA+4TUghbfYUHHinhsQAhLdwN1llMaYEF0qMCeo49XqhhV2kYAFa6PjBtzliV7BnWgmsKDCA0H8HTVQgFCVIDAJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fmW4qk5gId5qp/pPPgbjY/D26Le8anJx6sdfHGnUnYk=;
 b=l9ucsE1PxEtWiH6d+fMWosRA1HWsaiMs7YBwdj7ZtjP79hDDK7Y4/Vl1SX0mEAVT+pMTrCubuvQBJlIjxjbNGfa3ivYK4J9LkyuITd1AvTi2mN7kBJEBV53/ajUvjUOgnmu4jNO1VOT6lK/IrrwWkvG1rN3QffnrUvjaZc5laMy+QfHLqAPdS+z+B9W60LpUT7nT8SnVkBno4OlWxRfjNFMqZIliR+WYAfmIyrdqXowW85qmzbtB/GlaJdSD6e9S7OYaqDHy2uYtIE0zIhZmfA+9jbn6INXCXiP7H+bQ0eMlPRF+RxgDxNOGZ9msODWGPxXiJ8vAfPJvfWRiM4N8qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fmW4qk5gId5qp/pPPgbjY/D26Le8anJx6sdfHGnUnYk=;
 b=FhD6ZjHp+GU+//SRjDHpO9j9F9RUZYIIXdhbJjst9gguxf2ZzCoxfv5BreJa3vMk+n0JEgx7pGo+eimhlWLN9xf/vRk1d4mK2loOSu/iQ3/aN4pB9HqByLUNzDH9PTRR3aZwmbdGFS2dcKOrUqtkHc/gI1fXoTf9b/Vl0NyJQNs=
Received: from BN1PR14CA0017.namprd14.prod.outlook.com (2603:10b6:408:e3::22)
 by DM4PR12MB5198.namprd12.prod.outlook.com (2603:10b6:5:395::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Fri, 28 Jul
 2023 05:40:39 +0000
Received: from BN8NAM11FT065.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e3:cafe::8f) by BN1PR14CA0017.outlook.office365.com
 (2603:10b6:408:e3::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29 via Frontend
 Transport; Fri, 28 Jul 2023 05:40:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT065.mail.protection.outlook.com (10.13.177.63) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6631.29 via Frontend Transport; Fri, 28 Jul 2023 05:40:39 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 28 Jul
 2023 00:40:36 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v2 14/16] iommu/amd: Enable device ATS/PASID/PRI capabilities independently
Date: Fri, 28 Jul 2023 05:36:07 +0000
Message-ID: <20230728053609.165183-15-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230728053609.165183-1-vasant.hegde@amd.com>
References: <20230728053609.165183-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN8NAM11FT065:EE_|DM4PR12MB5198:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c3fdb89-6727-465e-1bc2-08db8f2d2cd2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	8nXBnYNYvxuqGxajiKA3UT6DmqA3vkP4iUJ1BMhZ6fpx2p9fVIX0V1PUm+NggjqVU1kDEQ/7/7WqrqghtYyYWBvG2LPdi3afTiAb5UKyux9baAqCY02Zos4CLTtjfSKZ7PuqFv1+BltPqK5FJOaTSlYXxTOd8X0sz4jcWXKGN5+VotwSsFFm98AkV/OoyLvuLNVD/Qwp/RnkOQHwp06MuPY4X7HRhgkpv1yeqMavAqbmtMhxuOVs+S/xkrzeKgSe6lPq3kdwC4BIg0fg7VEV8UYFYo9xu+mE+xo/YGM4x4jdkihM1E/C6UDaAituaaZwULF55vaRouSJ9zn1jbe4kcmRkASbrrKPICHTIkLZ0HyAtyznTqcxxeX9UwpKk+SB7Gd+viiM3pcOzwAmkzZxkJTXnJPfK8YGQ8WD7JwLkgniXlxmRvK7KhHzgu72/5BO43jib0yFm6AXJHjs7E8c/Eiqbfnw1ec048RQw75Wg5nbnbxWP2fYiPlWgTyacSgHN9ypjrtuF4beX9A3OOwss2Cgqv+JrqXwnVbYAza3WUS4pjaBFjKKsPzeZE54twn3pSdnXGnpgwmnflAVwYKhO2gKu6FQqWGx1zmm9Sf/7QSiLgbUjOD3DAOCQWX7qOXzL458ABQRBv7g9f8JZ2sVTqy0Nld5NN0wtn4xAqpEpTfHOxUx98sOC60DT35YYecanf+7BrYBi9t6Fobd43S6Vkwbu4O+Qal0nYjR2oFBYoFjKhN4CDd1G6waVIKBLh/c+bNvzh+MUTfTbpHr926PfQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(136003)(396003)(346002)(82310400008)(451199021)(46966006)(36840700001)(40470700004)(2906002)(316002)(8936002)(8676002)(5660300002)(44832011)(41300700001)(40460700003)(36756003)(40480700001)(86362001)(426003)(7696005)(6666004)(81166007)(110136005)(54906003)(82740400003)(26005)(478600001)(1076003)(356005)(336012)(16526019)(186003)(70586007)(2616005)(83380400001)(70206006)(36860700001)(47076005)(4326008)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2023 05:40:39.0855
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c3fdb89-6727-465e-1bc2-08db8f2d2cd2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN8NAM11FT065.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5198

Introduce helper functions to enable/disable device ATS/PASID/PRI
capabilities independently along with the new pasid_enabled and
pri_enabled variables in struct iommu_dev_data to keep track,
which allows attach_device() and detach_device() to be simplified.

Co-developed-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
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
index 57c74870b17f..445b58c24d20 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -824,6 +824,8 @@ struct iommu_dev_data {
 	u32 flags;			  /* Holds AMD_IOMMU_DEVICE_FLAG_<*> */
 	int  ats_qdep;
 	bool ats_enabled;		  /* ATS state */
+	bool pri_enabled;		  /* PRI state */
+	bool pasid_enabled;		  /* PASID state */
 	bool pri_tlp;			  /* PASID TLB required for
 					     PPR completions */
 	enum ppr_handlers ppr;
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 7f67e8991949..3b20d4d97192 100644
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
+			dev_data->ats_enabled = true;
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
+		dev_data->ats_enabled = false;
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
+			dev_data->pri_enabled = true;
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
+		dev_data->pri_enabled = false;
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
+			dev_data->pasid_enabled = true;
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
+		dev_data->pasid_enabled = false;
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
@@ -1761,48 +1868,6 @@ static void do_detach(struct iommu_dev_data *dev_data)
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
@@ -1811,9 +1876,8 @@ static int attach_device(struct device *dev,
 			 struct protection_domain *domain)
 {
 	struct iommu_dev_data *dev_data;
-	struct pci_dev *pdev;
 	unsigned long flags;
-	int ret;
+	int ret = 0;
 
 	spin_lock_irqsave(&domain->lock, flags);
 
@@ -1821,45 +1885,13 @@ static int attach_device(struct device *dev,
 
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
-			dev_data->ats_enabled = true;
-			dev_data->ats_qdep    = pci_ats_queue_depth(pdev);
-			dev_data->pri_tlp     = pci_prg_resp_pasid_required(pdev);
-		}
-	} else if (amd_iommu_iotlb_sup &&
-		   pci_enable_ats(pdev, PAGE_SHIFT) == 0) {
-		dev_data->ats_enabled = true;
-		dev_data->ats_qdep    = pci_ats_queue_depth(pdev);
 	}
 
-skip_ats_check:
-	ret = 0;
+	if (dev_is_pci(dev))
+		pdev_enable_caps(to_pci_dev(dev));
 
 	do_attach(dev_data, domain);
 
@@ -1907,15 +1939,8 @@ static void detach_device(struct device *dev)
 
 	do_detach(dev_data);
 
-	if (!dev_is_pci(dev))
-		goto out;
-
-	if (domain->flags & PD_IOMMUV2_MASK && pdev_pasid_supported(dev_data))
-		pdev_iommuv2_disable(to_pci_dev(dev));
-	else if (dev_data->ats_enabled)
-		pci_disable_ats(to_pci_dev(dev));
-
-	dev_data->ats_enabled = false;
+	if (dev_is_pci(dev))
+		pdev_disable_caps(to_pci_dev(dev));
 
 out:
 	spin_unlock(&dev_data->lock);
-- 
2.31.1

