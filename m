Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2083.outbound.protection.outlook.com [40.107.96.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 195EB10788
	for <iommu@lists.linux.dev>; Tue, 15 Aug 2023 10:26:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DdOTX1qWjDixiWov3D1+iPVLw2rUy+wHyb9FHiQfDd1wqC0LUyCxSmPDLGNsOXiK/E82j5S3iKh1W+Jclni586HxRWsZBbrqB/Vebp2qyC7Y/RdYXs10cmBxOK2WLKHVBpqVx6uiVtI76h1Bvr8wgN89ojfdc2aVgHDr24nCIslQxzukJxI1/JwgT/g18YHPEysPjPQhPMx8lP/qwfSx8SJWDnHXp4Boj52Hi9eWHbtjho3wVBW6ALp7e1ZH1rvRxKdD2//TxvfRfd+9XFsgHDEy8NjTTyuqnICNUV/uw30FbeuG3AEAjQjFKe7GoRaxasFfZU4O5WORszH/E7rH+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8t1Ie/FiAaSgp5lm1kppS0stPVM+KuRZWXX3Ab2qUtI=;
 b=g3HYvTi7i9Q7a3Zcx5snqM38IV8xQk80AqEARcHp8L3ArTzKdUNOxhiqIesmLg4xZ/xtYWAfu6KQC/rKO5QpRohYFgwPaDsH7fhnqVoIJy1Yw6Xdgfivd1hVOdG6zBXTcezJ5vnyi/+kdyq8HaywABwEAHHMjEDCG+Pw/Zr4m/FJmrJe4rnAt6TDHsadYQ7pkUomT7yvPf5RdzruI4aoIGdvKM1EcuWKD4MInAkCw0UO5n1wR1Ehl9JGDn07HFj+Apl+k+NlBjEH+4wCj3pAhJHEaR2GPpER6O7BR1ipuvR08eMKTAP8wasscBlrILsYyuq9aL8K7xpbEq6XldvkGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8t1Ie/FiAaSgp5lm1kppS0stPVM+KuRZWXX3Ab2qUtI=;
 b=zOYpUSfVcZNtEt9OJhiHGO08OPNH9fLvI9XJViriMNgzn9dOPHC9lLwq76JFVqtTh2GIRzNBPxCcXXXPyRAeqLwv1Gq39ypfApsyBJdebHwJGUdpjv/iNqfs3+yxu0IDhWVIA4PKpdYOaprwmmKphSk+1c8hWazJjLSizDVhOKA=
Received: from MW4PR03CA0104.namprd03.prod.outlook.com (2603:10b6:303:b7::19)
 by IA1PR12MB6211.namprd12.prod.outlook.com (2603:10b6:208:3e5::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Tue, 15 Aug
 2023 10:26:09 +0000
Received: from CO1PEPF000044F9.namprd21.prod.outlook.com
 (2603:10b6:303:b7:cafe::70) by MW4PR03CA0104.outlook.office365.com
 (2603:10b6:303:b7::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.33 via Frontend
 Transport; Tue, 15 Aug 2023 10:26:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F9.mail.protection.outlook.com (10.167.241.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6723.3 via Frontend Transport; Tue, 15 Aug 2023 10:26:08 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 15 Aug
 2023 05:26:05 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v4 12/14] iommu/amd: Introduce iommu_dev_data.flags to track device capabilities
Date: Tue, 15 Aug 2023 10:22:00 +0000
Message-ID: <20230815102202.565012-13-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F9:EE_|IA1PR12MB6211:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d394dcc-eb04-4dff-6257-08db9d7a0a57
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	OOOIZknSGyIrAbNB+FlMBmSru8EbDMRqvw3zACWnua26EyiHn1fmGnMKq6B4oc3aqMSqrh6BKhrscLW5wlnEa+QjB7I2xwnUsY0Uc8L6mVQROImZga81Qn+ErPsrlZT07xB+TxFd2bRztoXf383PtQQAwbU/pFfRnTtF+aa68+mazGW5U5Oowbs2KF/hfficbaPaPoFBPNXOFGV1pGLl1rOxNaMBSflNlk9xf5gvnSAMR3ftLckrJVzVfpBPbbyxQP6U3RMWd7pW35AeiEhMI7/I9o8IHDwWmrJGBrP/Qir9L01WU1nhStthi1bOkljOMo/UR6sW6+4xllSLLrfqHMRbhMxR/7DBgIbucLtDNMXHaOGfRMROuWDIhVTRmL1XGVT9OYwSay2omiw608jwYq/LFJHL4U/jQ6mYgN+kZwWh7eG5x9iQj+/HUUHek3kZ0EHJW6omXW8h4QbOUvwdZ4PoFYx3Lacoi9y8i0MI8wngo59hzJkhqvdbLytSw9Ht+4dJENOVpZHZLbh6MVExQL0gSFKC8oIu2N74AeTlhvE04wxMMfH8DzCxsqwTGlaBRwwduQBeNgG8KFuLV2FV5kRhYoC+Vz7dNZ9PCQNmR9gelsEGIG7es8iG2Fqx4Eetf9YXwvBNcjGT5S26KvHABcbw3Km2pZ7st3xUy7zptqe+n33jBDrxfHn9n6+/0HRPBETg1uQFy1ru19nc8dnvF5OMJ5npJfka0VVsVsFaIDM8bcrBOtpWFfiwbv4j1jrFN3dPO1QSP2QHg4dk52sSKA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(346002)(396003)(376002)(451199021)(82310400008)(186006)(1800799006)(46966006)(40470700004)(36840700001)(40460700003)(336012)(426003)(16526019)(1076003)(26005)(83380400001)(36860700001)(47076005)(7696005)(41300700001)(54906003)(2616005)(70206006)(70586007)(316002)(5660300002)(44832011)(8676002)(8936002)(4326008)(2906002)(6666004)(110136005)(478600001)(40480700001)(356005)(81166007)(82740400003)(86362001)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2023 10:26:08.6564
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d394dcc-eb04-4dff-6257-08db9d7a0a57
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F9.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6211

Currently we use struct iommu_dev_data.iommu_v2 to keep track of the device
ATS, PRI, and PASID capabilities. But these capabilities can be enabled
independently (except PRI requires ATS support). Hence, replace
the iommu_v2 variable with a flags variable, which keep track of the device
capabilities.

From commit 9bf49e36d718 ("PCI/ATS: Handle sharing of PF PRI Capability
with all VFs"), device PRI/PASID is shared between PF and any associated
VFs. Hence use pci_pri_supported() and pci_pasid_features() instead of
pci_find_ext_capability() to check device PRI/PASID support.

Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/amd_iommu_types.h |  3 +-
 drivers/iommu/amd/iommu.c           | 46 ++++++++++++++++++-----------
 2 files changed, 30 insertions(+), 19 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index c9027119ab35..c93f9482d3c1 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -811,7 +811,8 @@ struct iommu_dev_data {
 	struct protection_domain *domain; /* Domain the device is bound to */
 	struct device *dev;
 	u16 devid;			  /* PCI Device ID */
-	bool iommu_v2;			  /* Device can make use of IOMMUv2 */
+
+	u32 flags;			  /* Holds AMD_IOMMU_DEVICE_FLAG_<*> */
 	int ats_qdep;
 	u8 ats_enabled  :1;		  /* ATS state */
 	u8 pri_tlp      :1;		  /* PASID TLB required for
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 9163e3a9aab9..b1a99b7d1956 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -319,24 +319,34 @@ static struct iommu_group *acpihid_device_group(struct device *dev)
 	return entry->group;
 }
 
-static bool pci_iommuv2_capable(struct pci_dev *pdev)
+static inline bool pdev_pasid_supported(struct iommu_dev_data *dev_data)
 {
-	static const int caps[] = {
-		PCI_EXT_CAP_ID_PRI,
-		PCI_EXT_CAP_ID_PASID,
-	};
-	int i, pos;
+	return (dev_data->flags & AMD_IOMMU_DEVICE_FLAG_PASID_SUP);
+}
 
-	if (!pci_ats_supported(pdev))
-		return false;
+static u32 pdev_get_caps(struct pci_dev *pdev)
+{
+	int features;
+	u32 flags = 0;
+
+	if (pci_ats_supported(pdev))
+		flags |= AMD_IOMMU_DEVICE_FLAG_ATS_SUP;
+
+	if (pci_pri_supported(pdev))
+		flags |= AMD_IOMMU_DEVICE_FLAG_PRI_SUP;
 
-	for (i = 0; i < 2; ++i) {
-		pos = pci_find_ext_capability(pdev, caps[i]);
-		if (pos == 0)
-			return false;
+	features = pci_pasid_features(pdev);
+	if (features >= 0) {
+		flags |= AMD_IOMMU_DEVICE_FLAG_PASID_SUP;
+
+		if (features & PCI_PASID_CAP_EXEC)
+			flags |= AMD_IOMMU_DEVICE_FLAG_EXEC_SUP;
+
+		if (features & PCI_PASID_CAP_PRIV)
+			flags |= AMD_IOMMU_DEVICE_FLAG_PRIV_SUP;
 	}
 
-	return true;
+	return flags;
 }
 
 /*
@@ -396,8 +406,8 @@ static int iommu_init_device(struct amd_iommu *iommu, struct device *dev)
 	 * it'll be forced to go into translation mode.
 	 */
 	if ((iommu_default_passthrough() || !amd_iommu_force_isolation) &&
-	    dev_is_pci(dev) && pci_iommuv2_capable(to_pci_dev(dev))) {
-		dev_data->iommu_v2 = amd_iommu_gt_ppr_supported();
+	    dev_is_pci(dev) && amd_iommu_gt_ppr_supported()) {
+		dev_data->flags = pdev_get_caps(to_pci_dev(dev));
 	}
 
 	dev_iommu_priv_set(dev, dev_data);
@@ -1850,7 +1860,7 @@ static int attach_device(struct device *dev,
 			goto out;
 		}
 
-		if (dev_data->iommu_v2) {
+		if (pdev_pasid_supported(dev_data)) {
 			if (pdev_pri_ats_enable(pdev) != 0)
 				goto out;
 
@@ -1916,7 +1926,7 @@ static void detach_device(struct device *dev)
 	if (!dev_is_pci(dev))
 		goto out;
 
-	if (domain->flags & PD_IOMMUV2_MASK && dev_data->iommu_v2)
+	if (domain->flags & PD_IOMMUV2_MASK && pdev_pasid_supported(dev_data))
 		pdev_iommuv2_disable(to_pci_dev(dev));
 	else if (dev_data->ats_enabled)
 		pci_disable_ats(to_pci_dev(dev));
@@ -2471,7 +2481,7 @@ static int amd_iommu_def_domain_type(struct device *dev)
 	 *    and require remapping.
 	 *  - SNP is enabled, because it prohibits DTE[Mode]=0.
 	 */
-	if (dev_data->iommu_v2 &&
+	if (pdev_pasid_supported(dev_data) &&
 	    !cc_platform_has(CC_ATTR_MEM_ENCRYPT) &&
 	    !amd_iommu_snp_en) {
 		return IOMMU_DOMAIN_IDENTITY;
-- 
2.31.1

