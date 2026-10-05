Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012008.outbound.protection.outlook.com [40.93.195.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 943C14AF173
	for <iommu@lists.linux.dev>; Mon,  5 Oct 2026 19:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791228691; cv=fail; b=EUDUBI///jmW2wf6mSW1C3K/7hyrsrrn5UBXb0tx5vt8xchoQxuw10WpU3lCiF8zPd8nr6l8of5h6PoCHEqsYm/9/va0diEc/uGy+SwRVVIMk6jSQUPl1UgSjMtAV3bv1Mejde5xU3rf3znab59c3ElM3Nnwz9ioa7DqTYq4c4M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791228691; c=relaxed/simple;
	bh=wTrm5RWrwaFNlKPtcqkEhtNC+UvjdGXWFOir4TSZNDM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GSpCle1WgMx7lg0V/D40ly4KoHX131wER1RvoGp4cv8tbp9qgik6bU8GTPoX055qX5Linkgh60zEnS/qarMRRObQQ3GLLCoG3QlhB+fBMTatGtWVwqFzdqgvayCBrtvYS3fGFpp/EkAfgBPcgDheLtPzv2Pysu3zd3XRXnpoNIA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jUPDeHZC; arc=fail smtp.client-ip=40.93.195.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jUPDeHZC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fVSey5y9RM6VfV9/P1JI4ml1DD5KkH59TN2D4yO/fpJjvt+Gm8aNsx/3A7pyEnFO4pTNwfRK7oZRBqk/rB+9aWaHlf4tdgWeqY7E8bP9YXwJgLCeFjUGme0mnZQ4K+DlDScCQ5SOef30Wu4qGs6VPOl99Xmn9F6YR4ZsT8j9P4R8EBNUgPRp/e1ratXhSINbj9gkiDIh8OaOK4bE39ay8VuMtjbpwMr9/ZpBEctEJ5TDEIArglTsu0kN4KVDoUu2K2D/4g9xlP7m0BVlbXY/aJEUf3JE7rfb/1HXoqpxsvBniP8pTaNDUHgVwhZX0pTwHPkaOwWC8bWqrURvOUjqkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mP7vSKLX+L7IeAbV8kO7o2Cg8Oprdd09wdh5b11ErvM=;
 b=W6pkhIrN8GkSK96FwZfmYcZPZmNw35ed4IxmXyb4+xsarr5LcEUSIYXHvAQnKGQsizJlQ/oWm/+bOdubcAGdb8HgC5xGiBS8I34DOWI9KEL2rz9U2hkqcUeMpD4F2KF19yxVJCnjDEI6kKu6dssx3wcU2b+n63zYdEDD6T9WPOoLytfqRMTmPGUANTiyRGJ+mx3LfX9GqgVuTnbZjys3AQw6BG6De4d3hUP+URMVcomaqOfIkZ0hQPgT9Zq4R+YhqdFVDjGgG9Z5Pzc67y+GXdLudUoUDyqU/6dVWvJJSKzS2kqMUawnnzLHo301aZrimIYBlYcOsHUH6TVevjX/HA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mP7vSKLX+L7IeAbV8kO7o2Cg8Oprdd09wdh5b11ErvM=;
 b=jUPDeHZCVX+urwevJ4F693XMlO0BWVFtjtb1MQ63vzS1hKQ61sGZDg4jduMYpfiZQvMzGSaJQiFk137LKzv4jaFjGvm40CoF+QXjFiFmttoYZ7p4SvfcnrDZodZ3DuZEkjaW3/JxUn13+5rgmlRDLOtUJuQMf2dRzQ1rm497WKf/ypphbt/QKP/6U+sM+vCImURn7S5kOsvmOI5WF7rM7gplxEPl6VReJrBjU8a32hoAM6VV+l0aYJqiEarimdwMh9M9Xsy13WMpG4F/TJsNE3ET9AnEBs+rWPV5giOUkPYJsjXu0BdwIb6spQRP8osSn8y9n2JC+WrGPyLZnp70nw==
Received: from SJ0PR03CA0225.namprd03.prod.outlook.com (2603:10b6:a03:39f::20)
 by LVUPR12MB999186.namprd12.prod.outlook.com (2603:10b6:408:3a3::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Mon, 5 Oct
 2026 19:31:24 +0000
Received: from BY1PEPF0001AE19.namprd04.prod.outlook.com
 (2603:10b6:a03:39f:cafe::3a) by SJ0PR03CA0225.outlook.office365.com
 (2603:10b6:a03:39f::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Mon, 5
 Oct 2026 19:31:24 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.118.232) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BY1PEPF0001AE19.mail.protection.outlook.com (10.167.242.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.14 via Frontend Transport; Mon, 5 Oct 2026 19:31:24 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 5 Oct
 2026 12:31:02 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 5 Oct 2026 12:31:01 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Mon, 5 Oct 2026 12:31:01 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>
CC: <robin.murphy@arm.com>, <joro@8bytes.org>, <jgg@nvidia.com>,
	<praan@google.com>, <kevin.tian@intel.com>, <smostafa@google.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <jamien@nvidia.com>, <kas@kernel.org>,
	Cristian Prundeanu <cpru@amazon.com>, Breno Leitao <leitao@kernel.org>
Subject: [PATCH v11 02/11] iommu/arm-smmu-v3: Make the ASID space per SMMU instance
Date: Mon, 5 Oct 2026 12:30:45 -0700
Message-ID: <e027296ac9db58fb7d69b1b4b5e4a2ed192dd401.1791226953.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE19:EE_|LVUPR12MB999186:EE_
X-MS-Office365-Filtering-Correlation-Id: 129e6b7a-1a6a-4f0a-d9ee-08df23173e28
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|23010399003|1800799024|82310400026|376014|7416014|22082099003|18002099003|5023799004|56012099006|11063799006|10067099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	nHK9L0fAX3WQ2i8VQPACg0eGC18l1o4n5/i3SgZo+Qbk9w5xuUkcHX1v1vfxA7f0QlhFrPgK5j3J9ArDO9kyAtMPyDlnBdbh+1nKSNLzEPls3qlNjhczUbLsJlzSL67IaTNkN4HlgJR+LFAMmrQkvlqC0JYl9w59fQvtdnAjQzvNvwGJRD1zdIKDJlARymwnHtxOyp0DBxDU6H8VjakTKc/uPK9hNbLBPUoxhU2ZC2pV/DBz5YUNN/BuQM5A/IqRhY6sjcKmFnlj7Xf8RX0p8YorCDuIPdFGJ9PVM/1tRXbzleYdmfbg81GRFTC+k4bb/16KwgQ9by2Bo9L+TZoce/QgtjRBya7mLDPfPhTyt9hy5q00bTZ78mm3oKNyUowMEdao30vdSzyLCXCGZHePn7ytRO41vnj6qA80IJvYVxYjQSLnJArxQWRoh/5XDWOZndnepbT0pu+wmS29fm85OSy8MyLYSKJB1dTvhM5PEY/C0bPcmJYBTUy+7ndwpBW/UZvpOn6252AJwlnn0lsDpz0BHI5A+FaUfdWYT0aWMJBXuJagwsenZu802emFUE6GUgzduppD8EN2dVG8/d8QThUhAhgXOR6pN0EZ5ppS5hDd5d906Xw0H2P0zSVqAR20Qy7wWXuqgIvsqrgkUL/Dy3LceNbLDqNBrjpoVxfkj4YluOvpUs2c9WbJ5k6w+LXSweMp8PO2dFqAPebtLfg/Zw==
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(1800799024)(82310400026)(376014)(7416014)(22082099003)(18002099003)(5023799004)(56012099006)(11063799006)(10067099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	4QlmH2iL+dZ/quEZ7a2hGiCW/LsQTXveuMOZJmEPLLJETr/8E6Y4ZpCWISoycFgVkoftob7Vsq1t+70IfE3IreIdrNed9W4xqAah7X9aAUyDsQEMam5kRp3PPVzO8FgHPIkqCwTwt+8qrnUgcvTVbO19KQrzss7Xi77G8uhdaKam9eStx4FO/BKTwJ+yhuUMK+FAdeQNcv6Kp+MDIdb0A3gDZsK0fno1KNxAWZX+TNvqXkhgr+ke/RfJJR8taJorJ9+AzyBq3j89Sla33z6MfQJhkUiLppnolIMa6iNmnCjDVpiuCO6HtD638A+QNwOcFK2Isjw13Xqn6rVedh9sn5/M0FwHm/DyBUP5WsaJUIiA+eNhJGNpR9DL9lNMQUmEG6TKWi1lc8DzyGRIyacnQsgUQP6D1IF/tizFC0LDnY2/hPoJEQLgufiVz6wBxaAM
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2026 19:31:24.3159
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 129e6b7a-1a6a-4f0a-d9ee-08df23173e28
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BY1PEPF0001AE19.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LVUPR12MB999186

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

This also eases the BTM work that Jason's working on:
https://lore.kernel.org/linux-iommu/20261004162219.GA4064@nvidia.com/

Note that arm_smmu_asid_lock stays global, as it serializes the STE and CD
updates against any ASID change rather than guarding the map itself, which
does its own locking. Giving each SMMU its own lock looks possible now, but
that would touch every attach path and belongs to a separate change.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Tested-by: Breno Leitao <leitao@kernel.org>
Tested-by: Cristian Prundeanu <cpru@amazon.com>
Assisted-by: LLM
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h    |  2 +-
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c    |  6 +++---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c    | 18 +++++++++++++++---
 3 files changed, 19 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index bb048e08d613d..8f2c0b1cc4a8d 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -1003,6 +1003,7 @@ struct arm_smmu_device {
 #define ARM_SMMU_MAX_VMIDS		(1 << 16)
 	unsigned int			vmid_bits;
 	struct ida			vmid_map;
+	struct xarray			asid_map;
 
 	unsigned int			ssid_bits;
 	unsigned int			sid_bits;
@@ -1180,7 +1181,6 @@ to_smmu_nested_domain(struct iommu_domain *dom)
 	return container_of(dom, struct arm_smmu_nested_domain, domain);
 }
 
-extern struct xarray arm_smmu_asid_xa;
 extern struct mutex arm_smmu_asid_lock;
 
 struct arm_smmu_domain *arm_smmu_domain_alloc(void);
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
index faeec656da9e7..489531e0027bd 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
@@ -311,7 +311,7 @@ static void arm_smmu_sva_domain_free(struct iommu_domain *domain)
 	 * reused, and if there is a race then it just suffers harmless
 	 * unnecessary invalidation.
 	 */
-	xa_erase(&arm_smmu_asid_xa, smmu_domain->cd.asid);
+	xa_erase(&smmu_domain->smmu->asid_map, smmu_domain->cd.asid);
 
 	/*
 	 * Actual free is defered to the SRCU callback
@@ -352,7 +352,7 @@ struct iommu_domain *arm_smmu_sva_domain_alloc(struct device *dev,
 	smmu_domain->stage = ARM_SMMU_DOMAIN_SVA;
 	smmu_domain->smmu = smmu;
 
-	ret = xa_alloc(&arm_smmu_asid_xa, &asid, smmu_domain,
+	ret = xa_alloc(&smmu->asid_map, &asid, smmu_domain,
 		       XA_LIMIT(1, (1 << smmu->asid_bits) - 1), GFP_KERNEL);
 	if (ret)
 		goto err_free;
@@ -366,7 +366,7 @@ struct iommu_domain *arm_smmu_sva_domain_alloc(struct device *dev,
 	return &smmu_domain->domain;
 
 err_asid:
-	xa_erase(&arm_smmu_asid_xa, smmu_domain->cd.asid);
+	xa_erase(&smmu_domain->smmu->asid_map, smmu_domain->cd.asid);
 err_free:
 	arm_smmu_domain_free(smmu_domain);
 	return ERR_PTR(ret);
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 792627e1c790e..aeace4335abfe 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -90,7 +90,6 @@ struct arm_smmu_option_prop {
 	const char *prop;
 };
 
-DEFINE_XARRAY_ALLOC1(arm_smmu_asid_xa);
 DEFINE_MUTEX(arm_smmu_asid_lock);
 
 static struct arm_smmu_option_prop arm_smmu_options[] = {
@@ -3015,7 +3014,7 @@ static void arm_smmu_domain_free_paging(struct iommu_domain *domain)
 	if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1) {
 		/* Prevent SVA from touching the CD while we're freeing it */
 		mutex_lock(&arm_smmu_asid_lock);
-		xa_erase(&arm_smmu_asid_xa, smmu_domain->cd.asid);
+		xa_erase(&smmu->asid_map, smmu_domain->cd.asid);
 		mutex_unlock(&arm_smmu_asid_lock);
 	} else {
 		struct arm_smmu_s2_cfg *cfg = &smmu_domain->s2_cfg;
@@ -3035,7 +3034,7 @@ static int arm_smmu_domain_finalise_s1(struct arm_smmu_device *smmu,
 
 	/* Prevent SVA from modifying the ASID until it is written to the CD */
 	mutex_lock(&arm_smmu_asid_lock);
-	ret = xa_alloc(&arm_smmu_asid_xa, &asid, smmu_domain,
+	ret = xa_alloc(&smmu->asid_map, &asid, smmu_domain,
 		       XA_LIMIT(1, (1 << smmu->asid_bits) - 1), GFP_KERNEL);
 	cd->asid	= (u16)asid;
 	mutex_unlock(&arm_smmu_asid_lock);
@@ -4741,6 +4740,13 @@ static void arm_smmu_destroy_vmid_map(void *data)
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
@@ -4848,6 +4854,12 @@ static int arm_smmu_init_strtab(struct arm_smmu_device *smmu)
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

