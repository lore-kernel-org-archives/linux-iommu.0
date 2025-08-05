Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2050.outbound.protection.outlook.com [40.107.237.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74BBB86329
	for <iommu@lists.linux.dev>; Tue,  5 Aug 2025 03:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754364896; cv=fail; b=gD90H68jgAYOXE7h8S6dEeNPTBUtEWRwjTYEsizkmR8w+HfATQkoaXyX8NDXYMXT8LwDgF/eeYaDgsxCI9YE2OamT3psjfwz+fU29WtSccYFKX+XZnSfzB54vhHYvBcMk8hsj6+WTSumsj410pw6YrpAwZnpDuceblPZxCqToiU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754364896; c=relaxed/simple;
	bh=+3p7rXVldwioqvIQRZYCwA9cl/c38TG0+pzL+Rgktss=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bdCI43DXV2fH1ydFZFl7m9YBZzrNHvxbtGiKkPLi1JeI4fi0qwkXUIFfjNrWDRojqVNpyABS7eviwPYRgn2ECyO6bIxoen7SgF/VXIwLrZ/8BmYS/tFWXherT4EUg3gDB4FCHLLieLIP1Z+yKRVmWnu5lJQ3qG4vDcx79KxCiVc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=EjfXT8sp; arc=fail smtp.client-ip=40.107.237.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="EjfXT8sp"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qRLvZVpsMfeam5BmcYFLDb9Pn1QWyeg0AXrv2lYBSpk2xyaZXRjoF1zO2REI3R8Hsx5IuvCi5bUnqqw7pIU9fdSSrhnGkt+yg6nwRyHv3/spGFqyqVj3h61TcigQ0z0cjjuvYqoo+ioqVBTrz2LxB4V+Uesrl8kaKFG2LMSBCAOdU1bLEwNMYKmqIXGQqFlePgenKM15GF2K/1mFCNKpXSuAshsKf/XCC0UDUBZ42lAb34Zb+4uF8KBMRJ7iNXg80HHZeFVd7tCWF+zMj7E+v3BybyxLGHK3TSA5hS/5l/9mW1RokwBNDCbq9oUDyTiOKnGx6Rq65UxbIhCy2QlcYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+5edqx/xVRduMw1BDx/MiUE1pcEKLirHhJsi01afwCA=;
 b=RmXJhJbmJPogAwpyTdjHCtTYHu2DVCidT5bZB9ViHwbQltWDeMlUtcpDE3PcyCYq3U21z4X/qptLV39PNqUXQ/+RlTW8V1rd0fHUS1lRVJI0m63s/bekbmNGGC/xjH4kT/Q+HKrR8NCGlYoOL4GaeQ5jJfNV7VyYykZ+173gR4QctEY/MFY2FPhQSdUeWeJtkrAongm+VBuVy9IuhdXidnE4bPtuXd7+HSmepQ3JbQnIINGq46vFZd81cEzWSWYd6SH0WNj67vy3vKh3VcQMJeRURYTXNn7rihGEfrQ9+20KtFPE23o1yBoYhth27C5CEcwW4QMmFPeywONtIy/YYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+5edqx/xVRduMw1BDx/MiUE1pcEKLirHhJsi01afwCA=;
 b=EjfXT8sptX31SKVL9MTD5hDefF6Xo84iJNbgfnKoFIZpc/L0r1rsZrh0ktL0AChZvYUccF0f/WDMMbVpqXW5J2EUOtwv31TVHBGiCau1lohI2F2Oa5TssbN/M4iR41Fhw7GTxo4ADYkz1FkmpqyrEkAALYILTGGmO0JDPBin3jbhzQ/6fy7JqVRy8mtioXSBFaDRIMTz36mbtoZrTlGJ3DUT9aPxbihMmuNassugO55p57IrYpHhhiCTDDihsmuL2Fk2FHfG7cM1Ch4FP1ggMrE0gZB5YhVOQs/hT3LSz6Eu4GRI2mbpaPlIVCZiiJmx7HcAHrLWmrpc36T4fE4rXg==
Received: from BN9PR03CA0393.namprd03.prod.outlook.com (2603:10b6:408:111::8)
 by IA0PR12MB7508.namprd12.prod.outlook.com (2603:10b6:208:440::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.20; Tue, 5 Aug
 2025 03:34:48 +0000
Received: from BL02EPF0001A108.namprd05.prod.outlook.com
 (2603:10b6:408:111:cafe::7b) by BN9PR03CA0393.outlook.office365.com
 (2603:10b6:408:111::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8989.21 via Frontend Transport; Tue,
 5 Aug 2025 03:34:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF0001A108.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9009.8 via Frontend Transport; Tue, 5 Aug 2025 03:34:47 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 4 Aug
 2025 20:34:12 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 4 Aug
 2025 20:33:12 -0700
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Mon, 4 Aug 2025 20:33:11 -0700
Date: Mon, 4 Aug 2025 20:33:09 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Richard Gemego <richardgemego@gmail.com>
CC: Pranjal Shrivastava <praan@google.com>, <baolu.lu@linux.intel.com>,
	<kevin.tian@intel.com>, <jgg@ziepe.ca>, <iommu@lists.linux.dev>, Quan Zhou
	<zhouquan@iscas.ac.cn>
Subject: Re: [PATCH] iommufd: fix returns ENOENT in
 iommufd_viommu_get_vdev_id()
Message-ID: <aJF7dbWXV8E6ReNY@Asurada-Nvidia>
References: <20250804100859.3462571-1-richardgemego@gmail.com>
 <aJCYtnyBjvTxULbE@google.com>
 <aJDxfiP8n3YLye1Z@Asurada-Nvidia>
 <c603856a-44ae-4ff9-8fe7-7cb48d78617e@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <c603856a-44ae-4ff9-8fe7-7cb48d78617e@gmail.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A108:EE_|IA0PR12MB7508:EE_
X-MS-Office365-Filtering-Correlation-Id: 06bd4d2f-cdaa-40d6-0433-08ddd3d107ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UgklmLwbUIJsrBBZmu0EbL/Rc1XsjitGUhQurZd0He1PelLAONc1EL/ub2Q+?=
 =?us-ascii?Q?vakObP/IbDSECnINpW5aPcDdtM6IljBQ1pX71PKqJqwkHTDhLtlcoOmH29qv?=
 =?us-ascii?Q?eqCn3WePnvHO7T9E282Dm2KmilZDqSWLfpHlaxgfLJIJyq8OMVVdBTXjJeFN?=
 =?us-ascii?Q?8UB5u/1PNnc4ESjzP2AFaQMUWYPqEsFpar6JvDYpBb3Y6S7TGul9WR52x8Zl?=
 =?us-ascii?Q?jro53pXMHtxSjEzmAUDqtjeryRCjnEFeRx3ii11VsAfccPR1gPlpqm/EJn7D?=
 =?us-ascii?Q?4VGkoGzDVQ9xdRqecpynzUem2p/08fs88jtdVBGYS+Qx7T4pokBPMHLOOwbV?=
 =?us-ascii?Q?6XoWAefCf1uSuta5/RkN8wH3hFYIAhzvv6fme50Ik/i9GkYUX0BQmBzs57kg?=
 =?us-ascii?Q?7UnO+di0pwU2ouUWOgOvapifRax1UXCy3fVXEVXmCnPFHHz1VZ/YuzbDaNl2?=
 =?us-ascii?Q?TR7mNvumyNCE0Atl7DDaDWqd9lH2uzYwt1hdbeqTctCVZW4gOelUAuxCzALX?=
 =?us-ascii?Q?n8zcKESxu3ObCLFa90a4sPeerWFIpIUzga1f8G+m+eS1l+uOOI3QYD6S035q?=
 =?us-ascii?Q?kby/STkEiDdKDRDPoJ/1bI99KaPPM44XN9B+qkwcCahMWAoxGh/va/eSjYbg?=
 =?us-ascii?Q?oF+F78q0psUjTPfYZSqdtu4znCYnljVafoODpnJINPqgz364vHrL2Dgk689h?=
 =?us-ascii?Q?L0112WmfcDHJVGv3YgtshMx4jUDAtCGWp0zQAbHuBdoYrI7xLiJynDwHJ1s7?=
 =?us-ascii?Q?jPg1y6fXQbauB37rKaKSQuSKY0vcY25R0k3TLxVPM7a2CjoEX7EUG6KNR5mP?=
 =?us-ascii?Q?DTXm+WiFuUHKA/GZ7WlLgoq6u/k0+y6GCk33hcO28S6Ew9hn0BmM/kPZ3rus?=
 =?us-ascii?Q?KqlDZG947+BXh0nfXcvtOBRmhsIss2dd8dlUWZnvPlwz5W+8PZH2FBAsyQgE?=
 =?us-ascii?Q?zIc7AC3dSRSKMRRt3lIo3QvBpWBZxIaipRO5rwiy9jtzBP+bVu+9bVUsRUs2?=
 =?us-ascii?Q?9WfIzHLweh3M45vL/VLdt9b9U6M71+xDCeTG/wO0nvudjL3IY2ws5UZgpX/Z?=
 =?us-ascii?Q?GRU5tcsEPBQ/vbo8+n1CDZ5Sj57asjt5QYGgSwQb38nlomBQY/9cP2azbqFq?=
 =?us-ascii?Q?aA2sOZTNIZHkFswm8X4Y6IxG7izbzjuW6mxI+00qAUUDZFB7lLjGZZcNEtjB?=
 =?us-ascii?Q?fsaoZOI+xsHCGTLrNmw46cRcAjAaOZPfiHPshZoiMCBU0CkMJX5e7dMzaMMQ?=
 =?us-ascii?Q?Oh6x4loNU1DnR5SIMscdt7Hl1RoAk45DHlQZULoZHVzNtq9MpWpEKNX4IRpx?=
 =?us-ascii?Q?ypiMlhsgmlx7hLdoPL+qhLZYNMTRisa0sRP7gerzFWpBDv3Qt06oNQjWsSsc?=
 =?us-ascii?Q?znI/UMPfr0q8qxD7JOli88PPuuvTn7sIMsot0oiecFbEnJ0Nfuktg3ahXwZr?=
 =?us-ascii?Q?pZJuaOksCQuUZQh59tVV1nHnGtDNBVbMwxhDEPFXu2YeoD+gvqVGKT87PeQ1?=
 =?us-ascii?Q?bNaE+sCkg/SVUCjfvmqHV4L3o/L8EvVOjvTX?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2025 03:34:47.5828
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 06bd4d2f-cdaa-40d6-0433-08ddd3d107ab
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A108.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7508

On Tue, Aug 05, 2025 at 10:46:20AM +0800, Richard Gemego wrote:
> The motivation of this fix is when iommufd in selftests tested on RISC-V,
> 
> I found that `alloc_hwpt_nested` items are failed

That TEST_F is a non-viommu case, using the hwpt model, i.e.
mock_domain_alloc_nested() that does not set mock_viommu pointer,
leaving it a NULL value. Any vIOMMU/vdev specific thing should not
be invoked in this TEST_F.

> then I followed the
> function calling chains and found that in iommufd_viommu_get_vdev_id(),
> there is always not any vdev in viommu.

Then mock_domain_nop_attach() won't call iommufd_viommu_get_vdev_id
at all since the "new_viommu" there should be kept as NULL.

If you see this function is called for alloc_hwpt_nested TEST_F,
there must be something else going wrong. I would start to check
the mock_viommu pointer to see if it is set (and then by what).

> I wonder if it is because RISC-V
> does not support vIOMMU well, so that there isn't any any vdev in
> viommu, then iommufd_viommu_get_vdev_id() will always return
> -ENOENT. Have you ever tested it on RISC-V? Will viommu always have
> at least one vdev on ARM (since you have mentioned ARM in ea94b211c548
> patch series), so iommufd_viommu_get_vdev_id() can return 0 in iommufd
> selftest?

No. The underlying architecture should be independent, although the
kernel config file or compiler can be a factor.

Nicolin
