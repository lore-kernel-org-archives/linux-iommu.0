Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2077.outbound.protection.outlook.com [40.107.92.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2A4C79C6;
	Thu, 30 Mar 2023 15:36:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L3Hur7rhsFmjQUnrEt9PRZBksE3m5OXH3oLT/bg1abYz9mBvxM2u20azoQaIETqaTcdC1pVLc7XRH6RcvpqRYBEkyDoQBodevDQExwxsa0m9coNK+3N4ocVUCi5VDmOi/CsW9SuLI39LywPGH6wiB7Pi3yF6NNPgeYSk4ip9IZbDkrvfGkO20IRQEStUJAQ2UEqHIeNolqfQcs1pZhhINe3L7Gi2Yf17v8R0xo/l9LuvLN92WdhFDlupk368hJqpgTsGWqvWrxp0XN7JCsPOMtYAOy5y3bX4L3+kdfN8udaeRDN0h/LqjsG93rdPryGRl5Qockrs+0GbCNehuNBUyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OPeAnOcsxhIT0qoEmUdbcpLY2vwk/QpHI+DK+nWypyI=;
 b=Po5DrHKnxkDrt3zKbI/m04ShtQocA4FoagM6macud4pSjrMP8PhbaC7Y4VaBXEpvulLYWn02UhOva+kPSZH5IniJ35UjcR6Ph45D/c6oQL2Ya6D1gIpHn+TLWI0tMfS83+zwt6Mj7aS6wYjIwRwG6H0SYBojhi7DWVVpm6Eklqcomg0u8BUFcN/u4BaEuk086bx0+TCrNdWZ/s0OrKyaKoCm8aOQkgN+pHaH7CeG4CPjfAvvFL/Ef3THyx2lxLJM/wUqYg6OOwPUBewzaMFSxtWvM1ia+YtNCv0SayZR7b9/i4TdHcyhwUqtPNqPYItBgiOlwnsj0awIciZPM1T43Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OPeAnOcsxhIT0qoEmUdbcpLY2vwk/QpHI+DK+nWypyI=;
 b=gvvoZmnOCkFLvpJpdWYET7d0T+IkJCpHMZP/80GYiLWykH39BUmkbHFU1QJkI1X43fT/yXv7itFXTjtX0ieWS4jP+/8HpNoKaFAt11zOcg/An/xJluXd4L6GnMJl4Izc9ZzMzoosW8qU45FYT1uB0TOqAMzX89sXEzZseHTynXrHi1Y8TyMS9R7GH0uhl4Rq9kdX1KuNIfoqcpw2I65B/pOlWpUdOhfH1JxJ4BuBEIucTGOJempw8BcsFnQ7Na4YXgSBxNGTPH/GxF3dMV859d8ZxoT4P0/2uWeObtj27QXXT63nPK3iGw0h9wbSZJa51yroSWY1uG96TkhZsalb7w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by MW4PR12MB5666.namprd12.prod.outlook.com (2603:10b6:303:188::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.22; Thu, 30 Mar
 2023 15:36:23 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1%3]) with mapi id 15.20.6178.037; Thu, 30 Mar 2023
 15:36:23 +0000
Date: Thu, 30 Mar 2023 12:36:22 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
	llvm@lists.linux.dev, Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, Tom Rix <trix@redhat.com>,
	Will Deacon <will@kernel.org>, Kevin Tian <kevin.tian@intel.com>,
	Nicolin Chen <nicolinc@nvidia.com>
Subject: Re: [PATCH v2 12/14] iommu: Consolidate the default_domain setup to
 one function
Message-ID: <ZCWsdjM/21IPvjKi@nvidia.com>
References: <12-v2-cd32667d2ba6+70bd1-iommu_err_unwind_jgg@nvidia.com>
 <19197c52-139e-c3c5-2771-42323d38c045@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <19197c52-139e-c3c5-2771-42323d38c045@linux.intel.com>
X-ClientProxiedBy: MN2PR19CA0003.namprd19.prod.outlook.com
 (2603:10b6:208:178::16) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|MW4PR12MB5666:EE_
