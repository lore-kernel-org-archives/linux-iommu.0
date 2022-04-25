Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE5BCC433EF
	for <iommu@archiver.kernel.org>; Mon, 25 Apr 2022 11:35:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 7ED2B4048F;
	Mon, 25 Apr 2022 11:35:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TvpiGxcrEFei; Mon, 25 Apr 2022 11:35:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 4D810400CE;
	Mon, 25 Apr 2022 11:35:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 379C5C0039;
	Mon, 25 Apr 2022 11:35:24 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 51874C002D
 for <iommu@lists.linux-foundation.org>; Mon, 25 Apr 2022 11:35:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2CE0E815AB
 for <iommu@lists.linux-foundation.org>; Mon, 25 Apr 2022 11:35:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=amd.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NqIKbzKTw__R for <iommu@lists.linux-foundation.org>;
 Mon, 25 Apr 2022 11:35:22 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on20613.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8c::613])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6BE1A81497
 for <iommu@lists.linux-foundation.org>; Mon, 25 Apr 2022 11:35:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RlOgpaexyCNOnYRT8AWaDt410kGdwF0OR1hW4SFD2HSj4UQkcuapjscW6BiFqyO6NJ4OzKf/vXcgGXK9c/tGzpbrJFyxnylAACsJ+1HpoA4loSBze0m+IF9/Stlc5Haq8/3WRHSH/2ubr2hpqkz7PRYYdO9XhGfDsbMxNfJA5/8GBgYOte+A1zL6QZ6yVR+lZ2hK61kUrd3N1rbkKgW5+G2puXTIzKWSmLByChq6BlJg6xbCdDzGfVWh/cM23b4429yByOb9nJejiHetvnxRcIckEN+m2J8FJ5TK2ObC51mpwv5+EMbJ6heJlZmd69P8AvSh1C+lGgF5rZu34uNfGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OQycysHcLvn/h2Lh4geO6t9zUpzixLJE4YHcuHSEZtY=;
 b=POx2ht7ULdTio1VBaNtgmYenVzIQNCKXy/xXPY3b6vORDca9y85gbaeSm6ghSn60+XZ5ZsHN/uVM478ZLGvomuk64JatWD5emF3HeBwdIqsiU2gd+oDLttsNZAfrYrH77MNOn4OuiPtn1DfFOwTElKYjJlvugCpqEH9QZiBF/hbgX8tztocDsVw8lJZmzvgIo2ul2V8E2O5yurOBz4Td/fhdGvcg/ICjqCBzQhbDDB2nJ/JpLuZaI4o7DryXgU1Cbl74Lkbu3Y++WckB1Uozmp9fZ849T1pHp9UT696L3IxORaHwsny5WmM1wonSqg+yHsnOETIHiTcFLNLbRMB3ZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux-foundation.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OQycysHcLvn/h2Lh4geO6t9zUpzixLJE4YHcuHSEZtY=;
 b=09knGXk9OZkMi52l5ZWNcnL/0n24FFVEJHuZ0+Jfaf5al3T2rznWdOVYUw02NwD20wfbVowuyxvQM6wi4CC9ZRV0AqvqD1JUWSCouVKsgQURCz1IF1ZMNwIZ6KcPDs1SQuFptZyDJhcBqVO02AASGrSWKo+WmPuz1p2x7r+gXok=
