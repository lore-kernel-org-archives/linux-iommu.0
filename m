Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010054.outbound.protection.outlook.com [40.93.198.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A05333CB570
	for <iommu@lists.linux.dev>; Fri, 14 Aug 2026 10:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786704072; cv=fail; b=tURTwpy9kZbbpnMlQovfZMWPMIewuvroQwtY+mclNfa19LlldqJKpScvwwEMchhQ3W171G5gjhVI+K7+86qFYPnLzw07o23bYm0B2Hx5+gNUqxQlXt22UtGVwoU16CQKrBwm0HPRLZosHDS39JNwLd23mc6RwfVLXcOT+ld3D7w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786704072; c=relaxed/simple;
	bh=DXCDdDHIKE0YN/xSz6MAa8v3aajTeGfg0aiJ0u+folM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=E3tn6M0DOpgTgAMW+yNHFhZPxWONpJ727XdwDQBgRdqj1a7/HXOyaVZAfeDjg+WmHvVGYZ7cmAqXMYp9MBdw0ZgY8gCde920rnxhLZe1AwFV5ae8f4yri8bo5H3PpISfZogx2a8PpKlHzGWgv957/0Qlq89pHrZ8AgsijMCf2Sk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=MAEF2Gow; arc=fail smtp.client-ip=40.93.198.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="MAEF2Gow"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dQ2tYJ/qOFK+gesU7vX3CZjDmFYbZmGkOKujVmVgnmsYPwGKhbBQsiRZ8p6BSRmL+sSNunOMj+tmb5s+haF4/6UNuHhiOQY9saagkM30CB/PlzoMtx8NaJzvCOM7OaOyMyr3LOTayHF9Zm3Qk9EWIIsOHl4qwPUz3Ezn3krgrRs+zfFTqQlYSaIwop+gxcZ8NPlkD94q9Ru1tBgHO+bSPxLbR1tCujcV1MEk8JIfnFX05sEetSn1FlgLVn4ufdbb1hsN0zy6462zTq9pQqvMampMr6PCWdc8qaRz5sEcJrwya++uL7R838cqc3OJxIrHUHfsmPeFfXnv96TZjR0iuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hhqteE7gpJ0Qunj8A+jg4BEcbbSxORZZtAodwKOXSl8=;
 b=qxeXGR70YR5+RFw9mKhOyi02LpQvZVOTgcWWL/GFxvkNdvQnmD8AyK98nKWnfTz3OfnHRT0Ke2jWYp/7EPlv/9YZl7CHVN+lzY+jTUOz+6P979jSzQTpEtewxqtuC3GeLNRgnFKD8Nod4/CsjS1qWnJ+h9913ncewugE9dzk7zsbmwFfRodpb3gB3R3oB/HUKmpiU1KYzUMnckJcUP71ZPDGRQ0hSaJKBCeW/XgsMA9Leq85iP/QkilnwaEP8lUhQT6UmK41EwJV0+jFTMt9fs2cSIm5nSfiUxeDt+wRTAtXbIgM9jmp7pKDy/M2uR/g6tDgwX83nwLU4nncgIlC2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hhqteE7gpJ0Qunj8A+jg4BEcbbSxORZZtAodwKOXSl8=;
 b=MAEF2Gow2HJKUHTcFhjP3W3xkKVA7DyjDR8S6rMpCvWcEOZSmMOFJIYp+kdLZ2g9oa1PAcgwkQ2JVaEMSSMMpxcbr48IIQ4VKCDY1lKCs+6fS2t5s6Dtk6hTSM1wyFX26phC+qpZpVxsfpVL0oGGQesOtUfCr1HsI+BzDSrbwUY=
Received: from DM6PR06CA0089.namprd06.prod.outlook.com (2603:10b6:5:336::22)
 by LV8PR12MB9207.namprd12.prod.outlook.com (2603:10b6:408:187::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.16; Fri, 14 Aug
 2026 10:41:00 +0000
Received: from CY4PEPF0000FCC5.namprd03.prod.outlook.com
 (2603:10b6:5:336:cafe::66) by DM6PR06CA0089.outlook.office365.com
 (2603:10b6:5:336::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.16 via Frontend Transport; Fri,
 14 Aug 2026 10:41:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000FCC5.mail.protection.outlook.com (10.167.242.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Fri, 14 Aug 2026 10:41:00 +0000
Received: from kali.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 14 Aug
 2026 05:40:57 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <will@kernel.org>, <robin.murphy@arm.com>,
	<suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>, "Max
 Zhen" <max.zhen@amd.com>, Liang Wendy <Wendy.Liang@amd.com>
Subject: [PATCH] iommu/amd: Remove iommu_group_mutex_assert() from amd_iommu_clear_gcr3()
Date: Fri, 14 Aug 2026 10:40:29 +0000
Message-ID: <20260814104029.71021-1-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC5:EE_|LV8PR12MB9207:EE_
X-MS-Office365-Filtering-Correlation-Id: 070042a7-6bad-4cd9-3f9b-08def9f0880b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|23010399003|82310400026|376014|56012099006|10067099003|6133799003|5023799004|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info:
	zpkfaMrCodAIVv7E48m8pyQFaMevFfkN+4kBvqB75qo6EKdsLFKm1xJ+B9raCO64fQQxGNx3BAQmjEbJCguqyt42Qv2p60wUYAAakQP8YVo21j7MG46BaY/g2HR08aAA2Kyi9AeKpa7dob9vBdlb/RK+PiQ02Qh7VCunz4YE99sHkIsMzCTnftbzcs/8pP/ugybzHksM3KIT+8e/HejjBHO9SCRYsKdw/oMKqpIkPIVp0X+2N4voPE6/5Vji7/xzSvuW22NzhYxXRU8O2pxnf/KcJVqtt90hBeI6C6JAV8ZF2CXswl/JcxpzuDs4mxXv8q8snhw3dvDJdcwg0IrKrlpFoHjKhuaKI3kQnI7o5CQDd2R4CJiU9Sjd0hfXbpeezUmLZ7CGSKl3KMC91zX8VuYq2p65W1gi9ozG8Kw9ijV4I5x8HQ8vSbQ5qQIppuMjNnL6E28fjDKwwiYABQsXInFyLGdS94bsY9UU+DaTVbtgcUnZr5I3jv7PXevpJN2hMxBBetL1LRawK6XLHmhpeyHHTGDQvdat551rlko8o4S8QAwWl0AYLe3sVjXeYN0yVhcI90CtwOOuk+4cqeeeEJGVHAf4B0VANQeutFdEyV0sCsQNY8O9Qt7WTVEWAzJac/BenrmkXM5x/8uH3pPu4YXoyBrwjFoU/r6S30PjSdHLRsnENRaQMCLhpQc9mYDGVUKQLM5qhWLbtr6wl3sEkA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(23010399003)(82310400026)(376014)(56012099006)(10067099003)(6133799003)(5023799004)(11063799006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	hsVGTouaxiNknFm6l/V37EoJ+glQ+4YCx4f2DYrGYmpyAW/d+Ow6vONbehXVyyxbd2orDQqrjfsL2XTXDdVdnx7KovgwgjDOz9ZCkt8944ebcUaLtxh67AP/OwplIrxgpW9gDXKZx2eFV2CWHuQQwM/DlJolFZOpclvmGmcNJDX360G1zbxeAQx/QmLfodDGrPuEK1MSKvETaXC9jjhE6PELsPRSTubt6q9TULlkx+cnIlaE5cL+kKKtOF3yt8/jUMcnRfcpTwmDbprF9Mi8cMDMnNF0bPnrvQlGIkmt3fw5f+jJ1Q6I6Q0W2jznxqRR5sAg2KIgusVN5QMXC8k8xlMaiMpvg5i+54uCdoqeLwQMrfghMBfxq/TzY35BbIGpB3cyEZYse86C4Kk1Ydea/0YfYVdsZ4wuPAAOzHTM87/s4Q8P2J++G+zG7h2qO65v
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 10:41:00.2372
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 070042a7-6bad-4cd9-3f9b-08def9f0880b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCC5.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9207

amd_iommu_clear_gcr3() is called from sva_mn_release() during the
mmu_notifier release path to detach a PASIDs when a process exits.
This path does not hold the iommu group mutex, since it is invoked
asynchronously from mm teardown context rather than through the normal
IOMMU group/attach APIs.

As a result, the iommu_group_mutex_assert() check in
amd_iommu_clear_gcr3() logs a kernel warning.

[62863.761300] ------------[ cut here ]------------
[62863.761320] WARNING: drivers/iommu/iommu.c:1361 at iommu_group_mutex_assert+0x3a/0x50, CPU#14: kworker/14:2/621
...
[62863.761706]  <TASK>
[62863.761712]  amd_iommu_clear_gcr3+0x1e/0x50
[62863.761724]  sva_mn_release+0x68/0xd0
[62863.761739]  __mmu_notifier_release+0xb9/0x2d0
[62863.761763]  exit_mmap+0x427/0x460
[62863.761836]  __mmput+0x41/0x120
[62863.761844]  mmput_async_fn+0x15/0x20
[62863.761852]  process_one_work+0x22e/0x780
[62863.761876]  worker_thread+0x1b5/0x380
[62863.761892]  kthread+0x10d/0x150
[62863.761913]  ret_from_fork+0x346/0x3c0
[62863.761930]  ret_from_fork_asm+0x1a/0x30
[62863.761964]  </TASK>

Remove the iommu_group_mutex_assert() call from
amd_iommu_clear_gcr3(), since PASID teardown via the mmu_notifier
release path is a legitimate caller that does not and need not hold
the group mutex.

Fixes: 1af95763e0a3 ("iommu/amd: Initial SVA support for AMD IOMMU")
Reported-by: Max Zhen <max.zhen@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
Tested-by: Liang Wendy <Wendy.Liang@amd.com>
---
 drivers/iommu/amd/iommu.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 29dc18d3d22e..1fe99fb98793 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2063,8 +2063,6 @@ int amd_iommu_clear_gcr3(struct iommu_dev_data *dev_data, ioasid_t pasid)
 	struct gcr3_tbl_info *gcr3_info = &dev_data->gcr3_info;
 	int ret;
 
-	iommu_group_mutex_assert(dev_data->dev);
-
 	ret = update_gcr3(dev_data, pasid, 0, false);
 	if (ret)
 		return ret;
-- 
2.31.1

