Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.52.47
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795780584;
	b=Sgy1scJw3za6gtmwcBZGAHSPMJO7DhUX2tXgoza2a5zQr10RyWM1iqICgS432AtfGrid
	 U3pO0au2xvSdDwEaQEwJT/KUYNp45TV3Ehbbf7oFVGow8A/pbg8/pICNFjFgJuxAzKF+4
	 BHkVDQrj2YEL9nD7IAz2xu9uA6LMm7QSIOyZjweQVsBrfcop7UPlChS56laAXo7t9tlbb
	 tcMOyNEu4TlpgwfTg7r+/EQmXmnyk4PqY+B3yTqsKsMBlnV4u66OObefXIIWEv+KcBj/d
	 7lyuekEcQRGIaGcsj7ZiGBUFeMnBoZLaWdsIGqpfrd1qVi4Ay8QAJMAXmCrGfMnTV2A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795780584;
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
	bh=IDERNi/5sMp9mwlG4KMPP1/OSo+5V3LJF8j5k4V8WQw=;
	b=pt7kmrHhTItQP17jtxwsJXxzMxQidCvkHPHbSA/toj8P2KyOYU3etNh/gxErQeW3zlZ2
	 7y0jmajEgHCVoqLAN8dvv/LugSjZUcxRtWYU10KxeZ+MzYVwP28I7EAFB6zlZDXACWBVJ
	 anoEBrPU9EP27pcv5SRp07jDAeyonH7VX1QeCyBELg3f17ru2RUNyMPlLEur/K/rWM+Hm
	 oJ/rgL9KByHa0Np3LCZM9xIberMduQ3qnf92VZTx+Dcz8mPf0YyWXJ7ySqJKT2vTOeErI
	 5VprnjyCRON3+REqIxIei/zn51GxeJ7uhygmDUVo1jaWkOz4rOswB6/3FqclvuWt3Qw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=UdHp2dTC;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.52.47
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011047.outbound.protection.outlook.com [52.101.52.47])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB018606A31C
	for <iommu@lists.linux.dev>; Fri, 27 Nov 2026 11:56:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CB018606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=UdHp2dTC
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VBFhTzrR8V6cN1SkuYUOeCCDp66GgO7x55hlw21go0MkAxJedlwfchHBDN5K/3aQp8uElWlRK7Wvn9pJxA/VsQ2/lnkovP7qm7fb6oz23uJwvblNYo6EKUzUJRcNwdmR0gHhIPVxwrIgJ1sCOxKCvATt6scW03kK/vKyO/tMiSIj9V+TsKJZw/9kkzaUX+Lm91UzlaF56OpZgLp+3eOVpluZZBbgb2mu2L+mwJTX7cFdu/3Y94CSkS8iHbPnuHWDR5xuZuJqzpL0yM95oaVu56pkreY5/JsA9sPMXSYm5v6kuDWQvfjhRQ7LrKuBNtcIhWLeKNTBU/w9fkOS3khiQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IDERNi/5sMp9mwlG4KMPP1/OSo+5V3LJF8j5k4V8WQw=;
 b=sotdqoGtSSO7Zer3+SF3YL/TK3LSuKMU2VGpcdbWrC0I4bLW5m83IatRrq0k/rmFnZAQINcTG2ZLGceww3CADFiwUW5R1qSVpvRCy6xCVApCmZkPl60dk/E+SpbmXTNxt+nDtzZHeZ/6BvpD3mlmPE74lEG7iuIN8mqffSRmkGOO9AWsK6ChWgI1aPkrVYfAiNfY5JcHaOOoUaCVL5tEgRDqSVJOykgEHWLPg1QpJqBGZ6PKQuLrMgqFDQH7gx+FUp1pxFGQFJWa5smybp5EykvcDeDUqZnUoPfO9Pu2RnWPaFMOxyt+Mj9X69Zc4w+dqWP4yPY6DdKK1bMKpfkvkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IDERNi/5sMp9mwlG4KMPP1/OSo+5V3LJF8j5k4V8WQw=;
 b=UdHp2dTCjND8SocLc/JUjAtswhQwep9lZ/EFnAvq4skVLe926mdr1YUdWQyurwhfiwZMrmZ1rcROwl8TzmHw1EZuyt93JIbAcjg4/5d7Ltj/Kbnh5O/VwGUe00wTsFurf3ZoW7Tln9YU2EgreHqn/KWoua073Rjn0hrgdL+zBt8=
