Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2058.outbound.protection.outlook.com [40.107.244.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88CC822EE1
	for <iommu@lists.linux.dev>; Mon, 13 Nov 2023 17:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LD+AcO6E"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Oo3WwPZbVE84vr1+k8i2CKT9gcRcH9lIJ5JyCwrfgKlcn7VsEv9bvNm/j+MO4EyGsSjHtg3dJTkNKwlBUYg4aD1ZxhJTM+sCqf4NkTwPjw7VAzYeb495Xj3wUhDoYTx+JLlQKMHB7ktxjV5rZbVKt0KIk9dSdwRHddfgF1gEz9lvstegKN1/prStMIO9cJSomIY9293QqRGu2r7PTThuY5qWsRx9R/EtQLJnsTHVLag5xg4QW1Qc1lZW/PRn36Jqutxl85QWu8hpUkx7Qn0YVlV1RsX9lYgq2W7KcNdogPeKdko1IAQg1i6Ap+NHegFeasUtlkveJtavARWQvA6BPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=In/5NjVOIp7IsZ0dOG0i0Y7zCa6RMB+4XqLdi87zf2E=;
 b=cBkWPkES1oTFR3Zw/aPLn3KI74ksPug4+y6Cm70YVRe/CrcmeEznuNohUMXWU+52sVkJiBwu43Vaz0BIgREGFcD0YBE0TSc9PTzHkbx5ziBOexGpXtaJrYG0TBkLxVSwPceVA4oc9tGbKkzenF+Ggc6Li4bCuGV8b+EXxFL8iL/E5zLcZ7Q5MrM3EaSw+9L79V1byNBn3HECkDhXGE4rX/UxWviNmfAujmmDbRpDXMpVPlwakZzPPEB5rNhEeuUhJLFVTIvXtlsITKypMutlrtZ3Li5VRlNO/ExNB99ly4VK0VeFBi+KySble4R5BYGIdvsFwduuYn8uNqMW7PHHCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=In/5NjVOIp7IsZ0dOG0i0Y7zCa6RMB+4XqLdi87zf2E=;
 b=LD+AcO6ExRW+G5sR+DJcgSZ+xGy+3RtgUBxEGTUOeHdIg22Weutjd2IR5+jyYPnxM7UeBE72IGblhd3UlNx8hmzOKH0aMfAmlFUCmopYL8RVc+n05fjXFBNK8ZJKf6zcJgft0QrJeeMgnW9Hkk3BkrI0uij6AW95rYPxfOloIus9deJkFqpPCaCrSRXS7qXqiEV9FI/qq1NQ+SaUXHliL7kpbjqDiL0pCv2Nb2xGxb3GfxdJQfMuAu2iE4PiGme3IoP+7Lf/r9Qz5nCfKLFfkd+neVOgm3dmUAA3QISkCBRPFYV3arZikm1kDCPtvbhk8Aq7x5nK6lo2PB9FldGUdg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM4PR12MB6038.namprd12.prod.outlook.com (2603:10b6:8:ab::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.29; Mon, 13 Nov
 2023 17:53:31 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93%4]) with mapi id 15.20.6977.029; Mon, 13 Nov 2023
 17:53:31 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>,
	linux-arm-kernel@lists.infradead.org,
	Robin Murphy <robin.murphy@arm.com>,
	Will Deacon <will@kernel.org>
Cc: Michael Shavit <mshavit@google.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Subject: [PATCH v2 11/19] iommu/arm-smmu-v3: Do not change the STE twice during arm_smmu_attach_dev()
Date: Mon, 13 Nov 2023 13:53:18 -0400
Message-ID: <11-v2-de8b10590bf5+400-smmuv3_newapi_p1_jgg@nvidia.com>
In-Reply-To: <0-v2-de8b10590bf5+400-smmuv3_newapi_p1_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0309.namprd13.prod.outlook.com
 (2603:10b6:208:2c1::14) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM4PR12MB6038:EE_
