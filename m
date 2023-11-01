Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2089.outbound.protection.outlook.com [40.107.100.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E58D11C6B5
	for <iommu@lists.linux.dev>; Wed,  1 Nov 2023 23:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XfK97EqD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L3toJha1yfQMn46P6pdsq7E/7ROaQXMawoeO9wA9xYvo0ghFgI5OmofgZO27bc3M5FNPkNkN/WhviK0BCwpy9VeHKB+u0NrVFXcH2li/R15MqiUYrng1/Td/PTzNjDjJrh6+i8u4iweGxm9hU5mbthRGYiaCgEm96piYvEtRnC3XtJYL1k6n2MntCQKIcAXBUT+iHAMPLY8O96mERhIKe8HumWIPWmE+4uOMpc6HYrDs05GTl0rFUyUtutMZ1ksQkWSGoaakeD9diswqHMBVZqOAjCME16G6ujVvV+OMff4ieEv8GN99qih7YTQ/FHOP3HyS03wyvWlBtVbsan3fRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jGjiY+BsSfMWK/Q13JqlthIt1T1RVrJZ3zIkNmN2cxA=;
 b=KApcz9qEnRooZZEaxRRz2y7/KS3SgFHfv52A+WYER1KS3exhuL+NQ6UF35ihgf7hgTDLfvYE50Srf7GYkeDOGmdqzpG1iZfaurcA42tmqKRKM+4ycbJM6ys4uXTx0Vr26/dbjJ1eZPboLvY5P7bHos8nvjOBTT7d+Di57ajyJ0umNKd9vpchGeBWtAhyyR0rpgnXpc+OJMatkXvgGro1f0sK68mBtWY0JX5QIuOKTJ89RIGqbmEH3/9TG/Kcu4GzdMpjHxcC8l4Vf4827Td5e0U5fXEKWRP/VOr+eleE5zC9ZK1qKIhYyTEpxA8lfDAHbwQB4QjRkIewp3C2mejsNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jGjiY+BsSfMWK/Q13JqlthIt1T1RVrJZ3zIkNmN2cxA=;
 b=XfK97EqDj11fk+QKexnVFNAZ+Ha8SnNp0kiyOGlECIbTTCKLmK4+SRC8GcnEu2YlUqlh8sB5DFEHcu/O+X1hR8+2NawRaZ5neZrlz4FXySeboM/YuE/bvAuS20AJ10AfzEnSWYfRZZm4fxfmAFsrhUcxncgenuxITcdvx54vDvXMUrQ0zBVJGg2VNrvK+pdn+i+wR2rxKaquehStG75pAaqYUj96A1vTqqw9WWzCROTg5B3BRx/e/InmvKpZzdlyxSUIlhz+CVHpkr1BnxwL45U5vSEJIo3FM01KdwyM9ZHZm1N0HMzdenSBYbcaLZebWBGFpZZsW0lx+Qtnm7A/dw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by BN9PR12MB5338.namprd12.prod.outlook.com (2603:10b6:408:103::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.21; Wed, 1 Nov
 2023 23:36:50 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::b53a:1092:9be2:cfb9]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::b53a:1092:9be2:cfb9%4]) with mapi id 15.20.6933.027; Wed, 1 Nov 2023
 23:36:50 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>,
	linux-arm-kernel@lists.infradead.org,
	Robin Murphy <robin.murphy@arm.com>,
	Will Deacon <will@kernel.org>
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Michael Shavit <mshavit@google.com>,
	Nicolin Chen <nicolinc@nvidia.com>
