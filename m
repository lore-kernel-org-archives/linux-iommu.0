Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2065.outbound.protection.outlook.com [40.107.94.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27A2B4437
	for <iommu@lists.linux.dev>; Mon, 21 Oct 2024 09:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729502405; cv=fail; b=mdU9BFWdnjWP/JCz5ZHI8+5eg9PKwyJUzqYkbaTgj+MyrQxjWResGZA0ssMLZVvILGaCQz129eBMw1UxUjf5hoe5A0cApMtsPlIdowIqcwD0kDcmr5eLeRgJfrIF1TfV2XvoMx7OnZetMNdPBT+fBqsjGh5L1De1AhHaMBlx98I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729502405; c=relaxed/simple;
	bh=jvUaLqBJYpvR7oDzew1op15jX0hkI67XIVZO2aQvl0Q=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XpickfZY/BuyY+/EjpaQdFxBr/eeu3YAfW8BRK6NhR/aSFtiE8MCs0G/x0Spqf2xTt9pBNCKZNKzbu5UvkzuVIBoWgiMVi5niXOb44ZZ80m7JN+bV4M64xztC1RIXUGmVlDredXfp6BS7s/f0odPcD9JXXE32BrMS+JsDpu5cJE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=fRf7+L3r; arc=fail smtp.client-ip=40.107.94.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="fRf7+L3r"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eM1FFNfL8T4kEZEMQ27IDUbnrolO0xsxzixu6ywCb9sDRj2IC2suZPEsT247f4PI++wGWe0GFPjiTjV3+74auYk7uEM21e/0y8JwMhqilZYVrKIZXuwVxeG6eAxpzv+NTTYZAlXJvJhnY978gRC6jlj1U6oLFRAKU1l4CetU/PL6pXq4h+4ogN4UlX2Wnl6m1XUX8xXS8KsRTRw++xCAhf8rtan4hrvTf7pqNdEq1x7noxAfyUOmgHBecW/m/Yr1kI39RRs2d2US5PCbZdQ2M2PoR5sMFl7ISqozPK7N8sg4ECOGOpfoNpR64IHSX7arsCERMvGBX5fV4aQ1bFARXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gwPKDv0SvqExwjk5YTDnMOeU11ajDnpublJ9KwbnIQw=;
 b=ACL4bD5IZYwf1vTBx6sBkNE97dFc4CZDCw5cyynNlsgpB1u0f1bXCMsXXttMqVP9fyeSf7Tpubt0OIFupvTIF4pxNru0dynt40RUNCqDGy2EuFpLjHPLEZAWgq+kL1PiDtqDvlYJ9ivYU2Fv3fBl0QJIT7xuiqkFz6ys3g77rwOJos3E1DsWhF3+jnjgMLepNVAOXCpCdalY4KBszfwoiCN1Buep9dnZU2Rh22Za5QX1U/YDc/CsKI37DFQNPL9/xwoKDzp1LgvOH8ztzY0vO+6kIuoHmk0DkzWBAnFn3JS9Vw/aVRiMj7+wxQ22sywB/9LvUY1ZxtRxAvTabBpEnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gwPKDv0SvqExwjk5YTDnMOeU11ajDnpublJ9KwbnIQw=;
 b=fRf7+L3rUvCKptk2trIEoU05RAkVl7pavl1Tiz8IFjyTRoJBL4F6qGKRRBdTmWC20SX3/k7AFtjZAXu//ghfWT93LVLYU3aC7YxZjH72I3DEzn7i+w7qzf5+Jbqs7mBK0YBm8hw/ocv0+HQ98gxIOT4nYlv9cDjBoT6lG71ivAI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 PH0PR12MB7983.namprd12.prod.outlook.com (2603:10b6:510:28e::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8069.27; Mon, 21 Oct 2024 09:20:00 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5%4]) with mapi id 15.20.8069.027; Mon, 21 Oct 2024
 09:20:00 +0000
Message-ID: <33d759f2-5517-4010-bd35-bb6097224bf1@amd.com>
Date: Mon, 21 Oct 2024 14:49:51 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 02/12] iommu: Introduce
 iommu_paging_domain_alloc_flags()
