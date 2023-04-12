Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2049.outbound.protection.outlook.com [40.107.96.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3940D2CA5
	for <iommu@lists.linux.dev>; Wed, 12 Apr 2023 22:40:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JrCBJY1YIj9TvHjTnfXhw/cj1NQ6VLoNl3HYWqc5UWnzgiDX2B/ud0DZovqeHcBz3xZbWGaGYg1EY7SEPRnmwnH1qfPXLaFQHSwydjNzncNDP3LABM3UgczNyDgrfL01l+p/eobp5WwBi+I8WevcjCOFohPIFC0lVNkahmMKoC3GUTMY7ZlENDoKcZ2xGCe53zBUQc0zP1WKltu1vwRxAaChapf8wC4g0HOhRz+protQZot2uF/fFCGTZjHv45j8wv3MPZXZO/HNrB0Ul6n2ilAqPyMj8w6i/8F1gYH+gZXS2QvH0TS0fttNp88i1iZFg8j6aTU96mxsQFFu6PFIQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1FarQ7zko2Xw9qRK4SC4Akwi1r3j28cTKnoB9Sn9fHg=;
 b=ludn/76pIpjg4w3kM+bUC3yahy3NfBk6Ba9pEhaUJXPKdF80VDTQ7jcQHG7IDywO2B2f8uC66rFPvkTAfP8Wc7RXQUvKFwJBlywuZ12l3HynTdRLdzexXL21lJannfIbtOrIK5eisxQB6Y6QR0KLPSV4Xq37zSNuRFAJjjFr9yWxjszXeJGXoo75zqZUnyRgPoqWBXS5nF+IwcDHynJcl+sOR2HBCUNAtLoo8pT7H9jVL6uxLcpqFsLMwBnG9bL6eKFeQyhovZHtjeVVH8ps2mv5l3YaJkQ1/KOmOKTFLVkRzOVtKm+lJRa10cc//UCBx63ApZfJsy20OxXzKl0ySw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1FarQ7zko2Xw9qRK4SC4Akwi1r3j28cTKnoB9Sn9fHg=;
 b=Op7cTrD3YGdyL2F6bQgbYjXaxlZ1A/yceuaVx4MIvofECkVpPNEUr4leHYPo2EoPhmRI/kHtxyskvKPH6c/WMBd+copIGgzGgu6X1iuZcFyM8NnkNxYREyvAdog+zcZ9lntKFHptpSZUfBcITX1q0R6aQmCCSYMc4UysN//tzsDDR6Na+VtpTpIxfg/W05Dd+hf8d1JdWfgrFyJwLb7MHVRmX0oLsFZsOAWuo5NHiY+F5tEGOQibf9WNZ7QJmHVoxzKWPxO6gQiqppQDMBUX3GdfrbCj/vvuID6WLRgmT8yJUa5Er+zF5tJIHfd2IQfWWzjPL4IZy3kKOcpb4aa2Tg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CH3PR12MB8753.namprd12.prod.outlook.com (2603:10b6:610:178::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.38; Wed, 12 Apr
 2023 22:40:52 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::6045:ad97:10b7:62a2]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::6045:ad97:10b7:62a2%9]) with mapi id 15.20.6277.038; Wed, 12 Apr 2023
 22:40:52 +0000
Date: Wed, 12 Apr 2023 19:40:49 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Robin Murphy <robin.murphy@arm.com>,
	Steven Price <steven.price@arm.com>, iommu@lists.linux.dev,
	linux-samsung-soc@vger.kernel.org, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	lim Akhtar <alim.akhtar@samsung.com>,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH] iommu/exynos: add missing set_platform_dma_ops callback
Message-ID: <ZDczca117FRQn26A@nvidia.com>
References: <CGME20230123093116eucas1p19b8fe8afc4b631debbdc5321c53009e9@eucas1p1.samsung.com>
 <20230123093102.12392-1-m.szyprowski@samsung.com>
 <Y871a3elCP1gmPQi@ziepe.ca>
 <e7aa3a5d-c8f9-ad7d-4c5c-08756c1ab2d3@samsung.com>
 <Y+90rkPHe/+eSLs6@ziepe.ca>
 <9a12fcac-c347-5d81-acef-1124c50d0c37@arm.com>
 <ZC9Xzvakhepn0liX@nvidia.com>
 <4fc0adda-2468-1db6-4ff3-1a48d8637615@samsung.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4fc0adda-2468-1db6-4ff3-1a48d8637615@samsung.com>
