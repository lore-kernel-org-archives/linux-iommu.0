Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF578C433EF
	for <iommu@archiver.kernel.org>; Mon, 25 Apr 2022 11:43:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 953E360C0D;
	Mon, 25 Apr 2022 11:43:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VFANPhjPVYSv; Mon, 25 Apr 2022 11:43:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 7268B60B2C;
	Mon, 25 Apr 2022 11:43:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 57D20C0039;
	Mon, 25 Apr 2022 11:43:33 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 79D17C002D
 for <iommu@lists.linux-foundation.org>; Mon, 25 Apr 2022 11:43:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6764260C0D
 for <iommu@lists.linux-foundation.org>; Mon, 25 Apr 2022 11:43:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Y2tAeQ2e_cwH for <iommu@lists.linux-foundation.org>;
 Mon, 25 Apr 2022 11:43:31 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2061a.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8b::61a])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 506AA60B2C
 for <iommu@lists.linux-foundation.org>; Mon, 25 Apr 2022 11:43:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Meo/GjT3VNY0jDEFLJEnzdNQeeaSMEvlaQYRzcKOsIjT2bAMAh3YcF1aTDmzklj4AxGGn+PyXL29FMprN0jykiSHKFBORc93muGJfOuFudeXSMmDqseUZl4+vSgl1n9+gVyCYjzf2j+OV7zI+uDzPi+sMlsfBcGYlHpS7LIJGsofqyQOeVhytsQRoFnCYZ3w70wJteprsFoEVcyd4XQS3s0c/B64O0C7ej3h2kIt9EcugizhkZ7v4nKbIAh9zpZ2tSLCveIh2UE8SdPRtsxYkznKYYGsfirL2fYO44zInSA9If1ScVqGWufCyj7g4M6WOovA52iCRoZtF0ts2UhFeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t9vJiM6VpPds2yeSLnnX3YZUVu4nEeYrJQ5QDox3gN0=;
 b=REa8o+Jkbe+7f7m887rYtA0rC33VT4X1b3SSXgvw7a06rKKaBjLMjI1oGXguPUCHpB8WBZZ+hAB/t71s9E3ZvGaaRIHxnGX4+u83W3gBlcdEiCiHQle6Rcqg/tDh3gyO/UX7Y+F0FVo6ZvQ8pYUCoSlhMQ6zENq/5+oeCmtvWTzcSvPrbxEDBaoMeWkP64010DddcYr1QqDuZ+0JMn/hFNduIuvbx3LwwlIphXIl2LCJgwjRhy373u+Fgzhz2aKE6VT+vheXEcML2PcvZv8UqCE5zj8SuX7gsuWY96GdWHeENv3ZJkmR+uwMnHlVkNwsjMR97Plsea+Xd/r22t93gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux-foundation.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t9vJiM6VpPds2yeSLnnX3YZUVu4nEeYrJQ5QDox3gN0=;
 b=htXPP6hukozu4b1cCM3Ry8VVASiLWnZVolEPxrSvfH4wXIFCOVfb5MypHJNZNUqaXxyGfFV6n4lYSs5uVBgSpqPhHwQ1Va9exxyDaSQtrDPYBD1kBQmpy4eExaGp0aFqiIdqPeus1CaoenqActP6+Ng5dFewotJvlFzY1W/Tijg=
Received: from BN7PR02CA0026.namprd02.prod.outlook.com (2603:10b6:408:20::39)
 by BN8PR12MB2980.namprd12.prod.outlook.com (2603:10b6:408:62::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13; Mon, 25 Apr
 2022 11:43:28 +0000
Received: from BN8NAM11FT009.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:20:cafe::7f) by BN7PR02CA0026.outlook.office365.com
 (2603:10b6:408:20::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14 via Frontend
 Transport; Mon, 25 Apr 2022 11:43:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT009.mail.protection.outlook.com (10.13.176.65) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5186.14 via Frontend Transport; Mon, 25 Apr 2022 11:43:28 +0000
Received: from kali.amdval.net (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 25 Apr
 2022 06:43:26 -0500
To: <iommu@lists.linux-foundation.org>
Subject: [PATCH v2 34/37] iommu/amd: Add PCI segment support for ivrs_ioapic,
 ivrs_hpet, ivrs_acpihid commands
Date: Mon, 25 Apr 2022 17:04:12 +0530
Message-ID: <20220425113415.24087-35-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220425113415.24087-1-vasant.hegde@amd.com>
References: <20220425113415.24087-1-vasant.hegde@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 94221015-1dee-4514-54f2-08da26b0d094
X-MS-TrafficTypeDiagnostic: BN8PR12MB2980:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB298097927489C05B1A60C2B287F89@BN8PR12MB2980.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MVXFGoQf0MIpFhh0MHJTpsdYRpnV1Bxf93/HP2eQFjtE7ZTDJybdzDRlPPXrHKtBU7y1zDQ4HF/icWVxvvi3kEGxwwLG79EgKTU+IqBe4a/pz7KYcLUN2bTTyK1cQFU8dZyFK4Wqh/+Qn/kQssf9gvake/sauKtpmJNOZ1sNnc5BenbPEOTxZZA3WbSW4x2WjoEGr+tEPlS6rhzF9eFHI7I4CYydIhLsp/VFODm7BUs2VdD90HEHQ5dFv2NsF7+DNruJ6g6EdRk+5yj/E2a4r9te8Qouh48/FWmVCNX0m1A6eeWt+wyFPBt8Kxtpw6XTB0OdLdJuKP7oAlOATDuSMNVWMu6LJhcHXInpGwavo6WNy6xYIW3W5MTe14xNFdLIZN92A/4qWAjMw/cfesq3fNVs2Ja5DyPdC8iAYtN6+ZaBMkLXVJQbBvAxQYW7FPfPqGw/3C6kekx5ntaZAs7WDGzygo/G7O/fY1DRTs5f0oKS6iVUA8zZWQf3hzxhy7MQwdwrZVTygRPytX12feo5x4trkkwn9uiWCnz3ZsnexeuuZP6jTKqp16g6TMv3FSkG8J1Ahg/zx3GXFrzAYo3AIUlR/VpJPyBOurkdgY3R/vKUovqmDcLC614peAdInW1kXEDXZnuY+UlbqtTtEbuzOsbhq0x0WjaNLkGe26I/I0NEKEyhzmx6lUvZNlD1E4nkytIfzYbWP+QP1R9a8VAWAQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(83380400001)(6916009)(54906003)(36756003)(8936002)(36860700001)(16526019)(82310400005)(47076005)(2616005)(316002)(336012)(186003)(426003)(1076003)(4326008)(8676002)(70206006)(81166007)(26005)(70586007)(40460700003)(356005)(44832011)(508600001)(2906002)(5660300002)(86362001)(6666004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2022 11:43:28.1203 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 94221015-1dee-4514-54f2-08da26b0d094
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT009.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB2980
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
