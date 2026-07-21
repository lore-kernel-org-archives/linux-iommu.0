Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012057.outbound.protection.outlook.com [40.107.200.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 662C547012B
	for <iommu@lists.linux.dev>; Tue, 21 Jul 2026 19:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784663349; cv=fail; b=d/ejeEENXuY9wtetsV/jzYSbHSUwmvMX+TQcocQcJfoaTEHgXEsFv24Au0CNMWb5Qm+S/GhszJ0HWHmEV+/td8Q2MKIpT6BlDxhR8d21OKbvY9QtfCy8EiajyPUF9YfHy/i15AhepImQBhz0EXIMpGGCebiZxyajJJgJDsVd9go=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784663349; c=relaxed/simple;
	bh=OfH0bJaeZr+vpC/haNdJ8CMxCKin7cRkMjNZHM9YOTM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c2B7dQhNHDyy+KC+yh335C+Zmx4zAxZ1acdZiFgMsHeAJNu2goUl+TTJqn0uLEZ3uvTQ0kHzI5VfQy+eDF4ZtKjVmqgR+JJT+EmTlQlv3goupM48l8IB8RfoO/k6anIVHjqaGu+MfjqR4qGcfsD1cTXSl2Rsv2LpdNIBE9CQ8VM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=i34/m4mD; arc=fail smtp.client-ip=40.107.200.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="i34/m4mD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lt6ycrO9XOz9jZJgMafzkWR1Lo7g/lcRXso1Vox4RxSm/V+6V3YdeUeGfS4QNWEiLQ/mLLIG3/WV+fcPKXcGjzuZB5KXIZxyy7Z5Al90+iyFDPfkeateZvn7B20sReyEk+tSuhtJ1yAd77YXweWWfBnk1+sWQQ7CjkXOb6jdL370HKFDZ9vrxSBoaDl3g9rqZ6dKJJGPF3N1JxiCyeE8xibzMHN3y1TOC25XKEwv/P6BgaE7Dgj3MHungCiEHvIhq4cgeJ+M85CADpOq8HPXlLoa/Rc2w6sGQ7wP6sWqr3Qr5BjfC0juNVUfKaNFvmFJjXLAGwd1X8U90qnLUSbnsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bb2AuwMR956f2t0mR3cpc+t14D0NTx5BpcAZd2a4/Ig=;
 b=FPxFUpWOCmF0adxBEpD16MPv1JrhL+gouDurY2P/tDs09oFI6FsNPGN0eniIe8wQLzfo+EMmkBqkgV89FE9d2xcUw9WD58XMer/99PsfNEJhhtpCrlvvc+JPsGA0WBzTH6xP7jL6cAsM1gr28huEQSEC7JVGZJvCrqMWrAOS2D/hqDOzV7UA9NJB2O3zINujzS/7d6vvb/L5xct7lZpDxQEDMODRq7AngkruWWb6eVG5waOszUhnU+l5y7aIfadTkvwUaCrbut5k2FpN1FqnLNPIShoWh3hR75QiZVCvshqcGMxjm+Zc0nsIFXqiExwbJVwsBnE0cO2FRJUvFpL4cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bb2AuwMR956f2t0mR3cpc+t14D0NTx5BpcAZd2a4/Ig=;
 b=i34/m4mDdmFZcbEuhEuZ1njJ1lj+qr57A3dBK231WL9CwAxihbcwurLYBeaQ+17jy5i5OXkZycy4dtmFn4FR2CRsdH2cXo+gv8QpKuLdmUkJH3ZUq8u5kTd0dFmZq5E7ZM9JVB/HYMeUFcMcx612BccShm/bMJWoHbdA6j0uckYYxMobhJpP3Qp4Lc7sjbW9shP29xAB3qPFF5S/Q90lxKpcE5dhT6ahOXBdWPOC5EP103acMPumzynYIkiISOM+SoLYmpjB7WkbIm0pX6tEOTePC4FbxvukzDX4CSrFXOgeWyTnrUOJKY+5FcB9fvmKhXnhoT9wHsnO0K3gtcgZsg==
Received: from PH8P222CA0003.NAMP222.PROD.OUTLOOK.COM (2603:10b6:510:2d7::18)
 by IA1PR12MB6388.namprd12.prod.outlook.com (2603:10b6:208:388::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Tue, 21 Jul
 2026 19:49:02 +0000
Received: from SJ1PEPF000023D3.namprd21.prod.outlook.com
 (2603:10b6:510:2d7:cafe::f) by PH8P222CA0003.outlook.office365.com
 (2603:10b6:510:2d7::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.10 via Frontend Transport; Tue,
 21 Jul 2026 19:49:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF000023D3.mail.protection.outlook.com (10.167.244.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.0 via Frontend Transport; Tue, 21 Jul 2026 19:49:01 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 21 Jul
 2026 12:48:39 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 21 Jul
 2026 12:48:38 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Tue, 21 Jul 2026 12:48:38 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>, <robin.murphy@arm.com>, <jgg@nvidia.com>
CC: <joro@8bytes.org>, <praan@google.com>, <kevin.tian@intel.com>,
	<smostafa@google.com>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>, <jamien@nvidia.com>
Subject: [PATCH v9 04/12] iommu/arm-smmu-v3: Destroy vmid_map ida via devres
Date: Tue, 21 Jul 2026 12:48:13 -0700
Message-ID: <8b0978c9376f20519a7b827e7e0789dfd86e3b14.1784663184.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1784663183.git.nicolinc@nvidia.com>
References: <cover.1784663183.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D3:EE_|IA1PR12MB6388:EE_
X-MS-Office365-Filtering-Correlation-Id: 648a7565-b25b-4599-81e8-08dee7611d01
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|82310400026|36860700016|1800799024|6133799003|11063799006|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	7a6D1sUHxJdqsEKhkyqOMiTmqWkyeSqByJFboy6dClZZgBk1lIy94QsKIWThr1VGVrbWlxtFWZiqh0AWPqWJXA7JXHCTC8qBZx7M73Lr6cy8kuf4jZO4QoQzQYgleGTxDwVGQnL80kcgbK9deD/3AH7sggRdMHAKihtAyMoUsW7xfk16EWWqfvQ7ZQtc4fyH9BDg2su2Bww9QQ46h9JM7RHuGBxmbZu+PlqdFrQa/kO1GcaAIvbzeyuq47/xmKm9RI1u+utddf7H7YqHJ4X93aChiTWuIWzWylyK/bO4W9GId8F7bZLxJwppEg0ctTPxX1AhQ2HWlL4+klPtildLbo3lDDjZHrAlS+sJaTVp1nz1wKcizVXquhw+J49Ucazky/uhwvlJsWU7PP6dDGvvjWZsRby9pnFrOCCZXlAn9d9kyIK348EmNVZGl+6VSs87/b9kdSJ/OlaaazacjJ6A3dnIC72FQr2g+ihUtxhoMFdIGuHoq9LxEMN3jaDltcGeHO3LHTc2PhJb4S65NgH5BBMbt4wra5OB0Ga4iwgtPKlOzw0cnYnc/TaDfpA6Q9fKNF8Eil6F3FSIB6h2Fm/P05yb/+xEpFjaxSKwoo7xzZJST3uK8foe5j/l/epLZLzgimxVIXxhNrvlpfniyYUoOJ7Jg7OdtYMSYLlJ+NkilKn8QsEQuYkMBqkeHXc4eT4AgXyEZXDKVLEaATeabxXIOA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(376014)(82310400026)(36860700016)(1800799024)(6133799003)(11063799006)(56012099006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	m9vTzeeGXHUcywcKJkbvxt5j2bQLDSp3Y7X5NaZxY/Ufm5lJE+BZqr4y+uyjtKRPSN78eCEVsPFJtTmJeGyHBnvRN8CNFjmEVR4czYMAmYNxtZG0WMSe10V4lbX2HgyPASGLSPPSdEf51vKTE+QnDymz18oWE6Bvn8nMIr9LxRypb7vr6TJrEKT7QM8G2V7wLZasM4zT0G7oqyUFpDeKJiE+kHlfiejcdkOEY+upCMqvZcGseERex/Jph4+4StYLU8eUVqfpQpX+xNluK6xskqLQFFVLM397YRf82kd9l3W3aBEaREwhAqu46nvDBSIlDLr4A8Gw4AAO225sd3PvvSGauajDvWT9+8g3pyOgYyVXFixpSypxEoeYaHLienkqFVvUcjHwrV3ZPDTTxJaNSZUOim2+QAu017E0+2SFytU6ct8y46CWnKIn8YD+yfAb
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2026 19:49:01.6338
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 648a7565-b25b-4599-81e8-08dee7611d01
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D3.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6388

The vmid_map ida is only destroyed in arm_smmu_device_remove(), which does
not run when the probe fails. This is currently harmless, as the ida stays
empty until the first S2 domain allocation, which can only happen after a
successful probe.

An upcoming change will start reserving the crashed kernel's VMIDs in this
ida, at the probe time of a kdump kernel. A probe failure would then leak
the ida's internal allocations.

Register a devres action right after ida_init(), making devres the single
owner that covers both the unbind and probe failure paths. Also, move the
ida_init() call to the entry of arm_smmu_init_strtab(), as the reservation
will run in the adoption path prior to the regular stream table setup.

Assisted-by: Claude:claude-fable-5
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 132bee5fbb1d1..0df6c17a53173 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -4494,20 +4494,27 @@ static int arm_smmu_init_strtab_linear(struct arm_smmu_device *smmu)
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
 
+	ida_init(&smmu->vmid_map);
+	ret = devm_add_action_or_reset(smmu->dev, arm_smmu_deinit_strtab, smmu);
+	if (ret)
+		return ret;
+
 	if (smmu->features & ARM_SMMU_FEAT_2_LVL_STRTAB)
 		ret = arm_smmu_init_strtab_2lvl(smmu);
 	else
 		ret = arm_smmu_init_strtab_linear(smmu);
-	if (ret)
-		return ret;
-
-	ida_init(&smmu->vmid_map);
-
-	return 0;
+	return ret;
 }
 
 static int arm_smmu_init_structures(struct arm_smmu_device *smmu)
@@ -5548,7 +5555,6 @@ static void arm_smmu_device_remove(struct platform_device *pdev)
 	iommu_device_sysfs_remove(&smmu->iommu);
 	arm_smmu_device_disable(smmu);
 	iopf_queue_free(smmu->evtq.iopf);
-	ida_destroy(&smmu->vmid_map);
 }
 
 static void arm_smmu_device_shutdown(struct platform_device *pdev)
-- 
2.43.0

