Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2067.outbound.protection.outlook.com [40.107.94.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E1162741BF
	for <iommu@lists.linux.dev>; Tue, 15 Apr 2025 04:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744693115; cv=fail; b=VRUK6xuLLjsxm6yn7B3D62To8A7vhT1ncXuLSe6aC5FMCMuVqd78O5occtRa3zJMuoY+xw9wk5m+Q9/OPQ2qPfso6q8xESlZuxCsWcPFwQawv6QA4Q8uZ6/0dvWSv8NGHhPFAv5ULbHxpLcxCtvojxJWXRffg4v8QH5zwqSO3CU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744693115; c=relaxed/simple;
	bh=rbKepy12vwKwTbbDhFbwsCYe9iwr3zyuYhFZw4vleHY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mAhgfqfsBednHEi9TF0UnmC1qyRizvxOTv8mepM9ehPfFl0JAKb4HackViyK9sg0QgcgdFXMMxwY9xHcxWpXoRpahb9mCSWmOshDaIPdz2faoz1HgbTIpyw1TMmssVyUeS2hORIJpwJm7QTQb8goCR/Q+yhOwaG+giU5Aijfl30=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jFZHiMIC; arc=fail smtp.client-ip=40.107.94.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jFZHiMIC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q7yGUo6l/81LVRntJ5mT9kXpXlfKolEOFDLUY6FVsVPHuTUyhpO8KRDqAqLJ4Fg1kTbhp4LYAK3rtL/aXQuXq5UKULIC6jAWvhaj/ogMm5zpmRoInSnfriJqa79c/Hk8xNWwoSS/LEgq5dc2WlNJE/LTVzydVf1t/fpeFLzlTNYvUhF7RiFo62egwOuXHyD36cdl0ogzPx6pJJlUMHg/AxunDc2zghGACT/zQiCDBqIAGYmkWAwVzrrcBZ97lm/K3f75YMr+i1Al6XEeBsxfrgXaxkjXB46Rg2sKJrrCnIDsBKx7P3Pp2TA4CMGRcdiaMnn4op5Fn7QT/gM5yXtZ6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5T7fnQQ3IaEj29h5JN4p5siPBXQrrDjYGCJlb1jsRHI=;
 b=c5xDq7EisHgdydv/HD6D2CtQK7HGKl7rRZZo+uCpu/0aUo3226Gn/EvMHgweyXA+AErTJhxAYx+bZQtXl6o5qE3p+lWr51NYkuNZZY7KFWlX5QUwurFQOhztoknCV9Tyt6BIH2gqvhUFNnvczztA6Ho7yIR83ric0J/FUO1NsUxQDETtGszxYOImcVeIq8z1d7fbsMC8XcnK6RQYaoJ9JZpRZqCkNxBpSCcmnHAh/3Oxb+ld/BQa3oQg1TGo87y5JL4mFaeJRTAKDfmw2vPHAYMHExA/pqteXwsd8/c2VnbZYstiDplSkhGurhJgLUWd9mykxCUlOCfIXeuJTxlR3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5T7fnQQ3IaEj29h5JN4p5siPBXQrrDjYGCJlb1jsRHI=;
 b=jFZHiMICKxvOfxOUQ5lBqVSJYPgW7FNQnAUg9U7xcH8iSz44VTVp0GHgYIn5hrQtkI6kTFFQTku3Rw896MYPKWzVNGmv3lFkn++YQ1/PeKZ5LTQVmOr8OpewAbUVbMQEaqqAqOgZRIw2uYhrAlGN641VY3HSL/lvggvToU2AkjPaoWFi3FqbpuM8QddEqIHG5xYNmCc3N5BsLhoMEjrJ0aFr6tSGh2QyRZqoOK+Wykc/b7DMvx1DMgoRevNsWEyDlCzvOApRjib79KtFQBcTOlPCRYgsBGhmFLY8gi9aymbPk//ssNy7Vqz/5pN+GnZqUk2lVP88LIGwJUMCwFp8rQ==
Received: from SJ0PR13CA0037.namprd13.prod.outlook.com (2603:10b6:a03:2c2::12)
 by CY5PR12MB6347.namprd12.prod.outlook.com (2603:10b6:930:20::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.33; Tue, 15 Apr
 2025 04:58:29 +0000
Received: from SJ1PEPF000023CC.namprd02.prod.outlook.com
 (2603:10b6:a03:2c2:cafe::e6) by SJ0PR13CA0037.outlook.office365.com
 (2603:10b6:a03:2c2::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.15 via Frontend Transport; Tue,
 15 Apr 2025 04:58:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF000023CC.mail.protection.outlook.com (10.167.244.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8655.12 via Frontend Transport; Tue, 15 Apr 2025 04:58:28 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 14 Apr
 2025 21:58:17 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 14 Apr
 2025 21:58:16 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Mon, 14 Apr 2025 21:58:15 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>, <robin.murphy@arm.com>, <jgg@nvidia.com>
CC: <joro@8bytes.org>, <kevin.tian@intel.com>, <praan@google.com>,
	<nathan@kernel.org>, <yi.l.liu@intel.com>, <peterz@infradead.org>,
	<mshavit@google.com>, <jsnitsel@redhat.com>, <smostafa@google.com>,
	<jeff.johnson@oss.qualcomm.com>, <zhangzekun11@huawei.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <shameerali.kolothum.thodi@huawei.com>
Subject: [PATCH v2 06/11] iommu/arm-smmu-v3: Introduce arm_smmu_s2_parent_tlb_ invalidation helpers
Date: Mon, 14 Apr 2025 21:57:41 -0700
Message-ID: <61fef9052b2034e5b4ffa1fa6ce481667d8ea6b1.1744692494.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1744692494.git.nicolinc@nvidia.com>
References: <cover.1744692494.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023CC:EE_|CY5PR12MB6347:EE_
X-MS-Office365-Filtering-Correlation-Id: 21cdad51-9e88-4497-497b-08dd7bda29d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vW+wAczugqUoLIeRsqD8CQQWalcS/r9Fv/WyWeNP37EvMbuvwq2pJ7BNYDmr?=
 =?us-ascii?Q?/Ji23v/J6CXDSsFbCfWSEzweRCIuVH+0Ji5wMuPGgPdUuVCIhqUSC9I3EoAJ?=
 =?us-ascii?Q?W0dmYSEMiySgafo8rBynyQlw7R9P4hh0VIHgKceV6RII8yBJhH5jl/rTIfre?=
 =?us-ascii?Q?pOddW+zpyMkjXFhZtsqu8q3wwX/pElBSNk+zlrf5UHX9+iYQYfCo8gNzZReb?=
 =?us-ascii?Q?5i8uiZS4ymlgMxodnlWcqremFyKid/PlMk9R9uW7AtDxX8KD5DVN55lzJ+Gg?=
 =?us-ascii?Q?5/HjmxyU5UUaucgNTI6TthiK/k/aZL4UHERY8HlHIKQeeqsvpMgrJhmj8j70?=
 =?us-ascii?Q?BMZaUKlLvyhEhMQfLdxKlw8ttEW7na8hGFPdGBSGF7OWRK0xLRk0MzokFJaZ?=
 =?us-ascii?Q?1BuUVOXkXnBEeqXV0nHInydfqYtCJRzHKIJlL3SxQ7Eg+f2NFjyiyWExSX/I?=
 =?us-ascii?Q?wpDAEj7cK9v37eWnmSwkOf/cb6y7jD3Qw/KCf9zeyohy3QW0e/WTYljhh77e?=
 =?us-ascii?Q?2ELeOweX1aMuqBDY4uxK8UWSzoQu+4OYUSYRRqb38sBF3+9Mj1VA5XRtcRwq?=
 =?us-ascii?Q?iKAj7SQ8CP5vy3q1EpW94Dp8j1bnHzkXEN+j2IYDknsXZGVaKVIxb/6pLsdg?=
 =?us-ascii?Q?8MtwIFO3TItGLpXUmWIBN9nibWggudvNFtUWzWmzGJobOCDQBB00ooq9z3su?=
 =?us-ascii?Q?XuUzZWUE4UeELCBzdIkumjGMqwk0BvvHIMRgEzWK/fxX9UHgEWBQGEFawAnl?=
 =?us-ascii?Q?AeR5yzbtuA5xz6UkNdJNf/dIae88j77O/DGfX1Fcc8svON6dyNHKfDVSf76U?=
 =?us-ascii?Q?2AWArXlhNl5krs8hsk23YHDeHMgasz0FhxtnbHs/nHr32alu2tYRlvjsy5aT?=
 =?us-ascii?Q?RTp5/jlvrlgisAm55aGXLqvhgixpGTQZtBHPaoD1AXFDSuia812yWD49GSgA?=
 =?us-ascii?Q?2lrOY4ZhnC8gcH+8mWhyx8PjcEmzWAyNd4yEXwztpDN8L0qpaptpYJOGm3Ry?=
 =?us-ascii?Q?JV7mPtd1JDyQ//e+IZW5qmBxT8WaK7azbjsuWHacoiwiZCV07tHzUVLDRMp8?=
 =?us-ascii?Q?0rLWy3BvCOu29TfJSgOkTghTftqometAsNHo/lydpuYHdzYqNc2BXSqyw8Uy?=
 =?us-ascii?Q?JiC7cx4HYbAUm3daGZmJGz7BO+FQkEMPt3c4efyS5VePRYSZZwtKXKHtu1in?=
 =?us-ascii?Q?1PG1G5DrKTDJNjTc45n+TANTvD4qQ9IMJCyX39DK4GvwXCCXuC8d8cHCwto/?=
 =?us-ascii?Q?mYpnm88NNUngFoZbIl1pB9RmyiuWaw8DFjQn4NaHxaVFBoDdMQR6t1SyVDsw?=
 =?us-ascii?Q?slzc3BUtIDaM6vpbdFCJ+E+KvM8UY5ygFCpULKz74y4uxpSALLlZKJwP/xWU?=
 =?us-ascii?Q?Hosn6prxrygMCMcza19bMa71Yjyu469hVRUpgze4/2koUiuARYA3ARCT8smr?=
 =?us-ascii?Q?m1xbA0KQmFhEW4GOgATYyXWuZM6UbZgy/ODuT3J937dIWYob/2hEI3q48TDu?=
 =?us-ascii?Q?uOPvFCg4xc++EwConquwEa2WhtDmw1bZ9DVM?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2025 04:58:28.9937
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 21cdad51-9e88-4497-497b-08dd7bda29d4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023CC.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6347

An S2 nest_parent domain can be shared across vSMMUs in the same VM, since
the S2 domain is basically the IPA mappings for the entire RAM of the VM.

Meanwhile, each vSMMU can have its own VMID, so the VMID allocation should
be done per vSMMU instance v.s. per S2 nest_parent domain.

However, an S2 domain can be also allocated when a physical SMMU instance
doesn't support S1. So, the structure has to retain the s2_cfg and vmid.

Add a per-domain "vsmmus" list pairing with a spinlock, maintaining a list
of vSMMUs in the S2 parent domain.

Provide two arm_smmu_s2_parent_tlb_ helpers that will be used for nesting
cases to invalidate S2 cache using vsmmu->vmid by iterating this "vsmmus"
list.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   | 22 ++++++++
 .../arm/arm-smmu-v3/arm-smmu-v3-iommufd.c     | 53 +++++++++++++++++++
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   |  2 +
 3 files changed, 77 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 7b47f4408a7a..7d76d8ac9acc 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -859,6 +859,10 @@ struct arm_smmu_domain {
 		struct arm_smmu_ctx_desc	cd;
 		struct arm_smmu_s2_cfg		s2_cfg;
 	};
+	struct {
+		struct list_head list;
+		spinlock_t lock;
+	} vsmmus;
 
 	struct iommu_domain		domain;
 
@@ -1081,6 +1085,7 @@ struct arm_vsmmu {
 	struct arm_smmu_device *smmu;
 	struct arm_smmu_domain *s2_parent;
 	u16 vmid;
+	struct list_head vsmmus_elm; /* arm_smmu_domain::vsmmus::list */
 };
 
 #if IS_ENABLED(CONFIG_ARM_SMMU_V3_IOMMUFD)
@@ -1094,6 +1099,11 @@ int arm_vsmmu_attach_prepare(struct arm_smmu_attach_state *state,
 void arm_smmu_attach_commit_vmaster(struct arm_smmu_attach_state *state);
 void arm_smmu_master_clear_vmaster(struct arm_smmu_master *master);
 int arm_vmaster_report_event(struct arm_smmu_vmaster *vmaster, u64 *evt);
+
+void arm_smmu_s2_parent_tlb_inv_domain(struct arm_smmu_domain *s2_parent);
+void arm_smmu_s2_parent_tlb_inv_range(struct arm_smmu_domain *s2_parent,
+				      unsigned long iova, size_t size,
+				      size_t granule, bool leaf);
 #else
 #define arm_smmu_hw_info NULL
 #define arm_vsmmu_alloc NULL
@@ -1119,6 +1129,18 @@ static inline int arm_vmaster_report_event(struct arm_smmu_vmaster *vmaster,
 {
 	return -EOPNOTSUPP;
 }
+
+static inline void
+arm_smmu_s2_parent_tlb_inv_domain(struct arm_smmu_domain *s2_parent)
+{
+}
+
+static inline void
+arm_smmu_s2_parent_tlb_inv_range(struct arm_smmu_domain *s2_parent,
+				 unsigned long iova, size_t size,
+				 size_t granule, bool leaf)
+{
+}
 #endif /* CONFIG_ARM_SMMU_V3_IOMMUFD */
 
 #endif /* _ARM_SMMU_V3_H */
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
index 6cd01536c966..45ba68a1b59a 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
@@ -30,6 +30,54 @@ void *arm_smmu_hw_info(struct device *dev, u32 *length, u32 *type)
 	return info;
 }
 
+void arm_smmu_s2_parent_tlb_inv_domain(struct arm_smmu_domain *s2_parent)
+{
+	struct arm_vsmmu *vsmmu, *next;
+	unsigned long flags;
+
+	spin_lock_irqsave(&s2_parent->vsmmus.lock, flags);
+	list_for_each_entry_safe(vsmmu, next, &s2_parent->vsmmus.list,
+				 vsmmus_elm) {
+		arm_smmu_tlb_inv_vmid(vsmmu->smmu, vsmmu->vmid);
+	}
+	spin_unlock_irqrestore(&s2_parent->vsmmus.lock, flags);
+}
+
+void arm_smmu_s2_parent_tlb_inv_range(struct arm_smmu_domain *s2_parent,
+				      unsigned long iova, size_t size,
+				      size_t granule, bool leaf)
+{
+	struct arm_smmu_cmdq_ent cmd = { .tlbi = { .leaf = leaf } };
+	struct arm_vsmmu *vsmmu, *next;
+	unsigned long flags;
+
+	spin_lock_irqsave(&s2_parent->vsmmus.lock, flags);
+	list_for_each_entry_safe(vsmmu, next, &s2_parent->vsmmus.list,
+				 vsmmus_elm) {
+		cmd.tlbi.vmid = vsmmu->vmid;
+
+		/* Must flush all the nested S1 ASIDs when S2 domain changes */
+		cmd.opcode = CMDQ_OP_TLBI_NH_ALL;
+		arm_smmu_cmdq_issue_cmd_with_sync(vsmmu->smmu, &cmd);
+		cmd.opcode = CMDQ_OP_TLBI_S2_IPA;
+		__arm_smmu_tlb_inv_range(vsmmu->smmu, &cmd, iova, size, granule,
+					 &s2_parent->domain);
+	}
+	spin_unlock_irqrestore(&s2_parent->vsmmus.lock, flags);
+}
+
+static void arm_vsmmu_destroy(struct iommufd_viommu *viommu)
+{
+	struct arm_vsmmu *vsmmu = container_of(viommu, struct arm_vsmmu, core);
+	unsigned long flags;
+
+	spin_lock_irqsave(&vsmmu->s2_parent->vsmmus.lock, flags);
+	list_del(&vsmmu->vsmmus_elm);
+	spin_unlock_irqrestore(&vsmmu->s2_parent->vsmmus.lock, flags);
+	/* Must flush S2 vmid after delinking vSMMU */
+	arm_smmu_tlb_inv_vmid(vsmmu->smmu, vsmmu->vmid);
+}
+
 static void arm_smmu_make_nested_cd_table_ste(
 	struct arm_smmu_ste *target, struct arm_smmu_master *master,
 	struct arm_smmu_nested_domain *nested_domain, bool ats_enabled)
@@ -380,6 +428,7 @@ static int arm_vsmmu_cache_invalidate(struct iommufd_viommu *viommu,
 }
 
 static const struct iommufd_viommu_ops arm_vsmmu_ops = {
+	.destroy = arm_vsmmu_destroy,
 	.alloc_domain_nested = arm_vsmmu_alloc_domain_nested,
 	.cache_invalidate = arm_vsmmu_cache_invalidate,
 };
@@ -394,6 +443,7 @@ struct iommufd_viommu *arm_vsmmu_alloc(struct device *dev,
 	struct arm_smmu_master *master = dev_iommu_priv_get(dev);
 	struct arm_smmu_domain *s2_parent = to_smmu_domain(parent);
 	struct arm_vsmmu *vsmmu;
+	unsigned long flags;
 
 	if (viommu_type != IOMMU_VIOMMU_TYPE_ARM_SMMUV3)
 		return ERR_PTR(-EOPNOTSUPP);
@@ -433,6 +483,9 @@ struct iommufd_viommu *arm_vsmmu_alloc(struct device *dev,
 	vsmmu->s2_parent = s2_parent;
 	/* FIXME Move VMID allocation from the S2 domain allocation to here */
 	vsmmu->vmid = s2_parent->s2_cfg.vmid;
+	spin_lock_irqsave(&s2_parent->vsmmus.lock, flags);
+	list_add_tail(&vsmmu->vsmmus_elm, &s2_parent->vsmmus.list);
+	spin_unlock_irqrestore(&s2_parent->vsmmus.lock, flags);
 
 	return &vsmmu->core;
 }
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 07d435562da2..df87880e2a29 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -3256,6 +3256,8 @@ arm_smmu_domain_alloc_paging_flags(struct device *dev, u32 flags,
 		}
 		smmu_domain->stage = ARM_SMMU_DOMAIN_S2;
 		smmu_domain->nest_parent = true;
+		INIT_LIST_HEAD(&smmu_domain->vsmmus.list);
+		spin_lock_init(&smmu_domain->vsmmus.lock);
 		break;
 	case IOMMU_HWPT_ALLOC_DIRTY_TRACKING:
 	case IOMMU_HWPT_ALLOC_DIRTY_TRACKING | IOMMU_HWPT_ALLOC_PASID:
-- 
2.43.0

