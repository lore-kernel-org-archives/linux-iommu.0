Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B342FC433EF
	for <iommu@archiver.kernel.org>; Mon, 25 Apr 2022 11:43:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 7F507405B3;
	Mon, 25 Apr 2022 11:43:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id i-Tn-2e3fYze; Mon, 25 Apr 2022 11:43:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 497F6400CE;
	Mon, 25 Apr 2022 11:43:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1BA5AC0039;
	Mon, 25 Apr 2022 11:43:19 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A96A0C002D
 for <iommu@lists.linux-foundation.org>; Mon, 25 Apr 2022 11:43:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9764260BF6
 for <iommu@lists.linux-foundation.org>; Mon, 25 Apr 2022 11:43:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=amd.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8hq-LVkfV6s9 for <iommu@lists.linux-foundation.org>;
 Mon, 25 Apr 2022 11:43:16 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on20629.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7ea9::629])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B3E6360B2C
 for <iommu@lists.linux-foundation.org>; Mon, 25 Apr 2022 11:43:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gVoblqfy80nAfjRfueGKmdjss4nuyDqACf84DR0OE9yb6juCZJ6ixkmQfWv08pRpyRulf+4VB5hdjaSCF5SqhG/hmUqV0ldBV/c/ydlZG53XO6dW1ZyZJkf6UIogeCuz0OKUOgCHUikHyCdg2QTC71RuD8pmWUJb9zGW1/6LP5uMkMmbu36DfgDlmgCx9MgNbyA0FB7sGRGLsQ+vXZ8W+vCc0lOaDSuFXpaRQ+R4ua5TqHZLfOj/F+9CYd8Ycq1346tcKQdfTYCxTQm+hdWmpJbUr9+QpXs1WqYq36FraFmbhbhdl/hx5a/ucjeg+O0j8gKEAlMfsp8rDQ+8mBNBeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SKo4EQVUCZ78tDF4rDxo6pVh8aQM6K8Zo1+iYefyUj8=;
 b=KeiGZ/F7ELYnIe8fQY9pHHFXknqyw5YVSIxbmOwUtwjS6OTXZvLnsXADzBNbEAHnBphGCxtemuKUnUILA06kL3izzmETgmXcA+bez4KVAoqOliX77nG8o5tdCcj4oFfRMqzsz3raMO7fUG4JpPEKKxRTTAjM33mY1Njga0bhOqkML1wIjLJgXD+HcLwEBk6bnbXHT/xS/PTELPZJrTgGSygLoIN2DVae05EUBLbV51PKJaJqrzhSHoU000OHyiNDe4Og7rn/G8lso/W+X0gPBlcAyJntGRu9OLrkqBTqUIOVJY+tIohaw6ZTBFDfE7SbgfBqCsosGCVcGS6gm9rkQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux-foundation.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SKo4EQVUCZ78tDF4rDxo6pVh8aQM6K8Zo1+iYefyUj8=;
 b=Mko4gVFRNeIxbBbOd0CsAq0q5wnVVB7BJysW8UanjxZR0C2RD1HgnAzgKrFjLjfe9EAtF24gBjMlq6Xrq5fx/FAFX5uQkwFrLkA5hkfOp5gmxJF/k5FtoUn4ZA/ldWSAH938/Z+nLz9kO/QnkyLA3UDcTA70M5ggw/9moW0bw0M=
Received: from BN9PR03CA0471.namprd03.prod.outlook.com (2603:10b6:408:139::26)
 by MW3PR12MB4492.namprd12.prod.outlook.com (2603:10b6:303:57::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Mon, 25 Apr
 2022 11:43:14 +0000
Received: from BN8NAM11FT032.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:139:cafe::94) by BN9PR03CA0471.outlook.office365.com
 (2603:10b6:408:139::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13 via Frontend
 Transport; Mon, 25 Apr 2022 11:43:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT032.mail.protection.outlook.com (10.13.177.88) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5186.14 via Frontend Transport; Mon, 25 Apr 2022 11:43:13 +0000
Received: from kali.amdval.net (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 25 Apr
 2022 06:43:11 -0500
To: <iommu@lists.linux-foundation.org>
Subject: [PATCH v2 33/37] iommu/amd: Specify PCI segment ID when getting pci
 device
Date: Mon, 25 Apr 2022 17:04:11 +0530
Message-ID: <20220425113415.24087-34-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220425113415.24087-1-vasant.hegde@amd.com>
References: <20220425113415.24087-1-vasant.hegde@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 75a8cb46-e5e9-44fe-ec9f-08da26b0c7de
X-MS-TrafficTypeDiagnostic: MW3PR12MB4492:EE_
X-Microsoft-Antispam-PRVS: <MW3PR12MB4492CE9538187477A252906A87F89@MW3PR12MB4492.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IKg49Zm3t52YXNHg07i4cKrXlRnjrA/AOr3pqD2fTZoE8Gxt4LNtGD5W3HyULlHiwopRtLH0w6tt/KGb/oUcihByhM7Yn9JT+H+81KoEm0S/EGP2dhfPyuzsKPzAef8jh9YwFpYB7zWl/+VvSpb++wwNj9o0EvvskUTi/xgaiWxUHj2pXmWdlwBuYFtziEYXuJYG0Qs4yqno1wfgs2zhru34Z1iTqE4IMNyrbWpylVOTF37ZtfAbeeHJik6h4nUbWHu+7Wq0MYgv32PZojtkBOXMh80C7IxRT8kKqjzfoE0CUjO2zgeOfIDiByUUYb5NMNi0TB6SL/+IYmwGD406heQe9Q8vAFVEZ0NI75muTXpp09zSXp9tRgzx6quhQGl/BVsobj77fhlAB4CYjG28nxyLZVQ56aAyyidFuY/2A86z2Na6nO/U1/nOay9U8P1kNlNqsxxAFaYt7FeMfzMhcoq9ANBDPvUkLbv7yrlh/+GWSqlaejvkvv7CKr3dyzwqeTdHPTcfeuDMVnl0Vw8lU0zpp1dF81QPqleev2vZaPO4DBW0vKkiZL33c47NgNlCQ2MK5Ou56/2H8H0byB3ueCv+ho0hBwx7uYGUOFmeCHLNDwBovyAYLdzrtjydTYEDAc1Ya6ydloIogLdLqWEsRAQvzZtP9seso9QnRD9QaWQZ6lcavVc58/Gna9Kaw6li2aBohSWl2S18ockkjgYaxQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(83380400001)(82310400005)(81166007)(26005)(508600001)(356005)(70586007)(70206006)(6916009)(54906003)(36860700001)(8676002)(4326008)(86362001)(316002)(40460700003)(5660300002)(44832011)(1076003)(36756003)(336012)(426003)(2616005)(8936002)(16526019)(186003)(47076005)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2022 11:43:13.5096 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 75a8cb46-e5e9-44fe-ec9f-08da26b0c7de
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT032.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4492
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
index 1e375d469280..46236fb05a1f 100644
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
