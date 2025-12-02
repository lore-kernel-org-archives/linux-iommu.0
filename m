Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012049.outbound.protection.outlook.com [40.107.200.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57C24EEBB
	for <iommu@lists.linux.dev>; Tue,  2 Dec 2025 05:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764652506; cv=fail; b=BHO8XSKoBYg0AizuAENBmOS1PLSvoIwzCO4wO+6mLUwYIJIRoYuZXUmmid7qbfjifRX8F99CGuGx1Zz3XkzHLyOzfXOm9O/3+NNWaH9wlOUwKheepWTq1zx3DV0Q0s+VLCDBb2KGx4RWAIYPz61vF4q3+8p2YINnDWnLkLsWFGs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764652506; c=relaxed/simple;
	bh=uFI3MFtnMqRBTELyCkqMqKuKU1gb2Nxo5tcb7IAi6NE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=up8zOLVH3ZTH1UGVaioDU68EqDaGIParJplgl8Yve2510mRu29iROyFzwhTcFzflmEMO2F+Ap2e0l8nJtkNKKIDEtQTOBfZvAPR/4zFTUXvfSTvffLXahZKYLHdNOj0HPfRzxZqSDFo0naNbvUZCiHAr6PTZWSJWw2u/HVnyMsA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=xLU+j6oU; arc=fail smtp.client-ip=40.107.200.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="xLU+j6oU"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a2KuOdVNCyfxdkp3kq1AqqdPlFqeXEQjYzusnOcfOMSdQR7KYmnbNwIP0ADBzAlqvjWz8BQ+5XqYV/PMI3oCECrwBKPq+bSMRJfeiMvRwjvEZbhbszqr7bOD1XeZL0jm0NhtOLe7oFZXNG5Y/QrqitFcOhWrKi/Og6xTdn1S8blXQkdJCKGLe1yfXEet/NNMsLRtL103DOLNfAdMeFjc8/Ho8Mo/aKXLYWlUWm3eB5Iqtdi7KCCHSwlhU3nqHY4ctt+lU0d/J/O9p9/TYHqWaqaCzqZw8VSw2tQumZICff+BNFI9j6jkMezJ1fVGM7lxdPum4o+69O2szs2OvV40Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bofmKABa2hsNBlTWKrczLMeXApp2hg609TBp/vd9Eqk=;
 b=xV7zZB9OwHL9b7SnwjnNaWXjiqcwzqQgIZpTQZq/RAJdI75f+dPEl6kjwpFUSboxnjVJeNkct3re2PDMbh3Lrx6Pk0h4pDWxZ267Fi9CUmQzdnIYLGruXUpNDUIloAvs2O/Q44mAP/eBZWp4GhTYePTORJiQEJro5F7nVHyc89fmVZtT2w0KT7bGHLgUOf76J2jB9OWm/iHFgnmopU5hyoBWYOoGNB0cFVCQeH3MjC9rEYgZzvNXHP1refS+jGRVLwXpmaZ8MvadhlNADNJG0B+EjQxD99oQCpgW5uviDFBI4pvYPrJal2Ms0t13YbqcjpglZm9YHF2w57TwC+xoKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bofmKABa2hsNBlTWKrczLMeXApp2hg609TBp/vd9Eqk=;
 b=xLU+j6oUx4ud3QM24E1XOf2J5JOiN446bgXLbEF/1UjIcl2JP5cq2CIgRbLhFf8Hx7uixgI+7QQszFMVnEUQLS5+q6XEfbN12mT12rYhEmWNmYfUj7JJTDuav5MDZ3WDZkRy1gx1hrx8FZavzWMcjuRbOe39ULs8D/wVn5m9clM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 SJ2PR12MB8691.namprd12.prod.outlook.com (2603:10b6:a03:541::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Tue, 2 Dec
 2025 05:15:01 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::a5e0:9d7e:d941:c74d]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::a5e0:9d7e:d941:c74d%7]) with mapi id 15.20.9366.012; Tue, 2 Dec 2025
 05:15:01 +0000
Message-ID: <7ba57474-57ad-4c81-bb50-4e0c6e3be633@amd.com>
Date: Tue, 2 Dec 2025 10:44:55 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/amd: move wait_on_sem() out of spinlock
To: Ankit Soni <Ankit.Soni@amd.com>, iommu@lists.linux.dev
Cc: suravee.suthikulpanit@amd.com, joro@8bytes.org, will@kernel.org,
 robin.murphy@arm.com, linux-kernel@vger.kernel.org
