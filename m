Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71862C433EF
	for <iommu@archiver.kernel.org>; Wed, 11 May 2022 07:24:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 393E860A83;
	Wed, 11 May 2022 07:24:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mODBASAH7KPT; Wed, 11 May 2022 07:24:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id DC80160A68;
	Wed, 11 May 2022 07:24:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B7822C0039;
	Wed, 11 May 2022 07:24:20 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7D800C002D
 for <iommu@lists.linux-foundation.org>; Wed, 11 May 2022 07:24:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6C93860A83
 for <iommu@lists.linux-foundation.org>; Wed, 11 May 2022 07:24:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4-sIQoJK546v for <iommu@lists.linux-foundation.org>;
 Wed, 11 May 2022 07:24:18 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on20617.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7ea9::617])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4EEDD60A68
 for <iommu@lists.linux-foundation.org>; Wed, 11 May 2022 07:24:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a4428hR4dv3BggClqCFzRatznQLIpDVITC4C9fS0r95AeDJcA2W6xpmSD+/rgxoFnZMHzi9ON0d1eWyySPV9/5R9xWk5TeP5EUXED2QCyVspQDgEB8mJwb4K3ICXndgJfaLRSMXdd+WTtaBH9WSuoK6qSYEvv0KkoMq4exuMur+1l1v5vLGCIT2dXbgyec27PQOUzGheAictmNVTvYZ3gsjAwYjXwyJ3RYjoUi/i/zEVXg3KVc4/iHQLWAx8IujsyjZa3LZTRFK+1vsgCbTwXHslyZP8RX1dU6brrs4amUudFzZ7gKq8nNArMUY8v5sBDlNT/scOy69sLCSGTC+Llg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p9VDJAq0vSmcJ/yDFrV8Ly2Z4ZARmeoRppJ4Ph9Guso=;
 b=HZ06+31d4vgdbJ80QjM4DXznv/a2ZwppJmGrp5ogOmPF7kcjSgG76G/lMvEY7Iiencqk+7J7kD+/VeeB+W5ObejEwu47z5/X6Mwfioncuc1St1qfANAwgPF5BW/uGQ6hRoe+RbMYw/v/LMkYT/IcYFGJ0osi4z5S9dJ87Omd5T+1BvvhpyXiuzEwI/sn1nsP1yoq/omgxmAuwyKD2IUGPt74anKyH06SbTXnlLXB2pvN5jCeVSMyiNLwrrtLawzdX0csv1jziOIKvrv1N1Xxq/LpsYScJPwVwnSQsRROQ1yiKEpRMPblzN18RrkYIRd/SBF12YjT09scuN4TLXrtNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux-foundation.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p9VDJAq0vSmcJ/yDFrV8Ly2Z4ZARmeoRppJ4Ph9Guso=;
 b=Z9CjJj0Dx5THzm/pAwHmhTWv/G1gLdybaN+LSbfAPbTdO+lZNo60WZ+wUVsQ5dl7HJ+dcesgZ6V6CZjGacxziP6oyAMXNV0E9lAk7jPONcVFEHDLhlF93uOKkSJHQ8dV2ZqbqwX99kOGr15kWH8xgYE/D6s0u8BNRPuxEWvQoLU=
