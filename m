Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010024.outbound.protection.outlook.com [40.93.198.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 284FA35AC34
	for <iommu@lists.linux.dev>; Mon,  5 Oct 2026 06:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791182488; cv=fail; b=DsItexTJuxdlb27Jdklgx/blVS99mFR5S1yIzOogp1+DQIvFfRjsul0mx1u0s1p2l7SSmbdOQ/wOKE7bN3qvHPw1S3bcIMQAp+SoLp5SzbtpAHo/2Aa5Xo73rPx60UzENOdeLk5/keCJXD/581C+Wgid4uZIfLMnitCl7m4YJhE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791182488; c=relaxed/simple;
	bh=jUdFhYIOmUIEibIR/tkubq0P+CdRsk11L1eTceKsLBM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JyUgBaJD7B/00+vcks/myecaeLCunua68Zr994RLuzPR9nxSfL1uPsTumSjCVs4/+dO8jrh6DAoGDZV+lYoTHky1ObX2OyDCqIhohTG4gegYdoYGV7LWRIyI+Wh/ZwehKstbJuFk4WOynZEOjzKoh4FJ6cF9twDA8ytYqGY4Rpg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=FNXsmzq9; arc=fail smtp.client-ip=40.93.198.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="FNXsmzq9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l0InNaDCk3pzJ9o5NZcCkHNwpGnGS//BVnnUo0KFpWMNz5vcQrNsnCNIHMy5ckOh7cHcDy5RDS83jzE9CWTN/LNZvgoVWhhI6TA5WkEBUp6nZOzEXSvnnsvO+5ijoHh0vnmgtee3MsuHhf7mH1SPuVotCUYXuVG7C1+fv6QOxXjllZiWXIrkd1Hl0jaqicQCHCp7JGlt7ryWOYZ3fhKrPDOeSVgXLgJ5W3x9/GeMjRi/yJZLhfDpchMC05RodFzfdXJw28yNdG+Ch9H3oEWPUjokT82XBlkETqfSABRR2hJXFEHNKGZojZc7eHTyCU+YBAes7He4xxVz7S6mD/k7vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9tUH1RygVr23BK8GsFjUDbQTutc5H8KcpqzvV162kYI=;
 b=yj+f4RnUCOVuSghPSilajU5q4uqUvnEbaPikGJsB64A4swUwerICuNzeFS4k00yG/O+pjwNzokEox9tfiqbi387TTqwuCKtl0CUAmkq1kGMfUv2Rmh61I10C2LLXGuV4AzOEW5sGTJJcqe0F2QncgZdiVGAkjRTim4n6eATTTGNceo156OTNUHfM+cunUE1w1fF/h4hHGYln+kT/ql3BWLLBaYrvyFtIN4ZJ7qoe6BrkEBrSwSWGSX3FqBdqsg5YpfRcvg0jJR/8jUrr7+MA9YHS6XaPk0RiJBNXysjldOWjnQNn7BSxqG/tft8BLOzdP6eAtOyJua3lGCXj5lTAZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9tUH1RygVr23BK8GsFjUDbQTutc5H8KcpqzvV162kYI=;
 b=FNXsmzq9+Eacw10cjn1OpyIZWdcjPzC14Muwf9Ld+TxyJrb4mlvVmTiFdXKQfh0040sIkWGOXsTogfgRqdbz70HTLugCazdJW4meJW9brBiEseyDVlLhJgjZ7iVhkBbVlucs5FWwmV85tV2DaiAvAuSBCIa4vaGpXciSyNnENds=
Received: from SJ0P220CA0011.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:41b::31)
 by DS5PPF5FAA0E762.namprd12.prod.outlook.com (2603:10b6:f:fc00::651) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Mon, 5 Oct
 2026 06:41:23 +0000