To: Yi Liu <yi.l.liu@intel.com>, iommu@lists.linux.dev, joro@8bytes.org
Cc: will@kernel.org, robin.murphy@arm.com, suravee.suthikulpanit@amd.com,
 jgg@ziepe.ca, baolu.lu@linux.intel.com, kevin.tian@intel.com,
 jacob.pan@linux.microsoft.com, Jason Gunthorpe <jgg@nvidia.com>
References: <20241017140137.6028-1-vasant.hegde@amd.com>
 <20241017140137.6028-3-vasant.hegde@amd.com>
 <942e7019-a477-496c-b04f-b0fb12283187@intel.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <942e7019-a477-496c-b04f-b0fb12283187@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN1PEPF000067F6.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c04::37) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|PH0PR12MB7983:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ba24acb-fbee-4701-8761-08dcf1b18998
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NnI2dUp2R3N0Ry9NZ1gzWFFrdGpQWHF5SCswd0ZxdEo3NDlMSzFrU0lUWXgw?=
 =?utf-8?B?VFM4a2NGUkxQUGlTQ3ZRSDNQaGFrcHNKc2tHT1EzRHBNdkZEMEpUWTMxUTZp?=
 =?utf-8?B?R1NjQXhHdkFHSENuWkVSakV6SjJuRk9XSkc3T1NwcCs4T1VmVkl2SUtKdEJ5?=
 =?utf-8?B?QlRrWHoyeldnQWVvcURLWENIN0JKaDVaMFFKOGxZNENXb2d6V2pkZ0V1T1lV?=
 =?utf-8?B?L2lBV01JTWY1RzBRa2FWRm5iQ2JaWEo0NDRZL1RZQU8ycG8zbmV4blB5MDZ3?=
 =?utf-8?B?OXlDWXFnaVZXWlpOV25KZUpMVGI0ZW9scHp5RlEyUTdNME1XbU9MYXd6SXFv?=
 =?utf-8?B?T1Z6NG9ZbmQ4WE9qbEdWS3N6cHlwaGkvS2g0TXBINmR0SEVYT3NjQnZXLzdv?=
 =?utf-8?B?MW9zdkxON0dwTzEwQVh4bzNmaGw1SFpzc0hHRFBXNTdoTVlYQ29MUE5GMERT?=
 =?utf-8?B?OVcrZFhtV1V3WkJ5WDF5QzY3L0x2L0pOZWZWNzl1TDdGVEZZZGFJZEhtQWpN?=
 =?utf-8?B?RFVYVllvYk9aM0RFMGtPZEpWc3BrK2EyT2g1RzdhRndRZnBhMVFFekdSdU1Y?=
 =?utf-8?B?YUZ6ejhGL1l0UitNY1JhdnlpTUwyS3BzMTAwOGZRVGNENWZaOE5KNTZDRWk3?=
 =?utf-8?B?YTcrc2Z0dEJFbnhiUktBQ3d1SkVLaGErNHRMbjJkSlAvdGxtYkFWV2xldDIx?=
 =?utf-8?B?REFrZ2JVVVVicldGSS85VWM2Ry91OGpMeHRGQ1RNY0dUekE5djg0UlROM3hi?=
 =?utf-8?B?ZXJrcTFBeTl0eWRqQUNqZDNPNlFkOHlpRFFUVzJodlhEUThpeThOU1pnYVh0?=
 =?utf-8?B?T2VDbEh6WUZwMmc2WTdoWlYrckNHOWNzejVVRGc2dSsva1Z3cUpDbS9kUlVp?=
 =?utf-8?B?cWpiQUxyckZiWE1DM1E5UktrR0FGUk9HZjZwN1ZxTVByRjk0WWRPT2JXdGlv?=
 =?utf-8?B?OW83QjZqeUdVN0hVeXl2dm5HSUMxeHJxbkNMY3cwN2tqZS8wQVVJN3lvYjRZ?=
 =?utf-8?B?ajRxMXZ6RFMweFY1YUtDM2x1cHNqRXY5aEpiUjMxL0VnWmw2a3VkbXFpeXd5?=
 =?utf-8?B?bkowc2tBeE42QTV5M284SkdDbklIem5sS2pqYytxZDVaeUdCellSRkU1dmZH?=
 =?utf-8?B?V1RJTG01Nk9FdUxtdkxwQXMwTWloTkdsS0Z6YktBUHZJbVlNSmFKc1ZGaDFB?=
 =?utf-8?B?U0xiM2ExekhKZmVXSFpyc2w5L3BEWTh1eVVwblcrcHFXVWU3a1I1eWtGNExz?=
 =?utf-8?B?bEdkQWZ4aGpFM3dQeUNBb1lVVFpycWk4MSsva3dmbkdzaERVVXBrcUhXTDdS?=
 =?utf-8?B?QnNKUG52T1o1eS9pYTR5UElPK1RheVo3NURUNnBkbmdESFVjbStBVCtYTE5p?=
 =?utf-8?B?OVNJZDQwb2xxajdZTFFPRCsxcHdac1V0MHN5bi90SXJ0azJhem4ydklCVDQ4?=
 =?utf-8?B?WTA4M3FOOW9xOGJxNnU0aTNycEcxdHNGMTJQYlFLV3NXY09iMC9rZVgyOGxZ?=
 =?utf-8?B?ZmJxRlFRUkM3alBjaXhlcFFKYjBjRXNhZFljcWdJcG9La2hwdlFncVp5NXNq?=
 =?utf-8?B?Zlc2dEpUcEd0SVh0cXFXL3M2RmdiVVlWdnpkUmh6OEtobmhlQ1VOY1dadHBn?=
 =?utf-8?B?Z1FpK2I3bXh1Sml2UGF3U2I3Q2pNbm01dUlsZ3JOK01wUy9tNGVVUW9leUdB?=
 =?utf-8?B?aHRjbWNkTHlqYVNkMVdNdnFpYzFnYUhOd3R4cHV3Q3g4S1NKYUtlcmtWcnlu?=
 =?utf-8?Q?0L7feonN9HqEZu/f6i9QHYpgMzsmXEUf5GhCkHv?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YVl6S1BNQVo4MWN5K3UyZXN1SXdNeWgxc0lLSXpGM1VWaHd2TVRBK3JWVnhS?=
 =?utf-8?B?ODAya1VLTE50TFRaSmZrejRzZGs0VHY0TElZSGYrT0RDN3dCY1hGYlBjYnNx?=
 =?utf-8?B?N1QxNHJqM2I1S3VWTEpMM0Q1K3hRK2FlNzJWY0g0N2dEYktEZHEvTUxKR3Fy?=
 =?utf-8?B?THhrVDRNRkZwem9Nd05BN1daUkpxcTFOdytEclpVZHNHSW1Gdmt3cWpXUzJG?=
 =?utf-8?B?aVphclpVNjMxelFzekNEcWl3UzF5V0Z5VEZwcGRkUG9mWUl3SG8wS1NhVFBn?=
 =?utf-8?B?S1lHaVA3SXJFdEhQLzhBK3JoTkN0MEl1cmlmWEY5YzlWeTNuNGV1S1ZINEUv?=
 =?utf-8?B?aW02aVFkWFM4MmhRcFR3Tm9OY0tNZWFGekZQVkxRQkpOSFhjTFd1dmtLOGl2?=
 =?utf-8?B?dmdzUlhmcGVjTGRsRGZjRmVNSHdkaGJTY0VZUFlBU1JVU3daV3J6SUxueG9w?=
 =?utf-8?B?dERqbERaQlQ4N2kxSVNuMFVsakxiMm5JZnRoUldYeW5UUlk3eHdUalZsSmpk?=
 =?utf-8?B?V01laWZNeCtqQnA4MWdNM29LMHZFZ3F0WU9pWjdIanZVNFBTejBIY2FNazd1?=
 =?utf-8?B?S1RnY0c0eHRoVXBPYWxPbmIvalhiY3p4YVA2VjVPbjF0emRBYkpENzNIczRp?=
 =?utf-8?B?d1pKaUFkeEdwLy9LV3dmbWI5cytKWTZieDA3YWptUjdFRGFOSEYzN2JMQlF3?=
 =?utf-8?B?dUx3TUU0cC8wY3JvSFpKbGpuNmtnTkVlWDNtd1NLcnpTbXZMQ1pTOHo0Y29m?=
 =?utf-8?B?TE85NDY5ZEdXakxEcTBZRFdLQ0NCblpjNjJwSWdvcTVIRkpncWZmSFdldHF1?=
 =?utf-8?B?WHRPSE9MejJQbmROUTVIUjN5bEM1cE5ibDFtK20ySC9OYk9qS0MxbjI2aUdR?=
 =?utf-8?B?MkE5NVBheWMyV29wZ0pDQ1hzOHByT1ZMRUdOT1M3VW5jakdGZjlpYkN6bGRj?=
 =?utf-8?B?Zkc2aHkzVVZkdC9wczlNSXFwM1ZwdEJoNXJpLzd5OGFubjdqdXlIZmRmejl4?=
 =?utf-8?B?dmlDMnBJTmhxN0d4VHhuN0JCeHFZeDd6b2FaSDJXNkJsK2pyWGFPVDdwWDhp?=
 =?utf-8?B?VUpaaUx0OXA5U0FFNXUvZjJPQndkRC9RcnVkNDhzZ1pGRHFzSi9teno0cHpE?=
 =?utf-8?B?TzI0NkFVaXRYRG9oOU5lbHNiQUNvbEJyOHhKYUlpR3VRamlsWlVBZDhCRFc2?=
 =?utf-8?B?aTdxWFJxTmtRMFZ5SzJ0N3VRbmdPbjNQZ2RiRTNWTmswQWdkd055Y0Q1eUs5?=
 =?utf-8?B?dDBQcjhVVGsweTVPVm9rVE1TeG1DL1lwTlZQK2pTSkdnNGFXUHpiU1FVYTBO?=
 =?utf-8?B?N3NrR2M1dHhxMS9jeTJvSGtmNFZhNnptUzN1UEpxSHFVcmdxVklodG1YYlI0?=
 =?utf-8?B?MTJmM1FMSENkODhDUHQwTUwxVGdVelhzQUNrcVczWXpXK05SMXlTWEt1QmNL?=
 =?utf-8?B?ZWxTb25vS0VKVzdoelcwWkdkcTlIYmk0TlVvQWYyaURWSmRXSDY4SGMvQjNq?=
 =?utf-8?B?ZmdqRWdYNlBESFliWUt4QVluNlV2cGYzMlF4OHBRdGN4L3RIeHRwMFJhdUJH?=
 =?utf-8?B?c0ZKeTlQak9YWjJQVnA5RWlaLytTREhxd1dVbmw1b29wWnNjWGp4K09sSzFF?=
 =?utf-8?B?Zzh0aEd5cFYydGFCMnl6L3puVWs5U0gwSUJGNWJmMVNJakZBMzFSOGJaZmJC?=
 =?utf-8?B?MmM5T3VFc2EwRjBJRzltUWFqdHpXeUdzcWx0R25UVGhOUFVvdU96UXhkSS9y?=
 =?utf-8?B?ZEtaeVY2VGFKVVpLdzdrdDl5VklXVkZBMGhLdmxqZ2xmaTYxcW5RUGtaUzBP?=
 =?utf-8?B?U1VIV2ZqMVZ4c3Y3RFdrUTVsOVBnd08wYXlIUkozZm45Ui9qcGdYRFdxdmw5?=
 =?utf-8?B?WmZpelZVNHVad2lzV2o2UTRQR1dHTDI5bFRsWm0xaTNwbWI5RE45QzA1cjBJ?=
 =?utf-8?B?UzZWeWpqeDhWSjBYMFhuZjBDRmZkZGFUd0JuMjFKdTljWTVsMHZlY2pEOEhw?=
 =?utf-8?B?eWQ2TjhFOVVWZjhBTWtRc2U1aTlTMExoS2s2QTd1d2JVRGF3Y2lWalRrUnI3?=
 =?utf-8?B?Y0RMQlBMaFpMbGpobHY1b3N3WHMvWXgyT1BUa2dYdWtzZmJpODZWSXNjKzIw?=
 =?utf-8?Q?ttlzFz8Aq0XK61zN95xMhStJQ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ba24acb-fbee-4701-8761-08dcf1b18998
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2024 09:20:00.2827
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZFT8PR4zVGQgQoxkR5HIZ5jmF7KU1YPZLZqlI8fFRdBgiticoRfjwcHwVWZkWnP3lgX2kN3Da5rDHtEQk8aWUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7983

