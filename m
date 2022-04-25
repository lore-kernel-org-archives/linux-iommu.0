Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B963C433F5
	for <iommu@archiver.kernel.org>; Mon, 25 Apr 2022 11:43:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D1D9260B2C;
	Mon, 25 Apr 2022 11:43:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Hpll68dJeRJB; Mon, 25 Apr 2022 11:43:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id A04E160BEF;
	Mon, 25 Apr 2022 11:43:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 86647C007B;
	Mon, 25 Apr 2022 11:43:00 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 591E3C002D
 for <iommu@lists.linux-foundation.org>; Mon, 25 Apr 2022 11:42:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4557960D4D
 for <iommu@lists.linux-foundation.org>; Mon, 25 Apr 2022 11:42:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fLuwDm60ShOB for <iommu@lists.linux-foundation.org>;
 Mon, 25 Apr 2022 11:42:46 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2061a.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eae::61a])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7AD7A60D56
 for <iommu@lists.linux-foundation.org>; Mon, 25 Apr 2022 11:42:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XZABxqpUOCPHct31TJjPsedLqKrZmjYyqcQl2lBCktrvcOyVBvS7ycL3Jbv8G9pvaruYNsn+kv01qItMP8lEL36893ayHGhb+vilTbwEpkli5hqtowHCI506laBJuI6P1vxdmhU0wZt4Ucvrm2IDY6223dKDLpc1ymrX+w6vB4aZgcv6cS93FT2gVScI/70oZdPKdst/lfPo3icyTTIycI3MbVwQG+mB8dci27qZKniUr7NQdhfYQr1mBWw3LEsTLCClESfbAIrshMJaSuJ6HH1iXH/BG5Awqe3z7EeouI1lymB9dddzMMblBganSls6G7elPDJIlzu0u9mSfybW+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ossJiR4vstgkUL/nOsg2lykVLHrN33TJGRRN6Q9Gdko=;
 b=JxgiVLZ789mx7AxoSRTsGbggis2/Lw0m/PNCsEvyURx9lECJaXcfTmersYdCSJmCN6P16Bzn/SQZwd26nSxeVPqmVUfNux3qQ/yaH/jXIZIO38fC+JlV0UsVOxQjvuaUSw7E/j3E/0AwWzc5KgjHAUu/X6LYH4PFXh88CWMxRyOhFTVdQTjLAJ3xMGWRAUUKpPvnVtXW3StEKEkm4LhmlmWAqe0OPn1RcvmIyIm97GE/kJcn8P/wHVBFpgTLkhpsHH3Ji2SZBJj5QtY/m0h8Nep++6Iu9r4sxacvcuskp0JzEyQhv0cgo5MwELmVa2uGE+2C+YtX3uuZ/+YWwhKUwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux-foundation.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ossJiR4vstgkUL/nOsg2lykVLHrN33TJGRRN6Q9Gdko=;
 b=1kqrrvreUvDOwkSmvp20LAMAIoy4Zk+cPZO7MLbW2NS25XTYBKu0VHI9J4yt3CuFrrPxseGl4GOD6TdiC7gnPmTo/I8aiO5+bJPYQRMUuf8u6h/szyJivDwe8Qt0AYmw8w9ySJlRKR4IfUCASwkOSJd8xsk0/2xb5ZABh4D3p2g=
