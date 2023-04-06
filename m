Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2058.outbound.protection.outlook.com [40.107.212.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 729523214;
	Thu,  6 Apr 2023 11:34:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tb/1m5/SDDTsGmbvzDwLJbt4jJ84ykE50ghHwdTiyjb1MSOlK4ef3sGikZ4Hefy9kJXjrwV6NyoX/oDSh2pKsLnzYsawEUaTvm8YITTT7biAF72HodeO0FtfIrBpJx0H+BrjcdzCRN1wdHuG0Wpt5ritYXDiQHCD1rIZr1V01LzxCNaX1S6lFLbkNzI2rKVM2ocyvzg6mRhabHXpOWtLJysSox3x/20k1V7jMO5Dv9AFpF9cUElJZhSuVmMLTjVlm1uzzPzOhZinDyrlZZLZ+W9FllX8plevFvhQR9OKIKq/49VNJcCsLyfmAji1AucY5XGqSlIM8ORpqti17nyh6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s2D37O0QUC5A+mqDzO6BU11LOwkMlmvdKnAs942cUuM=;
 b=PSm8D5/3bhX02zdzArzo4v/E6JC5q1Lut0rf9QCzdNxjhcoJn+vyysji2BWVYdc2Ei1TiMPLwD8EDRwMRWCH1L/Tu3WHMkyuhOy5SVtJHm1CHfRB6vqbK1BmcjoEk5u3Dpz2yxepgUL2obsiRbN/VTtBNtIWSif0OrjASM48R+QQOitQjujXcULKF/pvmt53F37kk6sR4iDKHCJpl0Bp3tkGFAb8XmEzmsHHJiHkHLlZiuYgvI1CCT9gSjIbGCN+L51h6KNJFPxrb45PzvjMmEiJRd8jU4zmlYluc8wbbZ6KEbceKU8Gj2H74lY65uBvB89Ck8nv9tMSI5tRPZro+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s2D37O0QUC5A+mqDzO6BU11LOwkMlmvdKnAs942cUuM=;
 b=Vg64MT46Gf5oU4EtMN+IeY9Lr7zztpOuSHkF5KZ9vq5qA08dPSIFHMD6p9ekQvI7SJZ6zjKRTZ5aYCdeRvgK1jgTEpllWQJbGC4r41eVHjhyStNWBXiJVSmx11a6i5fvM5ejTxJpILHq89V0aPowye62keUpjgtrsbxiEAKBKEsMlII4F8P1l0n/nvkYaooFJMDnmEbcDoafYng6JG9vfXY4prSk8Br4fIGYC4XE7gPvHuAc9saiLRa94dl2sHV/ZhOx+nSLZje/Oknmtx1Ek7kpVWVh2RAI+al8N2K9xIJg/F5kaIFGpb6ZH+TWy8PnUfLxyxCsvg16Lg6OLgvIFA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SA1PR12MB7221.namprd12.prod.outlook.com (2603:10b6:806:2bd::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.35; Thu, 6 Apr
 2023 11:34:48 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::6045:ad97:10b7:62a2]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::6045:ad97:10b7:62a2%6]) with mapi id 15.20.6254.035; Thu, 6 Apr 2023
 11:34:48 +0000
Date: Thu, 6 Apr 2023 08:34:46 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
	llvm@lists.linux.dev, Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, Tom Rix <trix@redhat.com>,
	Will Deacon <will@kernel.org>, Kevin Tian <kevin.tian@intel.com>,
	Nicolin Chen <nicolinc@nvidia.com>
Subject: Re: [PATCH v3 13/17] iommu: Revise iommu_group_alloc_default_domain()
Message-ID: <ZC6uVivTESGPKkHu@nvidia.com>
References: <13-v3-e89a9bb522f5+8c87-iommu_err_unwind_jgg@nvidia.com>
 <c7d5273e-5621-b681-bd6f-2e044e6db6ff@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c7d5273e-5621-b681-bd6f-2e044e6db6ff@linux.intel.com>
X-ClientProxiedBy: BL0PR02CA0144.namprd02.prod.outlook.com
 (2603:10b6:208:35::49) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SA1PR12MB7221:EE_
