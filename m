Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B5E2C433F5
	for <iommu@archiver.kernel.org>; Fri, 11 Mar 2022 10:00:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 3D22940521;
	Fri, 11 Mar 2022 10:00:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mmIjdBswFf7g; Fri, 11 Mar 2022 10:00:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 70B714018A;
	Fri, 11 Mar 2022 10:00:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4B755C0012;
	Fri, 11 Mar 2022 10:00:10 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3413CC000B
 for <iommu@lists.linux-foundation.org>; Fri, 11 Mar 2022 10:00:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1E047418FB
 for <iommu@lists.linux-foundation.org>; Fri, 11 Mar 2022 10:00:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=amd.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PrZW_8esT-zS for <iommu@lists.linux-foundation.org>;
 Fri, 11 Mar 2022 10:00:07 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2060d.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::60d])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 481CB4099B
 for <iommu@lists.linux-foundation.org>; Fri, 11 Mar 2022 10:00:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W1I9hMPBYVnfFDaT8YGbbuGEErvmpzPAybM/TZJGb37mtmd7bhzH5M8Vv/oZ6SYXqYFxyvALlUE3xMSChgPoQWFPDjUcj0zkkwBRsOzppK9fEhpYH/pVeyRO9RYTAtOeYMAbxHlPpTJzPXwg8n2RFNA/VleTAm0xdSUuBRV9CnByaGOhCMJjqzMPnpQ1cNn+cCcoLAF0Q2IBlfYpRkTikByM+Ffus3UZ3RnQ6Tx36tXV1qnEKP0bvhhMqT6dAb0MrkoU6Qvn1hu5hv2ixSHxfMa/mpbG221StxV9nIbhOkCZ20v6OXPjmqFR47/oSRFvNRppDZruaKtNnGSoqN87lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=On4DlrRRjcKP+gcnCSWF7mAvTwKmNYVvxsKML6kwhBE=;
 b=U7C1Wikbg2FcGXBDimf783kYspiCcX+Wyy2k65bVVZ3QUvjhpoPHqjZpjDqhj9xK7V57/IIUpZF+5KI5N1ipR7YVVuv0Jx2ICDhI1VsUxd2Dp91ZnWmqCUX6ACLCQUpWXrRQEOUUmsaahNadhMH3m5bIvkei1NN2U/SDGoGKksaQiREHLufUdQ0Ldf/fuj4On7yE5t3CYajRvjHXf78vsro4dzKMwDqBd0PQhSvF6aOcmdekpuuxnRxtLNWC912xnsr3Hm8gRZTWlH0zsxBOTGadQI7Xq8eF4/N2tA71+S2+05MmQlnaTvrEPszmSXU4PsIWo40AYWIjVQl8ufEEuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux-foundation.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=On4DlrRRjcKP+gcnCSWF7mAvTwKmNYVvxsKML6kwhBE=;
 b=QPTDvz7j2Uk2a9SSgc2Yobpt49By6cMwCaoj9nor2LisWBKDNN/aPc0Y61L8io38GL1ZrKFGilgscznwoDjtommW9lt+CG0ISWLuDRXuTDXMG9nYwhLSgq+66Kv4iZQZ4E+jqgbMxPQxOfgBUsFnqZeoAdpIwRhVzG82AyUqVrg=
Received: from DM5PR05CA0015.namprd05.prod.outlook.com (2603:10b6:3:d4::25) by
 DM6PR12MB3116.namprd12.prod.outlook.com (2603:10b6:5:38::12) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5038.17; Fri, 11 Mar 2022 10:00:04 +0000
