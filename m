Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA383C433EF
	for <iommu@archiver.kernel.org>; Fri, 11 Mar 2022 10:01:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B2E7E61288;
	Fri, 11 Mar 2022 10:01:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id J1rFNY9FLFRi; Fri, 11 Mar 2022 10:00:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 3BA6F6127C;
	Fri, 11 Mar 2022 10:00:59 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 17705C0012;
	Fri, 11 Mar 2022 10:00:59 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 86789C000B
 for <iommu@lists.linux-foundation.org>; Fri, 11 Mar 2022 10:00:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 763A7418FB
 for <iommu@lists.linux-foundation.org>; Fri, 11 Mar 2022 10:00:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=amd.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4Cjx97H_3wnU for <iommu@lists.linux-foundation.org>;
 Fri, 11 Mar 2022 10:00:56 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on20610.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7ea9::610])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 79A264099B
 for <iommu@lists.linux-foundation.org>; Fri, 11 Mar 2022 10:00:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tx6ZFYDpz+HvyUcjcraRa0xlPq2yQomr2GgUTlCWkQCvUtMdCsiyzWHLuKQkanKCvgrjNoMGcQt/FXxLB0eabj/J+/YiaEkAyGSd4ketEz6vs/sTythKmVAZGYyDaxp4/2lnFR66kfxGA4qijowmsCHIQD7O0fqGOsca+FbFLS6nfd90VQAydPnmsk/aaa8nmkmhFe6y5AHlJhOBvoYai9aZB3L6Tw7f1mdMEnYHdNFVsVN8VTh3akZaWtmiudmBTtzUZnot8vx8yp3vJ9gK0IrZyNfFqPc341BvDUCpeoSvyuBqOpIXyqOGxqqDr9xIUY0PLJHu07gg2vMFwhXcGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t9vJiM6VpPds2yeSLnnX3YZUVu4nEeYrJQ5QDox3gN0=;
 b=GMHrlI9XAtxQqcZYK7nAbPjiy2/gwFP6M96JcHSJo1SXcbBCS9o19LyYC+wTKay9k4+9Gxl/xRmMwXXS0s42T86nCIuwQCCZfGwPvJurSnNDctLpbI7V+LbZzQe2GHxmON3ZZ8lNGtRpLcGRSp5GbwzVYcsFbxXMiChos4Z35jytGtabg2+AR64M1YPWOB5K81vSiWDrZxsB2pJfhEffBMwZSdDmSyZbTKHyUmzOxRfBhk2fbWNgP6wzicCuJIAoSS8LYyznm5rIqDgnrfgsHWg7Jn4SBOlFd3s1F8yGhpP4HHFF63uKJRuc2fVIpCCDUCU1QnHoZ4lYbxeVJEsKDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux-foundation.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t9vJiM6VpPds2yeSLnnX3YZUVu4nEeYrJQ5QDox3gN0=;
 b=fEav4ERtY4C25DgAY17mBqjOJ0zeANQfRg4/7nRIpS5/nuZP8ePRGAHRWrNz1Ln6ulmIaIs6ER2hKRUz48fY1a2aMMjwkO69er/CMK7HwvSPWYOArubnqDAqoez6LU033tzOOmJ2+NYIftchjbg/+Zwv/b5aK+UldPi1Syf/yaQ=
