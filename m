Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2053.outbound.protection.outlook.com [40.107.220.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 747E920B01
	for <iommu@lists.linux.dev>; Mon, 16 Oct 2023 10:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="qXuX9YV/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YobKVnt8+m73UZF1fFoY80/XdEIgoZBeFKdmRiwkt9l7D7YdNhbQm6XfNNhHDtOKqKPPPb/el2uFMrLNq49eWeXFO2K0Zj+vblhXrd0MCZYza0ubWDOtQKUjRJcb4i3bm5qlhLT7WwivJJPPGWxsphf7rtj5h1GDyWlVbOIhvLOwNKLv55FnVbmomEyJF9BTr85Qu1gJjB04BekvhPzUk7Lkmp/t1acuYmA6x/U+6n/ZZYw9vdeq50DBR1nd/b5ko8UQ7r9GRdOGkHWTdUEv8kSQxrNXzTye2RhbF7Au4uKlwOQcsA3A5gmB1x4+hUTjT5VAA2iwyhvkUZsnqNrfBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lvEaiHb2LMJ3pv5FP0sey8H/BqILeIVZsCdnutxCAys=;
 b=k2e2kgHfPiqivB1p7NqAxTcMLuOs3s5L0J0L60FDfB4R/s4kFg9UPcK6jHqpUHOwmFCxrU6GM9kleN5hTLV1ITgO45DcHDYOnANM6dYDlWTPWpwTpbofXmiF/XXGD5pKO6Wp61NosEGnr385gl4sZ15GvHHT8DItfuLuW9T1Z36xUmiVUp9iXSCKVg079frXVFP+1Ws4ESy7KZVgv2IzKZJWZa43etI8Os1E5x2Bipf9qlidAvlTFqF6WLwFqXfeuqvgz4omt9g/3iT0rsJYVqpJJyfOhcGunzQWPQ2n1LCF7Yd8EKTaow6ZV2YmYf4WM/2QdgLAX+H9VNMmsV4S4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lvEaiHb2LMJ3pv5FP0sey8H/BqILeIVZsCdnutxCAys=;
 b=qXuX9YV/181ehCgLO1U9JKCIy26PjVIiNUSk3LkmHFvX9iJfqubtaDNnqQdbbIzUCAf0b3FkxhV0wOn2dVfcKiEagnV1BwcuZXm+9b2s6y0d3hyChEaT2chO+vlU5BA2bLilUpjb1ZAPOn9ixTr/rCxbkllEaAFuPGkogYoJRtI=
Received: from MN2PR15CA0057.namprd15.prod.outlook.com (2603:10b6:208:237::26)
 by MN2PR12MB4584.namprd12.prod.outlook.com (2603:10b6:208:24e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36; Mon, 16 Oct
 2023 10:45:53 +0000
Received: from MN1PEPF0000F0DE.namprd04.prod.outlook.com
 (2603:10b6:208:237:cafe::6a) by MN2PR15CA0057.outlook.office365.com
 (2603:10b6:208:237::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35 via Frontend
 Transport; Mon, 16 Oct 2023 10:45:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0DE.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Mon, 16 Oct 2023 10:45:53 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 16 Oct
 2023 05:45:50 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v3 04/12] iommu/amd: Add support for enabling/disabling IOMMU features
Date: Mon, 16 Oct 2023 10:43:43 +0000
Message-ID: <20231016104351.5749-5-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231016104351.5749-1-vasant.hegde@amd.com>
References: <20231016104351.5749-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0DE:EE_|MN2PR12MB4584:EE_
X-MS-Office365-Filtering-Correlation-Id: 13e08bfe-4464-4b73-287d-08dbce3511d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	mIAnuwojLauN1qjIfcIVwbhJrFu9aZHxVKl6i/GrwGuFdIdta9x47oPqJgy7lw4mbC4If+RtnucWQLXY1zIWfG7b8iArxsBR6GR46yZguuJ5wBC69gQJErWqJVHii8ul1bG3332k/kdBzRPxrW1I/ZoPu9kyhlOn3I8Ik7b4Q/iS/+RqNNVJvfN5PeENaUIP7unarp02JAfegQ8vh7I0Idyja75NQuz82sQ55QdJ1Uc9qbQo+pkf4cnmHLdd7Ll8BDlWTLkvkjejuGUhE+z6wdeUH6XuVHNykcXnnZPoYbZ8DzDCiIJXyPM6FjTIYY46u8HEkYdsF1dxuOaNoupPUsaYlTEEqW7PMgkrqsXsPjPneL+PC98ngN6Vy8BYTiY239pey6JALVkYsBC4fojFiYxW1K/k2a7l04E0f5PFVZK4xSA+to3HrKQnUV2TJ9fZJKybAHcr9fNysi/YbgyTj5bUfK4LwiKPsPYFLVEm6FG8kvL/Z2Z5FHSnRgQV98XMwf1NLU30u6FH0C7CLyChzzLk2jA8BnONp2+bMSSBCCv1QTh66XAnNTPwcR/foB8pZjbvit4XSqmP7G6sogAcjVV+GDF6cW0dG8G37QT9ae/AKAu86+dp91PkAWODtjThCings8zCN4Kzj3fodpJAe3vaxJg2Wj9Mkbm0FTeKZsyf1xFBi+dBTCePtpNQPUNRwwWKR1Khp9To8dA9jZqDdfoWpg7OliG3uuahygjaP7Jinon0j9CMz0+yqiqcVkJMsBT4tkra3K+EUhJlnGdGqQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(346002)(39860400002)(396003)(376002)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(82310400011)(36840700001)(40470700004)(46966006)(86362001)(36756003)(40480700001)(40460700003)(2906002)(478600001)(7696005)(41300700001)(44832011)(5660300002)(81166007)(356005)(82740400003)(6666004)(16526019)(2616005)(36860700001)(1076003)(26005)(336012)(426003)(110136005)(70206006)(70586007)(54906003)(316002)(8676002)(8936002)(4326008)(47076005)(83380400001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2023 10:45:53.0490
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 13e08bfe-4464-4b73-287d-08dbce3511d7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0DE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4584

From: Wei Huang <wei.huang2@amd.com>

Add support for struct iommu_ops.dev_{enable/disable}_feat. Please note
that the empty feature switches will be populated by subsequent patches.

Signed-off-by: Wei Huang <wei.huang2@amd.com>
Co-developed-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/iommu.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 39acf98e45dd..22e0703cb500 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2774,6 +2774,32 @@ static bool amd_iommu_enforce_cache_coherency(struct iommu_domain *domain)
 	return true;
 }
 
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
@@ -2785,6 +2811,8 @@ const struct iommu_ops amd_iommu_ops = {
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

