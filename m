Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2048.outbound.protection.outlook.com [40.107.244.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C85311FC8
	for <iommu@lists.linux.dev>; Fri,  4 Aug 2023 06:42:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j61IJCAEoF5i8CiyI+ZE56c7ivfQyasQFreT6vnIY+2MQmSbEhg7BeElqsoC2luBL65ZwXa27jxj2/cf72Zn+djZc/Hex6cHh6yRo2803nm/AePqDuO0GJYcoqM/DKFU3JrVHIJcV1lU61YMvD2E5TdmwIWJVtresxS9+LnlryMLfxOULTUeFmxQu3xshD1h3gw7Nzu7Zwz2BYdSw3wZ7iffZASKTLU/VPMyYgQgDyUIwSfdMAj+z+MsfejzMS87fZ/d04DbvxV5pR/CPpWvD3QznWDw2gdXX/20AbuOHMGLAOF3lvE5Y4yOSWT+lKrbTPqO/avINJqzyE2I1LWS2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QOgeHECytdd2CkNNRLTmc3MO/nzO2Dylgn4ttmOd+e8=;
 b=VkJFoZGZHfO0VTt2vWH249Zmobf55Q0QEO/86IuhuWUN8hGp9zCrdHNFFtPrRVfuz8a8/fWknPMQ8sjFcCB4SQ5XrBLi9doeN1K5w2J9sIExcz8dANnj8DjRXDcDX8sLuxs/ZzMbTEgYlbsd+hxvaQd74VAJz3qDp5Cndky9wnvNbNN+fWiLOXRolpklYnbetvG0HG9hhrjEJyD1vgbyD/qmur+xuvg1rFhtiulip1/Pl0txgUxxsFy5AT+ee5QLwyvea6x96oG+o7yN7SiuZ0g5c+XENEmeQrgH89ahTOU7FNvRXSPPbXOV7uZj0jxZdZsBktmrlPslQFaEsi1Eyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QOgeHECytdd2CkNNRLTmc3MO/nzO2Dylgn4ttmOd+e8=;
 b=4119HJBIkAHYY9R4KoSGbXc6NG/HLddYW6Xg5o7taRotIVRN7p2Z68MdJmh42f60CJ1jyNgD5wqs+0NFrNT8olpblbnhA1rboh1v2tn59WHy6nGurjPxqqGHzYu9YB19S7BTRJGt2PZqgOU5v6OVZ9oWL86omsptOqJaxvTSUUE=
Received: from CYZPR11CA0016.namprd11.prod.outlook.com (2603:10b6:930:8d::21)
 by DS7PR12MB6216.namprd12.prod.outlook.com (2603:10b6:8:94::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6652.21; Fri, 4 Aug 2023 06:42:46 +0000
Received: from CY4PEPF0000E9D1.namprd03.prod.outlook.com
 (2603:10b6:930:8d:cafe::ee) by CYZPR11CA0016.outlook.office365.com
 (2603:10b6:930:8d::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.21 via Frontend
 Transport; Fri, 4 Aug 2023 06:42:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D1.mail.protection.outlook.com (10.167.241.144) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.19 via Frontend Transport; Fri, 4 Aug 2023 06:42:45 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 4 Aug
 2023 01:42:41 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v3 00/16] iommu/amd: SVA Support (Part 1) - cleanup/refactoring
Date: Fri, 4 Aug 2023 06:42:00 +0000
Message-ID: <20230804064216.835544-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D1:EE_|DS7PR12MB6216:EE_
X-MS-Office365-Filtering-Correlation-Id: c1b6044e-1cca-46c5-57c9-08db94b60307
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	c+0goqMurT5PUOaZm/8SW3FWEMwcnv+6dkKnEQxQh+0gJq4s2OBYeHk/Ro34MqbhuT4OxBnQhnZx6hkznIjdxE1P4mxGMV8FAy7nTCjW5VXFVEopcUzOoIunzcy7UuHcKR7m+gQPGJxs/sz2yuZMDCS/zuvHna4+jnlXwcc/Ak1c+3sX8wgekNihd4GlNZJfrcVFsI1dmPVQRw6d2jEppntFHVAMTstOyphBB7YwJ2mMz8szRySbSHwEc5lx5wufgeDvtg+wnZxnZp9jbSmX4ZARh3YJg54/V69cQzUkSPJMCXv7PqWQ1AcOf92pB2HFmNx0Qpz33norJaxs/ibr5nOcXHy9tvfrQb7egZveM1AxOqM4OrHATCN0QJn1hEasX7lAvljsHR5h6GU2su7wCqwXlzT3NviA4OB9bpwSOo9xMzGDX0d7M4EAm/moqm1m32JtU3vgHak3EvgvvYD5QJrvlJJxjxqE1c/8Wny16rObq/iXCURcBBsLNCnFiyDqiUxXgrPjLTPDb3a921dibNrO6yJM7bI3lnBs298/4rHvDtaUM3Ix7pJifRWfzr4XsLfxb8tAGwTW2N9VCcnazaVDn344GBNQm5pMHfiWps9ANUxqZTve5c4cXWNL/cX7lR0v7FNa7f1m23oqQ/7N1ucFXHOAtTp8EYm5sEeDtpP7EbpLL6ddcNT5Jxj6J8mZj3VBIIGW7hFPSvrzANVWM5J2Ow2E7q0Tx6sKKVGZbdY2q3IRLoqBBgVsSaup0/DhOTHqN2ogZhYI3isyZrLLwvWGCRYbrM82/2N4gEDpUCg=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(39860400002)(376002)(346002)(1800799003)(186006)(82310400008)(451199021)(46966006)(36840700001)(40470700004)(2906002)(40460700003)(44832011)(426003)(36756003)(2616005)(16526019)(47076005)(83380400001)(40480700001)(26005)(1076003)(86362001)(336012)(70206006)(70586007)(4326008)(316002)(41300700001)(7696005)(966005)(82740400003)(356005)(81166007)(54906003)(110136005)(478600001)(6666004)(8676002)(8936002)(5660300002)(36860700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2023 06:42:45.7891
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c1b6044e-1cca-46c5-57c9-08db94b60307
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6216

This is part 1 of the 3-part series to introduce Share Virtual Address
(SVA) support, which focuses on cleaning up and refactoring the existing
code in preparation for subsequent series.

It contains the following enhancements:

* Patch 1 - 10:
  Clean up, refactoring and miscellaneous improvements.

* Patch 11 - 16:
  Modify logic to independently enable PCI capabilities (ATS/PASID/PRI)
  for devices. This allows more flexibility in preparation for SVA and
  IOPF supports.

This patch series is based on top of iommu/next branch.
Base commit : a5003e75a171

This is also available at github :
  https://github.com/AMDESE/linux/tree/iommu_sva_part1_v3_v6.5_rc1

Thanks Jason for reviewing previous two versions and providing
feedbacks.

Changes from v2 -> v3:
  - Removed fallthrough from switch-case
  - Added lockdep_assert_held() instead of comment on top of the function
  - Moved macro defination (PPR_HANDLER_IOPF) to the patch where its
    actually used
  - Use helper function to allocate memory instead of get_zeroed_page()
  - Converted boolean to bit fields

v2 : https://lore.kernel.org/linux-iommu/20230728053609.165183-1-vasant.hegde@amd.com/T/#t

Changes from v1 -> v2:
  - Dropped GCR3 related changes from Part1. We are reworking
    GCR3 management based on Jason's comment. We will post them
    as separate part.
  - Addressed review comment from Jason
  - Added iommu_dev_data.ppr to track PPR status

v1 : https://lore.kernel.org/linux-iommu/20230712141516.154144-1-vasant.hegde@amd.com/


Thank you,
Vasant / Suravee

Suravee Suthikulpanit (8):
  iommu/amd: Remove unused amd_io_pgtable.pt_root variable
  iommu/amd: Consolidate timeout pre-define to amd_iommu_type.h
  iommu/amd: Consolidate logic to allocate protection domain
  iommu/amd: Introduce helper functions for managing GCR3 table
  iommu/amd: Use struct protection_domain in helper functions
  iommu/amd: Miscellaneous clean up when free domain
  iommu/amd: Modify logic for checking GT and PPR features
  iommu/amd: Add support for different types of PPR handler

Vasant Hegde (8):
  iommu/amd: Refactor protection domain allocation code
  iommu/amd/iommu_v2: Use protection_domain in struct device_state
  iommu/amd: Do not set amd_iommu_pgtable in pass-through mode
  iommu/amd: Rename ats related variables
  iommu/amd: Introduce iommu_dev_data.flags to track device capabilities
  iommu/amd: Enable device ATS/PASID/PRI capabilities independently
  iommu/amd: Initialize iommu_device->max_pasids
  iommu/amd: Simplify amd_iommu_device_info()

 drivers/iommu/amd/amd_iommu.h       |  29 +-
 drivers/iommu/amd/amd_iommu_types.h |  36 +-
 drivers/iommu/amd/init.c            |  36 +-
 drivers/iommu/amd/io_pgtable_v2.c   |  14 +-
 drivers/iommu/amd/iommu.c           | 489 ++++++++++++++--------------
 drivers/iommu/amd/iommu_v2.c        |  51 ++-
 6 files changed, 340 insertions(+), 315 deletions(-)

-- 
2.31.1

