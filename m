Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2040.outbound.protection.outlook.com [40.107.92.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5310E28F5;
	Thu, 20 Apr 2023 14:59:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ebKi9ySmB6Ufzzc9I66tvsRmEvufqiTvlWDmciZo+Ks/GRL2XTy+AXzqJkxQvhL4YNQ0PvMYkwDwzgPYLDtHtpnyAP/gah+6UKutQyP9SZf6NouTlJztJ12iRhuI6myThK8IUGZhhfmcSHLahAzqp2ZHKCu4vsy+Y87QjAKcNt2um0qW5Cyrup4EzXWTrmW3YmVHGvFpFDPfpx0/D4cxb8wbEUx1uL+SXRD3w0p1zHWuJoiSdoDAzMNFKXaXG/E1X5p+zIpdfEEcwrQbPncxaWbOf3dG8XAdiaMIav78H612BPJ9l/beDi2A0PdQBr3a+stcNstXmMqnJeNUrizIJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=juYG+7WgJd8rvCJHWlmnLDhqujFlJCakYkGBgSkQOWo=;
 b=hvwYw68OYzUINq7daJOFd9nHJMSC4bXjc5qIfhpQ/kgTz6MD9v7Hy6FEdtpNge6hgO7pKRg8xroPZSh+/qYpU32ErMn+9Che9hUKErHiXwyYK8ak7Anqhvrm18PhgvSAjqDeyh3Ic6f1Ytk9drTMAWHdDA6nTywUP6tXGt0felBiYF2PBLVsEiS+/LfxzuT4GZS+ahCS+IusPr/gFKePyybnL/JWB/3zlYazkcr16HZ7zdc+bkSSJJTbNDCxQV5N8x6JuQ6iWt/r5Q1I/IBtqHMOKMzRGKq83QIzGTJqP/a08eUu0oRduH/DFByNnZkwofWoBNlT4sdpqd0EL+T0dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=juYG+7WgJd8rvCJHWlmnLDhqujFlJCakYkGBgSkQOWo=;
 b=iPsHNfb3bdU5a1it5Lsq/G1nxO4X07mE1nfdlGBD77HyZimjudl3+xy1ChRIOYSSyjXwg8O0NDyNEIT158Vfqm0B2UPZYJOSSQ4rbJV283ANCS7Lwp2Oyp8g0vbuYfa2BSCSklsaktEFWyb49bLS+44qQiuCABzQi8t3+GzHnvr0POtZHzD0uqjR2Oa6VzsfCeA2mbRsaYvVmhOjAintK507lOIcz6738OyYntOfZHhMbQTg4OmA7oR9t2qY5JkU3IjQT8dgzzaXjUks9LouZb8qG/WA9YIML9zSxeAeR6jp7mppEe/poNcfSCjf1iyfvahdZp1TK0kbmDdGv1jjZQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DS7PR12MB6333.namprd12.prod.outlook.com (2603:10b6:8:96::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.45; Thu, 20 Apr
 2023 14:59:53 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab%6]) with mapi id 15.20.6319.020; Thu, 20 Apr 2023
 14:59:53 +0000
Date: Thu, 20 Apr 2023 10:01:09 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	Joerg Roedel <joro@8bytes.org>,
	"llvm@lists.linux.dev" <llvm@lists.linux.dev>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, "Rix, Tom" <trix@redhat.com>,
	Will Deacon <will@kernel.org>, Lu Baolu <baolu.lu@linux.intel.com>,
	Nicolin Chen <nicolinc@nvidia.com>
Subject: Re: [PATCH v4 16/17] iommu: Remove __iommu_group_for_each_dev()
Message-ID: <ZEE3lQOfQPE6mDk8@nvidia.com>
References: <0-v4-79d0c229580a+650-iommu_err_unwind_jgg@nvidia.com>
 <16-v4-79d0c229580a+650-iommu_err_unwind_jgg@nvidia.com>
 <BL1PR11MB5271BBE89526DA4E3DBEEF2F8C639@BL1PR11MB5271.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BL1PR11MB5271BBE89526DA4E3DBEEF2F8C639@BL1PR11MB5271.namprd11.prod.outlook.com>
