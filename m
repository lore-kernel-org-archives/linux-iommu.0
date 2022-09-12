Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam07on2054.outbound.protection.outlook.com [40.107.212.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29E2A7F
	for <iommu@lists.linux.dev>; Mon, 12 Sep 2022 06:34:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QHwCTEp9TN6J4p9pOWLELdm6efNGBvYSlKaZ+CEuc68E86YlQ3tOi+RwEDDivjXp/7iP5jFB+pCaLcWE0JBvK0xYmzXjl6otjXhrvYdv3BYoTdiFKQIuS8Lf8+bitnAHKTIosx+CE2hQmoLBrKZSkUKrH/eUgSCk0zoQ0v5MQbBvmZevVG+u4QoVWiMI7/VZsoW5aK01NaxJ9Jeoy+AizMwjEYOLINcV4NHztl3aj2Seo94HL1EFJIJm8cB6np9q8AvBxV4bWKoI3fg29jJtSccBK9LAA4fTOfxUQRB8DMcumxT7/NnxmXLHu8DVgpLPu06P3f632ofNvOVXNGX4FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lX7tIBRnoTc+rEkIJRccahxxeC7Gw2sQMqiaWmUMUNs=;
 b=XVa3tUBuJNv0QrXF77DefDq63RRF2BezhIre7HiphB19jZy/VXg8CHmpzPB6XyPU96TPsv6SFHz78hAEupuxZJ8EEJ/22NjUUhINbP27+37aqEGyUMjzh1KzN/XV3HE+xSFQ2DeFoeVv/d3NNjw/6Xy4atgT/2+5wnZZHjRYNL8TNTKaQjjfv4eON0pQmBVlxOLANpr80p3WdUrfO1iXCopOMCAmLyT/zlTOGRJH9a3fBHz/msvgIDPZ0h55FlPws8dJ/G7ME6c4IUX+9q7QGACAEI8p+X8h7nIuyUfxKawl7WuQc0Lm1KM7tMFdDiVRNlor/8PykxJXYGmR12LsFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lX7tIBRnoTc+rEkIJRccahxxeC7Gw2sQMqiaWmUMUNs=;
 b=m+I1PeKe0LMWbuNszMVKWu89QaoCGge26fcdmKrgA1xRGu2XwQB+srci+R8cn4HHd5uZjcs5b6b7zDmzQsS3BdBtrTkUSeTd/7kgoqu/aSW5yJWVDZ8rBkBDqxHGPdik3XYLkI64GJqF4N6CTd5HpxWbHS370JdQ8T5VFMA2Ew4=
Received: from MW4P221CA0028.NAMP221.PROD.OUTLOOK.COM (2603:10b6:303:8b::33)
 by DS0PR12MB7631.namprd12.prod.outlook.com (2603:10b6:8:11e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.19; Mon, 12 Sep
 2022 06:34:28 +0000
Received: from CO1NAM11FT097.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8b:cafe::93) by MW4P221CA0028.outlook.office365.com
 (2603:10b6:303:8b::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14 via Frontend
 Transport; Mon, 12 Sep 2022 06:34:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT097.mail.protection.outlook.com (10.13.175.185) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5612.13 via Frontend Transport; Mon, 12 Sep 2022 06:34:28 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 12 Sep
 2022 01:34:23 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <robin.murphy@arm.com>, <suravee.suthikulpanit@amd.com>, Vasant Hegde
	<vasant.hegde@amd.com>
Subject: [PATCH 4/5] iommu/amd: Remove outdated comment
Date: Mon, 12 Sep 2022 06:32:47 +0000
Message-ID: <20220912063248.7909-5-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1NAM11FT097:EE_|DS0PR12MB7631:EE_
X-MS-Office365-Filtering-Correlation-Id: 835edceb-6a2e-40f5-3ff1-08da9488d7c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	USJ1nH4AXEasQ8hKhWMafienYv98hUuku2iQGCuQZZeb6gmIAZiObVg4Sb6tXkSStFBlNLD6SQSbL0g/sR+zNvwy/FZWvQsC9yJo4Nfhn7uMWZYs+aonEUx8MyDixyOeMuDeQBsk48223qb8oduTj0/6h/71JtJjBEe4Ap1H+OK4x4x1zi87tQ+ewwMp1nkiSzqc9qNASJaG/baftuj6v7TB4Wm1VI8UhCvZdS+4z5TZAGEL5EaPO0zEFCEFMGxM462vRZB+CS2eR5heyVhGSIo9F8VojRCyWSS9RapjlKjDwuOYDhSwivl0RGqeijZVMXIClE7BpGZLra9tC1RDEg8ZaiM2PkkOQu17v1CNXSCeTxDFj16pb3pXnPEFTKSKHAa3vmNU72ynWSgO8heQk6AJFVEKyxlafPT4HGx9Iu2VwQg8FDpyvgOE27hwL5ZWRoXx+y1iUn16G+0ftPMBUHCbeShc6rDGW5x/KXwhicLzsx4lKQN02AFFUFQmkOc/vkUKyAT1uc2FUMTVW4CsnY7DKK9nP9iIKGJMXGary/qfNVS0/7slhbldQyWnF3+YMhqS04SDe08YRDvKvAFIa48GFvaGCjpJCkI6XJ3vzv1rdDmJV2l+o/aMMaa3Kf6fuu0i/Da5iCAiIyo7IHzKc+3l/L6N7lOBk9ORznoyLLBCuvshzxBd6oTXyK438H1isv/oEx4K1sBf/OerG+sZuUdzQC6/AJgsIH4pOfVJmUFGjZBpHshmTVbh6TmlKQBI8MHqUjGNByW5WwdMbRgTxJZizTJ8XiDwRuaxRu+Gz1yTsyOZtgwtBSVUMY6slX5m
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(346002)(136003)(396003)(376002)(39860400002)(40470700004)(36840700001)(46966006)(7696005)(41300700001)(26005)(478600001)(6666004)(2616005)(426003)(83380400001)(47076005)(336012)(4326008)(1076003)(186003)(16526019)(2906002)(44832011)(4744005)(5660300002)(82310400005)(40460700003)(54906003)(8936002)(110136005)(316002)(40480700001)(70206006)(70586007)(82740400003)(86362001)(356005)(81166007)(8676002)(36860700001)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2022 06:34:28.0610
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 835edceb-6a2e-40f5-3ff1-08da9488d7c2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1NAM11FT097.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7631

Comment is not related to amd_iommu_ops variable.

Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/iommu.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 4509c9c4ee20..c589832695a7 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -66,10 +66,6 @@ LIST_HEAD(ioapic_map);
 LIST_HEAD(hpet_map);
 LIST_HEAD(acpihid_map);
 
-/*
- * Domain for untranslated devices - only allocated
- * if iommu=pt passed on kernel cmd line.
- */
 const struct iommu_ops amd_iommu_ops;
 
 static ATOMIC_NOTIFIER_HEAD(ppr_notifier);
-- 
2.31.1

