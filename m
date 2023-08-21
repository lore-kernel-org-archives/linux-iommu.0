Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34F8A1848
	for <iommu@lists.linux.dev>; Mon, 21 Aug 2023 10:48:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d4qjbOC0vcRXN2kwxjjmG9v6XBK68yTguYmppNvJgk8Ksq1ixrfc9Z+XuOIjIuNYf8QOC2eGyMZqkJCn4183hmH5MoGoJ3jYeC/jrMWhs6KovYhFiR+aBm1865tNZVdyen3Bj9rBmcCubsUYWXwXmarnKNRt2/WK46kybyPz1A/ZyCJ0Eq7eUiPRWQprhaXeoa7qVl4MmmMOuBMDlRL+5Lc41P/e0MZrFOuCJepDbi4XU+DaUx2KeE4++3sE6inRFqhWO5l99fRbAeIglfiIE4MggtiZYnl6+8l3CagTXI+KecX1Fl0Q8RzcldugJWng4dVwVAcFvVgTftyNe7IWcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H8PiF28Ra/bUL4ibXMaYlGIgYgEuRolaLtjBrTdGRVc=;
 b=ELx0nzbERWk7r0ByjOspLElG2uv8X5e4hMUIgDXYUJPxhkWPHz+iBdt/cclQnfMQSMVA2DLaVD7EbZ6UuuD1TCvR0tQSjlEUowLyeQ3fbtjvNVm+nPcHhnb9yRKMEuvcr7slcfTB4b1SOXw4DulvcYMs1ciOPm2pYe9JUNIedmbfCebLzGs8Jj/uGj4yVhSMTe4HZcgEjOJerEqFvk+hHpRXO8iqElOk74njJ77Ah3+C/StNRk6tSPJEg/0c6ubMvXTwxQcw1we/en6xpdc8E7z3C0mXWDrQBtSPdAAEHz+sFr1X6IcY5nTHQjhIaq3ymhtGH39Uj+gwc69XGq1CPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H8PiF28Ra/bUL4ibXMaYlGIgYgEuRolaLtjBrTdGRVc=;
 b=TfERVd/VEC9KLxOq81/CfNCClX8TBZVCYG4fUxG5BwYC4WD00cdKcOY2epR5oHYdK/2+yDtCPgfr+sQGCHs/akeB78in8pvpoyjAiQkLDXSCvQx291EqrGb3gs+9NeQB7+uOoD0bn9L+Dt/As9ncEpCWX49Lp8JfYEMgB+zAUYI=
Received: from SA9PR13CA0037.namprd13.prod.outlook.com (2603:10b6:806:22::12)
 by SJ0PR12MB8139.namprd12.prod.outlook.com (2603:10b6:a03:4e8::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Mon, 21 Aug
 2023 10:47:58 +0000
Received: from SN1PEPF0002529F.namprd05.prod.outlook.com
 (2603:10b6:806:22:cafe::18) by SA9PR13CA0037.outlook.office365.com
 (2603:10b6:806:22::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6723.10 via Frontend
 Transport; Mon, 21 Aug 2023 10:47:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002529F.mail.protection.outlook.com (10.167.242.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.15 via Frontend Transport; Mon, 21 Aug 2023 10:47:57 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 21 Aug
 2023 05:47:52 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v5 13/14] iommu/amd: Enable device ATS/PASID/PRI capabilities independently
Date: Mon, 21 Aug 2023 10:42:26 +0000
Message-ID: <20230821104227.706997-14-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230821104227.706997-1-vasant.hegde@amd.com>
References: <20230821104227.706997-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529F:EE_|SJ0PR12MB8139:EE_
X-MS-Office365-Filtering-Correlation-Id: e0585ddd-1f09-45de-2579-08dba23414fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	WhsntCvoa0omwTegVDgdONmMG2Srh8t5+EWHpU34yow+IMj7X5Y0S5tJ3vSJM+3/UWmzm3oNBBSbZnxczBoK++en9waiaZMhDmB5kWZY1Yzp9vAXj8wZAxkFq1pQil8EeW1yRHcDIMnxtJ6xIU4BUTm/9PQ0ErE57f/ETKgZpuR/MK6jJtMOk4FgB1taRVSudW7NzpTvDy5NL+PX/lnOTDvbRkeY6Jv1DHrvg1xfBJ6hK7+aJ+MqnG8GH7lUrxEsTeIyRFLdbux6qy/qlUH1gualEILO7FSo0Lc4bId1kpaTMZopw/PwdzQABE8Yu7PJdPoKbwuWZ3edl/CMXMKbRMQO8U0Y8tmpBnSrkix1xlW9WwnFoAEfl1pT2cvKpRR87sF7hq18UPduMQjpMvOLBU04VCYVgfTgmc30L926avS8/EzAUfr0BjUAjDFEvgER/2PjMb2weQktEnL6p6H0/npP9wylWRGC4kGORsZfFVq1ckz7F/HOwyUAq1h9mhec5+fTPTWo8qq5tf8NepE4FMDNe5m0qNTRaQyQK1eus5rXMJFF4lkEizBhTtNDcRuVdghyTnBJUjTjBuPSCBKwqgbTv4/CDKA5+V+1dU2AMxNZmk8U+dMKXLTU/u92+mVF9PTKnSAtjmftwB98CIjSA29AFs+vRCdAth4yrEZUN+DeouuCVip/Dy90ZACdQjFc0gtpr+Zjl9wfUxIVKKMxTKUqFr2QDfg8OxNkM53mUPbK8lpJfWNV+OtRBOax8ijiwCCZAxF6fVfbNu7JvZvxYA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(396003)(136003)(376002)(39860400002)(186009)(451199024)(1800799009)(82310400011)(36840700001)(46966006)(40470700004)(86362001)(36756003)(478600001)(40480700001)(44832011)(2616005)(5660300002)(4326008)(8676002)(8936002)(47076005)(16526019)(336012)(426003)(26005)(1076003)(36860700001)(83380400001)(2906002)(40460700003)(6666004)(70206006)(70586007)(54906003)(110136005)(81166007)(356005)(316002)(82740400003)(7696005)(41300700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2023 10:47:57.6369
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e0585ddd-1f09-45de-2579-08dba23414fa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002529F.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8139

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
index e287366f72cc..be2db4ce81ba 100644
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
index 07f8919ee34e..c6d47cb7a0ee 100644
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
 	u8 ppr          :1;		  /* Enable device PPR support */
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

