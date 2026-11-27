Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.43.42
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795778578;
	b=MIos/zKZFNlhByAwKUEqR6IyjgsRxYOZugqx8l+GquJnqFirp0cB0fPh/9pM2S9S3CFW
	 BJ60Lg7VxqN2YASCTVaEtf79OmzcazVXiR8jojgoM6/jZvvQYj0s8f8QBEirVKqc3Zo+z
	 0AE+ML24wGeNNo0k0FBiJBBz8QN4kc+Xe786Ybh+m88i8h6ZMA1L5k0dyj8gxluW+RQ3F
	 ognj4gQClBofExNNwgo4vTl1/wFQ75XDWWbXgk3CqUNeeUmqjs1yz1Xr0U03EDL/crGri
	 OHzHjN7zSk7b5y9BGVrmFNCsHZ7+LojHGpRyZdLLs+EW8WXhTrhFtSPYRojNE8aoExA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795778578;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
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
	bh=YeX/LwvRxzxg50aRWT684lf2C1yeAvVGoN7YvmSM3ic=;
	b=EMzFKp79T2a4gw5XHYp/JqpNB6ZkKqrnmZ3o5jpXhXCuzdw7YR0aQ1GiCo3ks3dHK5c5
	 9Phezn2s3xf2mq+UhYuIjC7JddeRXGeufnbUDlEvnY3MeMp9DeGPUJzeYrfBmAndFSAXV
	 lYBRsLyOYBzGNuFnetEg3fIkgL2Jrz5hXB0Yqv9avYSTn14LZW0UFltyKAnsm+28qtz31
	 9SSX5sDZo2DlOPlDQ1dFrsvd00vTC7RvJq7r7EJ7ZCYPpU1HJRgRvX1kHV/vt/eEr/qv4
	 eEXZRL/ttrqvX5uJv3MHN7Tua/Ly7mHrhDd3/V7Aou/t8soDfSeg7sV9r0NaV+y/gGg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=zYFsoDZy;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.43.42
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012042.outbound.protection.outlook.com [52.101.43.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95533606A31C
	for <iommu@lists.linux.dev>; Fri, 27 Nov 2026 11:22:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 95533606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=zYFsoDZy
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vGY2a23OdKS2cx/qta9fErNK9ek/dFQgbpUkiClGL+9D7uEe2hzjIB2AkMaFcL/Ngaxe/KgR67CJftJd5FGAfGsjpYtnNIx6vCRRuBNvUNZ4mEr+4VRUwfrsE8fBxbRPOdI01m7GUheqOnODF7jpx9hQUOn1IciJldov/EU5oQ91Lmri5iD8H171Wv/5Z+Mh5dnip8v5/2hm+LKZTUkXKdOoykYkqh8FwBPmBk37wpRqFgo1C96Fu7lPz8BuDYn5J06fJbeXFe0BKSuqd0+HynlzWj/+XXSamLB/X4tOT7JPOJiAvC4aH8tgDiwspRMG+Xfhfr9i7YNXxoPiWVUWLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YeX/LwvRxzxg50aRWT684lf2C1yeAvVGoN7YvmSM3ic=;
 b=TIqXjtqTjloadC02Ldfe/7lfZyAoVq7F9kAWEAELjBEpH3elCG1IYWuw9BvKnAAsTggFm+0zjDjBYjioEIA/1o8SIQOZiLbRsS0WKIH0xmtpRGpMG3INWvmqQdyKhg43QPwisPykaAGSZaRF8+nBa0PthR6PfWvyIUM9/O2VdWpp4f8tpbdw346at8sk29VssuqOmjg3/at3ymhIYqUfVxrAB7X9ZWXkVuhHbMhJQXaPP9Ysn2gQwFzuU0q2rj/25lcplPEW0XYK1W3kcJi54ABksT0H3WXRh4tfZJntnSv6diwhQ/qtcUpghYgc38WiWEzgeJMZoii/2E+m8h2Yig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YeX/LwvRxzxg50aRWT684lf2C1yeAvVGoN7YvmSM3ic=;
 b=zYFsoDZyLAcMqsDsgwOcidmGpSg0Cm6TfbYTZyAwShfHP1O03RcEtt5hWEn/dXUHSxek9T3jFAi47ytagkKC1+BviVZSBKpnB0uGz1gPn6QbMPcNyex30FOIX8hhLnmZSSXrUkELDsnEDU2saeWc+gylL8ZVImxV1Oq+n3/eQww=
Received: from DS7PR03CA0082.namprd03.prod.outlook.com (2603:10b6:5:3bb::27)
 by DM4PR12MB5723.namprd12.prod.outlook.com (2603:10b6:8:5e::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.12; Fri, 27 Nov 2026 11:22:53 +0000
Received: from DM3PEPF000265BA.namprd04.prod.outlook.com
 (2603:10b6:5:3bb:cafe::69) by DS7PR03CA0082.outlook.office365.com
 (2603:10b6:5:3bb::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.9 via Frontend Transport; Fri, 27
 Nov 2026 11:22:53 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DM3PEPF000265BA.mail.protection.outlook.com (10.167.23.247) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.688.5 via Frontend Transport; Fri, 27 Nov 2026 11:22:53 +0000
Received: from kali.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Fri, 27 Nov
 2026 05:22:50 -0600
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <will@kernel.org>, <robin.murphy@arm.com>,
	<suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>,
	"Santosh Shukla" <santosh.shukla@amd.com>, Ankit Soni <Ankit.Soni@amd.com>
Subject: [PATCH v2] iommu/amd: Continue the completion sequence in SNP kdump
Date: Fri, 27 Nov 2026 11:22:33 +0000
Message-ID: <20261127112233.208738-1-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: DM3PEPF000265BA:EE_|DM4PR12MB5723:EE_
X-MS-Office365-Filtering-Correlation-Id: 951e24c3-cec1-4487-9b05-08df4c78c740
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|82310400026|36860700016|376014|1800799024|6133799003|261009223027099003|18002099003|3023799007|261026140227099003|11063799006|56012099006|261102123227099003|261021121427099003|261022105027099003|261028144727099003|261022075727099003|261026121527099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	JPLlEzMDoHoWLfhG3s3e1W8Wsf8/PLRXdbfhvGscqHaeszQA+/c8qOlh4PMFbUHc75wGtljAs6PReHikR2TVDwaRa4DLidn97mqChEmIrmXbbQUS5sTTD5R68cKVJA+BF1uza6nS+/tZQIKZcQJMtHPgGL1bQTd2peJ25XU8WaLPjC8V48nvFyIDk+XpqZYP4h79G6FcJD0zVmJWZUEupztZaVXZAlea4zrYvP1Ja7dXBt+S1iS3EXT3WhkFU/74W8BfLYcnz6pHbWSzUfQaa+MmbEtVOSSgaixr1MTWM3rV8jsezVIuHg1G70Fz0WQytEY+FPioYrplMaNF3yoFJaUY/aqHi10IqXXPCR26GBwuAO0pcJGm+uzj0Rl7FquBEf3dCjYLK+13EntsiBgKZXAYS8A7DDrd6t9gAnor6O3vYPQnRImwbPgItkdY4FE9P1d8vFc8ZSHinpHrepmuFLeZqyXx2QrDAULQqQboya/ZEyiNWMys+Au1Sbj/GIL2NgCVQLuPx7DDbVZxEPaNcFPCG2AEHqHIPsTLvr7QPukc1Lldc/fjIdPi6QyCpMpR7d/k6MndaE2wAdQHUXuZtgGlo3+w7zdfZMiY5Tx+35e+mW3bChxd+5lb9VUkHNk1/kbobkPIpdP9XX1xoVTu+4aTbQWfOJTJyVNNFg5ed//fnWQFHF+fGsbBPbC78lu2oQRMSUWmVjvXUAgD3V3Fsg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(82310400026)(36860700016)(376014)(1800799024)(6133799003)(261009223027099003)(18002099003)(3023799007)(261026140227099003)(11063799006)(56012099006)(261102123227099003)(261021121427099003)(261022105027099003)(261028144727099003)(261022075727099003)(261026121527099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	10zT6vhMUnJJrXgoENm87+fZQHTDubYfV+bZ2Fy5hizMYLX0fIyRg0AdeUj6kwGPBuoe8ZmHcOFQQNGIzhwVqA86Nuwb1wDgLBt7ilcZPJQ2DVw/RNyTYaXtbyWKHcW47KBb4PvcR+wyOVAxmHnBZFV8E/ijj0Lz45/WzfBfm4qNb6lhk5jyTbbOAt65YMrFWrmsuyFnjkWMYyilBbSzr0LgVZ3jPkNZyucQDJa6N5ryrGdEfJr1GGFSSRy2CyDiC+tApQ/OlN+gpSMlGfNXitJNwBdP2U4U1Sm9bhbMfScRPGFWj6OVN4d3Uk55wqiSQnYoXWGcnqu7zbCs2iP7jWLVrusN/C/jT80ctIVhSLSx3uWwotAyndvvFe0/rGAQ4xLxYBqc7HgYl68k1p9VJ05kfBM2PK049dH4/9y/lQ2aM5dHm+OPMMBedrISLlr1
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 11:22:53.1830
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 951e24c3-cec1-4487-9b05-08df4c78c740
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM3PEPF000265BA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5723

SNP kdump remaps the previous kernel's completion-wait semaphore
because the completion-store registers are locked. That page already
holds the last sequence number the IOMMU stored, but cmd_sem_val
starts at zero.

wait_on_sem() returns once the stored value is at least the target.
Until the new counter catches up, every completion wait succeeds
before the IOMMU has executed the command. That includes the cache
flushes issued while the kdump kernel adopts the old device table.

When the old device table is reused, sample the semaphore after the
command buffer is disabled. A completion wait fetched before that
can still store a later sequence number. The old command buffer
holds at most 512 commands, so continue that far past the sampled
value.

Fixes: d2a0cac10597 ("iommu/amd: move wait_on_sem() out of spinlock")
Reported-by: Santosh Shukla <santosh.shukla@amd.com>
Cc: Ankit Soni <Ankit.Soni@amd.com>
Reviewed-by: Ankit Soni <Ankit.Soni@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
Changes from v2:
  - Rebased on top of v7.4-rc3 and updated tags

-Vasant

 drivers/iommu/amd/init.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 58f63298493b..10e89b5f3760 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -3066,6 +3066,20 @@ static void early_enable_iommus(void)
 
 		for_each_iommu(iommu) {
 			iommu_disable_command_buffer(iommu);
+
+			/*
+			 * SNP reuses the previous kernel's completion
+			 * semaphore. wait_on_sem() returns once the stored
+			 * value is at least the target. A completion wait
+			 * fetched before CmdBufEn was cleared can still
+			 * store a later value, and the old command buffer
+			 * holds at most CMD_BUFFER_ENTRIES such commands.
+			 * Continue past that range. A new page reads as
+			 * zero, so this only skips those entries.
+			 */
+			iommu->cmd_sem_val = READ_ONCE(*iommu->cmd_sem) +
+					     CMD_BUFFER_ENTRIES;
+
 			iommu_disable_event_buffer(iommu);
 			iommu_disable_irtcachedis(iommu);
 			iommu_enable_command_buffer(iommu);
-- 
2.31.1

