Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2080.outbound.protection.outlook.com [40.107.223.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D68E92D7AC
	for <iommu@lists.linux.dev>; Tue, 17 Oct 2023 18:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WacokR2w"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YMie2SlT+WritlrFYHLV60RVNkGV5a86jtdRMLhCg1Mfc63d6L6CXFhq0yqfXq3t71N1t4hM5b6BkKm0A2Em/de73EbwMfWvbkC5DoL7es6ZgOi7p1zaIcDptNC3eqkx5MYJrJULTKIfg+6Mm+E9/UwqtIRWak/GQgjCYVg5LFnpWEaEHCOj9oLvszSM6k/Yi+WCqlyPoOzgC/LiyNbY+ITJgw0qXNbXkwqSxUWTtUQ7QZ2PdLJ8eZ4rERzfyKDXsSPIB5xWGAYeqheJfWZeoFIT2vSItj/CUGrp9R1aV6vbVZAhhsRTLo1LGbNF2x3j2ILPh7LBnxNTzO8kCiz/Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RCGukwq7edEHAhylgmao0YC2GaXXhPfhgHOitWZ/+Bc=;
 b=jDgo9sH61A3hwCOYRIaBhYDQgUopsrew7bhfQkt/q0lXApdcwX+VkafFR4rVp0oRWpHhfob8PzOjR4toCaAeb4Y6S+S+QrUTR68x2OQZmik3x0vQGXeL/AfqTBKBrc4MBocIhGFPzNqOkciIOKG6Bc0C1jHKbBG6e9p1ScKSJnv8u7Yo8A6V6qXRIHxIn3ycfDFDsQRXYySZy+jAZZUvhbeo6gv8AApP7ODRqvAIp+lI/g3qs//6CRWAKczGTQlMtGzfruyu5qGkHXBF9uW9j6OtxUpKqn8apyRVdrLxjQmz0OIq6Ip45Cv+Quur8Q4i03bG3ZVlS7ozUY7Zg3fTTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RCGukwq7edEHAhylgmao0YC2GaXXhPfhgHOitWZ/+Bc=;
 b=WacokR2w6p3nEVGSztavz0mWiXb2eIYHdRzljVNLTp//xcP4yfmJIOWgSN3GDvv3N6/oZFrWMYLAAowh9nMzpfD55KfVxDWlP7+sRx6qh+VOiIT1SpwraxumHLaL6GXTGK2NOWq9SNuAbPvvYXmMQnQ0cV+76CpYzYiLBjySgzlS6IiRQqJWPM7GKjbZrnTJ3Dq1H9hWqtMos26Kd6fRJIY/optbc1m0SXqoOOXI5yPEC7a4Tx9OHrCtM4tJIzlA5/Ihi0BqVheAvjutI4pRDL2JE6CRaBItzan/uoA8JuqwADJHVKGHRufjSgrQVQ236otvsUNqpVQy3fY+z1UhQA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM6PR12MB4265.namprd12.prod.outlook.com (2603:10b6:5:211::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.41; Tue, 17 Oct
 2023 18:11:48 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2%6]) with mapi id 15.20.6886.034; Tue, 17 Oct 2023
 18:11:48 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>,
	linux-arm-kernel@lists.infradead.org,
	Robin Murphy <robin.murphy@arm.com>,
	Will Deacon <will@kernel.org>
Cc: Nicolin Chen <nicolinc@nvidia.com>
Subject: [PATCH v2 2/5] iommu/arm-smmu: Convert to a global static identity domain
Date: Tue, 17 Oct 2023 15:11:41 -0300
Message-ID: <2-v2-c86cc8c2230e+160bb-smmu_newapi_jgg@nvidia.com>
In-Reply-To: <0-v2-c86cc8c2230e+160bb-smmu_newapi_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0138.namprd03.prod.outlook.com
 (2603:10b6:408:fe::23) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM6PR12MB4265:EE_
