Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2045.outbound.protection.outlook.com [40.107.237.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6913BDDBF
	for <iommu@lists.linux.dev>; Tue,  8 Aug 2023 10:03:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F/Q+/RCGBLmHEitSjqwmY4G8bhMT/GllJLA3k+AJyqWYVdohzlvgqBaZ3kfcrswuGtJt6jTDvwSDzIKScUgIuais5JeCFvx+KadyMRfKkcAEmY5rbbAr68Zr0b0BhB5AoN3PpTw62dzCJCI0Vp1K+FK+B/GLn+o9xGIeZEJnqH8HqzWWvzic+jlCh/fD33gY884su/xPCp4g/ZbXlT5ZJ3coNd4wJvYNLMPU3fP7llwuBePcsfB9jL7cH1vsv8R1yuD/6f4sphO+kDVtNbcK3mXvWV+t+9V7meDtGYwIqBCSzsuFup1yz+ospLW3L5LzdQail2/WH213lTjKqMcmZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YOQKiEJnwTw/Iv8qrQxiO005bhjhZOiqw6pjZfKZP/c=;
 b=IXvza9Y64+LQYLML6A79+mSPYCqOjmPNgqYTD6V/NungzmOoCkV7kmRAheJZFGfm0C8wvhzGZPdAaGvM+adHTuePdmdcZ9TIm81wQR2zEbT55EGCVdIIbYOJfTS37+wcJrU9OuZoNSVLPL0aDgUnrc8oHKQsKzmqoockat2U3u+7EUJ+dnwZY5pMXiKaPHstSnmjwMuXRo0J4vmdHlMzuOX09geJsS/41DsgfQi252oSMqSZT0vTCnYiZqjuOSNjdsSiQAR4MBfzacS+tpdOHy/0yCp6F/q02hqpk+BYRsKhzcbJ+2sdoJ1UsHZNoyWcERqjOYxseHnLW9VtlH0T7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YOQKiEJnwTw/Iv8qrQxiO005bhjhZOiqw6pjZfKZP/c=;
 b=JxDZU0KycshbzYXXY/7PlqeyoUek60SQvubv2n48CfEZ8TrKqeOADY3oX+2Y4hn0wi6b5twksf1Auk9ZLt3C7DCvFnlyicygV04OjTXpLxhdesdl0xObqKz3KvW5a3rb2eiztvrSwUJAqpdmZ5bimXuy3TY5l4m48tnyY+4be6E=
Received: from SN6PR01CA0036.prod.exchangelabs.com (2603:10b6:805:b6::49) by
 PH7PR12MB6491.namprd12.prod.outlook.com (2603:10b6:510:1f4::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.26; Tue, 8 Aug
 2023 10:03:03 +0000
Received: from SA2PEPF00001505.namprd04.prod.outlook.com
 (2603:10b6:805:b6:cafe::82) by SN6PR01CA0036.outlook.office365.com
 (2603:10b6:805:b6::49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27 via Frontend
 Transport; Tue, 8 Aug 2023 10:03:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00001505.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.19 via Frontend Transport; Tue, 8 Aug 2023 10:03:03 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 8 Aug
 2023 05:02:59 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH 00/11] iommu/amd: SVA support (part 2) - refactor support for GCR3 table
Date: Tue, 8 Aug 2023 10:02:21 +0000
Message-ID: <20230808100232.5977-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00001505:EE_|PH7PR12MB6491:EE_
X-MS-Office365-Filtering-Correlation-Id: 21745881-c67d-4a2f-26c4-08db97f6a7c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Ced74pThuJWaQ8H/spS4dI/KCM3kBz+yB7dJovNRY2WKj5DXTpvZIwSFx9Zo3fzUjyAKqhDep2/YHEoHYHXqjYddFjWk4Ia/JiOlM5FeKYMR2crlrHCWBFdSGHgunythokfDKOWJPka4fVnWW3MgQiOVbfrR/iVqc36b9XjYtgpsjDbrd/e52kqyHozwjOsaquzqRKLCjRC4tVUKLr21RQRpPYsSZXQVs+igLzRODjQcbUbv9OoRYKdL/d1pwnXG2ivlKh597sbjNLKSt12DTL3twQpxmjRYAkFBmaJdANPBaTE/k3D8j14kQISZV+unUKkeazEAK7azZzCLhEXUokVATaDwudjRlsK4e0rwvyxPlMVHZt88FcrL9AkT3lfWbX+6v2k8UKh9ny7aglLDRnv79setNTn4EWmgg+npa1Jq+hvGhODrrlrRnfePWz8NIqH4wXIteol29hfhPLdvJwdGfplpOebeIxAuKXxcWsaXSTtnQOtpGkWrYiP/OU0o+Ycm0PQs7yXvCNUahi9ArSZQSanr5Qnp9VV4255eHaUMVVXNdAbFkiX3NrGRu56GzKHikx8ckxB5eviPUNjEkFMNS2I/qEXQSCnbxxM3qRNFTZxRncdJjBszgHPDabdt4C1iJxHaPvV0nL5V9co8g2wnXBrb8ZZyMFv6nGIECpgHQ4rBqEahGhtGfGs/vMqEi8Vs95T4n2HZnxDTrfzTKquwU2gASdPzcob69k9ZCfmy+K36ycDz2CbTeMw2okc/CvxxJy661D+B/EXqQqUo2UbCinpNmRXOvKhv5jVO+tE=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(346002)(136003)(39860400002)(451199021)(186006)(1800799003)(82310400008)(40470700004)(36840700001)(46966006)(81166007)(40480700001)(40460700003)(2616005)(7696005)(6666004)(966005)(478600001)(82740400003)(110136005)(86362001)(54906003)(26005)(36756003)(356005)(1076003)(316002)(5660300002)(8936002)(4326008)(8676002)(41300700001)(44832011)(2906002)(16526019)(70206006)(70586007)(336012)(47076005)(426003)(83380400001)(36860700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2023 10:03:03.5027
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 21745881-c67d-4a2f-26c4-08db97f6a7c7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00001505.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6491

This is part 2 of the 3-part series to introduce Share Virtual
Address (SVA) support, which focuses on refactoring GCR3 table.
This moves GCR3 related information from protection domain
structure to iommu_dev_data (per device) structure.

It contains the following enhancements:

* Patch 1:
  Rename helper function

* Patch 2 - 8:
  Introduce per device GCR3 table and code refactoring

* Patch 9 - 10:
  Add support for iommu_v2 module to adopt to new interfaces

* Patch 11:
  Remove unused variable from protection domain structure

This patch series is based on top of SVA Part 1 [1] :
  [1] https://lore.kernel.org/linux-iommu/20230804064216.835544-1-vasant.hegde@amd.com/T/#t

This is also available at github :
  https://github.com/AMDESE/linux/tree/iommu_sva_part2_v1_v6.5_rc1

Thank you,
Vasant / Suravee

Suravee Suthikulpanit (9):
  iommu/amd: Rename helper function rlookup_amd_iommu()
  iommu/amd: Introduce struct protection_domain.pd_mode
  iommu/amd: Introduce per-device GCR3 table
  iommu/amd: Refactor helper function for setting / clearing GCR3
  iommu/amd: Refactor helper function for attaching / detaching device
  iommu/amd: Refactor protection_domain helper functions
  iommu/amd: Refactor GCR3 table helper functions
  iommu/amd: Introduce helper functions for AMD IOMMU v2 driver
  iommu/amd: Remove unused GCR3 table parameters from struct protection_domain

Vasant Hegde (2):
  iommu/amd: Use protection_domain.flags to check page table mode
  iommu/amd/iommu_v2: Add support to switch default domain to SVA mode

 drivers/iommu/amd/amd_iommu.h       |  17 +-
 drivers/iommu/amd/amd_iommu_types.h |  27 +-
 drivers/iommu/amd/io_pgtable_v2.c   |  20 +-
 drivers/iommu/amd/iommu.c           | 387 +++++++++++++++++++---------
 drivers/iommu/amd/iommu_v2.c        |  66 ++---
 5 files changed, 307 insertions(+), 210 deletions(-)

-- 
2.31.1

