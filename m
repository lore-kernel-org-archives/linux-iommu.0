Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2068.outbound.protection.outlook.com [40.107.244.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8907D180A88
	for <iommu@lists.linux.dev>; Tue, 14 May 2024 19:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715713348; cv=fail; b=JZe3BNEDKDBSVEDIIC+QQFHDpGub1rPR4k02lpjqrHI9EJgiNm25RGFlFZu/OYa0fj3xRsUc3RCriULNeY9OmZsxQRfu7w7bhrZI6xjqwCIso6BuKzLMJIp1IvPrgkHXx+R6RWQEgcx/L9ErA9KeqJ3a41eE+4RAZxA5pnOo/4s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715713348; c=relaxed/simple;
	bh=IpvbgRGTmhRen8xLBksHiUP1Ez9xxnATmlRlkpqqYcc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rn5l5ookEafXODhtkqkzONEl8Mz3dTO5FeJnZAVRkxI5BjBuys7zhnslV6f7o3g/5LfCzE8mwyRYfie8zumyu7KTm1xZvSlrQGsA6/XpqMSUyHx34GCvZaidOFM/unekpv8Ya1wiqiKjsel1XMRLl42FADM+a+OzHrQmzGsfW8k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=tSovA4+A; arc=fail smtp.client-ip=40.107.244.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="tSovA4+A"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kreBmlLMbUBa1/1xw7js7fdCGs3EPPNCB3IApBy0M03fyTxBQ+wj9pmNNLcrQqQOLaZDo1pO9bLcQRXgLCuWX1lYr2zQpajViSfNCKWZlEEIz2K4myyYxQ7n66w7CsDAekapKsYMLLXijHCe/2uKn9nB3j4BBnvxh1zaxaW76ERwrt3rSktm/EbZzHrUWCkI0JmzHAkcZ2dWQouy8jU/8soNMbtnwLan2P4NYvzazTrvFETHJ4agoT0fw2dzKAzTe5F5ZRfceY3RFjhV3nSLv/bueEB8nxWq5ug7B6jqHiL71FwOUjGlszB+sNmWEJPwNZXUFPHeMG2sw+Qtw+Bdpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XPFGeu9uCnr2nOTTberAiIPOJjJw8Na7jolLoNJBleA=;
 b=h4777bNzbhBcyIx/C32RYXIjYNn8MXoVdKEcLTfcuKuY5Ttl9m/Xazis4utUTwlvCiM12lH6+5mlD8aU8n9YV0ZsgoQlUPzNlTEy2LKVSFwhLqXDLrI9EHrqEVDjXCKLhy6yB6r5trErVHmM0NmZPKkC4dUEjIfb3fP/dq0bteQkw8IBOHESOFncZq+KAE62Ep2CcHUcgP/gO6XBI447eRKJb6/dU3dhsG5Sn2Bl/7eT4RFj3qu/lks8lDqPI5UfrWbyMvPN3J0VgSeuO4P6wpBoKk9lTzkVWimlTRE490IZ1MFp4lugrq7MaglPYqfNDsmI9fl5cLNmP17uOMkPPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XPFGeu9uCnr2nOTTberAiIPOJjJw8Na7jolLoNJBleA=;
 b=tSovA4+AuXgt8Ykfljvnd/7eax0Njeb1WNkBhr4crodc9KU3IiH25NNavot1RWDbiVZYkKQwDJYEMk9so5nfhSkOh0bEJaxhV6xrUk0w5AZEpLtxo0OVJ6BlkUAmjpIQqKm7CAUWZwzzSaSXfzM3zLnTGCgxYtepU5mnGE0EdEg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM8PR12MB5445.namprd12.prod.outlook.com (2603:10b6:8:24::7) by
 SJ0PR12MB6992.namprd12.prod.outlook.com (2603:10b6:a03:483::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Tue, 14 May
 2024 19:02:23 +0000
Received: from DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::a544:caf8:b505:5db6]) by DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::a544:caf8:b505:5db6%7]) with mapi id 15.20.7544.052; Tue, 14 May 2024
 19:02:23 +0000
Message-ID: <24a4eb65-5e1b-44f9-a8ae-71f5f8f26ceb@amd.com>
Date: Wed, 15 May 2024 02:02:12 +0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/9] iommu/amd: Add AMD IOMMU emulation support for
 SEV-SNP guest kernel
Content-Language: en-US
To: Michael Kelley <mhklinux@outlook.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 "joro@8bytes.org" <joro@8bytes.org>
Cc: "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
 "vasant.hegde@amd.com" <vasant.hegde@amd.com>,
 "michael.roth@amd.com" <michael.roth@amd.com>,
 "jon.grimm@amd.com" <jon.grimm@amd.com>,
 "rientjes@google.com" <rientjes@google.com>
