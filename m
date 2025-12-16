Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazolkn19013075.outbound.protection.outlook.com [52.103.74.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D25D5334C1D
	for <iommu@lists.linux.dev>; Tue, 16 Dec 2025 05:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.74.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765863733; cv=fail; b=FzZk4CstBdJkn0ckEVZSNSpjgLcDWoKC7G3D/I5PmMlWsuQo2m6+WjZTn54BKaAMa6HxKi0LSJPnH5SI7ObvOsZlDUWrvEL7mk23pSMoLkwusPYIUnhbF/RUuexo98TKn5vq4xwF7mgN7QCGbByvd9FyqzU6MFwT6f98noNQJZ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765863733; c=relaxed/simple;
	bh=jH8E4LyZfP64EI24egh/yeHREVtLvhB/MIh1FsplhEE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GP8fC+FSidiMe7T2mFCVTNU6NTxIWv9tOgd2SSnr0NHNZt12Ru0WaueqcqfhsJ2U439bFxframMQk5Ac1svnRGlDjP5chc+FEfMYjQY6iE9S8XlDSKfQHjr9rPIlwjYAXySg+S4ot7CGbO5aYteIqY8om14WGqvWpwFF2yb8S0I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=X87fF1HN; arc=fail smtp.client-ip=52.103.74.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="X87fF1HN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yn9IjRnOrrN68MkMaIIbjWbkWxCO4+9aJp9Qe9/t6SAe6TciiK+kK8YRbYWIToelvpBrqJDtAh627L49juXC0n/E6T7b5VMrWHtu+1k5TsV6s2fCChEQE0nftxxb6JtZwZjiwwPfcsANPEc5n7/Fal8bX+AoJDhLq2WVLM02H2U7L2iu19PQysWHWYcoll54cf5M/QENagQOIXdd+FGu1OOLLWzKvzsqPer4QZNutdt5cSCc1aEJmNIGjnYyIyhn8jGmtbX6FBYA/rsuBRcxdR6EuyXqU7PhN5wclppv4KV7VgPR59PpISQJipzNJ3SBOc2a37MxWTQZWnqp0wuHWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vAoaEzqKAsBZgABYGKbSPEas9O8H1bKKCUy4Cn3KcVM=;
 b=gUaP8jqJyLu9l5v1qrN8lw0uLuUogKiQVbXz9xtsCkDtWLqYI2FrV7JEZw+rDc2uRyKiQUgQeKKEDAvUHMQr8W1c/A7Va2ZwOsgdXgWsYZichjSf4u3RKCH9f2om1f1MFVHuTLDqdc+oQ10xuuC+0y+kwOEHb32bLEJwro9B6sihEATQ/OUNFh68XXpO5x2YJDtlmz26cS4/KFP61Mm0IOwvr6d0Q2++etp4i2aGICF9K7Tf5s0q24YFwpsPlgB8SFTFz/HTnhgDe0xhdTDS9mzMBOlVGDCEDqcmJ0KUZHwOB0EdXxE4Wh2S6QG96qHmDsPM7NmwYStdiT33QkJ+/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vAoaEzqKAsBZgABYGKbSPEas9O8H1bKKCUy4Cn3KcVM=;
 b=X87fF1HNJRWYFDo5NQr0gBAlp5ivt820JIrBsKPYC2Kwl4mp+Nsm2/ELh++/LI8FCnhHhxp7HXX2kLLgHqkHVm1xtINxloEWQ9tY626+LrTsUDhjFRSvEHuaSvpGVntjnS1tYdJTOi/cPOvLizKqLt2q7OJ9rqhAVdPi3/FFsSOgColVKZ++9n0GSE0AxuHsi+wQWCznrVbmvazB94jBr/dtpApWnI0t0kdDAAXa6WkkpxYL9HGf6JmG1iYoZRpK2T/htUolsihGhEQOuSdf0uE3J1LpLaCaF/Wr/WNUZN1wnqV8SS+wnOccMGGO2/aLh0iO5xsy1dSp0xkqXxxlWg==
Received: from SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 (2603:1096:4:1b0::7) by SEYPR01MB4101.apcprd01.prod.exchangelabs.com
 (2603:1096:101:3d::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Tue, 16 Dec
 2025 05:40:43 +0000
Received: from SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 ([fe80::5e86:f04a:37e5:64f1]) by SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 ([fe80::5e86:f04a:37e5:64f1%5]) with mapi id 15.20.9412.011; Tue, 16 Dec 2025
 05:40:43 +0000
Message-ID:
 <SI2PR01MB4393F42495CB73A47FD3744BDCAAA@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
Date: Tue, 16 Dec 2025 13:40:37 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] vfio/type1: Set IOMMU_MMIO in dma->prot for
 MMIO-backed addresses
To: "Tian, Kevin" <kevin.tian@intel.com>, Jason Gunthorpe <jgg@nvidia.com>
Cc: "alex@shazbot.org" <alex@shazbot.org>,
 "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
 "vasant.hegde@amd.com" <vasant.hegde@amd.com>,
 "suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
 "joro@8bytes.org" <joro@8bytes.org>, "aik@amd.com" <aik@amd.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>
References: <SI2PR01MB439337D5513729BAC122F526DCCDA@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
 <SI2PR01MB4393BFD04F698501F19013B4DCCDA@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
 <BN9PR11MB5276D5D7338261F48FB863188CAEA@BN9PR11MB5276.namprd11.prod.outlook.com>
 <aTu9gUxtvWsmG+WD@nvidia.com>
 <BN9PR11MB5276E6194ACDC16D1240DD438CAEA@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Language: en-US
From: Wei Wang <wei.w.wang@hotmail.com>
In-Reply-To: <BN9PR11MB5276E6194ACDC16D1240DD438CAEA@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TP0P295CA0008.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:2::20) To SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 (2603:1096:4:1b0::7)
X-Microsoft-Original-Message-ID:
 <770f6997-45b5-4414-97e0-c93d8be07259@hotmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR01MB4393:EE_|SEYPR01MB4101:EE_