Received: from DM6NAM11FT016.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:d4:cafe::91) by DM5PR05CA0015.outlook.office365.com
 (2603:10b6:3:d4::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.10 via Frontend
 Transport; Fri, 11 Mar 2022 10:00:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT016.mail.protection.outlook.com (10.13.173.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5061.22 via Frontend Transport; Fri, 11 Mar 2022 10:00:04 +0000
Received: from kali.amdval.net (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 11 Mar
 2022 04:00:01 -0600
To: <iommu@lists.linux-foundation.org>, <joro@8bytes.org>
Subject: [RFC PATCH 30/36] iommu/amd: Introduce get_device_sbdf_id() helper
 function
Date: Fri, 11 Mar 2022 15:18:48 +0530
Message-ID: <20220311094854.31595-31-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220311094854.31595-1-vasant.hegde@amd.com>
References: <20220311094854.31595-1-vasant.hegde@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 70cf9be2-3ff3-47ca-472a-08da0345ea21
X-MS-TrafficTypeDiagnostic: DM6PR12MB3116:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB3116F94814D483F273E352E9870C9@DM6PR12MB3116.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o/Ye8SDnwVAoGBDFZ7Dev2Zw/AlOxjA5LfvWu8Yj7MqxDljzUYFMAt/xg+WZTzmaEnF4X50DCtln7IfqXumq7r+BY+30xwinhFM9xwFVu+9yKzbrerjmIeqXB/LG76IS+w3NI2633fxWgJ2CrEEV6+RNEMuaLbP2j5RKon+FvwSvikminEYRunv9lIaV8MYDXQm04ZLKUdJA46uLzH3q5cDuaPVlHWZX/WQ80z8LEet6mqbiUcfhU1cCV8jdfMTxthtOBQ/CnG+2f1rzvzacPe/v6uL4a+ftULfX+y4w3udR/R83tcTKXduIMlQfXks8lyjFAP64Q+UgZdpErk0e4e+utuNt7Y45FYVRCf78ENrMH2K5//wdAMNPKXGotyA9AIEHzSjILo3q8IKtn27V94gtVWYQH8z1TI7MdOn4O0o2+nFPXhGIDTOQNR1wIbl+EoecgJfqNNemddj6eDH96f9K9q7W1MPuCuqvxOmOwKopMDhSsbsaTEqCDvy9ESY58FkSIfy0uRYp+5uUqJrRqmIyttSaUZTZWV3pm6chRDBz0lPY0+7soY2cfeUCZGxQarkRrrQlaN9BytryRpvASwZwptrXO/8hJFL7md6vslBnUiSG58GkQZgDfuV0Lvlg/YU4IO61e2leoyjFMONhxtFU5DgfbYdNo7nzLZVvfeY0Dr0m9K/QB+igutXRd3SN8zNShwcDRzkJ9dlwGDn+yQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(508600001)(186003)(86362001)(40460700003)(336012)(26005)(83380400001)(1076003)(426003)(2616005)(16526019)(47076005)(6666004)(2906002)(4326008)(5660300002)(44832011)(81166007)(70206006)(8676002)(70586007)(316002)(54906003)(36860700001)(110136005)(356005)(8936002)(36756003)(82310400004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2022 10:00:04.0929 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 70cf9be2-3ff3-47ca-472a-08da0345ea21
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT016.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3116
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
index d1c58364a1af..1f7567e230cd 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -112,6 +112,13 @@ void amd_iommu_domain_clr_pt_root(struct protection_domain *domain)
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
 extern bool amd_iommu_is_attach_deferred(struct iommu_domain *domain,
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index d44f2cfa5b3d..430faa882200 100644
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
@@ -364,9 +359,10 @@ static bool check_device(struct device *dev)
 	if (!dev)
 		return false;
 
-	devid = get_device_id(dev);
+	devid = get_device_sbdf_id(dev);
 	if (devid < 0)
 		return false;
+	devid &= 0xffff;
 
 	iommu = rlookup_amd_iommu(dev);
 	if (!iommu)
@@ -374,7 +370,7 @@ static bool check_device(struct device *dev)
 
 	/* Out of our scope? */
 	pci_seg = iommu->pci_seg;
-	if ((devid & 0xffff) > pci_seg->last_bdf)
+	if (devid > pci_seg->last_bdf)
 		return false;
 
 	return true;
@@ -388,10 +384,11 @@ static int iommu_init_device(struct amd_iommu *iommu, struct device *dev)
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
@@ -420,10 +417,11 @@ static void iommu_ignore_device(struct amd_iommu *iommu, struct device *dev)
 	struct dev_table_entry *dev_table = get_dev_table(iommu);
 	int devid;
 
-	devid = (get_device_id(dev)) & 0xffff;
+	devid = get_device_sbdf_id(dev);
 	if (devid < 0)
 		return;
 
+	devid &= 0xffff;
 	pci_seg->rlookup_table[devid] = NULL;
 	memset(&dev_table[devid], 0, sizeof(struct dev_table_entry));
 
@@ -2259,9 +2257,11 @@ static void amd_iommu_get_resv_regions(struct device *dev,
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
@@ -3147,7 +3147,7 @@ static int get_devid(struct irq_alloc_info *info)
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
