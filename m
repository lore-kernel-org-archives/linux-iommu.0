Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013025.outbound.protection.outlook.com [40.107.159.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2434B49A3C3
	for <iommu@lists.linux.dev>; Mon, 21 Sep 2026 12:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789994224; cv=fail; b=ocC0yfdvtFnD30BaW/VTZ0CAZo6WLlKn/97RAaXDT0WPeSf0J0aSGzadGMxiPxYCA4yg+RqX8DI481XJMn/JvxOafyu6+sjgMTwoAm8YbHAMPflAp1pFhBkbKPok2eOeNSGsDsan/5qsOx+YajKhbYFZmWxxLg88fJYpMoLQDp8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789994224; c=relaxed/simple;
	bh=umXTb/1OOHTWKEpQtm9AR3N5YXms8K/tOA2z5ZHGSMA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lJQ49za4EUNbzQWx+l3DwGFWaWo6y3WT4j8FLhU75f7J3JQFPYFTy6JsDVyfhbpCu1WDh0O9kag0s3Gvw/wEBwYkg4uwP9ZOp/AyjetZA9muudPbehlLYSFxRT4EJ1Wa+UAunbjJTMDfc9ZLPDWvCX8twvgXOA91PTEjkhITy78=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=PEpe8Dg6; arc=fail smtp.client-ip=40.107.159.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="PEpe8Dg6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ap5+/sMN/kUP5b08POsqzSiFNXsOIJTxPp6/zxZt1BVEKGjT7IPat5Mh4gTAp8u5GrLEObELTYt4yMX22SfI0OBb4K90HVRyeNWEAkA7AB3uGVFaUGV/3pxWfvd+E/h+0j7PSpDqiGCtdgofeWi7GZPyd6m5oYacDFzaASBAJD6y9OuEAOecPbB9zwYVUed2CO3K/ppbiMsKPvtiBjtva89by2xzbbysLcLM7WMYnkAuNqEXO5kuO56nnHEtsrBI2XiAMOYNvVu2vvNSFsXSPfyZLzOeVCSmyLgJMw7vGeg6rVF8D+qJYVyKv8K6Qh9x3nirxdiG+yUjpbaExEt+Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OBkujC1NXZxovgDMvI/zTLqcyC6O12+DyBcBm7tIcZw=;
 b=E1kJusHrbfn35lqdHWJqFGYD9+0BbyqTzVUJtGLmmodJYDkRbi68IjuDbIJaHdVNMFfNcHZ5Nuq8pkMUrFSE6nznR5/mIOG6MPBW0+CRQMqxGc44jhu2WprDt2gHAh8UJx4CTRI6/8I9E2ylskW+I0wqRU5EQVIHT7xvVgWhOT+N75khr7wpbCOdrhbZHNgvsVl00RO7eDIy1bHQGgGVRoaa0Gx13zn1jkuQmeSkGPLd7+dJ+XsxANxgZCwO78/nzmCoVUOFVrB9nosy/lG8ZSQGLyXPzvuhp73CB8EDkZ+1WnGu781xp9S6A7AayCuZd21jdhLnOS6bcHzTvID+QQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OBkujC1NXZxovgDMvI/zTLqcyC6O12+DyBcBm7tIcZw=;
 b=PEpe8Dg6Lf9NSxN9lM6LxoxZFDj389/xIcvcN1r9DiE0BrvTc9FfKRXkTWdbPMB4mFNLrE4H2sioRmm3ZdplpPhmHtJJvys0BrRIqhqTGhW4QAD+e9eXTajbclefWMGXuiC1RvHzpAY/lsRGhZ0oo4oon5H4HDZL7wdYFweyWeMM+F2jloEB9GmaihrACLHlhSGYWOCDVeBcpANLQZ9gcKrwJgB+UBTrhEeD/1AuXZRYlg5fp+MTWE+QCq+owGpEDROcYwl8XUgILXGcwHn2f7bWv8SLm/SuoujqlGPr5H2HAmMBllgF/zGEAVk1CK3linRKYZvFagVGUPKF2o3Q3Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by AM8PR04MB7907.eurprd04.prod.outlook.com (2603:10a6:20b:237::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Mon, 21 Sep
 2026 12:36:54 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%6]) with mapi id 15.21.0428.015; Mon, 21 Sep 2026
 12:36:54 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: will@kernel.org,
	robin.murphy@arm.com,
	joro@8bytes.org,
	jpb@kernel.org,
	jgg@ziepe.ca