References: <20240430152430.4245-1-suravee.suthikulpanit@amd.com>
 <SN6PR02MB4157E795C636EBE75CC806A1D4E22@SN6PR02MB4157.namprd02.prod.outlook.com>
From: "Suthikulpanit, Suravee" <suravee.suthikulpanit@amd.com>
In-Reply-To: <SN6PR02MB4157E795C636EBE75CC806A1D4E22@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0004.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::22) To DM8PR12MB5445.namprd12.prod.outlook.com
 (2603:10b6:8:24::7)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR12MB5445:EE_|SJ0PR12MB6992:EE_
X-MS-Office365-Filtering-Correlation-Id: 21a40b9b-53fa-47ef-6dd3-08dc744862f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZVpKMVlFOVZkR0JTcDdYNVNuT09Cclp2cC9rclZyWWdvdVArTjNTSjR3dmpB?=
 =?utf-8?B?R3ZwRTJ3U0t0dUZMV0tWd2pTZ1pRUXJCM3cvdE1FQndZTEhHKzlKZExhYkRi?=
 =?utf-8?B?UFl5U0VnaFdaM0NhM1pNWlh6cUFqZkxobmRFbjJZbzJoWDkwc0U3Y0RhSU9Q?=
 =?utf-8?B?OEZ6ckthSE1oRVloLzZ3NDU3bDczOTExT1VKbWNFQThma2QydGJ5R1BXMC9l?=
 =?utf-8?B?bG84WXlqRE5lZElNL2l0NXVIdGpuYXNPWDFDV0J5Vm1vWDBDUUtDdmhwOExS?=
 =?utf-8?B?d1V6OTMzSDBwVFJZdVk5OHRwN04vb24wYm5DS2wvanowNUFab1Jzb1gxZjhX?=
 =?utf-8?B?cVBVT0t5S2xzMllHTnhYZlFiNGdISmxQSWs4enlxUkJSdkNOcnlTZVh1RTBq?=
 =?utf-8?B?b3F6YWR2cHE0M3VEclViYkl5MlBhOSszT2dFUWhBdUZ1SlJpZ21wR09FMC9H?=
 =?utf-8?B?Qk1BMUlXa2hYeTQzcWhTSFJmeDROQ3p3YlJsV3IvZ2FweFk4bkh3cytjdG9D?=
 =?utf-8?B?dnFuTVFtekEvb2h2SEZEZExqOFhFeE1JaUhCYWUwaVl6L1J1L1FrRzJkMkVw?=
 =?utf-8?B?V1NlbkJWWjk0a2VYVjFwb1B0WnBRa2RxcFFGZmpxTCtVT1hUTzZaZk9TK2dE?=
 =?utf-8?B?emZEMHVaNHNvLy9OM2psajIrd2NxTHV2SHJUcktMWElIOVJXdVU3aTd2a05y?=
 =?utf-8?B?RitvOW0zY3N4MHY4cVF2Z2RISkhabFE5ZCtwdGJHU1FpcUxlVEVUT0g3dkZ2?=
 =?utf-8?B?VFRxQmVNOFdzUlBwMlhNQVVvY2JxclYyTlFEbVRPVmczTjI4aUN0SlpIeHh6?=
 =?utf-8?B?NXRPaWRlOER4ZHhqaWhXREU1ZUpQWlJRcWM5OFZ1K2ZXNE1pMzZzYk1oaGVY?=
 =?utf-8?B?ejFzV2F5TUFsWUVTL3FieEM1YWpWOVJnZHFuK2tvclluelBCeGlENzIwbjdm?=
 =?utf-8?B?YmhnMmoyRVZGTE14Vm1rWUxQT25qcTlGUVpqSUFFTi9QbDlISEtibUQvQ2Y1?=
 =?utf-8?B?S1pYemFzRWlGQzdLT1hYVk15UVd0US9Cd2IwNFJwYnRwcEpBaWZZS0FsZGt4?=
 =?utf-8?B?TG14UC94K0lOM2piQm1Bc3YyU1UzL2RwcnBNTHRLVGozbXV0bElnN0tRdHNY?=
 =?utf-8?B?L2JTLzFjejBjWXpEenZmMGVrS0NWYTN3ZmZSNVpwalUvTVVMYXlaOFYrTGhH?=
 =?utf-8?B?bkdMYmZGUTY3Z05tZEZXSll4N3ZVQkVNT1VVTGdzS2pITjNFclJ4RUtOdGw2?=
 =?utf-8?B?a0ZSYkFFeTdkK0RkRmFZY0NuVXBsRVJjR0htYncvRU8rMFJCVkZPVHZYbm5y?=
 =?utf-8?B?NHovbU1IbFgvUHFQeDNmNWhJZE1JakNLa1duTUJFTEtxZmpwREkxaEJ5dVJU?=
 =?utf-8?B?RjhDdmJCcGx3azJiYzk5OFhKSDVQWWRBRTBmZlkrNVhMS2tKcGp2VktTdWxC?=
 =?utf-8?B?S1R2WEFiek8zamRWclJsYXFDcFdRMlFsYkFXTS9XV2JpQ0NsQmJJdnM3VTJH?=
 =?utf-8?B?cUo5ZDJZQlVRVzlQakZES0Q1c25yWGxIb3JLY05DWDB0OWp4N1RMaWRQS1pF?=
 =?utf-8?B?R1ZsQ1oxV3dKWnVvd0d5cnUxVjJhMlpqdWRidUhyZFFsU2JuWDg2ajkxNE9n?=
 =?utf-8?B?bjNEMXAyNENjaXVBak52VlhCVXZTdnh3YVpwSFNtSUNoQS9wZUJldVNZVFF4?=
 =?utf-8?B?OEhFMjFGdTVyVktKazEwMjVvQ3pWanlDNnBSL3NOOVJNMWhWWFovWDFRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5445.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NDBLZjc4dmdVNkJra3dzMWpndW1zNkJrcHVzWFUxQ2tQZnJLQzRDaStSSUM3?=
 =?utf-8?B?Y3FDd3JVa0JvbEl3aFRqYlB4MFRrRmN4NlRMYjBrcFkzMWxrR1E5TVBSTG9R?=
 =?utf-8?B?YUUrTXlPNWNXMy9HaGd2K2UrQU1vRmJOUnM4WnFBa1JrQU5CMjZyd0JUdFBv?=
 =?utf-8?B?dXFJUkJra1lpdldyd0hodVdscHhpQlpra0JzRVY5RTZJTzYwV1RGTTVubEtx?=
 =?utf-8?B?M2tkckFOSjg0YVBKNWJQZWFYL0RiZ3Y1cUNqR1JPeTk0YXJoTGFQUlZmZFd2?=
 =?utf-8?B?bHF5WDRjaHhXN1JFVGZ3SXJRcklGMDQ3b2JhWGVBQXBnSmxEQnBGa3ZTeU1M?=
 =?utf-8?B?NXNGK1dKeC9laTJQeU5RWFIvWi9JUDliSk8zSXQvV2RNc1NuV1YvV0dYcCtL?=
 =?utf-8?B?dGVTSC9xNHZWQnVTYzJjRTZFZUoxYlpPS3QxUFFvQU9yc3poalZaUlB1aGdM?=
 =?utf-8?B?a00xVnFzL0dMc2RWY040RUZ4VnFhbWxmTFBnYXFrU2haZlJ5N2t2TlRZc29S?=
 =?utf-8?B?THVVRmpaZ1hhL09NU2ROcmRET2pVZU8wVG9GaWtzWExvdVd1VzNjUitxNStk?=
 =?utf-8?B?aHdYTzRwMks1T0p4cGQ3RFpiTWlMR3l5eG9JNUIyRnB2WFkwSVZtbHBacnZF?=
 =?utf-8?B?WUM4UHkxTmhsMVVhKzd0Y2ZZZTQwUUlmRnAwYXBId0c5cUo2cENpNy84REZn?=
 =?utf-8?B?TFlYcGM0NWx6bFl3V0tCdEtmYTVnVS9YRjVFcWdUUkVHYkh6WElneUN5djdG?=
 =?utf-8?B?V3pSSTk2Z2dZWFExRjVQc1dZQnkvYWZadkRlZUE3UEh5SnFDWWRYTm9BYytx?=
 =?utf-8?B?cGFrNHRlbnpxckExb2dxc2RZVGtVOFQ4UW1hRUYwOUlWcmFDbHpBYXAwOWFQ?=
 =?utf-8?B?eTdJTG5aOXNkQjZ0aTdKajVGTjRRYVREdVFmTGxPb2svbGNIelpCNWc1dDha?=
 =?utf-8?B?MkZKRDRJU2Y4TXJKeis0blYwN0J1UDBJbGdySWJLdUtWYzlsWmhxa01jOHE5?=
 =?utf-8?B?WDVXaHFlRHlJdGNML29YaytmZXJDWTBUT0dyL3d5MTcza0JWdndkUUlLOWpY?=
 =?utf-8?B?N3dmVGV3SjdRL3ZORzhIZ0xjY2VaR2ZwVGVBOEhWd2lBZXFnQmZ6UGpIbm5R?=
 =?utf-8?B?ZnZjT1VWVzNpUHNVUTFaVVJBWUh1YjFLVTJLTEk3VTdKdlliR1FYb0ZzaGhE?=
 =?utf-8?B?a3p5OWllM0xTUlhDZFNXbk5QZ0JUcDlRMnB4S1FCU3NvekVSOGNPazg1WGlQ?=
 =?utf-8?B?cjVpSjh3d1E0OU9SaEN2U1lYRzVGKytadC9zTzdDK29DYXRPdWFuVE9sU2pU?=
 =?utf-8?B?VFVXN2tad2I5TnNLVTFaQXl1YSs1SUNXbWxOY21TTVJDajFrSFowSFVXWHlx?=
 =?utf-8?B?TkllMmF6Vi9wbkFvV3NvKzJrWE1TaHdiR3J6TG1OWE9TYmp1YUFQNzVjVGxN?=
 =?utf-8?B?bmJsSzBWUC9NMWkwSlVnS3NyaVNMMzNYRElDT3RIZXFwSkdQMDVvWEM1c2xx?=
 =?utf-8?B?M0VGd2w3eGR5QmtVTE1OajVObEN3YzN3ejYzQ2sxVWlsYk9KTEtucEx1UUNz?=
 =?utf-8?B?N3NrdlBmZ3hHaFdrb3YzbkpJRzJEekpEeHc0bFpHZ3ZseUducEQ5MS9BdGNl?=
 =?utf-8?B?QUh3SkVjRXF0QWtkMXlzd2szTzNPUGx0MXVuRnFENzZNbHpoQUh3cXV2SjB1?=
 =?utf-8?B?dGpWUXJxZWh2SW54QUpCUkc0elRFazZCT0pOY0E4ZEhZaHVBeURaUm9qb1pW?=
 =?utf-8?B?QmE5S25ya2VrWGRqQWZBVmJNN3g4SzlZWlpNNTZTQ2NlOVlIOElPRWRwWm5m?=
 =?utf-8?B?UjR4WXpPYkcxN25hMjFpN3MraVJqd2pJbzIvUnpxenF1T3VTVlVWNFVCajRx?=
 =?utf-8?B?aGVNSVpncDBmV2Zpd2ZoVU9UREMrRDd5Ulp0UFo1cEk4bjQ4Y25TRm5ibHd4?=
 =?utf-8?B?Y1Q1dHUvWDZIRm9hejlxeWNSekI1a1dydlEva3F4VnZ5RjUrNDhja28wWHAw?=
 =?utf-8?B?b0QwVzdDd1RaM3krcVNCTEVnU0J3MzBjUXZWTVg5bDNjYnVLbUVlMmdTTndS?=
 =?utf-8?B?MGkxMXFCL1p5VXlhQXVSVWk1UzJZeGtvSkM5QTN6dmxLQXV0eEtKSlFYNmJS?=
 =?utf-8?Q?93aialCc9r8KULmKhzyIphfEp?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21a40b9b-53fa-47ef-6dd3-08dc744862f7
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5445.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2024 19:02:23.0336
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qGd38xaKsGZw9VkRMqm5Ns+4YqEFMnm5rtranMIHN5dYdSbEr6D6DFhHtDMSVl3iWixnYG0RD5W9Ty3krgv2lg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6992



