Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012043.outbound.protection.outlook.com [52.101.66.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F2B138655B
	for <iommu@lists.linux.dev>; Wed, 16 Sep 2026 15:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789571961; cv=fail; b=ezptNmljSL+VxIfbAPetJgbgTgVGvdmu7mORaWKI0BT12mNW/M/+J3vjk2TK1KwjkOCfG4rYlBt8bF+Dy1HW23MXWf8jWPcXX06q2FeUmX21z3pZzc5zwKlGYU4fRhNfhqUpCSximG6Wx0Czr9lC7Rf3DE+3KjwYSRcev4bBygE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789571961; c=relaxed/simple;
	bh=s7ZFHVQJQFEopoNbv/QuqD0zDBc7aV3HAn46bO+2ejk=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=OVhGbZav/QgcboFvcrnz9J0ybfKLsrCVpMvtAfToxZpk4LAqEFEY9BevQ24/vHB17tqtI7ddthxz5KteoytBGhwFKjrrH5w4fO280TOlfKvA6kOrAssqP4QqKrJb8IRCHskQrsfaIB63ODfIr4uXsx/qvyBV8pwJGCcMD33xNIY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=X2FQo7o7; arc=fail smtp.client-ip=52.101.66.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="X2FQo7o7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c4od5yo1VuDpQ7DGC2umEZ/eHLYpzNWx05KjfAF6MwsFzYdgUO0WeMi+H7l/8O6ESsEVlStJCZJ/5ZnbpYHWpCntq/aDezsxxxQLHD01j+nLgaWhPdF+FfbviRlotszYy6suR73UkpRfOkLnHfhOfbFzB9q0eg7yV1FDFcGhMbuQr/gP8UCZArZZqQ+eZhEp16U2H1oMADX+t6I6kd8Gt0aBsU01AbPvZ2Egeg/AYUnxFymeW1xAY4OEwjtU4vX9vH6hlesjjCdSPmO7rUB21YkKkb+QdFbEGzdlpj3vqjwNytpdVZ+MEUzQVAXBr64+ymK7X7JppRi0VyvNHd09zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zTi5hg3fozRBcjwZg9bJ41sk/rqCbMnCWL/rRq85iAc=;
 b=Al4zOKmrTetQCw0kfXbRmprgI1t86/ByvN5Sn2KTvBi18VQSkLSGMKKCjzjiZxoXkqqMdi+tbJSYgVFmTvWpy53D89p0T2WqU2SQgY/iBwp1oncAqfMAxzDjYdCnJgELRXLGQvyrNHG25hfxi46QFHglClV7KHNP6La9ipDFaDSFT0Z9mbDJ6nDLfrtmd6nHQryHzVERt6b7/JZ31C9uAaQlkA43lFZbiZGfWXrDSWHAzsNp2cDSpVP8y3HRx7VdBKQuU/s9ViMRiJvqkthT1FXMhqYWihk66I54ekpv8uhTs/NOq5EFTq8unxM7ACg9NKC0h+lyOXGN40JPP1wpTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zTi5hg3fozRBcjwZg9bJ41sk/rqCbMnCWL/rRq85iAc=;
 b=X2FQo7o7tjerMkpQyGdmiX2hNlghhI/Fn+VYSKDv8uREw983oLexGEnvDXh/6jFmwiDRHwsRxHKZAL8SMetZTiiC6K1liJhQRGjeQ4fdpzc1SprUuC8LLsD6z9V2QtOGXkZfYYI0JnzIhhNelq/S0Z885B8LuKjpZ3lP7SG8YtttYmkWHhUBZrwE8PEcAXN9tNCuuF0XcmRuZbe4rqImT/BHNzYyV3AqKn7A2KQhf/sJWRDEU5g3S8zHq+P6WbdpYnhOiyGU5FPADmaixJXti6ZAJBWwL2ba1hTcVBYdg/wnow65OC1mRWT6A6MZ+CdCURABieFlhKMn9Ttlt2helw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by PA6PR04MB11912.eurprd04.prod.outlook.com (2603:10a6:102:51a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Wed, 16 Sep
 2026 15:19:17 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%6]) with mapi id 15.21.0428.009; Wed, 16 Sep 2026
 15:19:17 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Subject: [PATCH RFC 0/2] iommu/dma: Fix DMA_ATTR_MMIO swiotlb rejection
