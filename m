Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2080.outbound.protection.outlook.com [40.107.93.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AEB41DA317
	for <iommu@lists.linux.dev>; Wed,  3 Jul 2024 05:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719985341; cv=fail; b=Y8H036HOr0hzYH8wrWDNIDHY4tl1mpjIAjXbOXTPK9QTj32pgTCHNAjxlKHZj29tASmqVTcpPOL37KBFOxuGjYRCDNrHZ9zph1/v3Enle0gTem4YI4ddS+b/wtXcMU30MY8FmECXxtKv06oq70EQmaL+p1fHtoEiEY7eRz29lA0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719985341; c=relaxed/simple;
	bh=E3LUwoedYq/sPMHVEuyETmGRorTfCvUrJ3elPdOiO0Y=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=sDDPzuLzkVoqT7j7XRrdfCUwTIdSNCsO2zJo0PctAyKmgCkyOIF4fehaKpktbIz/D+lA+G8loSiofM4LTiWxeInT5mMTeFG4uiRki6DLVt0Sjm0ATthUWDHu1r29hv0qYpqQfMFAJ8szfk7hmdyE3ZQhruDE/RdB34GZfJ9vKrc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=iCuAql78; arc=fail smtp.client-ip=40.107.93.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="iCuAql78"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HygDYNUfaXe4Y8C3VOQapxXpxNxcNJo52N+iVT4eg+bBs0VG07FY9v3u1VmQZCU37B66kQfcG9dCG2f920PjU1jUf2cQullm7Vc85RLFi+tJVZunhBNs0xdN3QAsMQye0NsSiyVty45xGBUgqJeBMwhRHJw3lyBTVLSz1wPUnGTXIElebJfxSgKFHgYG/gZ4x3apPwGqYXMur5LJyHcJQT75BkfRXro/OeZDV6SpzOX0dYHcIxOPU8v28r7BiFG8FeVCvowV+b+YNBT+d6PqkyHrLqYpIlgwgJ5eSL41NkNumpJTEd/KsQqimcTCIDO5aMVJ7IrOmdmhyGVtqJfdMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aLrzLkQvcHb7od6caIpRTB8XVC48y6RsRRckkdZcxUA=;
 b=Ld4O0AufKa+WEiT9Ifqny3Tug6IXytJflG76y2UVC1L3BF/LjghGvjvcUkqty9ouvpiAVHqq/jzUSkguOsYvK1bYkVUdNY8R9sv0LCsdYUdkOHdfxiEDoHt2zkhvKhcrW3h54FhMbm06hPKmmAq0uUhn7gvBNr0LpqJ0Vx7NPfnkCKMN9qZy45XdqS+nDlaOoM8QlAF11rm27tSOQvw+ILVXg2zCP0T9osN4DEI8Vk8d0+z3Wot9ib0dfrrg65rqOggP1/WIis9Znq43nusityu5vP7nvlh5aQiTk7Z1MhYaBLAJZ5sjR98KTPq134RpPJrUzVkWfEm17ABLpAzS2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aLrzLkQvcHb7od6caIpRTB8XVC48y6RsRRckkdZcxUA=;
 b=iCuAql78vlHaaGMybAchmIUl0OElX468S7PdGLgOS+TT9tBsLTXAUvUWZT6KBbDoPMUQCxX5SFjt4898YfJs6oyrv3SB6PJ1cnEwAFpEqxoaT3OKbF7doxNj9VTrlgvRga13EbqjCGH8eT0bme8UuuBmftgDaP6aK7x9kblCX/0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 SN7PR12MB7883.namprd12.prod.outlook.com (2603:10b6:806:32b::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7719.33; Wed, 3 Jul 2024 05:42:17 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5%7]) with mapi id 15.20.7719.029; Wed, 3 Jul 2024
 05:42:17 +0000
Message-ID: <68d300af-4d3d-497e-9338-d99dbf88dd21@amd.com>
Date: Wed, 3 Jul 2024 11:12:08 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] iommu_ops->domain_alloc_paging() enhancement to support AMD
 IOMMU driver
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Joerg Roedel <joro@8bytes.org>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Baolu Lu <baolu.lu@linux.intel.com>
References: <7e249bc6-c578-40f0-aca7-835149a0ad39@amd.com>
 <20240628130330.GY791043@ziepe.ca>
 <26524622-971f-47f5-936e-d0173d342288@amd.com> <Zn77FbsQWmByf16t@ziepe.ca>
 <1f8f04e5-3b70-45de-bd93-e3c96fb0a555@amd.com> <ZoLmyOzOVYGLKjmn@ziepe.ca>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <ZoLmyOzOVYGLKjmn@ziepe.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0018.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::7) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|SN7PR12MB7883:EE_
