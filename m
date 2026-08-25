Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013044.outbound.protection.outlook.com [40.93.196.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4480E32B105
	for <iommu@lists.linux.dev>; Tue, 25 Aug 2026 16:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787675779; cv=fail; b=kEnC7mSf6UQkr83n2YjoJNunLRpXGrgVLWE/cq6uwQdLQp2QhQzutFobHNMKlho+boE13hT1V+8RmB4oRQvlAvhvS8gEdeS8shlC2zrjuiywXlo8/jmApand/pYzv2Y0lHZ04CMGz7EtUzIT7urC2NAV0APGif7TumrDT2Qm3KE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787675779; c=relaxed/simple;
	bh=EAwigCqkKtjs5avoiLpIZ6kiaBrd64noppKB/R30ot8=;
	h=Content-Type:Subject:From:To:Cc:In-Reply-To:References:Date:
	 Message-Id:MIME-Version; b=HP/r/VfKrEgbi9SMVgTZBq2T5LVN5EPukG0P776MG4v0TB6TNuMRO3ubkzw5XTFVJBxrFEN0QFQ2sclfFd7L8kwDKD0svm0Qz8lIkQip0YMyeeh2Il913vXGzSKk1ImEwRnExO1wCCFgBc7p4hjiTsLlEJyvsvAa4rfkrDEA618=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=uDu2dCxt; arc=fail smtp.client-ip=40.93.196.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="uDu2dCxt"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MIf/CX8kwmp3PuKkf7hFd3bWIDtpKwm5IEM9b+SnqeoMsMNMzj7M/8nSCouQamdVND6Vu95Qoxm8/CcIKQLWEAd2qJ1VJLXyZsSGaHOy/+gkpRDSSES9STmd2MHwnOiZ3SLBmREpG/Y2oug9dcBEMcnXhew8sPRUkLXKR2a73A66iVJSi/zOT2fv+pSruxkRB4XDziUyTHBS97xaB0vnlrA5Wz+KFOkpUN74lKGFIm+PEQJbiaZU1PgRDpdRYnOWBKKY+KT0v+JxYSMlIGtu1CZK8zMsdlATC+V9AB9ch2CGPGSOuvpHht9FFC4QTk0SG43EHAg/S9yfsvfZeUQs8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AHPTtxtmedqfZgXjqDDSsL1hEt0snnUPutHEFyzrTb0=;
 b=vRiw73baFdYNqseVn2dujvXfPEuSbrK+dq09z48pIN0AOj14n9vWcTEV37MTOwd0SSt0+qI6dOhQPZvArcOSQBO+voAOPMX12HpjJ430oRuMmZ2f8KfZnpLkP7bUjnSBjTqXf8j4VwIQemEVn8mNhIOMhEOGFDXqHDlfJksqzyohtfm061BziTw3Es1UvpN8lUBQWbHG3wvNVKZNFPqLAoieefD4FlJhID1r5Y2FUZ9GKgukPLPhYI6R+MB4DGgWfiTiLN/Jej8YXua3FjYPC57pmZvLSd2uRzPf1gokd+BpF14upPRUzFQ5IVSjHpUG/CyeDBjLY0tF2MIypjP8iQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AHPTtxtmedqfZgXjqDDSsL1hEt0snnUPutHEFyzrTb0=;
 b=uDu2dCxtTafLtBLQsxGJcig6s9NWf13LkBCbG2HekMplMXfsmRQTJC9Vrwf2hHUlJJK3XJf4ngqaBELYV0L6gR3dwRxMhdB5c9cTnQ4skXULpddWDYxgveg46S53bfre0NOxUHJerTEwYA4TdQA5WHk374bU//QKBOr1Vl8NFcgOzMx6naotluCUVUVdTf727JFhegBNSHEHmq7AsqpSjcEzkiqEb5oUX0M4PKdynrVpFPUnSQI7jtwBsVT8JRH9r/nlNSB7eKrCTcxDRcZYikqOPv4Jzh8W2xh3a38xQ86CZembKjntZLUxU3GE1cM18q5alMCsCgU2waz+ArnydQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by IA1PR12MB9466.namprd12.prod.outlook.com (2603:10b6:208:595::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Tue, 25 Aug
 2026 16:36:14 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0339.012; Tue, 25 Aug 2026
 16:36:14 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v9 06/12] iommu/arm-smmu-v3: Handle gerror during
 suspend
From: Jason Gunthorpe <jgg@nvidia.com>
To: Pranjal Shrivastava <praan@google.com>
Cc: iommu@lists.linux.dev, Will Deacon <will@kernel.org>, 
 Joerg Roedel <joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>, 
 Jason Gunthorpe <jgg@ziepe.ca>, Mostafa Saleh <smostafa@google.com>, 
 Nicolin Chen <nicolinc@nvidia.com>, Daniel Mentz <danielmentz@google.com>, 
 linux-arm-kernel@lists.infradead.org, Jason Gunthorpe <jgg@nvidia.com>
