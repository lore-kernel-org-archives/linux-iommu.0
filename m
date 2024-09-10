Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2089.outbound.protection.outlook.com [40.107.92.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3353B17B427
	for <iommu@lists.linux.dev>; Tue, 10 Sep 2024 06:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725951516; cv=fail; b=RteYC44B4YNPbgf4Fs4eK0Bmiw2FoPJo8k0+e8HG51nXXAKrcAD19fBgtih1/QpkIKHLreijEH96mQ3ZGEtK0Wz9W6ugaKIEozKEZcP8gBl+4TFa89TZIs5EKC45lXgspo5+J5j+xgkPTapjmUICOxC2wEuzG0PV40YPEu3gM+8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725951516; c=relaxed/simple;
	bh=uBj2jL76iES5roAUh5qdFbsBecPR1930WUb+V4YqjEQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=j0mNc7C2R4oUyxo5C2/Gd/UcV21WvQDUqbY6oiIu5r0NqFpe7DiM1L3tRz015x+YWvzCYnhFUXbdMEVTKYDL8TgywAawSsPRiOE3JHOO1MQEOxMNTU6JqukDdUsZbF79zanveebOCbK6n2CC1A8OUJrRahOIXj5RaPpvSgzgBgk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=RULxZTLf; arc=fail smtp.client-ip=40.107.92.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="RULxZTLf"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eT/rV2NMEALeFvt1FXh1jB0P6KYxMTCE7eZ/5PHXJigDcWTnbID4qgNt2m3195wTmz+aGcR5XtH8nOZk5MMpevSu/0N8KS3spK1Cg7GewVS9ZWjPQRMiBCKMUdmpS3Ru4yb7Nojf75Cw3OKAe1MvfhFR+Mw770wZrQRdcEQ4IUZGCJ6vDmI9D2lWqI/xqK6jqNx+gWg+hcFUTWNVBLyHNiawoX/OlM5O3TOTADajnBeabbFRlNgcG+H8kYnzDToP3Pl8bBsXk8V7LR0/uU0bFFSZsAqmNcvXWl3gpPETIQVa6Ac/SuciDJ7FuO8eg5hTtk10JFhxrzu1xPYbXAoq/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+abEW7r0FtA27odKohZQJ6u2gFzMy6uU5FqTtpeZVhE=;
 b=Gsnx6GgYzVsLR/7eEqpj+l7Ngkwqq6w5dWAjAeev6HICJnJHvyvUibnU2H9sK8TDz/qi9n6MSSazrgpkWsggiKYrVsuK1/i9s3xERtD7zlisqaaFDatmgRcO5ypITg0t+ru+zRScbMrZ9ITQCeo/odE99lkc0AM07cMrKgUG5nCOdk0ayez5wmeKRDcF5nDPafrNXUFlfkTmdpArXXrmbw9VkAYwemmCoyH1IbQbDEurhUO6X/bt5RGxKUl+dIRJngh+hH8DN79G1tyITXiiBzI1EROIUY2REDfuRIjTZlj9TqdILWYbpko+iuyLrTN+8uzVg/pIcYdFvc3aj5eBOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+abEW7r0FtA27odKohZQJ6u2gFzMy6uU5FqTtpeZVhE=;
 b=RULxZTLfrfHJt8T/HJEMHGpVuBKbC4y88cZz19fqlriN0IyRrgCBP8a6th9IS5vhXlwWZWgaBhgrrvMeM/Z89Ec+uwfSL7xcSKbKdNJ5U95ftnp+F4bvch1qT2R72KOTNWP+vCGLN3OfMZ2/8w0EkkWA/ZQKul8XB4gHuoAjGOg=
Received: from BL0PR02CA0072.namprd02.prod.outlook.com (2603:10b6:207:3d::49)
 by BL3PR12MB6380.namprd12.prod.outlook.com (2603:10b6:208:38d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24; Tue, 10 Sep
 2024 06:58:31 +0000
Received: from BN2PEPF00004FBB.namprd04.prod.outlook.com
 (2603:10b6:207:3d:cafe::9d) by BL0PR02CA0072.outlook.office365.com
 (2603:10b6:207:3d::49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24 via Frontend
 Transport; Tue, 10 Sep 2024 06:58:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN2PEPF00004FBB.mail.protection.outlook.com (10.167.243.181) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Tue, 10 Sep 2024 06:58:31 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 10 Sep
 2024 01:58:28 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <will@kernel.org>, <robin.murphy@arm.com>,
	<suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v2 00/10] iommu/amd: Improve domain allocator and device attach code path
Date: Tue, 10 Sep 2024 06:58:02 +0000
Message-ID: <20240910065812.6091-1-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBB:EE_|BL3PR12MB6380:EE_
X-MS-Office365-Filtering-Correlation-Id: a2d4fde3-2070-4c70-4989-08dcd165faf8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0rQI0s67wOh5WBal9Jrg63ilJ1WMUF8bwz3gyXxVw0ia9mGwZJGrfiyM+opQ?=
 =?us-ascii?Q?PiVoAukxMpI3IHp1Knl1T5srrvShhxGJcJF4XTNkUnHnsZQc1ZdKOlkLRAFt?=
 =?us-ascii?Q?wHE/PTsEMfKBwRabqEoDrIKv7F6o5fSyqqY9KH+gv1RLUac+GaMRRKMAAXz6?=
 =?us-ascii?Q?HT+CinrpOtMWCwulo9A8Pt5y6DvOFPbG2OoGUswROt1fbSgMi4lYrstjgIKe?=
 =?us-ascii?Q?LJmuT1OQfNVaHQfqPSfibl6CtsMqlksUJtZnUMRij5P2r57TYUx5D253gbsP?=
 =?us-ascii?Q?Kg++XNgFm4t/UocoUuw3eD7eh+Uaob42RA7jhTol8vwo+ad3ROLeQZHxfhdr?=
 =?us-ascii?Q?xjLAJ1pWrFt5v3q2DwyAfHUMxqzqITywXzdeetJfC66coB7fWrOPHEPFHRNM?=
 =?us-ascii?Q?f19BMEiwHfR5Xxqn/e7TPiitgmcBxP4RpB7EKydrgwH0U5+cs3b+ruJPXYe2?=
 =?us-ascii?Q?BnoyYOMW+65D7zF9+SZuY6i9P0nPYgqbI3dNA7YhgCJQ+drMk+qDJ3qLI3nm?=
 =?us-ascii?Q?I0RaqNckdsjXcl+murYTSduLPPqFVeX+N4i7uT9R70jUvxPjAt2k3VGLTUha?=
 =?us-ascii?Q?LC697t9bYlDbD/pM9BjbxCqGwBNvoVWbl5Tymba8sWOtvoFERmKJk4Q9OLYe?=
 =?us-ascii?Q?lnhZeprTmBW+ghWrjb8M3IWZw62XdRCvffrmxpWJ76NJI3tdIHWnTf4pWoNL?=
 =?us-ascii?Q?fwi88VIOvyP4HoBp4Of+1+2epU/H3Sqst3Jo7D+kSuZ3bLmUjVpyLIED6dL7?=
 =?us-ascii?Q?6rM1bFPmaV2ox02nsj/bSf2+/kKMz0gpdcHxSE7C/+PoL3nn/n2bG7cUCDnG?=
 =?us-ascii?Q?0Pk4P4Y0PM24RmcoPF5Bt5+p+QEFoK141N1YVh4rtumRCWOTufSm7vCac6jb?=
 =?us-ascii?Q?tQnY14dIGJtItIrsyvolRm7olUgSImuEkxSqRQ9t0+V5Q0oYTobgLnk9EKVQ?=
 =?us-ascii?Q?qTGef8rV40UH/t+wxlIvtHa85bWTxtvDvhA2WxMgtcDFjn5tG2StZvSCSnur?=
 =?us-ascii?Q?3ctbgCOB0YVMgl6V1EmTRhYXqvnfYDoN3HbNg8+YGVinxgVx4a62ZZLEfkBo?=
 =?us-ascii?Q?3IvZ27Ouv7VXVGrjuhLSzQJXp2LqV10UJ7V4DYlLMtbYKRjp3vgKZoiPmTk9?=
 =?us-ascii?Q?qiRyQWErP5EOUAHRcWrNFAe6Ba45hF0HBDv2EP0/heantxr+FqFrxQOGFce2?=
 =?us-ascii?Q?uLc87s6eCwED5AG2Dx5l2FU3VV9F5BD46RFTHCsd99x1KI6RPHYomyx3zYON?=
 =?us-ascii?Q?whZYCoRYfp83f0Z9kya4wxRMn3WZGhypRYnXD4JvZddpN5/MG/qlM8SE5DW3?=
 =?us-ascii?Q?6XDMD3dbgME8tF0JWFxx1h7WBGjt+SMPsVL250D5DPm9W4IcmFd/MxMxZl3V?=
 =?us-ascii?Q?f4h6g3PU6OkSy2lFkzx5BQ67RMoobe2Z7ntMi4F9qPTLy8G8W8qvLWHkEgGC?=
 =?us-ascii?Q?HlFSwcp3yHXhs5Vm4Na4C4BIxwwJTXOtrcq1SK/qMxOU+nQl2MWoGQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2024 06:58:31.1464
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a2d4fde3-2070-4c70-4989-08dcd165faf8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF00004FBB.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6380

This series aims to improve domain allocator and attach device code path.
  - Replace custom domain ID allocator with IDA allocator.
  - Improve protection domain data structure
  - Improve attach device code path and replace dev_data spinlock with mutex

This series is on top of iommu/next (Commit 72e7bac4135e) and a minor patch
to fix protection_domain_free() code path [1].

[1] https://lore.kernel.org/linux-iommu/23a7c339-a7ba-447e-a4fa-935250f771eb@amd.com/T/#m870159022b8e1141d6b9c6ef87c6ee6821d0428d

This is also available at github :
  https://github.com/AMDESE/linux-iommu/tree/iommu_rework_attach_dev_v2


Changes from v1 -> v2:
  - Rebased on top of iommu/next
  - Minor fixes.


V1 : https://lore.kernel.org/linux-iommu/20240828134317.6239-1-vasant.hegde@amd.com/T/#t

-Vasant


Vasant Hegde (10):
  iommu/amd: Use ida interface to manage protection domain ID
  iommu/amd: Remove protection_domain.dev_cnt variable
  iommu/amd: xarray to track protection_domain->iommu list
  iommu/amd: Remove unused amd_iommus variable
  iommu/amd: Do not detach devices in domain free path
  iommu/amd: Reduce domain lock scope in attach device path
  iommu/amd: Rearrange attach device code
  iommu/amd: Convert dev_data lock from spinlock to mutex
  iommu/amd: Reorder attach device code
  iommu/amd: Improve amd_iommu_release_device()

 drivers/iommu/amd/amd_iommu.h       |   2 +
 drivers/iommu/amd/amd_iommu_types.h |  20 +-
 drivers/iommu/amd/init.c            |  35 +--
 drivers/iommu/amd/iommu.c           | 349 +++++++++++++---------------
 4 files changed, 188 insertions(+), 218 deletions(-)

-- 
2.31.1

