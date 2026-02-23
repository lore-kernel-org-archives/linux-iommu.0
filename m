Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011000.outbound.protection.outlook.com [52.101.62.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 471CA348440
	for <iommu@lists.linux.dev>; Mon, 23 Feb 2026 06:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771827539; cv=fail; b=Tt8jCsNF4rsBAq9vtSR3YTijrCdiThFUVVH93BSUiafDY2NdPoVXxbryxJgmPerTMEeFCkBwuWxLViU0/gBVMneFMc5vvAx3mmZrGzddLrOAqq3ZSTiNvWnI83OCnH4XPn/seIYUN2M7hM+gQhXN5Jv2SDi6fV3OTVQaBUKwAPU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771827539; c=relaxed/simple;
	bh=jzySCBimknjYLR8WdofVaWK1kW7EZYP7NcjHZBQxIZc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QfXLosHZmonH8HaGjZp1aE1xZN+Uf7JicJsIT6XFM3n84JnOPUbaobU59Z78D9J0NQpC4DGPXuhk6GEotfyLbQd+8wDmUfIQDHr0/h1kX4nU0yqXIMN5CAH9HeApJ+8h8RvV6jAZSLTFl0l0NnLwVwagOPGJP1RhYUWzBXwQgiw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SfUZMniL; arc=fail smtp.client-ip=52.101.62.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SfUZMniL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YMczI7dpY3vcb/P6qFaiQ7x1lllsC9uiXN7bon6ixNcxc+t3TEbONvbSa6k/aY5qTUc35Q/0LF2IBijvzh6pBZemTaqWzxLZ7m28sJaZ7P1obXWYq3gA9A6huLs/0obM0dnoX1cblWsGHSxHTzE/rD+NO/D3SSJ8584pPlaxmUPagZlQf7sYKLnokgM1/ZWRak/yPOEIdJW7meBQQ6sH0fCMyNfFT/3+E5UuqiWLocpYuIBCLuK3j+vy0L16NYld5dGvg9tjPGFKh6T+0y7CboD8++HoMP6RLn3vnXvEfAh6PFwCSO+Lb3dnX7X/BWFjTfAPhIImOA6kAmHUJpewGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dkRcolCgewjJ1DCI8uNtYcycmIlSK+bkAk8f9HkM0os=;
 b=PuS62QVv7zb4UbnQH7qT68o/fsbB4QCt5o2xvZ6pkN2p0GIiSGd+3QPrq8iuhtR4YGvqIpt8YU4zPuOHj4+Y91JGAJ/01TvRUVTFTlqKgtAyepYQClPuDxtjaL0zLQgLRz0eLJJO9kVXt/VrQ1Ifg7P+CcGJCoUqzUleT1Nrl9y++96KZahspQh1tIdbx2kBsbwr97NtNsbgENPb65Sb5dHKgnMf2uf8P4PPRc0OudZIggFg24g2guxMXknzBz87NiOvwPh8nvMZneFf10FWk78B+cdyodt2w6GNb7OrGaORL55LRB/L0RezM36dlo9ZAGee7VOBHOrVMqdwSW91lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dkRcolCgewjJ1DCI8uNtYcycmIlSK+bkAk8f9HkM0os=;
 b=SfUZMniLwojan8yDSfAOUIt8iEhlz/WEa4dthiZcPAZcHPP8L6jer4GNyXMKcA3GNxG7DK0VqmTVy1CcLhdtmJQPFFFjpwjYOg1yhu5/83om1bjz9PN1i8YWI8hRCPZhtfL1tawaKSRrYja/vhgDzdMLCGJk7hRUWewahoHV2+lhQrT2SXFR5OaSrghK6PbkX65gIKUqRLCEsFlTf+m5iRxW046lxuPIZTI7gw5R5L3VxmTZh0rCxGd6Qeh4w+Emf0xF3znjx7wIIiFYAKbOhPShVOCx+gl0Ku06AlJMS15ddO7y6Hc625bPNaycxmdL8PsM0MzgzB/ER7zxLyAzNg==
Received: from BYAPR08CA0045.namprd08.prod.outlook.com (2603:10b6:a03:117::22)
 by DM6PR12MB4385.namprd12.prod.outlook.com (2603:10b6:5:2a6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21; Mon, 23 Feb
 2026 06:18:48 +0000
Received: from MWH0EPF000A6735.namprd04.prod.outlook.com
 (2603:10b6:a03:117:cafe::c6) by BYAPR08CA0045.outlook.office365.com
 (2603:10b6:a03:117::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.21 via Frontend Transport; Mon,
 23 Feb 2026 06:18:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MWH0EPF000A6735.mail.protection.outlook.com (10.167.249.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Mon, 23 Feb 2026 06:18:48 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 22 Feb
 2026 22:18:25 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 22 Feb
 2026 22:18:24 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Sun, 22 Feb 2026 22:18:23 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>
CC: <jean-philippe@linaro.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<jgg@nvidia.com>, <balbirs@nvidia.com>, <miko.lenczewski@arm.com>,
	<peterz@infradead.org>, <kevin.tian@intel.com>, <praan@google.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v12 6/8] iommu/arm-smmu-v3: Populate smmu_domain->invs when attaching masters
Date: Sun, 22 Feb 2026 22:18:07 -0800
Message-ID: <a095daed30c5ebded34e35fd5785a62c3d92a5df.1771815709.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1771815709.git.nicolinc@nvidia.com>
References: <cover.1771815709.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6735:EE_|DM6PR12MB4385:EE_
X-MS-Office365-Filtering-Correlation-Id: fffc5c9a-339e-43d8-2864-08de72a36801
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?36g0o8e5Atr4V+gebrIvGk0TRH293NPgUy2G9rDl8Ku2iJ2W9zEWgPyTpDMc?=
 =?us-ascii?Q?Gj2cdmx9JEpg82BFAX7YfxW98ZoKu/t2h7jUxx84IF5SxMpYTJWZ90fGQi82?=
 =?us-ascii?Q?8Qq62A3Hi3LaDco3YxrA90wWh/IqJqEE51sJ+SfL86+3N840DHgFLqb7UmRd?=
 =?us-ascii?Q?4in2LJ1YGVjLmaLF9gjkoH4zPkuFzPkY9KOZxwOpVpuVwF8ojsMen0N2pzAT?=
 =?us-ascii?Q?DNyspl/s2ejQic/lQJg6excaLWYBxDKOFm1MRNDD3QxkCMkTzNfOnK6Mpya+?=
 =?us-ascii?Q?GOrOCPQUZQVEmGGqEmkVaDfnobvE1QO8X9UqzfRLmpDIgjVQDhzJIDoWWRQh?=
 =?us-ascii?Q?8HNyQLGeIBOiZ1BMurzpI1+BP0SfR6u8wiHwMcqObJ90sFIFK3Wqhq6bOIpX?=
 =?us-ascii?Q?UipnIMNGzCR69BdMb+vp+7kjjxBhtioZr1KKYrVbdPPcIrBMCl8PSqdBjUUH?=
 =?us-ascii?Q?wWvINBKjdQQu41OmzrgD76L6CAX1uvDcktL1bP/rXgItDxJUBxQj+ADeBdYT?=
 =?us-ascii?Q?HXUR59R4eE3DgO/BE+MhxuI8oGC3gUavPW0fyTE55KFVa/RNsgod0sehb1fX?=
 =?us-ascii?Q?I2057vh3NRnxLKtD+X5GUS8YOlcwp6V8UAzDGb0XOTBuCuWUhye/hciNlfM3?=
 =?us-ascii?Q?HVN+c781FLFo/OuXxzEy98AKioZ8GKmdN8lViFHfbQ+cAldspadZ7edZx+Pf?=
 =?us-ascii?Q?TYTjfWwzKZBNcYPmKt5Ikp3tezMJgMn0IdJvEwCAwAjHHhRJ0ANvu5efkj1D?=
 =?us-ascii?Q?8ti4/x7LTpDu4OPGgCxVli+9izyDQZjN4x2BUtHW93PqJcKbi63A7bsFcF1S?=
 =?us-ascii?Q?wqFMEm7y5zF8JouQp2jxEAjwdC/u1Uqa3akVDVigniTju65XeKXrX0CNiu8j?=
 =?us-ascii?Q?CG8T5V6AfmB01RVW33V6OOqki51nC2WgMMoEsdXF+64CIuYo6rsrhGqg1Uwp?=
 =?us-ascii?Q?NBHn94L3sv4ywoAseu49SmzuT4w8X59abDHnob2EmYLfRiOO4Pmre7X28MT6?=
 =?us-ascii?Q?xwOkwB3rj8hWZnh8fc3oejLW6CFyqf9kPidjAKGFh6gvlqO3XHg60HWT70wJ?=
 =?us-ascii?Q?OzgR6MumuJlLR3R6pgmg/eH4tYEXTklDWfu+Ht9p/TJ3bjNKSBbKZVuOltWQ?=
 =?us-ascii?Q?KAQTYVHWe1/lZMfXP4YNs3S0MJM0brPTQ3maD3MKocPROiIH6zKyj0FHjb5E?=
 =?us-ascii?Q?QXE8osxMt3kYmlewmO8fXOFH88ZfJ2HlTLCYqa9ko75yvaa6L6+wZSe3KZX+?=
 =?us-ascii?Q?xnTn5z3uy/EAPPYS2PQ3w6D6Pv+a3Hr8Dbb7jZ0h3irJbNeFG6OdmNwbAvt8?=
 =?us-ascii?Q?sw3HKYmcauEvyG1pDjXjvjYfSeO3ficFBnWzhEFwRg9GDg+WxX0IKVpUwOPq?=
 =?us-ascii?Q?ZEgzrpiKwSL8UnczjmSdmzpYIcD1hOIGzUaX9ZsPFHOJ7Gavg6mJcMyZ4VL0?=
 =?us-ascii?Q?rBeSzkQYn8tBm5Zw5v1/WqlTP4DaPD6VLyeQnJucJNlSdW8JUCTinuBgV8ho?=
 =?us-ascii?Q?pjeA+RSqquuMU0xZoxr2Ssa4j46QbN8MAgy5TjwDFK52wmm2I5epKeoZiT0E?=
 =?us-ascii?Q?fP/WcUf8Ux3BJQSnYF6jepx4M/zvR5niss+4GdLArBPrnMHDOMLzc/VHiYix?=
 =?us-ascii?Q?3PC/hTFSScCF02gf7mfOK7s64w+4dhEQFL01sf7Kxn1efuRLIuCyKSWeExlT?=
 =?us-ascii?Q?zfBbJA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	1w1/l/8PNaqf7IjEX9zSxYWdfkz8iPBvKyBJE9UpmQok2bUtLqwBGc7lEcs2J+HcV6rmyqkuJ48FP7zBYbuoHlXfh29jya/Ri8igqGAhknEsQZe2dN2O6PAZNH2idfNmIKLmb352tJSnAU/pn+f6T+XMGkt6aPhxKm7KHxN0B/godQjxUtX3BADYF8OWXL9cpHN4MNJ3QKfwpm+aqvibPgvX7svOof26fSTlDsGMbyCd+zrCBJjNBJPLKE0rCm2dfyfEte2veQM869n1wRNPX1PskObnlC4G9IHN8eej0YWN6QcW+SQeKGF7cyi25nf0SIGzDt0LW6QP5RGDsu67o61+KduywSZRidN2FbQ0iH94y7XQqSiND9aBHvRQac0uU+jYdedfB/adajJXksXNuN5eyiFrEexa1OAVn94+9tbMhTwiRPKKE9zcoG482I5s
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2026 06:18:48.1901
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fffc5c9a-339e-43d8-2864-08de72a36801
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A6735.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4385

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
index 7d8377f6a6838..9e406a57a1dcb 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -3142,6 +3142,121 @@ static void arm_smmu_disable_iopf(struct arm_smmu_master *master,
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
@@ -3171,6 +3286,135 @@ static void arm_smmu_remove_master_domain(struct arm_smmu_master *master,
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
@@ -3228,12 +3472,16 @@ int arm_smmu_attach_prepare(struct arm_smmu_attach_state *state,
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
@@ -3281,6 +3529,8 @@ int arm_smmu_attach_prepare(struct arm_smmu_attach_state *state,
 			atomic_inc(&smmu_domain->nr_ats_masters);
 		list_add(&master_domain->devices_elm, &smmu_domain->devices);
 		spin_unlock_irqrestore(&smmu_domain->devices_lock, flags);
+
+		arm_smmu_install_new_domain_invs(state);
 	}
 
 	if (!state->ats_enabled && master->ats_enabled) {
@@ -3300,6 +3550,8 @@ int arm_smmu_attach_prepare(struct arm_smmu_attach_state *state,
 	kfree(master_domain);
 err_free_vmaster:
 	kfree(state->vmaster);
+err_unprepare_invs:
+	kfree(state->new_domain_invst.new_invs);
 	return ret;
 }
 
@@ -3331,6 +3583,7 @@ void arm_smmu_attach_commit(struct arm_smmu_attach_state *state)
 	}
 
 	arm_smmu_remove_master_domain(master, state->old_domain, state->ssid);
+	arm_smmu_install_old_domain_invs(state);
 	master->ats_enabled = state->ats_enabled;
 }
 
@@ -3513,12 +3766,19 @@ static int arm_smmu_blocking_set_dev_pasid(struct iommu_domain *new_domain,
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

