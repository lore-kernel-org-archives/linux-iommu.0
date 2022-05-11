Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2A2AC433EF
	for <iommu@archiver.kernel.org>; Wed, 11 May 2022 07:31:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6490E4188B;
	Wed, 11 May 2022 07:31:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cFIFAcHlQ6NF; Wed, 11 May 2022 07:31:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 086754188E;
	Wed, 11 May 2022 07:31:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C1AFAC0039;
	Wed, 11 May 2022 07:31:08 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 18058C002D
 for <iommu@lists.linux-foundation.org>; Wed, 11 May 2022 07:31:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E2B6940B68
 for <iommu@lists.linux-foundation.org>; Wed, 11 May 2022 07:31:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=amd.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CpswuyBlqIbb for <iommu@lists.linux-foundation.org>;
 Wed, 11 May 2022 07:31:07 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2062f.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7ea9::62f])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1560140B65
 for <iommu@lists.linux-foundation.org>; Wed, 11 May 2022 07:31:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HLVvg1mBRGE20N+y249rU5ZWONLUGw6u2ulMt7XwZQzZPOf70sB4DOC6iO8b/o1aPkJopAV5lO3T/kLTkkHWDIqzeuHQRlnVfaPw3uYFsKKqZOX2kvVO6nm/YA/PFXy9wN0QabS1MYs9hfdjJHEBTyX5akxDZnzWszBRVFbRwQc+rAGrrwtfoLIm2qm2EfGzyoxkiZx7eQz3ZR0HVTq/xVku09A7sMNHCXmlT+fPVO0vlQNpboTrlMmA2TO7Wsvg+E4Uu25OuKJcv16PynDIf2Vn6JDry7KBYOWVpg1Cy7ztWFsqzYPk5UmdM2PvBhGvIFnbpV8xz9xkQ+rBHabaWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vD0QWYvnhN/ksQ5dde6TAuJzzSiWBNo9k5PNLTaP6hY=;
 b=QMdQjRueS6Pu+T31vg0xc73J0Fv+OQtRSCg5OQlBVtZEgTsAUpbfamsY5MeAHNI0c3/Y5T2j2rDfMN4ZO9woC6f+EojV9m6/06BCWhR3AQezo2mSZyisKbg+EFsjmdwxaUXJVrOYUgyDcj2A/x4olMu66YJrsNKs4qRrDgV1Z+KqNs/tqgN/fxXQvFA2sOF+fv/ShiYW/eWAs/p50CK+2uecDasrO2Par8WUDb0Cid9nyrA2TNsCalb9HBkYVeMIbCpGbWRPNzUbnE1RTUPMJNHmx2+XTeHmWL+L9GKbyl3QxfUaVTaOAqHwoJWq25C3RxlTYigDAe5pSUugoP/rZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux-foundation.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vD0QWYvnhN/ksQ5dde6TAuJzzSiWBNo9k5PNLTaP6hY=;
 b=ifna7botkniRPhCbw9dRg7hxl5rVXlrXHr+/qTuTss9BIpHUpzh+CVbzsP494R1AkXUcyfC7gF8fcnK7TGNeoup8lub5JBOTGrNb2tM/DusxPjYchAjDDakbbzQEpURrXiwGU3xLy/flbSNOxAyamsQ8TMHqXMisYxCDHHytQCI=
