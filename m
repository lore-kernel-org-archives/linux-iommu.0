Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2072.outbound.protection.outlook.com [40.107.102.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CDF214A9C
	for <iommu@lists.linux.dev>; Thu, 11 Jan 2024 10:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="hFoLrAwX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gcdPw+BoQGPbu3y2ZAiQF+7IxQXx1scP/ecLzbYoaX55UU2tD4f1+SpBz9Qd6LOs4fou0GbUA0KdeoNMECZg41RZeldH4xwNFzwLuCzGxkg0UBNUSp9k+3Jw7XMVhZlaVm+zMczzEGhRrr7WXdVjTmM4I7HV1x2QhRbQHH7C4YYnnccFBlnKR62GQ+7QQc/mxJvPSmsfQ9+66p0pJ28xzL9ZxytWvNvdb5pXE7cO/hbHuEsxi4QCTC0cGxW6rsLXPprpX+zbOfZB11A7k/LRtekMbyIf3jV0+bMZyBqaRSef3yyFLdYg2JErZpg7XeXMok7qh8tOZ51B0E//TarNsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UauyGCrBBhYbsCWeBloFhOIxUkYIKY3zoiw1oe20riA=;
 b=nv5YPnCAq1yzbZg8/RdkO9QR9OmAAibLjhZoKAHjGFQFXAWpv6ngfg0iv4/2gPwmtXrDbWperMS981EP/v8cTyOQK6XONZ7jHsbDboA9haC3tjm5Ixk0grcmkhndG4lX+CAOcrZ5D7WeUqAAhNfUwLWk54uHT8dBQQWaVTtMYGus/8DQLCqlWKvKurRorYpatXopl4539XYKGsnuosHZpXOKWaCq8aTDyaLe+X54i7TmXfKz7Ojq603/oVnoe5hHJfEO7Mkg5W2wEOjGfqxYWmQMriQbA5ab6h5K9CkW2bhRj3wtePpy+0rtPyMX4jCQ37KdS07AjuZ0sKmjxZLnhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UauyGCrBBhYbsCWeBloFhOIxUkYIKY3zoiw1oe20riA=;
 b=hFoLrAwXv0Vf4nUrj4RrFLgZEtUxbPjXxCoolDj8h2ZowoC8SwylgPCKGT4NdiksrVxz+vZYhy4WEEpIzkl9h5R+/vjugmF2I3HkDh0PHs0KT9zwC+j7BMIIcf/nMsjpqcaSggvnHZPqySXxxKgzE6KYQflg7wAscBI/TxrNb0g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 CH3PR12MB9193.namprd12.prod.outlook.com (2603:10b6:610:195::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.18; Thu, 11 Jan
 2024 10:06:45 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::481d:7627:c485:9cb]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::481d:7627:c485:9cb%2]) with mapi id 15.20.7159.020; Thu, 11 Jan 2024
 10:06:44 +0000
Message-ID: <cac79edf-3505-865c-4d88-ebb97d11c97f@amd.com>
Date: Thu, 11 Jan 2024 15:36:36 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v4 11/16] iommu/amd: Refactor attaching / detaching device
 functions
Content-Language: en-US
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com,
 wei.huang2@amd.com, jsnitsel@redhat.com
