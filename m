Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazolkn19012053.outbound.protection.outlook.com [52.103.66.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D83732F759
	for <iommu@lists.linux.dev>; Mon, 19 Jan 2026 05:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.66.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768798810; cv=fail; b=qGzKvJ5H9DxDTCpfg1xjFGGaBr9fBmpSyBpEMQr3IRqbVJ75ZsspVHqxCZOSRRJQNoRYj2USGg8MaMNyChHMkszxi8dy2AEF0X2WiCl+Hja1D5wRdyNIqvZiwNNt8HeVMnwrWGNxGW1I7YKNjP8hPNUIxSp8DA61FAuHbMFivEE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768798810; c=relaxed/simple;
	bh=QXhq9jqV2Sks4rZCQxyfdMqG8KeimcFOkyzGl44wh70=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aH1OE3nUNvBRGN4XfOEe7vDnN0b/VSUPR6k7sgGFadA54fdFaWOT5CRyOWDYmwughP6+n4wBkv9ODrv49kqkofe+/5T+zEaymwLT3St1l1N6E3sEUiP+xZxLz5NokexoNs1LPzKzVRjYHIY3zKv5aNmnRKr3WhGjLwytodp6+kA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=hTgQqbGF; arc=fail smtp.client-ip=52.103.66.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="hTgQqbGF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mRwCXyOyMZQXBA1tY9TDkRQ53SsKGFzxf1xUYgAU+6o4vZ8p1oU7ZIWuiEHcnZjXH28RYXuGfVQEuh2fR0J/aUUNK28fYVyISuUuY60OquLT6Bcdm1e4K6tWgkcNOvgIS7MH5duOmDBxKWBLcFgx3tEudQpgmvZBkPhQoqDnE5HAkNBuHXLBW0WME5demq/Rs+Xsz/nSGwrIsvkEUgn97vEaBUgJRU2hT+dzVQ0FSmp2bhwaA+lo2t/bUzFKIyDM6SIm9V02SkGsdjqvxjzAI0atw84aO5YtwK1sC0X5obA1icLL/zFDRcFpGwXnzMujRjN+YuI3d5YCmuHY7jXbDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KpAdFqRYNTAfIW9mKTA7oRhI12Cr2VPJMTf4Qh/mJoM=;
 b=cMbLe/URA52r5K8JJ4NonAdAPxS4uCQG/jUchsTf62PVIILH0OpPoxuto+iok3iIArpazqHAQjT6x2yRuTyvfYFOqc6tPatORkCJwXTGsarC1BVocGhEuTdU65mxc/J8kOrmj7UwA6D1dst+aztzMRzlBowtKFxA4sHt9+2TjaazBjIwAO4y00ergy5oltragB+DK6+osV8su5SPiXvRETWwZe/X3wIlfAy63B5/LMLo7SFuVdIX2z08P+AiXGwmHSjQiPV92r6C7Lk2qR2XraHPFrfmbt62eioCI2yet1c31mVr++asl3pi1MsxP+S+UIOCAVWQxWmdmCIlGdsNrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KpAdFqRYNTAfIW9mKTA7oRhI12Cr2VPJMTf4Qh/mJoM=;
 b=hTgQqbGFHiYr+Gd8v/2NYPlyrnBtsXy4yVqtl5dmIUaPvNiGmXn28hdl29m22RAdFxRko6lAMymAJS9IqD5VG1dnJv/lL1rTlCcehinGaYxmFULhSEk5m80+1lq2nzImCHWnT34CA68+A7Qt540hg/NEuYbLyEieX8juMM8znq3kwBCsZoAnwnGckcLCFlyG3JM/Knouq19JaGveMqTvDzMOljwCHrimzVhaumQ6m/bvnVvcNBMQftdx3jAClGy8mmXRUOar3WX6KZwfkrqpoUNPaO8jjWfv4puEi1EGKMGgHpr3PheG0N5u3R3XvrKuJwzj6msrmMhu1IZzZOy/hw==
Received: from SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 (2603:1096:4:1b0::7) by TY1PPFBE0E41249.apcprd01.prod.exchangelabs.com
 (2603:1096:408::34a) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Mon, 19 Jan
 2026 04:59:56 +0000
Received: from SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 ([fe80::c735:fab8:6e3d:6d1c]) by SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 ([fe80::c735:fab8:6e3d:6d1c%4]) with mapi id 15.20.9520.010; Mon, 19 Jan 2026
 04:59:56 +0000
From: Wei Wang <wei.w.wang@hotmail.com>
To: jgg@nvidia.com,
	kevin.tian@intel.com,
	alex@shazbot.org,
	joro@8bytes.org,
	thomas.lendacky@amd.com,
	vasant.hegde@amd.com,
	suravee.suthikulpanit@amd.com,
	aik@amd.com
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	wei.w.wang@hotmail.com
Subject: [PATCH v5 1/2] iommupt: Do not set C-bit on MMIO backed PTEs
Date: Mon, 26 Jan 2026 03:19:20 +0800
Message-ID:
 <SI2PR01MB4393563CD72EE92D40EC565EDC88A@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <SI2PR01MB4393C9B731ABDA050A336166DC88A@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
References: <SI2PR01MB4393C9B731ABDA050A336166DC88A@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0043.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::12) To SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 (2603:1096:4:1b0::7)
X-Microsoft-Original-Message-ID:
 <20260125191921.831033-2-wei.w.wang@hotmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR01MB4393:EE_|TY1PPFBE0E41249:EE_
