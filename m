Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F499C433F5
	for <iommu@archiver.kernel.org>; Wed, 11 May 2022 07:29:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id ECD3683224;
	Wed, 11 May 2022 07:29:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xVkwAUR0bx8l; Wed, 11 May 2022 07:29:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 95DE8831DA;
	Wed, 11 May 2022 07:29:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 714A4C0039;
	Wed, 11 May 2022 07:29:39 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4C7EBC002D
 for <iommu@lists.linux-foundation.org>; Wed, 11 May 2022 07:29:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2D60360BA3
 for <iommu@lists.linux-foundation.org>; Wed, 11 May 2022 07:29:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=amd.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id b5j7UHDlPO_9 for <iommu@lists.linux-foundation.org>;
 Wed, 11 May 2022 07:29:37 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on20604.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5a::604])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4CAE76080B
 for <iommu@lists.linux-foundation.org>; Wed, 11 May 2022 07:29:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jn0ieRG/Fd0KFAtgE6iZdYW5bV1K4gsDt3SemeOUfHWz3VCusw7yQA30yaSuc8k6LhESjf9PqisWSUAuuNus3wxVRQePHq0nZPwAoaSSO2Tz6KAuxh3qM2sxC4Va3gN7WCbPV5pH9/mMHiQI6NOSewVFN/aJlQm4hzzuTwm1eGJOouHdrA0/URw5fxrB+P/Sk+xwJcH9cNgNLI2bk4FSKgrX/yLFOs7qLV1HRkNhDuAgROwfsqY8EoUa1EF1cz0lDtm9323C9Vm3Wr9pGm0Nxc8VNHheAi9YzXrGkdIJVVfoRQaxNgfwt3ZEhXy0KL9kwqt8f0+ARHuMRG/smJShaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QIsDgmCfrvzY+lMXid94dLODxQZBawLs1HGV0UfpUMI=;
 b=cviEpGC6bbWpSUM3aqPmfDJC/2TTxUgIkQq6mAVlltDDPtmKhSgwGCE8v9BoR1nJZOckBeG/x1Kfl2R4ynynhVkzXdUBkogVw7jGbiFp8dYO+AIxBa4uojysZ/RG2mAQ1Fl6hw+VGEhIL27Zbl6x/aNj41uL5FCza3X7rruxnr6YRVYqUjqeIGmbNQzAz0KjjPzvhtduY6m35HatvvSnJ/PTxCXT78CMfpP5uLmppBsXxRPaT3WDTkCFUX81ct+yGwho18yvJVEI6tavW6G/zoVN9p5x0vxq9Uo8yQe3ORWjAoQOk7hGSCoPFCOgWsGlZ6w/U401yls79wY3Np3egQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux-foundation.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QIsDgmCfrvzY+lMXid94dLODxQZBawLs1HGV0UfpUMI=;
 b=Z8sAizpjNmjYiiIz0EvcEn96Nkl7RkdbaRSKRgYqahVFXfF0FJEGwodu0lEfKs3EvGRVpvd1OcYGT2v/NptT/muDHH6wThpkJBtuR1BuAMV8+3E1hHUut3kL/ifloq8xHMEJWFQMjIloqMhbCIINk6FCjcZIb337ucY+JV1n6iI=
