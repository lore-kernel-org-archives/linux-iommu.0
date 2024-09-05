Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2088.outbound.protection.outlook.com [40.107.95.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2793885654
	for <iommu@lists.linux.dev>; Thu,  5 Sep 2024 05:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725514347; cv=fail; b=czE0s+/zauq6rsMJivhvXLUx08/Xa8YM8Wq2uGOPNkwXwAJJKvnOIfysRfXY7ulr7GJqepYGTBfAHqhiXVESkJHbRNULp+MulGTux7/SNwlxCRzINaGNogmC9eOSI+ewkvscVOwW/W/Jdqo7tX/uCIrmo3dBGPKj5njVDKioiBo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725514347; c=relaxed/simple;
	bh=qUASLrcJloDydFmWiuo047UOB/wJN0izSnRhsE9EZsM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tEiWw+pEMTDBhE9VKEd0t0Q6lY2iP+km3VuDdCRRegyxpCCB7PXM4TA0DLO3j+PxyZd0beaxcg2iIDFxWlyiNqVQO3iqX3wB6WPPFu9xqFmi7geQ3F0GLjbwsBpu+2/G5r1qtP/wX1oNHx0GJ8RkaVb9EAvMw12x7yEWWmGAX4M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ReM9udFT; arc=fail smtp.client-ip=40.107.95.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ReM9udFT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v+IvIS9KH1Joqob3lm3JPSeQ/9WKG5mizD5ARDds233dBwWKJcnR+XgCRBcULpBRjtchDmaks8Y1Iuacrh3qQpvvm9c7CBWglemX15NoRaeLMGbqP+NuWJefxUVEi5CNv4Y+vQkgoXZcnHojaOFtHxX/EwVZf1Djdlc/sE3pXJXEQaLsgj4n/+kS/GRMC0hKlAUNdl8uaz1WBIPzP+XAHXfVx/OiasfKLVSl2js4XSn5D3EmgD3YKJtqcxv53sdobF3cWPi1Enl4PXxhn5V8fmqYuRvTzKm1NZeG2UQD0Ka+SQ9+aX1Xordqdo+kwTRKZSYEw3INekKFb8b7AdwhJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5QVQAUSJzFY4MI6GOYu3BXsnkfQ9RdXUbEKIkxRG0KQ=;
 b=Gff4/jNaV0l9R2ZbfUrK5idIbTRdnYWwLO28g49/d0sauBZYNvgo+NCkztMg3cd15te39tQ83056JeFiIebwNEDIdVakfhX6/xwk6ciVKGhlRCXaJOn5OdzcTwFVSzbIno3gm201frkqQ5jrBa3McpY/j90Dnm6KkLDMzGB4/+h8QW3Uhg48prazeGQPAqPJ3uUYeB91duoBx4gWeJkcTGDkwwsW34y/HItrDScEStZn7L6s2aBFj9I4y0z+IeaezGhkdH/Y3i5sgr+/EAfTjOclTSu0qIwYkJBP2AtIm0xTB5wY1agQxbW8X7XDQzBdGQ+im9bxveFAScMNcFd18g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5QVQAUSJzFY4MI6GOYu3BXsnkfQ9RdXUbEKIkxRG0KQ=;
 b=ReM9udFTGcTmw0+LXkHGLGNcK4QF5oRmMtyz1qt23XII2GzdzWjT9D5y2+UxH4Boxo2K7HTl1B4YtJ7q2b5NIp5Rh5hs3YF2kb/1hzHQdkjev/V/tux5LTF5/Mu/CEcDWbS6sUg4VWMW7TF06BsjMhev653BXAZsIK7+y8h/cn4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM8PR12MB5445.namprd12.prod.outlook.com (2603:10b6:8:24::7) by
 CY5PR12MB6645.namprd12.prod.outlook.com (2603:10b6:930:42::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.27; Thu, 5 Sep 2024 05:32:23 +0000
Received: from DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::a544:caf8:b505:5db6]) by DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::a544:caf8:b505:5db6%5]) with mapi id 15.20.7918.024; Thu, 5 Sep 2024
 05:32:23 +0000
