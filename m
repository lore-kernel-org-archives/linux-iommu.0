Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012035.outbound.protection.outlook.com [40.107.209.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC3A522AE65
	for <iommu@lists.linux.dev>; Mon, 12 Jan 2026 06:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768198376; cv=fail; b=UVNlEzva9ViFxSyy8QQ2ik24tt8SMFN8sQCL7JXRyKMZQh43YAt51oSTKN4CVZBRqBo7UH+CgBHj/CIry9XpgqkW51hdd3mkbR8owj37aqizeNOwR/yWixvQ2F8QuFs2LZGSp31RVGToTDMa060O1y9Gb7P4vVVHIGI4VpEvEyI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768198376; c=relaxed/simple;
	bh=dtAunoC1/ryT+Qo2OtkDUEMz9xRmmMuj0N2mwtIU2mQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XCiqkg/iLbHrkXTWSbHY+BV0gfyeMT21g3Rqmq3eiVfsGcIcr3bDbYdokWBA7QFCGuC79wwK4SOxYXcfsTR6DdAUWEqaA7CDwklNiiuG8nD5ocesdjbRL4vWHTLOnUEx7Oykac0h0HmPRWtqgMqAuu59BHEZX/Amx6okjRc30po=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=imjjkF8R; arc=fail smtp.client-ip=40.107.209.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="imjjkF8R"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Uk7UVIhdHdycKgl6Uyfuax2HX0ngX+CGHQ4b3BdfnQTol/j3nTczSdaCzTr1nUlz/yFjup8Y4UOxnxq08Qs/p7i4ClVSsNvOSGXZWKX4uynHBGrdor5Ts3q81Yt3KrNl8MgMle6PxFzA5GIitEue+lBnVZyyozmMS7kTpmfVmNNJhgMecLkn1dxV1XOh2ZqA/jA2V7vc33qfzLDgzTgyAy8ZO6zCBC45izjI67QWjaHx+GITu5Kf17k4XpOgVmCG2v6Yq2F3tunuO5fjxQZjU3wkjeBn00nE4rSInOU8uRYejLh47CJ+NXAd+jf6x9i6D/4ZdE1Mi0Ag9lggWrju9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=etLnAlSj2Q8RB/bV+f2rWoc0fip2xOL6dwn3dttfSRU=;
 b=PhQD7l/2xEb45PaOdd00FZ7x98WQMRtwTlGbZxv3ivaQS4UElhXVNRbGhkWUR7qIZSNQsAww7WRizKnpguEvChguBQvgX1ifF00jsP+Eiry98Bag8IcVYsqdGFvs4syN+RicWO2CRmcleiMCcGMQJf5eQW00Ye70wZVmrJfE4YuKvnalUtmfbfJMT/fDe3BP/v3gaq7bRzWkLxWWUMiBtqx+VoR5m03vNT8VFHCKkDR9OfaXh7DnmRS/Rt3xZ+MYHu8vQSHLWeFCRTq25hue7AmP6fZ5PLXMaMiEju19PwkCyb1BL1wIPSmC5omOWnHMJ5k3lywL2pRwhkXmnzHILA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=etLnAlSj2Q8RB/bV+f2rWoc0fip2xOL6dwn3dttfSRU=;
 b=imjjkF8RL0q9rhipUbW1p8ALTrv2AgRuA1JvqFneAct8gEb25roHtwMoira8NtgswlIJ9un6n+QXcXNkXtj+4Mr7mMQTX5RkyUZIoB/9pqlcAT9sTIDWtTLixiZKi6Ouo2OGVrJ0DjDfXLp34WzwSxrFmoj+/M0wklCssYPV0hg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA1SPRMB0013.namprd12.prod.outlook.com (2603:10b6:806:22b::6)
 by LV9PR12MB9805.namprd12.prod.outlook.com (2603:10b6:408:2ee::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Mon, 12 Jan
 2026 06:12:52 +0000
Received: from SA1SPRMB0013.namprd12.prod.outlook.com
 ([fe80::fc4:fa00:c2d9:456a]) by SA1SPRMB0013.namprd12.prod.outlook.com
 ([fe80::fc4:fa00:c2d9:456a%5]) with mapi id 15.20.9499.003; Mon, 12 Jan 2026
 06:12:51 +0000
Message-ID: <16264021-2dbb-4805-98c6-6dea758367d8@amd.com>
Date: Mon, 12 Jan 2026 11:42:46 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: amd_iommu: Kernel panic - not syncing: timer doesn't work through
 Interrupt-remapped IO-APIC
To: Tj <tj.iam.tj@proton.me>, "iommu@lists.linux.dev" <iommu@lists.linux.dev>
Cc: Joerg Roedel <joro@8bytes.org>
References: <1Z2Ru2RmAxtkhZhrEa2zqn0k2zgpgbB6W-SgyuWJioaY8S40qY9b8UkPH8UpVCzfljOfC2KFIQKr9rpWW6_k5IReGboeeA10QUgma15NNis=@proton.me>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <1Z2Ru2RmAxtkhZhrEa2zqn0k2zgpgbB6W-SgyuWJioaY8S40qY9b8UkPH8UpVCzfljOfC2KFIQKr9rpWW6_k5IReGboeeA10QUgma15NNis=@proton.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4PR01CA0088.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:2ae::10) To SA1SPRMB0013.namprd12.prod.outlook.com
 (2603:10b6:806:22b::6)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1SPRMB0013:EE_|LV9PR12MB9805:EE_
X-MS-Office365-Filtering-Correlation-Id: 23b472da-fcd4-43cb-b6a3-08de51a19e24
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SUxjQlVPWW91U2Z0Y091Tk1uQUxvYVMxNndMU3dFOGQ2cHh4VTdzQUN1aU9y?=
 =?utf-8?B?T3pIZUhUSHh3QUU4azFaa0twZmhpMzJ0UEJoUHgrZjMrcTlrVWFabGRKalNH?=
 =?utf-8?B?K0tlNWs0WFgrbksyc2RpZlVvLy9EVlUzaXlnZ2NDbTZPWnJNYkNvYmxRWFF3?=
 =?utf-8?B?eUF6M292bHo4WUdmc0NlNVFwdTQ0cjZQVmN4L0wrQmExZWVvWmRaQjREd1FH?=
 =?utf-8?B?Y05qczhWMHV5TjBCeGpMSVB6U09qOTUyRTQ4MDVYRVpGWTJ1VUgxVXA0aTAx?=
 =?utf-8?B?QVA3cGVjOFAzNmZRRWs1Z3ZQaStJZ2JuUGdPZEdmckpLT0I4b0lmNzcyWE9a?=
 =?utf-8?B?WTdkcWVVT1g3UHZaWUZRVUZtVE5NdlFuL29KdkRkclE2cE1XWkFwVVJvaHBi?=
 =?utf-8?B?U3hMdDdCMUdNZ1pKcFVMekRyaU1saENDSlA3akQvY0hWMzJwYml3K0RDZnJt?=
 =?utf-8?B?VEIrUVZtUVNxSE13Q1MvMEZSTVhzSDBEV1dCU1NUVUlOVVVUOFJ5dUJ2OHRZ?=
 =?utf-8?B?aHhWMU9KRGNLWXdxWDVFRkF6azJxOWk2cHJwb3RHMjlmZGs2RXhaMW1WN1A5?=
 =?utf-8?B?OW1ReTZlVzdBb1doOUcrRkFMbzBwTVRKb3hLa0NmOUFmYXlpN2h2RWNvMFNO?=
 =?utf-8?B?TFk0MGVMaU42R2pYQlVLRVg1MUNnV3dZaUpaaHhScTI0RXpKTW9teGlldTJk?=
 =?utf-8?B?WHF1dC9zVUJoVEN2Y2FNTVFubitDNzNkOEQvU0ZmZnE1ZlJySFBBRENMdnlY?=
 =?utf-8?B?Q1FBZEtBV0tUdGVsUE0zejVWZFdsUVlNRVVLSmpDdVoxbmcvb0dOdzA5bEV6?=
 =?utf-8?B?Z1dvV3lzZCtVWUQrc1JuRElrb2FIRG4rZUhDRnVTVXJOZ3REUGVnL3RzRDk1?=
 =?utf-8?B?WENLTU9jS3RlTDNXL2xQQTBIN0NrOEZPQlQ4R29IS0FtK1cyaEFlYjZRN0Fx?=
 =?utf-8?B?SVE2aklnNUJ2a09qTXRhL2NxRHFpVXBHN0ZQU0RSdVdYTVkybStNZUlGSkZS?=
 =?utf-8?B?RmR1bVVSWUYzL045QlNOcVNFZndtVEE4a205S3hXWmhNbDBDK29KM1VsWmh6?=
 =?utf-8?B?Mmx3RTRPK25USG11VDFyVk5ZMFdWeHFQV1ZqYk1YRHNwWFNEK2tabkVsanpT?=
 =?utf-8?B?QnpIK05vbW1ZL3doZjloaDFJZ2FoQUJ3S04xSzZhRi9jTjF1ODZrc1U1aGF0?=
 =?utf-8?B?QnBvWDlNNURqSXlvMXpDVmJzeFE0MVlpNmVBTUJwVnZkMzhuTEpWanZrMDly?=
 =?utf-8?B?Q2pvV1NtSFlxUUV3WG5rSFhzU1BxQUVEbjdrSTE5ZzdsWituNTltcGFseVQ4?=
 =?utf-8?B?Sm0xS3Q1WXlrN0RQb2d1dGplQlp4RWZWdVNJdVVrZ0N5ZXErSlgvL1hDMWl0?=
 =?utf-8?B?bnNFTk5iZkF1VnJTR2VaNDV6VWZxWWJBUDljTm9HWWJVQjlCQVZYSlhOemVM?=
 =?utf-8?B?WlBOL0UxTzNJVFRkck5FSTAvQTQyckVDcVB4bnhzVFhZTy9FWnhnc0kwS0dn?=
 =?utf-8?B?M1ZRUHdHUzV6QUhsWEdHdDVnNTJvRUdNOXhpSFZiNkYzZmhQY2FnWER4bEZW?=
 =?utf-8?B?eTk4a0dnby9CRksvT2FPYkUwRmU5UHd5bklLRUZuLy9qSU9hS1YwY1c3SlRS?=
 =?utf-8?B?M3N4ZnpyWGdLdzYzN1hkRWdIYXFXUFN5aDVva0RNSVE3WUZoekhNSlBLM2Jk?=
 =?utf-8?B?VmdFYlVKeDR2cXQzYjhsaGs0aTFLVzRUMTV1NldMVndjYnVRdXdQUVlQaDJr?=
 =?utf-8?B?ZE9BaHoxcGpXZzRxZjRySFZiMTVpZjZuWFFGSDZpcngvTGQzbHloQXpJKytt?=
 =?utf-8?B?RlUxVUo4RkRmOEVEUVVnODlYcW5JM3pSQ0cya2V5K1hSOFZ0Q2t5c3d2T2Rr?=
 =?utf-8?B?Ynkxdy9OaDk5NEZJRUo2L3Frc1VYbjdCY2VoVlI0OXFzM2IvSHFYRGFLSWtt?=
 =?utf-8?Q?jdrI5hMN0v46HukD8lBIVxa9z902aEYA?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1SPRMB0013.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZC90d05sNDBBUE5hanpMWkFIc0xMVEVNcUd1Ni9TMVRkQTFOeTdvUXVOMnFN?=
 =?utf-8?B?WUxKdW5wcThQeTk3citCUHIzbUhnZnZGNGVTYVlrazBVcEFKVGtFU2taaTkr?=
 =?utf-8?B?Q0I5OU80amFFK1EzT2tJZVlxZ01DQU1MSEFqWjJ0K2lJdktQTGUrQlpIMWNP?=
 =?utf-8?B?YXdHNUtyV0t1bDJiMElyci9aYmpOU05yODIzUTFIbWZOVmtKN1VPaERLVCtI?=
 =?utf-8?B?MjBRamNjOGo0Y1BPZzlZcVFzUEpGMytycXRiNmtQUUNoTTE5SUQ1WndHMUJC?=
 =?utf-8?B?U2ZZbXoyZTk1TElVclVibVhhK2d1YTk1MEV1RTJnZG43Y292QklqWlNMKzRT?=
 =?utf-8?B?Wlc3OUhoNVgzVlRsMlZFSUFwM2hGR2dTaEZVVjJJczdmYUlFWWZtU3FNbkp1?=
 =?utf-8?B?T0RiTGRXRkFNKy80TGYrNEtmanVvU0Z0eEpiSEJxdGg0VmJNelpQZUxXRG41?=
 =?utf-8?B?cWhFYjY3Ny91QmdVcEw5TW01a2prVVVVS3hLVnhzTVhLbFJIamdKci80SExX?=
 =?utf-8?B?RkRyNlVuaXRzTzdtdjJ6MHgwK3o4cG5YYy84a0QvaDROck1LWkRsV1JTUHBs?=
 =?utf-8?B?amxVK20yb1NYenNlMkl6TzdELzJZSkU1VjdDNXFZK0FrME5zUkFqbEw4WGZN?=
 =?utf-8?B?R0Z2QmgzZVBwM0Y2ZFpHSUVoMzlsUm5uREp1bEpidHdRYzA3ak4xSm80RGpL?=
 =?utf-8?B?cUtxWnIzdjBUTXowRlBQU3BFSWdwVVBZYVJvcVdPYzVZZTB5aVJ1ZUxQT1p0?=
 =?utf-8?B?Wjkyc3hrdzFGdXJuanZwU0M1dU8zWEgvODlPYzJhQ2ZDRXRuRFZ3QnhMZFZJ?=
 =?utf-8?B?NWJDbGhLRVZ0NkxNWi9oWmtQK0s3OSt5cnpWN2xSYTRMSG1rbWg4MzJ6Qm1O?=
 =?utf-8?B?aUtKWC9sRkVERHlKTjE2QiszalcxQkVyY3ZxL3RSd3hxQnUxU1Erczl4bDdF?=
 =?utf-8?B?MzJWYWtRMFNCZmF0T2hsOGVZa09iOUV1YTRmWGlJMmIwT0dSZ0c2OUdVSzc4?=
 =?utf-8?B?M2xzRWVkKzAvS0F0MitCVGRIakZYa1NPUEJDekFSVWFlaHhhY2VlT0owRjEx?=
 =?utf-8?B?MURSQUFZNEc2c3l4L25Qa0pEeVNuNHhPeGk1T3FDUG9XeitXSXFKdWhBS1hx?=
 =?utf-8?B?RUpxbmdlQ3hhbkpzdUdoakJPdFZuVGQ4Y0lMT00xOWtXV2pTOFF5a2h3bHpV?=
 =?utf-8?B?cCttcDl6c0gvSDBzRU12QmRUb213aTYza010dTlGMmdZY3dMYmFrbjlMYVNW?=
 =?utf-8?B?L1FadlpTWjhidU9SK2lQd1Ric1JsVzUzUzhZRjh2R0IyUUYySUYzeHlIU01j?=
 =?utf-8?B?MEQrRDZJS1NucmNvejhyVW1tbjlzdmRXYjFVeWJISVpkRTBoYU5FeVFVSVFa?=
 =?utf-8?B?enBXaitHSUVHUWg2WmlCejF0NUlWTmNPOHNMMk9vdVZJSEF6a2ViWVM1VVhP?=
 =?utf-8?B?Q2dZTEtOcHJIUW5JRzIzS3JOWWlMZXBCNmdVVG9ocjRqSDZkSEFMRTRYV3BY?=
 =?utf-8?B?YnBzaytIQSsvSWJXMG5LMFdNVTRQVmV2b2dsd1dqRThsRVRvSTNFSjNBN0ZS?=
 =?utf-8?B?Qzg5K3NSaFhoOC9MR3VHZkRpMEtBWFd4TDRQdlZjNXpKSzVBZWxteHVRWWV2?=
 =?utf-8?B?MFY1dUdMSm1yWEEwNE8vYis3clVqaVFSMjIzZTdtcS9zQlJ6Vy8yK0JzUkZY?=
 =?utf-8?B?L281OEhIbWxRN2xmNUhUUG9Ma0dEc2VpZ1ZCM3hJbjFVeHhkQlpYb1U0VVdL?=
 =?utf-8?B?UzkwTHRoNXVOWkVydWFmdWRkR0R5djJibEhmQ3BvdmxsdFpwMVR3ZkRXM1NK?=
 =?utf-8?B?QXJ5L2wwWHV1NXMwN1VyalJhcFJwbkJ1NkZwVmFSSnpiOXMrcEhlS2RwMkRa?=
 =?utf-8?B?TE10d0FhZWRoZkM4SnVpNWpHVEs5TzdjRURlSUc4R0xkMlZmc1FYSTFWMHZt?=
 =?utf-8?B?a3dXZWJUU3pTQU5qYzFLdmVUdjkyc2IzTWhCTERCYVBxa2xrUUNMcVRmVFhm?=
 =?utf-8?B?YjZ1dThGd1ZIZlZUaG9STnE0eVJsSEY1aHRLMzF1ek5aK255TWpIQkFiV3NW?=
 =?utf-8?B?V3dmTW9rd05CYU5xR1RvWi9yVEZ0WmRxdGRONmo5c1RPQzZ3clRUUkpRdDds?=
 =?utf-8?B?TWxDbUJsZlpWMkhNcUp2UGVXOE9TNk45K1VCMTA0dmQ2UkMzcHBxRkhwRFp3?=
 =?utf-8?B?bjViWCt1NXIxdGN6QXRXY3czaWx5Y21YTnpISmZhUGQ4bGU2OFdNQWRRcFFw?=
 =?utf-8?B?UXJpM1RGSG1vL2w5OWRPUWFIaEFkK3dCYUV1UGc5ZnphTVc5MXh4Z0dlRGJU?=
 =?utf-8?B?bVp1aVFPY3c0RkhtMy81YTRTQ3RGbmw2SVJaMmJtTWZVNG9CS2ZaZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23b472da-fcd4-43cb-b6a3-08de51a19e24
X-MS-Exchange-CrossTenant-AuthSource: SA1SPRMB0013.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2026 06:12:51.8790
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4wT4/UBlb+GQyXKRQmzCkWCUamGMmA+JP32g0Oa2+Opx44QGe+WWIcwGjdZq9PqTXwEDPErEmYi1hg+IaOwdEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV9PR12MB9805

Hi TJ,

On 1/7/2026 10:42 PM, Tj wrote:
> Currently debugging a KEXEC_JUMP preserve_context panic with amd iommu on kexec restart using:
> 
> /usr/sbin/kexec --debug --load-preserve-context --mem-max=0x3f000000 --load /boot/vmlinuz --initrd /boot/initrd.img --reuse-cmdline
> 

Sorry. I have not looked into preserve_context code flow. We will investigate.
Can you please tell us the use-case?


> From my limited understanding so far it seems that because the KEXEC_JUMP preserve_context path mostly follows the same flow as an S4 hibernation the IOMMU code, on restart, assumes the IOMMU had a hardware reset. In this preserve_context case that is not correct and the IOMMU is still in the state from the prior kernel where it has done:

Currently kexec codepath assumes that iommu was disabled. Only in kdump path,
driver assumes hardware is still running.

> 
> drivers/iommu/amd/init.c::amd_iommu_enable(void)
> ...
>  ret = iommu_go_to_state(IOMMU_ENABLED);
> ...
> irq_remapping_enabled = 1;
> 
> So I wonder if in the shutdown path this needs handling in amd_iommu_suspend() ?

You mean reset the irq_remapping_enabled or other relevant variables?

> 
> I've been testing some changes to syscore to enable passing runtime state in struct syscore_data in order to notify amd_iommu_suspend() this is a KEXEC_JUMP but cannot find a way to force a reset of the IOMMU. I initially attempted to handle it in amd_iommu_resume() but that doesn't seem early enough in the startup flow - I don't think syscore_resume() is called until after this panic point.
> 
> ...
> [  141.722644] shutdown[1]: Rebooting with kexec.
> [  141.781931] Freezing user space processes
> [  141.787032] Freezing user space processes completed (elapsed 0.001 seconds)
> [  141.794028] OOM killer disabled.
> ...
> [  142.975667] Disabling non-boot CPUs ...
> ...
> [  143.594423] Calling amd_iommu_suspend+0x0/0x20
> ...
> [    0.000000] Linux version 6.19.0-rc3+debian+tj (linux@iam.tj) (gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40) #364 SMP PREEMPT_DYNAMIC Wed Jan  7 12:46:49 UTC 2026
> [    0.000000] Command line: root=/dev/mapper/SUNNY-rootfs ro debug systemd.log_level=info drm.edid_firmware=DP-2:edid/UE50NU7400.edid fbcon=rotate:3 modprobe.blacklist=radeon amdgpu.si_support=1 console=ttyS0,115200 console=tty0 no_console_suspend nosplash vt.handoff=7 pm_debug_messages=1 "dyndbg=file syscore.c +p" elfcorehdr=1032176K kexec_jump_back_entry=0x00000001ff34012b
> ...
> [    1.571701] clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 133484873504 ns
> [    1.580860] APIC: Switch to symmetric I/O mode setup
> [    1.586226] AMD-Vi: Using global IVHD EFR:0x0, EFR2:0x0
> [    1.591467] AMD-Vi: Re-using command buffer from the previous kernel
> [    1.597834] AMD-Vi: Re-using event buffer from the previous kernel

Hmmm. Driver is picking kdump code path! looks like is_kdump_kernel() is
returning true.

In your use case, do you want to reuse old kernels memory area -OR- want driver
to setup new memory?

-Vasant


> [    1.923179] x2apic: IRQ remapping doesn't support X2APIC mode
> [    1.929564] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
> [    1.980114] Kernel panic - not syncing: timer doesn't work through Interrupt-remapped IO-APIC
> [    1.988652] CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted 6.19.0-rc3+debian+tj #364 PREEMPT(lazy)
> [    1.997882] Hardware name: System manufacturer System Product Name/PRIME X370-PRO, BIOS 6203 07/27/2023
> [    2.007289] Call Trace:
> [    2.009747]  <TASK>
> [    2.011856]  vpanic+0x31f/0x3a0
> [    2.015010]  panic+0x63/0x70
> [    2.017902]  ? timer_irq_works+0x80/0x130
> [    2.021921]  panic_if_irq_remap+0x1d/0x20
> [    2.025943]  setup_IO_APIC+0x8c1/0xa30
> [    2.029706]  ? __pfx_amd_iommu_enable_faulting+0x10/0x10
> [    2.035030]  ? __pfx_amd_iommu_enable_faulting+0x10/0x10
> [    2.040351]  ? __cpuhp_setup_state+0x63/0xf0
> [    2.044626]  apic_intr_mode_init+0x76/0xf0
> [    2.048733]  x86_late_time_init+0x2d/0x50
> [    2.052754]  start_kernel+0x7f2/0xc50
> [    2.056428]  x86_64_start_reservations+0x18/0x30
> [    2.061057]  x86_64_start_kernel+0xfa/0x150
> [    2.065251]  common_startup_64+0x13e/0x141
> [    2.069361]  </TASK>
> [    2.071558] ---[ end Kernel panic - not syncing: timer doesn't work through Interrupt-remapped IO-APIC ]---
> 
> 
> $ grep -E '(IOMMU|KEXEC)' /boot/config-$(uname -r)
> CONFIG_KEXEC_CORE=y
> CONFIG_HAVE_IMA_KEXEC=y
> CONFIG_KEXEC=y
> CONFIG_KEXEC_FILE=y
> CONFIG_KEXEC_SIG=y
> # CONFIG_KEXEC_SIG_FORCE is not set
> CONFIG_KEXEC_BZIMAGE_VERIFY_SIG=y
> CONFIG_KEXEC_JUMP=y
> CONFIG_KEXEC_HANDOVER=y
> # CONFIG_KEXEC_HANDOVER_DEBUG is not set
> CONFIG_KEXEC_HANDOVER_DEBUGFS=y
> # CONFIG_KEXEC_HANDOVER_ENABLE_DEFAULT is not set
> CONFIG_GART_IOMMU=y
> CONFIG_ARCH_SUPPORTS_KEXEC=y
> CONFIG_ARCH_SUPPORTS_KEXEC_FILE=y
> CONFIG_ARCH_SELECTS_KEXEC_FILE=y
> CONFIG_ARCH_SUPPORTS_KEXEC_PURGATORY=y
> CONFIG_ARCH_SUPPORTS_KEXEC_SIG=y
> CONFIG_ARCH_SUPPORTS_KEXEC_SIG_FORCE=y
> CONFIG_ARCH_SUPPORTS_KEXEC_BZIMAGE_VERIFY_SIG=y
> CONFIG_ARCH_SUPPORTS_KEXEC_JUMP=y
> CONFIG_ARCH_SUPPORTS_KEXEC_HANDOVER=y
> CONFIG_IOMMU_MM_DATA=y
> CONFIG_VFIO_IOMMU_TYPE1=m
> # CONFIG_VFIO_NOIOMMU is not set
> CONFIG_IOMMU_IOVA=y
> CONFIG_IOMMU_API=y
> CONFIG_IOMMU_SUPPORT=y
> # Generic IOMMU Pagetable Support
> # end of Generic IOMMU Pagetable Support
> # CONFIG_IOMMU_DEBUGFS is not set
> # CONFIG_IOMMU_DEFAULT_DMA_STRICT is not set
> CONFIG_IOMMU_DEFAULT_DMA_LAZY=y
> # CONFIG_IOMMU_DEFAULT_PASSTHROUGH is not set
> CONFIG_IOMMU_DMA=y
> CONFIG_IOMMU_SVA=y
> CONFIG_IOMMU_IOPF=y
> CONFIG_AMD_IOMMU=y
> CONFIG_INTEL_IOMMU=y
> CONFIG_INTEL_IOMMU_SVM=y
> # CONFIG_INTEL_IOMMU_DEFAULT_ON is not set
> CONFIG_INTEL_IOMMU_FLOPPY_WA=y
> CONFIG_INTEL_IOMMU_SCALABLE_MODE_DEFAULT_ON=y
> CONFIG_INTEL_IOMMU_PERF_EVENTS=y
> # CONFIG_IOMMUFD is not set
> CONFIG_HYPERV_IOMMU=y
> CONFIG_VIRTIO_IOMMU=m
> CONFIG_IOMMU_PT=y
> CONFIG_IOMMU_PT_AMDV1=y
> CONFIG_IOMMU_PT_VTDSS=y
> CONFIG_IOMMU_PT_X86_64=y
> # CONFIG_IMA_KEXEC is not set
> CONFIG_IOMMU_HELPER=y
> # CONFIG_IOMMU_DEBUG is not set
> # CONFIG_TEST_KEXEC_HANDOVER is not set
> 
> Thanks for looking at this.
> 
> Tj.

