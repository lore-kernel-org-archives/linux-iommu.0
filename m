Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.196.14
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793851270;
	b=ZXOwsnIhOJc0cpqDzRiakBnn+g3ZTzdXXpg+BypOLnkDxY1r8NUSlxUUQNSsly/B47ed
	 mw+NYkCdizG7e3NzMbBu0xJWgiz6ffn8iBHx2FsmvgswNGvWQu30fYRn40jXCvOPJ09YD
	 h2o0TovB5G3EcXVmJqBeYCA+lQfDiyd+dko07d83OK7sfO2eQcOr01qStpw2DaANpNLh6
	 o5nvaxv58Sk6oBtaCbbj0pRv8aeshQA2uS1rx+LJOr+qppJdfxVPsDqOLoqxojzKdB8er
	 n5r1vtdBrfIKobsp+Mi86PMcI4LwHSWslFCDJnNjVaZVGRhr4sXxWNP4virZHssu3Tw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793851270;
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
	bh=VxlEbibRHWuEkeqR4bqQbZTkc0ccYhFv3FSPuF81weE=;
	b=w5MGrT/d69EbyJIkMvkcdVxAv0HjnQ+/2ezV6Ta1tvcq9PSMkecqDCLSu0CCPkoBJ4js
	 mv/cssj3aOPKNRzEw2Zh3Klwn7UdT8K0QlVr52/XCD9KUp/OdVzu4QyxieEp9z4UIgjMf
	 GsakUZ+ymfZF9QLMW4moMvlYG0g8epcZ48LM+OS0e+dv/0aAvQ0J4VDA4K2aDMYyaPhrd
	 6z8/8hEuJo8sLMw+p0BnDnoI8HeHeN81Lg+IBeE+wpsf/QNZy6mKXAdFlFMCShn5ejCNJ
	 4uYnEymEPKF11xRn7Xh7A7crF4lf1Xl/zHPe74tqmg2JmFx1cTO6uRTb78LbC5KljoA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=rFPcF+qw;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.196.14
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013014.outbound.protection.outlook.com [40.93.196.14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D337606A326
	for <iommu@lists.linux.dev>; Thu,  5 Nov 2026 04:01:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1D337606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=rFPcF+qw
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pajtzXE2oAVdfeTpknOT+R058Mc/Fe1/sq/uK2FNSydOZ7D+tOuHb4cFQ32m2uVDxMYlxGoz+ukhnw+BamyTbBNh7swJEBjXk9/RyrudRczlBllO3gEh0tuSe9RgcsiQJx6ijgQrRm7HG/EHadI6/H2wAOVjvQ+MZgQtYc2gX9fQuYzRUIkw2KnJAjPvtbk9jQy9xmkwEMXthASPWFt6kOJfPARU1ggxxZKg1A1EuleK/aIJgAHBFN5GpunyZIIcTkdPJu8CfIpzowKEK68Ej5mD2zUUFTluW4rwcn9H0652At6lNAoVAN/tmuPY4u0+jqv6j4nGPw7cA9MD1FdTrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VxlEbibRHWuEkeqR4bqQbZTkc0ccYhFv3FSPuF81weE=;
 b=KQtkE2DoZfpYTrZAMIGOB6kT8oIAoMp64gjp8flbb9EQm4X1yudxetL4X9uKdXGiYvrrR1D/K99ZbdwWzC9oFVcFyd++6bTSw5xA7S5wEg2OZLnjI2uGo7r0N9LGRCTHYupbY3Uff4GVQszZlJw0j2Wkj/RETFG7p9GEHoeAoYUcmn9RGuymK/3MnybtkE0kjyX/3AiADYnJWfzP07SUTGym8fTO8281s/RPiLLk/vqrJLXiyNfr6QaC80Zfn1jF8gHXOalmq5Vhos7GleaJm8S1bTQpL3koc+/89bQw4cwr/PH6dSGkUj16qIrcYloP/SSc2IZxrgmQ+IHEjU58Eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VxlEbibRHWuEkeqR4bqQbZTkc0ccYhFv3FSPuF81weE=;
 b=rFPcF+qwSxJuxJGewxvtlTDl/L7mEn7Pe0BODA7aXV0jdYAmnt6t43Ue3lOzC6IWdkaQJAvZSkIfCTcOc+8UqdpsmddCbVEnSbAb4i/l1JAknCcqI7GET90AbYpzMnUEtXqHTmctXPZrhkOVHsePDwffVUfeiaSNY7G+lWGGs7c=
Received: from BN1PR10CA0018.namprd10.prod.outlook.com (2603:10b6:408:e0::23)
 by LY0PR12MB991900.namprd12.prod.outlook.com (2603:10b6:404:215::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Thu, 5 Nov
 2026 04:01:06 +0000
Received: from BN2PEPF0000A892.namprd04.prod.outlook.com
 (2603:10b6:408:e0:cafe::7a) by BN1PR10CA0018.outlook.office365.com
 (2603:10b6:408:e0::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.10 via Frontend Transport; Thu, 5
 Nov 2026 04:01:06 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF0000A892.mail.protection.outlook.com (10.167.248.184) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Thu, 5 Nov 2026 04:01:06 +0000
Received: from kali.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 4 Nov
 2026 22:01:03 -0600
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <will@kernel.org>, <robin.murphy@arm.com>,
	<suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>,
	"Dheeraj Kumar Srivastava" <dheerajkumar.srivastava@amd.com>
Subject: [PATCH 2/5] iommu/amd: Unregister the IOMMUs before disabling them on init failure
Date: Thu, 5 Nov 2026 04:00:13 +0000
Message-ID: <20261105040016.398718-3-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261105040016.398718-1-vasant.hegde@amd.com>
References: <20261105040016.398718-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF0000A892:EE_|LY0PR12MB991900:EE_
X-MS-Office365-Filtering-Correlation-Id: a298558d-dd61-4daf-9621-08df3af16ab3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|376014|23010399003|1800799024|10067099003|22082099003|18002099003|3023799007|11063799006|261022105027099003|261021121427099003|261102123227099003|261028144727099003|261026140227099003|56012099006|261021123027099003|261009223027099003;
X-Microsoft-Antispam-Message-Info:
	N3ScSJs2Zi7Bgi3OR4MhZwWhiV5OUKfig+Ey4s5msxyk1LROnb3c+EGfwujnIx9ifGabUWxZxmVzymST7Ce0cm/uqn6TaBv/yYCSA3QDA05mhyF74ay+JTb+Ot4MXzWgxf2clPrhCUhLdp2aCtN4PLSJEh+SFL5M+O0wVoE0S44tMh+X/Iquc2qodGxmqCQNkcFQE8Pf7B2uFqNhFo+7ur62J81j6MXGFNmwtmznGs3s2ynZ0lhc5xLIuICZrY7zlSunGtlk94aCNp+fKMGE8MgtYbHYcz+A4k7FvKSby7tiqq8r/v9/9Bl09WgBqrd5PJJwGNCLHviDA/Ykduktm7ygMSGPxixOREA18wilIejfJ5b4SVWBRQdCH3zZA8wlPrs9ZVZSYvkrKz6zvl8CYXbr/utH1g7cuIgI7UG5Zxo8KOR2MmbLpCh+XsY9rtCaSZQaqFgev2bmXXfuX43VYBrzfo2bbhkwx26DDvaLz9+NKnEwi0bjC/sNszWc3akkrLs1EgTtTXqQ6nbjJLzPb0YK9dhhElXY0rDYQp/XZz9O4LRBYXCu+SXJmTD6sWs4DqPAYMRnh8cm8pQnwe26ymVlLbH9Ioz7p1CZi68tuoayY0eCBwzjtvqfBcdbxzgy3ET9cIpyN/40Y7FMcMsHyQmfGVbjjaq1xIyxkpoC2tYvAujRE1N20PQSmI56YyLsJ3JnJnDLhNYQ5MdEceAF1Q==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(376014)(23010399003)(1800799024)(10067099003)(22082099003)(18002099003)(3023799007)(11063799006)(261022105027099003)(261021121427099003)(261102123227099003)(261028144727099003)(261026140227099003)(56012099006)(261021123027099003)(261009223027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	NmqU56PzdlZAdcK+4s9IbjxMUpAriG3o9SStfYRlJ5K61udGjsLGrtWMRDVzztUovY+Vm9jQQfxGI1ZlaQjh4xqY0RIY9tzOgmsAvENRC0M6oDtxjtkLz2zGWlqd3PqD1OQavr4EJ0VcDRo4jZM/yNWuMG5YqIBYhkNvy6r7t2dTLBs9kuKWXNgvPd8DtDOs3a/NeNzY/YPSbjrXhoLaBXl354YPgQp1+Mbrdk4UY1chba2wG+GLqnhSCeq4TU47DYG6Wsz89qkbD2sHVMjKzYh5WAUaSoKL+WXdcR1kLI82MTexDZVzoAVt8ooRjldmG7SCWWGAcLIyYnmf1bNPHFMOek0APzMBS2S058b9xVWCP/UMFdBkwSEOsR1vdi08OiacIYZW9VSpbTJUmR8OoMJ7axic8F0DXlFTJd5bHtL8Y2LZwKfgUsIWEvTAhMXA
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 04:01:06.1169
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a298558d-dd61-4daf-9621-08df3af16ab3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF0000A892.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LY0PR12MB991900

The init failure path disabled the IOMMUs and then called
free_iommu_resources(), which unregisters each IOMMU. Unregistering
releases the devices behind it and clearing a DTE queues an
INVALIDATE_DEVTAB_ENTRY followed by a COMPLETION_WAIT. The command
processor was already off, so every one of those waits spins for
LOOP_TIMEOUT and reports:

Sample log:
  AMD-Vi: IOMMU 0000:70:00.2: Completion-Wait loop timed out
  AMD-Vi: CMD Buffer head=56 tail=58

Unregister the IOMMUs first, while they still process commands, then
disable the hardware and free the resources.

Assisted-by: Cursor
Reviewed-by: Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>
Tested-by: Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/init.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 425c61c3956f..877122898e05 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -1792,9 +1792,19 @@ static void __init free_pci_segments(void)
 	}
 }
 
-static void __init free_sysfs(struct amd_iommu *iommu)
+/*
+ * Unregistering an IOMMU releases the devices behind it and clearing a
+ * DTE queues an invalidation and waits for it to complete. The IOMMUs
+ * must still accept commands.
+ */
+static void __init unregister_iommus(void)
 {
-	if (iommu->iommu.dev) {
+	struct amd_iommu *iommu;
+
+	for_each_iommu(iommu) {
+		if (!iommu->iommu.dev)
+			continue;
+
 		iommu_device_unregister(&iommu->iommu);
 		iommu_device_sysfs_remove(&iommu->iommu);
 	}
@@ -1802,7 +1812,6 @@ static void __init free_sysfs(struct amd_iommu *iommu)
 
 static void __init free_iommu_one(struct amd_iommu *iommu)
 {
-	free_sysfs(iommu);
 	free_iommu_buffers(iommu);
 	amd_iommu_free_ppr_log(iommu);
 	free_ga_log(iommu);
@@ -3631,6 +3640,7 @@ static int __init state_next(void)
 	if (ret) {
 		free_dma_resources();
 		if (!irq_remapping_enabled) {
+			unregister_iommus();
 			disable_iommus();
 			free_iommu_resources();
 		} else {
-- 
2.31.1

