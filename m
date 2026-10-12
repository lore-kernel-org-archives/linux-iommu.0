Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010036.outbound.protection.outlook.com [52.101.46.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB2AF39EF35
	for <iommu@lists.linux.dev>; Mon, 12 Oct 2026 20:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791838154; cv=fail; b=rTu8dckjYRvgY2mXrwiXsplatWLpCM3sjwyVlWJ8cWOqQ553zEUKpPaH2OALB2VjrDsYJPlUhksTU8c3chrVXUSy8FL1rE6XBnO2dNn67E6VgCec55DQ/AZNiG33K/rwhpzW2eNJLCzso+8pkHIPUMWVI+Rxc17juEZr+jR9vHI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791838154; c=relaxed/simple;
	bh=MinIUeH8gYib2agR658ZUbrZuFxOXA/CXs/1J79/lJ0=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pIbaVl/A1nxkHdxhiEIfzuGru2XjxxmfIExSeVldL/EwiM+SXXXLn2oRT/JIluADTW/BbkHIS4lKlhOUbkAUJwgpp4s/H5/Ob/n6HxVe2LIs1PzspAF6Wv/tPvsEKzla4eit0sXnFR9hCx9JOt+brVIFREzvvAhsVdCS2eEw34E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Esh1slEW; arc=fail smtp.client-ip=52.101.46.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Esh1slEW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e+ZWDHfQLC+OuKkHiPzl+ufSp8E3AgMJzfPZD60VQXMyPvV+lQHx0HstZtv+MPk6LFaKCovlfNxagzb6GjTtOFQfLty9DWCzEC8jyx1oarjEHfCvcUiZYZV8wv7VYsrPtMhigP+lQI85MdecCG/AvJLN7Vn7Wby6AvJcmMxYL+Q6j2++dTSHc8aQAGZcsUv287kiuaXKe3KfSRCstWBOsB9F7O+jStosuTkVNPPFD/WvMoY803IDEOhUMePPVqasMvKxf9ZDEuKY5Imazd5lT4fdZFXI3J5n5inxmlmIOOm45Nfe3euzCbO/EBlHEmQUf2AJi3W7oScbqL68ODZgmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cvf3N1QhN73wg42zXoX/lqMSJhRNvXVhFYSh/86iFLY=;
 b=GW9xv89FV669RQYlRBHneToFbZAo/76VB0K+xnhdZVHPMssI1oqRRdWdxZJtaNBJoXRK6K+OijTCDAC4FQmBpYl7UMwbJUyR/vuxmr7rYQuBxs+QXRZgmxBdT+YHiL0ckf8J80KFK7hAACE0iux6b7x6mBwms1BMDZDxXDKeA2PWWUqKPslMdxLpO+7TvfCb2a2QDkgu3QQP6jnxFuqSm4+FEE4ocbA7h6gr9jPPPsgWzJmxnPCjVXn6K8COBzWIraYJECSk03fIcsBKmmXpLcM18igML//7ebT6CbdeaIPXi8oQpn5frjqelAnzlAFQQlJoklTzo6u/mKVdXpsnZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=oss.nxp.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cvf3N1QhN73wg42zXoX/lqMSJhRNvXVhFYSh/86iFLY=;
 b=Esh1slEWrkvuStLlYFZwOPXK4vIks2Fh6fUOtd/07pknWi4k7bjxuWOAmQKvyN3d6RqtGP5zkSjjghjWu5lFfwHa+oC3ptmVp9SXbZ6vvr0xNB/yzzSmZQd+mMNF58pElPDylo0JtDEqA7Ym8+gBGvKAfN2Xzhkevo6dcmtxrV5IrlzNpjvYjfj5m0Ik4H2145oPf18meplrmXO4IgM3G1VAy3YE2tFjNaCyra1MzQBsOg7gR1Puxs3ryM7IOYCMninWVA2hbhVhey1G0tr1LQZo1sbE1UdjwzB+7ExTfUjLP3ZrHR7026/1Ofx9CqUanV885u5Pflnp8+7AQdiFog==
Received: from BY5PR04CA0030.namprd04.prod.outlook.com (2603:10b6:a03:1d0::40)
 by LV0PR12MB243158.namprd12.prod.outlook.com (2603:10b6:408:3fc::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Mon, 12 Oct
 2026 20:49:07 +0000
Received: from SJ5PEPF000001D6.namprd05.prod.outlook.com
 (2603:10b6:a03:1d0:cafe::7a) by BY5PR04CA0030.outlook.office365.com
 (2603:10b6:a03:1d0::40) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Mon, 12
 Oct 2026 20:49:07 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ5PEPF000001D6.mail.protection.outlook.com (10.167.242.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Mon, 12 Oct 2026 20:49:06 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 12 Oct
 2026 13:48:46 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 12 Oct
 2026 13:48:46 -0700
Received: from nvidia.com (10.127.8.9) by mail.nvidia.com (10.129.68.7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49 via Frontend
 Transport; Mon, 12 Oct 2026 13:48:44 -0700
Date: Mon, 12 Oct 2026 13:48:43 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
CC: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, "Joerg
 Roedel (AMD)" <joro@8bytes.org>, Jean-Philippe Brucker <jpb@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>, Thierry Reding <thierry.reding@kernel.org>,
	Krishna Reddy <vdumpa@nvidia.com>, Jonathan Hunter <jonathanh@nvidia.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>, Peng Fan
	<peng.fan@nxp.com>
Subject: Re: [PATCH RFC v6 3/5] iommu/arm-smmu-v3: Support shared SIDs in
 insert/remove_master
Message-ID: <as1Hq8FD3S67MpoE@nvidia.com>
References: <20261011-smmu-shared-sid-v6-0-cb76b89dc612@nxp.com>
 <20261011-smmu-shared-sid-v6-3-cb76b89dc612@nxp.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20261011-smmu-shared-sid-v6-3-cb76b89dc612@nxp.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D6:EE_|LV0PR12MB243158:EE_
X-MS-Office365-Filtering-Correlation-Id: 0307bcf9-299d-4a6a-9148-08df28a2423d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|36860700016|1800799024|23010399003|10067099003|18002099003|22082099003|11063799006|4143699003|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	f6hi5V6UzIuwvRWZuJkanPQaGlL8H6EVPHkveCJKl4PhBd4C+rgjUC4kyPEIlnWNP8fcEcfTqefBuLxpYXnW9HJyUETNq6o2FvFo3zHdAAxsks0YLgORem8b3EleCNcRM5wBMLsevr+QvnKUhc9LbZhZAP0nPlH1LmDC2ViwwQAau8mQc5dbUqt3jeaVBGIbDcZbca9H9O8hP+T4VJ2we4Grz18yIMxGljYTMASBts2oUD3KqjBB/2nX31DoWg+a0OjcSf83cs+6W6N2T0ENhsdfjckvddGU6wA+Qy+oM7edUv0XHpUkdkhB/zsTcDvtBegRuux5ikeCV02bCnBQXoFX8k69ryIG2l18QcWXymMmB50ulZL1LzNXmGuIlp0JM9i2rNQ2Z/zTwxJN98uTtrip3WjpGzW0UgHh0xO6+pXtFpkFDigQteIZRC28GNhNXqyqXGjIANZRf8IebQgoZght7RCg0FHuOO66vkZm962rc0N9apqN7Tz/EqG/rGGCMg4nWtG8UZe8IapvwPbbDbKVQD6wBzOSVOTj9JTVsoUk0sAetaP1sjcGG+b3sYNvpQQIdsbBKJO00obtREnLskYRtvhBTUcnSwkIh6cuMEvDoWM8Rll5qqT5eJhOKydrAKcedAo7Lvv+AnC7Xxy/0QZPI/qnSaVOFdEPvr3hkxpGYZBnOU98jzzmM+Ekz1QQamzeaJrqGmRomeFCZOdfcQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(36860700016)(1800799024)(23010399003)(10067099003)(18002099003)(22082099003)(11063799006)(4143699003)(261009223027099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	FYxsI8m//7/25IfY5QFafWAidQsXY1FBvK7MHNo0YTnZwR03/yafEkH9tHMy9z0qZ0O9cWEZddVPjXYEeuF/abURY0L4M9DKRMOJ0kF0F7WGNfREXP/cVTuGreyh69m8mjUyMwJNvgPZnw+2diib7dESmvo7ErUGQXtL0JDkWA41lQ2WRSXVoReVqgYIjlhEJU/7i0MXJUqjpM5cHT8+gXPYYz9ZJO9S7ZRFUr311I3JP7nSadCCGxrTWpSGKueVuajufFkZAxGM66uooraE5cu8BtRTLEuFIrUajleDo/QH9UPPGbg9WyGBHeTeUWRh5eYMHKAD4HFhfzrAqZtHdixl6a5QnyoaTq+h04h4yyiKF9P0dFIqphgGP9g2lFZ5ZUro/oJ9O7Tdah77cLeDldZVgpeAqXYBdzvB+TymigVbG1gfAauey2WEjiFV2TG2
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2026 20:49:06.9774
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0307bcf9-299d-4a6a-9148-08df28a2423d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV0PR12MB243158

On Sun, Oct 11, 2026 at 07:31:27PM +0800, Peng Fan (OSS) wrote:
>  static void arm_smmu_remove_master(struct arm_smmu_master *master)
>  {
> +	int i;
>  	struct arm_smmu_device *smmu = master->smmu;
>  
>  	if (!smmu || !master->streams)
>  		return;
>  
>  	mutex_lock(&smmu->streams_mutex);
> -	arm_smmu_free_master_streams(master);
> +	for (i = 0; i < master->num_streams; i++) {
> +		struct arm_smmu_stream *stream = master->streams[i];
> +
> +		if (!list_empty(&stream->shared_masters)) {
> +			struct arm_smmu_master *next;
> +
> +			list_del_init(&master->shared_masters_elm);
> +			next = list_first_entry(&stream->shared_masters,
> +						struct arm_smmu_master,
> +						shared_masters_elm);
> +			if (stream->master == master)
> +				stream->master = next;
> +			if (list_is_singular(&stream->shared_masters))
> +				list_del_init(&next->shared_masters_elm);
> +			continue;
> +		}
> +		rb_erase(&stream->node, &smmu->streams);
> +		kfree(stream);
> +	}

Rather than removing arm_smmu_free_master_streams(), just fold all
of these into arm_smmu_free_master_streams(). The rollback path in
arm_smmu_insert_master() can still use the same helper:

arm_smmu_insert_master:
	[...]
	if (ret) {
		arm_smmu_free_master_streams(master);
		mutex_unlock(&smmu->streams_mutex);
		kfree(master->streams);
		[...]

arm_smmu_remove_master:
	[...]
	mutex_lock(&smmu->streams_mutex);
	arm_smmu_free_master_streams(master);
	mutex_unlock(&smmu->streams_mutex);
	[...]

> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> index 56ed6ad1dd523..95da4ad354829 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> @@ -1020,6 +1020,8 @@ struct arm_smmu_stream {
>  	u32				id;
>  	struct arm_smmu_master		*master;
>  	struct rb_node			node;
> +	bool				ste_installed;

ste_installed is unused; better move to the patch that uses it.

With these addressed,

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
