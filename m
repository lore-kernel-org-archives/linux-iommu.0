Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66FAB1C298
	for <iommu@lists.linux.dev>; Wed,  1 Nov 2023 23:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="s9ffsbj+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F+HTQlbldL8yKVcsgCL+ledQ/Q0mU1ej/i0boAjkJyr1SSYTmDl9PtV1hw5w8D5sqaYdxW2XviUt6CYcPfAxSxqeC/pvhRixsK8w0F1rwZBkfePIRa9YJKBCgHmDgQC4BusYE2MX6s4rXy0s572WkIe1Z1VoAf0PbKlvVFe/Z3sF5gqgN0Rg5mCD0InVOPKcTnUV/iEAb/4UhZi1Nle/oqfQ1tBcRb7R+ykYeyuw0eURAAOeQc+NINcsr6i+/F9OYrcO2ENSx9RN5WlewQCikSCVJjIwWtYre+q4uBAN61zvFd1xHDTKqkRochJdi+GH7LVjUjX4kApOQzdXvRBqDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2WBXA2FhgfAL6lo4PB50Z2ds26skT2KUT8qII+oO8P8=;
 b=mm96ulmOGjLpXD8gQfwT6rEnw0QS5FKM573Cn4tcA2rMP2KU7LsY44+9mD4e1f7Cit+/PjDCMF+p2ayFNpGIF2E+giNXhoUxCNmoXv+jylpOpDVFqPQoDwTyFnQIBD/WXAHkaHr9e/a74w7J68nHl6EyJyuSJlKV3VCRVXMFIo7qhhL3A0Yj0wlhin+D05L3jli5s3M+dkF8nhNtVHS1MxweD2ghOTw2sE2uJrkJddLxKbCVjSc3Ru0d782I2zCUR163RPorEQYHXu62vF541+SGy0zuiosLA8xuh2ffMgtyN55V6s4sg1qVedRFa5wBP/ZZ1vozm24pGztCgVt3vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2WBXA2FhgfAL6lo4PB50Z2ds26skT2KUT8qII+oO8P8=;
 b=s9ffsbj+302TFv5GjvsqqesJgZaupeCYfy4mQ602+Y/MW3lqYvpA62LEUafB1FRrs9dWVh1AsJhXeBzrH+BEZQV9aHyWKtsVsUFe/NFo+JX4hojjiaSTj5GRZZ495SVZM2U7Mv38oBpS4XbEwaFiptsC2eCKPKD6036MIbDMua1YDfiXlw+h1nZj4TJE5VyWwvCJk/mj+EP6TF4RmixdeWAmL/zlK55Woepc+kRbeueNTenQRIGVw4OeSa7MD0FNQN1hc8wcOX3cd+zlcPqZeUXXZ5t8ITH3lPdy6V4KjVbq9AvlxClLx8o7VjIHdpyoD/fq4oSDqcOY1plcBY1egQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SJ2PR12MB9139.namprd12.prod.outlook.com (2603:10b6:a03:564::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.28; Wed, 1 Nov
 2023 23:17:29 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::b53a:1092:9be2:cfb9]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::b53a:1092:9be2:cfb9%4]) with mapi id 15.20.6933.027; Wed, 1 Nov 2023
 23:17:28 +0000
Date: Wed, 1 Nov 2023 20:17:27 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Jerry Snitselaar <jsnitsel@redhat.com>
Cc: iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
	Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Janne Grunau <j@jannau.net>, Joerg Roedel <jroedel@suse.de>,
	Sven Peter <sven@svenpeter.dev>
Subject: Re: [PATCH] iommu: Flow ERR_PTR out from __iommu_domain_alloc()
Message-ID: <20231101231727.GA5675@nvidia.com>
References: <0-v1-ee4b137bfe3f+57-domain_alloc_err_ptr_jgg@nvidia.com>
 <65qhudcviofmcl2g64wca4yy2a772uqvoky6xp62ij2svj67vg@cr2pu6anogqh>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <65qhudcviofmcl2g64wca4yy2a772uqvoky6xp62ij2svj67vg@cr2pu6anogqh>
X-ClientProxiedBy: MN2PR10CA0020.namprd10.prod.outlook.com
 (2603:10b6:208:120::33) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SJ2PR12MB9139:EE_