X-MS-Office365-Filtering-Correlation-Id: b2a30f6e-637b-45b8-68c1-08de3c65a710
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|36102599003|5072599009|6090799003|461199028|51005399006|19110799012|12121999013|23021999003|8060799015|15080799012|3412199025|440099028|40105399003|13041999003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UldBam1KdjVMWEJOT3Rub1A5T2ZIcGxWSlZNMFp6R21mSE1IMm5kaHZDcUNB?=
 =?utf-8?B?TEw1Nkk4dmxybzZqc24xOUVnRWJhNHVpemZKcENjZ05TTURWckhXMERPbFBH?=
 =?utf-8?B?d3k3N01OKzVGK1NYMnFDb05oZEx6MUNHTEJBVEpyTGdIUW15OTNmZDlZUm5z?=
 =?utf-8?B?N1ZLZmlJamFkaENFVVZ5c2hqMldQczBKMlNPdnVzcHRzR2xWZENXMSsxTDgy?=
 =?utf-8?B?bXdaUTY2YVpzY3ZMdWZvZzNaRm9xblpBaVBYZmliTUVXTTdueU55Wi9NeVF2?=
 =?utf-8?B?ZHEvWVJTbXJlZUdyVDNtUlJnZEhNWWxpVEVQRi93Qm1nWjNva291TzJGYjNk?=
 =?utf-8?B?cGdOK3V2dG80amdOcGpHTzdzVWFwL3BqS1ZqRHFqdkt5eU9DSVVOcG5GdlJ1?=
 =?utf-8?B?VGlZN21pZ0FhSFZrQ2FtTUdjK1RSOWd1UjJLZERtMUw4SzhZeldnWEZ0MlNx?=
 =?utf-8?B?SjhYWXVkeC9RU0dld3FwVXJVNkR1U0RGdWx2V1djZTJjWjNGSitjUllMamw1?=
 =?utf-8?B?TitGdHViZUs4elZjWlhSTjY1QU16YVQwcGlwQ1RSVlk2djhLQllmU3dmM2Jr?=
 =?utf-8?B?YytvRFI0YWlqT3JvSGZnZFgrbkpqVi9KbjRVYkVPNDJYekdOcGNmN2FoaE9D?=
 =?utf-8?B?OVZRWVNzd0MzSi9MVndnY2FOdGhoZmZWTzVEUmZrTXRFVENtRWdaY05ndGNw?=
 =?utf-8?B?Wk1MMlRRMTNuUFY1bysxR0pURWtXU0dOM1JTUm95OUxJZGxSZ1psOTZ4SWtq?=
 =?utf-8?B?SjgxTU9xK2Uwc1hobjlLRDlJdS8zKzAzOFpLeUVBN1dHbTBzM2x1UnpZUTZ2?=
 =?utf-8?B?WTI2UEdVNkFVZEtwTUV6Y2tRaklNdkxUTzVKWjN6Yk04bDI5SXVYaFBqTzVI?=
 =?utf-8?B?VEtqdXNNYUtDbDNoUHg0WE02bzVDMXNKTFdFSVR6cklCazFhRzQ5TTllWEtu?=
 =?utf-8?B?SmJscHg4cEFNYTQzVWxtZng1cUhPeHFhNklkVituUE8wcGRPTVRCY1BXdUpX?=
 =?utf-8?B?TFRRVUVwaVhuZ2pEeHZzQk0wMmdCZFVDano0TVpzNHF3dmlkQVZwbUtQdmwx?=
 =?utf-8?B?ZWFNUG9IZkxkVVhSSEtJTE91WjMycXRiY1BCeVdXeGtMTzR0U3RuN3RJSmJa?=
 =?utf-8?B?OWRWOEsvVk5acHU5WFA0UjJXUmdHbWZ5YzRlcHdBV1RKcXNtWVlYQ0tXdHhS?=
 =?utf-8?B?QmFoa2tKYm1wV051TEdueTdTWDMzVis0Z3JhZlJkTkJyaFo3MlRONHFBNHND?=
 =?utf-8?B?ZkN4UXNlQm5tMFVRMjd5ZE9sRVBVVS9yM0VNUUJsb0NGRDNLT05XWFd2ZDVY?=
 =?utf-8?B?b3k2NExVWUxKRk1xZnVWcW05MUN6dW16Tm9ESDlCRjB0YjZ4WFNPUVRNYUtu?=
 =?utf-8?B?NG43WCtrQTc3ODJQRjJuZ0xzOFBBQTJuZ1FLcys4NmFhb05GMWJCRWljN0RC?=
 =?utf-8?B?UE9oTndtQ1g4dSsySG4raXJwU2RQdG1iOGtneUhmenI2WnE4cW1CdDN4OUVK?=
 =?utf-8?B?QVRZTWxsUm9wcWlwWXc3WkxTdEVTYThLd2ZQQkd2Z0dWVWdzQlRXcFRRNFAw?=
 =?utf-8?B?OWZhNUF4Zk9qamtvaU16UFdHeWtQNHhXOHpCK2dERmpDMVRXN3cxU1NBSzFM?=
 =?utf-8?B?aE5YWjdaKzhyVzdBcXhsZXJFMkV5SWdKQUN5bm5DaUxWZHVxVHZBb3B1ekJH?=
 =?utf-8?B?UWNHaFpzalVnMkxPVnFqamhYc3JERVA3VkZ4UlFHM1NNQ2JBRzdGNTBUbGJH?=
 =?utf-8?Q?xMOoxPfzAX7FsZI5QY=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dVJpcUtwVmhlOGl4Rm1yWmdtWEZPT1JreFdpZlVIU2NUZnhrSG0wdm1nRnE1?=
 =?utf-8?B?V1d4RUZubG1wTG44NVNDUzUwckgvaWowZlBGUWQweFo5eXIxU1FyTm9QdVI4?=
 =?utf-8?B?eWJ0U0dJUkR0bXdpU1J4SDc4VU9jYm5kdWY4bzEzNTN4WmN6T3JITm52U0t0?=
 =?utf-8?B?b3FaRjhPbFE3aDB6UlhzZk1MVGdCdHpWdDc4NEhidDZaSHJnY1VUL2k2OXpE?=
 =?utf-8?B?a1g4RmhEMVd5SFNHS1AyMVBDUisvYmR2d01acUxTc1FNbXNpWmRHb3R6bEIw?=
 =?utf-8?B?eEo3L05iYTFrQzBwZFlSb215Q3FOQzR4eERzeUxVNFQwOFlnVjRsbk9JTnIw?=
 =?utf-8?B?UGhEckRpV0VhcVR4RTIwdGl3T0ZsNTl5c3V1OUNXeEs5Q3Q2WlF1UDVDVHNO?=
 =?utf-8?B?dk1OY0NZamhsd2ZKQkoxYkpoaFg5M1lxOG44SHI0WUt4TW9KeGNDa0EvSG5Q?=
 =?utf-8?B?NEw1cTd6SytIdFBGaHM5NWgzdWRqU3hhSmQweEJLa2srUXpaaUxKRWx6NERM?=
 =?utf-8?B?Qkd0YlRNYlhxTURFN2lnV0V0ZGtiSzc5ZXZka20zN1pZR3lVVXpSU2dodEpi?=
 =?utf-8?B?SU96Qk5SYlNPL2VqWXc4bjNveWQ1Y0ZWc2wwNEZNVGQ0NDRUZWZWZnR4RGNy?=
 =?utf-8?B?ay9EMktvczFFTHZJblhXYU8vYzl5bVV0RDY4dnlQTkVXb1dzaHd4V1pqMlVG?=
 =?utf-8?B?NDJ2VDRkbE9zQkNQOEJHVFZZMVptTjVRU1BiTTB6U1dHSUJBOWJiSklGbGU4?=
 =?utf-8?B?UXZ1amRkdGJqeGFPODN6VHkxTjdXK0h4Uy9vYllJcmZINTc3UkRZZTRYRzg4?=
 =?utf-8?B?VG4vWHY4ODRYSWd3UE1kSmV0YVRMMHVHQ1dDNFFXMVJBT24zZ0tpNFZnc01X?=
 =?utf-8?B?RnIxRTRNcUozcEY4cEltT0VYYzVRQWFjamc2NWJPd056OXRCSEUwa1BuZElo?=
 =?utf-8?B?NnljUU5rWUY0NkV0RTlrekk5STJmV2xhaFphZlcwY2I1ZU5zR0g2NHpsNE5v?=
 =?utf-8?B?VE1EdnZlVE5FTkFadzEwWEM5aTVGSkFmaHYzS2U4UXdYUks1Rnl2SHFIbDVV?=
 =?utf-8?B?TmUycHRzaUErQmRmWUdBcjFrRGZpYnpTOWU3Y3JNeGxNT0xjM2pkVGg4eHFt?=
 =?utf-8?B?L09yYlNZZU8zNW85K2EzS1JsdDk4UHlTWWM2bExSZXJRRmlHQ2tTRHF5b2cz?=
 =?utf-8?B?b1BadVhYWFVXYWVXNVJQUmhDb09COHRGSmJxelFyaTU1N2RSeTJHakFobHly?=
 =?utf-8?B?VFBCNGEyMDBoRDlXb2VQWjNvMXE0ak4yZHJHZCtjTmlJR0F1ZkVwQTVCWWF1?=
 =?utf-8?B?RllPZXliMHoxMmtObjZTTGcvMW9kM0R6bHNybWRJVzFMRSs2NXdjUytpTGxm?=
 =?utf-8?B?cUlPUGF0NVE5Z2R3bGl0aGtBTkZtRUxQazF0NGVyY2RoQzZsbEZZTDhlazZa?=
 =?utf-8?B?M2MyYVd4eE9qQkxyTXJnYUpnNEdQbVY0ZWlxM1h6YTFMRytzSjEwamV4ZGxv?=
 =?utf-8?B?c2p3Zk00eC9GZy9RMEd0SVZqQUd0QVVCTWdFWFhVcTc0U21GQmxJWS9DL2l1?=
 =?utf-8?B?NzM4aUJUaTNtK0ovQnFCTmQ1YXdXMWxSaU1kQWVZSmU2bzlUcnVIMVorMTQw?=
 =?utf-8?B?VzloemZUZ2I4UTB4Qis3V1lsVFRxNnZ4bzU5aDBaaUVkS1k3cUhhL2hOd1lo?=
 =?utf-8?Q?duQpXXxOio0gn843Goyv?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-5f51e.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: b2a30f6e-637b-45b8-68c1-08de3c65a710