Received: from DS7PR03CA0226.namprd03.prod.outlook.com (2603:10b6:5:3ba::21)
 by DM6PR12MB4353.namprd12.prod.outlook.com (2603:10b6:5:2a6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.13; Wed, 11 May
 2022 07:24:15 +0000
Received: from DM6NAM11FT033.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3ba:cafe::13) by DS7PR03CA0226.outlook.office365.com
 (2603:10b6:5:3ba::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.22 via Frontend
 Transport; Wed, 11 May 2022 07:24:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT033.mail.protection.outlook.com (10.13.172.221) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5250.13 via Frontend Transport; Wed, 11 May 2022 07:24:15 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 11 May
 2022 02:24:13 -0500
To: <iommu@lists.linux-foundation.org>
Subject: [PATCH v3 08/35] iommu/amd: Introduce per PCI segment alias_table
Date: Wed, 11 May 2022 12:51:14 +0530
Message-ID: <20220511072141.15485-9-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220511072141.15485-1-vasant.hegde@amd.com>
References: <20220511072141.15485-1-vasant.hegde@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 97aa3569-1bbc-4523-8ee4-08da331f4127
X-MS-TrafficTypeDiagnostic: DM6PR12MB4353:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB4353A25AB86102839FA41A8687C89@DM6PR12MB4353.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SFREwvr8CvESbXwHcvnB4Eyzbo9zM4x5wPgiNJ7ZW2NSlAV43kj4w96IhpQYNE/BomZXPfUD0oLyjya2FxcWA64HAjwaaKT25fPbsw/41tA1AFBKT1u0BzwcrXKSwwwIhic+fGvEmrk2C6Wb6MhDW/m545UPZ83xBFX0gjuDHOq+EH1odUqjFd3NhNF1ew6C0sWArIbUxF0x1BWHRo5hhue75cyir8xuNzsajeJcWK1FnplrvhQ3aV/e2jGO9gSlQY0hAGYaZqkUXV7TmW8svxYEYHTgrrDWJwmh9KN69+aaCUy3Yo0HWnneOMHo9NzAd+pRacgB9rdM9cbrclwjj2m6J2xiGN9TFMAORS3plKKebD4OhY/axDy2lrcvgr5OwbIls8R36aTCjSzy2hN4KGulb/rj73Z2z12YM8G3OOX459dYysinER9oVyqgmI2ecyrhBNsFhRa0qHnJXzIe4MnSm/rtKW3cCvbFo5nk/IgMRW3PiYDWxp2iTec1w6J1VhIpySeeEaPQUC0L0eIk9NreqSK0FfU85QMJ1czSdX+YK8OYvBj008WHiqiEhznpiLaKi4sqpqwZ/UmMnZx8anTy1NrWF/XTRRzPA2y5iH5nU9loGPZw/U+YOXYhe1o9tQ7sqdZgNwqUED1VbRNH0++ThX2vBR/iBxYOKUuJHr8LDS8Ffgb0crsD8Wjaj0GR+K+RfWJDFPB7Pb+J0tAHPg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(426003)(356005)(83380400001)(81166007)(16526019)(336012)(47076005)(82310400005)(186003)(1076003)(7696005)(2616005)(6916009)(54906003)(40460700003)(26005)(8936002)(5660300002)(36860700001)(70206006)(70586007)(2906002)(316002)(4326008)(8676002)(44832011)(508600001)(36756003)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2022 07:24:15.5367 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 97aa3569-1bbc-4523-8ee4-08da331f4127
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT033.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4353
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

This will replace global alias table (amd_iommu_alias_table).

Co-developed-by: Vasant Hegde <vasant.hegde@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/amd_iommu_types.h |  7 +++++
 drivers/iommu/amd/init.c            | 41 ++++++++++++++++++++++-------
 drivers/iommu/amd/iommu.c           | 41 ++++++++++++++++++-----------
 3 files changed, 64 insertions(+), 25 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index d43ce65f8e21..9534064124f9 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -576,6 +576,13 @@ struct amd_iommu_pci_seg {
 	 * will be copied to. It's only be used in kdump kernel.
 	 */
 	struct dev_table_entry *old_dev_tbl_cpy;
+
+	/*
+	 * The alias table is a driver specific data structure which contains the
+	 * mappings of the PCI device ids to the actual requestor ids on the IOMMU.
+	 * More than one device can share the same requestor id.
+	 */
+	u16 *alias_table;
 };
 
 /*
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 31b19a418ee8..9d57cb05878e 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -698,6 +698,31 @@ static inline void free_irq_lookup_table(struct amd_iommu_pci_seg *pci_seg)
 	pci_seg->irq_lookup_table = NULL;
 }
 
+static int __init alloc_alias_table(struct amd_iommu_pci_seg *pci_seg)
+{
+	int i;
+
+	pci_seg->alias_table = (void *)__get_free_pages(GFP_KERNEL,
+						    get_order(alias_table_size));
+	if (!pci_seg->alias_table)
+		return -ENOMEM;
+
+	/*
+	 * let all alias entries point to itself
+	 */
+	for (i = 0; i <= amd_iommu_last_bdf; ++i)
+		pci_seg->alias_table[i] = i;
+
+	return 0;
+}
+
+static void __init free_alias_table(struct amd_iommu_pci_seg *pci_seg)
+{
+	free_pages((unsigned long)pci_seg->alias_table,
+		   get_order(alias_table_size));
+	pci_seg->alias_table = NULL;
+}
+
 /*
  * Allocates the command buffer. This buffer is per AMD IOMMU. We can
  * write commands to that buffer later and the IOMMU will execute them
@@ -1266,6 +1291,7 @@ static int __init init_iommu_from_acpi(struct amd_iommu *iommu,
 	u32 dev_i, ext_flags = 0;
 	bool alias = false;
 	struct ivhd_entry *e;
+	struct amd_iommu_pci_seg *pci_seg = iommu->pci_seg;
 	u32 ivhd_size;
 	int ret;
 
@@ -1347,7 +1373,7 @@ static int __init init_iommu_from_acpi(struct amd_iommu *iommu,
 			devid_to = e->ext >> 8;
 			set_dev_entry_from_acpi(iommu, devid   , e->flags, 0);
 			set_dev_entry_from_acpi(iommu, devid_to, e->flags, 0);
-			amd_iommu_alias_table[devid] = devid_to;
+			pci_seg->alias_table[devid] = devid_to;
 			break;
 		case IVHD_DEV_ALIAS_RANGE:
 
@@ -1405,7 +1431,7 @@ static int __init init_iommu_from_acpi(struct amd_iommu *iommu,
 			devid = e->devid;
 			for (dev_i = devid_start; dev_i <= devid; ++dev_i) {
 				if (alias) {
-					amd_iommu_alias_table[dev_i] = devid_to;
+					pci_seg->alias_table[dev_i] = devid_to;
 					set_dev_entry_from_acpi(iommu,
 						devid_to, flags, ext_flags);
 				}
@@ -1540,6 +1566,8 @@ static struct amd_iommu_pci_seg *__init alloc_pci_segment(u16 id)
 
 	if (alloc_dev_table(pci_seg))
 		return NULL;
+	if (alloc_alias_table(pci_seg))
+		return NULL;
 	if (alloc_rlookup_table(pci_seg))
 		return NULL;
 
@@ -1566,6 +1594,7 @@ static void __init free_pci_segments(void)
 		list_del(&pci_seg->list);
 		free_irq_lookup_table(pci_seg);
 		free_rlookup_table(pci_seg);
+		free_alias_table(pci_seg);
 		free_dev_table(pci_seg);
 		kfree(pci_seg);
 	}
@@ -2838,7 +2867,7 @@ static void __init ivinfo_init(void *ivrs)
 static int __init early_amd_iommu_init(void)
 {
 	struct acpi_table_header *ivrs_base;
-	int i, remap_cache_sz, ret;
+	int remap_cache_sz, ret;
 	acpi_status status;
 
 	if (!amd_iommu_detected)
@@ -2909,12 +2938,6 @@ static int __init early_amd_iommu_init(void)
 	if (amd_iommu_pd_alloc_bitmap == NULL)
 		goto out;
 
-	/*
-	 * let all alias entries point to itself
-	 */
-	for (i = 0; i <= amd_iommu_last_bdf; ++i)
-		amd_iommu_alias_table[i] = i;
-
 	/*
 	 * never allocate domain 0 because its used as the non-allocated and
 	 * error value placeholder
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index f0764446dea5..df0bc0335b5a 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -243,7 +243,7 @@ static int clone_alias(struct pci_dev *pdev, u16 alias, void *data)
 	return 0;
 }
 
-static void clone_aliases(struct device *dev)
+static void clone_aliases(struct amd_iommu *iommu, struct device *dev)
 {
 	struct pci_dev *pdev;
 
@@ -256,14 +256,15 @@ static void clone_aliases(struct device *dev)
 	 * part of the PCI DMA aliases if it's bus differs
 	 * from the original device.
 	 */
