Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2042.outbound.protection.outlook.com [40.107.94.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D288A1800B
	for <iommu@lists.linux.dev>; Mon, 31 Jul 2023 12:28:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h0ksVOHKoM3+B10w7RfuJLeASlUg61LDx1sscPMnq4iZ2Lnasldl+UWNnXsEXp8L6WjRQp3Dq0uMh2JTtSVe0q47bVGlOUFYH3H+fY5j1NANuA9HWoOPzTr1mSnPneX9W8QZkjeSf7I0ITrnto20aWMfVXLdXI6+A2GfQ64NpZ2NANPKvRXNmMKhQZ8LIDm0HcT1H64VWnJfQuL9ZiFEn1OAnOPgM9x0FgK0fh5w4DSxgl3ulJnG0kgnMVq3y10BJPwAdFUhpWR+U2jKDW7L5bE+IZDHxJ0ZJz4ExqpKe5ZTvs3XdiPiCbHJZS1cMff7R1saPvNx/IndziFhijaTkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8+mI1FotPNI8/CTphXtbdsDAcz8VUOM3j1Py71758MQ=;
 b=P0jthvxiTtQnAHGoXdKuichCYaTNiIEUFUlQbEEGWXl9aX1uIUIBEXEhspMm68bcXJrbbVSTZyhF3yh//GP1Wr34h9AxbNq5n6+4WemKu12HYAXz/5WJz1PBngUnoa7uC+02XEVina9/DEmdWydpK+IDBOWCXoYA/MVuQ2/2qRlpvB9IzHiL1O5nWp+42Uw9edO2Tn8OcPaHDLAlDT+EJmWFnTWf+Ho+qVFiXBjp/pmpzajNC3tbkq2PdMqlOmqUzTeBUTfgykewk2gArRRDUriSJ6n6hmTce4ftO7bvdYp9CkoWedqlXpBDIQmFpWlNdYmwOsRdabysdGfcNmcO/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8+mI1FotPNI8/CTphXtbdsDAcz8VUOM3j1Py71758MQ=;
 b=PXahkqqZE9C9Jh6AcqxbWSHqETZSnqqxwGltItF5OrJptPaw6N6Hkotc3/BPhTy80n6NYnbtH6PcEOtZa4cJOXkkLTrKlNKLz+FnpvNRKCGwHwQgARQbNwgMg41jCpOC/XowZiQN9j7g3lNjwRalUsIA15TCHkD35Z3QDKE7vho=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 DS0PR12MB8574.namprd12.prod.outlook.com (2603:10b6:8:166::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6631.42; Mon, 31 Jul 2023 12:28:17 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::67ec:80e:c478:df8e]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::67ec:80e:c478:df8e%7]) with mapi id 15.20.6631.042; Mon, 31 Jul 2023
 12:28:17 +0000
Message-ID: <82c8636b-2cde-bc2b-08d1-5f669ba94bf8@amd.com>
Date: Mon, 31 Jul 2023 17:58:04 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v2 12/16] iommu/amd: Add support for different types of
 PPR handler
Content-Language: en-US
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com,
 wei.huang2@amd.com, jsnitsel@redhat.com