Yi,


On 10/21/2024 1:17 PM, Yi Liu wrote:
> On 2024/10/17 22:01, Vasant Hegde wrote:
>> From: Jason Gunthorpe <jgg@ziepe.ca>
>>
>> Currently drivers calls iommu_paging_domain_alloc(dev) to get an
>> UNMANAGED domain. This is not sufficient to support PASID with
>> UNMANAGED domain as some HW like AMD requires certain page table type
>> to support PASIDs.
>>
>> Also domain_alloc_paging() passes device as param for domain
> 
> The below may look clearer to reader. :)
> "Also the domain_alloc_paging op only passes device as param for domain"

Better. Fixed.

> 
>> allocation. This is not sufficient for AMD driver to decide the right
>> page table.
>> > Hence add iommu_paging_domain_alloc_flags() API which takes flags as
>> parameter. Driver can pass additional parameter to indicate type of
>> domain required, etc. iommu_paging_domain_alloc_flags() internally calls
>> appropriate callback function to allocate a domain.
> 
> how about mentioning that the domain_alloc_user op accepts flags from
> user which meets the AMD driver's requirement? Hence, it's clear why
> we are not extending the domain_alloc_paging op to accept flags. :)

I have added below sentence instead.

Instead of extending ops->domain_alloc_paging() it was decided to
enhance ops->domain_alloc_user() so that caller can pass various
additional flags.

