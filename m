Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2050.outbound.protection.outlook.com [40.107.220.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 819BB433A7
	for <iommu@lists.linux.dev>; Fri,  9 Aug 2024 05:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723181818; cv=fail; b=jiiqQN6s/3PFlAI9ObexRVFv1HlS795fF7m/VIV+WsGddPhpYGEuhmShThZoA3isqTcaSFGTUgNRBm0icBJ1PJHe24vQPWP2YU/d6y46qS9p/q+DK2CDtZenCqSCAf4BvMMHnbOcQVNXNBjVMhMZcxuBi8UTDVfMkmnYMqY4h3w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723181818; c=relaxed/simple;
	bh=RucAMQZTKHIvZ32UZNBQSnCzdxOJoQUc9Wi1hoO2CHs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=u06+CC7ebZXY7I5pnpEb8WTGf+LO8FFsDEFRgqV0qSTBEPvGfSVCyQ36yOUODhM+q8ng1w6W1gMikaT+KglPmraIgoI3sRi464uAm9VBIKKmxC+8RvcgeNR0fPm0f1D9oB6lZ9H8lKph6dp0/LIderHwFIQ+FWNyIs3ZSuZOfaE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=NyJ27EFU; arc=fail smtp.client-ip=40.107.220.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="NyJ27EFU"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AfFLNO6fsojKbY+MYsOfcSmRSA2xr5KGMgMFuigPIho6yIyrk1fQEPoFBmfFdSb7zh9il12cc29xfZW56pF9r4VeG0FD9YQsLMzhtImXzsBfWgdFLwYqR02/aIjfjJ1KyFTCfevMx7NDzSinkRUX9eNQisQ4FVd53M8MGvwJ/vqpE8UGAYMRFnqsr3gRrpgH+LA+1Hj3wl80ZNumTyGjYiESZihg7BR5t09u1PS29wT4ocVV7I1OF4KS9c9UPaEzAwQ8zySI1lZWRWEhvY3M6w7MXmoFbfUj0W3VtfkJ4821r9HbVIxC1rfxezNFqxa4MLM+q3vFEbZcOZuJU5xzCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MWUfhW/N7IkwQoAxgt557uA3YFJ+CA+AQu1VXQ16bKQ=;
 b=aU4Osd1Rs5pdPSIemXhZYG5LkWFJd2RbfCmoe5yGngN5oD7kH77t54XAk5mdE+s+wdRrlYmrdwjMjcPN4ChFdmHK5/ru9lfzksh38pBUJKIbYkBraixPJoUhBz8TXKdT5jbFMImYc8AQ51ZsEDNw0PhJDteIBferwtv4khc22sMmPEKhTixKPGo2po9D5TNZxytVwHePu/hSGNE421ZHDCc5VYo8qG16qB0ZWmlPDcCn79NricIFyYctyYSsgLBVkbh7vOfL8wXGAuFeEFRhXWR6bNJdmhkzLqsG3kR+ZJmuGZcQCkxyjA/Cu7vKwhEIdY9m+AU/PURkJwHx4hy9Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MWUfhW/N7IkwQoAxgt557uA3YFJ+CA+AQu1VXQ16bKQ=;
 b=NyJ27EFUmAcxYdMbxSWQN7YUbLrhrtnSMEVe55PFi1n2wcM4si/HFoQVmmOdyARtdiJvAUpfzJpqrivbrJqL7dp82FcvgY8A8otkytoCioHuZ3ufZUUnIUvSlY2p1RKsw4MtFdJBSZWqF1sZe22Zj0kFAR97nwNr9jkDP76MDao=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 DS7PR12MB8231.namprd12.prod.outlook.com (2603:10b6:8:db::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7849.14; Fri, 9 Aug 2024 05:36:52 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5%4]) with mapi id 15.20.7849.008; Fri, 9 Aug 2024
 05:36:52 +0000
Message-ID: <b718e041-bc2f-4927-81ad-80066ea09594@amd.com>
Date: Fri, 9 Aug 2024 11:06:42 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFCv2] iommu: Add domain type and flag to
 domain_alloc_paging()
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Baolu Lu <baolu.lu@linux.intel.com>, iommu@lists.linux.dev,
 joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
 suravee.suthikulpanit@amd.com, yi.l.liu@intel.com,
 Alex Williamson <alex.williamson@redhat.com>
