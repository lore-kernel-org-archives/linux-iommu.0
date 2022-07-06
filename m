Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0A4433C6
	for <iommu@lists.linux.dev>; Wed,  6 Jul 2022 11:50:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JAL2wXRidFPFB5Xek/GxdcLCSGIifxbYX0+8mDYBwpcmyU7h+zxNwyvGc/BFf8Rvu9M3XpHD2H3VbdZOGasFua/mLv7jXegalpSve9f8/ZvffYD7J6ZJucEsFNQ/W/65kkYACtJSzUzprsZyq3NT0oKbVd55jpaGr5mz4HT8mo9V7WW5ptV7qOZBNOkpf7q62Ktm6Ukh12M4yMVQcSYb0W3a30MFCvMsgEVWr4tl3+tKJKAKn2Og8HZVHJsZVbtr5Z7IZjeEb9uMavryPEv6fxRhORaVYADqPSzEDaP0foz7USlexSMKyEdZoH6mxq4Loju817SZDAulZWycwrPTwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p9l7pfMGEwOGhBcoVligJllp0B4aMs3mlhZxzTG25N0=;
 b=cQXCwW4YL8vS2C2EW+bAbYhwYTkFbdoyKLvD29A12+Z7Bx2XqVqPZgfyl5LAWpILU67BT9vLZq0SGR255BnhLa/dSWFSRYSb88DAvpNkFiBM+fboJpEKACSy5xZLeTlVtmP/FVIuGF4rYn4EtKBSgcQT8lCxJcbN4OlxPWaaOagTqOAS8/hep2AvZCNIIOEV3SjDLUvdrPbgSh7QBV2qON0PhBC8Dx/uFfqnUfMosAnZVA4iFcRedAZszwg85+wvrhPSFxywsLD0Yc4WpkpF/u+alN0FFa63LNC6SBk4jG25KKFd3aK7guGLNCIA75jXN7BISIKJLm3PHByH68qj1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=8bytes.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p9l7pfMGEwOGhBcoVligJllp0B4aMs3mlhZxzTG25N0=;
 b=MlYAtRRzwkFMiZ80HCUxnr/7sJW01XX+3jVFT+/y8pImXYez8YFztnE1C9n1pOiBJyPdUVqKVsFHbp2WjwTUgCX3xYNhj/MKpkz3wLgrMIY19Mfb2D9Qhg8FnIDOe6eoDM0dZaNLwzRVMpRQN/Hg1ND+O5gq1/6whHFOLbUrPiA=
