Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2048.outbound.protection.outlook.com [40.107.220.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 140B22F5B
	for <iommu@lists.linux.dev>; Wed, 17 May 2023 16:42:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DRRdkMaLyqUCX0ianh8vkAmTteWMCbARgNvDcnlfRTb+izPsG5+DYsRuM8jinDO60uQU7TLadm24gW4yR0G+4+hz7kNTpCNE0uQeae9xn7twAm9lGxNq2i5uqkmiBx3Drb1W4nLxlenGPiLdWX7a0JsP1JZRBR+sBo8qI2t9W4gVtzke8T1rG98sYwG2YVqEln+C1jFfyjhtD1PzaFqCT6FHizQj6NugUHyPJV572o0RWHBhLv7PUBGywQhUFdkSxDEGmsEumWO8uDPsAytVgvkkDrnrk3svCopOo42wWue1z5/6Iv84hc7k3UIXIB3qEMsaFXAyPbPq9IzcYXleTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YZmAEiLt9BbGfZJn3vO6d9yz/DPdC6Fo4hpOQXxr/c0=;
 b=YCi5L3GN8uIcl9VL+rRRvY2mal2ToVOGlZFzp9rj9700SjjNslcl3sYTk5xAK/iqwPUFVX4DyKwKMHRmhCvR6dvEEXTkPlq6z5by+iVRvaYla04cqkZW5ifgxf3GKK2wxSOxQ8d4DUOjHr/dhVgbvBzdSIdk39t+mN5D1LHLv9RuQ96ee81C72811vdLDxrDFa+d9r7lOMhtdm1A0syvF6GICCL5NkdJu1BofJ2JEo8skvlDYw0bHOOIEe7Y58DvMXzIuLgWhK/KulE47CTwQxelbgxhfggDJN5ONvO54qGPahov2MSpkZ15jnxtfj5SvTkM48Iw7K5I6TBopJcxoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YZmAEiLt9BbGfZJn3vO6d9yz/DPdC6Fo4hpOQXxr/c0=;
 b=NTu793/FPerVsLWUPo9esfL+HTwgnrGoAdRmsYjNrM/UQ18dfzSTIokvZZY/35eyDBYu2ZzxNiI/hdEsoWAEByyuIVqlK0s5s/wIUwXOfKH8ukNTEfbgvICAVSghgDJsmLTfb6wvf08SYsUnJI4+DvFlYaHcprmeqvKstGdbKQOGwCp8pDGx1MJi8feoTNZ4SMd8V+L+Cvn388PPorBRSkbUKeBwmymg4VYAHW8Nyx9wzp5vHx3dw+8Z6uk0pGc4KuIdZ1Ln6s+KSpqM24MOeMuUoUbpLWTykkj2H6q/gjXbhXaVCO4mQpmqcc+H6rirHVnUU98IlNGbx+9oUKameQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CY8PR12MB8411.namprd12.prod.outlook.com (2603:10b6:930:6e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.33; Wed, 17 May
 2023 16:41:59 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab%6]) with mapi id 15.20.6411.017; Wed, 17 May 2023
 16:41:59 +0000
Date: Wed, 17 May 2023 13:41:57 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc: joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
	eric.auger@redhat.com, virtualization@lists.linux-foundation.org,
	iommu@lists.linux.dev, akihiko.odaki@daynix.com
Subject: Re: [PATCH v2 2/2] iommu/virtio: Return size mapped for a detached
 domain
Message-ID: <ZGUD1efvOttujDPp@nvidia.com>
References: <20230515113946.1017624-1-jean-philippe@linaro.org>
 <20230515113946.1017624-3-jean-philippe@linaro.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230515113946.1017624-3-jean-philippe@linaro.org>
X-ClientProxiedBy: MN2PR16CA0017.namprd16.prod.outlook.com
 (2603:10b6:208:134::30) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CY8PR12MB8411:EE_
