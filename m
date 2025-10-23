Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazolkn19013084.outbound.protection.outlook.com [52.103.74.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D7A73148B9
	for <iommu@lists.linux.dev>; Thu, 23 Oct 2025 15:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.74.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761232571; cv=fail; b=W/anJs/UQPML8R/qCQ5FN9dXJzf8AOCLfMP4DvkUP1Uz/Upg00xAlBqnqxwc+VZcoIcJlo5SfSACiKSBs/cIqae5PhQyE6EnDw6fVrwe7j6vo97YG11iMtVlYYqzUVjEboAMMqxBmxfoTCe7Ih8loMeIunz5hERlV50vJbB9r80=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761232571; c=relaxed/simple;
	bh=R2R07wavmKKakWnWFoYwlIED9e18Ld7tgw9bL3t1iHI=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=GGKhVHqxzCFLEuo9UpcmQQMKZmtzfQSYlWz3o0yxt2v355jIkGhdTE8eyU3sw1kuRvsMIqGri+onUxRQYrgdiiLgeEhJMVU4Lfedtwfd8HNsILlrn4lhPy4A/aeKOXCAmngGjyY8uzHHjozOb1v7MNNEVet/koJnm5uLPVSzOzw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=gAzQAR1q; arc=fail smtp.client-ip=52.103.74.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="gAzQAR1q"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZL8QAPO+QipiYl7iHLp4faD44ekkubhYSOmo8OLB3mnje5RfxDX8mBtYnRkA4lYH4r6rGE6G38/G5wjjmf9ezkoLR0mUI0GJWBba5fIuvVIEtumYNDZ8ke7rrUynBbmq5RYdte0Kb7Ne1l/0M1VHW3i2ZO8nGA11z35gzGOqN0hcT/6kLLrFwUVCrzDzmPIMKHjqVCLFMRLzmNxnrAPVsP1dRbk5Stqsdmq8kG/1c6WudNAF+23HINAndDFhR+7tzxNWTegWdNpIac7MP3mseUXenV66KCwU/57zFlfguTSu7lBlmbsKHJrSLuNGNK8ppV+nMQ4bp0fusH59oNz/kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ODz2xOcRIo3gctDJP18X51SbzYUeiQL0uxdYxaLBRrM=;
 b=iRhYeqp34gHdyy2ZCL9taB9AROgqqF2WELs4zmrSMa2aInbfHHz2n46OIvyZ1OFQBk59MLus6LPo+y2ZpTGbByQYmUWDbZCwItcN20G9s74eWP6jgHn0PNHuxxNfjHFiMvCsjPLOxytjrFZFIiaE+fsHrcFSlFldZESRpGpgGoLTZ5nDpJHSfaRRfDJOoW1Tlt5ap2pWqsIF2ojvrv1NBUTAhmsAmtoKsdZLC2q/Uh6/gDiGSLjPOIbf/5rUtUbga9PbMNX8Js2ZH8aU8qjwjJ2lW1I+LXd+Y+riqy4TLM3Zs7SMSro0OWnX7CTPxMAgnnaCqJbHLCNR9UnPP67K2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ODz2xOcRIo3gctDJP18X51SbzYUeiQL0uxdYxaLBRrM=;
 b=gAzQAR1qSoEhksyGDP7Jk0yXMYqdbxuoi97XS7BCeRGZLf42x5x4zBvWRxrl+ikYlBdteon9VLHBRX3+zgA772W9Xq/I6u7HbKkPP54VYvxAvcaMFdN9TXyQ2ocWFE4uZxLIrFmbSr+k1UVTonDEyh/MDp3DjhTUAdxLIbExrOfousVnAYwZaG5jpeBFtGiU5yDi1bQjZ572hkDMbSv0GGXa/8uAeABXGGCSC1p6MKGU5iiujkmknQFyQHq+shN2xWaGOZATodPMIHe5yqCNL6DX0yInCnAb2HmJQ7KOoqNARZM8cYbnr0SBC3SK02/1DVLav9Z81ELkwzG8gRwDMQ==
Received: from SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 (2603:1096:4:1b0::7) by TYZPR01MB4212.apcprd01.prod.exchangelabs.com
 (2603:1096:400:1c3::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Thu, 23 Oct
 2025 15:16:05 +0000
Received: from SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 ([fe80::5e86:f04a:37e5:64f1]) by SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 ([fe80::5e86:f04a:37e5:64f1%5]) with mapi id 15.20.9253.011; Thu, 23 Oct 2025
 15:16:05 +0000
From: Wei Wang <wei.w.wang@hotmail.com>
To: suravee.suthikulpanit@amd.com,
	thomas.lendacky@amd.com,
	jroedel@suse.de
Cc: kevin.tian@intel.com,
	jgg@nvidia.com,
	linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev,
	Wei Wang <wei.w.wang@hotmail.com>
Subject: [PATCH v1] iommu/amd: Set C-bit only for RAM-backed PTEs in IOMMU page tables
Date: Thu, 23 Oct 2025 23:15:43 +0800
Message-ID:
 <SI2PR01MB439358422CCAABADBEB21D7CDCF0A@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
X-Mailer: git-send-email 2.51.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P286CA0079.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:36d::8) To SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 (2603:1096:4:1b0::7)
X-Microsoft-Original-Message-ID:
 <20251023151543.362291-1-wei.w.wang@hotmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR01MB4393:EE_|TYZPR01MB4212:EE_
X-MS-Office365-Filtering-Correlation-Id: 72c5c726-a2e9-4e31-1e57-08de12471579
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|19110799012|41001999006|15080799012|23021999003|461199028|9112599006|8060799015|5062599005|5072599009|40105399003|53005399003|3412199025|440099028|3420499032|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dv0NjBQfgYnn7gRK0mJmQxEmqymYb3vbW8sbXHnwzbndAakWmrLbBWMD0xEt?=
 =?us-ascii?Q?eOMUN4s+Ct4io4TbmQs594MKVsTzaXGN/rdKq55dhCoetjaz6TtPob33N3Rh?=
 =?us-ascii?Q?mK9D+jJZWy17wpDyZ2z+zfcf53Z2MJrXSvrZFuwV7uvnZkKuLjkOUWAa5M1H?=
 =?us-ascii?Q?pMQ1TRb3DHM3fuEGvFWlxbMwEzjftmuvBuh9X/U4arsyFq43MWDmUoe0VlvX?=
 =?us-ascii?Q?WsbKKpUvfsrcSmb0CHPlFVIjV+imZYLe4Ro/3DU/TH1aGxe8qhu3XPDwvpQC?=
 =?us-ascii?Q?8xd29/4PuCWkKra0pooUUtS7jk9GtycB8bq0fz3A8zancDK5o5N6ykpAPI18?=
 =?us-ascii?Q?7n/dnrezLDIUX77H6MWUgu/cAHsGpZyalY77vwE/3k19By2lG/G8Pw5ydVaN?=
 =?us-ascii?Q?oChk8yWFVQuaAVOUuZoTNY9RlmIV6Gi8pPt/S3uyuD7zd57HXn+4QUIXyck1?=
 =?us-ascii?Q?k+XLg7HOP7yHgA66c3OqkbwdXS40itQ23QyWL7KK6cw37DOc/QjXy4hq8FHg?=
 =?us-ascii?Q?PoSI651ciM7ejiA4JDxyYQ8vbOviNxwaTU41BpeRTHuAZQqVcD1nM4Bx6szk?=
 =?us-ascii?Q?pOcme8J8cMPbgZIy69E7daZbiYcONBjEGaP+IE9Hf0FFk9qM0igkQw9y9g62?=
 =?us-ascii?Q?EmA3dguRY8MEM015JFQOdBvwTmAVltfbUDJhPwAswhUB+hRXSSo5xmCUwPTT?=
 =?us-ascii?Q?MQfzIlvSB+ptjbCMZ8SgFIZn1eucymm2C7xqks8jXG14OHLDKjDHpnVveS50?=
 =?us-ascii?Q?oGxvwRpqF6I/TNJUGyMwtfZ3ENq5h7fTdba0wLyDQOITPP0Xzw5m3IjPAlGJ?=
 =?us-ascii?Q?OX7y/1N/HE8PpPK0ViG/s4GR4SlgQIs1JEWFO5/yvTwmXcqvF1XI3/dkhDLA?=
 =?us-ascii?Q?JN/t631tIzeQxK/QVO4nhMpyW7vJAWSXs49QrKP0DcFErZmZCd7jJf6wGjQM?=
 =?us-ascii?Q?t4e2ojcj9OWx8cOLVpZxY9xFARsyHnMQMApaSgeQgLrynzjte0WPAC7qOwvV?=
 =?us-ascii?Q?ktFIy7b8ilkmCYnWKg4mfaQzTdKlNcZUyfVYfHsmVK7JfNH2qkX6l/i2sIRm?=
 =?us-ascii?Q?Tcwxz8Q/k/ZAZTuKKOllpp1WS+8+2xsk2yRScCdu0lE5PLf5+jSAWe+UT6+j?=
 =?us-ascii?Q?Vc3jIUGea4b33zYcesbzaLFvHeCw0yeLxgAH0QFSZvmByjXA0QI5cs0NJHdm?=
 =?us-ascii?Q?9XBD5ZPF6SRZBiCF4R3AUu9kXQFFAXVWU5E7L5grPE4c3Yrbx0/ubKNVBfl/?=
 =?us-ascii?Q?6qcwM6daXJdXFltkBArzIv9vbzB/AXxmvRViu5wMv+TBu16WS/7iPX6gO+Y/?=
 =?us-ascii?Q?1gE=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Xso4dHkTpgtVDUhp/q/MxjXP0JkYwIkhEYAO9qPUC+7QiK7q3whUQsQVKBrw?=
 =?us-ascii?Q?SFfCcyJKAr7qmUSNeQCrkaga/QjEAdX9Lm2rZc/RP/BRs4bAMQr3DIx3tEX4?=
 =?us-ascii?Q?bUML8l+SlPrzmDhpXPR0uOMVjNfko7q4qxYfNt01S53u2bLIRxshfomEpMAA?=
 =?us-ascii?Q?aVkVQA6thkpUSjG9P9ZZpUfLALTCHCtCEKz9xVT/E//H3Qxs5AFer/D9PWJ9?=
 =?us-ascii?Q?KHxouNyncxd1IUdAS67ksoBoSkVSilh4rUjyP7IyWmtcXUeAPFZuEdK4BLBi?=
 =?us-ascii?Q?9f3vzsKOjDC8NHGWlJxl0zXNXv3z3XqJTze1eHedKPNqn/axRB5xBcbAvxae?=
 =?us-ascii?Q?zIXXY0j2d1fnf3JaZLsE46cmEHu+GLtcP76aM49MXiPiLOqwvRjTiYE9srWX?=
 =?us-ascii?Q?/4kQSN4bEi358KafT2lxFN921pbvM3lsSAe2L0H6xY2Ss1vkswkL2MbpepJi?=
 =?us-ascii?Q?A979/qSIVubAPtuhlgfo1hIHGyLIV+F2Z0bQ3YqENuhLiLIQZ578OJpsYrvK?=
 =?us-ascii?Q?8yKLbxGyBP8R8OIlxrOnsDRk8Juw8QgOLceRKoX1fPy9niX51RuWMm4TbUdY?=
 =?us-ascii?Q?TpV6fCLEtnO4W4d5zE4xCh14NMM6wBOFhwAMbK/qA5kYPD10W6LMLakQ400u?=
 =?us-ascii?Q?J31moGIyxp3MRvcK0oMbCF4zlkmsISXKN3SAcygRHgA8fSFU4hXZDUvuCt1+?=
 =?us-ascii?Q?jsxgCNu0wjyl/aOpKDXc/e9X5Oxv5giR+v4W7pQjoSC6mFi/1bxauZoWNirC?=
 =?us-ascii?Q?H3dQYl2ba2XkfOl2wQTSyUvzLSwB7A008EQFk44BIV9/se6rKA4ZYWGlRCj/?=
 =?us-ascii?Q?u1uV5bokS00/uCzwgvdRBmOMufZPKnr/7Yh7jFyGhKPPF/ZKiV1XDg9hFpzr?=
 =?us-ascii?Q?C/egye2DdptxYWRmL5p6z2CiK0BzCNX27bRfyPDer3pblcBbEs3jc1xbbMYW?=
 =?us-ascii?Q?vx9OW/wRH4a/tnrSE32n+lGaS2jF7XHMbYbJxz/9B6lsniCnZnZ+YMX+k436?=
 =?us-ascii?Q?HtQXHnq9xJ7s9DdOLRVeCuPngMf2mBqijGhFgxYWs/eAh6ARcAsM+GBM49BW?=
 =?us-ascii?Q?txx+xz+gDe7ZGlUWgADjrm0wOboD7XQ9/sodQ5eb6UWXzJcYi1ssrftpUx9D?=
 =?us-ascii?Q?X9OaUVyvYgVYKSkX/3xR8jd10qH5xAW+M1T3ow07fM/t4eVvVrA/KDDne3zX?=
 =?us-ascii?Q?IUHvYkGibvALiaMGdY9biilcr9ho6hLUAfqScFQ6htYdX+v1hi/uAMlugtw?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-9052-0-msonline-outlook-827b9.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 72c5c726-a2e9-4e31-1e57-08de12471579
X-MS-Exchange-CrossTenant-AuthSource: SI2PR01MB4393.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2025 15:16:05.0907
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR01MB4212

When SME is enabled, iommu_v1_map_pages() currently sets the C-bit for
all physical addresses. This is correct for RAM, since the C-bit is
required by SME to indicate encrypted memory and ensure proper
encryption/decryption.

However, applying the C-bit to MMIO addresses is incorrect. Devices and
PCIe switches do not interpret the C-bit currently, and doing so can break
PCIe peer-to-peer communication. To avoid this, only set the C-bit when
the physical address is backed by RAM, and leave MMIO mappings unchanged.

Fixes: 2543a786aa25 ("iommu/amd: Allow the AMD IOMMU to work with memory encryption")
Signed-off-by: Wei Wang <wei.w.wang@hotmail.com>
---
 drivers/iommu/amd/io_pgtable.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/amd/io_pgtable.c b/drivers/iommu/amd/io_pgtable.c
index 70c2f5b1631b..6f395940d0a4 100644
--- a/drivers/iommu/amd/io_pgtable.c
+++ b/drivers/iommu/amd/io_pgtable.c
@@ -353,6 +353,9 @@ static int iommu_v1_map_pages(struct io_pgtable_ops *ops, unsigned long iova,
 	if (!(prot & IOMMU_PROT_MASK))
 		goto out;
 
+	if (sme_me_mask && page_is_ram(PHYS_PFN(paddr)))
+		paddr = __sme_set(paddr);
+
 	while (pgcount > 0) {
 		count = PAGE_SIZE_PTE_COUNT(pgsize);
 		pte   = alloc_pte(pgtable, iova, pgsize, NULL, gfp, &updated);
@@ -368,10 +371,10 @@ static int iommu_v1_map_pages(struct io_pgtable_ops *ops, unsigned long iova,
 			updated = true;
 
 		if (count > 1) {
-			__pte = PAGE_SIZE_PTE(__sme_set(paddr), pgsize);
+			__pte = PAGE_SIZE_PTE(paddr, pgsize);
 			__pte |= PM_LEVEL_ENC(7) | IOMMU_PTE_PR | IOMMU_PTE_FC;
 		} else
-			__pte = __sme_set(paddr) | IOMMU_PTE_PR | IOMMU_PTE_FC;
+			__pte = paddr | IOMMU_PTE_PR | IOMMU_PTE_FC;
 
 		if (prot & IOMMU_PROT_IR)
 			__pte |= IOMMU_PTE_IR;
-- 
2.43.0

