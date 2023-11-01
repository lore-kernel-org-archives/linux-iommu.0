Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2085.outbound.protection.outlook.com [40.107.92.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70B4C19BA1
	for <iommu@lists.linux.dev>; Wed,  1 Nov 2023 23:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="eJSWPHTX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MJtkP63x/BVP1HQfm9bJg0/jn6AaG48qljnQlgckaMQMSHuF2hY+7tJ9LjIwsGL9Cm4tfCrQy1CeZiXyYIkPLOYKP9hfjNEcYH53SCY1QF3UuFy8KJ/0VW+scyEpSUXoc/LERgVusSursPi+s/7Q3jk92YqsyS2iuR0B9Dodu5iN9wtlTXw1f4GpcTZ1ajNmvp/3xLQHrz9nWH2m50Txmlz7cT7gK0mTTv9t36iVSaOi03/c0Aml4vo79IvXt36pguOyiPoZRr0NvTwq8ft70u9cANT1FEHJUTJdH1x064cdruhkiLslqa7fsdKceKzAs8vXADeQx4HjVkZZfDlAgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n6j/Qp3HDuv0CWkABHGS55Q2YSdU9ZL/WLYA0tHmH30=;
 b=TTigNVWQPBnXILFp/cO3qBly+gXSWLKlAxROPBwjJjCmG8j4ldeZtpecSYeI3S16pJcIZC5ZEvTw63V02ZUd5uQoy6v9M+hR3WuxsSkEYLkjs3wKBDVIbflK8YuvC+REyi/kobxFGgNKJ4dc94z+nfH1DQyp06w5O8LkFwRl2hai6rXx45voMEbabNBbb6kTEB3iA03Fs8igkYJD2MBjlTf80GHhCdU7XKuaGEIewsNtDg9gwa/FAhunIzT04/KSOPu1N0Nwgm1WEWkSsBSUfmjjxBHfLcVUrrsGhDp4Zuj6rABw6pfl4kPjcKnDDY704zQDX5ryCiXNp77urbUK0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n6j/Qp3HDuv0CWkABHGS55Q2YSdU9ZL/WLYA0tHmH30=;
 b=eJSWPHTXTGFwrlPQywYIgSaJ5nKRHT4viLOKR5w7p3F/y0KcKDiAYVfW/jeLUm4OebKDTu9/yBqgtux7XdZbH9OgxKNDHeZHEy0oRLUZi8sJlWxye2GVSBWxlvpQIGVdcwBRk0HTcxoBAKnBsl7NZO1If9V/KOGwh6D8RnEee32xF2DgxSy4VXYgcjbUCsgKxAUaD81bVCFNQ47ozK3eR1FIUEjJDS3XirnOAbKXapTQyQnsdYk+7FiVeRWFRRBPGGd67GUYtHgLSg+At+QrvT6sfPcx9Lv3wiPVqddTPBCU97g8nAwpFdlngPDmlyJMOGi3KG3okWIkbdXFqfYukQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by IA1PR12MB7664.namprd12.prod.outlook.com (2603:10b6:208:423::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.28; Wed, 1 Nov
 2023 23:36:53 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::b53a:1092:9be2:cfb9]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::b53a:1092:9be2:cfb9%4]) with mapi id 15.20.6933.027; Wed, 1 Nov 2023
 23:36:53 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>,
	linux-arm-kernel@lists.infradead.org,
	Robin Murphy <robin.murphy@arm.com>,
	Will Deacon <will@kernel.org>
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Michael Shavit <mshavit@google.com>,
	Nicolin Chen <nicolinc@nvidia.com>
