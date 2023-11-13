Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2075.outbound.protection.outlook.com [40.107.243.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E59FB224F8
	for <iommu@lists.linux.dev>; Mon, 13 Nov 2023 17:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CqVwMNNn"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CrNEuqbtTMRyTkBzDIMtguVivZt2sHp2NLaGx6g5lk7A2+zYIgsz0v5SOLOsMOA3VPXBUj/COZ7lqBpnL6s1+XjeeSw/31n6CeTtLZyC0Ay87do7pNhsv/8I6VFS9qjeMixMkTfv//T1SNw67N6iqX726qor+zKcSDNZCf9nWXYIKt+gg0iEr6gyv8ZGE5aQYbVtuJarmUpCsbFqU30cNuG/DkWOz8pQDGsQKk/Nio1WwG4WmXgQVA6Y2541WaqB5EOGo/w2uNQEYj8bHul0TFb9VCh2ZN4ndw31PsPgmts2bGhW7YXsfelr0f84NXzDxDNTo+bVlhqFRUuJzghihw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OlTqW+hx4z/JEPgi8ufSSNgBDqkQhsRDOmQ0a6Td5FE=;
 b=mBPZ4YFNfnLNFNqCo8aKylP3o/1EiBboGfKfBTfcNFKlELgSPrR56z005QDn8bRgBzo6vdjXieiNBa4d0dW35JnDjpbF++Loy8ZNNYZPjneR3QoyCXZ0FNdSlQC00+aBpiB1U/Cc3/XewEFzTKlJfIK/11BT52kzIgvRH1j52qKiq+/+u+dZUYktGb2ts8sNZg0/R9eRCdqjPEV+lLwhOk1z1wUS05EGYqDmc5tkJENKRkBlIXBUj+7AS90LWq4LmZrw63q6ajhOezJlGKtKJSKV75LXiZ6RuhF4noWxOBwf+RPQZVmXyQZ4Mu4TXzw15GHHvkIltLoJGqa03rFSjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OlTqW+hx4z/JEPgi8ufSSNgBDqkQhsRDOmQ0a6Td5FE=;
 b=CqVwMNNn++fgoA59P/k5ut58drjcpHVdIZ9RQ/o9+a03P9j8Jw5Qi449ghxgY5x9GfGRn0SulccELC/TznLcyYzkjYolGph+bztaoqeORmu+TRqVymJ4NQD9dEOfkoFG3wCxIGr3QW/aqnx3eHmOpUYQZknAB0/IhALDYQ8PDCT67X7P0ROrdwY0EzF/W+jm8j0bWvNs9Lbp52cRDryO1F9T0oVeYzr7FLe/6ZK3hFG1eA8NkPmLiEUEwPeuRjx2L19YTNdYGbNr+h3A1TIuP7ktn4M1gGtuUgRfwS/ndfDMy8TSeRTC4vf9w/p7gmrDeBi0eQMjc8cvZsbHvRPA0w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM4PR12MB6038.namprd12.prod.outlook.com (2603:10b6:8:ab::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.29; Mon, 13 Nov
 2023 17:53:29 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93%4]) with mapi id 15.20.6977.029; Mon, 13 Nov 2023
 17:53:29 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>,
	linux-arm-kernel@lists.infradead.org,
	Robin Murphy <robin.murphy@arm.com>,
	Will Deacon <will@kernel.org>
Cc: Michael Shavit <mshavit@google.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Subject: [PATCH v2 16/19] iommu/arm-smmu-v3: Add a global static BLOCKED domain
Date: Mon, 13 Nov 2023 13:53:23 -0400
Message-ID: <16-v2-de8b10590bf5+400-smmuv3_newapi_p1_jgg@nvidia.com>
In-Reply-To: <0-v2-de8b10590bf5+400-smmuv3_newapi_p1_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL0PR0102CA0039.prod.exchangelabs.com
 (2603:10b6:208:25::16) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM4PR12MB6038:EE_
