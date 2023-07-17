Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2055.outbound.protection.outlook.com [40.107.223.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5C7D1386
	for <iommu@lists.linux.dev>; Mon, 17 Jul 2023 01:22:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VGTqL9echphzGFyxRayEZXiCYKpjLYJ/Aw5CzzI2AfLgL1nW6Wv0uTFtr0Dq6Z3owK+6O8E3b3vJxqAmLV3y6H17F45Wyru+kD422ghMCeChG+feJa4S17qBqadkokDicPzCH6YXhBNwsjIx68ajK32u3e5HgJ6MkWaZoCMr/rdx6y7aymvqwRQCW3YjMPPKauxFKxzcdMXZJ1J0qfvhYJ19LcZIYjEoBHlwgqKkjE7Cl6o/jSLP0/d4fmrypRiN4Soolo93n0nWzXgG1rnrLMB7vrjhNks+VaNW5MKzbcL+DpO+8wrUAP2CqQq3oNru0G4Z0gBGYH8ari0Cl6FxTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Ib1Vui4WF2Qa434eumg13SKyC+Xt7oS+4UqMHByImA=;
 b=MzK4/br+uumIBW50jTTdE0brOGa8UBRFl82d3I/Pgvs4VsFEBPwjFBofSsVX7QB8rl3UEt9imNqjFNcYHn1iHoVpToZr5tBgPP09sTbx8b4xjN9tmOGS+aJWcUzmIPpFqG0zsxmGqcI1MoTxViIWPic+94MTUHk+NS1PXf5Q0dbeTiuzawqSffjORUpJyQuO5YtymixXS4XdFpcxgWzIvaeRyivYtkFIWfiLtB/1NUbhgWcuq+GbyPds/kcQMmVuDYDnmuXC36w0veHUfs8GnIGKKTNjXxtESf6FgX0zcKZnD3EDPZ25OmaMeqVe6Ozd8cTrgf5pN5hOIxChrHfCiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Ib1Vui4WF2Qa434eumg13SKyC+Xt7oS+4UqMHByImA=;
 b=TQsTNZKiVP/xI+Vn6f62l2/0PBOgxVz8mOEYwimf4gpYXrY4DO/+0PEj1xwrO/nJ98rTo5apeFjYoYFTK0dfbWPE0uyT1g/JutVFggS6dT6BYhPkdiWU8vXuA0Gy6A+7zDE08fJSOV9c8OKGEiD3JFZIuyZlR81aBb7Fl026aqE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM8PR12MB5445.namprd12.prod.outlook.com (2603:10b6:8:24::7) by
 CY8PR12MB8300.namprd12.prod.outlook.com (2603:10b6:930:7d::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6588.31; Mon, 17 Jul 2023 01:22:41 +0000
Received: from DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::12ec:a62b:b286:d309]) by DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::12ec:a62b:b286:d309%7]) with mapi id 15.20.6588.031; Mon, 17 Jul 2023
 01:22:40 +0000
Message-ID: <db7fe0f7-77d9-f898-0503-d6da58cf25c6@amd.com>
Date: Sun, 16 Jul 2023 20:22:37 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH 11/21] iommu/amd: Clean up and enhance protection domain
 flags
Content-Language: en-US
To: Jason Gunthorpe <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org
References: <20230712141516.154144-1-vasant.hegde@amd.com>
 <20230712141516.154144-12-vasant.hegde@amd.com> <ZLGFH6qERiRbD6cd@ziepe.ca>
From: "Suthikulpanit, Suravee" <suravee.suthikulpanit@amd.com>
In-Reply-To: <ZLGFH6qERiRbD6cd@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH8PR22CA0016.namprd22.prod.outlook.com
 (2603:10b6:510:2d1::9) To DM8PR12MB5445.namprd12.prod.outlook.com
 (2603:10b6:8:24::7)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR12MB5445:EE_|CY8PR12MB8300:EE_
