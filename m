Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2082.outbound.protection.outlook.com [40.107.223.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8186AECC
	for <iommu@lists.linux.dev>; Thu, 14 Nov 2024 04:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731557032; cv=fail; b=LRlm6rar9k0JvJQf8bFzDARU8xufko7Lni8SojuHCMbdS4+HxxDi8EkHfIYPvhyFOXoo9VSTloWsddWu1bmrBEtaWE5X0oBnTQ8zWDN9IpU8IDEB07SkVzr79yH0h4bK37Dk1at+EkmU3j+F7KIpeRjWIjgrVlo4UuYs+SYyo50=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731557032; c=relaxed/simple;
	bh=DJP7bukVrvDe6W4I4niyNtMfzLsPlg+u4jbVEOMGZjc=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NJN45AxJQkOgi7mkm0Qm/4rE/HEHoiI7aKM+g6ANat4bN1xA6ImNX5Bo0FIKnMOTv5T5tHHdN6xtXIJrFrlyLBf4Tx04fUx/AUZJOw0oHmGJWydTJhfPNA+9dKa44u2kk7m8gSMr90fV+Aa2WK6vHgSo2ptRH47H9x6Uffu1efQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Y09C5pPd; arc=fail smtp.client-ip=40.107.223.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Y09C5pPd"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f9rYAQjvAdtKhj31AKdD5VBC0aus/6C2BrnFvDQ3vIDde+N/P4358OD3GqNHttRLkPT7/2hoYK8pd1k89phWe3HU3+w8mFEA/zPDnVbDOX9g2VKWH8ay35f6en4LooqYJnzwNILNAwVVA/HOL8xwa6fW6no263eibk2ljm+428fCTRTM+nxo9rz2W6cCezHWBJUuKKR6vqbUlptbINtDA5aeRAP6dsV55He/NFo1lJghOn4B2f5tEumuCccM+OoQdIisWN7rPvD7oEXT12bqBaP49ZWmsD4eOyfjLGUrEq7h8xKZBtJyzifR13+C5jOlkEU/OyvIP7CsW8Bdp0V/NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yDFrcHWcKu8e/ZMl8Q0Vbc4OekkvMGaw/rZl6CtxArM=;
 b=rPtxesGtvp+kPMatv3MpjVOnbHTuXu7WCuBhEMo3MxHnpWV0TpYlqSmxDid4tTZ7Kw82UXAfpFuVWPrWYsSUQHevNQTE+Z3B+gWpIxnmvFE7DB9ECD/AvUCCb21wtFmdZQMqgLzg83NB7RSFovWNYoUSwbov7u11CHMFhH682PkiS8lx+ZitWRdcNPa3tUqfXc0Ax/VV+wdRKFtjJBMCvBZ7b9oEc29+uJypUAEQ6DcxpHLD70+ryokLQdyHZB9f7/hxIDp+a5JYBx1Jwq9aVxr+hWw1ugdyVQELMU0+xtwjuav+bZ1NM5bTfjZilLe6ewuBMguQVhg7JL+NyZvW/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yDFrcHWcKu8e/ZMl8Q0Vbc4OekkvMGaw/rZl6CtxArM=;
 b=Y09C5pPdI141CNkaTtpyJIEA25OB/1u1ScxkEaSLNlDePOyIDmJ6v6Ri5pXx/dTgHoKaHSwzhDGLYGzczgHw1X72aKDhNscf+podp++IGjGUXdbS6LOMDyqQa5XmmaZTNsnp2lFUA76+s6zWgwflNokx5G2jgZXrHTJXYKHv5So=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB9194.namprd12.prod.outlook.com (2603:10b6:610:19f::7)
 by PH7PR12MB9202.namprd12.prod.outlook.com (2603:10b6:510:2ef::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.31; Thu, 14 Nov
 2024 04:03:47 +0000
Received: from CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f]) by CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f%7]) with mapi id 15.20.8158.013; Thu, 14 Nov 2024
 04:03:47 +0000
Message-ID: <71e700f2-178d-4847-8266-af285fd5f524@amd.com>
Date: Thu, 14 Nov 2024 15:03:36 +1100
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH V7 6/9] iommufd: pfn reader for file mappings
Content-Language: en-US
From: Alexey Kardashevskiy <aik@amd.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Steven Sistare <steven.sistare@oracle.com>, iommu@lists.linux.dev,
 Kevin Tian <kevin.tian@intel.com>, Nicolin Chen <nicolinc@nvidia.com>
