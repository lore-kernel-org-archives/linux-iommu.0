Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2077.outbound.protection.outlook.com [40.107.220.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 564AC2E7184
	for <iommu@lists.linux.dev>; Tue, 15 Jul 2025 13:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752586663; cv=fail; b=Y5pDa5LDgLW+V6ydMV32jE52RtI6a4e5iFdiEdPqAn0FmIVKTqf9oFk8RCKThAxduSyo+eJSVcXIEgvpmQN+yZ8fRUrpCjziK3b22vT/NR5d1gq4/etk6JjRrcy1d0LJQMcNa/86+CefQ0uVZSJ71/Lao1yyPbjL+AZFG7UkPP4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752586663; c=relaxed/simple;
	bh=iMyQQcCIyM8FpFUTnz5r7K+RnvLD8Kk4X6xsuedOlYU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lWBsWps8LIVBTgvTsCKGcMg8Dm3THbHRUkU+2VXBPWAnHI9AdsNxNKb55mMl4ewDUuJCIIpud1X+Rp4D7NkH4IWjhDDhy57TKZ6D/pKM0JEhj0aKqf6nDUgYxYGtA8q2KEArUo93epNAb8GtDDR1tnyKUdIOeVIXyXRmozVZ5yg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Js4Z2aD7; arc=fail smtp.client-ip=40.107.220.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Js4Z2aD7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YQrRQl+/INe9GsfY6o4qgcVyNRMCpfhqyHY0Vf+vIUrUDEQW6GKB/r/td82bPxBs5NslqNrYOj1T9oYG9G6G1W8i2hytryM/QNxYZhwiuXd6hUyi6JUxshcDVJVKDSJtlPSy5Xw8rA2GQ8rOwC+4nCsXCPDzhie7ctlbJfp8gXrgbfTlLtCbb+Td3rY0uzfsrK6Zw8PGrU67iECAmDq66BD4MShJ9SFKyXvLThLg0l++wTCWDdFyooHF/LYRzqnwHWPv/D8HA6AViFmkVQYCPmbHEy7oksUHm5IfEiLItEqwwkOVOTUhPNuOoJPpvuUPHM3BHcQf+gDG4bH6CTsGTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BZVHRPtAYAvdlK6w4ntnrpn7G3UvJn5zBh4OTsnN7Zg=;
 b=GFViQMdPBScfCzgvWxF9mesNctdGeCdveTrZAZLun5yKou3poKXDsAlzdd2C6mzRjxF7UdJSRg0QVKidzAN487DF7zcpC4uDDGBiO98IHnBWVV/tGpI2zHmuM0ytOpdzdBR0LKMrGiMiKxfzxubl7YfUJ0mo4GKX4DcqGloBNbnb/iFcM8fy1aIlKBN+iDFpTBpIC7lKTYJsFhLFZADgvP0AV4NmmRPmDu+xIi+iLQoT08TcNqguvOEHekcoLAomO/dHDdlqF32x94fn/srBXSuwfEJ3uyale2anI/dpj6/kCE5GBBtZTRxgHUX4KDe7lnw2jqXMjCiUWIxwwEKh4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BZVHRPtAYAvdlK6w4ntnrpn7G3UvJn5zBh4OTsnN7Zg=;
 b=Js4Z2aD7DSHTNPl7iyMSsf081gnXWkUlZvv0nPy/hnUqpDoItIGlaC0qrEK9G9ycHwosU4rxEw6vGhkYUJdMhdK4uUVetghWStfxG7aH33tmXer3dSZGwFDx76dB4gw/vWP9POVoWvewpxnH7SLIEplO3JAF2mxODx0nw160ahrGVEPudInfUKxw9hVke9mlhVm29EVgoafpY0NWgcA+JI4sBSaPg5mWPNeCGFqqF7J8Grg5PHyDG1M79mx/dEPi5XNX1eB51lZVFXQbNmMnTiW2Uaoir2sJOAIqWWgrDB0VuINUMBYz9sqCsw6PiODLyEdT4lBsvlfqDu1VxplWMQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by BL3PR12MB6451.namprd12.prod.outlook.com (2603:10b6:208:3ba::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Tue, 15 Jul
 2025 13:37:38 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%7]) with mapi id 15.20.8901.033; Tue, 15 Jul 2025
 13:37:38 +0000
