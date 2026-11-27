Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.201.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795779948;
	b=RZnZMeI3OBTFmaStwHekBpxY7524mJbWuF9+LaPkIf3AT+nhTmvY5N2CRW+wIDCFbH6H
	 KaLdE8SmGMldcswRPrCpnHpBVhPaLZrZRddaQhQ5vh/CUy3J0TAytQzCw7SjighkyGhhI
	 F+GzjG3UHFasfSZNzxgM5AgbIfGKcHacuXaoY76jSsWGQQIhVeZnz6VzrTuuWhjhYpSN8
	 Ni3Df1Nz51Tkv2dZ9qzJ5Xk6OgjQcfnMcFB+BnFeNS6WpxX5x+23j1QLB5MaWd80GgZAe
	 bFrZbq/pG+682ZnP4S1+7XfGAkZLAhGh8wV9qurtEklputqxCoUd6nzn1+r83RER+Jg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795779948;
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
	bh=egMRfY1YzEtfx+e9YhICL9cQz8ivmLMxLeDQ/NP2WNk=;
	b=xddEZG8otFwxSeD6jjTqxojyLmynoseMlTx1XAO9lOCcSpeCEHO6p33nnQ805X+j2GbW
	 i4z+H9AzVmLHPraLw93pr7/g+SyUPCPOARSdoigSXk3vVM1jBHOGKBa/Q72rOqWcWn8+3
	 C/tM1s06tLzFt6g58031Qr3hcb+fpdd4z9g5wobj6MJctcd9+H5K4pvMwtXCQVNIoL8wZ
	 HKS61zzjdfT9Qwm88I22SgUi1e5KWftsXHfZnLCsUNM/s7tX9svyC0UctluFj6Pv6eVgs
	 uvfW5CbobGaHXvnRpJ9RbfTBwgZ4jsV35BMMFZlsROIBNp+auueYt6RYiMGBrKDNqjw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=y7WE15Dx;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.201.18
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010018.outbound.protection.outlook.com [52.101.201.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94B2C606A31E
	for <iommu@lists.linux.dev>; Fri, 27 Nov 2026 11:45:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 94B2C606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=y7WE15Dx
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LPRLuBmd/zJVXfMRCR/jkKo1XiHR2dQEBVp5C/eJ9bduaQiHFDwtt2pIBeCjWawR6q6LJ8sykBDrETOyWLZR76cvk+/saOfOfg8oMsW0ZoPCecSx9pX2VIJhOVYaOvzowoWbGQ6VNOZK17Ok4SnCpNhz1CzLnRMk69uCai5OrCeBAIwI27oSeImXjhWlY2KIUHxWeaDZLiqzPYV1Ig+a3ncOKPA03tkapq1loTr9AhAbj86J4gSjTVsNKlwvf8XNqjzB2uJUHVUqS4OGdw6DMVtRdPIC8YxGwjsukFFkWUBZ3iP4/bqN5WvN84ly7F9RGZGlLWfk6wBjtqreDDCmDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=egMRfY1YzEtfx+e9YhICL9cQz8ivmLMxLeDQ/NP2WNk=;
 b=ZU6D64aXX83A/cQsVXkRP0By7KYJmfXd6TxN/fcI2FVERGGtsqbJiBnPCimGuq3/uYGpEBTN0nirNcn5qoZi4M4cU1e62pAUUvpxUt18JZ945IhCifurYPER+BwrUWSLmD0P9zhgfEjhB/kKDZS7duNiUOKYvPequ9f+R1GimA7tHtRsBL3YLhui0k8WzEkUwUYF7/8DjMOXeKuC2K7QBkqej9meSDpDAiVxaaweo4k1fmm6dJHXssBzmJVwYjKJKn2+eWNsRHY9s0lYRFOPHAJzyEMHrJCkMPvW/4suImk2i/0t1O5UyaLRcYXxyX4IjG0YlBgH3OPRQ6aZl+27gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=egMRfY1YzEtfx+e9YhICL9cQz8ivmLMxLeDQ/NP2WNk=;
 b=y7WE15DxjLPHpgDtnZmV2HHWHRWV0pId8wCAjpud5XT1mm4CkCr+I4dus+TFGR1pWykf0sEeB4l8EVSyEfEf6lEYNC6f88lnANVkDEImhyiuglToPd3ykn86ETOHQBpAQM209afZ3icLnvLQSkHy5UIIw58nLD+Wuk/DVEo6A5w=
Received: from BN9PR03CA0316.namprd03.prod.outlook.com (2603:10b6:408:112::21)
 by IA0PR12MB7750.namprd12.prod.outlook.com (2603:10b6:208:431::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.7; Fri, 27 Nov
 2026 11:45:38 +0000
Received: from BN7PEPF000000A1.namprd04.prod.outlook.com
 (2603:10b6:408:112:cafe::77) by BN9PR03CA0316.outlook.office365.com
 (2603:10b6:408:112::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.9 via Frontend Transport; Fri, 27
 Nov 2026 11:45:38 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN7PEPF000000A1.mail.protection.outlook.com (10.167.248.153) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.688.5 via Frontend Transport; Fri, 27 Nov 2026 11:45:38 +0000
Received: from kali.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Fri, 27 Nov
 2026 05:45:35 -0600
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <will@kernel.org>, <robin.murphy@arm.com>,
	<suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>, "Akshay
 Jindal" <Akshay.Jindal@amd.com>
Subject: [PATCH v2 3/7] iommu/amd: Do not allocate GCR3 tables when clearing a PASID
Date: Fri, 27 Nov 2026 11:44:31 +0000
Message-ID: <20261127114435.209548-4-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261127114435.209548-1-vasant.hegde@amd.com>
References: <20261127114435.209548-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN7PEPF000000A1:EE_|IA0PR12MB7750:EE_
X-MS-Office365-Filtering-Correlation-Id: e7fdfa37-2695-49ab-7c90-08df4c7bf4fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|23010399003|1800799024|82310400026|261102123227099003|56012099006|5023799004|10067099003|11063799006|261021123027099003|261021121427099003|261009223027099003|261022113327099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	rVWpT6JHVxrluO+YUXIc8rRNGh5atfhhzEMG5a5EusOav/RNyNwD9JKEjtr93abbjcl5E5VN0YT9eAX2HqAui9ShqinVTeQV5KueJ6H7oeH++NOLKBcGs3+yRLKcwsgdzfvaOPJu6f8FfuTyHViaYR3d0rrdUa6E0YQ8VUDYWgIO+TgfC1R/qzZeh+mc+JsjkXqwc+QB9i4P7iBIOnj0NMNjF4GRsgO5wf9a9BiJg6zpR6v35kaVYRR4/ybX2rBeLDlV6NzaJXMl2stpC1Xf3ZfFfNi82RaXKVfF96FRo5iku4RjuKmV2xmD+HhTWMLc2owjVV5BYBU/aTuKObuEribOidj+zjAkEVT+fgwzN2LvTtrGh6oIpT4IJajsc7fq9fxRdnnz3Xb6HIYPhLDqYAxqLTQ6CfJp+5dDlUFcxcT9ZDki/RcaNs5kZhcPMvAPDY8423cU1VMDarTdr6/Bo5aJ+h/txUx9OC4EeHzxjTbqpcefg6J+Ic/KXKH8zYsK7qAKy+sybBLF+wVfuJV7lhqsrfhI53tbL8+jcS3vEYbwyAjpaKQV5EFHmF5mGU3Es0eGLLAfnlTn5qoJ3v9rIpf8Tsl7kjlBHZYyR/js+zOwiT5nvPCLfFCo9qUYZnjEfDo8ICXNAZ4l9dD6zog0O7MNCy960sQOuMlC7+8XzKm/VyySDFdbi8aZ+CvXbouyDc9tZND8Z91zRoDWEC/FkQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(376014)(23010399003)(1800799024)(82310400026)(261102123227099003)(56012099006)(5023799004)(10067099003)(11063799006)(261021123027099003)(261021121427099003)(261009223027099003)(261022113327099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Xb18z45rgOT1kx2+DZN7BS53q2jXqf6atU+VAIP7361PisxiiGdTupTjJhsD0NQ0ENl4h1yxurxSkmrzYGt8GA/lEKB3aK4VG9V7pR1AWm5JItoTkGHHjBkzMLHlu1ABMVM1YVdwYQupmBvcRAYKXoiKTpnpez4L8EOuzOn08jDjuswF9QvNwCqYCtpxgiqm17k9GuJyofiha/lbYJxbziyktBYMHhd+ZzaUYypv3N/rl3AtfxpJqp+B5GKOtlYAuWZBvxvEBu07yzne4iiurEQ7VfYy0hoMP0mORYp5o6pwWVZ876YQzri80z8A7Xr0HKiE5ai1OPUsusa7k2nvSF7/DXTglznZ2yrjxPSnaPvIbwg1qurto80DrNu6e6eFGYouKYWfGItfXO9AWFZxQHUcofmKByvnF7Ka8Sh9klpPrz5Wmlia2T6kooI42wHc
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 11:45:38.4349
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e7fdfa37-2695-49ab-7c90-08df4c7bf4fc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN7PEPF000000A1.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7750

Allocate gcr3 intermediate tables only when installing an entry. A missing
intermediate table means nothing was installed under it, so a clear simply
succeeds.

Fixes: e8e1aac33458 ("iommu/amd: Refactor helper function for setting / clearing GCR3")
Reported-by: Akshay Jindal <Akshay.Jindal@amd.com>
Cc: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/iommu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index ba6492e9bf0f..cd34ca735da7 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2044,9 +2044,9 @@ static int update_gcr3(struct iommu_dev_data *dev_data,
 	int nid = iommu ? dev_to_node(&iommu->dev->dev) : NUMA_NO_NODE;
 	u64 *pte;
 
-	pte = __get_gcr3_pte(gcr3_info, pasid, true, nid);
+	pte = __get_gcr3_pte(gcr3_info, pasid, set, nid);
 	if (pte == NULL)
-		return -ENOMEM;
+		return set ? -ENOMEM : 0;
 
 	if (set)
 		*pte = (gcr3 & PAGE_MASK) | GCR3_VALID;
-- 
2.31.1

