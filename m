Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013020.outbound.protection.outlook.com [40.107.162.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81BCC38F928
	for <iommu@lists.linux.dev>; Wed, 16 Sep 2026 15:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789571969; cv=fail; b=OHZJt370z2mMtJyhHRijStvY72J8Iu3a+OXHCQnLlqGM3Hg56idX5H5pmyown7jiS3Z1SoApsrMShd8kHcm2Nl7R1hEYkAAVoi9UqXb4hh81NmJ51w1+lw2mq0JFBRVhGuqeGPUbxCCNyYPLipQtGhKaXqWLGwgKAjxZWZE2LvY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789571969; c=relaxed/simple;
	bh=0w+H1wYsfvrz6ODoYCZ/Ve764sXHSpput8jKEf2mRJU=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=VxLvjCi74MPEN2aZ7kBVau5214S8qh1SOU3cp5PU/1fZCj7ch3arBc9HiDYftD1bovsz0ODa8I4KblwujG5GzbQv2eVZcf0Ny7Zw6VT17ByWO9tS/n+gJgvny9J+VAOVDvgOZcsjAEMmqEI3kXLtHDPYWZk/hhnZCSyYE7loBYQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=O1KTE9hh; arc=fail smtp.client-ip=40.107.162.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="O1KTE9hh"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p+qgYSDY5lFsrtbg3ouLAjw1xaXm2dVmnpslZ2rZ2rPmCWR8gjo3hOKbbo75DwcumKILMTcOI8xB1yctGugekDp8P1k8oeWKpUnvv74rrjwvmy3twa52OHlM6dSRAtLMwyT4Z00BYhMrxh7megmObbptq0MqaaDFFBw5RZNbXIxbbihNJN+wkLbRsii+FZlPppHPtArzYPyk8xxCUY08K5pVJmldzD5CA09wdYTnkoTnuIRkjjP9PVmWoVefUGV5EQgJVH3+4pNVn0lbEdn5C9QdkyTuwkvnP5raQGIe3ZNG+DjjRxQxITQVYCc/B5aG48wBUdul7ndSAthay87usA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XuYMxwS7R6YC1+RuwqQJ2SJ74S8+U6IUpNQhMUIlE7Y=;
 b=xL25TcLQBIOBgiHvb0ZxgIC2lDBx7o1gS2nCeYyXRmIkmgj9iqw6A1MQd4JwJvuzsjCLlq1VxjgODDmIppKI9vSS9Qtht4DUXfcvR9AyMr4p/zxiPbhEDJLpXyU+kCVk90JBaH65E7fkGnJXk7/nR8X9c/FqG6+I9lQm4Jt4xnozTaqPji/OcTYDIX+okjzgktqraXMDdV9FmEkn8gwFDurKIGaT15TyvxBVmh1YnZH5Vpflbpy8BLng86Dw1OfmuNwsdIFh/4XjO8SrP3Z3QrZF5XJ1llV30YuhTwzHQjOmm1xyosvCisYxAs4U3xhg9wCRal2JHGKQ7FqYcShSdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XuYMxwS7R6YC1+RuwqQJ2SJ74S8+U6IUpNQhMUIlE7Y=;
 b=O1KTE9hhl137YeFvpgPaSA7KyA+A7FRXBD5sUAhW4+BQJ/FfW70W/KAgmjO9Oa+LcmScf+iaszYS6aABeJPSGry65HUlfvciI9YiApCuGaod4+TSVnCrddlTtnLMODUw4QYSRBIYf3/N6tt9Y9gqW1oN6VRiiKmTC8/IHKlUWV1ENpNSeIXtpIgTeNbgaXlfYMkHQ6/RCOWeMNt+uN+bsKRjL0AYTZn+sBwjWMDzD7p+wlTX/w7vMoyGp6PoZN09z0J+gRO5f8Ger0OUq24vdhU2iDr0kdMdtgEiTgrE2TqrYVUOxdgv5EbCGY9k6IfgjXKfxswTUHlcoo5MjOjkPQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by PA6PR04MB11912.eurprd04.prod.outlook.com (2603:10a6:102:51a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Wed, 16 Sep
 2026 15:19:25 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%6]) with mapi id 15.21.0428.009; Wed, 16 Sep 2026
 15:19:24 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Wed, 16 Sep 2026 23:23:33 +0800
