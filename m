Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2064.outbound.protection.outlook.com [40.107.93.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1585405EF
	for <iommu@lists.linux.dev>; Wed, 11 Oct 2023 23:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="BL9wOKcW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WqrpC6loIHBVdsFnatBEmgPusT85ZVhzyf/jFy48EYSsMhJ7sQn2HLSlTBz9eieYldUIW/ox63+xou8IzId27hUsbLxnoPjMCSsfMFz3EzPk5OLLqusgmpPxTYSNj6XcsFhKGPFu2b2TUYN7U2r2yHKImmyy1Hrm4ngGEdna59uSw3pWWImlbHjXzcB6S7oyLMsJIfrWHfBEdWTHD1rqiOmkhItIONaZ/ks1YAVoK6/Gw1Ls9jRTjkQrc9SJ3Klv6oBH/ShOIb5Vpbu2CQ3Rkf+nB//cBEte2HP0yaWwPOTV/0nYnLgODY5sovYoMhJMySjxDZyMkqFGHhAwoRRMYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dyi5MGKMYjAkBZ+oNlyr+oZltZC4OBsol+z0E7Hwo0Q=;
 b=fhlPGCAWh1cUm0cwHtcxWz2UdJdWp+jrHFngkC/pfDngKMtwyB7nrrPnkYUEI+FbRqki1hh/eUrSIeQgZ1uAZWrnS4UkDkKMDEA391uZtBA2x2khUDnfZK5E9JHBZURfcA+7UgNVyFkXHVYreOreqCTqxjmEqrMaushTMOoUWs2zeuGpFm40nKfWM2sjEnPZN6k3j3fI3NftGasvHdKjrcourTjGCpqS9z0WbcHSNrrz7m3eLHTMju6XQxLTsy5Y7MugEThO/R7jtsqXvRJZiRsZ1bjjsMzra23devNHIfPVO512KVh+GNoWo65taIySqrdld5AyshjFtmAoBQ3wJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dyi5MGKMYjAkBZ+oNlyr+oZltZC4OBsol+z0E7Hwo0Q=;
 b=BL9wOKcWdubOIF5RB8II47gVc2qU4wz4iFRPU2p0kRntGRNdWEXEe2vXNkuHsvtoM9sxLnjl84Yw9vEbIs8qdnWWysHp7dSKGAA+8qJf0SoQqTCufVowQwDsC+Xb5O7S/xabyFVMv1X8J+h/ZSbW6LNtG9Z1F8EiNLL6B+96AlWAQ+7Ewl3V2nrdmO8uNWIu3sdMRQvAR2I9q0yG4p6BSad+Aqo7AsXKrt+F/C4OKuUkuuEPw8KsXh1sqv9gY+1JbGd4MU5zY3584FR+YIAP1F27sDUM7A+WzCUiRcj2nerB6mhr9We+CWvsMpKrciaHDJjb5kbgoAXL6L4+zogf9w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CH0PR12MB8488.namprd12.prod.outlook.com (2603:10b6:610:18d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Wed, 11 Oct
 2023 23:26:10 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2%6]) with mapi id 15.20.6863.032; Wed, 11 Oct 2023
 23:26:10 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>,
	linux-arm-kernel@lists.infradead.org,
	Robin Murphy <robin.murphy@arm.com>,
	Will Deacon <will@kernel.org>
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Michael Shavit <mshavit@google.com>,
	Nicolin Chen <nicolinc@nvidia.com>
Subject: [PATCH 06/27] iommu/arm-smmu-v3: Consolidate clearing a CD table entry
Date: Wed, 11 Oct 2023 20:25:42 -0300
Message-ID: <6-v1-afbb86647bbd+5-smmuv3_newapi_p2_jgg@nvidia.com>
In-Reply-To: <0-v1-afbb86647bbd+5-smmuv3_newapi_p2_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0001.namprd13.prod.outlook.com
 (2603:10b6:208:256::6) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CH0PR12MB8488:EE_