Cc: linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	peng.fan@nxp.com
Subject: [PATCH RFC v2 4/4] iommu/arm-smmu-v3: Wire up shared-SID STE ordering and feature gating
Date: Mon, 21 Sep 2026 20:41:13 +0800
Message-Id: <20260921124113.1664326-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260921-smmu-shared-sid-v2-0-4b656ce68178@nxp.com>
References: <20260921-smmu-shared-sid-v2-0-4b656ce68178@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5P287CA0073.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1b3::6) To AM8PR04MB7874.eurprd04.prod.outlook.com
 (2603:10a6:20b:24d::9)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|AM8PR04MB7907:EE_
X-MS-Office365-Filtering-Correlation-Id: 22419541-643b-42f3-f47f-08df17dd0452
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|19092799006|6133799003|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	RR+QwofzL0L81ZxfO0ybUdAeVtzTyr32g8wAv02OGgTuRjXHVLUU/DDPzq46nK2S8n63hUaIgscBGa7FI9UhTbzQd++lRBUBGZ57Z6N+rX7jDnP7t51UCtIBkRSh8ZlBcpnJ+xo1PzfpLVeyH/b1OWkFl33ECIMtE3nMX9UZXxRviR8TIRS1kjhFIj6EdlYSSLvjnUpCKqnpKKfQ4uyteaLmqGXATQYDFgh/ADfIR2YYlEV9X2AwZdctklMNrP3N8wov1NDhOwKZEkSpCf8zBnyYRPFm9KWXYY0uaEgrklrlRq7wSDqI+HCeq/0ggR/fLdVljMlflPIGesfw9Kzke/JBNU5w3qBpRR/oFQjrvG2cN14f8i145TSCDYyXAKdAb8Mz248L+lykViztWyZdi/ZMIcn3CsBAN/ZBgg8AD45xREFXEhjeRULW1ZKquOVgu1KlFhCe2+IobsNkZlEADEguujv9E//iv7JhaEdd2RlvgqKIPzu40YldTYw5eJf5vQ16zltmP1eXhapoMRqjuu31RgwkyCTZWHIPFCm6XGWgpesRJ2jqKnF9515F2P6hjTRsetaC5r2oVvizuQYIwb74SigZHj+0bv3ndQ+3Rj/t57BkDUU9ehY21aRw+oK8rR/8IcGtQt/rxQSS19U40UcoTxB7I/Sezt4CB2/vcPU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7874.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(19092799006)(6133799003)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?anIG1HqGhBZY/yT5VnE2EnIh7LWZhyoEYqciMtazGt9jDi+MZIuIqJNKDAmp?=
 =?us-ascii?Q?dW12bZiksVD8Jy8p918ZJF2lANlGLrfnFOJfFLEhuqU09LWzoTjQKSp9kDxM?=
 =?us-ascii?Q?uiUAsQmQNdm9MCJZNtAk1lA0Hma50ol1N5f4YfOyp7UJj75oz7krUe46cuBv?=
 =?us-ascii?Q?Ho2bqd/PEURix6NicAo8B+zE8kcNUi7mZDjqbb1sqUCvbIUtWZGp7snStbPs?=
 =?us-ascii?Q?bd1r4CHmGwPd1TxZgxFwBgT8gYAlmjAsF+pxlsOwZ7uVd4BvFz8mJ6fLW2d7?=
 =?us-ascii?Q?YwesHif+KXN3YAiMxecS3wuuPHeOqEex17DK4Z5CTVjOsXmAnBpIjOjU/yPi?=
 =?us-ascii?Q?XolQavoM/9BAAFGG31iYqaJKqVKDRJj4/Pnb7MmhJsNcKKEEFdtXoKhehyNK?=
 =?us-ascii?Q?TIA64V8PXtv9giWUjOCLPTr4ISHvSGI+8JcQwaa46BW9c7+4/EsRdsnOyKKu?=
 =?us-ascii?Q?l8YHj6HIV4bps/6HqTLNmiL9pdhtmD0K+7JAmfQ5JD65dZqj3lPf6TeAxXfn?=
 =?us-ascii?Q?f25Wa5eWXFabIeG8JPc4E6jFtOuWkQblXafNuFzNKusD3ktjzYDCoq/Gf2h1?=
 =?us-ascii?Q?HrHBoLbjYGIRNcC4ANBQd0CAIHAmYXulQeU08x6oreIWUuBlfMZmODthcx5C?=
 =?us-ascii?Q?Ds6A6zdC9IPJGzdu3qx1XJ7tWd1Yz088MAxwjrU9/OC3PPYlpiFPBSdfoevg?=
 =?us-ascii?Q?osfQ8JgPyGpwAI9oeVcwisRFHOqWIN2VFfvidC3nMtk5W16DEYgsvAa+R/vd?=
 =?us-ascii?Q?2nI4pBalUqNtB7tOKI4OkSdeqhQXOSjGh3JudPKDslEYofNxpClSbj8SAdVb?=
 =?us-ascii?Q?iCxqG4IptDLCqw9yLREzObHgm6j14Og7x08g2mUYZkQ73vNcJ5HB1Db91yn+?=
 =?us-ascii?Q?FSBjaKAcg7NolbYRF8QajpYivSC4bUKLzz8yAayNrHxeDHZfwsGB1GxdwAPB?=
 =?us-ascii?Q?bDTbp5pJISco1KHRdRK5QYe+/l8jwxRiVgMh+PvLBd+jj0cGBeaofL3R0DqW?=
 =?us-ascii?Q?ANFDzP3n4KsYkqqvPeo+dcjiikMANgBCdklopC8j7OClmbu2eH51YJnLlgIT?=
 =?us-ascii?Q?VmEJNwyc/TKxfTO1ldPGRUiSJCfxxaYkCOLZrbVfG+9tWCFTZn0lflclJrwC?=
 =?us-ascii?Q?0eyqEaSuGxi7lOyHJyZQyTqDU2vEc1yr5ekKwYdQUEWqhHl76hI35hAdZWn+?=
 =?us-ascii?Q?2n+OnB3I7z2smaVMhboYasbG8Er//bGiaS7JRnQ85HNIeHqSHzF5TkextuoU?=
 =?us-ascii?Q?bLwm0/Dpe+aTKEnrNdDu1q2YD8PfrQZz+gUKFle89St15wiBY+YyHEP4PVqg?=
 =?us-ascii?Q?NRuJjW0zauvFeGrhsPt+Yys3X1NcQnkd9hmYxA0/PxlwtMr84LwxcqHzJlbD?=
 =?us-ascii?Q?s3GCT5x89gzQ9cO+cgq1UoxH/EmQiA9NkcaqJ6/SJ36/NND8dooU6+2K43HN?=
 =?us-ascii?Q?tkIAXyIRC0n452oUuR4EpBZEQQUsUY2HfN5tukxdacdHvxRZvSZ/nUZ37tLg?=
 =?us-ascii?Q?J3mjaNi10ukSC+v35e2pF8FUv9afR7AM7/4Tf/RJuWsUOshQI8UscxGq3Fmv?=
 =?us-ascii?Q?/d8xNs1KFUTIGav/5xhxjsDAuwaBkq97F5A0KQurPkziQ7vmMytHKlgsRjKs?=
 =?us-ascii?Q?WYZt2QqfGq8h3PWOsk3Z8mkBIOWGYS/rUv2rDoZ8DbVM9db3IuEErB9LO+hA?=
 =?us-ascii?Q?MjmkQjlX2UQKrsX7Ri4d/M0zkqNhY6onj+KG2xVLoduUWpyRO7XMWIww9yMH?=
 =?us-ascii?Q?2cUmKlBsR5b3dwnBB2d4X1Bh5uI2E03Xq6vEvhyA7Gk/fAEcRFeS?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22419541-643b-42f3-f47f-08df17dd0452
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2026 12:36:54.0488
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kMe6bi42weT9wt+X4C9kL1Q6N6sNNuzf0Ep253sdzxUUbcRaGAeByoUYYGkhm+SQVebWuX8Zvq412JLaAKaBoWraEUB8BcFjaQ2wgxNCUan2oeiR4ZVI1t2Sj7LDJCg5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7907

