Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19DEC2D7A8
	for <iommu@lists.linux.dev>; Tue, 17 Oct 2023 18:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="U9ZvDTlv"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YhDRYDIyRT/ftVwtL1eckwTVEWNppgDkGPOGQuhsd4tDglwKIKyTF35XxXi2PRZS+bk35Si3XWSKsHdYJJZUPMN2k81E/5EZ4wOlpf7pxOLyLmHmCYsvw4DvuGbZjJFFEbHACldDdib1LygdVyVtkKbMX4UygoK66GDyheexj29wnDOBATKxq/LLSsaiu36rdqfdRYwPoiR+z34DZ1XhopgD3W56L+/jwWY0u1OH130BF35uVK4AEvY+TkwbKYNNKlPMGox2WznZ5aiElIMO+68uFXQM3eFCRs4dslomx6/gdoV78FZIlGjSdZap7dHft0SC62hyDZCfX40vDDQZPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8WVkyy5jklSyKjApiDm9yHn4euHvPUPC3h/A/6j8Lpo=;
 b=TD2MFuUHF+TCmuhj6SHWZyYlrRwAYDm8qBv0501hvsWc+6QGgg1mlKO0qfU2Tas2sUdiGdSovN8lOyddwJizF/phsDt7SthvpVc4VIRknc0Lps44PSXApwMXgI4RgN8ToMBZRrhYpH90wePsrtcG9tB8PiWxAjCWnn+SItLz1j7hEUCCghjmyd5+AVTClz1qQjBv8u7OGwHdTofPFJ7BM6ZVuDx2BjE00BrMkKXb0GmY9zDiQjXz3eB3efNjFaxMPrkS1gcvpS8AXTzMjgXJ9pSH9+Lx5wqfS4iq7AmpEznCdP/E6KNOWQnllLr6yAIICtcn4FIyP5sRak3wq7MquQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8WVkyy5jklSyKjApiDm9yHn4euHvPUPC3h/A/6j8Lpo=;
 b=U9ZvDTlvH+2ozO56Ebcxg5nOafuG1F41xuy+8hkDYWFAcy4vrSjlV5S9fiUJx4w6KxzVLupi5WxlFH9XZ4DZcafQZqCwDtyGjK8/2RIZmcWtlJy9Ly5XslL4XWu2uvLfq0aSBJFN4XgNaTtv9P9uvTVxfEhLWfQn+FHhR4nulm5SQGKz9wUurTmeUlQnxDg6OTcVeUi5gL0bHBwZ7vKD5UC+FzDRE6af0tHPue0xikYqxLc6d1sEi6BKv564DiEiZkD7El7t/FS89SuTU3Ors3QIFdq9v7BR9O8rbf5I0h4tvobgEUBAehP1NSQ1han4ogcbCkPrSLtrWSMiPRuQnA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by PH7PR12MB6905.namprd12.prod.outlook.com (2603:10b6:510:1b7::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.34; Tue, 17 Oct
 2023 18:11:47 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2%6]) with mapi id 15.20.6886.034; Tue, 17 Oct 2023
 18:11:47 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>,
	linux-arm-kernel@lists.infradead.org,
	Robin Murphy <robin.murphy@arm.com>,
	Will Deacon <will@kernel.org>
Cc: Nicolin Chen <nicolinc@nvidia.com>
Subject: [PATCH v2 1/5] iommu/arm-smmu: Reorganize arm_smmu_domain_add_master()
Date: Tue, 17 Oct 2023 15:11:40 -0300
Message-ID: <1-v2-c86cc8c2230e+160bb-smmu_newapi_jgg@nvidia.com>
In-Reply-To: <0-v2-c86cc8c2230e+160bb-smmu_newapi_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0074.namprd03.prod.outlook.com
 (2603:10b6:408:fc::19) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|PH7PR12MB6905:EE_
