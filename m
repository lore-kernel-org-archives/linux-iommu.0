Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2084.outbound.protection.outlook.com [40.107.212.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 314FF111A1
	for <iommu@lists.linux.dev>; Wed, 17 May 2023 16:20:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EZwwanfYPsRO97JQ8x7si1IUNSrTV2QlhN5ATSpanYTd/YbZt9cn1CW8Q9fn74C8t3MmCyci9SGWpP7pqPflHGcVqrN3y/VN5CTaE1i7Q8oGP5qCT8WsJiyHtbEL//a2jHRtFO1QHriwU7DY6fWRwPcTmDmuZhjOBSnJOe9s9R9sYLKHWhsHvImFMGW1o0AKGtiY5BmF0B5CBb8PQOrat9MHCaeDq/2C5n0pIqF3o1n/2NZ9DjI84sBEuOxmm2QJpXCKC28DimjbCtFzZzsB8o0/U7BQn0MNVDa5AHOqKR9HX3WW0wbr47TFpZL7rLEApRtEfZA1HkIVQ6FjtPKlzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OYQmYJCf7F/lJIdvsnNvtWC9AwvQJ82iYEH5BMDT3wU=;
 b=jfGJc4KdJea0cllTP+NoM1sjvq2nVsLunpgmQ2ocBO2Obqe2Mybu0RaxllY+ZF+m7ZneFhSW/9wyYspg6OJZyta1E+4aYCFvZhKi01HGxIBIlCkYzXzJ3eL2YBBwt02Ukj8izqCn3FB4wo5Nf5kqDevAP3eO3FyobH3MYmxZm3GpUfkQxj4rGOaimNpsrwMw0zGq2Y+WT0upW6xo99ge8PhQVvm8LGo9t8pVZVXT1kA/qHKaNJW4icFiYSos9XAOxReNGwcCIn6BVncXXGLUh7VeAkczhVUBfNpMMqFh1EKFO2653Dt1mnMeokwhmAIOieBK9Jr1/gRMPGLnMz2aAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OYQmYJCf7F/lJIdvsnNvtWC9AwvQJ82iYEH5BMDT3wU=;
 b=aWbfoTIUkewwjDzzU8OvhHMplv19lDl1P5aI4k/3VTvjgYo+ptlyxnvLxudVdfvXQVzcV/Ty2rvoxVQkC8Wtgq1q5BfX/TcJ7YTpodBI/mwDhEFY2arfyOmOz9NPzG9V0nXQ2oEkvwR3EuUuRvYJTPEgAy50mYXujZGn17ObGgaZOTe7E8/K1mz+x7g5r2Hjd/HziSyfr4c7a0ZM90tQdbFnChCqpA+lsf3ETDA9xIMV4SwBZVPMmViMLlkAQUEYRPVI2F6vZOjBpe05FmEW9HBwzkbe/IzX2QP0ibL6XEd23HFnw07Pe/hQnQ+nLozmrZ0/vuT1fH/QBVL1NpbQpg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM6PR12MB5520.namprd12.prod.outlook.com (2603:10b6:5:208::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.33; Wed, 17 May
 2023 16:20:52 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab%6]) with mapi id 15.20.6411.017; Wed, 17 May 2023
 16:20:52 +0000
Date: Wed, 17 May 2023 13:20:51 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc: joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
	eric.auger@redhat.com, virtualization@lists.linux-foundation.org,
	iommu@lists.linux.dev, akihiko.odaki@daynix.com
Subject: Re: [PATCH] iommu/virtio: Detach domain on endpoint release
Message-ID: <ZGT+44a6RYZ999kz@nvidia.com>
References: <20230414150744.562456-1-jean-philippe@linaro.org>
 <20230510081157.GA3326511@myrica>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230510081157.GA3326511@myrica>
X-ClientProxiedBy: BLAPR03CA0107.namprd03.prod.outlook.com
 (2603:10b6:208:32a::22) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM6PR12MB5520:EE_