X-MS-Office365-Filtering-Correlation-Id: ee3a03d4-2c66-4384-8bb9-08de5717972d
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|15080799012|8060799015|51005399006|23021999003|19110799012|37102599003|5072599009|461199028|56899033|3412199025|440099028|40105399003|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Qla32LFfzALWwmjTXurS0Pxz065X39RnLgHTNByek9DSDJYwmleiZA+t6nNQ?=
 =?us-ascii?Q?iSBLhxi8CowNv/K+W1oIkInbVQVOX+Ug1e16G6yhTMwrbJbTLwVBtw5oUa06?=
 =?us-ascii?Q?MHApMAUpvv5xFvGc8M9uxedENdXQmqloKLf+Cjdhd/QCbuPnnGe+llJmMrVJ?=
 =?us-ascii?Q?8ZNn/IJNBeNCoaEo07IrvAcJK1RjFGy61Gvmq0UlTmRDB5d6CMnFtI2hV3DG?=
 =?us-ascii?Q?1cTcXrEc8SralRoTX5MhrgPSiP7DyJkp//bnWaVBGRSO30zJTERx8Xp1sQ4Q?=
 =?us-ascii?Q?Tvgkv1UKbdSkoZtktWWxvrqVDEPZAnb7/FD3P+M8gilCx8vij9LBAocAGRai?=
 =?us-ascii?Q?6hWJzKu6H9NRBNRC46zyV7Qhkmk9kKL4gLJtlFI7DzX4vShEWPGNR4McmZAJ?=
 =?us-ascii?Q?rakF7aqKaLJjZ44BmFLj2AVx51vC+kbIWOrTxRL2PbXyhPUglhHqjUWDVtUc?=
 =?us-ascii?Q?zdkARHEfTQwJ5SWPcXWuc9x7RQHS1w2clTyvTzvEb4ZTHpxT8Ce4cGbd/NUp?=
 =?us-ascii?Q?rxQLh72PbzeW8SX3uzUY+zAgOE+/czd1ou1DMPSEn9Ghw6Kp/ab8qPRtAOuh?=
 =?us-ascii?Q?k8/GtLbSV3sopyQI+4VuAYJT0FeBJI/W355JKiAWMdZxzzjXrQjl/D7cl4mJ?=
 =?us-ascii?Q?o1qSVxfS0o92CjwZ7KBYprWsZhwefFD+CZ4i4bJjBxtqplsVmsQ82zibw5LV?=
 =?us-ascii?Q?Dshddv8LYyzjU3p6ASj4OX4/zTMpJo7eFoL861Gokg84de049ycHSh38sRw3?=
 =?us-ascii?Q?N0qJ4k78LMLu4uFniWVF1XqtqL5zWnLFBEZ2zKEyt9nRV+0HWHoPqJjMaaIt?=
 =?us-ascii?Q?3m0TFj/W28SPviUKa3qpkW7f/er0Eac7lTGNPe7f1+zn/gj08mCzIzB7lScg?=
 =?us-ascii?Q?JDtTNRZ3z+gkSgruepyxpGDFzJVRd5TvCLZGAjXNHmoY6fFsj1K/PG5a/NQC?=
 =?us-ascii?Q?wfxBZA8qc+FOqdMC9OptW74SdoVqgxKccGfh0f/KvOWEuzSo9dZaeGEXZaTP?=
 =?us-ascii?Q?I1abzwOVyAqD1+L0WfKuzgBJ61Hdspe/I+IR7DvBY7m/eCO3DgZ0RUPnl9NO?=
 =?us-ascii?Q?3Rq7pk4VdWCV4lrUE5ICcBjmdSt9uMM3v+ELUbDNNJIC38KNwy3SYeqFi5Tx?=
 =?us-ascii?Q?se+AbKa87CDzwWzSxMMXyDXmfNpZZKXKT9BxPxA1DlM30J3x9HJCPWhQcUxC?=
 =?us-ascii?Q?IH3zGqQLwAyiVPNZsgf4YJajDnaFYcK+cmO3ccP8QCV2G/V2ndBeIRxe/E4?=
 =?us-ascii?Q?=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?eN+F/elTecKhpk0TxiU3VlFrqGglVgC23FX2dVfk9XXYrbZ4D6W32gaAmcje?=
 =?us-ascii?Q?vtmjZC0rHAQbCJ7rNSveHJFFM7JfjzsS2lL4bccqA+WQVNKXHcMpIpnA9fwY?=
 =?us-ascii?Q?iMkWoY0FECg6eGmpVU9wi1NVz1mA/RXB4QwHfO1E89va1GNq1+IvDRSQTQsU?=
 =?us-ascii?Q?PzGkJCfoMZlm+g3vQfrumCuw+n8spq53H223NKwu0RTG25/rwae6uvEyzu2T?=
 =?us-ascii?Q?1HxUZ7GoRkb+Kp7DtXRTggY7GjbCvpezHIVpisvFsCuX9hmr9QdmiAGmMR6R?=
 =?us-ascii?Q?fr340sQ3Z5sHKurbMSSvfwEHg7tmli9klkhLFYN5LJS4ZJemj6j/KD4sTKZ7?=
 =?us-ascii?Q?i+LTsMvJhCL7Ps8DshVnuH6faji1drV8MhMHu8r64MIlBcDEVG86m+fTAKpo?=
 =?us-ascii?Q?O0ExBHGhBpNOfgam23zpv8Noi7zrMv3I92WbaUYPb04otVrEA+WWTQNIThnT?=
 =?us-ascii?Q?VxA/AB5ALuZOi9IDa8HRZY6gJo5EGZ0ZLqMJX6UatuDb56xrV8XGjTtYOso+?=
 =?us-ascii?Q?JW+zPagfsBQ+fdoJmsqx/P55mmKEimrkmyQ4YhMR5rDrsIBAwI3obvbQiZyP?=
 =?us-ascii?Q?ikctn5qzLqyhdJOtXB591r40dj9jTiYEnMSUzFU2KIzJm/CI8QoWpJ0Jwh5I?=
 =?us-ascii?Q?Kem8cHLLOUSPCACgDANLXyI2RQG7zUToKK/W3ZboB1JIPVXn9h9GJ1oxGd4w?=
 =?us-ascii?Q?/dv1u6tfxCXI41oLvr7z5H90a/4k+/cCAG8xY+eJ8pVCzX+6ODo8L6HSGQr+?=
 =?us-ascii?Q?PySb+q3RDEytb3nlx6zo6r8YsKQZOtqulXS2baanQ7Tqtvo7Zw+dd41ua+aI?=
 =?us-ascii?Q?oeOtpTuvbYd/oCAUaME6GSFfYYELiGkqdO9jFX5vLJsjoeAp1JkVC1ifnbHi?=
 =?us-ascii?Q?c8/tI3H+Ph+uOAGl+S0bwwEUvfudQSuSWGA48SJ0TECW/v4NRns+e7BxmB69?=
 =?us-ascii?Q?vAspZAJn2HjSR3ZEYzRI9NGqX+tP1APPkiPW4K4vYBIlyI4YkRcaqdxXu2gX?=
 =?us-ascii?Q?rL9QepxJR9mgWNrqB7F9Mt24fXwR9e03MTE+GwQl+qyjFxYwum38uiua3184?=
 =?us-ascii?Q?fZfuJnFUEF8CYt59Cakq1v3LckBJBZu7RjESQ0dnP7mNJtqdNn9uaau75ITm?=
 =?us-ascii?Q?crFtpARF/JZu3V3vfAQtJye0sLVtJ7ccQpLKhler0XdNSHu2zoIcW2Aaz7+P?=
 =?us-ascii?Q?uiFyW9mXQt3lQT8iIepbKT/yPGVGHNbZYOD1xKJyXLO4VLd0KFMAyk6RsWeT?=
 =?us-ascii?Q?6FCHNwDV69cA79eAVNMgzyHfjszPbZUk+iqLjjKLOzxFa6X+HbyMX099PNvh?=
 =?us-ascii?Q?3R8ZFQhcCULM6IfddJLlRSkVHiN+Cezr4k5iPyWUd9TXq/iJKlMylF6PqwlZ?=
 =?us-ascii?Q?wTfjqY6C5UNXAr5a/3xICzISYPnw?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-5f51e.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: ee3a03d4-2c66-4384-8bb9-08de5717972d
