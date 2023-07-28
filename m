Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2088.outbound.protection.outlook.com [40.107.212.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53E7A5696
	for <iommu@lists.linux.dev>; Fri, 28 Jul 2023 05:41:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aKrMhXYwQ+C3s2FlLx07vsxxaV/caLTIkprJakXnMGfZVvMmSgoi9Ku6sftVewqh7SzdgiJ3CwYjjrLgd9vNHx0TePgUFAeCUmjEOrCJDwNP4zlILwLlfxbAIHMkZFuMnCorJ4oqwmCGzsvsRo1q7Be0zyfbZ3u5WFk+X02/hT+eamoWJ+2Br0ygFmJgFAjAOOCUdCc/HvbkyPlYfQuljB8RGrqQ7srT4ahjgY8G6+/vM/37rPKQDtQt9UuZnWrXrfOXc5avpy0Xd4L2K4QQklt1TNFgzUpx/KWbBs+Ri1NQDYBJ7J/jM35ZxU0x8J2pK1eQfhRAvgJvOyxOjmJtKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fFkWyXANBTLlkqFo2d0FjF5iWKx1W3Xs5Fmp2gmDQkg=;
 b=MaSJoLtvsCKc/gUfDMO7o3GTICzQtT1o3VxracFGBLcuRu1oD4thVcgZ/cAJOphl7/5uds73NLjfmHsLKOjRKNRgy+8jH/auPOmMdtY2kSYMnxVH+1d7kOlLT3YD/46eD6kcRoCvbpMRgp8h+NY3CsabsdrIrgwwoZnJXybuI9BzDUup5roNxwsndu+UH7BmwpmZHs2WxnYET8aXByOS+xnpcNe663Pj+rJ2w4PtCETbaqwRXsHlBcG1+89Y7/Ku5XhMipAp3UAU1PJCQ4+hz4VZMgq9Zk6q7BTGAae2xyH098+4KTGywR413sct1hRZ0QHaYnvh/yTtYXg1bfJPGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fFkWyXANBTLlkqFo2d0FjF5iWKx1W3Xs5Fmp2gmDQkg=;
 b=AUuoj+v4JuI07HbfS5XTbfkNpef5TJ2CpI5pgZLqWTYH9yH3KHRS+FL/lujviDMDSgzPX6qQNu3Oa21HURWu325iGj9aVIgNqh3hRDgru+RHED3V0GtibyFq3wSKefrSmpbX4JlNeXku4+kPxTl52lw9E0CTh1/rC9CvR3xHz80=
Received: from BN9PR03CA0164.namprd03.prod.outlook.com (2603:10b6:408:f4::19)
 by DS0PR12MB8444.namprd12.prod.outlook.com (2603:10b6:8:128::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.31; Fri, 28 Jul
 2023 05:41:10 +0000
Received: from BN8NAM11FT087.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f4:cafe::bd) by BN9PR03CA0164.outlook.office365.com
 (2603:10b6:408:f4::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29 via Frontend
 Transport; Fri, 28 Jul 2023 05:41:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT087.mail.protection.outlook.com (10.13.177.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6631.29 via Frontend Transport; Fri, 28 Jul 2023 05:41:10 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 28 Jul
 2023 00:41:07 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v2 16/16] iommu/amd: Simplify amd_iommu_device_info()
Date: Fri, 28 Jul 2023 05:36:09 +0000
Message-ID: <20230728053609.165183-17-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN8NAM11FT087:EE_|DS0PR12MB8444:EE_
X-MS-Office365-Filtering-Correlation-Id: a9fe9f21-0fb4-46c0-8bd4-08db8f2d3f7d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	0tY9iURRnMDMdI3asbTg+GSHVmELzDBXAi56l7A833VBelaOgGK3tgyfAg0POJsAT/OZIyU10rANaOvN5cJKtF2K+QG78eNii3d/NG6RtanUp+EC9Mn0LzwMIY143JrsdKtjSTNWnq9uJZD51vw0nGNNwoAbkwwTHK/3YTpDQKgmnXo7zefkqcARIitsMn42/gQA3Xm5fmFY6CsAYami8DNzpCMkaw68IA1kNJoCGxW5PhRCH7+PbZObyCymGY5Wyt3pgkNauyqfDga2Py++CfVw6SApuh+McIVKFu7ADPiz77GYiw/lH6Xilm16jxEJMYWCySmx12BmpH/G/qqz5MmjBn+ZSpYVFrcKk+RfsK1yB6NnKsihPlzT9+Cf+We9xUh2efuQJj5oCPFV11GrbTSQF/zHp6fjMtz4+Dy2QoX8gm93jBmXcl7ScsyZQf+hlEtEB5eUuQ3jsjp5FxPWgQMbaob+/VOvbpddIWTzjtaAkCQ+LF7YF8HicqjgEbkG519Y/59vgtnuiKSuAOmx5KP6weQE0NmiwbW/W599IhscdoDHSf38rSda9LP0yrADRk7WKZl2kGDc5FFrOnSR91PqiMD69o71GTVOweUzbbXvN3g5N6GzSvSGENYx04D69k4KCcJY7LcN5y1Xy3zcI6ifzIedh7/XEbW4QoayfJBVTBFv1CR1iwNwQlK9xBtnfUmi1F4WBMy5AouJQ/o6Xal9bbLP3QzjUix0HvXjjSLxSwNRK9r05I8B4cJM6lym2jc2PGVBMYjxxiEznX3WYQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(136003)(346002)(376002)(82310400008)(451199021)(46966006)(36840700001)(40470700004)(86362001)(82740400003)(40480700001)(356005)(40460700003)(81166007)(316002)(70586007)(54906003)(4326008)(478600001)(110136005)(41300700001)(7696005)(44832011)(16526019)(8676002)(8936002)(5660300002)(26005)(2906002)(70206006)(336012)(1076003)(186003)(36756003)(83380400001)(47076005)(426003)(36860700001)(2616005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2023 05:41:10.4081
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a9fe9f21-0fb4-46c0-8bd4-08db8f2d3f7d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN8NAM11FT087.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8444

Let 'iommu_dev_data.flags' track device exec and priv support as well.
So that in amd_iommu_device_info() we don't need to check device
capabilities again.

Also in probe path __iommu_probe_device() updates dev->iommu->max_pasids.
Just use that instead of calculating max PASIDs again

Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/iommu.c | 41 ++++++++++++++-------------------------
 1 file changed, 15 insertions(+), 26 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 3b20d4d97192..54ee5a07f589 100644
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
 
@@ -2806,8 +2815,8 @@ EXPORT_SYMBOL(amd_iommu_complete_ppr);
 int amd_iommu_device_info(struct pci_dev *pdev,
                           struct amd_iommu_device_info *info)
 {
-	int max_pasids;
-	int pos;
+	struct device *dev = &pdev->dev;
+	struct iommu_dev_data *dev_data = dev_iommu_priv_get(dev);
 
 	if (pdev == NULL || info == NULL)
 		return -EINVAL;
@@ -2817,29 +2826,9 @@ int amd_iommu_device_info(struct pci_dev *pdev,
 
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

