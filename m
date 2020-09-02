Return-Path: <SRS0=BMay=CL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,RCVD_ILLEGAL_IP,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAC17C433E2
	for <iommu@archiver.kernel.org>; Wed,  2 Sep 2020 05:22:49 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E27C20829
	for <iommu@archiver.kernel.org>; Wed,  2 Sep 2020 05:22:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Y7ootEnB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E27C20829
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 6B4BB87186;
	Wed,  2 Sep 2020 05:22:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pVvCGZdrZpGr; Wed,  2 Sep 2020 05:22:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 7BE998716A;
	Wed,  2 Sep 2020 05:22:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 587ABC07FF;
	Wed,  2 Sep 2020 05:22:48 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 40F40C0051
 for <iommu@lists.linux-foundation.org>; Wed,  2 Sep 2020 05:22:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 28FAF84EB0
 for <iommu@lists.linux-foundation.org>; Wed,  2 Sep 2020 05:22:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Ya14rrrSM-JN for <iommu@lists.linux-foundation.org>;
 Wed,  2 Sep 2020 05:22:46 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2083.outbound.protection.outlook.com [40.107.236.83])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 1144D84E8F
 for <iommu@lists.linux-foundation.org>; Wed,  2 Sep 2020 05:22:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z2TpGrd1bYRxAv5oNJcYJoc+zEUeErEHWhR73kvQuII8hUnijXgh87Htyyt850c7kehZZHXUZ24lHrFanfCmoZnVixgJGH8DTRia9unUhTecj5rebPoom9j16ayRzjoZpDI7texFAhtkaoWktMZF2j9ip4XWBHyt30quIkYUFkpvgKHguQfKASjbFfV1S+wMbN29vMk6cA05HCbu02ls+iG+uk+M4KoBbUyNMCW+Wefvmwpm8BuqkQ27jyXa89mY3oJgwwbL528WcW2Gl7JQ8GGjtJET/C3efKiqCdPQ1cqMbNNn3YY/yfSLxhUz2vTTKFUU/hfX1HLA08IFN+XCGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ulAaKW1IFkd7SNsr8YqwGV8vpEzdEUKPrLb1OtYFhhg=;
 b=C2vsReu4ktuWns64GzisVlZY+yVcwThswmhc7Io7961Njq6/ib+AV3CTxuYyDxMYeg562Kwst/Q/NPwnY4FTJWIV+cpljfD3chxwq0Xfx66C67D/zj4vcOF7bZCzDOWSN/KjAGEKFkmnHAmCdy1b8Mc6lo2QYEMlsb/egpgE5yV/iMap652CCU4hw0EME8+T8XQXGEryUTXIQtpj5UqHB4rBMWYTfh8iRH5YTIXRPTEK0npRAjddy7F6/mI+xqhQ4NfrsgXGpHEjoEPNvK1l+B+tOq6DSSJ/MmI/pLbQi7PtpVhtRKWcHMRl0A0deEaOMd8uq23/2leU1gO80nluFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ulAaKW1IFkd7SNsr8YqwGV8vpEzdEUKPrLb1OtYFhhg=;
 b=Y7ootEnBDSpATro2uYdWD+j9Kq5e+CGl63IypgCOgCIlCRi1F2acqnnjdqiuJppuzLFVzgmUIoc0zbFHr1Zwp2JS9J/zjEodZLY7t2c3cSXkVTRJVzz2ul96KLJcnjO9VAM/MATl1G+TiqAEte4c3r2e3HmdszwOu4RaiEvQSPA=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1163.namprd12.prod.outlook.com (2603:10b6:3:7a::18) by
 DM6PR12MB2795.namprd12.prod.outlook.com (2603:10b6:5:41::32) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3348.15; Wed, 2 Sep 2020 04:49:50 +0000
Received: from DM5PR12MB1163.namprd12.prod.outlook.com
 ([fe80::cc8d:7537:ec56:108e]) by DM5PR12MB1163.namprd12.prod.outlook.com
 ([fe80::cc8d:7537:ec56:108e%11]) with mapi id 15.20.3326.025; Wed, 2 Sep 2020
 04:49:50 +0000
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: linux-kernel@vger.kernel.org,
	iommu@lists.linux-foundation.org
Subject: [PATCH 2/2] iommu: amd: Use cmpxchg_double() when updating 128-bit
 IRTE
