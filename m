Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.69.46
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793361897;
	b=4zbYudz7kkK/Got27JCeu44xcCUO4+2w6w2OGd302jbJiqJbmqqUA+SQiKzzslBAMRzr
	 ofONbDoG8gO03LthBwqBDRV6yfZsLRFtU7Dqh/FdVpjKQ7F0G0b9PwdSCAzTj9TPryw3v
	 rweAhpj24DDbKmSgEVH/xhX7FY0Ibw6DobVcYEQCqyUW4sDB9zdV2m+NnnGacXQtSPt8a
	 4v58D5N8Bnkg9XE9tlVfRZna0vbbwyR0KJsaG/TyyLw5sJ6bHkfJq2fA8RgsrZ+DPrfvq
	 6DtNympUgjoPQmydtNZnrNASF7165ZelxzOOkND9Ki6yrosJdic39m9x/qXxH+U8COQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793361897;
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
	bh=wus2LnrrFPfJ9t8FtVxAdkHlnrePP1C973VJNFRjdkc=;
	b=BkM6UO5aOIZzMCEF0QAGZuh5j0h+uw4m5AYwmT4IOaUxYl/PKGngIYrXRZqhy0yGstvF
	 bW3u9mNvDer3dSG2NOQJWWZLufUbDytFuION7mA2SqNWD1X4jU/+4jO/FYfd5vg4Ld5ma
	 UxUIdxW6C1pGK8Uuy8Vck4sLtGuQlxWYg1/h+AGfde4WdkkHOW27UuyZIUxGH5fM1Z9nt
	 tNkNQS5XpKdY9WcQIPM1FD49bscJNkyjkth+YMN9rvSBGLzglKWZON2gzK4l70eKN++Bk
	 z0K75NC8fwjHkaI4buvISEgANf1Sl+ofS7ezcOP+htF7HG6WP6dq19X0/wQopzwBhTw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=K67ZBx6m;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.69.46
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010046.outbound.protection.outlook.com [52.101.69.46])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E99E2606A31C
	for <iommu@lists.linux.dev>; Fri, 30 Oct 2026 12:04:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E99E2606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=K67ZBx6m
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K4ErD155/OK415lNbjAF+xOZAkgbv4iReCeIFCWTny0YOZEUVszwjUCaBFS+fll7jdSK+6eMYrGP5Zt8ErXvWq7BTi9ipHySzttN+te1om7Kagpb3PH6AdVvmRR2+aqJseE5yvoG/u7Y1enwSAZBLSl2gC0nIQOEX48QnUiud2H02jJwcrY1CGj8RvxPfV2AevjOpx0pzqZt5daghwL/sPukivaBJztLrHOMYjTOlVmXvpvb+t/TzkzhoDHH7M40VuKN55aZV2L5gVjnsGI4XEmFfpXGgVFnAUYmPy1NcwcBQ9DwqmWfdJ3aArkNfLis5Qzan7FqbGyNg33IHHondA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wus2LnrrFPfJ9t8FtVxAdkHlnrePP1C973VJNFRjdkc=;
 b=BqadlLIuRuKV+LqbafXo1FzNLROS16Q0WrJPH7WN64VgEyQmu8MkLCYtHoEtqHEfJ3q2Y0skWifZbyo68rD1SL62mcUI/uklgTC+vrBuAgi7c6lslcQRMK+CWJe8SArUxFlfwU4etABRcOmTbsPyAbFVhoVND7Ds8r403HJ2rSdCLl2M5LtYHJAZ67khhH3QmZlWoHiyYLABN8H5Bqc4PvrcWZ8sWIz+OoRzUz1O1qDnAi13apkVEI2tH/k42liRwLkEmCXA0pVzKi5rRf8RRuEE/u9a5grJFfERx55R5iK7OjhX66A8z1xz1PRi6fWVVZzbA5u5cwc+3h97XQR6Yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wus2LnrrFPfJ9t8FtVxAdkHlnrePP1C973VJNFRjdkc=;
 b=K67ZBx6m7husQTcb3dIzC5UGx659ee9tXpWAWxslB6xifzU8HjsK7Sq1nBwgCm2LGHcO7H8WdAPe4jaDJuW6HqgKpLsnjS+HvAeHZS8iy2to/xbnMUtO+K1dTVu1ekdgSdTNBBVnu+zlpjgFnAbbjphWU459nF3b004soWx2Gi7uF60sEg+L+dJR1oY3PYcZpJ7KTwb5quUSwx1nI7acJl4NmAlVqZSszvA2ZlT3Hq1W0vBg/Wy9P8EHmqmN1AFgFNGkTMJ5iWm64lrRc0JP9uJ4OUEPQ3Ao8ckhEGJGMcVQJrTWnRW1hkLpFQ9T+1/hIqIZC/7M9uw+q1HKhwld0w==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by GV2PR04MB11301.eurprd04.prod.outlook.com (2603:10a6:150:2b2::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.9; Fri, 30 Oct
 2026 12:04:52 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%6]) with mapi id 15.21.0569.009; Fri, 30 Oct 2026
 12:04:52 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Subject: [PATCH RFC v7 0/7] iommu/arm-smmu-v3: Support shared Stream IDs
