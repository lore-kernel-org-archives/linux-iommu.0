Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011049.outbound.protection.outlook.com [52.101.62.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F9673A8755
	for <iommu@lists.linux.dev>; Tue, 28 Jul 2026 17:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785260064; cv=fail; b=l6g3YnhR6mjKtXfHcbYgOCl1Nf0qNvCxGNh3zKOUQSC2iydKekfakiz1WdXVnWMT4TsaDwEBhEfKFucn9Y5+VINDbtsnnAyDKLD8Ee0/03Vm4SaT0OOG3BAQk6dzEPDz7HQOoPS3/9cSfCpt0KyLC0kiqrfglFqvU042rJR40o0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785260064; c=relaxed/simple;
	bh=kDqCU4drDD/34cz1Qcz1hI5chixYCXueKsm6yKKc/M4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XvzhVSWkNdbThwBpIPF+NKt0UPOuRjMGNzYRj7P5zwAeyfjjWcWUKDaj2/Y/wx6xK3JIWFgfzpZJaTUaUZCMvIYfP+xGBC9HCAnaQfwhS0gOQb8ww22Z/cdsoEW5wJkOo02CCPACdnkye278z86u+/CCw9P6TDEyL0mDk6j3v3U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ubCEO125; arc=fail smtp.client-ip=52.101.62.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ubCEO125"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JamjPYroF+3rltz9Fqi7Q1UUumeqGi9PlH/9//oAdLcq78iPLVdn8u5vr5VdkZK1M12nQzBlhL/hthNHD69Dm87ftsScfFvLmqacO07AiSE5Ss9yFiStF9DHn4GVy5YL7xTokIpTqGB+S2ib9EUKDH2AaQSMo95CFSQPtoNuEjNJ408NreG1QHmj5IY/zImCD3hdXTIPsQtqehQryPL7iQuuObR30U+1r7LLBDN5oVaAXCxH+SUWkF4uFaYLRWFaNzyKSUU+VXnnyhAupjLuoe4q48NJ1Is+m3udAJo+lAx/ExkR+/+PN+I8Og4yoRJbrSl64KHiD7dQZs+hdlFtug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bssftA5XRFlAN1N8d939rzfrgVyf+942s/j0hVlMLBE=;
 b=Ue0h89EJ0t6Js2UQLFQTL+olS5tvKWlH3VKKRx8FuBbZl7cgr51OEyhkun9ODXRUiHkMkwElz8MvDEm/JdsknaRhfuZUR+O/Kvaqpssr/Y2Rx3D+gL1JYjCekTDNOTeLSc23WND1bqVcXl1pZxa71WpMht3fII+bk42EEZE6HKaU2t03dD4ikVYPuWFesmriXwdSLpAyoYuq34eLbrbMZmPwA+9y48jIZSsEzNurk7B/4VNx9QX2v4nvAq3DY1oSRrB5NRmpQg8RNHrmHf2CDVrG3PFRCBwbQQMtFrxdghg+v8o9PNXB9mx37Sy5kTB8bd4InHrpOx5Wv1jwzlMNMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bssftA5XRFlAN1N8d939rzfrgVyf+942s/j0hVlMLBE=;
 b=ubCEO125gN/n+5UnWxbbLv7Dx7cvEVfKIzyy8Q/cF7Bb6G5Q2ZIaMPoC4ka+Dv6SVVPOsT/ehdbF40yT4PD96KjAEUv/rmyOnETptboftdpUmjTXf8rghcQXptRf3nmHFid6Bp/SsV5u5HL8bkfN80RPfPbpk5Hh+PFm3x0+a9jbNia0LnAEEjtB1UL2Cy5fVpqfhNNd8K/1j3PQWjU9iE4EMmLP6rC/8nuV/srDgZ4vzzan4XN0Bx6DA6nD6UbNG2OG1aKTZhirwT+CCW34bTovMJO9NFHukgRaJhm3B2/y5KyMhPC9/BpPLuQy3NoNHuZij9PW3drW2+Uy/ifsKA==
Received: from DS7PR03CA0090.namprd03.prod.outlook.com (2603:10b6:5:3bb::35)
 by IA0PR12MB8932.namprd12.prod.outlook.com (2603:10b6:208:492::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Tue, 28 Jul
 2026 17:34:18 +0000
Received: from SN1PEPF0002BA4D.namprd03.prod.outlook.com
 (2603:10b6:5:3bb:cafe::12) by DS7PR03CA0090.outlook.office365.com
 (2603:10b6:5:3bb::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.13 via Frontend Transport; Tue,
 28 Jul 2026 17:34:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF0002BA4D.mail.protection.outlook.com (10.167.242.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Tue, 28 Jul 2026 17:34:17 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 28 Jul
 2026 10:33:50 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 28 Jul
 2026 10:33:50 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Tue, 28 Jul 2026 10:33:49 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>
CC: Robin Murphy <robin.murphy@arm.com>, <joro@8bytes.org>, Kevin Tian
	<kevin.tian@intel.com>, David Woodhouse <dwmw2@infradead.org>, Lu Baolu
	<baolu.lu@linux.intel.com>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>, Pranjal Shrivastava
	<praan@google.com>
Subject: [PATCH v5 4/6] iommufd/selftest: Convert cache invalidation mocks to the core array loop
Date: Tue, 28 Jul 2026 10:33:36 -0700
Message-ID: <88ac1ce437afbef24368c9b9926b06b4aa445e91.1785258826.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1785258826.git.nicolinc@nvidia.com>
References: <cover.1785258826.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4D:EE_|IA0PR12MB8932:EE_
X-MS-Office365-Filtering-Correlation-Id: 935352d0-e48f-40e0-32d6-08deecce736d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|82310400026|1800799024|7416014|376014|36860700016|56012099006|5023799004|11063799006|10067099003|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	7362FanPm2tiZG9BE9uQsb7jI6zaivh9iZIklzLuqcAsf3hl1yTlHdIw653gwd43emYWZ2Awtb5NEhxXSg1gQ17PndXww+8KnWCSNuLKf3Fk4riUjfl7SUkcx0EtCP7/WwLX2nhnDg2QZaPqleMiCJ/GDSR2c9MvK8vdHlI/NlbRHYvaCqw/PHyBDDk0kx0L5E0mgeRti0xAcBGJfU/qgMrNVy6MrNIEKy5zyY7pOIAz12tiSt+mJz2d4RNXVMhKlz8SpbY9kNsgR/txJDeCmL0q8djhT7Ufl8D2hmi+gghXBycajht/u3Bzcey6OFIibiBcbttGYvR+c53L9LSGVRKE7WcqIkg6MQj1lpoD3xk3o+aphtXPptuGYOB9HgNcS7Ps3mV4m7BdJHUek+pHVqvkCTzLq9oR0eEBZr/5reBkfd8gR5auTKl34IBd6M28GFElx1OYvk/my9VxSPJWcDK10wdXd/cdwIhoKqHB3OvCmIaoMp7jS+q6Q9/3hhmNpTvluIT8Lnzno3iCWP6GH8cLVDGBpZxIV/yA7GUT3d62dcPAeOt//bypP079Vtp2BH+Djhm3VVv4tm2jgfnKFsYJG/JZw9/a5BsWGF/Vf1AjGaPDacL1UYB4JmTqoZVW611AIFycFu7IlVilEvtrKGfzjgOv8Y3TOMxEz9hnM+avqn2YWJ5xxKDDO05GJOZobkiFbRtVjkL9v4uMkLkVbw==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(82310400026)(1800799024)(7416014)(376014)(36860700016)(56012099006)(5023799004)(11063799006)(10067099003)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ZL1AW68KhUZhjvghG9qoXP7YMzsSnjLgfZVa8Fo5ClrX7i+d3u40rfkmaHhx/tOlK0AcpZxtGWZvBHD76/ZgUVJJU0ortzlEqsS1rZRn0pQbCPJ+kd0B8c03IOyyaa2ot9qCyycyce+U72OwJgWqIHOJifgemrni2eb1fmI8fTSswY7cp1y9uS4xg8jw9/uC0RibdjpXkQzaOmLpNwP744jTAkTgs92W4mGj8MlD13PqJ7KVTLxQ1UHGcxmuGIy46FOEA0FLzWTdt5YaPciNpdPT9zaBELpGUDzn6Mb1trqjWB7SSOqXEMrl+JKpeyNlkFjhsMZVG01CApD8pzZd6JHeAye3d3eC399nkY/VDBJFaTOePmdSKv5XHx6uF+X50V/cg0fs5dBBvGb31fNcMc+rmUqECLf3BMSlwnd6zTwx/e+Z/f8qkX950G0nhXq9
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2026 17:34:17.5725
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 935352d0-e48f-40e0-32d6-08deecce736d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA4D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8932

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

