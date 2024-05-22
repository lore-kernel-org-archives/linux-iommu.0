Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2049.outbound.protection.outlook.com [40.107.92.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6982213FD60
	for <iommu@lists.linux.dev>; Wed, 22 May 2024 13:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716385153; cv=fail; b=t/VFveRqc4q4jHDCmL8KlapoeZm40DCx8ls930jfMaPgi5lHBw9D8CmYEFkwQDN8neixc+ptM4QiL6F55Vb9w9F8Q40jBd7wYFHbWkBLLo2aIwDkfKLHlms8lR/euEd5cM9M1wRGVvr/I6oQ9xE2v9HXtslft/8zi7U9QM+KHZA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716385153; c=relaxed/simple;
	bh=N3MVSBJKaHEYjV7gbWuA8haZRV+Mh9/mbEPr1dmXzCc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Q7p4p+8SyC36ZKEbQydgWTBtHCuioxSCEIt3qNT4fzRLztj51QyaJ+E2cYV6mtohTpBnwHpyddl8pIkypr2rPyQnSmaw3AxkGohvQe2C2ZVZcA4AObKJHeIxySVeYhHwh5H3H2ccYKH/WA/KgkxBmtbCcDxODonSEP8JR2RIu9w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qqR4Uj3T; arc=fail smtp.client-ip=40.107.92.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qqR4Uj3T"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OnXpa4WmsJFQy9UyTLhovVOp3ExjyLrKVMopmq7H39YVJEQPIeb6s39fO/xV8cOsyr2oD2p6K6wqbwhlAxyK5AThyEs/j0t1Ftnuteyi2A4h2KcENeJqVCU0gciYJBVNtOihZRnAGJXktNpPmtiIyW2z6p03Xn8QpBRdjdJ6Mqp+Nuqu8fAvI9YIj33t6CEPDjU/sLKGup2M5U1KAMGF6tPJuzG8mM3b0xldpoz9Z0Nd0N7smyAD9SmKkvsGK/51l7bn/MEdVWPFFMgYEQMyJHhO4jDRV3AkPsDXAOWYmA2yq0Lq4KWWeyvR8GBU+Drvw9F8z68JnAGQKnxfIsxFQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PeHl+vda+DVf7wDC8DNAtITCtnRv6Htiw8y6Njll65c=;
 b=X6+22la/q273wl9Qd2hXF2DzOyCFQCcGTC5CWjvyVd12npHl13SK7oHzZCbZCh27Fjod6E/9n7Onauxm2XwCbXMy7Yi7kLL52hSnRBK3qjeRb1unOfZAElZwypowmDB4q9J6bnoFP1Yi0LEKAPv/0S51zcoQ051cYG2XOQNBjYO+GahY6PXXNLXAx8UyLAPPxqkA4jTFIllQZ9uzfe2T9tv+QBg+9W91V0u6YmUPWHW5kRSyjVjgXwZmgErm7BiUIHFaHRuuOl78Z62XrPLrGq2J0lzvU0teXDMTiRJb24obGYvZ/XQTmEUPcEYSTiS4+0juDJwNeGZlhwaQ59wW2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PeHl+vda+DVf7wDC8DNAtITCtnRv6Htiw8y6Njll65c=;
 b=qqR4Uj3TLMvhHSzMD9VEb5Vgg7Sv/Dxq0bFnIwlNd5p7ZedYviQ55w5o12BhuqFItANNOMKfNyMVb3CXsOUtd85nGlgTJIlW/GHpz4i59DOHKwKex4iV2ONZbo+m0ADxpnW1H2dIyObTgMYgY7IZ4CX0CMPmK+i8dnTdnqUPpi6M+vownE2lhAqjmF3nupdycaeVS+NRjWmvb0eLv9Tqi/C8C6gDjr8dldbrGhfDTn+rGWkUK0poby9v0otiNfIweQHa5Tq/eSuzkmhAa8EdG0r3cI3BttLYDQtsxCBjSqAfe9eup+50zvbwGr2lqmP9o8Z6adEl4jyDmwWfGBlzBw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by DM3PR12MB9391.namprd12.prod.outlook.com (2603:10b6:0:3d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Wed, 22 May
 2024 13:39:07 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e%4]) with mapi id 15.20.7587.035; Wed, 22 May 2024
 13:39:07 +0000
