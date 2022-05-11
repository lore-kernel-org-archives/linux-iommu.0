Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AAB4C433F5
	for <iommu@archiver.kernel.org>; Wed, 11 May 2022 07:28:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4F708831E3;
	Wed, 11 May 2022 07:28:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ebrHf3aPYAF4; Wed, 11 May 2022 07:28:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id F3493832EA;
	Wed, 11 May 2022 07:28:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CCACFC0039;
	Wed, 11 May 2022 07:28:55 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3EB60C002D
 for <iommu@lists.linux-foundation.org>; Wed, 11 May 2022 07:28:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1F64660BAE
 for <iommu@lists.linux-foundation.org>; Wed, 11 May 2022 07:28:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=amd.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jloLDAk2d11r for <iommu@lists.linux-foundation.org>;
 Wed, 11 May 2022 07:28:53 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on20624.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7ea9::624])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 394E66080B
 for <iommu@lists.linux-foundation.org>; Wed, 11 May 2022 07:28:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RB2egKnnGht0uw/naaXNyNk26iTeK3zWb32hWLPON5HpcPPT0l9eECWOejeoTeiM3J5/F1EgJ8QNFYUbXtLrZcgE8NyxnoRO9Se8q6pvo21oBTg/NG/EWhZqVOpjt1IaoWCveoI9gzvdLJJod2PbGkAGge9O6F0ITxW01w7lRvmbDLObKneFUjS6IDNSdnZVgFNKezW+wIZ0iDJzbeBUfBcWV/SxrjKY36QgdcNRddjZUVEqVyDezlaWAYRyw08MypM/BsHuoZ4QnKWu/48jH0bEOXdyosL7sqWfDOXKYL3iONSuokPzpXtw5/jMDMLlT5OSZsaB3F3qCa3WOE1y9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6p4ZC1pHQxPTm5A8vRp6rK1j4385aUOafgAw5qJJO/Q=;
 b=kprRisJtJYqOCILpdJXQq5sLWB5erGctzP+aiG7SlQfCmKdICtH91OVYFI+P4DPJmUA4kFq5gILgVsAoFO48MMAD0KeWp++lcTWz9uhMg6vcwMVMc3iCDx/5idMSJbJDG3/bSfNgRowUD2t8KpM6Gjwj7dM7Jme6BYYm3NiJPIqtxuKm708Y0iRIJyoUiNAVgxerhPKaIb9lXXlRNDupcICgWzdJ40I8FNtcU2Hlji0lDDp6iUTgNJJ2lyXFTpLIbyrdz8H5Vs0IXH6MGRDGpq04FVfwmwr0Mv1uhSqqkTyuvNtyE5Gu+uWsl3UGY50XbjgBYhiVGRM+TYIPoTJDWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux-foundation.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6p4ZC1pHQxPTm5A8vRp6rK1j4385aUOafgAw5qJJO/Q=;
 b=gf0WUYBl4FuHADmrJ7sToO46Wrw9IUD5FHghk2eAWsta24znIAqH3hgrhRQ4iCxCgTgfuZIPZoeUsFi+gUNbJjJDYxkjAq1p3Dyqi+GBCgtAgG6+17tkuJzYtYlrJYIpYIOxC8Csq3kepMs2x0ljsViCTqTgvNfMWs52zpCYsng=
Received: from DS7PR05CA0091.namprd05.prod.outlook.com (2603:10b6:8:56::12) by
 BN8PR12MB2897.namprd12.prod.outlook.com (2603:10b6:408:99::25) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5227.22; Wed, 11 May 2022 07:28:48 +0000
