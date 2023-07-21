Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2060.outbound.protection.outlook.com [40.107.94.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEB4D1D2F6;
	Fri, 21 Jul 2023 12:01:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A4s0zl5xOambAxhcUO8TPuhjtksmzhSIhSYv8gknFKOooZnK7PdWYKN5DTGlsGrJKiqrlQx8Dt7MGkhMjlRn2yHN+IgfXzS2+P8qt0b1WlIkYJPcy2/OscnZhAk930V0/nBJ8w93T+v7yc2dsGtM1B8UNHTz2yAhrvcuTRzGkqzV2Y7zZx/h6b7fvZFGURP/DMv4n1m7SOfOc7J54LMvqMGKcn3H5zkmwW8H9O2xN/4CjW+FLQ4hX5ZZZ7lCklQJrMaKKtVYCfvSvdwoEMlTzL28oYSZ+4Mvvia3ojmSeKVpF2jk6ScqhG9hSyHTQ0yAImjogIedg/8v6HZ5qys1PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HNNocPqmMjutmWLqtR25r2tlXNxi+sn6gTKCvsywkgM=;
 b=KA2XmOiKCAxKfnLHuLMp23zMk4rEHtZp665YqcS/iHBRuwsmI4olqMOE93gRv4yZ634B27j+CdM/a0IsQ80KsvisTaqho5qR7hrMm1jobNN9/4cuGtotH2gajYV/1BNeS5Y0Nq0QnLmGlihB1q7dZY3hAjM+Q2VZm5XZfqhDidsIQnyMey5HYIxqFx6q3Yeca84SI6f+6NkRwXKCwBr/OBeHud/fjBSwDxh5T1u4/9b9KVSrihBebKHEgqFB8S9QFhhscjmaVFgQACDWDeQwoIGTkz0tn0I5B7Bx2a+zjhNhZVpmtHpySBNB+rAzKeOHO/1fBa+TADKXiRFkCAzsNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HNNocPqmMjutmWLqtR25r2tlXNxi+sn6gTKCvsywkgM=;
 b=fcGOvELOCExYMMAjhDFnUMbvFwR3RqwgyPFIFEvz51ijupXe+jwFnNYx+E+/PwteNG+o6N7tGmL8dgOsdOC/WprD31qlvgkNgucf3JRhjaK28IPmDq4K9EWI4kjr21u0rJOIg5501mDdl/MuMD4/xMsaHRldztCRgT7VzHZ5aLmmsbabBj7bT6GqRma44Vfk5EIKYj21+57hhREgmPJrD5R2OrnJZl8V65hjsWBHp7CQ7eSXBKK0Kf0qJ0cht3BvWFX5PHdew3c4k4M2WIGAAzVL/+ABGODAaZFkVHi4SIfE89rd+rrmjeUXtoSK4gPcfGqBTRShVLaioQFYLERiwA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by MN2PR12MB4455.namprd12.prod.outlook.com (2603:10b6:208:265::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Fri, 21 Jul
 2023 12:01:47 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1%6]) with mapi id 15.20.6609.025; Fri, 21 Jul 2023
 12:01:46 +0000
Date: Fri, 21 Jul 2023 09:01:45 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Heiko Stuebner <heiko@sntech.de>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Joerg Roedel <joro@8bytes.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-rockchip@lists.infradead.org" <linux-rockchip@lists.infradead.org>,
	"linux-sunxi@lists.linux.dev" <linux-sunxi@lists.linux.dev>,
	Orson Zhai <orsonzhai@gmail.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Samuel Holland <samuel@sholland.org>, Chen-Yu Tsai <wens@csie.org>,
	Will Deacon <will@kernel.org>, Chunyan Zhang <zhang.lyra@gmail.com>,
	Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH 01/10] iommu: Remove useless group refcounting
Message-ID: <ZLpzqVAxxLGJp+L4@nvidia.com>
References: <0-v1-3c8177327a47+256-iommu_group_locking_jgg@nvidia.com>
 <1-v1-3c8177327a47+256-iommu_group_locking_jgg@nvidia.com>
 <BN9PR11MB5276130E7AE8B0BEA43FCC6C8C3FA@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB5276130E7AE8B0BEA43FCC6C8C3FA@BN9PR11MB5276.namprd11.prod.outlook.com>
