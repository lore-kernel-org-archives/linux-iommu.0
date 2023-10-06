Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2086.outbound.protection.outlook.com [40.107.93.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15D07125B3
	for <iommu@lists.linux.dev>; Fri,  6 Oct 2023 09:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Zuo3y/5/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XftvoN0CiSUNMs1FdU9FR7AkVs975a01VrLSmwYH7DlQnXZykz5lhSdUP1MBFjKdKiTBo4/qrtIlJrdjhk42VUSjuI3MQJOtp6T35ulhvcbM76aIrdNDKjrtuhJvIr+0m27mlHY3XotdjJSEb3BvXK39Z5/VS5xKjugqQdjXlrg1YqeT12nC1dD/2eU0OiVflcwofEXEUgr2/obyj75MFwi2nF0IaOvi9J4j1wJ2y2u1Wa6i0ELAEYI2ehuwI6FPLaaFG57TcTvi7nf48HXjH4HPQWrlrpap7czaFzsFG5atLcttI5TPXdCBpml5X77CX7MB2DtteE4GD8jXwPjsSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kHOKMlUCJvyLCpSr0pLGDU8GWPChR40gU8LB3CyoWPM=;
 b=YxcvlWjhlbMRAjZ0jAgqytzVqUHprpjXC9W/Z4bjl9eqL/OPUQ0YMBxuwqqDSYjYs+zCaX16JB1fMiJkyFspRe3idYPn7dqb9xQYJqF+1AoYawXHCNtU52OR55onsQCQ6dNHWy7r9w1XcX2tQFNpjBfQvD6+dBiK4PUpTKlZj6shXBESGu7Wn5TewNvBYm4t0xgItTdFiGmqkdWHR/nE+caT5yumvNmoSM4wvsdchje3Mmt+5XQSGsU149mBxkIr9EOK33AgtDXcGos91gkBegX/kH+ZufgNxbLvjSsIFoCBUNU0s0un5Lb/7HmEkjJTm+1+buuroi+zArOKjc3mgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kHOKMlUCJvyLCpSr0pLGDU8GWPChR40gU8LB3CyoWPM=;
 b=Zuo3y/5/l916bJewxJKvIVmmanUGZqV6jw7g+6JHWdVjHczW1CB9eaWs/z2YKPKH7k1ykD8YWCIQx24RvTF5mHHIJep8fRNk9t2d1BPJXRuxhFCZfIfQae8If1Q9A/xe+dBuppICKU+osYOo8LM4wKnPERaYrH9g+WHMnqbzdXk=
Received: from CH0P221CA0017.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:11c::26)
 by CYYPR12MB8939.namprd12.prod.outlook.com (2603:10b6:930:b8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.38; Fri, 6 Oct
 2023 09:58:25 +0000
Received: from DS2PEPF00003441.namprd04.prod.outlook.com
 (2603:10b6:610:11c:cafe::aa) by CH0P221CA0017.outlook.office365.com
 (2603:10b6:610:11c::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.30 via Frontend
 Transport; Fri, 6 Oct 2023 09:58:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003441.mail.protection.outlook.com (10.167.17.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Fri, 6 Oct 2023 09:58:25 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 6 Oct
 2023 04:58:21 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>,
	Jason Gunthorpe <jgg@nvidia.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH v4 3/5] iommu/amd: Remove amd_iommu_device_info()
Date: Fri, 6 Oct 2023 09:57:04 +0000
Message-ID: <20231006095706.5694-4-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231006095706.5694-1-vasant.hegde@amd.com>
References: <20231006095706.5694-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF00003441:EE_|CYYPR12MB8939:EE_
X-MS-Office365-Filtering-Correlation-Id: 34c352a6-323f-4f80-b087-08dbc652c87e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	5MjaDMrzAwOJl55d8FWicQdAz53Nnofrk8e5Q98N+uWVuXkr5VzsKIujJfxi8nW+BZqc5rTDkEs8frmTksQeXKCuJIPqEGlnG3efKy+rbMpDWsTx0KsIwGDWwDNyKsJwfuMWVFRlXVxM1jk3JNuT5WG5s2NenzLaIpOVabtKeqw2qE494zXEnnZzuWPeqqVS4Grq4xHz73oVvx/xX/agESaYp+LVas/9mi7gppSFA4xNA25Y7hN8sRj7l4s71N2zi+6rgQG/nhqN/VbAzkqPy166/nluvNWngJ7QA8Z6aAETMZ719l7n6qv6zkCjiUtyubcUoRB9ESQa1I60pTAIo7X8J3ETjxV9VdHWnGNZiV+L97ncvZIoIJeOIEHnfntGuct7zDIHbxmRCr1Znps10l93HLMxxCohNVPy+MazpV/2W9U7pSiz5YE7Mk8QUHiFfVaPagmg5DveWH0XOYVF2mhvUnKfC3zpqtASSWuDkk8s5NQW2MaT801LC+VINvbaRN+ZRB3ZwSb1fP4R7j/8lTLb78ZiNo8OpuvJBt6yHCM8vdah49ZcvBd2t/106lN4/vkADf3t3O0BF5SbTPNzQjB1KZJMgZd+Pg3aNNTmH5Hrw8POU+c1if9iDLH5NQyT8jKdVNPVz34htEw+9J8CpjtuaD2ULqB7diYe2TNeUb9bnDohmuiJXENuSLKHR4UTHBn6VQx6I73guj1dHpRKI+sDlONeDh6mash9nPFxstYkM2uYF8SrcbVRdbpWpKSQfaaF/UE5hgm8WA6fFs9ZeA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(376002)(396003)(346002)(136003)(230922051799003)(186009)(82310400011)(1800799009)(64100799003)(451199024)(46966006)(40470700004)(36840700001)(316002)(40460700003)(356005)(81166007)(83380400001)(2906002)(44832011)(36756003)(8936002)(41300700001)(5660300002)(4326008)(40480700001)(8676002)(54906003)(110136005)(86362001)(26005)(70206006)(70586007)(6666004)(7696005)(426003)(1076003)(2616005)(336012)(16526019)(82740400003)(478600001)(47076005)(36860700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2023 09:58:25.1889
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 34c352a6-323f-4f80-b087-08dbc652c87e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003441.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8939

No one is using this function. Hence remove it. Also move PCI device
feature detection flags to amd_iommu_types.h as its only used inside
AMD IOMMU driver.

Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>
Tested-by: Alex Deucher <alexander.deucher@amd.com>
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
index 790e10207afb..45ef9bc0cc84 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2742,48 +2742,6 @@ int amd_iommu_complete_ppr(struct pci_dev *pdev, u32 pasid,
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

