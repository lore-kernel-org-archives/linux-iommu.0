Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011063.outbound.protection.outlook.com [52.101.57.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 261E93F105B
	for <iommu@lists.linux.dev>; Sun, 30 Aug 2026 23:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788131925; cv=fail; b=Ri7x2pxEc3odPUld6vCzPoiAnLYpUE2xma5x/njHY1CXgdHZQPajAMdBgTT/VganXnepxHnUYwb9vc2HOrRmylLd2oKk1T0JpvGDKKfx+C8DT9uy2Y5NEWu+OfcLaXjG7ZEsuuZpKVnSssbtJszGHcBGwTYFJH1Zb6Bszy8Fyt8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788131925; c=relaxed/simple;
	bh=kcxIC+DJAB57QCifJp0owrwIj7aizYlVJnIwxGrwZPc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dK3yzgVXhDplSwOHItDtI8MA82/zj0H5m9ZTmyGeJXERV7YlJl4wiztASGFLHM4owZLHWx2Z50ICi/p8RRXphdiknnLGwq7OiB8TelQOFTWy/cASyWmGebGIXfFozNaicfOaGWWvP/F+TdmsghMfrk5+DlB/NLBclbQD3MQFBmc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OPH4yiKE; arc=fail smtp.client-ip=52.101.57.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OPH4yiKE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PA6PADGLfIAp0iFGUhJTgn18Y0jWsGarAQlqPd+RbopB8k4O9n2WY/2lcL3j4EKhDABkVm96twWKH9xMmqT3wzfTKQAlm0RTstiEwgDy3ffwGD1gf43sjG2hBWZEAO5K1p1QlWfZDFIMr6KW97FzoAHywlVkBUCFTzAJA2E/uVyRlzD9aTAJBvRU0gmtkAxMWJMN5+Xe1QAOPNo8gMs38f8KW7pyClnSj5k+rg7wW7Jf29V6m+CZ3QzUCCNMlCSiC3Q8qTecvLwjb40PBZTSXYaeV4XlzM/vNSXXD5gavz2DsTcNhYVGplZY4fvEVE/59O9mEBCtmYa123e7AntHzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FC6wpuQkuxCa0+S4ogNQxq5GvOJLiZEuCdy9xA6PMMs=;
 b=VgsuzZ14sDqa5O+eUesq8pUTlf5oydYyV5AgJOc8BUytY8b/LI1Pwi2IaGtJ8erHuiPf68j7ya4rSUBsJOHzlB4xMw7paEwxGrS65mB07tJ4686xgRzG67vEIzj8B7As3dAbgWGS47G1vXrBQHR9lUJxzSUw/ToLme8cec8UmgwvlXFdavMC/VUcJs5K5GBY8GuWlR4flq/WhrnLynxlX+XE33OtZPtLPDFK7PGWnzI5lCUqxP9+3cAh+8ZFGmfKzAn7rWOcAEjEmKlkEa8exvfuIk+57SiNWGwZuT9chJyxidNoRx1ThMkXfGRcstWbsJAonSVEZpR9Bm92nEDGyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FC6wpuQkuxCa0+S4ogNQxq5GvOJLiZEuCdy9xA6PMMs=;
 b=OPH4yiKE4MlXUbDLrnm6PuDHwEjKVNwHlVPNeQnMhdBHJzXshPBr63XWf3PDpntaxYgUiBWpfOEakEAPN3rfOwuY5rEfHxPuI2wtUyINqCBvE6OkN8zD/obpfEiVtQo8EFMae1LAgv2GHSwpuWcgt60/AGbQi2EIG+HifUHg3g4fIysk9XRNRGAdr5fpNuZ47hCw6GqBj5vMAq2erNPDXU+NPkJKy/51uUIarUdhtqhiCyNtiCw+4F9a2vfCFCVcNWa0Rh6hgHiAAYxny/oAvQhHWpWXhwPNqA6NuZq/ak8UCQ6Sv1uL9iU0MypsmdjjoqWcJiOzPnEYej9D9BBGvg==
Received: from BN0PR04CA0038.namprd04.prod.outlook.com (2603:10b6:408:e8::13)
 by CY5PR12MB6252.namprd12.prod.outlook.com (2603:10b6:930:20::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Sun, 30 Aug
 2026 23:18:38 +0000
Received: from BN3PEPF00022BD8.namprd03.prod.outlook.com
 (2603:10b6:408:e8:cafe::7e) by BN0PR04CA0038.outlook.office365.com
 (2603:10b6:408:e8::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.13 via Frontend Transport; Sun,
 30 Aug 2026 23:18:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN3PEPF00022BD8.mail.protection.outlook.com (10.167.248.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Sun, 30 Aug 2026 23:18:37 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Sun, 30 Aug
 2026 16:18:33 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Sun, 30 Aug 2026 16:18:33 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Sun, 30 Aug 2026 16:18:32 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>, <robin.murphy@arm.com>, <jgg@nvidia.com>
CC: <joro@8bytes.org>, <praan@google.com>, <kevin.tian@intel.com>,
	<smostafa@google.com>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>, <jamien@nvidia.com>,
	<kas@kernel.org>
Subject: [PATCH v10 02/13] iommu/arm-smmu-v3: Make the ASID space per SMMU instance
Date: Sun, 30 Aug 2026 16:18:03 -0700
Message-ID: <782e24224c916ad0f48de1a49c139e71c8db0ef2.1788130528.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF00022BD8:EE_|CY5PR12MB6252:EE_
X-MS-Office365-Filtering-Correlation-Id: 956e7294-5a08-42d3-f1f5-08df06ed0589
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|1800799024|23010399003|36860700016|6133799003|18002099003|22082099003|56012099006|5023799004|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info:
	HP9vc3x0UXEMNXYiprF/eEa2tkuHTzDg6O/aYYLMLKN/HbIZ2Hzuy/rXGqms4mcecUZxSvW1E7mvvGR/srW+gh5mYzCEtU+D+iejGLlNUl2VARxUG3QhOd4xlbNz7YJ4hZMcfEREElx+fAB3xrSJir/4ZKuc2v8xEey4gI9OUakgXQjcZSJ/LEjsbc8P6BgvCZn5PJVPeZBLZB3BS4HYC5afEW9JvJHE1wuzhlrUw2QtSwvElhw4sHoN9dsohsLxWH4JqLUPhacDMtiXIxoFIC9CKdc5nezv+lepwhlOANyCuZS4ml/Isn5lHbzTSriaYC6wxm0hTGe8dACAT26aoFnm1CDfmtRC7YSXE3ykMqN2+IhPopNHXf90VINACBe8Q7iTGRdjVZBa2uW15dHTYt5pUbksNJ2r59u51FAneVBZLoAOk6DNFT+Bm/7FBK6FvNkptekODMx3RKEZWtSRQza0NnN/dZ034lS19isYuOmXs1LezC9LOxzOGNiIL0/HAdKNoQzrITkVbNWQ9JH8ZvdAxFru9TuUin8sBU1HUfMz5qt4QUA7VyTR6AH+yupSycC4nBZQwjCZZcpdPLib68dUuvZsMVr0ZW3Y5A+ZItGM+em4ZzFxK3mnbxFNTN6QryqqmzkanTPgVMdXjPibeV+XeVUyTDzx+OjvftUCKKxnnkCaTaHyWzI4fDy7GPvMVbZ88LwGXs+/3eKe7yoI1g==
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(1800799024)(23010399003)(36860700016)(6133799003)(18002099003)(22082099003)(56012099006)(5023799004)(11063799006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	vZ9EmWM9IQgV3h8nqeazKesfekyoaqJ2eB2zC7aoz78ws9vEg8UwzNG8II2wcvNIxCLmdioQoQRB+td8npJmpSDq4nWcZaxbt8+rZF/spiOmB6F2TrIYRCLzBZNzRBkaBnPFP67DotHagyQQ3BAG5ypf+VwC4cjhLOjOXoiVCQhjGMIf+/lMnVv3sFDJ2f+0Q/xF5JN14AHKe4nrGoUNThviVMrAVh1QWwJXbbjtfYBLYDUTDgM6KvvpPu46hXAJ9K2iJLZHPa1KveU1Ol+SWZP274aSbiWy0vkf8eVC8qhlXzy4k8bJUz4J9Fsvp2IYDPzR7hFGn2pwJRlUDeerqIbCfFG/ajwXi4CMFHHMkdsKXB9sKQhdaX56YpIjAFj2ioJRlQLu1CG3QD4WTuOCTOIuX85zZJIQn/qkRQbjepWr+DxHRlmHcL4sF+lwfzS8
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2026 23:18:37.8063
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 956e7294-5a08-42d3-f1f5-08df06ed0589
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF00022BD8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6252

An ASID tags the TLB entries within one SMMU, so two instances can use the
same ASID without ever aliasing each other. Yet the driver allocates them
out of a single global xarray, which makes the instances share a space that
the hardware keeps apart, and lets one instance exhaust the IDs of another.

That global space is a leftover from the BTM support that shared ASIDs with
the CPU. Now ARM_SMMU_FEAT_BTM is never set, nothing looks a domain up by
its ASID, and a domain is pinned to one SMMU at the attach.

Give each SMMU its own asid_map, mirroring the per-SMMU vmid_map, and clean
it up with devres, so that both of the ID maps get the same lifetime as the
SMMU device structure that holds them. An upcoming change will need this,
to reserve the crashed kernel's in-use ASIDs in the new map during a kdump
kernel's stream table adoption.

Note that arm_smmu_asid_lock stays global, as it serializes the STE and CD
updates against any ASID change rather than guarding the map itself, which
does its own locking. Giving each SMMU its own lock looks possible now, but
that would touch every attach path and belongs to a separate change.

Assisted-by: Claude:claude-opus-5
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h    |  2 +-
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c    |  6 +++---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c    | 18 +++++++++++++++---
 3 files changed, 19 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 50f8321e979ce..fd6f489cfedf2 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -952,6 +952,7 @@ struct arm_smmu_device {
 #define ARM_SMMU_MAX_VMIDS		(1 << 16)
 	unsigned int			vmid_bits;
 	struct ida			vmid_map;
+	struct xarray			asid_map;
 
 	unsigned int			ssid_bits;
 	unsigned int			sid_bits;
@@ -1128,7 +1129,6 @@ to_smmu_nested_domain(struct iommu_domain *dom)
 	return container_of(dom, struct arm_smmu_nested_domain, domain);
 }
 
-extern struct xarray arm_smmu_asid_xa;
 extern struct mutex arm_smmu_asid_lock;
 
 struct arm_smmu_domain *arm_smmu_domain_alloc(void);
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
index 0a429c64fbf3e..2433ec61f5336 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
@@ -301,7 +301,7 @@ static void arm_smmu_sva_domain_free(struct iommu_domain *domain)
 	 * reused, and if there is a race then it just suffers harmless
 	 * unnecessary invalidation.
 	 */
-	xa_erase(&arm_smmu_asid_xa, smmu_domain->cd.asid);
+	xa_erase(&smmu_domain->smmu->asid_map, smmu_domain->cd.asid);
 
 	/*
 	 * Actual free is defered to the SRCU callback
@@ -341,7 +341,7 @@ struct iommu_domain *arm_smmu_sva_domain_alloc(struct device *dev,
 	smmu_domain->stage = ARM_SMMU_DOMAIN_SVA;
 	smmu_domain->smmu = smmu;
 
-	ret = xa_alloc(&arm_smmu_asid_xa, &asid, smmu_domain,
+	ret = xa_alloc(&smmu->asid_map, &asid, smmu_domain,
 		       XA_LIMIT(1, (1 << smmu->asid_bits) - 1), GFP_KERNEL);
 	if (ret)
 		goto err_free;
@@ -355,7 +355,7 @@ struct iommu_domain *arm_smmu_sva_domain_alloc(struct device *dev,
 	return &smmu_domain->domain;
 
 err_asid:
-	xa_erase(&arm_smmu_asid_xa, smmu_domain->cd.asid);
+	xa_erase(&smmu_domain->smmu->asid_map, smmu_domain->cd.asid);
 err_free:
 	arm_smmu_domain_free(smmu_domain);
 	return ERR_PTR(ret);
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 1c4322d87d8df..c1d04f84870f6 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -85,7 +85,6 @@ struct arm_smmu_option_prop {
 	const char *prop;
 };
 
-DEFINE_XARRAY_ALLOC1(arm_smmu_asid_xa);
 DEFINE_MUTEX(arm_smmu_asid_lock);
 
 static struct arm_smmu_option_prop arm_smmu_options[] = {
@@ -2839,7 +2838,7 @@ static void arm_smmu_domain_free_paging(struct iommu_domain *domain)
 	if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1) {
 		/* Prevent SVA from touching the CD while we're freeing it */
 		mutex_lock(&arm_smmu_asid_lock);
-		xa_erase(&arm_smmu_asid_xa, smmu_domain->cd.asid);
+		xa_erase(&smmu->asid_map, smmu_domain->cd.asid);
 		mutex_unlock(&arm_smmu_asid_lock);
 	} else {
 		struct arm_smmu_s2_cfg *cfg = &smmu_domain->s2_cfg;
@@ -2859,7 +2858,7 @@ static int arm_smmu_domain_finalise_s1(struct arm_smmu_device *smmu,
 
 	/* Prevent SVA from modifying the ASID until it is written to the CD */
 	mutex_lock(&arm_smmu_asid_lock);
-	ret = xa_alloc(&arm_smmu_asid_xa, &asid, smmu_domain,
+	ret = xa_alloc(&smmu->asid_map, &asid, smmu_domain,
 		       XA_LIMIT(1, (1 << smmu->asid_bits) - 1), GFP_KERNEL);
 	cd->asid	= (u16)asid;
 	mutex_unlock(&arm_smmu_asid_lock);
@@ -4483,6 +4482,13 @@ static void arm_smmu_destroy_vmid_map(void *data)
 	ida_destroy(ida);
 }
 
+static void arm_smmu_destroy_asid_map(void *data)
+{
+	struct xarray *xa = data;
+
+	xa_destroy(xa);
+}
+
 static int arm_smmu_init_queues(struct arm_smmu_device *smmu)
 {
 	int ret;
@@ -4590,6 +4596,12 @@ static int arm_smmu_init_strtab(struct arm_smmu_device *smmu)
 	if (ret)
 		return ret;
 
+	xa_init_flags(&smmu->asid_map, XA_FLAGS_ALLOC1);
+	ret = devm_add_action_or_reset(smmu->dev, arm_smmu_destroy_asid_map,
+				       &smmu->asid_map);
+	if (ret)
+		return ret;
+
 	if (smmu->features & ARM_SMMU_FEAT_2_LVL_STRTAB)
 		ret = arm_smmu_init_strtab_2lvl(smmu);
 	else
-- 
2.43.0

