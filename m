Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012022.outbound.protection.outlook.com [52.101.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBF5F36E478
	for <iommu@lists.linux.dev>; Mon,  5 Oct 2026 19:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791228703; cv=fail; b=KiT9qGJ+CpYlXcD3RujyaI4jcaGPS9jkvQnsoluOlvY5MOf2a/d2VBbRhzwpkqf02jAmKUJhN448k9jsUD3JqTsAQkAreDIzGPssoAAhukbXEY5/6ihqA5NG7ai0SZPpXXmOxAjBsP4+2pOUSXcw7LOTe5QlC2WBE6e92WA4Tt8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791228703; c=relaxed/simple;
	bh=BIVjbyBLIqwNBlaeZ8utGyvFchFrJfLIKhAtj+gPnIs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K5dKCkfDNiv9iXGX/l6AY8LmfXG9gOvWcbGz5iQk4LeO3ntfISzYH1H3Iannmqyiv8Uk1RZkDRtV6KuMokSedIsN1cG6cr6nsMFYcFXCrSSZ8IBiLKiIarft9UiKi5LoLLNjDl2k2DXrnCkBhLkjohcST5OTcbmevviEGHvqYKs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=InRYT/tL; arc=fail smtp.client-ip=52.101.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="InRYT/tL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xYK/AL95nQqwV6+2SbUg3WlbDYLpdxDVmb5IXfvNnRK56kH6xYbTlObPQDcEHflYxwx3HO7CbPDVusNdha6svfLjCG5FLLU8CIlJ4C7ZHJsEcphrjFZHjC1yuQy9YxQVQ5wAmqmBhGkkmJnTKkbrl+qxYMM/t0cnjnfBcXutNzieigSLoMY0U0ocVO1qtieCdCRnJOtwXlCwsnHj1YVf25ywGLfBnxZyNson0bKurAKuEOOtYRoAAtjPmQN1F6ezDH/The8Is/YB4rbHPbyhwb3Zk2TGxN3mUXWXehw7SXc8iuzVKpRmhDUBzvYerdtZg0y/P/toJgsjCGEjgR+grQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XChLkM+TUsb+FZ2ZG36maBfKgdsXxrk1+uIYcsWhybM=;
 b=koRcAThubD77pz2EIO01Q2RADdEq5VkpJqy/xw8zthPtWuVo4iBvus2kFCKlz1r9zGmwcZaUiOY3YAUv6zWTr/ZKt4oump5zPKmkbw5mv0lXKkdhqvzVt/n5Lx6PIVtHkpUZgUvhs0R/BJzhQX3bEEUveAxL+wyj9ZCAYU7KfEM4yiLoODGmghoAyk/FMz5hVn992upRYqQPV4C7LYGbYoRmzaWiwkHEKGYKda3/zHa8nIErXjZL2QPFtaR+inoCKxGMYjKIaNw9Q1EQxhh845hd/uYISVDT/Dz00eze+Z5lNTQKaZ1WHclF6Twbb8s+MpC33iw3x4PJ17ZES/sG7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XChLkM+TUsb+FZ2ZG36maBfKgdsXxrk1+uIYcsWhybM=;
 b=InRYT/tLwTnyPWn9ZJj0dW+pG7UuObD8tFYBlGNLjcHUMbDkA5bFvR3BSY2RSGkeoxCcmssKHJ/30seeIDhe0zG9xitlAi6Iabq4wV0PToZ9yhhTCOgZO2OrCRVsVQWdRCvzxSajGCeBF0fMFMOlNfJaJ7rxsXCAj+zvuMKjVrMjMiz9W5dH2PMssHP68pPWjs4wFSBLM3U6ilp3i2LLWZDjI6GDc+XPMPvF3siEgpUmFdeZxNzpxggyTEopOP/zTxF2GQBLodeHb3GxRAWrznqr0w5DFuo8qzmnNuLJ9Xq0daz62MFf97Z5UJhMbZ7YJe7w3yTl+rgsWrMK806sZg==
Received: from SJ0PR03CA0256.namprd03.prod.outlook.com (2603:10b6:a03:3a0::21)
 by SA1PR12MB999107.namprd12.prod.outlook.com (2603:10b6:806:4a2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Mon, 5 Oct
 2026 19:31:35 +0000
Received: from BY1PEPF0001AE1A.namprd04.prod.outlook.com
 (2603:10b6:a03:3a0:cafe::8d) by SJ0PR03CA0256.outlook.office365.com
 (2603:10b6:a03:3a0::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Mon, 5
 Oct 2026 19:31:35 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.118.232) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BY1PEPF0001AE1A.mail.protection.outlook.com (10.167.242.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Mon, 5 Oct 2026 19:31:35 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 5 Oct
 2026 12:31:07 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 5 Oct 2026 12:31:06 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Mon, 5 Oct 2026 12:31:06 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>
CC: <robin.murphy@arm.com>, <joro@8bytes.org>, <jgg@nvidia.com>,
	<praan@google.com>, <kevin.tian@intel.com>, <smostafa@google.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <jamien@nvidia.com>, <kas@kernel.org>,
	Cristian Prundeanu <cpru@amazon.com>, Breno Leitao <leitao@kernel.org>
Subject: [PATCH v11 08/11] iommu/arm-smmu-v3-kexec: Implement is_attach_deferred()
Date: Mon, 5 Oct 2026 12:30:51 -0700
Message-ID: <a80c74a629ee31af4dead1e9c263cde81abd5c1f.1791226953.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1791226953.git.nicolinc@nvidia.com>
References: <cover.1791226953.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE1A:EE_|SA1PR12MB999107:EE_
X-MS-Office365-Filtering-Correlation-Id: 6cac33fc-79d1-4666-e009-08df2317448d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|23010399003|36860700016|1800799024|10067099003|56012099006|6133799003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	9pKVbXstfemycFoYkBB6iYX/uVJ+YGx2xIhCpaRpVMnkvI3XvdRAv6aHsXmWFQOUIqI8y+TX6N3nH9KWPY37/WpILrln//V3/cJwgAQmEeIFsd8zWv0LYLLeGkk7x3m6aG+VUEEZTHEqVwEhiEXMuy5lYKeLuekyFKq0gbBiG4GyCG/uYvmyLAEMSHNnZXQS4mRMNC2XJA2DyH9ZO+TLlSiDkwixArye7l6HXD5bREjPbOM6DAhR1zU00SIT8y1eor9OjOk37wF7ggvYc5aK/bHk4wyeFaR7HOB9l5e9g6q/LXKX2ARMyKizsDajquzR1/IognYDvsfFyXoAqTcZV35uGcQNOoK+t0zkTbc0nYow0urj7PveHjAwqaRSonr+M9mb7sbRwqWokTIH2LoHJzGWC+Z87VSa+vL0RI+iZXsQeh56jUlbtS6yLdDnjoIzSisnr4NcngaFsI51JdniVYzULSCpFklTORdXxzi/bfXXqxcEIkUFh4WSEkslhg8LbIZlLrta73Pw9GB7C9A+XC6EbWlvq8qM0IYQ2korr3onVNmC/ysuZaZ+PKE/w16wfLooxqWW6UnkMo12ZK1+U7JGe4Jl34Q4cwiIrBvri5ZOcxvW/NRYxqutWDoN6ZdI3Q7DihyFMrj/cirR2J62bGyIwf4C1K6qiPEAv/X0Xv0r+bnkabqoYyiGdtZwBI4y7yW+sjy3W1Z1hTAaBWLKeQ==
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(23010399003)(36860700016)(1800799024)(10067099003)(56012099006)(6133799003)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	0KR530dFD15cPOJ0qc458X629KjNSbekDY90ssfOw2kWXkd2RZoDyqgASk7i8iCi5yKja3KPG4PNizOVZYdDn8cdqWO+GBIP/0IxALbGtDnyeNprESBuBz53WM6IM9wfdqzKjDU1jDjsb7e4UhcTaRqOXo1R/PeTFtPlc6hsGkdo4jzTpCGfZAjk/09s6/iN4gkNCo+LobKBwIucfjwFlkCR2sZwADtEt5nd3jeat9HXPkYRM5bMmr44NhHwy0YiLHScIib5Er89YEQ/dvsI6SV0WaDM49nhBwO+lL90CPtrrnRvtBuHzSORxhIcbMmeEW36mzlPIHyDUFn5MlWj0TDVe3MA+gBfCoiafwFE/8gqDJ0cJsYyMULIlrxHGcAgvYe0Fp2MZOMNaQRRWLxC5OrrzKc2lHxXxpPgG5lD/kAR7l8Z5OZ6kPjMygc3X45R
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2026 19:31:35.1091
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cac33fc-79d1-4666-e009-08df2317448d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BY1PEPF0001AE1A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB999107

Though the kdump kernel adopts the crashed kernel's stream table, the iommu
core will still try to attach each probed device to a default domain, which
overwrites the adopted STE and breaks in-flight DMA from that device.

Implement an is_attach_deferred() callback to prevent this. For each device
that has STE.V=1 and STE.Cfg!=Abort in the adopted table, defer the default
domain attachment, until the device driver explicitly requests it.

Also, move arm_smmu_get_step_for_sid() to the header for the kdump function
to use.

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Pranjal Shrivastava <praan@google.com>
Tested-by: Breno Leitao <leitao@kernel.org>
Tested-by: Cristian Prundeanu <cpru@amazon.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   | 23 +++++++++++++++++
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-kexec.c | 19 ++++++++++++++
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 25 ++++++++-----------
 3 files changed, 52 insertions(+), 15 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index a1f947e7d9fe4..49604550e3b9f 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -1280,6 +1280,22 @@ int __arm_smmu_cmdq_issue_cmdlist(struct arm_smmu_device *smmu,
 				  struct arm_smmu_cmdq *cmdq,
 				  struct arm_smmu_cmd *cmds, int n,
 				  bool sync);
+
+static inline struct arm_smmu_ste *
+arm_smmu_get_step_for_sid(struct arm_smmu_device *smmu, u32 sid)
+{
+	struct arm_smmu_strtab_cfg *cfg = &smmu->strtab_cfg;
+
+	if (smmu->features & ARM_SMMU_FEAT_2_LVL_STRTAB) {
+		/* Two-level walk */
+		return &cfg->l2.l2ptrs[arm_smmu_strtab_l1_idx(sid)]
+				->stes[arm_smmu_strtab_l2_idx(sid)];
+	} else {
+		/* Simple linear lookup */
+		return &cfg->linear.table[sid];
+	}
+}
+
 int arm_smmu_cmdq_issue_cmdlist(struct arm_smmu_device *smmu,
 				struct arm_smmu_cmdq *cmdq,
 				struct arm_smmu_cmd *cmds, int n,
@@ -1318,6 +1334,7 @@ int arm_smmu_kdump_adopt_strtab(struct arm_smmu_device *smmu);
 int arm_smmu_kdump_adopt_deferred_l2_strtab(struct arm_smmu_device *smmu,
 					    u32 sid, phys_addr_t base, u32 span,
 					    struct arm_smmu_strtab_l2 **l2table);
+bool arm_smmu_kdump_is_attach_deferred(struct arm_smmu_master *master);
 #else /* CONFIG_CRASH_DUMP */
 static inline int arm_smmu_kdump_adopt_strtab(struct arm_smmu_device *smmu)
 {
@@ -1331,6 +1348,12 @@ arm_smmu_kdump_adopt_deferred_l2_strtab(struct arm_smmu_device *smmu, u32 sid,
 {
 	return -EOPNOTSUPP;
 }
+
+static inline bool
+arm_smmu_kdump_is_attach_deferred(struct arm_smmu_master *master)
+{
+	return false;
+}
 #endif /* CONFIG_CRASH_DUMP */
 
 struct arm_vsmmu {
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-kexec.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-kexec.c
index 22d997480db1c..8a76b8cb4ef0a 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-kexec.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-kexec.c
@@ -697,4 +697,23 @@ int arm_smmu_kdump_adopt_strtab(struct arm_smmu_device *smmu)
 	smmu->options &= ~ARM_SMMU_OPT_KDUMP_ADOPT;
 	return ret;
 }
+
+bool arm_smmu_kdump_is_attach_deferred(struct arm_smmu_master *master)
+{
+	struct arm_smmu_device *smmu = master->smmu;
+	int i;
+
+	for (i = 0; i < master->num_streams; i++) {
+		struct arm_smmu_ste *ste =
+			arm_smmu_get_step_for_sid(smmu, master->streams[i].id);
+		u64 ent0 = le64_to_cpu(ste->data[0]);
+
+		/* Defer only when there might be in-flight DMAs */
+		if ((ent0 & STRTAB_STE_0_V) &&
+		    FIELD_GET(STRTAB_STE_0_CFG, ent0) != STRTAB_STE_0_CFG_ABORT)
+			return true;
+	}
+
+	return false;
+}
 #endif /* CONFIG_CRASH_DUMP */
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 3ec49c1e16aa7..d301f313ba1aa 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -3142,21 +3142,6 @@ static int arm_smmu_domain_finalise(struct arm_smmu_domain *smmu_domain,
 	return 0;
 }
 
-static struct arm_smmu_ste *
-arm_smmu_get_step_for_sid(struct arm_smmu_device *smmu, u32 sid)
-{
-	struct arm_smmu_strtab_cfg *cfg = &smmu->strtab_cfg;
-
-	if (smmu->features & ARM_SMMU_FEAT_2_LVL_STRTAB) {
-		/* Two-level walk */
-		return &cfg->l2.l2ptrs[arm_smmu_strtab_l1_idx(sid)]
-				->stes[arm_smmu_strtab_l2_idx(sid)];
-	} else {
-		/* Simple linear lookup */
-		return &cfg->linear.table[sid];
-	}
-}
-
 void arm_smmu_install_ste_for_dev(struct arm_smmu_master *master,
 				  const struct arm_smmu_ste *target)
 {
@@ -4598,6 +4583,15 @@ static int arm_smmu_def_domain_type(struct device *dev)
 	return 0;
 }
 
+static bool arm_smmu_is_attach_deferred(struct device *dev)
+{
+	struct arm_smmu_master *master = dev_iommu_priv_get(dev);
+
+	if (master->smmu->options & ARM_SMMU_OPT_KDUMP_ADOPT)
+		return arm_smmu_kdump_is_attach_deferred(master);
+	return false;
+}
+
 static const struct iommu_ops arm_smmu_ops = {
 	.identity_domain	= &arm_smmu_identity_domain,
 	.blocked_domain		= &arm_smmu_blocked_domain,
@@ -4606,6 +4600,7 @@ static const struct iommu_ops arm_smmu_ops = {
 	.hw_info		= arm_smmu_hw_info,
 	.domain_alloc_sva       = arm_smmu_sva_domain_alloc,
 	.domain_alloc_paging_flags = arm_smmu_domain_alloc_paging_flags,
+	.is_attach_deferred	= arm_smmu_is_attach_deferred,
 	.probe_device		= arm_smmu_probe_device,
 	.release_device		= arm_smmu_release_device,
 	.device_group		= arm_smmu_device_group,
-- 
2.43.0