Subject: [PATCH v2 05/27] iommu/arm-smmu-v3: Make CD programming use arm_smmu_write_entry_step()
Date: Wed,  1 Nov 2023 20:36:23 -0300
Message-ID: <5-v2-16665a652079+5947-smmuv3_newapi_p2_jgg@nvidia.com>
In-Reply-To: <0-v2-16665a652079+5947-smmuv3_newapi_p2_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR17CA0016.namprd17.prod.outlook.com
 (2603:10b6:208:15e::29) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|IA1PR12MB7664:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ab649cb-5c6f-48f0-8746-08dbdb336ab7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	/vVWCikm/Oo7ZV2PtQGmAYpDaiCT9hrMU/5G0cqN4IMw/zNFlFHg6sq/X8XkVQ9QvG9ouX0g4mEDLdM4HWuis2thd4xbzoKByDY2eu3bMHz+b9piqLSMJVy4mSe5sR+rCsWBpTycmAotWG7GgI8PaJa+XQEzLcTaz7fUjVvP7NfZymxYAM7GXH8085Odh+CPe+uyk/niw4tcW2SF72/dQtFVcKIGXjKl/6O2E2ZS4wN3oWFr83Bcrp4TPpUF5XatQtpw6iEqaV3T21IOHaOQ/uLwKq5ybSnoMacg9+KJ8oACLjy0TF92LSzfNCBybIG9rXNxLewy7EdAjLjZ3/w1chhYaf3EejGftglw0vUyosqKmA/U6wt142i5Ysu7e/EtpYU0y9AMzN0JkuC4NalZANQNZ+iegFvEcV89asc8By8XELWojhHyVbGtbwEd1Sfkb4OyinnhQvjs6HFJn19Jf8Nw1ry9lfYByd2pJnxpGtD5aQU7RglwBmHOU9rqkRRdjDiDx/M6gdUpbMrdI9LBMeAh9tjmJVR7Zosyz+nUdDKDAMFuxsd777kRPy/1rrwn69BhaijWzD0cjSH1YqZjmTKKb1t39nznr4GTx0d0Qrs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(366004)(376002)(136003)(346002)(230922051799003)(1800799009)(451199024)(186009)(64100799003)(110136005)(2906002)(86362001)(41300700001)(8676002)(8936002)(4326008)(5660300002)(36756003)(478600001)(6486002)(6512007)(6506007)(38100700002)(6666004)(54906003)(66556008)(66476007)(107886003)(316002)(2616005)(66946007)(26005)(83380400001)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1OYi+wjKRuhP3f38GC7IhET78I2nayP2xPiw7vgYgFqh50TkrE1GHZaW5eTk?=
 =?us-ascii?Q?PpWNP5pU+npoTykq1EwPwSSnxyE+oF9q1XGCygH6XfeRRY7uGoR4g2OVC7ID?=
 =?us-ascii?Q?vMPnTbRxWp+FwnbwBvJTaM4ybhzW9PhXJO86Pg5Ac/r22dKAOVzRWNcYVJUN?=
 =?us-ascii?Q?9NU01iltCtN/fL0OJx/U/aCtunfKssIvI+JkEXJOW2SoGHJ+7FBoAiQiHPPV?=
 =?us-ascii?Q?aW+zz3kE5XpLspt7SWzkjRsZ4cMHLrfaMeASHw2zAinvZObyql9ogPY0lVNA?=
 =?us-ascii?Q?aldRMEgmf09Zn7Ntv9iP6TrXy4rO5Zaaf0sFHEiART7WaHGY1WU0kzoVFvh2?=
 =?us-ascii?Q?Ho6DFNNH93Wvty9Qq3vmKKimyMun6Z/hGE6r72TnnP1BT9ncsltgwxVYRBD+?=
 =?us-ascii?Q?329fU4KXldzZ9NhDraI9wAulhvXM1Z7zomPWSxdAir+7SBED2Lwe5WJ8PWCO?=
 =?us-ascii?Q?NPyOtpZlB+6hmCMw3WWEiTOmd7GUQEiAUW2RfCt76seNogpQhWzsR2p2ekXB?=
 =?us-ascii?Q?VRlXcKhQsrZeq9tO+fHHxFJrKbr35pE0sqopG9IKNB37MaQF6RsOVIkjO+pq?=
 =?us-ascii?Q?e++njP6RIxThhCqCYK7on1cMRzxUZKXBMGlFHcf+0X9i87Aewo08Utt1vrBW?=
 =?us-ascii?Q?aEaTb9Ui5u0LWODbjdZY23sKzeoVNXV7ypL0ekyOlNumPn1PihLKgUQH/RWH?=
 =?us-ascii?Q?CPtXmlXYP4jYxUg0gRu0GvLTOHTWpF6bDVOwYfDZ5UrPdkfhM9qvcshYCNRh?=
 =?us-ascii?Q?XrXz1oEy33WD+xnxqVUUtjG2/qK1S1prlV2y9BYWJud4EEtHgpoUFtB3OSSp?=
 =?us-ascii?Q?9tQOrquIiKXevU2quC8ihluKS21StjS6BNLlOjEmVWfP62IyULpiqSl6Hz2M?=
 =?us-ascii?Q?pldtN/RZLvokoCj/5rigK4/k/t33w1LQr3fkccQcXIyjDVW7zw24V1T0Tc3a?=
 =?us-ascii?Q?kvXU03m+pYj42w8NwnAIxFPt2Y3BjpupdFLLsOFxADiPF+mNTSJ9KJ3EB8WZ?=
 =?us-ascii?Q?aVz0NbkrJIKFEWHxLMZQOCoimqYLuB5pcoO3MkygMvAeyWP+tW2cNvfo4Ls+?=
 =?us-ascii?Q?aYqboN1x6xuLlnRKX74HCkueH0sLhnzr3IMHR0xVQFJeX4ctRd2of4al5tRd?=
 =?us-ascii?Q?DyMSq4SS8L28DF+jrRZDIDPV/5S4E+J17iRjFynaJOSi4qrpUP0l7nwlT+Xo?=
 =?us-ascii?Q?AYrEFmZNsv3WfTrfbJ879yjLdEueMNT3jGbvtvllCRYoQLdagkHzJLIM6RBv?=
 =?us-ascii?Q?mQ7NVV9pDRJ2HF1yW63XIX9FToPnOimpgnpZlsPwwpYv8rpGeycUrGtNzqbF?=
 =?us-ascii?Q?pJd8FM4CysO+0H5BP/8OiY8W/+/VHoupyqxH6DJOyy5duxLUiiZBoOCP/5Hw?=
 =?us-ascii?Q?P2vfBDc3FYbtYXaWEnSkmNwXQOOHGLDI/iC8BLaqBuSJg+jIanjOyUa6Qd9C?=
 =?us-ascii?Q?nm5CmngQAcATY/nE+fLPOAsz0xxm6n/9rwkHKElqS2bREvnRnOwtzk2212Q9?=
 =?us-ascii?Q?rQGsRQExgtefhpUtDPDkK90aBKhaEVqOR44MnU2xkOx22m79hyZD9NG1HB4B?=
 =?us-ascii?Q?qWxvBawL8uBkUAFh//8nXvy8/SE5oSaiotq7pmcL?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ab649cb-5c6f-48f0-8746-08dbdb336ab7
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2023 23:36:48.4535
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Bh6AlGE1EdSF7OqBi9YQB//8h3rKfhEIAX2J1cX6k2yequ/I0cETIzQw3+1AQMnD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7664

