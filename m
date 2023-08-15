Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2069.outbound.protection.outlook.com [40.107.92.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 747083C1D
	for <iommu@lists.linux.dev>; Tue, 15 Aug 2023 10:33:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FI002VLw1SimPnRsQIhgU0YoNBiNEd+U+9ihUpnkwpn59rmdQIBZOfr5Wj/Q0vfKDCgdkKpfdcJDe+lDnsTeWXEjgr2MiqP/oHU6U3lXPdVmM0yxBdTTi42kW1HURxzlexVkaA+A1F9keiFas3ku0jerOinWcZviOMpiahT13qekgU7N39dyX+hm3YxbpUZZh1GwDuVPiUsKRHNOD6h8eqbUqdlt0EWIxsOVxpH8ruwEHfhUkiJ74TkOLo2iGV5Nty6+QscIF66fEG8h6KLaS0w9ZjVOff86O2bHzVq/sL/ETxeJSK0dfNPIde6DUeW57YqxJi3PdBzjtiJRttsTAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8JpEnD7kQmC3006Ly9nz4U6o2y2xADPXXhCpt20JBl4=;
 b=RKNJ9KpqDlSvMsk5MY8g3DkCm8lSm+GnYUL1glKWDsqHQM2MJsdVPx80R21Qs2bZP7Ylz9Hk2n1FIa1GiNLWqh/CCwWQ3wT/hwOfwqbGp6CLIZPNJ0ZYXpWXeZdPSzSqYhh+fec6UYE8mI/wnoSkyD9JvXcPY45ZOb+48K8/NzRkCsfd3fJnkAfFzaGf1CwXlRGfkneLXDBlJFX8qbynUd3u9oJsxyngUqmbj5iJ08B1nZVkIMfvxOfUqt3XE/ITgaMrXyqG2GSFozzIr+H2e9upUM2ywMKP8KH4q/q7jevvd8rEvmPyjS+wtmVUe9XBEL3UEGW3Frl9z3XP+i8XxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8JpEnD7kQmC3006Ly9nz4U6o2y2xADPXXhCpt20JBl4=;
 b=gROJB6svgbkhDdfJqc3r5w9Cg8DBjoZPEB4on/+kDI5sLqwS6yUOrHBbHbC18Pvg04kB7+1gs2hvsNvF+ShuPcnAaSzU2p7G1zSARf+60oeDc/oSI0EIMC231n2ZTRtG6x/BpZti1yLDbl69fYblz94JanE+Q6MNi6cQ+OKVFMM=
Received: from DM6PR06CA0086.namprd06.prod.outlook.com (2603:10b6:5:336::19)
 by PH8PR12MB6820.namprd12.prod.outlook.com (2603:10b6:510:1cb::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Tue, 15 Aug
 2023 10:33:14 +0000
Received: from CY4PEPF0000EDD3.namprd03.prod.outlook.com
 (2603:10b6:5:336:cafe::34) by DM6PR06CA0086.outlook.office365.com
 (2603:10b6:5:336::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.33 via Frontend
 Transport; Tue, 15 Aug 2023 10:33:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD3.mail.protection.outlook.com (10.167.241.207) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.14 via Frontend Transport; Tue, 15 Aug 2023 10:33:14 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 15 Aug
 2023 05:33:10 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH 0/4] iommu/amd: SVA Support (part 2) - deprecate iommu_v2 module
Date: Tue, 15 Aug 2023 10:32:51 +0000
Message-ID: <20230815103255.565295-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD3:EE_|PH8PR12MB6820:EE_
X-MS-Office365-Filtering-Correlation-Id: a034973f-b463-4ad4-79ec-08db9d7b07f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	1kBJNxfMgtEczvy6F60W8DKonT8Ab6xQxHpgYguJJbFefnPgke20j0Wgp9uaR4eU2dv8ru9dgwtuFUXvcquKKYEAEh5eqSXIOHKSNtbjxGc0B6nUIBfA8XJ+v4a59DWwHT/ZzPm7N3Oh/Zl1eq0dMu4nEK6nxc6gkE9yURIf9eGKkJcslh+oyegVKMbyDQ2aPHYXZyHaoGbTdVrbXFVEEjcccfIVZ5IzIMHdZXUnqzzAxxAAHSl7BYX+fWIhP+h7JjJYwPU+NQW51qLqo9Ohnj+pn04KycqewUfDfvOf5ggIdveOObSGN1+eRCt6FWpyZ6MkpHEXL8rd6iJOIK39sqR0tLW0PTzmDji8UhPITkx25QGbcBqHfq1oNizya11rm3Ww1SLwenqSrKeKZyUhq0Hf51sCFCU3FTlhw+9Pe5TwdpZCU2Nt8+ai9Tt7xUYl0rXhgvyF1LJGSmAcoRkANJP7nPaptxQERqCYGxhuQwCsO/0FtAGS/yOYHe1fBnir/KWFMHn/WA/SInrAMWRdIKuru9cZwMLQvlcvLmEVBUKnRWiIlsFmLqzWiJSEY2vPodOFbgegzROsewgtcb9AKk+lSnssTm1qI26yPlDaE6rgNvu9Z/bA0GxcCz2qkaYmymPb/zYcfw0H8tB5PXL5htskZH6DTuljSEoLbvixSzjgx/+vGGAxOUkhPX52XT69L7ok2Z2KseSPl3nPzCMV5iyEMkpwxzJCLuImnVm101LOOZBun1YGOC0y0H+G+zEhC9stuAmQ8QdCjJ/NmQLLRxXzsLw2okNqo0qFguRXSzk=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(346002)(39860400002)(396003)(451199021)(82310400008)(186006)(1800799006)(40470700004)(46966006)(36840700001)(40460700003)(26005)(1076003)(16526019)(336012)(966005)(7696005)(36860700001)(2616005)(6666004)(83380400001)(426003)(5660300002)(44832011)(8936002)(8676002)(2906002)(110136005)(54906003)(478600001)(316002)(41300700001)(4326008)(70586007)(70206006)(86362001)(36756003)(40480700001)(47076005)(82740400003)(356005)(81166007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2023 10:33:14.2160
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a034973f-b463-4ad4-79ec-08db9d7b07f7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6820

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
  https://lore.kernel.org/linux-iommu/20230815102202.565012-1-vasant.hegde@amd.com/T/#t

  Also to build kernel with this series either we need above AMD GPU
  related changes [1] -OR- compile with kernel config 'CONFIG_HSA_AMD=n'.

This is also available at github :
  https://github.com/AMDESE/linux/tree/iommu_sva_part2_v1_iommu_v2_v6.5_rc1

Thank you,
Vasant / Suravee


Vasant Hegde (4):
  iommu/amd: Remove iommu_v2 module
  iommu/amd: Remove PPR support
  iommu/amd: Remove amd_iommu_device_info()
  iommu/amd: Remove unused EXPORT_SYMBOLS

 drivers/iommu/amd/Kconfig           |   9 -
 drivers/iommu/amd/Makefile          |   1 -
 drivers/iommu/amd/amd_iommu.h       |   7 -
 drivers/iommu/amd/amd_iommu_types.h |  21 +-
 drivers/iommu/amd/init.c            |   1 -
 drivers/iommu/amd/iommu.c           | 133 +---
 drivers/iommu/amd/iommu_v2.c        | 996 ----------------------------
 include/linux/amd-iommu.h           | 120 ----
 8 files changed, 9 insertions(+), 1279 deletions(-)
 delete mode 100644 drivers/iommu/amd/iommu_v2.c

-- 
2.31.1

