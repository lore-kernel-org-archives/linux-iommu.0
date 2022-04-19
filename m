Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E9EAC433F5
	for <iommu@archiver.kernel.org>; Tue, 19 Apr 2022 21:02:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 32B2C40040;
	Tue, 19 Apr 2022 21:02:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nwIQEeUXLc1W; Tue, 19 Apr 2022 21:02:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id BD28C400DE;
	Tue, 19 Apr 2022 21:02:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 76F74C002F;
	Tue, 19 Apr 2022 21:02:10 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3399DC002C
 for <iommu@lists.linux-foundation.org>; Tue, 19 Apr 2022 21:02:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0718260F2B
 for <iommu@lists.linux-foundation.org>; Tue, 19 Apr 2022 21:02:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Ke5rgpW-Rh27 for <iommu@lists.linux-foundation.org>;
 Tue, 19 Apr 2022 21:02:05 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20615.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::615])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 07F2E60ACE
 for <iommu@lists.linux-foundation.org>; Tue, 19 Apr 2022 21:02:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dyA23AaC6StVRi/5W6auNvCuKiiB6s13wHp8BDQuNaQ7jt41fIbsx2I0PUoXMEqsLiTaxgFjA6Gn7X4IwHTxLmNQWmMGszIwVmeTiXnWUKSSf2LLHuAt8M2HQGAOHYu6miVBhgM7yD9rRIednVpukvGDCI3wUScbBfMGYxwhGB6FUv3tgstHMERZU34rk4lXfXAskcNhZXinkBMQU9CSTRGHTPT6JJQkYP2ASql2tqFGdWx8v0ASDuYunf0624iwc9DBbrTPAJeMHgMaE5Is3p0tuTddIO/73ncAkf4rMC/qBdt040tzdYzpB0Aj6d/5SVHauTo5OuL7MdnB/kgkaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fs4MrWJWy3dy4g0QhSGSOCy6H+hqFDc2/g74NufnRlA=;
 b=Y0cSxcMH2o1Bhya+Fp9M1LmZRnF7JSOVc3Y4r+a5Y8fSlEi9KwNYSE404SFAsbp0+qPxJa8zx1SPOhIOKecUmTRgMPvlOTuCzUpab/OJPJR8+ogYjoKU9Q+TP4yH+bKvtBoBt+ZTqWKmm+HBtGWFXn9b2xmQeWR+gxfjYR7Gz7N8C1o4e6RJcPj3bLAGfL8HsFuGBfuDq61oHH5Nl3hmE2LphBkCvpmLaPVOjhKLStaGixgGOqsuWw/1PnQHeUxep9XhQvcuT3Xwv0Y410eQWzavBmfxSEIihwaGPR+1VET5mmjs4PgXWZ1TPBD7BrAzNp7uqdVBE3z9e0Z4y+NAKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.235) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fs4MrWJWy3dy4g0QhSGSOCy6H+hqFDc2/g74NufnRlA=;
 b=LWMGjd8sjGww32jzEB/n0bUTGYZH+EKlpkAElhd4bapfUHkxrLlerWmFBcATs64kpLxEWiyO5ecbXkPLF01gZUiy2+aQgo4yLqCzAmJiRTCL3kxCqb7Qys5iwEvB4jNtbqHI1FQ0poXTRFfWSH4vt9w+CMhBlKPn9BrKc40tSpOBvjb02OIVaI4d8+HbLR8oQO2usnm8uEvwd97srMV28aSelQlJR854fZOjvJabTDMqFkAgaLj2PKaOx9AsCOzUcmnIgcmlNAOxb6sZmS/XHLl4i6IWfRbAzMgzty/m9nKM7hVljIIdvo/st9CIpv6IPzNdTVxENnEDZBMzJDecPw==
Received: from BN9PR03CA0609.namprd03.prod.outlook.com (2603:10b6:408:106::14)
 by DM6PR12MB3178.namprd12.prod.outlook.com (2603:10b6:5:18d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Tue, 19 Apr
 2022 21:02:02 +0000
Received: from BN8NAM11FT059.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:106:cafe::24) by BN9PR03CA0609.outlook.office365.com
 (2603:10b6:408:106::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13 via Frontend
 Transport; Tue, 19 Apr 2022 21:02:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.235)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.235 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.235; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.235) by
 BN8NAM11FT059.mail.protection.outlook.com (10.13.177.120) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5164.19 via Frontend Transport; Tue, 19 Apr 2022 21:02:02 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1497.32;
 Tue, 19 Apr 2022 21:02:01 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Tue, 19 Apr
 2022 14:02:00 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.986.22 via Frontend
 Transport; Tue, 19 Apr 2022 14:02:00 -0700
To: <jgg@ziepe.ca>, <will@kernel.org>, <robin.murphy@arm.com>,
 <joro@8bytes.org>, <jean-philippe@linaro.org>
Subject: [PATCH] iommu/arm-smmu-v3: Fix size calculation in
 arm_smmu_mm_invalidate_range()
