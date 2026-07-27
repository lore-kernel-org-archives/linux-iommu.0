Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010006.outbound.protection.outlook.com [52.101.61.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E961A380FFD
	for <iommu@lists.linux.dev>; Mon, 27 Jul 2026 05:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785130857; cv=fail; b=VAGuoCES8S9NRL/UIHnZTVFLuWJ/ihB3J/GZfDq6zlMIZJ3m8v8vdvBGFqrSmtFg2iOn5AqpVaDzj9FC/EhK9L56zmEzbkWgllN5wQdCpnaOmeXR4xFXVYBdjZFB5AR9e+H8A010zD6rQMVvCnCHrysCzTlKJloem/DqB+f/hSM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785130857; c=relaxed/simple;
	bh=41I/ROgBKh/dJ61xccFROaDeGDeveHtKWExVX3UKi5g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BclpwQhRNbDSitMVgZrc+qsU3VsGURUwoTgmla28m96Rw/UXNO/lgK2H7WofiAuBAIDlvwePgQy2ISvnSCex6jFXaChmPD7eOHKdN4aFX0rN1o4mnsDASX4hCnqO26gzQXgmP1UBR10eTECFDv/Spb91VcNMdXkc23WxvrK8H/w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=SbFFfpMp; arc=fail smtp.client-ip=52.101.61.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="SbFFfpMp"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nbnG51YbZt9fT8+H73R8BFZjcbkpuvrSwWWsJboMPtFz9ihSVmokwdxe2fSRCBy35P3LAcmOu5gHiGj/S+FS0fPFIJ60gKnKZf79rsYSP6G/TxTu8rsxuWe0ezPDROEZxYK+/rncgoHOUH0mWXbG3VuuLJUWpBKjaaGRFqscRSUicn8Wo8ZpR18K+726uxX5iIrIotsPPaY7ZwNmsEiyVekzxU44iGmO6vEE4Gq9fWNL/Y1HGIMoSasCc21YJ0B90TArsAiVYpw8NQ1rgD1K4xqBaRNU752h5ePZwDK6W5mJrhtPDMM+njuVYQKRqINXN7/E4eaipQ5nz81OoMClSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i6vQyINY6XMNkWgDTal1ng7KUelXBvGRziSa7oKFWFw=;
 b=se0QEeHFEFZ0b/PL8E6NhLgvq9E18Bs60vXbC/9ReDzR58cWw3h7+lDTbkYIGXv9WDnyEKEHlVPhbQXg3Yg0leou7wE3AYFRhkF+/sWhA13WhazMAzPAdDKZAJMfFTcbULx+KQqQHamzX8DTf2gMn93vZOQ5zcVC+d/Npbk2qo4oXctsh0AXTw2gtiEh9R0AZLPUMQwTD4p+u67YovepP2SWDk2s+VAwv68u7R7d7yXAKGPNBKrsJ0+bRwez7+QB83PlS7qvI6/fxjbZTkKFYa5m5+8vciiQjQLoAiZ5JYNepFm2htserCzSQJ7CqkYs7YKsKxkkWR8/otz9lS8pAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i6vQyINY6XMNkWgDTal1ng7KUelXBvGRziSa7oKFWFw=;
 b=SbFFfpMpE8wrNqeVgprqqUZVLZPesKlZVYH8cyt6ulAaJGCh7u/qa8Zx8Qlw7+TmHsfxJpG+tP3kcnMRo5vLZhnByNQEa/81ufTgEi6MrKodDwnjMTYuQ3xqSU/DT97H9ziCiLhGhJdg/8Ez2g/e8qhf17tSc4mC3w9EZtWT1zE=
Received: from CH0PR13CA0006.namprd13.prod.outlook.com (2603:10b6:610:b1::11)
 by MW4PR12MB7031.namprd12.prod.outlook.com (2603:10b6:303:1ef::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Mon, 27 Jul
 2026 05:40:51 +0000
Received: from CH3PEPF0000000C.namprd04.prod.outlook.com
 (2603:10b6:610:b1:cafe::2) by CH0PR13CA0006.outlook.office365.com
 (2603:10b6:610:b1::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.12 via Frontend Transport; Mon,
 27 Jul 2026 05:40:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF0000000C.mail.protection.outlook.com (10.167.244.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Mon, 27 Jul 2026 05:40:51 +0000
Received: from kali.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 27 Jul
 2026 00:40:49 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <will@kernel.org>, <robin.murphy@arm.com>,
	<suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH 5/5] iommu/amd: Fix GN bit setting in COMPLETE_PPR_REQUEST command
Date: Mon, 27 Jul 2026 05:39:07 +0000
Message-ID: <20260727053907.7622-6-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260727053907.7622-1-vasant.hegde@amd.com>
References: <20260727053907.7622-1-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000C:EE_|MW4PR12MB7031:EE_
X-MS-Office365-Filtering-Correlation-Id: 1da2385c-ca5e-4723-3291-08deeba19e7a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|23010399003|376014|82310400026|11063799006|5023799004|10067099003|56012099006|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	Mj5lcJzSVmnwK4k0Suv624cCOAORpeit4LRa/AJKXAF0TvBJXU8EGTGMKTp3p5lDzuKdgBLMFzgA0Yjsn0fp4Ixla3QygAT4KjEuKeFM8HueGh29vhVr9dyeGGiTkGlpVukwb+wt1qwVdVLYNTr464+MBJnP/7fkMIsmV+o+FFjbc+87lSjd/uFGpUUjGOXe89xzJinT/eKvTBVPYhlFLuYjHVcUzGDDAveSizQ9lMbqc9ZXVw1WRqvEpgE5wgQ/H2xN8hulm65A2Yxl7AwmBLot1Kc/86XG3B2tW0CdrgZckzmNP8qHkI6V9qOTP1sMCcgsovlc1hhxoEv71N619CP3bxu96XdCNwTug2SMZUhG8KHiXNqkuJflrSQky8rhpR71ziXS89LDKC3jcoMnQrE+KaBI0nrQd3oQygZWP7ff3r7PUifCCl/gHqErnZLDgzWhFwpnlzhOXvLmqnxeLpwbTXYyT5jju1DlgxmQ7WjNrgLFjWMKh7PqJBPhNvwaeYvyGyW2C4uX+H1yuCItsKyt7hHCIdLnUnz7W3UIQyjZJYnRqcL1yYC8OewhVkG7XFfL5qWOLIk6sYlSmA6i0N7OY/jDeXuDpyam9q0ux21IWiYi/X1o6rQ1Q34WyEtLT2DQ0ysUT+6zJF3AsMXVqxEaYyJnG/qjgU69Fp/AXvQWGx+WL5RUit5J7TUeXY5oJq5T0pp5Vzo6XFCr+oWEhg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(23010399003)(376014)(82310400026)(11063799006)(5023799004)(10067099003)(56012099006)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	/kS+RuCl69UL5lJImy7xLpw/GplcutHtNktWetpZ3v8hT9TqLu9WYmKbA/viZNaoAW9iP36dedWnd5KVNcxxM4zZxH8V7CPmMQY7z+pTV1/m9syY8oBfxnyx9xqLNU3sPNYkMMfx7Aux0JueuhmKPEJ48OBx7M8qGdV6NC0LdR6nR+i8+7OcCvQBeta/f8w7hzEwy10rnRfA+yzoWcGKWdUsSSmuSGSKcoPtbRxDWRaddTu5hSoWjCjkgVr3hL7anpX1nzVOjfNQ7oGNNAPX+RU+28t4MFrDoCxh2XbS+wevtet4XOEsfWCEXXv0y729cEXGHbnKXS93Ed3mPXRTpr3HO4h9X+wP8rKXC5c9TUblwJsj4nBJh4w36AkCfCH9r2IakBgdf10oXw01HauPhsgb/gqch+sH5G1jPtulByLWxWRhdd5be5ltIBMRQnb6
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2026 05:40:51.3942
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1da2385c-ca5e-4723-3291-08deeba19e7a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF0000000C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7031

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

