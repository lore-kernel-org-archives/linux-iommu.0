Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2051.outbound.protection.outlook.com [40.107.94.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48B2B15C137
	for <iommu@lists.linux.dev>; Mon, 16 Sep 2024 17:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726507182; cv=fail; b=UJacfxzaV1qIziKwNnaOkeEptGPDON873HuU7ZIdSI69vj8DBIf9AvzJzeX+8bBqT6CSxxJLlbMi2qLdaBB18fZTPTOxgpBDewBQwDdQl5pDtYT+r0PRY3pBeqG0UfM6Zo8BEQ2TMO5DDJl3EMPFI8w+r0uEf+dlQeNoxze0NQM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726507182; c=relaxed/simple;
	bh=Cqvtnrx9nKOFGAPnLIZFvfNbaZqphF7l99TfQcN41So=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=R45FdFe7ArsW9ztbHy3XRWRMA4IpW6JxgLNl1fb9sFqfjbPT2wKFRDiZnuaQc6DfYPt4tbtVKnptRqVhcAlMP81hqdUc0xYyrCHA+3nDwf4rvxMsnmz292qVEX20fzKdr0HQYq2JhuWKsyHagyK0bfqaZJ1G7+q8TcxPFACYEqg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=KLMmyFxu; arc=fail smtp.client-ip=40.107.94.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="KLMmyFxu"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OZeLTTK7N4+ICnkp/YsIIASTG21gcQdNlzMWSVlRtMRkyDsz1Be1lZ29xHKip1986gip+OenG04zdfSunNbJYkgm3bJyanpYQiyamaLheerPu71Zp/TaZKPZdpaffo9ugwQBfTv8kqaJBH6QJaYKN24vQlC4PaeNgRF6wCY1pCu9q9CF0/ns+gLL9dlWYeakIdYHuLzgLBd0KAwbYnYK1UDg2H1VaMVJpOF7AzPaJTIp80rlAy1ZkpCYQJ+s3HL1GcoCEKqzSKWqeQKB6L4N7iNAJgVcwJB4nmoPbDNbI5c+nnnqh/3eYlCJkN1EDpTG74Xvf0j4aa1dhXQ6pfliBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dbn4sQQIPmihKgbreWyJUE3/0jTINLvwXWaKnriaz1g=;
 b=jULklQ2giTc78BLBWZAaUWXmXAZ8Oxrj8A/lRwA6XN7dQd2u9hbtUYg4ziMZ6fCN0yr5MM3UvkomIrtTn+RDyz7qYpeLHNVbSf+4ttRgSTpVFamM4xZzW07cK3R+ux8NAHL3kJGoy3dwlJ6vQpj6vElk15SYw31UfBegkvljK5Vst71rOHu6i7Vn+6eROIPTtd4qpFu5M9aDeHWBzsVb8fkCK/AIjrqQtVy+PNbOdWWjGvjLrRNqIS0sTlIfJhImJrvFye80qRklcbDWXRpiL+D8SvwyI7J1x2PdzbIRM6H7CodIpbbeiinKL61Ox57n0y6FTDjKbG3DrNTuvfK1tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dbn4sQQIPmihKgbreWyJUE3/0jTINLvwXWaKnriaz1g=;
 b=KLMmyFxuh3eW3Unyz8/ZOLspokr2l6KJt9HtbQEfcuSWY6bmu0bl5MjxQSzCWJuLxchqVnGmzS7onKM58jECMK4RFk56TmXSKIJZCC8H0VKxm8DsfSfdJKwMo+c14HVUNbM2eyf/+xsbS/CC1PczrFn18YV5hTC3gpXpJrLp4Js=
Received: from CH2PR08CA0025.namprd08.prod.outlook.com (2603:10b6:610:5a::35)
 by DM4PR12MB8560.namprd12.prod.outlook.com (2603:10b6:8:189::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.24; Mon, 16 Sep
 2024 17:19:33 +0000
Received: from CH2PEPF00000140.namprd02.prod.outlook.com
 (2603:10b6:610:5a:cafe::cb) by CH2PR08CA0025.outlook.office365.com
 (2603:10b6:610:5a::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.25 via Frontend
 Transport; Mon, 16 Sep 2024 17:18:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF00000140.mail.protection.outlook.com (10.167.244.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Mon, 16 Sep 2024 17:18:33 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 16 Sep
 2024 12:18:29 -0500
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>
CC: <joro@8bytes.org>, <robin.murphy@arm.com>, <vasant.hegde@amd.com>,
	<jgg@nvidia.com>, <kevin.tian@intel.com>, <jon.grimm@amd.com>,
	<santosh.shukla@amd.com>, <pandoh@google.com>, <kumaranand@google.com>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH v4 0/6] iommu/amd: Use 128-bit cmpxchg operation to update DTE
Date: Mon, 16 Sep 2024 17:17:59 +0000
Message-ID: <20240916171805.324292-1-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000140:EE_|DM4PR12MB8560:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ab2f25b-07ce-4598-b0f7-08dcd6739798
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fPmnpcnL7HYlbso4G3j7Y04uPMxLEtXlrThVfepqkJuY6pT4ItIDshtsvJWM?=
 =?us-ascii?Q?DowMIKgnsbJRrm/qi03y3QB6BkTI/vHA3KtqsXmp8UP0LitQTM4Z1DYPCqKY?=
 =?us-ascii?Q?6wp12tV2yU0d68lOiGCMCSjPP7s+5hpmW+p09Fbcg25C39Z+xXOvx6zNxAi/?=
 =?us-ascii?Q?BtHBpVh0mf6Wz9ocwHypyGXcap7UVhQT7pTPF1kczkg15XCSDA0xdTZ5dgWl?=
 =?us-ascii?Q?fU8S4AF5eL5xES4lycDDXGRaeMAMvOaVFpj1p1e5ekMyubN05qapclDy0vGN?=
 =?us-ascii?Q?gjP1ja2tEqITYwGpQ6/Teu+HWe0hDiRrM25a5pr4UC2CHHF4e0cglg2V6Fgd?=
 =?us-ascii?Q?Fc2LueLRR21ETVi/E1Ji2wDNNFSYkPUmN3oJjSZ0OucUm0/HT9oux8HV1XZk?=
 =?us-ascii?Q?cWW4t+4UdoyoRKWfKR+N4rioQ+bdPDHXykudqx6wTK8ogBuRQvRBJU1XQyFe?=
 =?us-ascii?Q?Wh/d0iX4PLSn7u/zbsHJXU8NT7ZwhgTl21LrNQFYATTN48rlK6MRro9frgjP?=
 =?us-ascii?Q?POK3Y1CbCyh+CabwP93pZtT6ezvyH7xIq4KjyLJCUmQinccoxXxz9nVvxj0c?=
 =?us-ascii?Q?6vLfvK34qxv0bufjibZCn4LTp0PeMzAa9QtgCl0gq6XnO8LHICPjc+zkwH5O?=
 =?us-ascii?Q?qMSaAqErwB8akLa6JgnepDTCWv4ROWwb4OtQFWdTH8Rf0wS7oeoSXGHiwIDN?=
 =?us-ascii?Q?unhDIsE7dXrc9VHoAUy8aKVhI7YX4s4P+OgsVxPJeVeUFhacvQk0zX+QZgfi?=
 =?us-ascii?Q?R1pjX3DllwbIQGHQzlYKAzDL2fPxLHpreijwMU5TH70ePjNw7i4CCqlYy80J?=
 =?us-ascii?Q?0qmd3KWEvHajd3deWkEWnkxuSWtyHI3DuVVJRXG0UHyy+56QDOde4b8Vx9UO?=
 =?us-ascii?Q?YVTA70FldqX5JRu/KhW2WyZv3sSLNcjsQTUrsoZ2gAu+jEJNQf8fuSwndlD1?=
 =?us-ascii?Q?TlP9/pxP3YtGxy4DfgwSRhu4NabG7UOHEd7pHD9SJoy2YoYuQGN6oXIIrpsH?=
 =?us-ascii?Q?mILfcw+1JTgHw1DOl3ex6yNs/pDy+ZiMwkMLpyHyP0/zpojvXvP93HyaveXU?=
 =?us-ascii?Q?/Lqpd7oNIkJ9/KhNdCE9e4oqYy26F4h1yB6Ztvw7ag2paNrQCclvuxLqGXLr?=
 =?us-ascii?Q?BztdGEZkoPRn61DGh/FkKARnKWiTgPR9KG57mrcgfpPCiC6UVUYlQCP+fga/?=
 =?us-ascii?Q?W2fu+y1EEvblZKLilJq0Eat9BOwnMeFVP++byjYrVN5mRgilnwB7R12lt5w9?=
 =?us-ascii?Q?ioOQJOUEtN5e0ncSMzDLZ6OPOeOAIDtU3OcRAwKFpW2irBkPh0uusxwG2vvZ?=
 =?us-ascii?Q?KKgUoby8pGM3WLFA113prZoMC59l32OCDFMovEk1s89kvhWbJl9uKXlBmCyL?=
 =?us-ascii?Q?QfZd0xSWeI2SMtiXvVdL65w27Vi/QB2v58w5yjKkqn0FXyOxnmRAm1g9tIFV?=
 =?us-ascii?Q?xdiLoVUC8568KMo5EqltA5ZhI3ktmUM23AC4FXDxfWtzs/mGIs3EXQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2024 17:18:33.1936
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ab2f25b-07ce-4598-b0f7-08dcd6739798
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000140.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8560

This series modifies current implementation to use 128-bit cmpxchg to
update DTE when needed as specified in the AMD I/O Virtualization
Techonology (IOMMU) Specification.

Please note that I have verified with the hardware designer, and they have
confirmed that the IOMMU hardware has always been implemented with 256-bit
read. The next revision of the IOMMU spec will be updated to correctly
describe this part.  Therefore, I have updated the implementation to avoid
unnecessary flushing.

Changes in v4:
  * Patch 1: Update commit message
  * Patch 2:
    - Move get_dte256, clone_alias, dump_dte to patch 4
    - Introduce write_upper, write_lower
    - Introduce iommu_flush_sync_dte
    - Reimplement update_dte256
  * Patch 3: Remove spinlock since it is moved inside update_dte256()
  * Patch 4: Update clone_alias() and dump_dte()
  * Patch 5: Update clear_dte_entry()

v3: https://lore.kernel.org/lkml/20240906121308.5013-1-suravee.suthikulpanit@amd.com/
v2: https://lore.kernel.org/lkml/20240829180726.5022-1-suravee.suthikulpanit@amd.com/
v1: https://lore.kernel.org/lkml/20240819161839.4657-1-suravee.suthikulpanit@amd.com/

Thanks,
Suravee

Suravee Suthikulpanit (6):
  iommu/amd: Disable AMD IOMMU if CMPXCHG16B feature is not supported
  iommu/amd: Introduce helper function to update 256-bit DTE
  iommu/amd: Modify set_dte_entry() to use 256-bit DTE helpers
  iommu/amd: Introduce helper function get_dte256()
  iommu/amd: Modify clear_dte_entry() to avoid in-place update
  iommu/amd: Lock DTE before updating the entry with WRITE_ONCE()

 drivers/iommu/amd/amd_iommu.h       |   2 +
 drivers/iommu/amd/amd_iommu_types.h |  10 +-
 drivers/iommu/amd/init.c            |  23 +-
 drivers/iommu/amd/iommu.c           | 332 ++++++++++++++++++++--------
 4 files changed, 265 insertions(+), 102 deletions(-)

-- 
2.34.1

