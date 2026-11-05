Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.194.21
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793854119;
	b=II5vUmrQ3miQwmktn3pdJ3+Cq8DyHWjpGVPRgMa2XzQCjmS0XrClMDO5hGfQrO/Rr0V7
	 XasdPtPKwNovGfPLGWA1m25ND6eoTMQSdldzlGqW+ETXVhyGWRUe68Ou+MT+95NoU4JMl
	 PQkwuBdxvVJ938e8VANybHlCtXf+tXfpRqBCYmSoYaIIH1EGr1dr7dXuBR9k8n3p15bkO
	 LJgfZCriOU9cEbWkV20zfJT3HYfDleHD8GaojLckTlOrRTjjsm3thE+zrAxK6f2BSjqBV
	 3j00tyRQbQSu6btzcFypMdNHjXwhpMitOvF36jIYdmDXAUEHQK1HR1d6frl9tXcjCBg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793854119;
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
	bh=O2aJXmw5D840l0aUilBh2gDx6FeflLGo0Bfiuo3XIjA=;
	b=qLDsjG5OplQwtkOihvcZmgG3xw9igae5qcmDbfJTNORUoKmNxSd2bgyycCoGVI+0pTBA
	 1iSig8nF8UCOYD6ZbJ2YxFuvgrptqt6onAnQV7Pg5k/rpeGrGRbfU0saiQvAkCxx6KEyQ
	 /9k5j6JiwFzhcwf4XZ/7gVR72eRWdltkAz3mrY8K2NNQ0WxQYEJL/r3nm94Av/fRjE33B
	 ENwo5vYuGODCrdxXFGg44Nd8pwOX7JShbmCDtLXJB2Ighpx6NOB9eZcrJQIUc/LMx5p4b
	 hpVcRWKgJOIg2VnCKCTdEEhBcPHVhYxvJveVybxzpsBDm8LsfqC3yaNhMLoGek/E5dQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b="PL35/9sh";
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.194.21
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011021.outbound.protection.outlook.com [40.93.194.21])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32F45606A32D
	for <iommu@lists.linux.dev>; Thu,  5 Nov 2026 04:48:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 32F45606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=PL35/9sh
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eVKWM53UGtEmOjstUklZCJ5EW5iisG5GkR7NzUrtvlNrXULNIgG0sfGE/5oqbT0aNoSuvtEN4GllathV/TdpplMt324PjhCb7oNCATx8N6QJCahG0FGDTk9GjiBI1+sNJMgv3SQevs8pFhvQtaY5fmLCffD4zWhExUmr4Nc2CoQCF4DyeE2+4w5Lo4wlzp+Wv8Q1JYAWSljGCHUv6Vej9A5+UOC1q2GdN+mCeC1nP4Puo1qnh/yig/O2KWDBsrsheXZEhoY5dipC48PWjC5NlEgPphhZxJEJ+SXTLdGYuaeipNp0GqpUxp+oDP112joySNkN528LUcpZGBhZ23wwIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O2aJXmw5D840l0aUilBh2gDx6FeflLGo0Bfiuo3XIjA=;
 b=AXyCxWSOMOOrOwQeP9d5/HrERqJnsssn3gmvdrNMt4o5Vm8pAcXaH/C8GfGGlrgZsriVW+blhRNdWB+w+0ngAqKwVLNVaH35srIJLjNHhkioaxfRnT+v2rFj2qDT+uXg2rs/kQs23AffMtv4lUpQIi4Tjfz42dM6VSP2fHDTgaOleKeMQlBbL+WK9HDlTMS5wn/kdEzvXshlJ2pbHDWVnlhu9p0SeaFAXo9zIZ8lJJC4eo9bOlmriqv4CtMu9P/Cw8QaKtf7KTsZHWW1uqDjc0iFGpsiYEPo8KMNuavJnjWB0Zwtfe77NhDWze+xNHhVc8fi3yUTKW7XRzLHG7w4RQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O2aJXmw5D840l0aUilBh2gDx6FeflLGo0Bfiuo3XIjA=;
 b=PL35/9shriSYq8U8AOZNv6k7wtaE2mTZqXhIuCBP00aH9pEtkdKTuS278gMX3+ww1PEazVmrslURgsZwXvavdSuCZcLWVScLUY5/GP3L1NQH67EBM7CjUoF6MzjwEEprH0WjMsW+1hEaT5jFsRU/DgEqIZh/ZHYwcBARifxRz88=
