Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2046.outbound.protection.outlook.com [40.107.244.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCF8B29CF0
	for <iommu@lists.linux.dev>; Fri, 16 Aug 2024 00:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723769764; cv=fail; b=pZ8wZ+942lxmlne7khWt2VDHURPWR+08vnjBAkJNh7xUafPG1ft4ABOrO0T2rdp5TuicRr4h75Os94bg+bBQ+ljaEvVVJ6XAnHmlThd3f3gdXGhPwiPHsP1fVr2byHLobl2hC9tHWE8IidHiz6uvkU9hbhvPmnM5KyUSDVxI/DU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723769764; c=relaxed/simple;
	bh=014+MHv7pi6V1gRYB1b/iei50FEpsrdO7vAj0Cdgzdg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qlVi+/cLNnygf7Dt7B68RBV0D/Ke03dxvPFrR3tV3PBt9t8x0rsertxIGqAUB1oUeEghk8N2POWTU1ZVP8OJtQ+41LJGeX4y3xmBbfCZJsm8ulJtJPv83OAWLkY4Rmc0oOWOibSLf6GRKcy5Mja1Vg2m8fzQeQ/51TMreG6D8RA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RzCEg8TD; arc=fail smtp.client-ip=40.107.244.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RzCEg8TD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cuYg3+fpRevRmVa4ikez+ZSdmejbbLhLubjvAew7GqHVZS3VgaMLmGtleEqmno/SZA/vJXdlluYzsGrwNA50e0alALO9/M4FYSjlkWgLnz5IYGz4eJ5uEeWeBNw136m7dOXZEKoM9DONbeTtx6ceDV9P4h1lnkQbCcLKp4rqARiwQ627OkSEwW9Qu6BXFXdKXJgJWletIn37X63mYd7W0kbzCKof7TiEhB+l+eddgC2ZhmTEQFXrCPu2EQmgmVjPTeNU/syyg7YpmqCFFdcFZO6GODHRGsPiEPuRD+eV15kWkcGXOqH+H3VHRdRE2NXa0E4QFPWtAHy9yZOyWlY1fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lt5K9UCEEcniaDhgg5NrVV/8rsRKGQ7lUBCbem2SFgE=;
 b=Ms4Yjv+1phH2ufizPkxQRn0XwME0OwY/gsvs9UYo9Oq6mleaoKv8yfzGWeFbUak0+mznylLWqSo9hw0xz/PiDh04xsE8LRgAypLGOXHMW9TgZzNs2qGutNZ4m4byLlWpzcy2bg1Oaq6vC18MejUGwJPRRzC3QPOeiG87tnJSFgvcrIJq9n3HINEbu8w0w1h1l2D3tlAmchKWy2Y57HRpUS9G9wQRF6fRysoHakS7MyGC1xwsmu92rhzBuJbcIQItMj5eoQnEWgurHAViwfTRxhulsQ6snY96x9O5Gnl9A9gq8wX7ZabC6Y03FIqPbObMr38Q6/dB4mzrrgQZnIWS1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lt5K9UCEEcniaDhgg5NrVV/8rsRKGQ7lUBCbem2SFgE=;
 b=RzCEg8TDFOZnmUYL+WMO3bxUVvsJreEl62abGD3RLEjeM/wMur/nVGSqDYEgNQnGgxd2IPO2Nkl402thePYyxC/O/Z7uwBJ5uxsCKjsTxxFDGPeFpxrDO7DC9JPia1BlqV4zxKs7HD4d8FiKwCKPt/1qMQFTcVJT3CCACJIWWn50sEsGZyw8O9fo42xw/lBkWcLYO1xqurBQCbMJKz7p9CqRK9n23R7vqnEK1Ba32tVcAHaXct+01ubSe3f0bN4UhToITo3T3QFFitThCeLUac/SuMCqw9Jg6tiGTbb4Dog+B+WGQCyenDnJTBsnOZjQik2Ul3pZdi6Bv3kfxgLNTA==
Received: from MN0P222CA0009.NAMP222.PROD.OUTLOOK.COM (2603:10b6:208:531::10)
 by DM4PR12MB6495.namprd12.prod.outlook.com (2603:10b6:8:bc::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.22; Fri, 16 Aug
 2024 00:55:59 +0000
Received: from BL6PEPF00020E60.namprd04.prod.outlook.com
 (2603:10b6:208:531:cafe::67) by MN0P222CA0009.outlook.office365.com
 (2603:10b6:208:531::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.25 via Frontend
 Transport; Fri, 16 Aug 2024 00:55:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF00020E60.mail.protection.outlook.com (10.167.249.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7849.8 via Frontend Transport; Fri, 16 Aug 2024 00:55:58 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 15 Aug
 2024 17:55:42 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 15 Aug
 2024 17:55:42 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 15 Aug 2024 17:55:41 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>
CC: <robin.murphy@arm.com>, <joro@8bytes.org>, <jgg@nvidia.com>,
	<thierry.reding@gmail.com>, <vdumpa@nvidia.com>, <jonathanh@nvidia.com>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-tegra@vger.kernel.org>
Subject: [PATCH v12 04/10] iommu/arm-smmu-v3: Pass in cmdq pointer to arm_smmu_cmdq_init
Date: Thu, 15 Aug 2024 17:55:25 -0700
Message-ID: <729aa3ad3473c9459df55e487f24929d6f8e2716.1723754745.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1723754745.git.nicolinc@nvidia.com>
References: <cover.1723754745.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E60:EE_|DM4PR12MB6495:EE_
X-MS-Office365-Filtering-Correlation-Id: a5ca7bf2-91eb-4347-50f9-08dcbd8e315b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zMc3GSlRapSfT2UfIW4Y5M5rqB/pUkMVwTwD7viMKSnrEniC+n7iUXRu0L9l?=
 =?us-ascii?Q?iWrkH4AEqrWTItHWG9xAP+38wbPqneSO26ADiCOgGh9DgenymiM+zHDLIggS?=
 =?us-ascii?Q?GZdZTfP7ARCPzGnk2n8DwUvdX3SeQFrnhG2fs8Qjxu0jfTUTRKN5lxfI/JZS?=
 =?us-ascii?Q?7xIQS8VLiqTcbSDqDb9m6Xc5EzMCR08gok0kKf7OVAd9v0coaZfzO6a9cvZQ?=
 =?us-ascii?Q?d1RqAeAiakj0M+Q0sQraOXZnbrzehp15fF5+A8uWhVPhAwWywFoNhuyDWzmX?=
 =?us-ascii?Q?/GxpS63UJl/ga1alsQ1cCx7NvkjKjMVh71S752oFZpmGpaq4uwmZ3Gngo1c6?=
 =?us-ascii?Q?8kiDa/jY/GRZtesI175YRy/NfpWosuX9bCZa220fW8RsdNhofJyFZzDTIwle?=
 =?us-ascii?Q?QCyifuWKMCFNeHY0Xb8WZZfoQwuRQ4/qEqjsO4WCY85rrz4Opb0n918sRq+o?=
 =?us-ascii?Q?Nd6KdeRL5xbn/WPAUHmbClJi3DE1qxaSitURyNvO6bvPbkCaQ7ZacfwMrDx1?=
 =?us-ascii?Q?J5RChW/TqR6z3T63GG5T4/XCmtyo8SwiikUicvu4mqBdrYxErb4MxyEih5y0?=
 =?us-ascii?Q?93iCtH6Z5z9PLZ7bpfBF8vpFnHkjl2Luo2jLT1/jbXA/F5D6gPV72ikdlAYQ?=
 =?us-ascii?Q?Sltqc47ZJuoqJUI9WiP4vY3T4Me7IgrAGv21TE3l7tfoIKvNU+KMYNhS/g6Z?=
 =?us-ascii?Q?vd35TkhxUWmjshWu3Y13oHVrcY6F/RQj7Dv9kzzpUawQknecUbpl9eZYyVsi?=
 =?us-ascii?Q?vEHryQDiMHBnU5MuiruRMIQpKKzFTaMTgx+1igvQTZUEKetpa9iv6IlfXDof?=
 =?us-ascii?Q?hmpnUbzt60ASf/uU+YgdaPFLZnM6ZscovQa2MPp9ywAQOCIIjmP6IqoCH1Bv?=
 =?us-ascii?Q?UhCb1nTafoLkaotk1fLlDCTUdcLajMl3i9FqQKas6RJUAZDh524IEmcVH9v7?=
 =?us-ascii?Q?vrDwgCCL+24tevusDA4whwTtED87fzFpY8MEJ7ZsI4hdL2IDlGXgHZxmLv9g?=
 =?us-ascii?Q?O5KiarnHFuT6nrFahh1BAseiue1XoLEqYJV5XPJ/osMZeABCbmnK73675Tfn?=
 =?us-ascii?Q?zLvWE5TFvoQgthQpKuWaYFEYwEdPySrdUc2PR4HuZUILzBYHhGPY35ik5LX8?=
 =?us-ascii?Q?Hd1RaDFrGS+kgzkPR4cgeWMckLEVk73pVzQSN4tNSdfo/RD0oBGeblyGZPhL?=
 =?us-ascii?Q?q7gUFwhwxpVlA8sVKGtc9SLP47XohebsP8iimYEkYbW4ssT8SOcft3Lu3tSF?=
 =?us-ascii?Q?VDpt5BsvLTLJq+C1AS219wzAewTlLG2kpbr9XAU1nHJL9OMoKxeETleVUe3k?=
 =?us-ascii?Q?41sNIT48R4pGDyYhdAI9AFFCCoX0j3KQ5XQDmbfosZXH6WPs836ZWuGYtgDl?=
 =?us-ascii?Q?HEQkZ7chTcd8ynlkklWXkOO76wNALsQm019fH1D367LdiJSyX9eiPER6xI5B?=
 =?us-ascii?Q?qaWX0bFpY2bO1q4XUkg/slkT4B5rltO+?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2024 00:55:58.8966
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a5ca7bf2-91eb-4347-50f9-08dcbd8e315b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E60.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6495

So that this function can be used by other cmdqs than &smmu->cmdq only.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index d11362e9fc8a..e664c40b14ae 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -3555,9 +3555,9 @@ static int arm_smmu_init_one_queue(struct arm_smmu_device *smmu,
 	return 0;
 }
 
-static int arm_smmu_cmdq_init(struct arm_smmu_device *smmu)
+static int arm_smmu_cmdq_init(struct arm_smmu_device *smmu,
+			      struct arm_smmu_cmdq *cmdq)
 {
-	struct arm_smmu_cmdq *cmdq = &smmu->cmdq;
 	unsigned int nents = 1 << cmdq->q.llq.max_n_shift;
 
 	atomic_set(&cmdq->owner_prod, 0);
@@ -3582,7 +3582,7 @@ static int arm_smmu_init_queues(struct arm_smmu_device *smmu)
 	if (ret)
 		return ret;
 
-	ret = arm_smmu_cmdq_init(smmu);
+	ret = arm_smmu_cmdq_init(smmu, &smmu->cmdq);
 	if (ret)
 		return ret;
 
-- 
2.43.0

