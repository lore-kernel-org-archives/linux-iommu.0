Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010061.outbound.protection.outlook.com [52.101.85.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25C0646E005
	for <iommu@lists.linux.dev>; Tue, 21 Jul 2026 19:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784663355; cv=fail; b=XUwJyEPXbpuM0HyB6+NbFIEJAlSRdVpZnuuFJqL5ki50wwSJaVdFqk+G3eNbNDDR/OKL3KvzVL8Att7eNq62IQRCR17QY2TlkQW0sTPu2SicW2S4M6FyOv0C8J6YUlf3T1kdAl3eE2UZfC5ImGKRH7OuCVtBapz3zu//C9Okonk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784663355; c=relaxed/simple;
	bh=4wCklL54HSnpnvinSTViaJcQQ2SrT1rK45YcbQNinQo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DMCgFF/jmxVBA0KiGAKZUVay0bdvwRlTDmjsORhq+iEm9tCnI3Cf5HUGgcwxSd4ZsZ291ApGgwJOEo5lh3PGstzLoaepNMSTpgw4rurK0yNFd3YLD4oRhLhdt3EwK+8ZYrKQ3CNiVeI26b53OjAYJpiXGVv0xxFppDVYzxatunU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=L1Tz8HVv; arc=fail smtp.client-ip=52.101.85.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="L1Tz8HVv"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vnXWZrKaDm2OfiIZxl7DnWBf7E2ffjdcFG+c0kwdlVms1rdy9ic+LJ+FPx1qTMTvxXmkkvwnr9DVKRNCaOap8Nc3kGO9L5xPiMhqfWtnv0k33sOYVAftWjH2gUplkQfKIy2I4KMCt1PmWLR7lEc3Zsj3pgrIcDmLEHTNaOSgkZo9c2FbzSuMZt8ftgVROjtYcM5Q1a/ULBcXdm/tJOFcqJ8n0ezM/W3GN2ouBbz/J0rleH2J9rR+4NRpRVpD7Z6eqO5JhVL5RpSz7VswuJ36knY608x8pAObbfB5y9tmLFcgKYoEqEfOd4vTAiAhCiv3aBOLzQfD7pFuS11ig0MtnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xkMTKLfdZBkXqZk2HurJE1+UugIL2nuqDFL3byqoIZE=;
 b=Fw8DnyiHZfzMK4lrA3pHEBAxmZjx3qOExqlJc1fxVCmCMOBKcl/mzBnKyM6P0oqDAVNaKvmi8IVRaOlNJDJmd05S2IYntx1rNFKNMIfcjKB924WoBiMHS0x2dOHxKc56ZkKAe6A1ZAzPGgr8r/KVDUkwAdo01m2g86jYp/qzRG+6nv9dtN3XmR9noIZdQTWRN4uGB7UMOqcr+VUhuofplo7TRoIFzd+WkcCDuwoUs0yOuz+sHmlndyJ5QdPfLPMcfE4UdkxoMnF3aiOcq7/EDIf/1+gKtu5OXa2yRhPsWekNjCjiehw91O+WdCVqDyaSwiuFtWGRlNbb3d23IMkRig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xkMTKLfdZBkXqZk2HurJE1+UugIL2nuqDFL3byqoIZE=;
 b=L1Tz8HVvPkl9TakM37zsupMqWBpRLikPROEXGVx0m9mAdWBENSncDJrvPrsdP5br7bATLGtc96aNBIYBxXVkX3MSxh9F90ZFagloBeAQr571SC86UW0Wm1CUoiC9MofTSnJ71Lcq7W7DpVEtw7nynu0qRE/mJ8lsD4VFp7FvyTeDSOEuIyETyN0P71+JNK/Va6a9WBM0IVtPtKwPLk2ZwJV6pB41nJJ5YTfTiNp3TNto4sLZCXu0nnduzSB9W1FpnX9lWAgsb03WBAtBl8H3rQYigH39Z12zuyQ4KUNZ9GK9AV1+ACTqJxdDW/icxevEL5Ok3hdWMH7vKmP01aw2AQ==
Received: from PH8P223CA0027.NAMP223.PROD.OUTLOOK.COM (2603:10b6:510:2db::22)
 by SN7PR12MB8102.namprd12.prod.outlook.com (2603:10b6:806:359::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Tue, 21 Jul
 2026 19:49:06 +0000
Received: from SJ1PEPF000023D7.namprd21.prod.outlook.com
 (2603:10b6:510:2db:cafe::1d) by PH8P223CA0027.outlook.office365.com
 (2603:10b6:510:2db::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.10 via Frontend Transport; Tue,
 21 Jul 2026 19:49:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF000023D7.mail.protection.outlook.com (10.167.244.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.0 via Frontend Transport; Tue, 21 Jul 2026 19:49:05 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 21 Jul
 2026 12:48:42 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 21 Jul
 2026 12:48:41 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Tue, 21 Jul 2026 12:48:41 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>, <robin.murphy@arm.com>, <jgg@nvidia.com>
CC: <joro@8bytes.org>, <praan@google.com>, <kevin.tian@intel.com>,
	<smostafa@google.com>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>, <jamien@nvidia.com>
Subject: [PATCH v9 07/12] iommu/arm-smmu-v3-kexec: Add ASID/VMID reservation helpers
Date: Tue, 21 Jul 2026 12:48:16 -0700
Message-ID: <9f9d227c0adf472e93293008e7083973688d015e.1784663184.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D7:EE_|SN7PR12MB8102:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d69b445-1724-4fe9-5639-08dee7611f73
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|82310400026|1800799024|376014|36860700016|10067099003|6133799003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	spy38LJ+JuAdFPjU4i+bB9HTvbavaNjlgRoZ7FSexiHEfvKwkiAROUnGMyp1MxUCoJZ6+8am0RShQz1es5xzi5hqdLnNAalhfjTH6qIYh1KeXDd59BOzPF5iBuxvJZpB8ShIFkrqk5M++LMN57jE1Z7akJNGVuo/WjBxiTGoEYtLK4Y2Xh/lvAvcMTqEGGktt1Wurxr+LrG+jtV+3Tn2BBXD3k3dduNtkrzCit6o/Z7UFzX6ezpxNZqTo/MibF5mU8jgR0xOGl0mhvqGvhRyBkQSzPhKFpES9NiHrRJsDVQSNhNuwaMiJSq76buL2K2nRA1bIGachBsOXHuq9NikedWBlNti/iQW1KshHZSZ+U4mYd85Ej5XBXoQga7oiJhEEqPavshk06w8u6u1aRAup2RELR2JQ7e8OVia/4jRJoMrbmAEWdDQKaVuKjlaE5uVE1VfosroK9vLoZpHM4GYDDtOoi6YyLKsu63JkSoJgrR5s008j5l+ZXLTI8Sf17Xo6k6pH2OtRUZkUZa45fH14O2JMY9glgcIB4Bo2ZV6xxIbYoYz1OTKZcK8w+NfhIiU/esDWz+VAjQHqc+rFUVJxkouVAGmLDeh6vEhBCzrlFq9VjdQufvpIMlRlvg4oV1Bbl60XO6X/4qOPZVKt3JY+3twVY3zVVOGJlljwpcvcAzgmzz6Bs/5s1OYKXZJJTiGtopkPuqcE/YQ6R6Q9k1VDA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(82310400026)(1800799024)(376014)(36860700016)(10067099003)(6133799003)(11063799006)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	bFL1wCH5Dr/tpIQApnli8WE2lAik7C93wV6+tDYAMuwhnIyHb+U4JKTbYTgo8hRBRfzit1usJHI1qePST3EURUNWg8VC3q6uRZDpTBhNs8AL0TWftR61xU0kOuGVy4iZ7lswDVB8F68O+4jv2nJmql+zgpjny6EQhUc1Oc+rBLa4MGTRvuvzSSqMRF8MoL057j9xzNKvcHNZX6Bim+Y+gC9F2PR3tDDNq478ZOx4uk+8lbTEQGKD8ZBh4IDyab4etz9CZxEdoYmV8HJth5tJ45s3ucx0lJwYwfvhYzxau31K387LqSFEtlukDy9YsXqG5pm03m3WW6xV/a3rOQmL2cJsxVLO+cIksi/ynaYrDejP6mSSdZ2Qrvj/wBqYCh2OcRu0vFyPVpfthbdpKTo2Vx/l8FY5W2jluFNEC9u+0FZn67tYw2vJ3wlu8ZTGhQ1P
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2026 19:49:05.7412
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d69b445-1724-4fe9-5639-08dee7611f73
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D7.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8102

An adopted stream table keeps translating in-flight DMAs, so the SMMU also
keeps caching the TLB entries tagged with the previous kernel's ASIDs and
VMIDs. Any kexec flavor retaining those translations must reserve all the
in-use IDs, so that this kernel cannot ever give any of its own domains an
overlapping ID that would alias the previous kernel's cached TLB entries.

Add the reservation helpers to arm-smmu-v3-kexec.c:
 - arm_smmu_kexec_scan_and_resv_ids()
 - arm_smmu_kexec_unresv_ids()

At adoption time, arm_smmu_kexec_scan_and_resv_ids() runs a one-off scan:
walking the stream table set up in the strtab_cfg and every CD table behind
an S1 STE, it reserves the ASIDs in the asid xarray and the S2VMIDs in the
vmid ida. The scan memremaps each table transiently, which is a necessity
even for a live update: the ID reservation must be complete by the end of
the SMMU probe itself, before this kernel starts allocating any ID for its
own domains, yet the CD tables are only claimed when their masters get to
re-probe, long after that point. Thus, the scan cannot rely on any claimed
mapping and must map each table by itself.

The scan walks untrusted tables, yet every loop is strictly index-bounded:
the iteration counts derive from the log2size and s1cdmax fields, which are
validated against this kernel's own sid_bits and ssid_bits, so a corrupted
table cannot extend the walk.

Since both kernels allocate ASIDs from 1, reserving any in-use ASID would
often find it already taken in the xarray, either by another scan or by a
live domain. A reservation made by another scan is permanent, so it is safe
to rely on. A live domain will free its ASID for reuse at some point, and
the scan must then fail and fall back. To tell these two cases apart, store
the per-scan ID as an xarray value entry: a value entry identifies another
scan's reservation and a pointer entry identifies a live domain. Note that
the scan ID scopes a failing scan's rollback to exactly the entries that it
inserted, so a rollback cannot erase another scan's reservations.

Also add an arm_smmu_kexec_resv_lock mutex serializing entire scans and any
rollback of failing ones, so that a concurrently probing SMMU can only rely
on the reservations that will persist.

Assisted-by: Claude:claude-fable-5
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |   4 +
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-kexec.c | 260 ++++++++++++++++++
 2 files changed, 264 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 183c617ecb273..5c03de5aed27b 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -1241,6 +1241,8 @@ tegra241_cmdqv_probe(struct arm_smmu_device *smmu)
 #endif /* CONFIG_TEGRA241_CMDQV */
 
 #ifdef CONFIG_ARM_SMMU_V3_KEXEC
+extern struct mutex arm_smmu_kexec_resv_lock;
+
 int arm_smmu_kexec_parse_strtab_2lvl(struct arm_smmu_device *smmu, u32 cfg_reg,
 				     phys_addr_t base, u32 *num_l1_ents);
 int arm_smmu_kexec_parse_strtab_linear(struct arm_smmu_device *smmu,
@@ -1252,6 +1254,8 @@ int arm_smmu_kexec_check_strtab_l1_desc(struct arm_smmu_device *smmu,
 int arm_smmu_kexec_check_ste_cdtab(struct arm_smmu_device *smmu, u64 ste0,
 				   phys_addr_t *cdtab, u32 *s1fmt,
 				   u32 *max_contexts);
+int arm_smmu_kexec_scan_and_resv_ids(struct arm_smmu_device *smmu);
+void arm_smmu_kexec_unresv_ids(struct arm_smmu_device *smmu);
 #endif /* CONFIG_ARM_SMMU_V3_KEXEC */
 
 #ifdef CONFIG_CRASH_DUMP
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-kexec.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-kexec.c
index 5ad1fe1922eec..582192ab8390c 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-kexec.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-kexec.c
@@ -199,3 +199,263 @@ int arm_smmu_kexec_check_ste_cdtab(struct arm_smmu_device *smmu, u64 ste0,
 	*max_contexts = 1U << s1cdmax;
 	return 0;
 }
+
+/*
+ * Identifies the ASID reservations of an arm_smmu_kexec_scan_and_resv_ids call.
+ *
+ * A failing scan can only roll back its own insertions. Two scans of the same
+ * SMMU (e.g. a probe retry) must not share an ID, as the retried scan may fail
+ * and roll back, while the prior one's committed reservations must persist. So
+ * it must not be a per-SMMU value, but a per-scan one.
+ *
+ * Serialized by arm_smmu_kexec_resv_lock.
+ */
+static unsigned long arm_smmu_kexec_scan_id;
+DEFINE_MUTEX(arm_smmu_kexec_resv_lock);
+
+static int arm_smmu_kexec_resv_asid(struct arm_smmu_device *smmu, u32 asid)
+{
+	int ret;
+
+	/* A valid CD never has ASID 0; both kernels share the same HW limit */
+	if (!asid || asid >= 1UL << smmu->asid_bits)
+		return -EINVAL;
+
+	guard(mutex)(&arm_smmu_asid_lock);
+
+	/* The value entry marks the ASID as in-use and identifies its scan */
+	ret = xa_insert(&arm_smmu_asid_xa, asid,
+			xa_mk_value(arm_smmu_kexec_scan_id), GFP_KERNEL);
+	/*
+	 * An -EBUSY against a value entry safely shares a permanent reservation
+	 * made by another scan. A pointer entry means a live domain that will
+	 * free its ASID for reuse eventually: keep -EBUSY to fail the scan.
+	 */
+	if (ret == -EBUSY && xa_is_value(xa_load(&arm_smmu_asid_xa, asid)))
+		ret = 0;
+	return ret;
+}
+
+static int arm_smmu_kexec_resv_vmid(struct arm_smmu_device *smmu, u32 vmid)
+{
+	int ret;
+
+	/* A translating STE never has VMID 0, which is reserved for bypass */
+	if (!vmid || vmid >= 1UL << smmu->vmid_bits)
+		return -EINVAL;
+
+	ret = ida_alloc_range(&smmu->vmid_map, vmid, vmid, GFP_KERNEL);
+	if (ret < 0 && ret != -ENOSPC) /* -ENOSPC means already reserved */
+		return ret;
+	return 0;
+}
+
+static int arm_smmu_kexec_resv_cd_asids(struct arm_smmu_device *smmu,
+					struct arm_smmu_cd *cds, u32 num_cds)
+{
+	int ret = 0;
+	u32 i;
+
+	for (i = 0; i < num_cds; i++) {
+		u64 val = le64_to_cpu(cds[i].data[0]);
+		u32 asid = FIELD_GET(CTXDESC_CD_0_ASID, val);
+
+		if (!(val & CTXDESC_CD_0_V))
+			continue;
+		ret = arm_smmu_kexec_resv_asid(smmu, asid);
+		if (ret)
+			break;
+	}
+	return ret;
+}
+
+/*
+ * Reserve the ASIDs of all the valid CDs of an S1 STE in the previous kernel's
+ * CD tables. The CD tables are transiently memremapped for the scan.
+ */
+static int arm_smmu_kexec_resv_s1_asids(struct arm_smmu_device *smmu, u64 ste0)
+{
+	struct arm_smmu_cdtab_l1 *l1tab;
+	u32 num_l1_ents, num_cds, i;
+	u32 max_contexts, s1fmt;
+	phys_addr_t cdtab;
+	int ret;
+
+	ret = arm_smmu_kexec_check_ste_cdtab(smmu, ste0, &cdtab, &s1fmt,
+					     &max_contexts);
+	if (ret)
+		return ret;
+
+	if (s1fmt == STRTAB_STE_0_S1FMT_LINEAR) {
+		struct arm_smmu_cd *cds;
+
+		cds = memremap(cdtab, max_contexts * sizeof(*cds), MEMREMAP_WB);
+		if (!cds)
+			return -ENOMEM;
+		ret = arm_smmu_kexec_resv_cd_asids(smmu, cds, max_contexts);
+		memunmap(cds);
+		return ret;
+	}
+
+	num_l1_ents = DIV_ROUND_UP(max_contexts, CTXDESC_L2_ENTRIES);
+	l1tab = memremap(cdtab, num_l1_ents * sizeof(*l1tab), MEMREMAP_WB);
+	if (!l1tab)
+		return -ENOMEM;
+
+	/* max_contexts being under a full leaf makes the only leaf partial */
+	num_cds = min_t(u32, max_contexts, CTXDESC_L2_ENTRIES);
+
+	/* Aliased L2 tables cannot extend the walk; they only repeat a scan */
+	for (i = 0; i < num_l1_ents; i++) {
+		u64 l1_desc = le64_to_cpu(l1tab[i].l2ptr);
+		phys_addr_t l2_base = l1_desc & CTXDESC_L1_DESC_L2PTR_MASK;
+		struct arm_smmu_cdtab_l2 *l2;
+
+		if (!(l1_desc & CTXDESC_L1_DESC_V))
+			continue;
+
+		/* A valid descriptor never carries a null pointer */
+		if (!l2_base) {
+			ret = -EINVAL;
+			break;
+		}
+
+		l2 = memremap(l2_base, num_cds * sizeof(*l2->cds), MEMREMAP_WB);
+		if (!l2) {
+			ret = -ENOMEM;
+			break;
+		}
+		ret = arm_smmu_kexec_resv_cd_asids(smmu, l2->cds, num_cds);
+		memunmap(l2);
+		if (ret)
+			break;
+	}
+	memunmap(l1tab);
+	return ret;
+}
+
+static int arm_smmu_kexec_resv_ste_ids(struct arm_smmu_device *smmu,
+				       struct arm_smmu_ste *ste)
+{
+	u32 vmid = FIELD_GET(STRTAB_STE_2_S2VMID, le64_to_cpu(ste->data[2]));
+	u64 ste0 = le64_to_cpu(ste->data[0]);
+
+	if (!(ste0 & STRTAB_STE_0_V))
+		return 0;
+
+	switch (FIELD_GET(STRTAB_STE_0_CFG, ste0)) {
+	case STRTAB_STE_0_CFG_ABORT:
+	case STRTAB_STE_0_CFG_BYPASS:
+		return 0;
+	case STRTAB_STE_0_CFG_S1_TRANS:
+		return arm_smmu_kexec_resv_s1_asids(smmu, ste0);
+	case STRTAB_STE_0_CFG_NESTED:
+		/*
+		 * A guest-owned CD table is in the IPA space, unreachable. Its
+		 * ASIDs are only tagged with the S2VMID reserved below, so they
+		 * cannot alias this kernel's VMID-0 or EL2 S1 domains.
+		 */
+		fallthrough;
+	case STRTAB_STE_0_CFG_S2_TRANS:
+		return arm_smmu_kexec_resv_vmid(smmu, vmid);
+	default:
+		return -EINVAL;
+	}
+}
+
+/**
+ * arm_smmu_kexec_scan_and_resv_ids() - Reserve a stream table's in-use IDs
+ * @smmu: SMMU device of this kernel, with an adopted or restored strtab_cfg
+ *
+ * Scan the stream table set up in the strtab_cfg and every CD table behind an
+ * S1 STE, reserving all of the in-use ASIDs and VMIDs. The caller must hold the
+ * arm_smmu_kexec_resv_lock, so that a failing scan can roll back, prior to any
+ * concurrent scan, via arm_smmu_kexec_unresv_ids().
+ *
+ * Note that the scan selects the linear or 2-level walk per this kernel's own
+ * ARM_SMMU_FEAT_2_LVL_STRTAB, so the caller must have matched the feature bit
+ * to the format of the adopted stream table in the strtab_cfg.
+ *
+ * Return: 0 on success, -EINVAL on any malformed table entry, or -ENOMEM on a
+ * memory shortage
+ */
+int arm_smmu_kexec_scan_and_resv_ids(struct arm_smmu_device *smmu)
+{
+	struct arm_smmu_strtab_cfg *cfg = &smmu->strtab_cfg;
+	int ret = 0;
+	u32 i, j;
+
+	lockdep_assert_held(&arm_smmu_kexec_resv_lock);
+
+	/* Allocate a new ID for this scan, to scope its rollback */
+	arm_smmu_kexec_scan_id++;
+
+	if (!(smmu->features & ARM_SMMU_FEAT_2_LVL_STRTAB)) {
+		for (i = 0; i < cfg->linear.num_ents; i++) {
+			ret = arm_smmu_kexec_resv_ste_ids(
+				smmu, &cfg->linear.table[i]);
+			if (ret)
+				return ret;
+		}
+		return 0;
+	}
+
+	/* Aliased L2 tables cannot extend the scan; they only repeat a scan */
+	for (i = 0; i < cfg->l2.num_l1_ents; i++) {
+		u64 l1_desc = le64_to_cpu(cfg->l2.l1tab[i].l2ptr);
+		struct arm_smmu_strtab_l2 *l2;
+		phys_addr_t base;
+
+		ret = arm_smmu_kexec_check_strtab_l1_desc(smmu, l1_desc, i,
+							  &base);
+		if (ret == 1)
+			continue;
+		if (ret)
+			return ret;
+
+		/*
+		 * This kernel will map the previous kernel's L2 tables lazily
+		 * or not at all. Here, take a transient view for this scan.
+		 */
+		l2 = memremap(base, sizeof(*l2), MEMREMAP_WB);
+		if (!l2)
+			return -ENOMEM;
+		for (j = 0; j < ARRAY_SIZE(l2->stes); j++) {
+			ret = arm_smmu_kexec_resv_ste_ids(smmu, &l2->stes[j]);
+			if (ret)
+				break;
+		}
+		memunmap(l2);
+		if (ret)
+			return ret;
+	}
+	return 0;
+}
+
+/**
+ * arm_smmu_kexec_unresv_ids() - Roll back a failing reservation scan
+ * @smmu: SMMU device of this kernel that failed its reservation scan
+ *
+ * Roll back the current scan for a failing arm_smmu_kexec_scan_and_resv_ids()
+ * call, typically to a full reset.
+ *
+ * arm_smmu_kexec_resv_lock must be held for arm_smmu_kexec_scan_and_resv_ids()
+ * and the roll back.
+ */
+void arm_smmu_kexec_unresv_ids(struct arm_smmu_device *smmu)
+{
+	unsigned long index;
+	void *entry;
+
+	lockdep_assert_held(&arm_smmu_kexec_resv_lock);
+
+	mutex_lock(&arm_smmu_asid_lock);
+	xa_for_each(&arm_smmu_asid_xa, index, entry) {
+		if (entry == xa_mk_value(arm_smmu_kexec_scan_id))
+			xa_erase(&arm_smmu_asid_xa, index);
+	}
+	mutex_unlock(&arm_smmu_asid_lock);
+
+	/* No domain exists yet, so the ida holds only the reservations */
+	ida_destroy(&smmu->vmid_map);
+}
-- 
2.43.0

