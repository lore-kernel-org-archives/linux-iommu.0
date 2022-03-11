Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38C70C433EF
	for <iommu@archiver.kernel.org>; Fri, 11 Mar 2022 10:01:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id EDF666127F;
	Fri, 11 Mar 2022 10:01:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1Ezj0GgdXyPZ; Fri, 11 Mar 2022 10:01:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id A484061290;
	Fri, 11 Mar 2022 10:01:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7F6D6C0012;
	Fri, 11 Mar 2022 10:01:40 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E9859C000B
 for <iommu@lists.linux-foundation.org>; Fri, 11 Mar 2022 10:01:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D87496127F
 for <iommu@lists.linux-foundation.org>; Fri, 11 Mar 2022 10:01:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gF4r-TfYWHZy for <iommu@lists.linux-foundation.org>;
 Fri, 11 Mar 2022 10:01:38 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20607.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::607])
 by smtp3.osuosl.org (Postfix) with ESMTPS id EAE046127C
 for <iommu@lists.linux-foundation.org>; Fri, 11 Mar 2022 10:01:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B9NSy3oF9rRVTUb3G5bSU+ki7WKfgOou72Qx1jh8KQOSwrBy3aylhvY7cLgmdsQZFW8i7O8Okkyb3dOKKBnFWA9udsDfflVjM3VRsuV3WHRBYs2K4LVPhEg+yaURmuC+R9WvJl57XJLlioZNLA97IFHb/qMjTvjKnqnc7tfqpYzY8CmbrkCPCkrBl1g+QaSt4IT24/1ewxdoTHYbYnvPXwhCvL/+fdg86oj8qfSeQ50s8ebb3L5dvFTQRzy50XvzW1C8SsgjnatAWq6OLuQUkKBYxriaBgzYMU0l0I3BSkXwwi+Oxn4OlF5pMJwso1Lgrl+hzsjNBOuWcqu9ZkyikA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u6lCTcONL0CNGK2GOYhsU4OigDKkhX3PVh5/Pz17TVg=;
 b=WvvCJsGNkatkK8BuiL/5yj+CLpm/aupDtwsHr/MOFuWKNOX348dv3IZGX42T0jxc/RWP7YIVI4IUXkIDxNGGwcXwd4qEYUqXYw43kIBPY50wItj6yahl3e5UdFtq7OCWMiWqHYylYOsMzzoJPWlvM6laq5NZ5UrKmyYn2ocJKfCInAQb8eD8SpKDP+AQ55M2hZM7iDxVIc58OF7lPUrMpcaDF93tzvOTvP+K0dpBryWltoRw8JyUjU/+Ty7I/cAjmQWRBYqrDDLQTOXWP/RuiV8uRipNxYj3elrEouZIT4XYgLhfQ6JPE+E7NNX2ZouS98/amlZ0PHm3McNOVED+pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux-foundation.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u6lCTcONL0CNGK2GOYhsU4OigDKkhX3PVh5/Pz17TVg=;
 b=Nkz0TKBKP3IvNx02LDbRo0ThMi6fjyXjGnneulG3hFaE+stQCcTGCymmUZ7xfoZfdieAhBwpuvqVX3pyN6ibPi6E7niiTD/HazG/sQgV66jHUgpqygohXdJr0TkVdkBH8Zw8apvsG+93aAf2fDN2p+afo8rF8H5gFLbYUZ0N69U=
Received: from MWHPR22CA0004.namprd22.prod.outlook.com (2603:10b6:300:ef::14)
 by DM4PR12MB5309.namprd12.prod.outlook.com (2603:10b6:5:390::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Fri, 11 Mar
 2022 10:01:31 +0000
Received: from CO1NAM11FT015.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:ef:cafe::2e) by MWHPR22CA0004.outlook.office365.com
 (2603:10b6:300:ef::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.25 via Frontend
 Transport; Fri, 11 Mar 2022 10:01:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT015.mail.protection.outlook.com (10.13.175.130) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5061.22 via Frontend Transport; Fri, 11 Mar 2022 10:01:30 +0000
Received: from kali.amdval.net (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 11 Mar
 2022 04:01:20 -0600
To: <iommu@lists.linux-foundation.org>, <joro@8bytes.org>
Subject: [RFC PATCH 35/36] iommu/amd: Update device_state structure to include
 PCI seg ID
Date: Fri, 11 Mar 2022 15:18:53 +0530
Message-ID: <20220311094854.31595-36-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220311094854.31595-1-vasant.hegde@amd.com>
References: <20220311094854.31595-1-vasant.hegde@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 36bebf75-7e7c-4550-d483-08da03461df2
X-MS-TrafficTypeDiagnostic: DM4PR12MB5309:EE_
X-Microsoft-Antispam-PRVS: <DM4PR12MB53099C8056DF60FF02073C37870C9@DM4PR12MB5309.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EKgL2blHsZ8iYBkdtPEN74OU+8v7vnUna2O1DWk3GeAffNqj9LwtBp90E7thldw2sffxGpGBv98YiPHoIix+77DVPv/bc1lzcPFg8NNmiCgRobdLau7T/+bcJ5OxmVb0tklAdyfobe64RjG0o37YRd/yzcx9Z+CbRBsDYYCEiiMOJQJBO7A8ddDYpqrV0XETgFTvM1k83yADl01mWMuudu05eVU6EJeQQqG5XePASK7NMWUDn3bOJAsTLMBz7rpssfzCflXq7oab7mVt3PwuBND9VAfTj6F3mzBjaSDbuPGzBx6DyhbSU1TUv6OSeiEUfaf+RKgTc971s3OTGwvHVrCKiG1jiU2QyptOHX04h1X1NwpTGJW5+roSfMuXgbzvqP2s42zJ5a/Sv8vVBkMRYags10Ccs8CrcLqPqSwSgRuIDIxFc7iDcpgEqx7ddOWdD4GuqkBUZYBkP89SWcm3rSZWpykbdma5ajWZX3R+s4gNYUd5Jq4wlD0POEJE6/66SAX+7CXf2sNS4Hi/4qkb7R6ffsOa7qKIeMyl4oUXqp4FcqtbytfbOrwt3VsEFZsmQcthmIZs3jEv+eKC6gbub8ssMpIkeg7cIIVPfSsnOM9M4uyD5XxYX5MuO7eL2W8fihvTyQ7KejUwmOvu55IpTxSXUfK9JB5pn6P55tWxHTKvvJ5ZTMG1gHHe9e7NmSz586z+hX5BIH+k2Ify1pVGzQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(336012)(16526019)(26005)(186003)(2616005)(1076003)(316002)(508600001)(54906003)(356005)(6666004)(81166007)(110136005)(40460700003)(86362001)(426003)(82310400004)(83380400001)(47076005)(36860700001)(36756003)(4326008)(70206006)(70586007)(44832011)(8936002)(8676002)(2906002)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2022 10:01:30.9206 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 36bebf75-7e7c-4550-d483-08da03461df2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT015.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5309
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
index c72969ac4956..763bdac38a42 100644
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
