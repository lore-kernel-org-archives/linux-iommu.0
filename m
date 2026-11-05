Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.52.16
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793852653;
	b=b8HGjaMdg4QVNIBRt6ba0iFMoIj3Ek7qqEytzr1DvZnl1hDtAowhrmZ3o7CtXwZ+KVzR
	 rjsCu/yX8Js3+2rZNVwUEw52FrkgPq9j9D3T1hKuzt7A4i3FhKOUie+o7yyID8SZJzy6w
	 fEPcgVw4gt2vebQWdbwq749w5qXeikQule08V3nJpYE0AxKYf4G0p+AQqOR3byzAsZgfB
	 HT20xr9EVfgQNla5+5x5d3ge5xaenZ2qFIJGA2jjMVTc0XhIGpVS7U5yD1D3wkVbVugkE
	 lvFsVd9t+g0g5xdHV69FbleCEZyGre8ZBSfk5IU3NpxNvmq1NJl7DWSum9sPUotmqjg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793852653;
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
	bh=uMBXOjnxCIspIExMdaUDLpQs3EgsmYNlLP1dbFDd76A=;
	b=bo0PimQVa+xp9G80g76gzbw1V73bS1akuZSfowh7vhkENcsnaJ1CH1+mufKE/M/fHYI0
	 F6znpL3MMoAHknvue8z3nU7J4atl/REIc1THFOo6nRltS9X6PbaLmKqGP/4sovnCTU5bV
	 xISffXkHqEITtBM9wiUUawa4Ug1Se3MrXqpPmA4Cwshd4PzxM4Rs6NtU5ln8OIu/59SM2
	 six6QMI06BihCk/RpBK+HdVVcvxFAVwazvuFpP6ly8aurZfTv+u2cj7glaZZerxsrqbkB
	 t6MA0x4aA6dpNb2ouGJZ2JI/6JORNQ9vsmvExISkNsbStdflE9779CvdEf4r4wrOkiQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=5J2t7ocT;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.52.16
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011016.outbound.protection.outlook.com [52.101.52.16])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16EB8606A31B
	for <iommu@lists.linux.dev>; Thu,  5 Nov 2026 04:24:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 16EB8606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=5J2t7ocT
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QH0vzvb4b5HGHJz5u8NVE2RRkb6QK6pZxOxhWvIlxGmFFsil9Lw+TUwxBHPh4JYzJv9DuP97j9Ejf0ot0UBtznzvc7l26e3KrDsL8ZjDQKCRbOeF3eeCJmppQ+sWKOe0GL9PfGk2l48GwPGVI4jJDZhv5ILo4332poVIhls2N3fLxikKVXwnNpEtvNig95Hgz8UBybMx7w0AKisOGNlAosNxlOnqYlQXmPyhFkJXTFg7ih4FPwF5N3OPiSwgHHo+GK8IN9akY9tEs53/lZG+7nFaRp1s9dINY1sKHODeGG5pHUoVIpKVReI8fD1zr5j5SChkBVKjy+oQKIH7oSa0Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uMBXOjnxCIspIExMdaUDLpQs3EgsmYNlLP1dbFDd76A=;
 b=m98bP8ndkd2eZTE4dglTQJUGnAtpbDlQfzDa0y/2H5yccx9rFzpU75ukXTfZHAAMmByLmxZYN7vGlpTJvLnmPa8Y0wjesNLE/De1Zy9b4vxoh7KIweG4gnWaVxkUibygPG2OeIukTAVRcV273cDTRuLk1uk6lNSIHxdsNOPujRYOpUMJBShcBGzKsd60pzZRMSeanYVJf+0Dlej8S0upYqSxxOVbFJRClgqI2A8eNrDoh5vk12WS915L+T3hyXDzmSuzATjqLQ1IRUi9v1lUC6pPYHBKwCpKsbNBuPb71IlBt8ziUw82uJA1600vJPhDlSMFO+eucL/YA95QHAy9DA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uMBXOjnxCIspIExMdaUDLpQs3EgsmYNlLP1dbFDd76A=;
 b=5J2t7ocTDSTcIvhWnKeQaang20nIXAS6ueqYR8PxM4NC8gqydigyQ6eV58EzdhVJLvfN7OcBdH8X97wn2AgQfuiwvIQm3+qclDWJPmp9CQwWKDi1kHafb2X70ygtEBWl+yP6aG0eO7RoOGwF//avRNTOGthCISd/YKrDyat7C+k=
