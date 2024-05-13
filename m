Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2064.outbound.protection.outlook.com [40.107.100.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87126604BB
	for <iommu@lists.linux.dev>; Mon, 13 May 2024 18:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715626789; cv=fail; b=lPBqbbEZfFUnigYmG3yKQhIRbeTCCobX4a18fqPAPn/R1xCkN9XqZ5PMHSVJGCIuJ8oBMYXjXN1wqNKANoOXHgXLovBj9Y52BLBzQSa3auA9uwSRreB8kuruxAVYfYzrXNDb4TSTXoPfOnugUcWcveY52C51htdlh6yyRNmXNIk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715626789; c=relaxed/simple;
	bh=tSvyq8HDQTA2emsbH9DupS6eYq1R7xTL7L4Y8UVo//Y=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=aYXkL7XRq801s767KjO81im4e5w+/jEimqz+v/NhCJvKoN9XY7yTeY2D58NM2nsi7zWvim5nwrjnZWjyt7R6J3+N/2XVGsUZrIRLu2emblwTNv/SvHhXsANfFtPm0Z6xgthSgP5wZObxGvNa4q8DqksuiaE+ydotmKELLddYX4s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=aNrFTHXq; arc=fail smtp.client-ip=40.107.100.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="aNrFTHXq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K+o94ZNKbmzplV/evyIvgowHbFuCsBZa73pt/pYVILGf2hsxVNF2kFvmJgXmQiY+p+j6oKDv+sBD1aTHDJBj0xW7mQ7Ig5ZC2/gc81NpDYmUeKrtzRflptgq2KK+q5lellBUDakWeOmh58CSYvOuW1+9Tl5AsbQ4oqLkM4KhM0/FFN7TnI8p7sTbA6A92enpp1RE18SMWaqtkmSx5Kh23bPzZrufUNKoaifxAFwWHOIVPH6iFLgU3/fTH1G6xR8toxh1U8Nw5qPFkqWDo9DOiYTj+vzD587pReTppFHuvTTxNQAHB5YlSXE+FcSNvgx9yM5+1/eO+2DPvH8Tz+k2yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+f5QnsIuGZlWpgfbjeMLEo5DPwiFZmubVWuFJRg/LdY=;
 b=IiNHHnjbYr0WwFLCVeizTc2ZZ/KorXutqUhRIEWY+hO7PCCa/pJu39L1Fh33Z+mqsBPLoNScJCowkVEPpzHyiEso/eI/+JflqXkTvUU8Rs7fRavyEymnwqSQNFfwSLWmtOirCH5Gh9sEaI0iUJoTN8ihDPoN6s9MvqCxHKSCL8foPfKQ58K4EYQJv5xALh3w+MpZTyfMF9O2Iv3IMlNzEixq7nEJeat44OKbOK4f4tBGiJf8S9+Ok7ffzrBVpG89b1qwMNaYM/UlILsrwzfRpE7P1VATp3UdjD57f+97cdlr55Y8jGAfRXy6ZhyhcihsmZMzYETULIwdedrA+sGQrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+f5QnsIuGZlWpgfbjeMLEo5DPwiFZmubVWuFJRg/LdY=;
 b=aNrFTHXqIp6dbZEZihec00fYHjTdmGe+vKxTyRCqDdqL1mYvv4vkxUeuvxHwFpISCyDbGrY7lfa4FailXNpAOZCGlX8W0JyUjZVfxXg8GDmdRVko0A4xC4Z5KEpQ33xtog46T8InmhB46C8IXlZFG4VaNDpTJJTZ6OHRw4AafZI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM8PR12MB5445.namprd12.prod.outlook.com (2603:10b6:8:24::7) by
 PH7PR12MB7329.namprd12.prod.outlook.com (2603:10b6:510:20c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Mon, 13 May
 2024 18:59:42 +0000
Received: from DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::a544:caf8:b505:5db6]) by DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::a544:caf8:b505:5db6%7]) with mapi id 15.20.7544.052; Mon, 13 May 2024
 18:59:42 +0000
Message-ID: <1b03ba34-ac06-47ed-9086-f8d346a20bb1@amd.com>
Date: Tue, 14 May 2024 01:59:33 +0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/9] iommu/amd: Introduce helper functions for managing
 IOMMU memory
Content-Language: en-US
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, joro@8bytes.org,
 thomas.lendacky@amd.com, vasant.hegde@amd.com, michael.roth@amd.com,
 jon.grimm@amd.com, rientjes@google.com
References: <20240430152430.4245-1-suravee.suthikulpanit@amd.com>
 <20240430152430.4245-2-suravee.suthikulpanit@amd.com>
 <20240501161741.GG1723318@ziepe.ca>
