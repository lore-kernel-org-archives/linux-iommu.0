Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2082.outbound.protection.outlook.com [40.107.243.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D87523645F
	for <iommu@lists.linux.dev>; Mon,  3 Mar 2025 20:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741035198; cv=fail; b=Ufl8GO5BvVS3fDLrySGOfDbfWwSu6l0TDDBjQ407gpalNJh4VV7aVihwpZmHmmn++WuRlPbxgvuwEcepsnLH0SL8zUDhhHlRQ799SA2ZIm7q01QEladtXgHIACOpFYVn4iOAgodKo9YhNbeMRBCVtllFerci2IXYxRqFzmpstFc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741035198; c=relaxed/simple;
	bh=1lt1VLTBojY/8O3vRC1xc8FeT5cUi+lolEEJUBR+R4U=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BuEfZOpbY4e2meUiNXmAH9XoOzE1VZWs6Og+0kRm8QdsJLwcC7fZ6x8s41fkyZQkKHS26p+KxPJWdvH0t3+Nb/hitpvp2ePChzuVvIX1mfAPLK1qhBs7rs/niI7EnUg56R9twQjPDIEzQjU1OWxhXF2eof0vkUDz6outzmjUNR8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=k9eOo8eD; arc=fail smtp.client-ip=40.107.243.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="k9eOo8eD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vWPP585vm6hKTgwxj61NZlq81KThLYP27arrRyRaboJuJ3ssDE8inNP4ftMz2GeeaZQYr3t67/PWwtXU68sZcKRhENrsfG3jyWmNsEgiRwDcouXpXGzh/HlogiZPGY/vcqYX/dgXU7XnseiBM7ApKX07lIRLjfcbgkdbeZgIP+NuAHZzBsBhAzh3EeEz522z2YuEKnhbqS6U3edk4qsHFD0jy0mXYHdl0NQJOKjnOUDw9UkQe17ZOG8nF+FlThOa9/R/ZNDVi9pA8eQuiRxsdie4homkBJbaiEpdNWM8X0nksBhtduOtj4txDbANZ37vEu4eFh82P0A4AfEhOUox4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gJfTUk5At8jqOLiem5U/lJN25OidUdxLoqk5UGBk+Fs=;
 b=pdLluKtiSJY+WLvo9NXk1seogkQPAUa49i7PyNDgosH6+24ZyGC2TPO1niHZ4j4AwQxmhhPx7dKIIyAHsRNBfWB/xKlpoY6cqaeT88AqCHj3z8pPft0M0GohkmQ4KijIys30E3Hod67UvbRG0S4kMgpRtGz9BQu78GyJ7CQDnnvef/hj7NwS7/MAQIRxcb5HVleffjpWHkdnS/H2kQ8NAfd4LTXUG4jqlAVNf9YL37qsjDvOQQ9V9H5w4s0j2ZvIegH4sT9eAs1dbgQA5ADKQJYKA4Y32l6pfsgWDFdDhauIkApjXLlth8WrGN7xseAnzSHnqrAGsZ8PNx+qa5cmMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gJfTUk5At8jqOLiem5U/lJN25OidUdxLoqk5UGBk+Fs=;
 b=k9eOo8eDjnqcqg3BcOSl9fHDK9l9OJnel2yNmO/YV0UUooDVJd3PA5214BEcUsIGNflKVl5EXkIRwLROkrqUryz+k4xDOvaT7RF+KDe8MMl8WuN2vYlGnGUqUDSNK8Db61J8igYjHeahKUVeWqnxxnhmse/M/UbH1eOx1v+nKF56I0C0U0VnLeKkZUyFMNlh1oQXkwU2BShYgCJzMXzJrbqRpC/kre5BMjXwQwc57V4qYwB1+1THn3AIMO1qg1gysy+ysp6p1cVmhlZWPixqkRxOZWCGcfmXF88cAGOSQ98b59znrerKAx/k3DNNJxBLbvEGF6ewZvxfJJPORTvwNQ==
Received: from CH2PR18CA0008.namprd18.prod.outlook.com (2603:10b6:610:4f::18)
 by PH7PR12MB7985.namprd12.prod.outlook.com (2603:10b6:510:27b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.25; Mon, 3 Mar
 2025 20:53:12 +0000
Received: from CH1PEPF0000AD7B.namprd04.prod.outlook.com
 (2603:10b6:610:4f:cafe::cb) by CH2PR18CA0008.outlook.office365.com
 (2603:10b6:610:4f::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.27 via Frontend Transport; Mon,
 3 Mar 2025 20:53:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH1PEPF0000AD7B.mail.protection.outlook.com (10.167.244.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8511.15 via Frontend Transport; Mon, 3 Mar 2025 20:53:11 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 3 Mar 2025
 12:53:03 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 3 Mar
 2025 12:53:03 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Mon, 3 Mar 2025 12:53:03 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>, <robin.murphy@arm.com>,
	<joro@8bytes.org>, <will@kernel.org>
CC: <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 0/3] iommu: Clean up cookie and sw_msi in struct iommu_domain
Date: Mon, 3 Mar 2025 12:52:49 -0800
Message-ID: <cover.1741034885.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7B:EE_|PH7PR12MB7985:EE_
X-MS-Office365-Filtering-Correlation-Id: 6dddafc2-1cdb-4c3d-faa5-08dd5a95694b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700013|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sCY6nBaUFvOeqe81IhIuAb9YoR/vElFampxj8cliPnvmxsSpwbDyDe3W9Hhh?=
 =?us-ascii?Q?T/GB701Q29F8jVS8zo+gaPIU18m3b75Nb7MIm1hTNX3HzgeTCGoIGVap76XX?=
 =?us-ascii?Q?hsy4zUOr4g8BVpN9V7oigEsCKVjcI1Lp6taHJxyHlmWD+aw9gr4eBtzOnTxI?=
 =?us-ascii?Q?1S3ob6ImOeiBjBJN/NKV0KTpLvo3SvOSQ8vpc3It82lW4mdamIkPQp/CQLM/?=
 =?us-ascii?Q?NKnwoaoNz5AeOKxKdUBmLQjmpx9EdxckW86jb+bYIVHmPo+xKLvUbd2Sk9Po?=
 =?us-ascii?Q?jQMqx55EtvYYQntoFCEJeRh6MinY0fSldSiJ1YGgNFQvl0m3je26vZTbKGX2?=
 =?us-ascii?Q?W/ckgnRRU9ZST2BjHcYA8fyI0auv1gkObPvN7tkr7KMD//soDKU0csTy1wrD?=
 =?us-ascii?Q?yC95wQhLFw2du4xgGgtT1r2BgFsR9ieNmFfyqtYTsbmvg8VvUjsss4OdlBcG?=
 =?us-ascii?Q?nRZ+WvN4HceNJXou1l/E2coy4B7II3jN9WXhnJi1p6OHN/rRlLHATD2nR5BL?=
 =?us-ascii?Q?qEt6DUPik+V7edfsCZR3kVMIA30CZQyFC8t4NcAghhJwhXbo9//aJfBGVFBx?=
 =?us-ascii?Q?l+91WhPVmvDnravHRszX/7ldHzXdkdKrjNKM6kincsR4t/YM6UOhHBBDDEcG?=
 =?us-ascii?Q?gj5o7NUKOtkh89tuy/Wma7H6kaWYMbUerKx1QOJkTCKbYSmM1a22UsJc1uQV?=
 =?us-ascii?Q?HYZRWY8yMPR8d7Qc/fr9MvUnt0h+YcQgYbIl22Ev6JvLPe9+zuDJnJGdXn/F?=
 =?us-ascii?Q?aZWMPDeXT6fivm4KrH5T+LeMI+3PxdbYzcbrbvDhx+SOCAE5NJ0JbuWldi7X?=
 =?us-ascii?Q?9JeOzs5Zq08rKjrlu2FgpyaR7tQPdRef+EP6qv1wfh0bcGOZFPk5h6ghJqBs?=
 =?us-ascii?Q?/pSEJQ6pm7C/Nfbo14o8kjFWySn+mWXJU2KGBduG1baGLeM2n/cVYidMlJcG?=
 =?us-ascii?Q?hljEsvLiX20rLfC5x5QKFtyMLpIUsUWV6hQAcGenaP+FQ2hv6Xnd1aq+/sJa?=
 =?us-ascii?Q?qpFMExe0zs7kNQYLZ+5fEvUQJ2WNJCk3ksgcfnNLOwUJw6BAJ1l/DHZ8+lIS?=
 =?us-ascii?Q?PbD0a1x0twkYak9ZOsVtY5H6SyMCoIImWHHsvZK3iM/a+6iGm6WvocEa3hqL?=
 =?us-ascii?Q?gKglPGB8x2fU/DKPR1jUqMLWpG10PRmYku7NHg+DcjeygFJj/sDYOR0Scadb?=
 =?us-ascii?Q?oSZy5DKXFSUFuaYNNJwq7A/rOcQ3KCQaj+oBfwZrsXTZuYinzAEiVQU3t8FK?=
 =?us-ascii?Q?RSO7TYi+4MEe9zbGGiHJHLCkmF1FNzYRomxJLfTUppj0NuH5UX9Z2PiN69Gq?=
 =?us-ascii?Q?z22GCP5q/XEc9ULgQ3seG80gwr0ZwmsjWCLKPBd7X3zDSVk6TuQ4Vphzdz6r?=
 =?us-ascii?Q?2CKzvyvxUPsXef/0+p12yRzCDbRS3YSBF3V3hZvmM1G5VOCwosC/AciVX28V?=
 =?us-ascii?Q?4wzgK6nN1Su3G0YZi4XFQdWxCVY6N/jTyT29s38rJ954ohOuIiOldDYxG7yR?=
 =?us-ascii?Q?NYtGIV5aVIgKzXQ=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2025 20:53:11.8442
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dddafc2-1cdb-4c3d-faa5-08dd5a95694b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD7B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7985

A few things in iommu_domain structure (such as iova_cookie, iommufd_hwpt,
fault handler, and etc) are exclusive to certain types of iommu_domains.
So, all of them can be seen as domain cookies in different cookie types.

Furthermore, iova_cookie is shared with the msi_cookie use case. It could
be cleaner by decoupling these too.

Define an enum iommu_domain_cookie_type to fit all those cookies in.

Since there are only two sw_msi implementations, check domain->cookie_type
in iommu_dma_prepare_msi() to call the corresponding sw_msi function.

This is a clean-up series for the previous sw_msi Part-1 core series. It's
on github:
https://github.com/nicolinc/iommufd/commits/iommufd_msi_cleanup-v3

Changelog
v3
 * Integrate Robin's patch
   https://lore.kernel.org/linux-iommu/4e68d5820be06adc1b34fc0d1c9399481151daee.1740742271.git.robin.murphy@arm.com/
   replacing private_data_owner with the new cookie_type
 * Move iommu_sw_msi stub from the public header to iommu-priv.h
v2
 https://lore.kernel.org/all/cover.1740705776.git.nicolinc@nvidia.com/
 * Drop sw_msi function pointer
 * Add a new private_data_owner tag in iommu_domain
 * Let iommu core call the two sw_msi implementations directly
v1
 https://lore.kernel.org/all/cover.1740600272.git.nicolinc@nvidia.com/

Thanks
Nicolin

Nicolin Chen (2):
  iommufd: Move iommufd_sw_msi and related functions to driver.c
  iommu: Drop sw_msi from iommu_domain

Robin Murphy (1):
  iommu: Sort out domain user data

 drivers/iommu/dma-iommu.h               |  14 ++
 drivers/iommu/iommu-priv.h              |  13 ++
 drivers/iommu/iommufd/iommufd_private.h |   7 +-
 include/linux/iommu.h                   |  35 ++--
 drivers/iommu/dma-iommu.c               | 207 ++++++++++++------------
 drivers/iommu/iommu-sva.c               |   1 +
 drivers/iommu/iommu.c                   |  34 +++-
 drivers/iommu/iommufd/device.c          | 127 +--------------
 drivers/iommu/iommufd/driver.c          | 125 ++++++++++++++
 drivers/iommu/iommufd/hw_pagetable.c    |   4 +-
 10 files changed, 313 insertions(+), 254 deletions(-)


base-commit: 5e9f822c9c683ae884fa5e71df41d1647b2876c6
-- 
2.43.0

