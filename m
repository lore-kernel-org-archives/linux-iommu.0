Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2041.outbound.protection.outlook.com [40.107.93.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8B89E574;
	Mon, 24 Jul 2023 18:06:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ddfkNB/DSHLJofyHJwHbMpYt8bka9gGok6LMRqbSvMW6u7JAVxq7JqPf0/TurIo5e9+1FU9494Piz9XyOC91zcHipohx+Uu18qjOEdHd7vkpgDQCAG/uUZ+mvRV0iaKENgjCOiDE5oXW0vypmhU7+8MdbnfpaxAmnLcnQQH90H1c0VLNzg9BvxLYMGn2/Y+LAgzgsieO3GqBm4IHoo90//bC86a9yL/Kz9VYngMTY4DTFIDk8tYqw67UzYhhO3nuXKfJExZDkQutyYaGRwdZIUPap0aDjZM1jaW0Ic8R//uul+kwRVHIKZw1MVLgjEX/C6yTB7gNwn33BvF4Ortd/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hhVzU+lNWDKv3WBqZxApj8wUzxiF41q+7zYza1VuBmg=;
 b=NanHgLnmMDXhhH5EgyrV8CYvdHB8rnEduFqpZPLG5w8Ofn3/BlLzhfptqWlrqHpio+Ni3DS5KhkdoEcmo8dptab3cwnMBJHhu6EkeIrrROjchp8jjoeLGqyqoUtgheC1zpNG7+cjL693m4PCLfJfxV/tBcmtEAX/J+IJVg24PGj0sRgP8/JYQCS7R0hJz9UExhLPakxqNukcEcspiZOMI5YSzuTG4g0U/8KCvg+zwqi66VSMS7TFhBaoRvEYWS8zX8A58pLJOMliWPb2rIjshmuSvtkTOilD0vZMzY7VPvEuuldNG5r7nmZ/mFWKpWSW+cXlqC45Sahi1L1GLHu2RQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hhVzU+lNWDKv3WBqZxApj8wUzxiF41q+7zYza1VuBmg=;
 b=TlViUpALhQEzSKjsMqj62kbFXQ+mxSM0gN3q3vynBomDIjqSNrHQGUxrFGfrnHeM//vRIhx68Yv+GjHFcaETZaRpouCneAhY7z/eM3f2k4N3MTceGwutwWkZUd991Vcfq0gwzX013gdeLKL3zTQna1BtH0ZlNlwSZHUcZ0dju7MouW4UhIkZSHifxSm6yXeaR6zwE3/oFkmnZ9Va+xrD49FfJkZFCiefCd8Q4yzLEcHwrys6XNXrJCtHbWbfBPzfg81a8bWeDegRW+FU5zOzWoBAzRYlVSaH6G2xTsXOxWovjDRXURI/jX3TayhHn9zUzThNh6MkY/tc+xDCnxu29w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by MW4PR12MB5642.namprd12.prod.outlook.com (2603:10b6:303:187::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.24; Mon, 24 Jul
 2023 18:06:12 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1%6]) with mapi id 15.20.6609.032; Mon, 24 Jul 2023
 18:06:11 +0000
Date: Mon, 24 Jul 2023 15:06:11 -0300
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
Message-ID: <ZL69k24VQdH0LFHk@nvidia.com>
References: <0-v1-3c8177327a47+256-iommu_group_locking_jgg@nvidia.com>
 <1-v1-3c8177327a47+256-iommu_group_locking_jgg@nvidia.com>
 <BN9PR11MB5276130E7AE8B0BEA43FCC6C8C3FA@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZLpzqVAxxLGJp+L4@nvidia.com>
 <BN9PR11MB527621E6E7D464982B8730118C02A@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB527621E6E7D464982B8730118C02A@BN9PR11MB5276.namprd11.prod.outlook.com>
