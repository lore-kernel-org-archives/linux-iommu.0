Return-Path: <SRS0=kdGy=CM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,RCVD_ILLEGAL_IP,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5967DC433E7
	for <iommu@archiver.kernel.org>; Thu,  3 Sep 2020 09:36:41 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A0B8207EA
	for <iommu@archiver.kernel.org>; Thu,  3 Sep 2020 09:36:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="FMAsPodc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A0B8207EA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id F3C8E8737E;
	Thu,  3 Sep 2020 09:36:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Zltl28tdQGpr; Thu,  3 Sep 2020 09:36:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 6D6FC8737F;
	Thu,  3 Sep 2020 09:36:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 60D3FC0052;
	Thu,  3 Sep 2020 09:36:39 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 13F57C0051
 for <iommu@lists.linux-foundation.org>; Thu,  3 Sep 2020 09:36:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 0258D86B3C
 for <iommu@lists.linux-foundation.org>; Thu,  3 Sep 2020 09:36:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ISqPHdrlXwcJ for <iommu@lists.linux-foundation.org>;
 Thu,  3 Sep 2020 09:36:37 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2073.outbound.protection.outlook.com [40.107.94.73])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 4CD8F86B53
 for <iommu@lists.linux-foundation.org>; Thu,  3 Sep 2020 09:36:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NQbrkCzWX93zO996VVNTfm+lzuhCjLQKrPH+GeOHnZSRIywX+4B7sbGgcWqm6azWUbdZ27uDZbQj+/CKH7cQGgRS42XOe6fCL0nAyECKfu6AtA9WsshGINk/0VFaUnsdCtMJBXDvVjw6dak95dIJRmYyiEy+H9W31O1X402WmJfB/TBDtWHr7MXjD6k8rj7nb5DO088HIA3uMg1+PT4tCXdyPQE+zkqFA1n91rNQEgW5xd9PzD4SGXGCORlOy0MKckYCi1OXFw+X4pMHNK/2pVV7x8WVEHApi5gWpH7KWppjpnjd36vK8F8xxDzec7LFRVgP2nR4T43xT7nMqpN8qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EEdK69OgQDvP7KIW6AjKbLso1HVGIwb/JlVSWCNsGV0=;
 b=BpwBsrxKVXnFm3ZWsDzY7jc5fPsuGKS9STs0RmA7O0fggdeNoRskaxl6xenp4DjUktJQBZAlB7xSc/86GuH0bCjp+xW2vaX+OErVWlkgOPN5TCoG4YkMLWSqLfGRrHQM4E8XhTnJaS1+/5T4XklbQq8n2jW2gQ3wjwRCXyzoT19JMRtZR2MxS/PDfDZqVa+KQ1B/ophxeQ8uO0THFkNDm/yuKHwJvmXuYELImOwRfFj0T8cwyCYvA7uS7o/r/v0fdMNWqeHP9i+yUxQsMYNLy22Zgc8ouVCgEMmFsuOROrTYegaszy7dW5as75rOIZDPojB1WImCxbIsaOvVbhG/bQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EEdK69OgQDvP7KIW6AjKbLso1HVGIwb/JlVSWCNsGV0=;
 b=FMAsPodcf2wUiMYcfAN+QE11mlJVqs9Wy7KsCfu0NPxCyMXE+CxEU4U6bUZg4BGx9GDrV77r6luRE5JwCxJg3Wqf64lpSqHLTGCyR1393DlzL17eUdjgvPk7+v9u/hb9G3it+S6AKfJe4tieNio4zyZ5LIzRFqL44Gq1NUTO2SQ=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1163.namprd12.prod.outlook.com (10.168.240.18) by
 DM6PR12MB4337.namprd12.prod.outlook.com (20.180.254.76) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3348.15; Thu, 3 Sep 2020 09:36:34 +0000
Received: from DM5PR12MB1163.namprd12.prod.outlook.com
 ([fe80::cc8d:7537:ec56:108e]) by DM5PR12MB1163.namprd12.prod.outlook.com
 ([fe80::cc8d:7537:ec56:108e%11]) with mapi id 15.20.3326.025; Thu, 3 Sep 2020
 09:36:34 +0000
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: linux-kernel@vger.kernel.org,
	iommu@lists.linux-foundation.org
Subject: [PATCH 2/2 v2] iommu: amd: Use cmpxchg_double() when updating 128-bit
 IRTE
