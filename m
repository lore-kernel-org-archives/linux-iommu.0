Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B191C433F5
	for <iommu@archiver.kernel.org>; Mon,  4 Apr 2022 10:08:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B69FB410E1;
	Mon,  4 Apr 2022 10:08:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0m4S7aBBeAYQ; Mon,  4 Apr 2022 10:08:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 20D79410E5;
	Mon,  4 Apr 2022 10:08:42 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E48C9C002C;
	Mon,  4 Apr 2022 10:08:41 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E4970C0012
 for <iommu@lists.linux-foundation.org>; Mon,  4 Apr 2022 10:08:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D1707410E5
 for <iommu@lists.linux-foundation.org>; Mon,  4 Apr 2022 10:08:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CuLW4cXRq3vs for <iommu@lists.linux-foundation.org>;
 Mon,  4 Apr 2022 10:08:37 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20621.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::621])
 by smtp4.osuosl.org (Postfix) with ESMTPS id DBDCA410E1
 for <iommu@lists.linux-foundation.org>; Mon,  4 Apr 2022 10:08:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=co8JuDq+5s3iBdu1ZPT4MVQvpfdcujhG5+y4d0FkMbSeok7ZyjOsfo39yf8sStIlv9drW+GNYTJ1ZRxAe4oKZqAWMfqg0J8Pal1LL7fiiXutvfSjcRSTQXnZ6mMog85KnP4FnVbVRQ/QTLv2+y9eq0lIVZuFJ3mjWqp6hdsZXtXm6F4due17t/+rKJdcu0puivtHfdEQ7YYbQjBzcxxeHuyjrKaEPSP9C4YR4jKgQsGjCxKuyljhdpsyWRMwaoWuf9rcBlsimwEsIUyDGYjgQ0Tze+ZF4SMu0e2WCj9zM2NaQ5cHR3C4ieDwyt5F3BQ6xgFmd2yPQiwPcC2gMJ94Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d0qGfaF1fxoGthlPaghtzOtSP7F4B6D/nmGdjQrfSPE=;
 b=m125a208MEuBcvE+Qrpc9IvGhtiPuwn51GhiLl+SzdWoPqjRpNT+GWPEUVckqKPYgoGtICCWxx8W1BjMtdH2JcgSwXu3bcPs9TcUfKvJhodOPRsB6+eWXqzvFP3H7DB6i6w7leNAjvJYyABnPapdnIqy8mmS0kON7PsjQ4RRMfw5e25JOlqVI7xFhbylVz3/JK0ByEFBImhal03Q7XZri/ciPiZIinTzNObSZyxaK4rTM2AHj1jQ4p47/sYFp5ne1jaOTjH0jfSiWBE9MzvNtkc53e4sXlCrR4Cf4xOOLAu5LxFDbxSKYIFeDXhm5A0q0S0nFmP/+RzMZAq3Mtqfgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux-foundation.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d0qGfaF1fxoGthlPaghtzOtSP7F4B6D/nmGdjQrfSPE=;
 b=ijelwf5nZtKYAqpyGe40satH5hTzFH4bCArrqWdtKJDkm3quRF/3WVr7hYpbyG2uphhJpitC1uDpDo7YeLBxZBNjapY2JanGsFA55JN9FawfEDhM5l0zr6hAq7I9dGTctJCEWTuyrdp9ofuQr8fOcA6woeC4fIbd1EoPmDX7y94=