-	clone_alias(pdev, amd_iommu_alias_table[pci_dev_id(pdev)], NULL);
+	clone_alias(pdev, iommu->pci_seg->alias_table[pci_dev_id(pdev)], NULL);
 
 	pci_for_each_dma_alias(pdev, clone_alias, NULL);
 }
 
-static void setup_aliases(struct device *dev)
+static void setup_aliases(struct amd_iommu *iommu, struct device *dev)
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
+	struct amd_iommu_pci_seg *pci_seg = iommu->pci_seg;
 	u16 ivrs_alias;
 
 	/* For ACPI HID devices, there are no aliases */
@@ -274,12 +275,12 @@ static void setup_aliases(struct device *dev)
 	 * Add the IVRS alias to the pci aliases if it is on the same
 	 * bus. The IVRS table may know about a quirk that we don't.
 	 */
-	ivrs_alias = amd_iommu_alias_table[pci_dev_id(pdev)];
+	ivrs_alias = pci_seg->alias_table[pci_dev_id(pdev)];
 	if (ivrs_alias != pci_dev_id(pdev) &&
 	    PCI_BUS_NUM(ivrs_alias) == pdev->bus->number)
 		pci_add_dma_alias(pdev, ivrs_alias & 0xff, 1);
 
-	clone_aliases(dev);
+	clone_aliases(iommu, dev);
 }
 
 static struct iommu_dev_data *find_dev_data(u16 devid)
@@ -371,7 +372,7 @@ static bool check_device(struct device *dev)
 	return true;
 }
 
