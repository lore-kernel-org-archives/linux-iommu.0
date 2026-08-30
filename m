Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010011.outbound.protection.outlook.com [52.101.193.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D838A356742
	for <iommu@lists.linux.dev>; Sun, 30 Aug 2026 23:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788131947; cv=fail; b=KGs5xVWwp6TmHS4TMbRU8upig8kSUdh6q1meLq6bFUg3Prj4ILTEbfLC2VzQkoS6jr3wdXOA+lRvB0n8QOKANfwiBAJbf+jqE12OBV4Cjl1eueG3JPJ6qzvuc+mHlxSaLf53x22CZbWh4OJFLdbqhbrqzHwFjmAP/fFsoT6CacQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788131947; c=relaxed/simple;
	bh=lumxcTUtIo61GkMW5/RYHHhxiAa88lf7VHmj0pub1zQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FcsfKTrrXyUIpRbX0r2lFTquU/Py6zy65Qii6kHJp/hDPf7/NI0akosoBOfjgss2OlL5d8/vzplThPRcWH5AWsmHeqQKOH7keorrDOnlOgzym4jMNWt2/TPZIbo5EGCaAGApgvckgy+mEss0Nk3ypCjYRlwkx3rUiOlwimrNWdo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JFkKJ7/H; arc=fail smtp.client-ip=52.101.193.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JFkKJ7/H"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ATDpgBbO3kDrHMSPv3XTvOFgAUNCaEP3iVnv0W1/4MlES3Oi0wjAEEEuKgtouWmvpL73Ny8nIyEmpQudN9nuljh3cXBvpAgtVGjeM2sATWRIqSD3kaY2aRC1rFXOqiqjRsTeZzjwZoJSWSaIlVfFWsO4nTc/o9/3pnjcNuPnPA7UUd04mg6njIaspoD+dG+PQQS4Y/r6QS6GaalBQgDeEPl2aU0koYhV/U27BwmUuszwvQuJ/bUw//ZPTNBbza5+6xxwzzl7t4LY6BofWG+sZ8tKj3qlX53vRm1dQ5+P1e6WJ0lX7wvrHx/hsGG0H56PaGHx+DWLAlkA25tqodz5pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b+p3ugqrpbrw/apqvopQiBd5maPgPyZGkv6exgah+Us=;
 b=QMOAAfWmiQsaFk486Y++zgqH7jJTZK6G6UV8m3TAn2VBitOHj4p198V/DFC0Tyf3Wac7BIQLyY69bWXdDyyQ9u/udpApsrnX5vCxH8hcftHotqpS2qX1XkEHSJsO2PaW6SM+h3fOWvMBXh1YNi96EMxpksUHNNqmo3KPR34ircoEWI63plr/tUcxi1HT5yUIXwuR4WzENP/8O3RHqe8tzUNQLcqUs5+6PlbSdcK41T9LzeycZT2/Nr0/hFQgeld60dyGrN89QyOmacY1zwxCOmzDlsmuPDFLJw+bt9A3InSR8Z9P/RhxPmU9dYyNQeR87iIOsJbTaImurxVK6PfQeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b+p3ugqrpbrw/apqvopQiBd5maPgPyZGkv6exgah+Us=;
 b=JFkKJ7/HxeELqABRIizyfQO6kfdQog3N32dLDSHQpl7IxrmVyIjCGWZqSg7Zcm9NMTbIrNnFBrEw9vABd4MeMqzyNk+qJqsWE5Fx2I1YrtQGw2jAFYXnN09gtyBNt1dQUiufw1Vl+SedVdFqeiUhOoVqFoJrMTMsZVA4z+Jh7+mksnPkIjzZOsjMPOfBy3eKN0sHSenZQX0xXLIl13eb8Y92ld9A5kEGk6Yaqd8hf7vjlqA4dqsuZPakMGIViVloBzeJIvl+20bnyCjzQmj/clyuovWjb6za/2eTQRw+xMBgKR1G2O7sguK8YoqFovyRkY4ZgrqBYAtlQOi5Wd/vmA==
Received: from CH0PR04CA0106.namprd04.prod.outlook.com (2603:10b6:610:75::21)
 by PH7PR12MB6465.namprd12.prod.outlook.com (2603:10b6:510:1f7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Sun, 30 Aug
 2026 23:18:49 +0000
Received: from DS3PEPF0000C37E.namprd04.prod.outlook.com
 (2603:10b6:610:75:cafe::36) by CH0PR04CA0106.outlook.office365.com
 (2603:10b6:610:75::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.13 via Frontend Transport; Sun,
 30 Aug 2026 23:18:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 DS3PEPF0000C37E.mail.protection.outlook.com (10.167.23.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Sun, 30 Aug 2026 23:18:48 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Sun, 30 Aug
 2026 16:18:39 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Sun, 30 Aug 2026 16:18:39 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Sun, 30 Aug 2026 16:18:38 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>, <robin.murphy@arm.com>, <jgg@nvidia.com>
CC: <joro@8bytes.org>, <praan@google.com>, <kevin.tian@intel.com>,
	<smostafa@google.com>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>, <jamien@nvidia.com>,
	<kas@kernel.org>
Subject: [PATCH v10 09/13] iommu/arm-smmu-v3-kdump: Reserve crashed kernel's ASIDs and VMIDs
Date: Sun, 30 Aug 2026 16:18:10 -0700
Message-ID: <81ff0f09a965029f97f27b56670c69ad5511b2d5.1788130528.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1788130528.git.nicolinc@nvidia.com>
References: <cover.1788130528.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37E:EE_|PH7PR12MB6465:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f96cac8-632e-4eb4-fae9-08df06ed0be6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|23010399003|82310400026|7416014|376014|1800799024|6133799003|18002099003|22082099003|3023799007|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info:
	4d+8/tFi+ButiwXV31gosK0e8zEqCbF1V+RTqdiLSsFGH0jtTOspoo2CSNnNdGtGlHBMRpmGMq26sCY7vJhi1NYIClxwNzaCZ8HTRFgzx4ZfyS3fVM44Iy3GIgcEHfSeNd9oRDmUmdoHS5cZF3aXYNl7HZ4q05lsaqrkxCkdUpXYTQoh5qNb3deRUJOHaETrOfk3A1UlwgA2+2jfOblL6VPJfke+S0Bf4oRW3lhlbF9YVn8xJdKevpgyMg0z/qnBf84cyMXk66yx3+GD3rqL/6CdH8r2y+amCbXImoUaNhlu7b2ABP/Yk7R/ODh5qZE7Z8EclILhR8wuDTP1A9KbGdWovIAkEQvje0TsPL9hUy0wy7f+EILPV5DpREt7i9E1HzJ8oJ/7mPc3Grh6yIH5m6zHF/m/txuMN6z2zUaRq/x6QXDzzB88UDQvynOcV9wkAYAEUIL2x4GcfuH+8cXUULOe5mULp0JdW1v6cthQhil1mMCt76vjYxiEJzCJbXoGfchBcwh6EfmPDtJNwZ3MkR+DR3oAYrazDNSYNzBfoeqSxxAjQq7+A/KNByLZNzbe9YI95VGvR6HlMJbGL7OyV8X7gGG2GD/qilc8JuZ/vQlU5TPPqn96NlpUzJ4Xs3YNWvvw/3wOxKVKv3iSZI4nUsEACQnu9vnZg69q2ka+HvwyNqONomY6bw7Hey8jvT3sJs1Ip7igof9z5z24pl2AKQ==
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(82310400026)(7416014)(376014)(1800799024)(6133799003)(18002099003)(22082099003)(3023799007)(56012099006)(11063799006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	oVfAh5qqkbrZ5kVRtddOxg4V+8QGXohOmoWLg3xoRcYRp0rNM4EgLvYrCniHm31y2s80Z4XEFz/rJ9bpV5BkX/HkQ2PN8NLJWujMbjbp5rFNt+spcFk3l5KNcnjmOzOwP4pwwRbTpXDSDimSjcv9hjHp72qXxWO6CD2RSI6K/Ic6240vzkJvLM92Ycin54TqBRJ604SYDUaDQ147V1TFpnBtfinSnJDIU6UKUjI+A5q0afbYPfGUs7zlJ39OahHv0q+0Oin/Gbabo3jJZoxT/0LFD8dROq/+WUc7TsUzQVl9uQ5ByINPkls2Uwf/FR1dmT8a25x6p2mIu+A3YIRhtBCoJM8o3Pb/Ge9XQKtE9ybkbAzi0eLTa3ppWzqZrdmT2EQ55pVCBNSEqltPqVAk5tX1W5njX0qY9WorQRmA8CiYP14HXBbYqX8IetFqC3QX
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2026 23:18:48.5152
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f96cac8-632e-4eb4-fae9-08df06ed0be6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF0000C37E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6465

The adopted stream table keeps translating in-flight DMA, so the SMMU keeps
caching TLB entries tagged with the crashed kernel's ASIDs and VMIDs. If
this kernel handed one of those IDs to its own domain, the new domain's DMA
could hit the crashed kernel's cached translations, e.g. a stale entry left
behind by an invalidation that the crash cut short.

Scan the adopted stream table at adoption time, reserving every ID in use
via arm_smmu_kexec_scan_and_resv_ids(), and roll all of them back through
arm_smmu_kexec_unresv_ids() should the scan fail.

A nested STE's guest-owned CD table is left alone, since its ASIDs live in
a space of their own under that STE's VMID. Reserving that VMID covers all
of them, so there is no reason for the scan to walk the (VMID, ASID) pairs
behind it. The only ASIDs needing a reservation are those in the space that
this kernel uses for its own domains.

Note that, on an E2H/VHE host, the kernel's stage-1 domains are tagged by
the EL2 ASID, and the TLBI_EL2_* commands take no VMID. So isolating this
kernel by a reserved VMID alone would not work. Reserving the ASIDs covers
both the E2H and the NSEL1 cases.

Reservations are never released: a kdump kernel reboots after it saves the
vmcore, and the full-reset fallback flushes the entire TLB, which turns any
stale reservation into a merely unused ID.

If the scan finds any inconsistent structure, toss the entire adoption and
fall back to the full reset.

Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Assisted-by: Claude:claude-fable-5
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-kdump.c | 12 +++++++++++-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c       |  1 +
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-kdump.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-kdump.c
index a074d59ce3445..6740cc7e671cb 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-kdump.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-kdump.c
@@ -205,16 +205,26 @@ int arm_smmu_kdump_adopt_strtab(struct arm_smmu_device *smmu)
 		goto err;
 	}
 
+	ret = arm_smmu_kexec_scan_and_resv_ids(smmu);
+	if (ret) {
+		dev_warn(smmu->dev, "failed to reserve in-use ASIDs/VMIDs\n");
+		arm_smmu_kdump_adopt_cleanup(smmu);
+		goto err_unresv;
+	}
+
 	ret = devm_add_action_or_reset(smmu->dev, arm_smmu_kdump_adopt_cleanup,
 				       smmu);
 	/* devm_add_action_or_reset ran the cleanup upon failure */
 	if (ret) {
 		dev_warn(smmu->dev, "failed to set up cleanup action\n");
-		goto err;
+		goto err_unresv;
 	}
 
 	return 0;
 
+err_unresv:
+	/* The full reset will flush the entire TLB, so release everything */
+	arm_smmu_kexec_unresv_ids(smmu);
 err:
 	dev_warn(smmu->dev, "falling back to full reset\n");
 	/*
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 971b12517941f..1d4fb6c4f0a91 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -4610,6 +4610,7 @@ static int arm_smmu_init_strtab(struct arm_smmu_device *smmu)
 {
 	int ret;
 
+	/* Init both first, as a kdump adoption reserves in-use ASIDs/VMIDs */
 	ida_init(&smmu->vmid_map);
 	ret = devm_add_action_or_reset(smmu->dev, arm_smmu_destroy_vmid_map,
 				       &smmu->vmid_map);
-- 
2.43.0

