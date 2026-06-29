Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010025.outbound.protection.outlook.com [52.101.85.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B70D23FAE08
	for <iommu@lists.linux.dev>; Mon, 29 Jun 2026 09:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782726115; cv=fail; b=aTm6CToVbe2aFW8nQRdu5JJwKtE4SrTkHp4grYwruF6okJKGWd6RZKHlpPF5M8iQuSthpAzhYHAvfNDeWNoGsCyA9IE4iWvJad5rCEqRc2TzzxMnU3PeNqOOG3jk0oxIF7m27xscOI2NECsfwTPMPy6Eqt4qJsMgMRsITJI9bSk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782726115; c=relaxed/simple;
	bh=/e9MGNS0tKiLnqpk17NxqPqoMlYX6zWMfXynF4NFFx4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KOyJ0ZbMLX4tqzCrc+v415NsAIU409cWMtpAlGhjJlilD7cajQSFw67cqaZqqzl+HsyiQRYLeetzimMlhB8j8+fyK7Xybhj0WoL7DnT7Spl30afr7bIvbNR/yBbIYLmBiOnkVtq42pBJ1MGM+8xJrs1d7lU7Nx27mD14edoCM6I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DTsc0QtV; arc=fail smtp.client-ip=52.101.85.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DTsc0QtV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n4PHfl3cp9JcXDNHRP7eoKba7rvNMP3fftaP9lVhUAguAQ85TlwB7oMKd1PqS9X7it7xFSYDHCiu3EL3FDX12UT+di0ybY5ZwgtH4xqt4Lium3dND0xFHmeD7Qy0eA3S6gwFWAcbrlJqyYKLaxieV+JA92ht0U2DsCuW9ZblNLEpuHRK7JKBJRSdIxAhgldbHuxsoboCSioXg9yfMDYnV8j6r4kDeJkxef0fXnwrJJVPqqPrFRQYaTCDphacWoA7Sb/rRey2Z2cd9BsJcHhw1fCEx1Ijo4elVdPrrxCeNptbiMyaUqr5hF2mtP50+Q5hxldoSBHpiuQ7u6LKp2d9Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vGTT9sMXkPo88prq/5sP6quUrDr23NLN2DRafyxsPes=;
 b=jBskIZM4Jh3HW/ruy4maEJb9m5Vr8QzS1blc3/MZiP065VQDoW/e9mIojUrrk4EYxT87Yio4s0vTYDsaKtQBVXjU7ERavmMZg/Py1ea8IQpmcASqXG7JF9ZeR9ePYb0xxdWs8V+RaZXQoP9YUV4CeeyJlA+SkwIMSk7LCL7a4RlXWsYuSHdl0aguAE9Yej7GvGsF50xX4q15opc3oJDLbgLCUNCArwBSrho5atx7FeIwmGmv5H5SklL65V9g+UBB2LAdkAmp4YYMD/7qjFVxpM+Jjrv2VpeEIU6sUpHOqPXY+jetaRQlnTTWnCSBJYCX0fTTNkR36pvL5wOMgpHhkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vGTT9sMXkPo88prq/5sP6quUrDr23NLN2DRafyxsPes=;
 b=DTsc0QtVWUxW8Yv0BwGELsQI6kRDcuVFuhos1wbelXMkMW6oxKCa7uKExfwNN2ZUPMDwj1D+KlrUAHfRsyB0ov/Zt5/MPjbjHyB80+fUHw/r2Tm0N0QOFHZjnEZlCcoCu3yxCdaz5X+bdctYNXbHiandPQSimCfNwDwdLKNi5IKHyEezR01hGPPt651V/klKJFwvcQk0jMuSUCTIKWD3NHS7+UFLllS0lNZYmfzA7Ug9b+x03iRF0TsyPK/R05baJWm4e2K5tYyLTFJs3Az+tVJ8xRCJWV2+yl9+u3wnjXbPLuCHHZJoFda1uekhP4LqNs7qBsy6hNESCXD3FzCxbw==
Received: from MW4PR03CA0257.namprd03.prod.outlook.com (2603:10b6:303:b4::22)
 by DM6PR12MB4300.namprd12.prod.outlook.com (2603:10b6:5:21a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Mon, 29 Jun
 2026 09:41:48 +0000
Received: from SJ1PEPF00001CE8.namprd03.prod.outlook.com
 (2603:10b6:303:b4:cafe::6d) by MW4PR03CA0257.outlook.office365.com
 (2603:10b6:303:b4::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.19 via Frontend Transport; Mon,
 29 Jun 2026 09:41:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF00001CE8.mail.protection.outlook.com (10.167.242.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Mon, 29 Jun 2026 09:41:47 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 29 Jun
 2026 02:41:36 -0700
Received: from NV-2Y5XW94.nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 29 Jun
 2026 02:41:32 -0700
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>
CC: <nicolinc@nvidia.com>, <jgg@ziepe.ca>, <joro@8bytes.org>,
	<will@kernel.org>, <robin.murphy@arm.com>, <nathanc@nvidia.com>,
	<mochs@nvidia.com>, <skolothumtho@nvidia.com>
Subject: [PATCH v3 1/2] iommu/arm-smmu-v3: Manage teardown with devm
Date: Mon, 29 Jun 2026 10:41:05 +0100
Message-ID: <20260629094106.251694-2-skolothumtho@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE8:EE_|DM6PR12MB4300:EE_
X-MS-Office365-Filtering-Correlation-Id: 86083eea-eed6-45fd-be8b-08ded5c2a39b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|376014|23010399003|1800799024|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	fOsy2kSwTcYLZC3ei+8jAfhJF9Rnb/r7EU/mq1Nalh5+so9NsqAeuGqUCcej+65wPJNCaVZPexPxq/1bcFFBsc80jzILXSySpOhqPbTw6XjPL53wY5K4cn5TCie+Osb2Sd7N5KCHxEMGv35w9wum6fcFQ5pe5yU3RrLSHm+ZBk9jXX0IZfd2R7Q6xFonNLxN0BTV6OsbjCZ1dUBSDNBdxpDI3UR0JHwTZm8JuVrqPonusZK+ZtCe8yEH41CRaILqwnO9qLzgWXiRr+l1oY7YOb46ZdWQPXkdZAIYRnsVgUslYeva7kHGHBO6B77G86qHzrcv7ldcQAzHy90FA9+BLb5eEsr4ZYUACygMD9KejqcSVaR1rBlbE6MFBARJIHxA0klY5zuiurGJqINtNj0g/MdT7helebj6m7N9dFKZFuiTfooMW5DHisl/hSexESMpiBCgEg+Ah1mAbSkBe1asZY/qP+ROHU9bV3vC4YUHzGoMFpN0wz4DSFEkRVYGScXDYq9RQ/SULIwPNmBVY/fgTW6i0JUk1xEMqnqN/KE0fZCDGQWyHNZcu6Vlne+LUidgu6ZBuu0v2x9wtdvKiPAQEXN11e7czXYqYqxLB4a+sI4+leqiVcl6j+jiaYjYYdvNgj4PX6DijOL7LXJ/M6xpI+GH8sZgM3pfv8apVeQzRcDMesulQrBXpbkZe5JX6+ApcovWdBor3cCwjHu0rF/cxQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(376014)(23010399003)(1800799024)(18002099003)(22082099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	OklCVtSmj8+iRPBxob+zB1VO3yiOSvdR4zmlElqhZptIfd49ZrsVzBdPkEHwmMAyTyXabIMHjx/NV96vOdog0vlQ3VdP8vUuJOoy7TyemoNK9t+tSOTQiXuwvbFsHPKghNMERKtL29yqkErtxq7WP8UGnm1rNchRpt8ea5SohMe0dVB7cqSgposg+Awkc2uBMYhkXkwkQ31bF3NJQOPh5VwxGvkxZscly/egegHM4mnoT4qz5NJWhyBIfAOyVuK4cAzHV7MjU2z5IbExq9ZcF9WJOGCo6lZAhEXkJIpk4QLOr+aKVv7MmgQ5Zu5LPYorXGz1RPFwwtah0XpJ6MvvJcMYTHp+fLvvJHQQtHZKFfMgtvaXUhn+En6d1YGj7c5/ViNtaY0BnkGieQZqdnlKcxfyjTlH1lpY3Qi4vJt6RopGsmjpNaf3VV2LXIz9lgvT
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 09:41:47.6768
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 86083eea-eed6-45fd-be8b-08ded5c2a39b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4300

arm_smmu_device_remove() manually frees the IOPF queue, destroys the
vmid_map and disables the device, while the IRQs and queues are devm
managed. devm unwinds only after remove() returns, so the cleanup runs
in the wrong order. The IOPF queue is freed before the event-queue IRQ
whose handler uses it.

Manage all of it with devm so the unwind order is correct. Free the IOPF
queue and vmid_map via devm actions, and disable the device from one
registered after arm_smmu_device_reset().

This is also a prerequisite for fixing a Tegra241 CMDQV CMD_SYNC
use-after-free in the subsequent patch.

Cc: stable@vger.kernel.org
Suggested-by: Jason Gunthorpe <jgg@ziepe.ca>
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 56 +++++++++++++++------
 1 file changed, 40 insertions(+), 16 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index a10affb483a4..8f366671bce7 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -4398,6 +4398,20 @@ int arm_smmu_cmdq_init(struct arm_smmu_device *smmu,
 	return 0;
 }
 
+static void arm_smmu_free_iopf_action(void *data)
+{
+	struct iopf_queue *queue = data;
+
+	iopf_queue_free(queue);
+}
+
+static void arm_smmu_destroy_vmid_map(void *data)
+{
+	struct ida *ida = data;
+
+	ida_destroy(ida);
+}
+
 static int arm_smmu_init_queues(struct arm_smmu_device *smmu)
 {
 	int ret;
@@ -4425,6 +4439,11 @@ static int arm_smmu_init_queues(struct arm_smmu_device *smmu)
 		smmu->evtq.iopf = iopf_queue_alloc(dev_name(smmu->dev));
 		if (!smmu->evtq.iopf)
 			return -ENOMEM;
+		ret = devm_add_action_or_reset(smmu->dev,
+					       arm_smmu_free_iopf_action,
+					       smmu->evtq.iopf);
+		if (ret)
+			return ret;
 	}
 
 	/* priq */
@@ -4503,7 +4522,8 @@ static int arm_smmu_init_strtab(struct arm_smmu_device *smmu)
 
 	ida_init(&smmu->vmid_map);
 
-	return 0;
+	return devm_add_action_or_reset(smmu->dev, arm_smmu_destroy_vmid_map,
+					&smmu->vmid_map);
 }
 
 static int arm_smmu_init_structures(struct arm_smmu_device *smmu)
@@ -4716,6 +4736,13 @@ static int arm_smmu_device_disable(struct arm_smmu_device *smmu)
 	return ret;
 }
 
+static void arm_smmu_disable_action(void *data)
+{
+	struct arm_smmu_device *smmu = data;
+
+	arm_smmu_device_disable(smmu);
+}
+
 static void arm_smmu_write_strtab(struct arm_smmu_device *smmu)
 {
 	struct arm_smmu_strtab_cfg *cfg = &smmu->strtab_cfg;
@@ -5472,7 +5499,7 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
 	/* Initialise in-memory data structures */
 	ret = arm_smmu_init_structures(smmu);
 	if (ret)
-		goto err_free_iopf;
+		return ret;
 
 	/* Record our private device structure */
 	platform_set_drvdata(pdev, smmu);
@@ -5482,30 +5509,30 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
 
 	/* Reset the device */
 	ret = arm_smmu_device_reset(smmu);
+	if (ret) {
+		arm_smmu_device_disable(smmu);
+		return ret;
+	}
+
+	/* Register last so it unwinds first, while the CMDQ is still up. */
+	ret = devm_add_action_or_reset(smmu->dev, arm_smmu_disable_action, smmu);
 	if (ret)
-		goto err_disable;
+		return ret;
 
 	/* And we're up. Go go go! */
 	ret = iommu_device_sysfs_add(&smmu->iommu, dev, NULL,
 				     "smmu3.%pa", &ioaddr);
 	if (ret)
-		goto err_disable;
+		return ret;
 
 	ret = iommu_device_register(&smmu->iommu, &arm_smmu_ops, dev);
 	if (ret) {
 		dev_err(dev, "Failed to register iommu\n");
-		goto err_free_sysfs;
+		iommu_device_sysfs_remove(&smmu->iommu);
+		return ret;
 	}
 
 	return 0;
-
-err_free_sysfs:
-	iommu_device_sysfs_remove(&smmu->iommu);
-err_disable:
-	arm_smmu_device_disable(smmu);
-err_free_iopf:
-	iopf_queue_free(smmu->evtq.iopf);
-	return ret;
 }
 
 static void arm_smmu_device_remove(struct platform_device *pdev)
@@ -5514,9 +5541,6 @@ static void arm_smmu_device_remove(struct platform_device *pdev)
 
 	iommu_device_unregister(&smmu->iommu);
 	iommu_device_sysfs_remove(&smmu->iommu);
-	arm_smmu_device_disable(smmu);
-	iopf_queue_free(smmu->evtq.iopf);
-	ida_destroy(&smmu->vmid_map);
 }
 
 static void arm_smmu_device_shutdown(struct platform_device *pdev)
-- 
2.43.0

