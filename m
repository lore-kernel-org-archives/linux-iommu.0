Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010053.outbound.protection.outlook.com [52.101.56.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DE1733E37A
	for <iommu@lists.linux.dev>; Tue, 25 Aug 2026 16:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787675783; cv=fail; b=tyzJxFwAZKnSCBVeJ66OpcwdLH/CHSyK2cYlT+bMFS2qjNVCVB7i+F6wrLid8Yw3ePVioIsyttNPnbvARmzsa6U2H0S8pIMNrdrww5pWxKFk80mqwLfDcSM9fRGj9o3G01DM0+yagRbwjwr/3ItKkPyTy1CWwYkjpikjWacbb70=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787675783; c=relaxed/simple;
	bh=TYIfGYbdgLFSO+ROLlsqLQD9rl4Ah67fRKWCnuQSmeI=;
	h=Content-Type:Subject:From:To:Cc:In-Reply-To:References:Date:
	 Message-Id:MIME-Version; b=dTHPfaYnkR4c2Tarr28j6JVwisVfLlWBi6xgXOTttGfQHvGkauAxxItwhmrOsQIah/DKIDsxMhbM7U92fSvOffmDJ9yeOMzbe1P1MMzTcmXOtrsL47wXelf9Kg0FxPnEvrJDW6LPpR2jILqx1+gg+1ZNPbgXAq25ohjYJG2We7E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=I7DivUF+; arc=fail smtp.client-ip=52.101.56.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="I7DivUF+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pK6FmNnbMRRNdWgdjisiBUhpDXSAuZr4r7aWXPIuevkKBejcjn1TM9jhVwwFEO2REoPizimm5x1Uxtw+UttJg11MlALfAoRGXEOP8L5rK/VE4/zp6C3QpkBlvCsldJ19HebrBA1FoLuVdCWpuqhPASUa9KHWgvYgtfLBuHL2Xi3g5BGd1aO7AZ8wB7IEZx3uO4rVg40WPvjVOTOyGZqBonyS/3I22aDaZdxGk8RN6wCkFOCfZkblIlqGt5gkX6NfDddCoiCp7Rfhgz48sPi9Al5vD5L5gcB/BNICrpOcdq+c7y2GgBZPZmb1vORTPiBYnOo8C290QMBZSsdMjVl+8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k/uKb+skiA4hhRIowy4XonewFS0aAFdY/PVaGLDV6M8=;
 b=yTsYBjCQ1BZvU5S+v8jiuKDguRnJKb4N3W6GiUNgM2yo0eQ6JbUzfvtzzDGj1pjHaUaCg6wbTKkairpXPPP7DSv0PGvB4UgyFjtEnQUNR8QQgLOp3st5rn5ExaBqThTqxoHIl1LDekAdOlsRolvXm7QSeX+/6a+Z+OdXmQDn4cbArheZK8LN5TFIupOJiHh2gN7+Ht2xmTYcgLOzUBz+zjZuu2f8Bb9OCGds0p4X9IPsdHDdcBWtOcDdlJdLYk7A9lfrBoH5KJW/5L6xSbeyL6cb/ic5FO5C1j+17kqw21h34HvBACdejy2mrflQd+gaqvQ45BCnqm+u1duJM3OmWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k/uKb+skiA4hhRIowy4XonewFS0aAFdY/PVaGLDV6M8=;
 b=I7DivUF+R6ziOF1g1gGxWIgB4Zu3Dj6pHwjins9FIUw5jyLWTC1DMmSs+VMss2AN/DSn/n3C6XVVlu3+kWY99mvc532m92ktMpCBQX+kJdmEa5E4uMtXRWIVFX6JyGpyh50AavVgVJX3ivzz6As1vWZbJm+M5qPIWNhu8CEfgcG4MoPX+/pvdZIuuiGGf9KIkjrxnFaYPlJOWp73JGxk9j/fUvLW0Wq6RbS81dn41ngcAGArM1kOxwUYu2lmmSjgmA9BCbMr2Uls1+Z82bc6lrhqmwWyAqy1ISMDddCRpi/nMMQhhg3Oz2btZ800pcTAHvx3ghoS5lbH+W5+OPEI4g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by IA1PR12MB9466.namprd12.prod.outlook.com (2603:10b6:208:595::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Tue, 25 Aug
 2026 16:36:16 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0339.012; Tue, 25 Aug 2026
 16:36:16 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v9 08/12] iommu/tegra241-cmdqv: Add a helper to quiesce
 VCMDQs
From: Jason Gunthorpe <jgg@nvidia.com>
To: Pranjal Shrivastava <praan@google.com>
Cc: iommu@lists.linux.dev, Will Deacon <will@kernel.org>, 
 Joerg Roedel <joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>, 
 Jason Gunthorpe <jgg@ziepe.ca>, Mostafa Saleh <smostafa@google.com>, 
 Nicolin Chen <nicolinc@nvidia.com>, Daniel Mentz <danielmentz@google.com>, 
 linux-arm-kernel@lists.infradead.org
In-Reply-To: <20260728210928.1050849-9-praan@google.com>
References: <20260728210928.1050849-1-praan@google.com>
 <20260728210928.1050849-9-praan@google.com>
Date: Tue, 25 Aug 2026 13:36:11 -0300
Message-Id: <178767577113.3356902.12387755135854957596.b4-review@b4>
X-Mailer: b4 0.17-dev
X-ClientProxiedBy: YT1PR01CA0119.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::28) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|IA1PR12MB9466:EE_
X-MS-Office365-Filtering-Correlation-Id: e5421604-d43e-409a-f985-08df02c6fb24
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|23010399003|10067099003|4143699003|56012099006|11063799006|3023799007|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	Sl8WYs+YQ4u4AoLifNIN5qk2ruWvlP9iwEiHwKpjC/jFJA/Iy/uKKAZt5zUnj8dT9dyQiGIdrxZJfiNyot2BX+LgSgnqDt4RqnpqGCF6L4sfkpdtlKPQiX9EjhVLGWWy8gJZrl1VI5kTdhIOjUpAmuG7LW1myQc9Yg3bepI9ZrG3Gu5gzeS+px9uT4v3njTJSzTZEiM5iQ50hXsfb8La1e/avnnW5PalTLDtQu2krQrA3oFmvzjxG7GqTdLld6AleeQ9R5Fs1ZifRelrP8SaESP6vlC42/iW7yIX6L7irNAGvn3at5RCmBJREQZOO/KHlGqL3j224l4rhxiotuCyJ9HrQDWOvW6VT3QVEGKoO8Oz8IfFbMD0lMUMfHCs1vNKcjMe25mBCVl6xoiAizDKMRYIrfXm0Dt9iwS9tq4UICTd+x5YW0SpYlSVjaBY0TiRWbQub9EFFOEbFtl04rM6gr8mgPFdaRmNGNlmeUzKY2J1/5jofAjOo3Q1DoKzqnJb1ozi+B90sxDqWU9N6WSFa4jCRfa2VBwZ0FSY2ytNthiI5ewhIwlp4NO690iVSihOP0NPbjBHRiVazNS6lwTdGFH4NF3WRRWQwvVB4AV3mreZ0iFtHkSFygmpDRgDiwFv6jHLJNADcBSGtoYAtXg03qQw7gpu0Yvx6VgZM2BERF4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(10067099003)(4143699003)(56012099006)(11063799006)(3023799007)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NkFXMldqelFKaWJXYTV2eXhVVTcwOUlwWTVheG83dksrdEpRNE8rMWIvZW01?=
 =?utf-8?B?RG1RYldVM2tQZmY0aXltcnFjL1NHaXVvelV1NTE0dHRrbzRqdFhNWkpTaHZV?=
 =?utf-8?B?ZER0a01aaklZSzN2QlRTQ0RrdjlDSVpvUEZWUDVzb3NIS1JjUk5lVlNCakdx?=
 =?utf-8?B?UHpCYWxES2l4YXlaSXdRVlZjS0UxVjhjdjRnUllpR0pmVUZuN0xTQ0pFWmNS?=
 =?utf-8?B?aHVpVFdraEVzNlN4V0Q5K0ZTNHdSUHNNME5ZWjlDVFZyYldTOHAxVE1EVHhM?=
 =?utf-8?B?KzdKUkZ5UmQxMWNzRCs1cEJWMHpqNTltNTdiUU9sWUFMb3ArVVNUTTNYeW5u?=
 =?utf-8?B?R24rbzhEdnVLeEkwUXhXQ0dOTGtkZlpCTXJtemNyWkRZdjB1cUl2MHhYUnZD?=
 =?utf-8?B?R1FkR1hNQnlESnk4ekxPUjBxckcreVBtaGJBZkk2ZFN0b2NBdi90aFdRWW5J?=
 =?utf-8?B?cFE3ZHcwRzErNGhoelI0dmFkY0IzckVuZkpHdUhqTVVONmpPeFRZaHpQKzNX?=
 =?utf-8?B?SzlSeXpvM3hrQ3FrN2hXMStyTGJlVkNPNytHazY5UzZGYXQ0b2pZajh0KzRk?=
 =?utf-8?B?WXVEUURmWEJvTktXRngvY2JYR05iNUNQZVVnQ2tNSnkzREdnUnlTWjNjeHFR?=
 =?utf-8?B?WitJRkRlMEdZMWVXanBrWG9ocmRxZVhXNVNrOEhsSUtDYmpHbmh5WTFnd3c3?=
 =?utf-8?B?aXQ0dThiZkZXTE1PdDZaQ3lzSG1LVHJDS1EyeklDYkxpTTN3blV1bCtPdURE?=
 =?utf-8?B?REpTY0s1a0VsL21qb1AyUnNoTjVDbFd1ejZQLzJCS2s1OFBHN2d4eEtLMmZX?=
 =?utf-8?B?MmtmNUU3NWNCb285R1M3TzhlQUF6bHZveDRvczU0L05YbjVUQzk4eng3LzUx?=
 =?utf-8?B?S0IrWElSbmpxdGFCc1JOYzBBaW81ZExmTnFUYmI5NjlncGxkSXRkbEl6akFR?=
 =?utf-8?B?czV4SXVtNFdrZTIwTFRSS1Nkdi9xZzd0MUtMRVpzYXl2RDR6NWhHTURpOE83?=
 =?utf-8?B?dG5uNmtsT1ZKK3NGQkMxeUxlWm01YVZxcFFjTExnL05VMmZuekVPMnNTUU1Q?=
 =?utf-8?B?ZXRPaUlVN0hxVTZpc0o5TDMxczAzaDh4enlMR1F0VmcvV2l6WVY0SVFzR1c5?=
 =?utf-8?B?a0Q3cldQWlQ1OXVOblEva0VOQ3crZ3ltYjY0YXlOM0JHQUMzWnJtaWp2dFQy?=
 =?utf-8?B?enVYWjRvRERBMjN3bmNXVURkdmNMOXhTaXNNTUg0M0hFMzJxcTNPNEN0RDZy?=
 =?utf-8?B?QnFKcVh5enQwRklHSEd0Yk9hSDIxTWpuZm9GVHZYOFprT3RPVUkrdWVZMGd6?=
 =?utf-8?B?dmZ5TE5BL3BVc0huVlNaNlYwYm9sdXJMc3JvSWQvcnBxblhBcHNTVXNvNGEz?=
 =?utf-8?B?VEdTblVvNytiVS9NNlpicGZnNkJrQmgxOHRMOUNPS3h3Y1FhZE5ZVVRSODZN?=
 =?utf-8?B?Rmhua0puTWE5TW1iQ1FmRGRJeEV5eW9rRGJ2WXdyTTF5VlZVdU1uRmZJaTdK?=
 =?utf-8?B?cENFbWxSTjFvVmRtRmUxTkZLSTUvRGQwbWlnaGVWOWxlNzAzSVhVM2lOSjdH?=
 =?utf-8?B?OUtmZXpaSkMwOEhLN1lCbTJFc201NHZZa2JZQ1p0SUNmNkNkenkzU3I5MEZx?=
 =?utf-8?B?Tk5ZMENJR0luK1V2dXpPZ3prNEVwQVZ2Q2ozMjU5MW0rMGxqdE9yc0ZuYmhG?=
 =?utf-8?B?K2dnRW52S0tvTUh4dFNxVSttcTViSVBXemZySHB2M3NIMWFxWUFkUUdMbFhz?=
 =?utf-8?B?ZEtaT2VtdzR4NkVGMzYxK29OSWNsc2pObzE3MEpUTG5ZQ0U4MG9GcFJ5MHJV?=
 =?utf-8?B?enN0c3JmcFd3d0JrWk9kdHhpemR5SFk2c3V3MzZYWlBRUzhtMFhlZ25FWTlo?=
 =?utf-8?B?bklyUzRyU3VNUWk0a2pMNWdZc2lxeTlBdmtaLzF6OVFUeFUrbDhxcFZZYUZJ?=
 =?utf-8?B?djBqbi9ES3dYekxLWTJBakZxempmckNyejJtM2pGOWE3Z0dybG8wenJTSCtQ?=
 =?utf-8?B?Wk11cTQ2N2I0UmpuMzlTRnhZbEFHVU5VcXhWN005K1pFWVh4R29WRTVvbHYv?=
 =?utf-8?B?ZWxMSmtJeGZiZEpkWjVQVTZnRmJYTWZHbm9CemdsVWZZeUVLYnNOUXRuYTlw?=
 =?utf-8?B?Z3o0TzUvV3VYSHlRRGVRQUl5M0JjMmtKMVRHSktESm1aQVcwSTVtSHhha3Zv?=
 =?utf-8?B?RmFZR0pCcW5qM1NBaVFIbHZFdU5XYUllbWRUS3VlUG1mdWJhb1ZIbGJIMmJT?=
 =?utf-8?B?dWZ6SnpkdlcwVHVBc0V5SXl5bDBQYkhzTFYvU081RnZEbjQxeHgyYnA5aEh6?=
 =?utf-8?Q?jwINYQfp6uvYzfW5Ob?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5421604-d43e-409a-f985-08df02c6fb24
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2026 16:36:15.4368
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x5KP48FTKlWvABuRY7lKFFkweXj7mbA/5PGgbMgGnShufKmBQel/uhdoMPJ8Dj6X
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9466

