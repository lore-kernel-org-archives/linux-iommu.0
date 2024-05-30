Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2062.outbound.protection.outlook.com [40.107.94.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09B6F6F2F4
	for <iommu@lists.linux.dev>; Thu, 30 May 2024 08:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717059139; cv=fail; b=uePDvD1KhoU5w898hWaEU4jnple60bCviGr/ofBkrqiDDtVXSEtyHEASRn/A6EtR55agYaQtY7i8DEWNoGFEHc4fnbFX8o+/OEmzKhY9ihyuIWY3N3at9jNpwLRAw085o5Hk5aO1r9np7aOnA7jCCJ0x8Jf/5LEhOrN7yJX3DNs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717059139; c=relaxed/simple;
	bh=NNZSrdl2Kg7UKYkaV9g3SCPhkqxNOMlgq7y8iiuCyno=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MSl/zdpOXvOwF903//vVMfMZE6dTPZ5W2boXrr9o4U16svPiylySw8s8W0g8PaQ7DgBiVXKBOMBgKMp/b2vnqUVaE+8fF04gnnJSq3lhot6jgWiv9qc6FWHL/ax7EfP0YIIr0+p4Q/rpk41FDKC6l+Cr49G8wIM4i+PPz/rss8s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=BYjZtNfn; arc=fail smtp.client-ip=40.107.94.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="BYjZtNfn"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jd/o1ShdhI/xqiUXZSM+gDhk7li9Q7gLysc0KDqzd4tdMW2zxZy5v86wJNFE7IJnD7AZYfrecvBUkQvu+jFRnN17lUB2I4nBhtKbDA7IR+dvU+KppNlmr+rgJcLbZ97HLwZaSqUaHSeTPLZOyGozgv2J5p+rdDqn0lHXDLm0fxAA+DRy+auwCwWIjUhYlCDAE5x72u/GttqbIbW7Mf6r0lcjfP4u4GWSpz8ZQT8M20XkhRVRd605RbQI8noDDFXnF2P6kdGCp+1ZzdICt1Z0IEiK9XUdbr5RGrsPJ72koHuj4y6X1CkfLq9cbx5eLKADCIKYRgOo+ls2sxe8dDspow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8lauZGaPHD3SGJOPpT35zEKhTlWfBuCB8NhQ8CaUaNI=;
 b=H0G+E1BOpBN9z3ZfdejtqZBBOUhxW6Fxh/QaSknqv8+yvJFhxYpnRwEuyGhhy+rtjLJsVCQyv8Vak5QyIVXWjWrXhDl+QD+XyP3cVR9p1mLWIMKrmQTSm/Qhb92AGzRzXSZ2woqL2zYphHRR1Eha8Ni81Sn0gHsC3eSvLIQ1B4IUxpnlgFs9H45WYmHrkEZ55mu+QWxhOoIRPyYBgS2DLSfArMGqkb7TtUFshVE1o6rN2Q3xn/c1O8bnHQgPnPshtyNLHj4CLGczY/Ed/MmXsCabrQ3jsjBcy1TuCzRkmMGZZfw9YUP6xIL9N6n0Mb6Nn4coKqCaKJlJNKfZFvRpSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8lauZGaPHD3SGJOPpT35zEKhTlWfBuCB8NhQ8CaUaNI=;
 b=BYjZtNfn4tBonqscm8QfevtTuZRQ4x3fYoWJPx9VHdbWXYDvja9tfH3pMXqGrJtFPGyNU1zcjVqOehrjfQgRPkF0ru8l5uShXxqu54bCHwiWSZ3iy8xzNXsVMYKwA7+so7Ev0gtwTh7kMqj9MR6tqFE7cDOHCySw7oB1Vo+JnV4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 CY5PR12MB6432.namprd12.prod.outlook.com (2603:10b6:930:38::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.19; Thu, 30 May 2024 08:52:14 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5%6]) with mapi id 15.20.7633.018; Thu, 30 May 2024
 08:52:14 +0000