X-MS-Office365-Filtering-Correlation-Id: f4d24b57-e96c-4cca-378f-08dbcf3c8788
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	EVnzG2iw2R/ABiWU5jHLYPHEtkEnkRnqp4VGFuf4Spy4y1Gkwh9XW0Wmu2U1WcSoemrLYHyoTnn2/HepHZUiVyzaIUj38bK6Nw8si5ygwkypJDRKMET/ZTIz9oXzJCzlWV/rzLAWy8w7wO/UnxJK5BrSeEZvdqYOAUqKfaBQC3Y9+e2aFjdS35hmYjMd0jFudFMY70cBHg5GY3dKb2Zkc/IYnjs2/U+1krFmVU8cpQiNyH1LXW0qbkceVcQYwOq4HfZ6vrVhTgLAPXD6IxgMhqxunJfc3vXO/MpMXwWfSymcfrdlp0+mPco0HDE8jLUSeBb5ruR2ChNUw9ImCMMylNKjQQLpm7DWf4R507gIYAYLOA1udV016iSlwRy5Vf2mWcMM4/OXVkw63kyPVuXZPX73lsXX6Mz/CDJhmy1y86qwMcv3I+gOjsRz2s4mGJcfXIacuwN6f+GD4RXTDAqJzHHoH/t6/134sCe8/A0a8GO6/racPXyoqHVkbfazGg/r7cbXuhZs5lc54u9BjNa6GB7pMVNIyHgu3FTOq5J/YSORToD8NXk42nd2xUQgzgZkwECIWRCQwsJCD3E1ErnwNwl7YYVitdEdLwa2myQlk2A=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(346002)(39860400002)(396003)(366004)(230922051799003)(1800799009)(64100799003)(451199024)(186009)(6666004)(26005)(2616005)(478600001)(66476007)(38100700002)(36756003)(86362001)(41300700001)(107886003)(6512007)(4326008)(2906002)(110136005)(6506007)(8936002)(66556008)(8676002)(6486002)(83380400001)(66946007)(316002)(5660300002)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Eix5qDQr3KoX4ksTLIdKmKMcDOGPV2AqTF+RnzQad0zCJ81sx1+ZiEvjl3vi?=
 =?us-ascii?Q?Ix5aQYlxzVj+hCzVOVrlr0somdkgvuTBIIpzvkAHQla+h1lrFLUMsbvEd5b4?=
 =?us-ascii?Q?B7YyB1bSaO9Fb7fm+3JA8V6NWm0tfNN0lv5ZzAAeDbVQdU/sJZjrhCb5J2op?=
 =?us-ascii?Q?YDV7bCSoRDd/SxukTAwWenLoH8XuVicIqqwAp4vaQT4FQXfnF3FSU7LRUO+P?=
 =?us-ascii?Q?SrwykOomE73j6+5BOXgIFqD0mTnbZOu/5hhfNjw0R8WvO6WoJSYKMPZHdd5o?=
 =?us-ascii?Q?GlA9ZdRtbpqOcIFrlSQS6c29TeEKrb1rr1UCgAgRs30yY+fQPtYm8BpPYWmI?=
 =?us-ascii?Q?Xv89P7V/8xL8xbOKOO7VVSlLN2uUcpBUqETRdZqSb6iqRrbjVIgBm2sf0fF+?=
 =?us-ascii?Q?wzhrS6nz1T2JgLlPHLKwJXENojuqWdOuLy250RUJoBuiUCI/NKbCO/j8vt60?=
 =?us-ascii?Q?pzdFafwwCWFv86ewwf5YqwcrhcVr97H18ZQoeu0bfdLvoHj2gyoZ7dsqJ6cJ?=
 =?us-ascii?Q?WZE6bFswmRjWKMKWi3Y15MZdstC0eUitoAoHPUluwSKFajYL3R5GIGRJ4Rpg?=
 =?us-ascii?Q?uDZMmrAXU4q6GU7KetorXL+OoUe3Bu0PktXodvw+VsbWSrXm9ANG/vQEvwDa?=
 =?us-ascii?Q?aTXKpcjgj4z96q+FB/0RX29+wk25TkRGxhmTgtJididVOnV/WLw+rVRmxUC5?=
 =?us-ascii?Q?i/lNFfL5ZQyOq7F7qMywe+0BUXivJ/oP84b66FHeP1PXTNLm7m6HaaWUO/Zj?=
 =?us-ascii?Q?PiePPSJglUWsjQwUpyaQl/6KUkyMKMj8Pk4To75jvxwN2dPbl21jpB1Jqpgm?=
 =?us-ascii?Q?57/KjEB9O+H86ZJNpCco8MbfQVAFJkx5h4G5jVpjcLLZ7Le9VitjqZKPekq7?=
 =?us-ascii?Q?5ySvRSRhgScmrpcT2bZ+Y/Fr6eYsEG4gBkIYffL2oGAM2ogyfl9QjX5XiR60?=
 =?us-ascii?Q?L3xgsJN1ILri8htgAjwtfF4mvDmqjJIHR2kQnMpqk4t7sAQcfHStsYizCmVA?=
 =?us-ascii?Q?sGHBSiPjQp18FyvoNGnUmsyX6/J2vLGaLyvl2mlQw77+qW1P7RcA6jx39NHB?=
 =?us-ascii?Q?AS6IjYfTVrrd+GumlhmujQT1YvGrKt/py4Zy7dkbFpzkEYUkn7vCjX1/6hp+?=
 =?us-ascii?Q?gpJ9jwRto2hofjbDqT55ZX0JbY4BcLScdGgSFIRcsNQ6DnASgDHgR0DkYVAa?=
 =?us-ascii?Q?ikEh6oaN6wYWYW3A0m0sUGrIwUFvM31ItZKh8ac/+D7LOy7VR8wzDhlKnJuR?=
 =?us-ascii?Q?Tsdr2DWyiDav+nxAyPErbfodaTo6M9pqQ5b2OC2tFdjU71klJOdG6+35k0IZ?=
 =?us-ascii?Q?qIuh4hv5iya3AHxDOBZMDmdvkZ5On4Rb6pxr4DzT3JOXi0/TXeK/FgQlvMme?=
 =?us-ascii?Q?b37qbwxkOqoGiMrZ5uilxFPM8xYRCL/UkEWOkxqOCBJuT33xaiGThDHzxPuO?=
 =?us-ascii?Q?LpWsbIEc2QV2twTn1VRnV0BENyQWsjdFozbcRXS1p+atQ5HFcM7MeAMQ0axC?=
 =?us-ascii?Q?bQbZcAm0IOB2wUbwzPPTjpXWj+X7Ec/4uOW6L+c1hiOJBSj54M1RH9rzh3AA?=
 =?us-ascii?Q?+oh1E7WfhI9fW2gEvLJXtwTEMmhOwcAyDgBg1Ngj?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4d24b57-e96c-4cca-378f-08dbcf3c8788
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2023 18:11:48.3192
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GWqlU+Dy7KBGNaSnHQ5++PVW2g0CPEa89oD5T4KVEnAqQtgx+WqoS5Q39QxMXV1f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4265

