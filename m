Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2066.outbound.protection.outlook.com [40.107.95.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C40B3C8DB
	for <iommu@lists.linux.dev>; Mon, 15 May 2023 13:15:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oeZeiCnvOYDvp5THwwyrrh9ScKwcUFPfaC1Bw6z5zqWYNPpKlz53Ln5sPBc7WFChlhAxYWBknZ5KIFZoEWokaWOxqwLrnXjSn8WYlJVb9jAX2GgOMrV/wEiQyFzjSJjPlP9UNHL3STpc8BxE7YzPl/r7KMAScVqDpidz+9aRw1Vzym3OLKfqyS/cs41GG29qmCQiBxta/SxU1SCcXoBAFLMJblqw7PipcmGHwoFKMqMuRLBnzM2Aue6Ae/Sp+fK95MqdiUtsIMOX2Iv3BDusHN5Eg5oXKdtZswipZqKq5+WB/NTFx+GaHXde0LFlTazEr71mMneo7eO2p+kQ54ghjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qyUpS0bsF9aotS93XKkxk9JlTgVcOqHQEXxXoOhPTiI=;
 b=d+zJU2kaH4NJPYVv3obnMm4tS55Nct8zqOARoAn4YzamUhK4WvxwQvQ4H7owXbjLFVksGneFMB9wejWLnkHsXAP4G6f/A20NIIwHExlu+yDtN2dg28Zu6YbAZv/oOvg4yJ+wwCEHKDRxeJq6sVhK3/11v6c6B2WabzCQIyXXos7NB4w6bpLiD7a0AxZgtjhf9D17AfMFCa8pFmV6mngrgWphdTniUF8Dzlw3Y+L9620dSHsMNhAy+I6Y4FBThyhHWh8bQNrLCwurH14rMKOMeQjYPz/cwS41NuvGjf8djRPikIcRVZSAmgl9x6LLPBOoJYYCQI+Fdqdm0DaREWorqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qyUpS0bsF9aotS93XKkxk9JlTgVcOqHQEXxXoOhPTiI=;
 b=daTxwwUxPZkoVF0HFLsnRhaV/D1CeQVznlIhQY+Nni2XruLwbEW0uHwJW2e/BYB3Dhh+uv4aNIGFqkBT3e9XcRZwqvOv1wKy3kdCPDxgnD5j1OySOHEW7EOLfZm1J8OQtf1pGNNtv5n0tft14ZQb6tPh8ZvfSqK4jkbRS0zYpZaOcLfyzpUKcBKxVw2tHkuI/N+Z3Ug+dT36AiWU/PatSuEBftdgHhiSwQhxz4YfG4lqMcXg03JSMPvdctpRRcYz/OXbQMZL88HOPFUPJWZJ8s5YiSuvr92xrwY7+ZR/aLX+MDlvlz4nm+kN8z9y6y43ZCI0qAO1IdwDZ3DKR9q4jQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by LV2PR12MB5824.namprd12.prod.outlook.com (2603:10b6:408:176::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Mon, 15 May
 2023 13:15:18 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab%6]) with mapi id 15.20.6387.030; Mon, 15 May 2023
 13:15:18 +0000
Date: Mon, 15 May 2023 10:15:17 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Robin Murphy <robin.murphy@arm.com>
Cc: joro@8bytes.org, iommu@lists.linux.dev, will@kernel.org,
	digetx@gmail.com, thierry.reding@gmail.com,
	linux-tegra@vger.kernel.org
Subject: Re: [PATCH 4/4] iommu: Clean up force_aperture confusion
Message-ID: <ZGIwZZCcUV2lalIq@nvidia.com>
References: <cover.1684154219.git.robin.murphy@arm.com>
 <ed26ed3213bf07ab4977211702dc0898680524cd.1684154219.git.robin.murphy@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ed26ed3213bf07ab4977211702dc0898680524cd.1684154219.git.robin.murphy@arm.com>
