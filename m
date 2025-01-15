Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2086.outbound.protection.outlook.com [40.107.236.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6B2E22F392
	for <iommu@lists.linux.dev>; Wed, 15 Jan 2025 06:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736924190; cv=fail; b=K8sA0oZvDMAEjT7T4lGKU557QZU2fQwaWCaNp8PXUKWGrvpx4hIv2zyay7pVy+Zq1g0qJ3Uqb5sofiyTTccfoWrhYrNA/vhRoKvj50wpNNqI+4bB/qCyTLx2auZ839a198MLLN5pd7pREixTTGMtcyEvBCKYZqijureX7LylAbA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736924190; c=relaxed/simple;
	bh=gGG+Ob9axHFKueqYCMvRiTQ/0ifCTEwabJdfpCG92A4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qGBvL5+W10ex4ogOlakrk5qQhgIM/MzAS393YgPuBLtyjeG+cwgQzJlqCBfA9SE1DFLuQ8jorwltzLJIMYKlg5lD4pQk7CsOUgBnfFR/0GeSTXo9NAEzBjLS9lM+B8pElB/bKpUdz6AU2Gsgo0c+a9KCLhLKZ+92EcXr/mYcDZc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=IwmoOQMM; arc=fail smtp.client-ip=40.107.236.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="IwmoOQMM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M9sWTpJnX6YCnBtjjVIndI55HKHZvNaIi+8OPqJUidOsuiCaQgSG47Br3KOmepEJ8oPlNSpmhg+5VFwelMVdpDWyJOC33sbW3VG031PmxD6m2BXop7PwH2koh7NZtjY2CMTpqPzaJGzAFjm2PNNtrxlyKRmRebAeGgdmES5LIZlYeTLkisOMfzCelW+cTPtJgpeB0BlhN8kTUj5lS3PE2z82N7BmxlHwja5d1N2Vorh/mWZ0wn9iX1ti5NnO2ZItdgFoV/2L4wnspiMYRzoAfhMH+GFCM9T0XgH7DkSHwiNtPsFKxUxPyd5qNn22qr3IXCYeizFmoNsIQm7lWua2sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aT782u/NwAmNLZaTLyF68p53BgKVwh74JsUJvLIPTIo=;
 b=L9SvpwTMXrb2XcnCpOKS+4X68CyUjSd0l3Fw+lKoPwEeApmNluZIYfwZV+zZU58t5LG7pP0e5NA930hz3NjNDfqzTcOS2Mjb1wN8n2kmpzTvIEchjxGwogoCiqMNnzG0rn1lJaha+ji3VWxH6kbU4HH+ew3Qd6MM6alYZIiER8wzQx8vvzEwirr/01fMneLvZUYypuoevTA8uwMwTDwefFZh2TPDQihpyTFRmJAMLzxAs2GC9F6rsxs2Oh54SAktlGiq44O5lRSj6XCi/umJz+CHzNdZBq5SXANfaprYz1Joq8ljdW0mvKAW+8bN7/0jWj226QHk5+W5TBx+cSDhfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aT782u/NwAmNLZaTLyF68p53BgKVwh74JsUJvLIPTIo=;
 b=IwmoOQMMi8Fk+31l651EHOmneEG41o1XZO40JgOQGByd3FgaG99z3C7LyJ1QI3LMiUJIhseahQrRXnC5/fy11uLfnMDLEHkJ0B/qys2pvO7+2LEN2apDk2hdqKAcfpRaklvLPZtFdM9SBog1GC+xrlYiMsZ9tQMZ+R5PPSpaMhB7hxg/RyGyCsIcyV9GVPDO3zf1jIbJx3NaHzDXUjyaP3RQ/4kmMV76dCQJ3AJxFTd+UNLhXKFKC6slPeAM3BlX+rtNWL2JHTmLaddoxHoR1JO8sD4I2AjEUhTo2s7aaix/Bu/YUlSiV8/uI9I+THRWLo9NQiu8cHWxzgwhJC+sgA==
Received: from BN9PR03CA0725.namprd03.prod.outlook.com (2603:10b6:408:110::10)
 by IA0PR12MB7556.namprd12.prod.outlook.com (2603:10b6:208:43c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Wed, 15 Jan
 2025 06:56:25 +0000
Received: from BL6PEPF0001AB74.namprd02.prod.outlook.com
 (2603:10b6:408:110:cafe::25) by BN9PR03CA0725.outlook.office365.com
 (2603:10b6:408:110::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8335.17 via Frontend Transport; Wed,
 15 Jan 2025 06:56:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL6PEPF0001AB74.mail.protection.outlook.com (10.167.242.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8356.11 via Frontend Transport; Wed, 15 Jan 2025 06:56:24 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 14 Jan
 2025 22:56:08 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 14 Jan
 2025 22:56:07 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 14 Jan 2025 22:56:07 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>
CC: <kevin.tian@intel.com>, <baolu.lu@linux.intel.com>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>, <joro@8bytes.org>,
	<will@kernel.org>, <robin.murphy@arm.com>
Subject: [PATCH rc v2 1/2] iommufd/fault: Destroy response and mutex in iommufd_fault_destroy()
Date: Tue, 14 Jan 2025 22:55:59 -0800
Message-ID: <bc8bb13e215af27e62ee51bdba3648dd4ed2dce3.1736923732.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1736923732.git.nicolinc@nvidia.com>
References: <cover.1736923732.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB74:EE_|IA0PR12MB7556:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ec752a2-99ee-4fa1-9b0a-08dd3531ba2d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Rs5yZ2c+UJd1oC+ylxZrZMJnX2WNaHt12jwMHb3ol8k+M0QAlcWn1kQBEIhd?=
 =?us-ascii?Q?CZlxC1kD5uHcQH+lStFpaQ9hzg3f5XQc5VoEAPimFzsahtLJlQWVkgEqQDgG?=
 =?us-ascii?Q?yuU2rtAYLG25XnSnmeMsdi7YDrGVZ8TqwCFPwjHu1+i0SmPhTLrylPq7GbWr?=
 =?us-ascii?Q?GWhSk0XAJO/inLMLH1hVZTbE7B2IPkY8k0X8iwjLx6gIdXnuqG9q1j69qnse?=
 =?us-ascii?Q?0AriYQ3mQNnNai42sONKxpl6ZbhYOhI5r+Iv3p7VaiiZ+nsjSzjxWudszR5T?=
 =?us-ascii?Q?M7enV4SgvkZ5BZPizBuQHY1e0OQJt1JJV9f6Vq9a2+HJjTAh22EVy5j1nMbB?=
 =?us-ascii?Q?WkdahkztQq7BtbvMXv1uB4TYDhhGd1S9MUFYRtT+2sUrlnPjdde0tF6JBIay?=
 =?us-ascii?Q?IB6ifVUkqCA4aJk9DObJuFWfvAzJQk6bXgWkxsD4YddyWkBw3ZMFCdhRMWW0?=
 =?us-ascii?Q?VVrOCGIwdhjBlclPhP1kuUp6LmsslGb/SltEV1cwJHMID8yplzfjT7s0gzH6?=
 =?us-ascii?Q?zZCuW2nmXxcyUzAXno1rA5oC6tdnt0geDO+xY2JQvolU2dkC9KAgaqiSJ6NH?=
 =?us-ascii?Q?iREL2n598AyrwScTDOI9cxlvDmykk66rYiyR2SZYHzc9Zgk28LrmWaiVSi4+?=
 =?us-ascii?Q?GID+HLoLaHJl1BToLJGdlrZH8ajZT/xV42nmnt49/pDyF8WAJJElJ+uxi2qd?=
 =?us-ascii?Q?T1OFKs+H8Qa3IzNcdavBkmoAYKrrGwoSFvtKk1sSu5lsM8kgrjfaBM/Aebg2?=
 =?us-ascii?Q?cpVPRXQWo+GB81Q9oGRlNjxuU0SFQy0bQkC/RT0ilzr3XKnMDxAr2yaofB7x?=
 =?us-ascii?Q?OYvBbgnFUyeZQ/E6WXtFsGgMa8EOvmy1CrZHk+PdzuapQtT1ZAK5sWqR8xIw?=
 =?us-ascii?Q?UBxu6rWT1XyQa94dbLGObO0G7K+otwZwCmyK9YS6XdpS2vwOe5LX7Y+/5oVm?=
 =?us-ascii?Q?oxBXCdx6ByKcOSq0DOAjx3pk5tK+SsPtyawFeiiMqnB/WXQFMDO7NWZnVLrR?=
 =?us-ascii?Q?n2kSbY0+RASCxcsRvDrg4AsyQIRrvwETXHpffs5eH9EIjV9FbwR/ndUle/gQ?=
 =?us-ascii?Q?7q74N/igpwq1U8ayuUY89dKk0Y92fny9Y0VepAdFEbLGBhl2DktYRCbgzgUg?=
 =?us-ascii?Q?LnIdzmfV2Xwml+MxDngadaPM+m4U6BLo4EU62FTt7oZ8io/z2vf9KFOzqNRg?=
 =?us-ascii?Q?rf1FPecVehVdx9wEGQz0KFfiKn4QJ9OcKxd8p1Q+zs3KX7a9YMkF8FG54nT1?=
 =?us-ascii?Q?/QLv7ZiBuFeOEWbqn4/tQTkuNLdmoPbBIBSd2e8MyAq0CfTxlOaOQog+8JJI?=
 =?us-ascii?Q?ZF2ywkAoTWCc5ICBW7/UO1WvCVWjmX0Kl4hW9q5R6bcxPNPunspYx9ptkda3?=
 =?us-ascii?Q?7fpa7qM0l3/vPvpkmu1ha8pdtjnwvDesIisOWMWcoRGt7g7fMmRndXq2tdDJ?=
 =?us-ascii?Q?1K2Kdudmgaal1WUhef3HKEMj8UE+Q4WrHrACpFXxTdsP8KsA/7USR+/7dPFy?=
 =?us-ascii?Q?JFRRk0y8C5OHsm8=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2025 06:56:24.7511
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ec752a2-99ee-4fa1-9b0a-08dd3531ba2d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB74.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7556

Both were missing in the initial patch.

Fixes: 07838f7fd529 ("iommufd: Add iommufd fault object")
Cc: stable@vger.kernel.org
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommufd/fault.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/iommu/iommufd/fault.c b/drivers/iommu/iommufd/fault.c
index 1fe804e28a86..685510224d05 100644
--- a/drivers/iommu/iommufd/fault.c
+++ b/drivers/iommu/iommufd/fault.c
@@ -213,6 +213,7 @@ void iommufd_fault_destroy(struct iommufd_object *obj)
 {
 	struct iommufd_fault *fault = container_of(obj, struct iommufd_fault, obj);
 	struct iopf_group *group, *next;
+	unsigned long index;
 
 	/*
 	 * The iommufd object's reference count is zero at this point.
@@ -225,6 +226,13 @@ void iommufd_fault_destroy(struct iommufd_object *obj)
 		iopf_group_response(group, IOMMU_PAGE_RESP_INVALID);
 		iopf_free_group(group);
 	}
+	xa_for_each(&fault->response, index, group) {
+		xa_erase(&fault->response, index);
+		iopf_group_response(group, IOMMU_PAGE_RESP_INVALID);
+		iopf_free_group(group);
+	}
+	xa_destroy(&fault->response);
+	mutex_destroy(&fault->mutex);
 }
 
 static void iommufd_compose_fault_message(struct iommu_fault *fault,
-- 
2.43.0