Date: Wed,  2 Sep 2020 04:51:10 +0000
Message-Id: <20200902045110.4679-3-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200902045110.4679-1-suravee.suthikulpanit@amd.com>
References: <20200902045110.4679-1-suravee.suthikulpanit@amd.com>
X-ClientProxiedBy: SN1PR12CA0093.namprd12.prod.outlook.com
 (2603:10b6:802:21::28) To DM5PR12MB1163.namprd12.prod.outlook.com
 (2603:10b6:3:7a::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by
 SN1PR12CA0093.namprd12.prod.outlook.com (2603:10b6:802:21::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3326.19 via Frontend Transport; Wed, 2 Sep 2020 04:49:49 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.78.2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ad6c3f63-d05d-46d5-0688-08d84efb9fd2
X-MS-TrafficTypeDiagnostic: DM6PR12MB2795:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB279542FD6ED037F397BC2EF9F32F0@DM6PR12MB2795.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5eNMB+Vzyp6xE1T8iGMl9woaMol6pld/14AbcO2V/d2BvpCF7I9n3303DI6luUlt+B7OuFebesVwYL+PDntCwtp3ZK/ZwGa69kK+PbYcpz6EULoclyoBP9UB+x26nz+CyPBo030k+arc/N5in21nvvx/OYUYurVBhJ7HxAiyS/kDLFFUnPxvDav12p+FT6l43EUtJxtoDyrcvA9Z36dPbgBPjeTP18Pru3yJXiSR5C1zScerPeN6OaSWt+oprXe2ph4OdOHT3vw7fgL2ySlrAEybrPeiwxQnzJZPfKoWOBsoWNF73bJAI190cXke0wwv9KR5Ud4C4B+dss+lZiMl0A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1163.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(366004)(39860400002)(376002)(136003)(346002)(83380400001)(4326008)(8936002)(2616005)(956004)(86362001)(478600001)(26005)(16576012)(44832011)(8676002)(2906002)(5660300002)(36756003)(66556008)(316002)(66476007)(66946007)(186003)(6666004)(1076003)(6486002)(52116002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 5oXmT1IC3Jp15VWr+CU35BA+XSANZk+sgquKflGAWtvt4PxnqDPQzHBR7fvhZXdvLgzhqGlvRqG1NXQN6GsSSl2hjMB/B4NBgJb6s32yobDiAwI58oHSwm9oRiYF41hypPwb5QijpTAJZgc99lRwwTEMhY5V8y3vK1Fx+4dvjiDURt1qvQAdJb4iMDH6sBTxJb1D2Ka6E9OYyUd0QuPReOEeMi+STyOdTOsifMIrdmu+AJ3uWa703ypuAA8divgvl7NjtNbCZdniY7moiwKwQyT/nbEL8NuG6OPMUqwFPSKAxOqRDJ4PB9gI9NM5jiGFbFpJ1hOeKfRuD/RowQzkcsw7xIQ0p5WiK2/Fge8vuS1ycghBKuk39ICoO2xWQQxLyB73lI06cga07PxlV7kZo9vRj07UNh6ShnVhcORxxwafb+MM5aQRxlZ3lWl3vrSJbKDTs99w47vhX8Bco7gL35YI1LL0GfyQTcwJLS4snFnmY6I9qxMpZlmWZ1NvnUNvos23yrlRSGtL/wPEgXhMchw217ohhxJTvwjp8gXvJM9s5QpivSkCM4tvH2nxaNKY2Ag+wuFN7FFSVQ1pDDtNjfPfwTsDtMI829ZKn244iP9e1HoPdegM3tXi2d2mdlFjruN1w2G9Fs5XFv8J0Sq9WA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad6c3f63-d05d-46d5-0688-08d84efb9fd2
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1163.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2020 04:49:49.9953 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Migg7PcHwKESRh53wMsl0/vQMDZNCSNymzNnT9DWpRG3h1FN2jlJJQ4XZwLmMXg1xYrPdCO671cCbocV4qbleg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2795
Cc: jon.grimm@amd.com, james.puthukattukaran@oracle.com,
 boris.ostrovsky@oracle.com, joao.m.martins@oracle.com,
 sean.m.osborne@oracle.com
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

When using 128-bit interrupt-remapping table entry (IRTE) (a.k.a GA mode),
current driver disables interrupt remapping when it updates the IRTE
so that the upper and lower 64-bit values can be updated safely.

However, this creates a small window, where the interrupt could
arrive and result in IO_PAGE_FAULT (for interrupt) as shown below.

  IOMMU Driver            Device IRQ
  ============            ===========
  irte.RemapEn=0
       ...
   change IRTE            IRQ from device ==> IO_PAGE_FAULT !!
       ...
  irte.RemapEn=1

This scenario has been observed when changing irq affinity on a system
running I/O-intensive workload, in which the destination APIC ID
in the IRTE is updated.

Instead, use cmpxchg_double() to update the 128-bit IRTE at once without
disabling the interrupt remapping. However, this means several features,
which require GA (128-bit IRTE) support will also be affected if cmpxchg16b
is not supported (which is unprecedented for AMD processors w/ IOMMU).

Reported-by: Sean Osborne <sean.m.osborne@oracle.com>
Tested-by: Erik Rockstrom <erik.rockstrom@oracle.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/Kconfig |  2 +-
 drivers/iommu/amd/init.c  | 21 +++++++++++++++++++--
 drivers/iommu/amd/iommu.c | 17 +++++++++++++----
 3 files changed, 33 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/amd/Kconfig b/drivers/iommu/amd/Kconfig
index 1f061d91e0b8..626b97d0dd21 100644
--- a/drivers/iommu/amd/Kconfig
+++ b/drivers/iommu/amd/Kconfig
@@ -10,7 +10,7 @@ config AMD_IOMMU
 	select IOMMU_API
 	select IOMMU_IOVA
 	select IOMMU_DMA
-	depends on X86_64 && PCI && ACPI
+	depends on X86_64 && PCI && ACPI && HAVE_CMPXCHG_DOUBLE
 	help
 	  With this option you can enable support for AMD IOMMU hardware in
 	  your system. An IOMMU is a hardware component which provides
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index c652f16eb702..ad30467f6930 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -1511,7 +1511,14 @@ static int __init init_iommu_one(struct amd_iommu *iommu, struct ivhd_header *h)
 			iommu->mmio_phys_end = MMIO_REG_END_OFFSET;
 		else
 			iommu->mmio_phys_end = MMIO_CNTR_CONF_OFFSET;
-		if (((h->efr_attr & (0x1 << IOMMU_FEAT_GASUP_SHIFT)) == 0))
+
+		/*
+		 * Note: GA (128-bit IRTE) mode requires cmpxchg16b supports.
+		 * GAM also requires GA mode. Therefore, we need to
+		 * check cmbxchg16b support before enabling it.
+		 */
+		if (!boot_cpu_has(X86_FEATURE_CX16) ||
+		    ((h->efr_attr & (0x1 << IOMMU_FEAT_GASUP_SHIFT)) == 0))
 			amd_iommu_guest_ir = AMD_IOMMU_GUEST_IR_LEGACY;
 		break;
 	case 0x11:
@@ -1520,8 +1527,18 @@ static int __init init_iommu_one(struct amd_iommu *iommu, struct ivhd_header *h)
 			iommu->mmio_phys_end = MMIO_REG_END_OFFSET;
 		else
 			iommu->mmio_phys_end = MMIO_CNTR_CONF_OFFSET;
-		if (((h->efr_reg & (0x1 << IOMMU_EFR_GASUP_SHIFT)) == 0))
+
+		/*
+		 * Note: GA (128-bit IRTE) mode requires cmpxchg16b supports.
+		 * XT, GAM also requires GA mode. Therefore, we need to
+		 * check cmbxchg16b support before enabling them.
+		 */
+		if (boot_cpu_has(X86_FEATURE_CX16) ||
+		    ((h->efr_reg & (0x1 << IOMMU_EFR_GASUP_SHIFT)) == 0)) {
 			amd_iommu_guest_ir = AMD_IOMMU_GUEST_IR_LEGACY;
+			break;
+		}
+
 		/*
 		 * Note: Since iommu_update_intcapxt() leverages
 		 * the IOMMU MMIO access to MSI capability block registers
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 967f4e96d1eb..a382d7a73eaa 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -3292,6 +3292,7 @@ static int alloc_irq_index(u16 devid, int count, bool align,
 static int modify_irte_ga(u16 devid, int index, struct irte_ga *irte,
 			  struct amd_ir_data *data)
 {
+	bool ret;
 	struct irq_remap_table *table;
 	struct amd_iommu *iommu;
 	unsigned long flags;
@@ -3309,10 +3310,18 @@ static int modify_irte_ga(u16 devid, int index, struct irte_ga *irte,
 
 	entry = (struct irte_ga *)table->table;
 	entry = &entry[index];
-	entry->lo.fields_remap.valid = 0;
-	entry->hi.val = irte->hi.val;
-	entry->lo.val = irte->lo.val;
-	entry->lo.fields_remap.valid = 1;
+
+	ret = cmpxchg_double(&entry->lo.val, &entry->hi.val,
+			     entry->lo.val, entry->hi.val,
+			     irte->lo.val, irte->hi.val);
+	/*
+	 * We use cmpxchg16 to atomically update the 128-bit IRTE,
+	 * and it cannot be updated by the hardware or other processors
+	 * behind us, so the return value of cmpxchg16 should be the
+	 * same as the old value.
+	 */
+	WARN_ON(!ret);
+
 	if (data)
 		data->ref = entry;
 
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