X-ClientProxiedBy: BL1PR13CA0126.namprd13.prod.outlook.com
 (2603:10b6:208:2bb::11) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|MW4PR12MB5642:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d0bc661-47c5-416d-940a-08db8c70a9dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	BZjcaGKzvAiiPLjfqcprEYPabxGdslZTg21E7sEofXQJNBzg9HsHdm6YSFyBHSAX6+2ZvrR0XvvloADUbrk/TZo3Ij68j7xkuT3s154XDaAwmNSQAIEyYcZ2lWNLt0ZVWRtyXdfjdMX4UQUuoIT+QDPUf4nCUWkhPK+XadxvVuHnlhNfwhx4uuzOZSwbVowF0iLmBDLfQplsWLtKVBpNSqxrOUMAeQDSGMB4E83rXQqFsmtklJZHLpmK5l4S3xNpqeFuwG8wGjkSjPPo3gjaHW7lXh12too6u+hNp/LFwri9SamhdWPzlq2sg2UqKo1Kq5U/DaxiVGVNrqT/cUM+B3XSSCfIvWj5aQ7DbZ9YfYfJGlK1Fe0ycc26uRXJSzevd5jzo5RAj5gncsYH/I8I9qFSKTR22i1g/jst5LcQ5hFoQ2iJnK3Pa7gTT5nOywk3TWe3iflp40YpDK1sMQuf6h5mDzBbG/WEzc/jHpv8nVTNg85Jngg7T9RtFFzilXxJPAyo91Vjw+cdzXefcf0zTe9yU/snoOtiy8BDdjIb/dNHbAsv4regu6XSyvHWA921
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(136003)(396003)(39860400002)(346002)(451199021)(5660300002)(8676002)(66946007)(4326008)(316002)(8936002)(6916009)(66476007)(66556008)(38100700002)(41300700001)(83380400001)(2616005)(86362001)(478600001)(26005)(186003)(2906002)(6506007)(7416002)(36756003)(54906003)(6486002)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BMfpS0RgvRJJ9XDNz1dx03LIc9kEMfQOkGilWd/Md/6O/slfLYzvroNxGoRz?=
 =?us-ascii?Q?WDipeYRRThWVQNIYBY+sqSPE5lNrM00lav61+gUR9+LxbqlX2armoNf7SSHY?=
 =?us-ascii?Q?8H2kcweEf/7VZt775ActFyvXi9w01EljjQtXDLDJ1VOQqyTpEFiBGmvYwPZB?=
 =?us-ascii?Q?yZ9UEo2LL04OtWHEDb4d6MEs57I82LQvNH6gt3yyGJZgeEj/SuEaW91ZjiM5?=
 =?us-ascii?Q?wlmAdV71KvczQuQM0byo6onzekkjZ6kVnzKjiNIwjUZk4eU4ahwcDbtpW1rk?=
 =?us-ascii?Q?OGQrl6CBoZy6hSUFYQ5hamB4JTKelALG2tZ2GpY2jk46NuFGmhL8BPEThoU5?=
 =?us-ascii?Q?7r8jDv0V6CuxTBr0URlGLZwroxCwByb+K+BpdJbFBR2QzcpIo1m6WXwS/szX?=
 =?us-ascii?Q?QFmRc0FjM27IxYhLVPTtzV96d3dAARbY4El32Ax7v9FUJTbuF4ZpKD3QeBp9?=
 =?us-ascii?Q?+m0T66VhwrPe9sUwW5IwdAa74uMAUyR54+uuyWLYqsFO4NRn/wHZFtV0wvBE?=
 =?us-ascii?Q?IqEUWuYkFtg0LI/IHJ+LXupOZiGRY7kdzs5FHRIEr6hAz7mrPHT6thxXAlUL?=
 =?us-ascii?Q?8a6njYpUcIecvsFFNKN8Wo5gVTiA8hwHoT+ChXuqnjgEdVgeEHb9Qv5mM/ZO?=
 =?us-ascii?Q?0ueaBpLET5CTSeID0rot0MmHiQkVFpPfvcrzuozX/qUzgJy8vzRiGKfcj0+F?=
 =?us-ascii?Q?UwRPQLvzIpAM1kTTYOpAQgmnnX3ZyCnciP/DCSauYiUyuwMSLMiapCnO9RXA?=
 =?us-ascii?Q?9ksA8gDmfXFCbVlitKqxh4Ak2ovnXJX5AX/u2J3Xg2vWnw4Hf6/++xuJ/a/y?=
 =?us-ascii?Q?iimmSI2IZipfHgwBPs3UPtbmKoAOUgeWoYDAzfUQicCvMkA6LjS+BH8hToZM?=
 =?us-ascii?Q?Oes8zPbOtzFGWCxo3txuMDa13JeEW3VFgQ9R1F3A158rD+McEgme491cuF2K?=
 =?us-ascii?Q?5TY/HzlS9nZBQtsqwct2jyIvdYjYe2iKLy+eMWrlhF+Tdf1j+4jjPb+tVx4W?=
 =?us-ascii?Q?Ry7P75t55v/gmthFbjdXvScAApJxfqshedmvlx3PpP44ahWVCta5BQlSgv8o?=
 =?us-ascii?Q?8upaoFOj8J4Je/PRrAXnqqhRGFVAQ8uOwPsgu7f5CoRmGrTQw60iZnUZ+6Y+?=
 =?us-ascii?Q?9GIxSPBunBmntrHvKG4ducb7OQl3mS4Dgm4Sfsah3rdD3Wf5cEdX9RJw5tnE?=
 =?us-ascii?Q?l2qlZl17LZ9nYicOIcgR0hu+nR5wO7sg92Zc5v43yj5Du94AU08EExCEQ/5t?=
 =?us-ascii?Q?IPU2I5lN6Rw/dLmDznI2GdeZA5iFbAJZk1BBM0gbspgrzXTcu4K+HtkF0v3h?=
 =?us-ascii?Q?0dlgsTE3eNMi6FLFOap3v5Wq1HKEsPFbRtS7Ht4Kp11YTyz2um3kO5XCbBiU?=
 =?us-ascii?Q?aIRxgnvR8q5JtlgzC9B4iNxyn/KZBcsdA01GXVoDe20PzcEt0FDfPGJm8CZi?=
 =?us-ascii?Q?SDZAx/KRGkhghYY8K2hyznY/c7oilXvL4QQVQRg4mw73uRzZxBoH8+eKEUFu?=
 =?us-ascii?Q?//P5uNr4afZWnKMdvqB3OD1QpHtzbsfpeyCWpWroanCnUuEoZhOKdZ/ssHtj?=
 =?us-ascii?Q?NhF57uBF8C6JAcGC43A=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d0bc661-47c5-416d-940a-08db8c70a9dd
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2023 18:06:11.8699
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JCzd2GyeFSTC8FxmpLBZCsgCCPlHZ9n9G69mvSprh/MhfUjW2nTqpgnJAywyU8W0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5642

