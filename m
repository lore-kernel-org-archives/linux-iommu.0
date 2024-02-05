Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2054.outbound.protection.outlook.com [40.107.102.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82FB818EBB
	for <iommu@lists.linux.dev>; Mon,  5 Feb 2024 11:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707134215; cv=fail; b=C+8dHG8vcE+Db5eCgdntaaFqB1Gg8ldP37LycPXvOkmsQ31ZZRQEuH3lQqCgh5CBAp2DuQAeEOpHsoc2JakNhNZ3+PahbF9LwgnYmtksralADureZ5hXlJHpbivswVrMLryoWRWXsL6vynGHb5nxdkT/0WO3rjtSpsC/ZCRqFfM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707134215; c=relaxed/simple;
	bh=3kJxA2vHkj0pzaJiK/5J4y+aFH2YRdQ2grHB+3oNbg8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B6XlDa+4QsJf4PT7V3bB72/Q/OYItfMBJDo2y9D6F7czk77r7wRB/Qyyan7h0Qy87r/+AFQZVOe7lfq23N4cAyV/Zemjzzt60MMyx5lov3u7swq+FeN0I8U0N+WsFql3vYUnLhfpjD3HkLKjSLSlYDsDq1FdV8fnKHbwk144QlI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=f4eZkmvc; arc=fail smtp.client-ip=40.107.102.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="f4eZkmvc"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l+ujYpXd26Q6KhVYZqnzOCgxRJ3HcGJyTQgneSVFs91Q/a14sBqcT7x4Kn0fsa/y+JE05VR/JKJjJKbHo7qzhdw50ehXi+2RBYWRaitK4FvKgXuf0tS8s8AKZGbX4h1EHDY4rAbV/FEzqwuKyulGhPmjlleIlzZ1Fa99T2NeOIRF404EZT9PAYigJ2W9wtHcBBowURmQPUt4SUgmLScKqiy+pjDdkOXomDElZycuyeeZoWInzuflJZiv+t9J8IaSjFEMnqItSJE/m+BN/xujgDURSPZyHOEp088dL5nNc0VeU+SlF7HoQDiKCkUz2DSGwZrsX/nl9sXzCq9xvTT60Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y4+9SYBR2in9ge5TRVs5SxvyxIrPkI8Zdpsh7a7wXOA=;
 b=YcaBopJHv0rt6VnwEp7B7JSkRWkdTcTPs8pUMAe0RDIAOwdU9jKYG/4nfqPnjlpl4+Br+fNqfgU2Ack0FgWapHJTZR95WxyLpp0ac8RnRWMD76jmnkcgC9AKdezwwuxBuS9hQc//aSGEvKLhlxm1+bzBjRXS878txT5tVVKA8V+6mSXG5v7m6GGI+/S9rV/O8z2oPVV12ivZOTQqpSccwg84L4wIUeu7U2L76ONtNXki2n1eVYy9EeI7bBt+ouO5aLUJ/J1LjiU7SSwJQh4ni5vrbzgzP6/uHhBh327HIGgzU0W07H+7N8wVJgBK/wWQAF0uHf9Y20XcExSrr13W/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y4+9SYBR2in9ge5TRVs5SxvyxIrPkI8Zdpsh7a7wXOA=;
 b=f4eZkmvcbMLEZFulRO52Z2FwwtFDYeD2EoWfWGnvCqhkcrT6cS+tJ1oPGfa5MKZkEnufL+p2g+KML2DQjji711ddJwtKals1X9u93wBWKaTltRgMVCPc4zI7eC6UKqSrNwPhBzeszUN64797eQxG6viVrKJSoItDGIVSlFxpwQw=
Received: from DS0PR17CA0006.namprd17.prod.outlook.com (2603:10b6:8:191::22)
 by BL0PR12MB4913.namprd12.prod.outlook.com (2603:10b6:208:1c7::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.17; Mon, 5 Feb
 2024 11:56:51 +0000
Received: from CY4PEPF0000EE32.namprd05.prod.outlook.com
 (2603:10b6:8:191:cafe::77) by DS0PR17CA0006.outlook.office365.com
 (2603:10b6:8:191::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36 via Frontend
 Transport; Mon, 5 Feb 2024 11:56:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE32.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Mon, 5 Feb 2024 11:56:50 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 5 Feb
 2024 05:56:47 -0600
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v7 01/17] iommu/amd: Pass struct iommu_dev_data to set_dte_entry()
Date: Mon, 5 Feb 2024 11:55:59 +0000
Message-ID: <20240205115615.6053-2-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240205115615.6053-1-vasant.hegde@amd.com>
References: <20240205115615.6053-1-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE32:EE_|BL0PR12MB4913:EE_
X-MS-Office365-Filtering-Correlation-Id: bd743296-641e-4d38-39c4-08dc264189b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	8KTaCOg2vN0ySlrN9YejMasVbofm85NkzJp9W9S9ES46uaKDednvZiHm+8mRtnrqnfgbYN9D4JVVVZt3wnqy7BYY89fWeIttpC5eD6+LHd9ztIVk/EpjoanxY+02xjXOV2jtbe/SnUIBrt1fd6xjxOgFB+q8W4T+ha7OqWOF6rwQie/grzwLBq0BCBVRIfjcjn0XiHJLgK+ceW0W4cidF1qql1VIxG52aKA+KoOoVFEKoau3uoEpxjxGTGEuqo0wZqgt/BJjMQPfGzVPjlDxqWhsrfCrYJj9Z9FQXUQ1le8ckQt4OeOmDvr7K2QWiRFDT7ZLZKcBUA7c4JSNnXqIUBrpx7/00JT7a/sJSSe6O57VWukoR8qdYwPNPp7kPQpJJ2KOF8Uq2r/OoVB8qVhbbvuy1ZKatyiCwa2n7/echOoRaHiMkOC3zohYjB6lM2Bd0cKtU96Cufe15BqnVJgJCXiMrsW9VQS0iAmtnqeF0aBR5eID121GAzF2Wk+y52m6axHV3ZcZL8Kt7lg42rRcS3zKCyjoZsqCkaHM7Qut9hvgcismatu/TfbDDTvqIXqDP1Cmrq4YcYPIq3YfQlNBKaNJwUM67EbNeyKqlFyl3lQCwOBMLvSz6qergoPE1c6fDzqYmHZimpyUxJHJ0oCEfwmW9QtBm55lDTy7LkrOlVDiriSw8gMp0uT4d3+4URXXz1ng4TBwxoSR391G4/m/II/YuySxpbIvCTWRW++4NfGsRxyvIqO8acVWRM2XdQA/J4YOMbxQe38NChBGju1+3Q==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39850400004)(376002)(136003)(396003)(346002)(230922051799003)(186009)(1800799012)(451199024)(82310400011)(64100799003)(46966006)(40470700004)(36840700001)(47076005)(26005)(16526019)(1076003)(426003)(83380400001)(356005)(81166007)(82740400003)(41300700001)(2616005)(36860700001)(2906002)(336012)(8676002)(8936002)(70586007)(110136005)(70206006)(4326008)(316002)(54906003)(5660300002)(44832011)(6666004)(7696005)(478600001)(86362001)(36756003)(40460700003)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2024 11:56:50.3734
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bd743296-641e-4d38-39c4-08dc264189b7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE32.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4913

Pass iommu_dev_data structure instead of passing indivisual variables.

No functional changes intended.

Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/amd/iommu.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 4283dd8191f0..5edde7fa3c63 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -1704,12 +1704,14 @@ static int setup_gcr3_table(struct protection_domain *domain, int pasids)
 	return 0;
 }
 
