Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012023.outbound.protection.outlook.com [40.107.200.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 779A62E0B48
	for <iommu@lists.linux.dev>; Tue, 16 Dec 2025 02:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765851034; cv=fail; b=AS1oAO9t0zkYkPHu6nn54dJkZGUUaFt2x/KYmcY3SqUZwsGI9ljyAKsMT+sN7WGFTOXSazL5SkILCd+ymCJWhGkYwXy93hzPPEfs6QptVzkKBsfOCIQVDq+i/pAXnm7LI27UF+dhNEZSlm3YCmyGYBYhpUx3s1W12kwC5rAwJRw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765851034; c=relaxed/simple;
	bh=FC9KIgEfacK3ek1ARPbynBc5fwdSUQMf+GOBFxjhrqU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R3Eqt/FVscYzlM0qdWdSNvVZFIWrwOaG347+s8vb8DkIBvIRy7OVlrSWyOKorUzX5Nt6H61DR1liv1wf4kuqoGGm+KlsncUjrmepAvB0sBPKNH8xy/iV1laoF1j5V+2U4BfD1b8LA7eQhpvnAye0dtEVEwIL4epD6V7CIqk+Yac=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fJP/NHry; arc=fail smtp.client-ip=40.107.200.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fJP/NHry"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KaT/TyH9g9Yze3omJQALe+xa53Qt4wvjcGgdnpC0hULEzxBi+rs2q1UrMADCIrTRrRBRbITSuTyFxnRmTgmbvtd6hkNbdHQi8uGPplzr+lnRIXqMdL7LOnAweYl03+8a1ptJs7/9crGLCXX5esT9gqBckRHUhxjC9Bo/8gqTrbIpDHQ4hPIQLVWuMaj1L067lvj+2yLaApjyPsrER5Kb3qAas1ERyFfrBYymW0j/5eDlqdFkeb4LrAES8RYcdLxXUCXPJWJB43gI2dsF0qDV8e9PdllgTshLEaMdU29r2ZcSfAD89w3DJnkCSX1BPN6LdnbgTwaRt6/oowlYbjNa6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rdTJgEx7rqVxMuIj0bXh2lvAZFcAiv5iBQg+n1jcwyA=;
 b=GIc7eK8nnRsEqrSV1fCqpFvPOU2HSjGL0PKbFoj5pC8Z+9YCQkmUU/bZwluo0MOxq0F5RjSln7aFIwaYinB6h5bdfawZm6IGXIU7L0OYCJeGnU0H4OsTyuYGbQBBS9Wzcu8gNIO+DxO1oitoqh3IXQOiDZnmExAS0+9iuzHiw8WSKvv22lyHmdSrxMExl7v3unW2szIgcI06ZBHrsFUnWCoAiBsgYgLPNRfzcf6U48OTdncMNxU/J7A2W5H4kdmyV2LTv0j0qcrvQmdzPOiJKzSYGt+FtTFpWHskPF/jdwvWFdcZ0/zUMcT7Qtq2vIGuIUJ7aKbIcABHoLP14WUSjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rdTJgEx7rqVxMuIj0bXh2lvAZFcAiv5iBQg+n1jcwyA=;
 b=fJP/NHry2GnMZEtGXBrkCvlsD3WZUHgfa8p/jc8zM79D50zqv9GkTWnDSd1aa1lTYXLnGHPmMKIlGTebL/5wVoiszoYZILkPDmCYHic4uo6g+1yqGd9EhgunRTSCcrgnB9Kr2dsnkFCBIZoBUDPLD22uk0DQtlr9sSXkogYY0jiYK7f3Gt2NhrFsy26TX0Snmpye8pUF0d8Iw8Mk2vEMtD0sL5f6U1etjVpIRnXDYMSkrm9perJdvNh6mWpHEx+rRaTxHbKkZbZjWsd913hQ8ZkWn5ULkZHYFdyA3B2bXf3BaRtn15U0oDCh6E1q/tPqFQ5I6xpvLVcQnhtgYW93zw==
Received: from DM6PR02CA0060.namprd02.prod.outlook.com (2603:10b6:5:177::37)
 by DS0PR12MB9422.namprd12.prod.outlook.com (2603:10b6:8:1bb::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Tue, 16 Dec
 2025 02:10:22 +0000
Received: from DS3PEPF000099DC.namprd04.prod.outlook.com
 (2603:10b6:5:177:cafe::b1) by DM6PR02CA0060.outlook.office365.com
 (2603:10b6:5:177::37) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9412.13 via Frontend Transport; Tue,
 16 Dec 2025 02:10:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS3PEPF000099DC.mail.protection.outlook.com (10.167.17.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.6 via Frontend Transport; Tue, 16 Dec 2025 02:10:22 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 15 Dec
 2025 18:10:07 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 15 Dec
 2025 18:10:06 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 15 Dec 2025 18:10:05 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>
CC: <jean-philippe@linaro.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<jgg@nvidia.com>, <balbirs@nvidia.com>, <miko.lenczewski@arm.com>,
	<peterz@infradead.org>, <kevin.tian@intel.com>, <praan@google.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v7 5/7] iommu/arm-smmu-v3: Populate smmu_domain->invs when attaching masters
Date: Mon, 15 Dec 2025 18:09:34 -0800
Message-ID: <c8054b08a73214eb99a7e7cbe68fd19cb0eefc64.1765850465.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1765850465.git.nicolinc@nvidia.com>
References: <cover.1765850465.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DC:EE_|DS0PR12MB9422:EE_
X-MS-Office365-Filtering-Correlation-Id: bf2f084a-c582-46a0-ce26-08de3c484522
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dwXPdM96KYhDOBBnNbtq/zWTVntihonk+C1NUhUgOAX4NDmlVCnAb1uT00Ot?=
 =?us-ascii?Q?6a0bThGOje/gBKTKJVAOEar5J+ZD+dwPKVemRLWetkfFgOs+rPxbC0qhV6hR?=
 =?us-ascii?Q?7bvZMfMtzORhbDK2VYQCdCgXMOrJZoRhRkkXpxKIcrzv5ebtq5y2cawjxEQw?=
 =?us-ascii?Q?zqI42jg3qD23BG29AUzGJ0vzBHPaIDrAcLL6FkK2r2o0gHVJ4CYT4TyFDtrz?=
 =?us-ascii?Q?zSGEoI15v5UEjXpyRy/V/6319q1eyVEun4wYambAjdEd9XFeTpAonDNcbfqD?=
 =?us-ascii?Q?ZZzdDLkKWjy6feuFD2XPmqY1tyg5xVvKaoQ5FzChhKPSE96q5Ro8eHEAH8ea?=
 =?us-ascii?Q?Z1llmFy1l0M5/bykkTFC5Xg62UI59xr3TBaPFXYTJsEKGbDYqhG6lvDe8Ved?=
 =?us-ascii?Q?Jwzxc8k9OGn/x7yaKZahYYHK9iiy5ASnNQlsbGNdUypAKmRDexVdtWYXrPzw?=
 =?us-ascii?Q?6cS62cnXqkk+Vd0UlMiX5oTgf8e1prJ8iLwHylLA6lT88/A4YOhIMWfh8y3N?=
 =?us-ascii?Q?76npwmoC4Ww45CFGmDtOYOCZIT14j8vhWua+q1wsGtO6k/CBUcoSO6LJ9LR+?=
 =?us-ascii?Q?BUclkm9iAZ9F5s+kkRn0AXQuNAIADtmZAXNzibw5QUt5DVnq85Y7+IVrnTrj?=
 =?us-ascii?Q?8A3iWLf6xq4pSVqX932eTaYHJG3LAoJI4GQoTXLMy/sd6nCu1+pp8jWmjXPu?=
 =?us-ascii?Q?hjdLXkklFY7TBrORRhCxrFWSYpKHkmwsGDRoKrnf89nUTNbsMXx8GVjBDXoP?=
 =?us-ascii?Q?HY8HCn8ZPoYlsrKA63hvVSRdfxzRH6sPpQ628ZWOPdeGL5YymQxZhp66Ttnn?=
 =?us-ascii?Q?dhK44j+N1eKrBAo8cV6CBXYFODvsomzTWNyjEsh7bQrwcn8HJsEOOw6xuvae?=
 =?us-ascii?Q?cBpyERvqq7w+6277Ne7Z56xiUz2FlTC3Qq71K0wvvf6L1sbc0PUyPR7QBznl?=
 =?us-ascii?Q?uOT7MOU6n5DxeIYNUuu0E0EMvjyF12E789Dc1aY2hLwmC+mXfNAujw46TQbo?=
 =?us-ascii?Q?sXOT3Iw3zu9nDP55cjzOnanJsxMFbJ2Sx4VpI0qiRwL7eT3LaeInlg5XhrEP?=
 =?us-ascii?Q?9T5vKQCHg309PXZXJUynhOs8OWTzbeKO68IGM4nZbpz2YLHQZhpQyO/y8gfa?=
 =?us-ascii?Q?pe1DG9uIkGlMsEGZnQUGnMRy7m+NQyOMUuN5p3cCse+ELE03zagbYbnPzSz8?=
 =?us-ascii?Q?9sqmjV9fhWs7DXYmFZdKtucjDq31wYDQkLTxQxau2fo4sM3Hqfc4Q1DbotP5?=
 =?us-ascii?Q?VIDB/4/eaqEpoRC4gzedAuxWAI2tNbNffjXKVK8yQeYoupxfHltsHeo9TX7Y?=
 =?us-ascii?Q?RU2W7EJ/e7z+nGmBWv8+lM0Zj2MGDFSVoRkW5jjkIvDdQ2lWtsX1fRIQurVf?=
 =?us-ascii?Q?aG73YcEqntxSCRglvc3ejr4He3pV/zTcNir4KMG9CMRySm/Od5vmEpEN8BRa?=
 =?us-ascii?Q?zaq1/7d0Cq5Zk3pewv/LO+4nn8nj/P8Ru3++DuYx6hyyo9WJURCWykoR0Qbj?=
 =?us-ascii?Q?U94FlhnzNBX7HGXgZ8u8dWM3pjAxaLtKfcuXUTudsxnYFa1CJjE68HXGZavz?=
 =?us-ascii?Q?0shMuFOI655v/wR6vDU=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2025 02:10:22.6812
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bf2f084a-c582-46a0-ce26-08de3c484522
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DC.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9422

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
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 253 +++++++++++++++++++-
 2 files changed, 269 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index f98774962012..f8dc96476c43 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -1101,6 +1101,21 @@ static inline bool arm_smmu_master_canwbs(struct arm_smmu_master *master)
 	       IOMMU_FWSPEC_PCI_RC_CANWBS;
 }
 
+/**
+ * struct arm_smmu_inv_state - Per-domain invalidation array state
+ * @invs_ptr: points to the domain->invs (unwinding nesting/etc.) or is NULL if
+ *            no change should be made
+ * @old_invs: the original invs array
+ * @new_invs: for new domain, this is the new invs array to update domain->invs;
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
@@ -1110,6 +1125,8 @@ struct arm_smmu_attach_state {
 	ioasid_t ssid;
 	/* Resulting state */
 	struct arm_smmu_vmaster *vmaster;
+	struct arm_smmu_inv_state old_domain_invst;
+	struct arm_smmu_inv_state new_domain_invst;
 	bool ats_enabled;
 };
 
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index cc85e7a10ea8..9a2281b5d9da 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -3068,6 +3068,116 @@ static void arm_smmu_disable_iopf(struct arm_smmu_master *master,
 		iopf_queue_remove_device(master->smmu->evtq.iopf, master->dev);
 }
 
