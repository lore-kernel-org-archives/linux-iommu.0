Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2059.outbound.protection.outlook.com [40.107.94.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECA182749E7
	for <iommu@lists.linux.dev>; Tue, 15 Apr 2025 04:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744693117; cv=fail; b=b7Y0xN1zdq55HUbOc8XSQNfuwfv1/aaEOvmHfnsb5GC3/itnIuY5uqBweO8uoYBLHbnWtORKql2DbQRypR5PpRAXgf3DD0Y10Y6CWGRiraKrrDzhyDyt/tnlSu/OmeEQuKq+YBvqtn1VD5C+dz2IrsV+nofwcXirNM72XuFffII=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744693117; c=relaxed/simple;
	bh=EQV3lRogNxjret0GQdiIi7LQuYvZfc5RyJLnV/6lsGw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S7W9pB9BxULadx8wiF9LXPyXdnAKv2F/E76lfQRrVF0lRmkxX4hVW5vQa69DO6/XXeBvuMJ+F/rhXnyyDDaf8BUjSuTmQO8DuhhIiec4iGO42cc1RI028n5vIwxWfrXfadF8WSAeFB9BteFTYDQjZOmor42crzZsOBUNTHtRr7Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nrWnO95P; arc=fail smtp.client-ip=40.107.94.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nrWnO95P"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Eh9w8GjfRBaK1JkUu2KPskuGhQwm8hY7whqMRabXbU5Qolz7PIpIvszY+ZvJrDpwvBoiXI16ic2CamQbBrFrRjbJacTeUilvOIxBk4kIPXk7aQwdpKnuyNUer5zVq6Ot79HKi3O+JhjQt1PtEc+u3HPHRrH/l7BLzh66uxHPY544PBfMxIALcXKKw65hK7LGXbmshPXWqDtm3a2tbDPwzoU9ZZF3ilGV9lJfyBAO7KYib53nWQZ6Vgub4LaDeJb8+SEPeObexPHKmf2OWEp/pRZGzRHNZE/fPI1AOkHbE4yWsEoyqX0S4zynnLBYvMkf90I1/cAMrVlLIjOrQouPRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NxUFIToygWZJnL1QHFsxEXRplUq1RiOvOCD1KbjKJdQ=;
 b=L+12m6pGUJ4gPzG+cpCTI0677p33+LJDhGYqcJq5pOk9WaSsw6R3xxOG9pn5T+ObKlQUinxilKWfkrI8DK5zpF8ZUeYZWO/rvdKfvzHq/6IV+6IYX87vFu1ob/MmbJd85D3zhZe0CKxy9/SVfkPaGsJka1/E8DTp6xleEeime0Tc88bCpqH6+rFm7cYK/z+2UkZNfGtK8I9eGiCpQ4KzRkvv17qMzFWlkkByrU5kJuVmNBvxCI4Nu6XNOJ/U0SaEFVMLy6zd7MeEahuXiIC3P78DdZllTglusSi0ARjC23bhDGZ+FAF3u1Yc1mDWoczv9t6+/UxYfs2XqK9LFL+22Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NxUFIToygWZJnL1QHFsxEXRplUq1RiOvOCD1KbjKJdQ=;
 b=nrWnO95PKaXOi0TQcPkHWT068XOfK2myyRHND7C/vck01X0kDLOYNn1m/uTRv38Xd4T0hK3pqChlNo6mZ/0TRiSnNVQL9Hu6DkI7tK09A+YVUCyCHr3oLBEE6oIRchSnwSfZ4td/Ks5VNnABKpB4HD331Ej6asvKrnuJwS0bVrmh+IelHlkLg7wMOIDEKJmvPO5F5xXl28YIHssc+fbcGbDnMXqn4IfYvAlW6ke6jkD3f+un/fwnePfFiJo/hzDJ5nc/CJ8/yTqGXhkpATqDre9d/DgXG+HUrqUQICXO6npX2Pjl3pCFOiyJ8UU0t+lBtTT3Sb8GegBpd6ccPbvGXw==
Received: from MW4PR03CA0213.namprd03.prod.outlook.com (2603:10b6:303:b9::8)
 by CY5PR12MB6130.namprd12.prod.outlook.com (2603:10b6:930:26::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.28; Tue, 15 Apr
 2025 04:58:32 +0000
Received: from SJ1PEPF000023CF.namprd02.prod.outlook.com
 (2603:10b6:303:b9:cafe::d3) by MW4PR03CA0213.outlook.office365.com
 (2603:10b6:303:b9::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.26 via Frontend Transport; Tue,
 15 Apr 2025 04:58:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF000023CF.mail.protection.outlook.com (10.167.244.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8655.12 via Frontend Transport; Tue, 15 Apr 2025 04:58:31 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 14 Apr
 2025 21:58:18 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 14 Apr
 2025 21:58:18 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Mon, 14 Apr 2025 21:58:17 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>, <robin.murphy@arm.com>, <jgg@nvidia.com>
CC: <joro@8bytes.org>, <kevin.tian@intel.com>, <praan@google.com>,
	<nathan@kernel.org>, <yi.l.liu@intel.com>, <peterz@infradead.org>,
	<mshavit@google.com>, <jsnitsel@redhat.com>, <smostafa@google.com>,
	<jeff.johnson@oss.qualcomm.com>, <zhangzekun11@huawei.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <shameerali.kolothum.thodi@huawei.com>
Subject: [PATCH v2 07/11] iommu/arm-smmu-v3: Introduce arm_vsmmu_atc_inv_domain()
Date: Mon, 14 Apr 2025 21:57:42 -0700
Message-ID: <a7b7004b4129f8d86083025357646ed52527cf3f.1744692494.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023CF:EE_|CY5PR12MB6130:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b20ad59-e03e-49f2-cb67-08dd7bda2b60
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|376014|82310400026|36860700013|3613699012;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?P2yg1P24mtIHyPXNZt+rWIDXn8m//5V7bW8EHmVNw84vnV4oMpONDonBYe4n?=
 =?us-ascii?Q?aX7KqWfKCWheYAqfH7DSayj2qPnDYW2e3xsY9dyouAPDfYN1x4ND4yk3fSwo?=
 =?us-ascii?Q?Cu/SsxKGECAL4xzttUzRe7eMuVJT4uS71do/UiwcbiSpsWBcqFsjQJISV7C4?=
 =?us-ascii?Q?/QjV0cbSAFT+o3pNAJ9KJmN4rriCMFlTA2TJT3R9PJLOsbTRCetaSxWNccIR?=
 =?us-ascii?Q?Dg0/kmncX1lzrr0pbEqpYRMeylO3RCtCtBet65N6aOE9lppUVg8r6pelYZ3Q?=
 =?us-ascii?Q?LlgS9YduyI+SW+SK+KZprdK2ywCPOvZbgKaKPSean59RFCGKcCwaxDqHFzs5?=
 =?us-ascii?Q?sySstKA9VJhUyryBM81FSuhObs1oLosQBCmWDCHibQFoSRUPrZImi+shMykY?=
 =?us-ascii?Q?b2JErDmahmSVQCvH5QU21EpJTcCIQTijoeRZSpMnvyDlNLMkW3uisxjKyTDd?=
 =?us-ascii?Q?U9mF05Bu7lc4eWZzEImmTfl/QCYuvcyqKfzR87rOU3TPTH60EMoiWXnsYZE3?=
 =?us-ascii?Q?+Di7BXDMJHcKzfaFDZBa+lEPlUKEm/dMo49pihEl5CdlV5ShYqVx6d4UjQ9e?=
 =?us-ascii?Q?X+d+5RkQ2zTVg48NKtJbnMzglP2j9EC9+JUvzXaBZMZErJSspy/wXVxTP/wk?=
 =?us-ascii?Q?5Z++OvRmkp44waGrp3ZiGQyQxHvFSE552dYN3L/tnZruRn7CTow1pCHz2s6M?=
 =?us-ascii?Q?+0d5Ti8kNiIqEowop4cBQLVKDbmorU10YUcgk3ySg+SZb0fGILl6/iy4DSAr?=
 =?us-ascii?Q?BK092mlrmgAPPWvaM7NajbRkJYegDLmPdD1U6TPMdqe5U7vyOw0ZR7dG7zLj?=
 =?us-ascii?Q?psd2vmy5o6/Jrl2qVwzQL2OC9ozBOqBkbgDw620uxZddK/EG8YBUO6wpqwZq?=
 =?us-ascii?Q?fOPlrnUaQZkWAxnPjp1tTqK7XoOG/WZXg+xMml271ytasIwnGEuL681bWyto?=
 =?us-ascii?Q?XoOBNCozIcyCIGsqgZqKoZOc9NfzM/bG35rsiFupPUxSpmdxLU6CMfg9zuae?=
 =?us-ascii?Q?rQtMGSZrY86GpRh9n7Tb/rTu8BUBpxsbgKGMUCYCMGb8OenTZQVYlvz1Wb5s?=
 =?us-ascii?Q?5TnLpbdrhmvyUlpPRYrxJd9Oal7R+bPk5bygIt3GKqznFIDvqwVlyi2qLKQd?=
 =?us-ascii?Q?9YHLCYAsI04BdfgUBle2eH5+yDqCa/M0g5pVNN6Nv+DwbPa4/bAwyjZWMeCJ?=
 =?us-ascii?Q?6U9vgeI07PlKfELGiJ0/g/VuyEOPdA3xoefCclQiSlwtWL6o+PsJpSlCyuIy?=
 =?us-ascii?Q?3ZeTV2yhSdsAoYMgNVbKwbVMmKNWNtx9wDlHKw7ZINaE9viZR1SAbQ9dKb89?=
 =?us-ascii?Q?7J9S5hS/o7NiGzOlTUYRgpRMz11ex2y8vKG727XhPD2lwTLcu+qEMZu1tV5q?=
 =?us-ascii?Q?K5QCh7Q8ftdVGgGE+9SGHdAW9Zea1r3T2tYsqr3rUdYEDYe/kHNxhs0deaKR?=
 =?us-ascii?Q?9sI3H/4vSWR+v8MBJS99uS17zEF+bJxijmopCriKMSQNHhTIRYqN4HJ02Z+R?=
 =?us-ascii?Q?7WqQTBzIxrIC5CZXu4RvG/thpR83XTLkxLt4DFKCK7GvfJxnLh8C2VZBk2DE?=
 =?us-ascii?Q?4N48vxJIDXA6NLTqJCU=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(82310400026)(36860700013)(3613699012);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2025 04:58:31.6079
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b20ad59-e03e-49f2-cb67-08dd7bda2b60
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023CF.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6130

Currently, all nested domains that enable ATS (i.e. nested_ats_flush) are
added to the devices list in the S2 parent domain via a master_domain. On
the other hand, an S2 parent domain can be shared across vSMMU instances.
So, storing all devices behind different vSMMU isntances into a shared S2
parent domain apparently isn't ideal.

Add a new per-vSMMU ats_devices list (with a pairing lock), which will be
stored the devices if their ATS features are enabled.

Using this ats_devices list, add an arm_vsmmu_atc_inv_domain() helper, for
the s2_parent invalidation routines to proceed ATC invalidation properly,
which sends an ATC invalidation request to all the devices on the list.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  6 +++
 .../arm/arm-smmu-v3/arm-smmu-v3-iommufd.c     | 45 +++++++++++++++++++
 2 files changed, 51 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 7d76d8ac9acc..d130d723cc33 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -840,6 +840,7 @@ struct arm_smmu_master {
 	bool				sva_enabled;
 	bool				iopf_enabled;
 	unsigned int			ssid_bits;
+	struct list_head		devices_elm; /* vsmmu->ats_devices */
 };
 
 /* SMMU private data for an IOMMU domain */
@@ -1086,6 +1087,11 @@ struct arm_vsmmu {
 	struct arm_smmu_domain *s2_parent;
 	u16 vmid;
 	struct list_head vsmmus_elm; /* arm_smmu_domain::vsmmus::list */
+	/* List of struct arm_smmu_master that enables ATS */
+	struct {
+		struct list_head list;
+		spinlock_t lock;
+	} ats_devices;
 };
 
 #if IS_ENABLED(CONFIG_ARM_SMMU_V3_IOMMUFD)
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
index 45ba68a1b59a..4730ff56cf04 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
@@ -30,6 +30,41 @@ void *arm_smmu_hw_info(struct device *dev, u32 *length, u32 *type)
 	return info;
 }
 
+static void arm_vsmmu_cmdq_batch_add_atc_inv(struct arm_vsmmu *vsmmu,
+					     struct arm_smmu_master *master,
+					     struct arm_smmu_cmdq_batch *cmds,
+					     struct arm_smmu_cmdq_ent *cmd)
+{
+	int i;
+
+	lockdep_assert_held(&vsmmu->ats_devices.lock);
+
+	arm_smmu_atc_inv_to_cmd(IOMMU_NO_PASID, 0, 0, cmd);
+	for (i = 0; i < master->num_streams; i++) {
+		cmd->atc.sid = master->streams[i].id;
+		arm_smmu_cmdq_batch_add(vsmmu->smmu, cmds, cmd);
+	}
+}
+
+static int arm_vsmmu_atc_inv_domain(struct arm_vsmmu *vsmmu, unsigned long iova,
+				    size_t size)
+{
+	struct arm_smmu_cmdq_ent cmd = { .opcode = CMDQ_OP_ATC_INV };
+	struct arm_smmu_master *master, *next;
+	struct arm_smmu_cmdq_batch cmds;
+	unsigned long flags;
+
+	arm_smmu_cmdq_batch_init(vsmmu->smmu, &cmds, &cmd);
+
+	spin_lock_irqsave(&vsmmu->ats_devices.lock, flags);
+	list_for_each_entry_safe(master, next, &vsmmu->ats_devices.list,
+				 devices_elm)
+		arm_vsmmu_cmdq_batch_add_atc_inv(vsmmu, master, &cmds, &cmd);
+	spin_unlock_irqrestore(&vsmmu->ats_devices.lock, flags);
+
+	return arm_smmu_cmdq_batch_submit(vsmmu->smmu, &cmds);
+}
+
 void arm_smmu_s2_parent_tlb_inv_domain(struct arm_smmu_domain *s2_parent)
 {
 	struct arm_vsmmu *vsmmu, *next;
@@ -39,6 +74,7 @@ void arm_smmu_s2_parent_tlb_inv_domain(struct arm_smmu_domain *s2_parent)
 	list_for_each_entry_safe(vsmmu, next, &s2_parent->vsmmus.list,
 				 vsmmus_elm) {
 		arm_smmu_tlb_inv_vmid(vsmmu->smmu, vsmmu->vmid);
+		arm_vsmmu_atc_inv_domain(vsmmu, 0, 0);
 	}
 	spin_unlock_irqrestore(&s2_parent->vsmmus.lock, flags);
 }
@@ -62,6 +98,11 @@ void arm_smmu_s2_parent_tlb_inv_range(struct arm_smmu_domain *s2_parent,
 		cmd.opcode = CMDQ_OP_TLBI_S2_IPA;
 		__arm_smmu_tlb_inv_range(vsmmu->smmu, &cmd, iova, size, granule,
 					 &s2_parent->domain);
+		/*
+		 * Unfortunately, this can't be leaf-only since we may have
+		 * zapped an entire table.
+		 */
+		arm_vsmmu_atc_inv_domain(vsmmu, iova, size);
 	}
 	spin_unlock_irqrestore(&s2_parent->vsmmus.lock, flags);
 }
@@ -76,6 +117,7 @@ static void arm_vsmmu_destroy(struct iommufd_viommu *viommu)
 	spin_unlock_irqrestore(&vsmmu->s2_parent->vsmmus.lock, flags);
 	/* Must flush S2 vmid after delinking vSMMU */
 	arm_smmu_tlb_inv_vmid(vsmmu->smmu, vsmmu->vmid);
+	arm_vsmmu_atc_inv_domain(vsmmu, 0, 0);
 }
 
 static void arm_smmu_make_nested_cd_table_ste(
@@ -487,6 +529,9 @@ struct iommufd_viommu *arm_vsmmu_alloc(struct device *dev,
 	list_add_tail(&vsmmu->vsmmus_elm, &s2_parent->vsmmus.list);
 	spin_unlock_irqrestore(&s2_parent->vsmmus.lock, flags);
 
+	INIT_LIST_HEAD(&vsmmu->ats_devices.list);
+	spin_lock_init(&vsmmu->ats_devices.lock);
+
 	return &vsmmu->core;
 }
 
-- 
2.43.0

