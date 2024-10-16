Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2047.outbound.protection.outlook.com [40.107.94.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FC9018C323
	for <iommu@lists.linux.dev>; Wed, 16 Oct 2024 05:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729057091; cv=fail; b=YXpJM6T/CVXFUxUocWBgUeky4BvWjXD4mLuDzpb712J2TfLJFK/lCtYnS/9v+qlwzSpgn0VOhwcSO3P6eOtBLAmF/YbvuhJBaqs+PIMmTHzVvD+5xzH+iqnNEQKT2C7kNT+asWpc50IamzDo/4SWNjGGBnHhjmk4idkCGJkeZBQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729057091; c=relaxed/simple;
	bh=M7BCpVBK/3LYyQcc58Ffwgx8S57ZDoqkusfZtzs6yyw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t+S3qCaKnbDF6zAPXhViC2sOdHXxWZJ4qEHQ/1qnKWhHfSSCn2Afo0bXWgQJBQvnR371zZ9943YzTbkDqGuS/OasZq6I2vWbFGq7CyWwiO/mhEhhtS0d6jdl8bS1FSDUbvQRDWQLib/X45Oi3ep9/6cQO1GkDiJbpgIOxjy7pU0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=vzbOyQQ/; arc=fail smtp.client-ip=40.107.94.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="vzbOyQQ/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bw5WTQfuZNmj+VfF26o1Tbthh4f2vCMnB20TO2zT4+zRMD51bYkJdlrjiLBBdzcahnyzAGKQAIpZ8xhKC8Uky94pJxmAuT5OsKb5tLi7F8CPY4ijk4odvorS3JIhc4hQgekzuGhWys8md0myP86J5Zklkff+/Mh5o0LAQ55uD9vudmyAPVO+aUmAd0ZcV4xENESC/cDdxIw+C9xKiFTghUVIT4uVnbZcyLPRkRb8wk5Tu0cpfyMc+ACWR8jJB3+sqmZqNvy176tegexGNyMIHKR0YHQBikfcseJnTNX4k7jvnp0CJ/QvvyAaZIVtsBzPTbTXPIGyyJpZ/rvRO7C9NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9skhqww0F/YY13Fxeob1iuB5/IKADCGFG+AaXOxjM0I=;
 b=HY/kSlndo/KV5egaKE1C3n0/EyzuB5iNgB1WB0t8piqMv0IYw7d2ioMDP7ybBoSaOUXU+FoPM8oiHE80H6rnlJFNrBd5BviTHZDJXdjVf98dMoFG6VtKFnAvxAUCUmRTWE1ytgTh8jsnWYZAYLZG3j9RpVhZgQyfskEj+ZpyUekp89WjZKPvjMbA2aHBXHfxju4b0qr+LgTOycZsPulISjfFuWl4yrQt9ZoVn4PYH4LiDdf/12ftNF85U0pGeQMmpvVFYQqQZNiTecC8Qdw1ly1kf6jkxBSJK2xuodXOyIMSPxg2cw/igRTHMhwL1vnCISKnUSDxfvEYt+q5HuHvmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9skhqww0F/YY13Fxeob1iuB5/IKADCGFG+AaXOxjM0I=;
 b=vzbOyQQ/l6EOejbCc2aY7rdf8K1YwGLzvvP1DK+wBxneL3A/tECoL+JYkdDwubOSzvOZKGb3WtqyOSioeuaujXXM1xra10fY8vPWMicefRm+xyyjAJ+wSpIVhfU9mNg4095qi2SZ1u6lUZ67y6hCI0BroBSadSqQY1nm26oI6A0=
Received: from BN0PR07CA0013.namprd07.prod.outlook.com (2603:10b6:408:141::19)
 by SJ2PR12MB8956.namprd12.prod.outlook.com (2603:10b6:a03:53a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.27; Wed, 16 Oct
 2024 05:38:06 +0000
Received: from BN3PEPF0000B078.namprd04.prod.outlook.com
 (2603:10b6:408:141:cafe::5a) by BN0PR07CA0013.outlook.office365.com
 (2603:10b6:408:141::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18 via Frontend
 Transport; Wed, 16 Oct 2024 05:38:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B078.mail.protection.outlook.com (10.167.243.123) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8069.17 via Frontend Transport; Wed, 16 Oct 2024 05:38:05 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 16 Oct
 2024 00:38:02 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <will@kernel.org>, <robin.murphy@arm.com>,
	<suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>, "Joerg
 Roedel" <jroedel@suse.de>
Subject: [PATCH v3 07/10] iommu/amd: Rearrange attach device code
Date: Wed, 16 Oct 2024 05:34:58 +0000
Message-ID: <20241016053501.97497-8-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241016053501.97497-1-vasant.hegde@amd.com>
References: <20241016053501.97497-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B078:EE_|SJ2PR12MB8956:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b26ef5f-6cb6-4151-6db3-08dceda4b57f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2aNsFEgEPioPFyUr62jE898XxwF1F+jnv7TY/W8vAqAyPTPmxGZKvcYFM11p?=
 =?us-ascii?Q?s9fMKs+Zs9y+yCger9Nd1DqbZ3gs00Nhr48RPywukDPmSzlo2MrEbPNNz/jX?=
 =?us-ascii?Q?A202oysp4boLlKlxruhIfNojZCrEKP6RxIjfh+5tC0FPY7NjmVncqF639EoQ?=
 =?us-ascii?Q?lAG+S7wdhVf/dmCaYWaoo+ObagxyKl/YDxrce21mZ+UcryIr/W+PUtTIUSzF?=
 =?us-ascii?Q?690rPg/Pi5bXSiYgGKC5Nv/WV4/OWHX503pDCNsATyTGJ2x+sEYecpHYspgX?=
 =?us-ascii?Q?8skqenPbZnoBcIyZL5sGGGTnvqPsxk1KAuJ/jz9tDS5LS4OVoAbJNY+PlIQC?=
 =?us-ascii?Q?RJQkwb//estflgOp50BvEL5zBwjiObGhQNGlEUaHcuvFBRlN0sQj4KVyzQxf?=
 =?us-ascii?Q?U9lqPctK+v3orYgF/DPWQnzB6VZ77SgAhzJCML7f6fCRvoqiyTyPjmeDv8oP?=
 =?us-ascii?Q?2oPVLZP83yIbwh5Q6v3VJAdcRgxjc4k7abk7ytC6EOtvvRBCFYd5bP+PpaD0?=
 =?us-ascii?Q?6zQI7yRF7MpyZaBB4QcwcBkTAGlskN9VtccBJGAoRPcr8XaiDNHAd3V/A7UL?=
 =?us-ascii?Q?u2IR9NfNISdnEiqy0nNewzONNLck0Ya7XdoSkViisXwhzkt2MQ+apOO3b9ZP?=
 =?us-ascii?Q?pKpYcNZxhSjr/RiXhmvrAPv8eYpBgtjyYiiKdfRqf3ztTQjh411C/vnEngUw?=
 =?us-ascii?Q?IG2d822TFSuuUpCkLZ1nftPuNNeQ+SUf/HzMTyQZgoV8JNh1wjqOsEF7+RX4?=
 =?us-ascii?Q?1QJh8jtdpsHtLChkqmSRsCYgdEuB+tRNsqxtdNjACqj9qLjZ/q7zQMr19aFa?=
 =?us-ascii?Q?6xNT8VheVWdoklgxvFYvdhjRkskDu3LziGFlyLS7hTc/vGUEHJnnL4iUVFJU?=
 =?us-ascii?Q?Q3hXZUdBl+zzzErPQmyJGiMY9nQipPtAUFcBQS5S1Tj+NGFdGe6OFT3TPh1I?=
 =?us-ascii?Q?wfaLnoiAkmShAx5W1zKSqk7hlAivpwf26aRwW6hvVRkrMTyUn0JMDCOa4Vpn?=
 =?us-ascii?Q?zNreTvT0YOZLgDCDSUqjrRi3/eUYcqY41M3o6jHdewQ3JEasAC+VGxry5/+P?=
 =?us-ascii?Q?9Kn3fnkhnDNF3DrQT5tnx591WN2KoBLSEaF6+BSvsAfy6CQt4pcmwjX3TOmz?=
 =?us-ascii?Q?ym5tq+8LhZeNZpDaX0oeSLi3LkEa2FxIxx+RxPqIbGZqQ8Yx6OE0Kesja1QR?=
 =?us-ascii?Q?cy3622yjfB7w17qZPMRj9PAqBFtjloMbXcAhNLzqXF3lU3p9ocQB5iXGYCTk?=
 =?us-ascii?Q?CP/x6ehg8VmSQHoY57kII10rNrpOfoaidPiLZKlMwYQIy1Ul79wZ7PwAGd11?=
 =?us-ascii?Q?JYbnk3FN1ySSzTTG2VHyUrjY6XzXf4GjUJD97dhx/s2hOBvmaGhkiK65HiIO?=
 =?us-ascii?Q?gpDXrthsM5Ba9Wv/Let0qQnaEJ41?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2024 05:38:05.4433
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b26ef5f-6cb6-4151-6db3-08dceda4b57f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B078.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8956

attach_device() is just holding lock and calling do_attach(). There is
not need to have another function. Just move do_attach() code to
attach_device(). Similary move do_detach() code to detach_device().

Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
Reviewed-by: Joerg Roedel <jroedel@suse.de>
---
 drivers/iommu/amd/iommu.c | 85 +++++++++++++++------------------------
 1 file changed, 33 insertions(+), 52 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index a738d2d7f0c4..dd1fb3bedd33 100644
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

