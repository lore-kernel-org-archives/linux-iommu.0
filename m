Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CF54C433EF
	for <iommu@archiver.kernel.org>; Fri, 11 Mar 2022 10:00:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 53423418FD;
	Fri, 11 Mar 2022 10:00:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id u7ruIzOVweDL; Fri, 11 Mar 2022 10:00:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id E60C94099B;
	Fri, 11 Mar 2022 10:00:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CE160C0012;
	Fri, 11 Mar 2022 10:00:39 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 153DDC000B
 for <iommu@lists.linux-foundation.org>; Fri, 11 Mar 2022 10:00:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 036E66127F
 for <iommu@lists.linux-foundation.org>; Fri, 11 Mar 2022 10:00:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=amd.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XXbIsWBiMw4Z for <iommu@lists.linux-foundation.org>;
 Fri, 11 Mar 2022 10:00:38 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2060c.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5b::60c])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 26F7E6127C
 for <iommu@lists.linux-foundation.org>; Fri, 11 Mar 2022 10:00:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IUHH6afhGBlZko3GcCttcD4wcLPXouaGwD+X51JMoI4a/wj4XzPfjCah0Lte+AzPmcI9FdU0iF5Kgwv+IySPf0o6aWOSj0w55ZwmipDmbrNd8dikINKKohMft8AkuNH2K37hcCzrbsS0OD4Qs9/iGf/fZ1IuFsLHrByasiJQYmK/RjfvmQMu4EYu1PPtAT6n1gIgaPUhxe+RYT0kL87HVA/00H5pPiE314k0alx5Ay5IAm8YzNJtY815j4n+OidaucrthCXu8E8s3NRweRZHJIE4ScHgPERhSzuObqCvbnBP/iqUtklB8AwEWgIVUO2kImWsED43vKGlVJfoZ2p2GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5jVLTrGdsFErO/j9F1TUU/BNCglSgUgPxTVnQA8OcH0=;
 b=iQj6naFXdZRy92xTNSQJTyQLQyLW0cL0X77p3hnxlMQeGr8XEMwxre+6dr4SUsGWLZZKtPWTe1jcFNbogC1qzAjrGUpPLbjN7yvmgdeLozfNRKouiSpxiM7UGHuWpzyfRot1TNjgH/aGKjTdtPivnfI3Ces90S2DVoubp6m98zk9V3xb1GRxJWHGtFky9r7/rFp0FjLb8Vj9kTV3Q4wNLtODvcwJHSDsCheuy0m9yqg+SQ9KPx+BzS4LMw8j/vXkjIC0TFQ1Rc3vhFP8RLjb9EwPzx/gcyn3lhp80Xpl7MXNCmJ1Aso6Fo9YYD3WKGe9fRbovA4iFLfXcfRrGQKx7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux-foundation.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5jVLTrGdsFErO/j9F1TUU/BNCglSgUgPxTVnQA8OcH0=;
 b=0xOFE4tBbekIO8j/kkaG9ZaTUS9McT5AmSH61/q8WEdtJKc1MDtKcnF5bERJB33zgRdVR+WvkbzDOsL/+38iB5bJFsf11m+srfPytfrg1y+UVu4NYoa7w0S4sh5az/Rjm+pZXpGytCG5onWgwqNrMdI+iEkXQllJndIDPQ/Ab2M=
Received: from DM5PR06CA0056.namprd06.prod.outlook.com (2603:10b6:3:37::18) by
 DM6PR12MB3291.namprd12.prod.outlook.com (2603:10b6:5:186::32) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5038.17; Fri, 11 Mar 2022 10:00:36 +0000