X-MS-Office365-Filtering-Correlation-Id: 75dce906-9076-4cbd-8f9c-08dbe471705a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	XBDn/b2BalLWFmQCC9Yw4ZprvAaLu+otuSmDWn3vIIdiKMdJif/N5U5PFbF/whHCZ8goG2aegbC0iiOWKWJ5ZlT5MRg3LFtRCl8SXieTqE79bc6+PYBIQfhxid4HnQJFjhvdcEcu+5W9zbN6cz23Ln9UehoU5elO1m1FnFepJQwX5CfhGsqXJjKr4ASE7N0bBVaei6OrijYXuF2rVAIzP+E59PugSgBOi8Na26/zPpoyrv7V6usC7rP6vjJ0TIn7pdhQTy8IEYMxG6RVDBtefsYR+kD9p4hlpVdWtoS+0A6BOqR2HYQKLFj8OBI/YcMEZve5zGxIbd4hprk2xOU23aJtpMWoSJJbg7/ncG26WEhPkal2Ei78Vo4fdf+5KJu46VtJE3Cy1MmdKmokR6fO92+CSlH9emIZq2uVWDCih+vZMbiasQ/O0tcRe+NQ0gxdyeeE2tOIps2q8nmEic/oQ1pLMCmbRM/TrKaQyu+sChXy5bdorY+WYCc06FLBml9H8J+C29UKAAXnNhTMR2ea7NHXawLdrOEtm9ZP+3njzkleKJxH7dLzIKn8jqdT2ihI
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(396003)(346002)(366004)(136003)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(36756003)(26005)(478600001)(6666004)(6486002)(6506007)(316002)(2616005)(6512007)(66556008)(66946007)(110136005)(38100700002)(66476007)(54906003)(5660300002)(8676002)(8936002)(4326008)(2906002)(83380400001)(86362001)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1ghmGQ6JL1HXWJf3Bk/MeupyetxU6vVESvW/5wn7w2vy1gD8ZDRitfyTEGbQ?=
 =?us-ascii?Q?vTt6e0TditAbNjgSZ51xTIDGoVj7+8WG+6Ut+CnQ42o8d0UNkRa/QydjU9Nx?=
 =?us-ascii?Q?bXjhLE+Lk4/StOGJ6OzhZFnf5ovhx+4QTMWzXYf5suheLLhuEgFfAteK41Pv?=
 =?us-ascii?Q?hEDWEn+aISPZm+Q6+cK78gxn98QxKEGckKNtTjqF7Dg2Sqp/zzUaT22P4zzs?=
 =?us-ascii?Q?UqyXn4q13pDSA2sEnCv1vYzxZRYtVrPyyhlEalV7IwkqkgU71RTCLpqeazjf?=
 =?us-ascii?Q?o1v4YWBIFs0L6O8+0mv16r0OcZ7HFygyWJ+xVOCxvf4nGHIYIvnCSxjIIjmf?=
 =?us-ascii?Q?mQavgeHb6HcbQflWVwa/MjvgjJsQd/fZy8+xWCBp57XKJjQyFOUea5R20fIk?=
 =?us-ascii?Q?wZ11BlT8sKmRlEki7HyjUjy1s+eHtALCaeUkWe2u6/N0rqyizwocmFqBjeed?=
 =?us-ascii?Q?S42vzIcBRwXEARk/p7LkQ5IMUAypWbwr/DbuUwnxB+DzNOm+30sBQohwrk7D?=
 =?us-ascii?Q?GIgRBQVOEtaBHsQcyw7Z/4r0HdoVZyOkOt7WYcNJBYPDw34SvVuz3J+7yZGX?=
 =?us-ascii?Q?AWMJrWkpsZ+fWhM5G29HwiUWZSfyexI15AinUA9M+2+FOPsjHQSC2nsegFUN?=
 =?us-ascii?Q?B8vcHp2AmMywStXlKaVBmoUU4qpAIvHXV78x1enjuph0cW4azUmA6r5yBLHV?=
 =?us-ascii?Q?2s840FTv1ykzKZZQJL4vBSyUz5zMK2N+0Jy26tbtvlHCkdP4DyAFY1K1IcQX?=
 =?us-ascii?Q?FwHl9DZUsOGJlUDP/j2oF5yuCrJ2xT7KrbceRoClMRNBUnqiibVPgVqLwP0H?=
 =?us-ascii?Q?eYdvQp1JcpLVpBOMjVKyBeureCl8e4omMdo9l1v5/7IxO2iGifvR1312Zztz?=
 =?us-ascii?Q?S34U9pTiJXX142/d/IJcDZ0E60bMPWgvemohX33vjYxDkq3WrYGYSq2GW8dQ?=
 =?us-ascii?Q?ecZjlGs91xyPU2Antx9QGF/ohFChpoLxJuF61ZbPw1Vv6orEJ6ZsCEhsbO6E?=
 =?us-ascii?Q?eE0d+yPwNJXdFhKHIhixd7KO4kYnUIO6H//lXlccxQrp+WwqU8N3Z/aPyHF+?=
 =?us-ascii?Q?gYJdw1nKDUcLe9+a/moCqYKSFeIu10Zg9jQ8lUoebSdsyRlwJzss18Hb6h4J?=
 =?us-ascii?Q?Y518A8RpYaPzTQp8sqOlmUqFX29pES398Stq43DtGth8Z0AIwnp0mZCjPNvy?=
 =?us-ascii?Q?mhfVsF6ik0DcioD75XOW616vg3L99nXw0mlgDYCfgp/FcMddJjS+EDJQG8Mz?=
 =?us-ascii?Q?jy484/1tb6FQ2hODsTKy3Qk5gAzWI8c6BxAEoTalwu+BBaFuPoJNwV4MkJfJ?=
 =?us-ascii?Q?XhLJ/XRMQEKlMrh7IvYZNLaVaH7G2ODtET/Mpu8d4LDCe7oJDwffm30nKDRY?=
 =?us-ascii?Q?DooSTlLtBMKZRw188v0eAEedRqeeZTc6iywEqmcN4tASYKsEHhrfwL4ZDr5l?=
 =?us-ascii?Q?tUIjFuXAG0jwhqKISLEqoTfbv8B+sidC4mpfDLehDoBEmlsSHrdHDsrwIbtX?=
 =?us-ascii?Q?BIPggqHLtBYAf4v2PIRjt1XPZjmtxEGgXfTLhuQgwSMG7sVtIuMQ5J6U5vS6?=
 =?us-ascii?Q?c1BP/fMLPpkVINU8yvs=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75dce906-9076-4cbd-8f9c-08dbe471705a
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2023 17:53:27.1726
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ++UOrAGm5c1H1H9ydJNurcayPIwVoMX2A4jqaX2JOojkl5BCCERFZs8wM+PAu7pD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6038