From: "Suthikulpanit, Suravee" <suravee.suthikulpanit@amd.com>
In-Reply-To: <20240501161741.GG1723318@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: JH0PR01CA0051.apcprd01.prod.exchangelabs.com
 (2603:1096:990:5d::17) To DM8PR12MB5445.namprd12.prod.outlook.com
 (2603:10b6:8:24::7)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR12MB5445:EE_|PH7PR12MB7329:EE_
X-MS-Office365-Filtering-Correlation-Id: e95ea51b-902c-49da-586e-08dc737ed8d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dTdmcjJvcVFpODNBUFJ2UHh5bTdXRWpDd0J3b09xYk96akk0dE13cHJNSzlR?=
 =?utf-8?B?cTZBM0VDU3k4QWlKN3hVc0dsdUZiWGR1WHo5THFaN3R3MUdrSHFVMTZYYXR5?=
 =?utf-8?B?WlpHcDdFSWxBeUNjd2h0MjNZUEpKUDZyeUdZWEJEbnZXeTlMbDBKb0txcTZB?=
 =?utf-8?B?bWdPOWlQdWdrcUdBRTdoOVY3REZXZ2RrZDVST04wb1h0Wm0xWERUbHhkWFBU?=
 =?utf-8?B?bEFaaDJXTm5pUHAwellzVFRTeElTYWdZbHZPTUlmajc4cXg5clR0TURxcEtk?=
 =?utf-8?B?KzlQVFprVVBJOG1URlNDUWlxUktlampNV3VIRnNkZCtpcXVWRUpBNU9peWNv?=
 =?utf-8?B?ZE1NaDkwZ3FLU2pRY0NwdnY5Qk9zUXp1Q3pwWUpKT3ovN0h6aXg4ZGRxdW1q?=
 =?utf-8?B?SzY4bXVRaWtQL2FpaUdrK2crdzVMTFh4aHUzc3BzK0kyMFVkOGJRN1hjemkw?=
 =?utf-8?B?TVh5VFlaT2FSWFYwZzc4NHZ0SzVKNWd0REMydWpaVjBXL0dIVUxDUURYckFV?=
 =?utf-8?B?enduYnlObE9WQ1RHVXFvUFRzRUdzbUV2dGl3TXhiOEtITlIrSHo1MGF1OVZh?=
 =?utf-8?B?YWQrRGFDdmNKbHhvMlBBRDJxMVc3YTh2ekM4aG4yVFk0SFBUWnpESGEwNE5l?=
 =?utf-8?B?QmFBRVFxT2dMb2xEOTR1MkZBb3VFU0hxRmtYaTBxTWdkcjI4QXBBUWRRR295?=
 =?utf-8?B?aHBaUmdpWG56MDd1cndBZERnNUZ1OEJCRThCMmFZVC82M0RGVVhNYi83OWdT?=
 =?utf-8?B?K1VXaUVOQVBVL3kxTTZiRmRUU3kyQ1l3Uzg4cEhNV3Awc0ZUNXFiUGxJWTQ3?=
 =?utf-8?B?ME1jMTk1UWhra29tZmdHejR1THZiRFZQVzNEcnpLeVNZajg2bmZYUzBTZ0tE?=
 =?utf-8?B?S2RwTG1tZG8zUHJxdjA4bmQ1aEt2YktNM28veXJBT3lqL1NNbTZQaWlJdVB5?=
 =?utf-8?B?YW5XcEkxRDlmUWxQQWpJT0R4RnF4cGRqV3VpUmJRMUNISGc2S29MMkdFUDJj?=
 =?utf-8?B?SWdIWEJjRmo4RHNkREFPK01WZHJ2a04wL1R5V1JFWjNybVdhRDBkSWRsRU8v?=
 =?utf-8?B?NU05U3J3R2k4VEFhY0lvajlJRTFLZVNkcFBEbCt5M2dIZjhudUM3VUExb21B?=
 =?utf-8?B?ZjRYa2JzTVdzN2xuREpWdHJtQ1RNc29UVVIzUndHTkJ2RnFWMCttM2VvNDl0?=
 =?utf-8?B?QXBoMHlFOWRvOEJsWTBweXMvZTNMWkYwek4yREg2Tlh2OG0zUUxVN2Q0dkV5?=
 =?utf-8?B?TlRHbWpGanVKZWJ5cmQyTnhDTnhQRnZORnEyR05yYWZnSklQMG84anl6V3pU?=
 =?utf-8?B?VDdZYjZMbGVVeW84cWN1bWVKV0lWQzB2Rjk2czRGczIyaGtUdDZXaUZjTVU4?=
 =?utf-8?B?ZUZTTTVaYlJSTm1YT01WenhRaytONHZSVzQzNytVTW9jSUxudFFsZUpMRHFQ?=
 =?utf-8?B?V3RtU3BXL2NTUmlEcG9QTEhzRWhvRTc5OG82WGhxWFNza044NGJsQ0s3Vnlh?=
 =?utf-8?B?bWpmRVF1RlkxYjloU2xua2o2Q0xicmo4VFQxSTFCWXNQclEvVnJ0UmhpYUJt?=
 =?utf-8?B?U1NMZ1JJVkVrQ0Nub0lXY0RKSm9tTnBORExzRXdIODNWS0ZkMWlRUStMejU4?=
 =?utf-8?B?ZllCazZaTzBXRXhRUEtwUitHaTR2Yk12MkRGUFZIdlovQTIvVTMxNTRzUlho?=
 =?utf-8?B?cFNLRDNFWTgxOTlrckhueWNjTlBwbUF3K2t2Wm4zWXlzR3JpUWhLNThBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5445.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eTBFU1R1YXpQMFBFdE9Jakk4WDZuU01SeDJSaXhSS0RLS29YZitOQTJYVmdH?=
 =?utf-8?B?RzA5bHlNZkpSLzFjL0pYYTcvSmNGdVFrY1U1bUJIRUk2THpOblZPdTdNQkhl?=
 =?utf-8?B?VjBMaE9kWW1nWFZleEtwSWM4SGQvV29vQW1Zc2dOb3JhM1pLT0RURFl4SHhU?=
 =?utf-8?B?Q2tDUEtGSnlnbnVRS0p5ZDVETDhnN1N0L2hsU1hXTC9SRzZFaDRzclVScmtD?=
 =?utf-8?B?NCt3TlhSOEgyZ3Z3UFJoOEV6TElqSk1jWVFZTTQrY2MrNHc3UlhhN2NlVTVW?=
 =?utf-8?B?L2VpZDk3dFVQaFRxVWVZWEJGRzFiT1N6VDFxMjhJUHBqQ0pFdWZBWTAyUlJo?=
 =?utf-8?B?amh0bmN0UFhwa3V6eHlHWkp4MWtLVmdHRUdmRExOckVlaXZ2djQxVTMrWEdp?=
 =?utf-8?B?d3dkcThiblhBallzSXVlNkNQN0FRdmY4L0I1TE1YcUpFa2ovZnFCc254Sm9Q?=
 =?utf-8?B?SmFiZmExOVpQOGdnUEN4NzQwbUNubDQ0bTVMYTB3a2ROTXlOdW8xbG5yNExk?=
 =?utf-8?B?OGNkdmpYUXFpZG5PRktnTjh3dG81ZENzNjFrZVpwQXpjM3RDSDc2Tk0wNXc0?=
 =?utf-8?B?YkUzSDJVcEFMaU9NVmNJRGI4aVd5OXNzL3I0b0YwUGdnbHgwdlVKekx2RkN4?=
 =?utf-8?B?UFpYWG1INms3VlhHdXR3bys1VkZEd2pib25XQTFER0ZmV2JTMDBuUHZkM3JU?=
 =?utf-8?B?bkpmT1ZNSEdHZ3BsYzBsOTQ5SDhEMndObTFvUE5xSm5RQ3pid29yTkxJK0N0?=
 =?utf-8?B?MlVtTlJNNlhwc3A3SVU2U3QvZEhTd0treTlVcWsxclNsbXF2Szl6YkI3VUdK?=
 =?utf-8?B?eEJCRFA0SzFGaXVTR0pMYTExNnk3YzVpSDVCMms5R1kwellMa0ZIUzVIRTN4?=
 =?utf-8?B?ejBnOU44eEtkZmVqQ2RxamVLZ2ZlNENEMjd1cHpJTk5YNk1HV20wcGp2Mlkz?=
 =?utf-8?B?ak9rYUZjaWV2cktUbytSOE9yT1VmU2dNb1pVMXBsSG5VbnZ4YzRjUW9Xc28x?=
 =?utf-8?B?dE5NTU9LN0d3ZW4vOXJTTzI4dG5JUnNjbmU0Wi9nYlZWemVkc1lWUmRVL0Fn?=
 =?utf-8?B?N05KSC9QMGt0SWlrRm1qNU4zditQNWcwNGNGWkJkZFpZWFdwRWdXSERVamNn?=
 =?utf-8?B?d0x6eTRpV1RuUmsxOGpvTWNXb3paMytONVEzMHVlcnBwYlRscksveERaWE0w?=
 =?utf-8?B?RERGSFdreUlxc29UN2FDQi91bFdkcVpxTFhwNlUwRVhJdjJzZE53TXRZclpm?=
 =?utf-8?B?dlhPZWJJV0JiZU5nRFh6a09zbVBOUGlDWVBMVDFSU2hmeGRySUtIN2huTzZK?=
 =?utf-8?B?OXdVREdadm1OL0haN0NDakdxZ3VDWHg2Vm1rcEVzNnV4NjlFbFAvL2s5cW9k?=
 =?utf-8?B?Mm1FS0hSYktlaHRiWml1NjU0RTZKVWVKQ2VNaWlLNzBHdmRRdFg0ZlRPQ3FH?=
 =?utf-8?B?eVJtUUt0dkNmVE5yZ2NvVUxWZVA3eko2TWlnTkJHL1d3aG9PdlZqMlcwQnR6?=
 =?utf-8?B?Y3QrS0VsdDJwZXRkOFJhT1k2TlNodmxjYk03WFEvWGU0SXFyd0VyTHZOcTY3?=
 =?utf-8?B?Z3ZLcThoWVFyKzFxa1U3eGhjOVhrNXd1THkvSXN3QWZkZWdicFA0WFV2UUhz?=
 =?utf-8?B?ZXZLNXJMYXN1UXhYckJJY3BVdFVTRUhQeWxtVlY1amI0bE41dWlQL0lROWpr?=
 =?utf-8?B?RjhOckZhbmp3NzZrbnQxY0N6OHRZeUFGcnpRb00xVkpjTjdqdjIxNjg1V0s2?=
 =?utf-8?B?aDVQRU1SVzlQUjhKZ1Z4WGpzWXVOWGQ5WWJ0U3VOQUNKdVJiVTNPblZISW42?=
 =?utf-8?B?NkNOTldiRHRsYVYvM0o5M3ZZZVE0N3pMRUFUcXZYTUYvTDNSVVVDb0NqWXVO?=
 =?utf-8?B?bWxFSkFQWExCYWM2SnZyUnJqdXZDUWdUY3piMG1rQ3d5YmVvWHJWUEowR2hF?=
 =?utf-8?B?VEpFcXRoVFMxbVdvWU1xTk5Sa2R5TXhBLzBiMnFURkFBQjh4aXltWTJIbjgy?=
 =?utf-8?B?TXVNNG81U3I2R29JdDBtZlVCdG5wNjBOKzhqL2NUVmo1S0RXazhqcXFRS1Z6?=
 =?utf-8?B?cE4rUTNJUjYzRThReTh2ZEg0YlFKUFE4cE51bTB3U3JVMHg2M3gzVlRYc2J2?=
 =?utf-8?Q?RXtCidzdV3Un3weg1y3FOdhkv?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e95ea51b-902c-49da-586e-08dc737ed8d1
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5445.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2024 18:59:42.3854
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5vCGgN11jmS19Ihbh7cCvU2eiFzbITfESMo8PpATF7ApILeX/dRKYHkVh5z8Ca2jI2Z3M0etcMYlvFoIkhsiPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7329