Received: from SJ0PR05CA0205.namprd05.prod.outlook.com (2603:10b6:a03:330::30)
 by DS0PR12MB8368.namprd12.prod.outlook.com (2603:10b6:8:fe::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.9; Fri, 27 Nov
 2026 11:56:18 +0000
Received: from SJ1PEPF00002327.namprd03.prod.outlook.com
 (2603:10b6:a03:330:cafe::7d) by SJ0PR05CA0205.outlook.office365.com
 (2603:10b6:a03:330::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.8 via Frontend Transport; Fri, 27
 Nov 2026 11:56:18 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002327.mail.protection.outlook.com (10.167.242.90) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.688.5 via Frontend Transport; Fri, 27 Nov 2026 11:56:18 +0000
Received: from kali.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Fri, 27 Nov
 2026 05:56:15 -0600
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <will@kernel.org>, <robin.murphy@arm.com>,
	<suravee.suthikulpanit@amd.com>, <jgg@nvidia.com>, Vasant Hegde
	<vasant.hegde@amd.com>
Subject: [PATCH v2 02/12] iommu/amd: Derive the PPR completion GN bit from the request
Date: Fri, 27 Nov 2026 11:54:37 +0000
Message-ID: <20261127115447.209792-3-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261127115447.209792-1-vasant.hegde@amd.com>
References: <20261127115447.209792-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002327:EE_|DS0PR12MB8368:EE_
X-MS-Office365-Filtering-Correlation-Id: b9926ba7-2251-42ea-9e63-08df4c7d72a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700016|1800799024|23010399003|82310400026|10067099003|56012099006|260925021911599003|260925021311599003|260925022911599003|11063799006|261021123027099003|261021121427099003|261022105027099003|261009223027099003|261028144727099003|261026121527099003|261026140227099003|261102123227099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	kF4BmGNVojh4RlqI4BRzgeMjHSytLoM9AjiQQRQEugch8vVdq83FHr77kLs3qAgAiCeIHgY4mY4YmyXqSL4tq0GRV9Mlb70B6I07xZh8o2JiIzLsdQuNHHsnlrNJNBUkf5ttDd83W970R0Hz8bTBJfByaZ2NywJhHtuLz/kbgwXVe0UK4L8trcCEeHUMA1afWg0kaZCEf5HDSm7acL7SkOuVTLx2S3fwRKmvbzQV9RAylaC96vb0RnDa155ZNsUg40lXnEImdHvV0CXk54RjzFED8RaO0e/bSniEN6cITBuJ6ure1+Cokhydt30K9Xo9Jop/+ZeDcjP2qBcBa6W+IbDeC7i3HcaBzgT0nAAM0bDrBT72iqttuVW0qvbDC47TyxJufIAW9vvPOGPnSRg/ULmp8xv09+tIL+4enXhUFFwWyGOT/HS63xGKUy7Jt8Q6N6Ee50Wsudr8dapYZEbLjY9tEsS+gqQv1MvvdKTKumhKPrdAMxCYypb6cD1bEsA6mC6lLWIqqGX1C+77BSOh40E7vhNDmFh0JCZawFLNUbXcrXFeM8KJ1yoIQxCJqMpvK6KFygWeKfI9iscDhntKB6t2n2tWJ8D3eSvPdPfYq50L6yEguAe9EKhOVXsflV/YCvvYFAr6Na7/rVAh39nnbZNC/H+nmukKyQ2E9v2Q0nIfH4NJA39RPHmhxakktVUOqVaQvD//fKs95ZEbDbT5Zw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700016)(1800799024)(23010399003)(82310400026)(10067099003)(56012099006)(260925021911599003)(260925021311599003)(260925022911599003)(11063799006)(261021123027099003)(261021121427099003)(261022105027099003)(261009223027099003)(261028144727099003)(261026121527099003)(261026140227099003)(261102123227099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	9TojPCM+KzPp2DD2hJhNelkUfVoBJDcs9ifcyZ7nMkmLAL8GYMJCcCo9HmosALY8CFwdlaCEtd4mPy24ECf4ExN7NQEAr2eKma52cAcOAphE4dh3LoYcMDEdOT8aww17nYOPGW2hEG1uX8MI57G3hYgWJWv5paWArKdIOUFBIOhHKpnu9JTTYtqN+UjAIcmHv/m61BALA2Co0PchpkDD8Jk3vdVBeZ2XJ8UIH5mWkpXaUG/ghcESTt7v45FMcr0ryk6F3csxdxTMh9MLKHdf9h8zFKCaiNHnHwSB7zXSrTGRSPxcvW7j77WHoAm10jodp4CdEwi9aX76j05H5s8zjUrQLQnXh6dF35cVo3kXdh+PatZtL+KXws6Iqv+Hrl3JtUXmjIDRJbFPBvuHJZ7bfp8YK1qJo0OZZ5b16Jwm9x7qFl9zY0/HeoPX9N++H9UI
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 11:56:18.6505
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b9926ba7-2251-42ea-9e63-08df4c7d72a2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002327.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8368

Current amd_iommu_complete_ppr() derived GN bit from page table
mode. It also missed IOMMU passthrough mode which also supports
PASID.

Pass GN in from the caller instead: amd_iommu_report_ppr_err() uses
EVENT_FLAG_PPR_GN, the abort path copies PPR_FLAG_GN from the log entry,
and amd_iommu_page_response() reads it back from
IOMMU_FAULT_PAGE_REQUEST_PASID_VALID recorded when the fault was reported.
Fold __amd_iommu_complete_ppr() into amd_iommu_complete_ppr() now that
every caller supplies gn.

Fixes: c94252cd5bbc ("iommu/amd: Fix GN bit setting in COMPLETE_PPR_REQUEST command")
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/amd_iommu.h |  3 ++-
 drivers/iommu/amd/iommu.c     | 19 +++----------------
 drivers/iommu/amd/ppr.c       | 14 ++++++++++----
 3 files changed, 15 insertions(+), 21 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index 29355810db7c..0b79f44b6744 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -82,7 +82,8 @@ int __init amd_iommu_alloc_ppr_log(struct amd_iommu *iommu);
 void __init amd_iommu_free_ppr_log(struct amd_iommu *iommu);
 void amd_iommu_enable_ppr_log(struct amd_iommu *iommu);
 void amd_iommu_poll_ppr_log(struct amd_iommu *iommu);
-int amd_iommu_complete_ppr(struct device *dev, u32 pasid, int status, int tag);
+int amd_iommu_complete_ppr(struct device *dev, u32 pasid, int status, int tag,
+			   bool gn);
 
 /*
  * This function flushes all internal caches of
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index cd9179319709..1220891e3d90 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -90,9 +90,6 @@ static void clone_aliases(struct amd_iommu *iommu, struct device *dev);
 
 static int iommu_completion_wait(struct amd_iommu *iommu);
 
-static int __amd_iommu_complete_ppr(struct device *dev, u32 pasid,
-				    int status, int tag, bool gn);
-
 /****************************************************************************
  *
  * Helper functions
@@ -907,7 +904,7 @@ static void amd_iommu_report_ppr_err(struct amd_iommu *iommu, volatile u32 *even
 
 	gn = (flags & EVENT_FLAG_PPR_GN);
 
-	__amd_iommu_complete_ppr(&pdev->dev, pasid, IOMMU_PAGE_RESP_FAILURE, tag, gn);
+	amd_iommu_complete_ppr(&pdev->dev, pasid, IOMMU_PAGE_RESP_FAILURE, tag, gn);
 	pci_dev_put(pdev);
 }
 
@@ -1853,8 +1850,8 @@ static void dev_flush_pasid_all(struct iommu_dev_data *dev_data,
 	amd_iommu_dev_flush_pasid_pages(dev_data, pasid, 0, U64_MAX);
 }
 
-static int __amd_iommu_complete_ppr(struct device *dev, u32 pasid,
-				    int status, int tag, bool gn)
+int amd_iommu_complete_ppr(struct device *dev, u32 pasid, int status,
+			   int tag, bool gn)
 {
 	struct iommu_dev_data *dev_data;
 	struct amd_iommu *iommu;
@@ -1868,16 +1865,6 @@ static int __amd_iommu_complete_ppr(struct device *dev, u32 pasid,
 	return iommu_queue_command(iommu, &cmd);
 }
 
-int amd_iommu_complete_ppr(struct device *dev, u32 pasid, int status, int tag)
-{
-	struct iommu_dev_data *dev_data = dev_iommu_priv_get(dev);
-	bool gn;
-
-	gn = pdom_is_v2_pgtbl_mode(dev_data->domain);
-
-	return __amd_iommu_complete_ppr(dev, pasid, status, tag, gn);
-}
-
 /****************************************************************************
  *
  * The next functions belong to the domain allocation. A domain is
diff --git a/drivers/iommu/amd/ppr.c b/drivers/iommu/amd/ppr.c
index 2039a9dd71ac..1181dc31795f 100644
--- a/drivers/iommu/amd/ppr.c
+++ b/drivers/iommu/amd/ppr.c
@@ -144,8 +144,11 @@ static void iommu_call_iopf_notifier(struct amd_iommu *iommu, u64 *raw)
 		goto out;
 	}
 
-	event.fault.prm.flags |= IOMMU_FAULT_PAGE_RESPONSE_NEEDS_PASID;
-	event.fault.prm.flags |= IOMMU_FAULT_PAGE_REQUEST_PASID_VALID;
+	/* PPR_FLAG_GN means this request carries a valid PASID. */
+	if (PPR_FLAGS(raw[0]) & PPR_FLAG_GN) {
+		event.fault.prm.flags |= IOMMU_FAULT_PAGE_RESPONSE_NEEDS_PASID;
+		event.fault.prm.flags |= IOMMU_FAULT_PAGE_REQUEST_PASID_VALID;
+	}
 	if (PPR_TAG_LAST_PAGE(raw[0]))
 		event.fault.prm.flags |= IOMMU_FAULT_PAGE_REQUEST_LAST_PAGE;
 
@@ -157,7 +160,8 @@ static void iommu_call_iopf_notifier(struct amd_iommu *iommu, u64 *raw)
 out:
 	/* Nobody cared, abort */
 	amd_iommu_complete_ppr(&pdev->dev, PPR_PASID(raw[0]),
-			       IOMMU_PAGE_RESP_FAILURE, PPR_TAG(raw[0]));
+			       IOMMU_PAGE_RESP_FAILURE, PPR_TAG(raw[0]),
+			       PPR_FLAGS(raw[0]) & PPR_FLAG_GN);
 	pci_dev_put(pdev);
 }
 
@@ -241,7 +245,9 @@ void amd_iommu_iopf_uninit(struct amd_iommu *iommu)
 void amd_iommu_page_response(struct device *dev, struct iopf_fault *evt,
 			     struct iommu_page_response *resp)
 {
-	amd_iommu_complete_ppr(dev, resp->pasid, resp->code, resp->grpid);
+	bool gn = evt->fault.prm.flags & IOMMU_FAULT_PAGE_REQUEST_PASID_VALID;
+
+	amd_iommu_complete_ppr(dev, resp->pasid, resp->code, resp->grpid, gn);
 }
 
 int amd_iommu_iopf_add_device(struct amd_iommu *iommu,
-- 
2.31.1

