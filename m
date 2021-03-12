Return-Path: <SRS0=dgoC=IK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5F08C43381
	for <iommu@archiver.kernel.org>; Fri, 12 Mar 2021 08:55:28 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8519564FE0
	for <iommu@archiver.kernel.org>; Fri, 12 Mar 2021 08:55:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8519564FE0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 60CDF6F9BC;
	Fri, 12 Mar 2021 08:55:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WdZI2VI_BHfU; Fri, 12 Mar 2021 08:55:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTP id 333856F93D;
	Fri, 12 Mar 2021 08:55:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1D612C000B;
	Fri, 12 Mar 2021 08:55:25 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 577FFC0001
 for <iommu@lists.linux-foundation.org>; Fri, 12 Mar 2021 08:55:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 36E298453F
 for <iommu@lists.linux-foundation.org>; Fri, 12 Mar 2021 08:55:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=amd.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KBpew4v05Uc2 for <iommu@lists.linux-foundation.org>;
 Fri, 12 Mar 2021 08:55:23 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2080.outbound.protection.outlook.com [40.107.244.80])
 by smtp1.osuosl.org (Postfix) with ESMTPS id EC40C84522
 for <iommu@lists.linux-foundation.org>; Fri, 12 Mar 2021 08:55:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TNsx7Lu0Rac8AXDUx2mi51Wsgmp/xJSsJ7elDMtomG1inVnRT+oAVZ6vJK9luQgKKnrU3LiXjgvUNyo0vD9d5U8PmZaPmKTnkkjrRkXRRNImOHsdAJgIENDCUDfr7VW09mmVxufkxjUY0Z4bDzc1xbnli1Ks2kXetEOsTTVxsm4QY113GMj+QRGvsiDOQMB4tC4YrWkQekKQVHqiyM+KFpYPLJry5h+Kc9feq6ICML5YzDcVKmukGWp+bxGyc3mlo5s9Ffvkxldtn2UwpT3T+bul51+gtM3MernhsuZo0ZcVzUtXMMUf9oK6D0CcFrTlaqUD8fRiwsOtHmigA8tiDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kp00RgzTlDfb/okqSIV6M3N9sErA+psNz0tvHQixVXk=;
 b=RbFMYQVw4JkumW9kmZfEU1ttZrOXWmUQE303Z/mz71YTfQwViVK3mRY+Yo41uOxDy+yu45J2QDCOsPka4TXkg7yZa6YBv8jLYQ8wKOxRZr+nD8PtsTgy0rf3Yo37Cy/4FV5UyTofx4D/ci0jgf0k76SMH9bCCeBSg11MvhnQzVutbYm1551eP7A56wbs5hoUSd+Vs8WPzU/mlUPteIowC8zv5hXTfszrSINHhU/9hJoa+e+w1U8Y8RnrLil81vNO7xAng0n5Sybf0L+B3HL9iuLrsMRMJKpU9CVdVIBMUAq99YZP4eeJlLPnek2iMpK2l+PjmFn4dpec9la+GWzdbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kp00RgzTlDfb/okqSIV6M3N9sErA+psNz0tvHQixVXk=;
 b=SAWovRuB9hPoQTW0QjiMny7m9O55HiJnpFyf5FzIQNGi4HsYWoCyjrGy9iRTp8wl9zoiApnqhaLrb7dWk741pTpUlal4oRg8dki2lQsV4w4WjUeYLtpx9/kB6DG8eCa433dGuuhrbUiqOkhR/+dFjhvXANg1zBTRUneCZX/l5jQ=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4597.namprd12.prod.outlook.com (2603:10b6:a03:10b::14)
 by BYAPR12MB2840.namprd12.prod.outlook.com (2603:10b6:a03:62::32)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.25; Fri, 12 Mar
 2021 08:55:19 +0000
Received: from BYAPR12MB4597.namprd12.prod.outlook.com
 ([fe80::a95a:7202:81db:1972]) by BYAPR12MB4597.namprd12.prod.outlook.com
 ([fe80::a95a:7202:81db:1972%7]) with mapi id 15.20.3912.031; Fri, 12 Mar 2021
 08:55:19 +0000
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: linux-kernel@vger.kernel.org,
	iommu@lists.linux-foundation.org