Subject: [PATCH RFC 1/2] iommu/dma: skip swiotlb bounce for DMA_ATTR_MMIO
 in iommu_dma_map_phys
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260916-iommu-dma-fix-v1-1-a59a0c45ec5b@nxp.com>
References: <20260916-iommu-dma-fix-v1-0-a59a0c45ec5b@nxp.com>
In-Reply-To: <20260916-iommu-dma-fix-v1-0-a59a0c45ec5b@nxp.com>
To: Robin Murphy <robin.murphy@arm.com>, 
 "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
 Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, 
 Marek Szyprowski <m.szyprowski@samsung.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.16-dev-7bc12
X-ClientProxiedBy: MA5P287CA0272.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1f2::11) To AM8PR04MB7874.eurprd04.prod.outlook.com
 (2603:10a6:20b:24d::9)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|PA6PR04MB11912:EE_
X-MS-Office365-Filtering-Correlation-Id: 5cf6594e-1f1e-4d3c-0d7e-08df1405e3f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|23010399003|1800799024|376014|366016|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	LDGWym9/L3LIiiGp3oQ6GdqTNuIabE5Qm7ITHcT7X6JOFiQnYlxqI6oorR1hmkSjZuxxPnR7HkI4KrNrzuy8xurmPu1saJeZ429Gs0kbqfPvIE8Fv4q9KFpYPmqec/T7PdK9Y4ilIy0gnIoGN5hQY7jSjeZ1cHf0w4c61y6GESeEad/qGVmM4w1fUM3PhZieeBD6O9OSzSqpCBrjhkUaYzMoIkQdbi232jG7NqdybewB2Akqb/X4JXRIcE0Y1EyHJqpbUeDsDjoWM2IKDyHTo4sX2SjBwlVlhE2pfZ8VrBRP2zDEAFCD7KumVelUzMjutRQ6ljVEt8ubNMFFnL7mOWngwU3gnIz8mp0DS+8iKR3YOCX4ozRkSF4WD8I/dm1tqNhfLHOtWxMwWVWSUHAcV+Xpl3PKrpFleFNjA15JqnR93Qh2nSodkBLherTBEE1pPy1QNvVcwyv1k7o2k1jWi7EDC3AA++beuEx0HCopmLLiPfDLmnnNW3heBte87WUI2A72ypIEMIfgKc0T/TpqjfRR2jxI1hAgTjgQwJSgry/XZZTlWZgGDQu5ZK1IHAS+WmEvgo9/tIG7EWhqbvrepBYfm5+mXstGB0Qzw3Ynd6KgzYJKTpGO1uPM02GFp2ll55BJxi0tjzzNd7OmK1b/MNLysJW4kaxo2HNvSsrb3ps=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7874.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(23010399003)(1800799024)(376014)(366016)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NHo5YVNDRlNBVHRuZGtzam5CdVVqcVN6V3VHejJRQ3Rsd283bUorU0xkTURu?=
 =?utf-8?B?dnV2RzFLdVJHdUZnQlhxOXdQSTdtZjRXbE5oQmJuSjgwT0FFbnRIM0pmREFG?=
 =?utf-8?B?Z1JTUFVSOEpFUDFIdXJkLzQ5U3RuT1pCSUxEczE4Nk5keDdwcWVLbFp0NlFM?=
 =?utf-8?B?UEZKRHRFQ01iM3dMcy81M3gwUDg4aE5QcS8rYm1KNHhOdzdjalZybEpNUk9H?=
 =?utf-8?B?NHBVcm4vclBYd3ZwVTF5U2tvd2lpMzFOTXNvOHJNaTJNNXBxUnNJMTlydzhx?=
 =?utf-8?B?K2lrN0F6S1ZsTTBiMzUwNzNNNVBmK2I1Z29jVVZTWmlEdzlzbG5UZVhyNVdS?=
 =?utf-8?B?a3BuU3E4SndWWXN3dHZsMGtZNlZjeC9tSmdvTkgvM2FFQUY2Qnp2UHFqRGo0?=
 =?utf-8?B?RU1hblB6MERabWs2MjQ0ckJDTEpMRkVvWStDMkxlOGsvYXpuU2JwMWVWRm5H?=
 =?utf-8?B?L1NMM3Q1cmF6NER0OTMzOW5sbFN5c0tnTHd6a29ZQlZ1UTcvWkJHSnYybW5T?=
 =?utf-8?B?dlI2VkRuSzcyajU1TWhxeHVPTTNWZ2h6cUppeFFnd0ZIV0VlM2hoMU96d0s2?=
 =?utf-8?B?Wk9FSzhaR2k3dHBmUy85OENiRnU2aVBHQS90anFkVDVaRGJKS0lxNW1uSE1Q?=
 =?utf-8?B?L0F3VEJPMlFMRjU3bkIvWTFjUGM1dmIyWHl0MEdnR1d4dEpHZ0ZiWmhrSGo2?=
 =?utf-8?B?Wmh2THduNUR3TCs5THdGK3JEbFBnQUpteHNsSGR1d2pOcXlVMzgxZERsT3d0?=
 =?utf-8?B?TGVreS82SmVlTWxiVG1yQ0Q0VERtTHhxbDQ3SU5EOFNmRG5XMFFjdGg0VXhz?=
 =?utf-8?B?T0tpcERJaG1aYXVLbWh6MHdxMC9xWmJZMmxYUFdEUjU3UHowSkU2VmN2VElo?=
 =?utf-8?B?T1ZkTFpNbkNSTVZ6Zk9CekcwSCtsVlkzSDJGWUprM2hHc2tYdFNwcWpUYzF4?=
 =?utf-8?B?Vm1jUHlVTkN3MlJhT0NySyt5cmhWQlVYZWV1TW90WHpkMmliMUViVGh4VVFG?=
 =?utf-8?B?Q0pubXAvN1VmeTRqcjdFK3B0WnlMdUNXK0o5M1hvT0krYlJMdGtHT2dGbkVZ?=
 =?utf-8?B?QkdGMmxPaUFJck55QnJDZkFWQkZVSUk5cTFZZHdTTE5pVm5vbjdyWGxOME5x?=
 =?utf-8?B?eVJ5WVpCOGJDNGU3WXBzZ3BpNS81UUNSeXRHQzJuVWZSZXBVTVU4S1J3cStr?=
 =?utf-8?B?dVBWZ1pvaVg5OHprczA5dXlOTDdUMFhPUGZWR2hRbVZZT213WGpsTFdBNDIw?=
 =?utf-8?B?dkNERWswcjJoc09jQmV4N01YeGtMbTJDcVNKVjdHcG1Dd1h1M0dpbmFRekF1?=
 =?utf-8?B?bnBUZmVEaXZCM2Zzb1greGo2bEhzdnYySVp1d2dEYXJIZzI3RG5jNEhEdHI2?=
 =?utf-8?B?VU1hQURZZnBSa252RkE4WEVhMUNEcmF4L1NhMEUwdnAxYnEvYk9QbDBER25Q?=
 =?utf-8?B?SytUMTVvWGU5TVllV0t3VklHTGJtYXNLU3NvWWN4aWJqWjlRdlh4Y3ZsaTJk?=
 =?utf-8?B?a1ZuOXMyMHNXQ2tyUVpGWGttZk9xUWxSV1hwNUhITjJOZmV6VGRSQXAyUUw2?=
 =?utf-8?B?N3M1dU5KaTl6ZkNLZzBEam1DVXhNM2dRVVl4dGFWbm5HWHNDQ3gyVEFpbXpY?=
 =?utf-8?B?cm0wcWQrQWhvQmNGZDdsMzhmTEo2ajNTdVVGam92cDNDcDhXVzdmZnhJbS9D?=
 =?utf-8?B?ZmxsWHhZTWJ2Qnd3UHJrSzVraDFWallKU2dDbk9DUDEvR3h3dmVXQ24vNHp2?=
 =?utf-8?B?S21Pa0ozYmZJNFFJYk5UT1ZUU2EraWk4VVMrSHlTNTk5Y3RIdE1JbXZoZVJP?=
 =?utf-8?B?cmoycC85ZWJtUmw3REFjcmwweWtQbzdLaWNDcmVuMmpmMjV3d0VjbVh6SFVj?=
 =?utf-8?B?anRTekErbmRiREp1ejNFbFRrVUUwNE40OENGMWhqY2sxSkkvYnJMeHdxRnBp?=
 =?utf-8?B?NFE1am16aG9XamdpRnc2WG5DblRZbFV4TURuSDViZG5pdDFCOWlGVXd6MDly?=
 =?utf-8?B?aFIvQ2NPMVlhaWJHTHJNdmxDRzBHaE9wZklYb1Bvai9oQWRmcWwycUVicDEx?=
 =?utf-8?B?ZDNFbDRBc2VPaG5nTXo0MFoyNUt2Nk5icExNVks4U2VRSS9ROXNIcUZaTW1n?=
 =?utf-8?B?MDVibnRobDY1V1JpWGxPNEVWT3BEUFFrU29jSTQ2dk9qQ0c0UkZwRFNSclF5?=
 =?utf-8?B?c1A5U1JQUTB3eVp6MkhuZCtJblQ4U0xMQTRDWHNzeHpjWmhDQmhSaTJSWCtj?=
 =?utf-8?B?R3doV01mNFVKaGZOMHpmbGlpVGRNV2JJcUNTMG0rem8raXhzNTBQNzMrWXhj?=
 =?utf-8?B?dWIvd2VuS24yenZ4bFZzVEdZc1FJU2VGK3hIT3FNWjVYbjdEdmRPbGNkcE9m?=
 =?utf-8?Q?rCG1lSTkKQUOjBG4Ca60im47czqeEPZ21AFaF?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cf6594e-1f1e-4d3c-0d7e-08df1405e3f1
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 15:19:24.2945
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5qaYVzfim8NHWvFCnRAFT0RNZRDzCg3T3gibsFAONMtZ2ZmyC58IT/9liAMTsEzjNnhsM6iTRazHE9UsqI9t6pE/2sGUbafhlWjfjf3zWz7GB/teHIXBvaH2OUW1hakk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA6PR04MB11912