X-MS-Office365-Filtering-Correlation-Id: 52222746-b25d-447e-f116-08dbcab1707d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	noVFdu+UqR0uV5f8H+JAtnpy7lskYfz+VDAMPcQk2XCK2XsRwLV3BTaq1mTVGy/f2gsR5j0XbqGZ2+3ZKY2No+2+vVliDF6W5i0ZuIFd23jEyTp6jjbvkEzMhsjyRAKI46SPmUiKCzLnWBt03c5GzcLHilYiheUZtXnfE2EHgE/F3KTcsoOGQJFmZSfGFQ7AkR3dSBPc2lj6aaUwK4yr2GlGgnzRaOvAccVLBUTqYhOFC2TMByOsmaLkNYZVHyI3CKoUDK35Xj/dx481DwVaXrCREnlgMhphq/m60R1VSDIgD13o1V1wZmDxBmoQRQNZ4SyBIuspV2RZHUjh47eSAbtPbcWsMrkFkHeYsSZDOo9pmfLu/7xRkvNnIEDAHF/7mTVYwjxSnm1769zoYUWI2ATweketJT52ZMZeKRv0WGLra3YY5y/8RQBMWOTzbENKDqc1I7P/RcPO3pcwF0J3uU9ba43NbQblv55xVsqxfJGqK/A4uciFrMKbHihRx+6nXhL3Jb6oWLv7J+R0nxYVsem2F5EGozxKP037IIrF0GWOKJJa7iKNY+iRSmpFoknGiIBNd81DDBSaR6kjZdtwtdN96S15FsDdup1ofTGAqUI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(39860400002)(376002)(346002)(136003)(230922051799003)(1800799009)(451199024)(64100799003)(186009)(66476007)(66556008)(8936002)(66946007)(316002)(54906003)(110136005)(2906002)(5660300002)(41300700001)(8676002)(4326008)(6486002)(38100700002)(2616005)(6666004)(107886003)(36756003)(26005)(6512007)(83380400001)(478600001)(86362001)(6506007)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gQwcHDCUXMA7Pe900HpWTYEBsEgqniOoa2MMzJnLkj0Tkp/een8fB7DVTtOB?=
 =?us-ascii?Q?582lcdJloVcZN3q5ENdaf4Y+5pKqQg6CFqGAG/tVI3qBqFw8GBOYnPVDYpVW?=
 =?us-ascii?Q?HqdO14q10bqxNfH8LKh+BPw1ENPCW7NxegfgAVYPgGRUib4u83jQQ8DQUzJQ?=
 =?us-ascii?Q?dGd70VZqyRDO1tfbIm96a2Z4oQ8geNi2wdhhA+SlkCV59uTFjvwNLkjRJzBb?=
 =?us-ascii?Q?bSd/+OYWPLdott/YNGHOvhmXmH3cLtxwuGBce0bZOYn7lU6uIYa093xnDx2T?=
 =?us-ascii?Q?4xI9yZ94h8VowOD8d1VImgfmON3No/oaSrQN/sUwDdwIf/fytowFaCUbicNk?=
 =?us-ascii?Q?6vI68eTteYlFXD8IDQyphqEfXvzQeiQ0BRkGhNmh/Bk9YVO05LV3glnYorkx?=
 =?us-ascii?Q?lWCtauhiIYd+nr0ERAl1+7bmdJm41lMO07AZ3I67YwQAojP3iS4CsVPNFn4b?=
 =?us-ascii?Q?/9m44Zc21Cq58tQg8xNFbfjckRPgvKd1B2xktEuBHq21so0SIO8PguAbboBr?=
 =?us-ascii?Q?eOn5FhaErmAB4j1B9bNbvb+hFp5jX+J2bnMmcmSGQumiRcnsUWQx9KoR8WdM?=
 =?us-ascii?Q?ZNh6rDMNaW8inWXOhevV3sjvgLfO+z/nLSp1/eq5VCenAN4PM5/A+rey1FGZ?=
 =?us-ascii?Q?4ExZ1p28bpfL1k6kuirl4ahxO///HtC2p3DlwdyUWrbwRxIAMVZF1F4LhOJq?=
 =?us-ascii?Q?X5lmpaFnJCq3dvUUvI7DXBd629yu1pZDBqcIcwORvCEy+2lM10yQGVIQUSbo?=
 =?us-ascii?Q?IJ5OfBgz0ZVXQCqbmTj1+gfnFrhlTNo2XqZJ9Jwy6wqCpIvfN6VZnpOrgwIx?=
 =?us-ascii?Q?VuNBKmMeCpyV21d+KbtBQwIWszKSwfRuNEig4BGGzH7Kxys2pnnnu6Qcu6JW?=
 =?us-ascii?Q?kHm5y/zuCNjkNnSiHJ2DTDKUE7DTafl9vx5B3r36cRIkCgiCpBsDgidLJYWc?=
 =?us-ascii?Q?0rE8CueZeqrz9CMkGMjB6ipfGN9qhPjwtoWrrI5Uc35bCCaVpfHl2zKVwowE?=
 =?us-ascii?Q?nQaWA5ZiqlInaPf1lH2wUEXFkHzynqW+XAi/E6BzKaacA4XMXqTwdnjtnpWD?=
 =?us-ascii?Q?iRcrlsmlFtbFNeaH8k/WV9dlnPxkV/2E/IrujG8aHbb503EFFq9auzL/tsjk?=
 =?us-ascii?Q?b8pjicwiPjQ6Pd6PojRLj9E6rYANynY/R8DJzWI9I0egU8UZyUgUfjsKx9+m?=
 =?us-ascii?Q?4Iu8eTj8wJD4ejw3v5x9XMAoYm0Z4KaYb5LCgSCFAnDNFNNqMXL0Bn7Eo5J+?=
 =?us-ascii?Q?AzkphoPZ7pgK49+ZxIlZUgaL91+uFcYp7ZL+iQLz7HoraSEfyP8Qn5w3Spmr?=
 =?us-ascii?Q?xuLjezXiIeVQo6luuJopJAIeu1y84fiH5/wMxXQvPXi44304AEfiN+6XRlbY?=
 =?us-ascii?Q?cr74zRnzPF6rjd+rQSC7u+563Q7Nxav8w7EvZBJAbY0JbGZdSmy/a+PN5Z1R?=
 =?us-ascii?Q?yuMAYASVQX+hwBD+ly0nsXSNCE0COHLuJ55eeyFRGvSK3zdyhkvLqyypu1Q3?=
 =?us-ascii?Q?HfIGs8W7nyuWn1U5Xk3Kxe+mVxBYFmsVjwbEvi6aI3zVGk5OqislgFIwbJs8?=
 =?us-ascii?Q?EwkdEsUqaPSb6iD6oWp5CTJOdxkyazsGQtx9zPuA?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52222746-b25d-447e-f116-08dbcab1707d
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2023 23:26:04.9988
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5F6IkSgY8WY4jd9qLu/XD4PzrPCCbeCMAQmhMLb3fC5XP2Yz+zQzPB+wlVzmfNjk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8488

