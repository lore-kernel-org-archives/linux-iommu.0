Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2049.outbound.protection.outlook.com [40.107.236.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D4CB1D54CF
	for <iommu@lists.linux.dev>; Mon, 28 Oct 2024 11:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730115270; cv=fail; b=Dk9Y0Izk5XI+0jDk1AMgxhf7qd+TvM1gNFaXDzyBPO1iU6OZhrfIcnoIbXkZCBJCoCzYfLcwdccsv8usx53g+UDDfaKI1MUwIb5YuDG8bQ3reUoWgqgDDFKETZkxfYshWDuYl1nwvS7I52zQ3mjVH6sJ3ghVqEEKyhoFD4cFOpc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730115270; c=relaxed/simple;
	bh=SgR2PpzLQy5UD1F67Xic87Auqe++/qmYcjxCnyiPl/4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Mvbd6YShJHMMRQc3cqooQPwuqWXTy1lzGaTi+D6qS1dm0VyJ+9hs+knV1LB0GmMbmBKUJmF340mC4N8v+zCEGk5ruovTzanO8J0vW8vQV+sM0lMTsr+a9YibAwCMP5UkT6J7Zxa3f7N1ASYKjvA/oowBVgupuEcCV6sk+Ay9heQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ECg2Emv+; arc=fail smtp.client-ip=40.107.236.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ECg2Emv+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q/woR2hUPvjrsRkngboD2KbOGHRTfzrkwy6N7+xqHwhn9huzf7KT5Ya3iuIV6m+XOCkC+HOnZQgJ85+omz4ZjhtbGTxJxUEfJ4kHKBZ6+fr1RTA7QwUTDGDH/cs1bGtxOAC+7I4treIo3S+2nSNzYmOPhOcYI5wyjlWdTIAcYHHVRxVAc8PgSNB55ZMpR3R9mxJlR9kKbMYB+jPIQd0JpG+8F6CBsMLRARAV4afkUpGLEKVE1P0VE+HNOVT+ZzIPNYxTaHVDcfBtuYkllgKphrBpIom2jfq3ILlKlyf+wiRfQkzOfHkYsI9Gs8LU7DYStE26x6WJcTxsnW/PcdrzWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AMP1c/x4SzUSFyn1vXu+puFIa6aKt8Dw549G8M8Jl+I=;
 b=RK/3k4o79u4th3h8DvTfIUxPyY1td11RQN6SN2jqWeg6XhG3O/KiE6laFA8Z4QNjWOkrOT7yxxut08KgNj/Le+5mthvsSN14wspHtbVkid/Xpm1SKaOSt0ysGMJsRf/U4/Rtrx9CKG3R+3UljKvVSBb4iErPg3S/q5jmvLiNS3YfMzDZf9FMynQTq4E7TZGvPD5TCjMqSaqYTO2UgNEbhX2oGGYDr72i/10vqO80tM4tdsbE4p3Q+wRcKsHFKfJD0e8/YEJJcdf21/gisZOZgTRWFtvECnZpoq3Z/BxBny4WbZ/iYZDu+leG2Telqxe3aMjKCEXt/3n98IAu6AN9Aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AMP1c/x4SzUSFyn1vXu+puFIa6aKt8Dw549G8M8Jl+I=;
 b=ECg2Emv+ZxLFwCHp1nwWt7GxASJynEJ61Ifik1abSL3BcBS1z1j+Ra8dvFSsXl1Nuz9U8j07NkA42bM/FPXWHWtQqs51BseNg1oZSGg4JoWQNOk0Wh4b/XdECEJQeFsPeB1NPBX7We0SFO1xaoqcLRjh7wF4XehRrmMNh/2+tG0=
Received: from SA1P222CA0182.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c4::20)
 by DM6PR12MB4450.namprd12.prod.outlook.com (2603:10b6:5:28e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.24; Mon, 28 Oct
 2024 11:34:23 +0000
Received: from SN1PEPF000397AF.namprd05.prod.outlook.com
 (2603:10b6:806:3c4:cafe::83) by SA1P222CA0182.outlook.office365.com
 (2603:10b6:806:3c4::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.23 via Frontend
 Transport; Mon, 28 Oct 2024 11:34:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000397AF.mail.protection.outlook.com (10.167.248.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8114.16 via Frontend Transport; Mon, 28 Oct 2024 11:34:23 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 28 Oct
 2024 06:34:20 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <will@kernel.org>, <robin.murphy@arm.com>,
	<suravee.suthikulpanit@amd.com>, <jgg@ziepe.ca>, Vasant Hegde
	<vasant.hegde@amd.com>, Joerg Roedel <jroedel@suse.de>, Jason Gunthorpe
	<jgg@nvidia.com>
Subject: [PATCH v4 08/12] iommu/amd: Rearrange attach device code
Date: Mon, 28 Oct 2024 11:31:44 +0000
Message-ID: <20241028113148.5774-9-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241028113148.5774-1-vasant.hegde@amd.com>
References: <20241028113148.5774-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397AF:EE_|DM6PR12MB4450:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e83a8b1-e271-4748-0a4f-08dcf74478a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kJILfNTyvy7qPrIDDebIGz3cJh+U7i9dKmyCCy86DDIMRRQ3an2MmeBFqgS+?=
 =?us-ascii?Q?tenSpJWwXRd/2VjxMzc+HgRAO07rRfU/DkFzuTqdiBB72sxJDDzaUq5fGkf5?=
 =?us-ascii?Q?UJGB7+Z8gmGrznwT0MsAA+Q8IjN+3NGk8b5v5tGhZulkHXVNbA3IRvAP6Lyn?=
 =?us-ascii?Q?SE30KBa5PJqIepwB4Scu9YNhLiVi/CkOPiuwvyc6ZEQY0JwvW20pXiu/h6NF?=
 =?us-ascii?Q?h3EbvwQb99DbjnYjKP5Q5dOSQE05Vn7036Gsv9lEQ7a0Bb1mll+uUxuF5rp6?=
 =?us-ascii?Q?f8GRvK3t6VeZoZeNGFNGLBwvgJVJcpB248gngbZW+U/OAX2JwuIMdE0DBhT7?=
 =?us-ascii?Q?eih8B1lmDlSuJJVfnsZk8fQQKHzwrZGvUBDmQzbItnipfp/euPpDVqvz/Wcx?=
 =?us-ascii?Q?XzPeaiMXd49h2FXd7+gcTfRlqOYCuN7+12aRrKIB7VMND7OUzRYbJc3cDQDz?=
 =?us-ascii?Q?adtrKwKlZ2+AOdXES1fuDvCzEqqZkenLOdgDJxvgNlJXqGVK0ySZK6riiEf8?=
 =?us-ascii?Q?rZ2QqXE1gWPs3aG6xmcSCi0fiNvKdepe+3QjOQgYn6EE6usqUsI/cYF2Sddr?=
 =?us-ascii?Q?u4/ZKKp6SOsbs0IRY7G0VI8Z2GNu8ogHSfGlfTfR+wRnq0tuDGxoYkSIlCFk?=
 =?us-ascii?Q?VRa2oMnkSp5x9BWPmtfaUlfbJIk3VuONq6YQWj0iuetuSA8s2GrHGzPBc/wp?=
 =?us-ascii?Q?ynWB0cWw9W5phEZX6nxBgmDynKffd8lSS0LIub1MgvSnLJehzAuXNU6YiK5L?=
 =?us-ascii?Q?ODOSI5Wzqe+pfzpGcLQ+eyvCG/J70SPf1p8JMwMj4wNvNMnwnkY06THtPLZL?=
 =?us-ascii?Q?vwytHc34OIkuqytc28b4yAeqtUDsMYLlx6EhzbV5r8dQWqkXACVKjxcQlzeM?=
 =?us-ascii?Q?6ReiIgLLpWympa0ZfqmAZxwih4PqLhczSZLCQo4c8iPwHhyl4DKn6GLlhuFp?=
 =?us-ascii?Q?EGOXULvbagS2PicDUg/owY8u+soSf4Skoa5uwUKmJ1q/YJy4JyiKPKeoNq07?=
 =?us-ascii?Q?XZ2+xvsZS70w8OXdGGfirQp/EbZoxNkOO3jhbkxyawlOkMlmoo1OZ61VUYii?=
 =?us-ascii?Q?1ver1fwTVJqA1JTLqXGPr+YvQHy2hxDoUdpo2FaMDKYzAhdgMW3n1khI+ayB?=
 =?us-ascii?Q?Brqicrt7KazjXuiVbun1femA3VctGhk4G8Yc2S0XK2XwB0neNJ5WFgDp2kRi?=
 =?us-ascii?Q?NotX1e4DnpzzNkMUY8jFfsElFjsNPoDvwhgal/4kyGtmcZc/jhAMt1AEiPHx?=
 =?us-ascii?Q?iQ7UkHwZVGbCUmctG377gqnH59TR5sgBH5gBphFnTQoe6p6v8pmPDYF5bdgK?=
 =?us-ascii?Q?Hvl9kKL9qnY5QjSvr9OxjouQrzBjQR/RYKLva2Kor3fhOfg2NcH42e+6Eqlt?=
 =?us-ascii?Q?8N7Sv3hpzyc9GmxYvsn297gZ9VSJW77Qi6hpDWeFnIFxnmg22w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2024 11:34:23.3167
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e83a8b1-e271-4748-0a4f-08dcf74478a9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397AF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4450

attach_device() is just holding lock and calling do_attach(). There is
not need to have another function. Just move do_attach() code to
attach_device(). Similary move do_detach() code to detach_device().

Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
Reviewed-by: Joerg Roedel <jroedel@suse.de>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/amd/iommu.c | 91 ++++++++++++++++-----------------------
 1 file changed, 36 insertions(+), 55 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index cc819d3b1198..a7257d9e6388 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2078,12 +2078,24 @@ static void pdom_detach_iommu(struct amd_iommu *iommu,
 	spin_unlock_irqrestore(&pdom->lock, flags);
 }
 
-static int do_attach(struct iommu_dev_data *dev_data,
-		     struct protection_domain *domain)
+/*
+ * If a device is not yet associated with a domain, this function makes the
+ * device visible in the domain
+ */
+static int attach_device(struct device *dev,
+			 struct protection_domain *domain)
 {
+	struct iommu_dev_data *dev_data = dev_iommu_priv_get(dev);
 	struct amd_iommu *iommu = get_amd_iommu_from_dev_data(dev_data);
 	int ret = 0;
 
+	spin_lock(&dev_data->lock);
+
+	if (dev_data->domain != NULL) {
+		ret = -EBUSY;
+		goto out;
+	}
+
 	/* Update data structures */
 	dev_data->domain = domain;
 	list_add(&dev_data->list, &domain->dev_list);
@@ -2091,67 +2103,17 @@ static int do_attach(struct iommu_dev_data *dev_data,
 	/* Do reference counting */
 	ret = pdom_attach_iommu(iommu, domain);
 	if (ret)
-		return ret;
+		goto out;
 
 	/* Setup GCR3 table */
 	if (pdom_is_sva_capable(domain)) {
 		ret = init_gcr3_table(dev_data, domain);
 		if (ret) {
 			pdom_detach_iommu(iommu, domain);
-			return ret;
+			goto out;
 		}
 	}
 
-	return ret;
-}
-
-static void do_detach(struct iommu_dev_data *dev_data)
-{
-	struct protection_domain *domain = dev_data->domain;
-	struct amd_iommu *iommu = get_amd_iommu_from_dev_data(dev_data);
-	unsigned long flags;
-
-	/* Clear DTE and flush the entry */
-	dev_update_dte(dev_data, false);
-
-	/* Flush IOTLB and wait for the flushes to finish */
-	spin_lock_irqsave(&domain->lock, flags);
-	amd_iommu_domain_flush_all(domain);
-	spin_unlock_irqrestore(&domain->lock, flags);
-
-	/* Clear GCR3 table */
-	if (pdom_is_sva_capable(domain))
-		destroy_gcr3_table(dev_data, domain);
-
-	/* Update data structures */
-	dev_data->domain = NULL;
-	list_del(&dev_data->list);
-
-	/* decrease reference counters - needs to happen after the flushes */
-	pdom_detach_iommu(iommu, domain);
-}
-
-/*
- * If a device is not yet associated with a domain, this function makes the
- * device visible in the domain
- */
-static int attach_device(struct device *dev,
-			 struct protection_domain *domain)
-{
-	struct iommu_dev_data *dev_data;
-	int ret = 0;
-
-	dev_data = dev_iommu_priv_get(dev);
-
-	spin_lock(&dev_data->lock);
-
-	if (dev_data->domain != NULL) {
-		ret = -EBUSY;
-		goto out;
-	}
-
-	ret = do_attach(dev_data, domain);
-
 out:
 	spin_unlock(&dev_data->lock);
 
@@ -2165,7 +2127,9 @@ static void detach_device(struct device *dev)
 {
 	struct iommu_dev_data *dev_data = dev_iommu_priv_get(dev);
 	struct amd_iommu *iommu = get_amd_iommu_from_dev_data(dev_data);
+	struct protection_domain *domain = dev_data->domain;
 	bool ppr = dev_data->ppr;
+	unsigned long flags;
 
 	spin_lock(&dev_data->lock);
 
@@ -2185,7 +2149,24 @@ static void detach_device(struct device *dev)
 		dev_data->ppr = false;
 	}
 
-	do_detach(dev_data);
+	/* Clear DTE and flush the entry */
+	dev_update_dte(dev_data, false);
+
+	/* Flush IOTLB and wait for the flushes to finish */
+	spin_lock_irqsave(&domain->lock, flags);
+	amd_iommu_domain_flush_all(domain);
+	spin_unlock_irqrestore(&domain->lock, flags);
+
+	/* Clear GCR3 table */
+	if (pdom_is_sva_capable(domain))
+		destroy_gcr3_table(dev_data, domain);
+
+	/* Update data structures */
+	dev_data->domain = NULL;
+	list_del(&dev_data->list);
+
+	/* decrease reference counters - needs to happen after the flushes */
+	pdom_detach_iommu(iommu, domain);
 
 out:
 	spin_unlock(&dev_data->lock);
-- 
2.31.1

