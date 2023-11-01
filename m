Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2055.outbound.protection.outlook.com [40.107.100.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 737141C69E
	for <iommu@lists.linux.dev>; Wed,  1 Nov 2023 23:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="p5WejSoA"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F7qP1vShkgLWGfwaWWZcWvSU5luYZpx6tXhMouk4Bm9wzE2IGbS/JwvTqfOAgxYYwFVvOzvn8D0Acd6V0hX6lemXKqAH3uY5FcTdxH+B0vW+qrFb60qar94iCRVjjgNxtihtf6ZucBOdSCZV/DJfHsIbW2DLqh04MpSLdWXl7ur5HadA6IkuwRByPAjrYmCe37h9O/U1VVRwRN1HA9YK2Jm2NDsNrVNhf56tcdhIs5JhC5vJoBoSPDXcKTqO3aSOV4vynfQ766HfTrnzIxXeLDEGYwmYq76gBMDr8ythgKrULNUy11eRz7HumPsj4Wy1/B93xs2ZKKwIyIOiLo5Tvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4704La64aNqNatk/IcDiwXfTnYYBAB3KYCJ2QqvrqfQ=;
 b=XKgac/eawKpTi1T9vmhnX4MdViTjcRYzteSLB60Sr3LENRe8ox1iKXWawg8cdi3tgoJ32eL/6Vm8Plt8Elr8+CVgEaUVj4BS3LZxOmtmXdg1A0uI8sl4qyfBGmtNYIc/0tiB6jYg+glI6DV9OwDPiYThenf1IDO5qVzpAOUolhJCznkICoOgmo1xwDoJpT8EZ9JHA6Xo7ZPCQ69K9BYsuGuMTsFbeTfc046kwZ5P/I65sS0LsVvKEW8UCwcmj7yzwAjL/ih5LSvyBt+JcmgSyqJSrzNj7+9wQEkXV5PdQzQPnWPjxoLhLL7Sw4kZoHgZYLsDvLUCOsZJDxdZOYuRaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4704La64aNqNatk/IcDiwXfTnYYBAB3KYCJ2QqvrqfQ=;
 b=p5WejSoAt6v0wjnE7QpvEtYQEXh3uP7sE8gyrRlz6M9M7e3z5Uns48dM3LHKm2uY+15pBdKOeFqZ13V6aJUnshc5oxpzifWTbRJISiapZgyRL62chbTmEeyLgP63R6AHxA6Fb2UIM4zsCGuAUuYRxgoLKYQkU0a3KAiDLxfjTc50CgGR/Mk37nO2XvwjDxWatvFmm8GW7puOH4WS2GeLyvqFSw9p9dnl3bSrV6f1l0gWAerwK3ACYJha6cCwmLJtcvEw8tTLxfHG88zvQKpc8St8xrDzBjS7TxkXTvm82gC9NsqL05jSuPZLNyEZDEAJ6m1rZJ1Y+s62Jnw268Ni/A==
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
Subject: [PATCH v2 25/27] iommu/arm-smmu-v3: Allow IDENTITY/BLOCKED to be set while PASID is used
Date: Wed,  1 Nov 2023 20:36:43 -0300
Message-ID: <25-v2-16665a652079+5947-smmuv3_newapi_p2_jgg@nvidia.com>
In-Reply-To: <0-v2-16665a652079+5947-smmuv3_newapi_p2_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR17CA0003.namprd17.prod.outlook.com
 (2603:10b6:208:15e::16) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|BN9PR12MB5338:EE_
X-MS-Office365-Filtering-Correlation-Id: a01a0a1d-9d6f-42a9-674b-08dbdb336a15
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	JpDbw1LYJV+ESdjfYFk3VuRkVGzPXL5WPjjbvla2R5cCp7LEIC9ts4omtrdFBZg4YqgSlBQ4V2/DP9IL50cB/o6hVzJbRvpAlkX1fSgUfAST3xi/yB9Ru14tyrVIJdwqcQJ7i39yrOTDidwkhJbNXH5oSOMCiNRR5tKSMC2pEmkz5YaRBgi2U/hBhFNG20gGvUUHi3k0VFIrRRsmhtQVckaa91EdwKsu3JzDxA/aY0NxucB4mPjI468foHIpyYywXhApVlMJxg4GQCXnb0Dlcc/ea7/yw/+OJ0skUlmKvRp1BO8suALcs+llyWCotY63IooiAaj8awPGK6yZl96Foypa9z2Hn5tZdn0/c9Y0GxpuZtab07ZOAu4UV1sXfsNpPzLu+AQnBi4rKETCKqjQ8Av6yFfwUc1+ZUemdgZZOKFbi8kCZqdPY91UyfFgvNJC+eJki4aanMnl+K9oUscarsSy1/Ojlmk+wE0fxIxgIeu15r07t7bhyyQaB3FS04AaRWITqNt+eCHZQB6Txu2NV++btuq1Kt5lY549HNjrpe7CcjOkMLyrWcBpGxdVTvy8G0peN4ekMz0vXmduedqE7kWzMAL9TRK2ILPKkC3MUJhm3m0l06yvlry9F2ksbWm585x8fJujcyJMuMgRK2hq0g==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(39860400002)(136003)(346002)(376002)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(6486002)(2906002)(478600001)(36756003)(54906003)(66476007)(86362001)(110136005)(66556008)(66946007)(5660300002)(15650500001)(41300700001)(26005)(107886003)(2616005)(38100700002)(83380400001)(8936002)(8676002)(4326008)(6506007)(316002)(6666004)(6512007)(473944003)(414714003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GTA5Ks2wYjQYuEriEa2V8B4fCEiA3zg/H48BXYzbhDQMm6IfdsfVYfSUv8QC?=
 =?us-ascii?Q?gdYvh/U1i03CLLPKYHZtykRgN/7dqjIXgatglC8QFePeS/Qc7AajXHdWjS6t?=
 =?us-ascii?Q?NrvpS3DYcdWu/H0JM+LVVP0gACxI+962OWF0R89sP/EkDgqjhDB/C78Y/o4F?=
 =?us-ascii?Q?tVKyg3H1XgctpZ56e+LZTdm5vJ6RoiIlM+MErZhdl53cxLMDTn2G+J+actD0?=
 =?us-ascii?Q?3q126ulx+PJ9JYAIV56FaB5U0808GVExwITCjfoTIEa9kJW9ELIe6gomli4s?=
 =?us-ascii?Q?iZLEt41qpPx2ftpr1YrB4btcShREaP/gqcr/Fji2ApLw/DPqXWtjjp1ZDXGB?=
 =?us-ascii?Q?yoYCZtV3dbW9460lYeD0UWz0CTMxUhkBd9rx2AJLyCLf9saVfGJ+Rwb18xPm?=
 =?us-ascii?Q?ubVFwHwUEsuqpfnpw3AGeSDsIRGLtEac5UzmEO1Oo61KTRw5KWVaMNq82fMF?=
 =?us-ascii?Q?GrikOjJ0gyjpt3jwpzwkYLcso20iqQmBSMX05JEJdyKPLkpZlB/1EM3oDBQN?=
 =?us-ascii?Q?CsZ2dKBKD8dqbc2tXnEXqBlmAMN5Rf/YjbHDd/4k7iMmYkdHka5vP0FhZ5Ap?=
 =?us-ascii?Q?tF07vzO9hu1KxcfsMiUfyV8s7V6zDcFbDqylMn1A4+bqC9WDi+7sENqHYdbF?=
 =?us-ascii?Q?WIzmFSF4ycM3KKSt8OVE3+1bJvD6vusI73wZ9hlBX7YXlWWfzdzHEQddcp/u?=
 =?us-ascii?Q?KMztgZtkJTmu6rYxmUH/mrQmuZ1J4wDAiG0VQEtniQINqfZ6tpGybKwpDf4T?=
 =?us-ascii?Q?Zm6db89z4gTlyo8VuWRsNlgAYjMQ4jBs2Qp290SSvoStUIeRU4sHj8fgP+cV?=
 =?us-ascii?Q?4OAxrd8wI4i9xP2t2k/9bx6W7KYJpaI4W8n+fFAMiqN6pAOLOZ/FLBntU0yL?=
 =?us-ascii?Q?y5h5J27mz6Uzi8hJ6pnrJSTvkAdROPbAKWzUXHYzjEsAg+6OLDMgyvOU/Rzx?=
 =?us-ascii?Q?iVq0KevRysWu38UC02A01kZf4C5ds7fHBpy90odaVXHeAMui9w8HnnLgl3hg?=
 =?us-ascii?Q?j1CDZEqpXXjo1Sm9zABbnl59aT8vuf5ZoKfNrMkzG2+RO1prtqYv+t2Vm00j?=
 =?us-ascii?Q?FycdAKGacQ+wvRiS3fPkKzSNbT82MZBua8diEDArN3KTqkJGO73RhhMce7R5?=
 =?us-ascii?Q?0lKdCGQoDj10+EW3MkIJ1HkooEsuz6gxHxP9/Yu2vjEDlATIl44EVDUwmA6X?=
 =?us-ascii?Q?wkuPyP7XPz8yeO73wWDLtlysYWKtmnSPSI35iuzDd9bXLdhycrk3tB312kOs?=
 =?us-ascii?Q?u6AlDB5kn0h7M7mbz8wIaLVlipCwjoUBAQCS/+ewhiUs1hcMrqJYKow8PiIf?=
 =?us-ascii?Q?y+pT7XhSgOHSd6kAVvoWvGYG7W5O/Vuc4EC5Saipq/3ieaUTIbgjf+o6XqWx?=
 =?us-ascii?Q?BUDvEWbWk0/HdnQanpe/iIqSoL4hpB7V/WXsrp9Nqcs7L90vjewni7Om1uPr?=
 =?us-ascii?Q?uoShS22bbeg4CBle2VNL19pTEXfW9ChiJU/fP+wls+WtG/hQi8l4eDPPJj1f?=
 =?us-ascii?Q?GDe1A+X7o36wYjiRBdWzrOjhYU0cyTNbCSpyCxygT+bYbX+tvmKaerRHa02S?=
 =?us-ascii?Q?goDg8tqKO4p7pz1c1hYQEAnmNzeQcm7PBJqf4wjQ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a01a0a1d-9d6f-42a9-674b-08dbdb336a15
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2023 23:36:47.3582
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YgRFcG0EEW9WpUjDu5KSSWViIf7QIHq1gWlcYv0RviofULX4zn8+6VT7mOdHG0nb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5338

The HW supports this, use the S1DSS bits to configure the behavior
of SSID=0 which is the RID's translation.

If SSID's are currently being used in the CD table then just update the
S1DSS bits in the STE, remove the master_domain and leave ATS alone.

For iommufd the driver design has a small problem that all the unused CD
table entries are set with V=0 which will generate an event if VFIO
userspace tries to use the CD entry. This patch extends this problem to
include the RID as well if PASID is being used.

For BLOCKED with used PASIDs the
F_STREAM_DISABLED (STRTAB_STE_1_S1DSS_TERMINATE) event is generated on
untagged traffic and a substream CD table entry with V=0 (removed pasid)
will generate C_BAD_CD. Arguably there is no advantage to using S1DSS over
the CD entry 0 with V=0.

As we don't yet support PASID in iommufd this is a problem to resolve
later, possibly by using EPD0 for unused CD table entries instead of V=0,
and not using S1DSS for BLOCKED.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 66 ++++++++++++++-------
 1 file changed, 43 insertions(+), 23 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 457b1fd8a9ab0d..364ac78da16b48 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -1485,7 +1485,7 @@ static void arm_smmu_make_bypass_ste(struct arm_smmu_ste *target)
 static void arm_smmu_make_cdtable_ste(struct arm_smmu_ste *target,
 				      struct arm_smmu_master *master,
 				      struct arm_smmu_ctx_desc_cfg *cd_table,
-				      bool ats_enabled)
+				      bool ats_enabled, unsigned int s1dss)
 {
 	struct arm_smmu_device *smmu = master->smmu;
 
@@ -1498,7 +1498,7 @@ static void arm_smmu_make_cdtable_ste(struct arm_smmu_ste *target,
 		FIELD_PREP(STRTAB_STE_0_S1CDMAX, cd_table->s1cdmax));
 
 	target->data[1] = cpu_to_le64(
-		FIELD_PREP(STRTAB_STE_1_S1DSS, STRTAB_STE_1_S1DSS_SSID0) |
+		FIELD_PREP(STRTAB_STE_1_S1DSS, s1dss) |
 		FIELD_PREP(STRTAB_STE_1_S1CIR, STRTAB_STE_1_S1C_CACHE_WBRA) |
 		FIELD_PREP(STRTAB_STE_1_S1COR, STRTAB_STE_1_S1C_CACHE_WBRA) |
 		FIELD_PREP(STRTAB_STE_1_S1CSH, ARM_SMMU_SH_ISH) |
@@ -1511,7 +1511,11 @@ static void arm_smmu_make_cdtable_ste(struct arm_smmu_ste *target,
 		FIELD_PREP(STRTAB_STE_1_STRW,
 			   (smmu->features & ARM_SMMU_FEAT_E2H) ?
 				   STRTAB_STE_1_STRW_EL2 :
-				   STRTAB_STE_1_STRW_NSEL1));
+				   STRTAB_STE_1_STRW_NSEL1) |
+		FIELD_PREP(STRTAB_STE_1_SHCFG,
+			   s1dss == STRTAB_STE_1_S1DSS_BYPASS ?
+				   STRTAB_STE_1_SHCFG_INCOMING :
+				   0));
 }
 
 static void arm_smmu_make_s2_domain_ste(struct arm_smmu_ste *target,
@@ -2656,7 +2660,8 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 		arm_smmu_write_cd_entry(master, IOMMU_NO_PASID, cdptr,
 					&target_cd);
 		arm_smmu_make_cdtable_ste(&target, master, &master->cd_table,
-					  state.want_ats);
+					  state.want_ats,
+					  STRTAB_STE_1_S1DSS_SSID0);
 		arm_smmu_install_ste_for_dev(master, &target);
 		break;
 	}
