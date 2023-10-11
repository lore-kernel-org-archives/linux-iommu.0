Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2088.outbound.protection.outlook.com [40.107.102.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A3E7405E2
	for <iommu@lists.linux.dev>; Wed, 11 Oct 2023 23:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="i9OoIAGA"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hvRavoyKbixAedMrv3oVb4OFmizgPtezO3IdJX4Kdhv6n57E89g+r9iGOqVtbDZ9Ataj05JKAbCCfYFm3UB84bfz/XBZ2WgBMAPMuOgGWlYl+lj9cSO7U/xytFnhmMMm/gb+ecMsICoLBDkusYGDmzHzISGi9LBJI1hGDwrleao4WHaojcIn07T5xcPoj9qsRrBjGb/AvKOtlzvRLTYICKWLHPAT959qr9rGCy0Wq9qcdsZXwGwOiUsOJATh7jWVCZ/2EmLddvyrysCqcHtjpFIYEoytoFzIDFyzB9iOskam+duuIuWl7jDPjXvnubyDTry1qVNiQdrVG9UKIHaepw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+U01yDV1v0DoFTSuNI2hRHNv0TDMvrohaeDJAbWVkwM=;
 b=Yg19XNYwRVDxYXYBGQGVNP+icujRrY/VkigM54//Yrrw36dZiRvlAhb4tJ0ivdl9UHgMPvRNIT5rUzLcgenK2jgGOwbQYkrXhSTYogtAxTzoEfWmuNgIBYSSMLR8hnWM06C5SodNk6kiCOR3jYssDRh1GCqVp/EMr7NYK/jnQdOkwbqM1l+EUGPyxPIuQuFLmYHfmpxGFZOlUZUjhT91LqfsHDIf4sB7Ic74eIYrAzvRW1Ki/f8SVui/T68BCtRrvc2s9mesURB2KeN/aYRnlcAjwipastwUA1MLZWLRrFNT8G8xJz6wZk51siSjgd7O+gOThfv9Ivj9+RAHfJ140w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+U01yDV1v0DoFTSuNI2hRHNv0TDMvrohaeDJAbWVkwM=;
 b=i9OoIAGAv9eyET2MZwoJ4RrFLD4QoXhDg9NvAIuh28xpU1kLHoWSN9b5T8hkQCeFK0OlL0NO6MIfqnTRJMoJFBjW4gEc5jcg0c9HT0UzOZGmNOt7keghVzNOKihSYSPMu4j9ZecKO5+eRwE5xZqrC3jhtPN5XqKIbl1+BxW49j9TgEb5Cu83xO/yXagD9GPLu5RgtB+1jo1PkSOFAiPbyOybMqfVGoeZd+YmsgUWdR0kj1oE1QB3fOrOx/gsdIUkXM84qTJ+OcGgGJVg93E/e6MX2YRVnGYoHszfULL3x6Wyub29JILEuzjADJfelqBn4whZ6RNyHHwKWRU+erbzMQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by PH7PR12MB7380.namprd12.prod.outlook.com (2603:10b6:510:20f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.31; Wed, 11 Oct
 2023 23:26:14 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2%6]) with mapi id 15.20.6863.032; Wed, 11 Oct 2023
 23:26:14 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>,
	linux-arm-kernel@lists.infradead.org,
	Robin Murphy <robin.murphy@arm.com>,
	Will Deacon <will@kernel.org>
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Michael Shavit <mshavit@google.com>,
	Nicolin Chen <nicolinc@nvidia.com>
