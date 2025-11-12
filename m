Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011062.outbound.protection.outlook.com [52.101.62.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DC693587B4
	for <iommu@lists.linux.dev>; Wed, 12 Nov 2025 18:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762971979; cv=fail; b=S/LbmtWVe3MITreL+QCr/m5kpEfODJt1EFTN0U3DLn8mXRRgU8j03OOh2lqugzubuXBVlOcx56RLsiODAKGSIIDH2jVjxf1LuwTF7oYgvO6fZxeHOGxWYf9c9gzoAuVhhhguwgsHsac7ZBD+xpwR4g5KIhTcnnECCpkXL4c8o1I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762971979; c=relaxed/simple;
	bh=/92rYh126iF5amixGHYs+uo6GeqpKaT3RPErkPueYSk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gf9GgthMnVrrKqbIC6YozxeLWFLKICbVduYtT92HXMa7px52Bke5oJnWy/aUnDex7LSqooDZdHN7QSE8KGB3FXW8Zs5LEu22Ke45hswjVFLckiSvFbyxMsJDO7auWEERZ7lpz5xfNNmXSfM3ltRJJ/pNOKIH835iErngsotRS4o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=hkTnPRgT; arc=fail smtp.client-ip=52.101.62.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="hkTnPRgT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C8DnjoQ5VrubZjq0J5hpJ4YY+wx3UdE373l5mfrJMZJP9txDSUHDrSIP2RYmGB8gsNItDou8cDMtifBnEV/69KnmOh/qer7ifBq3mHhpm1QKozI/0n5g6cJYGcmuQiKJwfncQpJXPUu86veEwe7yjbOp2GWRupAA+Qj8Hgq0eEvxzUKZEecZSWJW8A7R7xxStD0KRUyMKdb9wlxrvu7qMWzd2NEBd4WhMGk27z1ISo5zgk/xyUJ/WIAUIE9/08fQjDTuu9IMQN2dcSV1xqeKZzYVkUoxVBrprKwhDtc3ruC2N8GX90TEvHsvwmtHwM68y8/kh/fnpvysl3npw52t7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tfD66YdBuYbCKNz4xv/ub76jT1GPVi86VnTU7ECfFm8=;
 b=hxWwy6ZTqUujBxuvsBBAYthEYseNbGcn9LydRUiQjKFDwoOw4xLdnhhy294EKqqdRInMMZZlCY1UC9WTVqkAVZMqFLxwIq1H6onDG7ceSw6Nzx1m8pVvaFBQP/IZjBg7mXxU5GAyN23d3SBje+N+xbxHy2WvBNWizWMuzX0A7f3mX1vTv82/HM7VM6T4JdRaXoOnhabkRSG/cUDWKA9Ckc8rNDkPrKSh3ibMnifK5QrcxmFsONr9aX4uhqPv0R6Gya62n0hrCSL8Trr7pYrSW4FDfs0hbvPpKgMWgK+Qn+IP2LxEgIN5k5Y19w1JPWu25LME6CpU4Nff28RBjGJQCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nvidia.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tfD66YdBuYbCKNz4xv/ub76jT1GPVi86VnTU7ECfFm8=;
 b=hkTnPRgTXpV8Lmxa6zBsiDnINpJIHGpJiTsCwXmsPyGY4Ec8wl1DMsXdlumQpznWSxbJ+8iRNgw2ptY/s8IS4r31Tw4kdhqp7jttwMUTSxIfjReSo2FnZ2j8L5hNBk1HWSgA9x2fO2m6yTb+vo4GNrMojUTSB1TAIwsEtUZu17Y=
Received: from BL1PR13CA0110.namprd13.prod.outlook.com (2603:10b6:208:2b9::25)
 by SJ0PR12MB6856.namprd12.prod.outlook.com (2603:10b6:a03:47f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Wed, 12 Nov
 2025 18:26:12 +0000
Received: from BL6PEPF0001AB55.namprd02.prod.outlook.com
 (2603:10b6:208:2b9::4) by BL1PR13CA0110.outlook.office365.com
 (2603:10b6:208:2b9::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.16 via Frontend Transport; Wed,
 12 Nov 2025 18:26:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB55.mail.protection.outlook.com (10.167.241.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Wed, 12 Nov 2025 18:26:12 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 12 Nov
 2025 10:26:06 -0800
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <jgg@nvidia.com>, <nicolinc@nvidia.com>
CC: <linux-kernel@vger.kernel.org>, <robin.murphy@arm.com>, <will@kernel.org>,
	<joro@8bytes.org>, <kevin.tian@intel.com>, <jsnitsel@redhat.com>,
	<vasant.hegde@amd.com>, <iommu@lists.linux.dev>, <santosh.shukla@amd.com>,
	<sairaj.arunkodilkar@amd.com>, <jon.grimm@amd.com>,
	<prashanthpra@google.com>, <wvw@google.com>, <wnliu@google.com>,
	<gptran@google.com>, <kpsingh@google.com>, <joao.m.martins@oracle.com>,
	<alejandro.j.jimenez@oracle.com>, Suravee Suthikulpanit
	<suravee.suthikulpanit@amd.com>
Subject: [PATCH v5 08/14] iommu/amd: Add support for nest parent domain allocation
Date: Wed, 12 Nov 2025 18:25:00 +0000
Message-ID: <20251112182506.7165-9-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251112182506.7165-1-suravee.suthikulpanit@amd.com>
References: <20251112182506.7165-1-suravee.suthikulpanit@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB55:EE_|SJ0PR12MB6856:EE_
X-MS-Office365-Filtering-Correlation-Id: cb60f37f-033f-40f1-6deb-08de2218f54e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700013|82310400026|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RmphVy9fuswVN7jDXlRIp2zdCcD0h2lq8D3tBi9R6p2uUNaWBVKY6rjq5+64?=
 =?us-ascii?Q?7rlyEC6CdBdOcXsyCDSQz05UlA/kRmgHLeAaohxgh1uBO0Z9KD/JxtHbPx0P?=
 =?us-ascii?Q?Rro/Uyq7KBQNRxDjqKLcyyQ8w77LTGrnND/9aBuToqGiXoqSW790F/ilFhzi?=
 =?us-ascii?Q?7GRagNtrjzLrpZs3OzgTo/ssrekbu6ajvX8AFFZSss4IUtTL52x2FXoO93YO?=
 =?us-ascii?Q?RTor69xShe6WM+7yq4RRnsNQR6DNoyUS5fGZo6C6gJ1CJBannJkOg0e5b+D0?=
 =?us-ascii?Q?4nYytOjW0qQr8OiRoCVGurkNcocYmR/Sz79JpQbKngoxXCcXMrxV5xXC1lRY?=
 =?us-ascii?Q?/DnD4joH8Mf0Ik84eaGeiEmBQgddjx/hRXGwiOiJVD+k9GOhZsPe6DG6CI3G?=
 =?us-ascii?Q?DyshiIzrxM4fO46kjDLja1CJtraU56m3J6X72dfyIk6Ti5onFfp0UDDlv2Yy?=
 =?us-ascii?Q?Jy6nZHUQLdjx8eKOzSqSnT6uA+bcNs6jOy7FAK+Xq3Fxt+tQJ/ytw1UZcUoJ?=
 =?us-ascii?Q?xAahFkyQx0S1hGIH9FXKhj2nWvaO6P7+voRGfQTh8gOJ6nGwq5iNV6oKfEKb?=
 =?us-ascii?Q?rY7GDTC/Mm9RfvAVdgJgiN1Tex11HuFpZfVc9ULWrkYBEBi92TjJdhpfy+hY?=
 =?us-ascii?Q?PniFPULGVmAjGbZFhTIBp+x4DM/CtnZJ+MNEUNF2swyrilzs9bHiJmoHHVQV?=
 =?us-ascii?Q?qC/4QtoyRNYHjVtUgFBHlyRjBgfHywvQpOr4tXWRpYKh4lpaw6tkRc+xdgCi?=
 =?us-ascii?Q?hOe0rgOy5IPUoJ5XngrP7fZnNtszNNmpyF8568sAptbXsiXS+SBYLQIrsNog?=
 =?us-ascii?Q?NuzWCHicmFhVVQSJISRsiJiWo2rV7/VIEsuCvnIWf1KvXxr3kO9kuuboSptx?=
 =?us-ascii?Q?y8U6dOYHHrxFW9Yzh2G0oUkEyE8pU1nV5ctavRtjLIYGvNBaAYKHvIYyf3Lr?=
 =?us-ascii?Q?IibwSZLLQK4ttSezinXuBqDhqF18qaZ6QcqlDPPeVmrAKTLm0rK5QCx15hcE?=
 =?us-ascii?Q?JaYMY1vfZVqO8LMh98VRy1Z3LBukbCZ07QmKKYFYnbdzFxzUoAQUcbOZZd4V?=
 =?us-ascii?Q?sfvXjx82xDoqdFLA+B6B41itmFN6U9zSJyDLfPRt+uD/tSZN13Y/mlrFcT/U?=
 =?us-ascii?Q?8iuTuD+y8MNiCAnHskY39xoZZRo3EDPZrXTgZ77/gm3+97dV9yuoYjgjN4Kc?=
 =?us-ascii?Q?me561l757kvts/ym/DGJzpzRHyUnXQrqRVLHxo/hnffuNZVVt9zWnBpNqjj+?=
 =?us-ascii?Q?qFsjoSMwKjtJY3Djnq8SUfMh35gqyl7i0y6uZHBZqgPAszLq7tzPfNMDQGRd?=
 =?us-ascii?Q?4QdpYc2yJDDXRE+ZLjq8rr86rPZTJ3cE7GiHMDJWOm/GUrBr3O9+tnBXeJXM?=
 =?us-ascii?Q?TV1NdL3XbhV2knjwzaRFpqFhSlj+82uElstuso7oNZFEDmKP74ixak1Kn7i5?=
 =?us-ascii?Q?OQS0/G7XwnITGiLPAzzfdMlsZVTQcx6XzLo1zzcGVxqRr3llwsuElmZYeEOm?=
 =?us-ascii?Q?gK52mH1y51U7vFZ6NIUZcebM66f3YvnUbBNldvAJWKYRXteRarF8qIF4zlGu?=
 =?us-ascii?Q?PaasNS6XAtrgk2o6928=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700013)(82310400026)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 18:26:12.2864
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cb60f37f-033f-40f1-6deb-08de2218f54e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB55.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6856

To support nested translation, the nest parent domain is allocated with
IOMMU_HWPT_ALLOC_NEST_PARENT flag, and stores information of the v1 page
table for stage 2 (i.e. GPA->SPA).

Also, only support nest parent domain on AMD system, which can support
the Guest CR3 Table (GCR3TRPMode) feature. This feature is required in
order to program DTE[GCR3 Table Root Pointer] with the GPA.

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/iommu.c | 26 +++++++++++++++++++++++---
 1 file changed, 23 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index a36426f096d2..e03aa8d946b3 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2727,6 +2727,14 @@ static struct iommu_domain *amd_iommu_domain_alloc_paging_v2(struct device *dev,
 	return &domain->domain;
 }
 
+static inline bool is_nest_parent_supported(u32 flags)
+{
+	/* Only allow nest parent when these features are supported */
+	return check_feature(FEATURE_GT) &&
+	       check_feature(FEATURE_GIOSUP) &&
+	       check_feature2(FEATURE_GCR3TRPMODE);
+}
+
 static struct iommu_domain *
 amd_iommu_domain_alloc_paging_flags(struct device *dev, u32 flags,
 				    const struct iommu_user_data *user_data)
@@ -2734,16 +2742,28 @@ amd_iommu_domain_alloc_paging_flags(struct device *dev, u32 flags,
 {
 	struct amd_iommu *iommu = get_amd_iommu_from_dev(dev);
 	const u32 supported_flags = IOMMU_HWPT_ALLOC_DIRTY_TRACKING |
-						IOMMU_HWPT_ALLOC_PASID;
+						IOMMU_HWPT_ALLOC_PASID |
+						IOMMU_HWPT_ALLOC_NEST_PARENT;
 
 	if ((flags & ~supported_flags) || user_data)
 		return ERR_PTR(-EOPNOTSUPP);
 
 	switch (flags & supported_flags) {
 	case IOMMU_HWPT_ALLOC_DIRTY_TRACKING:
-		/* Allocate domain with v1 page table for dirty tracking */
-		if (!amd_iommu_hd_support(iommu))
+	case IOMMU_HWPT_ALLOC_NEST_PARENT:
+	case IOMMU_HWPT_ALLOC_DIRTY_TRACKING | IOMMU_HWPT_ALLOC_NEST_PARENT:
+		/*
+		 * Allocate domain with v1 page table for dirty tracking
+		 * and/or Nest parent.
+		 */
+		if ((flags & IOMMU_HWPT_ALLOC_DIRTY_TRACKING) &&
+		    !amd_iommu_hd_support(iommu))
+			break;
+
+		if ((flags & IOMMU_HWPT_ALLOC_NEST_PARENT) &&
+		    !is_nest_parent_supported(flags))
 			break;
+
 		return amd_iommu_domain_alloc_paging_v1(dev, flags);
 	case IOMMU_HWPT_ALLOC_PASID:
 		/* Allocate domain with v2 page table if IOMMU supports PASID. */
-- 
2.34.1

