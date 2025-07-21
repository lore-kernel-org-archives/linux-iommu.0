Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2051.outbound.protection.outlook.com [40.107.95.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAA27227B88
	for <iommu@lists.linux.dev>; Mon, 21 Jul 2025 19:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753125181; cv=fail; b=A29aWONRm2q/+Z2MDf3BvRy4oXQq5e4N5BgisIz4AKCeSIB6tJeYbyb9270m/4Wb0tUWGp5QqtODVXmX7eI7P52Q1aZ1HeA+3K6uvmAP+nIncEp07MuVDF1IGqlNOhzfOVmS2HGzObs0JXZgxON0Z7nEOhNAjViFpzW8YVTIvIs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753125181; c=relaxed/simple;
	bh=kB3f7Rq6CvL7mnOJ2yN6BxFQwB0htIsF3er2FuWtJZ0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jO0+901ex5F50vW3FTp+IGPZ5KPDqGtDQMQyiYuBreqeDSppzWZTpOsB3aeIbfd2JGv6uEfA/5qdqVKYbfSgkmRh295VmAOK8EP2a94bxURMiW8EHZlv/hNx5Ln3kfCd9Sc7b6v68kK8GxGMzezrhydlU6B9cEmDy+x4i/3HqIs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZDSalsAq; arc=fail smtp.client-ip=40.107.95.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZDSalsAq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hNQ3fJx1Xs05+KTXUDfSnvJtRhHLSDt37kfN1M2+2/bMH6TOOF2SzdYblt8ZWF27G5xiOCMJUFIcFFFIxxmuVssu5tCj1xitMU95m368AtIWv9YpGqlCJPvHp/FK/TVf0dQGfD9z0VB+b9xeKHpESV6JfnURKkhAYVnzsgFEjooppnKfl9aBI5wbiBpYNJwdq67YCSWcFPNmHAoNhYuFsY/5y+VmDbK4KtOHkXhZ6fSX7q323qZB4Jw6HX4IsCBRw8ZOr1hXeyRmxsetc0Z7rI7u0PMjvzfM4kAUL4eijyGn83ARQmRwbl/rGNJCuLde4XxhHb5eM/d9joTdWQ9qqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=to2roDfD7E9G83eYAvCG7I3+KEz5YqN0ffcyNQszDN0=;
 b=NyBlO4VuXarr+iEwh0gtGSxVjLkcN0vjnbvbcbZo0UPfbkPAOzsuiRC8QXxJPZhTh+WBlK5ZAxEAJTIUQBVamNogsdXXhaVVygYEPT7Ii9+CEWysb4ZZHeLEo4I19Qh795smbKQSgQUa48aEGOc3eb/CWuQ2JIrlLBsjxuov+3O3CLXO6Ix2jTot82SSMKZOKEPbsvzyo2xwHvgOnf2X5Q8yAZQNXmZywsl1HD0DZFgAUzCHHVVZKdgQ+Zg1wibi+D0gLx7C3ygzXaLTq1IE8CrRho8Stx6wyzMj2bHSJedTYpBPV98yHxp29DCWdMszXhU9WeCkCFgJlH30R8uKwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=to2roDfD7E9G83eYAvCG7I3+KEz5YqN0ffcyNQszDN0=;
 b=ZDSalsAqbriH0A2ReBKR0MR+YyChKPlf4CZvfTWDZ6Fwyl+FKNpFxSkf2/mB4RRmkS7STxKfc3HxRgOw73q4SNQP1S/OSsCMJUYXAy8xTVkH8uA7Jxq4IUSDwlTC6Ws8L3mV9kTFglcZX99oTqhwGjbnBUgkaa4Z9XNdHS3aCbvFNKo2+25JIDGSsMj15rL7S+pwcHpBYVKDdDWwuQ4Ho614nBtNCbQ13RQ+9S5OMejZ3IFwlk56H4DmlgLop4REtNAg6L4aYu08y5SkANPcOF/pknv2W/lmqS0AS7E2zqeD/EIH3bh4R6wKHVTjOEJl4w/Y+hCJTZHZ+7vXFYEsEw==
Received: from CH0PR04CA0056.namprd04.prod.outlook.com (2603:10b6:610:77::31)
 by DS4PR12MB9819.namprd12.prod.outlook.com (2603:10b6:8:2a0::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Mon, 21 Jul
 2025 19:12:54 +0000
Received: from CH1PEPF0000AD79.namprd04.prod.outlook.com
 (2603:10b6:610:77:cafe::4b) by CH0PR04CA0056.outlook.office365.com
 (2603:10b6:610:77::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.29 via Frontend Transport; Mon,
 21 Jul 2025 19:12:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CH1PEPF0000AD79.mail.protection.outlook.com (10.167.244.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8964.20 via Frontend Transport; Mon, 21 Jul 2025 19:12:53 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 21 Jul
 2025 12:12:43 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 21 Jul 2025 12:12:43 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Mon, 21 Jul 2025 12:12:42 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <will@kernel.org>
CC: <joro@8bytes.org>, <robin.murphy@arm.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>
Subject: [PATCH v2 0/2] iommu/arm-smmu-v3: Two vsmmu impl_ops cleanups
Date: Mon, 21 Jul 2025 12:12:34 -0700
Message-ID: <20250721191236.1739951-1-nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD79:EE_|DS4PR12MB9819:EE_
X-MS-Office365-Filtering-Correlation-Id: 23056e3d-6ca1-4188-306d-08ddc88a981c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|1800799024|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IgMPERyChT16x0JhPIbIEf8hxJplUHLgyDptUloilCp1vQxB6ET0V85S1WEF?=
 =?us-ascii?Q?Hfo4VS+guCQe4q0e9unrrQJXgpPaW1a0CYIZ4wyzuE+HLbYRdV420lXNvX4Z?=
 =?us-ascii?Q?qKjGFipeLrg6SJPNehvZVFvJyhIhvMgsZrFtVDNf4oFVns64hpqR/i8JOd9q?=
 =?us-ascii?Q?iZQG6U+SxiQeWGBtHK/F6+aO0UJQojBqOwqoZXCzNCy/b8nFLleKiIyrmZaE?=
 =?us-ascii?Q?JSkogSdoqx+aB7HzFQ/e0ygL5A3d9j5PaqmnJqULPOtDLgzE+zMeYOcN4yZp?=
 =?us-ascii?Q?unm0HchqW2AhTDbCLDHUkpTyP6UWJ1X84LqRf6KmyUhq38DMjvPyn2WzyHIB?=
 =?us-ascii?Q?YJjD+ky2KHGB2sljIW1IaanWpXsghX5VKM+bThhIT8V5HTNA5c8T67SBClf2?=
 =?us-ascii?Q?nYwgtZwjU5bzG/L3jRNoc4TNRgoYatu3uXNUFtWd3KmoorrRi4Q2pJZSryvw?=
 =?us-ascii?Q?/jd+5AVcw+DYe4S0aNmfvMJhmCnEGBCfK4X9FTQ2UdpPcK2IAecllGg5xNZE?=
 =?us-ascii?Q?vyIb+/iEL8yND3ftmRTe6vATTtGvSN93XRbDf+1glPhUAPs9Y6qHPmptOwqs?=
 =?us-ascii?Q?drW1vRHHKeYVU3cLu1bcZRzGE//zHWOcUZv74VokL1IiAbCbWisj6ui2cWEa?=
 =?us-ascii?Q?g60pz9vKiurZff+fHNTBOqRgGr6rI0o1G26/YGWrSGRMbblWOi0le2W466UQ?=
 =?us-ascii?Q?zMFr41hj6hahWOFMWNbn9XkHcF46FQYIg31Klw5XvcSajcoztiragqb3OfTb?=
 =?us-ascii?Q?mr132g7rt6Q4rseopt4E6U8q387EPgqxB16PP2M68IktpLpHOck+oLHzMqRA?=
 =?us-ascii?Q?5l98ifs7pgANWfMc0Ii3qOpUFzkwLEyrTR7ERJOfXS9tqOG5ZqGLF7gVeirS?=
 =?us-ascii?Q?w8LjDJe8jOVbY2b+Zy1lMi5LaKCA4C3h8E8B42KiYR9w0JUfrqgQPVE9qLNN?=
 =?us-ascii?Q?oy9rKbFaKPUKdJGmS/yAZH+6uPkibvgmeq9a2sjnxW5XQrDwucgOnRUL8A8p?=
 =?us-ascii?Q?IclMKmNoA6dmdCj06Iq6X3GhH075E33xMFWGKlubYPhK5I2ohEg2SGI9L3yU?=
 =?us-ascii?Q?BQ6/FFHQCLt1yFJWHDXM0UO7v0X+SL7PWCFUtusNx/njIPo3CwC4z7E5UQHn?=
 =?us-ascii?Q?g14eZruAgcYxc3u8SmGN5cu7PGL7qdCCmWTQ5mBd6wxRIDl2RqZe9rHgEdHx?=
 =?us-ascii?Q?ZnMH+8bFh6oTtFO6uA0Fy/zN+WnriKJT5Km0UBBDB9IxIx+/nglgMQRczrsM?=
 =?us-ascii?Q?5t06w8TZzhfGRiMeodMxnoh8kwoENFolaBwlAWYns01FEjwKi789CGEFNjJo?=
 =?us-ascii?Q?eZFaBoUBPFliHOPs5oRfophpjpKeV+bs6dFwCzOtioXMNRtx6E4TAVPEMMVP?=
 =?us-ascii?Q?GUl8k/CTxD5uTuTgAF9sqBVeZ3AxIM5YPg1j2yM3Mn8GQ80xwU70LDUPp6CT?=
 =?us-ascii?Q?SFg2HS2gI8iPcZHtiEmjaCcMaIifB04X7SykN+4yIW5rb+QqkEigYmeMNoXS?=
 =?us-ascii?Q?0VhfTdFBOFtlWQHkQRJBtEeMuEM6nn5vUooSspuvs8b8Z/iSZHgsGzwANg?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2025 19:12:53.8062
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 23056e3d-6ca1-4188-306d-08ddc88a981c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD79.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9819

Since the vsmmu and cmdqv patches were accepeted via the iommufd tree,
this is based on Jason's for-next tree.

Per request from Will following the accepted latest vcmdq series to clean
up the impl_ops:

https://lore.kernel.org/linux-iommu/aHE4Y-fbucm-j-yi@willie-the-truck/
"
 It would be nice to avoid adding data members to the ops structure, if
 at all possible. The easiest thing would probably be to add a function
 for getting the vsmmu size and then pushing the two checks against
 'vsmmu_type' down into the impl_ops callbacks so that: 

   1. If the type is IOMMU_VIOMMU_TYPE_ARM_SMMUV3, we don't bother with
      the impl_ops at all in arm_vsmmu_init() and arm_smmu_get_viommu_size()
 
   2. Otherwise, we pass the type into the impl_ops and they can check it

 Of course, that can be a patch on top of the series as there's no point
 respinning the whole just for this.
"

Add two clean up patches with the first one doing 1 and 2 to prioritize
IOMMU_VIOMMU_TYPE_ARM_SMMUV3 always, and the second one dropping static
vsmmu_type and vsmmu_size data members.

Changelog
v2:
 * Add Acked-by from Will
 * Move get_viommu_size and vsmmu_init validation to arm_smmu_impl_probe()
v1:
 https://lore.kernel.org/all/20250718234822.1734190-1-nicolinc@nvidia.com/

Nicolin Chen (2):
  iommu/arm-smmu-v3: Do not bother impl_ops if
    IOMMU_VIOMMU_TYPE_ARM_SMMUV3
  iommu/arm-smmu-v3: Replace vsmmu_size/type with get_viommu_size

 .../arm/arm-smmu-v3/arm-smmu-v3-iommufd.c     | 20 +++++++++----------
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 14 +++++++++++++
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  3 +--
 .../iommu/arm/arm-smmu-v3/tegra241-cmdqv.c    | 14 +++++++++++--
 4 files changed, 36 insertions(+), 15 deletions(-)


base-commit: ab6bc44159d8f0c4ee757e0ce041fa9033e0ead8
-- 
2.43.0

