Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 879F2C433EF
	for <iommu@archiver.kernel.org>; Mon,  4 Apr 2022 10:01:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 45C99402F5;
	Mon,  4 Apr 2022 10:01:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mNnl1D1iv9JY; Mon,  4 Apr 2022 10:01:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 1BD434002B;
	Mon,  4 Apr 2022 10:01:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0425FC002C;
	Mon,  4 Apr 2022 10:01:57 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 99694C0012
 for <iommu@lists.linux-foundation.org>; Mon,  4 Apr 2022 10:01:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 796D5819B8
 for <iommu@lists.linux-foundation.org>; Mon,  4 Apr 2022 10:01:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=amd.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Fuujb4o3pmS1 for <iommu@lists.linux-foundation.org>;
 Mon,  4 Apr 2022 10:01:54 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2061d.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::61d])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9FDC68187F
 for <iommu@lists.linux-foundation.org>; Mon,  4 Apr 2022 10:01:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X9KZSyuktrjlnjQ4yUFSal7lLFlMt/F/BUbe2fuZl8pbA5vF2IB1sVXQ/LQCizQlCEbM/LI4PJbhkkYF38OVJZi/fTOg94vBSy+pNavW62m+cQRgq0zhZ/RNZSG4XI9fa5J23o7FbbvGVLvS4BlTP1CS5dHd9SLjV1auxGkoE+p2074d/dpejJT6rX44QLZKX9U7zJfYngfbG9/bIB8JS1x/pxokYwUsdoz0dJDiR3ySIQbryPz9tGP00m2HUUnAEEeAeMrDxsgv7fa5Mfq13RQXf8DjzrBmKJxKNkYto1842Ui4RIeZdaks0O44mTONgV6ZZBMKk7noW1zx4S6wyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GqFB+qy+l7atMnGPRWrBouoYbjlI+IkU5dDGzQhifQs=;
 b=LGe08OYc+qkF0/POHqGBH57AZdGbXSrkSmAhUREdzBTbTsOnYODstqSNMIkc8Xoco3Hfvp9vByQuFruHKonNdZSpuISThMJm8Co0eXdSiursmFfr9gfzeQw+aa9meHr0TXHV8lbnTT33PEZa2HbdxTyljvkKFMqOBEw07rVgoa5OLzNlYbTn0/rxMKM4BlMsLwvUk96FnACG9WmKXeTQrKs34T7D7KwokE+7tVjouZ3IdA1nIu1ip4MZwjIc6RP5i7s2nz1E28jp+j+jLrtrVVeuPBvhnb1Z4BMBukPbKT75b3GFa0PtIWKZS8LnTT6twKNWOhIzlLpeQe2idZr0GQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux-foundation.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GqFB+qy+l7atMnGPRWrBouoYbjlI+IkU5dDGzQhifQs=;
 b=5Drfxq6URGP54VMOkZmK779gJrRQNMblbTIB4W55X6lzf9HVqwJReFVfE3M7fYdREYEgTwsSKdWDgRbD7MBb4e5oLEkmWNdGzoR71Ts7SSNCCfLSPPwIuH6WcDLhKPSjRBaBRHCBZculGoqbnmTLUMY0tTAx8L0S8h6ZdZKFhpI=
