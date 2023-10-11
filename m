Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2086.outbound.protection.outlook.com [40.107.102.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D898803
	for <iommu@lists.linux.dev>; Wed, 11 Oct 2023 00:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rvkjAa64"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WCn7+0jBN63hsa1TMTLy6U+g4v4QqUe/uqP+ep8z1k+ZNlzNbocCeeoKH9iXMtFOBlf0owsECUS2QrJT9a02H6HvDsa1uct90iuLyfpJNnbxWtO5+JRg0QQgsDQSCFhTEGj4QvWY2JQQ3ouyTs8l8I+lMCeowdK88qoZ4KnhP6Qnvx2Gn7rRMf0dzIDgrbq7Vb2EuMMLMv2Pcpfgi5w2PCSEcjE8HoWyloOZxkHyjHJf47EjwrhSdd/ovf+3ENlk6XJfzVJ9d0R79+fk+MPO8IkQ2QN+/yHBmWFvraRLOEf0BJtUa6vZOJqD6rRP9ok77TTzcETaH7Z1NisFYh4w+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jZd7R7J2PzBAsBBgvft5UKof3LboQwE45ppu9LD7xx8=;
 b=P/7n7BdEKIOBXbaqgQEk5mmSVdj7X4Ll9h+kHqtbSvg49lPm/QPY2BlQXQUvW50Xq7C82utRJjatF/h1wpMt40xN3pDka8sQgAorxzNxmnPINrFSy5CslSVAlMoCqun2ic5QDYG0ekXdCgtixxks/GjOLQfzv/QElB1wF92l9k2ovXBqp89y9FV0sKLZZB7V82Y2zNiOCzqhhP23V4FKLhfksbVlOQ5y2F3Ygw7Q6U7kCFVqbhBxN44HTYaTyIYgjHSl3T/p9OnRYCf6fTr7sCZY75vkcivNihYI4Csu977aeMS3v0OO3Emh6n1jnOAXsGP9+iMf+3Avdy39GxWaKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jZd7R7J2PzBAsBBgvft5UKof3LboQwE45ppu9LD7xx8=;
 b=rvkjAa64KiRSXu+0eFVq+IXRe4rjwqWeKeJTIySmHzBZ6yUBrERw9qQDx68wfHGrgfW7Q35heb+RKHImwbavZIWozHHDRq+2twxQ50BAONA6tVN5pbI5l7E6wfeRCazcYDnl2cwadevNw5uLUT1//c3e586pft7p5Fso6JEY21ix2JQ6lwQthn6KK61yoP6SildHW2GMSILEHVKFNMnwzHQdh1hRgimfwDAsjbreaWCGO04gXRnOy/sFtq68t9CM4rCwcXkK0k4q7KPBHeb3EUf9gerzSECMTWarzU6VdyMC1/UOn2D7+9F2udfOLJhsI3AS8nmrhdVW6RrGLGa+ag==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by IA1PR12MB6625.namprd12.prod.outlook.com (2603:10b6:208:3a3::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.42; Wed, 11 Oct
 2023 00:33:31 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2%6]) with mapi id 15.20.6863.032; Wed, 11 Oct 2023
 00:33:30 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>,
	linux-arm-kernel@lists.infradead.org,
	Robin Murphy <robin.murphy@arm.com>,
	Will Deacon <will@kernel.org>
Cc: Michael Shavit <mshavit@google.com>,
	Nicolin Chen <nicolinc@nvidia.com>
Subject: [PATCH 13/19] iommu/arm-smmu-v3: Pass smmu_domain to arm_enable/disable_ats()
Date: Tue, 10 Oct 2023 21:33:19 -0300
Message-ID: <13-v1-e289ca9121be+2be-smmuv3_newapi_p1_jgg@nvidia.com>
In-Reply-To: <0-v1-e289ca9121be+2be-smmuv3_newapi_p1_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR18CA0023.namprd18.prod.outlook.com
 (2603:10b6:208:23c::28) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|IA1PR12MB6625:EE_