Received: from CO1PEPF00012E60.namprd05.prod.outlook.com
 (2603:10b6:a03:41b:cafe::9f) by SJ0P220CA0011.outlook.office365.com
 (2603:10b6:a03:41b::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Mon, 5
 Oct 2026 06:41:22 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF00012E60.mail.protection.outlook.com (10.167.249.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Mon, 5 Oct 2026 06:41:22 +0000
Received: from BLRANKISONI.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 5 Oct
 2026 01:41:13 -0500
From: Ankit Soni <Ankit.Soni@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>, <will@kernel.org>,
	<jgg@nvidia.com>
CC: <suravee.suthikulpanit@amd.com>, <vasant.hegde@amd.com>,
	<robin.murphy@arm.com>, <joao.m.martins@oracle.com>,
	<alejandro.j.jimenez@oracle.com>, <pasha.tatashin@soleen.com>,
	<rppt@kernel.org>, <pratyush@kernel.org>, <skhawaja@google.com>,
	<praan@google.com>, <baolu.lu@linux.intel.com>, <dwmw2@infradead.org>,
	<kevin.tian@intel.com>, <dmatlack@google.com>, <vipinsh@google.com>,
	<kexec@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH 2/7] liveupdate: parse the incoming handover tree before late_time_init()
Date: Mon, 5 Oct 2026 06:40:12 +0000
Message-ID: <20261005064018.1558-3-Ankit.Soni@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261005064018.1558-1-Ankit.Soni@amd.com>
References: <20261005064018.1558-1-Ankit.Soni@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E60:EE_|DS5PPF5FAA0E762:EE_
X-MS-Office365-Filtering-Correlation-Id: 931b20e1-4b17-4732-a8f5-08df22abab99
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|376014|7416014|82310400026|23010399003|5023799004|11063799006|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	OX7U621EuOx7qUzmbmIFSXhOKo+Ew8vvrNvcoIWJdyD5NNjDDbreRbwNlrX04/2Jzozpeq+R1TaoP6e9fl4Hc/GPg6kf5Dxyu6wwhs+YSAewRMjOshlT1ccMF+e52Q4MdLsnSK/fbzh3E4l9eaNkndDZtv0QJBTIj/+IXEr5lk3HKMEnLyWx0cQq+ogBKo58EaDOiu/15Zw8BwzIVohET8Aj3gib69OuDUlJE4VH4DFb0RYwYw2C3ouo1YR9z5s/PUB1D4mJP9E7L3UJ9auytNJizwyhDIeZbfPXrF5rrw3Lr3lHudpVnV4jQ6KbJl0TE0pI70bWbsyMJ2VpmtpJ7i2fMz4Fbzmo+3InDN5qdz7b7b+eq8zr+C1yvJ4roH7u0jvGh9wR58Inn55ppC239zWVNSAXYcw7If/ivZUqj2AdFac+5jf4bswwxkMW3ItToUn2Aj5FdePUYIwyp4G51E+RGl6tth/11Ei/NVPXCCcIOQin5zcw8hJmMEuZ6kL2uEn2nNZLd2OTpruS/j4naOQBdxn01G8CheIusWOAJYKkfC4TxZ3frD3tn/v9khRfscfjWNlUzNgSe2QQDO7p1UZL14H2xg3rErP5kzme0SQlP3cfDRq6ZWWL5kqRbxlgv5l0e2T4rie+kwLqx33v+hJvw5xZvJYgEUmDD4M7rI+R1u1gg9pXRrGoIoWEcVEjjx9oPejj5CmyCYJSLVMxzg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(376014)(7416014)(82310400026)(23010399003)(5023799004)(11063799006)(56012099006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	1iy0SGkJ2U/xx0RIufpn2kAjTS3KPm6m9oUPWCGCf3tOzcfmLZ12M+lrJZmDy9LjH387dZHZRAtpxpsIHwhFTUlGhN1qIaUVzuRI0bxqCoopkkNgeZ8KTXYGvm7YTG7ay7eV0T7E4TXk80vJ1RW79U3jnBXMSiGsuM9Bh/BD1WsZJVPboa6Rq2eEHxc+vY/EF/C1w+YD07VH1Me79MACc6O1rac9dM25REDXnKqj5uLYYXJsnVqW0O+MIWk7B3r1B+Aj0nEG/0Z9D0tNtk9P+64ykM5lKXf9fhiybhdyqVZcBtyT9SGt+G6f8IUznXtsJWUi6nU7D0vgcQG46FpyOefEF4sZCGhRIKWhxB+Kb0iYJudWYBB4Dg4wguCiQ0xot1sMsB+yOFfejnGJr+RZ0G0flfM7fdFCpU7gTvkVgayu0N4JQaCXbDTjBKTS2C/L
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2026 06:41:22.2268
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 931b20e1-4b17-4732-a8f5-08df22abab99
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF00012E60.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPF5FAA0E762

LUO parses the handover tree from an early_initcall, which runs inside
rest_init() -- the last statement of start_kernel(). Anything earlier in
start_kernel() cannot see the incoming state, and cannot tell that it
cannot see it: luo_flb_retrieve_one() returns -ENODATA both before the
parse and when the previous kernel handed nothing over.

On x86 the IOMMU is such a consumer, because it is also the interrupt
remapping provider. amd_iommu_prepare() runs from late_time_init() via
enable_IR_x2apic() -> irq_remapping_prepare(), and reaches
init_iommu_one_late() long before any initcall.

Fix the ordering rather than teaching each consumer to cope. Call the
parse directly from start_kernel(), immediately before late_time_init().
Rename it to liveupdate_init_early() at the same time, since
liveupdate_early_init() was named after the early_initcall that no longer
exists.

Signed-off-by: Ankit Soni <Ankit.Soni@amd.com>
---
 include/linux/liveupdate.h   | 4 ++++
 init/main.c                  | 2 ++
 kernel/liveupdate/luo_core.c | 5 +----
 3 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/include/linux/liveupdate.h b/include/linux/liveupdate.h
index 6051abc0612c..07dbe8366f76 100644
--- a/include/linux/liveupdate.h
+++ b/include/linux/liveupdate.h
@@ -229,6 +229,8 @@ struct liveupdate_flb {
 
 #ifdef CONFIG_LIVEUPDATE
 
+void liveupdate_init_early(void);
+
 /* Return true if live update orchestrator is enabled */
 bool liveupdate_enabled(void);
 
@@ -259,6 +261,8 @@ int liveupdate_get_token_outgoing(struct liveupdate_session *s,
 
 #else /* CONFIG_LIVEUPDATE */
 
+static inline void liveupdate_init_early(void) { }
+
 static inline bool liveupdate_enabled(void)
 {
 	return false;
diff --git a/init/main.c b/init/main.c
index 2613d3f9b3ce..221c22489c04 100644
--- a/init/main.c
+++ b/init/main.c
@@ -108,6 +108,7 @@
 #include <linux/time_namespace.h>
 #include <linux/unaligned.h>
 #include <linux/vdso_datastore.h>
+#include <linux/liveupdate.h>
 #include <net/net_namespace.h>
 
 #include <asm/io.h>
@@ -1145,6 +1146,7 @@ void start_kernel(void)
 	setup_per_cpu_pageset();
 	numa_policy_init();
 	acpi_early_init();
+	liveupdate_init_early();
 	if (late_time_init)
 		late_time_init();
 	sched_clock_init();
diff --git a/kernel/liveupdate/luo_core.c b/kernel/liveupdate/luo_core.c
index 91703715e993..54771d67d922 100644
--- a/kernel/liveupdate/luo_core.c
+++ b/kernel/liveupdate/luo_core.c
@@ -135,7 +135,7 @@ static int __init luo_early_startup(void)
 	return err;
 }
 
-static int __init liveupdate_early_init(void)
+void __init liveupdate_init_early(void)
 {
 	int err;
 
@@ -145,10 +145,7 @@ static int __init liveupdate_early_init(void)
 		luo_restore_fail("The incoming tree failed to initialize properly [%pe], disabling live update\n",
 				 ERR_PTR(err));
 	}
-
-	return err;
 }
-early_initcall(liveupdate_early_init);
 
 /* Called during boot to create outgoing LUO state */
 static int __init luo_state_setup(void)
-- 
2.43.0

