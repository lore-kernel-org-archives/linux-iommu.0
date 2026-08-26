Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012006.outbound.protection.outlook.com [40.93.195.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 458D3314B66;
	Wed, 26 Aug 2026 15:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787758781; cv=fail; b=WxvlouU2OqN7VSmXoQ39fiKRGbgvp8elDr39PtNqKA6LfBRPb91FvZ4ff/0qOZwVoJL/sdkJFq6EBR69X7NJkuGKiS6EfOtYo+9Nud6zfRAXZ94+WK+V9wcIQafff7vxK+vlEOxASMV0+KLNmgZ89orLD+v84T8vyEWgBezdv1A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787758781; c=relaxed/simple;
	bh=V/84nM68ahBLqJVDV6xUWnX2a2ZIe/PrDPKP0tebO5M=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Xq2NVbglr/cmm58mtqyrM4JA67LY16nhFVAaVwvdVoVhG9CmlXT7hZ1OAVV85Yt6Q3KP59UA85o2aoIPXiJIm+pyG8DjgyK4kruEyfRYMp3XzO4a1c9QpENoksEntXLKxEEUF+cGsyhfCjPzbAx5IN5WysOoC5DxEmuDPCe7uzY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dT3OoIBY; arc=fail smtp.client-ip=40.93.195.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dT3OoIBY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vooHsJbcObTzYef7DiLbNtN7e3WMwDXUGptaoxYqyPEcA/bZCt6xaEoKOVwVg1sXz6bPWbpBC40mKdWM72VRXxmQ+hTs/5Tx/0PjHpucPSiSmYZxVi02NRf8AekJydrbjpzcKeCbf4EgygGal3TKXHaSjELqvYpNsGOeaklwjK7z+FJc4Us649xo25SyxXOvq2GMuE5ccZkUPIDq8jdXNqXBLxICfKp6g18+qYo7xioX2kbm96QiuhL5VmmsNv9GWn/c1eM+CX4kYTjD+5SWMhAD15D7u22FTiCI00MeIzlgL6qqZ4dDbttBOS+9+ZpITghL9mY84zy0KS+fYYhtmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jTQNsz/Wja0N/SSjuVRsEjik1ZGWR23+xu3Z38xgeZg=;
 b=PqaKOwcq7gjwOxNzJWhlsrcLs+1u8oKwzWz7LKvdrkMH/geKwV5lxTzvc6w3Q5AC8CAWYNfkV6EjPHka73GGieUFgU3jAcBpVa4jJNpcMuMnfji3AsykFUufl9gjJdisAkwcLA3G/7gwltbOcK6NIchA34P20KTvjfTpyRve6ClY2NLHQbejcNXWrZdKWN4kKyAqW9fJ21uLP6snV0GXH6cwrAhyaixsErz8e2td63oWhXqoKVCXMteIKIaEDQ6TeqP0/HsovqFJh6PaHi2k6O7NPpuGYC5xzEqOiaw1e/wg1sf2NjuwIKvYkwpVpG6DY3GG17Yq474qaYBdiWB9AA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jTQNsz/Wja0N/SSjuVRsEjik1ZGWR23+xu3Z38xgeZg=;
 b=dT3OoIBY4qSceOy5aspmvGdOclKHH/v1hpazCguXSEjyg1SfMrW7VarMXLxAeN5dZEOPKHyCgApvLFnFUtq9f9YHQn+Cgq0P+y9HTIKTGhqP8B91N+mrW37xzID5mELKN3ZOALB0t5d7e7dKt23KnE7l9iDWX4N/Zxszh0HzCE5AFmXWjONy8TpWwKcPxyBPfRXbNEhnL9kA/zJJvNYJciB/9wti/xBFIkwYEI+1R2f6UPYQkfmtIU2I9r4iywn1eyVzAM39LdePS/1efHg0pBSFlaJxwbq1P6CQmNCJhhEsMYqAqZ1jryDRMNLdN88UGNuJCZog4uKNtH0+DdZCpg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA0PR12MB8716.namprd12.prod.outlook.com (2603:10b6:208:485::18)
 by DS0PR12MB9397.namprd12.prod.outlook.com (2603:10b6:8:1bd::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.7; Wed, 26 Aug
 2026 15:39:26 +0000
Received: from IA0PR12MB8716.namprd12.prod.outlook.com
 ([fe80::c18d:8eab:b36c:32da]) by IA0PR12MB8716.namprd12.prod.outlook.com
 ([fe80::c18d:8eab:b36c:32da%5]) with mapi id 15.21.0360.006; Wed, 26 Aug 2026
 15:39:25 +0000
Message-ID: <e2a95399-be5a-4194-8368-69599291ad66@nvidia.com>
Date: Wed, 26 Aug 2026 17:39:19 +0200
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH] swiotlb: avoid double copy with swiotlb on tx socket
To: Mostafa Saleh <smostafa@google.com>
Cc: Luigi Rizzo <lrizzo@google.com>, Jakub Kicinski <kuba@kernel.org>,
 rizzo.unipi@gmail.com, m.szyprowski@samsung.com, robin.murphy@arm.com,
 willemb@google.com, kuniyu@google.com, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, gregkh@linuxfoundation.org,
 rafael@kernel.org, akpm@linux-foundation.org, david@kernel.org,
 netdev@vger.kernel.org, linux-mm@kvack.org, iommu@lists.linux.dev,
 driver-core@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20260615234220.3946885-1-lrizzo@google.com>
 <20260615172535.080cf94f@kernel.org>
 <CAMOZA0KAHKsvA9yRcdrjG13S+=rJhw-Cvnw2WdLjGGY0azG0kw@mail.gmail.com>
 <ajEuUZMgS_NRmDcp@google.com>
 <ac473a83-c77f-4a41-bc86-8a857d2d6e36@nvidia.com>
 <ao3DzzFIVPdtL7MX@google.com>
Content-Language: en-US
From: Dragos Tatulea <dtatulea@nvidia.com>
In-Reply-To: <ao3DzzFIVPdtL7MX@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0253.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:af::8) To IA0PR12MB8716.namprd12.prod.outlook.com
 (2603:10b6:208:485::18)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR12MB8716:EE_|DS0PR12MB9397:EE_