X-MS-Office365-Filtering-Correlation-Id: af7bda9e-f432-42ea-0a63-08dbc9f1af6c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	AZo1fjaRDWWOeXlUocvHoPmSw941xPCs6G7oif+VhVSIQKRsT8FbxyN04Q+Hah+6Cj5/bmUufAYTeWRVz05+ljWY+s4EtkcWjbsRZiiezwQOEwlL3GhrJJMVWtnveI7Fao7M34jC/zoS8ZWgfqVLT3SoCkoA9cosfxYc7l3PMLAJ6pNMcMout5jBEbv65iq7jyZBZZrB59gFJR6RGa89/zoHCj2OYc8xd0I34Tc/i3Rap9x9VEwzY0SWFllniUzSIwsoGTbLCqJQsk3EU9p6lufTVPy7MpdfDjfM5YI35AfIMEREc54X3jdMWu4z+rAUr9OF4ltNYLHMx7+Ne15UBD+DkZnVXuwNKNBzwfO6+QTAp9h5agyJiHvNLpeTTYhbsRTyXFjv42OB6k1wMH9dIFulYH9Y8BVy7mZJ/RToYFFoGyJdGGG4CbEEZ3OSj3isxH6mazuuVh+JW0E3UqzwaLHJnh52txkbB7vEdaY756qGarSpc/iYrtguTJVdR55CV8DR3tG37SKFUDNXn/sXNlDe05Qg3C8j6phblPd3IlFeWsuHSwF6r5EK7OBQZOyy
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(376002)(346002)(39860400002)(136003)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(107886003)(6512007)(36756003)(38100700002)(86362001)(26005)(83380400001)(2906002)(6666004)(2616005)(6506007)(478600001)(6486002)(8936002)(8676002)(4326008)(316002)(41300700001)(110136005)(66946007)(66556008)(66476007)(54906003)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HcC807ZwXtDwXU0lsxz/ogCLSdMTBPB0vNBum4EZDXf7yPZtKNiwVRoN82jk?=
 =?us-ascii?Q?wv9+Jvxfem/jbmr1XFyWJTeoHK7XgYENDRrSMjxsceOeovFoEArPfnsDz9Ux?=
 =?us-ascii?Q?xjvVst5hjt0LuW36t0MbCdxkDMhnO+rlvNXHRjO9o9VvVRsMc0QrIBz7iJt/?=
 =?us-ascii?Q?o5HqkJ1qxua2C0gjPX0XgkclQoMGh7axFbJSpXxjaNv2zQv82to0ouLanIUq?=
 =?us-ascii?Q?c4eLORBuhbCOywEILE+i7amoQ5EIhCd78wC6bZ6wFAy2wZIvsY2IbZUmp6cy?=
 =?us-ascii?Q?d0tJ7MwJRCyYCHNOBjiFGtt7ZGuMdYYmp08F3HuQYBc08fX5GMQEMe7yaqTY?=
 =?us-ascii?Q?o1lF+S89YDgqBpHiHxkAFPj2Ay0rJaYLk0xOxBjQRW/P/V9XsPOfIHGvUp77?=
 =?us-ascii?Q?dDbRwSZqHVO1560DooeRy31a12EIPwUaX+NXQYBvnzMLQb4iOOve62YH6jne?=
 =?us-ascii?Q?Z+A0IFqc9L/bBBfez62goQWSWrmItp1ZUagGAABxMhqTWdtkua3fOHPadjnD?=
 =?us-ascii?Q?lqMpHdgNFet+F5RGrrzLd4bM+u0QXWD7u5ZkCMHlUnRS14ijPdvtWpSJw4nu?=
 =?us-ascii?Q?dAg5KR+Y86VivTRWQCvs94sy5uqM9E4Ql6NQ5n01wxJRKSkOy1FUcdEJ+7iX?=
 =?us-ascii?Q?NUjackChlDn8u5lxe9UFdXtR5kK8Pm1wf9nFchfy4B2bGyZyQXQgyi2Bz1KW?=
 =?us-ascii?Q?cPW74YXxV+SCSpsNwsVDkQk0fsMlB55OX1U351SDQoqBga3nPGkSQ32CCBcs?=
 =?us-ascii?Q?jwXhuSJFp9XvasxbOrdSoggozHONFmbqe2pki+M0iLxtI0IEmHlxYiN7mIl+?=
 =?us-ascii?Q?ZYE4ZIWYQSI//eWgCxktNH4WVls5Feq3dgJ5J9k2Cz4Qcinlie8c2qY1gdO9?=
 =?us-ascii?Q?+vgvmgU0FAGp5UP6mp8V9xqZy/ZYAB+EG6OVyuixYKVx3EUdqUwIokRI3Q4q?=
 =?us-ascii?Q?65YKpat7V7IitdDKepbqotTHr1YGRRKYLVeP9uyFu1QAuy4oWGfrBq6dRRi6?=
 =?us-ascii?Q?BK9/4zz6NdyapRMAjIKauYwzd+58YbS/DtNBd5qAjQVk7O0cY+XFflZb46b+?=
 =?us-ascii?Q?rVeghiXOCh2mNEVHbOJsG7Wa4digIpkmp2cYPpG9/Iq0CIG7/ijO6uPeCzrz?=
 =?us-ascii?Q?5njK4NtChhg4/bCX1uOKcfaaIw2iOVeZ2I2lJ5hTkH8xaoWLfNFzd1cEQD1W?=
 =?us-ascii?Q?Y2Q1h0E0IVXAUv/Znvp/X8cG6cXIV5qrE2dOm8pkbkVPzBqhmN/9zZqbIMbB?=
 =?us-ascii?Q?T/LfPwBxxMNVgAEwGz5LRo5aL0Q8/5KY0UHqpsxAaSBezkij1ecV3sA8sg9y?=
 =?us-ascii?Q?A5NPYiJgLW280Wsl3aC5Lm96aWi1w61fkXL29tYZt4GgeN3JMgI1U2u3BX+n?=
 =?us-ascii?Q?kJbRbXhNB0SWP8g3DNSboGUftirmjSJkd1YjAPfaYlSvWxaGAl3HaeJ8KFNM?=
 =?us-ascii?Q?ZcB7Cc2Xk20OQp8Z48JqlkUjlnxF5KuSKa1pRP4m0O8Vc8wReheNL9z8P7hq?=
 =?us-ascii?Q?3qqfKj9pDaawgr8/hcueUgHvsitvk+bxvqiIZJN8GE2Iy7gjIY80JPnXP7MY?=
 =?us-ascii?Q?FGeo3ny1/iJy3euGVvhHkcyGy1gpRMwT3WXxsjPm?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af7bda9e-f432-42ea-0a63-08dbc9f1af6c
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2023 00:33:27.1913
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HdtRaUDczXEZwCj9unT2w60w6WxjtpaLOS8OdSLWgdNmeUJ8Zi40EmpyZ7JVYsOI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6625

