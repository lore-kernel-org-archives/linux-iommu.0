Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2075.outbound.protection.outlook.com [40.107.244.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1452711715
	for <iommu@lists.linux.dev>; Thu, 18 Jan 2024 07:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705563516; cv=fail; b=sxJ48mljIReHVv/16hWdWIlLaeeOMxAAdXvrteNPH2gHMxHXb72PSnodTczj5iTp9MO6wytzp4u5yqr4zB4IeuxSwR7t/6ikQywmSZs36LQzyC/fFaRToEbrXT1fjMblu3TLEIiD4Y5+yvlh/0/NKOgaEOQnTx+PZ5X4veBJzbU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705563516; c=relaxed/simple;
	bh=PPvYpZLT7HY2NjgIX9Gk1OQ8cDaZwYO052wVsuMU2p0=;
	h=ARC-Message-Signature:ARC-Authentication-Results:DKIM-Signature:
	 Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:Received:From:To:CC:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy:X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped; b=N65yqySe5u3Q1v5MysV6471m49WiGQSUbtVq6t0dOGOi7vcJYeGtk+pUpwif92GuKeZ4GaDZLbIgwtJax++ciJ6VqLcBY0Nt51MJWUswGTUyqVE9kV8Owro8UVLKfloZ4U7HfG71BW8eyu2JYDH+m0guSUh4dPeD1QT1ALb2YYQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=FppKbcnx; arc=fail smtp.client-ip=40.107.244.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="FppKbcnx"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TWuh/KJCWI7SjxaaThXIdYep2pn/+GzQYlGaynB6ANSdNrZmgJ7gdZXiII5U0ZM+bsNpwOV77Uvsu0ZoDXmsgtrhU+GWCXGD0kGOUOprSxqGDMwZ+cK5i7R7GI+toNqR855VascW4o0RK87mNw2UXm3zH5uz+2deSH3J/OzEE0mS6IqFMGMOm4kc3u1z0qGJN4ZfI+SXCD3CiH5yDVJpk9cFfKcaTaEC7pskdwCTVaQKDaZQiuXWs2xTFgvTvqDdYQ/24B+FBLHVcg6Nkerb5VD1oQMAckrPRY2yF9BbpfSxDc7APPN5/Iw6dAuIWnrctXodXDe1GX18kpgf+YRviw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dAs93djPDd7rfaJ806SM+DsJz98j7zghGVKHcfj/MfI=;
 b=fjOmiZtxtL9TB1SMXi3TFONhPDQDQxMAy7yVcDXrkjTyOlmqkBRwxTdztb0EjTGBYa0z5Juh+Cb7AIWrnSNeFT9DX7aFE6wx6SWzNKIU4xWxXUCHTbcA3KG597bYfe0B4P3wVaOUhR5YGbzBM0FAsYN9eTMrlm9tsgfKHqDidSjOePSUAIE9KNew5qiFmfKjcWi5+F9eT8QkQHN/5tNVyioQXi4mlNucY46TUMYFWSBG7gHAJQ1DLe1vYdlc5mZISmK3WaqGLmw6ZQdbZim/+c5eD+cGEky4M3J5IfL1PJhP76zLiGWPBeXFCpDaYUkoX8GWJNpAsUQZ0GYjLYDaXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dAs93djPDd7rfaJ806SM+DsJz98j7zghGVKHcfj/MfI=;
 b=FppKbcnxZ2i6blEvY1Ay7I95gJIhylfH0dbE0sedvf2xEhTJq3TNNo+ULVfzurPY5VjFtz2HBYl0TABKZKGNTob2V5OvQuY21D0NzWtzxZ0nqEFCN27VublunsNYfp7FMxuHyIcijV8rhuAwHcFYtkhLdL8LFlpnLdfYvKpDtfM=
Received: from SA0PR11CA0024.namprd11.prod.outlook.com (2603:10b6:806:d3::29)
 by MN0PR12MB5715.namprd12.prod.outlook.com (2603:10b6:208:372::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.23; Thu, 18 Jan
 2024 07:38:32 +0000
Received: from SA2PEPF0000150A.namprd04.prod.outlook.com
 (2603:10b6:806:d3:cafe::f9) by SA0PR11CA0024.outlook.office365.com
 (2603:10b6:806:d3::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.21 via Frontend
 Transport; Thu, 18 Jan 2024 07:38:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF0000150A.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.16 via Frontend Transport; Thu, 18 Jan 2024 07:38:31 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 18 Jan
 2024 01:38:29 -0600
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v5 10/14] iommu/amd: Introduce logic to enable/disable IOPF
Date: Thu, 18 Jan 2024 07:33:35 +0000
Message-ID: <20240118073339.6978-11-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240118073339.6978-1-vasant.hegde@amd.com>
References: <20240118073339.6978-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF0000150A:EE_|MN0PR12MB5715:EE_
X-MS-Office365-Filtering-Correlation-Id: 11541740-9253-4f47-e421-08dc17f8786d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	1A4o/jGIwxdwsRseyuETI5U3edx6WCWRQ8ftx5CNbMl86IuQqt7PnTyDCdemxQ3OnA6M62CgaBU50dhYhFKNGQ5LlC9rIt1CVOAshMP8hGYCyg5yoKzeF4jXNDhTdeYzJGjp+ajt+EqV5rQHKrxsoZ1FgmPxyjwiY/b5hnm2E+u4E9TW0UN/1wFxUFi81EX7XejXeumOW0+FFTE+cLkjikaCCXMeAgoGbvyy9EI8p2n9daxHMhk7CLXUgeTPcagJAWC2aa6UJiPdmHf9RaFZbJTWHqEwL2Au0Qt68TeKNcTUP1eOOO1v8+QJAbixLYglXgGYStRi5hvbe+NBtcoXSudDvHnwyoX0/FVlbTWxYTBYgAe3pcauStGhq9C+kvgtn/dUdRZkn+xSt8qUFOYfgbpvIoFATojygrnSYD6ZrjcX6hKFzZ6XwmXoUiqaHVNgb6YH+AB4l1gkPP+GTmPVjxDEp1ww2diqKbL0JiOXF7g4c79fTQ2fU6HUurKa458DtjuC9bRXqEPNnrk/INYFSlwvhaMEtR1OtoaKu0yc/Bw5HwX+iOgn4atD+aa3u19wMynOseo5LbEqLdoXXJI9epwH5x4Va+snFAmkFkQfzJAqHIr7MkvOFzNU2N3AJEOpPLRaMYMM6CHJxI4JeFWmHNb16l3tUxpIKpXzJC2DuFUnpDKmEhPKgcgTr+NpTg3fthhGitAvL/KpB+1j5PLPZ77oHGoLX2v8Eld9RacZsTnAG6GrWGrlkVH7+t5jrSvHUEcZS2VQ3vcVpouOyLZeuw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(346002)(39860400002)(376002)(136003)(230922051799003)(64100799003)(451199024)(82310400011)(186009)(1800799012)(36840700001)(46966006)(40470700004)(83380400001)(70206006)(2616005)(1076003)(16526019)(8936002)(336012)(26005)(82740400003)(36860700001)(8676002)(47076005)(2906002)(4326008)(110136005)(44832011)(426003)(54906003)(6666004)(478600001)(7696005)(5660300002)(316002)(36756003)(81166007)(356005)(86362001)(41300700001)(70586007)(40480700001)(40460700003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2024 07:38:31.8938
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 11541740-9253-4f47-e421-08dc17f8786d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF0000150A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5715

From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>

Add support to enable/disable IOPF feature. So that PRI capable device
can make use of page fault handler in SVA mode.

Note that enable_feature(IOPF) just returns success, as this interface
is going away. IOPF handler will be setup in PASID bind path. Following
patch will add this support.

Also add IOMMU_IOPF as dependency to AMD_IOMMU driver.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Co-developed-by: Vasant Hegde <vasant.hegde@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/Kconfig     |  1 +
 drivers/iommu/amd/amd_iommu.h |  2 ++
 drivers/iommu/amd/iommu.c     |  8 +++--
 drivers/iommu/amd/ppr.c       | 57 +++++++++++++++++++++++++++++++++++
 4 files changed, 66 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/amd/Kconfig b/drivers/iommu/amd/Kconfig
index 443b2c13c37b..d563f6d496ca 100644
--- a/drivers/iommu/amd/Kconfig
+++ b/drivers/iommu/amd/Kconfig
@@ -10,6 +10,7 @@ config AMD_IOMMU
 	select IOMMU_API
 	select IOMMU_IOVA
 	select IOMMU_IO_PGTABLE
+	select IOMMU_IOPF
 	select IOMMUFD_DRIVER if IOMMUFD
 	depends on X86_64 && PCI && ACPI && HAVE_CMPXCHG_DOUBLE
 	help
diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index ce23ce1a1a16..d5e6315ef9dd 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -54,6 +54,8 @@ int amd_iommu_iopf_remove_device(struct amd_iommu *iommu, struct device *dev);
 int amd_iommu_page_response(struct device *dev,
 			    struct iopf_fault *evt,
 			    struct iommu_page_response *resp);
+int amd_iommu_iopf_enable_device(struct device *dev);
+int amd_iommu_iopf_disable_device(struct device *dev);
 
 struct amd_iommu *get_amd_iommu(unsigned int idx);
 u8 amd_iommu_pc_get_max_banks(unsigned int idx);
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index d300456e8984..36a5458a7946 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2749,9 +2749,11 @@ static const struct iommu_dirty_ops amd_dirty_ops = {
 static int amd_iommu_dev_enable_feature(struct device *dev,
 					enum iommu_dev_features feat)
 {
-	int ret;
+	int ret = 0;
 
 	switch (feat) {
+	case IOMMU_DEV_FEAT_IOPF:
+		break;
 	default:
 		ret = -EINVAL;
 		break;
@@ -2762,9 +2764,11 @@ static int amd_iommu_dev_enable_feature(struct device *dev,
 static int amd_iommu_dev_disable_feature(struct device *dev,
 					 enum iommu_dev_features feat)
 {
-	int ret;
+	int ret = 0;
 
 	switch (feat) {
+	case IOMMU_DEV_FEAT_IOPF:
+		break;
 	default:
 		ret = -EINVAL;
 		break;
diff --git a/drivers/iommu/amd/ppr.c b/drivers/iommu/amd/ppr.c
index 02d912b9f618..e1b3d579772f 100644
--- a/drivers/iommu/amd/ppr.c
+++ b/drivers/iommu/amd/ppr.c
@@ -295,3 +295,60 @@ int amd_iommu_iopf_remove_device(struct amd_iommu *iommu, struct device *dev)
 	raw_spin_unlock_irqrestore(&iommu->lock, flags);
 	return 0;
 }
+
+static int iopf_update_device(struct device *dev, bool enable)
+{
+	struct pci_dev *pdev = dev_is_pci(dev) ? to_pci_dev(dev) : NULL;
+	struct amd_iommu *iommu = get_amd_iommu_from_dev(dev);
+	struct iommu_dev_data *dev_data = dev_iommu_priv_get(dev);
+	struct protection_domain *pdom = dev_data->domain;
+	int ret = 0;
+
+	if (!pdev || !pdom)
+		return -EINVAL;
+
+	spin_lock(&dev_data->lock);
+
+	if (enable) {
+		if (dev_data->ppr)
+			goto out;
+
+		ret = amd_iommu_iopf_add_device(iommu, dev);
+		if (ret)
+			goto out;
+
+		dev_data->ppr = true;
+	} else {
+		ret = amd_iommu_iopf_remove_device(iommu, dev);
+		dev_data->ppr = false;
+	}
+
+	amd_iommu_dev_update_dte(dev_data, true);
+
+out:
+	spin_unlock(&dev_data->lock);
+	return ret;
+}
+
+int amd_iommu_iopf_enable_device(struct device *dev)
+{
+	struct iommu_dev_data *dev_data = dev_iommu_priv_get(dev);
+
+	if (!dev_data)
+		return -EINVAL;
+
+	if (!dev_data->ats_enabled || !dev_data->pri_enabled)
+		return -EINVAL;
+
+	return iopf_update_device(dev, true);
+}
+
+int amd_iommu_iopf_disable_device(struct device *dev)
+{
+	struct iommu_dev_data *dev_data = dev_iommu_priv_get(dev);
+
+	if (!dev_data || !dev_data->pri_enabled)
+		return -EINVAL;
+
+	return iopf_update_device(dev, false);
+}
-- 
2.31.1

