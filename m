Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.194.36
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793850439;
	b=j19eDg5UyRKtaXdk3Gy9rmmUA9uM6RdHk9KuiELkTLNXb1V5DCnkaa1kTyQ3ViX23W/H
	 KSlsCn9Kn3Ox019wcqpDE80lDj5KaoWtElqaBHVnCnyo1QW47flUeYkpu85S4ZuGeJWOZ
	 4lvZojUVpFVWahX+8BCHTss6biilIpLPk4Y8ibw/gfBNPWfPa9nQSk8xNIUtL5Ui9r3LZ
	 tCsbVmUKkxXO5/hPubTuQ9hC/xm9Sgq8FamonreoVgoExnN3w/nK84rzOFSBC56NqXrod
	 0kmtw80BfkYLODZt8f6BaVWqmQmPyHaWCpfuNNfIr6TChjpW4QLFPbQ+PtTs9tLeCuQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793850439;
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
	bh=ZaZ9cfX6uf4QQnt9fzz3XNa2xLuULNJHzmLwzZzGlHE=;
	b=GFZRirVQDrVEM9KwhI4cZDUPM3klP5bxPOxcDgZlxyTn+KJRt/sFcUYt/5SQ5hJ7CkuS
	 mGKXXb47sPz0tKjbWxPt6RCL3C6IJtj0YMKas/hOoRH1m6H6KShej5yZPR3Sr8ev7ZWbj
	 enviRnxwWmm9oxgvAMRbu07a7soTawH0OGRmI3/lnMZScF6J+nTyH7I4Ue/u62ay2tNAA
	 NwPBWefVWg9Ng96Nc068AScla7ttcT3Kzg8nNuNdQGYwShnjjxkKnZ4Wuixx3YOG3a2rm
	 PtW6gAOZZdFDtZlssrrDKAvpuqjdDzCSvBNQFbQc3a6VdJ+lepFltyvu3ivTiRyhnYA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=RSTunYkL;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.194.36
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011036.outbound.protection.outlook.com [40.93.194.36])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3851D606A31B
	for <iommu@lists.linux.dev>; Thu,  5 Nov 2026 03:47:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3851D606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=RSTunYkL
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gmil48hnlmaOa+pxfbbC+4iq796y02IvAmXG3ueL/eVBiviZRK7VEAQN7CWC/8O+RVY2W3V01gWVG777B/UMprHYy0vkrExkXohoxCvXgf8qoyj/pqxUWBQKnF+PYfT4YD344KatQ0c1FD0oFc4IIvYPtB7eZe8Bkm9bJ9QE3MjdiZ3uK3fQ+XiQP4zTecdPbQGjEGxf+IPtz52sQpKkVywDnCsRx0LiBRZE4EP+UjiJxYIar1Kc471n6SmP2N0WWKBPC0FqNE2i0GDeVCkOCDtYiPaV8/+yjfb3fRh6kcz5sAidIFki3V5dPD8y5C0LwyVHVA7EMAMuddbzfZOjmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZaZ9cfX6uf4QQnt9fzz3XNa2xLuULNJHzmLwzZzGlHE=;
 b=q1tWLjv1JPw2qBrR1bCTLtAlAM2E8T+f8gCyoiRfT3ZPBwMwZvx6k/meyQaGYTlG9cQsUzjnE6dJFB2TaZEZs/D776UwLQngWWDtLCQvyvNOmAIySgswlYns4v7MFX6hmWQrKdTs2wLrRbosrem0fxFolEUJgwCEM1b70pRrt1hdd3vOZn6y3rOvRi0Q10gySWJzmlIzTx92eVoJVxmGbfTJPSCzxdNLsZfRyDU6xsgUF/1S8pPlnfnvVwo+DRMUH3qKKXGuDfCAAI2IC/2675gm4TL+cV6oa5G+7XDj9DiCDjONZ2D/Vz3AJvA4eWogRxpCkAvc6Eo9UQEEFecbow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZaZ9cfX6uf4QQnt9fzz3XNa2xLuULNJHzmLwzZzGlHE=;
 b=RSTunYkLxtZmLZ2aZvBaqeCvuBmEfVdPn1mCt8OWUT8/AyVRftfKprCBimj4FK3tmuZg6SGhA7Gas6B7exFBTfc48/BwBrtyPvkbSVtVWRKZM9yuP0g85+CJvxKPeTUNWq5yuZOXGI8sLzpvntaYli7YhCDwjPD7tQ7VHiVRSSI=