The caller already has the domain, just pass it in. A following patch will
remove master->domain.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 540f38bb44873e..34893801d05c73 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2369,12 +2369,12 @@ static bool arm_smmu_ats_supported(struct arm_smmu_master *master)
 	return dev_is_pci(dev) && pci_ats_supported(to_pci_dev(dev));
 }
 
-static void arm_smmu_enable_ats(struct arm_smmu_master *master)
+static void arm_smmu_enable_ats(struct arm_smmu_master *master,
+				struct arm_smmu_domain *smmu_domain)
 {
 	size_t stu;
 	struct pci_dev *pdev;
 	struct arm_smmu_device *smmu = master->smmu;
-	struct arm_smmu_domain *smmu_domain = master->domain;
 
 	/* Don't enable ATS at the endpoint if it's not enabled in the STE */
 	if (!master->ats_enabled)
@@ -2390,10 +2390,9 @@ static void arm_smmu_enable_ats(struct arm_smmu_master *master)
 		dev_err(master->dev, "Failed to enable ATS (STU %zu)\n", stu);
 }
 
-static void arm_smmu_disable_ats(struct arm_smmu_master *master)
+static void arm_smmu_disable_ats(struct arm_smmu_master *master,
+				 struct arm_smmu_domain *smmu_domain)
 {
-	struct arm_smmu_domain *smmu_domain = master->domain;
-
 	if (!master->ats_enabled)
 		return;
 
@@ -2462,7 +2461,7 @@ static void arm_smmu_detach_dev(struct arm_smmu_master *master)
 	if (!smmu_domain)
 		return;
 
-	arm_smmu_disable_ats(master);
+	arm_smmu_disable_ats(master, smmu_domain);
 
 	spin_lock_irqsave(&smmu_domain->devices_lock, flags);
 	list_del(&master->domain_head);
@@ -2584,7 +2583,7 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 		break;
 	}
 
-	arm_smmu_enable_ats(master);
+	arm_smmu_enable_ats(master, smmu_domain);
 	goto out_unlock;
 
 out_list_del:
-- 
2.42.0