X-MS-Office365-Filtering-Correlation-Id: bf00e31b-298c-4d1a-b0d4-08df03883529
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|366016|376014|7416014|10067099003|4143699003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	2vAiH9WlRO/QIBul3BUcqHMZES9GIAnu5CuEucmtauX65B6UkH78owbxkD4uqnVCpNd11UmwZwg7j3FWCSem8IGsWCi8qS2BqJX83fhLqfTA8zvRDaBCHxR8/eQKL8Th40S6Fkdq8MCVObdLYgmvr5H5v2HkDKOzia5fTCHy9NY91qnX6eN+/e5ypajA4+e0wFOmfTiSRef03BEa++Biws41HtWWBYcVsU6P1/2rGVJF0Rk1svs2f6YFiAxBAttGU0VY98CFQAsfjFGdoy0OCt4x2x6D8olAEA9Or5t3zt6hvGSHDVywwk2nVD62Fedr84VLlqGVYoZZE8N2LEgwWw4P20B5mJp84HHpVIOCVREVrmZIQ+uOe2QbIjFfTLjpCdYw1c8CQk/linozjlyEL1ArU34Yj/OJU8BQ0PaGHzbIbLDhLiCtVe7x8v/ZyryW4peHm/wdNn61o+Efz4s/rvKKRQ2TuDKyNMCg2YVvGtJd1QX8HDd1rxzafcCpHeRz+KjqJHMTbqFbuSDY6RO7U/Wgvs9rfw2cyUggV293yc1Sy3Y1A1k2V2umFyDTtejl2F7Yvmp75f23mL/8mGKpT9v2BWyLUvv3RUQS5y9LLMU8pPMDgpmwWq5keggkX+d1vBaZltTdPDagpWqsr6K37g==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR12MB8716.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(7416014)(10067099003)(4143699003)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b3hlTnNKbjVSc3FtYmkxbGZRMHJoeTVSZzZjb3RMaUc5MEdoc3NzbUVndDRr?=
 =?utf-8?B?U2lmRlc2MGMzRDVSc0lwb1FRditRMDM4WFQ1UkhrVlpsOWdkNDJBZmEyajNU?=
 =?utf-8?B?T0dHL0lVd2RKMGxjN3B6eDdLWmpkVUdyNFpGTmtaNTZwQUZxWndpWUIrRkxD?=
 =?utf-8?B?dFZ0Wi9Tak5RR1gwRzIwbnNVUlo1S05HenJYWDEzem0waUNrR0hTMStIejJV?=
 =?utf-8?B?MHVab2ZGbnpKRFQxQ0FDMlh5cXozMFpPbGpLSHFVY2NNa1hhTjZRaGR1bTJv?=
 =?utf-8?B?Rjc5emF1dHNaV0diYVBvYkc5cVBqVHpjcDJNSlJ6RXJ3SjBmRUtXKzA5SkpT?=
 =?utf-8?B?cEkvQldJVmxwQ2VabFFWbWpMYXlxRjJScm9ZdTI4Vkl2RExMU1Y2ZmdoczYy?=
 =?utf-8?B?akcvV3VhYjU5cXFVOGxRWnNtVGZiN1BpRmt2NUpGYmNSQ1UzTFRJeVRJR1oy?=
 =?utf-8?B?N2ZkZHR0bnN2Y05JcmMyUDYwQWtJaFZCYzlBMFpzSHNDTkk3V2w3ZUhDTldy?=
 =?utf-8?B?K1NSTmJjcmIwOGE4bnIyWDJrYlZjQXdraVhEVk0xWUlnV1Y0TWZwTmtIRGFK?=
 =?utf-8?B?ZXFLS1FsaVNETTFJVjF0WGtVdUoyaUgvYTlIdSs4c0p4eEV5YThkTjFZMExM?=
 =?utf-8?B?T1FhZUhSMDJ4Wlg0cmlVZ200cFNqK2NXVU0rNmpwRGgrMUlqLzRyRm5Xb3pz?=
 =?utf-8?B?d1E0QjF4bWpFMFo1MkMzenpiVS96V3l4cHhiVnBwTG0zQnJuV3BOMUFRdS83?=
 =?utf-8?B?NUtwRVhESHB2L05PNW45b2VVRnhCODdwK0Y3Y3BoRFlqb0M0OW5TUzRXdFVP?=
 =?utf-8?B?MnZEc2ZOQ1QxUTdMREVhVVhoVDdJT1QxdTZUZytRR2FIdi80YytDRElGdkFY?=
 =?utf-8?B?QVBjWm8rZEx2NjRPVXgvcElLUUFjTEhlNHJhYUxyNm5LUHE2aFVNL1ppT0pW?=
 =?utf-8?B?YWRWcERhcnpUbXloZDFUVG9UV2hjRUU3MXNjTjBZUTJMaitlL2Nabnc2cjZQ?=
 =?utf-8?B?TVN2UmlPQm5nclpNNHVTWHlnelNOTnQ2SDQ2UnZWWjJTdWxHYWVzamhyN1A0?=
 =?utf-8?B?MDVmK2FJWDJVUU1EOS9Cc2FHa3pxZGlMWkl4Y0twNlBlMXVzdUR6MzAzdVd6?=
 =?utf-8?B?Y2dOUG0yY0IrZmlNdzUvZXFSRU1oSDhQUlN4UzFNYzkxRmdmang0MVZxMTdW?=
 =?utf-8?B?Z0JYNTJvZTB6UTlZczZIOWo2WlN0YjlZUEJuNnF3b21CWEtZbXBJMUxFQ2RX?=
 =?utf-8?B?YTQ2eTlmdFRCRE1nakNwMUltV1lkK1NBandKRVVaZWt5SWxZOUE4d1FCc1RI?=
 =?utf-8?B?UlljblZRUlR3UngwUnhQSm5PeXcvSmhmV1l4VGxPSnhvMlJEMjMydTB2ckFl?=
 =?utf-8?B?MmM4MzN4QUl4clpxREs4amwxUXhnY0RrRW1QeDVRcThPdDYyelhPakk2VVps?=
 =?utf-8?B?bzVmTHNndUVJVThFN25VbktYWXZqR2dWUk1QUm4xaEZuWkhvRkQyL0ZtdWZK?=
 =?utf-8?B?S0dUcnZISEFSczJMTFpuMzBJbVRCdWtRQ0FYbFF3OUE2d2FDdXpuQ3RiMGhY?=
 =?utf-8?B?SU0wTkw3V1lYRXdhVW5hOXBDcGlEZjV0MmlVT0V4N3FheWc1NzhpbWtPclYr?=
 =?utf-8?B?MnZCOHhONGRQckk4ZG5WcWw5SElvQ1Z0ZitQU3VxZnFOTHZXUnNacnhIbmpW?=
 =?utf-8?B?WkR2M3lIbktwZ056MVRCcEYyeFl1WVNXQlhZQTFTaXNFcVFwNEg1ck96Z1BM?=
 =?utf-8?B?K3B1SDdpL3RCNDdSWnV5cisvK3lMbGc5alE0K3l2Nis0Y1NiZlhrK0VWWTB6?=
 =?utf-8?B?S25VUzlkdG4zRW9zSDUzb1hoTk1mUjE0TjJaRUNnb1dqWlJDSmg2cGNYWS9z?=
 =?utf-8?B?R3J0RzlTVWltZXdtQ3ZWUHB2WVNUbjdCdWJ4RElFMFB6RVN0bXFxYXB3bnky?=
 =?utf-8?B?RzNzbmcwRE9aQVl3d1ZXazNIeE1LZlJmdzQ4WDVCeDNTaStTSUIvK1ZxY3Iv?=
 =?utf-8?B?SERmQkdmK0EvK2MwZzdwbyttNU1kWWZQdUg3ZGVzTWtINnM3NElKVXU5dklU?=
 =?utf-8?B?R0d6Y1dqTklIdjYxa3NwNitFVzBmMGRDUWlpTUp1a3FpcEM1MWFGbVZnSGpm?=
 =?utf-8?B?NEFSeDFDK2E3djgzTlBoVG5UcFRIUVdsaWZhRmZ4bW9UQjV5Z1FaNHhOY1hE?=
 =?utf-8?B?V0cvL0RaU3RDSUIxcTlrLzhCNEdHZXhOeE9TVVFoNWF4NXBVMjNTOTFVWEwx?=
 =?utf-8?B?d0Y1YW5SbVNDSFNSK2pMWHFRU1R5RW55eW1vdWdxcktzV094RUY3Qlp0aTgw?=
 =?utf-8?B?OU5NV04rNXBCOWVrUXB0MVBOM3RSZWJOK0pBdFpvakRCZ3RwUHltQT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf00e31b-298c-4d1a-b0d4-08df03883529
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8716.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2026 15:39:25.5086
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yuDZUJk0MEl+6MBRg4iCoqaHhSrRVYpKiAG+vx0jSkSZCPqj0pjWNbVAt8ZegjmN2A9nzwSR1XhZHWdwktlQOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9397