X-MS-Office365-Filtering-Correlation-Id: d97bb659-6bd0-44f9-30ff-08db56f2af2e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ynz+Jnzm26vGy2tz6XKabyiUi91xbxB2awOCO4b820lrI7gtRcDS8oSUDApqhkCbARctY67MEXkvq811tZm42I8S74kLwkvcYoRHP9RfqNL0erBsnmrAasgUx2WPLBhKD6XtpzKF7SbbX2rOcAnXejR+k7QrDnl/Sbm9NSnYM4500mmD+bT2zxrExjm39Z3p6TzQyjjtZknt+fYEXXNiW1CV0TRltT/cEkcsFyqADjj8SlVcIP/InsdSRvqOAOk9244+vPERJFZ7EIF8kwiHl+IX/l0Hi8D0KsUOSwHIN2wpes1KwufzJYaFzE1MstD7ZMPcYRCgbHroBCm8VyGtwBBAoz0XTDTiW9/gdgwKWWvI1OXQBakrZCeIuI2TuOKqq1ZRMA/jVadH3btdQbWh2QRslyJxa9miTl22veutbsf3Qn1t7xzGaHibsBPU4eRf/rBNghUqpfmZH0ZHGtT/1rltdjn5pelg8H8v4l2KPG15QwLyx4GdoA+UbQteYsling/XpPW4EsFtruTsTPs91p2S6iDc3rUf0wRbEmVMUeMchLr8gpa1NYzqJZvR7OLH4EqMyAgRSLm9sgKAL8q06jFamnFiHzAyxy4I+42AL0Y=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(346002)(366004)(396003)(39860400002)(451199021)(66946007)(4326008)(6916009)(66476007)(5660300002)(66556008)(8676002)(8936002)(478600001)(2906002)(6486002)(41300700001)(316002)(6506007)(26005)(6512007)(36756003)(186003)(83380400001)(2616005)(86362001)(38100700002)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YAHi7+/r3wND1HkTGuM7QMStVqXPYeSLcY0RaWG+ljuZWbopIG8B9p6ohEFg?=
 =?us-ascii?Q?4ikdRYEyu+JnIfhrZlad7CJxKJMjSnMscaUG7dX81RDuoXL1X5dmiJ+SxliK?=
 =?us-ascii?Q?Ri2M15/Bqabk2t14Kncjbg38TArE4731sX06vfXpF+EzdA4DW58aQoPJidjy?=
 =?us-ascii?Q?BsWMbGv8assrSDHjGzuo/eMY9Lp05d0Ojw/C0uTVk0p9J1wu3jq/E8wcZWq1?=
 =?us-ascii?Q?5+IouD28/j5APc35r/hB9ABEgI+WDgRfscfNfG4/e+diVVJHtb/ZF6X8ZJnm?=
 =?us-ascii?Q?D42neAlrFq5agUL76eli4ubf//N/9v3pOoJLib9q93PG7vHTbdtu41XKlFYB?=
 =?us-ascii?Q?Kdjuy6Wpq8+8FpnQ4g1ish7a7wva7ABc9tRZA4kZzXtfu1I7r5Ho7nL7me2e?=
 =?us-ascii?Q?TIDlNscMihyaMpcD39xNqxyBE1pwyPxj4jjF4XSn+PW8kT9A7bn2YxyU5Tbe?=
 =?us-ascii?Q?FIoES1PsFsi72x5Box9cItqOmxRkcFaGfFjI9juHig7EggOw2An8/i9DWW2F?=
 =?us-ascii?Q?42HlKWjZaw+twmIvk6k8xoSw57hBNuFfmWHNVDeNtWYEk0XJMrDodW4uenWA?=
 =?us-ascii?Q?Bd4IcNr8ZVh9syH+ZjMLRoR6PrUtrKfHk5wt4QPnxbSLKBISnjs6x4tqQ3Cr?=
 =?us-ascii?Q?0HLYy4gSzyQYtdfNxvQHNSK02lOUCapKAXChnDVbpVp53RjxxSmECGE5XKAw?=
 =?us-ascii?Q?JhxHVDzmXN2zgPbRPgY5pyaD1mng0y2wlthWyP7oKHnZJWZBNfxAcT1ma7dq?=
 =?us-ascii?Q?jfIYxEBXWK/rh7PFLZ6bYNHhzItpPqCtsn+rj0juAsi8G0lASHIcDyAJ1w/Y?=
 =?us-ascii?Q?HiXBhFgK7qX1Hf92ePJ9m3xvOYUPOTbiPbiJkO5gd4+PpI+/UVmFrYQ2hFJ1?=
 =?us-ascii?Q?i+skPIG3HHm3blk6wW9N7mn0dKtZWL1JAoCxlRM/cCw+fd/ABJZWzJURo4pL?=
 =?us-ascii?Q?Nngsw0mOb1AzS3JyRemSvGom2IVitQINK5itPs9gHmhz+ld1t+PZ+nhtbgt9?=
 =?us-ascii?Q?MMOla8msWPxm83Hx6+M1jUtYvii8A4HWHDeAUcggyU1+wxfkrV2rWhqF9n29?=
 =?us-ascii?Q?4dUZoiZQh5OMKHc1LGmYydQhAkYwqdbF2QKXtf4J0RA/fyN0tWcEshCyDAnx?=
 =?us-ascii?Q?whplYGmVPuylCQcaRHhEyvolLgm4Ox15tEAFJlaxgVq87f9Q/aVBzSl3o+nY?=
 =?us-ascii?Q?XKyKkZ7ua5Vcpm/qH5KvVEvZ8xWhq2T6OvI7wAVJ9dklcJO1pWC4XULb4Xh2?=
 =?us-ascii?Q?ipXU5sMMyaeKt1dYPYp+lj++umPnTEtPc1bnhJOoneptJ6DPlTikP8raDvCn?=
 =?us-ascii?Q?Qvi/npRXdbkExYBodHVoB8HqFs19vKu2GPra+Yyt3iwkNl3Q1g4GWk+5o9KT?=
 =?us-ascii?Q?wC4JAbZ9t+9l6oy4SIyF/t2WgKskdRgZnfm1hRo7oOGjfk4yLTVO18srnPfl?=
 =?us-ascii?Q?iFaJHadNwJvE8DX2J9t63N9he5M9+KWulLbgCKfM5HSjKD3H4279C1jXsfRq?=
 =?us-ascii?Q?oIfMrvpuhrSodUtfSGvCY3GLK+18E4xxJS9sy5sY4uW2ZNoW6v1E2acz+ScE?=
 =?us-ascii?Q?nfnb+AM2ZG+9Frscxm3JDE+a8CPZwDHy5adEUbE3?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d97bb659-6bd0-44f9-30ff-08db56f2af2e
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2023 16:20:52.5773
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I8uaqoZz5J7x18x0GQeI+4OQ+c3saft76jIcG0wV4LL6kZpnV5A666N4Pn3Ioown
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB5520