X-MS-Office365-Filtering-Correlation-Id: 9301adbb-a087-4af1-6982-08db56f5a260
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	6N2XLZ8FV2C5TkiHQn86zOjU6mcwmTHKVFoZhufA3IVykm2JmskkChL4U2JeFoRlmMmQLg3fWi3SAB6FN8/8s/DMS7kGDt/+/ALIQD2byh6ZVt3qRl5hf7CJSC34dVkFK+2QijFwCl3LMO8aDF0zpMjEd73SBHsgIAuOH06/DHEWSOzlo9eMxUvnd2EC5yZCCu3MwPfZjX2DXgBEcuPsnN6snoaspS1RxghEp22fJ+bW84IyoshS0vnUKZKKLNb9OJ9w101ht5X7JWnb3XARbWqKRAjyGpauYaxQi/eesjP25I1Zh2cK4sss7S5sLyVumBDjj37YKxZ5HH7RqDNqoUbS0Ql63RKEkiXhXrSc3jb7DgVeTBGLRIRxN91fsEmj40k5oPHzR3Smihty7yymKKYSpgdPfm6C9eyf2cE6KNx2oQyvJJkQs3UXIIh1QSoSEIXGRhP40r5hXjB9tdO0j0cnhFuixtbF7nVF4YvKn5IdoUpY07sjzOIkz0jCZuN6T/6WvMiVMaZzv6wO/rUX14GLO6VZvKjSnEq59aWgz/lfhU4jxo60EpGKgCH1SqLy
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(346002)(366004)(396003)(136003)(451199021)(5660300002)(8676002)(8936002)(2616005)(186003)(6506007)(83380400001)(6512007)(26005)(38100700002)(478600001)(6486002)(316002)(66476007)(66556008)(86362001)(41300700001)(66946007)(36756003)(4326008)(2906002)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yA0ussTn586nFQQLQh1SCscH0K3xBY/5gTIXx3kiOnBcR32yraaQiRNbqgmE?=
 =?us-ascii?Q?U2MjwWQrgD93jByP6ajs1NmtCj055YVggkGGt3dzJmyZtmao0x8WH8+tBMlJ?=
 =?us-ascii?Q?J3/QEWSzUQSnvy7E0TETSP5FBPJiQB2HJF0fByumKTPszWu/2A+0jp8pmDb6?=
 =?us-ascii?Q?3s7NYM0A923T3DYSR5IGYZ8GJCbK1syoYSaj71kBYvpeOOIMAbTohC0IbXsP?=
 =?us-ascii?Q?X4d2ZPC5wu27jKBrQ6HuHy996HlXJ1v578kAj3YcZzq+TC4QELzue2vUA0gz?=
 =?us-ascii?Q?nyF5evlhzbT0qMftjoHPKASDgrgGUHa7JxLHmFz5bfXxGCiEW2h8E2dsZfas?=
 =?us-ascii?Q?spwkbf3c7GjfpVoSdcL94VsQDWSnmzTuMjm27S6BhGjtP2lVkapv9ERoDigW?=
 =?us-ascii?Q?q0fYRVfRJU/fgZ3a0vNF8QTPO+51bkVnRfQuwNdxvajGMb4bMosn8rlrxln6?=
 =?us-ascii?Q?mGPDCNmnPnAtG8y+oJ9PznnQTQA2S4phRPcPUZlff2+Gc+dE07gJTKfc8Sbk?=
 =?us-ascii?Q?La5luAuWw7DNy7tNjyApD4aA4oBWXO6rCUWTvJOI32fXW45GAA8tfo2xWYrU?=
 =?us-ascii?Q?RiFbVq2UBddqVtyb/WnXvwN1XX2UosQsoO8k72UaJ2yIIgnfPKjMIpCADdzZ?=
 =?us-ascii?Q?XUov1KviuQMma29byzlmKfkoUH/u4DHtFrCnQElOpXvL8oqipeApcfjsXAKT?=
 =?us-ascii?Q?6WGC5Fp9gjALps7RL0OrURMYaHLHwn26d3U7UrpKLV8HnCfQnSPU65rksC9w?=
 =?us-ascii?Q?mEzc4ToeH5l9eaRzwd+iVNgRGhVJ5xVIOy6/b21VK0csRTWG3wj2uonLag1V?=
 =?us-ascii?Q?V8OBCnVVrCbtLGnuN9I1e2wjqU4q0kL5jJ9chz7PIxSUPLPouVz1d+gMm/Lb?=
 =?us-ascii?Q?qS6R0o8g7ohz6VMSJn75E6rSp0gAda91G/dQ4TEWp4sLrvkx/R9A2StUbNb6?=
 =?us-ascii?Q?QwgZkB6pgYROYBt2N3FN3SRxNBElLr2ddpsAM0zZxTz7VmL+lBTAlUEplZID?=
 =?us-ascii?Q?k1irw6cCr38YNuP5mSP6Ggd1Zlu3Z4fmHBcQ3CX0FhH/tgqTEOGVVnRKLEcd?=
 =?us-ascii?Q?wT/F1QTM3j1rWneE3UysY0i5eULYwP2AuX8/+hr6rJZbojlXyLYjz+8RK0K9?=
 =?us-ascii?Q?0f3sCVZvGACphaFAcOOuqHVjqf9dyEb1P/jKTkiR86uQWDQ6/DNDKNfpOwj+?=
 =?us-ascii?Q?evWwZM7/2Yi+xup5AqQqzwSxSP4QIYktsJpse24TqGIEMfjmW15jbNxUKy6a?=
 =?us-ascii?Q?EJlnNna2dBfilX/h2SJ9T+OiB6zl+UAI4OblJngCTr8CIXKV/ObysyEE5gts?=
 =?us-ascii?Q?4Ba4GVd9OuQf+NLRcZlff1N2XOMk9k/qds8lshC8TS3IaQQe2HsH4A0xIjvg?=
 =?us-ascii?Q?BI/xEVZsivBrLKVRNWfUG+xUbi7KhJPr9REHckhNhrfruToHMaxfQNzHtgIu?=
 =?us-ascii?Q?qCDBY6Rtqcks9gYUgpsm0BdAMZGuC2tMBix8iDUnDSUKYoe1yp5WoO8kd7dC?=
 =?us-ascii?Q?Mo0/CDoLupRhABaqiNK9e/6WyH2Sq6EJvBjlbgzIrMecBQL2IbH/5R2OyXtc?=
 =?us-ascii?Q?Y7ldDNCw7qI06/ey8Rc1f+5V+TZQE57GG8ETqjau?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9301adbb-a087-4af1-6982-08db56f5a260
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2023 16:41:59.5988
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T4Ox3ybZecg+HMnaN1rcL/FmN1OA2Q4+DZXTGZOLEog5KR6q6V0mXmT9wUpnjLcS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8411