X-MS-Exchange-CrossTenant-AuthSource: SI2PR01MB4393.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2026 04:59:56.8873
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PPFBE0E41249

AMD Secure Memory Encryption (SME) marks individual memory pages as
encrypted by setting the C-bit in page table entries. According to the
AMD APM,any pages corresponding to MMIO addresses must be configured
with the C-bit clear.

The current *_iommu_set_prot() implementation sets the C-bit on all PTEs
in the IOMMU page tables. This is incorrect for PTEs backed by MMIO, and
can break PCIe peer-to-peer communication when IOVA is used. Fix this by
avoiding the C-bit for MMIO-backed mappings.

For amdv2 IOMMU page tables, there is a usage scenario for GVA->GPA
mappings, and for the trusted MMIO in the TEE-IO case, the C-bit will need
to be added to GPA. However, SNP guests do not yet support vIOMMU, and the
trusted MMIO support is not ready in upstream. Adding the C-bit for trusted
MMIO can be considered once those features land.

Fixes: 879ced2bab1b ("iommupt: Add the AMD IOMMU v1 page table format")
Fixes: aef5de756ea8 ("iommupt: Add the x86 64 bit page table format")
Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Wei Wang <wei.w.wang@hotmail.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
---
 drivers/iommu/generic_pt/fmt/amdv1.h  | 3 ++-
 drivers/iommu/generic_pt/fmt/x86_64.h | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/generic_pt/fmt/amdv1.h b/drivers/iommu/generic_pt/fmt/amdv1.h