References: <60d2601b17c7008834fe393e75990371cdac74b5.1764591214.git.Ankit.Soni@amd.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <60d2601b17c7008834fe393e75990371cdac74b5.1764591214.git.Ankit.Soni@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5PR01CA0144.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1b9::11) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|SJ2PR12MB8691:EE_
X-MS-Office365-Filtering-Correlation-Id: 6cfbffa6-0219-4f9b-664d-08de3161be53
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YjJnNGtFTm1GYTYwVkFwMkYwN1hDNE94NUduREQrcDBvNGM4dTdtaFZQMFZV?=
 =?utf-8?B?UlhjbEdtTnJVT1FyMFVJcmdyK1BpQ0RxelNRVDFucHduSU1zbDdvZklwcWJL?=
 =?utf-8?B?aDdmamJsS2NsdVRsS0FDVnBwWmgwd1pBTWFTVEJmVWdTbG9mSXVndnRBa0xj?=
 =?utf-8?B?bWF0R3IrKzdHTnA0NksvUHkwYy9xZ1NDRXgvc1hlaWVoWW1JNGVoSjBhQ1dz?=
 =?utf-8?B?ZVlIekhwL2RPK1RQeUh0aEZ5NUR0RGRyRXpwUWx3eVVya0ZaYmFaUnJvQW4r?=
 =?utf-8?B?NXJrMXB5T0UxcDZkYTVtRUtQMVUzQStxbG5HN1NIaW9yV0wyc04vWVczeWM5?=
 =?utf-8?B?MlEzRWFhcjVvblZERUpPcE1aNmQ0c3BldUZkSldkT0VzMDVNWW5BMFpzTlA5?=
 =?utf-8?B?NkxJOHM2Sm9NMWNxQWsxdDl5TWdpK1V6SFl0ekpaL0RrNzlSWmt2ZkZrYndU?=
 =?utf-8?B?dDVSNE9DQlJBMjNSbHJ0YW1QLzlJdTR1OVVzaS9KTU5UNFdGRGFubkkwWlNp?=
 =?utf-8?B?UUV1WlFySVZUTlZiNFhEcVVWUHU1N3ZTUUFzWVhSdFZDaXRPWlVxWDRkNzB6?=
 =?utf-8?B?Rk13RVdqODlPdkV2Uk44SUFVNjJEaGswM1VpaFNxTnhrdDFzdDQ3VytIRjhs?=
 =?utf-8?B?d1k2K1lhay9XbFgydGpRVGlWSU1wZThMNjVralJyRElqSEZlVU1GelMrWlBC?=
 =?utf-8?B?RzNvRkVBc3RadWpMVm1JM2JpNDVPODJna0dQV2lDd3NJRVZUQjZWKzRxYThx?=
 =?utf-8?B?R3VGUEMxTWJEYWhnWkYwOGdrQ3hsMlZRbGxVMWt2ZUptbnhXaW4xTUErTVNt?=
 =?utf-8?B?OW1qNHRLK3IveGVtK2NWSlhGUkFRczgyUnFoVlRMN21QYVFLMTVNUjRHU2FS?=
 =?utf-8?B?TU0vM1FDaTFVdm5mTXBOMDFBSE5IQ0RseWJoSlVWcHloQ3RCelFxejQrNEdX?=
 =?utf-8?B?VHNxUFlKMlFNdTdOZ24ydzhONHplMzdJRWh1T01iTGloSmUrQ1NYcGlnNlF2?=
 =?utf-8?B?RjIwakU1NVpnc3hodjU4UlRTcUp4Q3ZnVmFQWEV1cTIvTmlkalErOXlCYU5X?=
 =?utf-8?B?ZitMT24ydFl1WXluM0ZBMm5tY2R1cE1hRkF0eDBIVW1pT1B3MVA2ZUN0MWg5?=
 =?utf-8?B?bDczUzY3aUN5ajN6czc2eWNNNWh1UmkwaHh5R2t6VnRHelVtQzkyRUZ2NmlO?=
 =?utf-8?B?b2RCaG0zYTNSb1JTSW1LZFVVM1MvYkJUQ2hzVE81TjRadC94cFZOZ2ZhYTN6?=
 =?utf-8?B?a1RDc1BuakV2MXNBTWZxUkpFTitUUjB0b0txbmJzVys2WFFiYTNTVndiMlZw?=
 =?utf-8?B?amJ6Y2c2M0U5eDArbmVIR25xQzc1MFJUOVRLSm9VMktMajgzZTdNYThMS0VH?=
 =?utf-8?B?dU1QNW1EZnlrRStUTUEwMDR3NytvenZLZHRhWWlNNSttVGtReGZmdVNINVdj?=
 =?utf-8?B?YklCUW5TVHZpSjEwN0FkNUpLWWJiajRpeWVvRXlGTWdaNkdHeGFSV2RFelgw?=
 =?utf-8?B?UW9haVhDZnkxdjI1cGRSU05PeVQ5WmJSVHVydGRKWW1XU3Rsd3ZpVUtiYUIw?=
 =?utf-8?B?TGVyVU01OS9CNGlUL3BnbG1zSWxGUjR5ZlpCVHZ2VTJJREVZbThYaWpyWk54?=
 =?utf-8?B?cW9FbTNzb1NMWFhOU1F4RElmRTFad1plMGRiZjc5MUJUUVN4cWdSVncwcXJ4?=
 =?utf-8?B?SytVK1dhV1UzREI1eWg3VUpGMWk0MGEyOWlNUUFxc3VCS0NJYnBZS014Y0NH?=
 =?utf-8?B?Q1BCS3UzZ1hWRG9YWTdQS1pwQlpFVEZDbGFvTlgvV0t4U0xFRXdkdEJRM3lC?=
 =?utf-8?B?WnliemZKdUdHaVgzdXZsUUx4REZhOU53amE1UkRCbmNGczRGR0tpQ09zY2ta?=
 =?utf-8?B?ZmtGUmJuaE5PbEN5bzI0YkhNOVo0YmJjWFN1QXMrUkE5ZHV4MFptVUJzVTM5?=
 =?utf-8?Q?sueFIWHi4635SQ7chiatErCxCNd1z/DP?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dWNxYzdQOXVGZnR0bVdwaGFDc3o2dldDbVBrcjl0NGRPOThJTGlMRUZrQzBh?=
 =?utf-8?B?a2pMbjlDUlBuU2JrNTNQZ3BsWlRTVDFIVmU1dnpSNndPUUczTFZCNGdTRHBk?=
 =?utf-8?B?MVVrWHA0NCtYU1FzNC9OdXVnclNFOWd2WTVFTzhVK2l1NEkxbUJBbjA2cW5E?=
 =?utf-8?B?SW80ckR2UEo5SkpOS3h3LzNCRCthWWE0VHNXKzNOUzNTZ1dqWFhFUkxQbHFa?=
 =?utf-8?B?bHR3UHozZXYxa3Z2ZFVMdWJtNUtDRytka3RFeXNaSU9DbCtrREEycGw3b0lU?=
 =?utf-8?B?Y0pLOFZjd3NnNTlIbFpQY3hsQ0tqSmZMK3E0RnArVkpNdTRXMDBJejdTdklC?=
 =?utf-8?B?UTU0d3puNEZuNU9Iei96UnZ2eWhJK0p3d21zUzFnRDZveTVpMkFpZUFwVGYr?=
 =?utf-8?B?cnlrbnUxdkhvUHdNbWNhTTNiOHEwSG1UYU55Q3JXdlV3SWVGd3Ivb2UxVk40?=
 =?utf-8?B?anExOXFHbkZpYnZnT2hJcXRHQTE5WUliMVROQ2dPZVB3R0UvY0tDaXZ5ODM4?=
 =?utf-8?B?aHVaWWJnbFdHWVBDSXhvQ3RKYjFMd1pLeHpNMHY5dXFuOFVMTDJVTXF6Qmh0?=
 =?utf-8?B?eXU1enR4a0JZeDJ2MzdvS0FkMm1ZcXR2WS9EYzM5QmRNUGxnOGhvd1Vid2RY?=
 =?utf-8?B?dW55ZTRkQktmZEFySmNuQTJKQ0RhdDBhTkpabFJmUFF6K3JoNk9taFVKTk1X?=
 =?utf-8?B?cGRHRkxBZGlCS3NjdEhlSnN1L0hmKy9iVjN6UlJyN21renZPWVBPbEU5N2tq?=
 =?utf-8?B?TyszRlVCcWZkNFZGdXpMU0o0MjBLZ0NINVkzNmNrTXRUak1TYkhnNHQxRjd4?=
 =?utf-8?B?TmdXeVp1MktyWWNpbHN2MkJFTDhBOU9JNTh0OVlxU1RGWHZMUVBZVDhxblhI?=
 =?utf-8?B?Zm5FKzlQMyt0U242bUhwalgvc3E2RHp4bEw1YjBmNFlSS0Q1dE1HOTNxUmRv?=
 =?utf-8?B?UFJ3SkdXbEdIMXpOUnJkQVdZNThRMlFpaDJkNFkwRVNzalhycVJIeUlVcWhF?=
 =?utf-8?B?TTlMNkM0cWMvK1RxNWZyc2NzR2tOM0k2dzRzb0JvN1FhdFozL1BJTmVEbFg0?=
 =?utf-8?B?a0I2YXRiMEFqVTVFUjNucEk4aGw0SUpUSjlZa3dKbUpTOGM4ZEwvNUpNL21W?=
 =?utf-8?B?YmtOT2xEMkVGTkVRVm52NjR2NlNhbGxna0M5b0szYWN5bFNVMDVnWXJlVStE?=
 =?utf-8?B?NW1xVHBiSC8xdElJRTlyd2ZYWVNtQzc0dlZ2UWtkS2czZE9PbUpTWTE3TjI4?=
 =?utf-8?B?NVAvWVVDckgwb2U2QXFOWGFMNWtnUnJzZzBNZGlDcGxtZnBlblZlU293aFVJ?=
 =?utf-8?B?bzgzZ1VvejFKREtVT2xIZTNmL1ZMTEc4YUZaZ0lwbUMxWm1PcWdPa2hnY2c2?=
 =?utf-8?B?UHpJQlh2L2hYcU5hUlE0YXg4UXhzUFBzaGcybXhZWFM0T01OeG1pc1NtR0M3?=
 =?utf-8?B?RHRiVVJoWEsyTlZvczZYbU9VdkhLT3M5Wi90bzgvRFQ2NnNZU0s0T01yUTg0?=
 =?utf-8?B?TGlYQ20ycG10SDAzSVpwTUJTM0Z0V29YZlBxbjZrdU9VTHlqbHFXKzdMazli?=
 =?utf-8?B?QUdSODJVeElwc29nbFZMaVphaElWVzcyWkFXNjNpR0ZzMjkyWk1KUnRpd3BX?=
 =?utf-8?B?S2hTMmgvOWo1Q05sZlRqcHpqd1RWY2NPZzM4NFV5VjZMSEFydGNJbTBwTHdp?=
 =?utf-8?B?VTMwUFFObWE1Z2NUOXNwV2w1RGc4MFJHWEl1SFMxN3JaMWtzSXpkaTcxQ1p0?=
 =?utf-8?B?bisrMjl2QWVMRXN3Y1FOSHFXdUI0bzhaMmxzS2ZpcSt3T01Mdk9Xc1dDdW5N?=
 =?utf-8?B?cys3Mk9CQlVlaGpSSDV5NWorUkJkUHd0ZlFSa0M2dGJjNUJBaE1HbmZSbXpw?=
 =?utf-8?B?czNvRTdBQXdqRFRWZTVPRGhJTFIrV1VrYVRrM3huSWdPYStKR2RCVVRvV2Jv?=
 =?utf-8?B?VFRVaFNrdmhYcTIramdxd3pUa1JzK3BYb2dMOGVRWGZYZFBpc2dVSUUyZ3Rp?=
 =?utf-8?B?Y1RXdUFVQ1JMRkFRSUxWUys1MVM2UjBGV1FMNU9lVzdQK2dCb2xaeVl6eUdo?=
 =?utf-8?B?QmRFeDVCdVNGZHZuUzJRRnhTTEhuanZFVHo1UzNYUlQyNEVTbWc0N1hoY1gx?=
 =?utf-8?Q?1Udz/FlrnSAOS5042axo3CBdZ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cfbffa6-0219-4f9b-664d-08de3161be53
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2025 05:15:01.2064
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Tc0qOHMPJqWZmnUrYWQxSizrh0jffNGd/BV4DHbAhoCnKtODpM511CwaZ6JhFvuOPNZUKWRJJ1R6x8zH5ZdN/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8691



On 12/1/2025 8:09 PM, Ankit Soni wrote:
> With iommu.strict=1, the existing completion wait path can cause soft
> lockups under stressed environment, as wait_on_sem() busy-waits under the
> spinlock with interrupts disabled.
> 
> Move the completion wait in iommu_completion_wait() out of the spinlock.
> wait_on_sem() only polls the hardware-updated cmd_sem and does not require
> iommu->lock, so holding the lock during the busy wait unnecessarily
> increases contention and extends the time with interrupts disabled.
> 
> Signed-off-by: Ankit Soni <Ankit.Soni@amd.com>

Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>

-Vasant

