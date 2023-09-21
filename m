Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2063.outbound.protection.outlook.com [40.107.102.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 675A8944C
	for <iommu@lists.linux.dev>; Thu, 21 Sep 2023 09:33:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nEWUJFwVHbY76oBkAmu1BEFqNBz/lSknp0mxyxFJ3dcdSrNGKkgrcmyY1eagg6RKGnwDCkjDACmN8f9M3X5YXzWQs9AoAfmlPxV8AISMflFgRFn2Ip49bbGqSbVjrEXD50qYL9jvM0iIER6eNnZobnEd8TRcxw1ErhdS2zSQ5EQrq7hwtBBwNll4f8SNqDufMNY9GBntqn6bFjAf69qknOKY47x0sau6vDQR0jC50MBAOZ7YJ/e9zGqYevZBQC7PrD9wJv2CT3gKMglILjCsiXOUh5SFeuNKISfXM5xxC5TJ6/TuXfVjabrZG9XgjGbsasgCT1iDCiqrtylMl0Jjog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=alBElRUeaijMdmapa/mD1FiPHbfKcMstRl0pFuM6J+k=;
 b=eKu/gcf6qin/4Xpo/LRSZ5fRl2gzGWn1bAvLOlz5wvNRZhswVjo3Tb00mnJzPHBdjH62Xg+ZGqcFm2fYcxGqbnzu2wqEmnz3KMxBmj7jCz0nI+QjYufLVi0lmfyx5aGSIQ5+US7Auboc0PGMVq2E0/sX1f0QImwkyJxKnxFnIFaKesfn8bzJJDFvPSsG0hJZ08de9jQ/K2qTwTWVhdClO9yT60BqN3Y/Rl4PahHT5mEs8nYAPGUWttR+MU8i6LdbJAOfqUEqwfXzPS/5wJG/rrX2bS1OoRrWn6ivAkKpssFUqjrkb7kbmXRO/AoR3+UHdsIeRR+oQyaJfk7MOR/mxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=alBElRUeaijMdmapa/mD1FiPHbfKcMstRl0pFuM6J+k=;
 b=IyOUQG3RGSwvopgcLCSwlv1YOoK9AgHLyBJbfK9u9Eoz6q7nfT6ZUBJNiKcs1MkzRWXgq8nSmfmkiSlBxwoa2q7v8vFcZ+S2Fp56+51bydXZLx5x+BEHlkriAMWAJzMi39tmhvMTIjHUELxfhK9E3yWrLU2gyqmssOTjQITl8JQ=
Received: from DS7PR06CA0016.namprd06.prod.outlook.com (2603:10b6:8:2a::29) by
 PH8PR12MB6771.namprd12.prod.outlook.com (2603:10b6:510:1c6::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6768.34; Thu, 21 Sep 2023 09:33:04 +0000
Received: from DS2PEPF0000343C.namprd02.prod.outlook.com
 (2603:10b6:8:2a:cafe::1) by DS7PR06CA0016.outlook.office365.com
 (2603:10b6:8:2a::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.31 via Frontend
 Transport; Thu, 21 Sep 2023 09:33:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF0000343C.mail.protection.outlook.com (10.167.18.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.19 via Frontend Transport; Thu, 21 Sep 2023 09:33:03 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 21 Sep
 2023 04:32:59 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v3 3/5] iommu/amd: Remove amd_iommu_device_info()
Date: Thu, 21 Sep 2023 09:31:38 +0000
Message-ID: <20230921093140.6162-4-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230921093140.6162-1-vasant.hegde@amd.com>
References: <20230921093140.6162-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343C:EE_|PH8PR12MB6771:EE_
X-MS-Office365-Filtering-Correlation-Id: 21ab4cb3-504e-4fe0-1393-08dbba85c0e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	7/Z3op4NyYuWz6q6rWUP/sy04dTQxrTYgItSwRS7pWK2ox4cnbfNGgcC2BGogkNrqGisbvn9KCoav16cCE26YiwX+Q0YJSvshFImfawTvdAWr14N5djNnHtF6ViHCZjHd3oDFu/lxyeAz3Sy/uGusYHqAwt1n1ozwBAezHPG5sE+HXT4XKLmjyx/WP/3B70hg6lp2u7Z+u1Auup/BACbBwIJ40WgnhpRww0brF85YYa5TngWd/V/qZGVaOvLGTOj1IgfdvRApGoHamY1Jy9N1J/e3YCva4r31gvPclVAXIAmySOVxSQpw1vin3EQyZ5bw8JeQnmzXvwfN+Gz4XRNWOIiXKfzVwt06+f4afEuvgvS6Y5JLwsAy3rveJqfAVISVe2vJUZBmHR5hzBfl08a/8uiYVsrrgqFT2ZHZs6XVhiWdut1t1WTQuT/KlL1aIEQbvVXXPx8AFeQ8CNcnmB6YzRV9H1uYauSWCRGZndqLaIiyp5AtR0UmQby/5cA8nFpiBjlE5drjDpc+TKUwWZD+4ms15PMsud125E8VyCWIEcnbn/dwS6Zidg18JEy9n/WYFAZOt6YHDXv3b2jA0htY7sPsqwVsIh/dg9W/h3R1MwnivwtaFEBtZlkJJX5Q3ROHejl1P0zkgaChSKiBC6FE8ZWeykpNCVmRuNreKyX2FOZLJwswFQGz8pMyPKgO+s7sl/xcekCC6iwHgXKcT4Q/tmMZMbfthdJHPX0twUqCtrIOb3NpHgJX3Z5lHneB5rNxer3BZjZ7keYF5WSuI0VHw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(39860400002)(376002)(136003)(396003)(1800799009)(82310400011)(451199024)(186009)(36840700001)(46966006)(40470700004)(83380400001)(6666004)(81166007)(478600001)(336012)(426003)(47076005)(36860700001)(2616005)(40460700003)(26005)(1076003)(16526019)(8676002)(40480700001)(82740400003)(356005)(7696005)(2906002)(36756003)(4326008)(8936002)(5660300002)(70586007)(54906003)(70206006)(41300700001)(316002)(110136005)(44832011)(86362001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2023 09:33:03.1603
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 21ab4cb3-504e-4fe0-1393-08dbba85c0e0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF0000343C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6771

No one is using this function. Hence remove it. Also move PCI device
feature detection flags to amd_iommu_types.h as its only used inside
AMD IOMMU driver.

Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>
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
index 5abf181f5ecd..8f43d89a98db 100644
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

