Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012033.outbound.protection.outlook.com [52.101.43.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9084345CCE
	for <iommu@lists.linux.dev>; Sun, 30 Aug 2026 22:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788128853; cv=fail; b=WT68tqHG8GRS4igAYwnTH4wj8dWAC1ds2dBSUF60J0DbREv1ID0n304W66ddjkckdOzCc3ggyD2YCUnkHlZuyaUO+Oz5bjDu59xVsTUQLm6lkKZjKDivU4U8r9KG3CsBBSNdKVCiGgDfYq+Lm7rYvS+Q53eGxikEOCkK7iBBaUE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788128853; c=relaxed/simple;
	bh=DQVIsqGHWEwW4go/ECfIZoCeK1JCWDGvbn5f8hJ42XA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LPvsxYGDeA8OuO9tHjaTY7aqCW8kQnyx7M4eJds8jMAomn/EFFFArq57tUA4NPKMgu7J0IuyrNmyG7caQmI++wa0G1nVdO3rzppSW+6wwZ7rPBNHVM4kgKBqX0xv1qqGRHuHbAa4z8+xcCctaPBKL1sN0WqwLWIU0f2iHDs4g64=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=thsLik97; arc=fail smtp.client-ip=52.101.43.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="thsLik97"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MrQDFWxRZFEAaiy4C50fldN6i8MLW55qSsagA2nLQXgFnK/N017wcXOiKCwAdiUBH83R+xFJgz6FbajsslYFtujVGjfPgQ/RGIt5T0949g2O4FC4nAMFJIYDOnSl0rJzBCilSGX6QwrFsT4QUVEsOD2jhG82yS+tMhIL/bMuynYkplk7/G4MTwDU2/T9BDHGgvEY175FLt0p1H5gXGgyDtXSxAqrUJgfv5kvSk+9nRNB8qxx+wLaEiDhI0LSipRG9z9TDFOAsfU696q6bPGYNDkQ5XxJT+jPjs99gB4ztZ7oBQsRatPjz4bA+5x+fHvcowoW5P3NVUPzQes0pcVm2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BxDdrALZG/MtNfMngnHKBE3/XPPS9KoD8FdD/RzYGhw=;
 b=oAgxHDWJnHb5b4sPejQTPUo/flrpdhkvOGHgHjfz9cjM2gXQtI/S8GeVaGWoEUncK594Gf9nhqkDvc65rplaTX6f5jjyXlL+FVuLLQwddJWTLSsywXbrB7dWtW/syOVgMp/FxSITpKXZe6LlWCGj9CS0aYt2jIfF8j/v2IJD11QDjhffnpiS4lZ5fjrdRUSkSA2gCiv+CJ5LM9rPqgLuDDogM6+H0ed12EeDlGv80dcD/x47TiyGg7LvyS7aRDu02x2tKYUu2XoRBqadEoZuNFxm9ZRxcxWXeDiDIKWdsTL54RhSIATfv1UV6ql5rrb+clciDmRIYVvxQcDKzZ++yQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BxDdrALZG/MtNfMngnHKBE3/XPPS9KoD8FdD/RzYGhw=;
 b=thsLik97p+L4fx116cSDDo12cAZx4ckJoFMPzaEoKv2I8Gznjdajbz4We+NYO9oa/JB9001emGY4T1AcE4kWRgcl9dJ01BK19MaELIyDzUfOrsHpfT2Unc4kx7L/sgPMewY4MBuPsfdzr6X5igKAcsr4DetW332BI7DbeREluEwV3TJg1193G6KpmkEWr7kyvPDE4H9IqrnpQhiL2omHOb4bfjNwThxls0yCf1x2MVjkVvxFfUy9AiW1GZJPa8zl/aZYp+nO3htndfHmbO22B5y8OVmC8+sY0Ll5J8z0K6U1SNK0mVlj3+kpvmQoGq2bvi5OZTGr1fcQYsFmRo1rtg==
Received: from CH0PR03CA0300.namprd03.prod.outlook.com (2603:10b6:610:e6::35)
 by MN0PR12MB6293.namprd12.prod.outlook.com (2603:10b6:208:3c2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Sun, 30 Aug
 2026 22:27:24 +0000
Received: from CH3PEPF00000009.namprd04.prod.outlook.com
 (2603:10b6:610:e6:cafe::22) by CH0PR03CA0300.outlook.office365.com
 (2603:10b6:610:e6::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.13 via Frontend Transport; Sun,
 30 Aug 2026 22:27:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CH3PEPF00000009.mail.protection.outlook.com (10.167.244.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Sun, 30 Aug 2026 22:27:24 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Sun, 30 Aug
 2026 15:27:16 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Sun, 30 Aug 2026 15:27:16 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Sun, 30 Aug 2026 15:27:15 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>
CC: Robin Murphy <robin.murphy@arm.com>, <joro@8bytes.org>, Kevin Tian
	<kevin.tian@intel.com>, David Woodhouse <dwmw2@infradead.org>, Lu Baolu
	<baolu.lu@linux.intel.com>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>, Pranjal Shrivastava
	<praan@google.com>
Subject: [PATCH v6 2/5] iommufd: Iterate the cache invalidation array in the core
Date: Sun, 30 Aug 2026 15:26:39 -0700
Message-ID: <e1896d79382392f8a0bf0ae736aa295f11c45ef0.1788127877.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF00000009:EE_|MN0PR12MB6293:EE_
X-MS-Office365-Filtering-Correlation-Id: bd86068d-e97d-4d5f-fb5f-08df06e5ddbb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|36860700016|23010399003|82310400026|3023799007|10067099003|56012099006|11063799006|5023799004|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	/COUHvkM300TP4Gvda2YFEzV/QSoJCby8TBSJDc43zgAL+kIoazOB1dYiEX79oxFosk+fYRu0R1/NKc5e7AXkXbdLhL1hVDmvqOS5zN5k7J7gY5ed32rLpZ8T1TkDzMxCkjnZPAaNvlZeiTqyzFqAtxl7o+T9TNyH3V6axOQ3aBowC3x3tun+89BhAvj7q1ooRceEs5u06HFWWRpaxmbh2vs2ANP1bGa94O6MVqvYWOIvITRkRHF6zn8uUdEwQi8Xtw7ZNviF+6eZV+F06ODpH0XfNFhGqqU8E9JFwmPWykFz7LvnT/PDhZVJ0BsbJDmnMMsVI/MpzG5OdfG6WjUK7JQSAL1AwUuPdLoDucobTlQLZ2AfmOr2YzWBV3a8vG4G96IOCi4MS/cDGQyMFNsUIuXMV+d/LM45me4T5jOp/tA0G+S8hCyegPckD3QAjz6bZmgRUjI0e185VUFaYvoJhIpMBMB5rp0Wttjo5LRvnNBb0lsbO5UA0SvxT2Em6Z63cn7k0W9TqTQkVhGt4+B4lAJozi9K2n2ATuSTxpinqXEmNwudTo4+7U9s7F/CWNNj1LKY+IYPQIOXTSDXofKmTSVN0HONim+n7ZBZ/iHXlos6Kba9BoTNNfcfV+cFz5Id1T1jhvKs6oDCnagFxoKSAMdhk4WLo56RTea5WgFAuv21PncgtqoXHcX1Zg9RfJzh4YHJQ45eMWO3A8C8oVroA==
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(36860700016)(23010399003)(82310400026)(3023799007)(10067099003)(56012099006)(11063799006)(5023799004)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	xiN/wjDgIDxF/OsPJZuhqGFtaUVnf+GgrRmvDRlyPyYYvayDOQSWD5Mq158bQTQF05Q48FGAz2SMrKByL87YRGWQTn2mqaPDapu+tXWYKca4rMjAbeLmu4GiBLrU1/E+g3XuwbN3ghv5KhNFQQkF8p906GERiBvSe3tXjvH6PPndhq+6NsnPveoO0t5E6Z3hkp5HB+6n0eM4iJBsE3axWBUgN6kY6a1fz07qId/yxQ3lDVXpvf+C3KUH4zRqbAFxS6z8J30Njrl9W35x1qI5n0UprI1lSe2huAYa2mNHkBKk29dbbIltnkwXI0rJ7frFSwOsN960mG+aupGZMs2sQ7GZFvi1/QIOk7vMLCCACpu36XDccbLbkviSpmoMw3ZSmgH1frmkvXpwkZn04t1bgJ6kk+tuRcwgUxSruAXWjneDRmKgZHAWCwjhlMf+y8Q8
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2026 22:27:24.5826
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bd86068d-e97d-4d5f-fb5f-08df06e5ddbb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000009.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6293

The cache invalidation ops, cache_invalidate_user() for a nested HWPT and
the cache_invalidate() for a vIOMMU, are each handed the full user request
array and report how many of the array entries they handled by setting the
array->entry_num. Every driver therefore implements its own loop over the
array, and a driver wanting to process that array in fixed-size chunks
(e.g. to issue commands out of a fixed-size on-stack buffer) has to carry
the loop and its sub-array bookkeeping all on its own.

Move the iteration into the iommufd core instead. Invoke the op with a
sub-array that starts at the first not-yet-handled entry, let it handle a
prefix of that sub-array and report the count via array->entry_num, then
advance the base pointer and re-invoke the op until the entire array has
been consumed or until the op returns an error along the way.

A driver that handles the entire window in one single call, as all of the
current drivers happen to do, finishes the loop in just one pass, so this
does not change any of the existing behavior. It instead lets each of the
drivers convert to bounded chunk processing on its own, done by each of the
subsequent changes.

Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Pranjal Shrivastava <praan@google.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 include/linux/iommu.h                |  6 ++++--
 include/linux/iommufd.h              |  2 ++
 drivers/iommu/iommufd/hw_pagetable.c | 25 +++++++++++++++----------
 3 files changed, 21 insertions(+), 12 deletions(-)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index ac43b8b93f14a..05f7cee1375ee 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -773,8 +773,10 @@ struct iommu_ops {
  *                         passes in the cache invalidation requests, in form
  *                         of a driver data structure. The driver must update
  *                         array->entry_num to report the number of handled
- *                         invalidation requests. The driver data structure
- *                         must be defined in include/uapi/linux/iommufd.h
+ *                         invalidation requests. A driver may handle fewer than
+ *                         the requested, in which case the core re-invokes the
+ *                         op for the remainder. The driver data structure must
+ *                         be defined in include/uapi/linux/iommufd.h
  * @iova_to_phys: translate iova to physical address
  * @enforce_cache_coherency: Prevent any kind of DMA from bypassing IOMMU_CACHE,
  *                           including no-snoop TLPs on PCIe or other platform
diff --git a/include/linux/iommufd.h b/include/linux/iommufd.h
index 6e7efe83bc5d8..3087f5b2def84 100644
--- a/include/linux/iommufd.h
+++ b/include/linux/iommufd.h
@@ -154,6 +154,8 @@ struct iommufd_hw_queue {
  *                    The @array passes in the cache invalidation requests, in
  *                    form of a driver data structure. A driver must update the
  *                    array->entry_num to report the number of handled requests.
+ *                    A driver may handle fewer than the requested entry_num, in
+ *                    which case the core re-invokes the op for the remainder.
  *                    The data structure of the array entry must be defined in
  *                    include/uapi/linux/iommufd.h
  * @vdevice_size: Size of the driver-defined vDEVICE structure per this vIOMMU
diff --git a/drivers/iommu/iommufd/hw_pagetable.c b/drivers/iommu/iommufd/hw_pagetable.c
index ef6e119c2a752..ae62db50885c9 100644
--- a/drivers/iommu/iommufd/hw_pagetable.c
+++ b/drivers/iommu/iommufd/hw_pagetable.c
@@ -514,6 +514,8 @@ int iommufd_hwpt_invalidate(struct iommufd_ucmd *ucmd)
 		.entry_len = cmd->entry_len,
 		.entry_num = cmd->entry_num,
 	};
+	struct iommufd_hw_pagetable *hwpt = NULL;
+	struct iommufd_viommu *viommu = NULL;
 	struct iommufd_object *pt_obj;
 	u32 done_num = 0;
 	int rc;
@@ -540,31 +542,34 @@ int iommufd_hwpt_invalidate(struct iommufd_ucmd *ucmd)
 		goto out;
 	}
 	if (pt_obj->type == IOMMUFD_OBJ_HWPT_NESTED) {
-		struct iommufd_hw_pagetable *hwpt =
-			container_of(pt_obj, struct iommufd_hw_pagetable, obj);
-
+		hwpt = container_of(pt_obj, struct iommufd_hw_pagetable, obj);
 		if (!hwpt->domain->ops ||
 		    !hwpt->domain->ops->cache_invalidate_user) {
 			rc = -EOPNOTSUPP;
 			goto out_put_pt;
 		}
-		rc = hwpt->domain->ops->cache_invalidate_user(hwpt->domain,
-							      &data_array);
 	} else if (pt_obj->type == IOMMUFD_OBJ_VIOMMU) {
-		struct iommufd_viommu *viommu =
-			container_of(pt_obj, struct iommufd_viommu, obj);
-
+		viommu = container_of(pt_obj, struct iommufd_viommu, obj);
 		if (!viommu->ops || !viommu->ops->cache_invalidate) {
 			rc = -EOPNOTSUPP;
 			goto out_put_pt;
 		}
-		rc = viommu->ops->cache_invalidate(viommu, &data_array);
 	} else {
 		rc = -EINVAL;
 		goto out_put_pt;
 	}
 
-	done_num = data_array.entry_num;
+	do {
+		if (viommu)
+			rc = viommu->ops->cache_invalidate(viommu, &data_array);
+		else
+			rc = hwpt->domain->ops->cache_invalidate_user(
+				hwpt->domain, &data_array);
+
+		done_num += data_array.entry_num;
+		data_array.uptr += data_array.entry_num * data_array.entry_len;
+		data_array.entry_num = cmd->entry_num - done_num;
+	} while (!rc && done_num != cmd->entry_num);
 
 out_put_pt:
 	iommufd_put_object(ucmd->ictx, pt_obj);
-- 
2.43.0

