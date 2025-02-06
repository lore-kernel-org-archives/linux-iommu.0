Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2088.outbound.protection.outlook.com [40.107.220.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB71D225772
	for <iommu@lists.linux.dev>; Thu,  6 Feb 2025 08:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738832190; cv=fail; b=YdmPT6L182velBXpMpVId2wm3KDnD+qyqUxEbB8hmCiQQg93dDkY1eXj7ImhJNK+dE/1u+Ytla6R4ZAu43glw5vyVLqNHiiDMJM2pNqtrKpuuXziJHarGvXncH3sNFYB9AyRUnhQqMRFtaFG1x1NJTjV/pvuhTcJb0AaXplHWNg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738832190; c=relaxed/simple;
	bh=qgUyWdRhQWawsr/9wUJ7w89wUN4Lz6MokCELT3ZmiKg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZX0aelCk5/b4dZVx1XemoQFt6FqrNPG0R3xVLug8YaVeuRBK2sBqF85pEiJYXy9ns4iLqcDndB6Bh2yiHBJ4/Jt3aO+68T4RDF4bi6EHRIkS82ZOcIM5N5oXasfok+E+gPXFhTd+qGrP6DKIXuLMtzavOCo2JiRChxux0K4DImc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=3ZnoWHZI; arc=fail smtp.client-ip=40.107.220.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="3ZnoWHZI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nyPh5Wa9R6LlHX4JlLREJroPcJshN7Zs4EDLb80tCgtXv4RxTmZfK7Pr/fclFatv8A1fWwRcnP21mXjnKLk9UPuRqf/X2HTtQd22FemBslBB6nRooKNtrppnefxmblHGcWmnhpfyfiFmDkyO3JRe64RKVztjw51KPoahr/cpf0BNs+NkN7LngfWLSvtg/cc/ESOtT8QxcN/zGHQ3uXHdqVDNaNBl9y5MsbyFADnM1MzFwS8B5cAXzqVq0Py3aHfMaZJTxvIeQAgNauQ+MtvvQMRPuU31c6LVgzMj7ULTBuwSUkSEOA2bkbsWoKSEOlgTBA773f31erotJZjmklUc6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2jRJCNElr7BJQE6MpKKLIsOzaAsBskANE5aYbQ3OE7U=;
 b=QcSGRRzyc4rt6kURNNGovThkEwAL4H985Jzxz1TAok2wo77zRYo0JqDYbu46b+s82DkZUSGMioE4+3/Ae3blJLH5LmSXDn+5pKJHH4TOV70FGvEpKq5cepsTO6ZO5or1tqLuhvaqgKt3i3o9d2/9l8FkAPd5+ndUFdMCtwL1BvzhYf+kvbRrA429NVxlzu0eK46LLDeTqae8FEII4eEo/Oc+lGRIio36Lam6kYHVY3WP9gWHUjdlmSJlMSpmWTUdlkjYs0Ibeqj0vBAQlZsv/nHuqoQXACAvWzL+aORYLO1/sM5R8bOyKDc8N1rz70WuqDNHjhThAbwD/0tu/JLrjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2jRJCNElr7BJQE6MpKKLIsOzaAsBskANE5aYbQ3OE7U=;
 b=3ZnoWHZIMH73XN1EzuW99y2g/T7Opb/NStaXna9gEZ7uEg4nfw/XjxCRaZQZUHn+Q9035fA6Vci5wLDbidhRwTfYRkqvf3ZPDO+gzKE8aXns9NDujmpSA4Qmv+Y52xT8S8ZiUY30HvsmU1AA5zp1cUTlVjf+fCcs+w6KhBnolCY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM8PR12MB5445.namprd12.prod.outlook.com (2603:10b6:8:24::7) by
 MN0PR12MB6245.namprd12.prod.outlook.com (2603:10b6:208:3c3::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.23; Thu, 6 Feb
 2025 08:56:26 +0000
Received: from DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::a544:caf8:b505:5db6]) by DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::a544:caf8:b505:5db6%6]) with mapi id 15.20.8377.009; Thu, 6 Feb 2025
 08:56:26 +0000
Message-ID: <49dd39ba-fda0-4ea2-830a-82b591b48332@amd.com>
Date: Thu, 6 Feb 2025 15:56:19 +0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/8] Introduce debugfs support in IOMMU
To: Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>,
 joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Cc: vasant.hegde@amd.com
References: <20250206060003.685-1-dheerajkumar.srivastava@amd.com>
Content-Language: en-US
From: "Suthikulpanit, Suravee" <suravee.suthikulpanit@amd.com>
In-Reply-To: <20250206060003.685-1-dheerajkumar.srivastava@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0052.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::20) To DM8PR12MB5445.namprd12.prod.outlook.com
 (2603:10b6:8:24::7)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR12MB5445:EE_|MN0PR12MB6245:EE_