This was needed because the STE code required the STE to be in
ABORT/BYPASS inorder to program a cdtable or S2 STE. Now that the STE code
can automatically handle all transitions we can remove this step
from the attach_dev flow.

A few small bugs exist because of this:

1) If the core code does BLOCKED -> UNMANAGED with disable_bypass=false
   then there will be a moment where the STE points at BYPASS. Since
   this can be done by VFIO/IOMMUFD it is a small security race.

2) If the core code does IDENTITY -> DMA then any IOMMU_RESV_DIRECT
   regions will temporarily become BLOCKED. We'd like drivers to
   work in a way that allows IOMMU_RESV_DIRECT to be continuously
   functional during these transitions.

Make arm_smmu_release_device() put the STE back to the correct
ABORT/BYPASS setting. Fix a bug where a IOMMU_RESV_DIRECT was ignored on
this path.

Notice this subtly depends on the prior arm_smmu_asid_lock change as the
STE must be put to non-paging before removing the device for the linked
list to avoid races with arm_smmu_share_asid().

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 4b157c2ddf9a80..f70862806211de 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2482,7 +2482,6 @@ static void arm_smmu_disable_pasid(struct arm_smmu_master *master)
 static void arm_smmu_detach_dev(struct arm_smmu_master *master)
 {
 	unsigned long flags;
-	struct arm_smmu_ste target;
 	struct arm_smmu_domain *smmu_domain = master->domain;
 
 	if (!smmu_domain)
@@ -2496,11 +2495,6 @@ static void arm_smmu_detach_dev(struct arm_smmu_master *master)
 
 	master->domain = NULL;
 	master->ats_enabled = false;
-	if (disable_bypass)
-		arm_smmu_make_abort_ste(&target);
-	else
-		arm_smmu_make_bypass_ste(&target);
-	arm_smmu_install_ste_for_dev(master, &target);
 	/*
 	 * Clearing the CD entry isn't strictly required to detach the domain
 	 * since the table is uninstalled anyway, but it helps avoid confusion
@@ -2852,9 +2846,18 @@ static struct iommu_device *arm_smmu_probe_device(struct device *dev)
 static void arm_smmu_release_device(struct device *dev)
 {
 	struct arm_smmu_master *master = dev_iommu_priv_get(dev);
+	struct arm_smmu_ste target;
 
 	if (WARN_ON(arm_smmu_master_sva_enabled(master)))
 		iopf_queue_remove_device(master->smmu->evtq.iopf, dev);
+
+	/* Put the STE back to what arm_smmu_init_strtab() sets */
+	if (disable_bypass && !dev->iommu->require_direct)
+		arm_smmu_make_abort_ste(&target);
+	else
+		arm_smmu_make_bypass_ste(&target);
+	arm_smmu_install_ste_for_dev(master, &target);
+
 	arm_smmu_detach_dev(master);
 	arm_smmu_disable_pasid(master);
 	arm_smmu_remove_master(master);
-- 
2.42.0

