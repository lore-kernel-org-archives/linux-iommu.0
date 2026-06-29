Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013065.outbound.protection.outlook.com [40.107.201.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1400A3C4579
	for <iommu@lists.linux.dev>; Mon, 29 Jun 2026 21:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782767790; cv=fail; b=OzmbRBgHPEYpXoPru8gscSl57nIKNJxrhDO6a819FqFdK6W9DU9ONUrsqi3skt+Chg42fddXfRyPYs67U5f64Mkg5fiB+xQH23jDMD6aWrx70Dsl5vcYyVRj2eAUIWnfjf3drMAaeJiCwvEh31zWxxoZXDHrOa7MYKEOV2msZ74=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782767790; c=relaxed/simple;
	bh=SVtbwjkjrB5/wU8NjApeo/YKmLSyAVfc8Jk/L9kvsgI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FxVJHcMLK5rshKe0abJuzuBTmWfOJG32Ee7+a1SfHcjZZFaVfjRR5pcGAaA/DuR0ycMpGfld4OrTq+Rue53DsSkC7Vw4rRT/AajSjKtrdquWFJW2b24joCwALb2aABDUnzGyEwtIKAq6KuuzBUT+zb8psspvOVIRL57ZXiL73BA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=sksX9U63; arc=fail smtp.client-ip=40.107.201.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="sksX9U63"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pM9iixYYV563PW3NWzdvK5I6wkTQcxfxlVl6jSoTgNwiiRysrC+6X29r1lJvAo5NE8tmWjogrIPCRAkXWvm5zwPmODyGsI4RaJXI5ty3Jd8DVt2h3wZaG0ygIJhaWQk+Y3/D22zFGa9TUL8nuRwtsHqe2wEyd1eJvHwyHG72gnyvhYA5+WhmbQfuNjJvXJcPvVwH5isdPPZzwhejVVO+Zww/FG8q606N3UYFlDAhCViDjQOZTFmVXJ5HM3qLplYQ6Gn0t4tj38DtiDbYa2XHepRXdUsg6CmdgOBTPG6uKS0HbRsnDC0jyzgWPwducrpi59GoFysdXjapC0JitcNnQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PHEXiyIy/0Zpk3J/WSxbLMb1BQwVa6JuGBYr9V9AaXQ=;
 b=aWBG0XWMDoCFjsCppLOhbybZ0sLFmdS3lI72hiHfrcEt6uRhNbEriusYzog4qotLCgGb91DbHiOEctAdUJW+cUjCVYXa7cbq7ko2q/MUe7zxCc+VBr4kXMCDz79R5Er0i77uzLwNVTGT4rvTTpxCe96NXnFbyx7wqFmVci1Fpw9HkU3KmzmopgZuMurOs66I9Z+VdTDrfXknVE3CQ1ej1CRrOC5/zCGDNdAaT+Ukbl53QqTN90QLrfotTpjFJq5V3jPx6db6vEHbTEYqjAsg9inOk7+6bUrO5/lPs9qT6ivVS5eqpIlHkKKu54mBihhQxUUDMoY71hQVWG+lHfu+9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PHEXiyIy/0Zpk3J/WSxbLMb1BQwVa6JuGBYr9V9AaXQ=;
 b=sksX9U63nZbnmZaaE2eWR0ImxKQgc6sswtiqBIkFhEnP+C+dsN7vlt4+B2P77lVrH2XL2Du/6Hz6GqN//eabZO5ORXO1QsDzZ0FrqvyTl3zJl+AqlFb5HuUx4xbGAyI1FmbAsekTP1VScW8EOzm2mljwlsRH72vGgxzlEraPW02mYtX0Sp2ulI8kF3M8O7Bb7RoO/oaHm5V6ROvW3eAaxPQHv6lwzkov8WYtTsy/1B3Ka94x9PQ82CPvCBE8HMkI4W89F/iG5WMc8FM+20XuEZRwFnw6VnQg1ydB8hbxJlt5TUVcpZ3Gxd3M956IorDj55lw4A8jBpalYZaxbYbJ2w==
Received: from MN2PR14CA0012.namprd14.prod.outlook.com (2603:10b6:208:23e::17)
 by SA1PR12MB7039.namprd12.prod.outlook.com (2603:10b6:806:24e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Mon, 29 Jun
 2026 21:16:21 +0000
Received: from BL6PEPF0001AB57.namprd02.prod.outlook.com
 (2603:10b6:208:23e:cafe::51) by MN2PR14CA0012.outlook.office365.com
 (2603:10b6:208:23e::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.19 via Frontend Transport; Mon,
 29 Jun 2026 21:16:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL6PEPF0001AB57.mail.protection.outlook.com (10.167.241.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Mon, 29 Jun 2026 21:16:19 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 29 Jun
 2026 14:15:57 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 29 Jun
 2026 14:15:57 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 29 Jun 2026 14:15:56 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>, "Kevin
 Tian" <kevin.tian@intel.com>, Lu Baolu <baolu.lu@linux.intel.com>
CC: Robin Murphy <robin.murphy@arm.com>, <joro@8bytes.org>, David Woodhouse
	<dwmw2@infradead.org>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v1 2/5] iommufd: Iterate the cache invalidation array in the core
Date: Mon, 29 Jun 2026 14:15:37 -0700
Message-ID: <dc0c92e0688db085e12e0b6931c49384489da887.1782767398.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1782767398.git.nicolinc@nvidia.com>
References: <cover.1782767398.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB57:EE_|SA1PR12MB7039:EE_
X-MS-Office365-Filtering-Correlation-Id: a2d7a7a5-18e6-4ee0-0889-08ded623aa0d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|23010399003|82310400026|36860700016|3023799007|56012099006|22082099003|18002099003|11063799006|5023799004|6133799003;
X-Microsoft-Antispam-Message-Info:
	Pbx4LOvdGGRdMdEYgV1Mmarj4YuhgAXZkNlSLUHKNPvMSS3YXoLhoAWyypAwnDjvjLS+tPJmpJNt8xG5rIIxm6aWjt9+s2D09088N+J7yFvODysqZ+0/ARpMMyVoaeT4+afu2F8KKw1pg5+EAkzTWf8zAKoB5Eu4XTU74oGjwstiPBAH2k9mUuYcmEfJOiOlxSOp1F0pin6GUJTKWoENJdKSy73CgSzvQczPl2AoxPCwaRyi+un3xxp2Sh4gYPwc3c+8WH7edPeSiUpSbNHhDqBEgALvnjJ7NT6k9awELgeYfKfEgFKgJzmMwlaJrZaC1OT0Uw5pJArrkc1AqNoRtxTNFAYFHI0ZtP1yXE8JmxUJ6zzp4LfwO8AqqMWg59wZUpbY6gwildqHxEJvfs8JqNE2zRkUAXFFagso6uih4/yBrYbcFcSI1VR5SP8T5D1V3O21zn0QpJAMdauq2Gwq0qphu5DFdDFfnyhYM0/VzDwRgvpygHGZGbNblvwr1Th5TTeF1Nmej0mck037dcs4zK6XlBhSi446jfEJWlYTThvgmpU5Ql2zhxCGCvEXk/fH9xmIyPTg+yFOvXugmDJah5XeOp+iH7Cie9Z5GYNPdg8w96B9YXaVBJIx8DyPXx08ATEb+rdnwToQrH1/UOgTzIfQSsFcjNmm3/RKHW6YogSjGoEkGeIxXAXBtHFQElov6P8wvvssXQjPYwy0zsQh9A==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(82310400026)(36860700016)(3023799007)(56012099006)(22082099003)(18002099003)(11063799006)(5023799004)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	wj32oGD7t6ZKeYcxhj+OKlWpUasgcsfpwQv+qLehrafGHVbM4OXmxv9bx+R/ivtaToVC2ZtpkYOISsnIy86N9gFxV8jZ/1qFCAV801mJneeTTO47ukoJJUqmRIGVAmZAJrsauyPJSLiRD+YFb++pcUOHU2adOSXWd4AwJ63bX6KLGnoEvAVh6uSLoaT/Fw5zv+ugcNKGA9gmL1ELGaptRvyT900nuQPrFGQdi+EKPNyP2mhPC35h/mcn9szDJ89AagobP43axPdGC4uHHmeIrNWyilHdbxrFsZkJX/X7I6PX7rAAllJsEddWyxdQ4ot+M22G+FmiqOPFE7g9ECDFwKocslsCYovOLHPzjmRT9uEDlAmtkNevKWlye84IKj51yKBPp9zb8+sRxbFYY1ta8MWnGK6Vu1Ps7Dy6FuphpADMqKssCtV5FSA4piJz1Z9c
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 21:16:19.6546
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a2d7a7a5-18e6-4ee0-0889-08ded623aa0d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB57.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7039

The cache invalidation ops, cache_invalidate_user() for a nested HWPT and
the cache_invalidate() for a vIOMMU, are each handed the full user request
array and report how many of the array entries they handled by setting the
array->entry_num. Every driver therefore implements its own loop over the
array, and a driver wanting to process that array in fixed-size chunks
(e.g. to issue commands out of a fixed-size on-stack buffer) has to carry
the loop and its sub-array bookkeeping all on its own.

Move the iteration into the iommufd core instead. Invoke the op with a
sub-array that starts at the first not-yet-handled entry, let it handle a
prefix of that sub-array and report the count via array->entry_num, then
advance the base pointer and re-invoke the op until the entire array has
been consumed or until the op returns an error along the way.

A driver that handles the entire window in one single call, as all of the
current drivers happen to do, finishes the loop in just one pass, so this
does not change any of the existing behavior. It instead lets each of the
drivers convert to bounded chunk processing on its own, done by each of the
following changes.

Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 include/linux/iommu.h                |  6 ++++--
 include/linux/iommufd.h              |  2 ++
 drivers/iommu/iommufd/hw_pagetable.c | 22 +++++++++++++++++-----
 3 files changed, 23 insertions(+), 7 deletions(-)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index d20aa6f6863ab..969758f87e445 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -773,8 +773,10 @@ struct iommu_ops {
  *                         passes in the cache invalidation requests, in form
  *                         of a driver data structure. The driver must update
  *                         array->entry_num to report the number of handled
- *                         invalidation requests. The driver data structure
- *                         must be defined in include/uapi/linux/iommufd.h
+ *                         invalidation requests. A driver may handle fewer than
+ *                         the requested, in which case the core re-invokes the
+ *                         op for the remainder. The driver data structure must
+ *                         be defined in include/uapi/linux/iommufd.h
  * @iova_to_phys: translate iova to physical address
  * @enforce_cache_coherency: Prevent any kind of DMA from bypassing IOMMU_CACHE,
  *                           including no-snoop TLPs on PCIe or other platform
diff --git a/include/linux/iommufd.h b/include/linux/iommufd.h
index 6e7efe83bc5d8..3087f5b2def84 100644
--- a/include/linux/iommufd.h
+++ b/include/linux/iommufd.h
@@ -154,6 +154,8 @@ struct iommufd_hw_queue {
  *                    The @array passes in the cache invalidation requests, in
  *                    form of a driver data structure. A driver must update the
  *                    array->entry_num to report the number of handled requests.
+ *                    A driver may handle fewer than the requested entry_num, in
+ *                    which case the core re-invokes the op for the remainder.
  *                    The data structure of the array entry must be defined in
  *                    include/uapi/linux/iommufd.h
  * @vdevice_size: Size of the driver-defined vDEVICE structure per this vIOMMU
diff --git a/drivers/iommu/iommufd/hw_pagetable.c b/drivers/iommu/iommufd/hw_pagetable.c
index 623cc608ca0cd..409ba2216f8bd 100644
--- a/drivers/iommu/iommufd/hw_pagetable.c
+++ b/drivers/iommu/iommufd/hw_pagetable.c
@@ -535,8 +535,15 @@ int iommufd_hwpt_invalidate(struct iommufd_ucmd *ucmd)
 			rc = -EOPNOTSUPP;
 			goto out_put_pt;
 		}
-		rc = hwpt->domain->ops->cache_invalidate_user(hwpt->domain,
-							      &data_array);
+		do {
+			rc = hwpt->domain->ops->cache_invalidate_user(
+				hwpt->domain, &data_array);
+
+			done_num += data_array.entry_num;
+			data_array.uptr +=
+				data_array.entry_num * cmd->entry_len;
+			data_array.entry_num = cmd->entry_num - done_num;
+		} while (!rc && done_num != cmd->entry_num);
 	} else if (pt_obj->type == IOMMUFD_OBJ_VIOMMU) {
 		struct iommufd_viommu *viommu =
 			container_of(pt_obj, struct iommufd_viommu, obj);
@@ -545,14 +552,19 @@ int iommufd_hwpt_invalidate(struct iommufd_ucmd *ucmd)
 			rc = -EOPNOTSUPP;
 			goto out_put_pt;
 		}
-		rc = viommu->ops->cache_invalidate(viommu, &data_array);
+		do {
+			rc = viommu->ops->cache_invalidate(viommu, &data_array);
+
+			done_num += data_array.entry_num;
+			data_array.uptr +=
+				data_array.entry_num * cmd->entry_len;
+			data_array.entry_num = cmd->entry_num - done_num;
+		} while (!rc && done_num != cmd->entry_num);
 	} else {
 		rc = -EINVAL;
 		goto out_put_pt;
 	}
 
-	done_num = data_array.entry_num;
-
 out_put_pt:
 	iommufd_put_object(ucmd->ictx, pt_obj);
 out:
-- 
2.43.0