X-MS-Office365-Filtering-Correlation-Id: b915572f-1776-492c-8eb6-08db3134845e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	gnvtBJ9RfY0J/oz0fpubIyYSWGRAhvK+QdSQtaRfmgdit2zqNx8rklO9Aiw7q9VIbhlT/MT3taI4SbqhG4NyDd01cdRAKMJLIFeO6kcDXOQurD3BT6Om8S43RwoinLUGJdGWQ/CmXIdFI9rovIM365M/85ZntKo+8MjLsaMsdFh/QNyVo4/efDnABWxPoDOf6xpkZ0F36Zv19jOY+1VKwVbiS8R8U0UKeI8iGEwKSxhGn86qM7pa+vQYvymYHRjF+/60KjbUqyU7ItkFU29nmjXyxUrOV9ZCfQFzHrwoJgbec/rnNPCqI5ZmlJm6f2PKrhjmikcOAs9SuxZeHh7sJu2U7Kl7PR4AVBnuhyIBqmSvMMy+1y0YpBWj/zF8co1hGY5ktyZCw3RiStNsqAB8mMYMgrZs+fVmX7BBLibxrcmPzhdg3B8GiCbEo/uvXOYDEstZlb73+NjMsVpxw92lit9H0vSM3+f5kfoleN6lnR2rw12Pc65ce5GKuK4lvkk21A/e3SpTge39Kav/8t+rqFj6ydeDFeQ3cbVJIrJqs3jVX5vjWuggjZhv9sQV9job
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(366004)(346002)(396003)(39860400002)(376002)(451199021)(36756003)(6916009)(38100700002)(5660300002)(8936002)(7416002)(4326008)(86362001)(66946007)(41300700001)(66556008)(66476007)(8676002)(6486002)(54906003)(2616005)(83380400001)(53546011)(107886003)(6512007)(2906002)(6506007)(26005)(478600001)(186003)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?F671aJZLEHiCsyJuBvn8ZD7uDJraaS6WSHfiHe9oYsIi5rbJq9YXjr32hIUs?=
 =?us-ascii?Q?MCNmPobmBAGyiV7hzXB5BACR8T68CxSjV3etQkG+vnGPDHLJbyK5+YyXhL8E?=
 =?us-ascii?Q?6f8f4M/MbmWJU40ldO8y3X/WNG9L2GYaEzkGALmi1F9BWOVxckb9yk0+T2ni?=
 =?us-ascii?Q?8gHesKxe3bI5/yyC/pF0xLxGcwfG2I+v0TMVpvkUGI6/Zl9lnVgjUJ3ddkuM?=
 =?us-ascii?Q?AZ7bNLVX8Fp/t0v/p52h17/uzcW9ZOWFLhLM85wdBIv8S5JxhTnmkIgtJ2tM?=
 =?us-ascii?Q?zcQrnuu2g0AUKldOt8PQYCfTdo+pVrEG/kEp1odFhIsGJ/mvEmvXGVzrPeu6?=
 =?us-ascii?Q?py/eXoiZXSXdfiY9q54yfReu7n2bDhYyLPyo+WduCUwo3Tq+/8kf4AvCMMdG?=
 =?us-ascii?Q?vOA/IXBCuSVhtYGuLBwaUXKEJL2CfZPFtmFBg+he1WFnfMYK6AKe0woSBz2D?=
 =?us-ascii?Q?fYVHrg8DyVdoMXPxt8uEin5RKkiUHoeAQX6vZDre57eGpCmzQeC1Vwy3TNqq?=
 =?us-ascii?Q?TGjZXInqFGnwDZGvnj2aqDxWq8t5HP3+zO79smP7hvd70TQHKZlfXLX3vK2m?=
 =?us-ascii?Q?AKmayYtu4nqPdkWNzH9AJb6mZAA0d8DkWIt5DeK4m+tm0y3seFpQcQE9bikS?=
 =?us-ascii?Q?MfPDlMGebaCHeWhkr88nl1a4RdrO5ORUP5ybX5P4qN8YXkl5Byy0UJpGqxHZ?=
 =?us-ascii?Q?auv3+a6lVx4UoKEAnqHKRNiZFK898T50y+oeWomBdOzBcxH0LwQh+ttx21yN?=
 =?us-ascii?Q?iVbQcVNIAet5SaoAf9T5JEChyHALyeChPq2bTsJdKpcMhh3jh9iBqY6pm5lZ?=
 =?us-ascii?Q?+A/06jNSkHDCiCFtWH/o2qoTs+XlcT7zPCHMN12ST2yiPpDaHfooi9raLkTC?=
 =?us-ascii?Q?oAwIR3xWuPqgg4EwbZkJLWC2qpirrP6QcONSzRN7Vlodtm4tGOKrLA7hB33U?=
 =?us-ascii?Q?1uLgVM9IrOeNEC3EYFZ4dQTkVx4EbY+z6cRbxzcKcnAkQ0scTS3tflUkGd04?=
 =?us-ascii?Q?oGoVijUGO4yj0tHGC5fQCR+u7NSiAsLB1sa7W8kSOlS+NT30XHyXxvnXniS0?=
 =?us-ascii?Q?aquKDLfapnsfv/YAH7hRW+gdznL7fgHNFrNQ2Ss7Dl8WsCMIB3hRL0nP276h?=
 =?us-ascii?Q?VvqeLSAi1OK74YDzzJB6GyDoSNJWcm9UxdK57tFjGEg74fbM+yfDEkuvLQhZ?=
 =?us-ascii?Q?scKVeK+h2BJlcbhfluF+VTX8IZ7XW9Yhiy63fLuyNreb9o/tMEudj7O/uOwH?=
 =?us-ascii?Q?xjz9eDPo4mlG9/cumCBr/Xf9C4nBXo9wO83KuLcy9OpbMgwFLnAdL3VvZHl1?=
 =?us-ascii?Q?HCOld29F2h9AO0UaX0O9Vq1A0zi4TTFXFk4Th6AZe/pbKz7mfAYzbub7sXb+?=
 =?us-ascii?Q?shGu7oTDujkget/QP1bWOTTfwhrzO1grWr2s7GIrwjLvQrIrAsO2eXkiFDY+?=
 =?us-ascii?Q?dIabcx5+kGN5knI17YQ6MpHP1bf21CQm7fHGETEkaR6Qip0YclGoY7Yvz8f4?=
 =?us-ascii?Q?ZXIYgYC+yg0xROLQTJ5MiHWm471BY0gHCsoEZozfNdyXgkkoPQ1LTH9Pqx2c?=
 =?us-ascii?Q?GiphQVkA2HYs0yljmxNuq30iFeDK+CEkVUbcJpwU?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b915572f-1776-492c-8eb6-08db3134845e
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2023 15:36:23.3625
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oy3eRxKZW1LFms2xI3eTQ3KuRoHalZ01XrgLjpNGb5HlFL7Z3goH8oSK0NOEHzjK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5666