X-ClientProxiedBy: MN2PR05CA0061.namprd05.prod.outlook.com
 (2603:10b6:208:236::30) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|LV2PR12MB5824:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e49f52f-447d-4f79-a6ce-08db55466dfa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	sj3+lMyRyryOlBwgVekAE09pzc3+4QRompA8eUmGK6rjIprzRrGvN+p/mrXaWD73RxHUO5DK60wbFSK4WCu10Ht3Xe0VEpLFlWcDu0aapLVo80/A7XUSL5V8YGmxHgvzWJh2tc71mju6u4Tb5gPWK/nNtOixghhGK7ut8scRysJC4l7gjXC2kNQTLAQ0Rsn4QhxoKw0qJkuRblHFVsRb8CimF4/enfjhtDJPvqWj228LN1Oo59o8mhUSwEOnj7Pzu76HOi3qid8rfLvNG49Yk76mRj8Rqw0nE593kuVKLe9IxA8yvUAoRkxK5b6JJ+71Pr4PUylHvgLy6njf3ezIOC0LYMpm79otsW6n3p9CHKrkUs0ZRuJ8qOSSVyuEYTyYgb3VCgAAWjK8exOYZ1lcK3vSNNvJf7JX10R2QjnTiXCNFtKOfqZtWcRrVyujscwud8t/wBpzAyk7VbNoCprLCi/e+7y3IrDkF2Bfs3sZt4dDBsZ+2xg2cy7xTpqCExzV4Sz6HajwqIocOtwFp4p9HWGrVgfw6AJWN/0Fk9FrcghXYkIr/kbyz4g5hmtR6EI/
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39860400002)(136003)(396003)(346002)(376002)(451199021)(186003)(2616005)(38100700002)(41300700001)(6486002)(83380400001)(6512007)(6506007)(26005)(478600001)(66899021)(6916009)(4326008)(66556008)(66476007)(66946007)(316002)(5660300002)(8676002)(8936002)(86362001)(2906002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OapPwTBmUHKL6e+KfCTBvPryfM0pp8YjvJtq5PmHzktorqpbE9hHJKNQxws6?=
 =?us-ascii?Q?c3k5IWwZ1jfa5q4PcGdJbYd15HQpV663SyRQWeW4R1S6E+jg3sMBqNlQenJj?=
 =?us-ascii?Q?6O06NevxguM/DY1fq+AgLwNV+OSdkrUFEAKFv/CL2sm/pr7EnIzv38Zz5WLv?=
 =?us-ascii?Q?nuoF70c4IhnAW7HPbKNPobZZlgPfi48fnqm0lNY6+0U5INiVfxfe+ol4YLNQ?=
 =?us-ascii?Q?BlVoMb/MihCMvObpt2ivbUKsnsSCFGplEpnDLy52yLuKWbYktkA+bBGRhe6T?=
 =?us-ascii?Q?Vr8Dc1KwDOHKj2XN/gqpNLLaSzxcGN5iZiwVFlzaAvs0KOGNU34zojeuL6HS?=
 =?us-ascii?Q?BQeZ7ZYrOvTTzj/eFFkitV7Po9ceMKE8N3DvPSQuZytZEpEgny4RZ/5b4XO5?=
 =?us-ascii?Q?GMlMZSzmOvdKhv12sD6b83feX6BqI19dcd4khbAsvEk5uLK+J/BZ4ZTzQg/c?=
 =?us-ascii?Q?QfiWi+kWc9cdPjSqmexp0fVoG5z9V3SSlNdTyk+1FVM6+oLN0UMuRb5uXfbr?=
 =?us-ascii?Q?vADGkHa9BnnbbvW0/NECvnpb/6KNXsePFKfDXiMtLMASkLeAM6BDoCV0ghQU?=
 =?us-ascii?Q?3RJYV4TkfxqTOOSq5bs7Z207LBu+DaSdkBofhzS0XnZ/dlIv/kuO2gGYQ2ga?=
 =?us-ascii?Q?Nb0o0ZxezV4W01geiBagcxaXqhMZ7e7tMCk089zhbpKfbwD9HK9C5xKWjgG5?=
 =?us-ascii?Q?1dIQMAMb1TJMfwROvm8nVoQH0w2Q5R8skJtBV5JgM0r93tVTEtxwz11px0Kb?=
 =?us-ascii?Q?k/Io9esieUGX0pBY7OpDTAKNVYaf0DdKdYwTOxR6VS1dPUOSqMF/HFRFlIQG?=
 =?us-ascii?Q?Zq++j7zCd/BFtkEA5y0IN/hTNnU2WN1QVst5TKb6c82wwh0KLIjCVxcAlzs4?=
 =?us-ascii?Q?wQ3lEBvU/Ul4LCLrpw55GXRl9h88vRruk3Dv/t9NEsLmcnV4H61t8Uf9LvY8?=
 =?us-ascii?Q?GmZmmtsiMI4D2WyRdicjBgoou36DTRCgAlkBenCt6xWSsqSxubgDdXqZdbMH?=
 =?us-ascii?Q?jcwwgxFWNFg50vdOuQ4cQzTrhd96x2XfcGeUQwOox5YWA0FAG7vrNdffQZ4b?=
 =?us-ascii?Q?BEtDG2bp7yhHsnIJdwAyQtAXQt+7jvcYN/tXKv3PndScPHnP32UE0LjQs1zs?=
 =?us-ascii?Q?5sDweTk9aS1m6MRjX02Iz0GKJ/pbIVxF6OvnFpyxBtztRYllXS9ZMm7xDaeP?=
 =?us-ascii?Q?HgzXLOQ4Tws222Ve6OEjPdqcSelrawClm0loupFpp3XxJsB8SGRkfRURX9eB?=
 =?us-ascii?Q?5E7q/GWbmQbjusuziPHeIbVlxPWYK7NvdSiubop1shhFApjeGhbChs1kxrHB?=
 =?us-ascii?Q?+O0DebOF3CULBBI6ku8GJV5+7kH83i7eg67YSHGSq2ozPvmUH7iC2s6rEvxQ?=
 =?us-ascii?Q?F4b/LMucCqmqxND1oeoR2Rt97kPHKXdt4+dK2STu8FYviYJM3OyaIi0PMWaY?=
 =?us-ascii?Q?BOln+72J1PkPTDp7i2WtlHwPVUvtNOD6ZU923oryK4U2R6MV1BjVLPQ1GsgA?=
 =?us-ascii?Q?eUK0Jx0S0aBErOUA7qT266VmRZNl+XwLDiZQjd3Z1Oqa0YqdyOrwBItBwHHF?=
 =?us-ascii?Q?SbCgzQcWA0m4RzWOZ2+SKiqeLQgywbQc38ugb+R4?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e49f52f-447d-4f79-a6ce-08db55466dfa
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2023 13:15:18.5363
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +prmTtyr7uV9nfnWgibalGgpPD5I2wY1eCiJ2YphY7A1nEI8Bn3jt+KidomdeztH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5824

On Mon, May 15, 2023 at 01:49:32PM +0100, Robin Murphy wrote:
> It was never entirely clear whether the force_aperture flag was supposed
> to be a hardware capability or a software policy. So far things seem to
> have leant towards the latter, given that the only drivers not setting
> the flag are ones where the aperture is seemingly a whole virtual
> address space such that accesses outside it wouldn't be possible, and
> the one driver which definitely can't enforce it in hardware *does*
> still set the flag.
> 
> On reflection, though, it makes little sense for drivers to dictate
> usage policy to callers, and the interpretation that a driver setting
> the flag might also translate addresses outside the given aperture but
> has for some reason chosen not to is not actually a useful one. It seems
> a lot more logical to treat the aperture as the absolute limit of what
> can be translated, and the flag to indicate what would happen if a
> device did try to access an address outside the aperture, i.e. whether
> the access would fault or pass through untranslated. As such, reframe
> the flag consistent with a hardware capability in the hope of clearing
> up the misconception.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>  drivers/iommu/dma-iommu.c    | 19 +++++++------------
>  drivers/iommu/mtk_iommu_v1.c |  4 ++++
>  drivers/iommu/sprd-iommu.c   |  1 +
>  drivers/iommu/tegra-gart.c   |  2 +-
>  4 files changed, 13 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index 7a9f0b0bddbd..4693b021d54f 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -548,24 +548,19 @@ static int iommu_dma_init_domain(struct iommu_domain *domain, dma_addr_t base,
>  	if (!cookie || cookie->type != IOMMU_DMA_IOVA_COOKIE)
>  		return -EINVAL;
>  
> +	/*
> +	 * If the IOMMU only offers a non-isolated GART-style translation
> +	 * aperture, just let the device use dma-direct.
> +	 */

So we add code to dma-iommu.c for a driver that never enables
dma-iommu.c and uses def_default_domain to prevent it from ever being
used anyhow? :(

> +	if (!domain->geometry.force_aperture)
> +		return -EINVAL;

We need more checks than just this, the 'blocking domain is an empty
unmanaged' thing needs it, there is a check in virtio-iommu that looks
wonky and the name doesn't really convay what it does
anymore.. "partial_translation" or something would be better.

I still prefer deleting tegra-gart and deleting force_aperture
completely.

Jason