Date: Tue, 15 Jul 2025 10:37:37 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Xu Yilun <yilun.xu@linux.intel.com>
Cc: kevin.tian@intel.com, will@kernel.org, aneesh.kumar@kernel.org,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	joro@8bytes.org, robin.murphy@arm.com, shuah@kernel.org,
	nicolinc@nvidia.com, aik@amd.com, dan.j.williams@intel.com,
	baolu.lu@linux.intel.com, yilun.xu@intel.com
Subject: Re: [PATCH v5 4/8] iommufd: Destroy vdevice on idevice destroy
Message-ID: <20250715133737.GO2067380@nvidia.com>
References: <20250715063245.1799534-1-yilun.xu@linux.intel.com>
 <20250715063245.1799534-5-yilun.xu@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250715063245.1799534-5-yilun.xu@linux.intel.com>
X-ClientProxiedBy: MN2PR16CA0027.namprd16.prod.outlook.com
 (2603:10b6:208:134::40) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|BL3PR12MB6451:EE_
X-MS-Office365-Filtering-Correlation-Id: 884f05a5-d449-4eb6-3c61-08ddc3a4c3b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OTQqYKItbsy4zV0bjxFGWBfNiehM9y4eNddVr6hXydD9fpoy7dPf6W/FhDRR?=
 =?us-ascii?Q?QcK3BQbvHBb7widl6bcxRtQlzFv/u1aBrxxs/c4UWGGtlWSRf1d50/eoesVm?=
 =?us-ascii?Q?CL5g1gl/UEUOoS/+WXE3UhwTYsxFxccWDIogEsYyUKQaJqXfnCRBXyzrUEe/?=
 =?us-ascii?Q?G348iWHkf7qcOiuK0r1d7Q7xJb/MSd3k07gETIeH3Iuseyt/CKzhjKz0yqH5?=
 =?us-ascii?Q?A01YFdq1UeUeFC8vm9PvIMirnAuT/Rtjl0V8JBHyl9EflB77lFWsnKr2jHpQ?=
 =?us-ascii?Q?+KVl626HnvoFqWkruAuxFz4h9VVg/qFrfLshsgV2E3rLi6mI2FP5k/jmVOa5?=
 =?us-ascii?Q?ee3lN3G++4gCYPbhyOaC4hifcW0K1pf7E0vLOiTf6+VUDmYmP3EdkgBHGGye?=
 =?us-ascii?Q?RmJl1jiKJMgtvF3N+lIWOXuqSpcAT2X7kZbUTSToV6FFExu4BqtBe65d7Pbj?=
 =?us-ascii?Q?4ozhBntkJXIdQOck3tkj5i89HAHETdwbIgq4/PB0nEDduNTPeuSpgb8xRI/8?=
 =?us-ascii?Q?wO72CUUsgNzBMzUp34tJOnpiQW2Sn+Yzf83dzQPceQ+KvUClUxbyvOmalB7t?=
 =?us-ascii?Q?aOWhzB60NHRXtc3Z+V5iL/iWmPOx3VM4FarJPTuE5ShiLkg/JJPLqKdS26zr?=
 =?us-ascii?Q?MWUP92wsPnzxc688jgHDAE2RpyWVzTX2dv9yitnPI+zD9nVOT+k8YtzPdhQB?=
 =?us-ascii?Q?AGAM2pM+4XVH6WPk4Dd4HQVacGHK2wCqLLLOR9woIJg/V2eKvHnAhBfzNS64?=
 =?us-ascii?Q?00Fcqcm9K2i7CU7G+d2OFFK3QDM689BFL20hCRnQL5TZXD/WS2Xwvb0lYDY1?=
 =?us-ascii?Q?qimFYx/P6ORS5lVAKtQV6YMQl5kTb38vsi0P+Zwez+CDGgQmHj/1F5T06QfP?=
 =?us-ascii?Q?DwJly0iVnRJ+kh4LAZWARm/D/oe8yQfhUwxO5EZwLs7InLoy8iF1bgT0Z1Fk?=
 =?us-ascii?Q?r8C7gDQnLGctn4XnFwwcqJK0yfqEB1v7NVArOa8zhAKSYGN+MQa1jx1mp8b7?=
 =?us-ascii?Q?PFuSUdCKffOrlJxvpVXOpb+IOeFZg9fAFd79hPy49kuQ6H5qnj2hngh8KtiC?=
 =?us-ascii?Q?8TyBnBqPrtpKTW6QC22qGOgjUqJAD9aV3S2aB0YcEhLg77Vqd21/zTcspxBy?=
 =?us-ascii?Q?JhxUj5JxtUadlKGM7J66d3ZLB8zLmmkfeA30gl6P/RiYoBljy41v9nHhLeJF?=
 =?us-ascii?Q?LsmueuRNHXL+a8UqOdQM+F1PsyJW623ZfbuFPEVlDNVcIYeNaatiXxaq522g?=
 =?us-ascii?Q?PV2elwzNxuyVuP1BXZlOH9oOM1oaR281qNP4M556YleofyVKn2cCy3O77bfx?=
 =?us-ascii?Q?ea5IRlM65+Q2IGP4F8R+pPQBruwHcz3hGv+vJ8Exd8UzPQ/nVcIamaFqwnyt?=
 =?us-ascii?Q?VTXm6m/wW53vnKgfdbQJcIg/YJJLaGf1+BvUMtj6nusRJX+/ag=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oBwIgV9FHm6u7VLliF37tJ7z7mog4eD+yGTz7Iyewab9Wyip1m1hKimHZWhg?=
 =?us-ascii?Q?Te4+6wimOZ0H1Us1jmBkdpxgn+eeXKCfPecEAx5mVxlOjIXEdg1IvCzn/Df5?=
 =?us-ascii?Q?g0AyloieMzTfyPk/n9gH7fb2cBU9iBbRv+uS6tzEaIYXmmi24C9NBw0/HAdi?=
 =?us-ascii?Q?wVE2aejGZERlCM4pS5a6lQDbqs/XOqHjjAbG8ELHFva4/YC61aFujDlPX2cN?=
 =?us-ascii?Q?qoxrkJvvOcDW5844qapMLcQ1WEnGue4EXiS5Lk/yXfD9/D1cpPvmIBCPECJm?=
 =?us-ascii?Q?aDmnRVoplzgtIvJRIlS7vpMTdU4K66HyxT01fcO3W6GOQtij2Uh+BvMv4319?=
 =?us-ascii?Q?DM3i8Q5yffHPM4S0Ku6/3JiiPPRRl13F4RswqKp4rbj5nkyCn8whKXdvdRyw?=
 =?us-ascii?Q?A645Bir7trQ0hz4ZUspchtj6py/SkyetmATWhr7z/MZrE7vvDI5doMy8hr7O?=
 =?us-ascii?Q?toi8CGn21GiKS3BBlJziKd7slMeMvPj2Z23GjAH06BAtQ3cAB0sc4dbazOLp?=
 =?us-ascii?Q?84dXopuLYP4KOwCpIEUAbTlJhtnkx2ciudPmwy5Ay+ltTlJpinPe6HZ5kK4F?=
 =?us-ascii?Q?FtH2phE57+7aeEGBr78Ki1ZjJb6SC5FhcEjuKfFt1BBesDvOUAYiPHFxtZMx?=
 =?us-ascii?Q?Bm/BfpEwKN0rqElY6rJq9u9vMInkeU+t/1Wj3LA9hXcZVLnQlptsdCiok/CM?=
 =?us-ascii?Q?I+hiZJ2UkZgctG3XcFBkk4UhrM6dRaTgvdbOuDjznH+0mc1A7pG7WyqgIE6S?=
 =?us-ascii?Q?HvcySxRBBVTFXZKtg4mgbks+ovLCNOeIxdQmiUPSPmMsgwjHkitTBi5fxZdV?=
 =?us-ascii?Q?v2Pi88a6DVsIFE2oi8eOT2vMKmE6PZFvPp5NtQp69+8Ebf9twvpxqEBwoh2i?=
 =?us-ascii?Q?OLlkt3dLJkRxtjLK0/OG6DYXl1FBJMhyO+ID6W7h/KWURscVFKGVvyS/5OiU?=
 =?us-ascii?Q?fRPKiUCdcfEiDiVAjYbSUkd87f2RI3k0FJFGXDdenR0Wp8KI2eOP1Xu5cirO?=
 =?us-ascii?Q?PRvxllm+IsENyFldQdwspL0P7DtwE9bIWkRp/oplRiOJF5ZyOqHjy1ooNBSK?=
 =?us-ascii?Q?yEzV9kM/T8PTnlSYlDT3b4trOBxvq5689Rp8j2On9n6v5fJJ72MaC0GW0Pa7?=
 =?us-ascii?Q?khM40VOOUm0UYJpCmPm1+W86U0O1bqpAvr1xdNiHuChtwNT61QQuJ2yY3MAR?=
 =?us-ascii?Q?vMowk5qLyqw8XYntJee+bDYpNbqr3UNqzelhIw8U5lF7BTUXy1EWH+6Y6ynu?=
 =?us-ascii?Q?FD2beS9GAyXlRBgpnsOu6aDNYIUUUIZN5dtUnREYgrA4hT1Wn0Sa1JbwMRzW?=
 =?us-ascii?Q?NSvC9wGC6y0J4tqEw7P3sQxT7jGARhAzE5Dph5GH0kV5sbDf6r0+1JFyz34i?=
 =?us-ascii?Q?PnJebSsvljbPRs4VhIeUmfCyavA9Dvh8OSq/NsoQn/H70m50g6NKBDjNSpZS?=
 =?us-ascii?Q?rM7iRI55zZ8sonQoZLtJU3hzBCpYHUeKJz8i912rkLAsyIZvCV+VMYXP4Klp?=
 =?us-ascii?Q?dHdZfnRSKmsex8ppouPD7Nw970gQwoc8Z1kmTVufE/Yy38Az6wVJsbrpH4TB?=
 =?us-ascii?Q?FnZcknLADp6K3FiWibh6yYWsDLJlgKhXybuZ3A52?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 884f05a5-d449-4eb6-3c61-08ddc3a4c3b5
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 13:37:38.3966
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ifw3wxUHRS4PEwBN5FBY6UzSD1SF1y1lcDAzwKUWjgZo7fcFQXCVZxQemn9UfWSh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6451

