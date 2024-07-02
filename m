Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2048.outbound.protection.outlook.com [40.107.93.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37B59200100
	for <iommu@lists.linux.dev>; Tue,  2 Jul 2024 20:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719951049; cv=fail; b=oMmYFwzz0TN9jTZoDS8hcYEKA+dyZiPOjtgXWbLVVmW5cx2tE9suMJGQDqF0CRBJ5XG05MCK/Ru/x+6D8wLFI+bBDqVOn9T5Ggr7Re2xn3aaNqwTTnkOjkXVvCwhZ4a+TDbPX4QIyAlisDwF+vlj7xUh5/jdna6VopqGWoBC+TI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719951049; c=relaxed/simple;
	bh=KQ+tcR6k32jumsSearrndC0iI5mFxnHcOJsvmCgFAVo=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V7uYGoiQe3Gk6KdCp4Hidksfl1SEvdNnmv/cMNl+3qvkiyDBUB+nk6RPq8u3NMmtPBNt8WR3aFvq7gXLiboBBMJC3fEC5qOisT36N2K6Z+F74fFbj1sWSi6L3Lhy0WCHQgc3yfz/7I/dsSZzxpOUvPLOH30VqELgtL7zsTe9D/4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Cs2FUYoX; arc=fail smtp.client-ip=40.107.93.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Cs2FUYoX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XOCmEF0yFWEi9gyF4dGGiQY3dA7sc/MpcVZ3F9YH0/WEFsrFcaFI4fNTqwrbXfCYLT3mwaYufKKiO8lKcMGO7BhyCIVGjrGZOSguSgwlDWiOJ5MztVwiQWn55LDeIzWoPHMcEPfgLw7Hqrm5TjKL/qS+hvq+e72dj7YvCLA90ApqoXeXkgLkDrr/7AkQMoQWFEgW2H/d+2L9YpULX2h4poLHSdwmQRVWlaVQURxjeuNelyt3PQ2UmA7oPvTzJA30dQp9hf/EQVUpMqn5Z474mcdtpfrjPKsDGNW5+DRABIyYzvHKVtKvKtFbPaw4ClRA1HmFZQou4NbD7o/oP/2Pww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8RGmEdsmSOSFfWWVDeIITO/WgL9V63sPiikV16ADWcI=;
 b=JrRhJB+UHSd3TnC+qOiv3NQvf9Ra3041LvVzZbXYuc3PxXVtIBmguN/LtCEyg4kxJ+otZnPjWjf5/A2Dz9ecHy9prAkUc+07PAPE3d6SS9fwjKNcTcXNGTEKvBtZMCjlff9VP8FXafApMkXY1r0taDZ1jKsXP88ETxOtyo3/2HMu7AiVFYJDXYrWrDSkQicMgMS+iuWfHdpvrfcExRN3qlhsUedvSivSZBT+0mhrkCOZx1e7o3ldXQ3D1cCz22sJ+Q0wh9/VSPC/YKmAVJyNZSISuw6lQr74Tmytgiaknzhf+OCNhfbbYcb9qoN7RJ8bE/y5yRsjYfWfyOz+Wo5TlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8RGmEdsmSOSFfWWVDeIITO/WgL9V63sPiikV16ADWcI=;
 b=Cs2FUYoXRHIoDYTw2qUQXzYih1bn0qAEa0Mf0t15l3vVZypCC4/UPUMISnj4zlP4h1XYLdEXVyqnvBVE5NYXX7A5e8GfwugfbNnL+KPhi69zSRuzgLz14yVbSA0j4+WYRtmaiqHFfcRNW9VJLEjwD0eKrKycAqvBTW3+CTsCOIzu4IQKkbeXKPUb/nDL0FQtrewK+gCYVmJwNTDXTRqgUAK2yR3zTuGX2RhT3+obSA6SeKztdTsMIhRsW549jx6zKDWxHo//9mUFX7BGV7PnveE9XuUH3AiRvXewIZcg29/vxZgR1EIAt4qZlHDj+jRhzXfjEkvqQ6jx3Ccxf5er1A==
Received: from SJ0PR03CA0085.namprd03.prod.outlook.com (2603:10b6:a03:331::30)
 by BY5PR12MB4226.namprd12.prod.outlook.com (2603:10b6:a03:203::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.25; Tue, 2 Jul
 2024 20:10:44 +0000
Received: from MWH0EPF000989E6.namprd02.prod.outlook.com
 (2603:10b6:a03:331:cafe::28) by SJ0PR03CA0085.outlook.office365.com
 (2603:10b6:a03:331::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.34 via Frontend
 Transport; Tue, 2 Jul 2024 20:10:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MWH0EPF000989E6.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7741.18 via Frontend Transport; Tue, 2 Jul 2024 20:10:44 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 2 Jul 2024
 13:10:22 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 2 Jul 2024
 13:10:21 -0700
Received: from Asurada-Nvidia (10.127.8.13) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Tue, 2 Jul 2024 13:10:20 -0700
Date: Tue, 2 Jul 2024 13:10:19 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Will Deacon <will@kernel.org>
CC: <robin.murphy@arm.com>, <joro@8bytes.org>, <jgg@nvidia.com>,
	<thierry.reding@gmail.com>, <vdumpa@nvidia.com>, <jonathanh@nvidia.com>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH v9 4/6] iommu/arm-smmu-v3: Add CS_NONE quirk for
 CONFIG_TEGRA241_CMDQV
Message-ID: <ZoReq/kNi368x79q@Asurada-Nvidia>
References: <cover.1718228494.git.nicolinc@nvidia.com>
 <d20dc9939523fac490bc02e57d7836f680916a36.1718228494.git.nicolinc@nvidia.com>
 <20240702174307.GB4740@willie-the-truck>
 <ZoREzIAqzyamQBWL@Asurada-Nvidia>
 <20240702184942.GD5167@willie-the-truck>
 <ZoRZP4k1A3G7nH9q@Asurada-Nvidia>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZoRZP4k1A3G7nH9q@Asurada-Nvidia>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E6:EE_|BY5PR12MB4226:EE_
X-MS-Office365-Filtering-Correlation-Id: 625a8190-3ec9-4ff8-f593-08dc9ad30e1d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?52dd6mxrm5zs3PjhCFLv/nzf2ZblOMpljq3od+LSqfuqd1ADxGN+oD27hCDz?=
 =?us-ascii?Q?Duo2B6PG60WOHfJclh5c6YO0K8F8F34UGnFwu2tBTkjjuLjvGnRQx+7YXA/Z?=
 =?us-ascii?Q?6EymEizdS8X0NXnm006ydLVk1cZWM9UwPfNZvrtm94wMtzuPkGcqD+yALjQt?=
 =?us-ascii?Q?G9jF3yTMPWWAUQ38Kg2cc18bjJf3MUqYiiNrRHSUlWQ8CF2LCD+20jK0bOOt?=
 =?us-ascii?Q?9DS3EkBd63+IRfYVUmid1PNPp2muyQ0ffaX9jGvF54A7QLf7fNIerMI78Tgh?=
 =?us-ascii?Q?ISWb7U3mb7g3YN0eS5xIfw+etzlXRINpxMX0YtSCDnHb5cNmuLNDeioy3548?=
 =?us-ascii?Q?Yg45+xdkyohyKVgDBAdaumL0jHFDr2sLQaviaRHGtKZw1C5wJeYVGpgUqK+h?=
 =?us-ascii?Q?HjLK5b6P7vbVu1tBecCMox5gEEC7f4iXtTZab1WZieqhgrVrmT7A+qD69Mm9?=
 =?us-ascii?Q?mYwLy2U1RVLQNTSfjBfTKqlfS5HoscIHpPlafJMse6MX9G3Bo6WwtLWYBNEy?=
 =?us-ascii?Q?m0CXmjUvKShLxpCg29W3lJxq1+TBYlm6+0bEuDdJIpCwFoReQJZ3dFb+rmSa?=
 =?us-ascii?Q?PVJtrKoyf8iMPAbg62X0gIylNLT1IblDiNCZJJI/qDGxxXOl2cdFzEo7rtmW?=
 =?us-ascii?Q?KwIAvWWkC1A+NyQYUi5cP+Pj3Mc12vhzE7u4kx4920E6gW8O3wa7/frrUCPx?=
 =?us-ascii?Q?Sf89WJ5RlveBqIZL3YT8q3u6OQ/vggyL36t+cBKiF5FkadClmQLvVU2Hofa4?=
 =?us-ascii?Q?yYWZhqdQFdA5oRyxSuv9fmmqliQUlScdxFhBVI+yq0srZJAziDFCLtQ8M8+X?=
 =?us-ascii?Q?s+M6qwD1M+Ioz3sOBUOqlBzWOKtkdFC2wEV9Yolvv+aeNRhi/o4Bsc+Sl8cU?=
 =?us-ascii?Q?wFGEgSWqStYu7EMorNF3Rmbi28azpC3H5jROmYwvACr1AlxR2nwS6TTusnMu?=
 =?us-ascii?Q?GR5qQRN+0kbcoGeNAvrbd1M3a40iYC4zAoJm9LYV90lS04K3zI3VF555yv+0?=
 =?us-ascii?Q?5Ig+0xG1VKfk4TbEroPbMnzySrQervR3Gi9Sb2nOBBVWEwPcKnHIoNXF94kU?=
 =?us-ascii?Q?tRuBNF865WKHPx7ZUZ9ngq5tftc1ycX0zGWG+b39BIQzBM6tmo4yFeQgdKM2?=
 =?us-ascii?Q?S98q7y6jTb42wC3H8T1R5DytBrcVSB9svFc6ycfTS5owEWUrrhmPvBnlCVXm?=
 =?us-ascii?Q?5oZzMRQkbbkGZOsaF81+DhCyZva2KWEnvu3iy6QZag7zXHSSVR1lPpP65l1s?=
 =?us-ascii?Q?qkgg8M4ona4ICfQ/g4yeWrOfVzfhLrNXqivZkuB5+9PUT1kJLazEi+cPqnFv?=
 =?us-ascii?Q?+oe4bRm76eupP5DP9qGtY2CcqbAQ8hEehkuAd0hGsMiFJlP3Uvugypt1Ql77?=
 =?us-ascii?Q?Ql4DBmd2uF2Vy+h4kCOr/a1Swg80udy8ELWjNDOz9aDXJBZfYu8jG8vl4oXG?=
 =?us-ascii?Q?BRm1v8e599kx9sFYB+lvhgRTj4HxNZF3?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2024 20:10:44.4451
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 625a8190-3ec9-4ff8-f593-08dc9ad30e1d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989E6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4226

On Tue, Jul 02, 2024 at 12:47:14PM -0700, Nicolin Chen wrote:
> @@ -345,6 +345,11 @@ static void arm_smmu_cmdq_build_sync_cmd(u64 *cmd, struct arm_smmu_device *smmu,
>  		FIELD_PREP(CMDQ_SYNC_0_MSH, ARM_SMMU_SH_ISH) |
>  		FIELD_PREP(CMDQ_SYNC_0_MSIATTR, ARM_SMMU_MEMATTR_OIWB);
>  
> +	if (cmdq->type == TEGRA241_VCMDQ) {
> +		cmd[0] |= FIELD_PREP(CMDQ_SYNC_0_CS, CMDQ_SYNC_0_CS_NONE);
> +		return;
> +	}
> +
> 	if (!(smmu->options & ARM_SMMU_OPT_MSIPOLL)) {
> 		cmd[0] |= FIELD_PREP(CMDQ_SYNC_0_CS, CMDQ_SYNC_0_CS_SEV);
> 		return;
> @@ -690,7 +695,8 @@ static int arm_smmu_cmdq_poll_until_sync(struct arm_smmu_device *smmu,
>  					struct arm_smmu_cmdq *cmdq,
>  					struct arm_smmu_ll_queue *llq)
>  {
> -	if (smmu->options & ARM_SMMU_OPT_MSIPOLL)
> +	if (smmu->options & ARM_SMMU_OPT_MSIPOLL &&
> +	    cmdq->type != TEGRA241_VCMDQ) {
>  		return __arm_smmu_cmdq_poll_until_msi(smmu, cmdq, llq);
>  
> --------------------------------------------------------------
> 
> Would you prefer this one? I feel CMDQ_QUIRK_SYNC_CS_NONE_ONLY
> is more general looking though..

And we would need some additional lines of comments for the two
pieces above, explaining why TEGRA241_VCMDQ type needs the first
one while bypasses the second one. Again, it feels even worse :(

Thanks
Nicolin
