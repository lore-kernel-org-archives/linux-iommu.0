Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53919C433FE
	for <iommu@archiver.kernel.org>; Fri, 11 Mar 2022 09:58:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 0B375404C9;
	Fri, 11 Mar 2022 09:58:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HN7cfIgPzxrt; Fri, 11 Mar 2022 09:58:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 9AB3F40A50;
	Fri, 11 Mar 2022 09:58:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 574E0C0083;
	Fri, 11 Mar 2022 09:58:11 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2CC70C0073
 for <iommu@lists.linux-foundation.org>; Fri, 11 Mar 2022 09:58:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C28E784755
 for <iommu@lists.linux-foundation.org>; Fri, 11 Mar 2022 09:58:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=amd.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4FjD-YJkaClN for <iommu@lists.linux-foundation.org>;
 Fri, 11 Mar 2022 09:58:09 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on20612.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eb2::612])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0C97D84732
 for <iommu@lists.linux-foundation.org>; Fri, 11 Mar 2022 09:58:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YsCc9cF3xhDkYtWsvfedQ3oTu+DwUCgYpiJvHDIjpxOX6HqYYtbu75DZOFElK7NaqnJkx8JVzQvVdF/YlImJF3DxP1L4guE9vuz4jarJqtgXu6Kg+TKz9p0X301Lh8P27SqBWQgBCiCoaPv9gvrc/qoowVPGpO+CCOUwD5PzoeyAhR6KQOoDpBEUgcV8ZzyrUsW14NJCW/opkZmS29h3Y/5xbBOebJlmaehvtB7rLUzeeBIYtDnQ0yecQ+ETEEJobEY9BIZr7Q6d/T9DuDvkDrhH4n88J2N6/zkN7hxGPn7JNxpDHq89dObcPppGGw3DykTlkl613vlNcV2uAVXpyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c53eKkCt8J0MBhSXCGk21tUlMWCnC/f+3ZTvwrH6TQg=;
 b=dgcE1S7eIUq9XpUJPoszp9Pa9HD2h2CUCsKT1WfNXdmRwmF1kX3PfWl5TfGFVEkJE14NdvgGXkeHIP7U3DvSJtEWR5OJBsuxnTwyblb9OwxeWoPEvvsW7mz/Zckw0YjFIUUr1sjivnfXR+/5M5IjwBTtSbAO7hiejLs/f3yJZl8J/l2utbGyHJR8B30wuQkqBeUJarb23ol9CCZD69AzFlUxCCfSW8uJQKluaFvxAL8NUd3c2aM9Z7oBUrs5lAqJRwoDvmuumSQYegefS4k1Frgov8Mrvp6PYh0/l7DAlDAdnw405GXhtEZRevEO6U20r8pEtLFJjC3kbToaMlS8/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux-foundation.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c53eKkCt8J0MBhSXCGk21tUlMWCnC/f+3ZTvwrH6TQg=;
 b=UmfdSImhGGTdxF6zJm0VMJDBv+ypOOx+WB7keoFWBUaqH/hQn2T7HYybgJg/DxH6DODbkxSuBkkLoirLYcRTDTVHzPUihMLlUTYDzYdN+pmU0KNTdqGvQVJodDSqAkX0NeCnBls5VWPxUTiDLQr0I1hKEOpa1ideUVJBeK4WGbk=
