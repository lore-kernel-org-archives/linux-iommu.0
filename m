Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2059.outbound.protection.outlook.com [40.107.236.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DA1A4F602
	for <iommu@lists.linux.dev>; Tue, 14 May 2024 15:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715701148; cv=fail; b=vGG76I8/MoGmfpDwAn8UUmYI6+Iw2HknMQZiZS18JPCtgGr6waVGFdHOelE+A5pW+8gMrLFfH4ZRVogYcDh3VCohx2dpwYPJ3yX73fGl7X4+AWkCIn0q2+/CYDkFvOq/IWMKNc11WBppe8Ujnzn3kYBpUYejnJP8yGAAoaY+GRc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715701148; c=relaxed/simple;
	bh=pyPfbaJeoir0rcKFR7T9jcBesx35vqGjq6BvMH9cSwc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GY+o+UyMsCIgQaEMhvBEUWZsbznSfmwjVmDT3Nztttxh1nkfM+xwxUTB1qzI+OLT1eQX108PXrTvAR5OcsGHZienRP/gTtcxqFobDJPw7DdyvO+ogNxp3hxhNzAIZf/4MeODBNJqVeOwCsxf3elG9l6v5b0IvcNEeywszWzrAIw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=J9CFYyw/; arc=fail smtp.client-ip=40.107.236.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="J9CFYyw/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iTxIBusKVXCmCN5A43VdwIhgYRC6fUYuboYX+VzYu4UoPxePLoFK9Ksfde5TwH1Vtj6kFeiRCuqkZchcvzA9bmEjnfDDfNYlGoXiaOscg7aKl+UfVrJWdmeNTNNKgWvpAW1IVmHcqyCaOYVfWwB2+AVXL6M68uEjlUxy5Pg7tjyfO3E20W3j1Z9ZGZyqZQ3VedTyjE3emI5UuT/9WflR9fhvviXifehJjfzvGqJED0UolWzP2r9UxNEiiwM3BUM542E003WIbG1x/JjGpvB8xjdwlmrSycjcoiHV24F5qbaElS9MLH3qaiPIwOFnThDyybXNnmZX/OzjGBz2YI3//w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5IUwsVZt/lxA/zYGwfInhmXgWa8/oHu7do369JAssjI=;
 b=UfVZEeLLTAJjtuj4tdU4aRq7u/XG0ssuf8adYqrKdsOOXsHi/zynotd4Phnosv//8YrgLC+SOKtyIwjnNjMbTN1zHluabvke2Z9fNuYKF1gy9vr6959xseIpspul+ISQi5I0jv9t9H4eYkQJ8XWpKmOEB+DX2X0BTWzZVwXbgc5UNt+CCSFDuuoloMmsWSGEc+pZiCRSYVhmyhJ1/TNEpc4v1IjttgB75Loav9fJvQrbn6DYzenEbnpdjLpHyRVe+On5ChGEKIzsiRou5UJA6mM7LLuHxChpzNMhwv6gEgC5B5q/Olx66mUMcLKNxgeJXrI2w0S0iJD9Z0dnHg+Msw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5IUwsVZt/lxA/zYGwfInhmXgWa8/oHu7do369JAssjI=;
 b=J9CFYyw/C13DiSKuzMA54RHgg04vnAYgb/rmCNaIPSeTcDWl3k+7iPRPPxgpSAeERBFqa2ojcC5fGKd+qeb6zMUD78duIxH+gwPcvdwN+xC6tv1KWyc8cVHvML27NpsXHIVtAbTzgrXa60Lgb+XzS1hL3qc69bg/+4sA1icZoH+LhwYfgt3PaXPyEzZJrz4U9yUUyL2prHHy6fUJuu1Um/wNGiEqu06qI4rreXYHamWqroI8/s/eNOMrJrUEWNWD74ERIhvM2jIyz2jGnvxcTvnbO4iS72aYkA87S/6sELa/vNV9A3s9s7N3sLzCpyhTMkmui9y8H7vB6gWptZjZNg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by SJ1PR12MB6146.namprd12.prod.outlook.com (2603:10b6:a03:45b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Tue, 14 May
 2024 15:39:00 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e%4]) with mapi id 15.20.7544.052; Tue, 14 May 2024
 15:38:59 +0000
