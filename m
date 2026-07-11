Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010003.outbound.protection.outlook.com [52.101.193.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E8C826B2AD
	for <iommu@lists.linux.dev>; Sat, 11 Jul 2026 00:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783731208; cv=fail; b=UCFRWZGCLBiOWfM0sakOSKe8ESzhJjLP5qd61ZJ9/q9dcooIff3ZAnxXFybx4+1YVS5Ly3SVcKdIEPOUcYSW22e2HiBd5LagmelXukcmTWBD3cgRyIzAkELNrON+LjhdqMfT7Vpru1/TxvH98B6l3K2l7M0qT+Cx4QERsxSmSHs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783731208; c=relaxed/simple;
	bh=syC4R7DVplo0VF1Nk4I/90/4St5N0Xm4vf5knhjgPlg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LsiaPHTGkKOk/z2mpwnzDZsTuOL4UfZYeeXUPHJIXoVcem1Khyih12kN5Zh8bt8zC9fXaHTx6gVLdhMV8F/qAP7fgUsU92qckJDIf/YOB/ScqhyzpUYEiAhvVeVxbaDrMsqSWc0ly9cmjgD2XW9ROiJQjyX0ZrDwL0yYAuBOmrY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=n+qSDill; arc=fail smtp.client-ip=52.101.193.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="n+qSDill"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gkVvKri0JTwr76pkoUln2TYwRbYTQ38nCZWLnBtxZJ2fCBpliTfHrqDLd8cHTkYHOzUZlcMqmBp1yvimfgBG85sAwQyQfGzSoeksyhzOrYY+NB22aI9sw5gMp1YOm2u7Q8fxFQpeyaO2ZLth3eMcx8xp9OCGH7dSOOowkCg1WVGNlyMWGofl7EA6i5z0GlOqhGMu5QP16oFmWmunCr+9EdE0zNXGi5G6Z7eOM6Hz7A4CVPyCPsf/XjewKG6R5l37rIgEbC20806VslTUo2k9b8zjloD3+elZLYkxgtlBIQu1CzAVIf7dVvY07FABFD7mKYqLq/+CnQsOezJeYyElmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bx2j31hJ2EV/4d2imBpZ0rUoWdsjsnEYjOYBUvkD8m8=;
 b=bWKFkCiDNHw3LfLXZWJuZuCY37oofm+gtPpNfh/DVx4bw+0KxMleO5GBlk0xN7A5N7UEbUQQ3VxC4sR1a47sNNzVvEjdUNLbMeCqHdZ3PH1XIgAotc2VavSBF7y+LGS0A8rxYLRsfXHsrw7DrTj1jO7jPGHUukrPX1jClw9wXUHobQutxV7s26yHlPEKtqCPzPQG5ocN+jGOz4z0ahtmHBQm8IV06bpIhmdfOuP6mIjz3UZCRLtwCndoR9UsGEEdLkwd7uc3TIzrqWbYsg4MLXbjsysjsvO2aBtdzhop8lllc8kDiaR42Y7v5ErzhVUSOgHwYREMtlSkG5tJh3f0vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bx2j31hJ2EV/4d2imBpZ0rUoWdsjsnEYjOYBUvkD8m8=;
 b=n+qSDill1cRlZbNBOy67UgZEGZKgAmml0va43/MKQcPok8pbVOyBpc0N+T7Y0b5PR1hA/5BJ86iKLVKEigSHCGYN5eskbcOnBn06stvs+MBYKvqKrxSJx07RqMOZE6hczJ/lwoXrxJSCK1Kz1r5e3as+RAnL5nxEfPCo2nl2Mygeq7fs7NzdeyiXMdbqVGR4R+ycw1G+fMflqhEpWg0NbSc4/Ak75kdtlV/CDBzKcvNASe3AT9nyLYu3RtOH6906VtAkKDdJ1zHj2As15fa0O4eiwgiDXm5w9UGy9Yv5aW5zOhSD2AbcDyf7zQrfZBJ/KKAMlMckgX+aQLVh3t2ucQ==
Received: from SN7PR18CA0028.namprd18.prod.outlook.com (2603:10b6:806:f3::11)
 by CH3PR12MB8660.namprd12.prod.outlook.com (2603:10b6:610:177::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.18; Sat, 11 Jul
 2026 00:53:15 +0000
Received: from SN1PEPF000397B4.namprd05.prod.outlook.com
 (2603:10b6:806:f3:cafe::23) by SN7PR18CA0028.outlook.office365.com
 (2603:10b6:806:f3::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.14 via Frontend Transport; Sat,
 11 Jul 2026 00:53:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF000397B4.mail.protection.outlook.com (10.167.248.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Sat, 11 Jul 2026 00:53:14 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 10 Jul
 2026 17:53:01 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 10 Jul
 2026 17:53:00 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Fri, 10 Jul 2026 17:52:59 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>, <robin.murphy@arm.com>, <jgg@nvidia.com>
CC: <joro@8bytes.org>, <praan@google.com>, <kevin.tian@intel.com>,
	<smostafa@google.com>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>, <jamien@nvidia.com>
Subject: [PATCH v8 5/9] iommu/arm-smmu-v3-kdump: Reserve crashed kernel's ASIDs and VMIDs
Date: Fri, 10 Jul 2026 17:52:46 -0700
Message-ID: <15aeae1e9fd460579912074ab025386fe1ffb682.1783729633.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B4:EE_|CH3PR12MB8660:EE_
X-MS-Office365-Filtering-Correlation-Id: 4af2b6f6-f0c5-4195-b22e-08dedee6ca11
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|82310400026|23010399003|376014|5023799004|11063799006|56012099006|6133799003|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	BjowFVTLkL8tEkn9KYqPqOoxVBeudyAn0NhJbGddTWaijCGp1J4L3bgjBFyXQbEWobfImrIF5ISqAVZVjpaZmY+lzH9PnWXl21HSQWMY0+7i9AF+ygy2sv/Tbj6kZYdVbs6ixaA9jJNQkM/QJfoxqTRUHM6OLwFTPfY2ov1zng358hVUNuBIdNO7zz8GHD+isEJNt+dFmZaOQnLK19/DNypYAa4K3TvR0vs7CJs5yM7U3lfEOEj4qNBu+FoS0UAsXHIuBPu/XMjZqvEVvx9UHRT3x6x4HxZIEnXet3Kv0QlgFAMY4C+KTs/q8XF4lwW5ydzeuDIpqhpAgpVudKY/TybAGFdnp8J1Z6CmPZG2yIuZegLMyZ0HBa/B4mcTyE/L6a90UR4b5AFTA4y68u7VmaAzAo6Y2RE7vZizu2dQfeGAdSlCjnFaSjttQq2X66XCaCXZRbCGpPAoecjPvbrXpqGjyMfbYLJ4OeA7i4z8tEFLhwyXW5u8cBXHrO9tsdt8XKdyNlGxI9iU1wFkidei6KB25ctQykWjk9TWtaZZ56eLrpKKD0SE6rxzAQxlt7fsnoDIBK4f9sJOnIHSjPWvCapwmY1n1B87JgZazc0BSk4VhhG31p8CYrM86+iM7/Rk5O2o+j4k6xsyp8MOet0a5ra4SfgjUTIdMCcQM+mlO4mAuXPnOdJU1APQih+19BOrwtyZ7tXGZ3nqk7k/Xv8brg==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(82310400026)(23010399003)(376014)(5023799004)(11063799006)(56012099006)(6133799003)(18002099003)(22082099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ZGliOSdjpSPVq3y9fPUC5wGo1LOipdoSpVTQmZx9eXzFwKLBrVPr02r06WyuCmYK6nhNvxqs71rc2kfRRLPD8JcPlu9831CMgRI5/r3ImsP2HkwjP+j9yRwPtfCzJ9qreSWtDc6lZYX+qvswDd7Hu605oSR7IV9RWomoFtQbvCKy3nYVzjuQMW8NZoh1O9PUBBcIWE47dZlKl10lzFRCTw+rzWFaAsu/VaJ6ZG3g6hfwqSVG/nd1OQDrTJ7QFPOdidd/Ln97VgO8J/zrOH02n15rAAoTT5pdk85bQANb+eEMjWb8hVowGvarsM1N/0HnFzvJGHcfbDKXYLpeUUU1iY0HJJgm/ZnVjQSrn7qqo7dWojaZKKUi6kSNb2vBgMZKo0Hk1EkWC2oJzSXTtTkZd2LmghE1rcAsJVIGCg2DIyrAF0aKp26K6eUCxAliy1r8
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2026 00:53:14.5844
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4af2b6f6-f0c5-4195-b22e-08dedee6ca11
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8660

The adopted stream table keeps translating in-flight DMA, so the SMMU keeps
caching TLB entries tagged with the crashed kernel's ASIDs and VMIDs. If
this kernel handed one of those IDs to its own domain, the new domain's DMA
could hit the crashed kernel's cached translations, e.g. a stale entry left
behind by an invalidation that the crash cut short.

Scan the adopted stream table at adoption time and reserve every ID in use:
 - Walk the STEs, transiently memremapping each L2 table
 - Reserve the S2VMID of S2 and nested STEs in the vmid ida
 - Walk the CD tables of S1 STEs (linear and 2-level formats), reserving
   the ASIDs in the asid xarray.

Nested STE's guest-owned CD table is in IPA space and left alone: its ASIDs
only pair with the nonzero S2VMID being reserved, so they cannot alias this
kernel's VMID-0 or EL2 stage-1 domains.

The scan walks untrusted tables, yet every loop is strictly index-bounded:
the iteration counts derive from the log2size and s1cdmax fields, which are
validated against this kernel's own sid_bits and ssid_bits, so a corrupted
table cannot extend the walk.

Since both kernels allocate ASIDs from 1, reserving any in-use ASID would
often conflict with another adopting SMMU or with a live domain. So, store
a per-scan ID as an xarray value entry: a conflict against a value entry is
just a safe dedup, as all the reservations are permanent, while one against
a pointer entry, i.e. a live domain that will soon free its ASID for reuse,
has to toss the entire adoption. The scan ID also scopes a failing scan's
rollback to exactly the entries that it inserted, so a rollback can never
erase any committed reservation.

Note that, on an E2H/VHE host, the kernel's stage-1 domains are tagged by
the EL2 ASID, and the TLBI_EL2_* commands take no VMID. So isolating this
kernel by a reserved VMID alone would not work. Reserving the ASIDs covers
both the E2H and the NSEL1 cases.

Reservations are never released: a kdump kernel reboots after it saves the
vmcore, and the full-reset fallback flushes the entire TLB, which turns any
stale reservation into a merely unused ID.

If the scan finds any inconsistent structure, toss the entire adoption and
fall back to the full reset.

Also, a successful scan makes arm_smmu_init_strtab() return early, leaving
the DMA addresses of the stream table unset; a following change will guard
arm_smmu_write_strtab() in arm_smmu_device_reset().

Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Assisted-by: Claude:claude-fable-5
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-kdump.c | 268 +++++++++++++++++-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   |  17 +-
 2 files changed, 269 insertions(+), 16 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-kdump.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-kdump.c
index 1ca0d7ef7dabe..4d010df430587 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-kdump.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-kdump.c
@@ -32,6 +32,247 @@
 
 #include "arm-smmu-v3.h"
 
+/*
+ * Commit or roll back an entire scan atomically, so that a concurrently
+ * probing SMMU (e.g. forced by driver_async_probe) can only dedup against
+ * the reservations that will persist
+ */
+static DEFINE_MUTEX(arm_smmu_kdump_resv_lock);
+
+/* Identifies the current scan's reservations; serialized by the lock above */
+static unsigned long arm_smmu_kdump_scan_id;
+
+/*
+ * The adopted stream table keeps translating in-flight DMAs, so the SMMU also
+ * keeps caching TLB entries tagged with the crashed kernel's ASIDs and VMIDs.
+ * Reserve all the in-use IDs, so that this kernel cannot give its own domains
+ * an overlapping ID that would alias the crashed kernel's TLB entries.
+ *
+ * The reservations are only released when the entire adoption is tossed, as
+ * the full-reset fallback flushes the entire TLB. Otherwise, they are kept
+ * for the lifetime of the kdump kernel, which reboots after saving a vmcore.
+ */
+static int arm_smmu_kdump_resv_asid(struct arm_smmu_device *smmu, u32 asid)
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
+			xa_mk_value(arm_smmu_kdump_scan_id), GFP_KERNEL);
+	/*
+	 * An -EBUSY against a value entry is just a safe dedup against another
+	 * permanent reservation. A pointer entry means a live domain that will
+	 * free its ASID for reuse eventually: keep -EBUSY to toss the adoption.
+	 */
+	if (ret == -EBUSY && xa_is_value(xa_load(&arm_smmu_asid_xa, asid)))
+		ret = 0;
+	return ret;
+}
+
+static int arm_smmu_kdump_resv_vmid(struct arm_smmu_device *smmu, u32 vmid)
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
+static int arm_smmu_kdump_resv_cd_asids(struct arm_smmu_device *smmu,
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
+		ret = arm_smmu_kdump_resv_asid(smmu, asid);
+		if (ret)
+			break;
+	}
+	return ret;
+}
+
+static int arm_smmu_kdump_resv_s1_asids(struct arm_smmu_device *smmu, u64 ste0)
+{
+	phys_addr_t cdtab = ste0 & STRTAB_STE_0_S1CTXPTR_MASK;
+	u32 s1cdmax = FIELD_GET(STRTAB_STE_0_S1CDMAX, ste0);
+	u32 s1fmt = FIELD_GET(STRTAB_STE_0_S1FMT, ste0);
+	size_t max_contexts = 1UL << s1cdmax;
+	struct arm_smmu_cdtab_l1 *l1tab;
+	u32 num_l1_ents, num_cds, i;
+	int ret = 0;
+
+	if (!cdtab || s1cdmax > smmu->ssid_bits)
+		return -EINVAL;
+
+	if (s1fmt == STRTAB_STE_0_S1FMT_LINEAR) {
+		struct arm_smmu_cd *cds;
+
+		/*
+		 * A crashed kernel might have used a linear CD table on the
+		 * 2-level capable hardware like the linear stream table case.
+		 * So, accept it here as well. s1cdmax is capped by ssid_bits.
+		 */
+		cds = memremap(cdtab, max_contexts * sizeof(*cds), MEMREMAP_WB);
+		if (!cds)
+			return -ENOMEM;
+		ret = arm_smmu_kdump_resv_cd_asids(smmu, cds, max_contexts);
+		memunmap(cds);
+		return ret;
+	}
+
+	if (s1fmt != STRTAB_STE_0_S1FMT_64K_L2)
+		return -EINVAL;
+
+	num_l1_ents = DIV_ROUND_UP(max_contexts, CTXDESC_L2_ENTRIES);
+	l1tab = memremap(cdtab, num_l1_ents * sizeof(*l1tab), MEMREMAP_WB);
+	if (!l1tab)
+		return -ENOMEM;
+
+	/* max_contexts being under a full leaf makes the only leaf partial */
+	num_cds = min_t(size_t, max_contexts, CTXDESC_L2_ENTRIES);
+
+	/* Aliased L2 tables cannot extend the walk; they only repeat a scan */
+	for (i = 0; i < num_l1_ents; i++) {
+		u64 l1_desc = le64_to_cpu(l1tab[i].l2ptr);
+		struct arm_smmu_cdtab_l2 *l2;
+
+		if (!(l1_desc & CTXDESC_L1_DESC_V))
+			continue;
+
+		l2 = memremap(l1_desc & CTXDESC_L1_DESC_L2PTR_MASK,
+			      num_cds * sizeof(*l2->cds), MEMREMAP_WB);
+		if (!l2) {
+			ret = -ENOMEM;
+			break;
+		}
+		ret = arm_smmu_kdump_resv_cd_asids(smmu, l2->cds, num_cds);
+		memunmap(l2);
+		if (ret)
+			break;
+	}
+	memunmap(l1tab);
+	return ret;
+}
+
+static int arm_smmu_kdump_resv_ste_ids(struct arm_smmu_device *smmu,
+				       struct arm_smmu_ste *ste)
+{
+	u32 vmid = FIELD_GET(STRTAB_STE_2_S2VMID, le64_to_cpu(ste->data[2]));
+	u64 val = le64_to_cpu(ste->data[0]);
+
+	if (!(val & STRTAB_STE_0_V))
+		return 0;
+
+	switch (FIELD_GET(STRTAB_STE_0_CFG, val)) {
+	case STRTAB_STE_0_CFG_ABORT:
+	case STRTAB_STE_0_CFG_BYPASS:
+		return 0;
+	case STRTAB_STE_0_CFG_S1_TRANS:
+		return arm_smmu_kdump_resv_s1_asids(smmu, val);
+	case STRTAB_STE_0_CFG_NESTED:
+		/*
+		 * A guest-owned CD table is in IPA space, unreachable. Its
+		 * ASIDs are only tagged with the S2VMID reserved below, so
+		 * they cannot alias this kernel's VMID-0 or EL2 S1 domains.
+		 */
+		fallthrough;
+	case STRTAB_STE_0_CFG_S2_TRANS:
+		return arm_smmu_kdump_resv_vmid(smmu, vmid);
+	default:
+		return -EINVAL;
+	}
+}
+
+static int arm_smmu_kdump_resv_ids(struct arm_smmu_device *smmu)
+{
+	struct arm_smmu_strtab_cfg *cfg = &smmu->strtab_cfg;
+	int ret = 0;
+	u32 i, j;
+
+	lockdep_assert_held(&arm_smmu_kdump_resv_lock);
+
+	/* Allocate a new ID for this scan, to scope its rollback */
+	arm_smmu_kdump_scan_id++;
+
+	if (!(smmu->features & ARM_SMMU_FEAT_2_LVL_STRTAB)) {
+		for (i = 0; i < cfg->linear.num_ents; i++) {
+			ret = arm_smmu_kdump_resv_ste_ids(
+				smmu, &cfg->linear.table[i]);
+			if (ret)
+				return ret;
+		}
+		return 0;
+	}
+
+	/* Aliased L2 tables cannot extend the walk; they only repeat a scan */
+	for (i = 0; i < cfg->l2.num_l1_ents; i++) {
+		u64 l1_desc = le64_to_cpu(cfg->l2.l1tab[i].l2ptr);
+		phys_addr_t base = l1_desc & STRTAB_L1_DESC_L2PTR_MASK;
+		u32 span = FIELD_GET(STRTAB_L1_DESC_SPAN, l1_desc);
+		struct arm_smmu_strtab_l2 *l2;
+
+		if (!span)
+			continue;
+
+		/* Validated at adopt time, so a change means live corruption */
+		if (span != STRTAB_SPLIT + 1 || !base)
+			return -EINVAL;
+
+		/* Transient map: L2 tables are only adopted upon device use */
+		l2 = memremap(base, sizeof(*l2), MEMREMAP_WB);
+		if (!l2)
+			return -ENOMEM;
+		for (j = 0; j < ARRAY_SIZE(l2->stes); j++) {
+			ret = arm_smmu_kdump_resv_ste_ids(smmu, &l2->stes[j]);
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
+/*
+ * Roll back a scan that has not committed yet. Committed reservations are
+ * never released, as another SMMU's scan might have deduped against them.
+ */
+static void arm_smmu_kdump_unresv_ids(struct arm_smmu_device *smmu)
+{
+	unsigned long index;
+	void *entry;
+
+	lockdep_assert_held(&arm_smmu_kdump_resv_lock);
+
+	mutex_lock(&arm_smmu_asid_lock);
+	xa_for_each(&arm_smmu_asid_xa, index, entry) {
+		if (entry == xa_mk_value(arm_smmu_kdump_scan_id))
+			xa_erase(&arm_smmu_asid_xa, index);
+	}
+	mutex_unlock(&arm_smmu_asid_lock);
+
+	/* No domain exists yet, so the ida holds only the reservations */
+	ida_destroy(&smmu->vmid_map);
+}
+
 int arm_smmu_kdump_adopt_deferred_l2_strtab(struct arm_smmu_device *smmu,
 					    u32 sid, phys_addr_t base, u32 span,
 					    struct arm_smmu_strtab_l2 **l2table)
@@ -255,24 +496,37 @@ int arm_smmu_kdump_adopt_strtab(struct arm_smmu_device *smmu)
 		goto err;
 	}
 
+	mutex_lock(&arm_smmu_kdump_resv_lock);
+	ret = arm_smmu_kdump_resv_ids(smmu);
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
-		/*
-		 * Undo the linear adoption's clearing of FEAT_2_LVL_STRTAB so
-		 * the full-reset fallback uses the hardware-supported format.
-		 */
-		if (was_2lvl)
-			smmu->features |= ARM_SMMU_FEAT_2_LVL_STRTAB;
-		goto err;
+		goto err_unresv;
 	}
+	mutex_unlock(&arm_smmu_kdump_resv_lock);
 
 	return 0;
 
+err_unresv:
+	/* The full reset will flush the entire TLB, so release everything */
+	arm_smmu_kdump_unresv_ids(smmu);
+	mutex_unlock(&arm_smmu_kdump_resv_lock);
 err:
 	dev_warn(smmu->dev, "falling back to full reset\n");
+	/*
+	 * Undo the linear adoption's clearing of FEAT_2_LVL_STRTAB so that the
+	 * full-reset fallback uses the hardware-supported format.
+	 */
+	if (was_2lvl)
+		smmu->features |= ARM_SMMU_FEAT_2_LVL_STRTAB;
 	memset(&smmu->strtab_cfg, 0, sizeof(smmu->strtab_cfg));
 	smmu->options &= ~ARM_SMMU_OPT_KDUMP_ADOPT;
 	return ret;
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 2fb28eb2b8895..3f4b281c35fed 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -4516,22 +4516,21 @@ static int arm_smmu_init_strtab(struct arm_smmu_device *smmu)
 {
 	int ret;
 
+	/* Init first, as a kdump adoption reserves in-use VMIDs in the ida */
+	ida_init(&smmu->vmid_map);
+	ret = devm_add_action_or_reset(smmu->dev, arm_smmu_deinit_strtab, smmu);
+	if (ret)
+		return ret;
+
 	if ((smmu->options & ARM_SMMU_OPT_KDUMP_ADOPT) &&
 	    !arm_smmu_kdump_adopt_strtab(smmu))
-		goto out;
+		return 0;
 
 	if (smmu->features & ARM_SMMU_FEAT_2_LVL_STRTAB)
 		ret = arm_smmu_init_strtab_2lvl(smmu);
 	else
 		ret = arm_smmu_init_strtab_linear(smmu);
-	if (ret)
-		return ret;
-
-out:
-	ida_init(&smmu->vmid_map);
-
-	return devm_add_action_or_reset(smmu->dev, arm_smmu_deinit_strtab,
-					smmu);
+	return ret;
 }
 
 static int arm_smmu_init_structures(struct arm_smmu_device *smmu)
-- 
2.43.0