Received: from DM6PR13CA0048.namprd13.prod.outlook.com (2603:10b6:5:134::25)
 by CY4PR12MB1368.namprd12.prod.outlook.com (2603:10b6:903:41::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.17; Fri, 11 Mar
 2022 09:58:04 +0000
Received: from DM6NAM11FT037.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:134:cafe::7c) by DM6PR13CA0048.outlook.office365.com
 (2603:10b6:5:134::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.10 via Frontend
 Transport; Fri, 11 Mar 2022 09:58:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT037.mail.protection.outlook.com (10.13.172.122) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5061.22 via Frontend Transport; Fri, 11 Mar 2022 09:58:03 +0000
Received: from kali.amdval.net (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 11 Mar
 2022 03:57:40 -0600
To: <iommu@lists.linux-foundation.org>, <joro@8bytes.org>
Subject: [RFC PATCH 21/36] iommu/amd: Update iommu_ignore_device
Date: Fri, 11 Mar 2022 15:18:39 +0530
Message-ID: <20220311094854.31595-22-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220311094854.31595-1-vasant.hegde@amd.com>
References: <20220311094854.31595-1-vasant.hegde@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f2aaf203-3167-437a-b8dd-08da0345a235
X-MS-TrafficTypeDiagnostic: CY4PR12MB1368:EE_
X-Microsoft-Antispam-PRVS: <CY4PR12MB1368F2ED9ABA4305FF1BB9BA870C9@CY4PR12MB1368.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dpB+Gm/X0krvipo/qHl4uvKD0ETU2NgfPdV4XI6EFiQ/0rEp9d3XXlXcVPDXXSjV5f+N6UCbkZmw3Z1TW5GCpNA2lXgXfnJBxEixbc9+UCPYw4NjZcW3veLk63wYKPOMdVTxkdtaTBZPD+12druGW/bfOmbAHEfbZMuWPt5Pdbn4qDAr5kd3yb8yaOQMNFqKAVjW/UOzCgy+hcuFsFMlAmoyu5GEwXqgyNKfom/CWDsU8se5WmSy7KnH+tN9KogdfXnaaoWQuIRGT/+p/C8PYYTWgJ5QVIIAworG4JNFwI2sanQ4ws9IVor7lYM3Ggph7hRzfcZ1KGP6ZcQlxIb/L1zE/DYMHMOfqwF09078/6qhVvAPoNielxyj630EF6lD6G63Vfjgd6wIVA7HgIXD1+P6mPe/GpOHkgYVXn9g4RNYIjFTGEDqBbhIFIGpWNlMbaFvhO5FsjI2inwp7lpXE9bVPtEHH89YUMEyQ1IUk6j5rw/M52imDYGmWa+f5HzSC8n/irrnVZfXVdcGnSeV3AMjsYb1OQZID/RAW+y1fDnfXnDbe5Aee3OZKpCCb7hgaG2C/4WMo/K/A82GUAh2mK/9fZe5hZqspEf1IaLOLduZTa5oFmikm7i9y/Ix3eIDRMaf8iULHKiiZkgkL/u+r+wvF8LWzvgA831KKF3U+nyh5nefbCB8iYILSqhsZdt5vCz34v/gy+Up6IvgBPp0ew==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(40460700003)(508600001)(86362001)(82310400004)(4326008)(2616005)(26005)(1076003)(83380400001)(336012)(426003)(16526019)(47076005)(186003)(36756003)(5660300002)(44832011)(81166007)(70206006)(70586007)(8676002)(2906002)(110136005)(36860700001)(54906003)(316002)(356005)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2022 09:58:03.4309 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f2aaf203-3167-437a-b8dd-08da0345a235
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT037.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1368
Cc: Vasant Hegde <vasant.hegde@amd.com>
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
From: Vasant Hegde via iommu <iommu@lists.linux-foundation.org>
Reply-To: Vasant Hegde <vasant.hegde@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>

Start using per PCI segment device table instead of global
device table.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/iommu.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index c467ecc44548..be3eaa638420 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -411,15 +411,15 @@ static int iommu_init_device(struct amd_iommu *iommu, struct device *dev)
 static void iommu_ignore_device(struct amd_iommu *iommu, struct device *dev)
 {
 	struct amd_iommu_pci_seg *pci_seg = iommu->pci_seg;
+	struct dev_table_entry *dev_table = get_dev_table(iommu);
 	int devid;
 
-	devid = get_device_id(dev);
+	devid = (get_device_id(dev)) & 0xffff;
 	if (devid < 0)
 		return;
 
-
 	pci_seg->rlookup_table[devid] = NULL;
-	memset(&amd_iommu_dev_table[devid], 0, sizeof(struct dev_table_entry));
+	memset(&dev_table[devid], 0, sizeof(struct dev_table_entry));
 
 	setup_aliases(iommu, dev);
 }
-- 
2.27.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