X-MS-Office365-Filtering-Correlation-Id: f82426df-8b93-4dc7-6862-08dbe4717053
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	F8VMBpsNJwE/WPRDlv+/AwQgb3fGXoKI6jl9KRgtg0kAIKlaY8zYqUtjDCIjDyB6kxGCrnHhgDOrZsRMNBiiSEB5D2JgQN9EIWuxtMFG1FzZFrW4IexN++gq926KBonHhDWrXMdq95EK5H5tdUOKL/7lp9DqRSNQeMH+ouc9G/K/2DBg994t9H+nvQULu4cPKrjY5zHDTkdLipz4wPUhTSy9l26JF4ehTbTCow4sO+I9TVyWicyvbYkf5qDgyO7ohmYfiF/H62inkCMk29R7e/QqcXII+MfNrvLJBF3xPrTbAvh5Xp6i2gp5h8pzgqiQat8Z7zm/uSmyjQ14kQMdZPwWpzRuhFbnlu8o9hYHPaXhS5Ulrom/35JFyiQ2mKJ5x1g4JXLXnSSWNVkDspNWd+FG7IQSwySEMvewLyzOkzRMXrJVQ33g5QZnGw8yZCwWXy7TSXtaF4gR2MzBupUYm2yKuY840zPC9TPJxj+NGFi/w6IvwcYLOn5fbP/hMQJBqFBDBP1WHeQ1pW8+HJ4tPvLwuUCeN58ulAbDPEsyaWoE8tYXJ0pQvtL/AfSmSskF
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(396003)(346002)(366004)(136003)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(36756003)(26005)(478600001)(6666004)(6486002)(6506007)(316002)(2616005)(6512007)(66556008)(66946007)(110136005)(38100700002)(66476007)(54906003)(5660300002)(8676002)(8936002)(4326008)(15650500001)(2906002)(83380400001)(86362001)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FfqDA1/hW3RpUxgLi2M4/VOFMYvhSV1ozS3lk+/CX61SdG+lIuDrjUloe33L?=
 =?us-ascii?Q?9VaHez9Dxac9ynpsCWdHbwWM8YDRZD6nJ0RZb8G+CN/8imBdnq8BVhi4xYKu?=
 =?us-ascii?Q?sdnuLkDzhbTlNBjVDnHtGM59usA0KmG7s1AYJjtlbSSxynBIMA1k96ruaFjg?=
 =?us-ascii?Q?iEIHO9JzBWMoI4VSPJXSAeUFyZu7j3QKKT9lW3PEQUW/UvVhG9m0UK2dOZ50?=
 =?us-ascii?Q?9IVsngkzVCnmh9/NqPXopZp04tyzARliDbPqvDAllPc0N1BinP0FXWuOz079?=
 =?us-ascii?Q?r2F72n436GO43BIObgSDBjdRB6FpakfYY+x6x8Rc+0khgmPjV6/lxAhPoZKS?=
 =?us-ascii?Q?pBBDrKiAZt0UpyBRM2Z1Mv/okZOoqFgySIGzGWeKx1u7ZLqgSBEsyC/YgUi+?=
 =?us-ascii?Q?of1lCmZZ/KEQDooIVxMljtOhBu3frkmT3eV63lkxnq/I636HpDSDPQ/V8xX/?=
 =?us-ascii?Q?7oJNnBptkgnO46UIw5YUO5Z862g0GQf0FP5Y3DO7b9TeuYaZnLAJaW/8+AG3?=
 =?us-ascii?Q?sHMm86RL+J2Bicj6Xikl8pj50s5AaK5z0gl8DCjtKhkxy+wgnPfutiBaWRvb?=
 =?us-ascii?Q?ZhOXo+o8t0HBIeEayA5GXRGfHfT1mP0e1HJuvpWgmFT957jyA100ar86lhfO?=
 =?us-ascii?Q?+wO45QaRdQZg7v0uU7KrVYz6uagfs0cnqjli/1e2A2Y83BXAtnclBPRZSavy?=
 =?us-ascii?Q?WxLermm4ASxa85v01S11p/gTOECH+CoRFiDDhbOZEduGfSplfh+5D+LIj8kw?=
 =?us-ascii?Q?K9gG/S4umolYeernPSV/DufGc2wXql1eA9FWUV0g/jodOLo2Q3IHM1b0h+BB?=
 =?us-ascii?Q?2T0q/m4gRr5XCg28A/5fsPn8m6S2qrLEAPahoQ+CQSJpQqFVFUvaDENHMKQe?=
 =?us-ascii?Q?gQh8LIW7bTKa9DSB4jUJQYp/dlL23IASL6lvRW5BISHgNzf/9xozcRK707hD?=
 =?us-ascii?Q?GN/D3CaLUCTUWuyybItEMIetQahyHs/wyeu5Wp3/hPkMPn9cNqSIBfZ3sKYh?=
 =?us-ascii?Q?Polspy0taUCKlVscd+SDkB/ZA6D8E8Gf8GVVELwKqH8mDn2OlTBGyJtTQjl1?=
 =?us-ascii?Q?k9hR7FV3DsiV4nVSQ+ePg7vVDu7vhsO5vINM6vQgECl7CvnuuFcuoA8MQXM8?=
 =?us-ascii?Q?S+Q363JGbG/j85pcjEouYqotSbyLBxC0HXAJ1wqK8tX1IaEShJlamyo3ZZCw?=
 =?us-ascii?Q?bV6S0GcfuBnj2+8fKwEriEqySuthnNNOsSRVAHbFK4hg4E/bUbQm0kRh65Ca?=
 =?us-ascii?Q?baozVwVFRxKd2bqiV05jnsJb2un1m+VbjQaP3tUEMUuP1zEF2avgYc2zBJfZ?=
 =?us-ascii?Q?Q0NvQ0n5o5EK87fAS05XE0BoRzGwFr+TacGvcorex+yg41funm5UR7qNVpAw?=
 =?us-ascii?Q?lvxc5akbHH+tCeEqLRDKP0GOivw/FH21iNtvARMpfoNQRveiSrHzrgt1aTG9?=
 =?us-ascii?Q?zG0s0YUk0P8wUkCweWERKbfO6q2szHlRmATGps67i/lAYCCdGsc6NG/RoNAY?=
 =?us-ascii?Q?BbJs6C9mZ/ogLpn+XUHuZZ4zG+5UgxVrGZZ43DQn8EDGQT65oFgNszsacX/+?=
 =?us-ascii?Q?Pv9AISCtZWCg+t45EVM=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f82426df-8b93-4dc7-6862-08dbe4717053
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2023 17:53:27.1101
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AlPDZphv1WbR7vbVo5XoIoDabL5I4xrQ99NXw6Df27AynLg6dQ5BQHOWCdC4j8Wm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6038

