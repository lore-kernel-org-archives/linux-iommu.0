Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012042.outbound.protection.outlook.com [52.101.53.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E55853783CC
	for <iommu@lists.linux.dev>; Mon, 29 Jun 2026 09:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782726125; cv=fail; b=BUBcZTil+JpIbgRgosj32Re9Wckg910qSb/Gq9SZCK/e60RWCgvGMFaTLtj3z5NfWlGM+Za8LCINP4Az2mwHdZQycutAj278SDzLceD0UpIU+ZNsXXIU172p8vjDPhb+5+3NbSf2GHwMQs7NJHH9mX5ZaLZIyvG63aNQDigJcec=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782726125; c=relaxed/simple;
	bh=umOmicy0eM9u1b/T7ilal402Jz1gKlKQMQI9XCmydDQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CVVXEFU+wNdF440td+AUsW8BwhZuGEnaPv7g9FfY9/QXiJispXXoyPT3IpobtIsZsK9i6lIp4NfPZEBZxoGQobL7EHRgL0KB60N67gg8ujpEhFtI8voRAKxB6Jfuod4CbRLpuOOQMnMud+Y+4izrL1EfE+jzxnCyKrHx/1/A0vE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Vs3aTESy; arc=fail smtp.client-ip=52.101.53.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Vs3aTESy"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xe8Bz+uB8yTk6+vHv/OQfv6XOwmrAoEWGCQyfV4N3gcWMNY73KvqJbUCzJZrxu0QLmbqq7ow/soaXjU6IW9LUJsV3CK+n4yFpTyVruWF6mGsNYFqW0HrupZpmfmTmKpRMobyQfGt+NeFKbd1DahvKk5PtjwbsxAemVkhI5l2J6l6oMW+jxEXPSFvPa6RXxUhKxxZuI3a8fZ8nwK0P2tuEB0LBb0CL0P/zvx2X7+RhqcfijQn4gidePBOfq+TUp7aNCJ3QyVRSkpjwgNp8Ojy9cAppECh94K9oaDOBZyUXuYD3klzYEGTOebnlGQ8HaILqQZv2pB76fTZaK8wFa9HTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kvjuFyGA3loFQTiSD+RwGq2Sk/TpKKWdrDEMMqCrc1I=;
 b=UcEIf4UVzQ2Ekgo1zTrMsNEEzgjzR1fvraRYIoKLHzKM6uRDao4+a+pe4DOOCibZcykWG48LIHrAdJ22Jf6WeLKkcttIbp/FLRvW1kCsZFOQg1yMACUAppnferAM/WKH1TWM6aTdmAzjMrzrIVt93sA6Y20Xr9YDqRJa8b+qs4HNdYtqZHL6vkt4guv+PwxURSEiR/HI75l6jWXoBr0CE2DCrok1+H0TbR+XaAuTRRMnXUE3xgWEFekUFyW1mFphLq7u6Q4R9WZ7/w75ysZAPTuuUBpQ+0yDK78dFOu+syFhnXVaP9IvXtbrtChhFxwWwfqihbMNk+wRHiG20RUSGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kvjuFyGA3loFQTiSD+RwGq2Sk/TpKKWdrDEMMqCrc1I=;
 b=Vs3aTESy1I2DAzx04CNI/mpNHYUv6fnF3fCEH8iZdcvcGr4DRKYdRywwFsP/p7dwvVmLSR/iFy6Tvrai8TdJ363qn5zDfQISAI1liZwAr/gJ8jKLAD9Sw6ud4+NyqWj/5j9WhvgZMmFS2Rw2vvYXLlLAyiZyeCVpxDsUjpmXvp/Ymwe2FTod7ZaCj1s7xDjhXN2XAeaUe//w5EnPePwj8BJzT2cOv7FMG1oVGci7Y437sH/AZOe5hHHRR4Lg+FquIaFOEMRzt7TI3V4jfiP2WTkIv/4w3W3z2MjhGYFDHZg5nqaOsx2AEwrr8nFDJYFhZm3Fk0RRqwaa4ufosGr/GQ==
Received: from MW4PR03CA0266.namprd03.prod.outlook.com (2603:10b6:303:b4::31)
 by EAYPR12MB999157.namprd12.prod.outlook.com (2603:10b6:303:2bf::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Mon, 29 Jun
 2026 09:41:57 +0000
Received: from SJ1PEPF00001CE8.namprd03.prod.outlook.com
 (2603:10b6:303:b4:cafe::65) by MW4PR03CA0266.outlook.office365.com
 (2603:10b6:303:b4::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.19 via Frontend Transport; Mon,
 29 Jun 2026 09:41:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF00001CE8.mail.protection.outlook.com (10.167.242.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Mon, 29 Jun 2026 09:41:57 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 29 Jun
 2026 02:41:40 -0700
Received: from NV-2Y5XW94.nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 29 Jun
 2026 02:41:37 -0700
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>
CC: <nicolinc@nvidia.com>, <jgg@ziepe.ca>, <joro@8bytes.org>,
	<will@kernel.org>, <robin.murphy@arm.com>, <nathanc@nvidia.com>,
	<mochs@nvidia.com>, <skolothumtho@nvidia.com>
Subject: [PATCH v3 2/2] iommu/tegra241-cmdqv: Fix CMD_SYNC use-after-free on teardown
Date: Mon, 29 Jun 2026 10:41:06 +0100
Message-ID: <20260629094106.251694-3-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260629094106.251694-1-skolothumtho@nvidia.com>
References: <20260629094106.251694-1-skolothumtho@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE8:EE_|EAYPR12MB999157:EE_
X-MS-Office365-Filtering-Correlation-Id: 6dee5643-4244-4906-c9f0-08ded5c2a96b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700016|82310400026|1800799024|23010399003|11063799006|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	tS74KIfyWB+lh7Y0OX0vGfxCyPASxyv7YvgoTthayCXXNkaUvsvpflma7r2KYeYcZDlBqKjWnA7wk4IRoWJZo6RAia/sDJbjXGL1By25fYOiwFKLI3ZUQhL9gT9f9dFfoVAlPfWnwEIaAMlCxpkCj/Neha9RtIPck6kXRiCdAEZ5BpVmotPtfo40pn9fMFJ8nrfc9Z48nslQcvV2IRBurfTyVnelZDTc5VRi4419qkcgnfySkZkbczmJPq0R/o2eSDdAbTSEmy0p01py4EAhzlzXULocuU99ZwcMHZa9XTKqn1ndBvBkxhgLgtA+HAmLFhil/4wUZBp1kOhDdbYSehhhz9KTePvvQ20Vbu3TAURQdB3qywO6BHh2NUd8+OFp1L5ychU/hj17yfFRiyDMIC1Kyg7UEdZhbw5eptIlOlfQvr4N54qr1E74aYnvPky0ciWZKfQPjI6at2vyg+vugScVUWBArG37TnT8QTZZbc9/y6wHB71yCOoGBJ2AmWwFMJ4UzVCqZNgkXB5aHmCjFzzaWBAuxMDen7eQGxLzDLHhCULkWeuxHvuOkCR0UGtkbdwRnFA0b03zVdJXy9WgyvAnDUkz03eysLy8B1/RPeja7p4IZS4GNLSTLD/Gv9C7vqkXcSsdDYQrRgLoclMSb9z3tTYTvG5Ljqrzci0CBv219auJGfxATby3XOvUnpp8XS0rcDEzcEVGHZZMfo/AxQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700016)(82310400026)(1800799024)(23010399003)(11063799006)(18002099003)(22082099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	922d4TRnzLvp1xvfBDmxqhL0r/qe8MvhkCoWzKSV1AihPeLg+3h17ZP32OQNcPAKKrTZSvTlcNDGtgFFh5AmpF++Uz8Uz6LNXCwRyh7IsTHnWwnn05w4I72XU7zuyGoWqhSP7FtR2aVyZF3wAVD5gNuqSwig5XDGKaMh+2VcEkplG7WjqF7/6rGG17Q+VnvGRkL2il+tImPzM9MiOileUsjXEdzYiWfVPwpnxQhZC3I1sk3GlhGIgAR8JO1U828MM3Jj5qXTTuD0d5KbrFu49Axe8geLupaSPnxKlT5fVRCuP97alMKEnouNr3uXAo1bVIJL6J4PVsN/g01SXERs4LvWqq+a5VQYN/EIlbB7h8T3lqtazmLN5I3aR2QxACM8KpzUFe6tUVyIJ4Cg8lihs6srYJ+dQVie+JNQ6K2fdcbUIFPMuvMII+OFUH+W3gGM
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 09:41:57.4612
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dee5643-4244-4906-c9f0-08ded5c2a96b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: EAYPR12MB999157

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
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h    |  1 +
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c    |  2 ++
 drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c | 15 +++++++++++++--
 3 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index c909c9a88538..1c4877ada1ee 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -871,6 +871,7 @@ struct arm_smmu_strtab_cfg {
 
 struct arm_smmu_impl_ops {
 	int (*device_reset)(struct arm_smmu_device *smmu);
+	void (*device_disable)(struct arm_smmu_device *smmu);
 	void (*device_remove)(struct arm_smmu_device *smmu);
 	int (*init_structures)(struct arm_smmu_device *smmu);
 	struct arm_smmu_cmdq *(*get_secondary_cmdq)(
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 8f366671bce7..f44911d310ad 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -4740,6 +4740,8 @@ static void arm_smmu_disable_action(void *data)
 {
 	struct arm_smmu_device *smmu = data;
 
+	if (smmu->impl_ops && smmu->impl_ops->device_disable)
+		smmu->impl_ops->device_disable(smmu);
 	arm_smmu_device_disable(smmu);
 }
 
diff --git a/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c b/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
index 67be62a6e764..aaf9ce38bd93 100644
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

