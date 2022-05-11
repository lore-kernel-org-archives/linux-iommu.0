Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98633C433EF
	for <iommu@archiver.kernel.org>; Wed, 11 May 2022 07:30:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 593B960BA3;
	Wed, 11 May 2022 07:30:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Fr7Eim1frTDa; Wed, 11 May 2022 07:30:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 0135F60C07;
	Wed, 11 May 2022 07:30:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DD8A1C0039;
	Wed, 11 May 2022 07:30:09 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4ACACC002D
 for <iommu@lists.linux-foundation.org>; Wed, 11 May 2022 07:30:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 369D18330B
 for <iommu@lists.linux-foundation.org>; Wed, 11 May 2022 07:30:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=amd.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZXeoe3aPZnES for <iommu@lists.linux-foundation.org>;
 Wed, 11 May 2022 07:30:07 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20614.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eae::614])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 03765832EA
 for <iommu@lists.linux-foundation.org>; Wed, 11 May 2022 07:30:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S43bR8g+/75KLZhP2YWLCMqhenHp3p8LY72UqpoJ2VZcPOq4SeXVvwSyZOPxIRNVUq/VsvTpkJzaOl96vMjWWSkwmGtIuZyke1OPRaPKxa9T6fqOsYWZR5oAS7/6o9Kj05ycw8vDn2cwOPYcCao8obVfHW7yIx6pbYkb895sExW4EwZ8XqySXbtz+tNXmqWxYr6IuT6X6wRCdFUWuilHkkVvYF5UY2ykKAplY5kLdTknE9QUZrSmGPpd64TsxAljsXw1QBCdDV3eosXYKd+aEtprN+4byTXw4/wWZOQiKW0ptW2R4chyajNIOlo4/d2HmqBfil+Y9bYka3LMgcOSfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vBXJBRz9qFGjQbxr6z7KL0Y5MvTzaSxkRJsHR3xpwuc=;
 b=NhCDdAhKkDvcS3rOFpzWJsPi3hrbQ4+Rxp5V0zfo1gY+GZEAIwtktdaklN2GVZ2Eo5iWttMiHZwMSfbZZ17D3JcRT4vioelwhyRSA97EuSRYeMy2GgouP/53yZFRZbqslYh4zeuC1xW8o5bjbj2ycCMTAaXLTpyKjoh2qw20D5SFLmlECPpYDfP2ZOjMmy8TV/deBP/kL3fvDzmw/PexETC8ETnfIfIsQsefnqe4U7DxchdTgDYs4MPjgEJvCkMylmmdDcc7U3pv2duBB9KpIMF30rcutDksfwMunG3bWtCxWD/Ryp+1F2gFYV6AQb7+ryKVDBdEGd9v/ROV0Q4PGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux-foundation.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vBXJBRz9qFGjQbxr6z7KL0Y5MvTzaSxkRJsHR3xpwuc=;
 b=HQiRPoOiXzkmchKpnYbYdbcRyn9UE4SHVCxXXMMavgkdbmV0Vj8NBukUt4/IEsoiBzLZhs3DcZlEtTdHw8LCkO9Zwajy9sIXiS2b4V8YFfYR+F1Uc2GuZ6UZjIY6Vzz6FPb7h2baDg1lnLIB7GVadR3kzMQc1j8zwgvumehgoyg=
