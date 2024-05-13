Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2054.outbound.protection.outlook.com [40.107.92.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76EB0D51A
	for <iommu@lists.linux.dev>; Mon, 13 May 2024 22:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715639792; cv=fail; b=pUmgWX5VEACdsiM4l61vViyHSTI+PeS+3nWviYBNwThMMOvEftQpq+YNEGphv13WjFJNrDcZuOg8XpnGJT8mOL+ybHCTznNhNp5R7zFrkt7evqrlCp0NkITdo+boeNgPvdBsLkxwV0u+zfu2zFZ4nc0PbcGR2VxNPEooXT6nm7c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715639792; c=relaxed/simple;
	bh=EikdCu0KVbvgTQs/KsCXjiIRMtQ1AgQYFShsDxbv29I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bYfp9WNcqS7INUD7zZ3FvuHNuMcjlo+qnNk0quv4wwf42M8otnPMR1JdNxcu/JdKPhhQovF09g4kgh53cxT59RCYLpKWNmdFJA1HA8rGftP++iyR6bdT+pCN0EeQUd6q7JthFXFdbekDdiO2fQypo7F9rwRNE22dBGNU/SA2Oag=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Tb+fXxso; arc=fail smtp.client-ip=40.107.92.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Tb+fXxso"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AbZp9mPDydG6weBWvuSbCf5rDhFb8pRqtG2L8l3Z4214aT8GYnsFXcTwDSXoFVaKsC48JtQgOXXy0smqyACyWOlk3VUo7Ii9v9Zi3wo/MnRN94zibifQ8ZBo6z8gk2wmKjV5+YcRgsyKiSov8q9VoZFO6bCEhAjT3enIr5rUHR5cvR+bpZgirJYXwzLf97ynRIr806xR9bua0YEm1jArxKly4qUtWASCUyCNi9VqRzENSyew4AB8OOEYvulstC6tgk/4fcMpC8vadrhj+wwPx9HfPqgGQ+beqJbvbCubVxHHGPsovycS9x1ZNJ9fu/Obk31W66HmfIv+YB8s3APjCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EJTII+l+JnM53pfUE/UncmqTezpk8rsnVov3Sg/QZoA=;
 b=IuETnWRSIoauuTFpCBIAaDF9gQjKEJFP7lY3A0Ed/OVJ7eqAt+QGaPCgCS/a26hZH7fobCspYJMmqGbZQu16XN0e7GfjjALOcGR/0pEb7FHHM0czY5RzkSGo1IBTdM1FLiw1f0/+5REz9ai4BvGGEGOKpdBzaXJ5iWJ9mJfYlExTgtKt+s9zX9Hk1aL50DfNOr0TXmOulvFP+DwOYSUnHqS7mT+1JZcYEDweMQdcxvBS1sr13dFwluKHSxkkEENFFMpMTo4Aq3ox+KNGYclilxJm8pHWXbq+qxdq0+NOWRcyJW9g7M1a9zhZhIbvulGMiLne+b/YwTJHkvcs0oOIJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EJTII+l+JnM53pfUE/UncmqTezpk8rsnVov3Sg/QZoA=;
 b=Tb+fXxsonBTFOp2n/Em4bPjXHY7CYMhRe6/EzLWdzngEooyM7/jt3OGI8MOEjgs+fj4mCbBhM1WctWN8E0s6hXur5EFKeTBhShP5hHmVOgNf6+SRd5gVaTIHnEpvG/l4bpC54EN1p2kF9D6U5JjFpPivN5itLGDqD3raQ7zJPnQtPp0F21gxkidBUueR3OREzTfaSWeoUp2r+yndbK/5rT3IixxgFUnbNE9JgT/Jd1LtwWthPkkPPr/nb2o5X5D/bGHoPH5LQc9wlasljY9j9NnfVUyyjOpqWk7a1zdMcwzsnn9hffIEJZhbk46EncySxAb8rbiGXwkQGVUfpJfZeQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by SA1PR12MB8987.namprd12.prod.outlook.com (2603:10b6:806:386::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Mon, 13 May
 2024 22:36:27 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e%4]) with mapi id 15.20.7544.052; Mon, 13 May 2024
 22:36:27 +0000
Date: Mon, 13 May 2024 19:36:24 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: will@kernel.org, robin.murphy@arm.com, kevin.tian@intel.com,
	suravee.suthikulpanit@amd.com, joro@8bytes.org,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
	yi.l.liu@intel.com, eric.auger@redhat.com, vasant.hegde@amd.com,
	jon.grimm@amd.com, santosh.shukla@amd.com, Dhaval.Giani@amd.com,
	shameerali.kolothum.thodi@huawei.com
Subject: Re: [PATCH RFCv1 12/14] iommufd: Add IOMMUFD_OBJ_VQUEUE and
 IOMMUFD_CMD_VQUEUE_ALLOC
Message-ID: <ZkKV6HcHEw5vetV4@nvidia.com>
References: <cover.1712978212.git.nicolinc@nvidia.com>
 <b0ee53af3f59602834e67ddf86c748ca304da175.1712978213.git.nicolinc@nvidia.com>
 <ZkDZ/YO0jqZOlRtA@nvidia.com>
 <ZkGZ7+37HnLlT6Jn@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZkGZ7+37HnLlT6Jn@nvidia.com>
