Return-Path: <SRS0=LjD4=JG=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFBB2C433B4
	for <iommu@archiver.kernel.org>; Fri,  9 Apr 2021 08:47:41 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 78E12611AB
	for <iommu@archiver.kernel.org>; Fri,  9 Apr 2021 08:47:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78E12611AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 21A48607D7;
	Fri,  9 Apr 2021 08:47:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gTcbn-btrmj3; Fri,  9 Apr 2021 08:47:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id CB3E8607DA;
	Fri,  9 Apr 2021 08:47:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A6D62C000B;
	Fri,  9 Apr 2021 08:47:39 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 28D8AC000A
 for <iommu@lists.linux-foundation.org>; Fri,  9 Apr 2021 08:47:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 062ED40E8F
 for <iommu@lists.linux-foundation.org>; Fri,  9 Apr 2021 08:47:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=amd.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1ArZ0APolXc7 for <iommu@lists.linux-foundation.org>;
 Fri,  9 Apr 2021 08:47:35 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2087.outbound.protection.outlook.com [40.107.244.87])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A2D2B40169
 for <iommu@lists.linux-foundation.org>; Fri,  9 Apr 2021 08:47:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W7/UJRdEKa4Q/dYgPk3ikJArpgdMNuQbgaPPag9oZWTO4NcfWmrTkQ1HgjS7wRfUT3wLXkku/Fd8qYloYP6vvoIBj1JrRWkSdXlc036F8pHSMQLV5CXqeJchrZLq2EdubcQfnYztlH7gOlgKWmTbM5WCBtqLi+3+MrmuLvJNZCiQXYXGacf6T4N1QGy9VklHRnAiB1vUWLFyjtEx5KxeVO/gFBocpYCyqdqOjMCPei80kq9W8ftn9Ya9mLsViSNL7li3YZqNGqaG61DYhc5FI2RLDIDs10zUM0mjzGQYN8nTCqdop5H4W0z7WI0F2HrrM/ARBHb0lT5QWTgdOmjPrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IrdPpEoIJrXYCKCim9t9iSiz5jn8zSXTU6TPAvweV1s=;
 b=ofhy0e2LTcSMmdlBxRLg1mKqxiLfPeh07cGfB2JELkwS3JVLuMdAzN/pVUy8OQQa/7s9aQdOBDi3583ZJzFs+X5qjKtJsyZz2cGqD1ghNoaD/w2EY6/1OHRgZklUNCaTx9IRxJBstIP5vY49tEY/NJs39O4qKHr8s84SakRGRrXWR6NNTpDlew9Akr/7W4qyLa240mfq+Mu0nI1b8xdRfJ4/283AJva/HhrnENKsqDo31pdMdmXDj8ApRkyctzRiWP2ce8tIcqS2QTUf2HNeuDWIrfdA6oZJDLJW0CUZko0G0BN131VDXBa8kDOgY25dsi0ZFQCgb0LeRAH4v5d3Kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IrdPpEoIJrXYCKCim9t9iSiz5jn8zSXTU6TPAvweV1s=;
 b=bXPux5yTftLRvKHPNVgBWiCu+WqTVOCmvMcT5Usy7hr/RYWE+D2JT/y5qhLHj2iSnGkAXbagEfVFubda8+R9R9MaxWtXBJT2HFOwxACeB3Zi11Aj6EWsvxIJvqiekcBY6038mkkyXYW1Bzz3d47SJ4w4AuN354Fj94z1nUGadcA=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4597.namprd12.prod.outlook.com (2603:10b6:a03:10b::14)
 by BY5PR12MB3889.namprd12.prod.outlook.com (2603:10b6:a03:1ad::30)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.32; Fri, 9 Apr
 2021 08:47:33 +0000
Received: from BYAPR12MB4597.namprd12.prod.outlook.com
 ([fe80::cc86:d78a:bb1d:5109]) by BYAPR12MB4597.namprd12.prod.outlook.com
 ([fe80::cc86:d78a:bb1d:5109%5]) with mapi id 15.20.3999.036; Fri, 9 Apr 2021
 08:47:33 +0000
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: linux-kernel@vger.kernel.org,
	iommu@lists.linux-foundation.org