X-MS-Office365-Filtering-Correlation-Id: e0db4c7c-a111-4bee-7b6a-08db3692ed60
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	HhTFpz3hELcvS4hwoKfcVt3n3Caab3dAIOD4eNsDbiACc60T/oueWNOGN9mp95ZZ7EEDeWb/eQitSW2Bt/oX6V4PC3hFqRnOuSuKFcG+jtSZUBwn1KRa3eIyPVwidnXm7INzRMBlXhYHR6pvlJDhy/O1kkAFfdgEdZKL93uvsgwjuTsGp2Yhd46q80HNgHH1OVXL/+ESe7qS7QGy+Ctxg+AgEpjARNKLyq5LDcSYdtvo+rCyxo4/gMyhe4nUSuxU5qksKC88p23jh0T3YJD2Fr94exIOwgmgyUaiHVIWqAiD5gmoA2SCYWEBqmu/NwHXkvW+CIWlD/ICSnGTqavPTjk7yIEXB0bZ8tdlPh8gsrh60y8XPMTUl6uZnTfCd5pMuKxA+K7OpfO5KED7XV+PdCCT1+66ZsHu84t5R5GZ7B4ovfWRVRe85yD01lBtqKGR8DV0gvUk5Vs282a48p4slbvGkCUyhI8izToKLMgkIKJ+vEX4Ceg+kd6xKIo2GnU5VVTvvurP21/8NboUHvOvgyxiQrOrb0r7Gd5YCJ8NbUpgDKDRPtrh6gvy5Z3//Wtp
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(346002)(366004)(39860400002)(396003)(451199021)(107886003)(53546011)(186003)(478600001)(8936002)(54906003)(86362001)(66556008)(5660300002)(7416002)(2616005)(316002)(6506007)(6512007)(8676002)(4326008)(83380400001)(41300700001)(6916009)(66946007)(66476007)(36756003)(26005)(2906002)(38100700002)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zfdeeVgw9IOKvJtdOSRFDBl2n1uda/GZh76dT5dj0cODQsFRqQVT2/Cqduzi?=
 =?us-ascii?Q?HUMqMR+B9jfX1ClkUPc7wtty2QIhLOmKaNBT/Lrmri/fcUSsi91P8BMI5qjx?=
 =?us-ascii?Q?mdKzjfHjTtMxzJxwFOmN5WOTNjrinAzH3AVuyNY34JQzvzRcKV1Yl8mXeXCc?=
 =?us-ascii?Q?DapgE55lDl0nxmRWi85a7NjUnvOpw/ma5PSO9TQye3xqcKMdp5wQsQ85M8Ub?=
 =?us-ascii?Q?fTMDVACNUMlMO6hwJ9cJHPlW9FHk0faL8hnwWBcfUlar1BMy7JEQfD4xTnDq?=
 =?us-ascii?Q?IZswUIXKkbkJzWeMwz/0GJanJsOCNylB7wKsKC1XkTqzBvvXVJjXMWd1GxP+?=
 =?us-ascii?Q?T7Sr92OJqGAwJyJZG0vCr5tjKlyYh8CDzxPYtgNbRDv9oMkSHr3FzCN03Lg2?=
 =?us-ascii?Q?KxhdgqKtGK8HPQFAoLYz7rdzpa+kWCz7yigPgaDSwjK90VjsDGjFDtI8od1m?=
 =?us-ascii?Q?Jj0DMHuBCR47VaEo9K+B9kJ+9sZ5PJRbG+ZNCJFmLswyBZCOtXRKllpGJUNi?=
 =?us-ascii?Q?v6PyvwSwoHODFKLhK51/yvxorKpE3NzBrxk7BSAi/BAywUpmwY2QS4+LmrA6?=
 =?us-ascii?Q?fOBzOtH9y02uFJzUj3hYKcOfJ2wW9WlTtFcxaTsO/YZKXLwBag6EriO6aZEL?=
 =?us-ascii?Q?sp4yz3JD7b1n9WWtFD5pv66ZbLYldI/PRor+ilXYzkrphT2BdYgog//wVYfr?=
 =?us-ascii?Q?SfgVxxW+RvxYAzIrZsrXo7xNu/sPYJi6wTOPEd6eJWB00Fl1ylPAnEOJZjCK?=
 =?us-ascii?Q?dUEuqcOiQqPTMey2Ubdej9Aherfx8Evjfwv+qxtyWGlW+q5d3duEeW0ljAUY?=
 =?us-ascii?Q?T2ZkUym5ZJmC171Jv9F4cZ9BnNUT2ZxoKsTAfRZnK7TMw59biuwgBZcXyDNk?=
 =?us-ascii?Q?9GtloxuCbmCce+KkJ3Zc1GaIXISqIJW/bBYWTyLMgsVGRjhQ7SZJ1Ymlh0oK?=
 =?us-ascii?Q?2M1hJ4EsK9HG8C1Lt/fg6uj3q9/AWxO8V3N6ldkLmCJqXaDXIJY7DGPbDBN0?=
 =?us-ascii?Q?wG/3pAOF6Agvvm74LB5plKTqc4m9kykuDooz395HDhb7VK5UFOGPomgRl406?=
 =?us-ascii?Q?Jnfd3ZcyLXQxZNQvCMbflO4zkAqqEmk4VGHJ6/99odyLhTesoj8h9hqQHon2?=
 =?us-ascii?Q?tdv6UfPgLuYliGbPO5Vi/mhdOzCvT/U1RV5sdBbVkpQYrt9BOsZ6q4YZP2Ag?=
 =?us-ascii?Q?5nVxIvM5g4H0XaP7+jFvFhFeu/wjHOmTZYS+gExWNfLxNqVuv8jcrYec8IlE?=
 =?us-ascii?Q?ZFNfisjHxHzbZahUUiQkq9Mgiqd2qPipqUtMdCUmlHALLKOdt5JpmslSGNl6?=
 =?us-ascii?Q?Dwdp2etRi6FlHKt2MLLxzzSvDwMHVEe9HF+l6CdSCsPXlbOp4Uun0zl0PVgz?=
 =?us-ascii?Q?wS1d00lfiRL76p6GnNQfZqAOzEANs9BpOW+LQrPOfAcHS8vQzU0diO5nilOR?=
 =?us-ascii?Q?Zl3d2SzXz5Nxa/VFmPVuBCAWAzWpHYZ3hXeO6uKT2utt6oWazs6VAWTwrfW9?=
 =?us-ascii?Q?E3tWvI8dqrpxcipbbacOK63CuhUpR7VyzQ44fGJTZuK6nxkZfGFdmGfzuvHo?=
 =?us-ascii?Q?W+ZsMcFqcLWa5fvhHnPKZtxBfiEdZA9F3LlwhV2m?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0db4c7c-a111-4bee-7b6a-08db3692ed60
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2023 11:34:48.0968
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fI/SVSnv9OIMJPmLAaEJMpSSU7WPgdNfc8A1/s7zrB/cAnyAEgp39Kdzqv8eKOe/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7221