Using the same design as the IDENTITY domain install an
STRTAB_STE_0_CFG_ABORT STE.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index d6f68a6187d290..48981c2ff7a746 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2647,6 +2647,24 @@ static struct iommu_domain arm_smmu_identity_domain = {
 	.ops = &arm_smmu_identity_ops,
 };
 
+static int arm_smmu_attach_dev_blocked(struct iommu_domain *domain,
+					struct device *dev)
+{
+	struct arm_smmu_ste ste;
+
+	arm_smmu_make_abort_ste(&ste);
+	return arm_smmu_attach_dev_ste(dev, &ste);
+}
+
+static const struct iommu_domain_ops arm_smmu_blocked_ops = {
+	.attach_dev = arm_smmu_attach_dev_blocked,
+};
+
+static struct iommu_domain arm_smmu_blocked_domain = {
+	.type = IOMMU_DOMAIN_BLOCKED,
+	.ops = &arm_smmu_blocked_ops,
+};
+
 static int arm_smmu_map_pages(struct iommu_domain *domain, unsigned long iova,
 			      phys_addr_t paddr, size_t pgsize, size_t pgcount,
 			      int prot, gfp_t gfp, size_t *mapped)
@@ -3040,6 +3058,7 @@ static void arm_smmu_remove_dev_pasid(struct device *dev, ioasid_t pasid)
 
 static struct iommu_ops arm_smmu_ops = {
 	.identity_domain	= &arm_smmu_identity_domain,
+	.blocked_domain		= &arm_smmu_blocked_domain,
 	.capable		= arm_smmu_capable,
 	.domain_alloc		= arm_smmu_domain_alloc,
 	.probe_device		= arm_smmu_probe_device,
-- 
2.42.0

