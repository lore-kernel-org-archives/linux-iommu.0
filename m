Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.57.47
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795773908;
	b=gwdELWmE8lpPjzttofUy7JTP8IT/fQV7n7zgwEXYMjSqWnAvfDrWjTTPkAOB4QLwJa0Z
	 zsExqF7w2K6+/7wALCWgCazNHH2ga+pIWhN8TZbFy9F4mr2tm6nXjokAICj6OW/MNAjK/
	 I5wlAfGCvic10stu5Wl6+z/lhJHpr+mpCZ24QDTYEUe/iUsOFoP9eMgSOHETXTHeCxrey
	 +BNkQotoQ8sqv1/DfVXfgXKd2hX0ghEstkjxLnrX+/97Dd/9xUmqye//Tjs6wxTCO+jNz
	 5FBSXGpSXpT5+EzgeO7Rtb/Wnv9jMY+nplmfdeqgubLLlWoimYdHOD/QyoPk2pbzrbQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795773908;
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
	bh=ZmQYJ03oWIrPXN26lI9WQUyX6Yvs1unGoWronp6SCl4=;
	b=ErXeoQG56nkBJOZ0rljXfeFf7lCuCXZlcjkbQO2OZkYMiKqPucxCj6aLaqBkMC6/x4ch
	 I6Up4R0Q3+bUBH5zZMDg+WEszoKFgQ/ro02JzxW3mANfTEvAJNwmBJ2ZeysLDY9R+7M7v
	 QR35HZ7QHONJj2aSLIhdY7Mcf7c6Yn1Gbs5y8fq2SFwOSJEZ54xHuokv45kxuTEuWU4iU
	 aPXJJTaztSG4WbGe1TrkHwNp1UIHtZheIg599oKVJuUoqeaZj9mpoQinqo5XeSzTIGiqi
	 NnMnAMv6dpNsg0XtDt3JyAQ7HZKA9Sh+FXdug9nr4+WavmMNUAmLNpBUFE2fBx9pSvg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=m+43r3HN;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.57.47
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011047.outbound.protection.outlook.com [52.101.57.47])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 979A7606A687
	for <iommu@lists.linux.dev>; Fri, 27 Nov 2026 10:05:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 979A7606A687
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=m+43r3HN
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kdphJfQV4Zbd7DRTXH/kKF1fkqs7+/0yA0pMru8UwZPudQrQkNjs/ScwfxdLk9hxpNoVmKBkUptHaRW1zrA2JvKBfiHbFQDUOUDsxJk01NvXVHIkZVKKU4xvMoW7KDXhhQ23uFLSIcwtE+2nkBqGW9vLDLB5V8MRGtk7VRMtKESikDE3tBD3cOjMgNQVS9gASbxE24YSo2FjIfJrX+JUbzaMsi+tMGbE3Iyh8Q9eNQrZu9warDE/iQdnA5se4k8OdCxWr05dL8chO1lw/cNuTJPAssoWPd2xtDVPXenKdq8uWjALYpdVl+OVgJzunmD7jVqJTDFfc9oWxIqBaSM5OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZmQYJ03oWIrPXN26lI9WQUyX6Yvs1unGoWronp6SCl4=;
 b=QCuNny0sOczts6k5cK+guot1mQsaZZ8uJrDtID/0cQdPEVbfaHBEYqCkepdCTjWu//1bFyi8j7H4C19XsNdm+dBhK3hHSJ7ldnR2slHGuh2+FUVMQc5b9wQ3DPkvTq297nZwg5BKkbdUlJbPA2RW3wSq++nR118xER6sC6US9Qt8+7kT4yjoJf7ZTfVhIFMgVDNC1EyY/DwxBXstQljIqdIYaFNT6Oekxd2RWFoDYNiqomuXIu9WdIZ8n5yzFGkuzQXkj+r+7STwWiE0vgobnR1CBQrYYmrQ9jNunXFWzpXTYgxd+awismeyu5Spe0Ztm5OG4xjPKVx8dg3fGnsGgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=8bytes.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZmQYJ03oWIrPXN26lI9WQUyX6Yvs1unGoWronp6SCl4=;
 b=m+43r3HNY9L4W9f5Z7H7IEyqdZxPojNFnyfltAEfHX3uySsMA6ufawlKZ1+SBIeYafCx9sNY3HyD0EH18v5TOR9FNOdykKSDyOvbcsonB/uqTRylUe10dXgsOvy9DClyG4WMynPUgnzBhZ+GX/70dglZWGVSV4qX3TAlZHCGIQ8=
