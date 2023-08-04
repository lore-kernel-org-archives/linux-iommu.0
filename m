Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2046.outbound.protection.outlook.com [40.107.223.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B06F11FC8
	for <iommu@lists.linux.dev>; Fri,  4 Aug 2023 06:47:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CU/sNSj8J5qR/RMYUHKbxLl4X/8X9+7e5at9NQRGCn1cVQ8f8EgHaZJVw8eu0ZpArg4bTroNRAdCcnlWjzqIyV3JTZGlLp9h1IhmA1Xn8B20P1pzyQjuu2+fmH/8396kv6+2szhE7i2BxF3yuk56J3naKKaLnEK5gndAjp/drCakRj3RMRzwP6Do+HxJnI2ytfvUvHhhccYm0FLUmHLTEu1edqIM+YhDeboGvuqH3U54Ah24uaRcRbpD/D78dHsti3luIPcm4Bu2p2PuGUI75eaxWbZYv+LZVYUtekVaaPG8xAmhZpTKY2LZTRWoO0xy27TTF8m2yMFHHgLoRi0b5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2dvcSVC1AeQA3Z+wtZFEdmCv2dRp7PbrGU8gfJuHz8A=;
 b=hOmyofuMIJUvuJi/VZOCEBIrmudRzaFuKwMUuQ8Zfai5EsErcq9GPJhqTeawjQpfVD6iQKzAiEKihs5pcq9LLarB0CoK5W982OXcKPXJZ6esz7FAmVtmdT816WvlBTVDy2sfRVfsTO4rPnPHROtp+wVQSTdHQxFndsJvcHUEmyWK4FHq8DFmJNoplraZHafIY3bRvhISniqtQoZN0PdkxZioDFkH5+elXW+yJrH3fdAiBsnpphU4k/SpdOC47suq0plMQ0bFsAHxUoT/SDDz7/HuU8mHkGCp6m0X+IMd6i0AFkygW7zxqouom0YfQaPrSnUzPIYzoGFN/kAVa3V0+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2dvcSVC1AeQA3Z+wtZFEdmCv2dRp7PbrGU8gfJuHz8A=;
 b=pnO3mQrm+R7T2H4kN5FlVoEUu9yXis2HCKGBhLJHUL4ckLX8jxh2xOC9lw/io5ZeEMoDaKRjAF2tUd0cNe9ZyC9n55mXTYyAdwxyrnXOZc+uFEO3dhaI8lWAu4KKuBNsvDEKBc4dkOQHAs4JklK7OsiCS83UNlHrtXQ2AHo4vaw=
Received: from CY8PR02CA0015.namprd02.prod.outlook.com (2603:10b6:930:4d::18)
 by IA0PR12MB9046.namprd12.prod.outlook.com (2603:10b6:208:405::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.21; Fri, 4 Aug
 2023 06:47:32 +0000
Received: from CY4PEPF0000EE35.namprd05.prod.outlook.com
 (2603:10b6:930:4d:cafe::ad) by CY8PR02CA0015.outlook.office365.com
 (2603:10b6:930:4d::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.21 via Frontend
 Transport; Fri, 4 Aug 2023 06:47:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE35.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.19 via Frontend Transport; Fri, 4 Aug 2023 06:47:32 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 4 Aug
 2023 01:47:28 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v3 16/16] iommu/amd: Simplify amd_iommu_device_info()
Date: Fri, 4 Aug 2023 06:42:16 +0000
Message-ID: <20230804064216.835544-17-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE35:EE_|IA0PR12MB9046:EE_
X-MS-Office365-Filtering-Correlation-Id: 176b0238-a905-48ee-e759-08db94b6adc2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	cSv6kzBYRSurL5WHIzeAE4Qgd/eEjAJiTsntnz6gkFHWrOz7tEBNB2Mt79UeQgh5OXb4dA7U3UjIsGjSXobvLKgijdqY6rJs3QCff+apKxABk7yH2m98jA+7AxdXPm2j3wPd1LroX24X+80IGHmPBuItLYJwrNdV0a0LByK2N5ZDEdx5iAlrxGdquGLfvLZ4NNtAKAvEtDXL6/Txki354Eqcye5VaqncRMcma9/ycU3f85SEQFFEmdxA93Q02wnLFMeZf5M5Z7u3O0An57Fybyx5FD4d4BwoRKrvj76yKHsa6DQoS0CFxl6fktjLdyemkCGPihXEz9KZtCn5XsNA0CnVGaL/Nf/vH5U6UpKTchsMxDdOfczHxEFF/kmcHzki1a/F24mJOkm/X2/4VIoX5MQHj8cw/5bV7Z19+uU9DHJx3cWGhlkKDTJXfzqQI22zD26FKb6AJ7UJXqCph+WF0+zfDc/8B2iHuGG+mDNUFwMgeJpGafO3Cy5YZU5bEonU9pr2X/jRJMB4FamVv/sfSi3lxSvKZ5w6GjW++fL5ofkwgcQIXLHGpTjm54miyTC9T5SV5ijmETlQAkYrkiUZMkDUIjY76oxFq88mhOFAED9/tCJWXQq3q6LDemRSDZakrXAejgPsUmNPMn70c6famwdkekgBJ1jtZoz4pomOn8A+zaYGjz/hcNfXhJmYWFoqOMaCcSnTx9bL6/3rpY8wEfCZamH/VEbqwqg8GM/tieDKe8BL8EubDU9dtK3uY465TgE3CbXpgna+CGBw9hgj7g==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(39860400002)(376002)(346002)(1800799003)(186006)(82310400008)(451199021)(46966006)(36840700001)(40470700004)(2906002)(40460700003)(44832011)(426003)(36756003)(2616005)(16526019)(47076005)(83380400001)(40480700001)(26005)(1076003)(86362001)(336012)(70206006)(70586007)(4326008)(316002)(41300700001)(7696005)(82740400003)(356005)(81166007)(54906003)(110136005)(478600001)(6666004)(8676002)(8936002)(5660300002)(36860700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2023 06:47:32.2309
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 176b0238-a905-48ee-e759-08db94b6adc2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE35.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB9046

Let 'iommu_dev_data.flags' track device exec and priv support as well.
So that in amd_iommu_device_info() we don't need to check device
capabilities again.

Also in probe path __iommu_probe_device() updates dev->iommu->max_pasids.
Just use that instead of calculating max PASIDs again

Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/amd/iommu.c | 41 ++++++++++++++-------------------------
 1 file changed, 15 insertions(+), 26 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 208d69e7a6b4..3c91b68ca8eb 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -321,6 +321,7 @@ static inline bool pdev_pasid_supported(struct iommu_dev_data *dev_data)
 
 static u32 pdev_get_caps(struct pci_dev *pdev)
 {
+	int features;
 	u32 flags = 0;
 
 	if (pci_ats_supported(pdev))
@@ -329,9 +330,17 @@ static u32 pdev_get_caps(struct pci_dev *pdev)
 	if (pci_pri_supported(pdev))
 		flags |= AMD_IOMMU_DEVICE_FLAG_PRI_SUP;
 
-	if (pci_pasid_features(pdev) >= 0)
+	features = pci_pasid_features(pdev);
+	if (features >= 0) {
 		flags |= AMD_IOMMU_DEVICE_FLAG_PASID_SUP;
 
+		if (features & PCI_PASID_CAP_EXEC)
+			flags |= AMD_IOMMU_DEVICE_FLAG_EXEC_SUP;
+
+		if (features & PCI_PASID_CAP_PRIV)
+			flags |= AMD_IOMMU_DEVICE_FLAG_PRIV_SUP;
+	}
+
 	return flags;
 }
 
@@ -2809,8 +2818,8 @@ EXPORT_SYMBOL(amd_iommu_complete_ppr);
 int amd_iommu_device_info(struct pci_dev *pdev,
                           struct amd_iommu_device_info *info)
 {
-	int max_pasids;
-	int pos;
+	struct device *dev = &pdev->dev;
+	struct iommu_dev_data *dev_data = dev_iommu_priv_get(dev);
 
 	if (pdev == NULL || info == NULL)
 		return -EINVAL;
@@ -2820,29 +2829,9 @@ int amd_iommu_device_info(struct pci_dev *pdev,
 
 	memset(info, 0, sizeof(*info));
 
-	if (pci_ats_supported(pdev))
-		info->flags |= AMD_IOMMU_DEVICE_FLAG_ATS_SUP;
-
-	pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_PRI);
-	if (pos)
-		info->flags |= AMD_IOMMU_DEVICE_FLAG_PRI_SUP;
-
-	pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_PASID);
-	if (pos) {
-		int features;
-
-		max_pasids = 1 << (9 * (amd_iommu_max_glx_val + 1));
-		max_pasids = min(max_pasids, (1 << 20));
-
-		info->flags |= AMD_IOMMU_DEVICE_FLAG_PASID_SUP;
-		info->max_pasids = min(pci_max_pasids(pdev), max_pasids);
-
-		features = pci_pasid_features(pdev);
-		if (features & PCI_PASID_CAP_EXEC)
-			info->flags |= AMD_IOMMU_DEVICE_FLAG_EXEC_SUP;
-		if (features & PCI_PASID_CAP_PRIV)
-			info->flags |= AMD_IOMMU_DEVICE_FLAG_PRIV_SUP;
-	}
+	info->flags = dev_data->flags;
+	if (dev->iommu)
+		info->max_pasids = dev->iommu->max_pasids;
 
 	return 0;
 }
-- 
2.31.1

