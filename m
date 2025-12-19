Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011070.outbound.protection.outlook.com [40.93.194.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6EBF33E37D
	for <iommu@lists.linux.dev>; Fri, 19 Dec 2025 20:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766175158; cv=fail; b=p/pFjDGWLGdYCHcRnyQ4j5DNfeSF1jp4CYXQbNSPGnXNTOG0Vn7TlHTsf3uuGxjl6V2hwEWaKL8NcWvkAuTvXyZTY2ujcg/Z/pqgA5jNnRAC1Hy/8ld+i2hU23nk8qwo54kBzXFHLlJn/z+JCv4AMwxncitVJnUy5mcGzR9kD7I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766175158; c=relaxed/simple;
	bh=x0lJyIjZvhE6XUe+SUJ9QSyRNWgikvNOzU1d+N142/Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KUeCekc7FTEVHX8wTVNBN9TxPsy5UYEp4UGCL2l06w7inGdsigtAOHKpuFBkp/pwsrtjFL4P6/IDuKuSmJaFL+wTJrN0E9KSRvSxd1FnmyIEsM12d3LKbvEeIf2fTDglYsnH7hJ7a3LWavuIOOy9jmcu6mb3oHNicfmQwRfCUWw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KzCGXpHm; arc=fail smtp.client-ip=40.93.194.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KzCGXpHm"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gI4Gdq6zu+o3LwXZjv3MgBypU2wih6Eiwze6XISr+fBQJKbOkyOaGNcmlLNBL2fp/Zh7bxjGoNwStD21nkAu/JWkB6BjgOxxCV3bT3L37NdbtMkyB6UAeHGdn6cQOgEk5GfoLdSlvooIF0yOzLVbgUYVMSKH5lDHpTP8yCDVD2ThZrZuBM4ys0saI1L7DC3H+XTgc9uPXP9rVziaocWGPwMEFWFMUunz54Po7fur1hYwVD3Urq/2KB5BeVouEembTpGmGhSW8hd7K1HEGc/e7kVr8Ow5bvqFVn3t+xJGyEpgK1g/DhYnq4xm9P0+qhA0OEwKKoq41WJvpKWAG0bWKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PGaBx+a+bo+0k46REkl6gOsGSESYdAY/iH34Eh+cNtY=;
 b=V3CQlD3m5QDRWegXUVMcbqczz1jEyXdPbLuRD7L2VaEJHODB0AmznlJFRh9S/tMPaKEz1QpmmvF2T+3HactUp+1Vnbq4QvaaFfvHDhY08P6F1U4gzlJIDfVFic13UH5ozjeP1mICZHKI0scbIV+vVg2tDBTQw7xfXJ4keAsBzr7pEYxsYfe8YucqfYTG7VoUQ8p2npSdlyvdxdnFTt62VusIH+NfhR4V0nJ8K1pHIUBrOKOy10sKZaig50vFfom4uYoJEvVc9nsXl3njf0lsXqlH1pmaTp68HTqCp9ruRZcfc0EUUpsSKDrGCqYdbzUIqGPtqI6hxSw1pzbHywXACA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PGaBx+a+bo+0k46REkl6gOsGSESYdAY/iH34Eh+cNtY=;
 b=KzCGXpHmMpOfsqnv1XOEVmeV3v36AwGbncC3EGEYuLjDDo3l+y0wDfiNw16TxckaGXwPEz7uH9qXI734lAPjyNylgBpviIdRtkoKE6YTBk/JIWARn01bePWs6SjDYYsh2EHgxmgLNJFLDW8ij2FcSJ+SpBsQt5NgMwzjs2Y6kynAvZ1Tfujg/YY/1nQ+G0z6VfM8zUSK2kEmq3cO+vdGaZEE7gggXhrYg8LnXHS71Ied1gn7t1NTJkqAdwoQmgDFqRo3lGn3RpELib9VjOWM6nbayB4iiFZV++rlITjz1rhIGEL+3WlLF2I2MwBQPT3KSmSCDmsi7Nu6y9xWoMAs6A==
Received: from BYAPR08CA0019.namprd08.prod.outlook.com (2603:10b6:a03:100::32)
 by LV9PR12MB9783.namprd12.prod.outlook.com (2603:10b6:408:2e8::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.8; Fri, 19 Dec
 2025 20:12:31 +0000
Received: from SJ1PEPF000026C3.namprd04.prod.outlook.com
 (2603:10b6:a03:100:cafe::83) by BYAPR08CA0019.outlook.office365.com
 (2603:10b6:a03:100::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.9 via Frontend Transport; Fri,
 19 Dec 2025 20:12:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF000026C3.mail.protection.outlook.com (10.167.244.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.6 via Frontend Transport; Fri, 19 Dec 2025 20:12:31 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 19 Dec
 2025 12:12:13 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 19 Dec
 2025 12:12:12 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Fri, 19 Dec 2025 12:12:12 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>
CC: <jean-philippe@linaro.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<jgg@nvidia.com>, <balbirs@nvidia.com>, <miko.lenczewski@arm.com>,
	<peterz@infradead.org>, <kevin.tian@intel.com>, <praan@google.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v9 4/7] iommu/arm-smmu-v3: Pre-allocate a per-master invalidation array
Date: Fri, 19 Dec 2025 12:11:26 -0800
Message-ID: <d6565a84698d93d6a2842b32bed492f87179af5e.1766174731.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1766174731.git.nicolinc@nvidia.com>
References: <cover.1766174731.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C3:EE_|LV9PR12MB9783:EE_
X-MS-Office365-Filtering-Correlation-Id: a35b1262-86d3-4d4e-61dd-08de3f3af0a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?U5O7GUYfO6CguJY4AEslDRKH2EyTn7dtBJzoi800N3rxbLsmr2i4R1vchDaN?=
 =?us-ascii?Q?fQCQt/A54vTAB/IF6q0vUCm6Mvz7aiD0a0e2sJjLnCTBQCdkkps7YxgIx1Ef?=
 =?us-ascii?Q?4IsRceOlm1lL16AgZ4sEBX4GWXtXLufcM4K7RFdK44Hw/9eiLrlDgEPtJIdq?=
 =?us-ascii?Q?v74t4sKIxfItCUV50JHtFhU2/fsCvuY3RkkGyrHtpKJvsxldP1TfUX5CHKXn?=
 =?us-ascii?Q?3EBkjk9p6eG3JRJ7F05VVuas9jfLOFljO5so2nEtX7MAhYbJA0A3wfVr31t4?=
 =?us-ascii?Q?XzEh7aubu8vCmirTSp3JWX9BAZMwwvKuEQU8sG1ZJ1go6oMDmABzuPGZuK+G?=
 =?us-ascii?Q?RfD/tqV63R87xjirBEk1Q1U0IWOSm17EflO4KBvzgeSJ8NhQhB75t22GQq+4?=
 =?us-ascii?Q?HAUtgTeam9Ve0mltwbuclK0Fzox1Dhk8U9VclY/SmvEY34yPf057SnDzOc2+?=
 =?us-ascii?Q?FDJPXkqrUzk7VqLtBjzqojE0iIEiIYvRFzxRMKYlQ02cyUmUr6GFEvXoBRev?=
 =?us-ascii?Q?x3FZFJ2PujETQ/ex8I2OHsYL/T6oK7xJUMNxehpTtNaFB+eDXDzi4LhuX4so?=
 =?us-ascii?Q?WP8fw4Klcguj/7a5CHWmZj5glqERZp05sUGMlZ9Vd0j0b8bQlMWndFF1GJZG?=
 =?us-ascii?Q?bKrvbJJmMAwOXNJ5PF7XLK9cYvGQzKRU905+HUFW6T2WwCrfmuyrexydHTut?=
 =?us-ascii?Q?G4wgWs6VAgBoWKM4vE18M7SVD+dR9DaudtaBiwT+qidEDut8H3jbUVFgdS2y?=
 =?us-ascii?Q?ajAlmWuj/+N3WhPQvCE6em9PHtCeoCseU8Kea56X9fENYUan/DUa1RMy7L3H?=
 =?us-ascii?Q?+2/nZHZypZmwmjWPwVc3JGGKfCgU8vw+DlsXs87CvFtkITRohZ+6RwDEPf5S?=
 =?us-ascii?Q?BfznfApwBQyFGL/I1mc9+eau2Ysb+ssg9f7YDi/343je9WkalsM8vfmoa5Ds?=
 =?us-ascii?Q?AaZ9Zk1q+9HWiGKsUeO/OWw4p0dhGb3cjeFNqLnX+JeCYGFdKYB3FgM/RlcP?=
 =?us-ascii?Q?L5TrOooMuCDIlDh76J8cL/CAueqY5TVv6wUpy7DTgm80Qp/f92ioJYFNZIfz?=
 =?us-ascii?Q?/JaJnb1kXpJGpUrlwN9LaS+p+68CZFglETXUG56gsGzsprNWCkY0WOg80wZa?=
 =?us-ascii?Q?OyUh6G1IBMYhO0ZOgAzZR8jErRmhB/lz3mVEtcuuefh11RVeSaFf0hB0vxu9?=
 =?us-ascii?Q?9i3+Kfqb1J/ZWfKV1zDdUorhGPFEXAFzeNLQhXpJjwVnreB7BOzO+1PpX/GL?=
 =?us-ascii?Q?x3q86uD2sdtM3TzbNwcxBSJzBH8zao/oycAIk7lXSqXKA/UdFaGV7+ZmTtby?=
 =?us-ascii?Q?XijB1IExCcPGjGlx5gZiuxh5zRVErONjibRLo+k7onDghmNDVFYBSild3gLh?=
 =?us-ascii?Q?YcqkQZg0mdR0PmhMbLmQY/xb14qNCYcurPEgXWtz0l8//9PgfQrmzlNaVaiK?=
 =?us-ascii?Q?QPJY0e5lhWjCVV/RIJzWB44ciQVlnhOsi+e9z+BslVRgdNt7NX7VpxbrsfXl?=
 =?us-ascii?Q?2BEiETDXUa9IR5bKz8wK2CurjMX/gPJpWz0SO3Sx1QVILOYA6AZtTpHi+/9L?=
 =?us-ascii?Q?v1f+3WgtDOkMnbKS9CU=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2025 20:12:31.0035
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a35b1262-86d3-4d4e-61dd-08de3f3af0a8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000026C3.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV9PR12MB9783

When a master is attached from an old domain to a new domain, it needs to
build an invalidation array to delete and add the array entries from/onto
the invalidation arrays of those two domains, passed via the to_merge and
to_unref arguments into arm_smmu_invs_merge/unref() respectively.

Since the master->num_streams might differ across masters, a memory would
have to be allocated when building an to_merge/to_unref array which might
fail with -ENOMEM.

On the other hand, an attachment to arm_smmu_blocked_domain must not fail
so it's the best to avoid any memory allocation in that path.

Pre-allocate a fixed size invalidation array for every master. This array
will be used as a scratch to fill dynamically when building a to_merge or
to_unref invs array. Sort fwspec->ids in an ascending order to fit to the
arm_smmu_invs_merge() function.

Co-developed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  8 ++++
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 41 +++++++++++++++++++--
 2 files changed, 45 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index a9441dc9070e..f98774962012 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -930,6 +930,14 @@ struct arm_smmu_master {
 	struct arm_smmu_device		*smmu;
 	struct device			*dev;
 	struct arm_smmu_stream		*streams;
+	/*
+	 * Scratch memory for a to_merge or to_unref array to build a per-domain
+	 * invalidation array. It'll be pre-allocated with enough enries for all
+	 * possible build scenarios. It can be used by only one caller at a time
+	 * until the arm_smmu_invs_merge/unref() finishes. Must be locked by the
+	 * iommu_group mutex.
+	 */
+	struct arm_smmu_invs		*build_invs;
 	struct arm_smmu_vmaster		*vmaster; /* use smmu->streams_mutex */
 	/* Locked by the iommu core using the group mutex */
 	struct arm_smmu_ctx_desc_cfg	cd_table;
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 39e89176fa87..cc85e7a10ea8 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -3709,12 +3709,22 @@ static int arm_smmu_init_sid_strtab(struct arm_smmu_device *smmu, u32 sid)
 	return 0;
 }
 
+static int arm_smmu_stream_id_cmp(const void *_l, const void *_r)
+{
+	const typeof_member(struct arm_smmu_stream, id) *l = _l;
+	const typeof_member(struct arm_smmu_stream, id) *r = _r;
+
+	return cmp_int(*l, *r);
+}
+
 static int arm_smmu_insert_master(struct arm_smmu_device *smmu,
 				  struct arm_smmu_master *master)
 {
 	int i;
 	int ret = 0;
 	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(master->dev);
+	bool ats_supported = dev_is_pci(master->dev) &&
+			     pci_ats_supported(to_pci_dev(master->dev));
 
 	master->streams = kcalloc(fwspec->num_ids, sizeof(*master->streams),
 				  GFP_KERNEL);
@@ -3722,14 +3732,35 @@ static int arm_smmu_insert_master(struct arm_smmu_device *smmu,
 		return -ENOMEM;
 	master->num_streams = fwspec->num_ids;
 
-	mutex_lock(&smmu->streams_mutex);
+	if (!ats_supported) {
+		/* Base case has 1 ASID entry or maximum 2 VMID entries */
+		master->build_invs = arm_smmu_invs_alloc(2);
+	} else {
+		/* ATS case adds num_ids of entries, on top of the base case */
+		master->build_invs = arm_smmu_invs_alloc(2 + fwspec->num_ids);
+	}
+	if (!master->build_invs) {
+		kfree(master->streams);
+		return -ENOMEM;
+	}
+
 	for (i = 0; i < fwspec->num_ids; i++) {
 		struct arm_smmu_stream *new_stream = &master->streams[i];
-		struct rb_node *existing;
-		u32 sid = fwspec->ids[i];
 
-		new_stream->id = sid;
+		new_stream->id = fwspec->ids[i];
 		new_stream->master = master;
+	}
+
+	/* Put the ids into order for sorted to_merge/to_unref arrays */
+	sort_nonatomic(master->streams, master->num_streams,
+		       sizeof(master->streams[0]), arm_smmu_stream_id_cmp,
+		       NULL);
+
+	mutex_lock(&smmu->streams_mutex);
+	for (i = 0; i < fwspec->num_ids; i++) {
+		struct arm_smmu_stream *new_stream = &master->streams[i];
+		struct rb_node *existing;
+		u32 sid = new_stream->id;
 
 		ret = arm_smmu_init_sid_strtab(smmu, sid);
 		if (ret)
@@ -3759,6 +3790,7 @@ static int arm_smmu_insert_master(struct arm_smmu_device *smmu,
 		for (i--; i >= 0; i--)
 			rb_erase(&master->streams[i].node, &smmu->streams);
 		kfree(master->streams);
+		kfree(master->build_invs);
 	}
 	mutex_unlock(&smmu->streams_mutex);
 
@@ -3780,6 +3812,7 @@ static void arm_smmu_remove_master(struct arm_smmu_master *master)
 	mutex_unlock(&smmu->streams_mutex);
 
 	kfree(master->streams);
+	kfree(master->build_invs);
 }
 
 static struct iommu_device *arm_smmu_probe_device(struct device *dev)
-- 
2.43.0

