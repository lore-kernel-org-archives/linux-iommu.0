Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013058.outbound.protection.outlook.com [40.93.201.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5595930276F
	for <iommu@lists.linux.dev>; Wed, 15 Oct 2025 19:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760557413; cv=fail; b=Yb+lDvASoUKL0Y6Bl3Khh18Q1Wrm+ZAqKWGx4PNca8BrHFaRUDnj4rGJ6qVBNis2ctYgMoYTHiLfUKenPDG4I6bKD4zleVVp0IOSXCMkKDYdsGjNzd1S1tkr03PtdyzHQPnPiTogCByQiYSAgrEWrnIzRfxNRY23spgTOoKXGPQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760557413; c=relaxed/simple;
	bh=B5Q+NC8ak2TfzXKbB9SYJPEyVHWqkqaUIHpPZ+JS9zc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K41OapzZ0e3uZnKmZmDWcT1idxb/c7RETk8VMBGo9VDoiYoRCaL98fQyka+gNw3jRgCZ7jUYZpjFOPj6zVx0H1dl/6F7/x2uE9x8mp9bHh+k/Ht5l6f7BqH8GY/iIb1brkw9FD5zHrCKf9NPTp9JQXujLdb8/SoAVmyIqpIj4Dw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=AbK6Axz9; arc=fail smtp.client-ip=40.93.201.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="AbK6Axz9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OG8roeMlD2h1X2kvpmD9FYcePp7yqSq5sLLtpgcrgLaw4UqbcR3q3/LOGClwajdgYwvIPXXqX2XjsnDK+6z/ntjYcCMxfON8r/Cbn0rydWCoY5tFcurYXCAZvgxCtJFX1muFYETTjPo0SfVuuy4YBL38gmJDiJzHp1olqQFRVhQJErr+PnpK8+RBiGuOuTONeYV9kj4Yj1Ox5PXOE2dRHbQeUjnyErpvUuSaXs9aZGBKPVJLfeEzuSQFQNH8x4iOBzPeOXS51264hYIWYshOkWB5K1b7rg8aFW+hwv8k3G9Zo3+8CweEw/XUfKjt6lmmGaldyRSSdSK+22ea6E8q6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l1wAxCeY9sFlYkjUfv89pYM0aTi66xN8p9zAuCU5Q0A=;
 b=cN5hXV+advOU+WLG2t3ql2Hujpk9LjkoTO/47y+3JQmGrn1YXH4983lxjCTlk3AWEquV3oT40J/tfUzLjgjsaoql8WcpNY8RLicJfb2kzCllBFxRnaaAHW+PzXr1ikP4f3sCgTBLqxPDnLwcsEjfe9qnzJeD6rlJyP6GKueYCmNwp9/1bRdQ65r85uIQdruegcu2FCF+MoKfZwhmcBvgGk9Ga2ZenCjDYEjSbHo/qh/l9o+vAF/f0FSowOo9SeEqzhI+HUaNluQtfGYNHcTcjQa0LESerEwWh0R35E6c6SNRbhkn+BB6/q4Cpgxtns40iBmAtc9x8PuSHQgUErxGZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l1wAxCeY9sFlYkjUfv89pYM0aTi66xN8p9zAuCU5Q0A=;
 b=AbK6Axz9V28ZKOuFfVLuK0rBN2Tz+A/aWeFMPp+j11kmn3x1EA/egPSOUeDJsz6VgyBWWfUGXxoSrum2peGKLfgFwclX4Q1qrfLvyZ8h0TW0eow8tHSnWh9U4fsTvooEz7itWdp+hF/Vh3oFCPP5D06D6VOMBac/kj78NceGkV82QRgFlz7p2RKtoNJsD7kIH+VTjPuVIC8ZadZ4xHdWLDjKRMgO0hH3oEhypL172VH7X8KEqmsxIL4XeuAvfSNwxd5dhCqBR3fF+AODYgiwxC+5j6UlImXVhH1dwurOdKHjz0Q9gYHToFgZIZfgwhLRX5rXn7MhqDj1Pf1wb0irZA==
Received: from SJ0PR13CA0007.namprd13.prod.outlook.com (2603:10b6:a03:2c0::12)
 by SJ0PR12MB6901.namprd12.prod.outlook.com (2603:10b6:a03:47e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.10; Wed, 15 Oct
 2025 19:43:26 +0000
Received: from MWH0EPF000A6730.namprd04.prod.outlook.com
 (2603:10b6:a03:2c0:cafe::a1) by SJ0PR13CA0007.outlook.office365.com
 (2603:10b6:a03:2c0::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.10 via Frontend Transport; Wed,
 15 Oct 2025 19:43:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MWH0EPF000A6730.mail.protection.outlook.com (10.167.249.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.7 via Frontend Transport; Wed, 15 Oct 2025 19:43:26 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 15 Oct
 2025 12:43:07 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 15 Oct
 2025 12:43:07 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Wed, 15 Oct 2025 12:43:06 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>, <jgg@nvidia.com>
CC: <jean-philippe@linaro.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<balbirs@nvidia.com>, <miko.lenczewski@arm.com>, <peterz@infradead.org>,
	<kevin.tian@intel.com>, <praan@google.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v3 5/7] iommu/arm-smmu-v3: Populate smmu_domain->invs when attaching masters
Date: Wed, 15 Oct 2025 12:42:50 -0700
Message-ID: <14d76eebae359825442a96c0ffa13687de792063.1760555863.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1760555863.git.nicolinc@nvidia.com>
References: <cover.1760555863.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6730:EE_|SJ0PR12MB6901:EE_
X-MS-Office365-Filtering-Correlation-Id: 03baa165-8486-4996-9dd2-08de0c231be5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0hqm71FBWxn3XgUaEIBb/PRyPzDOGaxpeWRgtkmIyzpWQNJSMPw/SbheQ49Z?=
 =?us-ascii?Q?SKwu+pCTiOvJ4XwdQjqsVm7tg7g4ib11afYZsIqlsO8PtC4Cx1ZSlBJCEKd7?=
 =?us-ascii?Q?jeFs4IcLNxCsTwBxARUZj3FAk7cua2Oi9sDj6cp+BVDZDPU+1gpqmAhN5t1w?=
 =?us-ascii?Q?a+AD7Iyb+ueVxwFFCph5LWnrUqMgh54aSbRUsABBFG0MyrqD7KYpdXTGbTOx?=
 =?us-ascii?Q?1THRbI7truEV1QoayW0IOr4tnm7GyxYZ+l1WW+GHkE6lVkbhUTfMZVcWcW0M?=
 =?us-ascii?Q?Zr5raZTDy8i2+cRoux27dBF2bA7CWA0u8/3uzmHHM8QO3h2EB62mrD9/gFhu?=
 =?us-ascii?Q?qCXXH+2u4RPNpMrkDiLstuQOQCL6jLzpAOnGZ98/37LIGAHXXW/XtTEiujwe?=
 =?us-ascii?Q?nKrZhDIB4f+A12IqfxwgGOazUtZc6raka0ACuMfV+Nqw6q8gxOAOt3eRe33g?=
 =?us-ascii?Q?V6qYoq04T8J/IP8EZQd0YO+RBXf7L4LlYVXD8JVxH0I51RU7OyJZ8aY+kWfr?=
 =?us-ascii?Q?0BzGJZu8X1RpRvq5m6j82j3RIrLwW7quZ5BEpOznM3bGI4uq1PRqZ3CH1/Qt?=
 =?us-ascii?Q?ciF+EoyDYxOb3Pi99MrXIlFtUij8qaEhM+/OkUREd26WCJ3pmLwvVUHy5keJ?=
 =?us-ascii?Q?XPSpFOcjH84rN61762oNS0pVd5AjBX6eKTSt8HlVobWCC6jdKDkbVr1F2xr/?=
 =?us-ascii?Q?ewL7EpnG+Mzq5M6mLJMvGPIzBQWtq7znx48Ii6chRdv7eNDKokaUyjnzW3+n?=
 =?us-ascii?Q?88ADgcTNnQc9ItvLljloZ18U43Dema2yQz3UHctViZHLa1t7MBG/LyFMrp3o?=
 =?us-ascii?Q?G1bMTnWt3ciOAAhgeLd8UDgPr7ArHq4QhOfGTFm9kph8/K3GpY+FIIXAw/y8?=
 =?us-ascii?Q?FDMKJ/+H6UdS/tBnv6SKhQiidpjvt7gI7/zwKmomh/mu053hXrt3W7r2DKK5?=
 =?us-ascii?Q?De2RlxehctwojaUf4tcj9BJXoSWZ5jDWdhQhRR/uJzWVk3YW1AJrdtODj4tK?=
 =?us-ascii?Q?UgFew7bcZh8ysMU8bg5xdk2bs8M+ANtQ4FF24eRi8TCOL6n57evjITEbV84I?=
 =?us-ascii?Q?hvsCtSYvqYl3mN+o+iDyEz0XZEKlxnhkN4V49NR1LCgDSeZP1+njSDrC/2uf?=
 =?us-ascii?Q?Y9Ab5FuI9sTw8ucX/s1xc9EWuab+k5AtkCgIN1QKn/Kpa8LFXlRjvi4g8Qx/?=
 =?us-ascii?Q?SNqcouxzpXZ1ARbP7fh1i84xCfbF7AHtIUMQY6SDM51AIgV6tn3MzEKYsd8k?=
 =?us-ascii?Q?HzAgoaykiPGE7MJiF+bfYJoGoHxJTlzCiOD/XvbCGJUKLh3MA5Arf7MxqoBX?=
 =?us-ascii?Q?IEnQ/hBOQ5yxalWvB2cEP8+E7pLtY3ElEsQm8ArsB68mAlvBvMeWdZxcAIK4?=
 =?us-ascii?Q?2ElAVznPkHxQ279VAWb+r3yu+ph7k1zBlUvqGAaat8HWYZqrFMsesTFGEm9E?=
 =?us-ascii?Q?pzTfK+sbJpesmZDx0GmLZ/zFUm5KZle/ShLtnHqv7YUrzmHseEfYg4WukVLX?=
 =?us-ascii?Q?iYQHhasmjtTBQ6Z0HMslnK3aTKia7YhOQJGiN8n942R7JefkkC3mtmYJ5ERr?=
 =?us-ascii?Q?VL61sx11mwpMdKIl1mk=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2025 19:43:26.3178
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 03baa165-8486-4996-9dd2-08de0c231be5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A6730.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6901

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
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  17 ++
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 242 +++++++++++++++++++-
 2 files changed, 258 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index c43b2ffef8a4d..b1dbcc6747baa 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -1093,6 +1093,21 @@ static inline bool arm_smmu_master_canwbs(struct arm_smmu_master *master)
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
+	struct arm_smmu_invs **invs_ptr;
+	struct arm_smmu_invs *old_invs;
+	struct arm_smmu_invs *new_invs;
+};
+
 struct arm_smmu_attach_state {
 	/* Inputs */
 	struct iommu_domain *old_domain;
@@ -1102,6 +1117,8 @@ struct arm_smmu_attach_state {
 	ioasid_t ssid;
 	/* Resulting state */
 	struct arm_smmu_vmaster *vmaster;
+	struct arm_smmu_inv_state old_domain_invst;
+	struct arm_smmu_inv_state new_domain_invst;
 	bool ats_enabled;
 };
 
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 97f52130992cd..9f7945c98e3c7 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -3052,6 +3052,97 @@ static void arm_smmu_disable_iopf(struct arm_smmu_master *master,
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
@@ -3081,6 +3172,146 @@ static void arm_smmu_remove_master_domain(struct arm_smmu_master *master,
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
@@ -3138,12 +3369,16 @@ int arm_smmu_attach_prepare(struct arm_smmu_attach_state *state,
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
@@ -3191,6 +3426,8 @@ int arm_smmu_attach_prepare(struct arm_smmu_attach_state *state,
 			atomic_inc(&smmu_domain->nr_ats_masters);
 		list_add(&master_domain->devices_elm, &smmu_domain->devices);
 		spin_unlock_irqrestore(&smmu_domain->devices_lock, flags);
+
+		arm_smmu_install_new_domain_invs(state);
 	}
 
 	if (!state->ats_enabled && master->ats_enabled) {
@@ -3210,6 +3447,8 @@ int arm_smmu_attach_prepare(struct arm_smmu_attach_state *state,
 	kfree(master_domain);
 err_free_vmaster:
 	kfree(state->vmaster);
+err_unprepare_invs:
+	kfree(state->new_domain_invst.new_invs);
 	return ret;
 }
 
@@ -3241,6 +3480,7 @@ void arm_smmu_attach_commit(struct arm_smmu_attach_state *state)
 	}
 
 	arm_smmu_remove_master_domain(master, state->old_domain, state->ssid);
+	arm_smmu_install_old_domain_invs(state);
 	master->ats_enabled = state->ats_enabled;
 }
 
-- 
2.43.0

