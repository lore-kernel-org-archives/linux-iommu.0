Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010053.outbound.protection.outlook.com [52.101.56.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA15437C930
	for <iommu@lists.linux.dev>; Tue, 25 Aug 2026 16:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787675787; cv=fail; b=E4DXAA8DL+M6EwiljduIq+BRYcXFdjMPzPy6Hoyk2QDUMdsn4hRlN3qREpmrlBgPuIRFmQkkzdyjXXN/P/lmPB7XnwbAyPXAqqL1Wm/JiEC7Z+hK1kIxipb28m5MFDf2VjbaP5NJYK55oPd9w0baZbUCU+4gYKVOtdaZRq46l4Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787675787; c=relaxed/simple;
	bh=LV37JHpWOsXcZR0/teabS+/HDmOoTWqJx3lcY8Uatb4=;
	h=Content-Type:Subject:From:To:Cc:In-Reply-To:References:Date:
	 Message-Id:MIME-Version; b=Tkgn1DhgMQvfLW5f83HD++FM9Ye+OttJgX0Z6iQwbv5IWXS800Oz5LkPS06YnpqEMY28EZMrJ9OLpRAo3xr7Ma1ru4KEZkNKQGIO6GGlF1d1F4jEK0yC8n//1qrF3Rz+ddQ6NnZZZJSv312kjiJsgqfzFyuRbS9Tr2ZEk0Mh6Jo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RVo7aTyy; arc=fail smtp.client-ip=52.101.56.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RVo7aTyy"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CZixhgor+IZ6km5bAbO3mGFGolfAcRSl/Ro3JC1iEOWHwSOGzCLxlM/sRzDYC7LKfBjVbpqCV5FC2IaxhP3uvc1SDyqn/4OvccUqTbAyu2+shaoiEm+WVdEBMxrug3oRlLVX6Q6Htmd6r9ONw6dt7M6tNHh8fcOns3Jnu89NjPeOgMX0eNQC7ZQ+JSDIond+GtE/rI5rA2vNYKZgs+rrhgT97HoxGdS1l+kO/AQFCzpnNf9ur/jHQ00xvDYBmHefX0s7nHUYisieHuDM1suRvd8dWUdKUkjFNTfLPM+MMpUcKoC+j+RqDb6Yzv6Tel6pbp/qRDibKU2jG4Fcd76RdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l9VR/qkpVVp/XoGBSrmyb5oXoyhUkdUPLJ7zppeYeIM=;
 b=vAxhB4eUt01H6cWX07bfmD2aCMIHp//JmU+sJ9hTIY1HrKH7Ra16DlSTLYAnYRW9EZ9GOIxZNx9mYYdOLfkTP64i38tIBT7MV7j9V3Iu26U6GWT46xy4lgfan+m78Nej8Ak5cVXwnTDM51mn2NcbkOJ2wJVCEs98UZPQRH7p7q2TklRGlb6xa16FBSbKeaSnRgeNuH6OfGNkw8hl5IlmDMaRGglt5ayAiOSvak0qwrt81DgpnVQB7tgouac4nUe04I2SvMv270AeJrxU/k7X4GKO+UzC2L4+XyBvFqKy7n2Iybi0yYF3smvePTwHjRINpigi6WSxjFJGlwbwIz0Kyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l9VR/qkpVVp/XoGBSrmyb5oXoyhUkdUPLJ7zppeYeIM=;
 b=RVo7aTyyeNu4UGFXVjhT1Q6lCnomcoLmXxZXt1c8L+hKrNnDQ417KuOQXXv7PK15ojymXcg86sAy2wRaXE7SlazBoaVTQVVkhA1QuDYCbMTIG3C7dJ4ZfkR+OxUL+3D6+SqW78tHi3oQRsCrxhKydmRdHCjtQ3UaDl9zm0+gXtfMweUU0OufqxaXj29rMYCZWIaw2jT5nPrQrafSUITIAdxs0JlVO/FbXWq/ICooG32PWYxGg9QxUvakLg+fa4naFod1x1C/XkKVNbt26V+9FeFRAozbRxRsnfobTZQOKqDwHRayogEdEV31TLRdYd0ADvmzFD/N3cJypX7SdQQHqA==
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
Subject: Re: [PATCH v9 02/12] iommu/arm-smmu-v3: Add a helper to drain cmd
 queues
From: Jason Gunthorpe <jgg@nvidia.com>
To: Pranjal Shrivastava <praan@google.com>
Cc: iommu@lists.linux.dev, Will Deacon <will@kernel.org>, 
 Joerg Roedel <joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>, 
 Jason Gunthorpe <jgg@ziepe.ca>, Mostafa Saleh <smostafa@google.com>, 
 Nicolin Chen <nicolinc@nvidia.com>, Daniel Mentz <danielmentz@google.com>, 
 linux-arm-kernel@lists.infradead.org
In-Reply-To: <20260728210928.1050849-3-praan@google.com>
References: <20260728210928.1050849-1-praan@google.com>
 <20260728210928.1050849-3-praan@google.com>
Date: Tue, 25 Aug 2026 13:36:11 -0300
Message-Id: <178767577112.3356902.15184998673790345568.b4-review@b4>
X-Mailer: b4 0.17-dev
X-ClientProxiedBy: YT4PR01CA0394.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:108::23) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|IA1PR12MB9466:EE_
X-MS-Office365-Filtering-Correlation-Id: cd9fe694-1109-4224-d9ff-08df02c6fbe6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|23010399003|10067099003|4143699003|56012099006|11063799006|3023799007|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	CAncW3km4Q25f5TUtbZk714iGCuYhOCWAoLcs2GiyYAuw16pmv+/l5TCp7HQeHyEIiwhjvhJa6/eNzTNfBQ5GYammzMzA1GITGDBJlQ/O3ItM62TehpIW1vWihISTLPOYVewrRKK8P7m4ZeBrZFSBPdmDcrxywx7Z7/WT2j60Wv77ngll8ptNVF0eM4CTP+BDMPSvdiddbhWZ5bZqaCemXOROSjy4cDoOJp8huxDrKertDI9VDqQ81PLFHxZbUyzOaG1geod2nXABm/L3Kq6XPjvDsWbuO9lAIs/yDoghEzge02+uqX/wMztu4U8fDZwRKYbbb5o3PNy8PBrzyPSpotAJHfH+ljXKYnqCzVyoafKldHCUCV4b4pvZ6Eex2MVdl95TFyjzSZv3bJp4XORoA/l2am9Lx8UzCrfiCwO4UnG9pNblEx0UMIIAvH5l1/2AnijW6c4v55z0adnOI6WRqcggNeYU9yUNlw48of37wr8xKNNBJsw+7e/MPfQqKS2F183GNiVC2tRAZFM/1nwTIFeV06cc5BlixP+zHhXBgPuuP7dVa6SEOypsVcQU0P2hMSN9DlWajefif8bgbLnHzabgQigQoU7xIu/uLHco2eCU6napBfoP5khhSu232K8OleR9tvVOuFI1YpHU1qrOYaT/USh/3jfW1LWriAmzrU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(10067099003)(4143699003)(56012099006)(11063799006)(3023799007)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SEpDb3FNSDhKV0JlMm9ISEdzU0J5TFJ3cldRWXVZRCtkMVliejM4dVR0ZDcy?=
 =?utf-8?B?d3kxc0F1M1UrUHprQVZzNXBaTU1UWDFVVktZOGtDTFNVNmRMMTU1QWJZYUQ4?=
 =?utf-8?B?YUlzdkc5bnB6L3dQaVgyRjMvajE3REl2ZGJqZkEwbkdVSjlETFhKemhmVDJu?=
 =?utf-8?B?eXdWQlVBdVhXY2VyZkVxVWkwbFZsWjdLSWYzNVhidUVjVTM1R3pWSVo3UUhv?=
 =?utf-8?B?czZYQXZtTHprTWJ6c1BIVWpHVnVSRXJibDZaTklGRTd5cjZoNGxETll0OXRX?=
 =?utf-8?B?S2JyQkI5dzZuRkpOYndZYzZPd3pyM1VhYnZPbStnb3lEL1NNeUVBdFBQeDV0?=
 =?utf-8?B?YXdsQmpSRWVmUU9rYktJQmxsdDZUWlpsTE13UGR2dmZYMWppVkxxSkZyNm5j?=
 =?utf-8?B?NXNESnNGTEYxQlNBMUJwUFhBd1BXM2t6cFh4VDdRcEdtNUhhM2Zib2ZJenlQ?=
 =?utf-8?B?ZGhNVGozekVJZW5tMmdsMm9hLzJaNFRSUlJrd0U0bHRyMTRJdDJiWTNQZWhi?=
 =?utf-8?B?d3BkYVRYTmVUNU9BbFdkUWpJYURmT1EwV3ZuZHYxb2NYYktQcTN4eUVoZFc1?=
 =?utf-8?B?dlJyRWptaTdSQXFORkd5SmR0Um93ZjU3OGVsaXpoZTRLdm00dmRCMitSWGNp?=
 =?utf-8?B?OGdVYjRXODY1bmF0OW1jYWhUS2NhZXVrcWs3WDV2empvenVWeHkxd1JndHUv?=
 =?utf-8?B?VnNJN242TUJnMkIwY1YrT2RzOWxZbklud3hPWndHZks5L240RVZ1QTJuNnpT?=
 =?utf-8?B?S1I2U0hnYm96bEpZWFIyTytmVDB3My9zNjhXdHE4K3FjUXIvSEJkb3dSQUtj?=
 =?utf-8?B?am5qdEkyMWQ1Wmg3cks5TXIyTjhIRTgwUTFVUWxNVnYyN3M4OUNQT3FOTHN1?=
 =?utf-8?B?amViQzRzRWxQZUpKU0xqdTVnSitOeUNlTmNBMEdGdDY5eVY2bTVhNzFXNllT?=
 =?utf-8?B?OEpRczdvMFdKSjV0QktlTUhQK1l0UmJUclBib2swNDFUWDVBamFqeEZ4QkpI?=
 =?utf-8?B?Z1NKb2s5VGdhbzVPWVRBcmRjYUdBMGp1M3FWMDNjQ0c4NXNHWVdQTzZvMTZx?=
 =?utf-8?B?YVpHYTZPUVJCSkJ1L1VDNXFhWXR6Qm11aVRrVnlpWlQzZG5mcXpKc3A4MHJt?=
 =?utf-8?B?aXRBS3BWOGtEeEtnU3Z2OVNhZEtnUlNzWnd5UUh4WGpNZmR6RDR4aTFnVzlz?=
 =?utf-8?B?clpRYVYyN3AwLzdnWFNaemlIcGM4NmZCYm1PMFRWSU9DUmdFSzF2NnR0VWE0?=
 =?utf-8?B?d0JjRzRTTFI1UVVld1VPRFB0YkpJdDdURHNwcCtYaVI0cnRkZzE5bUJvalhI?=
 =?utf-8?B?c095aSt5U1ZpWEJhZTh4TlRzaXNwZ21LSHd4UEVaNC9mRFprRVBpV0Rzb1Qz?=
 =?utf-8?B?dkFUaTU5NmM0UmozZ3duRFF1U1ZsZ0Z0cFl2aklhN2wzL1N1Z2FTT0RvTFN6?=
 =?utf-8?B?MUxnWUo1Rlc1VDB6OGEzaW9jc3k5TWF3dW5QcFMydmdBNU5EbzAxbmxTN044?=
 =?utf-8?B?a0crSE03bUErdTFjcTVyNHFMVTlNQXRrdFpmN0Z5UUJsdWZLcmJUTGlqeVM2?=
 =?utf-8?B?TThmNFloV2VLV0dVemJBaWFDdUpWenpodE1Yd3ZTK1l1TmU4TzdvRWFpR3Q0?=
 =?utf-8?B?bjBzZXgwNmFZSDhUUTN4MUpNeFpGYWlkOWlVS09kUDMxRHlVY2dsTVVkTmtV?=
 =?utf-8?B?Y2NXZHhmdWc4MXcrT0w0c1RlOGxQM0lxYnorVC9JZ1FVejFRL1RpN2NmaXdH?=
 =?utf-8?B?VFRZTHlWNzdGTUhnWGg5WEdIYkhqb3ltRDZwSVFNcUdrbnN3VnRtTE9YT25z?=
 =?utf-8?B?SkUrb3hnTXNROWZZOFMvcU52YW8yZVZNSy9xdldlUzJUcmZZOGppOUdkRHdp?=
 =?utf-8?B?QmFET29zMGtNZkczakpkSHR2bHBrUmxQUFNsNXM3RWNtRkdhTHhwVlVmTFhK?=
 =?utf-8?B?VEljOVc0OG45eE93Y0FOSEJ1MVVPc3IxK09hRnlxNkhXUmo2RlV1UzJjajJU?=
 =?utf-8?B?TjZucjRJakhoS1RVdWdoTis2OHBJemREQzQrSmNtc3dDT0xBUURKd0RtTmJ6?=
 =?utf-8?B?QkJoL2lIKzd6WjFjVURSM3liaFA5emxuMWRMSm5jTmQ5N0lzRVJOZDhMTjBV?=
 =?utf-8?B?cUpZNzlpekU5M2kvbUZHZnAxVC9NSGc1L0swMEhMamV4TDlQbXFBaDlTWDE3?=
 =?utf-8?B?WGJHZm95TFRWeWdFb3hlV0tlZ2VaSlduZ0kxYU1YY2JDODUxdXZrY0Ivbkpv?=
 =?utf-8?B?OWFsVDFlWTRmQ0JZZVBRRkFEZzgzQXdZdTNNYXJ5Nm9rVjVjSERHYXVpYzVY?=
 =?utf-8?Q?MowOD4dZz5bef7xfJx?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd9fe694-1109-4224-d9ff-08df02c6fbe6
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2026 16:36:16.5059
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fDiSm/vDHs3XAMcHrJ9L5RHlh/ILDWmSkNQpW22uM5LbUpZeCrZVau2b7poZEhBF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9466

