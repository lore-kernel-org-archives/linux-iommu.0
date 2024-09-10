Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2051.outbound.protection.outlook.com [40.107.244.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 571B217C211
	for <iommu@lists.linux.dev>; Tue, 10 Sep 2024 07:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725951631; cv=fail; b=GylGrQ9iRL8nJBEZXBo5xkt1ZIbkDxp+VIdDLbCorkxdETTlELqFSnSFSYEDNfUp41dpthcaBXZWSVy3gPRz4nyBmzSSQ14920/xcyIS4QQl9M4PmxI/oHAt/vIuV/rNHCa2rtkz/+oiA3LnMT9GULicLm6njjr7YHJsmpI5Pk8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725951631; c=relaxed/simple;
	bh=oS3RjwEPrO6dgEJ4Wii4J18xhHdSq+8WlVc5F+E2CzE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XZ4e3ZEjpJxIKC4mjE/6UJ/PJqgTjUFgzutvTlrF44CAcZ09bwXwI+ZGMUnvIJN87DtQX4MkTjiPc4WnW2SrQMoO86s4WA7fb34g0wp8gfntJIEqCqnD5F1upGt8h2DJAIyqOfC2kzvUD+Q4zHVKOkNrYjrnN75tpbNHU733cqQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=uW5TZw6f; arc=fail smtp.client-ip=40.107.244.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="uW5TZw6f"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wG+edTnoLxP/oPfin3w700rKtAsz/6nrIaKIkQaV+4RLNwu3MaR7zZss/TYuFaVfOSaa0eY+vYhkFERkfb5c6lAW8L3T4p3aZcRq63zY9tPx0RnT5MihGooLRgch3UW1f3Saq1d+5gVq7YZsorAT8oPSF0+IToeqKVsi9D9v4M8lVK34oK0jvW39LYhSMcHCsuSfKq6fsix2HUwBfUIW+NuLbh7Z2Ng/urup+D8yAL6pXCwr+r91RvuDM7rxeJmS804m1p0O34ef+pBZaRMKiFtLGzRbzjeAarGLRa2CJQm3UviZbtLoYtNT4qmX2ONy0C1AhF31oE1aTKOz5TqN5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SUH/2FlITp7ehIJNq58pj8fUXWPuiwc02DBYJEGc21c=;
 b=GTm3hps51oQkp3QFS38KoZsDFzxECxol8vdVO/t4zQkjabbHN9TUGxCybKpm24WpF8NPv74BdtwLnfEMZdiBW3pY0yZehoTqb9gYaXmOcyNNWQ1/TaIHhmv00oTY79uklMDRfWHet8BhYDddOucm3LfeA4y/fCZxbTqCVAwaYasz0aWcsfRNRONjY2jhr/VNFmq0Tv3m5Wg4pWyvZlcwCgVmdGqu5PNciEKJjxf5bLPueUZh7N9lyxvIttMmDYWf2rqaDgKb8RwqvHSDf1rAmyIjeYSwtQ5ibI+yyOQFriJQ6f9ER5W9kok51h1E/VO4jqN3OBcuBEIOuJZlPkZnsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SUH/2FlITp7ehIJNq58pj8fUXWPuiwc02DBYJEGc21c=;
 b=uW5TZw6fTcn/C6t4qGdrrOeUWK41/rDs7edRyX3pExKKTg7xw+2JajlnGIKY48JI4nICVbA3tyrqLKCUyRsAxWAUHMOUwlDnZxbQZkMeTcQF8l9PziV2kGBNez2eNC9FsygXYothU1B8GadD0/oTD699Zq4FNB2pbVqK2p1dkGU=
Received: from BN0PR03CA0058.namprd03.prod.outlook.com (2603:10b6:408:e7::33)
 by MN2PR12MB4061.namprd12.prod.outlook.com (2603:10b6:208:19a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.32; Tue, 10 Sep
 2024 07:00:25 +0000
Received: from BN2PEPF00004FC1.namprd04.prod.outlook.com
 (2603:10b6:408:e7:cafe::32) by BN0PR03CA0058.outlook.office365.com
 (2603:10b6:408:e7::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.25 via Frontend
 Transport; Tue, 10 Sep 2024 07:00:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN2PEPF00004FC1.mail.protection.outlook.com (10.167.243.187) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Tue, 10 Sep 2024 07:00:25 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 10 Sep
 2024 02:00:22 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <will@kernel.org>, <robin.murphy@arm.com>,
	<suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v2 07/10] iommu/amd: Rearrange attach device code
Date: Tue, 10 Sep 2024 06:58:09 +0000
Message-ID: <20240910065812.6091-8-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240910065812.6091-1-vasant.hegde@amd.com>
References: <20240910065812.6091-1-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FC1:EE_|MN2PR12MB4061:EE_
X-MS-Office365-Filtering-Correlation-Id: 3cdda690-da77-41da-cf31-08dcd1663f0d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?m2VM0P5fbWhLcIbCewU7vcA/re12Nw5WEKa8v9nvMGi8P+XRt0+i/YHhBwdk?=
 =?us-ascii?Q?97oW/1sI64/AzqHfsc3m+iBO6ymyBn1klz/SqAK66TRAlByTDFO+aWdF9Kvi?=
 =?us-ascii?Q?1RtgpqPsvgzRSbBgfvkyPNDcyOqeVb1mfAcbbKUkNPYZAGCfak8t2f60x6Lf?=
 =?us-ascii?Q?79mPHVX9okNh1/HX3wQ6snC9Kx1hfaYdcV9NUD1T57OTnpHyEdtmRmt8TZPU?=
 =?us-ascii?Q?ktk8dLkk4p1xSDh8xRDuoc41oGqt9U4COKwJBzO149s0GozPH+//hZijhvbD?=
 =?us-ascii?Q?3iL3BicOVQAXRVfZ0Ebf6zItCFKTwE9jHgjxOLgnkT3fyNCYtMrWRE9UiNAZ?=
 =?us-ascii?Q?KSU+u3eyx3cYRULt2PYBrMR80iuhTiojf0HU+7b5FYvS5qfF74t8WSJAkQZc?=
 =?us-ascii?Q?H68/g9zWiRTxi+BmYqDEJIQhUjmJCSHR+zz76IfWBZGdkptHSILmRL7pXVg2?=
 =?us-ascii?Q?IdI4fgYqPKwdWTk52NI7Ja2m5I4JVQiZWn76qx32atXrgBjV+IWl5T04f3DK?=
 =?us-ascii?Q?RSnjxd6Yff+7IywhlCBFKHDtKfXn4IDC2hqj8CO3IaivN5s1ImI2qb08ImBp?=
 =?us-ascii?Q?ghpgARa9cQlsc2lkes9KTnOOyqYy/LlSxPUrhXuHppbNyI8eQLZwb/OWtFNb?=
 =?us-ascii?Q?3i1DtdbUGT8iUplAM3pPNu76XjfHnKmvqey/60zr27l+xK0BQBFhJWSssyyb?=
 =?us-ascii?Q?hg9FK3yiqKgEudvv9Z2mxS1A2xVJrTex6O75Qh2ChbxzscBBbxtV1EKk92UG?=
 =?us-ascii?Q?xuAEij/19J/YwMcV4pJE75VkCvT0+oiB4LR/HeHNobDbE1ucb+Fo8NE6mZJk?=
 =?us-ascii?Q?2OTRrZKTGJCpNMbMrYFrpoBIVeCymOVwmiexMP0rfYjWJaYWe0Y4k5vz2+X4?=
 =?us-ascii?Q?EBWmC9zZtEsWwSFls6Dm/EoLpXFD3+H4LTVsqzMnuIpiQFne9w/olyqN8GMs?=
 =?us-ascii?Q?yrvxUtIbrkNdZXZmU88dIC/ANnVAITlreSB9L5zYbnOT2it29H/zttJt8Bit?=
 =?us-ascii?Q?puV+eADwA2P3BfBYvvH67MCVMBUI6f9J+qiTpiQGVPxmd/dTz3LTahJrmJfn?=
 =?us-ascii?Q?JVmUeYXlbI2/jcj5CvPyA2nFAbqaU4zF4TLw73ej81ZXlvfmC+9mKLPG412A?=
 =?us-ascii?Q?YEVGCdaMF4RDgMUCEzciFlkEtVJgR9bJ+jrT4lZgbKmyL6DHn6DkD0WjBHcR?=
 =?us-ascii?Q?55+g3iBvrTKWDLbZZlf0i8zPjUTjXrp2cZ84mT572i+dBRqcTjl+yaT7fbsH?=
 =?us-ascii?Q?tMxDeh27nZL0K5Yc9bQ1pQ9iwuBj5QGKLWimbeKWgQ1a4EdwOWxQ+6PDgwFU?=
 =?us-ascii?Q?5IvP+Dc4v610fDQboAu9ZA8aidHrBUvjGTasMN3kYwaBATlkDCdRu7HBHbFs?=
 =?us-ascii?Q?kRSq+zFYgyAz+L9VymQPTFF1ps0qx0rWVvh1X+1NNcCgN3VuuVu7DXqjGGO0?=
 =?us-ascii?Q?Cy6vgdYNkve29j/b8dtw3Q62SJzRORKZ?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2024 07:00:25.3569
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cdda690-da77-41da-cf31-08dcd1663f0d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF00004FC1.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4061

attach_device() is just holding lock and calling do_attach(). There is
not need to have another function. Just move do_attach() code to
attach_device(). Similary move do_detach() code to detach_device().

Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/iommu.c | 85 +++++++++++++++------------------------
 1 file changed, 33 insertions(+), 52 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 713d05a85de9..ab8bedf55459 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2077,12 +2077,24 @@ static void pdom_detach_iommu(struct amd_iommu *iommu,
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
@@ -2090,64 +2102,17 @@ static int do_attach(struct iommu_dev_data *dev_data,
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
-
-	/* Clear DTE and flush the entry */
-	dev_update_dte(dev_data, false);
-
-	/* Flush IOTLB and wait for the flushes to finish */
-	amd_iommu_domain_flush_all(domain);
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
 
@@ -2161,6 +2126,7 @@ static void detach_device(struct device *dev)
 {
 	struct iommu_dev_data *dev_data = dev_iommu_priv_get(dev);
 	struct amd_iommu *iommu = get_amd_iommu_from_dev_data(dev_data);
+	struct protection_domain *domain = dev_data->domain;
 	bool ppr = dev_data->ppr;
 
 	spin_lock(&dev_data->lock);
@@ -2181,7 +2147,22 @@ static void detach_device(struct device *dev)
 		dev_data->ppr = false;
 	}
 
-	do_detach(dev_data);
+	/* Clear DTE and flush the entry */
+	dev_update_dte(dev_data, false);
+
+	/* Flush IOTLB and wait for the flushes to finish */
+	amd_iommu_domain_flush_all(domain);
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

