Return-Path: <SRS0=5N08=DA=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 896DBC4727F
	for <iommu@archiver.kernel.org>; Wed, 23 Sep 2020 10:12:00 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 303812145D
	for <iommu@archiver.kernel.org>; Wed, 23 Sep 2020 10:12:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="tZJhg8qu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 303812145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id EA53186F71;
	Wed, 23 Sep 2020 10:11:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DujIQ6wChFj7; Wed, 23 Sep 2020 10:11:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 78E7286EB1;
	Wed, 23 Sep 2020 10:11:59 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 590E5C0859;
	Wed, 23 Sep 2020 10:11:59 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 29692C0051
 for <iommu@lists.linux-foundation.org>; Wed, 23 Sep 2020 10:11:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 2181C86EB1
 for <iommu@lists.linux-foundation.org>; Wed, 23 Sep 2020 10:11:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mMy+HvwDKCdK for <iommu@lists.linux-foundation.org>;
 Wed, 23 Sep 2020 10:11:55 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2054.outbound.protection.outlook.com [40.107.237.54])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 85C5586BE2
 for <iommu@lists.linux-foundation.org>; Wed, 23 Sep 2020 10:11:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gSCkt8qzOB5vSHKTOqkMUhChspSFhxlXmWxIcx+kTx+SaKwbSgqK7bDGvZWMIeZtB2s5dXUrFagGe8vNgEO7Mf08kaIo/UGMmFmKe7Z069TfbrlkoN/sOftHeT32AqXUGUrogKgJSDuNb7aRNHIebDMGFEzzlyvMNR46NLiLKvytCgk72gvTruVxjZpBkJ9ITVVzXxdxDdTlBvUb/ltONaNWvI3sNGHgiWQe9OoAN2kGh8txDPeMX1LH+jKKbjljdE6FMbj9FVj5iMT5Da4ICZ4gs0lK46QWCstz7gavJzMgJxubZ57Bj4yrIjB43BqTAJcEA5lOKb2KKgb0CXGJSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g3RLf7vkzqmj8xhjVfDs2PGkjZENcM+ralpFLJL6f0g=;
 b=hBPuBJ5L4B0hvoL+76DR+fB4vXDK756zZkkAnLiJ5U5usPlcKUn3aPKc7EOx2yH/6EzMu4AeSjiXQc5Dy/JiUTvEfYzgvc8qzE24L8MN6fmtqJGzQLKwJaZzVQBW35iXm+eaa4/AgEAXlmJ7mN8BTRpUWLX58OauaW8QVxNAtK4XReuH8WKvTo8BqZDPwH3HFBegu9WJ7lf9e9jKptYDvJw/Tf2FYmhlIjOrRbAmQIdqcyAnypIjA/Wc5Hhb7FHChpitxfZ4esEuDZvXURpNiBM+6XA/YUYTCp8TObvTLZbmETmiDFmTQ75wkrfaBzI4aKq1VtOy0UX0tpfxKLAADg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g3RLf7vkzqmj8xhjVfDs2PGkjZENcM+ralpFLJL6f0g=;
 b=tZJhg8quARfipucuOk3mV6wNk8SN6d1j6hZ6KM/CqxI4fV5e2sPtbisVuCJJU7UHXJFsOmW7VUGqzT3In4PCKeb4Sf+mfLf4CX7Ah+E3y+cBEv9lMwWoHvmG6MNrWDTsInI1Pny7tgaDU1FXLU3sDkeHe+2EFlMwYk4HD/+TAtU=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1163.namprd12.prod.outlook.com (2603:10b6:3:7a::18) by
 DM6PR12MB3466.namprd12.prod.outlook.com (2603:10b6:5:3b::33) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3391.11; Wed, 23 Sep 2020 10:11:53 +0000
Received: from DM5PR12MB1163.namprd12.prod.outlook.com
 ([fe80::48cf:d69:d457:1b1e]) by DM5PR12MB1163.namprd12.prod.outlook.com
 ([fe80::48cf:d69:d457:1b1e%5]) with mapi id 15.20.3412.022; Wed, 23 Sep 2020
 10:11:53 +0000
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: linux-kernel@vger.kernel.org,
	iommu@lists.linux-foundation.org
