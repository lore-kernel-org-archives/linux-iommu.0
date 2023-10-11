Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2056.outbound.protection.outlook.com [40.107.93.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4486A3D99E
	for <iommu@lists.linux.dev>; Wed, 11 Oct 2023 23:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QW9Go6qs"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=COf+U5XML6kjs3EPNkiXbvEAzJGN9irj7u50ryDzPHdJOVYTFWirFxJxDbA17FqpQ+adgiQHXJ5mlCYtUOGkDe7jPFAttMRNyLUthFds+3aff8uIwc00jbD00m+g+BVrIJ+bpXfBknYwYg462E2SX9YUtfB5Duh39HD+jmed/ip/c0F/Z82mZEX8DQukmzwOUVNTB2ONJaOA/uA+oinhpMqP7HtUdvMmkwNmGJ9FVeUX5YdRFozYcWpsl5QHY52yOuJi3xWD/C2XeApb9gl5DrBDgvMnBjK9m2fS6GCcfPKqFjGbtFz01Ful6XtGWHYBjCIjgqae8181zf5Cw+Yy4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EOBDTfeTV3Tj5j4XQAd5rTMvjK2UZWqaahLTGofq4k4=;
 b=MMaMVQdfgcBrlr7oAdw656IKMIZsUPlrO2PXowt5V7CAeNjkcJb4b3rAWNMPG2ns8hKeD6+vjhT0K6y/IMsx6oa/BdI9Gt43uUc0wRT/XwYnCQV1t6BoVUQkrhqPjOXtfJAnwJUY6z8wyV/28ixJ8Kr3R1WXSMNnoWYrMqOHlmZbNk9sEZit2fFLFXT2FhK7Elo6gg9vHZRxa4wJ8Wztf3G3FatkIbj7uXgqMcd+eN1on8TfQRZFrOaTlNve7BcmosW9oCV7UIcyWCRYbODClvceL2chGSdQdSocLKEeF8JxEPu6RdVuAw6kkYd1SVESKeyc+dQMtXoTl3mOeSiQnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EOBDTfeTV3Tj5j4XQAd5rTMvjK2UZWqaahLTGofq4k4=;
 b=QW9Go6qsIi4fiJyaUdDO4NDSd3Da0iUoD0og5j4ilSX1AZopSltD0g3ttQ4Pufwhbu3RCFH0cC9Jyzfiko3PI759Fg+VKrlVnWn1h2Pr17sDzE+QzPD0rLhhubkPydoUQCc0+sHQ6vEWa+/Zng9YnDXUuBt7U2FXAbsUFb02yTXZQXzKg00ClEBwKJCh3SwUrmnUkBEZKTmx3F10/15iB4sLeChIRqUwidsoPyYyMB8NOgf7hoCJOtBW6+Up7C1QP7JpV2aWRqNO0jtChh0XDiSUDunZqHt2IzmnEjBv/5vXzfGFRHz+qtDe+wJJdRH6qHOhVd5W4a57ZJkX4R+MOg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CH0PR12MB8488.namprd12.prod.outlook.com (2603:10b6:610:18d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Wed, 11 Oct
 2023 23:26:11 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2%6]) with mapi id 15.20.6863.032; Wed, 11 Oct 2023
 23:26:10 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>,
	linux-arm-kernel@lists.infradead.org,
	Robin Murphy <robin.murphy@arm.com>,
	Will Deacon <will@kernel.org>
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Michael Shavit <mshavit@google.com>,
	Nicolin Chen <nicolinc@nvidia.com>
Subject: [PATCH 18/27] iommu/arm-smmu-v3: Make SVA allocate a normal arm_smmu_domain
Date: Wed, 11 Oct 2023 20:25:54 -0300
Message-ID: <18-v1-afbb86647bbd+5-smmuv3_newapi_p2_jgg@nvidia.com>
In-Reply-To: <0-v1-afbb86647bbd+5-smmuv3_newapi_p2_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0030.namprd13.prod.outlook.com
 (2603:10b6:208:256::35) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CH0PR12MB8488:EE_
