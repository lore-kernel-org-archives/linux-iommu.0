Return-Path: <SRS0=aVDl=HK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	URIBL_RED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FE02C433E0
	for <iommu@archiver.kernel.org>; Mon,  8 Feb 2021 12:20:54 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE36664E27
	for <iommu@archiver.kernel.org>; Mon,  8 Feb 2021 12:20:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE36664E27
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 56F148691B;
	Mon,  8 Feb 2021 12:20:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3ZLtf52wb89i; Mon,  8 Feb 2021 12:20:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id A82D886916;
	Mon,  8 Feb 2021 12:20:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7E0C8C0891;
	Mon,  8 Feb 2021 12:20:51 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 37DDBC013A
 for <iommu@lists.linux-foundation.org>; Mon,  8 Feb 2021 12:20:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 25F788704D
 for <iommu@lists.linux-foundation.org>; Mon,  8 Feb 2021 12:20:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tf35or9dUc5w for <iommu@lists.linux-foundation.org>;
 Mon,  8 Feb 2021 12:20:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2044.outbound.protection.outlook.com [40.107.243.44])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 4658286FE8
 for <iommu@lists.linux-foundation.org>; Mon,  8 Feb 2021 12:20:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hIHfFTNowJIjoNkesF1agL5IOg6g3ra0fB7HYLYUMV2GMx2zGzRFf8htDnP2eZTeCzbiPaxioeJgsmfV1kQR6bqsAy9lX+nInlgGHT68eSLl8FmpGnSVjcBuC1OcYbKeAbDv74Gpi++bNxG1j4mjEiOBRTD1aCNELKzmR0/61Fq0d9OSK/6YI84GlRzk7v7AxyBuQEGm/gQP+fhQXp1VK2LtXxdih+QmJFhwMSio9UmLcBq/b7c33xKpI+GkhC7G5H4w0nNv9LY2hy5zlBIOsYrXz4HH2yNg0KUuppJyxFIR8GqP+bcxlSXeCn9dJ7uGRoVfZrxT3rG8Y3XXaVB1Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vT+EueukOylDdBEVUO390+exXUCzT3sjm67EIvFUPT0=;
 b=S2aOAporjhEpmrJ6PghbycgzfBFKpwUeAGAyYsaqVFUw/iEO7p8wj7rhE49bc7IaxGblXVkqX5sm7uJ0G4IkA9/JLFwyAePSdAsbsnuLaBWYrSeWH/yxSw/0i1IbSfDjZUl4eJx4pJygZZOvqhi8DoeyAn1tDNiD3xM7b1SXmmkN9nt7UXZ+85vdKmfzdpQeYgKjyxjf9pvyftCI3gg32/rXnHMSGMiTgLL9G8WLaPR1gODoGpKexDPAhbxK4JTJu6SB8z9BNYLR/srahhmlZtn6klSYwQ9IIo2jlJmwRIJEPvyjARlaNbjTp+N5carjk23osKuMViQ7+0v767ilDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vT+EueukOylDdBEVUO390+exXUCzT3sjm67EIvFUPT0=;
 b=cRIgQN4Vhvduud0NLgu4uUGYmHp1bwyQtPVxufii33iqVMJ353uayhL8WTEeB0LeEjdi/qp7ZvsIatkehQhlteKxaagSEflTiO4+qfQJUds0fAQJLQfsARBe03xwJFUHC0qgMgVl8A4ckid6laGd3Qx3EY8sJOGssrJuyKEbsG8=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4597.namprd12.prod.outlook.com (2603:10b6:a03:10b::14)
 by BYAPR12MB2789.namprd12.prod.outlook.com (2603:10b6:a03:72::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.17; Mon, 8 Feb
 2021 12:20:43 +0000
Received: from BYAPR12MB4597.namprd12.prod.outlook.com
 ([fe80::a95a:7202:81db:1972]) by BYAPR12MB4597.namprd12.prod.outlook.com
 ([fe80::a95a:7202:81db:1972%7]) with mapi id 15.20.3825.030; Mon, 8 Feb 2021
 12:20:43 +0000
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: linux-kernel@vger.kernel.org,
	iommu@lists.linux-foundation.org
Subject: [PATCH] iommu/amd: Fix performance counter initialization
Date: Mon,  8 Feb 2021 06:27:12 -0600
Message-Id: <20210208122712.5048-1-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.78.2]
X-ClientProxiedBy: SN4PR0501CA0134.namprd05.prod.outlook.com
 (2603:10b6:803:2c::12) To BYAPR12MB4597.namprd12.prod.outlook.com
 (2603:10b6:a03:10b::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ethanolx5673host.amd.com (165.204.78.2) by
 SN4PR0501CA0134.namprd05.prod.outlook.com (2603:10b6:803:2c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.11 via Frontend
 Transport; Mon, 8 Feb 2021 12:20:42 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: add04125-9116-405f-f2f0-08d8cc2bf495
X-MS-TrafficTypeDiagnostic: BYAPR12MB2789:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB278915558AB11D2B2762F2F9F38F9@BYAPR12MB2789.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zvuERM6cjiZN6oJOGuzbKkBfe4WaMdBDNZMaRDv/XJyz7+Gw1Nj5M3eWoPentCYnpOpOWd2DkaKars/ykhhk9jA5dXqt1V1TweBIOEWzp28OHl74n3+MPHWx9zlFT6D6lMOfiqgKO6XL5A7PZsSVmOONHa25QROHOdZlnyBw0E6UlOrQhPuzvp49PGpijQ2LlDCVJiii2j4hOPgEI8uDuG1SPx+C1XcM+kizusB+k92tSDq2A53n3oCtBC4JHonlOJwBQPpmBSMpRAnDVQLDQM/46zCyVoP4iRPeDTwFzTpRGY0MTpNbDNbvD3w+25cqs6jdlHZJb8lueR17XlyNtE9TCtsehfT5r345CPRCDu+9Im2pz9AgOT7gLNWzlC72dJqatViiyXN+8rXTD+CNUT23fA+4g06m2r260GAmy/W0iXCNRBCv8d0xjGhWlcGVxua8uHrjaFSBzmTyjpKMSVqB8Ujfu74tmgZb+s2M7hzMkWOA53gyly5EU+bWpqjiKmDq4w+PqXoyG3P1w2BWInu6r6ReNSkUQ27ux9tzMtpIWroIZkv+VAKZEqqDiCpcb9/b+ZEkLIIIvPWPBZ6dt5dckyxKEr5ltpbPm9pySiA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4597.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(136003)(346002)(366004)(376002)(956004)(478600001)(86362001)(5660300002)(36756003)(8936002)(8676002)(2906002)(1076003)(6666004)(66476007)(316002)(83380400001)(186003)(6486002)(966005)(16526019)(26005)(66556008)(52116002)(4326008)(44832011)(2616005)(66946007)(7696005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?vsRxLPTyQJjuSDumVVMXq/kdAfjvb1r5nmhxLjX3CKP0L6QlkKuZWDl/DC6U?=
 =?us-ascii?Q?9+FNl3TukIO8VD9f+nU1c5IYV/d/FSIgmPH+HNxSA93kb/6y+KWh4ht/8cha?=
 =?us-ascii?Q?tepvcKBuEFBNWqkh1xlaxO0aFq41mbUHPtI5W1OOKjWnKbpNmzqjSf/W9CaB?=
 =?us-ascii?Q?8Oi/khXgg34Ak5NzvBzwo5Uj0c9HKdwCVr1Fh2iCVWZudZkACvAuYp8fTFLy?=
 =?us-ascii?Q?eVO7yqpyBPZBlmaPjLkIj0YM20MwvFJa1oO0hYSZOxM0Hwa5hcdkV1t0ryop?=
 =?us-ascii?Q?KvYAAdqL5DKcElPCdhLYJR6wt/6qHVkTg/LJlcBXghNKjxKaqz8ZPDBLCXWx?=
 =?us-ascii?Q?b7Vpwb4hZ7Y2T/tHpSZjAQdrufsyswZQzY3lV9CufhjFpEdqSvRSdF/p+EZl?=
 =?us-ascii?Q?J6o6SnsYgY+P8ttfkaL5bCpkp/RUytumw3Ew2oXepLZBsv8Leg6TuOW/IJeQ?=
 =?us-ascii?Q?gNeqoHBPNJavAYYxyJ/g9DTgKc7YvXqXnW/rRUJqLpZILnuIlYf3ZgVCr/ok?=
 =?us-ascii?Q?vWJzt++L1BoBgUg1g8K00+XiGRxnqAH5Jh27zKl1WP0oDGTVzCe+6LbqCx58?=
 =?us-ascii?Q?PYWod0c+iud1HMkf/u4+iFi9/Pm/DS2eiXC1fHBuuyNQ2pi272iNyI+UcTjr?=
 =?us-ascii?Q?7RFZjxLjLmCsKhajNcNHE30Baf4aTRVTrXYxnd54vchmUbs8YdCswd3q5iuI?=
 =?us-ascii?Q?QshU6kmSu8KwqEVFRlF1EMEBYgZPthARYn8qZv6+EsZtvkCzppnA15+rQLu2?=
 =?us-ascii?Q?Aa3klH9bbT881pPEuyuk9xK5gRowFQaLk/+4c4rhHaX6/gHu2peGeY4fh/IV?=
 =?us-ascii?Q?9LGA2eKbsqoYm/Qh5ZGHWDwAa6eLkfK4seFLbPFcd89/5SuM2kiai1U1ntJr?=
 =?us-ascii?Q?ZpBMr4tQ7RqNkdZGeLkj7k1USpBlmyUI8dMcbkxlItuNhWeRIjax5NTAxqt7?=
 =?us-ascii?Q?CJFMiLGQHeqASUx+457lt1Kdc13ndOqS9fXg8VWsHScelvCswuIrTJyPAHIY?=
 =?us-ascii?Q?YBp/XSe7qS9es5jgRG/Uw1zo2hLX5LrdwyZPeBOc0kO2BvUkBEkP7IB+U9xq?=
 =?us-ascii?Q?p5RTGAvhQR9FKQiT9h2f6N2TRy6uAcBtcstBsphIVqk0I6HWdIVgCixWsWqK?=
 =?us-ascii?Q?MXsypy5OgVpG6FXnH2xs3jWjCuCh+2amB41qybRD3Qvdx797zT8JNFFpXT6w?=
 =?us-ascii?Q?Ri8ZhvVy6CNREsfwgD21DSS9hsL+hLS7hl246bKEbDYWKW4ziDsk6zchJ6sU?=
 =?us-ascii?Q?YN46z6ytWmbrHUr2DTzRc/XIQZSwCteNJq/rNmLZaq+gSqZRBdY0G/QwhBXO?=
 =?us-ascii?Q?woiJ0wnJnlnGN4SVeneYVxKQ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: add04125-9116-405f-f2f0-08d8cc2bf495
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4597.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2021 12:20:43.6240 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hGwWk0etmxleosEFIg573aIQpI9OANPCcIYjTTYThi46hnoNjr0oZdUIrmt2zH8AOZHElflzKRYfBW3WVN7Vxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2789
Cc: will@kernel.org
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

Certain AMD platforms enable power gating feature for IOMMU PMC,
which prevents the IOMMU driver from updating the counter while
trying to validate the PMC functionality in the init_iommu_perf_ctr().
This results in disabling PMC support and the following error message:

    "AMD-Vi: Unable to read/write to IOMMU perf counter"

To workaround this issue, disable power gating temporarily by programming
the counter source to non-zero value while validating the counter,
and restore the prior state afterward.

Tested-by: Tj (Elloe Linux) <ml.linux@elloe.vision>
Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=201753
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/init.c | 45 ++++++++++++++++++++++++++++++----------
 1 file changed, 34 insertions(+), 11 deletions(-)

diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 83d8ab2aed9f..01da76dc1caa 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -12,6 +12,7 @@
 #include <linux/acpi.h>
 #include <linux/list.h>
 #include <linux/bitmap.h>
+#include <linux/delay.h>
 #include <linux/slab.h>
 #include <linux/syscore_ops.h>
 #include <linux/interrupt.h>
@@ -254,6 +255,8 @@ static enum iommu_init_state init_state = IOMMU_START_STATE;
 static int amd_iommu_enable_interrupts(void);
 static int __init iommu_go_to_state(enum iommu_init_state state);
 static void init_device_table_dma(void);
+static int iommu_pc_get_set_reg(struct amd_iommu *iommu, u8 bank, u8 cntr,
+				u8 fxn, u64 *value, bool is_write);
 
 static bool amd_iommu_pre_enabled = true;
 
@@ -1712,13 +1715,11 @@ static int __init init_iommu_all(struct acpi_table_header *table)
 	return 0;
 }
 
-static int iommu_pc_get_set_reg(struct amd_iommu *iommu, u8 bank, u8 cntr,
-				u8 fxn, u64 *value, bool is_write);
-
-static void init_iommu_perf_ctr(struct amd_iommu *iommu)
+static void __init init_iommu_perf_ctr(struct amd_iommu *iommu)
 {
+	int retry;
 	struct pci_dev *pdev = iommu->dev;
-	u64 val = 0xabcd, val2 = 0, save_reg = 0;
+	u64 val = 0xabcd, val2 = 0, save_reg, save_src;
 
 	if (!iommu_feature(iommu, FEATURE_PC))
 		return;
@@ -1726,17 +1727,39 @@ static void init_iommu_perf_ctr(struct amd_iommu *iommu)
 	amd_iommu_pc_present = true;
 
 	/* save the value to restore, if writable */
-	if (iommu_pc_get_set_reg(iommu, 0, 0, 0, &save_reg, false))
+	if (iommu_pc_get_set_reg(iommu, 0, 0, 0, &save_reg, false) ||
+	    iommu_pc_get_set_reg(iommu, 0, 0, 8, &save_src, false))
 		goto pc_false;
 
-	/* Check if the performance counters can be written to */
-	if ((iommu_pc_get_set_reg(iommu, 0, 0, 0, &val, true)) ||
-	    (iommu_pc_get_set_reg(iommu, 0, 0, 0, &val2, false)) ||
-	    (val != val2))
+	/*
+	 * Disable power gating by programing the performance counter
+	 * source to 20 (i.e. counts the reads and writes from/to IOMMU
+	 * Reserved Register [MMIO Offset 1FF8h] that are ignored.),
+	 * which never get incremented during this init phase.
+	 * (Note: The event is also deprecated.)
+	 */
+	val = 20;
+	if (iommu_pc_get_set_reg(iommu, 0, 0, 8, &val, true))
 		goto pc_false;
 
+	/* Check if the performance counters can be written to */
+	val = 0xabcd;
+	for (retry = 5; retry; retry--) {
+		if (iommu_pc_get_set_reg(iommu, 0, 0, 0, &val, true) ||
+		    iommu_pc_get_set_reg(iommu, 0, 0, 0, &val2, false) ||
+		    val2)
+			break;
+
+		/* Wait about 20 msec for power gating to disable and retry. */
+		msleep(20);
+	}
+
 	/* restore */
-	if (iommu_pc_get_set_reg(iommu, 0, 0, 0, &save_reg, true))
+	if (iommu_pc_get_set_reg(iommu, 0, 0, 0, &save_reg, true) ||
+	    iommu_pc_get_set_reg(iommu, 0, 0, 8, &save_src, true))
+		goto pc_false;
+
+	if (val != val2)
 		goto pc_false;
 
 	pci_info(pdev, "IOMMU performance counters supported\n");
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
