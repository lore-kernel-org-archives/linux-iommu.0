Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2051.outbound.protection.outlook.com [40.107.94.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD370187545
	for <iommu@lists.linux.dev>; Thu, 30 May 2024 15:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717082293; cv=fail; b=ZVziAiqBpxMtI+vpqdxiA/lDo1c8GjMjUXzpb8SYj/WYDz1zrNrxxCZ0SjCbgGXn86HvCeuXnfVNdNmFjg64vYVdN22SHauT7TrXC9wie9YH+8wEeIEj21ZtBthWqe/k4Zu0x6LKO7SFesy9hQHtOTztPvb31ITnFtyi/h7I8cw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717082293; c=relaxed/simple;
	bh=0RhHh5JxKvm2UWM2b00E+OPA7xagFG1pu0uQFYEUVkg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rOBTDoEdDQrIHW2qBzY8nvITzzwkiE13NlPDh785wzqhO30j1qtlgTA3Q2b+bDGFIQh0YXZ4z6ioz1zLABaNw8FiP94dyqiokWsoQeONk3khpKcB0aiLfNUIQWzfXD2NZ5A0rfuu/mlFW+G5QIdJT6NLSW2cL2LPrJHtyRbCAGY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=eJz4rVCv; arc=fail smtp.client-ip=40.107.94.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="eJz4rVCv"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BNvb9xK3wOlQaiE+9V5CTtLm16i8XnUAn2bMmwutCJb4rVf3bKPvooh9LIPNacWayrYceHVcaJjc5C3Uf27nNXSlDiAOhwvOz8Hf1gRlBu0TUpBrScJPrSdn9Ozl6ZlvRhTpyvUDUlxmPNe5Tiv4yxvn9OXpLTVK4v/hc+hUM61SkPWWx7pQTp36XGT1yh/EqjEiw8wEqPiLNQ/l4yMTrhFGY1lqRMZ2d9MRogA8VxfDVmrphFKJr/SjteIqYKiPsancjjwPMXtLVLe/035W1fhj/wnBjRJLMU9WJzg/BCpnr6yI7iqX9gBWl4GnuK7oPEzPy9dFphHfGhfc6A6pog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ne8lNKP+i4InHa8l2axeh4sA15O4zCz7czJvErnUTgw=;
 b=mrcc8deiAseev0o7qC30ceTlqoH7PjzzPcrrqy1Ap3AUqGLFcBaLIsfN8ST0NNHCuRmN57d1tusqclLzh/NAwZDX1PXmScYjreWqgovCkH6yDiis8MZf0YEBVWlRFFVLoMA9RQQ3mKxPMyjU8H/lpynr9cGbm7zZHtoGySs74CpUbVIaD8wNqyYL3N1nDsG1C8YKm5INzqjOFinrup8wLU4loWo0OJZ7ffoeWxv9YsEBQjrisX6Mubb+Mu1WWekVh9y6jEElQDyGZaaeNCavABcTXhnhm3p/NwM7JzKhceQWp9WE4+wybj7OhS8+yQX7NgwRhHw6qNmsocU7rNTTwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ne8lNKP+i4InHa8l2axeh4sA15O4zCz7czJvErnUTgw=;
 b=eJz4rVCvwVNpVA7Rbp7Au3nAPJXwqkcWsHA8t3zss+IRaaKumI/iHPr/WJRUEnNJdIiSoQNFNIHOu5ShMx5FBHYQzsyoq19uv95fmG0wW+hI2q57OR22Z3u0AVdwRGFxdbdmzhX3QTB6eU2K/TBGhOP89DATG3/KtwXCMPgaAZg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 PH7PR12MB5880.namprd12.prod.outlook.com (2603:10b6:510:1d8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.22; Thu, 30 May
 2024 15:18:08 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5%6]) with mapi id 15.20.7633.018; Thu, 30 May 2024
 15:18:08 +0000
Message-ID: <85805c71-c94a-4518-a32d-1ffc2cbf61e7@amd.com>
Date: Thu, 30 May 2024 20:47:58 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/vt-d: Fix panic accessing amd_iommu_enable_faulting
To: Dimitri Sivanich <sivanich@hpe.com>, Yi Zhang <yi.zhang@redhat.com>,
 "Tian, Kevin" <kevin.tian@intel.com>, Baolu Lu <baolu.lu@linux.intel.com>,
 Joerg Roedel <joro@8bytes.org>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 David Wang <00107082@163.com>,
 Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>, iommu@lists.linux.dev
