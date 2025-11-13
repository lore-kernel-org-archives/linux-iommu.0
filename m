Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazolkn19013086.outbound.protection.outlook.com [52.103.43.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81AEE2FC00D
	for <iommu@lists.linux.dev>; Thu, 13 Nov 2025 15:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.43.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763049277; cv=fail; b=F0XucjGgOyAwWD5Z3D+Y20PGrvetnTtTJr9uQS56pbPpYHCjqNDTDtuEidfxrTw88/KsTLZy3G7wa6FA5fIC9HDZGFBdCX/feRAaTHF0ZuHnKemw0g+vd8wB9Lg3uIjE6RSkBz1vml4QxzhLvmFhoFazv0PQTYygMSYausL44KU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763049277; c=relaxed/simple;
	bh=XtlMF/22Y4JY6fSNxYx+dLlxvXvty5F+0k9n50wkfnw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Mpo9r9OaMZ+Cc87O3d0N+Wvp6ghEkZJpg5niqKUN0g/sQvayOwHCRf92YD6WpN+QPStKs0EI0WnWkvOmPD3/3rCVNsxCIWYQxRx9hLDMwl5TpPYQL5bWKVGQeG5fYeRyEfTtmjQDNAmFvhXW/4DsVEiR6TOVFyz4DsvfypGik24=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=mud0u9Vz; arc=fail smtp.client-ip=52.103.43.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="mud0u9Vz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UsADzWfmL7hn5vYzUj6Px6GNv4Gl3rf7MbNXHuzjZbDO57gTBi+tCSJfHSPkaOjrHvQMmZEdTSeUbdRr4/qPU7nCo1r26OHMBdyvsKom9FZttpbIcxkMpTO+swqbu/1fO/UDN9vTgABTXWBZ95XjMEwSPhpPPBerbfNjEiVRm0/Fr9FBXUmR2xt1D+zU5OCXWsMepAdhok3y6IG5591w46RcwNvJNE73kL9L/DKU3F/ueKIcvaLYXI9NH+uEbb1Nst0NDUeonSr9iDBqN93yAdtSzf5n9BbApPxWm0o5TZbM+BC2Ys48ht0SLxJ8rX4k18vDpdkZeskeTIbqbA4OSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+lhnji02kQqE3ZE4lPBpk6EgxLCHhM+7jfNFg12BxbU=;
 b=EI3hFvqOHR8rwJ2AwVa7jaMmObBsH4Tu6P8LFa5fGf3rgBL0mqpzSpfHueneVFoO690n/GWsl6mvYUaOGN6zdIpnrr0Wd0+WtFexXflgnEDiRRQ6Mx8jT70uyk+6270usInMuqde4i/nkuzN5YFUmgsOc3BM5FmEqgu7EBg6/FA8dh0fKw1Y3YlTY/gJ7ZFAHMUH6z2R9TQ+9meJUaJhQnG57sbwNo1jiv/IVwl9O/zENJNbt8UWn897aNwKG93Mgt4o6emWMEkagvotbum2CrP80OPeOsy7u/qpxDaL1iXFidXB/cqQtJf2PcaxTw5De7U++jg+5TwaPI0+ko82Qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+lhnji02kQqE3ZE4lPBpk6EgxLCHhM+7jfNFg12BxbU=;
 b=mud0u9VzMxRWw32fMi2Q8qELF10fXgxesvhirYF99W15QwuI6/Eo+zAsDhHvwnsRey3R0PHHWgfinpxRHj7zEUdL2iwGh6NatWRkVOOZOMi+lAF7CZsgQZVWS0wJG+WvS9iZLX7cNTaXnWat1/24/Cph3n0cBSs02w/wETF7y8WC+Pq8egav4yat9iJE0pGuKnqnubQ8CEvEqYVvmdKbii58+A8IBPXNPrIna3G8uIvzUMo0tQgBE8eaR1/j6qtVWcxXnOnoxb4wz0HmY2ZJcHwCA9ByXPA/0W8yb8P1NSm+PNtnLvFllKpqm+T94LXUqO5qjMK6rDJv5xU4JV6+/g==
Received: from SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 (2603:1096:4:1b0::7) by SG2PR01MB4170.apcprd01.prod.exchangelabs.com
 (2603:1096:4:1c9::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Thu, 13 Nov
 2025 15:54:31 +0000
Received: from SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 ([fe80::5e86:f04a:37e5:64f1]) by SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 ([fe80::5e86:f04a:37e5:64f1%5]) with mapi id 15.20.9320.013; Thu, 13 Nov 2025
 15:54:31 +0000
From: Wei Wang <wei.w.wang@hotmail.com>
To: alex@shazbot.org,
	jgg@nvidia.com,
	thomas.lendacky@amd.com,
	vasant.hegde@amd.com,
	suravee.suthikulpanit@amd.com,
	joro@8bytes.org
Cc: aik@amd.com,
	kevin.tian@intel.com,
	wei.w.wang@hotmail.com,
	linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev
Subject: [PATCH v3 1/2] iommupt: Do not set C-bit on MMIO backed PTEs
Date: Thu, 13 Nov 2025 23:54:06 +0800
Message-ID:
 <SI2PR01MB4393D642190C5C04A0543236DCCDA@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <SI2PR01MB439337D5513729BAC122F526DCCDA@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
References: <SI2PR01MB439337D5513729BAC122F526DCCDA@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0004.jpnprd01.prod.outlook.com (2603:1096:405::16)
 To SI2PR01MB4393.apcprd01.prod.exchangelabs.com (2603:1096:4:1b0::7)
X-Microsoft-Original-Message-ID:
 <20251113155407.1183804-2-wei.w.wang@hotmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR01MB4393:EE_|SG2PR01MB4170:EE_
X-MS-Office365-Filtering-Correlation-Id: e184fe7e-bfb4-4115-121a-08de22cceea5
X-MS-Exchange-SLBlob-MailProps:
	znQPCv1HvwUykhYCLh9DY9coCVULpTnX39YAd6DgWNivPHQ6ZhVZafONE1h0nmGktF2Rr8EpamV+rX60GsDFAarnb869ThodfJrHWkx1Lnt+iNjNz+X0x33LctOCNsyH2An/5JkjS7MXXelzdKn88V6kl7HbENQJaa8VuDY/PkgcUclAWmhb11Eb9/RMn/PBMRJwP/fUyeD4CP3eoITH3FPh3eHLWNFNSOLZWtdnctyIFnPUf4g1W+pRQ6TPBPmBzKu0ZpBytVQ1SNemyKPtqKhEa536Ot/+t3NPwWo9b/5uRLAWvhlKxfOEX/mQLLUQoq/la/hd4wspuCqcR+WNZF5s7htcIs8b7u/bYbHtDOJwigMQPYEFRI/+6bAe0ux2SR70lhlSikTbuWo2ymIQNe30IRJYbcjBeFZMIGevI7bvGuvmtOtUPyDqejovx0TEOx/vi6sVdS5A5eCBy+ERcHVvDZ9OnBtPvDAwAnfjEqnG0WBSjZ5TwdI28B27ISO15mp1wqG/hBET+Tc0GswTb7flMpz4HcFGrQt+vbOdaUL5/iwfI8lSDnH1RJkJIIXks7sk6IsT9sg5g747sNAVhOvRV6i6eJDd6X2nDhONsWlD5pHCnc64kOlK6lyT5m+djG6F7Ut0M1w9rKlkDga8RW49BuruMFKIB9dphSTcmJ3BMWJAYQEoer0t6cw0kYkUv9q9ErR5G7Cne1FxutnMPp7ZcoWpEXoJkF4VckP+S55OYbES3IFHt8LYIGlK4GFHDzXX8sN1N84=
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|23021999003|5072599009|8060799015|10112599003|15080799012|51005399006|19110799012|461199028|56899033|40105399003|3412199025|440099028|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NOIL70mb+qDrcMSnFlWTfgIuaBe5K6ZI2Spv3K1dFSY91Kp3yJ+OWc71mlwO?=
 =?us-ascii?Q?dhIAbi/uwThIrb8U6ZReEAqtxeXmV9hMBZFizTdcq1OL4MYBrNiYUdr5/wgr?=
 =?us-ascii?Q?bE0a9Kl5KJYygTFXb00mZkGs48qoDUuiTJwrRYfhG05qk79qtzsP3Y0Jm+RT?=
 =?us-ascii?Q?Hto7Jzq1gpK4h/PJCkK+YOTSlItOjA5lHUXuqFnSEkMhSxqqoyrzB+cNufwp?=
 =?us-ascii?Q?lzUkPIU7/OEFKLUuf9qL2I1q+EdC7/iAqI81nu9Ky5CSfcDWjIAQDSPJwb4A?=
 =?us-ascii?Q?uXbf5CBdSkvFYrELfaYVOxanrI7o1DqDlFwy8hTi+5jDhdPAjg1h5d9fIRMO?=
 =?us-ascii?Q?+CRzEEYrFHVS4htjkzpdJeCckZSmxq/UD1vwV95/iDaC3PMLqT74w6nU8TU9?=
 =?us-ascii?Q?16J62q7rA5KlVZuXRNp3ziJnA8hK8OdtShqf2zPW5MXEkrM+x5kcPVxcXcBR?=
 =?us-ascii?Q?OxUuCTvG3dV8+DCiLIM5d8BJ0/UY+V+5QDzsVjptkt5hKRQezdOoeIJ99yVp?=
 =?us-ascii?Q?d7/YpTiEBzgclxTEsZkSTxxRKIetpKrVODwFrdbIasPCKkE4+zKmcuM9eNok?=
 =?us-ascii?Q?+UjI9OQCAI3+uT7I3wj2Gwrkn+aOPBaxfx4HffJ/W7QOWAAKIV33xY3JC+Lr?=
 =?us-ascii?Q?9JB6+c6ZSxRUVN5CS2Pu+azgXtwlOl9DUjVvB5mpORkWl9BqDokNOjV8ttrc?=
 =?us-ascii?Q?mmqJ1S5OHIYOgHoeXX7zkiKtSNXeMAzJ4qETbdGAG6EtmgktTvRmfZl9xDNt?=
 =?us-ascii?Q?7P6R2yZ2O86YGV/QKoVg5H7hMOIW5IgIB/3dYgnV5OXbAsAB+r1yC413tioa?=
 =?us-ascii?Q?NjXMAqs5ighnPFmVw/SGyp91NcVkRmCStVoSKhvyzMU2o0QNu5kOh6usVp1K?=
 =?us-ascii?Q?4oa4jpGeX/U5b2DQiyo6dWzSrd5bAAYToW6e7jqDh9L7ntbxyIcaA1+XTT/Q?=
 =?us-ascii?Q?G7k9R7qZugTk6FpAXFJSxJs013R/4+Ac25WhI0/iMo7RVw+DOoh5me5Cos/W?=
 =?us-ascii?Q?dcSQs+abAaGwu+d+JQj7seTRJ7WpQH6xSQMOmRPVHnGeLoCvJMEIxwD0LzQI?=
 =?us-ascii?Q?iytY6seeTk5+m6XXl3olrYWfzyRAPDNxHEevHBqXTQ1sQa+cWrJTrZxftIwD?=
 =?us-ascii?Q?LKFW1g62/+a9CXLBBMinCP8/te/lkYifT5DHmoPU+B6M9ZWtv01S1GchpBAv?=
 =?us-ascii?Q?+H6kTxFwK8Yku9GRGqd0jqmh2c0xliqgoI0doEKCBAZyWRPukuTEI32nFJE?=
 =?us-ascii?Q?=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1qdpmW/dIlp58T8pETnvvYzecDAMY9G62+KvO8Nb0vtCp8Fg9OG1F8fyjAmQ?=
 =?us-ascii?Q?6HQ+3U1xystnDqzLVvCNTNqJLjf+iOfImdCE7l+RgSwo2HNWhZuDRn90+d+U?=
 =?us-ascii?Q?ySyRz9XeD4hp850FEJ5p43IARxUIRRCG+b8gjBnzprj4mscqJCLL+Qcz01Q8?=
 =?us-ascii?Q?zhxLvwIMQNizOwy7JpEoM2Brdr7g1e3J+8IyQPTGdrA6ph7rz+9+LRSbqBoq?=
 =?us-ascii?Q?hXcHOCpTQMWHxE7p2Uk5hU2LJVTgJf1pTBac0ggRZUG1Yqd4FsGYw0Jkr7lp?=
 =?us-ascii?Q?TSdg0EPAU6/K1ixkaY8gsgxT0hPidCzt4YdbeVMnDZQ1a7aY0r7F7ezvQE1U?=
 =?us-ascii?Q?0K1yCeBmBCEL4qAQMhVdlNwvKRH0XOu5z4ICfd6kKfRZ0nN4miXcHsjcCQ0D?=
 =?us-ascii?Q?4IsnHeD1D34BSqBKVzG2tdObplNJ14Ckj0O2Z+wsX5LlEHCtX8xLHw+va38D?=
 =?us-ascii?Q?/VwkcpfOG3yNP+DSNLsnKnncOlO6NJCUGWwL4gS4YB56hu25fc6q/INkrTjf?=
 =?us-ascii?Q?AKRQ+knjdM/ChBro+CV6Zij4946lR+F+2dK8fZgtcdwN8lAnQIti5TlJNQOP?=
 =?us-ascii?Q?O+b8FI1oLa+vw/QHZvzjzLbhSdXI6Zbg+OtkYxWTi7+LJVucQMEWCtRBjJcr?=
 =?us-ascii?Q?DRjPco4EdOXToOM0zX6ABYslqOUkD+lTURsdFqvjuBdnt17APdf2zTP/c6YV?=
 =?us-ascii?Q?f3++mYa9AbQMZo9lvwHhd9PxCs/Tw3qkOR0NPBUP+vuUdwNq+E8qsxsBovl+?=
 =?us-ascii?Q?6wdz5oN3jj2fGhFV/chKUhBdhN17ynLXK91I6Jsr3gZoMci/jSbWideZusjF?=
 =?us-ascii?Q?XorOHoT7LlqdGF0DjmEH6uwKN1YbVUrGgtHIq/oKgG16FF0uHtsiIc/piu4I?=
 =?us-ascii?Q?OSmWaxFjudFYY/uHjiV92wyCOp00D+AfutidwMRzzy0oxmQCwcUKxsuMNMvJ?=
 =?us-ascii?Q?7mDdFMBkhZLh4l4EL+I2Ezt31BmkUijp4JxuEms9C09R2wXcdf7xqQQpFNYk?=
 =?us-ascii?Q?aVB3SBmhzgZJjrzBPbp6bUy9Blxfem2lLwJjcOSMvYhML6kks/hHekGzEU9l?=
 =?us-ascii?Q?WsBtL6Vn/fd4eIpUVQnASFf0Q9JYEDuLKw04weTIKf6yLtb6UNfY+hSLQs2H?=
 =?us-ascii?Q?Y2ia9Uqqa7uzZPcmlI0kR3d49ZZM5qGcaJYtHjTspeo8A/GIbcJKCCpCBN+9?=
 =?us-ascii?Q?vY+wcPePyk3VxRuQRvTLtPKIdXkS8AITPMdoFQq0/GFa2di6hk7paXKVK4s?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-9052-0-msonline-outlook-827b9.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: e184fe7e-bfb4-4115-121a-08de22cceea5
X-MS-Exchange-CrossTenant-AuthSource: SI2PR01MB4393.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2025 15:54:30.9742
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR01MB4170

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
index a86353f1481e..ec2143488e8b 100644
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
2.51.1

