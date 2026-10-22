Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.201.64
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792653380;
	b=SeP0XOV2j+JG1ZOlgcZBVhe0Ra43Lm3qQ/RrNkUDhJBKMc5vz2iMdLVaOmsSv0TIGCaJ
	 COoKYilpbXjPytEvsBCbCHaXu/JUAaUUdXV4Uu/GMaU67VuVdTePhHFbah9O0z2qGaRkC
	 BQ2vpmXOls+aXVr/dERVdHz9ubgfMDEN8sPcU58MgBsaPTi0uO3YAjr0XH0/tdMdWucL6
	 NoBix+GKY59EdrC+qWFb5gntAQ0An1xmWs8RXBk9LoysyE1HRCwzm49r5drhgkb+zC+/n
	 wikomJfMUvz9fz7NWmmdEu8Gp8Dgvx+h98blcBR18j55OOkq8lEHgeeyG8zQ1yYBFmQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792653380;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:Cc:References:From:Content-Language:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=0vj8N67BISoQNb9JnmEl9lhNOssRDE36mqWhGAzhZY4=;
	b=klMZiHuBFqzt0Xoc52LErgrx5hrtvNvTzW8+Cx0fiiL9qsNVA7gZXYS90M4ogkkWzJj0
	 bx2T8Xf82YSKBr57ZxeiwT8QnR3bX5m0TDXh1y4JXa0nLRnFv+kWTbjggmrFrukzclEty
	 VfViOPLbxRTNCNJDSl4gbU7TmuRUjLRsuA+SmQ4OY7a30ZZXIE8YKj/i9hrAsFYC+VuyG
	 WJ+fOL62yCyQPiUuR5GzWNHuCboKsl/eL4qK5/rkoGY3WsPKzwo6OE/KzOUClQkI1J+Jg
	 A5qTO5Mncr0JEP6hwQBkVPjQApDRBa1j12jgMBy3Zw6OpCW9vsPQ9TqSSN62mb80EDA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=kLHJCmJO;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.201.64
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010064.outbound.protection.outlook.com [52.101.201.64])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCE6E606A31D;
	Thu, 22 Oct 2026 07:16:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BCE6E606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=kLHJCmJO
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JYJsOKrDhqb9ZvxwlrrOtz1F9mON5Uzpq5xPhTtktUxbu+G6YTooh/FEfCU9wwQKEzex16TNa0FMdpdwDbIcelgj+EgEYjsqrIsrsNwwDAnu2C83mzKtN8k1euUJFFzXVYqjJHAb9mX8Oh2FlIvFJ7KVUJp0N7U4D0DsGPunuNPOaTSv+lmUm899yn6dUppHfxNc3VhyPF0uXNC7mWSqT7LccMjbiyL8aE8LurfFeAEjPe0mNYSQUpH4/9xAbqTooI8pClYOUCgp5Phuel95DrBSDz6rM8mMhzv/o1qvp1NTmWfQ+9YF5MPFIlAU5L/0PEfgCYWxuWkS0qAkuT96AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0vj8N67BISoQNb9JnmEl9lhNOssRDE36mqWhGAzhZY4=;
 b=aQfrDHuox7UqEmJp57pj6nncxU0Ko6BC3AH64fQivZaI1cYsi9Z+K90RaZcTGMZzgRBom6SBNviIicErqfEHbOmBGNRhnfpV9M75ONF3eW2K55yhitmMVfbYuuo1k0WndPF3SAJrmfLKW6A3oXSt46+uYDXjeVs1G7Coy3Q18INzGEwL/MbDsZk9PY6SMsfgy0m7T4Y8jyLj6p8eGPa/mcBnGsRUZug8d5F/KL5rHHdyk0YuQHKevnCrvG4laIY4pqdrX4UdRc5bxrnekIuW0ex+7H0MMpyhl3w2v4b4997Mqb7jjH35sM6JONVFVpmZPIQC2tmhl+Wxj31UWSLyew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0vj8N67BISoQNb9JnmEl9lhNOssRDE36mqWhGAzhZY4=;
 b=kLHJCmJO3gnqfJRSEkhNcie01jDNQXH8Dm67HbfqKN/83/xqFwUaXZ2JgiyW4MikxJ55mcSO6QMDojZ2zVa1t+dlpGxluaFiLNQeGGeKO4/mQxA33qTfCVASKF1x1tFVRI6bkFEGY4P8uucm84AJCSuAFaQL/pifrq//ksV4VdU=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA1PR12MB999228.namprd12.prod.outlook.com
 (2603:10b6:806:4db::10) by PH0PR12MB8029.namprd12.prod.outlook.com
 (2603:10b6:510:26c::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.16; Thu, 22 Oct
 2026 07:16:13 +0000
Received: from SA1PR12MB999228.namprd12.prod.outlook.com
 ([fe80::4dba:119e:8e7c:37b3]) by SA1PR12MB999228.namprd12.prod.outlook.com
 ([fe80::4dba:119e:8e7c:37b3%6]) with mapi id 15.21.0546.012; Thu, 22 Oct 2026
 07:16:13 +0000
Message-ID: <d9304f91-2371-460b-8616-15a4f96c5674@amd.com>
Date: Thu, 22 Oct 2026 18:16:04 +1100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v6 09/11] iommufd: Add the vdevice TSM request ioctl
To: Jason Gunthorpe <jgg@nvidia.com>,
 "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
