Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2073.outbound.protection.outlook.com [40.107.220.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F81926FA51
	for <iommu@lists.linux.dev>; Thu, 27 Feb 2025 20:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740686879; cv=fail; b=q5HqD2wY4cTs4fkKUHVhebe2Kpc2PHYNqwK4GcTf9hhwvsZ1QgPgjIKHXhmLqX+/8nnrDM702HkWL238TY1Mj7b3JKA9hirt4ALbX8CGGrsKPqOb02CsST63lNs63rgicgYRib1CouBF2Jr4HRSzTdLKrd0WHNFf5/VIndStD8U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740686879; c=relaxed/simple;
	bh=jLO156N+m8NZyB6Zfpc7mUvIr/adaBW0JdOHchVZ+2M=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=azJZr+8jiP+XGrkASJDh05zY0y+8YsQ8slDrKJ3NRfDS95JyezcIV/mdlDPBEXNWQ4pKWQp7QJ1tza4vOtYASP9MfhnFYS7S6a+CJ+HGtNSY8k22xbGMFy08YpzyP6o874noZa9Vwsv+mZ0DpFC7iUq571TXr2KXYug0N+0g/GI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=eG+mXP2V; arc=fail smtp.client-ip=40.107.220.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="eG+mXP2V"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yH3y6XyGZDEkS6/OKCGOGm8QT29wYd3Wm0el7kyKo7In7yf0ntt5J4MZYDQJ0ZdDs92ZOMEpsa8evC1CZhxeymvgGrhNwY6q2Llk8uw4OtSAZZT00horehO1ky/oCpEnX6wSrYwXvO9Apqkv0GNMMQcLZ0UXfeBzZ7q4FXV06J1peAa7xvS1ZpZtIG0XnEoIMz63lzOlGcTGeukzplgEdH33HjGSqSMQJ5/h3dkfMIc0F9/6maXEA8ZQ4sNYtXwIi7RypJIMUJc9JVt/ivpWrVNPZSdP4cBhe7yiw2rmMBl/WWtMSGXTXIvQ8BGnMIXYqPhN25QFallEKvoLAZKEuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z0tV5CWiQ6A8vVOdh2bzM3tUSU62dOWxxonHa3yRiBo=;
 b=TFvo/SyN7KUAFyzkVFyXqCf+z8Fs3MTrAcbTdjvvGc/W/qP/+MAjDJWqH9eyK275GoyKisN92QoP+MlWscLfZ6iGup5WPslfMhiB8QDEWb0QmFstsED3H2ekiwttTnp9ITbtdYlfQp4SWQZp1KJx0EA99OprBGJc8GG+P2IkhtRuCGU8GM9R22Ng7bqvlmyDo/IsQttskIU4rncVmITnK2zaBA1lCPFdGSgP2EE11G0gFrLlnFexlPuUlPNuR10eL8izpYxdcah0o7qNs8RfxA5LlAfmeyQP4Jwv7g8tAg6qmQ1u/24onTXgA9TwBX+U2qiYXuSvAWmvbhJAShUqOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z0tV5CWiQ6A8vVOdh2bzM3tUSU62dOWxxonHa3yRiBo=;
 b=eG+mXP2Vz/JQX3hrsllOgEqIRsY3Ybbd1et7M3OreEJ3k15FGw6rTdoHua7eIWdNAg/DWGakorDjyt6c7V+eu86pKEDUlyIKhQbQ6QBjsTz3w2jGnqCeATMRKreVugB4E3Ls/9gftsXpWgvRsfPq5vBo51b7Oe3GAAa7pHZVxSpe198k21Omf7BRNes4oFDPtS2uim2v//a7iy74FKiP32W4z6/D+XzPcPmmDR+6VO4pBmK+fqq6wrlcF8N6AtiV9SfR49JsrT5QTKLO4UcGSI8Hoc04In0bc6Hz1bHY/xxC9K0zwmpQLCDKoWgSYT/qLhuPGhvfNXKUDn0A9OsqVw==
Received: from BL0PR05CA0006.namprd05.prod.outlook.com (2603:10b6:208:91::16)
 by MN2PR12MB4064.namprd12.prod.outlook.com (2603:10b6:208:1d3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Thu, 27 Feb
 2025 20:07:51 +0000
Received: from BN2PEPF000044A2.namprd02.prod.outlook.com
 (2603:10b6:208:91:cafe::f3) by BL0PR05CA0006.outlook.office365.com
 (2603:10b6:208:91::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.10 via Frontend Transport; Thu,
 27 Feb 2025 20:07:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN2PEPF000044A2.mail.protection.outlook.com (10.167.243.153) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8489.16 via Frontend Transport; Thu, 27 Feb 2025 20:07:50 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 27 Feb
 2025 12:07:35 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 27 Feb
 2025 12:07:34 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Thu, 27 Feb 2025 12:07:34 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>
CC: <kevin.tian@intel.com>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH] iommufd: Fix uninitialized rc in iommufd_access_rw()
Date: Thu, 27 Feb 2025 12:07:29 -0800
Message-ID: <20250227200729.85030-1-nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A2:EE_|MN2PR12MB4064:EE_
X-MS-Office365-Filtering-Correlation-Id: 5216b120-cd49-4a96-d42d-08dd576a69ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?oxndwbZfe7E+6c+ulDyaJ+Kc50pl/OPjU1lyLrW9HCOT2hsIoN+Tu2+iMc5X?=
 =?us-ascii?Q?/Dov4FALYE//ziOOQObm8oI6ovL2dNH9vgdeEVZLr25La4Vbhu27tgsWKJWS?=
 =?us-ascii?Q?vSOofiBT3VlqQQ+wRnbRXroMHJkNYlaNXHmALQST5eSnBxWJTYZv3GYp/lyQ?=
 =?us-ascii?Q?jfgkKsRG01mmVhnbbQmV0FxWHJIFhbia9jNDtpSnPSGT8vrPmMGbUfZPN3Gh?=
 =?us-ascii?Q?Ml5bc2P3gxzNPNic74dLrlUiLk8g/oW7VO+PvMOGqbg115emM/awSpHlZ7/x?=
 =?us-ascii?Q?kV1EHtKZnDtRwYwfQ8AQs6KX9TgvavqAqtILivhyT5M+H5L/7y3hpu27eYAX?=
 =?us-ascii?Q?yx6MUMsQoJik8xyXVJh53GuSshZ11res8/VSixxbo2vy0FhvVQa1ZBX9W/UD?=
 =?us-ascii?Q?26MiBxNpPK0mEwOsB8Z9ylj93BxEZdXQHutu8t+18Yn7aMPfhaHkmiq3x38W?=
 =?us-ascii?Q?VvNReMHTz/mVJRG2hF0sPf4t/XooEhwc7B9Eao5E6nl99mxVcnmE8cKiprvn?=
 =?us-ascii?Q?XQ6onRfcit9mCjhOpJGusV4gKK+Ft+84HVLDCV1JsDtu2aN9KiNIvJNbYprO?=
 =?us-ascii?Q?kDwR03zQMi8e9TPI11uL3A94nkIlYd5h2uLS8nrTb3W5pjYyBgofTSI9XjEB?=
 =?us-ascii?Q?l00FxXgKOqF4rz1fQ+F4tg4aXpY97Ur7DnI7PblzinZg4aeb0Y+b5NCXCjTx?=
 =?us-ascii?Q?UuigMrV2AbLSSWf1bKW3MRMi5kqBZAp2d/eSxeBWe0rUAOM3Eu8czpVmIwXf?=
 =?us-ascii?Q?QLU9IHf9+tzBcPKR65fvwfHxKTABAGRpy5cbBlJIWlqTlv+5FbU36c8ziYGy?=
 =?us-ascii?Q?DQCtf4TY8AwYJk5hxC6wd2ASjhvmNXi97nFC33/zoOA91c9AD68YyOGHwv4m?=
 =?us-ascii?Q?IXxGsPcydxaMgNq84Xd+qVLjHybf2f6RTpv57IFvpvjJn3rZ5+WDjwQl6TVu?=
 =?us-ascii?Q?Kik21tK6VL/7dLAg7XaTTRjHh4CMi492DpBx1jR5Y8RuN03OlY7Z77aip1dj?=
 =?us-ascii?Q?b1jK62DRd1BpkWYnGTx1ms53KfCTdyq9IG4oQ/oLz6fwpTZJwVoE6OOS6NMD?=
 =?us-ascii?Q?RirmhKKf0q/GfH+iZZ1F2isT9dTVNFKEJYX20AjvElZGnZxdUvQOE4novYEi?=
 =?us-ascii?Q?C1zHpyHGoMFvgajzKVWrjgus5gZTi77yjZukuyw5rJ8b3tAm8BQNcLAL1eTw?=
 =?us-ascii?Q?w+onZZWuFIwdDmleU5EW6POWJB2dxFIQ1moDNMAwHKAWFwfS++yBzaNVJ3KW?=
 =?us-ascii?Q?m6SxuwVgYqmFluE/KalDUr7Ue/zH2uXARYiD9qOHgunevsFKKeOYaltX1zLD?=
 =?us-ascii?Q?NWouYKQxQcKuUUU20E4WgpKHPPSJZ5bfiMvoAdvrZuKr3K3Wid4ICP4/oIef?=
 =?us-ascii?Q?VdDC3+unvOF+0JTFZGlexgBz7RNl+PPRQ/Rxvy6bCD3/LHk2JLI98ZknJH2Y?=
 =?us-ascii?Q?5ysfgIO6MKgd4LAKB9hXW7qaaW6PX00oO7E9Hu6alZkYbPslXd0Kv+wRMlEx?=
 =?us-ascii?Q?N87c29BF9JpzreM=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2025 20:07:50.7759
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5216b120-cd49-4a96-d42d-08dd576a69ce
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A2.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4064

Reported by smatch:
drivers/iommu/iommufd/device.c:1392 iommufd_access_rw() error: uninitialized symbol 'rc'.

Fixes: 8d40205f6093 ("iommufd: Add kAPI toward external drivers for kernel access")
Cc: stable@vger.kernel.org
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <error27@gmail.com>
Closes: https://lore.kernel.org/r/202502271339.a2nWr9UA-lkp@intel.com/
[nicolinc: can't find an original report but only in "old smatch warnings"]
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommufd/device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index 6dccbf7217f5..b812ae40f382 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -1348,7 +1348,7 @@ int iommufd_access_rw(struct iommufd_access *access, unsigned long iova,
 	struct io_pagetable *iopt;
 	struct iopt_area *area;
 	unsigned long last_iova;
-	int rc;
+	int rc = 0;
 
 	if (!length)
 		return -EINVAL;
-- 
2.34.1

