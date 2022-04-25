Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74F01C433F5
	for <iommu@archiver.kernel.org>; Mon, 25 Apr 2022 11:36:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 356704048F;
	Mon, 25 Apr 2022 11:36:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gBiADJutpoCP; Mon, 25 Apr 2022 11:36:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 1535C4045C;
	Mon, 25 Apr 2022 11:36:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F2DC4C0039;
	Mon, 25 Apr 2022 11:36:29 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BF604C002D
 for <iommu@lists.linux-foundation.org>; Mon, 25 Apr 2022 11:36:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9F70D409EF
 for <iommu@lists.linux-foundation.org>; Mon, 25 Apr 2022 11:36:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=amd.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id sUqkKI_m-Q24 for <iommu@lists.linux-foundation.org>;
 Mon, 25 Apr 2022 11:36:27 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20603.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e89::603])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 99C3E40991
 for <iommu@lists.linux-foundation.org>; Mon, 25 Apr 2022 11:36:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b+zm2LXQspWNNaMSSEcCx6UBf/zsZa4UNRR2cH7kVBGgo3oTfG/pImr227nNi0/bb6JjaN7JfYfyvv2QfHGjuHhra98xNZeu9bZ8izN0FgfJUMfIYtS0mrH9GK8yYR6twQQhGi1nP0qVgiBmCl/yDwt4iN3vNxnYwOd6kY1UOX0N399SqZ19Sh71ThLwvF+90zX6QSFiNbNJTaKvEUwc8GLrtSRteb3z9cJErVRdPVU7agaHJ7o9zggZPLbUjtcXEWShsBWxKLkhb42BmRRVrQMfeLdqTF/YJv2vGIsMaflO2XWKphpnRH9HsVLQ65x1LAJcw/1Z0p1MOwEeyScSPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ENeM+WnXDJxgRdfWaCLlOwHbvng5w8EgcYiNIE25bcg=;
 b=EM443WvTrkNlOsEigKP686ue/p3OBXRjyRuNT/XJOVpC7gog3NrEnfoyl9ypFraI2EcL+PU8ywHmsU4DX9uYINERYdK3F5Ny2h0RCFo09D+kioncb1f3Y0Gd+TGP81LyvKwc8WQJr5EWp2/7OtqnSVFmbwxJizupSm1oAq/dvrzXedFhjael/Ke9IPsredmLuqAnw9TUPb+R6rjKEJeyRWtZJ2KDNGdi8uE9RbZpnR53eum/VMZ1X/tHR/bgABfBKjpu5YtTZoitMyEH6fALfdcV0c/9u7AgducqPDrMJ83mq7HVwnnI0RsHuUaoKfr4nzfUzQejWDgpVWrYtoL9+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux-foundation.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ENeM+WnXDJxgRdfWaCLlOwHbvng5w8EgcYiNIE25bcg=;
 b=aAgFR2fhiuJldk8quWJoxBn9SfelealyZQMtajup6pVfJ5g6UZ8fnUCgwprYWn/kp10TANtu1c4BfW4h3Z8vqmgdWUyXwVuzJYoSgXQ+cbfzkdnDW9KdzwPyTtgbkNmPmdu6wLOJqjtKc8XUQB6CPbp2Gs0w5xKaQRPIm7XLrhM=