From: Peng Fan <peng.fan@nxp.com>

MMIO resources mapped via dma_map_resource() carry DMA_ATTR_MMIO. These
never need swiotlb bounce buffering, but the current code enters the
swiotlb path when the physical address is not page-aligned, then rejects
the mapping because MMIO cannot be bounced.

Move the DMA_ATTR_MMIO check before the swiotlb block so the entire bounce
path is skipped for MMIO, falling through directly to __iommu_dma_map()
which creates the IOVA mapping.

Fixes: f9374de14c0e8 ("iommu/dma: implement DMA_ATTR_MMIO for iommu_dma_(un)map_phys()")
Assisted-by: Claude:claude-opus-4-6
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/iommu/dma-iommu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 65d692ec7fced..26b9c2d71cd30 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -1228,9 +1228,9 @@ dma_addr_t iommu_dma_map_phys(struct device *dev, phys_addr_t phys, size_t size,
 	 * If both the physical buffer start address and size are page aligned,
 	 * we don't need to use a bounce page.
 	 */
-	if (dev_use_swiotlb(dev, size, dir) &&
+	if (!(attrs & DMA_ATTR_MMIO) && dev_use_swiotlb(dev, size, dir) &&
 	    iova_unaligned(iovad, phys, size)) {
-		if (attrs & (DMA_ATTR_MMIO | DMA_ATTR_REQUIRE_COHERENT))
+		if (attrs & DMA_ATTR_REQUIRE_COHERENT)
 			return DMA_MAPPING_ERROR;
 
 		phys = iommu_dma_map_swiotlb(dev, phys, size, dir, attrs);

-- 
2.34.1

