Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55BD3C433F5
	for <iommu@archiver.kernel.org>; Mon, 25 Apr 2022 11:36:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 090C14109B;
	Mon, 25 Apr 2022 11:36:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Fbu69WVZLTkh; Mon, 25 Apr 2022 11:36:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 87452409F7;
	Mon, 25 Apr 2022 11:36:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3F3B3C0039;
	Mon, 25 Apr 2022 11:36:39 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F039CC002D
 for <iommu@lists.linux-foundation.org>; Mon, 25 Apr 2022 11:36:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id DD243409F7
 for <iommu@lists.linux-foundation.org>; Mon, 25 Apr 2022 11:36:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1-f405w2HqDh for <iommu@lists.linux-foundation.org>;
 Mon, 25 Apr 2022 11:36:36 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2061c.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7ea9::61c])
 by smtp4.osuosl.org (Postfix) with ESMTPS id CB24F409EF
 for <iommu@lists.linux-foundation.org>; Mon, 25 Apr 2022 11:36:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bBcZvB9BU6rcxYh/6D8HtgFUPDWF+3/lFhmVvOJtpo/I1DwlQBH7fQ0H5f1oJ5pmQfNDOQqEklfB4CbUL7uZVB8vh5jyhUpbSvoDxnRzQ7iRW70ZraMe1+nCiCR+Am1mP6CAhVz6PNQJUdRHOlVnIdwQ/yWBUEdn27eNGCkQg+emzXo2S3ME9dobLNNQMet4Uyb/l/nATW5vU2V9DEf7goaenjYHQXe7K8Wt7j53J7kR5Z4Q+xTIozuqzGeetpTeOAMUJMnARGBCLZcmUFmcONNFeGYx4Q+bRhwpgPCA7pWknhMtbkQYunGOaFeHD4/47ijRHuScLiPf0hpFhrkTTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dYWLDhPIruV3trMynJ0mv/BggHkXvz3kae/ZR0sC+Pw=;
 b=mcxJZPAkasx+NdUpsOcYVKCk7cU5VFNlrYy30MBfHONMB4K+fBCvj6twCgH1Ythaq0qSCa0DR6dU+Mad7CRCol1i6e+GVrPmMYFWNqPHXgXzKWHV3nBGQU2/Z/t40xx+xUpujrcLz61oRS0YVqn82bLo3skA+O+aIOO7+Edy6Fh48pZ0uMtIQFMyVX/mjtPNgUGsx9b+nkMi6CSqaX4q0ymw3Ve6Eu6ZzBQuUSXP/C/osjTqzwFXxyHNGgsHP6li4jDGTA1av/d3fH3XN3BJqNYIQVpImYVkZRxolGRi5ikBMTZ7mjncAq/xnkjZcXt9EsnC6l0Qfag1zwInktPlcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux-foundation.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dYWLDhPIruV3trMynJ0mv/BggHkXvz3kae/ZR0sC+Pw=;
 b=oePpU9mag3jrUw8am1fnZ2OGEEdg8kaTKPYZ1VYjSq6P2JIxjGgBH0m3Zxb/9oe6vooM4r+qGw6EP0ddH3MkRbxSVQnLhfTg3PZmiymUF5kKxc3g0Pl80xHtYpbnyVxiaYJdo88QH6ngGg+NHCFjozfc4ZdzLXTbSLNUJVB1uV0=
