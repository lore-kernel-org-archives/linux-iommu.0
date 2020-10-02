Return-Path: <SRS0=Fz8+=DJ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21BB7C4727D
	for <iommu@archiver.kernel.org>; Fri,  2 Oct 2020 12:25:09 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C19692074B
	for <iommu@archiver.kernel.org>; Fri,  2 Oct 2020 12:25:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="W6LN9lq3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C19692074B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 9935886B92;
	Fri,  2 Oct 2020 12:25:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id icBPLOGXGbDZ; Fri,  2 Oct 2020 12:25:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 0A83886B1C;
	Fri,  2 Oct 2020 12:25:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id ECCA4C016F;
	Fri,  2 Oct 2020 12:25:07 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 746E7C016F
 for <iommu@lists.linux-foundation.org>; Fri,  2 Oct 2020 12:25:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 5F5EC86B92
 for <iommu@lists.linux-foundation.org>; Fri,  2 Oct 2020 12:25:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nWtUnOs0QGrf for <iommu@lists.linux-foundation.org>;
 Fri,  2 Oct 2020 12:25:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2074.outbound.protection.outlook.com [40.107.237.74])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 8B29986B78
 for <iommu@lists.linux-foundation.org>; Fri,  2 Oct 2020 12:25:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QaPknLQUjp6UUD75vjvz8fB/D4ARHYCsnsiPvG+3Nsg6Z8creLakbHwOrtesFldvGyksKPXwBaa0R2LuaCeUtaboOR5vUfzw677EM9VdpIp892lbuGxKdydEARZdu8/xJX+E1IHMBMzvDMPzKNtKGdZshiJPMPkEkmcUd1hrtuvYPFCv1bpbDTernMsQetyKyVlk3lRA4dHieA9jrW8SS/EOIsF+J2HAX8tW2U2+/6VYfrkZv7WZBqAEXBIJ5wqJjCD43i/0H5BzZzkgH9JXW0fk5XhHjaQ2xNbdkJUCm7nC3NsFsB6ocdtAVRPFigsSBi7TX+LXPKqbxvtUwVW9HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FBQRNJyQeudBg6GC7C1z6IFec5ntE4wUwJoEyhyQ8JI=;
 b=U4laZW5VJoxov1xaP1Iai/nyNCjCKaZBzzAl86PuYPzm42dAXX7Nd/bew1Z5iMUh76RGl01ZIfGm4g+qvrDkt1083SwYxk52mklzxqBJYpdzqofzJ1WCnTv/VZR69WXaunhpGMydWtNhFHV9a10ZYIuXNb+6JDlkiNBUO5URPCSI6FhDedh6rktKwS6gjKRX9ldi1hSB65nRlooj7UDlknn9xqZBqYblCN+V9apiy96VpKMvKpqm05tAyAYUsL5U4/3QJ9kEVFfMc4DRNF0+51qos2V8er+m5hAe/Xh87h8lcfviEjK21K51pOFCDiCzRvT27fA3DD/PJHGf1+OFQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FBQRNJyQeudBg6GC7C1z6IFec5ntE4wUwJoEyhyQ8JI=;
 b=W6LN9lq3Bo5GVvkbiKpbjw0FSti6prOUhp5MERzOD8pWOF1YAWYb1w5j2YRIe0Eh657kL6FRDOWhTws60rPWY/aDx32KN23EOD+hVT/zr9U0DpYBQXzouzNur3QLffsHvUU7452kPRCvWvNxgBlg2lLzWiPNnER9pHP91qF6ViE=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1163.namprd12.prod.outlook.com (2603:10b6:3:7a::18) by
 DM5PR12MB1163.namprd12.prod.outlook.com (2603:10b6:3:7a::18) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3433.32; Fri, 2 Oct 2020 12:25:01 +0000
Received: from DM5PR12MB1163.namprd12.prod.outlook.com
 ([fe80::48cf:d69:d457:1b1e]) by DM5PR12MB1163.namprd12.prod.outlook.com
 ([fe80::48cf:d69:d457:1b1e%5]) with mapi id 15.20.3433.039; Fri, 2 Oct 2020
 12:25:01 +0000
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: linux-kernel@vger.kernel.org,
	iommu@lists.linux-foundation.org
