Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010023.outbound.protection.outlook.com [40.93.198.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E020051B166
	for <iommu@lists.linux.dev>; Tue, 13 Oct 2026 14:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791902990; cv=fail; b=nrKj5AvOR/RocKVCmvrxGp/KSPigKeIItvcZkJWvxhotTMAeGFIsN1E1FGZWOIyYKNTfy6+RUt1ypyhvMD4ZotRq5i7j/c7Xm68px2xbC1YR/PrLDll7aGuqss0UAMN8bRBO9ELzPdiqlbIwDspNakSGBpeqPIKcqPk7bsDk+cM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791902990; c=relaxed/simple;
	bh=nHG/mV0TeA5zQcVjxGRIiwWigR00BHni0554/kU5Dko=;
	h=Content-Type:Subject:From:To:Cc:In-Reply-To:References:Date:
	 Message-Id:MIME-Version; b=C/wbFY7EtBQw4jeZkNSeXc2v72p+l1bWT6ymbPsvr9FPW6xr372Dv0CFacHhKuIMXZWG8zX6KDtiSYJpcYFfY+49FXuXdSik4h8MnWmSD9zntzweLQ5E+K8a1tk+JKsCc3OJ9LvwPEn3AWNVfSa6LtYWD0ol11375D7Ts7ZbSLo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qfSOflpV; arc=fail smtp.client-ip=40.93.198.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qfSOflpV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e1DU8LlWEvEXhjvCFzYE73fIiJqZnhtXs2jJ8vBmeOIrgLJ/wE1X6rRCIlU5yH1PUMq5f/vNAxJIzdsX2hkf3JDJtfa67YYHH9TLnwJWCgu5IENKac4KXDnh3qMdRDSopFp/JVgNg3sRvhGNjLqg1v0SiIfnq8zgAXcPhdizO+32C3etGqItPk3wIjLT16pSsDV0uxA2gkOgxHEwJZRrI9A00hNIe0wpmm9mmBqeqxdy+6ezc5FNk6Z0RBNDEwoZR+h3GlAkB9eCB7MBWpLm7RjjFL6hpUTLm9HlP+vek04Yg/IwhdmxdSnDQI9CH1cM0/PQGptAQgqrcXxvP9u3BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bm6qL8P9Oe3y/p0Ll4jx3Y+OUG5kOY4JwpM/oiT6tGI=;
 b=TxiklCa4/Ev3ht8S99mI9/x0IK0Mxcla3KAPh1oqXYEmKJPWMO7+4JSUEJvis+d/KA+43zpbcFXhYzxm4O5ES5SKohPspiWnzS+MLtE8of4tRXYowQrrsF34hmo+Y9nI298+yUh2PgQeQDljCDndRbhjUWserQzCYhjp87OT+s9CeaNX6ZFyeHhBVKh91rKYyuDDBJkQ45OF0599m1ivyi7NrQkKHw6ZTQnaO6WewY/jme4Jh22d5a/XVIIwU7M+mxkdew3y3ILj5qaWDxeLCaKwhfK6WrHucGMAAo/YWw5GcNBlpLxWH+05UhJy/fn8IC1EnQiA8fzIFiCWeWbeOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bm6qL8P9Oe3y/p0Ll4jx3Y+OUG5kOY4JwpM/oiT6tGI=;
 b=qfSOflpVdAWwu6mjzUFdxpRliCpf6gbmzMARsO1A7295jhF6PYuQqhKCgWz9NpTUGC2uZHrHvDy7fyNaNKN6Km7TFc9o0o+ihyFnH2BJvpbWlC32Ok704/xjMJa9ONZwCFuFbgZMxk1p5y5L1XXlsYW+xIxVQnqpSwqjLUf3tZIX/EZLJKKPJ+XFpkXB/iHXxVwZNU/zMvGXVJhL4xR42UFSaFRQ4wGGpB14nc5cBPz/Cb12EJ6LsO6FfwAmGgnrd6f/iZ0GR+HgRat5ateKoSqQNVATQOEko01Gkr3rIg/tx4gKQiNWEn5mAetLWf/tH+llJlnFOTMlDmB7m28p6Q==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12) by IA1PR12MB8311.namprd12.prod.outlook.com
 (2603:10b6:208:3fa::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.18; Tue, 13 Oct
 2026 14:49:39 +0000
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d]) by CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d%6]) with mapi id 15.21.0496.021; Tue, 13 Oct 2026
 14:49:39 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v11 09/11] iommu/arm-smmu-v3: Retain CR0_SMMUEN during
 kdump device reset
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: will@kernel.org, robin.murphy@arm.com, joro@8bytes.org, jgg@nvidia.com, 
 praan@google.com, kevin.tian@intel.com, smostafa@google.com, 
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, 
 linux-kernel@vger.kernel.org, jamien@nvidia.com, kas@kernel.org, 
 Cristian Prundeanu <cpru@amazon.com>, Breno Leitao <leitao@kernel.org>