Subject: [PATCH 13/13] iommu: amd: Adopt IO page table framework
Date: Wed, 23 Sep 2020 10:14:42 +0000
Message-Id: <20200923101442.73157-14-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200923101442.73157-1-suravee.suthikulpanit@amd.com>
References: <20200923101442.73157-1-suravee.suthikulpanit@amd.com>
X-Originating-IP: [165.204.78.2]
X-ClientProxiedBy: SN4PR0601CA0003.namprd06.prod.outlook.com
 (2603:10b6:803:2f::13) To DM5PR12MB1163.namprd12.prod.outlook.com
 (2603:10b6:3:7a::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ethanolx5673host.amd.com (165.204.78.2) by
 SN4PR0601CA0003.namprd06.prod.outlook.com (2603:10b6:803:2f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20 via Frontend
 Transport; Wed, 23 Sep 2020 10:11:52 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 23dd60a9-bb0e-4671-23b5-08d85fa91835
X-MS-TrafficTypeDiagnostic: DM6PR12MB3466:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB34667A5D874DEC72F144AD35F3380@DM6PR12MB3466.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Y+FRuyOwW8n9m0ExfDgBa7l1O9FZ2HFyHrNCIGvC5rRzJVvSX/1cM4/vedPTd5+q4Zwnk2BP3M2yHLsT6Dfv0YTRzc6Zvhzq0kL/oGSnY2gtFmm4rFGOXC5Z/4baA3ykCh1Y9Duelg7m2+lxfg31kk/9zqQaBGbeM0Ll64AUdiaAe54/CtWEnEvqFTsMKzhFj/4TN/jrlyTOY8pBan8/S/kBOpVny/dLYlMYub06MNXDfQhVYAXruAYVDKuZuSpzQhbUYlSjPEPHmhBvb924qN/jY/GMvWd/wy2Mg6tiQXU2oQ4ceNRvzUe4a/0e1jE1dzRSRDWtyjZNUmdaCZv87g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1163.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(366004)(376002)(346002)(396003)(44832011)(5660300002)(66946007)(66476007)(66556008)(6486002)(86362001)(36756003)(2906002)(8936002)(4326008)(26005)(316002)(1076003)(956004)(478600001)(6666004)(186003)(16526019)(52116002)(8676002)(2616005)(7696005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: PzmOGM0othNEFV70MFsfVEejgWa2n0/Qk1EsoWIvq09AOAaAueo8jjA4dt1Be/izBiRNJKJ8bsy+VIfmhWNKsseCay6cE/7rbBgN57ehCRqDsv9opZ19hRFlfALNJz/yRwf2Pf36qHUp8GVULkxNMQglRxvMZRFPX75GU6JzVNFDqQdrsPlCNC70Tezd2HJKm1mP3oIJM7+HsdnU22FB6X3ZWttlCZMZ1ndgpoI7DdoA7K9DlgTTz6oFNMmrfFOPhzXwrZN9hix/qJLz2nY/A/FZHKqP61ngk2oSzv6eRo84ViGYJqClLYPXnawJIg0X9zMvZ903wODZMxeAz4gPBeG4v+fJCHV4dHGmilkUG2Ua93PuWqZFMz+P67k8K1xRvas5L9T0hIsETAALgOEiJiT+RNHKpKPNR0T+jir3CdMdAT4btk/IfKtcA6kNZLT/CekXhL8Gbz2LN9Ma/CD1ZEBppaKK+EDjqe9Qfx4BUz27hH3JVb/XQvvrzWYTvKvlRMOwpE4WquUehkQt/rzkoEx2FTa2tRkEYFgMKRNmQq5nRb7S8tOoZn/bZLjRjXsqgAJKMT0x5w30GhAW/9ejhxlvdDuLWxpwdqh2ZIuJZpf6t066Z4iEMdCbdNmCIwtdtWGTtCkrXxChShJDHSD1uQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23dd60a9-bb0e-4671-23b5-08d85fa91835
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1163.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2020 10:11:53.5531 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dp/tlIQJEa0tQwUtm4xKvNWFgAdge6WKZUdDs4lKExAxHe23HOfqs/iQ4rBn+J4ipawaH5wBV+3EVDEOX6LqyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3466
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
 drivers/iommu/amd/amd_iommu.h |  3 +++
 drivers/iommu/amd/iommu.c     | 10 ++++++++++
 2 files changed, 13 insertions(+)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index 2e8dc2a1ec0f..046ea81a3b77 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -127,4 +127,7 @@ static inline void amd_iommu_apply_ivrs_quirks(void) { }
 extern void amd_iommu_domain_set_pgtable(struct protection_domain *domain,
 					 u64 *root, int mode);
 extern void amd_iommu_free_pgtable(struct amd_io_pgtable *pgtable);
+extern struct io_pgtable_ops *
+amd_iommu_setup_io_pgtable_ops(struct iommu_dev_data *dev_data,
+			       struct protection_domain *pdom);
 #endif
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 77f44b927ae7..df304d8a630a 100644
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
@@ -1580,6 +1581,7 @@ static int pdev_iommuv2_enable(struct pci_dev *pdev)
 static int attach_device(struct device *dev,
 			 struct protection_domain *domain)
 {
+	struct io_pgtable_ops *pgtbl_ops;
 	struct iommu_dev_data *dev_data;
 	struct pci_dev *pdev;
 	unsigned long flags;
@@ -1623,6 +1625,12 @@ static int attach_device(struct device *dev,
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
@@ -1958,6 +1966,8 @@ static void amd_iommu_domain_free(struct iommu_domain *dom)
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
