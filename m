Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA559C433FE
	for <iommu@archiver.kernel.org>; Wed, 11 May 2022 07:22:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 779A14060C;
	Wed, 11 May 2022 07:22:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lAbhiNweqZ7r; Wed, 11 May 2022 07:22:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 5926C4011F;
	Wed, 11 May 2022 07:22:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 42990C0039;
	Wed, 11 May 2022 07:22:38 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 17B8EC002D
 for <iommu@lists.linux-foundation.org>; Wed, 11 May 2022 07:22:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 063B14056F
 for <iommu@lists.linux-foundation.org>; Wed, 11 May 2022 07:22:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ocgJnaDCA4hy for <iommu@lists.linux-foundation.org>;
 Wed, 11 May 2022 07:22:35 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2061b.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eae::61b])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0D9504011F
 for <iommu@lists.linux-foundation.org>; Wed, 11 May 2022 07:22:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mrwt44OxYpDWqpNDpdFSwOpDu7v5i5klXUWnu3+gf6md6BdspwzrpSPV53i4C+4nFuCjeOlqTUqMQgmwYg+qRiL+jD30gvVzt/FyCXoi61O718pXMeklAY6zihWz9o6PxpJGSSXQDyo7qAIFFEak6qAmAWnP3hzzsW/wOmUSnsBe5oTeOLlthwyT4VQsOEE8cQ5BwN1ZAsY0p7oU3HU7QuEgAvC2TJjWt/6ASnpHnBCBJpbUM9hpsZIohVz1xVbz+0GEOH32YfeyFOXNlIAlmqnE+JuB1Ke73OCzqjwoY4pOQsCdQ83C8RCF6us5M4b6/hPjQsb32kRtC6PGW2Zz7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OQycysHcLvn/h2Lh4geO6t9zUpzixLJE4YHcuHSEZtY=;
 b=PgaQInQ3PHjCKhYca5CMsciyMfMokMNiNeTEvcTVwdN4QOfY2cZEAGpuGGGLlGGuaz8kzajukFhJZK2MrcXpW5s06dqId/+NK1guP4uQyca0heYwICrEgOcnMDOlVPfG+MUF3eGufgbOnTOtl9KmscgXdio3PlJiUZw9MNSmxlRIc/hThtodW8LRY8pErPbOMJEEM63+8oJga0kiwo6GjpgQPXsRJ77CHneBGKVNmvTO2CNDr7T+FiKM4XrwfhQEFhhEB34wrAciwN4MK+/dL1DnT1HJyj6M1GrDff5PCEkpr9Ye4X0SVMMEo8OWEhk+FNzfwlsErOjLylDS8DYQEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux-foundation.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OQycysHcLvn/h2Lh4geO6t9zUpzixLJE4YHcuHSEZtY=;
 b=Io3s91ZtlrQTEVtdVtT9p2/uwe/SCTSTA0gNgX46Z7ZAOYo+KylbRf0XAZcy/7870JjFjoqgvG8rj8MQofddt09ATwt7L45nJfEO3THey7EwClkERYKqiXURqVBhY76k+gL+GXNvR5EdHYI3VBASKrZhLzyEcRPRSA+XatBD8Ec=
Received: from DS7PR03CA0088.namprd03.prod.outlook.com (2603:10b6:5:3bb::33)
 by CY5PR12MB6082.namprd12.prod.outlook.com (2603:10b6:930:2a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.13; Wed, 11 May
 2022 07:22:30 +0000
Received: from DM6NAM11FT020.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3bb:cafe::2) by DS7PR03CA0088.outlook.office365.com
 (2603:10b6:5:3bb::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.24 via Frontend
 Transport; Wed, 11 May 2022 07:22:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT020.mail.protection.outlook.com (10.13.172.224) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5250.13 via Frontend Transport; Wed, 11 May 2022 07:22:30 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 11 May
 2022 02:22:28 -0500
To: <iommu@lists.linux-foundation.org>
Subject: [PATCH v3 01/35] iommu/amd: Update struct iommu_dev_data definition
Date: Wed, 11 May 2022 12:51:07 +0530
Message-ID: <20220511072141.15485-2-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220511072141.15485-1-vasant.hegde@amd.com>
References: <20220511072141.15485-1-vasant.hegde@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2bf491f1-d193-4600-e8b7-08da331f0270
X-MS-TrafficTypeDiagnostic: CY5PR12MB6082:EE_
X-Microsoft-Antispam-PRVS: <CY5PR12MB6082399EB6EA21AF206BFC2A87C89@CY5PR12MB6082.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uy0XZlEqlZtCdGTU3G/wNI3I1Loz9gVvEbV/7nNBEAnybXwpySQiPJCL5XSbUcm5b7kSxUlvi2OeOgnl9K9Rac2EAKJxWqi3uciC5D2ON1y5h2QhJh1LWDLbWW1KfuYBWd+Uyo33eIHuEcoxHVkSVXr6eIYQrNvwnoZYwee3AXzNkbPfc18B5HBub56pUQpkeqFRSiTySr1ujzQimfS9wXMx834QlhCIaYLD8qHI/lYv6e6h3GLnQgWqZtTlwR/yADBBzREVgjZO6122oojj2gIult8JfUW3ro1qKL39dEV+4jdh6LZZaruK1IQ+l+/o5L+3RcVhBaEoXoMXVs7UN48rgva7+NyYruQ/ic4/IGa3O5I3ykzNUA84P/np0XG3lj5w5fZIyKtxV4JgCD/VssG8hW64iSHsStFFp/67YCYBE5zC+HZuiTCspoW7RujbkYdLKzNlril6hZeO6aa2d0uTTaZM8MmErkb2X86co2Gn37ZEwq4P/bvzKPeJt1sNa4q+e7SJIZU8RShnEXx25p9oDVy4UJxuMncnRLjmLGGFP2veG5lQzwZcT4kh6c/PGjhKdUQpHlTsKlWxLwETuskjiU4iydBc2HLPZG2sRjyyYclMszeboS5SPFZFYs5uhTUlnP76hGAxlbKKP1Tro3OFc72SO+8arKqQW71WxBqlZrRBDIAM/Oxh6KaanRr71oJuh6U8FXBKoy9mDPViVQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(47076005)(36756003)(54906003)(1076003)(16526019)(508600001)(6916009)(186003)(336012)(2616005)(356005)(426003)(83380400001)(81166007)(7696005)(2906002)(44832011)(36860700001)(4326008)(15650500001)(6666004)(8936002)(86362001)(82310400005)(70586007)(70206006)(8676002)(5660300002)(40460700003)(316002)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2022 07:22:30.3365 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bf491f1-d193-4600-e8b7-08da331f0270
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT020.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6082
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
