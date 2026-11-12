Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.83.24
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794469707;
	b=CBnCp5I0uIj0eBolerNm+WnL6VHjZW3wc3x2GUl1vithnQYOq0fhrGlz+xjkmjigN+N9
	 fJOlfXViZ0vh25Mycof5RzcXtAGm62qvdaPNSRuWDe+sUeqkCQVS/3cUVS9Oc3VMXODkN
	 WMuQ5laDZd4c94PXPxx+tx4CG1wT3vKYbrP9vl+krN53nMb2JR1amreWj8AgVUnKEFzTL
	 KVWo1XdVWyw/KZeGY+L+EwjxoGPoEgspg9VBtVUcCYEKM/q8dB+PnHoA8f0CjaMAEnWpb
	 lfhd9s41TQKJ2h4NBAQQYRmG2jrH0fozeaPYuIDGwKY0gvHdPSFDp9zEebw8nad4MKg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794469707;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:Subject:Date:
	 Message-Id:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-ClientProxiedBy:MIME-Version:
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
	bh=aoYGNl3P0DV5NhjXbksTu0BhmOgLXt1nXgsp2JP0mVQ=;
	b=z4e97ehJxJckyNn2kuXMojvoDbIGoH2brjj0rkpECnCMeWgoDE00Vrsw26gnBmfDogMJ
	 9TV1cnhRtBrpJT3wtf18RrMIfga8eS7FVaG8Jwk0kLlJ+2a8guNlRpeam3zvSTF1thH7r
	 TeaY5uUVZHG8b6qOduQQNxxKYSNN39r5abZpcZyblkyRVYZpP3glfhcsdaq+8n2+lbj5p
	 9wTRnKnUp5j7tN0Niy8k2SEHaTcjCFGBZUPXEcaisiqQQ+IU0m2j078k5KMdCckX4PW7v
	 jtXKY4iqJlDhcRa9UZL2YztGo+j09rrrIOlzgs5/cakGWc3yaBqLQ5+dUYhO49qtv3A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=eje19+5t;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.83.24
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013024.outbound.protection.outlook.com [52.101.83.24])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 366B7606A32E;
	Thu, 12 Nov 2026 07:48:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 366B7606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=eje19+5t
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sKlH6s93KVGHemmTkzGmW5lNNG9ly69pws+Av1ldCcqQFLxJajfEEYbMRf3fBaWli9jDiDYQUtNcbda0FqmfhuRGRzJtSF9R4GlYF09a7zoUmxipywvL0PkiqFIMNYCJRiAV+hxIIRU82FEJjzYWsH+ociTql/mNeowcURDJGw2ly0U/z75y75f2Kg2+VsPBfy/GAGjBQl9kYkHt/csxBbtRZc61Yt3cB8ua6ooUvHhccSuo1V4N7qy8Ouzx2SRDnwf8QCksefPdtzEx9N4VlO1xSbjV5VaK0rAFb9cNb9YPyQJzrVSXul23IrqXYdSdr/JJ2HfcWGQiUwXv559Pug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aoYGNl3P0DV5NhjXbksTu0BhmOgLXt1nXgsp2JP0mVQ=;
 b=LVMd85fG+AqJ+pYRL2vhED5c+A/MfHGanAVAcKf8EmWclLNfi3Iq0Zn5aMq96UAUAYIRWmTatu9gqX7cNj1wznAwmm5vVUvu96d4rhhXnQ6h2pk9ZKuwvmDqPapig6Jxzt3YMzfNTGCbkZWXli4JvubyPt0EIhNoR9cd7JHaNzsoa01Hs/ORaIfE9VK5R2Nt+69+bNoWOBSEKiotJcb+rR4AgfFbId7FDUVbIEDPLFbotHZPLpwppatY4gsbz+LXGoB0xqn6kcMkbptXc8hsMOJpFdSWBNUgEbrYGpQNxDrWUFOXam2SEYa/aDL3VaGw/IJebsZxgzBz6Y1X9aUQgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aoYGNl3P0DV5NhjXbksTu0BhmOgLXt1nXgsp2JP0mVQ=;
 b=eje19+5tzbqlO3KMMm92weDHc9CxutkPNx6hmONYdkUjL1CRB3uwGZ8mVm467pUqv+1UXgbOVsMQs+kSQcckLHDMCElSlXVTAxlAtMP4GkZqamkmLfp1iweOcKK9bBQc0pqHWww/kewy3WRawrA5XQQH8eMFp8DPSY3OcOoumvofhf3SS7o33f7t75bfbbIOPdl/aCsjwYZmCBmEoRU5d8zi+Abc/d8aP5p+mBTf/xUk7eazQug5ulX6wRN4VXb4ZWY0K61LhQZfw7IJEmY8EXqnzwLjPxVn02ZK3qDRMym+F/L/w58vVLloWdo3e9dRcb1YIyauaFtJ11/sR5TY2w==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by PAXPR04MB8909.eurprd04.prod.outlook.com (2603:10a6:102:20c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.9; Thu, 12 Nov
 2026 07:48:21 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%5]) with mapi id 15.21.0615.008; Thu, 12 Nov 2026
 07:48:21 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Subject: [PATCH v6 0/9] dmaengine: add DMA channel bus and fsl-edma
 per-channel IOMMU support
