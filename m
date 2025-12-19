Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013031.outbound.protection.outlook.com [40.93.201.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27A3332A3C3
	for <iommu@lists.linux.dev>; Fri, 19 Dec 2025 20:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766175160; cv=fail; b=NPaBuYPEjnNCCHAkAf35OOBgO+tI16tjTkFdcTVfkmro1/yvXUKdG5lRCsS9pKNSCZwQyf+vO/DHtKUAlsqJFreIxkZ14XIxXWtyVJisnVLMj1WiaEXAUXQdxCeKh4OJxwM8s5uzkeBz7uixS3ubMjoQgGccfUuQ7GiLemEQ1rQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766175160; c=relaxed/simple;
	bh=CmuI0yEi1bGmdGf3AK712SXh0arDoWBNIuDJxdJKenc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WtRvnEKaHC/c41Wd78hWSlfizUgQh9fl9j3mOEz3Q6GM+CvpHqTdX0075b+PdsXWyTAEVXUyUG/VIcgQugYiV/QDYLnymqAKoXJ4sFYKTrGHOhoVIyKs6kyEfejp2jkAHc4jdoLj+Q44btVXW4lA76hH9iaWK5XDsJbkic3EGE0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QpDpIxnZ; arc=fail smtp.client-ip=40.93.201.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QpDpIxnZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n74Cwmv8yH9265AN6cyq4o6f1r0jghrZAgvunvjgVBrnG08tKdYp7oTBmFPNoGH96HTmxE0DAtmZwG+A5szm3f8M/QRkr1nCuns5vfUFbWZ+JGSAb1ViIncvdN0v0FVZWGW0wjVSF5TOknPpt4Gyla795Po/xE3Qr5RFcfyAJwkqlhI2sUEPXPYMoMkRKwKQm7el9UjjU8MqeK852Qf3aEqQcObQyXDO94I5BWLWgQxuLYpZdQjC6U1cOFLHDoEGTgOyVeLlRGju3uLhy8McMgMSmWaXV9iBPD91RQhjtq6HtVAWyYJcn1B8vccmd/qL8cCw5seC4M1Ibwn+SgGNMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MsO/nDG+zRdaL4qZUeyjPmZaxzLp3QOjcvvBuZ+UOEY=;
 b=Cg1PL90B1bBXYvOh3QyTNPCi0U+rHWv0HDEzXQTHcAiRi1595Go5UDsaBmz2n9dYZ8Ew2pfAfRe+aqHlwn8N86jrQ4MwAUCEkBdLEWV+fB7Y7tpb3Whl08nvFVas+9xVAaH1VoMr2EJ5WZxp7bLLqgEqU8ZJ79EwXLRUtqL+tAn6GSF33AUGKFJZZuFknNtPOLUSPwXq2Hj1c2y1HBwTgBNWESGFjhTJSKm+Ef6MnWc98ZwKi1hIzScx5FmOxwieIhh/nTXbbQtkOtwkOK/9nE9fQoD4ABn8etQK4VeI5JZlIZP+qNCXEwhUaEzKW+3qBrvdjIKZ71XXhUJvdVYW7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MsO/nDG+zRdaL4qZUeyjPmZaxzLp3QOjcvvBuZ+UOEY=;
 b=QpDpIxnZ4laJEaocnqUXydqJcYBDOMcLxIja0YNaIHTcnRGZlpfKAKdvt3UcmZzmvHw8GIeGZASoQKHdZ7F/uNcVRerqj5uCSbegbtXaID9856QhWMN59SbTF7nGlZpiQxMawguSUgdFudj28ilIQbMoSBZsrA/u1JSRJeg9FtFty+Zjuaz7YapQyS4bsIzThJPzr36C7NgEn6vnHjFMiSjsXp61BtvE9NAnphZrnxLz9p3KFsdljAlSEyCBDjCG/wSevGtP5kyGXSCzsBMq3xgoZdUfTxBW0N7kwy1kMlN2baPpBQXCRQ21xUvF6bJ/RjCiScUPzHrt6V+MfB3E3g==
Received: from SJ0PR03CA0138.namprd03.prod.outlook.com (2603:10b6:a03:33c::23)
 by DS0PR12MB7770.namprd12.prod.outlook.com (2603:10b6:8:138::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.9; Fri, 19 Dec
 2025 20:12:31 +0000
Received: from SJ1PEPF000026C5.namprd04.prod.outlook.com
 (2603:10b6:a03:33c:cafe::79) by SJ0PR03CA0138.outlook.office365.com
 (2603:10b6:a03:33c::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.9 via Frontend Transport; Fri,
 19 Dec 2025 20:12:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF000026C5.mail.protection.outlook.com (10.167.244.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.6 via Frontend Transport; Fri, 19 Dec 2025 20:12:31 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 19 Dec
 2025 12:12:16 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 19 Dec
 2025 12:12:16 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Fri, 19 Dec 2025 12:12:15 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>
CC: <jean-philippe@linaro.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<jgg@nvidia.com>, <balbirs@nvidia.com>, <miko.lenczewski@arm.com>,
	<peterz@infradead.org>, <kevin.tian@intel.com>, <praan@google.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v9 7/7] iommu/arm-smmu-v3: Perform per-domain invalidations using arm_smmu_invs
Date: Fri, 19 Dec 2025 12:11:29 -0800
Message-ID: <308ed579c724879a4a20b19ccdcb33e917597d77.1766174731.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1766174731.git.nicolinc@nvidia.com>
References: <cover.1766174731.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C5:EE_|DS0PR12MB7770:EE_
X-MS-Office365-Filtering-Correlation-Id: c254010d-4944-4a95-576d-08de3f3af0b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WrzNZbHHrwca045TU6+rguPu7x/BUxooILngAPoz05EJbdDYngpHmHCpCOsP?=
 =?us-ascii?Q?OX7qKORQNvb8jRbwyadViCANbbmDPGM+w7a99U7UpkbrLnQQEn2y6ztBXgT6?=
 =?us-ascii?Q?xIeqrpQ09SQyW32/VSvbiU9rdWazyKLkcp0uoyN8mjuB6PBkfvXfbWCQMeWx?=
 =?us-ascii?Q?iLpCxfORUtK83ymsl4lbusx1Stn0vCj2PHLHQ3t3nIeKzmRD9PKunAhwI1lr?=
 =?us-ascii?Q?nv+r78dkvzKMGhUVl53A6wQB3L7MAGgmjVx6MyY6wxD9tihXQN8Hy8+zAokQ?=
 =?us-ascii?Q?LkS2Dsw5zkxOLkmmolw4ao3uY9eNU9rQQNjkuQeAJyVLrSX2ElgmiuuvfXVn?=
 =?us-ascii?Q?VQp1upJpfPidn8Foydh5qR/v98Q6uQlpGKXBBb+LEuajHZYx88NoLRLKzCUu?=
 =?us-ascii?Q?xKpxQiRpkI1FiEwkraJ6zFd1gTuATq0ctWWgKzbQHhbXdd1HZ2AR0xX88gkC?=
 =?us-ascii?Q?ibNafF6K72Mxd6zKBfU7VWmHtQpePDrXfPReqyt9iL68PoqHYYZWipt2Wymq?=
 =?us-ascii?Q?EU3RBg0ywiR2cTkFyl9uWMUM13iL7pUramVEHPVUZ3FnjUlrZFkryD7MvNGd?=
 =?us-ascii?Q?ynkBywkynUbn6PD5WUZvWOYFfNuu7sc/6ITzjglDCrHQc5l1CcPcOfnqH1+K?=
 =?us-ascii?Q?sH9586Yj/7q19F0IUwPqfEP0UxInhrG7ynT2VPp2b7lbmWYaaGGXiDvBUamw?=
 =?us-ascii?Q?KJ4iEqJ1Acq8r/FliT7k2VCUE3tSD6/Kqxt7Gp5AujKri/UFuejUKdbYRuB3?=
 =?us-ascii?Q?XabBXwWWslS2XgoTFmnJidlso/NpTIvpF+tz6qvNaS6LNyQ1qJ2H5X4bKnsc?=
 =?us-ascii?Q?E3MZY/9lpHS5LioC6MSUpkPeVh1yugJJ6PLiZRybelQNPRHXXtASwt7YEcRv?=
 =?us-ascii?Q?RT22Nv7l5nJDz3iGX/2jmDi5Tkhk+tZ2ATbX0WvnOvSV7YlKLgGA+/+GGrM2?=
 =?us-ascii?Q?u+r9Rne3WN9mj7ietKYqMDf/BBC7APQJS0p57IxVeI4UrK12BBEX1i5NNGgk?=
 =?us-ascii?Q?12ORosucaGPyNRQKBSESbhLfzXqSXmOb+vqUcXvV+V2PYXj64lTfV9rDbJsR?=
 =?us-ascii?Q?17SoQIqPov5lf5F+UNk3ByuAgBjPH2+5YZhcBUnXJJMTlo9QBpv0ERF5vVVP?=
 =?us-ascii?Q?sLEp8D3/lS+0H4BNgyxF4GiIbw8QaQiSyeJ0JxBUkh4oxjXovujBx+a0GmV9?=
 =?us-ascii?Q?tDaVfX9bAXqb2IlaGo/80X6TV/uj2mVZw7fw8Z4eXKEbtHkXxy01JoAX87G2?=
 =?us-ascii?Q?Joq1jVKsm4JQyFeic0l6hiSUCSCFXjIrPQC2/2246CWIGIVTj/sUnCtn2Oh1?=
 =?us-ascii?Q?vNyW1iWrmLdxMkIv1Cabn+et6Y5wwK6sO8Y7Hg+Beq74Zb4XTTP19681mzAZ?=
 =?us-ascii?Q?QgQdz2U490PiRtZgB7u3JJoJ+jHoh2INmjiI7VeTpPQxSdQ6ZKTdHrMXcnaX?=
 =?us-ascii?Q?8UU5LHByyixSuJ0BdhAqfn4y66EbTVtNXkcnIdlzrucrhHDPjr1MLFNo49WV?=
 =?us-ascii?Q?8wYJBdJh+V2PPijNqaSpLjGV6Im0CAiduv5pCQDNOsuZc1nbhQmGF3qiY+H5?=
 =?us-ascii?Q?Zq3I0YEmGgI8ne3+Qs0=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2025 20:12:31.1824
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c254010d-4944-4a95-576d-08de3f3af0b7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000026C5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7770

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
index 6e1082e6d164..9912262a0e3b 100644
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
@@ -4150,9 +4001,9 @@ static void arm_smmu_iotlb_sync(struct iommu_domain *domain,
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

