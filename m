Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2051.outbound.protection.outlook.com [40.107.95.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DDB9286B6
	for <iommu@lists.linux.dev>; Wed, 13 Dec 2023 13:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="oeb/IAK0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kiqyzp7M8TVYcVxjntNVG99Xi12N8MDLBcxStZPRoaqDkc4pCTsJw0YNsuX4qIKJb5MwbmH8kgMryp12kDW/X+1n4VVeXQSgnZIUGEYw9n4+xWZ2NF/e80/JonXxVAMIYbLEzOlnLGDCCWPL4ME2VWE2f5VTuUCWE1DMtwtAs/BK2DmaqhPWGwy72UrVECuy9uZ2t12mDbghL3NN7Ims9ca92Jh6+ffF/3S8ctGSO7WwTzkboyAoufYFJwT0pOO1Mb33ji+Q8SJGYs8HSTi7ht5HDioPZ9RB4uFrPWiQBcjSkhZ1FhVLhogGVxavSaxBjhUCTrFZdNHyjfSZi0xD7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eko6oymQixTIj0XGr0L4COFpeiaJ3jzKl5kiZQU9VF4=;
 b=Ymx2VTU6NWPms58+mpGxGmUZtFDx2N04E1xF1L/EGIAwesmWpn9jA3lYLSWvFCVU326WVdqWI2RoEMIvfcLYnLq/6GqrqP7StYB5ZSYfKtk+8UuK3mUbhGpMubVMlQD9YicEEKViT82sQBjgfRpK3L78huFKZMnvtXNS/mJWHV7Hg9PpDKI6dylqqrbVaBsX+A22w8qx11c5i+g+MUCNo0xLhRb56G2jDlz5qU6Wcb4L7Hi2e5Hw30aQxmIRU3hkDMt/wURmsiKXUVK/gPZozvH/AN1tgg4hkqU7uQMVvO0zfDz0JYYNEcHBBZ055SFWaD4ujpYCG7yM4PtQ/tCXog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eko6oymQixTIj0XGr0L4COFpeiaJ3jzKl5kiZQU9VF4=;
 b=oeb/IAK0HpGKBDBSDQMQzStqg/TAEldrYnWHmHrGxGEdbtRIcnIr2BTOZvRHOrHmizRkYNiklhwJalRGNmPUSJg/pr1+yMJKiLdPnpceyFN4HdaS1YrelEUWDa7v5iNyiKwfHMupuU7nBdXsBtISNOYBuGLClIChdgocV+T1m4VWl8xodjB/4/XfDeizKg8P7WyMNJ3vxHdrPQD7p44x/99qPD6l+lZ0AoaQRpbYgmoH0LJOOu8JCGjf2icl5kELWHGQS/dq9XM8NhwMgWIRQ8B40jf3WbXmDdDxebwKmv2olF8K8PjdWxTWU22ff93YgOy4hDSM+0CkUkK4vkGyeQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SA1PR12MB7269.namprd12.prod.outlook.com (2603:10b6:806:2be::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26; Wed, 13 Dec
 2023 13:32:37 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93%4]) with mapi id 15.20.7091.022; Wed, 13 Dec 2023
 13:32:37 +0000
Date: Wed, 13 Dec 2023 09:32:36 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Will Deacon <will@kernel.org>
Cc: iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
	linux-arm-kernel@lists.infradead.org,
	Robin Murphy <robin.murphy@arm.com>,
	Nicolin Chen <nicolinc@nvidia.com>
Subject: Re: [PATCH v2 2/5] iommu/arm-smmu: Convert to a global static
 identity domain
Message-ID: <20231213133236.GA3259566@nvidia.com>
References: <0-v2-c86cc8c2230e+160bb-smmu_newapi_jgg@nvidia.com>
 <2-v2-c86cc8c2230e+160bb-smmu_newapi_jgg@nvidia.com>
 <20231212132708.GB29569@willie-the-truck>
 <20231212141516.GE3014157@nvidia.com>
 <20231213132651.GB31729@willie-the-truck>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231213132651.GB31729@willie-the-truck>