@@ -2727,16 +2732,14 @@ static void arm_smmu_remove_dev_pasid(struct device *dev, ioasid_t pasid)
 	mutex_unlock(&master->smmu->asid_lock);
 }
 
-static int arm_smmu_attach_dev_ste(struct device *dev,
-				   struct arm_smmu_ste *ste)
+static void arm_smmu_attach_dev_ste(struct device *dev,
+				    struct arm_smmu_ste *ste,
+				    unsigned int s1dss)
 {
 	struct arm_smmu_master *master = dev_iommu_priv_get(dev);
 	struct arm_smmu_domain *old_domain =
 		to_smmu_domain_safe(iommu_get_domain_for_dev(master->dev));
 
-	if (arm_smmu_ssids_in_use(&master->cd_table))
-		return -EBUSY;
-
 	/*
 	 * Do not allow any ASID to be changed while are working on the STE,
 	 * otherwise we could miss invalidations.
@@ -2744,19 +2747,34 @@ static int arm_smmu_attach_dev_ste(struct device *dev,
 	mutex_lock(&master->smmu->asid_lock);
 
 	/*
-	 * The SMMU does not support enabling ATS with bypass/abort. When the
-	 * STE is in bypass (STE.Config[2:0] == 0b100), ATS Translation Requests
-	 * and Translated transactions are denied as though ATS is disabled for
-	 * the stream (STE.EATS == 0b00), causing F_BAD_ATS_TREQ and
-	 * F_TRANSL_FORBIDDEN events (IHI0070Ea 5.2 Stream Table Entry).
+	 * If the CD table is not in use we can use the provided STE, otherwise
+	 * we use a cdtable STE with the provided S1DSS.
 	 */
-	if (master->ats_enabled) {
-		pci_disable_ats(to_pci_dev(master->dev));
+	if (!arm_smmu_ssids_in_use(&master->cd_table)) {
 		/*
-		 * Ensure ATS is disabled at the endpoint before we issue the
-		 * ATC invalidation via the SMMU.
+		 * The SMMU does not support enabling ATS with bypass/abort.
+		 * When the STE is in bypass (STE.Config[2:0] == 0b100), ATS
+		 * Translation Requests and Translated transactions are denied
+		 * as though ATS is disabled for the stream (STE.EATS == 0b00),
+		 * causing F_BAD_ATS_TREQ and F_TRANSL_FORBIDDEN events
+		 * (IHI0070Ea 5.2 Stream Table Entry).
 		 */
-		wmb();
+		if (master->ats_enabled) {
+			pci_disable_ats(to_pci_dev(master->dev));
+			/*
+			 * Ensure ATS is disabled at the endpoint before we
+			 * issue the ATC invalidation via the SMMU.
+			 */
+			wmb();
+		}
+	} else {
+		/*
+		 * It also does not support ATS with S1DSS = bypass but we have
+		 * no idea what the other PASIDs are doing so it has to be left
+		 * on.
+		 */
+		arm_smmu_make_cdtable_ste(ste, master, &master->cd_table,
+					  master->ats_enabled, s1dss);
 	}
 
 	arm_smmu_install_ste_for_dev(master, ste);
@@ -2768,7 +2786,8 @@ static int arm_smmu_attach_dev_ste(struct device *dev,
 					      IOMMU_NO_PASID);
 	}
 
-	master->ats_enabled = false;
+	if (!arm_smmu_ssids_in_use(&master->cd_table))
+		master->ats_enabled = false;
 
 	mutex_unlock(&master->smmu->asid_lock);
 
@@ -2778,7 +2797,6 @@ static int arm_smmu_attach_dev_ste(struct device *dev,
 	 * descriptor from arm_smmu_share_asid().
 	 */
 	arm_smmu_clear_cd(master, IOMMU_NO_PASID);
-	return 0;
 }
 
 static int arm_smmu_attach_dev_identity(struct iommu_domain *domain,
@@ -2787,7 +2805,8 @@ static int arm_smmu_attach_dev_identity(struct iommu_domain *domain,
 	struct arm_smmu_ste ste;
 
 	arm_smmu_make_bypass_ste(&ste);
-	return arm_smmu_attach_dev_ste(dev, &ste);
+	arm_smmu_attach_dev_ste(dev, &ste, STRTAB_STE_1_S1DSS_BYPASS);
+	return 0;
 }
 
 static const struct iommu_domain_ops arm_smmu_identity_ops = {
@@ -2805,7 +2824,8 @@ static int arm_smmu_attach_dev_blocked(struct iommu_domain *domain,
 	struct arm_smmu_ste ste;
 
 	arm_smmu_make_abort_ste(&ste);
-	return arm_smmu_attach_dev_ste(dev, &ste);
+	arm_smmu_attach_dev_ste(dev, &ste, STRTAB_STE_1_S1DSS_TERMINATE);
+	return 0;
 }
 
 static const struct iommu_domain_ops arm_smmu_blocked_ops = {
-- 
2.42.0

