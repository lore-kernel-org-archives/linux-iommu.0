Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2085.outbound.protection.outlook.com [40.107.223.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D8B722309
	for <iommu@lists.linux.dev>; Mon, 13 May 2024 04:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715574862; cv=fail; b=YG4bgyhWrvVhXGQS/+oeBU9pF1+mSYH1NIKxQoVcxcqh98VQIWcQuvnyB8I2BBtVeY20er01i5f5Ryd044Tv7WRPymeDFqhMuFsOrkM1SksMyzMD33MyiqcmS24mBuGG68nCN7xh/i/YydAY1gMhnpnnyWJvtVN4aPf68Mi/Zbs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715574862; c=relaxed/simple;
	bh=msmjPDyifqMQxClUwjq0pXWBr8ORf2INmPkT0NheTqw=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EqYONi2WJBIoh0dYptoi73te9uVWihYFjM+K7S1IxcMHnW1zVrtygGERD/nW3dBI+s7iFoH/aAKzFbMOuxVlbKpkYjI1TY9L11GPnDWBy8kqGsP2ipZ1/m+jG2I+WJdOkZSCYk4pSkg6qCHwp8x61T2/uUEnQHfWPEDBEmjjnzg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MJUlrdC+; arc=fail smtp.client-ip=40.107.223.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MJUlrdC+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ESNzd4NoCTgmA4S8k0Mn/ZtEb7hWvFOv6kxNnwl8nVwwHnBugSE86un2Lsa9cdGQAKe3BtIxncS8jUFETCkCH4OQLqb1lT5qfc0nJxIO/XVNVuzx1lAl0FoywCcNx3AXatu7kvMNlcYnR6/+3N2f0zNcaohP9DdEM+1zXsuwlLHNTm6KvLB8Qh5ahqan+NzC0QqGeg3m8YSqQDN1IYsZvo+svqtip0ZQGERVv+DvYu9FGyypD8UqXtSURWdMjhnllLM+J2at1stXlS6PeRlpVONbm8YcABq4of51n7Xh+n6pm/BHqHsr0Rui3LZlqw8Q4Ks/5zWcpySWkDJtqYzgkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kscEFERkcfXztaw3bIaGliRKpot79X8JhWhUJcmzTog=;
 b=bvDsOgeU7X4LPPaKu+hb9gohnbwR/sHJ6WAZoU9XpCRdwCSGXrkocaU+Y51UgVwMu8hXNq77V3iKp9txNJm3xs1h3RtjmWL3/+N7qT2bFq+j4zvV/j3IQ6oX+UxK76g22iq0wcZwuUP89Ex8gGtCRLK1t52Go9/OUhSuCfs8oCWpz90Uj5XJcDQMYyeaObCDLYAGY4E9ZQlStiWdCgtZ3hQWnJOsPWsntF37PzaiG1vHTld0TsGam2CT437iI7lNjJrrcbhBbErE6eFUIX5CL7ANoPk8bdL+UkV/ZzLb7EIqb9+AkfmfJPcmgcDItVQ/9WCVMBWqQj2PV0Dw0yiD+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kscEFERkcfXztaw3bIaGliRKpot79X8JhWhUJcmzTog=;
 b=MJUlrdC+x4zd9zz9bGXww3PtKJs4m/6qBhTlX4PbI/C/wL4wXr8VQq1G0Smu9xAntTz00i97XTgruucNl/bgj/HeR1CodneeVDCo/NkS9MJvnWtvQ+20j6qfbwDPuOmCt4AMqP06PsMhRPGSSeJKPPHjZPR+SNFgVSejKEFEXkB/RaFytz56V40zSZ3zgx3haN3rQhAhhkD4fsTyz5cv3H8/3oGEU4W1AZviDpxs4j0J4LF8YQ8ojk2YlIQWVBHx1xRB1AriVlOCtmihfwdxpIDESlnOUW+vZNcmAPJNgea/IUHiT3MQlNW/qCxcnF1lniBbQfOZpxkrRD3GuaLndA==
Received: from CH2PR12CA0027.namprd12.prod.outlook.com (2603:10b6:610:57::37)
 by IA1PR12MB7663.namprd12.prod.outlook.com (2603:10b6:208:424::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Mon, 13 May
 2024 04:34:16 +0000
Received: from CH2PEPF0000013F.namprd02.prod.outlook.com
 (2603:10b6:610:57:cafe::38) by CH2PR12CA0027.outlook.office365.com
 (2603:10b6:610:57::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55 via Frontend
 Transport; Mon, 13 May 2024 04:34:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH2PEPF0000013F.mail.protection.outlook.com (10.167.244.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7587.21 via Frontend Transport; Mon, 13 May 2024 04:34:16 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 12 May
 2024 21:34:06 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 12 May
 2024 21:34:05 -0700
Received: from nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Sun, 12 May 2024 21:34:01 -0700
Date: Sun, 12 May 2024 21:33:59 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: <will@kernel.org>, <robin.murphy@arm.com>, <kevin.tian@intel.com>,
	<suravee.suthikulpanit@amd.com>, <joro@8bytes.org>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-tegra@vger.kernel.org>,
	<yi.l.liu@intel.com>, <eric.auger@redhat.com>, <vasant.hegde@amd.com>,
	<jon.grimm@amd.com>, <santosh.shukla@amd.com>, <Dhaval.Giani@amd.com>,
	<shameerali.kolothum.thodi@huawei.com>
Subject: Re: [PATCH RFCv1 05/14] iommufd: Add IOMMUFD_OBJ_VIOMMU and
 IOMMUFD_CMD_VIOMMU_ALLOC
Message-ID: <ZkGYN36N7sh2vUmv@nvidia.com>
References: <cover.1712978212.git.nicolinc@nvidia.com>
 <3aa9bc1df6a2ee58a03c6ea6ededbc210a2d23a8.1712978212.git.nicolinc@nvidia.com>
 <ZkDR4Rp57cy9qSqP@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZkDR4Rp57cy9qSqP@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013F:EE_|IA1PR12MB7663:EE_
X-MS-Office365-Filtering-Correlation-Id: ff776303-4185-4b7d-e764-08dc7305f2cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|82310400017|1800799015|376005|7416005|36860700004;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?d49SIfVjmUUEQL4HWKQ922zf6rkCHqPBtKnwSbuvNsxWx+lsgqYvPnsYZe0j?=
 =?us-ascii?Q?kcuaFyxUBbVwZ94ufarO9+QFqdO0ywwoPeJnnVpnsA8jY/V0zfKhInX7ebyL?=
 =?us-ascii?Q?9NAImM1jPDxHCcE1DATwEp+450Y9jidvA/cI2rfdFPOK5fY5VTu5TfGOOcIt?=
 =?us-ascii?Q?NDr9fqXeEnqyaHlX14cVPk1I6RaiK7OE8A7k5YJhv3wpNRQ9Q4DyRKnPny2J?=
 =?us-ascii?Q?ie7cU1R7uCcW7hXnk2Hlr6y2bdzXpRptalRO1jcILMr2JisJfmMg9+DMoxLq?=
 =?us-ascii?Q?9reAEg0zrrmOJRX0Tjc/6UZeRMYakc0VrGMARwRr8AUgYTax2OrleycNpgic?=
 =?us-ascii?Q?nDPkb217E+QU035UnQlkTmgZjpcVp4hrE7IGyIED2mpvJCVjzEruB+Y1OCgc?=
 =?us-ascii?Q?vfkGfrDJcEt8B3kAB28MeUT8ty66jqy0iAzk6O+G5vAsMR9z4duxNCipsR0J?=
 =?us-ascii?Q?6YKBuaCYGor8kv6a2wvemOvpwdOBaF53wqxEVlcCZ9MyD3RcGDorcEaxsGYO?=
 =?us-ascii?Q?rUNwC6N+F6lISxYyvyNiNglR2lbs2hCWksPERT4r0clZr7uOXNzn/rcPeIAN?=
 =?us-ascii?Q?EDeJ3E+dX/AHKmcHdVIC3vBjVH1d74bwLN9jtnK8L9vpoXgoYlWKDeNY83XW?=
 =?us-ascii?Q?CJfdg3D4+qZH6U5Rgy+VS2W/iP4T8F3+MJi0kocfk0FjbPxfkFwcveA6C+5r?=
 =?us-ascii?Q?7Uyj5ulxq/q1GedhhDi4d0W0+y4Zx0UvVqFtryI8C/04kBeBZV4g3nZ8Rtms?=
 =?us-ascii?Q?1P2KYu9QH1M5PFsNFZcJPVIH6QGDKyn4le7/1X5AZ0jViORN8lsII6vIXF9O?=
 =?us-ascii?Q?JWL0G6wgdHsuauWJBgAky5mlqrxagww5jibe9gGIBWNpPC4fhkq+4Lg4CIyV?=
 =?us-ascii?Q?SIKrTmKHlvErZwRHlzXzNvmHnRqib1WwxQlZBr1Pso+dXL/voKnNFu13eSug?=
 =?us-ascii?Q?XviyP/Y6po9Lz900Zi65EIUBnv/3j6yKYdh/oxGDvAD81OWCbYwr5R6S/G58?=
 =?us-ascii?Q?X1Ub0+aEpSdlStc3aLHyWHVfmX1Ka6OKTLXKwt7OuiiXYs8lEMXpWyqSZsyJ?=
 =?us-ascii?Q?dfjp2ecHyCAUX/ijFvNhudMhOdRsCEvjqKE/XcAui7ZRhMcwc7+ZaHVZsQG7?=
 =?us-ascii?Q?OlxRLfvbdzdgE26XZ8jM3q5gPIjZ0QVpoF2TIeybQ1VFiMFqKvguOaRloWVE?=
 =?us-ascii?Q?d4PZ7b60gEhWXe9RQDnz5n3kN7GoWbFWrUMnf7uyh9+RLMOE2Rkd2e0TuHFV?=
 =?us-ascii?Q?JzttaBnZVTBY9AdrYhaTWcHupmPGLaR5o+IzSy0lzNnnNClT8eakslxeCnvD?=
 =?us-ascii?Q?MT1jXyCjFl1SiG6OFrvQOlzmBKWyAkAPkrfn2RL8PEpihzX7a03v23UtFGqY?=
 =?us-ascii?Q?xAkXP3njqTBaq5+frZMrXjZ6jOCC?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(82310400017)(1800799015)(376005)(7416005)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2024 04:34:16.3529
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ff776303-4185-4b7d-e764-08dc7305f2cb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000013F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7663

On Sun, May 12, 2024 at 11:27:45AM -0300, Jason Gunthorpe wrote:
> On Fri, Apr 12, 2024 at 08:47:02PM -0700, Nicolin Chen wrote:
> > +	viommu = iommu_dev->ops->viommu_alloc(idev->dev, cmd->type,
> > +					      hwpt_paging->common.domain);
> > +	if (IS_ERR(viommu)) {
> > +		rc = PTR_ERR(viommu);
> > +		goto out_put_hwpt;
> > +	}
> 
> Ah you did already include the S2, So should it be
> domain->viommu_alloc() then?

We can do that. In that case, the VIOMMU_ALLOC ioctl should be
simply per S2 HWPT too v.s. per IDEV.

> > +
> > +	/* iommufd_object_finalize will store the viommu->obj.id */
> > +	rc = xa_alloc(&ucmd->ictx->objects, &viommu->obj.id, XA_ZERO_ENTRY,
> > +		      xa_limit_31b, GFP_KERNEL_ACCOUNT);
> > +	if (rc)
> > +		goto out_free;
> > +
> > +	viommu->obj.type = IOMMUFD_OBJ_VIOMMU;
> 
> See my other notes, lets try not to open code this.

Ack.

> > +	viommu->type = cmd->type;
> > +
> > +	viommu->ictx = ucmd->ictx;
> > +	viommu->hwpt = hwpt_paging;
> > +	viommu->iommu_dev = idev->dev->iommu->iommu_dev;
> > +	cmd->out_viommu_id = viommu->obj.id;
> > +	rc = iommufd_ucmd_respond(ucmd, sizeof(*cmd));
> > +	if (rc)
> > +		goto out_erase_xa;
> > +	iommufd_object_finalize(ucmd->ictx, &viommu->obj);
> > +	refcount_inc(&viommu->hwpt->common.obj.users);
> > +	goto out_put_hwpt;
> > +
> > +out_erase_xa:
> > +	xa_erase(&ucmd->ictx->objects, viommu->obj.id);
> > +out_free:
> > +	if (viommu->ops && viommu->ops->free)
> > +		viommu->ops->free(viommu);
> > +	kfree(viommu);
> 
> This really should use the abort flow. The driver free callback has to
> be in the object release..

Yea, with the original object allocator, we probably can do abort().

> > +
> > +/**
> > + * enum iommu_viommu_type - VIOMMU Type
> > + * @IOMMU_VIOMMU_TEGRA241_CMDQV: NVIDIA Tegra241 CMDQV Extension for SMMUv3
> > + */
> > +enum iommu_viommu_type {
> > +	IOMMU_VIOMMU_TYPE_TEGRA241_CMDQV,
> > +};
> 
> At least the 241 line should be in a following patch

It's for the "enum iommu_viommu_type" mentioned in the following
structure. Yi told me that you don't like an empty enum, and he
did something like this in HWPT_INVALIDATE series:
https://lore.kernel.org/linux-iommu/20240111041015.47920-3-yi.l.liu@intel.com/

> > +/**
> > + * struct iommu_viommu_alloc - ioctl(IOMMU_VIOMMU_ALLOC)
> > + * @size: sizeof(struct iommu_viommu_alloc)
> > + * @flags: Must be 0
> > + * @type: Type of the VIOMMU object. Must be defined in enum iommu_viommu_type
> > + * @dev_id: The device to allocate this virtual IOMMU for
> > + * @hwpt_id: ID of a nested parent HWPT
> > + * @out_viommu_id: Output virtual IOMMU ID for the allocated object
> > + *
> > + * Allocate an virtual IOMMU object that holds a (shared) nested parent HWPT
> > + */
> > +struct iommu_viommu_alloc {
> > +	__u32 size;
> > +	__u32 flags;
> > +	__u32 type;
> > +	__u32 dev_id;
> > +	__u32 hwpt_id;
> > +	__u32 out_viommu_id;
> > +};
> 
> This seems fine.
> 
> Let's have a following patch to change the hwpt_alloc to accept the
> viommu as a hwpt as a uAPI change as well. 
> 
> The more I think about how this needs to work the more sure I am that
> we need to do that.
> 
> ARM will need a fairly tricky set of things to manage the VMID
> lifecycle. In BTM mode the VMID must come from the KVM. For vcmdq the
> VMID is needed to create the queue/viommu. For AMD the S2 is needed to
> create the VIOMMU in the first place.
> 
> So, to make this all work perfectly we need approx the following
>  - S2 sharing across instances in ARM - meaning the VMID is allocated
>    at attach not domain alloc
>  - S2 hwpt is refcounted by the VIOMMU in the iommufd layer
>  - VIOMMU is refcounted by every nesting child in the iommufd layer
>  - The nesting child holds a pointer to both the S2 and the VIOMMU
>    (viommu optional)
>  - When the nesting child attaches to a device the STE will source the
>    VMID from the VIOMMU if present otherwise from the S2
>  - "RID" attach (ie naked S2) will have to be done with a Nesting
>    Child using a vSTE that indicates Identity. Then the attach logic
>    will have enough information to get the VMID from the VIOMMU

What is this RID attach (naked S2) case? S1DSS_BYPASS + SVA?

>  - In full VIOMMU mode the S2 will never get a VMID of its own, it
>    will always use the VIOMMU. Life cycle is simple, the VMID is freed
>    when the VIOMMU is freed. That can't happen until all Nesting
>    Children are freed. That can't happen until all Nesting Children
>    are detached from devices. Detatching removes the HW touch of the VMID.

So, each VM will have one S2 HWPT/domain/iopt, but each VM can
have multiple VIOMMU instances sharing that single S2 HWPT, and
each VIOMMU instance (in the SMMU driver at least) holds a vmid.

This seems to be a quite clear big picture now!

> At this point you don't need the full generality, but let's please get
> ready and get the viommu pointer available in all the right spots and
> we can keep the current logic to borrow the VMID from the S2 for the
> VIOMMU.

Yea. Will try as much as I can.

Thanks
Nicolin
