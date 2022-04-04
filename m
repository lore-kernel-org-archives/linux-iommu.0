Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E30A6C433EF
	for <iommu@archiver.kernel.org>; Mon,  4 Apr 2022 09:43:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A9CFC60D88;
	Mon,  4 Apr 2022 09:43:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id o7hBs4S6P6-c; Mon,  4 Apr 2022 09:43:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id E8443607DE;
	Mon,  4 Apr 2022 09:43:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D1C2DC002C;
	Mon,  4 Apr 2022 09:43:43 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5D3E4C0012
 for <iommu@lists.linux-foundation.org>; Mon,  4 Apr 2022 09:43:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3B9ED40868
 for <iommu@lists.linux-foundation.org>; Mon,  4 Apr 2022 09:43:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=amd.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ntQzdcmCxkpM for <iommu@lists.linux-foundation.org>;
 Mon,  4 Apr 2022 09:43:37 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2060b.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::60b])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 556E54148D
 for <iommu@lists.linux-foundation.org>; Mon,  4 Apr 2022 09:43:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bZzPrSXkhERqX0A2GJYVNXX54lCnQl36VnSUd7tmsqkpAeWP6OCERM9qXc0cR4TdK8ha5NnDe4oPHjtcLz5qICTSMiQ9qwdlNMKnJt1111HHMKOgG9+3ROLVtqTvGd2yX8Sbqa5v4TPAMkkubg9YYXAjEe2zDBbopu9tHXXyZvG1aO0J7/FWHUdj4inSbI+n0ZXU70qDGJAxV6w8QFgiy/3QmP4qQFbTi72vSyuAxdKRpHuEYFL/ebV9mNCko5QTftwP1p+CfzW0ENGaQp3xgSmDSJvhH3+ARDeEIC48wSAyNk2HhosdxPRAlU3vSXuD+xJq8A233p9snxbqmcSC4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=591+3mGhDul/SENO6jS6G+P/7KQGBFM0sJuW7a2tlsQ=;
 b=ef7slCI8VP6enosOeDgAVpgMjLgbxpmeHkpCBm+1IUXe2nFXFHZwiExHK0dLFanE7nQi4uZAiFX0ROjnD0cQCww4Nr/cglFySbNG5tcrVM/TOQ07DBx6mcanydwp50RZudbEaPYkHku1MTd653E99CZWOKjW17townSbWWxBjttyItlRJXfsG3zvxK8l13hBSGxLyNffYRZKVcetnqp3VJYo0GTKIL7PTeOEaRJfLmKQF+Uu7ePdeun6JHpOvLg61EsaF+EvSYbpOcNWkQuM61F98zJljKtXIPPIEJso2hAcowmenCOEMZBCJg+QWbPp1/O7X9AzENMNxb24owBcCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux-foundation.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=591+3mGhDul/SENO6jS6G+P/7KQGBFM0sJuW7a2tlsQ=;
 b=ioTsU73EiL6aaEgAouM3L0Ayqul6fP6uYYoT6rPrjYHDsoVb2BlLNMwNSn75qqAsTrESoLoU388wrClUc5tUNuTBPo2GHvDXaHmSrBXp9bwH+6LHpeUcT+OuyItVXRUppUuG/SiCUC/EwpPstEawpNEsE+yCKe8CjIz6T8vbQhE=
