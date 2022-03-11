Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1CAEC433F5
	for <iommu@archiver.kernel.org>; Fri, 11 Mar 2022 09:51:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 68E99842FF;
	Fri, 11 Mar 2022 09:51:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Rf9sKa520Nrd; Fri, 11 Mar 2022 09:51:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 3FF1B84302;
	Fri, 11 Mar 2022 09:51:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 183C1C0012;
	Fri, 11 Mar 2022 09:51:05 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2183CC000B
 for <iommu@lists.linux-foundation.org>; Fri, 11 Mar 2022 09:51:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0301884307
 for <iommu@lists.linux-foundation.org>; Fri, 11 Mar 2022 09:51:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id IqZih7HCsg4c for <iommu@lists.linux-foundation.org>;
 Fri, 11 Mar 2022 09:51:03 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on20631.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8d::631])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 14088842FF
 for <iommu@lists.linux-foundation.org>; Fri, 11 Mar 2022 09:51:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FcHpSQj/BML8or98g6AyKHQGwwvHphkpsgbn3gR8PP3KQ0oYqWrER7zhA2nh1KBscW89Nx0o0xGFSxqUeyIwhdf5A5ySKmnPK41m9SJkyehtfIf48WQhH1fR6ZcMcRvRPWQyvIlcIUbCeyD0QY/5GTn3nJlEf3uNRqEPImXG/bxIZtfJRRQjdoXowZT+QP+Gf/mY+LgqOgh9hYv8WMuCCFuZSDTuzJqIabpRn+FmurirH11R3K+rlCcensLqPqPF0RVqdUwRW/WlSk+JFlQs/Lba90UPEI22gJEUwTqmC2JMyGWpe8PHVt/jFUTUX7c/futAlbizDWDCf4Ex+t54Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uIjQsw3XnwUAb/FTpCDK0IXkA2HYz3xuZTRLlEzKkVg=;
 b=gV5lmFJD0UaTay9FbkQ7mq4Lrg+F+YLYAMXF2E3nA+7SZjQe/5o57Dao6TtdOyp89ZDq9ONKU+rtqh+EE2GL5f81BrZVXd3WYOnrtpQw8SFGJFimuMh9oRf9wyRim9KlKw/kQsiisms0nJ/PF6/f6kWoIPLDbeRCyu2sSK0/2WacJ/CTc2t4tadyCUL970I10FgQXhrnWi6PN7Fh/Zv0W5o+s6Qpyepj3YPquwEFlcQCupN+qqRc1TEsA91RXA+QvA16PM481cjYywNA+epwBPhW1Y/dijKm6+Bo7O7uDR7zvc2S5ri1ptJ1tigqWR60zzUEx98Qj4/OufiaXoIfdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux-foundation.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uIjQsw3XnwUAb/FTpCDK0IXkA2HYz3xuZTRLlEzKkVg=;
 b=VtVu/DSVdkTPI4NPfg3ddkrBtRbd10qTu5roDsbEAQlCGxS2wFn2svbjGnK+yQ/z0Hqic68SLYhpvDbK9OZF173HJ3agFRp9bHfN1xgEPKcUXrXMFO7QIuLkqY/UgEGeOjwOzkGBDYJi/v7qzwVjWhx9hDqr9G8A+J4wMnX9MRE=
