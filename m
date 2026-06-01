Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010057.outbound.protection.outlook.com [52.101.46.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA9163FBB7D
	for <iommu@lists.linux.dev>; Mon,  1 Jun 2026 20:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780346609; cv=fail; b=nrhhtFxmX0MMFGl6iCijY9lwTOhC5ib2DJtXpXBwUhCC0RIc1AFb8TVE8FqqLBRRjnwK2fvIci1w74N24oPaIP3b4/AVF45M4WsMKsNYAZcec9fCQiPR7AYGFz23onkc+9zFp1t97oE+ipa1bWz0HX741vcqt468RiCJxenMMIU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780346609; c=relaxed/simple;
	bh=x66F3SPoN17phVdjUEix2CjrNPVhEPHU+LP06Yo6O14=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z/7JBudxVPXXM+IvKo/KQWBsyJib6dK0NpcJ/xca9x+Zd+qLcsWEN7QS2HvssOoAkdE0wY2eCu/hBF7bbIbPjfkfoTNpDK7K4Jzz/MqaHWF49x62irQtFhF4LM9ZLzykDs729AazaIyKw2A11WqbY+ohK4fGoEEQTe21Gtm4Yok=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZNERNQu7; arc=fail smtp.client-ip=52.101.46.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZNERNQu7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wybFYDMB6Op49V0A+37KdyS1QN94zv9uv7R7pMqEUKqNRtiCHGT0KykrxL2D5ZaLVIB7Ax47D/uDoRQPDtjT02H2B0yIqAFJC2GRUk5P2MJwv/+8OPNc8iDMb+EiP3koG6yUULSxCcG8IbHhsEnatf3f8XkZqMjTFlRCWwBL9AnNp1LW69osRKuW1Y5Zz36Ih/So8EsfvZ+1+JAwIzwuHHQAeJAkbQ1yKwcFWE/x8r7CDtapoJbdm69pls2bprWTaeYSy6PKT987yimmOOuEdqzHpOFiGY6+IECCYDlJ3F3tLPmYP3hEtlDYHUC4aHkvVlte7jZUl4IbqGYatF71jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ogcVoElS9hGgk8JHfrEawWnuwgkLK3A/uiwo/52fZXs=;
 b=wsFpVlljuAisgLh1l0oGXcYVt6jclGAX7vN2dr4UlAEcIth/I+7GyFm16SxR2BMOVQWT0e/fSKwZTiCMEq6Nua+O2YhevNTQAUrHqW98lboWnfHMJ99OGAw1s0/EpL5l7zfz0xxvzKVPDakMQRTwdCgzFVMvF2ubP2U9mvK+QJetLamUI+wKOD7ZC6jC6J4IA6pkbdunypwhl2dJtRz3eZ0M4P7CFgzBb3v656eRRkZfoy0RDZKPBXIdvCTVrMpy4zRIXZGYArVgdLl4zjEWwt4pAsS7G86OCalkA2bMg8ddSYcj9Bg4F1gloF7Gsjmve0Wc323bo1aEpOoR41Ku7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ogcVoElS9hGgk8JHfrEawWnuwgkLK3A/uiwo/52fZXs=;
 b=ZNERNQu7zApZ6fXU+CGh/6x+XXFmW4tXwsuqkCLbvi7pddsCuVDqCdHVkKFf5b/M1sJQiWbdmRziHoxlA9eGRzfiPHl7jJJkVbBREwPbHVLMYKzAySHKKamNsopR79wT+oj7ISZQZ2v5RbxwSFghu3D2j5HVf6zwEdsJDsxC1ca5YIYE6AZltY7GGCaPAsqeg4D0j+NxpkwlorjtBsn8XRKs2bverhmSu8mh0oPRVYr4/tjjTjc07yuIiyJdnV6SIkR4FahpI4lmNFUCKBhQBF5fMyjyjkgBAMexjZBSdAy3DivpisXoMFYZhuZFUvTtMOhv+7EY0NhJAxKxo5FFwQ==
Received: from BN1PR12CA0014.namprd12.prod.outlook.com (2603:10b6:408:e1::19)
 by DS0PR12MB6608.namprd12.prod.outlook.com (2603:10b6:8:d0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.15; Mon, 1 Jun 2026
 20:43:23 +0000
Received: from MN1PEPF0000ECDA.namprd02.prod.outlook.com
 (2603:10b6:408:e1:cafe::39) by BN1PR12CA0014.outlook.office365.com
 (2603:10b6:408:e1::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.16 via Frontend Transport; Mon, 1
 Jun 2026 20:43:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MN1PEPF0000ECDA.mail.protection.outlook.com (10.167.242.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Mon, 1 Jun 2026 20:43:22 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 1 Jun
 2026 13:42:58 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 1 Jun
 2026 13:42:57 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 1 Jun 2026 13:42:57 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>
CC: <joro@8bytes.org>, <baolu.lu@linux.intel.com>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
Subject: [PATCH v1 6/7] iommufd: Avoid partial fault group delivery in iommufd_fault_fops_read()
Date: Mon, 1 Jun 2026 13:42:37 -0700
Message-ID: <360cab4d4aeccb0bae275a970e2b3c340a71e0e0.1780343944.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1780343944.git.nicolinc@nvidia.com>
References: <cover.1780343944.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECDA:EE_|DS0PR12MB6608:EE_
X-MS-Office365-Filtering-Correlation-Id: e591d506-38fa-4bd5-e01b-08dec01e6bfd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700016|82310400026|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	oNSwJZIUEourbe86ZvZCvh42qU77AnTYWiSVEMD+JG+ebYFsnWwLJV7zGJTWxtVxPi1ZYHx3KBjZDnapZRDH00ZAC3z0pmA7q+sJXFEgNFEXfe7e8hrRtFKSFJr+nQbCh8OFWSPwcobCxCOmwDbfydCKkNswUlPGVFNCixXMqJoL6V/N3x6xDvqR3tHaATsiS0ntw+pgoWlSGYGIXzooKaNHiTJpPYO6N0O2CeRShPSCNariFmyjMTBJfe54OnSXKF0VMOi0A9vc8sb72Xn4xU+oSOToXFmq47Cf24MCTqXleRy6BYn+VYakllw7LB3bw4DBWXRL+FtN/yDzOOX+kdeH3BzlPQ/e25zsnNSHW1Kb1t6ja5m+5gbQQf0hVnwu7G920G6EbXYZ2Q+rkapa8Ml5CcDvDz2jD2b1CFKZWxILKZO4n+LArDTmhe/pFxpRJO8S53naLQiwJCVdKwpL3xYWEGSVGJ11N0ZjxUArsOKlbtVF+EaIZ0pr6CwtqQJRq2VTgYVW45Zr5faj/M5MGn44hAdqucylqGUG+xeeB01S6NZiNfalta1ec2Ye0t0NNRdC/eehtiLhdeQmZuhn6FlYzykE0LkRtD0u6uFhsW8X18pigpn1YlUB1hN9f3j2B+GKy+zK5/qz4Tr6VHMFKYDzVo8o//i94aNFBhzX3XHTlIzq6rcSqcMtyuLwAP5t05ticBzfDy10pZ2uPR83ThR3/fu4c7nv5cPVIrl9BE0=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700016)(82310400026)(22082099003)(18002099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	GpLCaqTu6Abi7+CbXMkvoCkODgwFcLFU6eGbl1kNXT006Zsui12N0V9f/MnpBApEVinwGT7E2C5Itosskzo/7X0WLOUumv5R2thyM7y7WdaONaStM4/vE452SCmkuxO+eQc2TWXaHOonP7vEUt9uI6qKTdJ2A5dNjc6R9BV8HtWNtg5oNitMnnI3KemfqPNTzPQjlXZjji5g/xZovDP9iyxSZ6RKQE8Hyj4zV7Vo0QrsxH3iz9yfkeORTNd5DLjEQ/pBvYVcTVpDM76cVMBh6f+Db6YM5tSdRHaSkRX+yHuxCfpvMTTnyD22YAkDOvDtroDUvVYmz4Ml52b2nJrGsZXNuZ/DpK0mjKcWz3JjXWfKZaS2DBNwwfHQTKnIWqPs+B7ow05HItez/veNPGPSawyVkBsbCWXxypT8NbByDDDj+9a+ERLG5sZq8XG143Kr
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2026 20:43:22.4688
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e591d506-38fa-4bd5-e01b-08dec01e6bfd
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECDA.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6608

The cookie returned by xa_alloc() in iommufd_fault_fops_read() is per fault
group, but the inner copy_to_user() runs per fault inside the group. If a
copy fails mid-group, xa_erase clears the cookie and the group is restored
to the deliver list, yet done is not rolled back. The function returns the
partial byte count, with the successfully copied faults sitting at offsets
below done carrying the now-erased cookie. The next read() then re-fetches
the group, allocates a fresh cookie, and re-delivers every fault including
the ones already copied; userspace sees duplicates carrying the new cookie,
and a stale cookie that can never be responded to.

Use a local group_done variable that tracks the per-group progress inside
the inner loop, and only commit done = group_done after the inner loop has
finished successfully. On a copy_to_user failure the outer break skips the
commit, so done remains at its prior start-of-group baseline; the partial
bytes already written past done are undefined to userspace per the read(2)
contract, and the next read re-delivers the whole group atomically.

Fixes: 07838f7fd529 ("iommufd: Add iommufd fault object")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-7
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommufd/eventq.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/iommufd/eventq.c b/drivers/iommu/iommufd/eventq.c
index 1c010e691f972..5129e3bf5461c 100644
--- a/drivers/iommu/iommufd/eventq.c
+++ b/drivers/iommu/iommufd/eventq.c
@@ -139,6 +139,8 @@ static ssize_t iommufd_fault_fops_read(struct file *filep, char __user *buf,
 
 	mutex_lock(&fault->mutex);
 	while ((group = iommufd_fault_deliver_fetch(fault))) {
+		size_t group_done = done;
+
 		if (done >= count ||
 		    group->fault_count * fault_size > count - done) {
 			iommufd_fault_deliver_restore(fault, group);
@@ -160,16 +162,17 @@ static ssize_t iommufd_fault_fops_read(struct file *filep, char __user *buf,
 			iommufd_compose_fault_message(&iopf->fault,
 						      &data, idev,
 						      group->cookie);
-			if (copy_to_user(buf + done, &data, fault_size)) {
+			if (copy_to_user(buf + group_done, &data, fault_size)) {
 				xa_erase(&fault->response, group->cookie);
 				iommufd_fault_deliver_restore(fault, group);
 				rc = -EFAULT;
 				break;
 			}
-			done += fault_size;
+			group_done += fault_size;
 		}
 		if (rc)
 			break;
+		done = group_done;
 	}
 	mutex_unlock(&fault->mutex);
 
-- 
2.43.0

