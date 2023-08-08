Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2062.outbound.protection.outlook.com [40.107.93.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85D0BDDBF
	for <iommu@lists.linux.dev>; Tue,  8 Aug 2023 10:07:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n7ZS7eNC9SmPuWZD/sM2LWuunrIFx/vBcG19JMYFjBA+HrJS+wQNSEp883Rxm9yw4svUotxN9icc9ni5mOrBCQ2m4H59oCc45X1EY5C/xgxywCnfaCPofM8jcMC9FMQ28cN5c33X4tKiYzxrZ8KvpFnjY9GVD4fdCimxIS8Jd4q7S9matpVFYDD/RpThYUAsC/ddccWFYxbJ5vWwqxQcdgfxALN6nXmvqFi+niBZC2Gn+r1xZVJdYjvQczpvR0gByMeZeCwzR1f9F3ms3sLGkDt8ZHA5Z6RCkd0P2DktsjGyOwscGl6J2ujNg1qR4HCvs6XA8UQK9/KptYPg5VuGYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QSFD5OU6VDlh2dD/SrDbOTRlCN/DjE/ICx1RMt5cYcQ=;
 b=WcjyCr7ppJayD/nkFsuAqqLWhfw4URJ3eRUGdS28gHA/ndqz7pVdNbWM+3tV2g2vLfoRY3rShUSTBvwUtHSsNmGynAF4/TAheNstim9bq2aVgnJ/DsidZ2arnNU/ntZV1QhKjU/NGqohR9XJ2QNhyLFGt2zwl/8KF13/LFD0tW1XyoLsTxgSdFIwGJ9mbkQu5xweFkBMSy8k7tvR7rvzGSl/t5eNbCagTcByfokdOQ+dxw9G/9Qj2wgZ1tMV/cMq264OMCwCYtyx5goaI0bpXy4FN4XPtWW4VUnmz1CkMCxCC/DCfm0JXgU2rRtqTk5gHn0rRb06lf3O5AVeA/x64A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QSFD5OU6VDlh2dD/SrDbOTRlCN/DjE/ICx1RMt5cYcQ=;
 b=2w4Bo2CtV7gKN9PDPd7ZXdLeA43d0a3PGTahczaglVTJsZcOSiqJoilVigR/zpG2tlIYI8uLZoiyVa5SUmsnMuZpenWvjTMrbUqSCjUnGhWX8drog1lgwo914L5gwAQpaXY09ha6rIifZWqeBka6+ECmXn5WBYgrLlxHn4r3rRg=
Received: from SN6PR2101CA0018.namprd21.prod.outlook.com
 (2603:10b6:805:106::28) by PH7PR12MB5928.namprd12.prod.outlook.com
 (2603:10b6:510:1db::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27; Tue, 8 Aug
 2023 10:07:07 +0000
Received: from SN1PEPF0002636C.namprd02.prod.outlook.com
 (2603:10b6:805:106:cafe::95) by SN6PR2101CA0018.outlook.office365.com
 (2603:10b6:805:106::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.2 via Frontend
 Transport; Tue, 8 Aug 2023 10:07:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002636C.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.19 via Frontend Transport; Tue, 8 Aug 2023 10:07:06 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 8 Aug
 2023 05:07:04 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH 06/11] iommu/amd: Refactor helper function for attaching / detaching device
Date: Tue, 8 Aug 2023 10:02:27 +0000
Message-ID: <20230808100232.5977-7-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230808100232.5977-1-vasant.hegde@amd.com>
References: <20230808100232.5977-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636C:EE_|PH7PR12MB5928:EE_
X-MS-Office365-Filtering-Correlation-Id: 4cb5146c-3926-446b-3c76-08db97f738d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	fUntmKxbR0lmzrqpoIag2Dx9UoFdGCrakOPpEHpfQ3Zeq7JeeZKLuHBJoRCqCeO5yoBbSFqxn3KRyYSqEODkCmL1xk8B8F15EkoOSvkmde3P6PeSepT3I8Rber7fq+bA53yfN9GRJxrBfQJALUqMXbetNAcDhjw/u8uX2hv78k+Vaobbg8slqg4cbcn3iOVkQY8Vepr9kfqWZOTAL3qGW0h1vpCTvyOrz69bMgbjE2wlAfrml5lSpxu+bB+au6J7XVsph09hKgREBywVRsMnee2/Quta3AjrvoVw1umZd70f9Y7aBbZrfXT8f9ZH3py7TPUgEOjMAmFl2TNKie4RG61L8EwM7SoxT/Jc50/kPtduKKgndQDHg2LFi4uHs4lN+0VOAcpSnt3j68eZpj03o6fLpEVQe1VMs1/B4UMIwW5HLyOzZOipT7ru1XYMXsT6wHIup+FASI4V53OlUOi22XW/MjLZhp89rU6zdpJjzCXftoMB7Y02PC/7KpsqrMDCnaxJWvyzuootgZOWMo0aKLS8h0nHDO7bRcqiCVIk1dTKNRVugHmf2Rx2satq+NRB/ZKY2JbgdYNvlMAGyaBJBEYw6ChMLhzs5LzwWzStjEvI/Ho7OqiXbpHal6s5ncYHgZ/4Y7VsPmvfaYylOJuxvgIriCzSbuapVdyA6BqecZ3HH58hXa/hCGWf9hdG4Wnu8LioRwO3KM31NLq75lylpXOes2l1wEsDw1g1YrgLJci6JI6cmCpBg9MM7yH+5XrcSWSqqEs3WKzKR0tl48ZuYA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(39860400002)(396003)(136003)(82310400008)(451199021)(1800799003)(186006)(40470700004)(36840700001)(46966006)(426003)(44832011)(8676002)(8936002)(5660300002)(4326008)(41300700001)(316002)(47076005)(83380400001)(40480700001)(86362001)(40460700003)(36860700001)(2906002)(6666004)(7696005)(2616005)(1076003)(26005)(36756003)(81166007)(16526019)(336012)(70206006)(70586007)(356005)(478600001)(82740400003)(54906003)(110136005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2023 10:07:06.8712
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cb5146c-3926-446b-3c76-08db97f738d6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002636C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5928

From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>

To use the new helper function for setting up GCR3 table.

If system is booted with V2 page table then setup default GCR3 with
domain GCR3 pointer. So that all devices in the domain uses same page
table for translation. Also return page table setup status from
do_attach() function.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Co-developed-by: Vasant Hegde <vasant.hegde@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/iommu.c | 54 ++++++++++++++++++++++++++++++++++++---
 1 file changed, 50 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index cc42732820dd..4fed3fbe069e 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -1821,15 +1821,41 @@ static void clear_dte_entry(struct amd_iommu *iommu, u16 devid)
 	amd_iommu_apply_erratum_63(iommu, devid);
 }
 
-static void do_attach(struct iommu_dev_data *dev_data,
-		      struct protection_domain *domain)
+/*
+ * Note: This is currently used when booting w/ amd_iommu=pgtbl_v2
+ */
+static int default_gcr3_init(struct iommu_dev_data *dev_data)
+{
+	struct gcr3_tbl_info *gcr3_info = &dev_data->gcr3_info;
+
+	/* By default, GCR3 is set to support non-PASID devices. */
+	gcr3_info->giov = true;
+
+	/*
+	 * By default, setup GCR3 table to support MAX PASIDs
+	 * support by the IOMMU HW.
+	 */
+	return setup_gcr3_table(dev_data->domain, -1);
+}
+
+static inline void default_gcr3_destroy(struct iommu_dev_data *dev_data)
+{
+	struct gcr3_tbl_info *gcr3_info = &dev_data->gcr3_info;
+
+	gcr3_info->giov = false;
+	free_gcr3_table(dev_data->domain);
+}
+
+static int do_attach(struct iommu_dev_data *dev_data,
+		     struct protection_domain *domain)
 {
 	struct amd_iommu *iommu;
 	bool ats;
+	int ret = 0;
 
 	iommu = amd_iommu_rlookup_iommu(dev_data->dev);
 	if (!iommu)
-		return;
+		return -EINVAL;
 	ats   = dev_data->ats_enabled;
 
 	/* Update data structures */
@@ -1844,12 +1870,27 @@ static void do_attach(struct iommu_dev_data *dev_data,
 	domain->dev_iommu[iommu->index] += 1;
 	domain->dev_cnt                 += 1;
 
+	if (domain->pd_mode == PD_MODE_V2) {
+		ret = default_gcr3_init(dev_data);
+		if (ret)
+			return ret;
+
+		ret = __set_gcr3(dev_data, 0,
+				 iommu_virt_to_phys(domain->iop.pgd));
+		if (ret) {
+			default_gcr3_destroy(dev_data);
+			return ret;
+		}
+	}
+
 	/* Update device table */
 	set_dte_entry(iommu, dev_data->devid, domain,
 		      ats, dev_data->ppr);
 	clone_aliases(iommu, dev_data->dev);
 
 	device_flush_dte(dev_data);
+
+	return ret;
 }
 
 static void do_detach(struct iommu_dev_data *dev_data)
@@ -1861,6 +1902,11 @@ static void do_detach(struct iommu_dev_data *dev_data)
 	if (!iommu)
 		return;
 
+	if (domain->pd_mode == PD_MODE_V2) {
+		__clear_gcr3(dev_data, 0);
+		default_gcr3_destroy(dev_data);
+	}
+
 	/* Update data structures */
 	dev_data->domain = NULL;
 	list_del(&dev_data->list);
@@ -1906,7 +1952,7 @@ static int attach_device(struct device *dev,
 	if (dev_is_pci(dev))
 		pdev_enable_caps(to_pci_dev(dev));
 
-	do_attach(dev_data, domain);
+	ret = do_attach(dev_data, domain);
 
 	/*
 	 * We might boot into a crash-kernel here. The crashed kernel
-- 
2.31.1