From: Peng Fan <peng.fan@nxp.com>

For shared SIDs, only the first master to attach writes the STE
(tracked by ste_installed under streams_mutex); subsequent masters
skip the write. On teardown, only the last master writes the ABORT
STE (ref_count == 1). This is handled by arm_smmu_skip_shared_ste().

Fault events on shared SIDs cannot be attributed to a specific master,
so arm_smmu_find_master() returns NULL when ref_count > 1.

Disable SVA, IOPF/stall, and vSMMU nesting for shared-SID masters
since all three require unambiguous SID-to-device mapping.

Assisted-by: Claude:claude-opus-4-6
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 .../arm/arm-smmu-v3/arm-smmu-v3-iommufd.c     |  4 +-
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c   |  7 +++
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 59 +++++++++++++++++--
 3 files changed, 65 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
index ab1078a97d801..258ca42917f07 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
@@ -308,8 +308,10 @@ static int arm_vsmmu_vdevice_init(struct iommufd_vdevice *vdev)
 	/*
 	 * arm_vsmmu_vsid_to_sid() maps a vSID to master->streams[0] alone, so
 	 * more streams would leave the rest stale and none reads out of bounds.
+	 * Shared SIDs are also unsupported for vSMMU since the STE is shared
+	 * between multiple masters.
 	 */
