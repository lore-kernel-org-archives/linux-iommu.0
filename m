Return-Path: <SRS0=mF+O=GX=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A7A2C433DB
	for <iommu@archiver.kernel.org>; Wed, 20 Jan 2021 13:44:52 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A96CD2339E
	for <iommu@archiver.kernel.org>; Wed, 20 Jan 2021 13:44:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A96CD2339E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 56AE885F6C;
	Wed, 20 Jan 2021 13:44:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id N8h-YNNbEnkd; Wed, 20 Jan 2021 13:44:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 4AF4A85A76;
	Wed, 20 Jan 2021 13:44:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2BCF4C088B;
	Wed, 20 Jan 2021 13:44:50 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E50F6C013A
 for <iommu@lists.linux-foundation.org>; Wed, 20 Jan 2021 13:44:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id D282086961
 for <iommu@lists.linux-foundation.org>; Wed, 20 Jan 2021 13:44:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6CpQSzJTJ7mI for <iommu@lists.linux-foundation.org>;
 Wed, 20 Jan 2021 13:44:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2069.outbound.protection.outlook.com [40.107.220.69])
 by whitealder.osuosl.org (Postfix) with ESMTPS id A1418863FD
 for <iommu@lists.linux-foundation.org>; Wed, 20 Jan 2021 13:44:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LnxH0+0UOuVurswsqp1YYTOwdzfolOxmFBuiCZ2LMvYcHL9xiUUcB7I8DO+F3ns1GW2i4x1yzusRffkgG7YdaZIki3KXbS8RAz0zwiBRDoDc/pskgP1GU/yjJdkd0VySbKip71+Xq+TZSCL56CNvzDl1lHeJktH+6JbeGhHb4zLGqBdBmzG6lHAEU8W7BqkAv+c+qRclBTbCDC2CJJMJRahToRjsMCAHd7Yn9W08KxuLwbwpwT6HMF5+mQaIbwlbQM5WOmVNnhJH2lMpBZZitEE63VU/boWmbnSGTEBk++98GApGl5Vd7QGUqWdvDAKpYHrNLFxUzCtZ3T0XSkMVNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bBRBVKYbsNo6QWu4wv+B/xWSlPpK1uF6sY1Oj9nJIE0=;
 b=DSSi4mO6Pc2eV+c4Yvi/bPivc1baFveWjrdjzLmth9DONZAihrIxvSejyCNYNQdwAPWWAa78qnBGeaAzlGgDPLKRzLSSfQbE8Lvu3wHK8JBFfCuYK4ukEh+/4KmtCSYAVZlxJf84TjWUFmAP+bmK2A9TDwxDrNACrv30DTQteVfujV7RlERq9nIZgN5UdjRdknnuQ36GXnDYDeHPzcvB7UssTq0/lHI9lALRnOZhGLJevkHU8KGxlSUIG1IWnTkRyVwbFovpMQ4q4TA2zVjCpODorarq6zwgvTzBDZ6TbPccMc/fG/p42sHUtTV1fBjoU6F/A0CvmiFDxB8ne7HVkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bBRBVKYbsNo6QWu4wv+B/xWSlPpK1uF6sY1Oj9nJIE0=;
 b=yhANKZo9tK28CnO9CzEouhBPVQiAmXDXjhigKah4j21Un7J6CQ9246tKhRrA3MhJixup0GjBSrmHNpGWYERyX9wZGUDNCyrVwGZfBeQzbc5Djiqz0xLbz2wb0N8ClFgm0UDeaQ4SZYxAFEUxqMVwHefsPU3Sm+mpeAzFIpu0Kn0=
Authentication-Results: lists.linux-foundation.org; dkim=none (message not
 signed) header.d=none;lists.linux-foundation.org; dmarc=none action=none
 header.from=amd.com;
Received: from BYAPR12MB4597.namprd12.prod.outlook.com (2603:10b6:a03:10b::14)
 by BYAPR12MB3128.namprd12.prod.outlook.com (2603:10b6:a03:dd::29)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.12; Wed, 20 Jan
 2021 13:44:42 +0000
