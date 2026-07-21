Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010052.outbound.protection.outlook.com [52.101.46.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3727430CDC
	for <iommu@lists.linux.dev>; Tue, 21 Jul 2026 19:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784663360; cv=fail; b=Dh3mkdg0SrDR1/ada1bGHXcHup4b6vyuAz8og+xgwHwB2jh+kKjUaJVeyOYUgApB47ulFd1y7NftDe9AWFTVSzPNxIT90Wl4cOb9Fub+BmrwFjZ0/LwTVd5Kil7+p16FtXOgDsUBjgGCYvrDmqxu2hLpzsISN7f49wKO+uWLhow=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784663360; c=relaxed/simple;
	bh=kPDydixpSkpAqhIfk0ShAc5jTd5/fVQ5Hd2kVGVL228=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kYefxKmVPdrKRW4gs1L8a5mjnjmT1M/sil3QY4tC2/Z2CdmFUw0rNqXKxtUHmYENBU3k1HEf/PqPugUuh9wgxbvvNzyYhbKcQ1GKZ/Egn2Ae2wTxg2B+Aghx4OmutSeWqS8lqfDwcdFkfbGCrqx1CXYN4vXsxH3U0jovV0bZ34U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Vk3RsjNZ; arc=fail smtp.client-ip=52.101.46.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Vk3RsjNZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ie5ObF5Rid57RKdO5h2H5xLHpGg6N/4lEEFa/Su8gOAs4vKeq0xxjAmtvqdEj/PlZ5Ea7Mc3Pq1ZbPHoW+lvsYXoJHN2l1Eg6oKTWTLak38JIPo8FPN4xNt4k7meJjr3EWUxy4kXNQRFWTlFrvoA0cwMd32FxYc0FgAPXd1lCAUsRKfBY0bXQulxMXK7NLdK0OUtnFkyvCWRD5as46jQRPDcFQGe7Qwg3IFfBvMBxneAU0CVSBba7bGOuSDsXCZWP3Jy+W+kygyOnqqeTW0ahHGiVwNw/hR/IrHJetAnBaqJB5/5rn8IEq+D2KWyHZWuaF8WMUz2Alo1xtzgJ013NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RuSRKrfgYqJkyN0UJbZ3icPKwC/5GQZhFz848vY+zlA=;
 b=QS2rqGMBOAYMRvd6X2gMWLWjNIWxn4Tsk8e/ZV1QDZszZiDIWL81WHYhONhs8q1IpoovsDUX8aWpbs3Z1SXnGXCDbmgh+3aVRgoCPG9TcNdLilWyhCJoIJqjOYRsTPk2vLgd+lyyDsH6lyxazm02Vuj2aPEdTzxG8dBEd7DXElEilTWh+8wdaLzZeG8EpltMMSMz2brrTXQUPF17l90aO4YlfNe0vus4AuEz07b8UJIX8fH4eIC+LMYCgJVoF8qvW0YbshGMRrAYbTAZ18anmhIbV1/fu6mdYpvetBBXDiYKD+9+kc/0FrZ/bG9QJ1WtKmnP+8KYaJVFbDbYZ1GtcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RuSRKrfgYqJkyN0UJbZ3icPKwC/5GQZhFz848vY+zlA=;
 b=Vk3RsjNZPevKvY1bCXAxMD5Kv5DzPS3Mdp0Co5napfNNc/qcZ8gIzCkdKMNne4jPAUcPLaQAP0kfIf/Ore8IATnkI5O0SLP6FYDSiASuyzhCT995i2c8i3IwkM3CJQLCsxAtTWLd1H75tuk1BpoN4ATbfB1x0lO6CDijQO67xs1FX3d8ljYEWgWWlR3CgFh+5ifYLDpBQwUS+2ORzDswmPIH5c9sMOYPmLMRJfydj8+g06+vrMaboO37ikVWFTKF+Rmz8RQaKWDZEO1ySr2mn5hYXBlsBpB0KUGxpWQWhetQ9WKQnOTYqQ7miUgTIqNxgLK15aiFXxd4IkjoFbwCWw==
Received: from BY1P220CA0020.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:5c3::7)
 by SA5PPFE494AA682.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8e7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Tue, 21 Jul
 2026 19:49:08 +0000
