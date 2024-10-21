Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2060.outbound.protection.outlook.com [40.107.93.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7712195980
	for <iommu@lists.linux.dev>; Mon, 21 Oct 2024 09:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729501722; cv=fail; b=bM3t/eNa8AU6Mf0mXuLwFl5dcmCo+aqW7s14HljiWpkoyLbQ+RnRZA2+RcIXqAzJ8/k4cYHoErmic5dynoeV5ZYg4HPOgEk8jnhwGK064DP0ejBF3LFd0jr5gZzxX8dryoNz0kc+SpzarbWIYwiNrsMks64+kw6hUGkbl9Ld4Rw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729501722; c=relaxed/simple;
	bh=CMPfdzW0rKhTC+JB/KPpuhJLuIyfLppN3y4Nj9FPdUk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qUCVUNJSyVtr2fYEdrs5S4VwwVci6Ft5cxoXkvhao3dERwLxh6HEzGJ3lPQt94Ue+7inR4Uv0AuRcEU661IaFYADI0mFIazYOjS/WCokfzD1ez25QAeoMte5SB/fScwfmOWxnlNvKDrN3F/hbHc+9OL5FGhFWJzFe2STSvoPbds=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=g8sFt5z3; arc=fail smtp.client-ip=40.107.93.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="g8sFt5z3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CpO0WXBRFgKN9icZTQIMYhkokF/CsO3LbO3PiiTlgIFrKC580Dpr/JTBZWpM/AAui+Pp10iVR+1XsPciJKHUrEZXH8US6Wcklt3AfnYABIqKYML10bC6V0XAzi8ZbISsgcG83IdhIKLgQHnOigS4n4zEQ6EoYZ38637ENjLgZtJiB8NlWNXvmOQjRUqnaIyWxKhnZDYTIgdcZdTFGpZBGPHLcII9rCy99wjZldeuCClp1D+fiSHyfdw4xYaVLml2RTw+SyxFbbOHsQokUDX7eUrUyqDTNhUSHeB3iYbgBgFO4hwV52hc5FaA9wSFxrryudVcijK2LieYbvmT+d8Ocw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XyMO4pbHlh9RCbMCqb5JSMN44EazPqL9/2ke4RKY+58=;
 b=b2zbI+gmsTRrliNrSWScxlhljx7lnAgOcIB6ZhBWOnJfvCAgbMQV6ML97bI93h4vqsQWwisNnTLgT+TBUpHB9dSsifr3YbtGq0olenZondYWfGCgljGXiZYM4IRZ1S0muta1qek8ho2bOB4VxHEQir6WmkPSEC32SqhEYmSIMT2NViiZb/bGyHOkqQRqKOTxcEz9jD6XTb5fyBJLCRuHC22tLzWWXp+pxcHJic+mLVPKqsLX63ldmVnFNyWQE//6oeeFwkA0/Lc+veN5pdZ5b/ypN2qPn2nmobyP/EUoeG9KPadvMUWDP4Jh4dSP8DVPPz8OcRl23E3DSkRWBup4QQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XyMO4pbHlh9RCbMCqb5JSMN44EazPqL9/2ke4RKY+58=;
 b=g8sFt5z3HxtpmyjetYWt9NdDddT2ZQwElV/u4xYN3dUoIkDdcNIJpFOLzEJGAosiep9mqEZZYIvPnesvCQQ5OU7TE/cNkEU6HYLa2h8O/g+v14dSUMYDRuvFht+K1bYf5T6HMV4ZVYO/bFMvFefMRtfEgus/aLJ9lESHrAeackY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 CYYPR12MB8922.namprd12.prod.outlook.com (2603:10b6:930:b8::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8069.28; Mon, 21 Oct 2024 09:08:38 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5%4]) with mapi id 15.20.8069.027; Mon, 21 Oct 2024
 09:08:38 +0000