X-ClientProxiedBy: YT4PR01CA0072.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:111::26) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|MN2PR12MB4455:EE_
X-MS-Office365-Filtering-Correlation-Id: eb61087c-2441-4431-0db6-08db89e241f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	djFa8w3sVf/NWmOiq9ixuSA3jHl7PKyp0Rgy6o4JYfLyAgYYhz7NtSVvStP2p75Coo6iqiDnWg0cFn/yDrMl3lSGZgCowP/EhgDFk+Uiy+yZ2gqHO4C0aHsyOXYOhY5grkX3Ay+R6jKpZp472+FhcPVBzrni31FrgEkQCz1bYIgv7pts3xBnxqwdO1/d7MvyFoW2Ri8mtM+NXTvQkw39HOhTKdNn43lwTVFgY/U3NusfDMA1DbAsGq+ogkaaR++xkQ6y91NMr46Qczwx7fUPFQf6dw7bU3vTrpIqE9sE2ILJtDrpabHCzmuwlafN97qdAfiRnWLAP12Y+EW2hmWZh6IHq0wYOWebo+0IswwPgIF3rk9OZBVZPo4elsF/q+C4wrrqN1jfYThVviHJIIWmV5lni5Nad2hUI1+qEl56Vmk4G9MTC+RErbJSfrDd+bUgFPxopp28S4rVxy0Rvq95+KpVKpKPslcbg6zAD141lTFZ3G3x+ktmX0kCizyoz/ALZZyscbmfrD18c2sT6X+7BVtaCzzA+AcvcIFRe9KcruN06RVbgdd3tSrskx7Vi81yRynV5w1tphcTMzfBi1LZSIlJPmiDaC/anlXRbibwKg8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(136003)(366004)(39860400002)(396003)(451199021)(6486002)(54906003)(66556008)(478600001)(83380400001)(4744005)(86362001)(2906002)(6506007)(36756003)(2616005)(186003)(316002)(6512007)(5660300002)(26005)(6916009)(8936002)(66476007)(66946007)(41300700001)(38100700002)(7416002)(8676002)(4326008)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hmRBUgYhecq9X5xLwfvqCPwWaWTYjFzd+olkzko+wOyGnvY/EYMj5iUB5ZnE?=
 =?us-ascii?Q?5buR9EjPUz8zOX7DIiLco9F+9hkcqYV87N9+/AJhEiOC/uCIjWyJnW46FoSP?=
 =?us-ascii?Q?STk3rVESEeTKaG/UBBANTWcKygqhA7eD+GY4+Y9ShlA7inIkYv3n2lSIf276?=
 =?us-ascii?Q?cZLmCwIHiAQ+kJOBN1EedQ5bmnZLB3FKcWlO1mHCX622pwvdkqpV75ogOs+T?=
 =?us-ascii?Q?hTmADGHaPTqkd65KjL4qmihJAeG+n2zFhsB5k/xq8EpncOFWM5MnI5UD9ojy?=
 =?us-ascii?Q?6lTMRLfvbyaNqUPr2ZrSrK5PHlWqS4bWq+YqBGMMt/R65Qi2qld4MO/Px+XT?=
 =?us-ascii?Q?N31+DTbObqAKkMvhxJavm1mWUxRRCWWnPPb3hmNuQv2v4lRKS/3OuVmTtUzi?=
 =?us-ascii?Q?KeICoZqOKi74WdbYAtuu4sESh733fWxD5z7/mXTNEZ7I7Y3ozaA08mGLzbUX?=
 =?us-ascii?Q?tnPxUhXr0JCef2dr/xN7EAzpzXwvsC+2eaX08Hm2ucpgB2oUF+xnmJWOpPay?=
 =?us-ascii?Q?dogKVwodECCb841yzzdbD08gQ6PCcA7lgg1+aTlJxBllOvGrVHrpQFSPWIQ7?=
 =?us-ascii?Q?d9thPmVi1zPyqlqNhOFU9JK5JJhyJEO8Vat5kvkxC9VSeyjzyn00igdjOjti?=
 =?us-ascii?Q?Oj9KL0jIecqzFUsB2/whcI7sMc+kIYyBNs3gvR4KbmT8BUd9wm7Nmw0ohf7+?=
 =?us-ascii?Q?SSU4wc5wHuKfYnS1VBvnXZtkCgYc0iht+BupyXIIJvvedvHU7ZWzjFoZ5ccg?=
 =?us-ascii?Q?Z1ZxPWP2PqkmP/wPXQvTRwywM8gcy2uiaAN9DADToYTK+tcSjA9cco79ZEkC?=
 =?us-ascii?Q?rXCuUNhgXQxUPhS733NEVNNzh13SR0UtbLPxRvfQqd+JHVFDa6Ri8ydlytd0?=
 =?us-ascii?Q?1ssG4YTS4765IzcbaOmvdGXrR0fIhNY+KqNVUB3SPJeEOG0MFt20t3XKmhcf?=
 =?us-ascii?Q?CkiuBJF2QHUyBYhHaNz8VVaI4vjKOJohpBaVLzE6vD12OoavBjrdalPmOoOl?=
 =?us-ascii?Q?G0wR9TYUuye/2xsS2Ka3eAgiGRCcGgC0bzrO5CetbauEywJ5c/OE3fd//EDK?=
 =?us-ascii?Q?J4mNcnL+/tL45zYBjnQNmiltxhEyN11XuS0Y+iF4gvnhxK5exaY3cIHCPQQZ?=
 =?us-ascii?Q?opa1eGkFTloZw7bPaGCbEK7UETuVyMpNUuwGMb/VgHNYVT4Kt6tB3qIqMq8T?=
 =?us-ascii?Q?SaeuLEzvwPYQMFs4STPijjcQ8NFSgsggba2etL6JuzaLiOuUIzkHtk3defv3?=
 =?us-ascii?Q?ggKDLg3dxGg7LfedCewGj0nJSGHm/2VyxYVCyG4b2i5+6Fa6cDNcWH/d+TKh?=
 =?us-ascii?Q?lBvXe+EHTA4GvIfEvBYqCkpxels449kNZ66SCAaBxLl0Y/0nl2jtiyA6KmGS?=
 =?us-ascii?Q?PLGfCwcYH8tXXs/MuhCU1LNHEFnAUokj2rSDbznwJnSZ1X38BFFwaftD07qQ?=
 =?us-ascii?Q?MA5R+MrFAoWpVZgjq0vzEk9Ze9TxNzITmbcop0KiIMGxxVAYeU/bJj0cdeU3?=
 =?us-ascii?Q?ndwFUxjxCCIB1A8EDB7b/uL+WrLfodlgZKVxwNgFjzsJZtbTo+aKDw5fCT68?=
 =?us-ascii?Q?JNU7Pi4Y5PbudSxSqUjoWcDel2TAj1rf6NC7PYEd?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb61087c-2441-4431-0db6-08db89e241f3
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2023 12:01:46.6970
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8mhGHkFxzoXXsIif/hQU4aWPjfqM5vQ+Sm8uwnpon6bYK9by/zoVAJc3+cOs1QWL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4455

On Fri, Jul 21, 2023 at 07:10:57AM +0000, Tian, Kevin wrote:
> > From: Jason Gunthorpe <jgg@nvidia.com>
> > Sent: Wednesday, July 19, 2023 3:06 AM
> >
> >  int iommu_device_use_default_domain(struct device *dev)
> >  {
> > -	struct iommu_group *group = iommu_group_get(dev);
> > +	/* Caller must be a probed driver on dev */
> > +	struct iommu_group *group = dev->iommu_group;
> >  	int ret = 0;
> 
> this is called in the probing path by .dma_configure().
> 
> the driver hasn't been probed yet hence the rationale to not
> refcount is due to device_lock() instead?

At this point the driver core has partially attached/detached a driver
so I'm considering it part of the probed driver explanation.

Really during anything protected by the driver core probe path is
assured that the group cannot change.

Jason