+static struct arm_smmu_inv *
+arm_smmu_master_build_inv(struct arm_smmu_master *master,
+			  enum arm_smmu_inv_type type, u32 id, ioasid_t ssid,
+			  size_t pgsize)
+{
+	struct arm_smmu_invs *build_invs = master->build_invs;
+	struct arm_smmu_inv *cur, inv = {
+		.smmu = master->smmu,
+		.type = type,
+		.id = id,
+		.pgsize = pgsize,
+	};
+
+	if (WARN_ON(build_invs->num_invs >= build_invs->max_invs))
+		return NULL;
+	cur = &build_invs->inv[build_invs->num_invs];
+	build_invs->num_invs++;
+
+	*cur = inv;
+	switch (type) {
+	case INV_TYPE_S1_ASID:
+		if (master->smmu->features & ARM_SMMU_FEAT_E2H) {
+			cur->size_opcode = CMDQ_OP_TLBI_EL2_VA;
+			cur->nsize_opcode = CMDQ_OP_TLBI_EL2_ASID;
+		} else {
+			cur->size_opcode = CMDQ_OP_TLBI_NH_VA;
+			cur->nsize_opcode = CMDQ_OP_TLBI_NH_ASID;
+		}
+		break;
+	case INV_TYPE_S2_VMID:
+		cur->size_opcode = CMDQ_OP_TLBI_S2_IPA;
+		cur->nsize_opcode = CMDQ_OP_TLBI_S12_VMALL;
+		break;
+	case INV_TYPE_S2_VMID_S1_CLEAR:
+		cur->size_opcode = cur->nsize_opcode = CMDQ_OP_TLBI_NH_ALL;
+		break;
+	case INV_TYPE_ATS:
+	case INV_TYPE_ATS_FULL:
+		cur->size_opcode = cur->nsize_opcode = CMDQ_OP_ATC_INV;
+		break;
+	}
+
+	return cur;
+}
+
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
+	const bool nesting = smmu_domain->nest_parent;
+	size_t pgsize = 0, i;
+
+	iommu_group_mutex_assert(master->dev);
+
+	master->build_invs->num_invs = 0;
+
+	/* Range-based invalidation requires the leaf pgsize for calculation */
+	if (master->smmu->features & ARM_SMMU_FEAT_RANGE_INV)
+		pgsize = __ffs(smmu_domain->domain.pgsize_bitmap);
+
+	switch (smmu_domain->stage) {
+	case ARM_SMMU_DOMAIN_SVA:
+	case ARM_SMMU_DOMAIN_S1:
+		if (!arm_smmu_master_build_inv(master, INV_TYPE_S1_ASID,
+					       smmu_domain->cd.asid,
+					       IOMMU_NO_PASID, pgsize))
+			return NULL;
+		break;
+	case ARM_SMMU_DOMAIN_S2:
+		if (!arm_smmu_master_build_inv(master, INV_TYPE_S2_VMID,
+					       smmu_domain->s2_cfg.vmid,
+					       IOMMU_NO_PASID, pgsize))
+			return NULL;
+		break;
+	default:
+		WARN_ON(true);
+		return NULL;
+	}
+
+	/* All the nested S1 ASIDs have to be flushed when S2 parent changes */
+	if (nesting) {
+		if (!arm_smmu_master_build_inv(
+			    master, INV_TYPE_S2_VMID_S1_CLEAR,
+			    smmu_domain->s2_cfg.vmid, IOMMU_NO_PASID, 0))
+			return NULL;
+	}
+
+	for (i = 0; ats_enabled && i < master->num_streams; i++) {
+		/*
+		 * If an S2 used as a nesting parent is changed we have no
+		 * option but to completely flush the ATC.
+		 */
+		if (!arm_smmu_master_build_inv(
+			    master, nesting ? INV_TYPE_ATS_FULL : INV_TYPE_ATS,
+			    master->streams[i].id, ssid, 0))
+			return NULL;
+	}
+
+	/* Note this build_invs must have been sorted */
+
+	return master->build_invs;
+}
+
 static void arm_smmu_remove_master_domain(struct arm_smmu_master *master,
 					  struct iommu_domain *domain,
 					  ioasid_t ssid)