X-MS-Office365-Filtering-Correlation-Id: 49285d1c-b9a8-43c3-6cdd-08dbcf3c8659
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ak/y55AtH0A8ixMjpWPW5c4Y5sqvax4+qpOFQTQ/LyE2GWrz/fvwwhuBbPGUdX7xs+k+CR78kYeWn15lV/t6RT6WtjDeZ7m6AdSwdmsswLOum9Mz0kG61vAhehYRWqPNQHy3hLcwqYAfpXDokE9NakuGQ6Mbu6DdFIWBoqfVr3tdLpybKJYLRVHPf/qKU6vvUhb2srt3PrAXFIdHRN46k13li6k9gcaWCbsRmjmT++K+JTp1sCLTsmtgVvc5cOlFThXdTWXNijM1gLnt0rJu5xngxOXt1I2SUej+NeG59ckSRY3uCW0NrchmZ/g/CKbNLnEzJtkSmEiacBNZJmrv8QI2CYJdxHEutXGPIJXJ2lZN2F0+8e/kriytDTA4edhdkmfjW7jTLaP29kBM9Ps8BCG9pgsQyp9RoWYOSI/Qr0sr/FEr5VyJ7ILgCbT3aCvPVjRx6h4sO6YuhNhOhdSBZU71ST7y2YMXeKzM1sSwo7RYWaBozC47bsm4FY4ME75VIIVB+JizhUAbwlqJlPQzLzqhepMNEq7X5yXUJ4jCvN+bWA6pjftpHspU1rjCPsKQxyDpsagHJjwm1IOeSP5Y3KgIYLOyPk4V7/TyKY7I0gM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(366004)(376002)(346002)(136003)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(66946007)(6506007)(66556008)(107886003)(26005)(66476007)(6512007)(316002)(110136005)(5660300002)(8936002)(41300700001)(4326008)(2906002)(8676002)(2616005)(6486002)(6666004)(36756003)(478600001)(86362001)(83380400001)(38100700002)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tix9TEIGGh6dUVBm6r9HfHBgIi/upRwVgVII1BwPLTjehBxwOFlk3X9jdnI1?=
 =?us-ascii?Q?nvEoQMKU+oGu4D9HwKDil4G4e3tNEtTofDEyYHiJrvtfOV7CYEo8mwJCqAkH?=
 =?us-ascii?Q?1Tbbc4eeSzamGxDnsJwH6eWb4uZR7tSMtvJGEvk1Gr9AW/rjjiOP4NNqhOck?=
 =?us-ascii?Q?W+Ca/OzAlw13mkqFy97bsP6r4J18m2Z+kPgRbQfeQZznADyFjsf0Z2VyoOyT?=
 =?us-ascii?Q?j5Fmsz8/ROAoCyrf+i0NNg0SIqh0x69pq8zLq+2H1LDFt3pKJz3V8eIk/0F9?=
 =?us-ascii?Q?WXybLGmyFMuoiEp8nfvbF4rycLlAKfgR+IIgWS6abDZJ4E4AMwoRG99DPiZv?=
 =?us-ascii?Q?V2Fc8UiM1zCeKDWlz27XZMbXpt9+/dB2Gc1oAsUa17re7IHQLDfPpoxp88MT?=
 =?us-ascii?Q?Tu6X8ghu0BWTrvK/eYX5s/EdUS+9lt8zIDSdKy4VI/TcUrkk3584LUtUoVPh?=
 =?us-ascii?Q?Jt603+TuQHMAiQCaYQCdIDbV2IEsFOM9b15FqCwGSBTCXxmy2FzTK+4nVUTe?=
 =?us-ascii?Q?7bAs/Td85FyKYKilROXUQDHf4YXLgVisnYRGs8empewFaKxzb0S3Lv8x7NtM?=
 =?us-ascii?Q?nPhI2Qz6GI2jP3gFGtXFGVzC8nEOr7a6Y6wkYN93+uCbOzG2tP8sssTY8JZy?=
 =?us-ascii?Q?2ZYG7i4y+ntbyoJ7+eAHxh/INy+Lgs4lH7G3XOejHZKrDwvdCZYD88XBkJj0?=
 =?us-ascii?Q?GRFeg5QT4vDMrWDuHb7mfR5v2S7Qq7aqBDURZfLVdQlwtm8b2maklftoXZ3w?=
 =?us-ascii?Q?3xLuqWrpbN8Vb3hej8Rpwbwu93bw5nGEsJAr95cH/nwEZxgRd6oDREfO4dhW?=
 =?us-ascii?Q?NQZ0l5fDIPIYVQojiHdEmR2S50CVDT7lwUpTMUG1ysgQ9EK7ups261ObbO3H?=
 =?us-ascii?Q?BRInXE8wk+XnjGUNSfPDEhZdc83JOWktJ6HIz96EDq/c/qHsubcwzOMFXxGT?=
 =?us-ascii?Q?t1Cf/iedCXBuRo3bHxnuIwBrIMi+9ekrHcgOqWRm9QYkIoYh7Bsd/vjBJ32p?=
 =?us-ascii?Q?hvjhinYAd3V7xudoS0aXnL41Ed596xOGzFYFTYWB2+TrofGnrobqGakmpb8s?=
 =?us-ascii?Q?so4mLnwCNV1YER4MiaFfC25Hh8x7sOPB1X7CJBD+3q6HXWFTeA4V8A8OCsQ5?=
 =?us-ascii?Q?An2zq8pA6rEpk9e8ivhIEkQMSPUMSMwYoCWdV5l721T3SnxZY/+McGjEVqFT?=
 =?us-ascii?Q?SjBUjRj10tM86IzXs5FoXpg4bjtR1jCwCiQt082dYlvG89AyqXrRRBrIAHXK?=
 =?us-ascii?Q?U2rqPifFffmoZ1x/oQElxzjdhAo+pFWqCUDSnAuruB70yFJFZGagP/Un0S/a?=
 =?us-ascii?Q?J6fe5gD7Of7x9HpwhHWeBsva8IsTvlt3azW/1sioJWsmAs/7TRyurO2Wj/8E?=
 =?us-ascii?Q?tcoSnYxiW0ZfJOhtENNLXYseEyKj5LtV9vChdQwPFB4/0Xi1xdzi3NzV0Ran?=
 =?us-ascii?Q?pD+M1hwAS6HigFhNSJbnELD1Z6jf/9+tZ849IgvWcCV2VeJO18UcOb9hu0Da?=
 =?us-ascii?Q?hZsM3R6sCHgNtMzr/kB8rBFZs1lbwygOEdRXEQOgrxubvvHC75q79M80Pc71?=
 =?us-ascii?Q?w+ACXn5wVH20jfr+WxfLxUTQp94qRhzcdyXEylzt?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49285d1c-b9a8-43c3-6cdd-08dbcf3c8659
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2023 18:11:46.4271
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XXIqbEWgG5S5m8qUAbnx6Dy2nZuy5UBnEN0QgilbGNAwNber9GROYCwode+kAhiZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6905

