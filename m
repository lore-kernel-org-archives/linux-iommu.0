Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.130.24
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793361902;
	b=rC9WSgeLXZDNKoa98bCPos0588B67G4/9s5+oR48oT6RcPKkKz7hasy/2T1IPRbiODgM
	 Yd8FSYwz5Sl8ghtQ+a2+5gMuGnz6wqNZFw0eyRNNUKW/nhHGpjto280ZzCDb6w4+IHXpD
	 GNpEUG7qVNp2rA3puiLnO2pDWPIkPujnYRikHFSBVxL35Y+J6u9+6A/MF7m1OlVBOxP2l
	 xeTMvXSrwNcadgIeS0U/xVRW5dRHUupOwQTP+G+SIkzxJmZD3fUwjyrpvHuO/6V3oCvYz
	 fF/Dkrjv2ttzBLhk9RHL8alS8oWs/+5V5I4w2gC82WFawpgpBLZeVCPMNJI4AlChP6w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793361902;
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
	bh=4GuuZ0LiBYMJjokPsmLzo+w3X62/QxbgLhwkKN4BTTg=;
	b=bkw9O66IGBsdn/rTyT6SuvjN7N46v+LZ9Z0awQI1r8lSIBe3oKljIxWLw81GY1zvlWaj
	 z0rNAqKaSc5bqbNnN9NmgNiwcFs/BMPm/Q7v7riex1vX0rT6XLvjuvRIWvwwM3gTcXn1F
	 wAl56PCzgbNOk4UoITiJejt9GbMpo761FrDFjiPhTRlJaxN57aeX1edDtjPKHI7JvBksI
	 NEH6Xqf9+GBqKp4Y/u8Kbm/i5R2QxFHxILtX4skW8QYYpQ5FydBRczXWiLbWMR5zuh5op
	 2KZ5RkP9TXCDLnIHK1aeDusVMuJCnLmpk9/84+7PdiAOIJrnLnfb0Y8RNMlFetMS5sA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=hE+oTT0m;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.130.24
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011024.outbound.protection.outlook.com [40.107.130.24])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FC77606A32E
	for <iommu@lists.linux.dev>; Fri, 30 Oct 2026 12:05:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7FC77606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=hE+oTT0m
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L007C1OKlSuHN342Ylhe1CalSl3FFKCHjdq0eDtwQUVDbMqe/6E8FEcbX8Ku1IFSAtL4qrtoQoHyiND7X1f8VHHazEsL+oR3ubo+Yqqa5eHNivBPHqMPJX/gYpYNUHlxw3yimEIlhPsRhRz+MeuggPeNnSu7H1HFo8DJfCM669aLAWOI8bD3hWHcpBLxOzxIo+Q9gdr5DdEgJpxo6bPq4Dn6x60bxJolNHnq++ULuJNxpvASuMpUVK2LFrZGN6wcLGql2Mj5b5PA4ekKlxUr6IWSu72s486syrwiWUaHB6yPnCmGvoWs7VqFz2GglBgKd977daC+iIOpSpSV/I5VZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4GuuZ0LiBYMJjokPsmLzo+w3X62/QxbgLhwkKN4BTTg=;
 b=LSzebl8+WcAQOXvRGnM4zcphj0yViwbYprYGTDfSm6Gjodqy7eXNNP99W3Cxyt7Otgurmsci/8OE3y5DfN0bb3fouYFpcEbc7RiyAf4r4CPTWt15iN3TRk6Y9GpXdoHC1mkQe39hT9U3K3LM6IRQYV4MpxctZX3tI+Tb2AhGw8sxXVJ23B3hvvuFRBnmBZlgp9z9E/wzngnHeTJSr1z8aJCMmXkHkEJGDS6DcVul6PPQRMQv59V7kLVBpNZEzhIaWLeqCj7XBXgoyvsfhd21Ruj5MPRAYYN5UmoTMGHDeecFosd0SkjPnRHzxntPahBtOOdYJxD4ZLB7CrCH/7l6rQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4GuuZ0LiBYMJjokPsmLzo+w3X62/QxbgLhwkKN4BTTg=;
 b=hE+oTT0miNghWXj3xgasyPB1V9RFuUitPFmFZ5+C9EVqG/dXHGu+vweYdG6PKIUnV8zcD1lmihlVEjpRHjBFbpC8VzS14ZC6m90ySbO9eWu5CsybTBBRTOmTJBMYFGokHVz3LafcN3piP+TC51xwFL7Umf53nvvUNZgtYLUaSFSeo+n3D488xciu8bTzDpZ9nHxayL8aihlJs+WmPqiTCj6V/dxDl/HvqOrr87vCnwjVYt7VAUNoBodOv3/TnDe/2bQTHsh8s/CyJWXmMmkvxe4DcqR2hYSfh0gFdcBvIFCzlyGShotvsEFK5oOrbJx/Vj2ON+hdIaWYuiAomKia1Q==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by PA6PR04MB11947.eurprd04.prod.outlook.com (2603:10a6:102:515::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.9; Fri, 30 Oct
 2026 12:04:58 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%6]) with mapi id 15.21.0569.009; Fri, 30 Oct 2026
 12:04:58 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Fri, 30 Oct 2026 20:09:33 +0800
