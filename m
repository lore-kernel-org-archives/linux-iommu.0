Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012036.outbound.protection.outlook.com [52.101.43.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE988379981
	for <iommu@lists.linux.dev>; Mon, 25 May 2026 18:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779735106; cv=fail; b=UbU5pEmZij0DVsJjbfpDoNGL3XD9DOO+Kvb09wPmp9sHfH35mZ+6GYAw6Z7q9qpvgzYVlNgN7meDqL9XlpLD0qbEFA0CfHUHS3DCXA5KBmvPsU1gDIFwv+UdLao8hX9+XYapnPY/Wobjv4CtrE2HM9H5nzUlW4t3HFLRV46gMKQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779735106; c=relaxed/simple;
	bh=mBaPRnX4T3XR4MhK2ltv1SnSxhzxBluyzqcLflfimM4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YyxPF7DnRj83dWaUSjPmiw0Bie5U18I1EwKQIm/TvONYv5qswXh8zdHy+IGjhYTvzZTJSbN6JmwG4qqsED9+uMWqos6DECdYiCYmGnOKTnZ/MAwVq+8wMaHP1W5rZud5zmDzMLFSzRg1e33+osQsFxV7g2/g8153kDewuboPprM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jUokMhql; arc=fail smtp.client-ip=52.101.43.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jUokMhql"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a5+wfeZ3g6Etws1vSup6gyc5X1fFUvI+2yylNZDMstKUkclHQdGIb+vJ72ESfPaYhCKlpFRkaYkig0SfalXNFshLi/g1KdicT6uF2mXtKtZOf7vwtjwMj4/ICbEG3xHnF6SRaIkbpWGqvEQTEYx/kLg0NLVzJCKRUCtB+7j4heHnC6nhiuDI0aI1zINuNki+eFDT634d02+WBOvx9yGItetNVRQ+qCtRnzZwoM//Dz5f3kvP1CWN8B7asRnq7P9sXCol/m97/6dnIm87XWwof+ZByC/8Sb9OyhLHEVLoLd3/9SZQIRKEMBSvvyBlRRUKeSDrx+ouTG+JzUYK2e1AhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XOSezI4CYxmhwR92s5p5XGQD3Q7NgeSfk/fW0HdxODE=;
 b=aLGHhPa+WHpMOfVrCOaDQi861NDiz0i1G0ohtQmZ8OEN85FOtw4WPK44ZyLjacaKDouK9EPcBb3/kl8ri8aMDP95PGmItKFS64miP1xQ3iVZ7t1D/CVhXV8xtcXIx97dkn4JbA4GtHSz37peUQdOm3oqkLwH2Os6MHla/4A7ZcKKXMIPuPXrFytoQ1q0dNJuhI2yShJOQrnuBSw3rc90fxxKND9J6AMyRhCB+qcS5uNvsdua9bw8TVrgyrQuGJ6Tf9rh96GYE/Jp7Vdi2b3nFpa1J4+R4IvCmoIHBIbd1iF8I2rvgBZ7uP8ca+zviBiV3EdJsBchAlwBgeJ3PyV0jQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XOSezI4CYxmhwR92s5p5XGQD3Q7NgeSfk/fW0HdxODE=;
 b=jUokMhqlCpQt7iv04ZE1y6LbANtHQw0k7RlybEcXsggIOAdo8o/VUTN9QpIfxwOlc+pXt61r7dPV22HqD5l9jpDHEidLTlq5CjOI+XcoS6jlDgzw3Bh5O4YaNHdlEwrQYxj7+PKNLRTpBPD6vymu+ZoZEfrSwJJUmXQGV8YUCWn4v/G/2haOoFMXZoJvr03ZctiMpraseNnqx3eCWCEL52iv468IaJUYQy8u+MpsXffn6pDdtv/xJoUE55h79SPExB1jXD/Qy8lX5hxAcBF3nV52vrnGAq9aKQ+UpXnD/GlJjpZ5eeUWtaCh+0qAYKz3tipFoiYxEqIxXLfseIqS0Q==
Received: from CH2PR11CA0011.namprd11.prod.outlook.com (2603:10b6:610:54::21)
 by BY5PR12MB4308.namprd12.prod.outlook.com (2603:10b6:a03:20a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Mon, 25 May
 2026 18:51:40 +0000
Received: from CH1PEPF0000AD77.namprd04.prod.outlook.com
 (2603:10b6:610:54:cafe::a8) by CH2PR11CA0011.outlook.office365.com
 (2603:10b6:610:54::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.20 via Frontend Transport; Mon, 25
 May 2026 18:51:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH1PEPF0000AD77.mail.protection.outlook.com (10.167.244.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Mon, 25 May 2026 18:51:40 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 25 May
 2026 11:51:28 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 25 May
 2026 11:51:27 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 25 May 2026 11:51:27 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>
CC: <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>
Subject: [PATCH rc v3 0/4] iommufd: Fix veventq_depth boundary
Date: Mon, 25 May 2026 11:51:20 -0700
Message-ID: <cover.1779734952.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD77:EE_|BY5PR12MB4308:EE_
X-MS-Office365-Filtering-Correlation-Id: afae669e-781d-4734-c3ea-08deba8ea841
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700016|82310400026|13003099007|18002099003|56012099003|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info:
	TF6EG1JaUluWhBnzqc6L5eMRPdSv/Gi2I5umk/rB2JDwegDOvHlLve/ZBq+E7jiXTAfgv4gaJltJkcZEHRGzuFuLl66oDa7Bc8Zu2d0f8iEDUI67awzyFUBqkPas2f5QpaZJX9hJiEcX4FB+7N3oHiNz6qipjfZJpfm1abqvksXtW+3HWYmtwUaAGNuW+dMc9bXj1579Y4/COXDAQtVB7+kV/h7b6S+i0vBW+JaYU1J/xtPoVxR9EFpGrSq08M32Z3a++KIKUUv/RgZHk+8HDsGpiO+QBqYvb5SDxVdo6rKIB70gqpUTeKJhfFGIgiWgzFIhXbO6TuKph1STmaQ0WPIfHIYUaav7eIWQxh1ewstwtmbTWsXEUf9OwVpU5X3fF/9E1pWeODPHjWrSDXdgAkrS6RqJ/W/icrX86eARmj7K28nDki9x1HuyixjJQbiHi4Syte7zD7ciFcE/AQChJCJHSv7fAY3oNmFbIwUZXgOQf+vr6ZRHV9u0bnYZEj6oaJxd5jM/BERK1MP+EdpTPCPoRv0drfCLnHwziYjrmZtXHfrFLyNUqegEyjRd5u4WiArqJI20eNZ8eeU8ln1mjeBCAQaw11jZT7j9g6Rd8uZ+I7R2rw1J9WRtnmgVp55h1pmDOnAKXIBYaAntjsVeSJuno+UzNPoDq3mVUfkjQeMmaHDyHqFkdepq0qu9fdeHEdZy5+XHcahrKdFU9bT8XsBCA1kBGeoSqdA4JXAq8E8=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700016)(82310400026)(13003099007)(18002099003)(56012099003)(11063799006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	qRayyT5Bpr+uoD9f+AENqUiqGoUiFNt1AU4r1xUIAxC22okrhWevTEZN1txK5K7M+8CNZkMVH/sQ2c19TjVxhjY/FXqxHx3SVBF90UvfLu44caMTYu8vwnnGg2tsdCMt77vZzgIsvaB/8U/8GMW2L693bz++Pv8iVbI3Q6JFeCgFeOX71AP9IxUy2DICDobQf+1tNDDdneMOf8trIgANKctA6tl9+GG9JhSGzzmcIQk4UEgm+INYYtzdsWdOrFV5W52/Pey2AbdstkDZns+Opc7UpIWJTlmpwpqJDC3Uyrx/Z6o3f7DZtpjHcnfFxozF3rDpUpQ7RBOMjKIxFgZ7qVSDWq+ZwjGN4QiEEx2bNuNcq+c1tHlhgaOiSN3RKETv4wKl8yz3cS92giVzJm5MlDMoIlVq7GNYFBRlEyluESdvbl+ynHxY8s1/eRTdmJEN
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2026 18:51:40.2568
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: afae669e-781d-4734-c3ea-08deba8ea841
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD77.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4308

The upper bound of veventq_depth has been missing for veventq allocation,
leaving a vulnerability where userspace could exhaust atomic memory pool.

Fix it properly:
 - Allocate outside the spinlock to avoid GFP_ATOMIC
 - Cap the veventq_depth upper bound
 - Fix event_data byte-count
 - Add selftest coverage

Note that QEMU's SMMU has been already allocating veventq using a "HW"
EVTQ entry number. So, picking 19 as the known use case, for a minimal
level of ABI consistency.

This is on github:
https://github.com/nicolinc/iommufd/commits/fix_veventq_depth-v3

Changelog:
v3
 * Add Reviewed-by from Kevin
 * Update the uAPI header about @veventq_depth limit
v2
 https://lore.kernel.org/all/cover.1779408671.git.nicolinc@nvidia.com/
 * Add Reviewed-by from Jason
 * Rebase on Jason's for-rc tree
 * Update commit message for clarification
 * Move "data_len byte-count" to the first
 * Drop optimistic read in the allocation path
v1
 https://lore.kernel.org/all/cover.1779070992.git.nicolinc@nvidia.com/

Nicolin Chen (4):
  iommufd: Fix data_len byte-count vs element-count mismatch
  iommufd: Move vevent memory allocation outside spinlock
  iommufd: Set veventq_depth upper bound
  iommufd/selftest: Add boundary tests for veventq_depth

 drivers/iommu/iommufd/iommufd_private.h       |  2 +-
 include/uapi/linux/iommufd.h                  |  4 +++-
 tools/testing/selftests/iommu/iommufd_utils.h | 17 +++++++++--------
 drivers/iommu/iommufd/driver.c                | 13 ++++++++-----
 drivers/iommu/iommufd/eventq.c                |  5 ++++-
 tools/testing/selftests/iommu/iommufd.c       | 19 +++++++++++++++++--
 .../selftests/iommu/iommufd_fail_nth.c        |  2 +-
 7 files changed, 43 insertions(+), 19 deletions(-)


base-commit: be93d186ae88a92e7aa77e122d4e661fa57b1e39
-- 
2.43.0