A cleared entry is all 0's. Make arm_smmu_clear_cd() do this sequence.

If we are clearing an entry and for some reason it is not already
allocated in the CD table then something has gone wrong.

Move the two SVA flows that clear the CD to this interface.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c   |  9 +++++++--
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 20 ++++++++++++++-----
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  2 ++
 3 files changed, 24 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
index b2763faa17c8dd..e73e9b67e4f622 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
@@ -330,7 +330,7 @@ arm_smmu_mmu_notifier_get(struct arm_smmu_domain *smmu_domain,
 		ret = arm_smmu_write_ctx_desc(master, mm->pasid, cd);
 		if (ret) {
 			list_for_each_entry_from_reverse(master, &smmu_domain->devices, domain_head)
-				arm_smmu_write_ctx_desc(master, mm->pasid, NULL);
+				arm_smmu_clear_cd(master, mm->pasid);
 			break;
 		}
 	}
@@ -354,13 +354,18 @@ static void arm_smmu_mmu_notifier_put(struct arm_smmu_mmu_notifier *smmu_mn)
 	struct mm_struct *mm = smmu_mn->mn.mm;
 	struct arm_smmu_ctx_desc *cd = smmu_mn->cd;
 	struct arm_smmu_domain *smmu_domain = smmu_mn->domain;
