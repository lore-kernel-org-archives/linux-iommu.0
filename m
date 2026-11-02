Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.69.11
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793601969;
	b=CUxgKERgIz3LIJwF7VLRtlcdDiUsn4Py8QJeD4jiHoJlRa8PrBijMymHG4/ORbWpc61Y
	 LBECy17WHfhecljAjq+w93ie37Y2yRtfqy+Eds99UUbCYF+MrBbrYtJddbjnCMhWHFgBw
	 PRaZ/ZQjKloDNdd4e2dGgnEEl5wfsOLoxH4m1KtHCtBXrZImmQhpo/lEXMvwBiTlA8kkA
	 0Pw4QRg/JUmO/4sBjgmGwd76tpH6dYolKU4iWISOD321TfeWzRNYYHU1F0gQhI5q2Jm9Y
	 ixx+1qunoadJkK/9sdF16qbCMArGyMF1kkdScp5Nvshqa/S4yCaBFGh2bQ7xoCUI3Hw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793601969;
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
	bh=gWZXrh24f5P64f5W7wFP/bDHfxgZfMTleODQcAViQoQ=;
	b=ei5B3eFBD07ZqPpfGDd+rteXgP7pNBABVB4tho2PwWKpj0xyUPWD17XEFc6+PTGZ8FcE
	 OFtVi0wq5zmuGD/mmMXJFqTszZZv3wkVJ3Dk5dfCsGFfhw+/xG6P6cxDu5+fjale5wA5M
	 mPWsmRSl/dEKl56tWKGITm6L3jrOBtLNIZrHjowGSCdf3yS4f2zuEE3gobnAFIOnPS3R2
	 7emi8LE/8y44bLI8DBV2aGe52L0IMNKQzSsTfmvlc9Lmc0QFDSjptyI21uuRQCXndbYz+
	 STD94x7/OFFQgbQecDunP1enyWzor+v/dHivk4DH2156FZV9R2dkkWjSzzn5j0wTElQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=uVX+OOkt;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.69.11
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010011.outbound.protection.outlook.com [52.101.69.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9F7260A2602;
	Mon,  2 Nov 2026 06:46:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E9F7260A2602
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=uVX+OOkt
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KDQYrRiYRFDXjTUbcIANPOAsl7wRc4vkAYxgpnCz4Q8JIATT844wNCslxbBIjohrDIYmbv7hwuFSArPyhIhaPfauP582lXv6dzJ1dQv1/JGN9nT3KXrSV712c7uTTZPEKLmkPVFnLsTggIW9WyHRIVqYGyrpoCAy73yX7hJxeTHpA2Og77raJA3kk3CpDE/qunQpQRiL2QP2wxaFZqON1okY/a59Fri8ragkjnDw9vqsry8XIvdVMl/MciI2rZ1jMEQjY9B8VebisJ4KlojbmVrjbgqPlSfMJTrPnxTz4cMKlXD+GyNUIM7pk5YFzqy6pMwS8nk8vAgjhJ43X1ZNNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gWZXrh24f5P64f5W7wFP/bDHfxgZfMTleODQcAViQoQ=;
 b=Je3Mjd6+J1+ewHxy5ftA+YxDx2S+Y4peg1IFyTBZmJNrVxnMvN5d+gYOofyc4OBqkJ81GFrF3U5UwAK77Zgf+v1/0OEYnOVTsgS9uCOgB+rSGVAu6/fTRfrAOd0otVUAn/i6QeVziMIYhNBATLqH9RfSW8zjcDJJaAPAcPYYT39zA3tu2A6zWUyiOCN8xru8Mam0Q8cTdB+fKkFMxwXCqbZb8XZoVhPkkDnTyQ913wK+SMYXig4L7DxDUg6ucuo5YxiASMv8BfT8rN/dyLqYuNfzI3K2gP0NNb/GDpur5oUQ6eBIb4pQke3gSDCzD8WV+HqlABi0wH0erAlCzu+y5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gWZXrh24f5P64f5W7wFP/bDHfxgZfMTleODQcAViQoQ=;
 b=uVX+OOktjXyZ4iGQeYl8TtrBtYP33QmQdD6icVrIDBBsrPKp/K9YUOpmqPgjV/htfmkp2iicy/6/ywOw3D5YF99BZrsWB8rSucq3zWU6D2fpj12mHVEfsc/8EsXLLOmw4W+9/Iut8h6SP0XdntT0IggbdakC8wAOvjBbPiw+G2XsXrNXEo/MJYi1k5svCSWwCHZzQ9njivgcveeKxhcJ0UP3APwvA8d13c9a1uh7rE6ckVLuKIhJZEtjfGL8ifhCq+EgoeVt7jju5t5V91lfT1j3NUjYvqkaplKyjCyfI8uOkFJId+FtT3rKnqACdCuZICOJ2i6WwL0MMMhRlilCrw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by GV1PR04MB420767.eurprd04.prod.outlook.com (2603:10a6:150:803::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 06:46:03 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%6]) with mapi id 15.21.0569.011; Mon, 2 Nov 2026
 06:46:03 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Mon, 02 Nov 2026 14:50:01 +0800
