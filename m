Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 474ECC433F5
	for <iommu@archiver.kernel.org>; Mon,  4 Apr 2022 10:09:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0903541498;
	Mon,  4 Apr 2022 10:09:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sE2qU7YKk9hH; Mon,  4 Apr 2022 10:09:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 671A7410E5;
	Mon,  4 Apr 2022 10:09:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 34F89C002C;
	Mon,  4 Apr 2022 10:09:56 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A8FCAC0012
 for <iommu@lists.linux-foundation.org>; Mon,  4 Apr 2022 10:09:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 879A460C34
 for <iommu@lists.linux-foundation.org>; Mon,  4 Apr 2022 10:09:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=amd.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zzJuhNNak0ia for <iommu@lists.linux-foundation.org>;
 Mon,  4 Apr 2022 10:09:53 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2060e.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::60e])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B3F7E607F7
 for <iommu@lists.linux-foundation.org>; Mon,  4 Apr 2022 10:09:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OS4Y8kmbxxsE5hZShOp2nbi3TnAnbIrkBT+9AMXxdl2htNh9IcpyWYewbTxFV79ThcPbL171iqF5l2QDfGXMwgEmvoHxmbDLO9ffFEt6J2hF3NVjqkZa8+za4pQ9bhWn3r2yOdeYJrS/O7V2FZeG/+9TrxpeVtY1ghwy/eMVAM7vhXwp5sGs5BIkALS83hUEJNLBT5iAncrbdzbfzlSGxzYAiBjb5FGntl67eMPn/3YAU20OvOmkS2E3a2h+HbejzOudhAj7nLaMKB/++3qOvRlSGHIPbmI2WrxzkvmiOt0K49lXPl0ziWOT5OMpu7avkmH8LdtcqSRe+Az/9eaXmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4v1qOymPZ4LTM4cqDemn6SXNjFfxOwHSbg+DwNV2mxQ=;
 b=QWBq409/gcrVAIrf4h99diIAzpCRwtYt6FR2JYBy2HSDvYCHqQJ9lqNf2/ZGYb58raN0aI6PDOktLUMqf++3+c1ocqfX+d5V5/gdf/krgNc98FMqGRibIdWgyeIXb8ltMtCr6gV6uC2DWCi0m9V6HoPjTs3tF1OcvtEGnLL5ABImmj+akkrDjhQjKEg4+0OIoUBJSPcUMmr+kl/e7WAI2loan8BQ8q+ATKOL+WFc7R8Q4qRDyH/w3mojT78G1JFM6Fr7pyj+1rTdb9ovPTIYU3ciqwcAVT1hIeGVnxXrrZUL/VDAfGIel5cinJJUnw4vrssKPIJZveVKG/HYptI3HQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux-foundation.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4v1qOymPZ4LTM4cqDemn6SXNjFfxOwHSbg+DwNV2mxQ=;
 b=PPsPhgZtiLteJMQ2tRnXD3XSREt+il9sfxsBqItdrk7bk0drFszBfmvvZ27TUPPkvlB4pewtdvcXJUZqtncU+VqJValeVHpmBkXLW6Uoj7uPKQBl9Nzurlgl1J7mBz7d6jF+jipk3KThfhrGyDGzqEi1o3V6NOtllLx9O0HUXnE=
