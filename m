Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2045.outbound.protection.outlook.com [40.107.101.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A5B34C7E
	for <iommu@lists.linux.dev>; Wed,  5 Jul 2023 04:35:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=COkRLPCDSLOkVPfWANE4L8FhQ54NzjJeZxnZdm9no4C2as0kaP6kIw2Pxmex0/VrZ06pNVbUajxygtea3b/OdCvbPviC9IO0onKghfMz5zEk3Yu8Dlk3xvQSyc98PrvXBq9bAakKiGMAQUmtEAN09PVO+cN87p2ByJ/Us6oES8w/5EEGPmFoYk5EdcT1NukGflqBv9AfflMNRGwtXkyadJn9l1cKw6QDkDJkTuXh+ApQoK4uxcAvgOe2cfFRQYi2Y0+QfUZsZDymvoxYzevEs3ed9t43DEqzkmJWwBJO7S0XvOBn9gm9NiSjo9CgHOfQOwNj/Vri1D3ahrB4QUm5kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HzVKa1dmzqpFjC/XYySN94dodsrIKe00gHubILj+R/U=;
 b=MOAVMOs1s7QgnJlg3lQ+ITdkjRC1ZkHWHOfOuA34yTsR5xqWQ77OyS3s6jloOvMfn6r1uSH6wO0Eva9b30Zpg23MP3UjjXiOmJbPivl63Z63Fk5hfzgC95zFTO/r1dJyCcaKAfD8KDhXNi5tceQl/AwFq8vuUb/JD0MWEJIzom0HNDMFs2ztiHFjj6w3N7BYkzEdt4nZMhlPSr5pyU9lxxxy+kf2RibEtAI/Z579XuqPo7gQ4NcAvNEfPLDS9iKh026rVgoroEMKbC5+ZvFSQ+GPRtHNh3Se8++0dN9s64Jf9XgIiq6uDSod5GPOecNxHXtAQj4/mxaqRUlAJ3gbwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HzVKa1dmzqpFjC/XYySN94dodsrIKe00gHubILj+R/U=;
 b=z4g8Nh23IclioTLurK+B816G9CN33oO+NyfkytB3hf2H026iO0SK8DCippB1jbcc0dSCP30sYFfkqDarssC27ZMyH0sBvEwkbijQenbHAag4tciUGwR55Ov+uAn5JMrPn2BZk6hJ/ChHN5BHZ/eYjLW76ZR4DTVMvZ5n4b0L9Jo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 CH2PR12MB4277.namprd12.prod.outlook.com (2603:10b6:610:ae::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6565.17; Wed, 5 Jul 2023 04:35:46 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::7cbf:236a:55b:2c99]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::7cbf:236a:55b:2c99%4]) with mapi id 15.20.6565.016; Wed, 5 Jul 2023
 04:35:46 +0000
