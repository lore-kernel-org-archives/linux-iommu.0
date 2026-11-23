Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.201.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795422785;
	b=hofeNvbpfs/EPeMxvu3kFt56Fh3qKKKbF1rM29gc0liOg4y0WaRKl/6iAgp/AJSBYV96
	 0Mo4tCpqe3VCzu0bCuv3hwo9r6x4Rug52CpNxNK+QU68BxeM6lLEa/6u02mk+w8qA8C91
	 +sF9qnT6UufQQO3QhD7eDvis7VAuG51nE9ZIlHIJgucjjcFUcO1/V7kzh45d6PsayZGIz
	 Ntdily+4zICuCXQMCeBJc6DXhxpcAV3k2GrGR0CUATMmOUEuAGfv17APUi/pPbmjYUP5S
	 TRpHMq2/vSczqThwJtgX2bYNC2WEz6CE8nNqd7JB/7zDg9JVztz+dLsbnZs19ay5PdQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795422785;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=VXbUu6pN/foWSpf5t/cqIEwwRDxnml53J2oU9Q82DXg=;
	b=DOCvFLLskrrvilR8RPkkhnwpaDXkOC0XT94UEMl/KtxpgjJ6mPpsMQp6B8WNbCN911Ae
	 Cq+xMJgIaM5CWGoWykz1DeYj/vurkAfozDZG0pZBor+6lwKhfOuu4w2NRRDQy+ObobO8I
	 ghamMwGM6FnnUlq1cyhss8ZPpzhTC8Bm8Nnp1fBUvJoOlZtqp4qT3dlLhvbRJ4dp+I0rB
	 Yd9sQvwu6PCYbgz1PsUbRtDhGWt8WzzdOP6BB2wZ/KCaqITKc+UON/Rk/CT7xACEY3XTS
	 DFt89qERyA1t9I1mJSVMOAHOrbZpbmJWb+6rr1vniDK9HeQcE15tKNjtpR7V6AKHJ6A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=g+Gol8FT;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.201.18
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013018.outbound.protection.outlook.com [40.107.201.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A162606A331
	for <iommu@lists.linux.dev>; Mon, 23 Nov 2026 08:33:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2A162606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=g+Gol8FT
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=re4+a+1uRzymc77jf7jIVJcDcRSMbVJ30VI2WjRrvlyBZ5RlUy6gV8/7WXCgcbi2cdMhD3pRxZzgwTLq/5KfIc2FKEzXsC4iYMbx6g5AAA4zzTpAP4JPfJyY3Z0FUMTOCIuAxiGuClVcHWaIx8jnkqTiQ9yQDtX9ERvg43V+UKyykJGmIf86U0AqlHjtdTtBus6WOeSzTFYvYWVQmW8RA/Ukg7onpWWyFDIbcMWVbJ3Ha2JnSbIdqVJmReO6BXYLghh5Bb4RrTGVSFPAir9X+VgvqdgYOb4ydFuK9jaxZq2GdTFCFVXnH+WtqpSHCOlkuL32EjxSIX01uKilpoULZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VXbUu6pN/foWSpf5t/cqIEwwRDxnml53J2oU9Q82DXg=;
 b=g/XYOWpye1wl1S2rITwxSHOuD/k11z7ycwB7g79ZD8thz6PHKkCh+3QQGX1HFT+F6lFxhQ53WUcdluZhnlj8V89K5DnDNUEIHxyOnKNseLA48zkdkwMydNov/SqdWFb2pUnxWhIt/46DrUbeH1t9w6GiWHwdhUYr3/E2AzYk0buuH9A3Qib6qFLsqfxP6iU2DNEDHNNMStB5x8EhyuP4wG22JL1Qaemm9HH9WAT3+vR49/X8x5LrUyxU3kg9a9Wbj/f6G2KDhaVNhEliq6oW+GHRHuxuGTGQaldpgnZNQzOnqcQGYxLfKBp6OyoA3hFbw3QRfxc45Md0FRL9Qor2RA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VXbUu6pN/foWSpf5t/cqIEwwRDxnml53J2oU9Q82DXg=;
 b=g+Gol8FT/t0Y/UeWavu7GjwWsqDRdbpmSndZnHpJ1d4VVZPXiH299AU9TkvOgYyjngQ+A6AtjXCpvwoEnLuZSyUcY0r3fuke3nj+iP1tDuFBibTc6PyWeCLDRmzZFc1p9vK1QGv4ogTrNaOexcxEJhlBZA75UKrQlpzfAfMNBio=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL4PR12MB9505.namprd12.prod.outlook.com (2603:10b6:208:591::16)
 by SA1PR12MB6749.namprd12.prod.outlook.com (2603:10b6:806:255::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Mon, 23 Nov
 2026 08:33:01 +0000
Received: from BL4PR12MB9505.namprd12.prod.outlook.com
 ([fe80::73aa:eb8c:a86b:5a83]) by BL4PR12MB9505.namprd12.prod.outlook.com
 ([fe80::73aa:eb8c:a86b:5a83%5]) with mapi id 15.21.0639.011; Mon, 23 Nov 2026
 08:33:01 +0000
Message-ID: <1f0dfd17-9cbd-4d7c-be9d-05c04d9c8150@amd.com>
Date: Mon, 23 Nov 2026 14:02:55 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] iommu/amd: Do not clear unobserved log overflow status
 bits
To: Guanghui Feng <guanghuifeng@linux.alibaba.com>, ankit.soni@amd.com
Cc: iommu@lists.linux.dev, joro@8bytes.org, linux-kernel@vger.kernel.org,
 robin.murphy@arm.com, suravee.suthikulpanit@amd.com, will@kernel.org
References: <4nnekry6a3q52hsibm7cqrwbtrkr5vp6yuhwucreaz3pckt2a7@rh36fx2u5i3o>
 <20261119141348.1601037-1-guanghuifeng@linux.alibaba.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20261119141348.1601037-1-guanghuifeng@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0322.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:21a::10) To BL4PR12MB9505.namprd12.prod.outlook.com
 (2603:10b6:208:591::16)
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR12MB9505:EE_|SA1PR12MB6749:EE_
X-MS-Office365-Filtering-Correlation-Id: 0de52289-8f0c-4602-cd01-08df493c62a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|376014|366016|261026121527099003|261026140227099003|261022105027099003|261028144727099003|11063799006|4143699003|56012099006|10067099003|261009223027099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	ogN2JOZrELIE17LuFQIFBxGr1YZBD3MO52CKhJdfqWaHJKTsKDY4NuLdPXMVYdhDkbBruK2+eK5EtT2S917RBZwPq2SscdMpSvm8Tno80OHpYo9TPESSiJkB/JSAZkr+2Goupo37a8uiLRl97KKy33uJin1EYy7FAJQtbn8xyYo/7racYxR5qDMGGpEZJqcJc6Vad6YFi7/u/UpklDLIijoMhyIoNXBlmTkpWStoY5bGdIYRlGWL+lcB1jqsVVJOhU6Oyl7BZMuf5ffT54I5PGRr51crZO5P02Il0tqJYzQ2NjKnyB2CwUb/Z1OcCDKt+Svqhg/tkSUVxgIzz5PDEoSWQ6Y326gIT9Lf4cv9EVVC3JF8mY5X6Fd2buvQUDQwOe/hfLGE9fcaeWBpveAHx0cFvr42hYj516YVOOcbW++I6Q4ogd2Z7HxsJBztBkWaqzlQEtH4u46dMTMsIkR01N7C1ZZkkhibll5vObUHpLanDIlQe4yl+gv1SSmbdUORnXREp5OpsUFBj2PLte5/1I/TGH74hl3A2n76OLfzN0RioGZjI9Z3ZV+wnP3AVNAgWODFb+LL0hbVaQiojnDfyYN5ULpVUx5Er0+U+xNh0xFDCc7Ka7zBhXF2CW8mJ7PpbJpCWIZLtr2dGNvrKtKJX5YSQoOTYN8PeVKFBzTrz+Q=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR12MB9505.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(261026121527099003)(261026140227099003)(261022105027099003)(261028144727099003)(11063799006)(4143699003)(56012099006)(10067099003)(261009223027099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WFNIZzNNL29CbnhqOVRhSGdMMnA3ck9PQ2xKaGFzZEV3WVJsV0hmL2lnWHly?=
 =?utf-8?B?SWxCckNuU1VWTEc5TUVpMW5oeHA3UHlwN29QMlpNaS95UXduTGxQYnJqeldB?=
 =?utf-8?B?bUI4bW9OemozNks4ZEdVQk4xZXdYOTNhMDBTbW83WE9WVUJkWFVpOHZkcWpC?=
 =?utf-8?B?TEUrdGRNcG9QcTF2cGVpK2pnaFdrN3RhbTN1a2pEUFUweEJxK3JXN0hVYjFU?=
 =?utf-8?B?eUovS3VRcXRWOE5tUy9CajIzWXVUSVQ4OENhZkxjWTZLeEhtVzhldW5WbXgw?=
 =?utf-8?B?L0ZPdXgwYUdwRUF2Qm5zVG5NdHUyVE1laVhiZmluZnVLOXU0VlBTbTl6Z2VW?=
 =?utf-8?B?aEVJdnNSNnAvOXBkVzhUR0E0eWVvWHVQRXJhY0lnL3BiUWljbjBVSENEMDk0?=
 =?utf-8?B?RjVzZzJoc3dYdTRyc2FIck9aSDdGei9JWnNYTnlCU1pvVkZxbjdXTlcxRmYz?=
 =?utf-8?B?Qy96Unc5S21keEdkOFV1aWdQVCs1Q1JWcHJ0R2llUlFIWjM3WTd3YWlIazRT?=
 =?utf-8?B?RVBjdSs5VGtpWW9oRUUrMTY3Kzc3ZXRuVHZnWGFjd0thNDdSN0hKa2dhaDBH?=
 =?utf-8?B?cmhQL3gyUkRnWW9GaGs3LzRuNVg4QXFSc1VmYW84Y3NkaFNUV0xnUTFnL1l3?=
 =?utf-8?B?VVdSRGNENHM4c1JhVkRZZytwR3REM01yOUpSTHVyck5WK0s2RUVvK3N0MUl4?=
 =?utf-8?B?TWZxbkY0TlpQTThLaXBVSnZyajZrUWNJNjlaVGdjUHdsSThCeU1iVFRKM2py?=
 =?utf-8?B?VjMzL001ME52bjZpWC9wMkVqeTlucTRDLzZ4U2FXZjdOYkVYc1FJUHd3U0pO?=
 =?utf-8?B?UG80U2s0aXNQblBuenRKeUpibm1udkFnNVNpUndOWkpIcG10NEpmeGpqem9R?=
 =?utf-8?B?ZlgxbStnZnNpS2s1VGZ5Nlo1clZtQUhSSE5mVHRJMGpIajREQm9qTWIvZzhu?=
 =?utf-8?B?Q2ZvNFJ3QktrajFIS2E2akwxRVVoUm8xN2RwZ0lCYWx5Sk9oVTNSSzF2SGtO?=
 =?utf-8?B?cndvaFduOEdqTnB4NnZWVHVxQjdwNm1VYXdBTGRKRWVwSzhaa0xQL2dOb0tD?=
 =?utf-8?B?ZlJaNmV5ZmNFVmtxbUF0UnhnN2lIL1NLZkdZVmZUZC92bStIUWZqRUdJYjFY?=
 =?utf-8?B?eTVpMUNaRGx0b2psQUFNOTMzdllPNStJeWRWYlpFcnhpZVc5Ump5RnppTnhQ?=
 =?utf-8?B?eWVYWk5XalRwL2hZVldDcnVYcW9qZTBrZ2NxdjZ3RmVwcVhoSXlGbzBzbU92?=
 =?utf-8?B?Tzd2azY2M01za1gyaU5oUnZ5TFJpcVNrSzcwZnV5dUlIOGpZQ3RiNlV5ZTJz?=
 =?utf-8?B?UFcwSGdYejhVNUU5Y0JmN3o0bWRrVTRFQ1hpSWlqYmYzdkRHYm03MlBCVnBx?=
 =?utf-8?B?R2FycXh2Q010Nk9jRXFrekJGeGpxdXAzL2xudEJPcTJRZW40amJQTWx6d0tB?=
 =?utf-8?B?ZGdtK0NONGZMTjFuTHVIRjN4TVB5VkRMSGFYOWJGaTVhc0dWb3NnNDRPTHU1?=
 =?utf-8?B?dkNCZG4wcmwvb0ZWU0FMUm84dmpxSWhhOGt4aTl4S3M5aVovMVlKQ3p5Z2J5?=
 =?utf-8?B?WXgyUFdWblZacDlJODZtcFNXbkNYMzA1MjF4cG93M2FldkxiTFNwRlJuU3h6?=
 =?utf-8?B?OWtsMUxkVFZiV1A4OTNrTERvQUh3ZGNic0tUdXRZcEhZYzVPME00S1FZeHVv?=
 =?utf-8?B?eXQ5M1ZGamtGay96RnN5T3FjbFl0QVFqb2FET0pvVVVJTVlYQUlKWTBkbERC?=
 =?utf-8?B?RGFSdkQvRjVzMFJVb2owV25xQXpDcGVxNmVIRGdYZER3RTI2TlJ3cmdFcXJ5?=
 =?utf-8?B?VENWNjVqOExuT1Exb1c0NnJRQkFjOEVobEs0ODRnY01TSU5iSXFhSm5VL1lr?=
 =?utf-8?B?ZERqM0NxR1l4a0dqNHQ4UHQ0YTN5QWZWdnBIK2hYcVh5UVBYaUVOMzU3aGNj?=
 =?utf-8?B?ZzZnbzVSVndCZ1ZnVElCSVloSFFrL0hxMjdIZU81cHJLS2R3MzhRb3FMV21H?=
 =?utf-8?B?SG0wV3lDbG9YcXgzeWhDdjg5aEFBOTFES3phRHhrcUNtSnNIMllIMU52Znd2?=
 =?utf-8?B?b2tCdmRqKzVCMXZkZzZzQmhqRHZMUEJRRUtmczF6dnJnQXhtaGtyVnoyM3Vi?=
 =?utf-8?B?QjBIdXlOVEVWdDNpU2Z3MDJNbkFBRStUclg2LzFqUlZkVzF6NVMvekdSQW13?=
 =?utf-8?B?ZGxUUkxkc0h3WXhTWTJobGZlRkMvYkV6WmpjdzMxUWFQYjQ2SlVyWUNQQjkv?=
 =?utf-8?B?djBWQWFQeWwxWDBuMmozMEF4T3dGdHJzSkptYnBUL3RBVlNxRWpVZFd1YnRk?=
 =?utf-8?Q?+lG46u+ZW49ASJ/vVA?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0de52289-8f0c-4602-cd01-08df493c62a4
X-MS-Exchange-CrossTenant-AuthSource: BL4PR12MB9505.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2026 08:33:01.3296
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wKi6YHRSWOhJKd0v5TyAvwnMFGtgx3mcnGgJC4UIGDLtOzjTK99JVANQnOE5uDrFlxWu1/L1uIuTDihOnui/Sw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6749



On 11/19/2026 7:43 PM, Guanghui Feng wrote:
> amd_iommu_handle_irq() clears the interrupt status with an unconditional
> writel(mask, MMIO_STATUS_OFFSET), where mask is int_mask | overflow_mask.
> If hardware sets a log overflow bit after the status register is sampled
> at the top of the loop but before that write, the write clears the
> freshly-set bit while the stale sampled status does not contain it, so
> overflow_handler() is skipped for an overflow that really happened.
> 
> This is fatal for the GA log: GALOverflow generates no interrupt of its
> own (MMIO Offset 2020h bit 9), amd_iommu_restart_ga_log() is the only
> recovery path, and per spec section 2.7.4 logging stays halted until
> GALogEn is toggled -- a bare W1C of GALOverflow is not part of that
> recovery.  The GA log then stays halted, GAInt never re-asserts and the
> GA log interrupt line goes permanently silent, losing all AVIC
> non-running vCPU wakeups on that IOMMU.
> 
> Clear only the bits observed this round by writing status & mask.  An
> overflow bit set concurrently is then left asserted and is re-observed by
> the existing ERBT1312 status read-back at the bottom of the loop, which
> re-enters the loop and runs overflow_handler().
> 
> The unconditional write has cleared an overflow bit since commit
> 5ce97f4ec5e0 ("iommu/amd: Recover from event log overflow"); commit
> af47b0a24058 ("iommu/amd: Handle GALog overflows") and commit
> 274c2218b8b2 ("iommu/amd: Handle PPR log overflow") later added the GA
> and PPR overflow bits to the same write.

Applied, thanks!

-Vasant

