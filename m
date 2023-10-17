Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2052.outbound.protection.outlook.com [40.107.223.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AECC12D7AD
	for <iommu@lists.linux.dev>; Tue, 17 Oct 2023 18:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="V6EnFX2x"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LuyJch2KP0dkm6gmRCALAzGX+W/TYRmhINk5KIdTgQdQQILr2Z6SnieqI6UMbHejZt8aZkLCR4dk/agAZugai2IIcFW9EKsFn0vWyirrSHOZAiSsodzzYxAFSV2Kzsw3RSdEr1saW38iTmqKixGFGHQDDW1BIDgYmsqeYZBpa/PUDAbeVDVvZPXhMWOqFIogWbVRmG8N/3Y1HfA5xTtcBqP8ig0XFNmOMRaAJDhDx4HsNZSZAeQWWa57ikRrUGXS8E8prCPogzvzqmmylXXUTbm9n8doemynjCVWO9zbtrVqNnZfJ1rbc3DhreoUqKzuGBRG/4UDnuKXST0Bo0jaLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=avoUo6vx7sHkpe7puueDTlg57kAlQE4G/kyybDPxJWo=;
 b=FDeBWPdC4TtPO24RA6V8D7NpCPw1vCfKlZDQJQ9w762URV38xIWVw9VZzd1lnjolCiSDGReBXSyW3dGPQpdEXU3jRi92Bvx1YaY7lWFysNhxzlBIbhLvPrtrBDkFCmTXmU0d0IMCkc+u+FwdMYSiZ0Ftv9YUXof896Rmrg0WWa5awtoaWBbTRaMHBIF/kdMXAvYc8a2zv738s9gE8zmXziWek1RxJIk1oGefxa/7GezrXqv+JsDQ3Sy6Nix+LRTkh85DIT5CoMjLC7mUU6NRFVROOIZ23dOZ6kQ5QPkuQsJbmsK0gyTuuHJd3DVpOC5vXnGTtcRQlBYkvzV/1Ja6Gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=avoUo6vx7sHkpe7puueDTlg57kAlQE4G/kyybDPxJWo=;
 b=V6EnFX2xmhHVbgSh+pYXkLabcRHRpD2lYfOouD5RMYIai9ZPEw83dhg0rzBESOeBr9hTe4i/hNdMwM4XrMKwhEi2pr7eIIjIua9/fN3F4PZQTnYq9xQGNGrdlkPl/xvMZxsGOTUof05utov89qjecqaRE2sPtJL3h/SZyz0FwW1sSosqRadL0bdOzqbeFuTZ9KHayDoWNnYLITOK8/y5X6DOTn09LFM3e/rSYPMoG4FoLxPlkxgt89RW4XztniUs7xdTRDnAWUDG3VuhBAG3HRYJds6b0JjnXk3NrWJ5VHEehsKbfI/jNr/0JL7TPS+85h8WCBqUSnj8pZd3Pz1jAA==
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
Subject: [PATCH v2 5/5] iommu/arm-smmu: Convert to domain_alloc_paging()
Date: Tue, 17 Oct 2023 15:11:44 -0300
Message-ID: <5-v2-c86cc8c2230e+160bb-smmu_newapi_jgg@nvidia.com>
In-Reply-To: <0-v2-c86cc8c2230e+160bb-smmu_newapi_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN8PR12CA0007.namprd12.prod.outlook.com
 (2603:10b6:408:60::20) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM6PR12MB4265:EE_
X-MS-Office365-Filtering-Correlation-Id: fbe4d30a-c18f-4c6c-378f-08dbcf3c8788
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	LB9yMIJe1oEC+jviKTVvQMWOPWOf7+OyBTHjN5xkjR3MYHLjdvk3r4470rwWAGwd8YxDyeUVvVJ/Rl8lf9xtb75ChEjgcwL9mLXL7aDS7O4e8uX6IoHZqbtzjTDqlh+9K0RhDnyZNFO53e3e09Ozn7R4R6oq4fAwJ+7avW47rNzLPUK7/Y9e1mkJl2KaP/PWT98w5jDXZdFjMvX7MAWAGYcf/JnwHsQUXy0aemBXvxoBLhpeUTAzX01uOuHflfSh9BOdxPrTiFWrKCgus3ZyMIQbVyTNkyxaey1HxFW/RT1/SwaTlpf2rgN3xt58C293OtQ47byZ38LvIgNdXmxJoENWIEDr1N9jjgLr2Hg6gLiEs23m2YzX4bPYyrMyYX2H39uejawXMknY7Ez/d6V5k1/Ukh7YhLi22jh9V8LPYX5Kroc5dmcxesz0OZxg9pGppjwgbfRIA/r1X1nFu5VJdbh1ZRcjjfKpX5BXzDBJFqt4i4A9bShgIQO4qIIZu2FTiP1chKhk0irWtIKu1hy2NGrGPoV/Qi5ytYDjckEIlcHTURMlOlo1lcc1RJrAJzHQb4nrXhXVqSu9/rleYgj8zYLIbSvbuDeUC8l30wxshsI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(346002)(39860400002)(396003)(366004)(230922051799003)(1800799009)(64100799003)(451199024)(186009)(6666004)(26005)(2616005)(478600001)(66476007)(38100700002)(36756003)(86362001)(41300700001)(107886003)(6512007)(4326008)(2906002)(110136005)(6506007)(8936002)(66556008)(8676002)(6486002)(83380400001)(66946007)(316002)(5660300002)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?41QwmqOoKuuoKUMXw7CHy6dH27ye594rU75foCVZiZg2mQyW3HShwHXNNgvh?=
 =?us-ascii?Q?VhyPxk2DiT+HBLyrLj8r/F/dMWUIFGedgmDY45PAllJ5IUwCVAW0qB85Hj2n?=
 =?us-ascii?Q?5142jmuZXVZI8yU6Gfq1ceo5qZJ7wbnGl3zsuowb7zk0oPhpm6iH4+Iurm7d?=
 =?us-ascii?Q?7z8MFT9Ug5sv/xNxzdIwhtR+x41TSoH/xmA1W/a6AGzM0nreg8G8lFF5MWrn?=
 =?us-ascii?Q?zQA6A6ezZt9Akx1eJj8ist+W24pb4WzOjrQlnKquTR3ghr1WByGbWyrVp+2n?=
 =?us-ascii?Q?ZN3YBntc8lbBfH7ilKxNUq5WIlZqn8gsLfLU3FJYMhq/rjUv+ilbw8jNVray?=
 =?us-ascii?Q?vlHjmlcY19LxeFGym9HeR070BwUesEzaDWTrNnv+fu47MgMrY2cCfMoI0Dzk?=
 =?us-ascii?Q?2l1kAmNUFHw03FOQoD9o+yNB+KSe37UVl096A2uZ2tHO4AgStxNagmp262sI?=
 =?us-ascii?Q?OrcknVRUuI8zbRoyYf75MuoFtIEwsp+wBybvjTOTkM7yzjXhfpX8oGN54YJf?=
 =?us-ascii?Q?yjZLoANy6iQP5nXDFQB54KAbEvuY9mMN4T70FYz4RsOKo0VoMlJfDFVNprXI?=
 =?us-ascii?Q?YHVW4Ar4/cwa6rHC3z9JIL49w4fXlLeUbSyNuGd+0P0w7TDxQ6IUfWq8fYHv?=
 =?us-ascii?Q?DRMnHyC+fnW/uX63KrxGXs7o+7idxTVfi5FQnElIZ4eLVp8+NRU6AVSy6Bxs?=
 =?us-ascii?Q?9aK48LKARsXYAlF0kKaQ1ycBF6pbXgg5tZE6yusm1FZFfgx3jgna0oXJhUN6?=
 =?us-ascii?Q?4e/IbYTSzRiYyGApv59xmVwCIinB7RC2K+sra9bl1YIJw6aU+R0lnbSzNdRf?=
 =?us-ascii?Q?6uS1TIIWVJhPmLNAE3sMYhFqGTdFZFyW65D8nQjmPDuksEQxrvwNRXjzI/AG?=
 =?us-ascii?Q?FF0ZQSJsixDBUqkKCWf+mbh6gtEEzefnqkzyYW0VEsFY+i/ZvJNQ0OD+YNz6?=
 =?us-ascii?Q?uZYuISddxwEzaIMYOuXF0Gmwl0eRnazM2ycWb31GNWNqFU9OImbFZjKsWndd?=
 =?us-ascii?Q?1CBRR0OLJ8EcRVpCA0kLVlssUB6mAwA235XnG8obe719yElZXSCJ0p0GE8RI?=
 =?us-ascii?Q?XvI1YQ499XEH7xrqKa3g9DkvaLvwy5HAyIVjTNQNz6M3nWAB18tjMdyhzaPQ?=
 =?us-ascii?Q?uBZn2qEcNMJlB/uqSxOYobg9NeLpMqlCK8D7WxtX31L+p5xq0yjJVMNFWlcf?=
 =?us-ascii?Q?Ktqe5AWnVyV0NhqoubwJElC+C9nl9QEBMrOo69XJ/nlEBlUSN1IncUhIe1xE?=
 =?us-ascii?Q?QVffDewLv7AWxlgpFg7ZH2U7o8qMB/E9LDwh4iprg1uh1OHof/8O0bcX6PlF?=
 =?us-ascii?Q?NcjUWcvFSr4FOH6wPNVxOrlVN4SUQdOH0PAZPIHyFY8UoOrkP4WtYigZrdBY?=
 =?us-ascii?Q?XpqktCqKrWPvwMtoJtBFWIl+5VQ15coxlUvxB+jgZMyoaqbk81Uykm2pe2po?=
 =?us-ascii?Q?2499Dw9L9gBar3oEJuF0in6K7/bZJpM6fUGAmNtYzyw4L0kgD7jiqE43Z6uW?=
 =?us-ascii?Q?5TNDOjKs8XcRz/WQhF3sQZs7HCuyqCYEii19ur5RqKikvGb6sJo8qIXernRf?=
 =?us-ascii?Q?nkZa/CYErhopAKhkcKjjyxNueIAE6j6NLS72o6Gf?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbe4d30a-c18f-4c6c-378f-08dbcf3c8788
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2023 18:11:48.3100
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vFc+xswI8SdYBLfJR2fm6UynOUfndcmM7tIGnghXg+kaupnilEw/pTMMAuIcDwxp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4265

Now that the BLOCKED and IDENTITY behaviors are managed with their own
domains change to the domain_alloc_paging() op.

The check for using_legacy_binding is now redundant,
arm_smmu_def_domain_type() always returns IOMMU_DOMAIN_IDENTITY for this
mode, so the core code will never attempt to create a DMA domain in the
first place.

Since commit a4fdd9762272 ("iommu: Use flush queue capability") the core
code only passes in IDENTITY/BLOCKED/UNMANAGED/DMA domain types. It will
not pass in IDENTITY or BLOCKED if the global statics exist, so the test
for DMA is also redundant now too.

Call arm_smmu_init_domain_context() early if a dev is available.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/arm/arm-smmu/arm-smmu.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
index 6340ee8ab7c482..cea25afe9e49db 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
@@ -842,14 +842,11 @@ static void arm_smmu_destroy_domain_context(struct arm_smmu_domain *smmu_domain)
 	arm_smmu_rpm_put(smmu);
 }
 
