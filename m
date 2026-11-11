Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.195.5
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794379580;
	b=Wv32kggyEMnYHXcI9xMX9uc0Yqr8iFIdg2wItSTxa6gIiS5DVptuqHXNEowkC5DBqvLH
	 bUO3kdTehLiH8ZKjGefZo1Wb/ugBpwnI7x4hKbdPlzwU6/XIJY2wcTUm6FsUvp1bce4af
	 Z1AE+Pch8u5H6niq6nAfjYCfmbaCc/B4YyF4CXohp1TGCjVe1vPKK5LSRy/HckWvgEU4U
	 koBMt1fIMm/nMT+4wv5/LPocd+BBL349iUdbmvwpe+hvczoNPUeTiZBLyax3EMos2QPl9
	 Iim8pF4lS3fq/cAjdyVBtZH4UiXo8uxidWD8YIgIOB81dLgPR+1zdcFhNHcdxcMxGDA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794379580;
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
	bh=iDHNbTfN8fe4cWobWA9wi32IMexnI2+d8shnispRp/I=;
	b=BFdynJbDI0fBPed8YNTfBTxq3hzUn3ATAzas/lbt+WX2XRLGe86/Ia4FN4nr3RwqF2Gw
	 N91KUAMQr3Z+LX4sXOMfeHidK3+AJOs9b9e5/gWa8hOBzd4Bv+roozn7RXen3USCpUMLg
	 wZFFr6TINoxsxNgOBZoijC4ByAu+7EFWTVJ4ZKsLRgk1nX+TgzjiV1WgPpD0VZ9PAPA5N
	 k9hgB8keHEqplV61v7A6zwsTVGVm+V63liZvFkh4XOIWmtBMbw+e3FH0H8CZhS0UEt3Vp
	 GjSX5MTQc93PjlLD5GgEzBCbHxSOmyHu3gGZLwqztMl+3hxx+uFFyjk5AZh4I20zPPQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=T6iiQkpa;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.195.5
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012005.outbound.protection.outlook.com [40.93.195.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12691606A32D;
	Wed, 11 Nov 2026 06:46:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 12691606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=T6iiQkpa
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oI2GiSJZ+HNbtGhztJGsYyT2mOPUAU8b9RW1Lj3fItRy1VgYzhpsz8efZlE2Vio4MXRcxlorRrravQxB/MlwUTTlYW1Q3kr832FzwxuOyYBrxEiF+TLpbIUg8LFi3eUGJbrde/9nXYreCQ4GI/4Rva5LKaXkerbBJtfHApYpjBvjlfI2rn4RRLVUXZuObXLefkHkFQUQfnUH/JmNS8WV1lf/Jy3gXEYsCwAhp5tMtn1iJ2CXeAjjScwXrQ2q72pZQTbGReVzv8FWQpktjPI0rqjDmTXbCHnyP/lDeP0Rfpk/gnqe+9nL7xgjYAl9Aqnb/Ja8PYLxksVeAi/VuZiMJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iDHNbTfN8fe4cWobWA9wi32IMexnI2+d8shnispRp/I=;
 b=kIkn+A76i1bqGU4tTWZQi3KrYRrZnvm4fqZz4c4waC2RHTaonpDPfHgH3CvibqD1q2rp288b2nfRHrcNGMdWuPnneI5dSC0+qcN4i9jg7lsVZjeuWS6bYn2RRw03XQz0P4NbuKTjVdqwxg2PHkBtu8Dq+vFKzGYOFFgn45JCNST/11MyNiL+yo8ccDMXXl/UvX9KD1e3PBf8QNlmz+al3wbVQH21fffXLDKXtJQQoGArS0ZZzcV0HuD+qAPf2lio2X1I3vMkxeXlf0XxgvgThXu/mrXev+F4bis2QBW1Jl89TIHpZ789/+iVTG7XeYGP6g3I3m6k6K8Qx7Ig+MCVUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=zytor.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iDHNbTfN8fe4cWobWA9wi32IMexnI2+d8shnispRp/I=;
 b=T6iiQkpanC2Kr/vazjGs7XWpXElfVz6VMsFUMpV/msw9pyj+YzRnIFwHXnyDaKB+ZT4kyFouH4b6+X+jHCbGYrijesKUYDzo5btlkjJ63pt2SvFNB/0RR5vkDmlSq8b1D1EXtQZd8BvSYZ2YqoU3zJNXQ3zoshcltK2F97LcrSs=
Received: from SJ0PR05CA0174.namprd05.prod.outlook.com (2603:10b6:a03:339::29)
 by CH8PR12MB9744.namprd12.prod.outlook.com (2603:10b6:610:27a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Wed, 11 Nov
 2026 06:46:14 +0000
Received: from MW1PEPF00018894.namprd03.prod.outlook.com
 (2603:10b6:a03:339:cafe::27) by SJ0PR05CA0174.outlook.office365.com
 (2603:10b6:a03:339::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.8 via Frontend Transport; Wed, 11
 Nov 2026 06:46:13 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MW1PEPF00018894.mail.protection.outlook.com (10.167.249.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Wed, 11 Nov 2026 06:46:13 +0000
Received: from BLR-L1-SARUNKOD.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 11 Nov
 2026 00:46:00 -0600
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
Subject: [PATCH v7 7/7] iommu/amd: Provide kernel command line option to enable GAPPI
Date: Wed, 11 Nov 2026 12:12:42 +0530
Message-ID: <20261111064242.29336-8-sarunkod@amd.com>
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
X-MS-TrafficTypeDiagnostic: MW1PEPF00018894:EE_|CH8PR12MB9744:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e59ca2e-2b1a-40ca-eb96-08df3fbf7a7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|36860700016|82310400026|23010399003|921020|261009223027099003|261026121527099003|11063799006|56012099006|261028144727099003|261021121427099003|261021123027099003|261022075727099003|10067099003|261026140227099003|261022105027099003|261102123227099003|22082099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	hIkLur5YuPPiZlp5Hrcz3jPH0GZxJEldBO99+9k2x91DOp8nsOMH1PYOsmVKMSKOom6BHrmJen9kF/OJtNgeyVrbPQflJk8jaOtTPCfyW/PuCqj96eh4u9iwZF2qen7BtaL/dMsF+BtidnNA8i9L7SzUelM1+OJeYru5jFUdII1vhBPKORFcU7+UV3Y4HE6OLx+zqqAPcpavqcRjeKGUqUPqFVHt18xKYbHNvqOWjxLGkEzHp43GxuWSjHxw9JrPVN7McMBSP64S9HFHuDnMUgsTTu7aOxbYphgL9izkccGYb8w4ZmgftpbjEH0BWM6wQl6BDDZr7RlVE+MjkBTMQelrynsB1NxK3Od9gqV3mVbLcheAKuHtIf43c7CYbICIphbW6fUA3vSutWA0dEbuu+6DskRirvBCzU6gjL9jrenr5bO9oqcMiOBtmiyLhIDj9kjgu4pphUibn16cgeEW9Q6p55kRvzf16tDtIF9g/GYsLd8W5P7ZwdYGIE7g3GhmgqDTphJM/EGbrZsUCoQ89ZrgPGeWmPVqNh+o5o7O4pPagBnh8OqV+RjMJqqeB5SiLhW3kZ9dtPR4gNOk3cBYObWJPJSUmsWqJ9nc23m21Dt/3SFzaIb6a8uSE6Uv/xBUJrfhVVA8976iyqf7x10DgmgjSq6oDZCpluRxwscm0BDsaCBAQtxCg1179kvTh1+O1V86kJe0QyZqahSudvqYPbMm4Azh7b290UHoPccPhcaYn6hdIc2aswWEkB9iXogD
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(36860700016)(82310400026)(23010399003)(921020)(261009223027099003)(261026121527099003)(11063799006)(56012099006)(261028144727099003)(261021121427099003)(261021123027099003)(261022075727099003)(10067099003)(261026140227099003)(261022105027099003)(261102123227099003)(22082099003)(18002099003)(6133799003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Mb+lFa7Pp3CW1DUDGgaZXuAGiJrNmU5znRQ5a+TX+7WRXKG1ZSkjNGci0ouwjjZqdtvqMMqDuOKJgNNlNWlThEXMG1zUaDNbuPnTFVmFPhm7BhuIP5hpHQ9nyfkd/b6Yr58UX6HENcri0r4Ed/9N+jPxADbfZoUcLlP3wDbhgqdf0X7XQ4l/6qIODCKdedh7XBwnR+6uc5rVZMmnECTtM0YJA6NL5SZ0ZeSsLHJmg7RGFH/4EV4xvu9vC1wkk4gJ7API0n8TXnpg+kN69ypdFCAa+E9e9VYXTDuEuw/FLW8Kdu5D8Ki74eHDSqxx4g43UXU+VRjEn3Nw0gci7U0azRBLeHcfEMO/HaJ0jILW3C0+8PIik37AX3AJHHVCR89zvCtpYvmgLDtameZegYpFeSMYciaTI0eBCcHE0ZJEYJcTwiYErj6aszwdxa/Q96r7
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 06:46:13.4798
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e59ca2e-2b1a-40ca-eb96-08df3fbf7a7b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MW1PEPF00018894.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR12MB9744

Enable GAPPI when the IOMMU GAPPISup extended feature bit is set and
the kernel is booted with the amd_iommu=gappi kernel parameter.

Document the option in Documentation/admin-guide/kernel-parameters.txt
and mechanism in Documentation/arch/x86/iommu.rst.

Co-developed-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Sairaj Kodilkar <sarunkod@amd.com>
---
 .../admin-guide/kernel-parameters.txt         |  3 +-
 Documentation/arch/x86/iommu.rst              | 22 +++++++++++++
 drivers/iommu/amd/amd_iommu_types.h           |  2 ++
 drivers/iommu/amd/init.c                      | 33 ++++++++++++++++---
 4 files changed, 55 insertions(+), 5 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 0b3c140babd9..54c01621fc92 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -456,7 +456,8 @@ Kernel parameters
 				          to 4 KiB.
 			v2_pgsizes_only - Limit page-sizes used for v1 page-tables
 				          to 4KiB/2Mib/1GiB.
-
+			gappi           - Use GAPPI instead of GALOG for vCPU
+				          wakeup notification.
 
 	amd_iommu_dump=	[HW,X86-64]
 			Enable AMD IOMMU driver option to dump the ACPI table
diff --git a/Documentation/arch/x86/iommu.rst b/Documentation/arch/x86/iommu.rst
index 79c33560299b..6bac30f5abbd 100644
--- a/Documentation/arch/x86/iommu.rst
+++ b/Documentation/arch/x86/iommu.rst
@@ -150,3 +150,25 @@ AMD Fault reporting
 
 	AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0007 address=0xffffc02000 flags=0x0000]
 	AMD-Vi: Event logged [IO_PAGE_FAULT device=07:00.0 domain=0x0007 address=0xffffc02000 flags=0x0000]
+
+
+AMD vCPU wakeup Mechanism
+--------------------------
+
+GALOG
+^^^^^
+
+GALOG is a legacy notification path to wakeup the vCPU waiting on an interrupt.
+When IOMMU receives an interrupt destined to vCPU which is scheduled out, it
+updates the vAPIC backing page IRR and appends vCPU tags to a shared GA log
+buffer and raises a single GA log interrupt. IOMMU driver scans this buffer to
+decide which vCPU to wakeup.
+
+GAPPI
+^^^^^
+
+GAPPI is an alternative to GALOG.  With GAPPI enabled, the IOMMU still updates
+the guest vAPIC backing page IRR, but may deliver a physical APIC interrupt
+directly to IRTE[Destination], using IRTE[GATag][7:0] as the vector. This
+distributes host wakeup notifications across CPUs instead of centralizing them
+in a log buffer. This can be enabled by adding option amd_iommu=gappi
diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 4600674baf84..47c7e7d28df4 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -79,6 +79,7 @@
 #define FEATURE_X2APIC		BIT_ULL(2)
 #define FEATURE_NX		BIT_ULL(3)
 #define FEATURE_GT		BIT_ULL(4)
+#define FEATURE_GAPPI		BIT_ULL(5)
 #define FEATURE_IA		BIT_ULL(6)
 #define FEATURE_GA		BIT_ULL(7)
 #define FEATURE_HE		BIT_ULL(8)
@@ -181,6 +182,7 @@
 #define CONTROL_EPH_EN		45
 #define CONTROL_XT_EN		50
 #define CONTROL_INTCAPXT_EN	51
+#define CONTROL_GAPPI_EN	55
 #define CONTROL_GCR3TRPMODE	58
 #define CONTROL_IRTCACHEDIS	59
 #define CONTROL_SNPAVIC_EN	61
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 054ef7262f3c..6a248327047a 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -486,6 +486,9 @@ static void iommu_disable(struct amd_iommu *iommu)
 	iommu_feature_disable(iommu, CONTROL_GALOG_EN);
 	iommu_feature_disable(iommu, CONTROL_GAINT_EN);
 
+	/* Disable IOMMU GAPPI */
+	iommu_feature_disable(iommu, CONTROL_GAPPI_EN);
+
 	/* Disable IOMMU PPR logging */
 	iommu_feature_disable(iommu, CONTROL_PPRLOG_EN);
 	iommu_feature_disable(iommu, CONTROL_PPRINT_EN);
@@ -2376,7 +2379,7 @@ static void print_iommu_info(void)
 {
 	int i;
 	static const char * const feat_str[] = {
-		"PreF", "PPR", "X2APIC", "NX", "GT", "[5]",
+		"PreF", "PPR", "X2APIC", "NX", "GT", "GAPPI",
 		"IA", "GA", "HE", "PC"
 	};
 
@@ -3102,6 +3105,13 @@ static void enable_iommus_vapic(void)
 	struct amd_iommu *iommu;
 
 	for_each_iommu(iommu) {
+		/*
+		 * Disable GAPPI, do not check amd_iommu_gappi as it may be
+		 * false in new kexec kernel even though previous kernel has
+		 * enabled it.
+		 */
+		iommu_feature_disable(iommu, CONTROL_GAPPI_EN);
+
 		/*
 		 * Disable GALog if already running. It could have been enabled
 		 * in the previous boot before kdump.
@@ -3131,18 +3141,27 @@ static void enable_iommus_vapic(void)
 	if (!AMD_IOMMU_GUEST_IR_VAPIC(amd_iommu_guest_ir))
 		return;
 
+	if (amd_iommu_gappi &&
+	    !(check_feature(FEATURE_GAPPI) &&
+	      AMD_IOMMU_GUEST_IR_VAPIC(amd_iommu_guest_ir))) {
+		pr_warn("GAPPI is not supported.\n");
+		amd_iommu_gappi = false;
+	}
+
 	/* Enabling GAM and SNPAVIC support */
 	for_each_iommu(iommu) {
-		if (!iommu_ga_log_enable(iommu))
+		if (amd_iommu_gappi)
+			iommu_feature_enable(iommu, CONTROL_GAPPI_EN);
+		else if (!iommu_ga_log_enable(iommu))
 			return;
-
 		iommu_feature_enable(iommu, CONTROL_GAM_EN);
 		if (amd_iommu_snp_en)
 			iommu_feature_enable(iommu, CONTROL_SNPAVIC_EN);
 	}
 
 	amd_iommu_irq_ops.capability |= (1 << IRQ_POSTING_CAP);
-	pr_info("Virtual APIC enabled\n");
+	pr_info("Virtual APIC enabled with %s\n",
+		amd_iommu_gappi ? "GAPPI" : "GALOG");
 #endif
 }
 
@@ -3893,6 +3912,12 @@ static int __init parse_amd_iommu_options(char *str)
 		} else if (strncmp(str, "v2_pgsizes_only", 15) == 0) {
 			pr_info("Restricting V1 page-sizes to 4KiB/2MiB/1GiB");
 			amd_iommu_pgsize_bitmap = AMD_IOMMU_PGSIZES_V2;
+		} else if (strncmp(str, "gappi", 5) == 0) {
+#ifdef CONFIG_IRQ_REMAP
+			amd_iommu_gappi = true;
+#else
+			pr_warn("amd_iommu=gappi ignored, IRQ remapping is not enabled\n");
+#endif
 		} else {
 			pr_notice("Unknown option - '%s'\n", str);
 		}
-- 
2.34.1