Received: from SJ1PEPF000023D9.namprd21.prod.outlook.com
 (2603:10b6:a03:5c3:cafe::64) by BY1P220CA0020.outlook.office365.com
 (2603:10b6:a03:5c3::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.10 via Frontend Transport; Tue,
 21 Jul 2026 19:49:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF000023D9.mail.protection.outlook.com (10.167.244.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.0 via Frontend Transport; Tue, 21 Jul 2026 19:49:07 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 21 Jul
 2026 12:48:43 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 21 Jul
 2026 12:48:42 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Tue, 21 Jul 2026 12:48:42 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>, <robin.murphy@arm.com>, <jgg@nvidia.com>
CC: <joro@8bytes.org>, <praan@google.com>, <kevin.tian@intel.com>,
	<smostafa@google.com>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>, <jamien@nvidia.com>
Subject: [PATCH v9 08/12] iommu/arm-smmu-v3-kdump: Reserve crashed kernel's ASIDs and VMIDs
Date: Tue, 21 Jul 2026 12:48:17 -0700
Message-ID: <28a26f13a91bf26a7b8215a0bea493627cd9c832.1784663184.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1784663183.git.nicolinc@nvidia.com>
References: <cover.1784663183.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D9:EE_|SA5PPFE494AA682:EE_
X-MS-Office365-Filtering-Correlation-Id: 99af9240-6b06-489b-87a3-08dee7612098
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|82310400026|1800799024|376014|36860700016|10067099003|3023799007|6133799003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	gF1Yu9U45Z2c7Bjt2r+lnyR5tn0hcn8bcvLcRuNeOly6qNMbmTHHcmHoZiznv/Fb4E79Q6T05DQU8swXPCyBVo3/bsUb90yNo8voEyQZKS7yDsGM2IH5HxFK54bcLIZQu1Ivs6lova+z09n5A9Mo2YezxBENvtDgUt9rDnMOAKteOivp7zQ5PUHxTwvPyv5f8Pc7oUFh+EXb8i7Xbh32x+Rg8bHYlY+sLh8AmC8U9FT+pb3dLow8ZhST5p8oeMQ5laTDpfQOdk1nIQIk9dBg4wM/SqTbVNBHF2uMrIRDZs3qF8Q8CkPmS1uWlxBHEQT2bZR6AqxzUR2j/92KqNTLOnhC8nAYeZmgHmfXJzSuci7TAeH4DK95lapT/018Z2OsS5h3D4Xe8D1XMu1KsBBmOHP7OjBHTPvdeZhOQclol3qpzGMHnvHhBPNFXIC0LcMTRgaNpGTDtMUNBHhHqmjtNPBJApdH21YuG3jAwIISej37qRSf7R+pkTIj6yKrqEQN0o9hPqsLOD68C5eSri+v6d1YvYvXbWnIOJrAiBtbfYQUFpV9fTjvT3anxlGxJ/sDqSF59qPKmhXclf0aDnfe6z3SXbkAqdgp/eZBPNPjhy7zypp10wAmIpASCJTF6usc03PuB5jR8PBmnAZG1c5tevxS8IK0iu/IbIBLMnbw+s90cK8GFFQxkba7UNZ39IRU1kCX6lZg//37Vzy1XdI4xA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(82310400026)(1800799024)(376014)(36860700016)(10067099003)(3023799007)(6133799003)(11063799006)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	vC86OmV6jJshgXYCQFfVAcGeBQEL3kT9RGtt7HT6hgyfu9/Hj63VKGGy9G7dn/mwyMz4gcaPG+cqKcgzJitwQL8CFl65G+M2JX9u0B3c//mDGJ40ftpEaPvVckJoDOJm7es8AAiOANlx5QsoFeXXqmRLtGBUFik+SPal3EG9gU7AxpAuApj6o7niLBc54UeBVenz7pKSX+IXN0rjLMWEOuJAHJ621dvoNDVKo8l4RTLZlymrvInWqJtbd2O9Qq6S3edYSPezXBRqWNHWR1S4gOTSR60bHxA5wuYceQ9/jUPAWKWhXGXC5V0HCU7k7E0mKDCXRFBH6m3lOgvFXnu/ljtXJ9CEI0VZ0/ETWLyi/AL+h9uDAu65WMHj4Zw7mTvBlOocPmVT+iY6Ip6HUgieKpk+kbUK0gGs1UvQLfaYvnori1eOuhGUV4p/Eczjy0Ey
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2026 19:49:07.6636
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 99af9240-6b06-489b-87a3-08dee7612098
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D9.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPFE494AA682

The adopted stream table keeps translating in-flight DMA, so the SMMU keeps
caching TLB entries tagged with the crashed kernel's ASIDs and VMIDs. If
this kernel handed one of those IDs to its own domain, the new domain's DMA
could hit the crashed kernel's cached translations, e.g. a stale entry left
behind by an invalidation that the crash cut short.

Scan the adopted stream table at adoption time, reserving every ID in use
via arm_smmu_kexec_scan_and_resv_ids(), under the arm_smmu_kexec_resv_lock
so that a failing scan can atomically roll back all of its reservations
via arm_smmu_kexec_unresv_ids().

Nested STE's guest-owned CD table is in IPA space and left alone: its ASIDs
only pair with the nonzero S2VMID being reserved, so they cannot alias this
kernel's VMID-0 or EL2 stage-1 domains.

Note that, on an E2H/VHE host, the kernel's stage-1 domains are tagged by
the EL2 ASID, and the TLBI_EL2_* commands take no VMID. So isolating this
kernel by a reserved VMID alone would not work. Reserving the ASIDs covers
both the E2H and the NSEL1 cases.

Reservations are never released: a kdump kernel reboots after it saves the
vmcore, and the full-reset fallback flushes the entire TLB, which turns any
stale reservation into a merely unused ID.

If the scan finds any inconsistent structure, toss the entire adoption and
fall back to the full reset.

Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Assisted-by: Claude:claude-fable-5
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-kdump.c | 15 ++++++++++++++-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c       |  1 +
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-kdump.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-kdump.c
index a074d59ce3445..3e0d544c6bc53 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-kdump.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-kdump.c
@@ -205,16 +205,29 @@ int arm_smmu_kdump_adopt_strtab(struct arm_smmu_device *smmu)
 		goto err;
 	}
 
+	mutex_lock(&arm_smmu_kexec_resv_lock);
+	ret = arm_smmu_kexec_scan_and_resv_ids(smmu);
+	if (ret) {
+		dev_warn(smmu->dev, "failed to reserve in-use ASIDs/VMIDs\n");
+		arm_smmu_kdump_adopt_cleanup(smmu);
+		goto err_unresv;
+	}
+
 	ret = devm_add_action_or_reset(smmu->dev, arm_smmu_kdump_adopt_cleanup,
 				       smmu);
 	/* devm_add_action_or_reset ran the cleanup upon failure */
 	if (ret) {
 		dev_warn(smmu->dev, "failed to set up cleanup action\n");
-		goto err;
+		goto err_unresv;
 	}
+	mutex_unlock(&arm_smmu_kexec_resv_lock);
 
 	return 0;
 
+err_unresv:
+	/* The full reset will flush the entire TLB, so release everything */
+	arm_smmu_kexec_unresv_ids(smmu);
+	mutex_unlock(&arm_smmu_kexec_resv_lock);
 err:
 	dev_warn(smmu->dev, "falling back to full reset\n");
 	/*
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index b768080c04db4..9d9fd11d26efa 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -4516,6 +4516,7 @@ static int arm_smmu_init_strtab(struct arm_smmu_device *smmu)
 {
 	int ret;
 
+	/* Init first, as a kdump adoption reserves in-use VMIDs in the ida */
 	ida_init(&smmu->vmid_map);
 	ret = devm_add_action_or_reset(smmu->dev, arm_smmu_deinit_strtab, smmu);
 	if (ret)
-- 
2.43.0