X-MS-Office365-Filtering-Correlation-Id: cf162110-35ac-43a3-b2e3-08dbcab170a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	XDLV8BdtPADh/hGkqU+QFtd74ef13MmPdz9eqCJJxM583Vv/FC+htTgH6kqSJnleNOjfznFH0stOXTjXA4+Wfmgi9UUWJQloVLXgrtyvF97Yc0EEcs6FsUHOz1C4HEZ4CSorg5Grun3hQYF4ij9s5qUOKwQlVAmWOvmgsPl2iPWcgu0e7gvZH+aXK2AvZEca53DKRn6U93go8SrkQfJ8AVK2vMzZMtwfUqq4o22ugnIOxKZ3djPjx0b8W6Wd+H9OFVbf/jNL+1ielSxbn18fzez528KwAeqanllinhmWugSnxwOMPxOaC8uv4WMzuB0EIZ1cZlTyBSA4PUWKxydjczu59Rp33LUJKQL4OlGR6K4V2z4a8ERkR57UR5tLAkuqSgSYbV2I5qk2rjC/kD9X6QiKiYw+TwZZgQQwvdAOnf7vfQQ1egSHZQhlJKhxmyLGpshJEMrqXDuT4RyHkOvp/jw1CVrkqkc53/ZCOUls1FgI+Oj/TwKR8D5JvyzXrrNCDp7ZKJ2DXCtMoLFQtLlTMPuFpHi1MMPBYTMnC1yJLl4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(39860400002)(376002)(346002)(136003)(230922051799003)(1800799009)(451199024)(64100799003)(186009)(66476007)(66556008)(8936002)(66946007)(316002)(54906003)(110136005)(2906002)(5660300002)(41300700001)(8676002)(4326008)(6486002)(38100700002)(2616005)(6666004)(107886003)(36756003)(26005)(6512007)(83380400001)(478600001)(86362001)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5rKCRGDp2d/QAo7ZR94ND7EPf4LGtG9g5Lp0WGBrrhnQForzvW+V6YPnK7EM?=
 =?us-ascii?Q?+x+8cegfMKqRnfsMvGDcNP8Bk2nlnWY4o8+8F834eS/PA8WUgT5+MSpNpAl3?=
 =?us-ascii?Q?mtmdbjEdN8oFJSlXH98psdff83hZmmlYTWiYAf0CGwvICyouAIjzVK8dmy08?=
 =?us-ascii?Q?QBkj3WBx8OI74pO0GjqhDyjgcs/7fuksHCV4dgYn6R9QuaUJrdU3lgz37e3E?=
 =?us-ascii?Q?7Qcut3iaXD3+FttL2ZeS0IX1sZiD6uuYaR9pPRA5BAOdwmggbRd9k+32gtzV?=
 =?us-ascii?Q?2C3SaAFZ6h2IclmWiC91lLz5eE5cLUi+AsWuDPOFuDYn6EFQXJIC/04cHRKC?=
 =?us-ascii?Q?zPdSZ/uST9W2sIuQc9x1LJwasELgjDxeVyGcH0X53rCYSuH1d/p/5ervOFxD?=
 =?us-ascii?Q?8HR65StJaI92lyqPe6BIfcycjkEFc3ZqrV85kP3p0bG2y30XIVWOmJrbny/3?=
 =?us-ascii?Q?7kt60G1NUbsnuw7GPcGcVRm/B66WwvDGV7QgRp166Wq37AQV8eXmoTMSmtmJ?=
 =?us-ascii?Q?xRpG7iIxDLsbR9tzAYwmxm9zMBuhO6JfautiqjPYdpNBjRegpHAveqsBGodG?=
 =?us-ascii?Q?P3EZ3zsnpW5ZX5fH2kwrtkpH8SQXYaSGWlaWdyUw4pUmQnktRT1/+DBZC7uw?=
 =?us-ascii?Q?ySmBK8ALLJHPcASS871Kgicp7In1kzZUR3YcjaO8BMjyjDxIuTD8YVbZx+Zj?=
 =?us-ascii?Q?hCGq5aYp5/xznqRS5EwazHb0erCLdX76cGuSRRvXjHA3URlPE+CrXrQ4VnZn?=
 =?us-ascii?Q?UH2M1JmPZAmI/eVBAq6HQDl3wb+yU/Sll2GEpVtCsvi3LmtvaRdQEaY0lk1E?=
 =?us-ascii?Q?CE5P7xFleZW3p9qkzCWMfLnf3b6I8zO+XMutNDZuZkKsYLIARxcWelQpOmEn?=
 =?us-ascii?Q?CusY3s5HjGhasM8tVKp1AonGns671zrf+3pk3iZ2Or5QlzE+zMvsjDfvtIRb?=
 =?us-ascii?Q?fu9AkLOd21lJtYXSAmVTHvjmkyupgN98/GH7BYEcRZnYO9whzTabtMkcIFRd?=
 =?us-ascii?Q?I12jwaGeD9hZOcoHbyaoXD+yQljTPHLYpkYOw54J+zPG5CVVrfoZHnCKJBLt?=
 =?us-ascii?Q?TlnCKFSoWatxltbaIOZVhckSBam1dWiAP4he4/9KXMdtcwbCZm2nw48eaXS7?=
 =?us-ascii?Q?xU6Jynbzb3aqamRRo2DhlxrTuocwrK5sdmJ61GYDak5YgSeUznDPyEuGq3TI?=
 =?us-ascii?Q?+vO8AAOxkWMk9yvebemguEJDYedHTa3AUbzeFsXd8ZdNLlX/jK9TrO/sA3s1?=
 =?us-ascii?Q?iaEnnCoHJpKSZgEXXdoJWyPHBaLCgmRrFKXfLi66nyTDGip44gEDIENmj5O6?=
 =?us-ascii?Q?JKyrVumbU47nP282f9j+h0X1cc1kb+yXc9DWGiOiIBvzYWG7Rzn9tA1HgJof?=
 =?us-ascii?Q?+pQOWMY6DPM8JdEmRydgx0WZU+DLHRw7Zr5m9OyEGrdNjDPwWetMSjaXW0LS?=
 =?us-ascii?Q?DdZ47vbfyeHyfM6i0n5Oh+LQZJaeDdb5gHikSHIHaV6Om26RnsO+nZg3I6GH?=
 =?us-ascii?Q?E9kgLKpjCrIWPg5j/5Tg4HcMWnHUcut1ckYiTKswycyB0u4brEvEPgWYL9o2?=
 =?us-ascii?Q?/uK87gsOnuBANJws6KGhR2pFpMuoF/CIIM7U7V3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf162110-35ac-43a3-b2e3-08dbcab170a1
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2023 23:26:05.1614
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b70Wie/mlSaE/kYyKbXLwf44qrRmCQ+u7+A0wpwPfZeMO2l+d4iGPVqrLeXpTQfQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8488