References: <1729861919-234514-1-git-send-email-steven.sistare@oracle.com>
 <1729861919-234514-7-git-send-email-steven.sistare@oracle.com>
 <8f2fadc0-1872-49db-83aa-314352adbb6a@amd.com>
 <7788773d-471d-48ad-9f9c-ddd5671b26e5@amd.com>
 <2bbfb5fa-20e5-4935-b52d-73b5186c6123@oracle.com>
 <5ff5b402-95c4-408a-99f0-2f6ea4e617b8@amd.com>
 <20241107140821.GE520535@nvidia.com>
 <987fe758-de45-44b1-843c-63f3f82fd864@amd.com>
In-Reply-To: <987fe758-de45-44b1-843c-63f3f82fd864@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SYBPR01CA0060.ausprd01.prod.outlook.com
 (2603:10c6:10:2::24) To CH3PR12MB9194.namprd12.prod.outlook.com
 (2603:10b6:610:19f::7)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB9194:EE_|PH7PR12MB9202:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d3690ca-126b-4aef-cb31-08dd046156b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UU12RzJ5YlZRRVRvdDV3azlBSHplTE0reDNLWnpITXk0ZUJBTllSOXIxM3Yw?=
 =?utf-8?B?VXhTbjdHU0hDbDYzZC9yMkpNdGV1amJzZUV5VitLWGk2bVIwNGNBVkN6Nlow?=
 =?utf-8?B?elFZdWJhMFRSZ1UxNks4a1BmblNKeHRUUnB2bjRHbXBJYythQVF0K053NHZR?=
 =?utf-8?B?N2dZQ3ZEWXVoejhxemVKNEkwUm9RMWYxWktLeFREelRzZXZBcld3K2wyMWov?=
 =?utf-8?B?Z2ZIMHNHV1o4VUFjdDBxcklONHE4aXBkSTV4TjJxRGJFSFlLcHUrbFlMNlhw?=
 =?utf-8?B?RnYrYktuNjcxMkRtUTg5dTZIZ0xaeFN1NVNYOEpIZzNxZXpwUG9SK2U5RXlh?=
 =?utf-8?B?VHBrV2VZNXhTdzNLaUFLSzEyNDFIT2w0blgxVzJmWDRqMjFYV0F6NmZDU1hs?=
 =?utf-8?B?S0xSUUdkL0QrV0dlTEhNanRzTGxJSUtreGRZcFo0K3FkcE5WNDVJZC9mK2ti?=
 =?utf-8?B?YWhSY2VtMUtUL2RNU00xVmxRMkk3UWtGeGJ3QkFBMkxUNHFIamhSQUswVk9S?=
 =?utf-8?B?SStwWTRocG9FRnR3SmlPNnNQK1pVL3ZrbVBRY2l6RnB1Rlc4VEZ0OXF3UUZo?=
 =?utf-8?B?RzhGK2MyYzFzdjZlc2hrSGVQdG84SUY3czMyeUlKcFIxUWFUMjNHL1EwMGNN?=
 =?utf-8?B?YXVFYy9UQ2tKbkhXdDlkUHVjdVJhYWx3SmExRHlRNmI2QUd3bTFaNmQyK3dW?=
 =?utf-8?B?UTBvWG0vRXFBZUpZTWpYVk4xNzlaeCs4QldsZTd3ZFFFU3Zqeks0d1dQdWFO?=
 =?utf-8?B?R2FVd0o5OW1iY24wUDRRQlFmdldWRk54c3ZENmF4RTl2T3VqSnR3S2d5ZzA1?=
 =?utf-8?B?TDAzMytFTFhuRThDZEVuZzhDbEdRbWFzZ0RqZTlWUkUxT3Yra1NTT2w5bkc3?=
 =?utf-8?B?RHk4akRoS3V1TmNtNG5uWTdFa3RCM1hoVGtFT0duTG9SclA5RnhWbmdoNGQw?=
 =?utf-8?B?bDNWODBkN2Y1VDYwZHJDZ1RvTjVBSjNzUlBoMi9MQW5lb2QrSDZhZVFWbXZq?=
 =?utf-8?B?bDZWNGxOYVgwa3VpYVpYYjQ1MlJDUHBPWnUyeXpDUnZFWEYwV0RESHdJdEht?=
 =?utf-8?B?TXAydWRPK3JRVUxWQmk1aFBzdXM5ekJCTXBXZnFkVk1aRWhVc0FCcFhhUzBs?=
 =?utf-8?B?OWxhSzM2SDZMUUxsdUl3dkFtdFo2STc2ZXB2M3pnTkRlRGQraU1ETjFyY0hw?=
 =?utf-8?B?ajBRQTNRTm1FU05OV3hhOFV0ZjRKQWdrNUJya2pLamp6dzdFakw4M1grTG5B?=
 =?utf-8?B?dU1XaHBQVzVpRHJuNEE4STlkZXlhSlRaVUQzRU0yVWFBQ0NBTTdKSk5uelNZ?=
 =?utf-8?B?bFhGcHNDTWx0M3pQSUdwOFVNWmN4Sy9WdkErWFcrSlBVTmtwWWgyT1U2SGVy?=
 =?utf-8?B?TU1zVXM4cWVBQjRoL3gyY25RUzNyem9zdUFXVnJUclpDUHMrcisvd3hIM2hV?=
 =?utf-8?B?Mi81OWxnOUltK1ZpRytVdEptOFpIZENpY1NJaTdyYm8rOUJ5NU9La09yRDYx?=
 =?utf-8?B?MDdyV3g2M1U2eVJZYU9yNnZMOGNDZzhmdWlkL1lFWjNvcysxdHpPL3dGcVhh?=
 =?utf-8?B?Nmxla0srUG0zV2hFZVJBbDU5R1puQXl0U1F5NitKbzJuanZUZkxacGZEM0lK?=
 =?utf-8?B?UUw1VzJUYWhsVlpVZy9lT1U2VkNxbTlXaUtxUGtpd0tyZmkzSWMvZCtGU0FB?=
 =?utf-8?B?QnRXbWdRcDBUN0w5M0ZwQytqaStpNW5PYWN5UlVYOVQ5ZSsxaGNlaTUyYzgz?=
 =?utf-8?Q?nYQ0dS+aT297WwZ0yw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB9194.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SHNDWHJzUEcrZmdYSzg0VDVtYXNLQmN1Z1AxTml4TDY5S041WkI0WUhLSDRV?=
 =?utf-8?B?bmRMcHNraXRTZE5FdHF0VEc3eFcrempLRklGakZFUC9ZbHR1aC9MTjhSL09O?=
 =?utf-8?B?QjZaWVI3d3krV2IzWExEcXhvOVpHSTNhTkVXdk5JWUQ5cUNBbGhUOU82N3pO?=
 =?utf-8?B?VG9DSkRWaXFoRXZTY1dWc2R3Q3ZiNE5EVkd4LzNFSDFZRGE1M0VPcld1bGdz?=
 =?utf-8?B?VVZ5NnVTVno1K29aOEdncWJZOUQ5V3hWNnNvYm92UVREekU1U0J1MWZSV05Y?=
 =?utf-8?B?bEsyUUdqZmV3VHFiWHh2TFliSjZGbTk4UTNoMDlXeU1lWG45aDJScWNWb2lF?=
 =?utf-8?B?VmlQWmxjT0FLTXlSdjl2VWRqYmlTOGZjUXRsRlVyeWRNS2VlUFljZHdWRHFL?=
 =?utf-8?B?SEc5RHpOYno5Qjk2MzVJOFZjRkd3TGFaMDhDL1pXc0xWdDFZclpMWFRkZ0cr?=
 =?utf-8?B?VXBLL0tySGNCVGFhdjZTNWV5ZUgxM09oT2hMRkIydVpobDVHR000WWdFdEkv?=
 =?utf-8?B?dDM0Q1VpVTBTNlphV0l3RWFqWEZzNSsrOUxPNFg2bFV6VHpHQlJ6RHNRazJ5?=
 =?utf-8?B?UFR4c3FROTFwTStiQXZVdmhFdWZYc2xJWngvQzNHaTc3ek93S1Z0aWRnSzNY?=
 =?utf-8?B?M05XbU9kbVFBa29hYkVpa1hKeEduRHJKb2cyWGtkdi9aajQ2bndJdzdmN1ZR?=
 =?utf-8?B?MkZHa0ROVExOOWhmSlQvRXJ6c3NRUjNEQUVzckVYZ1cwOVJVR1BEY2hEeCs5?=
 =?utf-8?B?UnBTalNSOE94NkRVaGRzTnNBUmRMbjN5L3JvUVVlTmdmdmhhNlI3WG1CS3lM?=
 =?utf-8?B?OWxGRWxNVUxLMHYvRGl1R3lnTVBsK0RvQS96VnVtZXdKaC9ObTVYZmdwMm5V?=
 =?utf-8?B?dHl3b1JXa2M1Rk4rZWUwNzJnb3JzcU1Hd0hUaW5TY05ybzJLb0ZWOUJqUVE4?=
 =?utf-8?B?R0tXZjRkSlF0RkRtSWxTMktvRERrME5EZTVlT1JWZURKdlBHdVFUZWhtcHdP?=
 =?utf-8?B?TmppUmcwT0ZjbWdxS2NVOXEzTnZSYmVyYWpJWDhXYjlZMUZNTkF1YXkrbHVx?=
 =?utf-8?B?LzJIT1Vzeml6UUNrRFgzb2RvV2swVndERGljbFV5Tlh1RTB1NHlFZkhtdlNx?=
 =?utf-8?B?MDVzeERhd09vN1M2Q1g5S09PN1dFZys4TEtqUElVMWZOU2dKMmJEU2RKTlRr?=
 =?utf-8?B?WndIT1RqaWpuTXhCc0VoYjZLUUFFT0tVcUh3SXhjVUt4UGpNTDM2RVdIMGdG?=
 =?utf-8?B?VGVGN0g5d3ZNZEp5MC9MbGJjaFVrS3hvbmtRbTk1bkpVWFZ6MUxxR2lTbVVl?=
 =?utf-8?B?aVorYVplMUM1T2xuWDI4cEREYUc2YUxNZi81NkFxMzdYMzFwMEhzQ2dRNWZk?=
 =?utf-8?B?RC8xZTBFWDRKaXdrTzg5YUhueUVDRE9pc3FWcWNPS0xEcmhaRE4ra3lYV3R5?=
 =?utf-8?B?cml3RDAwL0dOd2ZIWTNoQUlZVTFtckl2bmNGV0RtWHJNbCtUNkQvZkNGL1FS?=
 =?utf-8?B?T3pGdlV2Z3luVCtqRWdPTkR6SXNXbE4rSExKSnNoZkhtU2lqZ2Y4QmowdEhQ?=
 =?utf-8?B?N3NkN0JOVnBVc2pjRmo3RDZjcnNIR1daWTZBODE5ckFWZFlkaFJkMVl2RHdE?=
 =?utf-8?B?VGl6ckE3VmpiR3ZHa01jbDB6elRaUjB3aWVHTTNNMUxhSzgwV3dpU0U5RG1T?=
 =?utf-8?B?SzFibHdpOCt0YmxHUWNaWmdyOEo4UEZhUDZieHo1Y0RxT21yMjVTZUU4YkU2?=
 =?utf-8?B?OUdJNm5GQ2gvRFNycytkNTVTTkVrS05VQkh0UXdtTVBoWC9ZbXJjQlNSTWJW?=
 =?utf-8?B?anM5WHVEZGxHbHl3eHphbjZkeUVUcnhxTnhuZ2RzTHNzOHorNVpxb25mbVYr?=
 =?utf-8?B?eG1OWFVlN1I1d3N0MG5tZTFiYUd0SjdtSUxFYjRIazQ1N1pVVXlFU2J6L1No?=
 =?utf-8?B?ZmUyMjlVMnU1b0NqcDZqNXZlazN5V0VoOVQrMFc2dUNjWkZaazJHREpFRW0r?=
 =?utf-8?B?dXk3cXJSZklKWXRUeDFnWWdFMDJYVDZpVitwTHR5c0tOSE9UVjlaRm0velJv?=
 =?utf-8?B?VjFGNnBiS3JUZWJHZDN1MldRNUpoZit1MFlEOGdoMFhlOXlCV0d0ZXhCU01C?=
 =?utf-8?Q?Y4feBRwLKzZUW1YfUBlCIGv8h?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d3690ca-126b-4aef-cb31-08dd046156b5
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB9194.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2024 04:03:47.2581
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hC5BV8uW4+qxXvPfGAq4/4T+T5yrbSbo1I+sanNgC7IheHska5g+D26PP4dry+rM9Ix0rUsKhyDTzrwze7iT+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9202



