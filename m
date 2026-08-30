Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010011.outbound.protection.outlook.com [52.101.85.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33E3C357D19
	for <iommu@lists.linux.dev>; Sun, 30 Aug 2026 23:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788131937; cv=fail; b=triVZqLMo/+PAcqs5wue2r3VYpqZLmYAVLm5yPDC3sODqEeQFwEJ2LPZ9h9oFxIbwNc0mq3FI4RqUfncnoH6v2OGLFYWXeyP3i8aZcPJcO8K2LOd1pAHB+pTkuPw7TjH1kdxc8TXcFwdtkqsNCPkFOTtGeVCllgyPBMAXD2ZCq4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788131937; c=relaxed/simple;
	bh=y9jKrPJi3Xih2e+lJ53o9LPtWVWrXloT3GZgy5HU3fM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UdLiiw4vua5eTfE4WYBcR51L2zY8AUT9zdNozS67A6pi+/KU70FST9gmQ/RhYNtXfAfAsjZpoBSgUzi1IlyuJSyq9kP/b9DHdGIjcz0M5OicpOhc48lRTL8RCzrnzwp9aE4GxPcDb4CAPLncwPezCG+yFaCg5rBkiP2JXHsvgCM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=J4UVxIQt; arc=fail smtp.client-ip=52.101.85.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="J4UVxIQt"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xqo9GVt9droO1h7jsfL3gBvbxxprS+eFuwcKv9s03IN7ihtrgNJxuTXharpfv0BpW7hbK1BA7HZEnn+eZMJ/6B6i+uR6/fdm8Tkk6hJWWlubRh2bp7EaqjVpVYfW2XR2vPsaL211YhRhEsLAhxm3RfcZGfMbUvZCaQija7ylKzK6dIhibQOOHPPYVyyeTdgutm8UAFt5oB8Nad8ODxrgnMFDmxCGyUYmJP7y1+XakREhTGPtgVz+KQveY2T9eN/w3RYnj5NjEmuLHRRV8MrRaT8d0Ot7m0S2o464w6fhSKmDW4dW8+4SpwJ71u3XkqWHxLZdUaqXCKwOxPNNagXfYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9wc9+FPzY1QyYgey9eBCJosSGHylvjhHar2cXy0T15E=;
 b=TyFfEQHrHZkJzX0LdWasCFvFh/2SrWDMCcBb7SsWnW0yn+e911Kb1/AhVNJ7nzRfPVrg1cOWb2StNCFgCHAjUPhhlyn32i+3/nQZzdBWnaGxKYBXw2I0zFojg3bjr81PGgkkrdBsQtPI96DVLBJXJxDczuigPz7CqVsAUYqOZ3BMFfDRBAu3FOCHQ87Vc1Dp9N35CrhxQgVJ4S5FtoZ8/7CRJQRLhQKiThvRvs7XDUJCUJZZCLGCS2fcpTbXvtqVpH3Ga6FGWmeokEwtvbCND+5XTwSSHVBqpaL2fVqIZXdmOpChSKkEE55R5T7JpWea/hZi/8O438kxxT517ytVuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9wc9+FPzY1QyYgey9eBCJosSGHylvjhHar2cXy0T15E=;
 b=J4UVxIQt2UCNbvX1N6s7izkdc8KpZ+6RglHZCZqP5qIoeC6+vzjT+GkHaU5k1JbEItLUrzF18jxVWCM0JCfCC4EUxs0oYmP8y9kxDuMZ+Ya26R0klCY4eU+um+3iUc8aVdIZ4Eu5EWiLX0ne3DBFn0K/b7WkTzIy2WftQpqg+DXje2+5ux42lqMY2rXXfdkb++HJFnG+St9gZbByBE+nJlfUN32KqWZVWfqpxEvmJ08BIkUy7XNVgFmbDx08Cd7kwuahak7ZTOBVUEZf74lx5VUIyBV2wMNlUaypDDqx90HQwp7uq2ujbA9gwqgrttizqweXniaDNh/AwQ3JPf/Agw==
Received: from CH0PR04CA0111.namprd04.prod.outlook.com (2603:10b6:610:75::26)
 by DM4PR12MB5964.namprd12.prod.outlook.com (2603:10b6:8:6b::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.13; Sun, 30 Aug 2026 23:18:48 +0000
Received: from DS3PEPF0000C37E.namprd04.prod.outlook.com
 (2603:10b6:610:75:cafe::77) by CH0PR04CA0111.outlook.office365.com
 (2603:10b6:610:75::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.13 via Frontend Transport; Sun,
 30 Aug 2026 23:18:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 DS3PEPF0000C37E.mail.protection.outlook.com (10.167.23.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Sun, 30 Aug 2026 23:18:47 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Sun, 30 Aug
 2026 16:18:38 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Sun, 30 Aug 2026 16:18:37 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Sun, 30 Aug 2026 16:18:37 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>, <robin.murphy@arm.com>, <jgg@nvidia.com>
CC: <joro@8bytes.org>, <praan@google.com>, <kevin.tian@intel.com>,
	<smostafa@google.com>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>, <jamien@nvidia.com>,
	<kas@kernel.org>
Subject: [PATCH v10 07/13] iommu/arm-smmu-v3-kexec: Add a CD table parse helper
Date: Sun, 30 Aug 2026 16:18:08 -0700
Message-ID: <ade622c5c82913442d090aec251b5662b021b129.1788130528.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37E:EE_|DM4PR12MB5964:EE_
X-MS-Office365-Filtering-Correlation-Id: 0561a06e-85f1-480d-e1a3-08df06ed0b1c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|36860700016|376014|82310400026|7416014|1800799024|10067099003|11063799006|6133799003|5023799004|56012099006|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	9s0B+BJ1P4V3UhI3NkSw6qGur3/Nu0dzVF0/6ABr99IZ/4MmB5Gh0WRSvauiqH92wMz/TD1I7JIeQF8HO6Zr2lLb1CFQL/TmcA1qpdEfU1LbG3daOuZGHtLfXGVvE+irmgbDmMBwHCoN3T/mtXwIXzvIlGXY8be1osPIhzMbviK5yJYVIVNIb0+LdttNhIoehSP+7almwlYb4SAzKSAiJre23iLdy3IuXV4qysw6dXPotrEyRND1eRIoXywLKMvLzQoPVgMKWl46giqG3VjYnXolyVB8Ll8lHKVtewIk8M9nTdNR1+/LybRbV20CjekXLTMWzAwRz7N/1V6ywUBowANP4uF8VZd+ZImAml7v4Di9eBL88oHP2cRO7bGGNu//xg84vxy3txLNEF5KnxxMGNkxeEX46FLUkjPJBI2TAdhKSs6c4sjwk+pZWfv0D/ltS8y3bBi/VjfurN9hTYgd3tKRywdBhwklqL3aR2pU/rsKT//mVZd8iLN9xveOsaPHY7jhShxFVM818HmicjNoP1QRcGwowK93GcQuYA+Rhttubt1hFJUTNklIjnCCVQHfOG0bqZ7nUHJnHigjyPboWJyCiUvMw77YO6jih0oRkc4QReyhIozpPoIRsF1yyO1QmtRuhi+HxJ4wKsokBGPG8QeC9V9/PDuScz00gRipDMq8D555V/ejA7sY931dE2ee3GU7nNYBTOY2a3moBAXn3A==
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(36860700016)(376014)(82310400026)(7416014)(1800799024)(10067099003)(11063799006)(6133799003)(5023799004)(56012099006)(18002099003)(22082099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	RzszFFD8DipqtSdGIuAGcG+bCcO3BGuPUZkccs6mTHbjGBaMo6nayYvuik0RENgLd1qsOAMATqyHmDlcgo0/NkG4PQ2r8fNbWsovlTv8XLE+1uy5zUVVdQFLjTXzOr5wNjjQpIvuqMvCVm8lpxNgS5WNX6LQCf+2sbFDd504QlkljEzSowXEJ1WJykfw5K/5W7aiksJyxyeJrkt7+uLDXVqOeHRpE9pfbU6I8O37or7fk0X/kp5GseFia12GbHcQv2mNkMZKGIsp8HqhlqH+nweoRg7z/IeU65kU9j8Q6FEvZrZGTGMHnVCF3EQeeGJHJrZbsSke8lZs9lXhaukLFNeRJ6yGbuu81kt4Ng+ckfTxhmfokcbs8qGMuStXV6A2sGwEsPjEf+yxPPG7mLx6wR7bI3uNsuNyS83d5xnE+cwhG146++1qTx7kX8T63wz2
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2026 23:18:47.2399
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0561a06e-85f1-480d-e1a3-08df06ed0b1c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF0000C37E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5964

An S1 STE points to a CD table that both of the kexec flavors decode: the
kdump adoption scans the CD table to reserve all the in-use ASIDs, and the
live-update restoration claims the CD table via the KHO restore API.

Add another read-only helper to the arm-smmu-v3-kexec.c:
 - arm_smmu_kexec_check_ste_cdtab()

It validates the CD table geometry in an S1 STE against this kernel's own
ssid_bits and the 2-level HW capability. And it accepts a linear CD table
on the 2-level capable HW too, since a previous kernel might have used one,
like the linear stream table.

The CD table base gets validated against the table size as well, since the
spec aligns a CD table to its own size, where an unaligned base would be a
CONSTRAINED UNPREDICTABLE case: HW may zero its low bits or may fetch any
CD in the table, so a scan reading such a base could miss the CDs in use.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Assisted-by: Claude:claude-fable-5
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  3 +
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-kexec.c | 57 +++++++++++++++++++
 2 files changed, 60 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 41d7a907b9ba2..1bcf6cb2ebb3c 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -1261,6 +1261,9 @@ int arm_smmu_kexec_parse_strtab_linear(struct arm_smmu_device *smmu,
 int arm_smmu_kexec_check_strtab_l1_desc(struct arm_smmu_device *smmu,
 					u64 l1_desc, u32 idx,
 					phys_addr_t *l2_base);
+int arm_smmu_kexec_check_ste_cdtab(struct arm_smmu_device *smmu, u64 ste0,
+				   phys_addr_t *cdtab, u32 *s1fmt,
+				   u32 *max_contexts);
 #endif /* CONFIG_ARM_SMMU_V3_KEXEC */
 
 #ifdef CONFIG_CRASH_DUMP
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-kexec.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-kexec.c
index b15e23df11b6d..700f63c7972e9 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-kexec.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-kexec.c
@@ -164,3 +164,60 @@ int arm_smmu_kexec_check_strtab_l1_desc(struct arm_smmu_device *smmu,
 	*l2_base = base;
 	return 0;
 }
+
+/**
+ * arm_smmu_kexec_check_ste_cdtab() - Decode the CD table geometry of an STE
+ * @smmu: SMMU device of this kernel
+ * @ste0: first 64 bits of the previous kernel's S1 STE
+ * @cdtab: pointer to return the CD table's physical address
+ * @s1fmt: pointer to return the CD table format
+ * @max_contexts: pointer to return the number of CDs
+ *
+ * Note that a linear CD table on the 2-level capable hardware is accepted, as a
+ * previous kernel might have used one, like the linear stream table.
+ *
+ * Note that the spec requires a CD table to be aligned to its own size, so an
+ * unaligned @cdtab gets rejected here: HW may then zero the low bits or fetch
+ * any CD in the table, leaving the live ASIDs unknowable to this scan.
+ *
+ * Return: 0 on success with the three outputs set, or -EINVAL on a bad geometry
+ */
+int arm_smmu_kexec_check_ste_cdtab(struct arm_smmu_device *smmu, u64 ste0,
+				   phys_addr_t *cdtab, u32 *s1fmt,
+				   u32 *max_contexts)
+{
+	phys_addr_t base = ste0 & STRTAB_STE_0_S1CTXPTR_MASK;
+	u32 s1cdmax = FIELD_GET(STRTAB_STE_0_S1CDMAX, ste0);
+	u32 fmt = FIELD_GET(STRTAB_STE_0_S1FMT, ste0);
+	size_t size;
+
+	if (!base || s1cdmax > smmu->ssid_bits)
+		return -EINVAL;
+
+	if (fmt != STRTAB_STE_0_S1FMT_LINEAR &&
+	    fmt != STRTAB_STE_0_S1FMT_64K_L2)
+		return -EINVAL;
+
+	/* Both kernels run on the same HW, so a genuine STE never has this */
+	if (fmt == STRTAB_STE_0_S1FMT_64K_L2 &&
+	    !(smmu->features & ARM_SMMU_FEAT_2_LVL_CDTAB))
+		return -EINVAL;
+
+	if (fmt == STRTAB_STE_0_S1FMT_LINEAR)
+		size = (1UL << s1cdmax) * sizeof(struct arm_smmu_cd);
+	else
+		size = DIV_ROUND_UP(1UL << s1cdmax, CTXDESC_L2_ENTRIES) *
+		       sizeof(struct arm_smmu_cdtab_l1);
+
+	/*
+	 * An unaligned base is CONSTRAINED UNPREDICTABLE: HW may zero the low
+	 * bits or fetch any CD in the table, so live ASIDs become unknowable.
+	 */
+	if (!IS_ALIGNED(base, size))
+		return -EINVAL;
+
+	*cdtab = base;
+	*s1fmt = fmt;
+	*max_contexts = 1U << s1cdmax;
+	return 0;
+}
-- 
2.43.0

