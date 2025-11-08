Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010044.outbound.protection.outlook.com [52.101.56.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A53FD2DC767
	for <iommu@lists.linux.dev>; Sat,  8 Nov 2025 08:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762589321; cv=fail; b=T9mUuHSW+sFYFoQr4WciZFXw/5Q6zhS+lcjhe7+nVT76YaKoh4dfvOkElk/+Jdgo2jPdzq85q7S1/UBkBz2/q2SA4RiBKRDh/mpJQ2LXUVFKL9X9Lta3nTEabI6cCqybERlfxR9G6LZS4a0eX9ftbUzHlGVUP1MnBVd/djclb4M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762589321; c=relaxed/simple;
	bh=1jiDumrLVko2oxt4yWBghC3O8VGwrSRJqdOHc1QzbFI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FXnXp1KABtcueLqf5yQ6JayhuMO7iduvJWSOIZssKG/NCIOJNCW6P41ghOpJwL1UbNtGpEoIAdenxkSNdiODTvt2tk26eHlVSMBLbuBu8W2qFlhWSJwh+m9jirVLKHEnnszyMfa7/dgFChp2ynwsH/SU33/gpCT5Pq8OnKdXN10=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RYgQKV+Z; arc=fail smtp.client-ip=52.101.56.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RYgQKV+Z"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NVIOtc2VsFfRSN6lUC4l9AhfgiOSrsdcQXzNb2Fiwj7Kw07qp++NeREomrKlSBaP1A4Aq4dYDD5GI9EDlAhlo0gHJ7hfrlQFT7hK2bxw0p0fvUUm0jzLoLKtE6eYtA+DvDaNz3bPilYaQnK+tE93w7oxFIR7mpOa0sP7zdv7Xv/9f/BpMmt+zn0UOznwBP3RM5idIvMp3RWlmB2R0Cnvc55RGFI5c77n8NjO9xDR8tXKG53vr5ikqB/mzZLL3tv9/J//0DbK46VNKd1lMvnoUxEQgEXz9ut2THyiv7Mpy7rWv7kkHV0CnY9YXuII6uakMefsbne8pHgn2atKyDaFeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sZVRgVj3uSkvZFLSxeQdQTLxMboSYQ4zXKMA7kARAyU=;
 b=HIx35NwYSjA/+KKeJ+tTEmASJbZeB8kD28m5BM8vKMkOWhvIxbtqiM+w82MzN5apapiRR/hckDDCtsT2RJElrROugdEPEbWqEDg2e+zx7Zkf3IrFLCESilxbrx97mhcMudGkDWVXMtcblYMO85u8NnZnXB9JXE1BPSakasYdHgMLOanJaYvyqO96vFx21WrzVq/B/GSIlsXzjveEB7hU2+zgZ7cK0VTUOloWOrXY0qkSpgh1IHb2RAwymU08i+8AORGnVPUJlDnF3XIQ7Q5ORNuod6BD+zZU49cZdTPFu1rrkhshPNl9yUwjMIJP4//mZi1WQwxmm0Ae2FqVdHSNrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sZVRgVj3uSkvZFLSxeQdQTLxMboSYQ4zXKMA7kARAyU=;
 b=RYgQKV+ZEmJoZAl4C+h+tUF/+i5XWRWiQFEEWbMrTuPDnKB6Ipvd3+Vvp6GQg0d4EzOB2j15jB4egdGHVOsNRHHX90fm0Ny1eucpiUfB+3n9OgKwigZvTj+lOD8Whc37MI9mOGjlATI20xSp6PgStvHiG7XrtI4AbaJgl4j/AHMzZb72h56OVqUOuNBB7DPVFaiEqxyYd1Bi9KZdr9epLRv554QyD9h4rFaek0kya1tiV5q9/uhOFQb2a9MujlAHY+wH0omGtPrO6SLW6gUD6eyI1cNPh8uYLurL5qbz+OB8fXVSdCR5hsyRstknNTZLNqNoHqtYUxQ1432HOboRxw==
Received: from MW4PR04CA0097.namprd04.prod.outlook.com (2603:10b6:303:83::12)
 by PH7PR12MB9104.namprd12.prod.outlook.com (2603:10b6:510:2f3::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.13; Sat, 8 Nov
 2025 08:08:31 +0000
Received: from SJ1PEPF00002315.namprd03.prod.outlook.com
 (2603:10b6:303:83:cafe::ad) by MW4PR04CA0097.outlook.office365.com
 (2603:10b6:303:83::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.13 via Frontend Transport; Sat,
 8 Nov 2025 08:08:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF00002315.mail.protection.outlook.com (10.167.242.169) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Sat, 8 Nov 2025 08:08:31 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sat, 8 Nov
 2025 00:08:23 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sat, 8 Nov
 2025 00:08:22 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Sat, 8 Nov 2025 00:08:22 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>
CC: <jean-philippe@linaro.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<jgg@nvidia.com>, <balbirs@nvidia.com>, <miko.lenczewski@arm.com>,
	<peterz@infradead.org>, <kevin.tian@intel.com>, <praan@google.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v5 5/7] iommu/arm-smmu-v3: Populate smmu_domain->invs when attaching masters
Date: Sat, 8 Nov 2025 00:08:06 -0800
Message-ID: <ebf35fa1b2025be736475950503f0dc0612371f4.1762588839.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1762588839.git.nicolinc@nvidia.com>
References: <cover.1762588839.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002315:EE_|PH7PR12MB9104:EE_
X-MS-Office365-Filtering-Correlation-Id: 9054e927-eed9-4d94-3daf-08de1e9e01a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DqnPYcXiY2/TM32V4xcyea7x6YMkhVDHxawT6vDmlKbmiSijlQPv4jlyq/Hd?=
 =?us-ascii?Q?qlqEdomhJOwPh7BT/Baq7VCW34ABWPDnTabxLgOWeIRyQlgtG96n/m4ipkWX?=
 =?us-ascii?Q?pwAg3+07CJKKMB2k1Go6hnKPcmZIl1nOjEeGh9l+KWGQVBmfhpnX1zsQVgFa?=
 =?us-ascii?Q?Q+1whuOaBgh4a3Uz17ADPdcBme/4JnrKZ1UkQ6cGt5/HAEdrmVEU79JP8XUD?=
 =?us-ascii?Q?yi7J/7U5mMswAxhnacJ17VmasbUGpdya/doSlwUwnOki+e2kRx6Bpz2aRDOv?=
 =?us-ascii?Q?BNZrZcqWn0iDkvOEl/AB3oIsGywvn8/22qfuBj0stlZNPoDTIm4Sy4bJxLUj?=
 =?us-ascii?Q?fZdlomurne0k0LUmUkYnm/nxn7G8YqdciAX2UqFaogSg13L9qTXponr6gw8G?=
 =?us-ascii?Q?3bMPolIdvRuXZFAhhH3lbioNdtlKovA3bQnQdcGPl5BATa9i0W3Nneq2p6m2?=
 =?us-ascii?Q?VVzSdqVtsqLRv9SSKcA67n+EUlmauuoif28zO8thZ7cQQ1gFGXqRJAV4YZ6y?=
 =?us-ascii?Q?Pnqh5mjHO8QnMwGR0spOLCv71hrMb65iKlzCO5/A2D3t4tW/sI8PDbCfqMHW?=
 =?us-ascii?Q?ztq2YXXZl87ZgH5timY766TNTwuiSPCqYSax/IaR33Tn5lZEMUrWS3J+c4+s?=
 =?us-ascii?Q?RJu4C3SdjI0GorzBMb6hvJ66bl6+LFhYYrxtaiAqwe39NxLLKuE7ZN7ewg3e?=
 =?us-ascii?Q?a48CmGd5BaMRtJFrqQCGnjPFLsM5qUXG8bAIfsSpgu/Wtak1IIReAkGuG8qb?=
 =?us-ascii?Q?5+lLgYYrh+L4z48kRR4JB3D/r/ogD9NI1rZuBnS/eqlKJOVpYWOwZoswnk+f?=
 =?us-ascii?Q?cC0Y8JuSvj13fBgvS2sEVvgzh4t/C9XCgmXJuVivpn3HS6QFlQKGkcwaCutG?=
 =?us-ascii?Q?TdfSwJgj5+XE2xg2yXAqqNOQyYby+4g14I0iBlsOVBwEeVEerX/vcPqJA8fa?=
 =?us-ascii?Q?wEVXaEdohbEbRHW3GDuJc3wLDLVOQ/ID8tn8JgWEkC/nGZbvFGvn3B4lhArh?=
 =?us-ascii?Q?mymISpV6Odu/6FaiTo5ePjVatGZoSzqbnQeeeCNdPRsIL2hDy49eSMGiuf9Q?=
 =?us-ascii?Q?9YEaLrrD2rC31arKn8kdoa7/eQe1wprDIZfE/9eF8ty3vw1r49YscKekmlEg?=
 =?us-ascii?Q?BUnmtbne3l2cHl2y52jybpc8pBo770rdAZ9JIwhdokkMF5Jdo2r54ugAE5Dz?=
 =?us-ascii?Q?BIuHzWx+B6/0y1TKiLAQZNQ6ZZTI4y2QEWCIF85OSD9nOPkMWggQUPhgvcdg?=
 =?us-ascii?Q?6P74Kjmubl1fzAD3xfGwseDABdRzvuxNbAxO6cFwY+UQlID9HgnbueOoJlyo?=
 =?us-ascii?Q?+J5wVp7ZIV+RXlM9yzPrYLVZthPBKC5sG4KlfN37OUZL5Ln9laddGTy+oyo4?=
 =?us-ascii?Q?gcHhfGqIdCuPMbjCReavU5oRbIh3Xm8KTJIVgIpdeUSmB5Pm7fS1KDw+Rinu?=
 =?us-ascii?Q?kKR3KR2lCrA4oKgViQtpiarPP+5SoOOA4UkSObwdhwyJCl9KNEKO5RYXzQGo?=
 =?us-ascii?Q?ax3upCSOa5GOMXhF+LAms/U931bMa9zqS4QF2EGNY6yEPzR+Z6Lh2yGbTdkP?=
 =?us-ascii?Q?qbHIGIBf+zSiSDlKVyw=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2025 08:08:31.4006
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9054e927-eed9-4d94-3daf-08de1e9e01a4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002315.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9104

Update the invs array with the invalidations required by each domain type
during attachment operations.

Only an SVA domain or a paging domain will have an invs array:
 a. SVA domain will add an INV_TYPE_S1_ASID per SMMU and an INV_TYPE_ATS
    per SID

 b. Non-nesting-parent paging domain with no ATS-enabled master will add
    a single INV_TYPE_S1_ASID or INV_TYPE_S2_VMID per SMMU

 c. Non-nesting-parent paging domain with ATS-enabled master(s) will do
    (b) and add an INV_TYPE_ATS per SID

 d. Nesting-parent paging domain will add an INV_TYPE_S2_VMID followed by
    an INV_TYPE_S2_VMID_S1_CLEAR per vSMMU. For an ATS-enabled master, it
    will add an INV_TYPE_ATS_FULL per SID

 Note that case #d prepares for a future implementation of VMID allocation
 which requires a followup series for S2 domain sharing. So when a nesting
 parent domain is attached through a vSMMU instance using a nested domain.
 VMID will be allocated per vSMMU instance v.s. currectly per S2 domain.

The per-domain invalidation is not needed until the domain is attached to
a master (when it starts to possibly use TLB). This will make it possible
to attach the domain to multiple SMMUs and avoid unnecessary invalidation
overhead during teardown if no STEs/CDs refer to the domain. It also means
that when the last device is detached, the old domain must flush its ASID
or VMID, since any new iommu_unmap() call would not trigger invalidations
given an empty domain->invs array.

Introduce some arm_smmu_invs helper functions for building scratch arrays,
preparing and installing old/new domain's invalidation arrays.

Co-developed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  17 ++
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 242 +++++++++++++++++++-
 2 files changed, 258 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 7b81a82c0dfe4..5899429a514ab 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -1094,6 +1094,21 @@ static inline bool arm_smmu_master_canwbs(struct arm_smmu_master *master)
 	       IOMMU_FWSPEC_PCI_RC_CANWBS;
 }
 
+/**
+ * struct arm_smmu_inv_state - Per-domain invalidation array state
+ * @invs_ptr: points to the domain->invs (unwinding nesting/etc.) or is NULL if
+ *            no change should be made
+ * @old_invs: the original invs array
+ * @new_invs: for new domain, this is the new invs array to update domin->invs;
+ *            for old domain, this is the master->build_invs to pass in as the
+ *            to_unref argument to an arm_smmu_invs_unref() call
+ */
+struct arm_smmu_inv_state {
+	struct arm_smmu_invs __rcu **invs_ptr;
+	struct arm_smmu_invs *old_invs;
+	struct arm_smmu_invs *new_invs;
+};
+
 struct arm_smmu_attach_state {
 	/* Inputs */
 	struct iommu_domain *old_domain;
@@ -1103,6 +1118,8 @@ struct arm_smmu_attach_state {
 	ioasid_t ssid;
 	/* Resulting state */
 	struct arm_smmu_vmaster *vmaster;
+	struct arm_smmu_inv_state old_domain_invst;
+	struct arm_smmu_inv_state new_domain_invst;
 	bool ats_enabled;
 };
 
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 26b8492a13f20..22875a951488d 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -3058,6 +3058,97 @@ static void arm_smmu_disable_iopf(struct arm_smmu_master *master,
 		iopf_queue_remove_device(master->smmu->evtq.iopf, master->dev);
 }
 
+/*
+ * Use the preallocated scratch array at master->build_invs, to build a to_merge
+ * or to_unref array, to pass into a following arm_smmu_invs_merge/unref() call.
+ *
+ * Do not free the returned invs array. It is reused, and will be overwritten by
+ * the next arm_smmu_master_build_invs() call.
+ */
+static struct arm_smmu_invs *
+arm_smmu_master_build_invs(struct arm_smmu_master *master, bool ats_enabled,
+			   ioasid_t ssid, struct arm_smmu_domain *smmu_domain)
+{
+	const bool e2h = master->smmu->features & ARM_SMMU_FEAT_E2H;
+	struct arm_smmu_invs *build_invs = master->build_invs;
+	const bool nesting = smmu_domain->nest_parent;
+	struct arm_smmu_inv *cur;
+
+	iommu_group_mutex_assert(master->dev);
+
+	cur = build_invs->inv;
+
+	switch (smmu_domain->stage) {
+	case ARM_SMMU_DOMAIN_SVA:
+	case ARM_SMMU_DOMAIN_S1:
+		*cur = (struct arm_smmu_inv){
+			.smmu = master->smmu,
+			.type = INV_TYPE_S1_ASID,
+			.id = smmu_domain->cd.asid,
+			.size_opcode = e2h ? CMDQ_OP_TLBI_EL2_VA :
+					     CMDQ_OP_TLBI_NH_VA,
+			.nsize_opcode = e2h ? CMDQ_OP_TLBI_EL2_ASID :
+					      CMDQ_OP_TLBI_NH_ASID
+		};
+		break;
+	case ARM_SMMU_DOMAIN_S2:
+		*cur = (struct arm_smmu_inv){
+			.smmu = master->smmu,
+			.type = INV_TYPE_S2_VMID,
+			.id = smmu_domain->s2_cfg.vmid,
+			.size_opcode = CMDQ_OP_TLBI_S2_IPA,
+			.nsize_opcode = CMDQ_OP_TLBI_S12_VMALL,
+		};
+		break;
+	default:
+		WARN_ON(true);
+		return NULL;
+	}
+
+	/* Range-based invalidation requires the leaf pgsize for calculation */
+	if (master->smmu->features & ARM_SMMU_FEAT_RANGE_INV)
+		cur->pgsize = __ffs(smmu_domain->domain.pgsize_bitmap);
+	cur++;
+
+	/* All the nested S1 ASIDs have to be flushed when S2 parent changes */
+	if (nesting) {
+		*cur = (struct arm_smmu_inv){
+			.smmu = master->smmu,
+			.type = INV_TYPE_S2_VMID_S1_CLEAR,
+			.id = smmu_domain->s2_cfg.vmid,
+			.size_opcode = CMDQ_OP_TLBI_NH_ALL,
+			.nsize_opcode = CMDQ_OP_TLBI_NH_ALL,
+		};
+		cur++;
+	}
+
+	if (ats_enabled) {
+		size_t i;
+
+		for (i = 0; i < master->num_streams; i++) {
+			/*
+			 * If an S2 used as a nesting parent is changed we have
+			 * no option but to completely flush the ATC.
+			 */
+			*cur = (struct arm_smmu_inv){
+				.smmu = master->smmu,
+				.type = nesting ? INV_TYPE_ATS_FULL :
+						  INV_TYPE_ATS,
+				.id = master->streams[i].id,
+				.ssid = ssid,
+				.size_opcode = CMDQ_OP_ATC_INV,
+				.nsize_opcode = CMDQ_OP_ATC_INV,
+			};
+			cur++;
+		}
+	}
+
+	/* Note this build_invs must have been sorted */
+
+	build_invs->num_invs = cur - build_invs->inv;
+	return build_invs;
+}
+
 static void arm_smmu_remove_master_domain(struct arm_smmu_master *master,
 					  struct iommu_domain *domain,
 					  ioasid_t ssid)
@@ -3087,6 +3178,146 @@ static void arm_smmu_remove_master_domain(struct arm_smmu_master *master,
 	kfree(master_domain);
 }
 
+/*
+ * During attachment, the updates of the two domain->invs arrays are sequenced:
+ *  1. new domain updates its invs array, merging master->build_invs
+ *  2. new domain starts to include the master during its invalidation
+ *  3. master updates its STE switching from the old domain to the new domain
+ *  4. old domain still includes the master during its invalidation
+ *  5. old domain updates its invs array, unreferencing master->build_invs
+ *
+ * For 1 and 5, prepare the two updated arrays in advance, handling any changes
+ * that can possibly failure. So the actual update of either 1 or 5 won't fail.
+ * arm_smmu_asid_lock ensures that the old invs in the domains are intact while
+ * we are sequencing to update them.
+ */
+static int arm_smmu_attach_prepare_invs(struct arm_smmu_attach_state *state,
+					struct arm_smmu_domain *new_smmu_domain)
+{
+	struct arm_smmu_domain *old_smmu_domain =
+		to_smmu_domain_devices(state->old_domain);
+	struct arm_smmu_master *master = state->master;
+	ioasid_t ssid = state->ssid;
+
+	/* A re-attach case doesn't need to update invs array */
+	if (new_smmu_domain == old_smmu_domain)
+		return 0;
+
+	/*
+	 * At this point a NULL domain indicates the domain doesn't use the
+	 * IOTLB, see to_smmu_domain_devices().
+	 */
+	if (new_smmu_domain) {
+		struct arm_smmu_inv_state *invst = &state->new_domain_invst;
+		struct arm_smmu_invs *build_invs;
+
+		invst->invs_ptr = &new_smmu_domain->invs;
+		invst->old_invs = rcu_dereference_protected(
+			new_smmu_domain->invs,
+			lockdep_is_held(&arm_smmu_asid_lock));
+		build_invs = arm_smmu_master_build_invs(
+			master, state->ats_enabled, ssid, new_smmu_domain);
+		if (!build_invs)
+			return -EINVAL;
+
+		invst->new_invs =
+			arm_smmu_invs_merge(invst->old_invs, build_invs);
+		if (IS_ERR(invst->new_invs))
+			return PTR_ERR(invst->new_invs);
+	}
+
+	if (old_smmu_domain) {
+		struct arm_smmu_inv_state *invst = &state->old_domain_invst;
+
+		invst->invs_ptr = &old_smmu_domain->invs;
+		invst->old_invs = rcu_dereference_protected(
+			old_smmu_domain->invs,
+			lockdep_is_held(&arm_smmu_asid_lock));
+		/* For old_smmu_domain, new_invs points to master->build_invs */
+		invst->new_invs = arm_smmu_master_build_invs(
+			master, master->ats_enabled, ssid, old_smmu_domain);
+	}
+
+	return 0;
+}
+
+/* Must be installed before arm_smmu_install_ste_for_dev() */
+static void
+arm_smmu_install_new_domain_invs(struct arm_smmu_attach_state *state)
+{
+	struct arm_smmu_inv_state *invst = &state->new_domain_invst;
+
+	if (!invst->invs_ptr)
+		return;
+
+	rcu_assign_pointer(*invst->invs_ptr, invst->new_invs);
+	/*
+	 * We are committed to updating the STE. Ensure the invalidation array
+	 * is visable to concurrent map/unmap threads, and acquire any racying
+	 * IOPTE updates.
+	 */
+	smp_mb();
+	kfree_rcu(invst->old_invs, rcu);
+}
+
+/*
+ * When an array entry's users count reaches zero, it means the ASID/VMID is no
+ * longer being invalidated by map/unmap and must be cleaned. The rule is that
+ * all ASIDs/VMIDs not in an invalidation array are left cleared in the IOTLB.
+ */
+static void arm_smmu_invs_flush_iotlb_tags(struct arm_smmu_inv *inv)
+{
+	struct arm_smmu_cmdq_ent cmd = {};
+
+	switch (inv->type) {
+	case INV_TYPE_S1_ASID:
+		cmd.tlbi.asid = inv->id;
+		break;
+	case INV_TYPE_S2_VMID:
+		/* S2_VMID using nsize_opcode covers S2_VMID_S1_CLEAR */
+		cmd.tlbi.vmid = inv->id;
+		break;
+	default:
+		return;
+	}
+
+	cmd.opcode = inv->nsize_opcode;
+	arm_smmu_cmdq_issue_cmd_with_sync(inv->smmu, &cmd);
+}
+
+/* Should be installed after arm_smmu_install_ste_for_dev() */
+static void
+arm_smmu_install_old_domain_invs(struct arm_smmu_attach_state *state)
+{
+	struct arm_smmu_inv_state *invst = &state->old_domain_invst;
+	struct arm_smmu_invs *old_invs = invst->old_invs;
+	struct arm_smmu_invs *new_invs;
+	size_t num_trashes;
+
+	lockdep_assert_held(&arm_smmu_asid_lock);
+
+	if (!invst->invs_ptr)
+		return;
+
+	num_trashes = arm_smmu_invs_unref(old_invs, invst->new_invs,
+					  arm_smmu_invs_flush_iotlb_tags);
+	if (!num_trashes)
+		return;
+
+	new_invs = arm_smmu_invs_purge(old_invs, num_trashes);
+	if (!new_invs)
+		return;
+
+	rcu_assign_pointer(*invst->invs_ptr, new_invs);
+	/*
+	 * We are committed to updating the STE. Ensure the invalidation array
+	 * is visable to concurrent map/unmap threads, and acquire any racying
+	 * IOPTE updates.
+	 */
+	smp_mb();
+	kfree_rcu(old_invs, rcu);
+}
+
 /*
  * Start the sequence to attach a domain to a master. The sequence contains three
  * steps:
@@ -3144,12 +3375,16 @@ int arm_smmu_attach_prepare(struct arm_smmu_attach_state *state,
 				     arm_smmu_ats_supported(master);
 	}
 
+	ret = arm_smmu_attach_prepare_invs(state, smmu_domain);
+	if (ret)
+		return ret;
+
 	if (smmu_domain) {
 		if (new_domain->type == IOMMU_DOMAIN_NESTED) {
 			ret = arm_smmu_attach_prepare_vmaster(
 				state, to_smmu_nested_domain(new_domain));
 			if (ret)
-				return ret;
+				goto err_unprepare_invs;
 		}
 
 		master_domain = kzalloc(sizeof(*master_domain), GFP_KERNEL);
@@ -3197,6 +3432,8 @@ int arm_smmu_attach_prepare(struct arm_smmu_attach_state *state,
 			atomic_inc(&smmu_domain->nr_ats_masters);
 		list_add(&master_domain->devices_elm, &smmu_domain->devices);
 		spin_unlock_irqrestore(&smmu_domain->devices_lock, flags);
+
+		arm_smmu_install_new_domain_invs(state);
 	}
 
 	if (!state->ats_enabled && master->ats_enabled) {
@@ -3216,6 +3453,8 @@ int arm_smmu_attach_prepare(struct arm_smmu_attach_state *state,
 	kfree(master_domain);
 err_free_vmaster:
 	kfree(state->vmaster);
+err_unprepare_invs:
+	kfree(state->new_domain_invst.new_invs);
 	return ret;
 }
 
@@ -3247,6 +3486,7 @@ void arm_smmu_attach_commit(struct arm_smmu_attach_state *state)
 	}
 
 	arm_smmu_remove_master_domain(master, state->old_domain, state->ssid);
+	arm_smmu_install_old_domain_invs(state);
 	master->ats_enabled = state->ats_enabled;
 }
 
-- 
2.43.0

