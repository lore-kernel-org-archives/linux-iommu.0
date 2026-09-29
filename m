Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011033.outbound.protection.outlook.com [52.101.52.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 857323BE632
	for <iommu@lists.linux.dev>; Tue, 29 Sep 2026 21:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790718765; cv=fail; b=rstFDgychwUO3zHYq7VJ+rhQjy/YZeD0UpmC9GGGqzO0AHA6ZnmdZTBaXhklxz90Y8cJXC+7OTqX2BwjknYkMzX+CZiHruQfhzEtPhw/b0Sx1WSsP2ldkLZM2hPhHQxcY8GAijqqUoS8oyiqdF4bGbNjnS75uLIuLHJwKyT8Z/g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790718765; c=relaxed/simple;
	bh=MgEzj1s8+MFg/lwZH8zKg5qkr8I1KyQR8w+97AyyZxA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iwes3ci8Y5Idsi4Kbkc1XP8Nhaoe/N1eo9ENGgf7d0fHhWjMFqJ9nkDRuUuMdNznB7z4oq6qYUjPavQ4ws7X3gsdaRX2pjWT0ABxCVIZwlWsFLCt4YdctNIha2cwqf4FLpdOg3b84d4yTGm5zk+qEqMtL6vSioV0rOtw8MVwqKk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=LEaVeObz; arc=fail smtp.client-ip=52.101.52.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LEaVeObz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gWpT7avhM73hACdG5zy65MgoD7XUIWfzOOLZr0hQ7hqP+JgHy1M9UD3mguSJzErjqe7A8R+Jj9B3WK+uJRKz8S1L6VmcyalrUTs+XWoZiUqgkEk7570v/x6mvXIqVUC+Oc7wzFb2uBlZBdiZL4HysYOiN257fA7hwWdIiABvHRjflu6HYLWQ76M9Coxb1yG2ToM35xjVo53PTpzRFWd2FmAj5h7GXiqFtod5uwdkYaEq9vA0cpsY65yqpSfMwKrKwiSJewCeqFh6UQ6z3DRJdJuWYgBVl079P1tKjZVaBqZd/fhNyz4InBG9DzfVwCyeJoysPpCcw5LLv/2+03AtNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rrw0E5dU0HbQOQhpdSkq8aGFdXbrWCTgYrn5kXWwXGc=;
 b=V3sTq0MkUDl9gmuq9SY+rJ5JG9IV8tlA4Ox9VdDM8N2FhxiB9JCOMG1UHH/0kUSlVa1uK4uLzJDrKssw5WN8FVc8zDdrZ72E4a8UDNjWBB3DsGW0EuFysIcOE7ptYuig7DOzA9iRhiYH7/dcXUV5o7u/WT3SCBtE/e9IM6tQ43ZoL53meR+1zAWN3gkCt7WlboF4tfJUkYm9ucQwXJ4sx+21ZYPxwqNj4rwHoE9on5MHonnD6vMYY0/8Ekb+ftqbkaov74xywgWy7uE80azOCePrGSezXzYuXnml3HTC4Qf/hLekZ/lQIFdrjvTn4H2n1McZWkXuZGbQOiw0nwC9sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=8bytes.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rrw0E5dU0HbQOQhpdSkq8aGFdXbrWCTgYrn5kXWwXGc=;
 b=LEaVeObzdNJHJHKIo4MXx42UXq8OkOuZJbXgCOxwQRris3Ek0y8MXTFNmOvKNxtCfvB21QQE4+TEYdjzgzQ7pLO7JLl01fM/N8EJ8bawQl5vUrztYk2HORfByquKK7QlQUU3NUIXZ5zOalp/zXVy4cJlF9Xda339cWq5sdbdtrF3hZXAhn5xUpXvyr+tVydZeeMBnriL00B3qkzrnlcBWLK7fsCl8QquYqsJEYO+fS8UgYUFVS+G2Ag+Tcu4vXPAy3isWB5N5s6Rr6y4tZkZR/b8Z7YlREfR4MiEPUyQf4nkmk71GfYJ8Hp4E7siLWLzWfYg12huElAZL2r885V7Bw==
Received: from BN9PR03CA0709.namprd03.prod.outlook.com (2603:10b6:408:ef::24)
 by LV8PR12MB9205.namprd12.prod.outlook.com (2603:10b6:408:191::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.26; Tue, 29 Sep
 2026 21:52:35 +0000
Received: from BN3PEPF00022BC5.namprd05.prod.outlook.com
 (2603:10b6:408:ef:cafe::8e) by BN9PR03CA0709.outlook.office365.com
 (2603:10b6:408:ef::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.24 via Frontend Transport; Tue,
 29 Sep 2026 21:52:35 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.118.233) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BN3PEPF00022BC5.mail.protection.outlook.com (10.167.248.217) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Tue, 29 Sep 2026 21:52:35 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 29 Sep
 2026 14:52:17 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 29 Sep 2026 14:52:16 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Tue, 29 Sep 2026 14:52:16 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <joro@8bytes.org>, Lu Baolu <baolu.lu@linux.intel.com>, Jason Gunthorpe
	<jgg@nvidia.com>
CC: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, "Kevin
 Tian" <kevin.tian@intel.com>, Jean-Philippe Brucker <jpb@kernel.org>, Yi Liu
	<yi.l.liu@intel.com>, <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v1 2/4] iommu: Unpublish the attach handle before the PASID detach callback
Date: Tue, 29 Sep 2026 14:51:52 -0700
Message-ID: <3d6731c5c3502380b4de3c90a1f6ba5547f0dd85.1790718296.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1790718296.git.nicolinc@nvidia.com>
References: <cover.1790718296.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF00022BC5:EE_|LV8PR12MB9205:EE_
X-MS-Office365-Filtering-Correlation-Id: e6b58379-976d-4c8c-09ae-08df1e73f8cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|36860700016|82310400026|1800799024|260925022911599003|260925021911599003|260925021311599003|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	oWeZ8pSoki+cDd3oycw9GirLyDQg8QAQ3r64Cz5iH3nnmvGJXDfxnrc6llL7vLnsgrb3aD0gg+joPHRl5GdXVGFG7fAx/gZi0LEBWvt84tuRFdwneCr9wbj1Ra8+4y86I7Zhqxh8AJUM8UrLTjyekGZn1fAIK1Ygc0xBSW/Jnb1ZGiHeIdgIR0tdAA5EVSx2CUoIeWsXDf9gYp5sWAsepAOKuBZ1GAq5dc0UiAekVEaNYKRWPP/S5eDre/So9h3TkkcHphshz8Nabukzt8R/qM/ee9rG2jfsCWxAS68z9yP3+qM9b9QB7egJeBIA/bmBhPMwjyQquAo9BTdwDj2NB7Gzdexb7rv6Cy+RhxwdCXKMeu6d0PZtLpPSiy3te6QQYQ/KqvYsYlvi63eWnxDwsDIKCeiajVFllEaXHP74U+olGgWPDrcMbaoHjMhG5ZjxcpLRgEnys+WS7ax6d9e9BbKPZ++KCoh6tIjk1SMSYIXiYIUjTUeZUM+/0qFkNH4mAv/y7ej3c1boQtvRp2awKa52O+MCOtV23Cocs/kFAFktlfc/n8oqOaVXAol7+B6PcxBQW3GG8j3HZVEY6lr6O9OcC5XzYbFwQ4AQ1ofTJwedX8TN/wEqL5gBYX0DMwo+Cw7bWDeSIZfR09x42iwswGeXbvOlP2Vq8SqZAryUqMS2f4WDsudslHkhkARoNPpK69IFM5oHd0xGMGghvcKBnA==
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(376014)(36860700016)(82310400026)(1800799024)(260925022911599003)(260925021911599003)(260925021311599003)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	qSpaPxuPUmvNYTyPZthkQC1iAA4Iogw0lmRwn95DaYEhb/rFdw31g9KFg5kcJmt+XK+bXQA+FE4K3Bn/dEgl0xzLss496Q3Lk6NY5z1RIJyJtfGpfWWVDhxPsBdzA9oc2U0Rx32u6aoPD6YfsxOevSXhvrNMze57zkhK0W8CC0kiBNocK3xalta4U9gnIWGrnYHT8SW3JHwktMm9ry98NmjE94UmMRSFqfq3Xe5IgHbS2xVN49EgjR2MnwKreqsaKXi+2Ow4HYhssnagcHEKS0w7mvNYOTL2iaZdybdJSKW/SC2Lrc5LZyLhq6YlLZiNrWnXJx8NZJ+UkufpWPixmyOiGxd6B+qLlpxJai9elHnQQ6A0b9IMG3dM+FgYZ2fur0M3arqlv4n1RD7zkx3WSKlvlxZdBkOeBie+mU6u4UeTknYUiDj/LViHzrUgZNQA
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2026 21:52:35.2541
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e6b58379-976d-4c8c-09ae-08df1e73f8cf
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF00022BC5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9205

iommu_detach_device_pasid() erases the group->pasid_array entry only once
__iommu_remove_group_pasid() has returned, so the detaching handle stays
visible to iommu_attach_handle_get() for the whole of that callback, and
the caller frees it as soon as the detach returns.

Erase the entry ahead of the callback, for the same reason the group path
does: a fault raised in the meantime must not resolve to a domain that is
on its way out.

Fixes: 16603704559c ("iommu: Add attach/detach_dev_pasid iommu interfaces")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommu.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index a062a84686c29..19b880d23314b 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -3818,8 +3818,12 @@ void iommu_detach_device_pasid(struct iommu_domain *domain, struct device *dev,
 	struct iommu_group *group = dev->iommu_group;
 
 	mutex_lock(&group->mutex);
-	__iommu_remove_group_pasid(group, pasid, domain);
+	/*
+	 * Unpublish the handle first, so it would not resolve to the detaching
+	 * domain once the driver is detaching it.
+	 */
 	xa_erase(&group->pasid_array, pasid);
+	__iommu_remove_group_pasid(group, pasid, domain);
 	mutex_unlock(&group->mutex);
 }
 EXPORT_SYMBOL_GPL(iommu_detach_device_pasid);
-- 
2.43.0

