Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013024.outbound.protection.outlook.com [40.93.196.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A6E321B191
	for <iommu@lists.linux.dev>; Fri, 13 Mar 2026 00:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773362234; cv=fail; b=Xzyt+ruTFb49Gk58BIeEpDZln33N3DCmvAUsKMkfhCuCSdEK+Lam3g3/hdpu8omqDuH4Dho8HN7QH+Ei9oV9010Rj4psPeeILCzGW4r85mqG6SVxKQK0crBnR5B/Pz0pBbd3BYttWKnotWDO3P6a6xQlY8D2WISFAUcDkuMFljY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773362234; c=relaxed/simple;
	bh=vfeTs7OV8JXQrchaXieZdEbh4paA7i674e5phP8O4ZY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Em4BuY2u9Ix5K7wJ0nUt7bV1xQStRyA+U9A/jdP5JsLshXF2IEnVN9MTXOUlK+L8gkjIHYptuO06PeOYEMJIuTq6BqOllz/BKRyE76oG0LMENVQQU9GqZ8APB3YhWrTi2wxhs0IQ6sGbeF+xahYk6D0sZ36MXi144Ona3h9ZbyA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KuLFYFEK; arc=fail smtp.client-ip=40.93.196.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KuLFYFEK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C6TGxqyAd53vsPo/yMAooWtmdA+ng/dhrwn9EWqIs3b7++HuelVgRGCwVZxr8kdmSgsJ+Bn6/dZ1jciGXE/w0hRC6UIQVFYwWCBKYHXdAP+VurIwKmxst0kdnmKeP+sqjxIT8ps7B8Scc6FV/QwQI2EPths0NMlGqrSGA48ZQj8aGOTQzLTO5aFZiScg8B+pByGYx5jvu4UY5OqcZqH5e8aYDriBJGFamh1L/8qV1KwuauMlieRvCgPKAJXr+tfVSXIchg4F8/WmLRPk0zT7PJxm51c5JtoZTYYvSQWh8p1V/cOX5PuX4A61mJ8Mow3P1yJfVki++2uEA2bmsQ/tiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0ks8Owyrm6qtebHGX0dBncA/682LgIj0vWjj8F/wqiY=;
 b=Wug6dOJx/RMeclqW1BGnd0cj1CL453vQds/p1FpBorG2q6OmXiw0YbIIbq7RWtZl8r9eAAGTqtMQ4L4M201T0zqsZLui8ElcvJQWO/o54bfnrUpkZBpKPkof3MwMXM5RVS7erpUXkar4WVDwerP06aMcx0b5YR29CVUsf6XRIRWIfeX80z4+Fd8hPnJrurvKr5iejH6fSi0ukoAjxyx/xfi0Yb4YwNPZEfNvWpX83lm6PgqTL5wVukWNOgisstSKYG+w95UUHu7C8eXgksBgGsdQiCI9aQ8ta3fTy2J7Mp/9wVw2T/yIkFWULBubVuESlUPW0LmORXSMJH1UO2WHeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0ks8Owyrm6qtebHGX0dBncA/682LgIj0vWjj8F/wqiY=;
 b=KuLFYFEK9Rh3wO3elOifMzBAEZfegoNIXWujFXyShhvidbu5dvwt5RrqQlvKXxGwIeTZIFodCwgy2nP8WIE0F1N+w3kMaUec1iu9TyPfMaVkWxEMe4p+aBhiiT8C/RWoLN7iaISJwcMAolQqqXUZnd6qnif5mYet5Ag0yM3PPzrsn1X8LAJ8uhKlXULpM1Xn6FtAPGIGhrE44ts6ZOYzOrLZT2rcotqF4lVPjGjrMgrBDovFKjzoikV+zDcCXV+IB2Ep7MjFB4bEf30BVLeX+ZPuU7pblvmXJ/9ZxDeKGdn0QzdztKi4t+Uxc03njbmlL786a6EdvjDbtLbMDdLCvg==
Received: from BYAPR08CA0017.namprd08.prod.outlook.com (2603:10b6:a03:100::30)
 by DM4PR12MB6423.namprd12.prod.outlook.com (2603:10b6:8:bd::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.6; Fri, 13 Mar 2026 00:37:04 +0000
Received: from MWH0EPF000C618B.namprd02.prod.outlook.com
 (2603:10b6:a03:100:cafe::47) by BYAPR08CA0017.outlook.office365.com
 (2603:10b6:a03:100::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.30 via Frontend Transport; Fri,
 13 Mar 2026 00:37:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 MWH0EPF000C618B.mail.protection.outlook.com (10.167.249.123) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Fri, 13 Mar 2026 00:37:04 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 12 Mar
 2026 17:36:53 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 12 Mar 2026 17:36:53 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Thu, 12 Mar 2026 17:36:52 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>, <robin.murphy@arm.com>, <jgg@nvidia.com>,
	<kevin.tian@intel.com>
CC: <joro@8bytes.org>, <linux-tegra@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <eric.auger@redhat.com>,
	<skolothumtho@nvidia.com>
Subject: [PATCH 1/2] iommu/tegra241-cmdqv: Set supports_cmd op in tegra241_vcmdq_hw_init()
Date: Thu, 12 Mar 2026 17:36:34 -0700
Message-ID: <7988aa837f02e44c0f436bb236cba0573bd8974f.1773361875.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1773361875.git.nicolinc@nvidia.com>
References: <cover.1773361875.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000C618B:EE_|DM4PR12MB6423:EE_
X-MS-Office365-Filtering-Correlation-Id: 44eaf889-769c-44fa-4904-08de8098a60d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700016|376014|13003099007|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	4iY7WwdjNrX2LpwSrccKGjQAjnezApDRZW3rlkya95aRaQt+WpESC6NNZdTQb4gfViAgVomjY4No0BJi30+vM4fPNAZaRZo80tJMQ2SBlwGCh+Esa9Dk6YImi3zCgcQeY9E9eaY/yfAq88jYgwVQwD6YMCK2QWeGFQ7lH59PI2PRcuY/qSJbSRZLkdrBauC5JVdJ48ec4xSQFIiSx6d0eCLPNsxcVYGKbIT533H9v7yoZ/z18wFjLvVmpMVeVjZHA3T6An4hrBHKJJ8sSXeERdVIJb4uYxzDTAag6stgmF4ssrwalYNREDSzicc3yX3JytvPQJ9uIdQl+TOMGLpLYalAK7TiVvICxsXgPOIMUAsIsR8a29rO41EwCLlVS8jF+rY38F6X8qYIwrzziAdU/M8eRcHOX+16xDqqcVart5HZlB8F8nbA8kvMTgqoQV/1vjiC159kmS+3PsK15jEbNeMlozErs2kE6bjpHEEDHRfjBTWQeNGFrZ1ZiulYHw4M4HY0F+ai4qbigY7bAfzO2lxZOzfpV19L3Chi6ypQUfwprPVSzuw/Gav6rKFM1+ZBvlPNJ7WKS99Ad4tQ09Mm7ERutK2yE+qDbiPas2CNR9a/QSmv2KYf9M0TnCRkdqYldxoH9WFYsPb/9u89Nof+uneK9Jjfk+d/BYL+jYWNbfmeBu0N88S1RP8uHKkRsqmh1yPuJmjlcB1qvbaLM6+kDzVbBElpxroPyq2VdrdIQDMm2vTUcukjomz9hq6gYauLBDc6tXxIAdjksy8ZX9FR3A==
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(13003099007)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	o5Y3A3ZcgAYWtI0cRE2ilbYV9xzstAL9r2aDcqifTictQI0AaPzpi268ASiEI5xHHeLahny6F04ip153RJybMronoN6dLHMJY7Rm/TD6FjiQPJxY3fSDPaaGLb5NxKL3SKId1RsdIaLgAkXuZKcksjfv+7m54+2lIrtv9y5va/oKugLYGkADLSaEdQ4ivAGo5oFcCncsD0G5a6hlzk7E0dUL/Peu24n4Pfith7RplWMLtLvAL8Lx3DcmNCOYDjSCQxWHZ0nMnlcVVeUY+7WoaZtiL9srD4ESOH2LApLhswbHMCE3JEld1DOFkWlfLKe56d1O7mTh0/TpcY9v/k9DH5F1AWC81RFvykCX7wXKgbtZ298aO06mKM2uh1ePfbz6BSlcHfEahskAOBCIbNBZoAjNxuh7m+f6U8vii9uVGRaQX1dyPBnuBOmjgklIzfKn
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2026 00:37:04.1437
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 44eaf889-769c-44fa-4904-08de8098a60d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000C618B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6423

vintf->hyp_own is finalized in tegra241_vintf_hw_init(). On the other hand,
tegra241_vcmdq_alloc_smmu_cmdq() is called via an init_structures callback,
which is earlier than tegra241_vintf_hw_init().

This results in the supports_cmd op always being set to the guest function,
although this doesn't break any functionality nor have some noticeable perf
impact since non-invalidation commands are not issued in the perf sensitive
context.

Fix this by moving supports_cmd to tegra241_vcmdq_hw_init().

After this change,
 - For a guest kernel, this will be a status quo
 - For a host kernel, non-invalidation commands will be issued to VCMDQ(s)

Fixes: a9d40285bdef ("iommu/tegra241-cmdqv: Limit CMDs for VCMDQs of a guest owned VINTF")
Reported-by: Eric Auger <eric.auger@redhat.com>
Reported-by: Shameer Kolothum <skolothumtho@nvidia.com>
Closes: https://lore.kernel.org/qemu-devel/CH3PR12MB754836BEE54E39B30C7210C0AB44A@CH3PR12MB7548.namprd12.prod.outlook.com/
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c b/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
index 6fe5563eaf9eb..83f6e9f6c51d6 100644
--- a/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
+++ b/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
@@ -479,6 +479,10 @@ static int tegra241_vcmdq_hw_init(struct tegra241_vcmdq *vcmdq)
 	/* Reset VCMDQ */
 	tegra241_vcmdq_hw_deinit(vcmdq);
 
+	/* vintf->hyp_own is a HW state finalized in tegra241_vintf_hw_init() */
+	if (!vcmdq->vintf->hyp_own)
+		vcmdq->cmdq.supports_cmd = tegra241_guest_vcmdq_supports_cmd;
+
 	/* Configure and enable VCMDQ */
 	writeq_relaxed(vcmdq->cmdq.q.q_base, REG_VCMDQ_PAGE1(vcmdq, BASE));
 
@@ -639,9 +643,6 @@ static int tegra241_vcmdq_alloc_smmu_cmdq(struct tegra241_vcmdq *vcmdq)
 	q->q_base = q->base_dma & VCMDQ_ADDR;
 	q->q_base |= FIELD_PREP(VCMDQ_LOG2SIZE, q->llq.max_n_shift);
 
-	if (!vcmdq->vintf->hyp_own)
-		cmdq->supports_cmd = tegra241_guest_vcmdq_supports_cmd;
-
 	return arm_smmu_cmdq_init(smmu, cmdq);
 }
 
-- 
2.43.0