References: <20230728053609.165183-1-vasant.hegde@amd.com>
 <20230728053609.165183-13-vasant.hegde@amd.com> <ZMPRN6Gz/dsbBnqe@ziepe.ca>
 <d231040e-c657-35aa-c6bb-9705c23afa82@amd.com> <ZMek9W9NoJAIxvqy@ziepe.ca>
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <ZMek9W9NoJAIxvqy@ziepe.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0110.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:96::7) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|DS0PR12MB8574:EE_
X-MS-Office365-Filtering-Correlation-Id: dd942e5e-9fb7-4ef7-e9a6-08db91c19de1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	80E/tazSSYx4Zo/XzOiBc4GQx81uHld2Yvqgw7r8IWL5EQqFV4vuKpr6vivjXGfQQN/nxLwxB8kttrYqpSEoyoEGiG4BJs4Z+QnfpqRRNn2+CqMg5LAcJ9yAJJeC7CuKmNCLUOtW5GhwJQJEImX0z+jUQDaxVEo0W/yDQG8RsrB/ycadB5dvZb9myOZ2fkjIXCNE3GYxPd2aVNPVoYzT2dvc06d+4ENgkQCwO+s4NQTJmO7yrecEf8ysz0AroZWuWCK6e9fRyrc3gnT0nIbTVTuafak1P8poi7n2HhXmH5rgb/aRJG5zaYYEnOExNxvnYilN8YZNuN0ozjknnhtWbDoaUKqo3o2q7pR3fivX5qa5QcM2DJQHl789z4Jiax0GMo0ttthNop7Gjql5XDPRAw+1nMBg6kCeF1hSuLXvPvN1M+mVnJmoKPfvONT/ukUGYVmO89YxWt3lvojhMYX9zRfdo/UzXsXEcEyJk7Jf17h91odBxItf2/2eDDe156FOXnmAiAoHnifHjuBRESHyd20u24EUJIiO4CzSK/h5SozqN/c75y/7/27KgEGTZMV1rq0K4sgl+G2ovc8gyJctOqA2Ybc1O8m6eGi6pTRBlQXwkE/VUr1UVgK5pUBRhXKPLO6OLnE+B3wPH7H0ugWr2w==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(366004)(39860400002)(346002)(376002)(396003)(451199021)(6512007)(6486002)(36756003)(53546011)(2616005)(26005)(6506007)(186003)(44832011)(66946007)(66556008)(31696002)(86362001)(66476007)(316002)(4326008)(5660300002)(6916009)(8676002)(8936002)(31686004)(41300700001)(38100700002)(2906002)(6666004)(478600001)(4744005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MVBuTDBvek5EMHV2bUhOYmRpb2J5azdtRWNMTi9pbEwzQ05MTkxIUlZ4NDZi?=
 =?utf-8?B?Y0V5TWRhaUhpdjQzR0haR0NkZGp1TVZsbTFSUlUyS2U2UXJjUGlDdk03S2lB?=
 =?utf-8?B?TEFWZnRDR1o0dUJsOThNQVF3c3R6QzI3eGY4MUN5RUhOcGg2cGl4MExUWFYr?=
 =?utf-8?B?a1M1TStya2hiT2J6enptUHVIYmxjMWdXTUdmU3JVUGJtU2pObnJvNGR1Q0hz?=
 =?utf-8?B?dHhjV0ZUNGkvUzJYOFJxMzFiNjhhQjhVOTh3RUp0U2k2ZmQvWStCYWdQbEFo?=
 =?utf-8?B?ZkVQWGcvd2NBK0h2MzlZc2pQQy9JS1g5a3Vqb2d4VU5YcTZ5N2k5Q1prRmtV?=
 =?utf-8?B?RklnMmRnb0ZQWTQ2RTZ3NU5FWXF5UDloV2RrYnl2cWVKTWJCOEN1VjZMMFBU?=
 =?utf-8?B?RzcvenJ2RnRhR0FDR1U4Q3Y2U01jbmxBOER6VWlRaHZsbWZOejhvMjhQT2pU?=
 =?utf-8?B?YmRpdUovcitGR2c2UFpQaENpdXFxZGtuMXdCM3hIcElNUzZKd01wYk1WTEg1?=
 =?utf-8?B?OGFoekRDR29mNDZYbWg5K0VJeExRd2R1YkZuLzhIaWZhRndYOVE4K3dTMktk?=
 =?utf-8?B?aVRYL09neGVORmN3YjdDajJNSEFhbHFiS2R3Vjl5SDJRL1N6RFdXKy9lN1JB?=
 =?utf-8?B?eWVyNlE2RTJUaFpKNHpuM0w5T3l2Rkx6RGNYUzBueXBtQ2gvQWdSRFk2WTRn?=
 =?utf-8?B?cGdsNGFmb2dHSkh4elhzYkUvbVBYYkcyOGsxTW9uMUxvUEpYRUpObnEwMFhy?=
 =?utf-8?B?UXhaU0gvMUEwWWQ2WnZCYmNhMHEzRXB3eUFmU0pyYjRJSXZvR1k1b2VSTXFG?=
 =?utf-8?B?QXZrZFhXMTJKeDdLbituUkdNcXNSZ3haTWhCTS9GeGFsM1ErdURBd3o3WlZQ?=
 =?utf-8?B?eWZpVUNqUGxVWDAvVzQ1Vy85QnNZelJjNTFZdThkOHEvR1liRWFPTnBYYTVR?=
 =?utf-8?B?eHlhRHBIOVV6a1d0NlByM1BpcC9kQWxFWDI1alcxS3lZOHhZT21TWVJsbVhK?=
 =?utf-8?B?UUs1RGhQUGpsS1QvUEozMFFaRlZ3YmpKeVFEMmV0YkdOMmQ4VlpiSStHQUFl?=
 =?utf-8?B?bzd2dnJLMUJaMjdiNVMwUmpwVWpOcHExRFZZSHNpWlVXV25sa25WZ0pMcG1K?=
 =?utf-8?B?Y3FCY2EwT3hpL0FMMFRSaTlMVW84YlV1ZGNpYTErZ0JHeEZOMEhUaDVuUnJH?=
 =?utf-8?B?d2pMajREelp1UzVnVk1YWThOZXc1Ylc3d1ZmZUtsZ0c1UnM5YXROOFNLUTJt?=
 =?utf-8?B?MkcwRkVYellFaVRNb2hSUGMyYXBicXRrY21WOGd1WlJXWEtFalJoZ0NqczJH?=
 =?utf-8?B?eExEQnZ2SVV1Zm5qSkkzaHFOODZqWjg4OWtqZXZXRFJnSkliMnE2Tm1sMHJ4?=
 =?utf-8?B?ZjFpQ216eDdoTXdmUVNoN2Evamp6SWxhbmducmJxRldHM2FDc0t5VEV5SExo?=
 =?utf-8?B?TUVFaXpWWndoakVlcTAyMVVmNFhYNFlCVzYyQ1MxS0pXUllKUFZTdzQwMVVX?=
 =?utf-8?B?ZG5UYjJwb3ZBUzRqTzVXSWF4VzMxUERXMnRZbjNOQ1dRVEp6dFMzSm13bEt1?=
 =?utf-8?B?WGxpS3J4Y3Y5bUNoMm03ZWlGS2UrZythZlF3cXZvVFNrUHFMOGlUYUpkSHhr?=
 =?utf-8?B?VnM5NHNaMlhpVEYzZExPTFF1Mlp3ZTIydG9XdjZOSlBUZU0vRjBBMDBvY2Zs?=
 =?utf-8?B?Vy9weGpMdFFDTVhRdVQwakdjbE1HdTdjSk00eXRJT1AyMEdDZ2VYU1RseG1T?=
 =?utf-8?B?anBYMWViM2RXaTN1SHB6Q1VPcXUxMDE1dHlXdWVpOE13b3FaVVJYM2lwQVBF?=
 =?utf-8?B?dnM2VWRwdVZnYTJ4MUw0Yzk1NEJqMG43bFdUSjl5RHpxUW1hWEN1VnJiMW9M?=
 =?utf-8?B?QzVkRnE5UmF5Wmhad29FcWhCd0VWb1NjQTZFQ0loWHV1cHoxRThMM01obGRo?=
 =?utf-8?B?UG5zSXVhNWpBSEVSREJaYlAwRDRxdk85UDFQTW1KTWk4dm10VW5tcGE0ZGY3?=
 =?utf-8?B?OUhRZnpMWGtZZmF5SG56UjQ5aTZBSFAzc0NSU29HdWYzUXZERWtlZHNxVE0w?=
 =?utf-8?B?V1ZUWDE2SitJNmEvTUNWSXpaWS9aZ0E0YjI1cDlNNzFaVXNpVmxMQ0xTQk9a?=
 =?utf-8?Q?G/tUd0x44RLRGLCCjkxkCIGqI?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd942e5e-9fb7-4ef7-e9a6-08db91c19de1
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2023 12:28:17.0323
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0LxCUL4HWNtRS/GrE6dqcrCl3bitRg7jSS/dizfpdJt8qbXSRrQbw0NUBYxnx7FJqtjVs1cIgf3/VogIwBHG5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8574

Hi Jason,


On 7/31/2023 5:41 PM, Jason Gunthorpe wrote:
> On Mon, Jul 31, 2023 at 01:32:05PM +0530, Vasant Hegde wrote:
> 
>>>> +enum ppr_handlers {
>>>> +	PPR_HANDLER_NONE,	/* No handler specified */
>>>> +	PPR_HANDLER_V2API,	/* IOMMU v2 API ppr handler */
>>>> +	PPR_HANDLER_IOPF,	/* IOPF ppr handler */
>>>
>>> This constant is never used, move it to the patch that uses it.
>>
>> Sure. I will move IOPF macro to later patch series.
>>
>>>
>>> Why are you doing this? It would be much better to hook the GPU driver
>>> into the standard API, what prevents that?
>>
>> Because once we implement IOPF support we will have two different path. Hence
>> adding variable to track PPR.
> 
> You should try very hard to avoid having two different paths.

Yes. I think eventually we will get their.

-Vasant