Received: from SJ0PR13CA0044.namprd13.prod.outlook.com (2603:10b6:a03:2c2::19)
 by IA1PR12MB8285.namprd12.prod.outlook.com (2603:10b6:208:3f6::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.9; Thu, 5 Nov 2026
 04:24:05 +0000
Received: from MW3PEPF00001659.namprd21.prod.outlook.com
 (2603:10b6:a03:2c2:cafe::29) by SJ0PR13CA0044.outlook.office365.com
 (2603:10b6:a03:2c2::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.4 via Frontend Transport; Thu, 5
 Nov 2026 04:24:05 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MW3PEPF00001659.mail.protection.outlook.com (10.167.249.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.0 via Frontend Transport; Thu, 5 Nov 2026 04:24:04 +0000
Received: from kali.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 4 Nov
 2026 22:24:02 -0600
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <will@kernel.org>, <robin.murphy@arm.com>,
	<suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>, "Akshay
 Jindal" <Akshay.Jindal@amd.com>
Subject: [PATCH 3/7] iommu/amd: Do not allocate GCR3 tables when clearing a PASID
Date: Thu, 5 Nov 2026 04:22:50 +0000
Message-ID: <20261105042254.399163-4-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261105042254.399163-1-vasant.hegde@amd.com>
References: <20261105042254.399163-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: MW3PEPF00001659:EE_|IA1PR12MB8285:EE_
X-MS-Office365-Filtering-Correlation-Id: 462e157e-5836-403d-5d27-08df3af4a084
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|23010399003|82310400026|36860700016|56012099006|261009223027099003|261022113327099003|11063799006|5023799004|261021123027099003|261021121427099003|261102123227099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	wNDTKeb8coNVtQtvv3DFSOgj6WWxSuQ4mXAkdgJygLaNH8ObiBOnzWr6oEw5mJAdBnL+jWCrCJqBJ4mVvwR/jjP/xfZ/W2szP7FnUrz6evqFb41tWz+1GZ6p6JhzyYorfktj+bMBZowOWjanMRuSBMdenx3Czez2mtTl2qTckljdrvkog95dbXwWTPiaenVsoJ8XNJx7/SYlWkZm+QV0YEFhLurtW6P3H9GY4ayD16xeF4OelIMcJNYHf5ybyd7g2r3mhHW4XhpjALIfEwFJtDdqlJmJTEhjI3f38QFXAnXEEdr3pYJb9iFEHMaC3/CffUHLmVlgMMYvAJPXnhN0cKcN9xUL8r2eu1R/OLaFk+dHA/Lk3sNzWkarXtfppVpdy9LCYph2/Gu4ECxH0wK853IyRi+lPDSuS2FMR61nRRNs43/Gg9ThrkHUszTk15mvQ8zJxdl9MHJR2DZlQJIncXQbTr/UabV32L8nPmm63Q/97Z3iB11AG+f/xjEqLOFfTMiQbQQ7ZI6um38xT4/xLBkbUfmvxjDaHTfQXu9Vs/O5gfpUCqv+C3HfpHti+TVgJWaSpqljptOW8Nm5EH7rLa2NR03aBrPWtChQnLnJ8S7JCoJ2ufpdJwXiPTmVDpVWJLP49ns49wb7pLnEBwKNOtIJ4mhUBH6CQFdPI0IcSQQQreeGUbVMmVERV0gP9tyMZQLQdOXT7BWyBAQ5+BP9jw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(82310400026)(36860700016)(56012099006)(261009223027099003)(261022113327099003)(11063799006)(5023799004)(261021123027099003)(261021121427099003)(261102123227099003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	y2Xwjap/eyB17qCYDOu3VRH0eE4dfCuJ1nZQvoHta/E2AJRP58etpSj9b5dXn9UDy6hUzb0BnmFzRYGzhWcCRWgzSxjvjUTNVFP9qxO75s3Gg7F0oGZkn2A4MtsowcxbLAp+E2Y+HeuwAfITtu0a2LJpuW4VIZGls/D4EFSsV8K6p6N2CEwBxbiSnmmD3J51gpIjaYR2LbsOih2BvdAWq/wW9XhNr4ZO+gwV1i9Y0mDxBbOC4/oJfV6Ama+u8Bs6nkmiz8GD6AxOU88zchl/5AcgeaBTzBBWeYfSeVBmG0FyaT++G6YIYRH8+5EQxDQY3fLvRV+a/sQGUwkLP78v+nChX2Ev4zIX7KTRRViAKp2tLYHP4fyIeFawDsAl1rWzTAywp9PiSeqwA5kbaUNbYWJX+hMbI89YXfuDn0/c04E2v3KioBTySEf/cGpc7xqw
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 04:24:04.8016
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 462e157e-5836-403d-5d27-08df3af4a084
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MW3PEPF00001659.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8285

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
index c88f6ae3753f..9559d272eb18 100644
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

