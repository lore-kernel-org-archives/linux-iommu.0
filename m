Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013023.outbound.protection.outlook.com [40.93.201.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EC73394493
	for <iommu@lists.linux.dev>; Tue, 17 Mar 2026 08:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773734403; cv=fail; b=WgcHfySHLOlSVHkX0dQ90H8jRWmGvTVcWeUfFlSexJzrSt/Ji6Ir6vqTPiidxspw2k36LgWkESSjO+RRiMsjbc1KcHOvrMM9UEOchtaUljsqjiVJB0XoleP7Tu4qIq080HR2j5fpRc6UmyspBk4CpcHB7XwCrGIuYSEAMaXK/kM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773734403; c=relaxed/simple;
	bh=CQdShTbjX2o5S/VpOMFUdJ+pn9wwXGK1tyGvB570vrI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DtSVlxv0BkEeo67m4m1vkgVTLZBwDfaLzpz0AGQ708ZDImVzwSHYcPR/ZLA+KoDbgWXITXwX5yZB7uUxme00HiHneMcfx8guoDNY0O8OqImTM5T3gpFSzbsHp6krk1nrAuWqkpUJ1CZCV43R7NJlQvexZgXJVVYheREG9/UvwwU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HeMuCJX3; arc=fail smtp.client-ip=40.93.201.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HeMuCJX3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PXgMGFv0HsMoAavtU8YhWmP4Lwzp2ZDP1a35Numqs+mFXQMaevrLeiZe78qpk9xjDlpZLDaHHALcK2KiZHSDYv4IPT7F/8d6bF86ydMGrzw3afcgYRrsNiWXD+g/fh0zYI6Nx36MlYNMuWEPb8AN5iPIez2FcnNKR9rJ/+9sc1YeZbiJ3dKcxwy0530D1sr+7n756MgUFOiEOJ9GdvjHuE2DtBvmufBRPiu/xcqkOcWefgKtH0DTPFG26ESke2VR8D2RuIwrFTHIvFpwSovBhJVsO8HXCD472ApiHKmwly0ZYVlVdlullxSkklriUr4aTAPocoFQdR7C1LQJO7SqZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rGuCszV/N2uJ9qeKnWvFWmssjB5VtEasESgymZkxkNw=;
 b=lJZo7qSalO2qfQOjKV46mtXyLDzTZnKFbXRdKYmxYnQmYNgZgMRwqBJ9dCMLpYZ6fQI2kBhsOLpkaBvAp3XXdmP64jZLFhXoIoE5UdTxCTmkDnbtpIlSVLLQZYv5I2qC7/o8QRR6s6dCHCebgsTEUnMjopHJCdf2hywig+HJ4pXtcHyXyE77jDF7Tt06FPzvzzQRQUH8sr3RHXV0fzyvaefxVI+uMF37OMpfuqyWMbpjbFV4LwPnwbQWhAACwAkyPzga031+CNZsAg2pB3W1X9Cf7u3kzvhqK2PbvDqb5IDHZIQq1BwQWP63DYqLineSMJK/OjTpG+iB3TpFIVZ+Zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rGuCszV/N2uJ9qeKnWvFWmssjB5VtEasESgymZkxkNw=;
 b=HeMuCJX3TVK8klhijD4z4/BKZ21iJMty7gLz6SLOcnV6NDpioLWYGdPG1Nd7h5IvXeq1GzpeO+j3Vwg4kMP9Smsl1wErJn2RfhfVXI4rhp3WGI55SIJ9gEfrzVsiS6F+ILHXqLoiLqyvy/VZEf9jL/T/HnytDAmAlkfBN4UhZ44W7kJBMIJz/BSvhR6GSB1khuhm4KfI2IS7c+0/F7xhXa+OeYj9zJxGPe35QikZJ19s8EvgKP/q/r+mZ3XiJt/sJ4M3rquVwAzCTnDbdiwTc7pVpUIB7hLn7QX+OLK2Ss+4q6UpADnuMrZ6MZ2/VI/Vvb79xVch8D2BJMFQOjw9AQ==
Received: from SJ0PR03CA0209.namprd03.prod.outlook.com (2603:10b6:a03:2ef::34)
 by DM4PR12MB8498.namprd12.prod.outlook.com (2603:10b6:8:183::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Tue, 17 Mar
 2026 07:59:52 +0000
Received: from SJ1PEPF00001CE9.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef:cafe::b6) by SJ0PR03CA0209.outlook.office365.com
 (2603:10b6:a03:2ef::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.24 via Frontend Transport; Tue,
 17 Mar 2026 07:59:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF00001CE9.mail.protection.outlook.com (10.167.242.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Tue, 17 Mar 2026 07:59:52 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 17 Mar
 2026 00:59:39 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 17 Mar
 2026 00:59:39 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Tue, 17 Mar 2026 00:59:38 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>
CC: <jpb@kernel.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<jgg@nvidia.com>, <balbirs@nvidia.com>, <catalin.marinas@arm.com>,
	<praan@google.com>, <miko.lenczewski@arm.com>, <smostafa@google.com>,
	<xueshuai@linux.alibaba.com>, <baolu.lu@linux.intel.com>,
	<kevin.tian@intel.com>, <mshavit@google.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <peterz@infradead.org>
Subject: [PATCH v13 6/8] iommu/arm-smmu-v3: Populate smmu_domain->invs when attaching masters
Date: Tue, 17 Mar 2026 00:59:21 -0700
Message-ID: <eee884e734230ccdf8592a2dcd6962060e83b750.1773733797.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1773733797.git.nicolinc@nvidia.com>
References: <cover.1773733797.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE9:EE_|DM4PR12MB8498:EE_
X-MS-Office365-Filtering-Correlation-Id: c3df76e7-0327-4d4e-df44-08de83fb2b9d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|82310400026|36860700016|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	iIzdS4uUzjRDQk0VakZT1pRwKPAHHaW8UQ+mwLZp8dqrdly9f112rltF12xBRLftbpDOuwR1Rqv664BXAw9NpXcyJ6UGyiKSHNgSFBnSU/LsQ+G+KQFLh1HK5iAW0A7pyNgPXk52KFrDLPIM9TsM1Wu7AnHXFDhO6E9cjgCrCyHbk9dBVyp/HEPH2f0FD41ly0dg1lh04B6TGGjPurHmRXS9usLoV+/S+IqxzZlDmLLXxz79gGO73pPdKv1hr5wJVTJVQnGmzqwLz/e1iLlI9+uvFDHROl91qh0X8TdxoPH6JdWrHHGIJfQPt+/OUydz0HUe6MHeN4pxkAQB3/lha3bviVh1mJlOMd0lR0UYDeRlpVsGgnOHn1PhKHk7D0B7HbwoXC+XAYnCkDqfoW5Un+QQaUn+/tIwUJnz7G0Vt7ebyou4Y2JUvufPP8tvFF3Mh+CEnRbn/ntlelx70Uw2y29OBktVtJeiY3ZzvGKIFdPub0R6oCDt6ssWnllLcA207HVG5JrUGR1jN8gdMyZuJaWgTzamViUroSEEXTfpqhnvMFxim0oDrVkmsPm1tng2tCF5nuO1ch/i3mLQuMA/FRTao7Un2SCC7AelobSzJu/IIPvEKMKQZOSBDlPCoJFUk7GiffEXtceed69lAFG5UajWuXq2C4BfkcfDYR81+nN8o8M3QGgbeeIdXeCcvm9nJyP9ZDNQLeAQaGDDC1cdKf0O465v2BGVK6jFi6UPC+OFLxBqwItTffBZ45j4Yo+xoYGIZr8umrMZPgbayH9YWw==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(82310400026)(36860700016)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	TZ6WzkpXmXWH+G01EKRz8FgUEkFh+/NOOY2k/+Ojoe4MzYKhIYEuCNbd6cs0KXOrFPTiwq6n6h3aM0fVcqYFxzCFIiL7aFXHi8SIg6z9EwQsHOwhU4W/ZvPlJTAFpbG9ueavrlXUG6sUqBCmi2Op8wd2HA5yjcw+zevmMqaMBDRi8Q9lXnXWGE8Pl5CniEclu+XMz4GXe8KGsXK+yHsppHBrzHnPI3mnL7G54Ric1BGnlXwGUhKpslroeaJUfbi2rEuPFUti7rhlZvhrPcb3TSGUeUZLeQUo23DT6bTNVAzF5p8yGdkbNn0AGVYAV/lyzb5ntG7DFb+03o0FeqUURkJ3HcG//HJ/WDK9d5je5qyZ8JjVs/nQ0fobHvbn/SiygJ1V7wIkUwN5zxnrPR5fKh9lOkPuNfZ4tSHntdcf/BSiTHxdy5QyNLQ2d/twJuAP
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 07:59:52.4606
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c3df76e7-0327-4d4e-df44-08de83fb2b9d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8498

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
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 262 +++++++++++++++++++-
 2 files changed, 278 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 5e0e5055af1eb..83d7e4952dffb 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -1102,6 +1102,21 @@ static inline bool arm_smmu_master_canwbs(struct arm_smmu_master *master)
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
@@ -1111,6 +1126,8 @@ struct arm_smmu_attach_state {
 	ioasid_t ssid;
 	/* Resulting state */
 	struct arm_smmu_vmaster *vmaster;
+	struct arm_smmu_inv_state old_domain_invst;
+	struct arm_smmu_inv_state new_domain_invst;
 	bool ats_enabled;
 };
 
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 8e651cf6b86ee..1d0f968138646 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -3147,6 +3147,121 @@ static void arm_smmu_disable_iopf(struct arm_smmu_master *master,
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
+		/*
+		 * For S1 page tables the driver always uses VMID=0, and the
+		 * invalidation logic for this type will set it as well.
+		 */
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
+		cur->ssid = ssid;
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
@@ -3176,6 +3291,135 @@ static void arm_smmu_remove_master_domain(struct arm_smmu_master *master,
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
+					struct iommu_domain *new_domain)
+{
+	struct arm_smmu_domain *old_smmu_domain =
+		to_smmu_domain_devices(state->old_domain);
+	struct arm_smmu_domain *new_smmu_domain =
+		to_smmu_domain_devices(new_domain);
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
+	arm_smmu_invs_unref(old_invs, invst->new_invs);
+	/*
+	 * When an IOTLB tag (the first entry in invs->new_invs) is no longer used,
+	 * it means the ASID or VMID will no longer be invalidated by map/unmap and
+	 * must be cleaned right now. The rule is that any ASID/VMID not in an invs
+	 * array must be left cleared in the IOTLB.
+	 */
+	if (!READ_ONCE(invst->new_invs->inv[0].users))
+		arm_smmu_inv_flush_iotlb_tag(&invst->new_invs->inv[0]);
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
@@ -3233,12 +3477,16 @@ int arm_smmu_attach_prepare(struct arm_smmu_attach_state *state,
 				     arm_smmu_ats_supported(master);
 	}
 
+	ret = arm_smmu_attach_prepare_invs(state, new_domain);
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
 
 		master_domain = kzalloc_obj(*master_domain);
@@ -3286,6 +3534,8 @@ int arm_smmu_attach_prepare(struct arm_smmu_attach_state *state,
 			atomic_inc(&smmu_domain->nr_ats_masters);
 		list_add(&master_domain->devices_elm, &smmu_domain->devices);
 		spin_unlock_irqrestore(&smmu_domain->devices_lock, flags);
+
+		arm_smmu_install_new_domain_invs(state);
 	}
 
 	if (!state->ats_enabled && master->ats_enabled) {
@@ -3305,6 +3555,8 @@ int arm_smmu_attach_prepare(struct arm_smmu_attach_state *state,
 	kfree(master_domain);
 err_free_vmaster:
 	kfree(state->vmaster);
+err_unprepare_invs:
+	kfree(state->new_domain_invst.new_invs);
 	return ret;
 }
 
@@ -3336,6 +3588,7 @@ void arm_smmu_attach_commit(struct arm_smmu_attach_state *state)
 	}
 
 	arm_smmu_remove_master_domain(master, state->old_domain, state->ssid);
+	arm_smmu_install_old_domain_invs(state);
 	master->ats_enabled = state->ats_enabled;
 }
 
@@ -3518,12 +3771,19 @@ static int arm_smmu_blocking_set_dev_pasid(struct iommu_domain *new_domain,
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