CD table entries and STE's have the same essential programming sequence,
just with different types and sizes.

Have arm_smmu_write_ctx_desc() generate a target CD and call
arm_smmu_write_entry_step() to do the programming. Due to the way the
target CD is generated by modifying the existing CD this alone is not
enough for the CD callers to be freed of the ordering requirements.

The following patches will make the rest of the CD flow mirror the STE
flow with precise CD contents generated in all cases.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 79 +++++++++++++++------
 1 file changed, 57 insertions(+), 22 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 80cbedcf33aabc..042bcc27ace777 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -1146,6 +1146,55 @@ static struct arm_smmu_cd *arm_smmu_get_cd_ptr(struct arm_smmu_master *master,
 	return &l1_desc->l2ptr[idx];
 }
 
+static void arm_smmu_get_cd_used(const struct arm_smmu_cd *ent,
+				 struct arm_smmu_cd *used_bits)
+{
+	memset(used_bits, 0, sizeof(*used_bits));
+
+	used_bits->data[0] = cpu_to_le64(CTXDESC_CD_0_V);
+	if (!(ent->data[0] & cpu_to_le64(CTXDESC_CD_0_V)))
+		return;
+	memset(used_bits, 0xFF, sizeof(*used_bits));
+
+	/* EPD0 means T0SZ/TG0/IR0/OR0/SH0/TTB0 are IGNORED */
+	if (ent->data[0] & cpu_to_le64(CTXDESC_CD_0_TCR_EPD0)) {
+		used_bits->data[0] &= ~cpu_to_le64(
+			CTXDESC_CD_0_TCR_T0SZ | CTXDESC_CD_0_TCR_TG0 |
+			CTXDESC_CD_0_TCR_IRGN0 | CTXDESC_CD_0_TCR_ORGN0 |
+			CTXDESC_CD_0_TCR_SH0);
+		used_bits->data[1] &= ~cpu_to_le64(CTXDESC_CD_1_TTB0_MASK);
+	}
+}
+
+static bool arm_smmu_write_cd_step(struct arm_smmu_cd *cur,
+				   const struct arm_smmu_cd *target,
+				   const struct arm_smmu_cd *target_used)
+{
+	struct arm_smmu_cd cur_used;
+	struct arm_smmu_cd step;
+
+	arm_smmu_get_cd_used(cur, &cur_used);
+	return arm_smmu_write_entry_step(cur->data, cur_used.data, target->data,
+					 target_used->data, step.data,
+					 cpu_to_le64(CTXDESC_CD_0_V),
+					 ARRAY_SIZE(cur->data));
+
+}
+
+static void arm_smmu_write_cd_entry(struct arm_smmu_master *master, int ssid,
+				    struct arm_smmu_cd *cdptr,
+				    const struct arm_smmu_cd *target)
+{
+	struct arm_smmu_cd target_used;
+
+	arm_smmu_get_cd_used(target, &target_used);
+	while (true) {
+		if (arm_smmu_write_cd_step(cdptr, target, &target_used))
+			break;
+		arm_smmu_sync_cd(master, ssid, true);
+	}
+}
+
 int arm_smmu_write_ctx_desc(struct arm_smmu_master *master, int ssid,
 			    struct arm_smmu_ctx_desc *cd)
 {
@@ -1162,16 +1211,19 @@ int arm_smmu_write_ctx_desc(struct arm_smmu_master *master, int ssid,
 	 */
 	u64 val;
 	bool cd_live;
-	struct arm_smmu_cd *cdptr;
+	struct arm_smmu_cd target;
+	struct arm_smmu_cd *cdptr = &target;
+	struct arm_smmu_cd *cd_table_entry;
 	struct arm_smmu_ctx_desc_cfg *cd_table = &master->cd_table;
 
 	if (WARN_ON(ssid >= (1 << cd_table->s1cdmax)))
 		return -E2BIG;
 
-	cdptr = arm_smmu_get_cd_ptr(master, ssid);
-	if (!cdptr)
+	cd_table_entry = arm_smmu_get_cd_ptr(master, ssid);
+	if (!cd_table_entry)
 		return -ENOMEM;
 
+	target = *cd_table_entry;
 	val = le64_to_cpu(cdptr->data[0]);
 	cd_live = !!(val & CTXDESC_CD_0_V);
 
@@ -1191,13 +1243,6 @@ int arm_smmu_write_ctx_desc(struct arm_smmu_master *master, int ssid,
 		cdptr->data[2] = 0;
 		cdptr->data[3] = cpu_to_le64(cd->mair);
 
-		/*
-		 * STE may be live, and the SMMU might read dwords of this CD in any
-		 * order. Ensure that it observes valid values before reading
-		 * V=1.
-		 */
-		arm_smmu_sync_cd(master, ssid, true);
-
 		val = cd->tcr |
 #ifdef __BIG_ENDIAN
 			CTXDESC_CD_0_ENDI |
@@ -1211,18 +1256,8 @@ int arm_smmu_write_ctx_desc(struct arm_smmu_master *master, int ssid,
 		if (cd_table->stall_enabled)
 			val |= CTXDESC_CD_0_S;
 	}
-
-	/*
-	 * The SMMU accesses 64-bit values atomically. See IHI0070Ca 3.21.3
-	 * "Configuration structures and configuration invalidation completion"
-	 *
-	 *   The size of single-copy atomic reads made by the SMMU is
-	 *   IMPLEMENTATION DEFINED but must be at least 64 bits. Any single
-	 *   field within an aligned 64-bit span of a structure can be altered
-	 *   without first making the structure invalid.
-	 */
-	WRITE_ONCE(cdptr->data[0], cpu_to_le64(val));
-	arm_smmu_sync_cd(master, ssid, true);
+	cdptr->data[0] = cpu_to_le64(val);
+	arm_smmu_write_cd_entry(master, ssid, cd_table_entry, &target);
 	return 0;
 }
 
-- 
2.42.0

