Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2054.outbound.protection.outlook.com [40.107.92.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5777615C15F
	for <iommu@lists.linux.dev>; Wed, 23 Oct 2024 08:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729673535; cv=fail; b=e5U8qs73tEHy8k1pFoh0eWwAemSGc0m8hxFYCWF6MdEk1CJ2viRcHNQjCCR1fUeWItD+GuJ2VtVC5fHuXcxWMJoPJUgi5kF7UqO6CCzeBaIp5Dhbz4stUzeTJN/JMe63KvEP6HlRTqPh05VAvKrABB16NRsqVriFLf/e6AwbSCo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729673535; c=relaxed/simple;
	bh=7Uh5x87cd7Af5iQjsKGu+Xs5amn5BaP01YITvqRDAPM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=e+d++ArgSI0rsjIQe3YOy7UP23/4TbvEB/Sk0L7meWFO2c+CWQkBeaDhKIutKIfdETQrvqTIxZK3rZjpGAhjDExeFkoBVoXMFdOngj3WKXwXFpMJnvQkLwKkvrryWqeLp/+LNkBda+R8dKRX6NK6p8DZkuofXTH+K3VzUO6Ia08=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=cYLzVscR; arc=fail smtp.client-ip=40.107.92.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="cYLzVscR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DmklXqTz68wxRULk0F4cPAT8hOITFebvHgIORQghs5YWUA18ec7HYWXv7z8xmeXFdbbJXnlYiwnkoz8Oh5MNwMn8BQeC4B/B0+mih83o/A8iKzY+0p2mHYukw6opqp3FdRTmQ1nw0tq8NtAB5JzPXJUC9gE9NVaLQkwlxT4JgzH/IwBd3SFEFzzmsOJcckhv+4I/HBXUlSoMOptgZz8vzxumvcgyoQl7hBnf8kxrKw/x+rc/+beNVUX0/Z+hKDtBFOayjZ8oFIKzNpMAVhr7je2v76qRF/ULRbL9nFOQwidoIs25CCux5NF6nixUpSG8z4KyLpaKkI498BH/sYte+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3EGLtDETNm5+FfPybIXngWcUS3zmfj6rdnFV420UBw4=;
 b=QBUmxB2fhEFZmwv94/zo+figbb3xTn18/tkp4OIbOBQ3Zifkfohaygk/Z+jtF7KQMuWWWli9/tYYb5ztTodKsFd452LKNthO6kSojRN8U0fg/Q99pRRuUsc7/pS9dYchkeEJpRGGfrXbfNxA9OIBsMBttSWxpvf267vvEBECsS+GDMR9cMsWLRkf5AQvuiMl2LSjTTexTrQEkygtgd490h4BsEvcIc/b4qn8Fdp6mdMxWEzNtpbMthPFYvtSovhrGM4QQv41Q1+iwI6vmgopQPWTXARp/FA9KUYZoLBe5NfUN9xaTsAvoqhs3oS/kJqNHQIQw2rrIkvATeb+/o+SHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3EGLtDETNm5+FfPybIXngWcUS3zmfj6rdnFV420UBw4=;
 b=cYLzVscRX7AuvRHmqTUoFIjxh8Vr0X5hVViwP5iACg41Vzso5/vP4Lo8LVdwMeiYGdBAChyzri+VMt83QdFVvxAK2bRiWOy7QzAVICSGpn9WlWt03H4SwtGM/6Af8qxuY/Lmjr3qbWIS4DvGBTqg/lyldm+uhGumuerJ+lYQjUk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 SA1PR12MB7295.namprd12.prod.outlook.com (2603:10b6:806:2b6::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.16; Wed, 23 Oct
 2024 08:52:10 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5%4]) with mapi id 15.20.8069.027; Wed, 23 Oct 2024
 08:52:10 +0000
Message-ID: <3640a45a-ecee-4c7b-9ee8-13799e4045f8@amd.com>
Date: Wed, 23 Oct 2024 14:22:01 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 03/12] iommu: Add new flag to explictly request PASID
 capable domain