Make arm_smmu_domain_add_master() not use the smmu_domain to detect the
s2cr configuration, instead pass it in as a parameter. It always returns
zero so make it return void.

Since it no longer really does anything to do with a domain call it
arm_smmu_master_install_s2crs().

This is done to make the next two patches able to re-use this code without
forcing the creation of a struct arm_smmu_domain.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/arm/arm-smmu/arm-smmu.c | 23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
index d6d1a2a55cc069..e2ec1fe14ed40b 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
@@ -1081,21 +1081,14 @@ static void arm_smmu_master_free_smes(struct arm_smmu_master_cfg *cfg,
 	mutex_unlock(&smmu->stream_map_mutex);
 }
 
-static int arm_smmu_domain_add_master(struct arm_smmu_domain *smmu_domain,
-				      struct arm_smmu_master_cfg *cfg,
-				      struct iommu_fwspec *fwspec)
+static void arm_smmu_master_install_s2crs(struct arm_smmu_master_cfg *cfg,
+					  enum arm_smmu_s2cr_type type,
+					  u8 cbndx, struct iommu_fwspec *fwspec)
 {
-	struct arm_smmu_device *smmu = smmu_domain->smmu;
+	struct arm_smmu_device *smmu = cfg->smmu;
 	struct arm_smmu_s2cr *s2cr = smmu->s2crs;
-	u8 cbndx = smmu_domain->cfg.cbndx;
-	enum arm_smmu_s2cr_type type;
 	int i, idx;
 
-	if (smmu_domain->stage == ARM_SMMU_DOMAIN_BYPASS)
-		type = S2CR_TYPE_BYPASS;
-	else
-		type = S2CR_TYPE_TRANS;
-
 	for_each_cfg_sme(cfg, fwspec, i, idx) {
 		if (type == s2cr[idx].type && cbndx == s2cr[idx].cbndx)
 			continue;
@@ -1105,7 +1098,6 @@ static int arm_smmu_domain_add_master(struct arm_smmu_domain *smmu_domain,
 		s2cr[idx].cbndx = cbndx;
 		arm_smmu_write_s2cr(smmu, idx);
 	}
-	return 0;
 }
 
 static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
@@ -1153,7 +1145,12 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 	}
 
 	/* Looks ok, so add the device to the domain */
-	ret = arm_smmu_domain_add_master(smmu_domain, cfg, fwspec);
+	arm_smmu_master_install_s2crs(cfg,
+				      smmu_domain->stage ==
+						      ARM_SMMU_DOMAIN_BYPASS ?
+					      S2CR_TYPE_BYPASS :
+					      S2CR_TYPE_TRANS,
+				      smmu_domain->cfg.cbndx, fwspec);
 
 	/*
 	 * Setup an autosuspend delay to avoid bouncing runpm state.
-- 
2.42.0

