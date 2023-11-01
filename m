Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2051.outbound.protection.outlook.com [40.107.244.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 095E71C6AA
	for <iommu@lists.linux.dev>; Wed,  1 Nov 2023 23:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VEDaVz1U"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CuCxtsWwjF3lsZ82Oh1Coh9qo6obO7GiGQMV+35oZ8SOxVgHbuT5Mmz5hz4dz0bKUIy3Pi2ue5PDzHiDsyhnI0q9SeDTleMfIKd1f1NsRvTZpOe55g1+Tj1nNTnUK849Hslgx/bBCX1o1Nl0zIsaSFTiSsVT/1AeOTCMlWNc+AoWqL1EJPgP6oE8evDzt61U5kqd0qVLL6fYdmiQHHmcYgDsix61rbwm1LtZ2F7mWbp+zLFg2lEkawaH0QCf5JV95Wr0zvQgWktpOztUHaIc+ZMw5GLowpj29bvY4kI66+wL7FbVnozP+HIOrFG131Ohu5WDzui+cbzWv+aRJZ7RCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Tll8psXY+4Z8He1bBdO292WiMoFZ3RTDzdsz3sPuzM=;
 b=b0XjkNIGsZ4OZI2MtZ7W1TIY7jyxQM0mB0Xrx3bExZVJfDwoyUVhyzKorL9baH2ypmeiUfFyqZk8iCozcm9jkt2A5Sl4Urv+ertEOtvzWtNm/wAA4k8BXV5LkdvfegmC0feoL3BQFTdCkzwUpwHKL9vw7ow9V2bcj8KthMh4BO8WB/C+lCG2EW/JfX8KSxi5D76v22EIVDdVONRYKD7KNNxLdksEs8OVzYFQ7P/DHXuedwL3tYkBj3r2rO5HErGjm477OfWwpY6CWa+/nYvu0P7cI2wiJykLnzqeaWiaoQ2G81VIgU3ify2dHIqcEnMAzJs8Fo4fucqQcavL+og+8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Tll8psXY+4Z8He1bBdO292WiMoFZ3RTDzdsz3sPuzM=;
 b=VEDaVz1UOd5KhdznErc+JN7pzDWeZaeJ7TZJemzL2u8KLy/iVu6bgNPQU8SjWc2l0ckCFE+5WuN3pGVsD7FrmlH9a6yfFf20vN8VxrcqQqusoe3WjLtaZ3w5Z+IEnlkpatUkzLh6jCE+YjN8GAhNevLGXiWxnac/pdZp4j6oL26T2hQiFMpXnkhjn8jKo9mqr6XPHDv9hLgbf3lx7eJFtg6c0SRaz/Ur8CcxAKvryQ2w+TJZmf0ZC9P4jp08m95mgvegTodOsMpevNGBuktvtG6hRXaPVUWNNrkbergsiaXtn2p1gkh9Jsb8+hHZc5bBhdjd/7rS2666qr3C574k+Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by BL1PR12MB5301.namprd12.prod.outlook.com (2603:10b6:208:31f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.19; Wed, 1 Nov
 2023 23:36:47 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::b53a:1092:9be2:cfb9]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::b53a:1092:9be2:cfb9%4]) with mapi id 15.20.6933.027; Wed, 1 Nov 2023
 23:36:47 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>,
	linux-arm-kernel@lists.infradead.org,
	Robin Murphy <robin.murphy@arm.com>,
	Will Deacon <will@kernel.org>
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Michael Shavit <mshavit@google.com>,
	Nicolin Chen <nicolinc@nvidia.com>
Subject: [PATCH v2 07/27] iommu/arm-smmu-v3: Move the CD generation for S1 domains into a function
Date: Wed,  1 Nov 2023 20:36:25 -0300
Message-ID: <7-v2-16665a652079+5947-smmuv3_newapi_p2_jgg@nvidia.com>
In-Reply-To: <0-v2-16665a652079+5947-smmuv3_newapi_p2_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0280.namprd13.prod.outlook.com
 (2603:10b6:208:2bc::15) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|BL1PR12MB5301:EE_