Subject: [PATCH v2 27/27] iommu/arm-smmu-v3: Allow setting a S1 domain to a PASID
Date: Wed,  1 Nov 2023 20:36:45 -0300
Message-ID: <27-v2-16665a652079+5947-smmuv3_newapi_p2_jgg@nvidia.com>
In-Reply-To: <0-v2-16665a652079+5947-smmuv3_newapi_p2_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0293.namprd13.prod.outlook.com
 (2603:10b6:208:2bc::28) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|BN9PR12MB5338:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e6136f1-2eca-45b6-402c-08dbdb336a0e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	3rti4p1lOdeLenU78WB8B3PpQszTFmmuvqaUn3DehKqi7ZmoQIV1tnOrNPPwN5G8w5WnGw5ZtyVh8gTWqv+49smxe4NZcxIMXfcKy81CwTDW62xt073iY/EAA1jJViBAqISPjROQU0E1YsBaveYl75Pw3HSbN/0akHEXUOEM50O81xWy4bglpn1dRwU7oru7pA1EiaTdT7yMql1smQY7sjictOtJKiXz1BfKIizf1flRwXqOY/elrFCA1rYEtdZpywyh7k2wsxAywcmUS83fk7GFFSECAA5ZNJ44LwpCv0brditYqPtxyvdZeNzC4SDCV1ZnDHlT4qjzp44Ob87Bft3pd2lmwNAtvGu79lLofrKiywnvmCoSAGW+iZZHUw2hXtAcMr1BKdf8iyDcDxjl/pUNJof5vE/foNF3DUTlHaib5g806Lf1yqMuF1dDZjpY18kaVPeCja+/fzfPYhEtF4yZgYX/dlBnUcZTjkvw870gr+KyeKqp7seXK2vxCXrxGFCvvofIKxkX6S5JKcX+ux0ZwAmSG8IU7a6RwKKfb5odFer4K6nqkv7XPvBksnLa
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(39860400002)(136003)(346002)(376002)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(6486002)(2906002)(478600001)(36756003)(54906003)(66476007)(86362001)(110136005)(66556008)(66946007)(5660300002)(41300700001)(26005)(107886003)(2616005)(38100700002)(83380400001)(8936002)(8676002)(4326008)(6506007)(316002)(6666004)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3iEjlh0TlyGsReme7WSU6o17cm7wzG+kzyzrpyc3Q4vyLVnDItxBn854SPe3?=
 =?us-ascii?Q?uRnuuLIGOl5tFp8TL90Frb/JGUp+rXT030kwI3rNOrUkm+SQYBE4pX1MOy0b?=
 =?us-ascii?Q?iwi4Z/4zCWphMc8HiKj8iDKdIBaYtPk+gO/T7py0gVdouNyV3ldGHV5LH4dx?=
 =?us-ascii?Q?825quhc06j2JSBsgDG8R12kXhv6G0f0FpBXXSCOZeEucFoKdFgKYH1pzQfYk?=
 =?us-ascii?Q?wcmgVewZvnUVCVKQLm4wZTKCZWSw+YYi5yf3XUBQxW8QGpbNQ1Fej1sI1PAT?=
 =?us-ascii?Q?03XPpOQ1krxNPLARo4xTiN/V/6aSJfbZVIYtSM5UUj2ZeYvJVmOiYSUfSC4Q?=
 =?us-ascii?Q?ZxwrqF+zVHKGGjV4I5cVCtBvRHQH6FjtLO1SBaDtCIjny5bQnld11MNmAZg0?=
 =?us-ascii?Q?jCKJ8PBPl5NiHY7X79ewiwIHzEaw9qyRSJBHb1FzXAX8NFNmoIadZ2yvXPN9?=
 =?us-ascii?Q?4edTg1ZhAeYFxf/7ZrqppMk6Y66FYwSl33V+UYH6KFQDUxsfda0RyYFQrONU?=
 =?us-ascii?Q?OKsmHCc9bIbxOZqmxYZSrSyauSUF4Dy+DYbZF2jVvSYjn5TZi2OLluDGx2uL?=
 =?us-ascii?Q?dKPIulqjjo6bNtxUwUbmbTJa2eoXhKrEb7oaUp8Dcote88YehtZhuWN6sEho?=
 =?us-ascii?Q?32/mUiyFzW51sNRO0owcbQHmi3u6FRN+sUYjsPuj+jmhxHtoXPJhQDEIpNgc?=
 =?us-ascii?Q?QglSGc9RhalPcMJEqHDzgyfY2cMzflit65oFuH27RjsY3ic219dsp3ItUvbF?=
 =?us-ascii?Q?VnXkzsvENtxbsAlXRqjJZefOCCOvbxBHx/ls7AiPOgeCBj566TmIAj7ikc/Q?=
 =?us-ascii?Q?V9X0ImglWUkJpg/yGTxDmhDbIQHgZ7KItU9YkDHyO0wXH/c+q1FkRz+hxDZf?=
 =?us-ascii?Q?PKyjcctzHZn1LheX26h+9fGsp3CgbBG7IS+ApmvZaYMZisOMwdN7TAHmdyDe?=
 =?us-ascii?Q?oO8+46h5Yx/1s4L9qKZPalYIkvnZv7zXzSsy0cadprP0o9FXXkx8ek4NLh0s?=
 =?us-ascii?Q?pZVYzJZPAMb1vLoewqjOkkAuXW41ohoR05ig2IOI50lQzD1TrnWvT1lJOUJg?=
 =?us-ascii?Q?GRmUL1REjH/Yp/LesJKf7jMQHHboe4yAHB6J9QXDKENOL73xU1vgTQ+lta2J?=
 =?us-ascii?Q?+RSnCTI3GIxgaIDfUfpIEBN7P+c+DMTndFpQ526OqzUuttdiIVyPlcX+hQtD?=
 =?us-ascii?Q?xpI5QhTtONYSTA14NappUjcflFYY/kfPopxNZHiZ4zOwfRp7K1KRMBXWr/K0?=
 =?us-ascii?Q?n8a+TuLaoExgyi8Itx6qPCrCMktua2bejeq3fIoCqlN2Fs1omiW604LWKur1?=
 =?us-ascii?Q?/m3Bhge3IEGX3mtxhK/3zSSbOlUQ1+5FjY0SdK3FABFBGi2UhKhAGRwSOHk4?=
 =?us-ascii?Q?wbwJBeX7SFNSQSu9rXYcdRDDvwSmSHN1E2nRDlyn0qgYZnOZiMTk/hs7bdIJ?=
 =?us-ascii?Q?xqtJ1vvi0UxX2zydQKEAaBEYh2rPZbwKqxG0qYkL3Y6opJHyU3srj+afoNfi?=
 =?us-ascii?Q?FurY985QQxNQ0OdCRrxIT39PlSZHi/OigGega5VJCwTKMM7P7lhwFVBnco2D?=
 =?us-ascii?Q?/CAByys9gdPyrMof7Suf8gEmoWucl1jLO3uA2hWe?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e6136f1-2eca-45b6-402c-08dbdb336a0e
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2023 23:36:47.3101
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U+xqjQFH8ZCTYSu0zhxlLUsols3keGcouQJ+k3mC/vcAFEAFv40WHJzji82thb+D
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5338

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
index 0040e5cfbf9d4f..b2b3b6e421cf4d 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -1217,8 +1217,6 @@ void arm_smmu_make_s1_cd(struct arm_smmu_cd *target,
 	typeof(&pgtbl_cfg->arm_lpae_s1_cfg.tcr) tcr =
 		&pgtbl_cfg->arm_lpae_s1_cfg.tcr;
 
-	lockdep_assert_held(&master->smmu->asid_lock);
-
 	memset(target, 0, sizeof(*target));
 
 	target->data[0] = cpu_to_le64(
@@ -2685,6 +2683,36 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
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
@@ -2713,7 +2741,7 @@ static void arm_smmu_update_ste(struct arm_smmu_master *master,
 
 int arm_smmu_set_pasid(struct arm_smmu_master *master,
 		       struct arm_smmu_domain *smmu_domain, ioasid_t pasid,
-		       const struct arm_smmu_cd *cd)
+		       struct arm_smmu_cd *cd)
 {
 	struct iommu_domain *sid_domain = iommu_get_domain_for_dev(master->dev);
 	struct arm_smmu_cd *cdptr;
@@ -2737,6 +2765,14 @@ int arm_smmu_set_pasid(struct arm_smmu_master *master,
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
 	arm_smmu_write_cd_entry(master, pasid, cdptr, cd);
 	arm_smmu_update_ste(master, sid_domain, state.want_ats);
 
@@ -2754,7 +2790,7 @@ static void arm_smmu_remove_dev_pasid(struct device *dev, ioasid_t pasid)
 	struct iommu_domain *domain;
 	bool last_ssid = master->cd_table.used_ssids == 1;
 
-	domain = iommu_get_domain_for_dev_pasid(dev, pasid, IOMMU_DOMAIN_SVA);
+	domain = iommu_get_domain_for_dev_pasid(dev, pasid, 0);
 	if (WARN_ON(IS_ERR(domain)) || !domain)
 		return;
 
@@ -3280,6 +3316,7 @@ static struct iommu_ops arm_smmu_ops = {
 	.owner			= THIS_MODULE,
 	.default_domain_ops = &(const struct iommu_domain_ops) {
 		.attach_dev		= arm_smmu_attach_dev,
+		.set_dev_pasid		= arm_smmu_s1_set_dev_pasid,
 		.map_pages		= arm_smmu_map_pages,
 		.unmap_pages		= arm_smmu_unmap_pages,
 		.flush_iotlb_all	= arm_smmu_flush_iotlb_all,
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 19628340ccd632..91b23437f41055 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -786,7 +786,7 @@ void arm_smmu_write_cd_entry(struct arm_smmu_master *master, int ssid,
 
 int arm_smmu_set_pasid(struct arm_smmu_master *master,
 		       struct arm_smmu_domain *smmu_domain, ioasid_t pasid,
-		       const struct arm_smmu_cd *cd);
+		       struct arm_smmu_cd *cd);
 void arm_smmu_remove_pasid(struct arm_smmu_master *master,
 			   struct arm_smmu_domain *smmu_domain, ioasid_t pasid);
 
-- 
2.42.0

