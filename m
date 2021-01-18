Return-Path: <SRS0=rNTl=GV=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE25AC433DB
	for <iommu@archiver.kernel.org>; Mon, 18 Jan 2021 05:14:24 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7EE18224B0
	for <iommu@archiver.kernel.org>; Mon, 18 Jan 2021 05:14:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EE18224B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 160B78702D;
	Mon, 18 Jan 2021 05:14:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id F0T2o0XrIPih; Mon, 18 Jan 2021 05:14:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 0A7D786C82;
	Mon, 18 Jan 2021 05:14:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EDB4AC088B;
	Mon, 18 Jan 2021 05:14:22 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D745EC013A
 for <iommu@lists.linux-foundation.org>; Mon, 18 Jan 2021 05:14:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id A130620112
 for <iommu@lists.linux-foundation.org>; Mon, 18 Jan 2021 05:14:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gYoBhsg9CusL for <iommu@lists.linux-foundation.org>;
 Mon, 18 Jan 2021 05:14:20 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2058.outbound.protection.outlook.com [40.107.94.58])
 by silver.osuosl.org (Postfix) with ESMTPS id A04DE2010F
 for <iommu@lists.linux-foundation.org>; Mon, 18 Jan 2021 05:14:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iis3FhSy1rzmqM/gc3RzAvJ9gmF7I0vb84TyJbMvS9eWi/V2EIUdW98LmuGrOMDSR3ZwvnZDwnaqJe40fUFpf1rfpSlyjbNCF4MV8vcle1K8UN1fevltHLmB9MaAAiq6JrVVF18XqDLGVZuzE7iPfCq0RuliWOInwcU9yODLrRqM+kxiJWuRTJs8Dg2yb1YDJNkr8zB8mXX06bkaGcSo9JTRIc9LEBW1ofeHCWGRq1Vi2yIPpZD00sJN1wLlRgbhTG0/QVhlaGGDV4gtQshmQJao45NrtgpJlGjSN/4xO8v01qZSNpoXYjipuCOfd8TBd+5irO+dKKWd2FDQMCBRVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rly7klrcU1o9VHLBUX0Ix5QF1jc+j78JPk9QdLwFkvo=;
 b=ctlO0LYUR6lihLAcLKUKhH70oMDBc6g4y60EccS45p1j/ytZgUQyOc1qCBfpYkGWzZIKdjH7aU9YrSR2GaCDNVQVNSHqDjAJn0v67D+Iq/en9nRYT3hjyYs5Wqw8fVVBmlb2/d3i/JFTO8ae1wmmCfl1Wo8/d15DxbsX1eZzessanQY/ZnTR4P0j/+A40imdMG7Bp58u0zIfj9WRhGOBF8DY5o23CeG4Pm32olFnYbpS1dbwzFy8JzW9ExGJ4SjqR91XZCKw98OsS9B9LOBng78Fp7R+T2FlvF6lRNj7D4T4n1lJBg6f2db8nqQTPSO0wvGFLvuHu4n1rayNXLhnGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rly7klrcU1o9VHLBUX0Ix5QF1jc+j78JPk9QdLwFkvo=;
 b=Ce7XjLrMiHxxAYDReeNt0EBwpwxPToDA4PoIUolH0xj/v0ySgK+fdjTUIZ4O3IN24CrZINbQ+b/34SLceJUp28jD9Ci1deMXb41mT11Y65bP0lPkDSoCG/pjnH/qx4ClG2g6tIw8leFkx5iunPhWxTcS8ldaiTmEiwjJP9UrytI=
Authentication-Results: lists.linux-foundation.org; dkim=none (message not
 signed) header.d=none;lists.linux-foundation.org; dmarc=none action=none
 header.from=amd.com;