X-MS-Office365-Filtering-Correlation-Id: ed40ebd5-1381-4c06-0bc6-08dbdb336978
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	lTQqH0PnGxQRj419f7SpAv3c1dV47wpprccCk0op5ny6IcHUcyMZekPIdkfG3yhJJapBCsY15mWrpze3x/CSQQMQRoqNg5vLceXAse7dEr7N8orNDlFeunI1LrWM52R3Mrw+y6BJgnhEZ3ooCqHR6UbT/7irfPwBJLEC3sBPCwTOtWuD3spkIcGR/pGb6qB7nxaL76L2t6+ZmkqVBkzbmeTL1wXm/q0jpdDFGdPMtINRUYd/AUTZoGjx6mcSK9fYq3hfQqYHRbje1lt83uA+N7gTddcsxPIh7gbW9nj4YB4S98N8zPbDWxSjdnNEbwp6NMjNG1v4a8kpWLMr0+URvXuExfssp2Z9bX/JjS1NoiRzticlrRneLTV9dnP6hQ2MtaOPmnhg3g2OMUhe8VtwJgFn6HCe2ufa0EOx3A5ObEO80MJukp+B+FM7q883daXk9Mve4KKLR52bJfzahslVCOM3IRcyBPh6c/4Qz8Kgkn33bE+Bkdt360kOZWKH8ymT5tP8xFppYuywT2ft8geHVhHQACytScsoFKHUqxhz6qnYApdgyT3n9jWywbjoWtd33mBonI85hH9vFov1tLTS4JQhmDedBLeaHWq48wTNVqreGvqnOhNkvqQ5hctrW+vP/hvQjfFI49W/XVki5MnaZw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(346002)(396003)(39860400002)(376002)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(4326008)(8936002)(83380400001)(86362001)(2906002)(38100700002)(8676002)(36756003)(5660300002)(41300700001)(26005)(66946007)(6506007)(6512007)(478600001)(6486002)(6666004)(54906003)(66476007)(316002)(66556008)(110136005)(2616005)(107886003)(4216001)(473944003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xjdgMKkeBH0+Fv6PYUNsOWoUFAgNbH6/PB8YdwR+I1bq194UWZmprCddt87D?=
 =?us-ascii?Q?+4zKVnpjJrUwESgwv7SVCcEI3vccjTu7LSp/3Cq99t5vLCiaeKhunej/oS0X?=
 =?us-ascii?Q?w/ZvMoKdv74nU80UUQZSFBab1MJC/zEB1gjeyYUBLD4uNmLeGVZ3mxScxZq5?=
 =?us-ascii?Q?xS7cYMznzWwGKoF0TwY7KcWUJkkowpD9mtL1jkvtKdZgH6A139PN7XSJYgEc?=
 =?us-ascii?Q?zrqsgfok5Yj0uFfdVhcsP1KV6pW0Sp1VKgvyT6dB8+RPp//qLCjf9Vyt1dUX?=
 =?us-ascii?Q?ZgzQXoHLhb7KmA5dNHIMYeYNVMP8cYpHUyppBbTugNHBeke4pEbD9h95IWfh?=
 =?us-ascii?Q?Zvue11eXOj5KYSeRukIwRdxIs3fYkyXO3oyMjSMQX9+FRYPEHUWaOBAyxaIr?=
 =?us-ascii?Q?Sjl8oQ6OY9S2895p+jy5WzRCyDpH7guVrDI36QZ4PKgLGkVG9+3k11ahc7xb?=
 =?us-ascii?Q?6d56LWmHFd+vbMXl4gBCwlnEFQSbAOiNrLeOqEbS/zuOcqq6Qk8LTscYB4Sc?=
 =?us-ascii?Q?h+QbGRovd7GwRZ5bJ9ajiP6nrKEYGK4TjLiKksZ40HHpJcQySQcmeJz+mV35?=
 =?us-ascii?Q?IkNDvPShZtSFxNaA2hLKN+B1MqM+aPeHEwM4fVeywaI9EoFbYx7L/dE2WfDF?=
 =?us-ascii?Q?sA8rPaZ0qj4p8ygMUYEx5WYHgjy4eBl/ijV3lOFXJgdy456oFhaUR5TJoPrd?=
 =?us-ascii?Q?0SfUHAdCDTsOKi2ROFOaaIlu0G/9UhJZJE2ltTqRxLPZwNSaNd8T6Q/QnHzE?=
 =?us-ascii?Q?/drEHMUeKqCiIiTgKDmf5qYfq0/OgyUVHT1rh73NkbsQ4LTRRgtETANqUgXU?=
 =?us-ascii?Q?06UyrlLFskzUjBftDEEGMTgtzMVI3B0rK+xbsSSb24zUBy2tiC9LfRBUUIYi?=
 =?us-ascii?Q?MKY8NEZ0thV7CZZ15ghz3zVweDZgJS091ym+Ikkxw9sOWXSyZmj+naNwjx/r?=
 =?us-ascii?Q?OQoWQ6g2nOP487CC7TVDiSsNAGgDiRTbXuOaHkEt7kHnQXsWcxnKH7MRa7bd?=
 =?us-ascii?Q?n3M41FZekRmlyrXEQRHmX4bXJZ+w0sB7sLMI5MfTJnDwdY+UsA6TzA745zwl?=
 =?us-ascii?Q?fhQs8tAQ1+AhPnkdxjdEqqV++umyLZpxMwQ7aDa7noVgqMxc+NJhMq4Ci398?=
 =?us-ascii?Q?kwzFcp5lHzP8ZAU2RpXwRjmYCd+TikIET28rnDsOOom2gQgS0K35pAvNyTCg?=
 =?us-ascii?Q?82OjFNeueq4JK+7cEhBxGInQEkoyj/jClCcHwz+zTueRHtBJ9dvtfzngyY4s?=
 =?us-ascii?Q?4aNUctztjCbxDwGEUyHWUwJgk2s75m+8DB/n51p+kkv2aPQo8UoTUQgRohGR?=
 =?us-ascii?Q?R/Y0bd3qIr0/z2JxTwhtqABjKVUr5N6bda9h5TKIUMTR3KmAQGhEJdcXs7Jf?=
 =?us-ascii?Q?R2z2wo7wdb8McRUsR8ipn1zBmrGB+nPypYNVPAIsvao0btmGN04TvpUzd+vz?=
 =?us-ascii?Q?u9s34FHUfHoszKbO7aqVvA0UYTsWYLADr7PMe27SlNp1ZrcpL4bFO60Ma5Pn?=
 =?us-ascii?Q?h4L208bbWoWB7U9jmA2RXGxBcjDFZOEgZOv+FrtFJYCBiqDT56sb30Xl5WY6?=
 =?us-ascii?Q?znqFTiCqZoXAZ+KxoRvqI3/EHjg+gLkbD2y2/hrO?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed40ebd5-1381-4c06-0bc6-08dbdb336978
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2023 23:36:46.3655
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ayRNVu2u4gVQbIYYzw7d7/PqTyZ2ZDYMbfKk1Witk/FNr/cgHiwbgImXlgufFlQp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5301

Introduce arm_smmu_make_s1_cd() to build the CD from the paging S1 domain,
and reorganize all the places programming S1 domain CD table entries to
call it.

Split arm_smmu_update_s1_domain_cd_entry() from
arm_smmu_update_ctx_desc_devices() so that the S1 path has its own call
chain separate from the unrelated SVA path.

arm_smmu_update_s1_domain_cd_entry() only works on S1 domains
attached to RIDs and refreshes all their CDs.

Remove the forced clear of the CD during S1 domain attach,
arm_smmu_write_cd_entry() will do this automatically if necessary.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c   | 25 +++++++-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 60 +++++++++++++------
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  8 +++
 3 files changed, 75 insertions(+), 18 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
index 521bfa18879f90..04a807774402b2 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
@@ -54,6 +54,29 @@ static void arm_smmu_update_ctx_desc_devices(struct arm_smmu_domain *smmu_domain
 	spin_unlock_irqrestore(&smmu_domain->devices_lock, flags);
 }
 
+static void
+arm_smmu_update_s1_domain_cd_entry(struct arm_smmu_domain *smmu_domain)
+{
+	struct arm_smmu_master *master;
+	struct arm_smmu_cd target_cd;
+	unsigned long flags;
+
+	spin_lock_irqsave(&smmu_domain->devices_lock, flags);
+	list_for_each_entry(master, &smmu_domain->devices, domain_head) {
+		struct arm_smmu_cd *cdptr;
+
+		/* S1 domains only support RID attachment right now */
+		cdptr = arm_smmu_get_cd_ptr(master, IOMMU_NO_PASID);
+		if (WARN_ON(!cdptr))
+			continue;
+
+		arm_smmu_make_s1_cd(&target_cd, master, smmu_domain);
+		arm_smmu_write_cd_entry(master, IOMMU_NO_PASID, cdptr,
+					&target_cd);
+	}
+	spin_unlock_irqrestore(&smmu_domain->devices_lock, flags);
+}
+
 /*
  * Check if the CPU ASID is available on the SMMU side. If a private context
  * descriptor is using it, try to replace it.
@@ -97,7 +120,7 @@ arm_smmu_share_asid(struct mm_struct *mm, u16 asid)
 	 * be some overlap between use of both ASIDs, until we invalidate the
 	 * TLB.
 	 */
-	arm_smmu_update_ctx_desc_devices(smmu_domain, IOMMU_NO_PASID, cd);
+	arm_smmu_update_s1_domain_cd_entry(smmu_domain);
 
 	/* Invalidate TLB entries previously associated with that context */
 	arm_smmu_tlb_inv_asid(smmu, asid);
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 790e7911714dc8..46d0a45fb0f525 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -1118,8 +1118,8 @@ static void arm_smmu_write_cd_l1_desc(__le64 *dst,
 	WRITE_ONCE(*dst, cpu_to_le64(val));
 }
 
-static struct arm_smmu_cd *arm_smmu_get_cd_ptr(struct arm_smmu_master *master,
-					       u32 ssid)
+struct arm_smmu_cd *arm_smmu_get_cd_ptr(struct arm_smmu_master *master,
+					u32 ssid)
 {
 	__le64 *l1ptr;
 	unsigned int idx;
@@ -1181,9 +1181,9 @@ static bool arm_smmu_write_cd_step(struct arm_smmu_cd *cur,
 
 }
 
-static void arm_smmu_write_cd_entry(struct arm_smmu_master *master, int ssid,
-				    struct arm_smmu_cd *cdptr,
-				    const struct arm_smmu_cd *target)
+void arm_smmu_write_cd_entry(struct arm_smmu_master *master, int ssid,
+			     struct arm_smmu_cd *cdptr,
+			     const struct arm_smmu_cd *target)
 {
 	struct arm_smmu_cd target_used;
 
@@ -1195,6 +1195,32 @@ static void arm_smmu_write_cd_entry(struct arm_smmu_master *master, int ssid,
 	}
 }
 
+void arm_smmu_make_s1_cd(struct arm_smmu_cd *target,
+			 struct arm_smmu_master *master,
+			 struct arm_smmu_domain *smmu_domain)
+{
+	struct arm_smmu_ctx_desc *cd = &smmu_domain->cd;
+
+	memset(target, 0, sizeof(*target));
+
+	target->data[0] = cpu_to_le64(
+		cd->tcr |
+#ifdef __BIG_ENDIAN
+		CTXDESC_CD_0_ENDI |
+#endif
+		CTXDESC_CD_0_V |
+		CTXDESC_CD_0_AA64 |
+		(master->stall_enabled ? CTXDESC_CD_0_S : 0) |
+		CTXDESC_CD_0_R |
+		CTXDESC_CD_0_A |
+		CTXDESC_CD_0_ASET |
+		FIELD_PREP(CTXDESC_CD_0_ASID, cd->asid)
+		);
+
+	target->data[1] = cpu_to_le64(cd->ttbr & CTXDESC_CD_1_TTB0_MASK);
+	target->data[3] = cpu_to_le64(cd->mair);
+}
+
 void arm_smmu_clear_cd(struct arm_smmu_master *master, int ssid)
 {
 	struct arm_smmu_cd target = {};
@@ -2609,29 +2635,29 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 	spin_unlock_irqrestore(&smmu_domain->devices_lock, flags);
 
 	switch (smmu_domain->stage) {
-	case ARM_SMMU_DOMAIN_S1:
+	case ARM_SMMU_DOMAIN_S1: {
+		struct arm_smmu_cd target_cd;
+		struct arm_smmu_cd *cdptr;
+
 		if (!master->cd_table.cdtab) {
 			ret = arm_smmu_alloc_cd_tables(master);
 			if (ret)
 				goto out_list_del;
-		} else {
-			/*
-			 * arm_smmu_write_ctx_desc() relies on the entry being
-			 * invalid to work, clear any existing entry.
-			 */
-			ret = arm_smmu_write_ctx_desc(master, IOMMU_NO_PASID,
-						      NULL);
-			if (ret)
-				goto out_list_del;
 		}
 
-		ret = arm_smmu_write_ctx_desc(master, IOMMU_NO_PASID, &smmu_domain->cd);
-		if (ret)
+		cdptr = arm_smmu_get_cd_ptr(master, IOMMU_NO_PASID);
+		if (!cdptr) {
+			ret = -ENOMEM;
 			goto out_list_del;
+		}
 
+		arm_smmu_make_s1_cd(&target_cd, master, smmu_domain);
+		arm_smmu_write_cd_entry(master, IOMMU_NO_PASID, cdptr,
+					&target_cd);
 		arm_smmu_make_cdtable_ste(&target, master, &master->cd_table);
 		arm_smmu_install_ste_for_dev(master, &target);
 		break;
+	}
 	case ARM_SMMU_DOMAIN_S2:
 		arm_smmu_make_s2_domain_ste(&target, master, smmu_domain);
 		arm_smmu_install_ste_for_dev(master, &target);
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index a8e7574ab8e154..950f5a08acda6d 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -764,6 +764,14 @@ extern struct mutex arm_smmu_asid_lock;
 extern struct arm_smmu_ctx_desc quiet_cd;
 
 void arm_smmu_clear_cd(struct arm_smmu_master *master, int ssid);
+struct arm_smmu_cd *arm_smmu_get_cd_ptr(struct arm_smmu_master *master,
+					u32 ssid);
+void arm_smmu_make_s1_cd(struct arm_smmu_cd *target,
+			 struct arm_smmu_master *master,
+			 struct arm_smmu_domain *smmu_domain);
+void arm_smmu_write_cd_entry(struct arm_smmu_master *master, int ssid,
+			     struct arm_smmu_cd *cdptr,
+			     const struct arm_smmu_cd *target);
 
 int arm_smmu_write_ctx_desc(struct arm_smmu_master *smmu_master, int ssid,
 			    struct arm_smmu_ctx_desc *cd);
-- 
2.42.0

