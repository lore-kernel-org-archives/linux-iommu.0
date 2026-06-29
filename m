Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012029.outbound.protection.outlook.com [52.101.43.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BB863C3437
	for <iommu@lists.linux.dev>; Mon, 29 Jun 2026 21:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782767787; cv=fail; b=OnK49vqkR6ZADDol89Q43fD+sJgyVaXKIMQZ8pLesJ1H3yJuNqHdiqljdhIyoJZV0runS2VrljakH51B6VcKEV2K0MnXLnrgdUTkskKldCyswBlP6Nd19gxa215Q3xapJebOkTruARh9HBbODtV4yoN0UKFhEa7mirmJcZItrME=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782767787; c=relaxed/simple;
	bh=eO2EWzJ+LVOxibuqrdEEtihUP8qIJw6EK3TNRBkOhT8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dbCiVCHmtCgIlY2V/5yd5fOlst/oYdxFfvF2tBEGEsRH8lsE6z4ijltl++GmlLpPQDDkMr44t58ipSSt35QL9lbqdUeEJztwddHkkSSGheOccXY7MLOVpnOAomc0cm/Fyi+lN/r+QRfn4gySP1Iequ1ztyrTy2yhafoeJzxAu8k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=onO4aHDe; arc=fail smtp.client-ip=52.101.43.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="onO4aHDe"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=alKSuGiNjvktAy2A88RzGrwC5PeepmZvSo6SCoVj8Hbc3A0X+maMxT9hIBgt5n6cAXDv7lMAXBqEzeHeOMNaECXWk+OLDHWl1EPkG5FtzMQq1nupp1ytBJ84rrHaB5UMr6e0Cy/JqChIR8l0vHwBHvz7YxYXWs7Mq085r+Db8T/ljpkw5UMMnfDHQjYOA3GDTIH0KKud1/a8i6f6VGL8vpzgKQVZKah+mI2WucEctUI8O73AHtrOlqu16Albd/xk9fOX4wOTxMBgQs2wsFr3/Y0sB4JSUef26W9VAcp49Kk3ENFjYV3dZfJH1SDjmmShG5whj2oGTDZXdKEXU4HPZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s22lhQvp+nJgPR7aN0emPTA6egkG2Y4mTS5rf3cOTwY=;
 b=lhPasYjOx2LbsA5wKNdb8xPtE+x0f1QPbzC9LCTXKpp9sLvxjflLga7MhOyUUEHAv/0quYd7Pc9xW2C0BjDGrkK3gX0a/aDfLBGqUNvLVK8h6YAkY9YME8GydvBmT80N10EDiWBEHqJxkEC9w/jYunM9RUQ/+PglQMRRXjoeBx1NdfDwXejeo96ynBcvnhgnTSB3wJ1dPr+gqabus/c7vJvdVL61HgdK6/gKoftdjkACj4JKTMutKXAXUJW/F11/TSGUBIR3yurjtPWA4NT+W4JcUPnmBwO7tjA/vXN6nZhkva8X/nTt9vW5QgBuqZGSX3muRpJT4tNsIRQC/vvyDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s22lhQvp+nJgPR7aN0emPTA6egkG2Y4mTS5rf3cOTwY=;
 b=onO4aHDeS5LTZHjcxLRYd333m2J7W8D8jl9Sp/Z+pkAS0G90zWgRQ8jAzw3qAxcHwM8Av5jMcaP1WZu+k/aG585Y3SSoxd4i8epwCwCP7yqgrt5TdLThh64+1VKGy05RQoaXW5eSGIvMIA3F72AE7Q900EWiVXJuj7UNEtv/p4zYmqcp8X56kqV0+ibKGgn/o4ftZnEjMt9ruNv3Xghi074AKJNnd97r1Zdc05vx1ddcFiQJTN+Q9LJmuCQ9/h5hQu1f5Kp3QMIFhTQGarnZS/3nDbkxdkphpl2ZHmRuHMNyavL2dJNXSnRO3XPgM80dS+5XIGRd2tdJWb3S8UQviQ==
Received: from MW4PR03CA0236.namprd03.prod.outlook.com (2603:10b6:303:b9::31)
 by LV3PR12MB9354.namprd12.prod.outlook.com (2603:10b6:408:211::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Mon, 29 Jun
 2026 21:16:19 +0000
Received: from CO1PEPF000066ED.namprd05.prod.outlook.com
 (2603:10b6:303:b9:cafe::85) by MW4PR03CA0236.outlook.office365.com
 (2603:10b6:303:b9::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.19 via Frontend Transport; Mon,
 29 Jun 2026 21:16:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1PEPF000066ED.mail.protection.outlook.com (10.167.249.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Mon, 29 Jun 2026 21:16:19 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 29 Jun
 2026 14:15:59 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 29 Jun
 2026 14:15:58 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 29 Jun 2026 14:15:57 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>, "Kevin
 Tian" <kevin.tian@intel.com>, Lu Baolu <baolu.lu@linux.intel.com>
CC: Robin Murphy <robin.murphy@arm.com>, <joro@8bytes.org>, David Woodhouse
	<dwmw2@infradead.org>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v1 3/5] iommufd/selftest: Convert cache invalidation mocks to the core array loop
Date: Mon, 29 Jun 2026 14:15:38 -0700
Message-ID: <0b590a04fe2d38d696d0e31e37d8afdb1b6725f2.1782767398.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000066ED:EE_|LV3PR12MB9354:EE_
X-MS-Office365-Filtering-Correlation-Id: d12c0fff-b136-48ee-7f1c-08ded623a9fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|376014|1800799024|23010399003|6133799003|18002099003|5023799004|11063799006|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	zUpTp/eeZ0J/30YjZrb7+iSkTlyvY9+l/zGfoAK5/Z0YYtkp9sNWvOQbRuiPcjvTbJouHYaTssuxRC19WGDanhXPg3Tctg3dnz4RhcLClICMtrhEwq+zfbD14RY0AuIlwZDURPj4+AAq/B7exF8TuHbDz/cf2wDgqcY9jq04F3k8mPcd7rxglIAznduFj/kHvpujqvTQv75//t+uPOU+3FQj7XT0rLqUlESdW9mAC9zawkNjBobVcVC8bpuaavsFWX69/dvt4QBPFvplT7rz7YyzAepUMHAHFTLWOFKQyEB2+kPeXCgElUYw/asck+STZb113qJ+8YkR0XGNHPO6n7r9OEkc3YqwHqar9gRjL1RDajxAyFhWzlxeSws1Bye+mJlNpbv1olaI+LoZ3Uo2z0Fychylt0OeuwLZ8mDCBpzSVt+m97twn1sHoHfn3m1jdnGhYs0bM94w1BCcAjSzaWHZxh6nf6X3V8BjmB0uZcR/7aZKkAroQq2Sqk0MYmTF60xKXth9AjdhgOIjEExOVmDJApPho7BdTKwx9VRQa4jl23ZoW0Fx00vUUJZAAh9lNYPR+FMCqFhPpmo7jWmyNZIs+0VNfNX1unoqxlv+5gUianVJvjB6MsBqSCRamNNNhcCk3DoQ/XaPx5EvRuglxYbnCEijR7hcy3PRUSuzmsmxC4+c1GluqQqmIbNk/Cz5DTItfd05bfZUxaaLSdJDog==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(376014)(1800799024)(23010399003)(6133799003)(18002099003)(5023799004)(11063799006)(22082099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	USpMXF22I7oirqxJNTOKbGb9xPpbhATN7w+tfXqsnC798EARbC3ZP3oL3oKYLWqby2zHotFJyhYEG866irhnOiMOERQFQx0EwWKrpy9+kLYgq9X9n97/M8C4owHvBNmfp1emXBwIKf0RG+USE2DHSC5AFwZ/z2/Ne5J8aKnT5F+bv+RKSDXX4O0KVUD8KWOb0fF6dBDSe1lH+TLNj5bYCek4PRfggo55gasyISq6R0J2WfGoiRvw91N6vKZ+V5eRp20TF2mWJJSOC/GdzNBN9RD3ewc5rU+mz0sAePOiTdbkkiDIIx0VGv5kb2WGIXY4rD1O7t5HpakjADt6ky8uNUhp+sQtBy/3k3KFp1B7zmAmG5Tvfri8trBAQ41tGuvU+uk2i6iiIElC9oWHtKDCeWQuDtVNszIa3vXMfd0J3J1KK0WGh2Wmzxj8pIkXz9O4
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 21:16:19.6212
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d12c0fff-b136-48ee-7f1c-08ded623a9fa
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000066ED.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9354

The vIOMMU and the nested-domain selftest invalidation mocks each used to
walk the whole request array on their own, with the vIOMMU mock even
allocating a buffer sized to the entire array in order to do so first.

The iommufd core now iterates the request array itself and re-invokes the
op with the not-yet-handled sub-array, so handle just a single request per
call out of the front of that sub-array and report one handled entry via
the array->entry_num. Drop both of the loops and the kzalloc_objs() in the
viommu callback function, and keep returning a success for an empty array
as a probe of the selftest data type.

Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommufd/selftest.c | 147 +++++++++++++++----------------
 1 file changed, 72 insertions(+), 75 deletions(-)

diff --git a/drivers/iommu/iommufd/selftest.c b/drivers/iommu/iommufd/selftest.c
index af07c642a5260..51da687e432ef 100644
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
+		goto out;
 
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
+		goto out;
 
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