Date: Fri, 30 Oct 2026 20:09:32 +0800
Message-Id: <20261030-smmu-shared-sid-ver7-2026-10-26-v7-0-961726ebd6ab@Example.Com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPyI5GoC/yWNwQqDQAxEf0VybkCXpWt7FfoBvZYeVjfWFNSSV
 CmI/96ohxmYGXizgJIwKVyzBYRmVh4HC+GUQdPF4UXIyTK43J0LE2rfT6hdFEqonHAmCbitWOR
 o7i91LH3wbSgdGOUj1PJvf3jA/VbB8yh1qt/UfDc2rOsf7TJh+ogAAAA=
X-Change-ID: 20261026-smmu-shared-sid-ver7-2026-10-26-49ba8474f782
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
 Jason Gunthorpe <jgg@ziepe.ca>, Nicolin Chen <nicolinc@nvidia.com>, 
 "Joerg Roedel (AMD)" <joro@8bytes.org>, 
 Thierry Reding <thierry.reding@kernel.org>, 
 Krishna Reddy <vdumpa@nvidia.com>, Jonathan Hunter <jonathanh@nvidia.com>, 
 Jean-Philippe Brucker <jpb@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, 
 linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.16-dev-7bc12
X-ClientProxiedBy: SI2PR02CA0037.apcprd02.prod.outlook.com
 (2603:1096:4:196::8) To AM8PR04MB7874.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|GV2PR04MB11301:EE_