Date: Wed, 22 May 2024 10:39:05 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>, "will@kernel.org" <will@kernel.org>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>,
	"suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
	"joro@8bytes.org" <joro@8bytes.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
	"Liu, Yi L" <yi.l.liu@intel.com>,
	"eric.auger@redhat.com" <eric.auger@redhat.com>,
	"vasant.hegde@amd.com" <vasant.hegde@amd.com>,
	"jon.grimm@amd.com" <jon.grimm@amd.com>,
	"santosh.shukla@amd.com" <santosh.shukla@amd.com>,
	"Dhaval.Giani@amd.com" <Dhaval.Giani@amd.com>,
	"shameerali.kolothum.thodi@huawei.com" <shameerali.kolothum.thodi@huawei.com>
Subject: Re: [PATCH RFCv1 04/14] iommufd: Add struct iommufd_viommu and
 iommufd_viommu_ops
Message-ID: <20240522133905.GX20229@nvidia.com>
References: <cover.1712978212.git.nicolinc@nvidia.com>
 <8610498e3fc00000e78bb9cef6fac9f6a54978a4.1712978212.git.nicolinc@nvidia.com>
 <ZkDMSfd9BXmsFfb+@nvidia.com>
 <ZkGKKoHnykAdGJq6@nvidia.com>
 <ZkOJgvMNFaZZ06OO@nvidia.com>
 <BN9PR11MB5276423A0BFBDA8346E1ED3C8CEB2@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB5276423A0BFBDA8346E1ED3C8CEB2@BN9PR11MB5276.namprd11.prod.outlook.com>
X-ClientProxiedBy: BL0PR0102CA0049.prod.exchangelabs.com
 (2603:10b6:208:25::26) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|DM3PR12MB9391:EE_