Message-ID: <47b5397e-d706-4c72-b849-a91f6ef1f569@amd.com>
Date: Mon, 21 Oct 2024 14:38:30 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/12] iommu: Domain allocation enhancements
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: iommu@lists.linux.dev, joro@8bytes.org, will@kernel.org,
 robin.murphy@arm.com, suravee.suthikulpanit@amd.com, yi.l.liu@intel.com,
 baolu.lu@linux.intel.com, kevin.tian@intel.com, jacob.pan@linux.microsoft.com
References: <20241017140137.6028-1-vasant.hegde@amd.com>
 <20241018125005.GF948948@ziepe.ca>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20241018125005.GF948948@ziepe.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0173.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:de::17) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|CYYPR12MB8922:EE_
X-MS-Office365-Filtering-Correlation-Id: b749a481-adaf-40f6-12f9-08dcf1aff329
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QXQwaEdYUlpXSnA2bENGSlNrbzl0SUltTzRhekRDTTMrZVhROVhhcy9pdzkv?=
 =?utf-8?B?NVhyRDNJbVdXUDFvVnZhVE9qOWVnaFNTUklhNzN3VzBkVmNacjNsMHhLUmV2?=
 =?utf-8?B?WkpXSFJkRTlTa0EzVHBTR0RVTjA1SHBYNlU5ZXNFMUlVQzVnS1F6TCsreE8r?=
 =?utf-8?B?K3cvRVJPNjJTaDV1a05HbmFIQytwbDJsZFRINWdMaEIrTWZDNTY1V3h3V1VQ?=
 =?utf-8?B?c29IMURwb01RQndNa2I4d3diV3Zad3p1aG5ERHp5K1FXazBjS3NSK05MWE9J?=
 =?utf-8?B?ZDBQQlVobThHZXF6N3JvT0tubnU1ZHNueHZ6TUdRUTRnbTRyNnNDWGVsbzEz?=
 =?utf-8?B?OTh6VnhVTWdCRG50OUJqUTJvS1A1Y2xZSEJORGdFWjIvdUhyaE1kcXlPT0VV?=
 =?utf-8?B?clVYMytIOExjQldyTGh5M2Y5RWQ2WFVlN2JXVFZFN0RYeThVTDBiUnZWQnpY?=
 =?utf-8?B?ZEZOQ3dYNXRVSkJDajU3bSt3ZTdUOFp6QTdBQ3cxbWVhSnF6MlArUXBRRmNv?=
 =?utf-8?B?citBNmwzODh2STRwV0syWW5IN09ZTFdmd1Q1eCtHRUFTMDM0aUtXV1dLR0Rw?=
 =?utf-8?B?OHZUWTI5cDFIZTd1MkovUk1HaGdLdjV6bVdNL0hYcCtyb1lmZ0hURm11VTdm?=
 =?utf-8?B?amJpMVZGWlpPRGg3aHdkOXlLa3lWVmRrWUprUGpFTUVRV0tIelVKQ3AxMmtG?=
 =?utf-8?B?NjEzZ2Q1ckpRMlBlakJYTmVBS0RoRE9xM1ZGVC9aK2hpQTM1WUVxRjRDRmxu?=
 =?utf-8?B?anJSaEFmQlZ5SnVtS1RSMHdtbW9ocGh4UkNJSGFOWEp1OXNUVzNHZGFnc2Ir?=
 =?utf-8?B?cGlPTXY1L0JMekpiaDYyazhBNm82NEhLSXkzTEt3S28ydyt4QlFLSXduTnlC?=
 =?utf-8?B?dnhnOWt1SEFYWlVTRnhTRStBYmJoUjM1Wmc3Y3Rpc0JiMXNUeVpQYW5Pd3Vs?=
 =?utf-8?B?OTVmVUpRWnBMRWNPTWxEc040bFdoOENyb2lnU0tYSUFrcFhTTno4dTZZdC9m?=
 =?utf-8?B?dG9oRW81VVpXMWVmeVVCK0d1WDRQMU94dEprMk9hWFU1alk4VFlldTV4Y2I3?=
 =?utf-8?B?bE5rdkZXMnNDdDNIYzI5VzF4WGk0WmJQejBpNWhXQXFHaUo0LzNYcFBudE93?=
 =?utf-8?B?N09WbXRERFFRek5xRGdJYTJsN1YvdWduV3FhbU16Y2ptWnlBa3V3M04wOXJH?=
 =?utf-8?B?UHpnZmFCZTdaRXZnYXJ4Mk13cFZITDhaUW45YjdiWjBRY3I2S3p0SmVxR0Nk?=
 =?utf-8?B?Z1BDSE5SZktVT1N6MnV2TEFRZjlQZnpFM2E0NmF0RkNsYVI2RnRNWlA0TGts?=
 =?utf-8?B?RFF5Uld2ejNMSThZU0o3bDMyTjZ4TzNteUVYbVJTSW03SnZwZld2L0hQZ0Fs?=
 =?utf-8?B?SDBLYUI4bHdDZ2U4YTdoQ2J1RHAxWERzNEpkNFRmQ0tYRkRFcHJRbDRodjN2?=
 =?utf-8?B?eko3NGdob2pPL2pidFd0TGUxK0tHY09UeTUxcG5hSHhLSGJrRlZEc3Yzb1Er?=
 =?utf-8?B?cEVXTndxN1lpaTE4OTBqc0czeHJJampqNEF3Rk0zMVpaQmoyQTlkTWM5dEdV?=
 =?utf-8?B?WGlZb2Z3cUYxdTZ3eThVVEFiRlcwbUNRREVnTHZWSlY3d2ZkZFdzcHVtVGFp?=
 =?utf-8?B?SVZYWi9CaGFQaVBpMC9FT3JScWNWSEpvWUJwV2EwSGVqaGFqbnIxQ25icmw1?=
 =?utf-8?B?MmVwWk5uVW16eWdSdXJLbWg3YVZwaEZyU0J4M0NRenMyM0JoM0I3Mk1kcm5N?=
 =?utf-8?Q?76+hKa2YsDgQvkvLPH3kEOyhJf+zpufl/j9gFUS?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a0JHYS9HZC91SG1ua09qT1l2ejhWd2JUVmZSZW92blE5OTY2WnpldFdPYzRC?=
 =?utf-8?B?VGhTYTNpU1Y5V2xGU1dtOWM5T1YzYklaYjZmQUJVZFVjNEFwak9UeDJnRHZ1?=
 =?utf-8?B?d3FPV3F1TzU4ZXhHUTVsOWdYeTEyMlNqbUdqd2FmR0ZIWHJPak5ZZXFCWVBu?=
 =?utf-8?B?NXZzRHpIWDVWcUJhWG1HQzlLeVBneFFDMTM4VlNiNFA5Q3Q4K1U0R2ZoTlMv?=
 =?utf-8?B?SFFlZHFuZkEyMXkzcDBoR044b3ZJUEl0RG5oOVNvVnJyL3dpTHNkaFkvamRx?=
 =?utf-8?B?eWgrNWIwbnd0U3FRU3VXMUFwVGdZdUxxMmkyQm1SM1VPcEliNjJaVU9xS241?=
 =?utf-8?B?a2FTN1BGZ1FtR3dFQ2owYURtMzBGNzRocGc0elRWSVNVQ0t6cHZyd0s0bUdH?=
 =?utf-8?B?SVdJb1ozeWhmUzQvUDJST2FEUFVEUE5saFhwblJCV29qT3NWTmNqb0lQVHFu?=
 =?utf-8?B?U0RGVWFFOXlHOHljOVJNRnE5UEk0aEc5bksxQUI1YmdGVE5wUVBZaEZ3SUZP?=
 =?utf-8?B?a0FzZlRVQ1VOL2xQSjAxUzg5ZldvcjBCWXRvbmRJRHpGMWpoSzFLWEJmUG5j?=
 =?utf-8?B?bTEwSkZHWFBmRVdpb0M0QWovQ3JZV3FBSUhmdXRnbWs1cGV1U21tYXdTeWM3?=
 =?utf-8?B?cCtoVENmY2xqb200ekxSTmd2Y0tLZE1QOERKenQ1OU1tcjFNZE55TnJnMTZ2?=
 =?utf-8?B?amQwSFl6a1JvcmVrZWx3NnB3cHpETVBjTU9oM2ptZ01weDdhNmNyNXM1cDMx?=
 =?utf-8?B?Ly9XMlFVUmJHcCtlY3U5WUV0Wk1zVVVwTk1IRzBWYTV2TTkzQnlyVFp5Zm81?=
 =?utf-8?B?UFdiSGdKOWxuZTFPS2lMNEJmWkxQVkppOUd2MGMyeGZmUWxMYityek02R1Vk?=
 =?utf-8?B?WWpuYXVpcFRsN0pMWFlzRC9tTjg2UmdtVFY5QVV5UWx2TTdrM0hqOEgwSHVE?=
 =?utf-8?B?Ulk5ckgzaGFUQkVyWnFjR0xUMUJzcExyUmZ3UklidXN1OTFyT1NiWXVFSlpp?=
 =?utf-8?B?N2ZKSXV6RGx0VTUvTXVHb05GSEkxS21EcXJsNUlraUU0UVZHeThwcUNKckJP?=
 =?utf-8?B?MnErcEhzZVdHcTNsemk4NXZBSXZPeXRiSHB5RDVabnJxKzZDMkZmaTZOYXJP?=
 =?utf-8?B?RmFFQXlQYmRja3ltUnRSMy85dERxSjA3NnpNdGVLS3poRHp5SGUyNmtNZ1Vm?=
 =?utf-8?B?TWh4Z200dGhJQ3dyQVIvVlR6b3dzMU0yT2t0RC9pU1dyTThIT2FKSDJ1S0Rv?=
 =?utf-8?B?WkplYXRqK2w2clprL2FNb00rK2I4RVZSeGNIV3p0TTR0bVRBT0M0aW8yZjhZ?=
 =?utf-8?B?MC9mbDNYQlROOFd4YWR2SFBlZVFQSWx4L2Y2R3JLb0VtSW1KUlZhbVR2d2lR?=
 =?utf-8?B?TlpKTkxQMGZ6ZFVvdWhiVmpsNU5hWFkrNTl3ajFjVGc4V0xDaWFKbE14cFEw?=
 =?utf-8?B?SW10YTZxTjdlTGRKZHYzcXo5YnpZczlSVU5BQ2Z6VW9LTlpnTEtZdXZNaUpL?=
 =?utf-8?B?bVhpRE4zdFVoWjQzWnArTmJ2aHY3V3lTdVg4WG1UQXlRQWhaRzZNWVpadkxX?=
 =?utf-8?B?dHo5WTA2aGlJQ3FWOGZ0N051d2p1UEo5ZjFlYzZQOHMydmdYbVp0ZXdiK0JD?=
 =?utf-8?B?UHJYWTZ6OUthRmprWDhnS2lvRk1hUjM5bjFBTi8vVDBjNzFlN00wSXBvdzFp?=
 =?utf-8?B?Y1Z6eXdjOVBvUnRpNmxlUGpBZFhIcWRIcTMxMHQ5OGtJb0kvNGluVElja2VP?=
 =?utf-8?B?enpIck5zSHNjUGViUmJCYndzUWR6TkJpR2ZmZGYxN3dIazdxYTVvNlVDSnN5?=
 =?utf-8?B?YmhmWWV4T1NHUmVrbjkxK3pzSHRjRzBDMTJxUUJLN0orbWVFQTNSVDVQeEFz?=
 =?utf-8?B?N2xZSEk2S2FTdGNEbmN3ZTVZTmtsVGMvR0ViVEE4WEJpN0hBZEZJdWlmMVhO?=
 =?utf-8?B?OG1xNHNmZEJpTDJMaVRyWTJyeFdBdm5vQ0xyVWU5S3VOMVloQm5abzV2cUlp?=
 =?utf-8?B?bytEaVpCRllQc04wcDV2Z0xNNDZzLzJETzNaVVo5endibjZmL05LeG5BRzVE?=
 =?utf-8?B?NEVURFVReXJBWFRiR1NWU1BwbVJxQWM5L3FpREdPYzRTbE85elQ1VEtXTDZL?=
 =?utf-8?Q?Dr80rkPRMbH3sru08Tgcza0RZ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b749a481-adaf-40f6-12f9-08dcf1aff329
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2024 09:08:38.4477
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nsimNJ18flHhAZYJxb7kyK6HyZcPKsP32NnSvfe6oBZYPCt3qlBuW+LpJ+2PdehhyZZKLkfcGgo8EqHQ6pEwlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8922