Subject: [PATCH RFC v7 1/7] iommu/arm-smmu-v3: Allocate streams
 individually
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261030-smmu-shared-sid-ver7-2026-10-26-v7-1-961726ebd6ab@Example.Com>
References: <20261030-smmu-shared-sid-ver7-2026-10-26-v7-0-961726ebd6ab@Example.Com>
In-Reply-To: <20261030-smmu-shared-sid-ver7-2026-10-26-v7-0-961726ebd6ab@Example.Com>
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
X-ClientProxiedBy: SI2PR06CA0007.apcprd06.prod.outlook.com
 (2603:1096:4:186::9) To AM8PR04MB7874.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|PA6PR04MB11947:EE_
X-MS-Office365-Filtering-Correlation-Id: db6ecaf8-5e0a-4be9-09d2-08df367e049d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|23010399003|376014|7416014|1800799024|22082099003|18002099003|56012099006|11063799006|261022075727099003|261028144727099003|10067099003|261021123027099003|261021121427099003|261021135927099003|261026121527099003|261009223027099003|261022105027099003|261026140227099003;
X-Microsoft-Antispam-Message-Info:
	dPnIaeWWefX3hPXB1H6R50HLi3lDql7qJl5ofkJ+5MmRk8WgLlbNfdOymFT+MSyQKC7vDxupyGLS/bNAFekhLZqrRR+mOSuaKLtJqfd7IGt52V45iCNpVJPMAGd0HWDm3XhOpNm15en/sxgtLHgjMFxkqhbog8a9PF12Cg6/GBxPokxiU5nlUCGtFuwBg2Yo73oXBmxvE7HkVaXv7CJgPbbuNNJHOfXl3r0F8SfwJ5c43s96M/9rPYxlcenwhdpZv4MpheMm7trQYpmDRZKFxT0KTqQkPI8PTWVxIJX4TkA+P+wRtFhLb+/eQsyrZSHMPBGpw7dtDXD3nFP5ibByKHZgp7lowBYZMu1RmYmSSxYdruFpM2Z731Jcz6hK9iFyA/fimsrtjq1lswNufwhlpxOBbLNiV4QyXxTbJgpb8rLs7jQdQxpRYyk/PBrvgVyMLOtFGJ84BVPjtUX9s8FzngQ/nCTOD47+p3onxKjQ/JyTF1IUFSZeaBTEG6TA+H9UiT3U88/DQE+Qz/SXC9j/bO/uHQUxfOCj0tnVVWk9ll9J2OJK6UpAZilujQu9a00CJuG7IdLcg4/Hha3ETaJtC6iCmV4qMhml56ijY477hHiqV30TfPjvy4m/45Ql/LQG
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7874.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(23010399003)(376014)(7416014)(1800799024)(22082099003)(18002099003)(56012099006)(11063799006)(261022075727099003)(261028144727099003)(10067099003)(261021123027099003)(261021121427099003)(261021135927099003)(261026121527099003)(261009223027099003)(261022105027099003)(261026140227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YmdyTktNai9kakNYOVFkck5nb0lYTXk4c1RYWktiMmE3d2RBaGJEZTQ3YTIx?=
 =?utf-8?B?Q25VeDd6bWVoNGNkQm9TMFdaRTBSeUw3RTc0NHkxUW4zVnF4NXpETWVNUjJm?=
 =?utf-8?B?L1lSeDBDeGFaTmdkai84bVR0V1BacFEwbU4ydkI5QjhwOWhhOE40dXR1SWRY?=
 =?utf-8?B?bzFldTl4V2Qwc1hKSHlWRVlGdVFsWmlKUHhmb1MreExBYmlLNjIvam1NenZ6?=
 =?utf-8?B?V2lOOHptOTRqUUoxSG1Lc0gvVnlseXhCUTc3NWxJcVlRc05yYW9FZTYxMU5m?=
 =?utf-8?B?cWEvNml5ZHFiOGlYRmdGQk8wWjBraWdEOThrVkJpaGtNVWVKbENqZ2N3KzVu?=
 =?utf-8?B?YTJiQitDeTh2aDlNV0d1dHpJSTJwZ0EycHVhNzhOM0hNczMvaUFjSFk1ckxa?=
 =?utf-8?B?SXVMSmxmc29RY3AyVDJScEdzZVRhSGpKMXI3aWFjaU5qaExySWVSZ3lVSlJY?=
 =?utf-8?B?a3lLenRVdTJxUVI4MzdJR0xVUXdlUEU4UkpUcVdUVkxjVmtKWk9LVjZKcWRO?=
 =?utf-8?B?V2NGcWRxUnR6MmZrRzI4dENqclI1L2NFRTV4TFI5OURLQjFEZFpMNUp1SUJ2?=
 =?utf-8?B?bkVpSkxtcnRYYlZOMTRiMWtURVRaSFUvOERrZE9QUy9HRXk4NEFjR09GQWpI?=
 =?utf-8?B?OEptL0IrYVU1cmRrMS9KVU9MMXhCSVdEK2dVbS9aT3pGR2orUkltejZ4VUxa?=
 =?utf-8?B?YVRrV2lqbkR5cS9QZEF3TmNGYzFETUhPN1ZlSmhmeWVRdUxBdjRsakxNczJi?=
 =?utf-8?B?Ymc1UGF1V3k5b24wMVFpSGVzUk1ibWxDeWh6MGRWRlU0OExQQ3laaGNjekZq?=
 =?utf-8?B?eEVQeWhOQ0M1aVZYdTNRV0t1bDR3YldJQ21GRXRGc0hMRE0vRWNPWjhTQXVW?=
 =?utf-8?B?NkZOSWhoT3JkOE5OTEF6cDBlRWFmalVId2ZLWTB0TGZsWWQxaHEyRGpYUnNw?=
 =?utf-8?B?SEtQQUhRL3FwbXpPem1jZ0hGSCtGWVFxQ2RZZW9jNjdKd0ZJV2FPTjM2amVR?=
 =?utf-8?B?RVpYZ0hyaDNDMVQ2ODBsZU5xd0lyNWp1cDJuMlJrNXF4UmRaMk5DQk0waUM3?=
 =?utf-8?B?THZVL2wwTlRzcXl3V2hvZWg3RXUvS0ZvMDBNVGhJcDBhNzB5Qm1FQnJrc3li?=
 =?utf-8?B?azgzYXV3Nno3QjNFNDZ6Y2lKSVlCTTBhMGFiazh6Y2w3b0RlOVpRa3RuTE0v?=
 =?utf-8?B?Yk80TUxJa1BQeGUzWnhOSitDS1ZVejV1Sk9LUTV0c3BQQW9HbmFWamdvc1Nz?=
 =?utf-8?B?MEJBejB3YitkNXlLSzJlaUlzWExTRzh3amg3SVFSMkxJM1g0NVdJUjByOEsy?=
 =?utf-8?B?ajI5NDNBalkwV21RbTRqRXRvc1lRSnN5K0xFWjB2cVJsd3ovQVhadmdoYWE0?=
 =?utf-8?B?cG40cGdmRzdrTThVdzgrUEhGTVBhSDlvMTVCRmp6K0QvY0lwU3VTaWtURWFW?=
 =?utf-8?B?VE9yOWgvOEU0L0xjbE9UcUd3RXRWZFloVlh5NUlnREFBOE9DMnN5a1BQdlB1?=
 =?utf-8?B?WHZZaVRUTk94c3kyVXR3S2hOYnd2UDB3QjBLNVVTRUQwNnk3SGs2ck9NWTJG?=
 =?utf-8?B?eUVtZDc3RUhLRmNsOWRmdHFDZ2V5cTNrQ3plSHV1TFMvMm9tUzdBa0FqUWI5?=
 =?utf-8?B?MTA3SzFzQzBTV3RxQWUwdzVjZFlBZmJGTTNvRWtab1lJL3ZqTURTWXQxbExx?=
 =?utf-8?B?OHBBU3Y1TjkvMEdFQXg5dzJ4Q2ppbUN4eGVkVkhXcnNaZnB0YTdneVh0L3c1?=
 =?utf-8?B?b1dBb3dOeUVxbFh2cllLZWI1Zmw1UkJFNW5XRXprODdia3k5TFVURnlsUHVV?=
 =?utf-8?B?ekk4NEF4dEgzM3hOWWRsTEtmZG53ckdpbTlhTkFIZlpHeWF3RHdVZDg4cnBB?=
 =?utf-8?B?WU1wTW80WnJUSnc4cHYyVU1RckJKZG5LSnlNYWU5VXAweFo5U3RHK0FxODQ5?=
 =?utf-8?B?bjdPZlhtTkhqOHVKY0tQMHVua1JoMnBmV3ZVWUZCTnNnRllOME5TQ0xMdFRQ?=
 =?utf-8?B?SjExTVFCbm01SCtZOWNzWk8vTWRZbGdzUURQSmMwY21sR214K3hsZXVrRWt0?=
 =?utf-8?B?Y2VkU1RaTVBMdm9xSGlIY0owOUViRERDY20yOU9mUWdJaklrL2tmSDlDbGpE?=
 =?utf-8?B?eDhvZk9qZG9zN00zNTZwdUZNL1BTYmJFS1o3VCtWbWNRUXJGbWNNUFJOa0h5?=
 =?utf-8?B?Q1lZeG5VOWY4cXZuV2RCSEhKRTBGRDNrQVUrTnd2eWJjZ2NHWmdNOHdQZ1FB?=
 =?utf-8?B?cUdGSC9rM1BoWUlDelh1VzI1UngwTjNIZ3prWUVRVmZWN3NydVcrZ3FtVlZj?=
 =?utf-8?B?MThHdmZlZ1lwWGV5SFRjYlZhbUJwZGZSVGZuaHg3V3Z4VkFBUndHTmNuNTlZ?=
 =?utf-8?Q?LuIxH4SICl5/Ug3ZbQ0UJ02OggE768LOOLGz+?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db6ecaf8-5e0a-4be9-09d2-08df367e049d
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 12:04:58.2117
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y+L0Fn7A/fOLEjgnSOsdvoYCqsahktPw/q+knu08wNFCUJr30S+LY+4jg6u24MoPYYrb0TCyjSISdvu3lZKlNSMzWyjdsDNxuj8XvvsmpF+zwMfreSmHUlQrUWlP9yoU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA6PR04MB11947

From: Peng Fan <peng.fan@nxp.com>

Change master->streams from an embedded array of struct arm_smmu_stream
to an array of pointers, with each stream individually allocated.

Prepare for shared-SID support where multiple masters will point to the
same stream object. With embedded structs, sharing requires duplicating
stream state and manually keeping fields like ste_installed in sync.
With individually allocated streams, a sharing master can simply point to
the existing stream.

The sort comparator is updated to dereference the pointer indirection.

No functional change.

Suggested-by: Nicolin Chen <nicolinc@nvidia.com>
Link: https://lore.kernel.org/linux-iommu/arG6hmng3NddGEHm@nvidia.com/
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c    |  2 +-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c        | 52 ++++++++++++++--------
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h        |  2 +-
 drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c     |  2 +-
 4 files changed, 37 insertions(+), 21 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
index e68b464850955..853276dd54536 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
@@ -295,7 +295,7 @@ static int arm_vsmmu_vsid_to_sid(struct arm_vsmmu *vsmmu, u32 vsid, u32 *sid)
 
 	/* At this moment, iommufd only supports PCI device that has one SID */
 	if (sid)
-		*sid = master->streams[0].id;
+		*sid = master->streams[0]->id;
 unlock:
 	xa_unlock(&vsmmu->core.vdevs);
 	return ret;
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 6d4520c473086..5e092f51faad0 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -977,7 +977,7 @@ static void arm_smmu_page_response(struct device *dev, struct iopf_fault *unused
 	}
 
 	arm_smmu_cmdq_issue_cmd(master->smmu,
-				arm_smmu_make_cmd_resume(master->streams[0].id,
+				arm_smmu_make_cmd_resume(master->streams[0]->id,
 							 resp->grpid,
 							 resume_resp));
 	/*
@@ -1522,7 +1522,7 @@ static void arm_smmu_sync_cd(struct arm_smmu_master *master,
 	for (i = 0; i < master->num_streams; i++)
 		arm_smmu_cmdq_batch_add_cmd(
 			smmu, &cmds,
-			arm_smmu_make_cmd_cfgi_cd(master->streams[i].id, ssid,
+			arm_smmu_make_cmd_cfgi_cd(master->streams[i]->id, ssid,
 						  leaf));
 
 	arm_smmu_cmdq_batch_submit(smmu, &cmds);
@@ -2463,7 +2463,7 @@ static int arm_smmu_atc_inv_master(struct arm_smmu_master *master,
 	for (i = 0; i < master->num_streams; i++)
 		arm_smmu_cmdq_batch_add_cmd(
 			master->smmu, &cmds,
-			arm_smmu_make_cmd_atc_inv_all(master->streams[i].id,
+			arm_smmu_make_cmd_atc_inv_all(master->streams[i]->id,
 						      ssid));
 
 	return arm_smmu_cmdq_batch_submit(master->smmu, &cmds);
@@ -3155,13 +3155,13 @@ void arm_smmu_install_ste_for_dev(struct arm_smmu_master *master,
 		STRTAB_STE_1_EATS_TRANS;
 
 	for (i = 0; i < master->num_streams; ++i) {
-		u32 sid = master->streams[i].id;
+		u32 sid = master->streams[i]->id;
 		struct arm_smmu_ste *step =
 			arm_smmu_get_step_for_sid(smmu, sid);
 
 		/* Bridged PCI devices may end up with duplicated IDs */
 		for (j = 0; j < i; j++)
-			if (master->streams[j].id == sid)
+			if (master->streams[j]->id == sid)
 				break;
 		if (j < i)
 			continue;
@@ -3447,7 +3447,7 @@ arm_smmu_master_build_invs(struct arm_smmu_master *master, bool ats_enabled,
 		 */
 		if (!arm_smmu_master_build_inv(
 			    master, nesting ? INV_TYPE_ATS_FULL : INV_TYPE_ATS,
-			    master->streams[i].id, ssid))
+			    master->streams[i]->id, ssid))
 			return NULL;
 	}
 
