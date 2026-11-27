Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.52.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795778892;
	b=zcrXvYkNZvYM3TkXtHfMKQUtiJnyGoavFyZMRk8Xiuahr596H2TPihjc5tUtZQLS6v0m
	 0Nx8vPTMXQQ+ddb6f3tb0NBm1k0REBmVoWp7leVivaHuoA2Vmc7DIb90n37icX5ZxgJoc
	 +Akqpb6D72kjw610/q5EsdpRUbEievhOEaO83Uw2irlWSqy7OOl1m2ABPSynYZE9Nb6Lb
	 WP1+I7pwKOmnhM4VmJW5mL7ARPkaPqHup8NN+L4u+UUKBYcfT4hYh2H1kQD8CsUHBTm+U
	 PlSTnTLDEzPUtNGkqFpekzaL4h/rPuBseRj6xkb2G8gk90NB7OZinAdfk16xoViOdjQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795778892;
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
	bh=hyyLcftfbPMu9kx50w2c5cI50til5Q0vgfhkvBMCYhI=;
	b=W4g9s00r1eCZbcworErG9ekKxVXSn9nr38WQ57n/xLTIj8xDUxNWBC8iy2TUecjOY3vM
	 hpD4Ly+IuY2jZdN2c7PBCBra5Z/JrJu0YkFMjo9opwuNLiX93hSnipsl+k4BSknTz0EOJ
	 yxsJizlm97//PTeKT94s8A02NSy+gED0ZqcwHs/2GH02OSKtSVAQV4naR9CYymoTyp/Ur
	 xNSTWpaUMA85NVZK1NEZF2NQIQFpylMTunqyL75VZwKIswE4+LxClT1OxB0xeraRXsC25
	 kzP256n2qkTTnnVxINd2SNRkmO8mbP0iMrQZWXRz+YejkhG9oibahl1iMGliWw2+H2A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=uBg4opsc;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.52.54
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011054.outbound.protection.outlook.com [52.101.52.54])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2200D606A31C
	for <iommu@lists.linux.dev>; Fri, 27 Nov 2026 11:28:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2200D606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=uBg4opsc
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ohlG4+Q/peJ9cfJD4aKsltqe/yoNhvz7rLNAGjF4pnVvzrDuZ+S1sTyI2mbxIPeS4+vYdKwcejH5yh3zQwmu4uXiqgK8W7MruGFl082fddY9XYwnYcxyX1jIurPNjRjW2ibYpyETGFNL1rOeg+QoKzIRrSVnpYQ0besbDjLJ0SBkBA3iW4WLmhT0j8nlqhdhSWYgmzuwYSuXDL1mh0VklMg0HXfAtMtUtbTtrfw6ERZ2t3zAwwryjcTIA5rPHvNHqSdL1we7a0n8fZfJUjAvpE82TWCbRJ065q91HEMalfb8BkJHaMKej+Xs7+Ss/t4sdXaWxIgnS/vorjNzlmGJCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hyyLcftfbPMu9kx50w2c5cI50til5Q0vgfhkvBMCYhI=;
 b=yvj4vaj8t1V48nJUaeYnJc9vbbVH91G8c0ZbyUsawBn6VDB8gZmpITUfG6mhhwU0fBVVfIwE36DICaEsvolaHZ5n5hu81fJzGpWedPcYP2lsW8sFWNOSPgeUnCcg+DU0dd+fHDuZD/yL0gAz0+gvUf/QzutW+8Wru/6tCwOTZ17zF/E79FUi+okZyEq0BA4YE2uQD2GWMGDNqCPdzJ/bKdlYQJHifUhhqgJ6gK5e/WLv+OUSxU+I7cAIBgV3yW8ldX408qBCwVm3PCBJyNCc5+8RmKP2AEFEBRerH3KyDkOPwyiElGFOu6yFjXzidLvuLUWBGGTIRNd5v1q/FnLOtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hyyLcftfbPMu9kx50w2c5cI50til5Q0vgfhkvBMCYhI=;
 b=uBg4opscbv2fndDxiaVbo9MzwPXffZCUYJBRoqYjJwYxn5cryUfthhHUvp8hYPf16Bu+2R3az/aZoXCzekbayi8IGKo4afNVLMdm99mz9n5gpNBKyL87xq2+cfelReZcW/OdWoVlc7fFAVjL25ukvknqHMK4/zFwLkLZuffQIdg=
