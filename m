Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2053.outbound.protection.outlook.com [40.107.101.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A2DF1CDFAC
	for <iommu@lists.linux.dev>; Thu, 14 Aug 2025 19:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755199911; cv=fail; b=myTHfD+wctdN4niTJlPg8Sb3j9qBKWvyN+C/zbUdsartEFVGFq9h8RnAo21ktvHXCwRHBc8tdzFBd5XwvC7zamBaNrxzrcs+KUtBKlqXF2LFwlPpDUBlot7aL21cms0ptlKXWEFBHxBNcRilgguCBpuGKOT0NHp9obTz7ESkXk4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755199911; c=relaxed/simple;
	bh=MaOrtYD/iFrYdvt1AeSH6le0XYz5fYwCoivuQcxY0X8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=EWzW18hjwlnnGABd6tKC3SlMkDYvV76Kj2agAC/Sn6XgxvMDmBUmc3F7jNDEYRwoS/9Uq+XgKZs73tRdQ6pmjUuZK9lLzK0XI6TsMddx4iTnYNCBiLlKViCnVyWL8iW5DkA7WjCKZsL7J5Hv2M8i6+0rac4Ae2DJHyP+YCy2/dQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hfmudPgz; arc=fail smtp.client-ip=40.107.101.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hfmudPgz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o0bcJukjMFUEOb8ft7zy40ydIN84vr/p3HHsdmWqz7uw2dNL7e5LS69oJucXlfPwm7valPKuuiDfAP5kCs5/rCoDaEJCo2MSelt+CPwjNDvHRUhruimDRM+tH7WZOoQZypABN5i07vGGnuJZzfV1ChqUQxR+7rAiBIVJRzz27XjGraqQkTEKZrbjDj1wDPRqHwGnYQJh/llTYGm5JOpgmu5TiJ5Bwzlk4I+dSGnUmO3fbbrZbM0byZZo4U3l5FPCsjLh48jzIBRy/YKHxLwJbJAXqBW6Yt5u/nvgYijLeDGoV2QwSQMk2lm+4xogTMw0NaEdOC8lV9eG2A1Bdsgo0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dS1EDzB/qdl06bmsBu28JgAdc8UmIIbsYx8cp32f5J0=;
 b=MqaYHfLkSipGBIeSpfSQS9eyFyPS6oV9fCgFraCHw8PC1mZCBe8qdBuZavV7ESlwBGn6LdoS7ZKLLc6klulyYyJajngIDtJM4BBY9Wos02t18cLf/aI1fhfJkuKoRBFf0o8nDg0GCLA2eSJ8WA67kGgJz602MZah7wjPlPmkley5kxxqglx6bkSFrH9/8wS/cESBYC9AXLljdLPlDGVRXsyZOY8Dbz3Uf3dCwKUgL4gKfD6rYHUg4vg5uqPaXThXjEx7DeKTxH92wAe0MNASRAbjX4GnvjZfk1SZgtm6Zy94aY9gkoZ7apW6hdnruq5O+fv8tuH8an+FUIrOqb7nRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dS1EDzB/qdl06bmsBu28JgAdc8UmIIbsYx8cp32f5J0=;
 b=hfmudPgzriA2yUgDI0b393S1UdUx55qjjD34nE3+/K0jdurHP+artPuEIhQfzJfZ5GEFWayvsjN09rZ1L7MV7SiWzg5brf7uaP+2rAwgxQxnaraJH/qi4ECMpHyLfAnWUSRCgmnyOck8/0VXqfwlEhdx0GETI7F/KppVVR9+94ZpqYIAz5gylzxf31z9YZOF9+smzJ9GGaNTqHdeVBwv0t6Ma//EAX6CWQGrBuEqw8a7jfOy/ngfRNot4LqlKwf7tAXymEQ5HGYzmJlEGNQi1zd2rTXiRkPhNv6lLr+fTnSXgRR/yrPi2FgGt+vm9LJ/cey4tG7p5yzUn91JA3Ty9w==
Received: from BN9PR03CA0977.namprd03.prod.outlook.com (2603:10b6:408:109::22)
 by DS7PR12MB6190.namprd12.prod.outlook.com (2603:10b6:8:99::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.15; Thu, 14 Aug
 2025 19:31:45 +0000
Received: from BN2PEPF000044AA.namprd04.prod.outlook.com
 (2603:10b6:408:109:cafe::c) by BN9PR03CA0977.outlook.office365.com
 (2603:10b6:408:109::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.18 via Frontend Transport; Thu,
 14 Aug 2025 19:31:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN2PEPF000044AA.mail.protection.outlook.com (10.167.243.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9031.11 via Frontend Transport; Thu, 14 Aug 2025 19:31:44 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 14 Aug
 2025 12:31:27 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 14 Aug
 2025 12:31:26 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Thu, 14 Aug 2025 12:31:26 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>
CC: <robin.murphy@arm.com>, <joro@8bytes.org>, <jonathanh@nvidia.com>,
	<thierry.reding@gmail.com>, <vdumpa@nvidia.com>, <jgg@nvidia.com>,
	<linux-tegra@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>, <praan@google.com>
Subject: [PATCH rc] iommu/tegra241-cmdqv: Fix missing cpu_to_le64 at lvcmdq_err_map
Date: Thu, 14 Aug 2025 12:30:38 -0700
Message-ID: <20250814193039.2265813-1-nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000044AA:EE_|DS7PR12MB6190:EE_
X-MS-Office365-Filtering-Correlation-Id: c5120bba-43a6-497b-15d9-08dddb693412
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?za8gZN2TVlF4Amu6m7Lmw/4FXgBjsf8NwXjM1YNiPuAnKY5b071UDIwsYp9n?=
 =?us-ascii?Q?/LS11mtnn0y5/U05Kp0HuUTLKKoGmiE9wmqfpx+HYhKsIJmmSBFVQWPv0QOh?=
 =?us-ascii?Q?sJDH3zaqN3KBuBH3j4PPkcpWnbyi9QXea0yjzlsKSWNI3bWvjRL1sHSlfJMs?=
 =?us-ascii?Q?IXdXlqUzja2BEMVuKXdrdHs1BC9vGuJob780IHINpntoLuapEr4i8dzZTGTe?=
 =?us-ascii?Q?y+K4r0rLFkXpc4/tixu++M2VC8OayWdSiDavtSVNgKiteMxFCb0naPJPx6EX?=
 =?us-ascii?Q?G38LnO1pGdm/X32LH/lY1sY5cyaJSYxVju5YrqDg/76y/fGAzp1gHJecO9/2?=
 =?us-ascii?Q?PQS3C9nJ7g03VwIu7dQdczDlJDMBB1Hdq0fJu2IHFS7o3je0nqUTgJq5dhZD?=
 =?us-ascii?Q?PLFYBPG5dj6yDHOHsEhZHY7cdAD+BA2b4rhaTe4RPkh2FQmHxbcOTmi+pPf5?=
 =?us-ascii?Q?PwTBtI48iF/aT5fis9S1yfmXVqMrUywV+Zu+YDpCBY58OeMh88zGnk2yWg/P?=
 =?us-ascii?Q?3JGvI4jJpqWTQ2tDEV/efH1Tt1cMGx+DnpLsyjpG5Sg9aY0fGMF2ieZNf1Fi?=
 =?us-ascii?Q?oQMh7jXmAA38Hf67UTsXuozkRGKuvOEELV3rKbS+LTAQVOg4ePrSHe34OLCN?=
 =?us-ascii?Q?uM2+95YWkqERsOuoHlsnPm5gJMH6dSwoTQ/NBhvdjZQa+0E9tvjJjdmIcgjX?=
 =?us-ascii?Q?lYdYiF1t4ahbW13Nqr7nKo2WfIz9YERgmb8tYqdR5yTpIydHOB2wvSYTOwM8?=
 =?us-ascii?Q?+zdQ1P7AIrI96+mVxU2/qg/iDESR9fQWY9Rf5DEurSPRF6iRrXeOTS9oXaLP?=
 =?us-ascii?Q?tS2Q9mFYU7a51DqMUx19ajSlF8pwyDKNitMm/FVlS+UmWTxDyJAMoro46PW5?=
 =?us-ascii?Q?XqCSp3taRXSw8NxNXInhIAAZ3Xsxdxsr0L6RyIM5pCNTzaGXsrWFU/rEQHeP?=
 =?us-ascii?Q?kx35Zwsvg4c8EpdK7RAZc8UIv2MqeCrKyxIxzZtqUFi1jh1ElxaKkfiDXliZ?=
 =?us-ascii?Q?djnwbcUkmClmX8uV453IjzbxD+sgB4h7n6ojRuqCUyvwzvJ7a59MsFDhZFD4?=
 =?us-ascii?Q?zLXxILHO6BbprEop2Y4M8j7PHIlGvlVYYS6Elt9hzJtl+bxur4KZloPuCz3U?=
 =?us-ascii?Q?EL/4Y2h4zIS+9sm/o7n4T3C0Hyg4tTAnZUOy2MHIGYckZnHpJysm+kfg5n7f?=
 =?us-ascii?Q?S9M5nNcgyPMi9mWarc9rMZcwRCG0utZbf89cevrcpO4XimIb3s8kY1ZlTdvD?=
 =?us-ascii?Q?1KjKMe4XJarnxrzHe29F6JEes6Sr3HWwa+Q8mlyt935sIPNWUdutk/VOZDeB?=
 =?us-ascii?Q?at0de90bLb6lczTb4CezQ72t2g1x/TcpYy++7YjJoZSwBDOiV2IWCcTPH/SN?=
 =?us-ascii?Q?8kWk3Hr9oTeElIXYTleRclHhj3C9PbrMdEFZUKrHOL6bYsyUaypgtSpaNOXU?=
 =?us-ascii?Q?yUQJchPEsXb6laGaJbuYYS1LWkY/DuB69L7CkpLet8Ul/UHsaxgraB+YuSDy?=
 =?us-ascii?Q?a8M1i5BiU3LlVlHiXC00VhB38mrkA2LE8HgyQVPYjn9VWzsu3vyXyqOFMw?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2025 19:31:44.6285
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c5120bba-43a6-497b-15d9-08dddb693412
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044AA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6190

Sparse reported a warning:
drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c:305:47:
	sparse:     expected restricted __le64
	sparse:     got unsigned long long

Add cpu_to_le64() to fix that.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202508142105.Jb5Smjsg-lkp@intel.com/
Suggested-by: Pranjal Shrivastava <praan@google.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c b/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
index be1aaaf8cd17c..378104cd395e5 100644
--- a/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
+++ b/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
@@ -301,9 +301,11 @@ static void tegra241_vintf_user_handle_error(struct tegra241_vintf *vintf)
 	struct iommu_vevent_tegra241_cmdqv vevent_data;
 	int i;
 
-	for (i = 0; i < LVCMDQ_ERR_MAP_NUM_64; i++)
-		vevent_data.lvcmdq_err_map[i] =
-			readq_relaxed(REG_VINTF(vintf, LVCMDQ_ERR_MAP_64(i)));
+	for (i = 0; i < LVCMDQ_ERR_MAP_NUM_64; i++) {
+		u64 err = readq_relaxed(REG_VINTF(vintf, LVCMDQ_ERR_MAP_64(i)));
+
+		vevent_data.lvcmdq_err_map[i] = cpu_to_le64(err);
+	}
 
 	iommufd_viommu_report_event(viommu, IOMMU_VEVENTQ_TYPE_TEGRA241_CMDQV,
 				    &vevent_data, sizeof(vevent_data));
-- 
2.43.0