Currently the SVA domain is a naked struct iommu_domain, allocate a struct
arm_smmu_domain instead.

This is necessary to be able to use the struct arm_master_domain
mechanism.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c   | 11 +++---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 34 +++++++++++--------
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  7 ++--
 3 files changed, 29 insertions(+), 23 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
index 042daaef0c9703..bc3cc51dffc2e7 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
@@ -669,14 +669,13 @@ static const struct iommu_domain_ops arm_smmu_sva_domain_ops = {
 	.free			= arm_smmu_sva_domain_free
 };
 
-struct iommu_domain *arm_smmu_sva_domain_alloc(void)
+struct iommu_domain *arm_smmu_sva_domain_alloc(unsigned type)
 {
-	struct iommu_domain *domain;
+	struct arm_smmu_domain *smmu_domain;
 
-	domain = kzalloc(sizeof(*domain), GFP_KERNEL);
-	if (!domain)
+	smmu_domain = arm_smmu_domain_alloc();
+	if (!smmu_domain)
 		return NULL;
-	domain->ops = &arm_smmu_sva_domain_ops;
 
-	return domain;
+	return &smmu_domain->domain;
 }
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 43e0c15432073f..08eac534cffd36 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2204,23 +2204,10 @@ static bool arm_smmu_capable(struct device *dev, enum iommu_cap cap)
 	}
 }
 
