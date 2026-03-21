Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011036.outbound.protection.outlook.com [40.93.194.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DAF32EE262
	for <iommu@lists.linux.dev>; Sat, 21 Mar 2026 22:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774133496; cv=fail; b=ineaLZthlAC8SFPJ8c244ucd13VUsqCXwCIM0QIcd8jmnZNuf4NPtFT7TXGLccmSaglnwiIUqIoI7lHwT7serSBmZAUI8BWZtApkgepgPM6D5fSe+8DOrMVWgRneKKQA0I5kU4HfT22PgyeCxcuEUxuWHWuZe/yIFVXcqQQ7q68=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774133496; c=relaxed/simple;
	bh=MqSmoBiGzHvGlc2sV2JxtOeIMxFK7MfDjwJpAJj9vSI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KPf8Dm7uJy/FQq6x+7PLWdk0qFH9pwDBmyMhItj1ROXFUg4Kj82Jc7Ll0CwCyk9A7Cecdmv2W6vvkqNdf6mFllqFbylQiHj+3jA0fUURiGzYr/i1F0G+QhZyC1ONUX6ilQdqh09SeyQAd6BT+nT2YVnunKJnM3/23p8cTKNsFdQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KqwpKZU8; arc=fail smtp.client-ip=40.93.194.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KqwpKZU8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XT8UB6GXLGJhT6aeRkU/ORsAwf5y6z04nJiIv9zMQpiILmqFDXZ1yfjDps8Jby7hGSBCRGTnXbwfSQv5L3o/BLwH6wYb+XCjniv4yOpH/d1GcjZMeUwCuW57PxrxiwTLRJX9K5bF2mmmmpM9n2Zi5y7X3FaXuxpCDjnLn0AEEPUg/og1u5Yv1l0hj1O3WgaFT/BOzAP0rr1/tDNH4514UwoJGu9WqspygzEyQhLOQlYftZmAc9DWPkU22WeDl9YmPqBEceeHZOvU4dxZjxLPzEpk9tJA/VJfkaT08w47ShAzLw26IPHQN/DXzGNMqNWk9caHmWL3WV9cjVb1nigZ9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9XlwQVvn7qQpwN+ZxjyfM/MbeNStnrUI8Ik6lYGGIj4=;
 b=eAGaDFCwMbAnF1IGH6sGbu3tYHa+jWBACsDv/lmUf2EARpI8KnC53d/IrbYF7CgNqxGzmCsM/7HPQIEyoiTU5VbujHvqFYUHhTiIqLjTnP+jyS7yhpnCDU2qpFYb4he9/YAp5M1/RDb28vjjnBsqUrB5vViPOJtaKLuCJmNLc0xkeiGb4d0VuEjoxlIWHLlwi+eVtbz2+TW+0UIkFjQRwD2knu5E0XMbWlToBgLENrL0CDPRCeezI8MtNJ9TZGCYYrADwOftBrxFlNzFrb0BNDrJNU5GfihkdpnjjxyuKLNfjqoUeuKTMIjjcfuQDSNtd7vqpSsv7pC1pZ14OrFEhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9XlwQVvn7qQpwN+ZxjyfM/MbeNStnrUI8Ik6lYGGIj4=;
 b=KqwpKZU83xt5a4rhrszvCGQrsKrtW9FWVwldjoqOO+75UIY7gz8PPI2CDJXsKkKep01oVZtgvPj+93PNyaOKvz5YDGrNTplRc+2i9AUYyoi4wsOMvrXEObDgyz6teWM3MbwRvGcKonGC5byZkNXT9CSue0NhGy0iaEyo43wUKO+lOvvzQfgbSe34I2lVDO3mGEt/dlbWZANMOGSR0A6otbYZOR0KvADtOHPtD2e7EPLULw4vIr+Kj5E/mZKqFDve8RTlUHMSt/k9ZGnj++ApFZ9zgnn5orGwU9QMrLU8K2bL3eiUSlJeZMDvKMsgWlxANc8ncDtpl03IhPE7bcwFVA==
Received: from DS7PR03CA0107.namprd03.prod.outlook.com (2603:10b6:5:3b7::22)
 by IA0PR12MB7675.namprd12.prod.outlook.com (2603:10b6:208:433::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.15; Sat, 21 Mar
 2026 22:51:31 +0000
Received: from DS1PEPF00017099.namprd05.prod.outlook.com
 (2603:10b6:5:3b7:cafe::27) by DS7PR03CA0107.outlook.office365.com
 (2603:10b6:5:3b7::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.25 via Frontend Transport; Sat,
 21 Mar 2026 22:51:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 DS1PEPF00017099.mail.protection.outlook.com (10.167.18.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Sat, 21 Mar 2026 22:51:30 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sat, 21 Mar
 2026 15:51:28 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Sat, 21 Mar 2026 15:51:28 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Sat, 21 Mar 2026 15:51:27 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>
CC: <robin.murphy@arm.com>, <joro@8bytes.org>, <jgg@nvidia.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH 2/2] iommu/arm-smmu-v3: Fix typos introduced by arm_smmu_invs
Date: Sat, 21 Mar 2026 15:50:41 -0700
Message-ID: <20260321225041.11090-3-nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260321225041.11090-1-nicolinc@nvidia.com>
References: <20260321225041.11090-1-nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017099:EE_|IA0PR12MB7675:EE_
X-MS-Office365-Filtering-Correlation-Id: 10b079cd-6616-46a9-3389-08de879c64c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|376014|1800799024|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	qaL0FkysW02J9F8YNGQ54cbRdM9rg9mBNXZH+6SvypP+Y2aurnlEUjKTLb3GzOdcGclT0pANuzsODoY1MXxGVY5rqH43FLydLVmk3PeXiFHO3FuTCGbMXhJoYXw3+zZGAjepPI45h+bGpRrX600h3gx7VIwaNt4hZ0BLHeXk36C6tmJwAhgGOVwhMDGt7G+7X/wtyQMGQtSW2ShSihqHJNTOydW332ojEhjlngqty0eG5F1HwPsg5Jyn9uz6RwXaBTvUOOUD2UT5qw0a0JhhDtsKMhoN1X0POd0x1XHt1brFjfOmBzqraSKzSrKyNDRCITVu9Yf5f/ivZVaJzYhejdBXrdkf3E7M7ZExRef++oRnmGfFtOta3mNgA5zYvg/kCE1CBPQ2mkuKvY0i0Gdzjx5sLI6rKhvHkHFTGUam+7VvaUED/+oLTpkq+nBYPY0ppMrcOjrp3Xzu36QFoJAuMtN874lmGAamibzZiC76wcadqddqHlMefFwz155gIZQHZhk9R2oA/6Gi9Bb+Z3GyW0LaA4A2yI6EONCVCvCsXh21w9t9lZx2c+Y9uDBf7wxAUuUraBM4/OJXT0LsH0w2/tzUVI581xkZsuPZT52lAGnH0fYqjoCupOqkG3GjfirxTI7p8bfJ0GbNBOQf/gDy7tBJ6SaPFwhPyhShG8gVtY+F8FVmrVAk8CiYGqwJxHRTN7nurJjncRgMZHqq8ay9rCG+FscgF1iIbwmRLEH6X75/PAfkgWw41++diEcoWMNWIdjur2yK4DzFYix4eXDm2g==
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	kwFJia54B7wRVlezUUwP91x/ZOeu5iJqlr8SzktsiQHtJHk8ve1zXbSgWDqKgGTXj1/pyqkmWLDgI6F7D3Cw+xcYoQTXkeJgv6SYxZ+t/Op++TpIBfEfmZkVU5XZgKXar9cnivUV1PPm1tZfFcxbDFK2+PHEymxjj2jdSXnr3p/k0zWqb7vahPgcJpe9yTxoCtGJMiwFb4WSk1tOZ0nHrIvhse4FhCxXyCkBMNRmIzkGzNOde90ZeN4eEyPX9iA81APpLCym7lAdq7s5jjIXPsmXo3H+e0wXzzvUsjWZv7qUQyByKvPiy7KLc4TqidVLFATYWkUKWI80JXji3sU/kiJfl/veCm9o8fqj9yYmmuRYoongv/8d7uCH5eBXnHx0uEgRdXtGXA9X+xFrUPhnvF5IJG6LbYR3bOrCfh89IE68OrNNAa6U+xF0rCzYoIyj
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2026 22:51:30.6997
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 10b079cd-6616-46a9-3389-08de879c64c5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017099.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7675

These are introduced by separate commits, so not submitting with a "Fixes"
line, since they aren't critical.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 6 +++---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index c3c6987da9506..b841efbcc9e9b 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -1128,7 +1128,7 @@ static inline int arm_smmu_invs_iter_next_cmp(struct arm_smmu_invs *invs_l,
  * Both @invs and @to_merge must be sorted, to ensure the returned array will be
  * sorted as well.
  *
- * Caller is resposible for freeing the @invs and the returned new one.
+ * Caller is responsible for freeing the @invs and the returned new one.
  *
  * Entries marked as trash will be purged in the returned array.
  */
@@ -1258,7 +1258,7 @@ EXPORT_SYMBOL_IF_KUNIT(arm_smmu_invs_unref);
  * This function must be locked and serialized with arm_smmu_invs_merge() and
  * arm_smmu_invs_unref(), but do not lockdep on any lock for KUNIT test.
  *
- * Caller is resposible for freeing the @invs and the returned new one.
+ * Caller is responsible for freeing the @invs and the returned new one.
  */
 VISIBLE_IF_KUNIT
 struct arm_smmu_invs *arm_smmu_invs_purge(struct arm_smmu_invs *invs)
@@ -2739,7 +2739,7 @@ void arm_smmu_domain_inv_range(struct arm_smmu_domain *smmu_domain,
 	 * But in a race, these two can be interdependent, making it a special
 	 * case requiring an additional smp_mb() for the write->read ordering.
 	 * Pairing with the dma_wmb() in arm_smmu_install_ste_for_dev(), this
-	 * makes sure that IOPTE update prior to this point is visable to SMMU
+	 * makes sure that IOPTE update prior to this point is visible to SMMU
 	 * hardware before we load the updated invalidation array.
 	 *
 	 *  [CPU0]                        | [CPU1]
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 36de2b0b2ebe6..ef42df4753ec4 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -687,7 +687,7 @@ static inline bool arm_smmu_inv_is_ats(const struct arm_smmu_inv *inv)
  *            greater than @max_invs
  * @num_trashes: number of trash entries in the array for arm_smmu_invs_purge().
  *               Must not be greater than @num_invs
- * @rwlock: optional rwlock to fench ATS operations
+ * @rwlock: optional rwlock to fence ATS operations
  * @has_ats: flag if the array contains an INV_TYPE_ATS or INV_TYPE_ATS_FULL
  * @rcu: rcu head for kfree_rcu()
  * @inv: flexible invalidation array
-- 
2.43.0

