Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2058.outbound.protection.outlook.com [40.107.243.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 690611A58A
	for <iommu@lists.linux.dev>; Mon,  6 Nov 2023 11:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="TUgbwLaS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MdJVvUNScFI2IN8KwoWJunF+v+MTDetPec34A605hqIm5tN/WkPlhIdF/frYwwz5X+41+Q495C23BskdaadUBDT95DOuQw+gArkUtUUEMXQwpzms9drXb1H90FzRDzrMLgLmtIxBbcLVxzutBQ4DtmFN3Umbyo0e+GUxNi0kGvCuRmMjgmoB5KHrezwdC9Ytiz47qZyF0iEmm5PaT+ZhAyBz0IsOH6B0IpHIQmAWStwyBV4+4saYoxrfma0ncV6hF7RiM4t2c7RbADckoyfT8n7YNP1UkBy9sV7hxO9hLlhNDa2esyGCMw7FfezOTZWEIjzrQVKgLJ1PcaUk//69/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tILgnwBAsKNaTVvr+i6c7qjpGAmx9McyKjQjKr8uhlI=;
 b=iS8pwuzjdfrp7kFJcfoiXhBYclTDlEo5RzKRb7ze6Vz2WZTAHmKnvVkaH9giz5PzvN2SvEIfoAvPG4zIHExsodPJ8UgzeuquZanE5uCNgXHpMi5ZT2bJRbO5qOo/CBGy2OFlTOPWQ5Os2ThEqVfZ+G53INeLHqVgKlk+Uviy8xedbIaOd28/ie3tv96l/Vmf1/6jSOuk0RN6Ba88zMHMXut8fVXEK2jUNVhw7+XOXwHPDLtlxeStQeXFuueErxSDG1IsFTTyUpGseU2Vsjycr81mdtZdMKO3MjlRNtEgXCvYGmWtPFJN2YZCVvdu/5hKfpZcJXLXnS9/3tiA4CLNNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tILgnwBAsKNaTVvr+i6c7qjpGAmx9McyKjQjKr8uhlI=;
 b=TUgbwLaSN0pwGIHalPMTxsPxnFcWAYVuB5Xm1um0uDjzMevuek0ElaIV6rC5q87f1kUQCFDk963b6XxCVzJRKwuUpGn1zSzzl0j1Y100Nj8QN7N+6fYyxrDm3o7e9OAW3lz/6gNkFUgYdlVxMSRlqbLWT4wP+ZGGbpT6yLagqs0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 LV2PR12MB5728.namprd12.prod.outlook.com (2603:10b6:408:17c::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6954.28; Mon, 6 Nov 2023 11:45:46 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::befc:daea:28e6:32af]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::befc:daea:28e6:32af%3]) with mapi id 15.20.6954.027; Mon, 6 Nov 2023
 11:45:46 +0000