Cc: linux-kernel@vger.kernel.org, Steve Wahl <steve.wahl@hpe.com>,
 Russ Anderson <russ.anderson@hpe.com>
References: <Zlh3nz2Ij06TY4cr@hpe.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <Zlh3nz2Ij06TY4cr@hpe.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0114.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:11d::12) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|PH7PR12MB5880:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f76d073-9e95-4e31-0f18-08dc80bbb609
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|366007|7416005|1800799015|376005|921011;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MlFxeUZaMU05S0NwUXZpdVpDZHhoNUU1cW5MeUhQQmdaVDFveXpFY3VBUGlr?=
 =?utf-8?B?SzV5VW5DS2hkWmlienJnRXBKV0dZOXB5cGFicmRlclNGOGcxTnVHNy9OcTIy?=
 =?utf-8?B?SUdWY2pQOURXdDlDdElwb0xBOTJBNDl2dDlQRWJjVDcydXhzc2Rlakw0Z0pL?=
 =?utf-8?B?QzAxSzFRMGMxYUZuREkrZVA5dkZYN0VKK3VPTU5vdm12b1lWOEd4YkpaK3Iz?=
 =?utf-8?B?eVM2Z005SVI3aWZFMFNWemxzSXQyd1RWdU9NQ1ZmaUJJUEg2R2NMWmE5MlB6?=
 =?utf-8?B?Q1dJeHFyMkdZSCtRakFsS2RxZXJaeEVsOHM0SFgzRjFXNXoxcHYzakpwcWtQ?=
 =?utf-8?B?bHludjhrYnNpUnlFNUFYTGcxdWMweUdhUkVoLytpdUZrSUlvMGRSaWViRTFU?=
 =?utf-8?B?TkJDYUZsUW9zSkg1R2ltb1F1c3ZsNEdtUHQzRVZiMm9nTk50Ti9sTXJyT2xn?=
 =?utf-8?B?Tis2dmNBRnJGYmV0Y29DUGV5N0M3Y3IwK21GMXJOOUI1QU1tcEZST0h2V2Jy?=
 =?utf-8?B?MTZLYUMxTVIwWVgrVEhYSlo0QVYwYno2clM0dlN0Z3AzbzJjU3hlT1V4aS9W?=
 =?utf-8?B?d3NNYjEyMlF1NTRSTlAybk5LZ0NNNFVqVm5CclNFVGxDRk5ZaEJ3UTh3VFE3?=
 =?utf-8?B?WFpwRHlKZytRMXFKcWE3MXlMNEg4MU9lNkNyMjJ0K2cvVXJzOXlNQkR2c2dw?=
 =?utf-8?B?NGxJQ1Q4cks2Z3Q3QkNUV3FFb1ZpOU0yMUcycDFubXIweHNtMHY5MlhXZkhh?=
 =?utf-8?B?K29zMS9KUjFkQ0NmSUN6NjJuUjE4dXF0MURDMm9zZEs3SElZK3pJeEdkY3FT?=
 =?utf-8?B?YlVSTk1JdktScEgzVC9wNCt1VHJtN0s3dFRxQUdIL0czZW1GMmtwc3JRVkJs?=
 =?utf-8?B?bElQa3NiWStwQXhCRkYvd2JzY3psTm56bjRYamwzUUorU3paODRDT0hUdU51?=
 =?utf-8?B?V01URW9DdXRJbkxkclNQdC94SnlNcGZGSkVQaVRvK2lNKy8xckd2NEdNc3Ay?=
 =?utf-8?B?R1hmcTdlZjJiSzdnTThJLzBBUjY2dVMvdWRwcGxZdzRDSHJtZ3U0Ymx0T3pN?=
 =?utf-8?B?UnVWVUZueEdvOUNZQ2psK2Q4cXFaejFKOW5kamhRbFRLRG5GN1JSQ09wVDJK?=
 =?utf-8?B?SWRvWERaakkzSGE3VDlmT0QvRXNpVkw4cHkwT3gxNTE0Q05vY0xqYUV6Nlgr?=
 =?utf-8?B?OXVkcnRmQTB3UnRHQ0JmYjV1djE2OEJIYUFaQ1ZBMlpvWEFUTzVBZHpHbjFm?=
 =?utf-8?B?MHYwY1Uyc1lmOFBWU2tUeUI3cGM3ZFdSM0U4d2VST1pYZWJwRUpCaXk5RlB6?=
 =?utf-8?B?SUw4cnJTQ0xnbDcrZjB5T042NHU3ditHb1NKT0U0SUtEMUNHcVJVb1FkZ29N?=
 =?utf-8?B?TjU1cEZRTmlNMTg2THZZYXhnODVlZWg0ZlZvRmova2Q2UEdvVk91eTMzeGdq?=
 =?utf-8?B?NGlreURITlNnYWRKbmRIS0ZMdEN3NnhvSW83T2NVdWpDZjRBUmFDbW9uaGxp?=
 =?utf-8?B?MG5xOGF2WEN1NnV2Wk5sMmprR3FNdzBrZDQ5M2c4OTA0TGdtS3RJMFV6cnpV?=
 =?utf-8?B?U0VuaGg4RXVXbEVQSkxaK3BWLy9hSElNUnVuSWVlNU04end2a3B1cEdZQUhV?=
 =?utf-8?B?Z2N1VkZjelloWHgzaFlIeEtOdGRQZlVUNVZNcmhvSHF2UDdYTExtYjJQT1JU?=
 =?utf-8?B?Z0FWaTREcHl3aEEvVGdsU2RYbHg4VXcwaEkzRGNNd3B1QUtja0crSHU3MTgy?=
 =?utf-8?Q?kwfN8ApIzGq3VHHgwOqwvpLINl4SHvkS30Cb0CJ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(1800799015)(376005)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b1F5OGhQN1hUckU4LytnU2xYTWdjVkRPbmdVM1VTRzZENnFaNzgyMDNyaEZz?=
 =?utf-8?B?M3djMmNqN0V5QmYvQm82bXB0ZTlMazJXUlRpcjB1SUVnTElZOGdUK1MybkQw?=
 =?utf-8?B?U3JmS1d6dTZ5NWhLU0JLdE5VR0gzb2lHVTVyL1M2U1J5dDhKUWdCM3hHTGIw?=
 =?utf-8?B?TlI2aEJDUVpYMG9YNVJKejVnVFhidTVYeEM4OTk1SDVTQ3VDWkZvcE1vZ09U?=
 =?utf-8?B?aW1GTWEyQWJLT2NidHZMWlFqZ0I1WU9IbE93dXZXS1FFWWJNakFDcXdSU1JP?=
 =?utf-8?B?b3c5UGVaN0xBaUlKYWNOZzNyUmdOaTFBVjU5ZmI0SDUxUCs5UnFCTkp4Wm03?=
 =?utf-8?B?RkRadU03TWN2V1JGZXhvZ1NCdUtSbVFGTGYvYVJPUHVTZUZPNS84TzNUMGxK?=
 =?utf-8?B?c0VRdGMzRWxwei9iMWx5eEp3TTJwMEdYV3ZvbDZmMXArd1BtWUEyQm1wQkw3?=
 =?utf-8?B?Z2dpUjJoS21pSUdrTVp0Q25sSTVCQ3lLN2FhakEySW53QW1Zd2hESGFOM2Zx?=
 =?utf-8?B?TE1jVldyYncvN0thQzRjUGRNWmt5TFhBTXJjOHFSUitqa24xVzNxNmpBOVdP?=
 =?utf-8?B?aDE4VmtNUnE5R2V5eThVWUdVRW1JL1E1L2N4T201OW42SEdURW9IR2RQb3dJ?=
 =?utf-8?B?T25CSmhpdmFCZnlkdmJWVlRMcXlRc0ZtZ2RzNkNsdytEUm93emRIYXdiSFRN?=
 =?utf-8?B?L3FybG5Lc3lLVExsOFJHWGdneVFmSlhNd3RUV0Rvb2Q0RXRmUEw2SzdXa0Vj?=
 =?utf-8?B?WElRWGMxajlJZEVoUnd2UUIyNlAyZmVUSWNXRHlJNTY2SEhTSWZDclI3Mmxt?=
 =?utf-8?B?VXF4RG42RVZsSVVqKytkeHdjaDdKVGZVREoxRFFLM3pkdUhNVCszRU05dVdJ?=
 =?utf-8?B?MXZBbHlTS0cwU1VZTHRyMFlqRTExeVk0WlhRRUNaVzdNaFErajNOME5iR2t3?=
 =?utf-8?B?QXFLa1pmc1JtcEFZeSttVTJ6N3FkOHRhU28zaFViYVpYQkFoWitXQmNnWm9J?=
 =?utf-8?B?dWo2SWdFSkxMYTJxZXRHOCtKOUtvMk1RUlJMdFlFeDRmM29kOFdvNGVwbXdo?=
 =?utf-8?B?OE9jV09MZEJzQndnRytDRk4vRitlaEtuNGZXRUI5T2lDWnduS2FhZ0J3Vk9X?=
 =?utf-8?B?V2xCVGRFOGlvTWpvQUEvYTVHY29RRSszSm9CRjJyVE5QWmozTjhyM2dYbDBk?=
 =?utf-8?B?R09oWGJueSt0aFJTK3N4K1o5Wm1YN3AzMmtFK1ZrMFl1MjZNaWZOZm1GN1c0?=
 =?utf-8?B?aHNRejA3aEVDWDBGZXZYYnNuOTRtQ3dTck4rdTJ1WUhtTFZlZit4TWZYVDFN?=
 =?utf-8?B?NUNyWmM1N0c0RHZuMlRDZVFBcjQ3Rk1TRDgvOU9kZWZkMlhkS1RQbTBzSFhC?=
 =?utf-8?B?c1M5dkcrSjRRdUtoNEVaUTdBTTBJNzBNc3NoS1JTSGNRVjFMQzNFL3dPNHFp?=
 =?utf-8?B?dzVWWjRpd2VmNjN5K1dhREhDd24xV2hYU240VytickZoa0RwM2NUYjl0Mmdz?=
 =?utf-8?B?QUpUOXZJSzZHTDEvR0NETVpkNWJ0TEJkaHR4SjBTQTBtRVdnV0dOV1BRYWc3?=
 =?utf-8?B?eGdGQm41WVFSeXZGSkFOdGY4Nnh2Tm9NVlV4OEx1ZCtORUJabm5DUktiZmU1?=
 =?utf-8?B?aGtUQlZSNC9WSzdaNCszTnV4VTZKZ0tqYm1mb2NQL2NLVGUvRHd0aEE1aU80?=
 =?utf-8?B?NGR0YlpES01UMVQxdnJ5TGJXY1FuMElibkcyOEdsSmI0dEJPVkpwY3ladG9T?=
 =?utf-8?B?Y3E4bzVFR1MxNXliNFU3ckQwTE9zc3E4UUs5Zzh6Wno3TEtiSFZkT2xJaGhn?=
 =?utf-8?B?MkF4YkEzTTVrU0Jydk80NzRKNk9uT2kxNFpaSVp4c1Z3ZjdJaHdJbVI5WFE1?=
 =?utf-8?B?a1hFZGZrYzFSVFV2L0JhRm1CV1YraWcyRXJoMmltV3JjajduZUdtY01uVlVo?=
 =?utf-8?B?a0xKcHc4UEhxZzNsT251alBhQThkQVFUdTg1SVRvVFlKTkdzaVp3Y2p1c2lB?=
 =?utf-8?B?V1NNc3RXQStFaGZwWUpnbjUyQkJwMEpOOEJqUXBMdzdYL0l5bjRjS2tNNDdP?=
 =?utf-8?B?eGFReFBSWXp3amNmNVV6d05ETEVEa0tZMEs3amNwdGlQWjBOYXFvOHk5T0pY?=
 =?utf-8?Q?adG0zTMA55BAWX7dAFrdSz1lM?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f76d073-9e95-4e31-0f18-08dc80bbb609
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2024 15:18:08.4836
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YOvyzcjA9u16NpEKd2uxQMNVyvzX8WNpSlZpXoD4wOAl5U2Q1hfwgFwlZdJTQakMHBTwPYn0gskL98ClKXyhng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5880

Hi Dimitri,


On 5/30/2024 6:27 PM, Dimitri Sivanich wrote:
> This fixes a bug introduced by commit d74169ceb0d2 ("iommu/vt-d: Allocate
> DMAR fault interrupts locally").  The panic happens when
> amd_iommu_enable_faulting is called from CPUHP_AP_ONLINE_DYN context.

Issue is happening on AMD system. Can you please change subject line. s/vt-d/amd/ ?

Also may be add "Fixes" tag as well.

-Vasant


> 
> Signed-off-by: Dimitri Sivanich <sivanich@hpe.com>
> Tested-by: Yi Zhang <yi.zhang@redhat.com>
> ---
>  drivers/iommu/amd/init.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
> index a18e74878f68..b02b959d12af 100644
> --- a/drivers/iommu/amd/init.c
> +++ b/drivers/iommu/amd/init.c
> @@ -3353,7 +3353,7 @@ int amd_iommu_reenable(int mode)
>  	return 0;
>  }
>  
> -int __init amd_iommu_enable_faulting(unsigned int cpu)
> +int amd_iommu_enable_faulting(unsigned int cpu)
>  {
>  	/* We enable MSI later when PCI is initialized */
>  	return 0;
