Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010067.outbound.protection.outlook.com [52.101.46.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75F14409107
	for <iommu@lists.linux.dev>; Thu, 28 May 2026 19:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779997222; cv=fail; b=e6jtOnwP02RUPEVQXz1+hZgYDLTPE2CPcIxi1gPsSAY7YpcdUh5akeWJMTolf74XiYg+tLWTfqrBQDqk6x/Z+02mxAFYh3vcBQsd1W8W/YaYDsQQHD/bMhH6Mc6j+uRLWDwI64bKKoeJWq1U50a/fTFlXugeuQkgfbI6cJO6URU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779997222; c=relaxed/simple;
	bh=7YDd4hthFHNmNKCrgtmGk3P42UF7HGAWO/i7CXgrSTM=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sb2L4NxqM6YMwx2nwK4qlgQQyWjqRhZaoINrTUs5scuJ3hmdRWYGpK3CIYh6mYo0tQP+tDr5sA11TVzSsocBMBQBsd13HGTwAhK3C/ffqxQtj6rQE3jtj+aqtZK3NkU1ZcPzUO3m0VkrRN9RtQxPzRfM8yFJYI0y8BGSVXwA3aI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=t5sXV7mS; arc=fail smtp.client-ip=52.101.46.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="t5sXV7mS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b+mdL+wvFm+0Cybo5FceB5SrOFk0DPMHip8xZpufI+1ohhspJMT8reTv2+xWYhU+iDALurzIj/9hUgdn2pAIojBC4xj+ENtRf8ro3hZu1JXiwIsQFJh98kbAQXov6j2+0F8hT6cpqK3fh4SUJT8gQ0+HEw70EYiEfSTjS9OTwl3sfozOmZGr3u0hnc7ZJ/Jez+nYkUFI/mviM0ALtGyYfGshLTkmVPTQsmZDRvhnIEO3BlZYaADe62tOuvePRbL0r2WtIJXW3SLppoPh84s0wbwizbmXMVlPk9CeZpqIjkL00AKy6dHoAr2m9egipO+PU4ItQPgqM3OWYMgEd3r9cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3mtBMugCVyN1tObiuKGa7UFWb2rEK54nRyJbUVnqRrk=;
 b=bfXgx4rvZEhfo0yHErHvMiWEJxfttqe94t1RIUO/ChFoa2fyNlHyAkGZGmEM/I6c2V7pkMwvoYgHRBcRyStOjNr+8jkCTHq5jAoQJPKztCaXWXJ+qkmSjWZAdgvTSFk8TVLrh4FClhVAGePBTW2QZdGknM55gsBZ8255RPT/fOJnBKDmOVovWpkoGP4ZeM9OLurrrUAGSrKZE0tYzh9UlpLdBaFO7E+lLdQJzQluYOdrwgDyaqO56A4CwgfpglQdTP+G1YoJaPjz8WMnHbIE2Zyv8pRiYoXbSEHmGEOKzXHlgX6quEz4Pr18kzFYyO+KqZq0ChU1aCn/BfejOTR6SQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3mtBMugCVyN1tObiuKGa7UFWb2rEK54nRyJbUVnqRrk=;
 b=t5sXV7mSm4YuJhOzp2sgEPUQZdBlEUVPUM+tSKilJtypXQFBAFAgyX5L/uRzQP0hQIEduHIliCCm1qZZTtZuL3SKMF4AjVoSPW0Ht7tRmEPceJB7neQ0HO64StvHtB2qgEh37i3PAjMswPkWEi7+qdIFeB9I7i7hCJACsUecX4OghE6sLp9HiKxEKCRLs7wWmkq75nRUuZS4J8QZ/5vvKGu7hU4efMN6pm+O56VGqhNJjJCpUbtLMRJRkE+Pr0Oxwu+13gFYLbg1OZppDD/mbSz4oLOJdnEzPONS7QlkExZNqi2oB+wRH391Qr2WuFBaWdqJPx19TcQPCaTHGxx55A==
Received: from BY3PR03CA0012.namprd03.prod.outlook.com (2603:10b6:a03:39a::17)
 by PH7PR12MB9176.namprd12.prod.outlook.com (2603:10b6:510:2e9::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Thu, 28 May
 2026 19:40:14 +0000
Received: from MWH0EPF000C6187.namprd02.prod.outlook.com
 (2603:10b6:a03:39a:cafe::77) by BY3PR03CA0012.outlook.office365.com
 (2603:10b6:a03:39a::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.13 via Frontend Transport; Thu, 28
 May 2026 19:40:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MWH0EPF000C6187.mail.protection.outlook.com (10.167.249.119) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Thu, 28 May 2026 19:40:13 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 28 May
 2026 12:39:49 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 28 May
 2026 12:39:48 -0700
Received: from Asurada-Nvidia (10.127.8.13) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 28 May 2026 12:39:48 -0700
Date: Thu, 28 May 2026 12:39:46 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Pranjal Shrivastava <praan@google.com>
CC: <iommu@lists.linux.dev>, Will Deacon <will@kernel.org>, Joerg Roedel
	<joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe
	<jgg@ziepe.ca>, Mostafa Saleh <smostafa@google.com>, Daniel Mentz
	<danielmentz@google.com>, Ashish Mhetre <amhetre@nvidia.com>,
	<linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v7 08/11] iommu/arm-smmu-v3: Implement pm_runtime &
 system sleep ops
Message-ID: <ahiaApzK1/nBwr2R@Asurada-Nvidia>
References: <20260527221407.1756491-1-praan@google.com>
 <20260527221407.1756491-9-praan@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260527221407.1756491-9-praan@google.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000C6187:EE_|PH7PR12MB9176:EE_
X-MS-Office365-Filtering-Correlation-Id: 2cf89bd6-3ebd-4590-1fb2-08debcf0efb8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|82310400026|376014|4143699003|11063799006|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	p7XKzhl/y8Ef7VO10TqqSzEMtx9CtVK+WxTn1bIVXCYjQjKaq2Y6ANN4QtUrpSbILFsH26X/VDRuhaQ2VQo/qwq+S3UrJbFUtD/h5bnTWD1LpUxC1CfYSKH6+7gp6sIPutUX+Konh9LebANG+qagX0AKQFERrJjeqjpyXtvaNs3IWHgLlS0SPuCYSf7rajgBjG4Vc29FMv4I52mnac+MBmQQ4JnMrMDQXvqOGH+p0YWyBYvWLQgPR6s9DvY1/qpXB8/5DkNkX0jXhk/GCW7GFMIlzd97RIwW5sXFVMb1kXkF3gGRM4heWnk6uIBjB7gijzjkJsxXswLK76Xq2eH/2bpSweebUFJdIXcQd9xDtdorYOS+gmhC36adrHvz9tfh02huKZWNGhfyJVNILi0xPFk+wJFF/hi6cSWyg4Gm64fble2YsWUYAvGHjdA4Io4rlvrV2/A6vdD5u1WSXVBnIVvKU6OuAMA0Xu9hSgC02gNmF8+Cl/JIaXiZJ7ZfPoJHtFszYzWy0lLWfem2QxL3rTXQtK+krtCPeHQgYC5gLS7eWAfPKfvtmYqIJh76pMMztndazU5zenLQDryMf3wtzmZYGnQHY95VAzix+GoQC7qTBatn5LafzyhY+FJ16skwY/sJ/yyyjIipHvDhJBrIHdElzmTq9yoWVYfmwqKhf+0Fle/iNJu/kpomViHivrPphVP75rYhHgDCT2q7GNLblLTaMgmUucweG8ej0/N67oc=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(82310400026)(376014)(4143699003)(11063799006)(18002099003)(22082099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	dBFzWC5/kXKYTeA59ZxtXfqy/ayCexBUjbBBEoFxcUszFni8WgIM2nv0Ouexqzo7veFRn1xfo/DgPlRkYOgsrVbrK/jE6R7O2GHfwHKDYJQei/2RsGVI4rW4BF1aE4ljSWw3cg7yjkmy4QJ8/j3bzQHyilgVrojrpsZig2WhfJSS6h8+X3RCLkSppNJIwY3WQrJ+GNT++Ujg3b0Ny34LbQeDlTqT0ZC818gu1BaxovT44HHw6AW4oqkP29dTBzBjdwFJqybPt5MO3HrbOHULIyU2Nj7Ag+G7k+a/ZZwji9krRRPJaL6M5TnbSUEQVrsRQYiJSy4J4Zb2BikiwBzbhT6jQSuDXrj4dGZXyWkFnD0bmzo9AEAuFM4R1QeHJuyxfSWwBLDKF6cEwp4TUCPAKQyWy+xBtRN3pVCFr+ZlEVangLlk0s9wLgDLHKcBQDMB
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 19:40:13.2105
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cf89bd6-3ebd-4590-1fb2-08debcf0efb8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000C6187.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9176

On Wed, May 27, 2026 at 10:14:04PM +0000, Pranjal Shrivastava wrote:
> +/* Runtime PM helpers */
> +__maybe_unused static int arm_smmu_rpm_get(struct arm_smmu_device *smmu)
> +{
> +	int ret;
> +
> +	if (pm_runtime_enabled(smmu->dev)) {
> +		ret = pm_runtime_resume_and_get(smmu->dev);
> +		if (ret < 0) {
> +			dev_err(smmu->dev, "failed to resume device: %d\n", ret);
> +			return ret;
> +		}
> +	}
> +
> +	return 0;

Nit: ret is used within the first if.

Yet, I wouldn't like it to move. So, maybe do an early return:

	if (!pm_runtime_enabled(smmu->dev))
		return 0;

> +__maybe_unused static void arm_smmu_rpm_put(struct arm_smmu_device *smmu)
> +{
> +	int ret;
> +
> +	if (pm_runtime_enabled(smmu->dev)) {
> +		ret = pm_runtime_put_autosuspend(smmu->dev);
> +		if (ret < 0)
> +			dev_err(smmu->dev, "failed to suspend device: %d\n", ret);
> +	}
> +}

Ditto

> +
> +static inline u32 arm_smmu_cmdq_owner_prod_idx(struct arm_smmu_cmdq *cmdq)
> +{
> +	return atomic_read(&cmdq->owner_prod) & CMDQ_PROD_IDX_MASK;
> +}
> +
>  static void parse_driver_options(struct arm_smmu_device *smmu)
>  {
>  	int i = 0;
> @@ -789,7 +822,8 @@ int arm_smmu_cmdq_issue_cmdlist(struct arm_smmu_device *smmu,
>  		/* b. Stop gathering work by clearing the owned flag */
>  		prod = atomic_fetch_andnot_relaxed(CMDQ_PROD_OWNED_FLAG,
>  						   &cmdq->q.llq.atomic.prod);
> -		prod &= ~CMDQ_PROD_OWNED_FLAG;
> +		/* Strip all metadata flags */
> +		prod &= CMDQ_PROD_IDX_MASK;

Should its prior atomic_fetch_andnot_relaxed() call do something
about the CMDQ_PROD_STOP_FLAG as well?

> +/*
> + * Lockless pre-check to elide invalidations if SMMU is suspended.
> + * Races with concurrent suspend are benign: the cmpxchg loop in
> + * arm_smmu_cmdq_issue_cmdlist() acts as the true commit point.
> + * If we lose the race, that loop observes Q_STOP == 1 and safely
> + * drops the command. If we win, the suspend thread waits for us.
> + */
> +static inline bool arm_smmu_can_elide(struct arm_smmu_device *smmu)
> +{
> +	return !!Q_STOP(READ_ONCE(smmu->cmdq.q.llq.prod));
> +}

arm_smmu_cmdq_can_elide()

Should it handle a secondary_cmdq?

Nicolin