Jason,


On 10/18/2024 6:20 PM, Jason Gunthorpe wrote:
> On Thu, Oct 17, 2024 at 02:01:25PM +0000, Vasant Hegde wrote:
>> This series adds iommu_paging_domain_alloc_flags() which takes flags to
>> pass additional details for domain allocation (like domain with PASID
>> support). Also adjusts core code to handler variuos domain allocations.
>>
>> Also updates AMD IOMMU driver domain allocation code. With this by
>> default it will allocate domain with V2 page table for PASID capable
>> device and v1 page table for rest of the devices.
>>
>>
>> TODO:
>> @Jason, @Kevin, @Baolu,
>>   With this series if driver implements domain_alloc_user() then we assume
>>   IOMMU always supports PASID. If IOMMU doesn't support PASID (ex: AMD driver
>>   not supporting V2 page table) and device is PASID capable, then driver will
>>   return error. Device probe will fail.
> 
> We shouldn't fail device probe just because someone plugs in a device
> with a PCI PASID capability into an old CPU..
>  
>>   I think if driver return error, core layer should retry without
>>   IOMMU_HWPT_ALLOC_PASID flag. 
> 
> But this makes sense, and it solves the other problem where if the
> driver doesn't know how to support IOMMU_HWPT_ALLOC_PASID it will also
> fail. Retrying with 0 flags is correct there too.
> 
>>   Other option is indivisual driver in error path
>>   of domain_alloc_user allocating non-PASID capable domain.
> 
> This would turn IOMMU_HWPT_ALLOC_PASID into a hint, where you might
> not get back a PASID capable domain type. That seems like a slightly
> worse direction
> 
>>   I prefer first option. Just wanted to discuss before implementing. Any preferred
>>   option here? OR any other better way to solve this?
> 
> I think you should fail in the driver with EOPNOTSUPP and then the
> core code allocating a DMA domain should detect EOPNOTSUPP and try
> again with a 0 flags. Is that what you mean by first option?

Yep! this is what I meant. Let me fix the code.

> 
>> Note :
>>   vt-d specific changes is handled in separate series [1].
>>
>> [1] https://lore.kernel.org/linux-iommu/20241011042722.73930-8-baolu.lu@linux.intel.com/
>>
>> @Baolu,
>>   Do you want me to include above patch in this series so that it doesn't break intel driver?
> 
> I think trying to avoid inter-dependencies right now is a good idea,
> so keep the order where 0 flags calls domain_alloc() first and intel
> domain_alloc_user() will always fail with EOPNOTSUPP.
> 
> We can sort this out next cycle when more stuff is merged

Sure. I was worried about breaking intel driver! Hence I had asked this.
With above changes hopefully it doesn't break things for intel driver.

-Vasant
