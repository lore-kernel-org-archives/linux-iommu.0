Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2069.outbound.protection.outlook.com [40.107.223.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2A112B9A1
	for <iommu@lists.linux.dev>; Wed,  7 Aug 2024 00:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722990907; cv=fail; b=Nwt2uwjxjl66Bt5ckNDqgVRmQgoDXS6EENrxCJv3N8IbWHh0xlLmvCTfxWQkH1mDBSi8nkx1VWHGgXRWHnQlRY86x50eiX2fhu91Kyf0uJAMJCCs6vhlEjJRhBxHhEVMvAzuOKe5bpZJUSLKKnfR3YhvSh1JuK9o7Z8Yn7Z6ho4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722990907; c=relaxed/simple;
	bh=Uk0gw/3iohdWDRpgunfmvR/2Jdeyoi9HX6yTrWwoct4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cI/V9X7JcM8CbW6yosDvP/dgYcRZF3b8gxkZAYAYwRJo5BFIx4YJsOyxNMTiELYxR7Bd2MBycslQDjBHCtGbheg2rgReACBNATEkMMEOdegDbbr/td5GDmCjpA96HX97dvN6d2OHcnF64bHHIskfi9VYBUFtjTgyU9DaQhcGi7s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jmrGbaG6; arc=fail smtp.client-ip=40.107.223.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jmrGbaG6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ocSt8QGpaWJDEDzqKj2GS9N7E3oOFGltmJKe8tdbgzmCwX697RlffZTL0Yj/MlvgUFSFSlgcyEE0kezNDuo7OgvXX0HTfywpNBWxHyT7fzqplnYJHjXTGgd3QPxB91r+NE5aw/6OMBfvKBjIo3oLNlQI4kUNcY/00kRQ6n2bAPXJjmwJajgok7AlVyjFuwjvhbgRC93aEzRkVhKkNMMQxSFA40IjbTTQ19b5jObkf66a8tN+QtU8OTXJLC6qFl+f4+eAyEiSWZbcqtKe5aTeGl9h7IfTMtPShs/7W6+ZeioaEkZips/o9tz176Uw0NbGAoLGVK+7uKYGa8oIGQF1CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rMaztat7898AlTFAc5BPpcTaey9c+u1ohij+xQuijjU=;
 b=cppbjiZygtUiMNM7VivlG6+X4JWhZlLo273tQqE7JYgG9J6qV9eeC29bkolByRikByuzBf3KCGX3LTvEBtiGQiQ8acDt3bxvr8NelRd7tlGgYojoABkrK74UeRyzORePP+S/rINCmOwc8f2AW8Yhj4vi32ZZTmIrEPmjzZkHEmpuXKcjrmGjtbcW57N/BilRLaUzLN5NJPt9cGeZi1PHHNLlKIWe2h9lSigVU75zlkBSWk6i/OU2FuYn6bfObV5jz4XcGZAnmxgct4oVHnBSOqTcNONp5fYo3vvLKC46AEzIzPfIt25dECq4IbJAHYV7HBj+Tnxd2twy5TfhqtYA+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rMaztat7898AlTFAc5BPpcTaey9c+u1ohij+xQuijjU=;
 b=jmrGbaG6gSzJLSRUN8LXJsXMaO1mgCNkEw8XGeZ+I6rsf9ZTFORmaqMjw2xRwVXedqOTgkuylRs+wplU/B0VT5ZgeQOzxywERaiNqU4/X2HloRNPs00BtFqHezZ/a1QnguHjDMIY1i56q9xxPouf805ds/aoV9N0FjOSH6tek6S2L0Jf0z046U7n+BJ/bM7N4QpFf+e9hxclRHtiPDnNkI9MCc44qNp0ZqdFDFdUf9spB7LQbJuabLP4HPEONrtUedYKlTHbLvsnnO0MOBq8tSOFjFDBfCZJyG/OjQuOnVwbM5tVF6K6Mqfo6Z0c7/9JbACU92hH30ZF3dyDaXA/FA==
Received: from BL1PR13CA0093.namprd13.prod.outlook.com (2603:10b6:208:2b9::8)
 by SA1PR12MB7128.namprd12.prod.outlook.com (2603:10b6:806:29c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.23; Wed, 7 Aug
 2024 00:35:01 +0000
Received: from BN3PEPF0000B06C.namprd21.prod.outlook.com
 (2603:10b6:208:2b9:cafe::bd) by BL1PR13CA0093.outlook.office365.com
 (2603:10b6:208:2b9::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.11 via Frontend
 Transport; Wed, 7 Aug 2024 00:35:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN3PEPF0000B06C.mail.protection.outlook.com (10.167.243.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7875.2 via Frontend Transport; Wed, 7 Aug 2024 00:35:01 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 6 Aug 2024
 17:34:52 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 6 Aug 2024 17:34:51 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 6 Aug 2024 17:34:51 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>
CC: <yi.l.liu@intel.com>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v3] iommufd/device: Enforce reserved IOVA also when attached to hwpt_nested
Date: Tue, 6 Aug 2024 17:34:46 -0700
Message-ID: <20240807003446.3740368-1-nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06C:EE_|SA1PR12MB7128:EE_
X-MS-Office365-Filtering-Correlation-Id: 23d3c404-db71-4b0b-96a9-08dcb678c616
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ttjU+QMe0Ep0mxw7aEG4X+OD2U6cr+tr6paTW91iru35It671P1A8/dtWPS1?=
 =?us-ascii?Q?LBYgaAclAf1GyXPXhFnn6avDQj4jAI7/llW/LYweXSCwTLDaW2qK+fnpCqDa?=
 =?us-ascii?Q?+lnGpB8wTpv/sLcYUxVAVkF4+EHMmOMUd0r0hrk26uR4bCVt70IwisjXvpb/?=
 =?us-ascii?Q?mCd1kleEiMVVUlsAiJvFquIuBzeg23xHJgzt+y2MwhokXNZHc2lDVQv6HLtF?=
 =?us-ascii?Q?EeaRqeAOpJ+lP4y317jYXhHS3wAeFbOY1ZLUajj4dJBYQkvqSrsTqe8H7nwc?=
 =?us-ascii?Q?Ai4j3p0Ai44ZqBEIcxokM0W0Tp9kwu5VQwu675CGTWryqKZfSCEx5/ROYhWk?=
 =?us-ascii?Q?D4e4JCtR8JdH+Y5j7AvdMeggFZM/lRVOhLpeQqoDZGPzUIuI490ZpOv4CaIh?=
 =?us-ascii?Q?B6DXSFnYJCLRZMFqbv8ZW0cad3VpV8ZH3VnDdSH4RX0eHwoyT0GIrR6vcOrL?=
 =?us-ascii?Q?0hgms131fXx3+QzwoQAZYl3QvrFsgxNSdJxJQ29Yb1G/+05Ka2dhYpbkWOWf?=
 =?us-ascii?Q?4vAhUbVRekwTayojoKV+lT7vjrjnyK9dx7DbEeepGADlQL34oeIYmij5oko7?=
 =?us-ascii?Q?XeaCEaon1EJqEZkS1cBf33Jy7JwRV/81+S/aZFUl4pWOCU9u4f9xRv6e/syq?=
 =?us-ascii?Q?qeqV8zFzefoDSGvit/KNJsDLoXGhrR7QmYqRwh4zscp0b7mp33A+CMxCDDRk?=
 =?us-ascii?Q?A7b8b0efNkZWRFYiUc0xNdPHA0grioqXcrngxnHaLm0HLaX1JcEStqCcbLc7?=
 =?us-ascii?Q?2ZcIHegykWUbkAZn60OGuTeHUoj/9qUu44mGc/YgCNnBeRAqm7kR3svut2Fo?=
 =?us-ascii?Q?V5agcTW10UboQbgf96LzWPFSpOmDjAY6fKlTydg1y9+ZnhXleGMW/YvLSBNU?=
 =?us-ascii?Q?oJf1dyIXAlPRV8EkjmfKH/EAn0q9LUL9nSo9JIfjc6i28khv+fBwV2rF+CZy?=
 =?us-ascii?Q?os9aoX1lo6YiNbxzkdgkuQvMkTkvjDuC7W6kgP2tWJrgD5ZNxG+qBtjCNcx3?=
 =?us-ascii?Q?R4cYarrL6yFgRFeBwKkJem6ugwGK2kYDTx4SqSTa+8sbumVw2tiOwtGv+fCr?=
 =?us-ascii?Q?yGnS4l7CxZKfqCpz5yBjhBzjYeVr1kil1aJoHnFypDWqiRrg82Oeztw4HDrC?=
 =?us-ascii?Q?DC7OFZSE3ZZzpZX4jjEGw2SNY5fjWuuu132VcFLKB2SDU/Da6B4c6ZkTTr0s?=
 =?us-ascii?Q?4DfOBZTq7zfoGjKLlAHPyYjZaDMq2gQta8yYQQJXfXnGOo277skRR5Q4msOi?=
 =?us-ascii?Q?2xzNlwURs14V3s9rabRoWkwcjbZNCa2JJAnW37mPlibZRtPIqqD9OiwKavj2?=
 =?us-ascii?Q?Q5nEZvYHjFIdCm5IZCh5vExekQEOZ1tMQt/C/swBT9XIEMfoUJ6CW2xo3cYz?=
 =?us-ascii?Q?6+wuM0kbGK+e+K+i0naVXBOrzUbOeR3klB73SIfk/xxBjeEehpk0rFfUF5Dp?=
 =?us-ascii?Q?6ZtmXG60VB7Qzmm7G/k9Y5Hc6T2W1dEa?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2024 00:35:01.3436
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 23d3c404-db71-4b0b-96a9-08dcb678c616
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B06C.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7128

Currently, device reserved regions are only enforced when the device is
attached to an hwpt_paging. In other words, if the device gets attached
to an hwpt_nested directly, the parent hwpt_paging of the hwpt_nested's
would not enforce those reserved IOVAs. This works for most of reserved
region types, but not for IOMMU_RESV_SW_MSI, which is a unique software
defined window, required by a nesting case too to setup an MSI doorbell
on the parent stage-2 hwpt/domain.

Kevin pointed out that:
1) there is no usage using up closely the entire IOVA space yet,
2) guest may change the viommu mode to switch between nested
   and paging then VMM has to take all devices' reserved regions
   into consideration anyway, when composing the GPA space.
Link: https://lore.kernel.org/all/BN9PR11MB5276497781C96415272E6FED8CB12@BN9PR11MB5276.namprd11.prod.outlook.com/

So it would be actually convenient for us to also enforce reserved IOVA
onto the parent hwpt_paging, when attaching a device to an hwpt_nested.

Repurpose the existing attach/replace_paging helpers to attach device's
reserved IOVAs exclusively.

Add a new find_hwpt_paging helper, which is only used by these reserved
IOVA functions, to allow an IOMMUFD_OBJ_HWPT_NESTED hwpt to redirect to
its parent hwpt_paging. Return a NULL in these two helpers for any new
HWPT type in the future.

Suggested-by: Tian, Kevin <kevin.tian@intel.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---

Changelog
v3:
 * Moved to_hwpt_paging logic back to the callers
 * Added a new find_hwpt_paging for reserved iova callers
v2:
 https://lore.kernel.org/all/20240806050201.3717816-1-nicolinc@nvidia.com/
 * Corrected the ioas comparisons for future hwpt type that returns
   NULL by the to_hwpt_paging helper.
v1:
 https://lore.kernel.org/all/20240802053458.2754673-1-nicolinc@nvidia.com/

 drivers/iommu/iommufd/device.c          | 52 ++++++++++++-------------
 drivers/iommu/iommufd/iommufd_private.h | 19 +++++++++
 2 files changed, 45 insertions(+), 26 deletions(-)

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index 3214a4c17c6b3..bcbcd6d940624 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -327,8 +327,9 @@ static int iommufd_group_setup_msi(struct iommufd_group *igroup,
 	return 0;
 }
 
-static int iommufd_hwpt_paging_attach(struct iommufd_hwpt_paging *hwpt_paging,
-				      struct iommufd_device *idev)
+static int
+iommufd_device_attach_reserved_iova(struct iommufd_device *idev,
+				    struct iommufd_hwpt_paging *hwpt_paging)
 {
 	int rc;
 
@@ -354,6 +355,7 @@ static int iommufd_hwpt_paging_attach(struct iommufd_hwpt_paging *hwpt_paging,
 int iommufd_hw_pagetable_attach(struct iommufd_hw_pagetable *hwpt,
 				struct iommufd_device *idev)
 {
+	struct iommufd_hwpt_paging *hwpt_paging = find_hwpt_paging(hwpt);
 	int rc;
 
 	mutex_lock(&idev->igroup->lock);
@@ -363,8 +365,8 @@ int iommufd_hw_pagetable_attach(struct iommufd_hw_pagetable *hwpt,
 		goto err_unlock;
 	}
 
-	if (hwpt_is_paging(hwpt)) {
-		rc = iommufd_hwpt_paging_attach(to_hwpt_paging(hwpt), idev);
+	if (hwpt_paging) {
+		rc = iommufd_device_attach_reserved_iova(idev, hwpt_paging);
 		if (rc)
 			goto err_unlock;
 	}
@@ -387,9 +389,8 @@ int iommufd_hw_pagetable_attach(struct iommufd_hw_pagetable *hwpt,
 	mutex_unlock(&idev->igroup->lock);
 	return 0;
 err_unresv:
-	if (hwpt_is_paging(hwpt))
-		iopt_remove_reserved_iova(&to_hwpt_paging(hwpt)->ioas->iopt,
-					  idev->dev);
+	if (hwpt_paging)
+		iopt_remove_reserved_iova(&hwpt_paging->ioas->iopt, idev->dev);
 err_unlock:
 	mutex_unlock(&idev->igroup->lock);
 	return rc;
@@ -399,6 +400,7 @@ struct iommufd_hw_pagetable *
 iommufd_hw_pagetable_detach(struct iommufd_device *idev)
 {
 	struct iommufd_hw_pagetable *hwpt = idev->igroup->hwpt;
+	struct iommufd_hwpt_paging *hwpt_paging = find_hwpt_paging(hwpt);
 
 	mutex_lock(&idev->igroup->lock);
 	list_del(&idev->group_item);
@@ -406,9 +408,8 @@ iommufd_hw_pagetable_detach(struct iommufd_device *idev)
 		iommufd_hwpt_detach_device(hwpt, idev);
 		idev->igroup->hwpt = NULL;
 	}
-	if (hwpt_is_paging(hwpt))
-		iopt_remove_reserved_iova(&to_hwpt_paging(hwpt)->ioas->iopt,
-					  idev->dev);
+	if (hwpt_paging)
+		iopt_remove_reserved_iova(&hwpt_paging->ioas->iopt, idev->dev);
 	mutex_unlock(&idev->igroup->lock);
 
 	/* Caller must destroy hwpt */
@@ -440,17 +441,17 @@ iommufd_group_remove_reserved_iova(struct iommufd_group *igroup,
 }
 
 static int
-iommufd_group_do_replace_paging(struct iommufd_group *igroup,
-				struct iommufd_hwpt_paging *hwpt_paging)
+iommufd_group_do_replace_reserved_iova(struct iommufd_group *igroup,
+				       struct iommufd_hwpt_paging *hwpt_paging)
 {
-	struct iommufd_hw_pagetable *old_hwpt = igroup->hwpt;
+	struct iommufd_hwpt_paging *old_hwpt_paging;
 	struct iommufd_device *cur;
 	int rc;
 
 	lockdep_assert_held(&igroup->lock);
 
-	if (!hwpt_is_paging(old_hwpt) ||
-	    hwpt_paging->ioas != to_hwpt_paging(old_hwpt)->ioas) {
+	old_hwpt_paging = find_hwpt_paging(igroup->hwpt);
+	if (!old_hwpt_paging || hwpt_paging->ioas != old_hwpt_paging->ioas) {
 		list_for_each_entry(cur, &igroup->device_list, group_item) {
 			rc = iopt_table_enforce_dev_resv_regions(
 				&hwpt_paging->ioas->iopt, cur->dev, NULL);
@@ -473,6 +474,8 @@ static struct iommufd_hw_pagetable *
 iommufd_device_do_replace(struct iommufd_device *idev,
 			  struct iommufd_hw_pagetable *hwpt)
 {
+	struct iommufd_hwpt_paging *hwpt_paging = find_hwpt_paging(hwpt);
+	struct iommufd_hwpt_paging *old_hwpt_paging;
 	struct iommufd_group *igroup = idev->igroup;
 	struct iommufd_hw_pagetable *old_hwpt;
 	unsigned int num_devices;
@@ -491,9 +494,8 @@ iommufd_device_do_replace(struct iommufd_device *idev,
 	}
 
 	old_hwpt = igroup->hwpt;
-	if (hwpt_is_paging(hwpt)) {
-		rc = iommufd_group_do_replace_paging(igroup,
-						     to_hwpt_paging(hwpt));
+	if (hwpt_paging) {
+		rc = iommufd_group_do_replace_reserved_iova(igroup, hwpt_paging);
 		if (rc)
 			goto err_unlock;
 	}
@@ -502,11 +504,10 @@ iommufd_device_do_replace(struct iommufd_device *idev,
 	if (rc)
 		goto err_unresv;
 
-	if (hwpt_is_paging(old_hwpt) &&
-	    (!hwpt_is_paging(hwpt) ||
-	     to_hwpt_paging(hwpt)->ioas != to_hwpt_paging(old_hwpt)->ioas))
-		iommufd_group_remove_reserved_iova(igroup,
-						   to_hwpt_paging(old_hwpt));
+	old_hwpt_paging = find_hwpt_paging(old_hwpt);
+	if (old_hwpt_paging &&
+	    (!hwpt_paging || hwpt_paging->ioas != old_hwpt_paging->ioas))
+		iommufd_group_remove_reserved_iova(igroup, old_hwpt_paging);
 
 	igroup->hwpt = hwpt;
 
@@ -524,9 +525,8 @@ iommufd_device_do_replace(struct iommufd_device *idev,
 	/* Caller must destroy old_hwpt */
 	return old_hwpt;
 err_unresv:
-	if (hwpt_is_paging(hwpt))
-		iommufd_group_remove_reserved_iova(igroup,
-						   to_hwpt_paging(hwpt));
+	if (hwpt_paging)
+		iommufd_group_remove_reserved_iova(igroup, hwpt_paging);
 err_unlock:
 	mutex_unlock(&idev->igroup->lock);
 	return ERR_PTR(rc);
diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index 92efe30a8f0d0..0bfacaf40c055 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -324,6 +324,25 @@ to_hwpt_paging(struct iommufd_hw_pagetable *hwpt)
 	return container_of(hwpt, struct iommufd_hwpt_paging, common);
 }
 
+static inline struct iommufd_hwpt_nested *
+to_hwpt_nested(struct iommufd_hw_pagetable *hwpt)
+{
+	return container_of(hwpt, struct iommufd_hwpt_nested, common);
+}
+
+static inline struct iommufd_hwpt_paging *
+find_hwpt_paging(struct iommufd_hw_pagetable *hwpt)
+{
+	switch (hwpt->obj.type) {
+	case IOMMUFD_OBJ_HWPT_PAGING:
+		return to_hwpt_paging(hwpt);
+	case IOMMUFD_OBJ_HWPT_NESTED:
+		return to_hwpt_nested(hwpt)->parent;
+	default:
+		return NULL;
+	}
+}
+
 static inline struct iommufd_hwpt_paging *
 iommufd_get_hwpt_paging(struct iommufd_ucmd *ucmd, u32 id)
 {
-- 
2.43.0

