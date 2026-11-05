Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.57.59
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793854135;
	b=fk1HTI3D/Wwec+ce9Ji8rA5ZR4HScL50V/lHaUcPl7wj6YB0dT2ti/Ioi2HjMo13q1AF
	 bCnf9wdS8ySOy6o0QFVKBRauprYib9YXuQx7LZpT9sS2PuOQvX/xzrZF7JJt8/gbB2gNd
	 ibWTvsuaLGmfuJavs37zjVXHzFGR77PtlZnN/Dp6q4VnWXDry21ZOev35PQE5X19YKRnt
	 i/jRmEaLNDYxByrWd6Ge8WLVWQgN8KXZqRPCbgMLYbsLezXNuWy1Uni5qKfcF/0te+KND
	 /Y0SQQzfN7UoFU5wAeKBeuheSMHBqpDZvAdl1mtx3f2km40Uxk3zg94MA2yQNGrb66w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793854135;
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
	bh=J9cjtSHQXW3XCb8A+4JFN5W+RLMu55Cqh7k3LAC5N98=;
	b=2xnu4mbc3HoUkWo1vDQrAPn8TthGCylCOItOBfotCEnq1lGDHdr00bm4jkwpwvdUOdPo
	 mUC/GverQtc9eq/VXnDePc2LIp3uhQ8BTQ4jgXxa+fbyEirHBmusQgCbhjH/y2zyZzl1u
	 czyYZH0Ic/VCLkvljzOAArtrMksyBIib/sq/n4UPVijo8VwqH2pQsOhH2GAzbFwgAUHwM
	 x7ovVjhW0zzkP3u1tY0yPlWNP7ny+3VZfXx0nvFZo/26dhpBoQO6X3kHmN8vJPPw9JSnd
	 1FCh6KGQ165VCw/vuHLTlkN1Pgqe80rTj/xlwPVRqswPHwjSvReygzTILmjOxnQMH4A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=IIUzoj52;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.57.59
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011059.outbound.protection.outlook.com [52.101.57.59])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 619AA606A32D
	for <iommu@lists.linux.dev>; Thu,  5 Nov 2026 04:48:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 619AA606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=IIUzoj52
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dyydiQAWZjQXNMRhEjQtiqgc3HgUSHPDo6QMpBuZpmzwTJyMLh9Et7aBt4aJ2s5I6RwaJjKNZcy/61d9EedEK2yi1xx8Kh76l3Weyr7cshsnWw3X7Nw75skZsm3eOq6zD2d4pd/Dl+oZ6uRaM6TiH5XMhVT1rgc/cXiDW/WMKbXyD/yvzq9QHBLSLh202J3lrFiX1Qggzv58xzcuTAOhMZ/GfFXfJyZP+DSj0ML9m3hnptyI651Hx0f/Qh6lDrkdoU0CbqQ8dc/JePrpxhBuShGBAWA/0XanDLMjMfhg6dbx4iinc/7mRhuVKSnXy7AJKBeqeT9hOOmJMyaQEJ5E5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J9cjtSHQXW3XCb8A+4JFN5W+RLMu55Cqh7k3LAC5N98=;
 b=VyuIvK+yCfRBZ282venkju0M7i2IQTuoXbJkvagawkecLxB0BAaYNxqznBcjEc/sKMilw3UHsUZOteL1PB1wIKlFqY7OiXccQuT2BXNBCD+j+Hm199rPyyxbxhsas7nU2CU5G9Uki4QAxTKgyg6Z1ba4u+tzsOiFyxagCKJkGAzfMAvXzBxdhRNa3/evDIq2mZKF2iv0p1kKNbKWTfS1N7/weqYcgAJLbDA9PSV2Eezdx4zHQDZIW8x+q7/cE4X8QNzpSJklrYCjErV6NHtwanMO/I1E0DELFGe2qSxekWjMyDD0DZ6IXWkA1PS+f4a+1KhwuKJxzHvImamR9HMflw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J9cjtSHQXW3XCb8A+4JFN5W+RLMu55Cqh7k3LAC5N98=;
 b=IIUzoj52yMCRFfeFu75a3ZdsA/KZdEOk75rDqcdIGYpVpfZHBIpjUUz3xfsqUQ8B5YAVsEY0JVAqljMPrH2zMvLeMrBUL4xwnjcj4TxsYQaFA3qiESP0QTwXuSzBOB+4MYRyxVWmFia3Pa8zQ1QEyfbujjp8jy981G174d2w3jU=
