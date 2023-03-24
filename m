Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2043.outbound.protection.outlook.com [40.107.237.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 547396FA1
	for <iommu@lists.linux.dev>; Fri, 24 Mar 2023 15:23:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jAR2LOV2eOK6Y3NSqOLwsBEP3U9xZAepntnaxDK+tTzC+mjX5OS3KTzhAlp9dAigYix5e0vGmdyub3xP4XnkQgzy04W79RdsMjMykVz8cPmnReyx51RA+Zg5meb9B9b52y4kpMLC0GvbhrYSMFVBVcx7CZgZTPx/OGTYKkC6X/Yw66XgoXumFoCsqykTCltWq2R+FHWogy7Hz/TglaMqmnJhNhXndkefkhsl4KUt2E5erZeg94jj/NjdOTFsAszAa4DUvV/xdtQ8nWLfzXZPILszKmY6Jg4iYk2QZ6a2V4Yhd16oVf8Y140tfZsk7UpA3XFS1/539DGILpVW/wj0sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SE7aBpP8vxwyoAHbDEPSp//tVhokNtAhTtBy4RnEg30=;
 b=SOLzdN5GIbIZysjfY9dgt8LohassCG3TkGBugalVOeYmxMm87EVSYpjUnt/CTEJjyl1hgBrsOP2NZkKntWyleVlRlrC6MlD2lNwJdspWrxbWYscA0q3V9fJtsajFBOU7kxG7v1Xpb2vCPSOiJsLslT432VHco9LDTCr5cwXXNam+HmLQjlrPyaYtvnhiDCt3iPZSsGxu2z98qma3NOytae9poBE0rftkRcCeYUtHvSdQdkjxRghOABxtJGmqrOSjvFMG/3wLjMbqu/lxtIVSccbxmN6cta8c1FQMMGAwgD0fc+2qnavGDcGvh+34DyO79Zfekaz+8xvfNMYdcG6Y2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SE7aBpP8vxwyoAHbDEPSp//tVhokNtAhTtBy4RnEg30=;
 b=gGIsbMIKTrWTb7ROx58bQguERMC5Wm7ZVxroEBiJjeY7s5P0nfs/t5UsQcYt7JTeeGJIGQnCzpW7uKt2IyFKKEn0budhkxBtWLTsuT2B8Z0x4IUUcOJ52Gf3joZ8Id+3SxfpA2WDTM80+B3Pg4BuNGlK4EoMKHu7UwHxlzrV66J5YqVhZlpeobMNamFpBUvn/L0b2snP0s/wk+gEgPlocC9RMPEXIslBPSSseWOz2C4Nw5nxwisaDhqhTU9u3WwHfWSpP5cOk1fsX6W725SUt36DrZ4fc3CJXML/6Ai9tiwLXHIyVueN/l9mO3jJjUpA7U4xG5pvOQDNCNFYnXMBig==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by BN9PR12MB5146.namprd12.prod.outlook.com (2603:10b6:408:137::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Fri, 24 Mar
 2023 15:23:52 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1%3]) with mapi id 15.20.6178.037; Fri, 24 Mar 2023
 15:23:52 +0000
Date: Fri, 24 Mar 2023 12:23:51 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	Joerg Roedel <joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>,
	Will Deacon <will@kernel.org>, Lu Baolu <baolu.lu@linux.intel.com>,
	Nicolin Chen <nicolinc@nvidia.com>
Subject: Re: [PATCH 5/9] iommu: Make iommu_group_do_dma_first_attach() simpler
Message-ID: <ZB3Ah89mG7POI37Z@nvidia.com>
References: <0-v1-20507a7e6b7e+2d6-iommu_err_unwind_jgg@nvidia.com>
 <5-v1-20507a7e6b7e+2d6-iommu_err_unwind_jgg@nvidia.com>
 <BN9PR11MB52766008E93EA1CBEFCE5DF78C849@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB52766008E93EA1CBEFCE5DF78C849@BN9PR11MB5276.namprd11.prod.outlook.com>
X-ClientProxiedBy: MN2PR12CA0033.namprd12.prod.outlook.com
 (2603:10b6:208:a8::46) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|BN9PR12MB5146:EE_