Received: from MW4PR03CA0059.namprd03.prod.outlook.com (2603:10b6:303:8e::34)
 by BN6PR1201MB0179.namprd12.prod.outlook.com (2603:10b6:405:59::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Mon, 4 Apr
 2022 10:09:51 +0000
Received: from CO1NAM11FT047.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8e:cafe::89) by MW4PR03CA0059.outlook.office365.com
 (2603:10b6:303:8e::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31 via Frontend
 Transport; Mon, 4 Apr 2022 10:09:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT047.mail.protection.outlook.com (10.13.174.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5123.19 via Frontend Transport; Mon, 4 Apr 2022 10:09:50 +0000
Received: from kali.amdval.net (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 4 Apr
 2022 05:09:47 -0500
To: <iommu@lists.linux-foundation.org>, <joro@8bytes.org>
Subject: [RESEND PATCH v1 36/37] iommu/amd: Update device_state structure to
 include PCI seg ID
Date: Mon, 4 Apr 2022 15:30:22 +0530
Message-ID: <20220404100023.324645-37-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220404100023.324645-1-vasant.hegde@amd.com>
References: <20220404100023.324645-1-vasant.hegde@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8d1046f0-b04a-42f0-4208-08da1623417b
X-MS-TrafficTypeDiagnostic: BN6PR1201MB0179:EE_
X-Microsoft-Antispam-PRVS: <BN6PR1201MB0179E994B3EF851A22594BBE87E59@BN6PR1201MB0179.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: X8FLGgBotbmEs/91YeJAWxf5B/rJFYSTzkS7FuMtbtSK1DrRDjIp6dfqwuWqVux5Sm61Kc8d8Jyh9GiGuV7dn1ehedI4Js+LEX3mXKJolo0kKjlbdpVptH9i8l1WnREmbrntnkWLJ4uxdt2HPKTu8DmKMY3P24Zkfic5BXVBi8MLwa+0yQPKFN/Q0aLbvzGrUK1mtahHEyTljezlzrVDYkuGaS6+MWNEqNj2XKGV6ZAvpOugv0D6nH9bF7yO89pxZgiju8EJEgN3s7GkuTX9M9tHqhY3CGjiJzA8Ryh2cOTKMkVmVyLtqDCCVrjhOGCKZlL4GwVBEbBxbGRyJ33i7UgCEm1wOrRsdBhnAwO3dmCGBrC+k3gcywDQ/M7y0QEPVZJCwewrP/iXsDnO3FIQtJFNw7ug5I1qzfPvmP14HdlrE+PNjnxHkNaCE2CWBxvuks8UQvfZfuV1aNgy9wxh8nfYj/1kNsZhxBB/SBIRzzsF3bEE9dgAV16g0bo8xJY+IVuXRzLYlf7uBsrZ41Fno/Pkiz0Q+sRK1vfyKzQJ4Amkp77nCr0/wvzYtF8OWQRIInRrRARNfRTQgeILb+LRaWRuAZPbcNZiEu0FY7lDxq1H+ZIfQW6L+PqygZaW2ltNELPt6bwQMTixbEkzAzpebGOEdCVTHo57/YQdnl7YobVFdPo4sfr9u7+I2JHHDUfBHdsPx1diG666ZUW4Ng1Uxg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(8676002)(4326008)(82310400004)(86362001)(70586007)(70206006)(2906002)(356005)(44832011)(5660300002)(81166007)(8936002)(36860700001)(426003)(6666004)(83380400001)(40460700003)(2616005)(336012)(36756003)(47076005)(1076003)(26005)(186003)(316002)(16526019)(110136005)(508600001)(54906003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2022 10:09:50.2891 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d1046f0-b04a-42f0-4208-08da1623417b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT047.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB0179
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

Rename struct device_state.devid variable to struct device_state.sbdf
and extend it to 32-bit to include the 16-bit PCI segment ID via
the helper function get_pci_sbdf_id().

Co-developed-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/iommu_v2.c | 58 +++++++++++++++---------------------
 1 file changed, 24 insertions(+), 34 deletions(-)

diff --git a/drivers/iommu/amd/iommu_v2.c b/drivers/iommu/amd/iommu_v2.c
index e56b137ceabd..b186d33336e0 100644
--- a/drivers/iommu/amd/iommu_v2.c
+++ b/drivers/iommu/amd/iommu_v2.c
@@ -51,7 +51,7 @@ struct pasid_state {
 
 struct device_state {
 	struct list_head list;
-	u16 devid;
+	u32 sbdf;
 	atomic_t count;
 	struct pci_dev *pdev;
 	struct pasid_state **states;
@@ -83,35 +83,25 @@ static struct workqueue_struct *iommu_wq;
 
 static void free_pasid_states(struct device_state *dev_state);
 
-static u16 device_id(struct pci_dev *pdev)
-{
-	u16 devid;
-
-	devid = pdev->bus->number;
-	devid = (devid << 8) | pdev->devfn;
-
-	return devid;
-}
-
-static struct device_state *__get_device_state(u16 devid)
+static struct device_state *__get_device_state(u32 sbdf)
 {
 	struct device_state *dev_state;
 
 	list_for_each_entry(dev_state, &state_list, list) {
-		if (dev_state->devid == devid)
+		if (dev_state->sbdf == sbdf)
 			return dev_state;
 	}
 
 	return NULL;
 }
 
-static struct device_state *get_device_state(u16 devid)
+static struct device_state *get_device_state(u32 sbdf)
 {
 	struct device_state *dev_state;
 	unsigned long flags;
 
 	spin_lock_irqsave(&state_lock, flags);
-	dev_state = __get_device_state(devid);
+	dev_state = __get_device_state(sbdf);
 	if (dev_state != NULL)
 		atomic_inc(&dev_state->count);
 	spin_unlock_irqrestore(&state_lock, flags);
@@ -609,7 +599,7 @@ int amd_iommu_bind_pasid(struct pci_dev *pdev, u32 pasid,
 	struct pasid_state *pasid_state;
 	struct device_state *dev_state;
 	struct mm_struct *mm;
-	u16 devid;
+	u32 sbdf;
 	int ret;
 
 	might_sleep();
@@ -617,8 +607,8 @@ int amd_iommu_bind_pasid(struct pci_dev *pdev, u32 pasid,
 	if (!amd_iommu_v2_supported())
 		return -ENODEV;
 
-	devid     = device_id(pdev);
-	dev_state = get_device_state(devid);
+	sbdf      = get_pci_sbdf_id(pdev);
+	dev_state = get_device_state(sbdf);
 
 	if (dev_state == NULL)
 		return -EINVAL;
@@ -692,15 +682,15 @@ void amd_iommu_unbind_pasid(struct pci_dev *pdev, u32 pasid)
 {
 	struct pasid_state *pasid_state;
 	struct device_state *dev_state;
-	u16 devid;
+	u32 sbdf;
 
 	might_sleep();
 
 	if (!amd_iommu_v2_supported())
 		return;
 
-	devid = device_id(pdev);
-	dev_state = get_device_state(devid);
+	sbdf = get_pci_sbdf_id(pdev);
+	dev_state = get_device_state(sbdf);
 	if (dev_state == NULL)
 		return;
 
@@ -742,7 +732,7 @@ int amd_iommu_init_device(struct pci_dev *pdev, int pasids)
 	struct iommu_group *group;
 	unsigned long flags;
 	int ret, tmp;
-	u16 devid;
+	u32 sbdf;
 
 	might_sleep();
 
@@ -759,7 +749,7 @@ int amd_iommu_init_device(struct pci_dev *pdev, int pasids)
 	if (pasids <= 0 || pasids > (PASID_MASK + 1))
 		return -EINVAL;
 
-	devid = device_id(pdev);
+	sbdf = get_pci_sbdf_id(pdev);
 
 	dev_state = kzalloc(sizeof(*dev_state), GFP_KERNEL);
 	if (dev_state == NULL)
@@ -768,7 +758,7 @@ int amd_iommu_init_device(struct pci_dev *pdev, int pasids)
 	spin_lock_init(&dev_state->lock);
 	init_waitqueue_head(&dev_state->wq);
 	dev_state->pdev  = pdev;
-	dev_state->devid = devid;
+	dev_state->sbdf = sbdf;
 
 	tmp = pasids;
 	for (dev_state->pasid_levels = 0; (tmp - 1) & ~0x1ff; tmp >>= 9)
@@ -806,7 +796,7 @@ int amd_iommu_init_device(struct pci_dev *pdev, int pasids)
 
 	spin_lock_irqsave(&state_lock, flags);
 
-	if (__get_device_state(devid) != NULL) {
+	if (__get_device_state(sbdf) != NULL) {
 		spin_unlock_irqrestore(&state_lock, flags);
 		ret = -EBUSY;
 		goto out_free_domain;
@@ -838,16 +828,16 @@ void amd_iommu_free_device(struct pci_dev *pdev)
 {
 	struct device_state *dev_state;
 	unsigned long flags;
-	u16 devid;
+	u32 sbdf;
 
 	if (!amd_iommu_v2_supported())
 		return;
 
-	devid = device_id(pdev);
+	sbdf = get_pci_sbdf_id(pdev);
 
 	spin_lock_irqsave(&state_lock, flags);
 
-	dev_state = __get_device_state(devid);
+	dev_state = __get_device_state(sbdf);
 	if (dev_state == NULL) {
 		spin_unlock_irqrestore(&state_lock, flags);
 		return;
@@ -867,18 +857,18 @@ int amd_iommu_set_invalid_ppr_cb(struct pci_dev *pdev,
 {
 	struct device_state *dev_state;
 	unsigned long flags;
-	u16 devid;
+	u32 sbdf;
 	int ret;
 
 	if (!amd_iommu_v2_supported())
 		return -ENODEV;
 
-	devid = device_id(pdev);
+	sbdf = get_pci_sbdf_id(pdev);
 
 	spin_lock_irqsave(&state_lock, flags);
 
 	ret = -EINVAL;
-	dev_state = __get_device_state(devid);
+	dev_state = __get_device_state(sbdf);
 	if (dev_state == NULL)
 		goto out_unlock;
 
@@ -898,18 +888,18 @@ int amd_iommu_set_invalidate_ctx_cb(struct pci_dev *pdev,
 {
 	struct device_state *dev_state;
 	unsigned long flags;
-	u16 devid;
+	u32 sbdf;
 	int ret;
 
 	if (!amd_iommu_v2_supported())
 		return -ENODEV;
 
-	devid = device_id(pdev);
+	sbdf = get_pci_sbdf_id(pdev);
 
 	spin_lock_irqsave(&state_lock, flags);
 
 	ret = -EINVAL;
-	dev_state = __get_device_state(devid);
+	dev_state = __get_device_state(sbdf);
 	if (dev_state == NULL)
 		goto out_unlock;
 
-- 
2.27.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
