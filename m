Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2040.outbound.protection.outlook.com [40.107.243.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B815A1A592
	for <iommu@lists.linux.dev>; Mon,  6 Nov 2023 13:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LVGbd1HQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jd34od8sKWgGFGaeECE5BJWkVqRy4QCffWq3PhVzbN6/ZvBo5OnGL1vuOxlNO485KtFZn8T995i08kHvhB4Ix9nsxwhMCTWgJrIRalTOp9HXsVBsRNXYReYW1scbhynP2cuPGNo1gjrzTeRV484hzxo0W6Hbu8BZ2HKtwfz7ZtlSqvnI8bMifF1RjL1/lg5+ZgpLB6C9TR4DuPiGpXIZ8hnXSvxZraSM078At+GJcI7wbDqb4bjHUCQqyz3JzyKSa7R1H6lbqEnOe4xG9xmLpngTBwZXd9MG7+aR57ZvZ1VX87FFnrqnY9Nqq+cVF3mvCDhVG/FTQsRwBhNPfNknDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+zOJsL421aTyAfp6jxwrLFcVm6G2AaBxszwJU/Yx/g0=;
 b=CQBiB18UPCCznUD0bfeMaCpTbDLOFFIRfJoUej5jgOarMCmZFx+mC5hydDitLIxKxYiZiGCbX4ovjR9KlFVMy3D78J3r+nxmUoz1fJQUICkkuWX7bTZvCtMvT71S817U7UrZY96rChrAmNd2E4mMV1qHD6qd3CVmTVxjMiVZEgfcvLa4BrXsh9i3ijv+3CoKKwWEmFgAhHht9yDqJlxdf9qpFIyKJ6ScqI/i7/dITiuB03CraiokAn5S2ftFOCnDqucrDgyEZfXQP7KRhv53mLJStaX127FUWIjtbv8bbOF7kKdQG06ai+/d+pYfOzEKo8DikQ5+ekbdduRdTQsUaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+zOJsL421aTyAfp6jxwrLFcVm6G2AaBxszwJU/Yx/g0=;
 b=LVGbd1HQAKI0UgeQZCih+VnjWrYZTULp1/dOvVkkR3qImNRYAWZ+tLuzBc7EeuGzuZaO3nil9p7wrzRh5fZvd30g4QGaxfnIUA46OgdQul6uTO5Hz5Hi1LzpKiQElbLQWyIIlNm3bIorKLY7mLcK74SFBtKnMXMnkpjjb0eY7orPSzcaqazaHc2sMqou3ncbpSacUuMWP6nX0BjSnrYz+i5PeNdbjgIBgWzXcIC287k67+aXnRcg8t44bpuszZK6LxgYr5i255JsP6BxnWyinwmrONWFpshAR1vsad1w9H+rdWPDZX4LBzgHgOPnefskMc8GyLbWBwqqvImjcz1SyQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by BL1PR12MB5924.namprd12.prod.outlook.com (2603:10b6:208:39b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Mon, 6 Nov
 2023 13:01:39 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::b53a:1092:9be2:cfb9]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::b53a:1092:9be2:cfb9%5]) with mapi id 15.20.6954.027; Mon, 6 Nov 2023
 13:01:39 +0000
Date: Mon, 6 Nov 2023 09:01:39 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com
Subject: Re: [PATCH v1 09/13] iommu/amd: Refactor domain flush global function
Message-ID: <20231106130139.GF4488@nvidia.com>
References: <20231006101624.5912-1-vasant.hegde@amd.com>
 <20231006101624.5912-10-vasant.hegde@amd.com>
 <20231105175228.GI223197@nvidia.com>
 <e4f69ac2-579a-ab71-653f-81af3c3bb3fb@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e4f69ac2-579a-ab71-653f-81af3c3bb3fb@amd.com>
X-ClientProxiedBy: BL0PR0102CA0039.prod.exchangelabs.com
 (2603:10b6:208:25::16) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|BL1PR12MB5924:EE_
