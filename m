Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010007.outbound.protection.outlook.com [40.93.198.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CA752C21DF
	for <iommu@lists.linux.dev>; Tue, 11 Aug 2026 04:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786421448; cv=fail; b=MtxXo/py4D2YOsilE04g5dgJy19LLGKf9OgODydmuZ7P8HW1lbDBI7cx8aW/EXywnxmfudzm2Hp8Ma0SA6cQ869jjCJok7H5BDGQ619FFBpbedAduAiT9aLQ6I2csxMBP2/7Cgm+uE4C5Z4UzwYZq6VDjCBJWz79foqn2Q4Qmqc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786421448; c=relaxed/simple;
	bh=xrke0RkXpJ9CMtFdhvzLWCp6pwLqunD9OlnPTXdEGH4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M0UOSxwCXNQK/yzp9oj99DhNAriQW/FTrL7b85oh1FQS91g7A52/q7AWoqG6uN8ynf61kLHMXLqBrIViy4DMxR6gXF0Z7VMtD1TnYzIkNcU9NPKOwL2qXRQM8hJsp9DzelRgnlOAWyr230GBqt/KqDJtiSy0n0Xzbb1ZOhkPqDM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=mMUhHcP9; arc=fail smtp.client-ip=40.93.198.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="mMUhHcP9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kYtxkzcye/cyng2XzZfFyIZ1oAXHaFkZNspOMHwRPr3t5ua9YiukNzOXkDHTPBmeGzjBTQkzfDwhl5qBvNQyJ+gk8MYjsh0r86J5UYMofrEZomo+tU4BBm/jXLoEEkaGPSgYl8kxcRAeU99hmcFhZvrDZvbPeN+Jz9jyHwZUfart1uraeFt/u3twh6xcSy9RIm3xt6Kc6cax7m4hEd0mXdectPEA5sUefhIhnUDV4QgIPucZlTr5lXg9OJ+kVzPMs4WMlxd5i+WqtzEAVgOnanizKVoLBHGtqM6mxu3D7LvJMdvLx+9CKkvrrhpSvlukmbm3Rd0dTHy7ySsXuSdihQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5kFeCYneSDwT2ow8SdUlogqkqaifL3J+YYezQXzm/N4=;
 b=j+G3vsCm2tuZEv8D1FNGKU/dCRBKhrbe3q4zitDrSIsZdMpvdW+f1gqwQOXuHaL06Bagomxao62IvgoE6p131Jc6AtaTPbSfxNXGCRv62HzHZZx2ROs0AGGvApO87FLvcHyRRA6iPDGH1pjIxPfDY+J39bXTU0DmM592gqc9jx5a6TkWQTybdZWm/G7wdcZ6UhroPnRgzcU5o3FjVbp9zWn8gLXhu9nyZULPQmIMIorTAYjWR+G2afEqyeNLUF1mY1dp3uphHjHWO00hZLydkgy3jwiaM5+idJF9jXPqNKAwt57IZUF0W9OXbvemXHsCahR+flgExCsPE8lkselMCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5kFeCYneSDwT2ow8SdUlogqkqaifL3J+YYezQXzm/N4=;
 b=mMUhHcP9XxXP/fUc1rcBTwUyiQmNaZiX2Czdo/uCrfAye31q8aMvEz3odIMaRGY557f63sRArVhkcMCA/q9UDcgqK94gQJhGP4rl4/7b73xRN0aOFfuiYB55Q4JDynibvOEZcBC57yygUQEQ5h5RkPYssz5eNmUkHEgSsZP53Co=
Received: from SJ0PR03CA0108.namprd03.prod.outlook.com (2603:10b6:a03:333::23)
 by LV3PR12MB9166.namprd12.prod.outlook.com (2603:10b6:408:19c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.11; Tue, 11 Aug
 2026 04:10:43 +0000
Received: from SJ5PEPF000001D1.namprd05.prod.outlook.com
 (2603:10b6:a03:333:cafe::6b) by SJ0PR03CA0108.outlook.office365.com
 (2603:10b6:a03:333::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.25 via Frontend Transport; Tue,
 11 Aug 2026 04:10:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001D1.mail.protection.outlook.com (10.167.242.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Tue, 11 Aug 2026 04:10:42 +0000
Received: from kali.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 10 Aug
 2026 23:10:39 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <will@kernel.org>, <robin.murphy@arm.com>,
	<suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>, "Ankit
 Soni" <Ankit.Soni@amd.com>
Subject: [PATCH v2 5/5] iommu/amd: Fix GN bit setting in COMPLETE_PPR_REQUEST command
Date: Tue, 11 Aug 2026 04:09:00 +0000
Message-ID: <20260811040900.8572-6-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260811040900.8572-1-vasant.hegde@amd.com>
References: <20260811040900.8572-1-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D1:EE_|LV3PR12MB9166:EE_
X-MS-Office365-Filtering-Correlation-Id: cda0365d-3bc5-4e1d-ba56-08def75e82a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700016|376014|23010399003|22082099003|18002099003|56012099006|5023799004|11063799006|6133799003|10067099003;
X-Microsoft-Antispam-Message-Info:
	p2dKPJ/dz+hnk1vABEjyn3971XGVOSw8bIQvl8wKMWczBW0ZaBr+xVSevoZrVIzbCTjtj0eTI8fkVyOrn0ex3M2gzf9I9pC+DxFCMuCc/C64rFFcInBN1SOranZ0nz4lbYUa4FY9OAnIrdiQbBvj/vrrtPczMeNNFgisPoG9hwOGgQMMXnwSpbrgWUx808jJXK8E94A/f3L95/uUoq3OClAh9nCtzZgGnYv06BxMIkDKae5mEKHzoOruDiM2dUhdsZ65kXkyk+Xj0VxqqAm4PAvZhjLI+EApTKPFgafFFqNPO6t8Ftkw2dN8f/XEzKwA4f5HicvsuSEowhcLKUJd0jJ6e2flWPEYZ240niFW1+Pi31lUKsHlaMGg8NXmjDf20it0g249z225PZqLa4fdrrYVg6vqmuU2B+kX56XyCl0aPNn9LozaDw3qpgBpv3vaZ7MYAvETV7ljU/gvi9kjL6u9Y/CwStb14AFnZAWclQtScZB1RK0GnSk8hsqgO8utH6kAeJSnMRv0cPPQjpYBoNBOQ+xWXiSrh1Df9Z/kSsVMpe3wTY7TSoRiLrs/WW3B5osNdD3bi5PNd/kleZurOLCCjnMse8o2YiA6fHQoiWzs3JnehHsaBXxBTH6uh3dVJCaEZnWIgTAWYOWVB5SVCfdMXg5cUtEG5CwX4h8avH5HvG9GY5x1NbxTQBOmStzFdvratf9CEzqfdQXrfh4++Q==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(23010399003)(22082099003)(18002099003)(56012099006)(5023799004)(11063799006)(6133799003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	U15kZFBnK/oIW5zEDgL6O+3bEC9+uxd5rY3+UyPyTatkflRmgwuypuJcEsnpEky6aW8DtSprhS9gH96QyowB8cNDYDDLzAdhW4cZXkqkEiXyaNH3urh7Rx0U0e7q7lPC66GmXVD90TBIh8e7i/sRsuWWuidttphNqZStC5AtBNJ8Lh4G1tbG9/aeIHRcXIam4vQ2d3w8K7+8fQrcv1yEX4b2E5ExDFa5pwJrrL5zqksPFSP27mL9vd0EGv4SyUF3eimtQog5gSrTtKOiwdPEQQ0tyLgVx1n7ITRy/L23mq02MuSkjM064U/yt1zEz6gXtcvDRMp7La9IbQEEe+vIAKCy3MCOha0s+magYYnIi9TkzUcZQjswH0bLchhzVtDUrn+jGiwlEVxH6XErCGmhc2xnSfXd8sli3650OTbpHoJM6DnBdzPSHyRwvMWr194q
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2026 04:10:42.3139
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cda0365d-3bc5-4e1d-ba56-08def75e82a6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9166

The GN bit in the COMPLETE_PPR_REQUEST command indicates whether the
device is operating under a guest (v2) page table. Currently,
dev_data->pri_tlp is incorrectly used to derive this bit. However,
pri_tlp indicates whether the device uses PRI TLP which is unrelated
to page table mode.

Fix this by refactoring amd_iommu_complete_ppr() into a static internal
helper __amd_iommu_complete_ppr() that accepts an explicit 'gn' argument.
The amd_iommu_complete_ppr() wrapper then derives the GN bit correctly
from the device's active protection domain via pdom_is_v2_pgtbl_mode().

In the INVALID_PPR_REQUEST error handling path, the device's protection
domain may not be accessible, so derive the GN bit directly from the
EVENT_FLAG_PPR_GN flag in the event log entry instead.

While at it, change the 'gn' parameter type in build_complete_ppr()
from u8 to bool to better reflect its semantics.

Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
Reviewed-by: Ankit Soni <Ankit.Soni@amd.com>
---
 drivers/iommu/amd/amd_iommu_types.h |  1 +
 drivers/iommu/amd/iommu.c           | 26 +++++++++++++++++++++-----
 2 files changed, 22 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 500952e752b4..36c0df418ce5 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -160,6 +160,7 @@
 #define EVENT_FLAG_RW		0x020
 #define EVENT_FLAG_I		0x008
 #define EVENT_FLAG_PPR_RX	0x001
+#define EVENT_FLAG_PPR_GN	0x200
 
 /* feature control bits */
 #define CONTROL_IOMMU_EN	0
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 17df9b28ebaf..856948a5192c 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -92,6 +92,9 @@ static void clone_aliases(struct amd_iommu *iommu, struct device *dev);
 
 static int iommu_completion_wait(struct amd_iommu *iommu);
 
+static int __amd_iommu_complete_ppr(struct device *dev, u32 pasid,
+				    int status, int tag, bool gn);
+
 /****************************************************************************
  *
  * Helper functions
@@ -912,6 +915,7 @@ static void amd_iommu_report_ppr_err(struct amd_iommu *iommu, volatile u32 *even
 	struct device *dev = iommu->iommu.dev;
 	u32 pasid = PPR_PASID(*((u64 *)event));
 	int tag = event[1] & 0x03FF;
+	bool gn;
 
 	dev_err_ratelimited(dev, "Event logged [INVALID_PPR_REQUEST device=%04x:%02x:%02x.%x "
 			    "pasid=0x%05x address=0x%llx flags=0x%04x tag=0x%03x]\n",
@@ -932,7 +936,9 @@ static void amd_iommu_report_ppr_err(struct amd_iommu *iommu, volatile u32 *even
 		return;
 	}
 
-	amd_iommu_complete_ppr(&pdev->dev, pasid, IOMMU_PAGE_RESP_FAILURE, tag);
+	gn = (flags & EVENT_FLAG_PPR_GN);
+
+	__amd_iommu_complete_ppr(&pdev->dev, pasid, IOMMU_PAGE_RESP_FAILURE, tag, gn);
 	pci_dev_put(pdev);
 }
 
@@ -1372,7 +1378,7 @@ static void build_inv_iotlb_pages(struct iommu_cmd *cmd, u16 devid, int qdep,
 }
 
 static void build_complete_ppr(struct iommu_cmd *cmd, u16 devid, u32 pasid,
-			       int status, int tag, u8 gn)
+			       int status, int tag, bool gn)
 {
 	memset(cmd, 0, sizeof(*cmd));
 
@@ -1867,7 +1873,8 @@ static void dev_flush_pasid_all(struct iommu_dev_data *dev_data,
 	amd_iommu_dev_flush_pasid_pages(dev_data, pasid, 0, U64_MAX);
 }
 
-int amd_iommu_complete_ppr(struct device *dev, u32 pasid, int status, int tag)
+static int __amd_iommu_complete_ppr(struct device *dev, u32 pasid,
+				    int status, int tag, bool gn)
 {
 	struct iommu_dev_data *dev_data;
 	struct amd_iommu *iommu;
@@ -1876,12 +1883,21 @@ int amd_iommu_complete_ppr(struct device *dev, u32 pasid, int status, int tag)
 	dev_data = dev_iommu_priv_get(dev);
 	iommu    = get_amd_iommu_from_dev(dev);
 
-	build_complete_ppr(&cmd, dev_data->devid, pasid, status,
-			   tag, dev_data->pri_tlp);
+	build_complete_ppr(&cmd, dev_data->devid, pasid, status, tag, gn);
 
 	return iommu_queue_command(iommu, &cmd);
 }
 
+int amd_iommu_complete_ppr(struct device *dev, u32 pasid, int status, int tag)
+{
+	struct iommu_dev_data *dev_data = dev_iommu_priv_get(dev);
+	bool gn;
+
+	gn = pdom_is_v2_pgtbl_mode(dev_data->domain);
+
+	return __amd_iommu_complete_ppr(dev, pasid, status, tag, gn);
+}
+
 /****************************************************************************
  *
  * The next functions belong to the domain allocation. A domain is
-- 
2.31.1

