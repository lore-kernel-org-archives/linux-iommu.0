Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2059.outbound.protection.outlook.com [40.107.243.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C16D211CA9
	for <iommu@lists.linux.dev>; Thu, 18 Jan 2024 07:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705563349; cv=fail; b=jAgjpQmPEDx6kVdop16zrimPdUd+7GLc/iH8b14s+CNEbN7phv4sMiw4HJHVRZSp6wb9n2gE3aBqFG6d/SYj/D/IRouMGw7oSClYE0SYB4QRBQ9SUEWu3+LZ8sLQ11Yqlr4pdi8+VP/wS+7z/D0Aqgx/5RvbUBIHY5CHm0g5d7M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705563349; c=relaxed/simple;
	bh=8mtDGF09Q0w9p/073mKHlxxFawmTm+9z5EDycQ/XzZU=;
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped; b=suhDQXtNJOv7O6l+opO3JHTTbP/E2kgNK4OHEt3BsmxSRWAQcwIHgqxOwaOPEoczVsZcHMoMvFDPiRazjwJxg6K5wSXjt+VQV0RhUO+Kvj3ndEmkvY6W3nXrQtCsmpceD2HS2QW4C0WAyCfLifOJa3aK438gfrX2CcKS5gkK1Dg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=WsnzQiQS; arc=fail smtp.client-ip=40.107.243.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="WsnzQiQS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=drO8ntI24+88EJqNue7eOMv77FkOZlPNwb7EUdVyfOPLB1H/XDpS65arCB+zeR/Oaur7suOh3TsqwOp4ibzzSDJvcryL2KMGc8JcPsSq3h3GAFj6AmLtocXPEa3rtcgsvIr6wy/AQxQyZOeTb3X4jFMH5ExmWDVqV0TfkWrEYmfIX/RU2FQMAiwqMVSoLTV97kHgb6TQiAgcdK2l64jvQpPzTXNBCF9n4/uY65kDjRu+31yDByDYtZNBavCqePRbK3fXCoyxjdbJkAh/1yVX2ff1Aqketb1XvTClafNKJ5EQzhCH+syPr4GiRi03ONlEMTX5/aGhepOUMpwgZA7Dqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T15A6g/0hFhDMB/rdz1yvi4xluUXg5Cm8/9JHcSAKRA=;
 b=mvqZ8ALMLS3ecNdxt25xBXXGRNtNy5JGxfeUCR0/NMfUTIfTPZKXcjNZ9I0cX0AYsTKPR4hInOKHDABL7sKl+S+DF5dayI9jUST2/QED5+v6PLoouUVyl/tqO6K7DS1HYOi708Qi1/WE5trAkFQpuoQ0HCxZCpHOfmhWcV3uG2ot9bQI0tBmU0f5ofcdUBPpFNvu/DD3PlaTFAS2zhvmUdEI6pmcgUmJrLhx0BsxQSfapGU5TzA6cj2P3bzhCnMohVRy3eJIhaJUzB7IcDic5LRVxdEBpDUv7flfh+WV9l29z6PjooHMCi15/wnvSQf1kbhc8vcWBHwS1oFVgsKZag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T15A6g/0hFhDMB/rdz1yvi4xluUXg5Cm8/9JHcSAKRA=;
 b=WsnzQiQSvb5R0qpmhFGe2koEoxL88u2YeUuEmSqA+Whry361uKEb2hoLrhbvdiogLzkhwntlqHREqSANM1WFpoevX7mv8Seg+fipIiouqkAt+3aMOx5ZVAKgNaohMNtdfYGt/2Q3GGdEGClIw+84rfdirKmsHycNoNalpHqS0ic=
Received: from BL1P221CA0029.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:2c5::25)
 by DM4PR12MB5939.namprd12.prod.outlook.com (2603:10b6:8:6a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24; Thu, 18 Jan
 2024 07:35:44 +0000
Received: from BL02EPF0001A0FD.namprd03.prod.outlook.com
 (2603:10b6:208:2c5:cafe::78) by BL1P221CA0029.outlook.office365.com
 (2603:10b6:208:2c5::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24 via Frontend
 Transport; Thu, 18 Jan 2024 07:35:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A0FD.mail.protection.outlook.com (10.167.242.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.16 via Frontend Transport; Thu, 18 Jan 2024 07:35:43 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 18 Jan
 2024 01:35:35 -0600
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v5 03/14] iommu/amd: Add support for enabling/disabling IOMMU features
Date: Thu, 18 Jan 2024 07:33:28 +0000
Message-ID: <20240118073339.6978-4-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FD:EE_|DM4PR12MB5939:EE_
X-MS-Office365-Filtering-Correlation-Id: 123831cb-bb9e-4cf4-cbf6-08dc17f8143b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	NhUTkTEmDDw6lU1Wve3BqRgmW1/9DAxmT7s6QcXsfSrpTK999DCUGfUD8SSn0WPNNuEdued0jT719sQ+AU/v6oZHi3bi2WZ3xUJE2bsuSNRfLw3g5uvxChIxGzoCqKZlHPK/FGF2qqIUzeoS2iLeTdnW1pIVkHmshd6D/ZtgTf/tFjW9QD2SoaPorAumcgVhGJH7/E7AHvqEpGX+kd9T/f9QZ7eYJzf94ygtC+XMXxsbSClcAcNRi1g2iBlg1t8uqJUz1nHUXdO+KNbVbCjgYuyTMpyjLd1ZC+3AgEdkfKPel5tAmBLoWeeZOLEUyex/x32OOizv11btoJP19Luk9FxVqFl9DiLq7Q2PrkFvLWEAur4a6ewhnGA0X1VqbRHSL5rDEsNLhsCMwTCvFH6q8FBaqWM3/4Z0B/EoYt1u5wumxGQWZ60Cud3Vaw68O/wM40SXnw080aJLldYpMR/Bqag3f3fpkj8tq0VZI0HodSaXBo7b7wXtwgRDEd6LMdSzL+tfLHZvMJhYoXrSMj7gzy6TJuFcxwsak4v1qSRN42NFEl8QPL03JOGOrfIFmEssrocrFJ3PYwyTsIpF6ZlyiOu+qm+bEk7peEAnu4krXys0co1uXLTXejCaiedJZOXeGuUdBhSacn7sOrqO4IvUa5aaG69SkgV9YlixGlJVsUAwnJrnpXBU5ePc9/m5UGjFneVti7kWw/EAI8cPjfZgE/SVUEo4HOoD7515nGIokk17cW1srl4C8HSG1vKc0i95P5g5rQ6sYeWskbxRsgchSw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(376002)(39860400002)(136003)(346002)(230922051799003)(451199024)(1800799012)(82310400011)(64100799003)(186009)(46966006)(40470700004)(36840700001)(16526019)(2616005)(1076003)(6666004)(26005)(336012)(7696005)(426003)(36860700001)(47076005)(83380400001)(5660300002)(44832011)(4326008)(8936002)(2906002)(8676002)(41300700001)(478600001)(316002)(70206006)(70586007)(110136005)(54906003)(36756003)(86362001)(356005)(81166007)(82740400003)(40480700001)(40460700003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2024 07:35:43.8090
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 123831cb-bb9e-4cf4-cbf6-08dc17f8143b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0FD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5939

From: Wei Huang <wei.huang2@amd.com>

Add support for struct iommu_ops.dev_{enable/disable}_feat. Please note
that the empty feature switches will be populated by subsequent patches.

Signed-off-by: Wei Huang <wei.huang2@amd.com>
Co-developed-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/amd/iommu.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 68fd1251b981..ca4dd90c875d 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2799,6 +2799,32 @@ static const struct iommu_dirty_ops amd_dirty_ops = {
 	.read_and_clear_dirty = amd_iommu_read_and_clear_dirty,
 };
 
+static int amd_iommu_dev_enable_feature(struct device *dev,
+					enum iommu_dev_features feat)
+{
+	int ret;
+
+	switch (feat) {
+	default:
+		ret = -EINVAL;
+		break;
+	}
+	return ret;
+}
+
+static int amd_iommu_dev_disable_feature(struct device *dev,
+					 enum iommu_dev_features feat)
+{
+	int ret;
+
+	switch (feat) {
+	default:
+		ret = -EINVAL;
+		break;
+	}
+	return ret;
+}
+
 const struct iommu_ops amd_iommu_ops = {
 	.capable = amd_iommu_capable,
 	.domain_alloc = amd_iommu_domain_alloc,
@@ -2811,6 +2837,8 @@ const struct iommu_ops amd_iommu_ops = {
 	.is_attach_deferred = amd_iommu_is_attach_deferred,
 	.pgsize_bitmap	= AMD_IOMMU_PGSIZES,
 	.def_domain_type = amd_iommu_def_domain_type,
+	.dev_enable_feat = amd_iommu_dev_enable_feature,
+	.dev_disable_feat = amd_iommu_dev_disable_feature,
 	.default_domain_ops = &(const struct iommu_domain_ops) {
 		.attach_dev	= amd_iommu_attach_device,
 		.map_pages	= amd_iommu_map_pages,
-- 
2.31.1