Message-ID: <1d759c12-ce5c-49bb-b3fd-cd17993014a7@amd.com>
Date: Thu, 5 Sep 2024 12:32:15 +0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/5] iommu/amd: Use 128-bit cmpxchg in
 set_dte_irq_entry()
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, joro@8bytes.org,
 robin.murphy@arm.com, vasant.hegde@amd.com, ubizjak@gmail.com,
 jon.grimm@amd.com, santosh.shukla@amd.com, pandoh@google.com,
 kumaranand@google.com
References: <20240829180726.5022-1-suravee.suthikulpanit@amd.com>
 <20240829180726.5022-6-suravee.suthikulpanit@amd.com>
 <20240829194046.GL3773488@nvidia.com>
Content-Language: en-US
From: "Suthikulpanit, Suravee" <suravee.suthikulpanit@amd.com>
In-Reply-To: <20240829194046.GL3773488@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0020.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::6) To DM8PR12MB5445.namprd12.prod.outlook.com
 (2603:10b6:8:24::7)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR12MB5445:EE_|CY5PR12MB6645:EE_
X-MS-Office365-Filtering-Correlation-Id: 073c3814-f0da-48ae-00a0-08dccd6c1e4c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OUdCcVRmSFBBTU0yRVBYNjRTdEhPSkd5OGo5UHRKQkE1RmF6MzV1MFUwRDh2?=
 =?utf-8?B?Y3dtQlo1aHhoOWc3TE84Tk96c3U1dUNjaGdsRndWVUt2SnZmMzU0UHN4WndP?=
 =?utf-8?B?eXpndXRSYWpuNmwvVDZpSHZaMW10ZVpSR1h1WHdTQ1dJWmZ4ejByNW80L05j?=
 =?utf-8?B?R2VSNTJQRHRDRnN6S2ZLOW9kNVVrcGM1cXc0MWduZStiMG8rdTlLYVFLS2Nt?=
 =?utf-8?B?ajM0ZXlaeUVIVll3M0sraG1IMmRtK2cvem0wbVdNUndCdGpTYXowVzdkWXBj?=
 =?utf-8?B?WDBIaVhNY0dhMldvRjRRdXZ3SW9vQTlQUld6UmhidHBxZitRb282bGR6aDRl?=
 =?utf-8?B?Z3I1elozUWdQTE9aNXlYaTFJcGJtbW9VWWZJRlJMeTN0SHVXTkQ3TkRKQnUy?=
 =?utf-8?B?T0x2bnMybXV3WXJYZERpSkxpS3hIbUY0eWxrcWZOZCs4ZTdYak5yMVhmdlcv?=
 =?utf-8?B?Sjd2NUU2K2kvVm5ZOUcySWc5OGdKL1dEQStFMXBXM00wVDMrRXFSYk04eU00?=
 =?utf-8?B?RUxSWDFybmFuMXJzOVJhRVR4cFFEQnlReUFRMmJ3WEx5bjZ5V2hPVHZGTVlx?=
 =?utf-8?B?SjlnN3RFbmhBbkJOUi9IbDVBUXZFai9iMWNac2pabXYwTVluSVZ5VnJqSUZQ?=
 =?utf-8?B?YTlaUXF2aGJqcWRIdHh1d1ZvRDJtRzZ1WDlQTXVLdWl2KzByRGpmUlFLRkcz?=
 =?utf-8?B?cmxPZnlBNXN5UkVjMW4xcWRtcktWdVpvN1puQVpRU1AvQS9meWZwTHBwWkRW?=
 =?utf-8?B?dDlWWitQNC8wMGo2bWl4WEhIbHBFNU1XaUhYaVJMak1xbndFaThQVmhxKzFP?=
 =?utf-8?B?SHd4ZFJXc1dycEEwQWV5eFYwMkc2UEVuUHZRUmRQdXZZWFJma1FHN3FaK3dx?=
 =?utf-8?B?a2h2TlFPRE9ISVJnMjFJYjZYZzN5bGEvTjBnNHRWRHp1MkZ2emVlMjUwT0Fp?=
 =?utf-8?B?WGxWRHZWSEhlVmpIeUhCMUpScm9OZDY1TFE4Nk14QllYUmRWQ2dGOHYrQlJ1?=
 =?utf-8?B?eUlrV1ZWWW9yMldDVyt4a3dnZVY2a0hYSldBR3ZKWW1jMmdkTk9nNDZXOVQy?=
 =?utf-8?B?VXE0akIwVTd0Qmd6azZqTE8xWUJIKy9rK082eFhxV2FOYjJTbEF4M3JrWFZY?=
 =?utf-8?B?ajU1czFsTDZYeWpsVG9GWnAyRW9lQWhBbUFaOHI1UzJZdERFcmpHQnlybTVD?=
 =?utf-8?B?TkhTNGtxMG81dFd6REVQYVA5ODVnTE5OYXBwd0dVU3RkMGhnVU1lOTcraHZB?=
 =?utf-8?B?VXNlOTJiSGlDSlRIaW1mZ3dURjQ2WnRVS3kzSGluT3pzWG1SS1hzZUhFRW1y?=
 =?utf-8?B?RitYYk44Z2JVR1EzUVE0V0FZeGRUMkVkb3FNMExLZVFCVU0rN2xTdmtvUGF2?=
 =?utf-8?B?SWh0ZjNBeG9tU3o0MXF4MEZUS09sQ3BUTlBKcE1HTFN5eGtIS3dKTGZrdFdj?=
 =?utf-8?B?UVJtVklTQ0ZvU3htczREcTdJK3dXUWRPR2M4UEJNZkV2VkFVMEV0NnpkdGRJ?=
 =?utf-8?B?TjFJSTQ3U1FhSTFzZWF6Q01XSmtyTStoYmJTTVlOYTZzVWY5b2FVWGhRVHdC?=
 =?utf-8?B?MXlEUUIwZCtWa0xMTE9wWkdwdzdXWVlzOEZkbzVya0pVVkpIdm55ZFhSbExx?=
 =?utf-8?B?VGRsd0ppcjExZm1scDZNU2MweEtNRHhaV3BsMU1TU0haQU1rcExDaGt0Skpx?=
 =?utf-8?B?dlpYRm9SYUgxYVNUL2pPSTRNOFU2T0hnRE5URjAybE43blpZZmUvVC9tVDJh?=
 =?utf-8?B?Mk1kc01tZjh1VEZiY01sdFBORFNlMmwzdVdiam01YXJ0ekFnZXNHdHVCQWp3?=
 =?utf-8?B?WWFPK1RyRzdoNFNtRzZadz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5445.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V2REZGJTL0hxbGZyazd3aXN2ejJsL29pU2RoQ3NKL3pPczdhMkMvOGxKbzJC?=
 =?utf-8?B?OFdrdXd0RVlSdTJTbmxIOHYrNk9IYVB3ZVVXVnhPMzFpQ3JLUGpieU1iSUlx?=
 =?utf-8?B?cVpBSVlmVmFIc013ekZMcER4WURqclpsdkMrN1VJaTNmRllJVTVjYnJDWWpu?=
 =?utf-8?B?RjJWV3hldmJhZGJHL3FPOWQzaUlJNDhmWGRqdDR1VEI3M2NwbGtXajlIM3p3?=
 =?utf-8?B?NFNPMWR2SXkreFg4cDBMWWNIZFVsTUE3azRnS212d0Q3Ukxia0NzUjdDTWx3?=
 =?utf-8?B?NFRnZjVnTFcxNTYwNjI1b1A2dkI1YlA2VklxTTdYNVIvTFhjdTNlck56dzl5?=
 =?utf-8?B?dlVhNFlCbWtZc1lwYlRwdFJvbHNISm8zZWk0N1FaOGdaZm5jK1Mvc0NvN0lj?=
 =?utf-8?B?N3JYZFhOZFNDR01laUdmRlhqZ05VOUJHZnJSVUpIN2QxOU80UVAyY09PUmF1?=
 =?utf-8?B?UjB0ZUhNZHBmeGV0Nkp0eE5NU3lKUWw3WjhScVZQYWVuSTAxczBHL3dXaGNM?=
 =?utf-8?B?R3VRam5scW9yS1laUTRmV0R0VFV5SUpXeTBreEQ2VXFTWVFPZHdKZldVeGZJ?=
 =?utf-8?B?LzNxZnRWUVltL3ZoWHl2NjBkV1FMWjF0SnRuM1hwSm5WTDFvS01TaHNBeXhI?=
 =?utf-8?B?aVFaeGpKME5FM0lzdkhFbUtJanFpSDhsY256bllSTzVmTFBLQ2hGczh4OE1E?=
 =?utf-8?B?Ujk1ZFJpbVBNeGhPcXZGYWpBOEhmK3lnNFNwYy94TDJGUnozei81YjV6Tlpa?=
 =?utf-8?B?SUdWTmlNamx1b1MyME5VcDJCRVZDTk9FYXFHY2lhaU9oNUxzWWZLYnd5NlUx?=
 =?utf-8?B?VXl2bmhVSEkxN1phRkdzY002WTRzNzYrZ0JrWFYxNmlZS0tmOTFPUzhmRHRQ?=
 =?utf-8?B?UGhQQ256SlBMQXI3c3AycEJiamJzUHZxU25IWS8zcURqSEUxWU5OMkthQW9r?=
 =?utf-8?B?N0p5YVczdU5LY0lWanIycUJhRXJYRUYyM1FuN0RSWlpoOE1sZEV4bkNYL2pP?=
 =?utf-8?B?eXBOSWNNN1diaG42L3FENTVpaEd5VkdZc3RJME43UHNWcVNqSStqNStPaUlK?=
 =?utf-8?B?L2kyR0Y0UkpKZXMxOURjT1RCNndvTFlWRGFXczlVQTBCQmFJZWdwRlphNnhC?=
 =?utf-8?B?M1VnbFlzdEl0SW5VaDVCMTRsUVZBazRZRjUzdEg3L3BXbkJNL0c5Vmt5UkZq?=
 =?utf-8?B?YjNDU3dpc2hINm1FenhBRHhZWUE5blFLZDBweGp4MXVWSUxDeU05dUFMaC9K?=
 =?utf-8?B?VFVYeFZjdmlNRExqaWRHNHlTSmdYMVFrV0l5L1V2SFlGbWd2SGRkZlFDUzNE?=
 =?utf-8?B?SmNneWgxejBrd1hkTGhqQnBVdE9WLzMvbjZXVnpCaUFSMjA4VGVpWllVeEpU?=
 =?utf-8?B?RHhYaXpRc3hvSnJCa2F2Z1FzS2o3QzQ3NE9wdkV6RUVONzAwMTNvQ3NCeitv?=
 =?utf-8?B?RTJSa0M4bm1JNm9OaDRucXNWeFJZbm4xUjhzNjhJbjYwVWk4VzBlWWx0dU9O?=
 =?utf-8?B?MWdzeWZwSWpVL3B4YkRKanFtMlA4Z1U5c3ZGUGZYa2l5emxnWjZmS25VcUxC?=
 =?utf-8?B?UC9jNzVZRk1ZQzNCTUhqS1pDR1BEZjJ0WHpzbTFpQTNibEFmT0Q5WGpQRVVq?=
 =?utf-8?B?YUxyS09XTDMzOGFZRWZic0I3U0hGR1dXNTNhYjVPQnFBMzNIY05tdlRSWklJ?=
 =?utf-8?B?TFpLdmVnV3Z1bE1xZjdEbzJJRGRTZ1JBcTY4a3BlZUVNeXplWjBZNnVkaWdN?=
 =?utf-8?B?aGRNMGNEdUlDRmlxQU0wRHBEekVRc3pvTGE3c3M2c05mKzZwTzl3UWI1ckMx?=
 =?utf-8?B?bW1vUG12dUlxSlczczhRMDIzbVpKb2F0bG53eis5WXR2d2YxYU1KMktlYkRP?=
 =?utf-8?B?Kythdy92Q2VEcm85R0JPWkNiY28rMDViNHhGTlRhZCt3dEhmNEhQeE1UVEZ0?=
 =?utf-8?B?UkVFQ25PMXJDSTd2VXc3MmxCdFM0Z1NkWDlhaFJxdys2MkxPWGxKbW53Q2JB?=
 =?utf-8?B?OEtDRjZ1NUowakQvcVQ4RWdmZGJDMkk3NzJjTDlBQXdHUVVYTithUnJuTnBC?=
 =?utf-8?B?T0RkTisvNXJJN204MTJCaTA5MFh6UDNhK1cySTRvaWlXVFJoY3FGMUNTWlN5?=
 =?utf-8?Q?yD/xr85spuJwdaCZpCuYfdsBd?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 073c3814-f0da-48ae-00a0-08dccd6c1e4c
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5445.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2024 05:32:23.0379
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WN4jWuSan8ci2Tl+lzmKmYFT9gEWLHsHjGpLasrmpLyvDj47F0Qbaf1W6z8BSKIROHcSRhaLXN8tB57oI3NoAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6645