Message-ID: <dec93cf1-4823-8c77-4f3d-a2a1ea74ab07@amd.com>
Date: Mon, 6 Nov 2023 17:15:38 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v1 13/13] iommu/amd: Rearrange device flush code
Content-Language: en-US
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com
References: <20231006101624.5912-1-vasant.hegde@amd.com>
 <20231006101624.5912-14-vasant.hegde@amd.com>
 <20231105175949.GM223197@nvidia.com>
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20231105175949.GM223197@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BM1PR01CA0150.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:68::20) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|LV2PR12MB5728:EE_
X-MS-Office365-Filtering-Correlation-Id: cd33f4d1-05aa-4d6d-a1be-08dbdebdea38
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	K7e9VsKr+uU63IvaXOoTnUu1qPbyPckI2cLJzE8PEm+RGdLyg1et2c9i3hSZq5QwaKUoOsoUnaPeSjBCTX+e2hLgbLxUpdD3NHGV2fL8XczUbCeF7/m6JQXen7CtN/sD4kv2eN0zZwo60RXB5Ab45VbMAn1hlPB+/r6A0dVUwUGqj9AUgjoKxBtmGg6d1YYEl/OWve8/EZDPQN6wEMqDkG0SXEmUEosvGFOeCDtSHnH53v+4q7hJRFplnlrRYBC/jxVzuixTGSVyzM5lxj+oYFzBHsnHpPdWqxBP1VF9Ch/F1CmJAWPYMaVNhYMc3KVrv1hYUqwEq9Dp+sdauja5lEu9ic5pbTTDzSH4lVNf+MhZwTarJWgLculjE7vv+B/rj13N/tIb1hITWUEcoPtE/sQfY6FnKr1nUHyJnacbfuI1iDLRih/9qsKKVLQR1P7JOMBAt6oGAMrTStLwA+990ElzdBPb+iX3HuYYqEm4SuecmsatY1x5Z1Gyl7DL5Jv7H1q2iHlQH2si0Db2H1+egkwiI6CngkAeB8hH+u4dRatzKIZxOgSGZNSq1szaYS7vQT8ih9sNxGaGRP+MZwuKHpZQjkVWa4jg6YN7ziKdhdGWaW5F3kArTAW6TzU2eXGu/3H2rUbwnEYewbOG+5EJew==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(376002)(366004)(346002)(39860400002)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(83380400001)(6512007)(26005)(6666004)(2616005)(6506007)(53546011)(316002)(478600001)(6916009)(66556008)(66476007)(4326008)(8676002)(8936002)(36756003)(38100700002)(4744005)(2906002)(41300700001)(44832011)(86362001)(5660300002)(31696002)(31686004)(6486002)(66946007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bkNuelRRN0xtN0U4L0JqYXc0cFFMZEoxOUZuN1BJaUY2K29DdlVUbFRsYWxV?=
 =?utf-8?B?TkhMWlpQblpETUxMVzRnMHdDVlhMRjBMNkRzV2w3a0c0bHVrdVhhMHRkak9V?=
 =?utf-8?B?OTczdVVvNytBd1MvdDlJdDhaci9JVVUvUVNlMG93YzM3ZFRCVHVOYVNneklm?=
 =?utf-8?B?SXQ5cFpMRUhpRVlHOG9DRjBKQ2RMTVdLcWswaW1xUmR0T0Y3SVZRcGcraXpz?=
 =?utf-8?B?Q3FNM0cxM3pia0d4OFBFSDNMZ0pPUUtEUmx0cldlclJKL25NbTZUa2RFdjUx?=
 =?utf-8?B?UnZwNUh2QWhxUTZFMGxCZ1JSRTVZN0R0ZFpCWDI0TFpjV1QyUWhoRkFLU3NS?=
 =?utf-8?B?TEpvT0xVVzhNNGJYejhTUXB5UzZwNC9KOUVCRkw3WVFjZkxyNFJpbUpDMmx0?=
 =?utf-8?B?WVFuVXJJOGdrUzQ0VU1NM1Z1RmRldm5TTTN5TmdjRnh0RjJVZlQ3UDBtdHNI?=
 =?utf-8?B?Y2xZZmU3RUZhaFJDeU0zaStaZEdjOE1wOXFJSEZYT2s4UGRsZTlEbGZ3QmJm?=
 =?utf-8?B?OGxSa2lTWlBPY3Z0eFZRMlBxMXA2WGlLQTNod3haK2Z6bDd3MjJocFA2azVw?=
 =?utf-8?B?MnJDa3AxUmdDWlRIbS85dDcxMzJSeC9YV0xaeHRub3VLcVlhVStGbmtxWGxx?=
 =?utf-8?B?USttSkNybW1qZG04d1VFbWdIVlFvc2tuajdqZmhLQmloZ2RwZm1ybTlpT2VS?=
 =?utf-8?B?bzhLQndHZUM0bzhzVXJEUHNuSmlPRXdPVkJuSXpaOVdVSXZHKy9EdHF2THhE?=
 =?utf-8?B?VmNGaklCRmNyWUxIajhZWEhLbGxCV1RsbUJtZGVrZm5wck5ZWEpucGFnUjRy?=
 =?utf-8?B?YzBLQnlGck5QK0dGUU9udEt6cDkrR3hnWkRJWE1zZk1HUWw1aVR4QmN0amk5?=
 =?utf-8?B?OU5BZkNvTzh6UVVnZTk4bWZmMFNkQURRSjZ2d2wzajhYSkVRbHpjSEVZOHh4?=
 =?utf-8?B?MkxzL3FMSWxSc3lCNGczUUIrVVFKYVFOVGhmUFo5NkVQZitUQnRmUWJXa1cx?=
 =?utf-8?B?Y3ROY20zbi9uMWF6elE5emRRYVNoZUlucmhTeHlmZWNFNkE1TUhhb1RaeDBq?=
 =?utf-8?B?WlVLV1RMQjlEQ2JXS0JBWnFabnZCZ0VsWDZLMlJCSjZTbldINnN1Qk1YNG41?=
 =?utf-8?B?UHlLNTVnMWNyb2NCekFUd1RwWlUwTTNkS20vYU9NaHBlekhpeGtOazZhV0JM?=
 =?utf-8?B?MWVaNWtrWkJXT1VIRlhTem12UWpQeGZyWHlYajVNZFBHcnJHSXdvb0JGbElL?=
 =?utf-8?B?UFEwQ0YwZk05eXZPU253Lzk1UzViN0lrSnNJS2Q2VjhqTGtZcTI5NzFFZEk5?=
 =?utf-8?B?eE45UXJJQ1IraUhjdUQ3NHFhWHN0NnNVYVNmSDFBc0I1OWRYSnJORWhPOWU4?=
 =?utf-8?B?SURvYmV4OVA0L3gvMXdhVmZLSFpDd0hiQWlNRUdwL0h2SlBUYnYvV2dpTHBS?=
 =?utf-8?B?S29aOXhLMUEwYldlMlBmSTBWMGlvbUZoUmxobit6dE5yT0hTY3BjcDlHSkVk?=
 =?utf-8?B?OFAyd09xekl4K04zc3Z1TkF5cmVnWTZMV3hHU3hOdjNTMm10c2wzMnZ1ak40?=
 =?utf-8?B?RU9mcHQzVnNXZ2lzNjVOeFdBWFlpb2gzN0ZXN25OaTNOdUR6VFJoL2pHd0xX?=
 =?utf-8?B?OEZ5cUdLQXFZSzJITGkxb2Q5em41K09MeUs5V3UzN1pGbzkwb3NuL05ORzFJ?=
 =?utf-8?B?Y1pLYUpicHRiVTJGRGQxVG45Tm5nakNSUCs3aDVvOEoybDNxc3R1Y2kySjUy?=
 =?utf-8?B?SWR1RWJDZGlzNGJ0RjMrV2VKQVJEamdtc003aE81YWtGSy9pc3NmeXhwWlVB?=
 =?utf-8?B?ZFUxaUYzeTFZTVRmcmhQVVRXWkljN3BKdU9nOVhuNVViQjRnb0FUVVhEZDF1?=
 =?utf-8?B?dkRMTmxwbmpwWDFZSXFOMmpvYVhWSXF4N3VQclA5V0VOemF6TnZJVGkrQmFP?=
 =?utf-8?B?aEgzbTUxOEJGUUpnSVZ2VjJXd0hiN2VXVkRpQVAwZy9tRVpqODFuTjgzbkFu?=
 =?utf-8?B?MnpXOUE1WUpKMnVodEErV2pPZ1FVUHhMK0JrWThucXFpOVY5K2hvV3Y2MXlP?=
 =?utf-8?B?QmhxVUtpeWM5K3NtdTgyV0hLVUdkZEZUWkRmckxUdnRYNElrRzBTb1pkY3Rz?=
 =?utf-8?Q?XiXQ337nlooopsFKF4f1r9iR1?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd33f4d1-05aa-4d6d-a1be-08dbdebdea38
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2023 11:45:46.6122
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tfiWovafYtklQ+7xhOvcd9mUresL9fyfuFZ7v3MID7D/nNgBTcu5u5emvFhbm7jY/N/Iu1zKQRRohoT9SLD6TQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5728



On 11/5/2023 11:29 PM, Jason Gunthorpe wrote:
> On Fri, Oct 06, 2023 at 10:16:24AM +0000, Vasant Hegde wrote:
>> Consolidate all flush related code in one place so that its easy
>> to mantain.
>>
>> No functional changes intended.
>>
>> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
>> ---
>>  drivers/iommu/amd/iommu.c | 105 ++++++++++++++++++--------------------
>>  1 file changed, 51 insertions(+), 54 deletions(-)
> 
> On one hand I wish to do this sort of code motion quite alot and agree
> it helps maintainability to have like with like
> 
> But, in Linux I generally discourage it because it overly harms
> backporting for quite a minimal gain.

In general yes. I don't prefer to have a patch like this.

With removing iommu_v2 module and consolidating all flush code, I felt this
patch is necessary for long term maintainability of the code.

-Vasant
