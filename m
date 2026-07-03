Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011056.outbound.protection.outlook.com [52.101.52.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A52CB30CD9E
	for <iommu@lists.linux.dev>; Fri,  3 Jul 2026 03:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783049491; cv=fail; b=kHTk6z7yIRQREnYnaTus8Fki1V/UWdcJUJ66OXsM64w4mAB4SHGUARTmlrU5QkRd6mJSmWQF6WeZ62/vQavUuDA/fwfekwkrp4JVG62aNGDsEA8EV3gk70ladAgWaiXlCxDMHy7dDkCQVqd8+tJUe3vimzNEto0CfpKIQdJCO18=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783049491; c=relaxed/simple;
	bh=zjT5LEbemDSZ1QKmXDPcd4IOvnc7q7i/SUF2guYtFhA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PPUQYY1FsNN7dp7qfrEjK9po+j7g9wwXLhbYK/5Rrgyy0BQs8EwEAQ8/i5Xv9OFAdBNnZjA/PwvYcbEGciB3QC4rYOMi/qwmiUwk1d9NVFSg0YDtqtsPU+Xg5lBCJPQkd8sGuf3N+wVpkRLaa+5JY30OwABk48zW5Cidr3Y2YUE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=sGUH9yBo; arc=fail smtp.client-ip=52.101.52.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="sGUH9yBo"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xG+wd1al5qe9dR/gS2+3e/q/VKPitnJs+BSd6XedjK26oaT7xanxuPMVv/MFRQJ3D/aVceK0LCrek9wMEqi54AfBZOMKe9HNuUk+Pmj6A7iH6kmRZRitpcRgmo3BHxLGkBNCHYiSqtd8m6hFI4NtXa675Sl0N2AjiYQjuhLwvOfa6vaRsBm3ZPH0CxhxkMpxN1YVkdmnLdKEs0KHx66Al4P1jMzrtFpzM8nZ3K131qcNjNy15Sr/BZKFI2mUD3o5nFV9pwMVxnDobBKfsNP10DSasEzbE57EOOdwpDbtxsCs78ebULOcy8l6NIvn85/VC5cm5Zp+9yz8d41rz1ol1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7h+Pty4puKQahc7Zo3qakYVxY/IsiDyIgzGwrcfBoek=;
 b=kpbkUc7gaIlNp2Nv2yqHXcpeffj4bLF3mlTqDK2476a1l242Qp330SbvCbQy6PudGlk7Wvx6FLiVciIu2NoeioKguV7JdreHpxIR9dqyy7NKFW23wJmF/eKmnd0us8YcYZeoZbKYHnGKer9YAt3qxgB5r4ExB0QU9phZnaYneX7NxTTAe5sMDPy/qsKANEkjPh1oXPEZn12mnIadOY4/JToB9MXASiDHmbADiOO7kshnkbwja9y287N+O9qQvGoSeXU6BxxAgl7Rum5WnwUPq3/zKPUQdeGOJwOOumLvzdLZk/9k+ki0A+qkAN0LXg8ttYlfpGExppLJtr5gL85Knw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7h+Pty4puKQahc7Zo3qakYVxY/IsiDyIgzGwrcfBoek=;
 b=sGUH9yBo3H7ey2dSVusCVlSTd/d7vvuvLnY+WJZw7KSl2sjGWrLSa9lUmEZYBIO0/2sF25m+38ITAHl6H/v/TmYws4u1e+s2gpzuibUB19F10/7XyCC3oALQyx/6G8+XjToY+KD9VxxG39Y6qDjl2uXIrLCSBOuyQyu6SahhZ10=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY8PR12MB7170.namprd12.prod.outlook.com (2603:10b6:930:5a::18)
 by DS3PR12MB999218.namprd12.prod.outlook.com (2603:10b6:8:38e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Fri, 3 Jul
 2026 03:31:19 +0000
Received: from CY8PR12MB7170.namprd12.prod.outlook.com
 ([fe80::7565:bdd3:383a:de5f]) by CY8PR12MB7170.namprd12.prod.outlook.com
 ([fe80::7565:bdd3:383a:de5f%4]) with mapi id 15.21.0181.009; Fri, 3 Jul 2026
 03:31:12 +0000
Message-ID: <464bbc14-78b3-4863-9cff-b2613fa56267@amd.com>
Date: Fri, 3 Jul 2026 11:31:06 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/dma: free the entire IOVA reservation in
 dma_iova_destroy()
To: Robin Murphy <robin.murphy@arm.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org, Ray.Huang@amd.com,
 joro@8bytes.org, will@kernel.org, leonro@nvidia.com, m.szyprowski@samsung.com
References: <20260701092033.422867-1-honghuan@amd.com>
 <820112f0-4361-496f-ba84-557746c75601@arm.com>
Content-Language: en-US
From: "Huang, Honglei" <honghuan@amd.com>
In-Reply-To: <820112f0-4361-496f-ba84-557746c75601@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2P153CA0036.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::23)
 To CY8PR12MB7170.namprd12.prod.outlook.com (2603:10b6:930:5a::18)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB7170:EE_|DS3PR12MB999218:EE_
X-MS-Office365-Filtering-Correlation-Id: 249a2d34-3ea7-4d6b-b0c0-08ded8b3878b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|23010399003|366016|18002099003|22082099003|56012099006|11063799006|4143699003|3023799007;
X-Microsoft-Antispam-Message-Info:
	LF22WtqiwxkTG4a3ORRQREUTfTXwe4axT/pQ0RV9u3M34fkX2Tp0P9bfjtBpUkxa1tVXj0fNiPipDr4TAbfL1WPbqEiVsKpUkjYySTQAxXIKo7DfzEr41CtuKr8ohmCTSVQZ6VNHcIgIdJMvQCmzsltMPHGfjg3SuK7JihLCuTKdmZuwvaY7yHjfT6t3UDT8qGl+gzNFLkSSrscdABGTajKzEUkIoy9ooXZuK7Y9WVDIJvUP8QoUPRal363YSnDtQZ3dJCKhL47yKN6FCzwW4pvcNJgCiMqEi0tDM3yXc3PG2169h79pY+MswxlwgSEdDpbmp4/3tBP2Um8MSe/pHop585NoQ7X9C/TvJwLkIuAwf0nlVNH58pAA1rjEPJHnO642vRHeT611KQmPK8+TjfD2VtcoTzQS3dyb8V0mwk+DjMqp1wSdDtM2HtqrgL92a5DnOVUbCnG4GRZuT0SxdchrBPCCr+3v6Cn2EEhWZLxC/977sBD+bqCeJYvljgpM+bU6FJp0IRY7V1IDv6RkF1ErqMmv8WCxkLWdX2JwwwkgG+Npw2eS3EAN9E1pGI89WGURBYzroUPsMf3kMaHg8EpU6CTtiIx+m9x99qn2i6HFkFehBnFAcVjFne8542RoDOW9G2gq3l0EkVg23QXl+T28a33RRXPnrp2/nCLqPSE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB7170.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(18002099003)(22082099003)(56012099006)(11063799006)(4143699003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WDlOcVh1ZEVYbHdIaFFlVThQSFExZHVDMXdkZ05ETkNDakY1eFFMT3BmQVdX?=
 =?utf-8?B?dWNwa1pSUDlPbERuZnpGYnRGWStDbmhqdW9TdGJIWU5LUU5pazRHWjlBSHNQ?=
 =?utf-8?B?NGFHWWU2QWRPKzFHYTl2bnpubFZRUVF4ZUVVNUtKbmNuQ3NZb2FQdjdDMnE0?=
 =?utf-8?B?N1hFMkxXR25Eb0ZDdE10dHpaYW5JZ0d4OUs4V1dMTWF5cEJ5eVVUOHZiM01U?=
 =?utf-8?B?d0hzcWtIWHBJaTBlenZIOEcxZENIb1lpeWxPNDgrYkRzRHpEanRMaGFub0Nw?=
 =?utf-8?B?VWkza0UxQjhSRitybWNiMSt2QU51V0lKWWxIbGcrNnVtRVZWOUgveTNFQnJq?=
 =?utf-8?B?NDVCZ2c3aW9LcmNhYmNlYUpSQzJKbXNFeVYwZEJkUUtxYXk2bWk3bFMrZW9a?=
 =?utf-8?B?bURVRFZDRlJPMUs3UjArY05jKzFYY3orT0poMW51MlpmSkR1allZaHdHOVB5?=
 =?utf-8?B?NTkrNnhPajJacXdQZGNHNDBFVjdjbVdCWmdNcFQ2MlpQcm9hUlF2U2o4QmZv?=
 =?utf-8?B?QlNBc01lUUtOWVVaY0wyVmtGWmRDNGNhd1VzNUhrcUdUeTZmRytjRzB4QnFI?=
 =?utf-8?B?UHVuanVQWFN4RnlDMUpjdEVFeW9admVTTDB6czlJWXluYnVRSllkRzB5bWNS?=
 =?utf-8?B?cE9GeTdETzJhYS9raEFQaW42WCswT3lNRzUrR3I4bVk5RHUrZEFXWG5Id0g2?=
 =?utf-8?B?MUNNcWpDb0xPeVZIeVg5YVNPTXJiTWpSVVBzcU1qZVB0OE84SHhSOHlkNFZX?=
 =?utf-8?B?bnZvNHRBeWhCY1JqMXFqZ3VubzRtaFRpQUs1dzhkMzNuMGIxbmhJL1pFS1Vy?=
 =?utf-8?B?bXBPL3BEWndvaXg5RWNYN1dzSnVLNjlEVDNJc0hURnd1aDNCRkhYZEVIeVg0?=
 =?utf-8?B?Y2QzS0xsR2wvNGN5cE5FYXBaT1dhSFd2ditaU0FCSlpZeHQyL3JpRXZ6U29a?=
 =?utf-8?B?dHF3eW9ZRkJkdlE4VmljMENpckVYaHhqakFhTWNld1pmaXZzemFmeFowVjEw?=
 =?utf-8?B?OE1DNVBjVnExWHVEaFVWQ3dCbkFiclpZVW1hRUc3R2NZdlV6eVArejk1SGwr?=
 =?utf-8?B?QjNmZmdWWWFuQStFbVRWb3ptc0pwd0FQSk9JQ0ZhUkdycVY5SVBGZVNWR3lV?=
 =?utf-8?B?KzNUM0I5Mm91T21VUFQ0d2FSbFdSbTRNTEtDeEE5YUdJcFNWNnZCOFRvL25V?=
 =?utf-8?B?VENKd1pvQk1WM21QR254elB1NURERDBjcWoxRExXdkFwd3VVQk9tQzVrUGJs?=
 =?utf-8?B?eUcvSzNtdDR5Uk5MU3B1ZFdHK0VOMG1BM3lPSFlQRnJkUkovK1hMSk4xM2Z2?=
 =?utf-8?B?RXFtdjJKRnJMa2xoQjFoWTgrL2ZqNkhtVERwZzFqMTNiZ1QzY3VZT1ZDbk1B?=
 =?utf-8?B?YUZBcW1TWkZsQzJCZ1cyYjVZMUphN3NzTGFvSitzdFlmeEJzRUdpQld1bCs1?=
 =?utf-8?B?QUIzR1hrK2lPUjJDY3RTTmZMMzlxVUh0K1dINjRVbmNmNVN3bityZHBUaFE5?=
 =?utf-8?B?QjYyNnVsQWNrb2xuS05LUUN1V0VUS2hXWHNtZlRMTElkT214QTRWRkh1UWNF?=
 =?utf-8?B?T3RlM21HU0IyNjI3eDNnREUvRStEY2M0OHpFeWxjd2xaZW16QlhNT012TGQr?=
 =?utf-8?B?R0ppTGtrREpQdHMvQWRtZjJLQVlZL245THM2MHNldVh3QjBlRSswNU52QnU1?=
 =?utf-8?B?OUxaaFlYcTBRTkN1QktoVjU5d0dKNy9TRXE4cythMGRFTzRWTlRoUDVVNHdv?=
 =?utf-8?B?eHluU2prdmpTTUcxUWtsaVpDSjNOY2wzMlBTSC81c2lWbGFPaWJGdkFyTDJw?=
 =?utf-8?B?aml4SWNlMll3RE9lUC9uVzVWaVdEOTNvRnhjMFlTRFJHS0NaQXZJVUtOaHZE?=
 =?utf-8?B?ZVBOa2J3ZERPZ295V0IxTGE5VWhmSjdYRjhGa1BxcDJ5dkpwbFByeU4ydGNu?=
 =?utf-8?B?NmVBUjZyVTlZaUNwcnY0R2F0MFg0WlBWbGJJakZoTVhUVmFlNkErclJCNTlh?=
 =?utf-8?B?YlBsQVBVWWlFRm9xWk43NkFTeU1xYnJQZytlM2RLeXVZRitUbEUzY1hHTVNP?=
 =?utf-8?B?VE1rTlJhWmw3YW1OZ3ByOXNVT2pMb0hRTVBBSG9oZTh5c2pFcjJZK1o3ZVk4?=
 =?utf-8?B?anBsSXFaOGJreEFaY3JSYmdRdnFCa0dNQ3pPN0hmd0pFd1RtZGdYMCsvSWpN?=
 =?utf-8?B?ZzV2bzJWL3F4VWF1QmpFd0JENU1ROFVvQnJBWTlrMGV1elJ1bHhVekVrbHpk?=
 =?utf-8?B?KytxT3IwWG95MWlOa082VE5CenE2VWt4RFp1ME1pTW1LYkVCVzlFWFNHcE9v?=
 =?utf-8?Q?bvITRxRZaaGySz8Twc?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 249a2d34-3ea7-4d6b-b0c0-08ded8b3878b
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7170.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 03:31:12.4588
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fSJVOXGT1Im8xmEifBQpAbjivNPY5PxQCHGj/sS3s9/VeRcZaqTOgQImQlv0KzDLgtXQMvziR/vWV08zS7oTyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS3PR12MB999218



On 7/1/2026 8:36 PM, Robin Murphy wrote:
> On 01/07/2026 10:20 am, Honglei Huang wrote:
>> dma_iova_try_alloc() reserves IOVA for the whole requested size and
>> records it in state->__size, but callers may subsequently link only a
>> part of that reservation, for example the drm_gpusvm mixed range case,
>> where a device page range is linked incrementally.
>>
>> The doc for dma_iova_destroy() is:
>>
>>    "Unlink the IOVA range up to @mapped_len and free the entire IOVA
>>     space."
>>
>> However __iommu_dma_iova_unlink() computed the amount of IOVA to free
>> from @mapped_len rather than from the full reservation. When the
>> reservation is larger than the linked length, the tail
>> [mapped_len, reserved size] is never returned to the allocator and
>> is leaked, contrary to the documented contract.
> 
> That's not what really happens in practice though - note that 
> free_iova() doesn't even take a size, only a pfn with which to look up 
> the corresponding rbtree entry. At worst, for sizes small enough for the 
> rcaches, a larger IOVA may be put in a cache for a smaller size, which 
> although wasteful, is otherwise pretty much benign.
> 
> This isn't to say that the allocator behaviour might not eventually 
> change in future, but for now I can only assume that dma_iova_destroy() 
> doing this is intentional, because I pointed it out at least 3 times 
> over the course of the original review from RFC to eventual merge, and 
> Leon made a point of refusing to do anything about it :/
> 

Got it, I checked the code, the current code behavior does not cause a 
leak. Leon proposed a new modification, will send V2.
And I believe is a cleanup rather than a fix.

Regards,
Honglei


> Thanks,
> Robin.
> 
>> Free the whole reservation using dma_iova_size(), mirroring
>> dma_iova_free(). The unmap step still operates on @mapped_len only, and
>> the same iotlb_gather is reused so a single IOTLB flush is performed.
>>
>> Fixes: 433a76207dcf ("dma-mapping: Implement link/unlink ranges API")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Honglei Huang <honghuan@amd.com>
>> ---
>>   drivers/iommu/dma-iommu.c | 5 ++++-
>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
>> index 9abaec0703e..bb29c82d1c8 100644
>> --- a/drivers/iommu/dma-iommu.c
>> +++ b/drivers/iommu/dma-iommu.c
>> @@ -2096,8 +2096,11 @@ static void __iommu_dma_iova_unlink(struct 
>> device *dev,
>>       if (!iotlb_gather.queued)
>>           iommu_iotlb_sync(domain, &iotlb_gather);
>> -    if (free_iova)
>> +    if (free_iova) {
>> +        /* Free the whole reservation, not just the linked @size. */
>> +        size = iova_align(iovad, dma_iova_size(state) + iova_start_pad);
>>           iommu_dma_free_iova(domain, addr, size, &iotlb_gather);
>> +    }
>>   }
>>   /**
>>
>> base-commit: dc59e4fea9d83f03bad6bddf3fa2e52491777482
> 