Received: from BN6PR19CA0067.namprd19.prod.outlook.com (2603:10b6:404:e3::29)
 by CO6PR12MB5443.namprd12.prod.outlook.com (2603:10b6:303:13a::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Fri, 11 Mar
 2022 09:50:58 +0000
Received: from BN8NAM11FT023.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:e3:cafe::72) by BN6PR19CA0067.outlook.office365.com
 (2603:10b6:404:e3::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.24 via Frontend
 Transport; Fri, 11 Mar 2022 09:50:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT023.mail.protection.outlook.com (10.13.177.103) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5061.22 via Frontend Transport; Fri, 11 Mar 2022 09:50:58 +0000
Received: from kali.amdval.net (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 11 Mar
 2022 03:50:52 -0600
To: <iommu@lists.linux-foundation.org>, <joro@8bytes.org>
Subject: [RFC PATCH 05/36] iommu/amd: Introduce per PCI segment dev_data_list
Date: Fri, 11 Mar 2022 15:18:23 +0530
Message-ID: <20220311094854.31595-6-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220311094854.31595-1-vasant.hegde@amd.com>
References: <20220311094854.31595-1-vasant.hegde@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5a6d51f8-b4d9-408d-080e-08da0344a4c5
X-MS-TrafficTypeDiagnostic: CO6PR12MB5443:EE_
X-Microsoft-Antispam-PRVS: <CO6PR12MB5443979C6023582B1835B756870C9@CO6PR12MB5443.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lEBEtOd1rnz2ywvt9jOCk6auGZGgnOPBudMtY6SvsA29QehdWRD41aQJzNZmERRdVJjirsjmutSKkK1KHUQAL3AOqYeVCtbZD/hChaXQ3Y3aEdg7p8xvm/2qM7dWgtF3eYVM+FnwCjBIh2hP329RY/64TDMewadBTRvJCQnMjoKg8wFnHB7nmEu2MwCCimklFQfWc7z83KhKiBed/2zrFxmr63AuBpKy5a2kDxPhtUZKsUCrtD+XsKR6a5CoUlchGSyvmNbeU/fL9jrOqoo2+jgqmZGSG8/iwLMSWPsPH9gz2eLi8uq5Dg41SbfDLxZMLKFU7LRy1whyY/8vIceT5muF+2on1sfffcn4IZbSVdana0xvduMBhJaz4uZJifb7+V5hMwXIO/iEuJBcR8LjDnLrJG4hf02C8IJWbtGZl9a4naci4wqOXuz+fRUd3/hrR1klUNaWEz0EDP2u8V5sntSAWGrH2VVrBL9AvJ4Fn9QjbRg0WBLxp0C1ZFa9sIFyJwRf6MQjOWwH7jGJsSUnkB5j/gOj1FfE3PtqNr+1SW+n5hTYGkAfCkzM1MT7ml8FyOrUHK31GRcA+w0s4qaEQqM5q+krCMOs9CsFMf7bJ75t7R80sFrw9CFBNuKzGGD+fj8GSOjKop6h4hW5mZ2Vl6l3xXH8aOBv+hrA8vPF/WWSVO1qf2CTE9hv2jnuHkdRwZgurB85iSM2BQ7PYNT4gg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(70586007)(70206006)(508600001)(86362001)(8936002)(8676002)(44832011)(2616005)(110136005)(6666004)(1076003)(47076005)(2906002)(36756003)(316002)(54906003)(82310400004)(336012)(426003)(40460700003)(186003)(16526019)(26005)(5660300002)(356005)(36860700001)(4326008)(81166007)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2022 09:50:58.2600 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a6d51f8-b4d9-408d-080e-08da0344a4c5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT023.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5443
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

This will replace global dev_data_list.

Co-developed-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/amd_iommu_types.h |  3 +++
 drivers/iommu/amd/init.c            |  1 +
 drivers/iommu/amd/iommu.c           | 21 ++++++++++-----------
 3 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 5330343ac596..31ae5a73604c 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -538,6 +538,9 @@ struct protection_domain {
 struct amd_iommu_pci_seg {
 	struct list_head list;
 
+	/* List of all available dev_data structures */
+	struct llist_head dev_data_list;
+
 	/* PCI segment number */
 	u16 id;
 
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 48db6c3164aa..27785a558d9c 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -1525,6 +1525,7 @@ static struct amd_iommu_pci_seg *__init alloc_pci_segment(u16 id)
 		return NULL;
 
 	pci_seg->id = id;
+	init_llist_head(&pci_seg->dev_data_list);
 	list_add_tail(&pci_seg->list, &amd_iommu_pci_seg_list);
 
 	if (alloc_dev_table(pci_seg))
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index fa473ee5be28..a9cd64ab6b1e 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -62,9 +62,6 @@
 
 static DEFINE_SPINLOCK(pd_bitmap_lock);
 
-/* List of all available dev_data structures */
-static LLIST_HEAD(dev_data_list);
-
 LIST_HEAD(ioapic_map);
 LIST_HEAD(hpet_map);
 LIST_HEAD(acpihid_map);
@@ -195,9 +192,10 @@ static struct protection_domain *to_pdomain(struct iommu_domain *dom)
 	return container_of(dom, struct protection_domain, domain);
 }
 
-static struct iommu_dev_data *alloc_dev_data(u16 devid)
+static struct iommu_dev_data *alloc_dev_data(struct amd_iommu *iommu, u16 devid)
 {
 	struct iommu_dev_data *dev_data;
+	struct amd_iommu_pci_seg *pci_seg = iommu->pci_seg;
 
 	dev_data = kzalloc(sizeof(*dev_data), GFP_KERNEL);
 	if (!dev_data)
@@ -207,19 +205,20 @@ static struct iommu_dev_data *alloc_dev_data(u16 devid)
 	dev_data->devid = devid;
 	ratelimit_default_init(&dev_data->rs);
 
-	llist_add(&dev_data->dev_data_list, &dev_data_list);
+	llist_add(&dev_data->dev_data_list, &pci_seg->dev_data_list);
 	return dev_data;
 }
 
-static struct iommu_dev_data *search_dev_data(u16 devid)
+static struct iommu_dev_data *search_dev_data(struct amd_iommu *iommu, u16 devid)
 {
 	struct iommu_dev_data *dev_data;
 	struct llist_node *node;
+	struct amd_iommu_pci_seg *pci_seg = iommu->pci_seg;
 
-	if (llist_empty(&dev_data_list))
+	if (llist_empty(&pci_seg->dev_data_list))
 		return NULL;
 
-	node = dev_data_list.first;
+	node = pci_seg->dev_data_list.first;
 	llist_for_each_entry(dev_data, node, dev_data_list) {
 		if (dev_data->devid == devid)
 			return dev_data;
@@ -287,10 +286,10 @@ static struct iommu_dev_data *find_dev_data(u16 devid)
 	struct iommu_dev_data *dev_data;
 	struct amd_iommu *iommu = amd_iommu_rlookup_table[devid];
 
-	dev_data = search_dev_data(devid);
+	dev_data = search_dev_data(iommu, devid);
 
 	if (dev_data == NULL) {
-		dev_data = alloc_dev_data(devid);
+		dev_data = alloc_dev_data(iommu, devid);
 		if (!dev_data)
 			return NULL;
 
@@ -3457,7 +3456,7 @@ static int amd_ir_set_vcpu_affinity(struct irq_data *data, void *vcpu_info)
 	struct vcpu_data *vcpu_pi_info = pi_data->vcpu_data;
 	struct amd_ir_data *ir_data = data->chip_data;
 	struct irq_2_irte *irte_info = &ir_data->irq_2_irte;
-	struct iommu_dev_data *dev_data = search_dev_data(irte_info->devid);
+	struct iommu_dev_data *dev_data = search_dev_data(NULL, irte_info->devid);
 
 	/* Note:
 	 * This device has never been set up for guest mode.
-- 
2.27.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
