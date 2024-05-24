Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2082.outbound.protection.outlook.com [40.107.243.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CDE83C00
	for <iommu@lists.linux.dev>; Fri, 24 May 2024 04:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716525748; cv=fail; b=N1VhAWUBDTHkMeDkJw4SWW2gl2JyRB8xYkXUKa4yi7YJqMeKkXW81XD6r3GJMMo73WphxNtv03zi8zYJpn4p4/t5FJM1a0LZK4QaYh0X3nX9b3IAl5FR6pP4xUL8QtMYtDkD90PivYFEeHQXKN+KbXOVSWLeEM+w5s+4ZUO7+Jo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716525748; c=relaxed/simple;
	bh=fB0mPEYqL3WbbVc+WItr1kYnlna/j98t5ugDwhxoPns=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rOQ+2PqwNSvQFLOM3+IZ77VYQvTZ9PpM0+ZHfgL9E8gQgIEwPOR7qT6tge0PLG3FKStxtbBa5VwKYWaVxjj8p9oO4/d1pOQ5xYTdK1fM1mjGOl28Fpw/RfLhniebJFchQ4JyboRLKn+AGU+MwA4b1uX2EZQzaI8wa4PXrupIHHM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CDdGEy9f; arc=fail smtp.client-ip=40.107.243.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CDdGEy9f"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JR5QpwcYTIMA1TeNOeXCcrRLClpp+f+A8BAuc6P9X6qEgHWr2prChoG9FgzOEVvpjrbE+BV85fk8PsONf1f60cDG3qmXWHyYkAizEa2kGryqTGEch7ie5LdbWs9ikAiobP9qPYVlREox8Uys3QY9uhNGz8kcPbbgIzqI0kqUVRR7YfFvyB3baPCD6CXGnVDocU0C/SCDZaKmCI9E/ECVc5sleCSFZNcTGjdc88jcpU5oEKXHjk/iM2ECfWeedqCkUB90W7/8aLeNjiEYY95dJxbgIyg5avK/Sftme3r/g9GCj2JA4n5nDMqn3n/KSduMPW4S0Az5Kogh2WJ5PQ2aYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7AO7mh3cbI5QbYaXfZrrqn0sL8OQQ2eDl9TJDjb8txc=;
 b=nP3C+X6lHL2t4zyFP+AynNHDz9vTpTH3XEnmXtzsR4PnZvzCM9JZop7k++U7x1kfYNdI61gcDckbGhzVAfmU4X5s3KAXb4UorFmHqula7rxRURRJol7NyvNwjPw1U+98DbecEXgt6Rm60DJVyvFGOkDefWVTpVrr/+7xPIB6ptNByzcdwwXn4fO5dQ6rFSE7Cy6R5gADyoxbJlGAh0kgGCPVQZ4fAhd9YtOq1Gk44i+xGlZJciM/PepFSNT0HA6a5wKSfgBw0HwACw6CXLGtKcOa+RuUwPBeYs+TLKOS8AS60PnAwFfn69k9hEx6wrIE2VKXrJ+Ict4S24rP+fjm3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7AO7mh3cbI5QbYaXfZrrqn0sL8OQQ2eDl9TJDjb8txc=;
 b=CDdGEy9fAWDrH2AmiDw7YwViVlW+mvsZXUtbphTTGhAdoJCppsSHEbcJ2HJkht3aE96cpo4hS8Ac5sldPQbyhD2+POjov+oaWGBRlbU9znydk9Uq+7ReTNPKeyEdPkVLsYjnX7QlyH+Gn8gKpSa9nc5iw3qwlA2lP84r+3aB8o6TtrK8WRG9kPF+KXm/OFZ5LZeOwXcfFiYiQcOKKPuUSg38vDYyfah4+k2Shrgtrb6DamfgQb9jbJU6/mjILAP7P/Plj2g1KqQjAZmPyx1pRRaxrRHtCrbdFYtocSi7ZJGiFjF/wuYT3I2xdOiMZYZWo/Rc6tYjnUH9YM2z2zTQfw==
Received: from SA1P222CA0114.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c5::21)
 by CY8PR12MB7124.namprd12.prod.outlook.com (2603:10b6:930:5f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.35; Fri, 24 May
 2024 04:42:24 +0000
Received: from SN1PEPF0002636C.namprd02.prod.outlook.com
 (2603:10b6:806:3c5:cafe::4c) by SA1P222CA0114.outlook.office365.com
 (2603:10b6:806:3c5::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.22 via Frontend
 Transport; Fri, 24 May 2024 04:42:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF0002636C.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7611.14 via Frontend Transport; Fri, 24 May 2024 04:42:24 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 23 May
 2024 21:42:16 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 23 May
 2024 21:42:16 -0700
Received: from nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Thu, 23 May 2024 21:42:12 -0700
Date: Thu, 23 May 2024 21:42:11 -0700
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
Message-ID: <ZlAao39Zc+9moEDP@nvidia.com>
References: <cover.1712978212.git.nicolinc@nvidia.com>
 <b0ee53af3f59602834e67ddf86c748ca304da175.1712978213.git.nicolinc@nvidia.com>
 <ZkDZ/YO0jqZOlRtA@nvidia.com>
 <BN9PR11MB527668B2398FE65771A429D08CF42@BN9PR11MB5276.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <BN9PR11MB527668B2398FE65771A429D08CF42@BN9PR11MB5276.namprd11.prod.outlook.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636C:EE_|CY8PR12MB7124:EE_
X-MS-Office365-Filtering-Correlation-Id: 6635e30e-453a-47d7-86f2-08dc7babe828
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|82310400017|1800799015|7416005|376005|36860700004;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vUcbiEVJlM0MGOl8LLXGx8cAdOv04WPNezYoa6pn0PtjjvmsVUPHHLFrStXK?=
 =?us-ascii?Q?Wzx0XpfygHHqynua5wcDFCMvEV/Jv5eTmvkgNelo8QOKkbfd8Gx7nA3gB5tZ?=
 =?us-ascii?Q?AssNzIyKKWqDtJr1unV+koojdt8AXkcqEWqlN+0vgvrDk1qwgsAJojh/f1IV?=
 =?us-ascii?Q?pXISI5JLFLf8d6U+N6NkP8Q2vE/t0ydrSrydrWa3Q0t8NlQh2aQeDo2rx6J0?=
 =?us-ascii?Q?suB3SsfYj5O0uyHWvx4e1ZYcq1lMeCqm2d6CCIzh4h3jST/uGg/S8oSjG/pR?=
 =?us-ascii?Q?aQ7kvx607GYMGeF7Sj2sp7nW72EYsPtLWdZa97pMoh7WqXcw8AtQ22NpPc5+?=
 =?us-ascii?Q?otWEd+TD8avMdnfW8B7vF8ZwhpDFG/7UtnaCeYR9qTSvdqtFNFJdy1X/6shH?=
 =?us-ascii?Q?w4Dt6EXQjHjXHHQUCKdK0UzytnnWPKmEjNhbqzFWOQu+CW1E99WwZZs0OJ0Q?=
 =?us-ascii?Q?tkytdOdIKDFniBND3FiB8RsXO6Wp6yXml9AIXorFSViz4PaZPI6w8Sod/2HR?=
 =?us-ascii?Q?YiaUKlaagCvyrtQBt4yEbsCnUDiD2V5a+8lIzSldDIyHxdpSuuH2xMm27PNP?=
 =?us-ascii?Q?nNg1i16IaTQ7ZlQGIVlN3LrVE8A0pd0K3XR/Y0cO5xDyDPQPR+fyvkKvUHF6?=
 =?us-ascii?Q?ooLtZ1CYZ15lEUSo76iQyKrovPDcp/rRuaneI0tviw/03AbOs1+zgj6MOIu/?=
 =?us-ascii?Q?UFcD1cYXDJ6cXftp7VlYFmiXQytKLngtFTItOYIknI//KHILxsRzsLtapbCg?=
 =?us-ascii?Q?a42MZeH2UAMvV4yX1sGGmvTOIPA/hUpeKBVkcQrXtoin/aVBroBRaQ93Qry7?=
 =?us-ascii?Q?jspUKnb/M7C3VmbDN6pmGTMOwUMOE8TDKYZIuD1CYTgRec4qAIigW1/4u/Zq?=
 =?us-ascii?Q?JVFMmjnWMU9SwSr9bGQBLYS9zSEzPGg4DA4Ff+e0seqAFAhpzAfeARuzxoHM?=
 =?us-ascii?Q?s+sBY9llegPwSO8Zt37VgCmHvoKKc4swmg7S3s7+j1OlsA5vLqx+9Htocdh4?=
 =?us-ascii?Q?Mt2IHqtzFcwUIMBnHPJT4yv8a41Y1FbU9ztUpOii4TK+UeqXS8yykR1SVJAb?=
 =?us-ascii?Q?yqmSP7jGad4GGAlFuzpm23UFraigFTt9wT3LlEJ1djTLG9/pLZlQrcpAg/Bz?=
 =?us-ascii?Q?PiptlQdd0KOqsxqlry9VcuoKGjIJL39YAj1AzaRhDLyXTLvwdQn+RzousiSx?=
 =?us-ascii?Q?G9EYiLAWhNSR65YhXgvxkuNwWyHUt1r+0EUrsWb6H7FfO02UAMWSJxB8Ztlc?=
 =?us-ascii?Q?oHF5l1pvAJs/pmuyNYK872Cj36CaoVhP84qzOBaFtpPHQweuD9hkn9Nh8BVG?=
 =?us-ascii?Q?lfEhvpL5eGkaC0k7EGuHMbDz06VVvHeJd9krNcbkdwDKO74M9M2WERaemWRB?=
 =?us-ascii?Q?YdTe+vhXQLO/etRmImVFQqFGt/yn?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(82310400017)(1800799015)(7416005)(376005)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2024 04:42:24.2955
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6635e30e-453a-47d7-86f2-08dc7babe828
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002636C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7124

On Thu, May 23, 2024 at 06:57:15AM +0000, Tian, Kevin wrote:
> > From: Jason Gunthorpe <jgg@nvidia.com>
> > Sent: Sunday, May 12, 2024 11:02 PM
> >
> > On Fri, Apr 12, 2024 at 08:47:09PM -0700, Nicolin Chen wrote:
> >
> > > +/**
> > > + * struct iommu_vqueue_alloc - ioctl(IOMMU_VQUEUE_ALLOC)
> > > + * @size: sizeof(struct iommu_vqueue_alloc)
> > > + * @flags: Must be 0
> > > + * @viommu_id: viommu ID to associate the virtual queue with
> > > + * @out_vqueue_id: The ID of the new virtual queue
> > > + * @data_type: One of enum iommu_vqueue_data_type
> > > + * @data_len: Length of the type specific data
> > > + * @data_uptr: User pointer to the type specific data
> > > + *
> > > + * Allocate an virtual queue object for driver-specific HW-accelerated
> > queue
> > > + */
> > > +
> > > +struct iommu_vqueue_alloc {
> > > +   __u32 size;
> > > +   __u32 flags;
> > > +   __u32 viommu_id;
> > > +   __u32 out_vqueue_id;
> > > +   __u32 data_type;
> > > +   __u32 data_len;
> > > +   __aligned_u64 data_uptr;
> >
> > Some of the iommus will want an IPA here not a user pointer. I think
> > it is fine API wise, we'd just add a flag to indicate data_uptr is an
> > IPA.
> >
> 
> Presumably each driver will create its own type data which can
> include any IPA field as vcmdq_base in this patch?

You mean putting a base address field in this common vqueue
structure? Hmm, I think we could, assuming every queue must
have a set of base and size info in the guest level.

Thanks
Nicolin
