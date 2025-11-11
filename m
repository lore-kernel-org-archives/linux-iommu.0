Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010032.outbound.protection.outlook.com [40.93.198.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B02D82777F9
	for <iommu@lists.linux.dev>; Tue, 11 Nov 2025 04:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762836286; cv=fail; b=G+KNCpCDXyyUYsYMdnsgo/rI5mhIaOy4gRQ8Ugvpo5m9FNnmLzjI0vDjPtKOk/sOYrstxMbhtZKRikrwXPWnRKUcOqJqNWCGBFrBF5GD/0eGfzjfmihkAXvW6zPPU69u36Su9weznpojhw8MtE5HF8T5gROUdSGiW82Y9zy1qtw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762836286; c=relaxed/simple;
	bh=PP6vV5cSH0KX0YkLInM+VHJHGQ5riSlZoXLiYodHmRQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WjPuSxiFayatHIv5Ho41v7506EA+8KvJv7WBUzEsK+qCym1vd1e4DboBEzo7JO51RuFFlgu0zOuy2iLk0L7wYrczyjsX6qOEEo9MqYVrBBXPk5qjCgqu6C0G1MSWTBzCoWvgx5bre+f8tZTAuEC1/4ZBnhSx3qgq5wsM5/CzBUw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=2pQi5glx; arc=fail smtp.client-ip=40.93.198.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2pQi5glx"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dKClcDIikAdPuwG2GtyWGyeFQYQHya57fuRKSHe6uZrNW/o85Dpv4TbZ+Vgf04aWQHYTsgEQpmOZm6Qdp6TgSEEHf6bn9EJmWlaExzWBtkUf4vHZt8FE4QSS6NagfOwSXQ9vR4hcf2E/ZN4LqJsu2XD/eyQJC9I0CkLruGBfqa7Rgvb5UNtTQ2Tb7F19aCCdkP+KUr2nn/rK34EEAZuMG+gchfigZIN6J74hnDm/bvYnenuhY4K33rlYiBXLXXUdJ1DoL9jZEbY0jtxfm0eBGB7qzYzUHDyiUTZVLU3LK5tLhSOhLMsZoMZ6Bkw7seb0W/L7itymiLtkwL8/0QhryQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+AfuL9fvXKTR+k8kXEU/Im2TxI277k0EFYXEMAk3Daw=;
 b=qdIsMj1X81jQrEIxad3nHtSRtua1qj37HkWy0YMtEUIHMrn+6ecozpX42HrvRiaCy5oARRgzVwrLs6lJ8CpsBaG4VVASgJEotDyhU7DdaB/0deAycL+pmta5qYsdcYAiCLan/N1P7UPDeI5HBA+XDbiC0GJE2MVbQqYgmr9l5xdDVi833qxFG2CpCBw52L9vTYD8utwggn+eL6UyeIQ5AzB/ny8/a0hLmKkLbtQWRQ5mo/MtS/JdAJKWn4TdB6LmIL1/9CxwipP2FPBglDqOG7cQE1Vz8XmC0+l76vEuws6VFVtqdUVDyaRiH2kYs7MV0wmJfliP17V7YnVeQTYTsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+AfuL9fvXKTR+k8kXEU/Im2TxI277k0EFYXEMAk3Daw=;
 b=2pQi5glxINRNmv+zjNr1Ttm+XM6f20KEvWmMmUvl3OUoFDHBEXVkXLW0dkk4moWtWe5k9Nfq+WUmzJUCTnEMeb6jsQwo1tGZeowWRsh2Q1J9CfkuPJBzUQXXcTqbl118D8HZM6JfX48+JS8PG3OqOaMYErEV1e4NOzfMAM2ws68=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB6043.namprd12.prod.outlook.com (2603:10b6:208:3d5::20)
 by DS7PR12MB6286.namprd12.prod.outlook.com (2603:10b6:8:95::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Tue, 11 Nov
 2025 04:44:40 +0000
Received: from IA1PR12MB6043.namprd12.prod.outlook.com
 ([fe80::eff4:a43b:62f9:acaa]) by IA1PR12MB6043.namprd12.prod.outlook.com
 ([fe80::eff4:a43b:62f9:acaa%3]) with mapi id 15.20.9298.015; Tue, 11 Nov 2025
 04:44:40 +0000
Message-ID: <17ac6394-78fb-4d8e-857d-9dd5829ac8b4@amd.com>
Date: Tue, 11 Nov 2025 10:14:32 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] iommu/amd: Add IOMMU_PROT_IE flag for memory
 encryption
To: Wei Wang <wei.w.wang@hotmail.com>, "alex@shazbot.org" <alex@shazbot.org>,
 "jgg@nvidia.com" <jgg@nvidia.com>,
 "suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
 "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
 "joro@8bytes.org" <joro@8bytes.org>
Cc: "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>
References: <SI2PR01MB439373CA7A023D8EC4C42040DCC7A@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
 <SI2PR01MB439351F0B7E54513710BBD3DDCC7A@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
 <e6b877d7-91c9-4db7-9c4f-bcf4608e17df@amd.com>
 <SEZPR01MB4399DEBB3B5DA122E075899DDCCFA@SEZPR01MB4399.apcprd01.prod.exchangelabs.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <SEZPR01MB4399DEBB3B5DA122E075899DDCCFA@SEZPR01MB4399.apcprd01.prod.exchangelabs.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA0PR01CA0061.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ac::18) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6043:EE_|DS7PR12MB6286:EE_
