Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2084.outbound.protection.outlook.com [40.107.102.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D80B4200B1
	for <iommu@lists.linux.dev>; Wed, 12 Jul 2023 14:21:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CACR7p72egyQdz47NTFR7pmBnzDtkvtHYN1iYljUEoZ3oHrHJvJKQyn5G6gZmMZkLs14/ES8fWBmGaUTRtPN/xPWKHTJmwZNRNvCDWeUEQpzOtghMVrMl0bBCaqPqun9H2iMU6B6HP0/kHdrVQMWiwVnS84y4ZtuGvMA5OxcrKwLyKoihOrzmX0X0kiz1sLzyIDR+61QRtqsn1p6szdQkOgX6QJpa9lgYzKW/6d7wf4I8ixFXn9hiEZWjiQYWrwQTLkoxSclOrCoe54aJEkGoubay21moLglXNrViTRGFn0Rkz3vfi7JQLcwsbsZbHQn3/lga8xpp2AH3VUZRVutxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rowxiY7QY4wS83y+wFfL27twGf6JSbiQHOjcz7kq2s4=;
 b=NoyO4TPCnQvTTu7OC9jZE4izoFqsvP1aoGAOetpz9uiS324MYmj6Thc9r6BbYlKznJKvLq2v2qiT8e1F6V9XrgyVUkQ0/qGUOnRDPHlu8w8QhBcC7n7NNhEvkcK/4SsGOMNjv/1SxL2magchz+6x8DceDHSYEW7dfWgAwQ9F0tbe14TOaaGtcVn3VTI5ea/szGOTtOIpz8aEppRFq0PqxqqXXWQcAmh8zWdSGMyjHg8YhaWUfEuiu3vD5rtPec8Hwb64MyFXIsk6DFAHVWdr/sIq/VHXpbkdvOVUXPVKyS80Um5W2hx6/V4tLLJbMjh3ADgNof9AgWxm4uSvIEudLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rowxiY7QY4wS83y+wFfL27twGf6JSbiQHOjcz7kq2s4=;
 b=WoU6P45G7qjAIB1ynzVn4GW0icGGnrFVoaKyVMUPSAnV2BK7jDOeeeWPzfYvqb1xQrT4q69MrQjKvp/HMCLcUtRiJrhtSMRBHOEYVLNoX0hVDZvd+pYQN43h8hN3RHvOTk/nH0RI1H4223xVKm1pISuOJIuvasOOZjJfq/LTOJM=
Received: from MW4PR04CA0197.namprd04.prod.outlook.com (2603:10b6:303:86::22)
 by MW4PR12MB7120.namprd12.prod.outlook.com (2603:10b6:303:222::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.20; Wed, 12 Jul
 2023 14:21:11 +0000
Received: from CO1NAM11FT097.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:86:cafe::8) by MW4PR04CA0197.outlook.office365.com
 (2603:10b6:303:86::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.20 via Frontend
 Transport; Wed, 12 Jul 2023 14:21:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT097.mail.protection.outlook.com (10.13.175.185) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6588.20 via Frontend Transport; Wed, 12 Jul 2023 14:21:10 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 12 Jul
 2023 09:21:08 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH 21/21] iommu/amd: Simplify amd_iommu_device_info()
Date: Wed, 12 Jul 2023 14:15:16 +0000
Message-ID: <20230712141516.154144-22-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1NAM11FT097:EE_|MW4PR12MB7120:EE_
X-MS-Office365-Filtering-Correlation-Id: f26c4be6-e7d7-4c23-ddfa-08db82e33ddb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	PxMrH8urHLKLZfF74xHIqtzAbpiloLz5fKsD4s+SPUD4f0yw8aDx/09S1ey67uK8e0SDP/LFFmKNk78xjalWT+6yjgruASOFh+MhKBwddtTWAWwfoxilD4lMVq983u754d18wZVu0udIVaat0QsDhtaf7aSLE68bLg93Gz7845GAlgivoasI8XjmWhJOo70HDWimZDZDPCCU+OPlCgip0oNvZREwvbKimuuvkwDsvb5Uqtp9sp7cuO6FCYWZNlMwroDk2REy1NLKsDMno8igObJMcBrt57PYUaAdGrf7YuPHQ2b86npp80hMXNK8yJfbUwSFKwPxyr8fAoDGs/I5VYD8HitPCcH5sVvkasL8jF7oAt25Y94Omq5O3BSKQttF9X+1stsOqj4c9wkfhJYbyDl99BQVSgD8wMfEDquOjHeqIxhyxY3xBBFep0D2gKH2+JkXG0Dvk46tHHGfz3B3Hi4xYkGbbpaQSlIaZyWlvPASypE5DYOB46V6pebJgLivJqvV/bZ5+HodmkgFW8Idu5UNcu/J2VAhDfeybeCxSKRf65qsvkrA1Nj/UNJlkq4AjnQO4Xv/3KiVsgah7PXW5jmMhDRdLuylfVkf1SkgZqEesFpI7hoCGja18GD4fRTrNnB/umfTagRS5fZdbNxjQLszY0A93fFY5H4BW5ut2iKSDP+Fsmom+AcCkOZB8ylOQSgd40QafjZk/nCTqMFXBx+OciLepm2bok9zs2sdAZx6RJCmGklKZpuQCLdrkqa/YARSu8VE9+BOZzBhNRpCmw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(136003)(346002)(376002)(451199021)(36840700001)(46966006)(40470700004)(110136005)(478600001)(16526019)(186003)(44832011)(81166007)(356005)(82740400003)(54906003)(26005)(1076003)(82310400005)(6666004)(86362001)(8936002)(8676002)(7696005)(2616005)(2906002)(426003)(70206006)(336012)(70586007)(83380400001)(4326008)(5660300002)(36756003)(41300700001)(40480700001)(36860700001)(47076005)(40460700003)(316002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 14:21:10.8344
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f26c4be6-e7d7-4c23-ddfa-08db82e33ddb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1NAM11FT097.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7120

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
index 62de31cd59ee..6319a2dc4654 100644
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
 
@@ -2883,8 +2892,8 @@ EXPORT_SYMBOL(amd_iommu_complete_ppr);
 int amd_iommu_device_info(struct pci_dev *pdev,
                           struct amd_iommu_device_info *info)
 {
-	int max_pasids;
-	int pos;
+	struct device *dev = &pdev->dev;
+	struct iommu_dev_data *dev_data = dev_iommu_priv_get(dev);
 
 	if (pdev == NULL || info == NULL)
 		return -EINVAL;
@@ -2894,29 +2903,9 @@ int amd_iommu_device_info(struct pci_dev *pdev,
 
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

