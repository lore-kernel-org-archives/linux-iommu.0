Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012036.outbound.protection.outlook.com [40.107.209.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6FEA46EC68
	for <iommu@lists.linux.dev>; Tue, 21 Jul 2026 19:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784663354; cv=fail; b=nXIx0g3NqNqozfGgZoUKB+qhONmPYX64mgnOfj8kyrZOROn8JxTOJfuSeT1sNsHY5gX7O1sPmYBHWsZvFgMYZBAYw/gX9thKDUaEB6hSqIl+JZHCFHrz/lFT5HTIQM29hMA1Cu30MfPwkKZdafoK4nwuw0e2NpbBmIXrH+/AiJ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784663354; c=relaxed/simple;
	bh=835Lkyo+MHF72rc63MjWw58AsNuy8pUgvx9Z8I0fglA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C26IpaFiyRe9Wl7UeGY0DjZ9fqqONQUy32kUlkREKB6p7pfV3UL3nID9jr8E2SvqPM4Vr2LhL+qUau4KB3WHH6RnZ0DKYUxJA1pub4lqYyXpmT8VTP5hM82T/443V2s3vFVOXc2zyneM4SF9I8viWU7Xsle77JGH6iMsoC2dquE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=E8uak/HX; arc=fail smtp.client-ip=40.107.209.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="E8uak/HX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CLa5fGmMrlKn0yv7ofrIzY7BblREu9pa9P9uZ2yDzQK/r4ou9fY5XyoThFaALVIp+XFJbkkfWQ/lkfjqvWzPFfN3ePAt80F6P27/DN5c9yGO1z9mHBvYfj9Kc8hhB/bX/Lgv+twoF3Z/Wsj75Jrch2y41XbXZmOXLwf46F4F8KhMLaXe79YYLZd89McmHrfVLk//+bdlRPRdLyBFHLnbiafK1JNZNJW+YiuQVFSr/cDScHchMFs5q7HTv84XYcTD47Woj3oLNvFzFJAZBFJX2eFg9xT/eI+KMXHn622PpXumQWQV9LmgJQfqNNLn5HWCc8pmY7QtY1Z15EFXfCLriw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yVy+yX/ubX8hOdAfXkTta1FxAkjsEQOIqE+K3yToyoo=;
 b=NkLsu1s3wHSCHJ+xigF0yfx3yyF6pu1m6/hxp21QkHNi323WtzYDYGlbG4l3NNm2EgIdSUFOamozhGxhomLCx0yz7VTsu0s5F61E1hPv7E1TbWc5vINx4apYNXmH+UkgpwEaTjOTTYJwK69JXgEMD/UjjXSIBaSqe+pCJS/O06fObsayfDNJ2+radHF/Sdw5iGvsb2MVqZdDLk0Cknu5VmPk0j5Oa/mM2FHOex5RjMsfmbGsdfgniu9SIjA3Sk0OKFMdXxFsPzcmwhnqQB2y9iRDoCWJOmQNViyshXs4Ux0l9Z5Mvnsu3DFOyCyclyciDY8j++Oi/ZP/IAYG4gI1WA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yVy+yX/ubX8hOdAfXkTta1FxAkjsEQOIqE+K3yToyoo=;
 b=E8uak/HX74YujJisezTyO1frPkG+mBJolhpZaOY6+3SVSu7iUldVd13+0Loneb9zBKBPtHodRxqXqUY4F+FEhTxNswadsujksrE5DrScrW681uijVntacvd7BEHhiqrm8VFpRSYzQyPQDZt5eodQg4tUFEbvbzqJ0vOwhviFUOAT9FrhA2ZOmjv/oadhGSyfr+kUOVhWG6CSA0VZyGQsVPEi0J3OEfu7mfuziHuCbP4viHqPkaPeTjfS8/E7FCk+QlZAcHb2b2RZ68S9R1PbH3rJRa1oUi9cOAWcj06oi5VAeRc7dJ10YXGozHpbFS/PF+Xe/3mBfUcLvYa0Cb4hDg==
Received: from MW4PR03CA0019.namprd03.prod.outlook.com (2603:10b6:303:8f::24)
 by SJ1PR12MB6170.namprd12.prod.outlook.com (2603:10b6:a03:45b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Tue, 21 Jul
 2026 19:49:05 +0000
Received: from SJ1PEPF000023D8.namprd21.prod.outlook.com
 (2603:10b6:303:8f:cafe::37) by MW4PR03CA0019.outlook.office365.com
 (2603:10b6:303:8f::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.16 via Frontend Transport; Tue,
 21 Jul 2026 19:49:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF000023D8.mail.protection.outlook.com (10.167.244.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.0 via Frontend Transport; Tue, 21 Jul 2026 19:49:04 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 21 Jul
 2026 12:48:41 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 21 Jul
 2026 12:48:40 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Tue, 21 Jul 2026 12:48:40 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>, <robin.murphy@arm.com>, <jgg@nvidia.com>
CC: <joro@8bytes.org>, <praan@google.com>, <kevin.tian@intel.com>,
	<smostafa@google.com>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>, <jamien@nvidia.com>
Subject: [PATCH v9 06/12] iommu/arm-smmu-v3-kexec: Add a CD table parse helper
Date: Tue, 21 Jul 2026 12:48:15 -0700
Message-ID: <dc0d53df95a890ce95399a0e799160da41fa1551.1784663184.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D8:EE_|SJ1PR12MB6170:EE_
X-MS-Office365-Filtering-Correlation-Id: 5777252d-afc2-4626-67c6-08dee7611eea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|23010399003|82310400026|36860700016|6133799003|22082099003|18002099003|3023799007|56012099006|11063799006|5023799004|10067099003;
X-Microsoft-Antispam-Message-Info:
	KRaKwiVu8nJTwGfvcKQpQoyKxfbb8o/vM4Te1+yRJVBbY9tTA4XdrjHmd7gBCSY+u/wvg9bBt8B2/YYebsBUMrETRHunx6O6HbiKsHym2vxZYyfBOGI/6IXF3k++yjY6bSmHjjXUOIMB+5iWmM4hrb6AUpLtHRIfUEy/Cb/WirJOmgqr9rLajwA3Ncf1PQkJ0dUhAlt5ZfiANV+V2DP88Ce4Zcwl7wGxDPXWL3kD5yuaLmM/xnSrY/VDVj7dhzcwQqG9mqBP7bRMJb2ZkrklJtoBoCj4OIKd/hOJoIEWHd9NrmFTgkEQaHdYvW3qdDGCqOsGVxxRa6gib1YfEjHfjYtwNyTbS8MZhq8RF3kqTnUhtysrnpBeCTlpy4OYGRwLQLN8mNh4q3VY0LgIcICR1bUMfqvj5d+CbvenKrgG9RowLhsj4CaYKH7GrPuSeY7FadkdRZqenChpB/HYNHhF/UMiMMNRRY9ijeYOphkDliajuU4KhqQJSChbEciz0z7/956U6GE0nA+FyBcple5TQwHk5agAmy+bf+m+mWWsaUnUe1c1Q9mPWDJmY1qlpZqKrxEgxu7dDACrTdxS7CZIEhyeVhVHgilvnZYt2BKeYIOPvItRbhm26iII/JUH6njUjXEREMdtdjZthoTAvTwuQYKXHZACb/j4EpIP5CaelPaBpa+bD2uh1AYy6BcE1ecySw7aRQ+aDw2rNye1OuKEbQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(82310400026)(36860700016)(6133799003)(22082099003)(18002099003)(3023799007)(56012099006)(11063799006)(5023799004)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	/KRny7zZIkO+5F3iKYwJzzsjGPJF40ZwkbmXX6m8rtEuVZqpMQJLF+uZ317nIO05PEtLqRbfF3n4TXTQpJd6AUtRXfuAEJ877MpuUNb66mGcsJaLrxu9qjy4XFgdnheg6/1S7z7XDOvbcbe7AIdpDtJ0ytvl02uNnYJtcyhuXenBapYzeQYHVyHv13yOb1VYdg7LAkwEpIQW2FcqVOyC75ZXLLsbHcdnhSwp36GrGqne8SPqzm9yuYFurmiBcN5SnX9kmlDx6CG19zSeeDQEa3JcUk7iSdx89iMUtMi/UOQrl7SDq8Qp2BLr8p7aQ1VRnM8oYl41q2vb9DHliLXo/Zkth2MVuAgcqB5cl5UwKxHnAPKhsyJb/rhtlV9snwo/ULNMTUfCcB6dy+f79XNFIeoOPEy9I1Xl5YcE/fJlilpe0lOh37VWimxOI4Dj7ifF
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2026 19:49:04.8409
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5777252d-afc2-4626-67c6-08dee7611eea
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D8.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6170

An S1 STE points to a CD table that both of the kexec flavors decode: the
kdump adoption scans the CD table to reserve all the in-use ASIDs, and the
live-update restoration claims the CD table via the KHO restore API.

Add another read-only helper to the arm-smmu-v3-kexec.c:
 - arm_smmu_kexec_check_ste_cdtab()

It validates the CD table geometry in an S1 STE against this kernel's own
ssid_bits and the 2-level HW capability. And it accepts a linear CD table
on the 2-level capable HW too, since a previous kernel might have used one,
like the linear stream table.

Assisted-by: Claude:claude-fable-5
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  3 ++
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-kexec.c | 42 +++++++++++++++++++
 2 files changed, 45 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 6ef307335d80c..183c617ecb273 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -1249,6 +1249,9 @@ int arm_smmu_kexec_parse_strtab_linear(struct arm_smmu_device *smmu,
 int arm_smmu_kexec_check_strtab_l1_desc(struct arm_smmu_device *smmu,
 					u64 l1_desc, u32 idx,
 					phys_addr_t *l2_base);
+int arm_smmu_kexec_check_ste_cdtab(struct arm_smmu_device *smmu, u64 ste0,
+				   phys_addr_t *cdtab, u32 *s1fmt,
+				   u32 *max_contexts);
 #endif /* CONFIG_ARM_SMMU_V3_KEXEC */
 
 #ifdef CONFIG_CRASH_DUMP
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-kexec.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-kexec.c
index 5346132529427..5ad1fe1922eec 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-kexec.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-kexec.c
@@ -157,3 +157,45 @@ int arm_smmu_kexec_check_strtab_l1_desc(struct arm_smmu_device *smmu,
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
+ * Also, as the CD tables are supposed to be read-only, @cdtab is not validated
+ * against the table size, but only carries the field's own 64-byte alignment.
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
+	*cdtab = base;
+	*s1fmt = fmt;
+	*max_contexts = 1U << s1cdmax;
+	return 0;
+}
-- 
2.43.0

