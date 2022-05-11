Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 539F1C433F5
	for <iommu@archiver.kernel.org>; Wed, 11 May 2022 07:23:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0834441879;
	Wed, 11 May 2022 07:23:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id j873eYZaUYiT; Wed, 11 May 2022 07:23:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 739EB415A2;
	Wed, 11 May 2022 07:23:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 54A49C0039;
	Wed, 11 May 2022 07:23:50 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 53BC2C002D
 for <iommu@lists.linux-foundation.org>; Wed, 11 May 2022 07:23:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 42B30831A7
 for <iommu@lists.linux-foundation.org>; Wed, 11 May 2022 07:23:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=amd.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id x8JkT-hr3zYa for <iommu@lists.linux-foundation.org>;
 Wed, 11 May 2022 07:23:48 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2061d.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8c::61d])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6F8A381836
 for <iommu@lists.linux-foundation.org>; Wed, 11 May 2022 07:23:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JIukLAHqeJkkytNkg8cStfsvucaQqoxFlRu6LtUWwuCSONsKGl2Gg9MNeyixIylUMObouSlw/7S0JPU30MZxdIqXafUPEDfypWqNwgkrSGuZD0l1uVGeuxqrnm30l1q5jUi+60c8NFHjrgtzEXXMGewn0TfxtukUNC7ZRAtaP8LuaGgayIvpudTYcE1wmB1C3iLjIelasZ1lfy8Qe+PBxPCjBzKwcVrQ1AIGZ8FbLYW18KboY5W6vJiuuy8qruDImKhkFOQAayQE/LtIGCh1uW8wIHNzRsUZ7wjLpWp17LdbB6dDR2hx2WcQNwRMMVIDfH6IW6oV5ctxXGaIHLkbfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sbeOv6jldpilGHjCr/5rnA+Sj1VxUr4Qs00/gmbidUM=;
 b=KBb1a06KIRlI1cMel6vu2dG5byYuoezgmCaXipfDUJpkOBhis2yiXeu+rgD01Mrjpyy6VJLPG0vjbwfsEt9tbzdmkwzCI8P7u+1lYQfLY0vg51gBHWNFO6Cb0rUubaP7FWUntoNPshU4W35MU4NhJqZbSM+ic6vOvSDGIi2Xk7dW7PX1ucpTh5H410en3MzhemgwPtmXaPaOVxAVAurITNWxL2TEhOaVgPtwWuxsSg2uR40X1C6iVv8L5NAEzJtxEVPqRAcSe+chtMTYWalRLPjIshrs8KLQSVkjRHNZ+y5FPB8Dq7eIiO8Uafy1a59rVi6vRyh6kWxiudzkYB19qA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux-foundation.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sbeOv6jldpilGHjCr/5rnA+Sj1VxUr4Qs00/gmbidUM=;
 b=GbboLjs7o8S/bgsFpHS1y5Mh4tqNUH/n1lyMOt2xnSmAylItK4TQV+ooSKQ28+7l6To3OFEf6n6hglxYedY570dq9+AVbqGLbFTGd8sGnlfokLKLyOrjv5iOuQbmIkbwH6b4co6bkJZ1zOBxXp0CV8RWlc0wuNlpEhvLQDdqPY8=
Received: from DM6PR08CA0021.namprd08.prod.outlook.com (2603:10b6:5:80::34) by
 MN0PR12MB5881.namprd12.prod.outlook.com (2603:10b6:208:379::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.20; Wed, 11 May
 2022 07:23:45 +0000
Received: from DM6NAM11FT037.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:80:cafe::e) by DM6PR08CA0021.outlook.office365.com
 (2603:10b6:5:80::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.23 via Frontend
 Transport; Wed, 11 May 2022 07:23:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT037.mail.protection.outlook.com (10.13.172.122) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5250.13 via Frontend Transport; Wed, 11 May 2022 07:23:45 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 11 May
 2022 02:23:43 -0500
To: <iommu@lists.linux-foundation.org>
Subject: [PATCH v3 06/35] iommu/amd: Introduce per PCI segment dev_data_list
Date: Wed, 11 May 2022 12:51:12 +0530
Message-ID: <20220511072141.15485-7-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220511072141.15485-1-vasant.hegde@amd.com>
References: <20220511072141.15485-1-vasant.hegde@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b5949b56-7834-4906-c646-08da331f2f4a
X-MS-TrafficTypeDiagnostic: MN0PR12MB5881:EE_
X-Microsoft-Antispam-PRVS: <MN0PR12MB5881A91BDC4C35959B690CA887C89@MN0PR12MB5881.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QE2F4qvd6pfPsgxIT0dHHjyPpeXvAPiK6iEu2hGU6nrOnY7OIaRpQLa8bst+ghzuCYuoyJzbeaG+RqaT/dRO4l0JCR4IoiKYWq90aDcMwDZgcZpvRIuUIBPej3zjJg5q78XqTGugKPAV0Zr9wVshuUhxLzxtMIXWpJBihSe7EvtqBMzlH5cOUJUC/2xYcb0WSffBKBXwLMLcSy3oF/TcrJd4tigAoQGYwnT6UJxfcGI7JD5kDuDPo+QSg73GaNUsqe4jQFpK0utLA2TDZl6WEDWDl3r5U8B0ho+ygn6Y1f3ANNPAesBit4WqZkzOTdIN5iJfL5Bu3kB0bpog/Kt5xxVuMAmvNVkXq/HPuIdjeioSX0tN4W9BjyCGZ2809xjFPVctw10Xd40bKWfuhtdhe+cevnAJvKlSs/JETFTEC8vyDO4h5/a9/Iy0cbhCZfnxLW6b1axxOLpPW0jB9MZKvoO6Vj6a9iVXGt6yozkL4GuwBXtry1+UB0lazKJr6Pf/HxXDXvEKv7wPNuMmsdzTYz/2TCyo9Jd80NzoxAJsWATESY2c2Bz0oo4nTAL+Bp/dyHKeyeT7R5gPNHHoOi7ng1e4jxn8XP76tGGvK2QorjACfkzti6D2MnPnaMI1PX81Ch8M+8gm/PT0dlcjWZIZn/FtOiirv0yWeO9hmGwOmaGCXcW7jAqlcwNsbdkRSZzMAXfKkHdgY32rThDULhEYWw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(508600001)(316002)(8936002)(356005)(6916009)(36860700001)(81166007)(54906003)(4326008)(86362001)(70586007)(70206006)(8676002)(6666004)(40460700003)(83380400001)(44832011)(26005)(7696005)(2616005)(186003)(1076003)(426003)(47076005)(82310400005)(2906002)(336012)(36756003)(5660300002)(16526019)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2022 07:23:45.5685 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b5949b56-7834-4906-c646-08da331f2f4a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT037.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5881
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
index 55792edfcfbe..7dac61226208 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -542,6 +542,9 @@ struct amd_iommu_pci_seg {
 	/* List with all PCI segments in the system */
 	struct list_head list;
 
+	/* List of all available dev_data structures */
+	struct llist_head dev_data_list;
+
 	/* PCI segment number */
 	u16 id;
 
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index f513591a0646..144835a5cf6d 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -1525,6 +1525,7 @@ static struct amd_iommu_pci_seg *__init alloc_pci_segment(u16 id)
 		return NULL;
 
 	pci_seg->id = id;
+	init_llist_head(&pci_seg->dev_data_list);
 	list_add_tail(&pci_seg->list, &amd_iommu_pci_seg_list);
 
 	if (alloc_dev_table(pci_seg))
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 1590270ac54a..f0764446dea5 100644
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
