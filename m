Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010051.outbound.protection.outlook.com [52.101.85.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17F8937A83F
	for <iommu@lists.linux.dev>; Mon, 24 Aug 2026 06:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787552985; cv=fail; b=nMu4w2FNlHl/kIQY/ZkQoMDCzbhDkAjvIYx4OzA2zm6qtGfCpAHxPvWq3WunyfudCBfltqg1MaIDGJc4HiajpN77beXQKmb9H5HMASY3WSh/jate+RvX307q1YjP5keSGnSbHJjccDoEHZlROg4wTAcDj0HIWMm9RxJOQTzHZVE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787552985; c=relaxed/simple;
	bh=xtP4t6zLOqicCJHeOjzNob81trixUQbNX5p1vAsStlw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=amPYc1PPTPXjL+Ul75QEEZrL6fEWFtuc8wahI+UHl2mo+/+VEsZ8zQ/EuSVrV0GMRYIjiNuGc0zFbWPi40C0oEX4MypXQvzZ+O/DSKnk5xJMMjTpEM79TPVWKYqVQXW3X35P9QrkB2zexQ1lyvKYiYyic8rFN8R4lcC/f+WkaBo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=EtYpHCkE; arc=fail smtp.client-ip=52.101.85.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="EtYpHCkE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sKqDWA1cXTnhZxHjQaYWXtxJGbSFp77dL6Ej6xC6YgGHRJsCSSpHLi6KdyAVVtAz47ugy1jkAN23CE26sbLpeWAxvt4Y+5wU/+JX8/uHQQ3sltgWY7YR1T1rii4dBDM9kTaFA3o4nYcjgkuI3qgweflWzPKMTMAIH3C6TpaKOPhvG59gdcvhMZL64I1SCR6OsCimwY5k7cTXxNlc2DceSXMaCWrEFRdhEOqRSG9PYq6GdF+TkoRi719JZRj7RT9papzrjEX4RsC/JMbu6YV/wBF+OyBMSRButWZMOQIsXhkeHb9RHPnRmxFQC5sv37U5MUXHT7h2cNQaU84VML//8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D/YpLgL8zQHxMfHzpWrIgUEiFegOudCu9YdQnqqvOvk=;
 b=zJJjnH8TECQTHxuhQcBbzwZBCsVRZ00PxswR+PhUIv5SqlTQpo6DXM+I3hhwcUNCKt9UB6aJahhAz80sie0jaRj8hr9FxEWCDc2lZDwcU3DmP4EyU7sTqFUsCytkIisAFPgAifkdTr9HpjhjEAnGXP7o53OR74ttBr1bLJ6WChPjjBoKkVXjc+3uCNnheo0nKtNsF+e3EDVO8IaHeWLj4IKS1U4OfIFkg8iXSL35fPVdGT+zukpeC4ufsnbPY8ACBk/bp1osw0AKAUnMZ6Th0HQWrg8n0mu8fphUVRulyQaEl7ftRABdgE7BiMm05jJSumNgCm3vMSdEN8hJ/0skqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D/YpLgL8zQHxMfHzpWrIgUEiFegOudCu9YdQnqqvOvk=;
 b=EtYpHCkEYpFwPKop8nSo1E5s+X5+DWeXjJRGITaj0Eyp8XPuUCnytB8VjVH5gtJHqUNzyuPMtoe1wN90QydTQO2MWyukVDrMME3gMV1Rh7a6Bhr2iXKkad8QP9JV4AKhwHSF8WzKDIe8e8W2guEHt7BgkK1PF1BO3bZNIaG1rTI=
Received: from DS7P221CA0016.NAMP221.PROD.OUTLOOK.COM (2603:10b6:8:25c::19) by
 DM4PR12MB8570.namprd12.prod.outlook.com (2603:10b6:8:18b::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.12; Mon, 24 Aug 2026 06:29:39 +0000
Received: from SN1PEPF0002BA4D.namprd03.prod.outlook.com
 (2603:10b6:8:25c:cafe::ad) by DS7P221CA0016.outlook.office365.com
 (2603:10b6:8:25c::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.12 via Frontend Transport; Mon,
 24 Aug 2026 06:29:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF0002BA4D.mail.protection.outlook.com (10.167.242.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Mon, 24 Aug 2026 06:29:38 +0000
Received: from kali.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 24 Aug
 2026 01:29:35 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <will@kernel.org>, <robin.murphy@arm.com>,
	<suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>,
	"Andreas Juch" <andreas@juch.cc>
Subject: [PATCH rc] iommu/amd: Fix premature break in init_iommu_one() again
Date: Mon, 24 Aug 2026 06:29:07 +0000
Message-ID: <20260824062907.4926-1-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4D:EE_|DM4PR12MB8570:EE_
X-MS-Office365-Filtering-Correlation-Id: cb6c465a-8631-42d5-2563-08df01a912d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|23010399003|36860700016|376014|1800799024|56012099006|11063799006|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	sIXWdK6nC6Eo7QvVZJiiI4BnU4XQq133v1tCAx7h3ZOJFX1kgqIohFM6qysP0i0PydU8yH6sgPcjM6Z03fq3DaTCH2kiYFi1NX2Pmdpq5INJPeq3llALcL/BF8/kNW1Tydhc52Z65cWvM3EByLI1IhngFwpSG4fOtvFzSdIDvBADSOHqkRfuL8Axs/hXDy/UfKoAUhmHaSzolw8Pe9KkLVEyId8j4QFRYOAdsEaWU41P11t8CmsmsoewEJf/F/7a+5MIi0nadr306HSNNpJoMUXluaHVuE7ZWj37BnfZ+aM/XV4kqToMjTvitLSwAvadw4I6uVaKWNCYMAIDNbg2VPe/S35XvoSFa1gpXHNS/rRgp2WAZ/Dv+cZea/GLM7CujeOnyTnhY8BzWlg8SWECKlOQ3NuNJ/kammUvIiw94A/6sT6mqwC0Njm66CszHGvigURW63hR+hwIEEKZ/2YlpctiEne+ptiV+Gc0nA7WamoWtBYrLh0GP7mNjJeEYRNuEWjmzDMx2qUKGL1zmdc50WyNuZRAuocCHnporS6+wXNnZZ1EsTMMheYvLylOfhA0AEc5KmmCnvioVDSb1eIu6ZCT2lopzgTucXQUJbQZ08zTzQPO/bxGSaegLbegrCzLFWYwk3swJEkhM4O2f+tfkXB3ruk2o/ethKBnBjuHBhJ6oaFpDivzjOnTmE1e/AZLJK/TKPWWprdnjjs54JmwDw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(23010399003)(36860700016)(376014)(1800799024)(56012099006)(11063799006)(10067099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	p/jCZb0IBIcfcYrNP/fVkcpRNx+7Myosls9EftHmxqjk9CqlqFD6Ohp6y0LyYgvh5P249trx82CeIzFwBI9g6WvvnF39nMQgtPWXTq1r5/XIeVZH9VYJYrTJ8qeoJjYVafH0JSGSJ3wmdcLal+lxS89E7WIwfcioWJ7gsbByIJNXAcGBWoy5hq6wXKHZNGfQsQ/EtQKbkMRCYydcmK74Ahj7Su1TFDf1p2e5VPXdramMxlixMqY74rDRGpgWnxl9g9p4D1xgHj445pKT+gOMZ2is8li3RmscsRz5KQQ4HC0hu2ZR2a7e8kmmR0IZfldPAAshPiQ24jYiBgCavSeMf6+npQP9kNHbXnPcBh+cP6JRh5qPtoiz/jRWf30g1y1D4PwztNh26tBmAq9ZHxvRzSG8uP63MbhHCpSREE+duH81z9JlSBdMHwdPXIZea0Qy
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2026 06:29:38.6508
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cb6c465a-8631-42d5-2563-08df01a912d8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA4D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8570

Commit 283d245468a2 ("iommu/amd: Fix premature break in
init_iommu_one()") unintentionally broke older platforms - such as
the ASRockRack B550D4-4L - where the BIOS advertises incorrect IOMMU
features.

Move the HATDis check ahead of the GASup check, and re-introduce the
break inside the GASup check to restore correct behavior on affected
platforms.

This is a short-term fix to resolve the regression. Longer term, we
should rework how EFRs are tracked and prioritize the MMIO-advertised
EFR over the one reported via IVRS. That requires more extensive
changes and will be addressed separately.

Fixes: 283d245468a2 ("iommu/amd: Fix premature break in init_iommu_one()")
Reported-by: Andreas Juch <andreas@juch.cc>
Closes: https://lore.kernel.org/linux-iommu/07b2d390-f7a0-47e2-bc2c-eb0853acf52e@juch.cc/
Tested-by: Andreas Juch <andreas@juch.cc>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/init.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index e7d7b4cb9337..c67dfd39a5ef 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -1914,19 +1914,20 @@ static int __init init_iommu_one(struct amd_iommu *iommu, struct ivhd_header *h,
 		else
 			iommu->mmio_phys_end = MMIO_CNTR_CONF_OFFSET;
 
+		if (h->efr_attr & BIT(IOMMU_IVHD_ATTR_HATDIS_SHIFT)) {
+			pr_warn_once("Host Address Translation is not supported.\n");
+			amd_iommu_hatdis = true;
+		}
+
 		/* XT and GAM require GA mode. */
 		if ((h->efr_reg & (0x1 << IOMMU_EFR_GASUP_SHIFT)) == 0) {
 			amd_iommu_guest_ir = AMD_IOMMU_GUEST_IR_LEGACY;
+			break;
 		} else {
 			if (h->efr_reg & BIT(IOMMU_EFR_XTSUP_SHIFT))
 				amd_iommu_xt_mode = IRQ_REMAP_X2APIC_MODE;
 		}
 
-		if (h->efr_attr & BIT(IOMMU_IVHD_ATTR_HATDIS_SHIFT)) {
-			pr_warn_once("Host Address Translation is not supported.\n");
-			amd_iommu_hatdis = true;
-		}
-
 		early_iommu_features_init(iommu, h);
 
 		break;
-- 
2.31.1

