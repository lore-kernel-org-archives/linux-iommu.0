Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2041.outbound.protection.outlook.com [40.107.102.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F299863B3
	for <iommu@lists.linux.dev>; Fri, 11 Aug 2023 16:51:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hb9b3rmNr0HiQHbf1THQPm6JzVWRG0hOY6XildOtM7JNp3/mji9QlJDV5XIYY0y5/F3Bi51O1ajuZuhrWCCbisbs+8VkovcaVgyXf/v6MxAZZLmDtmFfpfKmvljJ1krS8a43uBWg2owch5OxJbbJu1ijPi//ZN0NH4OXOHxE73pTMqq0EBBINnxh2uMPQUwQLMr/nsmSfkkVuPsFw2vqTJZiGiYbAys0VE3XMP6bB3wQSVoK/pGA+v8S30SgjhSLH8H2w1YaKO4r01pfHEYbHJ5TBn55R9ucL1CMBlRLrWZyrDGukKupcGM/yCOA1qEf//EAaDFV1fsfbm2PBbqrNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xKGOOvGp1nO1uhchyNtRN+G1158YGHTeuC8wqOIg/Fw=;
 b=hvElxDSG2whnP/GxuOKGUDBl4VdLXkGOVKBQBLbPwTpWhfHnhnFo0ZnDe6iCHuHpNTyoAEMa/Nwb46EbUeP6krmh2iH2xMC5VRMWml3Tu3Ac67LnTNbNJfu2mFj//Owp2C3MUnUsYa7XbXxqhtTCUbD2UsK7G8w1Qv4Cig3Mq+Kk2KSplqvE6j1ba/V28lFbxtTAn4Y28nB3HyNgdYDcXYz67kSBoJIVWm06PXbAqwENzeBNknpi0qvsO5vdxuGda9cjzCA2jyEYjZHhhTyUyvFDLhufN3nM7j0WUoBSCQxa1zjDgmcUkt2Fn+1lt1K/QP8Wd/iB/tHB26FGfQLLbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xKGOOvGp1nO1uhchyNtRN+G1158YGHTeuC8wqOIg/Fw=;
 b=wj0RtdvxFyw1ZLCc/Fj5vO+OkXjvkhyefvvRr4n5j/RPjHhzZf0+fKYt17JbDRp+u9C1G+5CHGqdLxpDlvH0r+QazOG/cObB4MxKcZFPjx/DDNV19ME6B4R8fNlWfe0xryD/MCttN/Crhd7DqHc/PQGgTH++zkWtWJhBX5Tjeg4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM8PR12MB5445.namprd12.prod.outlook.com (2603:10b6:8:24::7) by
 BL1PR12MB5705.namprd12.prod.outlook.com (2603:10b6:208:384::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6678.20; Fri, 11 Aug 2023 16:51:27 +0000
Received: from DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::12ec:a62b:b286:d309]) by DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::12ec:a62b:b286:d309%7]) with mapi id 15.20.6652.029; Fri, 11 Aug 2023
 16:51:27 +0000
Message-ID: <b7979ec1-c6a4-c892-9ff5-2c369a5133a8@amd.com>
Date: Fri, 11 Aug 2023 09:51:24 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH 09/11] iommu/amd: Introduce helper functions for AMD IOMMU
 v2 driver
Content-Language: en-US
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Vasant Hegde <vasant.hegde@amd.com>, iommu@lists.linux.dev,
 joro@8bytes.org, wei.huang2@amd.com, jsnitsel@redhat.com
References: <20230808100232.5977-1-vasant.hegde@amd.com>
 <20230808100232.5977-10-vasant.hegde@amd.com> <ZNJj9ljbIM842lEh@ziepe.ca>
 <c5572a08-42b4-c778-b6ce-21fe44190ec6@amd.com> <ZNY1A6e5S80heWoj@ziepe.ca>
From: "Suthikulpanit, Suravee" <suravee.suthikulpanit@amd.com>
In-Reply-To: <ZNY1A6e5S80heWoj@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH7PR17CA0068.namprd17.prod.outlook.com
 (2603:10b6:510:325::12) To DM8PR12MB5445.namprd12.prod.outlook.com
 (2603:10b6:8:24::7)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR12MB5445:EE_|BL1PR12MB5705:EE_