Date: Thu,  3 Sep 2020 09:38:22 +0000
Message-Id: <20200903093822.52012-3-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200903093822.52012-1-suravee.suthikulpanit@amd.com>
References: <20200903093822.52012-1-suravee.suthikulpanit@amd.com>
X-ClientProxiedBy: DM6PR13CA0002.namprd13.prod.outlook.com
 (2603:10b6:5:bc::15) To DM5PR12MB1163.namprd12.prod.outlook.com
 (2603:10b6:3:7a::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by
 DM6PR13CA0002.namprd13.prod.outlook.com (2603:10b6:5:bc::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3370.7 via Frontend Transport; Thu, 3 Sep 2020 09:36:33 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.78.2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 250b46ee-29dd-4c70-d4ef-08d84fecd8e7
X-MS-TrafficTypeDiagnostic: DM6PR12MB4337:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB433779AFCF83026665C8F809F32C0@DM6PR12MB4337.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RLIxR+zF2sz4wBiSqUkvS7jGNGdCDDude0M1n/Yx91QPGKGz/OzfKePEkgNOnukIk2lerkQl7o2+rj2ZnGwXOISr31Kk2+rc3UAhWHZYhf0nHQk7TcsZ64FPVttIoitwkbjIq0GJX55DX2HJT5TMD5UY/ZQwQYfysRxLeizQ9CypTdYtltr0ieOCQHcQryIEU/MMWkP6N1WQ1wkAiIOyNNfOmbuD99VnCx9RPV6lUsj1gzFQ1hO8new5nhkUl1e2S6Gt+V9rJfWtVN4Q9WhmMxzR98Pi/PkhNbN5bteafawb9z/PcZtrHXnKYfAvbJqHoMj8e/t9xzBRiA/9UnXM1Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1163.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(346002)(396003)(376002)(39860400002)(83380400001)(2616005)(1076003)(36756003)(6666004)(956004)(2906002)(478600001)(52116002)(8676002)(8936002)(316002)(5660300002)(4326008)(16576012)(86362001)(6486002)(186003)(26005)(66476007)(66946007)(66556008)(44832011);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: Y5ReFm8Td4VAf58ztQBPRsG5aEm05pemymDNNzzuWsZHjgVt68Jc+45xTfknms/goMZUiibBnkhZq7+n9wh77tC1PgQzZLL31/Wd7hYWANQKI79OCCRe5ilPIHaohYsb2Tn9jvxBDsovya/SmLltKsd2xX3Tub7p+UXNJXHqbOcMDH6JG+Hb/LXxBFzEpejvzkLbTGJ+PRPwqphfxUs70/9PKvfGaYQ2eFhsechL4QXnnDWJbmiWP1loVA9zbZN6FK6IPC1sTHAfh8nUaHmXKexnlWvpMKmP5kynclnfhb2RR2ZJ+w9Ye8j3GcGLlxlHp4wTW2oz6CuyAagaxJfl3nTQXoU9EMMIyPV9P9m3nDXxCbD+K1WwHDitP4LexILWOkjveB3UaPqw3rKc67Z8QyH9tzGTXk/hdFYQwxcJtTs+3jKQvR4dUtEIuV/BbveWvnSc/ScL9blqSfobhvtHk8LsQkuCdPO3CTydl4CMzd1ZeC347ClkUiJ9LDTojWzDhmUfRecxntPg4ItueV4bAeyB2FMvmejNBjtmbVQGIfAQXb+3H5SDd5DHRdoeDSDDRoBXVT313YJxP3qDY3Y14a1nne7RbNKL6g+a9GLdY707y6/bRBK0NbtfOTzlTIecKM/s7ZjzGLO7lQk4gM2PmQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 250b46ee-29dd-4c70-d4ef-08d84fecd8e7
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1163.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2020 09:36:34.5352 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bKCAcm34fdvNgI0NOmMjfodH4bdS90fusaK6q42u7L0lKYPk7DiJtYYKrQZB4jCBsXIm5dOeIB0p4SPZCh1iNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4337
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

Reviewed-by: Joao Martins <joao.m.martins@oracle.com>
Reported-by: Sean Osborne <sean.m.osborne@oracle.com>
Tested-by: Erik Rockstrom <erik.rockstrom@oracle.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Fixes: 880ac60e2538 ("iommu/amd: Introduce interrupt remapping ops structure")
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
index c652f16eb702..ac09e4063677 100644
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
+		 * check cmpxchg16b support before enabling it.
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
+		 * check cmpxchg16b support before enabling them.
+		 */
+		if (!boot_cpu_has(X86_FEATURE_CX16) ||
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
