Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011001.outbound.protection.outlook.com [52.101.52.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0396438331C
	for <iommu@lists.linux.dev>; Mon,  6 Jul 2026 18:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783363674; cv=fail; b=UUQ8fDP8A/GKvJJHXUf3ZOcHRIWdZlt+1Rntd8G5K8Q7g7b4tEVxe1XFkyI0NGgPCkOEhl2+NubqMkhd+u4nkahx9uNFzjkpL7v9Y02uyeGvL2zx/FtNygQoPhbwg9Ak9e8FP5LzlcIiDzKctr4UCETvQx0rUg0xWraDi1xLoPc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783363674; c=relaxed/simple;
	bh=ZEqiHXdMPxSMGJ/QLrN0bsAPuxKkleAIOpNAvJcvRX4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sgZ9+CzlrBoVW+KvxJk3ULKIGRHQcQnEN3gwhPZv5VP9V5cRMHuQMHVE+XL3xYwRT6qiQm6VTXHb3H9H7L8rRaRyw4k2QfJRLEEWaMLJTZLLwEDt/LoqfUlX4tcTHs/v7mgmyGdC3EwzbhVRS7qZb0XDZ/MMPmmE/jnFgS3mIi8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pqIc+OB3; arc=fail smtp.client-ip=52.101.52.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pqIc+OB3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jsh+O3osU18meIQYgWrEltbFWczagqA6jyZjmSFo4GQdULfqrS+iEu2JxToTPBdu6TwCbBMVbO+0623h3j+ILqLrOfXtg2gcndT6FOuag9GFmkFas6S0K7H6NLV4u06VBDB/Pu6zUEcptLhD8Fv5tll/+VDomF6frBXODXU3NpJXAPH0jgiqqMLUjOQ2RqC3Adwjphaje46UdiP79zp53WxVPweW9XHYIWYJO6ntE/T9nXZlm1o/cp3gnmtxzqrgZYSksQI/nMyzWypHLCZYU+V9lIz38OVFAUcpjT9bLHjpIaKREZrItHu+sWfnx5mnUlmJ3U1/SI6HKgAuQ/EoZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xLKpclR6TzU06Q17+5WVq9H2iJLIm9bYLUOwqelsQHs=;
 b=WGAq0IC43RQtybYp6uJxjAum8ZI/2oEpS7MoeArpJvXZg5PusqMy1oIEvJFGpZriZmNxVeaZC1oiUv13lQO7JdSA+E/PLITMswcw1ALlqbrZ8e/OZ1P6qqq+ojttFt2bOUeawThCYPHGDQlplN6mV6k9XfcTmbW3l5NOvLE+SABGtdzIrV1PJ1UWbnktg4theNaTyAMIZxS25WZ3Hy2FUjQ4SzgysqGNLd8XlsXWHJhzmjCgrA43h25Pdeq8zttv8ZfWB3kaBuru0vr2HH/MgmSHyKb2K+A/9OkOKEWpEHruD1OVnXHNYqFebpzqqH+Fy43dPaZQfLa65+HvDqvkbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xLKpclR6TzU06Q17+5WVq9H2iJLIm9bYLUOwqelsQHs=;
 b=pqIc+OB3oZ8liRNs5ShqBoogHfInc4of95GRwTS4kP8GU9uVfkPPT1UW2o6B1CV3G0apgj+R3nL1ZCmYZbVZj80XAy7zGWEAAyLJqN0Ih0FQZHsUXqI8Aks7k0S9+SFovHKdBBLhUwJQxB1DsRtgh0bCsEDqwDBeah4jbWE94CgiH1BlUyk5gtrZBedivqXesV1QO60uKAnpvPaTTL6EkftKZyxkHwAdl+7qK6uKJIrFF2avYIqf5k8ZLylgHS0MXTljOrZrU7v1voZcf9GENuFOE3B7qgq5UUTMY7oY/IfaKmlqKOQQZapoe2QVX4V45EBbRb+KUZPPkHuh33Fyyw==
Received: from DS1P220CA0009.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:455::15) by
 SN7PR12MB7853.namprd12.prod.outlook.com (2603:10b6:806:348::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Mon, 6 Jul
 2026 18:47:26 +0000
Received: from DS1PEPF00017095.namprd03.prod.outlook.com
 (2603:10b6:8:455:cafe::92) by DS1P220CA0009.outlook.office365.com
 (2603:10b6:8:455::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.13 via Frontend Transport; Mon, 6
 Jul 2026 18:47:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 DS1PEPF00017095.mail.protection.outlook.com (10.167.17.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Mon, 6 Jul 2026 18:47:26 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Mon, 6 Jul
 2026 11:47:11 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 6 Jul 2026 11:47:11 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 6 Jul 2026 11:47:10 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>, "Kevin
 Tian" <kevin.tian@intel.com>, Lu Baolu <baolu.lu@linux.intel.com>
CC: Robin Murphy <robin.murphy@arm.com>, <joro@8bytes.org>, David Woodhouse
	<dwmw2@infradead.org>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 2/5] iommufd: Iterate the cache invalidation array in the core
Date: Mon, 6 Jul 2026 11:46:52 -0700
Message-ID: <56c0672b01fed759f65bea21b749909d087549f8.1783363477.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF00017095:EE_|SN7PR12MB7853:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e14bcf4-66a0-4391-d425-08dedb8f0612
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|1800799024|23010399003|376014|22082099003|18002099003|3023799007|5023799004|11063799006|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info:
	Y4SjWaTo3v8GSFynVzmNaEzgFx7OVoBnQR3gcm0V6RaB5cyU9cLCyZ3GLPrqLDB6zm5XTPqG8lu8XP44Wzy5leGq9CCk2HSpNBZKeqIsanlp72Uhi/LoNPBMEYNXj0LsyJQG8cfBrMzBHoCuBGe4LP+o1xanLUOznv1wZRSgPqt/b4wF8m0LvVr1XVbA7b/1yTq4Zdky/nuXia+I6YfD4SX8l3D5RsH+z9vAeRN2MuRKKXJyFSmicoOj/kAwCRpu2jUMm3yBn/6rSNAsR3RbhN5oJ42CUzgDPekrDAObqqpegsLLHBmITMveylRo3MvLrUDoZmbERyUa8laBuJUEzgVBYEYhobttjPW9v9xLm6twSFyC7i4Dd0ov1qNIwnzrJgzNXfDkexoPx1fCqGPTQ3HcKXuYSdQV4HEmmglbE5FMyrlHDOtXlo8w/qnJsnlonGRwcv5i52aVov56Pu8H5TcrR666D6CWFUoQ/lgCjd2a5KHelLB/+nsWk97f89eH6HaGAwn6f6mbCFuW2DeaqVXsHuFCtfupuygtDp4GzQGqpLUBGjEnoY5k30QBfSPY4h8Xrl7xeyRWi0UiSTAzv7u3R4e85MxTIz/GFZteHY0hP7svFegEmR8gmNnF2UWEXGaMFyu9fxeVJofjtW0rMbyolPD6P9Y1QJ2eXyxHjYWjnJo7a0zCHWRWiUKFdqHxyS48kx6QrmD40MIOlrrEdA==
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(1800799024)(23010399003)(376014)(22082099003)(18002099003)(3023799007)(5023799004)(11063799006)(56012099006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	2aVMQWwjp7y6JM3sjzzVq+1DEgGDVOb2FIrs7IxqdhtVTED5rmx7QSSBB47Iz8a1695R62rxLzfpa8b7Jbah7qSSWyaMQKYMnZZLnTZjJtk8IBjNz1hmeEJk7cVs5taTN7u6pHSrK0BtE8Jv9RJ1P5IPDq6EcCDAmnWjq9jxM8IvZKDgONeeIeG+/DXRxlxzumF0XDQ/gvU947silot39yfarB8uHvZfyQOoWrX4vjMUuCZqy2yLLkTFPO9T5ltkUulkZ4+/IQW6ktnGzs7t8HyoA8qaXvqUCdvvBTvpm0l8df1BvdXhzbl9EGbL2sw45WPjMlBwvV567kSPYHKdrYsitiCoFtj7gdCnwlNEz4bn/FfzC0ZnrITbkpvp8FRvHSQ+AB+UrGGyBVD0/JSe2to7BB4wfOrtIlhnAJ8vt/gr5pcojfmkU78nPsAoEmru
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2026 18:47:26.0511
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e14bcf4-66a0-4391-d425-08dedb8f0612
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017095.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7853

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
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 include/linux/iommu.h                |  6 ++++--
 include/linux/iommufd.h              |  2 ++
 drivers/iommu/iommufd/hw_pagetable.c | 25 +++++++++++++++----------
 3 files changed, 21 insertions(+), 12 deletions(-)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index d20aa6f6863ab..969758f87e445 100644
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
index 623cc608ca0cd..644daf18849f4 100644
--- a/drivers/iommu/iommufd/hw_pagetable.c
+++ b/drivers/iommu/iommufd/hw_pagetable.c
@@ -501,6 +501,8 @@ int iommufd_hwpt_invalidate(struct iommufd_ucmd *ucmd)
 		.entry_len = cmd->entry_len,
 		.entry_num = cmd->entry_num,
 	};
+	struct iommufd_hw_pagetable *hwpt = NULL;
+	struct iommufd_viommu *viommu = NULL;
 	struct iommufd_object *pt_obj;
 	u32 done_num = 0;
 	int rc;
@@ -527,31 +529,34 @@ int iommufd_hwpt_invalidate(struct iommufd_ucmd *ucmd)
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

