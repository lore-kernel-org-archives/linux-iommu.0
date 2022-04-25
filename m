Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E053C433EF
	for <iommu@archiver.kernel.org>; Mon, 25 Apr 2022 11:44:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2F8F460C0D;
	Mon, 25 Apr 2022 11:44:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YmOHZpEYb1AO; Mon, 25 Apr 2022 11:44:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id ED7F960B2C;
	Mon, 25 Apr 2022 11:44:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C4034C0039;
	Mon, 25 Apr 2022 11:44:02 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 04B82C002D
 for <iommu@lists.linux-foundation.org>; Mon, 25 Apr 2022 11:44:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E7CBE81AF6
 for <iommu@lists.linux-foundation.org>; Mon, 25 Apr 2022 11:44:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=amd.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FvRaKFm482_a for <iommu@lists.linux-foundation.org>;
 Mon, 25 Apr 2022 11:44:01 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20625.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eae::625])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 12B1B81AF4
 for <iommu@lists.linux-foundation.org>; Mon, 25 Apr 2022 11:44:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DC4u57v7h66PoFCD0AGpC4MuJeKLoq0SsHzfnNUh4kWr5FHQ1iIn3hJdQ14Z23gnx+35o+dJyklOzd7Dtx4tvY71NZZWtZcHI+C4GQpaKsRO8L4V6DAEokm4ktkx8pAlBDdhw9U7yZiFJAon286dQIwxwpUoHaK5k5vRbDpKQvrdheNH8Ub7unpI027oeZC55F7qZCYfw0fOSx+3YPhW9P1+nDvnPwYdWEbAGUCbZ9ONMTP5N5d0eLnATbPGanhIdSHkTFOQ386vDZjz+L6OvU7umacxydROwoWMUoH9Ydl5xRQL+t+Lp1gpCWLvJ0u/NboptEoVF+/2YDYs1sO1/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4v1qOymPZ4LTM4cqDemn6SXNjFfxOwHSbg+DwNV2mxQ=;
 b=fE716abRnj6G5qFA3Fd4rRpeDYbaGy47Vt7dADslXBrQ30RW1UrgjAXNxpBunOagK5vV5JMN4fmo+xNkK44wSIqNGZu0pVMGCEcESc8uP572f4g++/lXGspUt4cAs9uz7mKioVlGc5vmj86HhxLQygeJazwCxR84vE6+QMm1hh2Upb1KrGSvMt8X4ygdx/EqMbErUFkroYzN0Btbdtt0835IzSCwUxhx7oWK0rZINbqcJb8ApUOR50a7ZaG8o//j5vbVuByjyZ2Q6ipLC2JfDS9Fi/xcHRkUF+Yd4gPPTfuoB6PpP2BRhh1l+CfGoa3rR1BAQHTt3B9HglUF/F0Bmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux-foundation.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4v1qOymPZ4LTM4cqDemn6SXNjFfxOwHSbg+DwNV2mxQ=;
 b=AEoCbq3KsxcmGyA/xv8mhly/k0DMjhmvW4R8rYY9vZSLUi28i0MZ7um+cmRI5ByXLa0ximucujGoKZaC2pIknZTuC/Czymjq90q9xdvpm+Tkxk4kYHZ2zAVBeWVHjEMTds/dBlQ0r0Topmg7U5XMNQpJ8ueLq0oogwjY29DDg1M=
Received: from BN8PR15CA0007.namprd15.prod.outlook.com (2603:10b6:408:c0::20)
 by DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Mon, 25 Apr
 2022 11:43:58 +0000
Received: from BN8NAM11FT026.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:c0:cafe::70) by BN8PR15CA0007.outlook.office365.com
 (2603:10b6:408:c0::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.21 via Frontend
 Transport; Mon, 25 Apr 2022 11:43:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT026.mail.protection.outlook.com (10.13.177.51) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5186.14 via Frontend Transport; Mon, 25 Apr 2022 11:43:57 +0000
Received: from kali.amdval.net (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 25 Apr
 2022 06:43:55 -0500
To: <iommu@lists.linux-foundation.org>
Subject: [PATCH v2 36/37] iommu/amd: Update device_state structure to include
 PCI seg ID
Date: Mon, 25 Apr 2022 17:04:14 +0530
Message-ID: <20220425113415.24087-37-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220425113415.24087-1-vasant.hegde@amd.com>
References: <20220425113415.24087-1-vasant.hegde@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: aa373801-144b-4526-1df4-08da26b0e249
X-MS-TrafficTypeDiagnostic: DM6PR12MB2619:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB26191346CC8A3B7E18D2E10387F89@DM6PR12MB2619.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: x2vf7AW5Uj9ODKj3pSunnsUEzJHzXkNzFcM24aF8NFgpiBYHq0NDcfZNj4uJulKR3VpjgRSqshdhwpD7FydszvqlSHcEzGkDk/lL83kxaKVRw/nj9PJWcHAnSuzoLiS8xzw4vCJKNyE0VgPg0jO1+t7kLR+0uN9Uh49y3bcIOorh3h8P9QgYujp8Wqnnah16cFjZGIHWnBLjL5VJAI6sgqsDZtEVAcBqE+A2JOe+ucYm8ChsWgNl5pnpqZ1Lbx35sYGRfhk8suH47/7KsImlK9urdykffSMzJKp77PG1r/LWy3SFViFWlvJNkjGClGO0up58mon6uih76EpyopWv1lSN5F9sFfn58+BFch1XWExYpibUsmkwByhyJ+M0th69CXp1uBZd0JSdQ2Lh3R1CPGaGc8/XjWJP97eTIkoeeEKXAsD8eRzoPsTqzt/qHRspV654k4FUKOcHCVLp9+8wNkNJ1WHjued4VIyTIRrP0c2Klok/UymKQaqqO2kGWV7HKjp4zGawfZ7zSOEDUmk6RWbK5o6o5nMHK36DvLh/vPc93cuez0EVz+emzdmE7+uV8QaD5XduSm4UnfnOoR/H2xa2/OQAXjrdeoemicDPzE3H3FQVs+UhVh25wVMsj0MZ/BujMw5481y87IU9/YCFMCBhY+2aE2/BCaenVH0sVDhz4GecscJhQXuibztZxzW6927fUsHWf/l6BTGNYb0/5w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(70586007)(40460700003)(81166007)(26005)(356005)(70206006)(8676002)(4326008)(508600001)(5660300002)(86362001)(6666004)(44832011)(2906002)(8936002)(36756003)(36860700001)(83380400001)(54906003)(6916009)(316002)(1076003)(336012)(186003)(426003)(16526019)(2616005)(82310400005)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2022 11:43:57.8107 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aa373801-144b-4526-1df4-08da26b0e249
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT026.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2619
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