X-MS-Office365-Filtering-Correlation-Id: 67e646aa-5c9d-40ec-b5d7-08db2c7bc678
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	sxxqAOlq/kGcvxB2jaQ4j0Fb8WJB0qFjq7WEs+xDp/MzULfDPoyBrQnx78iWTZBlMKY012gi9JYp8I7mpdmrfGCwuXRpyhnD9uPEYLimtIB7hyvok3sGCUS3cXaIlk651P3Cg+n/mU7US5DFOXIbwSp2Pz71gzPzqvztQ/AC9oOJe7acNXrZcsG2QtiItJqgMNTRM35l0sqEz4AYw7c5bdYDueZix4IdGy5iJY5J+EIC8SzFMX+B3Ukfneg0pVkhqaGDSOaHPjA4CHCRsZJqxBMaNlN1UHIsiEmB058nSXwRKjjm8Q5K3NP2DSsnuk4qI8+smaysMxAVJo2F5WYWXQ9x86U90/F6NbN9W7jq3pOfhcGm8I/7AX9mG08/oY/mAxq/yAkF5nlbAz7mQTzZeXetSoxlV2ck87MC6cY3ZR7VHaqcoDUuk/8koVQQ9jTj4VyDEgvuVqhAmVnvvRCuR8KVEgh6dWiOV/PedTYN3AX8TcXYBfXCwO7DawJvYwZVbWOZK8RVGL+h3YY+jZ2Mm9LZEpUjTeShgdnFML/kzdgh5du8KGLF8Ro8yvDq3gch
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(366004)(136003)(376002)(396003)(39860400002)(451199018)(54906003)(86362001)(478600001)(41300700001)(8936002)(5660300002)(66556008)(66476007)(66946007)(4326008)(8676002)(6916009)(316002)(6486002)(2906002)(6512007)(107886003)(38100700002)(6506007)(26005)(186003)(36756003)(2616005)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CgyIJ1+vDbt3wjZXD9vC0ZRb0UAXfXvISn+7N4q4Xxb37iTvFlJdcOQuuagg?=
 =?us-ascii?Q?q1rcVJNPTDB61riNaXRgJt8UvjYX011ofdxfDUcAQLNMlrxmMRFTq64kaoYe?=
 =?us-ascii?Q?DXF9l3uysf8rabXxN2bGospxaYXxfReTLvhZ2LgvaWe3hO+hUmxn8T6NwVyR?=
 =?us-ascii?Q?tcftOLngA+OzsiiCGL1h4qsSk4xIOUKHqcHZS7VNMGd4LOrGp/1/Tp5ZiFo2?=
 =?us-ascii?Q?ztxdc7fprnlZRXefF6bDBM1kQXzSCohdxUjlj9BtTl3ZOYR4Vnu32hGII2og?=
 =?us-ascii?Q?FMoujpn23Vw/Rvygm+RRyE9sdpvxLwFKMEeNk0UfKs8Hsud5O1UtbQTtD2vn?=
 =?us-ascii?Q?sQaabkQPbhysAkAOWZ0JujswtcvxA5PvPpL7MOsBX8akICovkwa9MZya6Wtb?=
 =?us-ascii?Q?tMlo3Pj6zsFCgoOz41RcdyXf2jY8hsA4FsqxhqVDSF9D8lqqtoykh+vEA1MW?=
 =?us-ascii?Q?+7nt3LcpQP0/Tao+MAGRCTAoV/tv4sl1jgKogiA7tj5lyKHpL2yrmNo1+gtL?=
 =?us-ascii?Q?reFqAfYjwYVnWdAMvAowLPPpLo1gQAo7uwzZ0X3zwAfBK82Ye2IzSNWJR1IU?=
 =?us-ascii?Q?BoyzyGu+28+G2wlZJ0aKCm+AAoyXQsL8423bH3bCysMnsRcMAwKbfiz5wwib?=
 =?us-ascii?Q?0+KRjolQd5CEwsnl3xxo/30WIzxBoyjFvXaFJiPJA7IX61OTf6+Zq+NjDx5C?=
 =?us-ascii?Q?9R2S/ywcgVFUQhO/2wQbTq9vrz8/nc8EGe1a0XwD14cHJEE3bvoiOu/XMltL?=
 =?us-ascii?Q?Ed5oWab1du0RvcLwu1mXKMpzMyPvepnuunRaGEe5Lyqrg6+SNJ2qOsE90Qw1?=
 =?us-ascii?Q?5Sl799pU8t7/pTFRLgv1puYZhP7fDpxxhq4+i1J+y9yJyv9sSCw+1Y757u66?=
 =?us-ascii?Q?4kYxZxbguusjL5n+eUhCOOCs/8D/PpUs4yHsrUawMc7emaqnE6iclo/cWion?=
 =?us-ascii?Q?Nj8dW7E/HTKxVzrHdXoeusH9geKr1lGlpAI18xhEaVxVqmFJW9tIrErpjaJa?=
 =?us-ascii?Q?GSC95GAJxz51XPFDQnpvh8bZhgfW5MPgHp06mZ/LEdR2WH1sZTb9LsVDSaBS?=
 =?us-ascii?Q?TrQuvSA8ql80mW6NPSpNY2GhRFcCB93W41CSNB5pecb+rlhHcHkbdcDmitg4?=
 =?us-ascii?Q?nQX9QLSPwThpor38euZ5ICG0aDUbCFIb3XJpP69iyVMWMJ0KDh943aBd1Lx1?=
 =?us-ascii?Q?Qi6puuxQL8TRxGsLeAy9WYXvmhrsDqRbk548voWfPqa1FjR7QwFmrNQagMOq?=
 =?us-ascii?Q?QfGTLS7+tTHoUvlHcGf+f6cEtu19wPfmjNJk0UzGdMaRPBzppVEgeSUy7QeI?=
 =?us-ascii?Q?NAukF28VZutD+d6BeXFinJcFQV1cHcFeZkLiE1HOn/Odl2+N9lOGounqa6/6?=
 =?us-ascii?Q?aQwZps6HRwula19OXFCLYzHp/AdVX/XiXtJsb/Rqu2duQkLyi2u1iGSOS99I?=
 =?us-ascii?Q?5gdxr8i6MrboT4j8ylJu0ldqF9v1Lz3pY7zQoBSXj70Pvtv45keqORAPdlyc?=
 =?us-ascii?Q?sF43V7N+Rf6n/7RNBBb8gSQ897xCVJxQ/3+miaQAU6jD9A3Iil8GOZ/w1W0h?=
 =?us-ascii?Q?xFJVbf+IL2hJ3EvOkLX9q8oSsGEoCL3twbsSJXcE?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67e646aa-5c9d-40ec-b5d7-08db2c7bc678
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2023 15:23:52.6706
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R1ELtsGwwgvSdjIdBGVfP1yI/rtt6ai7SFRu1helshVrmMY9yZF3hqYiXstuSyYK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5146