Hi

On 8/30/2024 2:40 AM, Jason Gunthorpe wrote:
> On Thu, Aug 29, 2024 at 06:07:26PM +0000, Suravee Suthikulpanit wrote:
>> Interrupt-remapping-related fields are in the top 128-bit of the Device
>> Table Entry (DTE), which should be updated using 128-bit write based on the
>> AMD I/O Virtualization Techonology (IOMMU) Specification.
>>
>> Therefore, modify set_dte_irq_entry() to use 128-bit cmpxchg. Also, use
>> struct dev_data->dte_sem to synchronize DTE access.
>>
>> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
>> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
>> ---
>>   drivers/iommu/amd/iommu.c | 25 ++++++++++++++++---------
>>   1 file changed, 16 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
>> index a24986c2478b..4eb53bd40487 100644
>> --- a/drivers/iommu/amd/iommu.c
>> +++ b/drivers/iommu/amd/iommu.c
>> @@ -3020,17 +3020,24 @@ static void iommu_flush_irt_and_complete(struct amd_iommu *iommu, u16 devid)
>>   static void set_dte_irq_entry(struct amd_iommu *iommu, u16 devid,
>>   			      struct irq_remap_table *table)
>>   {
>> -	u64 dte;
>> -	struct dev_table_entry *dev_table = get_dev_table(iommu);
>> +	u128 new, old;
>> +	struct dev_table_entry *dte = &get_dev_table(iommu)[devid];
>> +	struct iommu_dev_data *dev_data = search_dev_data(iommu, devid);
>> +
>> +	if (dev_data)
>> +		down_write(&dev_data->dte_sem);
>> +
>> +	old = new = dte->data128[1];
>> +	new &= ~DTE_IRQ_PHYS_ADDR_MASK;
>> +	new |= iommu_virt_to_phys(table->table);
>> +	new |= DTE_IRQ_REMAP_INTCTL;
>> +	new |= DTE_INTTABLEN;
>> +	new |= DTE_IRQ_REMAP_ENABLE;
>>   
>> -	dte	= dev_table[devid].data[2];
>> -	dte	&= ~DTE_IRQ_PHYS_ADDR_MASK;
>> -	dte	|= iommu_virt_to_phys(table->table);
>> -	dte	|= DTE_IRQ_REMAP_INTCTL;
>> -	dte	|= DTE_INTTABLEN;
>> -	dte	|= DTE_IRQ_REMAP_ENABLE;
>> +	WARN_ON(!try_cmpxchg128(&dte->data128[1], &old, new));
> 
> This probably doesn't need cmpxchg because it is only touching 64 bit
> quanta [2], just a lock is good enough and avoids the "what to do if
> cmpxchg fails" question.

Okay

>> -	dev_table[devid].data[2] = dte;
> 
> But this should be
> 
>    WRITE_ONCE(dev_table[devid].data[2], dte);
> 
> Beaucse it is writing to memory read back by HW.
> 
> Required for all the DTE touches everywhere.

Good point.

Thanks,
Suravee
