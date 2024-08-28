Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2060.outbound.protection.outlook.com [40.107.93.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EDBB188CAD
	for <iommu@lists.linux.dev>; Wed, 28 Aug 2024 13:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724852624; cv=fail; b=bXtST+xYzqXz2Yj+pjRhHkcykfcSLNIZBU+N70l/AdqE29UzDmk8unAnMhKr2E61vqEO9GzR50zxg/fPdt+upm5HLdsshfAh3e0XTv4b67qqMLVOghXSSBtyxsSwbWsFNue4HXKelrdXwesTwTDZ0T4Givmf3Bvwc2GS1xRsmlY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724852624; c=relaxed/simple;
	bh=guv0xA890NGakFWVojPK4a5ZPjE+BnYFm24i52xVPDw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=omJ48rx+eeZJCHizSxVjkLUehS0mYAG+5cHO80L50du9jBwDzQ2XrQindFZUQmWuGoibuiUAOuZmKOWzZNTb4IcH42lqYXJq6AtB46uD9qiOsPVeFSV6//kcbcVgndINxWwuRlEJoytE2JNJ1+/YY4wzegpmjVfDVbqkwD+QsL4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=yWRX0LM+; arc=fail smtp.client-ip=40.107.93.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="yWRX0LM+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=APqdIHSsefdTQfi6DIpZXp4IKRUrwTDs8hoBINP9DzSYmCZuSbtIW6oxjZc0wwqp37YpqHyrQNQmzL5wKePJCz9yaKZnX7QTg9EY//AxHdNu/ZoFs6UcQNYSjVpt3FQZKtZZr7itA6rT8i04fhUJNRl24POWt8Z4rhgj3kqpJdHKVH5TQ/Bsu1mOf4yemRHnXz9sgOleDboJcfgi+Ah6Pnrtl9hlAoNilxVhFT88scCVSZvVLkbv9hhz1SI2k5nqJOTocfLH/s8hEwCF5XpPXtGs+RHjYKnAg2m/hWxuG8AzSv3SArrU4sNmVZePZClIVRDtSN97e/5jpaCuZXcPww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ngv5cqdqHKDoUFUsiAfTMdXKhD2teAxkoTMufbXaKTw=;
 b=jd5xk2hETBeqhayZ41n5F8eZLmqUo7piRz4MBURqmlEjf4rvDARwuHkt41R9h6dhQmSQyVYdcuZxjT+M2RkeAEMlMrnaaMXL8BXjQH6gtimlrLbzs8N+md8zTlHe6Zih/snu5koCwPEj3jW9NsdBzhdhpURAk/bXTBTLs29sTPBHs3TWfDRKwh150YovPhm44Vg2sk4EcXRwx6qq4MQw/UloGrs+Z8jPFqvY7OBKTEaWvUAnPU4PNbtKQ/DiXXZw4lL9P9ZeANUrWpPXm7FQRNhkrfCT8Cfld/lr8Pz2SxJw2bOuYvpfjdFLCbi4IaJ0z5kje5m4bQPoBFVq0/pa9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ngv5cqdqHKDoUFUsiAfTMdXKhD2teAxkoTMufbXaKTw=;
 b=yWRX0LM+byYb0cj/Zhfdner0qxUuxYSiphnnyhX3lREb3FXWjU2/WaCQtVhlE1I+sY5cjSqrU0QCxcKb+Sl+QaXfvKZqLC1MuWsLi0wtbm4wOGtWLaHWUTNOy9kyOrK7UTN88FvevBj1smRQfk87do/qkP75Iu8HCvGb07xZJTE=
Received: from SA1P222CA0045.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:2d0::22)
 by CY5PR12MB6372.namprd12.prod.outlook.com (2603:10b6:930:e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.27; Wed, 28 Aug
 2024 13:43:39 +0000
Received: from SN1PEPF0002636E.namprd02.prod.outlook.com
 (2603:10b6:806:2d0:cafe::49) by SA1P222CA0045.outlook.office365.com
 (2603:10b6:806:2d0::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.28 via Frontend
 Transport; Wed, 28 Aug 2024 13:43:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002636E.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Wed, 28 Aug 2024 13:43:38 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 28 Aug
 2024 08:43:36 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <will@kernel.org>, <robin.murphy@arm.com>,
	<suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH 00/10] iommu/amd: Improve domain allocator and device attach code path
Date: Wed, 28 Aug 2024 13:43:07 +0000
Message-ID: <20240828134317.6239-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636E:EE_|CY5PR12MB6372:EE_
X-MS-Office365-Filtering-Correlation-Id: 948f94a1-6699-4a78-ed46-08dcc7676c18
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?y46Qm/OlDGlw2tKMmA5bGISPQcEjPR27HGY8EnJNuq34fz3sv7SKKeY0WH7M?=
 =?us-ascii?Q?mU1Z5Eg6/pA6UZclqiE00Es1XdQMEL+YWNotnGKC68HFL+unIXhd2osv/JxI?=
 =?us-ascii?Q?D/dAduL3x/GbKi8f+KXbJUl2zSB8a82Y4ig8P7vEKehbZC3OYOuuBrsRA6EL?=
 =?us-ascii?Q?hV+1HT0G/QxOkeZbPFeYgZZHzB/A0d0BFIPzp0cTDSh0Vk33eieWAZaXeiTj?=
 =?us-ascii?Q?8nAMhG/skGSKaGxDXFIkbp5AxQe8XPJCuBhLsMS+7VYJFbBEvwyszExwqS+u?=
 =?us-ascii?Q?mYtNUmGgmxyX/meeldqpb1aB9bQ+TQp1FltCfMYltE5aznO6qxbsKW2YDUZd?=
 =?us-ascii?Q?zLZloe5quNzDphN987q5PvZFfITcounJUac+Cmy9DxCcsCFJVhyHI6ksy68p?=
 =?us-ascii?Q?5ZvUS8+rBcWFCZefKqYNOFCtbymiR4Mjp9WazKDCG1WKkcaMUy9yXJXyNLrf?=
 =?us-ascii?Q?OkgOTF+vpIUWbOH12+uqJA7oYh3BA9DklKazemwsZ70MMeYUjQFPgy9DtV40?=
 =?us-ascii?Q?HmG/l+a6IDAkaj48oahoXkpYjX5/cNHgHmlotOWJfHZeBJlQHgAMK1Zg9jbU?=
 =?us-ascii?Q?WpR4Jh3ILZ6nVlfVNiImZO2LMbbxQENzJ00POOJJCFFMPwLBo+g8R4aoIC7d?=
 =?us-ascii?Q?ga4TyaZmUG+zqqUcgDocljQbz7j2cxkupDaOAsX03ZaBVAvrcFdV68aMz+bN?=
 =?us-ascii?Q?hTAQV4dLR0CYXinPd5x7Pf5/l6bFXQ0ipOkL7o0D+B+xjxUNK0xyLUvNAPCZ?=
 =?us-ascii?Q?sDZbzUOY0oZ+bIS/2byLgIHMZodgKP38FPw442++bX0cQp79eMrGk04xP4w+?=
 =?us-ascii?Q?oa3hgeyrNkCXAUStTKXa3Y5DkCd2Du/bG47rhiQIdJyWqZ7vxuX52aqlwAnr?=
 =?us-ascii?Q?W8vg4RyInAj+NIWQd4NLVU8t3hyKO4M8+6KYWTYnazjiiKz/qzXbGzRs8XeQ?=
 =?us-ascii?Q?FZfRngQsnjBkXwUBpqHNotiQ6nbPdAtUxCSNd1HkQT9ZOwWE3l55ZD/f0ahc?=
 =?us-ascii?Q?uZTDrGQ2euWx5DkPiO+6/JNJ7reIR/VgkPx6xyxELJRaRyZNrYdiZ5cWLAk/?=
 =?us-ascii?Q?7BfC9DnWS/noBs0W+yamJIpvoJ4RB5wZ9PFgc8j4RmKJSPPE+RJeT9K7hl4g?=
 =?us-ascii?Q?8V2i44yTpq58PXQzWZCLtPW4Sb7kZTX+l+eWhN4bXQQuKYssYnE53ZChnG0I?=
 =?us-ascii?Q?LDDv0IJSbVwklpHlTh6mK0HJ9EbTaYSIdO63MhctRv8T00TNOdjSnbnbTjBc?=
 =?us-ascii?Q?xuxTqzAlnlgN7OdOuL3311CJtsQGwCsFbxkItoPDgM2vuYKi7cgdQAonN1L6?=
 =?us-ascii?Q?WH4xYNYHnenVPB4sfNRD4/0/1kcrvfap3hFspi9JvkURSyR+5bgtbZLGyoOb?=
 =?us-ascii?Q?Q5ws44mQw7oYz2BLGIpcPjbb7SPOd2Lq77InBs3NYpnxPR1RmQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2024 13:43:38.8120
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 948f94a1-6699-4a78-ed46-08dcc7676c18
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002636E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6372

This series aims to improve domain allocator and attach device code path.
  - Replace custom domain ID allocator with IDA allocator.
  - Improve protection domain data structure
  - Improve attach device code path and replace dev_data spinlock with mutex

This series is on top of iommu/next and cleanup series [1].

[1] https://lore.kernel.org/linux-iommu/20240828111029.5429-1-vasant.hegde@amd.com/T/#t

This is also available at github :
  https://github.com/AMDESE/linux-iommu/tree/iommu_rework_attach_dev_v1

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
 drivers/iommu/amd/iommu.c           | 340 ++++++++++++++--------------
 4 files changed, 185 insertions(+), 212 deletions(-)

-- 
2.31.1