Received: from DS7PR03CA0211.namprd03.prod.outlook.com (2603:10b6:5:3ba::6) by
 DM4PR12MB5069.namprd12.prod.outlook.com (2603:10b6:5:388::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5227.20; Wed, 11 May 2022 07:30:04 +0000
Received: from DM6NAM11FT003.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3ba:cafe::87) by DS7PR03CA0211.outlook.office365.com
 (2603:10b6:5:3ba::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.22 via Frontend
 Transport; Wed, 11 May 2022 07:30:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT003.mail.protection.outlook.com (10.13.173.162) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5250.13 via Frontend Transport; Wed, 11 May 2022 07:30:04 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 11 May
 2022 02:30:01 -0500
To: <iommu@lists.linux-foundation.org>
Subject: [PATCH v3 31/35] iommu/amd: Specify PCI segment ID when getting pci
 device
Date: Wed, 11 May 2022 12:51:37 +0530
Message-ID: <20220511072141.15485-32-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220511072141.15485-1-vasant.hegde@amd.com>
References: <20220511072141.15485-1-vasant.hegde@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 00fe17f5-8b47-4904-3d60-08da33201109
X-MS-TrafficTypeDiagnostic: DM4PR12MB5069:EE_
X-Microsoft-Antispam-PRVS: <DM4PR12MB5069D09921503F4331E626B587C89@DM4PR12MB5069.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: y++4in8+NWP/jABWrUb5D+HqE8TkIVFNbh4V+gL2MD3rxTSBvnUQoObzxgC1DZ3CAMwZXU5FxW0S1YM6tH/K5SgJQxRZF9djdNIrPClMPsqdAhiB1Aoilso4ZdD9AH7UtCvYsNaYMaSQRduPeCTJfnBndGHGDdDSPs2NrnWA/CaPbehZgZW9We5uUaEqXMM8GgehloA6q9+stodgqS900hKV8ggb63uJeQYD8VqUmCPYPzGg2B8otMBhhdJReUpj16zbrZhtbNbf4RfCI9Sw7wj+D5vkZ0xPf6GAF3lNueLi7EBx+nSnr0c9yH4t5Dskn4a2zpYrz6YS0N9dIuZpXuG2Qqa6TA96kPzqwnoye9OFiduVCUuJ1mUNHcE5r+BgRSAVYj96hP2ups2hlFtg2gLm0I8CoUCzX41r4ox+fFZcWU8f9+0MaR4ogaCb4Scz5lm8t10IuBy2qXhNkf2bD3UuT2ALBP6+Q9t2PaeiG7dzUKAUk3PpCyQfRFaV1LJjfM87DPDICIupE9eSOH6ln5xbXfCqEmQdPZQSvDqMS6TcBM/RAMdXWF/c1NJKkliX3wtXggSXh3ogECb/vRaeSIYmlowAM1lyMWH/Zl+6lg6xpHVZ/ELEwDCG51Ci62TUwAXs+CVUn/xJXgMpOwGG3GXFu6K+nT5pW2qqfnwoJmYhoqoHpPhE2BF4GUVnkWqmeB96jV94qMlR5XDd2aAyXg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(2616005)(82310400005)(356005)(86362001)(36756003)(5660300002)(8936002)(83380400001)(1076003)(316002)(70206006)(6666004)(47076005)(26005)(70586007)(44832011)(426003)(508600001)(4326008)(54906003)(8676002)(6916009)(336012)(81166007)(16526019)(2906002)(7696005)(186003)(40460700003)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2022 07:30:04.3197 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 00fe17f5-8b47-4904-3d60-08da33201109
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT003.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5069
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
index c746b71c0dbb..ca79637560a3 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -1960,7 +1960,8 @@ static int __init iommu_init_pci(struct amd_iommu *iommu)
 	int cap_ptr = iommu->cap_ptr;
 	int ret;
 
-	iommu->dev = pci_get_domain_bus_and_slot(0, PCI_BUS_NUM(iommu->devid),
+	iommu->dev = pci_get_domain_bus_and_slot(iommu->pci_seg->id,
+						 PCI_BUS_NUM(iommu->devid),
 						 iommu->devid & 0xff);
 	if (!iommu->dev)
 		return -ENODEV;
@@ -2023,7 +2024,8 @@ static int __init iommu_init_pci(struct amd_iommu *iommu)
 		int i, j;
 
 		iommu->root_pdev =
-			pci_get_domain_bus_and_slot(0, iommu->dev->bus->number,
+			pci_get_domain_bus_and_slot(iommu->pci_seg->id,
+						    iommu->dev->bus->number,
 						    PCI_DEVFN(0, 0));
 
 		/*
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index d9b23f7820a9..536dbc1d26ad 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -473,7 +473,7 @@ static void dump_command(unsigned long phys_addr)
 		pr_err("CMD[%d]: %08x\n", i, cmd->data[i]);
 }
 
-static void amd_iommu_report_rmp_hw_error(volatile u32 *event)
+static void amd_iommu_report_rmp_hw_error(struct amd_iommu *iommu, volatile u32 *event)
 {
 	struct iommu_dev_data *dev_data = NULL;
 	int devid, vmg_tag, flags;
@@ -485,7 +485,7 @@ static void amd_iommu_report_rmp_hw_error(volatile u32 *event)
 	flags   = (event[1] >> EVENT_FLAGS_SHIFT) & EVENT_FLAGS_MASK;
 	spa     = ((u64)event[3] << 32) | (event[2] & 0xFFFFFFF8);
 
-	pdev = pci_get_domain_bus_and_slot(0, PCI_BUS_NUM(devid),
+	pdev = pci_get_domain_bus_and_slot(iommu->pci_seg->id, PCI_BUS_NUM(devid),
 					   devid & 0xff);
 	if (pdev)
 		dev_data = dev_iommu_priv_get(&pdev->dev);
@@ -505,7 +505,7 @@ static void amd_iommu_report_rmp_hw_error(volatile u32 *event)
 		pci_dev_put(pdev);
 }
 
-static void amd_iommu_report_rmp_fault(volatile u32 *event)
+static void amd_iommu_report_rmp_fault(struct amd_iommu *iommu, volatile u32 *event)
 {
 	struct iommu_dev_data *dev_data = NULL;
 	int devid, flags_rmp, vmg_tag, flags;
@@ -518,7 +518,7 @@ static void amd_iommu_report_rmp_fault(volatile u32 *event)
 	flags     = (event[1] >> EVENT_FLAGS_SHIFT) & EVENT_FLAGS_MASK;
 	gpa       = ((u64)event[3] << 32) | event[2];
 
-	pdev = pci_get_domain_bus_and_slot(0, PCI_BUS_NUM(devid),
+	pdev = pci_get_domain_bus_and_slot(iommu->pci_seg->id, PCI_BUS_NUM(devid),
 					   devid & 0xff);
 	if (pdev)
 		dev_data = dev_iommu_priv_get(&pdev->dev);
@@ -544,13 +544,14 @@ static void amd_iommu_report_rmp_fault(volatile u32 *event)
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
@@ -613,7 +614,7 @@ static void iommu_print_event(struct amd_iommu *iommu, void *__evt)
 	}
 
 	if (type == EVENT_TYPE_IO_FAULT) {
-		amd_iommu_report_page_fault(devid, pasid, address, flags);
+		amd_iommu_report_page_fault(iommu, devid, pasid, address, flags);
 		return;
 	}
 
@@ -654,10 +655,10 @@ static void iommu_print_event(struct amd_iommu *iommu, void *__evt)
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
