Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010069.outbound.protection.outlook.com [40.93.198.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0DBE39F16D
	for <iommu@lists.linux.dev>; Thu, 19 Mar 2026 19:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773949977; cv=fail; b=brtSvLLecVJCG8jlIOb8IblaGka0r2nT9qjwP5TAYnSdCV8I5+9pHOc3V8klvHQbZbYVG8Y2cPK4U3rDSL2QrH1QFMGHemN1gs8vP2HJ5atGT+L5GXXX0gKPbIl7ydvZmI4oB1m4PPdGNOkv55bPwUwFG3OpkGFvcIVU9kQwZn8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773949977; c=relaxed/simple;
	bh=BKjqR3HvOPSAE9wuAQfuXTylzl2AlFpYBoN1hfKcY9s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fkZFMMFcmqAxqAJ0zL+zX/ZEzsVB5+87KFGZQIy/0R0nfu4DV29zLemYFEcZYntTJ2Lm9BxN4wGrHyiX7Dq/jFhEQiVqYfTZJzLiwIemMFh/zm9lGoNDK5dtFSyOUFGyx7j7UWENwloVnS9+5h2Z5CROwaj5TWMgWlPWDESjb60=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MZpqOuO7; arc=fail smtp.client-ip=40.93.198.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MZpqOuO7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A8GFoNoLjHGLS5WbBM0UDYl/P8Fp4OnQJPuN1L67rmng44JvhYjsLSGpddDI6V8q6EFBrm8HOW+b/unYhvglWvTBzjPeX5cZciZCkXgnaAHiN1uXpP2+BjdlEIfv3DxI8BNVkMql08Vp4RUicF14ZvFz5l3haG0WWBt2iHUfpqvC/0T4vJzojwKGX9hrEDUiW9OZlhc5OSeEOxJPLmqH969LWZjchwZQnWdqBg2HL+tKF5CeSVRUn6IKAvk4txtfhJU0EseekhRfdP+6+biWv1Pqla8qH9x2i+yD9g527NaksX4wVfYFwok7UpmEhWsaI+69A3YweDpl9eNIsbhyyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3ZuTXQlk4zThQ+FspnoHwvyxZGM7px8eEuD0etLDOGI=;
 b=kYbAP7YAjWsxEL1hsdwWvec4NSUD/VGfnj/R6xJVpCsAd8N3TqcmnuelnuvOfusg7VpgTn0BlHZ1PMsylgiCOCyyDChYGtO6e9FA0AABC8Ceu2Ua+XS4VgRf6JDTJREC2u8H+ZIPWo0hrGWhAJ58fku+k8HMEnWBH/vt2Ak2HpWSa2BmTViEo2FFgSRwqZy7pyalXeqbNtgyvKr9whAgukJusmpE95i4FlGK83SpXBXRZ0DRCEsPk+EZBN6cn8QNrJN9DYUjsAX9tkdeBiTaHXuFNxyOZ5JVjxsjXhXChnM/5prORybUiIw7/cb5L/KxHcusSufVLsmu1AbKSeYLKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3ZuTXQlk4zThQ+FspnoHwvyxZGM7px8eEuD0etLDOGI=;
 b=MZpqOuO7y5SLCRPO1oMEvrYNYwT6tl1CaX4UX+8yodANJnb5vghRBWbaChvYYiDP/3N0dx527bLcB85bIEtKaBGMe2WCsPP2WxlR/sC9Q7K9GQDhezrtgt/UUE0HOuAY55ju2NFC6LYkV0LCFFodFycj3gl2Urt8XuCi8NQtG6PsH9GCwCwUJYFcWy26C13pLc1J1BNw92/VaX0AK60nYXIYrcTrd+iqGZCcQ9m5t9woc14gsszu8UB09A9jk4w9oNBPEbkl9OtB9jgBqfBCLWO7PxTATX69mX0tI9J4RuLuTgPzimxCXc6RMysM7pFt/Kk/uCM9tsSWjb/JjyZHGw==
Received: from CH5PR02CA0023.namprd02.prod.outlook.com (2603:10b6:610:1ed::24)
 by SA1PR12MB9245.namprd12.prod.outlook.com (2603:10b6:806:3a7::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.9; Thu, 19 Mar
 2026 19:52:30 +0000
Received: from CH3PEPF00000016.namprd21.prod.outlook.com
 (2603:10b6:610:1ed:cafe::74) by CH5PR02CA0023.outlook.office365.com
 (2603:10b6:610:1ed::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.20 via Frontend
 Transport; Thu, 19 Mar 2026 19:52:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH3PEPF00000016.mail.protection.outlook.com (10.167.244.121) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.0 via Frontend Transport; Thu, 19 Mar 2026 19:52:30 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 19 Mar
 2026 12:52:12 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 19 Mar
 2026 12:52:11 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Thu, 19 Mar 2026 12:52:10 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>, <jgg@nvidia.com>
CC: <robin.murphy@arm.com>, <joro@8bytes.org>, <jpb@kernel.org>,
	<praan@google.com>, <smostafa@google.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
	<jonathan.cameron@huawei.com>
Subject: [PATCH v4 07/10] iommu/arm-smmu-v3: Allocate IOTLB cache tag if no id to reuse
Date: Thu, 19 Mar 2026 12:51:53 -0700
Message-ID: <aea51cbf226d90436918dc09df5cf8f5c64ef8bb.1773949042.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1773949042.git.nicolinc@nvidia.com>
References: <cover.1773949042.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF00000016:EE_|SA1PR12MB9245:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b85fe7d-f5dd-4b04-4b52-08de85f10e25
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|36860700016|376014|1800799024|82310400026|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	9T4YHNC9iVFHBOtjk6XWQ66mA0jfblfCYy6HVEr10QnlcYiFIc0N8FrbjYJCShTMUx6ti7SVrfbCOXLOtMLD9Z02p2+PfsWMZBQ+aUrGR5fV65SH9WLa8Z6gWy6W3ae/gXDVYDKG+tKNEEl9pcenN5FZTNXiHn0jTz5SFdcnHafrAwlEvyRRM6Ka6wRx2OPc8TwEQCltTsjFHdf14L1H6VF7Sb1XP5E0nUWg4POyhwzWBxHH3P8/CKoBk0swgPk6f8NI6B6Vg0Hy5cZfHB4pbWca5lLMi6/HWRxOZ+/hnJt505h7gPNXvQ3vA5Ux0+j/KxhW9owF/TbeyDDHeOHGtiSz4BsW/iwvZ4PRoJLwEsLVT3n+ku8/HZXGtLRB6YaIZ0ipKRC9Gya56kQ4HEjp0nEFRgB/sahmYzGKAdVMoVsMxxpZ+ap/+rfoE+WkzsrT6Xs5VPitAJZcPkdKc5oPLS1G+BBBTzGJZIZBqF8+yGXX+uRi6T51JNz1S2lmJKiReziKo/RKLx9HB9Nhbi6Zy2mfiu4Z7Lbu3TiPE1DnxcSfKQNXUJvJRNn48FG4L8DyC5ZNqaUaDUS+ILxIV1kXjBew2Fqi+kTibODc8nMm/pgzJszzT6jGMygJA8r3LIRZ8B9JVPTuVTQ8tVKgRtEW1JEZF9syPNHQcn/gLlGVS6LPpVfr0ve0+Cx70hFx4kQsknoG84I5qzmY5Xxb/VTnMqeIWtDgoq4/rW8FnGPUOs2NYt1KtGe8hLacIBRjFJqHct8WOaG0pLxYU7adQ9HPWQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(36860700016)(376014)(1800799024)(82310400026)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	XM7fPAKkxfikPNNA+RdffnBwBwUvDe6s2uc9UajSkOMqtOvrtasF6pfINnLtxedGRJU2U1nLCnkj88ifdPB7ZF+chQNSM0A9PuA4FKxeJrk249dkHKSh3rR1lEsf8HujfT7Na7JdDwf+Fyv7k/FwlQ8OL5dBTXG6FKYiLVoYw5nzTDVNEWd2FW4+N623RmySCeLrxKABW0TyWeo5Ev2De47hGak1VE2H9S7PceHaa1hx1gpvDor42i1gpPQud6hYALYmb/L/f9GyXAa5bKtjqz0lf7sxO8WiA92tynf+25Ib9QSxYrgsMyPFJBxVIgPi5de/d5Gl/gprkghx1hkreJgNrfekJPPmRZjp+vpTimkJ7c/+x2AklqqxFqQcg/WD4spkaYFAHjEM5vgVql3vHgHdLmIjSV5gHNkYvmSE3MyZFRPLC4CXRNK2I+y+nY3g
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2026 19:52:30.2421
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b85fe7d-f5dd-4b04-4b52-08de85f10e25
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000016.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9245

An IOTLB tag now is forwarded from arm_smmu_domain_get_iotlb_tag() to its
final destination (a CD or STE entry).

Thus, arm_smmu_domain_get_iotlb_tag() can safely delink its references to
the cd->asid and s2_cfg->vmid in the smmu_domain. Instead, allocate a new
IOTLB cache tag from the xarray/ida.

The old ASID and VMID in the smmu_domain will be deprecated, once VMID is
decoupled in the vSMMU use case too.

Since invst->new_invs->inv[0] and invst->tag are basically the same thing,
merge arm_smmu_inv_flush_iotlb_tag() into arm_smmu_iotlb_tag_free().

Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 63 +++++++++++++--------
 1 file changed, 38 insertions(+), 25 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 130b6442af37f..1c9358ed3ecf7 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -3281,13 +3281,44 @@ static int arm_smmu_alloc_iotlb_tag(struct iommu_domain *domain,
 		return 0;
 	}
 
-	/* FIXME replace with an actual allocation from the bitmap */
+	lockdep_assert_held(&arm_smmu_asid_lock);
+
+	if (tag->type == INV_TYPE_S1_ASID) {
+		ret = xa_alloc(&arm_smmu_asid_xa, &tag->id, smmu_domain,
+			       XA_LIMIT(1, (1 << smmu->asid_bits) - 1),
+			       GFP_KERNEL);
+	} else {
+		ret = ida_alloc_range(&smmu->vmid_map, 1,
+				      (1 << smmu->vmid_bits) - 1, GFP_KERNEL);
+		if (ret > 0) {
+			tag->id = ret; /* int is good for 16-bit VMID */
+			ret = 0;
+		}
+	}
+
+	return ret;
+}
+
+static void arm_smmu_iotlb_tag_free(struct arm_smmu_inv *tag)
+{
+	struct arm_smmu_cmdq_ent cmd = {
+		.opcode = tag->nsize_opcode,
+	};
+
+	arm_smmu_inv_assert_iotlb_tag(tag);
+
 	if (tag->type == INV_TYPE_S1_ASID)
-		tag->id = smmu_domain->cd.asid;
+		cmd.tlbi.asid = tag->id;
 	else
-		tag->id = smmu_domain->s2_cfg.vmid;
+		cmd.tlbi.vmid = tag->id;
+	arm_smmu_cmdq_issue_cmd_with_sync(tag->smmu, &cmd);
 
-	return 0;
+	if (tag->type == INV_TYPE_S1_ASID)
+		xa_erase(&arm_smmu_asid_xa, tag->id);
+	else if (tag->type == INV_TYPE_S2_VMID)
+		ida_free(&tag->smmu->vmid_map, tag->id);
+
+	/* Keep INV_TYPE_S2_VMID_VSMMU. vSMMU will free it */
 }
 
 static struct arm_smmu_inv *
@@ -3515,26 +3546,6 @@ arm_smmu_install_new_domain_invs(struct arm_smmu_attach_state *state)
 	kfree_rcu(invst->old_invs, rcu);
 }
 
-static void arm_smmu_inv_flush_iotlb_tag(struct arm_smmu_inv *inv)
-{
-	struct arm_smmu_cmdq_ent cmd = {};
-
-	switch (inv->type) {
-	case INV_TYPE_S1_ASID:
-		cmd.tlbi.asid = inv->id;
-		break;
-	case INV_TYPE_S2_VMID:
-		/* S2_VMID using nsize_opcode covers S2_VMID_S1_CLEAR */
-		cmd.tlbi.vmid = inv->id;
-		break;
-	default:
-		return;
-	}
-
-	cmd.opcode = inv->nsize_opcode;
-	arm_smmu_cmdq_issue_cmd_with_sync(inv->smmu, &cmd);
-}
-
 /* Should be installed after arm_smmu_install_ste_for_dev() */
 static void
 arm_smmu_install_old_domain_invs(struct arm_smmu_attach_state *state)
@@ -3556,7 +3567,7 @@ arm_smmu_install_old_domain_invs(struct arm_smmu_attach_state *state)
 	 * array must be left cleared in the IOTLB.
 	 */
 	if (!READ_ONCE(invst->new_invs->inv[0].users))
-		arm_smmu_inv_flush_iotlb_tag(&invst->new_invs->inv[0]);
+		arm_smmu_iotlb_tag_free(&invst->tag);
 
 	new_invs = arm_smmu_invs_purge(old_invs);
 	if (!new_invs)
@@ -3702,6 +3713,8 @@ int arm_smmu_attach_prepare(struct arm_smmu_attach_state *state,
 err_free_vmaster:
 	kfree(state->vmaster);
 err_unprepare_invs:
+	if (!READ_ONCE(state->new_domain_invst.tag.users))
+		arm_smmu_iotlb_tag_free(&state->new_domain_invst.tag);
 	kfree(state->new_domain_invst.new_invs);
 	return ret;
 }
-- 
2.43.0

