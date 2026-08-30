Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012063.outbound.protection.outlook.com [40.93.195.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC5AD3264EA
	for <iommu@lists.linux.dev>; Sun, 30 Aug 2026 22:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788128849; cv=fail; b=lp5vmN9j5ErEm6FhT53TWiNkqeBG+3wKVuwJSg5zhjWOT6Lz4E8PAiqcLVlVbexleQwPc1WyuxcgPoqW7PebPF8JLq9BIx4lvlmQChElDr2lrz+jrmpecTyLndXgj+esLS5+5HgxU9+Q+F5RNWqXn5Jw83c0v5XD/Mhr7uE3Pc8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788128849; c=relaxed/simple;
	bh=hMCdqdrknS4jT7Qh5gF4xL6r69W5HnIvG3plqdqFPh8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CFaOytKE2+VRJlOhx2EZDehN5S3/sMxs0KSa4rUDAWm27YGVq84zLRxcxLmtQNtPzy1l1JVZMwDj54+NSXS0BiZKntkrnNdkzd9GyMUaDLQM4iLv28/chs0+WpsnFvCUPRcRcUi707vAcm0yGQKJ7M0PzMUkIut30lG7cCbtONo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mQ+7AQWI; arc=fail smtp.client-ip=40.93.195.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mQ+7AQWI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DCABCkg98urGOlOc1ypxPQNUpaR0tm6xf8rZ5soUsZ9yFkxJcT7PatWO6qTKJY8HkRkwy9yiZpG3whYYR2sOM+RAresI0YB5Ggv69tnLbixRJezegv6qqEtI0Tc6zhch+MtbONsGc0mu3nnUw3EPptgcW0ZvN6TuBJ4n8K0jCoZMYgWflflnlz2SWRmVTaApfQjOHCOdE4h0BOU/uVxCvD8kJ0tn11yFZUpFauyayT47drtHvwYYYsfVLgLV9eSiNjdXvrmWozZDY9w76Nc6Zha0edTZc7yy9gVlfS4W3NMx6TyVOfSJ2mUqeydxl2jNnm8JGrJYNGI0clKArSDpMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MqWfrEFINGLUpvLOmW9PWKiLM88azkXCP60m6Gm9nj8=;
 b=e9in045BJxusJmCaheRwjEskM1lJaHCYC44SrKRU+/GRFeA5GyHfp09Nhp5k2a4SMDDjhfZEuqkuslHS2d34vBqyQ/+TCzHeu0q3j8lhMU4bz3iig/NjUP2OqHkgh3AajvL/P9IcmyisbPtvdRF0xjaHitRpz9ha+Sjk0w+GKInuaKbypuP1ttqDQlHUHMbJ0PQi54R4qZxxUGVCXqlCTIpKisIFvkntUHnr3jNNyo+DZB4Thb909KWLM/457qQa3vdvo9UF9UdF1ZJxZt+o94mtSnnrwrGWfNsA/DBuQfKEbSMnG337gFxnADy9BU0DsjQhPKkgq6syozmtVyX6Rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MqWfrEFINGLUpvLOmW9PWKiLM88azkXCP60m6Gm9nj8=;
 b=mQ+7AQWI8vkxki4xskpn1gy/oWUSIkmfzBXTDRZM4Tk/ZzZpmefJCRa7DkA+zuwD/ZfGzClD8WQ2NoCb4hCMWv9zk2VPTGY4V7kumhmvT8nRCybQDVCBqF5pkpbwioAQskxi/nPqKUgphu2/dJFQsK891RG2k0TkduQdVyh582ECzBQXKCydL9P+V1KQhNu7IjwgQwEESA1AEqhK0WgrYFy7H5i5keQPMxhktjD3SMmZ6QXnz8nGWpGrCiSyFVdtSAr8aKyHJVUv5Mi1r29xX/OTGzYNaBHy/x/U79fY+zCY5QVow9RAoQJNvi5nvzdQ0Q7B+2rW5BeGNYPVicDxCg==
Received: from CH3P221CA0002.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:1e7::25)
 by DS0PR12MB8218.namprd12.prod.outlook.com (2603:10b6:8:f2::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Sun, 30 Aug
 2026 22:27:22 +0000
Received: from BN5PEPF00046987.namprd02.prod.outlook.com
 (2603:10b6:610:1e7:cafe::57) by CH3P221CA0002.outlook.office365.com
 (2603:10b6:610:1e7::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.13 via Frontend Transport; Sun,
 30 Aug 2026 22:27:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN5PEPF00046987.mail.protection.outlook.com (10.167.245.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Sun, 30 Aug 2026 22:27:22 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Sun, 30 Aug
 2026 15:27:17 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Sun, 30 Aug 2026 15:27:17 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Sun, 30 Aug 2026 15:27:16 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>
CC: Robin Murphy <robin.murphy@arm.com>, <joro@8bytes.org>, Kevin Tian
	<kevin.tian@intel.com>, David Woodhouse <dwmw2@infradead.org>, Lu Baolu
	<baolu.lu@linux.intel.com>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>, Pranjal Shrivastava
	<praan@google.com>
Subject: [PATCH v6 3/5] iommufd/selftest: Convert cache invalidation mocks to the core array loop
Date: Sun, 30 Aug 2026 15:26:40 -0700
Message-ID: <535f3b97e16c437f1df0c988a96229f623142ee9.1788127877.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1788127877.git.nicolinc@nvidia.com>
References: <cover.1788127877.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN5PEPF00046987:EE_|DS0PR12MB8218:EE_
X-MS-Office365-Filtering-Correlation-Id: 6307c27c-2acf-4718-297e-08df06e5dc41
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|82310400026|23010399003|7416014|376014|10067099003|6133799003|5023799004|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	pN2JypvqwxW6A7s4hQRcqkVLbNWat1idZZADZHTkSTWT95K4seLVrgUJg0O6CW+3iSNuXHdFLZuC6zuAWn0alajTcUfvRdPpUGbPlg+s/QV8RW9M/XJ2xr8EPrVITc2akwFWxcCC7vV1m/IqXqf0Ju2Rxyg5EsiTAshAXDk3DXJFtO7Th8BrKqpVCbrDqX1jhEBDeVW8WNztlIZ6eN4ErhoZiocU94PryzP6wyrscvdbeR2iopV8UyIjGB+cvfzNhkGAKuL8xuCyrCqF9af//E0uQpSAFOvABASPnapBD94gIPX668t/J5Fm2Q97AwYIdFXeWJmdcOzaFZQx8zwmv9n39EGvdMIMtMCXn+o0uX0T7evf0i9LKC+decJFLUeHBKi3sFlq85SO+bXjxS2PdNi2qPFgRYKyM+Q3LUgUapBEU0IkwBK2+ugryaI7SiAnoqGF16MXsAo1SYef/eM8mdcFPs6gH34ESGMuQ076nKKaThuJtKnAS4T5STDJUyW7C8wXBiwiBuZw1sjYU6s2HE8LpGFGRNY0XjqSeMhvHMktFzaYwxd0tBtP8TXS8IszLXiZ0eaPuETtXJH/mMYZFJW6+7e6m9JaUW1GkC9t+vb+WbuwieyUIKyar7EfmSBOQ/RYG5HcAEEokibFfX+8kwX+BvKCQKoJ5OcJbQK3mAFJTVj6xojVLho+9e2JFqf6wXbKl76XOS/zkIhxeJdJkg==
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(82310400026)(23010399003)(7416014)(376014)(10067099003)(6133799003)(5023799004)(11063799006)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	wvg2w1pQ9Zh4Q5LKim0edjfMmxdVgP+6p1uV3lQwUuVEpZ8yuf/1YeUv6uqNTRDOZOmiYP//B5iV6htVX0uwNxzBJdGXgx9H0TVugbMWTiwkT7/gNvdnMNx7+YE32o9zv55SX5vc/AvP2ZUDgLdP+dh9oiYOd3geuEDLsbnFdJDPfaC/+IDY5/QSmDbZM1QPLlXzZ1UpFKoO9KCB4OxFj9bfNoRrFI7dDt1+jBOtb6ER8T9kFiqPXKmvD8fCb/OOVFhIuank8cDdS05mAsvbx65MJLw6staGqfHlAeK8nT4YUazyUyPjB7ZWowJGMQv/TGaD/ya4QSXTFjvNhx5yXng92dHA/7LJkN+FW4yPHuO9fLE78vu9Ob4QLt3jnR0WlO/a3EAcLeVYIx8dnyC2OB+T5Mx1gOCftDNqpuZvRr/lWVit5vh1qjald2FTL3ya
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2026 22:27:22.0487
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6307c27c-2acf-4718-297e-08df06e5dc41
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN5PEPF00046987.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8218

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
Reviewed-by: Pranjal Shrivastava <praan@google.com>
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommufd/selftest.c | 147 +++++++++++++++----------------
 1 file changed, 72 insertions(+), 75 deletions(-)

diff --git a/drivers/iommu/iommufd/selftest.c b/drivers/iommu/iommufd/selftest.c
index ee706f18f7e91..1c6d685c4dec7 100644
--- a/drivers/iommu/iommufd/selftest.c
+++ b/drivers/iommu/iommufd/selftest.c
@@ -633,70 +633,63 @@ mock_viommu_alloc_domain_nested(struct iommufd_viommu *viommu, u32 flags,
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
 
@@ -877,42 +870,46 @@ mock_domain_cache_invalidate_user(struct iommu_domain *domain,
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