Subject: [PATCH 27/27] iommu/arm-smmu-v3: Allow setting a S1 domain to a PASID
Date: Wed, 11 Oct 2023 20:26:03 -0300
Message-ID: <27-v1-afbb86647bbd+5-smmuv3_newapi_p2_jgg@nvidia.com>
In-Reply-To: <0-v1-afbb86647bbd+5-smmuv3_newapi_p2_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0009.namprd13.prod.outlook.com
 (2603:10b6:208:256::14) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|PH7PR12MB7380:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c7724bd-745a-43f8-9506-08dbcab1710a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	b3G2BYsPjFRHEd67eQN9vuyDb1L1XRj8dLxAUIyc582SlGh8CuUsvHd4kQ4fV0a2l9kMLNhYesQJgaVWfsjd0L9rSw7V0CxBu6GiNi+nVusp9fxq3QwWbibyzO9TlIf6eENeteGniflTTPQUuO1HJTKJquWCdViJUsfEtpCJ26vUmjXsHs2EYInhOFlF5ILce8x7M918aJ8qe8WJ+Wgi/dkyRU4HS3/dpBFksYrcW7JHF0FPVk8yRqQ+F9AEtPDvZ7QIPzpgjT04O7ZOqb1hEkJyx53e085CxW1a6r5Fmt9LMtNsUemNgd7PoAyXajodOwE1L/SKz6PXohg9+3GXp4SmZ4E2PJi/NGpv+14fHVCDgaKqJ+HDOHAr/t3IcGKDyI5ElaDk4vTdhrENFmgADZl/BXu3L4bcjYApqgZxVZ0oLB0Ia+w9jj7lCQy2RX+pClsei4ZPPWlS7yrB3vOscKzeQK6dQXymsFXkcEbcPIvwrxRtCGgvuZvtRTjaMLzuNiIsJBE7spuOB/oZIVdZacYqZM1645QhG6g6Ne/1qen5jJkIUo9bp3WhS/aordxQ
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(346002)(376002)(366004)(136003)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(36756003)(6512007)(6506007)(8676002)(2616005)(83380400001)(26005)(107886003)(6486002)(6666004)(478600001)(38100700002)(4326008)(86362001)(41300700001)(66556008)(8936002)(316002)(2906002)(66476007)(110136005)(66946007)(54906003)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DkNHyKm9X7lfcmx8/REPEha8PHH80lNkcTBAZOilJEOBnS2eg20bWxmj3knd?=
 =?us-ascii?Q?uuobC72CTD2KZq29OP2YUX43AkkANLRbZv4oKZCnwY+nyg+bstUWqHmUuqGP?=
 =?us-ascii?Q?h7TRjinxDf8LXwqVDvBFb5akG4bLeG1g+5zvCCNMKgdfHSEAdHaJj1L7eOR1?=
 =?us-ascii?Q?90isMdDiWJ4uO8ltBHKcNXaAjk5mUbg9nYl8wXJtdmSUNT/93fQsKMCtqe90?=
 =?us-ascii?Q?2/dS/99I2QtkX2elMHioeGagL9XpIjXmM+DOnE9RAsyvSn87p612aDh/cHFR?=
 =?us-ascii?Q?Y5X96fHFL28MQERQpDuRXJ3kWK9Z7+cg6osNV1CTX6Gw+oFoQ/KyaRUCllWZ?=
 =?us-ascii?Q?y9o68RAvgRBNJqk2WgxVAKZXb90jYiVUTjUfy9yVlpL9rLp5UEuaaM12tIcW?=
 =?us-ascii?Q?xJeyKw4lODToDcSKZ4soEMwY/Ijcyk0qQ/KxKTMMZotG/SdF40qISLfUmsFZ?=
 =?us-ascii?Q?736GFmVmSUsKJjNFWjGp7p3tsuoFd3DH5hV0biE9kmZS38rEa3F2QxwK5l1B?=
 =?us-ascii?Q?TnxoswJMEnUtuYO2hjBEf2B2321irz9J5936yP1L7rR++ivmkDrnvFZBpCCq?=
 =?us-ascii?Q?zpnynYS5L2kAf6HXkxgBWWs2+CzVGcA1lZV7G7tILEe3h3GD1Bm4EVt/jPB+?=
 =?us-ascii?Q?PI/r/i0E5HhQlmU97vMAAdtF7ba+r/qISs6nix2cZD+7bFu/6QPPC+fU0Exn?=
 =?us-ascii?Q?3yb5LytY98VzwF1Lb0LIokcQp/r6uIYclVjSd9SvUljjJmVmA9l6AKz6DIva?=
 =?us-ascii?Q?v/eClQTgCkQNiFAzLiQSTAdXenrNgqC+mQUvf8MqdC7uLCpuZg2r+X9Z4TES?=
 =?us-ascii?Q?GtW4R+ExI4AqErDpk1xD9UY0WOz4unl94sE/v3waY5uybrdZLI3fZDSqeVnj?=
 =?us-ascii?Q?BzHO/3VRyjK5y3AUdD4M1co4NDXeXlZCPzSahuCydprPMKHlHprE4a1RygBQ?=
 =?us-ascii?Q?goJk5IH13Li/5VhKkCaihUy0CLPW2NecECGuBDumHOhLOkuCyMv8ogEn466l?=
 =?us-ascii?Q?sVSnmdBGMVBIIRZC6TVPfX5FycdOT7q93Nxr02b1i6JRi9S5zxpICj05gTMu?=
 =?us-ascii?Q?1M6PUUnUZUf5D+51obgHaYRnRy2akTLOLhhhM+B0LVR66qSVwwvwnKcubsYR?=
 =?us-ascii?Q?RnRAVF6ZWJ0YRzjSywHEQ5Lw09sJP2jw6J8PdTdqiLybBnAZioHdLS21Geju?=
 =?us-ascii?Q?9GSVoigOHGCWsUna7N6qKpoVAO3mbRtbtquoZXNdesQCZImW3W1OLLj0rprq?=
 =?us-ascii?Q?1S0Ji+cqcsRMw06czn5fGMCIi0dYqMc38hIVAjcpGGGkZful3SHUR5ELvcrm?=
 =?us-ascii?Q?2ln+NXpqOp1wMIpNGWaBZGDXa0UmZ6wbjcAIIdkTozeEB676i90x0mwP0atx?=
 =?us-ascii?Q?eUKqncqHg+6WF/RFhPFiZptJZGb3ZLEovTZOOlxsxguSFcKh+jpyd1PRGpH5?=
 =?us-ascii?Q?lCj0hgJqC1+MpG4a3iqJG1KJpuch8BB1j4vDmv9nF6d4K6oRin1jbeegEgQb?=
 =?us-ascii?Q?fB0t6CmdQw8h1Ft4+SG7FUQqM/R3iBLU1P51Q9BrSoiorhXeAQBQmLoHBSa1?=
 =?us-ascii?Q?cmUAoKk+vEevOEo9tIyP7vUJyLm8U0Ga5aZ4+t4M?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c7724bd-745a-43f8-9506-08dbcab1710a
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2023 23:26:05.8731
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NWtdafpv4MtBWx84D2zTYwesyL1bE1Oj979EUttUwHuvxJJB5POXLxhyu8sAhbGf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7380

