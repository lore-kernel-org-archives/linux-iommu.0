Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012045.outbound.protection.outlook.com [40.107.200.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54A42318EC1
	for <iommu@lists.linux.dev>; Sun, 30 Aug 2026 23:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788131937; cv=fail; b=ti+OlEaOABr9NchQDBTKbcagoeZgDHmqLgo4ua8zp+OhGDZYOTEkHjt5aZ53fUIAQa6upep6kOYH6+VhxAc7fALiVCcfUxqmkkrta5e/P3LAw8hdPl6AiM4CbrsivVq5OYmbfh7MuF+bj8KArEoFgjj5W/iPE45amEd2hoGCtIA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788131937; c=relaxed/simple;
	bh=bq9WRatbY/Z8czTzcs9ipWdANdqyyHAl1+BJJdQtppk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jBKjNLzegKsKm4Me1gBUugxLDrKFiXJfiURBE9a82R6vNNrsQ/+/2Z8Th4saAP456dMF6aHnwkma9HgGvxz+hSnRI55tHxO6+Q2JvdYf9QXjFKOMqVX1ITiYEXdOsS/rRDsy3zHvqWi/dXha9JgBA4b/pemWYAoPhFnhbLCi9dc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VSIDv8ha; arc=fail smtp.client-ip=40.107.200.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VSIDv8ha"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jGT6p8IV+6Z0/oAKaSMW6SPkaS5/zm0tbdL0RG9bqLWMX3yLJ8HWTl5K3pOOBTsP3pjdFdg+OY2k3hPNeSrKyb/fi6RxRpL1y/wZOwBkc1ffmqSl87JoM3F1Mzle4RlVewsvpbW98KvFfwuVRbOGu9Z+m/OgwhBNylVsQNbyYHkEPMvQMdN9vriMmPYn1/tNCY0+qq4WE8vpJEZNwW7RXiFDiHruoEVhgVdiaKIbP5ccGhkCea46gSejs9P2NHJhvh6APqsDfRb5N5JS+GFkeETY2/azt3A7fiZ4BZwi9oP5yRX+gaMVv8Qrk9DWMFA+lsYttc2x2bLTLCBwHay1fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qdmuftCiy+fCH38GmDRsLucte6ZnMppWhtlTdRaCRDc=;
 b=XETYQTV20k8cbd3fhCyIzBjicj7be4xUCR5EBvUvovwAyYnxdlZEsuhp4ZQbvEw22nK+nTxyvy6cuC8lKjlXobTJ0fxk2k08CzXNe+RZG5cQQV0SOC1QFz/rEp96tLPIVRWw101FJ5cAHk2euZy8YNjHrwm6QpxlFf/mSRg34/TCrZkFEiDUEUAMRKt7nQdrdWWcTggomkIjtSKNJJTQ8bEZtok2OYy361ARNcuL8Wr06oGFrld/QwVkwo1Fu2h0nKYVKp+TFkXFVD+coTPiRelmdQ+JeW2ImmrC9uDZAyPU7b5zonzN0zobrhJC254w7KFNJlZ4rAc2pQ2HAqt3Pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qdmuftCiy+fCH38GmDRsLucte6ZnMppWhtlTdRaCRDc=;
 b=VSIDv8hayPPfEgNDPT3k2mMSPExw+VuRszMEy9x801UMpebD2+7ZQaqE2FzYHFifrvR704CxxMI8PeUFfcIFcrbCY2kjkBf6+9J+DxnLRI5XcG0HJJQPnrYjsme1ZfYZoD4oiRz7hjq2CD0EwjJ3jOLRDZ6uJj7MUR9iuSX7E4+jsy9fHfEgxZjckimmj56X65bH/PPqa3O1F/18IwJHn0Ev5CPienSdcN+IBAibuyvebV/RS3nLzy33TnUKv7Pt2i2sVWZkGwMIyWRy+WQwXIMxDcS6TpmCsrU1qJY7HeMSfgTNRRCVuQ4hyhwesE2E3ytvhif1pGD/lrwOKMDZnw==
Received: from BN0PR04CA0057.namprd04.prod.outlook.com (2603:10b6:408:e8::32)
 by CY5PR12MB6321.namprd12.prod.outlook.com (2603:10b6:930:22::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Sun, 30 Aug
 2026 23:18:44 +0000
Received: from BN3PEPF00022BD8.namprd03.prod.outlook.com
 (2603:10b6:408:e8:cafe::3b) by BN0PR04CA0057.outlook.office365.com
 (2603:10b6:408:e8::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.13 via Frontend Transport; Sun,
 30 Aug 2026 23:18:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN3PEPF00022BD8.mail.protection.outlook.com (10.167.248.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Sun, 30 Aug 2026 23:18:43 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Sun, 30 Aug
 2026 16:18:38 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Sun, 30 Aug 2026 16:18:38 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Sun, 30 Aug 2026 16:18:38 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>, <robin.murphy@arm.com>, <jgg@nvidia.com>
CC: <joro@8bytes.org>, <praan@google.com>, <kevin.tian@intel.com>,
	<smostafa@google.com>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>, <jamien@nvidia.com>,
	<kas@kernel.org>
Subject: [PATCH v10 08/13] iommu/arm-smmu-v3-kexec: Add ASID/VMID reservation helpers
Date: Sun, 30 Aug 2026 16:18:09 -0700
Message-ID: <063aa8aad441946f3a79746f870b625599937571.1788130528.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF00022BD8:EE_|CY5PR12MB6321:EE_
X-MS-Office365-Filtering-Correlation-Id: 83002270-df04-46e6-5bbf-08df06ed08e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|36860700016|82310400026|7416014|376014|1800799024|6133799003|10067099003|56012099006|5023799004|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	G5Bq5OO+XA9ykoclLgEZalWQz62Txbls3XG53EOynii7IJL40RsXfcYNX/KGnfscAmgs4UrGN98Tvmx82ZGjXw/hVkZzKPoCxIAxLmclz2SqXO9I1CDuLmvDuv3DRn3oiz791GIKqEGU2TTqryEoT5q7Pw7dqkxc+JtxK0KgTbFec5NFuVWQdI/Op+uVhOUKnmtvfQhSvtLsOwcMHo/8WzhwOpVNcLO5+svrpSO7wxcrw9rv1K7aC72Xpa683ZqclMkkQB0pCWcpM1EuVnZBTCdSTpYvECjaYERjqdGRGAABliHHT4nsQy2oDfwxIc9UgCahtB0a/AMJOoMmNkSDEWZO66vzRZGrPSBdMxYR58qq0xOnahGLcG2UDHkpAgeK3gJY5xjoslJr9uMQhIKncXucLeTIctCsUGzXwVpLROxpOegho3Fp9bY/NGT4Rn5cZqxUqi8o4HDh6OGfuBPLFlaP0rt+pRKJNi39aGEep8IOApRVYjlHti10F4oHa+qsKoPmnWn6UzAPmYSn6c1tb/Ee4q7BDLOJWyfACtvnY91Qax743Fn41fIM+5+nMqNjvvCuex+WvLB2VQf4tdNguUV22tjFyYCkJD9WQ5YCjj1a7iVNi+xdlERpIv90b4h7s6XARtZTnM8g+DmV7bR7VieQP5eB+cfIHOl8o+1SZB3hcDTtxOEDSkh5Y+Ym8LGTlzLv4x3GRy3Gtxzz9WGKQg==
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(36860700016)(82310400026)(7416014)(376014)(1800799024)(6133799003)(10067099003)(56012099006)(5023799004)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	GSByy79ChvHUulqNj+XqTYVXXQD2WLsK9sEv8yA+DyIe0eKCmvhI8sQ8/P0FF5Fjwbiv38Nu/ekpq6+5ALTWLy8vMabmVJcTFX6gC1BH46PyUvw0MhPUISCRvfEtxTLb5CTdURgSsYip8qdsBCu4i3hKjasjI5xO7xDgdMv9Gw6gHo5R98WWkp4ogybHyhvIEyMH8c6Tp0AEww3ncDjAHjhjLtgiBMmZG3/ZIFq1zEQFC/zKHlAb9AwhYgZ7UBsG26YThdtZKOe/+VlV1DBfwICIreBSf3zyc0N7Alfqa0SNLW2L5pTQcwqV9SZDBL4hdkH6IEq4t1WfE7tJR+zorKD/4f3W7gkfo7HQLNax73C7iT0EIlc75jNMd8Z7qar4W2stVxMlPZ54Je+tZKcCs4FGswElFJ1+Kh1jJbeOC/nm4GGW3sIlF09cna3GS4rF
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2026 23:18:43.4392
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 83002270-df04-46e6-5bbf-08df06ed08e6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF00022BD8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6321

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

The ASID space is per SMMU instance and the scan runs before its own SMMU
registers with the IOMMU core, i.e. before any domain of that SMMU can hold
an ASID. So it reserves via xa_reserve(), and a failing scan just empties
the xarray and the ida, since they hold nothing else at that point.

Assisted-by: Claude:claude-fable-5
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |   2 +
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-kexec.c | 235 ++++++++++++++++++
 2 files changed, 237 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 1bcf6cb2ebb3c..64927c54f8b6b 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -1264,6 +1264,8 @@ int arm_smmu_kexec_check_strtab_l1_desc(struct arm_smmu_device *smmu,
 int arm_smmu_kexec_check_ste_cdtab(struct arm_smmu_device *smmu, u64 ste0,
 				   phys_addr_t *cdtab, u32 *s1fmt,
 				   u32 *max_contexts);
+int arm_smmu_kexec_scan_and_resv_ids(struct arm_smmu_device *smmu);
+void arm_smmu_kexec_unresv_ids(struct arm_smmu_device *smmu);
 #endif /* CONFIG_ARM_SMMU_V3_KEXEC */
 
 #ifdef CONFIG_CRASH_DUMP
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-kexec.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-kexec.c
index 700f63c7972e9..8c53cd7570070 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-kexec.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-kexec.c
@@ -221,3 +221,238 @@ int arm_smmu_kexec_check_ste_cdtab(struct arm_smmu_device *smmu, u64 ste0,
 	*max_contexts = 1U << s1cdmax;
 	return 0;
 }
+
+static int arm_smmu_kexec_resv_asid(struct arm_smmu_device *smmu, u32 asid)
+{
+	/* A valid CD never has ASID 0; both kernels share the same HW limit */
+	if (!asid || asid >= 1UL << smmu->asid_bits)
+		return -EINVAL;
+
+	guard(mutex)(&arm_smmu_asid_lock);
+
+	/*
+	 * The scan runs before this SMMU registers with the IOMMU core, so no
+	 * domain of its own holds an ASID yet, while xa_reserve() does nothing
+	 * if the entry is there, covering a domain's ASID that many CDs share.
+	 */
+	return xa_reserve(&smmu->asid_map, asid, GFP_KERNEL);
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
+		/*
+		 * A valid descriptor never carries a null pointer. Also, an L2
+		 * table is always 64KB-aligned, so an unaligned pointer would
+		 * make this kernel read a different table.
+		 */
+		if (!l2_base || !IS_ALIGNED(l2_base, sizeof(*l2))) {
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
+ * S1 STE, reserving all of the in-use ASIDs and VMIDs. A failing scan rolls
+ * back through arm_smmu_kexec_unresv_ids().
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
+ * arm_smmu_kexec_unresv_ids() - Release the IDs that a failing scan reserved
+ * @smmu: SMMU device of this kernel that failed its reservation scan
+ *
+ * Undo the reservations of a failing arm_smmu_kexec_scan_and_resv_ids() call,
+ * for a caller that falls back to a full reset.
+ *
+ * That reset flushes the whole TLB, so the previous kernel's IDs no longer need
+ * any protection. A scan that fails halfway would otherwise keep a good share
+ * of an 8-bit ASID or VMID space reserved for nothing.
+ */
+void arm_smmu_kexec_unresv_ids(struct arm_smmu_device *smmu)
+{
+	/*
+	 * Emptying both maps releases exactly this scan's IDs, as no domain of
+	 * this SMMU can hold one until it registers with the IOMMU core, later
+	 * in the probe. Both stay initialized and usable for the full reset.
+	 */
+	mutex_lock(&arm_smmu_asid_lock);
+	xa_destroy(&smmu->asid_map);
+	mutex_unlock(&arm_smmu_asid_lock);
+
+	ida_destroy(&smmu->vmid_map);
+}
-- 
2.43.0

