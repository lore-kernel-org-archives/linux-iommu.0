Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011045.outbound.protection.outlook.com [40.107.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C281213E02A
	for <iommu@lists.linux.dev>; Sat, 11 Jul 2026 00:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783731197; cv=fail; b=gOQ8Mq5PnO8zYykIl+qz0+NoFTyBDHkTGhTPc7pbxfBGk8iyTGpuMCtZFZd/ktqRTC5lREiafiSc2J9mHzvtrUBC412SCuRwQXdIPeGjffSU5B96B8yKvNom5UsDHchIGrI67xfcjKKI4xkYI+yxIx8TZxP7VQ4V5FmlMS1agnc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783731197; c=relaxed/simple;
	bh=P+pZQC64cGKYy/cVPOlSIaBW9UOlCSf8I4B4l80rtA8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZjXKGcKRtS2Bb2SSpFBZnCxeli4rZdoHbzwK8EzDxuVr2760n9zuh9BR5rMnqsOcHska2WWj/DdrC/m5pK5ZKALVrDTcpPFwN+S5kulVjVdvGYVHjTyOQvzoRyP0OQv5r0KarQj14vj8oAzjj8qFN1NzuG3HqpzJL77iLal6mtI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=c2cDPUEM; arc=fail smtp.client-ip=40.107.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="c2cDPUEM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kT+cG2A8HYFqbVnT/QCa3PFwpfctskKiOKLS2cL6EM0Npp1ArTiVxNq76RAMVu/c8SycmUMMeS4oCOD5ALblMiCyyo3/mUoVFAaI/N8J0/zkRPMDLCRNyUBtrETrIvcAaWqoZ/UFy1D1GLZYwxaEN1s24YIkQ1+OT3ULJoSJJxGLS5XUaRY2rqUQacuVItH3qbs0H7M9aSnW0DcWO5mYcCGUf2SYvLxDS9pXgyjGLEPtVS4Fdvzhuz4k92J01aFPdPhMlRWkVKYoP7O2fIXE7r84f2BqLTQskMXljcsNMt5T3F0nC1i996ErXqs20WnmDrTzRorKF3WlcYE5IPOZ9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XqlPOmLKfoaigQ8p6CnkhvohyvlRctFlhS/R+FhF9q4=;
 b=AG+//aH2LsGWYa/ILGBY05+HqOnvE1WWfg6j6+O2NdXtuXIhSU7z77ugR7qoflaBYN8XmDeoSOav9aoKexHUgYw9JL8q4cz7W/n+4Vr408DMJBn7zJL4kCal/Z0HKr+J0+ZG0eZsl8AhaC/i6mZQocnyJobeyHmKxY4223GpmpxYy1AFfW6IfuxzGaeu2tHHV3Z3ot2BEi4gmpjbtJS4YWt63d6jBXtnd//Rz6OAIgrdFpHxg8PfvVlO2AbxfWlDyedzqQjPVpgchmkjC1RdvX/aS5GKCNDQXaQ+AQC00kV7oHrW6ANERH7cCR2+9ZzJa8e2QeL9YfOaqc7uLul91w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XqlPOmLKfoaigQ8p6CnkhvohyvlRctFlhS/R+FhF9q4=;
 b=c2cDPUEM9FMzrcl+SSxcmt9LtH4ArF0m/1HpB58YY4+sei4t9DWIJN7+JKOir4FwkJV/AxiQAEAvuSeZb7BDi9xvfhBQ3Vtqcu/L8XwExYrcwzxJoeEtkQqkioirHk2nB2BsgTkRZVEE99bSl7/yQMxRnqSy4mg2TXeflKpo9GJhURTN2L7TV4r6j0E88TS+ZM9B336XIWVZTwBWEy0tzUe9bs5hhHsd4V6iEqICv31NEd1JEq0C/NDSUXBrwmbUcr4imoUl0R+s7E9oYMlgeL6GP11gep1MtI3Dti2dOorKQHjI4MO6GJeRmqNjz1ZCRXPQ1mO10clBKZeRS6ZKGA==
Received: from SJ0PR03CA0135.namprd03.prod.outlook.com (2603:10b6:a03:33c::20)
 by SA1PR12MB8858.namprd12.prod.outlook.com (2603:10b6:806:385::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Sat, 11 Jul
 2026 00:53:10 +0000
Received: from SJ1PEPF00001CE9.namprd03.prod.outlook.com
 (2603:10b6:a03:33c:cafe::5c) by SJ0PR03CA0135.outlook.office365.com
 (2603:10b6:a03:33c::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.10 via Frontend Transport; Sat,
 11 Jul 2026 00:53:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF00001CE9.mail.protection.outlook.com (10.167.242.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Sat, 11 Jul 2026 00:53:10 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 10 Jul
 2026 17:53:00 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 10 Jul
 2026 17:52:59 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Fri, 10 Jul 2026 17:52:58 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>, <robin.murphy@arm.com>, <jgg@nvidia.com>
CC: <joro@8bytes.org>, <praan@google.com>, <kevin.tian@intel.com>,
	<smostafa@google.com>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>, <jamien@nvidia.com>
Subject: [PATCH v8 4/9] iommu/arm-smmu-v3: Destroy vmid_map ida via devres
Date: Fri, 10 Jul 2026 17:52:45 -0700
Message-ID: <1b39e846b503635c43122033b8aaf89379af9a6f.1783729633.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1783729633.git.nicolinc@nvidia.com>
References: <cover.1783729633.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE9:EE_|SA1PR12MB8858:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b45b0c4-9e02-4d05-2652-08dedee6c791
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|23010399003|36860700016|82310400026|6133799003|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	wNsRuOL6fgLpwXzrciFdy3CPv7G/MWdhzrFxK49Q6fa80Lb7c4w+3Ag54l1c1mxqNj+4DfYghIZUxdAbviirmdOlvP+DwQJrdoCP+brGSj4nvSg0XMkCrpWpDBhgscUHYacecYHSVC3LA/ZVPsaTT7C84s7bp2rPyQdL/kBZrxnjdS0K04yREJDTU+WZlWLBWREvuf8USOGnN5xot1VK9BrGFOEsiXAnvak5z4ZpcXIhlSz16SzyJ89nAO47Acvai0fC1d+3aF6t9fx/uG4WL6Iz7iswjCfgwXKJlXtPb5G9KE/RB2BVZf9Tm/ZQ6q0zTV0yRDJMRIm8GXCmjHOikN2JWCSUoTtKlDJbDzVVEgTYAge+OPsTNrnw7UKgpV5aquX39uK46oRLihtzhNrCoGYYmuKPxy+yGnNeK+IJ+6AYYisrinch1t9bSWooZtokcUUoBgIuW5G2IIBSB6MjkSOgqDs/aXIrLzirouyoCEGyhoz2SHaRPQfUt6Wn1HDS+SqwZdNJyNj/UQlohGweNc8BaZvMndyS/5z4jr2ZRAD3iAqfGnMT+xsCd5jwGp/030Eqo90pOHyzvwABxXrJZZzo8DPVQuKQ9vmtEl6+AbS1EdHjXREWudVrA2j9oHakucMAfpOGcmvbgieOWG8knLtiqIQnWdijs2SlQfgAXVaDY4+Rew6kHU7yXVhk0ZyvUngQp4zxJpDtQouAcaFRUw==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(36860700016)(82310400026)(6133799003)(18002099003)(22082099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	GEzr1kUs1P1jhj6IElF+nUlJyhOzNug3Dx92XZFX4KuGXDDXNlyQUOkgRUk6OfqddLmoM2FR0t8/4kUwQqcfSFYmuu41J6dt681SgdXdcE1ZaEshUGTVisFnvHVXR/yzV2rJ1P7QgL3cGQanSxNhTZfeTbgfFhBPhtaicFfEJUUn+cbarXGvj95RPWtmafxNk23MJYW36VA/G9Vz5uY6nvZqJCjWjFJvL7IDp8b7LE00KPefcinD+bg+3jA7oOy3S7/lN3sumNgIjEVk1gpvy4ymzjY7XUj1xn4KkC0zqM2kgEwI0ERA0ijULHltIXWcGUDip9N4iP369ruqQvPcA+kD+zpCsm0l9B1fRDUZkzZ2JX3KQvDPDJAq9W22WLUAN0xSiKYbgcbwvE6hcjR1QqWPcEtSlHOdDEK/jaadDeG676iGQKTE8WVltO9zlP26
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2026 00:53:10.4815
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b45b0c4-9e02-4d05-2652-08dedee6c791
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8858

The vmid_map ida is only destroyed in arm_smmu_device_remove(), which does
not run when the probe fails. This is currently harmless, as the ida stays
empty until the first S2 domain allocation, which can only happen after a
successful probe.

An upcoming change will start reserving the crashed kernel's VMIDs in this
ida, at the probe time of a kdump kernel. A probe failure would then leak
the ida's internal allocations.

Register a devres action right after ida_init(), making devres the single
owner that covers both the unbind and probe failure paths.

Assisted-by: Claude:claude-fable-5
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index a1a91b6635129..2fb28eb2b8895 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -4505,6 +4505,13 @@ static int arm_smmu_init_strtab_linear(struct arm_smmu_device *smmu)
 	return 0;
 }
 
+static void arm_smmu_deinit_strtab(void *data)
+{
+	struct arm_smmu_device *smmu = data;
+
+	ida_destroy(&smmu->vmid_map);
+}
+
 static int arm_smmu_init_strtab(struct arm_smmu_device *smmu)
 {
 	int ret;
@@ -4523,7 +4530,8 @@ static int arm_smmu_init_strtab(struct arm_smmu_device *smmu)
 out:
 	ida_init(&smmu->vmid_map);
 
-	return 0;
+	return devm_add_action_or_reset(smmu->dev, arm_smmu_deinit_strtab,
+					smmu);
 }
 
 static int arm_smmu_init_structures(struct arm_smmu_device *smmu)
@@ -5564,7 +5572,6 @@ static void arm_smmu_device_remove(struct platform_device *pdev)
 	iommu_device_sysfs_remove(&smmu->iommu);
 	arm_smmu_device_disable(smmu);
 	iopf_queue_free(smmu->evtq.iopf);
-	ida_destroy(&smmu->vmid_map);
 }
 
 static void arm_smmu_device_shutdown(struct platform_device *pdev)
-- 
2.43.0

