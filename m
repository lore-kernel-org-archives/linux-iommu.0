Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2089.outbound.protection.outlook.com [40.107.100.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7F841BDDE
	for <iommu@lists.linux.dev>; Wed,  1 Nov 2023 23:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="A4zsnDm5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OroIC8hBVbYYWsvu8QNTxhhuIbc/wg8h1VaSu+0dOP7rxbD91VkN0RBni9ZqE0ZA8r3BJ1zHODVKP9Y//N0dYsTCV1iQknE+D2wcKY2UpWq0Xh/x9k/n2DkIPMqQ9zhut9hqr/WJk1XYfT7ftB1j6AHLTBcafuIq3dG9NiaZiSVdddg7584FfIQuNOpVpkHbykQFlxKvZXk0Vc2OOJ+I7J9Hu+lqFyAMP/hiZ+ZLlFG6gCyGt4hTXsL8tNM+96PkqvP2BWu11Fj5jg8WkcxDhu35BFHFsxN+6h56rMFTGgZDannzoQnKU/dgeyPrrGaUDFG8wZ2vxtb4DtBqivIRCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ku7Dilck+INBq9I8VJlFIh/CUuychxsmLXhaajGORho=;
 b=NeaWQnXR6HsXuEgDQv2XMdtLOnavt0HEQVb3lP+sCJjB5/UPSDVVbEHzjLpJ2WHe2O4N//ga4gpriZiPqi6f5QKb2u87fTl2hPvEWAf4qWCdAZvuRznn2KIZJzD0D+d6jsxK8Fp/pBFMuQpoave+m/h37RNHWisb/aDKUnrblJI0UevmPtYhbWipQ/7jwhwUtAPX7EwUG1N6F3j2wnfA4uJ6t6jVXxo6KX0P3DTTGJ7vB89Xjx/fSFwhH5v7inIP8x0aJgb3q7a502xPaKG2vZi3cEy86KcCBnmyzNKzoIth2AEUUg1zT03LdkdAp2oAuJJ8fX/AiVSucYp6Qp0mVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ku7Dilck+INBq9I8VJlFIh/CUuychxsmLXhaajGORho=;
 b=A4zsnDm5Lm9G9zW9jvkSrMRy5Fr/fy8rWeJ+B2XS5xD7MxHa1Lm9ZKF5npq95CFRLlI0iLx9hz8ja7G1qJQ8Y+dj56xYomKXHrMsUDj/pVHuf/ZbyT+bnK7BKJ9R8h1OavV7rBFpAypev72tpAqdmjm9ea57WhNZDsG8wLHN31djt3B1Ql1BhZolZlzz+Jw0rlKjp5n2Nwy23K8iCNk8wxlVunW03UQ4ptIKcX7u1lEwOLcEJAwuoKvQGbAah2RXaHvhNCwamm8V1yEJD4VaJDWjM2C7B5vnNXEzlk1HLZ9Mr3bq6Vc90yjOq9Bs40zY+6WZBE2l0/3K0n08IvWLRg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by BN9PR12MB5338.namprd12.prod.outlook.com (2603:10b6:408:103::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.21; Wed, 1 Nov
 2023 23:36:48 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::b53a:1092:9be2:cfb9]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::b53a:1092:9be2:cfb9%4]) with mapi id 15.20.6933.027; Wed, 1 Nov 2023
 23:36:48 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>,
	linux-arm-kernel@lists.infradead.org,
	Robin Murphy <robin.murphy@arm.com>,
	Will Deacon <will@kernel.org>
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Michael Shavit <mshavit@google.com>,
	Nicolin Chen <nicolinc@nvidia.com>
Subject: [PATCH v2 19/27] iommu/arm-smmu-v3: Keep track of arm_smmu_master_domain for SVA
Date: Wed,  1 Nov 2023 20:36:37 -0300
Message-ID: <19-v2-16665a652079+5947-smmuv3_newapi_p2_jgg@nvidia.com>
In-Reply-To: <0-v2-16665a652079+5947-smmuv3_newapi_p2_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR02CA0003.namprd02.prod.outlook.com
 (2603:10b6:208:fc::16) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|BN9PR12MB5338:EE_