X-ClientProxiedBy: SJ0PR03CA0030.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::35) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CH3PR12MB8753:EE_
X-MS-Office365-Filtering-Correlation-Id: 931abd72-b03b-4851-2f3d-08db3ba6f838
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	xNQwlRZAPfTdxG2Y1IdCzY5h0oaZKVA/Fv3AIzGJ0a3WnBZhEaaLWLNL0+dJfr7HQ/cKH76qYekr/VZ/RzwQT9xJBTCUtgZY7OE3/QRo/szedUh3HxFP1tCyrJ+hsyhqp3mhnXES8MEJVB/s7SGKkFL79liFghR+8Y0tc9zmFegBzraFIP74OzVmxA8pjgYu+6p82qkyc2dvtJoQONl7uwUCvYIC1gvFJnVUHam42TZTtRIpBWQA2bF7rsBmaVpyKa+dUdvd7DoqrVdv4bbm/t9CieL+hwVnDfmeHnD2z1IGFYTc5Z40hiW9rJJmDIuu17kB/+C4VsQ+oQlZxdAYzXvSM2SQ116Lkuw2Vrn3tMwmyseTafugELMHdYFXV0FpEE5hRggKYniuOZt1DMFy2mNVU3XhiyFcN5sdTqDuMkef+puH/Mlu2qOrl2/L5G3iEpZa1u5mTJZApEMuGn1KB4K2b1Sa2xefEi1mDsEs7BZ+nGC7bTE0TzSNybJhuDyGnObsYgzRrvPEvG7cG/a9NZWILVKVs30z3qjcpRL7UxiOfDUUbQTthS3FzNYgXOpV
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(396003)(346002)(376002)(39860400002)(136003)(451199021)(86362001)(53546011)(478600001)(26005)(54906003)(6512007)(186003)(6506007)(8676002)(8936002)(316002)(41300700001)(6916009)(66946007)(66476007)(66556008)(4326008)(6486002)(36756003)(6666004)(2616005)(38100700002)(7416002)(83380400001)(2906002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XRAp0gmsCojtnu4X7BFpKoPRYtpsQnOnhPqR6zB82ZkUwCHMGgJdityxlv+9?=
 =?us-ascii?Q?Vk+LlBs3RLvQD6QXHE/Hx59uBQiEhZgfLKAHU/L3Em1UFZ0MuSOVnUW1u65y?=
 =?us-ascii?Q?Uakd5K5IZ+j+842XJaD0jljgGbNv5nJ4mrjn2OLTax1Mif/rd5bjoEPbo5HD?=
 =?us-ascii?Q?mjzGB2LMB9lNoRpQBwTkg5luDArlpqQpVDgNE0dhWU0CVHxaGddq90reQFys?=
 =?us-ascii?Q?varLHnbqWLYTsesZKV+yD13lb/YJ4J2hBbZMIC0wGkD/xwRxnBpq1oqzr9UJ?=
 =?us-ascii?Q?HTw1+rXudrvp/9aZKROxHNBuahsbq8V4TjN3JBp7hhv2+bE8xtCt02Q62w14?=
 =?us-ascii?Q?KuIu5LyNsEvXieqGeK2wWW9jjcx+9N3b1rwAhAv0UYJ0BPHO+X+P/YtAwDZr?=
 =?us-ascii?Q?PirNBlx0IuseXR7dgKjjy1hRFEbOM4AyB5GZxEHqvJT0qirVfa0rymMHlBDo?=
 =?us-ascii?Q?t1WSz1KCgX0pqvbqnMLWwtLBP7MLZWUjIt1jYmS6mbNDqjBHpiUbp2gJFtiU?=
 =?us-ascii?Q?4Qp1HrL6n3YW4JBLhgPRGFXmnGFsbLns6jx1mtF4LpGKAkNxLKxyJewR/Z/O?=
 =?us-ascii?Q?LZ/YNeTObsSniF+TULUUnGZRvJRJz+unfZsf64MPsfdYyX/0Wbps7/BaPzmJ?=
 =?us-ascii?Q?SHQw+6RLT+nPCQ69Qg6RlGdqKKsPCtCha6WWhDTk/TjOKYl1P472Nr6rh8TI?=
 =?us-ascii?Q?sQ7LSt11xrsWpQJiA0xV889bxUJ6Uub3ZDYUDz1o6oi2snTvEbKghM0UtBIr?=
 =?us-ascii?Q?nO51DDMmOCOLfip7edajUQaCoRne+jEyt+vV8TdYGIPtK5vl0sTVybKLRHfl?=
 =?us-ascii?Q?lT9uxZCUC3BarEMlmfHdS885Qx+kx99DsVOMvm+SbrC9M8IK7WHh/GIa9IIs?=
 =?us-ascii?Q?thHymSaSRBB1j2Wp17k67PpeEKpJ1fT4FPK/ZMQs9dErUnQ0HGEgRRCaGCGT?=
 =?us-ascii?Q?kjjQyG8zQdjvS06wz/MPJhERRfH7is/SYVspgiLla5BG4iD1xWn+UR4pTYbu?=
 =?us-ascii?Q?I/UisMj45TaebESJMmC97mSugowFC/gk5eshekMUlKcl4wPhaJmfn78irB0h?=
 =?us-ascii?Q?4gTa/okObKkMDmJnnTLiFIQXuqxHpqlMovQh8XlvtktEzuSpkhrb2M4G76Ya?=
 =?us-ascii?Q?XIumIZfCN/w3EDbI9/PQ8RHW4ftZcP48aJBhGO6fbmgUSmqXJdYDCGbpOytS?=
 =?us-ascii?Q?yODZSGa5BllnBjpqE5sex6WVXGSaBKNCCQa8fmcjgmMmErWoW/BowJRbg0d8?=
 =?us-ascii?Q?xmcapgfdzhBlJnymiO2dMyXliBrygH7CMRei3l1vsKrwb1PYvXiZCEqYAwj5?=
 =?us-ascii?Q?4Dy2RUEk1d6Yb0DUwasY5+QhrAqe+H09cnXn8sZp3EJGFArZtTjUxvjUhnus?=
 =?us-ascii?Q?doZ0hyUWPC1zGZexqb+keQv2eR3G/cdVItYg/LjIVw6gRQtaQZiJQtRl9RCk?=
 =?us-ascii?Q?w62GpH0MXesOT6HTUHNR8nFpTewryIm3KLgNQnW5s8Nk8TbXcdwD/3BR2ZSV?=
 =?us-ascii?Q?fQ/7Cn34vDg+WGoOJ7S81/MndoB2FtfE2hF6gS2qsyAh2Lppr+/M4KfmHIOW?=
 =?us-ascii?Q?yPDqUNXzptlFRHbWHVT/jgJmsua6Mt+hLcM/hsQQ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 931abd72-b03b-4851-2f3d-08db3ba6f838
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2023 22:40:51.9607
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vJJVSaf3Cj889dV7XVoGYuBKq4AAG7KthajCHl+M1M7u+ezykn10ip8nbL25fvSm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8753

On Thu, Apr 13, 2023 at 12:03:55AM +0200, Marek Szyprowski wrote:
> On 07.04.2023 01:37, Jason Gunthorpe wrote:
> > On Mon, Feb 20, 2023 at 01:58:40PM +0000, Robin Murphy wrote:
> >> On 2023-02-17 12:35, Jason Gunthorpe wrote:
> >>> On Fri, Feb 17, 2023 at 12:08:42PM +0100, Marek Szyprowski wrote:
> >>>> I'm sorry for a delay in replying, but I was busy with other stuff.
> >>>>
> >>>> On 23.01.2023 22:00, Jason Gunthorpe wrote:
> >>>>> On Mon, Jan 23, 2023 at 10:31:01AM +0100, Marek Szyprowski wrote:
> >>>>>> Add set_platform_dma_ops() required for proper driver operation on ARM
> >>>>>> 32bit arch after recent changes in the IOMMU framework (detach ops
> >>>>>> removal).
> >>>>> Thanks for looking into this!
> >>>>>
> >>>>> Can you explain more about how this actually solves the problem in the
> >>>>> commit message? I don't get it.
> >>>> Exynos DRM driver calls arm_iommu_detach_device(), then
> >>>> arm_iommu_attach_device() with a difrent 'mapping', see
> >>>> drivers/gpu/drm/exynos/exynos_drm_dma.c Lack of set_platform_dma_ops
> >>>> leads to a warning in iommu_group_do_set_platform_dma(). The other case
> >>>> of calling arm_iommu_detach_device() is after unsuccessful probe of the
> >>>> platform device.
> >>> Why can't this just use the normal iommu path in all cases?
> >>>
> >>> It looks like it is trying to copy the DMA API domain from a parent
> >>> device to a sub device.
> >>>
> >>> Even when using arm_iommu an iommu_domain is still present, so the
> >>> copy code should work?
> >> The ARM DMA domain is a regular unmanaged domain owned by the ARM DMA code -
> >> in order to use any *other* domain, a user has to detach from that first
> >> (wrapped up in arm_iommu_detach_device() which also swizzles the DMA ops at
> >> the same time). Without set_platform_dma, that detach is now impossible
> >> (because no IOMMU API default domain exists either).
> > I was looking at this again, and for completeness, the reason it
> > doesn't have a default_domain is a bit subtle.
> >
> > The driver does support IOMMU_DOMAIN_DMA, and it will go through all
> > the iommu_group_alloc_default_domain() stuff with that..
> >
> > But... __iommu_domain_alloc() calls iommu_get_dma_cookie() which will
> > be wired to fail on ARM32, so the core code nixes the IOMMU_DOMAIN_DMA
> > after the driver successfully created it.
> >
> > I wonder if that is actually what we want? As it seems like it would
> > be OK for ARM32 to have, effectively, a permanently empty unmanaged
> > domain as the default_domain?
> >
> > If instead of failing due to iommu_get_dma_cookie() we set the type to
> > UNMANAGED and make that the default domain it could fix all of this,
> > even for all the other ARM32 drivers that haven't reported this yet?
> >
> > Alternatively since we taught these drivers to support IDENTITY, we
> > should be able to remove the set_platform_dma_ops and instead
> > implement for ARM32 def_domain_type fixed to return IDENTITY?
> 
> Maybe it would be easier to simply switch ARM32 to generic IOMMU-DMA layer?

It is the long term goal, yes

In the short term it would be nice if we could at least keep the hacks
out of the drivers

Jason
