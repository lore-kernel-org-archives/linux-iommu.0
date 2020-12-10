Return-Path: <SRS0=6gDp=FO=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA714C433FE
	for <iommu@archiver.kernel.org>; Thu, 10 Dec 2020 16:22:27 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2899423158
	for <iommu@archiver.kernel.org>; Thu, 10 Dec 2020 16:22:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2899423158
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id A453B20525;
	Thu, 10 Dec 2020 16:22:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qHwh7UrjnZre; Thu, 10 Dec 2020 16:22:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 9E0382050B;
	Thu, 10 Dec 2020 16:22:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8B6C7C0893;
	Thu, 10 Dec 2020 16:22:24 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9F652C013B
 for <iommu@lists.linux-foundation.org>; Thu, 10 Dec 2020 16:22:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 8D1C0870E5
 for <iommu@lists.linux-foundation.org>; Thu, 10 Dec 2020 16:22:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id A5ZbEHWl8rEv for <iommu@lists.linux-foundation.org>;
 Thu, 10 Dec 2020 16:22:22 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2070.outbound.protection.outlook.com [40.107.220.70])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 5672B870E4
 for <iommu@lists.linux-foundation.org>; Thu, 10 Dec 2020 16:22:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dTRAK69Yd6uKRRQylQpmpl6jDni532gUDAvV0+YN7lDQbYjnb8LBhX242mikXrzwL141S9+coVqVN008Jr9yAnmhoTtd2atLeAOa/tl+QD0oErutQZUZ2GYi6nvFAr6LwSkfb2hSI9rCUlNMBZCBnPkBQrbHPFD4PaCiQAasmeaf2LHvHn3Gq4TOl0NljOJttBWDujuCCVWAuE29BeoNLumZFLmMASk3a+QbEZyHyynBKbMT3GS0mvK3HD1vgq/VB97s3DkmExMxP+t6i9Ve9N94UJC0PF9iiQRn6AiSXV3X1/EE3Os14YFZCsSE7k99SaT0FfzvB5MYkgeYFtydtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xC8US1bwidRSiHIJ4XPZSyOpGGP1P3QuWmDK/Ik16HM=;
 b=McDOqlJcLMOwIdfaaNsfaPlsdQq8gsW2mApjcITw3t1bSgHS4JZQn7/SGLwuGKAvdKrsr0HLsPSHUM9tpblwDqqRyc9F3JIT6WbBVfqGXj2Cc7T2zsn1ydA4AY/1kH741h0FKdJjAFZKyGRO/r+NGjnEYTXUAPaHIpad09KhvZHAJl7av74zOwqah8vlLqr8e7ZpFpk9GASKYsUZzC5yJK9MAH1RYY9sC8CTd5VcXFUMw0d/0U7eUcbl9BOsu9wLD0cMiq1/UuCf4QgjPUxj4gFHmx8tKiaewW0H39slQK+IkjmLivCtYKY0MvQr58nJBhJpkOC8EyBFgixiWHdU1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xC8US1bwidRSiHIJ4XPZSyOpGGP1P3QuWmDK/Ik16HM=;
 b=kGWRIMQzk1Q0Lx7yd1Ru83JiIWdz4kueL/bq+mjJ+l+eoObonDK4vh/RZBeCebkurkrOmJXznKbIOv0l/BQvqB0yM+lXzVf2i9osm7mfD06mFgOFOeJvrwxn9Xgdb3uJVN4Ra6o+DSlIyEZUw4I5XFeVj9z2b7lretZ+oy8QBaQ=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4597.namprd12.prod.outlook.com (2603:10b6:a03:10b::14)
 by BYAPR12MB2918.namprd12.prod.outlook.com (2603:10b6:a03:13c::27)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.12; Thu, 10 Dec
 2020 16:22:17 +0000
Received: from BYAPR12MB4597.namprd12.prod.outlook.com
 ([fe80::dd10:efd2:e325:53c7]) by BYAPR12MB4597.namprd12.prod.outlook.com
 ([fe80::dd10:efd2:e325:53c7%3]) with mapi id 15.20.3654.012; Thu, 10 Dec 2020
 16:22:17 +0000
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: linux-kernel@vger.kernel.org,
	iommu@lists.linux-foundation.org
Subject: [PATCH] iommu/amd: Add sanity check for interrupt remapping table
 length macros
