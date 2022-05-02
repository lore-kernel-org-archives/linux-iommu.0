Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01EE4C433EF
	for <iommu@archiver.kernel.org>; Mon,  2 May 2022 16:42:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 962BC81CE9;
	Mon,  2 May 2022 16:42:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Lx4VBHZ6BZEO; Mon,  2 May 2022 16:42:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 444EC81D11;
	Mon,  2 May 2022 16:42:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 13D9AC0039;
	Mon,  2 May 2022 16:42:25 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 72482C002D
 for <iommu@lists.linux-foundation.org>; Mon,  2 May 2022 16:42:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4A36B81CE9
 for <iommu@lists.linux-foundation.org>; Mon,  2 May 2022 16:42:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SvFDccJZlgn4 for <iommu@lists.linux-foundation.org>;
 Mon,  2 May 2022 16:42:21 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20604.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eab::604])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8FB8781CBA
 for <iommu@lists.linux-foundation.org>; Mon,  2 May 2022 16:42:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IcmfdJzKhHz2We+4x54QyOXXOv3Qo2pN5WarYe+MtQEq0N5xyVKwt+bkS0GurP3ZjP0gMnYIjPC1xwy4rOQvp+jiydAPtlhwp6VAF9lmw6dQc73lANniGAnHkIOiuYZ4vcUEMY9Qbkw0ylNakS1V6sEHy/t50zeQ5V6oZYDIYjr7WJLR1hxwUx6wr7RkuOnb3H4eqYu/vxxTEog8fmP6sTErMpaZtIdCfU5K0KbLO1jNt2MRhLaowIfDgBJ07xiz1El7AZnIN/an2xJqCa4o44zoT2YOJmdpSFM720aA4YmdhOhX5KR10tAoMn7B6TZxG8MTi5cFv2jknQHwYFr7jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5cagTUnb4DWRQfEc7s5hpPOtMUJi94V0C4C6XmnX2Qw=;
 b=NnLdZ3rajErV6CYvAD619g/kGfW7ltAWx316qJG+DHxhM6Gz/CdXPe7BHoP0l5IbgEpaq4B19W8VyWgb7p73KBxWqN0T+x0LOwI/uuY6zVel7iV/ewoGR/ZQCNaD0ZYZMDRUmjl1YxgqMPhDtyPtJnC/YeO5VmH51RE/dg8R3gml0CstqUxRu+Fr1AiUmt8pGotj4NvJpJ6D8pcpLl6ncMQltVu3IjANBblXVbn7AMKSoBLrne0XXTk0loBlahtIKRdNJDvCqyw2g7LbiK5UxHdLNXsCEv+SEOL1nZlw27EQI1pYelMFAy+Lb57yRxugFVSWeX9EdsDrO7z8Zztf9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5cagTUnb4DWRQfEc7s5hpPOtMUJi94V0C4C6XmnX2Qw=;
 b=EHxyaslXS8ZdR+IbdkjA/X0YuW+rY0DC7doWPLWRvi9Hvhw9N/ITu/blpcyn7IZY5B9GuyU9VzTS/Roar/uuwrSUbDwFjNSPrY0uLfEKl0TpXgFKaI/8oy2swqIzKwXV6R5Ne7R1/eva2JxHpQ1y4h3bp5Y8KCCahqIaw/6vzblt6AdibPOBZ7tZAOjE6DPA6o4d6nA08w13syaJ9YHKsUo3lLCakW8vOqIbCHbQ+08V8n7T3sbXlz+jrKr0eA9Rnh2gaVGaT2DB5Xmjz+Kmurk79Xk+qQyCRG4bJyuFzb3JWSKrMYSmHKZwshXVNaBH41siVmAOufCcbx61qKUc+A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by MN2PR12MB3181.namprd12.prod.outlook.com (2603:10b6:208:ae::27)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Mon, 2 May
 2022 16:42:17 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ec2d:9167:1b47:2db2]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ec2d:9167:1b47:2db2%6]) with mapi id 15.20.5206.024; Mon, 2 May 2022
 16:42:17 +0000
