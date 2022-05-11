Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1AC0C433EF
	for <iommu@archiver.kernel.org>; Wed, 11 May 2022 07:30:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9F7AE60BAE;
	Wed, 11 May 2022 07:30:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CEBCGzKGKEJa; Wed, 11 May 2022 07:30:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 4E0CB6080B;
	Wed, 11 May 2022 07:30:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2A531C0039;
	Wed, 11 May 2022 07:30:25 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 98BABC002D
 for <iommu@lists.linux-foundation.org>; Wed, 11 May 2022 07:30:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 783A260BA3
 for <iommu@lists.linux-foundation.org>; Wed, 11 May 2022 07:30:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cecb8dZ6Ea7W for <iommu@lists.linux-foundation.org>;
 Wed, 11 May 2022 07:30:22 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on20618.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7ea9::618])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 79D126080B
 for <iommu@lists.linux-foundation.org>; Wed, 11 May 2022 07:30:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e480/QZGAjZZvLfSlFvXERGfo5wOI4mcBSwMTQksKGgnSUEpzQpPqgBAJJpp3akmRFZCJo++KYBeEyjYw55V8baC/5ydOyxCYkiaKn4dpurttdjQ7XEE1oITtMdGEA9gqI4iAQU9Ao6xuE93ZFYf/Dc4WsEOvhsHgJ2u7QqIBcMi9ebtyUXrW2/LWwdGHSAL82QYvcw96UAdegnCpkX6/G7fFpPpiT43UPVm8rfXvqBlzz8QZtZ3ZlrMVcA2FG5QFV7t9VirdaQpCdxFzxTt34ICtNredYazQmviNrhgXb1zgTxjSVNWxeUEbXZfoDbPVTjVKvP+M8V839CdBQd3zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ovPZUppPLFY+JyGvH5fOnlaaoXMUzb35yzHlKirtLCQ=;
 b=QYIpBJeQayJawlzZg3faZ8aR5HFlXdOz0or8aKPsiKqBNG1zcr5/G0joRerxrklksFfDn+O++nAtH3HXHbr5SX20PctvRX4jxvUctja57qggQ8YHem3BHfmQFSQklmzO6ZFbQGmI8gRJ1xdmBQRuNrCIjsgUCAZuu8mjoTisxAKN7aflvzgT2o1nQl3BU7D39bIBXwV9QFOtRbOHysMUDfuv5w6O0b+n8R2JygdFbu3+ml+RAmwjtfchP7/CNIDkG/lfyV4lcBHVQtjwJx78vfpjhVY1bK7gdH+xN3WbxJsPtxcggQgJ4IWslwd8tAdfpbKJNec6geFNsUrFm5lDMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux-foundation.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ovPZUppPLFY+JyGvH5fOnlaaoXMUzb35yzHlKirtLCQ=;
 b=p/6VpcsgMIqIL1xjVhNzgz3MDLq7EwtJniJypP4C53MB1R7qjj04B+jracOrjZW+mMcM9KB7KFuWYbjitCvLyHqn7MZztF35aRmWoXRm3Gdvl2PD+CvrK2Xf52/wtdeFSQdVzyzQZf3/TPf/8seJmtiG3jggfUg+M7qq1lumssA=
Received: from DS7PR03CA0152.namprd03.prod.outlook.com (2603:10b6:5:3b2::7) by
 DM6PR12MB3452.namprd12.prod.outlook.com (2603:10b6:5:115::12) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5250.13; Wed, 11 May 2022 07:30:19 +0000
