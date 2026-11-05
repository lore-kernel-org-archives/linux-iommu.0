Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.201.48
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793852253;
	b=0Zo2fqWj+dLJ7aLwIf99HZuaHOnfunKcxwTSQroXR51qVZeo4jOtzY6TXqXyK5O1zRgf
	 3c/Q0LrMM+meu1zT9yiG9JMn5sNkFql2IFmql1THQ0UkxAd+9eDEOqqxToOWZFjLJYZCW
	 atFTZZvEMU4XOEJ/Zk/huIZSSqf4ZZEU0TnbRSAciLZ9DE5p/2QcGtHOQK1BeXsj0CoZc
	 jKg75O4W7aaY97SSgob18EqarJaVrmBhXJlrWr2IXoVDItyphUdW4l6Ui5rmHOZ/mWy/I
	 fuaoowLjSLnnzJRfSlsaEgTWY+wI10VOGQlSCVLTMAN1h/q2gG1wHukzsYTqB3v+usQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793852253;
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
	bh=0d11oEH6nABkgJjcbWh9E0UH6viG1S/lAB8sWXGE1KY=;
	b=DRyzfusHUbI0FKoTeEdp5HxrR0P0seTxuz+708sack6LBaYMobBbJk8/tlw7AR5vdbgf
	 M7KoV0f6UnYmaxiPX63ppn2KQGzVUVXUbTC38LPV5pPtG4GkgVjvZavPt2Sa6mWOGqYox
	 BvOoQNFCZ1/4rBWi5PxsKLKAX2F+pGt2x/3+kEYs5XjCCmebLPkceVowRo8Yd13N3pZee
	 vdADslZTlc3M2lGbx6365Qe8YgKfQm/6vqTWqnoJcBYDxu5cXcYCX1IJ/EpXrIt02DrUi
	 bII4k38Df3oKGUmu7usQ7fzdg4Hl3KUaRETUf2PdBFKqLQNm52CVWAEzN+ot8I3Emqg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=tf7O8+Re;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.201.48
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010048.outbound.protection.outlook.com [52.101.201.48])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA9F9606A31B
	for <iommu@lists.linux.dev>; Thu,  5 Nov 2026 04:17:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AA9F9606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=tf7O8+Re
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KqJhcaNNakQuD0jB+YLuXItDCa+rvde7kqo0JzcUmiSLrqymh3D5sb1pt7b/PCQK+YQ6X8KwEkXeArCgBZ48xYrO2M4zgd+IvaaThCwDNT5vPR8jk4O+pr8UP59LXNjSbG0zWOEqzh6n1r6CdR6SdkVAB07ShZOVeZrE2zqRLzXdlhGl6SKkA1qq4prTaxhN0yumYs8dH4IxBCiOSb0dGuwBbzdE3cpOTk5hWXV91vi1CJxSMj/hBX3+9yg2QCBORKMevni9QhQdM9YmCRs5ivSJ4VLAyBpG1Qpx/qy4YWqj6tqE/w0LKIkcFY79EoHfh3HYbVYVz7ePDuj69RzlwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0d11oEH6nABkgJjcbWh9E0UH6viG1S/lAB8sWXGE1KY=;
 b=y+7AwMkB57eX0jJqxJRsKxQz01BrViWrptInTOJc2AEB/YXU2gj/OKyAZL1MGHY8Yxx6yRAsnogUEC6nU4o7qBqmPB08Orp+Vju5NkRlza+/YIEI0K5kgKkb9MG2c62xG0uXafbxCtNtiUCIf+xSl+JJQOmvz9YRU/mXxURStEVhzc5wk2MI7ZC1X8ikBd2ToHza2vCjRZsLqTpBlHbWIEazr4NXhR7lc3OsUr7yS7iCsfoPeHwW0uODO5c78Twvcp/tpRjWGZ0k01RBF4M39Unlb8lVSazkk22gRcDySMNWHL6KS+1G3Zc0xbjFP1W5NVxJM80nGSBfhq1MGWNDpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0d11oEH6nABkgJjcbWh9E0UH6viG1S/lAB8sWXGE1KY=;
 b=tf7O8+ReaSYLAQ2/uBUJuJWis2iNER+/Yh4UKCBRsyYLN7W0boTxPFQ+h7xyxfzIzTSDBQD9BEKRXImUeyChqIBPdQffhxtLputIj//0hebI5+j7FVVNK+r+PmkMo6Qw2dU5sQ2Dm/xBJ4sEJwHuegDm1+6QWf0Cvz3SIxGBsak=