Received: from BL1P221CA0033.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:5b5::14)
 by CY5PR12MB6600.namprd12.prod.outlook.com (2603:10b6:930:40::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.6; Fri, 27 Nov
 2026 11:28:05 +0000
Received: from IA0PEPF0000003B.namprd03.prod.outlook.com
 (2603:10b6:208:5b5:cafe::7a) by BL1P221CA0033.outlook.office365.com
 (2603:10b6:208:5b5::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.11 via Frontend Transport; Fri,
 27 Nov 2026 11:28:04 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 IA0PEPF0000003B.mail.protection.outlook.com (10.167.249.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.688.5 via Frontend Transport; Fri, 27 Nov 2026 11:28:04 +0000
Received: from kali.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Fri, 27 Nov
 2026 05:28:00 -0600
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <will@kernel.org>, <robin.murphy@arm.com>,
	<suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>,
	"Dheeraj Kumar Srivastava" <dheerajkumar.srivastava@amd.com>
Subject: [PATCH v2 2/4] iommu/amd: Unregister the IOMMUs before disabling them on init failure
Date: Fri, 27 Nov 2026 11:27:08 +0000
Message-ID: <20261127112710.208885-3-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261127112710.208885-1-vasant.hegde@amd.com>
References: <20261127112710.208885-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: IA0PEPF0000003B:EE_|CY5PR12MB6600:EE_
X-MS-Office365-Filtering-Correlation-Id: a4e8f1e1-c09a-4848-b8c8-08df4c79808d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700016|23010399003|82310400026|1800799024|10067099003|11063799006|261102123227099003|261028144727099003|261021121427099003|261021123027099003|261022105027099003|261026140227099003|56012099006|261009223027099003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	5N+JyOsXO0BWrx5g/ssDoC8/li5Ttjn7iVJlDjwRF++pYzv0K6o6gEcHpW5Herr6lJ303WAvkQxL/LfSvWvHtxjh0RgtBKGzaao31TDUTuY8fB+U5UsvrcBlFbPi+gaIVkgPyXGnlWYIRr1iC+aX61CN/2uREdm+f3uEct++5U2s962v+uZt8J43jr+5ZF74QlfjDw47ftizJxvwnMBFhmZBaQfp1RgJJ8jexrcqvKr3LbsXOi+Uvmv2HlUIst0vW8M8rZSxM/WCQyzqEcsajSshv1w4vC5N9J1R537Eiq33LDXD5SetRL/L6nqJOa9DIVDaPYHxSXV+C1aXLIkpXAe7YBax6mjTdB3trzHKEq5RocxUWjkjruZiiuYs8M/6A94SLDte7iXEpaH2zsoG5C84ELNBPU1kXcLOhB+3OKEMkpTq8m8RpijqxrNU1kibThnJ3raFoocsHPkJa22C+hE9lGavyIshriXScDPzW2VtGi8aDl9VdvqiDXyenPlGS64qGe5lWje4pMeulgLXzELC/lDD7uzQweHSU3GfP2zP/gm9PV6UDGkH+Xz/vL8K8g3K+ERZBcNtH2bx5HtwwDSBS9Yi1w1vB+c/9s90dcaOdgDcgXIlWseJ2G0+WyFkzVxYScDogJJrhj+/aacJ9Zmi9gxbOpTAI48BZocGse0W5Vv3QuIsiX03Pc4jGOGv08QWUBQNm91ezfcHN3p5WA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700016)(23010399003)(82310400026)(1800799024)(10067099003)(11063799006)(261102123227099003)(261028144727099003)(261021121427099003)(261021123027099003)(261022105027099003)(261026140227099003)(56012099006)(261009223027099003)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	W5M7bZJOcpY3gJZ5nBsxoOFFL0rmE54udvLBmbGjJhCVVrjf/NR8K4P/RTYJUg/Oq4QobcQq/0hEAcU/me8GUw9d99PPTCm1U+X+0p2Fcs6DfKTvYkcQvrQ4FxT62yvXdgmCuXEM/a2pSdy22AT1X84hzThJ2m5rYrHNZdzc9GRc1gv+fBi7Q8msRAQLX2WWtYSIYE7CGxnGVkxDA9/tV9L/ytXcbqzlzcMjsFSSVjYetTgpym7OF05RzzfvAmJaSyovHTXqgYrVZFDxVYA2WFv4LbTMtYm0FRzJ5rYyah7/+TgUzKs7VKt28nweze/4W9/YIjzi0CIXQ5uZNS1JzjQsKbgAiM+0fuUQj9q1hzdTgsav3GLL9I7vbsYFwDjRpc14k5Lru6lo/BVdk5eCwxlMg5CvfKWysEAzIJY432Hn4gsHKqcVDJ7L6yoCtWeW
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 11:28:04.0973
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a4e8f1e1-c09a-4848-b8c8-08df4c79808d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	IA0PEPF0000003B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6600

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

Reviewed-by: Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>
Tested-by: Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/init.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 0993983e5bb8..fb3a93480b40 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -1850,9 +1850,19 @@ static void __init free_pci_segments(void)
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
@@ -1860,7 +1870,6 @@ static void __init free_sysfs(struct amd_iommu *iommu)
 
 static void __init free_iommu_one(struct amd_iommu *iommu)
 {
-	free_sysfs(iommu);
 	free_iommu_buffers(iommu);
 	amd_iommu_free_ppr_log(iommu);
 	free_ga_log(iommu);
@@ -3672,6 +3681,7 @@ static int __init state_next(void)
 	if (ret) {
 		free_dma_resources();
 		if (!irq_remapping_enabled) {
+			unregister_iommus();
 			disable_iommus();
 			free_iommu_resources();
 		} else {
-- 
2.31.1