Message-ID: <fdc3bffa-7149-48a4-949a-dd469c6c2726@amd.com>
Date: Thu, 30 May 2024 14:22:04 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] iommu: Make iommu_sva_domain_alloc() static
To: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20240528045458.81458-1-baolu.lu@linux.intel.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20240528045458.81458-1-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA1P287CA0018.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a00:35::27) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|CY5PR12MB6432:EE_
X-MS-Office365-Filtering-Correlation-Id: c3da0f2d-4d17-4af9-b650-08dc8085cd14
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|366007|376005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TGJDQS92ZmtJdXM2VFBlSWs3R2xHK1c2S2Ezd1p4TVQxbENVRU1iQnhSbHpI?=
 =?utf-8?B?aEU0SGY0NEk5UlYvZ1lDVUhzWGRYbEpkL3k1UUxZeU80OTN2UHo4V09hdXZE?=
 =?utf-8?B?Q0Q2MklKS1AvVkE1cDgwanRiUzJiTWRHSE1NTndUZ3llTW4xYm1tU2ZhdGhl?=
 =?utf-8?B?REtuOEtnUjB1SXkyR29nbVlLRUNpWVlpZUh3NkF5bjZ1TSsrNXcya3NaYnJC?=
 =?utf-8?B?eXMxczdqQTZEeU41Wm0zUHZiVzFlZVhYMVpJcTJwcnZnOUpHSHpwR09JUkVm?=
 =?utf-8?B?WGVveEZxR2FOUysyZW5wcU9BRVBRME85czd3WHBSY2wrMllUSzJRRU5BY2NJ?=
 =?utf-8?B?Z0pBM1BSN3NUbUY4Y1JGZy9qOC9LNmYxYkdiMy93M2tNN3ZQbHFVUzVtbkZG?=
 =?utf-8?B?TWcwcTdlb1daTUVJaklCR1NISDNJUStmZTU3Z0M1b0QyZGJ4c2c0ZVZneGZH?=
 =?utf-8?B?cVBrZmxZTkpUb1FNRXFjWGp5ZHNwdmg0amRNZm82aG1vcW1PdmpLaGFRUFpS?=
 =?utf-8?B?Ry9wcHNleVp6NVJRbTZ5ek5yWFQrN2ZwTlNMTHdXVlJ5NkRBMjFUajZXZzFF?=
 =?utf-8?B?dER3L2ZRaW85N2FDMzlrQndpR01CQWRhNllRTmhwc2V1RzlGRzUzbk4wM3kw?=
 =?utf-8?B?WFpvYk5Ra1B2Ykx2Szl0S0wrRUJNQ0FHc2htNkgxSjc5emtYM3BscGtKR2M2?=
 =?utf-8?B?RC9FOHZYRDhzbUJ2c3NEY2lqcTk5ZktMZERTYUhTa1hlK096LzRBQWxUSEkz?=
 =?utf-8?B?ZkJjN1ZoQlJwaHVmWnprNTZKVzVwa0tZeHBDWlZsT25ZZkpSZ2JrQnFqcm13?=
 =?utf-8?B?VnZ1dVNlWmdDZGpkQ2hmY1pGU05GWDJwSmh0UzJpcmhYVXp2MmJaYSthSjhP?=
 =?utf-8?B?VXltNU9iTnpjMURTSTVHQjg2UGRrTDRzN2VWa3VOanl6TXlxdWhBSnRoUWtH?=
 =?utf-8?B?MXNkaUlyU2ExcnhZWnR2WjlXQy9tV3o5bTdLVzJzczV4djlzMnNwclU2Z2pN?=
 =?utf-8?B?dTRUR0JqTkdVa3RBRFRKemRkRjhKUGxEZHRqSVFpL2JIMUFmN3RmREtGamh6?=
 =?utf-8?B?UmZ2bXlqdmIzOWQwcGVURHJzK2R0NjY0UnZDK3o0WTZXMjBNb0s5eGtGUXo3?=
 =?utf-8?B?Z1h4STQ1RktMT0E4SHZ4aWJJUlFmbW5mS0JCb3AzUzQwU1NjdDVYVW96ZU9P?=
 =?utf-8?B?bXpwSUlBeExBL0U4ZkJmNTNCMlNlamQzRWs4OFZSSXU4Y0FVeEMwa2NUcEk4?=
 =?utf-8?B?eFN1bS9oUms0OWc2alNMcTN0QnFuVko4QmtobDRSNGNITHJ1L2g3RlYxMTI3?=
 =?utf-8?B?MWhZOTdUa3YrU1lQL2pPOHRzN3diazRTSWdEN2U1ditCYTBBZC90Y09DNVdS?=
 =?utf-8?B?cUR5VmpUb2xGRWFMUktyNkgyV1MwT1BrZG1ONUFMcHVuMzE4TnZHZHdBUGJW?=
 =?utf-8?B?dnlmVzhvU3pISTJXcmFYZXpOOTZObS95UmNTQW1BKzNWUlhpelhTa2dCR0dS?=
 =?utf-8?B?S2lVQ0MvckM0VjhVaFpQMUkzVUJNVVpSNTMreU01eGdiVkpLRXVEZjJDWG9L?=
 =?utf-8?B?RVdrbnloaXlmeUhnSHJsbUJZQzViMkJCRHF4OVdKOGZpSSttNEZvVHNTbUpq?=
 =?utf-8?B?L3hQV3YxNERpQmxSMUp0Y3V1SEVyQVVMdTlGZE54blFXSWptZE54Z3dOeU51?=
 =?utf-8?B?aUQwL3ZmYVVqU094MFpIakc1RVpLeUhXaHBSMXVFTVdZaXNHbEtDMmRRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QmRlbUNXZjByTDYwZ0xFdlJ1bk9rNXU0WXNiSkF2bUxJSVNkakZpSFpicUJ1?=
 =?utf-8?B?eVIvc1ZQcGM1YXdXSTI3M2pXQWdFNEdTNzM2cWZGVUhJWFQ4RjdqWkc5SVZu?=
 =?utf-8?B?U09PazlvS1VDV1dDWkkvcERYOFJ6ZmJaTE5PR2VsdXBsTno0T3BKNFFxOGw0?=
 =?utf-8?B?L2cycjdXWEl0TlN3VDhlNno1YmVjRERicXBZUXN0VnVCOXBLcnVYRUdwSnQ5?=
 =?utf-8?B?eGNUcE5ibHlFOEVKbTFjaUFib1NjN0NabUlIK2kwR0E5d0RtTUJWVVNSS0dT?=
 =?utf-8?B?ek1EbDJZRm9UL0ZManN3NHYrQS9sNTd3N1dMbFJmS0FnNkRCMEpjekVHSlVx?=
 =?utf-8?B?MHl1YzhzRFNDZWpkbEUrVkxpMHNWLzJhSHlXaWk2SFMzRmtzeUNUNGEvSVdt?=
 =?utf-8?B?eEp2OENtTXZIektqeDJBeEpWOUc3VDFzUzJlakpYVUt6bnRibE9NdVBDR0dY?=
 =?utf-8?B?QnpjdUUvMzEzckYwMElXSDNVQUdRK3NBazhFQzFZaHB3U004SG1QRXo3bDYr?=
 =?utf-8?B?Sk5mMW1abTFlZlgrN3FTbGFZTHMxNGVxMFZyMGFyNkc2L3RWTlFrK2c3OEts?=
 =?utf-8?B?ZWdFcWdUUDE0TDZ4b2sxNUlVZ0FURlJEVlJzYUVDK2JoL2hHZ2dQZm94RnFT?=
 =?utf-8?B?QzFxd2g1WDI0MUV6WjJ1VkxOVEJOR0dQbGl3cXI1RHZXTUs0c2lrSjJZS2tC?=
 =?utf-8?B?Q0dXMnJZVVd0Wm82ZXhLTktMejUyZzFodXVwbi95M0w3Z1FvSUxDbWtYc2hz?=
 =?utf-8?B?NENmS3V2cGtKUjFhRDZQRTFRZnVaOHRleGVkcld1eFBzR1RETnFUOE9mZDF3?=
 =?utf-8?B?dkpCMmY3Q1RFTmxPL0pXLy9mNmV2Rkw5bStWREE0MTNWZUYvdnJHdzhGYkhk?=
 =?utf-8?B?S1NkOVBWdk9HeklCWXNUbjdWdWFleW9vb3k3czhZYktuTlB0OU1MN3JhS21B?=
 =?utf-8?B?VXo3SytyQnQ4UGdhRnZRNHlWdjRiTVhxeE1vSytvNmQwUWw2RlB3T2ZCRFJx?=
 =?utf-8?B?cytBUU5mLzh4Q1VNNURqZVUrMTUwUnZpM0o2STFqUWtGSkE1cXZYenFBQTJZ?=
 =?utf-8?B?U2dRd2lGZzc2djQwalp1Z3VqNVFHN3NWN3IxYmxTRDFQRjFqeDVOVjFSWUZo?=
 =?utf-8?B?MFZPRGg1cUs5U2ZPVS9WaEZxdnd6cW1BSEZFTkRCUnZmT2ZLWk9jc2ltakVT?=
 =?utf-8?B?K1o2R3ZGTjNSTURvN2pNTFZhT2dYNHE3YVBaNlJqaEJEUWcwSlZRbThPM2M1?=
 =?utf-8?B?OVVxTHZnQ1ZXNFNWV0QveTFmRXNBdnBIakJabFBWR0JGWlZwL3MydUZwVit5?=
 =?utf-8?B?Um1sRlVaWlRVWU8rQThSam9zcWF0NlV3TWJKeUNOV0NEd3dRbnRZV1BQNXNW?=
 =?utf-8?B?VGpadXg3b3FSeGZyaTlFRS9IS240RmlPMGJSZFVQbzdEVUNneXZYMFJ0VUlo?=
 =?utf-8?B?YzZHRmozbWVVU3dBN2Q0UllZeW1CbnpocmxmZ1A1WkMxZk14aW4xaGc5a1Fq?=
 =?utf-8?B?M1F6S3dleEdPOGpxNjJaQWVQenQveXE2ckFlRzU2UnVxOEZPVXBreUx6bUdY?=
 =?utf-8?B?SkNsVjdreFpKYjF1UEQ4S3FFZUZpOURDQUdMdnVoNStZZFlveG9RZTNmbUM0?=
 =?utf-8?B?TURxaGZISkl1NTF4cDhoM3RvYmNmWjlaN2Y2OEUzbmZMZzFWTUM2STJPWXBE?=
 =?utf-8?B?TkxaYUZTUG5reThBK004VnFLRHJtREpxTitXZmhvUHV3QWxlbDJudDc5aWFs?=
 =?utf-8?B?ejNDQ1lCUUdESURYUFhWd2lHcWZLWmNodzBqYXkrbmltYnJLS1Z6OVBFR2Rh?=
 =?utf-8?B?Y256Z3Q4cWd3TkhBYWE0NHgzY09odEIyV25obzRUbGE1Wi9FQXRKYWp0cHZG?=
 =?utf-8?B?Y1VkTkFDVFdSaDFxZFJiaHpXZnVCZzlSYzBIYjVMdCtoR2NUdzZiL1AxcGxi?=
 =?utf-8?B?RXFQRTlFRWlRbTFheFVQK2VDTENhR2RWSzB5WHNqRW5LTENBeFNCMDN0RHh1?=
 =?utf-8?B?eHlrZlZiUUV6OFgzQy91dTdUVzVVaWdleWxsNmd6ZlZOY1Q5Z01NWGQ4eVN5?=
 =?utf-8?B?Y0J0bUd2ZXh1eHM0UWFiWHNTTTRGRTBsTk5VaWo4bHJCc0Z6ZDJrQ214KzdI?=
 =?utf-8?Q?f3TqlPjmsLf7h6mA/TXdUVrU/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3da0f2d-4d17-4af9-b650-08dc8085cd14
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2024 08:52:14.2963
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p+kgoNGQihtWsjyx33ROxng//QfzecTK/twSJXSJrPYXwz1NMKRGO0HvjoWQ99QElSOBI2vPx0mZYydvZ8pwOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6432