X-MS-Exchange-CrossTenant-AuthSource: SI2PR01MB4393.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2025 05:40:43.1679
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR01MB4101

On 12/12/25 3:26 PM, Tian, Kevin wrote:
>> From: Jason Gunthorpe <jgg@nvidia.com>
>> Sent: Friday, December 12, 2025 3:00 PM
>>
>> On Fri, Dec 12, 2025 at 02:36:46AM +0000, Tian, Kevin wrote:
>>>> From: Wei Wang <wei.w.wang@hotmail.com>
>>>> Sent: Thursday, November 13, 2025 11:54 PM
>>>>
>>>> @@ -629,6 +630,8 @@ static long vaddr_get_pfns(struct mm_struct *mm,
>>>> unsigned long vaddr,
>>>>   				ret = -EFAULT;
>>>>   			}
>>>>   		}
>>>> +		if (vma->vm_flags & VM_IO)
>>>> +			*prot |= IOMMU_MMIO;
>>>
>>> move into "if (is_invalid_reserved_pfn(*pfn)) {}". it's pointless to set
>>> it in the error path.

Yeah, that looks better, thanks.

>>>
>>> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
>>>
>>> btw another alternative is letting userspace set a map flag explicitly
>>> e.g. introducing a new VFIO_DMA_MAP_FLAG_MMIO flag bit. It's
>>> not considered because your use case requires existing VMMs to
>>> work?
>>
>> I don't think we should do that, userspace shouldn't be able to create
>> a mapping inconsistent with the rest of the kernel for security
>> reasons.
> 
> ah that's a good point!
> 
>>
>> I think if we ever need a cachable mmio through to the iommu then it
>> should be wired through the dmabuf mechanism the same way vfio drivers
>> wire the cachability when they make the mmap.
>>
>> The nvgrace is the only driver that creates a cachable mmap already,
>> and it would be more correct to have a cachable IOPTE, but the only HW
>> tha driver works with does not care either way so it has been left.
>>
>> Jason
> 

