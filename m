Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.159.27
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793601947;
	b=rv7jD0N72G4B9Z68YG7kRAioG0nHz1Y7svRko73EyyKSAZId3cIMW6PoBIX/nKfAN2gZ
	 oLPvQUo4hvLLgg1IM/jictP4h3wGYoO02zoDJjnNF8SP0CrLpJ7kRgQnjRAhLIA9JuKEl
	 xYINJ3IaIemrn6xIKCgmPV3g+Pr2P32tu0Q+HcJQbDViUyT4tGjYwvEU9zNDL89IL15/X
	 9ZP4IaUIqS1sIb6zXISIFPP8Wh/14WpFo6X5ZKT1VLwYMwdCCy8Wli9Ajsf/PMj53s2F9
	 bvGmvlKkYsiL2+2loEylO1//PzuJQ/oMM3aEIaE2RqhosUksLtx2rsekGBFERHKe1MA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793601947;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:Date:Subject:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-ClientProxiedBy:MIME-Version:
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
	bh=BORkiKznHE8MPAcjptr5w+wXFA2ADo+t+dbs2bsP3zg=;
	b=WSgpAWQsNo0osqPlTNQba0h0GQN7cG4nNcpwLizNNgC7gHXSCg8BLh1aAhGfgA6VsdFQ
	 cVb8zV6B8g2dNu2ztRUomsXbdh27lLOAS1i0lN23BobP58kGxydaAERRja5thiV2Bmo4t
	 GZgYCRCBsnrICqNZtge+0JAWszURM8W8Lt1QwW98x79h15Cw3iy9m8gFdLhTDdH8RK23g
	 YCGYfmi/TzQbmAIDxKc8uiqyZACJM7Tjftkip6QYo6cRMEHNZbLgwMCykLoINGavSZgrX
	 DcmyPQSFfKSTz2BvHWcpuJtg5aWOWjg4VkME7kS3UefpwUoQkzExHtmHgt+nAsyVbLQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=qR+pb1w2;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.159.27
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013027.outbound.protection.outlook.com [40.107.159.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56627606A332;
	Mon,  2 Nov 2026 06:45:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 56627606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=qR+pb1w2
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qPhIY9n1T8+CgL0Md6o/t7fjd0Lp8q7C6rdKwjkEp88uOtCHeD1ivmdfBMWBwPB+ZPIhoFhE4Bp7bIKr0RJV4CK80RqcZ8aWl5x5/vjgfI0EmF+yNsm1hsvkGk+R5GrM1BuDI50F/qHaQ6/q7L/1yQM8uuRWyc1Ltcj4FGyVYlm77Ll6DX6WKdIBCukUe49dKB3lGETpQ1JAuhAW+vPGtcHMPpIeuUyeiclf1dFsbXGAHqGh7V5upmo3Rnye9JzGIVnKYccBrqloryT5Mczxu2NAz/7gBKQRl2GFcoNsYc0HyUOhbWEm9FrL1YSzENqnE1E13YsTlSm3Nk2HxQDgWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BORkiKznHE8MPAcjptr5w+wXFA2ADo+t+dbs2bsP3zg=;
 b=DDEYw9ARaJs37A8vws6bf/JNR4S2O/Ax4lX2AOHa7DW6Sp2ooshwRklFSCZlfwq4aOivdv1x8K+YggEupD+aAqHWuBmaJza7+mf6O0Nh3WKySYdUyheMtkg2FIUiFhFmHlJEBeVLdzNNwvWjDClwD8iu4m1rVstBAHWvtjzgEr109lSOhgiMkfRiQ0NZWZWoOld1s00mgB+Ob75QSuv871/6XwZsBQFPnU8j7qWzhD34K/JFiDI3exL7O7VE+ZDzxIbOBudMYIN3vdJtvyrGDgX4ZeG7ZAml8Syx31KrANVN/qEgn4BVPy2wF8dhJ7gWdVP+lfxfxuWJBSK9K9qb4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BORkiKznHE8MPAcjptr5w+wXFA2ADo+t+dbs2bsP3zg=;
 b=qR+pb1w2waxGkmbpYRXX1SP2ooRsmIzUmY6m8byVR4a5Q39BbY2agiDnYBVEQDqCbj2OR81k0LnRzlevHSM0zc5alkfggGrQwoGgh3QiFapbRgvoHs0SJm4boRjqsyWq2X2OWQuVplMalFDGyq0OFN5z7SLo/C7nZGY8II2kXvJV/ByFj7dadbGt3g12QL9WRuTgRkQs/wlbXXLRtEUgOZFSR5b3YrW0NnKBFHpEtH+ikc/PpMHCRCH6fg2gXIYksG5Ztm2SJLt/vxDlfV5CDaCNPSo38iW9JLSssfJI3VHGXu4a7ChTrZJbi3IAE5KVaBuGzoILhP3/Ivhry0C8uA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by GV4PR04MB174932.eurprd04.prod.outlook.com (2603:10a6:150:418::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 06:45:43 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%6]) with mapi id 15.21.0569.011; Mon, 2 Nov 2026
 06:45:43 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Mon, 02 Nov 2026 14:49:58 +0800
