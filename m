Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2066.outbound.protection.outlook.com [40.107.94.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3220C33C6
	for <iommu@lists.linux.dev>; Wed,  6 Jul 2022 11:47:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CDiljRmMCT67ZR6RF+5q/OrtyMCwjF6Ah5BT7KzLlqZAc1cACETPOfPFApOFQpEjktVZxB0SEdSCBs9Ra0F1I/7jH4eCoeHb2BdGPnEZOqxFO91d242l94Jqw6KKC8lRMrU5jDBywhEaIsUQAvKeLxklINEDgSxzW1p8qOkKSW2NcU7bglK9k9vvriPOUV75DlyQaFun9ljG8gTAhwWd/oBdAh2m35Maxcv81dKSQrmAiLpEOulneZc8i/60EmVUb7FoKEJmrNrJiG8qgPNTSCO0svvChKUQ4dBosIjUxvvY4+PrB6rbWn6GdOp2EA20eFbRgFF5XJlvI1/r09OOyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uStNGY+ot1EJHF5FyKGdIDpaP0AOIYTCXWlIRW3Bwkw=;
 b=YFYLywfawyNvbZP3nwEjzKfEuYjoyecjKywun9FphtQt6KpICfSFF3+XeRhl3wQ8Od7dsoG94Bnr2JJumuWCjrQmCukFpOV0mZZdGT5+qX1recaSKQzrsa1npEBcGfEYiB5BEJuJY97U+eLCLc+NErYUskJlSDBAfj24DyTINvI1BigqgIjUYqyzQb/srbdIE6povbZcRFIxOMxsbcXRLnk4N0OQiWa/OjQaftjGS+kiBcqXBS26zqSAgwpvor9fbap9ssxYCkhF+381nnGUOi63FhXRZZPxXteXAufCYB2tOFcqdx+wixehKniZf7VOguZFRNEgbmoyytPlONxRvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=8bytes.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uStNGY+ot1EJHF5FyKGdIDpaP0AOIYTCXWlIRW3Bwkw=;
 b=ASEy+NO7Ill/k8vECYxjfZuXcbmWibbEx03+oa+1Ne8wlWoljqvFQU7i3odVMYs7A0vXdf4R8o7IpgxBeEMNZSTfD7qyK0TrAaQdmKRkPjHjvMUjCfOaF8LxzLWjV+p4tRMAQefw+cOTn2plXAu4rTElTwquMCrZlp0z2Hv42B8=
Received: from MW4PR04CA0089.namprd04.prod.outlook.com (2603:10b6:303:6b::34)
 by MWHPR1201MB0222.namprd12.prod.outlook.com (2603:10b6:301:54::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.17; Wed, 6 Jul
 2022 11:47:47 +0000
Received: from CO1NAM11FT067.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:6b:cafe::5f) by MW4PR04CA0089.outlook.office365.com
 (2603:10b6:303:6b::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14 via Frontend
 Transport; Wed, 6 Jul 2022 11:47:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT067.mail.protection.outlook.com (10.13.174.212) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5417.15 via Frontend Transport; Wed, 6 Jul 2022 11:47:47 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 6 Jul
 2022 06:47:44 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <joro@8bytes.org>, <iommu@lists.linux.dev>
CC: <iommu@lists.linux-foundation.org>, <suravee.suthikulpanit@amd.com>,
	Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v3 RESEND 21/35] iommu/amd: Update set_dte_entry and clear_dte_entry
Date: Wed, 6 Jul 2022 17:08:11 +0530
Message-ID: <20220706113825.25582-22-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220706113825.25582-1-vasant.hegde@amd.com>
References: <20220706113825.25582-1-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 26c47169-1d83-4503-f39b-08da5f45590e
X-MS-TrafficTypeDiagnostic: MWHPR1201MB0222:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	sjfe3YpFDPoOGyTkXAzFCZE/fPnFXV1zNS+VH528NsFGYlLoxRU8q93Y7JsvIweDr0qIA4mZRJFbk0u4AVw0uxnpCip56zNtNIX9sPkrAOO5Ybhz3Qv1YRGCOqTqvcmXugDJjr6R60ANuQGHmdpJ97tgprRbEQy62ZZZLk9h2TnMAwb7/Nrg4JHWKssJFvRPda4DrCUlsOy/c+u8zX+5sH2hCs6U+B8P+IsXb5kM8NpL67jxkBm74Dq0lY+t/T8sYlyf1ZyoflWTZ0iEiBZIjtWNwdt3sya4NjxZBDwmduL56CdM2A4ltfqAmICVaaI1AZ74U0Dms44mpdMfwazKK9Y1NTEFH5kVf/QeGwlWiRCxBHHsy+ieiHwbHvjm19S5vEBMAJwpbzXOyXT8ER5T5b5klTTT0m8/l6xoGJEwRllquGyD5d6Le9s+QM77ZuMhPGmlp8aNJ+4jpR7k0fH7C6bP0XrnxvVmWjHHqBi5aVySvq6LMZ3NvJ+dhp/17tDQTNdEzmusfc2DHcwQOIOVFpv+LJZ1IQs9r2KoeE7moPqay/TY6RLr6fmXwRbabFswjMtEOph2NsFNBPQ6p5a9lmvAGLwiKEcM5dwz7JsfP/DeybVL4rFr5tiH+nZIPgnyXKwEOQYvuUWledSdpfGzicPnUbyEgZx4K5Oh3Sl7v5Z3gQ0W9jdbUEH3UaOCGYME9925MMj9TB8jJol/50ZT+jypzXTulUQKIMaP/9gOH4/MdYApbStj9HLJr2z5qISGAFx2dt1gwi31oXw1YHefFvVi0EzucutZJYAEcyXQSxLRnVol8p5GesTRYRhz1agGwyQYFH4vjqAh1V0LlNuAentHnIqNXYw/T83nWnnJ/7pg87w9uL2nYmNCT+elkOMC
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(136003)(346002)(376002)(396003)(39860400002)(40470700004)(46966006)(36840700001)(110136005)(47076005)(336012)(40460700003)(426003)(26005)(54906003)(44832011)(82310400005)(186003)(16526019)(36756003)(316002)(1076003)(83380400001)(86362001)(2616005)(5660300002)(34020700004)(70586007)(2906002)(81166007)(40480700001)(36860700001)(478600001)(7696005)(8936002)(4326008)(8676002)(6666004)(41300700001)(70206006)(15650500001)(356005)(82740400003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2022 11:47:47.5849
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 26c47169-1d83-4503-f39b-08da5f45590e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1NAM11FT067.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0222
Message-ID: <20220706113811.7T4bjwFODdGjDzqCXqsGuY5eIv1WEgeRHXrflF8ODcQ@z>

From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>

Start using per PCI segment data structures instead of global data
structures.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/iommu.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 6e0cd9c4f57c..493cda5e0246 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -1537,6 +1537,7 @@ static void set_dte_entry(struct amd_iommu *iommu, u16 devid,
 	u64 pte_root = 0;
 	u64 flags = 0;
 	u32 old_domid;
+	struct dev_table_entry *dev_table = get_dev_table(iommu);
 
 	if (domain->iop.mode != PAGE_MODE_NONE)
 		pte_root = iommu_virt_to_phys(domain->iop.root);
@@ -1545,7 +1546,7 @@ static void set_dte_entry(struct amd_iommu *iommu, u16 devid,
 		    << DEV_ENTRY_MODE_SHIFT;
 	pte_root |= DTE_FLAG_IR | DTE_FLAG_IW | DTE_FLAG_V | DTE_FLAG_TV;
 
-	flags = amd_iommu_dev_table[devid].data[1];
+	flags = dev_table[devid].data[1];
 
 	if (ats)
 		flags |= DTE_FLAG_IOTLB;
@@ -1584,9 +1585,9 @@ static void set_dte_entry(struct amd_iommu *iommu, u16 devid,
 	flags &= ~DEV_DOMID_MASK;
 	flags |= domain->id;
 
-	old_domid = amd_iommu_dev_table[devid].data[1] & DEV_DOMID_MASK;
-	amd_iommu_dev_table[devid].data[1]  = flags;
-	amd_iommu_dev_table[devid].data[0]  = pte_root;
+	old_domid = dev_table[devid].data[1] & DEV_DOMID_MASK;
+	dev_table[devid].data[1]  = flags;
+	dev_table[devid].data[0]  = pte_root;
 
 	/*
 	 * A kdump kernel might be replacing a domain ID that was copied from
@@ -1598,11 +1599,13 @@ static void set_dte_entry(struct amd_iommu *iommu, u16 devid,
 	}
 }
 
-static void clear_dte_entry(u16 devid)
+static void clear_dte_entry(struct amd_iommu *iommu, u16 devid)
 {
+	struct dev_table_entry *dev_table = get_dev_table(iommu);
+
 	/* remove entry from the device table seen by the hardware */
-	amd_iommu_dev_table[devid].data[0]  = DTE_FLAG_V | DTE_FLAG_TV;
-	amd_iommu_dev_table[devid].data[1] &= DTE_FLAG_MASK;
+	dev_table[devid].data[0]  = DTE_FLAG_V | DTE_FLAG_TV;
+	dev_table[devid].data[1] &= DTE_FLAG_MASK;
 
 	amd_iommu_apply_erratum_63(devid);
 }
@@ -1646,7 +1649,7 @@ static void do_detach(struct iommu_dev_data *dev_data)
 	/* Update data structures */
 	dev_data->domain = NULL;
 	list_del(&dev_data->list);
-	clear_dte_entry(dev_data->devid);
+	clear_dte_entry(iommu, dev_data->devid);
 	clone_aliases(iommu, dev_data->dev);
 
 	/* Flush the DTE entry */
-- 
2.31.1