Received: from CH0PR04CA0044.namprd04.prod.outlook.com (2603:10b6:610:77::19)
 by PH7PR12MB6936.namprd12.prod.outlook.com (2603:10b6:510:1ba::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Thu, 5 Nov
 2026 03:47:08 +0000
Received: from CH2PEPF000166C3.namprd04.prod.outlook.com
 (2603:10b6:610:77:cafe::6b) by CH0PR04CA0044.outlook.office365.com
 (2603:10b6:610:77::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.10 via Frontend Transport; Thu, 5
 Nov 2026 03:47:08 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF000166C3.mail.protection.outlook.com (10.167.244.231) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Thu, 5 Nov 2026 03:47:08 +0000
Received: from kali.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 4 Nov
 2026 21:47:04 -0600
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <will@kernel.org>, <robin.murphy@arm.com>,
	<suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>,
	"Santosh Shukla" <santosh.shukla@amd.com>, Ankit Soni <Ankit.Soni@amd.com>
Subject: [PATCH] iommu/amd: Continue the completion sequence in SNP kdump
Date: Thu, 5 Nov 2026 03:46:46 +0000
Message-ID: <20261105034646.398549-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF000166C3:EE_|PH7PR12MB6936:EE_
X-MS-Office365-Filtering-Correlation-Id: b298e286-a15a-42b5-49a0-08df3aef774c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|36860700016|82310400026|11063799006|56012099006|261021121427099003|261022105027099003|261022075727099003|261009223027099003|261102123227099003|261026140227099003|261026121527099003|261028144727099003|10067099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	x8GmPgvveCZzamlB+k0jr+CP+Janebh9fMMaBOebcHBt1HQO5x7y1EvJ7kWc27rIu5berU2TM2ZX/xEAPudbN5UqALJuYWNCKdwX95q3Q6qSbAo5oCZ0MxQ7xncWSxZeNkd6NciobuPG8p5SqEFHaSo7vY6GFi4nozciEgNIuX5ar9uB1nLsD1lyzD0w1vUdTn60UhllRNdg4rVWrhu9iGlvaOGxUoKJFAUoysxLxXPrjyL/3DyOngtiSxjjSr2HR5wq63goQbUvvc8UsYi5MW7H+MVbVmkbJ70CiOoMuX/hpnwMycqQlt3ZIzIPMxhdvj4u3uG30k2C1aAZifcAMejmANoIAAVTJT9r9qCSAu99JNSuVlha8U5ghvCGggUpZTNOHgLcX6FOPK4eOikdHSTmx058kDR5xq4Jv/b7QM3tbNYztBjGI5nva2A0L6RnE6UGMhrWOYKwbAGqIsjYsaBwH+RIMxhHUva7PAGKPfbWM3Oplif+x+joKzeT58EwxA2zGxUKKBDBG1GDtVOms5CI8Kt9/cPDq6lOWYeUMe7hjdR2AXEe7KzZgPKQV+fZIgICThdlbkFVVlWCpi8wi70/FohMzv+MAqi0yMKDzcdTBiU1fQ5+7W/Lk0kMldeC6BrkxXzwJ0UgpoLzZeA19Opj27i4C4xeqFiDavsorCyGwwu1soo5eHLsCQyVNNRE/zMaNm7WPbEBNRjcjCBBJg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(36860700016)(82310400026)(11063799006)(56012099006)(261021121427099003)(261022105027099003)(261022075727099003)(261009223027099003)(261102123227099003)(261026140227099003)(261026121527099003)(261028144727099003)(10067099003)(18002099003)(6133799003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	wRTvI5VLFz6x+ueqVwbtbfh+pKCwqHQzHuWKF2b6/FRWygJFoGudSMS4xTWDLl6iEPYz0+7ywiZXpqXl+HXJ9xEfh3cB1JQrB74nV4SO288+fYw0/BIMyk4OLSs4r01wW8ecylhCOwLR1y1/i4Lb1AXPKEG5gbxvE0vE0AnWDvv+mfTfZwZoTtd7X5OvoKt/jm3E8PsDSE6VcnCRtbkWaS6QurCDkyD3xmx/ZzuQTOok/SbwrIUar1qY3ZJ/MZMgu3/XBjkxU6SKw5cTG6OLtB3FkChisfOuUFye1FDMsOSByCrpmt4hLz5kCMrK56dyVRrwdqeEsrlQqCHWohDbZEnNyPwxWChWmVHVzDbH3tiiIdQS2Ec3TsMtrWplg4aFF+6yk7PWWgz6cJVLI2vyzB2QdRzrVIkEX97CIA27PIfOvLa7mE2Td3IRTszXIrUa
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 03:47:08.2373
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b298e286-a15a-42b5-49a0-08df3aef774c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF000166C3.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6936

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
Assisted-by: Cursor
Reviewed-by: Ankit Soni <Ankit.Soni@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/init.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index de6db5621194..28a4067a7a05 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -2992,6 +2992,20 @@ static void early_enable_iommus(void)
 
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

