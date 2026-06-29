Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013002.outbound.protection.outlook.com [40.107.201.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 395293C5522
	for <iommu@lists.linux.dev>; Mon, 29 Jun 2026 21:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782767792; cv=fail; b=s3+AbK2BIZTHoKB26weE6JFqWDUjPZwMRqVa3vl1phyv7GyN3OKMVLXlbOILqXocL7l6vPzGqa8puflC1xgd9aRw7FsQfB8EQR4NQcxQJd2cznn4SC7PArm2Z6vflG5kPpvN9M8d+a88sZjpdM3xx4IDVwsudW6I79BwFlL0ftY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782767792; c=relaxed/simple;
	bh=3eELhNPihG8nm4toZ7jCivjStCoyN/mSE3uHulxpM2w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K9KmgJAODpdNHz6cmP96AxEC8MniayogWKSb9rHqEftMt55WWF+RynN11VVDAyMSCvbeH6lid/Zf1fnR4KniO2XHq/rWPXFDn90kf5WI0m5sNoJR9eKHgFiZUZLGdvGdvlzvXl9FVhIi6Cmzv7rxkh59bEyx32YLfnqDh7begrg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HiOQDU1l; arc=fail smtp.client-ip=40.107.201.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HiOQDU1l"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xdXgKvST6W6F4BbcoNnrJSeOeX1d4GWj4usFjLO4Nkju+TKU3aQmu38N0BoX2Q0gfbfQ6KXolspnOEF0QPLD5n04cRvdZveBFpRddwvtpqERrMmdnM1nj0NyZbZ3cCBy50qrUvZs9Tl2Uo7KZaqag7VWZhBve1BL6o5Q9ij+NndbhnIinzNI1ACO6FgnHAxftnt6aSzvZLFcW593/9dY5aMRADWNd0wAZYWXDgFSgtPmr5JDzdlXS/Pxyy+5cUqQmPJDKyT9XDd5gWU48/gPdKzNoT3OTuHnsLxCQVUFZVdTqPBkQzFgWOgiRZc/cJ8o5jQd11VTAykkCsxxCaD3Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LPdKOiX7afMz3lSqnmqFZtRiHknFAFWbgjQXO0El3jo=;
 b=eS4Ktstkvcji8pXhEIv3CdrSrgoBWwJsrj5Zxs2UyHbuPsQeImmbPSVEiWrM75xn0aIu2kJIc3/Pkbd9ZpAr7WipeQX1W5iYbNsSy/+IbN1FDCRT/X0zfx/WWizL00aReTJ1CJHX1nktUTyLzzkqb+tF2Dsp0eUVgzEuHhv8EhEd1QiYi8Zq2y1o09yX8nsEehtE8ZssHzwR7nxo9p4NqGzdnJFKfaCilAKeIfie6zQ0Ajy7XnJbwyB0+yOKK4cS76KvbasG1RTyEnDBjB4AvlGlUm5hbVa3JQrYCZdlzc/XUgNsVuOkjGAS57t400EYa2v5UVARZRxLY0ZxYiA6aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LPdKOiX7afMz3lSqnmqFZtRiHknFAFWbgjQXO0El3jo=;
 b=HiOQDU1lMcZM4c6/9ka9gK5G6qBntWwMq0OjUJ1N1NG2VD0k7Ul+gCKtDb5j3Ja2wMXbmDIjTtdYk0n3hoM+J/SXIqdrfOcELYyPG7JEFxrnff3xucbWQ5G8jl0lyVQJrkcZtZTronwrAkVk1wbABUwXPjHdrS7DnkQ4XtPb1L2Lh8Nfeba112UKAzTflp1qAtY6jGi9ZNQugxpkgCPY3WRVI0BUi4FbI9PzW6x6zWbSnRT1eBZbGq4U4Yeyevk86HaVrro8tJgEQCHIA7Q+3hqFB6llCGhq1bKEQCHdmrdj525K6F4BragD8Rymyenn8V5+CirkkfWidxuOePAVfg==
Received: from SJ0PR13CA0097.namprd13.prod.outlook.com (2603:10b6:a03:2c5::12)
 by IA1PR12MB7711.namprd12.prod.outlook.com (2603:10b6:208:421::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Mon, 29 Jun
 2026 21:16:23 +0000
Received: from CO1PEPF000066E6.namprd05.prod.outlook.com
 (2603:10b6:a03:2c5:cafe::c) by SJ0PR13CA0097.outlook.office365.com
 (2603:10b6:a03:2c5::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.8 via Frontend Transport; Mon, 29
 Jun 2026 21:16:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1PEPF000066E6.mail.protection.outlook.com (10.167.249.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Mon, 29 Jun 2026 21:16:22 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 29 Jun
 2026 14:16:00 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 29 Jun
 2026 14:16:00 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 29 Jun 2026 14:15:59 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>, "Kevin
 Tian" <kevin.tian@intel.com>, Lu Baolu <baolu.lu@linux.intel.com>
CC: Robin Murphy <robin.murphy@arm.com>, <joro@8bytes.org>, David Woodhouse
	<dwmw2@infradead.org>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v1 5/5] iommu/vt-d: Convert nested cache invalidation to the core array loop
Date: Mon, 29 Jun 2026 14:15:40 -0700
Message-ID: <58eb6a9c1ba59ab3b4d1617adf697262f4c2a633.1782767398.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1782767398.git.nicolinc@nvidia.com>
References: <cover.1782767398.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000066E6:EE_|IA1PR12MB7711:EE_
X-MS-Office365-Filtering-Correlation-Id: 9afeec47-3f2d-49eb-a420-08ded623abc5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700016|82310400026|23010399003|1800799024|22082099003|18002099003|5023799004|11063799006|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info:
	q4gHBssPqx3HLXrdHtbH4rS1VYo41anbZXH8f3avUfR9a79Do43omnzRAbJjFd6RA3+U86HpfmUcsytTzXOq6mvrbfj56jOuOFBG02a0IwnIsb6uKLg/EyelSUKjs1ExOS4NCyyvwzIGHuv85l0UoBlz+OVZAw2X2raM+8eM45jDd2cswE51G3YoVsZqFFcg5bsyWIM5hCNbxNaCPpYKQNyK8njPQxWYtAco8yQFyKZpHJAo22xIN4kl7aLwA8SZUb13iQZn6zlyD5qR1cCIPhoj7ZErkGiwGAuckscBHtPQEfJlJoxhq8zr8m4DnzSCtbe2cYyfk21NitLYicoABf39qSbzHepq7t93U5IhmwiAaYEeyMJC3yYRtuMvOPNI9m8/41hK6GfFWCUQPsnsmEppf/teLJVCYomM96l+FX50B6+uiOsnD9xkwTU+tMymeEVMB2tdQouDZDI50glHz8QdCUXClINsUbdll8BDDfHAUYSlTvPEmO5QhL15buILaQ0UoZeyPxgDO4ShP2He7uYDfSUI+cGLHLcpUT1OTeGBfZTyDDlNP3oSdzxHyV0yz2RfNmpuG/HKMtnjKb08kHNDtsZuJgQ5Ir22Py5ltOMVdj2SWltvsguvV9yInHufGXDtZHtVC+R8S8WUC0BvRy6uzkNbdIz8Sp5ft/A4DXggOCI5/QEH/ezxNdV3XLjKWwHVnala4GTcnFOYjCMYxA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700016)(82310400026)(23010399003)(1800799024)(22082099003)(18002099003)(5023799004)(11063799006)(56012099006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	VoSNmI7Dkiqvkzo8MKe5JGnzZtWFfhFJ4ZDex8n+xP4NiDS25MuglH4EiO+0Gx+PZ5nXj5xhWEI+O+01eZcFiVbv9JMV1ypeO11IhWxOFulYfHHp3YyXxSPWFp3w1uQsYJT76DVqYJK08bempK1dhtm79ILUSyLBcFaFqKjaKO8etIN1NroqFyu54m5TIAmApd4rjLNEnr2iaoQh2KILB0ml6SwZ5o4CnJhD9Ob6YWkNZeV32uu4rIgUIqITRXuCqIuWQYSl1pLOIkgKoAFvNUISLhLIy4KHF78rIz4HM412f54avEyPqSniVJZOtVZbGeE8ePingo1Cri2r8ElbLeg4Nq7qu5yXkapP6tK/qVA9EFuH2qWj2F21EVDOFYZjJUJ8GWV+GZojuwR4TQSJ5H+xHVAAYHltWMNM0qFxEFXnU+XyyIC3P60OpXyfiyhK
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 21:16:22.6153
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9afeec47-3f2d-49eb-a420-08ded623abc5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000066E6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7711

intel_nested_cache_invalidate_user() used to walk the whole request array
on its own, copying and then flushing one single entry at a time.

The iommufd core now iterates the request array itself and re-invokes the
op with the not-yet-handled sub-array, so handle just a single request per
call out of the front of that sub-array and report one handled entry via
the array->entry_num. An empty array keeps returning a success, used as a
probe of IOMMU_HWPT_INVALIDATE_DATA_VTD_S1 support.

Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/intel/nested.c | 54 ++++++++++++++++++++----------------
 1 file changed, 30 insertions(+), 24 deletions(-)

diff --git a/drivers/iommu/intel/nested.c b/drivers/iommu/intel/nested.c
index 2b979bec56cef..cad5c1573196e 100644
--- a/drivers/iommu/intel/nested.c
+++ b/drivers/iommu/intel/nested.c
@@ -93,7 +93,7 @@ static int intel_nested_cache_invalidate_user(struct iommu_domain *domain,
 {
 	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
 	struct iommu_hwpt_vtd_s1_invalidate inv_entry;
-	u32 index, processed = 0;
+	u32 processed = 0;
 	int ret = 0;
 
 	if (array->type != IOMMU_HWPT_INVALIDATE_DATA_VTD_S1) {
@@ -101,31 +101,37 @@ static int intel_nested_cache_invalidate_user(struct iommu_domain *domain,
 		goto out;
 	}
 
-	for (index = 0; index < array->entry_num; index++) {
-		ret = iommu_copy_struct_from_user_array(&inv_entry, array,
-							IOMMU_HWPT_INVALIDATE_DATA_VTD_S1,
-							index, __reserved);
-		if (ret)
-			break;
-
-		if ((inv_entry.flags & ~IOMMU_VTD_INV_FLAGS_LEAF) ||
-		    inv_entry.__reserved) {
-			ret = -EOPNOTSUPP;
-			break;
-		}
-
-		if (!IS_ALIGNED(inv_entry.addr, VTD_PAGE_SIZE) ||
-		    ((inv_entry.npages == U64_MAX) && inv_entry.addr)) {
-			ret = -EINVAL;
-			break;
-		}
-
-		cache_tag_flush_range(dmar_domain, inv_entry.addr,
-				      inv_entry.addr + nrpages_to_size(inv_entry.npages) - 1,
-				      inv_entry.flags & IOMMU_VTD_INV_FLAGS_LEAF);
-		processed++;
+	/*
+	 * The core re-invokes this op for the remaining requests, so handle one
+	 * request per call. A zero-length array only probes the type, validated
+	 * above.
+	 */
+	if (!array->entry_num)
+		goto out;
+
+	ret = iommu_copy_struct_from_user_array(
+		&inv_entry, array, IOMMU_HWPT_INVALIDATE_DATA_VTD_S1, 0,
+		__reserved);
+	if (ret)
+		goto out;
+
+	if ((inv_entry.flags & ~IOMMU_VTD_INV_FLAGS_LEAF) ||
+	    inv_entry.__reserved) {
+		ret = -EOPNOTSUPP;
+		goto out;
+	}
+
+	if (!IS_ALIGNED(inv_entry.addr, VTD_PAGE_SIZE) ||
+	    (inv_entry.npages == U64_MAX && inv_entry.addr)) {
+		ret = -EINVAL;
+		goto out;
 	}
 
+	cache_tag_flush_range(dmar_domain, inv_entry.addr,
+			      inv_entry.addr +
+				      nrpages_to_size(inv_entry.npages) - 1,
+			      inv_entry.flags & IOMMU_VTD_INV_FLAGS_LEAF);
+	processed = 1;
 out:
 	array->entry_num = processed;
 	return ret;
-- 
2.43.0