Subject: [RFC PATCH 5/7] iommu/amd: Add support for Guest IO protection
Date: Fri, 12 Mar 2021 03:04:09 -0600
Message-Id: <20210312090411.6030-6-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210312090411.6030-1-suravee.suthikulpanit@amd.com>
References: <20210312090411.6030-1-suravee.suthikulpanit@amd.com>
X-Originating-IP: [165.204.78.2]
X-ClientProxiedBy: SN7PR04CA0040.namprd04.prod.outlook.com
 (2603:10b6:806:120::15) To BYAPR12MB4597.namprd12.prod.outlook.com
 (2603:10b6:a03:10b::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ethanolx5673host.amd.com (165.204.78.2) by
 SN7PR04CA0040.namprd04.prod.outlook.com (2603:10b6:806:120::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.18 via Frontend
 Transport; Fri, 12 Mar 2021 08:55:18 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 32a1fc37-817b-485f-b026-08d8e534902f
X-MS-TrafficTypeDiagnostic: BYAPR12MB2840:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB28401270F35BCFDC36DF0F3BF36F9@BYAPR12MB2840.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1013;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KgJAfTlS8B9VsGt4gzGACYgZxo+9FV+0hEVjD1peBEZok+f167RnhHC39bSlHPR4a+y+w1R4B4uU7KWcIal21HxEG0CXLMWXvF0P9eazS05EUn9aqRWt0/UKe6s0OgH9ixn9Lqil5S5qxS3iSHUu0QB4HBK2U82PBQgkt5CtTL7YLroF0Ho1NYHJ670TQiuqlt2gFAdbcSwvGXWhTEk8vxGDqRyys5q4QRr07g8X2rpcLEJVwh1w06Xlt9GUdFSaKrlTi2xKjWgRMMh46HItbmaRuGL7JrHqYHH2XrUV9CSNFqBx8NBg27aiTHpPZQ7aymadd6ZysR0VyqUTRWWLnzBpde6/B/v8BDy3TW7sO6mYUA+ffgriMavfpQKWuMmZ56DhTqW4tYTA0jVoCRXVMMlnYMR71YiDx4Ozdl1oAbL6s0CFqnZO8i+oq/7D9K7OiKyAXKFA8dcL2VFUzwPIeSrEWGoK9324zdeTLZ+aHTo85Owhuj5pYDtRrnPejy4M//lbpAxz6oVjkEvYWwE3YA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4597.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(39860400002)(376002)(396003)(346002)(136003)(8936002)(36756003)(86362001)(2906002)(8676002)(316002)(1076003)(26005)(956004)(2616005)(66946007)(6666004)(186003)(6486002)(5660300002)(7696005)(16526019)(44832011)(66556008)(52116002)(4326008)(66476007)(478600001)(83380400001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?AQ5/htT73mV6wnhjxTg1a1QBbpeR6zgit27kn7ikwZhA/G/CUG+StsPGNX/z?=
 =?us-ascii?Q?5d24QTZTwqIq5PT9u3dTC/pCnbiwu+M57P26ishjh3t2CI7mjQzop5JCPXjl?=
 =?us-ascii?Q?PT95DFkiVjeKbEjq6kzecPuGV59pw4ly7EWAdZNW1Pe2zGU++wyf8d9Ok77S?=
 =?us-ascii?Q?AMlIfOgSelRsPYLylRKhAnv4j9Iv1FKiZvSqDGGPkoaBRijwOxL/1d1s9oBv?=
 =?us-ascii?Q?qPRJqzs1FjOu284v8H2a15mhvJq3/+UGSVKf66PbgtnSIlkn3ceGW71n7jYA?=
 =?us-ascii?Q?NRX0I+vp0uF7LgO+yz+XBYnHXjI5yyg3TlBnfDPQrsZOJUJG54XEh3fDoXMK?=
 =?us-ascii?Q?kcwu9UcYgYUQiSiwsEcuxjOKLJaZ8fUKr9pKzjub9iCYOtEdMTyW53iJxp7h?=
 =?us-ascii?Q?0aqxst9L3j7qAQUkQqFVYuIJfguxWuqWpPTZXdFwHKRmAU6j1VqP6s1+ukf0?=
 =?us-ascii?Q?eVEXKhuB5OXtoWLTD4eqPoR7IuJVm6xlh5h6exxc65ojykWg1mcQsE8Y5Hbi?=
 =?us-ascii?Q?/DxgKj5gaGL3P238LKyWORr3s09l2YbfBKh5cfbfkj9A93UsqjHHFoOPWzTF?=
 =?us-ascii?Q?S3bYdtYyNAjI3Fx56o+8Jdr3+hwBDIJb6qrEWtgQwoRmMI1+bpV9WYwPkJiw?=
 =?us-ascii?Q?32V7e0ZWDWkswG9ZPd969iZIKM4EzJB/70hu/h6sh9ZbG71SYhGBkAs//fu+?=
 =?us-ascii?Q?e7iFs0NYVfMvafpvW5dDSXeLpYhQ0O6eijn4EQaG2zshOwePn8EGs5aBK7lY?=
 =?us-ascii?Q?Jd/czVx7Q8zTqoQXX7dbxameEi/BqZrs3e/e+PBFcAwML5Eo6V9aLm9CMhOe?=
 =?us-ascii?Q?cr1ViPJE/MeyU8Qg1DW5oinNNjSEMYK+yjuAJdfCrYt2POgiq2TUi572P8pd?=
 =?us-ascii?Q?rVWXI9PkSNL8y0+gcyaLzpzeOSu1iUeRrD20PkolaQ7x1xWHbi8jfQNmlRh0?=
 =?us-ascii?Q?xeOu5S+SeWuZEXyVRFnNLxHW/KesPMTT8GeYRx5i4i30mI+aga8M47z88X6R?=
 =?us-ascii?Q?bXjWdPgnn+i5dy/+DNH2rVdqnv3iBY4Uiv1nuxsywpWtbDNh7+zvMiL53bXi?=
 =?us-ascii?Q?EsyxXWxGMT/JOz7O2sAtYANrwyEtxCdt1MCRZYtcmsbEdanFYo9ZwU2BUATm?=
 =?us-ascii?Q?/4MUt3yN+kekBKIZPb98Ypjy9cDJuT1gjc3re0YzVu/LvVhjSspT4KXNvtlH?=
 =?us-ascii?Q?CiYcKpHEiIf9idxtkJ8m+WZtVVBpMDZ/KOFQXEsc63x9Fjcu8/9S1Ro65I7W?=
 =?us-ascii?Q?JGRF2a+nmzIr8kSbLFyAL19h4kzb98o5v8nopPusQMJ2sOHFpTsjChwTlGMk?=
 =?us-ascii?Q?a53srCdsuB0645plmZzr5u9b?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32a1fc37-817b-485f-b026-08d8e534902f
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4597.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2021 08:55:19.5888 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +dZXhXTrHPSLr0YJuK/i49v5WQ0zNYIjcvJ1kWMPQ9wlZdniTN1k0NaBqNT3hH3Kvulmf0pOeb4FYMClthGK3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2840
Cc: Jon.Grimm@amd.com, Wei.Huang2@amd.com
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

AMD IOMMU introduces support for Guest I/O protection where the request
from the I/O device without a PASID are treated as if they have PASID 0.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/amd_iommu_types.h | 3 +++
 drivers/iommu/amd/init.c            | 8 ++++++++
 drivers/iommu/amd/iommu.c           | 4 ++++
 3 files changed, 15 insertions(+)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 25062eb86c8b..876ba1adf73e 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -93,6 +93,7 @@
 #define FEATURE_HE		(1ULL<<8)
 #define FEATURE_PC		(1ULL<<9)
 #define FEATURE_GAM_VAPIC	(1ULL<<21)
+#define FEATURE_GIOSUP		(1ULL<<48)
 #define FEATURE_EPHSUP		(1ULL<<50)
 #define FEATURE_SNP		(1ULL<<63)
 
@@ -366,6 +367,7 @@
 #define DTE_FLAG_IW (1ULL << 62)
 
 #define DTE_FLAG_IOTLB	(1ULL << 32)
+#define DTE_FLAG_GIOV	(1ULL << 54)
 #define DTE_FLAG_GV	(1ULL << 55)
 #define DTE_FLAG_MASK	(0x3ffULL << 32)
 #define DTE_GLX_SHIFT	(56)
@@ -519,6 +521,7 @@ struct protection_domain {
 	spinlock_t lock;	/* mostly used to lock the page table*/
 	u16 id;			/* the domain id written to the device table */
 	int glx;		/* Number of levels for GCR3 table */
+	bool giov;		/* guest IO protection domain */
 	u64 *gcr3_tbl;		/* Guest CR3 table */
 	unsigned long flags;	/* flags to find out type of domain */
 	unsigned dev_cnt;	/* devices assigned to this domain */
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 5def566de6f6..9265c1bf1d84 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -1895,6 +1895,12 @@ static int __init iommu_init_pci(struct amd_iommu *iommu)
 
 	init_iommu_perf_ctr(iommu);
 
+	if (amd_iommu_pgtable == AMD_IOMMU_V2 &&
+	    !iommu_feature(iommu, FEATURE_GIOSUP)) {
+		pr_warn("Cannot enable v2 page table for DMA-API. Fallback to v1.\n");
+		amd_iommu_pgtable = AMD_IOMMU_V1;
+	}
+
 	if (is_rd890_iommu(iommu->dev)) {
 		int i, j;
 
@@ -1969,6 +1975,8 @@ static void print_iommu_info(void)
 		if (amd_iommu_xt_mode == IRQ_REMAP_X2APIC_MODE)
 			pr_info("X2APIC enabled\n");
 	}
+	if (amd_iommu_pgtable == AMD_IOMMU_V2)
+		pr_info("GIOV enabled\n");
 }
 
 static int __init amd_iommu_init_pci(void)
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index f3800efdbb29..e29ece6e1e68 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -1405,6 +1405,10 @@ static void set_dte_entry(u16 devid, struct protection_domain *domain,
 
 	pte_root |= (domain->iop.mode & DEV_ENTRY_MODE_MASK)
 		    << DEV_ENTRY_MODE_SHIFT;
+
+	if (domain->giov && (domain->flags & PD_IOMMUV2_MASK))
+		pte_root |= DTE_FLAG_GIOV;
+
 	pte_root |= DTE_FLAG_IR | DTE_FLAG_IW | DTE_FLAG_V | DTE_FLAG_TV;
 
 	flags = amd_iommu_dev_table[devid].data[1];
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
