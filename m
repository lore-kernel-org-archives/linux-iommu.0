Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2083.outbound.protection.outlook.com [40.107.223.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BEBD7B
	for <iommu@lists.linux.dev>; Fri, 27 Jan 2023 04:44:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kVyzZ9xwMUHGQM2y59LqsBHTcuWueWaNsXWb3EUbhCa875AO9vvvXDlZbInXlMIdC7Y0qIGBLP8HBYG/hiEPeJ3GX+KBzQOQYpuugyKV5W2HbND/U1bm2LSRwW02fGsYl+6yih4XT+7i7bXqu1i9z0m5ATt++wQ9vbnzjKzemhZjrc/4KB807+kNvwjdqRLPWze8w8rDkHl9/BFTXMx5MErre2FE0ynSj/K7WlfpIhvww128YbzIGxYHu/gRkGHnvAhYw7o0mpFwFnzYefCQSbkdwJmfn6NxfT78VhXE3buGSddIYeFajB6jmL1ouyTW4e69JnxnAxFJe7iqL0uOmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m0rYexatJHPHosTmAoG8oqKCtZCMPfup7BJybWmdivI=;
 b=fs2cSI435ekg2vo5VU27mLIoevn//2fqDrBi7r0YTcN87sUJ5E2SS1y8K3xQbCbYvtCm1EiTS+/nuUVUCUZIoG622R2XvspHilotyyswb7DEyPhTQBJ+d71X28dJrgl15ytmJ+ppLD/I6R8+OZyNPhZeo/nlEXpHn1HQorp4TziQIRarnA1K47MkV0pnYINBqYiFiq73eXnwRUqp+SOYXaRX8EE/JDBF9D3WNYwHotiSsZjorjC8OdGpi3piU41aULU7XrRgWmepEiEGTAgKbbzU6lW1lf4BH15youV13TylMTk/bqAIzPXMOjlHNnwM2krp1VXviXmqLl60K/RPCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m0rYexatJHPHosTmAoG8oqKCtZCMPfup7BJybWmdivI=;
 b=gMb3AqSs4hNICtl/XH2adnZh5bCXNNidmCVVSVbOQpMXIaUxJT5Nxfzgb4huzx6zmSjaptEyF6bDqe/hvoFEy0Pb68qABHdXqVYDwkeNdy3zYV8jc04CALl4cgzQPSQbpx+YdvSH1vUZKhVa9eF7hKocB6CgUNXXT9QXapqKxW4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 PH0PR12MB5452.namprd12.prod.outlook.com (2603:10b6:510:d7::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6043.22; Fri, 27 Jan 2023 04:44:27 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::4014:79ea:392b:b4f6]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::4014:79ea:392b:b4f6%3]) with mapi id 15.20.6043.022; Fri, 27 Jan 2023
 04:44:27 +0000
Message-ID: <6fa315a8-844f-19eb-1a23-41cf8b51313a@amd.com>
Date: Fri, 27 Jan 2023 10:14:15 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 1/3] iommu/amd/iommu_v2: Fix pasid_state refcount dec hit
 0 warning on pasid unbind
Content-Language: en-US
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com,
 Daniel Marcovitch <dmarcovitch@nvidia.com>
