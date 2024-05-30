Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2076.outbound.protection.outlook.com [40.107.220.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0061C14387F
	for <iommu@lists.linux.dev>; Thu, 30 May 2024 08:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717057437; cv=fail; b=YKtPHfMHreQbj2yG1V2KxoLtfLOXZ+9y8HRQXlI8+iX3qGLi/o3bo+qTl+JhrVblLGDwkKwsWSYZcbLWMymIwFAd2pMmXihfBtyvQYKYJKO5qvxcSlso0m0UizMpStzi1WcvY9EKa4kOyjxJVVYNdhw1YqMAyfoUN4YtovhrFC8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717057437; c=relaxed/simple;
	bh=cd0z6A2JirzPITNUOyz53KCuz8DYar/CywyHsvc2SfI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nlLrcQG3xvRjVI7fMF0Yn+lbxp6hjJ73XWATmYAtX0bjQ2AUBTQVPBzTyLCx3ujNDw+mGUGsz+Ek5fTL8Qpe+48er/PF1Fc5s8+519uxScBRChgHxi4JOBEGLnAxM5GUhZD1ETMN47r5hWPB/1YcV3P8sEqvxhOOpe3ZI7sjYC8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=cow3KFlz; arc=fail smtp.client-ip=40.107.220.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="cow3KFlz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BtvkYeqz0tzAhga4vy6UrhVi7eFoNWFupfFgYYTV6tMNTTGY5Jsp5vXTvapIdGbqd3SPE8662TTr105JWBrRPk3mmRjHmfJfScJuRzV0LMmyb1nrrmDPgQAYo09K5p+64B25zX74dLURf7EE6sW+fhSh8TWWLTMWpdub34oJJ22krNwKQZO2gnUPSgvKiLu+1ZjMu44jofoNEEc/cepnslo0zv2Us9O+yThftr+dkoCttogX5t3gBUFABw9ip2cQY3U4tJTJR7up/3/V4NC1QewJ1NYkmOLkdsxOZsPV01jLezptY+d28pmRDkOjsdeLYrbXB/qmWOy+/XaYWd4zDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E2fxEaNj2xCwHwAIl77epv0roB+qeiBNeJkmRE6pnbw=;
 b=Wx5lHpjR/qOeedYthrecnzCq6Ll55/B6S69kEMRRdzd9N/74f7IiMB5SEKLab3qsZbhk/8g2katPnNUhK0x++8Fu3PmiJQI+xM3rvsnvdHlUO0yG98xFJ7BrwLTlSKg8Q6cHS/BOwsPvxymItd9l5TfGyyTv2un1y7yLhTTYHYHvNOC2XnlE3iC5/YxgrY1/72wsC0I6FUx52zai09mwomfXeF1XeaZqTEGnrYm9a6JQgXWGebLmAWh2chKyY4kHpn2UU4BiWts9uCYKTRlHNt+E1vB1ebq6bJNwI7R8bF8WbFSAz2056LfQksXB3RuFAOJZlv0sIFYAZe43s1pG4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E2fxEaNj2xCwHwAIl77epv0roB+qeiBNeJkmRE6pnbw=;
 b=cow3KFlz3R7v36dRrflJom+tkTrB7enirA5pNB1FiQZ2+Ch1BSRCSlKQZD8J7DiAxmEv+lof+Mwo+Nj5BdKRV3S+NdmVXU8Sd1jQbskXZhOzV3CqJdFJBpETp/PmvNvUtWLfSx9OjD9imVC4H7lVX7akOJzOzCs782En3dcl45A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM8PR12MB5445.namprd12.prod.outlook.com (2603:10b6:8:24::7) by
 MN0PR12MB5979.namprd12.prod.outlook.com (2603:10b6:208:37e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.17; Thu, 30 May
 2024 08:23:52 +0000
Received: from DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::a544:caf8:b505:5db6]) by DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::a544:caf8:b505:5db6%7]) with mapi id 15.20.7587.030; Thu, 30 May 2024
 08:23:52 +0000
Message-ID: <e5a90f10-a7e8-49b9-a83b-7d44684a5779@amd.com>
Date: Thu, 30 May 2024 15:23:45 +0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rc] iommu/amd: Check EFR[EPHSup] bit before enabling PPR
Content-Language: en-US
To: Vasant Hegde <vasant.hegde@amd.com>, iommu@lists.linux.dev,
 joro@8bytes.org
Cc: Borislav Petkov <bp@alien8.de>,
 Jean-Christophe Guillain <jean-christophe@guillain.net>
