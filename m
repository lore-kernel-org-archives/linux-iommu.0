Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010032.outbound.protection.outlook.com [52.101.85.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F3CE3D1CC3
	for <iommu@lists.linux.dev>; Tue, 15 Sep 2026 02:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789438569; cv=fail; b=G6d8DGvcBVMVzOcSbVG2ubsvqGpBS3S3i4Dn/SdySWd7oRlryCATuTFXxj130xBcBhyMzd8vKS0pWVVTXKvB0z57P9G4nxI7yL0+ZWILbB1SpmFIZnKC7yrjncSuIDspiaq5HTVyJ+pCOijbFC9x6LqhDluNwojvh94MdE3i2NI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789438569; c=relaxed/simple;
	bh=u/OIXeJePkjJZh6MoW8AN+M1Pnbv7JtrXs+vyRfoTjk=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=froQsWF1mGBnKuHca2HGu2oJwYX4QbNJVyIvud09Y2t2o2IvvbcuS6Uq8M2i1r1ALWRPwDMSTjCAGt8gH4kuO0RIWLaDJNDlf3rNDMo2IcT0mCyKyFQcgSqmE+G/f1jAtQaWaliIGHt8CrutRYH1NaEuRS/zA3VdVIkxFlGJOpc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ljemWsb8; arc=fail smtp.client-ip=52.101.85.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ljemWsb8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v+oINNjNcgi5KXtMO5gjEw8a+XYXE8FHLisMTWVfxgOxK7LSmvF1tylitZz6auqfJWO8rEJVbQWIWXbc56vLGFkyV9VGDyD8coGNLoGcEe2y8RMpPOcqKHZppgBHIp2uKFW31YgKfAzxkHMZuJbzS33EXO4Zk0UBd9o6XgU9izmoomw/W2n18QP/nLJHqZZ/pwOxEwYvfI5Y5tbGU7WGsn6PrJCkXIVmLFG/S3SCHXaCKFsn7hK/h/pzawy4pP8iCps7BBJU95EH7djwe3KnrTjKqVubnEgd6RNsAkvr5Ke+qhW54q3cT9rxHD46BTo+SfqdZm0dLu0+IGDb+4eCTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VsCnSTgjxN5wvf31VElvHzai+9o6Au4DtHZ52SUUH80=;
 b=EjhqOStWvpUHnvzn+K6x/7ncZvz7TeokVzCttdM9bmDZoq9MdGTu55qPdzbzmUZX8ujbrSAanuv2ZRz4C00qoc7SUtEkzoVUZj9WfiuBtG1B4ECf6B49aZWvULm62S61aOvP3wbQ7JN7clvum++VPF+EdBxQc7QMn84SYlgZ5+yP8fOgv4qqTu6AIRm11aYhasrEt4YA1Wc2N0KDDgZYFlT6i5kZ5X4F7V2TXv5BQUxmdmHaFJ/1zjAVXDo5Dqqj/qlceIbiKM4Lfn8ZkJlcQ49V5v00KhZ1v5OHh3muOJKOQXr9oI66axFmPjaXbmXX7PHcsxLtJVJT5S1MOH2kVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VsCnSTgjxN5wvf31VElvHzai+9o6Au4DtHZ52SUUH80=;
 b=ljemWsb8gZQGxRa0qfEAjd64nWl+753gjgDvhMql3TNZSMJkbqI4kTgTtsviSTOpe+csh5hRtW6v50rCOA64pHFqsH/pp3o1XXXNuT2GCH+78dN+4CPYRwuyYo9LrUD/06nVAz988PqcnwWhJ/EvpBlyhSjw9Y/v1/6ojdtSiNgUWxHfkQ8gMa/xjBNzu38VdvOqdnivhTgApbsv02KNLI8uPi/NOzfScSzMTbd042BVld4Np7FNQ7NNJpZCq+NUp7ro6xfIksyT7pmj1Q/iILRo7QFV+kSdDOleytGmtxZi9EOm4NdEki7P2sqEahiymFlVoZAb63P/R0Zk3z8zHg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20)
 by SJ5PPF0C60B25BF.namprd12.prod.outlook.com (2603:10b6:a0f:fc02::98a) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Tue, 15 Sep
 2026 02:15:58 +0000
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017]) by SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017%5]) with mapi id 15.21.0406.007; Tue, 15 Sep 2026
 02:15:57 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
