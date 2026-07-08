Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012050.outbound.protection.outlook.com [52.101.43.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47AB93B14D4
	for <iommu@lists.linux.dev>; Wed,  8 Jul 2026 01:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783475827; cv=fail; b=JDXNsoHZaYcZ+q63CbjBad+T9Lqu9hiY1KQd+p256nLtiYUTCE7D7tNRHnbEUu2wts7iCy09kk1jHrZj4bZA/Ekj9ciBkNyHK3ND+OM0DDq8br0JuGdQmJEv1qWXiCVVm2PpRdgFo9kAG/R1oO6hPPlQftYvR6r4olZ2cP/cklc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783475827; c=relaxed/simple;
	bh=48QkgrkYWKD5wZwfqSbGy6ISEHrQmWLAWdzmOa1jnpE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=StJt8tVAHm5rkr+WAk3qRsVxHRv6RUQaNpVT01T4RA1NYSL5ab/u6ydeAwN8HTka3e1xBjIDehEDmUx2OjWpq6JVY72Bw7tkBlykAF1v64YZANNd09oCR9P3vsf+BX0w/W5NK3aZwR5oQBPDuOxxseOXIPNQgCtx9vbNMxOiO8c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=GbdqBQBZ; arc=fail smtp.client-ip=52.101.43.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="GbdqBQBZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xAC6fZqzpeYZ5Wd2pfm+UUv0RCzk2x/hzrz6tdSTo1tOSb9hnnfcqwJh6Ej6LLqtUoXcESn2x21tHfDx2IkHZlZmhMW88MsVriUtSw4Fve+Xaj7rcm0Qonpwi79TqPoyVoebnVsCAo/KwU9py3r/MwhmMuf5SecqEJ3SJQj6czl4TNISBSAcYBwV6DsKYIuq0F4wIaVdEVPlGZqHpY6TcvMl0GDWn0VWj5SKQErWIuU8BQd6RA/kI6/Nqev3GzEj8cG2M+YtGPPqtK+Z97gD7ZzCm9lJTBk7BpY86T8U2Jb4AFkJ3zwPJ1uuYtA7BfrNwvZw+42ANPOZs/TXuPHirQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KwAe1VaWrcOT7Pi9bD+uYKu15FJR9k6QsGD4Zz0ES0M=;
 b=L7hJT3B9780ImopQkRq6rgdtH0GDVjHHSiz/fGyd6jGeMw48iKCsROF87IF4kuHowzjp0nzZuMZwJ4eJd1iXAfjvKCMpufsglxrWo35fAb19n5dNDz6u+56E/nuN9zYdm/FWaNtUyjfRx1qC4TDAQgpbYmDzNW7H63+ggm1g7a3KHprF3IyPCcY2Yca/2l+aeLDLSTxwWnXVHeFNFJcqwZewYq8uQuY8GbymegcWFrWzpI7GriplPuKQI5n37psqCHBHoTooETtq3e2oOtC89MypLcJMld3IdocHhiHLa8jVmf4Bpfhq4ySGIdPMZhhvdlRNDCand9R3CUgx5heKlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KwAe1VaWrcOT7Pi9bD+uYKu15FJR9k6QsGD4Zz0ES0M=;
 b=GbdqBQBZnRdZJA4ZSbGGvgjAuKaVEc5Ad/BFzveZ0Oox+5krdUqEuFZ5U38/wvji68DRAONsuEgJIy/6EPzMGtSkdCcZ83KeGySM40LJzUuXdYed/rMWQpnZUx+BGi4drepV0ScUXVLMEOTStBUUYbNxf+Y8Bu3u/Cjt88FUDJ0=
Received: from BY3PR05CA0053.namprd05.prod.outlook.com (2603:10b6:a03:39b::28)
 by PH8PR12MB7229.namprd12.prod.outlook.com (2603:10b6:510:227::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Wed, 8 Jul
 2026 01:56:59 +0000
Received: from MWH0EPF000A6732.namprd04.prod.outlook.com
 (2603:10b6:a03:39b:cafe::8e) by BY3PR05CA0053.outlook.office365.com
 (2603:10b6:a03:39b::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.9 via Frontend Transport; Wed, 8
 Jul 2026 01:56:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000A6732.mail.protection.outlook.com (10.167.249.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Wed, 8 Jul 2026 01:56:59 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 7 Jul
 2026 20:56:53 -0500
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<joro@8bytes.org>, <jgg@nvidia.com>
CC: <yi.l.liu@intel.com>, <kevin.tian@intel.com>, <nicolinc@nvidia.com>,
	<vasant.hegde@amd.com>, <jon.grimm@amd.com>, <santosh.shukla@amd.com>,
	<sairaj.k@amd.com>, <jay.chen@amd.com>, <wvw@google.com>, <wnliu@google.com>,
	<dantuluris@google.com>, <chriscli@google.com>, <kpsingh@google.com>,
	"Suravee Suthikulpanit" <suravee.suthikulpanit@amd.com>
Subject: [PATCH 0/2] iommufd: Add AMD vIOMMU HW queue support 
Date: Wed, 8 Jul 2026 01:56:26 +0000
Message-ID: <20260708015628.255088-1-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6732:EE_|PH8PR12MB7229:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c82a042-5d33-4223-919a-08dedc943285
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|23010399003|36860700016|1800799024|13003099007|6133799003|56012099006|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	gAe23JzSEdTbim4PXiVX9+fbFJjwPhvTdCQobeIjVe/q8bHcjdbftChjazVm/jADV9KGOYN04HKuhashdK7A89tBSMfSseTDJuwjQKYlBP9KVYKNXAYEIPgXmy0vVvkcm+ONUgctPabcOJxsoI0WGSCZi+rlTbdE1DMD2ks7m9UMtzUFC+Q1iBPsbmLuyzkNQAQ2vQiEzgC6mr/yRyAiC0vXaCuP9yR8hCqmFkX2pAwsx3/muqwMPioI6y9YcjQdXu2S3jmi8x8xvmm/GkKwDOQxmUOR/rAUx2pki+fc+ezkDpx9yP7DoItQRXsAJndlHXJ1GE2gcKwLXm+6JpZr+n5afRgm8N2RvUphhP3/gjfw1L/YPOoL5JzvEHAFrWtWk0LZecMyp8NmLQvHISre0ySYoiiZRt2fY0cMWmCqnqHOe2Z4W8HB8CMk8CVC7AzgTN11iADIoodwvy9jiU/4PkXkOeNW3fPkSt0LFP0J0BBeblSGa87tGGjxQDlH7g3SlVNQLerEz3m8jr+mdRmFZbGTKlbRrddlFrBgom0KqC+1DSTO2fRe2wN9jGklqoD5futd2deKJMlz2EhgOF76surkHJ9mxBx8umYfImW6bGmzNIB5/okg2u2pPQDl/8TIWHltR2an+LiPA6j9KoGGRqWLG3fK3w4a/masi7xuWB4qfmnUcpnf8s2/CHrEV0NWtxgkpY7D4QqJ61Ixv6Vdww==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(23010399003)(36860700016)(1800799024)(13003099007)(6133799003)(56012099006)(18002099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	NrsmrR5l2Dl9eCA9ciyGA644augFtxGMmeZnk/04CzZLkeTsY/wNI+YMZQREnV/JJaFX0afp/x0Jmz9o1ppRVDhVQNx0OWiL1/PNJO1LDXe+Fnouw7QI3dKx4Fvpueec0V9y6wx69M7zIlbYDMKuYuCUIsvbrYuG01To6GvWEFtWHxoi7wabbFom6BEgil1uOrEXz47CRsdqx2ucrivlv1cmyZlnIlIjRyHP4oM2e5rznNXHWuvfi3uoHfLs4y8mTWprSypJci+as3sSUg8stL0y/9WPl+ZjKLxmvSGKE1yDOUGLkbJDND2qj5VW3EKWfZKAqlpjftCL3d83AJJfi60OrmGkovrxC1dj4hN6hkVwruKOLnicYoKRy6QwcJvNUFQ36QQuUKwMCTGs2EMI7m/z02aDGYxnTR0/miHL7Zk93B1mReYDqiHxQ4iiHiCd
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2026 01:56:59.2733
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c82a042-5d33-4223-919a-08dedc943285
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A6732.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7229

Notes:

* This series depends on the "[PATCH v3 00/22] iommu/amd: Introduce
  AMD Hardware-accelerated Virtualized IOMMU (vIOMMU) Support"
  (https://lore.kernel.org/linux-iommu/20260629153535.15775-1-suravee.suthikulpanit@amd.com/)

* Previously, this series was part of the AMD HW vIOMMU series,
  and now is being split into its own series to make it easier to
  review.

Overview:

AMD HW-accelerated Virtualized IOMMU (vIOMMU) guests own command, event,
and PPR queues in guest physical address space. The existing iommufd
HW queue path pins host pages and passes a physical address to the driver
via hw_queue_init_phys(). vIOMMU hardware instead consumes guest queue
GPAs supplied by userspace through IOMMU_HW_QUEUE_ALLOC.

This series adds a guest-address initialization path in the iommufd
core and wires AMD vIOMMU VFCTRL programming for command, event, and
PPR queues.

Patch 1 factors HW queue allocation into _iommufd_hw_queue_init()
and introduces hw_queue_init in iommufd_viommu_ops. Drivers that
implement hw_queue_init receive the queue GPA in hw_queue->base_addr
without the core pinning host backing pages.

Patch 2 extends the IOMMU_HW_QUEUE_ALLOC UAPI with AMD queue types
and per-queue enable flags, stores flags on iommufd_hw_queue, and
programs guest command, event, and PPR control registers in VFCTRL
during _amd_viommu_hw_queue_init().

* In this version, the CommandBuf, EventLog, and PPRLog are expected
  to be allocated when the corresponding enable bits in the guest
  IOMMU Control MMIO register are set, which is different from the
  previous version where the HW queue is allocated when the buffers
  base-address/size are programmed.

Thanks,
Suravee

Suravee Suthikulpanit (2):
  iommufd: add hw_queue_init for guest-address queue setup
  iommu/amd: add vIOMMU HW queue initialization

 drivers/iommu/amd/amd_iommu_types.h |   8 ++
 drivers/iommu/amd/iommufd.c         | 129 ++++++++++++++++++++++++++++
 drivers/iommu/iommufd/viommu.c      |  95 +++++++++++---------
 include/linux/iommufd.h             |   6 +-
 include/uapi/linux/iommufd.h        |  31 ++++++-
 5 files changed, 228 insertions(+), 41 deletions(-)

-- 
2.34.1