References: <20240530071118.10297-1-vasant.hegde@amd.com>
From: "Suthikulpanit, Suravee" <suravee.suthikulpanit@amd.com>
In-Reply-To: <20240530071118.10297-1-vasant.hegde@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR06CA0014.apcprd06.prod.outlook.com
 (2603:1096:4:186::11) To DM8PR12MB5445.namprd12.prod.outlook.com
 (2603:10b6:8:24::7)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR12MB5445:EE_|MN0PR12MB5979:EE_
X-MS-Office365-Filtering-Correlation-Id: 357cebbc-28b4-4b10-6d9e-08dc8081d668
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|366007|376005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bXoyYkVJZTdUVE56N2JFUk1YWHNrWkFxRUlQdEJxa2paMUNJM29QREs3K1hs?=
 =?utf-8?B?VVRGY1dxT1YvZklOOVp0RUxzN09VMndRc2ZFSnp0emUxRS9BeXJidW00T0pX?=
 =?utf-8?B?YW9NTlZ2T2xVY0YvdCt4MlVJaVRTdDQrbGtDTFRBSitENUNVN0hHQno2Yng1?=
 =?utf-8?B?b0krMWRteEFXazI1VDdsb0srY09jUHNiU2ExUHA1SC8zNmFJb2NKbHgvQjVv?=
 =?utf-8?B?a0ZzUzBVcWNSTEhKZk0wWDFtR05ObUYzdnozMy8vajRYTTdwUGU5WFFhaDIr?=
 =?utf-8?B?OGZnUnVqRGEwME1QM1lWNHlsaW5ubFRRWlNQNW82ZXErTzhmdXpWem56a3BS?=
 =?utf-8?B?aEdHK3dnZjRGd3ZVR3VHdDd6cEZJZjRQQUNnWDFkN1JPQVMvOXY0a0FtSE4v?=
 =?utf-8?B?M1IzYUc1aEFTMnF1c0orSWlkazh6T0FaYVI0VkFCUi9Vb1hUYUdDNWhjQUg0?=
 =?utf-8?B?K0Y3UUF3R1AzZTFybDZlcFNiYU1MSUpNQzBxdWpYOTQ0MzFIVGxqVk0wUnd4?=
 =?utf-8?B?dG55QWcvRXFjTnRmbGZ1Rk1hU2lPZlA5R3htTmNzMytzWHhJRTRwVG9WVVhE?=
 =?utf-8?B?Tjk5QTBDaENoTnBCN3lXS01pM2prODJ6MzU5THJ2b3VWNHBpcE5WdVFzZjlZ?=
 =?utf-8?B?bWFObHdmNTU3T20rc2kzazNuZ0oxOTFQMEdScnVsRUlKNnBhOG02bFJaTVQw?=
 =?utf-8?B?cDNQSVlIeFJ3WjM5NDlZZzFCT1JFSlZMUWJ3V1dQci83RWxUTDM3SGw4eVRL?=
 =?utf-8?B?Q1NIQktxZ3lJR2wvd0l3RnIvU0lzY3pjcUNBSEhSTVk1UFBzWVN5aVM5MGpy?=
 =?utf-8?B?SUNhYnJMbC9yRjNkbFozcUwwWEhQTmZEN3JTd3VpMjhwa2w3Yit0SUVRNy9K?=
 =?utf-8?B?MzBoQTVxYWhCQlUvNXZUVXNOd2R1SG9VWjFSSU1TSml0ZEZwVlgzMVZVMnJJ?=
 =?utf-8?B?VTVyVWNuWGlWWlJsckRPYStFVE8yWDUzWnFuVDJZVWFUalczaTg3QTdhbTBi?=
 =?utf-8?B?bTFINU4yY2l5SHZaSEZlcG54dTRyU3dxMFVIcjZlRC9yR2gzRWRsYlVBVWRS?=
 =?utf-8?B?TCsvRjVZT29UZFBzQVVVZHVDelRiQXZINDNjRFNpOVRLbEVwL25wUnRlaURj?=
 =?utf-8?B?d1NteCtDOGNsQWFYRnhkcTZ1dVpsdUgyTUsrRVE1SzNicmNwUzdGTnVwS0pt?=
 =?utf-8?B?WVdiTVFRQ2xTQlRtbW01QXA2c3BQcndWWUF6a091Wk5nakF0MjVUVVJLZWR1?=
 =?utf-8?B?bXpiNXNXcFRRRFJNbEVZOXhzd0dkYTY0NmMvMmpPa3lhU0l4QWxtWDlXcjRZ?=
 =?utf-8?B?SThCNktNOXRtL1h2Uk1XZ3laQ3g4SEFRditOUUpmR0tvM3BvVm8wYnVTSTQy?=
 =?utf-8?B?bnVzckNHTmxkcTZ6MExCK1NuMjdnRExHMjN5WStXaWdRNW5vSnZ3S29NWXR3?=
 =?utf-8?B?SzRWaXI2aTlHdFphNmdzMVRGdkN0RUNwbXNEMGlXZkMvcy9HbmFYYWVZeEFq?=
 =?utf-8?B?TGZMNWo5YzR2ZjAzZzJrK3JGeDJMc3ZpOUVERnFsS1RpVkY3MFVVN2gwS2Rs?=
 =?utf-8?B?Ujl0UWZteStTdVM3OXFrL0QreHJ4aVJVY3RveElySWdBOEVSNksvR29INUR0?=
 =?utf-8?Q?0Xz4eIFKFMcca2lXZhwPdShII0MBqex5AtudkfE7+A5s=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5445.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c0lBaFBuLzdhWjRWMXZvSnJxL3A0QXg4SSt4K0JCemZZTTFSS1lUUmlIQVY2?=
 =?utf-8?B?cFlZR3ZOMFd1ZFZpYlMyZWlhMTNRS0ZJOGl4bGN3dFNiLzVUWG1SM3lKZnNZ?=
 =?utf-8?B?R0lQK2hxbXB3RXZKUjlvRnVMenlmOE1aRnFWNzlRTXMvL204cDEyWTllZG95?=
 =?utf-8?B?NkFJSVFzVFowcjVBVFp1UGFzWm5vYi92S2o4eFRBRE5vNFljdWd1N2dPQ1Vy?=
 =?utf-8?B?SS9aZVgyWEJhSk43MXV5d0pLdlhJVTRaRENMN0tNYnhVTlRLREN2Tkc0WDdI?=
 =?utf-8?B?TGdJZ0YzNUZmYmVOQzNxSFVETU1ISDRPOUZXVDE1Q0J4Y1owZUxJd256T3hv?=
 =?utf-8?B?ckhPdzg4M3NyN2JEQ3Erdnp0TE1ZcjhIeGU1TERrNlhOUDlDc0FHY0c3dGla?=
 =?utf-8?B?Sm1ZYU84SmdLbzg0N3Ntd0VUaE1NK2FqQnRxbjBvb0l5Q2JYUGdlOS9YUThQ?=
 =?utf-8?B?SE5tb2h1QWRjMWQwTzFWSDdKSUh6SWVqUC9WZjNZYjh2TGhWTlZQbTVQcFJ4?=
 =?utf-8?B?dkk5VFVsQWxiOW96NkdXTmR0a3pCVWRTYk13RS9kK24vVWtYMzNGV3I4Sm9P?=
 =?utf-8?B?eHloS1k0cDBkVEhZS0d6eVV3TVJ1ejZ2bVFXeEFTejhUb0ZsRCtYLzY1UHM5?=
 =?utf-8?B?a0t5SmljR2JsMXBjekhrSGdHa3B5VldPN09KOGd5enFoUDBVb2xRNDE2VTMv?=
 =?utf-8?B?Y3FTSHp3ZHB6ZDFDMWdLVzMvWmNCLzIyMlJ4a09HYk5GQTlJM1Q0TUpzRmty?=
 =?utf-8?B?SUNaOXN6TjRTOGpUeDh0UFhEcFFpekZxaUF5SlhWNnIvOGovRmQ3TVdOREd3?=
 =?utf-8?B?RVNKZWI4NjFySXZvMk9OVlJKUW5RODZ1ZnQzMlhjTGorWkRpcE1lcXluemND?=
 =?utf-8?B?U1Nla2xheW5oUnJnajBLUlZFMXBWSWR0UFUwbXU4YTgzT1VLbVJwd1MwSXhp?=
 =?utf-8?B?Myt4KzRaVkczQzJTVHUwMWpNSHAxcVd2aXlMWGNZOTgwZ28wOFdsYUtweEI3?=
 =?utf-8?B?eDFXeEVVeFlScytCU1kvcG14Ukh0Wi8zOG95S09PZTdVU1NyOEtFZWE1Sjda?=
 =?utf-8?B?S1UrMzc4dytNbDc1NXQ4U3Qrd2tqdWJkRC9LSVF3THhCaWdSRDRDcC9YOVlQ?=
 =?utf-8?B?R3p2SloyMWw4N3hUY29GT01tbytTT3B0TGdsSnQxRkNiWk9OcDRxYmh2bFpZ?=
 =?utf-8?B?NThNazJFNEdjN1gzRmttTWhlT085QWZ4Ty9kZCtZc3lkbjRLSVIzNU11Zkpt?=
 =?utf-8?B?UkdBTTcxZGd3NVRhRmZDOFlSUFg3MklGMytOSmg1cVgzUDZ0WlBIdkFPVWps?=
 =?utf-8?B?bTJ6THJTaGFVbWE4bmpLYmxERktSRk90UDZtTENvSnY2MHpxaTN4alpXcXpu?=
 =?utf-8?B?ejd3eTJ5b0xRYjFqUDQ4ZGh5eTBZOUt3R3EvUUZrdzVFUkgvSXdIODhuUk9J?=
 =?utf-8?B?WHNxR0szMzVGaGR6U3FieEZSdFBhcDhtUU14WDN5VXNGWEhaQ3JTQlVJZGhh?=
 =?utf-8?B?UVRCTEJ2MTkwN0VHRk56Q3FLNkdyMkR4Vks5RUJQV2tmUzhUWGhUTTloTGxK?=
 =?utf-8?B?clQ1N29SWFhxRWkyNTNXbEpRZHp3YThxVGZTRjBvK2lGVFNtdGwva3VXazBy?=
 =?utf-8?B?ZHByZ0JlT3oxY2h2QmdCR0FPZmJRa2tUd0hxNzhsK0d6QVB1ZERCNDQ0OHVm?=
 =?utf-8?B?c2RhUngrUkdGR25CcDRSZmMwbExnSnFvRVlMSGNVTHpJcWRkd1drV2ZSSnE1?=
 =?utf-8?B?ejlnQ2ZHUjd6bGxoR0lEeStvbjF5eWJkZVlUN09iSTYvQXZpRjduaFpMbytw?=
 =?utf-8?B?Zlg1WlNzTnFvUmZnOWlpZmFpeEE2azI0MnpxMkFPckxSbUx2cFYxamJSME5S?=
 =?utf-8?B?S2V2TWk5b21ZRHN1N2FBZ2hSOWFVZGJ3cTEwVjA5WGF5TXhEN3BJTVBSb1VD?=
 =?utf-8?B?ektteWs3U1Y4RHgybDRtYTk1L2lISDBXN3VYSk1ta0pyVFZHQkxKbFIyaFhM?=
 =?utf-8?B?WVhaeExsdHhiaWNzbmpzWnVGSXU2b3RIZnhSaFFwS2o5enNWTHZDS2kraXV4?=
 =?utf-8?B?a0NjSXQzL3RVVituSTZ1WTRuYXVXamV1Y25nYUsxL0t6WEJRRHlpcUN2UkNO?=
 =?utf-8?Q?SQHAMGvr4rZ7p5kNAfDRLC++t?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 357cebbc-28b4-4b10-6d9e-08dc8081d668
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5445.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2024 08:23:52.0120
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0dirZlF/Sf0lMk7tWfDXnpbrgyvXXd3JIuH9GS05Ol38rHpYEq4vWJkaqqPMxrZJzHugO825L7z808vieVeq7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5979

On 5/30/2024 2:11 PM, Vasant Hegde wrote:
> Check for EFR[EPHSup] bit before enabling PPR. This bit must be set
> to enable PPR.
> 
> Reported-by: Borislav Petkov <bp@alien8.de>
> Fixes: c4cb23111103 ("iommu/amd: Add support for enable/disable IOPF")
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218900
> Tested-by: Borislav Petkov <bp@alien8.de>
> Tested-by: Jean-Christophe Guillain <jean-christophe@guillain.net>
> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
> ---
>   drivers/iommu/amd/amd_iommu.h | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
> index 2fde1302a584..2d5945c982bd 100644
> --- a/drivers/iommu/amd/amd_iommu.h
> +++ b/drivers/iommu/amd/amd_iommu.h
> @@ -129,7 +129,8 @@ static inline int check_feature_gpt_level(void)
>   static inline bool amd_iommu_gt_ppr_supported(void)
>   {
>   	return (check_feature(FEATURE_GT) &&
> -		check_feature(FEATURE_PPR));
> +		check_feature(FEATURE_PPR) &&
> +		check_feature(FEATURE_EPHSUP));
>   }
>   
>   static inline u64 iommu_virt_to_phys(void *vaddr)

Reviewed-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