Date: Thu, 12 Nov 2026 15:53:03 +0800
Message-Id: <20261112-edma-iommu-v3-v6-0-b038edb8ce6f@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAF9w9WoC/3WNQQqDMBBFr1KybsRMNGJXQukpShcxjjWlMZKoW
 MS7N7GbUijM5sF/b1bi0Wn05HRYicNZe237AOJ4IKqT/R2pbgITSEEwlgLFxkiqrTETnTkFqEX
 BC1aoNiPBGRy2etl719uH/VQ/UI0xEhed9qN1r/3hzOPuXztcSssmRQGyzDOsq8sizfDE5GwNi
 fU5//IZ+/Xz4EPOC4U1CiWh6pchUdHdtu0NRZkbYfoAAAA=
X-Change-ID: 20261102-edma-iommu-v3-22b673717cf4
To: Frank Li <Frank.Li@nxp.com>, Vinod Koul <vkoul@kernel.org>, 
 "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>, Laxman Dewangan <ldewangan@nvidia.com>, 
 Jon Hunter <jonathanh@nvidia.com>, 
 Thierry Reding <thierry.reding@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: Frank Li <Frank.Li@kernel.org>, 
 Larisa IIeana Grigore <larisa.grigore@nxp.com>, imx@lists.linux.dev, 
 dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
 iommu@lists.linux.dev, linux-tegra@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.16-dev-7bc12
