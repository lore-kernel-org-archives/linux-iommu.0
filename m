Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2058.outbound.protection.outlook.com [40.107.100.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A77FF374F5
	for <iommu@lists.linux.dev>; Fri, 24 May 2024 06:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716530614; cv=fail; b=Am4jW6HBmIBr5zzc4CHSuS6YosXJFQfY8gqdSWy0Wzre22BQZKqy0ILhl1RHAwvSAvVTwUXL1Subrp2TsxwCczFtLkcZk7M2kf95LhBLBm/CiPF2/mcfZY2pknaSz0FOLyqsOL0gX4FmR5jr6UCNRAx+lgD+dsT8rOvrMBtVerU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716530614; c=relaxed/simple;
	bh=9x+cUq2iZpGSEyE43loUE9ZUzEXFIu0T3Q+GPMXxwNc=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q1JkMvm87h8m4jjEK62P7l1REGoHnzKA3bLO3a++gfaL9kF6Jxv6a4mTh+aOQxoFKt1XjZdKtFd1PNtl1ZRCfARuPEEJ9NlSpGgwbbZQDBAF6JUrwVvJ2Uq1HwSUROj2zTyP0QqX2Bk6UrXzv3KqhdN1/IDJdSzBa5KzX+vbvWI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=naajt1yb; arc=fail smtp.client-ip=40.107.100.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="naajt1yb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YKH+Q+Bo6ZBV9PZxVIHzeiRr32E6DAMUPoSWiY5O4O4497xZp22+GR/bMns9Ezaka0jYFCmWGDsW0mt9N0P+yllqXA+XjZl0s9o6sD0tPcwyGI7Sz0V+tBmgvF36dpNFU06exeknbKN+ci1k2zNvkkpEMiYPsuUaqEF/UTz8zi2hWJ1+Uw4OR+ntILMfiuqk6dHrGDoUTZCcLysgqwoejYKVsXEj9XO/P9Od6DHvzs8ySdWbzT0p4NrU8/TY8KCYF+d9Wtze6npc8oVlLfxBnAXy0Wmv0eSkSScAfPssbvbWhsDrbsGpHJL8oynYZqtqeqKTN55h6sOwLtDg+vrQoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ef+2mRRG73lFHbdWJHp0LGQmdCBz434lS9vvUK6BpQI=;
 b=UHgId3lUNkYEzK9jesN+omCDkgnejkCp7uU50lxW8J9G7OcLqebgCkP4gNvguhbVL0dmfZ9qszn8BdeODRsmGHZnygqKZgEO7WJh/gGajjztsubJP/Y4sZvID6LpJrtmBc+QP1XhxxqTmT2OW7xu1VZhx4wvWf28ljf34IWqt4Lz+sWnuhkgnn+A2GOty3C/yJmSUW+zxO7c3AMj73zG38JCLXBRHzJG6X9OOltyewb/FZvbKhX0jPw+DH7eWDdfzlBwhc38N33J/toRvIBRnVO/P8h4lsff/Y0zIdplZCQJxNvIxs7eydu0l4/mM2lmI9FkAYxip5M3ZurKUXjfTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ef+2mRRG73lFHbdWJHp0LGQmdCBz434lS9vvUK6BpQI=;
 b=naajt1ybsHZ/NhBFObWXZuOVEToWUZo7GLmXn3pcvGbEiXwSjau0p1u81Z7aBITRxB3nziHSWnuj5NamFRKK1YQ6COkBBU3bnnZEIr7+BQqIYw2XDQjzDX8Lr1DIcoVpeMZZeDs56cuwvpRZpcus9zFcNWT2B5JRhlf8xM7YxDcWGwtNad+sxvcaVLxHH36Hibod6MiA3kaAOIb31gjavM5ynLV5Y3pzIPnbQUY9hF0WTHMthP05o9E/n9SUWJbdm4GtgpnFz4sGHy/4B4f98OcFmC+mgK63vhN0krJlDeEcfn9XJGYKRXTih6LmuTRmcSR1f4kDvnIGbK/oTy6Vsw==
Received: from DS7PR05CA0003.namprd05.prod.outlook.com (2603:10b6:5:3b9::8) by
 LV8PR12MB9153.namprd12.prod.outlook.com (2603:10b6:408:185::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.22; Fri, 24 May
 2024 06:03:27 +0000
Received: from DS3PEPF000099DB.namprd04.prod.outlook.com
 (2603:10b6:5:3b9:cafe::ee) by DS7PR05CA0003.outlook.office365.com
 (2603:10b6:5:3b9::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.19 via Frontend
 Transport; Fri, 24 May 2024 06:03:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 DS3PEPF000099DB.mail.protection.outlook.com (10.167.17.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7611.14 via Frontend Transport; Fri, 24 May 2024 06:03:27 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 23 May
 2024 23:03:23 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 23 May 2024 23:03:22 -0700
Received: from nvidia.com (10.127.8.10) by mail.nvidia.com (10.126.190.181)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Thu, 23 May 2024 23:03:19 -0700
Date: Thu, 23 May 2024 23:03:17 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
CC: Jason Gunthorpe <jgg@nvidia.com>, "will@kernel.org" <will@kernel.org>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>,
	"suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
	"joro@8bytes.org" <joro@8bytes.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-tegra@vger.kernel.org"
	<linux-tegra@vger.kernel.org>, "Liu, Yi L" <yi.l.liu@intel.com>,
	"eric.auger@redhat.com" <eric.auger@redhat.com>, "vasant.hegde@amd.com"
	<vasant.hegde@amd.com>, "jon.grimm@amd.com" <jon.grimm@amd.com>,
	"santosh.shukla@amd.com" <santosh.shukla@amd.com>, "Dhaval.Giani@amd.com"
	<Dhaval.Giani@amd.com>, "shameerali.kolothum.thodi@huawei.com"
	<shameerali.kolothum.thodi@huawei.com>
Subject: Re: [PATCH RFCv1 12/14] iommufd: Add IOMMUFD_OBJ_VQUEUE and
 IOMMUFD_CMD_VQUEUE_ALLOC
Message-ID: <ZlAtpSAvDgGzZwUG@nvidia.com>
References: <cover.1712978212.git.nicolinc@nvidia.com>
 <b0ee53af3f59602834e67ddf86c748ca304da175.1712978213.git.nicolinc@nvidia.com>
 <ZkDZ/YO0jqZOlRtA@nvidia.com>
 <BN9PR11MB527668B2398FE65771A429D08CF42@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZlAao39Zc+9moEDP@nvidia.com>
 <BN9PR11MB527672C2366F7F6DCA33FD948CF52@BN9PR11MB5276.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <BN9PR11MB527672C2366F7F6DCA33FD948CF52@BN9PR11MB5276.namprd11.prod.outlook.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DB:EE_|LV8PR12MB9153:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ca6a3c2-0375-4743-865a-08dc7bb73aaa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|82310400017|36860700004|7416005|1800799015|376005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7ZV9Z85+QIj02zzcuhaDd3Rj/8K4W8e/rb1MwuSJ+pPxO2BoAl+ogKKU1Qrk?=
 =?us-ascii?Q?+zok5IKl44+5i12K2W5mV+8rUExTvuWDy5S0A/0LkyznfNXiIN1yw+yV4IjS?=
 =?us-ascii?Q?sua4CP4LaXtTCk7Wt4avbvA7fgeSVjLHQH5X9xGVFbpwKgpjTGRGYG2xYZKH?=
 =?us-ascii?Q?jmCaR6xIAw2lXQVOul9LboIiQiCJyobWAcwp2A1xzPJq7cIRY0K8uvCZ5Iy0?=
 =?us-ascii?Q?qXTmW4b5FQkWdHJyMiUwcItuOExb3L/1Gv7xuYMEHOrqjJNnQsT4ucBgrBjz?=
 =?us-ascii?Q?yj3Dfxj22sdljbfgIMIkQj9xjTC2HZbO7c+lWuKkMkSxGfHLAlBKGHAFK2HE?=
 =?us-ascii?Q?pfguo2Hr7dyKUxkQ0FNoqq+MC0U9dYVKOkJE6L8n0IUdwvvn0Ju0S5AvIUII?=
 =?us-ascii?Q?L3NqIh73vJlxDVpT4UMWkEikF2vUKBTqFlwyiZJhqT0AXoNzU/Ab5JZvm2rt?=
 =?us-ascii?Q?WOP3436tSEG6V/FT8etVqtKgCGAjcmLOdwEYUKsxfLf5Qm7A/PFzGEvLCNay?=
 =?us-ascii?Q?w+4/aekbRRJHA9V5bXqqY2oU80jTDuYHuvKRTz6zIRqx2cg8slWxMjOnSsf0?=
 =?us-ascii?Q?TcJ86lrqoxCE4Y0z4tth9RZr7pNRL8eZqjLZVYdhksD6uqO7f4YNFvKfSrs2?=
 =?us-ascii?Q?rIJrKYHs2K1fqDvwjb9U9Hn9Z+ps9KAiJw8f1CkdBrKD3c5w2NHBaSnXOyKc?=
 =?us-ascii?Q?G18uysKq0iwYwOsRqevrFxNos48z41o441BrWY/g7qwG5Ecl2uXqpihDLEBo?=
 =?us-ascii?Q?BgmStyelgMQELzHvEofrNcvKa56/im7Fh8GHrPovd+AQmV1CS5HSKSvWe9rA?=
 =?us-ascii?Q?UhIIVyzjkjENrdQRWS5p6Mems3pGwKaXB86Jl4nRzWiNJsjQZyEFwF3Frt5Y?=
 =?us-ascii?Q?m/nL9eKADQVciDYSSJxNxAn7qmi4KWFdmU+ax7dcGXBfvuBS9+uHpJ3i4U6d?=
 =?us-ascii?Q?CGqSwIBLLJPC0Zf8QOtzGrJqLBHbvf+pOckwqMYUa2q8pxgnSKFGCj/AkgVJ?=
 =?us-ascii?Q?/RXeMnnEV/vp+3BOrEZTzCQk2mltWa4Z8Q7hUDjuYa0muLPrhUsstbqEA8gz?=
 =?us-ascii?Q?lAeX+VR/L/XkqcQT54amy54INuPbOS6fb6BJnqaw5F2IksRQyKEeXoJ8etG/?=
 =?us-ascii?Q?0KGw3R0HB/Jxtqc7qDoyrCd4cwpFoDArtubE0omG2WFGqqRvXSy8hjLrP2w9?=
 =?us-ascii?Q?z1yjdmQqEFY31PnegthS6ZImaABagAObqKDxa1wjqe+ycD+Go6P3Ww8RgjqJ?=
 =?us-ascii?Q?6H/27YXPkaoyJIA5SSmZsyEnS9D8BocrB6myulPlcElI3rOls+6DrwYi6XHP?=
 =?us-ascii?Q?p1S8Tb5gd2aIMe7bZ2yjUcAe92emEBRfYLhngOjQNtDDBXh6RcqykazRH9MB?=
 =?us-ascii?Q?9OsiP2CkYKq0XCOjG7nnsvwaaf09?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230031)(82310400017)(36860700004)(7416005)(1800799015)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2024 06:03:27.1847
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ca6a3c2-0375-4743-865a-08dc7bb73aaa
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DB.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9153

On Fri, May 24, 2024 at 05:26:50AM +0000, Tian, Kevin wrote:
> External email: Use caution opening links or attachments
> 
> 
> > From: Nicolin Chen <nicolinc@nvidia.com>
> > Sent: Friday, May 24, 2024 12:42 PM
> >
> > On Thu, May 23, 2024 at 06:57:15AM +0000, Tian, Kevin wrote:
> > > > From: Jason Gunthorpe <jgg@nvidia.com>
> > > > Sent: Sunday, May 12, 2024 11:02 PM
> > > >
> > > > On Fri, Apr 12, 2024 at 08:47:09PM -0700, Nicolin Chen wrote:
> > > >
> > > > > +/**
> > > > > + * struct iommu_vqueue_alloc - ioctl(IOMMU_VQUEUE_ALLOC)
> > > > > + * @size: sizeof(struct iommu_vqueue_alloc)
> > > > > + * @flags: Must be 0
> > > > > + * @viommu_id: viommu ID to associate the virtual queue with
> > > > > + * @out_vqueue_id: The ID of the new virtual queue
> > > > > + * @data_type: One of enum iommu_vqueue_data_type
> > > > > + * @data_len: Length of the type specific data
> > > > > + * @data_uptr: User pointer to the type specific data
> > > > > + *
> > > > > + * Allocate an virtual queue object for driver-specific HW-accelerated
> > > > queue
> > > > > + */
> > > > > +
> > > > > +struct iommu_vqueue_alloc {
> > > > > +   __u32 size;
> > > > > +   __u32 flags;
> > > > > +   __u32 viommu_id;
> > > > > +   __u32 out_vqueue_id;
> > > > > +   __u32 data_type;
> > > > > +   __u32 data_len;
> > > > > +   __aligned_u64 data_uptr;
> > > >
> > > > Some of the iommus will want an IPA here not a user pointer. I think
> > > > it is fine API wise, we'd just add a flag to indicate data_uptr is an
> > > > IPA.
> > > >
> > >
> > > Presumably each driver will create its own type data which can
> > > include any IPA field as vcmdq_base in this patch?
> >
> > You mean putting a base address field in this common vqueue
> > structure? Hmm, I think we could, assuming every queue must
> > have a set of base and size info in the guest level.
> >
> 
> We could, but my original point was just that it's confusing to
> change the meaning of data_uptr. Let's stick it to be driver defined
> data and any driver-specific IPA field is defined in that data.

Oh, that's copied from IOMMU_HWPT_ALLOC:
* @data_uptr: User pointer to the type specific data

And it actually makes sense to me to be "type specific" since a
driver (AMD VIOMMU for example) might have two different vqueue
types (invalidation queue v.s. fault queue)?

Thanks
Nicolin