Received: from DM6NAM11FT005.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:37:cafe::7d) by DM5PR06CA0056.outlook.office365.com
 (2603:10b6:3:37::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.21 via Frontend
 Transport; Fri, 11 Mar 2022 10:00:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT005.mail.protection.outlook.com (10.13.172.238) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5061.22 via Frontend Transport; Fri, 11 Mar 2022 10:00:35 +0000
Received: from kali.amdval.net (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 11 Mar
 2022 04:00:33 -0600
To: <iommu@lists.linux-foundation.org>, <joro@8bytes.org>
Subject: [RFC PATCH 32/36] iommu/amd: Specify PCI segment ID when getting pci
 device
Date: Fri, 11 Mar 2022 15:18:50 +0530
Message-ID: <20220311094854.31595-33-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220311094854.31595-1-vasant.hegde@amd.com>
References: <20220311094854.31595-1-vasant.hegde@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 125278c7-e0dc-4a00-e913-08da0345fcdb
X-MS-TrafficTypeDiagnostic: DM6PR12MB3291:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB3291143A8A14CC642777B1E5870C9@DM6PR12MB3291.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nzmFeezUgDums4bM3mi5AMrAKKKVRgiNqm11bgM11TIxwRAD75hc1Qr9dH7F/Qmx+dwPBrixtbWzDPi4iIBL2VtWr4nQ6/ksW5QKY2b7sdIQMHWfdX2Q/+GYIFI3qSZ5yVljUnWr3nZ5HaAThaupxrKIlSn4mLALIDzwBIM4ajFPXVIixOQlb+f4UZpK8Jl/6RonIyTLPV3hCwku/zzY+YlYIIcw1ifbQ0+a0CcVez1XW85E3/ZnExxG8l+1p/T4wIfMKyJ2HuhYueSIJX/3wAQKNOmZS1cdlfhmBm+EVBDEP/WpSy/oJunP6qsnSDrXYS23WUWSYv8i9HYhgQ8aDHcrw1O86frHRePmNo+G8JcLVjpvFzPIJOGQF2wS9WbXd9AHbUx4eB+YX3hNzDW2uHVFSIbH/+BXHmaL0Ol/dRkNqBCjreTDfJ+vBRAwtbHQeNk7U15QXY5KhWgNjP1/C42BNh/9+HN5FtU0UkA2MPifZuTNn7nQMAenIEZNgJTiZU1p9KtVph0Y3hfggCwIYThm4hR28Oj9uS/I7Ro7PyQgu14SmR8p0q+bpPF91hEBVxDxJICNle6S+yEojKpuLe2pYq5XqrR5rKBh2BBgKMYeiCbV3WFWIwPZczErIfaqqaHOekoyQAdk0/K8K55Bm8miWA5k0VXTMOLJL4pvaKLTh3uDEfwMsul5Ldec8gLeCF5za7PcLazrbZKeLECQzw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(44832011)(2906002)(47076005)(36860700001)(316002)(82310400004)(86362001)(40460700003)(54906003)(81166007)(356005)(110136005)(508600001)(4326008)(8676002)(70206006)(70586007)(36756003)(26005)(186003)(426003)(336012)(1076003)(2616005)(8936002)(16526019)(5660300002)(83380400001)(6666004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2022 10:00:35.5306 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 125278c7-e0dc-4a00-e913-08da0345fcdb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT005.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3291
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

Upcoming AMD systems can have multiple PCI segments. Hence pass PCI
segment ID to pci_get_domain_bus_and_slot() instead of '0'.

Co-developed-by: Vasant Hegde <vasant.hegde@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/init.c  |  6 ++++--
 drivers/iommu/amd/iommu.c | 19 ++++++++++---------
 2 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 4a9f424eb4b4..ccc0208d4b69 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -1961,7 +1961,8 @@ static int __init iommu_init_pci(struct amd_iommu *iommu)
 	int cap_ptr = iommu->cap_ptr;
 	int ret;
 
-	iommu->dev = pci_get_domain_bus_and_slot(0, PCI_BUS_NUM(iommu->devid),
+	iommu->dev = pci_get_domain_bus_and_slot(iommu->pci_seg->id,
+						 PCI_BUS_NUM(iommu->devid),
 						 iommu->devid & 0xff);
 	if (!iommu->dev)
 		return -ENODEV;
@@ -2024,7 +2025,8 @@ static int __init iommu_init_pci(struct amd_iommu *iommu)
 		int i, j;
 
 		iommu->root_pdev =
-			pci_get_domain_bus_and_slot(0, iommu->dev->bus->number,
+			pci_get_domain_bus_and_slot(iommu->pci_seg->id,
+						    iommu->dev->bus->number,
 						    PCI_DEVFN(0, 0));
 
 		/*
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 430faa882200..d3c29f04c970 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -471,7 +471,7 @@ static void dump_command(unsigned long phys_addr)
 		pr_err("CMD[%d]: %08x\n", i, cmd->data[i]);
 }
 
-static void amd_iommu_report_rmp_hw_error(volatile u32 *event)
+static void amd_iommu_report_rmp_hw_error(struct amd_iommu *iommu, volatile u32 *event)
 {
 	struct iommu_dev_data *dev_data = NULL;
 	int devid, vmg_tag, flags;
@@ -483,7 +483,7 @@ static void amd_iommu_report_rmp_hw_error(volatile u32 *event)
 	flags   = (event[1] >> EVENT_FLAGS_SHIFT) & EVENT_FLAGS_MASK;
 	spa     = ((u64)event[3] << 32) | (event[2] & 0xFFFFFFF8);
 
-	pdev = pci_get_domain_bus_and_slot(0, PCI_BUS_NUM(devid),
+	pdev = pci_get_domain_bus_and_slot(iommu->pci_seg->id, PCI_BUS_NUM(devid),
 					   devid & 0xff);
 	if (pdev)
 		dev_data = dev_iommu_priv_get(&pdev->dev);
@@ -503,7 +503,7 @@ static void amd_iommu_report_rmp_hw_error(volatile u32 *event)
 		pci_dev_put(pdev);
 }
 
-static void amd_iommu_report_rmp_fault(volatile u32 *event)
+static void amd_iommu_report_rmp_fault(struct amd_iommu *iommu, volatile u32 *event)
 {
 	struct iommu_dev_data *dev_data = NULL;
 	int devid, flags_rmp, vmg_tag, flags;
@@ -516,7 +516,7 @@ static void amd_iommu_report_rmp_fault(volatile u32 *event)
 	flags     = (event[1] >> EVENT_FLAGS_SHIFT) & EVENT_FLAGS_MASK;
 	gpa       = ((u64)event[3] << 32) | event[2];
 
-	pdev = pci_get_domain_bus_and_slot(0, PCI_BUS_NUM(devid),
+	pdev = pci_get_domain_bus_and_slot(iommu->pci_seg->id, PCI_BUS_NUM(devid),
 					   devid & 0xff);
 	if (pdev)
 		dev_data = dev_iommu_priv_get(&pdev->dev);
@@ -542,13 +542,14 @@ static void amd_iommu_report_rmp_fault(volatile u32 *event)
 #define IS_WRITE_REQUEST(flags)			\
 	((flags) & EVENT_FLAG_RW)
 
-static void amd_iommu_report_page_fault(u16 devid, u16 domain_id,
+static void amd_iommu_report_page_fault(struct amd_iommu *iommu,
+					u16 devid, u16 domain_id,
 					u64 address, int flags)
 {
 	struct iommu_dev_data *dev_data = NULL;
 	struct pci_dev *pdev;
 
-	pdev = pci_get_domain_bus_and_slot(0, PCI_BUS_NUM(devid),
+	pdev = pci_get_domain_bus_and_slot(iommu->pci_seg->id, PCI_BUS_NUM(devid),
 					   devid & 0xff);
 	if (pdev)
 		dev_data = dev_iommu_priv_get(&pdev->dev);
@@ -611,7 +612,7 @@ static void iommu_print_event(struct amd_iommu *iommu, void *__evt)
 	}
 
 	if (type == EVENT_TYPE_IO_FAULT) {
-		amd_iommu_report_page_fault(devid, pasid, address, flags);
+		amd_iommu_report_page_fault(iommu, devid, pasid, address, flags);
 		return;
 	}
 
@@ -652,10 +653,10 @@ static void iommu_print_event(struct amd_iommu *iommu, void *__evt)
 			pasid, address, flags);
 		break;
 	case EVENT_TYPE_RMP_FAULT:
-		amd_iommu_report_rmp_fault(event);
+		amd_iommu_report_rmp_fault(iommu, event);
 		break;
 	case EVENT_TYPE_RMP_HW_ERR:
-		amd_iommu_report_rmp_hw_error(event);
+		amd_iommu_report_rmp_hw_error(iommu, event);
 		break;
 	case EVENT_TYPE_INV_PPR_REQ:
 		pasid = PPR_PASID(*((u64 *)__evt));
-- 
2.27.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