Hi Lu,

On 5/28/2024 10:24 AM, Lu Baolu wrote:
> iommu_sva_domain_alloc() is only called in iommu-sva.c, hence make it
> static.
> 
> On the other hand, iommu_sva_domain_alloc() should not return NULL anymore
> after commit <80af5a452024> ("iommu: Add ops->domain_alloc_sva()"), the
> removal of inline code avoids potential confusion.
> 
> Fixes: 80af5a452024 ("iommu: Add ops->domain_alloc_sva()")
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  include/linux/iommu.h     | 8 --------
>  drivers/iommu/iommu-sva.c | 6 ++++--
>  2 files changed, 4 insertions(+), 10 deletions(-)
> 
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 7bc8dff7cf6d..5cdd3d41b87b 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -1527,8 +1527,6 @@ struct iommu_sva *iommu_sva_bind_device(struct device *dev,
>  					struct mm_struct *mm);
>  void iommu_sva_unbind_device(struct iommu_sva *handle);
>  u32 iommu_sva_get_pasid(struct iommu_sva *handle);
> -struct iommu_domain *iommu_sva_domain_alloc(struct device *dev,
> -					    struct mm_struct *mm);
>  #else
>  static inline struct iommu_sva *
>  iommu_sva_bind_device(struct device *dev, struct mm_struct *mm)
> @@ -1553,12 +1551,6 @@ static inline u32 mm_get_enqcmd_pasid(struct mm_struct *mm)
>  }
>  
>  static inline void mm_pasid_drop(struct mm_struct *mm) {}
> -
> -static inline struct iommu_domain *
> -iommu_sva_domain_alloc(struct device *dev, struct mm_struct *mm)
> -{
> -	return NULL;
> -}
>  #endif /* CONFIG_IOMMU_SVA */
>  
>  #ifdef CONFIG_IOMMU_IOPF
> diff --git a/drivers/iommu/iommu-sva.c b/drivers/iommu/iommu-sva.c
> index 18a35e798b72..25e581299226 100644
> --- a/drivers/iommu/iommu-sva.c
> +++ b/drivers/iommu/iommu-sva.c
> @@ -10,6 +10,8 @@
>  #include "iommu-priv.h"
>  
>  static DEFINE_MUTEX(iommu_sva_lock);
> +static struct iommu_domain *iommu_sva_domain_alloc(struct device *dev,
> +						   struct mm_struct *mm);

If we move move iommu_sva_domain_alloc() before iommu_sva_bind_device() then we
can avoid this forward declaration.

-Vasant