X-MS-Office365-Filtering-Correlation-Id: 57ac76c8-f831-4eeb-a322-08db86644fbe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	apm9EA3PXkJhhYSmoTwGggehynXKk6cgwDnooRO4fbhrJFecRILVzZctRDb6LfHzpqCIjbLm67PHcB99MT2enyzX/JgOo6xyXPAw1tfkkdWlPxNk6XBiruCnxpxjeL40WnqU7H+oRDYea1Tx3jrU0TY9a5vaPeHQdu60MGHtNQ7zM9mh/rgJYxoK1U6PKK7q0GEUUGAd6+RHI+sFfG4GGARQrTDPH54I4WwOIJuQ9Y3QA+/cXHCbtLBIXKrCUuD9AZddCwufB3w1/rWlXG/4/D25YArpB+R/iILv3j+jHXd6rKoKI41MKDStFz8Vxy76G/UgeoquRxDa8YyrIrIsD+GoEr+yOvNV7Ag+gjeN4nWaN7xnrxHI1woRWltCMa5+WM3Bl1zrFTSKkuPkh+b8+eIgSHhXoS8q/uI1pB6EnWhsT+E8mDHqTTystrHzPkXYKDcUHsqvhG8rvXlHpQGLDQcctJ3S74mssYgt/DU8PcRwNQ9UlQ3evRmVI3oqterb43VPtn42fn0tcZXqt2un9+eVD0t5Y6V4UkdkRelztYO3tX0TxQLz5mZ+bWNIfGCkKzw3K6KQ093KaeDnxu35iwj3O8qy/r4J8HUc1zGnd0vGE7vYcXB/CZTUg6r+5irS+Np6Bn3DJBiP+NjWQBgBxg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5445.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(346002)(136003)(39860400002)(396003)(376002)(451199021)(478600001)(6486002)(6666004)(110136005)(186003)(53546011)(6506007)(36756003)(26005)(6512007)(2906002)(316002)(41300700001)(4326008)(6636002)(66946007)(66476007)(5660300002)(8936002)(8676002)(66556008)(38100700002)(86362001)(31696002)(2616005)(83380400001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bDBRdWFYcU5QUGdYOVcrRDRpMmk1L2pWWGVIbER5QU8rU2tIaG4zNlVINmFF?=
 =?utf-8?B?a2hHbStaVml6R1EvQXpSZi9JZ0x3VmhwVkxDd0pMZTlwVC94d3pWT3BGUFBv?=
 =?utf-8?B?aC9RdzQ3dVZBdFQ3alpFdS9BTjY1OFNBSXNidVBJVEZEaHhyWXhoV0RHSm5X?=
 =?utf-8?B?czU4M24zc0dFVlU5Zk4yRTcyajNJTVVGRHJQMkE0U1FHcmhDMjY1Q1RNZE82?=
 =?utf-8?B?enpwQW9RblF1SVI0L0EwcTUwK2NoWmdwVHg3N0s5UHllaDV3bW5LQTJET3Fz?=
 =?utf-8?B?aW9mdVVhNkZudUdHLytwRDZMMnpDQ3NkSzE2Y3cvd0owejNBdDN0WFUwUFlU?=
 =?utf-8?B?VWVQVjd5SkF5Mi9pYVFaQ0UrR0dwVFFpU2FuRmR3M0hYWG5VdEt5cFJSNC9J?=
 =?utf-8?B?NStzeEhZU0xHYXVwSXluRXVjc0tqVEozM1IwSWo3aS9yRDFPMHdvQWtpQWIv?=
 =?utf-8?B?SExhcHQyZ1JENmZReVpSSDZWdy8vclp5N1NtRFdNMkdmNUtPdDVEamI2Qk4v?=
 =?utf-8?B?TFQ2NytxdkRpVVRZVVRhaXc3ZGh0WVhkRlluelQ0QkRaQ0x1bDBrMlllRnI3?=
 =?utf-8?B?L2I0eGR1REpBQUdONEgvLys4a1VPd1RhZWZsS0YzaEpHUEZOUWx4L0tqTjhP?=
 =?utf-8?B?VCtxQi9IbTAxeDUrbllPWGhqK2dPaElMUWR0UElFZ05oRkRzcEd2Q1cyYjhJ?=
 =?utf-8?B?WmVMeW1XMHJCaHovZ3VJTDNLVUZzdDIyODZRUk5CbTBxdld5UDFObk56N0Rk?=
 =?utf-8?B?eEJCVXZ1Rlc1anBDMTJSeWRJSWN6UVgxOEI5aDdWaDU0WGZYWllFaHR2TzhU?=
 =?utf-8?B?NVcvcmNhMDNWQlllQ1NTZ29mOWJMVGk2R3FRUEJJRG5BWmdUOFlzN29KejV3?=
 =?utf-8?B?Mm1vMFRrZmpoTVRHSFJxOUROYUpWbXV6akp2akFhOEZpN0VBejIyaFJNb2NQ?=
 =?utf-8?B?c1R1SGkrbHdSOTltRElyd3hnclN4MVZkejhDd2tLNzFqK3gxc1VnSkpnQ3dn?=
 =?utf-8?B?Sm0zQVNSOVlSeFhiZ25XZTNuMklLVktZL2g1ZEJCSm5Ca1p5RXNjaHhIUyth?=
 =?utf-8?B?c0hJSEkxUXZFTjM1eFAvUkZFbGU0RkxYNTViUk91UTI1UjY1SkljeW53T3po?=
 =?utf-8?B?TmkvTWpseVVuM1Rnd0MzcXpNVTE0bytCRUQ2NEdoQUF4WGZ2MElEendqRlhq?=
 =?utf-8?B?ZzAxSFZiTS8wZWhSTkJBeDcyRXNFY0pINTF6bVI3VUV6VVFuVC9ScjJjdDdP?=
 =?utf-8?B?SElNWUNiOERyM2xtWlNONmJvc0c1OU5WS2g1RC8yVFNiWnU4Q0pkWnI0dGg5?=
 =?utf-8?B?eGx0MCsrakVGcFA0TUw2bXhMNVZHMGVvNEdCWHlJZWRkMXN6Q1RoOFVMNm5u?=
 =?utf-8?B?bm03NXlTeTBaWjF1alpFWVZ4VkdSY3hZcXZTeFk2cTZnLy9wa05QTWltTGhz?=
 =?utf-8?B?b2FLZnYycWhVVUszRWpQM3BHSkYwenpHa251ZGw3UDd0UnUxYzBmUVVIaVZG?=
 =?utf-8?B?bkttd2t1Z2hpbHlablZpeHBVRW5vYXVBTjRJQ1QxWEk0VEJKcWxFQzlOa2hX?=
 =?utf-8?B?d2I2VmdjZUxzS2dNVVZEa2tIY2tUaVpjcytPbk5NQUwyZVYzb01Ndno0MkZQ?=
 =?utf-8?B?T0hrQ0RGRVFiVkhlNTh5Vk9wcllRV2xXWHh1NDZTeWVmR0hYcDF3eTFtdy9j?=
 =?utf-8?B?b1IwMVFVK2dRM1B2Y2UvMU5VQzFTeStvZ05VK3pnbktGaWVhT1pFNVoyREVU?=
 =?utf-8?B?cFFLSW11eC9tL09UQ1ExV3lpRDBmL2l5SW1HSFpURHBaOGcrazFhNkhIMmRK?=
 =?utf-8?B?VzNKVVNXRGU0NWZJT1ZqZ0RrcUtaV2lXUENlSlVhelVtV1NaOTBJZmFTUXR4?=
 =?utf-8?B?L3g0bEo2YVVXRnR0M0lDMHlPYjViSDRIb3ZhV2dRdWhZT0diVjlQVUFqVHJL?=
 =?utf-8?B?ZHRDNzM4OHZnalF5amRITFNTMHpqdS9CYWhKSW96RFBDeVVsZUdzelphQUVH?=
 =?utf-8?B?bTdwckpMZ21IRndOdjI0WlNPV201OGVNUXE3dWNTM0NkV0pqSEdLdVl1SGpX?=
 =?utf-8?B?bUJQUVprVERTb1EwYnFBTENMSndtUVJ3RjZrdXBnMndJMWhZQ09GSDBtejVY?=
 =?utf-8?Q?ZUhQQodod//bM69JnqjtClGVW?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57ac76c8-f831-4eeb-a322-08db86644fbe
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5445.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2023 01:22:39.7703
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0vMaSGTEQW21tysqXT6e/K+vnk1iIci6nhaAOn+G2A9kQU5gKm+RWfvVEFASbXx4NASsGANXdOPGBajfxWISqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8300

Jason,

On 7/14/2023 12:25 PM, Jason Gunthorpe wrote:
> On Wed, Jul 12, 2023 at 02:15:06PM +0000, Vasant Hegde wrote:
>> From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
>>
>> With IOMMU v1 and v2 page tables per domain, and the v2 table can
>> be used in various modes, keeping track of how a particular domain
>> is configured becoming cumbersome.
>>
>> Enhance protection_domain.flags to keep track of how a domain is
>> configured. Also Remove unused flags, and rename them accordingly.
>>
>> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
>> Co-developed-by: Vasant Hegde <vasant.hegde@amd.com>
>> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
>> ---
>>   drivers/iommu/amd/amd_iommu_types.h | 14 +++++---------
>>   drivers/iommu/amd/io_pgtable_v2.c   |  2 +-
>>   drivers/iommu/amd/iommu.c           | 21 ++++++++++++---------
>>   3 files changed, 18 insertions(+), 19 deletions(-)
>>
>> diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
>> index 346c32343417..907af6e41ae9 100644
>> --- a/drivers/iommu/amd/amd_iommu_types.h
>> +++ b/drivers/iommu/amd/amd_iommu_types.h
>> @@ -443,13 +443,11 @@
>>   #define MAX_DOMAIN_ID 65536
>>   
>>   /* Protection domain flags */
>> -#define PD_DMA_OPS_MASK		BIT(0) /* domain used for dma_ops */
>> -#define PD_DEFAULT_MASK		BIT(1) /* domain is a default dma_ops
>> -					      domain for an IOMMU */
>> -#define PD_PASSTHROUGH_MASK	BIT(2) /* domain has no page
>> -					      translation */
>> -#define PD_IOMMUV2_MASK		BIT(3) /* domain has gcr3 table */
>> -#define PD_GIOV_MASK		BIT(4) /* domain enable GIOV support */
> 
>> +#define PD_FLAG_V1DMA		BIT(1) /* DMA-API mode w/ v1 page table */
>> +#define PD_FLAG_V2DMA		BIT(2) /* DMA-API mode w/ v2 page table */
> 
> "DMA-API" should not be part of the driver vocabulary. Does this have
> anything to do with DMA-API?
>
> Only "paging" domains should have IO page tables and an IO page table
> type.
>
> Maybe this is just misnamed?

These flags are for struct protection_domain in AMD IOMMU driver, and 
not for the struct iommu_domain.

PD_FLAG_V[1|2]DMA flags are used to signify that the domain is using v1 
or v2 page table to implement IOMMU_DOMAIN_DMA (which has 
__IOMMU_DOMAIN_PAGING | __IOMMU_DOMAIN_DMA_API).

> Also, shouldn't it be an enum not flags?

We use flags instead of enum because we exepect to have combination of 
the flags. For example
* IOMMU_DOMAIN_DMA + amd_iommu=pgtbl_v1 = (PD_FLAG_V1DMA)
* IOMMU_DOMAIN_DMA + amd_iommu=pgtbl_v2 = (PD_FLAG_V2DMA | PD_FLAG_GIOV)
* IOMMU_DOMAIN_SVA = (PD_FLAG_SVA | PD_FLAG_GCR3)
* Domain for v2API = (PD_FLAG_V2API | PD_FLAG_GCR3)
* Etc ....

It helps keeping track of how the IOMMU driver needs to setup DTEs for 
device in a particular domain.

>> +#define PD_FLAG_PT		BIT(0) /* Passthrough mode */
>> +#define PD_FLAG_GCR3		BIT(3) /* domain has gcr3 table */
> 
> These seem redundant with the domain type?
> 
> Maybe a few helpers?
> 
>> +#define PD_FLAG_GIOV		BIT(4) /* domain enable GIOV support */
> 
> This really shouldn't be a iommu_domain flag, this should be computed
> based on what domains are attached where
> 
> Eg this seems like it should be triggered by attaching identity to the
> RID with PASID enabled or something like that.
> 
> Why do you need to set it for the legacy GPU path?

The PD_FLAG_GIOV is necessary for when we setup the v2 page table for 
devices, which cannot support PASID. With the DTE[GIOV] bit set, IOMMU 
hardware would treat the request from these devices as if it use PASID 0.

Thanks,
Suravee