Received: from BN0PR03CA0027.namprd03.prod.outlook.com (2603:10b6:408:e6::32)
 by DM8PR12MB5495.namprd12.prod.outlook.com (2603:10b6:8:33::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Mon, 25 Apr
 2022 11:42:44 +0000
Received: from BN8NAM11FT064.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e6:cafe::c) by BN0PR03CA0027.outlook.office365.com
 (2603:10b6:408:e6::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13 via Frontend
 Transport; Mon, 25 Apr 2022 11:42:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT064.mail.protection.outlook.com (10.13.176.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5186.14 via Frontend Transport; Mon, 25 Apr 2022 11:42:43 +0000
Received: from kali.amdval.net (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 25 Apr
 2022 06:42:41 -0500
To: <iommu@lists.linux-foundation.org>
Subject: [PATCH v2 31/37] iommu/amd: Introduce get_device_sbdf_id() helper
 function
Date: Mon, 25 Apr 2022 17:04:09 +0530
Message-ID: <20220425113415.24087-32-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220425113415.24087-1-vasant.hegde@amd.com>
References: <20220425113415.24087-1-vasant.hegde@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 40a3ac8d-9047-4591-6889-08da26b0b611
X-MS-TrafficTypeDiagnostic: DM8PR12MB5495:EE_
X-Microsoft-Antispam-PRVS: <DM8PR12MB54951F49816BA05D9E98AE7C87F89@DM8PR12MB5495.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C3b86kXHZtN+ZeEhliXGqQn61DrLmjX3C3vjfjbxU2+imxZZ5DB7/kKysBJkj/OiKHPZYJBVQ7KozHh3BtsaKs1vDHRi98cs7oHoLoxfMneqx/+G4ddPglZc5cSOxRLkmXkQGVIJ9cO0QA8j7CqDLv4W6TGTTZA9/fUfypbJkpxCYfiNcWnTyImGTe2u8ZGXmURfIPWU1yVRRzHgQa23zAmUIudLT6lJFjOlybF+XsFsUzMX3KemhYvs8sM0+rgbYqgltPB15hmFf4vfKFNsr33xTrV0Nxg/JCImmy4uW5BV1MLsjPO+tb8a+Y67gHJ0F/LmJeiqO+KLhUY9qA4nurzSDmz6bL1xoLxOWoGO1vSw0aUkBpZkK+apgcL5NZRDGr+7ZwpC2u9epHLGIWUa0pjtxT1tnEcsW07LHxX/VX1jOgpsdGnr4rGgPEp5/YfD/hGvGx+iWsagUr95plPddxMr3Kn0FaOenNiXX8RAc3MfO3L4tia9DMkql8M1JBPQD0WMlfkzpkk0HAARAEwBiki0eqGRSYmFJ+8gQFKqtDWauJo/LCSxpn8n5xCk3FM1a0Pnq1bB3yLvOBQEwmYtzb55QdB21F/9GKjF9aeQtTpuV8rjT80HtOvmJ4ys/qUX8g7GVtJM/PolkEMW8FVcLVi5Nb7kl3GTdDL9vIX/LRGs2nYqsvRzp4ka0azmvoSy5Z/g7QQDsT32wsQNriIbUg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(8936002)(5660300002)(426003)(36756003)(83380400001)(4326008)(336012)(16526019)(186003)(36860700001)(44832011)(2906002)(1076003)(47076005)(26005)(8676002)(316002)(2616005)(86362001)(508600001)(70206006)(70586007)(81166007)(6666004)(40460700003)(356005)(82310400005)(54906003)(6916009)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2022 11:42:43.6415 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 40a3ac8d-9047-4591-6889-08da26b0b611
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT064.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5495
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

Current get_device_id() only provide 16-bit PCI device ID (i.e. BDF).
With multiple PCI segment support, we need to extend the helper function
to include PCI segment ID.

So, introduce a new helper function get_device_sbdf_id() to replace
the current get_pci_device_id().

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/amd_iommu.h |  7 ++++++
 drivers/iommu/amd/iommu.c     | 40 +++++++++++++++++------------------
 2 files changed, 27 insertions(+), 20 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index 64c954e168d7..4dad1b442409 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -115,6 +115,13 @@ void amd_iommu_domain_clr_pt_root(struct protection_domain *domain)
 	amd_iommu_domain_set_pt_root(domain, 0);
 }
 
+static inline int get_pci_sbdf_id(struct pci_dev *pdev)
+{
+	int seg = pci_domain_nr(pdev->bus);
+	u16 devid = pci_dev_id(pdev);
+
+	return ((seg << 16) | (devid & 0xffff));
+}
 
 extern bool translation_pre_enabled(struct amd_iommu *iommu);
 extern bool amd_iommu_is_attach_deferred(struct device *dev);
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 40415e477853..1e375d469280 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -92,13 +92,6 @@ static void detach_device(struct device *dev);
  *
  ****************************************************************************/
 
-static inline u16 get_pci_device_id(struct device *dev)
-{
-	struct pci_dev *pdev = to_pci_dev(dev);
-
-	return pci_dev_id(pdev);
-}
-
 static inline int get_acpihid_device_id(struct device *dev,
 					struct acpihid_map_entry **entry)
 {
@@ -119,16 +112,16 @@ static inline int get_acpihid_device_id(struct device *dev,
 	return -EINVAL;
 }
 
-static inline int get_device_id(struct device *dev)
+static inline int get_device_sbdf_id(struct device *dev)
 {
-	int devid;
+	int sbdf;
 
 	if (dev_is_pci(dev))
-		devid = get_pci_device_id(dev);
+		sbdf = get_pci_sbdf_id(to_pci_dev(dev));
 	else
-		devid = get_acpihid_device_id(dev, NULL);
+		sbdf = get_acpihid_device_id(dev, NULL);
 
-	return devid;
+	return sbdf;
 }
 
 struct dev_table_entry *get_dev_table(struct amd_iommu *iommu)
@@ -182,9 +175,11 @@ static struct amd_iommu *__rlookup_amd_iommu(u16 seg, u16 devid)
 static struct amd_iommu *rlookup_amd_iommu(struct device *dev)
 {
 	u16 seg = get_device_segment(dev);
-	u16 devid = get_device_id(dev);
+	int devid = get_device_sbdf_id(dev);
 
-	return __rlookup_amd_iommu(seg, devid);
+	if (devid < 0)
+		return NULL;
+	return __rlookup_amd_iommu(seg, (devid & 0xffff));
 }
 
 static struct protection_domain *to_pdomain(struct iommu_domain *dom)
@@ -365,9 +360,10 @@ static bool check_device(struct device *dev)
 	if (!dev)
 		return false;
 
-	devid = get_device_id(dev);
+	devid = get_device_sbdf_id(dev);
 	if (devid < 0)
 		return false;
+	devid &= 0xffff;
 
 	iommu = rlookup_amd_iommu(dev);
 	if (!iommu)
@@ -375,7 +371,7 @@ static bool check_device(struct device *dev)
 
 	/* Out of our scope? */
 	pci_seg = iommu->pci_seg;
-	if ((devid & 0xffff) > pci_seg->last_bdf)
+	if (devid > pci_seg->last_bdf)
 		return false;
 
 	return true;
@@ -389,10 +385,11 @@ static int iommu_init_device(struct amd_iommu *iommu, struct device *dev)
 	if (dev_iommu_priv_get(dev))
 		return 0;
 
-	devid = get_device_id(dev);
+	devid = get_device_sbdf_id(dev);
 	if (devid < 0)
 		return devid;
 
+	devid &= 0xffff;
 	dev_data = find_dev_data(iommu, devid);
 	if (!dev_data)
 		return -ENOMEM;
@@ -422,10 +419,11 @@ static void iommu_ignore_device(struct amd_iommu *iommu, struct device *dev)
 	struct dev_table_entry *dev_table = get_dev_table(iommu);
 	int devid;
 
-	devid = (get_device_id(dev)) & 0xffff;
+	devid = get_device_sbdf_id(dev);
 	if (devid < 0)
 		return;
 
+	devid &= 0xffff;
 	pci_seg->rlookup_table[devid] = NULL;
 	memset(&dev_table[devid], 0, sizeof(struct dev_table_entry));
 
@@ -2265,9 +2263,11 @@ static void amd_iommu_get_resv_regions(struct device *dev,
 	struct amd_iommu_pci_seg *pci_seg;
 	int devid;
 
-	devid = get_device_id(dev);
+	devid = get_device_sbdf_id(dev);
 	if (devid < 0)
 		return;
+	devid &= 0xffff;
+
 	iommu = rlookup_amd_iommu(dev);
 	if (!iommu)
 		return;
@@ -3154,7 +3154,7 @@ static int get_devid(struct irq_alloc_info *info)
 		return get_hpet_devid(info->devid);
 	case X86_IRQ_ALLOC_TYPE_PCI_MSI:
 	case X86_IRQ_ALLOC_TYPE_PCI_MSIX:
-		return get_device_id(msi_desc_to_dev(info->desc));
+		return get_device_sbdf_id(msi_desc_to_dev(info->desc));
 	default:
 		WARN_ON_ONCE(1);
 		return -1;
-- 
2.27.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
