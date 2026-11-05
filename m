Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.53.6
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793854216;
	b=woW6SJ7NrW30CT3zwVKUrDCTMd4egZLMSHyeyGD5dym4v4wlq28Y/hjpPjfs9EVRbxg8
	 hpYlZ5Fo5Nxo+tcVcbwYBtw+aeeTRltRKET+6SaaYkvXoWfLL3bRpap9mszdq539zCwbx
	 57qA8R5AnZdGFHAUjf/gb0v1tMsxpQhTDIB0fbFFIdPQ244DOYpYYi/QR7dJHpnt00DAM
	 HEy2dndkUoqMiX7ftTRZt+fkwjy8PselU4QzVGUMKSvUdp4hwjeTDTvJAJX4AvoMCF73P
	 bi8JcBtbJ1dFs/ak3jUw0/WJG+lgQEUpMHJGXMYfUFe3zSNf2nKGgxjf4FLuHS440Vw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793854216;
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
	bh=m+8ZPcyV+AwwqKlrYPNf1ij7XSTs3caGGKucdeWepZE=;
	b=LALUWmlXnoKR/346id3Z49e5L7RJmeBHQLGxX/IEBzCpiR35pY4v0wUKW9xG8YoHCtEj
	 OfoAIjCCc+VfZ/fGaCZiIrzTdJKuWgHRi7/9dFj28A3+YEMpRBtHd09zxAwZrmZcFI7ib
	 DIpyNI3uxrC8XyAP/f0wGpu+BQ6qNwacARkdTdDmh83txxvQ+miTIRdie9/ZqTfGjphRf
	 hs2XXefnGpUcu4XRKfwlyh5FDakIAi1eUptjebIVNaecIYIIe7XaYhTxG3p7/OcgYnmfU
	 Q+FzuEjPBiORk2Gn1kYuMw56KfE+AhU/SP5CDG5GC+yBhs6WaOqJMmBtMtrmsgFLZxg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=QdzGLfBj;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.53.6
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012006.outbound.protection.outlook.com [52.101.53.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C1F3606A329
	for <iommu@lists.linux.dev>; Thu,  5 Nov 2026 04:50:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6C1F3606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=QdzGLfBj
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Omy9UQhwD5mS9ZBA4QAPF+9VC9WPeoS62NH4+MZEmTyzsPAIpffSgFRnW7sG3sSNTihYoMzHdNY25YjK8FAU/gEXr88L9028gEDPAil+Z6pKiDxSIvCvQc+KzvhYVYmSCji/5gU9rhfSPo8sl75WVLK9gHmKnWe+STLMf4Q8Zg2edNRldb8ohdteyaI0Du3pE6s0/zC4stlCf7HgR1jhbWDymT+RC1oHGS/fgKGS4ZL0U1GU47tLDctzAlXeBDnrxn0xjzbmsVh5vk/uMRCpGv4C7WcP3f4eHbdPb7V5T5SsmurkjwJ+AQ352stWxof5ULcrGUREswr69tF3sXGh2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m+8ZPcyV+AwwqKlrYPNf1ij7XSTs3caGGKucdeWepZE=;
 b=VrVgICRKy52W/fMfql9tH7NKPtc0j4cBNm+VKqR4ZQ9+FzR6WzSewBltfni9CBuItvaw+VAlJxcvku5/71I3Mpy4HE47u4hySvB9X4X+ex1IUFJCvs7Y8riDil/6fkV+AYror8QE46YUXLFS/rpn7BFABxtj1zejNIuXy4o8g0rXTIaNL86uyb9UBS5uMv9smYvZiyigy02HWF1ZQNBIF/OIpSho7+h2qSo4eCjMPv0SmTatFepPtTeksnyj7PUbIPfdpwp5MtgldpjFuXbCrJJMSCSQ0wPytgcegLk2eqLWEM5DVq3o2SuAjui3YadoVdH3+iDwMeV0zGhOrhUTQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m+8ZPcyV+AwwqKlrYPNf1ij7XSTs3caGGKucdeWepZE=;
 b=QdzGLfBjmIxTWSYtJE/Oh7ryQ/nzkjrZhUgE8ooQWigVapK4xxXvO4d1YTqo4h7r8eStnlNVWc7ohVC4FDUAfVvVFTJM+U/G9CYlG0kMN1N6a5N53WGURGhSxe2lqm9cM2Pous56YsvM5gOWKhCrLjo0NcjfU51cj5xiJvT/ITk=
Received: from BN9PR03CA0487.namprd03.prod.outlook.com (2603:10b6:408:130::12)
 by SA1PR12MB7038.namprd12.prod.outlook.com (2603:10b6:806:24d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Thu, 5 Nov 2026
 04:50:09 +0000
Received: from BN6PEPF00000070.namprd03.prod.outlook.com
 (2603:10b6:408:130::4) by BN9PR03CA0487.outlook.office365.com
 (2603:10b6:408:130::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.8 via Frontend Transport; Thu, 5
 Nov 2026 04:50:09 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN6PEPF00000070.mail.protection.outlook.com (10.167.248.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Thu, 5 Nov 2026 04:50:09 +0000
Received: from kali.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 4 Nov
 2026 22:50:04 -0600
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <will@kernel.org>, <robin.murphy@arm.com>,
	<suravee.suthikulpanit@amd.com>, <jgg@nvidia.com>, Vasant Hegde
	<vasant.hegde@amd.com>
Subject: [PATCH 07/12] iommu/amd: Complete an aborted PPR group only on its last page
Date: Thu, 5 Nov 2026 04:47:56 +0000
Message-ID: <20261105044801.399466-8-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN6PEPF00000070:EE_|SA1PR12MB7038:EE_
X-MS-Office365-Filtering-Correlation-Id: 65d29993-6715-4d30-5df6-08df3af8451c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|376014|23010399003|1800799024|10067099003|18002099003|22082099003|56012099006|11063799006|261022105027099003|261102123227099003|261028144727099003|261026140227099003|261021123027099003|261021121427099003|261009223027099003;
X-Microsoft-Antispam-Message-Info:
	a6WcmZrT3yx0jv/a3rZLIjaR1xidJ7TgcvoPgn02aCg/4CWjyWGsSUfieWN7g+41hQbNbvVXDS/6tLTiiTgXxtCh65lZ/v4dKah8HHb8hVN3EubMyMbT6TjYSXoH7gC4EqDGMyhNLs2DjD0u0FSlNMyPnP7fpswbNQW2/JfgQxLgSPvQuTCUqfrNQfrTRbgXfiALjJ+WlXrhve/zj/vApevMQl/6wGRdJ6t8YRYWi9O44OSkM78CPFrjdn80DjA9dW3YHV9cvgBqD9WCuncjqS1zF55pap8r8BYHTbuTnngZ6AWXzvjhVSiFZj9udpumd2ikgM7ela+OVTLOlFpjgXqTsrdSeDJz2WSHcRWLHiqKaPnY7jHo+ZYiTEvxmrtnLAUfx6kTkKjKSTSWtkL++WRywSevWTbNiCsu0gZrBMc9VGWMKnALxLy+fO0rXE0OFbtbY1VDLTYTlHRBg7+ETVZfHHxNGN/HhrVTUmzotUzxxUg04cSYNQjHHVuXiqe7dHmI+ECy7WOQxNc1g4F4hEfZA7yFgvypTnIjJSM56Xz3mAcwk4ByQWJc97nEHFt5bAT0yM9Tk3WmKHOPAbKPWXOUG4NJIJ1KnDDinhCyaCf2TWWq4c3jl+oai4yfWlJ20qpbxhuLz66KqtRF36wbACDccVCqEEbAGHMvqeiH/8h2Y4u6TAiZhsMGEXsi1WcMxVXqshwgRejhbsUI5ipd2w==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(376014)(23010399003)(1800799024)(10067099003)(18002099003)(22082099003)(56012099006)(11063799006)(261022105027099003)(261102123227099003)(261028144727099003)(261026140227099003)(261021123027099003)(261021121427099003)(261009223027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	aDrf/1ORDNkcE90TCBBYVM1Yfj9q9xdnw/CeZTDe2hH7dCqqh3LPLJvPrqYjYNczvZJq2gAVXKJpfOTjlszK3vrxobfmvmG7tHFrE5Y2YJ7HxlgOpVAFT2jGo0RqNaJLOmEIyrVYZxJFzlU6ZfcLFgWFi9efmLoz1A0ci9NlOnilcPQ/xTpxzinuemLz1CSS8ak/NKqxzMzQkCpAxQQ3uBMGFX5IR5B2tQfRDC8rRcH5gIUNew7rkWhvtMBWm3xLweit3Y7OUY2E/gDeqD112PdZ0W45bMJ5hWmNlus1KN/X/0cEDjy57ANytydf1XLGzaJmi01i92SewVVMCjEqZzj1pEdVhqk7wmFG3LSMd/vuJ+0a6SkdQnPMX5xQqoYidi+PVWcz5De8bMkJvcIQVuJq/VOheNG1iSGmAC15aYLiETNBxcw5GWkONa2s54JT
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 04:50:09.5250
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 65d29993-6715-4d30-5df6-08df3af8451c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN6PEPF00000070.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7038

iommu_call_iopf_notifier() sends COMPLETE_PPR for every rejected request.
A group of several pages then gets several responses for one group index.
A response for an earlier page can complete a newer group that reused the
index.

Respond only when the request is the last page of its group. A request
that is not the last page needs no acknowledgement.

Fixes: 978d626b8f1a ("iommu/amd: Add IO page fault notifier handler")
Assisted-by: Cursor
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/ppr.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/amd/ppr.c b/drivers/iommu/amd/ppr.c
index 7d660a81df3a..20ad2e46b240 100644
--- a/drivers/iommu/amd/ppr.c
+++ b/drivers/iommu/amd/ppr.c
@@ -174,10 +174,17 @@ static void iommu_call_iopf_notifier(struct amd_iommu *iommu, u64 *raw)
 	return;
 
 out:
-	/* Nobody cared, abort */
-	amd_iommu_complete_ppr(iommu, devid, PPR_PASID(raw[0]),
-			       IOMMU_PAGE_RESP_FAILURE, PPR_TAG(raw[0]),
-			       PPR_FLAGS(raw[0]) & PPR_FLAG_GN);
+	/*
+	 * A page-request group is completed once. Responding to a page
+	 * that is not the last one sends another completion for the same
+	 * group index, which can complete a newer group that reused it.
+	 */
+	if (PPR_TAG_LAST_PAGE(raw[0])) {
+		amd_iommu_complete_ppr(iommu, devid, PPR_PASID(raw[0]),
+				       IOMMU_PAGE_RESP_FAILURE,
+				       PPR_TAG(raw[0]),
+				       PPR_FLAGS(raw[0]) & PPR_FLAG_GN);
+	}
 	pci_dev_put(pdev);
 }
 
-- 
2.31.1

