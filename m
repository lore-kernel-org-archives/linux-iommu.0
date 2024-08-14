Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2047.outbound.protection.outlook.com [40.107.102.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F0EF4D8DF
	for <iommu@lists.linux.dev>; Wed, 14 Aug 2024 23:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723678299; cv=fail; b=EWUEFkGSCuyvLU1A23ATZsh4Rnf/p1AuqqPqDE4glmAY/R6fPqRd6W4wUlggtPXWi4oJxp/ROpdqQBJm/4Dl+9Ya3MDDjOPL7RcuVJ0Xlk3foRx7e1qnmkX6g458RoXYgCAQdoMAlUgu0XbG+pAjwxXwjsJugo8m70EPfpfi8DE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723678299; c=relaxed/simple;
	bh=NpoHJCiPp4DM/KE0sgLqa3QgjXo9+spbfWePwcmh/kY=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H2oraqqWhV8yZVcEu9BEKNWzClYu9yBfVuDnJddv51peyYMetKUXA+3hWhHm9yK3mDF5dLQbNRVwEL2KONdI707Le8QGUbdw0if86vBNs2FUmz8bDsSiBpjmSoVst4NhbdenH1pJGaTAWQvRxyEWF4TCPZUPmPnduNZyFw5fkdk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=LFOFw2Gq; arc=fail smtp.client-ip=40.107.102.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LFOFw2Gq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FxTuAB5o+TWSevWvFTna7NWl9aE7KF6PBJFJmeottB7m2O5Zukavjbwt0wPVuahfWsZiJUZuO7nLQBNB2a00b+TO3I3vGDQglGZyF8iT0RZMXNekDJF76ef/6TRvyjqDx55W7Ke0yJTY14U32w1mq2x/z7DUsePASo36W3JLr+X6GrM2g+jL4QURrioGWhwrT4hhPloELgto5lB0slSawpJoEXZBSsp7iLpnChDMjT0ciiIJXhuK6HByOABvwLN5nOjYJiWQ4FnZ+gBj4wm9srVarxK1SU5LUJdqaQfJylHq2bPqLP2VscWitTs0eDictkH97IEKwRKIZNaQslNVrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pqBU61wjf65+Z1vrAH9rd1L8jX6PeFdlq/bzv5idkL4=;
 b=Sbw8v7QW/NnPIuiNjaQJBvTNrlnF6w6HJ3dA7P/a7ej19kyxQiCQjQpfPW/xDHMxoV266QTsUbi6Rf57miSQs3HnXw8bwdiszQc1vwmLmyFZI/r+JFq6SHF8Ji+KImaXv05DXnZxZ5g/KZckhb6zOJVNsYsWBLqSz+8i/tzmNlDcB/RbNS/mgvLqLqAoVK50EP7VMtjco7V8nKF9UIV0ajSavijUcnZPanycjwX7bZOOxjMrDpWoBW9Zo3yDOft9rwTKYit1h8eiG9BRVdrjZcESNQje3SDK1uLN8J+fBA23EERk++CpH6Pj0uPJz4QlFV5Z6nQfDL1VwUAc/GQyjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pqBU61wjf65+Z1vrAH9rd1L8jX6PeFdlq/bzv5idkL4=;
 b=LFOFw2GqcTB0sUFPidfpQzusMOrGmEYO/Bc3PqnXYjuDG12qaTylk2DPIk6BCMRQRP6DY48BHsKnyVXxrnTrNx6OykPvglWhc3KiL/Mw3pgpesr02W+2ksF7/e1o9roIhGhmZEc9AhGmdu3sz4Z+2kzvMSHXrGaSc9Qe59XhdCJdo0nponY5qsZ85gunhv0uiyw+bPE994wfSKxek2v2LbxNBkKeFNo5ubc6/eI70Xm3spCdh4cskkLzsD9/2+raQ43C0M1P4ek28nQYUj7N5PtgotXTomgB17FRLCWU/Rt6W3QlyMinqhPZOfaKk91LLvEFJ9zGJYtMbaTpFyL81Q==
Received: from PH2PEPF0000385E.namprd17.prod.outlook.com (2603:10b6:518:1::6c)
 by PH0PR12MB7096.namprd12.prod.outlook.com (2603:10b6:510:21d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.22; Wed, 14 Aug
 2024 23:31:34 +0000
Received: from SN1PEPF00036F3D.namprd05.prod.outlook.com
 (2a01:111:f403:f90d::) by PH2PEPF0000385E.outlook.office365.com
 (2603:1036:903:48::3) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.23 via Frontend
 Transport; Wed, 14 Aug 2024 23:31:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SN1PEPF00036F3D.mail.protection.outlook.com (10.167.248.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7849.8 via Frontend Transport; Wed, 14 Aug 2024 23:31:33 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 14 Aug
 2024 16:31:19 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 14 Aug 2024 16:31:18 -0700
Received: from Asurada-Nvidia (10.127.8.12) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Wed, 14 Aug 2024 16:31:18 -0700
Date: Wed, 14 Aug 2024 16:31:17 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: "Tian, Kevin" <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] iommufd/device: Enforce reserved IOVA also when
 attached to hwpt_nested
Message-ID: <Zr0+RSaQk8e/8pl1@Asurada-Nvidia>
References: <20240807003446.3740368-1-nicolinc@nvidia.com>
 <BN9PR11MB52762AD4E68BC0FC10CACBE18CBA2@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZrZ6sBbDK5gJtbB8@Asurada-Nvidia>
 <20240814223843.GA3972912@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240814223843.GA3972912@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F3D:EE_|PH0PR12MB7096:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b114f11-2aa5-4994-9d58-08dcbcb93bdb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BIgdQMe3K9aTxCyP+137JUdynJlF4y13WFc8iVPMr9NRcFXIFFrUkGdThLBX?=
 =?us-ascii?Q?ymDIJc2G5OPk82zo2+h+kx+5afGLcNzMI0wkHK7hXpbrmW1SelVR7NLhptym?=
 =?us-ascii?Q?2LjI+cBxKpncEB/0BNN7wPBOvg0wJmIrbVd+bw1NRPuLJdGQ5dcv34HvjvRk?=
 =?us-ascii?Q?9i+i2DUn93uj7+ltwJSd0h5lxVwiMym9j7l4yPao5k/hxYTRPRn6anTGPGTG?=
 =?us-ascii?Q?nnSFK/ZfzbGOfz0uAVAQT3aHJJnAUDZosm2kUXXa3IpghkW4wNlb+27YgojT?=
 =?us-ascii?Q?6Xn8FkMMve8EIPuVABAOH47gW00VtBiwp98BYs44n2zc8mB8MPGSvx85hYNA?=
 =?us-ascii?Q?TFpLkGEGLUm3XjLC+TyEOeyLKvKNQowV7QYgouAJvhr8OD3me44QIudAYxRM?=
 =?us-ascii?Q?hPBxoveiPH+Uq5nS5wfIbl9oeNYOn+jFxQ5O3Qwtq5SXRw+CRr19PfO3cQNY?=
 =?us-ascii?Q?ekc6Q5mGbfrLQxAXJRrE3x524QtW0E9FK/wa2wRHFS54ndtIEdZglCgcs3X1?=
 =?us-ascii?Q?KS6EilRpdX9Y9WV5QuxSPjTEIC8k20p06VKtwp2W6Gg87ycHgS3pCR5rnTKW?=
 =?us-ascii?Q?Zil/nnB5jk8YWUJSgcgD7rSmZsndkKHVRvhFxrkktzqjzYEgCPWETS9cllNl?=
 =?us-ascii?Q?GHqBmNKT4cA9PG4JY62d0Dz1kD+i76cP8X7xzQSvH8Ur8Azds/TLyN5M9z9n?=
 =?us-ascii?Q?CLA8UX/GLc4lSqdBgc4q+wYfIgbc5vtGfnIn6lL1msXw8LDmF48FuuOegd1l?=
 =?us-ascii?Q?TjnPesYTSOJ6ZJBDo6Z0MdOFZC7aZz4rusY1QukjXwfU+jBrZcztTc1Uli/M?=
 =?us-ascii?Q?CCsTtVEMG0bFoq68ZJ2r3V77+xlumcgESevUUYuBH5ZgZ8mTCsLa6+/R0RTz?=
 =?us-ascii?Q?t9ZwDskFVTxe3Qme0Gy2mY09JEF2GdcO5y0Cv37lm6IxAbtBtjEHfkr1YQjB?=
 =?us-ascii?Q?nv/02ME/nHUHXVH9Z7fjH/8rafrM4wBDPq8Ojiwt9XdcdmeXeb9IrY6Lu96a?=
 =?us-ascii?Q?ojFIMbJjt4m4yqU/+AWFeEXJGhyXNpwqtz1gGIiYURt8IfUyS7MdH8dxGn+g?=
 =?us-ascii?Q?Kmlt8zJXdg6yvHCQjEhfJKGR1botT9Sc4zqr7Fu/4FAUXFDfzDylrhhnZDax?=
 =?us-ascii?Q?6M3mzL+nRraRtXgTT6dhcwFsCbRhw5V5IDA0t5c5Amt7+BKGhD7trK473g6p?=
 =?us-ascii?Q?XDcJQ+k16eFug91vdB+wJGD83q9yCQNSrnPgazhJuFc3f8+7ZxQJZh/u1Gso?=
 =?us-ascii?Q?ThaXinh+LG4cErtwFbYSUzc1ELX6oGBohXCVaCZJmdaAan2042EuyTMm7eeT?=
 =?us-ascii?Q?c4zzW07la/+0Vv6xmqUakp6SPno8JTQKazkLxQT3ScO/dlOYPtC5im38jidj?=
 =?us-ascii?Q?hXEmf6k1PNydbddM9a7PP7wDrZWbfsbWOHWxmJcs7xT5UZhShjUKL6Kr17XR?=
 =?us-ascii?Q?UAqNflQJ1U1qoVxXdqzggFmAHxcW1dt4?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2024 23:31:33.7581
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b114f11-2aa5-4994-9d58-08dcbcb93bdb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00036F3D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7096

On Wed, Aug 14, 2024 at 07:38:43PM -0300, Jason Gunthorpe wrote:
> On Fri, Aug 09, 2024 at 01:23:12PM -0700, Nicolin Chen wrote:
> > On Fri, Aug 09, 2024 at 02:00:10AM +0000, Tian, Kevin wrote:
> > > > From: Nicolin Chen <nicolinc@nvidia.com>
> > > > Sent: Wednesday, August 7, 2024 8:35 AM
> > > >
> > > > Currently, device reserved regions are only enforced when the device is
> > > > attached to an hwpt_paging. In other words, if the device gets attached
> > > > to an hwpt_nested directly, the parent hwpt_paging of the hwpt_nested's
> > > > would not enforce those reserved IOVAs. This works for most of reserved
> > > > region types, but not for IOMMU_RESV_SW_MSI, which is a unique software
> > > > defined window, required by a nesting case too to setup an MSI doorbell
> > > > on the parent stage-2 hwpt/domain.
> > > >
> > > > Kevin pointed out that:
> > > > 1) there is no usage using up closely the entire IOVA space yet,
> > > > 2) guest may change the viommu mode to switch between nested
> > > >    and paging then VMM has to take all devices' reserved regions
> > > >    into consideration anyway, when composing the GPA space.
> > > > Link:
> > > > https://lore.kernel.org/all/BN9PR11MB5276497781C96415272E6FED8CB12@
> > > > BN9PR11MB5276.namprd11.prod.outlook.com/
> > > >
> > > > So it would be actually convenient for us to also enforce reserved IOVA
> > > > onto the parent hwpt_paging, when attaching a device to an hwpt_nested.
> > > >
> > > > Repurpose the existing attach/replace_paging helpers to attach device's
> > > > reserved IOVAs exclusively.
> > > >
> > > > Add a new find_hwpt_paging helper, which is only used by these reserved
> > > > IOVA functions, to allow an IOMMUFD_OBJ_HWPT_NESTED hwpt to redirect
> > > > to
> > > > its parent hwpt_paging. Return a NULL in these two helpers for any new
> > > > HWPT type in the future.
> > > >
> > > > Suggested-by: Tian, Kevin <kevin.tian@intel.com>
> > > > Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> > > 
> > > I'm not sure the name find_hwpt_paging() is good enough but can't
> > > find a better alternative. So,
> > > 
> > > Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> > 
> > Thanks for the review. I couldn't figure out a better name but
> > that :)
> > 
> > With the ongoing discussion with Robin at the other thread, we
> > we might be able to get rid of the msi_cookie. If so, this one
> > will be unnecessary. So, we might want to put this on hold?
> 
> Regardless this seems like a bug fix to me that we may as well
> take. Unless we intend to retire the entire RESV_SW mechanism it
> should work correctly.

I am hoping for that, yet can't guarantee of accomplishing it at
the end of the day. The SW-defined window can still be a default
region, stored somewhere in VFIO/IOMMUFD instead of the RESV_SW.
That being said, the alternative solution is gonna take a while
to finalize. So, probably doesn't hurt for us to have this patch.

> When you say "enforce" you mean both that the reserved region list
> reported to userspace does not include the region and that the
> required mapping was never installed in the parent?

The "enforce" in the subject is a quote from this function:
iopt_table_enforce_dev_resv_regions().

So it might be more accurate with:
iommufd: Enforce device reserved regions as well when attached to hwpt_nested

Thanks
Nicolin