Received: from MWHPR02CA0005.namprd02.prod.outlook.com (2603:10b6:300:4b::15)
 by DM5PR12MB1179.namprd12.prod.outlook.com (2603:10b6:3:6f::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5395.18; Wed, 6 Jul 2022 11:50:36 +0000
Received: from CO1NAM11FT028.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:4b:cafe::d0) by MWHPR02CA0005.outlook.office365.com
 (2603:10b6:300:4b::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.15 via Frontend
 Transport; Wed, 6 Jul 2022 11:50:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT028.mail.protection.outlook.com (10.13.175.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5417.15 via Frontend Transport; Wed, 6 Jul 2022 11:50:36 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 6 Jul
 2022 06:50:32 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <joro@8bytes.org>, <iommu@lists.linux.dev>
CC: <iommu@lists.linux-foundation.org>, <suravee.suthikulpanit@amd.com>,
	Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v3 RESEND 32/35] iommu/amd: Add PCI segment support for ivrs_[ioapic/hpet/acpihid] commands
Date: Wed, 6 Jul 2022 17:08:22 +0530
Message-ID: <20220706113825.25582-33-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220706113825.25582-1-vasant.hegde@amd.com>
References: <20220706113825.25582-1-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 93e46df3-ced2-4df2-e5ac-08da5f45bd74
X-MS-TrafficTypeDiagnostic: DM5PR12MB1179:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	3SB+uy0TWlvJnKgXiHYFQS7YeWIYUhWWgOz4PhCUDFGMQxOCJdiTQMG7K4OsscJYl42KnkCBafNeGL9aMPfyv4VFMM/ESbM8RZ7ThXsMhI9jyGP0ef7ToDlS2S1l+vTmo+/n+UrL84IBH0+ek2T5GT5CyVLLw6bAVZgt5BAMxJTqacQAKs5GEfZFou/gDTKPnK4VMmwx6D2WbI9uzScRf52uVOJuby6LYkoRyvtQACFeEjrPyRjtRHcFhenFs7y7SE8cQeRfxyOufnSRC9kbf6MR4eQ3iTeXjO3yosDSO3CHcBgZ+yi6+4KbIK/XUd8oNH9EPExKBYcfIdBPsodSybGe6MsS4TvncHwDl6Aj98rFVdNpBtqunIYBjC6oiBC3I3FnaQuMzkDzCFkVEIOVddam2UratoRhQTW37WwHq0MzacKjpP2TOApYxaHkUZ11xlztboQani+cuzfu0xcEgm7rSVNctxznvVBSJOFUFCLhO5qgEckgfkR8Xlc6Up8FqJpvJvmWviv86tI7a7in2txrVHoOZwQoJqNQc0tDOz5o+qtKd4JSmvoMM6hEcqWMSeT4vqL7iF2jup0vb05ibQFaYnMT381G4nCGkXOnlIcIP0Dz0Orz4juHaAMlLcnnTwEtzwFXt6ZE4tFq9FSszBco4kXuEK1J60Uv1zmLZMvyslCRI5SSYAqmZk48F2AvfNgorBclaIVOQNtHUUJuiMVQzLIbcNQf3RBiD9HqtiBVTXqIsel3v+6Fg9+ZdWpZcAzFFmNvJanMkP7IIBYMCTrnpxi3blSwz8pwcchb3jVi2IqjvZ0iik2aEmhHD7m+bgYdr5DfLdLLESGJaKoKznNa/waFxFwf2ExIWtzui4ImwQD07vNTQXuioyqTFh1m
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(396003)(376002)(346002)(136003)(46966006)(40470700004)(36840700001)(16526019)(186003)(2616005)(40480700001)(1076003)(426003)(82310400005)(47076005)(336012)(36756003)(316002)(54906003)(8676002)(4326008)(83380400001)(110136005)(70206006)(70586007)(5660300002)(8936002)(86362001)(40460700003)(7696005)(44832011)(478600001)(82740400003)(81166007)(356005)(34020700004)(36860700001)(41300700001)(2906002)(26005)(6666004)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2022 11:50:36.0408
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 93e46df3-ced2-4df2-e5ac-08da5f45bd74
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1NAM11FT028.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1179
Message-ID: <20220706113822.Ls5VboUZjoCH8uTHnnOCybkt8ZnLEwTElnfy0QbzmCE@z>

From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>

By default, PCI segment is zero and can be omitted. To support system
with non-zero PCI segment ID, modify the parsing functions to allow
PCI segment ID.

Co-developed-by: Vasant Hegde <vasant.hegde@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 .../admin-guide/kernel-parameters.txt         | 34 ++++++++++----
 drivers/iommu/amd/init.c                      | 44 ++++++++++++-------
 2 files changed, 52 insertions(+), 26 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 2522b11e593f..d45e58328ce6 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -2266,23 +2266,39 @@
 
 	ivrs_ioapic	[HW,X86-64]
 			Provide an override to the IOAPIC-ID<->DEVICE-ID
-			mapping provided in the IVRS ACPI table. For
-			example, to map IOAPIC-ID decimal 10 to
-			PCI device 00:14.0 write the parameter as:
+			mapping provided in the IVRS ACPI table.
+			By default, PCI segment is 0, and can be omitted.
+			For example:
+			* To map IOAPIC-ID decimal 10 to PCI device 00:14.0
+			  write the parameter as:
 				ivrs_ioapic[10]=00:14.0
+			* To map IOAPIC-ID decimal 10 to PCI segment 0x1 and
+			  PCI device 00:14.0 write the parameter as:
+				ivrs_ioapic[10]=0001:00:14.0
 
 	ivrs_hpet	[HW,X86-64]
 			Provide an override to the HPET-ID<->DEVICE-ID
-			mapping provided in the IVRS ACPI table. For
-			example, to map HPET-ID decimal 0 to
-			PCI device 00:14.0 write the parameter as:
+			mapping provided in the IVRS ACPI table.
+			By default, PCI segment is 0, and can be omitted.
+			For example:
+			* To map HPET-ID decimal 0 to PCI device 00:14.0
+			  write the parameter as:
 				ivrs_hpet[0]=00:14.0
+			* To map HPET-ID decimal 10 to PCI segment 0x1 and
+			  PCI device 00:14.0 write the parameter as:
+				ivrs_ioapic[10]=0001:00:14.0
 
 	ivrs_acpihid	[HW,X86-64]
 			Provide an override to the ACPI-HID:UID<->DEVICE-ID
-			mapping provided in the IVRS ACPI table. For
-			example, to map UART-HID:UID AMD0020:0 to
-			PCI device 00:14.5 write the parameter as:
+			mapping provided in the IVRS ACPI table.
+
+			For example, to map UART-HID:UID AMD0020:0 to
+			PCI segment 0x1 and PCI device ID 00:14.5,
+			write the parameter as:
+				ivrs_acpihid[0001:00:14.5]=AMD0020:0
+
+			By default, PCI segment is 0, and can be omitted.
+			For example, PCI device 00:14.5 write the parameter as:
 				ivrs_acpihid[00:14.5]=AMD0020:0
 
 	js=		[HW,JOY] Analog joystick
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 9693f0b9e07a..9b1026fa7283 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -84,6 +84,10 @@
 #define ACPI_DEVFLAG_ATSDIS             0x10000000
 
 #define LOOP_TIMEOUT	2000000
+
+#define IVRS_GET_SBDF_ID(seg, bus, dev, fd)	(((seg & 0xffff) << 16) | ((bus & 0xff) << 8) \
+						 | ((dev & 0x1f) << 3) | (fn & 0x7))
+
 /*
  * ACPI table definitions
  *
@@ -3288,15 +3292,17 @@ static int __init parse_amd_iommu_options(char *str)
 
 static int __init parse_ivrs_ioapic(char *str)
 {
-	unsigned int bus, dev, fn;
+	u32 seg = 0, bus, dev, fn;
 	int ret, id, i;
-	u16 devid;
+	u32 devid;
 
 	ret = sscanf(str, "[%d]=%x:%x.%x", &id, &bus, &dev, &fn);
-
 	if (ret != 4) {
-		pr_err("Invalid command line: ivrs_ioapic%s\n", str);
-		return 1;
+		ret = sscanf(str, "[%d]=%x:%x:%x.%x", &id, &seg, &bus, &dev, &fn);
+		if (ret != 5) {
+			pr_err("Invalid command line: ivrs_ioapic%s\n", str);
+			return 1;
+		}
 	}
 
 	if (early_ioapic_map_size == EARLY_MAP_SIZE) {
@@ -3305,7 +3311,7 @@ static int __init parse_ivrs_ioapic(char *str)
 		return 1;
 	}
 
-	devid = ((bus & 0xff) << 8) | ((dev & 0x1f) << 3) | (fn & 0x7);
+	devid = IVRS_GET_SBDF_ID(seg, bus, dev, fn);
 
 	cmdline_maps			= true;
 	i				= early_ioapic_map_size++;
@@ -3318,15 +3324,17 @@ static int __init parse_ivrs_ioapic(char *str)
 
 static int __init parse_ivrs_hpet(char *str)
 {
-	unsigned int bus, dev, fn;
+	u32 seg = 0, bus, dev, fn;
 	int ret, id, i;
-	u16 devid;
+	u32 devid;
 
 	ret = sscanf(str, "[%d]=%x:%x.%x", &id, &bus, &dev, &fn);
-
 	if (ret != 4) {
-		pr_err("Invalid command line: ivrs_hpet%s\n", str);
-		return 1;
+		ret = sscanf(str, "[%d]=%x:%x:%x.%x", &id, &seg, &bus, &dev, &fn);
+		if (ret != 5) {
+			pr_err("Invalid command line: ivrs_hpet%s\n", str);
+			return 1;
+		}
 	}
 
 	if (early_hpet_map_size == EARLY_MAP_SIZE) {
@@ -3335,7 +3343,7 @@ static int __init parse_ivrs_hpet(char *str)
 		return 1;
 	}
 
-	devid = ((bus & 0xff) << 8) | ((dev & 0x1f) << 3) | (fn & 0x7);
+	devid = IVRS_GET_SBDF_ID(seg, bus, dev, fn);
 
 	cmdline_maps			= true;
 	i				= early_hpet_map_size++;
@@ -3348,15 +3356,18 @@ static int __init parse_ivrs_hpet(char *str)
 
 static int __init parse_ivrs_acpihid(char *str)
 {
-	u32 bus, dev, fn;
+	u32 seg = 0, bus, dev, fn;
 	char *hid, *uid, *p;
 	char acpiid[ACPIHID_UID_LEN + ACPIHID_HID_LEN] = {0};
 	int ret, i;
 
 	ret = sscanf(str, "[%x:%x.%x]=%s", &bus, &dev, &fn, acpiid);
 	if (ret != 4) {
-		pr_err("Invalid command line: ivrs_acpihid(%s)\n", str);
-		return 1;
+		ret = sscanf(str, "[%x:%x:%x.%x]=%s", &seg, &bus, &dev, &fn, acpiid);
+		if (ret != 5) {
+			pr_err("Invalid command line: ivrs_acpihid(%s)\n", str);
+			return 1;
+		}
 	}
 
 	p = acpiid;
@@ -3371,8 +3382,7 @@ static int __init parse_ivrs_acpihid(char *str)
 	i = early_acpihid_map_size++;
 	memcpy(early_acpihid_map[i].hid, hid, strlen(hid));
 	memcpy(early_acpihid_map[i].uid, uid, strlen(uid));
-	early_acpihid_map[i].devid =
-		((bus & 0xff) << 8) | ((dev & 0x1f) << 3) | (fn & 0x7);
+	early_acpihid_map[i].devid = IVRS_GET_SBDF_ID(seg, bus, dev, fn);
 	early_acpihid_map[i].cmd_line	= true;
 
 	return 1;
-- 
2.31.1

