Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.195.29
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795630081;
	b=H+bvhnC1FkJHVXndUIO5qxODR1szZa8VoDLtr649sPZ+AkbU0aT2OAOxtnbPw2DgsjHj
	 x1v3EUc6tTsn0wErEAn/OsApl4OOG/xIIzCBj0aha5tuo9knJ9fUgosuZmqXzm6i6iJg4
	 k7WwH3ZCxZxcvgmQnHsUSIMQwLARBf2Zk3M3IipA4zgJYExPUwgZSvXVAnx1a7E5R8kzD
	 V3Gq8iipr5CLqyd+xrqlheJGOMuPMnVpwQ6ObzmowPsJHYSm7/U4wOaEBU5HJFjnbDLnF
	 2b9cOSd7+/qwwzBOYhAQwMf5G8kG0F3P8/F4j/fHVrs/FNrWLT2A4dp3tkZgcZb6WzQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795630081;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Content-Type:
	 Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:References:
	 Date:Message-Id:X-Mailer:X-ClientProxiedBy:MIME-Version:
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
	bh=UFDmw24d6m0Q3an/CvsmMe7HKIB5j+BzGB+w6Av88f0=;
	b=cVQExDqGOAztlTYmr3zU3jZ0kF8juGbGPjnN+SosDpeLxPVnqPcAvf4MtN9Y+d/qBHoE
	 gtpsyOL6e8Ug9c0/f6Yi3dmcYQfW1Y8+KyzHTgXbS06HXLmX8GW+wv6MiTWCTI+MCBgoS
	 texXLoSfUjr7E8O9Gt7krXdsdnzSREb/3dP1mD/suK4qKxEJaDLcvq3UdEZpU+YesdG1O
	 IkZ8yrvJnNIeLee42+DjTNW3o+4m/MPjs1x6ksm72gcHg+OOm07l6ykIUPL/TQ6diustw
	 bvAxdQO2jPMg3/mfk1s/BcJqpM/k0/9E1lGVXGq/Kba3o7AqcTePbxNMmhxBfSHqwag==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=raK5vKbT;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.195.29
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012029.outbound.protection.outlook.com [40.93.195.29])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA52E606A684;
	Wed, 25 Nov 2026 18:08:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BA52E606A684
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=raK5vKbT
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=towj3We7MtRxmkK0yHDH2HyJIIA66Mc5VTUHfyGu9/rZ5QRfr60Z2K22R8j4BpC0/+SSX/7WNdHxSuzmzbwVsvCUwOQLvLdaoyEEWMsVC1hDZLMfaHn8BfcIkM4/eCqz6s0ZX4VT+eQOdN/uXxtjqAnUWuo+HzKYxXz/JCUlr2PQOEImz3rLcBR/hWKv3OzwZnB5q1XMqEx12iFQAnhkcs0EncoPDPqGkl4w6fS+KAjpwwEYT9MvmNUHNU7nrJ77BwoSurF3L9hyIXCnyQ9jkHDDOz69dv/RHxj5dxVfE4dEzbwnRpl27q7481x5h7wrWXYUOrH+AEh6U0b+y/TI2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UFDmw24d6m0Q3an/CvsmMe7HKIB5j+BzGB+w6Av88f0=;
 b=zOmBggUgG9SfU9mGmqcbJCxwi82bWptUsdS0WRqcvFGkcGakD3riq5xrT70gn32GGhVcvkZFjRNE9ej+X99Vj9UYZcN48bigXOW2x8cEUcrlvJ8KOT3p5IKze0TasBLqZpos+Ba6sdDAcBqD6nAW0KyBGJyRCocZcEeaKcEcepDS1qIsc2ATPgpAH5ae32wZEGyXY/GMsKRv0/tFI24iSiUv/QMCBiQdoE1O4gVbxtj47tirTf6KiKBjVRa3nwzOyTZ818hxUaINPp7iRRsalhGjO2II5Zxcfq1cj7mUBwJLRRgf9+WEGIvmBU7Nt0rOidEU6XcI0EE52nK1y5+1fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UFDmw24d6m0Q3an/CvsmMe7HKIB5j+BzGB+w6Av88f0=;
 b=raK5vKbTJQ95QJ3uItBfrM9flVB8sAJE2R7opsma1+5wQZKN53gkHvseE5KwIIDRKoDcyxEfvR5JspMQUk2fr1zngXQQ3KKLj1NfnLZGl43ljUBgdLutsxippiSsr5ZWTzuNnpawpa1sczopaFiB2fOKzNC53z6+crgKisg+bMu7KVdDJs1mF+txXbKYHtZvDVKIHV8z0YMIPxM1M2Y9AfZC5etWkP3FLV+fTQZJ5fjKs8d1HHg27zTaFoXwSOno65xXBnZOqJ/iRMlN884sGNJScx+AmSjK2bdmHGqOiUhPrZorEvIFLnFwpAtGlzfeF7gvK6lrQ0fZywFg27Z2gA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LY0PR12MB325698.namprd12.prod.outlook.com
 (2603:10b6:408:3bb::14) by DS7PR12MB5815.namprd12.prod.outlook.com
 (2603:10b6:8:77::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Wed, 25 Nov
 2026 18:07:53 +0000
Received: from LY0PR12MB325698.namprd12.prod.outlook.com
 ([fe80::b65f:1548:5b35:e2b5]) by LY0PR12MB325698.namprd12.prod.outlook.com
 ([fe80::b65f:1548:5b35:e2b5%5]) with mapi id 15.21.0662.004; Wed, 25 Nov 2026
 18:07:53 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3 6/7] iommu: Park TDISP T=0 devices in the blocking
 domain
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>, joro@8bytes.org, 
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, rafael@kernel.org, 
 Danilo Krummrich <dakr@kernel.org>, Johan Hovold <johan@kernel.org>, 
 Marek Szyprowski <m.szyprowski@samsung.com>, 
 Mark Rutland <mark.rutland@arm.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Pranjal Shrivastava <praan@google.com>, Mostafa Saleh <smostafa@google.com>, 
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
 driver-core@lists.linux.dev, Sonang Patel <sonangp@nvidia.com>, 
 Ankit Agrawal <ankita@nvidia.com>, shameerali.kolothum.thodi@huawei.com
