Return-Path: <SRS0=qGVY=DL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 890EDC46466
	for <iommu@archiver.kernel.org>; Sun,  4 Oct 2020 01:42:13 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39D5A2067D
	for <iommu@archiver.kernel.org>; Sun,  4 Oct 2020 01:42:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ft5EAzF7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39D5A2067D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 1377287058;
	Sun,  4 Oct 2020 01:42:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RYu5X6a3aPMK; Sun,  4 Oct 2020 01:42:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 0D35387068;
	Sun,  4 Oct 2020 01:42:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E77D4C0895;
	Sun,  4 Oct 2020 01:42:11 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 31D52C1AD5
 for <iommu@lists.linux-foundation.org>; Sun,  4 Oct 2020 01:42:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id B561C20349
 for <iommu@lists.linux-foundation.org>; Sun,  4 Oct 2020 01:42:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ap17nJko-FyE for <iommu@lists.linux-foundation.org>;
 Sun,  4 Oct 2020 01:42:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2082.outbound.protection.outlook.com [40.107.93.82])
 by silver.osuosl.org (Postfix) with ESMTPS id 1789B20415
 for <iommu@lists.linux-foundation.org>; Sun,  4 Oct 2020 01:42:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bwXtTc29/2soIjU7WaNCV9nVIkzzDfb1S34tJDwhA7snowt2BGO6lGFCNcWjTLc508ZQ50F5wIxXWynDDF6hdE59vz31B1OCHM3dRh73MbgPVfVGyrFT+YJTiBrJ1p1fP+c5rs/vOizJZE4GhCnyoP3ReOS0bfSs6MzWSjqBcBozXfsRihC1tc5Q3Q/X+xsGOQKq3rO4h9W/FRzjW6as1YPHhVV3n3oE4u277wbSg5NRcRuqud6o9OtzT/GJlrdeXL6UscPzlQA4vlj3lz/KNAtz/Z8ZI7lcV2wdr5c44sCJrlqFwXUMXxjr38QxDfc6elg2KaFnP2j+0UGT11wN1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VwaXxZjoMCs+km1ZSSCYq/eqbsBpS3lS9jrdpUJSWJg=;
 b=FIar9O+QospNZTxPUXb28m1J5puBcZ31Mirga2kv8YfpS6TAd+O+cFO32mVmKB/QxMU5U+BNrT4yZ5ec6nGF7Gvc/jKw1iFNMPHn037RfZCGBrvpFa7SQDUaghG7PerI7hdTgZPYekRZqb8cr5q8Icmu8z+RO7HQyEridGren67oqdWhV3hNMiUbDXsrzbHezJZVtmcJ6G4oxh1JTb3dIX/po+OyjRYlXr3Vzhnljkfh0ysSZvm+doX9hGxL1apchs28R4LhONnjxpV4CqD0xsV1BfVWTwNEK3mfsLEIZhpHQlAZW838yoKT8ZTdUGUQ9sSq0X9WhIKVpCSTTgv+ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VwaXxZjoMCs+km1ZSSCYq/eqbsBpS3lS9jrdpUJSWJg=;
 b=ft5EAzF7ncfiRs7Fz4j8BCiV6zoViixOb+ExWXMFqvt6shA+Vai54CCyJYwS9gyERd2Ixg4Gdrff6CoXJIWuNQdOrR66NOBoNZeTNXdx5qFAD2NbGj7kXYOsrLAaahXTFSvhGfwQIJkb+VKOpZoPXd5EMB32lvfMPcmq6xujSEg=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1163.namprd12.prod.outlook.com (2603:10b6:3:7a::18) by
 DM5PR12MB1451.namprd12.prod.outlook.com (2603:10b6:4:d::12) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3433.39; Sun, 4 Oct 2020 01:42:07 +0000
Received: from DM5PR12MB1163.namprd12.prod.outlook.com
 ([fe80::48cf:d69:d457:1b1e]) by DM5PR12MB1163.namprd12.prod.outlook.com
 ([fe80::48cf:d69:d457:1b1e%5]) with mapi id 15.20.3433.042; Sun, 4 Oct 2020
 01:42:07 +0000
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: linux-kernel@vger.kernel.org,
	iommu@lists.linux-foundation.org
