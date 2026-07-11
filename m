Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012058.outbound.protection.outlook.com [40.107.200.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABA67272E6D
	for <iommu@lists.linux.dev>; Sat, 11 Jul 2026 00:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783731209; cv=fail; b=J6PaLdj0KliDxdmXBeAjBhQuQjTL2wd4eD7wn4rKz0pfpXwJBJJwsNTmPjvOwC8/l0sT9gJdT2wMDAPYi31uAmpHTUWNkQhsbbaGFJtvrPGiSglvdhYRm8JfahKT0ZwCa+FFeaoZeIjGh8rFBZ0RPx/OXKRPWSZhhf+EOnsu2os=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783731209; c=relaxed/simple;
	bh=yHRnDzJCRwnknACwcpcjn+rycpdrgEz50Bv/3Qz9xgg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Nz/MnVQfGBvnSTyhH7wPFYmSI33ICTHZ8IFKQLbxWyftgRHA3X6eVbt9RNSuBP01b7KhDrRy4fpj4Al4n50CqvPVjnx4qtWlDjFS4Fqw+bnGXrp90lKUtnaZZ6888FtiRRzziiaB4612vL7D5nqhZYE/wwvL/w6rBHI/L3hhcsY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fTFitQ0q; arc=fail smtp.client-ip=40.107.200.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fTFitQ0q"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s6kbitgfj4SLp39eFth4fKTRAjkgne+XxPXakRoJrivYDwUO1xPpt6hwz4ndmDPL8OQGziKbkaI0ajq2iLwBo/9dbWGcxqQbszyPRwSj4k1D4j4QbBjHg3F21x1ub9RvLtr2wyjesH7xKBbU7jyU6pTm+UTvN/+mEHZJPAHExWqbMK5pj25u4Gj8jT2Yr3TgG7BEhqF9Mb4g9Oqh1z4Uy1az2eYAACz1r3fbvljI4B9dqILDYZNCT6ecmlG3KuGIjB7A5Cc3OVNh7cJ4gsFLmIrpdspiovB9MjB4lAUMzAuzmCs/82LjxfPrHupddkfOm/xSl+3FAjvDUm04ch5pqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5V464Wpja7qSw2vbipp1o77Z8p+QGOTSt6g6yk9njn8=;
 b=dl5P2nmxUXraOCR38nKlveCmkueXz7FIJsgS5VakWy4g/i2XKdLjhEIw26XWtiUrlofuIVC9LgcKsuvrzk1XXb/s2OZraP/0Q6mfIrT6ErzDtrSMyQacrNDFzX82rAc/XcbJf9ZqrALBWF70sLXNMI9HQO+GtbO9pwq9z3rXvNAtnPVGaxUTJv/IUW60UsZs0Hvb4q0PaBLUbKMQpCXy8rlecCxPHZHG9lvBQVQazn5Hxgm4AEd7wqNmhhLEzfrKG7K8zs0pZEIMJeV+jFQdJiwgbvN5Wgj5ZXNSqGMat2pKeLYmFSMC1TbixpCqgUWWGJWLF/MYNqUbDKRxrXwXzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5V464Wpja7qSw2vbipp1o77Z8p+QGOTSt6g6yk9njn8=;
 b=fTFitQ0qxflU0GTudo5V3sg/bFkhi6JjfDOnugZZEUpQAD7K494Yka3lcE7N60RRElWoqRnflqKa0FDrU6sleYocvN5EjHBPHVu6Cq8fTm3G261T4dJs+DOv8I/VHm8HI+Tec+Ytl8rMAKEyyCqkwjLFyYPz69JtnLvdLyVT9USC1ZzHE82qMYAhbZqijUy3plhG07Dj/AWHBo4vrNRGJCiiLntT18MM7jk7Tq++KmFrPN12IpM2QQwdeFAW/1YTA7GMLQ63If9TFsuDzMzIGt3eQNrqGqKcPaURt3W+IMeyYyXxOxX1kVm6CvDKZ0ADeSwPGWWrob8+iCh5x+mcqQ==
Received: from SN7PR18CA0006.namprd18.prod.outlook.com (2603:10b6:806:f3::8)
 by DS0PR12MB7802.namprd12.prod.outlook.com (2603:10b6:8:145::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.18; Sat, 11 Jul
 2026 00:53:19 +0000
Received: from SN1PEPF000397B4.namprd05.prod.outlook.com
 (2603:10b6:806:f3:cafe::2f) by SN7PR18CA0006.outlook.office365.com
 (2603:10b6:806:f3::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.14 via Frontend Transport; Sat,
 11 Jul 2026 00:53:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF000397B4.mail.protection.outlook.com (10.167.248.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Sat, 11 Jul 2026 00:53:19 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 10 Jul
 2026 17:53:04 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 10 Jul
 2026 17:53:04 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Fri, 10 Jul 2026 17:53:03 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>, <robin.murphy@arm.com>, <jgg@nvidia.com>
CC: <joro@8bytes.org>, <praan@google.com>, <kevin.tian@intel.com>,
	<smostafa@google.com>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>, <jamien@nvidia.com>
Subject: [PATCH v8 8/9] iommu/arm-smmu-v3: Skip RMR bypass for kdump adoption
Date: Fri, 10 Jul 2026 17:52:49 -0700
Message-ID: <576fa03a4824fc70e4b9007173396ce6dd55db15.1783729633.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1783729633.git.nicolinc@nvidia.com>
References: <cover.1783729633.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B4:EE_|DS0PR12MB7802:EE_
X-MS-Office365-Filtering-Correlation-Id: 49850341-2cde-4797-44ab-08dedee6ccea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700016|23010399003|30052699003|1800799024|82310400026|6133799003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	7PMPoI9OohmXfk76+10Gp2ZbVlBVbIRTmcqxgv3SR9ym0wMVwhrqfMCTk2QoQv718i2RHXoQS8fiPlcF9UyMB3fyY9mCA1HLzKrON/OqqLnNthp4Pt66gcCVFI/hH6269jzAFEYrA/aiZYsEEOe3ex3Yu51SOAOQojrJfDuirIFI+kXoeuVFg/KU6kxjCKkIOQu+GsQPDhpcj/DyeUrSsX9bsxzZtmk2lh+bPEiRSq7zvzBpBJZ7Nrl3PHwPEl9hB4kxmvg/lyMrL/yeQP7Jp7ryX/Szx1t78ROpLOpLHGcEUB/f7G9dPw8qe0ZDDWN14QG+11xxC2495Ib8lwKDn5qmmSxnzAFhys589pd/pABKeyrlJcvuXeFYv6M5ZeO93ahcwf/scn19pP+5ss5fO0BeST3HYVw0dsUZvMx1+bk2bJHyLkesM2O2W/khvJhdfgpUValxBNP9GKR39cJVFRrFHOVV+J5YTY3uAhnuJK65mFDXwCdMwI1wVGBlANMciDfVyI4Jyp5gqI3It4R6JdurQieOB///QvXqX+CaNUiVjqakAy/V18UOoduW2QrTdigTh2lN6HLjccWaz1B5iErUJfnlnAwYs3L0lbc5y0X1ReI9fWi4ehL1aJZWH9M3KdW0FIv1Sxdxqz8eijtTJppYbPmEVwS5Q5RlwtCDNCysv+rLuItAGRORfVbT0N369IryLaGJ7IcwQbxQ7ycgZQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700016)(23010399003)(30052699003)(1800799024)(82310400026)(6133799003)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	4RUcUOcEHiSGLGRGqQz4xzW/6cZd3QMAAIUXzYFL2mSKaMHQ7w7nMFkgnSVg/pg84/wWIDqNctOo61GOH5XQa2+iyU7jPkR2TgzCxjpGs8lwOwCtUnMX7Q58Lt7XIjsx395sfrymUGStLhYmUEek08+pbYkbPRvqoM5vFpw3z1M6Pb+yydkK7yQrKjt/DY/DqEcOuP+MFFhe54CqJLv06j5r8ksoo+vpwFFXIzAzwQjqIFQKHnmLwnfaR8PpSTliSBYs8/d4+oKq+pjV2NPKCON/SecJCwHhpNP+WTmd9llLJomi7iOgOwhNR5lPolVov5dNGsvfHn8hwADEMgOp+fCZW4mc5Y7W2UW2GnmqCaZpoh3MJogrcO6/pc8kG8g2lhR70WZlm11gxvtLXqr6uZLOWPsbI989Qvti2twR/S7Wm6bT8tRPcKhhy4EoZOA7
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2026 00:53:19.3832
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 49850341-2cde-4797-44ab-08dedee6ccea
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7802

RMR bypass STEs are installed during SMMUv3 probe for StreamIDs listed by
IORT RMR nodes. A normal boot switches the driver to a fresh stream table
whose initial STEs abort, so those RMR SIDs need bypass entries before it
becomes live. This preserves firmware/guest-owned traffic, including vSMMU
guest MSI cases built around RMR-described SIDs.

ARM_SMMU_OPT_KDUMP_ADOPT is the opposite case: the driver keeps SMMUEN set
and adopts the crashed kernel's stream table, so RMR SIDs already have the
only translation state known to be safe for active in-flight DMA. Replacing
an adopted STE with bypass can turn translated DMA into physical DMA, then
point it at the wrong memory.

arm_smmu_make_bypass_ste() also rewrites the STE in place after clearing it
first. While the table is live, a concurrent hardware STE fetch can observe
V=0 or mixed old/new state.

Leaving the adopted STE unmodified keeps the kdump kernel using the crashed
kernel's translation. That gives the endpoint driver a chance to probe and
quiesce the device.

If the old STE was already abort or invalid, installing bypass would create
new DMA permission; leaving it alone is a safer failure mode. Later domain
setup still gets the RMR direct mappings through the reserved-region path.

Reviewed-by: Pranjal Shrivastava <praan@google.com>
Assisted-by: Codex:gpt-5.5
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 9aa1df1e53cf5..325376cd72ba8 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -5421,6 +5421,14 @@ static void arm_smmu_rmr_install_bypass_ste(struct arm_smmu_device *smmu)
 	struct list_head rmr_list;
 	struct iommu_resv_region *e;
 
+	/*
+	 * Kdump adoption keeps the crashed kernel's table live. Rewriting the
+	 * adopted STE here could expose an in-flight fetch to a transient V=0
+	 * entry, or change Cfg=translate to Cfg=bypass. Must skip here.
+	 */
+	if (smmu->options & ARM_SMMU_OPT_KDUMP_ADOPT)
+		return;
+
 	INIT_LIST_HEAD(&rmr_list);
 	iort_get_rmr_sids(dev_fwnode(smmu->dev), &rmr_list);
 
@@ -5437,10 +5445,7 @@ static void arm_smmu_rmr_install_bypass_ste(struct arm_smmu_device *smmu)
 				continue;
 			}
 
-			/*
-			 * STE table is not programmed to HW, see
-			 * arm_smmu_initial_bypass_stes()
-			 */
+			/* The fresh stream table is not yet live. */
 			arm_smmu_make_bypass_ste(smmu,
 				arm_smmu_get_step_for_sid(smmu, rmr->sids[i]));
 		}
-- 
2.43.0

