Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2080.outbound.protection.outlook.com [40.107.94.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3A2F7F
	for <iommu@lists.linux.dev>; Mon, 12 Sep 2022 06:34:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KMfBKx++rBKW8N8Un2Rn3CTUEmLUobRzhDms32f/cxmf8OdVjqlGFJdJlmOgGZXWI9BdXFgOAxqABYpaI+Go//IvxmAD2l+qzir5fR0G+zSEGOqVEmX0iv/tzLBSbXkrT/xKxJSa/cNVno9hPrH0PYGPh1QkBl3GpIjYaes7zfoif/8q43cba8kd5Ar855Y9ohdRZhJAtQEprlg8U3eVadhh6fIlrNLJ6m9aCoMGRB/74Wid+DKA3BM8rLIUAfHqWO3rFYhhqOD7RokqshJafDvMKzXQ1/EmNR+Wq5JFF1rQ9Uj32KJ4CpYhrldlvv4bQGqVKlmDIR3S6icERWQSnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GB5+gpFd7fWKv2I1VWFJcrarpX16OopnKnNX2xdDZpk=;
 b=I7kAl6qHViR0xU7q7VDQWmsX/jTjy+vATZ/WC5C9hCMyibICvb7EXSMXwt8t7/pHyDyA+CPzimICHbhLAGVpnvYpfR3WyC136YP1qOkXbQ4Xd2zNQtYmAgRTLAnCqbWCRzoyaISRlHYFxu1O/2u9HhwZRqHEI91zc6MrhqcCe4g3in7M30ADT/yDuD8RW4aSaLgGZggkjso76KYpKs4f9+WDY9LBIGbZNQGy/zXdSePmzIMOGoS4ohRVoV83r+igZ7FAt2Jg709GLA0OaFnSWYewNJ15I6BI0ulnIycRPMsailxNaNekJ4ugCNwdDKe2RqDNkhZz53kxSFRQ+AHKvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GB5+gpFd7fWKv2I1VWFJcrarpX16OopnKnNX2xdDZpk=;
 b=oUqpgFWiKF0Odq9ju/DbQj9pgWDKA0pzgGMrNiV/GY0COnBbA80IxfbHG/yPV2OFEtK4bOuIPp3P37N4Zc7FiZo7OBHpxHaUeri9DuARZYXvmu8O/RrLsbdiXMpdOt3JWUtU96XvCNdzTEJ/7Dgy/aNNH8YJCV+Pd/AGG8uSzfw=
Received: from MW3PR05CA0006.namprd05.prod.outlook.com (2603:10b6:303:2b::11)
 by PH7PR12MB6395.namprd12.prod.outlook.com (2603:10b6:510:1fd::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Mon, 12 Sep
 2022 06:34:42 +0000
Received: from CO1NAM11FT099.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:2b:cafe::e8) by MW3PR05CA0006.outlook.office365.com
 (2603:10b6:303:2b::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.11 via Frontend
 Transport; Mon, 12 Sep 2022 06:34:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT099.mail.protection.outlook.com (10.13.175.171) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5612.13 via Frontend Transport; Mon, 12 Sep 2022 06:34:41 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 12 Sep
 2022 01:34:38 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <robin.murphy@arm.com>, <suravee.suthikulpanit@amd.com>, Vasant Hegde
	<vasant.hegde@amd.com>
Subject: [PATCH 5/5] iommu/amd: Fix sparse warning
Date: Mon, 12 Sep 2022 06:32:48 +0000
Message-ID: <20220912063248.7909-6-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220912063248.7909-1-vasant.hegde@amd.com>
References: <20220912063248.7909-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1NAM11FT099:EE_|PH7PR12MB6395:EE_
X-MS-Office365-Filtering-Correlation-Id: 95bd578c-781a-484e-6133-08da9488dfbb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	t56hgawZj2DTR5VzeaxKzXQTUCjXSVRXDkdxvLtEl2wc9E3Q05bGvPr6XIZna2dWUvEtwITroIEPyfJW8adB3DXE0qpf5gz2mv6N7+pd2lr+tevufPVSIfMH8+Qmf49Ze/qFP6IIRjG6CyZF1TQq66gjs/OaX5TIFn9ermdu2Dh7o1DxZIJYbMHJZiy12wSAgQiviNzFSYJJP+nv8xxVCD9mFsxCUxQmJJpNQz6NGe8LOwe9kdFfVQYwRCFDVDTvwrnNyXxXRLFuW00U5DHmLNo9wDc4B4ltbv2Mah3j9ycCHf9LBa5nZRvMBcNYVt3Z6SjBffp38miCCCQk/j78m47UWPgnAWtaK0nny8G7QQ+Jej+1P6UhTqcOi7JLtYx1nV7VpcORvpZsC1X8IZD6lKoN/mNkelT8YfJV/nrVzAftrVglOHcUoDVVoViV2Y9YeX1WyPjMM1ICjx4a+ySlXsjyv8WHQQOO5L+JWGq0pjQb35qRDVwgvmpS90yKMs82RiXzYVKFzTg+6VH2W6NPPBwiOZ7yz5y3oZ8vnIhfT4MExIzv7iAC6veRrAG1+zZYo9yUbd/GIYoQ8s8RGAWiWrPcSgA5s+8NCnA2hWr3h9MsaG5mek5Zk0SB6eWOJHbOzCck7C6OPgCnbXxVlLNNL/rVc57ruFmMJ/pMZRkh2Wn3VVdIqCce8/sQKWrIjM7RP62tYx7RQNEPJVcK8C3etBrL8/hsxgJxZ8WuzbJIVjkxFUhJbvb8/qlwlWZ1cvrgVSp6zkAEwuvz+8x7FAz1iSkralsAWcIMwWlrXBbyFR9+3o5DUj4/TKimd0LYDU/T
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(136003)(39860400002)(346002)(396003)(376002)(46966006)(36840700001)(40470700004)(4326008)(44832011)(8676002)(86362001)(7696005)(26005)(2906002)(83380400001)(2616005)(186003)(336012)(16526019)(1076003)(8936002)(426003)(6666004)(5660300002)(47076005)(40460700003)(41300700001)(82310400005)(110136005)(81166007)(54906003)(82740400003)(356005)(40480700001)(36860700001)(478600001)(70206006)(70586007)(316002)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2022 06:34:41.4533
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 95bd578c-781a-484e-6133-08da9488dfbb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1NAM11FT099.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6395

CHECK   drivers/iommu/amd/iommu.c
drivers/iommu/amd/iommu.c:73:24: warning: symbol 'amd_iommu_ops' was not declared. Should it be static?

Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/amd_iommu_types.h | 2 ++
 drivers/iommu/amd/init.c            | 2 --
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 1beed57fc35d..1d0a70c85333 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -461,6 +461,8 @@ struct irq_remap_table {
 /* Interrupt remapping feature used? */
 extern bool amd_iommu_irq_remap;
 
+extern const struct iommu_ops amd_iommu_ops;
+
 /* IVRS indicates that pre-boot remapping was enabled */
 extern bool amdr_ivrs_remap_support;
 
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 688cf8387b0b..a515e837adf1 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -95,8 +95,6 @@
  * out of it.
  */
 
-extern const struct iommu_ops amd_iommu_ops;
-
 /*
  * structure describing one IOMMU in the ACPI table. Typically followed by one
  * or more ivhd_entrys.
-- 
2.31.1