-	if (master->num_streams != 1)
+	if (master->num_streams != 1 || master->shared_sid)
 		return -EOPNOTSUPP;
 	return 0;
 }
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
index 0a429c64fbf3e..43f8cc81bfdd1 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
@@ -271,6 +271,13 @@ static int arm_smmu_sva_set_dev_pasid(struct iommu_domain *domain,
 	if (!(master->smmu->features & ARM_SMMU_FEAT_SVA))
 		return -EOPNOTSUPP;
 
+	/*
+	 * SVA requires stall-based fault handling which cannot be supported
+	 * when multiple devices share a SID (fault routing is ambiguous).
+	 */
+	if (master->shared_sid)
+		return -EOPNOTSUPP;
+
 	/* Prevent arm_smmu_mm_release from being called while we are attaching */
 	if (!mmget_not_zero(domain->mm))
 		return -EINVAL;
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index bb3ee25d10d6e..13968191b1452 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2034,6 +2034,13 @@ arm_smmu_find_master(struct arm_smmu_device *smmu, u32 sid)
 	stream = xa_load(&smmu->streams, sid);
 	if (!stream)
 		return NULL;
+	/*
+	 * For shared SIDs (ref_count > 1) we cannot determine which master
+	 * triggered the fault, so return NULL to let the caller handle it
+	 * as an unresolvable event.
+	 */
+	if (stream->ref_count > 1)
+		return NULL;
 	return stream->master;
 }
 
@@ -2944,11 +2951,43 @@ arm_smmu_get_step_for_sid(struct arm_smmu_device *smmu, u32 sid)
 	}
 }
 
+/*
+ * For shared SIDs, check whether this master should skip the STE write.
+ *
+ * Setup path: only the first master writes the STE; subsequent masters
+ * skip because ste_installed is already true.
+ *
+ * Teardown path (ABORT): skip while other masters still share the SID
+ * (ref_count > 1).  Only the last remaining master writes the ABORT STE.
+ *
+ * Returns true if the STE write should be skipped for this SID.
+ */
+static bool arm_smmu_skip_shared_ste(struct arm_smmu_device *smmu,
+				     u32 sid, bool is_abort)
+{
+	struct arm_smmu_stream *stream;
+	bool skip = false;
+
+	mutex_lock(&smmu->streams_mutex);
+	stream = xa_load(&smmu->streams, sid);
+	if (stream) {
+		if (is_abort)
+			skip = stream->ref_count > 1;
+		else if (stream->ste_installed)
+			skip = true;
+		else
+			stream->ste_installed = true;
+	}
+	mutex_unlock(&smmu->streams_mutex);
+	return skip;
+}
+
 void arm_smmu_install_ste_for_dev(struct arm_smmu_master *master,
 				  const struct arm_smmu_ste *target)
 {
 	int i, j;
 	struct arm_smmu_device *smmu = master->smmu;
+	bool is_abort;
 
 	master->cd_table.in_ste =
 		FIELD_GET(STRTAB_STE_0_CFG, le64_to_cpu(target->data[0])) ==
@@ -2957,10 +2996,12 @@ void arm_smmu_install_ste_for_dev(struct arm_smmu_master *master,
 		FIELD_GET(STRTAB_STE_1_EATS, le64_to_cpu(target->data[1])) ==
 		STRTAB_STE_1_EATS_TRANS;
 
+	is_abort = (FIELD_GET(STRTAB_STE_0_CFG, le64_to_cpu(target->data[0])) ==
+		    STRTAB_STE_0_CFG_ABORT);
+
 	for (i = 0; i < master->num_streams; ++i) {
 		u32 sid = master->streams[i].id;
-		struct arm_smmu_ste *step =
-			arm_smmu_get_step_for_sid(smmu, sid);
+		struct arm_smmu_ste *step;
 
 		/* Bridged PCI devices may end up with duplicated IDs */
 		for (j = 0; j < i; j++)
@@ -2969,6 +3010,11 @@ void arm_smmu_install_ste_for_dev(struct arm_smmu_master *master,
 		if (j < i)
 			continue;
 
+		if (master->shared_sid &&
+		    arm_smmu_skip_shared_ste(smmu, sid, is_abort))
+			continue;
+
+		step = arm_smmu_get_step_for_sid(smmu, sid);
 		arm_smmu_write_ste(master, sid, step, target);
 	}
 }
@@ -3116,8 +3162,13 @@ static int arm_smmu_enable_iopf(struct arm_smmu_master *master,
 	if (!master->stall_enabled)
 		return 0;
 
-	/* We're not keeping track of SIDs in fault events */
-	if (master->num_streams != 1)
+	/*
+	 * We're not keeping track of SIDs in fault events, and stall/PRI
+	 * cannot be supported when multiple devices share a SID because page
+	 * fault responses are routed by RID/SID and we cannot distinguish
+	 * which device triggered the fault.
+	 */
+	if (master->num_streams != 1 || master->shared_sid)
 		return -EOPNOTSUPP;
 
 	if (master->iopf_refcount) {
-- 
2.34.1