Subject: [PATCH v3 4/7] dmaengine: move channel devices to the DMA channel
 bus
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261102-edma-iommu-v3-v3-4-9d0e62a954eb@Example.Com>
References: <20261102-edma-iommu-v3-v3-0-9d0e62a954eb@Example.Com>
In-Reply-To: <20261102-edma-iommu-v3-v3-0-9d0e62a954eb@Example.Com>
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
X-ClientProxiedBy: MA5P287CA0133.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1d2::7) To AM8PR04MB7874.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|GV4PR04MB174932:EE_
X-MS-Office365-Filtering-Correlation-Id: 5db0af11-03e7-47aa-669c-08df38acea70
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|23010399003|366016|1800799024|19092799006|921020|11063799006|56012099006|261009223027099003|261028144727099003|261022105027099003|261021121427099003|261021123027099003|261026140227099003|261022075727099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	EsBiu4jnaGk9NiUrETr60MvIXwqOVyaKzKpCMv7A3vaHfFhCAYLEvA8kRNe3SeOPc+t1UQuzTzYIc+8GVL2dSDeAqE/XtsPWhTnHTJzM5Oc+00V2sPg4d7NV/yPyylrk7Xy1+7vlQJlHl1+fWoE7iigIxlgTS3uVWhjxsurmktcXT6p7OiAogvhfZZgeSR29Q9S1R68O0BtK2yKiqqMocRQNsPx5ISKmhjaqz6D81QWwGBKzeRyGkZ64+Svdew0ROt45Ph5Xk+h90HlfVEJkB9hKOAe7+ZQQEQA+/wF9bxo/N3pZxyEVmnVZpGUzV5SSQzPbzTh7230hXlP8B/QW20F4HC1cAW6rtgRxxf9c7uShHHb5UlYqa0Sbo7W30Jzrqsvkf11mWPuRiyNBKqzTpswM+xkROkNeuCHlhZpuciAO/0oeHTE2gB+7S+vZn0JC6dA5Q++CqS27beiomRJCKjIKhLP5nDCIyUag4xG7ksMXsMMUTovwvT8X49Uq/T18l64kHlV+IY0hnpzFwe2OhrJjTZtR7P74RFZFrDnLkma7HRCB12QQ/R8CzRdhlHOXCCFbZxm8xvbzg06FftWkNq46rXMnxHsUvk1vwVFNYekv6K7b99/n87ed++OkdVKUOSIZ8VCJFs58dojC5XlDrsHzkqTXfUxGKBsek0z7mCfIWqrCD6VMbOrnxvfJzq8X+cO7CCrR1pAJmDvCpvWrKQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7874.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(366016)(1800799024)(19092799006)(921020)(11063799006)(56012099006)(261009223027099003)(261028144727099003)(261022105027099003)(261021121427099003)(261021123027099003)(261026140227099003)(261022075727099003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L1BMT01jZ3dMRzQ0ZVlkSmN3Z0I0djVLNTFWTVdwaHpkVVVoYjV1Rm1JRVh3?=
 =?utf-8?B?NFl0TzZyeCtTcWtWb2hseGNKU3RKWVovY244UU4zTy9wcUE0bmZMaHluMlh1?=
 =?utf-8?B?U0pXK2tRSTVSVnBzVlptQjRhd1lKbUpjMGtvdUN1SXlnUXpxN29kNjFsUHgv?=
 =?utf-8?B?bXNnbG95TC9Gc0ZjeDdqeUt1Y2FKUGxIT0VpczRaS1FUTjR2Nk1PbmJkZllF?=
 =?utf-8?B?WTE1Z2ZNNGtJQjNiNktTN0lWOEo4cVFtUkM2OHFXS2poSC83bXBxMFFSdHRV?=
 =?utf-8?B?OGcwNy9zUFZVR1B3REZGY1RPSHFqRlZ3dXFoK29FWUQwdVNDc3k1M20zZFB2?=
 =?utf-8?B?ZFY2YnZDOGhkN3p5ZTcwVGxTVDFxUlM5VGNTK1dpVTBES1ZSUk1NU2xjaEpu?=
 =?utf-8?B?VXBEQkZhWHBPZWM1YkRZbTl3SXFva2ZpaSsrRDdGTnk5MlhFM3MrS3FPbjBk?=
 =?utf-8?B?djE2NG1MbzNpNTBWaWpSblpTaWEwY1ZEVk1HSEx3MGsvQ0gvczFwTEg3NHY3?=
 =?utf-8?B?S0tKQzM3VStzVWo4OXhMV3VpUGV0VllucGZhZmFJbC84K1dmWjI1UHZjYk5Q?=
 =?utf-8?B?RlQrOG1EUEJYTStjRUU2V0UyR1VXeWkzMytGSk1IRmZlWUhJanV5Q3kvaldM?=
 =?utf-8?B?T2dva0VHSWVkWlVjZzAzL2dDZnM0TjhlcmlkOXpMNm84cFVSK0IzMUo2R3FS?=
 =?utf-8?B?RFVDRm5RdzhGdjNsZWxKUjhPSmNnbGVPV1VQaWVrUGdEWHBXT1RnY3VXSFZr?=
 =?utf-8?B?eTN1YkpkakVQOTI3TUs0L29uWGNqUm5PMlJzVXp5by9TM1FDOG1uOFI4VzZs?=
 =?utf-8?B?WWl1VGFmL1NadC80RmVhQ0kvMis3V1FkdDg0TEg2WW1DRXhnTCtCbjE1MjdQ?=
 =?utf-8?B?Nm5wcEkrNjFDZjVJalJvSlg0cVIvcFVkK2R2VG1LRWNZTFFkeDdwcjdDU2Zu?=
 =?utf-8?B?YjRSZGxCUTNHWEdGR21wRUxpTXFZYTRIUnl6UWpBbjltMWJSazFVUTZVZEV2?=
 =?utf-8?B?NTVCL1FpQjQ2eTNndUhFNGRwVEJUTGRKbUcyQnFQb0I2VlZiLzRIU3N0NGIr?=
 =?utf-8?B?c1BOcHVXbVFLQTNxLzJMdlJYMXBCRmFOVm1BYjFIa0dKVFA2N3JPZXI0eWxu?=
 =?utf-8?B?Vk1wRkh1b0JnN1JIN1VTb0JvdEhHUVNKcEFNdzFYaTZMZVdpTTlqd2I5Qk4v?=
 =?utf-8?B?SmFLZjN6ZGxOSWc3UnpFSmVUY3hIK01kUkVIcVRsaEM2bm5wOUs1azR0dWRo?=
 =?utf-8?B?OHZvYnJjZTk5bFBxUHdGcUVyTEozKzJqUDFwaEpOZloycjZ6a3BSSGRXVk5X?=
 =?utf-8?B?Sy9VVDlZdmlRRGxxLzRPU3Q4VHBzZ3oyRlFSMDJuWnc1d084WkhyM1M5N1d0?=
 =?utf-8?B?Q29SL0NZa1NCV0xra3hPdjBBQ0N5bnl4aUVjeWgvYldVM3dobHByOG15dTUr?=
 =?utf-8?B?MUVDdHBlUmhDdG9lYUxDY3lTOElPeDNaL3ZWUlBkbnJIZ1Q2VlZyOUtTYWJh?=
 =?utf-8?B?cVgvc3JZS2M1M05EV0NnM0l6L0czSC8xanBtZFVxSW03cVNobFhZZ2t3alF0?=
 =?utf-8?B?dDBvQkhZeEo5OHZCZjlyT3dQZE1ndlFjQnEwQWFwUk9mOC9KZTRzaDZpNjBB?=
 =?utf-8?B?MWVvTS9Fa1VNbzVJSmRYZFZ2amNLcWxKdDdHMDJXM3B6UyszM0ljNmZZRVVp?=
 =?utf-8?B?clBQMGdXaHg5dDdERFNBSHNiZHNRQ3pEcWxUTVQyVkVYTzZKZE5PMlB1UVJs?=
 =?utf-8?B?SFVrUGFOazhXQTB4Z1dWdVk1Q1NNck9kd2FlVEJRUUxMWUt2UjU4Q0kwVUVL?=
 =?utf-8?B?ekRkL0FUeDcra0VLWXhlUnEyWXNKU0o4Z3hvTjMvSzBDMG05Vml6eWJqMmoy?=
 =?utf-8?B?SGlyRGtsZHRqdVRPV01mck1QVm5uRUptdmkxdVlRRXpORlY4U0xGQVppVlFq?=
 =?utf-8?B?dHErbHZBWlg1cnFCT2FseUVmT004dVM2V0VQQndlQ2ZzcXJ4bU1DMzZiekU3?=
 =?utf-8?B?VWgreEtaR04zbTlrd3JJL1pWZU9iU2htWGZ5VFU5VjFLVmhaRDBkRUhKSW5k?=
 =?utf-8?B?UWpBdmN1U3ZUVDlFdHhEU24xNktOWGtPL0wxZkcwNGVrcjZBeHhLNCt0dTFD?=
 =?utf-8?B?b1ZKY1JaS3JNUExvZWFENncvN0tNN1NuZjhCSm8zbXZseFNZYUZ1TnZuaE5u?=
 =?utf-8?B?QWhsa3FucHhvMkJTNmI5U3lrczZURXhmSDB0M0w0V0tOM0dNNm5VdGRWSFhl?=
 =?utf-8?B?VWJGOWFjekxmK2w4SXRMZkZJT0RRSXQrbVRVTnlJS2VpQmxRaFZWMmkvRTNt?=
 =?utf-8?B?WjlrcVVsWEpQQ2xFQS9PMU9qamhzRXVURGlNVkNkbWsxOXZGa1JLbHRmb0VD?=
 =?utf-8?Q?m98k8q82vvbF3EIkFvM82NYm2CF/RAQ1RwxUj?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5db0af11-03e7-47aa-669c-08df38acea70
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 06:45:43.4931
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F7qUjktnzFg4j0vsB36wlVOmgpv2bgAlOWrXo2rwCdN5vgQjcWGe+PB7rYdsJlTeiKOQZOZgq+NtgLgTPlcsSZLucyTuE4/MQuGEEHYkCdoi7J5SPcWV2kCa7Pe++RY7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV4PR04MB174932

From: Peng Fan <peng.fan@nxp.com>

Register each dma_chan_dev on dma_chan_bus_type before device_register()
and make it a bus device instead of a class device. Setting the bus
before registration lets bus_add_device() take the bus subsystem
reference, so the matching bus_remove_device() calls drop references that
were actually acquired. Attach dma_dev_groups to the bus and set the
device release callback directly.

Keep the existing /sys/class/dma interface by registering a class_compat
named "dma" and creating a link for each channel device. The channel
devices now live on the DMA bus, while /sys/class/dma/dmaNchanM remains
available to userspace. The uevent subsystem name stays "dma" because
the bus has the same name as the old class.

Remove the post-registration dev->bus assignment from the Tegra GPC DMA
driver. Leaving it in place would overwrite the bus selected by the DMA
engine core and reintroduce the reference imbalance.

The DMA channel bus match callback never matches, so no driver can bind
to these channel devices.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/dma/dmaengine.c        | 27 ++++++++++++++++-----------
 drivers/dma/tegra186-gpc-dma.c |  1 -
 2 files changed, 16 insertions(+), 12 deletions(-)

diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
index 6fea67f088b35..0e2eea339f1ce 100644
--- a/drivers/dma/dmaengine.c
+++ b/drivers/dma/dmaengine.c
@@ -239,11 +239,7 @@ static void chan_dev_release(struct device *dev)
 	kfree(chan_dev);
 }
 