Received: from DM6NAM11FT018.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:56:cafe::a2) by DS7PR05CA0091.outlook.office365.com
 (2603:10b6:8:56::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.13 via Frontend
 Transport; Wed, 11 May 2022 07:28:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT018.mail.protection.outlook.com (10.13.172.110) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5250.13 via Frontend Transport; Wed, 11 May 2022 07:28:48 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 11 May
 2022 02:28:45 -0500
To: <iommu@lists.linux-foundation.org>
Subject: [PATCH v3 26/35] iommu/amd: Update set_dev_entry_bit() and
 get_dev_entry_bit()
Date: Wed, 11 May 2022 12:51:32 +0530
Message-ID: <20220511072141.15485-27-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220511072141.15485-1-vasant.hegde@amd.com>
References: <20220511072141.15485-1-vasant.hegde@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3c528a77-2ff3-4708-d9f3-08da331fe3be
X-MS-TrafficTypeDiagnostic: BN8PR12MB2897:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB289726BB072FF1618D16D74E87C89@BN8PR12MB2897.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IPbyvjGaJm+Bx2fMq13Iw4KEHMP/USqaHaURKS0RKYHTWDcUgrRiG6w9kouFmMmjirHgZUtkbGhGdPmNY9tkZ0GVXnPqxxDXKzvgNhtF7i071zXQdcYs3+B0ZB5uvq1ekj5uwON0Beoir0UOmGQmCAZSr1yNGJh7ouUbFx3JTB8FQw2wlTktMRudajxYLqWvzPuHbQ0jQpKypi08Gwys+tYG5a9bezhvqtyRm6sU8+WKgFcxOndqUBAbQy65/CX/YjY2kyuxTUTovycuj6FizOLeyLsy8PvvorB706s8BJWr8bzRhaXn67f0gqio4G+BHFVi6xJxA2CxzZ26iAofrBkEPV2jdxqB943hFjVUJXtIVNa/NqVHZQLfaKkDvCKWXABFJf6+HfHXMFE2dqD9dYcGsrN/DbClWGAZwONUW0IQ+6uEfBb83A6+4JjFOvNdd6OPp4du/RixCpTA+mUiTk7QXbm3wheRG6IYYZi2uOnEoLmJdzuwCQyyn5l1pbf0Xbe1zxq45HaASOHh86f8ckyISuZWN5J3CA8QuWESbIJ5+GLUyBO5iWVZAmL1uxEab8lRemVOt+AbLi/zexteSeu6lotmKzUC+ri5TrkKToOzcKfdkJvAnfRBJQ3w+nmgLRU7dLt7cRgQ4PGNDw4x+qfBCGvbBmEcVNopAVXvF5eIcOenf2jgU0DpmJgcZaPlZI8Ww45Cm95BtKmAP9uGhQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(83380400001)(36756003)(356005)(44832011)(81166007)(2616005)(82310400005)(8936002)(70586007)(6916009)(4326008)(70206006)(8676002)(54906003)(26005)(36860700001)(47076005)(426003)(336012)(40460700003)(316002)(508600001)(2906002)(5660300002)(16526019)(186003)(6666004)(1076003)(86362001)(7696005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2022 07:28:48.3347 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c528a77-2ff3-4708-d9f3-08da331fe3be
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT018.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB2897
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

To include a pointer to per PCI segment device table.

Also include struct amd_iommu as one of the function parameter to
amd_iommu_apply_erratum_63() since it is needed when setting up DTE.

Co-developed-by: Vasant Hegde <vasant.hegde@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/amd_iommu.h |  2 +-
 drivers/iommu/amd/init.c      | 59 +++++++++++++++++++++++------------
 drivers/iommu/amd/iommu.c     |  2 +-
 3 files changed, 41 insertions(+), 22 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index 2947239700ce..64c954e168d7 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -13,7 +13,7 @@
 
 extern irqreturn_t amd_iommu_int_thread(int irq, void *data);
 extern irqreturn_t amd_iommu_int_handler(int irq, void *data);
-extern void amd_iommu_apply_erratum_63(u16 devid);
+extern void amd_iommu_apply_erratum_63(struct amd_iommu *iommu, u16 devid);
 extern void amd_iommu_restart_event_logging(struct amd_iommu *iommu);
 extern int amd_iommu_init_devices(void);
 extern void amd_iommu_uninit_devices(void);
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index ca9131ab745b..2cdce8a3b86e 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -987,22 +987,37 @@ static void iommu_enable_gt(struct amd_iommu *iommu)
 }
 
 /* sets a specific bit in the device table entry. */
-static void set_dev_entry_bit(u16 devid, u8 bit)
+static void __set_dev_entry_bit(struct dev_table_entry *dev_table,
+				u16 devid, u8 bit)
 {
 	int i = (bit >> 6) & 0x03;
 	int _bit = bit & 0x3f;
 
-	amd_iommu_dev_table[devid].data[i] |= (1UL << _bit);
+	dev_table[devid].data[i] |= (1UL << _bit);
 }
 
-static int get_dev_entry_bit(u16 devid, u8 bit)
+static void set_dev_entry_bit(struct amd_iommu *iommu, u16 devid, u8 bit)
+{
+	struct dev_table_entry *dev_table = get_dev_table(iommu);
+
+	return __set_dev_entry_bit(dev_table, devid, bit);
+}
+
+static int __get_dev_entry_bit(struct dev_table_entry *dev_table,
+			       u16 devid, u8 bit)
 {
 	int i = (bit >> 6) & 0x03;
 	int _bit = bit & 0x3f;
 
-	return (amd_iommu_dev_table[devid].data[i] & (1UL << _bit)) >> _bit;
+	return (dev_table[devid].data[i] & (1UL << _bit)) >> _bit;
 }
 
+static int get_dev_entry_bit(struct amd_iommu *iommu, u16 devid, u8 bit)
+{
+	struct dev_table_entry *dev_table = get_dev_table(iommu);
+
+	return __get_dev_entry_bit(dev_table, devid, bit);
+}
 
 static bool __copy_device_table(struct amd_iommu *iommu)
 {
@@ -1121,15 +1136,15 @@ static bool copy_device_table(void)
 	return true;
 }
 
-void amd_iommu_apply_erratum_63(u16 devid)
+void amd_iommu_apply_erratum_63(struct amd_iommu *iommu, u16 devid)
 {
 	int sysmgt;
 
-	sysmgt = get_dev_entry_bit(devid, DEV_ENTRY_SYSMGT1) |
-		 (get_dev_entry_bit(devid, DEV_ENTRY_SYSMGT2) << 1);
+	sysmgt = get_dev_entry_bit(iommu, devid, DEV_ENTRY_SYSMGT1) |
+		 (get_dev_entry_bit(iommu, devid, DEV_ENTRY_SYSMGT2) << 1);
 
 	if (sysmgt == 0x01)
-		set_dev_entry_bit(devid, DEV_ENTRY_IW);
+		set_dev_entry_bit(iommu, devid, DEV_ENTRY_IW);
 }
 
 /* Writes the specific IOMMU for a device into the rlookup table */
@@ -1146,21 +1161,21 @@ static void __init set_dev_entry_from_acpi(struct amd_iommu *iommu,
 					   u16 devid, u32 flags, u32 ext_flags)
 {
 	if (flags & ACPI_DEVFLAG_INITPASS)
-		set_dev_entry_bit(devid, DEV_ENTRY_INIT_PASS);
+		set_dev_entry_bit(iommu, devid, DEV_ENTRY_INIT_PASS);
 	if (flags & ACPI_DEVFLAG_EXTINT)
-		set_dev_entry_bit(devid, DEV_ENTRY_EINT_PASS);
+		set_dev_entry_bit(iommu, devid, DEV_ENTRY_EINT_PASS);
 	if (flags & ACPI_DEVFLAG_NMI)
-		set_dev_entry_bit(devid, DEV_ENTRY_NMI_PASS);
+		set_dev_entry_bit(iommu, devid, DEV_ENTRY_NMI_PASS);
 	if (flags & ACPI_DEVFLAG_SYSMGT1)
-		set_dev_entry_bit(devid, DEV_ENTRY_SYSMGT1);
+		set_dev_entry_bit(iommu, devid, DEV_ENTRY_SYSMGT1);
 	if (flags & ACPI_DEVFLAG_SYSMGT2)
-		set_dev_entry_bit(devid, DEV_ENTRY_SYSMGT2);
+		set_dev_entry_bit(iommu, devid, DEV_ENTRY_SYSMGT2);
 	if (flags & ACPI_DEVFLAG_LINT0)
-		set_dev_entry_bit(devid, DEV_ENTRY_LINT0_PASS);
+		set_dev_entry_bit(iommu, devid, DEV_ENTRY_LINT0_PASS);
 	if (flags & ACPI_DEVFLAG_LINT1)
-		set_dev_entry_bit(devid, DEV_ENTRY_LINT1_PASS);
+		set_dev_entry_bit(iommu, devid, DEV_ENTRY_LINT1_PASS);
 
-	amd_iommu_apply_erratum_63(devid);
+	amd_iommu_apply_erratum_63(iommu, devid);
 
 	set_iommu_for_device(iommu, devid);
 }
@@ -2518,8 +2533,8 @@ static void init_device_table_dma(struct amd_iommu_pci_seg *pci_seg)
 		return;
 
 	for (devid = 0; devid <= amd_iommu_last_bdf; ++devid) {
-		set_dev_entry_bit(devid, DEV_ENTRY_VALID);
-		set_dev_entry_bit(devid, DEV_ENTRY_TRANSLATION);
+		__set_dev_entry_bit(dev_table, devid, DEV_ENTRY_VALID);
+		__set_dev_entry_bit(dev_table, devid, DEV_ENTRY_TRANSLATION);
 	}
 }
 
