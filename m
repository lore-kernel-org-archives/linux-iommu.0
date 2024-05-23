Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2058.outbound.protection.outlook.com [40.107.220.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95C3B7D412
	for <iommu@lists.linux.dev>; Thu, 23 May 2024 06:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716444600; cv=fail; b=IHRrAnBsVHMjrm0m9DzqDAzNT3l/usHZRgrkhcFuE9ow4kvECJNOrXUvJ4cj3HvRyi6N5ApH78bZjySZWCogdAgb0HH6SbJgWW77W2tyrVFEB/CQPAn7Mv0caMgAqU/CrOxaCo140Z6GzcobcEJqxCW1lu5o8dLxGa+7Vm2PcFo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716444600; c=relaxed/simple;
	bh=+tPN09fcKUTXy9O9cmDO+WLZeiaGaqGTn4wsU2KqRFI=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AyL7WYsvOhDh0Ba5jjeCWQgLPzxEf+wUIOUiSDMVcEdvThvVM3j2XFlbTvOJGXWRjb5z+1ONEC1g3qamg9kPMgeRgnrTSsb7g/YL+5c54lcGHpUDaUs8pfnJ51Nv2FYOh0lAUSWDpXhuh9UDpjtXblFNjEKxxGAcD2BZG0nWP4g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YjpYsZRD; arc=fail smtp.client-ip=40.107.220.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YjpYsZRD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iuOZuomFTe6FtdmmcVT/KKleeLWUSvPclA42WQyCbt1rzzGMX1AS3vrwh5cB53J44IDof4nJvpZCz62Us844GCbS3zX+RUxmmNYD0rGHVREnLKRAYjEOGzKb135PxicQEuYWwK3Nwn37N3NPMO2NldJJTLmaW9DCh+adkIVMzGgrJPp8G2deWLGSKVO3P3SbrMHt6rcxpFoihLKCvjs4a898NZicFhTGIeg9/RhK1YpanXz+f0EfiSUSbWlBKWS+piRHYpnA1yI/r8ab6ImgVmapwdFcrN60/jxCTSWuLntBCv7BdG+zgdWcrS4j96zjC3Hh8ZweYPXDAx+jJMrhAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m+yEwAFMpRhUg09sISsKYbRYCBoSQ3j4ZM36tP+XBQA=;
 b=XTNHWCuCWf2irpAQNC3nK6H9cGfmujXK0298R5cbEv/g9ej5y6QDI3ynX/O0YB7F5q9UKjqbtoQdQW+Booyr/4m+cjxtJ99+oaNmu/L7iQvanJ5xNKkKWtNGFQcMJspY8P0iM5Jyx6Z2fQ0QWvo1cjyUuYvYgXRyDlQWdSklqa30JXB+2fMsIr0QGQYnRA54qlVrVllD9bYnK9mAEQVyiTo9gGlnFkHzWyVyxkzafKBfwB/bYd+ByLw6HGNa/QASiv2CP+Z9MT9peSfTxMW18F3enHmzeL+lsZ3Eg21OXs7PfIg8pGE+SZhLkkzQAI1tX2R4dZIRXxv/MJgFEPzgig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m+yEwAFMpRhUg09sISsKYbRYCBoSQ3j4ZM36tP+XBQA=;
 b=YjpYsZRD/1LZ9MgGaeM/ICosf28/IaybPCUxa+qKAnvUVhIHKR/OPHfMo8j/ZWcE9lhytNFQC2AEtmYIfvuQUuTCk1aqOVuUuKRZcGBLFcYlFcYXEnI+cGxg/MVj5Q1xl7yE4b6JcTPSzBtuf9dTrecpeUODOEHVC3+N5gf/dFqln1xU+TFFwvTup+bi/0OX7j6o7MFOO3/de38ddS5aovVO7N0sX6t+vjkbsgfNeOFW9mJ6bIQARyI8DTVzpNmlS94AEi/1IoGGRyUpIe7ZXEZjawmHtPuwu/4bYfJzpkKyJdhwX+bEsmGzjy+mKldwHZ2vUpOsRPBlaR+tuHxa5A==
Received: from MN2PR18CA0016.namprd18.prod.outlook.com (2603:10b6:208:23c::21)
 by SA1PR12MB7174.namprd12.prod.outlook.com (2603:10b6:806:2b1::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Thu, 23 May
 2024 06:09:55 +0000
Received: from BL02EPF00021F68.namprd02.prod.outlook.com
 (2603:10b6:208:23c:cafe::c6) by MN2PR18CA0016.outlook.office365.com
 (2603:10b6:208:23c::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.35 via Frontend
 Transport; Thu, 23 May 2024 06:09:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BL02EPF00021F68.mail.protection.outlook.com (10.167.249.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7611.14 via Frontend Transport; Thu, 23 May 2024 06:09:54 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 22 May
 2024 23:09:45 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 22 May 2024 23:09:44 -0700
Received: from nvidia.com (10.127.8.10) by mail.nvidia.com (10.126.190.182)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Wed, 22 May 2024 23:09:41 -0700
Date: Wed, 22 May 2024 23:09:39 -0700
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
Subject: Re: [PATCH RFCv1 07/14] iommufd: Add viommu set/unset_dev_id ops
Message-ID: <Zk7dozLpy67ZY+RI@nvidia.com>
References: <cover.1712978212.git.nicolinc@nvidia.com>
 <6e57d7b5aa1705bdd547b1cd2aca93d3bf70dfa4.1712978212.git.nicolinc@nvidia.com>
 <ZkDWXnPW7CaX5TtA@nvidia.com>
 <ZkGZc5dvLigXcWib@nvidia.com>
 <BN9PR11MB52764728D4A8F54CCDE9B6C38CF42@BN9PR11MB5276.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <BN9PR11MB52764728D4A8F54CCDE9B6C38CF42@BN9PR11MB5276.namprd11.prod.outlook.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F68:EE_|SA1PR12MB7174:EE_
X-MS-Office365-Filtering-Correlation-Id: e909c375-e80f-4429-9b5f-08dc7aeef75d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|82310400017|376005|7416005|1800799015|36860700004;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7P4uS78JOC8Zk4pGSMRKaOhVXyg/7+Y0R1zGwi7C/hrQN9fhqfwN7m/CDN43?=
 =?us-ascii?Q?WxXpCUrVAlBrTj+8iR/hqKatUEIR6pphGZ5oD2q0TNuHp3aHMnJgzxdwWW+d?=
 =?us-ascii?Q?4sKYta4Vnxw+nYMRlCu0zfPRhOX3oLjbkm2nEfT2Xg7BrmuqDL7VeWYnMO0D?=
 =?us-ascii?Q?9NiPZYlMo7nN+eE6Lmel/23HTiHX92AAxA+9rR18QkQVlAlbECEz6B91WkGp?=
 =?us-ascii?Q?+ADfH5OtUwjquhob55JQ4FAMdqnefq97bQts6cAjv0G8qsfwSNvx32fSsGPM?=
 =?us-ascii?Q?YbY2qKD521CHsJ/j5i57ybiPOhzQ71cDYmmS5yhgzEAHA9i8sDZf3xudEO0j?=
 =?us-ascii?Q?cV1NqjFPgDtu4IC7e0IsIi/FVUne5mtk97eRk35Voj1fqWqjEr+9WhihA8a3?=
 =?us-ascii?Q?hBq75jr4C/kFD6T32q5K1IIZe1TqSzfqkZlWS5a7o9f3hXn0uu8bmrhmWPAW?=
 =?us-ascii?Q?ZhwyaCbC1F3RD8KAwD2Wa7gxlOtN/D0H88slBkGL95HwKDa/nIjk35QuOiV0?=
 =?us-ascii?Q?2P+aouFwLG8PqU6vttMJjKvGOlfW4J1SrenRlNQh6bJ9MzQlvjMzn3HNqZUV?=
 =?us-ascii?Q?WpIKBh23/quXqCKWeJgn0jFfTP0r62c8LZJU4dc3TZVLM192Iy0oXMr+zZtJ?=
 =?us-ascii?Q?aA4WItbJy13l7IFtnfz1RI2nw7FYdzq/sj6SbR3811D7Cd9xl1KZzu/T/7H7?=
 =?us-ascii?Q?GJ2RDLTudP+Z/CMGpbGFvIaeOxodo3wlMRT0j8qrYUR/fqb4TRjd5BZ5VtmX?=
 =?us-ascii?Q?0FHYQ5jlujCJrJPvI5cUkcKVQcI782DiDMZkjfkMdFWnhvEdtGtfOGYebu10?=
 =?us-ascii?Q?nVR2/C7k6pCPoi80H3FnaeYZcdju018RDvEV9+0D29F4k3z8Znjc13ket9IP?=
 =?us-ascii?Q?BpHbjxwqIovAKp/0EcviyjEBkh7aId3n+OLzV6yeSnWFBepwmyEI77Hds3qd?=
 =?us-ascii?Q?vfUa7YdXXBl9NL2mmIt1J5fUD6m8nOFHnTOgm3AG4jRVibWxRTWOliouDScB?=
 =?us-ascii?Q?wv4radjXKIPFU1TLKmknQG0RhevUClgYcaGr4SxZ6ni3vBrKGzDU64+Zwm+h?=
 =?us-ascii?Q?LU+p4kQoaaf6adaWe8jBJ/ss7qAdpoLbN81JM+Aiu2zh28zuegudw9/6RtCt?=
 =?us-ascii?Q?RmO75NNRL0RHnLVBxLdEVr3OAgFmIClNw2QvA5yU714y47oS3w7odaf6cIvX?=
 =?us-ascii?Q?RfgJZV2RJ5KTIZcnfh+LClJyhY7SmUctjuLnjnZIjDj6jHAT3dh7UpUQ9nNV?=
 =?us-ascii?Q?pa9GzBT5TpFGwwMkpRcOVEx+W6aTWRQTL44cabFO9rUZr34Kt9owXlux4xvQ?=
 =?us-ascii?Q?zHfzRHrOf1nKn2XFIuctXtFeB01euAfwO588kVYfF5TCLSHudNJNRGTO1xqG?=
 =?us-ascii?Q?xe6veQphSPf2C15atyq0R0LhJAnm?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230031)(82310400017)(376005)(7416005)(1800799015)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2024 06:09:54.8804
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e909c375-e80f-4429-9b5f-08dc7aeef75d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F68.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7174

On Thu, May 23, 2024 at 05:44:40AM +0000, Tian, Kevin wrote:
> > From: Nicolin Chen <nicolinc@nvidia.com>
> > Sent: Monday, May 13, 2024 12:39 PM
> >
> > On Sun, May 12, 2024 at 11:46:54AM -0300, Jason Gunthorpe wrote:
> > > On Fri, Apr 12, 2024 at 08:47:04PM -0700, Nicolin Chen wrote:
> > > > Add a pair of ops to set and unet device's virtual ID that belongs to
> > > > a viommu object. They will be used, in the following patch, by iommufd
> > > > to support some HW-acceleration feature from the host level.
> > > >
> > > > For instance, every device behind an ARM SMMU has a Stream ID. The ID
> > > > is used by ATC invalidation commands so SMMU HW can direct
> > invalidation
> > > > requests to the corresponding PCI device where the ID belongs to. In a
> > > > virtualization use case, a passthroughed device in the VM will have a
> > > > virtuail Stream ID, used by the ATC invalidation commands in the guest
> > > > system. NVIDIA's CMDQV extension for SMMUv3 provides a v-interface
> > to
> > > > execute the guest-level ATC invalidation commands directly, yet needs
> > > > the HW to be aware of its virtual Stream ID so it can replace with its
> > > > physical Stream ID.
> > >
> > > I imagine using this as well for the ATC invalidation commands. It
> > > would be very easy and simplifying if the command fixup just extracted
> > > the vSID from the ATC invalidation and used an xarray to turn it into
> > > a pSID and then pushed the resulting command.
> >
> > You mean the nested SMMU series right? Actually the set_dev_id
> > ioctl was a part of that until we wanted to try DEV_INVALIDATE.
> >
> > So again, yes, it makes sense to me that we move viommu and the
> > set_dev_id to the nested series, and then drop DEV_INVALIDATE.
> 
> I'm right about to ask how the nesting series is going. Per earlier
> discussion iirc the nesting series will go in before VCMDQ?

Yes. It still should. Yet we ended up with adding VIOMMU to the
nested SMMU series too. A shared S2 domain/hwpt isn't exclusive
for VCMDQ use case but also for regular nesting on a multi-SMMU
setup. So, VIOMMU turns out to be the best object that we have
at this moment to hold individual VMIDs for different physical
SMMUs sharing a single S2 domain. Its virtual device ID lookup
feature can also allow us to forget about DEV_INVALIDATE ioctl
for now.

Jason listed all the tasks ahead in this thread too, using SMMU
as an example:
> So we have this stuff still open:
>  - Identity STE with PASID (part 2b)
>  - IOMMU_GET_HW_INFO (part 3)
>  - IOMMU_HWPT_ALLOC_NEST_PARENT (part 3)
>  - IOMMU_HWPT_DATA_ARM_SMMUV3 (part 3)
>  - IOMMU_HWPT_INVALIDATE_DATA_ARM_SMMUV3
>  - VIOMMU_ALLOC, VIOMMU_ATTACH
>  - VIOMMU_INVALIDATE

By this series nesting setup is done. We need Baolu's solution
or VQUEUE for fault reporting after that.

Thanks
Nicolin

