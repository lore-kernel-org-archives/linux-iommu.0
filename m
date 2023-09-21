Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2055.outbound.protection.outlook.com [40.107.237.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 613B4944C
	for <iommu@lists.linux.dev>; Thu, 21 Sep 2023 09:33:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WtLy5dgQk/n6IvJjV6x+1yxmpLcK1b4YcDsdJDd33CTMLeDIHOBqraq8/AEaAcaxqFxl4HNozMNj2EATO+0tgIXvtq8xzmCenQupu664T9gvytqJ1+s7AfrJRj0k7n3yV3CAoOSvL6y6enhvmJxQpHvzs5Als8hckzIotrs274trmsDsuJm+sdReuZqNLoFDsdBtvoFIjDRzF327U54KpwjY2O2tybO63wQKkW5ZPqJ4K5YCv/TGNX/UEDyQeJTRE4dXZ58sF462QzJSuSbG3KXurY/RFERbprxpeQNXxIGmTziKtp6c9PhkNfJsftI2LBVh27j2R5UAMn+8wDTicg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bEw4TwkJQpijDWCHCHEJtkfNkAcJ/IPfBzbgOd2Qugc=;
 b=oABruuA0ulcjBQpHdGReNYNPnhKK5Ky3V6ZxGqPoAsviP3RIH5KuViOFOF4k4TeQSFyWXVlGg6thI+rfzlRh48a/rU9Hb88Hrpgkps2bVoaqK+J85IoI1Cz66E+GEm6uLssOCdP8IVUs+wCX5/jMg/dgkQUGCtwDAWzY6My3DH6VvGBqTt3bgHs7iPe7xTatLf1UNsP09YdOYHYG8CkFvdpAV5z9X35+J4dDwnPJSUih7P9bP5I5Gej6jH8KmxuNxohi7iuWkQqBzT++1STt5pxn+PNQmdcNiVnEQ8ymfwRfP3CZQT+5Wfo4Tj9LrUVwWzOcMHzxdcd/kNg3jRw4Ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bEw4TwkJQpijDWCHCHEJtkfNkAcJ/IPfBzbgOd2Qugc=;
 b=hCmp5E6AbzMk0skVrPxm5D0MnDUbzew8DGjVnd4tVeu1TF6aoh0/hXdlwJ3cZ7dP9t2n1Xt3QwxBHDFmRYJxpWAMNqjrfDwTipcrVwvHMpuLbMEUgaHYPCvcCvXyCuoJQQdgqbJICgxCrhOlPpZ1gIxapJSMYNOXLS1UtUqV+gw=
Received: from DS7PR03CA0191.namprd03.prod.outlook.com (2603:10b6:5:3b6::16)
 by MN0PR12MB6151.namprd12.prod.outlook.com (2603:10b6:208:3c5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.28; Thu, 21 Sep
 2023 09:33:44 +0000
Received: from DS3PEPF000099D6.namprd04.prod.outlook.com
 (2603:10b6:5:3b6:cafe::18) by DS7PR03CA0191.outlook.office365.com
 (2603:10b6:5:3b6::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.31 via Frontend
 Transport; Thu, 21 Sep 2023 09:33:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099D6.mail.protection.outlook.com (10.167.17.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.19 via Frontend Transport; Thu, 21 Sep 2023 09:33:44 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 21 Sep
 2023 04:33:39 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>,
	Robin Murphy <robin.murphy@arm.com>, Takashi Iwai <tiwai@suse.de>, "Jason
 Gunthorpe" <jgg@nvidia.com>, Joerg Roedel <jroedel@suse.de>
Subject: [PATCH v3 5/5] Revert "iommu: Fix false ownership failure on AMD systems with PASID activated"
Date: Thu, 21 Sep 2023 09:31:40 +0000
Message-ID: <20230921093140.6162-6-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230921093140.6162-1-vasant.hegde@amd.com>
References: <20230921093140.6162-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D6:EE_|MN0PR12MB6151:EE_
X-MS-Office365-Filtering-Correlation-Id: d5c7c66d-5d1d-4749-b3ec-08dbba85d96a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	p/unbsCTGTXe4dGSQkj/3lOGDy5TyJ6e6u8B3SL3piYezGO4jmxZg5fAuCyrR9Za1lL53JI8WsNnCXKPGaww91ymAQALSd7peZm9ghMx9e4l0KhqnxZOb6oARPYAwvuL8LCngTGZowT4Wxb4yYR9nMnCAiAyXoayRvXkPvURgbTeQVqtP6hB+PDFu1nX2PKjDctKnPFtm9XuqGdxO0yYxSNUYxwtsZZoV3F7Q+DHdlvmP8DqkghuM+OedRH3avQBr6OBXO6PXWqa+yrxPLYhT1+e4nV7HPuSgQtVYYryGdQ860yTb94yxbPySr1rRYWBT9M0sykH0B9DadMe/qHbxzEODQqo53Rpe/TosUIC7zGd6eIFlTbwxmYusRyAR8Xl/vS53MzjGVdMZWEDaA04CKce5YYci6FiNOZ8b74dwxVKUpxFu3x7CTkyCPG+b0bK1yk5kj0i5bPk++A1vwqxv2kaTjjm5P08wK6Q3WM8nf9khPZaFr3RTUiCYVjjUjIvbIuXM666SBGbgOoSB0n/tFtmfyF/y9vZDucUUG9d7L5rmUp+CTIJPXOAuI2/IvNeK14Rg5gvfqst6qSBKjkSgee+oHZ3OtFDnVe31S2bHfOQ1sQJXaEi9zKfZuHzh1mzG0kejQ7ETXsO8viLcKfdfWKC6FyuZbnNOg7g2A8VG3LcQwdbhsE75ZEzceoBZ4YmWc6wrRrbQe2putHnDAsR3f5safSA/E+sIlleuTRc+0ojInXB8H8wRPC+Es6D9ZmGSYclXC3+LyzufZiPfoWGFQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(396003)(376002)(39860400002)(136003)(82310400011)(186009)(1800799009)(451199024)(36840700001)(46966006)(40470700004)(7696005)(6666004)(478600001)(426003)(336012)(5660300002)(26005)(83380400001)(4326008)(2616005)(2906002)(316002)(54906003)(16526019)(70206006)(1076003)(8676002)(70586007)(8936002)(41300700001)(110136005)(44832011)(40460700003)(356005)(82740400003)(36756003)(36860700001)(47076005)(81166007)(86362001)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2023 09:33:44.3341
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d5c7c66d-5d1d-4749-b3ec-08dbba85d96a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099D6.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6151

This reverts commit 2380f1e8195ef612deea1dc7a3d611c5d2b9b56a.

Previous patch removed AMD iommu_v2 module. Hence its safe to revert this
workaround.

Suggested-by: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Takashi Iwai <tiwai@suse.de>
Cc: Jason Gunthorpe <jgg@nvidia.com>
Cc: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>
---
 drivers/iommu/iommu.c | 20 +-------------------
 1 file changed, 1 insertion(+), 19 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index f3231042954b..b74befc08036 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -2899,24 +2899,6 @@ static ssize_t iommu_group_store_type(struct iommu_group *group,
 	return ret ?: count;
 }
 
-static bool iommu_is_default_domain(struct iommu_group *group)
-{
-	if (group->domain == group->default_domain)
-		return true;
-
-	/*
-	 * If the default domain was set to identity and it is still an identity
-	 * domain then we consider this a pass. This happens because of
-	 * amd_iommu_init_device() replacing the default idenytity domain with an
-	 * identity domain that has a different configuration for AMDGPU.
-	 */
-	if (group->default_domain &&
-	    group->default_domain->type == IOMMU_DOMAIN_IDENTITY &&
-	    group->domain && group->domain->type == IOMMU_DOMAIN_IDENTITY)
-		return true;
-	return false;
-}
-
 /**
  * iommu_device_use_default_domain() - Device driver wants to handle device
  *                                     DMA through the kernel DMA API.
@@ -2935,7 +2917,7 @@ int iommu_device_use_default_domain(struct device *dev)
 
 	mutex_lock(&group->mutex);
 	if (group->owner_cnt) {
-		if (group->owner || !iommu_is_default_domain(group) ||
+		if (group->domain != group->default_domain || group->owner ||
 		    !xa_empty(&group->pasid_array)) {
 			ret = -EBUSY;
 			goto unlock_out;
-- 
2.31.1

