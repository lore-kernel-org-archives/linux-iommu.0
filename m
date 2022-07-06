Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2061.outbound.protection.outlook.com [40.107.243.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04D6633C6
	for <iommu@lists.linux.dev>; Wed,  6 Jul 2022 11:51:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TIdPciThjqBrWJMBlpU/ub8CCyMloPwU1c0B6A5CvgGyzTQzGDiXWH/6QweW4Xquswo0CTvWRSF+zQUUyvHWe0TmneEynX90rmmU9w7iWYrW0SmAhvS5E754e8IQBPBhIGKID0U9qzPRueC06UDoOrFsQ0Y69gC0C2j+kmI3QX6VzK92v31v/3qs+MqZSiFp15SvQKl6GMJ1HChyKwxO7Ns+tMTaX/fp33ocE4+4ed7W9U2jEX9jWMtDJeJxwGwq8wCg9ctqkk6X6f2s0cm92Hug5TXvGPAzegFypFyclE0S3MkrG/YMUX7IjqNUQR5hVuiv0iCm9y4NnQJsy6Z3ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7cpL5D566G+d/ZQ0JEAbYGsRVmJ/HcuXHs1Ftz8iVAg=;
 b=dmKkcpXEXuLvGfFPELJgLyjeI83EqbsIKgWy7zsfI2IGRDOjkcQ51JO6wlCTV5OKPgwqctFot0UUDhtU5MLnK0HPrlipHi1y5eNj64fzSiAMmHb53BeCb2dGtlG38WpSKkl7GSj02SYPoguOvAGHXj9BI7agbe9nGn8NTbewoPPNddj8SNA7I+YrUht+XDQMBYhZ7shl1SGbeMg5lrhuk6ICh53E4LiG+kzQvz8YSkkK8ALRN3oNtIshm2zJombOnwKpGg+P4XNBJCiKNXlAslcQ34YXjMY/8Q06XjEyXkikNnrN2R8DIM3iGjZ4MtGH+lPadNFwwoaxDXDsBQJ7CA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=8bytes.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7cpL5D566G+d/ZQ0JEAbYGsRVmJ/HcuXHs1Ftz8iVAg=;
 b=LtCgr9RizS01lBhEcR6/mUQJ1eaoE+8jewVmhDU2G7Z1vau2y3zA/yJ/HEGjNHbIXjt/NiIsySD+BOWY1ahggfIx8GQNB61Q1mrhpHnyJQallhH41g/DROvLKy0GPREHQqpqTq3URACwGT95j5b5N4GKl5e+mFO04ei1vb73QSQ=
Received: from CO2PR18CA0045.namprd18.prod.outlook.com (2603:10b6:104:2::13)
 by IA1PR12MB6017.namprd12.prod.outlook.com (2603:10b6:208:3d7::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.20; Wed, 6 Jul
 2022 11:51:09 +0000
Received: from CO1NAM11FT056.eop-nam11.prod.protection.outlook.com
 (2603:10b6:104:2:cafe::c5) by CO2PR18CA0045.outlook.office365.com
 (2603:10b6:104:2::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.22 via Frontend
 Transport; Wed, 6 Jul 2022 11:51:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT056.mail.protection.outlook.com (10.13.175.107) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5417.15 via Frontend Transport; Wed, 6 Jul 2022 11:51:08 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 6 Jul
 2022 06:51:03 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <joro@8bytes.org>, <iommu@lists.linux.dev>
CC: <iommu@lists.linux-foundation.org>, <suravee.suthikulpanit@amd.com>,
	Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v3 RESEND 34/35] iommu/amd: Update device_state structure to include PCI seg ID
Date: Wed, 6 Jul 2022 17:08:24 +0530
Message-ID: <20220706113825.25582-35-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220706113825.25582-1-vasant.hegde@amd.com>
References: <20220706113825.25582-1-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9d9f1d3c-7fc9-4e81-ea7f-08da5f45d08b
X-MS-TrafficTypeDiagnostic: IA1PR12MB6017:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	OzmWIPqCdUlCWzYxMr6JU/2nYTmnUREkdfWKDaceoh89CyW5AkoqPaqXhW77ZXJA7nkNVKKXCU9yemC0FD1Li76/MYvpAUY6lApzUiVI5HFJbWKyRX68R5BcliFCJHwcvt3A5HZWPr2UDpqnC50rWralCL1/D0XvJMcfXTD6H3VJCDd0No5s609k9z7tY8PUjQRXjzgHbpCnAncpAGJIw8WGJILX0phfB6Ou173+jZLLUKK7+8ce9t8VIs36a5NK/v6IZ4xdqRe/pZjpx73RbB+UN3PGHSpvG3FYJE1ysJCcOuz57d2zezdeLSprhWMzRDPmWNuVNa+pFCjgKWlR5VxGZYKN6C0xaUuxIReBDMc3eS0obuDsSjcWpotJOWqFyL6L9F61wD/w9c9KR+ACVCHGWGw+AasE6pnsDcIfCGYFk5Lf40YJeGHSBs4rftALIB5ZuYRf8eepanf9wYrRkbo4gKPyTwg9v1KOAaGdqA9yGLmnS73DMEWPNEXk6QqwixgPzK7Pw5PMexON+VXf/j7spqbO4srXrNc4jtdxv81RmDhVwr/u1um1mSp0lh+1mOblJUQrn+RwTTcXGgFjTlEA6TUsMSWuQI73+JcJapYtbncxxNo8/z1AMhDHYjTLZzLnMTtL44tB8taMfjEGUkd823bDwgXatTpJwEkabQA9c2GrkvdiSgPTJfR8HpfuHI4xoLLQGFlaCqDsEuAciWmIb3Ol85X4HRcEdjiwwS+oa7pR3v/PQRakOZB1sOZDE14tLOzPYxUItBQJB2GCVn0qTVuHcj0ZEqccwYyLby4qlY0yXX4UrFKoSLS/o1j5OusoVkv8/KfowwHWUxGNvYCmnInXz+LK3EcdYVBMHGWBX5LUmC6rpYnAiJIFuwSt
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(136003)(39860400002)(376002)(346002)(396003)(36840700001)(40470700004)(46966006)(40460700003)(5660300002)(2906002)(36860700001)(356005)(34020700004)(40480700001)(426003)(478600001)(82310400005)(36756003)(16526019)(186003)(44832011)(336012)(83380400001)(47076005)(82740400003)(2616005)(6666004)(110136005)(4326008)(8676002)(70586007)(1076003)(86362001)(8936002)(7696005)(70206006)(316002)(54906003)(41300700001)(26005)(81166007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2022 11:51:08.0684
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d9f1d3c-7fc9-4e81-ea7f-08da5f45d08b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1NAM11FT056.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6017
Message-ID: <20220706113824.uJ9xlXU6ra8zj-pfIA5CrAG8hFuP9ZIh6bsRupK20rk@z>

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
index afb3efd565b7..40484af2ffc2 100644
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
2.31.1

