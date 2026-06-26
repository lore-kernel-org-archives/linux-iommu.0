Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010049.outbound.protection.outlook.com [52.101.56.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE3583F0A90
	for <iommu@lists.linux.dev>; Fri, 26 Jun 2026 11:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782472145; cv=fail; b=dQWzg1uxcN0fkOpiQpatT9+6W62rz8BHj4Aq4Uk536g61XGCoGyfw2QJPnOVbzKWYVdbxrEzxF7gL8AhkJ/xp9D7YT794xOjyDHFc8+aVpfTUK72ALTra1Q/uUESRmURTAHQCdOYafE15T9QfIRfTEfXQWGOkghlcgvcK+gSPP4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782472145; c=relaxed/simple;
	bh=5lK2wMaTIEOc7fR9t+pXzIRqI45cUWiIP4aSh+Ef2wI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pAckp5uJ80RzPyogVNkMLBROl9n0JnIOfUlPeeLxYsieCkefdJ/Vo2wn8H0SQxUfKNMHO1ECnKPK9dMNFxdTqkUrWP++90ZheSO5FWulQXHJvP4mcrOg9yEV3ZFPI42NiUBe6EMoAF8A9XfAdrRDnHqRu6QhyoghlycmS1qwnxw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=lYeYaxeS; arc=fail smtp.client-ip=52.101.56.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="lYeYaxeS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fjHwqHdv2hv1yjJQz8MNzNdQ3Y2bV1zO1meHVO0WR+Uve3+aSmFqCmmmK5ftN1tYLrsVYVHV8S1ffyzKH9PI4qSMXAp1JtGqeK2OIu3kBC2LRk2RmBsukz/YDIRc2qaaXCXyaVpKoPVoUGsJ14qId+k9+TmYSQs9qEchEwWTPsr/Ek+Y1uMy+N3/r6GkLDDKRMfsBOD8Zh6A+ffM6KOFcnnLW7yiiXv2mmtosmm5s7D3El6n2NnvX63A1PCOyqToEZs2DmciTAjNKItKpqz1JNk+58D6sW3lTxrGRh/5OmXlsK2RXobB21dhDxpace9yJRvNxm+ipF62COa/y9o2Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9ZhWNyJrkSv5u9Me/m6yp2sGrgKw7VmzDp9nUipX4fM=;
 b=tW5SEaLXvDA+Z7b63h6JwrH2UlWb5ItMeTtwSH9JGEGOgwR9G8YJ84UrTZdtN1oVgYxd3zqha6bVkfxlZg9Z6bmGaj9ukkvbCNx+djzKoX4/85ef0YopGWQ2PXmVQuBQPzyQOhhSuRaoPTQed6WnHzlwnc2dSTT9Zgv1iAVVAnun6404JYZTy7Az0rIRF8l+oOPo8DOlk9vj8uL+uke+uhFX6Yev/NC8rZ9BN9NWqfYwUfw/YzFXSsgScOGchv1TWlx/TOXI+skvALuJIHhMZ/jTH/AZjc7myJFczWPeVgzFzkXUlydXrRL57lsw8wAwIJQ0D8RWmACCCk67fqzsjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=zytor.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9ZhWNyJrkSv5u9Me/m6yp2sGrgKw7VmzDp9nUipX4fM=;
 b=lYeYaxeS1EgGvh5Y8l5Gymp4DCHL/9ReDOsmZs1VpyoO9NubEYocczPwOs8uDBAn0kkqb4oHx41Uu/H8cikGy04jp9CYisfGzpRMNlIbDLByosoa3q8o3GN68RWEou1sIraQXmlK5trlaFLcpsxA76MbbURWDkRugDt9/2gmjJQ=
Received: from SJ0PR13CA0034.namprd13.prod.outlook.com (2603:10b6:a03:2c2::9)
 by LV3PR12MB9401.namprd12.prod.outlook.com (2603:10b6:408:21c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.13; Fri, 26 Jun
 2026 11:08:59 +0000
Received: from SJ1PEPF00002312.namprd03.prod.outlook.com
 (2603:10b6:a03:2c2:cafe::27) by SJ0PR13CA0034.outlook.office365.com
 (2603:10b6:a03:2c2::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.7 via Frontend Transport; Fri, 26
 Jun 2026 11:08:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002312.mail.protection.outlook.com (10.167.242.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Fri, 26 Jun 2026 11:08:58 +0000
Received: from BLR-L1-SARUNKOD.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 26 Jun
 2026 06:01:14 -0500
From: Sairaj Kodilkar <sarunkod@amd.com>
To: "H. Peter Anvin" <hpa@zytor.com>, "Joerg Roedel (AMD)" <joro@8bytes.org>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	Ingo Molnar <mingo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "Robin
 Murphy" <robin.murphy@arm.com>, Sairaj Kodilkar <sarunkod@amd.com>, "Sean
 Christopherson" <seanjc@google.com>, Suravee Suthikulpanit
	<suravee.suthikulpanit@amd.com>, Thomas Gleixner <tglx@kernel.org>, "Vasant
 Hegde" <vasant.hegde@amd.com>, Will Deacon <will@kernel.org>,
	<iommu@lists.linux.dev>, <kvm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <x86@kernel.org>
Subject: [RFC PATCH 5/5] iommu/amd: Provide kernel command line option to enable GAPPI
Date: Fri, 26 Jun 2026 16:29:06 +0530
Message-ID: <20260626105906.14577-6-sarunkod@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260626105906.14577-1-sarunkod@amd.com>
References: <20260626105906.14577-1-sarunkod@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002312:EE_|LV3PR12MB9401:EE_
X-MS-Office365-Filtering-Correlation-Id: 23a7c7f5-9a52-4396-3ed3-08ded3735233
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|36860700016|376014|82310400026|23010399003|1800799024|11063799006|56012099006|921020|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	dvymmByt5b6q4dIXgXaZ5GPlydqbWwESgkudnjWZAkZzk36mL59v8HOJTL44zPz27vBgRRngJ7JefaW8VaLLb+83+qPiTMmddKHcRMJuJY5nAEDH8Ty30XlIxlpkZrkbMENB5UxCalfWFcdr7sKfNGovYaPNVGuZz6NI7fUUnsILK4+UJ4CN0NzgZjMxzG8W3G7ZbRUJAhKp8c6KqToy+2fMGH4lhf+ud5HGTSU8IqRzCL2U42zg6t/pD08n9t02tpEOgoH4iisAcwCncuoXpVRky0/NB3VF+MGk3hInuOyM8r6vK1zfbZ3zI353Kp0685B8dn7NJxtV4lkewiUNP1CMEA+4ob+BFKpfFWUJsPe6iOBLCXwuDNnMaaqn3IC5XtnpwQe6tZVy2tlkkAsc7R6XzTe/hFOF8CSHHYz+T1hwKSMnxDSS4XwCuc0XKtdE3qdnFwzAgDi8zl1X61dxwzatOhXV3nzwvdGVPFQt15NCddmqYQOE3AxdSUKb4wiE84FA73RwI/QrXIzx4h7IoSSk2wLo3FRkqF6ci4Lm63sVuGdPpqSlfZgHXbZDpHlIimTsfb3n5onsiebcmYId+IvPalvgsEDqB6msrbizGjocX/CkJ/vAmQx5sLFpquWo+IQvxn6zbmgRpgI8St0j2lTrbhCT0bMuAgEbO/d7Mifa7vVFJQK3A2AlK+eaEfh4n6chesv5ZG1NZAHIhJ6HLvWoyDJ+Xq0OSu0915tDGk/fdlWRO8p+GUoe14TEdZCX
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(36860700016)(376014)(82310400026)(23010399003)(1800799024)(11063799006)(56012099006)(921020)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	UbzheAH26WJAoX9OEKE5WjWigs9q3BUnxR0OZNseU0HsL3CM4TJTdGUMumqygXP2c//tNGCweN93oeBkFoy5p1DaZuovky/7M8za3CaA53AeURAk3G/J2Zi+tu7UJd0ChXUPmCBRIGXGcgxrK69aRKwyoKh1Od5Q513T8IdaWYmag9BW9RBgrfD84Q6V3Da2Kn3oYd0/79YQq1drPQrJv50MvJV15f5sOVdiYKgTXOw4t7O6OFx+fhneEqmFN4Yy6FYXPOf1hI7l45PnsGXvFZFbHhRXMZsnSdhFAPXqyVdInbFTVYZXXzQ/pf18gzEdiAw6Oxti4v63w9yMrHFCV7Nk4qycbNRQhP0mi35uwWJGXG/uydH1dUpAMmeFMdgbv2utnN3ChmK6ql5OUX/PO17TnxGYlzd5up2QBome+cYByFxv0gOM+O1KlSHsMaHx
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2026 11:08:58.4626
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 23a7c7f5-9a52-4396-3ed3-08ded3735233
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002312.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9401

Enable GAPPI when IOMMU GAPPISup extended feature bit is set and
the kernel is booted with "amd_iommu=gappi" command line parameter.

Co-developed-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Sairaj Kodilkar <sarunkod@amd.com>
---
 drivers/iommu/amd/amd_iommu_types.h |  2 ++
 drivers/iommu/amd/init.c            | 20 ++++++++++++++++----
 2 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 26d7a9796e64..de0b23306944 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -94,6 +94,7 @@
 #define FEATURE_X2APIC		BIT_ULL(2)
 #define FEATURE_NX		BIT_ULL(3)
 #define FEATURE_GT		BIT_ULL(4)
+#define FEATURE_GAPPI		BIT_ULL(5)
 #define FEATURE_IA		BIT_ULL(6)
 #define FEATURE_GA		BIT_ULL(7)
 #define FEATURE_HE		BIT_ULL(8)
@@ -191,6 +192,7 @@
 #define CONTROL_EPH_EN		45
 #define CONTROL_XT_EN		50
 #define CONTROL_INTCAPXT_EN	51
+#define CONTROL_GAPPI_EN	55
 #define CONTROL_GCR3TRPMODE	58
 #define CONTROL_IRTCACHEDIS	59
 #define CONTROL_SNPAVIC_EN	61
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 2e1889f8a9e4..b3e1d8ee7e9d 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -3038,11 +3038,20 @@ static void enable_iommus_vapic(void)
 		return;
 	}
 
+	if (amd_iommu_gappi &&
+	    !(check_feature(FEATURE_GAPPI) &&
+	      AMD_IOMMU_GUEST_IR_VAPIC(amd_iommu_guest_ir))) {
+		pr_warn("GAPPI is not supported.\n");
+		amd_iommu_gappi = false;
+	}
+
 	/* Enabling GAM and SNPAVIC support */
 	for_each_iommu(iommu) {
-		if (iommu_init_ga_log(iommu) ||
-		    iommu_ga_log_enable(iommu))
-			return;
+		if (amd_iommu_gappi)
+			iommu_feature_enable(iommu, CONTROL_GAPPI_EN);
+		else if (iommu_init_ga_log(iommu) ||
+			 iommu_ga_log_enable(iommu))
+			 return;
 
 		iommu_feature_enable(iommu, CONTROL_GAM_EN);
 		if (amd_iommu_snp_en)
@@ -3050,7 +3059,8 @@ static void enable_iommus_vapic(void)
 	}
 
 	amd_iommu_irq_ops.capability |= (1 << IRQ_POSTING_CAP);
-	pr_info("Virtual APIC enabled\n");
+	pr_info("Virtual APIC enabled with %s\n",
+		amd_iommu_gappi ? "GAPPI" : "GALOG");
 #endif
 }
 
@@ -3741,6 +3751,8 @@ static int __init parse_amd_iommu_options(char *str)
 		} else if (strncmp(str, "v2_pgsizes_only", 15) == 0) {
 			pr_info("Restricting V1 page-sizes to 4KiB/2MiB/1GiB");
 			amd_iommu_pgsize_bitmap = AMD_IOMMU_PGSIZES_V2;
+		} else if (strncmp(str, "gappi", 5) == 0) {
+			amd_iommu_gappi = true;
 		} else {
 			pr_notice("Unknown option - '%s'\n", str);
 		}
-- 
2.34.1