On Wed, May 10, 2023 at 09:11:57AM +0100, Jean-Philippe Brucker wrote:

> > diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
> > index 5b8fe9bfa9a5..3d3d4462359e 100644
> > --- a/drivers/iommu/virtio-iommu.c
> > +++ b/drivers/iommu/virtio-iommu.c
> > @@ -788,6 +788,28 @@ static int viommu_attach_dev(struct iommu_domain *domain, struct device *dev)
> >  	return 0;
> >  }
> >  
> > +static void viommu_detach_dev(struct viommu_endpoint *vdev)
> > +{
> > +	int i;
> > +	struct virtio_iommu_req_detach req;
> > +	struct viommu_domain *vdomain = vdev->vdomain;
> > +	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(vdev->dev);
> > +
> > +	if (!vdomain)
> > +		return;
> > +
> > +	req = (struct virtio_iommu_req_detach) {
> > +		.head.type	= VIRTIO_IOMMU_T_DETACH,
> > +		.domain		= cpu_to_le32(vdomain->id),
> > +	};
> > +
> > +	for (i = 0; i < fwspec->num_ids; i++) {
> > +		req.endpoint = cpu_to_le32(fwspec->ids[i]);
> > +		WARN_ON(viommu_send_req_sync(vdev->viommu, &req, sizeof(req)));
> > +	}
> > +	vdev->vdomain = NULL;

Not for this patch, but something to work on..

I assume detach disconnects the container on the VFIO side and puts it
into a BLOCKED state?

Can you wrapper this into a BLOCKED domain like we are moving drivers
toward, and then attach the blocked domain instead of introducing this
special case?

I've been thinking about having some core code support to do fairly
common pattern of 'parking' the iommu at some well defined translation
mode, BLOCKED in this case.

Thanks,
Jason