On Fri, Mar 24, 2023 at 07:23:30AM +0000, Tian, Kevin wrote:
> > From: Jason Gunthorpe <jgg@nvidia.com>
> > Sent: Wednesday, March 22, 2023 3:53 AM
> > 
> > -static int iommu_group_do_dma_first_attach(struct device *dev, void *data)
> > +static int iommu_group_do_dma_first_attach(struct iommu_group *group,
> > struct device *dev)
> >  {
> > -	struct iommu_domain *domain = data;
> > -
> > -	lockdep_assert_held(&dev->iommu_group->mutex);
> > -
> > -	if (iommu_is_attach_deferred(dev)) {
> > -		dev->iommu->attach_deferred = 1;
> > -		return 0;
> > -	}
> > -
> > -	return __iommu_attach_device(domain, dev);
> > +	return __iommu_device_set_domain(
> > +		group, dev, group->domain,
> > +		group->owner ? 0 : IOMMU_SET_DOMAIN_WITH_DEFERRED);
> >  }
> 
> This changes semantics in iommu_group_add_device().
> 
> Previously it always does deferred attach no matter whether the group
> has been claimed.
> 
> While this change makes sense given deferred attach only applies to
> default domain, it's worthy of an explanation or probably even made
> into a separate patch.

I added another patch

Thanks,
Jason