X-MS-Office365-Filtering-Correlation-Id: 301b1fcc-84b2-40b9-301b-08dbdb3369bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	2kZ2MmrWhpkQShE3cyiuQrXlV/pEb8pxnBpDUt5D6F9O7maflhMc4Bz0F1qNC93z0lad9P94LjfBxRRZfaVrsrxohsdeLxejuDMywhQo0XaDakLDCUteVM70ZtmWWLQGd/wnDnbK4P6sMnkmt3kyaPfQgJ45XT+DSe8694QEYr1jz/LA2c9j68q916yfyffEMIWkGirUc4KgaQ7kaI1xLUC51md+gZeoWCkF92qnyQs0oVaf7FZvpDCRDmY+zpBfZtrVq/QU13ZkziQKd751dGpX7lPS7MEYHSvf/TmwHwNfoNcMv3lptiK1VuPdZb9O93pnqaDag8yhblzQujp6lthTZLWRbIk6ctOgIa7ZVSeRs8qt805rwA/8lhqVQ1ZGCZ6ys24S72SiJnfZ6UhX7sBcELp2ipW9W26OOAvR0XzsGOQugb2KhSibBPCa+/Pvv1V92JeHX47HUOOGLmwv1sF+xieQ4CMSefAPd/eiF3R9YLrWIC06McO6NOpELYZZIBjYTPf7oSB1//Xm3BqgcJwmRol87hfCCniO7wtsbuTz88ZRICt46JZTGM82ZM22
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(39860400002)(136003)(346002)(376002)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(6486002)(2906002)(478600001)(36756003)(54906003)(66476007)(86362001)(110136005)(66556008)(66946007)(5660300002)(41300700001)(26005)(107886003)(2616005)(38100700002)(83380400001)(8936002)(8676002)(4326008)(6506007)(316002)(6666004)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?c2oF/74rFOerATxSLqO2z2Y16W4gYejp4VcsAVYUzrlTZfPzRb18BuVtSmAT?=
 =?us-ascii?Q?otUdBHSc0bWyTzjExA1FrjdkopLzvdkjt/gNuxHURioDLV2fa3jZY4s+ar4S?=
 =?us-ascii?Q?5Lj2em8KYubdY0y/r6MNo4zpWZx4h+QvC5KKK5McG6WLkaWXR6r2wUjaSKrT?=
 =?us-ascii?Q?51jFBWmPaG2BtHnuZCYl7gXYf7dV6mM+zdSDNWtTrFhWcTl+qao0wJx4BePj?=
 =?us-ascii?Q?EAqHqmeQ98OvIsjZaWFeU5fSbciI6EClc6XsccJklGd7Lt6RRO2kGwvSf2Jh?=
 =?us-ascii?Q?XYCxiNjTy0CruJt2O0Nfv3w2qI0Tx4AR3QLWWsk6sL/jLvjh6I9mkahVxrSh?=
 =?us-ascii?Q?Iw4wEqzikbqOd7LW2X1k46AfJ0RPXvVc4ib3hO6mrlSbccAPR5TSXbwTYDAy?=
 =?us-ascii?Q?OjX7e5AaSpMFDrBHEc0EIk6oFc3FEwDBlB4Sg9mTbR36GPhYF0vstfC+H5d+?=
 =?us-ascii?Q?ANioFXrvvitelMXOa9FbgK3XT9qScNTzj5uRnulbkPl79DIhABoAmBNdsaEU?=
 =?us-ascii?Q?y7rHxELBr9YGCzTe2c7U33qzBUjJit2XSM44LKW33OZc9MRgV7ChO2MhPISm?=
 =?us-ascii?Q?30lvU/9TEVvd5RDHTvHhaL7aiEftvUTsPKwSxvHnyqA9qwqdeboOKcRD4Hjt?=
 =?us-ascii?Q?Vj89eBjvn+nQ75rQodZkG4o/yh+fQuqncdylJYFylfRqx5qzWSrgxXJA5sCf?=
 =?us-ascii?Q?ekaA4TeR5x4xbGnC2ZFlsTwPYnryZk2J5MvILuBcPopruIRtxPmytPpKHh+U?=
 =?us-ascii?Q?Mty4HFBfHW3IOXf30gv5No56Md5aJVcjxVYTii0wkMg1ijrbwRF4M8U5/isK?=
 =?us-ascii?Q?6ZsDuwLpic0yHY6rdoRbxqYNSCl3jX9M5fssTsVdaVm/0SGg8u/0dxGP3GY5?=
 =?us-ascii?Q?DgPOS0wtcSBMW+ZzSVeqMmw89DeEvs4ZST8nFLJ/ShR5I2GKBUxI1Xoo+uIe?=
 =?us-ascii?Q?j7t7v+AtJVgrENoMyyPvUSvrdg5NHgxNvB7n8DBvVDaeGJbMN2eA8/Jg8osH?=
 =?us-ascii?Q?+fuB5vYgQgPMh+VF62e2rb/d5TUZIju1nY4SfBxUdGHcJ6Dm+RMSPmQxZnHn?=
 =?us-ascii?Q?wcjIjy9MgnVl2LvAAO7Ii2xyDOPNDc0qi7NIvply8CARlgHAeCPuucVhBjPK?=
 =?us-ascii?Q?MrVBSbx4unuclH0IV5Ee0O8PSDERDVBuN0Ztc1VuVbAs9HcW6+NRIbqfLx0T?=
 =?us-ascii?Q?rVNwCLgdiMdVDQIJkY4KQC43IBEb/+E68pZ/sE0NLLwpCPTyPvPaOsRvDGoL?=
 =?us-ascii?Q?mMTo4VTungbHa3RM4NfPBYjCFDYcKQQ2ixwNUKc8DbDJfWhlLOPQtoJtuixs?=
 =?us-ascii?Q?SaKLOMQAjeQbu1trh4vT+pwMJSi8ntonCubnM9KYHpmaII8NNTmKri8LxcHA?=
 =?us-ascii?Q?IwkLKbIdptxojq1RhyUsW1O03A/0kWVrCl69gMJe4Bu9YBZCFeAnvFaz+rJ0?=
 =?us-ascii?Q?Q1SVsMOLjSyLIGXilgCKzW0F1FmXh6WD+5hm360H7idvE/42wy7rwEcR8YvP?=
 =?us-ascii?Q?4cy12bcmTai2zk7vltYwEt8WuZsF/DEZj9zLua2tYwjfprF2qxJtlR/CzoOU?=
 =?us-ascii?Q?Ddgv15jju6ZEdzQ21ZRB7oFiBF8LgcTcSzRGR7fb?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 301b1fcc-84b2-40b9-301b-08dbdb3369bd
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2023 23:36:46.8139
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bs2S/dsQxdBpf+UhNoKVmts1b2jVh+GdA4ug2g1dP3eavN/ZZKQwAqU0IiykKWEe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5338

