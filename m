Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2073.outbound.protection.outlook.com [40.107.94.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C368C25A335
	for <iommu@lists.linux.dev>; Wed, 30 Apr 2025 10:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746009167; cv=fail; b=tveI7uW8uxA1WzenHdhJMpVlpTn/dJr+CchsNLZZIjxLZtL1+dr35WdkjtNmfqbzMw5+OpEAW1VqkmUIQQ/IcgVq3VLzPpIC0s1Oo5W483gogIlf3plJty6UiQUfH2R7ta2vJ5t5mm9dOwIq0qu0tarRcPVZxsS1AZlBuX141do=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746009167; c=relaxed/simple;
	bh=60l8Mb9BkZtfvpadpgBhw4MS4Blp8nKFkgK+AIqV/hs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rUU8C1KIU11HcWl1fokSKXrrPsZeSjQOhxYxHEFuKhP9e6r3YJImtZyG5eTQK1Zt/aDxGC8lChvnMDKS5bQPI/+1aPx6CaG9oUSbQDVwLO7D0aP5NNUTPdD5CSi1NSk2854w0S3sLt9//dWmooTjG6OI/TnpbXEwUYsA/zllRiA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=YP+Ws47f; arc=fail smtp.client-ip=40.107.94.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="YP+Ws47f"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uRbRRDD0osfze52v9/N2kzHO3zK5BScOkvjdhZbMAJMb4yeHBcNXo97SNSTp7bvQlNfbvfAX9071KoDZDWm62G9iE0a675lgMawSKotR0ax0MPu8qXMpDv9U/X7yJOXLOg5KtiPz5CtGLqO+3sCaW6cERio5+v8utJMAthBTT+G0jU6h/oBHadxRRPB3tppfXGmvAOtznEmv2jOR6sgBsfABcmMkZ9jxZ3Gv862lQ0A81odHrcfsjA3vmpKX26zKdgNEHyqh6Vx1295DJrjGevrYj2R5/+Rp1dGqMWelDh9ozsiWnptvvlviOpBeEs8S4DTRvdHwalmgP1fusCTk7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gmvm4b/cKGhknBJ9m6sw/Q/ej/T/KFh9QZ9ZxujMyJs=;
 b=XI+ndQYCRVZw5hOW7xYZt9VR7oqfsEZ3tbjivuzwcl+z5KgxPjjeC2chPHdb8UdRUWk7bqbefE/QrBHoCk+hFKtg0/4LKMW06sGb0LDfLZjLxM4BTxYkIc4MvJPsvwnJfzKGT1glEfzJPmi+iACLlgGoB7azbrRiEPfbXQmB3vGQvc4MCFC7tY+1CmSjO74I9PemdWdb+acHYAoD/l6vhSmDNl2Mrk6k9vqTq6XSX5UNvSDk/HwiF8IlIAUuV2QsJtVRnUh1ZqGawdLbt1z7iMdaPnTQj8bX2lfyLvbOsVEozYjAXfgNLLK3h8qa1DxWiR8wq0fYa+Ym33ZfQywziw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gmvm4b/cKGhknBJ9m6sw/Q/ej/T/KFh9QZ9ZxujMyJs=;
 b=YP+Ws47ffGdHO2A6GpCyM+gYhE5kG4XlgVfQKvIchGBPhDkMbMVJd6ScowWADxhyqIuMUJwDAHwX6N02VqZ/O4EdRGyk10r6CF86YP3BICkOzs3kZgWKtOpgOsMPLUNzK2sfk8bHJKxYtta9CT5XwIzQPNPM6RJml9ZnWYvz4UM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 SA1PR12MB7444.namprd12.prod.outlook.com (2603:10b6:806:2b3::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.19; Wed, 30 Apr
 2025 10:32:42 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5%5]) with mapi id 15.20.8678.028; Wed, 30 Apr 2025
 10:32:42 +0000
