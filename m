Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2059.outbound.protection.outlook.com [40.107.92.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 746811FBC
	for <iommu@lists.linux.dev>; Fri,  3 Feb 2023 10:40:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NitMQAl3wNIIsPUX8NkF3sgY/fh/ZsF1d5hGsFe7jENv4LrQS5ZDMOjliqKHlO49evFFMIcKY5Ge0DqXO2O55DGVdei7v/lkLkOsZL4c1kS3SmPVQtOaVwG27UAbJVFnYSJBzn499jQdT+HvCEr0UcpK/MY4z5Z3r4uPp7lPA+4UpL0z2lOcxomFb2f+SF9vl10nuByApr09IpHGKM1NNT7I8Es/9Rtz21pnSR5TQkRFe5aX0BBM6zqPRzrDox+1T+JseEA0yvAcgfMZf2Pbc5dAoUkLDooZ4azg6+Qgz6BKg1k45eLCSdV95DsVi36ntwzG0zzeC0KqFl/N+DI1PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+AmDlg939+FfIJ++US1mnk4VrH6AjORohPTwPMkCHdg=;
 b=RpSRsVd6ZHmXHIciEonnekmZ9ley/c9p5R38xPjSJgLsgewBdCaA8uh2kMuxaYM2nZMpI+ZgTJpishxkBO1aD6NKnrlbtJvNaOC76ZklTXtvBmjB5PqK2bep7FE8TRY3VrOLRX0u7XAI0OuEIDJWqP/VUGBOOO0fFsLJFgwoY25Mt8IQSSetTzHM5ns2WoYcJsKsiil+H1Wbxx2S+6KnW9Tadk/tiUHGdwfKuZbrQ8jcCezirXXV2koIh/KSEONCXUt+pwFrf0DbkLZv1hFR8m6dICR2D8HMbPOibFykrOiE4cUaPdgtPdc0a1lJ6V/e6lwSQ/voUCJoBzsb/DfjUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+AmDlg939+FfIJ++US1mnk4VrH6AjORohPTwPMkCHdg=;
 b=URlY3Vg9or0BWwSY7IZR2aPz9kEYj8W+dybMBHi9KJul1f7viQSGhqV1YoAkM5ymPJLpOyqQ2Rbi12rTAL3MBERPCHGemaTXudDPyp5m5jciq4r7XjolT8UQCHkKKbo2H04LU35OI9JKSmM1nlqel73nru5IkVnsjxXJOK3pots=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 MW4PR12MB6851.namprd12.prod.outlook.com (2603:10b6:303:20b::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6064.22; Fri, 3 Feb 2023 10:40:44 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::4014:79ea:392b:b4f6]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::4014:79ea:392b:b4f6%3]) with mapi id 15.20.6043.038; Fri, 3 Feb 2023
 10:40:44 +0000
Message-ID: <8f161d2b-2c00-5a91-5799-36746af5b32c@amd.com>
Date: Fri, 3 Feb 2023 16:10:33 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 3/3] iommu/amd: Call BUG_ON in page fault hanlder path if
 domain is NULL
Content-Language: en-US
To: Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux.dev, robin.murphy@arm.com, will@kernel.org,
 suravee.suthikulpanit@amd.com, Matt Fagnani <matt.fagnani@bell.net>