index aa8e1a8ec95f..3b2c41d9654d 100644
--- a/drivers/iommu/generic_pt/fmt/amdv1.h
+++ b/drivers/iommu/generic_pt/fmt/amdv1.h
@@ -354,7 +354,8 @@ static inline int amdv1pt_iommu_set_prot(struct pt_common *common,
 	 * Ideally we'd have an IOMMU_ENCRYPTED flag set by higher levels to
 	 * control this. For now if the tables use sme_set then so do the ptes.
 	 */
-	if (pt_feature(common, PT_FEAT_AMDV1_ENCRYPT_TABLES))
+	if (pt_feature(common, PT_FEAT_AMDV1_ENCRYPT_TABLES) &&
+	    !(iommu_prot & IOMMU_MMIO))
 		pte = __sme_set(pte);
 
 	attrs->descriptor_bits = pte;
diff --git a/drivers/iommu/generic_pt/fmt/x86_64.h b/drivers/iommu/generic_pt/fmt/x86_64.h
index 210748d9d6e8..ed9a47cbb6e0 100644
--- a/drivers/iommu/generic_pt/fmt/x86_64.h
+++ b/drivers/iommu/generic_pt/fmt/x86_64.h
@@ -227,7 +227,8 @@ static inline int x86_64_pt_iommu_set_prot(struct pt_common *common,
 	 * Ideally we'd have an IOMMU_ENCRYPTED flag set by higher levels to
 	 * control this. For now if the tables use sme_set then so do the ptes.
 	 */
-	if (pt_feature(common, PT_FEAT_X86_64_AMD_ENCRYPT_TABLES))
+	if (pt_feature(common, PT_FEAT_X86_64_AMD_ENCRYPT_TABLES) &&
+	    !(iommu_prot & IOMMU_MMIO))
 		pte = __sme_set(pte);
 
 	attrs->descriptor_bits = pte;
-- 
2.51.0

