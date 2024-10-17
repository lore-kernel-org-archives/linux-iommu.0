Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2040.outbound.protection.outlook.com [40.107.243.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD1911DE2CB
	for <iommu@lists.linux.dev>; Thu, 17 Oct 2024 14:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729173939; cv=fail; b=b8ADsrw3lCXk8YVSE/li3CMlpcNpG4FkUAwi4B/7vpYDiFy6OuIwCPHjyt0Lw8X3Nz81R8LE6hWF1T/g8M6zoHYdoQgKZfLh4wJumjr/howRw2+cgKfst08pRhUoqJK9t1mBKJf1FffF1aR0zH3zg1QuLNCLnU6FRlPkKRVF3lQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729173939; c=relaxed/simple;
	bh=TBPLOIj04B4vZbNRurVkryq4inhPbZRJ6FQ673zANps=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gcwqf/NOjFFReHC8tdZROPyKrbXCu4TxgrKCvwRNxWa5sXQYjUUkes9g2UTcxZSYOijdAUVZJDKL8g4wDyB7wxze+Wy6a8KYbNjq+s3OE4LGti9xctwwagBoYBhwr7lFUMgX+AiVI6/MxNRuZVLb+sAsLxcoJolC+fU5wAaEA6U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=3hKGAFNQ; arc=fail smtp.client-ip=40.107.243.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="3hKGAFNQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KafBmBHZTHl6ZtYTd7reTBJt9uASWMf/SGqaclWgH71SnpvrgVwiyO/aGuGJCphRFL5AGJpCVCLl9iQaDVNOhYhEcrhObPsDU7JaW9JL6IsMaDp3MMT06efOtrcnjvVXswH8VSKDoA5kNrSRbxfeankQI/lscmDNkkng2Sg8S3eV1sVz6b7QI+47fgmOpQwFMrnNh8iv9mFpoYugV94P+XhXyziSu7EGJT8RMhN6JlzU+eii54NSG80gyAoIExiedCJJzKJ/AW6j9i7Nc4MieOa0JnymOeSUEsmLMj+lbmptLC385np46YioeOi0yfW6MjzmEPjyEUkVtwstnXp1Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OLLg40XxPAXBla1Fc36XbgG1olEDGhEJZm2bxP0A/go=;
 b=pMzj55ORxzQfM1FNYuJOdDt+TJQJrtymBdcr3LQRQNzHlKOrjHXC3ePP7QgaVtiC4OGL7poRhqk0Zm2wopm58Vqn/T5ukQngB9bJEIBxYRUka78jf3njY23mZsEjRZ26tTikCu0EYqWC1nNT4necAp6bvYfl9Q+ck9Rf9qzvtRArd4hKBapxEWVi/JhjkkbZtCPY8iSW6mM72OyTdd1Wv6QDotVDER9nWolsOfiVi+E6pmHQ4PVFaTtE41VFy9O42N+C4bOYnAeyO9tyhbleL/rTq8GrS5/SjpOaEh+b309v4G/TC3RFf8iEzxZ9jJnu+3KBXHyjaCpzJv0t8gGgVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OLLg40XxPAXBla1Fc36XbgG1olEDGhEJZm2bxP0A/go=;
 b=3hKGAFNQEZ1eqSjoMyS/9TqyoDZ9yIZJmXOVL+5AvtAaVDSp2J7zkpS/aHxGTxf/dx2VlbSfFKijMPfFT7zanamF+oqRBbZcvYq3HuPAxvgoUziwXLs2s/Fs/agfB2PvpfOi3lxpCy2x9p7SKq64Q4kQEZTODHeES78aVmmEhC4=
Received: from CH2PR14CA0052.namprd14.prod.outlook.com (2603:10b6:610:56::32)
 by CYYPR12MB8962.namprd12.prod.outlook.com (2603:10b6:930:c4::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.17; Thu, 17 Oct
 2024 14:05:30 +0000
Received: from CH1PEPF0000A346.namprd04.prod.outlook.com
 (2603:10b6:610:56:cafe::40) by CH2PR14CA0052.outlook.office365.com
 (2603:10b6:610:56::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.21 via Frontend
 Transport; Thu, 17 Oct 2024 14:05:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000A346.mail.protection.outlook.com (10.167.244.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8069.17 via Frontend Transport; Thu, 17 Oct 2024 14:05:29 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 17 Oct
 2024 09:05:16 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <will@kernel.org>, <robin.murphy@arm.com>,
	<suravee.suthikulpanit@amd.com>, <jgg@ziepe.ca>, <yi.l.liu@intel.com>,
	<baolu.lu@linux.intel.com>, <kevin.tian@intel.com>,
	<jacob.pan@linux.microsoft.com>, Jason Gunthorpe <jgg@nvidia.com>, "Vasant
 Hegde" <vasant.hegde@amd.com>
Subject: [PATCH v3 12/12] iommu: Create __iommu_alloc_identity_domain()
Date: Thu, 17 Oct 2024 14:01:37 +0000
Message-ID: <20241017140137.6028-13-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241017140137.6028-1-vasant.hegde@amd.com>
References: <20241017140137.6028-1-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A346:EE_|CYYPR12MB8962:EE_
X-MS-Office365-Filtering-Correlation-Id: e0b8c535-c9bd-4dfe-afd3-08dceeb4c240
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QafoZisnv3h0uUnZ4tkpvuLRA+BDwx5+C1dIW9cuXI7okURK5zsjA2MZ1h/I?=
 =?us-ascii?Q?tRWEB2FRSPlsxVSTogPgOPPxPa9Pex0wV92ENzBK4HpFR2tUr8VDtYS7jNS7?=
 =?us-ascii?Q?qaaMU28oqPsDdVKaz3+bUG0vFA2elmkT+z28ElYt/ArYiHkVpmzUL12k3J0K?=
 =?us-ascii?Q?dqXtSCCJ2i5oDioSLBTBMmzKT3pW381AZodk2ecR4OJcU21EUeX2ttCN7Wmt?=
 =?us-ascii?Q?eZAotL1b2vAiFyVFBAPc63xvZqOQN0VvVh8ewIv/NIzVEXDDHqKuGN4bSAjK?=
 =?us-ascii?Q?STZSc1MCHYORUAdX7eIxkQQ5bJX8QHJvfULq2q7XekVxQsrcJmYaZIbXCGBK?=
 =?us-ascii?Q?h8hQGbu1CcGKHsMXBch585UNA/UJD2TxpiBw0SGpWms9HqkOH+fc13sp1S8B?=
 =?us-ascii?Q?+osELNCjfqnqwC4zR0HRIZfKVchGl11aYvnC26KbvAfbiekPnOisDceUjQOB?=
 =?us-ascii?Q?/CUz/QLstFBGR6EFXZKdowWNmxMi8/NE96FFMYQv67OTzFkWPknotodguY3Q?=
 =?us-ascii?Q?weMLwZ0P/zv79/xkElfL0cJl+jrj0z+nyRDpY1AE6a+RlwIO4x4AzLhAbuzZ?=
 =?us-ascii?Q?oSWoDw2hLQZmclQvg4Z1iBQrA7c7dPuWmKpu19CskG7buasbwMLYFC6g31CM?=
 =?us-ascii?Q?F7h9uPZJm6yg88E8fezeIbYlZ8WuCZ/VWqrSiaAUJn12hOnmascH1+H/RO1j?=
 =?us-ascii?Q?llzP1ZN812AdWyr7sJ6b6XbQnuvQpDbEXNeM47P1XuM3GtouU9cZMyyb6W5r?=
 =?us-ascii?Q?Yornem982fDva7IpkDYHsWf+QqLl+klWu9ZS2FTNV8IFVtZaOSQqbfMJ8VPz?=
 =?us-ascii?Q?4i2dW25GR5nwg4ErbPRhn+0OIX4lT15vS95zWxuL0r9mE2TAcstMo/JsGXE0?=
 =?us-ascii?Q?ZB3pTaEn6aK+PVeWLOfP66AOOJl/JJj7ooDPwkstMlkF94T9EsAfOzM2CVXr?=
 =?us-ascii?Q?ksBk5UdcV4Fq0OhwP1Ec0fKXKq4p5sX73bljlMTMsrYb0+ec8DsbmM0WwXTZ?=
 =?us-ascii?Q?Ywq24KXbydDkBxqRovEWCnkMJzAMY0vN8SFuh1Lwd4cnssQZqQs7X8GNQv4N?=
 =?us-ascii?Q?+/dZ4rvmpm0wVm4/mkWYotBbJi7NExYqI6KBw0Zz6s99SkXDi1EokfeKGfjw?=
 =?us-ascii?Q?wEXINlsJYWo05P6ZfVyCFP5pfR20uEK/WVAl+MHaT48T4kI+jTIEaMxzHGpa?=
 =?us-ascii?Q?/utqlVI6jwdWsnc9I2xNN4O21Roj6Ba25hmqVVyh+ixHQwIfihwbT9MosH7d?=
 =?us-ascii?Q?I6rnwIrlVbuPsqJ0RMWqEV5FCRAfhfAug2hA8IO3zINkIzO6wcLN950f59ZO?=
 =?us-ascii?Q?gmLNSRrI11vwLwrVayUeUDGiwwNP8jGdfXGJMtahqRLp4whQ4Z3Esv7kpZiM?=
 =?us-ascii?Q?beWiYIiGBZY8aFgD7t0to1ObY8UBCqBImbB5gGcZCGXKrSWzng=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 14:05:29.9529
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e0b8c535-c9bd-4dfe-afd3-08dceeb4c240
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A346.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8962

From: Jason Gunthorpe <jgg@nvidia.com>

Consolidate all the code to create an IDENTITY domain into one
function. This the legacy __iommu_domain_alloc() path from all core code
paths, and preps it for final removal.

BLOCKED/IDENTITY/PAGING are now always allocated via a type specific
function.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/iommu.c | 43 ++++++++++++++++++++++++++++---------------
 1 file changed, 28 insertions(+), 15 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index a007fdfd2fee..dfb573d8f213 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -94,8 +94,6 @@ static const char * const iommu_group_resv_type_string[] = {
 static int iommu_bus_notifier(struct notifier_block *nb,
 			      unsigned long action, void *data);
 static void iommu_release_device(struct device *dev);
-static struct iommu_domain *
-__iommu_group_domain_alloc(struct iommu_group *group, unsigned int type);
 static int __iommu_attach_device(struct iommu_domain *domain,
 				 struct device *dev);
 static int __iommu_attach_group(struct iommu_domain *domain,
@@ -137,6 +135,8 @@ static struct group_device *iommu_group_alloc_device(struct iommu_group *group,
 						     struct device *dev);
 static void __iommu_group_free_device(struct iommu_group *group,
 				      struct group_device *grp_dev);
+static void iommu_domain_init(struct iommu_domain *domain, unsigned int type,
+			      const struct iommu_ops *ops);
 
 #define IOMMU_GROUP_ATTR(_name, _mode, _show, _store)		\
 struct iommu_group_attribute iommu_group_attr_##_name =		\
@@ -1590,6 +1590,28 @@ struct iommu_group *fsl_mc_device_group(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(fsl_mc_device_group);
 
+static struct iommu_domain *__iommu_alloc_identity_domain(struct device *dev)
+{
+	const struct iommu_ops *ops = dev_iommu_ops(dev);
+	struct iommu_domain *domain;
+
+	if (ops->identity_domain)
+		return ops->identity_domain;
+
+	/* Older drivers create the identity domain via */
+	if (!ops->domain_alloc)
+		return ERR_PTR(-EOPNOTSUPP);
+
+	domain = ops->domain_alloc(IOMMU_DOMAIN_IDENTITY);
+	if (IS_ERR(domain))
+		return domain;
+	if (!domain)
+		return ERR_PTR(-ENOMEM);
+
+	iommu_domain_init(domain, IOMMU_DOMAIN_IDENTITY, ops);
+	return domain;
+}
+
 static struct iommu_domain *
 __iommu_group_alloc_default_domain(struct iommu_group *group, int req_type)
 {
@@ -1605,8 +1627,9 @@ __iommu_group_alloc_default_domain(struct iommu_group *group, int req_type)
 	if (req_type & __IOMMU_DOMAIN_PAGING)
 		return __iommu_paging_domain_alloc_flags(dev, req_type,
 				dev->iommu->max_pasids ? IOMMU_HWPT_ALLOC_PASID : 0);
-
-	return __iommu_group_domain_alloc(group, req_type);
+	if (req_type == IOMMU_DOMAIN_IDENTITY)
+		return __iommu_alloc_identity_domain(dev);
+	return ERR_PTR(-EINVAL);
 }
 
 /*
@@ -1972,9 +1995,7 @@ static struct iommu_domain *__iommu_domain_alloc(const struct iommu_ops *ops,
 	struct iommu_domain *domain;
 	unsigned int alloc_type = type & IOMMU_DOMAIN_ALLOC_FLAGS;
 
-	if (alloc_type == IOMMU_DOMAIN_IDENTITY && ops->identity_domain)
-		return ops->identity_domain;
-	else if (type & __IOMMU_DOMAIN_PAGING && ops->domain_alloc_paging)
+	if (type & __IOMMU_DOMAIN_PAGING && ops->domain_alloc_paging)
 		domain = ops->domain_alloc_paging(dev);
 	else if (ops->domain_alloc)
 		domain = ops->domain_alloc(alloc_type);
@@ -1995,14 +2016,6 @@ static struct iommu_domain *__iommu_domain_alloc(const struct iommu_ops *ops,
 	return domain;
 }
 
-static struct iommu_domain *
-__iommu_group_domain_alloc(struct iommu_group *group, unsigned int type)
-{
-	struct device *dev = iommu_group_first_dev(group);
-
-	return __iommu_domain_alloc(dev_iommu_ops(dev), dev, type);
-}
-
 static int __iommu_domain_alloc_dev(struct device *dev, void *data)
 {
 	const struct iommu_ops **ops = data;
-- 
2.31.1

