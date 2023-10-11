Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2064.outbound.protection.outlook.com [40.107.93.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19B1C3A291
	for <iommu@lists.linux.dev>; Wed, 11 Oct 2023 23:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="W2jvTBMt"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QSUTbj+h7Vqhj7C7XZyEpXUQi9WudwjpaZkOtMGVmc52UqVMPmH6156CwRReCLpO7KsOsRg/r6nVznYC5uJ/8l6K/R0VU6iaC++J4gxONBRZ8fFyuce9S++9gkRpDG6znjnLUbeCcybBxbM0FmAqtEnxzhOeK7sBB2GnkA3ffHGxDYPJNUN1HuK8wddeJj9WHenbyMbJRRkX3yQf4ywR2AUC5se4XnjKjAoxWix/djoZG09JJ7I34XUdbjRdupF315iK1sFwsAaWTwvlfSG0esYwjU0MoS91KjLK/wcu3Jiguyuz1Zju6Twz6H7lRLtdQLua/RWC1Kss0oT4YS5yLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D9Ba8EFgAz3T7f8Rk2GuSJtJYbDWq0zmhHgmG2jrXIw=;
 b=kChLH9bfofovpJ7i9fnO0BIk+7+Z1WIoJ8F8gXIH9lysF9N/HZhjNSbvyJR8Y23r/kaaqcd8l3R1/+2VAsZtCyugTgLDXLGVQXVZZDMac8s5dJzFeqd/yeVL5iqDuX/B7eL6kOKXq0p4XXnaaiZyNF/sRs3ov2zcrQVuGuj+dVR7nOZfB2Euw6895+DMpFFHlxfudekNj01ZEzOWNyw9snYTTXV+7KGNunTnkYWen97VXNfEom7hapZyEA6Wul+MNxjVA2zNNlBOop/aXV+fVd0qxtqc1sdEA/TXV1E8eukz1+NJpnAlV7oZXEDnhNh9+l4fH0B6gwmpHpZmdOMRJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D9Ba8EFgAz3T7f8Rk2GuSJtJYbDWq0zmhHgmG2jrXIw=;
 b=W2jvTBMtQSo7E5WBzZVtuEDvDwdpwUJAGqi9L3BskMXPWdqd+Sy6QzYh5JiXtxVnT81Rt8GTAnnMVsiAjGA4LmE/cypr3Iexi8i2XFUpr29f+9kxwKn1av+jUZjXer1617XZGRmxAEHZ0gOob3hG6uQIRwX7HYhU+LRoLrAjdZdSO/TXCXwJjaq3s9QojmIZRGpDMTl9tM0Q232mWpXbVBiwHxNM43/KKa++JJT4nBhnHQaIf+aA5Nhnp3DazqaspWQ3vcDw0yGNeOxNk/zSuWMox+UwNh/NozpVwVWzl59e8DFIAjWfWPiGDROritvWr4PZhUvVf/6HHxWN0/HMiA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CH0PR12MB8488.namprd12.prod.outlook.com (2603:10b6:610:18d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Wed, 11 Oct
 2023 23:26:11 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2%6]) with mapi id 15.20.6863.032; Wed, 11 Oct 2023
 23:26:11 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>,
	linux-arm-kernel@lists.infradead.org,
	Robin Murphy <robin.murphy@arm.com>,
	Will Deacon <will@kernel.org>
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Michael Shavit <mshavit@google.com>,
	Nicolin Chen <nicolinc@nvidia.com>
Subject: [PATCH 25/27] iommu/arm-smmu-v3: Allow IDENTITY/BLOCKED to be set while PASID is used
Date: Wed, 11 Oct 2023 20:26:01 -0300
Message-ID: <25-v1-afbb86647bbd+5-smmuv3_newapi_p2_jgg@nvidia.com>
In-Reply-To: <0-v1-afbb86647bbd+5-smmuv3_newapi_p2_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR03CA0026.namprd03.prod.outlook.com
 (2603:10b6:208:23a::31) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CH0PR12MB8488:EE_