References: <20230124104355.119166-1-vasant.hegde@amd.com>
 <20230124104355.119166-2-vasant.hegde@amd.com> <Y8/32rScnCHTacQT@nvidia.com>
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <Y8/32rScnCHTacQT@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0080.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9a::22) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|PH0PR12MB5452:EE_
X-MS-Office365-Filtering-Correlation-Id: 90382a52-b9de-4c74-a880-08db00212bb8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	XWd7bTyMGixjLrk2XOfSlGg2BS2b8oQ24T0xPuOCMLK7w+6LOEjk4UUTYszqlfK4JNhIvZx7T/r4nAJ+N16uOP6QcUBcjMD159U3CEl1lCaWzFuX+InMFIjOjQGwmROx1KjwUX8j3+SeNaRxnWDrvC2XErDPB+fiinHV0mdriNsC9WioxoTymLYcVpoW/R4lrCWqC06udRJcHoBHACtH5f5BCuoIrmGRiqmxoKylNc53DI8zd2bSFrJOo2sFduYMO/jOBW6a+oRu3WiBRejpI6Mzf5qD9psLvpF4X0pbHK38uBgEwZicqjaCIMctFrRarjF5grF0UaCtVL+JcNg+fJ699fNKrrI7x2o+52eW3KH+KItmuILMBLPgTGNbYSBquY+423U3bbyGPUEMCF2KehnQQFDJ3b6ye1hcIKeHNgc0MkyoVi4hPGRJ8mSru0YZj0qd6po1BYkyZiTqePOji+sAUe6nn23p7rze8dwyEcxBhEXVjDpdgcijAR5qFjTQGkUPYd4jSPPn5dWstYBQdwT5fBtYLKwMOyBYbDn/AVoDB8l5c4c98jufpRJlDdf7TXDuYKTSew7vLtqQlnDFFHiNbz32230USRofOKrAmwkXS3LawZZreMBcvrePoQknZ2bHnRvgyCu0RAqjlZklmKIQEXFo2jMgpjX3k5fsuxPsBIPrxR0XdQb70qwPfyNv59YtC5nPq1JIyW5EAfSUB3lNFuZWFcjAOJ6oDstty1c=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(376002)(396003)(39860400002)(366004)(346002)(451199018)(41300700001)(8936002)(6666004)(26005)(86362001)(66556008)(83380400001)(31696002)(36756003)(316002)(6916009)(66946007)(4326008)(38100700002)(8676002)(66476007)(2616005)(6512007)(478600001)(186003)(53546011)(6486002)(6506007)(31686004)(44832011)(2906002)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dzlLdGQ4THVPbmN0Wm5TeVVmbEttdml3Y0lxMmVRMTBZZlg0VHY2VjJwS3oy?=
 =?utf-8?B?VGIrUlpJQTZuM25XeEVjclh3citVbWwyNS9KZUdCVXV4Y3l0NVB0d1pRY3Yx?=
 =?utf-8?B?L0xVNkttZTV6KzE2UkFXTVVOd01OY1BJd25rNWMzU3U1UXpNUHdvZHIvYlpL?=
 =?utf-8?B?cjZSQTFiVHNVQWlFcjFMOWVuVW1yTzY3aStRb0hSVFF1bEt2bEoreG5vTk91?=
 =?utf-8?B?MGhjQWRiR0IvYWhRQ2d5dWw5Qk42dlJFbDFPdVl5cjhWOW9BQ0xZd29BbVNo?=
 =?utf-8?B?cU9PQlFiZnlSV256RlZ0bFgvU1ZjODNjWVNmM2hLaTFrSWpjL3FldGlzTTZt?=
 =?utf-8?B?djA3YXRVdm1CejB1akJLZnpsQnBQTUxKY2ZaY0V1ak5MU3hjTEoxSGMxTGxP?=
 =?utf-8?B?VXcvOGhYNHN1QTg0dG43K2d4TmE0bmJPYVZFczJXU3NzRHN2VE9ZK3hNRnNi?=
 =?utf-8?B?RGpvSjNvdktJUWVwN1p3WktsczFyaXl0MTRFalZIQTZJSUdoOEZKMkYrMVFH?=
 =?utf-8?B?bXUrY0lEYitjWTFBbXlVVWNaRW1zUlZ4K0lmeXd3R2ErampzWGNqcFhvZ240?=
 =?utf-8?B?VjltUzZlMkhiN0VGc1NPZWFQNTRmNGNER28vZkpkdmROaWtwdjFCQk9DOGNX?=
 =?utf-8?B?dlkvelllQStlVkdkc2tBVWd0VmFYZUh2ZjUvR3VnTXhuSDFPOXR2WUZtQzRO?=
 =?utf-8?B?dDVDWCtLTUhpUFJ4RS9WQnIwbTAwaHlqei84WU5YcWc0VmZ2RkpBc0hHUVlD?=
 =?utf-8?B?QysvV0ZnUFp1MSttL29maVptWTY3b2ozSUszSzhwK3p1aGVKZUtRbzBGRG9V?=
 =?utf-8?B?STRpbjhqUDRUQ01RNEttcUJvaXk2aFpLbG1yQ2Q3UGxTZExJTGFBV3h5dVBx?=
 =?utf-8?B?WDFvV2ZqKzIzemR3ZERLUG1CSlZrcXpLQ2VMaVhqTzFQczUzZmlUa3Z2d0d4?=
 =?utf-8?B?R2RtRW9pTHFKNUgxd29JSkJGcEUza0JiQjRtbEFGNXhXcTB1MU1FdW5FSXhE?=
 =?utf-8?B?WllqeEtKRmZjeThuYTdiYmR4bmk2cjF6TmNiVUFHdUZFc0tjUk53UzgwTDRo?=
 =?utf-8?B?S3g0TGkvMlh1NVNPTkFrK3o3M1UvQnA3QTI3NzZRQU5MRCs4QmUyekR0NFFX?=
 =?utf-8?B?MFlWVnhqaC8zcDVoM1JyZjEwZENER1YzdExhNXZQT2tRVFlmTGtBbmFlR1hB?=
 =?utf-8?B?ZDZiVUFpRG9oVjVCMWp6WWlVNDlBR05FQlhNZEhXS25mT2ZhelYzN1FDTWx6?=
 =?utf-8?B?Wm15dmZUcGFwQThkUmRnL0Z4QXFQcmVOb2ZJU0xSWTJCbldMY1BVbzAwR1hP?=
 =?utf-8?B?QWQ1em5HUUEwOVBadWxyMnFrS1M5clFUdEdSTm5Kbm5FaVRZN2diUGM3T1ds?=
 =?utf-8?B?RndjKzhYMVdGSU5wVHBFbkYwQkR1YnpSUkNUWWpZSENjWFZoaFZxRzdLeldC?=
 =?utf-8?B?aGJJTy9Yemg5YkZ1bWdNVTQ0dDZxWmlCQS9OVHJvN3k1QzRMYWFCZ0J1UmZ0?=
 =?utf-8?B?RHhybU5WdVV6YzJtVkY3c0djS0t6S2VmWThma2xJaWhQTWNKUDU2NUxCczFr?=
 =?utf-8?B?S3R1bDJTVjNZdmFnWnliZlZlMVdBZjRVS1g0ODlQWlczR1VMczh0ODN5bFhp?=
 =?utf-8?B?RE1OMzZEZWFtanNZL3B3YVh5N0Z3aGEyZXV0VEZiRmFYVjBOYmc1Z2EwUUl4?=
 =?utf-8?B?UkxSUCtRaG55QTNqelBQSkswdlBSMU0wOE9pNG05NFZLaEs5c3JiWC96YTha?=
 =?utf-8?B?QTd3cHU0UklYbmpUWXVYZElGcndLUDJiamswakZLOVBrK2FhbWNxdG1QblJu?=
 =?utf-8?B?MEtCdzErTDlHQTd1eGVFOWxSNkxhVlRXUHVMOEFveGNyUCtmSWZVV3QwbTcz?=
 =?utf-8?B?NklCcXhMN0NFdUFxV25WYjhIalZwMkEwaVVUS2t1WmJSV3gzZWJBSFZCWGR6?=
 =?utf-8?B?cjZsREE3MlZISjhydU9zT3hjenFxcTdHZU1qWFpZQ2hCbldPczF1YXVEOHVo?=
 =?utf-8?B?K2M5WG04My8zQlFKRmhJbzVsZ05aOUlldGRTSnBFcEZOOHUvQUQrNDhCR1U2?=
 =?utf-8?B?dFJOU3drWXBDZWNBNERTNEhWMlh4bTZxd2M4RUVDYUdWaThCdjNLVGNPTVU3?=
 =?utf-8?Q?rqbc9wmvr91gGKgcG7JyARnbc?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90382a52-b9de-4c74-a880-08db00212bb8
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2023 04:44:27.5342
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZFvCoWInySSKIMh/l9pz45tIyAcmpWDWqm3zO0OYKEi1m68MqUpSCQL4jvXzHufMHKUjfj42ncAaJ9miEMYuvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5452

