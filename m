Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2081.outbound.protection.outlook.com [40.107.243.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEAC04C6A
	for <iommu@lists.linux.dev>; Mon, 21 Aug 2023 10:51:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iIJmkx1LJ2AVCK2YwkUZ8aPO8Zsg4WY+/+cNTlBxLRCR96lA9vr0F7u2d7ApM+DjHhMuaMg/f/RyesXWUfjmtobhG5n6Ur9RVcy5hQYc5dq8bVIbgVHXZwFC3HHvo3L08J1cUFJR/hBgxysLNMCO2zYW870MUJGtlMIv4jVQAUCke8DnGWUeMreayplBaqwir3xMU2r0E/dwQ82t+W+3NOmt2QQQ0Sn1dRbA2he7GuwFMQ+0nSTTTCT0lQRva1KBuLEQOPhp/H1iGAlBfVvVH2xzTfDE+Y3Wv9gv0EIVJ7qLbGyPpdkCoiztorEVVPaydxVS5kSBTenfTx8x4EFLTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xuWJRm7DuPlm31s8yXdfdwimq8WaZ+tF+UyrlovYUcE=;
 b=RRC1Eaele5CPXqqZl7dLY+63k/FYLXfcFe/znCRCEChyr8aH8rhtSc/8J0OgbAEX9YYD9XxNbQ7Fj9mf09Seyk0viD1puhI+b26CU0heYyG/z0PCs4+K7dKFEVSRq6/JF48W/zJWm0zJ6VXuMDFqjbDC7aU+AOc4GD69fjfoJLpMonXMn28FbY+WnarzpZCNgjnFRYic4sTvg+LpKVXnrxS3PHwllPw2uAG2Ib1K8JO7/LZntyXecWfbVL3AoB8QzRAFOwasoqoPRJzi/Y3V7g4r/zNhvgzLqICxQmJzV38nGDSrV0U+F1SpZa+p93HY7fVKmGLTeZtJa7ycz00okQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xuWJRm7DuPlm31s8yXdfdwimq8WaZ+tF+UyrlovYUcE=;
 b=dN7rAleIAC61vQ5nJ1M+bpxieXKaLN0QYnm57CVMOrTW2jQx1kjuk02ox2Ln+QexVpu6PMaAWhyE86CaJFTqeGqEc31oyFb6Y1+qIG2TrstCCVpIq61TehHwOj/AoW0NHjVh52uYHowynrjw8dw2YeT03xIvlAfTWTXW392VXtQ=
Received: from MW3PR05CA0013.namprd05.prod.outlook.com (2603:10b6:303:2b::18)
 by IA1PR12MB6281.namprd12.prod.outlook.com (2603:10b6:208:3e7::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20; Mon, 21 Aug
 2023 10:51:17 +0000
Received: from CO1PEPF000044F3.namprd05.prod.outlook.com
 (2603:10b6:303:2b:cafe::44) by MW3PR05CA0013.outlook.office365.com
 (2603:10b6:303:2b::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.14 via Frontend
 Transport; Mon, 21 Aug 2023 10:51:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F3.mail.protection.outlook.com (10.167.241.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.14 via Frontend Transport; Mon, 21 Aug 2023 10:51:16 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 21 Aug
 2023 05:51:12 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v2 3/5] iommu/amd: Remove amd_iommu_device_info()
Date: Mon, 21 Aug 2023 10:49:54 +0000
Message-ID: <20230821104956.707235-4-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230821104956.707235-1-vasant.hegde@amd.com>
References: <20230821104956.707235-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F3:EE_|IA1PR12MB6281:EE_
X-MS-Office365-Filtering-Correlation-Id: 83b05f60-7581-4883-e6e8-08dba2348b8e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	2LxsVpRXBGzVcRqCF02Ff1vxV1qXsguzA4r9lGjjrndhXTupTvhbCn09WB9yHRqwT+2rpR+4MOPU2wde6M3NbWINmcTKRTJUTe+JTBNOhjhxGxYB74TpZFk9h+TXb9c9mWMJoS2KQlAObtx1PLQ2+QGKwq7yJIm9b7SSuEH5+v4A4Eul6pp1gnpmpIcKkZgqTfa2GSCa2hXsJobWfm/APfwuyhCOlX9ywewbN6kzpLywPnQRawjydH0H5P4uL+MRn+Rl3gxXN+S7YVUiQWtMOwHCMFNY3/VFoyNRQyJ0T8xFeDvLhzXvSu2xrPnNQfYywXqWmq50p01iqBpC1vKA9ChBPejxYj1qcIFtOOFuYnOsQ5WVvRTYjb41cMcGKibPioHoUg0sFPVJj7nh3isA2N1vQlvzKeNYWSrVzFXROFaefiNe/XKin/jyHI7MPvlV31TdoDDpKOkpnr+B8hEIpmxrL92MuU7BWPb7keuav7hEbUntsW3fG2O5kRRYDmQzlbOPsB7ow+vFXdDozFBv60fsQmHvmcXT+fCJ2IlQN/GQ4a14zHC4QCJmwCqFi68cJArOuDy4IC+C1xNBoauMn+WhzUaTT8FAVa3BQZr9BF1Cp/CRySYuyuBEc35yLsJbAWFOa/GmQ3x3UZmrfO48i2V/fbNTNLCjSCwnSo4tRQtQLuhrrG5hWPv6lOZJXEM7rTcNgsApUxoMp8lL3gWklGcO4gLvMq936u/fr2MAmI52FUhguX4l1F4CIN6sVveUxcZQiF1bmOa2weagwgDgCA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(346002)(136003)(39860400002)(396003)(82310400011)(451199024)(186009)(1800799009)(36840700001)(40470700004)(46966006)(2906002)(83380400001)(7696005)(40480700001)(5660300002)(44832011)(336012)(426003)(16526019)(26005)(86362001)(36860700001)(47076005)(8676002)(2616005)(8936002)(4326008)(70206006)(316002)(54906003)(70586007)(110136005)(478600001)(82740400003)(356005)(81166007)(6666004)(40460700003)(41300700001)(36756003)(1076003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2023 10:51:16.5048
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 83b05f60-7581-4883-e6e8-08dba2348b8e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6281

No one is using this function. Hence remove it. Also move PCI device
feature detection flags to amd_iommu_types.h as its only used inside
AMD IOMMU driver.

Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/amd_iommu_types.h |  8 ++++++
 drivers/iommu/amd/iommu.c           | 42 -----------------------------
 include/linux/amd-iommu.h           | 26 ------------------
 3 files changed, 8 insertions(+), 68 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 25b731f3d984..e742006f2885 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -786,6 +786,14 @@ struct devid_map {
 	bool cmd_line;
 };
 
+#define AMD_IOMMU_DEVICE_FLAG_ATS_SUP     0x1    /* ATS feature supported */
+#define AMD_IOMMU_DEVICE_FLAG_PRI_SUP     0x2    /* PRI feature supported */
+#define AMD_IOMMU_DEVICE_FLAG_PASID_SUP   0x4    /* PASID context supported */
+/* Device may request execution on memory pages */
+#define AMD_IOMMU_DEVICE_FLAG_EXEC_SUP    0x8
+/* Device may request super-user privileges */
+#define AMD_IOMMU_DEVICE_FLAG_PRIV_SUP   0x10
+
 /*
  * This struct contains device specific data for the IOMMU
  */
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 2becbd0529cd..fdb5b1362ba0 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2741,48 +2741,6 @@ int amd_iommu_complete_ppr(struct pci_dev *pdev, u32 pasid,
 }
 EXPORT_SYMBOL(amd_iommu_complete_ppr);
 
-int amd_iommu_device_info(struct pci_dev *pdev,
-                          struct amd_iommu_device_info *info)
-{
-	int max_pasids;
-	int pos;
-
-	if (pdev == NULL || info == NULL)
-		return -EINVAL;
-
-	if (!amd_iommu_v2_supported())
-		return -EINVAL;
-
-	memset(info, 0, sizeof(*info));
-
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
-
-	return 0;
-}
-EXPORT_SYMBOL(amd_iommu_device_info);
-
 #ifdef CONFIG_IRQ_REMAP
 
 /*****************************************************************************
diff --git a/include/linux/amd-iommu.h b/include/linux/amd-iommu.h
index 35ca00b09384..dc7ed2f46886 100644
--- a/include/linux/amd-iommu.h
+++ b/include/linux/amd-iommu.h
@@ -33,32 +33,6 @@ struct pci_dev;
 
 extern int amd_iommu_detect(void);
 
-/**
- * amd_iommu_device_info() - Get information about IOMMUv2 support of a
- *			     PCI device
- * @pdev: PCI device to query information from
- * @info: A pointer to an amd_iommu_device_info structure which will contain
- *	  the information about the PCI device
- *
- * Returns 0 on success, negative value on error
- */
-
-#define AMD_IOMMU_DEVICE_FLAG_ATS_SUP     0x1    /* ATS feature supported */
-#define AMD_IOMMU_DEVICE_FLAG_PRI_SUP     0x2    /* PRI feature supported */
-#define AMD_IOMMU_DEVICE_FLAG_PASID_SUP   0x4    /* PASID context supported */
-#define AMD_IOMMU_DEVICE_FLAG_EXEC_SUP    0x8    /* Device may request execution
-						    on memory pages */
-#define AMD_IOMMU_DEVICE_FLAG_PRIV_SUP   0x10    /* Device may request
-						    super-user privileges */
-
-struct amd_iommu_device_info {
-	int max_pasids;
-	u32 flags;
-};
-
-extern int amd_iommu_device_info(struct pci_dev *pdev,
-				 struct amd_iommu_device_info *info);
-
 #else /* CONFIG_AMD_IOMMU */
 
 static inline int amd_iommu_detect(void) { return -ENODEV; }
-- 
2.31.1

