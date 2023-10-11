Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2064.outbound.protection.outlook.com [40.107.93.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3D229CA4A
	for <iommu@lists.linux.dev>; Wed, 11 Oct 2023 23:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QzzJa4J8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KNE68wgJoJHCEkBDwQnWNgM8XhTa2/21qfe9rKmEjTm8jmcoigkpecGlXeMSljX09lQ070Zgm7mChohuagQeVJ8rttbHNxYgxeihdc4YW/4tHlKdOCZ8ptFvJm/XJDHKwnx41e1VFh6B/bPGZv9GtFKWRB8q1dPhJCNukEQSP4uAWfjLadrukLFL5e47Nm/pGb1DDKBwmweqnNe6Y75syN6VKLHxINcIfNgkgZtB3tZPGOWE1cR0UA0JH6+ivJJzGHUDPMSreN1MS4ap1jPR0R31Cl6wijc+H1ojQZFG4rq7FtKHGmo6/wrztaLJw8Pv/H2hPPPJa7sFfpLbTGONvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xXlW5cEmf2lXDw1C4CnyfiShh3KU/QTq/1qtcAlXgyQ=;
 b=QYc39dDAno0P8ZS8ubtA16zsbcR34CrcbQltKGX0RN59TH7ghzqgwaGraqUFiAAVlUnG5QnirzBocFnV5lF57WApdlceLIfihrZobzfrYfWQbBXAoDU+0R8Y1A9SJwJqSZxyOjtNFFT1CXMUjwDtXa7h24MDIfIPxNbdZktVvWyYveFIJEbzNY22E+F1KXbGF7OknJ0gNpnHVJp2QMp8+PDb4VYBrjU89M+4J33oSMrjHPlrUSAWpZoGt1czSTcEEW1hUxaAlitjVR3l37SGa4dl3pyt8TwWNUC9uzrZLbn+9JZpBcl+mRe8iS0YrAar4Mke/EKZvZlTatsEaG3dGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xXlW5cEmf2lXDw1C4CnyfiShh3KU/QTq/1qtcAlXgyQ=;
 b=QzzJa4J8Jpjq3ES3u/yoolJGoh88b1xlnlfuHMizTGi4lx76V07734DT2kIVvtA2EoXGLT8/NNty/e1Tw+uWIh9mTEU9e8jkeFw16EU2//QLreUh/6IYf4XzQ0mmxD6XA3fFDICTfsXuNV3JGCvL4A6ta6m5/SwwCWufcrkNReiIP1RavLrb5a5EKo+/vO5KSam6bUtqRgu8qUVfu7FMvskv/kPA4W2JaDu7B41vmlt2Wa/6TVin/RsTT1+2P7ttQGlcBCAhOVBj7BVW0B5S1Ir7odOLyUqecH11Ge6Xerdl9Aa77314uasxE9GrZ1hXmP9+M4tMXQJZJ7WncQdA6g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CH0PR12MB8488.namprd12.prod.outlook.com (2603:10b6:610:18d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Wed, 11 Oct
 2023 23:26:13 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2%6]) with mapi id 15.20.6863.032; Wed, 11 Oct 2023
 23:26:13 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>,
	linux-arm-kernel@lists.infradead.org,
	Robin Murphy <robin.murphy@arm.com>,
	Will Deacon <will@kernel.org>
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Michael Shavit <mshavit@google.com>,
	Nicolin Chen <nicolinc@nvidia.com>
Subject: [PATCH 23/27] iommu/arm-smmu-v3: Move the arm_smmu_asid_xa to per-smmu like vmid
Date: Wed, 11 Oct 2023 20:25:59 -0300
Message-ID: <23-v1-afbb86647bbd+5-smmuv3_newapi_p2_jgg@nvidia.com>
In-Reply-To: <0-v1-afbb86647bbd+5-smmuv3_newapi_p2_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR20CA0057.namprd20.prod.outlook.com
 (2603:10b6:208:235::26) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CH0PR12MB8488:EE_
