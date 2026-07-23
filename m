Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012056.outbound.protection.outlook.com [52.101.53.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75C83381E84
	for <iommu@lists.linux.dev>; Thu, 23 Jul 2026 08:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784796409; cv=fail; b=b0UoLzQIzhEJ3jMjyja8/naiH0Fm3uBfRN8o/FrHuVEKbz2/JjdU+rinck9aVTnvo3d44Zy5KaKEtnEHcansIWVEqujyHXH+pCpyLh0kzNbOU0ExuZ5TcC+RKkW+8VUuB02q34NIIN3j6jX0wfQIH31BJ9lBrh4MoJ+XUyUj5vE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784796409; c=relaxed/simple;
	bh=/B018qFITJIwX4ijO674XkmuK/4IKled804PcBfzTSs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YqpBxIrlrIMuoMF+q5Uz3k6Rv8JV9uegw39H3DpaiFePI4zadRaNsLBHJuvJvH4YOUa9jNAb1aurl8DZz4YJ+HfsVj5IreGazsaXrg6zgyqnkdlcuUdwFSeqsqDI5rA1QRqSNqQsVNtsgdYbHLchzTOpm5BaDHUitF7BeUmRCfw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=zlxturDy; arc=fail smtp.client-ip=52.101.53.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="zlxturDy"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rk5ET2T8IA/AmNTs9K5axfHHgBBXDdLjHdasxKIa0REFYC89GCFvcrzGtoV274UzNH3qObLA+ObsPnkPxbiMyFnvaclZv1gdTyBbBDE5EQdO5sAB1eCOD/s+SzAlsas160E6xuwefDKVWr/NW6E3riK5RC3Ju2zeGtStR8ER7BmdE79CTSZqSiyNufBysGQR3srUGB0LSGICRaZI369AfZed/011/eTLyJbBZONIM003hKVVVlmhEAQud2QRhF/XZC9zEn8SKhIfoPavPX/p9eQ82OXuyTqsOp5Ziss5EL3kknL15yH0EXGnb9A1v5us8rXLbcmxJ9lo4CQu9+aG1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dW/j7bdhaYNgf5n++fIV45Y+UTtM3ixysk8OC+bfKY0=;
 b=y7L6VIjWFN2sbZFBu3AStGpP/uEb/U0c6v4Y5+4apiOSBlk2IYsMNMiE9zfhdVQsYYvyt2yomLGcpwWIOGGJcTsy5XNdUjKxdzCUwWsN36lLN0MCSUxGwnTX2UClRhcdLSoXbTG2+mPXY5hywtFpAQp4SeS3zxCWilX+cOWCjzEHTWqu50C4N8dW0v4Fz9CsuD1JYjexJk1gxfLVRJyKsmps3dReMW8ZbwGvlz3XYfNB19pnXWdTM74gjFmVyIw05ruUcASb0+GTFG+Xp+KSAFjGYhAeynt+w6TNI2jjsTSal/m/uhzyzgELGPaEvZ3pl1cu8lx6dGvQcML4wB6RUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dW/j7bdhaYNgf5n++fIV45Y+UTtM3ixysk8OC+bfKY0=;
 b=zlxturDyjgD4RTBjkcwKJjY2gFwnfWbeYObFo9PuXCanowzMq7AQPjv+GK/t5ZmSmMeeCTR2xth5XPdsxtELQm0eRTV0VZm5/4s0uNs8J3UpErJd1/v2lqB/4/ziTn4AEe/Kq2mojli0iTgKvWzTpIpY1Nw5q7LNtyhkYKfATKo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB5766.namprd12.prod.outlook.com (2603:10b6:8:75::12) by
 DS7PR12MB9526.namprd12.prod.outlook.com (2603:10b6:8:251::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.10; Thu, 23 Jul 2026 08:46:43 +0000
Received: from DS7PR12MB5766.namprd12.prod.outlook.com
 ([fe80::222:966a:d65d:d08e]) by DS7PR12MB5766.namprd12.prod.outlook.com
 ([fe80::222:966a:d65d:d08e%3]) with mapi id 15.21.0223.013; Thu, 23 Jul 2026
 08:46:43 +0000
Message-ID: <d7ba7ef4-cea1-4a2e-84ba-a0fb85af2824@amd.com>
Date: Thu, 23 Jul 2026 14:16:37 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/amd: Add SNP page mode 0 support
To: iommu@lists.linux.dev, joro@8bytes.org
Cc: will@kernel.org, robin.murphy@arm.com, suravee.suthikulpanit@amd.com,
 Amandeep Kaur Longia <AmandeepKaur.Longia@amd.com>
References: <20260723084332.11008-1-vasant.hegde@amd.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20260723084332.11008-1-vasant.hegde@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5PR01CA0265.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:21c::19) To DS7PR12MB5766.namprd12.prod.outlook.com
 (2603:10b6:8:75::12)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5766:EE_|DS7PR12MB9526:EE_
X-MS-Office365-Filtering-Correlation-Id: 53413f1a-d0f3-466a-bae5-08dee896eb88
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|23010399003|10067099003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	LHMMsgMVzko7f3g3u1zs0MGqrx/UU+1D4Ozj6uXt9dCEZY1r7VUyQMwCyV1HuwXnwHuKsQqjRu8YVltqVBTAXGXEa6dEBwzJ48ju+9wFXaGzO9Wz4sNBO8KuDJ5bAI8tDz6AeVEXOTvc1v49rEkQKDbmW0+5EgPAqE2dr8Huyf716AMHrikVoh9eEs0biS5oKMaQP2xO5tXtTKN2AS9W2o4DEYLoJcv5o/yV7mR4UodnLxhwM5gpWujaF924uHDP2NEfA4k5KhX0l/XTI92IjKcMQXbOSEJa1fUtEEK2q7kUkXgTFojRGL3hlK+qdNush44z1rS4op6LyaYSQPYJsrmBWXaphgTe1SRx2Dj1sn3Fy/RoRtRDg2AvgQPLXhEjjV2+BxfJakh56RSni+FvG3oss0mUvDUv6xLbzros1wKpkZk0Z7frNjjhLech1dzt9FE/uXHH9J99V49Y6ifE6ia/ArLzcQtjh/2HcKR1XrLbibkiEqEQtkyoZzJy5rhQbNUvSeguf2svRcptRIxhWmgfkifiNhxKbZPOs/Z93i60K+kmMPyP4OAVOnLEirueYm/Q+pGp2bXBPvIk0z7LpofIClIY6x5R/ZGZS06myq0D7KEjZBWJXY6DjGBhDlG8+Bs5bpivtyuEYUGWUPSc1s6Rc/LMOiCIfHjmXuiYH94=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5766.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RktTY0kwc1JjdDhzODdQVmkrZTk3RmhITnh3SEJNU0JYZVdSU2FuUTNkb2hL?=
 =?utf-8?B?VmhSS3FUY3BzejBTZldBMk9ZUmltQlhDZWJKRkpnK3pJRC80Y0FMR2hpWUpw?=
 =?utf-8?B?aE5VWERJT1ArRWgzenhrQzQ4d1Z3WmFvcWtZV1VtQkNyWGJJRWgxdUQ2ckFY?=
 =?utf-8?B?ZzNGbnlkN0E3NXJxQ3lpRGY3WGIremc2Z1Vwc3VEVGF0cjM4YnFzYlhLYmUw?=
 =?utf-8?B?SVJMcWVUQ081RjIxdEV4MUJXZFNJWmV2eVlad0xCVVU1MWtsMnN0WkhPWkJN?=
 =?utf-8?B?dTl0TUYyUzV2OHd2ZWsyaEE2eUtURkc5YXFyYlBEOVRPWko5Q3JFN1dhU1N1?=
 =?utf-8?B?US95VzRTdzg5QVdhK0t0ZUtMTUNUcm9vNHYyOHlhejY2TytxdGtNVktvbUNB?=
 =?utf-8?B?TktERlBBZTlTa0RueCtwYTVIY2JBN2N3YlNkSTdIdVNVZTJlWUJ2aDFid0dY?=
 =?utf-8?B?Zm5rUncrbkhtMHdXV1FLbzcwRFJ5UW1WY1hac3dHUXB1amR0Y2FxVkVMUVRU?=
 =?utf-8?B?bjV2NWprWUJ3TmQ4dEJYVDNpS3FSMEhncGwrbWs4d1pkN1MyOW9VNUJ2UUxK?=
 =?utf-8?B?WnVLOGpBQ0RPOWxONEtYOExJTlJvd2k3WmdIcjlZR1Q0aURneDVFelhSWFFS?=
 =?utf-8?B?MEtqSXFoay9IYUF6NVFVV0s5YmdMWm40WTZnWFVtb3YrN3ErL2FOcloxaGdu?=
 =?utf-8?B?UXQwSE9ZblQxRGZRanQ5dWdTUGx3NHFSMVNOYnRnUEp0TllscUd4cjNDMS8x?=
 =?utf-8?B?VnY0MWFjOGJCRlJ5YTB2VUp1bThOUVA5UUQraktLL1pVc2ZZajNUSkkvcmJw?=
 =?utf-8?B?cTBsbTZpVmVYUWk4cFdPcG1YWEttOFRFZ0dGeklRUEt4MUk4WTRWaFlYc0xy?=
 =?utf-8?B?dkp5TEpzZ3NvZGtrZy9DRzY4TCtpNFN2OWV4cWtHYlhaTEVFQThmeENpLzJa?=
 =?utf-8?B?ZHRPRDNLN3hEK2hhTmt0ODNsQW1QeitGWi9CWHI0dnVEci90VTgxOXNOdlpT?=
 =?utf-8?B?WjJrQWljV2RNb3R6TGZpampyRDlLQUFobjIvcFhFME5mMk5ENG5nZlNPVExV?=
 =?utf-8?B?NTg4ME1mUWtGQjd2Vk54dC9HK3Z0SmNEN2ZJQytXNHg1cUYrRGZIbW9mMXlN?=
 =?utf-8?B?cjQ5Q2NMYjFLdmExK2xBTTQvaVZSSkxBaXJJaTJadjNxTnV0STZXaDB6eWhX?=
 =?utf-8?B?UTlJZGhnNmx3aWhSWUNyODJyK1YrWFNOS1J0alQ4Z2dVTHVZa3d2YjFoL1dm?=
 =?utf-8?B?NjNqanB2NzhqTXRKNnF6WDNWaVB1bldtMjh4cGxYQlZXL2MwM255N0Z4RHZi?=
 =?utf-8?B?eWs1NWpMQ1NnVmpRL2dhaGZlYVRDV1psMSttQXhEZitZR1E3YlNpd1JzVFYw?=
 =?utf-8?B?U1N5ZGVPTHljaVc2UENhLzZJM2RvTkdIZE5HbXd6bW0vcC95K2I3UkZ3dHA3?=
 =?utf-8?B?ckFCL3lWNGJDMXZUU0U0SDFLRC8wRkVRTU8wU1BTQWs2ZmJQRm4rU1l3cTdv?=
 =?utf-8?B?RUNvaTlYbkZ5dTMyM0srQ2pFNUJ1SWs4cHVTdmREWlV3RXJxMmpWOVZGYVpX?=
 =?utf-8?B?Tis2a2ZkeE9CeVRqcU5BU0dNK1k3bWtnN3hVNVJUY1UrcVNTUmVlUUdkVkRX?=
 =?utf-8?B?UGpHOVM3UkMxOTJFbldQQ0plU3NodVZMZTVZd09iaUJqMFdZWlVWWWZycVdm?=
 =?utf-8?B?ZmRyaGpHYnlaVDVWRGxGano2OVF4SHVya2kwNmVlSzRIMEdNTlUybXNNNnFH?=
 =?utf-8?B?elBPTk15UUJOMWVIYU9rWWZ4U1E5RGlERXZNd2ZrMHVJdXJSeDVHcHoxR0xx?=
 =?utf-8?B?cyt5NTgxV09HVmJlcUtxSTlOcDB5eDd6bXlWWTk2OENSZ2czUXFOZTViYjN2?=
 =?utf-8?B?aktyYW0vTzRwSU11TkhRWGlmZDRTZERNelZ2bjBmemtyRFVjdFJTSDFEaHd4?=
 =?utf-8?B?dGhyZitmVWNHTWR4ckptU25xYzF3M1dHVE5sSEd3WmhveEhMUHJPSkRVdUdv?=
 =?utf-8?B?ck1LZ1FSL2ZyeEpyaVZzcWxLQXZKbUNIVmk3R1dOYzM1L29PenBYT2tmYUcz?=
 =?utf-8?B?TUdBRUoyaGp1eHNEQmhNaXdXMFlHaXBYTzlaQTRoNHhUcGZVUS9FSW1tVzhk?=
 =?utf-8?B?MDdzekhFZkFZbHZySmdoVXR5RWRzMWRKMkMzRXBKakloNXVGd2tXc0g4OThZ?=
 =?utf-8?B?ZEpqNmRpL0FaeXpsdndyUHo5U2FoUFFMbU1jdytqNVVzdElqOGFXYWN2WE10?=
 =?utf-8?B?MHV0bzZWQ3EvMUlLUzRYOVBGVy9pTUVremxiaVkrNGpNVjc4OFlPbTVhNzVx?=
 =?utf-8?B?SzlSUTd2c0pocklWY2dRNGF6bkYvcmhxMjg1VEw3bXlwL2YwUDJkQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53413f1a-d0f3-466a-bae5-08dee896eb88
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5766.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 08:46:42.9329
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9do9o4/9BXBqWi89IOSry+mlj6dxbuNB1svHNa1BbUHSdGWGh9CfGeiGyrL4YFUn426iXsLC2jnUA43tNyL3CA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB9526



On 7/23/2026 2:13 PM, Vasant Hegde wrote:
> Newer AMD IOMMUs supports DTE[Mode]=0 for SNP-enabled system. This is
> detected using new feature bit (EFR2[SNP_Page_Mode_0_Sup]). If this
> feature is enabled, then IOMMU supports:
>   - Passthrough mode (i.e. iommu=pt)
>   - amd_iommu=pgtbl_v2: Forcing Linux DMA-API to use IOMMU v2 page table
>   - Setting up device for SVA mode in the host.
> 
> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
> Reviewed-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> Tested-by: Amandeep Kaur Longia <AmandeepKaur.Longia@amd.com>


Missed to mention. This patch applies on top of

https://lore.kernel.org/linux-iommu/20260723061548.10187-1-vasant.hegde@amd.com/T/#t

-Vasant

