Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013069.outbound.protection.outlook.com [40.93.201.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 503D6384CEE
	for <iommu@lists.linux.dev>; Wed,  7 Oct 2026 23:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791417366; cv=fail; b=dnrgGoU2DPoQQwBZn/bprDDs+0w1cE3pQ4nkUAsttM6G9DkQxvAJ14qehYBkLS/+AdbGmhe8Xn9P0jCR6VgsbHRGnvLqZor+KT4jfkLxXkOeaBlZU/JYvu5xnxdexwvzccfJ6Fm40r1BBUkIP5O7cORnhPaIEQzcxzy3HEvvFJ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791417366; c=relaxed/simple;
	bh=phlnh4noREAkhNDzWcWr3GjS0QCw0iZqEp3H8lQRH1E=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lwc8jesnEXKNsPat4AufDxGaCULr60/TTx/B055OqpUhfRV2P7OPWefczywsp1bOLZA0f22QUyDdljIStqCV3jK+986f8FxkdF7Np1WNfaKFEeLUN58+0J10dVXfQod1xR4dAAP54g1CeyJVoi8uyEIU48e7rapGwlb8IMmj/Tc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=k+QMJ/5z; arc=fail smtp.client-ip=40.93.201.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="k+QMJ/5z"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cMAiXJGDe37gNHganGJpHwyFaHh6RWj66p/L/6N41W/jw38PJW8jv/r7qaXM5OY3yLSfM3l1eJJMwdFcMqlGHBfPFRIJWdBL4D5O0k7057mumxXhF+2U+y5iWOdo4u9nXVtIQZ02GP8/lnWuJNkYMGWnmJxpZ80FfXB7VhfJhSTBpSRXBj6vbdABjwV/Q/685o2f/vUAZSv52AtXJM5RxLYEnFSrEd9CwG3wPLD5f/FvD6oVy6piziaYuCoAilS4AbwzahOmcTZqRXe8txdzc3fPW6FX4dpLHfig8HSO2tVrloJ1kuOHlhjdWpUwRXn9OWpFkeAjjiTxPjfrHfWWGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w5dyDI4MnqvkKg+OhKWMFhFTzM4fD8p/xguEzXihwSc=;
 b=lAlEZVVm9WQH10CUJi3k/sgXX6mEVZfvlrKCumDx3jaxAVxnK2wm5xB/Iwg1egSdv+V2PIViGqBNqud7+V631RDxqnCZXzTTuorDkSmCqBbA5y+IfGgiFCZDmDgRjUMCKMVjDofxws5zAuml23YmLcv4XpowtlE6QJxNPvO6FsvmNDSkkgApojgAAcfKiZvs8iOWXkAgEuPL79hDAmpuClO3n1X0t7jpKpyg5uR0Ra6AtjdyriRKjuInxqP0HFEt07+tG27mnBGFaO1JesKkZ8djtWTg8lFconniJvcqjmhWxoxthvD0vIlryBNS2UDp5vNqCdaxrxCRQUm/muF7aA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=oss.nxp.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w5dyDI4MnqvkKg+OhKWMFhFTzM4fD8p/xguEzXihwSc=;
 b=k+QMJ/5zKJ6CyEut3ZbUYd2p0lDiOzGV8rT61RocKF+LuHsD5AB07nFcX8AOZV7RFEG3t+BWsycrqB8N+K29jIJiQb2v+sKS1hcvLDT19F8VeCcjl2EAZRtoQMKtGb3PuWD5wHA6gtpPPSuIGfHoP7si/nBrFXQQLPtHow7l5FMM3fDSfGRhz4STSpdn1vylYGavoYdcn5J2HCsM+0vOqZOMotuXWR111P+3DsjCQLE1YtOWdrcNLymMYieywGbESD28G9u8alJpcfq4IvGQzsuh0XDKL1gllv+H79hSlagHCde79aJUglwc+nWs8xKRffa8yYCni/V0dMxM99Eg4Q==
Received: from CH2PR04CA0005.namprd04.prod.outlook.com (2603:10b6:610:52::15)
 by CY5PR12MB6624.namprd12.prod.outlook.com (2603:10b6:930:40::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.16; Wed, 7 Oct
 2026 23:55:59 +0000
Received: from CH2PEPF0000009E.namprd02.prod.outlook.com
 (2603:10b6:610:52:cafe::a8) by CH2PR04CA0005.outlook.office365.com
 (2603:10b6:610:52::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Wed, 7
 Oct 2026 23:55:59 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH2PEPF0000009E.mail.protection.outlook.com (10.167.244.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.14 via Frontend Transport; Wed, 7 Oct 2026 23:55:59 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 7 Oct
 2026 16:55:42 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 7 Oct
 2026 16:55:42 -0700
Received: from nvidia.com (10.127.8.9) by mail.nvidia.com (10.129.68.10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49 via Frontend
 Transport; Wed, 7 Oct 2026 16:55:40 -0700
Date: Wed, 7 Oct 2026 16:55:37 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
CC: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, "Joerg
 Roedel (AMD)" <joro@8bytes.org>, Jean-Philippe Brucker <jpb@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>, Thierry Reding <thierry.reding@kernel.org>,
	Krishna Reddy <vdumpa@nvidia.com>, Jonathan Hunter <jonathanh@nvidia.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>, Peng Fan
	<peng.fan@nxp.com>
Subject: Re: [PATCH RFC v5 3/6] iommu/arm-smmu-v3: Delay stream allocation to
 inside the mutex
Message-ID: <asbb+ffdovx+q6Rd@nvidia.com>
References: <20261006-smmu-shared-sid-v5-0-169a59c671d3@nxp.com>
 <20261006-smmu-shared-sid-v5-3-169a59c671d3@nxp.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20261006-smmu-shared-sid-v5-3-169a59c671d3@nxp.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009E:EE_|CY5PR12MB6624:EE_
X-MS-Office365-Filtering-Correlation-Id: 138d88ba-2e69-4ec3-d880-08df24ce8928
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|23010399003|1800799024|36860700016|22082099003|18002099003|4143699003|10067099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	IemfLYRC98xVGG+bW75Kt6zYQWq7QXx1IF4GbNJV/aWV/Nd5IdgFQjgK+vTDb5EiAaNPhJ/S1UhAEeD2IE1+o7h2M5aEDAW5fVfh0R8JNFFZnBNYvqAfjNSn0lyn2IZwHBfLIcQ7G1uYXJsFSPrNdelEx76czYm/Iqkz/N8HiQQdunqRq+oM3nSOBSBt/i/l2Yyro2ow7Wt4d6IJHsCJ/hXH/1lFdJnoBP1uiSTIeowPL6Sc1Km5e101QsE/X/9xZ8TO4UP7fJ5YIkRHgO0ZWuPtbhVDSsZw/qGExZlCnGQdN8oTZ2SfxLTbX2CI/f8Ub2A8bp9WsUNtTNDI77StM9Y51DikTM6UXuGKhn39tvwE13tQpwwc8qPRKBFzx6FXURjGDHp9ZB9qEpJhngMyB1lfism1AH6Pe5/t2t4NliIcoJSh/BwpNqwSbqvuH2k+veQUGY7RdsQvpLh/roG+ilp9CgtSY7PeJL4RGPTyIZ9YnzQQE/vFUPZ4JDrIiwc+CIDeA4CeC7JH1GDPqYW139aGhd/S+aAET2tlkmYJhHNJQOvO5iqiIaYOuPYM0nn4fJxfEwYP3rG6A9BnuKgfBeUu+ISuR2BG1mOnK6z0TVbuZ8kH77Sxn0Vnkewh1bQlgnm+ZxjL4doSmBac+KoO70oktffZTSjbwxAInqOvt5yAPHJzVxasSfogz+8Idh3YFXx/JdTWY+KHmRGxQdopvg==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(23010399003)(1800799024)(36860700016)(22082099003)(18002099003)(4143699003)(10067099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	UsVT06X4YM+gUvEPq+y5ZQ3a2g6WCnzerQC0+ezEUBwNQbbOUaorS+qa5LgiQNB7xwxqwzoPB8Yfbbvt4evfeG0hvIf9oQ7NjPymHlSlNLV7k7KMwrwHXyiWCG62H3IEHvoXzhgpFfKv3CEBueatJdEmy5Qq78ldZFY3vvCku5yV2EgkQEYfR3fUFzdL03i6P1d0fvES8IHSAYOe1tGOv1OFBU+C3pCe4vyatgmbFiq+a25iQkBeT1mbR4ylsJxuXOGHHlct1bxI5jxeShlmAxX7M8+BqrmLbd3zbh12dvL/qST9L6H4VMNSBuh0w220u28/dscY0qt7TBZAFMJl8VAm2Zu2x1MS8Xavxp3YS4taSwdYk2e3h77tpqAbBcKQ9O3pGMfZgfzeZ/Ys6QFkZiiuVugylmMYh0C6mzxhoDLsZOUHkGdUUfXiS6PsqRU5
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2026 23:55:59.1275
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 138d88ba-2e69-4ec3-d880-08df24ce8928
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000009E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6624

On Tue, Oct 06, 2026 at 08:19:09PM +0800, Peng Fan (OSS) wrote:
> @@ -4110,52 +4110,29 @@ static int arm_smmu_insert_master(struct arm_smmu_device *smmu,
[...]
> -		/* Insert into SID tree */
> -		existing = rb_find_add(&new_stream->node, &smmu->streams,
> -				       arm_smmu_streams_cmp_node);
> +		existing = rb_find(&sid, &smmu->streams,
> +				   arm_smmu_streams_cmp_key);
>  		if (existing) {
>  			struct arm_smmu_master *existing_master =
>  				rb_entry(existing, struct arm_smmu_stream, node)
>  					->master;
>  
>  			/* Bridged PCI devices may end up with duplicated IDs */
> -			if (existing_master == master)
> +			if (existing_master == master) {
> +				master->streams[i] = rb_entry(existing,
> +					struct arm_smmu_stream, node);

This can be cleaned a bit by moving the arm_smmu_find_stream()
from PATCH-4 to this patch.

>  	if (ret) {
> -		for (i--; i >= 0; i--)
> -			if (!RB_EMPTY_NODE(&master->streams[i]->node))
> -				rb_erase(&master->streams[i]->node,
> -					 &smmu->streams);
> +		for (i--; i >= 0; i--) {
> +			int j;
> +
> +			if (!master->streams[i])
> +				continue;
> +			/* Skip duplicated SID pointers already freed */
> +			for (j = 0; j < i; j++)
> +				if (master->streams[j] == master->streams[i])
> +					break;
> +			if (j < i)
> +				continue;
> +			rb_erase(&master->streams[i]->node, &smmu->streams);
> +			kfree(master->streams[i]);
> +		}

Add a helper to share with arm_smmu_remove_master():

static void arm_smmu_free_master_streams(struct arm_smmu_master *master)
{
	struct arm_smmu_device *smmu = master->smmu;
	int i;

	lockdep_assert_held(&smmu->streams_mutex);

	for (i = 0; i < master->num_streams; i++) {
		int j;

		if (!master->streams[i])
			continue;
		/* Skip duplicated SID pointers already freed */
		for (j = 0; j < i; j++)
			if (master->streams[j] == master->streams[i])
				break;
		if (j < i)
			continue;
		rb_erase(&master->streams[i]->node, &smmu->streams);
		kfree(master->streams[i]);
	}
}

Nicolin