Message-ID: <702f4def-7382-4d95-8b3d-c1c10c11f627@amd.com>
Date: Wed, 30 Apr 2025 16:02:36 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] iommu: Cleanup comments for dev_enable/disable_feat
To: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20250430025249.2371751-1-baolu.lu@linux.intel.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20250430025249.2371751-1-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4P287CA0009.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:26a::6) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|SA1PR12MB7444:EE_
X-MS-Office365-Filtering-Correlation-Id: a83c5ecf-c235-4637-6f77-08dd87d25694
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eWFzb1ZxRHloQXFZcitxVlFWdVlYUFdtWXZYN0prWXF0T3BzMGZTSEp0S3Ev?=
 =?utf-8?B?UmdFVEtCVDJEUTBNVzBJNkJGSTdTK3cwRVJGMGs1Z0JNOStnZWZuazNvV1M3?=
 =?utf-8?B?dytNdDFmMENNYWVWYVJYUG1iTlozZDduaFBhOWZGZGxWdEJUQUg5bk9CbjBY?=
 =?utf-8?B?OVI4YythcTg4eFBPckNMRTc2ZEdiSFU2dnFiM1pvOU8vNXc0SlNpQnpXTHk3?=
 =?utf-8?B?cTFCemZQRHRhSGFOaVZtQ25xV3ZuZklCcTRmYXgxVW1YcWVoUkY2VjRhM1dI?=
 =?utf-8?B?THBPbUJCczBjMWQrcy9XNEt2NFY0TmltdHNJWE5yNnRTNWxoNWNBdzdzZlZG?=
 =?utf-8?B?WUVabyszMlF5L1cybVl5ZzdBck41MXJ4WEhZdklNdndZakFQT2lqZFFqazdV?=
 =?utf-8?B?cy9lR2d3cDdEV2lzWGJBSnJhUHlNdjcvbXI3SnJyN2QyMXR6NkF0RXY0Uk9r?=
 =?utf-8?B?RG16SytwKyt4M3FrT21VSnhwdHo4TGp2L3prTXBFaEg2TlR3VTNiUE5aUnZp?=
 =?utf-8?B?UWlBSWlxcCt4OEV5MGY3NjlPNWV0T013SVQwMTB0Y2NMR0l2dUIxdFczR3lW?=
 =?utf-8?B?TStySjZQOWwzWkZnbmsrV0g0OXh0N2gvWDlkOWFvQzllamhUVDQxYkZpb3Yz?=
 =?utf-8?B?U2lwRmJ1bXpaQ2J2cXJrQ0Myd2h3YW1aNUk0dE9YdUFBRjJWeW1uZXVIQUY0?=
 =?utf-8?B?TU0vTi9neExmM0tLNU5mcVQ0d1RIY0pOTXBLalpvekllVHUrejA1WUVxdEF1?=
 =?utf-8?B?V3l5Q1RQOXUvVTB2OG1WaUZaSFpoUXcyZExSUGhXNHE1cisrK2J3Mm16ek5L?=
 =?utf-8?B?TUx2Q0VHNFk2S0JOMnh3YVZRZ2d6ZVpMMDludnNFZkJqN0QvRGhJOHdrRnR0?=
 =?utf-8?B?eHBBR3dFb3d5QnV3NW5Yc3JJSFZuVHZVNEI3Q3dtaWd6VnpHZGtJTnhrNmJk?=
 =?utf-8?B?WmlMVms2YXgvZUhxT0ZKMW9ZM2Z3NUZUcmk4bmxtZytIcld2WUE2bGdLbDVH?=
 =?utf-8?B?THh6aHFxRnZSL1huS2ZYMUlXRHkrSG5HVkRMbUFkU2pSR1ZVNXorb1NPRWRu?=
 =?utf-8?B?ZDlHMy9NZGZNYnZGemNzMUZON3phN1JTOUxDWng3N05NYXUxZFRtNTVIQ2h1?=
 =?utf-8?B?ZnB2VTNqdnQ4Ulpmc1V0cGhmUVQ3dUt0NThNQXRtTzdFbjFnL3JzQnFDZXFr?=
 =?utf-8?B?cDRoaGpMdW5XbmQ3ZjFPc0NpMDM4b2s5WllXTmtyUi84eW9Lam9xS2MvRW1K?=
 =?utf-8?B?a1h2YVZ6UWJwTjZmQlgxM05ldEZLTWVRSDhhNmlGTWtxWTVoTFp6eFcvS05W?=
 =?utf-8?B?QUhUWHdFcVYyMUsxOHdlWGlkU1pIbDRjckhjZlk5UEhBWG53VERrUGxQcjBU?=
 =?utf-8?B?L00xSU5OSTJsZVkxaUZZTGN1VnlIOGFZbU1naEZEcTM2RHhPRGc0aFFnSExw?=
 =?utf-8?B?eEZJOWZ1M3F6eHAvYUE3R1NNdjRkd1AxaU9ZR2U4dE9WcXZkb0lESHlhTXg3?=
 =?utf-8?B?UlpJZEFYVTFzaDNMd3BKcmpoUVVMbjJVVDFQOFpuNnFWZi9UUjNGY3VuMFI4?=
 =?utf-8?B?d2EzRXBOdEkrc1V4Q0d0Ym41U2Q4T1dCZG5aSFNleTZteVFoOUJOKzVRN01q?=
 =?utf-8?B?a1N1S0k2M1cyVFduYjlwSFBTTFFIeGw4TDkvTnR0d3hGaERpUi84UFJBSHhz?=
 =?utf-8?B?akxSQ0dDeldwWGt2dEIydGxiTEpLN2IvY3phZXhYbWhzUm9RYlUwSXZwZWdB?=
 =?utf-8?B?N3RqZGRJS0ZicU91ZFArdzRvSTN5ejVra1l1WDdDMkR1YWJGS3M5R3F3RlRY?=
 =?utf-8?B?QjNkVVZHYzd0TWkxM0UvMUdPT1V0VXVaWmRzR3AwZUJkSUV2VkNoY05nZTdS?=
 =?utf-8?B?OWdjNXdKclBNVGhFRmJCRzdzOHdsb0I1dWdkVmdwcEk4VzNKanYyMTNsdUZx?=
 =?utf-8?Q?LJ/rL/ggdcs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y0tGdGpMa2c4RWNoRTg4RjN2QUJVdkpGWUpqZmg2dTVGYWFFSWN2em1NWkhG?=
 =?utf-8?B?eGVCY2w3REFEekdTcWhHSVAyd0FkMDBGT1M1NGh2bUNJUjJYS2J4R0ZjMDNR?=
 =?utf-8?B?TS9mc1lyNWU4eTlwNWFHZnh6dEpXejUvV3pyaWxjK1g4VGVLQ1l4S05VYzda?=
 =?utf-8?B?aENzRHZKTFlLWG9Hd04rUzlieEp5Z3QwdFdWMU1tQlUvZkFvSGNjamdrdytI?=
 =?utf-8?B?bHk4d0NqZ3QzTENtdEo1b2Evc0tvOEVGSzhiempRcU9ZM1gxdkZja0R1RFlr?=
 =?utf-8?B?Y1VzUVJrZVBrNmtmb05qVmlxNi9LbC91a1RMRVdmMVVpSDVoUkhsSVdpbC93?=
 =?utf-8?B?eDNvNnMyOGMzNHFFOVVIUjRmeElGblRxS3dYUHV2WkRFT0JodG03ZXNKZGRp?=
 =?utf-8?B?VU1QM1psUTRMTGpXTVRYWTRmMjV6djg0TTdoVDBST01zaW1LYTBDcUlhVTB0?=
 =?utf-8?B?amkrM3FRM29SLzBmOGNudEFXT2pSOVRtVW1GOGxaYXBuOTBiL0ZKSnFxYnF4?=
 =?utf-8?B?MmU5cnd0TWdabG9pdlFjWVF2aWdraG5mNGJSQlM0SUZLdDZVRVJxeC9WQ0Vw?=
 =?utf-8?B?cFY0Rjd5WkpoNE1FSnIzRWZKZFRpWDRJcjFoejc0b2trd0VQWWhrNG5ySWZT?=
 =?utf-8?B?MDU5MmdITmxTZHhnL3lWNlN2NzhrTHZVVVZMemNZQUhrME1Dejc1TUJJQmhJ?=
 =?utf-8?B?eHdOVjcwVTVwVnpVeUhVNkNQd0tueGQzTS9kRjVpMEJSaStEWjdVMWdWWUhD?=
 =?utf-8?B?cjZNZGJmdVU4TGVpSWYzZEpJV0ZtRFlUU2lGRjdIUm9hbG41YUJWN0pnbHhS?=
 =?utf-8?B?RFc5dlc1UGdvUWxsR2VObXg0M01nR3VCVXhZVE95L2JjOERubDBFbTM4bzgr?=
 =?utf-8?B?SnF1UXJzb25QSHN6dm5FcTd5TjNVVTJPZUswcnYrc085MjVURU5Fazl3TnRR?=
 =?utf-8?B?SFhuVzRxOVcva1ZvbTNZU1E3NjNZUGUyMzRjRUpIRU90aXkxZjhlYXZGMGpL?=
 =?utf-8?B?ZDhFMXpFdnNpLzVabUhZcmJrSE95SUQvNlIvNnlNRWQycHVmcG9UcUtIUzZW?=
 =?utf-8?B?eSt2U1ljcUg2Snl5d3BKZ2ZkaDRYdTQrbUh2YzIvTEtaN0VUaGFPeHc0cXBG?=
 =?utf-8?B?NWJGTmg2S1pTRHlBK3VsRkZGUDJId1oyaTI2dEIydS8zazBTWnRhWVg3TkZ2?=
 =?utf-8?B?c0dlZTJyZGFqZ2pjVC9scWJXbytOYzZUbU9TeXV5UzdCSDBHN1JUR2kxcmEr?=
 =?utf-8?B?NVpaSXJmSy9wUURTY0Z1NGU2Q1JlMXFnYXQ1eUtxaWRoQTBrVE8waUYyR3Fu?=
 =?utf-8?B?WTQ2LzFYZGhzaVAvVVhpY25rb1FCc29NVE9Oa0lBSFJKaUZHTzR1am4rbnhD?=
 =?utf-8?B?K3NxZDN0Uys5YXk4S3dzSkptckdQWGZreDhhVE5OdHFMb2lyMjR0R3ZwbVFU?=
 =?utf-8?B?WU0rS0NpWUFpb1FDYmdjK3dZRURDcHY3UzFRSGZyYzRjWmd2N0RISm5kRVRK?=
 =?utf-8?B?c3ZFNVliWnNaNUtiOFJRWW1OeXdBVkhyZWc3QUNrd2Mrc2VQYmRGWFpzcGM3?=
 =?utf-8?B?QkZBOVVVWUxMUUV2UitvV1lpbm9jbmQ5NmxuUi8xZWhML0EranVzdkJuc1NW?=
 =?utf-8?B?TFhsZy90dkdYc1NjUW1OUTZFeHNiQllOZzNLa0p1WkZmdFZmWGN3ZjgyZkFm?=
 =?utf-8?B?VXB0VWxzclhqNTJ3aHAwaGhCZE9CZTdaekFBVSt6d0pkYVFPMFNWUUhxZnZx?=
 =?utf-8?B?VFlqVlNlRjhwVEpNYXYxdWlIcVFSMCtZWjVXZGJoR0dSSHY1cmFFbUIycWp0?=
 =?utf-8?B?MHNrd2xxWkpTMzVJNnIzeHZ6TnZnMHA5U0VibGlOWVhrd0dhWXlyeWFrRmlG?=
 =?utf-8?B?Mndaa1BTc1Roc3N3bnYzSDBYcUNRenBYeDVhSHNlVFhPMkkxaXpZQXRJOUFx?=
 =?utf-8?B?MllUVzU1S1N0YW5iOU9rZEtWTEZqUXZnN2RWbHNXZDJ6dFBFSnp2dmoxUEYv?=
 =?utf-8?B?UVZTWGdFYldsOGZla3E3TEhaUlpQVUxxeTI2bUVHOWltSjJiTTlDcTRJVGtp?=
 =?utf-8?B?dzRGdjg3VDgwdnIrSDdSdHdDT0J5SElYZzRIZHE2ZjZ6dS8zaUVsK2xBQSt5?=
 =?utf-8?Q?Jb1Pdh0gbCtYCNcQGpjEQLmzq?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a83c5ecf-c235-4637-6f77-08dd87d25694
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2025 10:32:42.5075
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dOtG5iLGQmaSZfPTf8oettnjh4CFuFRP0SznQwgn0+p3N5OR60rXPSKH4WyHnB0EbRugM23xQuuPCHMG72ib9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7444

On 4/30/2025 8:22 AM, Lu Baolu wrote:
> The dev_enable/disable_feat ops have been removed by commit
> <f984fb09e60e> ("iommu: Remove iommu_dev_enable/disable_feature()").
> Cleanup the comments to make the code clean.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>

Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>

-Vasant

> ---
>  include/linux/iommu.h | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 1785caee5977..36df38c2d3a9 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -590,8 +590,6 @@ iommu_copy_struct_from_full_user_array(void *kdst, size_t kdst_entry_size,
>   * @of_xlate: add OF master IDs to iommu grouping
>   * @is_attach_deferred: Check if domain attach should be deferred from iommu
>   *                      driver init to device driver init (default no)
> - * @dev_enable/disable_feat: per device entries to enable/disable
> - *                               iommu specific features.
>   * @page_response: handle page request response
>   * @def_domain_type: device default domain type, return value:
>   *		- IOMMU_DOMAIN_IDENTITY: must use an identity domain