References: <20230113135956.5788-1-vasant.hegde@amd.com>
 <20230113135956.5788-3-vasant.hegde@amd.com> <Y9zVnkfEp3bC+UfL@8bytes.org>
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <Y9zVnkfEp3bC+UfL@8bytes.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0164.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:de::6) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|MW4PR12MB6851:EE_
X-MS-Office365-Filtering-Correlation-Id: d2ab6986-2be2-4afc-535b-08db05d31a84
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	8XlPEvPR4TTPCRHEaUiv2RqgGHC8UTu+4mX21i/UDsTP1Y8hWvQ8ZowLBOVmqazZAptEqIHocnLKIACFgC2WtLxjpWYWXZSbV/Be3uFtxcLQcBMo8outkb+jvQN1PGBVKBAwa+OG+ygvC1WonmvxY/DhoEHAZTpqF1cd92QZZ2yYXXpOII2bMY92sMgcCwsrhIjXjfmILEr6+rgTwnY1v2JNHPizfTJ/Cl5YbDNmIoyvZZg2zK73c2xMtI4fuSZnI7lE4bm0hrl3dH7Nr+V3HWEw2oEXpwQ9CKeZSd0EokEsXUnAWALBwQpyP4v7pe5YaFz8ut3CD2XKAbHzvRyiC2Fw/2+DrexxFodJ9lOUfYsxHUoJpRAtokJiedz9VCxp5chIEpLYC+VLEx7HNytZUCynhlRqymfLAyhxJkukeqYo4wbPjbTMWEN8JrYyhfF1Zvk61QEfUVirdhGOMSmzvPT3zCwSR5NydiH8tcSXGNgoCjR7OH/M1SBj7zWWIFwi3/6Qd6+JlLPeuwjzgm7u/0n+84k1XcALgQA9zyL+FWgdijtSGXiqWk/qdIfWv1ynbS4D477tK5prgksY1jN4dBHvvgtEhcFxrHJxWF4MbfyBjDj/GMq369Bi94BlhMQzgVSPOVeHCLmDzETQ4V1/omytXp9Mmg3/2L7C8KKKAkx6eu3w1bWW/wf1Fdg5A68Fvy15r0pMGKEUe2zgLTgkTgS4JrP7kgqrlD2UKoKd6W4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(366004)(396003)(346002)(376002)(136003)(451199018)(86362001)(53546011)(38100700002)(26005)(186003)(6512007)(6506007)(2616005)(36756003)(6486002)(478600001)(6666004)(31686004)(83380400001)(5660300002)(8676002)(4326008)(316002)(6916009)(41300700001)(66476007)(66556008)(66946007)(2906002)(44832011)(8936002)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?anFZcmNoLzNzSklqcWM5UGlsVW1PN2I5OTk0L3ZwU3VVSlVkcXB6bmxUZHJy?=
 =?utf-8?B?ajRlSWd2OG9iOVZ1amJ5TGtGaVVtUHdiVm12SmpiSXY0U0lDeEoyV3JWQmRl?=
 =?utf-8?B?Zi9YeFJvWFZvSEdPQXJua2E5MGdIUVUwNTZVRmVhM2gzR1dtUXpKYVB1RDla?=
 =?utf-8?B?T3MzMXhHalRINmhqbUkxSEh3QjVZbEFHSzBYQWFZM3BtVzIyS1FqTy9HbitP?=
 =?utf-8?B?dThGd2Nia2Nvb3NseXZvcERmNjN0NzluMnVnWTIzeWw4a0VhVkZncjhVWXNz?=
 =?utf-8?B?dnMrS3pyRlZHS2txZW5UN01SNnVSMFRGU1puRHNNdVpQQ3FpR3BiTlRYRWNI?=
 =?utf-8?B?alpBM0ZkYjI5YnBFcnpCWm9ldTJTRGVVclhzQW9ab2xZN2ZRVm5nek1tUW5E?=
 =?utf-8?B?WkpFUHdMTWM3V2g1cUxxVmdUN3ZpQkNLL2NYNUlFUVhCajdzUExwUXN6Z1o4?=
 =?utf-8?B?VnJmYmZENkJTQk1WTnB4QW1icmZSMTE2UEZsN1loc0ZKTHRnOHBISC9mb3dr?=
 =?utf-8?B?bkxFSWkvYkJocVBsdU5ZRllxM3ppUkN4VjcvZnMrMTNXZjVRQmZFeGMyT2ZU?=
 =?utf-8?B?OUhCQndqeUJVRGdNQUt4RmNadndvcDBTb0JjN1QzL1pJOFpXRWdCdWJ5bGFp?=
 =?utf-8?B?Y0d5ZWhYcVJlUURVbUNYYTYxa0VUdFh4QnptMVhSMzVDVENvTlcyWC9sTWhx?=
 =?utf-8?B?eXk3cGxMeTF1RmdIYUV2RFBBU2MrOXZSWDVXb1FVSTFLMm1aUXlHVkg4S2xJ?=
 =?utf-8?B?R0tLM3ViSXlxWkp3TmhxSW1zdzZLNkZyQ0FCdk1STkNwa0M2eU55Vm9rN3p2?=
 =?utf-8?B?QXdzVU5pYzNBR1Axd2xnOHZKNG1VTmxiWEV1eU1tTlZWei9kTXpOWTYxZTUw?=
 =?utf-8?B?WlhDQURUcTArL3MzbjZPbHplWXdqWDlWZklTdzh5MEh1SnNocVVBYWhzclF6?=
 =?utf-8?B?VmV0NG1CMzIrTWZxLzBKNUEvTitlZUxUU1owM3pIUDRCaEhKRWpBSUVROFA1?=
 =?utf-8?B?KzVLRU9HYmxvZ0kvVWYzUjFMczVtVmVhUjdhOVZEZlJKNHg4RW0vRlpDc0Jt?=
 =?utf-8?B?bXJIOGNhMGFkVTRhTThhNXZIcUVzN2czOWp0N3FEVlRBMnlFSWwzUjFyRmIz?=
 =?utf-8?B?OFM3YlhvcDBtdWhLZnZRUzdxTFlyRlB3Sjk5Vi9tcjZZc3lwY1pidmUzWHZI?=
 =?utf-8?B?bmQzRDlpYlZRUW00emdtTUk3NnpDb3ROVG5FRTZKa2FmMmEwcUNCMm41T3B0?=
 =?utf-8?B?Y0ozNlFDV0hXUTR1ZkQ0M2I1elF6R1ZRN0daaDFPZmZWeThtcGZxZ1pXREor?=
 =?utf-8?B?WHg0NEQrNTMzcTVDcDlmWndFV29MQlBBZWpvdldOTkZQeFhoS3BaQ09iazIw?=
 =?utf-8?B?dG9YbThlVFhzaUFWUGRVZ2Y3UFBCYkhHaXRIYzFXYjcwT1pEQ0FPalo0cmR1?=
 =?utf-8?B?OTVEZTBoNFhrRitFeFppVFh3ZnNPU1Z4UkRkWnJmbytDMWtiSWN5cmZmSzNE?=
 =?utf-8?B?L1gzS1VTWngrMDZmVUYySlBFa20vR3JDRWVUaWlyUTJRN3RGUnBOTXNDdDE2?=
 =?utf-8?B?azVlVGVQaVZyb2hTaFQ2cEtVL2VubmJxeDYvcGsvTzh1UmlpNDlhU0dXcFpR?=
 =?utf-8?B?WThkUVp2TmZYZmVKYzk3T2oxbnhFQ3lZeHdCQng1YTFnaGpDVHV2RHNWTTZq?=
 =?utf-8?B?RTFFOWpXcVVLV1RaSnZJOFc5UHdXWFpUQkpydHVOalRRWXdOcm85cGNWRE56?=
 =?utf-8?B?MitYYXhCVEtUYnBld1ZZUEJJdXNsN3AweFRaR2VyOC9CWFJxNjVzdUpicFUx?=
 =?utf-8?B?Tlp3eGx3TFlQRDFGd2hLaThEa3ZkcGZOMGpyZHhmZUd5b01TMktWN21iVjNO?=
 =?utf-8?B?N2U3OEdRUEhFRlpLYkpkQjJBTXlGS1hSUU84Z3JwQi9sRW5lRzQxenlCVDlZ?=
 =?utf-8?B?eWowT2Z2elllaitBT2RiRE4xM2VDazVFTkl3dU9Gc3ZUMTI3cHhiWGROSlRu?=
 =?utf-8?B?SGlZNVZsNGFobzZQdWtLeDZMSFVyaVF3VUVpdUE0WkxxYTl0ZGdwVnVvV01M?=
 =?utf-8?B?WWg2VVQycDVHTzdFYW50em5Xak0xWE1GTXdEU3pwanhsTy9xbGhod3lBS0cv?=
 =?utf-8?Q?utr/w5cr/Kiv8m9JMq4ayG0qv?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2ab6986-2be2-4afc-535b-08db05d31a84
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2023 10:40:44.7924
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tI1S3HPFUYSPP1RnHc49phkPP614IcvGzgWxC2uDMjOsfZDjpvhYCHvh+VV9JIaof+RXt2JyNnFgTclh4/5SRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6851

Hi Joerg,


On 2/3/2023 3:06 PM, Joerg Roedel wrote:
> On Fri, Jan 13, 2023 at 01:59:56PM +0000, Vasant Hegde wrote:
>> If IOMMU domain for device group is not setup properly then we may hit
>> IOMMU page fault. Current page fault handler assumes that domain is
>> always setup and it will hit NULL pointer dereference (see below sample log).
>>
>> This is mostly programming error and difficult to recover from here. Hence
>> call BUG_ON().
> 
> I agree with Robin here, a BUG_ON() is no improvement over a NULL-ptr
> dereference. Just handle the domain == NULL case so that this code-path
> will not crash.

Initially I was thinking of logging error message and return. But it will hit
device faults continuously.  Also we don't have nice way to recover from this
condition.

So I thought crashing here with explicit BUG_ON is better. But I agree with
Robin's comment. We don't really get anything extra with BUG_ON. We should be
able to figureout crash reason based on NULL pointer dereference easily.

Do you want me to just add explicit log here? Otherwise I am fine dropping this
patch (3/3). I think we still need first two patches from this series.

-Vasant