Received: from BN9PR03CA0288.namprd03.prod.outlook.com (2603:10b6:408:f5::23)
 by MWHPR1201MB0173.namprd12.prod.outlook.com (2603:10b6:301:56::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13; Mon, 25 Apr
 2022 11:35:19 +0000
Received: from BN8NAM11FT004.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f5:cafe::f9) by BN9PR03CA0288.outlook.office365.com
 (2603:10b6:408:f5::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13 via Frontend
 Transport; Mon, 25 Apr 2022 11:35:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT004.mail.protection.outlook.com (10.13.176.164) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5186.14 via Frontend Transport; Mon, 25 Apr 2022 11:35:18 +0000
Received: from kali.amdval.net (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 25 Apr
 2022 06:35:16 -0500
To: <iommu@lists.linux-foundation.org>
Subject: [PATCH v2 01/37] iommu/amd: Update struct iommu_dev_data defination
Date: Mon, 25 Apr 2022 17:03:39 +0530
Message-ID: <20220425113415.24087-2-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220425113415.24087-1-vasant.hegde@amd.com>
References: <20220425113415.24087-1-vasant.hegde@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ca8f1b31-4f53-48c1-c993-08da26aface2
X-MS-TrafficTypeDiagnostic: MWHPR1201MB0173:EE_
X-Microsoft-Antispam-PRVS: <MWHPR1201MB0173163CF5EA1B513022629287F89@MWHPR1201MB0173.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oylYVVVJOrJRx3dc1AbjA+NeFdxu2B8DTMH1ak8N7cwtKSCQfMaWmLwqShIpAYzFt7e+r1+EXDoy7/pCtiqX7ntPTIrbV0oY1VMmDER2dQMhKGkK2MWeIkUlLGGdHLa8IVzqM6m0uDmUGk/w+u9mPBS2JCK4nCaFogjRWxi8AiS5sBCGlYqaPgWvbiOwtFyLD4xjdP6H+gJgOFopqrBvy4Prc9IDyWEGFpFWgZCOjSnpY9qFzieovT+jVIZw27ZbaBGkaN2PY04z+d4WKg+kRKYf2VIsiVNKVpDvHTySrj6I+UZsZYA2cidpbM1dMhEqkLo36wAuaxvEX9lZ2wA8M4aEdA44qKC0CpfgcadgBV6nX5dobjn6od2yaja7YIXxnAOXoK5DDKOzIgvEywch+gAUN06J5jQtUXDhnCM8/Qp/H5VwHLitOkgk2d49bQFvaeIq98LzLeGk+P2oXUlcGPVNyKuTU/TPcRCwYOgVgkkU/vmPtAeGERtJxVXEPiOSotMGSfIkfxw/47+Khzw9akgLaM3f5R9BoDOWMP+mVtIZum3HZPDN1yDqIPYDONGJTYXCVKer27arKvjIn9bxctIWBTkssrOozDznE3VhVLyMalyuxlNg1qw8QRgBAf31AWyYDruwjVkjYizmpUobYzJ9JaWZkyW2+5P+yvWycSuYgH/xfWOAX0qEQUY3wsVntx6uC/x9ByCYmdn6FUnhBQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(2616005)(1076003)(426003)(336012)(186003)(16526019)(47076005)(5660300002)(316002)(54906003)(36756003)(6666004)(36860700001)(82310400005)(26005)(8676002)(83380400001)(6916009)(356005)(44832011)(70206006)(4326008)(8936002)(2906002)(508600001)(40460700003)(86362001)(15650500001)(81166007)(70586007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2022 11:35:18.7241 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ca8f1b31-4f53-48c1-c993-08da26aface2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT004.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0173
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

Replace "struct pci_dev" member with "struct device" and use to_pci_dev()
to get pci device reference as needed. Also adjust setup_aliases() and
clone_aliases() function.

No functional change intended.

Co-developed-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/amd_iommu_types.h |  2 +-
 drivers/iommu/amd/iommu.c           | 32 +++++++++++++++++------------
 2 files changed, 20 insertions(+), 14 deletions(-)

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
index a1ada7bff44e..cf57ffcc8d54 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -188,10 +188,13 @@ static int clone_alias(struct pci_dev *pdev, u16 alias, void *data)
 	return 0;
 }
 
-static void clone_aliases(struct pci_dev *pdev)
+static void clone_aliases(struct device *dev)
 {
-	if (!pdev)
+	struct pci_dev *pdev;
+
+	if (!dev_is_pci(dev))
 		return;
+	pdev = to_pci_dev(dev);
 
 	/*
 	 * The IVRS alias stored in the alias table may not be
@@ -203,14 +206,14 @@ static void clone_aliases(struct pci_dev *pdev)
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
@@ -221,9 +224,7 @@ static struct pci_dev *setup_aliases(struct device *dev)
 	    PCI_BUS_NUM(ivrs_alias) == pdev->bus->number)
 		pci_add_dma_alias(pdev, ivrs_alias & 0xff, 1);
 
-	clone_aliases(pdev);
-
-	return pdev;
+	clone_aliases(dev);
 }
 
 static struct iommu_dev_data *find_dev_data(u16 devid)
@@ -331,7 +332,8 @@ static int iommu_init_device(struct device *dev)
 	if (!dev_data)
 		return -ENOMEM;
 
-	dev_data->pdev = setup_aliases(dev);
+	dev_data->dev = dev;
+	setup_aliases(dev);
 
 	/*
 	 * By default we use passthrough mode for IOMMUv2 capable device.
@@ -1232,13 +1234,17 @@ static int device_flush_dte_alias(struct pci_dev *pdev, u16 alias, void *data)
 static int device_flush_dte(struct iommu_dev_data *dev_data)
 {
 	struct amd_iommu *iommu;
+	struct pci_dev *pdev = NULL;
 	u16 alias;
 	int ret;
 
 	iommu = amd_iommu_rlookup_table[dev_data->devid];
 
-	if (dev_data->pdev)
-		ret = pci_for_each_dma_alias(dev_data->pdev,
+	if (dev_is_pci(dev_data->dev))
+		pdev = to_pci_dev(dev_data->dev);
+
+	if (pdev)
+		ret = pci_for_each_dma_alias(pdev,
 					     device_flush_dte_alias, iommu);
 	else
 		ret = iommu_flush_dte(iommu, dev_data->devid);
@@ -1561,7 +1567,7 @@ static void do_attach(struct iommu_dev_data *dev_data,
 	/* Update device table */
 	set_dte_entry(dev_data->devid, domain,
 		      ats, dev_data->iommu_v2);
-	clone_aliases(dev_data->pdev);
+	clone_aliases(dev_data->dev);
 
 	device_flush_dte(dev_data);
 }
@@ -1577,7 +1583,7 @@ static void do_detach(struct iommu_dev_data *dev_data)
 	dev_data->domain = NULL;
 	list_del(&dev_data->list);
 	clear_dte_entry(dev_data->devid);
-	clone_aliases(dev_data->pdev);
+	clone_aliases(dev_data->dev);
 
 	/* Flush the DTE entry */
 	device_flush_dte(dev_data);
@@ -1818,7 +1824,7 @@ static void update_device_table(struct protection_domain *domain)
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
