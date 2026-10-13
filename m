Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010023.outbound.protection.outlook.com [40.93.198.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B6DC51B188
	for <iommu@lists.linux.dev>; Tue, 13 Oct 2026 14:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791902992; cv=fail; b=ugyXD+72KA+hQ2EAUy35SP4L5Q8pSblGA9z/1hWX44D6tLjgk4I/5VLqLaqtGt0I3Msyctfki8ixzA3ndwA0jkMw8sXDyfTdC5nVRh/MMCYe2ImT5tdfWZQ1TpqS7PvGxvsortD27nnAbU6j0nh+TqKSFdQemlxOIDsGRnH53Q8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791902992; c=relaxed/simple;
	bh=t0RfikQAHfqsaEClsd3WLTniKVYw2V2cwBWP7ewhU44=;
	h=Content-Type:Subject:From:To:Cc:In-Reply-To:References:Date:
	 Message-Id:MIME-Version; b=uLeGsT4LiTGodDq/o9ZFgWO0gDbasQZ6zG7ehXjFtZ2dfeoXfyOf7ME+Ouh22ihZyaR8XLQu4gkFX+ADdpn8+q4gjf9SHdxIq7tfrRuSzYYFjoPpaMADMxXCMkQrglI7xDNwfi4g1bpfpuDVnqy7GghxqH6r4+RBYQC/QJSDNFk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bJ1PiORn; arc=fail smtp.client-ip=40.93.198.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bJ1PiORn"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=se6xj2RDJgweGlKm8Bsp+72QZCM3V/+L0FmmmsY+iRIAK0Np5cYHuR530VM8wowBEUlCDC6daB9XAQnVD0h/yR1KlwIr9HsCFuICRBz1L3n3bv0Q851Dc540hyjES8bNVXjfr8FSwJOzKlfsux8u/ZAin+MF9fFrim+KcL/72UZkuGpRtzhg3b0UDNqajc2aZs7zDnOKwY7vGDqJ7W+IYNSW3va3v/Jw6wtmoTUfAoJsqismllSBYXdZ0QDDm7suFemsxS6CEMztKU+f/7yJ2P66Eq/5JtM7SMaWNkRjRu1sOj7i3ufgcsI0qvq4SRXFGHTKb6eGwahVc5AarlWIMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SLRHfMDFscCcGCrfkQr+Qkqk3hNWS37Bg0shGQHriyM=;
 b=AaSp3Wj/4T5BeDF6R8mtBV4FPjv+FNbL6J87tCzSY7EBRySBvcfw4OY44S7GDnrfmv7nkNEloQwmtYI3xPJ91s2rmz+NJ1BjGgqGEM5ZDTzy37YH9PjQ7qvbE+qbTlzQ8geK06WPKd2lO89y5nGSuHFROIcts+YByQoRX+Dy4+FWZdDMwwEvvywbhDO6VMpRupEBEppDDUEB+6rV6yvR9VRAMeubcJTHVD2ydjFk/pQ3xjVvzIX11Z4D7R586XNn61W6iElnNghnsKRh0DK7uvk8WgKdfdHc7E3+g/sNgLoVOlaUkYKrduztIY4MRnV3gjVYl3DGYHIITP8SSHbaTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SLRHfMDFscCcGCrfkQr+Qkqk3hNWS37Bg0shGQHriyM=;
 b=bJ1PiORnwOjuQic0hKHCyx3aNW4yxPPRw5jLH+K6Com8RZIny0ivWEhikDTrTRgyhx0Y/VT4CP8WAA+YXnUNZG9KVEnQN5/4MR2bD4ka05gcCc/8EelI+ZJGBfH6WnQ9+mUK/ZcoiV8npJOygWlvOu5RuKyeo46G+YQq67HJK8Jr3ZbJcq0tmtpNwQkoG2aF/H08/mNcVkUC0dlAmHDWDmE8AYyHPQ042B0YfACXGybYW7ne9e9l2eu+OP8CvfLXzlT42bxeoKz2BjyUvW0hJeI7FoSuXVlJ1oouchFkTC4h7Zdaj5Go2CksStrNUt9+WxllE7YAqgTynA0hUreoOw==
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
Subject: Re: [PATCH v11 03/11] iommu/arm-smmu-v3: Swap EVTQ_MSI_INDEX and
 GERROR_MSI_INDEX
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: will@kernel.org, robin.murphy@arm.com, joro@8bytes.org, jgg@nvidia.com, 
 praan@google.com, kevin.tian@intel.com, smostafa@google.com, 
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, 
 linux-kernel@vger.kernel.org, jamien@nvidia.com, kas@kernel.org, 
 Cristian Prundeanu <cpru@amazon.com>, Breno Leitao <leitao@kernel.org>
In-Reply-To: <630e70ba13639e5bd86fca0b574dd47dddb7fb92.1791226953.git.nicolinc@nvidia.com>
References: <cover.1791226953.git.nicolinc@nvidia.com>
 <630e70ba13639e5bd86fca0b574dd47dddb7fb92.1791226953.git.nicolinc@nvidia.com>
Date: Tue, 13 Oct 2026 11:49:36 -0300
Message-Id: <179190297652.2261874.5664965715184131627.b4-review@b4>
X-Mailer: b4 0.17-dev
X-ClientProxiedBy: YT4PR01CA0118.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d7::10) To CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CHBPR12MB731189:EE_|IA1PR12MB8311:EE_
X-MS-Office365-Filtering-Correlation-Id: 88ac272b-0659-4cd7-5b14-08df29393522
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|7416014|11063799006|5023799004|261009223027099003|4143699003|56012099006|22082099003|6133799003|18002099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	k5CoY/y/oVsU7Ykg+ROKFhB2KEmyzC+x794OZ6qPxU8ScCjgu7DHwBxUQNIP1JcCQj4H7UCweAuwnNU3VtXCCL6+2s7jIdCYD5fanxkiPCmpEEB1wkfMaDor11VVcaC2QK8D4n9f5mG1bw5F7gy5vHqytVi9svcLBmFvEmazd1ZwnWzMqVwJt6f0hskvAfYy7jwE594CHPIhxskVvOyww1df29izOFmqmxT7QQtfgp/wX69py5QwlXOGiJ/71mYjNUBIvGpwTQilxJMxhrfAfqIsShDUASoExlLGlOrTljsB0BLiIW3q7GeMck6eXdshcywwiQncoObgkhZqU0E5cePfJBivLh/fxMgtocZlu/Z0MFhDRalRsVJlabo1cpKxNBizAYgw5iN4VPFSV1zlQN2jx4pIX3FLEpyuCGEpk22HojOGtrSnlhl7xa+oFVKwIkwiNLF0FBynWm22Maz0PWZWoK+PcW/wgkoM5R3w97uh42GPX5BYEHwOF/SiTxer3/DiFDaPHn5URVS9V0+kCHdYesk7QumEM4Qym8u512oHok0Tmx0i9tnKfC3DhLoy7Xgm7Le/71oEImf/4NbuaB0SU8YcDrcSK2LRT2Oo5ogcBmA8B6xD5oR3lzmVaHPCw76xhm7QgS2o6S9WQs3BMjy6pBSgjJggEBk5BgB5uxU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CHBPR12MB731189.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(7416014)(11063799006)(5023799004)(261009223027099003)(4143699003)(56012099006)(22082099003)(6133799003)(18002099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZlYrci9TM2FyZmdQbHpyWlRlc3pVYVN6UjZGdnNBL3RqRHhxNUtIZU54aXND?=
 =?utf-8?B?TVdFVDhFUWFURDdLNEJINjZ3Y1BqVDFSN3hIdEdSR1JvTnU5TDh6MTVvN2Va?=
 =?utf-8?B?QVZ6VFJ0TG5jZWdia0NkRFQzbWJka2UrdFdNOFVBaGZMUnE5QTRudkJlSkxJ?=
 =?utf-8?B?bDZicXEreTdmZjFTSndSRHNXOXBpZlhPbGVjTzdDd1dlZ0UxYWJyaEJQVGdS?=
 =?utf-8?B?d1MwYUlFUlRxT05vOVJIbEVVVGxsTVE5TG1IRVphSnRRV0Y4M1pIZVh5bzhx?=
 =?utf-8?B?NllYeERkWkhlbnJxTXFUMzV4THo4aEdWbjFQQWE3MWVsR3dscXZuUnFaNUd2?=
 =?utf-8?B?UitWMWFza2JIMlBpQmd1cGM0MUtpTjJ6V3g0Rm9sMm9mYnE5aWVFMTQ1d0hi?=
 =?utf-8?B?U2dIbSs0VUpRdG9XbWhEU2lHWWx1RS8vYkV6Yk5VVmtBcWRDdHdybFdiMWM5?=
 =?utf-8?B?QXFYRlNkMTRjTGFKNlBhQVdaNmQyQ1dLMmswU1JrM2FvUWcyQjBSV05mTVhB?=
 =?utf-8?B?Y2NyRkZsc1FQQVQwM3FSQnRxd1N6cGpMemlqSXQ4N3Y2YUM2empFR1FycUwr?=
 =?utf-8?B?VTFRd3ZMWDFGV0xLNStFNTMyTU16MkxoNmhKQitHUXJBUTgwL0M4N0FYSmF3?=
 =?utf-8?B?Ly9ucENUeDhxbmYxUTFMWlpwYkM4Wk9PRHV5VGNkRENYeFUvZ3JpS2ZQc2Ev?=
 =?utf-8?B?MWZDSWJCUGtuOUUveHlSOXVIWUhKVlpKZGV6V1BLbzhRMGhYRytWSWIvbTJ6?=
 =?utf-8?B?NjY3eXN3cUkxZEtMYThERDRmaG92VUlLbWJrcTJCNTVpNXluaXluSVRqakgx?=
 =?utf-8?B?MGs0aGlQMTRkYlRPMU8xQmRLR09XdkhPMUZHU2Q1OWJOaWxWZjgwOXlVOUhV?=
 =?utf-8?B?Mjdrb01HMFNLeDhDM3dRQUNZTitlZkdLUVJIQVd5S2g3TUlEeFhQNm1SSFJY?=
 =?utf-8?B?N0ZnTzBSNG1hVnMvTEJua2FaU204L1hpR0dBaTAzTStlQlRZN1dyRFp6LzVl?=
 =?utf-8?B?a1ZJcUxmWjh6M2hHNjZSVEhYN2JRTGIxWEdrYVdSNzJwdVVQb1lEQzhWQUlX?=
 =?utf-8?B?YjR3cjdTWUNFbmo4b0JSRDN2dVh6UmphTDJJazZKQkd3MUZZUGNlWUlGcWJT?=
 =?utf-8?B?YzdDYXVLTFdLVW52VEtuV3RqUTZPN0NneUtEWFQwN0Vkci9QMjd5N055Q3p3?=
 =?utf-8?B?Q1RzUTdxTTVyOWN3VjdoQlBjcnJGd0o1Mk00aDdVY3FvQW1RcmFrd2lKZCtr?=
 =?utf-8?B?TGZzblBYVzdhd3dwckZMRUovMW1YQ0lsaEhpb1JUU1JIUER0N1lKOGRoWita?=
 =?utf-8?B?ODErNUk2SGM1Mi9Mb0dWQUVCc3E0U2RzdHJxN0ZPZHF4S1puZ25qR2MwanA4?=
 =?utf-8?B?Z2dhZ0huN1Nvbm9UbGVPY0RSbjhKRDQrUDFpc0w0eWpMdlN5RlQyTURienFr?=
 =?utf-8?B?aXBtN3hQYlpUQmFKcXhMSFVPVUtGdDBUQ1hRcmh6SFVTdHJYNmhtbUV6TmpB?=
 =?utf-8?B?aDV1TGY4d3Z1aWFtNlo3blVKRlZDMHBSRnJZeWRrT0hTTGpaZTBDUk1ENC80?=
 =?utf-8?B?ZGVzNEhZcHpjcGFLTVNuSWVSVlBmd2d3a1IrRjJGK0syQzlkanJQeFVGRS9o?=
 =?utf-8?B?RHlGUGRrSjNzeUxoQVRYRzhwVHNUUVpkcUdNaG1KZlFVZ0dsUFpoVjVyTmhv?=
 =?utf-8?B?WWFTbFAxcEcyN2paUVdoS3E3VzdnRCtHVWxlUXMvQ0JSVXRXY2pnZk42WWsr?=
 =?utf-8?B?UEZUOWxmcU50cHNYbS9ZOHJvWjM5OUxxOExLeWhSNURGWXM5ZUdDN3VTYU40?=
 =?utf-8?B?aGlwVVFKWW1XTVJvRG54VWNVZUkvOU53QUFRdkZiTjVVaEVWUW9uYVZmYUJo?=
 =?utf-8?B?SjNaUCtCTi9EODdLSUgvVDZJamhGalE4c0xrRzN5RUlIeFRtQkk2ZVJ1bjV2?=
 =?utf-8?B?YWEyVTNwMkprN3VLWE13M0RyVzRlY1k2ay9hMnR2UlF2bE1PQ3RuYmNRYUsw?=
 =?utf-8?B?TXJCMzMwTEhqNWV6bjhhY2FaMjc3WERaYkhvK0ZTNFZaTkluK0VpYk5COHNI?=
 =?utf-8?B?RVhvSWEzNU1zbHh4Z0lPTW9rcVo4OTJnbVNWQlp3NDJwVFBDTTlVMVZxcWJv?=
 =?utf-8?B?ZWlOeGh1QU9YTmpyWVlkcksyRFhOYkp6SW5BVXN6b1Via1BrRUdQajVVM3Y4?=
 =?utf-8?B?S25TYjQ0azU3SXZTcitnc2VMczg0V1p0dnphSGV4MGltZHdOVXlWVnNKalJC?=
 =?utf-8?B?ZnFlekFBWHV3ZmJkZFk5ZngrR0dKbDB5U1dOMzlXM2ZTMDRTcytZejhVdDA5?=
 =?utf-8?Q?jTxyicEiAp7V1wJcjO?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88ac272b-0659-4cd7-5b14-08df29393522
X-MS-Exchange-CrossTenant-AuthSource: CHBPR12MB731189.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 14:49:39.2157
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G/WvuevR8TiEn4q9hb4VNGEUMjThaw9hkCJ7kxaXmLa/n8r3GvEiU41GmPvX6D2I
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8311

> The nvec trick in arm_smmu_setup_msis() works well on PRIQ since its index
> is the last index in enum arm_smmu_msi_index, but it does not work well on
> the EVTQ as its index is 0.
> 
> A subsequent change will make EVTQ optional so it can be disabled in kdump
> mode. This can skip its MSI vector allocation.
> 
> The index is driver-internal to select arm_smmu_msi_cfg[] register set and
> the corresponding MSI slot. Nothing else.
> 
> Swap EVTQ_MSI_INDEX and GERROR_MSI_INDEX. Then, arm_smmu_setup_msis() will
> simply decrease nvec when EVTQ is disabled.
> 
> No functional change intended.
> 
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index aeace4335abfe9..6ff61565f75838 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -57,8 +57,8 @@ static struct iommu_dirty_ops arm_smmu_dirty_ops;
>  static DEFINE_STATIC_KEY_FALSE(arm_smmu_erratum_repeat_tlbi_cfgi_key);
>  
>  enum arm_smmu_msi_index {
> -	EVTQ_MSI_INDEX,
>  	GERROR_MSI_INDEX,
> +	EVTQ_MSI_INDEX,
>  	PRIQ_MSI_INDEX,
>  	ARM_SMMU_MAX_MSIS,
>  };

This is the only change that is really needed

> @@ -68,16 +68,16 @@ static_assert(sizeof(struct arm_smmu_ste) == NUM_ENTRY_QWORDS * sizeof(u64));
>  static_assert(sizeof(struct arm_smmu_cd) == NUM_ENTRY_QWORDS * sizeof(u64));
>  
>  static phys_addr_t arm_smmu_msi_cfg[ARM_SMMU_MAX_MSIS][3] = {
> -	[EVTQ_MSI_INDEX] = {
> -		ARM_SMMU_EVTQ_IRQ_CFG0,
> -		ARM_SMMU_EVTQ_IRQ_CFG1,
> -		ARM_SMMU_EVTQ_IRQ_CFG2,
> -	},
>  	[GERROR_MSI_INDEX] = {
>  		ARM_SMMU_GERROR_IRQ_CFG0,
>  		ARM_SMMU_GERROR_IRQ_CFG1,
>  		ARM_SMMU_GERROR_IRQ_CFG2,
>  	},
> +	[EVTQ_MSI_INDEX] = {
> +		ARM_SMMU_EVTQ_IRQ_CFG0,
> +		ARM_SMMU_EVTQ_IRQ_CFG1,
> +		ARM_SMMU_EVTQ_IRQ_CFG2,
> +	},

The arrays don't have to be in order

>  	[PRIQ_MSI_INDEX] = {
>  		ARM_SMMU_PRIQ_IRQ_CFG0,
>  		ARM_SMMU_PRIQ_IRQ_CFG1,
> @@ -4965,15 +4965,15 @@ static void arm_smmu_setup_msis(struct arm_smmu_device *smmu)
>  		return;
>  	}
>  
> -	/* Allocate MSIs for evtq, gerror and priq. Ignore cmdq */
> +	/* Allocate MSIs for gerror, evtq and priq. Ignore cmdq */
>  	ret = platform_device_msi_init_and_alloc_irqs(dev, nvec, arm_smmu_write_msi_msg);
>  	if (ret) {
>  		dev_warn(dev, "failed to allocate MSIs - falling back to wired irqs\n");
>  		return;
>  	}
>  
> -	smmu->evtq.q.irq = msi_get_virq(dev, EVTQ_MSI_INDEX);
>  	smmu->gerr_irq = msi_get_virq(dev, GERROR_MSI_INDEX);
> +	smmu->evtq.q.irq = msi_get_virq(dev, EVTQ_MSI_INDEX);
>  	smmu->priq.q.irq = msi_get_virq(dev, PRIQ_MSI_INDEX);

Nor do the assignments.

But I'm not really a fan of this design, it is very fragile.

I think if you want to compress the nvec's array it should be done
directly.

The smmu should have a small array
   u8 msi_map[]

Which holds the xx_MSI_INDEX value. Then arm_smmu_write_msi_msg()
would indirect to get the config:

	phys_addr_t *cfg = arm_smmu_msi_cfg[smmu->msi_map[desc->msi_index]];

And we just compress msi_map as we go through the normal flow

   index_msi[EVTQ_MSI_INDEX] = nvec;
   smmu->msi_map[nvec++] = EVTQ_MSI_INDEX

Then it isn't fragile at all.

-- 
Jason