Received: from PH8P220CA0058.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:2d9::32)
 by SJ1PR12MB6172.namprd12.prod.outlook.com (2603:10b6:a03:459::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Thu, 5 Nov 2026
 04:48:34 +0000
Received: from CY4PEPF000392DC.namprd03.prod.outlook.com
 (2603:10b6:510:2d9:cafe::4b) by PH8P220CA0058.outlook.office365.com
 (2603:10b6:510:2d9::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.10 via Frontend Transport; Thu, 5
 Nov 2026 04:48:34 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF000392DC.mail.protection.outlook.com (10.167.247.122) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Thu, 5 Nov 2026 04:48:34 +0000
Received: from kali.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 4 Nov
 2026 22:48:31 -0600
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <will@kernel.org>, <robin.murphy@arm.com>,
	<suravee.suthikulpanit@amd.com>, <jgg@nvidia.com>, Vasant Hegde
	<vasant.hegde@amd.com>
Subject: [PATCH 01/12] iommu/amd: Disable PRI before ATS and PASID
Date: Thu, 5 Nov 2026 04:47:50 +0000
Message-ID: <20261105044801.399466-2-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF000392DC:EE_|SJ1PR12MB6172:EE_
X-MS-Office365-Filtering-Correlation-Id: cf40a309-97a8-4951-b989-08df3af80c3c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|23010399003|376014|1800799024|6133799003|10067099003|18002099003|22082099003|56012099006|11063799006|261028144727099003|261022105027099003|261026121527099003|261026140227099003|261102123227099003|261021123027099003|261009223027099003|261021121427099003;
X-Microsoft-Antispam-Message-Info:
	qxwgoGfYzqUHBEU83MN1LYeqtJF1IZCfStBfLU6oFZ9ZSySc8cJtV4sdtc7/6VixWOv2O+UBeaFk4vmQKVuAp5i6kdgwClF8i8Lt0KgZjFy/Yp0k0nd/M5KDQUTWDfU2MRBPH4IL2C4kQX3nLQk3b9xO7PnZJAtcghxZYpjiAwacSrHYj01Pr2a832YVS74P9QK4zFJCDlWE2DZMFUbGYXYy+3BVPHFT4MzYgqb2+xgX4qh/2D75f6dPgQ3KYsd7fRloD++3GKWmadgltQIQQeBMwU6oEFS92cqN6EAGROZPLVnbpDgMHxQUjt96yABncUEwjYFNESAE0p9e892b3/iHyFNyw9l6HmZdTx0tE6gRKt9oW7CDIfnul7uDp/plyL4krhg7UGruBCVwzJwkBoS8/djlV/4UGNqJFAoiAt89HGxVNzE5mNg3yP9/5h9UNSlf6oNw0mPVD1UseaSuozlqW0X5kr5QaDnuVng4ORoEWKZofxLaMULt7Dxh8H3sbTVddGZ9i//383ISMY8OjoEFV8IUB8AfWMNfIqPbwnKeJ82qsaVtkrD9Zz7WfSZeoZHiZs8aKQJyrLrbHrkygFk3y/mNZWdF+jcxJY5byIjsP4HtGAWAsSMGlznUBteBV/gKddiAFlsx/9RKUau0GgohcRL3nfx3dsq+kY5ekWOrgoZtDN1ChTZr2KlsniiVeNvvP3BtvNBP2BtLz3H5Xw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(23010399003)(376014)(1800799024)(6133799003)(10067099003)(18002099003)(22082099003)(56012099006)(11063799006)(261028144727099003)(261022105027099003)(261026121527099003)(261026140227099003)(261102123227099003)(261021123027099003)(261009223027099003)(261021121427099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	nW85MUcTXObDduyYPEYFTcQIh/UeBQzA+IBbAXM+1sTSL9P3LmidJeTzZRdtY/CCPpTRTdqwcuRyWRhBqETOsbEwfMFNrkiRedsbSzHCN5NbqsTJoF2H8i58voaARNriarolrnBCSTOEjY8zqFHOO2/1w9uJgudVn3YKErdB+ZEwMTtudbgF5VEqfRs3PD1JnlD2KNlC6Ge3prD9utVGsMDktZXiINpZrpBl9/SXCvVDguGBDuxyY9PRyh7p05uv0foIBUQoezqzbK9LV2ieL8vMfnDnY+szcE/+lwXGVVVjOKcx5oQaAXKucK1pcmx2B2wcKMp9vK0G8nFXfQVZc+xrxJ9qe6wtaDWg+sChOKr0qLknFcfQLwfhJ7YCsnKztEYBSXK6R172aTrHI7G9R5x282+3zptA4EVJJJtxS/nPMntbJa1np4JWXi/rOA2+
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 04:48:34.0586
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cf40a309-97a8-4951-b989-08df3af80c3c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF000392DC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6172

pdev_enable_caps() enables the device capabilities in the order PASID,
ATS, then PRI, but pdev_disable_caps() tore them down as ATS, PASID, then
PRI -- not the reverse of enabling.

PRI sits on top of ATS: page requests are issued for failed ATS
translations, and with PASID enabled both the requests and (when pri_tlp
is set) the responses carry a PASID prefix. Disabling ATS and PASID first
left PRI enabled on a function that could no longer issue or accept such
transactions, while page requests might still be outstanding.

Disable the capabilities in the reverse order of enabling: PRI, then ATS,
then PASID. This also keeps ATS disabled before PASID, as required by the
PCIe specification.

Fixes: eda8c2860ab6 ("iommu/amd: Enable device ATS/PASID/PRI capabilities independently")
Assisted-by: Cursor
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 2ec0a598d829..b8cb937c79ac 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -651,9 +651,9 @@ static void pdev_enable_caps(struct pci_dev *pdev)
 
 static void pdev_disable_caps(struct pci_dev *pdev)
 {
+	pdev_disable_cap_pri(pdev);
 	pdev_disable_cap_ats(pdev);
 	pdev_disable_cap_pasid(pdev);
-	pdev_disable_cap_pri(pdev);
 }
 
 /*
-- 
2.31.1

