Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2055.outbound.protection.outlook.com [40.107.237.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F354911181
	for <iommu@lists.linux.dev>; Mon, 19 Jun 2023 13:30:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kvotzg8uEr/srQ5smRhXA4Ctcddo5FxUMrJUdkGWvIVsUtLS30NvzGt8272m7FdsJgco0+c8pd8SvK2l970kQMSqJtuNlCXWyA7BR7FSzx1VBVOmc1JHKy8W+dMpqTKyB6ZZYAS8UbS5294f8+rKXZy5TaxhLw1owF/6yg4MuroKTHMr2QtZF91mjmHbf6skWb+tOSlFctVm2rd24TdiSccEpmrHMibyaIQwG7DX/JnDCIPQ99Osgl0x7wtwuGwPRummrrFD3U+vMCC1M0+/lfFRNU1Dcu1pRBoUTTbaZz4tpOgglK0utEPmxouXKvZReEITVSXE+HJSvtEYX3MCAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W5ak3gn2i4ZRNJeFYDOkJ+JcW5nida84mPtdreLPPM8=;
 b=WtuVWn1EX4wiLo9gV2K+Aj62SmTRrodnoAJGZhPQ30EEBNtfTvXmeAgbF8/DBsgzpc1CJE7g8Rz1eOC9sLGnC1x1FvEUViz/uqVL4BoOvxfJNZb2O7tdOah06TaDHdlscJAfv7+vq+9g3Vj4Hph9kbCoNfELWj57GcJZs+a7X0twNPJJuOUvqB+6FQjWbHLtY8JAVlJ9D6zgpDVP/5CdpimrWzIhAs8mOdh9Sf2iIh2G6ipFuPYHW08+HJMqG+7LkdMh7chJo5XYtG44xTB+e+XfeLwpW2qa6SmZGIRv2xiPLbTuRz8FdcjjQEI8q+vPrvPiSoaWDCNXFjbYiX920Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W5ak3gn2i4ZRNJeFYDOkJ+JcW5nida84mPtdreLPPM8=;
 b=c9F7bfvmNLOrJX3bMo/dxRu8lZ5FWu/zJwjjVTbx3dkbfs1nRdMonem+KMzBDKfo6EPfUhZfXYdvt28aks0ts6xmQYSu8lD7iakkz2VQ7to7ehI8V2icLQRZfIx9l9jiIMb9vvElci4A2G7NtjS8ndhLjGofuAMPnAjeJTsZDr4=
Received: from DM6PR03CA0097.namprd03.prod.outlook.com (2603:10b6:5:333::30)
 by MW4PR12MB6731.namprd12.prod.outlook.com (2603:10b6:303:1eb::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37; Mon, 19 Jun
 2023 13:30:28 +0000
Received: from CY4PEPF0000EE3A.namprd03.prod.outlook.com
 (2603:10b6:5:333:cafe::2c) by DM6PR03CA0097.outlook.office365.com
 (2603:10b6:5:333::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37 via Frontend
 Transport; Mon, 19 Jun 2023 13:30:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE3A.mail.protection.outlook.com (10.167.242.14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6521.17 via Frontend Transport; Mon, 19 Jun 2023 13:30:27 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Mon, 19 Jun
 2023 08:30:25 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v2 0/2] iommu/amd: Interrupt handling improvements
Date: Mon, 19 Jun 2023 13:30:06 +0000
Message-ID: <20230619133008.6221-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3A:EE_|MW4PR12MB6731:EE_
X-MS-Office365-Filtering-Correlation-Id: fa0317c1-5213-49ae-8a83-08db70c95876
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	E57qvzqtzwuTEVKFdyzVPCZcpsyHMeOHKo1lv/KBniGQgokaiK/wiP62LCmhV227cfwSk1COQSMlgkKhQJlZcheCwVWesnaW9KP8zFUEhdvOt3ruFlj2CIJr6MuMjXW7UZglAt3jKXZeSE+fGIgbV1GZXFkhXIm0MTsZXxdurVFPdgtFx4q9WH1OW3e+US/WBv+6GBdLLTeBSPgy+8NewmV4k3YDjH+F9YXJTnWxg5hpVmYoEPWbWiQk6H9UaAxlmd2ZBup0fbOMkkPjzHghlkHwPx86Ba5jMYmUvNXbPrDO1hK0SLwBbTBZ3LEN96G2hHuqZZxwJesCQlBIglpBuIuijJZMGSuEThn/t5hlVYBf5PWi2NeFG2aLXaY2SUbD5S2bJ7d+Gtssyp1p1vz3tR+OfeAW1kOrzur9Qm7UHok8Sxc/MEZVw6Vu+jw1lz34h9V+OYes+VrcyvmGFi6ePGtfTouQOJs3Qmbx9/VFJLVIYZbFyCg34PGZTc5zk35cUoFB0JqoL3bfnzckL6Tc76MMPtxNp1RYKt+4zKxGgXzU2jP0Jwp891wHKfUFzmClicC2nFxvDx/YenWrbdpwfKtjr3AV3tGrNsaH1fgmAS9dyuixh8QN7FaU7QZ1EOLxYTgO8abR/sjnb5u4tbAvxPpB+dpkh7DZAO24i24dJENNwFVUpudhNs1ftVgiOwGcJQ2+m9vehllygVKc4ctJbrHH4clvOoW5c4y0RCW3XzmgLXCrPEg1aDjneDqMZe9HUZpcUfJ6VSDmwsgUUkdJ0cXj0KqOddug3DXr06Qfprc=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(136003)(376002)(346002)(451199021)(40470700004)(36840700001)(46966006)(41300700001)(5660300002)(44832011)(8936002)(8676002)(2906002)(40460700003)(82310400005)(36756003)(40480700001)(86362001)(26005)(1076003)(54906003)(110136005)(186003)(16526019)(478600001)(7696005)(6666004)(966005)(81166007)(70586007)(70206006)(356005)(47076005)(36860700001)(4326008)(316002)(336012)(426003)(2616005)(82740400003)(83380400001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2023 13:30:27.6864
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fa0317c1-5213-49ae-8a83-08db70c95876
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE3A.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6731

AMD IOMMU has three different logs/interrupts (Event, PPR and GA).
Currently, the IOMMU driver consolidates interrupts for all three logs to
a single interrupt. This could become a bottleneck when enable GA and PPR
logs simultaneously. Hence separate these interrupt to prevent potential
performance issue.

This series applies on top of PPR overflow support patchset [1].
  [1] https://lore.kernel.org/linux-iommu/20230619132346.6021-1-vasant.hegde@amd.com/

Changes from v1 -> v2:
  - Moved GA log interrupt under CONFIG_IRQ_REMAP
  - Updated patch description

V1 : https://lore.kernel.org/linux-iommu/20230609102025.6498-1-vasant.hegde@amd.com/


Vasant Hegde (2):
  iommu/amd: Refactor IOMMU interrupt handling logic for Event, PPR, and GA logs
  iommu/amd: Enable separate interrupt for PPR and GA log

 drivers/iommu/amd/amd_iommu.h       |  3 +
 drivers/iommu/amd/amd_iommu_types.h |  9 +++
 drivers/iommu/amd/init.c            | 50 +++++++++++----
 drivers/iommu/amd/iommu.c           | 95 ++++++++++++++++-------------
 4 files changed, 101 insertions(+), 56 deletions(-)

-- 
2.31.1