X-MS-Office365-Filtering-Correlation-Id: 4afddae5-a6f5-49a0-41af-08dd468c235e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?clVHaGNQZVNaelJVS0MvK3VGcFRPNVlqYnZhZXdqSnVVN1VzVC94KzBvR0dj?=
 =?utf-8?B?U3NkYWZvSjhhcFZXNVdsZGZSRjNPQ2plZFB3YzNXQnpzSm9MQmtJV2psUng3?=
 =?utf-8?B?Yi9kYzdPdVFURUlPN2VmQm1ZMUlFK3RWUThtSk9Cb1lJdzg0cy83WXFNbzQr?=
 =?utf-8?B?OVlCNXNNc0MvSTFiSGU2MXNqamdiWGR5dXdKVmc4MkNWZURNUFpSSW4xbzhh?=
 =?utf-8?B?L2FaMys4dFZ6WGcwUWx3RGk4aWhUK1ExMUpkWFh2NzVzZHhoKyt6WkdHbWg3?=
 =?utf-8?B?SWRzOHM1c2xOMnMvVHAwWnRGdlhoY0RVYk1VdnNaZTVZR3JqSDkxcXZBbDg1?=
 =?utf-8?B?SUVCL1pJTUZOR0RWSWZOcXk4T2RhMnlrMFZPSlpVUDNmMmpPdG84OHJ1a1lq?=
 =?utf-8?B?dXhnRmxOSHJaN3RRNEtYRGRHTlVBUVBDWGhaRVljaVhMK0lzWWRFUWNkaTdl?=
 =?utf-8?B?M1RZWllCdEdRZGpxOWZLVTFWTmRyZWJmNnVnb1RmcVlicVFva2ttWFdpSmNn?=
 =?utf-8?B?K2NlMmhXdXgxOHVnWStVdXlsdGpxOTV4aThFNG01Nm5YRTAwL20wMGo5MjZn?=
 =?utf-8?B?QVk0RGRYdDlSYkFUVU80T3RqZjdqNDJ6ME5MZWNPRTlxZmF0QS9XRXlES085?=
 =?utf-8?B?VUh3bExjelZuVlFRaDV5ZytLbnNpSHdJNlliL1FwZTZyalp4TTlielBsVUkw?=
 =?utf-8?B?ZWJ3MEYrSWlVL2ludXZaSEJqUFkxeEhCdFBzRVlBaU52ck5mZzU1L3Q2SWtC?=
 =?utf-8?B?bjZBYXE5c2tDWWVPbUE3Mm0xdzA5ZmFtcERPK05FbVJPZXlpNmJEb2c5Vjl3?=
 =?utf-8?B?QVRTa2xZSmxXbGZTMjJqS1VINzVXUTN3ZHg3S1ZYUmlZMDNSbEdITUxDaUdm?=
 =?utf-8?B?bVNBNHlpMTBaSXhTOUhpRmQ4aW85eDlYS01Jem94U2NXcUIwNzBMbUEwUkpW?=
 =?utf-8?B?Q3VoSUhLMkxJQXovRUgwYU9yU0RadE9UWEcwL0QxYXdXTFRsY0Nld0Y3dzN6?=
 =?utf-8?B?VVhVQ3JCN3drSVhXczJFdmx0RmozckxSdElVU3pJdGgySlRaMlNNaEVLeXp2?=
 =?utf-8?B?NFJvSktXZ0huNnd4dlQ0L2VHQ3NNdHBVWS9wRGx1bHdQYXAxTHo3R1ZDVVRW?=
 =?utf-8?B?R0Rvb1RFdWwwVHVKcGpDUC8wZFN0RDJFVU55WHdBaU4zUWxSbFBLcG5iYWI4?=
 =?utf-8?B?WEF4cW1BOWhHL0NCNGJoTjlyVGRQcFVzWDB5eFpUWjh0cEVOcFd1ejJTd1lX?=
 =?utf-8?B?ZFVkSVlJVlowNlJIMUpvMkRXejNyaTR6ZjhjUmJ1NGc1N0ZlaEl2UXRaNWpw?=
 =?utf-8?B?RTh3QlRNQXN3cWFaQ0NqQ2dxcGpSSFZheFFJN1VROUk5VVhWeXc5SEVCMnBU?=
 =?utf-8?B?NW02aWFZVHczOFpJeUJzZCthMDJRcHNFMFBxZEVPRXBhRW9DM0FCN0F1dVM4?=
 =?utf-8?B?b0pIZHNXZFhKdkp1eFlwV0ovakJSSnM3N3hMbG5LMXZ6OTY5ZzMxSG53aFZD?=
 =?utf-8?B?VWVNVUJLYlZpblFMYm80NTJaNjJNaDVEd2hndkw5cmVrUWtoVkNvRkNaa1I2?=
 =?utf-8?B?WFRWeW9LeElVNGNudjV3RGxibktXOUtCMHVONWJ5MUtYSG50d0s5M2Y1VEpi?=
 =?utf-8?B?blRDaWdBZVdQcnhEZjRPays4cDhZUURlRDVySFBUTGU2M2I2aU9lNjdOVVZt?=
 =?utf-8?B?aS8vTVJJd1hHckRLSVIySU10SEFLTlM0OEVjU21mbXR0b2tWSXJ1RmpsMmli?=
 =?utf-8?B?S1RkdTc0SytuZEl5cmJhTWtSb1RQaVB0QnR0L04wRmZ0S0Z6TlBVTmg3UTU5?=
 =?utf-8?B?QU00bHJ1SnE2RGwzWmZjZm0vMWVHaUJFTTR1YTBvZzh6WE9LM2liZVRMeDVT?=
 =?utf-8?Q?Lvfb14uUE5AOt?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5445.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YWVwRGpleHlIZGFsMmhCMGVuTVFuRmxEc2dEeVNTb29tYWUvdFpMbkx4cHAy?=
 =?utf-8?B?UUlkZDg5SVRQWW9LaUdTaXJwSFBmR25LWHR4Nk1HTUlMdU5iVWhvbTRPd0Iv?=
 =?utf-8?B?c0dYaFJDdmlwWGJXU3hQVkxFVGVaNmpDaWJ5bUY2M3VjWXNibDB5RmR1a3V0?=
 =?utf-8?B?Vkk2cUxzWSs5bi9heW1IQjhvYnJYd20xcC9xK2Zlc2VvbVpuV0dnMkFpVUNh?=
 =?utf-8?B?MTBHV3UyOHRKRGhyM1pqeDFqcjZwNE1ZWGNCOFZBSUpmVVUxbGhBN0JmdUxx?=
 =?utf-8?B?dzRlVzN6T2xEbTZOSVp2UjFoY1FtSXlzRXhTRkxSd3BnTDQvbjU1VDg0OS9E?=
 =?utf-8?B?S0x0bGkvNzVMR2tad2VpK3ZUKzRjWDlNVFo1UWpXQjVZVnpwQ3RLb1dpYmhN?=
 =?utf-8?B?enM0dXM4ZU5IUTU3TlIxU0srRWt3bFNvWG5wb3BwR080ODdQeVFOL05zK2NU?=
 =?utf-8?B?SWNiWlFJK2tFZkNkQ0o2RmpzOXpOOHc5Qjg1SDh4TGt6akRTUlVxRGxneURU?=
 =?utf-8?B?VlcwQ1hqTC9CKzJHb3E1d1oxN1k3T29TSko4THlKeENjcU1RL3ZoTkNzWkFC?=
 =?utf-8?B?Nm9qYWFuTFBaSkhPTWVTa1JiUnY1Q2p2Z2liZFcrVEZyOHJuWE1vM204VnpZ?=
 =?utf-8?B?QUxjOE94QWZocWt1UXB6RGNVSXFMMTNiY0ZQUE5kWkNibTlCY0VEWWRyUlZC?=
 =?utf-8?B?c3lGVG54aXpmaVNoaC9rVGo3YXJrbkpoT0NRelc3dlkwRDJQbTVyczRHMTQv?=
 =?utf-8?B?OUNvWmpDMGtCOTdGa29lZWRHWWJ3N080cVQveGMxdGxZUk1EQ21qRjZpMEJG?=
 =?utf-8?B?RlJMLzBQbEtZWlllQ3dxcVZWMmYweXRkMW00SkpBZjJ3Qkt5UWdzT2Ixc3Bo?=
 =?utf-8?B?LzBucVQxMjlpWXdSRGtpK1BBR0lleVBnRHpsN2tFNlpMbjhla1FEdFhrU29P?=
 =?utf-8?B?WUNNSGpHWi9RREcwTEdMT3Z0Ry9EQllPSm4xcW1aS2JNL0ZnYlJhTGtSRWpp?=
 =?utf-8?B?S0RtWjMrdmZTb1RvVUxZTnRLYlo2djJTYll3eUd3dC90aVNTWkE4VnhwR3VJ?=
 =?utf-8?B?UWhXZHFwMktQdmphRFY1ZEFVN0VWSTRFbUN1WXdzMWVPRUdwMFpmNzBnbDNw?=
 =?utf-8?B?bDRjb2VXY3JjRjMveEVTM0lIMDhNY2R0ZzQxY2xJL1FKSzM4ZXJYazArSy9z?=
 =?utf-8?B?U05VaFk5d0FrL1NsLy9BNGpzbHNIaUcrQXhMeml6RmhzRG9kRDNLZTBIeDZw?=
 =?utf-8?B?YjJPZDEzeFd4N3VBb002ZjJDVEhJQkFWVTBvbk41TGxPSjdVTWFwekVlWW1D?=
 =?utf-8?B?d0czdGQzZTJGemFuNlBFZ3IvYkI1c1IwbWtsR2Yva0toSzRrRkNZT3BpN0gy?=
 =?utf-8?B?dHhUQUw4b0F5QzhtUmh3OTYvL01aQlMva01laVVVcVhmb3VveWhvWEoyMnB0?=
 =?utf-8?B?cnNtMld6amE2OHRldWtYSXNPcllFVHNVdERBMHZ0M2xwOThDd1VzWUg2TXNj?=
 =?utf-8?B?YnB5ZGNtWU9PTm0wN3NzODdDKzRUZHlSNXVCZWFNTG1tMkVxTVN6RUM1WFZD?=
 =?utf-8?B?amtDVi9pc2UrYkxNK0pTbjNwc0dxMGJBRkY0RUUyV0VRaEVtb2RjbXNCZWlQ?=
 =?utf-8?B?T1hETE1EZzJoZHdpMFhTSWdua2lDTG80UmZXT3JydkhNcG1LUU85NjM4V1Bs?=
 =?utf-8?B?WGhCTnJRTEVxRzVZMnlGQnNDNW1BS0VWQ0hvb3ZOajRsWEszSnJiNGVHd3hl?=
 =?utf-8?B?RzZwazZsM0M3NmcrM3hmMXp4QU15TmNNWVFadWZLVlhWM2gxWm45Y2xYUDEz?=
 =?utf-8?B?c09TVUV4NytTcXRWZ21NZTRrSE5DbngyTDhuOXBQcjEzS3dVZWhCbVNnQ0dG?=
 =?utf-8?B?TzdHM0lGa1BqMGs3ZGxTMTlwb1JBMmJSNDJTSkZxcjB3aGRDSno5QVF4SFdW?=
 =?utf-8?B?Tk12UDJtTzZGZ0hjcmF5UXdRU1BTRUhaM3kyZGlrUCt2VUlKVHZmZFhBNjRp?=
 =?utf-8?B?VERjZ1Fsdnl0OUM2SE8wQjduYnZzck9XTkwyaWZtWTdEa1FwdnIvbDlxUjM0?=
 =?utf-8?B?b1k0b0tSQWlGVjd0bi93NGxQR2xrYWZ0Tm1DUnRnRzRGelJ6V0xXa2lLalAx?=
 =?utf-8?Q?q2mWC+BcZO9I7eAwEBwz7J4lV?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4afddae5-a6f5-49a0-41af-08dd468c235e
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5445.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2025 08:56:26.2834
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VD4I3uWam5xx/+DwIJEJS68BFFz5rBs+HYnFfklaHpq8PZfYJohGgH0VCgL3fnO6rGHp1OOtgAA4xUdcmUVEGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6245


