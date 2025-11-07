Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012049.outbound.protection.outlook.com [52.101.53.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD12431771E
	for <iommu@lists.linux.dev>; Fri,  7 Nov 2025 15:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762531032; cv=fail; b=gU0zeHLGWYNot1Sle4ggD4d30MNl+EhlO5WoDfvjP7YNfGJfnW6/ZeiRVxWq/APggGW8FY+9CFoHVwYCYxMX+nhwG79cdEqqdB+vU4nzb/Ew5FfYGfHUjmohJjiMAa5J9wIouC/yEXdFzVrpi48m/1M23o/HczogIEsxD9KY4jg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762531032; c=relaxed/simple;
	bh=/0j8MwDPgHFvo/xEIn7UbW1wwq1G++sQ0n0225+UMes=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ejhKdPaixkmC45Diib6Sy0wplULfsjBrlO7foY08qIdAodhSrhgMsz+fuPvmUJ82o92MNaOW4HE1b90qk7u4QZqx7J08Hr/v695b0ccmaSNf0fXQtrR57tVzzbNixMEBkrPA1qmR2IH/FR5lUUY21cGX0fgOTfaQtJTEMzdtNPk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jp1esfyk; arc=fail smtp.client-ip=52.101.53.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jp1esfyk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=auuzm59C1+FInEyWZKj9ZcWKV6+VV17c0O4V8x6WtL9CpaD3VcO9fCdYVcai/EAS2e8a+vn63OXyB84h4yc99+oK3TOYC62z2nBBPd0yddLX6DMuxn1gok8jrEjEidHyxgyEMI+tStPu2BszqiMyikfLB6k4WmRfr3E73qOPdO7ULeUgl/zTjkRTUn+ykN8mTdSJC065w1UIv1B5ft6zb3e6tScCsvCE+Hbsh2J+3S8cna9xZV3cmagvE+8Szx/hsHi2Zfl1ElzMY2n+lnMSu0CsP+Tf1d7CJ3ZMu1c4LHL4s36+PYQNZhkwfziiQZNGgVqditJKUNRB/62KqybiNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y/TSyBlXxinr+9iu2CxSxF8f9+HDDMqCzk4TO37e3W4=;
 b=e/LIQg/p0ITOesErvB8vcANxQwbVszrW5FduLovnPZqmGiHVMchVMjfiw1vRi5IxVyyprTtaD/86RK6zmKYbN7I6iKXkHBznMWzJCbAU22xC4yZWKEibPBh1pemyaSz/ofhKV2fxdDxcIf3e2aLqvVNow7gzWRdt+n/BCmRZGzgIHNuuoAv3QCBiGJDCc1aAuE4V/huIyybxbzFHfjloGUBrI6SYo/PgOfe8JZkr4i8jj7ABx4loFYMzPDCVtABhVaFYpim6W3kpTJwqOTRH2cbyfHLoZMTT4PObl2ePGC2aBqdtl6Mm4IUYkyaVvznHHCNc1rjJeZht1a/hfnfvZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y/TSyBlXxinr+9iu2CxSxF8f9+HDDMqCzk4TO37e3W4=;
 b=jp1esfykcyck+p0VTiXsRG6xCCr57CAIKic4gju3Id3Duk5wvI8xPGTeyRSMVdHtfYNaJ/9aa5fAntO5Td7Wm17zZbTg7t+P7G6xB7bqL/iF75B2T0mLqj9CGRSrpEIJR1I7W9glxoGjDmQ9g6Sh1vghuLd3CeXt0P+s/6tUxd27/9pPqUIs7TpZd3naxkBx/96o1ewHTayeWPC4pYB+82xIO6KfQ/xPFQXm2Xd6O4765nXIks+UlovB3YyrNeb1WmXG0k02QcXqBC+7Wk9ZWJHXh90PUmxQOLFyewMEk6/XF4iHhz5D9mGMFVOeUMFOs9bxS7/HYv2cxE5x731PDg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3613.namprd12.prod.outlook.com (2603:10b6:208:c1::17)
 by LV8PR12MB9360.namprd12.prod.outlook.com (2603:10b6:408:205::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Fri, 7 Nov
 2025 15:57:05 +0000
Received: from MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b]) by MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b%4]) with mapi id 15.20.9298.006; Fri, 7 Nov 2025
 15:57:05 +0000
Date: Fri, 7 Nov 2025 11:57:04 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Wei Wang <wei.w.wang@hotmail.com>
Cc: "alex@shazbot.org" <alex@shazbot.org>,
	"suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
	"thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
	"joro@8bytes.org" <joro@8bytes.org>,
	"kevin.tian@intel.com" <kevin.tian@intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>