On Mon, Jul 24, 2023 at 02:11:44AM +0000, Tian, Kevin wrote:
> > From: Jason Gunthorpe <jgg@nvidia.com>
> > Sent: Friday, July 21, 2023 8:02 PM
> > 
> > On Fri, Jul 21, 2023 at 07:10:57AM +0000, Tian, Kevin wrote:
> > > > From: Jason Gunthorpe <jgg@nvidia.com>
> > > > Sent: Wednesday, July 19, 2023 3:06 AM
> > > >
> > > >  int iommu_device_use_default_domain(struct device *dev)
> > > >  {
> > > > -	struct iommu_group *group = iommu_group_get(dev);
> > > > +	/* Caller must be a probed driver on dev */
> > > > +	struct iommu_group *group = dev->iommu_group;
> > > >  	int ret = 0;
> > >
> > > this is called in the probing path by .dma_configure().
> > >
> > > the driver hasn't been probed yet hence the rationale to not
> > > refcount is due to device_lock() instead?
> > 
> > At this point the driver core has partially attached/detached a driver
> > so I'm considering it part of the probed driver explanation.
> > 
> > Really during anything protected by the driver core probe path is
> > assured that the group cannot change.
> > 
> 
> Probably this worths a slightly different comment then?

How about

	/* Caller is the driver core during the post-probe path */

Jason
