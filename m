Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2071.outbound.protection.outlook.com [40.107.244.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D087417F7
	for <iommu@lists.linux.dev>; Wed, 16 Aug 2023 07:31:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B0ZYZPPtCJKBs9/HUSRAzG2kPwmaGIxrTJ5cB0qg8KUbOGCandhh6P/Sh1TN5xmoMeJKCdBamMKJdKAdzNvJH459QllHjpuFXxYQCuu0nBv7vhv2I212Pc08AOR+4wUn1+PRjWL1DJkUTuNTlepZMIM83v/uSrEeJyz3jsT+jZf69vjLsDbLsr7HYzUVkfeZbW4blylBt6xS/WGxDfx1m0fK7HwYS+KAoZxlH3+85lFKLDW0POqIgMnfKjaX0VhJvEeZJu7WGrSOABP0FNAn8Mxc9WMnU7V8oMq0e5Df7UCc7mSijVNQeCWcHxopCnulqajRZzyXAjsgaVRLVD1iRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5RLJrK8efpi8Ldkconq+38FFpYTuzYzuVZMSLCmccbc=;
 b=k/7Zn5132WHKBk/7frppfaYriPKWczFqw/zk7a11EkRqfJmSeslpC2Xa9JSwEs1JcvkxjZpMAPrkyFzW7VskyAb0DVbw+M4sECHSBBK62Qju+8FgDbqWiMCmCLwW7EH8x7nvjWTmWXPAGdvM20C2fDGl6HqMNY24j6MnyI6pcmVy/ivkUyRZGckiafL/sn/AFXYYzkf2d3G3K0rMKSRrDJX+YMQxy5XtEpsv7Eros+Eo1Q12GI/vGwVmtQ3iTGO5nUEmZV03iqV/Xfz/icQDgaBezxC7UleWBVUE1DU7S8Z1Akd88AQSyN0WN3K0Du8Iy5H/dVWIDM5m578eBuCY9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5RLJrK8efpi8Ldkconq+38FFpYTuzYzuVZMSLCmccbc=;
 b=XYj1+YdUHFGX987Y0kY2ReLKY14XBUi1xXtRDtpitbqJRPtksT523/tQhANe8Qv23a0JyNaazxIPlgsMKZQtvaCjwOQoRcknGQSJ0Dt0abxbTuDzfEy0LygGZZanVurdCpMyRgjN26JKjPKxgJwrGz2GPhGc2prXf3EM+JTJzEU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 SJ2PR12MB8875.namprd12.prod.outlook.com (2603:10b6:a03:543::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.29; Wed, 16 Aug
 2023 07:31:42 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::67ec:80e:c478:df8e]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::67ec:80e:c478:df8e%7]) with mapi id 15.20.6678.025; Wed, 16 Aug 2023
 07:31:42 +0000
Message-ID: <673b7081-801b-d24b-ea75-33c5847951b4@amd.com>
Date: Wed, 16 Aug 2023 13:01:29 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 0/4] iommu/amd: SVA Support (part 2) - deprecate iommu_v2
 module
Content-Language: en-US
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com,
 wei.huang2@amd.com, jsnitsel@redhat.com