On 25.08.26 18:33, Mostafa Saleh wrote:
> On Mon, Aug 24, 2026 at 10:59:21AM +0200, Dragos Tatulea wrote:
>>
>>
>> On 16.06.26 13:06, Mostafa Saleh wrote:
>>> On Tue, Jun 16, 2026 at 02:33:52AM +0200, Luigi Rizzo wrote:
>>> [...]
>>> I am still looking into this, I was planning to bring this up in the
>>> upcoming LPC.
>>> I will give this patch a try. However, I believe that we need a more
>>> generalised concept for CoCo pre-decrypted allocators in the kernel.
>>>
>> There is a talk at LPC in the networking track about this [2]. This is
>> exactly the type of discussion that I was hoping to have there.
> 
> I see, thanks for point that. I plan to be in LPC, so I will aim to
> attend this talk.
> 
Great!

>>
>> Besides the issues mentioned in this thread we've also found that a lot
>> of overhead can come only from swiotlb allocations when running many queues.
>>
>> I will add information about this series in my talk. Hopefully I will also
>> have time to add some numbers for comparison.
> 
> I had a quick look, I am not sure how that will shape at the end, but I
> think we need a general solution beyond NICs. For example in pKVM the
> bouncing is used with virtio devices, so doing this per-driver won't
> really work and is not possible in some scenarios where memory is
> allocated from the core kernel and then passed to the driver.
> So, I was thinking the kernel relying on
> CC_ATTR_MEM_ENCRYPT/force_dma_unencrypted() could detect that and
> allocate pre-shared memory for those cases.
>
Ideally it shouldn't be per driver. But I was thinking that there should
be a way for the user to provision memory for certain devices.

Thanks,
Dragos
