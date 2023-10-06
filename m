Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2044.outbound.protection.outlook.com [40.107.100.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E63D15C2
	for <iommu@lists.linux.dev>; Fri,  6 Oct 2023 10:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ipcpnY8D"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M/cos8nlFTy0bEe+mN08dX8sJ+Jv6EnedzaJslQqIssP6Ksj2/ZpWunJKL34FeK9bQrALDa67p5yh5b6ISD00gWyoMIWw0j3F3TTnOPzOLWR+voEz9jKNwHEY8QB2EmdCRYOXVkqyWDLonHAiwh785C06R1oTgttLttfLF6F486G0pPGKCUEw7zYIbmbmiBi0PJnHTzOzsofPhYVhD0QyBqDpzXuMbNm7ePI4jW5UFT2WnHd+W0b15gKYzrW8BeMP30JJ9e2mmVSkiA7EbL/Hj+FdKUzIFOkk15TCtlKJZMck2kdkTadkjTBNc9+IJj4B8DozhCPLYYocVjkpBVw6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XIosQGym/6g6FJzozzsLc1rp/LliGr5kKVYUs5qbUU0=;
 b=jruonw3W6JfYJ42z9ahumMDQUSKjZg3mPuTYUlBzsjficxH7qCM3uAKjTy+mGFY/HdK0w9tPoE81wb5oziNUMvmxjKTr94LFkGhB7TjHSq+lixggyUnwOiwfU2yjYehuST871MaXZLc37He3htiAm9h2m+c2834oMrlNv+KtsnemPs6jgWYJRfQTU4nZJBVlDrNOjYsQiaQ8w2NsOaPQQJzHqjVCz9/1ol3fFojwHKoe7kuiAqKXQGNQUWDZFoBOIGz8LAdPPMpeVG3XuPtgnRFbfXZlEt55L9rE52n+c7AAqhaOF7V7LHWBvI0BE9OwJPsCtMi9xmLcQclYaFGUZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XIosQGym/6g6FJzozzsLc1rp/LliGr5kKVYUs5qbUU0=;
 b=ipcpnY8DgGP2jccfll439J9M0C3pNcXSDemqC/hyILkkbzAw0i+QS1y3dj63OW05aLzyuuG9LsbR/z9AqobhQIa02UzMtABQfmfHDNYJ4j9p938bK/T4QYSE06DlbS9gIvGLHtx6X7oSaqdJGT1UEJUKWIgfUoAN8RC69mHqCb8=
Received: from BL1PR13CA0422.namprd13.prod.outlook.com (2603:10b6:208:2c3::7)
 by DM6PR12MB4252.namprd12.prod.outlook.com (2603:10b6:5:211::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.33; Fri, 6 Oct
 2023 10:17:00 +0000
Received: from BL6PEPF0001AB58.namprd02.prod.outlook.com
 (2603:10b6:208:2c3:cafe::cd) by BL1PR13CA0422.outlook.office365.com
 (2603:10b6:208:2c3::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.25 via Frontend
 Transport; Fri, 6 Oct 2023 10:16:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB58.mail.protection.outlook.com (10.167.241.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Fri, 6 Oct 2023 10:16:59 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 6 Oct
 2023 05:16:57 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v1 00/13] Improve TLB invalidation logic
Date: Fri, 6 Oct 2023 10:16:11 +0000
Message-ID: <20231006101624.5912-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB58:EE_|DM6PR12MB4252:EE_
X-MS-Office365-Filtering-Correlation-Id: a02e7fef-1d8c-4e4c-29f0-08dbc6556043
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	W3OzmrEFAN7KlLXV3YCpb4tXmWqx8JdNtNMV9CSdz5RRd4dzSbhMGa9nicF8w0K0/DC9MNh/lkyroJ+DWX0k6wKwyZMwcOPkWd9u2utddI5XOL0OTZjE9MwEH7NweCy74gz5u16yF+2Hhfub9bMoflBTJEMciaq40e8mdABbQ/iQzcxr5Nj2buaUOVQFqncLlCsYT4l66yfaJplAXIuhE722xtEXmLFzgtuTx4LF/ZMYEp9eIgE1GjH3ahfvv90Z+OZyVuqczOCptTIXhhTVL4guYtt2vnV2XxiORaPY+zLrDK5JE3yUDQsmkQ9LKSvjnZIjXWuihCgOhDK44dqn9gCahoaWdgKgg65EomWucHTzHRFhE/ysdplIB9gyd6naNZ5su7eRTEujKj9vf74bmo3Ts3LSerVZcWTzxsmlJQ2Ie8pS1xyTCqTLVppT4Zz4TRXW4NF9d9ClDWgsSxxFSCwl1AUIctd205ZSKGYHWJ8TMe48ee2fKjv5uoN9WVxOqhYyhDQUzt98TEfDIJq5lVC1pMj4U8hmWErK5VaKTEO69CBSkFFYH0gyioeVW9Pa7AJx2k2ZEFrWZXVu5OLDEXtRj9GJQkIVAvf9IeZ5nMDGpNt6n5NNi4TpnAwMhiI5KvigPItmtaki980MxqhIJRPSt0IKprblMgwJE5AjT8Imu/S/ACt/AmEk0NTF84GcIR3Y3hDdwC28KFLKt84sTobwXATYtvahZPdJIWXwqMZfE9hmT0HcY9gz23hTDbRxtNxClAmxzqpd/kkjM3SozWIlsvbU8ebpyG61YAUFO6w=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(396003)(376002)(136003)(39860400002)(230922051799003)(186009)(451199024)(64100799003)(1800799009)(82310400011)(40470700004)(36840700001)(46966006)(83380400001)(16526019)(966005)(6666004)(7696005)(478600001)(36860700001)(26005)(1076003)(426003)(47076005)(110136005)(336012)(2616005)(2906002)(54906003)(44832011)(316002)(70206006)(8676002)(70586007)(8936002)(41300700001)(36756003)(4326008)(5660300002)(82740400003)(81166007)(86362001)(356005)(40460700003)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2023 10:16:59.2122
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a02e7fef-1d8c-4e4c-29f0-08dbc6556043
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB58.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4252

Current code invalidates single page and entire range for the given
domain ID. IOMMU hardware supports multiple page invalidation.
This series adds support to invalidate range of pages.

Also consolidate various invalidation functions, remove unused functions,
re-arranges invalidation related functions.

Note that this series doesn't add support for PASID based invalidation (except
PASID 0 for v2 page table). We will include necessary changes in SVA series.

Testing:
  - This series is tested with v1 and v2 page table and it works fine.

This patch series is based on top of SVA Part 2 [1] which in turn based on
top of iommu/next branch (Commit 8e5ab3f54a10).
  [1] https://lore.kernel.org/linux-iommu/20231006095706.5694-1-vasant.hegde@amd.com/T/#t

This is also available at github :
   https://github.com/AMDESE/linux/tree/iommu_flush_improvement_v1_v6.6_rc1


Thank you,
Vasant


Vasant Hegde (13):
  iommu/amd: Rename iommu_flush_all_caches() -> amd_iommu_flush_all_caches()
  iommu/amd: Remove redundant domain flush from attach_device()
  iommu/amd: Remove redundant passing of PDE bit
  iommu/amd: Add support to invalidate multiple guest pages
  iommu/amd: Refactor IOMMU tlb invalidation code
  iommu/amd: Refactor device iotlb invalidation code
  iommu/amd: Consolidate device IOTLB flush code
  iommu/amd: Consolidate amd_iommu_domain_flush_complete() call
  iommu/amd: Refactor domain flush global function
  iommu/amd: Consolidate domain flush logic
  iommu/amd/pgtbl_v2: Invalidate updated page ranges only
  iommu/amd: Remove unused flush pasid functions
  iommu/amd: Rearrange device flush code

 drivers/iommu/amd/amd_iommu.h       |  12 +-
 drivers/iommu/amd/amd_iommu_types.h |   6 -
 drivers/iommu/amd/init.c            |   8 +-
 drivers/iommu/amd/io_pgtable.c      |   5 +-
 drivers/iommu/amd/io_pgtable_v2.c   |  10 +-
 drivers/iommu/amd/iommu.c           | 417 ++++++++++++----------------
 6 files changed, 189 insertions(+), 269 deletions(-)

-- 
2.31.1

