Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2049.outbound.protection.outlook.com [40.107.223.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87A981B0F3B
	for <iommu@lists.linux.dev>; Mon, 28 Oct 2024 09:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730108324; cv=fail; b=Lva9lpwxyovf8GMIzLjfgo67CSptXSCKGPreZL+mNojLxZiOmo3nNuLOMVh15xXeneQSEE5zkahZoVGJbhKEZ1YRoHj9BQ4afu9hjHLA8v6zVJHPBzoQFcL/XS0QmlYoRhYEkl/vUAUpJbpP63KBzrTGOXb83EqMjkhCGs9SLv0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730108324; c=relaxed/simple;
	bh=IZfn+RWrcBRZ4xgIiuH+fAXw5MbUXrbTsGN07HWyEu4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RKiC8rcrc4+90vn3Sx2Cw/TllOUcjEgwZ6GTU/H1YyReIqz9WFy1iy43Tki/5SrvNXhqKwrzlk90D8eQgVpRNNdShAHj4Z0v9Oi/D8NPfD89AEqAQyiOIlmotV6UovmWY5yNw6G5lqUF+tL/JrsOsS2hUdjHE6jMlIAiqyL1vQo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=CGKQWEeG; arc=fail smtp.client-ip=40.107.223.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="CGKQWEeG"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H2Wo7ypO5rs4HHl/GpvX6WDkfLITnNyhY3j5DcWsyH5nYAS5SHEsieI9sE51eVAO9ImTeY4/4ztK5O3ohGzuA95J37ARzBXdlsYu38OYhWq3hvmQG/41RpsDNBFcdOVZuTusY+14R3VMVZYKc1hk7cWGi0JSayVn9QtTGvc8dlUagUWajEPQU8YcTPiWXb8S35Adp0Ipdm08A21VxZFyOo2ilkqg+9C1IQ3d5Aaduk2v8VmzURc8kFrd8kQcZelnfLqtlHrL58OEL7el2gV28AXU+jAe5TJmjMwpad+Sf7XA2ICvCjLIoCXizaoPbV1o/ZCJ4CCMrOlW6vLXUKLajA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lJn+9tzYGLR/t+lHhgipJ/ivYZexQFzTVPNjXRtHWpM=;
 b=jGLpGbovnae7DCkKFh81Cq1gJdUOC0lk7agQ6wkudAKGkbnEVQyaq7PLJ2vOgiufDeVeyhNk+eiHa+YZwVwBC1uHzDYZUaGgerCkqg0dhXRZwefun+K5psvjafDKR0jHTtjDxvJ6HWzPMRHLtj01gwcFRA8LleASNaHARYb2t2FZE2eDPuuhPZM1qqdM3wW1TGWl2cMKlbrsyTM4Txu3GQFOSqHhRKQdiYAdHKC/aONN7PP1DESQZxGuKkBN+oNy/lPy1i4oy32/kJDkNAw5bPSusxTIVnblSVKR9sHY5JUPsVNP1YYyTXgj0kDh/w+sAp+HtH8u9fPxkBYO6Vg7YQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lJn+9tzYGLR/t+lHhgipJ/ivYZexQFzTVPNjXRtHWpM=;
 b=CGKQWEeG0e1VzF5cIMA3c77AMLceJlEtiaJN/W6+Rzki5S1FD/b1r96rdB8fNhp/0XvJG8LZPwCjzxzpHNabX7+vbC1ogrDm3FFXyxeR2057nl/9D3hjw9jrc7Jr5qFIRbOXyElQtC70xgaR4WJCLx3R+7kFrHlGWE7SRCe8VnU=
Received: from MW4P223CA0006.NAMP223.PROD.OUTLOOK.COM (2603:10b6:303:80::11)
 by BL3PR12MB6569.namprd12.prod.outlook.com (2603:10b6:208:38c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.24; Mon, 28 Oct
 2024 09:38:39 +0000
Received: from SJ1PEPF0000231F.namprd03.prod.outlook.com
 (2603:10b6:303:80:cafe::9f) by MW4P223CA0006.outlook.office365.com
 (2603:10b6:303:80::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.25 via Frontend
 Transport; Mon, 28 Oct 2024 09:38:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF0000231F.mail.protection.outlook.com (10.167.242.235) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8114.16 via Frontend Transport; Mon, 28 Oct 2024 09:38:38 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 28 Oct
 2024 04:38:34 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <will@kernel.org>, <robin.murphy@arm.com>,
	<suravee.suthikulpanit@amd.com>, <jgg@ziepe.ca>, <yi.l.liu@intel.com>,
	<baolu.lu@linux.intel.com>, <kevin.tian@intel.com>,
	<jacob.pan@linux.microsoft.com>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v5 00/12] iommu: Domain allocation enhancements
Date: Mon, 28 Oct 2024 09:37:58 +0000
Message-ID: <20241028093810.5901-1-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231F:EE_|BL3PR12MB6569:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d7f442e-7a59-4a32-93d1-08dcf7344d04
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?iseeXHUT0KtyUfMXD8dgSuo0wqedrmNfKYm56JZLi74SwwYhRELhePoD4k6O?=
 =?us-ascii?Q?lseOvGLJm04ePU1vU2Qrq1HZcTsQgv0usSMC+lqyFS78oy2lffAbL9Y+cEC/?=
 =?us-ascii?Q?K1yMPTioouK00BMHohvQXxu/uZErylgR/Yeu8TLmSF9x8Kb8ArEofudhJRqo?=
 =?us-ascii?Q?2mkqWcjDXBEWsiPfehk2GIDu7+5hHd7YMfl1zwVr+L0NiJpgnMD8wHXOFqpd?=
 =?us-ascii?Q?/N+32E3xFCAWrglNaSi+Uoj927m1RBwJ+E13HDR3kFK/EimLZ95JG7Zg+iPQ?=
 =?us-ascii?Q?3Xml84FywX8kYJ8u+SGgKFzPX4l4bCrssZL7DVwqLfyjnZkRb7/BGmIe4dzX?=
 =?us-ascii?Q?zKTaMcvf1B95JE/GXZ8UURZX9Ko4lB3j0HxvJnR1plOVorzqS/HQtmuI3EMO?=
 =?us-ascii?Q?Xh+b5DX2dwvyGvAKh53L+DhlcI+yG1/WZKWejfncxClGYYthr/mYhNyNCrrr?=
 =?us-ascii?Q?BYn1R8qlrHgma9DgBxqCC4FEC9fdpCOXK34nFlsq2Nkwmfk+VaqbTB9l0RWU?=
 =?us-ascii?Q?Yb+PZMbZfHtStJ/7Z4Q83U48ZHJOjUaQhqZAjElilhTEA6QLqmB/KzADr88h?=
 =?us-ascii?Q?Lxo/nX85xq76CvT1Z1S3cNYkphRwpkIsSDGwum5XPeM/Dqm1cmJ/80HDdloK?=
 =?us-ascii?Q?7AikH9//g2PW+pdgibTUHL2TMYTnvJRo4ViVYQEbqvyt136A8DNav2LmDthc?=
 =?us-ascii?Q?viwK6NAVYsDO5SqGgqq9OH2Q719POroPBvHUkCcGbtPF7eYs0K0o4bOvLrgy?=
 =?us-ascii?Q?A7/LifoSSpNetMVn7zsbD7dzz7DRyaCpY/11fjJHRrBTq+x0J2cZ/4makM7Y?=
 =?us-ascii?Q?tDVwUc7JeW/MP26NH3qFcpJ7Qu3yU04JV2LVj6lvku2B8+J4XQrauRGPm8mK?=
 =?us-ascii?Q?UK75p6pxOntnwAdBInJbki5oUTnd5idnJEPAZZKGtyTryunfSp9aCreZ/FL6?=
 =?us-ascii?Q?cwvIhNNpmVC5z87eemGN/q501GD1BwcBrSsXAD+cQPqaUlz0ylSausZUVKoj?=
 =?us-ascii?Q?RutnfbCOhiBKzmcabRNYxvjsLY2HrcAwCJ1P6COaUahUx+DMU3w0vb5zSJxe?=
 =?us-ascii?Q?9WuEJxgJ44j4otZlUbs1tl6Bhb2pKh/hJ4XzZzRr+tcZvVZoJHok/2nCE+V8?=
 =?us-ascii?Q?sjYqkqfytaa/Iy09bPaoFNRph2hTdfAGixRpiYQpqub7XtkjuK37ag9jP+rp?=
 =?us-ascii?Q?k3XHTmYRB9TjStFLntR6q4+9TaHtX8P2WLcbdx8AnKl/zNjv7JXei+8PiHnU?=
 =?us-ascii?Q?CJ2vayFXtodVA88DPZC+0tlPWY3n4kQXA4naj1VTcLWZjeTTHtV0b/2bm8bF?=
 =?us-ascii?Q?YHklMD1ey3OPt5vSfT4TR1GxUZcnMvSRlM+3mx4pdU9vDxTSJBWHtLnSIdZu?=
 =?us-ascii?Q?sQJ4cCU=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2024 09:38:38.0710
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d7f442e-7a59-4a32-93d1-08dcf7344d04
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF0000231F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6569

This series adds iommu_paging_domain_alloc_flags() which takes flags to
pass additional details for domain allocation (like domain with PASID
support). Also adjusts core code to handler variuos domain allocations.

Also updates AMD IOMMU driver domain allocation code. With this by
default it will allocate domain with V2 page table for PASID capable
device and v1 page table for rest of the devices.

Thanks everyone who reviewed previous version and provided valuable feedbacks.

This series is based on top of v6.12-rc3.

This is also available at github :
  https://github.com/AMDESE/linux-iommu/tree/iommu_paging_domain_v5


Changes from v4 -> v5:
  - Updated amd_iommu_domain_alloc_user()
  - Added Review-by tags


V4 : https://lore.kernel.org/linux-iommu/20241023104207.5894-1-vasant.hegde@amd.com/T/#t

Changes from v3 -> v4:
  - Added Review-by tags
  - Updated Patch3 to handle -EOPNOTSUPP and allocate non-PASID domain
  - Updated amd_iommu_domain_alloc_user() to do flags check first
  - Few other minor fixes based on review comment


V3 : https://lore.kernel.org/linux-iommu/20241017140137.6028-1-vasant.hegde@amd.com/T/#t

Changes from V2 -> v3:
  - Added Review-by tags
  - Fixed warnings reported by 0-DAY CI
  - Added patch to enhance arm_smmu_domain_alloc_user() to support IOMMU_HWPT_ALLOC_PASID flag
  - Added new patch to check GIOSUP/GTSUP
  - Added patch to move V2 page table check to early_amd_iommu_init()
  - Added patch to adjust blocked/identity domain allocation in core layer
  - Dropped "iommu/amd: Add iommu_ops->domain_alloc_paging support"

V2 : https://lore.kernel.org/linux-iommu/20240911101911.6269-1-vasant.hegde@amd.com/T/#t

Changes from v1 -> v2:
  - Rebased on top of iommu/next
  - Split patches into smaller patches
  - Added global static identity domain support

V1 : https://lore.kernel.org/linux-iommu/20240821133554.7405-1-vasant.hegde@amd.com/

RFC v2: https://lore.kernel.org/linux-iommu/fc8715e4-fb44-433b-a42a-7804118ebc57@amd.com/T/#t

RFC v1 : https://lore.kernel.org/linux-iommu/7e249bc6-c578-40f0-aca7-835149a0ad39@amd.com/

Jason Gunthorpe (5):
  iommu: Refactor __iommu_domain_alloc()
  iommu: Introduce iommu_paging_domain_alloc_flags()
  iommu: Add new flag to explictly request PASID capable domain
  iommu: Put domain allocation in __iommu_group_alloc_blocking_domain()
  iommu: Create __iommu_alloc_identity_domain()

Vasant Hegde (7):
  iommu/arm-smmu-v3: Enhance domain_alloc_user() to allocate PASID
    capable domain
  iommu/amd: Add helper function to check GIOSUP/GTSUP
  iommu/amd: Move V2 page table support check to early_amd_iommu_init()
  iommu/amd: Separate page table setup from domain allocation
  iommu/amd: Pass page table type as param to pdom_setup_pgtable()
  iommu/amd: Enhance amd_iommu_domain_alloc_user()
  iommu/amd: Implement global identity domain

 drivers/iommu/amd/amd_iommu.h               |   8 +-
 drivers/iommu/amd/init.c                    |  18 +-
 drivers/iommu/amd/iommu.c                   | 141 ++++++++++-----
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c |   6 +-
 drivers/iommu/iommu.c                       | 186 ++++++++++++++------
 include/linux/iommu.h                       |  14 +-
 include/uapi/linux/iommufd.h                |   8 +
 7 files changed, 270 insertions(+), 111 deletions(-)

-- 
2.31.1

