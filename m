Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2044.outbound.protection.outlook.com [40.107.101.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF923207E15
	for <iommu@lists.linux.dev>; Thu,  6 Mar 2025 21:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741294884; cv=fail; b=HB0cUppMhTnXiUO9hK9crwBCaP7xDqhWfEXydC7/tUDJWbcA/rHSes8T3pPv0A93LrBUwLmZyRkaEwjqRjsYgAv9g5M5A7641VbKV4YXluFm+MZSNz+MQH6qft39b5uGkMSDkOe+5bITlOC7M0emoNz0ZBZKlQGcbVECrReVIxI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741294884; c=relaxed/simple;
	bh=yclrIAF6GrVZKNmYzNEXPdUqXlOu8Yuh0LEL85wvUE8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=f74BDlDtt+WoK+HvsC/k/amJwo/YaWayA8auT2smDE28B58Qi2E221/km5NqxWdmJlzjrdpNtBB5/fiYno3yAU8Kp8n4g3lyfxkd2dJQfkZ51y8Smss+ibyDPh7zn1uYH5toI/YzIjgFso7R3G80+lfORJu0W/KxzuJFeW4yYQU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ftrWd3p2; arc=fail smtp.client-ip=40.107.101.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ftrWd3p2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=njHypXPiA8pnW2QF+8rZnbeVuIM6GiKBCYHxNC6bNZ+LZZgSpvfQdAckRDtASHI5USWME+3VZ3DYmRFrh3svRmE4I+3jXnMG1CDZPCc3XfdPLlUzYx2Mgo9p/4VvFxYcidikfPt2aETp1XR+OFd0i/IrMV0rmXVUjeEhptruZKa1D5DbSiKDFUPgVjoQMJkYnVHAEWe5uqhevW9zVVe8kAYbQT3utVluGGZZeNP0V4tXpEyTMzxicOwk+A+Kg0jb46ioK4uWIV2nklcowE77UOkRxnh877hvgJY1SGZYjnEfi7oLcEJzALrIJnIQgdv9+BJsS2HP3F6LXttph3MlkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=klnn/TOFzm1LwmSpMjEwRVsDLm5JDnSDsdsgwmJGBU8=;
 b=A3oGWJtb/wXAyuTNixi3+SGpxNioOfcnEmBC19u8VDWfxnTlo2QsbDnI4ILHFpFU2gl/WEJiUHBk9Vxg9KVr6oiffsAuxw507pKLaN7egkBWlSBTCRUcEMGN3E63e/UpOcrE8r6MZyX8niTi6e/9aRuoOyKLlrdrB+pB6K7DAJg1diI4d/WKLHTqw/cmxX4FtGtzIs0lcRBjJUkglyoWQVGxGkSclS20a3yntueEePPbzGRFquUSTZxYtRGg+EFFo9Lqc7PlOXI1NfgBM3Bt8/tmIMNFryzBH0lX826Ffdm55JQwSEeVjeE16mh4ONyVKgmDx1L1htuuCDy1s6wcFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=klnn/TOFzm1LwmSpMjEwRVsDLm5JDnSDsdsgwmJGBU8=;
 b=ftrWd3p2z46ga3CHaiff3IkilNvn81oSjNeu4ptW56SYaWtmYlGaY/se2SJ+EQ4k9NBWLssnu7VT1k6xKBVpxzbPB+hGQHvpdEIpez06DgGGPwhSkJVoFK3yRDGAKyiX0Mx5POOXmubWiaCUCZVqqHVn7VGeHFdrU3VGlBgz/CI7qsGbL+P+pKBLoNIsQe1krQUYzRuT3eVZsL6qqXUPaovaFOThQigfEfZKi7024bWATvCNoYRBDZ/uiJHM9VcBZo39pJZdbZaTLUi3eXDM+B+jjeVvCDUuQ5E28u8Z67NL/gr9Pdr65Sjov6+qsR6G+uTpJ46VGlAG8Hde3a245A==
Received: from SA1P222CA0150.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c2::20)
 by SJ2PR12MB9137.namprd12.prod.outlook.com (2603:10b6:a03:562::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.19; Thu, 6 Mar
 2025 21:01:18 +0000
Received: from SA2PEPF000015CC.namprd03.prod.outlook.com
 (2603:10b6:806:3c2:cafe::84) by SA1P222CA0150.outlook.office365.com
 (2603:10b6:806:3c2::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.19 via Frontend Transport; Thu,
 6 Mar 2025 21:01:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SA2PEPF000015CC.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8511.15 via Frontend Transport; Thu, 6 Mar 2025 21:01:18 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 6 Mar 2025
 13:01:02 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 6 Mar
 2025 13:01:01 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Thu, 6 Mar 2025 13:01:01 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>, <robin.murphy@arm.com>,
	<joro@8bytes.org>, <will@kernel.org>
CC: <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 0/3] iommu: Clean up cookie and sw_msi in struct iommu_domain
Date: Thu, 6 Mar 2025 13:00:46 -0800
Message-ID: <cover.1741294235.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CC:EE_|SJ2PR12MB9137:EE_
X-MS-Office365-Filtering-Correlation-Id: 92ec067f-4d9d-49da-fe20-08dd5cf20a70
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?x36PVBX3yXo+u9yxx5FrIt6hk5m+NArDMjdNayFB4Y4mT9lesNc9sMInbC0l?=
 =?us-ascii?Q?pmZgM+/FcwLs2WXA5dlcsuuWWVWNzTY11yb9ugUhIHoXW3G3xabLirrBPdy1?=
 =?us-ascii?Q?agw96AhVD8bpoqmzy7DljPUyf08aPDiH4gp8gO7AWUfoUfEv2mHvxxpl7Rug?=
 =?us-ascii?Q?Sg4O6dduKRT0TFotTbIhe8uexcyIeM8ZY2IZ7YZGCbcUgOgcb7tdgsPMc9j/?=
 =?us-ascii?Q?Iw5mZ5xhsAzBodhmfDoSDpcaObc6tdo1Z9+nr1v4h0L5EFtnfYRXhU+vfyNO?=
 =?us-ascii?Q?LEyExbFCrhUmGgEMMuWdF1yxDEOb9POsseLmZu03mAS2jK/6bT8BjnTegkjD?=
 =?us-ascii?Q?otlz6jahDN/9Yc+VvB1/QdyC4AKvySHEm6yKhckMm+oGFOjp5qcJyZtgRbED?=
 =?us-ascii?Q?jxoccAZwYehpMbTitcstCTgUvUdS77s5VJLq6fz9oKVAsFkYCZZvtjsslhCJ?=
 =?us-ascii?Q?3LVdMMx1acloSD/UZQruBHJVoaHz3MxxnOCOYmj3p2kalP4xy3welU9bRSM6?=
 =?us-ascii?Q?ELeGkQL/2MDiFIU7LhBIyx2QBEbRhqaTsH6jFVdnQHu6IEr3Vzvkq2lyvJza?=
 =?us-ascii?Q?YLtoiuKiY8+Yp6LCbmUcr47ZbKdDdksrqB5xTicRHrOuTSj3vxrU2l1keq9d?=
 =?us-ascii?Q?FwBS9W/s1fi//ir1vyPnnFxgS/TqZLXOiPImb42yBsyMwzc/0TjzHiUn5lo+?=
 =?us-ascii?Q?Hf1lGmzJ3QXke7AWaeWHg4FaLD4ZcMtqZdlkivaCDtg+hS7iXcRfCZ0eJZDQ?=
 =?us-ascii?Q?jvfI5l54lU3x0+WNQ/i6U//ZSjP7TJb+Ck9RPLAoyJtGXIE7qT/DOPR5kY1F?=
 =?us-ascii?Q?lsoG04ONs07soBeyxZfg97gFT5d+mQRNRxr9oPSN8ft15rNeODtpF1LTiiFz?=
 =?us-ascii?Q?+z3I92ftNZgmlih6mrOC4+85bcYyAeiP80SZztklfzN6bdlxW+Ye2SlK89uE?=
 =?us-ascii?Q?bjFG6tk1Q3D2xtVnjiroltMiqsPYIJtrJrQOo3LfkgH7tyayw34Y//30Nn6d?=
 =?us-ascii?Q?jCxGEjoNc896td0vNrykPePQY9t/HhP5XMH9gRHgKzoPG4adQI2WrKGV0Ish?=
 =?us-ascii?Q?N/oJ5EejiKqbCGEe3ClLlfaKBjDofr50U2jo4bM5dUDV34XneWaDz93JeDE5?=
 =?us-ascii?Q?hf+xUzXCmwRRyJiJ/Wq0hjxHHGUnyOJkv4H2gPMJh4TgzwRJHdoyGdVyNlso?=
 =?us-ascii?Q?rlQYi2k83Ge5lLYG1blrr5gY+HEBxlR0d83nzW7J2ymLPxwhf6NzkrK90N0x?=
 =?us-ascii?Q?p/s91O1M+PFOcN7juH+44bf13Te4wMHki0Re4d0vU2lkQ2m6ZquNXhwJzXnp?=
 =?us-ascii?Q?wPFBPg57zPh1ZgLUFlTv7k3sZUsLa48HtfaO0vfWYuFdI8dXp0R73vIc6Dsw?=
 =?us-ascii?Q?C7V3V64LWBPiOGv4nUs8W7bDHtXB49LMM++N3U53npXlq1xQR4vLIiuCLRAt?=
 =?us-ascii?Q?OzinvMd1mw3O2famWHumqrZ8dSBn3KR5QfdA3fUjsMCJySb3Zj/vpPA4z55c?=
 =?us-ascii?Q?quUFoHLlyEYqpgA=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 21:01:18.1934
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 92ec067f-4d9d-49da-fe20-08dd5cf20a70
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015CC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9137

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
https://github.com/nicolinc/iommufd/commits/iommufd_msi_cleanup-v4

Changelog
v4
 * Rebase on top of a bug fix for hwpt_iommufd cookie
   https://lore.kernel.org/all/20250305211800.229465-1-nicolinc@nvidia.com/
 * Add Reviewed-by from Robin and Kevin
 * Add missing "break;" in iommu_domain_free()
 * Drop "linux/msi.h" header from the iommufd/device code
 * Set iommufd_sw_msi_install's SYMBOL to "IOMMUFD_INTERNAL"
 * Update commit messages for typo fixing and size comparison
 * Add a local msi_page_list to cache cookie_msi_pages(domain) return
 * Add an inline iommufd_group_setup_msi() for !CONFIG_IRQ_MSI_IOMMU
v3
 https://lore.kernel.org/all/cover.1741034885.git.nicolinc@nvidia.com/
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
 drivers/iommu/dma-iommu.c               | 208 ++++++++++++------------
 drivers/iommu/iommu-sva.c               |   1 +
 drivers/iommu/iommu.c                   |  35 +++-
 drivers/iommu/iommufd/device.c          | 131 +--------------
 drivers/iommu/iommufd/driver.c          | 125 ++++++++++++++
 drivers/iommu/iommufd/hw_pagetable.c    |   6 +-
 10 files changed, 320 insertions(+), 255 deletions(-)


base-commit: 4b022ff93d8b332891cae818a7331942db50610f
-- 
2.43.0

