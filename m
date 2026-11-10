Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.195.51
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794493319;
	b=GcKcBh+iiOyq/MsKof8KlpZjueU24NKT8wOzrx9qU47uMrBpwGFXdiT5kwECJdtZLO7k
	 rYGDZTpirWhWO/gwzx9KtCbwOHrWp/ah9sGxbVanosRGaOgz7ox/es8wc59Iy/zwF6NHT
	 WGe9WN7gENhhOy4tyrmtIa1gP/QQg6WF+4wdyxV6Jow3Q9qblm0bRsEBWtNrBiJJZPlUK
	 uPjRCIpiBnCUvd2IifBf/F/5hb+YUohbtO7SOrGAl7vt14ex6py+8/Bkqp0cx0m079DrK
	 AEyB1Ah5J0+aFhL7mhmKJwXLU2oCoq4TQGffkglbYCVEOqkajWjF6GPsja3X716CUnA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794493319;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:In-Reply-To:
	 References:Subject:Message-Id:Date:Content-Type:
	 Content-Transfer-Encoding:X-Mailer:X-ClientProxiedBy:MIME-Version:
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
	bh=g/j/TNFdrEjqkuTnDLHV+KIXmFwQ0JewjQW/NR/3oBU=;
	b=C037+bwbE3khffLh8UiMZVHeIH/udbrP4PZrIqdUFNiszT7URPDRzol7+BTu2JRIqFTb
	 ZoLd1IwS9EwVnz9edYCHJjpXT7QSh3z/Ci9AlvkLMh6gAAnnwlRFD6t/fHQq9Us/oLQub
	 GmkHMcUA6LSXe8uefuTByxzugjT8V6oTRrIvXy2TbpkmqzeNOd+7LED5/Vog2qlWiJ82R
	 WQkSxhU3A/8SlTZO+ICvPs8ZlyOEIqiviChhpiQBQmZBANFwrsnb7siPjvgip+8wBemul
	 RrPoewXiMTdKXlaBnWbKVSrvVPS5BlMOSUIFFFrKm/hJz5Xg8vMSK/DbFI48BUYn4yg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=cLuJo4Ur;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.195.51
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012051.outbound.protection.outlook.com [40.93.195.51])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CDD8606A330
	for <iommu@lists.linux.dev>; Thu, 12 Nov 2026 14:21:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7CDD8606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=cLuJo4Ur
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CLfmnhcRDxKUH+zB3/iJkGunalybjeSAnJxEgUJls1eKFmcRRxEvDbTa2Kxy77Oh0D5O0gkmVCVSFOrEB5AV47+mhT4T+sDwCcQ/iBdtWRTPGp/nf1WCtcXBXbtLvehv12vE8b2JIBdulHQ/biOQXxV8wRSWAm3I5zW97MGLAShMbvBjihaoqvCCdfoBmbBN1qArwvlj4PMO5ZZjIAtsGHCGCwUWLQuMwK0eCAHsmgku6SX0PoiMqqFq0yXd8FYcAJj3wTCJ1+TQaOBEuKUmV+FriUa+8VKTAnIPxw4goO7GbUSF2KXCphDzyfGT23BqIeIULezn/i6fJ5YZR12F9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g/j/TNFdrEjqkuTnDLHV+KIXmFwQ0JewjQW/NR/3oBU=;
 b=dqpTEKqFt1EEsWUSPb3Rc47oBnBuQmAq9yQMPEtgMAYzacKzF2urwDXvNMTdrXnlEZmG9xv2gimHqSDJzW2D33JJklzPY2KtLdBeNLZu6WGrfkGPZ+XZZygO9h51LxZkHpEp6nodKd0dsnrr3/uZpnLWG45GEZmzai5wa+rKeSs42FNDjEBIgsnkcHwQZ3sdQEL3CbWEO/7nMVw7abPo3zG2cQj+INE2ZWf0PJoP2ZTeVEi8GicXxTwXAFhINbszacagWKnl+PrxlSRyu17FD8rIS6eilK+7HekFyTPgWPHyFZ8DyAFQonKKAsxkM7Ezcf9liPqnaAwvjBxnp/c0Pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g/j/TNFdrEjqkuTnDLHV+KIXmFwQ0JewjQW/NR/3oBU=;
 b=cLuJo4UrAs5+IIz5ZKjSnbyz7vWCE9SYaxE5M+Ia1giQL6rjJAalR/rUGT4vXIQFdb/3pW33wcxFJXacdoTq9aOoooNfgpYgmR6yQ0yTVJSrKXsrXVXfhA0QchGarvUq2+KYWaFiAhb5r8BBiKC4nsew4L85Kw2HRM6fjTCWe32KBU23hkBEaEDQx6bE6U60EmLKwNERKyLpekRUqIkaxuhIyVIX3dqbM6PbaiozmpdFZlxzRusq7AmMQcw6kHYUEwyvuwhdETdjvLmmKcN3SeehFWUUkhmZGuVSLUvk/taQOQUDuccykA9jYse6qgeAiqjkOtlDUD/Btw7AFx/b7g==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12) by MN2PR12MB4205.namprd12.prod.outlook.com
 (2603:10b6:208:198::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Thu, 12 Nov
 2026 14:21:55 +0000
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d]) by CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d%6]) with mapi id 15.21.0615.009; Thu, 12 Nov 2026
 14:21:55 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>, 
 Sasha Levin <sashal@kernel.org>