Received: from MW4PR03CA0066.namprd03.prod.outlook.com (2603:10b6:303:b6::11)
 by CY4PR12MB1463.namprd12.prod.outlook.com (2603:10b6:910:e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Mon, 4 Apr
 2022 10:08:35 +0000
Received: from CO1NAM11FT058.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b6:cafe::d6) by MW4PR03CA0066.outlook.office365.com
 (2603:10b6:303:b6::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31 via Frontend
 Transport; Mon, 4 Apr 2022 10:08:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT058.mail.protection.outlook.com (10.13.174.164) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5123.19 via Frontend Transport; Mon, 4 Apr 2022 10:08:34 +0000
Received: from kali.amdval.net (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 4 Apr
 2022 05:08:32 -0500
To: <iommu@lists.linux-foundation.org>, <joro@8bytes.org>
Subject: [RESEND PATCH v1 31/37] iommu/amd: Introduce get_device_sbdf_id()
 helper function
Date: Mon, 4 Apr 2022 15:30:17 +0530
Message-ID: <20220404100023.324645-32-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220404100023.324645-1-vasant.hegde@amd.com>
References: <20220404100023.324645-1-vasant.hegde@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d55b7330-6f78-40bd-3d4b-08da16231473
X-MS-TrafficTypeDiagnostic: CY4PR12MB1463:EE_
X-Microsoft-Antispam-PRVS: <CY4PR12MB14633103E0308BA390A2A10F87E59@CY4PR12MB1463.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WWLD7mX+RdWA2oaJDMUlnjrCGOiq1lIzT4SCTJkxYvlbVXKme19RP/9ktsCl4tJGZ1i4+vT0z6JuNUrMgMPRoY7xVfRp2gusdVWsl7x6FSWoO5FvtB224Z938bwvG8wCopEIxckf9TXM79v0QZZZgMpfKOKxLov8kxsaZ6Yy6RsI3R1dS4i5qbP1dMrQ+SdiQwjHfPMcemObTOewBvz0qKl0iIu9C0MtTnWIKx8/AKlZGmX7iEXsP7drjReRB67FCTaGHlLpF+yT72X3ZkrX52+ymBQ2z76SodEJbBscXkZREybstYvDsmqLdlllGDHdBjvEjV9EYeVIajHBviNs+TZHwkRXJxfAiX0M2Q3UHohwp2oc8cw6MkGoQtGNgXYAXA9A9+Ml+bmMAEho8RnFfcKp8brk/6lCMdd7CzUNitMIQzu/USVnj45IBmjXYfswTylXJaPSeL67B7N36boSsszE5dcXHKkVw9JyQZHU9eIkJEQDVM8iI3SPZFhIPrlPJdsRYt83towRONlxQ4RQSKswjt1WNEabbAJb87KCRxp29uKJjWwSk/gqHu1XfzI2rGyjqBR3/pdPPvkzykYKku4kNb8IoO+q+IQAhTy6HzyHa5SaA9ld3LTNavTcj9J4b7HeVTi0okC72vnPMiVKHhK/Glb0X7WGtfnzCmsmE8Bl/DIQYfR0yMCSbrN+dlvOW9BpBLJG3FuZ0EGYPVR03A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(81166007)(8936002)(70206006)(8676002)(356005)(70586007)(36756003)(2616005)(2906002)(54906003)(110136005)(36860700001)(4326008)(6666004)(316002)(186003)(16526019)(47076005)(26005)(86362001)(1076003)(44832011)(83380400001)(82310400004)(40460700003)(336012)(5660300002)(426003)(508600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2022 10:08:34.7234 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d55b7330-6f78-40bd-3d4b-08da16231473
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT058.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1463
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
index 60fbb1abb15f..4fe77f77dfa1 100644
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
@@ -421,10 +418,11 @@ static void iommu_ignore_device(struct amd_iommu *iommu, struct device *dev)
 	struct dev_table_entry *dev_table = get_dev_table(iommu);
 	int devid;
 
-	devid = (get_device_id(dev)) & 0xffff;
+	devid = get_device_sbdf_id(dev);
 	if (devid < 0)
 		return;
 
+	devid &= 0xffff;
 	pci_seg->rlookup_table[devid] = NULL;
 	memset(&dev_table[devid], 0, sizeof(struct dev_table_entry));
 
@@ -2262,9 +2260,11 @@ static void amd_iommu_get_resv_regions(struct device *dev,
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
@@ -3151,7 +3151,7 @@ static int get_devid(struct irq_alloc_info *info)
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
