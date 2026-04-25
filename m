Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010007.outbound.protection.outlook.com [52.101.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3BA13176EE
	for <iommu@lists.linux.dev>; Sat, 25 Apr 2026 21:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777152721; cv=fail; b=b7b8dLSUrMTKSWnzPXqqy6E2dsit4nQegT6DpfHkuxDTN2OTK6hgcyVsZLO3gJoC6bZouZd+24/uVq2dn5684NrQL5DefrU4hPoHOpC3WS2vlOCzWmVvCpclOhyYbRHol6n3mf//Eru3rZBcq29Vs+lxzWeQYWjwCZNAn3o6Qms=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777152721; c=relaxed/simple;
	bh=s6D/+fFwii8Rq9Lm+48rZS2xmAsvtcDSs2nol5QKnxo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ce8HvFNvTJ7Bc/SiS/8wk3PWH6qGcGmxo/4qlZfpoE40Q9VMnJTGzCJjvAikbejg6qr1A6qUosGKxU7BBOT2KcxpcQX5FZOvNXPPkxSNe8Hy7jQiIwpQ67waYHPFNFPBORZ8IZ0PqcyGBFK6Lw2v4DFosGyUV13UxGCQOtJKbHw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GOSRuAHO; arc=fail smtp.client-ip=52.101.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GOSRuAHO"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MXeL572J2XUKGV2rQkgOuddCs+U+5hpjFg7t3bN+S5SZa9iBbobB9bExHvqXlRNh89DVvs5ZBgzxNaq1Py6adBYTFkav7A+sYbcLU/+Ez3ia2PaVn/9CBGdPt9ltnalFne9ELd4N977DyLk7M+2VguM40hO6z+fbuVezsulycNVh+VBNaAudkkSg57j7QpmuF/b+rplpbF2hNCGQS2boUORuQZioMxX1LSwRs7XtrmllLjlSEeIku6GZue+4wnrtqXs9Ex4J38wWfjfbq6via3M0ytScVvWzeP59W6UOKjymsjLxYF6xfH0uqAKNp70btIBMarhMV3ZFdsnVdGy44A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aEU6gyfczctLJcSMH8Hj+JI5AGbW3f46G9n5nc3iGZ8=;
 b=QNS6yQ3Lntllf32PmRN44bbNvnYoJos9/35vWb+cctaKy2wmNjeC2kx+/PexI8pusYzPjzaYEJO0XyKZFlW4ZB4G0ezQDTkLnc4cVbVkp3aQ8KZ4/PQtnjtAx9AXRVAH/bHjIploX6jdcG2UImtFkeJvRFhh/tDMFkLLPShEwvozIZWMjY0PF4JYP7BKWqxuhHqZRkIAmEJIBccLcHB2/wQUPW5ct8eUSpjAhDy+JJ71393UIrmzNaGwsYOoUkbFrzADESosvUXClNckIVMG90M5bn87JoDcAjeADFEWmHtRRG8dSBofwMl+2+5+m7EOGJPy4Sj0OHINyNfwYoERaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aEU6gyfczctLJcSMH8Hj+JI5AGbW3f46G9n5nc3iGZ8=;
 b=GOSRuAHOtLbl6MMLLqo0JvkBY2+cj20T6Ad3Nefz0/0DzUD0EHvvwX+oRyf8RjFxnwIjfwSMu8LRxpgxiQtfwBJEOfeSzrw9Un9a2CiRtXXyyfDyFtNqSoItBRineayhjez8x6YHlyndBTUc993FL74ZPnsibX9aVBqlImFYqR1joc25aZnxTIr5LTrZgg01ajOTX6YbcZs0fKsub/wZWij89B9AKiDvjd9GnBxawWa6CPXPMkzWbdaWV8a/VVl1oXqTTR24D280zhEOo7IK4ndy3v/tIWfIYcMP1+k7DXnfq++e5WXThboCJuO3fS2wIUcdhfisG3zaTA8Rni4vMw==
Received: from PH7PR17CA0040.namprd17.prod.outlook.com (2603:10b6:510:323::26)
 by PH8PR12MB6721.namprd12.prod.outlook.com (2603:10b6:510:1cc::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.12; Sat, 25 Apr
 2026 21:31:53 +0000
Received: from MW1PEPF0001615A.namprd21.prod.outlook.com
 (2603:10b6:510:323:cafe::bf) by PH7PR17CA0040.outlook.office365.com
 (2603:10b6:510:323::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.24 via Frontend Transport; Sat,
 25 Apr 2026 21:31:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MW1PEPF0001615A.mail.protection.outlook.com (10.167.249.85) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.0 via Frontend Transport; Sat, 25 Apr 2026 21:31:53 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sat, 25 Apr
 2026 14:31:43 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sat, 25 Apr
 2026 14:31:42 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Sat, 25 Apr 2026 14:31:41 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>, <robin.murphy@arm.com>, <jgg@nvidia.com>,
	<kevin.tian@intel.com>
CC: <joro@8bytes.org>, <praan@google.com>, <baolu.lu@linux.intel.com>,
	<miko.lenczewski@arm.com>, <smostafa@google.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>, <jamien@nvidia.com>
Subject: [PATCH rc v3 2/5] iommu/arm-smmu-v3: Implement is_attach_deferred() for kdump
Date: Sat, 25 Apr 2026 14:30:47 -0700
Message-ID: <d278d53df155ef8cba5382b8bd665dba8a296e90.1777150307.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1777150307.git.nicolinc@nvidia.com>
References: <cover.1777150307.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MW1PEPF0001615A:EE_|PH8PR12MB6721:EE_
X-MS-Office365-Filtering-Correlation-Id: 61273386-44a1-4c92-dcb8-08dea3121197
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|36860700016|376014|82310400026|1800799024|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	dpuWB7uaP311k7QKrOubP2CXMvZybdtrhn9PAwU1gzoAaNjtzqDgobwXlEGIoBPIqNZWZVZ/Y28Q6oFnrW2b5PEOJKGB0ig/ev3LtZnbpvf8Iw/rOaauRkh+E3wCBK2r4IYROEC5wGBLfpyGB+G03Exgv58uLAJ4XuERoL3bgKmsR16kmKRBEGWlQQgIPRoEL5FRS+fKVyut3A06h/pC7e6lFFICzQNHFtw9TRWIaPUheGFanOIPULlr71ARcj0DfK9BzXeZq9whSvxRCn4bb0115Sz6WIq9QXwYln8e3is3XAIPQXFCSUBpRZCMMz/OPQ7aiWYcaNdAiCeiT0mSHFbB6/2o1SmFK0wdSTjJiaPdy1ksNEU4VT7JDbGXaL3YKO211/95sUIVvOlZiOvXJb3/KGn2GZQC29BQ/ZpH9kuAl9V9BbWyU/lqFIB9cz3rGGfRD2cddJXlJ84fgeq4Fs1+iKBhioUPa3fGOw2m5ErlLDv1W9vW4Hf+Xf2tq7L5CJzBNe3zF+hUo0VVuz/Ifc8EGaFHLM556/qO73DLnISfFmpSaIQ6H2E+X6jEZoYanVzSqfZ1AsIIJxAZdNB/9+Rr1uyscNdqsT69OU2ok6pbdqbMFwRiZOehQMTSQqBA9BkAPv3cAg3vhqQXY983ToT3WD8oQK3rxTvqnMM29xovedH8JtXwQs7f6uj0pQyHDb6wkdsn3BObwhcXYQgewAAQnl5YNQiAiZ0jHywy7xM+F/Qo4FR66PAccRdaGX8wRtRNn7FPhE7T6jqsgEXfCw==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(36860700016)(376014)(82310400026)(1800799024)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ip9izWcaSySqI1h25rQlMiIaSFMoWp3BGiHdCBWtRLWOmIhTtx6Cmv5qZD6n9sPeGDyijZaZeNeYIiS+JEHHFDetbRWvt+7AKeSw8RjM7Dt5R2QHE8BlsgGTlxO/xlDNtckezYZSbJTFwu799am0mSVdXm32xfvFRuU+W8Dwrw+AS1GdLBJuwGkIJmXKaayN2ZIBWGHi4mxrd+SOVktEaTSU9h9jOoAs4YIsZJC+3h+ZnCSk/z+lbaiFBWk4IvtxgQ5R+Ga1hEQLRBJ66tTZFB0AxJUtnd5uKowxg+xh4aierBRus1I7uIQ6PYn/liydSIFs+gjeWcPE89NyMeGqiqCqCvmHFrNWzYH6eqfsKEAS/fvlU0G5H3wDmJ7Lt04ei5AZnCHhqwnOsJ5UPB+l2gg3r0HkJd9ev0r5rkonYbVAC0kOiRrouaiCx9FcEgsE
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2026 21:31:53.2186
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 61273386-44a1-4c92-dcb8-08dea3121197
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MW1PEPF0001615A.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6721

Though the kdump kernel adopts the crashed kernel's stream table, the iommu
core will still try to attach each probed device to a default domain, which
overwrites the adopted STE and breaks in-flight DMA from that device.

Implement an is_attach_deferred() callback to prevent this. For each device
that has STE.V=1 and STE.Cfg!=Abort in the adopted table, defer the default
domain attachment, until the device driver explicitly requests it.

Fixes: b63b3439b856 ("iommu/arm-smmu-v3: Abort all transactions if SMMU is enabled in kdump kernel")
Cc: stable@vger.kernel.org # v6.12+
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 24 +++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index bf292e1e0c323..8423bcc4be69e 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -4213,6 +4213,29 @@ static void arm_smmu_remove_master(struct arm_smmu_master *master)
 	kfree(master->build_invs);
 }
 
+static bool arm_smmu_is_attach_deferred(struct device *dev)
+{
+	struct arm_smmu_master *master = dev_iommu_priv_get(dev);
+	struct arm_smmu_device *smmu = master->smmu;
+	int i;
+
+	if (!(smmu->options & ARM_SMMU_OPT_KDUMP_ADOPT))
+		return false;
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
+
 static struct iommu_device *arm_smmu_probe_device(struct device *dev)
 {
 	int ret;
@@ -4375,6 +4398,7 @@ static const struct iommu_ops arm_smmu_ops = {
 	.hw_info		= arm_smmu_hw_info,
 	.domain_alloc_sva       = arm_smmu_sva_domain_alloc,
 	.domain_alloc_paging_flags = arm_smmu_domain_alloc_paging_flags,
+	.is_attach_deferred	= arm_smmu_is_attach_deferred,
 	.probe_device		= arm_smmu_probe_device,
 	.release_device		= arm_smmu_release_device,
 	.device_group		= arm_smmu_device_group,
-- 
2.43.0