X-MS-Office365-Filtering-Correlation-Id: bc73ad48-a6ce-4a46-d381-08dbcab170e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	GOFIuvLeNch8GhUrsP6Gophy7Mp3PkOrU990WxFPFHrrKbemPnzHty/uD/l0Od6ldigt2c26KE20tsuKda1/ffXu1Qf+dTdA7MV++F4IjE/IcYTA0a1CH0UXJ0PPc0cE2CjwBKKG+/qcUEyLfpvqAsJZjNpfdMiMRwlaLvbF47p5RNRPRhdjcOtL1tYqeK8hpd4E8RS2qAtPjfUa4eMe3xM3NFtE2HYO7I2pdZeYkoAFFbNMFHOz2kdvotTH2DMoJG7lwfVumP2igPlgZ8pBnLZOVCj5k5MtW9APROznbLo64Kc+uhenYiLypkgKwBXjs8BXAPsc6SGV26hmcFUWFBk9B4W/CidnyWRa2onkLqHJb/ZhM5IY2LtBsNFluXkxXlhyF03AHFb8gCq96l7YMWL+fEE/LMfkmdJt2+tKORmJMD5rG41BgEUNQQAbBZbFm33Y45vSNCSdySdbZjpg18SMNonUmO/119xN2cZUXupydclNbhryp0XSA55rvwdEbO5MUuFNJ0RQSghiPNkLy2w3dPlKWevy3EhH0tUFqzwqwebPWP+b5I6JHI7PnWvI
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(39860400002)(376002)(346002)(136003)(230922051799003)(1800799009)(451199024)(64100799003)(186009)(66476007)(66556008)(8936002)(66946007)(316002)(54906003)(110136005)(2906002)(5660300002)(41300700001)(8676002)(4326008)(6486002)(38100700002)(2616005)(6666004)(107886003)(36756003)(26005)(6512007)(83380400001)(478600001)(86362001)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gxLTAM6JqGqLTYNHIGTMscfoQ4DohKEejVmGDOnc1+EVA+G23LEjdpZMRbDf?=
 =?us-ascii?Q?xOHexPQ8kgzLXf7eAnhrsAwBnMrn4gBfv5SPcrP/QPUx3qmgL4e4PizPCTaz?=
 =?us-ascii?Q?JcoR4akBafBPfyYwwBZUUyT52uSOFO4ZOW/1rdMyqBz+5mMHabCKOh3a0lcg?=
 =?us-ascii?Q?hNM25urEjX+Lb5EXf0rz+vUXFkDmQXEp1SdaUxCB0qXASnjPM+GSfE4CX1Nu?=
 =?us-ascii?Q?dBznnyuIzLT0s0UIzKlmTlPUeuhB4gFIehi8cSbHyXuvJNJqxa9W6JNIJZzm?=
 =?us-ascii?Q?+5M6y/xvRGyvAcG+PkyUwXU9PKx3gY8gnFDVbQLl5rjBUA1uDV9Lqr7aUX7b?=
 =?us-ascii?Q?Umq2nbfGHt+jT6tSKTPHhOUleWP3xRMCc0v4+tD9xI+ng9B5XMIv4g2naDTv?=
 =?us-ascii?Q?PD2Yki1k7qcMRcYmsh/9CLsmueb9apfkfiLHBspchCAN/XJlDUIkOBK6MD/I?=
 =?us-ascii?Q?m43VltGa4HNB5VmYLKAIsZHU042zfxcEUjLQgkA9XGLh5rKdHS1GBkBi7TOF?=
 =?us-ascii?Q?BMmTlaxnjaLJy+nWajlEOdYP8APKCjuK6isarGcWurTTa0rdTTArF3yRLuU0?=
 =?us-ascii?Q?fQiw5MLUIBYWRIaACcfFZoYcRoLofLDGD/Jbv/QDdEyXQxgG0Qhe9NsWp6Xm?=
 =?us-ascii?Q?ZDiwMlDeCR37mVZGzaaY0S6bGOi6ufV8HZS+b/iNXuuplqrULh6hY+F9OtEM?=
 =?us-ascii?Q?agOuQppdpqRoX0t4tkNAe0o7cn9Ql4tgYys7aASPxqTVBHexyNUCMWAmnY6Z?=
 =?us-ascii?Q?+G508Xe4xB/esVb+4PXC8SmXwTVhYjzoW+zRkwxj3gO+9dertgsSmX02kh8N?=
 =?us-ascii?Q?m+WCqKUmRZi8atgnEgauuDyWESmzdQbpvt8PTbZgUSaZPw7HWNVlMT0tKoS1?=
 =?us-ascii?Q?UuaXNywGF4lO7N3DrxKxpLo1L5E7M1R+BsUGbpTrYXyb7oK/aVpbv9pEypy2?=
 =?us-ascii?Q?Pty1/aGiq7beYKUiZhbgk2Mb788700BTfPgvBqCIfnQl8n0Ka03SnPTrRR4R?=
 =?us-ascii?Q?E6M3VLLzUQZNgla58ZRwS1GV5vcQRTCVvhJ6IRT1E7P5sLCOmP+kYcsiK2oO?=
 =?us-ascii?Q?mLmQiHSFzJm4ZhXd03qvpXSQL7HQEo3SwClF6ece/m25vXoF8I7g3kADaNdc?=
 =?us-ascii?Q?zyQxi7DI1QaKHPiE+OtmUw2lIK/tFfGswHhWee2Q4o07j1UJVYG/xXxqJmQ+?=
 =?us-ascii?Q?xmAy5F41oZpdRhZQgXl2O7Bt3bpxkaCvek5UHHn8y104F6HuI/l7Dty8/aw1?=
 =?us-ascii?Q?31xxT8ieevbwIPANZ7Ud23rwmDgltnl7rZ7D7a3tXykxaDoPZ1Lb3jOFHK7p?=
 =?us-ascii?Q?iKz3Hj0uMzyW8XeTq43g42jUDfVjwwdoTTAVZAOghR8c1cqIqa0km8zKdSA4?=
 =?us-ascii?Q?5p8kBh3z5b0H2ViK+gMcT42jQZ9uwbHHqRiIF/iwtKp/j0sxg/47/fxbzMsK?=
 =?us-ascii?Q?v8i8B/IHWcIhheEgvQ4Hdd0Yj2DKLXC2e6balYK/uWyoNiLym30UBFt805M9?=
 =?us-ascii?Q?GbHDoRqpVcenh80G8LZmwDIxkjd2+aUXJbjQE9EIRg9Db6QlpYWuo8pDPLD5?=
 =?us-ascii?Q?Ob44fuuZFJpLtgu7hmpg0kUTOf2qNtFBjqSpa13p?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc73ad48-a6ce-4a46-d381-08dbcab170e6
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2023 23:26:05.5999
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DQuGcG/RXlV05M5B3jZwiqfmQWOtLPqix1n2uX9UCFrk406G50AWS2a4YH/2kIS3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8488