References: <20240801144523.11803-1-vasant.hegde@amd.com>
 <8e531f39-9d14-4d3b-8a52-c2e8ca026f9e@linux.intel.com>
 <098008f7-2b3e-405a-a096-947e5df560e6@amd.com>
 <20240806123452.GE676757@ziepe.ca>
 <6b197aac-c38f-4e6e-9d32-d74e1a5b3968@amd.com>
 <20240806173230.GS676757@ziepe.ca>
 <bbe564b6-5079-4973-8678-1068a53ddf70@amd.com>
 <20240807135915.GF8473@ziepe.ca>
 <e5da0709-86d3-4b45-82cc-d995a2686afa@amd.com>
 <20240807182947.GI8473@ziepe.ca>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20240807182947.GI8473@ziepe.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0114.apcprd02.prod.outlook.com
 (2603:1096:4:92::30) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|DS7PR12MB8231:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ae3f246-f153-492c-5046-08dcb83545ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Mlc0ejJPVW9ENTZyRDdvTlQ0MExITUxoRnlpNkFoTm5uRm5wZWFFdFBPR1Yz?=
 =?utf-8?B?bWQ0S2NDb0pXTzVseVFhNkk3ZUZpVEJRa2ZNaEdqbHRaR1hHQmdoV2RBb0xY?=
 =?utf-8?B?L0dpdWFDNVZqWUpqbG5USWszeTlnM3c5ekxwUVNpZWh5V1E4d3Vha3paRVBj?=
 =?utf-8?B?QWdtZkk0SXkveVVrbXNwMit6SGhTMnJJNFBQQlROZ05Lc0JQSEhEaHBJVUw3?=
 =?utf-8?B?a1JGblZReUZ6T1h3OEZFZXU3WEl1ZHlvNjFxK2pTK1BFaktxd29OcXJOb2tY?=
 =?utf-8?B?WEIzVCtyNzhlR0lnVVR4eS9USldzbW5yMTZmMUt3NlN6RHYyY2FTQVlWeTZE?=
 =?utf-8?B?WDM4WTZwMzBORHZzSGVFMHNVVDBmWDNtZ29hL1l3VCtUSWFjbnpZbUpLY3dX?=
 =?utf-8?B?cDI3aUUvYkxhRVU5UVhYYlVZS2ZUYzdtanI3VTZsZ2RNYWJYM2w0ekJacWQz?=
 =?utf-8?B?akltcGg1NjZYblBHQzJjTERGT0ozcTU3ZnA2WE50Q3h3WDNIdW40V1hUaTRa?=
 =?utf-8?B?RFcvTWcyQThZUFFpaHU3T0JKeGR6WUVNbGFIVDBIYkI3L3VOdmwrOXdCZGxn?=
 =?utf-8?B?ZlpaNDJRODBKVTArT1A2dUc3ZXZhbGtiRG04RVRzZngwNURCVW9pc2RvYUIr?=
 =?utf-8?B?VEh5eTRvdVpSdUhzbmFqN25GeWJkSUx4bUkrMWlDdWdDSmZFbkU3SjRLNlNa?=
 =?utf-8?B?ZDFpMThYN1lmSk0zQWF0bXNuaFpnWDRCZ3QxYlJrbDNsY3F4RW90VG94YUd2?=
 =?utf-8?B?NnhNaVRUTHVXbkIxa1p2MVVwNmF1dnFpZXNlcy81L0xucFp0dmdFSndIdGhz?=
 =?utf-8?B?b0VLZ2JNejhWZm40d1BBTmVCN2J4d3VMbU4rVEhLVURVUkt4cWRhaWZsbDZk?=
 =?utf-8?B?aTMwWDd3MjRweDIwN0NXclZXMEQ0Q1E3R1VTMTZGSGlFQ3NWMlkrV2JIMzdU?=
 =?utf-8?B?YTVUZ3ZVYzM5eXB4ODY3aEU5akZWYVFFTFM5Rnd4eUpjSXVMWnI4Yk5ZVnhN?=
 =?utf-8?B?RTRXbFJIY1owNWJYVGtlMXBoZGp4VXdkQTFGK3RTY1ZXamRaeGVQQXcwYkhr?=
 =?utf-8?B?eEFKb3d2UXBncmFIc3NXZXFTNDFxbUtsMVBqY0gvY0UxZ0lMUm5DQm9yWEhy?=
 =?utf-8?B?aXExL2tWNXpRMk5SMUVobkxoZ1FTdmFOM0ZrT3lNdm1FUVgwZVNieE1xT2hv?=
 =?utf-8?B?VU1NSWdhMWNySk9tSXFYMEUvVkxyekJwVTdvNVE4RTJlLzA3TjJFM21iRzd6?=
 =?utf-8?B?YTQzV3lyei9KZzdOT2pROWtObEpuWjRiSis3TkQyVGY4R1ZvN1J2cm9IUHl6?=
 =?utf-8?B?RGhpMHZyZ3h1b0hLcVBnbHRPcW4ySkxuZWRDcjRkdXc1L3RuRitRWkFKbVd2?=
 =?utf-8?B?RVJndjFLM0NmNFFiMWFTN2RRZy95RWhLMGZOTllxS0sxSitQYjJnSUx2MEFv?=
 =?utf-8?B?MUZDVzQyYVhOOHhoa3BKcEdUTE10alV3S0dQYW1ZejNiam1QL1ZuRVUzSXRp?=
 =?utf-8?B?ZGxxTU54OXZJTk9XWjFueTZnc25pRXZGSXVMbm1Ub1l1aitCVHF5SXpib1FP?=
 =?utf-8?B?ZnNac3QvNVoyK1krRllvSkFlTDdjYWFpWnBucWpDME95K2piL2g5RHA3eDZv?=
 =?utf-8?B?OWlZSmdFL0hGdmxZZFFGbWdYc3pXb29NQW15RFdyL3BZc284UHJpaDdDTk1M?=
 =?utf-8?B?R2I1a0lMZU4rMzFKRFNwRHdIRloycUJ6Mk1aMDNkR3F5NlZReWhqa3BEanY0?=
 =?utf-8?B?YXBYcmNBRHhWS3pxNzF1KzdON3BGRkRIUHcxRWhOV29tTS9UTjdKRWJkU1pP?=
 =?utf-8?B?a2JDSit6RmtyOGVoTVp1dz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TVBsWXBjZEdDR1VVNjRiZ0FsTk9BeUVMWnRZbHdiWTZLdWFqTU1jTE1jOHRS?=
 =?utf-8?B?c3VXNkVJd3F0Z3pFTGZrODJSUUtZL0FFYmQyaGRvTG5Nemo0eUhHV2cxYTJ1?=
 =?utf-8?B?UWQwNHc5UDNDaEpwR2NLeDk1ZWdrRlp5M2xnUE5SS1pWNnhoTVB2dTVTVDV3?=
 =?utf-8?B?bmxpMlk3bitUekw1aWdaTityWnJacnFOU0Q5OXdZcllvQ3NUeVRJV2VIeFVk?=
 =?utf-8?B?OVVaWFRjYVZtUVVGV1BJV1lPdHZtUDVwMEZ4VXBoRU1yM3JmY1FsTWc5SGRi?=
 =?utf-8?B?OWhkaXBmRTVmdDN6TWRuM3RpR2lmV29tM2hVUmRwZ2hXbEd6bEwwUzZpN1BW?=
 =?utf-8?B?L1lDY1lBNHdyS0JRanptd3pLZHdndndBNGd4aXBVN1dWN2ZjOVJaY1UzQ0pX?=
 =?utf-8?B?clZhRVpudnphbGVzek0vL0VpVk12Vm81VzMvZUx2cG9YZVlBeE1xbkJhcUpT?=
 =?utf-8?B?U0JMU2tPaVRmQVhXTlJYWWlPcHNUZVlGTlFMVldPdTBaelhzbEppZ0p1K0hz?=
 =?utf-8?B?YWxabUIra2UxN0RWaXo4VXFSZmtGT3hiTVVwTVdhcmR3RFN2SWt3V0w4cnhD?=
 =?utf-8?B?eTlBWk81bVdKakJvdHkyWk5rdkE4bFVrMklqZVhYRWZhSVo1dmJXWVhGMmQ1?=
 =?utf-8?B?REl5azluWmJDYzN2Qmh6OEpBTG9Nb1pHclo0cExpZEx5L0xuemhGRFdmUkRC?=
 =?utf-8?B?aUY4dnBVSGRyZmxhY2MzVnZFZ01nS1JwdTZ5RndUYlBMcjBaK1BmQi9TU0Qy?=
 =?utf-8?B?Y1JjcGJEdEJVTkM4aEpqbGJUQzJjSkdETHROVzk0dUJpRHhLR0puMGJLMDg5?=
 =?utf-8?B?cVZNdlRXdU5MOE9lN0VwS0l1bTk1d1I2SWFRN1RQeDZEK1A5WVg4U2U3QjJU?=
 =?utf-8?B?Q3F6WEQ0Znd5ZHFWR1A0K0JMUFIyU1Nmd0FHZWxpWkQvRE80clV4YWlCZERY?=
 =?utf-8?B?VGhnWmpFZVJLOGQrNE5HT3N3czZKRXBQODcyUVBITiszMW1teHVuY0ZscUpn?=
 =?utf-8?B?a2FmTGd2UGxLMzRlLzV6eVRmOTE5SEZ5QVNpbFF0TzlabmJGZ3ZuWVNNdi9v?=
 =?utf-8?B?TE8wNENNM1hmRWJVWTZUZFdzTVJXQnQxWGpBVE9ubWIwOXRibDEzQlRpSkFG?=
 =?utf-8?B?ZXdXMHFXbmppTjVxNTYyQ2F6UXdvanBTcVJkZExhOU80UlB4T1ZSendDUjl4?=
 =?utf-8?B?WEJZU0Q5M2tua1Btb1pKdjF1THFOWFhHMHRoOXA5TTcvZVA1MEhTNEpnV2J6?=
 =?utf-8?B?TTBjSjJoLzNhdGdNM0lKWUNDZTlKVUxpWXhMWVZnazFQQndmdm05VVcwWWow?=
 =?utf-8?B?Zk9MRFc3dzQ4dlRtL0ViMzh1N2FIN2U4RzZ6SkxUbURscUlSOWFJeFlweFJ0?=
 =?utf-8?B?UnZ6elQyNEdTMTFvMDZVWXhzZGZBTkdFeDIzRG9NcDZSR2RIWDdBUGQwYjNv?=
 =?utf-8?B?bDBuRjJXUi8rZVRVTnBkTTRtWjRvNU1NTXVNNU5JOXpra3BtYmk3S0EzK2JF?=
 =?utf-8?B?cjEzWHh2REFubGNQakhPR2gvb08zYUVabFhwelkzb0xrUjd6dUdUODUxUG5h?=
 =?utf-8?B?WDZhajQ0WXZiYjZvaFR5R3ZHK0Nhb2tnOEYxT3NwYUVOVDNuWHRTN3Rzdy9R?=
 =?utf-8?B?c283OVRsbkdCZ1lTT3YxV005WFNHU09pbVdjbGc1TDBVaktWS2oyVHBEZ25k?=
 =?utf-8?B?bVMzVUhKRkN4Z0N3WWlrV2h4TUFtbXI5eUNNWjl2NllEeDdNOCthbkpYTlJa?=
 =?utf-8?B?dkhTS29DWFpLZ1FSc2EvRDd5ZVZMZStFSVVnMUNyWVE3RlhmK0lYaWdCZEVs?=
 =?utf-8?B?WnFndGgvWmtTdkNOaXNTMmRkRW50ZExwNlVxQzkyem9Vd3lFUzlna2hNVlRs?=
 =?utf-8?B?aThLUisrWDBFT1d2dTJjaHhlVVk0dmQ5V092T2t5andXcFZteUZXQTJuc2Nq?=
 =?utf-8?B?NmlpOGp5S2g5MGQ4dHdXdUw3ZnNzcWVBN3QrQWxqQVJQN0o2V05ERkYyWnZJ?=
 =?utf-8?B?QUZqTEl6TngxWGxVNitLTXFycU1GeTYzWGwxNTN0MllTNHBheHFycEY0US9R?=
 =?utf-8?B?bFhYMkR4UVJXdkp1aWxMZ0RDTXNZaEt1dC8rSnI4WUlLeHRBZWhWY0RFMEVn?=
 =?utf-8?Q?hCtlYiwxoDGgSoEvBrIaYUXAx?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ae3f246-f153-492c-5046-08dcb83545ad
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2024 05:36:52.4734
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C2BTqB5WxNCkcT6XpZ2okYScGPgSnA7nMd0XIDudbaDCqDeJVXtnjE97AjpQYP2bMHVF7Zuw22VKmmJ/t3Lncg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8231

