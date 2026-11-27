Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.208.15
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795779977;
	b=CUSQnXZaGH0k8Z+sIiLLZ0ltaKBe4IfXhPJD3O+++sBzOHqWi6rWpdLr7fcq7n/nA9cS
	 D+uZHH5LySkrXUZsjKiD9P+bLUuMm4yaNNYc+Gj6He4AQ6vEmqBAYoJR07pCW7nCOaojg
	 QDYu43UrRFZP+gbTvRC6vbEIyErIy34/ZV/XNUgZCB4jBskSKtNMQc5ZwF7aDkgKUFaIg
	 njfV79L2uON1xgjqZ5ZR2bE6++44TgwqMEKa98nQr21fI5eazbbym//lHrCEqV0nKwmWb
	 v87kGF3s4nKg3tAPs6OLtjF6M/fsGIy3Je1cAovuQvnIeXH+B+aC+UtGAdSj+WNaFsg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795779977;
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
	bh=CzOr2JflGoNO2HQNcSqITbY61YWIl3TicInSD/4u4Lg=;
	b=btILUDfe2si0Y9yLr1pw+mKPFcRnq1yfL+j+17CmGerfrsoUUbmA8vgEsQpSiJE1DCzZ
	 zpwgxyef3AqOIBHqxciL+QJkH8dj6BQ2S7cfJ0hjYrF/ZNpDVAB+Omjt7cE6JPvsOIEHh
	 WPxZqZsqaB5pZ3u6iQbX1+CaGq4EAjKg5JEfOaN48BC8BEr8iwEqlAGgjIg4qjUVnDcx1
	 9mvKtciJq4adMVBudTRNikocpDLq5A9hnG6t+sXwnqiONuSEZD4ery//I6BfNacbpLjd1
	 OgH5LMSkbpSIUfBg0YZiMCanydPRJ43M1/mDQX0Jc+RuZogqnSItvi5kmvOT6FPYPcQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=G6GnK44v;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.208.15
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011015.outbound.protection.outlook.com [40.107.208.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB9D9606A324
	for <iommu@lists.linux.dev>; Fri, 27 Nov 2026 11:46:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EB9D9606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=G6GnK44v
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ArDdx69Ubm2qRQbYniet1MrEZxWwarcrXTFHtq3T2l8tbFxspJ1eTcEfqqUlzhkKrCIv8p2waH8EfkeeGxxRMxCtvQGm8JwFkXIbwWxcqMVUrOzHN5ETAgsA5gyFnAh2pwbHFBHhQ5NCOfMx21EsbSnNL8dbiQ1XWUhKVrMdClx3rTOOxmeq42qxF9VSDu9eKMr8HN1CsM3CyqRrn5g/PeCj9TpLapYLKVElrPVG+X+IyKArYlX5RzD+4N4NQtnDOxksuudjtb2IJTitwJXYHLADKjMPM3HFwlAmxeugH+65EyjbmkrIXUmqyPWO0qZqFU1BJicOiLW29GH4WzBqYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CzOr2JflGoNO2HQNcSqITbY61YWIl3TicInSD/4u4Lg=;
 b=G4oEERlFCC67sXVCEKxnZjW4mckkf0X2YSjt+mgXY9OAyGamubE3GpXLI6wuXmmdDv/H9sPmba9PC5pdNDxsHjEVX5/8aa0pvUtB5TdXwWjp4hVu8RcBarJ2Vg6INtb2DymnDZbhokFXB//U/X1x3nMhNe3ruXUNLd3ZGnBSU4ks1/dTr6v4D5LgFqmuIyDQEUXEXeL7lTD+NlSuDYuOaabsEEQJt0ng3IYJDuZPEPwwFu7KaG3QtSMDsfM0vRzQlXM9eK+eQOICoCuzgOx3YM9NlZX22A2HSiI3foLb42WZ2+aa+zwJzxPr6H/kZxXH1DwYtwdfl/7Ae3+d3ankUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CzOr2JflGoNO2HQNcSqITbY61YWIl3TicInSD/4u4Lg=;
 b=G6GnK44vLtSDIS4XAICS5d/jitNBtSmxtia03614rlRSBV+gaeO7nQjX5hoh5vgQ5VbxQdCR4E91JXeJN8qfYcp5p6VnZ8CQKcnss4aXBcAXeZCasy24KjyAtT/F/Cb7C859TeKsHfp0AMm/z21WILbCmUyiBvgoINr5n3y1IoM=
Received: from MN2PR14CA0005.namprd14.prod.outlook.com (2603:10b6:208:23e::10)
 by CH3PR12MB8533.namprd12.prod.outlook.com (2603:10b6:610:159::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.9; Fri, 27 Nov
 2026 11:46:12 +0000
Received: from BN7PEPF0000009F.namprd04.prod.outlook.com
 (2603:10b6:208:23e:cafe::15) by MN2PR14CA0005.outlook.office365.com
 (2603:10b6:208:23e::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.9 via Frontend Transport; Fri, 27
 Nov 2026 11:46:11 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN7PEPF0000009F.mail.protection.outlook.com (10.167.248.151) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.688.5 via Frontend Transport; Fri, 27 Nov 2026 11:46:11 +0000
Received: from kali.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Fri, 27 Nov
 2026 05:46:06 -0600
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <will@kernel.org>, <robin.murphy@arm.com>,
	<suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v2 5/7] iommu/amd: Free the level-1 tables of a two-level GCR3 table
Date: Fri, 27 Nov 2026 11:44:33 +0000
Message-ID: <20261127114435.209548-6-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN7PEPF0000009F:EE_|CH3PR12MB8533:EE_
X-MS-Office365-Filtering-Correlation-Id: f0062a97-c209-4148-1715-08df4c7c08f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700016|376014|23010399003|261009223027099003|22082099003|18002099003|11063799006|10067099003|56012099006|261102123227099003|261026121527099003|261022113327099003|261021121427099003|261022075727099003;
X-Microsoft-Antispam-Message-Info:
	eL+RLEQqFQ1KJiki2/C5x2IaSHaBlVax04S0c9HNOdDzvngPc1I8hA7aW0udS6d9kCRqtYzQRnT7cVCwoGRd9SpMSXakmPYTPCnFB6eVkb6ttQ7SWD8ZCoIng5aYac9mGg83/pNw92sfGGYNWbzrhu2ZgkWTv4ZMgc1LlDT+7FRPZKexPABl69q4AAWR3E9gFqH9ScYguFUVk4w0clOVrFNU80I63fs+86JGH7sb6+cRKyyUJtfbYeRmjFGGnLbZLHUaqb1xBUBKbAY7eO2hJOMA4tq2gTbQ52vvKBN8sLxBDJ1X7h0lhsSGcPm03LPHTpOlz95C1XnC0D7bGXwhd9ST1J17ZDeKeWVOA/siFazzujy6eKPnrLF4dqzWkdQLx85lchTSNzpeVDC6WKR86LY3sze1/9zlLWvyYBlhEUsbuyEkgT19Z+H5iXNo7XaoyZBm19ZOcAAZwkllscoh8juNorxMZqiEQRhYKOJXmdtd3P5brIzLlFn30T9hKMDCp1ohqU5tMtptAX9pziwt2965LTUAcbC3h5sNMCN9jwRcqEi8D6IojycqEfw5+0HTFuR+6T3HqzcpfR0OrWZkTWDqTsHDoFcjsuD1V/HlQ+QVYiB2A7dHeUL/pvrcz646Hz3Jww0wcXCI8Rl4NAck2M8fdjCTjkG17Es2qZMs/MhxP8vo9b9uPfk4Pyn+if36fE0qqS3LJi4qviwgbqzUIw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(23010399003)(261009223027099003)(22082099003)(18002099003)(11063799006)(10067099003)(56012099006)(261102123227099003)(261026121527099003)(261022113327099003)(261021121427099003)(261022075727099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	NlwwY3q54vkr75Iy/IgokMQpDVE8Br3CtJYI0loFAAQ8EoJT3yo4pS/KAmXnfVpA7wGv1bn3bnS85QAfO+xVAtRmSagTpYeolPWH8Z2BLu6U+0nvx3Hbs8L6c2Fu+ub2NT3YPTSNoMwzmByqTgjQnwyLXvY6CQBrJLCrns0zVl7PsHdrVDgGFRLBWIq4n4GbRIq/qw8qzmdyJwveZZGM+p2CFUGmk2k62XIC1EejDyeT5r5efpdkG9bOHvk6BHYL0EO9+ooVTp3Wp+lpLLEIFEEeLR7IkncmJKvHI4lUe18xfGQ+4wt+svLMqapPaWHFdsyBaxtzkP04BnU/ndHA05JzF7LHRhkAABSBi2UeuiMJXNfJUcB8F1haYX9R5WemuBFfLEHoeeC3Lnwzi5lCEm5Zvd2j3PZLiV/fFkTg5iUQUwVr+MNULgPCm93jAJ39
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 11:46:11.9255
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f0062a97-c209-4148-1715-08df4c7c08f2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN7PEPF0000009F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8533

free_gcr3_tbl_level2() frees the leaf tables under each level-1 table via
free_gcr3_tbl_level1(), but never frees the level-1 tables themselves. So
tearing down a two-level GCR3 table leaks every level-1 table.

This is not reachable today: PASIDs are limited to 16 bits (PASID_MASK),
so setup_gcr3_table() only ever needs a single level above the leaves.
Free the level-1 tables too, so the table can later be grown for 20-bit
PASIDs without leaking.

Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/iommu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index a9bb8d50146f..49cccc969639 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -1934,6 +1934,7 @@ static void free_gcr3_tbl_level2(u64 *tbl)
 		ptr = iommu_phys_to_virt(tbl[i] & PAGE_MASK);
 
 		free_gcr3_tbl_level1(ptr);
+		iommu_free_pages(ptr);
 	}
 }
 
-- 
2.31.1