X-MS-Office365-Filtering-Correlation-Id: a2752548-b1d3-404d-c472-08dc7a648d6e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|7416005|366007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DbZ4CBpxidn42c3WsR4pMsVREguxh2YSOwN4Pbub/JQx6BR1CIyu0gRp7dHB?=
 =?us-ascii?Q?9r/6kSjLeux7Tz9OZsxc2bJvK4Z7adFHVsqIRnVfaWyRrzo9hSNcgltDXVRD?=
 =?us-ascii?Q?/FXW8laQFiPnmmY7WZ7bbvtk/HfhI8qcFtvsG3LwhtgV7sQSQnXyAR6UsVCG?=
 =?us-ascii?Q?4dlkoExUhqIs7hZpbRe2deUcLWdCZ1BKnFvuCNEGbm12s3a4zW1cv3tpgA1w?=
 =?us-ascii?Q?pWG0BU/K4hijxcUOkH7xpwGQ2pCp4DFLSHJwMNtveODjkKJKMGiDsq8tcsdV?=
 =?us-ascii?Q?CX0jQ5orzPBQHebvnfFSyxGOeP1ssmGt4Ry/q+0HwCPpaKcC5FYaoTTqUXv4?=
 =?us-ascii?Q?SEgsdH5+46rbH2fFzCu4k58Z37DSCFbhTWqht8giKfrnyf9k/fUfq1zN7dpu?=
 =?us-ascii?Q?mquulclBfyMOfYwJTNYoa1fRMuf0OSeZnaefHzPUwUOxnRX4nZNrPB3kvS1D?=
 =?us-ascii?Q?vP9hd/9shNy/em5oXXf9pBQVgYMXPmuatX3/eZG2CkIzIlNKNaQsMpU/uhRd?=
 =?us-ascii?Q?Swq280zFpLCaKj03HYr73u9DDfE50ysmR1ldXkAyVVCIO1trp3SfnRNUpceq?=
 =?us-ascii?Q?+7rpx6MKKiw1ioO+8TsLWWvP7h5p4ZJAIxKe+uTE7BSeCsqS3yrR3eh9U8tF?=
 =?us-ascii?Q?mbsicZOKLy6GnyMrpSacascXU9gDdg5aZOI1hDqP6QZ3RJhCENasXQiAnW37?=
 =?us-ascii?Q?ItS+toQ5Q+MedqIeS2AEYyNVQKffyB3OI8KsCYr0FZARyZqRaULlr4N6zsdz?=
 =?us-ascii?Q?fAhvtBsbPFZFNV0GpEY9Wj1b8nLRs00eLiqWo4X19zZ+9EHBL87zHyamju8G?=
 =?us-ascii?Q?gWTxUF4LH51yD5Tgw60gmTdVt3AMQ7uuCrzfHqLdiZqdHLBTCQr551aZ8biL?=
 =?us-ascii?Q?2q7VyeaDnfDlTs28NWpz62UrMhmxktLYdq10ERj3iBh1tA9BcDzxTaD0nkVx?=
 =?us-ascii?Q?bMDBKW+uwh0H7NLvYr80Ixk+UBCfJudiixLt/inektAFR9bFelRnG72ze5az?=
 =?us-ascii?Q?i9thpAl/mkhaEaFS88IWU+ShRwPDHQMyh0MkJhRzOYzIFt0mTfO4xDLjbGAt?=
 =?us-ascii?Q?rjgPS1QVk6lrlQQ4f4G8JWpVgaN0/wlI8MFTwcz/lq/9i9kfJg2LflOa2QD6?=
 =?us-ascii?Q?VUcCwnIgWtu24is7odVcgu+Nj7mEDsapJArtmZObO7acgG4NAY/aPkIMRs+t?=
 =?us-ascii?Q?bxUQPMsgmGMSyJi1BuTHigCucVC3WWFLHlyCFhQt5rl+3g5UJUqO8WBmwm7j?=
 =?us-ascii?Q?SKmmocMNQshRmbUd90egFoDneKtYYtYae7PoD6wKKg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(7416005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XgX7tK69Fthql12Q/6AkS52rYIQezbV0YZzd2YEMNQgbjJI297cQA0jtepok?=
 =?us-ascii?Q?bZpnaZvD8/ubKAbzJfGYTgNNxC/LkgxvlC1vq81Nr7qjvTX6cOl0D+bElppj?=
 =?us-ascii?Q?+m9PwyFXi0nR/ANyJ6nGpGcUgV4NXCyCugTcD82WomKPG3A47btCWupZkEHi?=
 =?us-ascii?Q?QHKwJj1R/1KJHgig7QxomdiPuxQFRD9H3LAWkUwgFLjRaNuH0GeHoeE6vU6D?=
 =?us-ascii?Q?pl/ylGs4fDX4xBDqlRAW3Chj9WkrgHYOzy8MRUaeltjbISn/EoOMnS/zyE5r?=
 =?us-ascii?Q?sBLWW+YCS4Nw9ANBQSiEuXaFwuIDFNG1H6eOTJPkGV1zk+pkDb4UXn99rM+Z?=
 =?us-ascii?Q?pA9kMQPbqdKAASkO+MOtDi9AA08eAUJiabX7RKN1eG6HKk1CmujrTPQrvcUq?=
 =?us-ascii?Q?27WzsSuqleNJJ8RKlMrvc6ydJiDGOvX19E2lIDIKi209pW3E0hY5d7ssQuwf?=
 =?us-ascii?Q?JOyzY73ZoT9Vt0zmj7iwt3f3WSy429vDXW/J5MrPjkEqK30kETyF0OVqGEZF?=
 =?us-ascii?Q?aShD98jMpUu+4DoXlWd/L7/qiW/OJDskCzLwpzLOfI2riz9aml2S7nxdk851?=
 =?us-ascii?Q?pPky2gPeiNZ839jU/eCd0re6mZe4Wv4VhR67JiBqWQ72gJEnzlycyrgejtjJ?=
 =?us-ascii?Q?T8kjmxpXmUEO04NTcwobXsr2ghNW8mRbGsWQ5aZZOBi1JpinN3vs8Ho14HcF?=
 =?us-ascii?Q?OJSnkjUcWAcFYlPYuOZDBJAotA5wsq6W0NpXOOrFBJzC8akJtkGnd7Pn8eFb?=
 =?us-ascii?Q?rnjQYYqtorH35Yei9y2j6aLOhq4iIf/J/JNiquCvkUSKCFA4vp2FR1vRWnQ0?=
 =?us-ascii?Q?2VVueRBsUAFQZhrhdQ9JQGaLrSXe1JiDMJC1Cg7NXlVxwdizNUAmxGIPPAnT?=
 =?us-ascii?Q?HfM8wY75rZ5BHUpllAVfJUO2Wkhd9CR7Qq3I6K20oLMz/lQtdlL9gx7pc7SO?=
 =?us-ascii?Q?xnzQbeVLjEdBPhX6xYZ8bCFyrErS8EofZUzQptxQOx4cvNra5MlgGMFF/TCM?=
 =?us-ascii?Q?UOlSeO2xaMT6rV2prj0DqeTtiwLG/QXhB/X+GNP9Vg/VFYh1+w5W+77NPj+x?=
 =?us-ascii?Q?0zPPkNNMdO30oAL/0GOEVLXvArkrxtKtQdmukg88dzpDg/NcKqNe0Tc5hXEP?=
 =?us-ascii?Q?n/oZds9Fz532QzX/7CvShq+s/gBUKcLCOTO7qDKZ29s+/forh90PZsLWVQ3R?=
 =?us-ascii?Q?HSbsS+1fNOugpJQMKSAczZPVFxn06RZrBagMemSFi7fZsur4LdG7ulYeOlKA?=
 =?us-ascii?Q?e3bDE6FC2MPkw0ddLKWhJ59/ZxOOtXKMXEhU84bNKWlBVD6bG9vgI2hH8i9r?=
 =?us-ascii?Q?XLzdyUB9DxRF8Y7/TqmWcNt8nJ6WWTlaG7o+KZL+qHffMLfhV0EdsFiOyaEg?=
 =?us-ascii?Q?OFY2KXVAIjLdnTZ7L1T6DGdsAfdE7+ZlC6rFsZyqpKF2kWv1ASpEsuZljBxK?=
 =?us-ascii?Q?BMlzD1Pdb/C2Ey9PD2VIym1O230d8DZZwkZug/PvfcGLOY446n/J8a1kEUHO?=
 =?us-ascii?Q?EZYCS9rBVC8/M4ZOvWt1+4aWNAoeoPTB41spsZvTFnBMWauc/BGDhI6GZS9t?=
 =?us-ascii?Q?6t/qAclB7180KxJb958=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2752548-b1d3-404d-c472-08dc7a648d6e
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2024 13:39:06.9339
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qtq2fshNb0uLm2v4+bvQJbXsAy8Oelz0Hv6w5jYIOjaWLZFmT58244MtlK1HEWJC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9391

On Wed, May 22, 2024 at 08:58:34AM +0000, Tian, Kevin wrote:
> > From: Jason Gunthorpe <jgg@nvidia.com>
> > Sent: Tuesday, May 14, 2024 11:56 PM
> > 
> > On Sun, May 12, 2024 at 08:34:02PM -0700, Nicolin Chen wrote:
> > > On Sun, May 12, 2024 at 11:03:53AM -0300, Jason Gunthorpe wrote:
> > > > On Fri, Apr 12, 2024 at 08:47:01PM -0700, Nicolin Chen wrote:
> > > > > Add a new iommufd_viommu core structure to represent a vIOMMU
> > instance in
> > > > > the user space, typically backed by a HW-accelerated feature of an
> > IOMMU,
> > > > > e.g. NVIDIA CMDQ-Virtualization (an ARM SMMUv3 extension) and
> > AMD Hardware
> > > > > Accelerated Virtualized IOMMU (vIOMMU).
> > > >
> > > > I expect this will also be the only way to pass in an associated KVM,
> > > > userspace would supply the kvm when creating the viommu.
> > > >
> > > > The tricky bit of this flow is how to manage the S2. It is necessary
> > > > that the S2 be linked to the viommu:
> > > >
> > > >  1) ARM BTM requires the VMID to be shared with KVM
> > > >  2) AMD and others need the S2 translation because some of the HW
> > > >     acceleration is done inside the guest address space
> > > >
> > > > I haven't looked closely at AMD but presumably the VIOMMU create will
> > > > have to install the S2 into a DID or something?
> > > >
> > > > So we need the S2 to exist before the VIOMMU is created, but the
> > > > drivers are going to need some more fixing before that will fully
> > > > work.
> 
> Can you elaborate on this point? VIOMMU is a dummy container when
> it's created and the association to S2 comes relevant only until when
> VQUEUE is created inside and linked to a device? 