> [ ... 36 lines skipped ... ]
> +		if (queue_empty(llq))

 [Severity: High]
 Does polling for an empty CMDQ actually guarantee that commands have completed?

 queue_empty() relies on the SMMU consumer register equaling the producer
 pointer. However, for CMD_SYNC, the SMMU advances the consumer register
 immediately upon consumption, not upon completion. Suspending the SMMU while
 commands like ATC_INV are still in-flight could abort them, leaving stale
 translations in the device ATC and causing submitters to time out.

This seems broadly wrong, but it doesn't seem explained very well,
maybe put a comment above the function something like

 The caller must have ensured that no concurrent command submission
 can happen. Thus the entry at the PROD must be a CMD_SYNC due to how
 all submitters generate commands. Waiting for PROD==CONS guarentees
 completion of the sync and all prior work and thus idle HW.

I don't think the other substantive remarks are valid.

The Werror thing is right, every patch should compile alone without
warnings. Sometimes people add __maybe_unused to accomplish this..

> [ ... 19 lines skipped ... ]
 [Severity: High]
 Does this logic miss commands routed to secondary queues?

 The driver supports routing commands, specifically ATC_INV, to secondary
 queues (like the Tegra241 CMDQV virtual queues) via get_secondary_cmdq().
 By strictly hardcoding the poll to smmu->cmdq.q, we ignore secondary queues.
 If the SMMU suspends while ATC_INV commands are processing there, they could
 be dropped.

Yes, I think the ordering is wrong, to keep them as different patches

iommu/tegra241-cmdqv: Add a helper to drain VCMDQs

Should come first, adding the op callback, then this patch would have
the hunk completing the function so the newly introduced function
works completely.

Otherwise the approach looks OK to me

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

-- 
Jason