Currently the smmu_domain->devices list is unused for SVA domains.
Fill it in with the SSID and master of every arm_smmu_set_pasid()
using the same logic as the RID attach.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 326c82fad90b8a..23bcdf1630c23e 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2712,6 +2712,8 @@ int arm_smmu_set_pasid(struct arm_smmu_master *master,
 	struct arm_smmu_domain *sid_smmu_domain =
 		to_smmu_domain_safe(iommu_get_domain_for_dev(master->dev));
 	struct arm_smmu_cd *cdptr;
+	struct attach_state state;
+	int ret;
 
 	if (!sid_smmu_domain || sid_smmu_domain->stage != ARM_SMMU_DOMAIN_S1)
 		return -ENODEV;
@@ -2719,14 +2721,30 @@ int arm_smmu_set_pasid(struct arm_smmu_master *master,
 	cdptr = arm_smmu_get_cd_ptr(master, pasid);
 	if (!cdptr)
 		return -ENOMEM;
+
+	mutex_lock(&arm_smmu_asid_lock);
+	ret = arm_smmu_attach_prepare(master, smmu_domain, pasid, &state);
+	if (ret)
+		goto out_unlock;
+
 	arm_smmu_write_cd_entry(master, pasid, cdptr, cd);
+
+	arm_smmu_attach_commit(master, pasid, &state);
+
+out_unlock:
+	mutex_unlock(&arm_smmu_asid_lock);
 	return 0;
 }
 
 void arm_smmu_remove_pasid(struct arm_smmu_master *master,
 			   struct arm_smmu_domain *smmu_domain, ioasid_t pasid)
 {
+	mutex_lock(&arm_smmu_asid_lock);
 	arm_smmu_clear_cd(master, pasid);
+	if (master->ats_enabled)
+		arm_smmu_atc_inv_master(master, pasid);
+	arm_smmu_remove_master_domain(master, smmu_domain, pasid);
+	mutex_unlock(&arm_smmu_asid_lock);
 }
 
 static int arm_smmu_attach_dev_ste(struct device *dev,
-- 
2.42.0