-static struct class dma_devclass = {
-	.name		= "dma",
-	.dev_groups	= dma_dev_groups,
-	.dev_release	= chan_dev_release,
-};
+static struct class_compat *dma_chan_class;
 
 /* --- client and device registration --- */
 
@@ -1115,8 +1111,9 @@ static int __dma_async_device_channel_register(struct dma_device *device,
 		goto err_free_dev;
 	}
 
-	dmaengine_chan_dev(chan)->class = &dma_devclass;
 	dmaengine_chan_dev(chan)->parent = device->dev;
+	dmaengine_chan_dev(chan)->bus = &dma_chan_bus_type;
+	dmaengine_chan_dev(chan)->release = chan_dev_release;
 	chan->chan_dev->chan = chan;
 	chan->chan_dev->dev_id = device->dev_id;
 	spin_lock_init(&chan->lock);
@@ -1128,6 +1125,11 @@ static int __dma_async_device_channel_register(struct dma_device *device,
 	rc = device_register(dmaengine_chan_dev(chan));
 	if (rc)
 		goto err_out_ida;
+
+	rc = class_compat_create_link(dma_chan_class, dmaengine_chan_dev(chan));
+	if (rc)
+		dev_warn(device->dev, "Failed to create compatibility class link\n");
+
 	chan->client_count = 0;
 	device->chancnt++;
 
@@ -1172,6 +1174,7 @@ static void __dma_async_device_channel_unregister(struct dma_device *device,
 	chan->chan_dev->chan = NULL;
 	mutex_unlock(&dma_list_mutex);
 	ida_free(&device->chan_ida, chan->chan_id);
+	class_compat_remove_link(dma_chan_class, dmaengine_chan_dev(chan));
 	device_unregister(dmaengine_chan_dev(chan));
 	free_percpu(chan->local);
 }
@@ -1306,6 +1309,7 @@ int dma_async_device_register(struct dma_device *device)
 		mutex_lock(&dma_list_mutex);
 		chan->chan_dev->chan = NULL;
 		mutex_unlock(&dma_list_mutex);
+		class_compat_remove_link(dma_chan_class, dmaengine_chan_dev(chan));
 		device_unregister(dmaengine_chan_dev(chan));
 		free_percpu(chan->local);
 	}