References: <20230815103255.565295-1-vasant.hegde@amd.com>
 <ZNuOfZIm6itzNkbu@ziepe.ca>
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <ZNuOfZIm6itzNkbu@ziepe.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0221.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:ea::17) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|SJ2PR12MB8875:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c8059a8-2eb5-412f-9896-08db9e2ad5cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	QyM2B/dgyt/l9tBs/CsZtZRCF06p2UOfwS+ukADpJRWUGmfItISEiPannLmw8hTNpkDDGoyK69prk7fvfr515Dz0PmWbo9tF4GoueHuVlPbOpoxQp0tNYj5il5fjuzIpNuulQ3ujMkElUKLhVaLOnL5z6s2NIeOlBGaH8jsgcm7rC4O7tRMp+7cuGmYjApGsWNEUI8FMTSA6aDxzbieXXveQUbfR4z81VbkiJteJoiuS4n0C5zneqarmPdb2bitjp0vOFoevm+CsnPmZENwu+MpSArYUbhCiyqsuUC7PSVNCU8G4Duln8Pdt0w66KN9zJD6XN58emXp+jxP14wwLq/zxA7RkqyCnz+Em8U2JfbdgaL6fTGQOy2VboRwWqZPnG1VzBCX8rxJMhh5R8jrsg/zrZAp57KYO72InEZi3owa8cm3j9lk0kyitnYdmKFqUtg/mN2csNqYaIEFqW3ABrXjLSwADxKfHRPJfdI3sbpstb8vLMmQBBlQJ/zrX6WmZYz8W4RvZF03Oru38evfvRK6TyQuSkyI2FjztRpyKJy+yC+NbpEjupwHQ1QAbrq+CSfNy5rrkIzi4e1uM8avpRRauBoZdV8lC7m6PAnNhClSfyTNwzKARoB3XV+ZBN939O6/sVUbr5luRIgDSZhHvl+HIO1n5U36XPq/muHBpZIg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(346002)(366004)(376002)(396003)(186009)(1800799009)(451199024)(38100700002)(31696002)(86362001)(36756003)(478600001)(6666004)(966005)(2906002)(2616005)(6506007)(6486002)(53546011)(6512007)(5660300002)(44832011)(41300700001)(8936002)(4326008)(8676002)(31686004)(316002)(6916009)(66946007)(66556008)(66476007)(26005)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y2Z5a3lrSzdubjBkcGcrOFBwZU9CTFlKMyt2L2tNR1N5WUg3M0xsUGJEejZS?=
 =?utf-8?B?VTVmNFRhVnViKzhib1JIWDdNdWVDQzhFYzZjZitwTnJBMjExc3ZKRGpCL0Zl?=
 =?utf-8?B?eFdERTZ3UG8yZzk0TjMyalZwY0JBeVZPMFFaRFJuTm01Ukt3MFA4UlFiQ3du?=
 =?utf-8?B?T1FFeTNuTlZHNGRKa2EwRlVPKzFydDF1blM5eDVXNHZqa1pVWnlhNmdYN3R3?=
 =?utf-8?B?elRwbWlIR296YXljNUdVc1luY0wvSDdMLzZscEkxR3lQMi82WVNtM3BGcHln?=
 =?utf-8?B?c2JoYlZhR1p1SDJUdkJaZG1Nd0UxYWZNQnBHSGtwM1FGak01MUVwVnRVc3Bu?=
 =?utf-8?B?OXd6cnRnNG5EdHFPSFN5WWFPVExzcWlMRjdLUWpEMHRIdzVOYVdqOEREek5T?=
 =?utf-8?B?M0VVdHNpenFjd3J3dGRYTzBET2tJWVBLWVNtclE0QitzTjRXaEljR211UmNS?=
 =?utf-8?B?eHlkeExrM0pSSDFldEVOcWFGNjVOWGdGNlZDOWJXUEJBZTVpajUzL1Y2STNZ?=
 =?utf-8?B?ZnZYOUNpN1dDU0xpVm0xNkFqSnp4VGJBWDFrVzZ3a1JiRU40Wm0xQXplM2xi?=
 =?utf-8?B?OE1TSjh6K0tScjJ5REEzQ0VxbW5BbDdGZ1dFTXVMQ3I4bDM3cGRCS2tQQnNt?=
 =?utf-8?B?SWUyWmJ4WmZXSlBocWMwQ2RMOVNac0c3UjM4VjBta3pqOVdiOXJ6OGl4cXdh?=
 =?utf-8?B?Wk1hanR4aUVEaFRJYmpWMno2clgrSDBIcW1YTWJtdm9yY1pManBONGpRVWR0?=
 =?utf-8?B?NUcwRHRjcGdySkllNXZUSC9oc1V1WHRwQVdBZHdjQXBoMkh6ZGNHUjRsUWNH?=
 =?utf-8?B?bE9SdW5JQUVRUWp5blpVVTNGajh1cWw0VVNzKy9HTUxlU2o1dFA2UlNZN2JP?=
 =?utf-8?B?NmI5V2tlMDRyU0ZHaHlRV0ZtN0xnZE5yL0M4SUwyK0M5NllMdFpFYTE1N2ZC?=
 =?utf-8?B?RDYwMWIxeFV6NnRXK0NqSkJTcEhKdERaM3VzdmZJdldIMC9MWlJoOHRyRTlY?=
 =?utf-8?B?c0o1aHhRNTRTbjRjUVIzdm9XeXQxTUQvdG8vcVJUSWkyQXFCaXlvcytMc2g2?=
 =?utf-8?B?b0FsVjNmeVFsRXFabjdZVktUTDZuOSswMFVZKzRDMjVYc2tJVTI0by9ianVW?=
 =?utf-8?B?UGVDdjN3ZWVHS1pmK29iWUJOaUxsVXBPTnRDSWcxbnlHQk5TeVowUHlxdC9m?=
 =?utf-8?B?SUUxeU94MWIwd2JGWEVDNE1HOUlnaEh0cExHZWYzTWJEWjB2QTZJQytGRGUy?=
 =?utf-8?B?N0JpMUNoZ2tDV0hWOEdpWDBNNWoydWVqcW12VEdZRUs2RE5Icm9wRVpTbUl4?=
 =?utf-8?B?czBWaUdYenZVb3Y2cmlIVzFhRTYyMEUrS2xyc0lQMjIrT3FFcHgwNHNTVGNj?=
 =?utf-8?B?eGhHUEFRWjNLVnVpTytUYytoRGxnV056WmNyVE1KZ0pYc01WVjRPcXBtQ1hB?=
 =?utf-8?B?ZHRnczVMRmNEM2dHQlNRRW93VDdNRG5MSENLcVYySEZieUZTWUViV1gyZEhz?=
 =?utf-8?B?MDdDWDd2WEpPY29iRXppMHVEbUgyNm1BT3JpVGtyOUN2OWRIM2RNdmFNeWtG?=
 =?utf-8?B?UWlvZ3ltSFJQVEV0MkdZcnMxendSZW5QMUYvMUs2Nk9iOXROZEZtTmd5OFJS?=
 =?utf-8?B?YUJENDhYRzkxbWtwT0ZhQk4rbUllRWVQSEpJRXNUQ1dvekFOKzIzd2l4cEJl?=
 =?utf-8?B?SmovN2E3d0phQzh4TVFIa2duMGxFVkZYZzgzVVRSdTc4K3p0VWZiYmNneDhD?=
 =?utf-8?B?OUtub29Va3Y0Rk5TVTZacmlFVFljbFJ6YUFRUmF3UTRDMXpXRVpzb3FMRE9D?=
 =?utf-8?B?RDJvN2I3SnR0QmkrdjQzc05LMm82YmEybSszVG1Rdmwrc2MxOUVKR3Jya2xw?=
 =?utf-8?B?clA4THM4NUdKUDZEaDNqYWpiVG9kUlNLbi9CUHpyUno2OW1KVzRRcm1DZjht?=
 =?utf-8?B?aVA5WkVUbWJZMWFrbE1wNU4wbUwrQ0loK1NtT1RXQnozMkFMK3hHRDZuUC9M?=
 =?utf-8?B?NkxkYXhycWJRMnVlZkhQU3BOSUFYVXoxTmdaWEJPUS80WXZGY0tUZzJBajE5?=
 =?utf-8?B?ZkxGVVhlbjY5YUVNdmhrWDZRcjRvWTAwOVdyQVh4azJyUGZvM0RRbm5OV1BG?=
 =?utf-8?Q?lhJWqnZRM2bJzkDJ3FDfwijjW?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c8059a8-2eb5-412f-9896-08db9e2ad5cc
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2023 07:31:41.9480
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5RPHiHhYIaM/DgOkBqh3cSv47QqKVCEyDER0IAMIYHuIzEJzWXblrR/qIOsXx/wdp8vjRle2xkhMUT/dP6zlWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8875