-static struct iommu_domain *arm_smmu_domain_alloc(unsigned type)
-{
-
-	if (type == IOMMU_DOMAIN_SVA)
-		return arm_smmu_sva_domain_alloc();
-	return NULL;
-}
-
-static struct iommu_domain *arm_smmu_domain_alloc_paging(struct device *dev)
+struct arm_smmu_domain *arm_smmu_domain_alloc(void)
 {
 	struct arm_smmu_domain *smmu_domain;
 
-	/*
-	 * Allocate the domain and initialise some of its data structures.
-	 * We can't really do anything meaningful until we've added a
-	 * master.
-	 */
 	smmu_domain = kzalloc(sizeof(*smmu_domain), GFP_KERNEL);
 	if (!smmu_domain)
 		return NULL;
@@ -2230,6 +2217,23 @@ static struct iommu_domain *arm_smmu_domain_alloc_paging(struct device *dev)
 	spin_lock_init(&smmu_domain->devices_lock);
 	INIT_LIST_HEAD(&smmu_domain->mmu_notifiers);
 
+	return smmu_domain;
+}
+
+static struct iommu_domain *arm_smmu_domain_alloc_paging(struct device *dev)
+{
+	struct arm_smmu_domain *smmu_domain;
+
+	smmu_domain = arm_smmu_domain_alloc();
+	if (!smmu_domain)
+		return NULL;
+
+	/*
+	 * Allocate the domain and initialise some of its data structures.
+	 * We can't really do anything meaningful until we've added a
+	 * master.
+	 */
+
 	if (dev) {
 		struct arm_smmu_master *master = dev_iommu_priv_get(dev);
 
@@ -3203,7 +3207,7 @@ static struct iommu_ops arm_smmu_ops = {
 	.identity_domain	= &arm_smmu_identity_domain,
 	.blocked_domain		= &arm_smmu_blocked_domain,
 	.capable		= arm_smmu_capable,
-	.domain_alloc		= arm_smmu_domain_alloc,
+	.domain_alloc		= arm_smmu_sva_domain_alloc,
 	.domain_alloc_paging    = arm_smmu_domain_alloc_paging,
 	.probe_device		= arm_smmu_probe_device,
 	.release_device		= arm_smmu_release_device,
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index ae8b2d8c7192f6..1f6d528d949fff 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -765,7 +765,8 @@ to_smmu_domain_safe(struct iommu_domain *domain)
 {
 	if (!domain)
 		return NULL;
-	if (domain->type & __IOMMU_DOMAIN_PAGING)
+	if (domain->type & __IOMMU_DOMAIN_PAGING ||
+	    domain->type == IOMMU_DOMAIN_SVA)
 		return to_smmu_domain(domain);
 	return NULL;
 }
@@ -773,6 +774,8 @@ to_smmu_domain_safe(struct iommu_domain *domain)
 extern struct xarray arm_smmu_asid_xa;
 extern struct mutex arm_smmu_asid_lock;
 
+struct arm_smmu_domain *arm_smmu_domain_alloc(void);
+
 void arm_smmu_clear_cd(struct arm_smmu_master *master, int ssid);
 struct arm_smmu_cd *arm_smmu_get_cd_ptr(struct arm_smmu_master *master,
 					u32 ssid);
@@ -805,7 +808,7 @@ int arm_smmu_master_enable_sva(struct arm_smmu_master *master);
 int arm_smmu_master_disable_sva(struct arm_smmu_master *master);
 bool arm_smmu_master_iopf_supported(struct arm_smmu_master *master);
 void arm_smmu_sva_notifier_synchronize(void);
-struct iommu_domain *arm_smmu_sva_domain_alloc(void);
+struct iommu_domain *arm_smmu_sva_domain_alloc(unsigned int type);
 void arm_smmu_sva_remove_dev_pasid(struct iommu_domain *domain,
 				   struct device *dev, ioasid_t id);
 #else /* CONFIG_ARM_SMMU_V3_SVA */
-- 
2.42.0

