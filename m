Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011007.outbound.protection.outlook.com [52.101.52.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2289C470121
	for <iommu@lists.linux.dev>; Fri, 28 Aug 2026 14:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787927268; cv=fail; b=kOv+LvHjh25Lg2//GIF7XzjpN7xVo9w3KlqIEBHaGfjUf2j9LnwIezG2SeaZKMkpEU8W4f8V4V/srwMTzC49kl2xNrrbyrPBi4VQ+7cFAeIfEbeXcwAA+WJAO2qkjxj44qwXadFrLHxkCd1ruLaIIxcITp2JEOQESZz2Drlad94=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787927268; c=relaxed/simple;
	bh=N7FOU+hnyeFvyGc0QnHiEg/XzLBjNTRXl55UFy8jiS8=;
	h=Content-Type:Subject:From:To:Cc:In-Reply-To:References:Date:
	 Message-Id:MIME-Version; b=X1uKHDjzlq0UBw9hzITAv8L0c+xUoZQ3Bfp3MJv4HcMH/WoLw4QC/P/4SMWNYJsCK0vUAXojAd/JLVl1uOeVqTrEE2cLMF3epQTOX+p7cRjL6H99RVBvOxkCyvDhfpJmY4UklNntabXNHiqylZ8TGIZvyu4SWJeXVXDF3E+hFX4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CygN0sY5; arc=fail smtp.client-ip=52.101.52.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CygN0sY5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c/dEynLYZOK9mjJY5n8C/NUNRts62dypy7HYs4OF/VaaerKyu3PVUSirngvCQ2u/ILddi9lC4zGR8FnCexcxm/QV1E6oklpJCPL3g0IkZBd00QQ5W05nvzdVvAjjQlEk+5ru6cuCImncQ+JclQLJU13Xcurt5fwynpuFY/dQ9nDTb+j9W1bORLUsbEz/J/gxUuMNDhflhEAqAWj2FowL295vEKp5ivZGe7yPkf+BvJo7mor05qOqQfiZrwfmTqW7pARbFts7b9L6cAtuj5jXzNAcd6MgYVWfrlDcSWmktKEfZCigJU3n19m7iqTn7zuTtOf0lhQkLsG09pTBEuBsWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=62rtuImu+cyRpqS1POOTYM4+cxmLxxCimDhBBDTrYI8=;
 b=Qby+RmvmzNWPNwUS6Qd+YjNuYWBowoo/3+aXYcpw2cvCmpnGD+nsIiV9mH6N+9l2CVIBT+GWX+X+84oYw5/+/SGixB/648EQ5ueDivHZss3B4OviclvCmFJa1qzfdeaOhcPoYUfwnbYvRgAz+4xgiP3v28Oq9i9cTxelpY7IJsKUnky5iBvRyvGQL8PEZLn2YB6EbQ4kEfkdhfs3JQB9pbGnXC68zvMnQqhHVGp3BEUoXiQpx4VRcz5AzKaoGR2KKKnswEJPqrI9qfc1Cxxx8Hzf18JOs21I6YEZyMZgchkSRpYEwnLK+tp9zVFCMtU+DRcooR9aHgwqnywL1NkUfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=62rtuImu+cyRpqS1POOTYM4+cxmLxxCimDhBBDTrYI8=;
 b=CygN0sY5+if9GJWBKHniy04wYY0byacRzzug2UuIDDCiwr9ZvDFs3h/YfdEdwtQaBGWNgUfvv9uek646/CbWtS2IApkbZKC+G3A5PiUXJJAgwtI09WE9GxWKo4LgkiqOT0/1GUzpxIkI+4yZ611EKmpuq18fq46kMKWyvFzFYZ3Yueaeg6R3d09KMT05FeqfoZDVfoK8lKvzkah01Q/1Smq1cqwuqLcrVyu005ozalc+FSINkQgnZ/LTOPRj/fuIUjysWDTf7VmvLU1Wo5YYUNoJaLOYHBQRj0wMeomB09h6M8eO3kTJLvcUhFBlHlGyuvfNNAXcc8Drp7+L18SsLA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by BY5PR12MB4275.namprd12.prod.outlook.com (2603:10b6:a03:20a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.11; Fri, 28 Aug
 2026 14:27:29 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0360.008; Fri, 28 Aug 2026
 14:27:29 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 7/7] iommu/arm-smmu-v3-test: Fix UBSAN error
From: Jason Gunthorpe <jgg@nvidia.com>
To: Mostafa Saleh <smostafa@google.com>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, will@kernel.org, robin.murphy@arm.com, 
 joro@8bytes.org, jgg@ziepe.ca, nicolinc@nvidia.com, praan@google.com
In-Reply-To: <20260828125409.1921538-8-smostafa@google.com>
References: <20260828125409.1921538-1-smostafa@google.com>
 <20260828125409.1921538-8-smostafa@google.com>
Date: Fri, 28 Aug 2026 11:27:22 -0300
Message-Id: <178792724273.3808739.4846429490545506144.b4-review@b4>
X-Mailer: b4 0.17-dev
X-ClientProxiedBy: BL1PR13CA0092.namprd13.prod.outlook.com
 (2603:10b6:208:2b9::7) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|BY5PR12MB4275:EE_
X-MS-Office365-Filtering-Correlation-Id: 83033529-0b07-4f8a-38a6-08df05107bfd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|1800799024|366016|6133799003|10067099003|11063799006|56012099006|18002099003|22082099003|4143699003;
X-Microsoft-Antispam-Message-Info:
	YYxpGE39xxx7z8iBZwZ2u8y7/r14jVlAFwxFCJUg9PFQAFKLuzXRvh6HyH1+3HRhyA0VDAB1+XH8gcPeYFi4o0woNaJHOxV1vWYTnEhyOYJ3qFFj2HzRHHWQsLpuPVMGNAlJQCoZcNK9NzPllnM8bfLdaWS27I9q9W/FsS3n2J2VbQwrqP4houpf+6RQTnTeFvSJzcU3M51pHjbw8YlS6A/VMRMEd/FkCIka0+pTxLn8rELM84nP3yndwjJxLxgD6GS7v2+dJqkZFUvsEJUJvqC0tkZtofFPRx9oYOjAqtLx3S+5dXv55NZmE5l/GUc+C1hstxduTUE0DhHkRVhvCV9xXKlncYrD3dkAu/Q1f+fAExt1SSMPuJ2gDKHBtIvRxHAE0/G5tBwDyt6PmbdUN5Qdl7jKlCtwPbBWj1XaymTJnZw6KTTkFYwVWC+S6nHGd/SgYKT9GJ6t1WVT8c3BkQGvaV2uSSV6hxSaTas+ubHVKGFbBzraek5v2fqwWie+PPuG5OVPamxdMneuT3JfnVN+7tS6/qQzqqEGXMhbvHhz4PMA0Gl6glBcyxVAdD0ogFYXPDHdbvRZxujt+HFX/V2VvI5+Ra7mrZ1Sk7eo8i3LPBQVTnMhibjaG2e4ttSh2XlZJG/MlT/sWax2HQtBuasppYznDGAlc7h9jY1fiI0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(6133799003)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RGwzemlCRDQ1L0lYSjFlVXFiUUg5Qlh0L2lSLy9ES0ptN2Q3STRYR0ZmcEkw?=
 =?utf-8?B?c2RtUGhzZzBBbm9QcVhBY0JYNVc5NnFkTEs5bWxFN05HVkh2UDhnQ1YzYlp1?=
 =?utf-8?B?UzgxSDdZby9HUldBdjJJYUZCWUFnZW4zK3F2WjB0V3BVSWlHbjZjY0E3Q1Bl?=
 =?utf-8?B?MlUzK1F3Z0xLanZ1Q3NKalUwN2J2VWFIRUkzVzlWNXl0TWt4MUd5ak1ZQWxB?=
 =?utf-8?B?S0VyWFVqTUh0aFM4L2wyZkNzMGNSWnNVZ1dwK09jcXVuekkyaEVjVUJoMm5W?=
 =?utf-8?B?RDNUMHBLWWw2OXRxb0RseFRNN0Q1dEg4T3NvTituK2JZeE5QV3N6bStxd1Zs?=
 =?utf-8?B?VkZaMkl4ZTJpczZJK04rdHlXdEpBMVBrbDBTcEpBL1lWaTVSaXJOSmhLVFdH?=
 =?utf-8?B?OXQ2REluUVEzOS9weWtKQ0IxTkh6UVAwemVlZ1Y4R3AxcXpsUURoZ2hlUm9T?=
 =?utf-8?B?cGcyeGJQTnFpQXB0SFNkb0djK3Bnbk9NSmZSQ1pXUFUzUmJuNmdzYysvdncw?=
 =?utf-8?B?M25NeEpSNUkzVDdML0M5cnQ2WHJ5UE1Qa0h6R3N6SExueHBHQWtlaUF5cmxW?=
 =?utf-8?B?VzlLdU5XUXhseXZ3TEhNL01QRTgzdEgvRTU5Nyt4aTJJZ1pZUGFjaXp4L1c1?=
 =?utf-8?B?ZlBFTzZNMGRCbGV0TTU5b1MraWwzVnp1K21KdkVUQk9ncGZaemc0Mm1FVWo5?=
 =?utf-8?B?bE40WWMxZ255dmlFbDA3NmFUQzdER1Q4ZXFNcFU1bTlUNmhDalJHNUxzWm45?=
 =?utf-8?B?V3JLWjkrY25OQkphMjNTUERUT0xpMFhlVlZ1VnBOSzVBUU45a2IzQ3VlWGhS?=
 =?utf-8?B?VzVJZ0pSdVpRUTdKK3lYTEdvRkRkSVlpRWpraTI2N3dydE54VTJWbWhLOVpt?=
 =?utf-8?B?S3ExT0hHK3YxWENGaGRyaXNocXAzWXVNQ3phNURuTXN1ZzVwMmVaQmlPcVZ4?=
 =?utf-8?B?ZHBwU1RXWm1wcENtNXJRLzVlM25MSzUzT2YxNHVOZ1I5U2dJczB0VHN1Vncz?=
 =?utf-8?B?VUpXaXd0VWQrY3JEeno5K200c1B3aSs2eWVSaE96SmJudTNqbnRxWnhtZjZW?=
 =?utf-8?B?MUp1SktqOWpnWDk3WHhsTDRlZmRtdWpoZ1ptMzZ4SEFoeEJvTUlEWEw3NzQw?=
 =?utf-8?B?M20xbkN1SS9hVElIUWFDQVVpZ3FwaEFvMWhTaFU2YzB3bTNiVVBKMDhxZHlR?=
 =?utf-8?B?MmQrcG8vVitkbldTTXlkVGF6Q0JBZW5veEV2a0h6dUxiTmI0bmhzTnVOVFJB?=
 =?utf-8?B?eVRGaXNGVmxZNzIvenhBTTZEQzdpVmVlWE1WMXI0b2RtU2FKdllCYmxmK1Vl?=
 =?utf-8?B?RVA3L2JxZFNGeFMreExxOGVnemJuaExLTFRDdDNHOWd1TTR6Ui9ONURXYVc4?=
 =?utf-8?B?eHZBTm1ubCtsQ1R0ZzBJdFNxbERPSlhzTmo5RDVLb0ordmRiYWNWanhpWXBM?=
 =?utf-8?B?YUJXbktNaExkU1ZkZHFZcDVMeEYydkhCUTQrR2wwREpEZ3prTUxmOGM1UGZq?=
 =?utf-8?B?NVd4bkd6L3hvdG9QUnQ2ZFoyTSt4QjBaT3JTdjd3R01mVDNOckNJdDN4ZWtX?=
 =?utf-8?B?UFd2dW1Fd21oTlVnTWVYaFQvWkZIcFF0OVU2c0FPOVNpYXJpTjBEdGMwSzFP?=
 =?utf-8?B?UmJ0YjRoY3hwVFBoRnpMSTdoQ3BQQTI0V2RCUEZZZGp1aVV6QzhwOWFlUlht?=
 =?utf-8?B?RURRRDlYZ2RFSVVPYVhyM3ZqTk5oRGI3bktlME1CeDJ5ZktWVlBYMFF5Q1hl?=
 =?utf-8?B?N3NrOEtkZlpwTC9lTGFmZkhrRWFiMVlVNDJ4a0V0MXBHditLUms1aHRDaXFJ?=
 =?utf-8?B?aEorZzU4bkJUcEFEaHQyL3pyMFpXTit4Sm1WZzBmWnZ3cGtiNnRUMTN6YTlC?=
 =?utf-8?B?UkNSV0thS3lDd0R1U0dVK01CN2NhMzFwUGk5NUJvbm1YaWxkaW9NUm5Qa3Nh?=
 =?utf-8?B?a3UvejRvMzY0SVBubk5HVENubWZLamZ2TUtTTHpuY20vT3d0Ym1PM1Z4M2kx?=
 =?utf-8?B?aWIxRXA1MEFYOWNjU3JOV3NPUXJTejY5dzUzK3NQM2J0dERJL2NpUU8zL2sr?=
 =?utf-8?B?bkdPSDRLMnRMN242TVFJdzNrd0RTZXpJeVhRT2NKeXFCb3VlaDNNblA4ZlAz?=
 =?utf-8?B?c1FFaE9VTlpROExwOFRTMzNndUVYMzE5cmV2Z2twRWZzdjVjTmF5Tk1ZVzFz?=
 =?utf-8?B?aW1xcUJLUGp5RUdncEdDZzlxdjZPN21INlY3Um5VL1hKeHJqY1M3NDF2Sjk0?=
 =?utf-8?B?akMwcW9oM3RCVTkxUlpZM1E5Sjl3MThmSEVMVkgxc29ndGNEOGp3NE9LTTdz?=
 =?utf-8?Q?ePY0qn2U0dLJmJ98Tw?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83033529-0b07-4f8a-38a6-08df05107bfd
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2026 14:27:27.3361
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q1ZpcFJV4yBTotHm0bB9bGoxKeVzk1ZKA0g1+PAUnzXG4m6ZyKBB8VGu8cEycsRk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4275

> struct arm_smmu_invs marks its flexible array member inv[] with the
> __counted_by(max_invs).
> 
> arm_smmu_v3_invs_test() uses invs1 to invs5 which has num_invs = 3
> but omit max_invs.
> 
> This causes the following UBSAN error:
> [    2.333240] UBSAN: array-index-out-of-bounds in drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c:1116:21
> [    2.333604]     # arm_smmu_v3_invs_test: lib/ubsan.c:228: array-index-out-of-bounds in drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> [    2.334129] index 1 is out of range for type 'struct arm_smmu_inv[] __counted_by(max_invs)' (aka 'struct arm_smmu_inv[]')
> [    2.335375] CPU: 6 UID: 0 PID: 155 Comm: kunit_try_catch Tainted: G                 N  7.2.0-g8dcb331fbb72 #2 PREEMPT
> [    2.335759] Tainted: [N]=TEST
> [    2.335791] Hardware name: linux,dummy-virt (DT)
> [    2.336254] Call trace:
> [    2.336932]  show_stack+0x18/0x24 (C)
> [    2.338443]  __dump_stack+0x28/0x38
> [    2.338494]  dump_stack_lvl+0x54/0x6c
> [    2.338518]  dump_stack+0x18/0x24
> [    2.338541]  ubsan_epilogue+0x10/0x44
> [    2.338565]  __ubsan_handle_out_of_bounds+0xb8/0xbc
> [    2.338834]  arm_smmu_invs_merge+0x688/0x8ac
> [    2.338862]  arm_smmu_v3_invs_test+0xd4/0x598
> [    2.338890]  kunit_try_run_case+0x64/0x160
> [    2.338914]  kunit_generic_run_threadfn_adapter+0x28/0x4c
> [    2.338955]  kthread+0x10c/0x12c
> [    2.338984]  ret_from_fork+0x10/0x20
> [    2.339433] ---[ end trace ]---
> 
> Explicitly set max_invs = 3 on the test arrays to match the number of
> elements.
> 
> Fixes: 15a2a5645ad7 ("iommu/arm-smmu-v3: Introduce a per-domain arm_smmu_invs array")
> Signed-off-by: Mostafa Saleh <smostafa@google.com>

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

I have the same fix sitting in my branch too

-- 
Jason