Subject: [PATCH v2 13/13] iommu/amd: Adopt IO page table framework
Date: Fri,  2 Oct 2020 12:28:30 +0000
Message-Id: <20201002122830.4051-14-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201002122830.4051-1-suravee.suthikulpanit@amd.com>
References: <20201002122830.4051-1-suravee.suthikulpanit@amd.com>
X-Originating-IP: [165.204.78.2]
X-ClientProxiedBy: SN6PR05CA0010.namprd05.prod.outlook.com
 (2603:10b6:805:de::23) To DM5PR12MB1163.namprd12.prod.outlook.com
 (2603:10b6:3:7a::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ethanolx5673host.amd.com (165.204.78.2) by
 SN6PR05CA0010.namprd05.prod.outlook.com (2603:10b6:805:de::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3455.13 via Frontend Transport; Fri, 2 Oct 2020 12:25:00 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2033f1b7-768b-43a2-ec22-08d866ce2ef4
X-MS-TrafficTypeDiagnostic: DM5PR12MB1163:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB11632D3E6475B92F1B6A41E0F3310@DM5PR12MB1163.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9Hae6Pf+02K5N46x+fe/AByyp0MwXVwFtW95YDKSFpHzPu3H18vEuNjfdAX1vCda5p8JgBU0E2hAqRF4NACCGSXIYka5qZD9L+5mPA+LSmoyHHquf2p8+3qHv8eOQgENdHKEnYzyf4PjUUuFRhVYijwhIlJLhiyUgy5IurYBj8dPbQn77eJXTFz4413JUIKuhHg/Q91sJArES63DZt1VTc3zXfGQSjxo2qNEp0vKY5Aj5C/w2NsmrkVJYTXuV6+HbBJ/ThtB0itQpVt0sB2zuCuU5zpBmCeIQLdKABwNzG2/XXiuFR3a3u1rP2GMg53T8hhMv8C6YyVf67OtgY7meQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1163.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(39860400002)(396003)(346002)(376002)(66556008)(52116002)(66946007)(66476007)(7696005)(5660300002)(8936002)(4326008)(6666004)(1076003)(26005)(6486002)(16526019)(186003)(44832011)(316002)(2616005)(36756003)(956004)(478600001)(8676002)(2906002)(86362001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: /iTD7S22KKTN83TqGRWoA6beNML4suRwlDk3EIihNZYdmp7Il0oBKb2zgLl4flWcCosrvlmQnOtbWPy4sWGyvklVmVomc35yJeEa7DEgd3TItDOBcwzQG0u2ROwWpGuKqrPHBlcV3bfK+qz5Sk/YJE8O3/T83JV9Ox1CEWuEqToc0XC0Zi+A5K8atbCjmaqxeZGKNE+9asWH8cIASgJpcN5p/3VBCrYHQwgYnLgkS80952HsATs1tKwrXQqv1vkkd/1nzcsVIBt+OpiWJh9yTDOA0b/VM8ZowYAVB9x1LmTLrukQ7InqopQiAgcAaOPl+6lZpik7o2MlrqiJ5ObrmyoYDnnu9EV8tFpk41z2Cr4N8PFmWahuxnlmRQb4RduLHsh6AxHoqp9zIpmZ2/VXo33aT13AYoGctqk8Nyx1YvyFmgp1yMOOZUgagHhQeZfw4QohuuCAi9eMXO7SiWtGMK7oANyiKWkTfWQZcfclUCI2XlWILJuUEY4IXQ1d8720ST/vk8t92foqzC3G9083eeAuAMBKVP4/6t5k6ucCbx/EZ3vymY0j5eRIFhcsxTLvkUsdHYny4EEmjggjSXu8uqFL3awj4zcFZfrpQ5D0c3sZwcAu+Qpqd3JzRsl4vMB/wjRGQDIUrjV1OK0lLR4WiQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2033f1b7-768b-43a2-ec22-08d866ce2ef4
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1163.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2020 12:25:01.2113 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DAZds+SFXBxbaqjn7ffxZBHWXkJpibGZPiYrRwqqaUE+AaLidD84gvGYUipTV9Kf0yg06m6Px3D1M3fslsOdHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1163
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
 drivers/iommu/amd/iommu.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 77f44b927ae7..c28949be3442 100644
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
@@ -1573,6 +1574,20 @@ static int pdev_iommuv2_enable(struct pci_dev *pdev)
 	return ret;
 }
 
+struct io_pgtable_ops *
+amd_iommu_setup_io_pgtable_ops(struct iommu_dev_data *dev_data,
+			       struct protection_domain *domain)
+{
+	domain->iop.pgtbl_cfg = (struct io_pgtable_cfg) {
+		.pgsize_bitmap	= AMD_IOMMU_PGSIZES,
+		.ias		= IOMMU_IN_ADDR_BIT_SIZE,
+		.oas		= IOMMU_OUT_ADDR_BIT_SIZE,
+		.iommu_dev	= &dev_data->pdev->dev,
+	};
+
+	return alloc_io_pgtable_ops(AMD_IOMMU_V1, &domain->iop.pgtbl_cfg, domain);
+}
+
 /*
  * If a device is not yet associated with a domain, this function makes the
  * device visible in the domain
@@ -1580,6 +1595,7 @@ static int pdev_iommuv2_enable(struct pci_dev *pdev)
 static int attach_device(struct device *dev,
 			 struct protection_domain *domain)
 {
+	struct io_pgtable_ops *pgtbl_ops;
 	struct iommu_dev_data *dev_data;
 	struct pci_dev *pdev;
 	unsigned long flags;
@@ -1623,6 +1639,12 @@ static int attach_device(struct device *dev,
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
@@ -1958,6 +1980,8 @@ static void amd_iommu_domain_free(struct iommu_domain *dom)
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