On 5/14/2024 3:05 AM, Michael Kelley wrote:
> From: Suravee Suthikulpanit<suravee.suthikulpanit@amd.com>  Sent: Tuesday, April 30, 2024 8:24 AM
>> To boot a VM w/ x2APIC ID > 255, guest interrupt remapping emulation
>> is required.
>
> Top-level question:  Is there a reason the MSI extended destination ID mechanism is
> insufficient to avoid the need for interrupt remapping?  (see function pointer
> "msi_ext_dest_id").  I'm unclear on whether it is or not. If it is not sufficient, perhaps
> you could explain why.

In case of running a Linux VM w/ QEMU/KVM as hypervisor, the 
qemu-system-x86_64 option kvm-msi-ext-dest-id=on would allow booting the 
VM w/ x2APIC ID > 255. However, for other hypervisor, it might not 
support this feature.

>> For SEV guest, this can be achieved using an emulated
>> AMD IOMMU.
> You've used "SEV" here and in several other places.  I think you intend this to be
> the more specific "SEV-SNP", and exclude SEV and SEV-ES. For avoid any confusion,
> I'd suggest using "SEV-SNP" throughout if that's what you mean.

Actually, The CC_ATTR_GUEST_MEM_ENCRYPT attribute is true for all SEV 
guests, so this will enable IOMMU emulation for all SEV guests.

Thanks,
Suravee

> Michael