-static void set_dte_entry(struct amd_iommu *iommu, u16 devid,
-			  struct protection_domain *domain, bool ats, bool ppr)
+static void set_dte_entry(struct amd_iommu *iommu,
+			  struct iommu_dev_data *dev_data)
 {
 	u64 pte_root = 0;
 	u64 flags = 0;
 	u32 old_domid;
+	u16 devid = dev_data->devid;
+	struct protection_domain *domain = dev_data->domain;
 	struct dev_table_entry *dev_table = get_dev_table(iommu);
 
 	if (domain->iop.mode != PAGE_MODE_NONE)
@@ -1729,10 +1731,10 @@ static void set_dte_entry(struct amd_iommu *iommu, u16 devid,
 
 	flags = dev_table[devid].data[1];
 
-	if (ats)
+	if (dev_data->ats_enabled)
 		flags |= DTE_FLAG_IOTLB;
 
-	if (ppr)
+	if (dev_data->ppr)
 		pte_root |= 1ULL << DEV_ENTRY_PPR;
 
 	if (domain->dirty_tracking)
@@ -1808,12 +1810,10 @@ static void do_attach(struct iommu_dev_data *dev_data,
 		      struct protection_domain *domain)
 {
 	struct amd_iommu *iommu;
-	bool ats;
 
 	iommu = rlookup_amd_iommu(dev_data->dev);
 	if (!iommu)
 		return;
-	ats   = dev_data->ats_enabled;
 
 	/* Update data structures */
 	dev_data->domain = domain;
@@ -1828,8 +1828,7 @@ static void do_attach(struct iommu_dev_data *dev_data,
 	domain->dev_cnt                 += 1;
 
 	/* Update device table */
-	set_dte_entry(iommu, dev_data->devid, domain,
-		      ats, dev_data->ppr);
+	set_dte_entry(iommu, dev_data);
 	clone_aliases(iommu, dev_data->dev);
 
 	device_flush_dte(dev_data);
@@ -2013,8 +2012,7 @@ static void update_device_table(struct protection_domain *domain)
 
 		if (!iommu)
 			continue;
-		set_dte_entry(iommu, dev_data->devid, domain,
-			      dev_data->ats_enabled, dev_data->ppr);
+		set_dte_entry(iommu, dev_data);
 		clone_aliases(iommu, dev_data->dev);
 	}
 }
-- 
2.31.1

