Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012015.outbound.protection.outlook.com [52.101.48.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AFD538DC68
	for <iommu@lists.linux.dev>; Wed,  7 Oct 2026 23:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791415086; cv=fail; b=W5x0k3JE1tIsk81V0Hw0zs2IMKLwwQlMHTZdEYtuZ7QhkcJspshKH+Kw3Yv4Y8sYktjXw8N7SvEOB3M/VRgpkjLQ7ChpCF/xEzFmDwY8MnPxCucpBpg/5Ie0iQD7LUv5XiNvFd6p//FH5IMflXTKVSDtUJnQ5ePPuF0SH3M6zIk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791415086; c=relaxed/simple;
	bh=2Ulob+G3emb/2UDHWogLFlIj1w6QMoc4xGmCKpWIyQY=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SwuhZujqqkTCPEyP4e9OaXR7O7hYq+11gZ86YEqAbfcyaMIJkjLx8Ux2A+ov6vTTBNOv19PIbAunARIpT3pmL1wxdwkahgc2Nadedny5b/SUw7hoNyORkoCuyYJE+79mLQxcgpSM3uKrf/9s30xETCjuHbI1iWTEUuxQ027LNXI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=t3CLCYPT; arc=fail smtp.client-ip=52.101.48.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="t3CLCYPT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OHFJgRGcZE6/zZi9xQnIQO8IidkmEKeyLRh+6eOntCy6TCwlevXrG6lPgWpqGFeiROhW46fwP6pgmbTlhVue3EjvgSQzDkB1SZPExdT2EElaiATzaXnUuj3hJxq9Kq1VzhflYDLPrwz36a4tUe+ViobN7q7P4ZaUqWjOxOfxxXmEyW8LZvHABggcddmucrZfh5u6LFmZDN/Ua182Uo/Izh6AWhweWUxuHD7tPEL3SyTF4h0MClSYv0/gF5f+LxlRdes3Fx5SZi6g1xnCCNUPKUbf83aZFyaiFbnKhezJjBK+jz6JgNgLdEHQLYgR2G/4GTPHLNpEEKBOdjhWpBJtTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KMZVVQ/LJS8PeSIGqjsk1G9U28SxGNTkNXsIRPwEAtg=;
 b=u1nk1aa0qwjDmeMBNQzycmmrbDEfWbiLJ0mt+ewXHGXUWAFDP+56tLcivGxLUfBOiecmcBRG5qvo/bqbd9Z/6iUXbXad+TTrpKQoLZimYAn9J7+TNWr7WNlh5QSVvENhjbl4Kyybv0sU1Nlo7J5nAQ4BXkIyu60i6mGS8/8odndJHXYB+goO6VucZc5dg5QLdnrf73A70hAxhPUFlGR2gWH51MZYKZv/Jek0mArwEgTxoPoMovRYreWaTbnNya/iPR/rKiU0bW+rQo0QOkHL9huYBvetjGAjxejRtKb4o6gmYdiTTc2aIdXgiGZbgBLyCLgJ2h42E3JX+uxtHBdjEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=oss.nxp.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KMZVVQ/LJS8PeSIGqjsk1G9U28SxGNTkNXsIRPwEAtg=;
 b=t3CLCYPTPYSSjoMIU5fcNX31eR9dVKzMTErODYEH/id/Y4y0UK+UBHRlRJUJujJ55UpqeZTVsnK69SFEtV4Iia8RYnIqdkjypMCxeL51KtgdAs31wKKjh4GIIFidORnu4lVQo80frVeKun7pJp5jF9Y+5zVCbbeyP1pMwoJHRhM2XlhVyqvvQByh4YDTk4pQXFeA64uVKlQNVxGN8d09JA19TKkGWPyMSSRHRD+1yvrn0MrgPKJdbULWXLpDtkCbRlzw57v4oOdsWCH/3YE6HXKLsik39pBwhthEh1wIjGSsYs/G6gTB3DQDF11ruUD7ZzWaqeH3BKYDXhUmRenWnw==
Received: from CH0PR03CA0327.namprd03.prod.outlook.com (2603:10b6:610:118::20)
 by DS2PR12MB9664.namprd12.prod.outlook.com (2603:10b6:8:27b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Wed, 7 Oct
 2026 23:18:00 +0000
Received: from CH01EPF000BE946.namprd02.prod.outlook.com
 (2603:10b6:610:118:cafe::40) by CH0PR03CA0327.outlook.office365.com
 (2603:10b6:610:118::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Wed, 7
 Oct 2026 23:17:59 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH01EPF000BE946.mail.protection.outlook.com (10.167.244.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.14 via Frontend Transport; Wed, 7 Oct 2026 23:17:59 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 7 Oct
 2026 16:17:41 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 7 Oct
 2026 16:17:40 -0700
Received: from nvidia.com (10.127.8.9) by mail.nvidia.com (10.129.68.8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49 via Frontend
 Transport; Wed, 7 Oct 2026 16:17:39 -0700
Date: Wed, 7 Oct 2026 16:17:36 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
CC: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, "Joerg
 Roedel (AMD)" <joro@8bytes.org>, Jean-Philippe Brucker <jpb@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>, Thierry Reding <thierry.reding@kernel.org>,
	Krishna Reddy <vdumpa@nvidia.com>, Jonathan Hunter <jonathanh@nvidia.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>, Peng Fan
	<peng.fan@nxp.com>
Subject: Re: [PATCH RFC v5 2/6] iommu/arm-smmu-v3: Allocate streams
 individually
Message-ID: <asbTEPMJvm9T00c+@nvidia.com>
References: <20261006-smmu-shared-sid-v5-0-169a59c671d3@nxp.com>
 <20261006-smmu-shared-sid-v5-2-169a59c671d3@nxp.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20261006-smmu-shared-sid-v5-2-169a59c671d3@nxp.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH01EPF000BE946:EE_|DS2PR12MB9664:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f202701-aaca-483a-13e2-08df24c93a87
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|23010399003|1800799024|36860700016|82310400026|13003099007|11063799006|4143699003|10067099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	n+QVLMzH9lqrz8g+rRRuFKyecrwvjwu8VB9wiqry2/HQrM7MtQBVD927Fh6YMMF2+aMmoib7en0Xa/4xeKvRenkWs+yJ59fn6cVhER23AfQWuvlB9VjV6Us9WXxxS1dJH0f48e1uDb8Xtlc/wt4/GyT5zllPi+qVUfk+TgW3j6Ku0hITmrVlLw2LfEKrGrsnRpKrAOl6fBxd7hbIll7X/UuAS+lK+FpQ5dy4onpMcOA/RQe5GlD3vknVAG7c5s9hh3pjAj5+SvqVK2nhFtbuImIN0aTqDVPu8LwnXWs9y0FW1J4pW2Cghuikbws1wKjjiQivnSdIFuAC+if9wWg9Q8eoXudZpjVHeeQ7QAU6wZ6JgJX6Fa0F3KczI6eOwjaQEnCJr6I23p6a8yKdMMsDT2Fs3YK5R1Ejaio9b6/PICZW2RTbk8Wpf+C+OVBgQatQGkZrkHMGuh2H9lF/JK5W6jSpjdoL4fP5pUlSgNSR5ZPjbAIEWr8MFMfByikdUCXLL/HbOBB2H+CSQhraO3KWgxuSkbOeD9z0/x9jUvE0GS7GJd/dTCrY4Cbise78/vgmWU8Ppu55XuUlSHMkP+E3T2YsRS5B5eALZe1bx58t0hPetvlXubR+nwExX/Z2TN39aB8ZA5QlbZG9Q/EDbil52uw55hU5RA1e3hBH+iBoQAvgcouM5nd9UkeYZSyCO35Hs9SA4/YJK8purbYxQBpzHA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(1800799024)(36860700016)(82310400026)(13003099007)(11063799006)(4143699003)(10067099003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	dTsRkFot3jtUFSQgD5+v2IqhWMoSfSkfEAc13iuZDmHc8W9+SvrQNNSi/hSMcsGdt7t+R4AVO5UoAT59PQM7GBwu/luetuncPMSmvJ6YH+mYhC2fOYme0POP2yWapGQ8rN6iFXHgJslZTQKE16Zg8Z2xON64xDyiefV5hV6kRRJbmTFJChkUyi/oEcocFVXGMBO7DsPCc63fj18V5kdwRfgAWUCC6iykQfQGVNK5sSJuau58OFMPoXkeHgdDjE2zoD0oRvf3uHY3Z56qaNykSQSMwAfSvFT0Yu1ft6fY+bd3oeENEcUJqTlQMAJfp9y5IGJvA5dOvU5pOOQ1kuibl+vpDkOtIDDa/VKXCK1dUznE2RFHShPeD6P1g229OGUMRuxEClI8j5anw+d3y1M+HEroIHUC3be9R1rGtkTLLKjMfP1ybRcjfFWZ+/t9ObBh
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2026 23:17:59.7053
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f202701-aaca-483a-13e2-08df24c93a87
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH01EPF000BE946.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9664

On Tue, Oct 06, 2026 at 08:19:08PM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Change master->streams from an embedded array of struct arm_smmu_stream
> to an array of pointers, with each stream individually allocated.
> 
> Prepare for shared-SID support where multiple masters will point to the
> same stream object. With embedded structs, sharing requires duplicating
> stream state and manually keeping fields like ste_installed in sync.
> With individually allocated streams, a sharing master can simply point to
> the existing stream.
> 
> The sort comparator is updated to dereference the pointer indirection.
> 
> No functional change.
> 
> Suggested-by: Nicolin Chen <nicolinc@nvidia.com>
> Link: https://lore.kernel.org/linux-iommu/arG6hmng3NddGEHm@nvidia.com/
> Assisted-by: LLM
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>

> diff --git a/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c b/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
> index 6644075c1431e..bc62a3d5a63f9 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
> @@ -1257,7 +1257,7 @@ static int tegra241_vintf_init_vsid(struct iommufd_vdevice *vdev)
>  	struct arm_smmu_master *master = dev_iommu_priv_get(dev);
>  	struct tegra241_vintf *vintf = viommu_to_vintf(vdev->viommu);
>  	struct tegra241_vintf_sid *vsid = vdev_to_vsid(vdev);
> -	struct arm_smmu_stream *stream = &master->streams[0];
> +	struct arm_smmu_stream *stream = master->streams[0];

Sashiko raised a concern of an out-of-bounds pointer dereference.

Though it's practically not possible, probably it would be safer
to move this behind the check:

	if (master->num_streams != 1)
		return -EOPNOTSUPP;

Nicolin