Received: from BN9PR03CA0786.namprd03.prod.outlook.com (2603:10b6:408:13f::11)
 by CY4PR12MB1414.namprd12.prod.outlook.com (2603:10b6:903:3a::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.19; Mon, 25 Apr
 2022 11:36:33 +0000
Received: from BN8NAM11FT037.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13f:cafe::db) by BN9PR03CA0786.outlook.office365.com
 (2603:10b6:408:13f::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15 via Frontend
 Transport; Mon, 25 Apr 2022 11:36:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT037.mail.protection.outlook.com (10.13.177.182) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5186.14 via Frontend Transport; Mon, 25 Apr 2022 11:36:32 +0000
Received: from kali.amdval.net (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 25 Apr
 2022 06:36:30 -0500
To: <iommu@lists.linux-foundation.org>
Subject: [PATCH v2 06/37] iommu/amd: Introduce per PCI segment dev_data_list
Date: Mon, 25 Apr 2022 17:03:44 +0530
Message-ID: <20220425113415.24087-7-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220425113415.24087-1-vasant.hegde@amd.com>
References: <20220425113415.24087-1-vasant.hegde@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 527c801d-b961-416d-0ae9-08da26afd8d8
X-MS-TrafficTypeDiagnostic: CY4PR12MB1414:EE_
X-Microsoft-Antispam-PRVS: <CY4PR12MB141497CA3BF056A6F0CA1A4687F89@CY4PR12MB1414.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3WG3irPbaPt1xUJT4iqHfS0hvQ0ctrQZt1tOzQUIRThuy5BiU+Jik9bknai796YH/BTtjItiPggK/D0+DL4WVQhq99WbShO/ivC2YDnQjWqApmyCeHxMSHULOet6U+sIe2PCK+1yJUn/Y9qG76LTG0IVO57FUqKVHGAAAGTpRAeTJD/+ZoJ975DGje76TLzQFcR8mF0OuSv8KEi0b2W1JdqiavAb03Pe4A1zoTcE3pkeHYa+YDDx84ULMEERckkl9MuYB0fLTVnROnQu8pO1hKQ3b4eE70dCq5qzaXGi5n899yhpj0JyE2Cz0iknQtZ7E64/e/WluPG85E9ur5NPLeEfIH/UeQn8DhFr0l6NQP8qenGpm1YazcTM4VDtaxcAax4f79olSQ+tHm6APOhLFVvrYOC+aBfFY0LbZV+MwbSA/USvH6ena0Qqn5oFE0cMIAI6g7yEad11M4Li0dabexdWEd9KzscL+Ih23hnIZXcwqb0K3uoamhU0uFV2JJb9WlaL9iojf2artO7rZQpQ55MdaRt1DxetTmliEmanTzp4duXIdLZVLgyF8/0XD+7Pzba198UqHNpjTN6ku4TXhuH+in63wZJIk+Hlw8qDdUO826iCHGXMp+npAULMl3277p1o2MR+6cfsoPkgS9cFQMfbHE6YUCeDhA3zm2zOWrb4opMlJlUFnATwSsgwaBbmDDFgx3Lcz/mqXl47h+06nQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(36756003)(83380400001)(16526019)(82310400005)(70206006)(186003)(2616005)(1076003)(26005)(508600001)(54906003)(2906002)(6916009)(44832011)(70586007)(81166007)(6666004)(36860700001)(426003)(336012)(47076005)(40460700003)(5660300002)(86362001)(356005)(8936002)(8676002)(4326008)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2022 11:36:32.4891 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 527c801d-b961-416d-0ae9-08da26afd8d8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT037.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1414
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
index d507c96598a7..7bf35e3a1ed6 100644
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
index d9cf5b3187b5..63728e34e044 100644
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
@@ -288,10 +287,10 @@ static struct iommu_dev_data *find_dev_data(u16 devid)
 	struct iommu_dev_data *dev_data;
 	struct amd_iommu *iommu = amd_iommu_rlookup_table[devid];
 
-	dev_data = search_dev_data(devid);
+	dev_data = search_dev_data(iommu, devid);
 
 	if (dev_data == NULL) {
-		dev_data = alloc_dev_data(devid);
+		dev_data = alloc_dev_data(iommu, devid);
 		if (!dev_data)
 			return NULL;
 
@@ -3464,7 +3463,7 @@ static int amd_ir_set_vcpu_affinity(struct irq_data *data, void *vcpu_info)
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
