Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69DF3C433EF
	for <iommu@archiver.kernel.org>; Mon,  4 Apr 2022 10:09:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2C32382A2D;
	Mon,  4 Apr 2022 10:09:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YfbqdFSc1vtD; Mon,  4 Apr 2022 10:09:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id D5B7580DC0;
	Mon,  4 Apr 2022 10:09:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AEF31C002C;
	Mon,  4 Apr 2022 10:09:24 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CE330C0012
 for <iommu@lists.linux-foundation.org>; Mon,  4 Apr 2022 10:09:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id AEB9C813CE
 for <iommu@lists.linux-foundation.org>; Mon,  4 Apr 2022 10:09:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XkzcKBP-ej5P for <iommu@lists.linux-foundation.org>;
 Mon,  4 Apr 2022 10:09:22 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20608.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::608])
 by smtp1.osuosl.org (Postfix) with ESMTPS id BDF5680DC0
 for <iommu@lists.linux-foundation.org>; Mon,  4 Apr 2022 10:09:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nAgRzoGbJZdY5hYKmwHcOWRCEm3svFzsqrLea22DjU7ZRdPoqONxMaB8cj9RCHNSO5ajnP1bq8kJwEXTN7Bt7XwoKAGzkvmZcEt+NLaFUOQlNrQRRJhcaeRKGHBT55em1zHROtFlhXU9lFDoJZ4ShBHVQBrUGMtPilaBUEHm5HZaHvxmZFMjuMoNPxmqyZKvwo6jjZlcU5uaK83Sl/LePEGAYHo9VUIq2Ee44iy/hvL38m+n6+RgSwRS6/JVt46vVjODnTUo24hfkZsK/0p+6g9NuTqBVjtPem2jylwPcj/QaoN0UWGrsb6l7OZcaigXDJbXPBVc9un5B/emduMRPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t9vJiM6VpPds2yeSLnnX3YZUVu4nEeYrJQ5QDox3gN0=;
 b=ZX76xFml/2lj+Q9BPXrahiIAxTSBcEseJo1fz8Q2ZpwXUmtseiiifsymWYtRwv9a8fgjKHXsI84wLL/JA6/FVKaWFHIjVIUVlVcH7IcNxD3Fy4brqKMOtetTQMzTwMgHbJojPBxZ3C0hzT9xg5CGV/6jnD9SdQgObcgZzrVJqBY9Dvbdo+83u5EegNKO/9jsPbu4l6HZUnBuKPluGtviAksDhFo0hEu0a3WG8O/NPJatg2UACO2WstjZ169Awo5ubH8ic9RAby1V+spNvEg+fier9VypFHJ8oAs2c2Ey3W9XhwU4p4Nqmt9MrjaHXhRMU0xqO2QEYcH2oEd8rglKVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux-foundation.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t9vJiM6VpPds2yeSLnnX3YZUVu4nEeYrJQ5QDox3gN0=;
 b=S0zx3G8ZPa0HmaffFi/vzAV3JOd+GGxcr3CHVTjc48zjIiAgKv7sosEMPQgxJ6Qecqa4LGLTCQ+W1oqu7sVq83o3JzHYpCnRIXMm/cKo4LTg/4nt6z+2WWwwi5ZSbmK9I70pQEKWCk7tQEMZBMTlJwMJmo9SCzojjyBu9uQnwP4=
Received: from MW4P220CA0005.NAMP220.PROD.OUTLOOK.COM (2603:10b6:303:115::10)
 by DM6PR12MB4928.namprd12.prod.outlook.com (2603:10b6:5:1b8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Mon, 4 Apr
 2022 10:09:20 +0000
Received: from CO1NAM11FT017.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:115:cafe::f1) by MW4P220CA0005.outlook.office365.com
 (2603:10b6:303:115::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.13 via Frontend
 Transport; Mon, 4 Apr 2022 10:09:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT017.mail.protection.outlook.com (10.13.175.108) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5123.19 via Frontend Transport; Mon, 4 Apr 2022 10:09:20 +0000
Received: from kali.amdval.net (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 4 Apr
 2022 05:09:17 -0500
To: <iommu@lists.linux-foundation.org>, <joro@8bytes.org>
Subject: [RESEND PATCH v1 34/37] iommu/amd: Add PCI segment support for
 ivrs_ioapic, ivrs_hpet, ivrs_acpihid commands
Date: Mon, 4 Apr 2022 15:30:20 +0530
Message-ID: <20220404100023.324645-35-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220404100023.324645-1-vasant.hegde@amd.com>
References: <20220404100023.324645-1-vasant.hegde@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9716a9c9-c4ff-4b54-13c9-08da16232f94
X-MS-TrafficTypeDiagnostic: DM6PR12MB4928:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB49287DFE15B28804644F10E187E59@DM6PR12MB4928.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Dx+3iLHZ6NHDqrjVgt+hg1zhUFk2tR4laLAuGNlqyApjq/H/dK223xD1U5VyIHtZRrBTlggBvebkGl2Olj2LpeyiElQ3u9QmHtkd73TJ9LpsAwEmMZuCwR6GG9GXCk+RDACfTOzbvTYkWi1lqGIJZd/6Ljm/zKdDeaLXeHQksaoXTDGxt4wE3/8n0NiqJ0CBbrHrQ1EnO3hFpyUDXn9OLpQv4s33+iFkFG05K+Iom1hQrouSBf78YymHsB88LLbRJ8M35nZkRUFOjV7j23dGb5KM9xSEin8W6Lx1YU/NEB3tSh1R/HHZ60u7DSv9FTOW6YQ493/bk3SAGT36aXhK54g3gmxhFYCanILS0f2Pih64EHZKVbY7QjEVv6OzLdtLiSMrFKu7npD8x0/DkMPUcQkc9UG4yYG2Vv+SqCY3NEfFsj1he5QUtSj7xBOoG409yxg0HsS1z4jJOpmoFWdvlH2EYd37QeYDvnGIZYjhCldUxgHwzUPJzuvD1uMuQ52oeciLKKET1tpr9HhPye/v3L6M/Gwb5pwreRj268qbCpj2Qf0grIMa4FGro+qSZ+gTd5SplMNuJzhTD9PzDqyZwha1BrPPhY/wbbdEkah0l3MjNbl96MveVypr++zZG+pPXDYvbWtEDKKnTk+U7F70DgC2WUw6fr0FdFITYItk3+vecsWee4pP1kXFxWsBbLrFsCF7FsR43DIrGoIDRR59jg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(4326008)(356005)(8676002)(5660300002)(6666004)(110136005)(54906003)(316002)(508600001)(16526019)(83380400001)(70206006)(47076005)(1076003)(426003)(336012)(186003)(26005)(70586007)(36860700001)(36756003)(44832011)(81166007)(40460700003)(2616005)(86362001)(8936002)(2906002)(82310400004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2022 10:09:20.2371 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9716a9c9-c4ff-4b54-13c9-08da16232f94
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT017.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4928
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
