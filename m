Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011021.outbound.protection.outlook.com [52.101.57.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A35CD3515D6
	for <iommu@lists.linux.dev>; Sun, 30 Aug 2026 23:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788131929; cv=fail; b=BdN4epgSFSTIUdr7FhR3Tldkvcyx/Ld7qgzeU83GAwrrHxRHAVbKAN08i1F3ZJlaAd+4AZT1SffM/eGCXwan9zs1PggetNDGQheujA1Q5+ptekkocRfvlmJjnsx6MwbBA9kDtIK1O+gnuOXLgJ5kYYOd1ve3snE1SFbUJDRU2pQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788131929; c=relaxed/simple;
	bh=aMa0SAqDfZ3LGJDAVR6kFiwdbgI32C38mIqioEcUDfs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JGT8F3qEVHLIGI+ObHtCoTG4Ah1ZQpfmavqP3yu1x3BRBcTkEig6JJ/6edZcPp40/MwSx/SK3UccpPzlFFWZ2RcRFkJ9nGaivAEzY18PkEN1DG8ozPgRxnkbbOGlxIoU447OV6Q7Md6vS3jDeIt6voznh76ncIEUu3ikFUab5RQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NVfuOjyd; arc=fail smtp.client-ip=52.101.57.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NVfuOjyd"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EJofZvE6QuT2CE82Wm9cJwADtIJLwr9yW4xyQPbAUtT4gm+bUY2Kr4fD7WxXvAwwO9SNaEvhXV5jwl/tRL0IdIdzF31g3JDNcVzUhQNB6CqJIl2UvmXAmu68Tj5TSnr9nR3yvfVjrRH7bRAjDskHon8O2WZ7Oyf/4qIsb3xWhz37BM3kCEDQTMHkqAAb1H4TByyM84wZbMEzXt0oYNndhOwZPq57Rogu6psnatITNvsAyNubRkatuvnYOeepaO+RLYcDjsVvKuvbO3nAHCgofCPcPR7+rH/CacnJ1PFr26mwEyM6asyuYr8UTnRPV4aINcru1qR2vXk7ft9e6+cTPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j/OT7P1Zkb2tLD2sJf6PLSfJk8SH+z7FU6nauZ2K/7c=;
 b=CUOEPYhEkgte+Ndi0Cje6gjuqwFOVP8s80DQ2RRW600T9vPYFmf78vXSin6JivlonbViN5LQKTNjFl1JoE5HTFlYkg6peartd8OG5bvzN83eQmXD/i11NpMcP71Ri+NJvo/0NWbgKmtAUxegf9Nh/H3gGT+W0/ip+Q/T5+cFZNf5aWv5Lkrn+gHx0MXRn56eGJg66eifqEf+8M4PuAPkzB8sHoqV4jlbLoDmwlNvEN81XGr1dmAfoSt6e3Ly+2ZiVE91Dv4m4ooy3XQfLijuOOT9b5igLc7PJOZ+9M4N2Qk1r5UB0zT7NdxdPbU4C8HsZ7OdIrF8Rxkt9Ha7bKOL5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j/OT7P1Zkb2tLD2sJf6PLSfJk8SH+z7FU6nauZ2K/7c=;
 b=NVfuOjydCV0IMGWrXKJtWw2owHQUUsJPyjtVxO94C5N75KniRWLfAkUKFSlz4LkUiW0vNQhZzxJHouLH9Jzif3pu1nMnnAVONxHSqLum49pszwxqC1/hNoNNwSR3fheo6iNTqNP5AP3865AX/AQz4t3zm08B6HEBiVs2FoKky7iLmlfVmkAVxhR6RC+HnP6okNbTcY3C61Z3SpsyeqBI+9iSSVsVSf8k8DLFp0hxjjafUJw2Lemn+mePnLgbh0LinSYSVkb+XcTsYtk+O2eK4o93mJLX3iHnaZDCjkV0/5+oi1sJmCUqv1kjOjoGMxC8bttutEnoPQnFChqY6y8wcg==
Received: from CH0PR04CA0091.namprd04.prod.outlook.com (2603:10b6:610:75::6)
 by IA0PPFAF4999BF6.namprd12.prod.outlook.com (2603:10b6:20f:fc04::be0) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Sun, 30 Aug
 2026 23:18:41 +0000
Received: from DS3PEPF0000C37E.namprd04.prod.outlook.com
 (2603:10b6:610:75:cafe::26) by CH0PR04CA0091.outlook.office365.com
 (2603:10b6:610:75::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.13 via Frontend Transport; Sun,
 30 Aug 2026 23:18:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 DS3PEPF0000C37E.mail.protection.outlook.com (10.167.23.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Sun, 30 Aug 2026 23:18:41 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Sun, 30 Aug
 2026 16:18:32 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Sun, 30 Aug 2026 16:18:32 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Sun, 30 Aug 2026 16:18:31 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>, <robin.murphy@arm.com>, <jgg@nvidia.com>
CC: <joro@8bytes.org>, <praan@google.com>, <kevin.tian@intel.com>,
	<smostafa@google.com>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>, <jamien@nvidia.com>,
	<kas@kernel.org>
Subject: [PATCH v10 01/13] iommu/arm-smmu-v3: Init the vmid_map ida before the stream table setup
Date: Sun, 30 Aug 2026 16:18:02 -0700
Message-ID: <8c1b88d58b26b97be0b2c9c78a254aaccfbd0baf.1788130528.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1788130528.git.nicolinc@nvidia.com>
References: <cover.1788130528.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37E:EE_|IA0PPFAF4999BF6:EE_
X-MS-Office365-Filtering-Correlation-Id: dfbc572a-fd47-4bb3-7c3b-08df06ed0785
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|23010399003|82310400026|36860700016|56012099006|10067099003|11063799006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	ooP27dpM2Oa6olcr3tN1CY//BZdWoYnV4aBGYpxufYtGJaYhD5jitxe+OdLi7xzorTAurFlcezndUt+phDdwRU/ZkhcH1W4GpfIFJr3oXgT8+CBJu+vVPqtyDpJFoarPo430J4JDuvCTOau/xZr5NKHx3joIGjxW74dKktp/jUagYrz7TFTis1WxK6pxGB5sABZJ6HMkuHDgl+K2UeyvWsfU+j1WzJkRrGvO2FpbHd1FECImfYBcvKqy1/m2JZoCZrGbS47yuovAaI1IMZ+dY+07lTKXDfPPB4Ig7Hfz+xFwqs8eiJiDt0YgPkKogQy1i2UqQsM/l8fvPtz9LPJgKbA2kVxzW274hLAyLG+btGo6GWnoz/z7oSy+Z/zVA/QAh72Dzu4PcJlO3ddBOMgBqTYcOX1eehJW31JKnds0S/T/DwXIEFS9d8O//HaZb1QxBQJtgrGjG5Zxg88ZyDU8AAVq4JWy3gZJ5y2efw70vfuL2DvnFrFOEUqdGF7nAiKVZchJ+MHz7vxhD7+YHtCQLTPlGxij6mjkutguq7qVxIHB6lxCleCk3EVIn8mRosP9ht7qPu9i2Y4+Cho0gM33Mk5zzTlVoWKyl1uJUfiTDiVfz/cYNWKqHAXHgEYYkhv7EEBIRmDJd1By/+aCaOCiuZM5ODG4pG3Ex79k70ymLzgE47age0tJA59u5fTeMXMr7yUvX2Gq22KXRXVN/jXnqw==
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(23010399003)(82310400026)(36860700016)(56012099006)(10067099003)(11063799006)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	C6tXG2quKXypAGZDdH4ATfeuiYXrO0oxPw4fQDKjIXH4A1UpDDEq6rTIgk+bj9Miza6WunD2vmSnRyyrfXdq8dYD1+JATg9N3GAiolj1WsvkRG2QV9BO69nyWa07NOgD6r3qBGeoRNk4h/IoJJwJtE7BUzpG8Fl8pqeNQfG9uuN16tczwUaAEl5Y1Kiy+Iah6TuEBAbJ2gwnH4SCdGrOkeAOSO0bj7bL79QBSSzaKusjpIEF0SzrALn8IRn0exsvbcmDurf9YuZdKAkNPfq7Q7+eh1OED+7Grye0KU3G7ucE7fiycn+rLn3zaU/7aOkLsOgF095qfyg5L2ZAyqI0NOijZLUNvGfDl/Tx4YQ4nJ1owOjlu5tc5fVUiH9JLZrpkhIjb+WJ6iB321snQ2KTjieg8lgXv5PIOWroZcVQXZFs9R0Yl6mlO9+3zhI6NUE0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2026 23:18:41.1732
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dfbc572a-fd47-4bb3-7c3b-08df06ed0785
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF0000C37E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPFAF4999BF6

The vmid_map ida is initialized after the stream table setup, along with
the devres action that destroys it.

An upcoming change will reserve the crashed kernel's in-use VMIDs in this
ida, from a kdump kernel's stream table adoption that runs in place of the
regular setup and returns early.

Move the ida_init() and its devres registration to the entry of the whole
function, so that the ida is ready by the time the adoption path runs.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Assisted-by: Claude:claude-opus-5
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 5732f3ba0122d..1c4322d87d8df 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -4584,17 +4584,17 @@ static int arm_smmu_init_strtab(struct arm_smmu_device *smmu)
 {
 	int ret;
 
+	ida_init(&smmu->vmid_map);
+	ret = devm_add_action_or_reset(smmu->dev, arm_smmu_destroy_vmid_map,
+				       &smmu->vmid_map);
+	if (ret)
+		return ret;
+
 	if (smmu->features & ARM_SMMU_FEAT_2_LVL_STRTAB)
 		ret = arm_smmu_init_strtab_2lvl(smmu);
 	else
 		ret = arm_smmu_init_strtab_linear(smmu);
-	if (ret)
-		return ret;
-
-	ida_init(&smmu->vmid_map);
-
-	return devm_add_action_or_reset(smmu->dev, arm_smmu_destroy_vmid_map,
-					&smmu->vmid_map);
+	return ret;
 }
 
 static int arm_smmu_init_structures(struct arm_smmu_device *smmu)
-- 
2.43.0