> [ ... 73 lines skipped ... ]
> @@ -467,6 +487,14 @@ static int tegra241_cmdqv_drain_vintf0_lvcmdqs(struct arm_smmu_device *smmu)
>  	if (!READ_ONCE(vintf->enabled))
>  		return 0;
>  
> +	/*
> +	 * Gate all vCMDQs by setting the STOP_FLAG in a separate,
> +	 * initial loop to ensure no new commands can be submitted
> +	 * to any secondary queue while we are waiting to drain them.
> +	 */
> +	tegra241_cmdqv_quiesce_vintf0_lvcmdqs(smmu);
> +
> +	/* Now that all queues are safely gated, drain them sequentially. */
>  	for (lidx = 0; lidx < cmdqv->num_lvcmdqs_per_vintf; lidx++) {
>  		struct tegra241_vcmdq *vcmdq = vintf->lvcmdqs[lidx];
>  

 [Severity: High]
 If arm_smmu_queue_poll_until_empty() fails during this sequential drain, it
 returns an error without clearing the CMDQ_PROD_STOP_FLAG that was just set on
 all queues:

Make sense to me, the earlier patch added:

		ret = arm_smmu_queue_poll_until_empty(smmu, &vcmdq->cmdq.q);
		if (ret)
			break;

-- 
Jason
