Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazolkn19013084.outbound.protection.outlook.com [52.103.74.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0247A1A9F9F
	for <iommu@lists.linux.dev>; Tue, 16 Dec 2025 16:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.74.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765901667; cv=fail; b=qz29rYFGnbODUx9yalemq8I0nZDYkhecNIZe557LMlsqjNuKy0f6qmZVkmRbSFFvgGi6ayPvyTILA2rDpHsZxg7Zm1Q0xzkBGLE5WH/5g5euPdzZ7kJqd+E5H7OWt2H0kdLlaTUcmYz1enTcx2DGN/DGSS+SlOtfsrHGkeOmAxU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765901667; c=relaxed/simple;
	bh=QXhq9jqV2Sks4rZCQxyfdMqG8KeimcFOkyzGl44wh70=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gOxPBN/ntX0Nd22MIt8+8ZVJiszxKEjyxUec55g/wUO2H2NT/fLICsuNKVCnoSMQE1NYIXr812T2K5MKtHKotKQKwMQpiyR/P+2tVpivago7AdKosctHI0YGaZRRA5EqazBPtIv8qVB9hZCYUuVDq3XVUeVe7yV9P/vr20YwwcM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=ouytwdjX; arc=fail smtp.client-ip=52.103.74.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="ouytwdjX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e2+/rST4OpVpDApgt2YY2g3zEVdh3ojqQn50SRP28pIz0iipvuKW09bWJ3/F2nyNbVp8WimIGTXDU5rRhx57zN1Hs2Zgf6B2e1B76XvM2Qrm0VoOdN8EBogy+o2uTWDJ0Rgiyz5CjCH1j90ZnmFiFXjy15u98/SOlq7vBiqsszzWOOwlvMh9KsicrsPjFgTk8jMalxgvXtIeNXxY3tiYgIitnIzpSIuBMr39LwWwPF+k7VrmIZSTR7iiQ1pnqyhCfjrMy/hHIaw/JdWTKhe5qPqMwLtEzKknITJGhP9ZVaYppR1vdwD5BrVS7+WEeL8YcbNldvnIA+yKkGEmjkp/7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KpAdFqRYNTAfIW9mKTA7oRhI12Cr2VPJMTf4Qh/mJoM=;
 b=vUyuTCQIN+XZYFzTXGIGqEE0HnrpA6ZNKw/HqbTO2zL9rt3DAU1oW2XGRjF/3/sFcgVga0BX4yD++ODlHpen5qjFsYNuIZz4rwUt+scJovH7klfUGONEt6No5xURbKXHJflesforCqrX1pbPeDyHPKJoCqQbnnYYbPwyauJWyFdlNuGot6PbVYeakfkaxkwG26zBUovx/VWXvMPuZAau56qGKRV+UM/lOBZmyGk0GrPy08gpP6dJLEyn7n1LsT0pJtoAc0BdTlS6E/51SQrHrtEWPTNMwhjI5ZWeuWhfn6AwORgAoujB+tYTlCQas9SQ8PUnx4VpTrjUArKFCGTBCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KpAdFqRYNTAfIW9mKTA7oRhI12Cr2VPJMTf4Qh/mJoM=;
 b=ouytwdjXQ6s7ua15H9GmH33dG//3mODgAhpsiRHjsWqm+taoKtK0kGFE0iJvz27DXlKhyMFkfEeZaMiGs5aG0GtsUVM6IxvOhEG5Z87vP/ioBUvhonMVcG1sWFrkC5qmBoqiCNPoDkhgfh+sSq0yOp00IRfQbUhntsWA/QRGHGRrnNLVm/7VCK1N3i/9CLOCkunQibT8nV+d8E9jIGTHbZUa31JusjTYUEJDyBhLdxFtOjoaNrjdq0T6CyARtDNjrSPruv/10mI1qnzuNA6svnQYeREkwSt/PVyDdGaCdHa9OBSXYZ7t305omKkLS5J2cZUdbI5niFDLjfZUwkFUxw==
Received: from SEZPR01MB4399.apcprd01.prod.exchangelabs.com
 (2603:1096:101:4f::13) by SEYPR01MB4770.apcprd01.prod.exchangelabs.com
 (2603:1096:101:b3::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Tue, 16 Dec
 2025 16:14:18 +0000
Received: from SEZPR01MB4399.apcprd01.prod.exchangelabs.com
 ([fe80::5145:bf70:5ca0:ee19]) by SEZPR01MB4399.apcprd01.prod.exchangelabs.com
 ([fe80::5145:bf70:5ca0:ee19%5]) with mapi id 15.20.9434.001; Tue, 16 Dec 2025
 16:14:18 +0000
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
Subject: [PATCH v4 1/2] iommupt: Do not set C-bit on MMIO backed PTEs
Date: Wed, 17 Dec 2025 00:13:46 +0800
Message-ID:
 <SEZPR01MB4399B4DA74A3C76056881D72DCAAA@SEZPR01MB4399.apcprd01.prod.exchangelabs.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <SEZPR01MB4399D06A044791DEA8BE43CBDCAAA@SEZPR01MB4399.apcprd01.prod.exchangelabs.com>
References: <SEZPR01MB4399D06A044791DEA8BE43CBDCAAA@SEZPR01MB4399.apcprd01.prod.exchangelabs.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0244.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:456::19) To SEZPR01MB4399.apcprd01.prod.exchangelabs.com
 (2603:1096:101:4f::13)
X-Microsoft-Original-Message-ID:
 <20251216161347.1380195-2-wei.w.wang@hotmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR01MB4399:EE_|SEYPR01MB4770:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c2f1bae-a093-4936-4240-08de3cbe2a10
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|15080799012|461199028|5072599009|51005399006|8060799015|19110799012|23021999003|36102599003|3412199025|440099028|40105399003|56899033|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MB9OkGERtxRcy8Fz7PcCQ9uG/VPJQNoc7pb9o2Eb9VjQfcG/p73kLGicVwkw?=
 =?us-ascii?Q?E8URe9C0+crx9dkeSzqae44gmsIPc9vjPx6RoSTwekCV+aRiCLOC26xyi2CR?=
 =?us-ascii?Q?Kwu45H3zY5Dhs+GEcRzMR6M+wns2VtPTkNfPEBlOPclL0iLje81+yo6afgk5?=
 =?us-ascii?Q?S71vvZz20mxGlEPzJmMjgrpmspwLPozjnCk+FLpRssSohdZjFw9qgviM8otj?=
 =?us-ascii?Q?0nFe0E+vimwhO7qW8OkXSnniRdj2BWbcJ+S6JR6jcpQSqRJkMrtZmdGPPhVZ?=
 =?us-ascii?Q?rYJSs8dsHJx9Ycu0MrBNdA0PD51NaIhTiRq1Kpg+bALVB3uSUnz0tB9mo2vg?=
 =?us-ascii?Q?DuBvKE968/K/0RrSa/uRzQyG3ySttX8P+Nr2G1o5Iw32I6BiU5kPcyMQ4J7c?=
 =?us-ascii?Q?26ni2DODln0TICJltJQ9NV90mhJWd0dzfkgq/G4eqOBdZp+9/95skFTkOXoa?=
 =?us-ascii?Q?M1gV1TJJ9U0KsSNJtaLhFo9tLms7dxLxJQG0s5+4fujvwnLG52w7BO77N22E?=
 =?us-ascii?Q?2UXLI7gpRCbSYCHvW2Y4ZJ54108+DMpwXrpusSfsK+aPvNsDiVkqRrigp0W8?=
 =?us-ascii?Q?h9QSJhhKcn8mNFUqrJKGh+gWfXXgANgjl22z9HGiyaFJhIHn7W6ceesa5kbG?=
 =?us-ascii?Q?0OUrSUzBCnQsduJOUIKfxOhCRvTEJ6jDoLJTw0j63dQJsT45oQuKALo+uG3c?=
 =?us-ascii?Q?4DNalamNVo/55JMXY014naUv4mo8rGl5E1EwqZbebk7K8xcRUMegQtM/i+Ka?=
 =?us-ascii?Q?F4bOmb/0ciYLLcU3ndl58Mna7wfPNzEGMJprrGrqOnLihq4bjeYiLXtezgN8?=
 =?us-ascii?Q?2jc1ZHKtsylyo0I+KE68hyFVLvrCQkFWiEDSgfw4JnRraMwG3drwN13MLLze?=
 =?us-ascii?Q?3AYoNRBl+FjhpZhhMgqAdlZgQ0QoEUMQFGpZ20DQ8IZRT537KQqadq36nkwt?=
 =?us-ascii?Q?70eZHXMgfIAPueoXtEK7S0ixxSSvIM9EQvmVxQcwVW340Phlk4IWeHpm6L9b?=
 =?us-ascii?Q?7vFDa2tOej/sf8Pnc26hWhWA4LGAvmj+zAuphmRX5T2vRiHkHx+f2qdm1JgT?=
 =?us-ascii?Q?jJVlBntG1GPHIxPDhYwSd1Sk3k8bareykXAJ0THH5rt7F1rSLk04trnyQc2s?=
 =?us-ascii?Q?QYzOgGMYrfM0GKm0W8mo6txbiBd6v+faY6mh1y+BGfVIEMvssTX2JzJ7cVxE?=
 =?us-ascii?Q?/t6AYYZ3rxmzyXCvcwqxsdNSZTQR13KWnTt9KJ1Z/pYlz5WLXK694zQQkz8?=
 =?us-ascii?Q?=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hZTimjACi7d5JYcbxrsTihbUURK0qNfT69emGjAnjj08aaiTEN+q4FHws8A4?=
 =?us-ascii?Q?HXgIxFzG/AdQ0r80hD7NedoHPdVDJvzOSSq/NzPc2prX52okJDNvSTBA1/GP?=
 =?us-ascii?Q?Sr22PiyOhIxZ/zyttNCnb7SNeWlx8975k4EHzaexeGBZi4M6x8Fyf+j4dqNq?=
 =?us-ascii?Q?69k+EMFfP9TsC25DMqK+9APKncJVMG080duz1YSHVP4PmaR0Nw/HFMiiraZZ?=
 =?us-ascii?Q?+5hxwnm/3Fr04BKWOlb7UDP5I3nYdMpnONkwfqMHil/epVc6ukJM3uPSvCSN?=
 =?us-ascii?Q?5SD0ZHlW7+lTUKhv7NorAk4ne1u0DoQwfqrIK/fmljZNRSQkWc1+aCDyXVbM?=
 =?us-ascii?Q?h/soquIyzYjwXdazBA+8NrhYXt7hxCNc8KhlAgesqb+X9zzs++9YNXS+MWLy?=
 =?us-ascii?Q?HPXxaibF+lZIIH74Fb3Eq/eizW0lMNxDLX+uf6t4MDWebk9WcRBJHdd0XeUO?=
 =?us-ascii?Q?N6Cld6Pxxne6PA4mKxMddi+hRkY27yy+yHr7UpQoAOK1/yYU1qmFu0jq+gLM?=
 =?us-ascii?Q?nVVxvd4PrWBni6jNi/zRfKPGV5KT7aibl+JaF1ivW/DgW1lil7i9klj4pJI8?=
 =?us-ascii?Q?2xLP82a9AvNhdV1ddazUFPb9BhIiXFbHzZs7QuLe3eePLWdKOgfjxfI4RVU1?=
 =?us-ascii?Q?Jrfm3S+FMbekfM4Zi/HnxvhYqw/BUUZijb2ipvGEDd4Q8+3VyK6BraTrK9Go?=
 =?us-ascii?Q?3LxAIvFPvjzCbdSiJDGY/Ysm/tGz60iGfkVn2QpVDo4WcLFlofv9asIA6hp8?=
 =?us-ascii?Q?Eb9ILXm4Gw0RqRKr0IghCHVDU2qmBsspP3a1LgNkzcgQ5VsLrJCpuYIWc6zR?=
 =?us-ascii?Q?Wa2FH4TtaBpLQGpqA/rfbiry3y5cAveJWwKJB+K8PUATFiheH+dKZBd6LgJ7?=
 =?us-ascii?Q?33n7I/ck3iazmwB4gXG6ccfaAME8kgX4U69vPH9ADw9MjwXBi8XRzS6KEqbY?=
 =?us-ascii?Q?leCM4f3MHHBQ8+cTJQXBE/LrVDl7vuy3JY6T8kSFM0EXs8HUi/IOv/rROhqZ?=
 =?us-ascii?Q?L1ep1hbWfY+ooI2sLoJFo5Jgc85V7ihsRzYKLBoVCwPsuvJqjhuCQ73kiTq4?=
 =?us-ascii?Q?/c6ZTcL1E9wcaZW+DH1HVTA9n1yG9DXLfWKnL96KFQPUgR/2rlxnjFtPj1Lb?=
 =?us-ascii?Q?zO5av0QTGBVsbrZ0cR+nIlPUD/+GIGYetJMiFqGAh4fDHU1lvFt5wsBxj8Cv?=
 =?us-ascii?Q?saCsgTMfx23obaiyBZH8uVlAkBj9IUci5lbc/2mQ7rledZ+u+afHTRbRv7Y?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-5f51e.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c2f1bae-a093-4936-4240-08de3cbe2a10
X-MS-Exchange-CrossTenant-AuthSource: SEZPR01MB4399.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2025 16:14:18.6101
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR01MB4770

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