@@ -2539,13 +2554,17 @@ static void __init uninit_device_table_dma(struct amd_iommu_pci_seg *pci_seg)
 
 static void init_device_table(void)
 {
+	struct amd_iommu_pci_seg *pci_seg;
 	u32 devid;
 
 	if (!amd_iommu_irq_remap)
 		return;
 
-	for (devid = 0; devid <= amd_iommu_last_bdf; ++devid)
-		set_dev_entry_bit(devid, DEV_ENTRY_IRQ_TBL_EN);
+	for_each_pci_segment(pci_seg) {
+		for (devid = 0; devid <= amd_iommu_last_bdf; ++devid)
+			__set_dev_entry_bit(pci_seg->dev_table,
+					    devid, DEV_ENTRY_IRQ_TBL_EN);
+	}
 }
 
 static void iommu_init_flags(struct amd_iommu *iommu)
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index ebae64711691..5361cc1f8b6b 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -1607,7 +1607,7 @@ static void clear_dte_entry(struct amd_iommu *iommu, u16 devid)
 	dev_table[devid].data[0]  = DTE_FLAG_V | DTE_FLAG_TV;
 	dev_table[devid].data[1] &= DTE_FLAG_MASK;
 
-	amd_iommu_apply_erratum_63(devid);
+	amd_iommu_apply_erratum_63(iommu, devid);
 }
 
 static void do_attach(struct iommu_dev_data *dev_data,
-- 
2.27.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