Date: Thu, 10 Dec 2020 10:24:36 -0600
Message-Id: <20201210162436.126321-1-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.78.2]
X-ClientProxiedBy: CH2PR20CA0029.namprd20.prod.outlook.com
 (2603:10b6:610:58::39) To BYAPR12MB4597.namprd12.prod.outlook.com
 (2603:10b6:a03:10b::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ethanolx5673host.amd.com (165.204.78.2) by
 CH2PR20CA0029.namprd20.prod.outlook.com (2603:10b6:610:58::39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3654.12 via Frontend Transport; Thu, 10 Dec 2020 16:22:15 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 194e88d4-45ee-45b3-085d-08d89d27c2c9
X-MS-TrafficTypeDiagnostic: BYAPR12MB2918:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB29180F395BC29A0FD6FBECF7F3CB0@BYAPR12MB2918.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KBYFa73i3a8IqkPXr0hC2qpQDc3gsQxw4++jHc+KX42268MD2/+zk3CgLvqb8nC7f08LUS+bVvpfdMTmaRUsx71BT6fLoccs1MDyMwzHU89ml5qX79t5+JPTTx/172zut2FtQJc2Czoxd9uPZ/yK7tRuWz8/csJM6U4x49/bSOBDg/Giwfw3Hs5JfJGt/iFUyHhAAJFG7FzY/2wEc91ZvQ+/pDgpRq4iO720xus2ZLgBgDCp+clTrB7hdpOlCmSGHMEc3OzapGOje1QczMBI3PnyO1EbxfqXe7Y8wndiUJq/AB6RO8yRl6GW8Wam98+4HrPr0lGY/2kWjj2q2P06pfCOlVAFg4VKB3iW1T6kptQCgZzY4b1rIgSHg6Jj1eQ0
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4597.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(346002)(376002)(66476007)(86362001)(66556008)(508600001)(186003)(8676002)(5660300002)(8936002)(26005)(83380400001)(1076003)(16526019)(66946007)(956004)(44832011)(7696005)(52116002)(6666004)(34490700003)(2906002)(4326008)(36756003)(2616005)(6486002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?r7aS3bKorMdJDGP+3yvsSEtO0Za+T48EQGhidQz36DCta1akmw2mnFSwBZN/?=
 =?us-ascii?Q?E4+TrnXgRdiLEMAYImYQVgQpo4T0c4plfgUhmWSnOx3WuRrhXCDWjwrDP2R9?=
 =?us-ascii?Q?e6d9XGITb/wGsqc/bgD93IeVrUgLlmbbVWC3bnh0A35I1YOIQrJndbK4o7OI?=
 =?us-ascii?Q?28WIXzKTTDNhm039NI4OlRSQXDrbEuFuMqo37tHpeq0j0ApxcDKbWJMXa4EB?=
 =?us-ascii?Q?uofIhnFDC1ibL+vTWCa3SObhC6opFHoRhUhycjf0lDDj6E55/MBmES7BM7jv?=
 =?us-ascii?Q?q5NB+dpRsXIciH7Caou7af4VVjquYK6OZcz1+wH6qHBwBXl/WkcujhAhVmNl?=
 =?us-ascii?Q?6jooG3obzZwsvmBEjP/YANbDQ26TP4Yt/AMSBicJ1/K/vYE31BNYhfEuPnTW?=
 =?us-ascii?Q?zTzjF0HGcIo5NqYe3wTBi5v3T+9fADptI+K8SdHZ7Hu0kkqQRB8MFsX01QXA?=
 =?us-ascii?Q?h43s3UwX7FWpbrKwdn09FU74BomFU0O38W2l5XgjMoMxL4AkFbjFiU589QaF?=
 =?us-ascii?Q?ZVI8ahneNKqerCqKtC94HEzK2aYrFNoIxlrH9ttN34x/S2nkPypkav4VHMoR?=
 =?us-ascii?Q?oEdeQvU8gYYZlZvCPGRHpDMHW2I3QZgydur0gWtxzUTfreOqskisoRTeoiTL?=
 =?us-ascii?Q?Yr93+eJq1rxZIN3gUz4Df7nnt59Xy6cWSpibcr9YUOscePsIkuvfdpfgKGcA?=
 =?us-ascii?Q?Dp9+65TkqToZQ91apW0D9+2njhvN6a8L+zmm/2RnzEQwYmF7tw3xS2f2NODt?=
 =?us-ascii?Q?CUWIbiXx1iKjny0md1ezajh/wX9fgDngctXzGTYs7SEVdL4/4Wgikimsl6Ux?=
 =?us-ascii?Q?Fx11F9oLucDVagFDbEX2PQ+Nhc0RefEr13f5lb0v+Yw4q4JGHTLdjA4VOpZ6?=
 =?us-ascii?Q?Hmps5ZlMmtNVS4Hv28qaRRRduQv5TdLE7rGx1nI4O63j6kWpheJlQiSkADfN?=
 =?us-ascii?Q?j3xrSRcZ+fHauhb7U4Xn9gp+StzikIouFOZQQLXs93H3Tueaai9Ikntr2I++?=
 =?us-ascii?Q?zYQY?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4597.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2020 16:22:16.9135 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-Network-Message-Id: 194e88d4-45ee-45b3-085d-08d89d27c2c9
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yNw5u6nhcsKZxl2XkjsWYkdUlnzVM5dOsf4hX0nPEykRGGQ6d/xv0YLvfosCkmTX4Lh1mXh7cH2GSlDDg2mkoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2918
Cc: thomas.lendacky@amd.com, Jon.Grimm@amd.com, will@kernel.org
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

Currently, macros related to the interrupt remapping table length are
defined separately. This has resulted in an oversight in which one of
the macros were missed when changing the length. To prevent this,
redefine the macros to add built-in sanity check.

Also, rename macros to use the name of the DTE[IntTabLen] field as
specified in the AMD IOMMU specification. There is no functional change.

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc: Will Deacon <will@kernel.org>
Cc: Jerry Snitselaar <jsnitsel@redhat.com>
Cc: Joerg Roedel <joro@8bytes.org>
---
 drivers/iommu/amd/amd_iommu_types.h | 19 ++++++++++---------
 drivers/iommu/amd/init.c            |  6 +++---
 drivers/iommu/amd/iommu.c           |  2 +-
 3 files changed, 14 insertions(+), 13 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 494b42a31b7a..899ce62df3f0 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -255,11 +255,19 @@
 /* Bit value definition for dte irq remapping fields*/
 #define DTE_IRQ_PHYS_ADDR_MASK	(((1ULL << 45)-1) << 6)
 #define DTE_IRQ_REMAP_INTCTL_MASK	(0x3ULL << 60)
-#define DTE_IRQ_TABLE_LEN_MASK	(0xfULL << 1)
 #define DTE_IRQ_REMAP_INTCTL    (2ULL << 60)
-#define DTE_IRQ_TABLE_LEN       (9ULL << 1)
 #define DTE_IRQ_REMAP_ENABLE    1ULL
 
+/*
+ * AMD IOMMU hardware only support 512 IRTEs despite
+ * the architectural limitation of 2048 entries.
+ */
+#define DTE_INTTAB_ALIGNMENT    128
+#define DTE_INTTABLEN_VALUE     9ULL
+#define DTE_INTTABLEN           (DTE_INTTABLEN_VALUE << 1)
+#define DTE_INTTABLEN_MASK      (0xfULL << 1)
+#define MAX_IRQS_PER_TABLE      (1 << DTE_INTTABLEN_VALUE)
+
 #define PAGE_MODE_NONE    0x00
 #define PAGE_MODE_1_LEVEL 0x01
 #define PAGE_MODE_2_LEVEL 0x02
@@ -409,13 +417,6 @@ extern bool amd_iommu_np_cache;
 /* Only true if all IOMMUs support device IOTLBs */
 extern bool amd_iommu_iotlb_sup;
 
-/*
- * AMD IOMMU hardware only support 512 IRTEs despite
- * the architectural limitation of 2048 entries.
- */
-#define MAX_IRQS_PER_TABLE	512
-#define IRQ_TABLE_ALIGNMENT	128
-
 struct irq_remap_table {
 	raw_spinlock_t lock;
 	unsigned min_index;
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 23a790f8f550..6bec8913d064 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -989,10 +989,10 @@ static bool copy_device_table(void)
 
 		irq_v = old_devtb[devid].data[2] & DTE_IRQ_REMAP_ENABLE;
 		int_ctl = old_devtb[devid].data[2] & DTE_IRQ_REMAP_INTCTL_MASK;
-		int_tab_len = old_devtb[devid].data[2] & DTE_IRQ_TABLE_LEN_MASK;
+		int_tab_len = old_devtb[devid].data[2] & DTE_INTTABLEN_MASK;
 		if (irq_v && (int_ctl || int_tab_len)) {
 			if ((int_ctl != DTE_IRQ_REMAP_INTCTL) ||
-			    (int_tab_len != DTE_IRQ_TABLE_LEN)) {
+			    (int_tab_len != DTE_INTTABLEN)) {
 				pr_err("Wrong old irq remapping flag: %#x\n", devid);
 				return false;
 			}
@@ -2674,7 +2674,7 @@ static int __init early_amd_iommu_init(void)
 			remap_cache_sz = MAX_IRQS_PER_TABLE * (sizeof(u64) * 2);
 		amd_iommu_irq_cache = kmem_cache_create("irq_remap_cache",
 							remap_cache_sz,
-							IRQ_TABLE_ALIGNMENT,
+							DTE_INTTAB_ALIGNMENT,
 							0, NULL);
 		if (!amd_iommu_irq_cache)
 			goto out;
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index b9cf59443843..f7abf16d1e3a 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -3191,7 +3191,7 @@ static void set_dte_irq_entry(u16 devid, struct irq_remap_table *table)
 	dte	&= ~DTE_IRQ_PHYS_ADDR_MASK;
 	dte	|= iommu_virt_to_phys(table->table);
 	dte	|= DTE_IRQ_REMAP_INTCTL;
-	dte	|= DTE_IRQ_TABLE_LEN;
+	dte	|= DTE_INTTABLEN;
 	dte	|= DTE_IRQ_REMAP_ENABLE;
 
 	amd_iommu_dev_table[devid].data[2] = dte;
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
