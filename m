Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2081.outbound.protection.outlook.com [40.107.236.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D57B6223DFB
	for <iommu@lists.linux.dev>; Wed, 23 Apr 2025 06:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745391024; cv=fail; b=c0ThhuEqcqFdhKUPN/W2pI042erqyILMlYTfeJwHjT18Du/vE3qVIAsL35JsYYXUl9UUjT4E012OJqudjo0EqAEOFsRg6ttbT0sl6HFcMUH5B37h8HzJduZuaMGIkVArkiuf24oPrFV9ePoQBJZ15tdSuSF9h7S7dR2h5ASE+wY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745391024; c=relaxed/simple;
	bh=5ZWxQC1HLR0nz12my6TG5vQO/Nc99R0lcg0Sb7Its64=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dpAicnq8atN3Cj7iodEHTWqSMm5rsV8HILuAE+RE790Y4blkwuZOFmVMTjqxsDgFRNa1kfl76v6z6XCQxc6mdr4EAC+bASFd2wOPObMoOc5J9753VffpS0fl2RE+S9xigPKTXRObX277jXxasW/MjyC6DMJj7TU7T5qIHX28ekQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Ah7u7P3q; arc=fail smtp.client-ip=40.107.236.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Ah7u7P3q"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WsERsQbpxyKUPRbm9vw4euRYyoKRtAPHhdOyK64vaGcPdy+kqEAYcpE+DNg6BBWMXI7C6ZzAkvalIICoovSX9x1f04sRoMxxxIJk6/UrGayNideCqgQc6eQvl53eXabUfDC7HWuAMAsK6UkMbicwWwQJh0WuHcEcpIyXV0o8a4Bb3AJ4dpg2thUGtEZGaIKI94CHqD0X+VfiQ+q9C7+XVnpMjougYW8trDKCQ+rzpcefxSa6YzqbLXYDOyShQYgdcCqU8iZUBL+iLlOLoyP6qtxEjFgl9IIena0IC0Dj71FQMsSikR7Z9UcKWOCuLNQ66WyKmw9KDmhiypkDFKLjRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=REgGOEY1JcBaO2PuRwZsCK1IsSxduTYqqv+tOnD4x9o=;
 b=ojO255DphRDtZubZPCd2hmWAEzIbWA4EQl0v7v/5f/xrzVIamm7OnK1SWtoJQyvAT9HZ2+T0lmno0hk/9MZP/Jc/mNaq8pgLeKobbi0e1ptHyVYNqENH7QyQT/nyRqfpwCfwOHE9YRGZh6R2kzrxVkjGBHGSlGmERVaSxogXDg7gNTJ8uILzpidE8kbtMqYnKcRbHoqJ6E5N+6+gqvjmMULAFqwJ7DsWNNRVp6Zh3+YUcDG+42D5sNh9OYyb1+NAORXE2dTYuW1GqCyffIyCLTLQsiJ1o9E1g0q71NWIIDtwb38YHeQUykep9M6mGrxMcN2QnHkWnhOJk1gYhBEqKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=REgGOEY1JcBaO2PuRwZsCK1IsSxduTYqqv+tOnD4x9o=;
 b=Ah7u7P3qbeuGUyLx2M165GC7QEOWTu/EQEmSS9eP8PoPXAU5OA1XVW0VhuNxNgLR3VwvslRAFyaRzJ0903eLEZPAsSH4nUiaKfa8Fxn3EFuvR6Dpg2/5RriYHv057aAqajgJzVtqx01HmlVTnSrymkiK396DDh+Hr8PhTzfB/U8=
Received: from CH2PR18CA0009.namprd18.prod.outlook.com (2603:10b6:610:4f::19)
 by PH0PR12MB7929.namprd12.prod.outlook.com (2603:10b6:510:284::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.32; Wed, 23 Apr
 2025 06:50:17 +0000
Received: from DS3PEPF000099D8.namprd04.prod.outlook.com
 (2603:10b6:610:4f:cafe::da) by CH2PR18CA0009.outlook.office365.com
 (2603:10b6:610:4f::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.36 via Frontend Transport; Wed,
 23 Apr 2025 06:50:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099D8.mail.protection.outlook.com (10.167.17.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Wed, 23 Apr 2025 06:50:16 +0000
Received: from BLRANKISONI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 23 Apr
 2025 01:50:13 -0500
From: Ankit Soni <Ankit.Soni@amd.com>
To: <iommu@lists.linux.dev>
CC: <suravee.suthikulpanit@amd.com>, <joro@8bytes.org>, <will@kernel.org>,
	<robin.murphy@arm.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/2] iommu/amd: Support for HATdis and HATS features
Date: Wed, 23 Apr 2025 06:50:01 +0000
Message-ID: <cover.1745389415.git.Ankit.Soni@amd.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D8:EE_|PH0PR12MB7929:EE_
X-MS-Office365-Filtering-Correlation-Id: 60e5cf19-20c8-4e73-f6bf-08dd82331b56
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6VSb53FbhRHN7ZM/DZXLX9b2voNZC+HXZ/JEhzkvmwU18kdcLvcPw5hyke/6?=
 =?us-ascii?Q?S2kqQGkXGbcsENKzQ1sYJIIkAj40hGtDL7prc99AumvhAAaW3wPM8DdPS6T4?=
 =?us-ascii?Q?P89IWoz1rUntriDJNSvVgOlQ8MoEqfjhQjszdl+eqH4VfgzHLUtL7aeEtuld?=
 =?us-ascii?Q?1M1oo0OKHZ7PU5hfn6fNcqK6BZtYBVoNdLx+mNkMO4qta7ALLPn9RKAk4vy2?=
 =?us-ascii?Q?SIO75MxU8E6EiLzhmxXIhpvkSJKqns3PK51XdhSu5Fqd978zLb3beNJXH5w6?=
 =?us-ascii?Q?uCdVpeon0haAsungyoWTK5C95wj2ZkDBCUGl0j4F8c46RtY/oL29n4zo45g+?=
 =?us-ascii?Q?P9uGAJH9GEHHLqcJXSoT6kiJVKFOfRC0+mVc57SJGXPb+pLNs+MOWx2bl+9w?=
 =?us-ascii?Q?m/QkxZnFqauawjN3peArvlYrrem3I4EE55Sx0xNZMYbhD+hWs/w+S3wQwcCM?=
 =?us-ascii?Q?8AdlomJP3bvQNuCahQZ0FJikKxUUDprJQPLaibsmKy87k871qu5LsOMsxh/w?=
 =?us-ascii?Q?Ao0HpLT10Jmc/avMPPny74qUPVHWqg+JPrXeVe7X/c6m/9mOImcL+/AUOczo?=
 =?us-ascii?Q?In9KPNtSVDrSVMWM9Ol2FDoHHKoqz1soX1YaVOdhdxwvxm4suQP0p3NeBNfI?=
 =?us-ascii?Q?E1QPFncLNJh2CPwdBT4ZXfw2XPb/eXMeZQNdCA/DbphEyPHg60ciyLQJvq7O?=
 =?us-ascii?Q?PYU6a1YRVVyaUtqhuZxi6XjNKf9m1s86x54qzOeDTngwzsgnNkAYxlyMEWb1?=
 =?us-ascii?Q?j4oTfnmEb83Ifddr8BCcoTySvo/2RXjcGoy1GWwgmom8SWH0jsACILOceIHU?=
 =?us-ascii?Q?Oe25VODedKdMzTiKMLycnIy+zEqgEIc7MqdO57wRu7gXcT/ve6V3kekClip6?=
 =?us-ascii?Q?nVkwcTRkP9RKM+GUtiecHOBZD8Jj4+gd+/REOQ9ttQ9EM7ymyDrBiOIlof2t?=
 =?us-ascii?Q?8LVH+6rOlvEaNeSfXhFbCQ+T6TcDjVGD90mVORndXdRJjgXU2pgmSRYYFx5r?=
 =?us-ascii?Q?2+yB1wRwQtnvRAhK4AmH2v9aSSxHDboJfjZhzYe6W7OqODY8qyOBf9chefAg?=
 =?us-ascii?Q?svOEDOibyS9rf45/4mJgFhVhBFgc/mohi2+bzAUlupnYEVp9tbnrOWE/IFXR?=
 =?us-ascii?Q?BUn0IdwnWtJG9EBqiymLv6cFSZodcQBipua1XBsEPhMOe1cW30MaXo1uA8WZ?=
 =?us-ascii?Q?EpYvjoc/LJOysjnKmNyjQHNaeiRTQwCmjVJpELMKbiEQLz9iC3sgf1wIoPpm?=
 =?us-ascii?Q?cZ/WgN+a3Ghrgwj+YazwmaFS7DCNvCt+8w98t1GFjpfK7Gw7FVkS1Hkdqy+i?=
 =?us-ascii?Q?6V7Bwx87V4samBU3ek7oSlyeij/U0hOAKORI195w1vMKZFeOzQwJ+RG+cH+n?=
 =?us-ascii?Q?cJvlFLJ3CPrX0FT5N8EHAaqlLC11id/XHe5Dk92TgG4TyXEjoJAvkDfbqHCN?=
 =?us-ascii?Q?1wg1VHCCL6xyInQv//fYWWN0oN/zFfVRk5P1fV4pM2QyHsy5ucIPZKC+BP2S?=
 =?us-ascii?Q?kPuos9cN5p1GUizS5Vu6oMu/tl8EybUOFthx?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2025 06:50:16.9324
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 60e5cf19-20c8-4e73-f6bf-08dd82331b56
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099D8.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7929

This series comprises two features:

HATDis: When host address translation is not supported by the IOMMU,
the IVHD->attr[HATDis] bit is set. For instance, QEMU emulated vIOMMU
does not support dma tranlation for VFIO passthrough device.
Support has been added to check this bit and switch to guest page table 
mode, if supported. This feature is useful for cases where only interrupt
remapping is required.

EFR[HATS]: These bits indicate the maximum level supported for host page table
by the IOMMU. Modifications have been made to adjust the maximum host page table
level, starting with level 4. If these bits are set to 11b, the driver will
attempt to use the guest page table.

If guest page table mode is not supported, the driver will fail to probe
devices for DMA translations.
The interrupt remapping will continue to be supported.

Ankit Soni (2):
  iommu/amd: Add HATDis feature support
  iommu/amd: Add efr[HATS] max v1 page table level

 drivers/iommu/amd/amd_iommu.h       |  2 ++
 drivers/iommu/amd/amd_iommu_types.h |  7 +++++-
 drivers/iommu/amd/init.c            | 39 +++++++++++++++++++++++++++--
 drivers/iommu/amd/io_pgtable.c      |  4 +--
 drivers/iommu/amd/iommu.c           | 15 ++++++++++-
 5 files changed, 61 insertions(+), 6 deletions(-)

-- 
2.43.0