Subject: Re: [PATCH v2 2/2] vfio/type1: Set IOMMU_MMIO in dma->prot for
 MMIO-backed addresses
Message-ID: <20251107155704.GM1732817@nvidia.com>
References: <SI2PR01MB439373CA7A023D8EC4C42040DCC7A@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
 <SI2PR01MB4393DFDCB2788CB823DAEC64DCC7A@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
 <20251107010349.GD1708009@nvidia.com>
 <SI2PR01MB43930E5D802B02D3FCD5ED9ADCC3A@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
 <20251107141632.GL1732817@nvidia.com>
 <SI2PR01MB4393E04163E5AC9FD45D56EFDCC3A@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <SI2PR01MB4393E04163E5AC9FD45D56EFDCC3A@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
X-ClientProxiedBy: BL1PR13CA0273.namprd13.prod.outlook.com
 (2603:10b6:208:2bc::8) To MN2PR12MB3613.namprd12.prod.outlook.com
 (2603:10b6:208:c1::17)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3613:EE_|LV8PR12MB9360:EE_
X-MS-Office365-Filtering-Correlation-Id: e036df4f-8f28-459e-8fe5-08de1e164c48
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?anFDUG5lSXkrbWluN245QVEzYXdUVW84WmZobEJrY2l4bEdNTFcvK0ZLdk4v?=
 =?utf-8?B?N0dxSW1PSWpZRWF1NDE3ZUZFWC9mWUxBT3o1YmpsR0lXV2xyL2FIUUdkK01s?=
 =?utf-8?B?QitsdUNFbEtLdlZYdncxcS9NZlk5dGxnR01vY3BINFlDVndmM2VSUUpzWEFr?=
 =?utf-8?B?d1drajhQTVo2TTRTOVdLWEg1aXlnRlp1UEVsQy9JeDhRZFNGcDM2YS9BVmpK?=
 =?utf-8?B?Y3ZXNHEyRWVxNzBRMlJXcHhtUWVmRU92TVBFVGp4SFVxelJHVlJzanV1YTZP?=
 =?utf-8?B?ZlNtVENsbmNsaHJYS09DbFhNYmNpV1ZwZVlPYlYrYitLd2tSTUlRaHcrczBj?=
 =?utf-8?B?dlRmVzJ0aFFWMXJOK25Va2tJMDZ4TUFOSVArRU1mS25wTmxhTEUxRldrdlEy?=
 =?utf-8?B?bWxydkJVMThDOHY4Q1JtUEVrdnk3bnVQWTJzWUZVZXk5NEh5aFZOYlRiVytE?=
 =?utf-8?B?RGJjdHVKdXFpSy9HSWRLcVJ5alhDY0ozM28xdmptYyt2d3d5amRka2xGRk0x?=
 =?utf-8?B?bHI2WUo1d21STG5XRXZMTjRIeXh6VkMrUjducytkNTU0YXk2MHZwQ2pubjVC?=
 =?utf-8?B?QU1VY29qR3cyemh2Z1gxK2MrYU83dEJKcmJzT2k2VGNoS0Rtd09IejJZdzcz?=
 =?utf-8?B?WHpma2F4QVVEOUlVUHBtMjBQRENQcmtsWmJBaUgrNHNpanRhMlYrRE9ReEpr?=
 =?utf-8?B?ZklTM0ErWWxPRnN3MFBtdmdHUHFaNnRWY0NRcDZBSlRwd2hLN3kxUTFiVlA4?=
 =?utf-8?B?dXlIMnJ2VklEV0VtZTBkbjVjOWwvT1hUQldVN0IrcUFvdVZmOExEOVpXQ01m?=
 =?utf-8?B?cGwxaXh6WXBTTkdKUndtYTdvY2V0WGJUSFIrY3VTcjE5TmNnUXZjZVdaZklX?=
 =?utf-8?B?QUprUjZ0MEFxZjA0K0wzZVA5U2lQMkZlZWh2QkR1cGs1bk9aRmx0czQxRGtz?=
 =?utf-8?B?dFhSMHRtaXpqbmlna0xqd2hJY2hpb1UyOG43VlVoNlBCUUxCVk5nVW1hRnBz?=
 =?utf-8?B?alAvWVZWcSt6aWJESTlXZmlVMDVvcjVaSnZIKzBSV0FzdndzVGljdWRmZnA1?=
 =?utf-8?B?VWlGQUhCVnBzOStrWTNMelJDdk9RMVkwdHBMQmZSTFYxaU1EYllFSlZ4UnEx?=
 =?utf-8?B?Z3AvekVKQVZEQWVqR1dabTJTK3k3Q1BNUUdJWDB0TkNOaE9hZHNieXhjTGtX?=
 =?utf-8?B?dEM1azQ0M2hCV3R3THVWOW1EREdvVk53WEVvcTd0L28rR3hFVzZWSVdscEg4?=
 =?utf-8?B?M0Rid25sSk5qcHlMQW1QeWtEQ2Y2Q0IveHlrcHhCZS9QU2tzUnhmMzZqOUlh?=
 =?utf-8?B?bUVLVXdvOG83RGV0TTJKbk1NelM4S2wrMzB0andGWlZHSVkrUGhpMERLQXVv?=
 =?utf-8?B?S2ZEemF0amlDSkNaMlZIVzRrRzIxck9lZ2RGeTJiY2pyeVRQaHdmOHd0b3pD?=
 =?utf-8?B?dlRndTZEc3dNYm10M0huZVk1dXZIalpZNiswcDlveExxWFhqWVN6dlUxZXda?=
 =?utf-8?B?MC9HZldDT3pNRmdDSkhIRmY2ODZkR3pZcTlkNXJGMmwwT2ZrRFNRTlB5WWt5?=
 =?utf-8?B?ZVlVUFNITDVhRGdMRjNqYVZFa3A3TU1KVVU0TEtuNmRSc3dQbkdtRkV3SmNZ?=
 =?utf-8?B?c29YYUhURURiWnFMUkJ1TC9JN2ZzcmFVVmlYbnhMQ212d2V2bzhBSy9GVUY2?=
 =?utf-8?B?TWVQZnVXMGpmU0Q4dHJ1UUlsMWZKOU9oNFBVSE9DYmVnbm9PWjBYak5UZi9v?=
 =?utf-8?B?YWhiWjB2M0I4NlRRRHh6YUpOYzBXT2dqQnROVHAxeE9RZjRMTDNabHZXWDlp?=
 =?utf-8?B?cC9tWjgzVldILzJPQmhLeGJqNDlFS09BN080SWM1TDl6ZklhVWY0ZXhqeERa?=
 =?utf-8?B?UnJDQU4rWTZQOGczdTVkMFppb0pJTlpHZTh6QXJqaUJVWWVJZVpYdUhFbVZC?=
 =?utf-8?Q?mq0J4t29B6m75x+2Zz4tSxsxsb1TkOn6?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3613.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Mng0L3M4UEtDcEFyMm1OVmNQVzBUcmY0cWtHTVJKbEJiTEx1Q2Z0bjU2SnZZ?=
 =?utf-8?B?M0ZkTHNDc2NDcTZwWDFWeGpneXhPaTBlbTZmdVh2NHowRjB4K05yaGRmaHJV?=
 =?utf-8?B?YTUxL0NKQkdPdGFjcCs0eDJPVUhjalZmZ09MVC9wY2tyN0MrMmU0OGpSZ1pO?=
 =?utf-8?B?QVNzVDk4ZDVuZ0NaWVM0d2xWK1RVLzczdWZNRlQySkl6d0FsOW9wTW15UVdT?=
 =?utf-8?B?UTF3KzlsRGFSbnBUOGd2MGlLK2h3ek5TSENjbVNNbzlGSENqbndwSnBEbmFl?=
 =?utf-8?B?WHV2NGNrWUc4ZGVCdkpFRFNYY20ybGQvSHdOZlZyZFNuTTZzbmw1cURhTVcx?=
 =?utf-8?B?Wm9idlg0bUNaZzFoRjFML2lyeVgxVTRqQnBIbSt2aHZGc3VmMzYxaVA3VkNE?=
 =?utf-8?B?WVM5K29NM1BJMEN5aFlKS0tRMGo2ZGh0M09yQ0VNSGszczdDdnd2SDRlc1Na?=
 =?utf-8?B?VzBNZkdNTkYvR3dyNjRNNUFmUkQxY3Vidkl4b1F4NVZSZWNjUFVJaEdZa3FS?=
 =?utf-8?B?bGRWam9zNHowOTNMOExQaTZ4eUhvcVppODAxKzZzRHYzOHYvTUdFR1dMQzIr?=
 =?utf-8?B?N0lTdy9TNENYalpqRzlOKzczenF0bEFZQkcvVW5LWUl5a2I1QUVRcDBIQnhK?=
 =?utf-8?B?eUlvbGpHS1gvK0VNZS9FeW80TVNsQ2JybHpWSDQxZ3FaUjBWUTArVnFVRVRW?=
 =?utf-8?B?c3QrM3N0R00rdjRFVlQyRGVvN2F2eFQ4YWRUSVU3bVo0dzMyZ05ObnFlVm1C?=
 =?utf-8?B?QldwbjUxeTNzelRvdUtzUGZGM0FROGRITk43aGFJWXlNQ0hFRkhQTnR4RE9S?=
 =?utf-8?B?YXJnS2VXK2RSeDBTRkpya2tteFJZNjE1WE03RER5eEN4Zmd5SVEvRHczMHlN?=
 =?utf-8?B?cGVkd2tFZ3lpUU5DQ1Jxb25KUlNmY0VrWTcycm9PZUkxdkhHaWlhd2JWd1FG?=
 =?utf-8?B?OUUzU1NuM2NhTzJmWFhyRXpRb3ErNzlaMi9FN1JBeDZvK09kcEhLSDNocTdK?=
 =?utf-8?B?TEV5NG1sVS8zWWpDUnNYS1gzZ3dUdmk3NGRnaUVsM0JzRjRwRGpQdHJBdXZI?=
 =?utf-8?B?ZzREN2xvS3J3NWRleWZJUHZXZ3pkZFRxWXRzMURaVnhvVWtsUm4wWHNKNnV6?=
 =?utf-8?B?VU0xTlZOR1Q1Um5HMHN4bTNGc1ptNjUxcUVFU3NNUDZRT2RhdVpBUVBqWDNq?=
 =?utf-8?B?cUs0YVdqUkg3Q0pFNVBNcVJRK3FPT0ljNCsxcEsvOW9FYVZjY1E3ZjVEYmJz?=
 =?utf-8?B?ODhQWjRuYjkxQWJDUUgxUk1nWWc4SVZKVnY3YTIwL2hqcFl2Y05OMXpMSE92?=
 =?utf-8?B?UGhjdEpJTG5QRVZkS1pRdStIdDdYd2kzcXBKT3F3Y2F3dzFGOFVEbXo4UXdW?=
 =?utf-8?B?S3M3eHJEK0RjQW90aU5JaEQ2RGdsQmtKUjRYYmpUQy9mQlhpblFXUFphditW?=
 =?utf-8?B?TGxPRkQrL0ZJWGJ6VVhSSjJrd2d6bklnOGNpK1pFb3QwMUNPK3Z2aGNlZDZD?=
 =?utf-8?B?THo2cHRIMkp0Tm5qWXZZNWdlV1NnZzVmaUdMWHp0OGFtamU3a2Mzamp5akVM?=
 =?utf-8?B?UVRNUWVQWXh0Zk1Ubm5XbmwwS1gxdVZGbzFrTGVUWGZHR2JwU3o0WG1tMGti?=
 =?utf-8?B?M28yM0NGS21jd0JNekhIY2tkcmFiN3BwMnhQQlBYa1M5VVZjY0xIRlU0alBT?=
 =?utf-8?B?TFNlVHF0YjRRUHdQU3czLzEvR1RDRHhPK1hldHZXVGdoTVcyaWVUYzFGN2Vt?=
 =?utf-8?B?cUlucVdodWppcDRmb0ViNzNmQ3RpbXowWThkZzZJWld0Zmlrb1JXM1B3K2hn?=
 =?utf-8?B?U3hnN00xS2FGOHNoTlJRNDVJTFl2OTh0U1MxY2JRelFrNk1sS3ErOXpPS0Q5?=
 =?utf-8?B?dlZYUzhFbXNwOXk0ZDdDcDdNOXN6YmpaV050dG9tNVRqS1pwME9CejhHOERi?=
 =?utf-8?B?ckdIRmgwcjU1N0NxQXp2a3IwbXZ3VC8zUGRnRFBFbkJYS2F6Y0ozbldhMFpy?=
 =?utf-8?B?dGRiaW45L2xlZm5NRlBGc0FIc2d1L3NtdHdqaGZGU1huMDM5QUJiVTJkVDZa?=
 =?utf-8?B?V2ljRjg5cUZxd05lRnA5cW9RRXpRKzVrQjI2V284R2hTdlllczRKNlAyWnJH?=
 =?utf-8?Q?8mZo=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e036df4f-8f28-459e-8fe5-08de1e164c48
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3613.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2025 15:57:05.2650
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ex/5Mb0Llks4G52WrolvMfHMwSuaucyzFh/bf2cLiUUYsL/zGBvdcXT7nN54AlfW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9360

On Fri, Nov 07, 2025 at 03:49:17PM +0000, Wei Wang wrote:
>    > (are you aware of any real examples in use?)
>    > VM_IO should indicate MMIO, yes, but we don't actually check that in
>    > this type 1 path..

>    Is it because VFIO type1 didn’t need to check for MMIO before?
>    (not sure how this impacts this patch adding the VM_IO check for MMIO
>    :) )

Okay, but it still doesn't mean it has to be decrypted..

Jason