Date: Tue, 14 May 2024 12:38:57 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: will@kernel.org, robin.murphy@arm.com, kevin.tian@intel.com,
	suravee.suthikulpanit@amd.com, joro@8bytes.org,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
	yi.l.liu@intel.com, eric.auger@redhat.com, vasant.hegde@amd.com,
	jon.grimm@amd.com, santosh.shukla@amd.com, Dhaval.Giani@amd.com,
	shameerali.kolothum.thodi@huawei.com
Subject: Re: [PATCH RFCv1 05/14] iommufd: Add IOMMUFD_OBJ_VIOMMU and
 IOMMUFD_CMD_VIOMMU_ALLOC
Message-ID: <ZkOFkfHhG2h2fv/c@nvidia.com>
References: <cover.1712978212.git.nicolinc@nvidia.com>
 <3aa9bc1df6a2ee58a03c6ea6ededbc210a2d23a8.1712978212.git.nicolinc@nvidia.com>
 <ZkDR4Rp57cy9qSqP@nvidia.com>
 <ZkGYN36N7sh2vUmv@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZkGYN36N7sh2vUmv@nvidia.com>
X-ClientProxiedBy: BY5PR17CA0054.namprd17.prod.outlook.com
 (2603:10b6:a03:167::31) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|SJ1PR12MB6146:EE_
