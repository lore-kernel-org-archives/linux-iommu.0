Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012038.outbound.protection.outlook.com [52.101.48.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27C6320B80B
	for <iommu@lists.linux.dev>; Sat, 11 Jul 2026 00:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783731205; cv=fail; b=tVr2JFFnCi0NOMu+T2UXGR751sK5j7GMB2eLpb/6Y4phFxOnpCkTqL5k3lS4l5ynQe1CBlE8XrXvzTd04LfQffOz6eJtk++E5hWNuCt5u+JlygQsLOjR9wQSitT5JDiem573HqbfTirO0m8Ulppl9ltNMBw3bIR8T1HtPlkFBfA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783731205; c=relaxed/simple;
	bh=HyQLgsoErT5PsrpBkaslewMWeuvD4R/HVGKPT9SvOMI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q7MqUObaWN6jzgXFwFIYy2vXdTeeM3/5vCEv07zQreLJe8pQTLQZmwjSSfdCHLADOzArr+DPaqRNEpM9gkt9c4PtbutzKxl4j6E5wB5/eCzj8xYkclNNq5jQnrrzNFs9m7nSs5QVKTxUB89rB900DJFiNY5wiKBQ9+RG7DDuELw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OvKcdX0M; arc=fail smtp.client-ip=52.101.48.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OvKcdX0M"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CNekQ/eYSaoIjI+FabMHuE+KVGHz8RgrT47f6uTdrDWkQ6yggjpRpSFR0FSNaD9TzFMVPTJskVkEpZ+KD31pV/3/wSUXjHs4eU4WtpKLKDhO6pG3TlxrgU8YiUiKcIc40nLOX8pPOgVCxoEssSBBQdUpC4eKRu9J9Ji6BIN5AmdFFC0IBGypVTVO6A+MR2imQWswEL5xBQdhuEIYZPKGOyfV2chbKK9dHCI+9CaaKxdCmHsf365Pc8z2PVW951YaUK1Wi8ulciWTvsLr2dApMrzS62kuYvaXtryWzeL/LGqIcApQCOA1iQBoOf/YifMya2rx9y02tepUEVI6YGRQnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9HYDly/Tw5PqEWeQFEuqMDCK5d6vkWpzdyWKArha15U=;
 b=ZXrTqnPCLIQpegmIS2ZOr20q9YC+5ZGx96zkOQ+fUJcJMoYOD29mJxYzkdR3uz7Q0L88E18nLVQ7GuM9BLGGiT7cPx0gtoXbVGY/aTYdD1GQCDz6IMcdYFaTv+9OPaL7Xs0cK34YkMyT1OVHzGHHOhsPdKvJc3eHE1n9ELsizjgDnCP/Rvnu1TWpJHktM84DlPLwm1MDx4SS9nN+Xvn5Ef6KDpBXjd4au8dgWALyhcvDa1KejWij3yvUT+3TK4+y26b+i2uRKfcH/wGQLVolt6ayeMYtiPKYJGwYdEi3E/bmIn91SRVOFpBfw3JyJoRbg4LU9wax+XgN29qH5NVmLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9HYDly/Tw5PqEWeQFEuqMDCK5d6vkWpzdyWKArha15U=;
 b=OvKcdX0My+xQaz8ZXCcZ11qhYo3g3GDQN7NvEIHNCCyHNinPv5LTPNQofKBjIg6Sw8TgUSJ6XrHoB2v/H46tXaDjQwBV0Tx6hrZOWcJkZtNJkxQlk96Gt04gPS22b+ZCC/NgFLBUH2/0WyeHKrmtvWdkCCh3XHptPyEnRqLf2cYP0no/Nsq7y5gCDDn+iz7B8fs3TY+WK0TLZplel7WGom+tcw7119HyjlTCjtyv6RT0y5SwOFFueY/qh7YI7PPz07BcLG4yTDzuAJDfxDRGQTel+moX/zgdHAykTcQ9o28cGT7CsgtqevmOEcjqouQAPfFiegr+rU23Lh2CH1R60g==
Received: from SN7P220CA0023.NAMP220.PROD.OUTLOOK.COM (2603:10b6:806:123::28)
 by DS0PR12MB6389.namprd12.prod.outlook.com (2603:10b6:8:cf::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.17; Sat, 11 Jul 2026 00:53:16 +0000
Received: from SN1PEPF000397B2.namprd05.prod.outlook.com
 (2603:10b6:806:123:cafe::19) by SN7P220CA0023.outlook.office365.com
 (2603:10b6:806:123::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.14 via Frontend Transport; Sat,
 11 Jul 2026 00:53:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF000397B2.mail.protection.outlook.com (10.167.248.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Sat, 11 Jul 2026 00:53:16 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 10 Jul
 2026 17:53:02 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 10 Jul
 2026 17:53:01 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Fri, 10 Jul 2026 17:53:01 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>, <robin.murphy@arm.com>, <jgg@nvidia.com>
CC: <joro@8bytes.org>, <praan@google.com>, <kevin.tian@intel.com>,
	<smostafa@google.com>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>, <jamien@nvidia.com>
Subject: [PATCH v8 6/9] iommu/arm-smmu-v3-kdump: Implement is_attach_deferred()
Date: Fri, 10 Jul 2026 17:52:47 -0700
Message-ID: <b897dd13c7de0c17128373693fc13cc2615de922.1783729633.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B2:EE_|DS0PR12MB6389:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e49cafd-5700-435c-1065-08dedee6cb25
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|1800799024|23010399003|82310400026|11063799006|56012099006|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	f4yij/7jtdErHMfb2kzdQo1/+fcLn6UVBLoNg3d3Y08IDt7LOehpDuW1JYyeX0ADKWIewK58YZIi1HXRwVhy8HhuX5Ox8dFU6hIwvJWaJnLGYb3nOvTaIi/ZUZoK0w+mem7h0Ix3XGVy6kQ5XqJB1X4seVBAHT8gOeVpFZMlT7ytr76EuVzT3L43PT+qVcJYixVKps1y4kVF1ASKDwZi8wKhUrnqb8tM6E2x3TnKA5dMz/xyucl54yo//FbRHZ+r3fYifS/y3cqRpMOLqjkI0n6Rnoe+Od0Hm33cHYKtM/CE0HseODMg2uDbi9d8yc2sgeUwjeb0IXH3u1K5Leq5n5GPI/Pgzkg4M3DV99Fv2iGZHINCZZV+M7vQOF5ey/A+qMAPv5mDk1dtSPJXLv28MOw/ig5kI0Cv4TWCyd5WOVYk0/26/86eOsuKfMLVvq2KXSEya2A4vOtSCEQWuS+7nKonTW2h9Abwn/bbprNFd3k++/pJmlcTgWiZXiiMb5aG8MHSh9pwvubtH0rlvP2jBzgke6IUWF3Ea4cSXjjLKiIO50ZND2ve8/jioXGhfML2AGjP7I1xHJX4A3s+GNtUC/lQdwvNTgOQZKSCYmBNJpzan308Nek5EGg7VKKJQNk8nYISwMsWFXxyh2G7T30ddNRKd7eafnaGD+NA6E8iriuRSAcz2HBci0j+t7AJHZ53LW8CxHPV+gEEe4D4gSf8nQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(376014)(1800799024)(23010399003)(82310400026)(11063799006)(56012099006)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	KI9jK1ZwytPHtPH9P/uKQZ1Gakv7ij5rmuecRW02DTyVnXQiZZQ2ixO9DfvybW99Uf4b+6wQj19nLVL75E8PRBp5EWunRN2K/dJrrbrTTGpua0eVw37QZ23siq/aKVHYOjRoKmHaaWxSTkuKFLuUQbG4rmWNEZ6+bOiTF7L3VeCEBfNzNizavtTWGvHhav+2psM6xqr7WGeuhUGdNEqdrckNdBVnjt+c0UDvmYH8dW0m7U04EN0gphl28Onr2O7N16/m4Qhwf9YPmdmj66XATMzOKwyXMU4N2vVKMBXwJ1DomtaKmaBSMJUHCvhcMUWCe1jwfqqvDj+q91V2FQeGC80ubZKb7bCCw2o8q8B/fEYk/8C0gkRJcyKhqkT8KnBXDbDdfRIQCDrig+yeWgX6nV51uAEVHzhfenM1SXcZgBcuzTGd7RItOyC3imH5ofjc
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2026 00:53:16.3652
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e49cafd-5700-435c-1065-08dedee6cb25
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6389

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
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   | 22 ++++++++++++++++
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-kdump.c | 19 ++++++++++++++
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 25 ++++++++-----------
 3 files changed, 51 insertions(+), 15 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index e567be11f2d56..7c5a25b90a8fb 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -1208,6 +1208,21 @@ void arm_smmu_attach_commit(struct arm_smmu_attach_state *state);
 void arm_smmu_install_ste_for_dev(struct arm_smmu_master *master,
 				  const struct arm_smmu_ste *target);
 
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
@@ -1245,6 +1260,7 @@ int arm_smmu_kdump_adopt_strtab(struct arm_smmu_device *smmu);
 int arm_smmu_kdump_adopt_deferred_l2_strtab(struct arm_smmu_device *smmu,
 					    u32 sid, phys_addr_t base, u32 span,
 					    struct arm_smmu_strtab_l2 **l2table);
+bool arm_smmu_kdump_is_attach_deferred(struct arm_smmu_master *master);
 #else /* CONFIG_CRASH_DUMP */
 static inline int arm_smmu_kdump_adopt_strtab(struct arm_smmu_device *smmu)
 {
@@ -1258,6 +1274,12 @@ arm_smmu_kdump_adopt_deferred_l2_strtab(struct arm_smmu_device *smmu, u32 sid,
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
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-kdump.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-kdump.c
index 4d010df430587..3efb4e7ff94b6 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-kdump.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-kdump.c
@@ -531,3 +531,22 @@ int arm_smmu_kdump_adopt_strtab(struct arm_smmu_device *smmu)
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
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 3f4b281c35fed..97c024c133f41 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2898,21 +2898,6 @@ static int arm_smmu_domain_finalise(struct arm_smmu_domain *smmu_domain,
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
@@ -4318,6 +4303,15 @@ static int arm_smmu_def_domain_type(struct device *dev)
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
@@ -4326,6 +4320,7 @@ static const struct iommu_ops arm_smmu_ops = {
 	.hw_info		= arm_smmu_hw_info,
 	.domain_alloc_sva       = arm_smmu_sva_domain_alloc,
 	.domain_alloc_paging_flags = arm_smmu_domain_alloc_paging_flags,
+	.is_attach_deferred	= arm_smmu_is_attach_deferred,
 	.probe_device		= arm_smmu_probe_device,
 	.release_device		= arm_smmu_release_device,
 	.device_group		= arm_smmu_device_group,
-- 
2.43.0