On 2/6/2025 12:59 PM, Dheeraj Kumar Srivastava wrote:
> From: root <root@BLRDHSRIVAS.amd.com>
> 
> Introducing debugfs support in AMD/IOMMU driver that will allow
> userspace to dump below IOMMU information
> 1) MMIO and Capability register per IOMMU
> 2) Command buffer
> 3) Device table entry
> 4) Interrupt remapping table entry
> 
> Analyzing contents of IOMMU data structures helps in understanding IOMMU
> capabilities and behavior and debug issues faster.
> 
> 1. MMIO and Capability registers - Add support to dump MMIO and Capability
>     registers per IOMMU.
> 
>     Example:
>     a. Write MMIO register offset to dump it
>        $ echo 0x18 > /sys/kernel/debug/iommu/amd/iommu00/mmio
>        $ cat /sys/kernel/debug/iommu/amd/iommu00/mmio
> 
>        Output:
>        $ 0x0003f48d

Correction: Based on the documentation in patch 8/8, the output would be

	Offset:0x18 Value:0x0003f48d

>      b. Write capability register offset to dump it
>         $ echo 0x10 > /sys/kernel/debug/iommu/amd/iommu00/capability
>         $ cat /sys/kernel/debug/iommu/amd/iommu00/capability
> 
>         Output:
>         $ 0x00203040

Correction: Based on the documentation in patch 8/8, the output would be

	Offset:0x10 Value:0x00203040

Suravee

