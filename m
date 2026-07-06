Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011003.outbound.protection.outlook.com [40.93.194.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1C153B5306
	for <iommu@lists.linux.dev>; Mon,  6 Jul 2026 18:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783363676; cv=fail; b=V0R6l+qTGtDNhmNBW0x80/jl47b/alDSo1QiZn/tM8BuYMSYYFTdgdz4Bd1b9M7YzIkBeXx75sEdYbzqlDxESp+qZxrWe7iSlZFWULbC6SHjJz1kwg1+qS5bdxq3bo9zQvNj99jGmGNdTHxsX+CUnMk19Wy0LqJMwmJZdmNo5Nk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783363676; c=relaxed/simple;
	bh=QwbJg3G2AjP2Frl3SHNMwgD/SwceD1IVfDj93BzHYxQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ebJ2Nux58qVRbJErN2XHI+TkNyBJgihGKul6Qs9TE14GeoP0/08pQboIjO7RyB0vKnRxfxLG+1q/5VSB5WW2fpaAgh2fHhHvoJcsqTQSG3OnRaPIBWxe4dgrqhfvToT+iCHrNkljhzK0g5OpU/QOcxt/9YuJx/IaubLkM7txVWg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=b1F60/pA; arc=fail smtp.client-ip=40.93.194.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="b1F60/pA"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B0tX0HFJAxfbaauH6zF2KahUeA2hs8KB8WdkJHju05usoW+HEZOnreUgy1EyqYuuro/cq9M60eydwk+IDa6DNUOZd+sTzlTMBfBOvfYKyhqWIVzVBbK/slsETBsGC/LgeSGYodxSXz0CHydiNik5gH0L+ftliigyMMqJ1fL330l/tJ9Ym4K8ADbILAGu5pEdkzDhqnqGHArXz3KS2mVZho96XXcTUWH5gvHuolscCSG3aOb9jQUoeGNkifq2UeY2KaQKdRvf9fNvJYYkgYVoYqqQVXwSBitk6YcYek4GfmDKJVrmNcc65R4YMhGPJJdcX/V6tvzmyVOvGVO4Dse0FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A8yVLhTNEHVMtNZQvE8C0mepFF5QZRCcqOIZQc7Y7/o=;
 b=QanEk7caQ2mMP7WnwRKdzFiDPDdWV90xcu60SiO9efbd7ZOV3rTWobIItqZ2hmPwemRwz9vzVlJWvuiLX/c/njhGwwVWn5PDldFJnxxKewt4QJ42/mLOVP7W93dQANai6mTS/xWieW8gToG+D33Q4jgIM/EDBlXeegGerjEGqaiX9WswWgi2Re+n3h2hpo3+u2U3pZ1ebbC306Sn7C0B8d0kWyy2Ch2CgP0XA1cQVOOPfUhe4aogYPJz0T8wuiDJrCN0opHbWLb5IdGhsVluxFEwBoep1VrmmdtPFeF3ZPDp9/MktWHaHzizuKbC3nZxNFOw6xXtJa5gDu1T/AGnzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A8yVLhTNEHVMtNZQvE8C0mepFF5QZRCcqOIZQc7Y7/o=;
 b=b1F60/pAdVmWkS4XqMoV0RTsyya91u7oU0/JLP0wE5ROqbUrXqOWd8/APpGr640/47nFPCL475LLwYRUK986mus4kE2QfoDdSbH2jdNO9dSzDMGlfS0A2geKsq9chbLSpaa5LL5KwMjjt3CIN8zbE5ldw9x3Rnf9OLIFf7gbn6ZCx5O5w12CfArNZK5tgkHBEbRyzy0Lm0x2pI0cUsFqMSOlKYMVXxYZZsmSU0q4BxeMg+dZgf3EmvhFwHUi3jUo8D0yc3XkPEvqQaIDSERxi51VJhRC88nAOk93krPHFNlgZQZfa1CZCPPzV9mF9lT8ysFXSoP9FeP85Uxn6moPlQ==
Received: from DSZP220CA0009.NAMP220.PROD.OUTLOOK.COM (2603:10b6:5:280::16) by
 CY8PR12MB8361.namprd12.prod.outlook.com (2603:10b6:930:7b::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.10; Mon, 6 Jul 2026 18:47:27 +0000
Received: from DS1PEPF00017094.namprd03.prod.outlook.com
 (2603:10b6:5:280:cafe::73) by DSZP220CA0009.outlook.office365.com
 (2603:10b6:5:280::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.13 via Frontend Transport; Mon, 6
 Jul 2026 18:47:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 DS1PEPF00017094.mail.protection.outlook.com (10.167.17.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Mon, 6 Jul 2026 18:47:26 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Mon, 6 Jul
 2026 11:47:12 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 6 Jul 2026 11:47:11 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 6 Jul 2026 11:47:11 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>, "Kevin
 Tian" <kevin.tian@intel.com>, Lu Baolu <baolu.lu@linux.intel.com>
CC: Robin Murphy <robin.murphy@arm.com>, <joro@8bytes.org>, David Woodhouse
	<dwmw2@infradead.org>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 3/5] iommufd/selftest: Convert cache invalidation mocks to the core array loop
Date: Mon, 6 Jul 2026 11:46:53 -0700
Message-ID: <764d9bed428b588939b9270469fa0145662dfc4a.1783363477.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1783363477.git.nicolinc@nvidia.com>
References: <cover.1783363477.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF00017094:EE_|CY8PR12MB8361:EE_
X-MS-Office365-Filtering-Correlation-Id: 662cc67d-5673-42ae-1322-08dedb8f0686
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|82310400026|376014|36860700016|18002099003|6133799003|11063799006|5023799004|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	GzQ3c917EhuJFYz76NURqtECKgEFmf5FQvjrUkBSXxv8GkTJEqj7WLbXhhLIdfCiBunL6NfKHOwYFsKC9IBot7jGZ0kaV21nIg8acjpu52FIadeHuKhRBbTEKCd78US1avz66DCNoaTCO12ZYpPTkwNx+RPEH4QA64pDsZmhhRa8UQCFL0kaSi0fc6DGa9ScuFPFhOpBgYPVVTR+jOT9fYsWkvlvFZHMRwLCW0SpiqAScS61WG37khLdQ42QHY6nGE3I7WfZRahfn1VMqxjFST8Rp+jMZjt4Ihzw9UEaUXdzg+DGBYh/kZh8BxjytBgsRSFCdbsvAyAJtloOfnbkV+J2mOMVuzMGd/CSq6GK6+hMRd8zIHIYiu7LQFBgDs5MBIEmXopfVnwG6QcsVF38m4+97xL7OZs8BITQXql8RbEmj1B+S145l8mbQzO4JfMd4YJhzv7eiMhXjHOGzS0VO9UJlY8Sr3BrjSLqmr+9YdyulMbdxwo+lHDdCfSVYGma3+CyHInob8Mg9RNVflGchPzfk/FHMtgP2XMtJyZqjV3C+NqLm9DoFFyzKRxmP4st98Q1CtxZd7wbF8IPUqMUFYZE0HVOpr3awPFWDrjNwU8fjV0t3s3YcuIvMUsBNN7jf/3rc2at7bks0UMcMAYk42MBdmQqSD6fDnX6MljG3MaPuWrxOs2gyFtNFckxV7EViiHDYEUd7SUGrcgQ69aNrg==
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(82310400026)(376014)(36860700016)(18002099003)(6133799003)(11063799006)(5023799004)(22082099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	oHK+W9vA3Ob6wunihK1QxvOPa6Tpf3D+sHAgheJYCfgd8Vd+KDf2JStpz3ikhcOuJ62HYhdInOUnehNakekoV9vHg6Oo30BuhWkjlgr+M009w49ykkZ0rSsX9aNrj2Rl1JBRUbGTyxEgpsPC/o31Bwe/f0yt1fx2LKz/WWiOYSBpRQ36I5JvzXoqHCBkCq95ToldoRDn4PCuB/ShlU9UH2OcrzBOAGeOIYa5DhyiQhab3JTt9xaqy0HFD0+8FGBT3cUCMuWEa1GEqXnHC6fhqbQz0/9u7R0NEoC5cz/sOHeRoqC5k5e0cio/IYhfGLxy0MFfZGJP/vKd4MRRg0HqQPajJyQLxl7KOSTuNIH5hTGKh/1bO05PxublS2mj+vOf3FmiDhd0uAp72jQa5qX3+GsInOrBRm5YNzg7d1reuOnm6Ieihtrx50kzA3QmHN9M
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2026 18:47:26.8063
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 662cc67d-5673-42ae-1322-08dedb8f0686
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017094.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8361

The vIOMMU and the nested-domain selftest invalidation mocks each used to
walk the whole request array on their own, with the vIOMMU mock even
allocating a buffer sized to the entire array in order to do so first.

The iommufd core now iterates the request array itself and re-invokes the
op with the not-yet-handled sub-array, so handle just a single request per
call out of the front of that sub-array and report one handled entry via
the array->entry_num. Drop both of the loops and the kzalloc_objs() in the
viommu callback function, and keep returning a success for an empty array
as a probe of the selftest data type.

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommufd/selftest.c | 147 +++++++++++++++----------------
 1 file changed, 72 insertions(+), 75 deletions(-)

diff --git a/drivers/iommu/iommufd/selftest.c b/drivers/iommu/iommufd/selftest.c
index af07c642a5260..75846cf1f9c44 100644
--- a/drivers/iommu/iommufd/selftest.c
+++ b/drivers/iommu/iommufd/selftest.c
@@ -631,70 +631,63 @@ mock_viommu_alloc_domain_nested(struct iommufd_viommu *viommu, u32 flags,
 static int mock_viommu_cache_invalidate(struct iommufd_viommu *viommu,
 					struct iommu_user_data_array *array)
 {
-	struct iommu_viommu_invalidate_selftest *cmds;
-	struct iommu_viommu_invalidate_selftest *cur;
-	struct iommu_viommu_invalidate_selftest *end;
-	int rc;
+	struct iommu_viommu_invalidate_selftest cmd;
+	struct mock_dev *mdev;
+	struct device *dev;
+	u32 processed = 0;
+	int rc = 0;
+	int i;
 
-	/* A zero-length array is allowed to validate the array type */
-	if (array->entry_num == 0 &&
-	    array->type == IOMMU_VIOMMU_INVALIDATE_DATA_SELFTEST) {
-		array->entry_num = 0;
-		return 0;
+	if (array->type != IOMMU_VIOMMU_INVALIDATE_DATA_SELFTEST) {
+		rc = -EINVAL;
+		goto out;
 	}
 
-	cmds = kzalloc_objs(*cmds, array->entry_num);
-	if (!cmds)
-		return -ENOMEM;
-	cur = cmds;
-	end = cmds + array->entry_num;
+	/*
+	 * The core re-invokes this op for the remaining requests, so handle one
+	 * request per call. A zero-length array only probes the type, validated
+	 * above.
+	 */
+	if (!array->entry_num)
+		return 0;
 
-	static_assert(sizeof(*cmds) == 3 * sizeof(u32));
-	rc = iommu_copy_struct_from_full_user_array(
-		cmds, sizeof(*cmds), array,
-		IOMMU_VIOMMU_INVALIDATE_DATA_SELFTEST);
+	rc = iommu_copy_struct_from_user_array(
+		&cmd, array, IOMMU_VIOMMU_INVALIDATE_DATA_SELFTEST, 0,
+		cache_id);
 	if (rc)
 		goto out;
 
-	while (cur != end) {
-		struct mock_dev *mdev;
-		struct device *dev;
-		int i;
-
-		if (cur->flags & ~IOMMU_TEST_INVALIDATE_FLAG_ALL) {
-			rc = -EOPNOTSUPP;
-			goto out;
-		}
-
-		if (cur->cache_id > MOCK_DEV_CACHE_ID_MAX) {
-			rc = -EINVAL;
-			goto out;
-		}
+	if (cmd.flags & ~IOMMU_TEST_INVALIDATE_FLAG_ALL) {
+		rc = -EOPNOTSUPP;
+		goto out;
+	}
 
-		xa_lock(&viommu->vdevs);
-		dev = iommufd_viommu_find_dev(viommu,
-					      (unsigned long)cur->vdev_id);
-		if (!dev) {
-			xa_unlock(&viommu->vdevs);
-			rc = -EINVAL;
-			goto out;
-		}
-		mdev = container_of(dev, struct mock_dev, dev);
+	if (cmd.cache_id > MOCK_DEV_CACHE_ID_MAX) {
+		rc = -EINVAL;
+		goto out;
+	}
 
-		if (cur->flags & IOMMU_TEST_INVALIDATE_FLAG_ALL) {
-			/* Invalidate all cache entries and ignore cache_id */
-			for (i = 0; i < MOCK_DEV_CACHE_NUM; i++)
-				mdev->cache[i] = 0;
-		} else {
-			mdev->cache[cur->cache_id] = 0;
-		}
+	xa_lock(&viommu->vdevs);
+	dev = iommufd_viommu_find_dev(viommu, (unsigned long)cmd.vdev_id);
+	if (!dev) {
 		xa_unlock(&viommu->vdevs);
-
-		cur++;
+		rc = -EINVAL;
+		goto out;
+	}
+	mdev = container_of(dev, struct mock_dev, dev);
+
+	if (cmd.flags & IOMMU_TEST_INVALIDATE_FLAG_ALL) {
+		/* Invalidate all cache entries and ignore cache_id */
+		for (i = 0; i < MOCK_DEV_CACHE_NUM; i++)
+			mdev->cache[i] = 0;
+	} else {
+		mdev->cache[cmd.cache_id] = 0;
 	}
+	xa_unlock(&viommu->vdevs);
+
+	processed = 1;
 out:
-	array->entry_num = cur - cmds;
-	kfree(cmds);
+	array->entry_num = processed;
 	return rc;
 }
 
@@ -875,42 +868,46 @@ mock_domain_cache_invalidate_user(struct iommu_domain *domain,
 	struct mock_iommu_domain_nested *mock_nested = to_mock_nested(domain);
 	struct iommu_hwpt_invalidate_selftest inv;
 	u32 processed = 0;
-	int i = 0, j;
 	int rc = 0;
+	int i;
 
 	if (array->type != IOMMU_HWPT_INVALIDATE_DATA_SELFTEST) {
 		rc = -EINVAL;
 		goto out;
 	}
 
-	for ( ; i < array->entry_num; i++) {
-		rc = iommu_copy_struct_from_user_array(&inv, array,
-						       IOMMU_HWPT_INVALIDATE_DATA_SELFTEST,
-						       i, iotlb_id);
-		if (rc)
-			break;
+	/*
+	 * The core re-invokes this op for the remaining requests, so handle one
+	 * request per call. A zero-length array only probes the type, validated
+	 * above.
+	 */
+	if (!array->entry_num)
+		return 0;
 
-		if (inv.flags & ~IOMMU_TEST_INVALIDATE_FLAG_ALL) {
-			rc = -EOPNOTSUPP;
-			break;
-		}
+	rc = iommu_copy_struct_from_user_array(
+		&inv, array, IOMMU_HWPT_INVALIDATE_DATA_SELFTEST, 0, iotlb_id);
+	if (rc)
+		goto out;
 
-		if (inv.iotlb_id > MOCK_NESTED_DOMAIN_IOTLB_ID_MAX) {
-			rc = -EINVAL;
-			break;
-		}
+	if (inv.flags & ~IOMMU_TEST_INVALIDATE_FLAG_ALL) {
+		rc = -EOPNOTSUPP;
+		goto out;
+	}
 
-		if (inv.flags & IOMMU_TEST_INVALIDATE_FLAG_ALL) {
-			/* Invalidate all mock iotlb entries and ignore iotlb_id */
-			for (j = 0; j < MOCK_NESTED_DOMAIN_IOTLB_NUM; j++)
-				mock_nested->iotlb[j] = 0;
-		} else {
-			mock_nested->iotlb[inv.iotlb_id] = 0;
-		}
+	if (inv.iotlb_id > MOCK_NESTED_DOMAIN_IOTLB_ID_MAX) {
+		rc = -EINVAL;
+		goto out;
+	}
 
-		processed++;
+	if (inv.flags & IOMMU_TEST_INVALIDATE_FLAG_ALL) {
+		/* Invalidate all mock iotlb entries and ignore iotlb_id */
+		for (i = 0; i < MOCK_NESTED_DOMAIN_IOTLB_NUM; i++)
+			mock_nested->iotlb[i] = 0;
+	} else {
+		mock_nested->iotlb[inv.iotlb_id] = 0;
 	}
 
+	processed = 1;
 out:
 	array->entry_num = processed;
 	return rc;
-- 
2.43.0

