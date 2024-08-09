Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2051.outbound.protection.outlook.com [40.107.220.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92990168489
	for <iommu@lists.linux.dev>; Fri,  9 Aug 2024 20:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723235014; cv=fail; b=Zo25gRLyTD2jIw4L2qp2ODU5fs6WYpEzR0yKGkxA329naTzV02+5Ohz13tHXljyavn0hJPAhlDg6FDn3QdEiXCw4vToo1dzmPqRSwqIF6osaMH2rTcJnS/Ze0ZT1thgsoi8BrTMqLszOqJ6OtAOW2rJz9bTkgfNfMAbkxouk1tk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723235014; c=relaxed/simple;
	bh=BXlhyw9UH7BK2cz4aJOqSv02koOzVQ6Fbo2p9qqwvzU=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m6fIRt1I2CqF3nUHQnHrJv1fCjujf6Q++uzbO594PaE0uN8/tYSxL7rpw9zWcmY7Cljo/MMkNRDqLbvwcyFS868pK2TDubjEA9NiXlpG29ZYq/P1TJSEhvK4zHZuaXJrCPQj+TgyY3QoCggfo0rqsu8V6yWqjGwyFz14jDfkRdg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=br2DyA6I; arc=fail smtp.client-ip=40.107.220.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="br2DyA6I"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=meF/dVgjnKjntdLq3zqfG38uYntMjtFBtXPy1OW9PHCn6Mfh+cBFjSc/W9pItgBryjv7KFg5510yeN7VV4dffQS89zDdb+c7m5CxDoD5wg+qUy5DJTdJLVnCt5uqxgrdajHRuXHD2ITAjOwVxF/vRnGg4Ts+08sI/wrDrm1aR1qva2CA8rZr16eWjaRu7ZcqZwbkcVJgcU9HJQ5UmvLKtzE2PChIczvJ8vun/6h6higopX/W+4T/+Oqfi0/FLAw+nyinbEUj6Fj9KoB0PRdTxKzPNlbpVLhFYdHEdZiWuuUg5gsT0nvQxxlQXh7RCq7cRK+dpiF024x7ZElH4uxasQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j6ItZ04HmAP9wjXNnxietDYNikNEoUIRLme9W7yrWuQ=;
 b=NJF8ihGT54N4WjPEMjGtG6xugrC4Up7COWPccaVVglcO04MJpW5QonwgiXTxNxIT2qmwd3+7piCTiz7hhFQek6AMgxyC9822ZqsL5P39wqisvlCLK92fuhAjFuyKIVipg6MWj5sDQuBdChYsngIgn0Vtd1boROVWpNQ/Q+/xJoXgPWuapdmU/0dA4uVAMLS8NwYurKHCbdxpyUFo/gLjPTEx5YGD0lMOv/P1oJlyCvoJXm36R/l2P6pZv61UbWLIRyUPJuPOToNvq/i6Mq110TilN5FeKkwn6MOtAYU3ibgtYk2qaA3xKZ1WUNfSfz82cGnLD1Bx8WJSCqJGOqTbDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j6ItZ04HmAP9wjXNnxietDYNikNEoUIRLme9W7yrWuQ=;
 b=br2DyA6IlKMsCHWhi1zsBHiFo7ReL+7C830x+8KQl+6N/JwpZAt+Fr4Axu28/M5y3vuQK1lLgcTRZpix9oYqFaGfYdn2hGOWnW6ORDHC0JG3b0wmiZ4NL0WfwdRUzuYTeSKGkC/ft/7L9rUCqsYok/j9Lcy55N7H/QY7TMcX0UczhC/aiCkynjCrmAjrasrYs5ZPDzpMegZrIY026XNyAVeXZasO7lPwkIz9kHkduP2pAP+UzpspJQ9kCEmAwWPFrhb8eCMY/thaU2rulAWVvVaAZszHYDlTJYUGeB+KetSA+niTPozkITnFBMeKbP8LsfLk7W/eoyiCUDBL2LLfSw==
Received: from DM6PR11CA0065.namprd11.prod.outlook.com (2603:10b6:5:14c::42)
 by IA1PR12MB6185.namprd12.prod.outlook.com (2603:10b6:208:3e7::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.15; Fri, 9 Aug
 2024 20:23:28 +0000
Received: from DS1PEPF00017093.namprd03.prod.outlook.com
 (2603:10b6:5:14c:cafe::6b) by DM6PR11CA0065.outlook.office365.com
 (2603:10b6:5:14c::42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.30 via Frontend
 Transport; Fri, 9 Aug 2024 20:23:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS1PEPF00017093.mail.protection.outlook.com (10.167.17.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7828.19 via Frontend Transport; Fri, 9 Aug 2024 20:23:28 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 9 Aug 2024
 13:23:14 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 9 Aug 2024
 13:23:14 -0700
Received: from Asurada-Nvidia (10.127.8.12) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Fri, 9 Aug 2024 13:23:13 -0700
Date: Fri, 9 Aug 2024 13:23:12 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
CC: "jgg@nvidia.com" <jgg@nvidia.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] iommufd/device: Enforce reserved IOVA also when
 attached to hwpt_nested
Message-ID: <ZrZ6sBbDK5gJtbB8@Asurada-Nvidia>
References: <20240807003446.3740368-1-nicolinc@nvidia.com>
 <BN9PR11MB52762AD4E68BC0FC10CACBE18CBA2@BN9PR11MB5276.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <BN9PR11MB52762AD4E68BC0FC10CACBE18CBA2@BN9PR11MB5276.namprd11.prod.outlook.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017093:EE_|IA1PR12MB6185:EE_
X-MS-Office365-Filtering-Correlation-Id: 35f8d285-33a5-411a-8822-08dcb8b1212b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Ii3BJzTqHlLZRvYk0FlbG3h1lK/uOMoPNmqU7RBzLF2xzIgi4wDpJE+/xmAP?=
 =?us-ascii?Q?yiUmSRcfFjBZF1cniYoe2LJoK25HSUV1SX/F8MSrKUfOlypPAUDJG9T9DTQ/?=
 =?us-ascii?Q?BTXqxiEphdd4WuZIpoCw1E2cJVGsAYPgz7ZA/DrZuaQ6ANt9xLTUROfJMUe0?=
 =?us-ascii?Q?GJZ9YdFHbLl+OCGdQffLIqB8T2EhN8ExBID9gqZFKlvsjEpeM8H52sF6H3iF?=
 =?us-ascii?Q?qQO2Set76qV7UAH1Hgc5vdbjNrUNkvFrHlLqzWYLq68u4L4Q2AwgpZPBzdOH?=
 =?us-ascii?Q?9lKgihL8Z4cNghFn/+n1/VzgCIbImfZdYEkLv39386YMsmJxmIdmLaya4lFY?=
 =?us-ascii?Q?FGrTVRPpVHMZroNf9YCKyoEQIqtH4WcmmlmlTWUcQ+4gmmhajUb3O4YKamZJ?=
 =?us-ascii?Q?jIip0/kqs7xvUl8UmZKCdMSK+RlFZd0d0DFFSdiphmyFxORIDTcusr4viqgz?=
 =?us-ascii?Q?5UMfbJSIYRA/z4b/kW+RV/H9pAVqsYXzq2spTVdNX5+xdVt+RNjgILPpi3PO?=
 =?us-ascii?Q?bMzByJRXiMfH+TR8Tz7aoO7KrM+q10pYqZjRoZ2Wq8nIyP+MZ0fgYjbgcnCo?=
 =?us-ascii?Q?mUHFQjJOhrTaUnHhDISrGsSXzVT7Qw4o/u2yO+w5j4G/WaSlHHhsxEmfhmyB?=
 =?us-ascii?Q?yOG9MAv3SSJGBJSc9XK9lSFUgf2wRkyZCXUlHH+efzQBWPbmsSqTYyB9pRJA?=
 =?us-ascii?Q?sVAIbaJAtyS3pQYC+1b62PLyHWJzpop0AT0fm5mtB55hCbgtCjejDbfrrHyM?=
 =?us-ascii?Q?OglZ42zdsEMxzZYxyrX5q4Ag6BNqz8kiOw3GfGrkYc7kuY43gv82JiUXk2Ry?=
 =?us-ascii?Q?BkU+fQhdrtsDZC8mFOCNkF1OKqJNNLpRisJ3ThwmIKcXLvHdalfrOx8pb/Zi?=
 =?us-ascii?Q?gZznsMDB4gqlA4Ru1Le8kbtJA4HhdI9hGHxPsG2fckgombYXUP7C631yuhsg?=
 =?us-ascii?Q?xa63PPmYEYtsnVR7YLg0VcOlmr1vywXzl8fvpwfN4DlYP3Ugx6ytlKsWB5tb?=
 =?us-ascii?Q?AdMShnEsfH0urV7hM3nnbyd2gJ1Z39TBt+yM9kicVNe5tCfLyrNha1+c/odK?=
 =?us-ascii?Q?JuugNrmQC7g6s5v7vuhnKZFxp92F0K9EhL3ufO24+vMSonA8f3rEyER9JvOz?=
 =?us-ascii?Q?6/5HXLAJrC2D91UwrucLSRTzZ7yNjpoTkduKPPjGfGBNagDDkwkK3pcaq+3x?=
 =?us-ascii?Q?kfRTUvGJDGWOX6c2FIn27fr3AHcWWNr11Ja3HangJdfDAlVcbaOEXcJ5QKKk?=
 =?us-ascii?Q?WacgqwoPdw/KUVY8j0mzoDtS9iG/KcblltVwDZPhDL7Nj1h5br83P9rcHbIZ?=
 =?us-ascii?Q?dIGFFpEGlUDBKc+WtAEat1zieDvD5CknSME6eDd2iXKqgnoRF9ZTeUpAX7jg?=
 =?us-ascii?Q?qQqo4hMOFyJLt7W7bkV7evHBkso5hTENjgsoHMfnaa4wB0g46CphJCO8wIdP?=
 =?us-ascii?Q?xdJddgvlHLkL76YJemGX7CJaLvyARnW3?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2024 20:23:28.2959
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 35f8d285-33a5-411a-8822-08dcb8b1212b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017093.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6185

On Fri, Aug 09, 2024 at 02:00:10AM +0000, Tian, Kevin wrote:
> > From: Nicolin Chen <nicolinc@nvidia.com>
> > Sent: Wednesday, August 7, 2024 8:35 AM
> >
> > Currently, device reserved regions are only enforced when the device is
> > attached to an hwpt_paging. In other words, if the device gets attached
> > to an hwpt_nested directly, the parent hwpt_paging of the hwpt_nested's
> > would not enforce those reserved IOVAs. This works for most of reserved
> > region types, but not for IOMMU_RESV_SW_MSI, which is a unique software
> > defined window, required by a nesting case too to setup an MSI doorbell
> > on the parent stage-2 hwpt/domain.
> >
> > Kevin pointed out that:
> > 1) there is no usage using up closely the entire IOVA space yet,
> > 2) guest may change the viommu mode to switch between nested
> >    and paging then VMM has to take all devices' reserved regions
> >    into consideration anyway, when composing the GPA space.
> > Link:
> > https://lore.kernel.org/all/BN9PR11MB5276497781C96415272E6FED8CB12@
> > BN9PR11MB5276.namprd11.prod.outlook.com/
> >
> > So it would be actually convenient for us to also enforce reserved IOVA
> > onto the parent hwpt_paging, when attaching a device to an hwpt_nested.
> >
> > Repurpose the existing attach/replace_paging helpers to attach device's
> > reserved IOVAs exclusively.
> >
> > Add a new find_hwpt_paging helper, which is only used by these reserved
> > IOVA functions, to allow an IOMMUFD_OBJ_HWPT_NESTED hwpt to redirect
> > to
> > its parent hwpt_paging. Return a NULL in these two helpers for any new
> > HWPT type in the future.
> >
> > Suggested-by: Tian, Kevin <kevin.tian@intel.com>
> > Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> 
> I'm not sure the name find_hwpt_paging() is good enough but can't
> find a better alternative. So,
> 
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>

Thanks for the review. I couldn't figure out a better name but
that :)

With the ongoing discussion with Robin at the other thread, we
we might be able to get rid of the msi_cookie. If so, this one
will be unnecessary. So, we might want to put this on hold?

That being said, a new solution will take some time. I'll need
to go through all cases and untangle the msi_cookie cleanly..

Thanks
Nicolin
