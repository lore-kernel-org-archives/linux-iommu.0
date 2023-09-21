Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2068.outbound.protection.outlook.com [40.107.223.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C1A58F55
	for <iommu@lists.linux.dev>; Thu, 21 Sep 2023 09:32:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jldkQFiQpciN1xBNBFYL/sk81+cfT2dfRUFl9WGoUf0GBulceED+O9yylwJSg1eMFL7xgQt9jicngqeueLJvfjRRrazW2m3YeISwu3nlNcvKYlOhNrwUkgDBFTAa+rooTWnsx+uzfCQc8WtT9Uif1Uq+7azl0/A/OCPfKBe1UhzX1zokZ/LVGMr8N/Te1DfrqCJztvS+v78h/5Dhy1QWMUpnplM4SuHuUrXjdQyQe0CdfDfkH5/X8dFnEPIfBhgU5H9/yMYxH9VmiGJ3lECtNshkExHPHw/Nfl4s/1Pf17ctWOtJh8Vtj3olM2v+H1BjQRC7bYGHBE/U2aA/M+cv/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vL2m5fJs9I/FUMCOCu2hOKCctZ7jbdMsVY4tlEkqnS4=;
 b=mrHiP81HMc065T/zYiHRY+PYSszWlS4PJEjyOK9hoVsDIC3coON++LuXsscRfJl1RAcepnGFffyG+ailU9OSGMI4O5aVA3h8Aj/Yv/lpWftCfQsTn4F9lmYT7PmOpwrNePbsEGf+OaOUzjOTFjMnEPuh/HwOIx7uGbABdwu7mdX8A96DbmLUw+Tyg+HbRB/epzg/KmprEK7iS2jHi2SLbll5HY0JP3h0465WwWlyGZ4IA7+t++KVmrvryQulgli7PO3ZZ9NRvHmjrp6JobKFo2KWkpuWNzfi2ZOSYtWw2KyuDyb7JDjuRKG1HVjAtdZHKW/terVlbLaGSt4njbMe1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vL2m5fJs9I/FUMCOCu2hOKCctZ7jbdMsVY4tlEkqnS4=;
 b=CQgEYZ9tm5iFXr+mGDEgBJD15gd4mUnoCrPntnOsJ1IYLtMAqyY6ufI5ij/TF80U2HNmOzx4baBA8fZLub3eKLq61wrBApMhUSH/DvYEDnKaGifQ3IqdtHeKD3KWYCUp6AceK6mQpGx4NA/NkHadhVvDqKoTKQx0ZjIKdp6pgnc=
Received: from CH2PR02CA0014.namprd02.prod.outlook.com (2603:10b6:610:4e::24)
 by SJ0PR12MB8139.namprd12.prod.outlook.com (2603:10b6:a03:4e8::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27; Thu, 21 Sep
 2023 09:31:58 +0000
Received: from DS2PEPF00003439.namprd02.prod.outlook.com
 (2603:10b6:610:4e:cafe::ce) by CH2PR02CA0014.outlook.office365.com
 (2603:10b6:610:4e::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.30 via Frontend
 Transport; Thu, 21 Sep 2023 09:31:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003439.mail.protection.outlook.com (10.167.18.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.11 via Frontend Transport; Thu, 21 Sep 2023 09:31:57 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 21 Sep
 2023 04:31:54 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v3 0/5] iommu/amd: SVA Support (part 2) - deprecate iommu_v2 module
Date: Thu, 21 Sep 2023 09:31:35 +0000
Message-ID: <20230921093140.6162-1-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: DS2PEPF00003439:EE_|SJ0PR12MB8139:EE_
X-MS-Office365-Filtering-Correlation-Id: cacf3213-5552-49bc-b9e1-08dbba8599a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	y8IUeAeOuPSHcmlHd/bMhhx4BoioOdJYx82Hs5TaOg9JlFnwcuzWL8ZN2NIFfUljIqZXdKH3Kg0U1GrAdo7XyV94pofQcYx7cXICweqbkN8DGdWZZ7PhvOycH8+EUWPyGvi66G8jgnPLWHLyJMyYzApY19QipRj9kiLzMNRLQwVIaa5dG9mvrB71On3PgsAsxFAaozARSqfILpfHhl+1eShjHAo1LqMduNfgH5SX9SLlVJR1cDIiJYi7UTL0147lRisRWtDMQsXoUxb14uFj+SYFCiN7IVQPnmh8E0ggdUaN5zAojBNhDP7/IIEenT8d6Lqmq6HJqcbonTw7XfQ90XQ4UhrHUAuzZpRcSgoQa9s3OL1gEni45VY5rguTq/m2pZCo4dIfsRrrSI+fdiT0QR++wBfF2/t0exwYEdbXenftg/71crvQCyiovsUQM3V+kjHXHpFhoS5fzyWRoGcy/i3ExdB6d3OayQhoNu8OEAUXrUlbs86lJX5XOZ+hfLIUxcs7Rsh0zAdtWGUz/CW1+2qbyeFKaQp/2d8pUN08IY/rlOMbWy/Jw+0G/0x0p9Sx88lWTwoYSjJwo2kvKjvn1EAdTw7T3u2YGRd92rS/SgJrgvJL3fZYmBJWS898pESh0gbYmvW1KNUscEEfm0Wv/ko1dL754VbkYAKC5xXwjESv/f2i3SjUBXUaWbKv0wzRaltKK4uhED/qTxniHuJb+vUoPZgdsnIARWGlwrRbFmYbsJ1bMzrtNZbmnvQImTbUhUQFdqp3P6EjBkAAOm7O2e9WUSoCnUckJEpfInEDtrU=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(396003)(136003)(376002)(346002)(1800799009)(186009)(451199024)(82310400011)(46966006)(36840700001)(40470700004)(47076005)(6666004)(356005)(36860700001)(82740400003)(336012)(40460700003)(83380400001)(81166007)(1076003)(2616005)(40480700001)(86362001)(4326008)(2906002)(426003)(8676002)(8936002)(44832011)(5660300002)(110136005)(70206006)(70586007)(7696005)(54906003)(36756003)(316002)(41300700001)(26005)(16526019)(478600001)(966005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2023 09:31:57.3598
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cacf3213-5552-49bc-b9e1-08dbba8599a7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003439.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8139

This is part 2 of the 4-part series to introduce Share Virtual Address
(SVA) support. This series removes iommu_v2 module support.

AMD GPU driver which was the only in-kernel user of iommu_v2 module is
removed dependency on iommu_v2 module. These changes are already in
upstream (v6.6 merge window).

Also subsequent series will add SVA spuport in AMD IOMMU driver. Device
drivers are expected to use common SVA framework to enable device
PASID/PRI features.

Hence this series removes iommu_v2 module and the functions used to support
iommu_v2 module. Note that there are certain functions (ex: PPR interrupt
handling code) which will be used in subsequent series for SVA support.
Hence not removed those functions.

This patch series is based on top of SVA Part 1 [1] which in turn based on top of
upstrem v6.6-rc1.
  https://lore.kernel.org/linux-iommu/20230921092147.5930-1-vasant.hegde@amd.com/T/#t

This is also available at github :
  https://github.com/AMDESE/linux/tree/iommu_sva_part2_v3_iommu_v2_v6.6_rc1


Changes from v2 -> v3:
  - Updated description as AMD GPU related changes are merged in v6.6 merge window
  - Few other updated to description based on Jerry's suggestion
  - Added Reviewed-by tags

v2 : https://lore.kernel.org/linux-iommu/20230821104956.707235-1-vasant.hegde@amd.com/T/#t

Changes from v1 -> v2:
  - Added patch to revert commit 2380f1e8195e

v1 : https://lore.kernel.org/linux-iommu/20230815103255.565295-1-vasant.hegde@amd.com/


Thank you,
Vasant / Suravee

Vasant Hegde (5):
  iommu/amd: Remove iommu_v2 module
  iommu/amd: Remove PPR support
  iommu/amd: Remove amd_iommu_device_info()
  iommu/amd: Remove unused EXPORT_SYMBOLS
  Revert "iommu: Fix false ownership failure on AMD systems with PASID activated"

 drivers/iommu/amd/Kconfig           |   9 -
 drivers/iommu/amd/Makefile          |   1 -
 drivers/iommu/amd/amd_iommu.h       |   7 -
 drivers/iommu/amd/amd_iommu_types.h |  21 +-
 drivers/iommu/amd/init.c            |   1 -
 drivers/iommu/amd/iommu.c           | 133 +---
 drivers/iommu/amd/iommu_v2.c        | 996 ----------------------------
 drivers/iommu/iommu.c               |  20 +-
 include/linux/amd-iommu.h           | 120 ----
 9 files changed, 10 insertions(+), 1298 deletions(-)
 delete mode 100644 drivers/iommu/amd/iommu_v2.c

-- 
2.31.1