Jason,

On 8/7/2024 11:59 PM, Jason Gunthorpe wrote:
> On Wed, Aug 07, 2024 at 10:22:00PM +0530, Vasant Hegde wrote:
>>> Needs more words, maybe even two flags?
>>>
>>>  @IOMMU_HWPT_ALLOC_DEV_PASID: When the domain is used on a device,
>>>  with no PASID, the device will support later attaching a PASID as
>>>  well. Some HW requires a specific domain format on the device to
>>>  allow PASID to work.
>>
>> I will add this.
>>
>>>  @IOMMU_HWPT_ALLOC_PASID: The domain can be used as a PASID. The
>>>  domain attached to the device must have also been allocated with
>>>  IOMMU_HWPT_ALLOC_DEV_PASID.
>>
>> Why do we need this flag? Previous one is already allocated PASID capable
>> domain. Is this similar to SVA domain?
> 
> IOMMU_HWPT_ALLOC_DEV_PASID is the flag you specify to allocate the
> domain you will attach to the RID
> 
> IOMMU_HWPT_ALLOC_PASID is the flag you specify if you intend to attach
> this domain to a PASID
> 
> They are actually different operations from a user perspective. Today
> every iommu driver implements them with the same logic..
> 
> So I thought perhaps they should be seperate, at least if we get some
> really crazy HW down the road the uAPI will still work. uAPI is a bit
> more tricky because you can't change it.

Oh yeah. uAPI is always tricky. No harm in adding extra flag in advance. I will
update the patch.

-Vasant

> 
>> @Baolu, Do we need to make any changes to intel driver?
> 
> I think Intel ignores this issue, they have nice HW and their RID can
> use both of their supported domain formats in all cases.
> 
> Jason
