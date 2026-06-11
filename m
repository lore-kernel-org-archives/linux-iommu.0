Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012027.outbound.protection.outlook.com [40.93.195.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4659386575
	for <iommu@lists.linux.dev>; Thu, 11 Jun 2026 08:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781167384; cv=fail; b=Zh6FzawqgRg/gGCaIsiE4E5WFkljIdpQEGOwxiYlDDHMDh73ILNWch5EuGaWLVwqbFr++yoTlVG3XCaUhcoa7c02RYKVt1oW3px22ulVvubI644dhdq6DwsxmXgVcKtb2oq7J2cGCFAghzmdClJDQE3U2QeV+LUTshtQKOnLneA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781167384; c=relaxed/simple;
	bh=6JGUhH6q3bMpa1vL0iSgqVTf/urDkVUesyEhhfFUxVU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZV89cmAe0+jpnJ/DSohiAhDjp5ddfTosIU1Omb9qfcMp5skBPcIUiLkNtFiAhyQfzo3pZd2jbjvofkOUKvlYpvQ4zjq9A4qAun4ZeTHbWy9aKLHQ2h08bCBv+phxs+pnPJg3BGGXeX2yXt8+c5gjxdrnjvExqVyl+VKhcJVe4vM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=So9dy1ba; arc=fail smtp.client-ip=40.93.195.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="So9dy1ba"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kNhCpuqFZz4pjmhVq3IJjb1GOKoCVUkDJk1Y71eN1kYGY5nITOU3vod1zwgiQ5Codo/UmO5wNterZpYbu0icz08TKlVZE0C6EFldvDrE/oX47T9MQWmB2ECaSCgLfGlHsVOivPm5mSohJvdVZO+aHoGq61NgKx3/JkwHhYf7UED8F52MaDLIlKFPtfYzaZeUXcUhZH7cL35q+6XZYu601DlCcMprnkLyRv7Eqq86q1jDS2uHxI0FdW2gEEUvJFQ2bBetTS60ylR/6afd2Kga27w74e7ICwplfoHrdo3GG09tSclpDiunU/GSpVTAWISzfDOCWDU0bNhe2wgM9SMxkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U2OBOTy5WdJP86DpM6CZPHp6nysNdiL1hSn03GVCNGQ=;
 b=K3wiuaJQ2DIVHtsLyfX4BCH7CRuT9ugKeDhW+cctaaLsdApi5CRkjolxH9gq1vph8CCDkj3j+dV3qlle0bV6E66bSMICEbhWzj4OYP8rYCPqgX1RoBMIkahLTsZ1KyXwQVKLoXvona32kHBihlpyXFvmo6G+jv2Av3P3l3NwNaIQvHPjex59T8nG270I868UGppZmGb17QMBgc3xgB8Coz9O/VlntlG1x9HdYfdLX+dRQ1WVD+oN89PYOpb9NTzj+JNM+LPTr7/JGVN/TvcoVM+//kD4lN1eBL7Z/kKbiSJDzFobxugj4ckheUk2CqfhJbvqlPHLeGQUTrRmynrPPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U2OBOTy5WdJP86DpM6CZPHp6nysNdiL1hSn03GVCNGQ=;
 b=So9dy1ba8sr+8xpoGuOmMDqPKiQV7CO7tactoCRuL+i/kO45l2VM6NZ8rUBP5qymyA6apFG4W0lQgDe2iSKhuIHobMkTSeXWVyF0w8gPUJhX8cCPMy9l8p/5sMzJY+644LqhDDphFlW9B0zIvc4XsEbgVjlAGz0Imv4Bf8PXan5oXTxLD58SXz5VE74AyKtHop+UJd9+pt8sv5uSOdF/pSwZ9jpgpnh1OICQEH+nmC7JDKR/rkFievjyqtvrILGrLqA69xDrjZ7hfPOiV69V4JglI9D5orqzh0pLURD/h9WWtAhAm+RfrIJHhAWcKOcp1HGUMtaOZaE/FDaCgX+14A==
Received: from PH0P220CA0003.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:d3::12)
 by LV8PR12MB9231.namprd12.prod.outlook.com (2603:10b6:408:192::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.11; Thu, 11 Jun
 2026 08:42:58 +0000
Received: from SN1PEPF0002BA4F.namprd03.prod.outlook.com
 (2603:10b6:510:d3:cafe::ad) by PH0P220CA0003.outlook.office365.com
 (2603:10b6:510:d3::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.11 via Frontend Transport; Thu,
 11 Jun 2026 08:42:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF0002BA4F.mail.protection.outlook.com (10.167.242.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Thu, 11 Jun 2026 08:42:57 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 11 Jun
 2026 01:42:39 -0700
Received: from NV-2Y5XW94.nvidia.com (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 11 Jun
 2026 01:42:37 -0700
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>
CC: <nicolinc@nvidia.com>, <jgg@ziepe.ca>, <joro@8bytes.org>,
	<will@kernel.org>, <robin.murphy@arm.com>, <nathanc@nvidia.com>,
	<mochs@nvidia.com>, <skolothumtho@nvidia.com>
Subject: [PATCH v2 2/2] iommu/tegra241-cmdqv: Fix CMD_SYNC use-after-free on teardown
Date: Thu, 11 Jun 2026 09:42:05 +0100
Message-ID: <20260611084205.686559-3-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260611084205.686559-1-skolothumtho@nvidia.com>
References: <20260611084205.686559-1-skolothumtho@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4F:EE_|LV8PR12MB9231:EE_
X-MS-Office365-Filtering-Correlation-Id: c1cf23f5-1109-4877-baff-08dec7956ffd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|23010399003|1800799024|36860700016|376014|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	p6ZPi2bxejFbXyFmW0Oj5rb4cmM19/2nl/EiUJk42EJh2IzSAnUt1+WGN+EgATbI+TXQ19hoYZotGAwx7vaPuV2MNZu8lrq5p/eojlAEKUVUNYcgFsGgzvUH02lKyD9oeQdrSrqpG2P7eH9XwbB2lQQMDq7ubaZigY1CAWjSosMz9GzAOlo6o63FpXJfs0poviyeaF7YnGWIHwPJvS8sYojFu/lDCB1FAMQgi6PvmnDQ9QEvsbUsyr1iEde+Rqwcd9XCl4pT4/6G/1X20Y8uOWluq6F0UrrGTHz++mDcDKWvc0sbvyWay/TYczQ4Wf4v1X80gaxrT8n24HVE+s0kB7h6GBjfmDbUGPcFhGz9EB/Fx1vhbNYrXQ+jA/0xdhO8xeEr1p5SdLXSL+I1iH7r53my2Sj292bTULEjYLLe/TivwdRSRJkGEJ1J+Etm4dB9K7SrEkw23ha4qQ60ld6EPkrAGL1UXL89e5UDPO2DASrtovD2oT17rRDcCLWxJuWn2CZReUsL2jDzUWja1wANg+K3lsiVmFtqBwRRMvRt1LxjpYfpfIzVUV6XMcBaIuvdIqpBvJ9+hpMb7EL0JEjX6tmg7XVWY+NHrvZ0bQwc20HYwgd8kqIudjpwYvFlMFdI4QCARZhDqGhI+saOxZM9w18O72qdab6QGetWEhoes31wF6N2tNirM4EzqoWie//HHdLx7QBDstSG2cVsNTHUw9AfzHuLVONPNBezryhU2ys=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(23010399003)(1800799024)(36860700016)(376014)(18002099003)(22082099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	6SHwr+B1JYc/34BEilgEfO44vmpeeb6lUssuzpWWZX6FUHDs3GiQDRCQ4zFzC+gedbK+hyCO/HkJyEZMy8XfchzMl45T8mPnba2z14CT3DDnsCTNPtcGBGCihaY92+2En5p/7YGLvN66fUrJBELB4ReGFgj2tzrv70YS2NrdqEfcnb8lRQt6BE9sRqYQ0PEgvvJzkVwhZXzkHwuZNJz0uM4zC2fqHBsA/HfTwOCv/m8IEv9lrlMGA6pyJ3vdhwzumq8aPkIPxuAZx9YH/gwgI8Hkf/ibv/BcO4aidfKbeXzohUQgLJBiOGms64BJSkfD8tlHJUheGghr4UmC5mKFyXBHoUMRK/1HSB9D+5qhLYe4sJo92RfdV3lrGbZXk/S1Tj4zjnCgEvd7nkFN0TUlcSUgG4CHlwu4D1gXZGgoWNzkjz8QtB4w4WPgg2H5frDN
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 08:42:57.4758
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c1cf23f5-1109-4877-baff-08dec7956ffd
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA4F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9231

arm_smmu_impl_remove() is registered as a devres action in
arm_smmu_impl_probe(), before arm_smmu_init_queues() allocates
smmu->cmdq.q.base. On a devres unwind, whether a failed probe or an
unbind, the queue is freed first and arm_smmu_impl_remove() then runs
tegra241_cmdqv_remove_vintf(), whose VINTF deinit issues a CMD_SYNC on
the freed memory.

Observed during testing with a QEMU hack that makes the VCMDQ fail to
enable, so the impl reset fails and probe aborts into the devres unwind:

 platform NVDA200C:00: tegra241_cmdqv: VINTF0: VCMDQ0/LVCMDQ0: failed to enable, STATUS=0x00000000
 platform NVDA200C:00: tegra241_cmdqv: VINTF0: VCMDQ0/LVCMDQ0: GERRORN=0x0, GERROR=0x4, CONS=0x0
 platform NVDA200C:00: tegra241_cmdqv: VINTF0: VCMDQ0/LVCMDQ0: uncleared error detected, resetting
 arm-smmu-v3 arm-smmu-v3.0.auto: failed to reset impl
 arm-smmu-v3 arm-smmu-v3.0.auto: probe with driver arm-smmu-v3 failed with error -110
 Unable to handle kernel paging request at virtual address ffff8000891e0098
 ...
 Internal error: Oops: 0000000096000047 [#1] SMP
 ...
 Call trace:
  arm_smmu_cmdq_issue_cmdlist+0x320/0x6fc (P)
  tegra241_vcmdq_hw_deinit+0x98/0x168
  tegra241_vintf_hw_deinit+0x5c/0x1b0
  tegra241_cmdqv_remove_vintf+0x34/0xec
  tegra241_cmdqv_remove+0x40/0x9c
  arm_smmu_impl_remove+0x20/0x30
  devm_action_release+0x14/0x20
  devres_release_all+0xa8/0x110
  device_unbind_cleanup+0x18/0x84
  really_probe+0x1f0/0x29c

Drop the VINTF deinit from tegra241_cmdqv_remove_vintf() so the unwind no
longer touches the freed queue. Quiesce the VINTFs earlier instead. Add a
device_disable() impl op and run it from arm_smmu_disable_action() while
the CMDQ is still up. That handles a live unbind. A failed reset is already
handled because tegra241_vintf_hw_init() deinits the VINTF on its own error
path. tegra241_cmdqv_remove_vintf() is also used by the iommufd viommu
destroy path, so quiesce there too.

Fixes: 4dc0d12474f9 ("iommu/tegra241-cmdqv: Add user-space use support")
Cc: stable@vger.kernel.org
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h    |  1 +
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c    |  6 +++++-
 drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c | 15 +++++++++++++--
 3 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index ef42df4753ec..690055aa63c7 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -804,6 +804,7 @@ struct arm_smmu_strtab_cfg {
 
 struct arm_smmu_impl_ops {
 	int (*device_reset)(struct arm_smmu_device *smmu);
+	void (*device_disable)(struct arm_smmu_device *smmu);
 	void (*device_remove)(struct arm_smmu_device *smmu);
 	int (*init_structures)(struct arm_smmu_device *smmu);
 	struct arm_smmu_cmdq *(*get_secondary_cmdq)(
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 00261e77e7bc..3d531af7e16c 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -4800,7 +4800,11 @@ static int arm_smmu_device_disable(struct arm_smmu_device *smmu)
 
 static void arm_smmu_disable_action(void *data)
 {
-	arm_smmu_device_disable(data);
+	struct arm_smmu_device *smmu = data;
+
+	if (smmu->impl_ops && smmu->impl_ops->device_disable)
+		smmu->impl_ops->device_disable(smmu);
+	arm_smmu_device_disable(smmu);
 }
 
 static void arm_smmu_write_strtab(struct arm_smmu_device *smmu)
diff --git a/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c b/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
index 83f6e9f6c51d..c7af7658a4ea 100644
--- a/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
+++ b/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
@@ -761,8 +761,6 @@ static void tegra241_cmdqv_remove_vintf(struct tegra241_cmdqv *cmdqv, u16 idx)
 	struct tegra241_vintf *vintf = cmdqv->vintfs[idx];
 	u16 lidx;
 
-	tegra241_vintf_hw_deinit(vintf);
-
 	/* Remove LVCMDQ resources */
 	for (lidx = 0; lidx < vintf->cmdqv->num_lvcmdqs_per_vintf; lidx++)
 		if (vintf->lvcmdqs[lidx])
@@ -779,6 +777,17 @@ static void tegra241_cmdqv_remove_vintf(struct tegra241_cmdqv *cmdqv, u16 idx)
 	}
 }
 
+static void tegra241_cmdqv_hw_disable(struct arm_smmu_device *smmu)
+{
+	struct tegra241_cmdqv *cmdqv =
+		container_of(smmu, struct tegra241_cmdqv, smmu);
+	u16 idx;
+
+	for (idx = 0; idx < cmdqv->num_vintfs; idx++)
+		if (cmdqv->vintfs[idx])
+			tegra241_vintf_hw_deinit(cmdqv->vintfs[idx]);
+}
+
 static void tegra241_cmdqv_remove(struct arm_smmu_device *smmu)
 {
 	struct tegra241_cmdqv *cmdqv =
@@ -844,6 +853,7 @@ static struct arm_smmu_impl_ops tegra241_cmdqv_impl_ops = {
 	/* For in-kernel use */
 	.get_secondary_cmdq = tegra241_cmdqv_get_cmdq,
 	.device_reset = tegra241_cmdqv_hw_reset,
+	.device_disable = tegra241_cmdqv_hw_disable,
 	.device_remove = tegra241_cmdqv_remove,
 	/* For user-space use */
 	.hw_info = tegra241_cmdqv_hw_info,
@@ -1152,6 +1162,7 @@ static void tegra241_cmdqv_destroy_vintf_user(struct iommufd_viommu *viommu)
 	if (vintf->mmap_offset)
 		iommufd_viommu_destroy_mmap(&vintf->vsmmu.core,
 					    vintf->mmap_offset);
+	tegra241_vintf_hw_deinit(vintf);
 	tegra241_cmdqv_remove_vintf(vintf->cmdqv, vintf->idx);
 }
 
-- 
2.43.0