Received: from SJ0PR13CA0149.namprd13.prod.outlook.com (2603:10b6:a03:2c6::34)
 by SJ0PR12MB6926.namprd12.prod.outlook.com (2603:10b6:a03:485::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.9; Thu, 5 Nov 2026
 04:17:27 +0000
Received: from SJ1PEPF000037AA.namprd03.prod.outlook.com
 (2603:10b6:a03:2c6:cafe::31) by SJ0PR13CA0149.outlook.office365.com
 (2603:10b6:a03:2c6::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.4 via Frontend Transport; Thu, 5
 Nov 2026 04:17:27 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000037AA.mail.protection.outlook.com (10.167.244.184) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Thu, 5 Nov 2026 04:17:26 +0000
Received: from kali.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 4 Nov
 2026 22:17:24 -0600
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <will@kernel.org>, <robin.murphy@arm.com>,
	<suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH 4/4] iommu/amd: Log raw event log
Date: Thu, 5 Nov 2026 04:16:03 +0000
Message-ID: <20261105041603.399016-5-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261105041603.399016-1-vasant.hegde@amd.com>
References: <20261105041603.399016-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000037AA:EE_|SJ0PR12MB6926:EE_
X-MS-Office365-Filtering-Correlation-Id: e5b118e3-d007-40bc-94bd-08df3af3b351
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|376014|23010399003|1800799024|10067099003|22082099003|18002099003|56012099006|11063799006|261022113327099003|261022075727099003|261026121527099003|261102123227099003|261021121427099003|261009223027099003;
X-Microsoft-Antispam-Message-Info:
	dF03ITe9MnnIVUc7/7V19LWaEh1W4x/zlE9JFW3uNOLCkJEyFhHrUGLilZUbDby6zdjJh1boKj6YnaowvNzr2jMxz42XqTaqH7fwOlKQd0FRTzgYkE2UC+9ZLHj1OC7u86tkZ8HTdkAOa1+/U6NmQdg6qjlLrrWZkso1Pe0KgxEZuD+GWo1DgP0asXh4WetpLT/XXQY4sxz7phCQ63KPN7BDoLEglGFW5Xn8Rw/1oJ7l7iCkdc01OBXBX6sCRNfH7R3h20f5hmZnSrxNcF3Lfn/WhotUqU6JCNHMz2RU+YWk/2pP+AvdLn0/x7WjD6sx776yhJ2vJ9OzgHy/NnkCfUSPqG2ahwt0+bWJbgjNmgAp7OaCm/KbP84YV+B0NlKKNgQBgbi08KXTTeKjwTlx+deYxxzEIzso/UfmHw8FkO8PUXRqRCjJmGOi1x8tViKnSXzTi/Hh8u2KPaVTsRgR8t0IxdfH/KmaLsC6FHHBQ2JEpACDih/EFvkCNDcpj1q0hFU9gI/Vx/MZVZJ7VWcc0N9ZbCZ76Z6nVH7Q6F3qKE1zLozT3BlAAdDVIE3SKiYyHwNi7mlEQmhEbo5AtRk0u5K3s8qKS8nli3AzVVY7YcgyfyF+KUq6G//9jvKjVt46FrD1uo2f4O6y3gIwsyoZVCt1oM0XKABts4Fv0wV6xkjordAzAW85xNzmp9syPzPo3JG5b7VcAdIH4TD/rLG+RQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(376014)(23010399003)(1800799024)(10067099003)(22082099003)(18002099003)(56012099006)(11063799006)(261022113327099003)(261022075727099003)(261026121527099003)(261102123227099003)(261021121427099003)(261009223027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	M3Fc6k1yCIgXehZYkUwbkFhlrmmXm1fxPkRdfhoL8VrgNdhswvzUBLgi34BfB0X9HLtKWWm8CqsM4U22+G4jLw/lux4TrDJGnBTHD/MXVcOq3ji1rNeAK+YT6JcK+jj6TrV9ETkkrqpyQvqqeGufNZOEvi8azDD5C5uy0zgMGufHBQ3SbHIsw1BN6lvwQzZtghuqOcZsJMGLdHVCZMFYrHtIZYBKkfTjEh9xRbw1nmrjceQzNHOHsZnCrLI6wvqD6b3bFi2R257KpLChuAg19eZILQKIjYsT7KHyGuGiiGV4r1rFBRqQwVA3FtxkKCXwXNqu8T655jBQz+lw3xDTmbdz/5+DDlFQ/LHy2HJQdQW+BhvImqRv82R3/QAXvLaYNXj9zKaTTGmq8wqVMYKuKwxJlOXr4MrnD+H0ykgAKfI1wFb6bAo/mMz74FciVb9K
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 04:17:26.8556
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e5b118e3-d007-40bc-94bd-08df3af3b351
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000037AA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6926

Log the raw event entry unconditionally before processing/decoding the
event. This is useful for debugging especially when decoded log doesn't
decode all the fields like newly introduced fields.

Assisted-by: Cursor
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/iommu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 8c09be157750..ea735ad46881 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -934,6 +934,9 @@ static void iommu_print_event(struct amd_iommu *iommu, void *__evt)
 		goto retry;
 	}
 
+	dev_err_ratelimited(dev, "Raw event: evt[0]=0x%08x, evt[1]=0x%08x, evt[2]=0x%08x, evt[3]=0x%08x\n",
+			    event[0], event[1], event[2], event[3]);
+
 	if (type == EVENT_TYPE_IO_FAULT) {
 		amd_iommu_report_page_fault(iommu, devid, pasid, address, flags);
 		goto out;
-- 
2.31.1