Received: from BYAPR12MB4597.namprd12.prod.outlook.com (2603:10b6:a03:10b::14)
 by BY5PR12MB4306.namprd12.prod.outlook.com (2603:10b6:a03:206::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.10; Mon, 18 Jan
 2021 05:14:15 +0000
Received: from BYAPR12MB4597.namprd12.prod.outlook.com
 ([fe80::a95a:7202:81db:1972]) by BYAPR12MB4597.namprd12.prod.outlook.com
 ([fe80::a95a:7202:81db:1972%7]) with mapi id 15.20.3763.014; Mon, 18 Jan 2021
 05:14:15 +0000
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: iommu@lists.linux-foundation.org
Subject: [PATCH] iommu/amd: Make use of EFR from IVHD when available
Date: Sun, 17 Jan 2021 23:19:27 -0600
Message-Id: <20210118051927.2905-1-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.78.2]
X-ClientProxiedBy: SA0PR13CA0027.namprd13.prod.outlook.com
 (2603:10b6:806:130::32) To BYAPR12MB4597.namprd12.prod.outlook.com
 (2603:10b6:a03:10b::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ethanolx5673host.amd.com (165.204.78.2) by
 SA0PR13CA0027.namprd13.prod.outlook.com (2603:10b6:806:130::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.5 via Frontend
 Transport; Mon, 18 Jan 2021 05:14:15 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 84bd9618-8d27-4786-4113-08d8bb6fe682
X-MS-TrafficTypeDiagnostic: BY5PR12MB4306:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR12MB4306B8182D8C8EC00DA5BCC9F3A40@BY5PR12MB4306.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dgyso6S6HNmWBq0CdvzBGW8DtobSsc9EA3QLnIentaKXbXXExlUxgr5HzEneG5pbqGLkOiuFl4macIvsKOp7FyrNHd/RqX6Zhd+YPsYzODiohWlnDLc/sJte0mQlYasuYeeHFDB+GpPsmfheUVbQNs6BPglymxDUQxB6Jm2zzUF31C4Ynn4j/c8RAPESp3ujpoFtKhLpunY/5tiPojm/o9rBxTYRVpsayVLJIE4o+5pla7/M8NGv6YwL+C1+d3ttDVVPrI2dQ/4PvMw4cNxcS5oOB1Lat5r4+U/7yXWRUCcqwgignotWvYkZv/oCwXVt2GSUW2gDVs2F81H6c1yJ06Mh3EBYWackkaaz8LDT4J7Wt4NKQS7QAlN+4HbuFcbBBhTc9B5DU0foyQ+Irc46JA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4597.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(39860400002)(366004)(396003)(376002)(136003)(6666004)(5660300002)(6916009)(478600001)(8676002)(66556008)(83380400001)(36756003)(26005)(186003)(52116002)(16526019)(66946007)(86362001)(7696005)(2906002)(6486002)(956004)(66476007)(8936002)(1076003)(316002)(2616005)(4326008)(44832011);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?NgSspyn7NdXkrrdzgRm40rB9xQVjsGaAwkaDJ2rHBysLPwdeKENb6dCDs3G3?=
 =?us-ascii?Q?dnjRZL5FgjDhg4txOzyZQ347D4J/BVBNDaNDQKlKW+aLXtx2xh0om55qrPWL?=
 =?us-ascii?Q?D9qQ0CvH9+xT7bku+kM568ZkPPGV5Na160o6ODnOhvhWZBeKcrlKrwOIbAfC?=
 =?us-ascii?Q?mlUdXO9F5b+ODT2Tu3RJ1sOaHzXVRwgqdeLKmRlGCpD7ydA4D/cHP3qwsWYY?=
 =?us-ascii?Q?Sf3z4ngNI/Y2efvYFlcwa0TQ6gT12TH9gT9499zy/1lcaBsJyrNg4Cwxzg10?=
 =?us-ascii?Q?+5dgHkHGyEArGzyvvnqctrlv/SZP3F/GDmlAKbGL020hFVIw7bDsFIlbwcLT?=
 =?us-ascii?Q?nzFCNSB7+W+2iYyTZF4pF+Y7L8xxvFEG5p9WuwB/8LgfnTRRY3sPhtlJ8xla?=
 =?us-ascii?Q?hjyLoDWQ3ubfbop+mf9yE6g+OGc0TUyfaYh2EmWvkOL1rPkr2OnbrchpaZYV?=
 =?us-ascii?Q?KEnYfkRQ0erC+cBvfC0l56fzjL32mRv4q9kvhkfjUVFLC2Pa2OTHKfgImoLh?=
 =?us-ascii?Q?usQSUJFzipsPVaGTu20et3EP3LQkwTL9wUOjdUIYHy3GbUHtdzsi+6weoFGl?=
 =?us-ascii?Q?e32q3mBouLsCRVfz4HZsjNsa5Iat//EV+9uSv78QwxjYh61JUVdUMqgY/819?=
 =?us-ascii?Q?RqSXivXLk+31TadHhVdtQLK/WdTribMWtAZe+0aDAIru/beFGcidIZnEdDM/?=
 =?us-ascii?Q?467edmCNikfxwdH+QekObFDU0MjcNO+HMbMUhQSORyOMzGtpWHy3cuEsmSmg?=
 =?us-ascii?Q?r7xz2z/VA9MZVefOgCJ+7hlgTlpaGpkpXsWLoblDTs1i5O3MioQRXrpfOly7?=
 =?us-ascii?Q?Jy3ZW8xghT7h+4jsqlq1fJYbjRwgoHulXoN/TIEX4/yF1zWSbee7UGqQTjtD?=
 =?us-ascii?Q?dm8TFZds/SsQ/ZVOxmBMYm18YWEl8y03HO8a/05xl+pbvhZJJ2ed7naW4Ti6?=
 =?us-ascii?Q?fNqoP0JAOSbmdA9Rr0Lgf2YZgkW5+pIfyT9XQR6otv0Q/ZDwikdpTWeKS7Bl?=
 =?us-ascii?Q?lYQX?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84bd9618-8d27-4786-4113-08d8bb6fe682
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4597.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2021 05:14:15.7434 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8918RSIRDMZP/kkt1qZ9cnc3J3YEChUo5rp1nx1qUEGSQmdj1/WzI8JLrnBMvcv6GWr0bICW4FJNqARjIyt1+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4306
Cc: brijesh.singh@amd.com, Jon.Grimm@amd.com, will.deacon@arm.com
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

The EFR is also available in the IVHD header, and is available to
the driver prior to PCI initialization. Therefore, default to using
the IVHD EFR instead.

Fixes: 6d39bdee238f ("iommu/amd: Enforce 4k mapping for certain IOMMU data structures")
Tested-by: Brijesh Singh <brijesh.singh@amd.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/amd_iommu.h       |  3 ++-
 drivers/iommu/amd/amd_iommu_types.h |  4 +++
 drivers/iommu/amd/init.c            | 39 +++++++++++++++++++++++++++--
 3 files changed, 43 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index 6b8cbdf71714..0a89e9c4f7b3 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -86,7 +86,8 @@ static inline bool is_rd890_iommu(struct pci_dev *pdev)
 
 static inline bool iommu_feature(struct amd_iommu *iommu, u64 f)
 {
-	if (!(iommu->cap & (1 << IOMMU_CAP_EFR)))
+	/* features == 0 means EFR is not supported */
+	if (!iommu->features)
 		return false;
 
 	return !!(iommu->features & f);
diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 553587827771..35331e458dd1 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -387,6 +387,10 @@
 #define IOMMU_CAP_NPCACHE 26
 #define IOMMU_CAP_EFR     27
 
+/* IOMMU IVINFO */
+#define IOMMU_IVINFO_OFFSET          36
+#define IOMMU_IVINFO_EFRSUP_SHIFT    0
+
 /* IOMMU Feature Reporting Field (for IVHD type 10h */
 #define IOMMU_FEAT_GASUP_SHIFT	6
 
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 6a1f7048dacc..28b1d2feec96 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -257,6 +257,8 @@ static void init_device_table_dma(void);
 
 static bool amd_iommu_pre_enabled = true;
 
+static u32 amd_iommu_ivinfo;
+
 bool translation_pre_enabled(struct amd_iommu *iommu)
 {
 	return (iommu->flags & AMD_IOMMU_FLAG_TRANS_PRE_ENABLED);
@@ -1577,6 +1579,14 @@ static int __init init_iommu_one(struct amd_iommu *iommu, struct ivhd_header *h)
 
 		if (h->efr_reg & BIT(IOMMU_EFR_XTSUP_SHIFT))
 			amd_iommu_xt_mode = IRQ_REMAP_X2APIC_MODE;
+
+		/*
+		 * For IVHD type 0x11/0x40, EFR is also available via IVHD.
+		 * Default to IVHD EFR since it is available sooner
+		 * (i.e. before PCI init).
+		 */
+		if (amd_iommu_ivinfo & (1 << IOMMU_IVINFO_EFRSUP_SHIFT))
+			iommu->features = h->efr_reg;
 		break;
 	default:
 		return -EINVAL;
@@ -1770,6 +1780,29 @@ static const struct attribute_group *amd_iommu_groups[] = {
 	NULL,
 };
 
+/*
+ * Note: IVHD 0x11 and 0x40 also contains exact copy
+ * of the IOMMU Extended Feature Register [MMIO Offset 0030h].
+ * Default to EFR in IVHD since it is available sooner (i.e. before PCI init).
+ * However, sanity check and warn if they conflict.
+ */
+static void __init iommu_init_features(struct amd_iommu *iommu)
+{
+	u64 features;
+
+	if (!(iommu->cap & (1 << IOMMU_CAP_EFR)))
+		return;
+
+	/* read extended feature bits */
+	features = readq(iommu->mmio_base + MMIO_EXT_FEATURES);
+
+	if (iommu->features && (features != iommu->features))
+		pr_err(FW_BUG "EFR mismatch. Use IVHD EFR (%#llx : %#llx\n).",
+		       features, iommu->features);
+	else
+		iommu->features = features;
+}
+
 static int __init iommu_init_pci(struct amd_iommu *iommu)
 {
 	int cap_ptr = iommu->cap_ptr;
@@ -1789,8 +1822,7 @@ static int __init iommu_init_pci(struct amd_iommu *iommu)
 	if (!(iommu->cap & (1 << IOMMU_CAP_IOTLB)))
 		amd_iommu_iotlb_sup = false;
 
-	/* read extended feature bits */
-	iommu->features = readq(iommu->mmio_base + MMIO_EXT_FEATURES);
+	iommu_init_features(iommu);
 
 	if (iommu_feature(iommu, FEATURE_GT)) {
 		int glxval;
@@ -2661,6 +2693,9 @@ static int __init early_amd_iommu_init(void)
 	if (ret)
 		goto out;
 
+	/* Store IVRS IVinfo field. */
+	amd_iommu_ivinfo = *((u32 *)((u8 *)ivrs_base + IOMMU_IVINFO_OFFSET));
+
 	amd_iommu_target_ivhd_type = get_highest_supported_ivhd_type(ivrs_base);
 	DUMP_printk("Using IVHD type %#x\n", amd_iommu_target_ivhd_type);
 
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