Received: from DM6PR02CA0132.namprd02.prod.outlook.com (2603:10b6:5:1b4::34)
 by MN2PR12MB3245.namprd12.prod.outlook.com (2603:10b6:208:103::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.22; Wed, 11 May
 2022 07:29:34 +0000
Received: from DM6NAM11FT060.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1b4:cafe::f4) by DM6PR02CA0132.outlook.office365.com
 (2603:10b6:5:1b4::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.23 via Frontend
 Transport; Wed, 11 May 2022 07:29:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT060.mail.protection.outlook.com (10.13.173.63) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5250.13 via Frontend Transport; Wed, 11 May 2022 07:29:33 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 11 May
 2022 02:29:31 -0500
To: <iommu@lists.linux-foundation.org>
Subject: [PATCH v3 29/35] iommu/amd: Introduce get_device_sbdf_id() helper
 function
Date: Wed, 11 May 2022 12:51:35 +0530
Message-ID: <20220511072141.15485-30-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220511072141.15485-1-vasant.hegde@amd.com>
References: <20220511072141.15485-1-vasant.hegde@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9913e69d-c2a8-4eb1-15f7-08da331ffef4
X-MS-TrafficTypeDiagnostic: MN2PR12MB3245:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB32457B4E65F0227699F796AA87C89@MN2PR12MB3245.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j/C4/ijIZQVQhPa51Pt7siPf4PMZSk9rVX1C+cVenCU9lpvYmQ/w621z/9ijPQFDMMRHTxtrFEH5+JXlUJVlp7lfgHV/dNYdRIwneC0oRDb5GAHMZktV/G0ya15EYuphN27i67HqnWB7Q625jqcZFN+i2kGA7713zMohgsy3Bz6mOAJ4CT8SXuscQv651n5B13u7HugZJkuMU5NxW6F56A+Ui/6ajhXQ8Zv0uOAHWdHFYcgnazVWyWrqneF+iiU03YEilRMUGLilfHwpL2Vc5ZtbK+GpWbzULfmArU13uKdZfYlweoiVzrXeOyMVu3kjDe/PwA9ENxzgjXlx/szCCYuguQM3ttwdZC5XGvytGkc4gKZgXWD41NnSTZqCL9OxeVQvzDzXUX2pfZ0j7Qep+CFpyiz/ZeH1q0JTq7jiWHP0egwdgKD8TZ1ckmjzrFYUe7p2hbhAUhA/4C1d6T7BHX9lEAp+Bc4wyFIEqgyiToy185vb4OAeNv8SkmVwQJmEyD+KK11sj/dnJmljnZBAFPspZFS+pdDEK3aT7z0x4pwhuD3EatUXaNlU4w8TYCT1vjepW6kKG/eI/gXB9d6mWProSNyIpO5ON/Q4erea/FicOXMR9xR/VXhwD4zhjjClytAmBS3ZfTLhgmGBoJCtFJ5bVkkSVLgBiH3DHYk3rgVIfCDBqvx0c6QvyF4W97188+viEn1++Zdcmxo84NWoiQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(508600001)(81166007)(36860700001)(8936002)(36756003)(8676002)(4326008)(2906002)(70206006)(70586007)(54906003)(356005)(83380400001)(7696005)(6916009)(316002)(86362001)(426003)(2616005)(1076003)(44832011)(40460700003)(5660300002)(26005)(16526019)(336012)(82310400005)(47076005)(186003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2022 07:29:33.9821 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9913e69d-c2a8-4eb1-15f7-08da331ffef4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT060.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3245
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

Co-developed-by: Vasant Hegde <vasant.hegde@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/amd_iommu.h       |  7 ++++
 drivers/iommu/amd/amd_iommu_types.h |  2 +
 drivers/iommu/amd/iommu.c           | 58 ++++++++++++++---------------
 3 files changed, 38 insertions(+), 29 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index 64c954e168d7..e73bd48fc716 100644
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
+	return PCI_SEG_DEVID_TO_SBDF(seg, devid);
+}
 
 extern bool translation_pre_enabled(struct amd_iommu *iommu);
 extern bool amd_iommu_is_attach_deferred(struct device *dev);
diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index dfb1f2055f0c..0d47aac685ee 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -452,6 +452,8 @@ extern struct kmem_cache *amd_iommu_irq_cache;
 
 #define PCI_SBDF_TO_SEGID(sbdf)		(((sbdf) >> 16) & 0xffff)
 #define PCI_SBDF_TO_DEVID(sbdf)		((sbdf) & 0xffff)
+#define PCI_SEG_DEVID_TO_SBDF(seg, devid)	((((u32)(seg) & 0xffff) << 16) | \
+						 ((devid) & 0xffff))
 
 /* Make iterating over all pci segment easier */
 #define for_each_pci_segment(pci_seg) \
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 68ebbccef5c4..d9b23f7820a9 100644
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
+	return __rlookup_amd_iommu(seg, PCI_SBDF_TO_DEVID(devid));
 }
 
 static struct protection_domain *to_pdomain(struct iommu_domain *dom)
@@ -360,14 +355,15 @@ static bool check_device(struct device *dev)
 {
 	struct amd_iommu_pci_seg *pci_seg;
 	struct amd_iommu *iommu;
-	int devid;
+	int devid, sbdf;
 
 	if (!dev)
 		return false;
 
-	devid = get_device_id(dev);
-	if (devid < 0)
+	sbdf = get_device_sbdf_id(dev);
+	if (sbdf < 0)
 		return false;
+	devid = PCI_SBDF_TO_DEVID(sbdf);
 
 	iommu = rlookup_amd_iommu(dev);
 	if (!iommu)
@@ -375,7 +371,7 @@ static bool check_device(struct device *dev)
 
 	/* Out of our scope? */
 	pci_seg = iommu->pci_seg;
-	if ((devid & 0xffff) > pci_seg->last_bdf)
+	if (devid > pci_seg->last_bdf)
 		return false;
 
 	return true;
@@ -384,15 +380,16 @@ static bool check_device(struct device *dev)
 static int iommu_init_device(struct amd_iommu *iommu, struct device *dev)
 {
 	struct iommu_dev_data *dev_data;
-	int devid;
+	int devid, sbdf;
 
 	if (dev_iommu_priv_get(dev))
 		return 0;
 
-	devid = get_device_id(dev);
-	if (devid < 0)
-		return devid;
+	sbdf = get_device_sbdf_id(dev);
+	if (sbdf < 0)
+		return sbdf;
 
+	devid = PCI_SBDF_TO_DEVID(sbdf);
 	dev_data = find_dev_data(iommu, devid);
 	if (!dev_data)
 		return -ENOMEM;
@@ -420,12 +417,13 @@ static void iommu_ignore_device(struct amd_iommu *iommu, struct device *dev)
 {
 	struct amd_iommu_pci_seg *pci_seg = iommu->pci_seg;
 	struct dev_table_entry *dev_table = get_dev_table(iommu);
-	int devid;
+	int devid, sbdf;
 
-	devid = (get_device_id(dev)) & 0xffff;
-	if (devid < 0)
+	sbdf = get_device_sbdf_id(dev);
+	if (sbdf < 0)
 		return;
 
+	devid = PCI_SBDF_TO_DEVID(sbdf);
 	pci_seg->rlookup_table[devid] = NULL;
 	memset(&dev_table[devid], 0, sizeof(struct dev_table_entry));
 
@@ -2263,11 +2261,13 @@ static void amd_iommu_get_resv_regions(struct device *dev,
 	struct unity_map_entry *entry;
 	struct amd_iommu *iommu;
 	struct amd_iommu_pci_seg *pci_seg;
-	int devid;
+	int devid, sbdf;
 
-	devid = get_device_id(dev);
-	if (devid < 0)
+	sbdf = get_device_sbdf_id(dev);
+	if (sbdf < 0)
 		return;
+
+	devid = PCI_SBDF_TO_DEVID(sbdf);
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