VIOMMU contains:
 - A nesting parent
 - A KVM
 - Any global per-VM data the driver needs
   * In ARM case this is VMID, sometimes shared with KVM
   * In AMD case this is will allocate memory in the
     "viommu backing storage memory"

Objects can be created on top of a VIOMMU:
 - A nested HWPT (iommu_hwpt_alloc::pt_id can be a viommu)
 - A vqueue (ARM/AMD)
 - Other AMD virtualized objects (EventLog, PPRLog)

It is desirable to keep the VIOMMU linked to only a single nesting
parent that never changes. Given it seems to be a small ask to
allocate the nesting parent before the VIOMMU providing it at VIOMMU
creation time looks like it will simplify the drivers because they can
rely on it always existing and never changing.

I think this lends itself to a logical layered VMM design..

 - If VFIO is being used get an iommufd
 - Allocate an IOAS for the entire guest physical
 - Determine the vIOMMU driver to use
 - Allocate a HWPT for use by all the vIOMMU instances
 - Allocate a VIOMMU per vIOMMU instance

On ARM the S2 is not divorced from the VIOMMU, ARM requires a single
VMID, shared with KVM, and localized to a single VM for some of the
bypass features (vBTM, vCMDQ). So to attach a S2 you actually have to
attach the VIOMMU to pick up the correct VMID.

