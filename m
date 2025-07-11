Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2070.outbound.protection.outlook.com [40.107.220.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AD0821FF4B
	for <iommu@lists.linux.dev>; Fri, 11 Jul 2025 22:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752271806; cv=fail; b=qjfUy0ytpQ7UWuKiIkYDP77U5TKxehpu7moM/CS2zfNNpedCst7ZHRoM8CAP/an4LCdvAGpsDw35bIKUhYOAHeEhD4wULQqXeeRZ4FM4pyxR2pCeih+t2N13d6NpsDgD5WT+kqEIpYRh5FUJwEtPRc673x7fODta0bzJTFETg14=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752271806; c=relaxed/simple;
	bh=rsYA+KMc45LphXEOwgBYH0awj/vPem7KokIkPJHUCrM=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IqB1ioKOFPY5bwbAxLlfER2wRFIOiYdM+5doFQSE8I1eBVtIIN0sQAfomFYN5pBYVvxDklTV+N8kVbEKqpgatyGPHAktW6p/yxdNrfbtdEPoBURiTKHTHoGpRgEXbbzDe+I/Qm9LLoZE+WvYIl0gz95H+/YRfOY6lhH8XuiOccQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fFr9GKfT; arc=fail smtp.client-ip=40.107.220.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fFr9GKfT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TAlFvgj5RFao+gPF5VXqoQuIbwGCKyZC/YQlSCIMrsPm6h+8APjbOOivThMLdgZXRCpeT6iBocPtYOBY00LMfUxNHaVC3H01mwA9N6nc5GWvgnq7m9I8t0mp8vSZFqO3n+19JDHfFRhZncaPzRMm83CRa8ZBzjSS5OwwHAbKvd16hT58vkeFIne9fTGYBNCktlS8m8ZZwPKN+ZihPVz4F79WTLAqvFfJL7ZTEJ1kPIie7aKkgJGXCE/BGI6G5Gml0XBJF+0a3Ga437si+whrRz4Q1/1DtCMKj8mS9nYliFgyrt54Gsk1Q8UZuJ/bh7abNI3W/8FZfDNKFpx3sPcBkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dHgttDQS7Ps58GHgSqke0HlAAWj61LKcZLzq7Ko1aA8=;
 b=Lh9hdKkyTY1r8ECLm1HMWUpp+wxjRjHkU3T7DGaZZMHob5J4L1jf+EJ8FXXHoiKiHT5dUUrggMAEPCWmCO/yj1i629UgN7ZNz6jG7fh4l/YB5MEHe2TLpc9XD3MTU/hlhkwyeOcu+jLs8iGEkGavHAGyEuc+G7UcWYexErLAfuFlMMsHa+GOZGCLU5sfy41SWd8IsgdMCv2QGMWbgVIqAOI5q6Ik6KkINwrdqOBcEHu6HOcZzlGeyUn0TP7q4JyMcrvSxjqjuNkB5pY4lOj6X9qrXvEJA4XCFRJuvRJBcoQ8+ReHq/bCqQEyCWnLcYkkWkkPoBqcN8WVnNhiD+kZTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dHgttDQS7Ps58GHgSqke0HlAAWj61LKcZLzq7Ko1aA8=;
 b=fFr9GKfTRbnF+E+Ocpf6bX7erdht0crqYS8t89eKZKDRGZGMDJml1sdRbqJcCmgePUFpzkvAFo7geW3n6NqH2rMXWRVeGwn9HRNc7sSrT6vuuPAcklySdatmJbI7mBckUPafn4crH5iQg9HZ85gobU1eRkjH7LKhpW6PD5EKtcKg6gIH9jEHeZ6OHXyUHyrPwtHQIVFwZ4xINQtEsnDdOW5HoMykvMZHG4YS55PCNslNNpiSCoqwrgdYrXH0EojU93wZfVw5s2XyhS0YRZUYvOo3MquownSJxBQHvqWXV//v3M9v+gt1CAtEkSYSKc/ERaCnFz9Xagaqh8qQzyPUEQ==
Received: from MW2PR16CA0057.namprd16.prod.outlook.com (2603:10b6:907:1::34)
 by CH3PR12MB8234.namprd12.prod.outlook.com (2603:10b6:610:125::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.34; Fri, 11 Jul
 2025 22:10:02 +0000
Received: from SJ1PEPF00001CE0.namprd05.prod.outlook.com
 (2603:10b6:907:1:cafe::c4) by MW2PR16CA0057.outlook.office365.com
 (2603:10b6:907:1::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.23 via Frontend Transport; Fri,
 11 Jul 2025 22:10:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF00001CE0.mail.protection.outlook.com (10.167.242.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8922.22 via Frontend Transport; Fri, 11 Jul 2025 22:10:01 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 11 Jul
 2025 15:09:51 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Fri, 11 Jul
 2025 15:09:51 -0700
Received: from Asurada-Nvidia (10.127.8.14) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Fri, 11 Jul 2025 15:09:50 -0700
Date: Fri, 11 Jul 2025 15:09:48 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Xu Yilun <yilun.xu@linux.intel.com>
CC: <jgg@nvidia.com>, <jgg@ziepe.ca>, <kevin.tian@intel.com>,
	<will@kernel.org>, <aneesh.kumar@kernel.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <joro@8bytes.org>, <robin.murphy@arm.com>,
	<shuah@kernel.org>, <aik@amd.com>, <dan.j.williams@intel.com>,
	<baolu.lu@linux.intel.com>, <yilun.xu@intel.com>
Subject: Re: [PATCH v4 3/7] iommufd: Add a pre_destroy() op for objects
Message-ID: <aHGLrJnGUVdkO3SF@Asurada-Nvidia>
References: <20250709040234.1773573-1-yilun.xu@linux.intel.com>
 <20250709040234.1773573-4-yilun.xu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250709040234.1773573-4-yilun.xu@linux.intel.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE0:EE_|CH3PR12MB8234:EE_
X-MS-Office365-Filtering-Correlation-Id: a0db9c9a-594b-4071-c174-08ddc0c7aead
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|82310400026|36860700013|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PTG+OgjyzOX3f3dZLJ1P3FYQ6rwwvFEVn8gppxe6L0NJAD7rFjPnxj750VAs?=
 =?us-ascii?Q?/mBIEqsGuS4biiG87VMzRn3kfjBZfQAhreMn3SzglSZ2J22aI8PCUkGaHN3+?=
 =?us-ascii?Q?FRj0aWf9PGxwC0lJjusCVnI3B5sm6dtJbI0rGjbArmj2Eb31NHDL93Jb3lV8?=
 =?us-ascii?Q?dPbCrYr8pR+0dLSh9pq5/kpZsHLi6KoHHTuu0Rc2iwSL+bmD5fX0VaN1HiI9?=
 =?us-ascii?Q?yAMF4lA7kW8Lo/p9nwQ7q41459SQsOrRKIhZ48wxMbtUZp+2gVNi5AIWpiGt?=
 =?us-ascii?Q?nCqnT2fVyuAK4RnziUp+PNOKiQYpra1hAGykISnWha3J5Klwm+3zDg/76fnP?=
 =?us-ascii?Q?yryJIpKJC8ZmCIVmnaTR5dnsfwwjVuGoPQ9rZuOESG2nsIAN66YM/MVfpxEX?=
 =?us-ascii?Q?lNGH9t9w/oYl8JHm7wLRNmoqquoULmsrNln70rIeAZRjYbEsh1Ob4x5MyHng?=
 =?us-ascii?Q?AG5SA45LNo3hBEpcNgvpia6I29wcHir0JQbQpdNqtHJKqn6i4AG3R62gDIVC?=
 =?us-ascii?Q?ZNl+xYCAJPBQSojK242M6vlGkDvoioVLUaugZ4G/mQIYZQMG+Ggh/noPoBje?=
 =?us-ascii?Q?XYAfQK7IwcWOLH4HkVUICzXmtrRS3yx2wKgyDUQj/NflgDjxDpWq6JL05Zt3?=
 =?us-ascii?Q?e+ciKw1Y3mZChyl88sCgBEmUPef+oJOJ8hVolvir5S1t1OKGViNoXhR4i1UA?=
 =?us-ascii?Q?flbf/ooJ0g8+I4UYRzgIUDqhGyT9S4t3/biwYQnVRQB6mS6p+BytgPToyr/d?=
 =?us-ascii?Q?qdBATJeDBw1D80AVVjjH/suQOhT5U9Y9M76AE2w9BQUmfmvR8EeSKitAVcpt?=
 =?us-ascii?Q?mWjTqmVTD/Ci74tDcTYz4Ko4UkwNC6SjYwpZwRy3BZVn18ndNtOCcTrhyodW?=
 =?us-ascii?Q?stAAObywz2sbakqml37p6FcDIBraw3LTzSXn4EbxX4FUXLlP69mPU66ekg/Y?=
 =?us-ascii?Q?CGUyWZJQj7it8EsOSGlyzA6OElJ18nbHhMIhPNx4mlzLh2oEGAt2FW1E9uAf?=
 =?us-ascii?Q?+B7j/68dmgvaETklOTvh9aVy5q8nuoDxjfvGLZeTJgov4I8IoTvblTe12Ycr?=
 =?us-ascii?Q?yImvbBTm/etuqN8G3lD/lPCV87aFMtR9mLbat3scuv2xVokXo4cEZHY1BSGK?=
 =?us-ascii?Q?EO0DSdSJPCjhQHSHAEmnDm1m3ber1QfB+BZeMkfP96hrEttoav95W8oWBhag?=
 =?us-ascii?Q?oCIF5Z4+GI/ka1mbfiplm1EMz8o2C6pm9a0OBxxdHVY6kBOS5/WHCDyRcPST?=
 =?us-ascii?Q?DiyUOsV4bWj1KfWL0NFdP+UXdIzbs5vH+Wp0HbUUYjbQ/1i/mX2cGUpqnZ7l?=
 =?us-ascii?Q?41OP8RmrNVyQkt6tk//tySLjRbAU7QEexYhel4hiZFTSVrMG+hvyS+vwC1Lp?=
 =?us-ascii?Q?ElhuSO+hgiYhcFj3MjT4WWLvbLCx5nt/QFiallcBSnJpP8LCTcoapSNztOt3?=
 =?us-ascii?Q?TfjDRdaRLfSq1d6GT1La9W4zl032/FUlINdI/FVgr5itq/0zEKCujjYxlQf3?=
 =?us-ascii?Q?ObztJzeKFbAejNpMKgO2nCPl1NvS7T4g+mOw?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(82310400026)(36860700013)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2025 22:10:01.7794
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a0db9c9a-594b-4071-c174-08ddc0c7aead
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8234

On Wed, Jul 09, 2025 at 12:02:30PM +0800, Xu Yilun wrote:
> Add a pre_destroy() op which gives objects a chance to clear their
> short term users references before destruction. This op is intended for
> external driver created objects (e.g. idev) which does deterministic
> destruction.
> 
> In order to manage the lifecycle of interrelated objects as well as the
> deterministic destruction (e.g. vdev can't outlive idev, and idev
> destruction can't fail), short term users references are allowed to
> live out of an ioctl execution. An immediate use case is, vdev holds
> idev's short term user reference until vdev destruction completes, idev
> leverages existing wait_shortterm mechanism to ensure it is destroyed
> after vdev.
> 
> This extended usage makes the referenced object unable to just wait for
> its reference gone. It needs to actively trigger the reference removal,
> as well as prevent new references before wait. Should implement these
> work in pre_destroy().
> 
> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