-static struct iommu_domain *arm_smmu_domain_alloc(unsigned type)
+static struct iommu_domain *arm_smmu_domain_alloc_paging(struct device *dev)
 {
+	struct arm_smmu_master_cfg *cfg = NULL;
 	struct arm_smmu_domain *smmu_domain;
 
-	if (type != IOMMU_DOMAIN_UNMANAGED) {
-		if (using_legacy_binding || type != IOMMU_DOMAIN_DMA)
-			return NULL;
-	}
 	/*
 	 * Allocate the domain and initialise some of its data structures.
 	 * We can't really do anything meaningful until we've added a
@@ -862,6 +859,18 @@ static struct iommu_domain *arm_smmu_domain_alloc(unsigned type)
 	mutex_init(&smmu_domain->init_mutex);
 	spin_lock_init(&smmu_domain->cb_lock);
 
+	if (dev)
+		cfg = dev_iommu_priv_get(dev);
+	if (cfg) {
+		int ret;
+
+		ret = arm_smmu_init_domain_context(smmu_domain, cfg->smmu, dev);
+		if (ret) {
+			kfree(smmu_domain);
+			return NULL;
+		}
+	}
+
 	return &smmu_domain->domain;
 }
 
@@ -1602,7 +1611,7 @@ static struct iommu_ops arm_smmu_ops = {
 	.identity_domain	= &arm_smmu_identity_domain,
 	.blocked_domain		= &arm_smmu_blocked_domain,
 	.capable		= arm_smmu_capable,
-	.domain_alloc		= arm_smmu_domain_alloc,
+	.domain_alloc_paging	= arm_smmu_domain_alloc_paging,
 	.probe_device		= arm_smmu_probe_device,
 	.release_device		= arm_smmu_release_device,
 	.probe_finalize		= arm_smmu_probe_finalize,
-- 
2.42.0