On Mon, May 15, 2023 at 12:39:50PM +0100, Jean-Philippe Brucker wrote:
> When map() is called on a detached domain, the domain does not exist in
> the device so we do not send a MAP request, but we do update the
> internal mapping tree, to be replayed on the next attach. Since this
> constitutes a successful iommu_map() call, return *mapped in this case
> too.
> 
> Fixes: 7e62edd7a33a ("iommu/virtio: Add map/unmap_pages() callbacks implementation")
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> ---
>  drivers/iommu/virtio-iommu.c | 33 +++++++++++++++++----------------
>  1 file changed, 17 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
> index fd316a37d7562..3551ed057774e 100644
> --- a/drivers/iommu/virtio-iommu.c
> +++ b/drivers/iommu/virtio-iommu.c
> @@ -833,25 +833,26 @@ static int viommu_map_pages(struct iommu_domain *domain, unsigned long iova,
>  	if (ret)
>  		return ret;
>  
> -	map = (struct virtio_iommu_req_map) {
> -		.head.type	= VIRTIO_IOMMU_T_MAP,
> -		.domain		= cpu_to_le32(vdomain->id),
> -		.virt_start	= cpu_to_le64(iova),
> -		.phys_start	= cpu_to_le64(paddr),
> -		.virt_end	= cpu_to_le64(end),
> -		.flags		= cpu_to_le32(flags),
> -	};
> +	if (vdomain->nr_endpoints) {
> +		map = (struct virtio_iommu_req_map) {
> +			.head.type	= VIRTIO_IOMMU_T_MAP,
> +			.domain		= cpu_to_le32(vdomain->id),
> +			.virt_start	= cpu_to_le64(iova),
> +			.phys_start	= cpu_to_le64(paddr),
> +			.virt_end	= cpu_to_le64(end),
> +			.flags		= cpu_to_le32(flags),
> +		};
>  
> -	if (!vdomain->nr_endpoints)
> -		return 0;
> -
> -	ret = viommu_send_req_sync(vdomain->viommu, &map, sizeof(map));
> -	if (ret)
> -		viommu_del_mappings(vdomain, iova, end);
> -	else if (mapped)
> +		ret = viommu_send_req_sync(vdomain->viommu, &map, sizeof(map));
> +		if (ret) {
> +			viommu_del_mappings(vdomain, iova, end);
> +			return ret;
> +		}
> +	}
> +	if (mapped)
>  		*mapped = size;

This looks right

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

But your unmap looks troubled:

	unmapped = viommu_del_mappings(vdomain, iova, iova + size - 1);
	if (unmapped < size)
		return 0;

It shouldn't unmap something and then return 0...

Also, these days this driver be much better to use a multi-order
xarray than in interval tree..

Jason