Date: Tue, 15 Sep 2026 11:15:00 +0900
Subject: [PATCH 05/11] ARM: dma-mapping: Bypass the legacy path for
 core-owned DMA API domains
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260915-b4-arm32-iommu-dma-cookie-v1-5-ba4f9d33a2b8@nvidia.com>
References: <20260915-b4-arm32-iommu-dma-cookie-v1-0-ba4f9d33a2b8@nvidia.com>
In-Reply-To: <20260915-b4-arm32-iommu-dma-cookie-v1-0-ba4f9d33a2b8@nvidia.com>
To: Robin Murphy <robin.murphy@arm.com>, 
 Marek Szyprowski <m.szyprowski@samsung.com>, 
 "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
 Russell King <linux@armlinux.org.uk>, Heiko Stuebner <heiko@sntech.de>, 
 Thierry Reding <thierry.reding@kernel.org>, 
 Mikko Perttunen <mperttunen@nvidia.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Jonathan Hunter <jonathanh@nvidia.com>, 
 Krishna Reddy <vdumpa@nvidia.com>, Krzysztof Kozlowski <krzk@kernel.org>, 
 Jason Gunthorpe <jgg@ziepe.ca>
Cc: Peter Griffin <peter.griffin@linaro.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, Chen-Yu Tsai <wens@kernel.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, Yong Wu <yong.wu@mediatek.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Rob Clark <robin.clark@oss.qualcomm.com>, 
 Geert Uytterhoeven <geert+renesas@glider.be>, iommu@lists.linux.dev, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org
X-Mailer: b4 0.16-dev
X-ClientProxiedBy: PUVP216CA0016.KORP216.PROD.OUTLOOK.COM
 (2603:1096:301:16e::19) To SJ2PR12MB9161.namprd12.prod.outlook.com
 (2603:10b6:a03:566::20)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB9161:EE_|SJ5PPF0C60B25BF:EE_