X-MS-Office365-Filtering-Correlation-Id: eb94a91a-50e7-4800-2052-08de20dd0627
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?S0hwUGt3Njg4TXFxbkxpVlhZb3BlWGVnK2hnTlpOalEvRmRhZG8wQmt6QU9k?=
 =?utf-8?B?ZCtvenpxOGdxajlIay9nRUpwdVdDVjU5cHpXUktqNTIwWEQ1NEgzOFN0dnRt?=
 =?utf-8?B?TVowcWQrMllQSDNVYkJqcGhBRXREVThCVklDRkVJVTZuU0RDTURPVEJkcFRh?=
 =?utf-8?B?NjRydXdyUjFJTjVUeWRGRUNSbHAwR1paVEd2Wmx1ZDR1ZEJpYldTWnYzL1A1?=
 =?utf-8?B?Sjk0b3U0UGJFMm96UDNkOUFOU0o3bUZIeGErZXBFRG5jOEovTXBYM3JGYU5G?=
 =?utf-8?B?cExoYmo5LzdmWGlpMDdDV3dLd0dBbDAzVjNsUFZIUDVjZHRlSTU2MlI4a05q?=
 =?utf-8?B?eTc2TU1BR0wxQS9zSUpzNUk4a2VTL2xMN2M4RFd5VDZFTlNYNWdSVGFsdHJL?=
 =?utf-8?B?Y0tZTXFLc0Q5VDVrbDJWaTNDc3hpb2hXckx4dVlDcGdZN0lqdWt5L2lWNzlH?=
 =?utf-8?B?S1RSZ3M1Y2dpN2x6dnhXWCtMenRMRXcwalJHNjJRSXROMVZodWFDYXY2b0FV?=
 =?utf-8?B?a3htNHduU2Z3Ly92WWF0YlRjMXFNYVdCN0VZS1M0ZzhMM1BWdHFadGVOdmRZ?=
 =?utf-8?B?TGVKbEtjT2haSk02a2NQZFgybUhFWjVyMnVaY2l3WXV1MlYzd1R2Y1BOMUsw?=
 =?utf-8?B?VE1tU1drN2pZc0xCRExQSGlVemxlNGtvT1lnTnhGYjJrSlhpV2pzanIwTGty?=
 =?utf-8?B?VnhDQ3dNK1VyUWRvU2J2eEFJR1AwNHpjZDRMODcvMnNKUFNaN1pzM04veGo4?=
 =?utf-8?B?VGVZOGFjOVNIS1I3WE1scVRPV0dKbDRWalJNQlpkNnFXWHNhdzZMS2c4S2RD?=
 =?utf-8?B?RGZyOTJVOWRTMWFvRTh5TVVvbmNhNWo4cmZYZkNXY3dsZzBIaHZEUExueStX?=
 =?utf-8?B?L3Q4dndNc3hzVmJCRkhkWXhmTDUxamw0azRiSFE2MEsxbDJvVXFFZ1JzTEFT?=
 =?utf-8?B?MWN0MWxUNEJ3YU5FYVlveDJtakk0UE1TM1ZXenE3ejhjYUdHeU42TTZpOWpT?=
 =?utf-8?B?cmRkOWdldjlvbmlLdFFFOXA0b2pEMjR4OWRzWGs4S2ptc0d2b082NWZaTG9Q?=
 =?utf-8?B?TGJkcW5DcjVsVnZ4WDgwYkZueU9jVnlZaHh2WVZIK3ZaVkx1Z3FZelRJMnov?=
 =?utf-8?B?K3d2NXBsVCtDcUQ4QURFZ3J3aDlrZlMrcHpZUGd1SzR1ZE1UdG8zVGM1Q0FP?=
 =?utf-8?B?aWRRLy9KU2FTaEZOTWhGdHpoRkF3dGhKNVFSVVpseklEOUJLTGtCbC9Za2da?=
 =?utf-8?B?ZnVhMDFyU3FUcHlHNVdlMDR2bnZHUXhlSnBKdjJ0UjcvRW94ZU5qNHFHMGZM?=
 =?utf-8?B?U2tNNmlPUTNodjdja2VOVFFJZStsSWVRTHZicTBpNjhoWG1hRGxSTU96cCtY?=
 =?utf-8?B?aG9qcDJCcy9OVmQ2OGxXS0o5YlY1Y3ZXUENSL0RXT0FrKzFXU252YlNSTzRT?=
 =?utf-8?B?b2FmWWlyV2ZsdGRGR0dyL1o0UWRFQkEyNzZPSUpoYWU2djYxYnlsaWVVV1JB?=
 =?utf-8?B?TVhaQ2VIVjVYUm5zYzRKL3RmM0t5dmFnVkYyZFN3ZHhEVlVHdGxQalN3UWJy?=
 =?utf-8?B?TFBJWTk4MkZmUHNRZThrMzlrOEs3V2V6RTRCM2tjWFo0NTE0MysreWV5TjV4?=
 =?utf-8?B?cVMyMUJTdDVJUHJ2b0RUOEdFaUZqRHpvUStsR1IvV3dtOTltUVVOMGpSTmN5?=
 =?utf-8?B?NUgvNDhWb3pVTmJBK2NaL1pyaldPT25sclUzdVFDckRjazE0RE1vam1IS2d2?=
 =?utf-8?B?dnRwdDNmTG0xc0QxYkN4L3YrQndxaGZ6M3MyRHV0SzFUOGNpL0txcFVZTzZO?=
 =?utf-8?B?Zkp2STQ3d1I2Y3Q3RzdVS1FUYmt1LzdhZ05IbE1naUhQVTVsTldKSFpWbGc1?=
 =?utf-8?B?dEQwcHdGUEJueXRLdXdrbzc1Skd3RlRQeTduRjN6emZ1azA5R28zVnYzTmpE?=
 =?utf-8?Q?oU68s25EBgOGHFJ+U08PYq5cZqe6K6na?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB6043.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MFQzcTgva3VXN0loc0U0T2kzRVZWSGRPUW9TT0UxUVBLRlZlbHppeUlsZVV2?=
 =?utf-8?B?Z1laUE5lUGxIdUtVYXdjM1AvRHJXUzJtblVRZ01QVktNQW84VXNJZjUvTm5O?=
 =?utf-8?B?RGlhSkhaV2ljU0dDMnpzNUxsbWZZR2NqZFVXWDlBNHIzazhndzByTDdxV2F0?=
 =?utf-8?B?SDFlYWExSG1KcUVRbFVtS2hUcXFpRk1WL3pUZXh1d2E0WVJEZmMxcTc4WFF0?=
 =?utf-8?B?Rk12UG95TER3R2dKdk0rU0tCbUM2cHlFWTRMWEtDMnFxdmh1WXp0N2ppdWFN?=
 =?utf-8?B?MjlpNytIWlJLM1lGUC9vMFRremZHbDM3aGNXd0txK1hlemZVWFppTEtDanZM?=
 =?utf-8?B?dWtpbGtJUzhqc0orRDJuaEJSMjM1OUpYOUNlM1NENjRwVU1UOUM1TS9IMXFu?=
 =?utf-8?B?Y3pDcFIyWnpIaXB4T3JKSEZkdG1kVmZURmZLbWM0UFh6aUk0YXoyVlY0ZEFC?=
 =?utf-8?B?YzlubWJmcGxWZFB3WHN1UUZyaWcvK0h0L0U3MWRINHhkUGJyTHRodFJwK3lp?=
 =?utf-8?B?c2FaMUlnQnhZZ1VraDM0bFFyeGlFbEg5cjJnK2E3TExhVmxJbytqZHBaRjA3?=
 =?utf-8?B?MnRWVHI2WXEyYXA2UWt6K0pwL2oyT3E4bUJkbjBUSnNGM3ZHOFU3R2F0MDZa?=
 =?utf-8?B?NlViSHN5STMvcTZ3Q0thaDdFUjZVZ3JHK0l3ZmNuNHVZVm5kY05XV3ZNSllD?=
 =?utf-8?B?VW9JYW9LU1l1Ym1JQVRVNUZUYWlLbGFhV2tKMnA4VGJkbE4xd3JDczZIQnV4?=
 =?utf-8?B?ZTlZVHBQUEhuTVBFQUlsK2Q4ekZjV0ZJSzVSSGhhVFVlQ2JDV0o3K0ltblFj?=
 =?utf-8?B?RDh6STBVd0xWejhyZm1OSlJhNGd3MGhKRnRzZHIrb1llYXlPT2hqZzZuZXJ1?=
 =?utf-8?B?eHJLRnJEWWhsUWVGb0F6Tm9WWDNUSFhNZTM2a1lNNXJZcVUxT1hJTldmOXZR?=
 =?utf-8?B?bUprT1RxUHYvbFdxOTN0K0xoU3kxK3N6UnZOSWthMHhaZDB0MW1BQzFxanZI?=
 =?utf-8?B?dzV0cW84NS8raVkzUy9EYU0wbWp3R2lrSFhQWDZ4RTEzYTBrTGpmL0Z4R2NB?=
 =?utf-8?B?M3lzODJWNzNRWTVZTGtlSEM3bnlrZFVYV1JCZGNXYUJLNytkNXRsREFCWWJY?=
 =?utf-8?B?a1pxZnNNNVI2RzFOUFdzNmZYYUFwSm94Y0tOb2xGUW45YmJxY2FLU09GSk53?=
 =?utf-8?B?bXVhM0R6YXVXNU9Qc3loVU4zTC9QOEszQnI2TlUrMFI5Rkt0QVR1d0U3L1RR?=
 =?utf-8?B?TjF4OURqbVhwOXhWeTZRTG85RE51aGdCeWk5ZDdTMWowZGVPSG8wSFlRL0JO?=
 =?utf-8?B?Wm52M2prcDZGZVM3a0RoTUZGVEkyb3lBeDNMZG5iSUdlL0hHT3R4dHlmL3dl?=
 =?utf-8?B?MUZUWmhqdVNTdmhlTld2S3g1Y24zSkZsaGpnUFI3ZWdIWHZLWnpWQzNyQ0RF?=
 =?utf-8?B?ZlAzaTdCbDNaN0lsWlBuZWc1T2xxa3BRckJmM3hWNEs1NFZyU3FkYXpJelRj?=
 =?utf-8?B?Z3VUVlBydlQvbitOMjl5d2dyMytFbEwzWG8vTWlNbm1wRVh1L3JWSTJldExu?=
 =?utf-8?B?aVIveEVBOFZnYnRiZUdUWCtYS3JWSCs3Nmh4R0RMMDZ0WE5iZlBTdmRGZ2Fl?=
 =?utf-8?B?eDVqdUNRWE1zMk1Jb3lXWFQ5d3VITUZWaVp4blRvWUoycGhxTXFCeStNMkpl?=
 =?utf-8?B?Z0hCbXZOUHd3dVIvQ2ZwdVpvS2hnQ3U5R1IrOExwSktSMG5BVXVucXhic3Q4?=
 =?utf-8?B?TjYrTUdqR1NMa3RaZFZuRjJTWFZzcFgzSHFVRVE3U1VtUDhHTW1LMTR2SDR0?=
 =?utf-8?B?YXY3WGlOWHF4VTFSL1ZGUDdReHB1QTVVRUVQQVdvSGhPanFVYWxXYzlFS2pG?=
 =?utf-8?B?SGRxbGdNbkJOSTExRHB6Qk5SNW1HeW5rSzMyWllCZzFXc3VrVEdRTyswdEZy?=
 =?utf-8?B?bHV5RVkwaVBsSlVTd0pEQU9pV3FzOTZ5cGNCWEtHOTdWV2JaeDFzMFllY1Fa?=
 =?utf-8?B?WGh3aVFHMDR5VUlLQWJlMkV3bTdMUFc5Zng3R0lTQTkwZ2FEMnpQRjZQTmls?=
 =?utf-8?B?bUxEUUZiUVpiRUdadUtzZmt5R29RelBMd2FIaU5XblpHbUN6eGhXaEtoU0JK?=
 =?utf-8?Q?QCN15MXx63vSfbSSUE0HD6oAi?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb94a91a-50e7-4800-2052-08de20dd0627
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2025 04:44:40.6284
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: spCHYj7DdUHJ3rtUAaJS9Nh4ubiWnMzKePuuXcanI+a7ZwT5sh0vZ/PZvIR9iTYdJaYd3DbaXSXtLc2BAFnVsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6286

