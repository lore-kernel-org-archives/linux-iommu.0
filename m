Return-Path: <SRS0=8SnF=MO=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19859C6377D
	for <iommu@archiver.kernel.org>; Thu, 22 Jul 2021 10:43:58 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3E4B61279
	for <iommu@archiver.kernel.org>; Thu, 22 Jul 2021 10:43:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3E4B61279
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 6986E401D3;
	Thu, 22 Jul 2021 10:43:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4r4I7rSBnL6C; Thu, 22 Jul 2021 10:43:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 9E002400CB;
	Thu, 22 Jul 2021 10:43:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 75FF8C001A;
	Thu, 22 Jul 2021 10:43:55 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F354AC000E
 for <iommu@lists.linux-foundation.org>; Thu, 22 Jul 2021 08:16:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id CC4E140189
 for <iommu@lists.linux-foundation.org>; Thu, 22 Jul 2021 08:16:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id J5jYoqz6BLCL for <iommu@lists.linux-foundation.org>;
 Thu, 22 Jul 2021 08:16:43 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2041.outbound.protection.outlook.com [40.107.100.41])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 8823E4013A
 for <iommu@lists.linux-foundation.org>; Thu, 22 Jul 2021 08:16:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cVu85ZIThPP7jKvmL2tqx8is44Lfw50XYK2IsJahlFRgVNC3fxBWBK7bMMUR12dVCRWChSpMLaEHrEDlCg8E1mjOn7Ar32iTeOGqUoILNf/M5jBW+TKgL3sKQjT832d2T8DLr4tVRJONrPM0jOw0aCkdfjluDwaWTn/LuENplhXGAUqafvfh2J95r9xP//KWciEpxTlu13XVklZgEtHXBO5YrO9Bt+l0XrYt7f+yYSoVMJCVySQes+5cvOCAQ5JPirCaCdjqice0mSqYECYGdkeTaY5RDzMI8zywnVV3FvYZ98abYPDU4ZAsdVQtGkiUAB0BQtvMfisPAau76Zb5sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t7d8NTvY56OthiuhXT1MhseKyRhztl9w8VrAkBAJoAA=;
 b=Ev50uWCLNCfFh+gsffBXwZOWD/sfej1cgDu1Z+Dv+yLCbK8sPOWWDshARPn0NZdEkBjWQlJvl5P5wL/A0w2/C5J4gY5Z+9caAyBiK06CftXbeQ6aELuLFP+n6Ov+KkljY7Fh+ITR/rTAY35wGrZVGuXe4ugM6jLMd6vGPUyciQHw7IZvHP19DvlN1q9qLmWxkp2GX12s50A21Cu2nG4vK3yqwEnfPFZ/aVrT6IaCsBlWovDqku83NTSiV7n6ngVIL422u7XRFs/fDTIUxIOME/GDQ9y/CzV/xb89XbNlO7UsFo4dEfno0MLQWSsrDUuNw7s+EM0MYRQxn8vzPCILrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux-foundation.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t7d8NTvY56OthiuhXT1MhseKyRhztl9w8VrAkBAJoAA=;
 b=MFeo2cPHXMNJ8UWGbQuLZgWz3qFPnRMz41OSfgoswaisNMK0KLNyfsSICjfBDzhmEJhcXjVaC94G9i0qMymeK7rsZIqCdCuI02H21SjYiAj/AqCn+bsm5QgkblOSA2kWG+qShgSNsHIJZBD2+d4YORA9MxaHjaTIVB8QpWANbAU=