> 
>>
>> Signed-off-by: Jason Gunthorpe <jgg@ziepe.ca>
>> [Added description - Vasant]
>> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
>> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
>> ---
>>   drivers/iommu/iommu.c | 30 ++++++++++++++++++++++++++----
>>   include/linux/iommu.h | 14 +++++++++++---
>>   2 files changed, 37 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
>> index 811748bec4b0..e13d64ffd14f 100644
>> --- a/drivers/iommu/iommu.c
>> +++ b/drivers/iommu/iommu.c
>> @@ -2027,20 +2027,42 @@ struct iommu_domain *iommu_domain_alloc(const struct
>> bus_type *bus)
>>   EXPORT_SYMBOL_GPL(iommu_domain_alloc);
>>     /**
>> - * iommu_paging_domain_alloc() - Allocate a paging domain
>> + * iommu_paging_domain_alloc_flags() - Allocate a paging domain
>>    * @dev: device for which the domain is allocated
>> + * @flags: Bitmap of iommufd_hwpt_alloc_flags
> 
> maybe "enum iommufd_hwpt_alloc_flags" would be more accurate.

Ack.

> 
>>    *
>>    * Allocate a paging domain which will be managed by a kernel driver. Return
>>    * allocated domain if successful, or a ERR pointer for failure.
> 
> nit: s/a/an/

Fixed.

-Vasant

