Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2064.outbound.protection.outlook.com [40.107.243.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67EE6100AE
	for <iommu@lists.linux.dev>; Wed, 12 Jul 2023 14:20:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FqvTtB6ontsjxeDrvz4Y8QssUrrKnMbRRxK5044b58LNDUh72n64npfSutWPLo4ujT/Gm1kW3B46QtuEzNcdjSLuLKDmbALKJInIN1b6QZcCdERCJrFhz54fIVdLk2AUniKVgKMYRWK+bRjp3YzNDs/87eMMCsHCnnVpU6ER1xHfU1eTNzSkrTVGGKBsSQWXHnGHiUpY0SmrM8aSXphF3lcOCrGd0nzr7bXUv0Z1oPbgKh90drOAyaKAomGBbowZpQPUSSnbPQ9XW+dAzWrrmVHWQIbvDRBE8AjMEGnJK/LZrPEFbVa/GmPcq1tzzFZ7blJJ0SZOtFp/YN4KZ/84kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gv4cNQKr48qmwKwHgNcRx97M1DzYIaaaUf5OEySAKsY=;
 b=RHPvOtTlUVA8SGft0NsM2WGxPvK2aDkfxemxglTThAZDmhA5on1uUJf9e8zwaLOdDJsnkzjUt46cECmu1zeijzOsaD0Bws6SpIn1Bt8IGUtQGlllNl9mC6r1I8zPwqv3cZwaJ+uNTQwPaMjgqbwk3AnUYGdhB/pSTSesjPLKqqr/4zeDCNPEIttn0lMhJVUmhK0oeUZlDgngWXXqhKV7QSEH2nGqJOXHCA1iOtdyTiBnXsDkE49deX4auWAaFGZxGcp2bXjAf4yZpDxQsThjATpFlqUNEaRRD5Ph5oqwR1iJxNDzoPTogIcwBLGx3Yz9kAKTzmRSOxT7JGm1zvxixg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gv4cNQKr48qmwKwHgNcRx97M1DzYIaaaUf5OEySAKsY=;
 b=3lDSoFu7MXJ/C3nHVeRz4skQRzS7diCBVA8qGnAX4/Yv4Feid3xcaJg/5SRO2N2ez691TelrmIaMXl//cpnAzJJ7ptHffbo8xZBAV3ChAaIsm8r/J+MdzCCTujSjYG7MDMBG2EPAYKABw+ABHoz1HIWcVbZJU2I8JV9ZTcVcIEk=
Received: from MW4PR04CA0091.namprd04.prod.outlook.com (2603:10b6:303:83::6)
 by IA1PR12MB7493.namprd12.prod.outlook.com (2603:10b6:208:41b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.26; Wed, 12 Jul
 2023 14:20:25 +0000
Received: from CO1NAM11FT077.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:83:cafe::bd) by MW4PR04CA0091.outlook.office365.com
 (2603:10b6:303:83::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.22 via Frontend
 Transport; Wed, 12 Jul 2023 14:20:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT077.mail.protection.outlook.com (10.13.175.55) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6588.20 via Frontend Transport; Wed, 12 Jul 2023 14:20:25 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 12 Jul
 2023 09:20:22 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH 18/21] iommu/amd: Enable device ATS/PASID/PRI capabilities independently
Date: Wed, 12 Jul 2023 14:15:13 +0000
Message-ID: <20230712141516.154144-19-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230712141516.154144-1-vasant.hegde@amd.com>
References: <20230712141516.154144-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1NAM11FT077:EE_|IA1PR12MB7493:EE_
X-MS-Office365-Filtering-Correlation-Id: be588c2a-7196-46fe-2d64-08db82e322c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ERZ8zWk21JdVBhegouwp+7YJNsurRvUnjsU/s2kvgtX+pkgCBopx1iywnUBDG6YKEx/t5gI5teCNDWuXD4nsmUmH+zGRwpJ/YHyGfMrP17wmMmCrnWnxokURqoNbJuJ+qlfI3Ua2gggzkKLTeMK6LYJJ+zyxbelsULgJQILJQj/jTPFtTDY0FFtFPTgDtkEhNxAUBY2tB4/+s3n9Ddwkj10ZTRFoeWYINWI4VnK+F6pqDWZBBt6P60tR4R8qTcO5Q/L1S7MA1vqrm5JORoNiG+UchOZt6lASF5mwZXX4/aRsQCTAfci4T9Ws4qQ8a2hgxSg1yS9bLss4vXYGK/i4FjWCbd4tN3hBf5W4DjmrodtCMR6olY9jQUTs5KtLRp5D7KgphQNEg4hPEbMnNv44QT5O5UD73digbeUY1WmTZCj/t2ylJpneNQcvWFf1S45jCmXrKj1PlFaPRsr53UL93wcOm91GFcmjpVXPz7iVxXp+MuNIbCxul0gSNm20+OvkJf/0jencVaRHK3PqDdshJhR+StpLNnju/RyT3xg+7zd792lPKYB40bXuq/Zbuw2NHvvH/jVurWo25nWnnlsJBY/6GXw1GnzlfHBgyEZM+PvJxSDVBYy4pWeVZvOrdZWbCVlQqD3Yi+FLy/e0RSbTyQ8chLih8jtqWRd4fguLT2GyRQ7jrlysUnar5oLbidQ0Eboc1LANtGIOqrdMtBI8rDFHB2VeSWWiOa8vOD+x9E0NxyP8uBHCeEdd/IXzQq8dayDd/xZeo4HLmi6kfVDCFw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(346002)(376002)(136003)(451199021)(36840700001)(46966006)(40470700004)(7696005)(478600001)(6666004)(110136005)(54906003)(36860700001)(47076005)(426003)(336012)(2616005)(83380400001)(86362001)(36756003)(40460700003)(40480700001)(70206006)(2906002)(82310400005)(16526019)(186003)(26005)(1076003)(82740400003)(356005)(81166007)(8676002)(4326008)(41300700001)(316002)(70586007)(8936002)(5660300002)(44832011)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 14:20:25.2673
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: be588c2a-7196-46fe-2d64-08db82e322c1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1NAM11FT077.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7493

Introduce helper functions to enable/disable device ATS/PASID/PRI
capabilities independently along with the new pasid_enabled and
pri_enabled variables in struct iommu_dev_data to keep track,
which allows attach_device() and detach_device() to be simplified.

Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/amd_iommu.h       |   4 +
 drivers/iommu/amd/amd_iommu_types.h |   2 +
 drivers/iommu/amd/iommu.c           | 203 ++++++++++++++++------------
 3 files changed, 120 insertions(+), 89 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index 7773315e5adc..d9d531f2775f 100644
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
 int amd_iommu_v2_domain_init(struct protection_domain *pdom,
diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 15c129dbacab..64add3347a89 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -817,6 +817,8 @@ struct iommu_dev_data {
 	u32 flags;			  /* Holds AMD_IOMMU_DEVICE_FLAG_<*> */
 	int  ats_qdep;
 	bool ats_enabled;		  /* ATS state */
+	bool pri_enabled;		  /* PRI state */
+	bool pasid_enabled;		  /* PASID state */
 	bool pri_tlp;			  /* PASID TLB required for
 					     PPR completions */
 	bool use_vapic;			  /* Enable device to use vapic mode */
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 6c425aa521c7..e0fa27aedbc0 100644
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
@@ -1769,48 +1876,6 @@ static void do_detach(struct iommu_dev_data *dev_data)
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
@@ -1819,9 +1884,8 @@ static int attach_device(struct device *dev,
 			 struct protection_domain *domain)
 {
 	struct iommu_dev_data *dev_data;
-	struct pci_dev *pdev;
 	unsigned long flags;
-	int ret;
+	int ret = 0;
 
 	spin_lock_irqsave(&domain->lock, flags);
 
@@ -1829,45 +1893,13 @@ static int attach_device(struct device *dev,
 
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
-	if (domain->flags & PD_FLAG_GCR3) {
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
 
@@ -1915,15 +1947,8 @@ static void detach_device(struct device *dev)
 
 	do_detach(dev_data);
 
-	if (!dev_is_pci(dev))
-		goto out;
-
-	if (domain->flags & PD_FLAG_GCR3 && pdev_pasid_supported(dev_data))
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

