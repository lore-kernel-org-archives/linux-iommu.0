Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2064.outbound.protection.outlook.com [40.107.94.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F11EF22F3B0
	for <iommu@lists.linux.dev>; Wed, 15 Jan 2025 06:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736924188; cv=fail; b=gbqft7iLzkumxvyfjitcZQK+0t0mZmM7Ix1ZZjBvmXnIp9e3ksQB5PdomOZshHZ8BBYq0nuIf1fuU+Jepq7V6cR6549UhYkxeKm6EdoIAGjxYh0KIMFCLLciVVo29wQ1Y9YEb6kKcZu0uw8rOhQy7Zt7GuYso5JvsLf/S/ZvGY0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736924188; c=relaxed/simple;
	bh=qYjX6X2FICQjXxYFMquhG790QmO2uh2RLGSjmLaejwo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=M+s5f9SNhD+nHLOZQrDRmAuQ9kGeeqPyeYCKcI5Yglpd8tpO06OVb7dYUASgmEfK1zUERq2J+pefyCLXNT6XPkLmY+3gUnFyzqOB/RhamL8nQUO7IfvvmnbwyglebWJR70ylZWPTOSVgXcLdWi20F0Ix7YZMOFMZwxi1JI773J4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=n53YExud; arc=fail smtp.client-ip=40.107.94.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="n53YExud"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DY4Pihh5dCkvcRG/Ka0jgJ/ba7IpRkgLRs3wBwUubIXWEGiRf5J2g8QJEGxzYZqNVdfw6FM6szQdHSeCJRb5dNthzNQevlEnTJ6F1qfOs/nEcxnHNbabVBTj/DgNoES+DD9BhZruvlSQr/zOdbQ9SNHbGiX8e+CJaegKbIYvJENGiwMK07PhDu/UhIc9caKejyWJuouBGqAjrNHqjsmPh6spBDa/5NaAJ08sdFcKuinve/HoMYbFkvXRZuVpSa6t9bd6U+G21rqD7cZYDIjU4rr8jhoQiQWZmfNwI5eIH4xI8qZ75oNM/OcxLhV+VZ2erV+wzCQP6Nk3sYbg3I33cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+TiveOd0gfjJJfzQH9rdNLWpY8EW0gCQGJM6kWt5RIc=;
 b=aO2SkEyvIroYOatYC+10jbk0ZAigUDz9317CQ7OiRGVF/v0Kqivhcdjm77OCEdSwUVF6aJROzKW/gonjPQ+86v7JTeFRMZP+q91XVccorfXpPn7dCycEiqVGeJaTsDGC29JcBUOmOqmCWonKfhlTDL0Xg4u0lfSjQOUeYBq9mCKhbX6/CAY7nYrQ7kOETNuce2DBRhOMmIXBNekRK4CcxIap7p+9Xa+KPnrb8406L0kp15Jt3/3vTo1mFy+2skRkbyKxWN+vX5CJPoigdq+5f2ba0AKP1bq3gWx7/i7HECSY4yT32lTLDBBQe/PfuwyOI0FKZTcVQ0KsVUER3ObFrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+TiveOd0gfjJJfzQH9rdNLWpY8EW0gCQGJM6kWt5RIc=;
 b=n53YExudk14iUkfV6TecPWMjzNDNb4ZMUgQn/dmEQenfsgA/1VZTxS1uiiIHPBR1LuWufbvP/kFT+CIxHhKf+eLK5bMNROThfXZgYkjmV9amOkBTJEFdZYrO8Mt4Ww0doDa59b/QuZE699NCPOmgYbiClUeakgqhPtZWHgpZUREfo37Ku5MmROnVdsI1q6KhyE3+vjjvfu63fUp/ZD40iwQpYGgfNlKU7LtKxZanPwIo8NyQWKBrcPbhTkqTnNGhRoAKyPZmMcfSfWmqw0O8NBX4kLK4iuE6AKf0HX8wlypVUhBGwYC5HL13aPcWLGFyaB/TemwF1qEGhXgZIYJWEQ==
Received: from BN1PR10CA0024.namprd10.prod.outlook.com (2603:10b6:408:e0::29)
 by BY5PR12MB4259.namprd12.prod.outlook.com (2603:10b6:a03:202::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.12; Wed, 15 Jan
 2025 06:56:23 +0000
Received: from BL6PEPF00020E62.namprd04.prod.outlook.com
 (2603:10b6:408:e0:cafe::ab) by BN1PR10CA0024.outlook.office365.com
 (2603:10b6:408:e0::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8356.13 via Frontend Transport; Wed,
 15 Jan 2025 06:56:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF00020E62.mail.protection.outlook.com (10.167.249.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8356.11 via Frontend Transport; Wed, 15 Jan 2025 06:56:23 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 14 Jan
 2025 22:56:07 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 14 Jan
 2025 22:56:07 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 14 Jan 2025 22:56:06 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>
CC: <kevin.tian@intel.com>, <baolu.lu@linux.intel.com>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>, <joro@8bytes.org>,
	<will@kernel.org>, <robin.murphy@arm.com>
Subject: [PATCH rc v2 0/2] iommufd/fault: Two bug fixes prior to vEVENTQ
Date: Tue, 14 Jan 2025 22:55:58 -0800
Message-ID: <cover.1736923732.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E62:EE_|BY5PR12MB4259:EE_
X-MS-Office365-Filtering-Correlation-Id: b0737bfc-1ea2-42e5-4674-08dd3531b93c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CHNkxtclgCbNnoHDPOP8OVWn1hD0KQ+NGWbXJ7kqThyR1m29unQX+tBT2Jhf?=
 =?us-ascii?Q?gPBVEuO6zJRcD1d4PNXhAOk9qGwr06C+Q0OkLFkLRPJe/QtL1ygNdOTuQLxa?=
 =?us-ascii?Q?LGEXXi9fGV4fbHNC4JO+BxdsOiKdGN5vTKDuknJwmQTaqcP4eTxTdN8f6dvz?=
 =?us-ascii?Q?v1K84mOb/17t27A+FiJ/6TgF7Mde8+5n0n3zJrNmqdYnezbn1tsPElgX/5If?=
 =?us-ascii?Q?vC2PwyM3QerVeGrEyB0xMZvi4h59xQqtfHZYkRjmKsqyLyy1k9iVSHPxwxCl?=
 =?us-ascii?Q?whiGpY5n6E2XEIOFK7mNasS+wbuKxKM3QD7bRG6xntdWpnVqimycMntOirSt?=
 =?us-ascii?Q?2YW+OAcTmMQwhMxMEkn6yiHoZ2n5XNlshG6iK2KyNxcAfcnT3tZLsqv4juwt?=
 =?us-ascii?Q?vF9VUHtr/Jc0t9wIBbc2LhhUMGMV9AVgwq9TQ/aJhvBfP1YrfN4zxUUTUu2J?=
 =?us-ascii?Q?AO4KmuhZmW/wPU2trG7NfxnnucJ/XkPOEsYB4IGWHMy9CP18+HdXXzx3fCiN?=
 =?us-ascii?Q?KnQU9b5vThezjvwCFwOVvG3wrFFOMp+fWNsI+o1lxt2i2xYf9eXJT5wbUeq/?=
 =?us-ascii?Q?lw+n8Zn3SjgGc+HyWu+6+1lRSvyMhvsAxJFAEEjR+9fD7xTuZJ29VIF/q2mb?=
 =?us-ascii?Q?XRcOw03wpf6t/ae8foItFHqQ7gD9utoTZ9eDjom5VANKaFx5OM4t7tg6Bdph?=
 =?us-ascii?Q?h/nz24Esm/dAZEmINLjJTwoV+UXLc86/1dgVDK/xpDRlvbqYCCtSsq+QG6Cc?=
 =?us-ascii?Q?5woT/kdVS4OQNwcwA8ghfacf5hkQfQyO4g+8EWjTCTAbCtv/29vSUPhoGpIg?=
 =?us-ascii?Q?ErAtn5hEHLWSHUa+x2V695ffqOo3e6ZrxsXPMNtq+plm87eSzTJz6f9nFnRH?=
 =?us-ascii?Q?2khiFkS1TNkvGyl3zTQpuLGmfs8bqe6IkmBD78muc+6+IXqA7EFYxxUeiiIV?=
 =?us-ascii?Q?HkfzwkJtN5++Dek5k6AvLHuqwY+SQHe9vzw+3ScMjRjvnE3u4qCScQZQfSOs?=
 =?us-ascii?Q?2jZGmEqN00zfIK+GuetXUNSQbbsjbMedAhNAjFeqxPi78GWscMN9dToguOzP?=
 =?us-ascii?Q?NTU4//GON7tdEHxvgSeRAMlxl1QAoWh7oD/5iLMyPX+TbuMUsnOu0jZ4C0Tw?=
 =?us-ascii?Q?9j61kba+z0iqCWSKmMNiOqjfQ7nqOEAr8oUPvee+bNnJ6BTgIChFoh/RL8IB?=
 =?us-ascii?Q?fkMnj8Bhc7HFG74lzdFuc850JIz5as+Suph1a6s7Vt3BUJVNnT7/gNlK+rm3?=
 =?us-ascii?Q?VnIzL8N2ZfwHI1IaU7VZK5QnWzWHxCBakqx6I71KaAMlJt2tHAAd9GsKuxxu?=
 =?us-ascii?Q?tl8lbZjwgAldJ0rLjWYew8mamqjymXfENK6J/dER8/JWj7p+KSSDbgSzzfmr?=
 =?us-ascii?Q?AXag33yyjW+4hDC8F8G3AAHgIly3mGLpB4ZoJZF3Kj4QKZFiwT8/rPkE9WOO?=
 =?us-ascii?Q?p813MCq6TU7+CUN80BirW/PLxUj2YvOnJYkZO5O4U7k0KyjB/NN0WK6N3D7G?=
 =?us-ascii?Q?g7+mq/KKerbPQj0=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2025 06:56:23.1851
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b0737bfc-1ea2-42e5-4674-08dd3531b93c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E62.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4259

It is too late to get the vEVENTQ series merged in this cycle, while some
bug fixes for the fault.c file can go in first. These fix two small bugs.

I will send vEVENTQ v6 later to get reviewed. And hopefully that can get
merged in the early weeks of the next cycle.

Changelog:
v2
 * Add "Reviewed-by" from Jason/Kevin/Baolu
 * Move fault->mutex closer to fault->response
 * Fix inversed arguments passing at list_add()
 * Replace "for" loops with simpler "while" loops
 * Update kdoc to reflex all the changes in this version
 * Rename iommufd_fault_deliver_extract to iommufd_fault_deliver_fetch
v1
 https://lore.kernel.org/all/cover.1736894696.git.nicolinc@nvidia.com/

Thanks
Nicolin

Nicolin Chen (2):
  iommufd/fault: Destroy response and mutex in iommufd_fault_destroy()
  iommufd/fault: Use a separate spinlock to protect fault->deliver list

 drivers/iommu/iommufd/iommufd_private.h | 29 ++++++++++++-
 drivers/iommu/iommufd/fault.c           | 54 +++++++++++++++----------
 2 files changed, 60 insertions(+), 23 deletions(-)

-- 
2.43.0