X-MS-Office365-Filtering-Correlation-Id: 28e61668-e0e6-4590-2d3b-08dc742bf95e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|7416005|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?btVURgoKGmhT5v2D0kBhjuldUGFX+xNzAXULOIPzk6jUwcDNzcNbwEfjkK+g?=
 =?us-ascii?Q?woZB5ujCIkN6+Hpun3D4l3JqtKzuxZVlqsMQq8AJUEKGx16F2deKbWQ73/qK?=
 =?us-ascii?Q?/Yn5LRLfM6RJ+PtkBpfSDAgNfJ4HnzJIGKE3UlQ1aF3SaFAX9rlVMGNK7VOR?=
 =?us-ascii?Q?S/eYF20ZH4u5dYF0bZiKdTc1Mq+LcIdPBv7R7XIAxX9r8OD7gS2sextvtO1F?=
 =?us-ascii?Q?KoA1+mdQGAxw+zh/NuuTEKR1H5a/VI+yjQKoIcqyyzzbv8SmA8n9isNIoBW7?=
 =?us-ascii?Q?suXcrQzVe3XY3kEhybUnUjRsFWI5HDHceENNcTKEApBcXD0FEwVFLqQlrV41?=
 =?us-ascii?Q?JeYQNPV3HxAFt3GIKH0Y0J6wb8s2kPMhbH+R4NGdJJuqDzsU3WisyWJSZdEK?=
 =?us-ascii?Q?IRGVby6Dz/pllJgezG/Nmv0BsQs4hfF51BfOTjCeAHNqxCRyFvoxqEcd7cir?=
 =?us-ascii?Q?NadAAmrehKYwomwU71c4NONBrl8c7mJjCXjCJl2Pe2kPQ5YFkjGhM/Rm2eik?=
 =?us-ascii?Q?JZ+UFJmLJTs1fa/vCZk7WuVTsTT6ZwMwVBENWwMsgqYMxhyPfjl/nmjKcUR0?=
 =?us-ascii?Q?fO+kHxtJC5Pj+T+V7QUgEaOLNA6OXRWziOs1K1UrEX0x7dIcwJiYntPUzwcE?=
 =?us-ascii?Q?lV1qMgqY2y4EKcl+FLqrQMN9ltQcU4rh0iJn5749sSj5lQZJldcqvZKrLrWZ?=
 =?us-ascii?Q?170NekOmSmEFJHVkSzl4KtwrJ0XGBFbGlgIKJhZwq++ZkiqRxKvDM4l1crti?=
 =?us-ascii?Q?GsgajiQevrmCec3FThldT7pE/6YGWR73aE52w6Lw0rb1b102totcIVq63aC2?=
 =?us-ascii?Q?2kskuxTL9KsXxbx+K+xwye9wJeid4Q3C2NnBnsn7y+J/o893c4U/inzdVLMK?=
 =?us-ascii?Q?vWar22ugAuUlT5rrOUf1b8MypP3gnMaz8vn06h8RUH1sI+s/CFJORLkU/t9v?=
 =?us-ascii?Q?778OmIG+bjg1LJSzuRXKBqVYqT7r+R/copJ20lD8QAwRNEz8zNCOZ7fzgJLg?=
 =?us-ascii?Q?EmH9vxSe+aqxG+Ruv2eAN/3QvlLAF1NXC5VQoa23DVAp9f6elfCZEtuwzz0X?=
 =?us-ascii?Q?voTuPSNFZt53yLMG4HpVre3N0ugR46vMN3jSRp0kbqHNnCdF6nvZxvV5vERy?=
 =?us-ascii?Q?CXtGWIrVlJPSS9H6+YIKAWFlN8UfFAzq+H/7D5VLapunMD0OOFoJmevu2+0V?=
 =?us-ascii?Q?IFPECOp/dZXGIrg7Hb2buySumHMHuAzps/uSlpvB3ONvLyV4Sn/chpGAACgq?=
 =?us-ascii?Q?2Dea+i3j2sTMRyqASYpZhf0oI5NIJDAhjPQOcMlDTw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lxsi2Ly7WKXuEQLOJNQtVfXpAU+Bpdz4EZgGN4Y55MyHJDyl86c9nUZK50zQ?=
 =?us-ascii?Q?kxbhbJMnOgFTsux2O4d7eMZNbzI8GZQXEHhW0+McvRFlZ2Hmgdrr3miMNYFl?=
 =?us-ascii?Q?gLV55CG8Dv/xk3abG140rDSi+yMiSFendau/lwHZ4TNUhIK01YruR4PPhus5?=
 =?us-ascii?Q?YfnqN3x/Rd2FDaarC54AfsKQTYSv91CdRAh01XzNk+GxhLgQ4s7Ip4t/HebH?=
 =?us-ascii?Q?omgF0OezOGQFbm8simZx45d6XqPb0MHxQGRHApBvJmzv5neBqZqop6q1X+LU?=
 =?us-ascii?Q?yCED152sqGzNq8mnzgQmU9GxdR+TYZ0RehSm1MwBx9d1S5MREPRelStaMQKi?=
 =?us-ascii?Q?PiZ3glChDJbgn/Wk6kYglim35589PuE05OGXUUxM20XER/4q1sbBd9elc90j?=
 =?us-ascii?Q?bmrN//tl7b5zSW6C9Gt5O5ZQxMCxb/qRIaX3Q/NB4fwruGv1gmPnY9lEoTRQ?=
 =?us-ascii?Q?xndBo8jxFmrqkOD7BBu0akEIEdTHIV4D5ZD8LHw1aEKUeSCaaK2m39P0dRS5?=
 =?us-ascii?Q?0AqZfRNFTbaEOMHBH7NJr+Iqe/YZTPDb2afm6o7N04/4p13mPYNaGjeU6BrC?=
 =?us-ascii?Q?xly24OrCTqJE4EdNl2mmm/Dd6px85Pbva0hKWisSCKSuN7wDx9/gWk73fZxt?=
 =?us-ascii?Q?Kknd7InFGrc2HhenuJIWCyflrjM2Qt90uX2KSx1F9OM4qCtvJwwjwAxcmFHl?=
 =?us-ascii?Q?cr3kiwF4Np4+jNM8DQ2QkgZtiCRgMEvVLfY6reZeDQ2fUmRlWel909isUT4v?=
 =?us-ascii?Q?Oz7f0bsHHyDciHrQ8ccsOnl48aIo7996UQv3pYLA0PkxQXbm4I7mTYlF1+vO?=
 =?us-ascii?Q?1KnaJwYiFoaAmeEqOUNCY+ctDESZUsrF7Adr89rWZF/xDD9JBICFam5kpGb+?=
 =?us-ascii?Q?j15AakqAygLYy+VGHYAy+UEtR43hG9nHKpUTMNfVlVq/OfWwo9OA7HCr0BNQ?=
 =?us-ascii?Q?QNY3+u5IWBwCj8HWGCxnXosDkILV/QaspfKDGaj2LAy8tjHlXUUGqFa8u9sK?=
 =?us-ascii?Q?zQ0v+gPJ4YZS590F2WMbGpgTGxaUm6MY1+OuI9leeZldxWXbV6k1wfUjTUDF?=
 =?us-ascii?Q?WIzPvRRhunxGondxL/Oj7m7w56xleU8wNGRalvlfvqvsrcDE8e2gZi25csJt?=
 =?us-ascii?Q?bbpabY1B33f1zF8DUiUFeKntpPUfdmdTETAKwlV9jP7DMexl0vS7PL35e3Xr?=
 =?us-ascii?Q?3X445dWiWUT9q22MnbTyMgTWzN5DbwSLsOvprx/Fe6Gn27iA/deuoxXtA5cH?=
 =?us-ascii?Q?TXMtlPfrN3jJ5nUOKPdLUOW1OrEkKiB3LQrpGsQtPVd9p7v3j5EgRN5er25I?=
 =?us-ascii?Q?zAJFAYFMbxwdDc8tHncwJPWnLnmcAGZnF5+hkI40kSqgNTx4eAXB6602soUF?=
 =?us-ascii?Q?IVFD4sPPqXOOCoYupyQzp0Ggvr6Usnxdr8SU7ZWTAQbttFH4972KAWmL4N/c?=
 =?us-ascii?Q?Uxp7BYng2gvlyJtf6RDv8fIi9aKVZRRrmy13u2GiodnZ+A3z1NVmd23wYNB7?=
 =?us-ascii?Q?EgGjtjHCqyuImrvh4yJdJNWt9L/wxGCpcR2vtkifo7Bx9p1WsK/LxeEdRY0p?=
 =?us-ascii?Q?bibNG6rLm53kT+/QSBE=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28e61668-e0e6-4590-2d3b-08dc742bf95e
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2024 15:38:59.7264
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lrZmOq78HWMJGhxsvRFM2CnOeoNun2QPYHAxgN35oHI4cgUKnZLNxzAXCA9Ek8jg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6146

