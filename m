Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011011.outbound.protection.outlook.com [52.101.52.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDEFD3F6C58
	for <iommu@lists.linux.dev>; Tue, 25 Aug 2026 11:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787656500; cv=fail; b=POiNaN7yBG5ERU9cWrygkginUv97wSjuoc3v8AuN3h8R5SPSJjBlJBpp2V/T+BHonMPFjHE5eIvY+WWr1c5QS/+LL5i9fj94oPFkRiFvqL4kfIkQFVy1FUPOnUpy/HGH/r/EqLbhZy1rBIBmZ7XtdKX8y0gzfa1M314+n7QcASQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787656500; c=relaxed/simple;
	bh=V8cV8AiTWTVOImuQSWbbljqeKLOMOLH90tdoefF46Ms=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ppz7k9CTLGmpj3IEJfCgq6YAgXS2Yphei2pUjyxgL2Pa0iTKgRQLWuIMp6IH8Qz2aL59x9rgmqB8f34+av8ZUJ+HIxzyymch8/xU5KVZtw5UaTaymxNEOnupDlKWNhNMd8scbmuay9jlIoMjnn/yxgrYgv1rNqyq85/BpPUFsns=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=S+TifQji; arc=fail smtp.client-ip=52.101.52.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="S+TifQji"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eEh/hyFQmo6gnCBkWNdUHbTTxrMF0VCwW0q+s8Nu6z2Cv7t5lQsr462XhSkqui8O4Qf8c9pAdrETvC0qSDUeQ7ZAuJOlszN0SW9Sw0Urkm6eIjPSGz3NzvIOOvUzMNLDTsOdH1RurEvCX1417YqUhEG5iPPgc87T6EST7K8gAQRbnJkaExwWBT6eymKjyuCJMOi+PdPQBrLafhtEMHp51zfRviEDo0P0aX6e44JzgCyWPluH2BhdL5D9fJqM9n4YxhyXaSytsDdGnr5eoZMkHKsQuu3Q3y1rZQQxzm59PVit+YniKbXUZYKL9ToPhCp+gs37BjAv0+VoeUjog+indg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jCSrFLzBRgtTvMehuWejCnRVg9jXhJX+zebMrOOLme0=;
 b=dJi30I+xPd/s1POjyhlEcRffvnIWOGxn+M+cX9TBn9+fWdjOJNX7Fdbda7dEnVrUbD6LUaio2WOVGm3dN6SyNwUNvyFlrbO6HqxRsEX+svl/+5xB2JpKMM0vBKf/uTqnB8nBtOVt75KQWYS6nyQnMAuPNbwOXhJ36lLHTNg1oUzcBu2kZd2euei46btSmOKP6g0erZTY/ysrIrj6bfxVMX7iJehJhBsjNVP8jkHSonNdIxEITpFRRhhYEdH9HxgrV85EB5BWvlr2VLejhrPlheLskcx+5r6o9/7oskWSEIWHfh0c0wZUaHnA9dlWR0KopQkrxQ1xDqDgf+8Xy5rkYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jCSrFLzBRgtTvMehuWejCnRVg9jXhJX+zebMrOOLme0=;
 b=S+TifQjiG7DK7BrA+GENPDAx/E7IFJ68rZ7C7SbjL86PsPyOGpQlZuI3PoNyrO8vOtW3wX5EDat8uu+uq/vxC/iPHOGB/T0hz32Fgs645fIdFEzNskYKHg+NeEFY5pw8xhJRs+lrX8+yNMMVZoSYUH2C/QSBDYOlSKRrB79jYXs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL4PR12MB9505.namprd12.prod.outlook.com (2603:10b6:208:591::16)
 by MW6PR12MB8951.namprd12.prod.outlook.com (2603:10b6:303:244::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Tue, 25 Aug
 2026 11:14:54 +0000
Received: from BL4PR12MB9505.namprd12.prod.outlook.com
 ([fe80::73aa:eb8c:a86b:5a83]) by BL4PR12MB9505.namprd12.prod.outlook.com
 ([fe80::73aa:eb8c:a86b:5a83%5]) with mapi id 15.21.0339.012; Tue, 25 Aug 2026
 11:14:54 +0000
Message-ID: <c20208dd-b3e7-4fe4-a1cf-1d671d3985d7@amd.com>
Date: Tue, 25 Aug 2026 16:44:46 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/amd: Fix ineffective error check in nested domain
 allocation
To: Hemanth Selam <hemanth.selam@gmail.com>, joro@8bytes.org
Cc: suravee.suthikulpanit@amd.com, will@kernel.org, robin.murphy@arm.com,
 jgg@nvidia.com, iommu@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20260825100554.2787577-1-hemanth.selam@gmail.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20260825100554.2787577-1-hemanth.selam@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5PR01CA0238.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1f4::19) To BL4PR12MB9505.namprd12.prod.outlook.com
 (2603:10b6:208:591::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR12MB9505:EE_|MW6PR12MB8951:EE_
X-MS-Office365-Filtering-Correlation-Id: 3aa9f2b1-95a1-4903-f253-08df029a16a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	JnvBz7VrYJO4Om7bgTHp688BuIECpn1V2xu7UkBNtWyAOVd4TScDf9DOIUT6+zga9HBHOIudniPWwFbYGVs4t0B7f65nbcAKacGXs5nExvcv382FYjcLh52oKx3cvpQ91nUjtq6wPxwJZI6V6jc7fdPRLyNlrV8c2tI1P/HfjexWOsEYWLZVu8aloiLeD21aEqaIet/z5FqLy42KE9TONiUTQy4VIs3D12QsiU+hQ51GNwhWDJYXcUp8iv31Hhxb5pxCSy7UYF8IeXKudikSxVhsohkVoaVK86LECSrRef2VUHz4BVyX7eTh6XqpPsvxrMIQDJzT81EMT9CQNUGWdfk4Z3DuaLMBpUW6UYgLh/gl9Q8QuxQRkNt1t3G574hN5OiiXfp/d3PM2mFKFO8pVp5tjOM+uoDwkq6Wcwt8Ewk14SMLmytZsCmLgeknHdsM0PUFlVqNI3gIyTm9BhUyZLrqzpxIBwf5BGKklr4I0seSls//rqf7N7rv8tI4cFCVVCWxoiUT7l2XDotgIhoMOtk3l0GYLc97PN5EGs9L0VgTcdCLC7hjqtYYVqXMXvNSAoUD6lhoUUHtHbI6KD68cxc/uAN1fhqbxvBaS1Kh5UZLjTdrYz8k7GHgNVwqmOxzrzwmZsg+hxy7vG1ujfNDpQ1zB0Trk5EhdDy7QKxPAZo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR12MB9505.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q0xFVlNPY1poaTNsVEhtaXdWOGlSS2xIQnF5bGFSK2k3cHArR0lWU0ZmL1ZO?=
 =?utf-8?B?cG00ajY4YmJOWTlrZHBHVzkvdm5ZNW1FU00xZzVFbjc5S01JQ3ZoZFIwdzFp?=
 =?utf-8?B?NW4yUkJNaVBPdXJBWXBoVnlIdk5IK2xWeVNRcElxNjEvdDkwdU5uZHdnNVNm?=
 =?utf-8?B?SGVrVEJ2NVI3TmJCakp6d0tIRGRDdUp4cUpTQ0c3TVpUK2tPT1ZQdnUwU3h3?=
 =?utf-8?B?R0Zsek5uNStUK3RPYU9yWGEwL1RzWnhmYnljbVNUMWh4TGdjRHpFMVV5ejBQ?=
 =?utf-8?B?cU9ZVG9sbWdaNEVGL2JLSGhBclVxY3RIRTJ4V1U4Y2FPdzRmMmRtcDUzODBm?=
 =?utf-8?B?a1JDY05tTzVaZ3UxaU53Y2JBN1Fld1RtUWc1NFpDaFBiNVF6M0tEb0VEWDRy?=
 =?utf-8?B?dXVER3dmU0ZFR21FMEY3R0FBTUVGcnpwZ2JtMHE1Y0FCWkxoUWFhVW12cVZn?=
 =?utf-8?B?TzZxbm9aS1lXb3FJdTBzbFQvRGN5azBKN0NYTkJZSmRRdS9RcE5hbUpQT25X?=
 =?utf-8?B?eTFUK1RtZmNjTG90WVB5Y3hkU3F6dzVHUG9NcDZPZXBTd3ZiNXNRbkxXRWQw?=
 =?utf-8?B?R1FSMmFLWEZuVU1TdDV5L0NFMjEyUnhpbnRmeEhLUGppMVc4eFM5Y0MxRU51?=
 =?utf-8?B?SkV1MDFoVmtqME5MRmhMdVU5NTg1OWx2c0hnR0dEMXNQWWgwMFZDbnhYSXVm?=
 =?utf-8?B?RVAzc04vTytiOTRaN2c5blIwdVZHM3lsS2hINHc1aVFpckdCSFFTaTZmNlNF?=
 =?utf-8?B?NXpRaGJGWU5qckZzNzJUamEzOXVxbGI2Ly9PQk5sSkh1ZndFcm9RWkpaOW9Q?=
 =?utf-8?B?eVV5aE1UUHpqQmpEWnNYUi95U2V3TDFXd2ROcGFBQ1R0ZUZ6ZStkNjBXa2pF?=
 =?utf-8?B?UHl1Y1Era05QVmREQ2F0V29ielpDY25WNFlHRStLVTEraG13aTlXWWxBUEVn?=
 =?utf-8?B?ZWM3R1BQS2h5b2lnMzlmVGNheFpQTUc0Wmlocmd3eCtaMDRja3VBTzUrOXhx?=
 =?utf-8?B?cXhvMmFTd0ZLTnB2Z1daZVdacmtIc0FoNS90aEh3YitMWmovdCs0WHNSQUpy?=
 =?utf-8?B?djNCZWVLMHZSTzdzNGdoTEFuRGpnZS9UWTFKZVh5eFN2ZFVpVFNTSHBmTzFk?=
 =?utf-8?B?QTR2RlJPMEZOeWE4OTR6djJLVGZJakYvVmZOQnVTMWpuM2VKNFVTUG44ZHEr?=
 =?utf-8?B?R3R5K1M2ZUJKeXhpY3NlSkc4cmdiNnpTWm91V2pMb2JCV0RLSW5qL3A2UEJU?=
 =?utf-8?B?U2krNVViWUhUUFNUbzltcFc3aWZtUzRwSiszVXAyUS9VOC81cWxSRDFBclBU?=
 =?utf-8?B?VHVQcTlzWk03cjF1WFhDcThRblRTUFZOUHhrN0MzczBWMHprdlBCK1F1RitE?=
 =?utf-8?B?ZkV5RFFaSVJrWFBhaTVLTkVjZkVCRUZ3MDU5Yk1Hekg3T09zVUVNVnl0RFBI?=
 =?utf-8?B?MVJMU0Z4NytRT1VSMVJVSzdjYmhYZ05jT2kyUmdjL0RFWjhLeVNRNDFTd1Bl?=
 =?utf-8?B?U245eUFlL01JZmZINUV3cHBGZCtSSnRKcHdSRC9kNGZSYThNajM1VStGZGRV?=
 =?utf-8?B?cVYxNENidTJJclpvRmR1bjhXZmNVSFVVV1oyTEgydzJvcjBlcTk4cDhad3pI?=
 =?utf-8?B?bG4xcVJIMnBhbXErWW1aUEQxcFdHeGFjS2ZQZjFPbUtJRGVhUUxPU2QvS2tw?=
 =?utf-8?B?ODZtVmRrS2RDVURZZnBDTHB4S05tR3VTQXdIanJnUFBpcTJqZUdnNWZMak5N?=
 =?utf-8?B?ajlUY1hGbVhkRE1Jc0hRdlc4cXBIY3Y3ejRBOVNDWGJtMm9JdnA4N1lVd2hV?=
 =?utf-8?B?UGxQa24xdVhzMEhZeFFGSlRaTXppZldSdG95Uzc2WlNyWUpzNHBuaXgrYWpp?=
 =?utf-8?B?K0FOUGJuSDdvT3lwcUEvODRySnptejJrU0pvNDVJV3preW5TNjFrTmhxZFNK?=
 =?utf-8?B?QlozajRKVGdmSFRMdWNoYVZYSkFiMzF2NVVQUlBIdGpuRjJIam92L3dQR2dq?=
 =?utf-8?B?YzI1NktyeVpyaE1QbEVIdDluWnFjWFFOV1NkSUNUdk9aOENiR3I2TWk0MWM1?=
 =?utf-8?B?akhZR0lSSGo5M0Vyd3RraFkyaEFUdUpBWmlHQUhrUDZFdXdQTXkrT29aamxM?=
 =?utf-8?B?c1ZUYWNGT0ZGSUIwNEhQSWdDcDIyRDlkcXpYLzhLbUxKR0VLY2U4SmtlUENn?=
 =?utf-8?B?Tys5aDNEalpqRHJQenFXVEN0QkNZU2poR0F4NDRRZFdCQ2JEd0dlOTRFdFFP?=
 =?utf-8?B?T0hsYXJCUytMcGZncGM3OWttSDZNZDNnVlg4Q1h1Z2VIRzk4eko3aTYvUDRQ?=
 =?utf-8?B?ZFlDSG5KbVJJOGFLbnhGS1dYUWp3TVJPVlBTY0FPTkxORFR6OEMwUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3aa9f2b1-95a1-4903-f253-08df029a16a1
X-MS-Exchange-CrossTenant-AuthSource: BL4PR12MB9505.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2026 11:14:54.1216
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gNmDMaPjanx0qGCSoPqfQOpy0qVSJJhwuPNUKK8hCUyY5hBAADAAgUZNTrGsOOtKeqqZZwFPbwZKiCU68LhhXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8951



On 8/25/2026 3:35 PM, Hemanth Selam wrote:
> 
> amd_iommu_pdom_id_alloc() returns an int: a domain ID on success, or the
> negative errno from ida_alloc_range() when the ID space is exhausted or
> memory is short.  amd_iommu_alloc_domain_nested() stores that return value
> in gdom_info->hdom_id, which is a u32, and only then tests it:
> 
>         gdom_info->hdom_id = amd_iommu_pdom_id_alloc();
>         if (gdom_info->hdom_id <= 0) {
> 
> The assignment discards the sign, so -ENOSPC becomes 0xffffffe4 and the
> test never fires.  The nested domain is then set up with a host domain ID
> that was never allocated, instead of the allocation failing with -ENOSPC.
> 
> Keep the value in an int, test it there, and store it only once it is
> known to be valid, which is what the other amd_iommu_pdom_id_alloc()
> callers already do.
> 
> Fixes: 757d2b1fdf5b ("iommu/amd: Introduce gDomID-to-hDomID Mapping and handle parent domain invalidation")
> Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>

Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>

-Vasant

