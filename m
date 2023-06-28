Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2042.outbound.protection.outlook.com [40.107.92.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14D0933D7
	for <iommu@lists.linux.dev>; Wed, 28 Jun 2023 05:32:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VsEvNz6wSYc8e8bnCYOlbxCR4fczEoIYjdFKgRZ/getJiWnHYuuAy5KLo+pI+DDaYDbVWnmAz07La2kL56qV4nJ2PAwz6dMYB/gS71g6IoTDbpCY/5ZnxHkQXMDWihddjr00loarcLTj1gZ+TV9E6UlE+LL3e1NSMVREuhSDmaJp2ryxjsjI+TbqaCVXwiATz3nJSD+kcwsitN/BprfyYY4XYLvW8HKOtcsRp5yt2Sm6ASNIk8eTRGkgr/Gnrl4/UNttjYuxbVkBimYvHHDgTYIIs9X/nnOIBfXt17jmlzqZVi7JjOukSBXhRLBCOHkV6RLoMO3yLSazUeFut8yh+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zQoyGxGCIuQQSh4iNwOOI2DyVXTvRrkdHU/AeE95Xlg=;
 b=Bzj8/9j6o9czs6sE6gLUlZsDJlHjKtzeLybLAYLMmMxKxkx+VFzfKNrgr0ByGv9fJmB94E0d8NRjUagL/nybbk9hTWKhXACEWjI8FzmEQVwwZpDgNAzTInvubO0jugnOK65rR3zPzMlZ1ef6tMsXZMP51me/4hmlnkr6pIjJ1F/O3Pm/0kuE+3/5qbtQezdlhf+BDW7+dJzCwoM3V1coK2buEYoWxGk7vf0HPkX6Q0uvvuhqTBCE9zqdVF3xEq69rMyzT4HXIXW3i4U6B1NLgvjAm93AYsF3JrkFIXB3XyUrXc263KTj0R9GFZpqlJLe1ZcLMpnRAn1h9JCU0GVKGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zQoyGxGCIuQQSh4iNwOOI2DyVXTvRrkdHU/AeE95Xlg=;
 b=2zOzrBdvRlXoSC+jQNdm4L1sx7SU0snZ2HP0qhxzFx+1qB0nSH8TFf/TcPqXWj60oFi4BkNuFUInMxtq0BRWI6k9b2HOFB53KGbtiKn25t7oKxfU21xfsEGQktvFLxQpH1pYgGHcTz+KsZ0Bght6MaNSOWJwRFaj8uh2CJ+186c=
Received: from BN9PR03CA0583.namprd03.prod.outlook.com (2603:10b6:408:10d::18)
 by SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Wed, 28 Jun
 2023 05:32:41 +0000
Received: from BN8NAM11FT037.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10d:cafe::a2) by BN9PR03CA0583.outlook.office365.com
 (2603:10b6:408:10d::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.34 via Frontend
 Transport; Wed, 28 Jun 2023 05:32:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT037.mail.protection.outlook.com (10.13.177.182) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.47 via Frontend Transport; Wed, 28 Jun 2023 05:32:40 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 28 Jun
 2023 00:32:38 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <joao.m.martins@oracle.com>,
	<jsnitsel@redhat.com>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v3 0/2] iommu/amd: Interrupt handling improvements
Date: Wed, 28 Jun 2023 05:32:20 +0000
Message-ID: <20230628053222.5962-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN8NAM11FT037:EE_|SN7PR12MB8059:EE_
X-MS-Office365-Filtering-Correlation-Id: d130fedb-d9e8-4301-0e81-08db7799176e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	WWAnJ3OCPTu1gZi9ejdeFbMh7zKiIkEdQ9mputhxqxhrUmt4qbzx8YSAUcdUbyxDzk1X/sCzalOvs71MZoGtlQgHXXON4matXr1KmSU0P9jGmJj4TjYm4Kw03pYApugzq90YKfYrIYrLliz98H5WWYmj4JftPKsCc13BOSLBFAjSGluQqkSJehrlON0esjZ8Rp229hYuxo2t98Lp5PnYiFfSH2jk4bFLkrONBYXJckCiN5JjBGl+UYo/wDfja8wKBEeNdoqlKsGMruWJ64QwVW8r3LHvj2D0IA0CVlV+YXvzfrUlFwLFx/M/P0m1Zxjh+G0jUCr2qtfvJkJCgOe3Ucd471vA0uMBj9KpkWe3i2EBWS78TE/YDhaRUCQno1SSyYSLkt0cSM9Wy3wJt4mvZBUrr8VCKEJ7waSJn6CA9keCI8GAGjAWXvi7BQ0qVfcK0xizJEuLrX3w7sr/qD72O7v7GY/+m/xY4h6lNmfRtG5vO5bXiiIPEGxAhx6q38YeS2xaL/79Wd989AzPbC0xW+YVupJktgyP79HmEsJJ+0dhwGxxFunowecRa760aUZOqP2wGSLln7Ozp4JClYq9nbQAp+DAxhzub3rVmhOyrZZNKJbFoEFrlvrO2JqDgVMwctTe/1GnCSn47+XJPK+KNXvxab/ZsgmdTaLCyxl5XbPoB++EMWudiNttyc9wvrN/zOMgfl3PJQsxYK2WDMAMaBr7eq6gpa2y1HTm20R+SctzKDWVvH83tkzekEAYhWyJYps84o+BWQb0L/QpyFjxPARQTn41O57Xznzzceo/Ogg=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(396003)(376002)(39860400002)(451199021)(46966006)(40470700004)(36840700001)(82310400005)(36860700001)(26005)(356005)(44832011)(5660300002)(70206006)(86362001)(40460700003)(8936002)(41300700001)(4326008)(316002)(8676002)(81166007)(82740400003)(36756003)(70586007)(40480700001)(110136005)(966005)(47076005)(16526019)(186003)(2906002)(83380400001)(1076003)(54906003)(7696005)(6666004)(426003)(336012)(2616005)(478600001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2023 05:32:40.9534
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d130fedb-d9e8-4301-0e81-08db7799176e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN8NAM11FT037.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8059

AMD IOMMU has three different logs/interrupts (Event, PPR and GA).
Currently, the IOMMU driver consolidates interrupts for all three logs to
a single interrupt. This could become a bottleneck when enable GA and PPR
logs simultaneously. Hence separate these interrupt to prevent potential
performance issue.

This series applies on top of PPR overflow support patchset [1].
  [1] https://lore.kernel.org/linux-iommu/20230628051624.5792-1-vasant.hegde@amd.com/T/#t

Changes from v2 -> v3:
  - Moved log message to amd_iommu_handle_irq() - Thanks Joao

V2 : https://lore.kernel.org/linux-iommu/20230619133008.6221-1-vasant.hegde@amd.com/

Changes from v1 -> v2:
  - Moved GA log interrupt under CONFIG_IRQ_REMAP
  - Updated patch description

V1 : https://lore.kernel.org/linux-iommu/20230609102025.6498-1-vasant.hegde@amd.com/


Vasant Hegde (2):
  iommu/amd: Refactor IOMMU interrupt handling logic for Event, PPR, and GA logs
  iommu/amd: Enable separate interrupt for PPR and GA log

 drivers/iommu/amd/amd_iommu.h       |  3 +
 drivers/iommu/amd/amd_iommu_types.h |  9 +++
 drivers/iommu/amd/init.c            | 50 ++++++++++++----
 drivers/iommu/amd/iommu.c           | 93 ++++++++++++++++-------------
 4 files changed, 100 insertions(+), 55 deletions(-)

-- 
2.31.1