In-Reply-To: <6620f49a3bb96837034aba24b5131a9d8c7eec8c.1794343501.git.nicolinc@nvidia.com>
References: <cover.1794343501.git.nicolinc@nvidia.com>
 <6620f49a3bb96837034aba24b5131a9d8c7eec8c.1794343501.git.nicolinc@nvidia.com>
Date: Wed, 25 Nov 2026 14:07:45 -0400
Message-Id: <179563006502.253973.16635562157369118727.b4-review@b4>
X-Mailer: b4 0.17-dev
X-ClientProxiedBy: YT4PR01CA0026.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:fe::11) To LY0PR12MB325698.namprd12.prod.outlook.com
 (2603:10b6:408:3bb::14)
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
X-MS-TrafficTypeDiagnostic: LY0PR12MB325698:EE_|DS7PR12MB5815:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d38e4d1-7a3c-469a-ef91-08df4b1f035e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|376014|1800799024|7416014|261026121527099003|261026140227099003|261022105027099003|261028144727099003|11063799006|56012099006|4143699003|10067099003|18002099003|22082099003|261009223027099003;
X-Microsoft-Antispam-Message-Info:
	hMhjWpU/CdbTZZGJ9HM57DqB6JUTaNXFtEtCOLGEDLVJgAD+sypmKHIr9rTVl5usnzYZavhQYfTOm485n7vHbN6xNA4VAsLXWLiOU4gaZ/sFQibdlDXwpZLx0BWrZKX8dumfxvVcZmRB6MzyMfudrQVN7/NtErr6G+AGk2e5jqGsr3kEpGR5p5MqfEOH1JL0s6tuNDuawMzQLVDQeNj4cneOW/P/u7GMTd8+1rfcbruUAGYeiPGQLwJ9SrPLpTy/m3tqa1uE5bsvYARBeIG/JQ1UXXcRC+5VVvnZnzdBm9Q1pGF/Q0KSOY/ECgTkXSNuqE6CbkfBy2CDYVJHZrGr/Csgish6m2iEGBbAjTWbskoI1wzl1Yv0yYb5TNxHSGk6V77aj09JzM05AGI79E59Dyb1W4HGBDx5CJjpwgUuVzRFYsd25OTe+NdMX+wEGiZqdUMRDOJL7uk5f/lvq/Jdc9p7en/AVH9k0cgdps4RMi6KwQD+oaqb0HfPJ2r1JDBnRKSVoMzRuQA6Hlaw9QzhnAM/jpk/pXwhc644zR35O77wAxC8giadzTYI24Bdilee3hjwo0O/lj4Ju1x7g1WukYkqROVuzRJ3AlfC71gNEw20CWgb5fP8/bIhncFgwnsyh9KiTqhNOOa7akRV0MuMYVWwDAUjm1YNct149FeF2LA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LY0PR12MB325698.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(7416014)(261026121527099003)(261026140227099003)(261022105027099003)(261028144727099003)(11063799006)(56012099006)(4143699003)(10067099003)(18002099003)(22082099003)(261009223027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SE1teWRvUURUaTMyV1JCenJIb01HWElUNk5qQTNUZXlNNi9lSkRXZEhNaE1z?=
 =?utf-8?B?S2FYdksxamlJbkpNckc3amNRbFdYakhmMXZ0TEFMZ3M0dklaMEQvZmpKSmh3?=
 =?utf-8?B?bGU3R1M1Ykx1VzZ0aktMZjE0VjNQeU84SXNLYXMrTVJYcytJS1NXbWdITXhR?=
 =?utf-8?B?K1I2K242d2FLVllhZk16WHZGL3dBZnZXL1E5QkI2c0tzczlpVC9wU21OOGEv?=
 =?utf-8?B?dkJJWjBTR2ZjeE1FVU5Od2FCUWhFSzNTWENxR0FpOWppSW0zTloxM29hR2JY?=
 =?utf-8?B?SSttd1hJZFg5bG9WSUZpSTlZeGQ5QURUbUNGRzJsQ0ZOMFFrWE5mTHlXV0Mx?=
 =?utf-8?B?RENsWk0vWkZpVU04YnNraUF5ZXg0NEZEcitabDZlUS8weDRHUXNjVU0remxz?=
 =?utf-8?B?MENPRUJ4bGlUWEJVRGVtSE9hQzR1MjRTejlkaWFTUHJPb1p1WFk5WVNVeGo5?=
 =?utf-8?B?U0FIc245dW1hSkx3bjRaSXh6MmR6c3RTTXhSbHBCT3Z3aE1iY1Y0Z1dkWm8z?=
 =?utf-8?B?aE9HUzFBbXc2bGFxTWRkM1Q0SStkTmMzaUdiMkFTWlQ4ZFZFVEVTVFd6bW1S?=
 =?utf-8?B?WnpDVnNYNDlsWVBxQ2dpSEo4Rzd3K3pxQzBSS1NzT2tZTEtPWEJaa2tnM1hT?=
 =?utf-8?B?VWZhWEhsTDBuTFNkN0FCMEhWUnA1UkVDWktUNjUxVC91UE9MZTB5NGhqa0k4?=
 =?utf-8?B?RWZ5WGRFU2VYWXJZdWdtRUYwVHlLQ1JYKzc1OWY2amVsQ0trUEdpZkdRdFUw?=
 =?utf-8?B?R1c1MHU1NXlTTzhxcVZBWXVzV3lCaUZ3Nm45bGhxT1gzcm43OUtjS01iaTVI?=
 =?utf-8?B?b0ZCbjhIMktHOWlxY3ZtZlJIMmwraC9mWDcrTitYbENZdXdNTWFOMzI1NkxW?=
 =?utf-8?B?WDVoY25yMDZ1alc3R2g3clh5bHFCM0xvV0tvdHd4U3ZkK1J4QWlwdmZlNEpu?=
 =?utf-8?B?Nm9KRGozd0p6WWVrNUcwSnhvM2ZidlhtODdzN1IwOThGeG85SlpXdUplSVZC?=
 =?utf-8?B?QXYxTksyNmIvVSt4L0R3MlNFUE1RT2EwRk1QOGhWa2k3eENIbWE2eXZDbUNX?=
 =?utf-8?B?ZHB2RjByNEJPUlg1dTNURVVzeHhqVVpRSmRHUUVVMmtmUlE4TnJMbUovWjNQ?=
 =?utf-8?B?ZDlKMUxWRUR4TUhNc2Q4STFjelRvYnFtaVZtUG1nYk9MTndPZHpsUEpxaDE0?=
 =?utf-8?B?UVNQS0Q5TldadW04N3NHZzNkYStaREtkKzRDZktsS2tBY09YWUcrRVlKc0Y2?=
 =?utf-8?B?NGpSZitxSWEvcnJmbERiK3MxVDlUdGUwZmN2a0JQREY2RmRxQjlPaEsveS9B?=
 =?utf-8?B?YUdzb080cSt3SFBXWjlwQVBVZ1JVRm43SFBWelZzeVNOUHBTOE1NS3BzVUNa?=
 =?utf-8?B?aGtBaVgreVY2b2Y4Y1NucDI2ZmpnZUxpUDJybFcySDVrZW5lM1dCemJucXVt?=
 =?utf-8?B?YThZVlVZc0NEbEZHbHN0cVBZUkduYy9SY29EcnlLeTdxR04xb256UjJMUDF6?=
 =?utf-8?B?UmZaWmEwd1JTdk1vODRlSUdOeFYwNXFQYmhSbVNEYmpGNHdoUVRuZG42SnEr?=
 =?utf-8?B?M2lsU29SbDVscEg4QnBTc1RjeWx2TnVlekV5N05HdzN3WW9BTnlDd2ZuQy9u?=
 =?utf-8?B?ZXlvNmxsSXJTOEx1eEVqcGtxb1JlQUtHejRhdkxwMnNQZnExSmZESHJNOWNz?=
 =?utf-8?B?MzlwM2MzdVhGSkpKL0ptYnlaVzNuVFpmdXhzNVZtMmpBR0tkV1AzR29kaDFZ?=
 =?utf-8?B?N1dLYzQ4bFJNNEpKeWFJajZZK2J1ZzdSVzdiMVIwQnpTRXlFM0tqWUVrMFpS?=
 =?utf-8?B?SDI5ZXd2YWJ2THZGUUwzN3R5UHdyMEZ4dUFsZGNVaWRuR1JUaC8vTG9WMWJ4?=
 =?utf-8?B?clphQ2NZZllZcGltVTBtUUNBTGR2WkJsd0ZobW5MU250YURLWGIrdmYrWlRt?=
 =?utf-8?B?MGRiY3BBaVRTTVpMU1UybXp6YXBRSXFpTFloR3hHNkFBakRSNFFUSG5IcTZX?=
 =?utf-8?B?dUVmMjJ6WVBtR2dzRk1kZXdhT1pBVTRIS0VocDU1Kzk3NGNpSFdMVno3eExm?=
 =?utf-8?B?UjJkZHprRVBWVFBjV2RJRTRYK0RqMGRJMWR4QzFWejRwaERoNko0RzZheE0z?=
 =?utf-8?B?d0J6WlBGS0dKS29UUDJyeWcxYXJmcWhNN1pJc0MxUGpTUlY2Z3EwZmpFUSs2?=
 =?utf-8?B?SE93NXBkRG0xelZVSGxyQlB2UVRxUUtHdGd1NWI1VDZFQUloNWJXQ05vUjR4?=
 =?utf-8?B?OXo3TjJxa2lYS25uZ2xzeW9mTzJnT0graFdPMEJBMmxjMm5HNlBjcitJU1VS?=
 =?utf-8?Q?HkcRPO/nYlsDIZsVX/?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d38e4d1-7a3c-469a-ef91-08df4b1f035e
X-MS-Exchange-CrossTenant-AuthSource: LY0PR12MB325698.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2026 18:07:48.3226
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aXqh1H/1Ozw5AyCJv+XzpwN6BdNUX6W7cTFOXmdBu5b5NItfhxzCTc4tvhkECPCw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5815

> [ ... 28 lines skipped ... ]
> @@ -1238,6 +1238,14 @@ static int iommu_create_device_direct_mappings(struct iommu_domain *domain,
>  	unsigned long pg_size;
>  	int ret = 0;
>  
> +	/*
> +	 * The direct-map reserved regions are still fine because the T=0 stream
> +	 * always goes to an identity mapping. Skip them: recording the request
> +	 * would only refuse the device its blocking domain.
> +	 */
> +	if (iommu_using_t0_stream(dev))
> +		return 0;
> +

Not sure about this. If we are allocating a paging domain then it
should always have the direct mappings setup in it.

I think this patch is the right idea, but it should probably be
removed from this series for now if we don't need it to make a basic
trusted vIOMMU work.

After Leon's trust level series we should have the flow I mentioned
before where the iommu starts out in BLOCKED naturally and we will
allocate the paging domain right at driver binding.

With that infrastructure you can make a decision to just not alloc the
paging domain if the device is not in T=1 mode.

>  	pg_size = domain->pgsize_bitmap ? 1UL << __ffs(domain->pgsize_bitmap) : 0;
>  
>  	if (WARN_ON_ONCE(iommu_is_dma_domain(domain) && !pg_size))
> @@ -1790,11 +1798,22 @@ __iommu_group_alloc_default_domain(struct iommu_group *group, int req_type)
>  static struct iommu_domain *
>  iommu_group_alloc_default_domain(struct iommu_group *group, int req_type)
>  {
> -	const struct iommu_ops *ops = dev_iommu_ops(iommu_group_first_dev(group));
> +	struct device *first = iommu_group_first_dev(group);
> +	const struct iommu_ops *ops = dev_iommu_ops(first);
>  	struct iommu_domain *dom;
>  
>  	lockdep_assert_held(&group->mutex);
>  
> +	/*
> +	 * When in T=0 mode the T=1 vIOMMU must always be set to BLOCKED to
> +	 * release control of ATS.
> +	 */
> +	if (iommu_using_t0_stream(first)) {
> +		if (!ops->blocked_domain)
> +			return ERR_PTR(-EINVAL);
> +		return ops->blocked_domain;
> +	}

I think the general invariant we will eventually have is the TDISP
state can't be changed without the trust level being disabled and then
this logic will just be 'if the trust level is disabled then set blocking'

> +
>  	/*
>  	 * Allow legacy drivers to specify the domain that will be the default
>  	 * domain. This should always be either an IDENTITY/BLOCKED/PLATFORM
> @@ -2399,6 +2418,10 @@ static int __iommu_attach_group(struct iommu_domain *domain,
>  	    !domain_iommu_ops_compatible(dev_iommu_ops(dev), domain))
>  		return -EINVAL;
>  
> +	/* A domain cannot be attached while using the T=0 stream. */
> +	if (iommu_using_t0_stream(dev))
> +		return -EINVAL;

We do need some way to block vfio though..

> [ ... 17 lines skipped ... ]
> @@ -3690,6 +3719,12 @@ int iommu_attach_device_pasid(struct iommu_domain *domain,
>  		goto out_unlock;
>  	}
>  
> +	/* PASID cannot be used on the T=0 stream. */
> +	if (iommu_using_t0_stream(dev)) {
> +		ret = -EINVAL;
> +		goto out_unlock;
> +	}

And this PASID related makes sense at this point, again with clearer
function naming

> [ ... 30 lines skipped ... ]
> @@ -4294,8 +4341,9 @@ int iommu_dma_prepare_msi(struct msi_desc *desc, phys_addr_t msi_addr)
>  		return ret;
>  
>  	mutex_lock(&group->mutex);
> -	/* An IDENTITY domain must pass through */
> -	if (group->domain && group->domain->type != IOMMU_DOMAIN_IDENTITY) {
> +	/* An IDENTITY domain or a T=0 device must pass through */
> +	if (group->domain && group->domain->type != IOMMU_DOMAIN_IDENTITY &&
> +	    !iommu_using_t0_stream(dev)) {
>  		switch (group->domain->cookie_type) {
>  		case IOMMU_COOKIE_DMA_MSI:
>  		case IOMMU_COOKIE_DMA_IOVA:

Hmm. At the moment we expect that MSI is always using T=0, so this
would be more like '!iommu->confidential' I guess since T=0 will
always use bypass. It doesn't matter at all though since existing VMMs
ignore the address selected here :\

-- 
Jason
