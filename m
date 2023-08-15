Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2076.outbound.protection.outlook.com [40.107.94.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15D0F3C1D
	for <iommu@lists.linux.dev>; Tue, 15 Aug 2023 10:34:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EZCwWsuedMo+9HKvGavSzVI2K3bsHUN7s58q2HYk9fQELIceMn55ezz8Js7MpC/CDdV03bKK/xX6RlUgNJZOF0F4RFQIBZ5TUJEAw0eP0L03E33qyy1nQZ6Q+avY96BPMZPbY0H56Wlsk++uLlgokdIeKXp7tHv94xgU84yxdYJSeOmrEF2a/6sJv8Kn8AY/NxnXj+06wrhT95eWz2gPJfBq6tMU8705Nv2DBHzftXujyZBJJKm6EDe2Nuzd4nm17g57bqK5wLyvM2xOTgLuwQC4tLEOb9trONAcNNDnRW3Y1fSSWX8cgnCVaX4FjtBxZ7UWfnK8AAKsEPJDJDsr+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oh+1jXAr46/ZQhMDk6Ou6Lm5bDUMh/uY52H1QO1Y0iM=;
 b=K3E3wr8umEiDR34SrRSY6KVbmSMS4zulSfUlvHZGt6r97LOtLBVVNlhbXcxmjKisgeUNmQ59IIbcT36vWd830EAMNwgxiUhNPub6jjTO80nyteCRNu+4n/6yhUcIlmVt3WxZs7BJku45guggaa6lciJ44q2jI1auxd1S1fGKnCvXE7tFuaq4KY1tKCvTKqEVlQUhNDfO5O3M5KQvoYzMGdHxt5kbN65z0IRfoEXt2fh84KysiO9D67WlOUmk3lRjkgjgFhxpqX1iiM6DpPlh4Ez0ERKK6MHVx7KyJM969BYZDoeh1YrPm3mRNcg6kUTiRFCQPXcuWcTX7QxybtpqJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oh+1jXAr46/ZQhMDk6Ou6Lm5bDUMh/uY52H1QO1Y0iM=;
 b=DLncriKks8Uat1TvjW1vR0Zro0KFFbaSP7mtalohmb1agd0SfPwozOMBReKOf7YPUlYKSnh074fj7qyR5vS17OR0KFW4koaN0Z71fwN78Kd/5iJHHv8/f+GL0ZHnSSVD8unUfXtFuYg2Xwyz5JOy5sAdoFlWIDeyQqGjYZaEeg8=
Received: from CY5PR20CA0011.namprd20.prod.outlook.com (2603:10b6:930:3::6) by
 IA1PR12MB6387.namprd12.prod.outlook.com (2603:10b6:208:389::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6678.26; Tue, 15 Aug 2023 10:34:23 +0000
Received: from CY4PEPF0000EDD7.namprd03.prod.outlook.com
 (2603:10b6:930:3:cafe::60) by CY5PR20CA0011.outlook.office365.com
 (2603:10b6:930:3::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.33 via Frontend
 Transport; Tue, 15 Aug 2023 10:34:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD7.mail.protection.outlook.com (10.167.241.211) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.14 via Frontend Transport; Tue, 15 Aug 2023 10:34:22 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 15 Aug
 2023 05:34:19 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH 3/4] iommu/amd: Remove amd_iommu_device_info()
Date: Tue, 15 Aug 2023 10:32:54 +0000
Message-ID: <20230815103255.565295-4-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230815103255.565295-1-vasant.hegde@amd.com>
References: <20230815103255.565295-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD7:EE_|IA1PR12MB6387:EE_
X-MS-Office365-Filtering-Correlation-Id: 883bbcc6-30f5-4491-c56a-08db9d7b30c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	/g/0JISMdGLPN1/yK4u/powZZaOMi3QzglfSEOwgBIX05bBz1bZTDFEghg3xlCJZIsjiqnraQzT0A/3agImvxls8ZrSfVMIl2+4TmzjHNUS1XaWL4ZWkIhTvf22CD/iT6WU63Ijkvd0b++6UJiJhJ+CbKI3gv2bYrcOBk1DPwg2mJzrjj0zeamH8VOA/2JcYtAEXzRQAvmQ75Llt8UV1rlIzmq65zIGvET7c6PpOYGjmt4KY6yEV40fJU9J3ETWuXBlNTE2GNDjTpV1j/VUk40CEpJRG8+6LvA6YS8W2gkEwOSPlNCnWEDUijNdwzBlkCWl41kDxTwLXFT+4ZdXpiROmWKPtf7XDuVZhVLpDfQyGlHHZHywmhqmsFW8oFcDH9yooHa8eH+RKx6HpuhSOQXZuCXKXqe8ZAUZqrNQpnrrKIyP+zRQmdzHgNg80eMWzbx5S5ZfPPCRBnCK9gLJagyN9ZMmsOIGWvtmib0+TuJuOaCUZL2ATcTKb2jMTMjCoDnWN3Udjmxxws1l08HONsemmlvpcJ3tjXR4jP3KLISaRtPBvjHphbvPwMRefN/aGPOfqIvQXiWhNFO70xjjjBTt/5JCbk/CluUYr7XdAYvOUhDgcRKtWp8MXHl23VK7/0WMjU6jcm5+ElVtFs8Sg0lKQvjPTomG5qZSOUsj3SSS8BgJ7ySEwRJvNoS2aUz4N+Z9g/2W+v+Eb6TvW9WNNTlItEohZf5hhedFLnw07yYg3BXnJCeHdNkHRw4g8fZmZcnNp9uf0Kdn5dH8eVhBGJw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(346002)(396003)(376002)(451199021)(82310400008)(186006)(1800799006)(46966006)(40470700004)(36840700001)(40460700003)(336012)(426003)(16526019)(1076003)(26005)(83380400001)(36860700001)(47076005)(7696005)(41300700001)(54906003)(2616005)(70206006)(70586007)(316002)(5660300002)(44832011)(8676002)(8936002)(4326008)(2906002)(6666004)(110136005)(478600001)(40480700001)(356005)(81166007)(82740400003)(86362001)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2023 10:34:22.6965
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 883bbcc6-30f5-4491-c56a-08db9d7b30c8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6387

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
index 730fd254c12e..c85289ac1a10 100644
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

