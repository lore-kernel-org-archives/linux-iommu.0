Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.85.31
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793854149;
	b=x1MtHL9vFHxgBJ+jSGXO+JmdiEEI/2rnLNcNtCrqqiNCqO2wnb0CEUbWNyogs0IWEsqC
	 oYsZJKZ3KvUXrHUap0j17ALRW/zu3eBaYyErDRdpbVrItKUHiLNW0sBzsD80Qo5v6hfjs
	 8ahl4xcfJWGafdC4Dka6y+i73U3zs/iSncz5z+TCfCyq1m3/RCymEXIUl8CBd74f4oFQP
	 3SnY3BMD/tculvXTyx9l9Pnn4PW9sMx+NhHn2P0EizDkr++paxCnGpij9zvx027pY9JpO
	 S/f47uhmXN3hbo5gPDXnur6XzPa1JSn4Dxkwpam6L7aeEJdzZ7b8FaNHF/N94cnq2CA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793854149;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy:X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=bLq8PnTV6RhH9uydZqxZqW1Z9EEjzbDPcXnylCavOS4=;
	b=Pd6c4/3gg4cbLhPPLBSd7WYM4RRD0OXXnsJdFbzdCgNVZcnaw8ViOOTAzfYOQU97sURB
	 XVAfjHiQLrrTLQGEwH3baNhHNWB86zyuFoiGW10kzBPUlQgc/3nxPcyLr+755rKA/8IGA
	 fzTwVI9ip/YIn5tzPvKy9rESrsFRwsSZCJWRVGB1hGFo2fWfraEwbyq/4+lpg76ep5Htw
	 /su4JIvdW1lQpZa8kDzu1HXb0bZYLgP+7AvMWrQaI6M71biNf6qn1o87ytHyvlFvm48ER
	 CeOdy7Q+TIQnIDv/KgUqNWVZg8Y4dRtOkC350ciCqg9F/OCVoYh4OlpmLR116sK7Uaw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b="WLK/bOf0";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.85.31
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010031.outbound.protection.outlook.com [52.101.85.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB6CF606A32C
	for <iommu@lists.linux.dev>; Thu,  5 Nov 2026 04:49:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EB6CF606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=WLK/bOf0
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q4rR2/J0yIs4tyYa3QKa7crVg/WKIXXhyLpRz7PbyM4OvXDc/FTderTLU480vcuoVsh4opl2FmegRKHmnts9SSeU6qKz+Q9m8NSZzXfhTazQxsAvZ4Op+GqsTvx6pKH6CSqIt018gLrHIlTHY8+OoOEUBqguDvdbwhvlfXFUfu3QXb4abFYqZbH0mFQe3Nn/DRBiMfOQl5CuLo2RFGW6c7Ig22hNwcdi0Ku/s2a5n2zvxAPyKAsh5yBra+bQ+XPrQOdnpsNVCnuTQcB7Ar1n0eh7d3RWmAwco6JQPk+2k9VAFXTTpK4By5Kf9U7EwYPEg5oeH5OB+Y8L88o7h/lthA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bLq8PnTV6RhH9uydZqxZqW1Z9EEjzbDPcXnylCavOS4=;
 b=sa5oQVZ50G7eggzDeI2RDQyMYtuULBqgLGVpYS/lAeH5sEIuyN1X9wzodsrXKFdT+Q+973A2bqyJTXI3kian92mgj81PsnTvrgKe8aHPVTsnWCxzXF3rs+2ASyXssDfmlMeGkGlFkHhTSC0Lf90CAkiIzGNV6QPBfJoss6Xt9CIUKS0tSkQRqZfvc4UM9bVtfj55MoiYjGuOrppBQgNQZITPsy0YJ71aZjanRQE7CNVXpI0M6fnF272VKC2L1AytPVZLmuZ3FGLVK5OId5zgSzOLNuPwMcvWvW6MJI7DH07n+l53wOMjcw61dGsdcMEAy0X1E6VYOKcalUKh1eDLTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bLq8PnTV6RhH9uydZqxZqW1Z9EEjzbDPcXnylCavOS4=;
 b=WLK/bOf0GjHAHuRp6LqmYeS6DmnbUaCFD2xZL9Fi6FxUBs1z2CxaXqAo4vvyUxD37vUaQ4aBW64j5h9k+FFSeI7wdMmrwGAulMqsmZCN92ddn14wZEK+14C4Y3H2ARn6nmN6eVMh5/igQoPLePPr8EDRwV7uqCXMUgTAmp+ppsc=
Received: from BN0PR04CA0169.namprd04.prod.outlook.com (2603:10b6:408:eb::24)
 by LY0PR12MB281605.namprd12.prod.outlook.com (2603:10b6:404:21d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Thu, 5 Nov
 2026 04:49:05 +0000
Received: from BN6PEPF00000074.namprd03.prod.outlook.com
 (2603:10b6:408:eb:cafe::a4) by BN0PR04CA0169.outlook.office365.com
 (2603:10b6:408:eb::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.8 via Frontend Transport; Thu, 5
 Nov 2026 04:49:05 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN6PEPF00000074.mail.protection.outlook.com (10.167.248.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Thu, 5 Nov 2026 04:49:05 +0000
Received: from kali.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 4 Nov
 2026 22:49:01 -0600
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <will@kernel.org>, <robin.murphy@arm.com>,
	<suravee.suthikulpanit@amd.com>, <jgg@nvidia.com>, Vasant Hegde
	<vasant.hegde@amd.com>
Subject: [PATCH 03/12] iommu/amd: Complete a PPR from a device the IOMMU did not probe
Date: Thu, 5 Nov 2026 04:47:52 +0000
Message-ID: <20261105044801.399466-4-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261105044801.399466-1-vasant.hegde@amd.com>
References: <20261105044801.399466-1-vasant.hegde@amd.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN6PEPF00000074:EE_|LY0PR12MB281605:EE_
X-MS-Office365-Filtering-Correlation-Id: 883094a7-901d-41ac-b169-08df3af81eb0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|376014|23010399003|1800799024|22082099003|6133799003|18002099003|10067099003|56012099006|11063799006|261026121527099003|261026140227099003|261028144727099003|261021121427099003|261022075727099003|261021123027099003|261022113327099003|261009223027099003|261102123227099003|261022105027099003;
X-Microsoft-Antispam-Message-Info:
	shIJ2xJ/w7CxnsjDQUf7XNDrZq5jQoT1SJyGrKfPrNJdSEOmZiKeCcwk5QMv9Cyp0AYNVmEaC8LaHLgkxdHcJM/jKzt0odbZEEK6nnD2MUsrt6ujOI9wLy1MrhfQEnzhduyy1VLi67HeqKdFQfTzWFcIqsBqfbk5ZNN/kysMjTEFf+N2CBmzzxNDBZxssQ3+kdABCodke9LFHHTh+oD8SetsBE86goWI+Y5935Ey2OO6It/7XlQ3HWQMN9GoEZVztIXRguH1KnfrrTeoP0jdCe/B2tihbN3gKZcwhqYg6U/Z6axBM9ARJQhzuIw2dv3+iVtkEh9N7qfi1gVB9ZkAI/PCrV72jZLMrog/snfQnKqM9KOKRW4N7/3CXoYMOQfJNNCcL2tFl/XNgV1AhCeZgoGOYcXIJLFMQq9IuRE6RpKlmMcQ9kAnZd28a1crt1490gzXESQm56xpQZPA/JUMFZl/WHAACJF79E4CUWAFi3RspidWLhVoRefuyc0o3U2q2TzzvA/gEjO0BzT/AHCaxfx3JNcLu708Sgf7Xv0Y9f4rHOZQ3PZdJmjPG35imG7v+gv0koAWs47kg/aQ/v1X3rIEfdgq4fXyzhYYaHREdUz1YEWFeEPFb3L4gtqR0qMuJ1rwZx4lYidhn5WUkWHmml5cjIE+Zf/k7okvm0REGyjSNV42ZfjL49A/K/TFk9Sbx2K2B9qESARCibm2o5B82Q==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(376014)(23010399003)(1800799024)(22082099003)(6133799003)(18002099003)(10067099003)(56012099006)(11063799006)(261026121527099003)(261026140227099003)(261028144727099003)(261021121427099003)(261022075727099003)(261021123027099003)(261022113327099003)(261009223027099003)(261102123227099003)(261022105027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	prIdk56fwHVoxYK6BbBdwbbpNVt1gk0MXYPksKQ6FM0xexfKqL4kVjHI8C/qh8w1S02ufOnHo3k4dCIKBbD7nDcMw+mqwz1aQHrBiCKpEN+ixhg6VP+mDYtNR0Z7lxPC7MZxeOQ+1iTpxigJOkuF6EOBhInM88X/PE5F6IAaoTQzVBVFYmr4P4+bO48Oj6KHPNtGzVrG4upLGsOJy9l0f4WNCkqs7MC7OdAi2HI45N3xiMWXZgALy1k91D2Q5HG9vc8FAwI6/TRKg83J0NA0a1jNdT6DRxZ7SX1/5jKxbSBwjnZNPinv+b9ykqhXK81AFRp/Ufo4oGHssquQWijtJC2gCMvdXMSsHADDjITiqGHQ+NSkjnPnQJd0JgiaXV6+o4WJWiPmC+hjZSgnfpQGgWCQY745WrJhsh3MkcVoF8DzjNtaYITndiyHcVdezCjt
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 04:49:05.0744
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 883094a7-901d-41ac-b169-08df3af81eb0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN6PEPF00000074.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LY0PR12MB281605

iommu_call_iopf_notifier() reads dev_data->max_pasids after looking
up the PCI device. dev_iommu_priv_get() is NULL when probe failed,
and the abort path then calls amd_iommu_complete_ppr(), which reads
dev_data->devid and the device's IOMMU. A kdump kernel reuses the
previous device table, so a device that failed probe can still have
PPR set. The invalid-PPR event path has the same dependency.

COMPLETE_PPR needs the IOMMU that owns the log and the DeviceID from
the entry. amd_iommu_complete_ppr() takes those directly. Report the
fault only when the device was probed. Otherwise complete the last
page of the group from that DeviceID. The invalid-PPR event path
completes the same way and no longer looks the device up.

Assisted-by: Cursor
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/amd_iommu.h |  4 ++--
 drivers/iommu/amd/iommu.c     | 27 +++++----------------------
 drivers/iommu/amd/ppr.c       | 27 +++++++++++++++++++++++----
 3 files changed, 30 insertions(+), 28 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index 4546f8be34ef..da93f7fb259b 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -83,8 +83,8 @@ int __init amd_iommu_alloc_ppr_log(struct amd_iommu *iommu);
 void __init amd_iommu_free_ppr_log(struct amd_iommu *iommu);
 void amd_iommu_enable_ppr_log(struct amd_iommu *iommu);
 void amd_iommu_poll_ppr_log(struct amd_iommu *iommu);
-int amd_iommu_complete_ppr(struct device *dev, u32 pasid, int status, int tag,
-			   bool gn);
+int amd_iommu_complete_ppr(struct amd_iommu *iommu, u16 devid, u32 pasid,
+			   int status, int tag, bool gn);
 
 /*
  * This function flushes all internal caches of
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 883901118ace..b429d8dfb3e9 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -872,7 +872,6 @@ static void amd_iommu_report_page_fault(struct amd_iommu *iommu,
 static void amd_iommu_report_ppr_err(struct amd_iommu *iommu, volatile u32 *event,
 				     u16 devid, u64 address, int flags)
 {
-	struct pci_dev *pdev;
 	struct device *dev = iommu->iommu.dev;
 	u32 pasid = PPR_PASID(*((u64 *)event));
 	int tag = event[1] & 0x03FF;
@@ -887,20 +886,9 @@ static void amd_iommu_report_ppr_err(struct amd_iommu *iommu, volatile u32 *even
 	if (flags & EVENT_FLAG_PPR_RX)
 		return;
 
-	pdev = pci_get_domain_bus_and_slot(iommu->pci_seg->id, PCI_BUS_NUM(devid),
-					   devid & 0xff);
-	if (!pdev)
-		return;
-
-	if (!dev_iommu_priv_get(&pdev->dev)) {
-		pci_dev_put(pdev);
-		return;
-	}
-
 	gn = (flags & EVENT_FLAG_PPR_GN);
-
-	amd_iommu_complete_ppr(&pdev->dev, pasid, IOMMU_PAGE_RESP_FAILURE, tag, gn);
-	pci_dev_put(pdev);
+	amd_iommu_complete_ppr(iommu, devid, pasid, IOMMU_PAGE_RESP_FAILURE,
+			       tag, gn);
 }
 
 static void iommu_print_event(struct amd_iommu *iommu, void *__evt)
@@ -1850,17 +1838,12 @@ static void dev_flush_pasid_all(struct iommu_dev_data *dev_data,
 	amd_iommu_dev_flush_pasid_pages(dev_data, pasid, 0, U64_MAX);
 }
 
-int amd_iommu_complete_ppr(struct device *dev, u32 pasid, int status,
-			   int tag, bool gn)
+int amd_iommu_complete_ppr(struct amd_iommu *iommu, u16 devid, u32 pasid,
+			   int status, int tag, bool gn)
 {
-	struct iommu_dev_data *dev_data;
-	struct amd_iommu *iommu;
 	struct iommu_cmd cmd;
 
-	dev_data = dev_iommu_priv_get(dev);
-	iommu    = get_amd_iommu_from_dev(dev);
-
-	build_complete_ppr(&cmd, dev_data->devid, pasid, status, tag, gn);
+	build_complete_ppr(&cmd, devid, pasid, status, tag, gn);
 
 	return iommu_queue_command(iommu, &cmd);
 }
diff --git a/drivers/iommu/amd/ppr.c b/drivers/iommu/amd/ppr.c
index 1181dc31795f..7d660a81df3a 100644
--- a/drivers/iommu/amd/ppr.c
+++ b/drivers/iommu/amd/ppr.c
@@ -116,10 +116,27 @@ static void iommu_call_iopf_notifier(struct amd_iommu *iommu, u64 *raw)
 		return;
 	}
 
+	/*
+	 * Probe never attached this device, or it is no longer on the
+	 * bus. A kdump kernel can reuse a DTE that still has PPR set.
+	 * The log entry carries the DeviceID, so complete the group
+	 * here and do not touch dev_data.
+	 */
 	pdev = pci_get_domain_bus_and_slot(iommu->pci_seg->id,
 					   PCI_BUS_NUM(devid), devid & 0xff);
-	if (!pdev)
+	dev_data = pdev ? dev_iommu_priv_get(&pdev->dev) : NULL;
+	if (!dev_data) {
+		pr_info_ratelimited("PPR for unprobed device: 0x%x\n", devid);
+
+		if (PPR_TAG_LAST_PAGE(raw[0])) {
+			amd_iommu_complete_ppr(iommu, devid, PPR_PASID(raw[0]),
+					       IOMMU_PAGE_RESP_FAILURE,
+					       PPR_TAG(raw[0]),
+					       PPR_FLAGS(raw[0]) & PPR_FLAG_GN);
+		}
+		pci_dev_put(pdev);
 		return;
+	}
 
 	if (!ppr_is_valid(iommu, raw))
 		goto out;
@@ -136,7 +153,6 @@ static void iommu_call_iopf_notifier(struct amd_iommu *iommu, u64 *raw)
 	 * PASID zero is used for requests from the I/O device without
 	 * a PASID
 	 */
-	dev_data = dev_iommu_priv_get(&pdev->dev);
 	if (event.fault.prm.pasid == 0 ||
 	    event.fault.prm.pasid >= dev_data->max_pasids) {
 		pr_info_ratelimited("Invalid PASID : 0x%x, device : 0x%x\n",
@@ -159,7 +175,7 @@ static void iommu_call_iopf_notifier(struct amd_iommu *iommu, u64 *raw)
 
 out:
 	/* Nobody cared, abort */
-	amd_iommu_complete_ppr(&pdev->dev, PPR_PASID(raw[0]),
+	amd_iommu_complete_ppr(iommu, devid, PPR_PASID(raw[0]),
 			       IOMMU_PAGE_RESP_FAILURE, PPR_TAG(raw[0]),
 			       PPR_FLAGS(raw[0]) & PPR_FLAG_GN);
 	pci_dev_put(pdev);
@@ -245,9 +261,12 @@ void amd_iommu_iopf_uninit(struct amd_iommu *iommu)
 void amd_iommu_page_response(struct device *dev, struct iopf_fault *evt,
 			     struct iommu_page_response *resp)
 {
+	struct iommu_dev_data *dev_data = dev_iommu_priv_get(dev);
 	bool gn = evt->fault.prm.flags & IOMMU_FAULT_PAGE_REQUEST_PASID_VALID;
 
-	amd_iommu_complete_ppr(dev, resp->pasid, resp->code, resp->grpid, gn);
+	amd_iommu_complete_ppr(get_amd_iommu_from_dev_data(dev_data),
+			       dev_data->devid, resp->pasid, resp->code,
+			       resp->grpid, gn);
 }
 
 int amd_iommu_iopf_add_device(struct amd_iommu *iommu,
-- 
2.31.1