X-MS-Office365-Filtering-Correlation-Id: 09815ec6-e200-481c-2875-08df367e00bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|19092799006|23010399003|7416014|366016|1800799024|18002099003|11063799006|5023799004|56012099006|261022075727099003|261022105027099003|261021121427099003|261021123027099003|10067099003|261022113327099003|261021135927099003|261009223027099003|261026140227099003|261028144727099003|261026121527099003;
X-Microsoft-Antispam-Message-Info:
	LkarDF0iQ9f6vc1HYr1APfaLW0R3JY3c84dT7CwuKshuD4us6Qywtt6mhy74jWnwHV36WDwQHiHE68rkM6BBF0vRUfiJuc9PuptSc4wsQ8NfVZ+YpBCNh2WRS3oknw6aL65lkRmJ2dCMuzmgFlLwYFsynfLsUXp4NFW+SiIPuyDhI2Ytv7Ny7w8Ph3VpHADRMe5ydgZJEPhUwFSo4ZD8dyae8nTChOwzLA9qplICrM9jPiILPCQhfMHymvzCIlfg87LgOKLFXKG2YjgMT5eqlFx17vw/FEDvCYdxm1ADZuvq0xp9ibMMjsPrxQdjZS99PEEWDNhT1f3nsvPYMtgO4+oaD/lyfdv5SOvuqPk8m/dCDR2oJ9UTKKwTp9Mv47FZ4RUofreHVGkeY86YLD35MGzqeXeRDDJcSHGVYjDvuXspjEiOSLst2fhov+gaDk+uYgX+0bsFJzpl5vyS5Z7hOdWgLB77220La+9xHSambWpiUpsR6q9652FcJ4kkwDLX6kAVfXYlwTwCsU34JqDU6B0Ze/AYiigKPQyTn3Or17F76N0V54Y8zu5eJM4dMLQP9mwBtxE111X7FIg353TvjRyjoWAIG5CKuAZCjOQzzxDplOPnO6uD4O1sCzVlgfk4
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7874.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(19092799006)(23010399003)(7416014)(366016)(1800799024)(18002099003)(11063799006)(5023799004)(56012099006)(261022075727099003)(261022105027099003)(261021121427099003)(261021123027099003)(10067099003)(261022113327099003)(261021135927099003)(261009223027099003)(261026140227099003)(261028144727099003)(261026121527099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OWdlRzhEZUhQTjRLSTFNTGtjMkxRREhTZFpxclZFOE5yOFVrM2NjYi9mVEJ3?=
 =?utf-8?B?WnR0Q2NUeGlDNlo3enkrYlVCaERhdUEwZ2JIdENlSlhqdVhBN2FnRTFkaEZk?=
 =?utf-8?B?Yi9TWGtKeUlHSUV5TWhyUXRVN2hUVGZkMmlQZjE0Y0VnNEpnRGlOZGh2VEhJ?=
 =?utf-8?B?ZnJxTitLK3dadDJTcXJjbFRLS3ZUTTJVWVBDL3NOZ056UXRDM2xnSUpYRVhJ?=
 =?utf-8?B?WUJDK2JpMGNjTHFiU2RKWjdveW0ycFRHa2VNS2l6c05mckg2QkJrbE9Md3NO?=
 =?utf-8?B?RjdVYVBzUjdDQW9yQWM0S2l5U2tuUHRjRlRhQmU2emhQYUxIK21BdmNaWGYx?=
 =?utf-8?B?RnlDWTZOQUNBS3pEZEtIaTRrVUdkT0tTNkdCeGlaMkN3WGFBQ09yZHM3dnBZ?=
 =?utf-8?B?UGIydVhhZGw4QmJHQnRuajBvYXI5OXpReGZHdnlTS0VGQnhEMDB0cXFNVS8v?=
 =?utf-8?B?S29QRDN2d1QvRk8vZllqMlRRYll5R3l4RUdwa0k0S1NLdUgrS0dBVnc2VFhJ?=
 =?utf-8?B?Ryt3QXlxUXhpTE0rZS95b29LZEpVVDBjQk0wbzNiZHBuMmxpckh0Q2o0U1Yx?=
 =?utf-8?B?eWJROGducVl4MkUwY3p1cmRqVEU1Y3dRSGJjRmp1K0pXWWVaSm9zN0FNQXgr?=
 =?utf-8?B?Yi9UcnF1cFVvTWRWVkRONi8rd21qenljTFEwNFFLUDlwdk9BQzlnSHJFazBP?=
 =?utf-8?B?VnB4WlR2NGQxTUcyOGZUcUREV0VkdU9tc0gzWFVweXJCVjFLNkxubzR5RWMx?=
 =?utf-8?B?bWFLTFllRTVPb0tzeGkvODNnQTV0dVMrVW5QTWlWWjhkczFLdmordGd3UTFP?=
 =?utf-8?B?Zkd3NUNHRHFyTzRERXJpdTdmRDlVWXI0RFhmZ1RLVEVjczhHOEJFcUlzZjNk?=
 =?utf-8?B?Y2dsd0IrZFltc0VuQlovbVJVUURxOWU0eDg4NDNSenZLczBDWHc5VWthNzRt?=
 =?utf-8?B?TnJDWnlKbFJHNFBrZUlpWTBDWG9Zb1B0UWswSjRabzNpeW4wMXkrYTBFL1BN?=
 =?utf-8?B?c3ROSEx5Z2pWVkR1UUE0cTI5am1EaEkyaDJEc2RHRkZ3Z0p0ZkRLcmhyaS95?=
 =?utf-8?B?Q2oxbTZoajV5SlFVKzVoeFhUaHh1U1l2aTBwZ3BYeDh3YXMzOVR0SFFIVGow?=
 =?utf-8?B?YURPeVdkS2xCeS9DREFKb3kzUTQ4TU0waFlUVmpwSC9hVG81WHJERDZWbkl0?=
 =?utf-8?B?bXNVVHc2cE5hYnU2cVFaTXhsQU1mbXkzKzdmb2YveE1UME83VGVmcUdCOCtZ?=
 =?utf-8?B?cklEejNHNVVwaTBTVkVOSDhqdjBmQ3dnVmNoNFRrS1pTdGN0ZTRFaFZKUlZK?=
 =?utf-8?B?bzJqNlFMVTh5bTFQSXo2VmR5cVRXcUxVWVU5L2F3cnVOVjRYQVJYZTMxeVJw?=
 =?utf-8?B?NER2WkhzQmh4TTg3NU14S2JxL3FtQm1rSG1NaTh6dWlMZDZ1MTdXaVduUlZ1?=
 =?utf-8?B?OWo5RnJCd2hpc2t3OW5VR1hqVHEvN2k0ZlJYd21EK2dFQWxXd09ISWEzMHIv?=
 =?utf-8?B?cXd3Wm5jbWwyVjliRUtMS29LMWRGM3ZVb0hrTUdTWXN0YUR4VlZxZkFGdXJz?=
 =?utf-8?B?OXJZMGxBeVJTUnptL2JWL25kczk0SCtyeWZ4S25haHpSNFc4TWNMY01FNWQx?=
 =?utf-8?B?RVpzeU5uNnJCaFBLZzJvRGZCZVRaQkJmTVR5ZS9NeDlKcHB2M2wraTNnV29x?=
 =?utf-8?B?TXBud3FKTGtkRHdXNUd6b3ovdWo5WFVVbldEYitRRVB4UWxHMkc0QVJCVTZt?=
 =?utf-8?B?VlNnQVVlcklVVW1Qc0VYSUNaRE5Xc2hUQ2J6aXlnZFRMTVNUM25zMEkyamxW?=
 =?utf-8?B?b0ZiWWtzNzgwVFV1MjZIWE9EUk1KRlV6bkxPN3VVTkZ4TnZnRjVPVkhVS2ZR?=
 =?utf-8?B?a3NVbm5Kdlcrc1JoampabW1sMk9OaC9xRUVsMGxpTitJMWZ2cWZOUHRZUDgv?=
 =?utf-8?B?WTdpL2xEdy95NkFha2VoNHVHczhlSUhQYWtvSFVFUUhOY1NXWkl4NEErVDN2?=
 =?utf-8?B?Wm1HMmtIc3RGbW9QekltemVjSWNXTWhQVUZrTHRDSU9JVjRqaFM1T1hSUFA0?=
 =?utf-8?B?VkZ4NkprZzJERGUrNUwzamowMVFVY0w0VkdoOWNSTGI5MXQ5K054Q2ZHK292?=
 =?utf-8?B?S2lpcHA5U01nQSthdHkrT1dWNExpUGw2UysxSjJ0OHRUbUtNR3RNQmppL1g1?=
 =?utf-8?B?VUdoMFdnajB6eGdWN2ptdnNtQnlyczBBSUJ6SDVkSDFOK2JhZ2oycklxbW1o?=
 =?utf-8?B?ZTZUVGJXeDRRM2VnZm14ZmFWZHh5dGFzZWZOdUJsT21kRjF0L3BYYkh5N0ZC?=
 =?utf-8?B?K0JXTEE2WGU0dDcvSTFGbEJzVHFxS0ZKM1N5Y0pUNEl5Uk5wa1g2NU1KeXJ0?=
 =?utf-8?Q?08tZE1JrrnO67kVT8h7PKrfcTCG51OpntqMHG?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09815ec6-e200-481c-2875-08df367e00bf
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 12:04:52.0980
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7OxrxYx6yBmIBWrHCFl3KxU7YwnXpeRsMTTs/sbzLvxicJWFGTbNwKTEwAyJ3NQhnYi920SzNQw1pxqKrRpL/6Ogwjvl/j9iQVok662EokumcYbKyMewbckMqzgFO47E
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB11301

Changes since RFC v6:
- Add "Plumb the CD table into the CD helpers" as a preparation patch, then
  introduce a per-domain CD table for non-PASID S1 streams. Normal non-PASID
  devices in one domain now share a single CD table; private tables are kept
  only for PASID, ATS-always-on, and stalling devices.
- Rework shared-SID STE handling. With the domain-owned CD table, all sharers
  build the same S1ContextPtr, so any sharer may program a normal domain STE.
  Release/blocked STE writes are skipped while the SID is shared, and the last
  master tears the STE down.
- Keep CD.S per-device rather than deriving it from the SMMU stall capability.
  Stall-capable masters use their private CD table so CD.S, STE.S1STALLD and
  STE.S2S remain consistent.
- Add arm_smmu_master_stall_enabled() and use it uniformly. Reject sharing if
  either master wants stalling, and resolve the stall policy before
  insert_master() so the incoming master's policy is visible.
- Reject sharing when the existing master has ATS, PASID, or stall enabled.
  Disable ATS, PASID, SVA, vSMMU and IOPF for shared SIDs.
- Link to v6: https://lore.kernel.org/linux-iommu/20261011-smmu-shared-sid-v6-0-cb76b89dc612@nxp.com/

Changes since RFC v5:
- Actively deduplicate Stream IDs during insertion instead of
  storing duplicate pointers. num_streams now reflects the unique
  count, eliminating pointer-equality dedup loops from all cleanup
  paths (Robin).
- Extracted arm_smmu_find_stream() into patch 2 instead of patch 3
  to clean up the find-before-allocate code (Nicolin).
- Extracted arm_smmu_free_master_streams() helper shared between
  error rollback and arm_smmu_remove_master() (Nicolin).
- Fixed remove_master to reassign stream->master when the current
  owner departs, preventing dangling pointer (Nicolin).
- Fixed remove_master to use a for loop iterating master->streams[]
  with per-stream shared vs non-shared handling (Nicolin).
- Reset ste_installed on ABORT so domain transitions (e.g. DMA ->
  VFIO) correctly re-write the STE instead of freezing it.
- Clear stall_enabled on the first master retroactively when
  sharing is detected in arm_smmu_insert_master(), not just on
  subsequent masters at probe time.  Prevents bus lockup when
  the first master probes before sharing is known.
- Link to v5: https://lore.kernel.org/linux-iommu/20261006-smmu-shared-sid-v5-0-169a59c671d3@nxp.com/

Changes since RFC v4:
- Include Nicolin's patch ("iommu/arm-smmu-v3: Don't rb_erase() a
  never-inserted stream node") to avoid conflicts in future.
  so the standalone patch 1 from v4 is dropped.
- Split old patch 2 (shared SID support) into two:
  - New patch 2: Convert streams from embedded array to individually
    allocated objects (struct arm_smmu_stream ** instead of *).
  - New patch 3: Move stream allocation inside the mutex and look up
    existing entries first (find-before-allocate), avoiding unnecessary
    allocation when the SID already exists.  Pure refactor, no
    functional change.
  - New patch 4: Add shared-SID logic on top of the refactored code.
- Duplicate-SID cleanup (bridged PCI) now uses pointer-equality dedup
  instead of RB_EMPTY_NODE checks, since streams are no longer
  pre-allocated with cleared nodes.
- Link to v4: https://lore.kernel.org/all/20261001-smmu-shared-sid-ver3-v4-0-06b34fb2e691@nxp.com/

Changes since RFC v3:
- Added a standalone bugfix for duplicate-SID rb_erase (new patch 1).
- Stream structures are now shared directly between masters
  instead of duplicating them (Nicolin).  No ref_count field;
  sharing is detected via list_empty(&stream->shared_masters).
- On owner removal, use rb_replace_node() + list_splice_init()
  to transfer the RB tree entry and shared_masters list to the
  next sharer, avoiding use-after-free.
- INIT_LIST_HEAD(&stream->shared_masters) moved after sort() to
  avoid list pointer corruption from bitwise memory swaps.
- Both sides of the sharing pair are checked for num_streams == 1.
- Link to v3: https://lore.kernel.org/all/20260930-smmu-shared-sid-v3-0-8abe6c1b4c20@nxp.com/

Changes since RFC v2:
- Dropped the RB tree to XArray conversion patch (Nicolin).
  The RB tree is retained as-is; a new arm_smmu_find_stream()
  helper provides stream-level lookup.
- No per-master shared_sid bool; replaced by
  list_empty(&master->shared_masters_elm) (Nicolin).
- Only SID-sharing for single SID device
- Follow Nicolin's suggestion https://lore.kernel.org/linux-iommu/arG6hmng3NddGEHm@nvidia.com/
- Link to v2: https://lore.kernel.org/linux-iommu/20260921-smmu-shared-sid-v2-0-4b656ce68178@nxp.com/

Changes since RFC v1:
- Revised cover letter to drop eDMA channel example (Jason).

Some SoCs have a limited number of IOMMU Stream IDs (SIDs) and
hardware that inherently shares them. For example, the NXP i.MX95
only has 64 SIDs, only 6 bits for SID in the system chip bus.
However there are many device IPs, such as SDHC, PCIE, NETC, GPU,
NPU, Display, VPU, ISP, ISI, JPEG, SATA, DMA and etc. Each Kind IP has
mutilple instances inside the SoC. So I introudce this patchset to
support shared SID.

The current ARM SMMUv3 driver rejects this with:
  "Aliasing StreamID unsupported, expect DMA to be broken"

I took comments in [1] and implement this patchset and only want to
support a very simple case that multiple platform devices share one SID.

Patch 1 converts the per-master streams array from an embedded array
of structs to an array of individually allocated pointers.  This
prepares for subsequent patches where multiple masters will point
to the same stream object.

Patch 2 moves stream allocation from upfront into the mutex-protected
loop in arm_smmu_insert_master(), using a find-before-allocate pattern:
first look up whether the SID already exists in the RB tree, only
allocate and insert a new stream when no existing entry is found.
This is a pure refactor with no functional change.

Patch 3 adds shared-SID tracking so that when a second single-SID
master registers an already-owned SID, it joins the existing
stream rather than being rejected.  The stream structure is shared
directly between masters via a linked list.  On removal, a shared
master detaches from the list; the stream and its RB tree entry
are kept alive until the last master is removed.

Patch 4 places devices that share a SID into the same IOMMU
group, ensuring they share a single IOMMU domain (required
because one STE can only point to one cd_table).

Patch 5 wires up STE write ordering (first master writes, last
master tears down) and gates features that require unambiguous
SID-to-device mapping: SVA, IOPF/stall, and vSMMU nesting are
disabled for shared-SID masters.

[1] https://lore.kernel.org/linux-iommu/DU0PR04MB94172CB3F138AD39E9B6DEEF887F9@DU0PR04MB9417.eurprd04.prod.outlook.com/

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
Peng Fan (7):
      iommu/arm-smmu-v3: Allocate streams individually
      iommu/arm-smmu-v3: Delay stream allocation to inside the mutex
      iommu/arm-smmu-v3: Plumb the CD table into the CD helpers
      iommu/arm-smmu-v3: Use a per-domain CD table for non-PASID streams
      iommu/arm-smmu-v3: Support shared SIDs in insert/remove_master
      iommu/arm-smmu-v3: Group aliasing devices into the same IOMMU group
      iommu/arm-smmu-v3: Wire up shared-SID STE ordering and feature gating

 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c    |   4 +-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c    |   3 +
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c   |   8 +-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c        | 485 +++++++++++++++------
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h        |  35 +-
 drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c     |   2 +-
 6 files changed, 401 insertions(+), 136 deletions(-)
---
base-commit: d89e1d186ec9271bf78e62771779e9fc03bf0fc3
change-id: 20261026-smmu-shared-sid-ver7-2026-10-26-49ba8474f782

Best regards,
--  
OpenCode Assistant <opencode@Example.Com>

