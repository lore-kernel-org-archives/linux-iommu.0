Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013020.outbound.protection.outlook.com [40.107.201.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B1C440758E
	for <iommu@lists.linux.dev>; Wed,  3 Jun 2026 21:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780522068; cv=fail; b=IEOqfiUZ+EyPTpt3ZrtRxvjhtAp2bkLeaFePg1oT/9/bR8Dl8HcY9TBOSbisgQogruND5ZzZk9nUDGWSV8JH9qmQ3wWSQ8ehy607hSozPVRM9cpNYIxiVN8TGARTlS60Bl55dBr9T7QDAyn2AIl+c/hROVf317IT3Livl5H58V4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780522068; c=relaxed/simple;
	bh=g3LVhud8I+30tCmMDykOYSVgLDmGzHnzm2+u9wG4P3c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L30BT+1iBYJa+HuKEN+x+TSXu3msD9Fn/oMX9oHbn6bbEkBcpNmIxw2T+wc+g6H5boFOHNjerubNJVqOahTghEdkENAKFH3/HJJGgMWsy2CHlgJ1y90Z/oM7oM0O/WTHwqW/sUBrnKGNQeLiaJtjxE0Z+6k33xRqJ3j6P6hKhYc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=AUjVyAea; arc=fail smtp.client-ip=40.107.201.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="AUjVyAea"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fL+d53G3JMXU7q1M30nnE3qzXwgOUFGgijoE+erV7YsV6VASWnBN4DuQmYtnNdezYkF+Av8m5MMqLAPeSa6HRsmHO0JVmIoCo+mkXGkULaQ5vUjO+CZp+zwthvUA5HEBTBHh6DQftpoS3Rifilj474FCickSdLMe8SQN6ffymq+8C32Hh8IH+Xudh0M9rDVEa+5dV6WUnEZBH7I4OLMRg4p27pzJCxBDWHaoQ4f5kfk4AWqeAlzdAJ2x4DaFLSzVfgcqDR36u07BnVcKPG3BP1b7aeo+lUquUUZgT7je7x0RFAYh/zeL5XHG6UBulQRju3i3EjTzbdvkAjhBmhDejw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ScDLmsf2XZV9b7pSAVLE6qhmAIgX2e0BGQG+cYT6CrY=;
 b=xX5dBFV4z9iPPvIp5SZtpgLquJ2ARIgn1xia9YfBrHKzZq/0gmw0rEXJRYeuz83cZAcii/CvrlW8YsBZSfE9HV2wKZNuV+xF0EFhQ/QY+caKzZaSwUDUlEd3p7z+COd6cR/lFlPmQR+6ssb0U4YFvIAg1iIYk5ALiZJ4uz4gcfN0M8iDPH76mVMNjt4PzxZdS7jWu7+gnS1NHM+bkyc/vq2AGxk/bVWYbRQS50wWhKntMB5raUbc7hDvl8YCh9vREQFlN701HFT0lP7P6d8j4/cmnUNFKuaLBhLjZxXR1hmKnCMr8w0A/lfaMYapqzuY+H98u0mKpTfAz24FG/37Rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ScDLmsf2XZV9b7pSAVLE6qhmAIgX2e0BGQG+cYT6CrY=;
 b=AUjVyAeav8GrL6TK/8U0rvvWTNo+b/WMSQqfMQT7pIxBtHpQIfeYfrK1a8hoSY3j9acPdlDUa6fbjWVtKRfSJaPj8k5aYWY3UCj1p2wsfnATK/zAsJ9tTPtqY9MtLrmKux/fyolPTLoIUcSriXnamAqJs9fMgw2bXNF+QafwMGu0UrQbqIoEWGM2+oQF0G5BlwTxlP23mt+sAZM98TAs+6i6RhaVTtJj5lDUVh2X9s5aO8vbmX5RzXrUOT11NeUUxDwKxJTZgQjYW7x++Kp6WfdxcbiPTDA1fM5qm8/2q8QTC5GojGPAMPthVEWCQdoTEe8NHtK3UHYeCJaQxFtUsw==
Received: from CY3P220CA0012.NAMP220.PROD.OUTLOOK.COM (2603:10b6:930:fb::12)
 by CH3PR12MB8074.namprd12.prod.outlook.com (2603:10b6:610:12b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Wed, 3 Jun 2026
 21:27:39 +0000
Received: from CY4PEPF0000EDD0.namprd03.prod.outlook.com
 (2603:10b6:930:fb:cafe::15) by CY3P220CA0012.outlook.office365.com
 (2603:10b6:930:fb::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.7 via Frontend Transport; Wed, 3
 Jun 2026 21:27:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000EDD0.mail.protection.outlook.com (10.167.241.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Wed, 3 Jun 2026 21:27:39 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 3 Jun
 2026 14:27:23 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 3 Jun
 2026 14:27:22 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Wed, 3 Jun 2026 14:27:22 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>, "Kevin
 Tian" <kevin.tian@intel.com>
CC: Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	"Shuah Khan" <shuah@kernel.org>, Pranjal Shrivastava <praan@google.com>, Kees
 Cook <kees@kernel.org>, Yi Liu <yi.l.liu@intel.com>, Eric Auger
	<eric.auger@redhat.com>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>
Subject: [PATCH v1 4/4] iommu/arm-smmu-v3: Process vIOMMU invalidations in batches
Date: Wed, 3 Jun 2026 14:26:56 -0700
Message-ID: <00748c5cbea95a938d032269001a598203b06bbc.1780521606.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1780521606.git.nicolinc@nvidia.com>
References: <cover.1780521606.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD0:EE_|CH3PR12MB8074:EE_
X-MS-Office365-Filtering-Correlation-Id: 15258bfa-5138-4836-d2dc-08dec1b6f06b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|82310400026|7416014|376014|3023799007|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	v6Aj6sz5iJUuhxIhYWRyLMude+nqnUP47ua5Xn6Jox9XeH2MUx33p76VsR3XGhPHn5eBqi5K4Ph3W70gxeP8skWneXXtYNq0/CqVrJEi4IYkpQxfkgVRxuwcJkZmPs0+sNwsRYEacPtmxffiKBj+tOSRf7yu2cNQYMHAdf9Jul/bZ2I2lnZnlpHJGpuY5BwhdfkggvgkCDwFsUTMQ6u42F+EbbLADyzGgl2OF55QzDLwzaFZEVn/kkbiLv+XyTz1db2s1AhHE5RmB0XrOVnTCcZ3wtDxdM3ypMKSXWUutUb766ve0r+dsl2NWM/939E2d5PlQnUA7mdbEhD1Tztwb3fr1PMu0QxDGRd8nyy2nqUiF4rORJWtYwV67tVtZn3VQsI3z9K0LfRnkzui7Lx2CdyUOrxOhSXBRiJ6CRjfaG52dNNs6U9bR6QfDGcP+7mayQ7kjPrOWOzoOGFF4FJrbiQ2swjgxbXaWwFPRgjvZsLRezaghn5h1nfAzxxTp4PQGKqYbI9F6rqDgi+HZVIyPsSvbNM1yj/fVFiH1HDTzGzLdQWCHCRpTrvtZXR+fguJ3uy1T6orWvrNLi1LlwxirR2vgrvGmx5xV68zXVTVsJZl8erESf+tfX6tUhtFYHcJghqXenkg5grfToVXNgeOVPGlcQ3oFVJtet3SHRkPSVLAJ2v1Sn1dp5r1Kxlhr5xNCkKtA2/CwEbcJcx7y2PKAH5oJ9pMI0DPRWWjKWk37zE=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(82310400026)(7416014)(376014)(3023799007)(22082099003)(18002099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	gmFMLfHYzEb0bvFU7U81nyCr2mKi6X5sKP2UhCSTigAS1bNEWzfvrNCLHVXf9n71FhWJfuX5OQ6YUdcOe2STZWx52yLZbec4m2Wo9ePQFmViIk04r8a9ENfYa7bIkrWAHtfR9owcq9VqiT7cSejmJSpWDLh4qb0Dj+okK5cUDyWLiZ1ABW5DDce6YxnyE0AUhqPnSfgsCIurK1v3RQuYtd9PCvnor0pNPIiZNOiXglZJLtkleW6iEZBrGJv3LBkgQ9tr0DOrfuhr2B6Md8YEQNlXuDCZq64FCj9GRScrZSDrIgTsVPeTZel4pKX7nXqvMnKKR0aa5jEZTPOfngsuouqCJUXyWMToibY2HhkxpgN4w7C6ddn9wp2IQJIxdJMWOjt17DVMvhwT5BUM0sNsu2VuCOXeLpgV9jgLCry1qLlUOGlgYTQ4ccqNmbfCWnRt
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 21:27:39.3702
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 15258bfa-5138-4836-d2dc-08dec1b6f06b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8074

arm_vsmmu_cache_invalidate() copies the entire user invalidation array into
one kernel allocation, then converts and submits those commands in batches
of CMDQ_BATCH_ENTRIES - 1. Sizing a single allocation from a user-supplied
count while tracking progress with a separate cursor is the root of several
independent problems:

 - entry_num, the in/out count of successfully handled requests, is set to
   "cur - cmds" on every error path. "cur" counts converted commands, not
   submitted ones, so a conversion or submission failure reports the unsent
   batch as handled, telling user space that invalidations which never made
   it to the hardware have completed.

 - The allocation is sized straight from the user's entry_num with no upper
   bound and no __GFP_ACCOUNT, letting a large request drive an oversized,
   unaccounted allocation and spam the page allocator.

 - The -ENOMEM path returns without touching entry_num, once more reporting
   the full input count as handled on a failure.

 - A zero-length array, which the uAPI defines as a probe for a data_type
   the kernel supports, reaches the full-array copy helper, which rejects
   zero entries, so a supported type fails exactly like an unsupported one.

Rework the function to process the array one batch at a time, copying up to
CMDQ_BATCH_ENTRIES - 1 entries into a fixed-size stack buffer, converting
them in place, and issuing the batch, which removes the user-sized buffer.
A refactor is preferred over a series of smaller fixes because the problems
above are symptoms of one structure; changing the structure removes them as
a class rather than patching each in place:

 - Dropping the allocation makes the size bound, the __GFP_ACCOUNT, and the
   -ENOMEM accounting question moot, not three separate fixes.
 - entry_num advances only as batches are issued, so the count it reports
   tracks submitted commands and needs no correction on the error paths.
 - The type is checked once up front, and an empty array then iterates zero
   times, so the probe case falls out for free.

Each batch is still copied in one bulk transfer via the full-array helper,
iommu_copy_struct_from_full_user_array(); the whole-array copy becomes one
copy per batch that the preceding helper fix keeps to a single bulk copy.

If converting an entry fails, the already-converted prefix of the batch is
issued before the error is returned; if that issue fails, the batch is not
counted. So entry_num stays tied only to commands that actually reached the
hardware, without dropping the valid ones that preceded the failure.

Fixes: d68beb276ba2 ("iommu/arm-smmu-v3: Support IOMMU_HWPT_INVALIDATE using a VIOMMU object")
Assisted-by: Codex:GPT-5
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 .../arm/arm-smmu-v3/arm-smmu-v3-iommufd.c     | 91 +++++++++++--------
 1 file changed, 55 insertions(+), 36 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
index ddae0b07c76b5..5574ccaecf381 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
@@ -350,53 +350,72 @@ static int arm_vsmmu_convert_user_cmd(struct arm_vsmmu *vsmmu,
 	return 0;
 }
 
-int arm_vsmmu_cache_invalidate(struct iommufd_viommu *viommu,
-			       struct iommu_user_data_array *array)
+static int arm_vsmmu_cache_invalidate_batch(struct arm_vsmmu *vsmmu,
+					    struct iommu_user_data_array *array,
+					    u32 *idx)
 {
-	struct arm_vsmmu *vsmmu = container_of(viommu, struct arm_vsmmu, core);
+	struct arm_vsmmu_invalidation_cmd cmds[CMDQ_BATCH_ENTRIES - 1];
 	struct arm_smmu_device *smmu = vsmmu->smmu;
-	struct arm_vsmmu_invalidation_cmd *last;
-	struct arm_vsmmu_invalidation_cmd *cmds;
-	struct arm_vsmmu_invalidation_cmd *cur;
-	struct arm_vsmmu_invalidation_cmd *end;
-	int ret;
-
-	cmds = kzalloc_objs(*cmds, array->entry_num);
-	if (!cmds)
-		return -ENOMEM;
-	cur = cmds;
-	end = cmds + array->entry_num;
+	struct iommu_user_data_array batch = {
+		.type = array->type,
+		.entry_len = array->entry_len,
+	};
+	unsigned int num, i;
+	int ret, issue_ret;
 
 	static_assert(sizeof(*cmds) == 2 * sizeof(u64));
+
+	/* Copy one batch of the user array in a single bulk copy */
+	num = min_t(u32, array->entry_num - *idx, ARRAY_SIZE(cmds));
+	batch.uptr = array->uptr + array->entry_len * *idx;
+	batch.entry_num = num;
 	ret = iommu_copy_struct_from_full_user_array(
-		cmds, sizeof(*cmds), array,
+		cmds, sizeof(*cmds), &batch,
 		IOMMU_VIOMMU_INVALIDATE_DATA_ARM_SMMUV3);
 	if (ret)
-		goto out;
-
-	last = cmds;
-	while (cur != end) {
-		ret = arm_vsmmu_convert_user_cmd(vsmmu, cur);
-		if (ret)
-			goto out;
-
-		/* FIXME work in blocks of CMDQ_BATCH_ENTRIES and copy each block? */
-		cur++;
-		if (cur != end && (cur - last) != CMDQ_BATCH_ENTRIES - 1)
-			continue;
+		return ret;
 
-		/* FIXME always uses the main cmdq rather than trying to group by type */
-		ret = arm_smmu_cmdq_issue_cmdlist(smmu, &smmu->cmdq, last->cmd,
-						  cur - last, true);
+	/* Convert in place; only the converted prefix may be issued */
+	for (i = 0; i < num; i++) {
+		ret = arm_vsmmu_convert_user_cmd(vsmmu, &cmds[i]);
 		if (ret) {
-			cur--;
-			goto out;
+			num = i;
+			break;
 		}
-		last = cur;
 	}
-out:
-	array->entry_num = cur - cmds;
-	kfree(cmds);
+	if (!num)
+		return ret;
+
+	/* FIXME always uses the main cmdq rather than trying to group by type */
+	issue_ret = arm_smmu_cmdq_issue_cmdlist(smmu, &smmu->cmdq, cmds->cmd,
+						num, true);
+	if (issue_ret)
+		return issue_ret;
+
+	*idx += num;
+	return ret;
+}
+
+int arm_vsmmu_cache_invalidate(struct iommufd_viommu *viommu,
+			       struct iommu_user_data_array *array)
+{
+	struct arm_vsmmu *vsmmu = container_of(viommu, struct arm_vsmmu, core);
+	u32 issued = 0;
+	int ret = 0;
+
+	if (array->type != IOMMU_VIOMMU_INVALIDATE_DATA_ARM_SMMUV3) {
+		array->entry_num = 0;
+		return -EINVAL;
+	}
+
+	while (issued != array->entry_num) {
+		/* Process and issue the command(s) in batch */
+		ret = arm_vsmmu_cache_invalidate_batch(vsmmu, array, &issued);
+		if (ret)
+			break;
+	}
+
+	array->entry_num = issued;
 	return ret;
 }
 
-- 
2.43.0