Jason,

On 8/15/2023 8:11 PM, Jason Gunthorpe wrote:
> On Tue, Aug 15, 2023 at 10:32:51AM +0000, Vasant Hegde wrote:
>> This is part 2 of the 4-part series to introduce Share Virtual Address
>> (SVA) support. This series removes iommu_v2 module support.
>>
>> AMD GPU driver which was the only in-kernel user of iommu_v2 module is
>> removing dependency on iommu_v2 module [1].
>>
>> [1] https://patchwork.freedesktop.org/series/122124/
>>
>> Also subsequent series will add SVA spuport in AMD IOMMU driver. Device
>> drivers are expected to use common SVA framework to enable device
>> PASID/PRI features.
>>
>> Hence this series removes iommu_v2 module and the functions used to support
>> iommu_v2 modue. Note that there are certain functions (ex: PPR interrupt
>> handling code) which will be used in subsequent series for SVA support.
>> Hence not removed those functions.
>>
>> This patch series is based on top of SVA Part 1 [1] :
>>   https://lore.kernel.org/linux-iommu/20230815102202.565012-1-vasant.hegde@amd.com/T/#t
>>
>>   Also to build kernel with this series either we need above AMD GPU
>>   related changes [1] -OR- compile with kernel config 'CONFIG_HSA_AMD=n'.
> 
> Why did you order it this way? Wouldn't part 1 be nicer if it doesn't
> have to worry about this code? Especially since part 1 is now not
> changing this code?

My bad. I should have posted this series without any Part number if subject and
then rebase Part1 on top of it.

I will continue to post next version with subject Part2 (just to avoid further
confusion).

-Vasant