To: Yi Liu <yi.l.liu@intel.com>, iommu@lists.linux.dev, joro@8bytes.org
Cc: will@kernel.org, robin.murphy@arm.com, suravee.suthikulpanit@amd.com,
 jgg@ziepe.ca, baolu.lu@linux.intel.com, kevin.tian@intel.com,
 jacob.pan@linux.microsoft.com, Jason Gunthorpe <jgg@nvidia.com>
References: <20241017140137.6028-1-vasant.hegde@amd.com>
 <20241017140137.6028-4-vasant.hegde@amd.com>
 <f2871fed-3d69-4f68-9d82-53b619a5fced@intel.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <f2871fed-3d69-4f68-9d82-53b619a5fced@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2P287CA0003.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:21b::17) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|SA1PR12MB7295:EE_
X-MS-Office365-Filtering-Correlation-Id: 1af70689-8431-47f6-a469-08dcf33ffae0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TCtraEI5dVh6RGYyMFJJb1BkRm9YT202V3E5bjRXdXZ2YzhPL1FPZGxrTHRm?=
 =?utf-8?B?anUvN1FSQWdscW9paWdEZ0xxVkw3MjUyTXFJTnlkcVRDdkpWc2pYV0JxbkdW?=
 =?utf-8?B?QzRieFZyZnlJOCtBUklQNDdWclhldmN5MElxUFBUTnhlZGhpRjhnMXpJbXUr?=
 =?utf-8?B?VmtFWmlsNy91US85K3o0aDFYYjRrTW9Tb09XK3hMbDhsdmc4bldMMGdpV01X?=
 =?utf-8?B?cGo4MFpUUlRUbWtQZW9TNWwyNTR1Q0pCSEZmQnhsRFMwTlIrM3hMZGZyRUZJ?=
 =?utf-8?B?MUkraU1nN3haZHFmRUt4N1VIbGNGcVQxZEhPZXpNazVpcHZXOXl0RFJFQVUy?=
 =?utf-8?B?RVFtazVaVGRKVnRzNVh5cEJnWk9EVWx2WGp6VllpTEJZV3o4N2Vqb0NhandI?=
 =?utf-8?B?Tm1icVhLT0dvanpEZG4rTzlnZk0rSnZhWHBoalpnbERwWjljaC8zT3dVcTdJ?=
 =?utf-8?B?Q00yQkp6MEEraW9aRGdWVWcxOStsblkxSVREWTFKN1ZuOWxVM0JNN050OUFa?=
 =?utf-8?B?TDJjZkhtTjIrUGh1SUlueUhqbDJXSk9VVzlkeE4rOW5zcFhaV1pSTFZmMWIw?=
 =?utf-8?B?WFQ3V3YvYS9XSDdmSTl4NEVidE83L0xEQnlIMUZNMlFCK1V5R3YxTWwzQVFZ?=
 =?utf-8?B?Umg3NmlocGdqSmU5N3RVN245YmU5ZHh5RGphSlJlNlpPR0VtcVdYUmQ4RU9O?=
 =?utf-8?B?b21XcXhyWmJYZDFiN0d6WGdOclpBeFBKYTNlNGxMK1kxNUlqdWh3MGl2QVdk?=
 =?utf-8?B?VTRvOHhkdXByZ1VNbUt4Szl4OHEyT3NXMFJiL0VqNlNJbzVUYzBNV2NlY2Zu?=
 =?utf-8?B?djZkbjlCaDFKR0VPMmFEQnVmTG1vazRsa0hMQm9pSG5aRlNqbENjL29HNzBW?=
 =?utf-8?B?MzJxdUNrN0tKV1RIa2tzTkdiWVc3R0FYTEp2YnJPUThXdWZ5Ynd4RDFDajFE?=
 =?utf-8?B?cU1ZUGRZeEQyMnlpOEF5QXl3TURGcEpKbkliOTZoblRsdWlSSXhvSHhVR0Ex?=
 =?utf-8?B?UVpFT2k4QjErMVBHTEM2K3Q4NUZwWFFCNzE3VXpMWUZOZUpFTTMrVlpvOFVz?=
 =?utf-8?B?N0NOK1U0K0g0UjZwdjhlRXJLVU9Gb1F0TGY3K3J6ck5kTHVGZThkRmp3SzBq?=
 =?utf-8?B?VkZhdFE0eEtXN0RaM294UjNBWUVvT0oxMzI2YzVQaVJHRHJqWmMxWkt3SnZa?=
 =?utf-8?B?OEdIM0RGQXJZSU9yb0dheGNraHhGTUcxTUdHY0JleGI5T2hyL1FhdGJEUFYz?=
 =?utf-8?B?MTNkLzZMSE1mYjhrMm8xRm1LUVplSUZuMlZpdXNacVRzNWlrVVY2bVZzOFNE?=
 =?utf-8?B?M3JxSGppTUs0OXNOT1pqSEpWVUlpb1U2QnJET01IblZydVQrQUtQTlB2NW9I?=
 =?utf-8?B?MVZSN3dTR0NmTEg5WHJyclRZaEFIeEc4U3RvUUNWSm1TejJhZ05SSmRPRGMv?=
 =?utf-8?B?Z2FXeUM5UkdxMGgwWHJrYUErMzFkRGJjYmxVM1lQMGdYbi9vZ2l2cExLZmhC?=
 =?utf-8?B?aEM2S05IS3lDUGtpU0pQOGJSUEUvMWpONnNBZDlGSDhVMzBJQm5vRlh5K1Rm?=
 =?utf-8?B?Vlg5MHZia2lSN0pxcEQxT0lCV1E5OGg2aE5MYzdvNXdHbnBwa3pmMDZtVTUz?=
 =?utf-8?B?RVovT1NKSkNGS1R2V3FMa1JwNXl0Qm5HSkVyTGlqT1hlSTcyRW9uekF4TGgw?=
 =?utf-8?B?eldZUW0rZUo4S0pYMUkvR2dVYVZwdmhlOFlkdHV4UzhjVkk3Z1l2ZWVoWGhX?=
 =?utf-8?Q?MHOAHtJq4ANE4WUuqdqxhhLHrfR3ZuDZbhRdeKS?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QzhBWlYxWngwK3lFaDhIcURGQnVpS0p3RGZ1R2dXbkJZV3FmcFpLLzU3bldY?=
 =?utf-8?B?VXdEOFh2aERLaS9ZanlXM1dXdDV0MGhraUYzTS9GbFpuMnREc3ZhQkhUdTdp?=
 =?utf-8?B?TlZ3SFBsUlNTOWxpaHd6aFYrVThoamlvbzlYWTd4WXJiR3dYWEFGdVJJSHlR?=
 =?utf-8?B?ejdINEIybG1vWVlFVW1zYnNsQWJLKzgrQ0ZMNG0veGFPTEcxWmJzMVVRRFZB?=
 =?utf-8?B?OTZwSnhTNVVUY2VpNGswNStaSWhBejJHMmZUTTBVd2g1MFFBZDJKL0xQdUdJ?=
 =?utf-8?B?UEl1OHEyVk5SdDJBV1RMUEZaeENmb2ZEWks2cXZBYXhoVFpoLzdBZHFYZTNv?=
 =?utf-8?B?d0pTdkFCNHZ5aU5vYmlKeGRZSFYwZk5IWnZSUmxqcXY0NUhSeCtkNUFZTDR2?=
 =?utf-8?B?VmdsQis3MGM0ZHc2RDQ5ay9TNnFZSWZ1eEpxbkQxRmdqMWUyaVNFNmdUZVFz?=
 =?utf-8?B?K3FWeWhRdERyeWkrYi9McWJEWVV3VVNHNGlRaWtoYng3ZUdwbllZNXZqbGlC?=
 =?utf-8?B?SndLYUFzQ1VacTYwdmFxeU5zd1ZNZWpQMk9DNlZuVDhJWGp3VGxsaFZQU0ow?=
 =?utf-8?B?MjVGa0V5MFJWMTAzRW5RcC9vT1VrdkwrRDdpNUw1eC9IejZaa09hbmw1ZnZI?=
 =?utf-8?B?YXNFNU9xV011QkpXdDRxMDd0QkZ0VEUrc205TkU3eGgreWY0WS9YbnM3WHo4?=
 =?utf-8?B?RzNMV0FYSktwSER0dER4UFRwWGVmci84bGFCU2ozQXVuQmg5eVVXY0JyMkNQ?=
 =?utf-8?B?bDhwRUZkWFV1NGNxVlI3b1gxSmxkdnYxd1dFRTd5MVZsRGQ2bkdXZnlhS0sv?=
 =?utf-8?B?VnMwOXE1S2RBZFROcjY2TWVEV3N1Z25hVUhhTVd4REpNNDlXR25KRm01OWRp?=
 =?utf-8?B?dkpvWU9NVndjK2hSYWRPZ01OWUptWUN1QUJ4OU5UTkFyQjJEL1lFaTFJOFNC?=
 =?utf-8?B?Y092S0JIN0srUFFMZnhISmdaampldkRkN3lBd0hFRXRSNWxZaE1sL0xuTXJ4?=
 =?utf-8?B?U08zNGxVZWZ3VlU4clU3d1IwV2VSbWg4WUpHWStnV0ZBdVU1V3Q3NTVGb1ZG?=
 =?utf-8?B?ZVNQYVhoY0pHcnh2VnV4NmtJcnBJVFVVV0RXZnNGbnZUSXRVeUhQTitVQ0JE?=
 =?utf-8?B?Z01VVThxZW5uc3R1Vmg0OUJwT0ZIWUxHZFpzUS92NUd3b1hJVzN0Y0VhYWJZ?=
 =?utf-8?B?RmFNYnZaUXFTOHRORjBUbENNUk5ySzU2SzlEYlZod2lYVjU3SDkydHB0c1VK?=
 =?utf-8?B?aTlUVWJtZU5wRStIajNBMWJMM3RmUlNpeGlCMWQxalJlOTRGYzFqWVY3QXZh?=
 =?utf-8?B?cnNMN1J3TnhTci9rclBmZGF2Sm1OTGZsd3pTaDhEYTlPZFBINUl4eW1CN3dZ?=
 =?utf-8?B?TGZkVFRkMXVwRmFGV2c4MElGdVdMVUE5TFJlbVFaTGVKcXZncy8xS20xYnRm?=
 =?utf-8?B?a1cvbXVWNWYyR0RnSXBIbGlVNlI3aHBmT1Y2YmhPRWk1cmI5VVdrWGpZaGt4?=
 =?utf-8?B?ek9WQTBhcC82MzdEVldBYjF2QzRFNCtMenZOYmVEM3Zrcll1Yk9JZkk4ejhq?=
 =?utf-8?B?aGd1UGpPRTZ6T1NFU2Y5ckRyVUZKQlV4LzFqYTRLNDBhMGVWS1BydUozTzMw?=
 =?utf-8?B?QWR1UkhIa3gwdGx5ekxlYkN4TGFJNjQzZFBhUWh0U2I2eHBwbWt4VHQrakw2?=
 =?utf-8?B?NzJNUklldTFBRHIvdVg2WlJEZkhJSEZGMHBNT3RSRmJGTXV0N2tSWUVsZkF2?=
 =?utf-8?B?V2NDZE9yQlBVa29vYUJOTGpWSE8wVHFiR21sOWtQbzh2QjU5Ky9BeVhsNE5Z?=
 =?utf-8?B?THRiMVk5WFhWSHRpUGdibVB1QzU3dytDWGJ5NlJqQnZNT2RjcnpPa25mdmNv?=
 =?utf-8?B?MUsvcDU3RnNpL1dDdU95TEY0YmJoOFEzL3FCMnozOHlqa3dCQVk4ckFKZU5P?=
 =?utf-8?B?UW1ZcndrZEt4emJoMDlNOHNXckYrNnVQbkx0L1FSRDVaZ1lFWExSWFlPWUtC?=
 =?utf-8?B?aHUzV0JKTW0rN25qRE5uMklqbWREUm1oTE5VWGlWVm1YS3pVV1o0c0pIanJE?=
 =?utf-8?B?NE9MMXpxQkdTRy8yZWU5cE9zZEF4cnNMZEZUQUkvUW5xL0g3aExYd3d0S2tz?=
 =?utf-8?Q?2+7hYIB1/Yv6utZvK1W6zSd+7?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1af70689-8431-47f6-a469-08dcf33ffae0
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2024 08:52:10.0376
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5zsKQgYKVM2CRCs7R9F7Dwfk2WgWRJkqUYTsZeImZsCXUx7wiHelLo3fv0f9Vrn8xPjYlzr85/82MqKVf+pGGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7295