X-MS-Office365-Filtering-Correlation-Id: 595199a2-2cca-40a9-df8d-08dbdb30b755
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	iffArRvZRfqb/zP/XXbWf+cylyQKiz2ZRVauhugBtQ1uMCIMZ2uiAAd50C3cmdFk4gbydfVs8DeryxSrtair2nXHZTDaRNmHXTJ2Lpe+4b6Rpkxhql7bLgEgTPWm8wH81kN//rqbT8GsINXXTknV2CX3Zw+th6/kESaMPWBvl5krlzNu7pQ7lVHpFZVFZ8r3cS2sBYA4uvM9neTndD3Q5wML2qUvsfYT3RrO17YOE8tXFxuIzMqBYczlJZ33PPdZWZny5s5XTT10HwIQFynQ0LploZyvATTSjOv06ZehoyxX+SFryCaMf8bVd6crbmrrWUO+OaUl03k3MjopriCxu+Tz4VXDe/z303v9aTib/cPgXgCqnxX2pZor4YH1w9r38MNXVeKwuJY0XS6guzhw+7ILL+poVEGiTZykmAG6s7wesAHTdYsGi0fuH93ASxgBR5URSKKtPJwQIDUOKcYW5EZ8V1eRg9Wt3pGAqrA592X/PMzL1r2EtJQ8Lqu0lG/vQhynVyhZCjzrmFUgMtgAUsiAH9e7z9i+ANVrp/Mc0pQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(366004)(396003)(346002)(376002)(230922051799003)(64100799003)(1800799009)(451199024)(186009)(41300700001)(7416002)(5660300002)(2906002)(6486002)(478600001)(316002)(8676002)(4326008)(6916009)(8936002)(66556008)(66946007)(54906003)(66476007)(966005)(83380400001)(33656002)(36756003)(86362001)(38100700002)(6506007)(6512007)(2616005)(1076003)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YX152iUVHNlS5za5geh0J9os2J+eLmZwp58TNF29tULSqiXhFtnJbZXe3tvr?=
 =?us-ascii?Q?dGdaRU+rEwjlLHCZEq8xUfGvLf2+HVVF3VXQBHhCcPmWtIuyfrD+3/BxmWC2?=
 =?us-ascii?Q?62K+3LCOCD1mKhTfJGMSJ2gh3/H7QEF9kOACFQhg2aGCGKpnKgNrx385M2GK?=
 =?us-ascii?Q?EMSGr8Wlh7joytS/bxO0f6PV72bG5TnWIQRzvI5eYRwRSLxPWj+1JsKDpINL?=
 =?us-ascii?Q?aOw8764UxiXngBfTnBPwCIXkwyKyB38bcd4l6La+a+CcDUP8Q1cCALpayotb?=
 =?us-ascii?Q?XYKW80JS6+AHQzgfK0Fvs4djl+4PEcwGj3Kn6kmLEg0gwwDOOzLy7AZ62bsa?=
 =?us-ascii?Q?bpAWRparQ9/dCtMLMEYPeBnt4Od32nJP1GJHSISZoamOkkypFLnsZoydvdOY?=
 =?us-ascii?Q?80jbOETdndQlRyeWBScA4apZlaCcdSg8/UFWJGnJS05lUSVeWlv42UhaI72g?=
 =?us-ascii?Q?qqp9IymbmQKOXebNnlCiwaqtWRuGbHM82acJpfcHfkdnQYvsO9XAwrbvE6G0?=
 =?us-ascii?Q?eHHtB6l2aT7fMyZMsnZ2qXHxqjjMQprDcpU/Emv1/GtzIOdayp8VGMvAvU3P?=
 =?us-ascii?Q?ct88Wu4yiw3jRCHvQJfy13uwqU4POWK45dElXkie16j6MWnqO9XVzkN/Hk9N?=
 =?us-ascii?Q?8HO7dY6PNm3CjcAgId/jdSXlGLeaM19R4rXUfhHKVuMtm3IUMW/gcEd1ps54?=
 =?us-ascii?Q?tB2lR7TUBnt8dUXGcumVMJ5SiPJE4Q+XsazqbrzvTf6abI+JLrvjEMw3ddyO?=
 =?us-ascii?Q?rRik+wE5DjcsXjHvE+zN4iszR+CuV2uWdBnuNiPS4C5knG3w6tyXSqrnvAWP?=
 =?us-ascii?Q?o4e//i/tkd2ABXcRmfUoBDXPvymI1eGcmdUMgbhxJ5oM4SuCGE8xkYr1YNS/?=
 =?us-ascii?Q?wYeI7eSto1dcWXnipNUI0oL8MgFJ+P+4LDCFI9YiGt2NY26LGRYI7YlRXjPU?=
 =?us-ascii?Q?cwnSrquSqVGO0tVJQJuvneJF8cu5O9gY8+naFzXk9Rau7OwEMSN8WXrDyMnN?=
 =?us-ascii?Q?W+H4/Fk77K5L7iKDmCtm0nnmH2Bg9/tUs69rqLDJoavscK9MM2kR4OEI58XC?=
 =?us-ascii?Q?8anaUbox5a62UGhmkkBZ1CCjVt1yd9RcA0H8GrObF5ogcOujr1+u6jvIXtIF?=
 =?us-ascii?Q?1+RrQR3Y97H0wZcQDnHBOYHKYoq9a1KB6A1SZZCnyXnRI2xOzI/pVOnqadFm?=
 =?us-ascii?Q?cj6Y+bf02tCdHTk0y2WYf2Rnixtzg5KysfxV4JXo09f1YK+S4eEzeMROjzbE?=
 =?us-ascii?Q?E3fn82m1/NnOHesaMf+0Qk1O0eWjuMpoK0iEbkZO4lX48AzT8BQuu40foiT2?=
 =?us-ascii?Q?qYPrzJ9ccyrQTcYg1aoINLMqlkP3GGxyTfy3m+KiUVosJ541S312mTkfst2t?=
 =?us-ascii?Q?tAEZALt1PBPodRabL3pjoroWNUIyDkq8BeetTH4CcdOYgkRFwRU0yO6oPP6a?=
 =?us-ascii?Q?FW/Gea/QLHPBDGKkusvK64u9ZNV3QoYG94xLPYwFdUyfgwuerPst1QDdViSM?=
 =?us-ascii?Q?Db80fXeBVrZt+GmfgCs3AsaqxPrYxnF/ecpRi8PV8P6nWUpNhfW9Y/Phl0Lf?=
 =?us-ascii?Q?fK3xCmaRTzzrupL29MvgPQYkwHSpNJehZaxwkFyK?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 595199a2-2cca-40a9-df8d-08dbdb30b755
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2023 23:17:28.6033
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bw+MmkIjISQcWcYAO8o8XUyBsn8ZSdXarhsG7B0VqQaz/SVk/scCvZTcHL8iZs4Z
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9139