I imagine something like this:
   hwpt_alloc(deva, nesting_parent=true) = shared_s2
   viommu_alloc(deva, shared_s2) = viommu1
   viommu_alloc(devb, shared_s2) = viommu2
   hwpt_alloc(deva, viommu1, vste) = deva_vste
   hwpt_alloc(devb, viommu2, vste) = devb_vste
   attach(deva, deva_vste)
   attach(devb, devb_vste)
   attach(devc, shared_s2)

The driver will then know it should program three different VMIDs for
the same S2 page table, which matches the ARM expectation for
VMID. That is to say we'd pass in the viommu as the pt_id for the
iommu_hwpt_alloc. The viommu would imply both the S2 page table and
any meta information like VMID the driver needs.

Both AMD and the vCMDQ thing need to translate some PFNs through the
S2 and program them elsewhere, this is manually done by SW, and there
are three choices I guess:
 - Have the VMM do it and provide  void __user * to the driver
 - Have the driver do it through the S2 directly and track
   S2 invalidations
 - Have the driver open an access on the IOAS and use the access unmap

Not sure which is the best..

> > Right, Intel currently doesn't need it, but I feel like everyone will
> > need this eventually as the fast invalidation path is quite important.
> 
> yes, there is no need but I don't see any harm of preparing for such
> extension on VT-d. Logically it's clearer, e.g. if we decide to move
> device TLB invalidation to a separate uAPI then vIOMMU is certainly
> a clearer object to carry it. and hardware extensions really looks like
> optimization on software implementations.
> 
> and we do need make a decision now, given if we make vIOMMU as
> a generic object for all vendors it may have potential impact on
> the user page fault support which Baolu is working on.

> the so-called
> fault object will be contained in vIOMMU, which is software managed
> on VT-d/SMMU but passed through on AMD. 

Hmm, given we currently have no known hardware entanglement between
PRI and VIOMMU it does seem OK for PRI to just exist seperate for
now. If someone needs them linked someday we can add a viommu_id to
the create pri queue command.

> And probably we don't need another handle mechanism in the attach
> path, suppose the vIOMMU object already contains necessary
> information to find out iommufd_object for a reported fault.

The viommu might be useful to have the kernel return the vRID instead
of the dev_id in the fault messages. I'm not sure how valuable this
is..

Jason