Received: from BYAPR12MB4597.namprd12.prod.outlook.com
 ([fe80::a95a:7202:81db:1972]) by BYAPR12MB4597.namprd12.prod.outlook.com
 ([fe80::a95a:7202:81db:1972%7]) with mapi id 15.20.3784.013; Wed, 20 Jan 2021
 13:44:42 +0000
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: iommu@lists.linux-foundation.org
Subject: [PATCH v2] iommu/amd: Use IVHD EFR for early initialization of IOMMU
 features
Date: Wed, 20 Jan 2021 07:50:02 -0600
Message-Id: <20210120135002.2682-1-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.78.2]
X-ClientProxiedBy: CH2PR18CA0019.namprd18.prod.outlook.com
 (2603:10b6:610:4f::29) To BYAPR12MB4597.namprd12.prod.outlook.com
 (2603:10b6:a03:10b::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ethanolx5673host.amd.com (165.204.78.2) by
 CH2PR18CA0019.namprd18.prod.outlook.com (2603:10b6:610:4f::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3763.10 via Frontend Transport; Wed, 20 Jan 2021 13:44:41 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: f17b8c57-b60e-4949-2c9d-08d8bd498a23
X-MS-TrafficTypeDiagnostic: BYAPR12MB3128:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB31285E85CCDBD78EFF3A5312F3A29@BYAPR12MB3128.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:854;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yYpWqFXcF9KtO0uvdtxcFM/A8uBKxpkofeHu8ZMeSPOZwljZh49IJqVgPxFmL/pjQwT+vavIZcVP8/KxGIPVip2dMRaiIhjSCiQiXO7V8zXsy24BtOltesXE6JVtm/rZfwGjgtAXqiMWI0onPInco2Z6/a7iJ1wy8C5ljARsAQuE23Ob30PWyLEIUMkTQyln7OEfjebSHw3lAf26jxVug8GJkRnSxHsBoCe/SD2zo5xjwVJJ9rweV8D95k/WJPd11Cpjzt3HuWbIzWl+X78Bopmr8YDjol50WYWf1Ba7u9OV4qEDEIAIuJF4qq6XWkWuLKkKQTSvygi+pXVdCHd5NKtbtAlVDCBMycPCEvP7NRqmLpBUT8IkhmEz5wT/QpdP1B2VIT9YD91DgpLB9QW+BA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4597.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(376002)(366004)(346002)(136003)(956004)(2616005)(8936002)(36756003)(16526019)(7696005)(4326008)(316002)(8676002)(5660300002)(26005)(6666004)(44832011)(52116002)(6916009)(66946007)(66556008)(66476007)(186003)(83380400001)(478600001)(1076003)(86362001)(6486002)(2906002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?uEWD1DNvoGrWJ0qY51LlRC3gd+nwYKFiuqrF/oKe40MhAXtmUdcnWjuK0QYG?=
 =?us-ascii?Q?cgc5apE/y9NgNSZVvvu2N0tYFwsWB8DE6JLbIWozfVaAcieEXUB4O4BC/9xY?=
 =?us-ascii?Q?6/KhE5ZIqtAozFBbbr+uwvdPlVjwIarvGK7KkI6WPR+VYtmBHHrUhVDV5RsY?=
 =?us-ascii?Q?eaD4J5jFQl4cqDQ3S1pv+w8dZ4u524i6uAnttmZ02hSxuA0RM8PJ5ZW1NEPw?=
 =?us-ascii?Q?MpCUaA/OT9Qz5yRr30c9UdgPyjyOen6fk1HRcq4ooLg4SoWVxD9XxJRBzM9y?=
 =?us-ascii?Q?EhZer4F8BV6TqGe5xcA4MSDy5R3MeBKIRvwLFuK8wBRusavDWDdjVJKyM1dL?=
 =?us-ascii?Q?NFxlFas0viVS3eeuQqO73+pT3u1+JboaVDEl3tAHCbEMAtcZsm9JsAm+rvNY?=
 =?us-ascii?Q?8Z7fmZcM4quze2ILZnCuwudR+Y1cDo+p6+b70Gxo3K48tBTxCIbmkDYpV960?=
 =?us-ascii?Q?bmWdBmW0PVFsOeC/6/328qsL+QRBC/gMseE0nak4Qawo6ehtzwKQUf9dc9kV?=
 =?us-ascii?Q?zOKJHRb1RHS92DPiebz5M7uv8uzoDh6hWJiaMu7dPEfTi5YxUTQiL7xQN9G9?=
 =?us-ascii?Q?m4o6yDs81V/nSaf/7bitCIzG7kZf/DhZ0WoIhjpb9rB43ieF9/+Q2vIqdRGl?=
 =?us-ascii?Q?2YXhj8J1cSGeEvyUbwpBORI5flRAYND6pgOhX0XW2XzVuKQt6AS4nVpqTFKG?=
 =?us-ascii?Q?E/v38fnw2LOIiNjs5LHy8DJF7TT3FQb5esrDwbWyQm+GS/l+zYXrmWAaLHN3?=
 =?us-ascii?Q?0IxiYpqbAib8B/jvN9gyoWqSXZw/HzoZCZ9UjzT1NsCH2/SLQaoLKCpwXm3I?=
 =?us-ascii?Q?0OHBghGIb+sfplqzncuKXz+cNA95j19cdOVgu6A088S9AoGI0WUICxiqh6ON?=
 =?us-ascii?Q?e41bFKjLBdvoBxL94IMzBagkXY2ZkKCbJsjY7dx2Tc1U4mrqC3Zfo+fxEetE?=
 =?us-ascii?Q?205oLykB/m4SLV8XEp7ZGH2/+q1ZD75tsA2T/Op7olPlOooVCRP5XgDOyHBM?=
 =?us-ascii?Q?JNEA?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f17b8c57-b60e-4949-2c9d-08d8bd498a23
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4597.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2021 13:44:42.4246 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IJkRcic6SxwHddz6h2TIKEP+9sOTzvr38sHHZRc1hb3r2rtm919i9f1epC+gZ7ElEf6ndHcccAWDVRDkiabryA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3128
Cc: brijesh.singh@amd.com, rrichter@amd.com, Jon.Grimm@amd.com,
 will.deacon@arm.com
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

IOMMU Extended Feature Register (EFR) is used to communicate
the supported features for each IOMMU to the IOMMU driver.
This is normally read from the PCI MMIO register offset 0x30,
and used by the iommu_feature() helper function.

However, there are certain scenarios where the information is needed
prior to PCI initialization, and the iommu_feature() function is used
prematurely w/o warning. This has caused incorrect initialization of IOMMU.
This is the case for the commit 6d39bdee238f ("iommu/amd: Enforce 4k
mapping for certain IOMMU data structures")

Since, the EFR is also available in the IVHD header, and is available to
the driver prior to PCI initialization. Therefore, default to using
the IVHD EFR instead.

Fixes: 6d39bdee238f ("iommu/amd: Enforce 4k mapping for certain IOMMU data structures")
Reviewed-by: Robert Richter <rrichter@amd.com>
Tested-by: Brijesh Singh <brijesh.singh@amd.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/amd_iommu.h       |  7 ++--
 drivers/iommu/amd/amd_iommu_types.h |  4 +++
 drivers/iommu/amd/init.c            | 56 +++++++++++++++++++++++++++--
 3 files changed, 60 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index 6b8cbdf71714..b4adab698563 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -84,12 +84,9 @@ static inline bool is_rd890_iommu(struct pci_dev *pdev)
 	       (pdev->device == PCI_DEVICE_ID_RD890_IOMMU);
 }
 
-static inline bool iommu_feature(struct amd_iommu *iommu, u64 f)
+static inline bool iommu_feature(struct amd_iommu *iommu, u64 mask)
 {
-	if (!(iommu->cap & (1 << IOMMU_CAP_EFR)))
-		return false;
-
-	return !!(iommu->features & f);
+	return !!(iommu->features & mask);
 }
 
 static inline u64 iommu_virt_to_phys(void *vaddr)
diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 553587827771..1a0495dd5fcb 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -387,6 +387,10 @@
 #define IOMMU_CAP_NPCACHE 26
 #define IOMMU_CAP_EFR     27
 
+/* IOMMU IVINFO */
+#define IOMMU_IVINFO_OFFSET     36
+#define IOMMU_IVINFO_EFRSUP     BIT(0)
+
 /* IOMMU Feature Reporting Field (for IVHD type 10h */
 #define IOMMU_FEAT_GASUP_SHIFT	6
 
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 6a1f7048dacc..83d8ab2aed9f 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -257,6 +257,8 @@ static void init_device_table_dma(void);
 
 static bool amd_iommu_pre_enabled = true;
 
+static u32 amd_iommu_ivinfo __initdata;
+
 bool translation_pre_enabled(struct amd_iommu *iommu)
 {
 	return (iommu->flags & AMD_IOMMU_FLAG_TRANS_PRE_ENABLED);
@@ -296,6 +298,18 @@ int amd_iommu_get_num_iommus(void)
 	return amd_iommus_present;
 }
 
+/*
+ * For IVHD type 0x11/0x40, EFR is also available via IVHD.
+ * Default to IVHD EFR since it is available sooner
+ * (i.e. before PCI init).
+ */
+static void __init early_iommu_features_init(struct amd_iommu *iommu,
+					     struct ivhd_header *h)
+{
+	if (amd_iommu_ivinfo & IOMMU_IVINFO_EFRSUP)
+		iommu->features = h->efr_reg;
+}
+
 /* Access to l1 and l2 indexed register spaces */
 
 static u32 iommu_read_l1(struct amd_iommu *iommu, u16 l1, u8 address)
@@ -1577,6 +1591,9 @@ static int __init init_iommu_one(struct amd_iommu *iommu, struct ivhd_header *h)
 
 		if (h->efr_reg & BIT(IOMMU_EFR_XTSUP_SHIFT))
 			amd_iommu_xt_mode = IRQ_REMAP_X2APIC_MODE;
+
+		early_iommu_features_init(iommu, h);
+
 		break;
 	default:
 		return -EINVAL;
@@ -1770,6 +1787,35 @@ static const struct attribute_group *amd_iommu_groups[] = {
 	NULL,
 };
 
+/*
+ * Note: IVHD 0x11 and 0x40 also contains exact copy
+ * of the IOMMU Extended Feature Register [MMIO Offset 0030h].
+ * Default to EFR in IVHD since it is available sooner (i.e. before PCI init).
+ */
+static void __init late_iommu_features_init(struct amd_iommu *iommu)
+{
+	u64 features;
+
+	if (!(iommu->cap & (1 << IOMMU_CAP_EFR)))
+		return;
+
+	/* read extended feature bits */
+	features = readq(iommu->mmio_base + MMIO_EXT_FEATURES);
+
+	if (!iommu->features) {
+		iommu->features = features;
+		return;
+	}
+
+	/*
+	 * Sanity check and warn if EFR values from
+	 * IVHD and MMIO conflict.
+	 */
+	if (features != iommu->features)
+		pr_warn(FW_WARN "EFR mismatch. Use IVHD EFR (%#llx : %#llx\n).",
+			features, iommu->features);
+}
+
 static int __init iommu_init_pci(struct amd_iommu *iommu)
 {
 	int cap_ptr = iommu->cap_ptr;
@@ -1789,8 +1835,7 @@ static int __init iommu_init_pci(struct amd_iommu *iommu)
 	if (!(iommu->cap & (1 << IOMMU_CAP_IOTLB)))
 		amd_iommu_iotlb_sup = false;
 
-	/* read extended feature bits */
-	iommu->features = readq(iommu->mmio_base + MMIO_EXT_FEATURES);
+	late_iommu_features_init(iommu);
 
 	if (iommu_feature(iommu, FEATURE_GT)) {
 		int glxval;
@@ -2607,6 +2652,11 @@ static void __init free_dma_resources(void)
 	free_unity_maps();
 }
 
+static void __init ivinfo_init(void *ivrs)
+{
+	amd_iommu_ivinfo = *((u32 *)(ivrs + IOMMU_IVINFO_OFFSET));
+}
+
 /*
  * This is the hardware init function for AMD IOMMU in the system.
  * This function is called either from amd_iommu_init or from the interrupt
@@ -2661,6 +2711,8 @@ static int __init early_amd_iommu_init(void)
 	if (ret)
 		goto out;
 
+	ivinfo_init(ivrs_base);
+
 	amd_iommu_target_ivhd_type = get_highest_supported_ivhd_type(ivrs_base);
 	DUMP_printk("Using IVHD type %#x\n", amd_iommu_target_ivhd_type);
 
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
