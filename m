Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazolkn19012051.outbound.protection.outlook.com [52.103.66.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35DC4276050
	for <iommu@lists.linux.dev>; Mon,  3 Nov 2025 14:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.66.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762178466; cv=fail; b=HKdGx46yJ44AY3pW3qw3181/AWoMTNtIVjrrk1OVT8gw6ah5Q1BlbaE1ZL0GoJ+CqRBdw2RJj9tlC1x3CTfm/Hq4J4LrzupD9lGJkBaUY4DW9rMiMRvHdHkIy6ncaE1AxxiuO6R7oEv5LBWaRJyxeHiYxfNe01giTR+1lSUmX+k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762178466; c=relaxed/simple;
	bh=K87KBRKGXEc+AxvRdIY9uxkR+gsBXdTIW9GcpdJHSvc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sJ3abXvt+XcCjeNx0vBtdsbO7N5d3AEziRM8MngZMuniR/NisOfMAyDjLAcCQPxC6gbRPH2Sf2unJ/HjqiR/1mYGbiVFNWLMuTERmjVUDR/BT902N5nlSYlZs8f9swhGswDhHiexgQ4P1nlMYnUa/FyOSLgncLY9wALD2mAgdNI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=qIRRZZZB; arc=fail smtp.client-ip=52.103.66.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="qIRRZZZB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=godETnvg5RJim6KYr6GTMj9A94+Q3Ef36qx8CeK1Ks5jhHOwgpgESvrwuix+i9K8G3PBdXO2wRVc4/l66aoeKRqoWSJUb3NraqFky2TMiSfddJvyrnBMpoPP+tFlbfgL/+8dhU+wEomPjnsjOHaUk0eaJnvrXLRkulB4eu3U/kC2Z/O9CK9EffDHYHlpaYqyhSpZfc9ayjbd5pVtaPXtCDoExH2yrnKqTXRpLGKEa6OuOQseVKwIhNCdFO2hdHR5t4YHgyEOGqXzs9X+cw3RmqM0SvgFFhnruT+LKZGbqJOPJEaTlapmrZA6hj4uhMDqMeIfX9/Gqsh/Nwqx/s1FUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OKZ9bbObITZlfVD822kaN0hFqBOoeamqtzosbYE3aVY=;
 b=LtPn2cNUWWW8lDcPutEUrVG9amBNnZ2zqzMHszJWKdDPNwvmAzwsd1U7ZaSQ3zx5cqjqduFXclzC32KlNjeeXBz0cbvG+6k6ObyciXxVNFtMXTuMZtN/5i53Yq4U2suB05YFSs3+97PxnLQDHjlv99ejMAPAyCGCGeUU+TaIR7mXElrqQinu+0toQsZpZ3cLoWF2NrRUGHW4apHKMQJEWgJjpIPdr7ReoV6uVfNOJHqMjpQ9CIlEHuxxJH/KiYWicEOJy+0q03NA4tawKqHkTDChZBg/GjCj5hMMJ1XSdjAtb0YiHMQnuWa3H1yOJfyBOhi+F7Dwn6fFWIf6bUtcCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OKZ9bbObITZlfVD822kaN0hFqBOoeamqtzosbYE3aVY=;
 b=qIRRZZZBwqQ279NVy2/y1KYs7kHFgxAz+htrRar7Vf1whamgCs1erQlBjdHVz7Xg1H1DYPu6y2xeZSf655QG0LmyujqfjoDYSDKfvVJTInvuIUaG2CGY78oVc+vtC2YDhbdnX0pFIDY+PFtW/IIX/bKKt1dk6byhJThEXnPvsmr0DxPhY4d9eV1AvpndpWtbxUa5Ucm8Z04iyO3nlCCEBZ+Bl+3M86R7HpTJjHgZEuscijAShwEfQVkqFGWdLVzWsz+K+zLmm/lXmYsR8zXlLlZTSbnp7XfuPSSGxjkiqP9H7UuhxkaBJiP1zV2EZqg20NTjPtxYHXeX+gwbxRR0lQ==
Received: from SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 (2603:1096:4:1b0::7) by SEZPR01MB4597.apcprd01.prod.exchangelabs.com
 (2603:1096:101:90::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Mon, 3 Nov
 2025 14:00:57 +0000
Received: from SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 ([fe80::5e86:f04a:37e5:64f1]) by SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 ([fe80::5e86:f04a:37e5:64f1%5]) with mapi id 15.20.9275.015; Mon, 3 Nov 2025
 14:00:57 +0000
From: Wei Wang <wei.w.wang@hotmail.com>
To: alex@shazbot.org,
	jgg@nvidia.com,
	suravee.suthikulpanit@amd.com,
	thomas.lendacky@amd.com,
	joro@8bytes.org
Cc: kevin.tian@intel.com,
	wei.w.wang@hotmail.com,
	linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev
Subject: [PATCH v2 1/2] iommu/amd: Add IOMMU_PROT_IE flag for memory encryption
Date: Mon,  3 Nov 2025 22:00:33 +0800
Message-ID:
 <SI2PR01MB439351F0B7E54513710BBD3DDCC7A@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <SI2PR01MB439373CA7A023D8EC4C42040DCC7A@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
References: <SI2PR01MB439373CA7A023D8EC4C42040DCC7A@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TYCP286CA0345.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:38e::6) To SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 (2603:1096:4:1b0::7)
X-Microsoft-Original-Message-ID:
 <20251103140035.762861-2-wei.w.wang@hotmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR01MB4393:EE_|SEZPR01MB4597:EE_
X-MS-Office365-Filtering-Correlation-Id: fb850d0f-2ee8-4939-5be2-08de1ae168f4
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|23021999003|461199028|5072599009|8060799015|6090799003|15080799012|19110799012|10112599003|51005399003|40105399003|440099028|3412199025|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VGdiT2M0RTZnT0M3OWVEYk5KRlA1Q21jSklVN2QvOXIrRnkyaW14L3pCd3Zp?=
 =?utf-8?B?UjUxYUlXTVBHbm82azNyUzR0VVI5cytFQUFBaktCem5ickFHWXRWVTc2bEFE?=
 =?utf-8?B?MDQ0V3ltYi96Q1R3MWNHdEd2b1N1d3dMTklFN2IrelRwZUtrTG5BYkhrcjFV?=
 =?utf-8?B?Ryt0bTBwSEg2M2xvelo2WnhnMzVBZEs1OGJna0NIenlkRjJWZUZtamMyYUkv?=
 =?utf-8?B?aitHVXBOMGh6VU1wbE01Z3FwdXNPb0g2NjVEcWhsY3BaN2lYZS96TjRlNCtR?=
 =?utf-8?B?Mlg1K3lFTUg1UHJPdnp6eUlVaFZkMktXcGtQM1AwNVJBdW1hQTNQMGo2cTFo?=
 =?utf-8?B?ajNFVE5xdE1uK3lTWHhWYURpRDVLMS9TWFd6WEtDUVEvdmlQaloyL3dINVhY?=
 =?utf-8?B?RWhDYmpPMU4yUVNTL1NmaFBsWnNnZzhxTDdiR29SQ2tobEUzNXlMOFd1R0ZX?=
 =?utf-8?B?c2c5UUFJRElES0VVVkw5U2o0V0FFVVJrT3hqRXBJeXVGUTBaNSs0Q3VMbnF2?=
 =?utf-8?B?dGlta1dQb3V0dlBQOXNvclNudTg0VFZwNnJJU0dldFBTTkJ1a1dITEpSOXhP?=
 =?utf-8?B?M0xhUXRGcGtEdmo2NEtuVGdrb3B5NGNka04wY2JUdjZqQmMwWEtTci9yOWFw?=
 =?utf-8?B?K3pFOFJMdGp5cWFScWYvMm90ZVhKS2F6b0gzcWc3OHpSZ2Q2NENEbXpaa2cy?=
 =?utf-8?B?RVVSWjh2Ym5YVjF1YVFVamEwUGNEemcxYm5NSm5LU2Q1WFZVR09TbWNwZ0Ri?=
 =?utf-8?B?NDhpVHNnYklCTEdtdFU4N3o3anpHTnlTRU1IaCtPZzVwUUxUbkpoWitSd0Uz?=
 =?utf-8?B?dDI2WHFyWGdDQldyeXRzNVF2ZnFqL2RqSEl6RXY5UXF1b0xiNjlwZzB5NXU3?=
 =?utf-8?B?K2FYSTVUbS9wYmNOblVYT2JVRjN5RmFseENpczF6OHo0dkRIeVNQYWlzTkll?=
 =?utf-8?B?Q0RoVm1IR1hKWVFoekl4ZDE3VC9LRWlZRDVEZ2REbDNHZkUvMFV4bzVsYnhF?=
 =?utf-8?B?eGJHVTVldExLRHdPYjgwdy9ud2tEa0FTanZ5bWY0QUMwUXZSNXFPdlQ5bm9r?=
 =?utf-8?B?d2MyM2dNLzVHWjdnNSt1Q2NVelZVbGVPUUpTK0JIMWVxSzVqN0FHTFFCU0dz?=
 =?utf-8?B?RWNUOGNmMkkxRGcvci9HZFUyZWdCUWN3N2ZaSmVJOWZtWDErK281NzFldlRP?=
 =?utf-8?B?cjlFWlV6eXhoN3djSW9rRy9rc2FBcE1oRGdOMVFsN2t0bVZkQ094LzBtRE5s?=
 =?utf-8?B?YThFQ0xzcTRLRDluVFJ1QjJpdEQ5LzU5MGJlZ1dmV215eHh4bkRJMEdqOHd6?=
 =?utf-8?B?VU54Tks2b25qS2xCS3FDdEdBeWphRCtnTk5QYWJHM2kwcGs3MEthY292Q202?=
 =?utf-8?B?REZKeFJ3czMzK2ZiUThtNm8zWVdEeGJsb1hoUkZMU1pSRlM1eFBHWHE5ZWpR?=
 =?utf-8?B?cFltaWU4MkRpZWxhYWlPWDJqbldGRm1GYVk5RVpSQlBKeG5mWDNBejhxamdR?=
 =?utf-8?B?UXJtQjNWMVVMK05NQ0xPdDZSUVRGbTBIVUVZWThGaGxXTkZ4TERBZkM1cGVI?=
 =?utf-8?B?ZDM3bWpWNG5YOXU1TXFDVlhVMHZkc203QldvL1JwTE5ZeTJzSnc5L1NmY1hS?=
 =?utf-8?B?dU54ekYvcWJOODdTUmdpTC9oWm13NjVnZVdzZWZ6bWIvS29kb2E1NWg5K1JT?=
 =?utf-8?B?RXZaYWprMjUxZVkrUkw2b1paSU5aODZwUGduOVZYcGJiVmU5d3NKcm9BPT0=?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RGNzSEJEcklNSjRVcnR1dURXSE9COHllZ1VTUmhQREc0UDVpNjVQRjdFdE1l?=
 =?utf-8?B?OFdlRG9mUStsZHROVnY1NHkrSHFUVG11eFVQWXNlQzB6N2ltak5XL0RMNTFP?=
 =?utf-8?B?MzNmWkNGSEtjNFJjNncxTzVCeVZRTTNQcjBBUGJOQmhEOG9vZ0U3bjQvUi91?=
 =?utf-8?B?dy8xa1VRMm9YeDJ6K0hGOXdsTWRGMy9XY0owaVozVjJWZzRzL2tUTkxmT1hI?=
 =?utf-8?B?aE9yNFBCYUxHNHlhcE1DS1hZZ0VvOHdZVHhvZGNXem9CazBHMG5PMmlDaWlp?=
 =?utf-8?B?ZDhNR0ZZMnIvbjEvNjQ0N1JUQUJhYlc1WGVQeENxZ2FrcDI5QzRxLzJpVm9i?=
 =?utf-8?B?R1pjOVZqZ0FIeHZ3VFJXNjZVU0p0a2tscGtPbTlZeEM5dzluMTBjbkNieE9U?=
 =?utf-8?B?UnNWN2VCTjFsYjFZbFpSVVE3OElGalpUK09jNCt4UWMwcVFsOFM4bkh2aUg4?=
 =?utf-8?B?aVk1enRVWEE5OEsxamNyQXRHdUFYYW4xRk13VmJHS0JDSDlZZFhSeit3VVNq?=
 =?utf-8?B?M2RBbTExK2lRYTRnZjZCc1VURmxHZGprQlUrNUxlY29zSmZMdUliSXF4Rkc4?=
 =?utf-8?B?NjhFSFVqMnhHVU4vbUFpdnNpTWFMaTN6cWpWUFdwa3FjWWp5dXIyT3JCaWhW?=
 =?utf-8?B?NjFIK0M4UkJaT1dXRk1ROUZrT3FNRFkyM3BOTFNRR3V2Tyt3c28yWHZYY2VO?=
 =?utf-8?B?MlNZd2lGM2xiTVdQWDIzQnZiZWpjNHhCeitVYUZpUmFIZHpOZFRoMlhRWVdJ?=
 =?utf-8?B?UTc4RGxCNlFYZ3NFQ0V4bWZSMnd3Wjd0bFg3SmJld0pKOHpjc3Q1T2Z1MlFw?=
 =?utf-8?B?UDZHMDVaUXVoZkwzT2MyOFdqOCtSQk5pNDFJeEg1NzdxWUtCZ1VPY3dyZmxO?=
 =?utf-8?B?aGdxdmhOTExCSTFTT2V6Z2YzRDY1QnFrTHBmNGlUOEc4dndUaGtrWEY1Q0ZV?=
 =?utf-8?B?MjhDeEFRcmFzREc0M2RGUGxnRW5aUCtYdytwTXRZaEowcEVqb0FzdmkrbGNF?=
 =?utf-8?B?ME15bjVXUHV5TE9SdHR4aVZUL2d4WWU3UGs4QVYrMm5YT1EwUDhreUM3Nlhu?=
 =?utf-8?B?eE9ZL2o1dFRBeXhXTkk3R09hOTZZNmtacEVhcFNSaGdUN092SmxsVXRTVk5j?=
 =?utf-8?B?MUVKUVJCS1Vyb1FxSm1jb292YzYyQUsxY0xqemxpOGk5TGhKUXVFTzNlVHI5?=
 =?utf-8?B?cGZKRXlPcHhzejROSVJncGdiOGlUQnYvWUxoa1NueG5xdWdMZU9NMnhEK3Qz?=
 =?utf-8?B?UC80WHl5Qnk1VENRY3ZYaDZWeEVyYXhLOVdZR3hpdlh1bFlyU0NtNGFaWURp?=
 =?utf-8?B?dDA1UnZ3VERxRHAzY0E0MWxyYVBndE1mVkhLeFU1NG1uQmtlTEtpeFA2U2c3?=
 =?utf-8?B?SzZ3MWJ6Q05kVDYwaEN3QTNMNmpnWUpacmhzdHBBTHhIVDY2czBoUTZLajkv?=
 =?utf-8?B?cy9IdnlCazdXTlFRNkw0VUlmRVNjTkNSczFQOGptNEQ0YUxWUmR5WENHMUR4?=
 =?utf-8?B?cVg4aEgxQjc1dDU1N0FQTDZvTFJ2blBoWUUzQkVzdERhdEpIdnY2NE9hTFZ6?=
 =?utf-8?B?SzVsQUp3UDlWSWJjOFoxWmFKS1NMaXBLSlFSNTlLRmhvRnV4QTBNZ2huQ0JC?=
 =?utf-8?Q?83RStE6/wjmSd9PyyH/+XtY8SSVbdBp/k0KzBnhasp8g=3D?=
X-OriginatorOrg: sct-15-20-9052-0-msonline-outlook-827b9.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: fb850d0f-2ee8-4939-5be2-08de1ae168f4
X-MS-Exchange-CrossTenant-AuthSource: SI2PR01MB4393.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2025 14:00:56.6954
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR01MB4597

Introduce the IOMMU_PROT_IE flag to allow callers of iommu_v1_map_pages()
to explicitly request memory encryption for specific mappings.

With SME enabled, the C-bit (encryption bit) in IOMMU page table entries
is now set only when IOMMU_PROT_IE is specified. This provides
fine-grained control over which IOVAs are encrypted through the IOMMU
page tables.

Current PCIe devices and switches do not interpret the C-bit, so applying
it to MMIO mappings would break PCIe peer‑to‑peer communication. Update
the implementation to restrict C-bit usage to non‑MMIO backed IOVAs.

Fixes: 2543a786aa25 ("iommu/amd: Allow the AMD IOMMU to work with memory encryption")
Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Wei Wang <wei.w.wang@hotmail.com>
---
 drivers/iommu/amd/amd_iommu_types.h | 3 ++-
 drivers/iommu/amd/io_pgtable.c      | 7 +++++--
 drivers/iommu/amd/iommu.c           | 2 ++
 3 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index a698a2e7ce2a..5b6ce0286a16 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -442,9 +442,10 @@
 #define IOMMU_PTE_PAGE(pte) (iommu_phys_to_virt((pte) & IOMMU_PAGE_MASK))
 #define IOMMU_PTE_MODE(pte) (((pte) >> 9) & 0x07)
 
-#define IOMMU_PROT_MASK 0x03
+#define IOMMU_PROT_MASK (IOMMU_PROT_IR | IOMMU_PROT_IW | IOMMU_PROT_IE)
 #define IOMMU_PROT_IR 0x01
 #define IOMMU_PROT_IW 0x02
+#define IOMMU_PROT_IE 0x04
 
 #define IOMMU_UNITY_MAP_FLAG_EXCL_RANGE	(1 << 2)
 
diff --git a/drivers/iommu/amd/io_pgtable.c b/drivers/iommu/amd/io_pgtable.c
index 70c2f5b1631b..ae5032dd3b2f 100644
--- a/drivers/iommu/amd/io_pgtable.c
+++ b/drivers/iommu/amd/io_pgtable.c
@@ -367,11 +367,14 @@ static int iommu_v1_map_pages(struct io_pgtable_ops *ops, unsigned long iova,
 		if (!iommu_pages_list_empty(&freelist))
 			updated = true;
 
+		if (prot & IOMMU_PROT_IE)
+			paddr = __sme_set(paddr);
+
 		if (count > 1) {
-			__pte = PAGE_SIZE_PTE(__sme_set(paddr), pgsize);
+			__pte = PAGE_SIZE_PTE(paddr, pgsize);
 			__pte |= PM_LEVEL_ENC(7) | IOMMU_PTE_PR | IOMMU_PTE_FC;
 		} else
-			__pte = __sme_set(paddr) | IOMMU_PTE_PR | IOMMU_PTE_FC;
+			__pte = paddr | IOMMU_PTE_PR | IOMMU_PTE_FC;
 
 		if (prot & IOMMU_PROT_IR)
 			__pte |= IOMMU_PTE_IR;
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 2e1865daa1ce..eaf024e9dff0 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2762,6 +2762,8 @@ static int amd_iommu_map_pages(struct iommu_domain *dom, unsigned long iova,
 		prot |= IOMMU_PROT_IR;
 	if (iommu_prot & IOMMU_WRITE)
 		prot |= IOMMU_PROT_IW;
+	if (!(iommu_prot & IOMMU_MMIO))
+		prot |= IOMMU_PROT_IE;
 
 	if (ops->map_pages) {
 		ret = ops->map_pages(ops, iova, paddr, pgsize,
-- 
2.51.1