-static int iommu_init_device(struct device *dev)
+static int iommu_init_device(struct amd_iommu *iommu, struct device *dev)
 {
 	struct iommu_dev_data *dev_data;
 	int devid;
@@ -388,7 +389,7 @@ static int iommu_init_device(struct device *dev)
 		return -ENOMEM;
 
 	dev_data->dev = dev;
-	setup_aliases(dev);
+	setup_aliases(iommu, dev);
 
 	/*
 	 * By default we use passthrough mode for IOMMUv2 capable device.
@@ -409,7 +410,7 @@ static int iommu_init_device(struct device *dev)
 	return 0;
 }
 
-static void iommu_ignore_device(struct device *dev)
+static void iommu_ignore_device(struct amd_iommu *iommu, struct device *dev)
 {
 	int devid;
 
@@ -420,7 +421,7 @@ static void iommu_ignore_device(struct device *dev)
 	amd_iommu_rlookup_table[devid] = NULL;
 	memset(&amd_iommu_dev_table[devid], 0, sizeof(struct dev_table_entry));
 
-	setup_aliases(dev);
+	setup_aliases(iommu, dev);
 }
 
 static void amd_iommu_uninit_device(struct device *dev)
@@ -1290,6 +1291,7 @@ static int device_flush_dte(struct iommu_dev_data *dev_data)
 {
 	struct amd_iommu *iommu;
 	struct pci_dev *pdev = NULL;
+	struct amd_iommu_pci_seg *pci_seg;
 	u16 alias;
 	int ret;
 
@@ -1306,7 +1308,8 @@ static int device_flush_dte(struct iommu_dev_data *dev_data)
 	if (ret)
 		return ret;
 
-	alias = amd_iommu_alias_table[dev_data->devid];
+	pci_seg = iommu->pci_seg;
+	alias = pci_seg->alias_table[dev_data->devid];
 	if (alias != dev_data->devid) {
 		ret = iommu_flush_dte(iommu, alias);
 		if (ret)
@@ -1622,7 +1625,7 @@ static void do_attach(struct iommu_dev_data *dev_data,
 	/* Update device table */
 	set_dte_entry(dev_data->devid, domain,
 		      ats, dev_data->iommu_v2);
-	clone_aliases(dev_data->dev);
+	clone_aliases(iommu, dev_data->dev);
 
 	device_flush_dte(dev_data);
 }
@@ -1638,7 +1641,7 @@ static void do_detach(struct iommu_dev_data *dev_data)
 	dev_data->domain = NULL;
 	list_del(&dev_data->list);
 	clear_dte_entry(dev_data->devid);
-	clone_aliases(dev_data->dev);
+	clone_aliases(iommu, dev_data->dev);
 
 	/* Flush the DTE entry */
 	device_flush_dte(dev_data);
@@ -1821,12 +1824,12 @@ static struct iommu_device *amd_iommu_probe_device(struct device *dev)
 	if (dev_iommu_priv_get(dev))
 		return &iommu->iommu;
 
-	ret = iommu_init_device(dev);
+	ret = iommu_init_device(iommu, dev);
 	if (ret) {
 		if (ret != -ENOTSUPP)
 			dev_err(dev, "Failed to initialize - trying to proceed anyway\n");
 		iommu_dev = ERR_PTR(ret);
-		iommu_ignore_device(dev);
+		iommu_ignore_device(iommu, dev);
 	} else {
 		amd_iommu_set_pci_msi_domain(dev, iommu);
 		iommu_dev = &iommu->iommu;
@@ -1877,9 +1880,13 @@ static void update_device_table(struct protection_domain *domain)
 	struct iommu_dev_data *dev_data;
 
 	list_for_each_entry(dev_data, &domain->dev_list, list) {
+		struct amd_iommu *iommu = rlookup_amd_iommu(dev_data->dev);
+
+		if (!iommu)
+			continue;
 		set_dte_entry(dev_data->devid, domain,
 			      dev_data->ats.enabled, dev_data->iommu_v2);
-		clone_aliases(dev_data->dev);
+		clone_aliases(iommu, dev_data->dev);
 	}
 }
 
@@ -2781,6 +2788,7 @@ static struct irq_remap_table *alloc_irq_table(u16 devid, struct pci_dev *pdev)
 {
 	struct irq_remap_table *table = NULL;
 	struct irq_remap_table *new_table = NULL;
+	struct amd_iommu_pci_seg *pci_seg;
 	struct amd_iommu *iommu;
 	unsigned long flags;
 	u16 alias;
@@ -2791,11 +2799,12 @@ static struct irq_remap_table *alloc_irq_table(u16 devid, struct pci_dev *pdev)
 	if (!iommu)
 		goto out_unlock;
 
+	pci_seg = iommu->pci_seg;
 	table = irq_lookup_table[devid];
 	if (table)
 		goto out_unlock;
 
-	alias = amd_iommu_alias_table[devid];
+	alias = pci_seg->alias_table[devid];
 	table = irq_lookup_table[alias];
 	if (table) {
 		set_remap_table_entry(iommu, devid, table);
-- 
2.27.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