Received: from BN6PR19CA0081.namprd19.prod.outlook.com (2603:10b6:404:133::19)
 by MW5PR12MB5597.namprd12.prod.outlook.com (2603:10b6:303:192::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Fri, 11 Mar
 2022 10:00:51 +0000
Received: from BN8NAM11FT004.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:133:cafe::61) by BN6PR19CA0081.outlook.office365.com
 (2603:10b6:404:133::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.25 via Frontend
 Transport; Fri, 11 Mar 2022 10:00:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT004.mail.protection.outlook.com (10.13.176.164) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5061.22 via Frontend Transport; Fri, 11 Mar 2022 10:00:50 +0000
Received: from kali.amdval.net (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 11 Mar
 2022 04:00:48 -0600
To: <iommu@lists.linux-foundation.org>, <joro@8bytes.org>
Subject: [RFC PATCH 33/36] iommu/amd: Add PCI segment support for ivrs_ioapic,
 ivrs_hpet, ivrs_acpihid commands
Date: Fri, 11 Mar 2022 15:18:51 +0530
Message-ID: <20220311094854.31595-34-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220311094854.31595-1-vasant.hegde@amd.com>
References: <20220311094854.31595-1-vasant.hegde@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 25e5cac7-cbfd-4eaf-76e4-08da0346060f
X-MS-TrafficTypeDiagnostic: MW5PR12MB5597:EE_
X-Microsoft-Antispam-PRVS: <MW5PR12MB5597C9385E22798D68E15836870C9@MW5PR12MB5597.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TmegLvhtxg2LboCudlB0Ms+RueJ5RUq3NWVI8EQyBhpoXy0fhoNN+MS7TDTOgHj2k026WoSwZ3MDySyP/KNlBl9sEILcxittpTM2FmxwDYZtrxFClnAS5/iIHR1C0zQGYtxI6vqJI+fqH5XWDMtF2TEVLVxd+5TXp75hUm34/f86gMIVkXgFBcaKFrgLvpd+220j09tVhleXGjGbIdzHCqO3rHOFQj6z8jIYQyXT7BKNBNwzHLWYhxAwSyQy0A9Y/JVzztsunWuKsC8tKNxCNlodCqXfykyeyK0m+y4n4e7tXAgsuE1DO0TN4hdiG5pveZbAd1rQczldT6S/GcKnDqov9SyGZFEWd88Tc2CoYNM6jVOni0ZvcOBRq19UMHyhwWsnt9nfPOkDX4Iv+WbJf8tKgCSYgoQ24flsjJVNwswg1ryw2z23rvVJWrXGDQtDH/w8JG8aIszwD+Gnw8hCfiVfsmTjv9lwoSOwAc2URN4ojwi6sfyN4SatZPhJzioZIUVgaDNX19/uZRypyucThvaa0+39PRnA3J8AOQ0lq1Xe+ZmoW7W4cw2NFmRq4CLxBHBjZAkymsAgerONn9uuJTER9arXygG6mUpmn/IKgK6HJCq21dm7/aZbAPgPeR5dsh6FUjDdHv1iCxDqEpq6v/oJ+WtcCUAjrWy1vEmxKD6ZJFQNQMEBf9CrB5UiswBfObrrfXepBD8Yiyenl7Ix2Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(110136005)(83380400001)(40460700003)(5660300002)(316002)(54906003)(70206006)(1076003)(2616005)(36756003)(186003)(426003)(16526019)(336012)(26005)(8936002)(2906002)(47076005)(81166007)(8676002)(70586007)(36860700001)(4326008)(86362001)(356005)(508600001)(82310400004)(44832011)(6666004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2022 10:00:50.9836 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 25e5cac7-cbfd-4eaf-76e4-08da0346060f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT004.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5597
Cc: Vasant Hegde <vasant.hegde@amd.com>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
From: Vasant Hegde via iommu <iommu@lists.linux-foundation.org>
Reply-To: Vasant Hegde <vasant.hegde@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>

By default, PCI segment is zero and can be omitted. To support system
with non-zero PCI segment ID, modify the parsing functions to allow
PCI segment ID.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 .../admin-guide/kernel-parameters.txt         | 34 +++++++++++----
 drivers/iommu/amd/init.c                      | 41 ++++++++++++-------
 2 files changed, 51 insertions(+), 24 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index f5a27f067db9..cc8f0c82ff55 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -2208,23 +2208,39 @@
 
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
index ccc0208d4b69..ba0ef8192a2f 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -3288,15 +3288,17 @@ static int __init parse_amd_iommu_options(char *str)
 
 static int __init parse_ivrs_ioapic(char *str)
 {
-	unsigned int bus, dev, fn;
+	u32 seg = 0, bus, dev, fn;
 	int ret, id, i;
 	u16 devid;
 
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
@@ -3305,7 +3307,8 @@ static int __init parse_ivrs_ioapic(char *str)
 		return 1;
 	}
 
-	devid = ((bus & 0xff) << 8) | ((dev & 0x1f) << 3) | (fn & 0x7);
+	devid = ((seg & 0xffff) << 16) | ((bus & 0xff) << 8) |
+		((dev & 0x1f) << 3) | (fn & 0x7);
 
 	cmdline_maps			= true;
 	i				= early_ioapic_map_size++;
@@ -3318,15 +3321,17 @@ static int __init parse_ivrs_ioapic(char *str)
 
 static int __init parse_ivrs_hpet(char *str)
 {
-	unsigned int bus, dev, fn;
+	u32 seg = 0, bus, dev, fn;
 	int ret, id, i;
 	u16 devid;
 
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
@@ -3335,7 +3340,8 @@ static int __init parse_ivrs_hpet(char *str)
 		return 1;
 	}
 
-	devid = ((bus & 0xff) << 8) | ((dev & 0x1f) << 3) | (fn & 0x7);
+	devid = ((seg & 0xffff) << 16) | ((bus & 0xff) << 8) |
+		((dev & 0x1f) << 3) | (fn & 0x7);
 
 	cmdline_maps			= true;
 	i				= early_hpet_map_size++;
@@ -3348,15 +3354,18 @@ static int __init parse_ivrs_hpet(char *str)
 
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
@@ -3371,8 +3380,10 @@ static int __init parse_ivrs_acpihid(char *str)
 	i = early_acpihid_map_size++;
 	memcpy(early_acpihid_map[i].hid, hid, strlen(hid));
 	memcpy(early_acpihid_map[i].uid, uid, strlen(uid));
-	early_acpihid_map[i].devid =
-		((bus & 0xff) << 8) | ((dev & 0x1f) << 3) | (fn & 0x7);
+	early_acpihid_map[i].devid = ((seg & 0xffff) << 16) |
+				     ((bus & 0xff) << 8) |
+				     ((dev & 0x1f) << 3) |
+				     (fn & 0x7);
 	early_acpihid_map[i].cmd_line	= true;
 
 	return 1;
-- 
2.27.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
