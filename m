Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2042.outbound.protection.outlook.com [40.107.244.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7652420B0F
	for <iommu@lists.linux.dev>; Thu, 18 Jul 2024 05:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721278921; cv=fail; b=HWWKLyEBnFwNDAuUV7qmy9xlwhPTIC7JwtS/SE020q1fMNh8VWoiwewAKOSIAT5ZDdbkBSOTXqo04pELtRA7Mohv9Zlrmc/7nNf3F+h+vKmUXdRloQ7gsIB+aGxP8WWozpjFTfirkAfkxBk7uOCRhb0dEHEBWhKIuVlNgyxLMyU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721278921; c=relaxed/simple;
	bh=mLRiSuPxMW3T48C+mcVvqgJZ7YZ2LIvudHaPA3aDOcc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=eEDyHBt+fJIkLJgVzroGlhM3YZwxgO2hCqYSxw+hfbR+q6oFbv5j/rKyXsi6fmdBJcJdD6/qYbUNpMuWuPhA+jvIHp9wRzCgGfKy/iPaBY2tG69kMcIW90D/4be3cc3V/k4BW97mqRjYghaudiCzRzt5cjMXhGWTXhNOjGqGO4w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=IPXo0Aq/; arc=fail smtp.client-ip=40.107.244.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="IPXo0Aq/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LMM8qb+XZHbaDiRwcoAsKMFAkFH8AnwCAse3i0JujR+sIh43+lm/ew+XIZS/Th7BHylbHtiwDx6gnwKsFX6Qva753kAh8ghOBOienawQRzLYQI0FNaElQaxjAOCAlSIwlfZsEYyYs9RCp7XOoj17+e/YMQypOwDjgaJFZ1Qi/WGo6S+Rhnw/1gd08VSmBLn3IprHfH54mI8RqbKET6tsxGp5cbNTp7Hwgw08BqsJsINZcmwITcldy0EKA3ybMxnJ+bTGg4QqmslaAnXmo1W6MyE44MP/GKzx9tBfvc92m4lfwiP3QKpM2Ij/4O0JiSex+PGvxqS46dE0/cREZ0w2Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UkBdSgvop5PtWWXUOA4zzguTiI1Ppcf67k7e4Z5L8gk=;
 b=fmPMAC85X9LYKLpX9P/XPQw6T4lTWsYJWI9AzCjqR5hXHnRwecjfYdo9pVi1p7MeLEqjwS8eiEueVwvhXDDCjwULT5EIO6TogeeKBkPOko56gFCi522lZSVBbzRRozhiMC+I+VERqyrsRHbUbzPtJ/Hv/21cS/xYeoFhuZQ8vRSoTn7mxjiBIXTR982zT2/qs0G7ofwhPoEE2UxUssXggHWBGHSriNUgsGS7KyI23mIApa8pj6qsvWTHlzuNDggh4h9cVQ/pVgk6wGaNHvEWOxCPwtER16LcvDd1TvvaFlfwnXzU5JNzHwHNx/79EQbJoSoJ9h3U8AvvSu3J4gcmFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UkBdSgvop5PtWWXUOA4zzguTiI1Ppcf67k7e4Z5L8gk=;
 b=IPXo0Aq/BpRC9gWIr99pf9UBwNNvP6fYSrJLOzSJY6kYpyHRy00QzkFJzrkghDCZwM82y+IKMOneSXpKZxfhGsFY/zbzbn0nquOpHUMZdWxLStw8jSxSyGBw0t/e7DQJg/wqC17i+v71SDB4yDUbXDn8wI/tdE1YAx1CMJnuJHMFC/4s4LzKT+qZ8bueTNMTO/+YF5UpdgMNxHNZmFwqIwYW+BvgKwJds6hLjVIJbdc6MiTGHpSIqop3KpSyhxLrncGnMjlelZKIU4SzFVr9AZ9MfAJzIt2hUcq1eBqR6m7b1/bSlv5oVg6uQHmgHxMCv906EMs1Ap1sL/z/P5uhkg==
Received: from BN0PR07CA0024.namprd07.prod.outlook.com (2603:10b6:408:141::33)
 by MW4PR12MB6998.namprd12.prod.outlook.com (2603:10b6:303:20a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.14; Thu, 18 Jul
 2024 05:01:54 +0000
Received: from BN2PEPF000044A3.namprd02.prod.outlook.com
 (2603:10b6:408:141:cafe::24) by BN0PR07CA0024.outlook.office365.com
 (2603:10b6:408:141::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.14 via Frontend
 Transport; Thu, 18 Jul 2024 05:01:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN2PEPF000044A3.mail.protection.outlook.com (10.167.243.154) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7784.11 via Frontend Transport; Thu, 18 Jul 2024 05:01:52 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 17 Jul
 2024 22:01:37 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 17 Jul
 2024 22:01:37 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 17 Jul 2024 22:01:37 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>
CC: <yi.l.liu@intel.com>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH] iommufd/device: Fix hwpt at err_unresv in iommufd_device_do_replace()
Date: Wed, 17 Jul 2024 22:01:30 -0700
Message-ID: <20240718050130.1956804-1-nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A3:EE_|MW4PR12MB6998:EE_
X-MS-Office365-Filtering-Correlation-Id: 92c1ca03-a72e-49d5-631a-08dca6e6bd7e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CS7w1X9RX8Xn9zWwMiZKSMqc4QDQ9X+QL+MrPWRB2mSIBaJBnT0gcxK5d78H?=
 =?us-ascii?Q?amkrY9UTBhD503mBijZZSxdmiVJGe+PdPxaZJdy5Dv/u/hRhUVWrv6K9G4l7?=
 =?us-ascii?Q?VcVOlciFJFHSj7D+8LTEox0xTFbmQ62uo3whl++i1MEtTKo+Q58L2zTKGWPk?=
 =?us-ascii?Q?xF8QRt3dQPxg2F81DTnATJuEZWnhGw2aKgWcb+fzBnWpi18ad2xbgyudfzAD?=
 =?us-ascii?Q?ZzP2OlazrfMgCPZupTgIQ/zomoXqGU916SzSgrq2pgL/RhvGVH+SKc8e/Elv?=
 =?us-ascii?Q?eOykuQy5WezXSEtjQXFYrkacnVBUFgj+f0YTdv7Al+pl4oJ7+UfjeeekaKnR?=
 =?us-ascii?Q?/59bzp1Mv3bsH2ajdjlhGse6u4zIc5X78OPYL/xqMywNS035meU8CIIjLQEQ?=
 =?us-ascii?Q?NotfA5gWH2e2NHx7x9n/BfJ+zEalEVcXnQmGKpxO/Usk1+vl+/JNoLXzehIV?=
 =?us-ascii?Q?4aPRcloSQFxvcEfLhT47Nd+wRBExv4BMxgIYod5f7cOLO2SwzXYhQEpu4n00?=
 =?us-ascii?Q?JmLqNYMTth1vSqzZn/lB88OokqJufTqWbkzorYNs993gIr3Lq8ou/EvDH3c6?=
 =?us-ascii?Q?r9Ajh6kJT6oUw5h9y7M9SaQ5cAdSos/safZpb4aJx3l9DUE45GCWvqaNSvJX?=
 =?us-ascii?Q?ua0RLTKDaPBo1S2MOY4ZIAZhpL3x1YH1IdOzy04t94qietF6Oj5pHXdMnnUS?=
 =?us-ascii?Q?jT6dm59mLk+IubKDdrQF/rmuOtTyhaoGDzzrKo9kLis2QRLmhrK2oSfhKI6X?=
 =?us-ascii?Q?V8bcqUbx0+2z41E/RqQ4xFKrGt9sB1FqfkcTG/7ravonbw1y80hfUGx85CRw?=
 =?us-ascii?Q?lP8VZHFQdcBbj/QpDcvmJOLyIgcCcZ8Co2729+x2fJOcHJ+OmH34M6sYuwQK?=
 =?us-ascii?Q?N8PM12YwueZjrTRs+XUF2pmxI328jQ2v6C8L8phwumSiy//kzOF9gTm7+Vp5?=
 =?us-ascii?Q?0inozsTg4gEdA/P7FJTjDDTfAccLK4gLkm2JRW5KmrX86vvHzVHWEzmFZTSs?=
 =?us-ascii?Q?sPyR5GjBLgw3iEHgEs1aCHnv3i+ek28zimjbK6dvP3uNV8xeKjLgGtwTx7wV?=
 =?us-ascii?Q?YHqyoAS+FWyKr4/i07BcZBRxl/NTbrjt2cZW0NVz06Ab2io6STbLevhStRl2?=
 =?us-ascii?Q?gmgGzpOZHmUBg03qVingqoxw2NckovaJMQAn33X2NUsTr3/Usy/rURQ/yXBc?=
 =?us-ascii?Q?1sFzO6opFSJEedUOLTw7Yji5Rs/5qDpPn+akQ0dUqadXHsHWumjQabTh7JkC?=
 =?us-ascii?Q?j4iJr61fKgAPLgnr3ChT2H3SNnqszob9pMqAfAEjb15m596LuIiZsw2+reGe?=
 =?us-ascii?Q?6wiHgTVv/MdCccKGQMFGw2PvVh2y8QHm2NKDa8j84fxeUsvwwUFq5XF62Lx4?=
 =?us-ascii?Q?9Jc4kE8x2/cEN4TeICTqcFAZQ9gy8gmyDO11iPkuHhNdhnfC00SZrAZ8f/uJ?=
 =?us-ascii?Q?TuoEH85s86jCuaoKZ2qKL8e1Vzd79axZ?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2024 05:01:52.9758
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 92c1ca03-a72e-49d5-631a-08dca6e6bd7e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A3.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6998

The rewind routine should remove the reserved iovas added to the new hwpt.

Fixes: 89db31635c87 ("iommufd: Derive iommufd_hwpt_paging from iommufd_hw_pagetable")
Cc: stable@vger.kernel.org
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommufd/device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index 9a7ec5997c61c..3214a4c17c6b3 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -526,7 +526,7 @@ iommufd_device_do_replace(struct iommufd_device *idev,
 err_unresv:
 	if (hwpt_is_paging(hwpt))
 		iommufd_group_remove_reserved_iova(igroup,
-						   to_hwpt_paging(old_hwpt));
+						   to_hwpt_paging(hwpt));
 err_unlock:
 	mutex_unlock(&idev->igroup->lock);
 	return ERR_PTR(rc);
-- 
2.43.0

