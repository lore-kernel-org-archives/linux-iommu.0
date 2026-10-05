Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011011.outbound.protection.outlook.com [40.93.194.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38C6D4DAF85
	for <iommu@lists.linux.dev>; Mon,  5 Oct 2026 19:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791228715; cv=fail; b=Sg33OUpWKNcNsJHkmGLDBFrRsgmZGjrThP/TiJtq45n+yc/VM/htq7fu4jvkhlYjYjjfEkyPJbaZuUFbhe+Daly6Xr2xZwlduvYmlASy9f17zca9UrBRQYYyWemy8KkJtYHdM4Zwyl4p3/tn78DC11FaD8tJ7HBc/xvqqMlffH8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791228715; c=relaxed/simple;
	bh=JAb29kc9a/JfcaNfwtIantzWLNGr6hWmWx/PG7/zPzQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PUd9Cwdmgnczl3ziB0SDLn5PKoXptB1uL3Uzqy5mlcM085vK3lTlg3qy65DMtq0XrpyMfAs7Q471nejlytKNgYYxCn492REZXtQk2UicJFrQbM/hJnQ+AIw19Bh4jWZ1UjuxjEjDaCVpa2jZpOPZK6RTTyn5QGl9j7dq/i9BTa0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=loiYF18T; arc=fail smtp.client-ip=40.93.194.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="loiYF18T"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F1dv2lHeXCex6GJC5saeDaxVvMi4X60QLsVID5FiR+WQdWataujGBotPSCM48vo961c1YvGWqC/v2q0vNYBy9byAWNxRGZ3fc7Sz/hetqZZQiIR15GM4DTm5eS79Q1VjKPrni9Em9LWkfKVjvmkfTzfGmVsVT489l3Bf4/pRJ2GuPeKzf2+BCUgCo8xU9iPmk48EXMUMyjSQz0POHfeqJkbC+GWDIn1I223/NZIaHnPmQlPh43MCZwUsjrEYVcBYdKES02mHl5CBdEoYRHRp09epnnJgQ7lgu/mKzHl2Ga+IZCw1b/NRx1WdYiS07BDWXVjIQU6xBV3Deznt6GcBIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9jlX5lKDAiy4Hv3V4mPae7KIBFK+W4Ih6+xURXI9cFo=;
 b=R+PNLKFoKCyEDMN5+lBTABtbab5ufXQ43t9fEY08blDPeeTjBOm/qv1q9cIDuM1evYl1to7+VIhasghD45w/2ddKC8jtimW/NMvOXZye14prdN/SHONUKrx81ELVogXfumJt2iO1lmv1rZGxENuL9YxOd3C3XKGw55dcVYhLezAkK+ciqy7FDdl0NCfrm5Zd7/Aa0CyUVdv96R7tJX0ClxgPO9EqdVuw3ajXDqkuAguYKXwl2vLoFpX26kfWL6TYlWgrTuqXFZqQ4f3hDraicmss+yLgumoDO2JXRIwyqBl8I4JsQ2++FZxNakXmUhejAn0neKkUXfk0T+sivFm+cQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9jlX5lKDAiy4Hv3V4mPae7KIBFK+W4Ih6+xURXI9cFo=;
 b=loiYF18TvE3Qw3kwLsu0VD8S/WVxfkJdGukEAvSVFu/uqBPW1bXvwjpBLGDPMOKOmxXUXiqS0yfMp7ARoLzAlHddG6FYGTeuk938zOwsga7WQENJJDdippOf50Kf1Qdi+ejcMzONdFKISbQfDksR4tQ97YQ2MyMDqcwjPB6H8UaAfw3U1Y/UK+f2kBeyxiDuIMjidD1ISv7GDIxDQEOS4pcQCm8ovbeMPT2Pm8DfHUA9kJjUBUdHzPaRm1d/qP0NHNmxp67lSwRkADAxjwIMp+NG2yz3W4d2D+To5RM7WDf9hsLyCc+BYnZMEURdCgQdoY2sE5osCn2pxJ3GXG+Zjg==
Received: from BLAPR05CA0014.namprd05.prod.outlook.com (2603:10b6:208:36e::18)
 by DS7PR12MB5741.namprd12.prod.outlook.com (2603:10b6:8:70::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.15; Mon, 5 Oct 2026 19:31:38 +0000
Received: from BN3PEPF0000B071.namprd04.prod.outlook.com
 (2603:10b6:208:36e:cafe::94) by BLAPR05CA0014.outlook.office365.com
 (2603:10b6:208:36e::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Mon, 5
 Oct 2026 19:31:37 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.118.233) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BN3PEPF0000B071.mail.protection.outlook.com (10.167.243.116) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.14 via Frontend Transport; Mon, 5 Oct 2026 19:31:37 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 5 Oct
 2026 12:31:06 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 5 Oct 2026 12:31:06 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Mon, 5 Oct 2026 12:31:05 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>
CC: <robin.murphy@arm.com>, <joro@8bytes.org>, <jgg@nvidia.com>,
	<praan@google.com>, <kevin.tian@intel.com>, <smostafa@google.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <jamien@nvidia.com>, <kas@kernel.org>,
	Cristian Prundeanu <cpru@amazon.com>, Breno Leitao <leitao@kernel.org>
Subject: [PATCH v11 07/11] iommu/arm-smmu-v3-kexec: Reserve crashed kernel's ASIDs and VMIDs
Date: Mon, 5 Oct 2026 12:30:50 -0700
Message-ID: <aab933435dd34913ccd2d185c92374a6b2ed9c44.1791226953.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B071:EE_|DS7PR12MB5741:EE_
X-MS-Office365-Filtering-Correlation-Id: 99c15f86-4bb4-4033-2514-08df23174632
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|36860700016|7416014|1800799024|82310400026|18002099003|22082099003|3023799007|6133799003|10067099003|56012099006|11063799006|5023799004;
X-Microsoft-Antispam-Message-Info:
	K0A3NK5hIQDONMh0T/08ZLujibOEGPWasCWluLucbnrKYgaNFGT6TnPeYP1/PGzmTUVDhJZVJHmkhxD/3dHqghcbLc5Wsu1p/rdrZ1YmvWFwv+rNT7qLi9fnJqvFHRpmv3yrfTCJ+G2jeDXvlvd3INLlMuoBWD9U0l/WsspR5/pT8Tg6AymgYijx8zlk6O+zFhVJF/HM/Xc35hm4k+QoaejKOSv29tGNbPmn79TPIuoWTx4zi690icVd1UfJqmEm+lpuWJJMkVbvLGjUCsEn1qoyduTC/uZyfNO06iosGk1sTIaTael350PAV3XpeD+Vkj8CS5yWY0VbE1p6DLgCyrFEgulv4VRKZ76/NXDKxSH55hC+ptyCdF27xUQ0pubIwOaZpPMPECQwxY/Gtt+lwFKByjjk5Hg9TpRouSLt5G9gyClxuNE+E0vyMV7cG+gmYqhDTTxPhiUhHx5LXcqnUi60Bf0u1x2fM5+Byyesj6LYgoBX+jXSxC1DQ3CAvmCBHF7BsUWh3oZUcKa/1sPsS+l2BUpE9F0CIHxxe1GcZoXaZvSfIpqWN1HDTpsbCq1yli6f7Yok2a+7OB/i989WkiQ/Jb+DhvKFQK2StZWz0msFCtftzGHEK1YjAI+Qnn/MOzz+lh10HWXyRAkPExx2U13zxyi9FnI7PWssPVhLl9kINhdf6gPBWZ4II5t0jD2LjLf6uA4+h/fde/1G6lM2Qg==
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(376014)(36860700016)(7416014)(1800799024)(82310400026)(18002099003)(22082099003)(3023799007)(6133799003)(10067099003)(56012099006)(11063799006)(5023799004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	cMfyS1946ARays+V4++9H8vGTBVRzAfz+lk8+w0czGAPHepXanAJ1Tpbx22a1AZfJxulWBvgmrVi+zf/PyTbWYlQ/RcWFO++1DfkZnPo7ofH90oMuWK4KT+tNh+cgM0HtR08QJwkmm5FlSH6N9GB2lCI5SNv709jviaY+Nasx1OoKcytu2fc+/1agHBhxJfadgKnem6cczWASNzsHQ2WxTLyY2+8xN/fmKWvHrBkyhaf17N7emDAwl5fxVdlwo7L23D1dRhOGlV+k0UsJr+6IQTo0JyVQovelRE5HElTNF7aUW/zC/vvHdL/Uu2g5Ib3whkBHuBETxmi12uDIHSNpSbLX1F6tUu4fgzFMI1KNqRjyrikbS9iFX8NzIkY8YM6Pcqx/XXOFJ5Sqj7Zq6ALM1ip/g/j8Xp7sbkDNghmPg/uvhs7CfQvXv4T8V8uqh6O
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2026 19:31:37.3506
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 99c15f86-4bb4-4033-2514-08df23174632
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B071.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5741

The adopted stream table keeps translating in-flight DMA, so the SMMU keeps
caching TLB entries tagged with the crashed kernel's ASIDs and VMIDs. If
this kernel handed one of those IDs to its own domain, the new domain's DMA
could hit the crashed kernel's cached translations, e.g. a stale entry left
behind by an invalidation that the crash cut short.

Scan the adopted stream table at adoption time, reserving every ID in use
via arm_smmu_kexec_scan_and_resv_ids(), and roll all of them back through
arm_smmu_kexec_unresv_ids() should the scan fail. These two kexec helpers
will be shared with the liveupdate code.

The scan memremaps each table transiently, since the IDs must be reserved
within the SMMU probe, long before any master re-probes to claim its table.

The scan walks untrusted tables, yet every loop is strictly index-bounded:
the iteration counts derive from the log2size and s1cdmax fields, which are
validated against this kernel's own sid_bits and ssid_bits, so a corrupted
table cannot extend the walk.

A nested STE's guest-owned CD table is left alone, since its ASIDs live in
a space of their own under that STE's VMID. Reserving that VMID covers all
of them, so there is no reason for the scan to walk the (VMID, ASID) pairs
behind it. The only ASIDs needing a reservation are those in the space that
this kernel uses for its own domains.

Note that, on an E2H/VHE host, the kernel's stage-1 domains are tagged by
the EL2 ASID, and the TLBI_EL2_* commands take no VMID. So isolating this
kernel by a reserved VMID alone would not work. Reserving the ASIDs covers
both the E2H and the NSEL1 cases.

Reservations are never released: a kdump kernel reboots after it saves the
vmcore, and the full-reset fallback flushes the entire TLB, which turns any
stale reservation into a merely unused ID.

If the scan finds any inconsistent structure, toss the entire adoption and
fall back to the full reset.

Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Tested-by: Breno Leitao <leitao@kernel.org>
Tested-by: Cristian Prundeanu <cpru@amazon.com>
Assisted-by: LLM
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-kexec.c | 304 +++++++++++++++++-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   |   1 +
 2 files changed, 304 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-kexec.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-kexec.c
index 6bbc369df86bb..22d997480db1c 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-kexec.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-kexec.c
@@ -173,6 +173,298 @@ static int arm_smmu_kexec_check_strtab_l1_desc(struct arm_smmu_device *smmu,
 	return 0;
 }
 
+/**
+ * arm_smmu_kexec_check_ste_cdtab() - Decode the CD table geometry of an STE
+ * @smmu: SMMU device of this kernel
+ * @ste0: first 64 bits of the previous kernel's S1 STE
+ * @cdtab: pointer to return the CD table's physical address
+ * @s1fmt: pointer to return the CD table format
+ * @max_contexts: pointer to return the number of CDs
+ *
+ * A linear CD table on the 2-level capable hardware is accepted, as a previous
+ * kernel might have used one, like the linear stream table.
+ *
+ * Note that the spec requires a CD table to be aligned to its own size, so an
+ * unaligned @cdtab gets rejected here: HW may then zero the low bits or fetch
+ * any CD in the table, leaving the live ASIDs unknowable to this scan.
+ *
+ * Return: 0 on success with the three outputs set, or -EINVAL on a bad geometry
+ */
+static int arm_smmu_kexec_check_ste_cdtab(struct arm_smmu_device *smmu,
+					  u64 ste0, phys_addr_t *cdtab,
+					  u32 *s1fmt, u32 *max_contexts)
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
+static int arm_smmu_kexec_scan_and_resv_ids(struct arm_smmu_device *smmu)
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
+static void arm_smmu_kexec_unresv_ids(struct arm_smmu_device *smmu)
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
+
 #ifdef CONFIG_CRASH_DUMP
 /*
  * Helper functions of the kdump stream table adoption for ARM SMMUv3
@@ -373,16 +665,26 @@ int arm_smmu_kdump_adopt_strtab(struct arm_smmu_device *smmu)
 		goto err;
 	}
 
+	ret = arm_smmu_kexec_scan_and_resv_ids(smmu);
+	if (ret) {
+		dev_warn(smmu->dev, "failed to reserve in-use ASIDs/VMIDs\n");
+		arm_smmu_kdump_adopt_cleanup(smmu);
+		goto err_unresv;
+	}
+
 	ret = devm_add_action_or_reset(smmu->dev, arm_smmu_kdump_adopt_cleanup,
 				       smmu);
 	/* devm_add_action_or_reset ran the cleanup upon failure */
 	if (ret) {
 		dev_warn(smmu->dev, "failed to set up cleanup action\n");
-		goto err;
+		goto err_unresv;
 	}
 
 	return 0;
 
+err_unresv:
+	/* The full reset will flush the entire TLB, so release everything */
+	arm_smmu_kexec_unresv_ids(smmu);
 err:
 	dev_warn(smmu->dev, "falling back to full reset\n");
 	/*
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index db80b980d1dd9..3ec49c1e16aa7 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -4868,6 +4868,7 @@ static int arm_smmu_init_strtab(struct arm_smmu_device *smmu)
 {
 	int ret;
 
+	/* Init both first, as a kdump adoption reserves in-use ASIDs/VMIDs */
 	ida_init(&smmu->vmid_map);
 	ret = devm_add_action_or_reset(smmu->dev, arm_smmu_destroy_vmid_map,
 				       &smmu->vmid_map);
-- 
2.43.0

