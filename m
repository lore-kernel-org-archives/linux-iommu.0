Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012053.outbound.protection.outlook.com [52.101.43.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7385401485
	for <iommu@lists.linux.dev>; Wed,  3 Jun 2026 21:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780522059; cv=fail; b=PNGiAuNdLzmXWiMF9QwJfpa1b8eiP+MxGsrFNq86Ljh4/HOBjyT4nLIfLaAv6EDapF16a82yyVDSt0IzL1Mcy7EF+LbhX/7rwKEZyZtnTsjk5sR3mMwfoholn7rtgtmxQNot4uVf3QHarRlM0rAAoRN+a8uV4jsHjR5YkA0eRAk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780522059; c=relaxed/simple;
	bh=GlluWPAvxqarxEiZ/YtSMwj+nr6Wew39RVtshk12Pyo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lhMc2AHfaty3vG/h/Tb77nc0EkXHhOBV0htN/KCtrcrBpWcKdbKNRV4WNz1PLa/KAYLNujFO966XQkYSo46QBOXIJKadwiyioTeT+OAlf6QzvpW7irkFemua63F4lfEki6lNaW3fHuN8DlGsnoCMjDi105Mn+pg2dtYcM4gGw1E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pMSGpjcN; arc=fail smtp.client-ip=52.101.43.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pMSGpjcN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y6OdzGIFtXhydB4xw5f5WVmJAJ+lraTnJrTYrdg76ZWTeGOKCRQI1PYeZKU2Apgu59PZhuUzERd/XPoKlvaAA69Xna/mLTqz0Uk8aaupdXjQl74q3TZIdhpEz8O+DbkIqgRbjjvPvA1dTgPGFrM46BUromq7X69yhOYoWeemes9Z7+mTWjVbhRbnPGdnX48i4HHZyj5aAVkPx4E+NMxLFb7Z8jra9iRgw7iFF2pR/CQf9qY9yZsvZMrdc7bXrLMHNbvD70RzQtGByv1i227HZpIFz+8t6r7YdHFZ9AgKaXuZsz4gkzKy6tt520SDUq8SXheu6yMD1T0CA9iKcPHKaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BJDXbc81T+hkbpxmKbDVlqYyQXz+8BEQuucdfVqpurs=;
 b=cO1V2ErSct7vgXe4nauJ+mNLH/WrK+gAwJKcNpvkPxXy/UckJGZ00dElAJgBpmdkhYU2KLlhnwCrim4VbB+fYXmFC1UrRQHa2IKPPcrwZA1s9Lu2DyEN+a193r9cYO+0tww8JoSUowxb0GygyaZiR+LnwvFFt0dQGTnNAetKs9StbSKqwkuxuuHGYa7unS7Y+5CfSofeuV509ynjKW0VaVeuW5rm/5sxe3wkBk92Mvxej7OBMWYi1pr2lN2m6KlsA/UrI20wwPZCREMe9/vrP76xL2yLOgC05R4jrtn0xUO8MQuYJ4svG3Oc9HfWIWe1dqA8cROqErwYbGdC5NjXlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BJDXbc81T+hkbpxmKbDVlqYyQXz+8BEQuucdfVqpurs=;
 b=pMSGpjcNuPLtmSNs+KzMt7kOxG0D44oO4/lJ9nZuqi2mSzSfoNXi/9CP8A2xA4uIBhTKUQTuu1GcmynW4YcQjn4vjtk9q6wAUbdkhRuy+UyzUWIwVstmPkPFmdKHKO3vhpLc5j+dhll6MzVwgc3sH/LmWXepEmxy5GRT9vdjaR/PX14OTvbAmY2UgMKZ6yuJ4ToVG4mvDX1dl0MX32yZnGqlSuNdpu5w9kcKjKbMMwnyqyRRXBZZ4r/0d/2t1qhqIyePn9uP919PPEjcCqOimW18YulUyDEbKTIifU6ffbg1666eDk3xSH/HX83WW8YvfQqSh3q+niOIk4+p+sWscQ==
Received: from DM6PR04CA0016.namprd04.prod.outlook.com (2603:10b6:5:334::21)
 by SN7PR12MB8103.namprd12.prod.outlook.com (2603:10b6:806:355::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Wed, 3 Jun 2026
 21:27:33 +0000
Received: from CY4PEPF0000EDD6.namprd03.prod.outlook.com
 (2603:10b6:5:334:cafe::55) by DM6PR04CA0016.outlook.office365.com
 (2603:10b6:5:334::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.7 via Frontend Transport; Wed, 3
 Jun 2026 21:27:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000EDD6.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Wed, 3 Jun 2026 21:27:32 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 3 Jun
 2026 14:27:18 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 3 Jun
 2026 14:27:18 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Wed, 3 Jun 2026 14:27:17 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>, "Kevin
 Tian" <kevin.tian@intel.com>
CC: Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	"Shuah Khan" <shuah@kernel.org>, Pranjal Shrivastava <praan@google.com>, Kees
 Cook <kees@kernel.org>, Yi Liu <yi.l.liu@intel.com>, Eric Auger
	<eric.auger@redhat.com>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>
Subject: [PATCH v1 0/4] iommufd: Cache invalidation hardening and SMMUv3 batching rework
Date: Wed, 3 Jun 2026 14:26:52 -0700
Message-ID: <cover.1780521606.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD6:EE_|SN7PR12MB8103:EE_
X-MS-Office365-Filtering-Correlation-Id: d8c57470-b901-4161-fb87-08dec1b6ec8e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|7416014|376014|82310400026|13003099007|3023799007|18002099003|6133799003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	YwQ/cdrY6Sq1yMdrpTbejO21JcQRQBw534Su8hY0ffcz0+Z7ZOiZ8H5oQXGuwFgpbdCDuaRLcePfnGGrdF7k7VmHSHzePqyweR95mz7oqN6AZSeHv2jKF97E/JiK0CrkjzWkkwxED5i50Q7+cQ83BgnNWsebfXgmDorpB+lpYFqBEqjBu/gtVaQirLUoar4WuiQEznLCxMc7TcVAapBtzPGlEPQTBeBLDM8WD19Vk4jcfX5RfPKNDG10tP/VDLV54jwBJgrTqJtHynqMwpMJiq/TlV2to+qEzABT1OEDTg3WV9s2YmjOEXqg5JvEcAk/XdSCY3w8UROCAZPJezhHbKcUdvuPIyT+J/b9bzz0YjlFPFlN40VeN2QSkHikAlaPARhJpzloVWlzZHp/Z9zyQrCtlAA6Cq8n9d3tfyixdCgcb7p5DWX+2RvuCms0kscmwDlK1/rtGBNht5p2O9s1lSeaUOV+TFQeCGykM3uDlmjK3YjydpSlTG83fIMSDh7oltVM79hml9yU9GGTl4SQURTIDSY77Jme475aM5MfFvKhCYLuZKCRrQSzGAPSJhwuNHBHCgRvW6TIJcBnraFWt3/6wylpTKMAO5uMJjB5wAQMnjuVqtrhrvwzPwe/9fQrHQqOKy5GZPoeeGAywqRoXXihdIWokxoqXuT2+bt44WkJjPUksgRAu+WUbT1IhP3UjKzbbzlTITU6URo4kk4lYpqGKc8nY7RBgtTIV/Xw0mE=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(7416014)(376014)(82310400026)(13003099007)(3023799007)(18002099003)(6133799003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	B4Iqs3ym2tcE8547TzHSCQxfiV9xH0mYwq9V9SmPP1HOecQmZq7/+tlr+s8kfi1lSecUzd3lOC/YaNYF6yVtkTG/6rQeBHlldT8H4rcyvZj70g8p6XxANKEtoLcPBG0JCo3S+XjEruNHO+C0mfXLKBW3V5f8DAI33r0qDQnt8L5j1LFo6i30N1Gb9LcDfNqqULHwQ/JSPhDeiJcKZLJ1RHuNX8jsHJyr087E0OQOXqXo1Xt+hzDwZKt9h0JIkbgISW4DpRl9fC8YVwdelXXjX61TsdRY2/+Bgb4MclvJeXuvqt8JrXQvAMR77cez1+E0jjnEsmRS1/LKgmQiuCKUFDIW8lFAiQuOTW7QxnfJWNznwkWmbQ0A3dWmN0YLQhaxvOtxnH3RK0Edrk9FHVUVFjjPZFNtYFGFORQqMXfDAEWfjMMXyX0JWuVthr1X4sGJ
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 21:27:32.8870
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d8c57470-b901-4161-fb87-08dec1b6ec8e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8103

Sashiko pointed out several issues in the iommufd invalidation path, which
also prompted a rework of the ARM SMMUv3 vIOMMU invalidation handler:

 - entry_len is user-controlled and unbounded, so the trailing-zero check
   for its forward-compat fields can scan gigabytes of user memory without
   yielding, long enough to trip the soft-lockup watchdog.

 - A large entry_num drives a backend's per-entry invalidation loop with no
   reschedule, e.g. the VT-d nested path, pinning the CPU.

 - The full-array copy helper copies the array twice on the equal-size fast
   path: once in bulk, then again entry by entry.

 - arm_vsmmu_cache_invalidate() reports converted-but-unsubmitted commands
   as handled on its error paths.

 - It sizes a single kernel allocation from the user-controlled entry_num.

 - It rejects an empty-array data_type probe that the uAPI allows.

Fix them properly.

This is on Github:
https://github.com/nicolinc/iommufd/commits/smmuv3_fix_iommufd-v1

Nicolin Chen (4):
  iommufd: Set upper bounds on cache invalidation entry_num and
    entry_len
  iommufd/selftest: Add invalidation entry_num and entry_len boundary
    tests
  iommu: Avoid copying the user array twice in the full-array copy
    helper
  iommu/arm-smmu-v3: Process vIOMMU invalidations in batches

 include/linux/iommu.h                         |  1 +
 .../arm/arm-smmu-v3/arm-smmu-v3-iommufd.c     | 91 +++++++++++--------
 drivers/iommu/iommufd/hw_pagetable.c          | 11 ++-
 tools/testing/selftests/iommu/iommufd.c       | 15 +++
 4 files changed, 81 insertions(+), 37 deletions(-)

-- 
2.43.0

