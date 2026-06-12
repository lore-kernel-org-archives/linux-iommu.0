Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011012.outbound.protection.outlook.com [52.101.62.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1B39339844
	for <iommu@lists.linux.dev>; Fri, 12 Jun 2026 09:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781257939; cv=fail; b=mUW5jaodUKo46LXDDa437lhUt4TFS4bWcDkkSjVm7ObQILbCKQiD04TbfbOeZXuHBJL3sACpxOgddNzxwxyOalTQFV5v5+thSg0DlH6Uczl36Hvj42WssteSbXrZwBQUIZHwIn6ZSngbZFXi3RGqjqVfX687DfOcmZAyH/VJeuw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781257939; c=relaxed/simple;
	bh=L258vKTjBRrQGIoSLg0wsnA78nrHXUYm5tRgwDiAzEI=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=leMPYyY7lVWqKaNP7DprsYLoe4O10ue1DZEETbTbozuFp3dzSSV6IkEv+uH1KgVl1ZKcDKWa5gw3CLe5xofZBOTqt5hjjnN/VlS8kdqz6KJ6f33uwkOZJymDqVGrixkJwcnwxkhrcJRE3WAFTgRwNs/yiHHbD+MJi+9cr3/tVJo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=f907VpZx; arc=fail smtp.client-ip=52.101.62.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="f907VpZx"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TEL0eelGBe8ILUHXqX+KIY7Lkm3hSSlKqp+snC2M8ElXDpS6gU9bUw0m4cUup8yWOSAeKoTH6e3Fgg94dWmp2UX+wiZT5LhYV2OZxY5YchUEydM9Iu3D2xkRycq71Vayg9ZZufwpOOVL4rQuI0Crc+mzmZnJGoHPKvixirLoaY2jLgb5oiGczOiTU1g0iT1s2OgIEWqgtxgbvcrsKwZjJEWv+ZVkTj+7RlB4+pIg5YMjanxYYT1CB9FSuucDND+FodhrXy7U1nCUsTd0ihyKIMfrr7kTZPGJnLTIrwopiflRIm1CIQjMa+EilxqPv8g28dN/r3FIt2vSoAPjQuVjYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YASluoR3yWqTndSMkLUAWLr+TtPFRQY8pWZ1ahcqYCM=;
 b=kTej0pqFRlZT8jhDGBRwy5qIAh5yZYnrXbmMBwmZGLxZdQpd/6eLTG+GC9ecmsPCHGTU7Q+kEFmIQeK4Q+xS0LuewXmqtSFPflnY98bQT7bwX5h1gHngQ/aO5rvZUzfH4HLSxzGine48+V6tDPwVAvxeehsJ7dxV8JrNvQz1pzLDSGUuByddEuXdD7W3TI1YSpaxiHDUHfLv2c+zf0/ma8Lj/iyy4rYs/BPRqXVgbeY5nQTqjgjRhANqRt5iQZVqKeQ2Vf1kaOnynMY/WFXlk0LEXMgbeeDb4TtxPB1gmeQUNsluz5ZDKBZUyoinGwWIAHK1cVNkcBb7hdc/xYkCjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YASluoR3yWqTndSMkLUAWLr+TtPFRQY8pWZ1ahcqYCM=;
 b=f907VpZxYT7wgF6vcNKOvNQd3nZ0i90hwdrtr6er9sGgFaW4Ff+8ypvqBgykDRMY7mTwRsLrI+Ixs1efOBqX2VD0Yr4bMUylDaaDmtEYWFASjk7v4cBQMouVj5q0k04+3rPo+ttMGMS6M5YJ/g/TxrJ0Fl6Izgqkd25B7UI0KE0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB5766.namprd12.prod.outlook.com (2603:10b6:8:75::12) by
 PH7PR12MB7115.namprd12.prod.outlook.com (2603:10b6:510:1ee::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.14; Fri, 12 Jun
 2026 09:52:11 +0000
Received: from DS7PR12MB5766.namprd12.prod.outlook.com
 ([fe80::222:966a:d65d:d08e]) by DS7PR12MB5766.namprd12.prod.outlook.com
 ([fe80::222:966a:d65d:d08e%3]) with mapi id 15.21.0092.017; Fri, 12 Jun 2026
 09:52:11 +0000
Message-ID: <95921d73-f108-4383-88b5-e706f10da047@amd.com>
Date: Fri, 12 Jun 2026 15:22:05 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: AMD iopt levels question
To: Jerry Snitselaar <jsnitsel@redhat.com>, =?UTF-8?B?SsO2cmcgUsO2ZGVs?=
 <joro@8bytes.org>, suravee.suthikulpanit@amd.com, iommu@lists.linux.dev
References: <airgbnJLPm3tnNig@jsnitsel-thinkpadt14sgen2i.remote.csb>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <airgbnJLPm3tnNig@jsnitsel-thinkpadt14sgen2i.remote.csb>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4P287CA0108.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:276::11) To DS7PR12MB5766.namprd12.prod.outlook.com
 (2603:10b6:8:75::12)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5766:EE_|PH7PR12MB7115:EE_
X-MS-Office365-Filtering-Correlation-Id: eef6637e-98b2-4794-1d8b-08dec8684627
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	4eJr2L3Y60wO6gtyLMabHkin7YqYAS8UcFNdPbQNbVe6z24fbG62xvnsSbq3ePpBK0JFsL6gxcKNMCHmblO+aI8SnqvITjPiLu6rw4yonINkRWrOJYYaTod6bZkNBXcsIEGpq1+LBtGKeMvxE5v0/NXbDsFWCbdTR2XtJpIgKWkB3H0DwUUpGA7UyPglC0oIb+mSaEn8S2HQ5Svu3gXzDgNphSbOVMXI/c03jOwfczLdluTgICQYIewoy3+klOZbkXvcvGvMRj3N69maQapBgJUdU4x3L39geLTjQjYCCm7jKe/QyhZ9SNcy0LOH20830fOV4WpWWhVen3qTgSxzVM6EBIgk9FhB5RTSvACP21kCQ+6S6sHCOgPd5V7bDcaMrnjpxqZXORB8duAKdx6sdKrX+IOv+d0YyeMBThDThW733iUtMim2N2V5MtkJTLRa6uJnXMjdTFSjpFHSDUZ3R4OxNS5wUIZCehboQ8X0NC9iEvl9DYMnmfkGSamlNWuvukX09SoYUGIYnIT9nPr+ZeLWZdtmgjD4KmeeRsVMGrDcsP+ZOXDeDwY9hnIECUdmCFtP+aNIrDxtr2DFPCjXJZlY7aVdlKNYzm+JAuu2MTfZbDMWpkX/ChRpgO9ZLZp7ZAgP/frblkpF4S00U4Ef0Nx+cuPSc/vrcG8Nw8wgkXSvlOhpEDNtKknAMK7jTbrL
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5766.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Mmc5TXdkTkxrVnd5NFFBdlpPREZ5LzJCQUV4TmdlUHczRXl1WEpCeHZGZmVH?=
 =?utf-8?B?bEYwdjBQR3lGSFVFSUlDTHl5YjM3RXhmYmJCZnNHOElSZzlUbitOc1JhNGw5?=
 =?utf-8?B?b2k0c0YwNmxoQWRzbkh2VE9vNjNneHI4NDQ1S0pITmdPYksvbGpSeUxPMWw3?=
 =?utf-8?B?alM2TCtBRXVoN0xtdXdUSjIyME1qWko5YTV1d0dCVWxEdmY3YkJxK2JCVXJB?=
 =?utf-8?B?SlB2WGlIN1hNd011WXI5eXBhd0dLVmhOSlRtcVdOcEFvTnE0ckF2YnE4bWZR?=
 =?utf-8?B?ZnBBa1pEa3BLT0YwbWJ1VEtnWUNRaEpEbWNYUzhkM2FxdkNDVmhXeVZ3NFVq?=
 =?utf-8?B?ZEYxY3p6ZE5wYkhBKzBFZSsrOUhtbEFDNVdHL2xGQm9jVWhoME1lWE8zSFB3?=
 =?utf-8?B?MVlLQ1czRUcySGppZFVLRURRemNwb0R3U3BuV0c3M0dSUmw1WXB3cDErMTBr?=
 =?utf-8?B?dW52cVlGOVMxTGtZZzdrTHpVRUFXbmRJZ2pPZzc1cWEvUjFNZjQwNlhVUjNp?=
 =?utf-8?B?cjBqN0s3eFFrai8zN0ZjMUFTUTU5dzZsUWszMHdSTXQ5cjVNdW1MbWJ4Znpj?=
 =?utf-8?B?R3V3UWhSSlE1QWFPVWVrdnhpSnIyQmJFSjdqbkxNR0pUaGMzUWVTeWwyRGo1?=
 =?utf-8?B?SlhMb0R6VG1yOVR4SCtLNDFKVy9SdUFxcS9wbHZCWjV6OHV2U1BZbUpTanhx?=
 =?utf-8?B?MDFjMTc3NGdQeEUvT1BvY01Ua01sM0FOM3JGSlRHNjVUUWtVVFE5djlScDBN?=
 =?utf-8?B?U1g4ZTVzUVVSTmxrMmx2S1BMMUJYQlVRMFduUUpBcmJyT25uK3pmNVUrVXNp?=
 =?utf-8?B?SE1rRmtuNjZFWUJETlpkUk9ONmZFVzdLa3MvRTVEREpLNmJHTE1vVWx1Y2tE?=
 =?utf-8?B?d2xmdzQ0VFRYVld4UmZ6WW5aa2s1aERvY3VCakkva3RmWStjWXpqNm1yLzBz?=
 =?utf-8?B?NnV2YXRaU1IrUEFRaVU1NGhzdnBNY1paMnRmYjMxQUhpbjdYN0wvVldzYVB0?=
 =?utf-8?B?Y3ZpVEtyVVlyaURyVUlnbGhJZkZUU3hNcUlxV2VReHl2bDhWSHB3QzlhRUFr?=
 =?utf-8?B?d3dIZ2hZVTdTNlVKSUtRUXNPbnZiQXR1ckVhUzlORlRLaTFKbmM1emxyMTVE?=
 =?utf-8?B?eitFL2xqcjIvejcrR01BbWRoRU5UczdsK29lOWdqL1hEQUJISVVzSWRCa2c4?=
 =?utf-8?B?SWRQbW11Y0o3SW5ncWNmNTBUUWgvZFdwM3lCT3IzUTlTUW5OZVo4VVVWMXgv?=
 =?utf-8?B?YzdZcGtTMndHV3VSekIyNFF6dTJjZFBWeFBDVW9nSXc5WnlPc3lIeUtHSVdl?=
 =?utf-8?B?S0NEVDlSWUpFN3JOSGdVMGU1TlRGaWwrbmJaMmllNEFocjVSck1ibE1aUGll?=
 =?utf-8?B?K0JRSFV0MmhoekMyUFd6RGpOeXJ0SHJobWJ5ci92NGh5OFJOOTVrZEFIYlla?=
 =?utf-8?B?TTBQSWRGUW5nYk9vVXUxNU1rZFJiTDN1M2pWRWdJZWJZblZKempSWDU2dmh5?=
 =?utf-8?B?UmF6NmVNOC9ISWJwNzBPb2kxZE0vYlFidWVqWnRnRFcrUkhzci9lTWNEQlcx?=
 =?utf-8?B?alZ4NlJSaE9aaE5nbWRxUkRNUUh3MkVuV3lFUHd2RytpSnVwK0NsR2IzU2VL?=
 =?utf-8?B?ZDZWaVg0RlRrTXkxRk9WMnpGRkV5emZveEtZcStuTitHYnVpZWtwYVMyV0ty?=
 =?utf-8?B?azFkZXdMdFF5QVRUSXpmYzM4ZlFGMVZDWkxwaGdYaXRML2tMTXFncXZGaHBt?=
 =?utf-8?B?L0NwVXppMmdrMDNQUUd5S2Q3VmljQnUrM0ZUQTZza0JIRlhUL0oyNFBtUnFt?=
 =?utf-8?B?aGZFNmlETUo0cmFuRUo4cDNsaTQ1V3ViUXBiMFBqUkZaNjZrRjRNYlhuZ0Zx?=
 =?utf-8?B?VTFjZldWRU4vZkxENUhhQXBabkNQZnhlVG9BdEs2VnNjdnBOMzJJUm5NM29K?=
 =?utf-8?B?WFVObC9aUXp5VTk5VExsdUtiTEc3cElUNlByeVVyVmxzWWtGdTIzQ1BaUmVE?=
 =?utf-8?B?K21pNzNYOEY3YUxHWWR1V2twQnFYR2wyZkJIWS8wdXh5WXQwTUpxRFNwM2o2?=
 =?utf-8?B?dTh4UVdkQjU3OE9tUGFBUEZHUUtVRksrTitPcnY5dGRNSXdDTlJpTHhrMlo4?=
 =?utf-8?B?dis3eFlOT29rZmtkVFhRZ0RtVytBVjFOdlgxTitEZmY3Q2pQSy9DZ1B4cTBp?=
 =?utf-8?B?ZjVjVTE0Nmh6T280ZlZwNUJNL3ZQT3NnVWdpZ1BmWkd0MFF2ZHZ0ZFMydzJa?=
 =?utf-8?B?MjNQS2VrTmJsSzRFK2hCM3A0d25DVUtyZ3VCR29Xc01RcjZUdnBMZnBrMktQ?=
 =?utf-8?B?QVd4WWRiQXZPSCtMalBydmRUMitqQ1NubGNMbE1FRkR5VXBmb3RRZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eef6637e-98b2-4794-1d8b-08dec8684627
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5766.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2026 09:52:11.3762
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Pxnwlo+dr1xYs8qNmCmCr0SxnRT2rfISSN03uz7pChF7lNzoISnA+h833U9mxLANuz1v06Yoo+lAQwer4RmAgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7115

Hi Jerry,

On 6/11/2026 11:11 PM, Jerry Snitselaar wrote:
> I don't recall, is there a reason amd_iommu doesn't initialize the io
> page tables to the number of levels supported on the system?

Its because HW supports increasing level dynamically and for performance reason
we start w/ 3 level.

> 
> I was looking at an issue recently with an i40e controller where
> someone had a set of them in a bond. When it would fail over to
> another device, the device would make a request to map as part of
> that, and the domain would transition into the 64-bit iova address
> space. When that happens the i40e would start generating requests
> causing io page faults to monotonically increasing addresses starting
> at 0x0, repeatedly causing event log resets.

I didn't get the problem. Why will it start from address 0x0? Our default is  3
level. Even when its increasing the page table level, it shouldn't hit fault for
existing maps.


> 
> I didn't have a system where I could reproduce with bonded group of
> them, but I could induce the behavior of the i40e generating the dma
> requests by doing horrible things like throwing a bunch of io at it
> from a remote system, and then mess with ring buffer sizes for the
> device. I was able to capture a vmcore, and near as I could tell it is
> during a window where the DTE gets updated as part of increasing the
> io page table levels, a UR would be sent back to the i40e in response
> to a request, and the controller would start sending these dma
> requests.
> 
> With the HATS support in the kernel now would it make sense to
> initialize pgtable->mode to amd_iommu_hpt_level if it is set? 

Are you referring to upstream code with generic page table support?

-Vasant