Received: from CYXPR02CA0017.namprd02.prod.outlook.com (2603:10b6:930:cf::12)
 by MW3PR12MB4428.namprd12.prod.outlook.com (2603:10b6:303:57::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Thu, 5 Nov
 2026 04:48:49 +0000
Received: from CY4PEPF000392D7.namprd03.prod.outlook.com
 (2603:10b6:930:cf:cafe::60) by CYXPR02CA0017.outlook.office365.com
 (2603:10b6:930:cf::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.10 via Frontend Transport; Thu, 5
 Nov 2026 04:48:49 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF000392D7.mail.protection.outlook.com (10.167.247.117) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Thu, 5 Nov 2026 04:48:49 +0000
Received: from kali.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 4 Nov
 2026 22:48:46 -0600
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <will@kernel.org>, <robin.murphy@arm.com>,
	<suravee.suthikulpanit@amd.com>, <jgg@nvidia.com>, Vasant Hegde
	<vasant.hegde@amd.com>
Subject: [PATCH 02/12] iommu/amd: Derive the PPR completion GN bit from the request
Date: Thu, 5 Nov 2026 04:47:51 +0000
Message-ID: <20261105044801.399466-3-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF000392D7:EE_|MW3PR12MB4428:EE_
X-MS-Office365-Filtering-Correlation-Id: 31a0b66b-87d5-451b-30cd-08df3af81558
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700016|23010399003|6133799003|18002099003|22082099003|261009223027099003|261021121427099003|261021123027099003|10067099003|261022105027099003|261028144727099003|261026140227099003|261026121527099003|56012099006|11063799006|261102123227099003;
X-Microsoft-Antispam-Message-Info:
	Ek4GH9HioyDIfgMO6R3gwfFuugAjNTjyUH5vEdhTOMxYruENdBHIuHQFtqoQn2csS0yG/FuQoEg0LE2gXzCRyqO/kRhtT+oUxhy4E+wGLW6KXNaMV+fD7nKjhfVjl2px9cMlXbFROGQ13fCZTi7SqVYFzpwo1oXnt/jiGqN5H10fop76cwjVYDAmYGI8/Z/1EKZ+wJTw4uy+QVT0/3/S0dQFRrMaG+/BsqOrp9W/rFyfYhM8P45bsBl+yqdPIrrJlp/tqJyER45eYi2IUF2mVW5SRnnqRWvk8W1WhWso6Kh4F/OAt94Zqlhl9f7Ml4PWgw26Hg2kp9/NKcx/XYBPKcqZCHkP/ZKmWZV5EPvearcT440kP2X0TGmrwFOsEd6dDFfM0RZGDM+q95UxbxyQc50yCDMuX7J9EsSzMfOCTKI/S6uotnzYS6epF5Q5nJ6lrvHCUM6NRymeUIoRwmf/k6tas0pANry0YS59DJETloOH2Wij7PoDNlk3OBD3btJMddPqxm3OKy4nSyXKMWuX5L5oiTqvxXgHHO0FwIv7U70zupkg+Fal5DQdZXuVjOR8aqXdagqOe9FXwqDzx8+6pCrJ2W3bZ2lHD4gIxnzQ3PGelob8xI+wXx/QEg/TEoCfLaVeGzLfOkUwW806EzHptM81CLjt+jB6GkB2HBeulG9qOnFLyilClYgdz6ZH9TW/oTqaynN2gagyMBFTJgt7IQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700016)(23010399003)(6133799003)(18002099003)(22082099003)(261009223027099003)(261021121427099003)(261021123027099003)(10067099003)(261022105027099003)(261028144727099003)(261026140227099003)(261026121527099003)(56012099006)(11063799006)(261102123227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	8iFctmfZSjcrYK77PTTInrxvqTyr6G8d7eOAeUgSAZuxUAEzCO0vXsrNJwmut+JiBJqqc0xSNtlFelLE4q6U98lFIxkPSL8Lzgl0kPLhnFn510kxWlTrGgLz2VPLWHdIzFxgSxur02Ks59yh22c5bwVEDIyOi7p2pHZjdfeYVWvQDIBAcszxnv5NZaGI1MfhBNj7Zm4V9coggHW/N4cHtzY1hMt/hrKNMm9QYzoDRlXm9h5zMMqttmKyL59KLDcf2tv3IDk1pxCNS0a7xHzG3iX3qsIindJWNtMEZfP+/edY0giR47aED9DrfmaJYThAbElFyZR0n2+3sjflLnD/0L/qPnmcYoCy85DXAb6ugQ/8gOIYWCCLIE0+oZJkF8uNGMy3losamXGZNOOYQexVqtTS3H1A87fRa0dw97KfBpWlyj8Rg81wfnqyniAmi0gC
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 04:48:49.3420
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 31a0b66b-87d5-451b-30cd-08df3af81558
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF000392D7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4428

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
Assisted-by: Cursor
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/amd_iommu.h |  3 ++-
 drivers/iommu/amd/iommu.c     | 19 +++----------------
 drivers/iommu/amd/ppr.c       | 14 ++++++++++----
 3 files changed, 15 insertions(+), 21 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index 93845b3c3fbf..4546f8be34ef 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -83,7 +83,8 @@ int __init amd_iommu_alloc_ppr_log(struct amd_iommu *iommu);
 void __init amd_iommu_free_ppr_log(struct amd_iommu *iommu);
 void amd_iommu_enable_ppr_log(struct amd_iommu *iommu);
 void amd_iommu_poll_ppr_log(struct amd_iommu *iommu);
-int amd_iommu_complete_ppr(struct device *dev, u32 pasid, int status, int tag);
+int amd_iommu_complete_ppr(struct device *dev, u32 pasid, int status, int tag,
+			   bool gn);
 
 /*
  * This function flushes all internal caches of
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index b8cb937c79ac..883901118ace 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -89,9 +89,6 @@ static void clone_aliases(struct amd_iommu *iommu, struct device *dev);
 
 static int iommu_completion_wait(struct amd_iommu *iommu);
 
-static int __amd_iommu_complete_ppr(struct device *dev, u32 pasid,
-				    int status, int tag, bool gn);
-
 /****************************************************************************
  *
  * Helper functions
@@ -902,7 +899,7 @@ static void amd_iommu_report_ppr_err(struct amd_iommu *iommu, volatile u32 *even
 
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