On Wed, Nov 01, 2023 at 11:52:08AM -0700, Jerry Snitselaar wrote:
> On Wed, Nov 01, 2023 at 02:51:02PM -0300, Jason Gunthorpe wrote:
> > Most of the calling code now has error handling that can carry an error
> > code further up the call chain. Keep the exported interface
> > iommu_domain_alloc() returning NULL and reflow the internal code to use
> > ERR_PTR not NULL for domain allocation failure.
> > 
> > Optionally allow drivers to return ERR_PTR from any of the alloc ops. Many
> > of the new ops (user, sva, etc) already return ERR_PTR, so having two
> > rules is confusing and hard on drivers. This fixes a bug in DART that was
> > returning ERR_PTR.
> > 
> > This also fixes a bug in iommu_group_alloc_default_domain() where it
> > returned both NULL and ERR_PTR, now it always returns ERR_PTR.
> > 
> > Fixes: 482feb5c6492 ("iommu/dart: Call apple_dart_finalize_domain() as part of alloc_paging()")
> > Fixes: 1c68cbc64fe6 ("iommu: Add IOMMU_DOMAIN_PLATFORM")
> > Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> > Link: https://lore.kernel.org/linux-iommu/b85e0715-3224-4f45-ad6b-ebb9f08c015d@moroto.mountain/
> > Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> > ---
> >  drivers/iommu/iommu.c | 53 +++++++++++++++++++++++++++++--------------
> >  1 file changed, 36 insertions(+), 17 deletions(-)
> > 
> > diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> > index f17a1113f3d6a3..6bc044d2310487 100644
> > --- a/drivers/iommu/iommu.c
> > +++ b/drivers/iommu/iommu.c
> > @@ -1802,10 +1802,10 @@ iommu_group_alloc_default_domain(struct iommu_group *group, int req_type)
> >  
> >  	/* Otherwise IDENTITY and DMA_FQ defaults will try DMA */
> >  	if (iommu_def_domain_type == IOMMU_DOMAIN_DMA)
> > -		return NULL;
> > +		return ERR_PTR(-ENODEV);
> >  	dom = __iommu_group_alloc_default_domain(group, IOMMU_DOMAIN_DMA);
> >  	if (!dom)
> 
> Should this be if(IS_ERR(dom)) ?

Blah, I think I somehow missed this function:

@@ -1788,7 +1788,7 @@ iommu_group_alloc_default_domain(struct iommu_group *group, int req_type)
         */
        if (ops->default_domain) {
                if (req_type)
-                       return NULL;
+                       return ERR_PTR(-EINVAL);
                return ops->default_domain;
        }
 
@@ -1797,14 +1797,14 @@ iommu_group_alloc_default_domain(struct iommu_group *group, int req_type)
 
        /* The driver gave no guidance on what type to use, try the default */
        dom = __iommu_group_alloc_default_domain(group, iommu_def_domain_type);
-       if (dom)
+       if (!IS_ERR(dom))
                return dom;
 
        /* Otherwise IDENTITY and DMA_FQ defaults will try DMA */
        if (iommu_def_domain_type == IOMMU_DOMAIN_DMA)
-               return ERR_PTR(-ENODEV);
+               return ERR_PTR(-EINVAL);
        dom = __iommu_group_alloc_default_domain(group, IOMMU_DOMAIN_DMA);
-       if (!dom)
+       if (IS_ERR(dom))
                return dom;
 
        pr_warn("Failed to allocate default IOMMU domain of type %u for group %s - Falling back to IOMMU_DOMAIN_DMA",


Thanks! 
Jason