In-Reply-To: <e8f6f198da25cc6b00902cd61bda9e7228cb45ec.1791226953.git.nicolinc@nvidia.com>
References: <cover.1791226953.git.nicolinc@nvidia.com>
 <e8f6f198da25cc6b00902cd61bda9e7228cb45ec.1791226953.git.nicolinc@nvidia.com>
Date: Tue, 13 Oct 2026 11:49:36 -0300
Message-Id: <179190297654.2261874.6563285667925479999.b4-review@b4>
X-Mailer: b4 0.17-dev
X-ClientProxiedBy: YT4PR01CA0104.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d7::9) To CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CHBPR12MB731189:EE_|IA1PR12MB8311:EE_
X-MS-Office365-Filtering-Correlation-Id: 0adadf8d-8c8d-4716-69ce-08df29393508
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|7416014|11063799006|261009223027099003|4143699003|56012099006|22082099003|6133799003|18002099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	skfMx2dIU4IeLjawUjnT7yVHSkfrmm0GM+4Wqs65xxrxCpH4PUzp/Bi1RSHrwaDn40jb2zJpanVM4HtjYioBLp+wK6s0snDcvyhPvn9YUXloEuU5sd1pte6jQd6I2WV8zCxl5gSjR+qGr9w5tqgyZ4NGW9P9ExNUJeMn+trlJADci/TAl2V+mO41jKJVk4laklOYezT+mPdHSGP3LU5lROqTWKGaFmwQixOB9nQ1WocX2inaUbzNba5es4/c79+n8/yoqMBjTxh183IgBf09F0ZhGInx940/F1soAMLhmJNHbh5DyhGKlIKsCOU0LXXph9pxPufXJVFzUp5tABsvNUh1mhHKVVV4pK5QKYr+IX9MkvwMpkvJqQ5BGE7rrUuADAuwtqsc2CXvikbYj3AauD7rz3NIOHsFPIasmC1RZstNhPaMuFssSMdXn3XlBOFXQaT63DtM4xYbaxisAc2DE7oApal6A4WeFScekyEFrTWuHs2m9Lb3Z8N8Z4ZjPomiRF7MqFH/B4gjyKnC6iqr6+m4pvEpVdZNxykVmDPjQwY4V+QgZ2TFz/a2THECwnx+4rwk6v+jar21tiVmp9Q6lQj1Hhkq/7otmiy7J4xLLbHfXDOiij2iO70gKC+By622iBxAn39D1nwqf+pQT9KwKe81emdTGGoqI4TrLLYTl9Q=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CHBPR12MB731189.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(7416014)(11063799006)(261009223027099003)(4143699003)(56012099006)(22082099003)(6133799003)(18002099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZkJwVFg3azg1ekNRekRSK1NrOUZxNjRIaXNDVTNoU1BWNWQxSlZDQ09LSExv?=
 =?utf-8?B?S2lwUTZjYk9xRW9ib0ZaT3BoUFBkUnM2TWVqUEhlUHAvaGFzWUJPVTZHWlBE?=
 =?utf-8?B?b2laK1QrUWUzTlFFeEZYS0tnc3g0dllIMlEwMUJaK3BaekZSVlMxa290SVlj?=
 =?utf-8?B?bzhNWTJ4UjI2VXVXa2JjaHM1TU1xWWp6VnlXOTc3L0x4WTFPV2F0bDVPUStv?=
 =?utf-8?B?RHhsSVpVcHdXZlBpWGZWWFZTalNiMkZacVYwSVE2YysxV0VrNUdUd1dWYkNa?=
 =?utf-8?B?Rkc4Z2lLVGI3VUlvQWw1VC9sUXFTVlBndExkNUswVUZlb3pEM1pKT0dzZ0NF?=
 =?utf-8?B?ZXlBZ3gyU2Y1RHU2L21aT1g0akVNVDlqREc2Qk1LMUFEOXgvQ1lhZzVvMFho?=
 =?utf-8?B?b3BKZ21jREs1bUFSc3UxZ05YWGFtOTVtMDZsaFhUNFovMENMNWdwcUNycDdy?=
 =?utf-8?B?elY3bHl2Y3lJT2VaYVJ1RGNxeXBQSGdFTWdLNkh5c3h1L0pWVjlYYnRteThz?=
 =?utf-8?B?UFgwTHZxWTRZQVFiVnYyQjVXb3phOWpDZ1VPcEJrdlhrcnZ0L1RoMFpGOFVx?=
 =?utf-8?B?K3VoamdoMWU4VkI0UjIwNTB0aDJQRzNiUDVvWVRjbC82Wm5rK0lxSTVZeUpL?=
 =?utf-8?B?TERIZDVuYzJEQVhkRWhNM0VUM3BFVllDRG92TmlLMERhWVdxQ0NlZllXM2dU?=
 =?utf-8?B?b0VmRGt2V044cGsxVDhIZy9rSFV1ek9BVE9TcVJIQ2VobHFNZTgzT2gyalhk?=
 =?utf-8?B?STJCWFlFemRRUEg4enFKN0kyRDNzeDRVQVFmVlR4amJWWUM1cTlEeEhIdTJt?=
 =?utf-8?B?UVVNOHB1K3RodG9WM2ZLTlNzNGdNZFpxUjdhRUFyVUtKMGQxalVaNzQ3Wklo?=
 =?utf-8?B?ZjZ3QjZTT0UycnVTVEY3bUxzOHN5Q2xJdGpmWUwrVFBFaFVvRERTMnNCTkk3?=
 =?utf-8?B?cHFRMjZwUlFMUC93Mk1DdDFBcWpKWVA5aGUzUHRYdTdwUVNhSWZDemhsSmxR?=
 =?utf-8?B?cVg3RVRPMTFvL1M3V3U5cjZsTVZIL0poZ0Vwc1hDQTY0TVNuMTJuTit0Qkxm?=
 =?utf-8?B?TzNobDkraVI5QzY3Qk9pRktzNkEyNkNoUFBOWWVnRDRVNGltcjVjVWt4OEky?=
 =?utf-8?B?akN4RXJJbkJjckJ6TGFIbm10eUlOVXdhSmttcDl0RmdXWmpOVXF0K0VZNmFS?=
 =?utf-8?B?QmxhemtVUVg2bE5nWWl0dWFRaEVnMTBrK2ZZbWlMQlU1S1k4OUw5Y094VVkr?=
 =?utf-8?B?bHZjMHZnSnp1NnA5TngrSnFhd2xjUHNKbGszOHUzUEdvWnFCUDV3SldUNkpr?=
 =?utf-8?B?bnNiK3BLNERVSlNCYncyQkpxUFBKOWJYRkE4eXA5d2E0YUdpU05VOUpXT3BN?=
 =?utf-8?B?SjF5SEFXRWJhYWUxUFRHYUdlU3dCNGNWc3AycVYzem5PTlkwZjI2UGtzUGNK?=
 =?utf-8?B?S25QdkZWWUZHUCtYd1NYMUtVajVJU3JiTk8wbllnWUs5MW9HcHNoZmFiY2dr?=
 =?utf-8?B?MFRWZFNrK3pTb0VhdmJheU1KYmsrd3RMTVlaK3NXcEZnQXJtRldKY08yckY4?=
 =?utf-8?B?M3RiNnlPc2JwRnlxMUIzMWhldjFIbDBncUE4cy9RLzA5MnBEdFg1YndyNi9n?=
 =?utf-8?B?MmI1WDVLTElzd3gxZEhuZGZsaExiSFFNRUk3bCs5di96TnFmMGRBb3AvVFdB?=
 =?utf-8?B?bFVjNngxbUYxamxQVy9DRCtpNFFqZ2hzMm04RmhOYnJ4NG40NzhBbnd5cnNl?=
 =?utf-8?B?bXJkMjEyOG1yVHN4b2FHclhJVGdQYnozNHpjTzRQaXlUSHhFbTRrVWZoSDRW?=
 =?utf-8?B?WkNzVEN2Y1VPYWMvZmhoYWcvUkhDQXJ0QmRRd1ZhYm1PWmNZVk8vekNlWEZX?=
 =?utf-8?B?NkYyS0tXWXpkSkZGQ2l1VnY4YytHL3pmQVlCczlUVEpGaTVyL24rQUVzbnFK?=
 =?utf-8?B?SnR6RTdlRTRvK3dva1hwSUprZU1HQ1NtOEh1R25xeGI1YUliVHJzNWdCU1o3?=
 =?utf-8?B?bDhYTVJRL0ozdnFzTE9ERVBJYzdneWJETG5mcEhmVkhVSThWMENLZzRMQklO?=
 =?utf-8?B?U3h4K1p6b2o1dEczTWQ5TUxUY1QyVG5zNTZMR1I3MUdqZjc1dWZEZTJsK1hm?=
 =?utf-8?B?TXpyeHBaS3k2c21BNVBPcTlNTHJlUkVtd3VrcEs1NWZleTh4MTZjbENIaDI5?=
 =?utf-8?B?UlpRNWExOVhSNHlvWlBSYytWTGJvbUJzNkRiTm1Tc1N1QzZyenFZZldmeDd0?=
 =?utf-8?B?ZjhEMnRINGlqRUR0b3h2WURLVHlUL1RoUjVRdlluSCtSRnc0NGszYStkaC9F?=
 =?utf-8?Q?ovm4OXs/0fiF0aMEKC?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0adadf8d-8c8d-4716-69ce-08df29393508
X-MS-Exchange-CrossTenant-AuthSource: CHBPR12MB731189.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 14:49:39.0603
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T744tnwcMWQ7fyYNS3ZAUXgUWHigu4JH9BqeTvdGffA0pRAY5AXD4keC4Elq1pDN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8311

On Mon, 05 Oct 2026 12:30:52 -0700, Nicolin Chen <nicolinc@nvidia.com> wrote:
> When ARM_SMMU_OPT_KDUMP_ADOPT is detected, do not disable SMMUEN and skip
> the CR1/CR2/STRTAB_BASE update sequence in arm_smmu_device_reset(). Those
> register writes are all CONSTRAINED UNPREDICTABLE while CR0_SMMUEN==1, so
> leaving them intact lets in-flight DMAs continue to be translated by the
> adopted stream table.
> 
> Initialize 'enables' to 0, so it can carry the retained CR0 fields in the
> kdump case, clearing only the queue enable bits. Then, preserve them when
> enabling the command queue.
> 
> [...]

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

-- 
Jason
