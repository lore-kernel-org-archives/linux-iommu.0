Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2060.outbound.protection.outlook.com [40.107.243.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 274FEA2C
	for <iommu@lists.linux.dev>; Mon, 31 Jul 2023 06:35:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S1HBp8seybF4k0VyQbT48/8NUxzACNPPfbVnvNeOV+bP1HiJ8EXv6qE8Ao+q61YjVnEHgwl2CH8AsPZ844CQKMtfS8uINEZTN+Xv6/FwgfqrRWPZYfR1VypzPc7i6OcQBmedItvM7dpPjE6b39rcx3vjlKVVtZ6gxJ7gSwKfRzrhTXRUlIhNW7X+ZGmDNDA6eX0zL3X/C1/7wepBAYg3cs+nTHNW6LvvL4jRJqs5TAilARq4KWzrgCeVXj71IiWAyqSR4XVbH5XUvZkCrdN+gbxYITt3egQF8983wJR5XgzcYarNVtsPb/RlXZa6bF/1WvJ7iJeepHRoUdQnDsXcBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ne/h+bg7vA9d5AA25QN0sAGlZE2pXlX3QeoKJD2qg6Q=;
 b=Z8QpfL+Js/Kb3hYsHevO1OKrXRyYzDvHXdL0npzgGD06jhVYwFzU/MHUlrt7smjP8tM4cGlaIKEsXxATBGON0TASTSwKvDVs368ce3zczDIvAimvDAlX8jqNL2DTX7oMZAL2qucD0ajyNqluoHCElFSLzKsRsm5YqwSMfPYsG42KW5LEDbzPeb9ftIRD7wck9VorQpIa8z2yhTYdS+8PiDPZcbKg7L9S+UojZ9tutxnXsKIdI+EPRvcFky8HfW9s+Y6UJUdgpIwu31Z05BsOucEBD9xUqcNsjWr6vKwb1a+pRhIbMkd3zz8kqDugpsv2r8a/K5VgiX5l5bho18mcyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ne/h+bg7vA9d5AA25QN0sAGlZE2pXlX3QeoKJD2qg6Q=;
 b=CPGpCO5VZOsyuYD+kkS0CL+eHDSYq/vCUYJCO8YNs9/EVbcKI/zH4/JTylqlg9IR9zR754m5zzFJ65tmwIL3W5Dq39Ff/OqGkg8Ht8QFDekOuJ9tFB6a97O0GpC2F83Thwen23phHZwFoXYbcZkiiPPI2WouV59N/osiB4rE9Uk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 DS0PR12MB8788.namprd12.prod.outlook.com (2603:10b6:8:14f::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6631.29; Mon, 31 Jul 2023 06:35:39 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::67ec:80e:c478:df8e]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::67ec:80e:c478:df8e%7]) with mapi id 15.20.6631.042; Mon, 31 Jul 2023
 06:35:39 +0000
Message-ID: <16a0a4bd-6de1-4d16-5dbb-b60fbc81bbfb@amd.com>
Date: Mon, 31 Jul 2023 12:05:26 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v2 08/16] iommu/amd: Do not set amd_iommu_pgtable in
 pass-through mode
Content-Language: en-US
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com,
 wei.huang2@amd.com, jsnitsel@redhat.com