Hi Yi,


On 10/21/2024 1:27 PM, Yi Liu wrote:
> On 2024/10/17 22:01, Vasant Hegde wrote:
>> From: Jason Gunthorpe <jgg@ziepe.ca>
>>
>> Introduce new flag (IOMMU_HWPT_ALLOC_PASID) to domain_alloc_users() ops.
>> If both IOMMU and device supports PASID it will allocate domain.
>> Otherwise return error.
> 
> I think my iommufd pasid series depends on the flag added here. As Jason
> suggested[1], I would add a check in iommufd to ensure all the domains that
> used in the pasid path are allocated with the IOMMU_HWPT_ALLOC_PASID flag.
> 
> [1]
> https://lore.kernel.org/linux-iommu/5a6c2676-256a-4fa5-b9a0-e433d4e933c9@intel.com/
> 

Sure. Hopefully we have sorted out all the issues. I will post v4 soon.

>>
>> Also modify __iommu_group_alloc_default_domain() to call
>> iommu_paging_domain_alloc_flags() with appropriate flag when allocating
>> paging domain.
>>
>> Signed-off-by: Jason Gunthorpe <jgg@ziepe.ca>
>> [Added __iommu_paging_domain_alloc_flags() and description - Vasant]
>> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
>> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
>> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
>> ---
>>   drivers/iommu/iommu.c        | 45 +++++++++++++++++++++++++++---------


.../...

>> +}
>>   EXPORT_SYMBOL_GPL(iommu_paging_domain_alloc_flags);
>>     void iommu_domain_free(struct iommu_domain *domain)
>> diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
>> index 72010f71c5e4..d1b07f4d9d32 100644
>> --- a/include/uapi/linux/iommufd.h
>> +++ b/include/uapi/linux/iommufd.h
>> @@ -359,11 +359,17 @@ struct iommu_vfio_ioas {
>>    *                                   enforced on device attachment
>>    * @IOMMU_HWPT_FAULT_ID_VALID: The fault_id field of hwpt allocation data is
>>    *                             valid.
>> + * @IOMMU_HWPT_ALLOC_PASID: Requests a domain that can be used with PASID. The
>> + *                          domain can be attached to any PASID on the device.
>> + *                          Any domain attached to the non-PASID part of the
>> + *                          device must also be flaged, otherwise attaching a
>> + *                          PASID will blocked.
> 
> Just a double check.
> 
> Can I interpret this as "all the domains used by a pasid-capable device
> (both the RID and the PASIDs) should be allocated with this flag set"?

If IOMMU supports PASID, then yes. Otherwise it will fallback to non-PASID
domain in DMA-API mode.

-Vasant