Cc: Shuah Khan <shuah@kernel.org>, iommu@lists.linux.dev, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20261103163910.640756-1-sashal@kernel.org>
References: <20261103163910.640756-1-sashal@kernel.org>
Subject: Re: [PATCH] iommufd/selftest: fix the unmap-all length on 32-bit
 architectures
Message-Id: <179432611487.1456949.12100993786284060593.b4-ty@b4>
Date: Tue, 10 Nov 2026 11:55:14 -0400
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-ClientProxiedBy: YT4PR01CA0363.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:fd::12) To CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12)
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
X-MS-TrafficTypeDiagnostic: CHBPR12MB731189:EE_|MN2PR12MB4205:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f0a62ab-e76a-4034-5c66-08df40c84d8d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|10067099003|11063799006|56012099006|261009223027099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	rxr2miy1Z4hGX4M5oCKQOHVzmUd5mK0QC9TGAC5JuDxDxr6y4OjZVNaD63Ltx0o2IeS+91ve0eK2xg12jkXHAmdUP6JQhYFzYeZBP8fH4z5j7sfqT1BSqmeSPhdE0j0txihcNhTw/N+9BRZC1q/hfD+43tu1n5aGiameRm6Psxlr/Kq0ImGt4yn/b3R+obb3K9FZBHHfe26wORKHVTy7BERBHwVnxNXZc2bWNT6JHPWfYKaUpC3OSGk3OcvBa+zvKMeSFnLUCOfc2XISFlp+SRTW0FUu1tG7ssic74sx93aa445t4ODSpnWPlzSoSWblDJoA5EcYEeHpynNe5zpDmqS48gPD3qq0+5OxRREBGacLBsvlwKD9e9n6W92hDQfdQXtUmSuFV5YpgpFycOaYTqfzcUD/sZFWWmfchdQ875Zk6vFEXYdonwIU9aNTqG0/9ev0NkycirbcenyfgSXe1LBstor9Zh1xH+TTJT2L4WVf4eC7WGLJunczIjcTDpwkexfVKoS0i8sQJAgcefwH3rhD2NUBgtYYs+4VW9lJ1mxcrO3GxSM1Kz1uc+xaP5dMClbV2m3iOxzJIVREnn3GlqeDfn78/GdMJqzTCZYxt/ZAkLyzx1CGo2g/jLaktKUAce7qHri3Cd3pPx7NNW2fx/9SjdAvQNDF6K+Kh/sJx/U=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CHBPR12MB731189.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(10067099003)(11063799006)(56012099006)(261009223027099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dU1QbVhYZmV3c0k0REdBZm03S0lha1Fvbkd5bWw5ZHdQYi9CcVVWQVZRTmJY?=
 =?utf-8?B?RGtHQ3AyNWZtZ1hQc2k5akZHM2twcXRweVpUOGhZRm1HYjEzSCtGak5LVnJ1?=
 =?utf-8?B?bVNHVDFiNy85TzI2UkdCbWlzUDBadzBhbk1CSVYxUWQrY3lhM2cvRGkrUkpK?=
 =?utf-8?B?Vk0vY1EvRkdTYjdVNTBjSTJhWSthZWJ2REx3WVpDWENoa0ZxNWRxMWdSM0hn?=
 =?utf-8?B?U3F5YW1pejRpODRaVE5SMlBPLy9EVHBteml6L1ZpbWFFbmRYWVhRUnkyeGxp?=
 =?utf-8?B?YXcvRVBNTDFZSG5CeEtteGRaSGJvUFJyaDZvMytGY1duYzkwTENiUHo2ME82?=
 =?utf-8?B?MS8xYWphc2lIRU1wQ2c2L2JVSGY4Qnk5WUNLSkNmL1NOWXpvc2dmN1NVL3Bi?=
 =?utf-8?B?blNFZmV3MzBEQTk4dWxmQncwTml6c2JhZmpqRVVldGx1VXJ1WmI4Qi9mdXd4?=
 =?utf-8?B?OFVRQmdkQzZmUWpqVlBYZ0tVbkhsbkJXZXJxbjNieUVxam5rcTNlYjFYTlFz?=
 =?utf-8?B?SEkzMk1iZVZ4aDZNeUFiYnpsZkExOXJIR0ptdnA4ZjErdXlnZmNDa0dDZ3Jm?=
 =?utf-8?B?VG5UaXQ1RlZVK2dJeFFwSlh4WWgrZlpCUGRXWXhqN3FrNmZBNy9nUnpQL2sx?=
 =?utf-8?B?MlpqdDVERU1ZSGJvNElXR3JIazlMZGpuR2JES1duM21DcGRpNWdoSVdoTGl2?=
 =?utf-8?B?NzVKb1BYenFoeXhzQ2JmVHRQQVJyM2psRVFtWXB2VittYk0xaDh5SFdwbDUw?=
 =?utf-8?B?bmRoUTYrOGpEeURRQXRCQXdWK1RVMkRhZDZsd25MZ056QlNKVkhrbHRvZkNG?=
 =?utf-8?B?ekRoZ3M4ODM0Ry9jWEwrRFYvelByczdlaVZ2MlU4TUpVaThVU1d1eXNWaWVM?=
 =?utf-8?B?bFlNamJvckhyUGhiWUNXSjlsK2hQNVVOKzhzeWEybUtwTmk3ZU9Ea0VDeG9N?=
 =?utf-8?B?QjNQK2pEb0FiakJxTnZ1eEdWWWRwTURjSVF0MkRpR1Rmb1BObDQ4REZLNUJJ?=
 =?utf-8?B?TXpzZ240LzZqRFAwQ3hFVlJ5RmFwaFQyMXlQaXhBVURwaW80YmczcGE5bS9U?=
 =?utf-8?B?VktWaXAzMGUrbTdQbzhXSklIYXdiRVZ0VWlGV21Zb3lCL3JuU0tzSEdXVnNR?=
 =?utf-8?B?UXRLU3kzbDN6VjQzUE5LdHQ4YU9MZkwwS2NCMzZrVUt2azcrU0FhN25neFpx?=
 =?utf-8?B?Rlh5MzFVVEtpZ3VlaTYwMmtkS2tlemxIemd5SXVYTGFOdC95bWlRTkV1blpQ?=
 =?utf-8?B?R2ZpZDR3SGF0ZG5DNnJCcWZ5ZW5GNVhPaFVpclVPZ09ZT3BjQ2c4bkUweFoy?=
 =?utf-8?B?RGNGT05YQzJ1enZZMC9NVm9RRFA0ME9DcEJIZ0ljL2EwYTJqdm9IUC9vTktF?=
 =?utf-8?B?TlRMZGlOclhmOGZWTjVtVld0WnBrRUk2NHZWVGNialVBRGtLdnVFaDVTT3dz?=
 =?utf-8?B?bEpQdWlZVkVSZHlZRzZqUno0L2tjaDBjd29tc3d0bDRTS084a1hkcWF5SXFM?=
 =?utf-8?B?SFZDNitkbmx4SzNyTmFWRzdoZFh4amtGL0pKMHhqaXdoUWdrL3JTSEZTL3Nk?=
 =?utf-8?B?L0ZSVHlCczh2Vk5HREhJc3lLL3phOVJwZkZMQVg3WWRrOUtHVUVVSjk2SXBO?=
 =?utf-8?B?dTJoSTAySDNlaXRRMkQzTWdQbGZnT0RjaTZVR0dnajloV1h1WUxCU3JQcXpJ?=
 =?utf-8?B?Wnp1K3hUa2RPRERad3BDVnozZFJMWXRCdmU1K2ZjeTE0K2xSekViU29GWitt?=
 =?utf-8?B?bFpEaG1xT1hmNnlHSVMvcWZNem1mWDY1SnVCdlBqa1VyTDhrYW1MTytwQ2pW?=
 =?utf-8?B?OWU2MlY2bUd0YzMwTloyWUEzaFh6RFd5cXo1Q3ROdXRjUHIxTVBCSlFRdHd4?=
 =?utf-8?B?WWoxTnk4Y2xBd1c4MXpySkFENTRwMHJXc0piMjVpZ09IRHRlRVYyRWp0YVJk?=
 =?utf-8?B?MU9CdFdPZUlXTE1KUGVDV1BlY2d1TWdlSUFjVWZDbGdFdjVKOTRkZEdBOEVN?=
 =?utf-8?B?UXJTTzRSb1V1T0tueUNrTkFyY3lGbUZpMEZaNHJmSVEvYW5MQldqNEk4TGhS?=
 =?utf-8?B?N3ZTeEcrek10aGtxMW5XT2NTNHEzOThxWlM4OGUwWVRDZ2RCeVN2UUZFZGZ5?=
 =?utf-8?B?WXJxQjVIRytFbkJhT2Q4aU9PZkV4K0lTcXZnZDRjOGRiWVhBQ1hJWEJxb3hR?=
 =?utf-8?B?UHFpR1RQTG5Nb2NwZUlZL3JNbk5abDNHcm40MnNYckVBVzhlUTdjeHBiTDRo?=
 =?utf-8?B?amFaV1A0cXNsdDgxSFJvNVo2Z3pncDlaWm1INFFDV2dNL0o4MmtvSGRHSHBP?=
 =?utf-8?Q?BKVfmxbL6KOio5Gw7I?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f0a62ab-e76a-4034-5c66-08df40c84d8d
X-MS-Exchange-CrossTenant-AuthSource: CHBPR12MB731189.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2026 14:21:55.1402
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wBO2+C9PUlmgbLQe9tpRWSt37YGYM/2sS4kmylMaDL9Rn94gRsiJaBwA4vPs8uo8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4205


On Tue, 03 Nov 2026 11:39:10 -0500, Sasha Levin wrote:
> iommufd/selftest: fix the unmap-all length on 32-bit architectures

Applied, thanks!

[1/1] iommufd/selftest: fix the unmap-all length on 32-bit architectures
      https://git.kernel.org/pub/scm/linux/kernel/git/jgg/iommufd.git/commit/?id=e6c489f40f10cc80b9baee3e6b59682bd26f3c60

Best regards,
-- 
Jason

