Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.69.49
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794576216;
	b=iIHE8Dm2a/b1M0CKmcnn/7HqTFyCgNhw9SlD1e7oWxH9Yz+oBQjxWt7CaBLugbpGF8u2
	 gBt5x+P0YvlBKdmrhWgVYJ8UFgzMRP1UlanbHtynsZjPG4X1v9R7tosYUbYgc2GpzpKKv
	 4mdRdA2fszf6bbzkSOzXQpN5Q8mHd0BsOs5RvoMctfDaKhKaI8BJ6qb1wDxc7Hm3rq9fU
	 p2+67y3ii2M1mshaxRwKx8KKmnTpVfjENUUCA4Foo2OSF1O3Qp4nnp5WxDqw9MqEwm/xu
	 g1jjJBz0pjOGzvCNGGAhQBCPpdBF8UEiseXlMnUZ4dXezziD4ehe8aR2onxEUZhnQ3A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794576216;
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
	bh=HH2D4dH1usuLtOf24GO2MINYD2duKVkWHmLmNZTFPj0=;
	b=zQS6CvOcghvwBDINpanvqdTsJ0ltWqWluv4dU2d3NN5Xq+s+dzrEJrfvFcSAIMciiUUp
	 pDc028hjFPX7iuAvGBqTXF7mEJ54h/bgfBvgYSQwqq6fLi8vUsycn0Ubbxu/iOl5+nse/
	 2X8HH0xfTlAG3wACnSolUhUY50SamlcRa+vdeefxBC4w7lkOM/3JEzoEWe/o7YHHkd6uy
	 HxucCW1Pjzb9H8wbLl8HdG5DZN61CFxXGafh0ExAFAMCkAkvU0lwcOTeGBlNTlqUPS/Hk
	 Y+uHmbDPpfLpFQrW9q30sX5H/eNISZQS5c6XnBrJQnqE3zUy8KPy6G3jQkozpdcfcuQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=Ti8xMDyH;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.69.49
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010049.outbound.protection.outlook.com [52.101.69.49])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23B3B606AB80
	for <iommu@lists.linux.dev>; Fri, 13 Nov 2026 13:23:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 23B3B606AB80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=Ti8xMDyH
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wg25g3GDebcaKoPl8Y9XZ0QrTDH7eXBwtLSjReBrMRVc8K08iHC7lPRzj/823O8vShT13TA7Q1JunZHNAIQuGhQN3NJyRVSuPwCagl0Kt1d6lPqmVHX0hMnFPuGxrlinU3qLmLy9h8AwMI0icpTni8VoRiGEtQBl5sd1JhG5dnwE0XZT5rtZqaKWJ1KPyvN2iEMH694diKp1HfdWODtSKJ/iThAPutf9mit7sZM1M08UK6lLHDRFjDS1ROkDPEmnqWPP47TbFRt7fgM9xxduO1XqUoK7FAvzVmvaOTD4Ww465EVXZCDzQXcZzLJoPCTl7U7vn4GPj7zb827ZR6ANXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HH2D4dH1usuLtOf24GO2MINYD2duKVkWHmLmNZTFPj0=;
 b=CRo9sbCkoNtenI4tMc3EQR6m6el7p60TXcF24EhQ63kXBhCokj3QwtITAdqP1rbGyViM3+nazTSDy/5zty+McU5G8nWEMYvT0/EZaEFB4jNK9DqZzwi21aucddaVjfzRSdn84Xbbk0PmBS1Z2hKXjUIXIE1m3b+8qJoCS03AkEqTk0kXCbjeDJ7hGwPZ1Tn5HUn9f5r4WJlU9cBigvPvm0GDb6ZQwkDFGHp9CPxPFer2m1k9D13tYkKhoHNE8tTPa5xTikwUEwqzclAv7TlkSo61vdwfw85s608q9ZAzAmyHTrs9v6TUhs7d3ie26QrzJ3U7SZ+uqbcLg4UMuQfHrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HH2D4dH1usuLtOf24GO2MINYD2duKVkWHmLmNZTFPj0=;
 b=Ti8xMDyH+hAe/5I27LxSxUkC8M2RenYFwjxdi1oICRyVLQb11/IKSdJ0U3YwqeONuxmcfzEdqDbxjFPjPOILmAcfKKE3vBeyjpx+x284Hx31yYgwhjamURjVtZ9KREMJnr4ix7RFZ997BdRTE4ut8gxm5LHMOCKegsRzQZYcExoHBet4L5VqELdOWFIOYVqEcyqwhSGqpf63Wj/iLuogkU2MzoHequyyYHYqSVY/KnZwWAnmk8CvWQb7OukYurB1pXQTzQhjyD+A+e0fiyfTaWCQaEn3t1ON3XPdeBZ7JdGc+2IB0wYu6SL21f27ca8SGstkHghhMwLybyReIQkcUA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by BR2PR04MB007356.eurprd04.prod.outlook.com (2603:10a6:2c8:6::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Fri, 13 Nov
 2026 13:23:31 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%5]) with mapi id 15.21.0615.008; Fri, 13 Nov 2026
 13:23:31 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Fri, 13 Nov 2026 21:27:20 +0800