Received: from DM6NAM11FT068.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b2:cafe::3b) by DS7PR03CA0152.outlook.office365.com
 (2603:10b6:5:3b2::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.21 via Frontend
 Transport; Wed, 11 May 2022 07:30:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT068.mail.protection.outlook.com (10.13.173.67) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5250.13 via Frontend Transport; Wed, 11 May 2022 07:30:19 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 11 May
 2022 02:30:16 -0500
To: <iommu@lists.linux-foundation.org>
Subject: [PATCH v3 32/35] iommu/amd: Add PCI segment support for
 ivrs_[ioapic/hpet/acpihid] commands
Date: Wed, 11 May 2022 12:51:38 +0530
Message-ID: <20220511072141.15485-33-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220511072141.15485-1-vasant.hegde@amd.com>
References: <20220511072141.15485-1-vasant.hegde@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 92867742-19ab-483e-6c21-08da33201a21
X-MS-TrafficTypeDiagnostic: DM6PR12MB3452:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB3452EA7AAFB30C4B3E2A11DF87C89@DM6PR12MB3452.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QwcYMN/c2OrAsQkblSkUjj4OKlmDLbk7mqrjHPt2HzEnqNtfg0mb4k8a+0bvC23fYm/dN2xJh+Maa/xm57uLheo16+Ocp8AIqVeOvkq6aIUPPyZ/n8KdkzM63RC2K0Jn/TVZX8e4HSbzgTJAyUDchBAr5IW6Zcnt4oreDR5btRydkyPan2m7/uQ1koeJ3sCJRb1veNsJJFO3rxR5rU5BihiwChEDwtvfmJw9EaAKQE8om8SXsZfL7RkxMILsiVxH9MJwaZfEWMP0jguBeDUYbEcy2hRDABfbhPtPveLspe5Veu01lhy2f+nP1BMKbS38wXHK0tO328weNB89LM/3k0H1B3gDSP3/YCm8xjA+5Rt7jtoqERGgAzafImNrSrC722cyH5oETYBuaYHtnuGWX2wX2cbry2HxAV4cr+zYTS77qFOcKF1sYAQDZrL8cuXw2N0o/gLALDvUdRol8sJkkPs/FquCvnrbpfoPB5zDiEIIvgYhHuFkREWT5jPPGH84zgP5BfUxi1rEt1SkZUTJTD7dSQmbJVVghfLjyWN6jIMWeSPAIYCfpSY4xD2lHyjk/eAbP00g3oM3z4LlFjDq2BU+bosPMxPz8FIWHg6LjH+Amf3RSp+N0UN0iEnkx1+9Co2HmnMK6Yiym7WaXhs+98E6+E/LWx97HX1gYp7znyV9LXn2LAAyiykvPDoEIdpiT12l1e1evfHKnTetQ/KTnA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(54906003)(508600001)(316002)(81166007)(8676002)(4326008)(86362001)(70206006)(356005)(426003)(70586007)(6916009)(1076003)(16526019)(83380400001)(36860700001)(47076005)(186003)(336012)(6666004)(7696005)(26005)(2616005)(36756003)(82310400005)(2906002)(44832011)(5660300002)(8936002)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2022 07:30:19.4683 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 92867742-19ab-483e-6c21-08da33201a21
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT068.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3452
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

Co-developed-by: Vasant Hegde <vasant.hegde@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 .../admin-guide/kernel-parameters.txt         | 34 ++++++++++----
 drivers/iommu/amd/init.c                      | 44 ++++++++++++-------
 2 files changed, 52 insertions(+), 26 deletions(-)

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
index ca79637560a3..969b496f7e74 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -85,6 +85,10 @@
 #define ACPI_DEVFLAG_ATSDIS             0x10000000
 
 #define LOOP_TIMEOUT	100000
+
+#define IVRS_GET_SBDF_ID(seg, bus, dev, fd)	(((seg & 0xffff) << 16) | ((bus & 0xff) << 8) \
+						 | ((dev & 0x1f) << 3) | (fn & 0x7))
+
 /*
  * ACPI table definitions
  *
@@ -3287,15 +3291,17 @@ static int __init parse_amd_iommu_options(char *str)
 
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
@@ -3304,7 +3310,7 @@ static int __init parse_ivrs_ioapic(char *str)
 		return 1;
 	}
 
-	devid = ((bus & 0xff) << 8) | ((dev & 0x1f) << 3) | (fn & 0x7);
+	devid = IVRS_GET_SBDF_ID(seg, bus, dev, fn);
 
 	cmdline_maps			= true;
 	i				= early_ioapic_map_size++;
@@ -3317,15 +3323,17 @@ static int __init parse_ivrs_ioapic(char *str)
 
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
@@ -3334,7 +3342,7 @@ static int __init parse_ivrs_hpet(char *str)
 		return 1;
 	}
 
-	devid = ((bus & 0xff) << 8) | ((dev & 0x1f) << 3) | (fn & 0x7);
+	devid = IVRS_GET_SBDF_ID(seg, bus, dev, fn);
 
 	cmdline_maps			= true;
 	i				= early_hpet_map_size++;
@@ -3347,15 +3355,18 @@ static int __init parse_ivrs_hpet(char *str)
 
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
@@ -3370,8 +3381,7 @@ static int __init parse_ivrs_acpihid(char *str)
 	i = early_acpihid_map_size++;
 	memcpy(early_acpihid_map[i].hid, hid, strlen(hid));
 	memcpy(early_acpihid_map[i].uid, uid, strlen(uid));
-	early_acpihid_map[i].devid =
-		((bus & 0xff) << 8) | ((dev & 0x1f) << 3) | (fn & 0x7);
+	early_acpihid_map[i].devid = IVRS_GET_SBDF_ID(seg, bus, dev, fn);
 	early_acpihid_map[i].cmd_line	= true;
 
 	return 1;
-- 
2.27.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
