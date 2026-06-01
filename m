Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010028.outbound.protection.outlook.com [40.93.198.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC9FE29D26E
	for <iommu@lists.linux.dev>; Mon,  1 Jun 2026 10:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780310947; cv=fail; b=josUdinmPQLbJz7vw6UkcPyKPP8oIWRDETAOKUz8kBttSh0Cr3yFDTXN2YtgejolYT6eQpzG6XBoohLri9vbz+/p8p60GKVIn1NplE5DpxgybNFV1N4nj/VxiFkmNhjA/7MbfIEp+k/+BfmzGPeFTfmI2etGKwqsXMA/0qwFst0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780310947; c=relaxed/simple;
	bh=cCozix9qAYI6b5Lq6O/32AhSqLM3xeNv1WO3FmsAQSg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=oPXgiAnguN8t2WXDIRk6mAWB3z2Wd+6CMc4mL1f2w1o9lBgA+YtfTDs78crnA34KpRk0AJ2ljLjbXY6nsf0xneAgJX3YY6VxH014O8FCAuaEoaJj2xBYYc/6SCMgKIofFJF11Cwnc51i7XqYpwf6XkHG+VlTuB20s7fT53VHrE4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UtSeZOl+; arc=fail smtp.client-ip=40.93.198.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UtSeZOl+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bZkdm7aCmct/6sNAYqbteBHh9wHn5SH4JQOZWeKkpNt8q2VOCnmfGdm+ZCjywI7ZiU63UjzEiqh4ogGZ5LT5q/0MlQsTwMSOcbRJXHqm8mbOmiXDzNDiffHsTQlx3FH4+AVzoMuwYMi1gnLGtjVZfMZ+ipdlTVxirQWtI8EYmuEfVvwS99/ywh2yrB3FApUsDFI8etnIWxgFEn6GrMr+0EA99Z9Mm/QyccG0tGYGVCuC3mz4arWI5HY2mFnB6tVPbIPyShzRKOyJPaFTNjSDfVU6f3hVwDBaTGzpFh17ILlFu7IUGDSHsEyDxNaZhJtfhXVf0jK46SxZuEvex2hH1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MzQbwJDWxeyEbO7cRuP+W7yNK4Nxp6A9Gvmr5pPoZz0=;
 b=FGJ7CiCY43ZBK6G8T45vIC33pUkw/gGmAtDak71imPi1Jj/y1cTVVc7xOObEPj8FYEhLKN9PLigOE0ml/rJfruhlJ3RrL8A83RDySBqhrOiffMfk0udE/DcqJKNNrp569KvkjGX0RO4pj9/R8PPGFUyQ1/hxDapBVI8/aP7hTUHR+mBU12i+WQ5Idj+9dK+2D60iLALyl4g7e3yZhNMwFPzXbI6dotG3ARvYEwekLc749ZtCIyYlZXoYdLLRaX4iwl187n7OGYcJbh/kPdxXrxKzlKbLBwyWL2nt7etWpn2EExn6cBjKtv/QbqntcXTJcPofjZXHLjPde21PGE4bzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MzQbwJDWxeyEbO7cRuP+W7yNK4Nxp6A9Gvmr5pPoZz0=;
 b=UtSeZOl+LZv3pzakG3ylBRl1zX457QXEpoNmD7ahRJmdM4CdL2AGXA8yXGwFqHuhWD6Y+48+aZyc069Lq96iX7ac1DiP7po4CwK7hwpIxkIQO31GL1dvkH+TJz5RIEimS9RYmq0yDqr0wdxIp1CAUbhR9dzeLNoLTFzvX5jfLI89AAsFhFPSLf2W22nzVrMaDmFvdempNV34a44stf+Ogrd/xgxfZnAck7TENYu0qOzS1YA4Nz71cl+yoFFAcd8LZmoJGD90f/Awz/5SYrYKOo/w42tn1LwsDHDTX20LygBNDl/mj3jCg20sZJFMaqr3qZ8XmiWZFzUnjXD6zBrqyA==
Received: from PH2PEPF0000384F.namprd17.prod.outlook.com (2603:10b6:518:1::71)
 by PH0PR12MB7009.namprd12.prod.outlook.com (2603:10b6:510:21c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.16; Mon, 1 Jun 2026
 10:48:58 +0000
Received: from SJ1PEPF000023D9.namprd21.prod.outlook.com
 (2a01:111:f403:c902::13) by PH2PEPF0000384F.outlook.office365.com
 (2603:1036:903:48::3) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.16 via Frontend Transport; Mon, 1
 Jun 2026 10:48:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SJ1PEPF000023D9.mail.protection.outlook.com (10.167.244.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.0 via Frontend Transport; Mon, 1 Jun 2026 10:48:58 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 1 Jun
 2026 03:48:47 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 1 Jun 2026 03:48:47 -0700
Received: from build-amhetre-focal-20250829.internal (10.127.8.12) by
 mail.nvidia.com (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20
 via Frontend Transport; Mon, 1 Jun 2026 03:48:47 -0700
From: Ashish Mhetre <amhetre@nvidia.com>
To: <will@kernel.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<jgg@ziepe.ca>, <nicolinc@nvidia.com>
CC: <linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>, Ashish Mhetre
	<amhetre@nvidia.com>
Subject: [PATCH v3 0/3] iommu/arm-smmu-v3: Tegra264 invalidation workaround
Date: Mon, 1 Jun 2026 10:48:42 +0000
Message-ID: <20260601104845.995005-1-amhetre@nvidia.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D9:EE_|PH0PR12MB7009:EE_
X-MS-Office365-Filtering-Correlation-Id: 260fc93d-ce4b-4ccf-2f13-08debfcb626d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|376014|1800799024|13003099007|3023799007|11063799006|6133799003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	kOaARzWGyo/s2K+xgLFr/r9s2bz7xEZtEfKHIEdk1+TL0OMIQaqfAq9uKCpUjj7+rQVORPMOjfw4sdstBYqcUdwANoobNp3/qzaIZVPetFly+RwFVlLkodxOhW20a+zquyzuJQyAuQ2EPeK+V22I+s5dhicRE9vDeQiIjPgmxVjLvyaR1SDD0wBjIxGaqCPQo6tLtk90GcbGTpS3NKtuzt98SsBiwEVEZZgCiqRKv7b5e8Z7DOB90Z0/C1m1XZuEHN4GOQNgYY58UaXNqIn86qbOeEzTXY22XS5CLlbF6Fx/eJCJc4JjojiaJa2gzDliHiXcRXoD8lU8VzbXm9PY5hGc3AuYtMS5e4XJ8MayIiuid2DOahq5KgmG6aObwqS3FktLcQKvqDTMuVhoehMWp6lApzFvMj5ZD9IkIAu+LSDAKOlftkoWDLVpyvLNuCXyzkY0yMrvkV8CGpucQpov+a71QyjWiXHxyH8m2RjeNCJZ4gdYEc+P3lbWQsVAeuQrS6e7apzA2OgpzyDoReGQJPZExD5Np7HVP4S6ubsMtrPswUq9OVg5+JozessidYPp2M6ozqKViYpXEZXo/4pD8vm3XJajrpIAvvLg888rvmR9C/9J/DXmj4Ue3tsMg4rO3FQtxIrkrPqIZ5ssXoXZWpuCy+DJ44tvjJDi2adOc+vD91O+wAjdTfcqPdVepk9GGFVqA8HkShNhg2DeDrkB/jMylBvuvFp8WUySaY3snWY=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024)(13003099007)(3023799007)(11063799006)(6133799003)(18002099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	hu0VlKtKdLsEe0Hgkg73HFMZDfC/+AmHMqbaEfCa1Vd/cIqylxYc/n/mf+DJgG9306HrVh8bVCi+k0FbfKq/14kiPG8luOBlCERkyiBwsgBp414wqSUe8lTFGlWuJlOaMx56bo++5xF1ERh7TcZJwQC/NKnbJ+i68zUd+UfQR0ry3yc6fFEqsy66NOWw7wo8Zo8hFxPN/FEBUu1+/Sl/cD27O5q94q5BReQmTPps/S4sfcbgDvX4rbPsjMXOfNqXpBYTrypIAnnVCqLuxcYyrVy5nSA2ZaaRXUUWaEpzgrWW8Jc4LHK/AlypJRBTEYsHz+qvKNq2soXvrxpKe/qVUQBYn9jhTClj3RhL8EkYYGGJ3pFYvUyTEK51xSkLBDEuzm4D82+p0HSPEp0TsFwgwZEoG11BRcVNEfwQRQRxNN6vi9t0cE1/MhRts4Q01tf9
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2026 10:48:58.3524
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 260fc93d-ce4b-4ccf-2f13-08debfcb626d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D9.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7009

Nvidia Tegra264 SMMUs are affected by an erratum where a TLB entry can
survive an invalidation that races with concurrent traffic targeting
the same entry. The hardware-recommended software workaround is to
issue every CFGI/TLBI command (each followed by CMD_SYNC) twice. The
second issue must execute only after the first issue's CMD_SYNC has
completed, giving the sequence:

    TLBI/CFGI ... CMD_SYNC TLBI/CFGI ... CMD_SYNC

ATC_INV is not affected and must not be doubled.

This series implements the workaround by hooking the duplication into
arm_smmu_cmdq_issue_cmdlist(), the single chokepoint that every
synchronous CMDQ submission flows through.

Patch 1 is a preparatory refactor that factors the existing batch
force-sync conditions out of arm_smmu_cmdq_batch_add_cmd_p() into a
new arm_smmu_cmdq_batch_force_sync() helper. No functional change.

Patch 2 detects affected instances using the existing
"nvidia,tegra264-smmu" compatible string, exposes the condition via a
new ARM_SMMU_OPT_TLBI_TWICE option bit, and adds a static-inline
arm_smmu_cmd_needs_tlbi_twice() classifier in arm-smmu-v3.h so that
both the in-tree CMDQ path and the iommufd VSMMU path can share a
single predicate.

Patch 3 wires the workaround in. arm_smmu_cmdq_issue_cmdlist() becomes
a thin wrapper that re-issues a synced cmdlist a second time when the
first command needs doubling. The Tegra264 condition is added to
arm_smmu_cmdq_batch_force_sync() so a full batch carrying CFGI/TLBI
commands flushes with sync=true and is then doubled. The iommufd
VSMMU path (arm_vsmmu_cache_invalidate()) is also taught to split the
user-supplied batch at every "needs doubling" / "doesn't need
doubling" transition via a new arm_vsmmu_can_batch_cmd() predicate,
since that path can otherwise mix CFGI/TLBI with ATC_INV in a single
submission.

The series is based on Jason Gunthorpe's "Remove SMMUv3
struct arm_smmu_cmdq_ent" series [1], specifically commit 13428b0bf794
("iommu/arm-smmu-v3: Directly encode TLBI commands") which is the
final patch of that series in linux-next.

[1] https://lore.kernel.org/all/177919957385.1012282.14787407041669291032.b4-ty@kernel.org/

Changes since v2:
- Add new prep patch 1/3 that factors the existing force-sync
  conditions into arm_smmu_cmdq_batch_force_sync() (from Nicolin).
- Move arm_smmu_cmd_needs_tlbi_twice() to arm-smmu-v3.h as static
  inline taking (smmu, cmd*) and folding in the option check.
- Plug the Tegra264 condition into arm_smmu_cmdq_batch_force_sync()
  instead of carrying a separate need_sync in batch_add_cmd_p().
- Fix iommufd batching: arm_vsmmu_cache_invalidate() can mix
  CFGI/TLBI with ATC_INV in one batch. Split at the boundary via a
  new arm_vsmmu_can_batch_cmd() predicate.
- Patch 2 wording: "next patch wires" -> "a subsequent change will
  wire".

v2: https://lore.kernel.org/all/20260529140830.629738-1-amhetre@nvidia.com/


Nicolin Chen (1):
  iommu/arm-smmu-v3: Factor out CMDQ batch force-sync conditions

Ashish Mhetre (2):
  iommu/arm-smmu-v3: Detect Tegra264 erratum
  iommu/arm-smmu-v3: Issue CFGI/TLBI twice on Tegra264

 .../arm/arm-smmu-v3/arm-smmu-v3-iommufd.c     | 23 ++++++-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 66 +++++++++++++++----
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   | 40 +++++++++++
 3 files changed, 117 insertions(+), 12 deletions(-)


base-commit: 13428b0bf7947098daf9a1db14a74d33eb1b5079
-- 
2.50.1

