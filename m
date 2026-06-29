Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012006.outbound.protection.outlook.com [40.107.200.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0427B3C4B68
	for <iommu@lists.linux.dev>; Mon, 29 Jun 2026 21:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782767828; cv=fail; b=pHudburuLclJBf9nFTPQaWwzntl5jzw7EOPdUbx5zLW2paK0vmYI9J4Un0LUJ/Vpi04LGdW4ufPClJLJScEUaLdfvcmdutJBWZk5lxwAj5diYDkfQN5szM0BsSzrFnVcVdFIPcBFIDi++ij5U+Cwiig1e7li2sluVjDtIBFrT08=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782767828; c=relaxed/simple;
	bh=d/Z5PcgWvptmE+pkigVhOvTGhGHv3GCYXYL0C+ZsXHI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eWk11TIfRPgKEH7JXGOpM037EsKjClNytSBgM6XhAfZYDOng8P/tBoiQiHYD1aXYi7hb4wtHmAQRUBDlLK0bp5rPY7j3GvxriVuyHAt+Aqbwh1BgaCBvOHpZCqd/YtCA8i5B9++7ILFMdxTBIxqq0s7ydMViNW+gBYmzmNDEb+Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SU73EXKm; arc=fail smtp.client-ip=40.107.200.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SU73EXKm"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uRDyLqSA3WGOMGfJaMIRs7a4gMYsaO9BhJ+nzmjgZgOwWKRjUaBx6eHHtEUgDqFsGsVi7VpmHGgp29gJdhwp7J6S9SbJfTO//nAGdXPU85mdZJ50VXVvdaZf6zTCxKJKEZC27b1WTQiNfqgBVmMd/tbTjEYER6dh7twl4AkWFVQI88tw0petDfdf3Czs6iZpCJkySCwDJMuB7M973LzbgTAJP2LiWz8Z2VEmG0wWTFZJdMo/oCbRIH2f8DvJ317srdlrBWDtI0DHjEd0Z9opPIHmA+HDU1hLRTzwE/bwGAASoFHIt/MzgptaJrUz8jfjeta8l+QcgbDICL94CR595g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TY72gHKGpWe4/BgW9EJfd/svD00w7ljow2Ajft9BbZ8=;
 b=oEqOqoNTMDGyE7txq514uf48EIYnsYq1Sg41tG1arz4IvHgO2oio6Xue45VSWvzkMiM6CqDR1Kt+cht2Wp4XVHxsrigN3uurrYB/524F0uPahjBtcIRw5qSOl4PkOIj/LwpYexHK1IlhjDb8uuMBVLCnApgNKYV1mPTA8PV3AhQrNy4IQ60nTYVu8tA4mOprw15Q/3og+1RtUrreOYC/wpRTTa2HFK/Iytg7UX0hB/5bQKWnkytvktQBgD0nQvsdzabJ50Kr+WXiBT4FVcQ0+zvvkOa6Y4QVQ1CVJ90G6fYFTHkUWXhUeKjmcOry6rvwd1Ep5yNYJpF+ZDgHLuJ8TQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TY72gHKGpWe4/BgW9EJfd/svD00w7ljow2Ajft9BbZ8=;
 b=SU73EXKm5maiZmOXr+6h5g7jJ352zE1DmX7REwrjJTglnl5zEiTICZ0A+/iG2kVGm1J+0l7/g9MT9UyaDdUXEEL1Rx3sFf3gnLsmh8alixmU2eUQyVqJliQY17JPR6D2Oo+qdkLna0zYv40+N1nGrCbVLd3/XvuZhUOksFzgUECh504KtNC5RL6q9IdES1+X/8GkVgrD32JwjYrIInEtCeRDmoJUcK6iEBv5CIeJPQt95vUuYFfJ6FahBQIjI1QSqqprn43N1VhZs9wF9UO7MYlf9Sx4tmRB3SWXMUVEqH42sUbb+FCZi0bcX0XnwzUV1Vy/gssX7oRMY532+1NoGQ==
Received: from MN2PR14CA0010.namprd14.prod.outlook.com (2603:10b6:208:23e::15)
 by MW3PR12MB4378.namprd12.prod.outlook.com (2603:10b6:303:52::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Mon, 29 Jun
 2026 21:16:59 +0000
Received: from BL6PEPF0001AB57.namprd02.prod.outlook.com
 (2603:10b6:208:23e:cafe::3d) by MN2PR14CA0010.outlook.office365.com
 (2603:10b6:208:23e::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.19 via Frontend Transport; Mon,
 29 Jun 2026 21:16:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL6PEPF0001AB57.mail.protection.outlook.com (10.167.241.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Mon, 29 Jun 2026 21:16:59 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 29 Jun
 2026 14:16:41 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 29 Jun
 2026 14:16:40 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 29 Jun 2026 14:16:40 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>, Kevin Tian <kevin.tian@intel.com>
CC: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	<joro@8bytes.org>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v1 3/3] iommu/arm-smmu-v3-iommufd: Require exactly one Stream ID for a vDEVICE
Date: Mon, 29 Jun 2026 14:16:26 -0700
Message-ID: <b98248fb8a7ba39beeb684d27f064897e6ec8ef6.1782767110.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1782767110.git.nicolinc@nvidia.com>
References: <cover.1782767110.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB57:EE_|MW3PR12MB4378:EE_
X-MS-Office365-Filtering-Correlation-Id: 91fd6093-841a-4bd5-dffc-08ded623c1d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|376014|1800799024|23010399003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	+YY4MDdoPQECJ182Eel30PUcflXQEvlq23ix5aaCnX39GI8EDL4bHjTxMb27bCe8PK9K7xkN/BoSDJNzWjEvVDvs5/Y2q4J7RQRGK6iBP/S3QW1ainIoOl+JP9gLEUn6npo+3zMNzoCAnhFxXW4DRRxRQoZepz9nkhvBTI0jFi0zCILnndwB5WONn3BFUzMAnN+o6mxKEqOB6/7FmojLfODF3ekIH1dGO/PgBMvYC4E4TJJgXw3oI1GSMzKGT394RoVqS/Rk9qoeU5q9z8FyJTUTbFz3MD6TfI+zm44B6CzSciixIJfdBWpo9pODvAEHFQSrGyqE1jOwoIpJ5tnD1GhVMFEnU/BibPfpQSM98QTogmKIMSnDDbPUQOb/GPJLjM70IP91lWlzSbUNUBWNjGIAjWkMQUM9So+RkbqcHvijNn4f1n1zXehw76Lwmi3ZB2ZRapMTFEUXJqG0QAeSaXqGTcxs2rL4cmBcBWxB18QkoUPPxJgLVyxt+9E4vPkddQb1tLXPxLIjSrL0SyuzMZmioU/bIplYoaGUIrNTmGlUdoBtr4n7TiWqh5MjEBn+4xT5A1rqbpI0a7IarhrtOXOlmBe6TedNIIIcCIucVzOwuASt7zrs5rcK3YdYATBli2eYydNSujGvAxXg0JGkBaidVvMJC0vYkU24aVkPJujQFDuhYs2XpAC7JMugXYJKcy34ZZOX375nnbpGCrsvjQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024)(23010399003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	KpEinR4iIw351atEbpEnCDaHCAPG+C9K9raaOhQi1SK8+WS2MHRqv1HY389v+3yRSGeGVTBfj1pebuqmZ8KBp9eOXRutsAMlBGw49UL4iIfopC+X6NlmdiF970qG+CrQRAuAcc7GCrQKZrMy7JVSf7I37mS7W2ft/bcwBDtKieO4q1Zzf+DBJqS60S/fF4QJ4k0fCrBwEoRoCmrgJYR95bCxt9gXJXpfLEY7sDDjDUn/WIKUMw50hw+73CaMIeHV1rE+6zvDGAn52F83qhN4W+Lw8wyNRnisZ4c4wxqknTPLkaBR8ChG30mCO7Ob7KOtwYm6Vsg8pK8i5CtLKyXtyKs2yd2DVdSYdJVVHuZmAJ9x/yug6dInYdLTd5aPpdJY3tegjZdIIq9NjU+GCTrSsu4qILzOhFtHkIizmvQu7PPfGsn7Rf7ZA2mIsPoF8Fbz
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 21:16:59.5738
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 91fd6093-841a-4bd5-dffc-08ded623c1d7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB57.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4378

arm_vsmmu_vsid_to_sid() maps a guest's vSID to a single physical Stream ID
taken from master->streams[0], assuming a device has exactly one stream. A
device with several streams gets only its first one mapped, so a guest vSID
invalidation cannot reach the others' ATC and IOTLB entries; a device with
none makes master->streams a ZERO_SIZE_PTR, read out of bounds.

Add an arm_vsmmu_vdevice_init() op to reject the vDEVICE with -EINVAL when
master->num_streams is not one, rather than mapping it silently.

Fixes: d68beb276ba26 ("iommu/arm-smmu-v3: Support IOMMU_HWPT_INVALIDATE using a VIOMMU object")
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c   | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
index 1e9f7d2de3441..2ba08df75af8b 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
@@ -297,6 +297,20 @@ static int arm_vsmmu_vsid_to_sid(struct arm_vsmmu *vsmmu, u32 vsid, u32 *sid)
 	return ret;
 }
 
+static int arm_vsmmu_vdevice_init(struct iommufd_vdevice *vdev)
+{
+	struct device *dev = iommufd_vdevice_to_device(vdev);
+	struct arm_smmu_master *master = dev_iommu_priv_get(dev);
+
+	/*
+	 * arm_vsmmu_vsid_to_sid() maps a vSID to master->streams[0] alone, so
+	 * more streams would leave the rest stale and none reads out of bounds.
+	 */
+	if (master->num_streams != 1)
+		return -EINVAL;
+	return 0;
+}
+
 /* This is basically iommu_viommu_arm_smmuv3_invalidate in u64 for conversion */
 struct arm_vsmmu_invalidation_cmd {
 	union {
@@ -403,6 +417,7 @@ int arm_vsmmu_cache_invalidate(struct iommufd_viommu *viommu,
 static const struct iommufd_viommu_ops arm_vsmmu_ops = {
 	.alloc_domain_nested = arm_vsmmu_alloc_domain_nested,
 	.cache_invalidate = arm_vsmmu_cache_invalidate,
+	.vdevice_init = arm_vsmmu_vdevice_init,
 };
 
 size_t arm_smmu_get_viommu_size(struct device *dev,
-- 
2.43.0