X-MS-Office365-Filtering-Correlation-Id: dfc6cee1-1439-4e67-269f-08dc9b22e5cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NDg3bFZTUmp0cWgzTGN0c0FxTHBmZy81eDJocW5PSitNSWk5bXRsVkRrN0lW?=
 =?utf-8?B?MjhGQ3FGRkRQb05UTk9ZbVBKbGZTWEV3NFIwWXhSMU5wOC9uZUIwdXpNMGhU?=
 =?utf-8?B?bXVrZW9vRzBJNmMzdFM2RWJZblAyOFZ2NWNvcVdnMEIyUDJFc0R2ME1EQVdr?=
 =?utf-8?B?cVo3dGcyUlNyUndaTkJvZkFLYVY4OXdaR3A1aHRhZjFRbEhLUlFEM05qeURP?=
 =?utf-8?B?WlZOWDBKcVBkc3k4OFh6Sy9FVUZ4YTZ1dTUzbFFnaXhhTW1oeWo3dFRJbFBZ?=
 =?utf-8?B?dnBoWEUrWVkwVitVZ2lvT053NUhIMzR2bEQ3VkFVZXRBb1hoVTZhNTJuVEpl?=
 =?utf-8?B?cnk1NmV2TWxkTmVPZVVlYkJ4bjlveG9NV2VNdyt0SFpOK1ZKWDFLSFFtVEwy?=
 =?utf-8?B?UHV4OFdMeVNyU2N5TDEyRHNkVjlPM2w0SUwwcHhJVzVnRk1kdFpCV0xqSnRu?=
 =?utf-8?B?T3V4Tk5aaUZDZ0huWGJCUkdkR1p4SDQ5ZHhlUWltZFQwQTFSckRGMFBXd1Av?=
 =?utf-8?B?TzU1cmhLSlNGNVpncWRiRVdic3dGSFNwb0lLUXpueUlaUGxyS1NPU2phM01X?=
 =?utf-8?B?OXd0dUtPVjkvRThZUm5KekUwVEFTeTRsZUFUZHNjSFhYdWdUMEVCaHE5K1Zk?=
 =?utf-8?B?REcyVzBNK1g1dWVuYVRWUEdGdFo3M1lMWHBqN0RtbWhlWWQ2K1Ivb0xud0No?=
 =?utf-8?B?KzVOVVplK3JCeVp1RVpUejNXbGZreUZvNkdhVlpBNVB2aVp0b2YvQzQ5Q24z?=
 =?utf-8?B?cWtqNzBzcUhMQWxabVdzWUJLV2VKSzRDUnBOczRkUXBBUTUwc2ZhY28zLzh6?=
 =?utf-8?B?UzZvQ3o5RmJRdFhUeFc0UHNMT21rM1VubmtCT1NGdWdRSTNwTGFxWW1RN1VZ?=
 =?utf-8?B?cWJ1NjgwVVduZTA3SjUwL2xrN0l5dUtZYW1sdHhSUGd6bFJVV3lNdE91YXEw?=
 =?utf-8?B?RGpOMmxqK0lqWnBOWHhhV3FYWVpJVzRjWmNFNThHdFJKK2VHZm1sUnFsRHdT?=
 =?utf-8?B?Zm5ORkx6eHRkd09oNHVVVnc0czVpRUxWQUZ5RDVTUFJXQThNZS8xdkhOdDhi?=
 =?utf-8?B?M1VkQ1FzN2RuSFZwOSsrQ2hUMlNuaW5hZ2s2aldGT0lsM3pkeklwK1VHZ21E?=
 =?utf-8?B?eHFXdnA5aFQ4VUpFT293bDdhK3ZsM3ovSzZpd3o4Zi9mbExhOFB4YWY4SGhZ?=
 =?utf-8?B?eWRhVGR6RWJVcEQxN2hrRDJzSG5ENWlXTXFEd0YrTE9WRVhHaVZQWXZSc1Rt?=
 =?utf-8?B?SlROYlBuUmRHamx0VkpMYnM0R1dNYTRKZW1TVkNlT3BXNjlIMEZTeTl2SkJt?=
 =?utf-8?B?MHhaUklXTFpOWTUzMHNxRWwrS0ZOWWxIK04xMDZPOVFmY3h1c3NrL3NzeDkv?=
 =?utf-8?B?bDNVTjdaYWpCZTQxS0VQRFVmdEdnbEdORisrQ2NMR3JpaTlVUmNSeUNBVjV1?=
 =?utf-8?B?cEU5ZlN5MjZ6VFlIWERWZzh2WlVWT0l0WmRkdkUxSDRPZWdxRGtWN2wyWWh2?=
 =?utf-8?B?REErRzNMQ1AvQTBFUmlTYzZheDRVUVR6WHRjbFFPTnhidmYwS1RLUThQa3Ni?=
 =?utf-8?B?NnpnOGFWc2R6T01GZFNBMzBNeDNOeTBRRlBIVFF3aFoxSytGUVB5QjdCYUs3?=
 =?utf-8?B?MHIrNnp2b2NYNmdsR0Vub2IxWDNlSngxcUZadXhTNUZQQnF5QUtSeXpvWU0y?=
 =?utf-8?B?eUw2TS9ZZUluS09yeHlKbjZXdk5hQzNvYW1YcGU3dTYwYUpLcHNUV2lyY0JI?=
 =?utf-8?Q?vLi+wCkSui4qMK38XQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SFk1N0x1cmlXU3VFdkdVMUxDdzlyWWdBZEZJdzdXMDBUVUx1cXlRQ0MxalVW?=
 =?utf-8?B?VEpLNTlhM0VKakhlajRvWnZKaVpkUE52REF2MEx0TDQrZ29mZU1LRkZyTFZk?=
 =?utf-8?B?bndjWEUyaDZpS3BpeFNhOHFXeEVFMU1NaFRxVnVWZm4wVVV4VjhzRlo4M0RW?=
 =?utf-8?B?U1V1QS9YSGhVMWQ3UTZ0bWdBSTdaOWRsTllzUjFxTmh3dTBpMEYvMGVkbGU0?=
 =?utf-8?B?UHA2OVh5YWhPcGdGaDlkZFhQMU1MZ1ZkbFBiVWZ4UDE5bkltOUtVb2NyeVcr?=
 =?utf-8?B?bmtnQkduNFZ3TUFLZGhmeTI3YmhENVZnTWdoeVJnVUJoUVdZcFk1THUrNldj?=
 =?utf-8?B?djhzNUNuQklpTG93NHZ0Z2RPeE9DZ2dXZnl6NmZFa2lUNVdtRGU3cG0zVDRK?=
 =?utf-8?B?a1JMRnJmdEJVa3hObEt0eDRHRTdpY2VQN0lQNXkrNmV0ZHFZNHptK0hxVWI5?=
 =?utf-8?B?Z1FWZ3R5VkdqNUZpczN5WVkwbDVScHFxZTFRWU53dHFXWGFNWHhmeEk2TDNl?=
 =?utf-8?B?V3Jyb1VmTTVDUTQ3c21WTXJZcUJFbE5BWDVQVFpOLzZwQ3Rzb1hWS0ZJMnFL?=
 =?utf-8?B?djBIeHJqRFl5NjdTN0NZTmlCM3pTM1hqVHNXazlZYmc3bG9zMjlKUWc0MmQ3?=
 =?utf-8?B?N2pKZWZDMDNkSmQ5RkxPRzN5UWRpWmYrMlNIRWVDYlJ0ZTJRVUF3RzRXems0?=
 =?utf-8?B?SjRHY3VUb0lSbFkvdVdUb3ZvRnk4VW9EcXNhWHF0UVhvRGNZZm51bzkvMG1R?=
 =?utf-8?B?RU1vejdTdXdRUlB6YTR0V2xFR2pqVnNoZmltS0h6MzhVbjdrNnJwNXVyNzFQ?=
 =?utf-8?B?czdiWWxacWMwcy9jdnZnQ3NtbkdaclZhYys0czBVL2gzeHZtNUw5N0NKSU5P?=
 =?utf-8?B?TytwUCtrZWZKcEphMmwvODR2bVNnSFg0d080VXhtamJ1L1lBeHBmMUYyTHIz?=
 =?utf-8?B?QXVsZXRieFdSTFVGSjcrOGRYUk9VM3ZpV3RHNU5XZzlQOGpSZ3B2V1ZaVjR2?=
 =?utf-8?B?T0pNcFFySk5vOWNiVElDSXRISnA0VkpVZEJFdThMVEZpaWpGMk5sR2w0UVFy?=
 =?utf-8?B?WlVCVXFYc2g0dElzMHFPY0VOSzh4UVROWUQrVTYrMkZ1VUNEVkp0SlZIenlU?=
 =?utf-8?B?SHBPUHdUUHZDVUxPUDZHNmd1WXFTNHEzOEd2MjJHblZhV1dudlBiODlMOE1V?=
 =?utf-8?B?OXB6cFR2TURTbC95VVlLVGoyRk9yWEpVcTRhNWtSUE8rd2FINCs4UzJjVWts?=
 =?utf-8?B?SGhPVlZaZUFCeXRJaDZCbHdnWUVRYUQ1WWxoT2pZWlUzcWxiTEI5Y2FCZEpG?=
 =?utf-8?B?NTRjaWxrbEsvQWp6L2FBNGpjOUt1dEhmMnZnOEcvaDNRYWE1UDU3aXpjTEFj?=
 =?utf-8?B?eTZDYjdKeTVhaWJUSG43ekxwcjBWdGdyNkx1WlJwMUQrWTMyTCtuMGpGcWll?=
 =?utf-8?B?VEF4cXhUNXZJVWozbkJxWEFrQ3pMajFYM1RacWdXa2I5Ujg0M3dJcng5NE9B?=
 =?utf-8?B?SE8wek53WSszZStZK0tMNGxNM2QyR0pSbENIVXFnUkZCVHZEZ2g1Sm5pczlG?=
 =?utf-8?B?eDBQcTRHS3greFYwSXk0QnNBSHU5dXZsYkxNTlJMSEdXYWY2eDU5U094MEtF?=
 =?utf-8?B?NmljSTFJa1I5dVo0S0dwYVQ4RitDbDdRQ1V6SjhYSWFQMVc1dHhkeWladTEv?=
 =?utf-8?B?RHdRSHJrR3kyeDJ2V3RnRWs4dUV3Qk54Vm5XbG85NGZCVXBwTXpad2xBTXNW?=
 =?utf-8?B?ZkhLd3VFSkg2TU9ManExc1RDRktIeE50ZjV3Wjd4U0dHT2xUM0ZJbFpqR2pp?=
 =?utf-8?B?MFBYZVlkQVlVSDNMV2dtTkZHRDZWQk5NZzFObjQrSHhqM2tjZDFVUnhhVjhj?=
 =?utf-8?B?aUhNVmorcjN6MVB2b2RxVzlpaUw3cDd5ZUEvQStRKzZhQ1hKVURlamZ6MldO?=
 =?utf-8?B?TE9qV01sd0sxa1RkZmd2cEFmQWlqdjR6eXlRbzFxYkdXYzE1M3pwbThWUWtD?=
 =?utf-8?B?Q3Y1OFR4OXhPSWFaYXBRSHV3QTViUGhiQmRaYlB0M0dEbU1jTWM4Y3FWbk9p?=
 =?utf-8?B?TG9DajJoTFNSZk1KMEVRTFZZdDNYTEIwTVdiQUNYQWZhTnBIUUhXNFN2ejJk?=
 =?utf-8?Q?Ag7TKbLg+WufnpccZfW0yCNk1?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dfc6cee1-1439-4e67-269f-08dc9b22e5cb
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2024 05:42:16.9311
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K8sQXJPtt+8aDR4sPatU3qAEiz6NeqW2f3+givwtRUue6BU+aMKuqtHGkofjtNNci7g0WcplX5jgxt3Wz8Mt6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7883