Cc: linux-coco@lists.linux.dev, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
 Jason Gunthorpe <jgg@ziepe.ca>, Bjorn Helgaas <helgaas@kernel.org>,
 Joerg Roedel <joro@8bytes.org>, Jonathan Cameron <jic23@kernel.org>,
 Kevin Tian <kevin.tian@intel.com>, Nicolin Chen <nicolinc@nvidia.com>,
 Samuel Ortiz <sameo@rivosinc.com>, Steven Price <steven.price@arm.com>,
 Suzuki K Poulose <Suzuki.Poulose@arm.com>, Will Deacon <will@kernel.org>,
 Xu Yilun <yilun.xu@linux.intel.com>,
 Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20260917140159.1163281-1-aneesh.kumar@kernel.org>
 <20260917140159.1163281-10-aneesh.kumar@kernel.org>
 <179027891417.104879.282447770434616733.b4-review@b4>
From: Alexey Kardashevskiy <aik@amd.com>
Content-Language: en-US
In-Reply-To: <179027891417.104879.282447770434616733.b4-review@b4>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SY5P282CA0040.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:206::8) To SA1PR12MB999228.namprd12.prod.outlook.com
 (2603:10b6:806:4db::10)
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR12MB999228:EE_|PH0PR12MB8029:EE_
X-MS-Office365-Filtering-Correlation-Id: dd949fba-9903-4a4d-176a-08df300c5aaf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|23010399003|56012099006|4143699003|11063799006|261021135927099003|261021121427099003|261009223027099003|10067099003|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	uuRVTLiJYsJR9LQTcMRG6UP5DVV6CGfExqqf2aYAWQXTnVdUnWZwSAnRWxNBpuDSFK+KpqS653IwD5uS51st5pwx6MpccYhJXw3TScc4LBbTeEG2x49oHAmwgCj9CDwKWnoHiaESvyzuNSavfD/dJAPsF/6XV1T3D/BRqOWYlk2y/RQmIgGABq754nGlRVnpD3vDeV932XGj90hPw8JUiC0/KuJppti3EM+NtZfq1yOryLtCl7metGZnXmAPiSCiRiLnUOovLiwI7K0OfNOYpNi3D6vswNbdGKpIBb4FEzy1zLjxzdxUouhPRmi/UlkjiAn0O2mF1dwrrrz20nxKtbAYaIL2hxrID6yu/yBAZ0tNN8LHPVapdcms89ADDWcMNZGXLcFVPAP4Bh7tFRZoPhlOgdyHUiBFCVj6U+P3sbQlOa170Cqp/f7YVC8GgAtLkNy6er/w3x/1lxkuLMd1aM55CWh6PqyxCg2ggsHVHrA2PFiPpW9G/jcFw45FMik25NEL2nlIjPiGtI2SgyZefAD7urn+a0u5urNuo/Yb3H8GCu6ZDfVP6sdPE1YM3+6ZcKNkzkymDBiQa4U3XTxDb8bNuFro7CfGKWpVszbFn8TJjW0F2v3q+cRNwfEVtfW3BP2bX8kiaVJpg+lQFtCBYg6Fzq8P6T540pkmN5PcL5s=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR12MB999228.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(23010399003)(56012099006)(4143699003)(11063799006)(261021135927099003)(261021121427099003)(261009223027099003)(10067099003)(18002099003)(22082099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ajNUbnJwSFlqZ1RzeExkbE5yU0E2VHhjUmtxRTVJM0JPRGtYV2lXUXQxTUNC?=
 =?utf-8?B?TUtHbnk5bnE0QWtrYUMraEh2dCsyc293UkZhcUk2TEx5dFNxTFkzdmU0SUgv?=
 =?utf-8?B?bHZIdkxqVUJjYlVKMGQzU2JHUG9WWGVReTB5bXN5VWNXNzM1ZW15SXRXZE1I?=
 =?utf-8?B?Sm9BY0pFUmxNeEVjbVozcTZSeDg5VFpCWEVYc1pleXZNeEN6VHNOYXhoRFQ2?=
 =?utf-8?B?SW1GeFcrQ29kZmluTm5CdGVyYUhmdFpkQWRJdlF2dkJkaDA3M3crQXJFNFRm?=
 =?utf-8?B?Z3oxVjNJQXhhbWppbjNBaGx2R3JrSlkydnVISTk4WENiVjMrdFBkVVJsd0Fi?=
 =?utf-8?B?cVF4UW10d281MjZRSHlvTWZ4aFhNWVFaTi9LaDg5SyswNTBlYjkvU3FReFpi?=
 =?utf-8?B?bXdlVjlTYTUwVUpTY014QnBRUHdrYlF4QUdFdkFMQmY4ZTJnQktBS091OXBM?=
 =?utf-8?B?MjhwWUg0ekJxMFhOWFdISnJsOU1pSGEvS05weE5KTk9xbHBkZFhUYjNiT2xK?=
 =?utf-8?B?aFJuRTFiTStQNWlzSWQ0QXF2LzFoc0FoejZBTUdobFhaNFZTS1dQbHk0c0U3?=
 =?utf-8?B?OTdkdC9yeGl0amJtVXdXQmZ1bDQ3Vk94QTN5UnlXdDJSblMvMk9XMm41SXNi?=
 =?utf-8?B?YWVYTWNDTW9NMGVLQ1RhVDh5Z2U3YWQzK2JyMkRqVTFxc20wTWlMajNETktv?=
 =?utf-8?B?em1CNUZWR3dpZmpHMjc3cCtWdnJZSjJxc3ZLRThRaWFwZkljTWR2OVY5S1VP?=
 =?utf-8?B?TTYwRkJpNTNSR3JSZE9EZXRWeHlrOFh6V1Rac3FRWUxDTDZ4MXpuNFNSQTla?=
 =?utf-8?B?NnRzMCtsQlErQWxYa3JqOE1pYVFmZ1RrZjBxemw5SmtpbEhzS2IrZmxUbkRn?=
 =?utf-8?B?S203SU14RzByYitybnROd1h6V2cyVUNYTnRmblFJK3RzeXVER2VkTWs1N2Qx?=
 =?utf-8?B?TXF5QzFOR3dYNXpvZzkrZHlOdnJ3OXoyRXNtUzJjdm8wd1hUOUxyTk5lYmlR?=
 =?utf-8?B?OEM1UnJJWE8reUEwUGcrWVBselU0dms4ekE2aC9memtaOXNPVnRBREVrWFpi?=
 =?utf-8?B?MTlBR284NzNWd0pIZ0lQNVNoeUFUYjlVYjlUOGxkRWJ3eFV4anlFMWI2a1Bt?=
 =?utf-8?B?Ym5PbmZBNHhJYjUweFBEanBvcGd1V285SjlDc2RGdWRyb0hzZUtOQjJTdWdo?=
 =?utf-8?B?L09iV0hFckRqNTJIOTNRRWUvZ3ZuaEhYTmE3UmxzT1BwejVuMnByVTlpeGt0?=
 =?utf-8?B?eHFCZHBzSG5ZcXlJQXZtV2hpajA2UzZRMDE4Yktpek4rNkkwQ1dXcGRyR0Jn?=
 =?utf-8?B?bXZYTGd2Y20ydk0xK2xjb3VRaUNBTEJkY05SUnkrUFNnMEtteWEzd0hWSFQy?=
 =?utf-8?B?N1VxaXdnakhyRFRoc0p0SlVZcFpyUG1tYjhlYmhpZTlGbUJJcHRNekVQc1dK?=
 =?utf-8?B?a21GRFltMkNWTnZQOVZFMFYzM2hEc3lZMUZNRjU5ajVsZlB3WlZqTldBRW5X?=
 =?utf-8?B?VHU5aW9PbjNPYzRSRXExSm4waGY0TW9rYnpta2dobEw4VVJtTjA4OHM0aWtM?=
 =?utf-8?B?V2lMYlpNYXE0SmE1dmtZOVZsZGlqTWVmVldnMGJKN3NxN2Q5S0pwSzFDTnlj?=
 =?utf-8?B?MTdpNWdKRVlDaHZuQ2Q3YldrenZweEVZY1dJTUVmSmZKeU1rQkpVUW1tSytX?=
 =?utf-8?B?YnA2cytsdWdhRUVYcUJjdWxTVG9YVERtZzJ0R0ZoYytaUkR1U2E1OE9pUUVE?=
 =?utf-8?B?MlNXcmdYbFJ0bVZWQWpLdFFmcHB4Y3c5T2lEUVZxT3JBNE11bDNLdWdaZ2FU?=
 =?utf-8?B?YzF6TmNuTlF4cy9vd1lUdmtwWjZnRGNqa1VtMlp5NkhrRkMzMTd6U0phUWZW?=
 =?utf-8?B?b0hFUHJHcHZSdlluejUrRUxUWXdMUWxGdlYxeGNVREJxbjBDdGJVTjY4aDRw?=
 =?utf-8?B?NGdJZHdncjdYR1lEOFB5VGpHTEtBdWdWVDdNaFFHVVFxeHZCN2VUS2JaNith?=
 =?utf-8?B?S3FFWFFzN0RGc3oxTGtLVWRDbmdibnh4bUtCT1I5Yjg1cCtZQTYwZmoxd1h5?=
 =?utf-8?B?RmRnNmdHRktKWDluRmswZDBmcFh2MTl1OEF1SFc4ZlZ0SDZVb0lSRGdVdTZ2?=
 =?utf-8?B?eEp4Y1doNlBGZnVpNlB1ZStiK21KYkJya3FHVUtqWGVXbjhXZloxa3pRZDlp?=
 =?utf-8?B?emEzKzMyNU5vemxFSXdjWThnZlNyK2s4SFVITkdtTXdMTHpZdjFMQVZ1dWJY?=
 =?utf-8?B?SGMrOU9ZM3hMYWFFY1E2eW93VlpJSkZROEdRaUp6R1hDT0pwL1BGRmZZT0Jl?=
 =?utf-8?Q?l7SGKbzhaStwZ3AabD?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd949fba-9903-4a4d-176a-08df300c5aaf
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB999228.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2026 07:16:13.1353
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GPeOPDFKINDgU9fgdNCb148HS1btYt3qjWYPUCMfplgkKNoH764O4Ff0/6uSKTeWEvvPft34INNO2zblOef1iA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8029



On 25/9/26 05:41, Jason Gunthorpe wrote:
>> [ ... 95 lines skipped ... ]
>> +static bool iommufd_vdevice_tsm_req_arch_valid(u32 tvm_arch)
>> +{
>> +	switch (tvm_arch) {
>> +	case IOMMU_VDEVICE_TSM_TVM_ARCH_CCA:
>> +	case IOMMU_VDEVICE_TSM_TVM_ARCH_SEV:
>> +	case IOMMU_VDEVICE_TSM_TVM_ARCH_TDX:
>> +		return true;
>> +	default:
>> +		return false;
>> +	}
>> +}
> 
> Generally speaking we should not do things like this, the viommu
> object should declare what it supports if we want to have validation
> on the iommufd side.
> 
>> [ ... 140 lines skipped ... ]
>> +#ifdef CONFIG_TSM
>> +/**
>> + * struct tsm_guest_req_info - parameters for a guest-initiated TSM request
>> + * @op: operation for the guest-initiated request
>> + * @tvm_arch: guest TVM architecture
>> + * @req: request data buffer filled by guest
>> + * @req_len: the size of @req filled by guest
>> + * @resp: response data buffer filled by host
>> + * @resp_len: the size of @resp buffer filled by guest
>> + */
>> +struct tsm_guest_req_info {
>> +	enum iommu_vdevice_tsm_guest_req_op op;
>> +	enum iommu_vdevice_tsm_guest_tvm_arch tvm_arch;
>> +	sockptr_t req;
>> +	size_t req_len;
>> +	sockptr_t resp;
>> +	size_t resp_len;
>> +};
> 
> Why is this struct in tsm land?
> 
> I'm not seeing why the iommufd interface should be locked to tsm, as I
> said other viommus need this kind of command channel too. Can't we
> have a general one?
> 
> Why would it ever not be tied to userspace pointers? I don't want
> an in kernel user ever using this kind of struct?


This mimics the TSM's pci_tsm_guest_req() API which it is a kernel component we did not want to hardcode to use userspace pointers as it does not have uAPI. Makes no sense in tsm_guest_req_info though.


>> [ ... 34 lines skipped ... ]
>> +/**
>> + * enum iommu_vdevice_tsm_guest_req_op - operation for guest TSM requests
>> + * @TSM_REQ_VALIDATE_MMIO: Validate MMIO for the TDI
>> + * @TSM_REQ_SET_TDI_STATE: Set TDI state
>> + * @TSM_REQ_SEV_ENABLE_DMA: Enable SEV DMA
> 
> That seems wrong.. The hypervisor should not have control over T=1
> DMA.

This is a guest request to the PSP which does control T=1, the HV is forwarding it and does some extra stuff while there. Probably could be decoupled and go to a separate ioctl().

The HV does not control DMA, it is for configuring DTE in a specific way - the domainid becomes reserved (and its sDTE counterpart starts working) and some other DTE bits have to match whatever the PSP writes to sDTE ("I" == IOTLB enable) and probably more.

And then, yeah, "something something RMP" == cut 2MB mappings if corresponding RMP is not 2MB.

Thanks,

> 
>> + * @TSM_REQ_SEV_DISABLE_DMA: Disable SEV DMA
>> + * @TSM_REQ_READ_OBJECT: Read a TSM object
>> + * @TSM_REQ_REGEN_OBJECT: Regenerate a TSM object
>> + * @TSM_REQ_OBJECT_INFO: Read TSM object information
>> + */
> 
> These operations will need alot more commentary. Use kdocs inside the
> enum below to make that easier.
> 
>> [ ... 10 lines skipped ... ]
>> +/**
>> + * struct iommu_vdevice_tsm_req - ioctl(IOMMU_VDEVICE_TSM_REQ)
>> + * @size: sizeof(struct iommu_vdevice_tsm_req)
>> + * @vdevice_id: vDevice ID the guest request is for
>> + * @op: One of enum iommu_vdevice_tsm_guest_req_op
>> + * @tvm_arch: One of enum iommu_vdevice_tsm_guest_tvm_arch
>> + * @req_len: Size in bytes of the input payload at @req_uptr
>> + * @resp_len: Size in bytes of the output buffer at @resp_uptr
>> + * @req_uptr: Userspace pointer to the guest-provided request payload
>> + * @resp_uptr: Userspace pointer to the guest response buffer
>> + * @tsm_code: TSM-specific result code returned by the TSM implementation
>> + *
>> + * Forward a TSM request to the TSM bound vDevice. This is intended for
>> + * guest TSM/TDISP message transport where the host kernel only marshals
>> + * bytes between userspace and the TSM implementation.
>> + *
>> + * The request operation is guest initiated. The TSM backend validates
>> + * @tvm_arch against its bound TVM architecture assumptions.
>> + *
>> + * The request payload is read from @req_uptr/@req_len. If a response is
>> + * expected, userspace provides @resp_uptr/@resp_len as writable storage for
>> + * response bytes returned by the TSM path.
>> + *
>> + * The ioctl is only suitable for commands and results that the host kernel
>> + * has no use, the host is only facilitating guest to TSM communication.
>> + */
>> +struct iommu_vdevice_tsm_req {
>> +	__u32 size;
>> +	__u32 vdevice_id;
>> +	__u32 op;
>> +	__u32 tvm_arch;
>> +	__u32 req_len;
>> +	__u32 resp_len;
>> +	__aligned_u64 req_uptr;
>> +	__aligned_u64 resp_uptr;
>> +	__aligned_u64 tsm_code;
> 
> out_tsm_code
> 

-- 
Alexey

