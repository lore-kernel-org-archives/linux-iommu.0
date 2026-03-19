Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011002.outbound.protection.outlook.com [52.101.62.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EA9F34C81F
	for <iommu@lists.linux.dev>; Thu, 19 Mar 2026 19:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773949951; cv=fail; b=QicqIU6WFo5zMkRQhJRzi0jl5a2uGa9/Ir6rtDdNAL0OnkbZivYHsZzuVP8O9qJ1zsZvM04n6JAz0dr2iszMqLLlXtstXcIKTMGukDlhQLOkd4rY6l4Qhx5+66rZL5K04QIofUiQqzr5fRtzfWy6bB7QHB5P+TjmeyssJDjk+bo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773949951; c=relaxed/simple;
	bh=UcC938qlrwahYxP4uvr3ijaeZTcLSa2/pjhk5zuvOkc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VayJF/+sEptBQRkabtcTgvp6EmbUYqbo511hn79CQdyo1EQTEwsc+XpZE7JC6/KH3p7SogqDLQPJ3jOy3GEIUywWxhFUEeKDDt4P8QVpqDE9Li2QbLYOUwfBzeMbJk7SX5nNynPG9D2viqp0oVoWyj9jIk1VmvDAhia5WwJS3ns=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YkYagz47; arc=fail smtp.client-ip=52.101.62.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YkYagz47"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EViO+zp4hXb2vAuuGj4NhBw8a0Ig6ERI/c3OlMPVC6ZmoJN+qFIowAd5OeOoVSKHHP6hldmoRk3LqC4n7STHRyzJi+SxO5WogTLkEDz1WqtOa0H5bhoTiSXM6WdHAs9hX5ocU46w9/HF7f4mcqrHcyzZfpX700pEvqpCYep/2IgohuouaNThrALYEPfs+il2zOb6c+lZHoWloI8/BJ/2oQUIbsUImNzXHpH7od24Pih3yJ5S1PBzCBAM5XHq+jc4bATGT3KHFw1rQbLpcj+1YWk7nIAJPCwiC30QyzhD5naZAzyPJd60wIoiCObVJhHd0+P4TKfDLb8OCIg9+JUiXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FVxYzDixrnAy2cbZcV66acdFkjOVeUDelFI+iHvg0X4=;
 b=i7Fj1wCbXjsrMlJvHuKkuJdqgUSjFaFeHUG99APNtyeflje5SYxmFxd/T2sf7Pbxd/klOyysWd/cBffZ91e3+DaUfeO5Dr7KROQEA2he3tJoizFtaaBNDzYYnkBvz3B51zMWqh3XvJtGTkeP5uWCEyt27gaT1dnEHRcYTCjI3TF/t/giL1/49quIPg+HFuHLA/1UvAtN1Jto226s3n43ZoAHMkMYAlVlwSYNzy+XvA4aG4zrY318vN570nnoL7OfU0fjUYzTwSbIZslNXohK7Q1UlXvjnTKabAKQz7nSbxx1T4XyPQ24rK74ppjDDyBhGwdI5YhWBHIKrlCNvEBHZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FVxYzDixrnAy2cbZcV66acdFkjOVeUDelFI+iHvg0X4=;
 b=YkYagz47NI8lgxgUu0si4agQNezntzvtPhltSO3FYRxydIp0x0UWkjhst7jOzEtA9Sz5sYTPboWssWLOTp0hmZB9ZbzFmXswixaqot7B/6EapPGLQ1mDAc8iMPqaJXo02eNMReaEl2C6PAlxzNJ8P/PpL/WJi/E/k/gy4i90Dm/Mdek+25MusgSrl2rpgOFDj260wz3FGNgR0UHEaI0njKFb1ToveporBUow/ahIjses4cs+Jad/fKeP7a+rpgwBW6wVjFjdJ8OthQY/2BoSRtZI/UuZeEZ4aR5Ozz/aRZh2zX2xWu/eP7zqlVN6OO/57/Guk2Gj1iBK33++nk7vKA==
Received: from BY5PR03CA0012.namprd03.prod.outlook.com (2603:10b6:a03:1e0::22)
 by IA0PR12MB8088.namprd12.prod.outlook.com (2603:10b6:208:409::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.10; Thu, 19 Mar
 2026 19:52:26 +0000
Received: from SJ5PEPF000001C9.namprd05.prod.outlook.com
 (2603:10b6:a03:1e0:cafe::3c) by BY5PR03CA0012.outlook.office365.com
 (2603:10b6:a03:1e0::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.27 via Frontend Transport; Thu,
 19 Mar 2026 19:52:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ5PEPF000001C9.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Thu, 19 Mar 2026 19:52:25 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 19 Mar
 2026 12:52:08 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 19 Mar
 2026 12:52:08 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Thu, 19 Mar 2026 12:52:07 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>, <jgg@nvidia.com>
CC: <robin.murphy@arm.com>, <joro@8bytes.org>, <jpb@kernel.org>,
	<praan@google.com>, <smostafa@google.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
	<jonathan.cameron@huawei.com>
Subject: [PATCH v4 04/10] iommu/arm-smmu-v3: Pass in IOTLB cache tag to arm_smmu_master_build_invs()
Date: Thu, 19 Mar 2026 12:51:50 -0700
Message-ID: <87419a1f7371643959a037f1ee7119ffa054a9a1.1773949042.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001C9:EE_|IA0PR12MB8088:EE_
X-MS-Office365-Filtering-Correlation-Id: 9662b7e4-a5a4-464e-1eef-08de85f10b74
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700016|1800799024|82310400026|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	Oho8FZyPTQ9WUkU+zMQC3hx/5HG0PI6KAWMyyZk0Wk1zQ4S2gER5HZAhYTY26vZbLkm6NF+X4JE0wGrege7lhuh9JZ2W+JJXQLDzgisSeSsBNqHPUuBUQ/jvjV7F7J2KK0yUIqfe5x/3xCH9gTfV+BR19FcW64aH7GmZFu/2CixBXmq0wcBxNnsbAmNzwySbaaZkQjmUwWI8qs9D7gmLrCJAzhc0qzFY610XJv1BjzDJOT1Hjhksz4Vp0UQ+nPKCG8atWeZTvxlbS+wbM4a5f9HLmxUy/cdaxBtUPDtoUrd5WNitYStlYyH/qZNiejUHLNbEKYFYRbBfNI5Pf8dqxczTGEajoGShCr9pp5ZnA7BByRRcaBIqO8quE8ADDxreB+Ha0S/F2WIEpfoudbrN2IFHKpwigKVjkWJfSCdq7IYPu61aMwqMm1Xsgz29QT1+zr356g3U1e53KWmEdX53PZ7ub+gB5b3RADQscFSbH23YaW/EUy2QFvv5jg0h/MTJJjGD2wkZtXt1kX2BfK6bC+EQ4KhBK7axbWrQbvK85eAusUiEGgLzgeEHffo1Rn+rCE3EmpWUFY6Gpy5FMQQzUYI52op43Rtog2t9qqO2Iprishmys28/jw+NpJrzwGd22/HxPGT9OcbnkdyNAOaVvIUyOlHYX7DcmWs1Z/jIFtG0hQh0QKYlNwie8TwmjDTuGHSaq0QbPVK6yhMB0lBaJSzl3t9uWysPWFU3lBtjLo+LtF625tS7VIP1uwdi34zn6zk1qULz9/Z1Nu7+OFByKw==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700016)(1800799024)(82310400026)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	GB6n7ShiH2Mi25os5yhLa+Y+7Qt3BYJHIAEYAhH9CmETTu7A/t7B2E9n3JXyd9W/FskWEn5lNrQdscHoJgxYSWUhfSwRcTL+f91FBGSDNcMoYvPLAn54v2MWM2keYT63+Ijt+uClLMQr67e2utPY1lgtXPnxR2OfTGl9wzebzJUthfiSRHU4ga4k/SaArHp8GU4Z9Fyx5o0TVoUrQyb3OZChZB7PTHv5t7VgDGgOUb82ignJ/3F/RpK6xNOtLR2n6zx6rABnJMgd/GX8obL5313zm3ypWP0MV4J9OoaszdAWOtQJDfis9Yoz5nJ2nIvmaUrmm8TtfaZ2Lc7q35Q4Cdw5rA8pGG6rBiseGRD2pFoo6F/yN3g5Hpm1ySFh9+d/9jmKYadYH6Wz4nZVusAimuJYQFQR+WYQNByX9jOO5j+2rC30r+K0pzpC1LDEahXc
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2026 19:52:25.7692
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9662b7e4-a5a4-464e-1eef-08de85f10b74
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001C9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8088

Now struct arm_smmu_attach_state carrys an IOTLB cache tag in invst->tag.

Instead of getting the tag from smmu_domain again, pass in the invst->tag
to arm_smmu_master_build_invs(). This could simplify the function.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 37 ++++++++-------------
 1 file changed, 13 insertions(+), 24 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 29b1310786244..9c23beb8a2545 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -3335,7 +3335,8 @@ arm_smmu_master_build_inv(struct arm_smmu_master *master,
  */
 static struct arm_smmu_invs *
 arm_smmu_master_build_invs(struct arm_smmu_master *master, bool ats_enabled,
-			   ioasid_t ssid, struct arm_smmu_domain *smmu_domain)
+			   ioasid_t ssid, struct arm_smmu_domain *smmu_domain,
+			   struct arm_smmu_inv *tag)
 {
 	const bool nesting = smmu_domain->nest_parent;
 	size_t pgsize = 0, i;
@@ -3348,30 +3349,15 @@ arm_smmu_master_build_invs(struct arm_smmu_master *master, bool ats_enabled,
 	if (master->smmu->features & ARM_SMMU_FEAT_RANGE_INV)
 		pgsize = __ffs(smmu_domain->domain.pgsize_bitmap);
 
-	switch (smmu_domain->stage) {
-	case ARM_SMMU_DOMAIN_SVA:
-	case ARM_SMMU_DOMAIN_S1:
-		if (!arm_smmu_master_build_inv(master, INV_TYPE_S1_ASID,
-					       smmu_domain->cd.asid,
-					       IOMMU_NO_PASID, pgsize))
-			return NULL;
-		break;
-	case ARM_SMMU_DOMAIN_S2:
-		if (!arm_smmu_master_build_inv(master, INV_TYPE_S2_VMID,
-					       smmu_domain->s2_cfg.vmid,
-					       IOMMU_NO_PASID, pgsize))
-			return NULL;
-		break;
-	default:
-		WARN_ON(true);
+	if (!arm_smmu_master_build_inv(master, tag->type, tag->id,
+				       IOMMU_NO_PASID, pgsize))
 		return NULL;
-	}
 
 	/* All the nested S1 ASIDs have to be flushed when S2 parent changes */
 	if (nesting) {
-		if (!arm_smmu_master_build_inv(
-			    master, INV_TYPE_S2_VMID_S1_CLEAR,
-			    smmu_domain->s2_cfg.vmid, IOMMU_NO_PASID, 0))
+		if (!arm_smmu_master_build_inv(master,
+					       INV_TYPE_S2_VMID_S1_CLEAR,
+					       tag->id, IOMMU_NO_PASID, 0))
 			return NULL;
 	}
 
@@ -3462,8 +3448,10 @@ static int arm_smmu_attach_prepare_invs(struct arm_smmu_attach_state *state,
 		if (ret)
 			return ret;
 
-		build_invs = arm_smmu_master_build_invs(
-			master, state->ats_enabled, ssid, new_smmu_domain);
+		build_invs = arm_smmu_master_build_invs(master,
+							state->ats_enabled,
+							ssid, new_smmu_domain,
+							&invst->tag);
 		if (!build_invs)
 			return -EINVAL;
 
@@ -3492,7 +3480,8 @@ static int arm_smmu_attach_prepare_invs(struct arm_smmu_attach_state *state,
 
 		/* For old_smmu_domain, new_invs points to master->build_invs */
 		invst->new_invs = arm_smmu_master_build_invs(
-			master, master->ats_enabled, ssid, old_smmu_domain);
+			master, master->ats_enabled, ssid, old_smmu_domain,
+			&invst->tag);
 	}
 
 	return 0;
-- 
2.43.0

