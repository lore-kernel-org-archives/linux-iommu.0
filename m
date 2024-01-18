Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2056.outbound.protection.outlook.com [40.107.95.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1B28947F
	for <iommu@lists.linux.dev>; Thu, 18 Jan 2024 07:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705563268; cv=fail; b=Mj1g2qerg2eks0ekeDUkjBFME9Vz0Q0sjXRxv5SPdRlJYwI/X9IYlNok9q++5OMB7Wh0Z0hXwwD1l6pBUf9kNnZv4XU1H1nSEDS80ED1VpSQhfftVFpL9mt91FZwWmd3szFMxYgd9YEQzSFANKO2cCBlKUADQx2ePfxGZdz+I9E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705563268; c=relaxed/simple;
	bh=8kneTi3aY2lFbMBdhnZ1aMgI4Sy8zZgFgMwJRHQc+VA=;
	h=ARC-Message-Signature:ARC-Authentication-Results:DKIM-Signature:
	 Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:Received:From:To:CC:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy:X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped; b=eaZ7K3xAX9EDI59JSn4389nXa7TdEbdREzA0Kh+c0be1JM5rd0laakeGZDuS1GaN9+Mqybea7K6xcFkPolyrMqwOAmYof5haH4rR1P5Ihz4Z4NSchjn66N03h1Yut8bwXJMsb75OgrIz5hhVqezv5kOQhNp1ehdNlCQQzm8WMRk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=LNNg+tZl; arc=fail smtp.client-ip=40.107.95.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="LNNg+tZl"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OylgrJzryvxfk+xkdobV9+qE09Gi9oDg0OIsrfRBzJ3DW4ubEhaid0/Hnt6cdafClBedgdEmVBMmQxjPYkqYmHHtR73mObdySJnM6IxcFPMXS2btQ/KnWn1bUbUIyRSvvXG1Ajsd2VU9yn6iCf1RtiLLvx7U4eUsfjM9453zI/wG+VOJKyZxRB+oXHiCyADOEINh+Yh4GBbietEnnfQ49RvBYnHUCUJpnhNOF4czSgGHGTJDAJA3Ohv484sjDdZY3zw1ruucrdgOni4I5D33XF6pEeTZ4Ibu1jebs7blwStf9gmJxVYfy3sonCeP8wyAfKgmoIzGBenv7VcZMw7lzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bRVcOQOUfSO6JXhvDDfP8gDNBCokOQ4rQWvbcppgRF0=;
 b=NAOemTzcdDrMR4DjmQwwolnG0/jSIZdSdyHIfkwB59bUbx8JHkZXz2kQXcUI4W2S5Tvc1R5H6KLN1DnpTchC7El1gYRdn2n/i/0p8mWQYNYBo3kHKULqp9ccsr99hYfOiLoGB70T17ob8BSA9eP5j4D0fZvQHTrKTClivKG5MuHi2RlTUJA5Oeu9Im8qIiDrumVe5NhBOc6dThJLY2OnGPtLkIE3HuNOEOkoY9cSfyGJSK+EV8OkI0UhOCFIO2MjqTMMQCytYQma0QlrRGJ+L6fIzw+jekNGO98Zqp+54oJTXLIPZSYbAk9QhYuwdyc3CiPKWMRlciFhF70kWKblFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bRVcOQOUfSO6JXhvDDfP8gDNBCokOQ4rQWvbcppgRF0=;
 b=LNNg+tZlIR0sH1FseM5F0h0WV7JiU44qEa3oA6qP+LyFlfVxk4cxo6rGwNYp1XF1ffDV8r+IvqCqtn3fPU2ieKBSOiZo770dLFsgCS1X/lsqOe98jv/5BBf2fyfzWOf7YTnif2hCXzZiIapppmjeZHnf/Di0EVrbbyNZyoTk+sM=
Received: from SA9P223CA0030.NAMP223.PROD.OUTLOOK.COM (2603:10b6:806:26::35)
 by SN7PR12MB7810.namprd12.prod.outlook.com (2603:10b6:806:34c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.23; Thu, 18 Jan
 2024 07:34:23 +0000
Received: from SA2PEPF00001509.namprd04.prod.outlook.com
 (2603:10b6:806:26:cafe::7e) by SA9P223CA0030.outlook.office365.com
 (2603:10b6:806:26::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24 via Frontend
 Transport; Thu, 18 Jan 2024 07:34:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00001509.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.16 via Frontend Transport; Thu, 18 Jan 2024 07:34:23 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 18 Jan
 2024 01:34:20 -0600
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v5 01/14] iommu/amd: Rename amd_iommu_v2_supported() as amd_iommu_pasid_supported()
Date: Thu, 18 Jan 2024 07:33:26 +0000
Message-ID: <20240118073339.6978-2-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240118073339.6978-1-vasant.hegde@amd.com>
References: <20240118073339.6978-1-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001509:EE_|SN7PR12MB7810:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b91a0d8-ad40-4162-8c68-08dc17f7e439
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	SSC5javqZ3+KACdEuaCYUrlijVR8CNF2kSCM/U+yvdVaKtzu3NkX6B6lUSncGrri6fGzQkOHHI57xe41hXYN1ioTU4im/Y9sSECcpuMsSrhKw7ZfPrkzFKr5zMREG7svnSZOwCUuHQXoEKG760wNn77G8X1TttU2GhQGJVShQPOxHzADss72Rhtg/n8ItDNAofPTuUPmPUCrYppJLCeX9daShI0HZ/S5rogNo86/4iJqqjf5qcmTmR00ifhbU7VQCIuK3+JPPxW0CufN27RyhgaS7jlsOkRb35bjN0YnqKxFOCbQbpDZGOm3eludqGiVEvNSAPPtIlaTrE/jg/MRTkwz0/QiSea2RSvjiOoJ2TStVj26whfMNJysBDC5sjs+4C6LtnBZpc9ejqaaON625nX5/yIW2Y3Ekun4cij+voibrvEvxijEnNLT8E4RaP6s7ntDItl0VC/nkm/cYkZyuYbotGkLiriUi7mlTnjZQ4TTfmWxGdc0tlnnyN0Bmk+1jjflI/XwJeUBjblYE9yRvxLxMm/+lHThjLRyeSymEn3hSXFLRdR1moY1SdrCPhx6r26w4tKLo6lbE0oeTHAg6REO+VA1xmgHW8rGulUamxLKofV6aYA/I1OULpVHav5/auT3F8NWWd1/hDGm4p50e/aA8Ix2SB4RuJQJWNz94SVGBS1tHrugEr6NXIXJZkkAf2SpEUQWZLCR2thJZV0cJpgHtwpSSxBVGWQ0XnbE8XYnB4dRxveFP/9lce9YXi+PXCq6tYv/10sSDysGQuH48w==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(376002)(346002)(396003)(136003)(230922051799003)(82310400011)(1800799012)(186009)(451199024)(64100799003)(40470700004)(46966006)(36840700001)(82740400003)(7696005)(36860700001)(26005)(1076003)(336012)(54906003)(2616005)(16526019)(40480700001)(40460700003)(426003)(356005)(81166007)(478600001)(83380400001)(47076005)(316002)(4326008)(36756003)(70206006)(70586007)(110136005)(5660300002)(44832011)(2906002)(86362001)(8676002)(8936002)(41300700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2024 07:34:23.2480
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b91a0d8-ad40-4162-8c68-08dc17f7e439
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00001509.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7810

To reflect its usage. No functional changes intended.

Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/amd/amd_iommu.h | 2 +-
 drivers/iommu/amd/init.c      | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index b61293f2aef6..334394d14753 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -38,7 +38,7 @@ extern int amd_iommu_guest_ir;
 extern enum io_pgtable_fmt amd_iommu_pgtable;
 extern int amd_iommu_gpt_level;
 
-bool amd_iommu_v2_supported(void);
+bool amd_iommu_pasid_supported(void);
 struct amd_iommu *get_amd_iommu(unsigned int idx);
 u8 amd_iommu_pc_get_max_banks(unsigned int idx);
 bool amd_iommu_pc_supported(void);
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 959820ccfbcc..62f695c519b5 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -3652,7 +3652,7 @@ __setup("ivrs_ioapic",		parse_ivrs_ioapic);
 __setup("ivrs_hpet",		parse_ivrs_hpet);
 __setup("ivrs_acpihid",		parse_ivrs_acpihid);
 
-bool amd_iommu_v2_supported(void)
+bool amd_iommu_pasid_supported(void)
 {
 	/* CPU page table size should match IOMMU guest page table size */
 	if (cpu_feature_enabled(X86_FEATURE_LA57) &&
-- 
2.31.1

