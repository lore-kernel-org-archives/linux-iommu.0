Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011025.outbound.protection.outlook.com [40.107.208.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 817183093BC
	for <iommu@lists.linux.dev>; Wed, 17 Dec 2025 23:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766014862; cv=fail; b=cMFcIUf0N1vcBW2VVkLKgARiInpkXxfPi5PAFAW3RYlt9qhGb8yt9bzo1F8SSZBnXbiWTkadDt7ckirwMvdQGPZghc1toerBfzK3xvOxVDMtwG6d/AaECasWwg63Qha2jfSMhZg7+02HlDF5z1EUd7LyrF5vQcXdZ6xu6KL87hQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766014862; c=relaxed/simple;
	bh=MNxcC0pJorokX1oaVppXwxGSNMGCwRHKTIRM1h9Z2Fg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HMwSFDT2hYHZ/mbArXVE7IRXNGQN8QwFTEuYyD3u8VkOyf1lMtphqGsNdftlzNT0iG8eATTCD3bdrEZn9b3Ucr15PHAWlmP7vrwe6cdIwLNP2Xv9bwIGxXfakO7ReYzHXN0ZF7zVFb07wTbYx9DYrhZDZNn5lkDtRRxUmBDEua4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UuPhq/Lw; arc=fail smtp.client-ip=40.107.208.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UuPhq/Lw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ilBDIX25YgsUkhlCX5aGrZ1RFaoObn8ZkBg/IZ5qa9BHplyGWSwCi0QVkFbteOi/RPAv7gMM4J3gW7C2dSlCDGkhJH6/nxqKfPcPx5WryTs+eZgPlR0E78hor0bv35IKF0MNBW/excveT7s3EYvPAWHpbhJJbxq//SsCW4IelqtMit+sNpluwL6GtXzjiANPsLpDBSkCw04etNZ+sGw6YSAVRuAb72a1bQGKYccHycCEo9iMkkzWibcGuwnCn6QccPQO+AjzgOhEUsPjUfxOZ36XjkO+RbenW+5bC2LQOKM//IZJBiP760Dt7Dy1c3XSD0jeeIH52TzNACmJ2+bqsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T4S8lprZm4tNykfbsBLi+6TZ+tOgxKC09GeyBLwxSUg=;
 b=TRNgeG/HeKqxgtd0JayIniPra+z0uC5D7SbuLvWH43r4UYrI3OE8cke7Adi8ODNawSemUyjhkdV++6fUwp1pASqpB1fnmil3241hSHtBvaX9QvhU8dedDwt/+naYCYzBdCxxyr0fqw4OaZvvc6zBoXTS/2EZVAnWp8xYrnUHikvGaO9XyKK3g3OrRAMozf4lXZHanBoWrnpGxbnir8e7de1MwE9pJF0UHCT6Ij5ywsHZSYpuYJIVhCKKn315kZRohdSez4mVQAjiAO5HVM+JyYAgdvfZQfAW2kMgHCPQDbJJtcgcrhkqzCHV4fYHrLDOahOa3jPa9D/ljt1LW/kwVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T4S8lprZm4tNykfbsBLi+6TZ+tOgxKC09GeyBLwxSUg=;
 b=UuPhq/LwpTqgZS/G2r+oVqYjWlGV5GJETaNQXIFQSs1C0OgsBmMylAyLSNKnf+3pK46JDZWtiYuxqYZYIzhJUmzh39FJQcl0LFLF1RGGb98DcFO+txlV2TgKlZYpAyxIBxpBU8Qtu4Iv/vnoiuynjF+h7IPK+BMXRMGI0jSQvBEhAa9E7DSFVfrQNsTu3VwJRa2KczeQgSFsuuS0fghDVPIO+wcjrm5xycxYbnBwzz1XqDGB5e7yKDeaSDNf0jbpCDPV5LGCY0xq8OaDE+AA4jOQFO3b9Y7o7oHkbLqLwEsW/gKFsSkGbSdY0/51NyBxzFCmiWdb6KPWLLY9+SWJvQ==
Received: from MN2PR04CA0024.namprd04.prod.outlook.com (2603:10b6:208:d4::37)
 by IA1PR12MB7566.namprd12.prod.outlook.com (2603:10b6:208:42e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Wed, 17 Dec
 2025 23:25:08 +0000
Received: from BL6PEPF00020E61.namprd04.prod.outlook.com
 (2603:10b6:208:d4:cafe::c8) by MN2PR04CA0024.outlook.office365.com
 (2603:10b6:208:d4::37) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.6 via Frontend Transport; Wed,
 17 Dec 2025 23:25:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF00020E61.mail.protection.outlook.com (10.167.249.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.6 via Frontend Transport; Wed, 17 Dec 2025 23:25:08 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 17 Dec
 2025 15:24:52 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 17 Dec
 2025 15:24:52 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Wed, 17 Dec 2025 15:24:51 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>
CC: <jean-philippe@linaro.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<jgg@nvidia.com>, <balbirs@nvidia.com>, <miko.lenczewski@arm.com>,
	<peterz@infradead.org>, <kevin.tian@intel.com>, <praan@google.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v8 7/7] iommu/arm-smmu-v3: Perform per-domain invalidations using arm_smmu_invs
Date: Wed, 17 Dec 2025 15:24:32 -0800
Message-ID: <be2867c39f19e8710e0bd2c274050e88cee5afc5.1766013662.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1766013662.git.nicolinc@nvidia.com>
References: <cover.1766013662.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E61:EE_|IA1PR12MB7566:EE_
X-MS-Office365-Filtering-Correlation-Id: 665555f4-84e1-4faa-8ff9-08de3dc3848f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9QqyiKgj1zEx7Ob11XdGmdaSUI1xDAgPDliVRmIr5dQBSsHSNyNSXSLHXXVk?=
 =?us-ascii?Q?jiaV0Bk583Eiqrw584Ipfuufd1FTMiQM5h18YnMCi8a4lfSGU/kIVXmZZzpq?=
 =?us-ascii?Q?36BifsqbPWs+kwXm95L7y6IU87XhEJuPiBnGym+z5zHge7ex6tuviJ+8Xzwh?=
 =?us-ascii?Q?nKHJC3oWR+SECVqK1pJy5k8DVYvvBZKLbtjrIs6O0899kTtMMHiQXGq1NHOT?=
 =?us-ascii?Q?bkFfmbqsjmsi5A1WIU0Gw9M+ex4dV1gegq1ea+lv7cnsB9Y6UJF29gzGI7V+?=
 =?us-ascii?Q?kM9umYVdRFaJBxIGR76+zZjfgeJDEaEKpNIpD+yrFLpVX+umandwv9o9m7TZ?=
 =?us-ascii?Q?Ld8ZJJXnWURagCn1Dur7PWR3GYmZ4GVsr27+3g38bGD6yujKW+tjjbr5o2RF?=
 =?us-ascii?Q?5yqvWBFK6S2j50SB5++FfgfHz8ziC4GuseQW3HuSJTqzLw8ua9I0XsxLrtp+?=
 =?us-ascii?Q?xzLPRJIDJF3K6RAZbB1Yc90/dg/FMg8lQiuNKDFDGgNZ2DNmED+Ta3C2/gBT?=
 =?us-ascii?Q?IrPr4AsE8wwKx74j9eucX0CftWmwnRA3/f0LYxu6uia5RTnZ/rqgT5d1UOdz?=
 =?us-ascii?Q?QPqdf35yGHQ5ldJTGjgt8lgo8u7YJgshYuvuRlawbFkCbG2w+rJATsvnQCK2?=
 =?us-ascii?Q?fEB785EV+BHdVBlIVrUwmOXq2L9ALN6a5oErOhngH1h2FiQoHupZJq6Pu/Np?=
 =?us-ascii?Q?xp4Gt5dPRKt4ALQMFOVV3KcZ25tuUbOuhlAkhoC4y7lAuGlhlYHzjgrfL7j3?=
 =?us-ascii?Q?HJxjxdbId/dmTTJSNgW4SwnW6PX+tgEde5QayM+qB8vOknJxANuobWJVtJhf?=
 =?us-ascii?Q?BOmxBxumSoT3jeZ7I1Z4KChydw/Ixppj7EFKomrJD8NFy7lVF5gzhEzEXfLs?=
 =?us-ascii?Q?9wl3OxivbW4ze6ZKx0Ff+hz+ONl+Hdy46PEO1fKclgxBisQ3b8NA6CGm5dbI?=
 =?us-ascii?Q?gOUA2RHrJia7EfabNewcnrTwZ/Q8/JYdrEcnJbN4lfRW8Uycnun3osW9bIr/?=
 =?us-ascii?Q?RQaNMNMEobqCB71jMQ92IJvgxAUqpQEM4VP7qeVrmzxDndvZZn20KqaQe/X0?=
 =?us-ascii?Q?zuYidWqtKWTQq8G7VXpfeEmeFgf1fJrMsD65dMLn/lbss+tJKs28VN48EGa/?=
 =?us-ascii?Q?6rm+CTl8qp94aZ7YlrjZ8X6f5W5Nx+Tj+OfBtvN5ImH8PEdEZuF+aZMteUlK?=
 =?us-ascii?Q?bnq+i+6ybqme5GC7wdSifEtS5XF+M/nlWGhtLspTEsWMpafZvStBV4VPDUi8?=
 =?us-ascii?Q?M3lc0+8BBekiJnTKHMmHf+1P3AX1fYwv6ApqBYhi/pXAknreyHhyxrUc1SZm?=
 =?us-ascii?Q?nyz8sQZRtBWJqg3TMkdrvmJP2dcKhmHuHb4LRabaKrzFQh7PuZPXKgiOJOvv?=
 =?us-ascii?Q?IjaxzeHqE2CvtwyIbpGrxZB3U2bAAYcvynaSR0h6Ulz8zlORwW89BbQ7OP1U?=
 =?us-ascii?Q?3CIjNBs9Q0cHoiqd/M5px0FtaXR1DTj3tn8dlCoCSSHhgr8aMOf2JHwoSQH4?=
 =?us-ascii?Q?qX/4c8WFoRBG8J0vX6/yeXYJSm0r9Ve1br3+50z2pLHbQylpIFpJcF+dXV2b?=
 =?us-ascii?Q?XClHpRMwhGictATEit0=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2025 23:25:08.3045
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 665555f4-84e1-4faa-8ff9-08de3dc3848f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E61.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7566

Replace the old invalidation functions with arm_smmu_domain_inv_range() in
all the existing invalidation routines. And deprecate the old functions.

The new arm_smmu_domain_inv_range() handles the CMDQ_MAX_TLBI_OPS as well,
so drop it in the SVA function.

Since arm_smmu_cmdq_batch_add_range() has only one caller now, and it must
be given a valid size, add a WARN_ON_ONCE to catch any missed case.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |   7 -
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c   |  29 +--
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 165 +-----------------
 3 files changed, 11 insertions(+), 190 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index c3fee7f14480..4f104c1baa67 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -1079,13 +1079,6 @@ int arm_smmu_set_pasid(struct arm_smmu_master *master,
 		       struct arm_smmu_domain *smmu_domain, ioasid_t pasid,
 		       struct arm_smmu_cd *cd, struct iommu_domain *old);
 
-void arm_smmu_tlb_inv_asid(struct arm_smmu_device *smmu, u16 asid);
-void arm_smmu_tlb_inv_range_asid(unsigned long iova, size_t size, int asid,
-				 size_t granule, bool leaf,
-				 struct arm_smmu_domain *smmu_domain);
-int arm_smmu_atc_inv_domain(struct arm_smmu_domain *smmu_domain,
-			    unsigned long iova, size_t size);
-
 void arm_smmu_domain_inv_range(struct arm_smmu_domain *smmu_domain,
 			       unsigned long iova, size_t size,
 			       unsigned int granule, bool leaf);
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
index 440ad8cc07de..f1f8e01a7e91 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
@@ -122,15 +122,6 @@ void arm_smmu_make_sva_cd(struct arm_smmu_cd *target,
 }
 EXPORT_SYMBOL_IF_KUNIT(arm_smmu_make_sva_cd);
 
-/*
- * Cloned from the MAX_TLBI_OPS in arch/arm64/include/asm/tlbflush.h, this
- * is used as a threshold to replace per-page TLBI commands to issue in the
- * command queue with an address-space TLBI command, when SMMU w/o a range
- * invalidation feature handles too many per-page TLBI commands, which will
- * otherwise result in a soft lockup.
- */
-#define CMDQ_MAX_TLBI_OPS		(1 << (PAGE_SHIFT - 3))
-
 static void arm_smmu_mm_arch_invalidate_secondary_tlbs(struct mmu_notifier *mn,
 						struct mm_struct *mm,
 						unsigned long start,
@@ -146,21 +137,8 @@ static void arm_smmu_mm_arch_invalidate_secondary_tlbs(struct mmu_notifier *mn,
 	 * range. So do a simple translation here by calculating size correctly.
 	 */
 	size = end - start;
-	if (!(smmu_domain->smmu->features & ARM_SMMU_FEAT_RANGE_INV)) {
-		if (size >= CMDQ_MAX_TLBI_OPS * PAGE_SIZE)
-			size = 0;
-	} else {
-		if (size == ULONG_MAX)
-			size = 0;
-	}
-
-	if (!size)
-		arm_smmu_tlb_inv_asid(smmu_domain->smmu, smmu_domain->cd.asid);
-	else
-		arm_smmu_tlb_inv_range_asid(start, size, smmu_domain->cd.asid,
-					    PAGE_SIZE, false, smmu_domain);
 
-	arm_smmu_atc_inv_domain(smmu_domain, start, size);
+	arm_smmu_domain_inv_range(smmu_domain, start, size, PAGE_SIZE, false);
 }
 
 static void arm_smmu_mm_release(struct mmu_notifier *mn, struct mm_struct *mm)
@@ -191,8 +169,7 @@ static void arm_smmu_mm_release(struct mmu_notifier *mn, struct mm_struct *mm)
 	}
 	spin_unlock_irqrestore(&smmu_domain->devices_lock, flags);
 
-	arm_smmu_tlb_inv_asid(smmu_domain->smmu, smmu_domain->cd.asid);
-	arm_smmu_atc_inv_domain(smmu_domain, 0, 0);
+	arm_smmu_domain_inv(smmu_domain);
 }
 
 static void arm_smmu_mmu_notifier_free(struct mmu_notifier *mn)
@@ -302,7 +279,7 @@ static void arm_smmu_sva_domain_free(struct iommu_domain *domain)
 	/*
 	 * Ensure the ASID is empty in the iommu cache before allowing reuse.
 	 */
-	arm_smmu_tlb_inv_asid(smmu_domain->smmu, smmu_domain->cd.asid);
+	arm_smmu_domain_inv(smmu_domain);
 
 	/*
 	 * Notice that the arm_smmu_mm_arch_invalidate_secondary_tlbs op can
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 788c20a9aa76..d7c492ee0936 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -1266,16 +1266,6 @@ struct arm_smmu_invs *arm_smmu_invs_purge(struct arm_smmu_invs *invs)
 EXPORT_SYMBOL_IF_KUNIT(arm_smmu_invs_purge);
 
 /* Context descriptor manipulation functions */
-void arm_smmu_tlb_inv_asid(struct arm_smmu_device *smmu, u16 asid)
-{
-	struct arm_smmu_cmdq_ent cmd = {
-		.opcode	= smmu->features & ARM_SMMU_FEAT_E2H ?
-			CMDQ_OP_TLBI_EL2_ASID : CMDQ_OP_TLBI_NH_ASID,
-		.tlbi.asid = asid,
-	};
-
-	arm_smmu_cmdq_issue_cmd_with_sync(smmu, &cmd);
-}
 
 /*
  * Based on the value of ent report which bits of the STE the HW will access. It
@@ -2430,74 +2420,10 @@ static int arm_smmu_atc_inv_master(struct arm_smmu_master *master,
 	return arm_smmu_cmdq_batch_submit(master->smmu, &cmds);
 }
 
-int arm_smmu_atc_inv_domain(struct arm_smmu_domain *smmu_domain,
-			    unsigned long iova, size_t size)
-{
-	struct arm_smmu_master_domain *master_domain;
-	int i;
-	unsigned long flags;
-	struct arm_smmu_cmdq_ent cmd = {
-		.opcode = CMDQ_OP_ATC_INV,
-	};
-	struct arm_smmu_cmdq_batch cmds;
-
-	if (!(smmu_domain->smmu->features & ARM_SMMU_FEAT_ATS))
-		return 0;
-
-	/*
-	 * Ensure that we've completed prior invalidation of the main TLBs
-	 * before we read 'nr_ats_masters' in case of a concurrent call to
-	 * arm_smmu_enable_ats():
-	 *
-	 *	// unmap()			// arm_smmu_enable_ats()
-	 *	TLBI+SYNC			atomic_inc(&nr_ats_masters);
-	 *	smp_mb();			[...]
-	 *	atomic_read(&nr_ats_masters);	pci_enable_ats() // writel()
-	 *
-	 * Ensures that we always see the incremented 'nr_ats_masters' count if
-	 * ATS was enabled at the PCI device before completion of the TLBI.
-	 */
-	smp_mb();
-	if (!atomic_read(&smmu_domain->nr_ats_masters))
-		return 0;
-
-	arm_smmu_cmdq_batch_init(smmu_domain->smmu, &cmds, &cmd);
-
-	spin_lock_irqsave(&smmu_domain->devices_lock, flags);
-	list_for_each_entry(master_domain, &smmu_domain->devices,
-			    devices_elm) {
-		struct arm_smmu_master *master = master_domain->master;
-
-		if (!master->ats_enabled)
-			continue;
-
-		if (master_domain->nested_ats_flush) {
-			/*
-			 * If a S2 used as a nesting parent is changed we have
-			 * no option but to completely flush the ATC.
-			 */
-			arm_smmu_atc_inv_to_cmd(IOMMU_NO_PASID, 0, 0, &cmd);
-		} else {
-			arm_smmu_atc_inv_to_cmd(master_domain->ssid, iova, size,
-						&cmd);
-		}
-
-		for (i = 0; i < master->num_streams; i++) {
-			cmd.atc.sid = master->streams[i].id;
-			arm_smmu_cmdq_batch_add(smmu_domain->smmu, &cmds, &cmd);
-		}
-	}
-	spin_unlock_irqrestore(&smmu_domain->devices_lock, flags);
-
-	return arm_smmu_cmdq_batch_submit(smmu_domain->smmu, &cmds);
-}
-
 /* IO_PGTABLE API */
 static void arm_smmu_tlb_inv_context(void *cookie)
 {
 	struct arm_smmu_domain *smmu_domain = cookie;
-	struct arm_smmu_device *smmu = smmu_domain->smmu;
-	struct arm_smmu_cmdq_ent cmd;
 
 	/*
 	 * NOTE: when io-pgtable is in non-strict mode, we may get here with
@@ -2506,14 +2432,7 @@ static void arm_smmu_tlb_inv_context(void *cookie)
 	 * insertion to guarantee those are observed before the TLBI. Do be
 	 * careful, 007.
 	 */
-	if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1) {
-		arm_smmu_tlb_inv_asid(smmu, smmu_domain->cd.asid);
-	} else {
-		cmd.opcode	= CMDQ_OP_TLBI_S12_VMALL;
-		cmd.tlbi.vmid	= smmu_domain->s2_cfg.vmid;
-		arm_smmu_cmdq_issue_cmd_with_sync(smmu, &cmd);
-	}
-	arm_smmu_atc_inv_domain(smmu_domain, 0, 0);
+	arm_smmu_domain_inv(smmu_domain);
 }
 
 static void arm_smmu_cmdq_batch_add_range(struct arm_smmu_device *smmu,
@@ -2525,7 +2444,7 @@ static void arm_smmu_cmdq_batch_add_range(struct arm_smmu_device *smmu,
 	unsigned long end = iova + size, num_pages = 0, tg = pgsize;
 	size_t inv_range = granule;
 
-	if (!size)
+	if (WARN_ON_ONCE(!size))
 		return;
 
 	if (smmu->features & ARM_SMMU_FEAT_RANGE_INV) {
@@ -2580,76 +2499,6 @@ static void arm_smmu_cmdq_batch_add_range(struct arm_smmu_device *smmu,
 	}
 }
 
-static void __arm_smmu_tlb_inv_range(struct arm_smmu_cmdq_ent *cmd,
-				     unsigned long iova, size_t size,
-				     size_t granule,
-				     struct arm_smmu_domain *smmu_domain)
-{
-	struct arm_smmu_device *smmu = smmu_domain->smmu;
-	struct arm_smmu_cmdq_batch cmds;
-	size_t pgsize;
-
-	/* Get the leaf page size */
-	pgsize = __ffs(smmu_domain->domain.pgsize_bitmap);
-
-	arm_smmu_cmdq_batch_init(smmu, &cmds, cmd);
-	arm_smmu_cmdq_batch_add_range(smmu, &cmds, cmd, iova, size, granule,
-				      pgsize);
-	arm_smmu_cmdq_batch_submit(smmu, &cmds);
-}
-
-static void arm_smmu_tlb_inv_range_domain(unsigned long iova, size_t size,
-					  size_t granule, bool leaf,
-					  struct arm_smmu_domain *smmu_domain)
-{
-	struct arm_smmu_cmdq_ent cmd = {
-		.tlbi = {
-			.leaf	= leaf,
-		},
-	};
-
-	if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1) {
-		cmd.opcode	= smmu_domain->smmu->features & ARM_SMMU_FEAT_E2H ?
-				  CMDQ_OP_TLBI_EL2_VA : CMDQ_OP_TLBI_NH_VA;
-		cmd.tlbi.asid	= smmu_domain->cd.asid;
-	} else {
-		cmd.opcode	= CMDQ_OP_TLBI_S2_IPA;
-		cmd.tlbi.vmid	= smmu_domain->s2_cfg.vmid;
-	}
-	__arm_smmu_tlb_inv_range(&cmd, iova, size, granule, smmu_domain);
-
-	if (smmu_domain->nest_parent) {
-		/*
-		 * When the S2 domain changes all the nested S1 ASIDs have to be
-		 * flushed too.
-		 */
-		cmd.opcode = CMDQ_OP_TLBI_NH_ALL;
-		arm_smmu_cmdq_issue_cmd_with_sync(smmu_domain->smmu, &cmd);
-	}
-
-	/*
-	 * Unfortunately, this can't be leaf-only since we may have
-	 * zapped an entire table.
-	 */
-	arm_smmu_atc_inv_domain(smmu_domain, iova, size);
-}
-
-void arm_smmu_tlb_inv_range_asid(unsigned long iova, size_t size, int asid,
-				 size_t granule, bool leaf,
-				 struct arm_smmu_domain *smmu_domain)
-{
-	struct arm_smmu_cmdq_ent cmd = {
-		.opcode	= smmu_domain->smmu->features & ARM_SMMU_FEAT_E2H ?
-			  CMDQ_OP_TLBI_EL2_VA : CMDQ_OP_TLBI_NH_VA,
-		.tlbi = {
-			.asid	= asid,
-			.leaf	= leaf,
-		},
-	};
-
-	__arm_smmu_tlb_inv_range(&cmd, iova, size, granule, smmu_domain);
-}
-
 static bool arm_smmu_inv_size_too_big(struct arm_smmu_device *smmu, size_t size,
 				      size_t granule)
 {
@@ -2850,7 +2699,9 @@ static void arm_smmu_tlb_inv_page_nosync(struct iommu_iotlb_gather *gather,
 static void arm_smmu_tlb_inv_walk(unsigned long iova, size_t size,
 				  size_t granule, void *cookie)
 {
-	arm_smmu_tlb_inv_range_domain(iova, size, granule, false, cookie);
+	struct arm_smmu_domain *smmu_domain = cookie;
+
+	arm_smmu_domain_inv_range(smmu_domain, iova, size, granule, false);
 }
 
 static const struct iommu_flush_ops arm_smmu_flush_ops = {
@@ -4145,9 +3996,9 @@ static void arm_smmu_iotlb_sync(struct iommu_domain *domain,
 	if (!gather->pgsize)
 		return;
 
-	arm_smmu_tlb_inv_range_domain(gather->start,
-				      gather->end - gather->start + 1,
-				      gather->pgsize, true, smmu_domain);
+	arm_smmu_domain_inv_range(smmu_domain, gather->start,
+				  gather->end - gather->start + 1,
+				  gather->pgsize, true);
 }
 
 static phys_addr_t
-- 
2.43.0

