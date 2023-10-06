Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2066.outbound.protection.outlook.com [40.107.244.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D99C125B3
	for <iommu@lists.linux.dev>; Fri,  6 Oct 2023 09:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="xKuYOYl9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QXoQ1ZqVnyVEyn30tHF1pBzHrXw66heAE0jzR8zc/+TXvw5eOsviMWcY3zBuTrD45WWiW4ALwiPPfeqIk3YU6lb6YRw92XayRIfVYHJto5Ul0A0ZUkRi8KcMjDESzBaddQiUHBk5Kk7ZsFWMjrXBbthevlnQ1TBHzCpN1dyYAo/jMrkV2EQyLJG8S/uNZO2lpykUS4ssyf9kwEe4WYQQc1T2m3W0dW6ewE9GKPYrMldCAzRuYwFPDX3qu7/roqWreGhurCjzuK1/NiwmDiPUouDpK24PcwbNSqQeOlDtuHj6UUYuPY1jOREL79NQmVq0Ad+8QqecYWEzyzyCIAEZdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n2/D/vymxKAPf41KVvejgSmzJGCOVTeC8eCwRYKhYcs=;
 b=Xiu+anhP9qfeQbZvr4ytvvepPcLXCyQ4wiABR1GYiES+arHA7bimtKkZylYTKCYGAACc0le6JlCpbqL5YPGMT66uYEwy65uwWHXaSVkzFvMCz/JO/uyZpUrLM8BMqenM/VnbqrY01aXLjE6hocYF195vkrPClemXMf9sVMNJkEBIeNKXBkIxRAvAMw/M2Y//elLARmIB8w0zWNVlFPrGrh1H8hgkjindkjacp2+2lyIDLnWz5u/YeJKC68MzF++6HuD/OUj3aE6g0Y/waeqvHgWG1eAQ2X6U1vXwKFvW6+EYM+Gkin4Fb+XR42iLSaG6weap9wC7Ex0frqmjdgjCEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n2/D/vymxKAPf41KVvejgSmzJGCOVTeC8eCwRYKhYcs=;
 b=xKuYOYl9GTKN8U0q2STKnwRWY51VJLHA/EKU8ixbzlKLjRupPODexf2z1lHTItCaUaOM7yjyOB7GH0W5ILJroJqXO/h5gODVjptNVrQmPURTKqSPNgtBBPGrlxlYM8HYnmMbpXIhZujxZ8BtfApc5TZdPKDtkyxJHqhbPPrXJwE=
Received: from CH0P221CA0014.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:11c::12)
 by CY8PR12MB7121.namprd12.prod.outlook.com (2603:10b6:930:62::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.38; Fri, 6 Oct
 2023 09:57:36 +0000
Received: from DS2PEPF00003441.namprd04.prod.outlook.com
 (2603:10b6:610:11c:cafe::4c) by CH0P221CA0014.outlook.office365.com
 (2603:10b6:610:11c::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.30 via Frontend
 Transport; Fri, 6 Oct 2023 09:57:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003441.mail.protection.outlook.com (10.167.17.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Fri, 6 Oct 2023 09:57:34 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 6 Oct
 2023 04:57:31 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v4 0/5] iommu/amd: SVA Support (part 2) - deprecate iommu_v2 module
Date: Fri, 6 Oct 2023 09:57:01 +0000
Message-ID: <20231006095706.5694-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF00003441:EE_|CY8PR12MB7121:EE_
X-MS-Office365-Filtering-Correlation-Id: 41598795-8344-4a2e-8985-08dbc652aa30
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	cbjtyViJ+jtIcX9bnNDghZVCc+VXgYHqNt2gI5nUKsyc/pSKl99y78zrnGPJYohHDMynoofbiwhOy+v6IukFcV/iqwfS8UqY94etMprf2Hkbvma49FPSO6xgnyiom23VIJNUrU5Nif6BRjNDhZzOb3wTpzsmwwe8sX9tsDSN/C832sezO2D8e39w5WV7y1TQkYF4eMDcY9SGPaIsWHdZdyzSVgqi174p2C+ReFq1P0kvXRXiNt3P3hHdJ9tQ06uHnED9KoGyv/nVaUTE5XHNfHGGQUDWZQlIXgL2Oo2uzlwFnHEFtvpNQC+aBTynZLBOB/pRiBU/gaKbUWo8KiRMwRsAU/INE1NOvSTTh328wpzdkCRZRAL7WiAvdR+cRC4q2HnMSPVD535JexREaeHDkYkeP/GjOlR+V61Nm0IubRWjZer9mr8b4qyTdlpn46+t4bqcQLqWbZVG0eiNZetpb7eHRlnpAhE6nvlBzmkRQSF9xl7apzUGlZmNXtYGi+6JyEY/zCKsFJHs/fTw999EM+3dD7Z9hbg0XCDblmAh1na9np4VO3UahTKJraW5iywl/oQ9IciUlxD0WwXXRNPJy2piVZy+wblWm6UqHJgsvpDMu4kimyYFsBZGf/zgsEKUQkyAR7qJdicm1lQgKGyH17cFrjKfjem2JJFjRyJKh7EW9AipGmOkGCpAuko2NTH+TzrYXxUR2ngjf3/uBOMm+4vy6ZMEF4xrxV13Z3zeqaHSd5DniHg9JvcqZxrv5CKUQrDgI+kOkmsvoByBOzrTHO/GFZe3hJEQmvvfbcZcZ0c=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(346002)(136003)(376002)(39860400002)(230922051799003)(1800799009)(186009)(64100799003)(82310400011)(451199024)(40470700004)(46966006)(36840700001)(40460700003)(83380400001)(2616005)(1076003)(336012)(426003)(26005)(16526019)(47076005)(70206006)(36860700001)(110136005)(70586007)(54906003)(316002)(8676002)(8936002)(4326008)(5660300002)(41300700001)(44832011)(82740400003)(7696005)(6666004)(2906002)(966005)(478600001)(40480700001)(36756003)(356005)(81166007)(86362001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2023 09:57:34.7201
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 41598795-8344-4a2e-8985-08dbc652aa30
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003441.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7121

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

This patch series is based on top of iommu/next branch (Commit 8e5ab3f54a10).


Changes from v3 -> v4:
  - Rebased on top of iommu/next branch
  - Added 'Tested-by'

v3 : https://lore.kernel.org/linux-iommu/20230921093140.6162-1-vasant.hegde@amd.com/T/#t

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