The SVA BTM and shared cd code was the only thing keeping this as a global
array. Now that is out of the way we can move it to per-smmu.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c   |  2 +-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 39 +++++++++----------
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  5 +--
 3 files changed, 22 insertions(+), 24 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
index 66de6cb62f9387..aa238d463cf808 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
@@ -407,7 +407,7 @@ struct iommu_domain *arm_smmu_sva_domain_alloc(struct device *dev,
 	smmu_domain->domain.ops = &arm_smmu_sva_domain_ops;
 	smmu_domain->smmu = smmu;
 
-	ret = xa_alloc(&arm_smmu_asid_xa, &asid, smmu_domain,
+	ret = xa_alloc(&smmu->asid_map, &asid, smmu_domain,
 		       XA_LIMIT(1, (1 << smmu->asid_bits) - 1), GFP_KERNEL);
 	if (ret)
 		goto err_free;
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 322add56bbdfe7..e9265026fe555b 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -71,9 +71,6 @@ struct arm_smmu_option_prop {
 	const char *prop;
 };
 
-DEFINE_XARRAY_ALLOC1(arm_smmu_asid_xa);
-DEFINE_MUTEX(arm_smmu_asid_lock);
-
 static struct arm_smmu_option_prop arm_smmu_options[] = {
 	{ ARM_SMMU_OPT_SKIP_PREFETCH, "hisilicon,broken-prefetch-cmd" },
 	{ ARM_SMMU_OPT_PAGE0_REGS_ONLY, "cavium,cn9900-broken-page1-regspace"},
@@ -2221,9 +2218,9 @@ void arm_smmu_domain_free_id(struct arm_smmu_domain *smmu_domain)
 		arm_smmu_tlb_inv_asid(smmu, smmu_domain->cd.asid);
 
 		/* Prevent SVA from touching the CD while we're freeing it */
-		mutex_lock(&arm_smmu_asid_lock);
-		xa_erase(&arm_smmu_asid_xa, smmu_domain->cd.asid);
-		mutex_unlock(&arm_smmu_asid_lock);
+		mutex_lock(&smmu->asid_lock);
+		xa_erase(&smmu->asid_map, smmu_domain->cd.asid);
+		mutex_unlock(&smmu->asid_lock);
 	} else if (smmu_domain->stage == ARM_SMMU_DOMAIN_S2 &&
 		   smmu_domain->s2_cfg.vmid) {
 		struct arm_smmu_cmdq_ent cmd = {
@@ -2253,11 +2250,11 @@ static int arm_smmu_domain_finalise_s1(struct arm_smmu_device *smmu,
 	struct arm_smmu_ctx_desc *cd = &smmu_domain->cd;
 
 	/* Prevent SVA from modifying the ASID until it is written to the CD */
-	mutex_lock(&arm_smmu_asid_lock);
-	ret = xa_alloc(&arm_smmu_asid_xa, &asid, cd,
+	mutex_lock(&smmu->asid_lock);
+	ret = xa_alloc(&smmu->asid_map, &asid, cd,
 		       XA_LIMIT(1, (1 << smmu->asid_bits) - 1), GFP_KERNEL);
 	cd->asid	= (u16)asid;
-	mutex_unlock(&arm_smmu_asid_lock);
+	mutex_unlock(&smmu->asid_lock);
 	return ret;
 }
 
@@ -2518,7 +2515,7 @@ static int arm_smmu_attach_prepare(struct arm_smmu_master *master,
 	 * arm_smmu_master_domain contents otherwise it could randomly write one
 	 * or the other to the CD.
 	 */
-	lockdep_assert_held(&arm_smmu_asid_lock);
+	lockdep_assert_held(&master->smmu->asid_lock);
 
 	master_domain = kzalloc(sizeof(*master_domain), GFP_KERNEL);
 	if (!master_domain)
@@ -2563,7 +2560,7 @@ static void arm_smmu_attach_commit(struct arm_smmu_master *master,
 				   struct arm_smmu_domain *new_smmu_domain,
 				   ioasid_t ssid, struct attach_state *state)
 {
-	lockdep_assert_held(&arm_smmu_asid_lock);
+	lockdep_assert_held(&master->smmu->asid_lock);
 
 	if (!state->want_ats) {
 		WARN_ON(master->ats_enabled);
@@ -2657,12 +2654,12 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 	 * This allows the STE and the smmu_domain->devices list to
 	 * be inconsistent during this routine.
 	 */
-	mutex_lock(&arm_smmu_asid_lock);
+	mutex_lock(&smmu->asid_lock);
 
 	ret = arm_smmu_attach_prepare(master, smmu_domain, IOMMU_NO_PASID,
 				      &state);
 	if (ret) {
-		mutex_unlock(&arm_smmu_asid_lock);
+		mutex_unlock(&smmu->asid_lock);
 		return ret;
 	}
 
@@ -2689,7 +2686,7 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 	arm_smmu_attach_commit(
 		master, to_smmu_domain_safe(iommu_get_domain_for_dev(dev)),
 		smmu_domain, IOMMU_NO_PASID, &state);
-	mutex_unlock(&arm_smmu_asid_lock);
+	mutex_unlock(&smmu->asid_lock);
 	return 0;
 }
 
@@ -2713,7 +2710,7 @@ int arm_smmu_set_pasid(struct arm_smmu_master *master,
 	if (!cdptr)
 		return -ENOMEM;
 
-	mutex_lock(&arm_smmu_asid_lock);
+	mutex_lock(&master->smmu->asid_lock);
 	ret = arm_smmu_attach_prepare(master, smmu_domain, id, &state);
 	if (ret)
 		goto out_unlock;
@@ -2727,7 +2724,7 @@ int arm_smmu_set_pasid(struct arm_smmu_master *master,
 		smmu_domain, id, &state);
 
 out_unlock:
-	mutex_unlock(&arm_smmu_asid_lock);
+	mutex_unlock(&master->smmu->asid_lock);
 	return 0;
 }
 
@@ -2743,10 +2740,10 @@ static void arm_smmu_remove_dev_pasid(struct device *dev, ioasid_t pasid)
 
 	smmu_domain = to_smmu_domain(domain);
 
-	mutex_lock(&arm_smmu_asid_lock);
+	mutex_lock(&master->smmu->asid_lock);
 	arm_smmu_attach_remove(master, smmu_domain, pasid);
 	arm_smmu_clear_cd(master, pasid);
-	mutex_unlock(&arm_smmu_asid_lock);
+	mutex_unlock(&master->smmu->asid_lock);
 }
 
 static int arm_smmu_attach_dev_ste(struct device *dev,
@@ -2761,7 +2758,7 @@ static int arm_smmu_attach_dev_ste(struct device *dev,
 	 * Do not allow any ASID to be changed while are working on the STE,
 	 * otherwise we could miss invalidations.
 	 */
-	mutex_lock(&arm_smmu_asid_lock);
+	mutex_lock(&master->smmu->asid_lock);
 
 	/*
 	 * The SMMU does not support enabling ATS with bypass/abort. When the
@@ -2776,7 +2773,7 @@ static int arm_smmu_attach_dev_ste(struct device *dev,
 		IOMMU_NO_PASID);
 
 	arm_smmu_install_ste_for_dev(master, ste);
-	mutex_unlock(&arm_smmu_asid_lock);
+	mutex_unlock(&master->smmu->asid_lock);
 
 	/*
 	 * This has to be done after removing the master from the
@@ -3434,6 +3431,8 @@ static int arm_smmu_init_strtab(struct arm_smmu_device *smmu)
 	smmu->strtab_cfg.strtab_base = reg;
 
 	ida_init(&smmu->vmid_map);
+	xa_init_flags(&smmu->asid_map, XA_FLAGS_ALLOC1);
+	mutex_init(&smmu->asid_lock);
 
 	return 0;
 }
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index a24d37e0212eac..8e13fe136f1bbe 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -675,6 +675,8 @@ struct arm_smmu_device {
 
 #define ARM_SMMU_MAX_ASIDS		(1 << 16)
 	unsigned int			asid_bits;
+	struct xarray			asid_map;
+	struct mutex			asid_lock;
 
 #define ARM_SMMU_MAX_VMIDS		(1 << 16)
 	unsigned int			vmid_bits;
@@ -768,9 +770,6 @@ to_smmu_domain_safe(struct iommu_domain *domain)
 	return NULL;
 }
 
-extern struct xarray arm_smmu_asid_xa;
-extern struct mutex arm_smmu_asid_lock;
-
 struct arm_smmu_domain *arm_smmu_domain_alloc(void);
 
 void arm_smmu_clear_cd(struct arm_smmu_master *master, int ssid);
-- 
2.42.0