@@ -4276,10 +4276,10 @@ static int arm_smmu_init_sid_strtab(struct arm_smmu_device *smmu, u32 sid)
 
 static int arm_smmu_stream_id_cmp(const void *_l, const void *_r)
 {
-	const typeof_member(struct arm_smmu_stream, id) *l = _l;
-	const typeof_member(struct arm_smmu_stream, id) *r = _r;
+	const struct arm_smmu_stream * const *l = _l;
+	const struct arm_smmu_stream * const *r = _r;
 
-	return cmp_int(*l, *r);
+	return cmp_int((*l)->id, (*r)->id);
 }
 
 static int arm_smmu_insert_master(struct arm_smmu_device *smmu,
@@ -4309,10 +4309,16 @@ static int arm_smmu_insert_master(struct arm_smmu_device *smmu,
 	}
 
 	for (i = 0; i < fwspec->num_ids; i++) {
-		struct arm_smmu_stream *new_stream = &master->streams[i];
+		struct arm_smmu_stream *new_stream;
 
+		new_stream = kzalloc_obj(*new_stream, GFP_KERNEL);
+		if (!new_stream) {
+			ret = -ENOMEM;
+			goto out_free_streams;
+		}
 		new_stream->id = fwspec->ids[i];
 		new_stream->master = master;
+		master->streams[i] = new_stream;
 	}
 
 	/* Put the ids into order for sorted to_merge/to_unref arrays */
@@ -4325,11 +4331,11 @@ static int arm_smmu_insert_master(struct arm_smmu_device *smmu,
 	 * which sort_nonatomic() invalidates by relocating the entries.
 	 */
 	for (i = 0; i < fwspec->num_ids; i++)
-		RB_CLEAR_NODE(&master->streams[i].node);
+		RB_CLEAR_NODE(&master->streams[i]->node);
 
 	mutex_lock(&smmu->streams_mutex);
 	for (i = 0; i < fwspec->num_ids; i++) {
-		struct arm_smmu_stream *new_stream = &master->streams[i];
+		struct arm_smmu_stream *new_stream = master->streams[i];
 		struct rb_node *existing;
 		u32 sid = new_stream->id;
 
@@ -4359,14 +4365,21 @@ static int arm_smmu_insert_master(struct arm_smmu_device *smmu,
 
 	if (ret) {
 		for (i--; i >= 0; i--)
-			if (!RB_EMPTY_NODE(&master->streams[i].node))
-				rb_erase(&master->streams[i].node,
+			if (!RB_EMPTY_NODE(&master->streams[i]->node))
+				rb_erase(&master->streams[i]->node,
 					 &smmu->streams);
-		kfree(master->streams);
-		kfree(master->build_invs);
+		mutex_unlock(&smmu->streams_mutex);
+		goto out_free_streams;
 	}
 	mutex_unlock(&smmu->streams_mutex);
 
+	return 0;
+
+out_free_streams:
+	for (i = 0; i < master->num_streams; i++)
+		kfree(master->streams[i]);
+	kfree(master->streams);
+	kfree(master->build_invs);
 	return ret;
 }
 
@@ -4381,10 +4394,13 @@ static void arm_smmu_remove_master(struct arm_smmu_master *master)
 
 	mutex_lock(&smmu->streams_mutex);
 	for (i = 0; i < fwspec->num_ids; i++)
-		if (!RB_EMPTY_NODE(&master->streams[i].node))
-			rb_erase(&master->streams[i].node, &smmu->streams);
+		if (!RB_EMPTY_NODE(&master->streams[i]->node))
+			rb_erase(&master->streams[i]->node, &smmu->streams);
 	mutex_unlock(&smmu->streams_mutex);
 
+	for (i = 0; i < master->num_streams; i++)
+		kfree(master->streams[i]);
+
 	kfree(master->streams);
 	kfree(master->build_invs);
 }
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index bb048e08d613d..56ed6ad1dd523 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -1051,7 +1051,7 @@ struct arm_smmu_event {
 struct arm_smmu_master {
 	struct arm_smmu_device		*smmu;
 	struct device			*dev;
-	struct arm_smmu_stream		*streams;
+	struct arm_smmu_stream		**streams;
 	/*
 	 * Scratch memory for a to_merge or to_unref array to build a per-domain
 	 * invalidation array. It'll be pre-allocated with enough enries for all
diff --git a/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c b/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
index 710a4c694b946..8166cece943c4 100644
--- a/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
+++ b/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
@@ -1257,7 +1257,7 @@ static int tegra241_vintf_init_vsid(struct iommufd_vdevice *vdev)
 	struct arm_smmu_master *master = dev_iommu_priv_get(dev);
 	struct tegra241_vintf *vintf = viommu_to_vintf(vdev->viommu);
 	struct tegra241_vintf_sid *vsid = vdev_to_vsid(vdev);
-	struct arm_smmu_stream *stream = &master->streams[0];
+	struct arm_smmu_stream *stream = master->streams[0];
 	u64 virt_sid = vdev->virt_id;
 	int sidx;
 

-- 
2.34.1

