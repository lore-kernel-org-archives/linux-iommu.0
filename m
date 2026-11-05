Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.48.43
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793851257;
	b=w7I4k+N6XMCXUiU5DPJwK/yu9Blpy1Y8eNh9HwqMAJYN8eAAep08zpKu0/9o3YNpde5b
	 ZisyIT4VmfR7IoI04cm6qaIeYWQF4lvCFfGCHaSY11VgfGTMvxWewPIHxKsObAe0M0tMS
	 jbBlnar+HUxx7EFySgzhZxjm2uziZPiliYKHQ27zsNcJNOX3F0QB/KPJtuhVcgEeQhOWo
	 7l1nKzBGnJcsh9hq70Wcoi/HXIT2qhMQulXhW2AEmYFn0T4e6ab3pxHmMcI6C96Vnr3gt
	 kaaMEMH5tn3bUU4PZDA4NhfnVNBTkHg7tnML5imiRCKyPaIff2ossHbPD5NnliY99OA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793851257;
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
	bh=GLpDvQ85Jb1nTcN2fkGYFBr548Qi27wQN1yXrg0y43Q=;
	b=ADX1dsCy4jxrFwZCUc0Vw/Xsb/JqZt4MFqO2/hG/sfGKW4nwe87UQgWn6cboUeguHkFE
	 JreA7MzJXuDOe0KaACQ8dvPFu5xMTqhW286VxkMwngc9rBUMlexLZm8iV64kpwFsutHFR
	 TB8AufXCfqOyzEXEt6MQzY7T6L0o6Gu11ZCKS9bqTC3vuayKRnRSs5An77fe72WoSV8P7
	 ZI4ihMpoNpS1ya8NGqrBFmS5sUGMIrIQg6wUmQya1bJRP6cTtpDm8BtvlPtN20GfufK7h
	 5HITbMB3+odgc6mxWBDYdLTDWRQJCl6/MuOkUnM5plvKu0Hqd1P2m63bNVBl1ZwKvYg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=VJ7JK940;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.48.43
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012043.outbound.protection.outlook.com [52.101.48.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9FC3606A31B
	for <iommu@lists.linux.dev>; Thu,  5 Nov 2026 04:00:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C9FC3606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=VJ7JK940
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A0Rem01BrySUY9ScQQkQ90Q3lUbV4NysFjGJRNEQt+47R00Zt7yNZqYTrKGwJAfXcsl0+JgR9oSW4/N6lUeFL+ZFRdzg/ns2uasUN90MiowemVOBeCRJ2EKW6kHGur85OvmQSU9+YVCsc3E5GydA158IkEBaqxkdtov77kMab5OSVShw58UwnW7XqDsWU5lwJPDKj0WwNfTLQvMdizUGng2bgzgetogJwCs+/HOgrjYaK+WMpxdXFc179N8qGK9eZdnKmQsJJW4yyDp+O7iFNcQCQOH6GLSeVPgZillm9IciYy6mm4mauC/sue590KAig2RFIibgCbMlFW0llpd7aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GLpDvQ85Jb1nTcN2fkGYFBr548Qi27wQN1yXrg0y43Q=;
 b=MlGhhD5W4f8pzg9I2jLIFsi/DE93UMRWHOelzw5cSQrN5K636hfOi7gzDPgLkVBCaTKMAjOAHn+VLBv8HTal5mCrRvZK3ybCMETMrDkUJLZKQNa3q+dBFV6rH8N2bBHdquyme9caJcTpgLtUBkVMMexyc4wTctMx49ViwCef6sUEtD9mDq2vHPWSV4yVKB7RkGJhFqjq+aaWSz9PKMVmZTwh0k+Zwlm19czFBGeTrq3hthURAkJgE5FXcsukltMR0Mu0pMGb5Ev5HUSbBmGj3znJVrD7lM3NFZqZlcXVzdN3GzkLG/+0nu2HhYoZYeH7MNGFStJSoQHxxhZJrlsoEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GLpDvQ85Jb1nTcN2fkGYFBr548Qi27wQN1yXrg0y43Q=;
 b=VJ7JK940F/YJ+uO7q5q0MQQPklWTKladB/ToY25prB/9B3Gbuawlh16s3StR4+YfEW2Z9RaWChab2oHv+ANug/ZqJX58E7yjZR7t/H7djKsL3LVPXH8dnpP0MvYsaRsh+7F9aSCX0+sBHWucCJdGpB+lTnrxp+XyvoyzOSp1lh8=
Received: from BN9PR03CA0397.namprd03.prod.outlook.com (2603:10b6:408:111::12)
 by LV3PR12MB9258.namprd12.prod.outlook.com (2603:10b6:408:1bb::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Thu, 5 Nov 2026
 04:00:52 +0000
Received: from BN2PEPF0000A890.namprd04.prod.outlook.com
 (2603:10b6:408:111:cafe::90) by BN9PR03CA0397.outlook.office365.com
 (2603:10b6:408:111::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.10 via Frontend Transport; Thu, 5
 Nov 2026 04:00:50 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF0000A890.mail.protection.outlook.com (10.167.248.182) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Thu, 5 Nov 2026 04:00:50 +0000
Received: from kali.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 4 Nov
 2026 22:00:48 -0600
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <will@kernel.org>, <robin.murphy@arm.com>,
	<suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>,
	"Dheeraj Kumar Srivastava" <dheerajkumar.srivastava@amd.com>
Subject: [PATCH 1/5] iommu/amd: Destroy protection domain IDs after the domains are freed
Date: Thu, 5 Nov 2026 04:00:12 +0000
Message-ID: <20261105040016.398718-2-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF0000A890:EE_|LV3PR12MB9258:EE_
X-MS-Office365-Filtering-Correlation-Id: daaeda29-3fae-4a29-873b-08df3af161a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|1800799024|36860700016|82310400026|261021121427099003|261022075727099003|11063799006|261021123027099003|56012099006|261102123227099003|261022105027099003|261009223027099003|261026121527099003|261026140227099003|261028144727099003|18002099003|22082099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	qPVqoD5Z32VihpKfCkXrdOI557vyZqtM0l8KeHfz3a3NIfh+91rMyrYad+ZBoBDSWQhIQaVzW7/6mbRDkJt1xE1h+InHX/9TGMVQwtSaVm+z+9HlTlTn//VcZgqfnfUt46d1EMiqGC8wEFJeRsTXKdgWTSS9iQ0EbVlmwFNXH6A52v30sUvq3glP+8tI8jQYmvC9KipI7yv7jwD5i61iYA0FfDT3AjsJj6e3BqfeEvhWiPibsIzGfFrPUw2UxAplBWWZjuxbpo3awv3GmIq1p/MKNVe+MaDXX2jrgC05PhHSH2o1uJqDD0xp0AnSJLP6YSVkKKqZY+TzFG/jSexzBlFohhCWVaPLyeVEpgE1UqvBj5p8WlVBfl3R1meGP08jLIYg6HzdcJzcNSB9zrQ41v/4fRvrltyINHddeW2dtK79MZLihcU+fy7lSrEqE7omgsi06oVVJKRMmJskvCmQFJ795QUfaG7hvTcqJqjKhdmpU+i9omKqBXpZvC5grBUgBJT8QNn9Vd6fJhwkzi3gO5KunUZb0pNowJA0bsEFdLIVMLc9QCrb3P8qNWKRpIaZsKfzHpMp1gtoRplDyW/5Wcxa0wqbwcG6kY+gcNKn9YN53Jl5tkTTdxTaND8k6XjvHuizGd1kZVtigKdDzxjaLJdjtlXnHCwWXZ5qd+TxsX9PYmQQXHIa1ppdAxfaySuHGECDnMM8oahBLj7mxyM7Gg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(36860700016)(82310400026)(261021121427099003)(261022075727099003)(11063799006)(261021123027099003)(56012099006)(261102123227099003)(261022105027099003)(261009223027099003)(261026121527099003)(261026140227099003)(261028144727099003)(18002099003)(22082099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	reHf9MooapLPnEy2k1pnKqlks+GnJ7FMh4kxM0LbN8MsAo1pV1iY+NIr+Gws/PMSKxgBc39fmLPlBTiQNhmrPJmiMUBaMXfBRKugyKcEyufbToRAer1rBjSfeaW+s20PrWsl2ETB3VlN3lzQIh287++IQh/0XHBQ8X9B6bVhhOB/ZLU71rsdUvTHIEMBMR+SYO9+0cMVTgrC2qR8NFVtiplc4eZ4//TcG/IKBrUKediBvX+5NZqaGKDEmgEoTAJg1W/NIzYxadtHMycpZRxOO8bYvZiIaTYeOvVh/5AjVZg9vi9H8McSeVz0yXvwChiwKRAwDIiq9acaKzgNo5wOWTuN8IsDMz4DfIOempc1L3zHHb33hbzMzePXeorww509OLxO0qA0bfs641R0fnEPHfErptdHMyWS6YdojuLwQs64Zuo4CKsex8crFFRpKDJ4
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 04:00:50.8951
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: daaeda29-3fae-4a29-873b-08df3af161a1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF0000A890.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9258

free_dma_resources() destroyed the protection-domain IDA before
free_iommu_resources() unregistered the IOMMU. Unregister frees the
group default domains, and amd_iommu_domain_free() then calls ida_free()
on an IDA that has already been destroyed. That warns for every domain
ID released during init failure.

Move the destroy into free_iommu_resources(), after free_iommu_all()
has unregistered the devices and the domains have released their IDs.

Assisted-by: Cursor
Reviewed-by: Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>
Tested-by: Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 28a4067a7a05..425c61c3956f 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -3174,6 +3174,7 @@ static struct syscore amd_iommu_syscore = {
 static void __init free_iommu_resources(void)
 {
 	free_iommu_all();
+	amd_iommu_pdom_id_destroy();
 	free_pci_segments();
 }
 
@@ -3268,7 +3269,6 @@ static bool __init check_ioapic_information(void)
 
 static void __init free_dma_resources(void)
 {
-	amd_iommu_pdom_id_destroy();
 	free_unity_maps();
 }
 
-- 
2.31.1