Date: Mon, 2 May 2022 13:42:16 -0300
To: Qian Cai <quic_qiancai@quicinc.com>,
	Robin Murphy <robin.murphy@arm.com>
Subject: Re: [RESEND PATCH v8 00/11] Fix BUG_ON in vfio_iommu_group_notifier()
Message-ID: <20220502164216.GP8364@nvidia.com>
References: <20220418005000.897664-1-baolu.lu@linux.intel.com>
 <20220502161204.GA22@qian>
Content-Disposition: inline
In-Reply-To: <20220502161204.GA22@qian>
X-ClientProxiedBy: BL0PR03CA0015.namprd03.prod.outlook.com
 (2603:10b6:208:2d::28) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0e6128cf-1e93-4fe3-4dff-08da2c5ab7d5
X-MS-TrafficTypeDiagnostic: MN2PR12MB3181:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB318157CBC2F3F6D7B823646FC2C19@MN2PR12MB3181.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: za3cDZlOwwfAbCiSnvwRfRbylCvn5pLNIkZ04CRK3PQP9JhF4hOLe4vNhaHcP4tSumioltMs8XhrNLBy4R/Pg9XXkLGFIWw6qLD9fwbcYwMXafTYdYeBQLVHxdmMAYEfswzVHi3bwW5B9W2zoyKlzhBLlFAvObqsSXjdwc1eXdy36aD4OrmoZXs15ZXEmkMpHcRvTtvKIJsCs429IGeEUX0xyOn4QLvtHWQFkuKzZgkCjUE0TM0rBzdq1rt/nAyo/ZC+Cob3FYJbcLiJLE4XlMhD+cCFwYg8rj9ahqhzQs6vh1IHTs/90EXn49rGHMLK5jP/l7PT4/evNyckf0E5YMvvTjp+YkrruUMtiewhz4txa6lFt+YUnOvYfmo+Lv2/HVyaE+gZZ/QT9q8vWIwbUbX31XgMdto4rCkc0mAahnRKqk4nP+/uA1FmvvZGGxg0VhwFuV6SsoRlZl2pEExkqyDzkl5am7Durovqqx7hsxAzh8ttQZzV6WRfSZ0ncJ/S8PQIDwvZpzIQWR8MYMX1hgy7ym5qrdu0cshn0uzHrItACllqzNHfQf9bnUspyZSEi+UHKZdDYJWo7+ad5qL6fD0V+scWvWSoTJw+/i9UPfpVnho2gzUw3lbG8hekOvmT0hVxNt0XMZxBiRb6T5nejT0cYl5IhqDxUTtmMxevG9dvVlnT48fjLvHWe54oNx4+abVn/ZdYXvCyi455OxGQaEpcacJ070hmXmh4qI3MUj4JWmbg9ZDGfg4LEUJefvi/aiUq9yo/RXMqOnAPz+anJw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4192.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(4326008)(8676002)(2906002)(26005)(66556008)(86362001)(66946007)(66476007)(36756003)(316002)(8936002)(33656002)(5660300002)(38100700002)(508600001)(966005)(2616005)(54906003)(110136005)(83380400001)(1076003)(186003)(6512007)(6506007)(6486002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dv+24AJaZl9d0ayJoBk9Y16+SHMJx89om71dL4QDZzlBQsH6qBFNI5bFhcGw?=
 =?us-ascii?Q?UUIyOeLuZhbYNvGMVBAuPC3hU4yWeE34oqaGWqJAjlEWIqERoLozeUZvAb4x?=
 =?us-ascii?Q?UahCILmRhp67mP+SJm5zMonuvB9wMhEqrKrcyrhnXwFVCqhGw3jSiwbIqbDu?=
 =?us-ascii?Q?BQ+dx10KHKnx9vydiTVNI9NBRrRWjBZYuh9cQ5yaKm4gk8I9jJokQrd8K65X?=
 =?us-ascii?Q?fhWwHzf73AfBBcXIVPxk9hUckX1W6p/h9+7+SuWKVC6EQ71oQvlnEbiALegw?=
 =?us-ascii?Q?Edxa90U4dM83UUKpZKegonLo6w8fosM5+yxGioRfU7yeZQe33h0CtDBk0L/3?=
 =?us-ascii?Q?i1UvJsIBFDszMVjGHTUq4HmDLDJbU2rtTVy5D41ZqW0x8yUrhDHCQvVG137J?=
 =?us-ascii?Q?FVZCbGq/hzymUt8X1+KO9oA7namTs0Na5JYi1U+311bDpZ6ePG6ygApgnUTM?=
 =?us-ascii?Q?n5ialNmIVerqPmyZmr3yN5CBjTPBusycwbGuYkxtYRRTxViATZkz+tEYH0gi?=
 =?us-ascii?Q?kG0QR4vSvcMtTzKI3T+N4kEZVHpbYMS8ZbjRZIRPQCNpcieWAX5sRgMhY0Ni?=
 =?us-ascii?Q?czDDcUfN/RTsdMeWHC0FsBZaUT3f6V0pWQISZCAaB4yOeA+eeSuMXkmekSt5?=
 =?us-ascii?Q?1C6ZB/H/09WIm/vNFNgcdzyB/hjr4lFGn5mw9KjQzsT0l+7kDfTpF6Yg4ZI1?=
 =?us-ascii?Q?m4TArZj+sZuyhDllvweaGHNHNZSARQp4lparTSJqkHvjB+G998MlhX3EnbM1?=
 =?us-ascii?Q?sV5j88PYrUJQwe7etCsq97QYQhvcY/IBtAn6ocwFnhSeTEbIc/FEl2XZnfnK?=
 =?us-ascii?Q?deSOqnU+lcUOzok1KudyfeAneJvPSR7xCj2Xzi9oQ6lglVCgr/YGZUAI/F33?=
 =?us-ascii?Q?HBmwc+fUiSPMsH/5bdtbuT3GE01EBckqVX0udF7MdgGq7MWCznBcnDiQy4L9?=
 =?us-ascii?Q?vWiQWF+HFNFvVHpEChOD6JTa+riWsncT4rYmHVU/65n6CShApmWQh+sSxzZN?=
 =?us-ascii?Q?Fm5RL6rGWcY2mvB31Q9xbmUfqWoY6ikjFwmbT9VgHcB976opDCStd1LlJgsM?=
 =?us-ascii?Q?6dWGBFn9PrwLGzMn2iVbxdLmGbCfb5YrqYuQttqq43g90OU+MshATv1wWfxS?=
 =?us-ascii?Q?fNnTJm3X0BJ6O3+BA+u7S6JaldlZ9L+ZtVmkY4LJuEhoo2DKZ3YUXT13lNZI?=
 =?us-ascii?Q?gE+geuWiDSCA+5WSdlpseO3UuNxtw870MZ9UE6DLHcxi+/3SMK2ItriRfqpu?=
 =?us-ascii?Q?8ZiekuU+7gQVxTj79e2N0jUn6N5+Q/hv39YdnFY8s17LIOvM82sBUNQFBMw4?=
 =?us-ascii?Q?zP1Ioe6XYNbPF32UtR01fReCmzJgRQxC12jQi4nhrJn7vGWMA218vhTWa17O?=
 =?us-ascii?Q?hnMaqgo/982Nl5U1r5My4T6Wi/j0URcbZUwX4f8m29S9SPOrTvNPMDrO57lk?=
 =?us-ascii?Q?pq9SmEpw+TWqOn4OxZpzWcp+SXANBQ6eEdjpAraCGxJVrBQmf2XPz58i7B/N?=
 =?us-ascii?Q?QMbIuapa7n5kAK7NlnEXXTQGgWz3PfqQ8igP/F0b6PnT0b19+WF3JfnPuD5J?=
 =?us-ascii?Q?EMT++AxQ2gYpnACFpWtYQGYFYYdUca7/SlzAgIblajh4eo13zXtjPXp8yy+m?=
 =?us-ascii?Q?6IVogneDpkMKZHq4XNFvRd2jGIyzN7Jxdmr6Tdq2FmFpFXdyOEhpUE4yOw5l?=
 =?us-ascii?Q?CigIFxo1/j3CN/gRkXVBPwVHdpz6mV7GTyZyaZ8mNUrYAD8RU+1O4Nwwp1IO?=
 =?us-ascii?Q?zJ8ujqJOBg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e6128cf-1e93-4fe3-4dff-08da2c5ab7d5
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2022 16:42:17.5483 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r4ymuEFyjWndE6MYivYiP4CLJC9nBidYwGy9kqM8PIniNGa/JXvNhArU+QE4qyT6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3181
Cc: Kevin Tian <kevin.tian@intel.com>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
From: Jason Gunthorpe via iommu <iommu@lists.linux-foundation.org>
Reply-To: Jason Gunthorpe <jgg@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Mon, May 02, 2022 at 12:12:04PM -0400, Qian Cai wrote:
> On Mon, Apr 18, 2022 at 08:49:49AM +0800, Lu Baolu wrote:
> > Hi Joerg,
> > 
> > This is a resend version of v8 posted here:
> > https://lore.kernel.org/linux-iommu/20220308054421.847385-1-baolu.lu@linux.intel.com/
> > as we discussed in this thread:
> > https://lore.kernel.org/linux-iommu/Yk%2Fq1BGN8pC5HVZp@8bytes.org/
> > 
> > All patches can be applied perfectly except this one:
> >  - [PATCH v8 02/11] driver core: Add dma_cleanup callback in bus_type
> > It conflicts with below refactoring commit:
> >  - 4b775aaf1ea99 "driver core: Refactor sysfs and drv/bus remove hooks"
> > The conflict has been fixed in this post.
> > 
> > No functional changes in this series. I suppress cc-ing this series to
> > all v8 reviewers in order to avoid spam.
> > 
> > Please consider it for your iommu tree.
> 
> Reverting this series fixed an user-after-free while doing SR-IOV.
> 
>  BUG: KASAN: use-after-free in __lock_acquire
>  Read of size 8 at addr ffff080279825d78 by task qemu-system-aar/22429
>  CPU: 24 PID: 22429 Comm: qemu-system-aar Not tainted 5.18.0-rc5-next-20220502 #69
>  Call trace:
>   dump_backtrace
>   show_stack
>   dump_stack_lvl
>   print_address_description.constprop.0
>   print_report
>   kasan_report
>   __asan_report_load8_noabort
>   __lock_acquire
>   lock_acquire.part.0
>   lock_acquire
>   _raw_spin_lock_irqsave
>   arm_smmu_detach_dev
>   arm_smmu_detach_dev at drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c:2377
>   arm_smmu_attach_dev

Hum.

So what has happened is that VFIO does this sequence:

 iommu_detach_group()
 iommu_domain_free()
 iommu_group_release_dma_owner()

Which, I think should be valid, API wise.

From what I can see reading the code SMMUv3 blows up above because it
doesn't have a detach_dev op:

	.default_domain_ops = &(const struct iommu_domain_ops) {
		.attach_dev		= arm_smmu_attach_dev,
		.map_pages		= arm_smmu_map_pages,
		.unmap_pages		= arm_smmu_unmap_pages,
		.flush_iotlb_all	= arm_smmu_flush_iotlb_all,
		.iotlb_sync		= arm_smmu_iotlb_sync,
		.iova_to_phys		= arm_smmu_iova_to_phys,
		.enable_nesting		= arm_smmu_enable_nesting,
		.free			= arm_smmu_domain_free,
	}

But it is internally tracking the domain inside the master - so when
the next domain is attached it does this:

static void arm_smmu_detach_dev(struct arm_smmu_master *master)
{
	struct arm_smmu_domain *smmu_domain = master->domain;

	spin_lock_irqsave(&smmu_domain->devices_lock, flags);

And explodes as the domain has been freed but master->domain was not
NULL'd.

It worked before because iommu_detach_group() used to attach the
default group and that was before the domain was freed in the above
sequence.

I'm guessing SMMU3 needs to call it's arm_smmu_detach_dev(master) from
the detach_dev op and null it's cached copy of the domain, but I don't
know this driver.. Robin?

Thanks,
Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
