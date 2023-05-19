Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2077.outbound.protection.outlook.com [40.107.102.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2F7D362
	for <iommu@lists.linux.dev>; Fri, 19 May 2023 00:56:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OBW9OVl8PAXmsAvQ9XJJqHqVv23X7X0TWdStvDhjUmvke/taG6dbZgXv2f5HALTfFwRUlGesB67iDO5RoXuStepLlG0BwcK3Rs0QuquwGSItZIwcYy2YAmbDwmS5OAWZIev8/aoGyzfi6IgbVPhltc0dRdC0Nri1tBxOas8lZ3WF7mIi5Hne+RUc5jSGlJmRINxseZUDzCVEF3mJvzNVHBJQl03ikyvyEXN2MNCJfTs7ZC0nLBem5WhsA2N+HpjsDmDD6ztlVNa3aiqaz850g6isV2f51eeK/wJkWd8XjhXAPCx+GTbByevW6U6ebbpyeURVjE3dZgsKR1Z3ENvnLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SswM4iZWjT0MphktUFPYYp8g/TgBWbRCpuStOvDcPms=;
 b=NYoH9DZ+iUl4r5lCtK+MuVRBrU4nDwAqJeNB8Rq9iHXNfgakhDi2v/6muI2uqxKZwouXNIu1XcQCyh58hnKjszvfUTnRA9rTwACkCmOT18aUg5BZiQAbTs3fPl/n3TtkfGfNlomT3vScnEE5NIk6fUULoVjMQ0iNh5cq5QyE0Eh4lS+c5rgQwDXIxQdxZtH9DHWBdXJMtpBXXYvzgfV6xywM/x1In9YjgYbZ6q22Y9DiXlRvPb32DU5pUzdRpRVyXuOPvkfquaGCEKdMEKOp+EgJW/UkHdYMemNi7XufBqtGpJdE79lCKXv5hqZjjdFZVwqAD1pWPCmHJps7eR9sug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SswM4iZWjT0MphktUFPYYp8g/TgBWbRCpuStOvDcPms=;
 b=WZFGxngkCbb6WgFDnB7hZREkYAtw9qZnUg3u4SGiFVnOVf8V3PhMoEf/SarxPVnmxLLMFLf9Tzwh++RzisDhGOfN2Vtfw6+AMCOc7keH1WwGXapofj7LvojZrqfpEVSJNXnulWmrT7Lzlg3zXu7AnVRTcYM+gaR4FQr+EIne8Yw=
Received: from MW4PR04CA0373.namprd04.prod.outlook.com (2603:10b6:303:81::18)
 by SN7PR12MB6864.namprd12.prod.outlook.com (2603:10b6:806:263::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Fri, 19 May
 2023 00:56:03 +0000
Received: from CO1NAM11FT070.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:81:cafe::94) by MW4PR04CA0373.outlook.office365.com
 (2603:10b6:303:81::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.19 via Frontend
 Transport; Fri, 19 May 2023 00:56:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT070.mail.protection.outlook.com (10.13.175.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.21 via Frontend Transport; Fri, 19 May 2023 00:56:02 +0000
Received: from titanite-d432host.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Thu, 18 May 2023 19:56:00 -0500
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>
CC: <joro@8bytes.org>, <joao.m.martins@oracle.com>,
	<alejandro.j.jimenez@oracle.com>, <boris.ostrovsky@oracle.com>,
	<jon.grimm@amd.com>, <santosh.shukla@amd.com>, <vasant.hegde@amd.com>,
	<kishon.vijayabraham@amd.com>, Suravee Suthikulpanit
	<suravee.suthikulpanit@amd.com>
Subject: [PATCH v2 0/5] iommu/amd: AVIC Interrupt Remapping Improvements
Date: Thu, 18 May 2023 20:55:24 -0400
Message-ID: <20230519005529.28171-1-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.31.1
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
X-MS-TrafficTypeDiagnostic: CO1NAM11FT070:EE_|SN7PR12MB6864:EE_
X-MS-Office365-Filtering-Correlation-Id: dae670ee-9603-436b-a675-08db5803d1a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	mySPGbYYF8D0RPdMmiTIk6oZACFLnZ/iVVko+3JtHC5JUwVA5LraHRTd12x4CjNAuKMpOBvMGZM08t3j8aqD/yJ3Z+SjgU4fsSt322jo68qnA+4HftmfV+z/VTsu+0qB/OKZIHL4EDHPzjl9iaeWHSuCsq8rBu1a9g1Nw/JrTd5gA78k0vcvRaNn4bYel3P1RBXO/t103r6v+teGwLjko4lTOm1Ly2L0xdoYuR30i2dcHkU/FVvKzYgPYxaYJlgWHbmqAKR3+npZ0o+uHbUQNL1qRay10GZbF2x5og7prjwMrhWj0yzp+HlZ7VM/VQzS1c5LWiaNkpH2o1Rk3qEuyGHzdKhywprnmf+JhO/uHE0fp6++I71YH1a8mQ3yqyt5fo5EyeF9HaEvQALiePTC9kDO7orvaFy43Mcp7a2xUkqNkYBHF/Z8FW7NZxPY0kpi5oMshcjURKwWhn/thZTaym2zF2SvEVUvdWeng3rD2KoHeH++lyM0krSK1b6WbdCGTT1dDtBSOKYaaCa2na85Sf6y2gfZ//vEOsG+AxvbNcBxjjxsO/bsdo2gxmq5j6VVbX3oCcQNbCulqJY1a+XN5JHoLDf+QamqPMA3qa+ot+4zQF67VgnysksPApixl+6xO6PSbYp3vkvAjRYP+yBZubWCus1YZ83AGFu7+NY1AGBlj5DTTvfYAUrn3d1fThHI8VLWeqKWBj63UdL+iJ9670rC1boZnL1RodBtfMECf5lMFKKd2cH+ARDnpf7dRngr
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(346002)(396003)(376002)(451199021)(46966006)(40470700004)(36840700001)(82740400003)(110136005)(4326008)(70586007)(70206006)(54906003)(478600001)(6666004)(44832011)(316002)(7696005)(8676002)(2906002)(8936002)(40480700001)(26005)(5660300002)(1076003)(41300700001)(82310400005)(81166007)(86362001)(356005)(426003)(16526019)(83380400001)(336012)(2616005)(40460700003)(36860700001)(186003)(47076005)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2023 00:56:02.6582
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dae670ee-9603-436b-a675-08db5803d1a2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1NAM11FT070.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6864

For IOMMU AVIC, the IOMMU driver needs to keep track of vcpu scheduling
changes, and updates interrupt remapping table entry (IRTE) accordingly.
The IRTE is normally cached by the hardware, which requires the IOMMU
driver to issue IOMMU IRT invalidation command and wait for completion
everytime it updates the table.

Enabling IOMMU AVIC on a large scale system with lots of vcpus and
VFIO pass-through devices running interrupt-intensive workload,
it could result in high IRT invalidation rate. In such case, the overhead
from IRT invalidation could outweigh the benefit of IRTE caching.

Therefore, introduce a new AMD IOMMU driver option "amd_iommu=irtcachedis"
to allow disabling IRTE caching, and avoid the need for IRTE invalidation.

Patch 1,2 prepare the AMD IOMMU driver to support IRT cache disabling.
Patch 3,4 introduce IRT cache disabling support
Patch 5 improves the code path in IOMMU driver for updating vcpu scheduling
for AVIC.

Thank you,
Suravee

Changes from V1
(https://lore.kernel.org/lkml/20230509111646.369661-1-suravee.suthikulpanit@amd.com/T/)
* Patch 3: Add logic to clean up the IRTE cache disabling
  and handle kdump code path (per Alejandro)

Joao Martins (1):
  iommu/amd: Switch amd_iommu_update_ga() to use modify_irte_ga()

Suravee Suthikulpanit (4):
  iommu/amd: Remove the unused struct amd_ir_data.ref
  iommu/amd: Introduce Disable IRTE Caching Support
  iommu/amd: Do not Invalidate IRT when disable IRTE caching
  iommu/amd: Improving Interrupt Remapping Table Invalidation

 .../admin-guide/kernel-parameters.txt         |  1 +
 drivers/iommu/amd/amd_iommu_types.h           |  7 +-
 drivers/iommu/amd/init.c                      | 38 +++++++-
 drivers/iommu/amd/iommu.c                     | 97 ++++++++++---------
 4 files changed, 94 insertions(+), 49 deletions(-)

-- 
2.31.1

