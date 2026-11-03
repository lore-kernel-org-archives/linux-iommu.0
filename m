Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.195.1
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793729268;
	b=iQNEsKBvd5m8fQDupWTRz0yJMwba6YKf4NGM+HhBreLje4mPnLFUZ1a9R3G/EqKBARUT
	 89TUXbQ9M7luKCfXsoGLfESZg9ySkQ1viwsLqEHghGPzNBdaPUtN+fncDHyRyrlhxlkIa
	 bmH4b3smnhKPSbkVqmv1w7C7tJ9t1wFRbvahtomKuOAtMXTEq3K8pRsKREQFLgp2ea2kg
	 p881Wb30vK/pe/KlzQviQei2ecXLtDcqeVtPtbaF+SOQ6kFkajwd8nkkIjBz/acK1m/Za
	 64vQ9K1/eMIrUNyDsQFmkFMdCDlQtWKPsEMdkgvYEOuwfaapfehtCGfOsvfUIN2BAAQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793729268;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 Content-Type:X-NV-OnPremToCloud:X-EOPAttributedMessage:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=hVx0/7/aRV2wWgxne9iyKihDqTCLobnDw5FCxIHHqbI=;
	b=VDqMUWTMcRkvO4/T820LPCVzFtSsjQwV0cTbXYR4WxQ+PhlAuh14oyNvIqbesdlmwjmh
	 +kal7Gt5G9ooV4NRQ5lVGOWP0t0mFlw/BawKpx9wwIvrmuuvZyYvTDAz7/dTp1TVqSBuF
	 5yEmIpWPN71kOBPh1AcV0p9vjZU5r/0BJRzRhRH6u1maUpzykkgD9q7vUTLACWE2+DSlw
	 0t79D+qj4goql3GqMwDxUkSLe+312eiAthjWqIm9eZz9Q2Y60fP+THUFFY8tMsNafUvOs
	 tWDxb/ZRh1jgbYAq7BmjlxY0yjvU9FGW+eD1qhKDFnfV0/ZwbFsbknxtX5DixDFJiSQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Vr1zfwnc;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.195.1
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012001.outbound.protection.outlook.com [40.93.195.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC8CC606A337
	for <iommu@lists.linux.dev>; Tue,  3 Nov 2026 18:07:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AC8CC606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Vr1zfwnc
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tJMPJzTM6R8QAzdhM6J5+4oHZfbqqOd0Wdlkpz8sNkDmtPwUnHytPn0nSLFO7cRrKlVo27kh8QlJQuKZCfxnXJbn/pdF3bIDBoENZLxLToyAqYlprmbU5jNvLVSFmU9wqiruG4svG3JN/LRBQQYDM7t+7l/7P8u5by/RoOk/10SgC9ISlE0vagaGw7wrcxCz9owivPVJiPqhsGOPhGDIQOf37sQiOQ4GtxYpH6mrjcBfBj1K6gKXkQAiJCNylEfKyOTrF+5E4YEcl+gztmlA8pYNHePQEAZ8Zz0h7k27geO+GFVDkNC6JSMGux2crnkvsoc8MRlhtsi8hckbtsnq4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hVx0/7/aRV2wWgxne9iyKihDqTCLobnDw5FCxIHHqbI=;
 b=oOmdYYu3jdcPt8+xpq1I307hYy3vEfouhcTuxQ6liWRFZd/EK6sHN6fykhfJ166PiA8on8+QqH6pT5gT1dCpp329TiL/2PrkoXKfuusliVIR97y5DCvt6CsTIUl61z3bO93xP9YsGyLiwubnOqUvUZfP6DZI6Xh64/OhQYxRJGNEiRhj4KGFMd65/jbgJenBjg3YxnxUcsdTdGwed4QQPmDFnbPWPQpXpbVvMdWTed3T4RAYLsiGj9ZkHX9DW3V3FWCImNT4LIUIGID1Ys/So448r61q65M9x8lyY/3wKSuNka7Xrkp0+yci51/wiNdCSkSOJZvucLH36c9hfpIsAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=8bytes.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hVx0/7/aRV2wWgxne9iyKihDqTCLobnDw5FCxIHHqbI=;
 b=Vr1zfwncIwyngz7qi8SkIGH2vtuPQa0CjukRoo/Q2K7KxOo+B8ACPYPnufd59A3ms/SPuGytP3y27C3c2KTeCkPPTiJ8L0U+gZFvldVKdi8VmqDLNnhgQdxBXhuBabssQQfPMqiEibAA9g3oC8otFOX0Na4SE5ZQSp+s9xHapEKwAoGPO4gODhovpyeIOtal7ZAOE8N4g2WQV3Of0bDeBrM1O9+X3MIpyfVZYIbrvXvYzdzM1NyTxTSKaCIt7hyubkvNI/POIkEfrL2AQ8mtYsndNmjpvQjk/YPD6yOreyrcpJEwvl9X7tLH7EwTm+XOQT5pr0eatp4Q+szYq+t6uw==
Received: from SJ0P220CA0012.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:41b::24)
 by DS0PR12MB8365.namprd12.prod.outlook.com (2603:10b6:8:f8::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Tue, 3 Nov
 2026 18:07:42 +0000
Received: from CO1PEPF00018864.namprd03.prod.outlook.com
 (2603:10b6:a03:41b:cafe::d) by SJ0P220CA0012.outlook.office365.com
 (2603:10b6:a03:41b::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.8 via Frontend Transport; Tue, 3
 Nov 2026 18:07:41 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF00018864.mail.protection.outlook.com (10.167.249.152) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Tue, 3 Nov 2026 18:07:41 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Tue, 3 Nov
 2026 10:07:14 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Tue, 3 Nov
 2026 10:07:14 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.2562.56 via Frontend
 Transport; Tue, 3 Nov 2026 10:07:13 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: <joro@8bytes.org>, Lu Baolu <baolu.lu@linux.intel.com>, Kevin Tian
	<kevin.tian@intel.com>, Jason Gunthorpe <jgg@nvidia.com>
CC: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Jean-Philippe Brucker <jpb@kernel.org>, Yi Liu <yi.l.liu@intel.com>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 4/5] iommu: Unpublish the old attach handle before the PASID replace callback
Date: Tue, 3 Nov 2026 10:07:03 -0800
Message-ID: <33748eda55ccd91c32729d5d212b389742a6b1ec.1793729087.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1793729087.git.nicolinc@nvidia.com>
References: <cover.1793729087.git.nicolinc@nvidia.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00018864:EE_|DS0PR12MB8365:EE_
X-MS-Office365-Filtering-Correlation-Id: dcc8f7e1-a335-4e26-03d2-08df39d55a32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|376014|23010399003|1800799024|10067099003|18002099003|22082099003|261102123227099003|56012099006|261026121527099003|11063799006|261021121427099003|261022105027099003|261009223027099003|261021135927099003|261028144727099003|261022075727099003|261021123027099003|261026140227099003;
X-Microsoft-Antispam-Message-Info:
	Lj4ZqqGQ9p/TFNOh0ZP9w5Dbt73E4RY9ObvXIEUxrvw8G219g1WQ/K6le5xrtVBz/PUh8U+mv/wxmknmU0iqE2hCL8gmPzvCOZwEv9P4/KqeWqTcn5ra7Y0MjJXrHrctyu8lF22Sz/SqxI4ZgBrmJebtakkkX28i8/jhcYWWJtMG0IUoU9caeUTiAcsOaEs3TVgwbs4avLAYjE2kL4qRYPmZrUTeg6sEBdJp5/RbEEM01eutVzeLTTLqeybiBQkZbID9mFWur8TFB9yynCbg8CBHtQFPvplmSUI7QBxyoFJWy3nLsPbGVKC5U6OFlr673gsf9hL/jHC+pLrSKz/gOZ+TTlSO/pyTmN3wMMEmCvqVm4RmBpptfyOuty5CRuqhf1IOx3EtSg/lb1wY2upRQEbxQPUZA2HF0k2q+wLH/85vfGelSBPlP2KFhw3OO1nBMBrVtLljVCOA4kaTKm3yp2EcGghy2+vd/o2+bUoFON8oNPpkLHQUaOrCB9pAAhDi/LdO3SvB4Wkyvw3phqnxFlvm5Jwdy8hfMead58Jp/1bGm+/rjzc+Jo7MYMqqN+fNHCWUPKmpCnwDOqwTG52tEVWTDoJ60xOUQuXtgfGjopKFWVp4usJHks0g4wWFm+J98qpwWQPTVA0Ef0SPdwOMJHCo5SWeEwZCHdW/2De1LDlaF4o1iadX0ghB6NUYiJgixIiP7TXPjF0YtebfFw6BzQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(376014)(23010399003)(1800799024)(10067099003)(18002099003)(22082099003)(261102123227099003)(56012099006)(261026121527099003)(11063799006)(261021121427099003)(261022105027099003)(261009223027099003)(261021135927099003)(261028144727099003)(261022075727099003)(261021123027099003)(261026140227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	fu6JoEcVxq0KXbpZeYZ2o6G/l/aMd05sSzjkXXgREmoyraFFqMuX2pl0DNKWw4Z/E0R3Ow71fP6A1RS/lCE26M+JGeJ+rdrZgIAW/govIYjyQr53l7BRU25MPgwwQDEmr4Ql3259uC5436m2gHaqj2JiRbiLi73BxrvE+QnRGvfYrNA44vhLiSgwkp7MwPpdhBMXm2Mkzoijrtscc5RJGwyYRa07xRT8PBbi2rLYf6ydSlT5Xc+5jrl/X5cgS8vmZOhDcsSxCXIo4IS1hdkJJXZfp7NJQzGV2Hm2AOjD61K/zn089tXKK1sZLE2msr5fWVIur1DNCPsT2ued5ZoG9zAWBUPCtQh1O7HPj8mbHSnzrS4scyXvT7ueHEcazNmWqXDbMIBjYhMBwm5TU2Pq1J7JC7PtJnI0q4GzYydiO2/CGH5s0PnKj+RqBTp0L53D
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 18:07:41.3448
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dcc8f7e1-a335-4e26-03d2-08df39d55a32
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF00018864.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8365

Similar to iommu_replace_group_handle(), iommu_replace_device_pasid() has
the same inert reserve as the group path and the UAF window:

  core, holding group->mutex          fault path, no group->mutex
  ==========================          ===========================

  xa_cmpxchg()                    ,-- old handle stays published
    no-op, the slot is occupied   |
  __iommu_set_group_pasid()       |
    driver attach/detach ops      |
        iopf_queue_flush_dev()    |
                                  |   iommu_attach_handle_get()
                                  |     reads old_handle
  xa_store(new entry)             `-- window closes
  mutex_unlock()
  kfree(old_handle)  [caller]
                                  UAF: old_handle->domain->iopf_handler()

Store XA_ZERO_ENTRY outright, just as the group path now does.

Fixes: 8a9e1e773f60 ("iommu: Introduce a replace API for device pasid")
Cc: stable@vger.kernel.org
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Reviewed-by: Yi Liu <yi.l.liu@intel.com>
Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommu.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 0a199c1c3141e..3fea48d3538ad 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -3751,8 +3751,13 @@ int iommu_replace_device_pasid(struct iommu_domain *domain,
 	}
 
 	entry = iommu_make_pasid_array_entry(domain, handle);
-	curr = xa_cmpxchg(&group->pasid_array, pasid, NULL,
-			  XA_ZERO_ENTRY, GFP_KERNEL);
+	/*
+	 * iommu_attach_handle_get() runs without the group mutex, so unpublish
+	 * the old handle before the driver callback: a fault must not resolve
+	 * to either domain while the switch is in progress. This reserves the
+	 * slot too, so the store below cannot fail.
+	 */
+	curr = xa_store(&group->pasid_array, pasid, XA_ZERO_ENTRY, GFP_KERNEL);
 	if (xa_is_err(curr)) {
 		ret = xa_err(curr);
 		goto out_unlock;
@@ -3776,7 +3781,7 @@ int iommu_replace_device_pasid(struct iommu_domain *domain,
 	if (curr == entry) {
 		WARN_ON(1);
 		ret = -EINVAL;
-		goto out_unlock;
+		goto out_store;
 	}
 
 	curr_domain = pasid_array_entry_to_domain(curr);
@@ -3786,16 +3791,16 @@ int iommu_replace_device_pasid(struct iommu_domain *domain,
 		ret = __iommu_set_group_pasid(domain, group,
 					      pasid, curr_domain);
 		if (ret)
-			goto out_unlock;
+			entry = curr; /* restore the old handle */
 	}
 
+out_store:
 	/*
-	 * The above xa_cmpxchg() reserved the memory, and the
-	 * group->mutex is held, this cannot fail.
+	 * The xa_store() above reserved the memory, and the group->mutex
+	 * is held, this cannot fail.
 	 */
 	WARN_ON(xa_is_err(xa_store(&group->pasid_array,
 				   pasid, entry, GFP_KERNEL)));
-
 out_unlock:
 	mutex_unlock(&group->mutex);
 	return ret;
-- 
2.43.0