Received: from MW4PR03CA0106.namprd03.prod.outlook.com (2603:10b6:303:b7::21)
 by BL0PR12MB2498.namprd12.prod.outlook.com (2603:10b6:207:40::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Mon, 4 Apr
 2022 09:43:34 +0000
Received: from CO1NAM11FT020.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b7:cafe::ab) by MW4PR03CA0106.outlook.office365.com
 (2603:10b6:303:b7::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31 via Frontend
 Transport; Mon, 4 Apr 2022 09:43:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT020.mail.protection.outlook.com (10.13.174.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5123.19 via Frontend Transport; Mon, 4 Apr 2022 09:43:33 +0000
Received: from kali.amdval.net (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 4 Apr
 2022 04:43:30 -0500
To: <iommu@lists.linux-foundation.org>, <joro@8bytes.org>
Subject: [PATCH v1 01/37] iommu/amd: Update struct iommu_dev_data defination
Date: Mon, 4 Apr 2022 15:10:53 +0530
Message-ID: <20220404094129.323642-2-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220404094129.323642-1-vasant.hegde@amd.com>
References: <20220404094129.323642-1-vasant.hegde@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bd978153-9f0f-4f75-557a-08da161f957a
X-MS-TrafficTypeDiagnostic: BL0PR12MB2498:EE_
X-Microsoft-Antispam-PRVS: <BL0PR12MB24981A13A19433FC77879C9787E59@BL0PR12MB2498.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: L7BJ08LTN4k4yg06t0sheC2PvpoWvICArKDghNqBFsCnx+OdMfSzeID3HDvXVtYkPkGDLEk++lbdooqQj1SlMhD2z7k/+9218OaKA6I4JDGiAgh8ejpqwiso/jTvcEfzWCU7BgsHIUiSLriOzLp1yG8w9op2G5Rqke6YPPUllIiSUCEaj/DwnsmEkLbEpZ6KzommrHXgySR0sD9DYJ1QXf6LCmDfChzr7xAO2zhpnh2uD8WnqbcxW8HVR3N2IJKloSaG8OrizdS7HbFIxAy+T/o+NDT2ZAsFnbguIMY51K1zQvBc0xwptfr0wIQ0OAnzAKYR2GLylM2aIL7BMRBu824x4o+WENbwUSfTLR3O8rZic2RGXPbvJD+R+U+icCGSPoFz05ojNlYNz7qgmT1rHlhrOK77IHwcqw3opMUQUtdVVF94zAYbV6g8QNW8cUNuhK7O89eMOw37dy36h3bIqxNO36IVGmkXcQrWgiknprqdmgz0QCwH+KC3o4Vz3sPTVKZ9SzSCbVva1hCVtP2dZDi1hE4Uauw1R+H/eSMcnNNTnBM9PdxpCAjsQ2/wGNx2kCoQFc3u/vkENWAnCpePEey8EXTP+dQIAkkG7vvjRe+dAYe/w0u6s/te/ZliD23aY48yE+I/JGePTig7rkv2GaFFzi+2WGylB06yr2KKbK4+lCPFhWDjJ63XPRmDl0AEQ+Xza3KNQEiPQm/hN7IfzQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(8936002)(44832011)(426003)(336012)(15650500001)(508600001)(47076005)(86362001)(5660300002)(2616005)(36860700001)(40460700003)(1076003)(36756003)(316002)(16526019)(186003)(8676002)(54906003)(26005)(110136005)(82310400004)(2906002)(356005)(83380400001)(81166007)(6666004)(70206006)(70586007)(4326008)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2022 09:43:33.2091 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bd978153-9f0f-4f75-557a-08da161f957a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT020.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2498
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

struct iommu_dev_data contains member "pdev" to point to pci_dev. This is
valid for only PCI devices and for other devices this will be NULL. This
causes unnecessary "pdev != NULL" check at various places.

Replace "struct pci_dev" member with "struct device" and use
to_pci_dev() to get pci device reference as needed. Also adjust
setup_aliases() and clone_aliases() function.

No functional change intended.

Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/amd_iommu_types.h |  2 +-
 drivers/iommu/amd/iommu.c           | 27 +++++++++++++++------------
 2 files changed, 16 insertions(+), 13 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 47108ed44fbb..06235b7cb13d 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -685,7 +685,7 @@ struct iommu_dev_data {
 	struct list_head list;		  /* For domain->dev_list */
 	struct llist_node dev_data_list;  /* For global dev_data_list */
 	struct protection_domain *domain; /* Domain the device is bound to */
-	struct pci_dev *pdev;
+	struct device *dev;
 	u16 devid;			  /* PCI Device ID */
 	bool iommu_v2;			  /* Device can make use of IOMMUv2 */
 	struct {
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index a1ada7bff44e..7a29e2645dc4 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -188,8 +188,10 @@ static int clone_alias(struct pci_dev *pdev, u16 alias, void *data)
 	return 0;
 }
 
-static void clone_aliases(struct pci_dev *pdev)
+static void clone_aliases(struct device *dev)
 {
+	struct pci_dev *pdev = to_pci_dev(dev);
+
 	if (!pdev)
 		return;
 
@@ -203,14 +205,14 @@ static void clone_aliases(struct pci_dev *pdev)
 	pci_for_each_dma_alias(pdev, clone_alias, NULL);
 }
 
-static struct pci_dev *setup_aliases(struct device *dev)
+static void setup_aliases(struct device *dev)
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
 	u16 ivrs_alias;
 
 	/* For ACPI HID devices, there are no aliases */
 	if (!dev_is_pci(dev))
-		return NULL;
+		return;
 
 	/*
 	 * Add the IVRS alias to the pci aliases if it is on the same
@@ -221,9 +223,7 @@ static struct pci_dev *setup_aliases(struct device *dev)
 	    PCI_BUS_NUM(ivrs_alias) == pdev->bus->number)
 		pci_add_dma_alias(pdev, ivrs_alias & 0xff, 1);
 
-	clone_aliases(pdev);
-
-	return pdev;
+	clone_aliases(dev);
 }
 
 static struct iommu_dev_data *find_dev_data(u16 devid)
@@ -331,7 +331,8 @@ static int iommu_init_device(struct device *dev)
 	if (!dev_data)
 		return -ENOMEM;
 
-	dev_data->pdev = setup_aliases(dev);
+	dev_data->dev = dev;
+	setup_aliases(dev);
 
 	/*
 	 * By default we use passthrough mode for IOMMUv2 capable device.
@@ -1232,13 +1233,15 @@ static int device_flush_dte_alias(struct pci_dev *pdev, u16 alias, void *data)
 static int device_flush_dte(struct iommu_dev_data *dev_data)
 {
 	struct amd_iommu *iommu;
+	struct pci_dev *pdev;
 	u16 alias;
 	int ret;
 
 	iommu = amd_iommu_rlookup_table[dev_data->devid];
 
-	if (dev_data->pdev)
-		ret = pci_for_each_dma_alias(dev_data->pdev,
+	pdev = to_pci_dev(dev_data->dev);
+	if (pdev)
+		ret = pci_for_each_dma_alias(pdev,
 					     device_flush_dte_alias, iommu);
 	else
 		ret = iommu_flush_dte(iommu, dev_data->devid);
@@ -1561,7 +1564,7 @@ static void do_attach(struct iommu_dev_data *dev_data,
 	/* Update device table */
 	set_dte_entry(dev_data->devid, domain,
 		      ats, dev_data->iommu_v2);
-	clone_aliases(dev_data->pdev);
+	clone_aliases(dev_data->dev);
 
 	device_flush_dte(dev_data);
 }
@@ -1577,7 +1580,7 @@ static void do_detach(struct iommu_dev_data *dev_data)
 	dev_data->domain = NULL;
 	list_del(&dev_data->list);
 	clear_dte_entry(dev_data->devid);
-	clone_aliases(dev_data->pdev);
+	clone_aliases(dev_data->dev);
 
 	/* Flush the DTE entry */
 	device_flush_dte(dev_data);
@@ -1818,7 +1821,7 @@ static void update_device_table(struct protection_domain *domain)
 	list_for_each_entry(dev_data, &domain->dev_list, list) {
 		set_dte_entry(dev_data->devid, domain,
 			      dev_data->ats.enabled, dev_data->iommu_v2);
-		clone_aliases(dev_data->pdev);
+		clone_aliases(dev_data->dev);
 	}
 }
 
-- 
2.27.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
