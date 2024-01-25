Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2064.outbound.protection.outlook.com [40.107.237.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E71F4776A
	for <iommu@lists.linux.dev>; Thu, 25 Jan 2024 12:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706184996; cv=fail; b=LZEv/6Oi3zsKhw9+gm4OKcZvDfHYpiL9IEEYDOqnGk7F7z5+sETNuaDJdbq1FIm3UADftlcwVUrCkgO+BmvCPVhBtf/YeUM0Dgq1oYcdfo/ye5NYZCI9XtJRFdLK9WkmZM9c8RwMqicJYd61nVr1nOCOmq+hX2h/aaAh7jrWtUw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706184996; c=relaxed/simple;
	bh=Vo1R3S2mb34jQXi7c9nGR8gK0BM17jORMAiCMaDwOx4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ph0qurrcK2dAQYdbmDQFjSJuubQ4GCaWnG1BonvOcguONh/8STPswa4kb2isJLHh29tixuhk6681pGfXT0EcKHtnmOZBkJRdJA9vVapZXC7kMOV2Wh2dEPPo55vQIOUHkjlQDq9YhzB/sXeQu4iM8ywUHtsaMHMw31F4iykmuoA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=4J8JvQ7e; arc=fail smtp.client-ip=40.107.237.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="4J8JvQ7e"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QUPJPUueLBCdjYn2cNL4lGKmYHEcNTTagy67Mxr5jAfZQVjaalOA53bCaJVJgPF7edS9ibFfnmI4QiZ//FcuuGDi6i5lW9pAr+euWuOimDj3uhky2E38dusLPtxgEQcG7KUSS/ROCcLSP3kCZbXyYg5011QE3qxgdjO1H4utZMTzLCUv9pdIaX9/opPAa4PA9OUWYIN0pqaoQD/+FZxLXdNqp4aXLDPMoM4kh19vPcT2XlkEGc/zhSX1rCd4NLoLfWyJjP6UKZ8twxqHu/6wUocomNvUMWa6mnEyZ0IkcIERmbWt44E4Q0bC4cJBhDHN6OBIARFH4DrzGXs+r6EoQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mcwVZmxP7HbcJiH89rju8GRs/rkKh5EQjcsinRXpkGU=;
 b=JdRXOf9GTTq63H9LHoOTDiFQ9M/p/e1tCu2z9m4Mw0IiUTbv7Cm0PeWrBj7wrns7LbfAj8TpmTIBWFhAZ5WMhF9JIxlwG2/Hx7J0fDDUzFC/fsy07DLWel29F9DkQnwnQgnsEH4aMKNXhmMJSSD/zHoskLsUJHcNTBUZA31qtlwnLnFbYmNRkmxRoNFUZIUPPFnJJQ+eO05a4ZmAnUiUCiDwJb61I4ZrKT8iB1S2R2T40KR9wXlJmk/qm+JqS1OenwlvbqGvAg5mwDScCGbuw8G5+n7c66QaA4p+1IAlh37RayRVlSDMxmbFwQ+V/i9DXRWUO46TXHtxOedY1gh4rA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mcwVZmxP7HbcJiH89rju8GRs/rkKh5EQjcsinRXpkGU=;
 b=4J8JvQ7ePalbaWCfIHg2ya9A5VJRDPL/xbdfhSKIQ9zLSGfDY8i86fdTgnb7U5mbOzoYcsW8KME+FtkOw9l242wW3AiKM44MeOAoXhcrp7Ak+XSfhjaDMLrxcS7LbV4KiiHOLf711OqcY6ZYLhiMo2ErUdS2LgFqISHRfr5HPAE=
Received: from BYAPR21CA0029.namprd21.prod.outlook.com (2603:10b6:a03:114::39)
 by CH3PR12MB8236.namprd12.prod.outlook.com (2603:10b6:610:121::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.24; Thu, 25 Jan
 2024 12:16:32 +0000
Received: from SJ5PEPF000001C8.namprd05.prod.outlook.com
 (2603:10b6:a03:114:cafe::fc) by BYAPR21CA0029.outlook.office365.com
 (2603:10b6:a03:114::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.8 via Frontend
 Transport; Thu, 25 Jan 2024 12:16:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001C8.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.16 via Frontend Transport; Thu, 25 Jan 2024 12:16:31 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 25 Jan
 2024 06:16:05 -0600
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v6 09/17] iommu: Introduce iommu_group_mutex_assert()
Date: Thu, 25 Jan 2024 12:11:27 +0000
Message-ID: <20240125121135.8217-10-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240125121135.8217-1-vasant.hegde@amd.com>
References: <20240125121135.8217-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001C8:EE_|CH3PR12MB8236:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c2f1383-f8b2-4a0c-f88f-08dc1d9f7736
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	sSf//EkKbOTAmSJnE3jzNVeNDjCneCtlvdApscH7PvfaeLKAtQ4iJDdIb6S5T/hMujN2KeY43DZEVT4WUYGoj/xJCgEW2vR3A/wnUIfQSui/1wtjJL+CTCg00ZxLSlXCvqyTFDXMNQlcyZlIKOAWdUq+Lz7j7gdsQnSmY6SEUhytEoL1beOuyHOJxvPzYl+QR4qS2NnSKI9idIhglv//wr8E+27JY90jE3lGFBJFZzXsBjoXG9IGw3mo+lEwd+qdWRv7yy+7eAxs6ocKcKGyCdv0zMUiWMFPlemOrw0r2CCbt0/8YQQbZhPKDxkSmH6i+XsUJlFRiM1TWeOozgBAO3/tlLVz3ZEgMEWTqL3QnKKeDcWfVcZ62i+UnwqefpYAULuIUE2JuG/gCwMeNvh5UipS4g1AmaQB+XzYt6alSLobEdYjR03E4UvRi9BT0dp6RNAExiNYilcJ8UofmH1Cdlrr/aP7ScvhawVynQFGx2a64pO1A3N7AA3WsazydUZSoiCbxKU0wOKT4HRXaksYvc5DzXzev5yXq/uds64s4XbFPjnO+9fB2Z6kZgkjWxKVddg7+h25dzU4PtqWm6IrGjz6L98BWdXmIXa6OAftGb6KLUMWjCoAKjzIMh0rrm5nh5i6+j0mazcyPo3eQss5BrhHP5PNysFYulYZ1O1tenlEnqfK+NS5WI3laTmXE8SSNmaU31HRGzBNsV0H96BOr1oOhV9TTn5hFI3KzHHMjR+SJLsnHovIyzOgpEqz91CGg2t7ifB5GyYMRrsmuxFrKw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(346002)(376002)(39860400002)(396003)(230922051799003)(451199024)(64100799003)(1800799012)(82310400011)(186009)(46966006)(40470700004)(36840700001)(40460700003)(40480700001)(26005)(70206006)(1076003)(70586007)(426003)(110136005)(5660300002)(316002)(36860700001)(4326008)(6666004)(2616005)(8676002)(16526019)(336012)(8936002)(54906003)(83380400001)(44832011)(2906002)(47076005)(81166007)(356005)(478600001)(7696005)(36756003)(41300700001)(86362001)(82740400003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2024 12:16:31.4364
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c2f1383-f8b2-4a0c-f88f-08dc1d9f7736
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001C8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8236

Add function to check iommu group mutex lock. So that device drivers can
rely on group mutex lock instead of adding another driver level lock
before modifying driver specific device data structure.

Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/iommu.c | 19 +++++++++++++++++++
 include/linux/iommu.h |  8 ++++++++
 2 files changed, 27 insertions(+)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 502779d57b68..ca2049e594fb 100644
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
index 7f6342bc71c3..54a952fbf140 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -1334,6 +1334,14 @@ static inline ioasid_t iommu_alloc_global_pasid(struct device *dev)
 static inline void iommu_free_global_pasid(ioasid_t pasid) {}
 #endif /* CONFIG_IOMMU_API */
 
+#if IS_ENABLED(CONFIG_LOCKDEP) && IS_ENABLED(CONFIG_IOMMU_API)
+extern void iommu_group_mutex_assert(struct device *dev);
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