Received: from DM5PR10CA0001.namprd10.prod.outlook.com (2603:10b6:4:2::11) by
 BL1PR12MB5255.namprd12.prod.outlook.com (2603:10b6:208:315::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4331.23; Thu, 22 Jul 2021 08:16:41 +0000
Received: from DM6NAM11FT014.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:2:cafe::d5) by DM5PR10CA0001.outlook.office365.com
 (2603:10b6:4:2::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.26 via Frontend
 Transport; Thu, 22 Jul 2021 08:16:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.linux-foundation.org; dkim=none (message not
 signed) header.d=none;lists.linux-foundation.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT014.mail.protection.outlook.com (10.13.173.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4352.24 via Frontend Transport; Thu, 22 Jul 2021 08:16:40 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Thu, 22 Jul
 2021 03:16:40 -0500
Received: from z-bu18.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4 via Frontend
 Transport; Thu, 22 Jul 2021 03:16:38 -0500
To: <iommu@lists.linux-foundation.org>
Subject: [PATCH] iommu/iova: kmemleak when disable SRIOV.
Date: Thu, 22 Jul 2021 16:16:29 +0800
Message-ID: <20210722081629.7863-1-PengJu.Zhou@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1c0288bc-5d16-4153-2721-08d94ce908d1
X-MS-TrafficTypeDiagnostic: BL1PR12MB5255:
X-Microsoft-Antispam-PRVS: <BL1PR12MB52558483C738F6623AC29E90F8E49@BL1PR12MB5255.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:422;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SphFJ3FHEFOQpxN2n9WeyIzZz7zQtu/ltgIT3OJMKNd1MvUnIcDnWkyJABDignfSQyvrdWxnv3LaXJaM4hs4T3oIM4vnlOTEephnO7WeEcY82TVMf+Vj8+2D1pP4z9FCl6UvQ1mnqYYpBAwS8KV9myP6EADASEcwcLamzRTDRXWZVEQ25SS4zavL2CA3aP02yKZ4/4h9iD5lskZugCgp45GHgnz5sHjcLOnQ4+VEXozgEFOAOqJzR8Rf9wP2DknGCa0oexnyKWjHueSq+661iGkoZQ8l4yBwKcwlrJd0G2F9DIzIX4Hn8pSVP29WoPMBi7425B7XyZskjJJb7ZnAR+xDr7BioKQjTTbLX5ZWLo5LZBOoHLhYunqlbDRzWmf01MkX8sbcGZE4AGkBPvDz0sHLfpKJ/3G9fupsGw1ZTCLOL4t2MZ5rgU0eHlI9NV1RQ4mxOMOIx0lU8W8++yqgyIvZYhzARIe13XGFMOvnE0ud7NypznKM8wf1Ya0Rk2PJnHqjrLmAGvjPUD8IEI2Yx7g+XF+sxx6huIChbmLRO6TKWo3WLRBpW5xD1tQsWkwKWxHZzUNqfSMAXBXjt3a121xQCvBOjX5vObFQmmsuRhbPJ8Ww4JpOZG0e0BktcpXLFb2y0MvSqXX2nv8uuJ9sIfuDZakfFUeqEI2W5JfCNw8OtSJL/b1x5GVB2lEJDQMC10ORwACtrI2gP3wyjpnAslqpauX0RK3a96m1vEg8Hdo=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(39860400002)(136003)(376002)(396003)(46966006)(36840700001)(81166007)(82310400003)(47076005)(54906003)(26005)(2616005)(82740400003)(356005)(36860700001)(6666004)(478600001)(316002)(86362001)(83380400001)(5660300002)(1076003)(8936002)(426003)(336012)(36756003)(7696005)(6916009)(186003)(70586007)(8676002)(2906002)(4326008)(70206006)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2021 08:16:40.7582 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c0288bc-5d16-4153-2721-08d94ce908d1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT014.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5255
X-Mailman-Approved-At: Thu, 22 Jul 2021 10:43:54 +0000
Cc: Alexander.Deucher@amd.com, Yin.Wang@amd.com, will@kernel.org,
 PengJu.Zhou@amd.com
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
From: Peng Ju Zhou via iommu <iommu@lists.linux-foundation.org>
Reply-To: Peng Ju Zhou <PengJu.Zhou@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

the object iova->head allocated statically when enable SRIOV but
freed dynamically when disable SRIOV which causing kmemleak.
changing the allocation from statically to dynamically.

Signed-off-by: Peng Ju Zhou <PengJu.Zhou@amd.com>
---
 drivers/iommu/iova.c | 15 ++++++++-------
 include/linux/iova.h |  4 ++--
 2 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
index 2371524796d3..505881d8d97f 100644
--- a/drivers/iommu/iova.c
+++ b/drivers/iommu/iova.c
@@ -26,6 +26,8 @@ static void free_iova_rcaches(struct iova_domain *iovad);
 static void fq_destroy_all_entries(struct iova_domain *iovad);
 static void fq_flush_timeout(struct timer_list *t);
 static void free_global_cached_iovas(struct iova_domain *iovad);
+static inline struct iova *alloc_and_init_iova(unsigned long pfn_lo,
+					       unsigned long pfn_hi);
 
 void
 init_iova_domain(struct iova_domain *iovad, unsigned long granule,
@@ -47,17 +49,16 @@ init_iova_domain(struct iova_domain *iovad, unsigned long granule,
 
 	INIT_LIST_HEAD(&iovad->holes);
 
-	iovad->head.pfn_lo = 0;
-	iovad->head.pfn_hi = start_pfn;
-	rb_link_node(&iovad->head.node, NULL, &iovad->rbroot.rb_node);
-	rb_insert_color(&iovad->head.node, &iovad->rbroot);
-	list_add(&iovad->head.hole, &iovad->holes);
+	iovad->head = alloc_and_init_iova(0, start_pfn);
+	rb_link_node(&iovad->head->node, NULL, &iovad->rbroot.rb_node);
+	rb_insert_color(&iovad->head->node, &iovad->rbroot);
+	list_add(&iovad->head->hole, &iovad->holes);
 
 	iovad->tail.pfn_lo = IOVA_ANCHOR;
 	iovad->tail.pfn_hi = IOVA_ANCHOR;
 	rb_link_node(&iovad->tail.node,
-		     &iovad->head.node,
-		     &iovad->head.node.rb_right);
+		     &iovad->head->node,
+		     &iovad->head->node.rb_right);
 	rb_insert_color(&iovad->tail.node, &iovad->rbroot);
 
 	init_iova_rcaches(iovad);
diff --git a/include/linux/iova.h b/include/linux/iova.h
index 076eb6cfc613..553905ef41fe 100644
--- a/include/linux/iova.h
+++ b/include/linux/iova.h
@@ -81,7 +81,7 @@ struct iova_domain {
 						   have been finished */
 
 	struct list_head holes;
-	struct iova	head, tail;		/* rbtree lookup anchors */
+	struct iova	*head, tail;		/* rbtree lookup anchors */
 	struct iova_rcache rcaches[IOVA_RANGE_CACHE_MAX_SIZE];	/* IOVA range caches */
 
 	iova_flush_cb	flush_cb;	/* Call-Back function to flush IOMMU
@@ -252,7 +252,7 @@ static inline void free_cpu_cached_iovas(unsigned int cpu,
 
 static inline unsigned long iovad_start_pfn(struct iova_domain *iovad)
 {
-	return iovad->head.pfn_hi;
+	return iovad->head->pfn_hi;
 }
 
 #endif
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
