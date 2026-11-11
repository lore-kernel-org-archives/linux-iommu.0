Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.48.63
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794379510;
	b=uaapLxeClVaimktnkqw42l07usj/XorFIW0+0cJLnLZUMMxuQuHzN0VflbdQjacTTxAW
	 ONuR5qdFmXweypQpSY8pQPBvwCAWBWrOBsTd/lNGDPiuFQTLKkvL1TAM4lbFeWRwS5o7M
	 EX38zCAYaQLDtyA/syujD5DZg47g5n5KO1tkbVvlfvJENrendQ5ctWanGt7EpbM/S92ns
	 /mf7pZWzlDF2OKAVnhGlcr7V8MKY+gy6XAZRqXeBjhC3LgkqEbvg2Y6KqYW/XxbNQuveQ
	 Rs4oUz2bM/RWww/UvPTmQXFuuMa1uObpM9HxGBU2AgVQMHA6MNade+ptu5TewLOx+hA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794379510;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 From:To:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy:X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=ndHbevDTRetvPtz5Mh79OBt4X6ObvmOO51LIyuQz3tI=;
	b=hsuDNwonYTRpICFOgquxU6wHByElW/+oPuwvTCuPFRIUjl/VQ+2i6oQ+FkyA9jYGt/Ax
	 7uAG/bIsT9z1uHYhGd2nB2Cu8rODP/yfYMZZIxuCP0m3bSOqXFjxAgpOcw+DsiHBJwbO7
	 mx95L/wyzpawMGLdxwMjdQI8X2kViV+FL4gSN5vvdcvB8pgnHrGE11XroW9eWlHPRb2rO
	 NsTtLO0mSliReWBL3pYVegbZK7sqVyCVYsw+bhLh7I8icOenaybswRBgHvpYCKycGF3hq
	 rvlCod/t50bAQkxiaMElYa6Avld7yGv6P3ck19YaBjyg326J2PahKWNbZaII23HwBYA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=oLzdJQvl;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.48.63
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012063.outbound.protection.outlook.com [52.101.48.63])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD733606A32E;
	Wed, 11 Nov 2026 06:45:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BD733606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=oLzdJQvl
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fyhzBLXofMMvJ5IFqmwUs17mDY3nmIk01FNdk3fKfrU5NmrMxweM2if4Lj/Z5a0MbzgJW8alFrCflfVmTBTCg2waQ/xgnw1fOuo+Pz9+l1OSkvSgcDyYpJC96tiX5Kn8dYH6Ox6kYeTS4paQqPQOU2e1+6OnrSvNll4N/hOhLV6co2umplW4kYBuUEnqgnFx3g9Vjoh0hMNGidNHtUKmu4v/s1zWTAJY9Zyrz55Ace9JxZp9EMHgymVzwrTz6sDw4RTkcSasdz9j4FHYJt+j6Xt7/05w6MFfH9/1rSYGG5vG61rqt9UMmdI78MJQ7rEOAy8UFodX1ynVsM9i+6+SwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ndHbevDTRetvPtz5Mh79OBt4X6ObvmOO51LIyuQz3tI=;
 b=bF/+23tLL405SvInaSgSIQX/FoK45lQgF1+9ogzsAjJAN+97x+ybYmyouv2cV86ETLjuM01pIyexkCY512P4z3tgfwKtfljl/lF6UZ6Dil6pN5lt0Y20/ibig4Esgo9dbVTABo3lfoBdMIR8KtDfYek6PNGjNvE4/7JmvpE842jZQFOgj7WCMXUBZdh9pH2Oh4fJySj8rX0pcKl8Q5Tns6ldnWYIRLwoygOnajRr3eYfZNxUEPXTjdqLgMu0Sf8VhloB4Su8ijw3Qrjfao3a/XmX5/gl29fHL8lhfRj5/rN9IqP1K9im+FY1nKMT55webDFU0jE2icsmhA3R2m7jBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=zytor.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ndHbevDTRetvPtz5Mh79OBt4X6ObvmOO51LIyuQz3tI=;
 b=oLzdJQvlBkaBeUPKgS7kgo7Ugjnmg9dxZ4p8P8qnkLmQmpOp8ivv66wQboWWuCl3Y4lc/DEJeCr75qfggmPLlXnRgEHD9u5KVAtX8Bvj3QmeZ0wzo5vp/oMJpPq6HdhB+WOmINbuPEIw48KWa5lKaCgk7EKnvnO6NcZUup7rCh4=