Subject: [PATCH v3 14/14] iommu/amd: Adopt IO page table framework
Date: Sun,  4 Oct 2020 01:45:49 +0000
Message-Id: <20201004014549.16065-15-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201004014549.16065-1-suravee.suthikulpanit@amd.com>
References: <20201004014549.16065-1-suravee.suthikulpanit@amd.com>
X-Originating-IP: [165.204.78.2]
X-ClientProxiedBy: SN4PR0701CA0004.namprd07.prod.outlook.com
 (2603:10b6:803:28::14) To DM5PR12MB1163.namprd12.prod.outlook.com
 (2603:10b6:3:7a::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ethanolx5673host.amd.com (165.204.78.2) by
 SN4PR0701CA0004.namprd07.prod.outlook.com (2603:10b6:803:28::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.34 via Frontend
 Transport; Sun, 4 Oct 2020 01:42:06 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 8ca58a61-bada-4fd4-b574-08d86806b3d5
X-MS-TrafficTypeDiagnostic: DM5PR12MB1451:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB145178410C4DA5D652E5B8A3F30F0@DM5PR12MB1451.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /xdo+jtWuSrUk+fPn6Q2jeY38ioNYlYky1WqeeODnAYuYxzNNkdQQ/1CrhSUucrIAIr2CCt4WQEpV9fWa6mspYN9kQ+m5vr01RtwW+AbRTNTdWKhpSkrsniDgeZHTzKIDXSk5I+yf9KTDQOWS/tEeWb4TMqW2nTvBbXHeZOWdW+cfPNn/vtdpP98tjJwUzNlNrFN9xWhybAK+lcgFlrs/dAciqrPqTlLf3KR1S7WIpB56x07uJ5GqP4f66lPfDL1rx4Qrek+2927LGgO8rw2GMuayHT4F+RfKXICHiGgxvolalC13/ar5XeAPZuZs75ratR5BgpW/VkfcC2n8jQ5Ew==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1163.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(346002)(376002)(136003)(366004)(39850400004)(2616005)(956004)(6486002)(316002)(66946007)(66476007)(66556008)(6666004)(478600001)(44832011)(1076003)(5660300002)(86362001)(8936002)(7696005)(52116002)(2906002)(36756003)(16526019)(26005)(186003)(4326008)(8676002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: cH3dOujC/laRVc3A1VWTP6j2wpP7EP+QuJ4ryhgQ/q526YFy6BNgDff/n3gYLrfGaaXkqLhqJkFk4OSVaB2EZL2VO2udzcJCcXRwU8yUVxmY0ne9zwAIsM3Gf1WNHz4SpXpmd5CpYF70thcmCNPu2ZpqURudNxKg7Y4tq2ZisY2GDKt6owA2finccSbS3yu6uSU4ncfO9ySPtN7IRpWoQBax9L9QZutFZhmq29/sc1qEdrfax1oBND5jFNiJcBxS46hazfbBxO+CJTR9yp+OUzHeQpnuSq1RRdI5zu9ZQ7vOLWSu8EtF99Nj7lhYbi8po2OwxZaG5ymrGM2Atm4c4VnENlMuQgpphll5xjiwRfMVshl9mIZCMGE8tjGFKxV93ZrcoM2KyxjG+jtCoYJ9gfcAd9DCBvLHBtKnuxHNo0yUeBp+ObEwnuTJvhmC+lyVTSQNqdVnrC6q4kLMX0nMeDq/vsFNLrt5xHoFt2tE+m+ikui0+8giGiC6Kos/hRbRnsFGuD7ePuBQD+jdwsr8gQB3bss2jyRAtrW1Xoy+Nz8kE+od7niCLYXWj69YKRJ13iO8jtIHM1yYRBn6OBDPBZA0vwqMuW0hmcO4adFsmg8SLyNgtshaCl2eARtypHN5ESIDiTYBdMwrfKzUJM8MgQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ca58a61-bada-4fd4-b574-08d86806b3d5
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1163.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2020 01:42:07.0754 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2qabKNKNE+iE4QCBG03KziizZeduHiooPfEU8p/Osm9FsIbtyS4jy90cHe27FS8XNb60N6wM99lEF7NH3sKFzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1451
Cc: robin.murphy@arm.com
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

Switch to using IO page table framework for AMD IOMMU v1 page table.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/iommu.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 77f44b927ae7..6f8316206fb8 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -32,6 +32,7 @@
 #include <linux/irqdomain.h>
 #include <linux/percpu.h>
 #include <linux/iova.h>
+#include <linux/io-pgtable.h>
 #include <asm/irq_remapping.h>
 #include <asm/io_apic.h>
 #include <asm/apic.h>
@@ -1573,6 +1574,22 @@ static int pdev_iommuv2_enable(struct pci_dev *pdev)
 	return ret;
 }
 
+struct io_pgtable_ops *
+amd_iommu_setup_io_pgtable_ops(struct iommu_dev_data *dev_data,
+			       struct protection_domain *domain)
+{
+	struct amd_iommu *iommu = amd_iommu_rlookup_table[dev_data->devid];
+
+	domain->iop.pgtbl_cfg = (struct io_pgtable_cfg) {
+		.pgsize_bitmap	= AMD_IOMMU_PGSIZES,
+		.ias		= IOMMU_IN_ADDR_BIT_SIZE,
+		.oas		= IOMMU_OUT_ADDR_BIT_SIZE,
+		.iommu_dev	= &iommu->dev->dev,
+	};
+
+	return alloc_io_pgtable_ops(AMD_IOMMU_V1, &domain->iop.pgtbl_cfg, domain);
+}
+
 /*
  * If a device is not yet associated with a domain, this function makes the
  * device visible in the domain
@@ -1580,6 +1597,7 @@ static int pdev_iommuv2_enable(struct pci_dev *pdev)
 static int attach_device(struct device *dev,
 			 struct protection_domain *domain)
 {
+	struct io_pgtable_ops *pgtbl_ops;
 	struct iommu_dev_data *dev_data;
 	struct pci_dev *pdev;
 	unsigned long flags;
@@ -1623,6 +1641,12 @@ static int attach_device(struct device *dev,
 skip_ats_check:
 	ret = 0;
 
+	pgtbl_ops = amd_iommu_setup_io_pgtable_ops(dev_data, domain);
+	if (!pgtbl_ops) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
 	do_attach(dev_data, domain);
 
 	/*
@@ -1958,6 +1982,8 @@ static void amd_iommu_domain_free(struct iommu_domain *dom)
 	if (domain->dev_cnt > 0)
 		cleanup_domain(domain);
 
+	free_io_pgtable_ops(&domain->iop.iop.ops);
+
 	BUG_ON(domain->dev_cnt != 0);
 
 	if (!dom)
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
