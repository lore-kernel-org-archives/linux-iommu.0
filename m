Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012040.outbound.protection.outlook.com [52.101.48.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB4654334B0
	for <iommu@lists.linux.dev>; Fri, 21 Aug 2026 23:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787354153; cv=fail; b=aDjqVEikwoOIIJLyKgf3qMvVJlyVM69OtHWRDvFwBRxNlwF7BX1Mxix0slyJwPjuaD11k6wisCtU23uKMvWZNbI+2J7zoO85TnX1C2Se5YiK81Bnsrk5DwGtsBXgHLtKL8N9Xl5D2RHedSzgWVBeK02CP850LRrKuubufCzlwso=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787354153; c=relaxed/simple;
	bh=qksTDNdIOx825xaVvS0aKFvrrQ60v8c6hCISuI8oDuM=;
	h=Content-Type:Subject:From:To:Cc:In-Reply-To:References:Date:
	 Message-Id:MIME-Version; b=R/FPYJ1jH9mJ5Q8+q0HrOvxvByWCLLJedMMFJwCsrm0BYy396k/S+p51v6Gf1vTpM4pkDaYoc2CM7UbmAd6A9J3TOoLSF74DhaF5vl6XY3Lvy2frmk8EgXabzYhzXCa8Li884wwrSb6CqyelcQuVIlfaoW+UJW/feg7cwdzhmsg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XGLIH8mt; arc=fail smtp.client-ip=52.101.48.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XGLIH8mt"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yohRGDxvq1U1BjCQW1FOqh8zpr0c7UeL6+B5t1QoZki3Xltpf6hrV0L/EO4XuqQah3/J+DugPFzx3bFbD3d6ZDFKQ+/n8q4Gv/Cxm8Lg+B3gYBN1wMC+Svqv2eh1pjyoBGzBV3MIvq2ioyBnJJSTJy0NZMFDBokqdc4rWq/vxyDS1OcTGCUAyAz9lTnfiV4lAuBdR7TTx3Jk62OtNm80cm6QJBybuY8NW1Vv2jlXCenKdvmzHv6azdRq8xJiwE7zE4AANs3XBiQjDaP5v2iZslEH0QtGjYsCtJZ/+jGq30RviBJR0xoSQKNQHLHMbPHYJdnTGHFu+eVj5+ikapZ6QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IgdZEUnjZ6a8tVUicQlhjTPEhQl/cOzp3rxYvvNCNnE=;
 b=g6MAXVhW4y1PsXgdvTW7D3t84RUsH69lpwuJEE928IAgr7NnFrAb8spvdCcOXScR8TBKfdmBUv8jQOOYDn5r58612A+jG1StI6poWQNIKdRc76ew9EDBaORiEAqoxZTfKe0vCvoKNY3KD71e5NWsBxVpYqu/cn/fC7+8KoCiM9OvEVGBAjRFDkv3PRTCqMcTsylHLV5pi1VFdZu96GE9e7N7vlN0aFLRaWTEucxrvaKPJRYJyKdj38mzqyvI2lxyvQtWDxt4OwyFwNHRYWct1dketE4OE76q7wT43ackb1rSg9uzfrw/+8Sj0E1mvQK/FdOhsoRxCGcyFA4cvKiWxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IgdZEUnjZ6a8tVUicQlhjTPEhQl/cOzp3rxYvvNCNnE=;
 b=XGLIH8mtlyRN7fprMkj7UHGs4m10xkcMxSb5DxBoLVIoxG1xxxDpIU0e6xbZL6QKpgKNaSJaWMh+nQ1gJok1Jr7YJQ+vZwag1VYdwcJvfMABu0I9ifCMvZ60m0ktrOa/SKlYbiFYojiNTLimYrem/HwVMVm+r+qnVGHQpEbVI5NY2u8s2GgHWPFpXt9Z5o8iY29TmhXH9kIUmgQCuSJmcamAsTu9bns4t5hkq/RwKyYqFAbFCedhnlOFI2oaFajloPlDFjfo8IvYnGh2RiI00hVIOSXBPdPHbj/t0+uB3kAcAqj0Ip91xwP10SQISFpNt8YcQQ2HiLMl0+BFpOjLGw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by BL3PR12MB6402.namprd12.prod.outlook.com (2603:10b6:208:3b2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Fri, 21 Aug
 2026 23:15:31 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0339.010; Fri, 21 Aug 2026
 23:15:31 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v9 11/12] iommu/arm-smmu-v3: Skip RMR bypass for kdump
 adoption
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: will@kernel.org, robin.murphy@arm.com, jgg@nvidia.com, joro@8bytes.org, 
 praan@google.com, kevin.tian@intel.com, smostafa@google.com, 
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, 
 linux-kernel@vger.kernel.org, jamien@nvidia.com
In-Reply-To: <dfdaefd08bc5e61b1b569919aa4f34118dcc98cb.1784663184.git.nicolinc@nvidia.com>
References: <cover.1784663183.git.nicolinc@nvidia.com>
 <dfdaefd08bc5e61b1b569919aa4f34118dcc98cb.1784663184.git.nicolinc@nvidia.com>
Date: Fri, 21 Aug 2026 20:15:26 -0300
Message-Id: <178735412603.18212.10290921432456136177.b4-review@b4>
X-Mailer: b4 0.17-dev
X-ClientProxiedBy: YT3PR01CA0126.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:83::22) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|BL3PR12MB6402:EE_
X-MS-Office365-Filtering-Correlation-Id: 90090832-5f47-41cf-07e7-08deffda17ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|23010399003|366016|22082099003|18002099003|56012099006|10067099003|11063799006|4143699003|6133799003;
X-Microsoft-Antispam-Message-Info:
	l+FpFCG8Eay0aZgaEwJ/eOlNXr0eEsp/15L59v5G4LkVjoZjIgtAEwcbIX/b3G0jQCqrFg8cWjvr7HBZZP+Ojos8s1lT4s/zynSNECd4hW3WTCKOlenvqZl7qFS2My7xMnpnh9KwyXyH6+x8tPvoBkYz7ZwcMqI/Tt6vp3YkbTdyl9IoUqPuPSbBJeNhNaCnEuPtk38Aohuo/82RXes6NO1pCOB4Lnj5qodRtBkkezagXPVfXTQTMYZKTWrMi9MJZsCX/wTCPnYc64Y0NHxZNEukU+SjIRF4z0GnyAI1ObSoSy4X1sE5PD+aJe74hFX/7GlvZWT31tXkit88ltiVDcGjP5NLd4/1ysZ15yhnvOCjhrBAE0+eu5WR/c3FNJbnKollmOrLP8dciLFeh2+MWyEG3oQcB54oJ32/LX3o3b4x9YL87wLH09P+n1t9k4cPaYxdce+T0Ffi/frO0kHgYUGPYR5Dpd8NhMU3XbW0R0LNQhdv8Q55i0LBspkRSOSyUCavGzJ1+UE2HylBZfKFc2p8roWve8lo8SzJ8LlmqeQiC0QbzIW28pr//Hsslb0GSEpyR3OsWYSvJnQWVkUbN62lwlfV2mwcyAG/EXEjmGjIcO2EQ8QWR3ID4mSbt3d0YasYBYDAw4LnkTNnC88GO6rsy/Rq4UuyAANZipxVZbA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(22082099003)(18002099003)(56012099006)(10067099003)(11063799006)(4143699003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QkxSK0hUNmdndmdNSkFIUUZFeHIxOE9TUjBnSDM4U3FiaGU5aFZkUU13alFC?=
 =?utf-8?B?cjBMcHZla081dndhMmRZR3U5d1pOTnhMNHdieWZtN0JsNERzTjNEMks4RWFr?=
 =?utf-8?B?OTlnZUhvWklrUGN1MnNMMHg5YXk0Wk5mTGJ6UmVVakhZWWE3YXYwWEh6bXB5?=
 =?utf-8?B?RjVXSW9pZFJWY3dSVzd0SFNydlE5dldrcDNvenhyaVJxbFRlVlllQ1RUK0Vn?=
 =?utf-8?B?dElnNDRlenlpbDVNTnlQZlNxeGZXNEVPWGNzaG94UXJ4QjVrZzQ2Vm9GR1dF?=
 =?utf-8?B?T1pJZUo1V3hQSzRIeUI5WVU4QTJLUUUzVGR2NW8wT1RJL1JBYURGRjRNU050?=
 =?utf-8?B?MnJYOFliV01jdDJYNThqN0FPMmtjOU1Qa0lod1djblpaM1hPWmxiRzVjeXRG?=
 =?utf-8?B?TW5WWE9aMUUrV1g3MmZBa29zSTZTNnYwRDJPWm44YkNLZW5qUnV3bko4Tmdw?=
 =?utf-8?B?N1dwd3dEcjBHbU1jdjdlSVo2dUdod0N4Q2QzV2pyWHFVdUkvLzFZNFZpV3pw?=
 =?utf-8?B?SXpRQ2tnZy8ycWxPY2JNcldmYysvTUdDVjJOZHRSSE0vc0RMT3V0TzFkWll1?=
 =?utf-8?B?UnN2ZVJkNGpYZXlBMkFKcUlNL0lTRGJ5WDVXRUU5eGFwNCs2ZFEzVmNuTzgr?=
 =?utf-8?B?WXJ3VWJtYVprMm04ZjFuSGlSYUxBQkx4Szdad0VHcUFXemUrZmVSeVBDSVQ4?=
 =?utf-8?B?UXU4Z1RBeks4bUVNSFNjeUlmckcvbFJEdFVWdUsvS1dYQzByWmlpVUhYN2Fv?=
 =?utf-8?B?OExXbXlVUDVnWndDQVVibGs1OVQyRmJKTHc2OVhLbFJqT2tSS3VOaEVhZTVU?=
 =?utf-8?B?YTJ2M0pCSkJlSnBYZWNPN2d6clRNNkt0UUhKV01JTmJyRnp4ME5WeWZVVUZa?=
 =?utf-8?B?ME1DM3p2aklnb25JK2JvOE5vQ1FBRUVGOVU0WDdtTisrZU5KcDBzbUw1V2F1?=
 =?utf-8?B?d09GWmsyeEVuTXRybmFzeE5uMzU2c2E5VnR2a3FvbkdtZzRscGQ0Wml3Ylk0?=
 =?utf-8?B?aU94TjhiQk1QbXRqK296QjlxZ0NhM0x6aXZTRTA4MmZOZkJ4MDM1dUJWRW5L?=
 =?utf-8?B?cXJSSm51YW1uazFGbzdDT3llL0FWOW9tb1lxTGg4R1Rpa3lDSjNNZ2VLV1BZ?=
 =?utf-8?B?Ujh4SkpUTTRNMkdTSSs2YnQvTEpxT1BmdE14QU00cEJ0eXJrWmxIcU5rbmZQ?=
 =?utf-8?B?eWxzclVySjE1T1lGM2xSUUI0aUtzd0M2Wm5EaVI0ZW5GY2hmTlNLM2lIQlhl?=
 =?utf-8?B?QVRCOVhmS1JnYnA4cWMzeXJtZ2FiYzErSE9vZDBjYnJzRTRKYktmbWFEajFW?=
 =?utf-8?B?UmxVclJZaUdIMDA0VEhQengzc1F5SjRvY3hjNVpzNHFkODQ3M2hLSWh0WEhL?=
 =?utf-8?B?RTNTNkIrRE5OMVNjUS9DdnRqcGNEekJwc05MS0hEYlJPNytqYnRmekc3YndB?=
 =?utf-8?B?SzcwYVJaK0IxMnhHaUtrbGN0Q0FBYnp4U0FITkgwWWxVWUFFemc0djZMNytF?=
 =?utf-8?B?Rkg2ekkydWVzT3VzZGxyTDVEdzhJR21EUUprOHg4aWtKZStJTUFHSVFhTnZ2?=
 =?utf-8?B?bWhWRU9yc3RWTUpWSzhYSlFaTnV4dFRBckhYVjFRUVhuTzVHUzdva3l4WEpB?=
 =?utf-8?B?bWdXMzJjU1psLzU0bGI1cUFENjIzV2lMY2ZHSmE5UVlPcmsrb3ByODg2dFJI?=
 =?utf-8?B?RzgyYlBoMmZZbEtzWFJSZENSYmcybzd0di85aXk2bittbnk1WDBUeVNUeXUx?=
 =?utf-8?B?aHgrY2t3MGVjYTdsUmhOWkIrSWRTWEZUeWREbTZjS2o3QnNJWEd1Zm5XZ2hX?=
 =?utf-8?B?L0N3OFFJWFNNdFMyRWpaZzZpU0t3eFVBK2xBQktEMFpFelgxZWRKUEh2Ym5v?=
 =?utf-8?B?SCtVOWhybGtYdUhBQVdldzBER2E2Y0FCWG1pWCtuVXVhUmt4eDA0MTMvWGFP?=
 =?utf-8?B?Sk16bk10emlGTDFLTU0yTUd2OGFacFhZUkVubExMN0RORzRpUmdITm0rYndF?=
 =?utf-8?B?TWNyY2lDRzhDZzl4aXgvWmI3UDRWVzJ3c1VKUTh5WlFqWDF4ek1MeExoREpB?=
 =?utf-8?B?QlZBVk1LdXRaU1RqQ3BpalRkWGNLME9BYUxBYUI2VUZBd3RZVlM0aEZvYUYz?=
 =?utf-8?B?dExYcCtmQUdZRzFHREQ0RWFqK1o1TjEwWWZ0c05COW9PRTBVa2pVclpYWUtj?=
 =?utf-8?B?RE9RcWhHeGM2UFhuVnAxREF1Tjk1bWwzd1FPRUpWbHYyUzJ3dVVXWlo1MHF4?=
 =?utf-8?B?QmZWVkxMWDY0aGp3TjdrR1gwUlFxZHdzNmFOL2lqb0NNOWJHVzFZK2pKRWNx?=
 =?utf-8?Q?//gbraLVou+NxUVpKZ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90090832-5f47-41cf-07e7-08deffda17ff
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 23:15:30.5324
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7Kf8k044qn0aP5n35C1F8fJ2iSwgW3NRXrf1WOzFIIS/facLkkQN7FsoPxZcjjc4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6402

On Tue, 21 Jul 2026 14:38:38 -0700, Nicolin Chen <nicolinc@nvidia.com> wrote:
> RMR bypass STEs are installed during SMMUv3 probe for StreamIDs listed by
> IORT RMR nodes. A normal boot switches the driver to a fresh stream table
> whose initial STEs abort, so those RMR SIDs need bypass entries before it
> becomes live. This preserves firmware/guest-owned traffic, including vSMMU
> guest MSI cases built around RMR-described SIDs.
> 
> ARM_SMMU_OPT_KDUMP_ADOPT is the opposite case: the driver keeps SMMUEN set
> and adopts the crashed kernel's stream table, so RMR SIDs already have the
> only translation state known to be safe for active in-flight DMA. Replacing
> an adopted STE with bypass can turn translated DMA into physical DMA, then
> point it at the wrong memory.
> 
> [...]

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

-- 
Jason