Subject: [PATCH 1/2] Revert "iommu/amd: Fix performance counter initialization"
Date: Fri,  9 Apr 2021 03:58:47 -0500
Message-Id: <20210409085848.3908-2-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210409085848.3908-1-suravee.suthikulpanit@amd.com>
References: <20210409085848.3908-1-suravee.suthikulpanit@amd.com>
X-Originating-IP: [165.204.78.2]
X-ClientProxiedBy: SN6PR01CA0011.prod.exchangelabs.com (2603:10b6:805:b6::24)
 To BYAPR12MB4597.namprd12.prod.outlook.com
 (2603:10b6:a03:10b::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ethanolx5673host.amd.com (165.204.78.2) by
 SN6PR01CA0011.prod.exchangelabs.com (2603:10b6:805:b6::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4020.17 via Frontend Transport; Fri, 9 Apr 2021 08:47:31 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 64d29784-05c7-4bdf-74f5-08d8fb341da3
X-MS-TrafficTypeDiagnostic: BY5PR12MB3889:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR12MB3889943DFDE79BACFA25A6B1F3739@BY5PR12MB3889.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1923;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: O/rRB5HUP1eknX3XK96hrP2OkVfO2ONmxXgGLmTi4wKF3OlbZttyH0+skUSM/q2GFCsSZq3WdWFvTcYQQgspkzpYSMoTplcbHBoZKPm4N8EPxAMXCDeaAuXd2xmVbeFVri7ciggsheMGhZC1XAnF1qmgHyqgWTdB5zNPgvZh0wf/oUJafFucqKYO7QZGAyyjrTIGKBPPIuTH8cwrLWdDzq5YVhvAng1gjf6JER9sihJKAuSCttB2w/dFi4zFDqcZOMmF9Xa35B9aonlqQcYUkC8nvJCMNuVRbOtIsEol9cgUSsuPHygG9ELpWS2davBKlwPNZCzqHmE6K7Tk6fkl24rtsFgClBGzqSf0RY6+OXewR+UGSteCvGsj44IB32Qr1HmHui+GyaZqs+uk99ksP+8YFkO5iYtJAlIF2VziYR+2wkKm2QH5qO/t+SoXItYXKbZnMO7b5UkNVGlgW7Fi1qMrUUaFXql2HWyx8wzNFcaYOpmXo+XSkZNmUwzIH+UTPkJ8JGfuiqBV2vQjXCoZ3nWBN/752Gh/Qr9Q48yB1vNJXjiP9rp9OKq//8ZX7IQAmmetN9HLUUde/YgvGao6YXzuSCDHlG8MmgBP46dbuBw/cos+cSGXjjEo+1OGqicy6As04SEOTqSZ2VXKgprcvaiLFGbZ0lxaDGAC4Wb7ObL0/0V48HqMldN2fNz2d1VkaadmwxRIArpwnh6XqM/NORmM+PENQg5xpQ0WWER5p7oQUWVjeIOeGgqJNRRyYn33hjR87o1ZAnpIuX/F9iDk/lXzFKcOrsPFXZwY863bOrU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4597.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(136003)(396003)(366004)(346002)(39860400002)(7696005)(52116002)(38100700001)(36756003)(26005)(38350700001)(54906003)(83380400001)(4326008)(8936002)(8676002)(66946007)(44832011)(7416002)(5660300002)(2616005)(86362001)(478600001)(966005)(2906002)(66476007)(34580700001)(1076003)(16526019)(6486002)(186003)(956004)(316002)(6666004)(66556008);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?lIgR7nhjyJwUi2mg6vsYeIfBbwe53IW3+SFKhsEjVPsTtf8u94L3YY6t8sht?=
 =?us-ascii?Q?gXCk3qz8D7UIxA0oCBQhlnL9+ZzU3FCX63N6mAVfXtP3iHQ/v3dZa1y4XpdB?=
 =?us-ascii?Q?4x2f+6/rpk9DZjjbgqfPXEPEr9WXUPlz9R5SCtUJi+3tx+sGOahG/feDXyZP?=
 =?us-ascii?Q?z4P4p2ejruDABZV+R9DeGk0dab1TqDO1yk813LcwH+he5bKKBPjtSaCDlHct?=
 =?us-ascii?Q?cC/Wr1fybEgfkiZC/yvWmFQdCMU6xyEIul6hP1KFvdXWIp1Jh4KaSlMp7o4t?=
 =?us-ascii?Q?YpfMbZy+WxKpseNV5B9VaUr4p6NzXdW9h4/U11uR/cMXWm5fR+DSIY0XaESq?=
 =?us-ascii?Q?sird7i0w/Zn7Y7eoBPBKIucZIoNtMy4UR7Li/2HJeD6lfsJIyA6VN4GS74uZ?=
 =?us-ascii?Q?YWV4KujIOAmkqC+h2BGY6k/T0/bnhJwh+3XAGs6+LP/YRaF/kSjQMN3fCooK?=
 =?us-ascii?Q?ed05k3yIfSY0/1+EkIzVzKJXhsHaAXHJ+ITaF8QmLzHlMVYi70hlQQxp23Ta?=
 =?us-ascii?Q?m0sST/VbklSZNcV4Hr1SpO/ohbk5TwV3V37gAwFG++MBmJdpH/Y0VLim8nIp?=
 =?us-ascii?Q?dJxgivbSp75TzqrBkfVQnrJUUJxYjV9+dnqQcNk6Bu+YV6TunMr5oH7i3kSO?=
 =?us-ascii?Q?Gx2lNEzuwU/XneZBre59//L3s77Hs2/U6QcMR7ozTtzI43BkTZ4Pr3Q1/TRG?=
 =?us-ascii?Q?zo3Ks1UdUVzkLxNTq8KkdFqZPCmdv/NfOhsbOt7jWwBDnguXdowHkQk5LYao?=
 =?us-ascii?Q?gEKQmrmYrM7/pvAIRrTU/SOmmbmdt5ewNmnFbbT53mccxNaU4ccIKDjYmZZm?=
 =?us-ascii?Q?HuAun+R6p0lf/DVB7wdD6wUF7i9fgFqfnzTT67nqtFbyb2GI/LVC0ScW/ijv?=
 =?us-ascii?Q?Ia69BNQbBpBb4qtM72Z92VTAJJ+lV/o0tt1ylfG0Tuw2U4ClNQtfr5ljjYQG?=
 =?us-ascii?Q?/yS0yutA4kiwoHHfuMW9oEoRgnspKgFU4/Zimy5jTbRp/mpkQKZdqwQYV/b7?=
 =?us-ascii?Q?+4wgBHYa58H4pKMiFK5k39C1PduQB8WNG/OjzCjTQ9klXXG7sZhgSUdNJMrS?=
 =?us-ascii?Q?YyGzyUyx82XY/oV5YcBP5l5LKH65RfprJC978ILmAikX/l3wyvLi6p3r8jeI?=
 =?us-ascii?Q?CBVgXCFkRR0NPNLifh8WM2puDxh3MT8wvnFuPXVtnAVFeb1q6t7hNiIfItOd?=
 =?us-ascii?Q?u+o1wYcX1E2j6w36ts5MB9VP8P5ZKX95sMwsP3kJLPLJ83+EO+EygQIgD6YZ?=
 =?us-ascii?Q?bGT+QEfngsf+YRs2d3XFs4DRB1+hxeFTYKh31stWy5hW5NfxDSOVqTQT1Ems?=
 =?us-ascii?Q?K2xbVcIbXUe9a5ynnyvtBGxB?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64d29784-05c7-4bdf-74f5-08d8fb341da3
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4597.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2021 08:47:32.9276 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NzDvxdmYrAiE1/kWmb32i0nGh8qNMrO51efFbXFlq0RlvpsdzNhrB9gX2RgsV0T8voyE5dz63LaypuiR9hY0Zg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3889
Cc: pmenzel@molgen.mpg.de, Alexander Monakov <amonakov@ispras.ru>,
 David Coe <david.coe@live.co.uk>, Jon.Grimm@amd.com,
 Shuah Khan <skhan@linuxfoundation.org>, Tj <ml.linux@elloe.vision>,
 will@kernel.org
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

From: Paul Menzel <pmenzel@molgen.mpg.de>

This reverts commit 6778ff5b21bd8e78c8bd547fd66437cf2657fd9b.

The original commit tries to address an issue, where PMC power-gating
causing the IOMMU PMC pre-init test to fail on certain desktop/mobile
platforms where the power-gating is normally enabled.

There have been several reports that the workaround still does not
guarantee to work, and can add up to 100 ms (on the worst case)
to the boot process on certain platforms such as the MSI B350M MORTAR
with AMD Ryzen 3 2200G.

Therefore, revert this commit as a prelude to removing the pre-init
test.

Link: https://lore.kernel.org/linux-iommu/alpine.LNX.3.20.13.2006030935570.3181@monopod.intra.ispras.ru/
Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=201753
Cc: Tj (Elloe Linux) <ml.linux@elloe.vision>
Cc: Shuah Khan <skhan@linuxfoundation.org>
Cc: Alexander Monakov <amonakov@ispras.ru>
Cc: David Coe <david.coe@live.co.uk>
Signed-off-by: Paul Menzel <pmenzel@molgen.mpg.de>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
Note: I have revised the commit message to add more detail
      and remove uncessary information.

 drivers/iommu/amd/init.c | 45 ++++++++++------------------------------
 1 file changed, 11 insertions(+), 34 deletions(-)

diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 321f5906e6ed..648cdfd03074 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -12,7 +12,6 @@
 #include <linux/acpi.h>
 #include <linux/list.h>
 #include <linux/bitmap.h>
-#include <linux/delay.h>
 #include <linux/slab.h>
 #include <linux/syscore_ops.h>
 #include <linux/interrupt.h>
@@ -257,8 +256,6 @@ static enum iommu_init_state init_state = IOMMU_START_STATE;
 static int amd_iommu_enable_interrupts(void);
 static int __init iommu_go_to_state(enum iommu_init_state state);
 static void init_device_table_dma(void);
-static int iommu_pc_get_set_reg(struct amd_iommu *iommu, u8 bank, u8 cntr,
-				u8 fxn, u64 *value, bool is_write);
 
 static bool amd_iommu_pre_enabled = true;
 
@@ -1717,11 +1714,13 @@ static int __init init_iommu_all(struct acpi_table_header *table)
 	return 0;
 }
 
-static void __init init_iommu_perf_ctr(struct amd_iommu *iommu)
+static int iommu_pc_get_set_reg(struct amd_iommu *iommu, u8 bank, u8 cntr,
+				u8 fxn, u64 *value, bool is_write);
+
+static void init_iommu_perf_ctr(struct amd_iommu *iommu)
 {
-	int retry;
 	struct pci_dev *pdev = iommu->dev;
-	u64 val = 0xabcd, val2 = 0, save_reg, save_src;
+	u64 val = 0xabcd, val2 = 0, save_reg = 0;
 
 	if (!iommu_feature(iommu, FEATURE_PC))
 		return;
@@ -1729,39 +1728,17 @@ static void __init init_iommu_perf_ctr(struct amd_iommu *iommu)
 	amd_iommu_pc_present = true;
 
 	/* save the value to restore, if writable */
-	if (iommu_pc_get_set_reg(iommu, 0, 0, 0, &save_reg, false) ||
-	    iommu_pc_get_set_reg(iommu, 0, 0, 8, &save_src, false))
-		goto pc_false;
-
-	/*
-	 * Disable power gating by programing the performance counter
-	 * source to 20 (i.e. counts the reads and writes from/to IOMMU
-	 * Reserved Register [MMIO Offset 1FF8h] that are ignored.),
-	 * which never get incremented during this init phase.
-	 * (Note: The event is also deprecated.)
-	 */
-	val = 20;
-	if (iommu_pc_get_set_reg(iommu, 0, 0, 8, &val, true))
+	if (iommu_pc_get_set_reg(iommu, 0, 0, 0, &save_reg, false))
 		goto pc_false;
 
 	/* Check if the performance counters can be written to */
-	val = 0xabcd;
-	for (retry = 5; retry; retry--) {
-		if (iommu_pc_get_set_reg(iommu, 0, 0, 0, &val, true) ||
-		    iommu_pc_get_set_reg(iommu, 0, 0, 0, &val2, false) ||
-		    val2)
-			break;
-
-		/* Wait about 20 msec for power gating to disable and retry. */
-		msleep(20);
-	}
-
-	/* restore */
-	if (iommu_pc_get_set_reg(iommu, 0, 0, 0, &save_reg, true) ||
-	    iommu_pc_get_set_reg(iommu, 0, 0, 8, &save_src, true))
+	if ((iommu_pc_get_set_reg(iommu, 0, 0, 0, &val, true)) ||
+	    (iommu_pc_get_set_reg(iommu, 0, 0, 0, &val2, false)) ||
+	    (val != val2))
 		goto pc_false;
 
-	if (val != val2)
+	/* restore */
+	if (iommu_pc_get_set_reg(iommu, 0, 0, 0, &save_reg, true))
 		goto pc_false;
 
 	pci_info(pdev, "IOMMU performance counters supported\n");
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
