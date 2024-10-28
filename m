Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2055.outbound.protection.outlook.com [40.107.93.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7CCD42A82
	for <iommu@lists.linux.dev>; Mon, 28 Oct 2024 11:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730115139; cv=fail; b=V6Cs3YgXKt76YOdC/5W9K5UJnWhG7gjBCm52Opv20e19GuwACRM0ZRIGL+ydgmVbw8fzdaH2m1cireobA1fgcSuCv07eCfKN/an+FFXUeLhhxqFNjQYFPEmGOYmJ1GAhbD+0clU2K53+TzWPnLU70uaq2eBTNsdSJXKUm9GU3GY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730115139; c=relaxed/simple;
	bh=NZn94IfeeGOJh/VYh0GD0T3YK+hz96ikLJfUoguAAuE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=R3A9BGny3DGEFsuXMzD+Ue5J8pH0aNEUReZSovCQwHSojbjNpULSQY3hMALLshRR/8BFfqKsMwS+rP8YmI/KBfvoWULRsIzzfcJK0EcgG8frv4vtn2QigQSq72WieZTfMEI7w4xHSctRgT0mtVO+ulXDsnR1f2gPnn2JUePGJeI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=lcuWNQX8; arc=fail smtp.client-ip=40.107.93.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="lcuWNQX8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vAIy3jHuzqy6OV5bqhw8nte2zKirICFpTkNr0TQiNBcs4Mj0bKECFlYw9LV+LUm9Tyq1hytXfPc81xWK1cIleQb+wE4t/Jyn+koXOrdk9fwZ7iy2JvlYvEvvOU311YYrVxrgpSw8gzfxTabQq4wxjTJd3LYbOcCqLN8natODsAVOx0jktTDiOXIpi2hHcoSpx4pSqAXIpIueY1wy4gbokhkn5NJewRx8b+5o7sdIQMqrboZMQCgWGHfcDjWyttfFV6sj0L865I4g6bgb39FhDYwAPe7cZ8+Ln1Ma/Iviuz5eWGKlBZL4sXHBzwg251HMHtHv3em2d7x5pSPLdN4w0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uW77YWMRJaCwCeoXET2KKrPQGNgUB4X7S7hjpPapjPw=;
 b=sBzZW8E8YZOt/AKQBvcOfvoE0TPMgrV+G1MruNA8NcT80fQ5dCr+oLMFgCbQODzfTo2owyXeMbRYqWYx8cnTmJen5Su4k2K4d/pliED/SUhlXMLvvs09o04au8G2ZG0TimHTLESOpYmwnCizEMze82eTmwMBKeY+8/qdYtkAMhEl/uyMDuofLKXJhV35/eW6ch/HjsAI2WEkro/IyBQycHddnTSZYusbYwADy22Ya9z0GZUCJNklSFH1VB2rmdcQ4rKRV1vdSnIFTUKs3kQ9h65mC/s0mueFSbm1bT0HDIx+RL1N/9l+OubUmc67iOEV1DRSsFWa+OanaPZjlSc6gA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uW77YWMRJaCwCeoXET2KKrPQGNgUB4X7S7hjpPapjPw=;
 b=lcuWNQX8p001Cf0n+RXBaVPb/OvkXWT2F5vmwaACH+xZBH3SVUzdizuWyJ6I8iUDxafLSTpWKjwFyJmWA9NkEAGbuz5K4QBKoZ7CJ3FjWPwbDoTUD3olqfqz4Jj/U6lnV5ZujFMgvIdtpTRZSPVXcVmrxHM/QER9nkFM0W/hYQw=
Received: from PH1PEPF000132EA.NAMP220.PROD.OUTLOOK.COM (2603:10b6:518:1::2e)
 by SA1PR12MB6972.namprd12.prod.outlook.com (2603:10b6:806:24f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.23; Mon, 28 Oct
 2024 11:32:14 +0000
Received: from SN1PEPF000397B0.namprd05.prod.outlook.com
 (2a01:111:f403:f90f::3) by PH1PEPF000132EA.outlook.office365.com
 (2603:1036:903:47::3) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.21 via Frontend
 Transport; Mon, 28 Oct 2024 11:32:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000397B0.mail.protection.outlook.com (10.167.248.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8114.16 via Frontend Transport; Mon, 28 Oct 2024 11:32:14 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 28 Oct
 2024 06:32:11 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <will@kernel.org>, <robin.murphy@arm.com>,
	<suravee.suthikulpanit@amd.com>, <jgg@ziepe.ca>, Vasant Hegde
	<vasant.hegde@amd.com>
Subject: [PATCH v4 00/12] iommu/amd: Improve domain allocator and device attach code path
Date: Mon, 28 Oct 2024 11:31:36 +0000
Message-ID: <20241028113148.5774-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B0:EE_|SA1PR12MB6972:EE_
X-MS-Office365-Filtering-Correlation-Id: abff6000-08bd-45e4-3c73-08dcf7442ba2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OU2qOlSHjOgU5Z0xf/8/tKKOiZsdebQKDEykLh3vwEI6dSbsNJct6Mz41Tuf?=
 =?us-ascii?Q?a+RM3woqUfDrdupSxlAVPt/4gG6kwEa2AW4JKnPI6VJ6TlB6Ax+u/j4WRfbN?=
 =?us-ascii?Q?XUCeY2reZUjdkCRympxbSWTDkcWOZNTDt/UMYsUbYIGNsPaxjzyFW/zJdtn7?=
 =?us-ascii?Q?Rd49pR3jgKrkOOVM23B7TnBn1w0HHqZr1LiMMZ62mV5NonMtd1nFtOm244Do?=
 =?us-ascii?Q?pGFRpNlsV09OzgRCvGv7BfHpxkh2pPYVPYOxizdsC1/28971fL8Zwu52TViY?=
 =?us-ascii?Q?qEcSK7a0jhT3QXswbcA9I0aMawD5YyE+jMVofBUyT/Xi9gMfgBHSFc8YyMEB?=
 =?us-ascii?Q?AhAZc5k/0Mgyp2KEVg5wC9rfW6whgO3mEVV2/PS07qYefBnTNeyhNnbHFJ5k?=
 =?us-ascii?Q?8xzPog7DZRoslnTu47iMdGoBzm7RRuVFiqyQSUU7ChPGDm4qMOlGlRJNBjdT?=
 =?us-ascii?Q?EkiS9zcO06MX3XwKAQiG6wOZhJl+yAzBM+jmuslFfdwRFJbgtMy8YJ9jdsNP?=
 =?us-ascii?Q?4Icif7pZnmBg2JCFKXBpk3Q/EhRXX8ILdRP0BD4pY1O5l8G5Kxi0mqqVpOSE?=
 =?us-ascii?Q?SyAhkKgBvuIFHuoCsV3RtdNolRB/ZLAe2rnUT6Hto+micUU3Q0K1qR0k9TfF?=
 =?us-ascii?Q?0pAKxyctkCtWwgw1ipU027Pc6ymZng6GLacsouxeb9Ebjv1jcTaDewmJgGIn?=
 =?us-ascii?Q?kGK+8jvr1oZowqx12wmQJpCkK+SVsN+U3v8Pxh9A5N3BarkPWv6i2DSeKjjm?=
 =?us-ascii?Q?sKEc3/PLRkRLLRGw8RUGJV6pLlNJJ2rfpla6NGPIj7w6v9F4MqOURKlMPM1g?=
 =?us-ascii?Q?wa1mA8YGLS/leiVd8EOCDnr9fXnb+8A/Pij98WHK65yc+yUovVTztW4lrr9v?=
 =?us-ascii?Q?XLJvR8nqOnbYVKeHsLmn6Sz2cPGPEuSRkjVPGnOx9LchoSXYdOpsNCxhzEHo?=
 =?us-ascii?Q?83uTDDzOMIRppERt5T291QxlQPaRWLop6dOi4U6lkzbNHPMD82Kp5pX2/eCT?=
 =?us-ascii?Q?tgVPnsKg6gk7NWGPuBUnUjzSDyPiNZ9UwUX7xakfr/x8ASmCcyXYxCsPZFex?=
 =?us-ascii?Q?ZAWl2roc9xxOEuE7z+aNFHQt0GRemt0JhG1UY/6Jsh5rJrLpFHGbm2T7T1mE?=
 =?us-ascii?Q?jMm5WPx0ZCn1YgpZaKprgj5xm33yO3O/SYUnU+CeQ21W/40yoZFbK+CDHxJT?=
 =?us-ascii?Q?+6gql3uQNYhwgp23Slpi3UjBhU5oIcukRxPUUZNo0QGDphdK3skuELXbGzxf?=
 =?us-ascii?Q?W0fLLi0fMbJvauKMZJ2VqvRDuqOE2/W0JUX9alj2CeirIji6nLBahred5yGP?=
 =?us-ascii?Q?/r9eI993CA321vRT5QsOFiRMvdAC53KtVXJ94a009j5psNtuPGuAF31YcDfs?=
 =?us-ascii?Q?aRmlG0k=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2024 11:32:14.0875
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: abff6000-08bd-45e4-3c73-08dcf7442ba2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6972

This series aims to improve domain allocator and attach device code path.
  - Replace custom domain ID allocator with IDA allocator.
  - Improve protection domain data structure
  - Improve attach device code path and replace dev_data spinlock with mutex
  - Add ops->release_domain() support

This series is on top of v6.12-rc3.

This is also available at github :
  https://github.com/AMDESE/linux-iommu/tree/iommu_rework_attach_dev_v4


Changes from v3 - v4:
  - Added release domain support
  - Added new patch to fix missign lock in pgtbl_v2 code path
  - Reworked protection domain ID allocation code
  - Fixed missing lock in TLB flush code path
  - Improved amd_iommu_release_device()

V3 : https://lore.kernel.org/linux-iommu/20241016053501.97497-1-vasant.hegde@amd.com/T/#u

Changes from v2 -> v3:
  - Rebased on top of v6.12-rc3
  - Added Reviewed-by tags
  - Updated patch description

V2 : https://lore.kernel.org/linux-iommu/20240910065812.6091-1-vasant.hegde@amd.com/T/#t

Changes from v1 -> v2:
  - Rebased on top of iommu/next
  - Minor fixes.


V1 : https://lore.kernel.org/linux-iommu/20240828134317.6239-1-vasant.hegde@amd.com/T/#t

-Vasant

Vasant Hegde (12):
  iommu/amd/pgtbl_v2: Take protection domain lock before invalidating
    TLB
  iommu/amd: Use ida interface to manage protection domain ID
  iommu/amd: Remove protection_domain.dev_cnt variable
  iommu/amd: xarray to track protection_domain->iommu list
  iommu/amd: Remove unused amd_iommus variable
  iommu/amd: Do not detach devices in domain free path
  iommu/amd: Reduce domain lock scope in attach device path
  iommu/amd: Rearrange attach device code
  iommu/amd: Convert dev_data lock from spinlock to mutex
  iommu/amd: Reorder attach device code
  iommu/amd: Add opa->release_domain
  iommu/amd: Improve amd_iommu_release_device()

 drivers/iommu/amd/amd_iommu_types.h |  23 +-
 drivers/iommu/amd/init.c            |  37 +--
 drivers/iommu/amd/io_pgtable_v2.c   |   3 +
 drivers/iommu/amd/iommu.c           | 359 +++++++++++++---------------
 4 files changed, 193 insertions(+), 229 deletions(-)

-- 
2.31.1

