Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011066.outbound.protection.outlook.com [40.93.194.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85837395261
	for <iommu@lists.linux.dev>; Tue, 17 Mar 2026 07:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773734399; cv=fail; b=Xa+7MPGDQEg+maCQkej8QrhqUXZbqImcLGDmFkK4sfXRH9OoAnuset0X02x4kzELV/gWmnxM37Jd5G+N68a7pZ1ZyjwW2CMS6KaQyDTjLreM4H3Cvug8q5KTpwwx/e8RjMmYMvb5t93RZ7lFD7k838rqF1qLleAxsErad33lAYI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773734399; c=relaxed/simple;
	bh=PAHdOZ+eGqnaQMGepqt86Ej0oIY2qF21u2KlH2sZIfE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=vC3X1axlhOxc50L03UbcKiU7bGR8NvMPX/AwvoqioFg49rCqa0wM9OKOKvygM7A0ChKeixc7NW95tcOGV6J3qnYMxx2H7EEfivob7kuxWWuZUyhIFqUKgm7By8m6xNDLKTyJpxklyMPA87E8MSluE+Z3nW8TwQrbQbwHJSIJfCA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=aAf7ieqE; arc=fail smtp.client-ip=40.93.194.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="aAf7ieqE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NyWML6Ckx1Ul3aRDlVqFkIb47smlvaK4xpst+Pl+0X8SaFb1jusHYP+gRVwjEhpGgfbDRisVCipjEeweU0xyZHKbSQvPWALySQByVm/KxkGZ46UgqGHaaQD3TpM6c8kwDTJsjzBMXPaAiefMQZiVn8bFF7w/uZzv0EZdYky5hxWcPF4+NHpaMqGfbp5E0c0lvY97TDr52GeNbQq++h2iGtCTVojAYLHfgTzSAG4C6odIogUOZNRXjbj+6fkn7MsXfrTy3owIYiYw2Iq1JFWuygaa2pGoE876vhCOFT1BPNdYsFXXwdVuu9rQ/WrDK4BaY6HT7AC8FL1tFxoiyXUDEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oc+cv5gi2Q9w0ejtzR2MU/wcIaCMLfMzagLkeLa20Zw=;
 b=NXtVxDfD6LqDeDd9BUy09hLzHAe5glLQ9l+cAGoBZgkPsVQgAlBAI/JGI4seM5u8KauRlYTnRZHW53cTY7CmDc/ewnSH8aqLclH4/6HtzF31cIdf6T6BMXzAu0z9wI23CZEqKVlpQNnLPDnJhyVsAQaVcP2aTj4YJ+o0KyqgqgOU3VyZdKaZRRUH/jX1bYemmiWFxYeVKwcmtOitjNPRS8CHQbQXV7bt2rZh3ytFOymAsiKtCk32L0j84a5dTJXoTjgv72u6c7DghM/t9VytMC9dfsKG58TqExfJ8j0cbQplQ9b2KPS3+dVw5NK/kAcocFe25FaQ6vwEOziEEeqH7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oc+cv5gi2Q9w0ejtzR2MU/wcIaCMLfMzagLkeLa20Zw=;
 b=aAf7ieqEjs6eXp3bbzkAi/oMN+5gHbKuWGrdBC6T+MHjHowC770tPF0lrgfrH9Hf88D1sR9E2wp/HHHlbtpRrPr2cHQHlSAdX5oF/ifhzOzQShZmJEozTeI60liMTG4dr5iW3pzjtVYWFfVSiJK16EwW3ezqFsoliZBcr2BoMU9zlmfllgEpFmNFPW3Ju7q35iiJoQW1MjQNyFrUg/IGHQ+ZT91bdcb5KtbCsgc2EboDUSlSI/+i+zY/i3kOvL/Egw2gDXsB1dzC4MvTgLPhAVA/K7sILIxdUK4NoNOEhopWICdsEh5Zk8SORe+GG7Ro8R4bs+5SrqxmobZWS/kzzg==
Received: from DS7PR06CA0053.namprd06.prod.outlook.com (2603:10b6:8:54::8) by
 CYXPR12MB9444.namprd12.prod.outlook.com (2603:10b6:930:d6::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19; Tue, 17 Mar 2026 07:59:51 +0000
Received: from DS1PEPF0001709D.namprd05.prod.outlook.com
 (2603:10b6:8:54:cafe::1d) by DS7PR06CA0053.outlook.office365.com
 (2603:10b6:8:54::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.27 via Frontend Transport; Tue,
 17 Mar 2026 07:59:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS1PEPF0001709D.mail.protection.outlook.com (10.167.18.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Tue, 17 Mar 2026 07:59:51 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 17 Mar
 2026 00:59:38 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 17 Mar
 2026 00:59:37 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Tue, 17 Mar 2026 00:59:36 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>
CC: <jpb@kernel.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<jgg@nvidia.com>, <balbirs@nvidia.com>, <catalin.marinas@arm.com>,
	<praan@google.com>, <miko.lenczewski@arm.com>, <smostafa@google.com>,
	<xueshuai@linux.alibaba.com>, <baolu.lu@linux.intel.com>,
	<kevin.tian@intel.com>, <mshavit@google.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <peterz@infradead.org>
Subject: [PATCH v13 5/8] iommu/arm-smmu-v3: Pre-allocate a per-master invalidation array
Date: Tue, 17 Mar 2026 00:59:20 -0700
Message-ID: <77de6296929aebf356bdd83b92b973b50e40a175.1773733797.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1773733797.git.nicolinc@nvidia.com>
References: <cover.1773733797.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709D:EE_|CYXPR12MB9444:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c9f7578-929d-4b4b-9287-08de83fb2b00
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|7416014|376014|1800799024|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	W9Zjme5701OUG8TEtCnRUxcRermTr8m4aWJ0LFBFMdqvhPurGr35umcm1SxudXx3b40DE67qB+H0USVRez+v9cSiG72ooMK5+yBdP51v5uVwjc7M/gObtugbpX832aX4xq6MrJBPIPApsHi35nWfduZcCjhzCYaQDR7sEefs4gcwn+wHK0Xmbylp8ignPTZthrDW1Y1fw+EhOnemQ/eW+Coqo7VZSxzuiZforoBCnjakYZzemoMI30sn2XaLVjt/t5j5SoRT4bwv1blEWxc4oeb5EMwF9B0C5UxEUQAJb07+go3kv551t9yTdl8YssQeo9fG0y3PIpYoQc7dkSAEuikRiMUc3tBZtf2XsSdOOijlKKndDwt7x7YGls/IEBXK+TfHAgTg/YlzZs72hoyPwprcSlkXryBoGVi6EeFLkVYsJ+rk8aD0MhJvQcYe9Tsf350/uVgsofAVSVxquLChyeoIfTbZ9l25r4sXtWJ1j0B+R2Zy/DvEQw+IFWxcZgL+nC9jlXpOsOcmi52KfCQbIx7PD15iZXo3j/OeU4bLQ3HSO6Il50SKPQczreMh3aX+E6P5/orl4eDhS3WdqrqM5HthlCBENdsQyINXK7UvhWbjEsWEAcLJwlhUuZvYE2jFqPutXhSeIsW2J7P4FSfuQ7XckbiXIadkw3Qmaqo7dPnyv8x8lavregBjRmmUed1P8QE7gKUILFMXYJCV6CIj7RYAoJiXYBSQ8SO0A3Ql/Tsky8hzRl3dDiz39Rt8JCjU3+rC1SfVtfi9yK2x/qCXSw==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(7416014)(376014)(1800799024)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	pvkZOr/YViYgAJvPwvO0vYFYSvD9CVUcrdZ0Ti1kIL7XaJHaS3lFN34zCWFQ6ZHJYfl022uVy/EbTgGHWNReA3v8p/9hv0+FSFAkCYUBRm9rugwsIDh12nD9TPGOImTKvcPKnX5f2yNU8JfIPjFfkRsSSkwv4j83b2OwsponfSIJ0cw6sP1u7l/b6mNFgT4B5TdMVYFVJak9myNGacBlCYwkxv5+N4PMpXRd45GgttUbzZWqN4ku1hmFdy6NuJcyFA+vIxfU19Ft/14dftSIxUfwBloJAN4G/rAhseo6gVkaff8ZzhqON7yG/F/TS5QKJrOXs9uRriafQUeFzgox2/PW7hSeHhetSIZbArclBVP+I2fcj9/6fqBqQ4O48sa4GE7HOKRwD5rigv4IdDkYQyMjibty0Wqm/GKGGF87GeigmySygKyPKIfEkOWBp7Yv
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 07:59:51.3213
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c9f7578-929d-4b4b-9287-08de83fb2b00
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF0001709D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9444

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
Reviewed-by: Pranjal Shrivastava <praan@google.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  8 ++++
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 41 +++++++++++++++++++--
 2 files changed, 45 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index ed8820f12ba32..5e0e5055af1eb 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -928,6 +928,14 @@ struct arm_smmu_master {
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
index 10050b1a6d945..8e651cf6b86ee 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -3789,26 +3789,57 @@ static int arm_smmu_init_sid_strtab(struct arm_smmu_device *smmu, u32 sid)
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
 
 	master->streams = kzalloc_objs(*master->streams, fwspec->num_ids);
 	if (!master->streams)
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
@@ -3838,6 +3869,7 @@ static int arm_smmu_insert_master(struct arm_smmu_device *smmu,
 		for (i--; i >= 0; i--)
 			rb_erase(&master->streams[i].node, &smmu->streams);
 		kfree(master->streams);
+		kfree(master->build_invs);
 	}
 	mutex_unlock(&smmu->streams_mutex);
 
@@ -3859,6 +3891,7 @@ static void arm_smmu_remove_master(struct arm_smmu_master *master)
 	mutex_unlock(&smmu->streams_mutex);
 
 	kfree(master->streams);
+	kfree(master->build_invs);
 }
 
 static struct iommu_device *arm_smmu_probe_device(struct device *dev)
-- 
2.43.0