@@ -3097,6 +3207,131 @@ static void arm_smmu_remove_master_domain(struct arm_smmu_master *master,
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
+		/* A re-attach case might have a different ats_enabled state */
+		if (new_smmu_domain == old_smmu_domain)
+			invst->old_invs = state->new_domain_invst.new_invs;
+		else
+			invst->old_invs = rcu_dereference_protected(
+				old_smmu_domain->invs,
+				lockdep_is_held(&arm_smmu_asid_lock));
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
+	kfree_rcu(invst->old_invs, rcu);
+}
+
+/*
+ * When an array entry's users count reaches zero, it means the ASID/VMID is no
+ * longer being invalidated by map/unmap and must be cleaned. The rule is that
+ * all ASIDs/VMIDs not in an invalidation array are left cleared in the IOTLB.
+ */
+static void arm_smmu_inv_flush_iotlb_tag(struct arm_smmu_inv *inv)
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
+
+	lockdep_assert_held(&arm_smmu_asid_lock);
+
+	if (!invst->invs_ptr)
+		return;
+
+	arm_smmu_invs_unref(old_invs, invst->new_invs,
+			    arm_smmu_inv_flush_iotlb_tag);
+
+	new_invs = arm_smmu_invs_purge(old_invs);
+	if (!new_invs)
+		return;
+
+	rcu_assign_pointer(*invst->invs_ptr, new_invs);
+	kfree_rcu(old_invs, rcu);
+}
+
 /*
  * Start the sequence to attach a domain to a master. The sequence contains three
  * steps:
@@ -3154,12 +3389,16 @@ int arm_smmu_attach_prepare(struct arm_smmu_attach_state *state,
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
@@ -3207,6 +3446,8 @@ int arm_smmu_attach_prepare(struct arm_smmu_attach_state *state,
 			atomic_inc(&smmu_domain->nr_ats_masters);
 		list_add(&master_domain->devices_elm, &smmu_domain->devices);
 		spin_unlock_irqrestore(&smmu_domain->devices_lock, flags);
+
+		arm_smmu_install_new_domain_invs(state);
 	}
 
 	if (!state->ats_enabled && master->ats_enabled) {
@@ -3226,6 +3467,8 @@ int arm_smmu_attach_prepare(struct arm_smmu_attach_state *state,
 	kfree(master_domain);
 err_free_vmaster:
 	kfree(state->vmaster);
+err_unprepare_invs:
+	kfree(state->new_domain_invst.new_invs);
 	return ret;
 }
 
@@ -3257,6 +3500,7 @@ void arm_smmu_attach_commit(struct arm_smmu_attach_state *state)
 	}
 
 	arm_smmu_remove_master_domain(master, state->old_domain, state->ssid);
+	arm_smmu_install_old_domain_invs(state);
 	master->ats_enabled = state->ats_enabled;
 }
 
@@ -3438,12 +3682,19 @@ static int arm_smmu_blocking_set_dev_pasid(struct iommu_domain *new_domain,
 {
 	struct arm_smmu_domain *smmu_domain = to_smmu_domain(old_domain);
 	struct arm_smmu_master *master = dev_iommu_priv_get(dev);
+	struct arm_smmu_attach_state state = {
+		.master = master,
+		.old_domain = old_domain,
+		.ssid = pasid,
+	};
 
 	mutex_lock(&arm_smmu_asid_lock);
+	arm_smmu_attach_prepare_invs(&state, NULL);
 	arm_smmu_clear_cd(master, pasid);
 	if (master->ats_enabled)
 		arm_smmu_atc_inv_master(master, pasid);
 	arm_smmu_remove_master_domain(master, &smmu_domain->domain, pasid);
+	arm_smmu_install_old_domain_invs(&state);
 	mutex_unlock(&arm_smmu_asid_lock);
 
 	/*
-- 
2.43.0