Subject: [PATCH RFC v8 8/9] iommu/arm-smmu-v3: Serialize shared-SID changes
 with attach
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261113-b4-smmu-shared-sid-ver8-v8-8-587307a77f3a@nxp.com>
References: <20261113-b4-smmu-shared-sid-ver8-v8-0-587307a77f3a@nxp.com>
In-Reply-To: <20261113-b4-smmu-shared-sid-ver8-v8-0-587307a77f3a@nxp.com>
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
 "Joerg Roedel (AMD)" <joro@8bytes.org>, 
 Jean-Philippe Brucker <jpb@kernel.org>, Nicolin Chen <nicolinc@nvidia.com>, 
 Jason Gunthorpe <jgg@ziepe.ca>, Thierry Reding <thierry.reding@kernel.org>, 
 Krishna Reddy <vdumpa@nvidia.com>, Jonathan Hunter <jonathanh@nvidia.com>, 
 Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, 
 linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.16-dev-7bc12
X-ClientProxiedBy: SI1PR02CA0023.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::19) To AM8PR04MB7874.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|BR2PR04MB007356:EE_
X-MS-Office365-Filtering-Correlation-Id: 800b8ba0-3fd3-4780-1667-08df41894fc9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|7416014|376014|23010399003|1800799024|18002099003|22082099003|921020|11063799006|261102123227099003|261026140227099003|261028144727099003|261026121527099003|261022105027099003|261021121427099003|56012099006|261021123027099003|261009223027099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	iA7cycjzxmql3h7q71I2k+dPVqvi5Ifa6P39BgQlVq9Ej/45c6eTTnSzhVIV+jpmFbpN+6n+9MZ1PnfI835kaK4xunoEnoHH4h3ZbczNB7XBmM6MDyrZCgBGInu6u7aNbE7d9lxDPr1rHEM7aW096DXZEsmBMo/ol10Vhzy0BRHgb4QXU71tPp6AZbK2hZcJjrz8s36x2cPq7Bjv6+VYShcahjo1qDRGxy2xbwx/bnCN+Fq7xyV0X3jwa6K+9dMwgo0RsE1ji26fIhK3snvfL+mudPx0xhD9x1ySiT8Rno6msCTm29YmsNRZhnSnoSdI8nZQE1NiEZG9+CKUpVWatUknIwGvhdp6Ol6Wh/3w68dd7FhIpRB7GsrS2ZNTVyJcAzaVdWSWEgVVWbhhFy3b6xfDXzz65Sz/ezFqvjOQwyfibikRhy6YBqWi+xr4GQnCZ2XI+vmcoZpriX1OCXDBIDtAFy0duxZni1c9LsQB+aYlaMgnrpvVsPMGzWVDCD3T9CDtrF1yf1h1/yKtnRnRm6L8yE+DuKrQdk+1pt24k/OOBfxjveIfcQ3AMajAaJKQTjhQprPIwnUrpklhCl+urbvLJFUwam8UQFiO5DrUgMPhEpPDFd4UBd0w8m4XohdHVei2UKLsOpWzrqedlwq40aahMlPrSMBDMZ22t9flC4YgVjTCFBy2V46XQJ3XjVj0WcCQZd+/hEWV/AjUUg6mSg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7874.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(7416014)(376014)(23010399003)(1800799024)(18002099003)(22082099003)(921020)(11063799006)(261102123227099003)(261026140227099003)(261028144727099003)(261026121527099003)(261022105027099003)(261021121427099003)(56012099006)(261021123027099003)(261009223027099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eWxWQ1FnMlIzWVU5N3dvMkNLRzJYSStyMElZK29rUTN4WEp4ci9EeXM4bmtJ?=
 =?utf-8?B?SEU4UmtvcTZzY3N4RWxacEpEaHZmSUFVV0FvMXhmUmFLTW9GNkh4L1NBM1Ny?=
 =?utf-8?B?YUEvMmVvdVJEYmkwdDVDbEc3TGNET2w0cHJ6dWc5SlFuejhwWlFZYis4amVw?=
 =?utf-8?B?TytaTy9rcDhjYUxGREFKKyt4d0FxRWd2dnN2MWJZMHdPaEVKZ1VMTUk3RWsy?=
 =?utf-8?B?V3MwdUovc0ZmR3VzZlg4TjVuS3pWVXVXMUNNWUlOMUxQWE1NdUMyVEIwQTB2?=
 =?utf-8?B?NnQzdURtS25SZWdyVkpvN2ZmTUFRM2NVME0xZ1FLQWZSU0p5SHVHeG8rbzRV?=
 =?utf-8?B?ZkFVMzVESmtpbFZUQnhVVmUwY0kzLzBjci9INUxJb1dQeUdZNUNLdnFyNlNn?=
 =?utf-8?B?bHBHTGpHZGZQT1FsSVNTZE9BMUQvRE9saW9Bai9KNjhFL21rRHpweWRYSXBZ?=
 =?utf-8?B?QWRWUklsa0hYMHIrU1RvaGhqU2UzbHFIMXR3M1FRaVJBVS9zbjdpRkRwUWhN?=
 =?utf-8?B?Mlh5dElScm5zR3JVeWpnTVlNaFlUVHUrbmN5TTIrTHRGR2lIQjYwMXltSlJY?=
 =?utf-8?B?MFc3My9SMlQxRkI5cTc4TWl2eHAzNjM3YlQwNStpdGI0QmhmNjJBYi9maFNS?=
 =?utf-8?B?UXloUy9qdWhXOUN2bHUwbUdlTE9UWnV2TFR5bzl1UVdINTEweER4QzhUZjJn?=
 =?utf-8?B?dFdQaytBdWRaSEdSbDNEQlBsN0ZDMk9XMmhiSjFqcXdaSTdEUmVRVWw4Q1lw?=
 =?utf-8?B?dGc0Y0s0UzR1Sm91dzZ5aVR6SVhCcExacFdVVWZyNmRTV1hlS3BaV2lXY2xS?=
 =?utf-8?B?aFVzUVZPdmR1SUxqMjUxZXFULzZ6Ym93MVBMR2JMTjJJemdwdXhVejFxUzJk?=
 =?utf-8?B?aURXdmE0U3QyWjROYUpTM2V3ZDVnQXVMcGd1NiswU0dmSENlVjRTVDZxWmFH?=
 =?utf-8?B?SVlvcXcydkQvdG0zc1ozUUdBYXJoYnd3R0FNMEtNYVNPRm05UU1tT3BBZ2c5?=
 =?utf-8?B?c0srdWhHRGlGbnJCS0IrUGZySG5TRUMvTHNOSmUxbCtrWDFoWU9RajAyYk1E?=
 =?utf-8?B?L09zUExuQlFJZ3BwR3lkTW1OaHFqM0Z4L28yY3R2U3NvVnVWQWRsWE5zMWls?=
 =?utf-8?B?a0dKWGZDOTRKb3ZFWFdBZFZvRXVrT25hSm50T3YwMFpDYzlFaTA2NUpieTd2?=
 =?utf-8?B?VWdKQVpyNUI2dXZjdldjc0NtNk9WMUYyZ1JpZHdNa2UxSVIrdFo4R3doV3hp?=
 =?utf-8?B?QVpVVklCQTlxa0g3S1JGSWZDTU82dStLWXJGMWV1dUV3MnFOMVlDTjRyRDY2?=
 =?utf-8?B?OThsYURGZVhBRXFYMEpsMmlEWnVaK3B0eXV2UUluWktuOG4xRlZGelBwNE84?=
 =?utf-8?B?VWs0MEhZZDQzZVpITUgrM3FXaHMrQWpDSkxVL3pUV1BuZjVwWENtWXFFdzNC?=
 =?utf-8?B?L3NYbDV0d0czbVlNcXZwN1ZrcllGakt5WXFBSDdLSTVINXRRM2U0YmpxbGM2?=
 =?utf-8?B?Vk9uMlJOS2orTkRLdmtzcHl2YXh4NDY0SVhZOTZ0ejRaM2NQWHh1UUJhaFRF?=
 =?utf-8?B?a1J3WXYxR2N4dEw5b0ZXWlBJK0czaktLM2pTTzRqYmJXR1gvQTVjb0ZIbjBP?=
 =?utf-8?B?S1ppU2NWOWFGbFFEUTB0dG5RQlYzU2sxbnpkTHY3VE1kWlFUYmo3bE9ER1VL?=
 =?utf-8?B?R3o0Z2Y5dkhFZDRPbHcwVGYxdGtIOWxNNzd0NFZRWjFFQ2RUaGJNejBSZmsz?=
 =?utf-8?B?Q2Z6TVY0Y0J5V0JmSC9VUTJiYXMwa3lRelZmbUF1b3VGSEhwdkpGbit5Rmg5?=
 =?utf-8?B?UEJYS2ZtZ3RIU0hXRjY5WC83MXBXSmlHdmZJUjIzejkrSlRnUTd2SjE1RmFo?=
 =?utf-8?B?R091MW5mcmFEMmUzL3hiVVJQZE9mVGNkT2R3cS9ZR3Jyam81ajRENEVROVZi?=
 =?utf-8?B?UG1qVDBLS1YvOWorT01sUkZycHBaZTBJdWU2UFdTS3JPVUxUVUsraWd6UE5q?=
 =?utf-8?B?YjY5TUVUYWRDczRBN2t2ZU9VVDFIZmNGMEF3VGt2YmR0WTFNUXBVTGwzeFBr?=
 =?utf-8?B?NmNVUkI0Zk5DT3BRUjF4c2JjWnhCSGtkZ0QxTUpjUmFVYjh5ZE1WbVpPVEw1?=
 =?utf-8?B?ZHpoWU5RNENYWGt2Mk8wWG5TVkRhOEpoY1NYNnQ4NnVTSGFsRkFOZ1YrNEJR?=
 =?utf-8?B?MGkzek53NVRWV2JGdjZ5Yi9Gc25yTGtuL3p4eG5RbUxhODdSdlBMTm9FZzc4?=
 =?utf-8?B?T0dGb0JETUgrTGhEcnFEcXcvU3ZXZmZLM0t5YWZjUXYzWTVmcDl6ZkJWT0Vt?=
 =?utf-8?B?cTNFU3FWWVF3VTB6YU5lVzhjbExFMEFhMmtZZXczdGdwUjRVb1I4a3JOZ3hi?=
 =?utf-8?Q?xousrUB4xsbsgenZ2b16/jCLxNwSaaDSzOS91?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 800b8ba0-3fd3-4780-1667-08df41894fc9
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2026 13:23:31.7894
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9y4GwvjYOG/XTURE3sImhER73a176OnI3JsZt5QJTvqZew+ss3/HpitBpS5BV6d3sTivpXAVBl74c3RVQIFxZKIetw43dtk/OYfqNF565f0wpPzYDbHjIX52Qzf4drbq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BR2PR04MB007356

From: Peng Fan <peng.fan@nxp.com>

Shared SID membership is modified under smmu->streams_mutex, but the
attach, PASID, ATS and vSMMU paths read it while holding the group mutex
or arm_smmu_asid_lock. A second device can start sharing a SID while the
first master is attaching, so the first master may select a private CD
table or enable a feature that is incompatible with sharing.

Take arm_smmu_asid_lock around insert_master() and remove_master() so
sharing changes serialize with the attach/PASID/ATS paths, which already
hold it. Keep the lock order asid_lock -> streams_mutex.

Recheck shared membership under asid_lock in the PASID attach path and
move the vSMMU membership checks under asid_lock. The incoming master's
own probe setup is still serialized by iommu_probe_device_lock.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c    | 27 +++++++++++++++++-----
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c        | 14 +++++++++++
 drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c     |  9 +++++++-
 3 files changed, 43 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
index 1fa512a655d2..10c5f9605152 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
@@ -168,12 +168,16 @@ static int arm_smmu_attach_dev_nested(struct iommu_domain *domain,
 
 	if (nested_domain->vsmmu->smmu != master->smmu)
 		return -EINVAL;
-	if (arm_smmu_master_shares_sid(master))
-		return -EOPNOTSUPP;
-	if (arm_smmu_ssids_in_use(&master->cd_table))
-		return -EBUSY;
 
 	mutex_lock(&arm_smmu_asid_lock);
+	if (arm_smmu_master_shares_sid(master)) {
+		mutex_unlock(&arm_smmu_asid_lock);
+		return -EOPNOTSUPP;
+	}
+	if (arm_smmu_ssids_in_use(&master->cd_table)) {
+		mutex_unlock(&arm_smmu_asid_lock);
+		return -EBUSY;
+	}
 	/*
 	 * The VM has to control the actual ATS state at the PCI device because
 	 * we forward the invalidations directly from the VM. If the VM doesn't
@@ -312,8 +316,15 @@ static int arm_vsmmu_vdevice_init(struct iommufd_vdevice *vdev)
 	 * arm_vsmmu_vsid_to_sid() maps a vSID to master->streams[0] alone, so
 	 * more streams would leave the rest stale and none reads out of bounds.
 	 */
-	if (master->num_streams != 1 || arm_smmu_master_shares_sid(master))
+	if (master->num_streams != 1)
+		return -EOPNOTSUPP;
+
+	mutex_lock(&arm_smmu_asid_lock);
+	if (arm_smmu_master_shares_sid(master)) {
+		mutex_unlock(&arm_smmu_asid_lock);
 		return -EOPNOTSUPP;
+	}
+	mutex_unlock(&arm_smmu_asid_lock);
 	return 0;
 }
 
@@ -547,8 +558,12 @@ size_t arm_smmu_get_viommu_size(struct device *dev,
 	struct arm_smmu_master *master = dev_iommu_priv_get(dev);
 	struct arm_smmu_device *smmu = master->smmu;
 
-	if (arm_smmu_master_shares_sid(master))
+	mutex_lock(&arm_smmu_asid_lock);
+	if (arm_smmu_master_shares_sid(master)) {
+		mutex_unlock(&arm_smmu_asid_lock);
 		return 0;
+	}
+	mutex_unlock(&arm_smmu_asid_lock);
 
 	if (!(smmu->features & ARM_SMMU_FEAT_NESTING))
 		return 0;
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 790a6e54c24a..5a6bed0ca7f1 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -4114,6 +4114,11 @@ int arm_smmu_set_pasid(struct arm_smmu_master *master,
 	}
 
 	mutex_lock(&arm_smmu_asid_lock);
+	if (arm_smmu_master_shares_sid(master)) {
+		mutex_unlock(&arm_smmu_asid_lock);
+		return -EOPNOTSUPP;
+	}
+
 	ret = arm_smmu_attach_prepare(&state, &smmu_domain->domain);
 	if (ret) {
 		mutex_unlock(&arm_smmu_asid_lock);
@@ -4588,6 +4593,11 @@ static int arm_smmu_insert_master(struct arm_smmu_device *smmu,
 	}
 	INIT_LIST_HEAD(&master->shared_masters_elm);
 
+	/*
+	 * Serialize sharing changes with attach/PASID/ATS updates, which
+	 * hold arm_smmu_asid_lock. Lock order is asid_lock -> streams_mutex.
+	 */
+	mutex_lock(&arm_smmu_asid_lock);
 	mutex_lock(&smmu->streams_mutex);
 	for (i = 0, n = 0; i < fwspec->num_ids; i++) {
 		struct arm_smmu_stream *stream;
@@ -4678,11 +4688,13 @@ static int arm_smmu_insert_master(struct arm_smmu_device *smmu,
 	if (ret) {
 		arm_smmu_free_master_streams(master);
 		mutex_unlock(&smmu->streams_mutex);
+		mutex_unlock(&arm_smmu_asid_lock);
 		kfree(master->streams);
 		kfree(master->build_invs);
 		return ret;
 	}
 	mutex_unlock(&smmu->streams_mutex);
+	mutex_unlock(&arm_smmu_asid_lock);
 
 	/* Put the ids into order for sorted to_merge/to_unref arrays */
 	sort(master->streams, master->num_streams,
@@ -4699,9 +4711,11 @@ static void arm_smmu_remove_master(struct arm_smmu_master *master)
 	if (!smmu || !master->streams)
 		return;
 
+	mutex_lock(&arm_smmu_asid_lock);
 	mutex_lock(&smmu->streams_mutex);
 	arm_smmu_free_master_streams(master);
 	mutex_unlock(&smmu->streams_mutex);
+	mutex_unlock(&arm_smmu_asid_lock);
 
 	kfree(master->streams);
 	kfree(master->build_invs);
diff --git a/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c b/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
index ffb0ac93a4f4..3bcecdc00a86 100644
--- a/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
+++ b/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
@@ -1264,9 +1264,16 @@ static int tegra241_vintf_init_vsid(struct iommufd_vdevice *vdev)
 	if (virt_sid > FIELD_MAX(VINTF_SID_MATCH_VIRT_SID))
 		return -EINVAL;
 
-	if (master->num_streams != 1 || arm_smmu_master_shares_sid(master))
+	if (master->num_streams != 1)
 		return -EOPNOTSUPP;
 
+	mutex_lock(&arm_smmu_asid_lock);
+	if (arm_smmu_master_shares_sid(master)) {
+		mutex_unlock(&arm_smmu_asid_lock);
+		return -EOPNOTSUPP;
+	}
+	mutex_unlock(&arm_smmu_asid_lock);
+
 	/* Find an empty pair of SID_REPLACE and SID_MATCH */
 	sidx = ida_alloc_max(&vintf->sids, vintf->cmdqv->num_sids_per_vintf - 1,
 			     GFP_KERNEL);

-- 
2.34.1

