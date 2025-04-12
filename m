Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2041.outbound.protection.outlook.com [40.107.94.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EC8BD53C
	for <iommu@lists.linux.dev>; Sat, 12 Apr 2025 00:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744417476; cv=fail; b=dD5rZwc1GLq42Ai7Lr1fIOPFkuXhzA+pNa5M6IHwKjW3+tcSKFx5e/Vd5Ko/RMci7Qn9FGhA9tEbXR9MhDI2R3YZrIk0MJFqWPzI9AFMR11aq/i8uu25XVIcF0BkTgbLHeWxAdUXrc/2FPC9gFpyMsyPE1sjq5pkzqRxfX1Kkpc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744417476; c=relaxed/simple;
	bh=8Lt+sW4Qc/qOm7OlKmZquSSUV4NTI04SmEQ2vvp1SHg=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=FvX+imFkdd1kmFTVe/I7ran+01D0WPmdi5cVBEidvOBNVuKkzM8dffCULLAOxtfGYeXtVaOLADzDlebQks4cuJMpJtrKUfSGHdeCLfqz4CiG/wgWIZcPZPkP40G8itDzkEaUgZDJnDxAyEQEguSkpPNASephEggQGLiun7ZQEc0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hVKWG5j4; arc=fail smtp.client-ip=40.107.94.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hVKWG5j4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eA8g2dcN3j0DlhCush5S0LvVHKWRRrVI0P6zEOwOoudyCPYxPLT05b9JfQo2tEr3ZhsFr8OFGdH4VRh19JQnELtEvyENJg/L7kzmo7tEZZhrK6khfXRo4sqC85DBVoWh9BeVV57578rvc4o7lsN0tQ/VO0NdsMpQ9OYVZBAotsUI+A9/kt/7nda8O4hGZkrPPeezMV//FGc/uFURm27Se9SSNAnxQP5kx4qjzRnzHejs55owL00yX0ENazPKYjuh1ZhH72bcoMWoLVp4NbQMswitXLpYu1VLCjF4It3QkTtVgncSwVvslsO4ABjm2eKExS1dApvLYyNN2S/CdXnutA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4CHuPHuO//10YS2UyTO7rYwaW+rQXd+Fu4OQIR5jkj8=;
 b=wEljSRd1CLqyVPNIv9wLkH6Q5+YtsVCxAiqZ5wgZmwJjOxpj8maQprEvhbBBNknkh+RIyUhfuJxYHx+rwqIeNueAcQtpblsfghW9DltABmgOJ1F46dHH1Pg96jMzVcJ9/P1QpR/VeITam11LqbJz2Vo/9F3OA02Da1DOFpx2262/WDwLUMCPLgxi4vygEqs1smZN1SKBjasykH+3MIPt5jHCzJMqvTwL1zACNjTqrEIxX+0DGDizwpMcNWpYsR2p4g8iq25Cni3ylbRsPLRV4e5fFZp6B8Ck9eNp78KfAGcNrvfJfcHlpOAfOomlhb58BJ19pYhZ8z/PjVdPv4IVwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4CHuPHuO//10YS2UyTO7rYwaW+rQXd+Fu4OQIR5jkj8=;
 b=hVKWG5j4/xk0pBuofAb1MRjkg+baWCciRQUWMu4kYnLDsCIb7h+468v2gffpduoI/YaMNxsKf9mghnrqJI+Z5Cl5uCJ8ktlJtXoVNBum93hzo3B11YAAzivRAJJU6tGNJV3/93U3TuMbh7jX9Io56FaPOCbcjQmVyHPj0ZD7ixkg+WKyt/4FbcbBDgsqRbM19F9ZpSUclFkqMkfMsk5kKJXTrb4V8aRJAn5ObKfqD1EQ3aR4wBFmijtExjNP9bTlu8f2+wXPN8HcryQ5ToRrD0Inn7A8HJDm1J2dL2RzqdAIyMXlhgN3g1jTHKFtjYUMzrCxyolo9PtgOnap42H8hQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH8SPRMB0035.namprd12.prod.outlook.com (2603:10b6:510:231::6)
 by CY8PR12MB7659.namprd12.prod.outlook.com (2603:10b6:930:9f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.32; Sat, 12 Apr
 2025 00:24:27 +0000
Received: from PH8SPRMB0035.namprd12.prod.outlook.com
 ([fe80::232b:2a40:c4e0:b4f0]) by PH8SPRMB0035.namprd12.prod.outlook.com
 ([fe80::232b:2a40:c4e0:b4f0%3]) with mapi id 15.20.8606.033; Sat, 12 Apr 2025
 00:24:27 +0000
From: Balbir Singh <balbirs@nvidia.com>
To: iommu@lists.linux.dev
Cc: linux-kernel@vger.kernel.org,
	Balbir Singh <balbirs@nvidia.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>,
	Jason Gunthorpe <jgg@ziepe.ca>
Subject: [PATCH] iommu/arm-smmu-v3: Fix pgsize_bit for sva domains
Date: Sat, 12 Apr 2025 10:23:54 +1000
Message-ID: <20250412002354.3071449-1-balbirs@nvidia.com>
X-Mailer: git-send-email 2.49.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR08CA0029.namprd08.prod.outlook.com
 (2603:10b6:a03:100::42) To PH8SPRMB0035.namprd12.prod.outlook.com
 (2603:10b6:510:231::6)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8SPRMB0035:EE_|CY8PR12MB7659:EE_
X-MS-Office365-Filtering-Correlation-Id: f2891e7f-9a73-4748-49ec-08dd795861fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KEQUe4uhbX8woK5KE8VZY+8v8qPa2zcstplnxH4KLBEnn5+OKYxJT6BlRy8A?=
 =?us-ascii?Q?lcyFS3DydE/4SE1125v06BNl+I7R+eUPIwoyaAo+sF3RoI+ins+FWeA/T7I0?=
 =?us-ascii?Q?PQuvVwJEzpoJoqmCvUrvnZZX7gflVZcOYr9g3PogP1kVdwXlexGtcsqNkOup?=
 =?us-ascii?Q?hNKAUXl2BRlyyp/0dR2BvhvVL8P/Fd5NISOKJy4Fx0+eN7mkzAMUaSfqO0F5?=
 =?us-ascii?Q?4cdyDy3KT8F9UYQKrudEYXGRyhAcnkXc0YiZQRGEnOvPbfqaTzXdpy8zDfmF?=
 =?us-ascii?Q?VG5IKC5m1dcXv1zfJu3qX/+PlFjCbTP/Zk1RK4RQvhok54uWOl8lu2bbjV73?=
 =?us-ascii?Q?HvB3LVii/XET8Nv5sCXhuRO4HN6UH1DN+XQfABlFBvp9LNehqmQDhtuLXPpF?=
 =?us-ascii?Q?OqaUv1p51OQeWLyTWonq9uGIq8U4BMhjCJxGgSPfmBh1T92J+am9GfR1aGH7?=
 =?us-ascii?Q?3s0C9vZGe9m/pXOKIfP3twISt/ue9+otTvio81UY4iL0sUchz1vTdwTYwpbB?=
 =?us-ascii?Q?mF/mwqJdHozbp9dDU3/Bkk1yXC954adWnRcJSAjum/8tOmeA6CVT2bmZ1iG/?=
 =?us-ascii?Q?2Sz9D1ZsBVo/qjMOwIIs+ghyRSSe9Ep6y/6+P3CVqvOZ4HTvR0giDj187Pyk?=
 =?us-ascii?Q?5zBUZ47svHZB4Jql5IscPal1fh0GR/D8sy0sVvQ/KddStz9Y7PMCMg0hFdsl?=
 =?us-ascii?Q?oA9ocaeZNvk0NHfaAjlc1zy2vh5VSdmG/cSU8x7lvQNnHUgWJfJPPUw4WAtI?=
 =?us-ascii?Q?Djjz5S+1Sl1f9wwAZLEg/d/OYkrfca4eceYzRAd649fZdTzLCIjzYdiD/l6l?=
 =?us-ascii?Q?TBq1NxF/pG6cHR/gsg1zjIx2iOtUk3swOeydNksmpqBajF9MshIDlZ0qj65K?=
 =?us-ascii?Q?1V7vKx/UW/C7A/4MvjhfSbeOuoXndvAV2anc8dTSf1dJ/oZkRS0sh57zZAyG?=
 =?us-ascii?Q?RNryKetdWMPbKfCTbMSOLE0z2hALhtRj2HhiZphHSVJlooyyHjB5c1oZCKbG?=
 =?us-ascii?Q?f4hixKN/am+sghyjjmG+ooLy9Cf/5FMDR6ZvEReVD/0Hium++mLoYcCiA/ff?=
 =?us-ascii?Q?cbxc8E//u2Q1zXn0eif5NTf1/bEnDPpKbofcySE0Pon30NySFs5x1CxjJUfU?=
 =?us-ascii?Q?HBZ+usoTl/ZPcvQx+yKH58PIrbAo60hg/zx2C7HvbN1Ih3//XuqLTxRu5CHF?=
 =?us-ascii?Q?nmA6RkotEAksVaQLwwILMMrGHDwpti9Qf+H66gCjq7XmANEaWcmedIN+8eCp?=
 =?us-ascii?Q?5/c5PaHp5Wk6cNZRQ6Dg/IVd3SXGVZdQWyTD/hgHRtO8u3QlTZ/8HyLM/z8Z?=
 =?us-ascii?Q?yy1sTgffgy97buMARdhs+phfcRmi41FJv47tcSy0Dwytm3E1A0ar8tm13tvk?=
 =?us-ascii?Q?FvQbAUuMtmqv8/+SvDnUttoLTuLqJoTN1yyVtHnmH/IyXMj4HqfBPfutPfMG?=
 =?us-ascii?Q?Cy/2S4fq9jc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8SPRMB0035.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3Fi2EgZGPKfjEHRXexYAuuT01IMBuorL7gs1dvl2sOVTAThO7qoC9gtz979w?=
 =?us-ascii?Q?aESXTDyznYZXLsUdF1HGbU4AqzGfDehLlbEZDypNUI9BCZqRcfFgBMq8cdBf?=
 =?us-ascii?Q?jhUw3WOyKT2YzpnB6iye7c3QC2o5jq9ypPI0T9OvC5TFx61R2F1sdoQRXmB5?=
 =?us-ascii?Q?5uBmsQDB1ZVWbIu6iAIkzy4ow56Vi3smT3SxByT6Q3kYq8yLHXB2/AF5307H?=
 =?us-ascii?Q?5UNobZGIH7TNszNHHejcFhl4mzjWObcyPTAtE+hR2vU/4hhrv9NJHzKrMWif?=
 =?us-ascii?Q?v2CraZUuw4q1tXGVj31zvgrHyGh4yvE6NmkSZYOmetdPjD43ApIFn11IYoKP?=
 =?us-ascii?Q?cnQC4cHH7SbQ44NyN+l/OJvpStFP/0N3+A3HzShM/zvT+CIe9dQJU7fIuHYk?=
 =?us-ascii?Q?p1lfOvhL9dTmXeNu6Vz/3LoFaYI+kYzKa0JxE0SpCErsT7eFEvyb5gTaGkGP?=
 =?us-ascii?Q?pejJQZ1NwLbzh2VxfRlWcA4LgfSFplinLzdbZDkER1JCMzRH/ZU3WOPvslAd?=
 =?us-ascii?Q?X49DuoGFa35Gl8WLs9YnfMeTUPXgfktNIoTfY10/kSF4RZ8PikCTnDnth5//?=
 =?us-ascii?Q?Xotjkjx3OHgi5l8ra3n4tzu14fJ7ycoVyZPqz1DUSKhJauDv6dujVfLqYS7f?=
 =?us-ascii?Q?B5/NGV+S1Bjl5H/FesAl4JqS6/XfkNjqNbRrrdX4vZ4qTZRfIM+nSvuYvZBv?=
 =?us-ascii?Q?upT+2FoUboZ/es9V+Tsxheqv0keHmXcQDyniLgtInuZRlhK/y3PQLMnLsjva?=
 =?us-ascii?Q?pdBGV/jmD7LpADBxvieLKHn9DVuFbrfhtKLdbyNw00+PuAChWBCmEbX95hzg?=
 =?us-ascii?Q?PNJ+H6eyp7YfBobCwnte6j0MSkwJ8GSq5i8ud8ANiWKBxu5q4YnmrmCN8C/L?=
 =?us-ascii?Q?FlrbOo4Mbe0AquZCwg55EwOB2s95vlxZAjUnl+PFSjMabnZcB+kfZAR0dKRN?=
 =?us-ascii?Q?Byn7vHebR0sGmtARusHTb9ZuDdGzR19b1qZGblbqYFdbtpVVj9QjUurPEH0+?=
 =?us-ascii?Q?YbQRvHdI1x0+EJ6cFmT9w8iLvz4IyZ6Pe2b0E8spCxyGRTUoJnh/WVYiUvtR?=
 =?us-ascii?Q?jr/YlfbrMj1od30zndnWmFOdQpOEbXvOKeEZ3el8iZ+6E2iCF6V2KmFT1J8q?=
 =?us-ascii?Q?DY+aKZxMhCurTec5AEwe0YmIc7Qkpjrx5cYoXdOVTgk1uH22DL84de4eLexC?=
 =?us-ascii?Q?gcfXTNqOTigWbp5IndLl37G30cVptpmaj/kXzlWSj6s9RtpPXZl82n5LBurF?=
 =?us-ascii?Q?8hpmSkmSR0S9c2zvDHHTBRv/CfBXNqjxchEoOhn71sMKDlJIMYZtY1mNFSoj?=
 =?us-ascii?Q?tMmmZutUVxD5cfP0ArSRYtmmkHqmEPX2SG1R+q5aXVSdRtA2yTJcdNOkFHmA?=
 =?us-ascii?Q?SLPjZKRYfVSbMeU/8GCLF04FyTC6ARPTd5Ag2BrL1o3P7d7aJkapFnm7yQZb?=
 =?us-ascii?Q?z2/IyorahdQb/79ykLOhjTx7OXT0oZBCApzghlgz0VhnRI0DJPVa0luIsMUf?=
 =?us-ascii?Q?s54GZ8Tb5iATbFtE5CN3PG7AhKhuw9Y6p/ZVuj2I6fKg3PSWFJk5mjE5vbDf?=
 =?us-ascii?Q?kxasBfuh9vtfjInvT5uH7d0PeStLzcY9uf07ZT/6?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2891e7f-9a73-4748-49ec-08dd795861fd
X-MS-Exchange-CrossTenant-AuthSource: PH8SPRMB0035.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2025 00:24:26.8329
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sqNiXpx+vjypTxZkSt50+mRNBUTm77Ao5hwQ+MWHGmdSBm4KUR0PlhPWa0ukutQvl6uyGrbShgJjgFD28qdb1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7659

UBSan caught a bug with IOMMU SVA domains, where the reported exponent
value in __arm_smmu_tlb_inv_range() was >= 64.
__arm_smmu_tlb_inv_range() uses the domain's pgsize_bitmap to compute
the number of pages to invalidate and the invalidation range. Currently
arm_smmu_sva_domain_alloc() does not setup the iommu domain's
pgsize_bitmap. This leads to __ffs() on the value returning 64 and that
leads to undefined behaviour w.r.t. shift operations

Fix this by initializing the iommu_domain's pgsize_bitmap to PAGE_SIZE.
Effectively the code needs to use the smallest page size for
invalidation

Fixes: eb6c97647be2 ("iommu/arm-smmu-v3: Avoid constructing invalid range commands")
Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Balbir Singh <balbirs@nvidia.com>

Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc: Will Deacon <will@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>

---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
index 9ba596430e7c..980cc6b33c43 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
@@ -411,6 +411,12 @@ struct iommu_domain *arm_smmu_sva_domain_alloc(struct device *dev,
 		return ERR_CAST(smmu_domain);
 	smmu_domain->domain.type = IOMMU_DOMAIN_SVA;
 	smmu_domain->domain.ops = &arm_smmu_sva_domain_ops;
+
+	/*
+	 * Choose page_size as the leaf page size for invalidation when
+	 * ARM_SMMU_FEAT_RANGE_INV is present
+	 */
+	smmu_domain->domain.pgsize_bitmap = PAGE_SIZE;
 	smmu_domain->smmu = smmu;
 
 	ret = xa_alloc(&arm_smmu_asid_xa, &asid, smmu_domain,
-- 
2.49.0