X-ClientProxiedBy: BL1PR13CA0233.namprd13.prod.outlook.com
 (2603:10b6:208:2bf::28) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SA1PR12MB7269:EE_
X-MS-Office365-Filtering-Correlation-Id: 516abf6e-f687-418e-5e3f-08dbfbdff877
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	BDkVH8K4LLDwzptiuzAu8muHvrrSpw9DIo1ltGUe369sJwFcsQ/JmALUnFjWPbe/KDIG9I0Gz97X84Z0Hz1db6ph+8n5Xc0v9QOXPeCPi6stX8tv7JFmXFRAErerE2xETVl3hbtKHMWko3+cwg+iPEqRjAEC/MB0hkc7r2ZrKVqd+TvLcE5Ylt8ASAJ8iNQAek+kQo6qo6nHrKt4KpIxQruYflkfBcrFTY3mpaW4I+CqMpMAeqlKoZgCO0eTY73kXv2EYBAUkUinYyIp8gT2qbw9eOERsnjSIqbTj5Rts//aEVn6hnDwkIlL1zRMsUum/MrZtaEBGP6QtQMluANMvaXmCcR9tnpY8qUv064Hovt2KO/4OQMEI60fDIm3JS6rJ2zxwnyWeHMvbyHgKVqH0367bwjGAGKUWNmIkx4svffo2CprAYHWR+UznVTEVsqTF4qVLDwFN+9Oa1+U+tNd8C6JwRpqAPX21KMn2z7M3mG8pJpSnOJA4oUsmxOXbi8/v9fhX2V9WZYixdE1g/pYST636frF9YvTr4IW+jZGxrlNG70QydnhOlU8QPFvRRg7
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(376002)(346002)(366004)(136003)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(26005)(83380400001)(107886003)(6506007)(6512007)(2616005)(1076003)(8676002)(38100700002)(5660300002)(4326008)(8936002)(41300700001)(2906002)(316002)(6486002)(478600001)(66476007)(6916009)(54906003)(66946007)(66556008)(33656002)(36756003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AtTiMZ2vgMeohEZzF4ZOPAQYs1nJwvzWQgU9GXPlYeqV6/OVJCMVst7GF5Ub?=
 =?us-ascii?Q?TUOx61zZv+YGWMuln3KURDc81nH4PSw3SZuO5bkvr5H+uhAfB236VA07CgqG?=
 =?us-ascii?Q?qAlTGf/qJk0pKrbx0OLV6dRE20i4MdAzYGo/pbMIkBQHhJrky75nvCTbnmrh?=
 =?us-ascii?Q?vdQSET8YSkKGp7KRsTHtHoEt6ZPLpLd64NV6MAQx9ezvKpmoHWnebJilCDsJ?=
 =?us-ascii?Q?eq/XKCo1edEgh9RwyxvkgwwbXAyO6HuEqcEmONfjkKi4rQcW88D/vOSyvls/?=
 =?us-ascii?Q?GV7LoWJ75aWbxUDAWuGUENxSr8+oEfVI48J4wDEkO/4sZuTHV8pDLPd7tyzE?=
 =?us-ascii?Q?N5YHg23J13Qpj0oViO3J34sWFzvIyxGhuTCKevD/j2HXtXEygESetp3qjcU8?=
 =?us-ascii?Q?9ajWa/M7UvHq81/xAicJMzTVzDQVlrm3HkcdRuXKHRZeKIF+RKYDvPNHRvL0?=
 =?us-ascii?Q?KxstjZmjEtUxgoVxSt76Q9k6Pv1hwLX1l6FcMPz52wTmoGWbYvkLBs++SBhA?=
 =?us-ascii?Q?xfkgHQMfHTmFi+cPCpWNnIE5PiZwWpXLOaeek/94pdjIZMYrwqZnqSvITPWF?=
 =?us-ascii?Q?bNXvbdVsPOchFtpLhmGGVRwnv3CVbsI7fojVdZTThnsibTia8rah2nGjttzD?=
 =?us-ascii?Q?r86+7SQI95+RGdrUntG0KMPN5VakmsPnV1uXzwFUMTLGDWoNEidQuZQBk0ci?=
 =?us-ascii?Q?b9qpz5wzFlC8VjdRJ3NMKsWP9mDO3pKCq9moycwOI6YqI85fW/zAHlgxZNUs?=
 =?us-ascii?Q?8O+t61/uIfU5wP+ddcPOJ5omsyTPyPOrLdcxJ5IAWeG75wvKJKqd8vwh6uVc?=
 =?us-ascii?Q?bkjvSPXn4vgTzwix79TS02/Cs4uC0it7JOj3jk6ehUtR435jaVdBVGZKzzF2?=
 =?us-ascii?Q?fG2pUWqyJHIifI0pATLVegk7FmFsBOPjMrqxvbvAMx4dawLpw1Z8NOpmZhRL?=
 =?us-ascii?Q?2DCOW582I3/Bwt2DjdNjO3N9tpWr8bKl/DhdKQgrG05V/MfBHnME+M5vNrIo?=
 =?us-ascii?Q?y40uQ7eNR39HQObFo70V7Z4t+8KXo4swGpW405n2thJ7QecRPy53aB+Dy5X5?=
 =?us-ascii?Q?x+soedmd2+2brc9l24CZvVBarx60H90gc1Np7X+4khkPJgUYJ0Lm5LgvVk1K?=
 =?us-ascii?Q?vL1IbnXQY8RLUPtBVh+q3RHqe3jUTTkipK72vhl9dvaUAe5aD0/8sH2V6mWG?=
 =?us-ascii?Q?LBBr2xQhhR/WdPm7tXYbezHM3/elgwtngRh5X6QPbwBrURGMWMm7OMR0QJY6?=
 =?us-ascii?Q?mvsAVC04lmcRU1uGs8lyZUm/I3BAIeIraCn38LLPnxo23MJf2+Q1e1vRoTez?=
 =?us-ascii?Q?dQ8p2ASu9WWi/hm+DE/eYmziZtS6CJzklVl+DbY+z5nKlY9Rbxxvn3qmjhYm?=
 =?us-ascii?Q?+cHlfK3EwCjgWTSA6eH5nIAX+VyM032OuRY+w/1d5F0Ol8qlETa5yiZXUqdv?=
 =?us-ascii?Q?iRu4gEZO07iSsImLB4x8rh34i/aTVCGMAtYQhmLb5Plqtm86J9IMXXgwY0YN?=
 =?us-ascii?Q?5FUueMNoMJ1zc8jXZBONlq8qcT+ykW7qJxVI7YmyY9kKDGBA4dsxG2Q1kFzB?=
 =?us-ascii?Q?3C1pWbxUkGcp/ZUYgmDjFv+6NAfaDtcjWuH+Ym84?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 516abf6e-f687-418e-5e3f-08dbfbdff877
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2023 13:32:36.9470
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iIJ97HILyRkFCs9rWTM3y8L51PVctG622ppbdXn72k1KKAaqeJ6U3qbALsxnP4Ly
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7269

On Wed, Dec 13, 2023 at 01:26:52PM +0000, Will Deacon wrote:
> On Tue, Dec 12, 2023 at 10:15:16AM -0400, Jason Gunthorpe wrote:
> > On Tue, Dec 12, 2023 at 01:27:08PM +0000, Will Deacon wrote:
> > > > +static int arm_smmu_attach_dev_identity(struct iommu_domain *domain,
> > > > +					struct device *dev)
> > > > +{
> > > > +	struct arm_smmu_master_cfg *cfg = dev_iommu_priv_get(dev);
> > > > +	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
> > > > +	struct arm_smmu_device *smmu;
> > > > +	int ret;
> > > > +
> > > > +	if (!cfg)
> > > > +		return -ENODEV;
> > > > +	smmu = cfg->smmu;
> > > > +
> > > > +	ret = arm_smmu_rpm_get(smmu);
> > > > +	if (ret < 0)
> > > > +		return ret;
> > > > +
> > > > +	arm_smmu_master_install_s2crs(cfg, S2CR_TYPE_BYPASS, 0, fwspec);
> > > > +
> > > > +	pm_runtime_set_autosuspend_delay(smmu->dev, 20);
> > > > +	pm_runtime_use_autosuspend(smmu->dev);
> > > 
> > > This is cargo-culted from arm_smmu_attach_dev() with the comments dropped
> > > and it's not clear at all to me that the autosuspend delay makes any sense
> > > for the identity domain.
> > 
> > Indeed, however it was how it worked before this split up.
> 
> Yeah, and I suppose given that I certainly don't have an easy way to test
> this, there's a lot to be said for preserving the current behaviour.

Right, it is why I did it..

> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
> index dde912f8ef35..dec912c27141 100644
> --- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
> @@ -82,6 +82,23 @@ static inline void arm_smmu_rpm_put(struct arm_smmu_device *smmu)
>  		pm_runtime_put_autosuspend(smmu->dev);
>  }
>  
> +static void arm_smmu_rpm_use_autosuspend(struct arm_smmu_device *smmu)
> +{
> +	/*
> +	 * Setup an autosuspend delay to avoid bouncing runpm state.
> +	 * Otherwise, if a driver for a suspended consumer device
> +	 * unmaps buffers, it will runpm resume/suspend for each one.
> +	 *
> +	 * For example, when used by a GPU device, when an application
> +	 * or game exits, it can trigger unmapping 100s or 1000s of
> +	 * buffers.  With a runpm cycle for each buffer, that adds up
> +	 * to 5-10sec worth of reprogramming the context bank, while
> +	 * the system appears to be locked up to the user.
> +	 */
> +	pm_runtime_set_autosuspend_delay(smmu->dev, 20);
> +	pm_runtime_use_autosuspend(smmu->dev);
> +}
> +
>  static struct arm_smmu_domain *to_smmu_domain(struct iommu_domain *dom)
>  {
>  	return container_of(dom, struct arm_smmu_domain, domain);
> @@ -1141,21 +1158,7 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
>  	/* Looks ok, so add the device to the domain */
>  	arm_smmu_master_install_s2crs(cfg, S2CR_TYPE_TRANS,
>  				      smmu_domain->cfg.cbndx, fwspec);
> -
> -	/*
> -	 * Setup an autosuspend delay to avoid bouncing runpm state.
> -	 * Otherwise, if a driver for a suspended consumer device
> -	 * unmaps buffers, it will runpm resume/suspend for each one.
> -	 *
> -	 * For example, when used by a GPU device, when an application
> -	 * or game exits, it can trigger unmapping 100s or 1000s of
> -	 * buffers.  With a runpm cycle for each buffer, that adds up
> -	 * to 5-10sec worth of reprogramming the context bank, while
> -	 * the system appears to be locked up to the user.
> -	 */
> -	pm_runtime_set_autosuspend_delay(smmu->dev, 20);
> -	pm_runtime_use_autosuspend(smmu->dev);
> -
> +	arm_smmu_rpm_use_autosuspend(smmu);
>  rpm_put:
>  	arm_smmu_rpm_put(smmu);
>  	return ret;
> @@ -1178,9 +1181,7 @@ static int arm_smmu_attach_dev_identity(struct iommu_domain *domain,
>  		return ret;
>  
>  	arm_smmu_master_install_s2crs(cfg, S2CR_TYPE_BYPASS, 0, fwspec);
> -
> -	pm_runtime_set_autosuspend_delay(smmu->dev, 20);
> -	pm_runtime_use_autosuspend(smmu->dev);
> +	arm_smmu_rpm_use_autosuspend(smmu);
>  	arm_smmu_rpm_put(smmu);
>  	return 0;
>  }

Looks good, thanks

Jason