X-MS-Office365-Filtering-Correlation-Id: c2d4c789-9194-4c39-d323-08dbdec88430
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	QUewiGQGiXmLBgX8arhzAvuFdLtirdSsc/2CAlXcJjWsifIThSlsfzhu0a/qsdyYC8cZNUxaEe6RVWNSlF7mu0cyqedVyPgybulzhgivS87UDSnZhiZ5X9Q4rZbqZ5F0NhbS3iTDEhGqDLO8dgQ4h72OQOhislD3sy24Vt1hHTOdt5GEYeEfyZB89a7g7ujq/6mLatDicSHul1bQEULpHWKiTTz3CHcP+tIFRDFBXU+HthRgR2OkgXvu6o2wCjpoc2Y885Uw/QbacoMxuYmbhLDcG6hxKy38U1xc133fDvuXKldZIm7HNGAKiYwjKFUOeWhPZUn/MJBwRhk57ChD7KdtyVHyolhs18C9J9C+OekLAmUxs39V1Sc12jQVQQaBr09AvoF+9Y7uiMOi/LpPZIVgWe0EVEttAxR5tIZwWISwZmXnGPPE8D/buGa+3dEnuL9j8ECn0l0+rn/J0EyM8AA8y5c37itnjQ+Hz3TRP5KyXTRbrk/Afr+OaSrzXodeowkSGI9P8IIPOk5tEYHHR+ho+ZxaTdcfEB1gKNhA6kcrKkynPh/s6t8XElQ1SSmc
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(136003)(346002)(39860400002)(376002)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(6916009)(4326008)(8936002)(8676002)(36756003)(41300700001)(2906002)(5660300002)(38100700002)(6486002)(66556008)(6512007)(33656002)(66476007)(86362001)(316002)(66946007)(83380400001)(26005)(2616005)(1076003)(6506007)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0DfAkEqmT6dJB6b1Yb/st7mpGnQm4OuiZgnO5Y371HjUbDk9c522pVGcH/+K?=
 =?us-ascii?Q?Rcc5LfrknegadAKdwzOxsuX1Iam3H4RUHBsx06gLD6OoludgogUGXRCAUyN4?=
 =?us-ascii?Q?ATKHIG9U4bJcx7xIaDcbs2TcRrAxyY7wl270nRIpbAIqqHIn4H64wRRTTkgh?=
 =?us-ascii?Q?SGOBFIgngTQqeT7XyPor1PUuouRukAiePDyWr7lGfM+WGKLhBP9Fawjdl0H/?=
 =?us-ascii?Q?q0vFJO27vqv/kSY6NgI2arVtnLKlFW6aqQC+wPAzrwR38mXVngeeh0srCX6o?=
 =?us-ascii?Q?ZD1xEfsvyZkxd5Y96r00Oo6mA81rEMuvYDgisKi0tN8/REp+etATf0xncmMu?=
 =?us-ascii?Q?jTcoINmp1I/IK8bM7LwM87AsPG2UM5NcTB8RvBybYkqhDVvpRKwyy6G/bTvC?=
 =?us-ascii?Q?1E5d+rplWaXrf+By3h8koQbWnEurtDhvug5bS/WkYxOD12EUNcVNrKlbsgfo?=
 =?us-ascii?Q?AOqpreMoXn94Rc+T0eqpldiCTmbj7jRMj2Eg7RdDVy7QAgo9XwUoCa0+rwnP?=
 =?us-ascii?Q?eBxX0GCj+iVvg15tWfEJmz0NgLSUo3080oTUohqvsTblbJZ2mBWCBZVND+jb?=
 =?us-ascii?Q?abfXKePpbXngH8p22IIEESX9BdLPwypo3nYCKKy+W+JB2qn+SgZhkfLEeURA?=
 =?us-ascii?Q?VGj26jSbdp0MWvZ0WkCVCqPWUXymql4ph995jv+yd9JqwaWpuPfT1yVNJZOc?=
 =?us-ascii?Q?Tu/WJZqZa1BH7kmlcF18EYv/STCpTlu2nK4BBVDHm1RU2+1E47Fi2Bw0KQsB?=
 =?us-ascii?Q?2NhWQXfOdABtbOGwRRlopQPuGWdu5KdoQweueJakXJ7P2NojsGZ4lkwa0tN4?=
 =?us-ascii?Q?vlTsRBTWHqPRCT6W/0b0ncaeSGd3ihdI6od6LPHfmQ4EJKMzYJ91h67uqUsq?=
 =?us-ascii?Q?apeYhc8XFgxMICrwZGj4csHyBYzUZwL2Rd5abBjueFrX0NqZT1BQHSrKvAWc?=
 =?us-ascii?Q?sERkXr9z4chh3b3+g5rMdirjSFrs6I77a5mrCSQn5yXtVAf05tZvN0+DMKzN?=
 =?us-ascii?Q?q/adIJyGN8Mcalurj8IfdW9c0mB/RXcEPnF38t99PyFNEafnB4w7EjUEWX6a?=
 =?us-ascii?Q?ZnI/zQmowUF1hwQvMWW5B1Z6QXVFZNqJ9vIdn+1eG5CHy+S7JPOz6wlM5eIh?=
 =?us-ascii?Q?pWjYKCKJ0dgL2Cy8ZWHTZyqFmGarHGbYTKitcAJnSK7S776DnaP8Zh3ini/P?=
 =?us-ascii?Q?u5pBbQzGaF0C0QNspBj0DcrruxWI7qrJcCDVnNuzWpothp+o+4oTgn6UlPgN?=
 =?us-ascii?Q?l3F4OnVc8gTx9845kZ/XVrq5lYVp0R8YYTD4Uwm/1py3STisq2JjoqSQkZNB?=
 =?us-ascii?Q?84w/RFXjFmo23I9AHLBFzfKePhc5qvhUliQ+o8TRXHQV2B8BtJ0Jmgla4Szi?=
 =?us-ascii?Q?KZO9GuVPK+oCFt/qCcCH2kR6WV15qOF0ZU5+Db4d8eGfeZRYiT/gsohXX6Vc?=
 =?us-ascii?Q?GkFc017VyDpJSkRHq/mqinlmj1a1TI7p+6WLBoxF0VFe0E1MFgeI3LBQC293?=
 =?us-ascii?Q?4BN7FeibVCpj3ZkC8VY24bjoAgB1II05t9XcL+iLK68g4915FrgGByt0DEy2?=
 =?us-ascii?Q?foy3UpcpFZ8mb0oB674=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2d4c789-9194-4c39-d323-08dbdec88430
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2023 13:01:39.7771
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oFnfuGcSmWJ2/G7/j7w+451+ggek4Rc1owB45TrOJ9yaiKdVC51eGdtJnssSe6EV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5924