X-ClientProxiedBy: MN2PR03CA0009.namprd03.prod.outlook.com
 (2603:10b6:208:23a::14) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DS7PR12MB6333:EE_
X-MS-Office365-Filtering-Correlation-Id: 5cc35003-776b-4acb-4f21-08db41afe57b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	7MG37Lvm40e1EZenxF9sQj0BGK0Ye0mJSQ1eYDKFJ7FhhRI7iwAV7doKMiqqACyGNrxojJgLlyM8Fg0tATmBpgMrUd3VOwPu9HI8PYkZxx5DDBx0FnWEVxBWwZMx+5xBElQverGAEbTAIMeiFB3ty8sVykwjI/g6b8qNbOUdcPHlovde8S8DMqWvN4AtVu1uot6lQN/2e1QpluBnueqjLFfblzASDyqGF4b+OyR9zmEISgTnZwbSZ3hHm+lriVlhvEo1IBYqJw1B1r89g1Q0s/6zvg/i+GCilT/GiZdO2pdoo5FEx07v7+sVf4IwL17l0EPgyz9yekGm3/iJBQavJ2IAZz9n8Rcd+kGs8+uIz4LaHIIJskqNVg1qnGnCFKOIvt8Ylp3CkaEuIjPiwTweSjpifVSVcsBRQQuy6zSTA9CUoaHJv4Cdm7okOIo8DkWGX1pK9cyrL7KWHpeCU9irr8VicVfhf63s3RcYFz25FGhvrFU7ohj/CDe2A3vOf2vuYG5znmaDIgZToBJqLFXUa5xFX2GeQiBz4N0bxTZiifsd0eI1n2Eons6ra4llC650
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(136003)(346002)(39860400002)(366004)(451199021)(36756003)(4326008)(54906003)(6916009)(316002)(66556008)(66476007)(66946007)(41300700001)(6486002)(478600001)(6666004)(5660300002)(8676002)(8936002)(4744005)(7416002)(2906002)(86362001)(38100700002)(2616005)(6506007)(107886003)(26005)(83380400001)(186003)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ngBB1fO/ltak5evqhR2AQge97I/6hFRjMMDM/OGGGjoTDAsXRLRyPbFR+rse?=
 =?us-ascii?Q?LFC89N0XtMH4zt683eZOISPD+f10MxCUEdPSzWz7EXTXyU3zUiBB82PFdEWm?=
 =?us-ascii?Q?kl8XPXnRQMnRK1Yg4DTWKk2O3DsqBjmEEGZWODmaR7fYbsOfKFW/HTBVoyhF?=
 =?us-ascii?Q?buWBsQJhb4pcFhSewqc0QL6r5GYqtZT7IiN6KYFLxBTCUlw1K3yj2JKwL1g6?=
 =?us-ascii?Q?fEMRgZszXemfK2bubjzR2qYx7jXIhEtQNPHs/IHHA/XmlOvISa63mmcoclEO?=
 =?us-ascii?Q?mKoaY42QRLZzOz0ckuE9dcwyLnPFPDHjBzWI9V3J+Z0RCILQ7crAkQjR+DQG?=
 =?us-ascii?Q?TRSKHl6VaHfI8bQUPWQwYWKKq0rywoDqU5rDXdcAwL31kr2+v8UCUHXuZACk?=
 =?us-ascii?Q?zlZj5k00+Opm7IyKZ0gFrCp09G7cTu/7QCWxxB+q744jB4wfji3bcmnLHUrn?=
 =?us-ascii?Q?VilhsFlGuG8vhZApu3C5lWD0542j8Wc/dOmkA9qphsXLrRA2R3zTjgi3reDX?=
 =?us-ascii?Q?XaGf5Mh1srFnYACyPRHvUo/WvvIK7Iu4ZE7+nxMjhWzHEy5MnbWbBTV9Qsan?=
 =?us-ascii?Q?XF/rYcitP1GjUmzvGOMdr9uQENZjJ0laL69B7XorE7nPdMofiIUJ9GNw0ULY?=
 =?us-ascii?Q?yBLuE5O7cHiOn9FQOmoBs7AlRFVWTYz9KVWUofCrta1y/8zVVzE8kqQsJvL4?=
 =?us-ascii?Q?Oze31S89EiKbYmw4RyjTitvB8sQyi1c9tNyM+1woyz3hycj4IEWXJrLIMXHc?=
 =?us-ascii?Q?TSCqspSDpX20qzh8p+uGqOpOR47jxzzKjqv/Fk8i/NMvRlKHgfG2MI6/O7sr?=
 =?us-ascii?Q?S9Xzgv8nq2ewa3tn3jKXaoN4BF+GEFZgEpC3BUEpzsbDwqeQLKAi3yIzSYKn?=
 =?us-ascii?Q?XFqPUJ+2Ges3ya63uOzv3sQHGkymSYx1+aaTSpTNwmIUxwYZhFvWO5bvFdvb?=
 =?us-ascii?Q?0bB1bQoqvPQzgHGM60HuD1U28GBvG3u6GgepkPsa8YFGDia+ChD6wBIZfAQ2?=
 =?us-ascii?Q?cCeXOQTQALiDyaebm1DFR8i6UlIz+KdBFnhZ5ZQyL70ZIOh+HgugGhOoXEVp?=
 =?us-ascii?Q?8B2+xa6G0EMZJa/kzLTWyP47gIJb+DgRWadcsHlJaltbCpXcleGNm1Ocezfb?=
 =?us-ascii?Q?Uf2PMzKDHQr3AXOUeLpazj4LdCa3kuR/oAdbKhLztbBA4CAZkYZ2QLH5gJGe?=
 =?us-ascii?Q?hlzFZo6MhPpcpbDEa7L0Ah5CcWsmty8lRCFQgFKc9GIZLIbSuRi+S8XvFQVg?=
 =?us-ascii?Q?MHwbQRmClkRwPXeq95Ukl5TXcww49KzXSsSL5tZ2AIBtDYWULCt6TkVdfBKz?=
 =?us-ascii?Q?S6R9ZMMcSR+Za4qO6XS9YBEjurYPC97g+bVSX6a0hKJnpBw7UnwNBF65Z8o6?=
 =?us-ascii?Q?zxkxA8iyzE9NFXEsDirwCYUw6a70HCKsdhYK390Pn/Kbp+26iWKC8E2OGJN4?=
 =?us-ascii?Q?lJdzz2Lg4n66f1TOiZ22waMM0Z8yUnD7H3h9lUpSSVjScH/iXSjfO8hQ9Ss4?=
 =?us-ascii?Q?sgvwU3q4otAuEIKe9wr+HuvZLfqPfH82IJXq82Wk/dv9QCxYHsWcg0H68ckI?=
 =?us-ascii?Q?B9bC/FR0ZD1LegOMnjCGJBixU6nbNWPB9FgWHZc/?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cc35003-776b-4acb-4f21-08db41afe57b
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2023 14:59:53.0012
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fp35MVQcHdRthWcgxwgG9GJ/tcisUm9MLWyUAly348b3LxGu586TdnB9GdjuGrFB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6333

On Thu, Apr 20, 2023 at 08:06:17AM +0000, Tian, Kevin wrote:
> > From: Jason Gunthorpe <jgg@nvidia.com>
> > Sent: Wednesday, April 12, 2023 9:52 PM
> > 
> > @@ -1858,7 +1843,15 @@ int bus_iommu_probe(struct bus_type *bus)
> >  			return ret;
> >  		}
> >  		mutex_unlock(&group->mutex);
> > -		__iommu_group_dma_finalize(group);
> > +
> > +		/*
> > +		 * Mis-locked because the ops->probe_finalize() call-back of
> 
> I guess this comment is trying to explain why the following code is
> executed out of lock. In that case it reads clearer to me to start
> with "Avoid mis-lock ..." and put it before mutex_unlock().

Iit is not avoiding anything, this is deliberately locked wrong.

We are iterating over for_each_group_device() without holding the
required group->mutex and hope&pray nothing bad happens. We do this
because of some bad ARM32 driver implementations of
ops->probe_finalize that recurse into the lock.

Thanks,
Jason