Date: Wed, 16 Sep 2026 23:23:32 +0800
Message-Id: <20260916-iommu-dma-fix-v1-0-a59a0c45ec5b@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHS0qmoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDS0Mz3cz83NxS3ZTcRN20zApdyzRT08Q0w6TUJBMzJaCegqJUoDDYvGi
 lIDdnpViIYHFpUlZqcgnIJKXaWgAiN9I2dgAAAA==
X-Change-ID: 20260916-iommu-dma-fix-9f55af1beb46
To: Robin Murphy <robin.murphy@arm.com>, 
 "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
 Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, 
 Marek Szyprowski <m.szyprowski@samsung.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.16-dev-7bc12
X-ClientProxiedBy: MA5P287CA0251.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1ae::12) To AM8PR04MB7874.eurprd04.prod.outlook.com
 (2603:10a6:20b:24d::9)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|PA6PR04MB11912:EE_
X-MS-Office365-Filtering-Correlation-Id: 89320468-be61-4aa9-1c5a-08df1405dfb5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|23010399003|1800799024|376014|366016|10067099003|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info:
	AJteUJVW2k+OjuiGHh9HyJ4Xjo1JYhEOGyl7VxmKcT17P4L7wmIiuMYngtMWDpVcQJUBXH46S8cufd6/ehQehcu+EThlzyapDgZpUOad1lsJsSR0EzaXb2DachSi34YM0SFSmscsqygit6ALWMdr3KAVUmXqGqmPFhQzmUXcFCLFx9F2w9cuguLQJrWqy3YTV3HBJicq6yyL7SKjPgjIn/3Tj2W+EZQqqUDh7QAryD3v5dUxH3Kz2hJr9MWCVOK4IchS+957LBQDOS22bVZyJz5Ed4oB7b+fuLOiV5aajPkuBV2KW4aHfbdw506knhsDao8fL+exEBbw65WSHkr2rRtj3RH1lHRoULOeec7m23GBYV91anat97wBKkQj4jl2JBvOj7IX+lAr56OFZQU97P+DB3wfZcu/rwe4l62h7OIQ94wAs4rCGU4lzRQrfjLqNbHNJhZOYCxnBIgJ+sVPFKaiHYWnIQj/yz/kMOXIyzxcuZiry+xxKxeXsInqsODSiW5GySaVDX54b8pVa6RraA1g6So7JG0o57BMb5FSMfMEdFhyrtdcoORYZz4Q0q9YieF8dkF91YNJH3/nPnugIgyBcjfzAyLmC0FFl3KVf8fNlUrHdGfDJtBPWNxVvzjfxvUrK629MbdmMFBqlDhWYFVO/hxbf2kK0DzE2o8qUn0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7874.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(23010399003)(1800799024)(376014)(366016)(10067099003)(11063799006)(56012099006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bVEvOFMvTm1pTzJvcnEzRWJnelllNEFaejR1eE9QeHJ2cjBXc1JrNElvZ0Fu?=
 =?utf-8?B?UkhTYndjYzBGbHo0ZFh4RUZ2MkU3cHlNK0NHcGUraWp6STRWSXplQVBVbnZz?=
 =?utf-8?B?bitKODEwVWZlSDg5SUxMYWJMQWNBTWp2aWczTSs5QlZtTXlCbGdNY3U1WnBH?=
 =?utf-8?B?bzJrNFlnZFRaRWkrWC8yZm1hVGtsZFRnamV1dGRBK1Q0Yng4M1BaY29qYTc5?=
 =?utf-8?B?SVowOUhFd2llVnJoQ29YMGxxU1RUc1lrV2dsOFVud0J2NzQ5Zjgwd2VQYlVP?=
 =?utf-8?B?bk9yajFEREZxYkx0eGViNnp2NmlwQWhKSE93SVF2QTFPRWJJTnFaaE9aSWFP?=
 =?utf-8?B?Y05va3JnSi9OTS9PUHltYWVIeFd0bXRrUWNielkza2JVRUpDMFVEck1nRU03?=
 =?utf-8?B?RjRqQkRsN0VJR2FWVzdxZlkrcDd1NEtCS2JRZ21JdlBxTzY2T01PdHZseGE4?=
 =?utf-8?B?a3AzdTYyZUxtMEo0YUVWT0MwT21xdUI1WU1LVnhwczlveW1zZUhjNjg4bUhv?=
 =?utf-8?B?YndPUmpxMjhYalN2MVhrNWdUTDZ0amhqaXdheHh1WEhQdTlzQUxIeG5FQ1Z4?=
 =?utf-8?B?WHBILytHOHI5RnFVV0NwTUxqUkZtZjZYL2ppUDJObnFLK0ppSW1FQ2ZUL2FG?=
 =?utf-8?B?dFNxRFBjS3g1UWF3cktqeVJEY0lJMkMxRDgxeS9NL1FUS3pZRkltbVBsZk5y?=
 =?utf-8?B?S01KQjV5RU00MkpJakwrK2pySnB4amU0alZ1WnFtSks1cEZxWU1uYXluTWw3?=
 =?utf-8?B?NHhVMkN6VnFDcGx1UWY2N0ZYaS9IOWkvclkyYWdzajF1K0FBNGRPTnE2amdy?=
 =?utf-8?B?LzNXeHI4U3RwZFNTMmJWWHlzSnVRV1N5M0dpRlczMjRrWGhqajFaQVpKT0tJ?=
 =?utf-8?B?dVNzUWlZZ1lTVjI3TWFSdXBSZ085QmVhL1kyeU1JdVgrVjJMb1RNNlNmSDBl?=
 =?utf-8?B?eWNnOVZvbE9nUUdkVFVLdlErNXVtUXBTLzJSdnIyZWJsbjBHOFdkb3dqSXkr?=
 =?utf-8?B?ZzN3cm02MVA4QWhpSnVUL0tlamIvTHFVK0dJRmpkWUhZRC8rZXlFS2NiaXd3?=
 =?utf-8?B?eENvSFE1aXRTeUR3a1JNMEdTV3JDNzZTaVdiZkhGQzhkZHZWUnhJZm5NcTh1?=
 =?utf-8?B?MGVSbkh0YnJyYUxQTGNyTWxYaEZTUmVRNkdybGp1ZlpyVU9pcFRtczVoK1hG?=
 =?utf-8?B?Nzd1NHBvczF4SkRyc2FJN1Q0SVFXT01SRjVMQ3ZKTnBId2oxWG5hRHhjR2kz?=
 =?utf-8?B?ak10Nk53RFcvLzdCeGxncFYzQURTK1VxT0d4RktmYUU3ZlFxNUs4VzVmcHRH?=
 =?utf-8?B?T3V4c1VnZ094WFgzTWdybHREelNIWGY5bXFMWERzRWJqeXBzRjFlNzRHQ0Jj?=
 =?utf-8?B?YlczbHlkSXV1SmM0VzlKUmhTdjJDbWdENllSZEtRZk0wQlVZQ004QlBrSXFw?=
 =?utf-8?B?K2p4VzBITTdJd0FZa0JQUkdxZ2hpd3VieXd3eG1LVHZhek1KZGFpMlg0WnFt?=
 =?utf-8?B?QnJOQ3lhdHB6azR4Tk1JWjlmL3BpeWZaa09kYWwzZTRCbGNHbUdic2dKZmlp?=
 =?utf-8?B?NHBRc3pYZmFNZGJGb0hNV1AxelBmN0VLSGFQcWdHNUlWT1FBMC9VTkxrTi90?=
 =?utf-8?B?VjNvV2E0bTVUcTFVSTZRbkFNTHBrOFl1NGxQSjVkTVF0bzlLRUdvbUlXV0c5?=
 =?utf-8?B?RWpzSTIrS3cyOUc2SFlUT2RaSnFqb1ZzSUJxVStUVlBoakVpUE91N2hGdnBO?=
 =?utf-8?B?OHd5NHd2WjlYRXNxYWliZ3BGbUN6emhpbmFMa2pHWlJwajdPc3Z4UUNQcU5W?=
 =?utf-8?B?UkxQbDB1UEJjSWxpSDdUNkR0eDNjbHluWThiWkVvdkNWNWhwYldIWCt3Z3ox?=
 =?utf-8?B?YjNaTzVDU1Z1dlcxcW1sblZ4UDhtZnRPM1RhWENZZTdIcUdzZVhPSnlQeEs1?=
 =?utf-8?B?Y2FBZ2NSVFFDMjFDN3NDRW81bSs2THkxZitjdy9oYUVhUnc2VC9xRWVXYnd4?=
 =?utf-8?B?dC9nSlpOQlNaRUtzcTMzcjR3c1YwWDZoeTBTMEdFZ3hQSTZ6YVM2NEU0aDJE?=
 =?utf-8?B?VDIwb0EzdHBWclJ5L09zR3JpRWlsK1c4YWFtcjJpVGVUV0MrVHBSTEhCNytz?=
 =?utf-8?B?cEh2emc4d3N5WHBRY0h1ck5XWGZ2Y2JDSGR1NXFVNll0M3hHaHc1OG9jRDVX?=
 =?utf-8?B?dkhKZkxsTTBldTg0UXF2azZ2NW5UZzBPZE9oZWhmcmhCRXpteFp2M2dJWkRB?=
 =?utf-8?B?ZGVYOVZoZER4WGlQM2p2MGRWUlpSU015YUtiWW9OSTY4RC9QVUQ1WE1Da0dj?=
 =?utf-8?B?VG1DTWNQbzI3Mmp1ekpndExkekkwZ0JyWkcwZ0dPUTJCZEY2Njg4a2FKdWNq?=
 =?utf-8?Q?sDq8RutRB9B4+HVtfGz7k/ex6eVFJR9HsJUpq?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89320468-be61-4aa9-1c5a-08df1405dfb5
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 15:19:17.4139
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d02kwiBLBFd1AnOSw1It3HueYUDgxFNFcvwo/+c5MSu3edlsveH8NFH+fvV+UM4I9Zuvc6DkvSec/YK4JGVjUacic2Gl0ZU73Yv1dSn4wIdHOUr3zz2kgy9YenhaxE6y
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA6PR04MB11912

Commit f9374de14c0e8 ("iommu/dma: implement DMA_ATTR_MMIO for
iommu_dma_(un)map_phys()") and commit c288d657dd515 ("iommu/dma: implement
DMA_ATTR_MMIO for dma_iova_link().") added DMA_ATTR_MMIO support to skip
swiotlb bouncing and cache flushing for MMIO resources. However, both
implementations placed the DMA_ATTR_MMIO check inside the swiotlb bounce block,
causing non-page-aligned MMIO mappings to be rejected outright instead of
skipping the bounce and proceeding to create the IOVA mapping.

This breaks dma_map_resource() for any non-page-aligned device register when
behind an IOMMU: DMA controllers that map peripheral FIFO addresses
(e.g. SPI controller TX/RX data registers) through an IOMMU for per-channel
isolation.

Both patches move the DMA_ATTR_MMIO check before the swiotlb block so MMIO,
resources skip the entire bounce path and fall through directly to the IOMMU
mapping function.

Tested on NXP i.MX95 with ARM SMMUv3 where the fsl-edma DMA controller maps
SPI peripheral FIFO registers (non-page-aligned) via dma_map_resource()
through per-channel IOMMU domains. Only the iommu_dma_map_phys() path was
exercised; the dma_iova_link() fix is by code inspection of the same pattern.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
Peng Fan (2):
      iommu/dma: skip swiotlb bounce for DMA_ATTR_MMIO in iommu_dma_map_phys
      iommu/dma: skip swiotlb bounce for DMA_ATTR_MMIO in dma_iova_link()

 drivers/iommu/dma-iommu.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)
---
base-commit: e6e35979777d646fe3c7c94dca7dd32fb25d45f4
change-id: 20260916-iommu-dma-fix-9f55af1beb46

Best regards,
--  
Peng Fan <peng.fan@nxp.com>

