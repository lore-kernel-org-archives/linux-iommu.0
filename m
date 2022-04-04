Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 148BFC433EF
	for <iommu@archiver.kernel.org>; Mon,  4 Apr 2022 10:01:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id CA85B819B8;
	Mon,  4 Apr 2022 10:01:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uV2xeH6fI4qD; Mon,  4 Apr 2022 10:01:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 7E5348187F;
	Mon,  4 Apr 2022 10:01:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 660D5C002C;
	Mon,  4 Apr 2022 10:01:11 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 198B9C0012
 for <iommu@lists.linux-foundation.org>; Mon,  4 Apr 2022 10:01:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 073AB607F7
 for <iommu@lists.linux-foundation.org>; Mon,  4 Apr 2022 10:01:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=amd.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id EwMo510ykScp for <iommu@lists.linux-foundation.org>;
 Mon,  4 Apr 2022 10:01:09 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2060a.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::60a])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 11CCA607F4
 for <iommu@lists.linux-foundation.org>; Mon,  4 Apr 2022 10:01:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ksfEth3+ihYda3LoMDIDLPNykz/fPb9mvcEt7A4cshOlk1o3aoojOBGxXy5NxFCadUp7MB3WZn0fVPw51r0xSu1fYAtFmPNKHXBiuyQ5vn49zZw4lkGh5s+QwM5Bzsk7bNDmoBPRPhAH41TX+KI87gh0CykkzbcRujtmii5kCRlCpHTID8hiHKvlEFZfKxMWxAL+uVdkt2vdZ5WqYzt3McrYKs3ZGxG/EKpApe6i0rkieJ3z/IOgixPnYzr9UmCxB43z/dJ3+usoth2sJrxmDzjUNeDKQhkGPxYDcwCvqc3nbRb4uDpWHq0SWl3Gj92qFCpf0OAeEPPBTqax0irUfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=591+3mGhDul/SENO6jS6G+P/7KQGBFM0sJuW7a2tlsQ=;
 b=cOWN0wfv4MyFz8riJwvY9x25WYiPh5mbdZeDRoJPcf7tfkvXZYD113W99Wn3oFZg7g059TLy2itULg1ZZ7v/I+bDMdNfEuUAurcFchepjO/1zhpoOG0G69xTTl+yvG1OK5hVHQg3H/Y/N/yze69CkYZf/ftVsix2Gf7KYo5qN+dOZL1d1LdThrX6ZpFIow+0jJMPUJnEg6luwkOl0DCpmblVD0VQA/31F/sUvtl9NeNBjZGPHiKdvWx/+GDivGNLvgozAqTSJdP4ER9XxXJHS1gPiQb9Ao3HlB3zG4nqzvT9JQpLd2Vvj38+qZ5U3869otb/sdOWM95+c2e2wXXASA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux-foundation.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=591+3mGhDul/SENO6jS6G+P/7KQGBFM0sJuW7a2tlsQ=;
 b=iriJBa6t/rlexp58y/yK8TQ2KSSz0y8vL6ec/xYriSCRH4N2zmzdteLKXxamXe6Ecn+hsmSUZqnYYPJZtA8u13I70MU7Gwi2Jpuq8YqpTF2CNI296eWLT82LdcVmwbAlOctjm2hKTGE7dpdgtnN1TGc+hoRPW1qXr65mkiaGm7k=
Received: from BN7PR06CA0046.namprd06.prod.outlook.com (2603:10b6:408:34::23)
 by CH2PR12MB4229.namprd12.prod.outlook.com (2603:10b6:610:a5::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Mon, 4 Apr
 2022 10:01:06 +0000
Received: from BN8NAM11FT006.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:34:cafe::84) by BN7PR06CA0046.outlook.office365.com
 (2603:10b6:408:34::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31 via Frontend
 Transport; Mon, 4 Apr 2022 10:01:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT006.mail.protection.outlook.com (10.13.177.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5123.19 via Frontend Transport; Mon, 4 Apr 2022 10:01:05 +0000
Received: from kali.amdval.net (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 4 Apr
 2022 05:01:03 -0500
To: <iommu@lists.linux-foundation.org>, <joro@8bytes.org>
Subject: [RESEND PATCH v1 01/37] iommu/amd: Update struct iommu_dev_data
 defination
Date: Mon, 4 Apr 2022 15:29:47 +0530
Message-ID: <20220404100023.324645-2-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220404100023.324645-1-vasant.hegde@amd.com>
References: <20220404100023.324645-1-vasant.hegde@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d474b0e7-6b53-4eb4-526b-08da162208c2
X-MS-TrafficTypeDiagnostic: CH2PR12MB4229:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB422994EE12B932027163F8B687E59@CH2PR12MB4229.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FQQC2Tn25x8KHnFXTK04GWTwgg64imvjRqjPcFJeBPvVDpG/+7lhn+jNvIEues9r2Z0yAxSGdWDKWJeszXubP2xig/dZ9DH6tKu9K1Q7vQRzqa25QDdeCwc2h/5Og1z8h0zgBD9fJyAfuT0PNLfbpQNZHKXjHmT4JiMsyhbLa/2SGTzFEn+ZfvkAiryFD0gxy6umtnR5W9aCx2p4UMg4A2DvxAthVt+jEwljIOxY2Jz7ZTpT68Ep/O+odvJEpXSrtDgy8qxsLlSeX4gIFUC1Mz27v4Cjaf5cJvXAjTnTCDp/8K26W8kRep3nxl/jltfJt7K8j+yPAtT0X1gT1MWvdPs8O3iC7l9RQeMdqXtGKzk0Kk7ZinleY0ex4a9dRE6BELbNFTfOd6bsKkLpedc/gCJrd32ZLHHrVZ77eO+8yergFKFJ5cz5sUFelXvg3oMbpguH5LScWxpM5dl0wFp+8MjKcOjjW1f5XQSkAskJ16ZOtdnR3V78DzicXVCOwrQLDfYxce3p2M1vD50CxEzQjjcxF9m8DqCP/hC/eYwKXpsP/b/FifqVxv47ZvIdXxrvb0pTjGla48BH7S4x7WTcVaUIlEGX0ZMfqtqn6vhYtbqc2FQHT7nGc7kk1dQ1Ib8758GZAjo0wUqcQn2LDzU8Gh59brtZB3idvknV2dF7+O/NF2f2uCfgCMmJjc1LdK9VTekarkvCzeFUn8kjUFmKCw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(508600001)(6666004)(36756003)(83380400001)(86362001)(16526019)(26005)(186003)(336012)(426003)(4326008)(82310400004)(70586007)(1076003)(2616005)(8676002)(44832011)(8936002)(40460700003)(15650500001)(70206006)(5660300002)(54906003)(2906002)(316002)(110136005)(36860700001)(81166007)(47076005)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2022 10:01:05.7217 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d474b0e7-6b53-4eb4-526b-08da162208c2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT006.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4229
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