On Thu, Mar 30, 2023 at 08:37:16PM +0800, Baolu Lu wrote:
> On 2023/3/30 7:40, Jason Gunthorpe wrote:
> > +/**
> > + * iommu_setup_default_domain - Set the default_domain for the group
> > + * @group: Group to change
> > + * @target_type: Domain type to set as the default_domain
> > + *
> > + * Allocate a default domain and set it as the current domain on the group. If
> > + * the group already has a default domain it will be changed to the target_type.
> > + * When target_type is 0 the default domain is selected based on driver and
> > + * system preferences.
> > + */
> > +static int iommu_setup_default_domain(struct iommu_group *group,
> > +				      int target_type)
> > +{
> > +	struct group_device *gdev;
> > +	struct iommu_domain *dom;
> > +	struct bus_type *bus =
> > +		list_first_entry(&group->devices, struct group_device, list)
> > +			->dev->bus;
> > +	int ret;
> > +
> > +	lockdep_assert_held(&group->mutex);
> > +
> > +	target_type = iommu_get_default_domain_type(group, target_type);
> > +	if (target_type < 0)
> > +		return -EINVAL;
> > +
> > +	if (group->default_domain && group->default_domain->type == target_type)
> > +		return 0;
> > +
> > +	dom = __iommu_domain_alloc(bus, target_type);
> > +	if (!dom && target_type != IOMMU_DOMAIN_DMA) {
> > +		dom = __iommu_domain_alloc(bus, IOMMU_DOMAIN_DMA);
> > +		if (dom)
> > +			pr_warn("Failed to allocate default IOMMU domain of type %u for group %s - Falling back to IOMMU_DOMAIN_DMA",
> > +				target_type, group->name);
> > +	}
> 
> The background of the code above is that some ARM IOMMU drivers only
> support DMA mapping domain and do not support identity domain.
> Therefore, during boot, if the allocation of identity domain fails, a
> DMA mapping domain is used instead.

Er, this is doing two things then because it also allows DMA_FQ to
degrade to just DMA..

I changed it like this:

	dom = __iommu_domain_alloc(bus, req_type);
	if (!dom && !target_type &&
	    (req_type == IOMMU_DOMAIN_IDENTITY ||
	     req_type == IOMMU_DOMAIN_DMA_FQ)) {
		dom = __iommu_domain_alloc(bus, IOMMU_DOMAIN_DMA);

So the auto selection only happens if the target_type is not automatic.
 
> However, this does not apply to use cases that change the default domain
> through sysfs. In such cases, it seems that we should directly return
> failure (-ENODEV) and tell the user that the iommu driver does not
> support identity domain.

And with the fix below it will return ENODEV rather than autoselect DMA.

> > +	/*
> > +	 * There are still some drivers which don't support default domains, so
> > +	 * we ignore the failure and leave group->default_domain NULL.
> > +	 *
> > +	 * We assume that the iommu driver starts up the device in
> > +	 * 'set_platform_dma_ops' mode if it does not support default domains.
> > +	 */
> > +	if (!dom) {
> > +		ret = 0;
> > +		goto out_set;
> > +	}
> 
> Should we call set_platform_dma_ops here?

It could be done and should be harmless, but the driver is supposed to
start up in that mode so don't need to explicitly enter it when
plugging the device.. I kept things as-is

> The existing default domain
> (if exists) will be freed below. But the iommu driver doesn't know about
> this. It probably will create a UAF case?

This is a bug:

	if (!dom) {
		/* Once in default_domain mode we never leave */
		if (group->default_domain)
			return -ENODEV;

So default_domain is either NULL forever or set to something forever.

Jason
