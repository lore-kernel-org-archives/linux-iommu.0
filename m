Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3F734C6A
	for <iommu@lists.linux.dev>; Mon, 21 Aug 2023 10:50:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nH9MKk3rn1V0HoHKkVPvbDn52T1AT2dJL7x1CFG9AfXkGmBk+b8jG8Ergg/AXSK3wO/UA+934MdUWw/Bsi6Vey5plnUQ8dKNTe9lv8ZZ/Pw7OqQ/ZcJnwnyABAFk/NmPZ0w39HUwffn4NPB3HWmCwx+HnYhHlDxgmF3PTCRzIqmhQqw9tt8xEorkduAk8/aSC7bAWU+sPXT/mf6RvLntBz8FLJfugakM1QyCNmrLwGrxIThyJlQ2V6qAs3m44BJk+Q1zIQ+U97uMIVHJqRt89gq2bfPswaXtZBvMeqTtV8fGVwPtypAbdEpe7R6HCaLThOrb5528EMDhf0/dIhbulg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y09WrRC2PJj0HNJ9u1W/1hHkAGIJSmX86GTpGubUVQw=;
 b=QGiY8zOhgmuvSqh/2vFx2uc/QDk0WAUTAX/N60oy3Y8nDjR+mZdmBBZb6UarvfJNyLPPwvH7W/jcGc5NhE/nRRmTWfU4XYm5l/iSwRxiilfiOg5Svg//PdTKmrPg+hPpLhzvvhmbi0yjDHHzoqj8DwSHSrpoFzpC9LIdScckYiUCzCr38gLQIW96JHO+fE2lmLAVVWQV4WbGh1zbx1j0QAyFhogO05svvSyyM1laIGGGs+45RcJ0uyz3VUoW5iDh19Q/wkiKTr+BrI384rIww21rHMiGmM8rs6JRO0XzTlpj48Mh/+WxkqEQKGlyBwigZIoWUgpYfaPFAOKOwno6rQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y09WrRC2PJj0HNJ9u1W/1hHkAGIJSmX86GTpGubUVQw=;
 b=V0LVK1swEX2ZH0o5bhU0XYWvQzxDUC3H3uzdBwkoHMq5ig2DdU3zLwLBC4kX0rZDtVwfl7Kd8gX9fKt39xVbCr0sD80AOyRW6dBvNCMeJiReVuUVyK17w+xNCSuCIFVEUrrM5+BewbEnqlN1p7uvjPzGSFzABZyIgsLU5nzqk6o=
Received: from SA9PR10CA0026.namprd10.prod.outlook.com (2603:10b6:806:a7::31)
 by MW3PR12MB4585.namprd12.prod.outlook.com (2603:10b6:303:54::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Mon, 21 Aug
 2023 10:50:27 +0000
Received: from SN1PEPF000252A0.namprd05.prod.outlook.com
 (2603:10b6:806:a7:cafe::fe) by SA9PR10CA0026.outlook.office365.com
 (2603:10b6:806:a7::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20 via Frontend
 Transport; Mon, 21 Aug 2023 10:50:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000252A0.mail.protection.outlook.com (10.167.242.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.15 via Frontend Transport; Mon, 21 Aug 2023 10:50:26 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 21 Aug
 2023 05:50:07 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v2 0/5] iommu/amd: SVA Support (part 2) - deprecate iommu_v2 module
Date: Mon, 21 Aug 2023 10:49:51 +0000
Message-ID: <20230821104956.707235-1-vasant.hegde@amd.com>
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
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A0:EE_|MW3PR12MB4585:EE_
X-MS-Office365-Filtering-Correlation-Id: 2df6b94c-f31f-493f-6b17-08dba2346db7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Yb2gSAz9gZP3PsOTTCRWrD0iS/9qD9bzbla1fdI1BDdGdHpDPXS1f1M7lpQDN61k7tc/c3WpHeLP2p2xjQJNgvqtRLt2aYtuo66MPW8ZU6DjSMY92NKhAMkQbRVqJKfAHL2EPAvj205n4f1ZZM8cmmg6+N6GxoGNePx6raCAXKbXCJ/ErWXVTsMsB6/cCogjmjV4LDda/HI1FLrSXRRlXr11yvohBa2FBow/v1KoH11ljsxMQaRG535HoVMp4GoiaUc/vPKQqGQnWUtqXPL1jdf+xdbIer74j6xFLUuqMKEp6BHCVbIn/mCuG8QN4LTJrzX6ZYqz+KQvd7/SYcHpu6wmMH8SOj59W6EgX5mU+qKOKpyo59yeVAdWxX8lmv/ojNkX5VNiMr8u5qvmaWdiNmeMOG1J5yaKaKHccvpkWIDULNvaHrRGkT2T0LiYR4EprwsUb9okNb8IcKcksDF/xZealCJ7YK20n3WslnO4dW0t/AfZNHAh2UzkptQOQs87mTlc9OPoaAqKSXnOw8BQGQLlfjSNbMPGf9t7JfbPVheMKZsSTyU4Moji6mqjQChsZkchapfm0xQ+mQaesqawI1RoIhNgpcdXz7P4SS0wJhDG+1rFuTrIkHjiq0j2jQYMT27bg0pSXYmKPVIrQc6xScReS1nFbh9aGsVKyYp57TKn913Tr7Oi/RLfjb+CzLf3vC+Oy3npX/myyPoKFephQ7v7elGJru61KMls8juGVtHE1Tes1g98OD631582qSNrc8FlRYrEMjbEUxbkBdVNWd4GMk07N2nX4ZLDSMIC+34=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(346002)(136003)(39860400002)(396003)(82310400011)(451199024)(186009)(1800799009)(36840700001)(40470700004)(46966006)(2906002)(83380400001)(7696005)(40480700001)(5660300002)(44832011)(336012)(426003)(16526019)(26005)(86362001)(36860700001)(47076005)(8676002)(2616005)(8936002)(4326008)(70206006)(316002)(54906003)(70586007)(110136005)(966005)(478600001)(82740400003)(356005)(81166007)(6666004)(40460700003)(41300700001)(36756003)(1076003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2023 10:50:26.5168
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2df6b94c-f31f-493f-6b17-08dba2346db7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000252A0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4585

This is part 2 of the 4-part series to introduce Share Virtual Address
(SVA) support. This series removes iommu_v2 module support.

AMD GPU driver which was the only in-kernel user of iommu_v2 module is
removing dependency on iommu_v2 module [1].

[1] https://patchwork.freedesktop.org/series/122124/

Also subsequent series will add SVA spuport in AMD IOMMU driver. Device
drivers are expected to use common SVA framework to enable device
PASID/PRI features.

Hence this series removes iommu_v2 module and the functions used to support
iommu_v2 modue. Note that there are certain functions (ex: PPR interrupt
handling code) which will be used in subsequent series for SVA support.
Hence not removed those functions.

This patch series is based on top of SVA Part 1 [1] :
  https://lore.kernel.org/linux-iommu/20230821104227.706997-1-vasant.hegde@amd.com/T/#t

  Also to build kernel with this series either we need above AMD GPU
  related changes [1] -OR- compile with kernel config 'CONFIG_HSA_AMD=n'.

This is also available at github :
  https://github.com/AMDESE/linux/tree/iommu_sva_part2_v2_iommu_v2_v6.5_rc1

Thanks Jason for reviewing previous versions and providing feedbacks.


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