In-Reply-To: <20260728210928.1050849-7-praan@google.com>
References: <20260728210928.1050849-1-praan@google.com>
 <20260728210928.1050849-7-praan@google.com>
Date: Tue, 25 Aug 2026 13:36:11 -0300
Message-Id: <178767577113.3356902.10872241669143339312.b4-review@b4>
X-Mailer: b4 0.17-dev
X-ClientProxiedBy: YT3PR01CA0150.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:83::18) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|IA1PR12MB9466:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ac24ece-7ffd-4ac1-ffa7-08df02c6fa56
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|23010399003|10067099003|5023799004|4143699003|56012099006|11063799006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	ZJBV23iTZ2KLLIwvEVRqWNGfR1HhYLSa3fw6usHE4u2wahKLqzzZEy31ST3yraMX4sVzIUK2paEFLiP8ApbJ+PiWNNOi/0Yq4chCqnGoGBx6APxMZhBKqgPUWXkkVVaQlpHo+lZPdils1R3FjnBw9vQbQ1PQxXOnqLzaz+MGcTB0es/+3FAlG6cjqslQDt7EfkYwI3hM/g5HG4YiEubkblc3UkMqgggGIv0YHwz7zvhI9FJk948im7qps36XTxMJyCwZVljP+vNaAfCl6riqpOh8LylBVWS3sD0ZSzCgDcnJLcgaYzI/f4yxEST66+BNnVDKjtby0N3nm7/LnsciL19ADeL4M3pxImztvzP3ED+umBNAlYkkTaUa78g7Z48uM5Yqfk2TKODrd6nU0Fxlusck5Tj3EpopiOM7rs+YG/++gOtDrESv9D06uiZSVySgS4y4FnSkBqf/D2KkmMSTYCphKDgf4MsF/7Hyur7YDpQPpsdx9B9QgXARFgGyVB5TsA6gygeuJOvoXu0S2NllRTlN+1pL1MuwDgdSk0e98NcKkN+uyT477DMB7326xGgpNqmTms1Cty6WUFEJJBIW0ft6L81usjrzqJyb1W+N/mw5DLlnjRmYpuU9GhUpX88+QhVkg14Ga1kLpj4Edat7beFnV6SPiqntNIVyscLX/BE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(10067099003)(5023799004)(4143699003)(56012099006)(11063799006)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V2lWc0hWdHh0U2E1ak1vSUdxNm9OMmlqZkh0aktST2tiWFQ1a21oZTVZWE5w?=
 =?utf-8?B?NlV6VVIrZ3k5dDA4TjRaRVlLN3NITzJ0S0NkMXdzWjh5am5Cb1VIcXlraWh5?=
 =?utf-8?B?UHZUdnZIU0d1TkNnSlI5dUdpOFJCT0RVWmE1NUgxT2hobGt5aTlmL0NXTVN3?=
 =?utf-8?B?cElVNVVCVVJEOUNjRDFEUytKUXpyM0tsTXZHTDhVZnZybURHNEJzUUR0R0VW?=
 =?utf-8?B?RmRJRndUSm5vSzVsUWhzaHdkcjNWL0dKRlRaUWVYK3dOTEh3S0Q1MjhiUXpN?=
 =?utf-8?B?VDRSUExBT3Z4cjJZVm8vWTJBTmpRdEFFNGk5REtFSXc2VUlOSFNsWnpiV2tX?=
 =?utf-8?B?ZGRHMlJSZ0Vlb2szQzBrWFZxV1ZCOEQ1NlRCcjlXdldVSzl1YzlVRmRjWFRS?=
 =?utf-8?B?NHN6U1JxTHdMN3lTSTg1blA1M2pzUzBxVEZzbHJaWDhGemhsMDBMRTFNSDVo?=
 =?utf-8?B?WmI0Mkg0dkJlVGJjcmV6QVlTTnRlL1pvMEluam1BTVBEcFMxZlpwMlV1M3E1?=
 =?utf-8?B?bzF6cUxlb1QycUdPUnlWT2ZhdStZK2JsQ0w4RExsZkVVYjI3WHMzZURUMkc3?=
 =?utf-8?B?WHNhdkVpWTdsdnZIVjFsRFhqeG5iNVdhVHgyb3Q1RjZnZUJEbEU1R3hSWVJD?=
 =?utf-8?B?QmtTT2Z6MEdaREh3Q1ZSaWxXalJ5dVlKRzFzK3lXMk9YVjVjeGl6VW1saWRt?=
 =?utf-8?B?emZ6b01QUmRXOWxvM3hzeVdIUEk2bVlDRjVxK1VtVFU0RzNZZ1J0WmgyQlFZ?=
 =?utf-8?B?c1E5dkkxQVdNM1lFWUtyT0RWdlIrekxTWTZXYkhnV01SdUIwcmRGODlMYmkv?=
 =?utf-8?B?bTlXQ0Y1Q2pTR0JqK012UGJMRXNaYUI2SFh5dzVzc3diRWhLcEVXd3pBKy8z?=
 =?utf-8?B?S1lWQkNlZHFxSkx5RUJ4V3RCNmgrT3R6V1FUcmgrN1UvUXVZYXVWU0o5SXJp?=
 =?utf-8?B?MUZpOU9DTjk5L3NucG5ySE81dXQwWnRVTllWTGNKM2lub0hwTHhZWnl3eWJ4?=
 =?utf-8?B?KzhHdnJlU0YwVE5FczNnY204YVlOVEJxeCs1a1pLa3hQbUwveWlrekpIVG1x?=
 =?utf-8?B?aE8wZDVDeHNHaG92amNpYXZITzFJajJnM1JVbDAyWUNDMnhRUkhWL0Y0Rm1v?=
 =?utf-8?B?eFo3MVZBSi9STWFoS0orbTJjb2hjYTROcXZWZVBlOTBMdXF2elc3d2VtZ1B2?=
 =?utf-8?B?R0NnYVkrNk41b2dubk9uVkdMemJYS2hFdzA4MVlQd3UxNnRoOXlHb0w2ajdW?=
 =?utf-8?B?dHFoNGZHV3B0enNLejh0Q0tnTzUyNVgwWmR0TFd6SlQrSk1UK3hiMExPUzUx?=
 =?utf-8?B?U05YWnhNVEhwZ3RWWGVNYmtya0ZnSERzb0ozemgzaVpBeldka2UzMmhYL2Jo?=
 =?utf-8?B?TXVRTjVreWxMZXJURTVaYmFMdytmcHdpWVhITzJVeUhuOE5aN1NmVHdWZG92?=
 =?utf-8?B?WDJTWCtnMERrMnB1UjRUY3NKdDEvUUlFV3FFSU1lMkZuTlBDMCtVQ0c1Ykd4?=
 =?utf-8?B?aWY0Q0luQm5mb1VwTWFoSEh1VTJSajIxOStNajZvMThFMUNDbFRIRVA5cFBM?=
 =?utf-8?B?cFFWUG5jSklVVWNpMTZvREN0S1pNQmQydHNEczZVdFZZY2RIWWpsbmtYWHdl?=
 =?utf-8?B?N2NEdFluRFJlT2RwWk5pYjh0RmJVSzYwVWdmNGIxZW1reU1lVkNoVDF0K1dt?=
 =?utf-8?B?b2Y0V1RmWEVtVU4vWUR5anpKZVE5cDNLREFEbWtSakllVTJJWTlMUlk1RVli?=
 =?utf-8?B?NER0cDlySnBwbFlmSkZtd2pick9BNlF6TFo2MmZjQk1pK2R2NzYxUEcxMVIx?=
 =?utf-8?B?OTFEWHNDTXhOODFvU1FzSXRmUzdxbTVRcTAxOWgzcjgwaUtiWEppSFVoazJT?=
 =?utf-8?B?SXJ0U3lDdjlIMUYzcmdOTDZqYmFHUkd3akxxTW5xcmh2eEZVMitKU3BZYml3?=
 =?utf-8?B?Y29qd2xmdHpBSjVpOEJLQlZScHVPYStUVWRxaHNEV3djMkNhK3BBQUpGSHBR?=
 =?utf-8?B?Z0hZcWhyeFBJall1YkVTd0h1eXFOZk92Nk83blhXOWFOd1dHNHBsRjUwS0ht?=
 =?utf-8?B?Z2pmRnJzUy8zVUZIRExRc3hCNFI3Q0Mzc0hnOVVpYVRxR28vclRka1pzKytj?=
 =?utf-8?B?SE5tRG5yOTFtdnVEVWF2Z2s0ellQZjVkV2d4NnArdXg1OWU4YjZEdVZXUmRF?=
 =?utf-8?B?YnZkUFpqT2xpcmpNNG93cVljbGVuc2hvR3FMTkxtVUlYRjkwRUN5blhNbjhk?=
 =?utf-8?B?TEgxMkpFSThXMmVEdlpBVkE2K0YycFI3KzlDdUN1WTA0YWxCSFIvMTBocERp?=
 =?utf-8?Q?ogm8i4+IKAE7+C2ZLY?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ac24ece-7ffd-4ac1-ffa7-08df02c6fa56
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2026 16:36:13.8338
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uKbAAPZ/fpwlbA1i1TnxjfRTHZB32+DiyQ7C+Ge3+0CRoS5yC3LK6StklKTxVjtK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9466

> The GERROR register's state might be lost when the SMMU is powered down
> during runtime suspend. Handle any pending errors before suspending.
> 
> Refactor the gerror handling logic into a helper function and invoke it
> from the runtime suspend callback after disabling the SMMU. This ensures
> that any late-breaking gerrors are logged and ack'ed before the hardware
> state is lost.

The commit message isn't clear, this is just a refactoring patch it
does not "Handle gerror during suspend"

But the refactoring is fine

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Though sashiko seems right about the pre-existing bug.

-- 
Jason