X-MS-Office365-Filtering-Correlation-Id: 342b52dd-306b-4148-d657-08df12cf4789
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|366016|1800799024|23010399003|7416014|376014|10067099003|22082099003|18002099003|56012099006|11063799006|921020;
X-Microsoft-Antispam-Message-Info:
	2wPdnabjFqDcyaLcZGiM+75rzyLV4kH7LuVuxW6QHcuhEoUAB0M1+Xb0OlBRhBhqVhBkmzX6Dzu7J8l1NCmd6v53CV99VnkpTkrh21BrRrrMHeb31zvBH8+tvKd3py5A7v7FBh+nQJ0RURBjoc/+Ds1N8XzddvDtEz17m6n3269Y9mrwsIAhCQ6VbJ4Vo16/4GqE0KnrGOXuEdb7TkDnI9yOd82TDsl95STuiWOpBb61F5J39c0q5JgRgiIi87a7MHw4rgp2ZTDbAnVAHsZNasoowVG7WxS840R4dwBeB23xhEixAHLki6QCap+cvaItNdQgvaKBh7kzD4hcHOsD9NuscZuBIVZErmPLHzjxRyn1FvHngBguUJ0PUVz/g0ofB6heRHZZ16EWbXtHZrPIe3Vfu7v6nleOzT5LSiQUi1tTkJTXitD6MBUiCxWcnWelB/7Dpz0CJHfyAtAFtgplYrufXlAY9k9V5B/MsYgf0k6mXjGHUcvBgh5aQTRJaeAnYuREWATAVyyaBiKffWLfNLiYtCIPT1ulJmLG+r1ZrVpH0SvsYM1PuKSMqg7nBMneWM8Jre09s6WfjqUNu3pstfJyYZXwJNnLe3wPxw9lbK1F/pCPm/1ICF2oOfAYKs54wac0tNMLyqehNWSojl6rh/qzEQ3FrTg/gtNcCPfdWfBE2yCKV8agkIiVdgQsaACH7WnFztXbJVMyhQM5l0CaIA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB9161.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(1800799024)(23010399003)(7416014)(376014)(10067099003)(22082099003)(18002099003)(56012099006)(11063799006)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Wjg1TldQQUZuSDFtV0FFaEIvdGNsZk5LaHV3bmhva1lTKzdjeWxwako5ZWFY?=
 =?utf-8?B?SStmTG5reEVqdDRQOXdVejJoZ0tUeTBhNUNCdHBEVytISkRVMWViN0F1RDhT?=
 =?utf-8?B?b3c1KzF6bXk4K242N3hjWUV6OC9HdzNCOTdwUEwxdUhqY09RRHRlaHZrbE5D?=
 =?utf-8?B?K2lVZDcvVmJnWXU3eSt0MEdHUE55eFlOTWdmdDJHZnUzZ3ZkdE1LL2lmcTVq?=
 =?utf-8?B?ZXlIZzhDNFdneG1oc3ZzYXRnUisvMnYyOTZ0YmlBNzc3b2VteXVOanNHZkhZ?=
 =?utf-8?B?bC83djhhZ3o1YURlV0dCbHp0bTkwYzlNc3REVVM5UnRYaWdjZENPcm1mTjY2?=
 =?utf-8?B?bXBJYlIyMDFJNkkwdUdTM1ZqRDk3RjQ2VzRXa1pIb0hTaUl0d3ViSkp5c1VS?=
 =?utf-8?B?YU5CaWdtUXpvMUtLOVc0TmVuZzNUdmtqZ2hsWEdOTUlRZVdMQkZvMk4rVlpr?=
 =?utf-8?B?VkhWRGRHMGd2N1JPc3M1ZE8ydWRIOU9ERmxocU9HY2FwbzFzQTM0dGRYQlhR?=
 =?utf-8?B?N2dSQUUvTVNIZHhNakVPN0pKSnMrNTcwSWUzZWZjdmE1UUdHSkF6S1FQRmI5?=
 =?utf-8?B?ekt0QWFyRS9vU2VwZGl4Y000OFVLMHlzeVlTaXJ1MUhsbi9YOTNHME9vUFpZ?=
 =?utf-8?B?Si9WcGxwdWswbVZYeHZpa21tZGt3RWJ0Z2p2eVpacGg5OVlTU3hmS3F5MHps?=
 =?utf-8?B?SEtUNTYyRjFxZ1Bua0MrNS9KQTBDalRwUUVDMG5pblh3cFJvMWJzdW5uRXJy?=
 =?utf-8?B?bkxhbHhVNHlCcWwwb2VxTG04QlJ3aGJOcG94N2lja3QrakVPNWNkTG4zUCtB?=
 =?utf-8?B?ZEdlMUFrRkEzaGdlVEQ3SlNvMHdoM25BRFRkWlNsMWJDaU5aVHRpRTBLazhz?=
 =?utf-8?B?ajNvZWN4bFNoQjc4S0tLck5KV21Lbm1CKzJBK2duRGdRTGxqU2VkazBpbU9V?=
 =?utf-8?B?WjJEbWZ1SWxBdE1MVGowUWJwYW1aUXpEem9iRkNjZWF4SEtCUFpGWnloTVly?=
 =?utf-8?B?SUtWMTllNHBESVk3STJIWEhWUEJLUVpucVR2a0hqWW1WV2dSTFFkVDJ1cHFw?=
 =?utf-8?B?eVdjSUlSY0pwcHFhUVNFOXRUY2hrSVg0KzJ6UU9sUXJ0MlhzVmZ5Y21yRVZR?=
 =?utf-8?B?TnhvSGhqclZwYy9YUW15cHZnNnM0U1JMaVNZVnFjb2tVSGhpVEhDeTVuWDUr?=
 =?utf-8?B?YzB2aVBQaUVjcmpla0FYVmNzTERiMWtMWEoyYzB4TWREc1dBajBMR0FpS3JP?=
 =?utf-8?B?YXFEd3JZMWtCZC9HVm54UVdqTGNpUE9Fb2YxUS95VkhiTTluSnFJZWEwSGt6?=
 =?utf-8?B?bkVLeXVBYVZFUGpSZkc4dm9PZUU4dU8waXU3TDNqSEtlRmxicW1yQkcybmhT?=
 =?utf-8?B?YitEYmI4RWV1UzhMUFR5amk4a0tLMnlsaVpFQ3JmTmxDT0JURnE5a3VpWjM3?=
 =?utf-8?B?cG1Oc29lQXQ5Tjk2cjV2YUUzYzAzdTJVMFlTN0pkSlczVHZOVy9PZHdYZ0VW?=
 =?utf-8?B?RGtDNHJ3Z2E0dkt4QXhHbHRYSEV1MkVrVnpnWmsySGVoMFoxbWl0YjdtS3VC?=
 =?utf-8?B?S1hvNEJvbWVMTzlHTldsazZsR2ZYZ0RETXNQRW9WNE9wMU00elU3SFNMWno5?=
 =?utf-8?B?TUxyS1d4YXRBc0w2Q0xIRlhmNFMrSWR5dDdwQUlJWXc4Ny9yTlB6NTJxMDVr?=
 =?utf-8?B?UCtzTG1PbE14SHNvMS9EeHhaL1Z0ejRSc1pHZnNQRmVnd0d3VCthNWN3R2xq?=
 =?utf-8?B?UWswQzJyd3pKb2R3NEZtaWRqTTlSakhkOGZhbE1MYmE1bkdEcGNWYjNXZi93?=
 =?utf-8?B?NVFiTW5QcUpBT2dBR0prb2p5QnJ2Q3VReFIxTm9tQVlLL1V5VWFEcERkN3Z1?=
 =?utf-8?B?clFzQU45cmlWakx0K0FEaHNTYTQxQ3lENWJ5Q3lMNXRkWmVMOEJNMjRWS0h5?=
 =?utf-8?B?K2xiN0ZkbFFmMW5WU1dZdVNhTjI4ZllqbkVBd3duTWtBMFFDY2hkZzRQMkZK?=
 =?utf-8?B?NW1jZStueGJWR3QzQ1VvcFhWYktYb2JqMDZkZmVmTWFMM0thYS85anJSUHYx?=
 =?utf-8?B?dFN4d3FJeFdaWlVHNEF1Q3F6VU8xSkVQS0FHWDJOalRqOU81Zy9lMC83N2Zp?=
 =?utf-8?B?UXBQV1JVUmtZSHlwUTlNenJtWDJWemRPQ0Q3dGZCaVoyeVNicjVUMFgvS2Vi?=
 =?utf-8?B?cTFuZjYzNlNSdG1HRjVIQnliRGwxSm1nVFFRL2h6d2RWQVVzQWNOSzBXSVZI?=
 =?utf-8?B?NTZUNzBpeEdBdUFmZzhaa3NKYWMwQktSSzdiZUd0Qjk4YTVGS3N4YUVrZFE2?=
 =?utf-8?B?SzluWHhIOUdFY2lJWTBVblJySWtET3pZb2RzK1gxako0U2tLWmtZL3hhSGJY?=
 =?utf-8?Q?68nfjcbH0f+G2ORtWNJnc0gLiUdp/3rh2ZVxV28YTD40h?=