+	struct arm_smmu_master *master;
+	unsigned long flags;
 
 	if (!refcount_dec_and_test(&smmu_mn->refs))
 		return;
 
 	list_del(&smmu_mn->list);
 
-	arm_smmu_update_ctx_desc_devices(smmu_domain, mm->pasid, NULL);
+	spin_lock_irqsave(&smmu_domain->devices_lock, flags);
+	list_for_each_entry(master, &smmu_domain->devices, domain_head)
+		arm_smmu_clear_cd(master, mm->pasid);
+	spin_unlock_irqrestore(&smmu_domain->devices_lock, flags);
 
 	/*
 	 * If we went through clear(), we've already invalidated, and no
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 64e11c56a58397..0590fd42aa01e3 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -1163,6 +1163,19 @@ static void arm_smmu_write_cd_entry(struct arm_smmu_master *master, int ssid,
 	}
 }
 
+void arm_smmu_clear_cd(struct arm_smmu_master *master, int ssid)
+{
+	struct arm_smmu_cd target = {};
+	struct arm_smmu_cd *cdptr;
+
+	if (!master->cd_table.cdtab)
+		return;
+	cdptr = arm_smmu_get_cd_ptr(master, ssid);
+	if (WARN_ON(!cdptr))
+		return;
+	arm_smmu_write_cd_entry(master, ssid, cdptr, &target);
+}
+
 int arm_smmu_write_ctx_desc(struct arm_smmu_master *master, int ssid,
 			    struct arm_smmu_ctx_desc *cd)
 {
@@ -2597,9 +2610,7 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 	case ARM_SMMU_DOMAIN_S2:
 		arm_smmu_make_s2_domain_ste(&target, master, smmu_domain);
 		arm_smmu_install_ste_for_dev(master, &target);
-		if (master->cd_table.cdtab)
-			arm_smmu_write_ctx_desc(master, IOMMU_NO_PASID,
-						      NULL);
+		arm_smmu_clear_cd(master, IOMMU_NO_PASID);
 		break;
 	}
 
@@ -2647,8 +2658,7 @@ static int arm_smmu_attach_dev_ste(struct device *dev,
 	 * arm_smmu_domain->devices to avoid races updating the same context
 	 * descriptor from arm_smmu_share_asid().
 	 */
-	if (master->cd_table.cdtab)
-		arm_smmu_write_ctx_desc(master, IOMMU_NO_PASID, NULL);
+	arm_smmu_clear_cd(master, IOMMU_NO_PASID);
 	return 0;
 }
 
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 24a77e0a97898b..a8e7574ab8e154 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -763,6 +763,8 @@ extern struct xarray arm_smmu_asid_xa;
 extern struct mutex arm_smmu_asid_lock;
 extern struct arm_smmu_ctx_desc quiet_cd;
 
+void arm_smmu_clear_cd(struct arm_smmu_master *master, int ssid);
+
 int arm_smmu_write_ctx_desc(struct arm_smmu_master *smmu_master, int ssid,
 			    struct arm_smmu_ctx_desc *cd);
 void arm_smmu_tlb_inv_asid(struct arm_smmu_device *smmu, u16 asid);
-- 
2.42.0

