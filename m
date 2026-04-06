Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazolkn19012060.outbound.protection.outlook.com [52.103.66.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF4CD3128B6
	for <iommu@lists.linux.dev>; Mon,  6 Apr 2026 15:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.66.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775490029; cv=fail; b=Uyl+ueh7vXRJUUBQ9d6V+FYoAoAhOOiAyVWs2Xd7ibuY3kxuMrHzBEdxz2YBdlI2Xw+HaNvePBTPQVL0y4RI3EPJNLjr9OehcqBLTB5YfvoE2ivjR6rHQigRy9T9ahIhkDeg3D5rroWbg3TcpobCwkM2PDX2RjKci3oTxBa3/8k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775490029; c=relaxed/simple;
	bh=faQ7Uxm20f1xCwYvMtJNRRVgrtIcsuNULyVUunaDWKM=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=WXycbzeV74OvX+tcJp5xdDJkSodvX+ZtogOOzeIzrwlLm+7qnRHAvkcy5T5326O08DrqXnuqxo2Bv8HlHkUti3df6V65fJ+V5CaKTIaQDLZoRh72GzqyE+BwpVXjdV78JBEfQ+bzhIccRek9bf2qz9hPI/L6O8D1cVj8TctnKQs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=lkaNKtQz; arc=fail smtp.client-ip=52.103.66.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="lkaNKtQz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mIjH5Q2UP9xjZmSTZJO1YbD3KBrso2vEMbL+Ge5nsDwEgHXpwanR7SUA91aG35cfvTSwemrQrL3VU4nDsGx0tdXcMu2oSuuDKa9dipRh24Ncjq+ZDKkrmDCe4hSakdGuroCZFaO/jxQEB1HTh9kWmPHcD4iE94o7TQGaF4z0ZX8jigAYafAt1+GrwXEAoVH8sApBFPxJPvb+e0tftiGlCuW4FD0Rlsz0Dpo1J7Q/9PzkakDypdEBVzfTKMUV/LBgGHwJJWevIAABkJ/YB3mpEVtgwBvEMy7xzMmIdFhdkMlYTV4cSPI4/WAda90ueAIj2Chodm0qDoLhOkOKXFMGEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9Flnm8Xs/AotdjrfA8ISIN7JF6UfRSQQd/tw6id9ZpA=;
 b=j1Z8TPhRSKZtTbhRSKkxnTIXmJohHj4Bto1e4VgS/TaUCmA34QtlG5zBtmbXlPP7Ny00Hf2lA0wM9/5YjQuQKSuPbp9TskiE8gTebhIMJQsffJgeRiIKDOPQV6bS9CehYZlD2cFpKp1nsvIGadheZiew19+KxtI2buoNQefmL5RyTzkETVd8A+VG+JTraa3vldPgBA/m6GCR01dCqJ91W4Px+MuHfDwJUq814D+aS7GRGAmvKSm+cjN/K3QVO9M3pRYAmVgG/kWWPoHk2GFSs46PG79472HEzunjRzaJpQco9fbc4DnwBRU2OOjhsDymepjDiGAPaQUZAxQsqLv8Qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Flnm8Xs/AotdjrfA8ISIN7JF6UfRSQQd/tw6id9ZpA=;
 b=lkaNKtQz4DyKlD0kAaRLZSi3jf5+8GEzwRT35hCKSP6hO6JnPCJ4m4+4UklYpZx5Zr7juo7QxCttdgfQ3i0BRmtIBn9qchYKNM4t5+x9gHJQYoVez7BT3ahd5+9K6G9DsxjkQv2un6EXuUdtOcO9tlO0c17wyXIXLqxULgL/xlrXiIxLcTjVCy0NTyJ5b6JwlITsh570ahLSsEzQHSF1Lk74NetU2jJbAIXH6FXlotemsja/tc0kwm1kyctuQTrX/+5CGlDtHGe4WfHGwYvD0FVzEadmSBo7CZJq3+/s/y98YK6I830nfmISEVqkm3zAuKUNLXxtWMw70f2BUV0bOQ==
Received: from SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 (2603:1096:4:1b0::7) by SEZPR01MB5150.apcprd01.prod.exchangelabs.com
 (2603:1096:101:e7::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.38; Mon, 6 Apr
 2026 15:40:22 +0000
Received: from SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 ([fe80::c735:fab8:6e3d:6d1c]) by SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 ([fe80::c735:fab8:6e3d:6d1c%4]) with mapi id 15.20.9769.015; Mon, 6 Apr 2026
 15:40:22 +0000
From: Wei Wang <wei.w.wang@hotmail.com>
To: joro@8bytes.org,
	suravee.suthikulpanit@amd.com,
	will@kernel.org,
	robin.murphy@arm.com,
	thomas.lendacky@amd.com,
	vasant.hegde@amd.com,
	aik@amd.com,
	jgg@nvidia.com,
	kevin.tian@intel.com,
	xuyongwei@open-hieco.net
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	wei.w.wang@hotmail.com
Subject: [PATCH v1 0/3] iommu/amd: Fix and improve SB IOAPIC IVRS validation
Date: Mon,  6 Apr 2026 23:40:06 +0800
Message-ID:
 <SI2PR01MB4393DCD4BF7E79CB63066D16DC5DA@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
X-Mailer: git-send-email 2.51.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TYCPR01CA0059.jpnprd01.prod.outlook.com
 (2603:1096:405:2::23) To SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 (2603:1096:4:1b0::7)
X-Microsoft-Original-Message-ID:
 <20260406154009.580106-1-wei.w.wang@hotmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR01MB4393:EE_|SEZPR01MB5150:EE_
X-MS-Office365-Filtering-Correlation-Id: 54298840-a140-4cbb-09f0-08de93f2d04c
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|12121999013|8060799015|23021999003|461199028|5072599009|6090799003|15080799012|51005399006|19110799012|7042599007|37011999003|440099028|3412199025|26121999003|40105399003|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WWZMTVFDcGxDRGNFRm1RdDVoaGs1eUw5UG1zOUIvY3IvRDJ5UURZaytSNUQv?=
 =?utf-8?B?ZGpwUGJWckxHOE5IWTdwcW5oUzRYbDdIbFRSR0dmNjlWK3dPZzRCMkxGTmVX?=
 =?utf-8?B?MnJwUkFOV2tRSkxydUtvTGRvTTdiWlkwRnpLK2VUZUloWWVVU3lCc215VUpl?=
 =?utf-8?B?dUk3aWtnWEl6ZEpsKzVaalJWY1dyMXREdTRuQ09EQlkyWS9UdktEQ016SFFv?=
 =?utf-8?B?ZDBESEJHQjl1Z1VKU05pRUVJZ1o5K0ZMbUZGQ0hmdndCaGhkc053TnVVSENq?=
 =?utf-8?B?SWRMMDlza2hFVVpoeFZndndlbWltMzNTTWxtMnRVWVprTFNjRlA2aFFORFUr?=
 =?utf-8?B?WjNCbTdRS2dJbTNoYjdHT3FVOG9CdThURkcwSi9uWGhHbHZoSUFhcXJTcXg5?=
 =?utf-8?B?LzZIYnFUQ2k5M1NrUFEwVDVsMmllaUUxUzliYzhBTEU4MWFLenNnNS83NmpO?=
 =?utf-8?B?bTVFL3dRWEp0VGdBSmx6Mlc5S0hTY2tDMWprVUxCektXK2I2QjBsL2pNQ0FI?=
 =?utf-8?B?TFMvTkJJTkh2KzhONDZ0V0NELzZCUlhCKzl4TW42TDUrZ1dvZU1XQ1B4b2Rj?=
 =?utf-8?B?QUZ4ZTVHN1ZUcENYTldyNWJwZmd6NUlEK1FBMVN2dHFyK3JrT3l0aWtCYUll?=
 =?utf-8?B?WFlDYktNRWdhU1k0NzdNRG9zakNMbjI5S09WY0tuWXV5MVFGK0hFYUt3TzRG?=
 =?utf-8?B?VmIza1B4RHZVNTJ2MVQvNWs3bEU0czRBeTRPUDUxVG9jTHE3VmNnNW9ZNU12?=
 =?utf-8?B?T0RjdStVS1RlRzdkK1lBMUROMHpyWUhIVTB5RVFUNzFxZ3NYNzl4N1JmZmxr?=
 =?utf-8?B?UHVYb0lVZFZlQmw3NVU5TjZUNlNyR2o1ZytaRFZGSjF1MnljWEEyNlI1d0hU?=
 =?utf-8?B?Rm5DYURneUdUaFlzeENoMitxSFZHU1hET1BXbS9udi9scSsrdmp5QnNaMi8w?=
 =?utf-8?B?V0lhV2NETjVDQVd6eWdnQUpxd3lKdG1zNHVmQ3ArTWNkNTlEVDN4NGM2UzRU?=
 =?utf-8?B?QTVkWnpzREFQNHBGSXYwaE9Qd3dReXV2Q1ZaMHAyR1NXaURCWGRiY0IreGd4?=
 =?utf-8?B?eXduUHcrTEhXRnNTM0xtaU4xUDZkbmE5S3JCc0FoMk9hYTdjeDk4VkFpV09M?=
 =?utf-8?B?blBJR1VYY3hwV0pUWlU5VEJCVHdJRjBybjBqS1dVNnA3WXRYOGhoOWlpSEFI?=
 =?utf-8?B?SElyeGVKZ05FbFNaUEVFdXVuR3Q2aUhabGF0YUg3Q24rbVhuTGNTQis3N09x?=
 =?utf-8?B?YXRSU1lYMWc3cnM1Q0JGd3owWC9GOTR5UHZMRnZNdXRQNWJ0OE9oditRRUxP?=
 =?utf-8?B?R0puMFlsc29zZHZEWTJLMlFSbnlxSGZvQzBHZ2d2QUFUT2w2SG5hVzJvd2FE?=
 =?utf-8?B?QjluRW02cURoTlk1NWRXRlRYRzM0R1RnL09RRG50MGJUYlI5YTI3aXVnUUlt?=
 =?utf-8?B?OXV0dUlUVWpueG40N0UxQzgxUGF3L0RUVFJpT1N3PT0=?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VW1WWVRVS05Mb1VwcFZlRzR1c0tCM3Q3bWN1V0dONEJGOVlqN0VGTUNmUzdX?=
 =?utf-8?B?YXY2NnFBVDUvZy94ZS9BMERYRVFabEZiakRLMURxbnhaeEdTdFQ3Y3hiRklK?=
 =?utf-8?B?aThCTGduZGhKT0UzUCtLbFRsUm50c1I4TTlheWRVdm9CdG9GSUhQVGRzUmtW?=
 =?utf-8?B?d2pFTnllM0N5TmxTaHJlWndIenllTHZoeHpSS09Pd2M0S0pSbFlyMjB0enc2?=
 =?utf-8?B?b1R0Ti9vc01pNlNKaFB3T2J2c2xJeGJMR1BPUkQwWkNkbVVpYWRXaVJxQ0Vu?=
 =?utf-8?B?UlVoNnVrTGtoYXJNMHVSVkZoeUJ4R2o1VGwyVzBoWlA3QTRDakhPQ3hVZlFu?=
 =?utf-8?B?WjBmdU1LN3lrYlJycU1DcG96YkQwYnB5UHlJNnZHWU5HYzdnaVBpZEdkdDFq?=
 =?utf-8?B?R05oc2xzOGw0WVc5Y25EdFNoenZ3Nmlmb25XT1hWb2hhdlBqVXBIY0x6aU1k?=
 =?utf-8?B?bXFYZ3BUYmtXR1R3cEFOMExFYnFxcTlFdlp6UER3K2U3blJmU1JGeG5iZjJl?=
 =?utf-8?B?VlAwOEd6SWJUckcyNk9LY3R2dlVNdElCamw2NUtYN3dubms4UGgzYUF6UnlU?=
 =?utf-8?B?QVYwS1ljU1VXMGxGYmlZdzM0eloyVkd5ZkR3dk12WVpPekhEVm5nYUsyalpa?=
 =?utf-8?B?cmJJTjNvM1RicWFjZ0NrVHdqTXM0eVg2ZW5PaG0xUjV3d01FbmpiWmlRVjV4?=
 =?utf-8?B?Sk1uZXc3YnFRTGRBRjd3MUZub3pqY2VLSUI4SlJOV1MzcUFnek15UkpYVG1O?=
 =?utf-8?B?ZkpuWTFranFaZUNxc0h6cjVTcHFxTjVpQmhrMFFxVjZiZ2kwQkwyUkNQdG1Z?=
 =?utf-8?B?T0JCano5OW1DdCtIRWtMeXFRdHRjaW1rZDZPeUF2WmF0ck55OWVuWDgxWXlk?=
 =?utf-8?B?Y05HTFRqdG14eU1XVS9TUU41UncvcS9pYnB2N3p5SXNPaldMaUxUcUd4RjlD?=
 =?utf-8?B?dm04bWkxeEczYnRVbEJ5SVR5RExISTZpSnlCeTluWXlFSU5nMlJmL2Mreldy?=
 =?utf-8?B?ZHBIRkFOUGJOakxvQWJxVU5GalJHRDYyazM1SW9tV1BWWWo2K1A0bis1aFdM?=
 =?utf-8?B?TTB5ZkZCVVBEN3k3MTVHTmFuUFRjSzlyQzUvRHYvcGY2RDNHOTMxUXpBK0xN?=
 =?utf-8?B?eWx3eTFPTHYzL2hPOWxCejRwZmRLUUZidGVJc3E3eDJ2ekhPYWNMd3lqRnFw?=
 =?utf-8?B?UjRnMG9PeXByRm1PaGhvNFltdHd2L3JiUmR0Q2ZtaHJBWklYQ1U0OE5UMWtF?=
 =?utf-8?B?QjhPNEdUUnhFbFlpWTIrMEtUZ3JNaDNKWitaTUZhaGRaZVJabkg0KzREUzZL?=
 =?utf-8?B?L0d4MDhiYkhGN1RhMEN3aUFNS0xaV0NXNEp0bzg3YnEzaDZTUTIydkE0TUE4?=
 =?utf-8?B?OVVFaXE0TFNQaHMzYVJVQzJXTExFOEdqblpHdEdOZ1YrU0hvblRIVHh6U3hU?=
 =?utf-8?B?MTZqTzFvcENrNlZGd0FXcTcxdGZhQnNOcU94VGFhc2dKL2lmWTRwUjYrTUFk?=
 =?utf-8?B?TTZnbU1WOG5lMG1Bd2FGNVFtN3hHcGdnU0xHcjgwckRzME1jWUZXWnErclh2?=
 =?utf-8?B?K1Z5a1hud3VvMHQ1S1lxa24wWG82c1U4WE1HT0tsQjR3RHdwcnJ0TkV4TXgx?=
 =?utf-8?B?SDlNNVJyTHFmblRIS0UyWEVqZ2RIN1Bwd1RZZUtDYlQ0RnByNDRPdVlRdjVS?=
 =?utf-8?B?dGlBc3pQU2E4ZGh1Y3ZPN3BxSXRsUksvN0dXMzhwelFudGdWTGl4TGNlcFRl?=
 =?utf-8?B?Vk12VUs4UXlkbFprN0t3S2hQT1J3Q3BaYlJCV2ZRd2dRQjYzc09qVDNUZTRh?=
 =?utf-8?B?M0lKa0t0dDlJUENUbm5EWlArN01GZVBiQzMvWVdDdkZ6ZFdwdWR5M0c3M3E3?=
 =?utf-8?Q?gv96+t/XASnXR?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-3e488.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 54298840-a140-4cbb-09f0-08de93f2d04c
X-MS-Exchange-CrossTenant-AuthSource: SI2PR01MB4393.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2026 15:40:22.6570
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR01MB5150

The check_ioapic_information() function validates that the Southbridge
(SB) IOAPIC is correctly listed in the IVRS table before enabling
Interrupt Remapping (IR). If validation fails, IR is disabled to avoid
IOMMU dropping interrupts from unmapped devices.

This series fixes three independent bugs in that function:

Patch 1 fixes a logic error where successfully detecting the SB IOAPIC
resets a 'ret' flag that was previously cleared by an unmapped secondary
(i.e., non-SB) IOAPIC. This causes IR to stay enabled when it should have
been disabled, leading to localized device hangs.

Patch 2 fixes a false positive: the SB IOAPIC was identified solely by
its devid matching the hardcoded value (00:14.0). If a buggy BIOS assigns
that devid to a secondary IOAPIC in the IVRS while the real SB IOAPIC gets
a different mapping, the check passes anyway and IR is left enabled. The
system timer's interrupts then get dropped by the IOMMU, causing a silent
boot hang. The fix identifies the SB IOAPIC by its APIC ID (the IOAPIC
that owns GSI 0) before matching its devid.

Patch 3 removes the hardcoded SB IOAPIC devid entirely and replaces it
with a dynamic PCI config‑space check. The SB IOAPIC resides in the FCH
(Fusion Controller Hub / Southbridge), which typically exposes itself as
an SMBus controller function. For example:

AMD Genoa:
00:14.0 SMBus: Advanced Micro Devices, Inc. FCH SMBus Controller

Hygon Gen4:
00:0b.0 SMBus: Chengdu Haiguang IC Design Co., Ltd. FCH SMBus Controller

The PCI class code at a given BDF is a stable, specification-defined
property. Using it to identify an FCH function avoids maintaining
per-vendor/per-generation hardcoded device IDs that must be updated for
new platforms, while producing the same safe fallback (IR disabled) if
the check ever fails.

Wei Wang (3):
  iommu/amd: Prevent SB IOAPIC from overriding IVRS validation errors
  iommu/amd: Fix false positive in SB IOAPIC IVRS validation
  iommu/amd: Dynamically verify Southbridge IOAPIC via PCI config space

 drivers/iommu/amd/init.c | 51 ++++++++++++++++++++++++++++++++++------
 1 file changed, 44 insertions(+), 7 deletions(-)


base-commit: 2febe6e6ee6e34c7754eff3c4d81aa7b0dcb7979
-- 
2.51.0

