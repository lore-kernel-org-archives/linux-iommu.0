Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013020.outbound.protection.outlook.com [40.93.196.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 798C83438A4
	for <iommu@lists.linux.dev>; Tue, 19 May 2026 23:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779233680; cv=fail; b=AdDG5/ygdRzQKr/QLhMJjk3roWAL4HtkwjQ0qHDdU+o4w+JL9GYp43FJ/A8b4560jHpj6vzL/2JNbiujAO13ejR0O5MnFGekhvV7TaVgeJKgC2gWbapy71BKY+EcC5bXZ48dxKcCZPSScOx5Mj5QF5JTDPS2G3dGzgg3dA0uCps=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779233680; c=relaxed/simple;
	bh=H3KKVkRx7jFlZEpMEZzOlONLj/HfZnGHl82OVvbNROI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LByfbtHuVcVDe3KOtNDkmoEp10hFEje1vM0G+sMF7ulK4ghuSJNXj5MqMVZdj4it29I1MvEzLmYzsyzQAkB0Ey5dbLmeekPS8+uKFQBRVXAj5IeGbFBIW6JHFgnyHK8DaoJyFUWYG89gS4/G2utb+rVKxY55p/G1mP4erorhcXQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=F3hOU1G4; arc=fail smtp.client-ip=40.93.196.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="F3hOU1G4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=odr+bh1b1NXp+SZa3zku1w3MKXQpquHQunJSoXjPNPsUz2nr5YVLf9gGFia5AxYLRVHEsbGCaJc2d6gtuDIKCTaYO2izIhtLCLdj3XvNZ6NewIF+E8/xcq3veVP1RI6pHuUeBTATBd5NZKe973R/cydfrSkesDTEOy/AOlFyiwI0p61dCSq7vp3qh4P1vwmE+DEKd0aHwMgyd5Rl8x6Ww9skm54FRy0TKDDDIN2JtArYaPbwGDpc4K258C7hLO0D9ZPOL9OEZDktdjX9R1dq8mZHbmYTJ6/Zhd0WTn+HD7MSIkk2EygpR7RnHxCV4/vUzVbYVtBEHm1eHfwgXPfquQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LU+GK9BLu9hAUAEmYBQjowgetKldMKNRgRBG2FzBaS4=;
 b=LnvGZl/lgPe5JdndzUZfflwmc+DNtqTSbYASSkLpQwUHM+q8ADj9IypGkO/8p27AIUVAEYeZWu7WZ5t7Xk7VTyU6xqrqYPDiRiPyuD2VbT6hUhDFbx9Rgz7o4uye73UXSjXLCqXJS6Sy8vb3IqAOjM7bvlChNoWkFxRhRGHutTX3ae47bV3Dm4UW+b6hmMntRc0SsIUFakzpakLtjsVcQEYhDP8/FF4mynOVk/i5np/3HjgkNrhRNeLvC4ejaIvilLmdHzI/F3aICy6VtlW5lflVtv+jejLlq/y1JRQRooj+Ta7aCZdU+YrYz5lNdacQGGd+COW2Ar/yTW168ZJxbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LU+GK9BLu9hAUAEmYBQjowgetKldMKNRgRBG2FzBaS4=;
 b=F3hOU1G4mfIHzsyi4PkTab9iSNkg4nDkAhRi4ZUCmwKp+RsMtKEagPkih0+zZ7STZaT+mvdDUeoo/1l0RXXn5jVefj1UT7A+NPtuGKK9QowkOpfUdEW5bbsdg1tHu79+N+lgaKnhjW54xPe5teki9oTFQNjE+/r85cHHCrb5q3FpziWFMzsLT7hwtNfOu38yiTfEhVcYXsLzG++KcU9iteOKPtc5h4sPcbRRHkrd6RwRXaw+OUsecAWyNd9SLWOe8EN9OwhPjRpV6cm0saA6QCYHc4UJxT/BN60E3nUsfemmvWz+cpAR3kf9SlqJJeVyaV1Nkq+7LhHkcIqDj114Vw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by BN5PR12MB9461.namprd12.prod.outlook.com (2603:10b6:408:2a8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.21; Tue, 19 May
 2026 23:34:36 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.21.0048.013; Tue, 19 May 2026
 23:34:35 +0000
Date: Tue, 19 May 2026 20:34:34 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Jacob Pan <jacob.pan@linux.microsoft.com>
Cc: linux-kernel@vger.kernel.org,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	Alex Williamson <alex@shazbot.org>, Joerg Roedel <joro@8bytes.org>,
	Mostafa Saleh <smostafa@google.com>,
	David Matlack <dmatlack@google.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	"Tian, Kevin" <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>,
	Saurabh Sengar <ssengar@linux.microsoft.com>, skhawaja@google.com,
	pasha.tatashin@soleen.com, Will Deacon <will@kernel.org>,
	Baolu Lu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v5 1/9] vfio: Rename VFIO_NOIOMMU to VFIO_GROUP_NOIOMMU
Message-ID: <20260519233434.GN3602937@nvidia.com>
References: <20260511184116.3687392-1-jacob.pan@linux.microsoft.com>
 <20260511184116.3687392-2-jacob.pan@linux.microsoft.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260511184116.3687392-2-jacob.pan@linux.microsoft.com>
X-ClientProxiedBy: MN2PR05CA0065.namprd05.prod.outlook.com
 (2603:10b6:208:236::34) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|BN5PR12MB9461:EE_
X-MS-Office365-Filtering-Correlation-Id: 3213c78a-3c39-4fb0-dd48-08deb5ff2fc1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|18002099003|22082099003|56012099003|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info:
	nJdl1Iupolv06kLsrWA9CgNT9SG+Dowo/64SWW/wz3AOFNrsnfkbUqXeIz6Z1XUm99jf7G+z74L51mjHAc9urSOZgkj4/iDe4JfhnVaGP2Leam8GUh7JFryeuFxvx/xlXhPyY0eeyEPHIl2/pCCvWKVjzzer0gVIcg1DqXK9A9Qv4cJQCksA/MurORWoXjEvjJla50eDHLxgvV9me44y9+MJTgkons/vGsn3ShwuS2mV16dKwB8NnWenD2hJQ+8MRzYaoKdkLVwbS1/dK76sXf2SnaDT/U8KXo7eiWr/ldfMq7YpZ7LhSG+ZpTK+rgmFnTMPu4/l870AFdDL2WxZ17CEvxStGZ9NGSGbhKGCzOsI/2zl+32zshlNDdzKjDRuxqFR04j7ETUxIam81je7V7SPF1mLaA0vuRc7OP3flWliJYx9qZsfBC+yu4e5kKaMrwAi6nK6sduCiP49f/MIl0woxzs7/0Fusj2KMcJbsiyRnCBzitvGDdnLwILnRkX6+FTneUus78eL1Z+AhpvicaVHsS1DkDGbLnwOg/OKgAZn1GxTvroYiSybCdJu8avsYqK2dZVVz1lP4rinNpzLS3mQcPpwpU7ct8M3Mz9woV/44pHxdjHc2EorZVdWpnezPQXRQlP1TICVGBq9MXsI2LPreBzR28lxbBekEg4eRn56YRwlqDMn5xYtZFhipaCBvLmwBm0AHl0KJ2dBCEQH/Q==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(18002099003)(22082099003)(56012099003)(4143699003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?heJYCJSiuYKIT4dQPkAb1z++VvywHdAYf6oiU9/WWnNJDLGwZn7GeyQVnA2B?=
 =?us-ascii?Q?p5KnzUTtdMwfYuiZDi/uyvi13QTnBh8MmtHuIJYU8Pj+qof5/1rvBernLFeC?=
 =?us-ascii?Q?7E+TB1ugBny2OmVZGc3zP+htaTwN7Hu1LYApdVvPh735lTQuzgKhVASP5k/W?=
 =?us-ascii?Q?RC3VcI7VxoNHSxxTOVr2QpE8RVYFV7PVy00R7w+jfDUEWVixhFD7L9yKp4q8?=
 =?us-ascii?Q?XUyNesVo0P9m7osGyHa+IUerrG4ZcTHwUGFw+S0cdcp/lLZn/3XdXAWrRO6C?=
 =?us-ascii?Q?g7FHmBMANxceK2MoYDDWmnpSUN26zHZQS5uUqyW5UOIqvPkF8O7Ea0PHioc7?=
 =?us-ascii?Q?3A9dDadH2gB9YBP+NazGzcXj3jp1D0OkiZOkfAX7PMBp+6V3NdOScBjFdmxl?=
 =?us-ascii?Q?guUhEv75YBWgFFgmhL3F46lhYC5GXnKw+KpSJHW+J28p36V5KAgmKmG1MDJT?=
 =?us-ascii?Q?36r3sPbv79/OMxzVOlJ4IZa0XDE5wY5WLUe3gN5SjiNmhyA44f8L6jCE+/Du?=
 =?us-ascii?Q?Jl/u6OxvAbmvwor8zTm5Ts4t3mzkodGDpsoa0MuhTzKdz9QB383i0LbeWrux?=
 =?us-ascii?Q?F6iHtKECCnyGSf0IQFl3HmIRzyyQ9dIhIUQllz/b7M4OyVFRMBulMrM+584v?=
 =?us-ascii?Q?BakV446ob017Yl3PPhZmioaEM1Z+0F9Z+V7fLLphS4MJ865nfB6d15RPlPWc?=
 =?us-ascii?Q?VwQoVEmsl2S8j85pCJo+YeaAwkd1fhVliiHdcHdbpojvpp8+7uq9Zg6iD46/?=
 =?us-ascii?Q?csH4yDdr/GSVNDiJBHqxUxNfbpmaLrs+E7LwqAINkxRoMCmL+i3idafYLzXi?=
 =?us-ascii?Q?Eg0Dp3bltQ2VzxjqCWKRdZMIko2Ugbe1BM9nnZvXL7rrCOrNYnLjOAYuQtaP?=
 =?us-ascii?Q?QU2DZPZEknU6SDg4bsYRCGO/ZJBU+lvRaC+A+rtqxXKe2j6QItEagaA8dvqU?=
 =?us-ascii?Q?DSqe7w5vY65uz5dyTluM9PAlNvNSHdMCKJoEuHky/mh5b4ojEY7ujVZ2Kysf?=
 =?us-ascii?Q?u8d84oIhOwodgZP6ol/+R7UAwRg4r5iDi7oSfRcBpQOdZfGNawdzKt/5I+rN?=
 =?us-ascii?Q?4EpjH8+SKDuzsZYJym7naDVKSgWe2m2WHa9VYedJV3Q7SpQbf+B/UcTouZKg?=
 =?us-ascii?Q?nqmARCp7VFAVKCImWe1Vlj1ZZi5tRxkXpS2cNV71pp4CgOes6VPXJz/JV876?=
 =?us-ascii?Q?VtJalH9zvJs4DphuAeNUqygLlHrxd7MLSLLJO+FhskLJsaQoL6GSMJfRQkL2?=
 =?us-ascii?Q?RSYvjLmvEdozt9ejABbD3bKsQOIBj7nXh69Dkq3+QvL/p+FN5sTyjLiaSDlY?=
 =?us-ascii?Q?kh4J99ab8rP9uxkVRTms2GUNKl/PFnkiwSrhhA9jgUsnaggt96hvor2vVLqJ?=
 =?us-ascii?Q?KHy7ljoohNwzmP+JD28VzcFvYf36u9ksfTtMBaHeQU0GWPidmgQukUsj5oRu?=
 =?us-ascii?Q?7tclWv8miKcK6b0gTICyQNqVLxDo0LMWfj1ipxyDy3pk1eGFAugRm8YAXXrT?=
 =?us-ascii?Q?m1XehPgPB6482+l5dw5jMCQyRLrx5ySXjHazBvvAvMUBeyXBDEdP27Ocbwz9?=
 =?us-ascii?Q?RDBn/LSjlCWmChp7yt/gnRPpdzM13B0Kf+GzI9Ve7OLOKXO7eD52ilEqzJWF?=
 =?us-ascii?Q?Ld+0f22snsQDoGLU0d4+wNo0E9WDZRZ0VbmfjP3txg3/gXcG7jxdK7DkeNBz?=
 =?us-ascii?Q?euhlf2w9VSbp1ySAOg6ZC13Xbp7AVjzW4jdCsB09oDs/gmzb?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3213c78a-3c39-4fb0-dd48-08deb5ff2fc1
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 23:34:35.7636
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2T/HYf6U6Z9WsaPzgLR6vNaylu263opwE8jYuXKisgr/yIReau9FKcs0ZGmMxroA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN5PR12MB9461

On Mon, May 11, 2026 at 11:41:06AM -0700, Jacob Pan wrote:
> In preparation for adding cdev-based noiommu support under iommufd,
> rename CONFIG_VFIO_NOIOMMU to CONFIG_VFIO_GROUP_NOIOMMU to clearly
> scope it to the legacy group/container path. Also rename the helper
> vfio_device_is_noiommu() to vfio_device_is_group_noiommu() to match.
> 
> Add an explicit dependency on VFIO_CONTAINER or IOMMUFD_VFIO_CONTAINER
> since the group-based noiommu path is only meaningful when container
> support is enabled.
> 
> This is a pure rename with no functional change, laying the groundwork
> for a separate VFIO_CDEV_NOIOMMU config that enables noiommu mode
> through the iommufd cdev interface.
> 
> Link: https://lore.kernel.org/linux-iommu/20260416144915.4fe38481@shazbot.org/
> Suggested-by: Alex Williamson <alex.williamson@redhat.com>
> Signed-off-by: Jacob Pan <jacob.pan@linux.microsoft.com>
> ---
>  drivers/iommu/iommufd/vfio_compat.c |  4 ++--
>  drivers/vfio/Kconfig                |  6 +++---
>  drivers/vfio/container.c            |  6 +++---
>  drivers/vfio/group.c                |  4 ++--
>  drivers/vfio/iommufd.c              |  6 +++---
>  drivers/vfio/vfio.h                 | 12 ++++++------
>  drivers/vfio/vfio_main.c            |  4 ++--
>  7 files changed, 21 insertions(+), 21 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