Jason

On 5/1/2024 11:17 PM, Jason Gunthorpe wrote:
> On Tue, Apr 30, 2024 at 03:24:22PM +0000, Suravee Suthikulpanit wrote:
>> Depending on the modes of operation, certain AMD IOMMU data structures are
>> allocated with constraints. For example:
>>
>>   * Some buffers must be 4K-aligned when running in SNP-enabled host
>>
>>   * To support AMD IOMMU emulation in an SEV guest, some data structures
>>     cannot be encrypted so that the VMM can access the memory successfully.
> 
> Uh, this seems like a really bad idea. The VM's integrity strongly
> depends on the correct function of the HW. If the IOMMU datastructures
> are not protected then the whole thing is not secure.
> 
> For instance allowing hostile VMs to manipulate the DTE, or interfere
> with the command queue, destroys any possibility to have secure DMA.

Currently, we have already set the area used for guest SWIOTLB region as 
shared memory to support DMA in SEV guest. Here, we are setting 
additional guest IOMMU data structures as shared:

* Device Table
* Command Buffer
* Completion-Wait Semaphore Buffer
* Per-device Interrupt Remapping Table

, which are necessary for QEMU interrupt remapping emulation. Therefore,
we are not making the VM any less secure from device perspective.

> Is this some precursor to implementing a secure iommu where the data
> structures will remain encrypted? 

Yes, the is precursor to secure vIOMMU support in the guest.

> What is even the point of putting a non-secure viommu into a SEV guest anyhow?

This is needed to provide interrupt remapping support for vcpu with 
x2APIC ID (> 255) in the guest, which is already available w/ 
QEMU-emulated AMD vIOMMU.

Thanks,
Suravee