> > > +
> > > +/**
> > > + * enum iommu_viommu_type - VIOMMU Type
> > > + * @IOMMU_VIOMMU_TEGRA241_CMDQV: NVIDIA Tegra241 CMDQV Extension for SMMUv3
> > > + */
> > > +enum iommu_viommu_type {
> > > +	IOMMU_VIOMMU_TYPE_TEGRA241_CMDQV,
> > > +};
> > 
> > At least the 241 line should be in a following patch
> 
> It's for the "enum iommu_viommu_type" mentioned in the following
> structure. Yi told me that you don't like an empty enum, and he
> did something like this in HWPT_INVALIDATE series:
> https://lore.kernel.org/linux-iommu/20240111041015.47920-3-yi.l.liu@intel.com/

I suspect 0 should be reserved as a non-set value for some
basic sanity in all these driver type enums.

Jason

> > So, to make this all work perfectly we need approx the following
> >  - S2 sharing across instances in ARM - meaning the VMID is allocated
> >    at attach not domain alloc
> >  - S2 hwpt is refcounted by the VIOMMU in the iommufd layer
> >  - VIOMMU is refcounted by every nesting child in the iommufd layer
> >  - The nesting child holds a pointer to both the S2 and the VIOMMU
> >    (viommu optional)
> >  - When the nesting child attaches to a device the STE will source the
> >    VMID from the VIOMMU if present otherwise from the S2
> >  - "RID" attach (ie naked S2) will have to be done with a Nesting
> >    Child using a vSTE that indicates Identity. Then the attach logic
> >    will have enough information to get the VMID from the VIOMMU
> 
> What is this RID attach (naked S2) case? S1DSS_BYPASS + SVA?

No, when the guest installs a vSTE that simply says bypass with no CD
table pointer. That should result in a pSTE that is the S2 with on CD
pointer.

I was originally thinking that the VMM would simply directly attach
the S2 HWPT in this caes, but given the above issue with the VMID lifetime
it makes more sense to 'attach' the viommu which holds the correct
VMID. 

The issue with direct attach the S2 HWPT is the VMID lifetime, as it
would have to borrow the VMID from the viommu but then the lifetime
becomes more complex as it has to live beyond VIOMMU destruction. Not
unsolvable but it seems easier to just avoid it entirely.

> >  - In full VIOMMU mode the S2 will never get a VMID of its own, it
> >    will always use the VIOMMU. Life cycle is simple, the VMID is freed
> >    when the VIOMMU is freed. That can't happen until all Nesting
> >    Children are freed. That can't happen until all Nesting Children
> >    are detached from devices. Detatching removes the HW touch of the VMID.
> 
> So, each VM will have one S2 HWPT/domain/iopt, but each VM can
> have multiple VIOMMU instances sharing that single S2 HWPT, and
> each VIOMMU instance (in the SMMU driver at least) holds a vmid.

Yes, right. We really want to share the S2 across instances in the end
and I have made the VMID per-instance along with the per-instance
ASID. So the above sounds like it could work

Jason
