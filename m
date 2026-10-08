Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011042.outbound.protection.outlook.com [40.107.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6F372C15AB
	for <iommu@lists.linux.dev>; Thu,  8 Oct 2026 01:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791421364; cv=fail; b=eQnLCck9z7VOOqV4zOmE+uz+Afhobn/dfjAdtLHMuDsK3WSZe9wWcFzPSLuShYfe8Ro0Fh2swMeUE5nbMgpuAKIoSL6QCpxNE43P3Odzc0yEJKJ5ruhOB9QlliwalOIJCGohS7AN2696vTvkNqhzVM7mWeOUui6QLGJTyUzUOHA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791421364; c=relaxed/simple;
	bh=XFc61gqkwKG/FsinPdhrcvrAQnnkY0e1hceoh71nSJc=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r0Sbt4YZqMTQkafbrqmsy8e4dXSpzTWLBLuo5NmB7T4QJdTh7HhMSWWjFgItlr8CeMBD0XBZxiu/708R7PtFRJBneEaFn3SOdeUq1SsjJsASpaZUsovdnbGMRsOAiJ7PIdRfhR4CRAUnlprSgsLlBrHIYV0T78kJ1r+/jbkJylo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Jp5SfSSf; arc=fail smtp.client-ip=40.107.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Jp5SfSSf"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c0KUjU/im6KAsN5UxAWOg5N+ZfxHrjGK/9lEs1KKkrf/Gfrc2m0MHRjYyviH/JiezGAPlgdbU91MzomocpVZZmQouCwzBQtA79Clu1kyG0L8BW60oVMABi8tbA8juOvpzWMO4eJrH4QfO4sLoU3bf5BihZeb675iLrKAIfBv/0QrooPHBqjQ8BKl+49UidwcifHKM4WRQyiBUOIE2ItvkxxbQEgqZuMWJZ8mStLO2uTMbGs+8QeQQOVcC8mcLcOw5oRADMS5QD4MgX6a/W4P70vxaJiuTwtwNWWkX4/JEEDDuLOCGtYCCVbnbjh0EwelMkW/9v7dLInCJ3dqSe1Dhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aD7snWdFsYXwAVcEGUH/h+z/1UfPF825jPQAVGrAfas=;
 b=s9KzLvwkEtuXDHDxE88q7qTC9ww2YUbXsjXQCnJGbyiJwDyaGd8Y9NZuuwFVONOF3M0WG4+FGVBIJhQiYF5FVCSvaFF0ZOZtv6UQopyPBbnfIIa2jVNgbhM8L9dIAzEzazBdFneNojA9VwhaHkoRVMr38Kx8ZLLBvVDqqrKsaXZZUAeP9aHwtZY+9crCLGkCiE6TqRV/dhhEJeISZ1YYoiob3UcfFY88y0oGlRFyR+8xmkK3VP8au8z2/1iAItqg7yt45GI5sXhT+APN+vMAf95u+Y917lXBUb8fR2cW+a0k8x5ZjTTbhu8LjI8B70LvRI+D5D6EQWjQEG+5QsfEjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=oss.nxp.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aD7snWdFsYXwAVcEGUH/h+z/1UfPF825jPQAVGrAfas=;
 b=Jp5SfSSfZoKwNEVwNP2bGTg4utwm+BCvixQwYeMPIQHTvRjftJJjMhyO006xyULriT+sQ4ULLg5u2/0pky9Q3E3tWriCODrChNFXdyA9xrMRP6KA3xxwx8hCUePKAWRndfFNMTUzWlduBOhJNLE7NJuoOtVFiwEXlEO+nmGE2SNEASpeo6Nl6T2jxWvzVtdwNbgr5wN4CCFzsw6GuTXHQDO58jsBryJQ/lcoS+BMKojpsfm32YA70O0v7tYXgvXMhUesSQVWhCqWTqwcGZLXX1S1hcU5U4BWUjlasPA1ZYUQDdVv2okQ9hVjQum7ADYu8Ak5s+Fb3RQMjyBqfAkARQ==
Received: from SJ0PR03CA0061.namprd03.prod.outlook.com (2603:10b6:a03:331::6)
 by CH3PR12MB9193.namprd12.prod.outlook.com (2603:10b6:610:195::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Thu, 8 Oct
 2026 01:02:33 +0000
Received: from BY1PEPF0002696A.namprd05.prod.outlook.com
 (2603:10b6:a03:331:cafe::21) by SJ0PR03CA0061.outlook.office365.com
 (2603:10b6:a03:331::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Thu, 8
 Oct 2026 01:02:33 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BY1PEPF0002696A.mail.protection.outlook.com (10.167.244.154) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.14 via Frontend Transport; Thu, 8 Oct 2026 01:02:33 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 7 Oct
 2026 18:02:08 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 7 Oct
 2026 18:02:06 -0700
Received: from nvidia.com (10.127.8.9) by mail.nvidia.com (10.129.68.10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49 via Frontend
 Transport; Wed, 7 Oct 2026 18:02:05 -0700
Date: Wed, 7 Oct 2026 18:02:03 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
CC: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, "Joerg
 Roedel (AMD)" <joro@8bytes.org>, Jean-Philippe Brucker <jpb@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>, Thierry Reding <thierry.reding@kernel.org>,
	Krishna Reddy <vdumpa@nvidia.com>, Jonathan Hunter <jonathanh@nvidia.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>, Peng Fan
	<peng.fan@nxp.com>
Subject: Re: [PATCH RFC v5 4/6] iommu/arm-smmu-v3: Support shared SIDs in
 insert/remove_master
Message-ID: <asbrixWURytrZgfx@nvidia.com>
References: <20261006-smmu-shared-sid-v5-0-169a59c671d3@nxp.com>
 <20261006-smmu-shared-sid-v5-4-169a59c671d3@nxp.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20261006-smmu-shared-sid-v5-4-169a59c671d3@nxp.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0002696A:EE_|CH3PR12MB9193:EE_
X-MS-Office365-Filtering-Correlation-Id: 99ad7c19-2290-4e6e-636b-08df24d7d5af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|23010399003|36860700016|7416014|376014|1800799024|22082099003|18002099003|10067099003|4143699003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	/C+BGfE+0TpCytwSNcexX1hsMBHoJDHee0AMqXvmpnIs3xSFilRUQzzX3a7lxGYeVTBAM613RdR3cBdCUtggZ844kDty3zY/G685wMwfTwj6rdcqcR2jzV8qzZU9hk4cyHPMXTV/e5Nq2qQLoIOoXZAOoouRW8LZMV75ftsCX9HjGE5qOPApoOlSdDtl3tZYLKBvCsoDBpartR2dbbvlU2e5N26KQO2w8SyiICTN6YooDNMWgRqoXgaI+munARWsLWiR7ep0BbVKev6l8pACnsd9XPwhnVHBVBTsQzCbrdGjvA8mit33Na2926NlFHoOaVV61q6cS+21ujauJy9O/MZ1+VIIcguycauF0DqqoDAKe/Fn2jDvLCyOmauE9KwYYGb+4+4y9Em3LAtFRb1hxCf6SyqBz+W3qHJOfzyEK2DaPYGQ3suujJ9D4oq8FXt5Jw9MJ9t3ef+nxfOsP+wTA8O2iBAiedytSLwedIBW/b+DmP9Q6ayvHVPb43z0sKRkW7/0660xzSYI34h0xxbzmHnhSsbdReeQ2N/famBk+gE+Hd1GfqH5UT/qAZX+MaCUPzuzE73zgVWAWpOLiK+D/stH1oaVcD5UiBE/eG8JwCB5OzWBjiJayJRASCzqBXyHqMhRy8K5nBD2dPAUisLtuQR9TUm3uITG2U5QQwnFXRWC8s5abl/wK1MFSLUMBpLx9i5DkE3lOcdmoN/ZhA9CzA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(23010399003)(36860700016)(7416014)(376014)(1800799024)(22082099003)(18002099003)(10067099003)(4143699003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	/asRt+RPY1VTKSlHS7CQMAWXs+Up3HH2TNOssDWjrxlTVCl7GgwpAY9A/2nPWS4zGQnyTPFmvfoQ462MvjinyNJtmc+LxHsduoHyTQqkmKXuEr3X0kUAkctZ5OYNHs26pBbGGYyoYv3ZaQKL3LU93MY8q3JGG5Mo87mT0LohivDG5ftCZ+6gosK8gD2C5nsuKjWdXPigU3zQ7GQYZPvf5RiORRFqreZQYK0lBmnqAB/xvllF+d7mJvjCpuNm4WmIApRSIWPWplBvmO34+3i9GFpc2ykAoM2EsCnmbQ9BHWaxbxdi7uJQm4iodwbgVCAwagUnAnDjx4jm1eL2Fu3rKptI3E0A2N1pkYVq7FMnS43yfjW8pem+w51L0I1Vp7vXlvDjxCJzQLhrhBtoyC7A01rL7CiXbz4+4/eo+6Y13QqeLtiGBTOZZpCso/1tl7Xb
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2026 01:02:33.0142
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 99ad7c19-2290-4e6e-636b-08df24d7d5af
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BY1PEPF0002696A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9193

On Tue, Oct 06, 2026 at 08:19:10PM +0800, Peng Fan (OSS) wrote:
> @@ -4193,17 +4213,31 @@ static void arm_smmu_remove_master(struct arm_smmu_master *master)
>  		return;
>  
>  	mutex_lock(&smmu->streams_mutex);
> -	for (i = 0; i < master->num_streams; i++) {
> -		int j;
> +	if (!list_empty(&master->shared_masters_elm)) {
> +		struct arm_smmu_stream *stream = master->streams[0];
>  
> -		/* Skip duplicated SID pointers already freed */
> -		for (j = 0; j < i; j++)
> -			if (master->streams[j] == master->streams[i])
> -				break;
> -		if (j < i)
> -			continue;
> -		rb_erase(&master->streams[i]->node, &smmu->streams);
> -		kfree(master->streams[i]);
> +		list_del_init(&master->shared_masters_elm);
> +		if (list_is_singular(&stream->shared_masters)) {
> +			struct arm_smmu_master *last;
> +
> +			last = list_first_entry(&stream->shared_masters,
> +					struct arm_smmu_master,
> +					shared_masters_elm);
> +			list_del_init(&last->shared_masters_elm);
> +		}

This doesn't look right: it still needs the for loop and also needs
to compare master with stream->master:

		if (!list_empty(&stream->shared_masters)) {
			struct arm_smmu_master *next;

			list_del_init(&master->shared_masters_elm);
			next = list_first_entry(&stream->shared_masters,
						struct arm_smmu_master,
						shared_masters_elm);
			if (stream->master == master)
				stream->master = next;
			if (list_is_singular(&stream->shared_masters))
				list_del_init(&next->shared_masters_elm);
			continue;
		}
		rb_erase(&stream->node, &smmu->streams);
		kfree(stream);

Nicolin