X-MS-Exchange-AntiSpam-MessageData-1: c5Mkj6hXTl5SUA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 342b52dd-306b-4148-d657-08df12cf4789
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9161.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 02:15:57.8813
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8dvERREtcJfPoV3c1Cz9p7le4KIfANOd85Iv/P05PwiFt5J7cyR6zLwzIIb3N/gPgOnJ1Yyc1zZmTnMAyC4ZiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF0C60B25BF

ARM's arch_setup_dma_ops / arm_setup_iommu_dma_ops creates a custom
IOMMU domain for DMA API usage, and continues to do so when the IOMMU
driver doesn't explicitly request a DMA default domain type.

When, however, that DMA default domain is requested and the core owns
the domain, we need to skip our own domain management. Add checks to
arm_setup/teardown_iommu_dma_ops for these cases.

Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
---
 arch/arm/mm/dma-mapping.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index e0d58778c5f5..91f12fb91509 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -1761,9 +1761,18 @@ EXPORT_SYMBOL_GPL(arm_iommu_detach_device);
 
 static void arm_setup_iommu_dma_ops(struct device *dev)
 {
-	struct dma_iommu_mapping *mapping;
+	struct dma_iommu_mapping *mapping = to_dma_iommu_mapping(dev);
 	u64 dma_base = 0, size = 1ULL << 32;
 
+	/*
+	 * An existing cookie means the core owns the domain. Only set the
+	 * per-binding DMA ops.
+	 */
+	if (mapping) {
+		set_dma_ops(dev, &iommu_ops);
+		return;
+	}
+
 	if (dev->dma_range_map) {
 		dma_base = dma_range_map_min(dev->dma_range_map);
 		size = dma_range_map_max(dev->dma_range_map) - dma_base;
@@ -1792,6 +1801,9 @@ static void arm_teardown_iommu_dma_ops(struct device *dev)
 	if (!mapping)
 		return;
 
+	if (!mapping->owns_domain)
+		return;
+
 	arm_iommu_detach_device(dev);
 	arm_iommu_release_mapping(mapping);
 }

-- 
2.55.0