X-MS-Office365-Filtering-Correlation-Id: 56f47b7d-ae0c-4b35-63ab-08db9a8b3475
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	3c91b4WBxeXuXd+/C0jC3XXDXS4f1tV0udEluPnlvpNQ2hsS1TpcX9D97hJS/mbKgxoVZIzjiW6AFM/3Fpup4WaBFLyqPTY09sHIrqxnRIrs+TNM6FoQAT6PLek94+6oVI7FDHdTQc5y2GWnWrbzTqiANvdFHgDgbukxa/G62HOhKa+vqF42U/0YpOeRmbB0hYRapGbosFrXqad3aoB7vkIfYGfvcajigDxNiNOVtcmoS2KIVG4ZXG7K4kQ2Y9JCZHNlFRis8F8BtT1UNaCsEQwaCKct9vj6+3EvQb03LtnLgEnEMDiXAuBzx+il/Ite4RDzclICfsQfScvDV8xU/TTw2Fv3hOA8zvp7Gfwzw45vBVN3z4Yxod/o874ua98NzS3eD0AwHh9ty5b4NdMa4sF0P986EK7aYkbmNHWq+V+jEWfK2Xud3A5PPfLKo5jiiH/chtuLJGpbD/bb/Ms0Qf8laUOp+JZ8lyfzym0gEIWruvFIIMa5eAojx7Jp0HzXIg2cqiZ8e79NDLmPoy7xzTLrMXIIAyNhDumAW0bw27h5+++MT0rN969UfsKXla93lYkPR4M4Quqa5Mr4wYZQYvLGZTco31+sZRAI4Sxk2gKczTtTEsZdx66/Wt34aU9qH/1s75ZgThNWNVuUb2PaBA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5445.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(366004)(396003)(39860400002)(136003)(346002)(186006)(1800799006)(451199021)(4326008)(8936002)(8676002)(86362001)(31696002)(26005)(6512007)(2616005)(38100700002)(41300700001)(6506007)(478600001)(6666004)(6486002)(36756003)(53546011)(316002)(66476007)(6916009)(66556008)(66946007)(4744005)(5660300002)(2906002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M3h5KzJtVzRwS2V0SGVwT3JKWmlCR1pGd0tOaE5FZVYxd1B4a0p0ZW4vZDU2?=
 =?utf-8?B?eUJUMUtYVkRSaFdzNHF2aGpiQzNzdk9kVVBZU1FoMkZRYVU0eU0rbjg0UHNX?=
 =?utf-8?B?bHZ5Vk1uTFJOVGNscWJialV1V0k0ZlBTK3VxakpSMkZuL3M2MWhKcGpuRXU3?=
 =?utf-8?B?a1hJTUUxQW1WWGdyazhSWU9YVzBtNXE2WkMzU1dhNERQS2dpL2RSR0tyY1Fi?=
 =?utf-8?B?aTVqU1h0MmxSVEhoZDI0aUVjQlRIRkZSVEpLeGRseG5OaURSbnl3RXo5R0s4?=
 =?utf-8?B?WHN3bW45Vm5nUGxzOE1WaVorY0NrZDlYeWkreDlHaVJRQ0JSTzQ2Sm5zVkIx?=
 =?utf-8?B?ckxSVXI1S0RySTNDY0lzUUMvUXVpVVEvTzJHejlNQU0rNDZhdHJMT0hkYjB0?=
 =?utf-8?B?T1dZcEdJcndEU25mTlRsMDdwVDRWL1FRUEJqSWFrOHQ3RFIrbHp1UGtTMWF5?=
 =?utf-8?B?Um0zKytiQ2tVK0hjeXZ1ZStuNlNlM2F5WTQ4Mzd0VW9KWUN0dXE5T1RNcC9Z?=
 =?utf-8?B?YnBjQXFuYVlHTXRWTmltVEpMelg2MmxIV1VBbGM3eXNrZkdkTDBWK3lwM3ZE?=
 =?utf-8?B?YjlOTkNTb3BmRG9ab1lkMGJiOWlRTDhKU2xVTXNOUURXU1RBVmx0TmxRLzRk?=
 =?utf-8?B?L0FHczJKYlZQQWVvd1VtazVzQS9nQWt6dTlIdVZwTzlJOU52N3B3YmYrYTFk?=
 =?utf-8?B?QzhhaTM0bGxDQktiazNaQlNQSDR6NDRWOTJBaEtkeUhBMzVyMFlLWm85Um5t?=
 =?utf-8?B?bG41MWxWVmM1eVU4cDNjdkVOVjFVNkk0RVJmS2taaTkrQ2RsNDF5WXFSZnNm?=
 =?utf-8?B?aEV1WkRzN1plTW9yOU1pMlh6S0Zmakc3SEVUUkpyN01sYkNvZ3ZEMkdMNTBZ?=
 =?utf-8?B?ZEdpUC9mdUdzaUIvcnNrQ1VOV0k2TlZac0pkYmlTZUlzdVhiZDM5OUdlT3Rq?=
 =?utf-8?B?RDhFeXJSNGpLSlJKQTVqaldxZGIyYWtwcWtUUG1ycUY0WHZNU2JHT3I1cTBh?=
 =?utf-8?B?TmFRZTBEcUJwVDlndVhVdDUyQ2VqWkVpR2RPaGl5OVhzY21yWkc5Zmd6NTBv?=
 =?utf-8?B?VW95bldsdW9SeGNrb3BkN21KeWlyb1BHUmxBMTBVTkpTc3FYRXQ1WXpxWUxp?=
 =?utf-8?B?V2kweHZYU0Z2SVZwY2ErY2pIMFJVNStoUUJzTnRTemZJMEFMR3JKSG5RdU1N?=
 =?utf-8?B?MjVCK3Z2RHRST25WbTU1NXpsTjFTVTZDS1BGSzJ0MnFHNE13Szd5RmtQNzB5?=
 =?utf-8?B?OWJqV3o2OTNiUzAzcUg2REJkZVVJSlVua3NCa1lBdjgxL0VaNUdLSXdUdmtB?=
 =?utf-8?B?L2FWaHlSRDZiS2IxMjRXemw1ME5wc05VbmR1MXhRV1lIcm5EQklzTmRxS2tl?=
 =?utf-8?B?K3p2UHU5Zjg1YnBPZGpTUlQvZVVOaGNLOEdBaWxIUDBpUy9ERU5zR3VXUlpP?=
 =?utf-8?B?MGtEbG5VU0xoRkN5OFZSUVVEQ2xFTDZJK1ZoL0FUUVpBclRzbzJPVFJyY1k1?=
 =?utf-8?B?WGNoNHZURjFiRDhGam9MYlBueER6eWJab2x3d3NON1RmMWdEV3NUekwrby9R?=
 =?utf-8?B?akhvQkg3dlozLzBaQUtyUkJaUFZVVlVCbC9rWnZvQ09CRTJ4ZmtqWWFpb0Vm?=
 =?utf-8?B?TDVwZ1ZqU29qUkE2NlVEOVZaSHNtcEF6UzhjcC9pSE1EQUlJVnVDN2ZFMFA2?=
 =?utf-8?B?eHM2S3Ird0dMS1NWNmw4MnEwTEdqWlRVWjd1ZUY2TTI0MTlYY25tS0VKSVk1?=
 =?utf-8?B?S3F2WUVKT05KSmRUNlNlTCtlWEtId1U0ck80NFkrNXVPOFdVUDBuQUpIblN1?=
 =?utf-8?B?STRzMTN5b1VzTW01UmVUN0RpdjJTTFJVRXBvcTlYRGtlQVQ2enc4UUcxSVlM?=
 =?utf-8?B?Tk9pRkNQdVJiZHNmdmp3RDdqL1VvOHZtWXVNUjNtSmxxaGFkL2hQMEt5Ylh5?=
 =?utf-8?B?ZVJYWEV0V2tVSzJtL3RidTBvZzk5blp3YWRlUG1RWkhPVkJ2SUFNQ1I0Mkla?=
 =?utf-8?B?TTRndXlDb0lKQUhPbDV6a1hqVXlETUxGdVZEK05xOGFFcE5ZSWxndkF5WjNB?=
 =?utf-8?B?ZzdORTVCTVZ3NDhmQUp4YWtqNkRxRURWT1M3WGwvODVieGd1alluSElpNnoz?=
 =?utf-8?Q?aH6puJ6XANmKHTvH0Cdae6Glq?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56f47b7d-ae0c-4b35-63ab-08db9a8b3475
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5445.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2023 16:51:27.6588
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Oda/hsQhNzTxW6REywBKEgNFu+qVSje2tz0NMr+oGTcVXr1Az2uyKqV7GAn837axhDYInV8iBa8buc2+orAjDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5705



On 8/11/2023 6:17 AM, Jason Gunthorpe wrote:
> On Thu, Aug 10, 2023 at 06:34:46PM -0700, Suthikulpanit, Suravee wrote:
> 
>> Supporting the IOMMU v2API adds complication on how IOMMU domain for v2 page
>> table is managed due to several restrictions, and it is conflicting with the
>> upcoming SVA support.
>>
>> Since this patch targeting v6.6 is dropping IOMMUv2 support:
>>
>> [PATCH V2 4/5] drm/amdkfd: drop IOMMUv2 support
>> (https://www.spinics.net/lists/amd-gfx/msg96082.html)
>>
>> Subsequently, we will go ahead and remove the AMD IOMMU v2 driver since
>> there is no in-kernel dependencies. This should simplify the domain
>> management, and should be easier to introduce the SVA support afterward.
>>
>> We will rework this series and send out v2 shortly.
> 
> Oh wow that is great news. Lets go forward on that basis.
> 
> Please make sure the AMD driver has zero EXPORT_SYMBOL's in it after
> the above is applied
> 
> Thanks,
> Jason

We will take care of that.

Thanks,
Suravee