Jason,


On 7/1/2024 10:56 PM, Jason Gunthorpe wrote:
> On Mon, Jul 01, 2024 at 04:18:01PM +0530, Vasant Hegde wrote:
> 
>>> Then VFIO will just request the V2 domain anyhow and you are right
>>> back to the starting problem again.
>>
>> Let me see if I can put together here.
>>
>>
>> - Basically we want domain_alloc_paging() to explicitly tell domain requirement
>> (ex: allocate PASID capable UNMANAGED domain)
>>   If we do that then we will fix ordering issue I described earlier.
>> - Fix attach device path so that for 'PASID capable UNMANAGED domain' :
>>   non-PASID capable device will use AMD V2 page table with GCR3[0]
>>   PASID capable device will setup its GCR3 table as well and it should work fine.
>>
>> Net we need a enhancement to domain_alloc_paging(). Otherwise I don't see a way
>> to reliable implement things.
> 
> Yes, some flag at domain allocation time is clearly needed

Right. I will try to get this going and then we can fine tune with Robin's
suggestion.

> 
> But you need the whole story, including when will VFIO set the flag,
> which requires a uAPI someplace.
> 
>> But these two can go independently?
> 
> If PASID goes with a default-on uAPI then you loose what you are
> asking for as VFIO will always request PASID.
> 
> So the overall plan has to be sorted out now..

Is this the Yi's thread you were referring ?

https://lore.kernel.org/linux-iommu/20240628090557.50898-1-yi.l.liu@intel.com/

-Vasant
