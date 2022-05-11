Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9825BC433FE
	for <iommu@archiver.kernel.org>; Wed, 11 May 2022 07:30:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5BB4D4020C;
	Wed, 11 May 2022 07:30:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AUE2z_nkh5p7; Wed, 11 May 2022 07:30:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id AF9F141883;
	Wed, 11 May 2022 07:30:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 83618C0039;
	Wed, 11 May 2022 07:30:55 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3A4D7C002D
 for <iommu@lists.linux-foundation.org>; Wed, 11 May 2022 07:30:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1AAF560BA3
 for <iommu@lists.linux-foundation.org>; Wed, 11 May 2022 07:30:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=amd.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wDPpBXAuo7uw for <iommu@lists.linux-foundation.org>;
 Wed, 11 May 2022 07:30:53 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on20626.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5b::626])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2E3546080B
 for <iommu@lists.linux-foundation.org>; Wed, 11 May 2022 07:30:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mazPNl7qFU0zhJXENvAcNuqFBbYX4Rac/SNwnduOEyhuhOCkecPLq9E3aueOAWmDd7Dm3aEuOV8PKEVEnEXHAzc4y3hVBwQEqfxvFIUitoCbJUDi9SWVw+F2s4hdqD67eO9NKiOua3MTYWUeiFntJsrpB3AeS5Cb0F5OdLfyJZGr4e6AbVyWNN8oB8DLlomaTgxhq+Rrwx6fzeCKarI/g3+0avutDt1PI+KTalABfkAxVBjwo0VucYi91qXuC6kM0atZwa/k3Nm4qV++f53x0uvFB+x8JdyPsirQITLWTuhVAZNH8N3Z1qJ4nMlsIn9NUhgI0D8WNzXdoNGRcXjOVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4v1qOymPZ4LTM4cqDemn6SXNjFfxOwHSbg+DwNV2mxQ=;
 b=ihcXAjxRmWke589qfZpJOxH24x3sX5YVWW3y0xMaQq69fMd/t6gj9vQIWmI6+IBJ7ljp6VQl8AA+HTIAzyKIKgqa1/DRCtENt7emA8aYT4Df2Y098ZHWx7RZQx6hEF39ci+CDu73QnV2AvD2y49WC9cflld/z+Ciup8OkltLEKh95op7LTsbIDhldhLKC2Uaz5EY2RXMGZsJVkCNw3tfR9mNSm4lCjvNYraePnNni5qyY2PKayAMhg1d1wo1GD29L6LOLYoX/yt1h51cg0vOWAscvPd1/DLpXIQgscTrnIQCT3dtJHlqhkWJ90Emdl0gOkPrSh4A+Y7SaMUGG3F1Qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux-foundation.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4v1qOymPZ4LTM4cqDemn6SXNjFfxOwHSbg+DwNV2mxQ=;
 b=rZMFvrEHChqyu70NuWiWJyIjKnwJEF4QYbF0+ODlzBoa34A60TRz3r8Q1cqgvRQm7kuxWsReLbAHCbmQTG5XlEwhwv9ZhtxU8lBByzKjRT5NEbDAEQ+cy296AyJiv2D0JEzpqQut9gdzFiaoe0hDIS4gO1QsKsOFPdF1HM3H/fg=
Received: from DM5PR08CA0046.namprd08.prod.outlook.com (2603:10b6:4:60::35) by
 MW3PR12MB4459.namprd12.prod.outlook.com (2603:10b6:303:56::22) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5227.20; Wed, 11 May 2022 07:30:50 +0000
Received: from DM6NAM11FT019.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:60:cafe::fb) by DM5PR08CA0046.outlook.office365.com
 (2603:10b6:4:60::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.27 via Frontend
 Transport; Wed, 11 May 2022 07:30:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT019.mail.protection.outlook.com (10.13.172.172) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5250.13 via Frontend Transport; Wed, 11 May 2022 07:30:50 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 11 May
 2022 02:30:47 -0500
To: <iommu@lists.linux-foundation.org>
Subject: [PATCH v3 34/35] iommu/amd: Update device_state structure to include
 PCI seg ID
Date: Wed, 11 May 2022 12:51:40 +0530
Message-ID: <20220511072141.15485-35-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220511072141.15485-1-vasant.hegde@amd.com>
References: <20220511072141.15485-1-vasant.hegde@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fcae17a5-f240-4a7a-1a96-08da33202c63
X-MS-TrafficTypeDiagnostic: MW3PR12MB4459:EE_
X-Microsoft-Antispam-PRVS: <MW3PR12MB445912868B6A39F12A6E4F8487C89@MW3PR12MB4459.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HJ2KdAYSeXfRvUC9bItwe1cXiQ9FKV6uRUvC9GbM65bDjxhV3q7UMEAESHrsn0MZ/3j/bF/szQ8tGUJMZe9PSgs/Jcj3BRNp/fwlOz1g/m9vQrCKW0xTIRiD/O7kqJjUFFlbLeluzjNHxDh0WpUy8yginFJ4IhqUIE4nV31BlgaX9stFVWKgh0L79uuccvoha7YfdNCCW/l7xl1pXCVmqSjnXn6NJedcA2mMKaIpNlcyzZyk1alUqI8bITUpa4sqR7rs4jtXgQv64VFAFkZrY3JQNL82zaAM9tFOwkiDoq77aYFNwkSeZLjmS7UPLZaf9PiAco8RxMOWTZaxxe1EL5v4HGNTJWLxY3QAOXFlurUjUwcg8caI/csgi/lHgxLFLVC6bJLLL08NcUcoLZjdn9YSdlDmhHKU2HDjJ4G7pf0f/h4CXuHpkJUaOS0AuKKqsnqzXE1TmCooeEolw6b9jq/wWGiTAyx7nprIN9zdDCbVYwiIJS7mTntVm+8XTAAzcOh4cW+4y7V8F+LLD86Og7huAeCs9pyQNNWe3Ddf5UOBIA+BfuGjuzPZ+zVAQWxSbDH/GQuTm5tH3P60MGQbTg+E83fM6HMTb6NmazwhexRfo3EXfDPf7HEWfMrAciloaL0JkGdRIqb5UIISQhjV2r9ic4M5aLzy5GIOGdSCon5ZEX1aLQH5obUi/XrAanRR2R7DEmgbC4UEcyD26Z7yIQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(7696005)(40460700003)(6666004)(83380400001)(26005)(44832011)(81166007)(36756003)(5660300002)(186003)(1076003)(2616005)(336012)(2906002)(47076005)(426003)(82310400005)(316002)(8936002)(16526019)(508600001)(356005)(70586007)(70206006)(4326008)(8676002)(86362001)(36860700001)(54906003)(6916009)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2022 07:30:50.1602 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fcae17a5-f240-4a7a-1a96-08da33202c63
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT019.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4459
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