X-ClientProxiedBy: MA5P287CA0298.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:21e::8) To AM8PR04MB7874.eurprd04.prod.outlook.com
 (2603:10a6:20b:24d::9)
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
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|PAXPR04MB8909:EE_
X-MS-Office365-Filtering-Correlation-Id: b2e453dd-5ab2-48eb-5e05-08df40915289
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|23010399003|376014|7416014|366016|260925022911599003|261026140227099003|921020|260925021911599003|261028144727099003|260925021311599003|261102123227099003|5023799004|261026121527099003|11063799006|56012099006|261022075727099003|261102124527099003|261021123027099003|261022105027099003|261021121427099003|261009223027099003|18002099003|6133799003|10067099003;
X-Microsoft-Antispam-Message-Info:
	FIu79Ae/fzEeyYWcH6YUfrMpFya/SJWw0jXeD8w5i6yi3ZOHnJGYiZyVWmTM8fsLou14U1z2/krQlBIkzMl+RDidrPRI+g1+SP9105mx1Iutaxsnf/Thu1O9vOJTK9I1ZHuvRgVyLnUSLSfkj3CQ+vuWKszQYt2OMnSdCBWBpAE3l4bwGnXCOWgmTM/v0Hjqk3Dxh9oJqA74Y5t9ChvMcgIpHvplT5IwpN8RMX86IDI86fgoUWVXedzKLWj2XiQyL4iLdnPGwS2cUhXYQdcTX8lOkCC6egN/dJiBQyBIDsdrMTwZoABB+j7nOJ/Q73uzeM8DFOruKRMivlHBuemfS/yng1XP3uQ1ElDVm9IaGH+tOGCCpklZZmQ2tsluW8JHcKh3et974w9HUJ3VQcZVPiJwBH/ctr8txoPi8LV72qmmMsIZ9qdrHVU4yASedZaPlNXti2BxyLVNBSC++n+GHsbbbEQ/uRW+gJ2Ud9+hpO9s/LYvXwaiTWCy1FonY7mBfO+TDwNLt4zyjdEXEHm3WnQXvrYisg6g/Kfji70hmEei7JvHuRJlXQmBQMA9pr+2N7QkauCIwGYkKZH2IqylCqdmQ0MosMJvQAff7A/VRB2tZVk2yi300dtU2rv2qhmULRm1lU7Jm3NNomyONTUTnfanLEC2oFDTcGHEeQUxRfQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7874.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(23010399003)(376014)(7416014)(366016)(260925022911599003)(261026140227099003)(921020)(260925021911599003)(261028144727099003)(260925021311599003)(261102123227099003)(5023799004)(261026121527099003)(11063799006)(56012099006)(261022075727099003)(261102124527099003)(261021123027099003)(261022105027099003)(261021121427099003)(261009223027099003)(18002099003)(6133799003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eUxiRWRtOUViRHdRajNsWEZhcHFtNjMvZTJYbEF2dTRMcGpVc3Q1MUl0ZmFS?=
 =?utf-8?B?VXhkR1FqQWJ1MXhpQVRLZkw5WURnb1lqS1lHZEhiWmV5ZHBwVGpERmdZK0I3?=
 =?utf-8?B?OVRxWlJyRGZxU2lkMmdlazFMVnJHN1dKdWxLQUFIQkxZTitXV05mRWRQUzQv?=
 =?utf-8?B?eFNRellUSWxSenpDNEVhVm81bzVKeDlQWTc3VFZkaC9HbllndHNBdFpSM1VN?=
 =?utf-8?B?TWNBamVOTHNNdlF1T2VNdnQwZk1Cd2NlM1cvTHdDRy9SYWxnczZvUmNEWmRM?=
 =?utf-8?B?eXlEWmhZb1Erdk1aNkNXc3M4SmU4d0hkbHhmM3VGMFlFQkszNzJ0akZQUUp0?=
 =?utf-8?B?czdrS1hVZ0gxaTVuRWlvZjFEbXRVRzRLbW02bTQxWkRpemZxL2VPbXpyQ1hZ?=
 =?utf-8?B?b3JPNXFOYVdvVVNkMERKZDhoL0JHVjIwN1FRN1lJdFRVeFZ6NDFURnFtMFhh?=
 =?utf-8?B?L3VSQnMvTngvNXBVanNKU0EzajZqcS9hSzF5UEQxenpLaWY4OGM3cXVXT2Vz?=
 =?utf-8?B?NjNIdTU4Ly9JQzRCaHd4aWRkclRFZUE3RU1WS3NwOVltcU5tUy91bDZKTWE3?=
 =?utf-8?B?U2FvMDFaNXVGQXc0ekRkQVMybm14SU5kVFhMeWZBdUJhb2luWitwWGpad3pQ?=
 =?utf-8?B?b3JDUWRmUm14NUx4T21UWG1GMUw1TDhJanE3YXNpYzFmaG1Uc2hGc05ROEgy?=
 =?utf-8?B?NEQyU2NuY0d6T3g1MmYrOUpqODlnZnZHeEJBdyt2Zzh1SnRyTVdsdXB1RmxE?=
 =?utf-8?B?YUJXU3U5TlFHeHdvQ0QyckVmYVJYcldYWGFlblcwN1doSi9nVys2TVpJVVRY?=
 =?utf-8?B?bG05dFNNT3JyTnpneWpPUkUvQ3kzV3I3Wjc0TDBHRTVPaDg1Tjc1NnlCUEly?=
 =?utf-8?B?UE1WbTJNNElma2FxbVZnTVF4ZEp1SnFGN0xpT3FITi94WjRlY0diTHdvUDFM?=
 =?utf-8?B?dkRWTGthTnhLZ2JtTDhFOTR4WGVYd2lLOUxVVnd0ZzlQMGkvb2N2cjlua2Ni?=
 =?utf-8?B?WUhxaG9DVlNJZU02MUl0Q3R1QWhTY0ZIakg4ZTJHaUk2T1hhOWpXYU0yaTJx?=
 =?utf-8?B?WGZpUHlkcW5MQW5KcnZWUXd4cEdZTXljbU5YMW1VaXZsTHNmdnV5dVpDWGdU?=
 =?utf-8?B?aFcwbDQwWm45TzBENmEvVVpOdEdwbm1DUnhZaldkMCtOZVJqcG51UVYzWDlt?=
 =?utf-8?B?MjgrcXBuNU13eENVVThKQnZuTXhWWmtjN0p6VktTVkM1eGxTRjN4N2d1K0Vt?=
 =?utf-8?B?czFjb0pRbGVmODB2UzVlSDRNV0xjaE1PMGhIN2xFM056V1NWOVV0NjZOYUFl?=
 =?utf-8?B?ZFZuUFFXN0VDRElaYzFlTUxBVVlKRllmRlJWUzA2dlY4RkZ4em1HZWd3bFh4?=
 =?utf-8?B?T2wxb3JRcVBpWVd3T1I1bCtxRzkvSXoyVnpvUTVFTEYySmRBYkE4VC9pT3JP?=
 =?utf-8?B?WU9oOXROcGZ4MStWNFRxbUdSQjBPZ3RmekxQd3dhMlNIWDlaMHNPRW9LOFdl?=
 =?utf-8?B?QXlyL1l4VTN2a2xWc0llL0ZPSDVLdHhDYkZwRTBVQnY4Z0d0VldRcjE4MXFB?=
 =?utf-8?B?UlA3Rm1nck9VeUFhYnVTbjI1bkc2YURmL1EzN0QrcCtSUlB1Y05xOVl6ZldZ?=
 =?utf-8?B?QkpoKytMcFJiM1RCVDF1enNyMzNjN0x4STA2b256cjRjUjFXZVJpSlZRSXJr?=
 =?utf-8?B?bmwva3NBZkJodUlxU1VpcGwzT0F3aHJSYTA5dlorN3JEVnpTOUZWVUs2RVgz?=
 =?utf-8?B?M2xDcUJHbDFNU2ZNR3BsbkgzU1dITjdyT0RwSG1Hakpoa1NLampZNmVxbFoz?=
 =?utf-8?B?US9Oa3FUdFpzY2hDMmkvaXZFY3ZSbUhHRVBIUHUwOHJUd2w0V1ljdUd2YU83?=
 =?utf-8?B?N0NaeDhINTlhMzRoMEdtbWNMR0p2bkpTdmcwd3hielpCZ0w3UmE5VDJDdFdT?=
 =?utf-8?B?RThLTCtnZzRRVFF4MWJhK2VDaVFNU0lJZHhUSUxQZUF2b0JCdFRjNHVCZ2dM?=
 =?utf-8?B?ZXV0clFSbVpQQ0d2L3BoRzhLSUFDSUo0aVlrcXZGc3czZ3pDbUpOMEhxb3Z2?=
 =?utf-8?B?T1QxVS9Ubk9yajcxK3RIT3luM0NxWGMyYkR1VkNRSXN0MndlN2pjSzR6Z004?=
 =?utf-8?B?VFpxMldjOEM1elEzQTMvTzBHWXQrR3B5ZDBQLzJuK2gzcjVOVlpSQ0JINWxs?=
 =?utf-8?B?VXZyaXl1NklVb0FVdHNPN2U1WDV0SHdFa0JDVlpzWW42UDJ5VkVGMFBGalFW?=
 =?utf-8?B?RkNaUnFuZ2hjTnBGb3ozekYweHFPc1Q4NDRoKzFMSER6MVBhQVBsZldkMGsr?=
 =?utf-8?B?ajR0K3VDQUhtWnZ3NDhGQ0V3SjVYdktnZVhhWEpqalA5UWo3KzRRRU90cC9K?=
 =?utf-8?Q?Zxu9vuX9Lrwhobse94APpXOcXNjbUXMPkuN7y?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2e453dd-5ab2-48eb-5e05-08df40915289
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2026 07:48:21.1565
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jhTLJgbquijfHU2w8MhBU1cX7SRyxU7ttvD3bLHKsceixs7Jh6KZLFGdRrvnPiLZl1IkdibiB+3yoLQZvYKB/PpODTZH3K2phL/gfgYLX4YyEpoaT/jZuUjhALyVQde3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8909

I used iommu-map for eDMA, but iommu experts rejected it:
"Using iommu-map to describe synthetic dma_chan_dev devices that the
kernel creates is the same kind of DT abuse from over here:"
More info: https://lore.kernel.org/all/20260917144804.GI3196566@ziepe.ca/

So I followed here [2] as Krzysztof wrote for QCOM VPU:
"Thanks Jason for context and detailed arguments. Robin did not chime in
yet, but from what I understood the DT-child-node approach will be the
way we should go here.

I accept above point of view and I am fine with this, thus Vishnu and
Vikash - please go ahead with DT-child-node solution we had some time ago."
[2] https://lore.kernel.org/linux-iommu/c7b956a9-d3e8-4e18-b780-5d08f5cd2ca1@kernel.org/

This series adds per-channel DT child node support to fsl-edma and, as a
prerequisite, introduces a proper bus for DMA channel devices.

The fsl-edma change allows each channel to carry its own reg, interrupts
and iommus properties.  Power domains remain attached at the parent level.
Parsing the child nodes is straightforward, but per-channel IOMMU
configuration is not: the DMA engine currently creates struct dma_chan_dev
as a class device without any bus, so of_dma_configure() has no bus to probe
the IOMMU with, and the IOMMU core does not have a bus notifier for DMA
channel devices.

Drivers that need per-channel IOMMU support currently work around this by
assigning dev->bus after dmaenginem_async_device_register().  That is unsafe
because bus_add_device() already ran with bus == NULL and did not take a bus
subsystem reference.  When the channel device is later unregistered,
bus_remove_device() drops a reference that was never acquired, leading to a
reference count underflow and a potential use-after-free.  Using
platform_bus_type is also wrong: platform_match() and platform_uevent()
expect the device to be embedded in a struct platform_device.

A dedicated bus for DMA channel devices solves this.  The channel devices are
converted from class devices to bus devices:

  - the bus is registered early, before iommu_subsys_init() consumes
    iommu_buses[];
  - the match callback always reports no match, so no driver binds to a
    channel device;
  - channel devices are registered on the bus before device_register(), so
    bus_add_device() and bus_remove_device() are balanced;
  - the bus is added to iommu_buses[], so the existing IOMMU notifier
    handles per-channel IOMMU probe and release.

The existing /sys/class/dma interface is preserved with class_compat, the
mechanism provided by the driver core for converting a class device family to
bus devices. A compatibility class named "dma" keeps
/sys/class/dma/dmaNchanM available, while the devices themselves live on the
DMA bus. The bus is named "dmaengine-chan" to avoid colliding with the SuperH DMA
bus, which is also named "dma". The uevent SUBSYSTEM and "subsystem" link
therefore use "dmaengine-chan", while /sys/class/dma is unchanged. dma_dev_groups
moves from the old class to the bus, and chan_dev_release is installed
directly as the device release callback.

While testing controller unbind, a pre-existing fsl-edma ordering bug was
found: fsl_edma_remove() removed all channels from dma_dev.channels before the
managed dma_async_device_unregister() action ran, so the channel devices and
their IOMMU groups were never released. Patch 1 fixes that ordering, which is
needed to make the bind/unbind lifecycle test meaningful.

Runtime-tested on i.MX95: repeated controller bind/unbind cycles with a
local DT based on the child-node conversion removed and recreated the
channel devices as expected, with no refcount, BUG, WARNING or suspicious
kobject diagnostics.  The per-channel IOMMU path was exercised with a local
DT adding iommus; that DT update is not part of this series.

The binding and driver support per-channel iommus, but patch 9 does not add
them to the i.MX95 DTS yet. That DT update will be sent separately when the
shared stream ID support are finalized.

I put all the patches in one patchset to give people a full picture.
If need to separate patches into multiple patchsets, I could do that
in next version.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
Changes in v6:
- Patch 2:
    Update commit message include more info regarding bus introduction. (Frank)
    name the DMA channel bus "dmaengine-chan" instead of "dma-chan" (Frank).
- Patch 6: new prep patch converting chan_masked tests from BIT() to
  BIT_ULL() for channels 32-63 (Frank).
- Patch 7: new prep patch converting fsl-edma to dmaengine_get_dma_device() (Frank).
- Patch 8: Use scoped api, avoid scan channel twice. (Frank)
- Link to v5: https://patch.msgid.link/20261111-edma-iommu-v3-v5-0-2537cebe6ca2@nxp.com

Changes in v5:
- Patch 2: Rename bus name to dma-chan per report from Sashiko.
- Patch 6: Address the issue reported by kernel bot:
  symbol '__udivdi3' undefined, using div_u64_rem
- Rebased to next-20261110
- Link to v4: https://lore.kernel.org/all/20261103-edma-iommu-v3-v4-0-470415d418c5@Example.Com/

Changes in v4:
- Patch 1, patch 4 and patch 5 are unchanged.
- Patch 2:
  Register the DMA channel bus from core_initcall so it exists before any
  IOMMU driver can call iommu_device_register(), which iterates
  iommu_buses[].
  Clean up the DMA unmap pools if dmaengine initialisation fails.
  Clarify that the bus match callback always reports no match.
- Patch 3:
  Update the ordering rationale for IOMMU drivers that register before
  arch_initcall. No functional change beyond patch 2's initcall move.
- Patch 6:
  - Validate child register resources: require them to be contained in the
    controller resource and aligned to chreg_space_sz.
  - Use div_u64() for the channel index calculation and reject values that
    do not fit in an int, avoiding 32-bit __aeabi_uldivmod/__udivdi3 issues.
  - Ignore child nodes beyond dma-channels, so imx95-navq.dts with
    dma-channels = <30> still probes.
  - Use BIT_ULL() for the 64-bit chan_masked bitmap, including channels
    32-63 on 32-bit builds.
  - Set chdev->dma_parms to the controller dma_parms so the per-channel
    device keeps the 0x7fff segment size limit.
  - Use dev_err_probe() for of_dma_configure() failures.
  - Reject channels for which iommus did not result in an IOMMU mapping
    instead of setting chan_dma_dev = true silently.
  - If child nodes are used, require every unmasked channel to have an
    available child node with a valid interrupt; otherwise fail probe with
    an error asking for dma-channel-mask.
  - Do not fall back to the parent flat interrupt array in child-node mode.
  - Keep the shared error IRQ on the parent node.
  - Clarify that child power-domains are not handled by this patch.
- Patch 7:
  - No functional change. The out-of-range child nodes used by
    imx95-navq.dts are handled by patch 6.
- The i.MX95 DTS still does not add per-channel iommus; that update will be
  submitted separately.
- Board test overlays are kept out of the upstream series.
- Link to v3: https://patch.msgid.link/20261102-edma-iommu-v3-v3-0-9d0e62a954eb@Example.Com

Changes in V3:
- Patch [1-4] are new patches
- Add R-b for patch 5
- Patch 6: handle of_irq_get() -EPROBE_DEFER, drop the explicit bus
  assignment to "chdev->bus" which is resolved by patch [2-4].
- Rebased to linus/master v7.4-rc1
Changes in V2:
- Switch to add child node for dma channel.
- Link to V1: https://lore.kernel.org/dmaengine/20260916-edma-iommu-v1-0-e1731968081e@nxp.com/

---
Peng Fan (9):
      dmaengine: fsl-edma: unregister channels before vchan cleanup
      dmaengine: add a bus for DMA channel devices
      iommu: register the DMA channel bus for IOMMU notifications
      dmaengine: move channel devices to the DMA channel bus
      dt-bindings: dma: fsl,edma: add per-channel child node support
      dmaengine: fsl-edma: use BIT_ULL for 64-bit channel mask
      dmaengine: fsl-edma: use dmaengine_get_dma_device()
      dmaengine: fsl-edma: support per-channel DT child nodes
      arm64: dts: imx95: convert eDMA to per-channel child nodes

 .../devicetree/bindings/dma/fsl,edma.yaml          |  70 +-
 arch/arm64/boot/dts/freescale/imx95.dtsi           | 774 +++++++++++++++++----
 drivers/dma/dmaengine.c                            |  49 +-
 drivers/dma/fsl-edma-common.c                      |  10 +-
 drivers/dma/fsl-edma-common.h                      |   1 +
 drivers/dma/fsl-edma-main.c                        | 225 +++++-
 drivers/dma/tegra186-gpc-dma.c                     |   1 -
 drivers/iommu/iommu.c                              |   4 +
 include/linux/dmaengine.h                          |   4 +
 9 files changed, 979 insertions(+), 159 deletions(-)
---
base-commit: aaa2f954c21b205a0bcd0961e5b2be4e82e58455
change-id: 20261102-edma-iommu-v3-22b673717cf4

Best regards,
--  
Peng Fan <peng.fan@nxp.com>

