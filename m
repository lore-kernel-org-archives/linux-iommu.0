Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2042.outbound.protection.outlook.com [40.107.101.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCA8C18C35B
	for <iommu@lists.linux.dev>; Thu, 29 Aug 2024 18:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724954878; cv=fail; b=D4oHkEHjp/nDSPhw/ZPmNIRFwq5GHZq9OTAFZJXqLY9ZPcCzZkHyMJzW6KDc7g1ERG+SrtbnXE5U4fhA11Tp/BSbrd+3ClITtn7tl6DP8oLUQQJAyfvt+XcEKUWArs5szVSKv+dCBDmpGmOIrBtXUkJKzxEVAkS9ND9qmGzOYww=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724954878; c=relaxed/simple;
	bh=l2UWGPalLi/dAUBBn+QL9GTQ5XtAUSWmsvSkj5c8PUU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WrXdnBfIskEEG1CqGzOytQUiIvDkErNT5lABTaDeMpYDJbROUmRSR9oUKrS2+F4xpjL0zbT4YS1HRK/tR4JJCXsTZut6RkW42xXrWDbr+nyGvmO8GShHaTzCIP7MN8CEA0A0abp/nVrszgRnIGC7406aN1Ij8UqFXGHq5sCoQJk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=WJ9LP53a; arc=fail smtp.client-ip=40.107.101.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="WJ9LP53a"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L014zMOaaUAIWBJJTpldhSD4sa7otP20VybD8+uBfhE4L7jcznSYzXpAm+8KdwGsOVPmEKx9U5tnNFs3TELDOpD896us3Uqrvng8VXpUHCvJH0gO16i8SDHDyRkb53lc20ztFnJRsW3d0ShZjU1vdfUiVYOm5RGR1rvGl1i3mr/6+cjEufJClISMReLf+cMF2AaVypamRWaemkw7qmbQw9otXaPS6onoauErnHqXdOMHt8/BuAaeHbv7RsPTn9vHhvyZc2DtmoRsu1g/SuJoc1bZFEC2neM9399/3g4CpqVGV7wwTiRShhN/w0XThiiPr/evKczvWupKIPRWtvsCvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x1jqPVBabM9Xq6d24QN6ZzXHDSDmnXRUFbAZErWTpi0=;
 b=jRdwtC0RxqIXqsfUYm43cd7JW8AyBsZPhW/0pZzWSGaH1mxWDuSBRbktVhwfq50XFOZ3fzq2/VwI1wU+Z53/1uSlkGwvvixUEY02kYczgdUUWOTkaFCgPSN6hDiOBgjBIXPg1WjQhZAUbDt18KVZt7cIQsuSGL3308cqZ7Cdq5uQvsyqES7WNZyx9gyN8balRKlWpZ2CQ16fP/vlZGpaza9P9MX6E6GVg9jNg97hniDx32slpWFurItoXhKMcqJYTIzVIU8Zu2GV3t9uL+c1CVVnQNqhdna2kp9S7gta1lzR+qcsiqmVA8FyRUQGb3fGnnoutlqt4PHxIds20Zffww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x1jqPVBabM9Xq6d24QN6ZzXHDSDmnXRUFbAZErWTpi0=;
 b=WJ9LP53aBVgEvBjSs74U/beILyQwkenP4WvY5xTTbpUZR4sBaZsWJvVapXvK0CfZSjqsG8erc4X0HAWBaqqLyLjyr1RQOtyFk0zkMrO7+KdOpRzk3nBvSAsuVfyaGLmX/3H7RascnI41GR0s5RkfYWYhd/Y1EO1unhA8zCuHniA=
Received: from CYXPR02CA0003.namprd02.prod.outlook.com (2603:10b6:930:cf::18)
 by PH0PR12MB8175.namprd12.prod.outlook.com (2603:10b6:510:291::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.28; Thu, 29 Aug
 2024 18:07:53 +0000
Received: from CH1PEPF0000AD77.namprd04.prod.outlook.com
 (2603:10b6:930:cf:cafe::41) by CYXPR02CA0003.outlook.office365.com
 (2603:10b6:930:cf::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.20 via Frontend
 Transport; Thu, 29 Aug 2024 18:07:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD77.mail.protection.outlook.com (10.167.244.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Thu, 29 Aug 2024 18:07:53 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 29 Aug
 2024 13:07:48 -0500
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>
CC: <joro@8bytes.org>, <robin.murphy@arm.com>, <vasant.hegde@amd.com>,
	<ubizjak@gmail.com>, <jgg@nvidia.com>, <jon.grimm@amd.com>,
	<santosh.shukla@amd.com>, <pandoh@google.com>, <kumaranand@google.com>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH v2 0/5] iommu/amd: Use 128-bit cmpxchg operation to update DTE
Date: Thu, 29 Aug 2024 18:07:21 +0000
Message-ID: <20240829180726.5022-1-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD77:EE_|PH0PR12MB8175:EE_
X-MS-Office365-Filtering-Correlation-Id: d2a7ae2b-5cfb-412e-6ad4-08dcc8558084
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Y7WzEtrER4jRIogsa7zkN13gICjgp+4qVgMuW4cEkhjgTRkqBOOEfScx4uEB?=
 =?us-ascii?Q?9tkGPOJXd4jfkRKHIf0/eQwPYnQM5cC8PKFtYnFAodnze0osxGJiAVl/pMyt?=
 =?us-ascii?Q?oPyPbNFsv9OjBnVrJZlDNra4lJ1917aRXGWQhIiWGwW45WBb+BXlnJzJnOzQ?=
 =?us-ascii?Q?1zOaw8b1cwfU1+i3IcB2X2FEgoPUB+Sv1BckZb67Pni5csuwWaS6xr5JYd6H?=
 =?us-ascii?Q?O3E1O72opaU5jg6PGttjs3dOVyYxuX3aPXg2utwkFIozGKHwfuGT2mZYWtIv?=
 =?us-ascii?Q?+tRuAHnetKHo3uc3VbhRGkWzD8YgO3QX5lPyy6zBDjSM4WvsgX6hbZUqMSHL?=
 =?us-ascii?Q?0nuQB/dtId9N7/t/XXL3FqyJbD2VoTGm2bgyKChPWhQcNiN3eFofygIi0Udl?=
 =?us-ascii?Q?7hntp4BEf/RDP3mBtKFbbgcnR0sd+oOsNLAPl5W35XhFJMNZ08vDiq7y2m0T?=
 =?us-ascii?Q?Wps0rJBgP3IfW1+SulYZo2kRKBk70OrI8hswMGowQYHIC3kX7o3CH3mQaYDZ?=
 =?us-ascii?Q?x/zyWg6wN5DL1J47OVsxbJ6p8PmI8CwFzsC8VeDUX8ywNIKokkqWv5guEPvE?=
 =?us-ascii?Q?BDShM2fRc84z1Xfq4aVXsaoMEZ6MqFGLoD4YVXIEiKUXE2XVSG5jSfzaMS/n?=
 =?us-ascii?Q?+n0iw131xnKWPTV4LjziaUfpRWZe/C281UmyH3+zLTa8UetVVydNAFyc+ArA?=
 =?us-ascii?Q?IvuNBX4uFar/uh1M8lh/WZf4iIEkVvKbL0xsMofL04yW6EKXQnh1fOqtE3Fe?=
 =?us-ascii?Q?HCw0fJ06g96XmYCq4tVqXhnuRz+1D0tRxFuWqiRHl8vyrArm9U7t6/JlBeOS?=
 =?us-ascii?Q?XnqtLTzvRjzMKTdisvgonsKIL+QxXg0c5qu+/FLIRVsRfyr4zoVMlcaX5nIe?=
 =?us-ascii?Q?9mSTcq96OdCQFNyXyQWYQj8k4l3fwjM9hrf/NYjslaR9H3BVJxXhq+EarIez?=
 =?us-ascii?Q?QOr//pYzgT8t9/tvaXcKhtftHextOCFqBAyZv4rfSIFYN7IZ/qWFjcVeWKy4?=
 =?us-ascii?Q?GQ7QJdIyp1wzKZ3Yg0Qq562ERIcc7G4DKuDQbXLUqayTc44sb7rRqDT9k3oH?=
 =?us-ascii?Q?teg/iCl2d6/hTk+QgdlqUBbvY2iTpAGy8nInl93LMGmRBPczJplf3DxlTDIg?=
 =?us-ascii?Q?Tq0Vs61oS2GNRPYG8GFUU/cgI3l3leAkI7j6YgzwqUpaKrfWLKQupcQF3rjC?=
 =?us-ascii?Q?3kgSIGG6SLLc8/rAagJQT52QjxdjoGUvGVOPO2AmP6actt4LrYWXxs0yiPeg?=
 =?us-ascii?Q?GOWKyLvbe/uaCwtyyfS38OWF4/KC7g1Qs2KsBAq6er+oBnI+f+hBA5U7e88I?=
 =?us-ascii?Q?tZ5y/fqReqyno4dG5OZf24A/CNi6bOVRsWVB4EACcKVKmhEDZwrfBOdAoBMu?=
 =?us-ascii?Q?bLL63kjrJhKDtTsnHFLxUJbj0BiTVA5prVjWSpOqqRMtcl8OKQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2024 18:07:53.1048
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d2a7ae2b-5cfb-412e-6ad4-08dcc8558084
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD77.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8175

The v2 series splits the v1 patch to address several concerns in review feedback
(https://lore.kernel.org/lkml/e937e26f-038a-6d01-76a9-76c86760ca4a@gmail.com/T/).

Changelog:
 * Patch 1, 2, 5 are new.
 * Patch 3:
   - Change struct dev_table_entry to union,
   - Fix update_dte256() per feedback from v1 
   - Add get_dte256() helper function
 * Patch 4: Refactoring set_dte_entry

Thanks,
Suravee

Suravee Suthikulpanit (5):
  iommu/amd: Disable AMD IOMMU if CMPXCHG16B feature is not supported
  iommu/amd: Introduce rw_semaphore for Device Table Entry (DTE)
  iommu/amd: Introduce helper functions to access and update 256-bit DTE
  iommu/amd: Modify set_dte_entry() to use 256-bit DTE helpers
  iommu/amd: Use 128-bit cmpxchg in set_dte_irq_entry()

 drivers/iommu/amd/amd_iommu_types.h |   6 +-
 drivers/iommu/amd/init.c            |  23 ++-
 drivers/iommu/amd/iommu.c           | 237 ++++++++++++++++++----------
 3 files changed, 171 insertions(+), 95 deletions(-)

-- 
2.34.1