Received: from BN9PR03CA0575.namprd03.prod.outlook.com (2603:10b6:408:10d::10)
 by CY4PR12MB1846.namprd12.prod.outlook.com (2603:10b6:903:11b::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Mon, 4 Apr
 2022 10:01:51 +0000
Received: from BN8NAM11FT036.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10d:cafe::ed) by BN9PR03CA0575.outlook.office365.com
 (2603:10b6:408:10d::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31 via Frontend
 Transport; Mon, 4 Apr 2022 10:01:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT036.mail.protection.outlook.com (10.13.177.168) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5123.19 via Frontend Transport; Mon, 4 Apr 2022 10:01:50 +0000
Received: from kali.amdval.net (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 4 Apr
 2022 05:01:48 -0500
To: <iommu@lists.linux-foundation.org>, <joro@8bytes.org>
Subject: [RESEND PATCH v1 04/37] iommu/amd: Introduce per PCI segment rlookup
 table
Date: Mon, 4 Apr 2022 15:29:50 +0530
Message-ID: <20220404100023.324645-5-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220404100023.324645-1-vasant.hegde@amd.com>
References: <20220404100023.324645-1-vasant.hegde@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8b35b544-f1ac-421c-3dbd-08da16222367
X-MS-TrafficTypeDiagnostic: CY4PR12MB1846:EE_
X-Microsoft-Antispam-PRVS: <CY4PR12MB1846D2D0F5DDBB444F7B863687E59@CY4PR12MB1846.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EPYHR7uElI40AwDtqTS/BcJ8wUsCiXqvp/L71IUURBxLpmJ5pnH8OUJTnYZZOvDa8KozSecp37JHSulCeuG3dN+ZtGDB9cXlYJQTvKT0Jq45MSyKkCRVDR/2Yd0iDLdl18ssDQQjr1lLCj4KPPEaFIyPY64ncCU0ikFNvTNnm5MAFbPJZanaTMmQNMkyzxUibanrNGeSg7fz+k49jALZDvanw2fzXKihSiKT8csLRnd6roCDtr+nc5Dj9w6PBGyAL03rNPKjiSFnqHOkEc+uVWsbYsSDY3MG0AZpPnMYVL/ghfVpBAyimK/TFnBVJ/1PR/aX/0YBDOX1577S/bjpd99GQPsku4M55g+ejlknr4r3vAG8JJTSDIAclkxCi7LmMohsBllE+VSS4NSgbYtRiuOPym51coBQl+sRTDhsTU7s6kh2SNcaDHaujL8x4+ffKNXo4KlK6cQB86R1VPCSXkwPRKGyG3Fdht9Qwl8WH3J9Ua8pdVarOo/b311ASvUL9SE9EcAp2c4IuNZlcLzuockp/NuC+llsZ/ZKL8++osjWmOguHPe80aDJl0g+1PTMWocjAJjfZbfGBHDPMqXOrulKOtxDH3WCk4LZfFsC0DDwGCmdDpfFVYXpQ4Ev4br88wTHpwEts0GYJcIwYlfm+/bAng2vp0kkc3QABBf4Gj3/XlXCfD4/XgMEPrjtiAzkrku3c7xDxXpxwegh/DusDg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(4326008)(356005)(8676002)(5660300002)(6666004)(110136005)(54906003)(316002)(508600001)(16526019)(83380400001)(70206006)(47076005)(1076003)(426003)(336012)(186003)(26005)(70586007)(36860700001)(36756003)(44832011)(81166007)(40460700003)(2616005)(86362001)(8936002)(2906002)(82310400004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2022 10:01:50.4389 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b35b544-f1ac-421c-3dbd-08da16222367
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT036.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1846
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

This will replace global rlookup table (amd_iommu_rlookup_table).
Also add helper functions to set/get rlookup table for the given device.

Co-developed-by: Vasant Hegde <vasant.hegde@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/amd_iommu.h       |  1 +
 drivers/iommu/amd/amd_iommu_types.h |  8 ++++++
 drivers/iommu/amd/init.c            | 23 +++++++++++++++
 drivers/iommu/amd/iommu.c           | 44 +++++++++++++++++++++++++++++
 4 files changed, 76 insertions(+)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index 885570cd0d77..2947239700ce 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -19,6 +19,7 @@ extern int amd_iommu_init_devices(void);
 extern void amd_iommu_uninit_devices(void);
 extern void amd_iommu_init_notifier(void);
 extern int amd_iommu_init_api(void);
+extern void amd_iommu_set_rlookup_table(struct amd_iommu *iommu, u16 devid);
 
 #ifdef CONFIG_AMD_IOMMU_DEBUGFS
 void amd_iommu_debugfs_setup(struct amd_iommu *iommu);
diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 404feb7995cc..9c008662be1b 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -486,6 +486,7 @@ struct amd_iommu_fault {
 };
 
 
+struct amd_iommu;
 struct iommu_domain;
 struct irq_domain;
 struct amd_irte_ops;
@@ -549,6 +550,13 @@ struct amd_iommu_pci_seg {
 	 * page table root pointer.
 	 */
 	struct dev_table_entry *dev_table;
+
+	/*
+	 * The rlookup iommu table is used to find the IOMMU which is
+	 * responsible for a specific device. It is indexed by the PCI
+	 * device id.
+	 */
+	struct amd_iommu **rlookup_table;
 };
 
 /*
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 0fd1071bfc85..a2efc02ba80a 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -663,6 +663,26 @@ static inline void free_dev_table(struct amd_iommu_pci_seg *pci_seg)
 	pci_seg->dev_table = NULL;
 }
 
+/* Allocate per PCI segment IOMMU rlookup table. */
+static inline int __init alloc_rlookup_table(struct amd_iommu_pci_seg *pci_seg)
+{
+	pci_seg->rlookup_table = (void *)__get_free_pages(
+						GFP_KERNEL | __GFP_ZERO,
+						get_order(rlookup_table_size));
+	if (pci_seg->rlookup_table == NULL)
+		return -ENOMEM;
+
+	return 0;
+}
+
+static inline void free_rlookup_table(struct amd_iommu_pci_seg *pci_seg)
+{
+	free_pages((unsigned long)pci_seg->rlookup_table,
+		   get_order(rlookup_table_size));
+	pci_seg->rlookup_table = NULL;
+}
+
+
 /*
  * Allocates the command buffer. This buffer is per AMD IOMMU. We can
  * write commands to that buffer later and the IOMMU will execute them
@@ -1489,6 +1509,8 @@ static struct amd_iommu_pci_seg *__init alloc_pci_segment(u16 id)
 
 	if (alloc_dev_table(pci_seg))
 		return NULL;
+	if (alloc_rlookup_table(pci_seg))
+		return NULL;
 
 	return pci_seg;
 }
@@ -1511,6 +1533,7 @@ static void __init free_pci_segment(void)
 
 	for_each_pci_segment_safe(pci_seg, next) {
 		list_del(&pci_seg->list);
+		free_rlookup_table(pci_seg);
 		free_dev_table(pci_seg);
 		kfree(pci_seg);
 	}
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 52058c0d4f62..a8baa64c8f9c 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -146,6 +146,50 @@ struct dev_table_entry *get_dev_table(struct amd_iommu *iommu)
 	return dev_table;
 }
 
+static inline u16 get_device_segment(struct device *dev)
+{
+	u16 seg;
+
+	if (dev_is_pci(dev)) {
+		struct pci_dev *pdev = to_pci_dev(dev);
+
+		seg = pci_domain_nr(pdev->bus);
+	} else {
+		u32 devid = get_acpihid_device_id(dev, NULL);
+
+		seg = (devid >> 16) & 0xffff;
+	}
+
+	return seg;
+}
+
+/* Writes the specific IOMMU for a device into the PCI segment rlookup table */
+void amd_iommu_set_rlookup_table(struct amd_iommu *iommu, u16 devid)
+{
+	struct amd_iommu_pci_seg *pci_seg = iommu->pci_seg;
+
+	pci_seg->rlookup_table[devid] = iommu;
+}
+
+static struct amd_iommu *__rlookup_amd_iommu(u16 seg, u16 devid)
+{
+	struct amd_iommu_pci_seg *pci_seg;
+
+	for_each_pci_segment(pci_seg) {
+		if (pci_seg->id == seg)
+			return pci_seg->rlookup_table[devid];
+	}
+	return NULL;
+}
+
+static struct amd_iommu *rlookup_amd_iommu(struct device *dev)
+{
+	u16 seg = get_device_segment(dev);
+	u16 devid = get_device_id(dev);
+
+	return __rlookup_amd_iommu(seg, devid);
+}
+
 static struct protection_domain *to_pdomain(struct iommu_domain *dom)
 {
 	return container_of(dom, struct protection_domain, domain);
-- 
2.27.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