Received: from BL1PR13CA0172.namprd13.prod.outlook.com (2603:10b6:208:2bd::27)
 by LV3PR12MB9120.namprd12.prod.outlook.com (2603:10b6:408:1a3::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.7; Fri, 27 Nov
 2026 10:05:03 +0000
Received: from BN3PEPF0000B373.namprd21.prod.outlook.com
 (2603:10b6:208:2bd:cafe::2e) by BL1PR13CA0172.outlook.office365.com
 (2603:10b6:208:2bd::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.688.6 via Frontend Transport; Fri, 27
 Nov 2026 10:05:03 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B373.mail.protection.outlook.com (10.167.243.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.688.0 via Frontend Transport; Fri, 27 Nov 2026 10:05:03 +0000
Received: from BLR-L1-SARUNKOD.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Fri, 27 Nov
 2026 04:04:59 -0600
From: Sairaj Kodilkar <sarunkod@amd.com>
To: "Joerg Roedel (AMD)" <joro@8bytes.org>, Adrian Huang
	<ahuang12@lenovo.com>, Joerg Roedel <jroedel@suse.de>, Robin Murphy
	<robin.murphy@arm.com>, Suravee Suthikulpanit
	<suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>, "Will
 Deacon" <will@kernel.org>, <iommu@lists.linux.dev>
CC: <Vasant.Hegde@amd.com>, <Suravee.Suthikulpanit@amd.com>, Sairaj Kodilkar
	<sarunkod@amd.com>, Akshay Jindal <Akshay.Jindal@amd.com>
Subject: [PATCH v5 1/3] iommu/amd: Rename exclusion range base and limit macros
Date: Fri, 27 Nov 2026 15:34:12 +0530
Message-ID: <20261127100414.6980-2-sarunkod@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261127100414.6980-1-sarunkod@amd.com>
References: <20261127100414.6980-1-sarunkod@amd.com>
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
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B373:EE_|LV3PR12MB9120:EE_
X-MS-Office365-Filtering-Correlation-Id: 928e6fb5-620c-4c43-1bb3-08df4c6de7f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|23010399003|82310400026|376014|1800799024|261021130227099003|261102123227099003|261021133027099003|11063799006|56012099006|261022105027099003|261021121427099003|261022075727099003|261026135527099003|261022115727099003|261026130827099003|261022113327099003|261028144727099003|261026140227099003|261026121527099003|261021135927099003|10067099003|261021123027099003|261009223027099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	WiIBRGkJbfDRhTP2py+TmZ/2MGjnBVFhnKPvBSRfP9fAslS7ZIHurhJcYUFky8pN1mO7YHxIQoVjBOK0W18k4hgzH5bbWMPy5jp06f4HJ2oMhfmKD8zIB6ee3VJHaWjvf7ngSfUvQAtTIJltQqNihZkbbAhAWGIcGRYT2QA1t8/IvpH/QEmzATD5p42GpRLmc11627GDhlEYVYB9Nfi1nUJ4F6+s74zO49z6pN0DZqHiVvc4xVpyMD9EOjThzccBEDGuqUnqZx8RckOG/rvvr7Bu7L4xB7QJFEwNYu3i58iJpFDQTEv6CC7+3duz+Y32oh6V5sDHAbOAVdBZx+d7ityihplNrCf77oPdRapFh/iqKylo3ZObyubyQdt0PMG/APXMebkaEoHziY3yFoPryI/WYxDvpPgrFd0+/hKlcxKdGGcZ9aQbuwXZ1LjnvVnbPHsgf4os2buSdV6EqncdnWgjIpt+YZ5cMAsBRK9eDkpQ2A2W2eOlxVb+DXysdhgQqKNE+0KzHhhVgJ9UiGV4xTqcHK9gSCAjzjb2M3KplyfkKoyBv8fedas+MCweWjaibs/FM4zKfZBdn3NfAjFUek3JLxEzDt8SgZLfNXDQI3mwckJ088TF9X1VhFsjb34a6QOmflF91ruWrJeoQMUsdYsTLcX4qfgnZMw/B+VCXuWT1Od+9azD+0v3T3w4tlq9eFZ2t6FmzKbCJg7cboSgIQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(82310400026)(376014)(1800799024)(261021130227099003)(261102123227099003)(261021133027099003)(11063799006)(56012099006)(261022105027099003)(261021121427099003)(261022075727099003)(261026135527099003)(261022115727099003)(261026130827099003)(261022113327099003)(261028144727099003)(261026140227099003)(261026121527099003)(261021135927099003)(10067099003)(261021123027099003)(261009223027099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	yiAoS5M864DQMSWl6vXMJ9tTetMF0ClCqQKpKJBMNURshyVOQGUPL2baoqBkHgEX7FWtuxp0Gg1uKtrvA8yxKZs83o06YV/v3L+A3ueaeJ+MrfdN7M3l7aM+Nlib5O0MOzMoek+X399oRMRo0GFyyhEkoet1YTs7tE9XfcAn7rOsncU9FStw4/uKWBgmtNZlwtVU2Gwkx8QgCXdS6gDYIPKC+oHV7ThedfoTqEEFLjqnaOJwe5EAnBODSGHXOT8Mxsan5x6F97eFukHpGRIfwx2XEacCBH27T3fFD8VZpW0XtJrwYzV0wnR8Slmuz4efxOdOoWkQ7b2CTbRPLkozxopUPB6ZZCvEeSAEX4hWg3bdVVG821c1cEGH0GUaDi7iJzCZiXmQANGC+p+5SVTqH1NGjh0M23VnEKhqFmp/QIYxq1rCC4TCDsneZ1BLl2UX
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 10:05:03.6190
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 928e6fb5-620c-4c43-1bb3-08df4c6de7f4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B373.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9120

From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>

The exclusion range registers have been repurposed to SNP completion-wait
store base / limit registers. So, rename MMIO_EXCL_BASE/LIMIT via to
MMIO_COMPL_STORE_BASE/LIMIT instead.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Sairaj Kodilkar <sarunkod@amd.com>
Reviewed-by: Akshay Jindal <Akshay.Jindal@amd.com>
---
 drivers/iommu/amd/amd_iommu_types.h | 4 ++--
 drivers/iommu/amd/init.c            | 6 +++---
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index f98770db0090..d1602144c160 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -44,8 +44,8 @@
 #define MMIO_CMD_BUF_OFFSET     0x0008
 #define MMIO_EVT_BUF_OFFSET     0x0010
 #define MMIO_CONTROL_OFFSET     0x0018
-#define MMIO_EXCL_BASE_OFFSET   0x0020
-#define MMIO_EXCL_LIMIT_OFFSET  0x0028
+#define MMIO_COMPL_STORE_BASE_OFFSET   0x0020
+#define MMIO_COMPL_STORE_LIMIT_OFFSET  0x0028
 #define MMIO_EXT_FEATURES	0x0030
 #define MMIO_PPR_LOG_OFFSET	0x0038
 #define MMIO_GA_LOG_BASE_OFFSET	0x00e0
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 58f63298493b..f8cf37a471f8 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -369,14 +369,14 @@ static void iommu_set_cwwb_range(struct amd_iommu *iommu)
 	 * Re-purpose Exclusion base/limit registers for Completion wait
 	 * write-back base/limit.
 	 */
-	memcpy_toio(iommu->mmio_base + MMIO_EXCL_BASE_OFFSET,
+	memcpy_toio(iommu->mmio_base + MMIO_COMPL_STORE_BASE_OFFSET,
 		    &entry, sizeof(entry));
 
 	/* Note:
 	 * Default to 4 Kbytes, which can be specified by setting base
 	 * address equal to the limit address.
 	 */
-	memcpy_toio(iommu->mmio_base + MMIO_EXCL_LIMIT_OFFSET,
+	memcpy_toio(iommu->mmio_base + MMIO_COMPL_STORE_LIMIT_OFFSET,
 		    &entry, sizeof(entry));
 }
 
@@ -1071,7 +1071,7 @@ static int __init remap_or_alloc_cwwb_sem(struct amd_iommu *iommu)
 		 * completion wait buffer (CWB) address. Read and re-use it.
 		 */
 		pr_info_once("Re-using CWB buffers from the previous kernel\n");
-		paddr = readq(iommu->mmio_base + MMIO_EXCL_BASE_OFFSET) & PM_ADDR_MASK;
+		paddr = readq(iommu->mmio_base + MMIO_COMPL_STORE_BASE_OFFSET) & PM_ADDR_MASK;
 		iommu->cmd_sem = iommu_memremap(paddr, PAGE_SIZE);
 		if (!iommu->cmd_sem)
 			return -ENOMEM;
-- 
2.34.1