Subject: [PATCH v3 7/7] arm64: dts: imx95: convert eDMA to per-channel
 child nodes
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261102-edma-iommu-v3-v3-7-9d0e62a954eb@Example.Com>
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
X-ClientProxiedBy: SI3PR01CA0002.apcprd01.prod.exchangelabs.com
 (2603:1096:4:296::9) To AM8PR04MB7874.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|GV1PR04MB420767:EE_
X-MS-Office365-Filtering-Correlation-Id: 5290ccaf-d41f-46f1-ae7f-08df38acf6af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|7416014|376014|23010399003|1800799024|10067099003|22082099003|18002099003|921020|56012099006|11063799006|261021123027099003|261021121427099003|261026140227099003|261022105027099003|261009223027099003|261028144727099003;
X-Microsoft-Antispam-Message-Info:
	5JyHeyGnzjnE+NS+FUfQApOwyWfvo4fB1u7qzDqhSBH7gBYfJNImhrP24ivpMRaghdi14QEAk072dQJ8il5jZNy+mORrJx/fE1vcofkhUjpmqm42QUikU0PvC8usmPSla3Ld0RV311DlSiDWlGalRr0FQxxIkCp++ylBnoJrQOxO3n4nIA+ejcJ8HK2VlprH0pmT93J/CR3+MDhF1CQ+9uLx1a95eG3AQyqcWFWNSmduVrY6Qmdf0wr3u59a1kPd3roNQRzY19wYzBUqCAZeT6wPVOkhsgDljHVqy6QKtb9ekSgW5yZndM2TgVVXg9K5vMJ+rsjJugpnOjXAcOg6vMYVrbSdO0htChUnyQsYnye167g6fM2QXdJkkYEMMKXAVQV88S98KYYXGrWOpciGpqEcuobjSCqp00LhyFgDtZDx2SzUKaDYhB0JG/vZPMTurzku/3i1Q6KCnnAlrviRAlMG2g/bYoh4k7iE0UmrhmmzcXDCrIewAa/JSmFMXGRUHH26tdL56OxceXdGqY7dzmfdBqU7gXRcRPEdqRkIbuXfGy5eJTZABGhh6n88aiI2vtFtpYN7DoCkq3+vPHLvoIx/+34ni/me0UTowvgPssmkLZnNG589s0AXaPP5np83fsmbpgQ+2fjNu4V9VVr1GO6ZFt/UtO9a/zijGjn/8WTKreKWY8cdZWAH3GUI5cXdpR5rMA4d+ldZ6Xu+1Ral7A==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7874.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(7416014)(376014)(23010399003)(1800799024)(10067099003)(22082099003)(18002099003)(921020)(56012099006)(11063799006)(261021123027099003)(261021121427099003)(261026140227099003)(261022105027099003)(261009223027099003)(261028144727099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eFN2bU9aK0x2ODBUeHFjM1hTYXllRUQvYTEyM3V0MTZnUDM5eWVtUHZCbjdn?=
 =?utf-8?B?UHkzckhvcVZISWlZMGQyVndHdE5vbDlJNW9wWUw2eGlYWUFBa2xrcEZTL3ZT?=
 =?utf-8?B?eTNwLzkxb3RzUUcreitZUHVoTTBDQ2dsN3c0Wkt4QkdZa3h4RzhUYTV2WEUv?=
 =?utf-8?B?OXFSWU5wbk05eE9GNENyN1d3T0VLcUpaYkNhMlJYYUhCVVpubVk0bC9JeGx5?=
 =?utf-8?B?YW9XTzdwNUZET3NrU1RpK29SNm1UWWVxUXozWnI4UllRVTdPaUloalE2QnJZ?=
 =?utf-8?B?UllZNjdDcDNCRW4zVGpjWFNzVVRsQmpUc3JCQ1pWaGFhYU41M0ZhQ2dIMER2?=
 =?utf-8?B?NmZVMW1HNFJwek9iV2MxQzhGS21SVnRnTlhzTGNjOEwrakg3VDhUQUlWWThZ?=
 =?utf-8?B?dW1nNThnNWdjdkpPMUMzMEpTUngvcDdoZjVuSXhvMmNqdjgrbFZ1T3I1b1Rj?=
 =?utf-8?B?OE1oNnhjN3B2RmJiaVhYR2RoS3ZWZmNiOWN3dTdqZjEwV0EzK0g2N1E3UHNt?=
 =?utf-8?B?M1hlR3J5OENLWWRLSWR6Nml4Vk01NzhEL05oUytkajdaODZHV2Ura3A0MTJ0?=
 =?utf-8?B?NWgreXExQjFiZzdrTWJtV1NKNlJ6bUd5SHBEazc4Ry9FbkNpNmVRSUFyMGRj?=
 =?utf-8?B?SzBiWmlzVnZJYzB2V2VySDhUR0NLTXhuNi9JWmdBN0F1Tm1SYWl2WDd3L3Nu?=
 =?utf-8?B?MnJkVVpQWHkxN3lwNmg3OWpBU2xEcjBZcFptSXFHTjRiYTUyTmJqbVg0Rzh3?=
 =?utf-8?B?Y0FRMWtUSDNiOC90d1BPUEtGdnN3YWhiR2RVTVNTcXZIZ2J5dndpSTY4QVJL?=
 =?utf-8?B?QWlWT1R4WEVON084YVlQUzkrS09Ma2NUM2lCNzYybEFSMnNFSWxLV3hSanFT?=
 =?utf-8?B?ZFY5KzBVbUY3WU03V0QvQ0VMSjRYYWNXU1NSM1N6TzQ3TU9VUVRIVW1nVUtv?=
 =?utf-8?B?NGRhdnBiOGhjK1FKSVpCbEJ5RExYM0l2aS83ZCtqeUQwR1RPU25hT3NFMWx0?=
 =?utf-8?B?YmxJMDRITThmNmt4NlltbzJ2QU14d0dvZ1RRY2c0YS9pSG5rMmwyb2NjMDVN?=
 =?utf-8?B?Y04zekJzcDZrVjlYRndtTnd6R015K0hGVHBXTVhDRWZIUk01bmRNVWduaVox?=
 =?utf-8?B?N0VlNXd5ZUpyQ0ExYUg1WHJoNzJDTjYzcUtUMnBqdU5CbFB1OG9ENmNJZlRQ?=
 =?utf-8?B?SkV1a3VNdXJYbXY4aXVFeHMrUFFVQ3VvcVRaYmxLVk93Nng3T0NHZ0Rjbm92?=
 =?utf-8?B?VFpuRWNJNmNjWks4UG1NVExVQ2NSdW8xVnpZMEhHWnFIWVNhWGt1MVVnTFVE?=
 =?utf-8?B?WHluZjZ6ODFvL003TUVIaG42bzQrRS9kZEFNYlhFRmh1SDF6YTZqRzVvTmx3?=
 =?utf-8?B?VkhBVjI4a3hESEYyWXJtUk11UXZPbmQ4aDI4NVpVNUR0TmkyUCs3UlBDK3BC?=
 =?utf-8?B?NlYzM1hQWWhYZnZjY0drMlRzUnZBQ3VPZFV4RTVmUHg5V0VKUEdxMHBLckQ2?=
 =?utf-8?B?SmxndE8xaGtxOHJpeTJ4cFZSMkZIaS8zdDg4cCtTUERkeHFtdGFVZTZ4d2pC?=
 =?utf-8?B?NVhKN0s3SlFYbGhZUTBnRXpaQlJvNjYyS1ZCQ0dFQ2NYdnlZaVM3QnBXVnIx?=
 =?utf-8?B?RGRyMVo0aURGMDZ4OTdqU1ZLZlMxTmlRY2RtamNveDlENXFOdEtxdG1la2VR?=
 =?utf-8?B?K1VvTmowUU9HRGNkS1NZY0ZCRlR5Qy9raXdpY0NIMVpBY3pPVnoyc3hHU3BS?=
 =?utf-8?B?NHdmSTVHSDh0NGxma0lVdU9DbGVCZjg2RVZnWnoyS0tLTEZ4TVA3bFc0RW9I?=
 =?utf-8?B?Q3lFUlVOOEMwcmZpWEhROXN3S0tlRnRyemFyOUk4QXBLZ1dxQWgyR3FWWXE0?=
 =?utf-8?B?cGt4VzNQaHpOSmh5ejk0RGVIQ2VlelEwT2tVRk5LVks4Zlc5eGpnZHp5UHcx?=
 =?utf-8?B?aVoxZWFsazdGT0k0RmxQWWJwdWFjYlVkenVhMEhCOU5VWHVnczZ2S2JEZkR0?=
 =?utf-8?B?cythUkZ1Y0d6dXN5djFlV0xrdU5zZFNNYkc2MTMrbytOcENhcU5oRzQrQ0tL?=
 =?utf-8?B?RG40Z2x6bFcxTWZwa0pxTjZDZ2lxY3FoaVhGSHJPRjJEOEhVWCtmYWV4QjJz?=
 =?utf-8?B?ZkJTQXg5UjdzTE9LOXcxV0NDZXRad1NOYlZLUkgvS3dZN2lMTWRJb1duWHRV?=
 =?utf-8?B?Zko0NFgrRTZmV2ZmN2lzUHViZVQzSERCbVkzVU1oKzEyNXZWdFdocWU4YVVG?=
 =?utf-8?B?c0sxMHRzSDJxSmZJSDNOc0VhcU83ak1ybXEyckdISDVYblR1OVozWHEybGlR?=
 =?utf-8?B?MTZIMitLZU9INU1KUkxmclRyM1M1czFjK29WcGVwR1BScDkrejhkejZoN0Uz?=
 =?utf-8?Q?pW/Mcny4kHXerjn9Cz/OI8S0mlXNmgJO6EiDV?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5290ccaf-d41f-46f1-ae7f-08df38acf6af
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 06:46:03.7588
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BXb0OmxQoJdqrQMvF5kyIUZdBwzVpJu5AxWSuydAkAqUxvlgAmFdE5WX5N9Ki6lUNAcLQ4bV7kTKkfvz0L0WCr6K5243zF25Xv4aB6oKcLRLcYrSs7QXowcNL/czfatj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB420767

From: Peng Fan <peng.fan@nxp.com>

Convert edma2 and edma3 from flat interrupt arrays at the parent node
to per-channel child nodes (dma-channel@<addr>). Each child carries
its own reg (real per-channel MMIO region) and interrupts property.

edma2 (64 channels at 0x42000000):
  - Channel N at 0x42010000 + N * 0x8000 (size 0x8000)
  - Paired interrupts: SPI 128-159, two channels per SPI

edma3 (64 channels at 0x42210000):
  - Channel N at 0x42220000 + N * 0x8000 (size 0x8000)
  - Paired interrupts: SPI 256-287, two channels per SPI

edma1 (imx93-edma3, 31 channels with 1:1 non-paired interrupts) is
left unchanged as it uses a different interrupt scheme.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx95.dtsi | 774 ++++++++++++++++++++++++++-----
 1 file changed, 646 insertions(+), 128 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx95.dtsi b/arch/arm64/boot/dts/freescale/imx95.dtsi
index d20c2498b9aa2..64570703ce6cb 100644
--- a/arch/arm64/boot/dts/freescale/imx95.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx95.dtsi
@@ -635,148 +635,666 @@ edma2: dma-controller@42000000 {
 				compatible = "fsl,imx95-edma5";
 				reg = <0x42000000 0x210000>;
 				#dma-cells = <3>;
+				#address-cells = <1>;
+				#size-cells = <1>;
+				ranges;
 				dma-channels = <64>;
 				/* channels 0 and 1 reserved for V2X fast hash */
 				dma-channel-mask = <0x3>;
-				interrupts = <GIC_SPI 128 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 128 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 129 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 129 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 130 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 130 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 132 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 132 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 133 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 133 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 134 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 134 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 135 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 135 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 136 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 136 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 137 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 137 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 138 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 138 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 139 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 139 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 140 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 140 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 141 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 141 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 142 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 142 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 143 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 143 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 144 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 144 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 146 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 146 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 147 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 147 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 148 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 148 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 149 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 149 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 150 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 150 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 151 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 151 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 152 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 152 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 153 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 153 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 154 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 154 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 155 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 155 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 156 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 156 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 157 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 157 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 158 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 158 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 159 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 159 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&scmi_clk IMX95_CLK_BUSWAKEUP>;
 				clock-names = "dma";
+
+				dma-channel@42010000 {
+					reg = <0x42010000 0x8000>;
+					interrupts = <GIC_SPI 128 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@42018000 {
+					reg = <0x42018000 0x8000>;
+					interrupts = <GIC_SPI 128 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@42020000 {
+					reg = <0x42020000 0x8000>;
+					interrupts = <GIC_SPI 129 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@42028000 {
+					reg = <0x42028000 0x8000>;
+					interrupts = <GIC_SPI 129 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@42030000 {
+					reg = <0x42030000 0x8000>;
+					interrupts = <GIC_SPI 130 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@42038000 {
+					reg = <0x42038000 0x8000>;
+					interrupts = <GIC_SPI 130 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@42040000 {
+					reg = <0x42040000 0x8000>;
+					interrupts = <GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@42048000 {
+					reg = <0x42048000 0x8000>;
+					interrupts = <GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@42050000 {
+					reg = <0x42050000 0x8000>;
+					interrupts = <GIC_SPI 132 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@42058000 {
+					reg = <0x42058000 0x8000>;
+					interrupts = <GIC_SPI 132 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@42060000 {
+					reg = <0x42060000 0x8000>;
+					interrupts = <GIC_SPI 133 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@42068000 {
+					reg = <0x42068000 0x8000>;
+					interrupts = <GIC_SPI 133 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@42070000 {
+					reg = <0x42070000 0x8000>;
+					interrupts = <GIC_SPI 134 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@42078000 {
+					reg = <0x42078000 0x8000>;
+					interrupts = <GIC_SPI 134 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@42080000 {
+					reg = <0x42080000 0x8000>;
+					interrupts = <GIC_SPI 135 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@42088000 {
+					reg = <0x42088000 0x8000>;
+					interrupts = <GIC_SPI 135 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@42090000 {
+					reg = <0x42090000 0x8000>;
+					interrupts = <GIC_SPI 136 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@42098000 {
+					reg = <0x42098000 0x8000>;
+					interrupts = <GIC_SPI 136 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@420a0000 {
+					reg = <0x420a0000 0x8000>;
+					interrupts = <GIC_SPI 137 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@420a8000 {
+					reg = <0x420a8000 0x8000>;
+					interrupts = <GIC_SPI 137 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@420b0000 {
+					reg = <0x420b0000 0x8000>;
+					interrupts = <GIC_SPI 138 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@420b8000 {
+					reg = <0x420b8000 0x8000>;
+					interrupts = <GIC_SPI 138 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@420c0000 {
+					reg = <0x420c0000 0x8000>;
+					interrupts = <GIC_SPI 139 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@420c8000 {
+					reg = <0x420c8000 0x8000>;
+					interrupts = <GIC_SPI 139 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@420d0000 {
+					reg = <0x420d0000 0x8000>;
+					interrupts = <GIC_SPI 140 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@420d8000 {
+					reg = <0x420d8000 0x8000>;
+					interrupts = <GIC_SPI 140 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@420e0000 {
+					reg = <0x420e0000 0x8000>;
+					interrupts = <GIC_SPI 141 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@420e8000 {
+					reg = <0x420e8000 0x8000>;
+					interrupts = <GIC_SPI 141 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@420f0000 {
+					reg = <0x420f0000 0x8000>;
+					interrupts = <GIC_SPI 142 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@420f8000 {
+					reg = <0x420f8000 0x8000>;
+					interrupts = <GIC_SPI 142 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@42100000 {
+					reg = <0x42100000 0x8000>;
+					interrupts = <GIC_SPI 143 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@42108000 {
+					reg = <0x42108000 0x8000>;
+					interrupts = <GIC_SPI 143 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@42110000 {
+					reg = <0x42110000 0x8000>;
+					interrupts = <GIC_SPI 144 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@42118000 {
+					reg = <0x42118000 0x8000>;
+					interrupts = <GIC_SPI 144 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@42120000 {
+					reg = <0x42120000 0x8000>;
+					interrupts = <GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@42128000 {
+					reg = <0x42128000 0x8000>;
+					interrupts = <GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@42130000 {
+					reg = <0x42130000 0x8000>;
+					interrupts = <GIC_SPI 146 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@42138000 {
+					reg = <0x42138000 0x8000>;
+					interrupts = <GIC_SPI 146 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@42140000 {
+					reg = <0x42140000 0x8000>;
+					interrupts = <GIC_SPI 147 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@42148000 {
+					reg = <0x42148000 0x8000>;
+					interrupts = <GIC_SPI 147 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@42150000 {
+					reg = <0x42150000 0x8000>;
+					interrupts = <GIC_SPI 148 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@42158000 {
+					reg = <0x42158000 0x8000>;
+					interrupts = <GIC_SPI 148 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@42160000 {
+					reg = <0x42160000 0x8000>;
+					interrupts = <GIC_SPI 149 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@42168000 {
+					reg = <0x42168000 0x8000>;
+					interrupts = <GIC_SPI 149 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@42170000 {
+					reg = <0x42170000 0x8000>;
+					interrupts = <GIC_SPI 150 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@42178000 {
+					reg = <0x42178000 0x8000>;
+					interrupts = <GIC_SPI 150 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@42180000 {
+					reg = <0x42180000 0x8000>;
+					interrupts = <GIC_SPI 151 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@42188000 {
+					reg = <0x42188000 0x8000>;
+					interrupts = <GIC_SPI 151 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@42190000 {
+					reg = <0x42190000 0x8000>;
+					interrupts = <GIC_SPI 152 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@42198000 {
+					reg = <0x42198000 0x8000>;
+					interrupts = <GIC_SPI 152 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@421a0000 {
+					reg = <0x421a0000 0x8000>;
+					interrupts = <GIC_SPI 153 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@421a8000 {
+					reg = <0x421a8000 0x8000>;
+					interrupts = <GIC_SPI 153 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@421b0000 {
+					reg = <0x421b0000 0x8000>;
+					interrupts = <GIC_SPI 154 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@421b8000 {
+					reg = <0x421b8000 0x8000>;
+					interrupts = <GIC_SPI 154 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@421c0000 {
+					reg = <0x421c0000 0x8000>;
+					interrupts = <GIC_SPI 155 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@421c8000 {
+					reg = <0x421c8000 0x8000>;
+					interrupts = <GIC_SPI 155 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@421d0000 {
+					reg = <0x421d0000 0x8000>;
+					interrupts = <GIC_SPI 156 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@421d8000 {
+					reg = <0x421d8000 0x8000>;
+					interrupts = <GIC_SPI 156 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@421e0000 {
+					reg = <0x421e0000 0x8000>;
+					interrupts = <GIC_SPI 157 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@421e8000 {
+					reg = <0x421e8000 0x8000>;
+					interrupts = <GIC_SPI 157 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@421f0000 {
+					reg = <0x421f0000 0x8000>;
+					interrupts = <GIC_SPI 158 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@421f8000 {
+					reg = <0x421f8000 0x8000>;
+					interrupts = <GIC_SPI 158 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@42200000 {
+					reg = <0x42200000 0x8000>;
+					interrupts = <GIC_SPI 159 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@42208000 {
+					reg = <0x42208000 0x8000>;
+					interrupts = <GIC_SPI 159 IRQ_TYPE_LEVEL_HIGH>;
+				};
 			};
 
 			edma3: dma-controller@42210000 {
 				compatible = "fsl,imx95-edma5";
 				reg = <0x42210000 0x210000>;
 				#dma-cells = <3>;
+				#address-cells = <1>;
+				#size-cells = <1>;
+				ranges;
 				dma-channels = <64>;
-				interrupts = <GIC_SPI 256 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 256 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 257 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 257 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 258 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 258 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 259 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 259 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 260 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 260 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 261 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 261 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 262 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 262 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 263 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 263 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 264 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 264 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 265 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 265 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 266 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 266 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 267 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 267 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 268 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 268 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 269 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 269 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 270 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 270 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 271 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 271 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 272 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 272 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 273 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 273 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 274 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 274 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 275 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 275 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 276 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 276 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 277 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 277 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 278 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 278 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 279 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 279 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 280 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 280 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 281 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 281 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 282 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 282 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 283 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 283 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 284 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 284 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 285 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 285 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 286 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 286 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 287 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 287 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&scmi_clk IMX95_CLK_BUSWAKEUP>;
 				clock-names = "dma";
+
+				dma-channel@42220000 {
+					reg = <0x42220000 0x8000>;
+					interrupts = <GIC_SPI 256 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@42228000 {
+					reg = <0x42228000 0x8000>;
+					interrupts = <GIC_SPI 256 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@42230000 {
+					reg = <0x42230000 0x8000>;
+					interrupts = <GIC_SPI 257 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@42238000 {
+					reg = <0x42238000 0x8000>;
+					interrupts = <GIC_SPI 257 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@42240000 {
+					reg = <0x42240000 0x8000>;
+					interrupts = <GIC_SPI 258 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@42248000 {
+					reg = <0x42248000 0x8000>;
+					interrupts = <GIC_SPI 258 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@42250000 {
+					reg = <0x42250000 0x8000>;
+					interrupts = <GIC_SPI 259 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@42258000 {
+					reg = <0x42258000 0x8000>;
+					interrupts = <GIC_SPI 259 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@42260000 {
+					reg = <0x42260000 0x8000>;
+					interrupts = <GIC_SPI 260 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@42268000 {
+					reg = <0x42268000 0x8000>;
+					interrupts = <GIC_SPI 260 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@42270000 {
+					reg = <0x42270000 0x8000>;
+					interrupts = <GIC_SPI 261 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@42278000 {
+					reg = <0x42278000 0x8000>;
+					interrupts = <GIC_SPI 261 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@42280000 {
+					reg = <0x42280000 0x8000>;
+					interrupts = <GIC_SPI 262 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@42288000 {
+					reg = <0x42288000 0x8000>;
+					interrupts = <GIC_SPI 262 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@42290000 {
+					reg = <0x42290000 0x8000>;
+					interrupts = <GIC_SPI 263 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@42298000 {
+					reg = <0x42298000 0x8000>;
+					interrupts = <GIC_SPI 263 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@422a0000 {
+					reg = <0x422a0000 0x8000>;
+					interrupts = <GIC_SPI 264 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@422a8000 {
+					reg = <0x422a8000 0x8000>;
+					interrupts = <GIC_SPI 264 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@422b0000 {
+					reg = <0x422b0000 0x8000>;
+					interrupts = <GIC_SPI 265 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@422b8000 {
+					reg = <0x422b8000 0x8000>;
+					interrupts = <GIC_SPI 265 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@422c0000 {
+					reg = <0x422c0000 0x8000>;
+					interrupts = <GIC_SPI 266 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@422c8000 {
+					reg = <0x422c8000 0x8000>;
+					interrupts = <GIC_SPI 266 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@422d0000 {
+					reg = <0x422d0000 0x8000>;
+					interrupts = <GIC_SPI 267 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@422d8000 {
+					reg = <0x422d8000 0x8000>;
+					interrupts = <GIC_SPI 267 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@422e0000 {
+					reg = <0x422e0000 0x8000>;
+					interrupts = <GIC_SPI 268 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@422e8000 {
+					reg = <0x422e8000 0x8000>;
+					interrupts = <GIC_SPI 268 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@422f0000 {
+					reg = <0x422f0000 0x8000>;
+					interrupts = <GIC_SPI 269 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@422f8000 {
+					reg = <0x422f8000 0x8000>;
+					interrupts = <GIC_SPI 269 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@42300000 {
+					reg = <0x42300000 0x8000>;
+					interrupts = <GIC_SPI 270 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@42308000 {
+					reg = <0x42308000 0x8000>;
+					interrupts = <GIC_SPI 270 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@42310000 {
+					reg = <0x42310000 0x8000>;
+					interrupts = <GIC_SPI 271 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@42318000 {
+					reg = <0x42318000 0x8000>;
+					interrupts = <GIC_SPI 271 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@42320000 {
+					reg = <0x42320000 0x8000>;
+					interrupts = <GIC_SPI 272 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@42328000 {
+					reg = <0x42328000 0x8000>;
+					interrupts = <GIC_SPI 272 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@42330000 {
+					reg = <0x42330000 0x8000>;
+					interrupts = <GIC_SPI 273 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@42338000 {
+					reg = <0x42338000 0x8000>;
+					interrupts = <GIC_SPI 273 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@42340000 {
+					reg = <0x42340000 0x8000>;
+					interrupts = <GIC_SPI 274 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@42348000 {
+					reg = <0x42348000 0x8000>;
+					interrupts = <GIC_SPI 274 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@42350000 {
+					reg = <0x42350000 0x8000>;
+					interrupts = <GIC_SPI 275 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@42358000 {
+					reg = <0x42358000 0x8000>;
+					interrupts = <GIC_SPI 275 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@42360000 {
+					reg = <0x42360000 0x8000>;
+					interrupts = <GIC_SPI 276 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@42368000 {
+					reg = <0x42368000 0x8000>;
+					interrupts = <GIC_SPI 276 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@42370000 {
+					reg = <0x42370000 0x8000>;
+					interrupts = <GIC_SPI 277 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@42378000 {
+					reg = <0x42378000 0x8000>;
+					interrupts = <GIC_SPI 277 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@42380000 {
+					reg = <0x42380000 0x8000>;
+					interrupts = <GIC_SPI 278 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@42388000 {
+					reg = <0x42388000 0x8000>;
+					interrupts = <GIC_SPI 278 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@42390000 {
+					reg = <0x42390000 0x8000>;
+					interrupts = <GIC_SPI 279 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@42398000 {
+					reg = <0x42398000 0x8000>;
+					interrupts = <GIC_SPI 279 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@423a0000 {
+					reg = <0x423a0000 0x8000>;
+					interrupts = <GIC_SPI 280 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@423a8000 {
+					reg = <0x423a8000 0x8000>;
+					interrupts = <GIC_SPI 280 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@423b0000 {
+					reg = <0x423b0000 0x8000>;
+					interrupts = <GIC_SPI 281 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@423b8000 {
+					reg = <0x423b8000 0x8000>;
+					interrupts = <GIC_SPI 281 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@423c0000 {
+					reg = <0x423c0000 0x8000>;
+					interrupts = <GIC_SPI 282 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@423c8000 {
+					reg = <0x423c8000 0x8000>;
+					interrupts = <GIC_SPI 282 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@423d0000 {
+					reg = <0x423d0000 0x8000>;
+					interrupts = <GIC_SPI 283 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@423d8000 {
+					reg = <0x423d8000 0x8000>;
+					interrupts = <GIC_SPI 283 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@423e0000 {
+					reg = <0x423e0000 0x8000>;
+					interrupts = <GIC_SPI 284 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@423e8000 {
+					reg = <0x423e8000 0x8000>;
+					interrupts = <GIC_SPI 284 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@423f0000 {
+					reg = <0x423f0000 0x8000>;
+					interrupts = <GIC_SPI 285 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@423f8000 {
+					reg = <0x423f8000 0x8000>;
+					interrupts = <GIC_SPI 285 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@42400000 {
+					reg = <0x42400000 0x8000>;
+					interrupts = <GIC_SPI 286 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@42408000 {
+					reg = <0x42408000 0x8000>;
+					interrupts = <GIC_SPI 286 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@42410000 {
+					reg = <0x42410000 0x8000>;
+					interrupts = <GIC_SPI 287 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@42418000 {
+					reg = <0x42418000 0x8000>;
+					interrupts = <GIC_SPI 287 IRQ_TYPE_LEVEL_HIGH>;
+				};
 			};
 
 			mu7: mailbox@42430000 {

-- 
2.34.1