On 8/11/24 11:01, Alexey Kardashevskiy wrote:
> 
> 
> On 8/11/24 01:08, Jason Gunthorpe wrote:
>> On Thu, Nov 07, 2024 at 09:00:50PM +1100, Alexey Kardashevskiy wrote:
>>> I was initially pointed at this patchset as an example of how my 
>>> guest_memfd
>>> pinning of private memory (CoCo VM) should look like. And so far it's 
>>> been
>>> good except the actual pinning part - memfd_pin_folios() - expects 
>>> the file
>>> to be shmem or hugetlbfs and guest_memfd is neither (well, last 
>>> couple of
>>> months). Is there any plan to add those? If none, I will then, just 
>>> wanted
>>> to check. At the moment I do what KVM does which is calling
>>> filemap_grab_folio(). Thanks,
>>
>> I understood that the guestmemfd folks really don't want typical
>> pinning behavior, you'll probably have to negotiate with them on
>> exactly what the interface is?
> 
> Yup I will, just checking the plans here.
> 
>> I though KVM had its own private interface to guestmemfd?
> 
> At the moment it is essentially this:
> 
> folio = filemap_grab_folio(file_inode(file)->i_mapping, index);

Turns out the complete sequence is:

folio = filemap_grab_folio(file_inode(file)->i_mapping, index);
folio_add_pins(folio, 1);
folio_put(folio);

so then unpin_user_page_range_dirty_lock() => 
gup_fast_unpin_user_pages() => gup_put_folio() work properly.

Later on, hopefully, guest_memfd will developed ability to mmap() and 
then the existing iommufd mapping API will "just work", I suppose. I'll 
carry on the above for now. Thanks,



> 
> Thanks,
> 

-- 
Alexey