Received: from BN8PR15CA0067.namprd15.prod.outlook.com (2603:10b6:408:80::44)
 by BL0PR12MB2819.namprd12.prod.outlook.com (2603:10b6:208:8a::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.18; Mon, 25 Apr
 2022 11:36:19 +0000
Received: from BN8NAM11FT021.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:80:cafe::3e) by BN8PR15CA0067.outlook.office365.com
 (2603:10b6:408:80::44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.21 via Frontend
 Transport; Mon, 25 Apr 2022 11:36:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT021.mail.protection.outlook.com (10.13.177.114) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5186.14 via Frontend Transport; Mon, 25 Apr 2022 11:36:18 +0000
Received: from kali.amdval.net (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 25 Apr
 2022 06:36:15 -0500
To: <iommu@lists.linux-foundation.org>
Subject: [PATCH v2 05/37] iommu/amd: Introduce per PCI segment irq_lookup_table
Date: Mon, 25 Apr 2022 17:03:43 +0530
Message-ID: <20220425113415.24087-6-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220425113415.24087-1-vasant.hegde@amd.com>
References: <20220425113415.24087-1-vasant.hegde@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d23025c8-6c5c-4507-4cc9-08da26afd082
X-MS-TrafficTypeDiagnostic: BL0PR12MB2819:EE_
X-Microsoft-Antispam-PRVS: <BL0PR12MB2819F35D90CDBDF4AB7556C287F89@BL0PR12MB2819.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VK7utezbFdA5uLuTKgLpExgibFRvyAwgjazjOjxKR4rRT+BICoc8aPuxknXbsOyvTGOW1+5v3VbvB36J9I5RNT6cjlK5llBx60kMRdDmcPRJFXiYOAAZkRGV2fr2Dj6t/UkUJGSNBG5lQai/VWR5uv80SFS1sPX0rcIZv5iuUhBAD0fl0UEewQiIkdYMTecl7PpC8H1UOPMbcbMUcl8eecnHV9eaElPGsoG7VtH3sCzCqp2FWSn42/VGF4b7AA/3g6AnXp3MPfTJO94IFjnIhzJupvY90n5AqovXHLAh97GAr6bLDbcI58upF02k2O6c+3n9T3HzP0Nsr2wldR34Ieh94LtW6cDRFHBmf7f3kO7ZOpUr6j58TVFHvfb2WMpxZTTzsMFvvRGVZ0qKrh7zArwqbLw9X4uLtm8gFBVOSwsuOl2WA9YkpfCbjAEZ9qRpDhWETOqTQOZHYB7jlnQ6LSwAHJO8P8VtE/5a7/NUAdsrhbNkSBvOxFE6G9YLO7ZowT8Wionoy9mWOUnC+eBlr9y/PpWQFJke+WBorK5OEBpIWxSVdubpwWWcT/FdDQq30kQ1xodH1e/Rv/ZHrgMY658kMj/6LzMSErsdVyN4Qxz56fRLsQxRZPAgPTm05V+9Seq4yE1cT6tl6SlM2O1lOjRxr3ubv93t02Cyw2stlRr9zVEI3BAZKvnhV4EhOp+8qZKb52bl59j6+MDH3OuE+Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(2616005)(1076003)(426003)(336012)(186003)(16526019)(47076005)(5660300002)(316002)(54906003)(36756003)(6666004)(36860700001)(82310400005)(26005)(8676002)(83380400001)(6916009)(356005)(44832011)(70206006)(4326008)(8936002)(2906002)(508600001)(40460700003)(86362001)(81166007)(70586007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2022 11:36:18.4897 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d23025c8-6c5c-4507-4cc9-08da26afd082
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT021.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2819
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

This will replace global irq lookup table (irq_lookup_table).

Co-developed-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/amd_iommu_types.h |  6 ++++++
 drivers/iommu/amd/init.c            | 27 +++++++++++++++++++++++++++
 2 files changed, 33 insertions(+)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 9c008662be1b..d507c96598a7 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -557,6 +557,12 @@ struct amd_iommu_pci_seg {
 	 * device id.
 	 */
 	struct amd_iommu **rlookup_table;
+
+	/*
+	 * This table is used to find the irq remapping table for a given
+	 * device id quickly.
+	 */
+	struct irq_remap_table **irq_lookup_table;
 };
 
 /*
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index a2efc02ba80a..48db6c3164aa 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -682,6 +682,26 @@ static inline void free_rlookup_table(struct amd_iommu_pci_seg *pci_seg)
 	pci_seg->rlookup_table = NULL;
 }
 
+static inline int __init alloc_irq_lookup_table(struct amd_iommu_pci_seg *pci_seg)
+{
+	pci_seg->irq_lookup_table = (void *)__get_free_pages(
+					     GFP_KERNEL | __GFP_ZERO,
+					     get_order(rlookup_table_size));
+	kmemleak_alloc(pci_seg->irq_lookup_table,
+		       rlookup_table_size, 1, GFP_KERNEL);
+	if (pci_seg->irq_lookup_table == NULL)
+		return -ENOMEM;
+
+	return 0;
+}
+
+static inline void free_irq_lookup_table(struct amd_iommu_pci_seg *pci_seg)
+{
+	kmemleak_free(pci_seg->irq_lookup_table);
+	free_pages((unsigned long)pci_seg->irq_lookup_table,
+		   get_order(rlookup_table_size));
+	pci_seg->irq_lookup_table = NULL;
+}
 
 /*
  * Allocates the command buffer. This buffer is per AMD IOMMU. We can
@@ -1533,6 +1553,7 @@ static void __init free_pci_segment(void)
 
 	for_each_pci_segment_safe(pci_seg, next) {
 		list_del(&pci_seg->list);
+		free_irq_lookup_table(pci_seg);
 		free_rlookup_table(pci_seg);
 		free_dev_table(pci_seg);
 		kfree(pci_seg);
@@ -2896,6 +2917,7 @@ static int __init early_amd_iommu_init(void)
 		amd_iommu_irq_remap = check_ioapic_information();
 
 	if (amd_iommu_irq_remap) {
+		struct amd_iommu_pci_seg *pci_seg;
 		/*
 		 * Interrupt remapping enabled, create kmem_cache for the
 		 * remapping tables.
@@ -2912,6 +2934,11 @@ static int __init early_amd_iommu_init(void)
 		if (!amd_iommu_irq_cache)
 			goto out;
 
+		for_each_pci_segment(pci_seg) {
+			if (alloc_irq_lookup_table(pci_seg))
+				goto out;
+		}
+
 		irq_lookup_table = (void *)__get_free_pages(
 				GFP_KERNEL | __GFP_ZERO,
 				get_order(rlookup_table_size));
-- 
2.27.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