@@ -1650,8 +1654,9 @@ static int dma_chan_bus_match(struct device *dev,
 }
 
 const struct bus_type dma_chan_bus_type = {
-	.name  = "dma",
-	.match = dma_chan_bus_match,
+	.name		= "dma",
+	.match		= dma_chan_bus_match,
+	.dev_groups	= dma_dev_groups,
 };
 
 static int __init dma_bus_init(void)
@@ -1665,10 +1670,10 @@ static int __init dma_bus_init(void)
 	if (err)
 		return err;
 
-	err = class_register(&dma_devclass);
-	if (err) {
+	dma_chan_class = class_compat_register("dma");
+	if (!dma_chan_class) {
 		bus_unregister(&dma_chan_bus_type);
-		return err;
+		return -ENOMEM;
 	}
 
 	dmaengine_debugfs_init();
diff --git a/drivers/dma/tegra186-gpc-dma.c b/drivers/dma/tegra186-gpc-dma.c
index e76c58f213d84..71a935d873868 100644
--- a/drivers/dma/tegra186-gpc-dma.c
+++ b/drivers/dma/tegra186-gpc-dma.c
@@ -1541,7 +1541,6 @@ static int tegra_dma_probe(struct platform_device *pdev)
 		tdc = to_tegra_dma_chan(chan);
 
 		if (use_iommu_map) {
-			chdev->bus = pdev->dev.bus;
 			dma_coerce_mask_and_coherent(chdev, DMA_BIT_MASK(cdata->addr_bits));
 
 			ret = of_dma_configure_id(chdev, pdev->dev.of_node,

-- 
2.34.1

