Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012042.outbound.protection.outlook.com [52.101.43.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB8F133291B
	for <iommu@lists.linux.dev>; Mon, 27 Oct 2025 18:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761591309; cv=fail; b=lmNKxY+Bf82fI17GPtavOtAjCuMXOrYBFsQF+pft85LIy7AyiXzsxIu0mo0nR46cDamyMg+tLAQhAMjDsxhyH/kSk4SKOlX6BvNw922HQ0lzefjLa3mgWVirtptyROKA7ayd6h+nj+CfFk9jegPqlTPQ9kHmbAWSuC6LrcIsnAg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761591309; c=relaxed/simple;
	bh=0rnMmUCxbw5yZCoVuOgw4JJeUYrSDdE9YotorC8Ki+o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tgxSwAQqRGDKxdlIl6YDq9cdcOmKrZCPJPm3Jc3KMNhUA6hbY7IOvNJHGHNrz9uvBXAI5G1qMIbPjCUvahBl6MERaxO2sR3DGQh+6/kJAGJYnR2tMq1KHeiUevDc4E8x+aIlwYaxyCpY3fOlLhYKYHyDTOvNd4iNHnsmC9NkKc0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OeU0vpoO; arc=fail smtp.client-ip=52.101.43.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OeU0vpoO"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P44Kc73aWXcH5RxeM/8P+L8KWXQ0l6uhySm4rLnH3y8b2P5l//JKdseENz46jAU3b1wgULkkpzXNbtJA+h25SjA7j77qKjnWzmwlZWB9hEYjlDueZPH+xY3kpGu7qrfTWlmuMm/TihAAWr7pOuT0gWSgQRUZBhv7DbfiixpeWYFFUZ5lN1CiUEmzkTFT6gogM5NwOzNeWjyrmqC9BT2GdX/aC6phy62K//aTH7IvKimz3DIZ2hOAaDlixlkFxx8L3vPJWhc2X09sw5vK8aFCZz77cpowveW7YwJ6zgDJD8IwKXQN/4AhcMJuUQua9ApOXVTNA0GnhAkYwYoffCEGzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gf4UpIAyvJ/qFDkwiezyGuPVHQjSQddUGHX5e7zK3PU=;
 b=wvuJYbib8XnCcM6sHy4EfhFmCksHA327jZw6aT3ygaOKB/tUERNKljYlFBOpSDt52bK74cJeZ2DJ2NW9WbKFDUZ1qbrAiRLwa5m52MCOBiWK5yHziM/gzWuOaBRat0X8K/BD8yvs10Bcv7GGGPQptXmSZ4I3/CKa88pxTuRrbWs5RtJa3YclKEnKcRhWUV9SRArCgrh6tYnhkSPw4fCV7DcbT8X1ec2pYfY/qWllduwUHN3SXSiR/1HbG9P/EayiqarTxOY//w1KdnsLjSxQDNrYbZKEC3iJhwzX2KWiZDNP60DtlkitOYVid3sImjKFkl4vE9wdK5o6t94/QOAepg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gf4UpIAyvJ/qFDkwiezyGuPVHQjSQddUGHX5e7zK3PU=;
 b=OeU0vpoO5tescYc9Bdb3fcxh++VFXiCBhU2bs7pqR2IrtEgcU/xfsBBLhL9f/Hn7XkR4ip5iuAXVJzgIoL2u2GNtFuRfB6D0fopdJ9ZIbVVj6E9BdXiAHDAL1Ohg7dhQOCzC+Wh5ocsnTwJ9UOClMb23TTTdvsrpbu2UTyhZexdrv6VBlHquIRt3dSXzI/+et5kLTPfue7C83yTLed2jFhsVvZMPXQ2c6wsCH79N1wln9D9oPCkP9VHM0hWbxsN89OWM92s6+y9hQssiZP1KD0bMWzMzGN2UrZtJpUU3yjjwAEiOiLaz5kFSgoAEV4xw2OogZAHkqnQ27yN+KTTdRw==
Received: from SA9PR13CA0056.namprd13.prod.outlook.com (2603:10b6:806:22::31)
 by DS0PR12MB7945.namprd12.prod.outlook.com (2603:10b6:8:153::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Mon, 27 Oct
 2025 18:54:55 +0000
Received: from SN1PEPF0002636E.namprd02.prod.outlook.com
 (2603:10b6:806:22:cafe::a9) by SA9PR13CA0056.outlook.office365.com
 (2603:10b6:806:22::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.12 via Frontend Transport; Mon,
 27 Oct 2025 18:54:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF0002636E.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Mon, 27 Oct 2025 18:54:55 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.34; Mon, 27 Oct
 2025 11:54:39 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 27 Oct
 2025 11:54:38 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 27 Oct 2025 11:54:37 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>, <jgg@nvidia.com>
CC: <jean-philippe@linaro.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<balbirs@nvidia.com>, <miko.lenczewski@arm.com>, <peterz@infradead.org>,
	<kevin.tian@intel.com>, <praan@google.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v4 5/7] iommu/arm-smmu-v3: Populate smmu_domain->invs when attaching masters
Date: Mon, 27 Oct 2025 11:54:19 -0700
Message-ID: <82f22b35e9d020efadcbac86564b609b08619f82.1761590851.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1761590851.git.nicolinc@nvidia.com>
References: <cover.1761590851.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636E:EE_|DS0PR12MB7945:EE_
X-MS-Office365-Filtering-Correlation-Id: ef4f2ed2-75e0-4ad7-cf68-08de158a51cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?a8U9HeNamCG/0SsJT8PAlKuacIcscV023RGZO9QnMe7KTBkgXUbYjFfrBxJe?=
 =?us-ascii?Q?0lkrLnl68hZ+E5JSuV+nbu+MWjy3LHQ4ObRPKwtnGenhGLoxpdvyJPDVSKDh?=
 =?us-ascii?Q?xY79T/p1qovnAptWK4V35Rbt6vkwTHwgTe0mrKE3LGUYNW3P40LitogfufZV?=
 =?us-ascii?Q?DAUPnVITIx3fPXAfbbGyKr2WVWhs6ce2hgUKIxEkyOTwgM5RQ50NE0AOVDuC?=
 =?us-ascii?Q?VnVmYv1ioH5mIco0V4c5izoBxBSho8Z6jc+7oSQ3NZLnTnTeUDyTfnFAfpuL?=
 =?us-ascii?Q?ddd2FvuJBVeDpiPN4L6MYqPdvjdCa5knTwiA77c3DCfmdKdJ1mn+ZsBqE5Mm?=
 =?us-ascii?Q?95PFicDvIDb0pILpzp6VecauLV/KXkR1emYECVhrVqfeXI5mBjQd0PfROzJk?=
 =?us-ascii?Q?AGaGRihbc3CQQX7SCQPpnJ8RMpKlGDN36CJSssJVlN7C7f4uxLLclbi4gM6u?=
 =?us-ascii?Q?g9hb8UcQzXHkCJy29V0jEDFZu7qYoKrDN659A9uFTM7gTcjaQSR2l6T5Z1pU?=
 =?us-ascii?Q?vfoIhsobaRe5y1ckjsr/mzl9Dwlp0DwblX1kZ6LiPqiEl/jO6aflGZt5eORC?=
 =?us-ascii?Q?/NGjEipxTywpstM4FctOepG5kKAhuyjun8NkVsygkX5ZpzMK5BbHdTCkV8k7?=
 =?us-ascii?Q?7esbiyuKqK5CPQLpYABHWp5bbQLyIt9QPtYecAxu/DtP0zYZ5YI//5nQSByW?=
 =?us-ascii?Q?A25xor/ahFAi6WEQheQuKh/paLshlFcR4Nv3kE5TAtNANSrwKfRhGUfcHURb?=
 =?us-ascii?Q?6VfVTNojiMJ4CEhyjuKn/x7i8OckXoN8uChUWeOoTGqgCvhehcjgMU9iRcRe?=
 =?us-ascii?Q?tRZrobRKMn6nxqzx1XpwZYArdpfYoxrbcWP/49wiqVROhzjjOfc3DGw0SmFP?=
 =?us-ascii?Q?xFyZc/48y447HmbFydc+hKA0/04Ti8xCrkN84EBVW5KB0cJZ/croseK3+iG/?=
 =?us-ascii?Q?2nSJ5TFwChqpR0krVfYtfMR5inBP7ZY1jEmDQ01y8eF6Kf7sRze+Kb0fmYBG?=
 =?us-ascii?Q?3HGpgi1myoNnTZd26aH2BHSuLT7D2ohLmFiN2VVAtmP6zsS0jZlAviOxHp0W?=
 =?us-ascii?Q?yPJjkM99kXMweSO2GhSj1C/vJNJP+pNalrQrCvtop+k07JB1LGUYg6AyQSxS?=
 =?us-ascii?Q?wSkaZb7fYtS8QPiZ4jk7wcrgIVN0+lwj7rC9acOhpVW6+5+RvGjueGv6QNQP?=
 =?us-ascii?Q?G9QusrV4CG2GkuuHIYjeeXikQNO+wIbDvwBhLT+VRHW3V8L1NT6+meKQ3ij2?=
 =?us-ascii?Q?khb0Zao0oV84GlZjoP5fwDMrgR5suFV/1iicBZXVpRH7FGLa6IJmFmwzwXo1?=
 =?us-ascii?Q?LSajfigIQnRBd2Fgw+1SUsRHWzFaEPDJ5ngidbIAdsaLog/q/9OwxWoy6UFU?=
 =?us-ascii?Q?s6CkQFjPt1k/vlwUDdXh79g2pJEShceILriS+yepXC0Md2Ld9haQHESz3OfA?=
 =?us-ascii?Q?ByRlJfgWOh044D79Qd6gm3vnPrPJn4APM3t+L6h1hW24k9sGhVZ3fdA6t5/T?=
 =?us-ascii?Q?B+sHw+d0cD0SXr/WYB4Am0E/ELE982iNRW3G62PrBBq/w0zJiYW5dyezkXrH?=
 =?us-ascii?Q?yNgqNYtsyrAzYdrxyJ4=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2025 18:54:55.4154
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ef4f2ed2-75e0-4ad7-cf68-08de158a51cd
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002636E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7945

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
index b8a4bda12b571..b0dd9ff846f75 100644
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
+	struct arm_smmu_invs __rcu **invs_ptr;
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
index f01c2a6b40cd5..f638c344b754e 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -3051,6 +3051,97 @@ static void arm_smmu_disable_iopf(struct arm_smmu_master *master,
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
@@ -3080,6 +3171,146 @@ static void arm_smmu_remove_master_domain(struct arm_smmu_master *master,
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
@@ -3137,12 +3368,16 @@ int arm_smmu_attach_prepare(struct arm_smmu_attach_state *state,
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
@@ -3190,6 +3425,8 @@ int arm_smmu_attach_prepare(struct arm_smmu_attach_state *state,
 			atomic_inc(&smmu_domain->nr_ats_masters);
 		list_add(&master_domain->devices_elm, &smmu_domain->devices);
 		spin_unlock_irqrestore(&smmu_domain->devices_lock, flags);
+
+		arm_smmu_install_new_domain_invs(state);
 	}
 
 	if (!state->ats_enabled && master->ats_enabled) {
@@ -3209,6 +3446,8 @@ int arm_smmu_attach_prepare(struct arm_smmu_attach_state *state,
 	kfree(master_domain);
 err_free_vmaster:
 	kfree(state->vmaster);
+err_unprepare_invs:
+	kfree(state->new_domain_invst.new_invs);
 	return ret;
 }
 
@@ -3240,6 +3479,7 @@ void arm_smmu_attach_commit(struct arm_smmu_attach_state *state)
 	}
 
 	arm_smmu_remove_master_domain(master, state->old_domain, state->ssid);
+	arm_smmu_install_old_domain_invs(state);
 	master->ats_enabled = state->ats_enabled;
 }
 
-- 
2.43.0

