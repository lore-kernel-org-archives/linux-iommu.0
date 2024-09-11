Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2059.outbound.protection.outlook.com [40.107.237.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C08D0185B6F
	for <iommu@lists.linux.dev>; Wed, 11 Sep 2024 10:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726050033; cv=fail; b=Y+JQvFnZNjpaR+z53pkW0DLYfMRFtH1JCJo43Nuj8mv+Aw9wjRSe8IgJLq/XA06geZFZ7DWVQ3+4JoJFyS3+fozC5LU0V/pJTjUktlePOLYxXdHks4qZ9JQZPrpy9vh0PlNWh9adkZi/GFcuhTvYXvF79oJQ/AS5BZSBDCVMddQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726050033; c=relaxed/simple;
	bh=8hdzHT6HtD4UxM/nitXsIsRGF6vNec2KnZ7SsS3GLrI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q2+VShTbhAgRGfh5UCmcv9wRy4bD6J7sjh9sFVDLLFTuIup8pJf9VZY4jS3L8RmuC7VPv+tj/Xfebo+tBXolSMgL+vcPE05OJiWoUzELCE+A7TiAU/+7EBT4R1sErTHD3dY2fyH7+YXE3WflNODHqDBeEG4qjghYaGzaviNkrIw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=rvW8o5ZW; arc=fail smtp.client-ip=40.107.237.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="rvW8o5ZW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qrgq7VhE7rfiVgsT4rhjPSzxjaeCZsJGl2DHzlrlhDLXcxSil2B5678XTaVXasYIwdhe7QE/7RfKSxGVuIzK9ZhSI8VvneDULQy5ouTSRe7DQYcuvldt7IqgyXQ/ZBuEfpnfgVU1i+a8zr3pE95q6xQNzqvsO/uKaXyy2LZQNDWI5lWdvxmZxtGygJQWdr6rBJZKb8Ml1Wuh1yb3oQ5NfLzBf8lUF6p9LfzgJKN98xDK5PYiR9dAVri+6N+EpAtM1EZH1+pGP12dHv3oj0lODD0MPvgMogtSdtdM5v5kitUjG7ozr07XR5rQxzXNRXyj2mlg7WULPniRE8+O6Zlmtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I+iQ9xBi1s8fEubv66e+CK7G4+Qna6hZrSc8zvnbWfg=;
 b=RrW7dfoT0TOEQfzZN0Rkz29tDAMbZcXg2uVgk5RmdeJ92Vhp32+QOEn7UEBbAiLMvOO7YXnH+CNY9cvq4RX8Z/BJGwrYxog9Np7icgSV9c1KQMHnm28pAKVqCcuWURn7T/34YxSqZdF1Z/5yyyeeQEe7uH6pyplc87ReXD/JFFt67neRL8QeCA5A3PP0eQIdrM8Q0eAc9iJKlzY2kqlHtKGg4qKgq4EZAIWDJvuvFTWrnaDGcZQf0FIVkLjkFHQ7d22SS/hOVOTQrcAxwdr5QvDOYvcHjiaGqK0zcqWdXi768ObkE+XJednuHXyNMKlbvC7b+uV/s3m8v6vywuht4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I+iQ9xBi1s8fEubv66e+CK7G4+Qna6hZrSc8zvnbWfg=;
 b=rvW8o5ZWTHYIxRXKMLkXdB8JYef+tIAuiK4dj5hMGo7Gbks9ufglpwE81ZOjUEZiAd6K1TMW30BIq0PCB6l5p0O6RToXRD4ViYIzUJGDp1Q+Se4j+PW3d0SnYNRwx+fF3U/mJVNzhvPDhwI/27iBfVTN6Hke/YNST0cJmCNRcvQ=
Received: from CH2PR03CA0019.namprd03.prod.outlook.com (2603:10b6:610:59::29)
 by PH8PR12MB7232.namprd12.prod.outlook.com (2603:10b6:510:224::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.17; Wed, 11 Sep
 2024 10:20:25 +0000
Received: from CH2PEPF0000013D.namprd02.prod.outlook.com
 (2603:10b6:610:59:cafe::aa) by CH2PR03CA0019.outlook.office365.com
 (2603:10b6:610:59::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.26 via Frontend
 Transport; Wed, 11 Sep 2024 10:20:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000013D.mail.protection.outlook.com (10.167.244.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Wed, 11 Sep 2024 10:20:24 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 11 Sep
 2024 05:20:21 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <will@kernel.org>, <robin.murphy@arm.com>,
	<suravee.suthikulpanit@amd.com>, <jgg@ziepe.ca>, <yi.l.liu@intel.com>,
	<baolu.lu@linux.intel.com>, <kevin.tian@intel.com>,
	<jacob.pan@linux.microsoft.com>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v2 2/8] iommu: Introduce iommu_paging_domain_alloc_flags()
Date: Wed, 11 Sep 2024 10:19:05 +0000
Message-ID: <20240911101911.6269-3-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240911101911.6269-1-vasant.hegde@amd.com>
References: <20240911101911.6269-1-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013D:EE_|PH8PR12MB7232:EE_
X-MS-Office365-Filtering-Correlation-Id: a65dd545-b7bd-4cf8-c16b-08dcd24b59ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OV0EzLyT5aPWoFo2g4/By5cUNU6kc6ms2TwY9iQ6j8jdl0KTT2OsA9uKvgqD?=
 =?us-ascii?Q?ewi1hDxr7bNxwn5Btds4xZ41VllIH2dY/qZuZz9WBoNHUyXTrhm6NO/fzWPF?=
 =?us-ascii?Q?0NXDV5HbIOLCEC06XNxcmGb22J+jo7thoo+VvUZEszju2s7jEmyS4HPT+Zyr?=
 =?us-ascii?Q?V6ljDj+5qGYgCDHpwcVxVafw9xo4ApgncdD3nfDFff0UVHN9yZgPBbZ6zMB+?=
 =?us-ascii?Q?j7qOIZSGuFTdLTsyXd+CXhToYDOpF/5FmXWpVq0ZOUf37g27VQRQ6iA4SNAk?=
 =?us-ascii?Q?5OyJsaaCXqAaNFlQjhqSkegfoVI3l0RXj1v1YdBzIhe10YOpLEiLAOess6MH?=
 =?us-ascii?Q?B05kYlXKlS/mO+ZJ8UXaXSrJKB4p8PjtM3+24R7SKP9ImvoTKT1yG5aXbhmH?=
 =?us-ascii?Q?LAPcW782M3sS/IMUurFmDGT9iPWRRRRVH0ByE0kKmiI1Dyaory4+Teq/d5il?=
 =?us-ascii?Q?gdyagCJDEscnNhGdOokcTicMXa+DHg1+XifqaNWY7IDmBAU6r40m4mRnyfKz?=
 =?us-ascii?Q?ZCzpCnQW/4QmKcEKtQpjmhuQ+4JCd13rqdx7F8XD/rE+mIkvauKoO61b8Smx?=
 =?us-ascii?Q?AMYv7l2XY8DfDImkAkkTheqE3ZnwpdP6TycUAzseTuOy8k2rSxomxw5CBgRo?=
 =?us-ascii?Q?6naJtNnAGLWKCQPgxfMfXQTYWAlpTGdjhjidXlraHTxNHLS83j91OhMii1kX?=
 =?us-ascii?Q?8XlrQCB0A2HHYp6EQ8/64TEvZaYMSx56dKFAk12bDh7EdPb7vfgFVkYIf2z/?=
 =?us-ascii?Q?U0cqlpcACoOhkMku0qQnfDILhemUZ68Rc3vs7pQcFVJYfrODozwbQKVPmuMx?=
 =?us-ascii?Q?3aUv7/y6H/e882LLxWZyGvD0T1Elb2Dx7S8iPaEXZKg5ljxHKTBCWgGRInvT?=
 =?us-ascii?Q?cOoVlIDcrovpcpgt7rKUfJ7SdxdX4dg3FSrD1qgt4YlNj0775ZT/BuVT1Dbz?=
 =?us-ascii?Q?QVpvVkohgmmqVSbYFbiNz2jLf2dnLRyWj/PE4ys/qo8ts/mQ5EI+xuZqAC7i?=
 =?us-ascii?Q?lEq7sYfQ3g1fbcxI93D1Ok3wftOthRRJwX6HdF836sXMkxWb3hHYnB0qcsS2?=
 =?us-ascii?Q?mqPo/BFHXggLzmVn1UCrzuytqXQ7x6xG2MIiibFIV9qxMBqmj8B4FZpNKNLr?=
 =?us-ascii?Q?2Lf+2n0Cg8qyy634NkniAiyQBFggPIvg9PVaGcQaxE6RjjUd/c4xZMW56MrS?=
 =?us-ascii?Q?4oaYq+uhhSLVjb80DptHtVwnwdqIbrSG7z/pXMfCP97YyWojBepDHK3TKAVo?=
 =?us-ascii?Q?H5wjqxdkyDWsEI7F8RqN0+eG0qN3TUSlwZZpOb+cCG286ZM38XWuSTBE1i+g?=
 =?us-ascii?Q?KSv+y6y5oEvkkQQgCmrm4MsKw9bFdv5rZVC0dBCaw7FdeJt/fkJ+x3cvwZwG?=
 =?us-ascii?Q?luUeVGviGA0WBRIKrxX5TbSQlD33qT5uvjwd7QE2Tc/hDSnpcQF7WfXvPyZe?=
 =?us-ascii?Q?FFWXSIZrBSd+GrXDH23BdgBQOhR0jHzp?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2024 10:20:24.7548
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a65dd545-b7bd-4cf8-c16b-08dcd24b59ac
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000013D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7232

From: Jason Gunthorpe <jgg@ziepe.ca>

Currently drivers calls iommu_paging_domain_alloc(dev) to get an
UNMANAGED domain. This is not sufficient to support PASID with
UNMANAGED domain as some HW like AMD requires certain page table type
to support PASIDs.

Also domain_alloc_paging() passes device as param for domain
allocation. This is not sufficient for AMD driver to decide the right
page table.

Hence add iommu_paging_domain_alloc_flags() API which takes flags as
parameter. Driver can pass additional parameter to indicate type of
domain required, etc. iommu_paging_domain_alloc_flags() internally calls
appropriate callback function to allocate a domain.

Signed-off-by: Jason Gunthorpe <jgg@ziepe.ca>
[Added description - Vasant]
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/iommu.c | 30 ++++++++++++++++++++++++++----
 include/linux/iommu.h | 16 +++++++++++++---
 2 files changed, 39 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 4118d3b15310..5d1cef36f633 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -2027,20 +2027,42 @@ struct iommu_domain *iommu_domain_alloc(const struct bus_type *bus)
 EXPORT_SYMBOL_GPL(iommu_domain_alloc);
 
 /**
- * iommu_paging_domain_alloc() - Allocate a paging domain
+ * iommu_paging_domain_alloc_flags() - Allocate a paging domain
  * @dev: device for which the domain is allocated
+ * @flags: Bitmap of iommufd_hwpt_alloc_flags
  *
  * Allocate a paging domain which will be managed by a kernel driver. Return
  * allocated domain if successful, or a ERR pointer for failure.
  */
-struct iommu_domain *iommu_paging_domain_alloc(struct device *dev)
+struct iommu_domain *iommu_paging_domain_alloc_flags(struct device *dev,
+						     unsigned int flags)
 {
+	const struct iommu_ops *ops;
+	struct iommu_domain *domain;
+
 	if (!dev_has_iommu(dev))
 		return ERR_PTR(-ENODEV);
 
-	return __iommu_domain_alloc(dev_iommu_ops(dev), dev, IOMMU_DOMAIN_UNMANAGED);
+	ops = dev_iommu_ops(dev);
+
+	if (ops->domain_alloc_paging && !flags)
+		domain = ops->domain_alloc_paging(dev);
+	else if (ops->domain_alloc_user)
+		domain = ops->domain_alloc_user(dev, flags, NULL, NULL);
+	else if (ops->domain_alloc && !flags)
+		domain = ops->domain_alloc(IOMMU_DOMAIN_UNMANAGED);
+	else
+		return ERR_PTR(-EOPNOTSUPP);
+
+	if (IS_ERR(domain))
+		return domain;
+	if (!domain)
+		return ERR_PTR(-ENOMEM);
+
+	iommu_domain_init(domain, IOMMU_DOMAIN_UNMANAGED, ops);
+	return domain;
 }
-EXPORT_SYMBOL_GPL(iommu_paging_domain_alloc);
+EXPORT_SYMBOL_GPL(iommu_paging_domain_alloc_flags);
 
 void iommu_domain_free(struct iommu_domain *domain)
 {
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index bd722f473635..907957a88470 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -511,8 +511,8 @@ static inline int __iommu_copy_struct_from_user_array(
  *                the caller iommu_domain_alloc() returns.
  * @domain_alloc_user: Allocate an iommu domain corresponding to the input
  *                     parameters as defined in include/uapi/linux/iommufd.h.
- *                     Unlike @domain_alloc, it is called only by IOMMUFD and
- *                     must fully initialize the new domain before return.
+ *                     Unlike @domain_alloc, it must fully initialize the new
+ *                     domain before return.
  *                     Upon success, if the @user_data is valid and the @parent
  *                     points to a kernel-managed domain, the new domain must be
  *                     IOMMU_DOMAIN_NESTED type; otherwise, the @parent must be
@@ -789,7 +789,11 @@ extern bool iommu_present(const struct bus_type *bus);
 extern bool device_iommu_capable(struct device *dev, enum iommu_cap cap);
 extern bool iommu_group_has_isolated_msi(struct iommu_group *group);
 extern struct iommu_domain *iommu_domain_alloc(const struct bus_type *bus);
-struct iommu_domain *iommu_paging_domain_alloc(struct device *dev);
+struct iommu_domain *iommu_paging_domain_alloc_flags(struct device *dev, unsigned int flags);
+static inline struct iommu_domain *iommu_paging_domain_alloc(struct device *dev)
+{
+	return iommu_paging_domain_alloc_flags(dev, 0);
+}
 extern void iommu_domain_free(struct iommu_domain *domain);
 extern int iommu_attach_device(struct iommu_domain *domain,
 			       struct device *dev);
@@ -1096,6 +1100,12 @@ static inline struct iommu_domain *iommu_domain_alloc(const struct bus_type *bus
 	return NULL;
 }
 
+struct inline iommu_domain *iommu_paging_domain_alloc_flags(struct device *dev,
+							    unsigned int flags)
+{
+	return ERR_PTR(-ENODEV);
+}
+
 static inline struct iommu_domain *iommu_paging_domain_alloc(struct device *dev)
 {
 	return ERR_PTR(-ENODEV);
-- 
2.31.1