On Thu, Apr 06, 2023 at 11:40:12AM +0800, Baolu Lu wrote:
> On 4/6/23 7:38 AM, Jason Gunthorpe wrote:
> > diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> > index 8623d3edc61014..5f6aecfd92c657 100644
> > --- a/drivers/iommu/iommu.c
> > +++ b/drivers/iommu/iommu.c
> > @@ -91,8 +91,9 @@ static const char * const iommu_group_resv_type_string[] = {
> >   static int iommu_bus_notifier(struct notifier_block *nb,
> >   			      unsigned long action, void *data);
> > -static int iommu_alloc_default_domain(struct iommu_group *group,
> > -				      struct device *dev);
> > +static struct iommu_domain *
> > +iommu_group_alloc_default_domain(struct iommu_group *group, int req_type);
> > +static int iommu_get_def_domain_type(struct device *dev);
> >   static struct iommu_domain *__iommu_domain_alloc(struct bus_type *bus,
> >   						 unsigned type);
> >   static int __iommu_attach_device(struct iommu_domain *domain,
> > @@ -444,13 +445,16 @@ int iommu_probe_device(struct device *dev)
> >   		 * support default domains, so the return value is not yet
> >   		 * checked.
> >   		 */
> > -		iommu_alloc_default_domain(group, dev);
> > -		if (group->default_domain) {
> > -			iommu_create_device_direct_mappings(group, dev);
> > -			ret = __iommu_group_set_domain_internal(
> > -				group, group->default_domain,
> > -				IOMMU_SET_DOMAIN_WITH_DEFERRED);
> > +		group->default_domain = iommu_group_alloc_default_domain(
> > +			group, iommu_get_def_domain_type(dev));
> > +		if (!group->default_domain) {
> > +			ret = -EINVAL;
> > +			goto err_unlock;
> >   		}
> 
> There are still some drivers that don't support default domains. It was
> allowed previously, but above seems to change that behavior. The
> iommu_probe_device() fails now on those platforms. Or perhaps I
> overlooked anything?

Blah, yes, this is fixed up in the next patches it is an artifact of
trying to split patches up. Let me think about it

Jason