Received: from SJ0PR03CA0140.namprd03.prod.outlook.com (2603:10b6:a03:33c::25)
 by SA1PR12MB999227.namprd12.prod.outlook.com (2603:10b6:806:4de::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 06:45:05 +0000
Received: from MW1PEPF0001888E.namprd03.prod.outlook.com
 (2603:10b6:a03:33c:cafe::80) by SJ0PR03CA0140.outlook.office365.com
 (2603:10b6:a03:33c::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.10 via Frontend Transport; Wed,
 11 Nov 2026 06:45:05 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MW1PEPF0001888E.mail.protection.outlook.com (10.167.249.165) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Wed, 11 Nov 2026 06:45:04 +0000
Received: from BLR-L1-SARUNKOD.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 11 Nov
 2026 00:44:54 -0600
From: Sairaj Kodilkar <sarunkod@amd.com>
To: "H. Peter Anvin" <hpa@zytor.com>, "Joerg Roedel (AMD)" <joro@8bytes.org>,
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Borislav Petkov <bp@alien8.de>, Dapeng Mi <dapeng1.mi@linux.intel.com>, "Dave
 Hansen" <dave.hansen@linux.intel.com>, Ethan Nelson-Moore
	<enelsonmoore@gmail.com>, Ingo Molnar <mingo@redhat.com>, Jeff Layton
	<jlayton@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Karl Mehltretter
	<kmehltretter@gmail.com>, Kiryl Shutsemau <kas@kernel.org>, Marco Elver
	<elver@google.com>, Paolo Bonzini <pbonzini@redhat.com>, Randy Dunlap
	<rdunlap@infradead.org>, Rick Edgecombe <rick.p.edgecombe@intel.com>, "Robin
 Murphy" <robin.murphy@arm.com>, Sairaj Kodilkar <sarunkod@amd.com>, "Sean
 Christopherson" <seanjc@google.com>, Shuah Khan <skhan@linuxfoundation.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, Thomas Gleixner
	<tglx@kernel.org>, Vasant Hegde <vasant.hegde@amd.com>, Will Deacon
	<will@kernel.org>, <iommu@lists.linux.dev>, <kvm@vger.kernel.org>,
	<linux-coco@lists.linux.dev>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <x86@kernel.org>
Subject: [PATCH v7 4/7] iommu/amd: Program guest-mode IRTEs for GAPPI wakeup when IRTE[IsRun] = 0
Date: Wed, 11 Nov 2026 12:12:39 +0530
Message-ID: <20261111064242.29336-5-sarunkod@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261111064242.29336-1-sarunkod@amd.com>
References: <20261111064242.29336-1-sarunkod@amd.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW1PEPF0001888E:EE_|SA1PR12MB999227:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d3f3ccb-be75-41bb-2a27-08df3fbf519a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|376014|36860700016|7416014|82310400026|13003099007|261009223027099003|10067099003|261028144727099003|261102130727099003|261102123227099003|261026140227099003|261026121527099003|261021123027099003|261021121427099003|261022075727099003|261022105027099003|11063799006|56012099006|921020|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	XhPdeV2Kj/x4U0k0X0mCrkDS3JlxzyE+VQ559UdfTRnLTfS0JT5380Cp9f85TXh0xkDsMF4fRoQ4pKUqCrHJ/XTaLGidrstK45ws1K/MQlWo6uEhSP3WM3iSQMU9GHxs0+nLZga5SZVsVyf3yxi3MDxjvpwkGYGSfrQlm/ZhYa/xwzXHp2hJW6afHBCPPIP0hyqMRpFpELgmPnuBBpRzkMANsQwfiGHelvti+5f1ksYADUNkb5y2hDsTNSUJR3Xv3F0kvoSkKK/5ezXyOu5WVrdhAfouVLxCAYARCBcoL213SpiCJ3wZ4fL0c8/WwWWGbk2eOGsXlg0gfDFMBYGM3nK/CE/uepEP8CL+gm+oVRbbSBNNlZBJVWj06BGzXP/cVVe/PiU9bZdXKSGNnOoeI4e9GUoScEsFYd5nyaexk5RixjTOqWhG0owXVLxIaFWbRrEP46IzB3XkeJhrZZzqhmTA6ohLerJdmpcU2s8nfMzW3XJkTYCwq9123DEceWD83WbdBOfke4Kq2RVHEE9xXwdEVmPK0hirssfpvIgMK9TRQaeYyhongHQXQYxATz0qc+/FslTmUh+ebSyBUZ+rNL5VWkN1yu2FC4gFhoy6f2qgDzjRRd7KSKkiO8PNULC/Eb74Ud5tsgpaQQNJ57UbrxIEyYbBdMDVRDv59DzSvb1VGBffskLZ8kkfy/1iXqMVZXQP/RuVVJpaDoSyC4GEPPjfw3qpxQKNNP8ytdstEvFoK8eDAOYKJ45weQMX8AZf
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(36860700016)(7416014)(82310400026)(13003099007)(261009223027099003)(10067099003)(261028144727099003)(261102130727099003)(261102123227099003)(261026140227099003)(261026121527099003)(261021123027099003)(261021121427099003)(261022075727099003)(261022105027099003)(11063799006)(56012099006)(921020)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	upayt7Ar23NbrP2suvr6Q2Mp3wYlwXiTOwVQxT+7IG3b5wixa9rxbpNt1C0jfkIiOx5LVfOkcUUAVcpt5tsmyd0Xo5F/bybU3kTs525FhF3bMbY46qN7NTGNmEBpsbwkVJnJ5nK0kr+Davl76anUYYQt9PAxw615SQLzJ5OY42+W/q+34EZNQcX/7C4oMXz8iELOt/Wd3nL3wPUu0g2LSX6CxFxvyFVg35Z3tbNFGyCUKtG4r8Gk6R/Qfd+l7t9La6BhJigqUTXEC7IN00ZOAzoVq3ZpSlhmTMCWLayYQgbBnM8YemoNQ12XwD9Q3wCws5CIjWoCLdWMo6kpRIC414oZy214Y9h2ZwqFjPSIMd8tU0FQ1L70AiMf3KQPBCVQalhDahD4p8W4q0nCSBdMvMfy+cNVc4aOVn+3UxwT7rKTfwc8XEGtkWdC+k3eNrno
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 06:45:04.8910
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d3f3ccb-be75-41bb-2a27-08df3fbf519a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MW1PEPF0001888E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB999227

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
 drivers/iommu/amd/init.c            |  5 +++++
 drivers/iommu/amd/iommu.c           | 31 +++++++++++++++++++----------
 include/linux/amd-iommu.h           |  6 ++++++
 4 files changed, 35 insertions(+), 11 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index f98770db0090..4600674baf84 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -100,6 +100,7 @@
 /* Extended Feature 2 Bits */
 #define FEATURE_SEVSNPIO_SUP	BIT_ULL(1)
 #define FEATURE_GCR3TRPMODE	BIT_ULL(3)
+#define FEATURE_GAPPIDISSUP	BIT_ULL(4)
 #define FEATURE_SNPAVICSUP	GENMASK_ULL(7, 5)
 #define FEATURE_SNPAVICSUP_GAM(x) \
 	(FIELD_GET(FEATURE_SNPAVICSUP, x) == 0x1)
@@ -992,7 +993,8 @@ union irte_ga_lo {
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
index 58f63298493b..054ef7262f3c 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -160,6 +160,11 @@ u8 amd_iommu_hpt_vasize;
 /* Guest page table level */
 int amd_iommu_gpt_level = PAGE_MODE_4_LEVEL;
 
+#ifdef CONFIG_IRQ_REMAP
+bool amd_iommu_gappi;
+EXPORT_SYMBOL(amd_iommu_gappi);
+#endif
+
 int amd_iommu_guest_ir = AMD_IOMMU_GUEST_IR_VAPIC;
 static int amd_iommu_xt_mode = IRQ_REMAP_XAPIC_MODE;
 
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index c00a85b3a090..3557d6e0d65c 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -4063,9 +4063,20 @@ static void __amd_iommu_update_ga(struct irte_ga *entry, int apicid,
 					APICID_TO_IRTE_DEST_HI(apicid);
 		entry->lo.fields_vapic.is_run = true;
 		entry->lo.fields_vapic.ga_log_intr = false;
+		entry->lo.fields_vapic.gappi_dis = false;
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
 
@@ -4076,15 +4087,15 @@ static void __amd_iommu_update_ga(struct irte_ga *entry, int apicid,
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
index 2b340f0f5b31..14be1322b7b6 100644
--- a/include/linux/amd-iommu.h
+++ b/include/linux/amd-iommu.h
@@ -35,6 +35,9 @@ extern int amd_iommu_update_ga(void *data, int apicid, bool wakeup_intr,
 extern int amd_iommu_activate_guest_mode(void *data, int apicid);
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

