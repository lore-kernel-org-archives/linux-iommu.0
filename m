Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2056.outbound.protection.outlook.com [40.107.96.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B2111AACF
	for <iommu@lists.linux.dev>; Mon,  5 Feb 2024 12:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707134449; cv=fail; b=Yrt3pjYqI6DxvmclD54TbOwStg2JsnsxlGd9BDGPl8jTYyWRQZy4rTk1pa8aaiFTnIxNuLSRm5Rd2E9hfKczq28jqZLRJCY/YqzkgZHXhdXCtsY6A0iQJ3hfX4mxiIY3CKN+csQDnqn3LTqVe0UX55sFjXJdje53yUNYVXa3MEE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707134449; c=relaxed/simple;
	bh=EJmfDsQRZPHbfujBfGVMd+sGOSwv2uO+TJMGFYB4L18=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AKkMvmaoc5QDh+3X/hN3yzv80NSZpohDidRmoN/BkLnTQd6K/gXfZj2wiP5mKLn/9UrR5sePt+1xrrf7zvLIwrN+CEnxY47TWk8Aur4uiKI8Oyzr7DIGK2QqnHP7xV7VBdViCRLISWtDePWfsIEiMW7v6xgOGZlm8YSFMQVv19s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=sBJ66tS1; arc=fail smtp.client-ip=40.107.96.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="sBJ66tS1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M7PcVRpQL5+L0EZ3TupddOjFkwppjfCJjd3bbh7EBCa1ENAzH/6ES0CGnBKZTZyNR72KaX54F2qlMWqGgv6nkbEbKv8ODW+sNO57D6xr/oEEeHlczwgWYE0wyQt8YAZ5vtszAhpkEpXCkOyr1snw5nWix9i+sEZ3Xj9TkdHqYZBQvqaxzaz35RuA9Koaon0OxT27lXxt5IvWnomGuag/KuJnSh51Zxtc3TuMhvw8sFlFWInrVZCQB7a31ts4NDyp7LEjY07ULoxWH260zAfVcn+ADpo1yP/fU1NYd1dTer1T4OYgDM5ABBJje3SNUqejjsQ5O6NdVEYzXbVZg0UTmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eIoUNfUBTnIus8nmJBrh0t4cPS2j9EBYlxZq6g6vQXo=;
 b=ILbUcHMdQnf4G/8LD85WMkBA1u1nN059Ijq6BUqWI58zvVSLh+i6q2GSlqqPIbDeXqNbdZQaYMkDIvgIGXzoigUaNA1snTF1XegZAsuc1bydDmRr/zErW7XcljW8pNNk7QV7M+SjHL9yR36hcn81fNs2nR9STCu2NBev7og2HBAMt8xssbBWvILq1+athgzbQGm9MgmlGahsAw1AFD0wYxssUQXLVvK86e7uVHzu2Phr6udf0YLBxDVeTVt3hIYDj6oPnFmKFrMf7RMAhgYpXsEAXfNG/tK02p1/XNpFPV6vX0e8gmujhp/oImWUPS+HBLicbECSElFdChp+SG51wQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eIoUNfUBTnIus8nmJBrh0t4cPS2j9EBYlxZq6g6vQXo=;
 b=sBJ66tS1/yLcvHFgEHEWY4nlgzYk1ggIlAXReB2NTqmLm/4PWO/EK+1lvLxyy9HN8Tt5PfVz3oqt52OibyXvSjqF8uynOgwNermSjrkww4O45EWJOlbDCdGq2wC6XYQ8V9kWqOZYWS5U1JHWae8lfzSSh9yOvCu1x7lAkHjYSz4=
Received: from BN9PR03CA0947.namprd03.prod.outlook.com (2603:10b6:408:108::22)
 by DM4PR12MB5794.namprd12.prod.outlook.com (2603:10b6:8:61::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.14; Mon, 5 Feb
 2024 12:00:44 +0000
Received: from BN2PEPF000044A0.namprd02.prod.outlook.com
 (2603:10b6:408:108:cafe::f1) by BN9PR03CA0947.outlook.office365.com
 (2603:10b6:408:108::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.34 via Frontend
 Transport; Mon, 5 Feb 2024 12:00:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044A0.mail.protection.outlook.com (10.167.243.151) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Mon, 5 Feb 2024 12:00:43 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 5 Feb
 2024 06:00:37 -0600
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v7 09/17] iommu: Introduce iommu_group_mutex_assert()
Date: Mon, 5 Feb 2024 11:56:07 +0000
Message-ID: <20240205115615.6053-10-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A0:EE_|DM4PR12MB5794:EE_
X-MS-Office365-Filtering-Correlation-Id: ded401a9-b75e-44fc-133b-08dc264214ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	zHrNgVtyuVtN0zSlgDbmd0DgbgWn8Oz7rApsfqVjgLIR0hemi3kYO1/0IKmzdRX2BkmsLEDMhP8+yqFWfx7s5DKieWCGCMvShSen7+IUwCxZkSUNQaUQvW7OomMoE3r4ylH9IFRgjSkixNFWVTL4ddRBS8xusYl72fIVnjlN7hOQMN3bMPPs30zkUbyCYYj6P9ZAaRhMsNgBMHSzLTMXghaobO7KXqRRAUa7EX+3xPS5OZWC0NK9bdIAYe6qmiJDESa6wpFT5/SsBmZpLuqwKgVWo2ORqEz6J4lRlJBv0Y+G7lId3XUDXj8caOy8w8OqWa2pz7uWi0n3kznoOIfN6QtaTpQVQwr09V+YQzV+oxCm3hnOSvu2L80a1XQancb9k7LNE0U0Br6sjxptWs4IfDU55GEWEXsgppNtTtIBldkRvh95+8cwYfG709SQ8OezLlgTg7LpDyfr5vYnaUhsujkxn54yILa5kCDUW49KdNMh7/W3LEE7FbbvPNTRG3v614QQqYPTmGZjpDsxnW5YtKXdN7ADkW0Wv4p3u5p8tb0IDiKni7zJB4vztuQN+ibp9NKhE110009r2OOKlxF3Gw7+3QIUPduSqcPJAimo22hb+BVURJnMF+xYWgZTW+2h4Ph4+yGfzH9OPWLWXws3T8j5GC7l2udEw/rhrWnDyAfLR5f7cAcTAVQJbUUImAcSsT52y/wgA4+j50ee5jqbP0cCQEulZ34s+qVhcvK+GSS4k0wTgaIrzdGrmrBLh/U1fqqXtB6W+eXjbAp4RslplQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(136003)(346002)(396003)(376002)(230922051799003)(1800799012)(186009)(451199024)(82310400011)(64100799003)(36840700001)(46966006)(40470700004)(7696005)(6666004)(26005)(336012)(426003)(47076005)(2616005)(1076003)(16526019)(8676002)(8936002)(4326008)(5660300002)(36756003)(44832011)(70206006)(110136005)(70586007)(316002)(54906003)(2906002)(41300700001)(86362001)(81166007)(478600001)(40480700001)(40460700003)(356005)(36860700001)(83380400001)(82740400003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2024 12:00:43.8474
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ded401a9-b75e-44fc-133b-08dc264214ea
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A0.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5794

Add function to check iommu group mutex lock. So that device drivers can
rely on group mutex lock instead of adding another driver level lock
before modifying driver specific device data structure.

Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommu.c | 19 +++++++++++++++++++
 include/linux/iommu.h |  8 ++++++++
 2 files changed, 27 insertions(+)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 35dac3e4629a..210dc7b4c8cf 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1246,6 +1246,25 @@ void iommu_group_remove_device(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(iommu_group_remove_device);
 
+#if IS_ENABLED(CONFIG_LOCKDEP) && IS_ENABLED(CONFIG_IOMMU_API)
+/**
+ * iommu_group_mutex_assert - Check device group mutex lock
+ * @dev: the device that has group param set
+ *
+ * This function is called by an iommu driver to check whether it holds
+ * group mutex lock for the given device or not.
+ *
+ * Note that this function must be called after device group param is set.
+ */
+void iommu_group_mutex_assert(struct device *dev)
+{
+	struct iommu_group *group = dev->iommu_group;
+
+	lockdep_assert_held(&group->mutex);
+}
+EXPORT_SYMBOL_GPL(iommu_group_mutex_assert);
+#endif
+
 static struct device *iommu_group_first_dev(struct iommu_group *group)
 {
 	lockdep_assert_held(&group->mutex);
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 6400bd52507b..2b8e6b827a6f 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -1411,6 +1411,14 @@ static inline ioasid_t iommu_alloc_global_pasid(struct device *dev)
 static inline void iommu_free_global_pasid(ioasid_t pasid) {}
 #endif /* CONFIG_IOMMU_API */
 
+#if IS_ENABLED(CONFIG_LOCKDEP) && IS_ENABLED(CONFIG_IOMMU_API)
+void iommu_group_mutex_assert(struct device *dev);
+#else
+static inline void iommu_group_mutex_assert(struct device *dev)
+{
+}
+#endif
+
 /**
  * iommu_map_sgtable - Map the given buffer to the IOMMU domain
  * @domain:	The IOMMU domain to perform the mapping
-- 
2.31.1