Received: from DM6PR06CA0096.namprd06.prod.outlook.com (2603:10b6:5:336::29)
 by CH0PR12MB5043.namprd12.prod.outlook.com (2603:10b6:610:e2::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.20; Wed, 11 May
 2022 07:31:04 +0000
Received: from DM6NAM11FT016.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:336:cafe::2b) by DM6PR06CA0096.outlook.office365.com
 (2603:10b6:5:336::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.23 via Frontend
 Transport; Wed, 11 May 2022 07:31:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT016.mail.protection.outlook.com (10.13.173.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5250.13 via Frontend Transport; Wed, 11 May 2022 07:31:04 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 11 May
 2022 02:31:02 -0500
To: <iommu@lists.linux-foundation.org>
Subject: [PATCH v3 35/35] iommu/amd: Update amd_iommu_fault structure to
 include PCI seg ID
Date: Wed, 11 May 2022 12:51:41 +0530
Message-ID: <20220511072141.15485-36-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220511072141.15485-1-vasant.hegde@amd.com>
References: <20220511072141.15485-1-vasant.hegde@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 40b48c6e-697c-472e-3af5-08da33203509
X-MS-TrafficTypeDiagnostic: CH0PR12MB5043:EE_
X-Microsoft-Antispam-PRVS: <CH0PR12MB5043F8EA57936EA1C8D6C69B87C89@CH0PR12MB5043.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OD040xBp29lJ98x9sovdWXI7AC0F06jFXZBzKMRFOtHpH7ySlGxH2CVtavVgNgfTgsRNHfzEY8A8OMRiTd1orrQa66am9LOIOUV5LwbAmXKJSI/Nh2bCO1bS1zY309QIJBKkkhpqIVHZgADOdOxpOUZvinZd4x8ilO6ZIa21YCekNgDQChSOJzETsGqZvDwIkDcDwQglnufYECTKA7midnUE/SGAfVZi3bySG1/r7K86s1PHYSg2kgxckgy53btgbZpxzIDeqPHyRs+08w/I9O191xLNXxGMPjWvGfMIN+EfPZ6JjHdm86IrUOk4JlUzreVNAdhR0c+d4A0znVcm46FVeWZQ7Pav3eXnF/LS+wajtnO1CguI/ffqFHUzgBfDc4wAnAn+pNA1go4BEpiq4Hurlz1aYfprkEIk/aCyxeXccQe8SZ/MuRZeMCSFGM+ruLgHXbdIH872Fl2rQnjLTTQ3YKMIn95V696Uhi2Lww+vMkF2irmkEDnK6HFZ0rnrLCB4nNSwTOEIbXe33jUuhjhD3fteWznmCxVF5wkwiH1inIzJL3v34DrEHETqo/iPWvQU6DslKel+xMl/a10cBQXrMNtufQpHFP5jc3eXe2kKP2bwAOQN2DZSX5dMT3FjNQVT3Hgh68qw6uj+QNygLTSETJhZMZ9s6tAEWm8EaJfycd/0hO+XWyOkhwOsiVELCSygKxQnVCtX8tTTrlkjTA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(8676002)(4326008)(44832011)(5660300002)(508600001)(8936002)(70206006)(86362001)(26005)(40460700003)(36860700001)(2616005)(47076005)(186003)(336012)(16526019)(426003)(7696005)(83380400001)(1076003)(356005)(6666004)(2906002)(81166007)(82310400005)(36756003)(6916009)(54906003)(316002)(70586007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2022 07:31:04.7176 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 40b48c6e-697c-472e-3af5-08da33203509
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT016.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5043
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

Rename 'device_id' as 'sbdf' and extend it to 32bit so that we can
pass PCI segment ID to ppr_notifier(). Also pass PCI segment ID to
pci_get_domain_bus_and_slot() instead of default value.

Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/amd_iommu_types.h | 2 +-
 drivers/iommu/amd/iommu.c           | 2 +-
 drivers/iommu/amd/iommu_v2.c        | 9 +++++----
 3 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 7cf6bc353028..328572cf6fa5 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -482,7 +482,7 @@ extern struct kmem_cache *amd_iommu_irq_cache;
 struct amd_iommu_fault {
 	u64 address;    /* IO virtual address of the fault*/
 	u32 pasid;      /* Address space identifier */
-	u16 device_id;  /* Originating PCI device id */
+	u32 sbdf;	/* Originating PCI device id */
 	u16 tag;        /* PPR tag */
 	u16 flags;      /* Fault flags */
 
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 6320f2f97d88..c95c09c56b37 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -701,7 +701,7 @@ static void iommu_handle_ppr_entry(struct amd_iommu *iommu, u64 *raw)
 
 	fault.address   = raw[1];
 	fault.pasid     = PPR_PASID(raw[0]);
-	fault.device_id = PPR_DEVID(raw[0]);
+	fault.sbdf      = PCI_SEG_DEVID_TO_SBDF(iommu->pci_seg->id, PPR_DEVID(raw[0]));
 	fault.tag       = PPR_TAG(raw[0]);
 	fault.flags     = PPR_FLAGS(raw[0]);
 
diff --git a/drivers/iommu/amd/iommu_v2.c b/drivers/iommu/amd/iommu_v2.c
index b186d33336e0..28fecc6d0e53 100644
--- a/drivers/iommu/amd/iommu_v2.c
+++ b/drivers/iommu/amd/iommu_v2.c
@@ -518,15 +518,16 @@ static int ppr_notifier(struct notifier_block *nb, unsigned long e, void *data)
 	unsigned long flags;
 	struct fault *fault;
 	bool finish;
-	u16 tag, devid;
+	u16 tag, devid, seg_id;
 	int ret;
 
 	iommu_fault = data;
 	tag         = iommu_fault->tag & 0x1ff;
 	finish      = (iommu_fault->tag >> 9) & 1;
 
-	devid = iommu_fault->device_id;
-	pdev = pci_get_domain_bus_and_slot(0, PCI_BUS_NUM(devid),
+	seg_id = PCI_SBDF_TO_SEGID(iommu_fault->sbdf);
+	devid = PCI_SBDF_TO_DEVID(iommu_fault->sbdf);
+	pdev = pci_get_domain_bus_and_slot(seg_id, PCI_BUS_NUM(devid),
 					   devid & 0xff);
 	if (!pdev)
 		return -ENODEV;
@@ -540,7 +541,7 @@ static int ppr_notifier(struct notifier_block *nb, unsigned long e, void *data)
 		goto out;
 	}
 
-	dev_state = get_device_state(iommu_fault->device_id);
+	dev_state = get_device_state(iommu_fault->sbdf);
 	if (dev_state == NULL)
 		goto out;
 
-- 
2.27.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
