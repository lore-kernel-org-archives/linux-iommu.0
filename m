Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2056.outbound.protection.outlook.com [40.107.92.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88EC0C8F8
	for <iommu@lists.linux.dev>; Mon, 11 Sep 2023 12:14:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zg9NTPov8L56TCyvdsyQAxEJNBjO4jJ6asE3RXfxmy5q+aUBiOAyJF6YQ2zW4Wlyh8mleZH6yJOv3HXWQuRfB/76GxSZISAfAKHsLo03czpbgJDHnWHd4YMLiq5FpwUe6pPknGoMCFHFv3Aalkj37baECvw5/2QZ1F5LxVavbCIhyIxzJLiR2h/ieeHExWbymiboTi8PN9RZg81Y23w84eAjDge0BLo67m49l53UsbkMBiYJojZYHsjZ+54rk3Uvp6r8xPw2y5k0DtpdiQ8jUZEaIa8an8AtfYRqrC4qakjR4YiO6rHa7p5x/qS/maC68gwqTqDTfQBoZoWNaFeLEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ap/xNHSbWol1KQi2oohGN4WJKWxNgZCmr5P62X9Nags=;
 b=j5gMqNky3VNU99gKSDB0aGNZ+01FK287gKTjWoYEILFJ5/gES6RRGOEGT3mMk/8uMe7y6Cv1jtMYn0PSxAingTDHQmNHGNhwYJSmKccrhbPHzoG1pXAAeB3bJN2nKKG8HW49nDphNgbWFs/ANvfoa40H+8LqMIfRZ+VpUsduLuIZVhmL4BeQQIuJ4TrkwF2XbnvetsXKJ27exPnpNVAyVEyu3F9XrdGN90zb/ON0Wl0HYgUYHvUEFe0XI4rt7UoejHNFHJBN8FcBZdXp6T9qR8qHWgzoupfL0BLOaRQq4TE2LuHfuwCCUGQUS7inXIAdVGyje0zIxLYoi5xvRW4kEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ap/xNHSbWol1KQi2oohGN4WJKWxNgZCmr5P62X9Nags=;
 b=R+qzWOD7NbznZdfOsqqDtTmwM6KDIqFzbw/uCvZXnMragVDIFYo987TSqd7lO8yZ27B5EaPu6y0SPA/tbkEKxnpT0MfS+O9a2m6+oox0NayJI7za2c9polwqCu5hqRBWR4VgzSf6BtV0hgrHgcp1SulNpuocDLXL0SQ72QYwv1k=
Received: from SA0PR11CA0013.namprd11.prod.outlook.com (2603:10b6:806:d3::18)
 by SJ0PR12MB8615.namprd12.prod.outlook.com (2603:10b6:a03:484::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.36; Mon, 11 Sep
 2023 12:13:59 +0000
Received: from SN1PEPF0002529E.namprd05.prod.outlook.com
 (2603:10b6:806:d3:cafe::1b) by SA0PR11CA0013.outlook.office365.com
 (2603:10b6:806:d3::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.35 via Frontend
 Transport; Mon, 11 Sep 2023 12:13:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002529E.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.17 via Frontend Transport; Mon, 11 Sep 2023 12:13:59 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 11 Sep
 2023 07:13:56 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v2 08/11] iommu/amd: Add support for page response
Date: Mon, 11 Sep 2023 12:10:43 +0000
Message-ID: <20230911121046.1025732-9-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230911121046.1025732-1-vasant.hegde@amd.com>
References: <20230911121046.1025732-1-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529E:EE_|SJ0PR12MB8615:EE_
X-MS-Office365-Filtering-Correlation-Id: b21902e5-5b36-49d7-3a4a-08dbb2c09466
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	04YpjZxgDQNvBfjUUcGERWIuIdEt87Yl2KWeiCkKTc47I6fguVb/PHH6yA/i2TeE//xo+rf6DJOQRpyUPKbLIhE6UKBHhpMjHpdytTGYVBmdJ8U9wqMGGdMdB8zsjRfcS+5V+vD3gGmJSAy2Iqejk4/aIENNiNWPmz+HHXwS7GrNk8lpapSo523NChL7gbTDOrNZcDFbhELlt/c29oVfDL3y/kIhSdwoxLL6UGravQ0TRYN73FTvZYUxAxqF2lOO6fDshdJi8eOmA6b/Oo6AfPqGC/5D2zUsTZBqtQwn1L2UTs94mHAjp1U1BdE4zt/3ppqjt/hqcVg40D1U5kdJR+5Udgl2EPr/dD4y2QoIWberE5F4ZcPFjAjkU4/b5tLFIfzEXKwzTlzEm1XbONIaxn38SowbC73oi+/HfTUHhTXsP/HDEjPQ8ByOZcV3UB37K9P0nNgFzkEKAYNY7DASZRtzRIY7Um02IMDkPlNCgQ7MQzbAv6liwOtxQw/EqS3OXP183bs0pfKtSBBmm5zsX7qF0lOor/EYmi6km2HOcGtyFh7YyBMrSnDDY7rYcpzZBKhH+QJ6toySlCFuuemu5rziyztr9vW4nm2Q58Nx/nAUM38EVLkvnJQGORHFROgm7O+oRSJQng9QMK4jeMr3xCbB809R1Qe00qgrwqXvBploodGgund2sBQB3CPD9LRL3ByFMF/toeC+R9XBV/FLtjUC+UrYGvwuISvN6cTmqk8YJhgSEnLO+BdfwQrOd/LBCmPbcK9Qnjwhrxd/IcSlcw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(136003)(346002)(39860400002)(376002)(451199024)(186009)(1800799009)(82310400011)(46966006)(40470700004)(36840700001)(5660300002)(70206006)(7696005)(8676002)(8936002)(44832011)(41300700001)(70586007)(4326008)(54906003)(2906002)(478600001)(6666004)(316002)(336012)(26005)(16526019)(426003)(2616005)(1076003)(47076005)(36860700001)(83380400001)(81166007)(110136005)(82740400003)(356005)(40460700003)(86362001)(40480700001)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2023 12:13:59.5624
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b21902e5-5b36-49d7-3a4a-08dbb2c09466
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002529E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8615

From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>

This generates AMD IOMMU COMPLETE_PPR_REQUEST for the specified device
with the specified PRI Response Code.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Wei Huang <wei.huang2@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/amd_iommu.h |  3 +++
 drivers/iommu/amd/iommu.c     |  1 +
 drivers/iommu/amd/ppr.c       | 15 +++++++++++++++
 3 files changed, 19 insertions(+)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index a85503259727..bfd9f705c0cc 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -55,6 +55,9 @@ void amd_iommu_gcr3_uninit(struct iommu_dev_data *dev_data);
 /* IOPF */
 int amd_iommu_iopf_init(struct amd_iommu *iommu);
 void amd_iommu_iopf_uninit(struct amd_iommu *iommu);
+int amd_iommu_page_response(struct device *dev,
+			    struct iopf_fault *evt,
+			    struct iommu_page_response *resp);
 
 struct amd_iommu *get_amd_iommu(unsigned int idx);
 u8 amd_iommu_pc_get_max_banks(unsigned int idx);
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index e11a705df665..646873e3790a 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2610,6 +2610,7 @@ const struct iommu_ops amd_iommu_ops = {
 	.dev_enable_feat = amd_iommu_dev_enable_feature,
 	.dev_disable_feat = amd_iommu_dev_disable_feature,
 	.remove_dev_pasid = amd_iommu_remove_dev_pasid,
+	.page_response = amd_iommu_page_response,
 	.default_domain_ops = &(const struct iommu_domain_ops) {
 		.attach_dev	= amd_iommu_attach_device,
 		.map_pages	= amd_iommu_map_pages,
diff --git a/drivers/iommu/amd/ppr.c b/drivers/iommu/amd/ppr.c
index 9816d7dbcbf0..2a0414e3d689 100644
--- a/drivers/iommu/amd/ppr.c
+++ b/drivers/iommu/amd/ppr.c
@@ -152,3 +152,18 @@ void amd_iommu_iopf_uninit(struct amd_iommu *iommu)
 
 	raw_spin_unlock_irqrestore(&iommu->lock, flags);
 }
+
+int amd_iommu_page_response(struct device *dev,
+			    struct iopf_fault *evt,
+			    struct iommu_page_response *resp)
+{
+	struct pci_dev *pdev;
+
+	if (!dev || !dev_is_pci(dev))
+		return -ENODEV;
+
+	pdev = to_pci_dev(dev);
+
+	return amd_iommu_complete_ppr(pdev, resp->pasid, resp->code,
+				      resp->grpid);
+}
-- 
2.31.1