X-MS-Office365-Filtering-Correlation-Id: 73325c54-c4ec-4c21-9dd2-08dbcab170ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ehPoVRn/MnllGOsfKTMlZCQDssS1rh+r61UhSFr9vCFTEOQnbKHsv54p83t3jKE0GfTV/CXOVW1/XFVmNUNeKbKgCrDFPM7Gl9BqndO2JXoLlx6sE8pmuvk/DzFWV9eb4+YQAstUck/cq8wgRMotiVPPc8fbjvou1VtXvVkTpfyhFh8aD8OIfT/2HvTeBsAc1jO271ZGYZt39313hJNBzFvC9OWpz8LiCF+8yjm9+w7bYAsOcvKGou+I+y8i2WfTSbEYlZiB7zpanLfV7yJumcaj2ShgOw/8fz9GNufO06L6ubPAZBxA+RJMTDP7EynCdymyMabc5odt8NI9B81cKAa3blByFvYYmQ37ngJniRi8YzuKR7mwFBNdNR72UB1Z8bOEtvERVpWVF74TaMxU/z3/ZONIS9ZidIsUzdkcDkEZdaQO8cKfK7ro0XBaFczCQd1+95Ttj+gNHpzNqEfe+flpaq4F02+VZzK1OWuuxEjnse1eyqeqHl9WRtTAWEdhTrVEjUSVSoA+xqemXvYBGkPM4vCaIzx9YieKt4B2/Xi5RlQpKed+z3Pa1lL9JtshyC5h9UwWMAbRdvBNHcIEctxnTgjJSxZYroeuhMmJQno4SekLrUUnJAohsgcC6GpAdkNhbjqC5ZoY1bRh59VwiA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(39860400002)(376002)(346002)(136003)(230922051799003)(1800799009)(451199024)(64100799003)(186009)(66476007)(66556008)(8936002)(66946007)(316002)(54906003)(110136005)(2906002)(5660300002)(41300700001)(8676002)(4326008)(6486002)(38100700002)(2616005)(6666004)(107886003)(15650500001)(36756003)(26005)(6512007)(83380400001)(478600001)(86362001)(6506007)(414714003)(473944003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ylxL0b3JDFJ8Tz1TRaimxU08XabwIFO7jWXtG83TVNtX1HGsXgBePAQEkhN3?=
 =?us-ascii?Q?xAfu2NqDkPXHKUcXNwBriv1Psl0x172g0QlT6H6zZ4y+kCs12IrGrPXLzj75?=
 =?us-ascii?Q?H6+kC1hQ1sWLqVapyBJEKp4dJs/H7rgyB4jGQtCPHxpe9idmxx/ztwU8Mo71?=
 =?us-ascii?Q?USvUkUdqB/iGUtb7nJVFqO/mRY9sm5HK/duUXflUNaRMoass5XLPcNKwFjBx?=
 =?us-ascii?Q?/ZcU9IJrEJt/On8zK2ZNrKsurZlAogbhfHhc5dLAeouBmgPp1a9HRSpVHSPS?=
 =?us-ascii?Q?2/jR/f8ganEuUxfPGqgBWO+Fr1OYPKIv21kWxGb1Jz2oV2hzaJHOELJqNt2Z?=
 =?us-ascii?Q?AFPwN/HDmkncWGIDtQw/BDwUR6c7QhjV9ukbgX9F6EPY9JsNu38WNhS/f0Sa?=
 =?us-ascii?Q?AUFDgKKXF9yfhbjhLstPCMjQdu+DWiUTXX3BDdaqb0L4efYnqlxbMgnji7Fu?=
 =?us-ascii?Q?vN1N8wZY/Z5MYOQX2kINhxAGUWVWj8b+34nyT3uqD2Edv33v39c5ce5nNrov?=
 =?us-ascii?Q?AH5FLG4Ay+ZWDWSB4JceLixZvg15NLzkDg3hiAuYLZdLkafkgC86VuPKclnW?=
 =?us-ascii?Q?o6yM9Sia/ZeExGMYSRYSSV4tK4n9SDXRLdC8213vg7dwfHkMym2BJjpybPzn?=
 =?us-ascii?Q?56GGGHjg0n0kixduKhaVzAu06IViYYcQ6qRgUQj2RfXKHDCB1B8ncOOcoFFe?=
 =?us-ascii?Q?cP6Uiabf3iUJuu0CYrSBEca7Gf14+9V/UtnQASS1gsml5l4tfExAUTWb4ffI?=
 =?us-ascii?Q?tBfm21Fh1z0k9P8UAPr97f3DhKKcXvV3tMKEOC9BUUxhdiPW/f7HPpFUzhAA?=
 =?us-ascii?Q?3AWk1cpyAA/2s3bY2lwIWJ6fYXlonEILilUsF2S7M2J3XeaoIny1zNvPshfO?=
 =?us-ascii?Q?2oUHUqGJffqJEdTDtWOlZhsXGALAvI3THX/UfdpO57dSLhlFJGvGlvRjSjKp?=
 =?us-ascii?Q?PvQWoYUxkDYPVq7efEE55godPWzldgQVC1H0LQqf3+Zcb1lifcyE5mBXjx0z?=
 =?us-ascii?Q?YenP1c0IWudHtTNM3+RAmuCHc46+fBuVNY7wAzpiUswmM4kcNWIpoqBv/Tz9?=
 =?us-ascii?Q?MB5mek3D/5Fnt/ShUkjcN9mQMFPMG9C2xawyYUo8psmXnwnB7Tm8lY6aYS2O?=
 =?us-ascii?Q?RYil29SyQ2+5cGGVeHMtSW/JO+X5z41iux4cBXioMHWJNUl8iHtHnD2e87IO?=
 =?us-ascii?Q?OqVcExq1ZwdZLMLLTjxUC+5amMi+ccN9crn52eG/ltGS0ZbseFvqE/fiiLry?=
 =?us-ascii?Q?t50UFr7BRwJztPRhiDo7XrBQuuqK6EBtVIKgIWqE7Y3TdISng44j0Elf7Eeo?=
 =?us-ascii?Q?LTNpXVDydgpCwQag1ZNn99B0TZBvUxmI9QnlUSPPc9dlj4i+22ImObuHFdmq?=
 =?us-ascii?Q?W00pDoyzgQ0ozp6dpmn8Zt9o+1l9nSLzYYNZxPHfShgaRUb3bFODygg5IraR?=
 =?us-ascii?Q?J1VoyJAKSeAyvCopD9wJY7Ulb8cNacyZoqRRvKxmQqZ1Rx0mwf06vNoGdGxp?=
 =?us-ascii?Q?WMYgsxs/eyS0IRKPNXOM4hvmWXUxFVskYqil1uvzJlBBfOgrWZhoGXWSat6n?=
 =?us-ascii?Q?hIziBV6S8qnYixlAojwbYkG7aB2dHO+IPA71lpT8?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73325c54-c4ec-4c21-9dd2-08dbcab170ad
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2023 23:26:05.2493
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wvtx+zKTiZl4/wcRv4MErFEVG1A9JR/mPcMeylDKqXUlGGWQkEg93sgtY2qi3J9X
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8488

The HW supports this, use the S1DSS bits to configure the behavior
of SSID=0 which is the RID's translation.

If SSID's are currently being used in the CD table then just update the
S1DSS bits in the STE, remove the master_domain and leave ATS alone.

For iommufd the SMMUv3 HW has a small problem that once a CD table is
installed there is no way to abort transactions (either for untagged with
PASID or for PASID tagged) in a way that doesn't generate an event. This
means VFIO userspace and VM can flood the driver with advisory events.

For BLOCKED the F_STREAM_DISABLED (STRTAB_STE_1_S1DSS_TERMINATE) event is
generated on untagged traffic and a substream CD table entry with
V=0 (removed pasid) will generate C_BAD_CD.

As we don't yet support PASID in iommufd this is a problem to resolve
later.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 62 +++++++++++++--------
 1 file changed, 38 insertions(+), 24 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index e784bacc58e098..83d288fef51249 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -1460,7 +1460,7 @@ static void arm_smmu_make_bypass_ste(struct arm_smmu_ste *target)
 static void arm_smmu_make_cdtable_ste(struct arm_smmu_ste *target,
 				      struct arm_smmu_master *master,
 				      struct arm_smmu_ctx_desc_cfg *cd_table,
-				      bool ats_enabled)
+				      bool ats_enabled, unsigned int s1dss)
 {
 	struct arm_smmu_device *smmu = master->smmu;
 
@@ -1473,7 +1473,7 @@ static void arm_smmu_make_cdtable_ste(struct arm_smmu_ste *target,
 		FIELD_PREP(STRTAB_STE_0_S1CDMAX, cd_table->s1cdmax));
 
 	target->data[1] = cpu_to_le64(
-		FIELD_PREP(STRTAB_STE_1_S1DSS, STRTAB_STE_1_S1DSS_SSID0) |
+		FIELD_PREP(STRTAB_STE_1_S1DSS, s1dss) |
 		FIELD_PREP(STRTAB_STE_1_S1CIR, STRTAB_STE_1_S1C_CACHE_WBRA) |
 		FIELD_PREP(STRTAB_STE_1_S1COR, STRTAB_STE_1_S1C_CACHE_WBRA) |
 		FIELD_PREP(STRTAB_STE_1_S1CSH, ARM_SMMU_SH_ISH) |
@@ -1486,7 +1486,11 @@ static void arm_smmu_make_cdtable_ste(struct arm_smmu_ste *target,
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
@@ -2477,6 +2481,10 @@ static void arm_smmu_remove_master_domain(struct arm_smmu_master *master,
 	struct arm_smmu_master_domain *master_domain;
 	unsigned long flags;
 
+	/* NULL means the old domain is IDENTITY/BLOCKED which we don't track */
+	if (!smmu_domain)
+		return;
+
 	spin_lock_irqsave(&smmu_domain->devices_lock, flags);
 	master_domain = arm_smmu_find_master_domain(smmu_domain, master, ssid);
 	if (master_domain) {
@@ -2589,10 +2597,7 @@ static void arm_smmu_attach_remove(struct arm_smmu_master *master,
 				   struct arm_smmu_domain *smmu_domain,
 				   ioasid_t ssid)
 {
-	if (!smmu_domain)
-		return;
-
-	if (ssid == IOMMU_NO_PASID && master->ats_enabled) {
+	if (master->ats_enabled) {
 		pci_disable_ats(to_pci_dev(master->dev));
 		/*
 		 * Ensure ATS is disabled at the endpoint before we issue the
@@ -2604,8 +2609,7 @@ static void arm_smmu_attach_remove(struct arm_smmu_master *master,
 
 	arm_smmu_remove_master_domain(master, smmu_domain, ssid);
 
-	if (ssid == IOMMU_NO_PASID)
-		master->ats_enabled = false;
+	master->ats_enabled = false;
 }
 
 static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
@@ -2666,7 +2670,8 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 		arm_smmu_write_cd_entry(master, IOMMU_NO_PASID, cdptr,
 					&target_cd);
 		arm_smmu_make_cdtable_ste(&target, master, &master->cd_table,
-					  state.want_ats);
+					  state.want_ats,
+					  STRTAB_STE_1_S1DSS_SSID0);
 		arm_smmu_install_ste_for_dev(master, &target);
 		break;
 	}
@@ -2736,18 +2741,18 @@ static void arm_smmu_remove_dev_pasid(struct device *dev, ioasid_t pasid)
 	smmu_domain = to_smmu_domain(domain);
 
 	mutex_lock(&master->smmu->asid_lock);
-	arm_smmu_attach_remove(master, smmu_domain, pasid);
+	arm_smmu_remove_master_domain(master, smmu_domain, pasid);
 	arm_smmu_clear_cd(master, pasid);
 	mutex_unlock(&master->smmu->asid_lock);
 }
 
-static int arm_smmu_attach_dev_ste(struct device *dev,
-				   struct arm_smmu_ste *ste)
+static void arm_smmu_attach_dev_ste(struct device *dev,
+				    struct arm_smmu_ste *ste,
+				    unsigned int s1dss)
 {
 	struct arm_smmu_master *master = dev_iommu_priv_get(dev);
-
-	if (arm_smmu_ssids_in_use(&master->cd_table))
-		return -EBUSY;
+	struct arm_smmu_domain *old_domain =
+		to_smmu_domain_safe(iommu_get_domain_for_dev(master->dev));
 
 	/*
 	 * Do not allow any ASID to be changed while are working on the STE,
@@ -2755,6 +2760,19 @@ static int arm_smmu_attach_dev_ste(struct device *dev,
 	 */
 	mutex_lock(&master->smmu->asid_lock);
 
+	/*
+	 * If the CD table is still in use then we need to keep it installed and
+	 * use the S1DSS to change the mode.
+	 */
+	if (arm_smmu_ssids_in_use(&master->cd_table)) {
+		arm_smmu_make_cdtable_ste(ste, master, &master->cd_table,
+					  master->ats_enabled, s1dss);
+		arm_smmu_remove_master_domain(master, old_domain,
+					      IOMMU_NO_PASID);
+	} else {
+		arm_smmu_attach_remove(master, old_domain, IOMMU_NO_PASID);
+	}
+
 	/*
 	 * The SMMU does not support enabling ATS with bypass/abort. When the
 	 * STE is in bypass (STE.Config[2:0] == 0b100), ATS Translation Requests
@@ -2762,11 +2780,6 @@ static int arm_smmu_attach_dev_ste(struct device *dev,
 	 * the stream (STE.EATS == 0b00), causing F_BAD_ATS_TREQ and
 	 * F_TRANSL_FORBIDDEN events (IHI0070Ea 5.2 Stream Table Entry).
 	 */
-	arm_smmu_attach_remove(
-		master,
-		to_smmu_domain_safe(iommu_get_domain_for_dev(master->dev)),
-		IOMMU_NO_PASID);
-
 	arm_smmu_install_ste_for_dev(master, ste);
 	mutex_unlock(&master->smmu->asid_lock);
 
@@ -2776,7 +2789,6 @@ static int arm_smmu_attach_dev_ste(struct device *dev,
 	 * descriptor from arm_smmu_share_asid().
 	 */
 	arm_smmu_clear_cd(master, IOMMU_NO_PASID);
-	return 0;
 }
 
 static int arm_smmu_attach_dev_identity(struct iommu_domain *domain,
@@ -2785,7 +2797,8 @@ static int arm_smmu_attach_dev_identity(struct iommu_domain *domain,
 	struct arm_smmu_ste ste;
 
 	arm_smmu_make_bypass_ste(&ste);
-	return arm_smmu_attach_dev_ste(dev, &ste);
+	arm_smmu_attach_dev_ste(dev, &ste, STRTAB_STE_1_S1DSS_BYPASS);
+	return 0;
 }
 
 static const struct iommu_domain_ops arm_smmu_identity_ops = {
@@ -2803,7 +2816,8 @@ static int arm_smmu_attach_dev_blocked(struct iommu_domain *domain,
 	struct arm_smmu_ste ste;
 
 	arm_smmu_make_abort_ste(&ste);
-	return arm_smmu_attach_dev_ste(dev, &ste);
+	arm_smmu_attach_dev_ste(dev, &ste, STRTAB_STE_1_S1DSS_TERMINATE);
+	return 0;
 }
 
 static const struct iommu_domain_ops arm_smmu_blocked_ops = {
-- 
2.42.0