On Mon, Nov 06, 2023 at 04:23:10PM +0530, Vasant Hegde wrote:
> 
> >> @@ -1553,10 +1553,18 @@ static void domain_flush_pages(struct protection_domain *domain,
> >>  	amd_iommu_domain_flush_complete(domain);
> >>  }
> >>  
> >> +/* Flush range of IO/TLB for a given protection domain */
> >> +void amd_iommu_domain_flush_pages(struct protection_domain *pdom,
> >> +				  u64 address, size_t size)
> >> +{
> >> +	return domain_flush_pages(pdom, address, size);
> >> +}
> > 
> > What is the point of having this maze of functions? Just rename
> > domain_flush_pages?
> 
> Later patch adds PASID check to this function.

I saw that, I still think it is a maze.

> >> @@ -1859,7 +1867,7 @@ static void do_detach(struct iommu_dev_data *dev_data)
> >>  	device_flush_dte(dev_data);
> >>  
> >>  	/* Flush IOTLB and wait for the flushes to finish */
> >> -	amd_iommu_domain_flush_tlb_pde(domain);
> >> +	amd_iommu_domain_flush_all(domain);
> > 
> > This is weird.. The cache tag for a domain shouldn't necessarily be
> > flushed from the iotlb when a domain is removed from a dte, should it?
>
> In this path we need to flush IOMMU cache along with device IOTLB.

The iommu cache only needs to be flushed if the IOPTEs associated with
the cache tag change, and that doesn't happen during "detach".

Some of this is confusing because we've largely removed the word
'detach' from the iommu language, we now just have attach, eg replace.

When the driver has to replace an iommu_domain translation to a PCI
RID with a new translation it should run a sequence depending on how
it is using cache tags.

Cache tag shared in the domain - eg the cache tag is stored in the
iommu_domain struct:

 - Load the DTE/GCR3/etc with the new translation
 - Invalidate any RID -> Cache tag caches (at this point ATS requests
    see the new translation)
 - Invalidate the ATC
 
 The cache tag is flushed when the domain is freed and the tag
 returned to the allocator

Cache tag is unique to the device, replacing the translation continues
to use the existing tag:

 - Load the DTE/GCR3/etc with the new translation
 - Invalidate any RID -> DTE/Cache tag caches (at this point ATS requests
    see the new translation)
 - Invalidate the cache tag, since we changed the translation
 - Invalidate the ATC

 The cache tag is flushed when the GCR3 table is freed and the tag
 returned to the allocator

I agree it does not need to be in this series, but there is a logic to
how all this should flow that should be captured in the APIs. Bundling
all kinds of IOTLB and ATC invalidation into one call chain is not
consistent with where things should end up.

The attach/replace ops should implement the exact sequence of
invalidations they need for what they are doing in a clear sequence.

Jason