The SVA cleanup made the SSID logic entirely general so all we need to do
is call it with the correct cd table entry for a S1 domain.

This is slightly tricky because of the ASID and how the locking works, the
simple fix is to just update the ASID once we get the right locks.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 45 +++++++++++++++++++--
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  2 +-
 2 files changed, 42 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 8eef125018d082..d5ba85034c1386 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -1185,8 +1185,6 @@ void arm_smmu_make_s1_cd(struct arm_smmu_cd *target,
 	typeof(&pgtbl_cfg->arm_lpae_s1_cfg.tcr) tcr =
 		&pgtbl_cfg->arm_lpae_s1_cfg.tcr;
 
-	lockdep_assert_held(&master->smmu->asid_lock);
-
 	memset(target, 0, sizeof(*target));
 
 	target->data[0] = cpu_to_le64(
@@ -2697,6 +2695,36 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 	return 0;
 }
 
+static int arm_smmu_s1_set_dev_pasid(struct iommu_domain *domain,
+				      struct device *dev, ioasid_t id)
+{
+	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
+	struct arm_smmu_master *master = dev_iommu_priv_get(dev);
+	struct arm_smmu_device *smmu = master->smmu;
+	struct arm_smmu_cd target_cd;
+	int ret = 0;
+
+	mutex_lock(&smmu_domain->init_mutex);
+	if (!smmu_domain->smmu)
+		ret = arm_smmu_domain_finalise(smmu_domain, smmu);
+	else if (smmu_domain->smmu != smmu)
+		ret = -EINVAL;
+	mutex_unlock(&smmu_domain->init_mutex);
+	if (ret)
+		return ret;
+
+	if (smmu_domain->stage != ARM_SMMU_DOMAIN_S1)
+		return -EINVAL;
+
+	/*
+	 * We can read cd.asid outside the lock because arm_smmu_set_pasid()
+	 * will fix it
+	 */
+	arm_smmu_make_s1_cd(&target_cd, master, smmu_domain);
+	return arm_smmu_set_pasid(master, to_smmu_domain(domain), id,
+				  &target_cd);
+}
+
 static void arm_smmu_update_ste(struct arm_smmu_master *master,
 				struct iommu_domain *sid_domain,
 				bool want_ats)
@@ -2725,7 +2753,7 @@ static void arm_smmu_update_ste(struct arm_smmu_master *master,
 
 int arm_smmu_set_pasid(struct arm_smmu_master *master,
 		       struct arm_smmu_domain *smmu_domain, ioasid_t id,
-		       const struct arm_smmu_cd *cd)
+		       struct arm_smmu_cd *cd)
 {
 	struct iommu_domain *sid_domain = iommu_get_domain_for_dev(master->dev);
 	struct arm_smmu_cd *cdptr;
@@ -2749,6 +2777,14 @@ int arm_smmu_set_pasid(struct arm_smmu_master *master,
 	if (ret)
 		goto out_unlock;
 
+	/*
+	 * We don't want to obtain to the asid_lock too early, so fix up the
+	 * caller set ASID under the lock in case it changed.
+	 */
+	cd->data[0] &= ~cpu_to_le64(CTXDESC_CD_0_ASID);
+	cd->data[0] |= cpu_to_le64(
+		FIELD_PREP(CTXDESC_CD_0_ASID, smmu_domain->cd.asid));
+
 	arm_smmu_write_cd_entry(master, id, cdptr, cd);
 	arm_smmu_update_ste(master, sid_domain, state.want_ats);
 
@@ -2770,7 +2806,7 @@ static void arm_smmu_remove_dev_pasid(struct device *dev, ioasid_t pasid)
 	struct iommu_domain *domain;
 	bool last_ssid = master->cd_table.used_ssids == 1;
 
-	domain = iommu_get_domain_for_dev_pasid(dev, pasid, IOMMU_DOMAIN_SVA);
+	domain = iommu_get_domain_for_dev_pasid(dev, pasid, 0);
 	if (WARN_ON(IS_ERR(domain)) || !domain)
 		return;
 
@@ -3272,6 +3308,7 @@ static struct iommu_ops arm_smmu_ops = {
 	.owner			= THIS_MODULE,
 	.default_domain_ops = &(const struct iommu_domain_ops) {
 		.attach_dev		= arm_smmu_attach_dev,
+		.set_dev_pasid		= arm_smmu_s1_set_dev_pasid,
 		.map_pages		= arm_smmu_map_pages,
 		.unmap_pages		= arm_smmu_unmap_pages,
 		.flush_iotlb_all	= arm_smmu_flush_iotlb_all,
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 5cb3b602b6baf2..74f6f9e28c6e84 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -786,7 +786,7 @@ void arm_smmu_write_cd_entry(struct arm_smmu_master *master, int ssid,
 
 int arm_smmu_set_pasid(struct arm_smmu_master *master,
 		       struct arm_smmu_domain *smmu_domain, ioasid_t id,
-		       const struct arm_smmu_cd *cd);
+		       struct arm_smmu_cd *cd);
 void arm_smmu_remove_pasid(struct arm_smmu_master *master,
 			   struct arm_smmu_domain *smmu_domain, ioasid_t id);
 
-- 
2.42.0