Date: Tue, 19 Apr 2022 14:01:58 -0700
Message-ID: <20220419210158.21320-1-nicolinc@nvidia.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b47da6ab-d5c4-4eb4-73c4-08da2247da1f
X-MS-TrafficTypeDiagnostic: DM6PR12MB3178:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB3178590E1C44EF9A0BE76CDEABF29@DM6PR12MB3178.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Y2Rje5Gkj0JRq7fSsXy+oAop8ghaTHXKhXpSOlnUumNLhg1Li6WfZr9HkQoyPrdwLHhsvgw09s5JruDsoxZTG3n8efBiBDEmIF96kdBreOeeXRn+m3NgjZ1LKZXuI2wix3pXuNGNDAifnYdjrlaUCTjGHMIZyfIV7z6/gvYNQHOw7XK31HZDR1/9Xm/5Qek2ZjHcvPWbuVMW9Duu41VlSGYW3cW5wB9RxxrXPXWaZ/+hx32yspjgykSTz3dlI4uF4XjLlhDNof69gmAJEklGNCQLWQK3vWPjI6Nmk0Iez5BPN7dQQGj61ygkb7a+GC2n/r/Tr3TeR/nyJklBgWD0Oi/d8Vib8dYo3D3pLY5t+oeMEwS8WNXs00Rmr73bkmBK7BjphiIGGRS9nJOpm80eM+gIr61H37lAhkLsY8FSVsoy5zoI+hcjJB+EDlRfHzbfmhGzo35RlHLF5qPkVsiCq31aVJYwbsyyHakeBGTNpomvKjjmFAWy28Yhc4KC8r0myzPVOzm34VmGZrvv3nyK7jnJ22mqT+BnbEdpczytUpNbovlByQ2z/HnSXx1/u3Oz4Yb0tyE//H8hjy5OipFoX5fzkaXLcseqlR0X+saVr1Ol+uCT/JlucH+MwLcG3KYMEWtTzXJFYLs79tHFNqfBZqroks0G7rlEDgMLEJ70I0ffEcefDJnvwgmTR7yONxgeF1RBB3dtsnrExhzHTjS6X/ETHdCMCKaewwG3bCXp3Rk=
X-Forefront-Antispam-Report: CIP:12.22.5.235; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:InfoNoRecords; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(1076003)(70586007)(47076005)(186003)(86362001)(26005)(8676002)(426003)(2906002)(70206006)(81166007)(83380400001)(36860700001)(4326008)(82310400005)(8936002)(36756003)(2616005)(336012)(5660300002)(7416002)(508600001)(356005)(7696005)(54906003)(110136005)(316002)(40460700003)(36900700001)(2101003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2022 21:02:02.1988 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b47da6ab-d5c4-4eb4-73c4-08da2247da1f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[12.22.5.235];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT059.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3178
Cc: fenghua.yu@intel.com, linux-kernel@vger.kernel.org,
 rikard.falkeborn@gmail.com, iommu@lists.linux-foundation.org,
 stable@vger.kernel.org, linux-arm-kernel@lists.infradead.org
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
From: Nicolin Chen via iommu <iommu@lists.linux-foundation.org>
Reply-To: Nicolin Chen <nicolinc@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

The arm_smmu_mm_invalidate_range function is designed to be called
by mm core for Shared Virtual Addressing purpose between IOMMU and
CPU MMU. However, the ways of two subsystems defining their "end"
addresses are slightly different. IOMMU defines its "end" address
using the last address of an address range, while mm core defines
that using the following address of an address range:

	include/linux/mm_types.h:
		unsigned long vm_end;
		/* The first byte after our end address ...

This mismatch resulted in an incorrect calculation for size so it
failed to be page-size aligned. Further, it caused a dead loop at
"while (iova < end)" check in __arm_smmu_tlb_inv_range function.

This patch fixes the issue by doing the calculation correctly.

Fixes: 2f7e8c553e98d ("iommu/arm-smmu-v3: Hook up ATC invalidation to mm ops")
Cc: stable@vger.kernel.org
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
index 22ddd05bbdcd..c623dae1e115 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
@@ -183,7 +183,14 @@ static void arm_smmu_mm_invalidate_range(struct mmu_notifier *mn,
 {
 	struct arm_smmu_mmu_notifier *smmu_mn = mn_to_smmu(mn);
 	struct arm_smmu_domain *smmu_domain = smmu_mn->domain;
-	size_t size = end - start + 1;
+	size_t size;
+
+	/*
+	 * The mm_types defines vm_end as the first byte after the end address,
+	 * different from IOMMU subsystem using the last address of an address
+	 * range. So do a simple translation here by calculating size correctly.
+	 */
+	size = end - start;
 
 	if (!(smmu_domain->smmu->features & ARM_SMMU_FEAT_BTM))
 		arm_smmu_tlb_inv_range_asid(start, size, smmu_mn->cd->asid,
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
