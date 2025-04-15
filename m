Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2051.outbound.protection.outlook.com [40.107.244.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C00C826770A
	for <iommu@lists.linux.dev>; Tue, 15 Apr 2025 04:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744693108; cv=fail; b=kl4NBhKdvfUVy3KiKE0UP6AT0RFmcrBo3k7EwTH7uWykAMHwMTbSjPrKd6d2u+JdywnXlcbZUFOJ0VGRoaN3znbfnkDlr7wNrgvlmgiFdavlMrIziXGDbaNThVQOptzIYoxek+jO3ejURT/Ea7JO6u3i5TUdgNRN/CF84UZn++I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744693108; c=relaxed/simple;
	bh=7ZbtB/M6Rr79XdP7P3+mGCQnP9Ly3YuGP2N5e/Rue14=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e05Gb+htzTVV5HQBTjzKQATVPWYn/G37+YXmfY3ziN4pAND3OI3R97uux0TGNY63xiMH7iF76HnGsmujb/Mvve20jBSgs6uvQJ7Zw84lxU6c/eFQoqJziJLk23MvoegIpGQG7zAeIAxqL7K6P+XIFdwVNhr0RKIX9IN9Qd+N8s8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gdeMOP7d; arc=fail smtp.client-ip=40.107.244.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gdeMOP7d"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S6SQEYiPeJDhxvcOC3SbmfZRI385oqf5IAKUTeXTjTzQeLGpAortlOziZmEuL1rC7xZVTiOzi0R/MsNPLCTIXiqHj0IYBGvRHpsqk7sFWcvLENOuzvZGvVsq7yrcvGJdAUYOznD1MXE8AG4Og+VGgPznVzuPYjIYI4Dz8hnTUTaIqOQYdpoRcK9kV7boXcMAoP383Qxl60myxqtlqo8HbYoZ8eglEDuyYXHKRB6ZV5x4+VbzqNuwxW9txzczS9bGQc6TpOlF4UHYv/Vg/ORh70B13Tjt7TLs95epbKoHBuxtyggFNpB/1HhuaF1yQQFi6+DAqy2XRj//QUMPqy5+wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AakWwIer6SrxVv7TACYnCn9+EApq7K2deGUXZTvNxIk=;
 b=mLgEkpZseF3t39N8u96C3JdpTT/Ka7CL49CdccCoba5IF/uBpD4cdmQpFCQ1laqeNQ+ZlKWGPZuww1NX0PWth1uwDi5fmScAUYfG4iu25H3yEJhIJv/NyCcmqI+/ChW742c2u8EsipDX4XhUBqDUyYddxmqMHxZ4EYTvUNfJFlx8c/yavijOjjCTRYmToNaYCJe7UEQskffb5YaIze4HP4CAw6Qvu5zknPTKefa2O5y7meexkU7StOYGIyxitcc7M6CxWuaxQ1TdJ17pieFccDJ+i+dr6+MS6SZmMEpsZyGlAgtGyi5PkeSYziOPy5333/mDbCl20+YWFhetTBPtQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AakWwIer6SrxVv7TACYnCn9+EApq7K2deGUXZTvNxIk=;
 b=gdeMOP7dRzJEUKXiPDiTxxtiQLkEs6ZNBldWbN2A/NcANQRsKGlbSYD4QjC2J9rVs94T/wBcSzbOu9UoO4hO6AMgCmmlh+Pa6sPnTrYTIEYDVpEXlWGZpDTmm/5e2BbIA8i7ViOXRX+GbuB7Hqvx3XIHyWu8mxD+sS952f/y/6XvZmqNT8+D27f0rqPzEN6AruQ2DNciiqXLVBcq4GIu2nFc6p9Z2gBviLj8xfq4r9uWEI1JXd/mw7SoYJ5fAc0Z4MaMZadw+1/fNi2TrmJQRb761JFsFqqkaPYqPGV3RuQka7u7a+OIyPSFLLvn1kXYLk80lyyuqejJdecfpzl5LA==
Received: from MW4PR03CA0230.namprd03.prod.outlook.com (2603:10b6:303:b9::25)
 by BN5PR12MB9510.namprd12.prod.outlook.com (2603:10b6:408:2ac::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.35; Tue, 15 Apr
 2025 04:58:22 +0000
Received: from SJ1PEPF000023CF.namprd02.prod.outlook.com
 (2603:10b6:303:b9:cafe::40) by MW4PR03CA0230.outlook.office365.com
 (2603:10b6:303:b9::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.34 via Frontend Transport; Tue,
 15 Apr 2025 04:58:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF000023CF.mail.protection.outlook.com (10.167.244.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8655.12 via Frontend Transport; Tue, 15 Apr 2025 04:58:22 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 14 Apr
 2025 21:58:11 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 14 Apr
 2025 21:58:11 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Mon, 14 Apr 2025 21:58:10 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>, <robin.murphy@arm.com>, <jgg@nvidia.com>
CC: <joro@8bytes.org>, <kevin.tian@intel.com>, <praan@google.com>,
	<nathan@kernel.org>, <yi.l.liu@intel.com>, <peterz@infradead.org>,
	<mshavit@google.com>, <jsnitsel@redhat.com>, <smostafa@google.com>,
	<jeff.johnson@oss.qualcomm.com>, <zhangzekun11@huawei.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <shameerali.kolothum.thodi@huawei.com>
Subject: [PATCH v2 02/11] iommu/arm-smmu-v3: Pass in smmu/iommu_domain to __arm_smmu_tlb_inv_range()
Date: Mon, 14 Apr 2025 21:57:37 -0700
Message-ID: <ed8b2837e5ea63f6ee98663761d4f1ebe66a6d41.1744692494.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023CF:EE_|BN5PR12MB9510:EE_
X-MS-Office365-Filtering-Correlation-Id: 898d9638-4163-4a31-5a74-08dd7bda25dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014|7416014|3613699012;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+HU7UvY9jjvq6eWFoslFg6sAomDh4mVPvmg+/vTqFGo8DIqDBr+eomASEgLG?=
 =?us-ascii?Q?RC/9ipY9A8JESj3IL/iAvvz96Ls1C3ZLXLUu08KpEZEwtJTIE8ITXNgk4pkR?=
 =?us-ascii?Q?SxbKtqUiteFf1bfuoKOP/bTihfGG5OZpdKhFXXdlpDYUo3mA/lbfEs/5yvqx?=
 =?us-ascii?Q?ZybXuVZO3FzahLIgy9HpM12yuMPQfVeUZEcphn3VFdBpK8+9j54Q/iYJaXwg?=
 =?us-ascii?Q?y7YWcUdYbztCxPy4MVt1nwIGR8GgTHK8dy7ppwcN8sF3B6OTrhInaGPwj+r3?=
 =?us-ascii?Q?GtqfeuE9qG3sadO1tx8Hab020SyBFe0KLIWcHi1OixgEmUeAhJN/brQ3CO0f?=
 =?us-ascii?Q?y8OhcQ4Yviu701K+REfWMnPgGiV9fT2W0nxYELKZyS0QitMuq1pOta867lfv?=
 =?us-ascii?Q?MRGTm1XifS1NrNBGqs1h3d6rZlfK5bleGmCtw72s0ZKQ5g95+ua7wxCUSIZn?=
 =?us-ascii?Q?tkf9K1CmY1Wj22lrnUjuWm5//zpPUWzE0mhmjOoLApF8TAiVuUBkaIlkYA7W?=
 =?us-ascii?Q?g8R+0awhHYtN/VcBZLsQgds8ddizvKwneiL39S0hVTmhDE3Lkd7nzBiEgejg?=
 =?us-ascii?Q?cow3SZEoFJFoyk4GzxyCJjq9mvCpUXGw3S2Eafa4xgt+tsqLiipNPPtaP8pI?=
 =?us-ascii?Q?pvXkIc+BACaDp3FkC+lllredOE9Z+VWpBa9HAN5qMftSmRJCrNj+VjcNGZtP?=
 =?us-ascii?Q?vKI6o0zuC8J7et/TBvnR7BEEvh8wvDdIcelpj/NddEElO3QURs40v06kPzzs?=
 =?us-ascii?Q?D88iDHmRkxN3kZ9nGcnCH/LGnkOV/Pqk5TT137EM7wKYMUbv1O5XiqKMqqi/?=
 =?us-ascii?Q?K1PbWP+Zm1kUqwXJkmJ2DnpIU1nJDWyFaEy2vzdAY3o73bjuEEGGwKTyPlgW?=
 =?us-ascii?Q?+ciNNmAHzDNY5h6ExPacjMEoaV+/YW8eBja5yEzJCTXyinJPHZKF3mLsyuaH?=
 =?us-ascii?Q?TtejLS4DbHq2Gr+dnjpFXjIatrCNUiXuiyQvaAlLM+LLEH2caOpH8xl3J9ET?=
 =?us-ascii?Q?bMmIAHxhImsH48766alsJqSswV6K0WBi6DhFNv3yXveJ/EaMhgEfeJ0O3PIQ?=
 =?us-ascii?Q?289oh6yK6+IIhsOFpmHXN2gnMPqhhkf0/ZowW7m1Wnac4nm49+xfm7E80ENZ?=
 =?us-ascii?Q?TeG0/3Z6YUvyjrsP8VBZmdbw250eDVmh8yphma39Xsl0kcbzxfza/MUGxc1b?=
 =?us-ascii?Q?0kvpofq7Ad6S4Oi61ri6re7oam9D4vmeN/iGwfN8ezZp3s5nflFJg+vE/vxn?=
 =?us-ascii?Q?ClP7DB3VfSZCXcW5lww9wMvOJl3zwigB5eXElHueVQrHFccmRZ1wi7YadWhb?=
 =?us-ascii?Q?HW6SMFDHe+MmbqL94jYHnaIZrFbLFynonuDu3us0b4lwaZoM04Qr68LRzxDM?=
 =?us-ascii?Q?onyQCkutyez5t4zAecc+ULPhH9X6fYYn8t3AUxq/Buc48Hmng40dZuO1dOAf?=
 =?us-ascii?Q?olMXWV+nhiI4BJ1Mru5MuWoPaZv8WDJbsKu/UM188iLFrRKdrsELbDjJFipq?=
 =?us-ascii?Q?Mk28FOzYth3oZ8jh0FnRMJ7uXraieVxgEt7E8/duryGy4nRQDTXHctWiKXf1?=
 =?us-ascii?Q?BhphzpCBWCnPBuRt9fw=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014)(7416014)(3613699012);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2025 04:58:22.3579
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 898d9638-4163-4a31-5a74-08dd7bda25dd
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023CF.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN5PR12MB9510

What __arm_smmu_tlb_inv_range() really needs is the smmu and iommu_domain
pointers from the smmu_domain.

For a nest_parent smmu_domain, it will no longer store an smmu pointer as
it can be shared across vSMMU instances. A vSMMU structure sharing the S2
smmu_domain instead would hold the smmu pointer.

Pass them in explicitly to fit both !nest_parent and nest_parent cases.

While changing it, share it in the header with arm-smmu-v3-iommmufd that
will call it too.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  4 ++++
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 17 +++++++++--------
 2 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index d4837a33fb81..5dbdc61558a9 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -955,6 +955,10 @@ void arm_smmu_tlb_inv_range_asid(unsigned long iova, size_t size, int asid,
 				 struct arm_smmu_domain *smmu_domain);
 int arm_smmu_atc_inv_domain(struct arm_smmu_domain *smmu_domain,
 			    unsigned long iova, size_t size);
+void __arm_smmu_tlb_inv_range(struct arm_smmu_device *smmu,
+			      struct arm_smmu_cmdq_ent *cmd, unsigned long iova,
+			      size_t size, size_t granule,
+			      struct iommu_domain *domain);
 
 void __arm_smmu_cmdq_skip_err(struct arm_smmu_device *smmu,
 			      struct arm_smmu_cmdq *cmdq);
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 1ec5efca1d42..e9d4bbdacc99 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2267,12 +2267,11 @@ static void arm_smmu_tlb_inv_context(void *cookie)
 	arm_smmu_atc_inv_domain(smmu_domain, 0, 0);
 }
 
-static void __arm_smmu_tlb_inv_range(struct arm_smmu_cmdq_ent *cmd,
-				     unsigned long iova, size_t size,
-				     size_t granule,
-				     struct arm_smmu_domain *smmu_domain)
+void __arm_smmu_tlb_inv_range(struct arm_smmu_device *smmu,
+			      struct arm_smmu_cmdq_ent *cmd, unsigned long iova,
+			      size_t size, size_t granule,
+			      struct iommu_domain *domain)
 {
-	struct arm_smmu_device *smmu = smmu_domain->smmu;
 	unsigned long end = iova + size, num_pages = 0, tg = 0;
 	size_t inv_range = granule;
 	struct arm_smmu_cmdq_batch cmds;
@@ -2282,7 +2281,7 @@ static void __arm_smmu_tlb_inv_range(struct arm_smmu_cmdq_ent *cmd,
 
 	if (smmu->features & ARM_SMMU_FEAT_RANGE_INV) {
 		/* Get the leaf page size */
-		tg = __ffs(smmu_domain->domain.pgsize_bitmap);
+		tg = __ffs(domain->pgsize_bitmap);
 
 		num_pages = size >> tg;
 
@@ -2356,7 +2355,8 @@ static void arm_smmu_tlb_inv_range_domain(unsigned long iova, size_t size,
 		cmd.opcode	= CMDQ_OP_TLBI_S2_IPA;
 		cmd.tlbi.vmid	= smmu_domain->s2_cfg.vmid;
 	}
-	__arm_smmu_tlb_inv_range(&cmd, iova, size, granule, smmu_domain);
+	__arm_smmu_tlb_inv_range(smmu_domain->smmu, &cmd, iova, size, granule,
+				 &smmu_domain->domain);
 
 	if (smmu_domain->nest_parent) {
 		/*
@@ -2387,7 +2387,8 @@ void arm_smmu_tlb_inv_range_asid(unsigned long iova, size_t size, int asid,
 		},
 	};
 
-	__arm_smmu_tlb_inv_range(&cmd, iova, size, granule, smmu_domain);
+	__arm_smmu_tlb_inv_range(smmu_domain->smmu, &cmd, iova, size, granule,
+				 &smmu_domain->domain);
 }
 
 static void arm_smmu_tlb_inv_page_nosync(struct iommu_iotlb_gather *gather,
-- 
2.43.0

