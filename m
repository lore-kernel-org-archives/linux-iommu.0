Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011007.outbound.protection.outlook.com [52.101.57.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 224D21E1E16
	for <iommu@lists.linux.dev>; Fri, 22 May 2026 00:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779410224; cv=fail; b=YoHXeJHJCdqx0+RbOp6Zw/RiOR4eVNcmOhDi5nRlAk8cWthJEOazzMjC0dI0a/rN7vCwfA10NB/4xFHsvMK21H27E7dz6yV2MgZCOUAPxr9E2sNClEzzcuUFrrpvIEtel7cgmiMnjNeSeBbDgwmn1O6nXhyV1n/nwxlRu9G4+jA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779410224; c=relaxed/simple;
	bh=qRENNpmgxX1JjqSogGr2VwKtbMXoUaHzyjahHvb+N0M=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uBtZUyZVodAB4D1/Z5urD/OFV7Opl3rYjLmUTk1nvwsysD9GbhMil/a5c4PMpk7Ltvgpgefb6UyJXcujZ+ITX7EmIJ6yjn3aEz0bN0dtq/MAp5Zm3p1C7Vk5uteoBTAvGBXu6xaaYKu/t36QMBpmY1A6CW3TPG+lkMtTQwen5x4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OpvUh7/E; arc=fail smtp.client-ip=52.101.57.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OpvUh7/E"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C5jNJpJFQoiiteFjqeKFb9+hGzHKBNcunbrcu9o+DRtM+Au9TAtGtrvAXO6AyKIFLkGDXKJPSfdfcl9chwLd67NwVGnRPqsh9Gpos4f5oBuvzKwmHBms9w55vpxy1uPRNfVLAmXHsUJ0yR+2+/vaEIzMH2qtH9rNe/w1oghWSEVdpM7tDZ2fGHb0BULwzqaWlgiPkRf2z+dR6IzggVxwAKyYQG1UgYQR4mLLwAwPQFvHpWo/iZN6c8le0yWgiXmFabg5xpShfu1s3/t95PBlhE5ZLaETC4s/TzfMXQ6+mcm1Jtt7q8BrR59anxOo/h2oEbg34X6G4BnJhxjYnIu/+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=phgGmg4iLa4nqdtqDxUVSrOsIIG6H/34RmO54KpgP9c=;
 b=XSJwK+7t9+jRTm2zqm0fr8ocKEusCO982wyO2M1rNnnxFQHG+5pvWSV2gjmBMCg9yUUFZQKzcd7TE4LAJILKSwbYvEdF5JsqImkwMiIhG7cLNq+vcq6aJTmnxz7wuO+tStEYGK6EFnDvwAMqVL9PmcdA1VkJs4Qqdv5ezs3yXPLVfSBdjeBG32iBNPOitQcTxHeJULWGx4lKU9b06/jE3oqVI+lEYpIB/Ln6Ks1yPzs6Uzqnhgn55iXcQwPD8Y5ItPpD0tQJmCQSyARgaBUqMJiNCqnPounQanMyQeUo9PP5ekwlD7FVnRK5ruIpcNwzRlkrIo44FYB5weeFer7deQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=phgGmg4iLa4nqdtqDxUVSrOsIIG6H/34RmO54KpgP9c=;
 b=OpvUh7/EI1PGClpVza5HkDiMp1G+SMi3Lkd8LXi9NpQuYqxnCZfibnAkGL0K2OpK7GmmcF8obZsAex9kWux78DaqIVHBsXRrrkBI/PQ1/O7cT1OgNyiGTQDVTyfWRj5N1ATCD6ALjUF3sE8AX5Zb5rXIJNchIoZdxskklf44QXf9pX9uAerB0KWkCIG3/KU0BYU6yLI62w9LDtYj8VGBmAmrQXv0AIBY5+DB21YWXXEcUOR3BkGWL/rAsNX4wJWB9lulItaufRASpjFBmKvLQ1QPHV/KNf4Il9rr2JyCduliIOObSsDr9iabtyXSiyNh5obFKvyopBqq7A9ckAMipg==
Received: from MW4PR03CA0138.namprd03.prod.outlook.com (2603:10b6:303:8c::23)
 by IA0PPFD78AA37BB.namprd12.prod.outlook.com (2603:10b6:20f:fc04::be6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.17; Fri, 22 May
 2026 00:36:56 +0000
Received: from CO1PEPF000075ED.namprd03.prod.outlook.com
 (2603:10b6:303:8c:cafe::7) by MW4PR03CA0138.outlook.office365.com
 (2603:10b6:303:8c::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.17 via Frontend Transport; Fri, 22
 May 2026 00:36:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1PEPF000075ED.mail.protection.outlook.com (10.167.249.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Fri, 22 May 2026 00:36:56 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 21 May
 2026 17:36:41 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 21 May
 2026 17:36:40 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Thu, 21 May 2026 17:36:40 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>
CC: <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>
Subject: [PATCH rc v2 0/4] iommufd: Fix veventq_depth boundary
Date: Thu, 21 May 2026 17:36:31 -0700
Message-ID: <cover.1779408671.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000075ED:EE_|IA0PPFD78AA37BB:EE_
X-MS-Office365-Filtering-Correlation-Id: 1df1efcf-dcb2-4780-18f3-08deb79a3a3b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|376014|1800799024|56012099003|11063799006|13003099007|6133799003|18002099003;
X-Microsoft-Antispam-Message-Info:
	+rCndTNpfvs3l4XInj3Pu2GDR6m2GHwyBJ0RQ6dKA/mk9QYY86JoSCZM+ldEqXcHK3azOuq4aazDl1NWcJghKULSHgZykmHDKZITWDgqL1DALrFYUCwtyuOAkdk8xA0bizP/tmgiDSUYzUmz34Am18nSXkZ/WD2U1P7kPpKxG3dKir4Z7qI8FIOsJfKBTyikyUvWEwNLTeOY2c0TE/zJ0DJvC7Kb7kGcrVP5cdsCeWnoOVfgXiAmR5OJbs72mSoWEG+NcRMQYXEQ2nt4BFxDqXHa2nSJj158/9U9OILbCP+WFX23M4IYUEmdWJ2AMZm3ruIrVXYy1XKW0HwUQ/M/NuZBDanGa1M8zmw1Q8RFZ3R1H3S+8G3eOoexlGjFBV5WKkmDbKhxRm8MQKrXnkfRVaPd8knlh148mnOyBIPGp6k9WqEVQE4DIKz+IBiOV9WsuPQuw4cDDOfgOicV6Nk2+xb0QTEHQpIBf3iUjVzNvCjVYVmTEyTFb/Hh7XLS9JjkmfKv+wxKsR66g+XwYhBTJ2TMzOhApcw9uaoml+Yj5JeX5Zr6xErl2XNegdMP1lkHFZjtB6UHH5vcpZ+4L8IdG6Uu4P4Uxqt8C5kEyUVStKXY7oH6ryiDxEzn71ncsAJhIM/lVDdAsgZxwlxpmYxiCrR6oXQXGdHOuZ48gKjQWJKzn198WIyGC0UtiB9N1Z3bKw1jbH2e7ggwUtTn6LKfUkf0hr+x3Tq3CfR1BlaLIC4=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(376014)(1800799024)(56012099003)(11063799006)(13003099007)(6133799003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	daOGuuAy9A0dUKftiO06UY2pzwj915H/JxFckAt0z9F5GBHWfMTfvEUKGuUsGKGkoP0wh/kPsl5V+r72WBbO6a0mjwd1vgCnsxRPlgkjmOMe0IrDAjLLu4R2vNF1Aq15uNWQq7xuEHCuZoOK8gFZRDmYNsfvsnqkDubl3sUog7jw+jifCFLQa7EMqML3dE7JFqhf2ekZiHVsxsWKHe8cvrON6LqPS9ciFndSlZrOfLTrqDDtxuPxxD5V58z/RabpKnWOGitgrRzaJW22vuVn9ZHh5IFQwS7E0FnxyDnT6MHikn/W0yaS4ffCigPsFkBZBbarvn07wOSJ8zS3LlcjzhQ3ByjoHukBnFi/dAg03i8KcRblif5QUqNcXI5UM7i2SgaBXU21qnLOy9bR5DDb5SNtVIRqL85V79tlv1sHF/PXEO4iz94g1UjeKW2ZK67/
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2026 00:36:56.1964
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1df1efcf-dcb2-4780-18f3-08deb79a3a3b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000075ED.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPFD78AA37BB

The upper bound of veventq_depth has been missing for veventq allocation,
leaving a vulnerability where userspace could exhaust atomic memory pool.

Fix it properly:
 - Allocate outside the spinlock to avoid GFP_ATOMIC
 - Cap the veventq_depth upper bound
 - Fix event_data byte-count
 - Add selftest coverage

Note that QEMU's SMMU has been already allocating veventq using a "HW"
EVTQ entry number. So, picking 19 as the known use case, for a minimal
level of ABI consistency.

This is on github:
https://github.com/nicolinc/iommufd/commits/fix_veventq_depth-v2

Changelog:
v2
 * Add Reviewed-by from Jason
 * Rebase on Jason's for-rc tree
 * Update commit message for clarification
 * Move "data_len byte-count" to the first
 * Drop optimistic read in the allocation path
v1
 https://lore.kernel.org/all/cover.1779070992.git.nicolinc@nvidia.com/

Nicolin Chen (4):
  iommufd: Fix data_len byte-count vs element-count mismatch
  iommufd: Move vevent memory allocation outside spinlock
  iommufd: Set veventq_depth upper bound
  iommufd/selftest: Add boundary tests for veventq_depth

 drivers/iommu/iommufd/iommufd_private.h       |  2 +-
 tools/testing/selftests/iommu/iommufd_utils.h | 17 +++++++++--------
 drivers/iommu/iommufd/driver.c                | 13 ++++++++-----
 drivers/iommu/iommufd/eventq.c                |  5 ++++-
 tools/testing/selftests/iommu/iommufd.c       | 19 +++++++++++++++++--
 .../selftests/iommu/iommufd_fail_nth.c        |  2 +-
 6 files changed, 40 insertions(+), 18 deletions(-)


base-commit: be93d186ae88a92e7aa77e122d4e661fa57b1e39
-- 
2.43.0