Message-ID: <ab7edcb8-99fe-7c38-d98c-d0681649532f@amd.com>
Date: Wed, 5 Jul 2023 10:05:33 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v2 0/2] iommu/amd/iommu_v2: Fix refcount related issues
Content-Language: en-US
To: iommu@lists.linux.dev, joro@8bytes.org
Cc: suravee.suthikulpanit@amd.com, jgg@nvidia.com, dmarcovitch@nvidia.com
References: <20230609105146.7773-1-vasant.hegde@amd.com>
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20230609105146.7773-1-vasant.hegde@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0074.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9a::18) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|CH2PR12MB4277:EE_
X-MS-Office365-Filtering-Correlation-Id: 514f2ed1-e6e8-443d-cb80-08db7d114c90
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	RZJi1QUYJcaHVCuIMbJ/kuIsYCmy7LOvlU8mkvKFICb4qR6wCFb1D0XcgJf56MLiXZo/EeFAqkOVg+rd8lc2NLgYgx41VYYcf7VFDbm8sFuTYEbq+I6DpKIANpFxuV01AR8jOjF+VCSUtoiOuvx2+ZCD9It3oraheCYXX9dIv9CrQuG4uNHaUBugxdDOZjDmMWKaieD3miIXp1zTMotce1AxhlDhHZ4wjaAaaTlgyn6PZX2wxSlVCLXTdxlck3jr3ABaLmrI1nvcp0aLT0UFW7WcfoYSuK2ZShvxnLLX3jQCLQkcTO8LMXFauW5fuyK0lG71suer0pSTzqBrIhkBSPiZQ9kmrhkdsBOjQwwlGvTQU1k44a5xGJgjkt6W6hURzPdvJLlZ043Vhl2wYQPQyxiaKpmvg6+ZbK6IZzeiIrsx2ev+8kr3JuPjeYqrmJypn+5LOGzQdWvtK+epoLlNRxz+wExDAynCJEf7oXg+huOcGvvqqdmvGoQQ6YV1KrdtuJqOQFJMpyADM2m3lRX0X8CmaQHg/gWYqODGR2fhsPztJuKdkbXGA6UKKnLxkSVf0zObhoQToeQsAsnjARPPiWuWt62GlBRw5NWR+2VQF+kYbW4u1irwauanEa8XT2juNxyPFv5tghHCYNTGqyhHHQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(396003)(136003)(346002)(39860400002)(376002)(451199021)(83380400001)(4744005)(2616005)(2906002)(38100700002)(36756003)(8936002)(8676002)(86362001)(5660300002)(66476007)(316002)(4326008)(66946007)(66556008)(6486002)(6666004)(41300700001)(6512007)(31686004)(966005)(478600001)(186003)(26005)(6506007)(31696002)(53546011)(44832011)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?allqQk9rUHhmaEIvTFg0UUF2UTgxRE8yVVFKSTNUYm0zQ2RYd3kyVitWWmtw?=
 =?utf-8?B?SXR5SGZUc0VHQzBKYXRJaUUzY2Q1STI5VDZ2UlJGSjN6WG9OaTh6aHY3NG8x?=
 =?utf-8?B?YWhKM21yWGRsVHoxSDVJc3BVWVZpclVxU1d3aEZxYnhHTmZwWlcvMkVabkk5?=
 =?utf-8?B?enRVbFBRV1kxd3RNRGdUaEloU3NUUzFxMERrcjAxRS83TmhqQTRxYThzNzFm?=
 =?utf-8?B?WVFGbi82ZGlzdjBtY3BZRzQvMUZHZWhZdS9hWnlaSnJlTHNkVXZtMjV0L0tj?=
 =?utf-8?B?MlRwbmdwZHpITUs2cUxzU2pTYUVzaGNnVGV1N0JWV2JKYTluL21JeGM2TzVr?=
 =?utf-8?B?dGUwL2lxMWViaTd4ZEZsRkVxd1QyRHBQci9KV1RwNFU4VFNLNWpyOVJSWnAy?=
 =?utf-8?B?SEpCZ3JNakI3MHIwclFJWS9DL0hyVXRkMEt3TVIxK3FmeFUxYndKVmp4cEdB?=
 =?utf-8?B?SlJwU3laS05jUzdRR3pEdVcreVZBYzhqSzZ0TFZYTXI5bTB1eG9vZHcvZ20w?=
 =?utf-8?B?dk9MbmozblByb3I3UXFLT2N1TUNaSXI2Sk9LRFZDZzlMN2FKWG8wZXRIK3Rr?=
 =?utf-8?B?ODNKUFk4UVJkaVJUQjZrSTJvTW9vY1hEMlpLUGhNakJESlYxNWcwY2Q1VkhM?=
 =?utf-8?B?SmpYaTI0dENLLzdla0d2OFdBWURjbStVUlpVV05BZUk0Q1J1a2dNUFE0R0Ny?=
 =?utf-8?B?VkdkWFkxcThpSEVYS0JMaGQ0NkQycHJiY0tFZGs0UVdMSzA3OWJKWTVtUVh2?=
 =?utf-8?B?aGdYSEpCdXduQVd4KzYyaFY3MUUvQTV4djVMemtITjFsOWh0VDRBUy9FOENB?=
 =?utf-8?B?U0h3MzRUUmtqbjVDZCtOQXU4VlA4ZTRpT0RJN0R2a2lPUjBEc2lJdENOeTZv?=
 =?utf-8?B?cnRRMU1FWUVhbEF6Wk1lczRXZ0N1elFoY2NJWE5pMmZTRjhDTGRmZTNqbXVQ?=
 =?utf-8?B?ZGljMzFhVS9xbUNEOFE2R0FzQnE5TXVsanZGSEpDK05UakR4NHlJZXRhMGxR?=
 =?utf-8?B?UVV1dE00Q0ZiNHNkQU1ieGx4czFXbldsOXp3QXo5dVNwNVFLUUt2aHNwR3Br?=
 =?utf-8?B?U242bE5uQWVaTm54dGxCak9xRFdiRjZmaENHeVUzSUM3VDl2MktoQVZJcUhr?=
 =?utf-8?B?dkFPcVNSVVc1M3lteEtOY0lxVjBWbERnT2RxeUNIQzNQTkdJL1JnSmIwcDhl?=
 =?utf-8?B?Rlk1M25mK3NNbDBweWUvNWhZOGltbGpxK3NBSytnSms4TDc4TVFrOFRvaGY0?=
 =?utf-8?B?aWlZQVZrMVQ5UldoNEhLYWxyOW1pNURYZFVEbjdmcjMxaWFGdWkzR2ppaEFk?=
 =?utf-8?B?RXdEbXNPY1BoWFE4WUdoUGJtbGJGc2ZuWFBXY1BoU1pCMDNhZ0VKeEZmTGMy?=
 =?utf-8?B?UmNvbisvbm9EZHd4NGpTdFVpaEpkMkZ1bHdQVFpPZFpkRWJnNVpvbkJneVkw?=
 =?utf-8?B?OSs4S2FheDZBZCtNaFk5d0x6ckRrODdxak9kc25hVEtIT2ZFRTR1S1VYYjlk?=
 =?utf-8?B?RmpjZEFPdXllZHg5VS9zTlRXQ21hdW9GNEJHQlB5WElqWFowaDR4ZDFXRUpx?=
 =?utf-8?B?VmlubUlhRFJha2tENDlFMFJUSmpnb2JRc3ExVTEwODAxRUN5MUlDQnpaSFV1?=
 =?utf-8?B?NWYzYUIxd1hqcVUxZnB1dDMvbERkeDZ3ek8yWkUwL2hVbXk3OTZPVnN0Smlw?=
 =?utf-8?B?OGZqRFhWajdsOFVMMTVzb2Jmd3V6ck9UY3BUc3l1STNmeTRacFREN09HaDFa?=
 =?utf-8?B?TGNWK0V3UUMrNTVJdGpQY0l3Vy9rUUlHWmVIRFJtQ2tmSmsrdDZSTWFINlhP?=
 =?utf-8?B?QUtCbE9oRWM3aXdCcW5PVkZycnFWd1FrWHdSMW9vbWp6b3lMYW4xcHNINDg1?=
 =?utf-8?B?TTJjd0hZNWN3SkgyRFUrVDRBTHVRL1VsR01IQnVhd1g4Y3ZwME5XYjZEQWlx?=
 =?utf-8?B?OGpoNlErQ2dVSHJPRzdwV0t6QmE3N2MvRDRxLzIya2FPdHFlYXJPbjFLYjNX?=
 =?utf-8?B?SC9EL2FDMGVsZVlOaTRlcW5nU214WSs0cjA3VUdOSlhoRkF2WHZtQWpVcFlB?=
 =?utf-8?B?VUJwQ01kNXEzNEUvM1RmYXpxOVhDeHdNUVFBSDV2NFRsT0VTUnRIUENJQVE1?=
 =?utf-8?Q?u4PTnVZaMhHYHpum/VHOptDcU?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 514f2ed1-e6e8-443d-cb80-08db7d114c90
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2023 04:35:45.9191
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0CDOe37djxhBZVZNGPgTN3Imafllq/7LAyKRPU/oxJ94WBMkuW2ovWZY5rwbNEcpsJ9z7aaXkXo6PYbEB4YxiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4277

HI Joerg,

On 6/9/2023 4:21 PM, Vasant Hegde wrote:
> This patch series fixes the refcount warning and pasid state in free
> path.
> 
> V1 : https://lore.kernel.org/linux-iommu/20230124104355.119166-1-vasant.hegde@amd.com/

Ping. Did you get a chance to look into this series?


-Vasant

> 
> @Jason, Joerg,
>   During v1 series review Jason had suggested few things including
>   moving to xarray to handle PASID. We are planning to implement
>   xarray as separate series.
> 
>   This series fixes the kernel warning we are seeing because of
>   commit 8bc54824da4e. I am keeping changes as minimal so that
>   its easy to backport.
> 
> Base commit: d11370bf64c57a (iommu/next branch)
> 
> Daniel Marcovitch (1):
>   iommu/amd/iommu_v2: Fix pasid_state refcount dec hit 0 warning on pasid unbind
> 
> Vasant Hegde (1):
>   iommu/amd/iommu_v2: Clear pasid state in free path
> 
>  drivers/iommu/amd/iommu_v2.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 