Hi Jason,


On 1/24/2023 8:53 PM, Jason Gunthorpe wrote:
> On Tue, Jan 24, 2023 at 10:43:53AM +0000, Vasant Hegde wrote:
>> From: Daniel Marcovitch <dmarcovitch@nvidia.com>
>>
>> When unbinding pasid - a race condition exists vs outstanding page faults.
>>
>> To prevent this, the pasid_state object contains a refcount.
>>     * set to 1 on pasid bind
>>     * incremented on each ppr notification start
>>     * decremented on each ppr notification done
>>     * decremented on pasid unbind
> 
> I've no objection to this quick fix
> 
> But the issue here is using a refcount for something that is not a
> refcount. This usage model is should just be a normal atomic if it is
> only counting the number of notifications in progress.

Originally it was using atomic counter.. which got converted to refcount by
below commit:

commit 8bc54824da4e8fcf0ed679cf09ac32f23d83254a
Author: Xiyu Yang via iommu <iommu@lists.linux-foundation.org>
Date:   Mon Jul 19 16:32:58 2021 +0800

    iommu/amd: Convert from atomic_t to refcount_t on pasid_state->count

.. after this commit it started throwing warnings. We thought of fixing the
warning instead of reverting above commit.


-Vasant


> 
> To be a refcount to have to follow one of the standard refcount
> patterns, ie get rid of the event queue and consistently do:
> 
> if (refcount_dec_and_test())
>     free_pasid_state()
> 
> Which implies the ppr notification done can do a defered free of the
> pasid_state.
> 
> Jason