Wei,


On 11/11/2025 6:48 AM, Wei Wang wrote:
> On Monday, November 10, 2025 5:55 PM, Vasant Hegde wrote:
>> To: Wei Wang <wei.w.wang@hotmail.com>; alex@shazbot.org;
>> jgg@nvidia.com; suravee.suthikulpanit@amd.com;
>> thomas.lendacky@amd.com; joro@8bytes.org
>> Cc: kevin.tian@intel.com; linux-kernel@vger.kernel.org;
>> iommu@lists.linux.dev
>> Subject: Re: [PATCH v2 1/2] iommu/amd: Add IOMMU_PROT_IE flag for
>> memory encryption
>>
>> Hi Wei,
>>
>> On 11/3/2025 7:30 PM, Wei Wang wrote:
>>> Introduce the IOMMU_PROT_IE flag to allow callers of
>>> iommu_v1_map_pages() to explicitly request memory encryption for
>> specific mappings.
>>>
>>> With SME enabled, the C-bit (encryption bit) in IOMMU page table
>>> entries is now set only when IOMMU_PROT_IE is specified. This provides
>>> fine-grained control over which IOVAs are encrypted through the IOMMU
>>> page tables.
>>>
>>> Current PCIe devices and switches do not interpret the C-bit, so
>>> applying it to MMIO mappings would break PCIe peer‑to‑peer
>>> communication. Update the implementation to restrict C-bit usage to
>> non‑MMIO backed IOVAs.
>>
>> Right. Quote from AMD Programmers Manual Vol2, "any pages
>> corresponding to MMIO addresses must be configured with the C-bit clear."
>>
> 
> Yes, thanks.
> 
>>>
>>> Fixes: 2543a786aa25 ("iommu/amd: Allow the AMD IOMMU to work with
>>> memory encryption")
>>> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
>>> Signed-off-by: Wei Wang <wei.w.wang@hotmail.com>
>>> --->  drivers/iommu/amd/amd_iommu_types.h | 3 ++-
>>>  drivers/iommu/amd/io_pgtable.c      | 7 +++++--
>>
>> May be apply same fix for io_pgtable_v2.c as well? (Of course filename
>> changed with generic pt series).
> 
> Yes. I was uncertain about the 1st stage mapping as it has a usage for
> GVA->GPA mappings, and for the trusted MMIO case, we do need the
> C-bit added to GPA. But since vIOMMU isn’t supported for SNP guests,
> and the trusted MMIO isn't ready yet, I think it should be safe to proceed
> with this now. The above consideration can be re-visited when the trusted
> MMIO gets landed.

Right. We use v2 (guest) page table to support PASID/PRI in host.

Agree. for now lets fix the v2 page table as well. We will fix it for Secure
vIOMMU when we add support.




> 
> I'll add it in the next version and see if others might have a different
> perspective on this.

Thanks!

-Vasant

