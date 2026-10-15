Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010007.outbound.protection.outlook.com [52.101.56.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7949624EA90;
	Thu, 15 Oct 2026 06:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792046918; cv=fail; b=njwP4zFhbEloYmWcVllXiIu1xtlqfocUyPt17WvyJqfsOHSqZjZxyBI17+Eqc2ib+3WZlng9pR5oyshFfaaLdUpI54yE7UpixDP0gudIyAfq7uvJOFygK9eumMaA5V61QIFZplsh5QHfPPMR8LjRt5SZ8umFg5z970G3N7uZHGE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792046918; c=relaxed/simple;
	bh=X+3wPiNIY/aryrrkG1ADF4G79uAUbyHWHnckn1/g6x4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=svHKCR3XOg+nScNwJyT2dYF0XGnCRT5Y0en7/34IGsJMPsVGWiAUjtxlhT2W0ZvsQGSTzla2L9qQMm6uPVEqGHVfQqdaSbChKmxa+FW6b7JrtB5pazoQzgZiDRZ9oMmPvzUa/cSPP/WTswBM/in22P0nvVh9DFDRD3vaB5eTXpI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=rcq0W2Ce; arc=fail smtp.client-ip=52.101.56.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="rcq0W2Ce"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yGGVSYL+SoTutWMbm89n50jWr7V2OOW1EJrPlIDW9BpD0LAqMUBNbI878gj2e/ymUXK3fh8iPMkLXO8PY5PBNcgdXqHjj2eHRIejZI749/qj5f3XaLuBGQmEmVnI+IE7lkSqXoI9aFdSBRfDJMLw+cGT7s5LwfY56rUBI9nIWjQqghEKN+z3ayUK05n1cLolQdnBih3N6tZob5Lip/U5I04ZAlxMRR3W85Hirdwm3yZ5hIXHOJV+mJmZEd4C4Z4YootntigDrOvOcwEluh2llLR+V3QTm8xtcEIU5T3RZR006Fi/SbuX9vjHVLAcoRpAQBLV3aFfTlsLxqTuojFVfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wcq5krF/Q9hEi1ogpoJRGe5osH5temXaEr+QbDdY208=;
 b=bLP3pSn9OLIYZ2difolKqXpdGLvyGjdk10L4tSeGQa6R8IgkSg0EEqT2DrTOApzVCEKQUVWPXgjieaNX2qw7OgKVCV2+6FTJDxvFVUv8qYF/tL03Rmv19uvGMN53cUrip1NDDt5uDJ7TmJ3KXI4aESLy2GNOQ85WB7kICERkuDFx2sYqlg1ETWmn5Iojy24zF9rKvAdSbyCKKS7VSHRILCRJDVQPb1MdCalF9gV1EBTxVPMEtMBbxYToJpHEKxmyf24/DlQLjdmK/DI5H0ggm2OALAVR+xPh2WY1FV482nfUJtam/8/GW5w6Gw8aFKrDaS/UzBzVjVZrel3BGuS8tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=zytor.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wcq5krF/Q9hEi1ogpoJRGe5osH5temXaEr+QbDdY208=;
 b=rcq0W2CenzZa3WtAcOaMLFczvDQtPYSW5ADqsBoww2R5/SwQbbfoqlMqUHJeEy0Cb3UqLX5b9QbWq+FXkX7T+RF7WjLdrXqYuZq19s6VdFHqJrnSxnJUeJfgrDe7leSHhXIAeWuGjdFmA6DZVEAtv71qoIjNK6umX9RGh9vX7e8=
Received: from CH5P223CA0015.NAMP223.PROD.OUTLOOK.COM (2603:10b6:610:1f3::15)
 by SAAPR12MB042067.namprd12.prod.outlook.com (2603:10b6:802:300::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Thu, 15 Oct
 2026 06:48:31 +0000
Received: from DS8PEPF000000E0.namprd05.prod.outlook.com
 (2603:10b6:610:1f3:cafe::a1) by CH5P223CA0015.outlook.office365.com
 (2603:10b6:610:1f3::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Thu,
 15 Oct 2026 06:48:31 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS8PEPF000000E0.mail.protection.outlook.com (10.167.23.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Thu, 15 Oct 2026 06:48:31 +0000
Received: from BLR-L1-SARUNKOD.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 15 Oct
 2026 01:48:15 -0500
From: Sairaj Kodilkar <sarunkod@amd.com>
To: "H. Peter Anvin" <hpa@zytor.com>, "Joerg Roedel (AMD)" <joro@8bytes.org>,
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>, Andrew Morton
	<akpm@linux-foundation.org>, Borislav Petkov <bp@alien8.de>, Dapeng Mi
	<dapeng1.mi@linux.intel.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	Ethan Nelson-Moore <enelsonmoore@gmail.com>, Ingo Molnar <mingo@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>, Jeff Layton <jlayton@kernel.org>, "Jonathan
 Corbet" <corbet@lwn.net>, Kiryl Shutsemau <kas@kernel.org>, Li RongQing
	<lirongqing@baidu.com>, Marco Elver <elver@google.com>, Paolo Bonzini
	<pbonzini@redhat.com>, Randy Dunlap <rdunlap@infradead.org>, Rick Edgecombe
	<rick.p.edgecombe@intel.com>, Robin Murphy <robin.murphy@arm.com>, "Sairaj
 Kodilkar" <sarunkod@amd.com>, Sean Christopherson <seanjc@google.com>, "Shuah
 Khan" <skhan@linuxfoundation.org>, Suravee Suthikulpanit
	<suravee.suthikulpanit@amd.com>, Thomas Gleixner <tglx@kernel.org>, "Vasant
 Hegde" <vasant.hegde@amd.com>, Will Deacon <will@kernel.org>,
	<iommu@lists.linux.dev>, <kvm@vger.kernel.org>, <linux-coco@lists.linux.dev>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>, <x86@kernel.org>
Subject: [PATCH v5 4/7] iommu/amd: Program guest-mode IRTEs for GAPPI wakeup when IRTE[IsRun] = 0
Date: Thu, 15 Oct 2026 12:15:12 +0530
Message-ID: <20261015064515.10700-5-sarunkod@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261015064515.10700-1-sarunkod@amd.com>
References: <20261015064515.10700-1-sarunkod@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS8PEPF000000E0:EE_|SAAPR12MB042067:EE_
X-MS-Office365-Filtering-Correlation-Id: ac5ae833-34de-47eb-8044-08df2a885343
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|376014|7416014|1800799024|23010399003|261009223027099003|10067099003|11063799006|56012099006|22082099003|18002099003|13003099007|921020;
X-Microsoft-Antispam-Message-Info:
	qBfGf4FstTnxycjhOekTaRxOiU9MLzXK2vLNMNZjCw+eJvY6y1fE9lmObgUlG8zh/txYCg5XHmzpmFqJRFpPioDh3QrObWjiOJ1r4y7ElU0BpKsjNkoib/ul1ZweEYnrgfQR5gvs9bZvgTG+mrx4z3BpsPs8HK6pMKMgqBe/5Kr7J9rd6SGU6vb9qS/0u0sj71YSRi239nQYo/ICfVqCRGbJ6cMDhvWzCcxv02cgsS9EEEpiUsICvKSwxqjkLsNfMMoIFDP7o2YbjERsX8Rzm0JarxO1JrK6LiTrveXOa8ueNMaZpuJVt9khJJctWuqUbb49xm7ctYaHvZXIPQzzXIATPedGnHV/G1CUE8c8OlPUMH25zB5DKrPcF+4RjeAvoSWgW8igU6Vprnv6wgymJK1SV/kqIBKm9yg2hZVv8m9XcXZeGfd9dHS7ijJSYKnXB98thI3SGSnu+kASuyG5/wAolo6W8X965O26i/7ABGspC+jeaLwABOeS8dzJhQe4to7mm6FOFyndegwhtIpeQX7oTAuPol/MPgQcFsE+pXT9xYYFKWwR1uxVIis9iCGA3yky2livgrrA2pvtKeJq/OZjFGlI0wqXLEb6+T/rz9fwKa7mqCjk705VbAar02d87QmXH5FdCv2QF+9cIqARxUNEawDRr9Lp+JcGVteirtfop0UzhRW6UUdMeLk4azVXjKZS/dOcm5Vq6GlXd9zsXDiWoRVLX+xkqBtXZZc6kPNkzNaY9Pk1QMy8WzzUzLlB
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(376014)(7416014)(1800799024)(23010399003)(261009223027099003)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003)(13003099007)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	kjCL61lFC9OT3T7x//9tiSokRPK08PCJWBP+6f1m6ikA0hrC2R9YEkqXV7dCnCo0bpPJ982TM0VHaIe4kN6DAiFQt3sIsJ0b8PD3Mus01z8eURrDPh8YIwsnn5u19LwbzqF/5Evuy3yWdI8BmwkBpiDL/Hs5+bX9IjBF7GvVqT9hn2u3ncrxXMIM5RsoUOz5zRv4bdQM/vlKa3iLvWMZYCj/u7Tm5QO8vzsDCAtvU4jGStXxKhkehXVhWbN49bxH/0Yht0slxkgZSUTNHKTGUI83u6hf2RoymYNKl8VU1Z6/tjh0UnT0J9Omyegyl8wVG70VLa31lccrcBERUZgqRjA6R+/aZmc5Ie4cS8n6ygDfxHEWySq1+ps+BdiIUHFReNP2VHovHykbpdsaRKQ3GXiCtuq3aVLNvd8ZrEXrnngEIVKaLIaXLS6A5OlwOAzm
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 06:48:31.0009
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ac5ae833-34de-47eb-8044-08df2a885343
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS8PEPF000000E0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SAAPR12MB042067

Guest APIC Physical Processor Interrupt (GAPPI) is an alternative to the
GA log for notifying the host when a device interrupt targets a
non-running vCPU (IRTE[IsRun] = 0). Per the AMD IOMMU specification [1]
(section 2.2.5.4), with GAPPI enabled the IOMMU delivers a physical APIC
interrupt to the CPU described by IRTE[Destination], using
IRTE[GATag][7:0] as the vector, while still updating the guest vAPIC
backing page IRR as usual.

The AMD IOMMU also allows suppressing GAPPI interrupts using the
IRTE[GAPPIDis] bit when the GAPPIDisSup feature is available in
extended feature register 2. The AMD IOMMU driver sets this bit when
the wakeup_intr flag is not set by KVM.

Note: amd_iommu_gappi is currently false; a later patch enables it via
the kernel command line.

[1] https://docs.amd.com/v/u/en-US/48882_3.11_IOMMU_PUB

Signed-off-by: Sairaj Kodilkar <sarunkod@amd.com>
Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/amd_iommu_types.h |  4 +++-
 drivers/iommu/amd/init.c            |  3 +++
 drivers/iommu/amd/iommu.c           | 30 +++++++++++++++++++----------
 include/linux/amd-iommu.h           |  6 ++++++
 4 files changed, 32 insertions(+), 11 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 8241ef922519..b89a2b3df0a4 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -97,6 +97,7 @@
 /* Extended Feature 2 Bits */
 #define FEATURE_SEVSNPIO_SUP	BIT_ULL(1)
 #define FEATURE_GCR3TRPMODE	BIT_ULL(3)
+#define FEATURE_GAPPIDISSUP	BIT_ULL(4)
 #define FEATURE_SNPAVICSUP	GENMASK_ULL(7, 5)
 #define FEATURE_SNPAVICSUP_GAM(x) \
 	(FIELD_GET(FEATURE_SNPAVICSUP, x) == 0x1)
@@ -982,7 +983,8 @@ union irte_ga_lo {
 		    no_fault	: 1,
 		    /* ------ */
 		    ga_log_intr	: 1,
-		    rsvd1	: 3,
+		    rsvd1	: 2,
+		    gappi_dis	: 1,
 		    is_run	: 1,
 		    /* ------ */
 		    guest_mode	: 1,
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 8a410d4aa370..ef23e0755c32 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -160,6 +160,9 @@ u8 amd_iommu_hpt_vasize;
 /* Guest page table level */
 int amd_iommu_gpt_level = PAGE_MODE_4_LEVEL;
 
+bool amd_iommu_gappi;
+EXPORT_SYMBOL(amd_iommu_gappi);
+
 int amd_iommu_guest_ir = AMD_IOMMU_GUEST_IR_VAPIC;
 static int amd_iommu_xt_mode = IRQ_REMAP_XAPIC_MODE;
 
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index c0eec32ee3cb..7ceb6bf508f0 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -4004,8 +4004,18 @@ static void __amd_iommu_update_ga(struct irte_ga *entry, int apicid,
 		entry->lo.fields_vapic.is_run = true;
 		entry->lo.fields_vapic.ga_log_intr = false;
 	} else {
-		entry->lo.fields_vapic.is_run = false;
-		entry->lo.fields_vapic.ga_log_intr = wakeup_intr;
+		if (amd_iommu_gappi) {
+			entry->lo.fields_vapic.gappi_dis = !wakeup_intr &&
+						check_feature2(FEATURE_GAPPIDISSUP);
+			entry->lo.fields_vapic.is_run = false;
+			entry->lo.fields_vapic.destination =
+						APICID_TO_IRTE_DEST_LO(apicid);
+			entry->hi.fields.destination =
+						APICID_TO_IRTE_DEST_HI(apicid);
+		} else {
+			entry->lo.fields_vapic.is_run = false;
+			entry->lo.fields_vapic.ga_log_intr = wakeup_intr;
+		}
 	}
 }
 
@@ -4016,15 +4026,15 @@ static void __amd_iommu_update_ga(struct irte_ga *entry, int apicid,
  * If the vCPU is scheduled to run on pCPU (@is_running = 1), configure the
  * Destination with the pCPU's APIC ID, set IsRun, and clear GALogIntr. If the
  * vCPU is scheduled out (@is_running = 0), clear IsRun and set/clear GALogIntr
- * based on input from the caller (e.g. KVM only requests wakeup_intr when the
- * vCPU is blocking and requires a notification wake event). This API is
- * intended to be used when a vCPU is scheduled in/out (or stops running for
- * any reason), to do a fast update of IsRun, GALogIntr, and (conditionally)
- * Destination.
+ * and GAPPIDis based on input from the caller (e.g. KVM only requests
+ * wakeup_intr when the vCPU is blocking and requires a notification wake
+ * event). This API is intended to be used when a vCPU is scheduled in/out (or
+ * stops running for any reason), to do a fast update of IsRun, GALogIntr,
+ * GAPPIDis and (conditionally) Destination.
  *
- * Per the IOMMU spec, the Destination, IsRun, and GATag fields are not cached
- * and thus don't require an invalidation to ensure the IOMMU consumes fresh
- * information.
+ * Per the IOMMU spec, the Destination, IsRun, GATag and GAPPIDis fields are
+ * not cached and thus don't require an invalidation to ensure the IOMMU
+ * consumes fresh information.
  */
 int amd_iommu_update_ga(void *data, int apicid, bool wakeup_intr, bool is_running)
 {
diff --git a/include/linux/amd-iommu.h b/include/linux/amd-iommu.h
index a5f1bd6db0ee..de228140ce6e 100644
--- a/include/linux/amd-iommu.h
+++ b/include/linux/amd-iommu.h
@@ -35,6 +35,9 @@ extern int amd_iommu_update_ga(void *data, int apicid, bool wakeup_intr,
 extern int amd_iommu_activate_guest_mode(void *data, int apicid, bool wakeup_intr);
 extern int amd_iommu_deactivate_guest_mode(void *data);
 
+/* IOMMU AVIC Flag */
+extern bool amd_iommu_gappi;
+
 #else /* defined(CONFIG_AMD_IOMMU) && defined(CONFIG_IRQ_REMAP) */
 
 static inline int
@@ -58,6 +61,9 @@ static inline int amd_iommu_deactivate_guest_mode(void *data)
 {
 	return 0;
 }
+
+#define amd_iommu_gappi false
+
 #endif /* defined(CONFIG_AMD_IOMMU) && defined(CONFIG_IRQ_REMAP) */
 
 int amd_iommu_get_num_iommus(void);
-- 
2.34.1