References: <20231212085224.6985-1-vasant.hegde@amd.com>
 <20231212085224.6985-12-vasant.hegde@amd.com>
 <20240105191437.GQ50608@ziepe.ca>
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20240105191437.GQ50608@ziepe.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0247.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:21a::14) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|CH3PR12MB9193:EE_
X-MS-Office365-Filtering-Correlation-Id: 2cb03e5e-f5c8-4f1f-acdf-08dc128d03ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	+NokGDx5n3QDqUaA8+U6pesKs29Ex1JPsu7fpy0ROxNGh8jHVg1QBhaQXMRCxrQxRdVjmydR8Syemu0h4G4F5qXjgzkBmYvbCEYaSeuxyDzrjeFuhMtKSV2rEOB0ETspB08DDfd1a6xeM3MERhKUwut4KTLh5pZt0Elp3YciKYMlIwCJYe8ly/C3iZqXIfh52YShnfZBmLKWr8vGKdrKcdvr7gagX0fm/ClHVOvqKKtInu8FZ20p17vpxAWYeWJCPmIYhJ3uNJz3ZdH54IOHaTcabRNAQI5DBJ4apRevI9esUZrl77tgsncK3omwWADBHuUwdRDn4qkTSRMXNcRPppIsT8V3lacWkvDIva4gJFsmYoS3SYmimPCYDmQCNTlPsdUMmtmbUUay1OZiOV5yJMc0ETpLwgZVYkQv5vc+cy9vmRsT5qbP52Ubq3+OCr+UOtG8UYchjX30cwbzgQEthHNaPWfMoUtLVm8alco6obrhIzGEvwsNe1pXY7uipiMyIHI49Ml/QkGTLuTC1f57NqcaKOZgCV8WxPKfrgwmKVOvAc7HZytFaI1YjxPI1MWA3XREFJM9h7wX+swYvBCabcz2Gd5xlO9aDpUERJeN5w+J3fIOVsFnV04+zIEzpTKf37daGVuLTxsdKph+/mwQHw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(396003)(39860400002)(366004)(376002)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(83380400001)(38100700002)(53546011)(2616005)(26005)(4326008)(8676002)(6916009)(41300700001)(2906002)(5660300002)(8936002)(44832011)(478600001)(6666004)(6486002)(6512007)(6506007)(66556008)(316002)(66946007)(66476007)(86362001)(31696002)(36756003)(31686004)(66899024)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZFd4YTFJSzQxbXg5VTlPSlBLRTR1R3ppR082Q05MbDFzNmh5Z1ZpbUpWV2JG?=
 =?utf-8?B?STdzRzFHdkNwZFZUbVdBUkNWRG1xMUFSdFBTNzVZZkp3TTFEUnRkeGFadGpG?=
 =?utf-8?B?VkRhd2hQQzdMcGFFWjQ4dEwyUmUrZk5MOGorL1V5YXZ6SG1XaHRVdDNUeEVz?=
 =?utf-8?B?N2JvdHJiREZyTEhyN1J2aUt6WUNtZTFjcm1kKzlJcWEvbmNFbWxCZmlBMkFU?=
 =?utf-8?B?dlBOOGpUOUI0U0w1OHhIT0hlaU9PWDVxWU1VbFJXODNCTkNDZnp1Zm5KZE5j?=
 =?utf-8?B?V3lkUC9aY2dvZzQzbnZxek1UVDZrWUFCbGZSRDlUWjByYnBmMnI3Tm1ySk16?=
 =?utf-8?B?K2ZmdnZEQmtXQU43LzJBVTlIRlFrR2lLZHRobWVUWENIVm4rVG1najduUEti?=
 =?utf-8?B?K2xwcXFXaldES3hpRFovYnh5MytEMFhwcW56RHpRLzdOY0FocGVvSjM1blA2?=
 =?utf-8?B?RFMwcVpmRTNuZXNIQkwrK1Nuc0RDc3ZKeUhrd04vUzNWdExFWld2cEJMMkxM?=
 =?utf-8?B?VU1tZWdieFp0clRMcTZ3eEgrclZXVTZNb3hNcS9JMEJjQk9QaERwVE9EejhT?=
 =?utf-8?B?MDlkQVhTU1FRSHA0TEl3RlcwQWJaeWI4em5uUFFBL2tKUDRLM1FwYkNGQlM1?=
 =?utf-8?B?T2Z0QkhqYUMrWnVRNmZoOWI2MkRNNmFjVzduNlRkUVBVaDNsZzgwdmkwR014?=
 =?utf-8?B?b1lESmEvRGpwSzVvTW9SQ1owS0o4bnVJUkdHRWVWNFRmZzlPN2FYNHVpVGRz?=
 =?utf-8?B?aFRreGpxUVM0UklIMVRXb050dWpVTlFQanNNNkhwMVp4TVpuekFmT3dqNW5a?=
 =?utf-8?B?ekNtQUsyTG5yQTBwVUlWejJiVHczeG13NlRsVnhPL0lhSk9RQVJNanFLSndq?=
 =?utf-8?B?TWZIWFZnKzRyejl6dUs2aEY0dVU0ekFKbFRQRXJoQWhpR2t2S004ODJwWUlW?=
 =?utf-8?B?UHVpQ0htdzB1OUdTdjV3ZGk5RXRWaE90cW1jWG1Bb1hMVVNCVFlOeDBQTVA3?=
 =?utf-8?B?SUV0bXczMTFhYVBRSS9uSDZpVjcyMXFxSXFvOFQxd3RoOTBuc25oSWhmVzEx?=
 =?utf-8?B?Z2RYRnMrdGFQT3ZLdjM1bUNDWXU5SWY3Z3ZmS0lpMUt2c3Rac3pvdzgwalcz?=
 =?utf-8?B?V25SK0t3UzFnVjdxaUc3SFZvOVFqcHNTand6Z1JiTUFxTnExdmdqUllEM0Fh?=
 =?utf-8?B?Vkg5RXhNL0tHNTVWMFFscUtKSUk2RVVsUFpBakVwUzNXajZjZlRRQ1ZzWi9L?=
 =?utf-8?B?Y1AzRGl6b1lreWtmczkvaGl5MFF5Mi9yd1BMVzlpS1N1UlVuTWFMV2VyU2ZF?=
 =?utf-8?B?NS9uckRMbDdZM25EK1V4MFErMDZUYWYxT3ZJc2w2MU5DMnpzaHNEREphWFFI?=
 =?utf-8?B?d1RWVFZ6QUVuakcydDBBYkFLNTQ0ZkxZWGlJQ3BlR2JJeUZWZ1plMWJWK1Nx?=
 =?utf-8?B?Wk04bCtwV1NLa29QL3dGZFduUWJFUnk0UWI2aXhId0RMd0g3TDh3TjJOTTdR?=
 =?utf-8?B?WW9wT1p4N0hZNEw2d0I3ZGNMbHVGelIzL3lsait4ZDJZMWIvRUFnSk1vUlFY?=
 =?utf-8?B?eTJRMlBEZ2lkbkpuSHNKb1J6c2Via1JFQzljZC9BK3VjUzNQdDIrU3Y3Z1Nh?=
 =?utf-8?B?RTRlMXZlRWNoTVg1REh0MHdpUyswdVBmdm1ZcEFFT0VsQlIwcGtFYzlGQ1Q3?=
 =?utf-8?B?Rnkra2JRNVowQnI4dEFKd2g5ZzRZanRtbWZ2Sm1hRjVmbU1KS0dNOFZCS2dN?=
 =?utf-8?B?eldkWm80WjhXZUU5d2VyTmY1Qm5BNHNNeXMvcUp2aEQxMTlIZS9pdGNoeHRn?=
 =?utf-8?B?VjNKRDl6MUpqbUxsYTJ4VGt6cXJvS21SNGgrMTdIbGRqcytPaHNVSnlsU0FG?=
 =?utf-8?B?Q2JnMnRibWpGRWxCN01hNEF3QVhtYklIM1pTRUFtS1BIZlROSjZRYnZKSDBX?=
 =?utf-8?B?b2ZFdlJiT3hhUjZjS0NvSW1LcGVFUld0TmV0aUxUSXUzV252ODh1bHFnZGhE?=
 =?utf-8?B?QklPUDliQ3UzeFJBMHpVbzRreUxTM1V3NElROU53aTJMdG1EQ01LY2lMWWNH?=
 =?utf-8?B?amNtL0czSnoxR050d21VMXVJUUh4ZW1WQnMwUUhTODczKzBNVDRLa1Q2eFlD?=
 =?utf-8?Q?76mECQIzKXxsOr1JKx1S5ODZk?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cb03e5e-f5c8-4f1f-acdf-08dc128d03ad
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2024 10:06:44.5203
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7l0cXC4Ec4L8LgikYiIg4nMFMNsWrSRT9yBZ7C8/IZL7X7T/nT4cWaaYJQ5Tgee/Hz8/3sTPjlXMukJFGqtCjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9193



On 1/6/2024 12:44 AM, Jason Gunthorpe wrote:
> On Tue, Dec 12, 2023 at 08:52:19AM +0000, Vasant Hegde wrote:
>> From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
>>
>> If default domain is configured with V2 page table then setup default GCR3
>> with domain GCR3 pointer. So that all devices in the domain uses same page
>> table for translation. Also return page table setup status from do_attach()
>> function.
>>
>> Note that current patch configures GCR3 table with MAX supported PASIDs.
>> Ideally it should use 1 level PASID table as its using PASID zero only.
>> Later in SVA enable path it should be reconfigured to support MAX PASIDs.
>> This will be fixed later once SVA support is upstreamed.
> 
> ??
> 
> Given this driver doesn't support PASID at this point you should just
> allocate a 1 entry table in this patch.
> 
> When PASID support is added then you have to allocate a MAX pasid
> table or implement atomic resize.\

Sure. Its just fixing param. Fixed in next iteration.



> 
> The patch looks fine otherwise
> 
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Thanks
-Vasant