References: <20230728053609.165183-1-vasant.hegde@amd.com>
 <20230728053609.165183-9-vasant.hegde@amd.com> <ZMPMm4QYPKRqO9mj@ziepe.ca>
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <ZMPMm4QYPKRqO9mj@ziepe.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN0PR01CA0016.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:4f::21) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|DS0PR12MB8788:EE_
X-MS-Office365-Filtering-Correlation-Id: f6048224-2a39-44a3-ae86-08db91905af1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	dxf6ly6UULNxll1qa9P4oxILNMeGEzs6EnRdoDMyO+h1n1kkG4sxKicW/sI6qFGEt5YNh0/RfvjskTzOh95ewK4kAYjr6kLJzsuK7qJ9b8m8FXURxZm9VNfPxkbPT/IJkdOcn36ENgdcDqjseNI/SD2vVONbZIc6gCs0OPw9sPCOontYmWs8C0qDrKhgAHw+Q3aDxWMSL1SNfr/1HtttvrDxo2mxkPSPqE14mE5c0oL7lw7AQ4ve9xhDMStSxsqDZypGYE2+dv33th2ZIgiTO5dGmKpWBgHpELD8JgEEb03W4xOZmeQLmyVwItFgxutKh2X2LRKHQ6lrB1uiU3CN/2QhLiS/sDHi6300DOZiypsTDzZ7nzaQx9mfGmM7NqQ6ezGOeQSuZUf5KThamyx73UmzdJl4gp2kZyihmI0wsy2D/y0FaTAQdv67k2f9hTnsxuOhhU1o85Y2mZz/PUQNOPtkveKbJ1ZpIH1seAhRCibhzMxxxtIQqFXUP7lMS9pyV2/DclMpzx+yW/9YmrVuOZawyY6KDKgmXKnNwUpRQQne/Z7AunCIeYibDZFtXlAHeyljjcnDzT+o9CR7nKAAFes4pwlA10rVzfE7IASiRHu954BQ/bByeV8XFBjvuGfLmEzIRN/cejVK73G/6OOlCg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(346002)(39860400002)(136003)(396003)(451199021)(2906002)(4744005)(26005)(6506007)(86362001)(53546011)(186003)(31696002)(83380400001)(38100700002)(478600001)(2616005)(36756003)(6486002)(6512007)(6666004)(66476007)(66556008)(66946007)(41300700001)(316002)(8676002)(6916009)(8936002)(44832011)(5660300002)(31686004)(4326008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NkhOZ1BBVVhVVjVmamhJTjdQbytiSFFZSm4rQnU2eHBLcnBHL2V4cUwrZFpN?=
 =?utf-8?B?R0ZYN092OTR6QXhxVDE0WFJEVmV0SGppcG02anBZR1NJTlo2eUxKRmN3R2hY?=
 =?utf-8?B?TzYyc3BkWlN1NUx2Z2VIK2wzS25tQndFbTdTMEtjUjFBdHNLT040WnU4ek5E?=
 =?utf-8?B?VnpOTTF5clViY2VJb2dKUjJHdXV4ZzE0SktzWDFkMUhQQWxXZEtMSjdoUnh6?=
 =?utf-8?B?bzJKRVBvMW52dWIwSFRNZzRRd1IrZnFFbm4zdzJzdmM0RmRyWTA1WG4wTU8z?=
 =?utf-8?B?QTU4RyszY2Q2L2NOUDhpSTU3RDQ3U2d5VnAwbU80WW9FVmxjZ0tNcGxhUC95?=
 =?utf-8?B?T2hPWWpMdmVCNG5YajlsdUU1MzU2MURYcXYyU0p2Zi9TazljT2c2b1RsRHV3?=
 =?utf-8?B?UlMvUWdTMFZndzMxa2Jzd2R0bm9UMmNGeEdoN3lSVFcyTGxMeEowckgzM01C?=
 =?utf-8?B?L3htYnlsbGhKamxHZTQwWVZnd3BobFJXTHlab1dDRU5qMExveFEreGpOeWtS?=
 =?utf-8?B?NzFjek1zTHAyYmVFazhaUmhJYkdQVjBMVXZ0MlpWOFlZYURhMnZERFdvS0Er?=
 =?utf-8?B?alM4dGFGZVNGUnl2SGQwbmVWUFBXUlZLZjVNZkRXMHdOaysyU0lFQ3pob0dr?=
 =?utf-8?B?NnZvdkNETTYrWktSamMrYUJycGcrUk0yTzhUNmZYWEovaEVTd3hLWmxVOXpK?=
 =?utf-8?B?b09rR2Q0VS9vVjhnZHVkSVAvWURqMGFBaEhRbGgxK1Q0OUEzN200R2VSb3Mv?=
 =?utf-8?B?WUxtaVR5WEQ0c3dlTFBlbjhIRnV5UFN2NTdadzQ1b3lEeVdDVXpxeFlLTG5B?=
 =?utf-8?B?UTJtVVlNZkxNWVJYU0lISDQzaVdZbjdmQnRzOEljOVF3TndDWUZiYk5WQ05X?=
 =?utf-8?B?K1VUSHArSTdGRXdnR2JkSXBSdGlYQWxxMnluU2lFN0gxZW5oOW5oVTBhY1c4?=
 =?utf-8?B?U211dlFTSlpKM1Z5ajN6RVF5Y3d1VENKWm9qVUJ5dDRmUENoT29vMWFhNjBq?=
 =?utf-8?B?eEQ5QjU5RzBJcU4zRmVObGFsRWJReGh3bnkwN0tNeWdEaU9iSjhwRjgrK2Yv?=
 =?utf-8?B?UTMxQ3hSWkxwYi81M1pKdlkyaDNJcnZDQlp6WTYwYWQzVTNWcEFMeTJDZVkz?=
 =?utf-8?B?cUFjT2laWktXc3YrNnAra0NPeWdDTm5nK1lCbG9SZkpuRUhQZ2U4VVV0NXVG?=
 =?utf-8?B?Tit3NUJxMGdDcThEZXNUMjdBMUpHbkRiRkFRaE56Z0xkUktleGJaSGphT2pT?=
 =?utf-8?B?aXdwR2NtaEM1b0MxYVlycmd2RmFKZk90d1ptSDN4TjNLNWJoZUF5YkhlR1Jl?=
 =?utf-8?B?ZlhhUUZNSzlZU21XSDFRUDVCV1dDc29BSHdFSmV5dFNlMy9yWEw5OTUxQmZM?=
 =?utf-8?B?bVhZQitTZTU2ajk5NUs3c0F1a2h0UGtOWkd0ZWlyTFd6UkR0eFlJZGlpY3gz?=
 =?utf-8?B?YUtrcWZZTnZ4dzAvVlJxeUZWWk1NYkI2NHpyMGJYNjJwVXN5d3RXTjhvVCt5?=
 =?utf-8?B?V1ZDaExSeVZJVGhESDBoNnROSWhuTEV3NFZpc0hhT2xsdlFvWDJQZnBpb0ZC?=
 =?utf-8?B?RnI1Wk1mcDRJY05SdEp2ZWNUNU1nL0JTRnhVZFpJWnBVWS9KdWx3ZEZveEgw?=
 =?utf-8?B?bVlXVnNUVzBHMjJCN25jWWJLSURvbiswaExpcEVBcDNERjV2Nm5wdms2eW9L?=
 =?utf-8?B?czA1SVFuUXhHRkEzVzBhSmpRd3R6ZWU1QXhuMEZEaE9obUZidDZoUVNFSHRI?=
 =?utf-8?B?T2RjWU16Z1FtQmtHV2JqWE9UV3cvQnAveWZ1eEVVRzNDRUVmUFZ5RFdUSzVT?=
 =?utf-8?B?c3BQS3ZyUkozN1hmZmM3ajlub2xLSEU2RG0zNU93N3JUeW8wL0tSYWxnUjJl?=
 =?utf-8?B?TlByQkExTkQ3NnZ0YUhLcDFTOXprdlBDZGJXN3RSaGo5TFRqelBKd2pUNlZ2?=
 =?utf-8?B?VEN0WVB1amU5RUhmdGJORnNVbnB1UFQybVBxY1RRS1M3UmtvMVYwQ2ZTcDkx?=
 =?utf-8?B?VEh0elIyZDVkMENXcnR4cVRGWVdwQWNPdWk0MXFId3FxbSs4ajRaeHFseTlZ?=
 =?utf-8?B?SlhSSlJzYUFBZ21IaU4xd2h3aUE1c05WYjJKUjVVeXhmYnVmZXdETlFKNzI2?=
 =?utf-8?Q?zf3B30P7hr/cQNBnquZW8LeNo?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6048224-2a39-44a3-ae86-08db91905af1
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2023 06:35:39.4051
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iMQOxfs1KaoNf9tJzKOSD/AFRhbw15DuzSgygHvucPE+VoRkjBY5jsdpEcGmWGrcR4AP91hOLhCBDdgIdDa0JQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8788

Hi Jason,

On 7/28/2023 7:41 PM, Jason Gunthorpe wrote:
> On Fri, Jul 28, 2023 at 05:36:01AM +0000, Vasant Hegde wrote:
>> Since AMD IOMMU page table is not used in passthrough mode, switching to
>> v1 page table is not required.
>>
>> Therefore, remove redundant amd_iommu_pgtable update and misleading
>> warning message.
>>
>> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
>> ---
>>  drivers/iommu/amd/init.c | 3 ---
>>  1 file changed, 3 deletions(-)
> 
> I never understood what this code was for, happy to see it go

It was a mistake from my side when I added v2 page table support!

-Vasant