X-ClientProxiedBy: SJ0PR03CA0018.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::23) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|SA1PR12MB8987:EE_
X-MS-Office365-Filtering-Correlation-Id: 51c4f063-3fa0-4025-a419-08dc739d2031
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|7416005|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8XxbJxrFKeUPgi78lDFy5VtdCq4syQFfuJfrJBRx8RQF2A2/T5znHZLOmORW?=
 =?us-ascii?Q?jEicIC9P+meQQBdo1ePSQl9s923+RFs6iLlxUmYW1LTUa2PSE7on2LeaiUpI?=
 =?us-ascii?Q?MMZ4K1qQzjgKzLXGKkLw2SEaMN45a908sRVDHyL1ACtlCoRs2/Ib/rjkrgn9?=
 =?us-ascii?Q?SC5JXrq8Q/m1gRcbB1K9I05jPa3M3YZcyJMCCozoP42NbOFvqIsOhV7zG3m5?=
 =?us-ascii?Q?uSPKrYccliYylwPP6OxxyrsQvLfJUqbnyF1OPbP2mNl+mmQXdzkbU+HDCtzz?=
 =?us-ascii?Q?njIsqRLSu7roH+hPaol2M9xIQ7CPWMP0DAGDAafkzY3jgBfh7fw7fKA+32vg?=
 =?us-ascii?Q?X9VGhTuxWbSUVA32EVzCYVzEWUn2SCfW+c2K2PJ4zyw8q1hSBorlSLib/Xx+?=
 =?us-ascii?Q?jWUHU+fEa6+lM756i0UkJLcBPWb1s3lTm9TZcI8ElDs/26GVc2wt4uUaxdLI?=
 =?us-ascii?Q?v/jeVG2fEfl0bFmt5HznaGTun8NzJYcaKv8UjUJwWwUV7l+QJAs113ohEFMo?=
 =?us-ascii?Q?LiO3Sg7DucQ2jttk2sOUpTr/5Uy3ZUf3jDVN5pukKY2NZYZgUZ7ohE4w4Ux0?=
 =?us-ascii?Q?mkI4roBtpPXWGGXFFpwfZ1VWpEckpDf++0diGb9iU+P8cxfkhHSoVZf15HzV?=
 =?us-ascii?Q?HtYhjTncIfXIZYCYBJn0VoHt0E0u3UdcHXx3Lwb39cWBKcYXheRxjSqaXrtu?=
 =?us-ascii?Q?CPiy1NMyeiugF9VVz52KEZyHpGUxvsq60SPw9zPf4Jwn05lAJBqxF5YTKwp1?=
 =?us-ascii?Q?IEZjXw4msKsKfVRAr8Yp/xfKgSplSR2H1MpI835WutZdKAXn4kWMsWVZtjgC?=
 =?us-ascii?Q?eULmr7JPUKtnnraZHtj+kUGlhSNYx4YuIROES0FXj2cMEd+6HJQ/5q8KQmW7?=
 =?us-ascii?Q?Qf59wfMps6r7TTtkj7hKssj4o1HVf469pzIPefk2vz2x7knNX1DLWCLjzZqh?=
 =?us-ascii?Q?wSLmrlsn/XA1Vn4rN0JZqXbZ3zaXJKfqu12hhzJxfriC0bVerQCmi5SyTL2e?=
 =?us-ascii?Q?EFIAO2IhyJEwMNhi6hNMPpPc9QosgVa04oRckB/ofcdo2CpxPrW8l/v5qfvK?=
 =?us-ascii?Q?fX8GWpHi2S0y7QNxpBfXL+JG5iEFJIm4CbeTx5nwwqCi8McUtTGuGbIW3ZDz?=
 =?us-ascii?Q?8I2hcBodCE35V5NyNkz1neVpTJdjY7JGP1Bi7pgSzuDfFQAtFHPZGqiqvBA1?=
 =?us-ascii?Q?aNeu3q032e8WASR/CcVqw0oRdQ/8vVlSDaiJXOxGRLSy27MINbvkilC+VZ1L?=
 =?us-ascii?Q?pEweTLXB0Dg+uzMkST3kzn91fe3ObUK/6rLk6SJ6qw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(7416005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TZZ5Tc9USlLetUsEJg95EiYZJ86ZlKpICHdpCWWO3oHakHnjG0OgiMwUaiZF?=
 =?us-ascii?Q?sYuzd9rHHWGJK7L48aeesQzNvpv1/c3qsLWXvgAwryXBPyj48a/VDMR0iS/M?=
 =?us-ascii?Q?/FCkq8vnlFoZp3Cewry70Go9/OfWZZYqfQ2jTNLhNEGQIj7fV0fjtRMky7VJ?=
 =?us-ascii?Q?Xl/0+q8T9sD0K+7/NkAl8mfenJhWFvEcfSM/ve9B+gCnYcIOoB6sRii1pYWj?=
 =?us-ascii?Q?o3L3BYugWK8MVd4gGYqtIkebCTqTVJMho6EcB/BoNizzNaHslA3X0qxrNbmr?=
 =?us-ascii?Q?6Am1YD7lhvheUG/gB271yIvrUZx8uJp6YZoxw+oYXwixqoztSQJe7T0z/Kny?=
 =?us-ascii?Q?fxCX7hx0EiNFXzZf1GEwj8too0CWHKG4U9Up3aIY8h+T2s0j+PWextT25Mcl?=
 =?us-ascii?Q?C14JGw/GB0JoGrJihhcoT0UuPeGkpCdJ9NI5MsVTOAEjOrL8aqEbW+PEo70h?=
 =?us-ascii?Q?oieWVfxuuwazpvzmZaszdHY6tlPmOMShAFZF5U6X2d9AXCb0l40c4tPdzxMf?=
 =?us-ascii?Q?97fySjlgw/0HxHszrF8w4oM7KFq/xY+hw/Ks8eP5jgG3s48ewdTn5OgU8ykQ?=
 =?us-ascii?Q?yADB55/VWni9zFYpSynRR5WEf70J6bgCDFjsDGPvPdhBL/ygZJ2h/jzmQalE?=
 =?us-ascii?Q?84eDNBq1GnXQs00GpQl1ZVRLB/Vc/YAgomIcz5YAoke/wZhoc7FxQbiTG+j+?=
 =?us-ascii?Q?pp+lNzWJ2WvE/pYMpnNsdEyC69sLQRDlCGvhNp7FFRpJjuyXDinYUthuWAlq?=
 =?us-ascii?Q?UDOPu/l02a14HJKhVE1Ve3esnXHG0BIBk1OeteeM8NCgcWUlddMK0rZWU38G?=
 =?us-ascii?Q?Q7tcDjS2QMArPtcGMbDTLdtQcKGwqyQR7v27Zrl+krIq3XtGkM50R5qNFQGI?=
 =?us-ascii?Q?t1k6n0lM2hVGb5NbwO0Wjh5e1OhMxgFBxZmNvfHAFMObv+PN/GypyMZmk733?=
 =?us-ascii?Q?YpvFWieAEtno4f8+bm5JnK71fldFHNqB1Ji8lFx+DbDr0KG1ZCe5PGd978q4?=
 =?us-ascii?Q?ctQdeatvPtTTvhBFo2cFgYEueAu72kMAkFxmLLRt+E7SmCaPU7Of3sdZjltL?=
 =?us-ascii?Q?J9nqv9I3NQzFMCAIhZU1J5m5BK/BM12WDvo8giOU8K263N3Y9TVm8/EmF4E0?=
 =?us-ascii?Q?qWJf8DOjijfqH2w95z3+EvaQl+xQq2jE/4mVkW+mBKfSFnF5GO1m6jXMX6aw?=
 =?us-ascii?Q?WLVmU/CMZShoD8R7M7npQmKekiusxQzXEBpaMLfWCIUihv7oLMiqpPiavKEd?=
 =?us-ascii?Q?f43lr1PEVQfynWeBniaGI/WjARzlxxuMEO3y7CPBvnh9AhG6P4uNFYihFBAo?=
 =?us-ascii?Q?yUGO/4bxyrC8h/ssguQ6E2VvbUcQA0mupFwZRNlkODpUPow8ZmjbH+ji5f1k?=
 =?us-ascii?Q?dfbUAlgoBpphrg2qDDHQQMW7py9pguYNv0XoEzmIV3R3W7upaq7qVKIS4Gc5?=
 =?us-ascii?Q?I5Wx6BqcgecfyoNSqJrScHqj8Gny+iXorsjIQaF22qaFBgzS3RtP2WIZzITI?=
 =?us-ascii?Q?3ygSzyfMQ/1HAdV+7QIGV/grg1vMY6SLmJ6bw7hoExKJj2wlHVfr9YulyJXO?=
 =?us-ascii?Q?xhBQ2868Os7lNS7zrUs=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51c4f063-3fa0-4025-a419-08dc739d2031
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2024 22:36:27.1611
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d99f+Aryzk2erfPuPP3zXFjtEoMYjgJJbocxEU0D38Sc8dPTRTyE7rKTFUOOFTO4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8987

On Sun, May 12, 2024 at 09:41:19PM -0700, Nicolin Chen wrote:
> On Sun, May 12, 2024 at 12:02:21PM -0300, Jason Gunthorpe wrote:
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
> > > + * Allocate an virtual queue object for driver-specific HW-accelerated queue
> > > + */
> > > +
> > > +struct iommu_vqueue_alloc {
> > > +	__u32 size;
> > > +	__u32 flags;
> > > +	__u32 viommu_id;
> > > +	__u32 out_vqueue_id;
> > > +	__u32 data_type;
> > > +	__u32 data_len;
> > > +	__aligned_u64 data_uptr;
> > 
> > Some of the iommus will want an IPA here not a user pointer. I think
> > it is fine API wise, we'd just add a flag to indicate data_uptr is an
> > IPA.
> 
> Ack.

To be clear, add a flag someday, no change needed

Jason