Create a global static identity domain with it's own
arm_smmu_attach_dev_identity() that simply calls
arm_smmu_master_install_s2crs() with the identity parameters.

This is done by giving the attach path for identity its own unique
implementation that simply calls arm_smmu_master_install_s2crs().

Remove ARM_SMMU_DOMAIN_BYPASS and all checks of IOMMU_DOMAIN_IDENTITY.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/arm/arm-smmu/arm-smmu.c | 50 ++++++++++++++++++++-------
 drivers/iommu/arm/arm-smmu/arm-smmu.h |  1 -
 2 files changed, 37 insertions(+), 14 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
index e2ec1fe14ed40b..dde912f8ef35be 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
@@ -624,12 +624,6 @@ static int arm_smmu_init_domain_context(struct iommu_domain *domain,
 	if (smmu_domain->smmu)
 		goto out_unlock;
 
-	if (domain->type == IOMMU_DOMAIN_IDENTITY) {
-		smmu_domain->stage = ARM_SMMU_DOMAIN_BYPASS;
-		smmu_domain->smmu = smmu;
-		goto out_unlock;
-	}
-
 	/*
 	 * Mapping the requested stage onto what we support is surprisingly
 	 * complicated, mainly because the spec allows S1+S2 SMMUs without
@@ -825,7 +819,7 @@ static void arm_smmu_destroy_domain_context(struct iommu_domain *domain)
 	struct arm_smmu_cfg *cfg = &smmu_domain->cfg;
 	int ret, irq;
 
-	if (!smmu || domain->type == IOMMU_DOMAIN_IDENTITY)
+	if (!smmu)
 		return;
 
 	ret = arm_smmu_rpm_get(smmu);
@@ -854,7 +848,7 @@ static struct iommu_domain *arm_smmu_domain_alloc(unsigned type)
 {
 	struct arm_smmu_domain *smmu_domain;
 
-	if (type != IOMMU_DOMAIN_UNMANAGED && type != IOMMU_DOMAIN_IDENTITY) {
+	if (type != IOMMU_DOMAIN_UNMANAGED) {
 		if (using_legacy_binding || type != IOMMU_DOMAIN_DMA)
 			return NULL;
 	}
@@ -1145,11 +1139,7 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 	}
 
 	/* Looks ok, so add the device to the domain */
-	arm_smmu_master_install_s2crs(cfg,
-				      smmu_domain->stage ==
-						      ARM_SMMU_DOMAIN_BYPASS ?
-					      S2CR_TYPE_BYPASS :
-					      S2CR_TYPE_TRANS,
+	arm_smmu_master_install_s2crs(cfg, S2CR_TYPE_TRANS,
 				      smmu_domain->cfg.cbndx, fwspec);
 
 	/*
@@ -1171,6 +1161,39 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 	return ret;
 }
 
+static int arm_smmu_attach_dev_identity(struct iommu_domain *domain,
+					struct device *dev)
+{
+	struct arm_smmu_master_cfg *cfg = dev_iommu_priv_get(dev);
+	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
+	struct arm_smmu_device *smmu;
+	int ret;
+
+	if (!cfg)
+		return -ENODEV;
+	smmu = cfg->smmu;
+
+	ret = arm_smmu_rpm_get(smmu);
+	if (ret < 0)
+		return ret;
+
+	arm_smmu_master_install_s2crs(cfg, S2CR_TYPE_BYPASS, 0, fwspec);
+
+	pm_runtime_set_autosuspend_delay(smmu->dev, 20);
+	pm_runtime_use_autosuspend(smmu->dev);
+	arm_smmu_rpm_put(smmu);
+	return 0;
+}
+
+static const struct iommu_domain_ops arm_smmu_identity_ops = {
+	.attach_dev = arm_smmu_attach_dev_identity,
+};
+
+static struct iommu_domain arm_smmu_identity_domain = {
+	.type = IOMMU_DOMAIN_IDENTITY,
+	.ops = &arm_smmu_identity_ops,
+};
+
 static int arm_smmu_map_pages(struct iommu_domain *domain, unsigned long iova,
 			      phys_addr_t paddr, size_t pgsize, size_t pgcount,
 			      int prot, gfp_t gfp, size_t *mapped)
@@ -1557,6 +1580,7 @@ static int arm_smmu_def_domain_type(struct device *dev)
 }
 
 static struct iommu_ops arm_smmu_ops = {
+	.identity_domain	= &arm_smmu_identity_domain,
 	.capable		= arm_smmu_capable,
 	.domain_alloc		= arm_smmu_domain_alloc,
 	.probe_device		= arm_smmu_probe_device,
diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.h b/drivers/iommu/arm/arm-smmu/arm-smmu.h
index 703fd5817ec11f..836ed6799a801f 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu.h
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu.h
@@ -361,7 +361,6 @@ enum arm_smmu_domain_stage {
 	ARM_SMMU_DOMAIN_S1 = 0,
 	ARM_SMMU_DOMAIN_S2,
 	ARM_SMMU_DOMAIN_NESTED,
-	ARM_SMMU_DOMAIN_BYPASS,
 };
 
 struct arm_smmu_domain {
-- 
2.42.0