On Tue, Jul 15, 2025 at 02:32:41PM +0800, Xu Yilun wrote:
> Destroy iommufd_vdevice (vdev) on iommufd_idevice (idev) destruction so
> that vdev can't outlive idev.
> 
> idev represents the physical device bound to iommufd, while the vdev
> represents the virtual instance of the physical device in the VM. The
> lifecycle of the vdev should not be longer than idev. This doesn't
> cause real problem on existing use cases cause vdev doesn't impact the
> physical device, only provides virtualization information. But to
> extend vdev for Confidential Computing (CC), there are needs to do
> secure configuration for the vdev, e.g. TSM Bind/Unbind. These
> configurations should be rolled back on idev destroy, or the external
> driver (VFIO) functionality may be impact.
> 
> The idev is created by external driver so its destruction can't fail.
> The idev implements pre_destroy() op to actively remove its associated
> vdev before destroying itself. There are 3 cases on idev pre_destroy():
> 
>   1. vdev is already destroyed by userspace. No extra handling needed.
>   2. vdev is still alive. Use iommufd_object_tombstone_user() to
>      destroy vdev and tombstone the vdev ID.
>   3. vdev is being destroyed by userspace. The vdev ID is already
>      freed, but vdev destroy handler is not completed. This requires
>      multi-threads syncing - vdev holds idev's short term users
>      reference until vdev destruction completes, idev leverages
>      existing wait_shortterm mechanism for syncing.
> 
> idev should also block any new reference to it after pre_destroy(),
> or the following wait shortterm would timeout. Introduce a 'destroying'
> flag, set it to true on idev pre_destroy(). Any attempt to reference
> idev should honor this flag under the protection of
> idev->igroup->lock.
> 
> Originally-by: Nicolin Chen <nicolinc@nvidia.com>
> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
> Co-developed-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
> Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
> ---
>  drivers/iommu/iommufd/device.c          | 51 ++++++++++++++++++++++++
>  drivers/iommu/iommufd/iommufd_private.h | 12 ++++++
>  drivers/iommu/iommufd/main.c            |  2 +
>  drivers/iommu/iommufd/viommu.c          | 52 +++++++++++++++++++++++--
>  include/linux/iommufd.h                 |  1 +
>  include/uapi/linux/iommufd.h            |  5 +++
>  6 files changed, 119 insertions(+), 4 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
