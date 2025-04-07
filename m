Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2080.outbound.protection.outlook.com [40.107.237.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4343F224225
	for <iommu@lists.linux.dev>; Mon,  7 Apr 2025 18:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744051910; cv=fail; b=N3Awrs2KvSiB7WOTp5QmL2+ktkiIJohlrPJwAt4p8BQbMlXeet+m7e3yTr6jPrMNh2acqybFXp+m15jyeIGqszz5RxgUypRikvMZDRJe4QjGhNSPB8biut0RB5oifHqFi/zeL01a13xpcrGL0uyYYceQzckJFX4h1s9kNahIymo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744051910; c=relaxed/simple;
	bh=XU8CyJ5rk3GRpeShVJpc+7HwuFV79iYyTMIQCnlbcJg=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T77AtZWRcKdNawuZ5NL06zJefZB75R13G9OIIINVQ5p0tXnPZ7MIMNxTh1D9ex61b6GS/GEE/nchOGd4mXiC3W0lkah06X/CoVDi/sLIeiELlYbRAyFUX3CWNB1s8C75MW4nYwp6uTSGHgGnB3/tGag+sVshx1RVkj8PAWM2Xog=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JOQAX1Dy; arc=fail smtp.client-ip=40.107.237.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JOQAX1Dy"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tsrW9nT/qKITjM/9PEzPAvvwjuVyurZYYOyhyEyMK6SSKSV7q1wjGEDDGoV4F/q0aDaDH/S2rqQxnfCxvOkl43mxqy/ml+hZCf+nFKvSFPpFjj55nEfMb2KhyAZjH745MV4uf2LOzyt8ANZMnaxkGxKA0nhIhIbaDq70Kpx13qZTb6mzIRWuxWnCdTGbYpdRZg55bYRAOyw2CjCnm3YSQN7/B2ftxe0oeFUQDGe/s5vKDt0CUrJ+I+sO+o+sNTWeWv0v6+Wyb4BJmObfYTQVXYTy5Nw/uIsKHQAxBI90hAKXk9Nssn+M21+JXJSC/5Lxoj5TXzNhk5I5psRhDPK0lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=99ne+CrsvUZSDr9nHvnQz5kvqqKLi60Qs64LteX6q3I=;
 b=i4Tow9+YH1lwYecgNG+KsjRQ5Nu2gAq289rKlBTufq7kHVkhFu5aXHeJ2VE9lIMD7yIDChh41S/qb8PP4wTnMkx2YtvseoYJ4MCt5wgc3bfB59yzPUDWCSjb+zYLkHB372nCdLVCQ8NrddAskOk4H3mifObu5CD0OBfPDQYCbYqHJFeo8HNy8YEdV0j5oNMlsmeJ4rPWrHEpQTPLGFLgqT1LTewsqk5JXmCYGzwDibjQraM/tCi9ffqNhTygaWaCx47+QLevzOaXFZqTfO1J+QBAdqNi5v3JaWmUhhIunMeBeddtFiSbDoGH42EybIrCzEIbxLGrP4o8zGrN6yXjUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=99ne+CrsvUZSDr9nHvnQz5kvqqKLi60Qs64LteX6q3I=;
 b=JOQAX1DyvWyOVveIDIafASR9r4MFwsYAdQb2VNs1E87VzLJj3ZBePSiI6VLguVBdFfjdRbcaeVg0D6oTvXxdYvaOEIuzxLF3s6DjjEggJccbDkuW8FT9Z2Ef5yZpBk0+tMZSIcKWxUo3mHiXbKaS/XVx0MeDyoX56RqtvKoWjioSj+FUOHDx7ESutMriXXH6zzsacf0QvLVvmCJ9WQu52RCWLAAS520MfOuNtR9VwiERcTnMe/qgJ/RzPJltDIC8JmXir1pmCoC4bl3MkfsrD9eELLSyNCxZo6jL3YpbE0MoJcwMu2EH0F7GL4arONHm81tC4aU8HERSAIYAuhsG+Q==
Received: from MN0PR05CA0011.namprd05.prod.outlook.com (2603:10b6:208:52c::17)
 by SA3PR12MB9131.namprd12.prod.outlook.com (2603:10b6:806:395::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.34; Mon, 7 Apr
 2025 18:51:45 +0000
Received: from BL6PEPF0001AB71.namprd02.prod.outlook.com
 (2603:10b6:208:52c:cafe::7e) by MN0PR05CA0011.outlook.office365.com
 (2603:10b6:208:52c::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8606.22 via Frontend Transport; Mon,
 7 Apr 2025 18:51:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF0001AB71.mail.protection.outlook.com (10.167.242.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8606.22 via Frontend Transport; Mon, 7 Apr 2025 18:51:45 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 7 Apr 2025
 11:51:25 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 7 Apr
 2025 11:51:25 -0700
Received: from nvidia.com (10.127.8.13) by mail.nvidia.com (10.129.68.10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Mon, 7 Apr 2025 11:51:23 -0700
Date: Mon, 7 Apr 2025 11:51:20 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>
CC: <thierry.reding@gmail.com>, <vdumpa@nvidia.com>, <robin.murphy@arm.com>,
	<joro@8bytes.org>, <jonathanh@nvidia.com>, <jgg@nvidia.com>,
	<linux-tegra@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH rc 2/2] iommu/tegra241-cmdqv: Fix UAF due to re-entry of
 tegra241_cmdqv_remove()
Message-ID: <Z/QeqJqXJZSSPekL@nvidia.com>
References: <cover.1744014481.git.nicolinc@nvidia.com>
 <b3cebee623b4c3fc7de0aa2abcb703b9342ba33d.1744014481.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <b3cebee623b4c3fc7de0aa2abcb703b9342ba33d.1744014481.git.nicolinc@nvidia.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB71:EE_|SA3PR12MB9131:EE_
X-MS-Office365-Filtering-Correlation-Id: 87e74102-be40-42b4-3019-08dd76053e83
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ueIHMs/+MXT0Ku9ykl6xQjt3coP59HtwQ7H3zvyKZxWeiHHgXVUAw60SxCst?=
 =?us-ascii?Q?epQBL6IJqP2tawzMzEKEJZagtYW8mUXK7BC1sStaex+2UsAR3luE7+MUab8q?=
 =?us-ascii?Q?94kKhTHdCxPpVeE7M4piwyJ/arPtczljRa1Lp9cCRegu8pT8KblMui60IW38?=
 =?us-ascii?Q?wE44TmSk14FjeaPc7pTwo5Ez+SuRCWgpQ6On3sHxTXNc5iHZEydg8mu6iBo2?=
 =?us-ascii?Q?P9j4Ot+MG8cf/JhQqQxR9FCQhbMRzDIlNpH9wwNqPtSSj+Tc/qK4s2PUiMoe?=
 =?us-ascii?Q?Gg4p5jmgofYjE1mZmObtEW5xX3EKRww/kXbjmYfLFuJyoj0PaDiZ0jfD1iv8?=
 =?us-ascii?Q?SIOih3WRAFfyBWjAJKxF2nXyY0WzwYlr+WiQbX3YFJfGsvJzktZKa51aMA/i?=
 =?us-ascii?Q?ej1ZXqIIhgKZx1X8x8Jhe35+pxNd7rlgE7oy5uzMe3HGgXQfjuI8WMo+zXP0?=
 =?us-ascii?Q?lccGwUUVKktB5rt1atwlHXmEqIYAZfNWZ3TabCPCGQaPZqejNyvEugxqc63q?=
 =?us-ascii?Q?e7ZExdRj9Yk0YxyRq7qK87evTuI6gh5dWrmdrR69fZOQWCrWGITuUdB6Uwg/?=
 =?us-ascii?Q?Sb1bg+wIus+vvBdA1SxEUswHqJN11kW2rb0eUSQguww0rZbGhVp4pj/yRDlZ?=
 =?us-ascii?Q?rMDGGtrUafJRWXmZE1y3N8Coxf9PV+L21Q/lTwpNJkF32vOFHHGK0f/9ug2+?=
 =?us-ascii?Q?ArF2LI5Aif34EcdQxb2hJky6Sh4hU3AnQbA3kiM6Pv/Xd0Qxr14P3N5oRrkZ?=
 =?us-ascii?Q?qOwzgihU45pS31KB8Dk2sQ6WskBfiHWM2wJmhigr3y9mTRdg7wxn6iX+Zw/4?=
 =?us-ascii?Q?ClLpMf9gewg2vfSpn+PT4rUuESQQh92nzOJtSn1s8Cns0r0NoiZuikrPyA8M?=
 =?us-ascii?Q?YZXzap6DD3uKez3NqtBVnT8l7xWDlz5GlZ6hmlPtHLB3Ncs4RiZdLVy6OjM6?=
 =?us-ascii?Q?OYqvdbKmcUMnNOOBUlTTUB4uWQqr9nT5TRdrWhdlTRvQidE9SzD1bpdN+uXp?=
 =?us-ascii?Q?cTIpBzUbEb+AtMQJH5WUvl+Nx+hJRJv1W+XlQeW3+T0O06EMAf9GUb7Y7Z3w?=
 =?us-ascii?Q?ATjuQZdj7OmnyFuetTbMyHmR41EOKLvkrT4bHbhaNc6yD9+Vp0wQFet28VA6?=
 =?us-ascii?Q?UTlhgPgz4tsp8wkKB2ZSGc5uxjITEhZW+tsXePJulL9eND5pH8X1IfzcbUdu?=
 =?us-ascii?Q?hgRXrhVhTX9l37mLMeWKAJ1kDHYQYpjjq/F8Cw1eJ1j/FkuCwcdmW4yAqjMD?=
 =?us-ascii?Q?ATfg9vR6HK20JtUi/wDLqjb7gKkW9ocwewrm3KWA2c5UlUDgiMlzbNgRKG4C?=
 =?us-ascii?Q?qAn0D8RSUnph+AzMfALc7UpXvB/0HujwrsRPsjbhWuxp7+W93WtGdu4moEkT?=
 =?us-ascii?Q?OpKb1PWYTvBMhbFK14sK5i5FeNGwz7SbMzMeAGD97ihDEeAmlnoJNQuWGb3l?=
 =?us-ascii?Q?Icg5jroLTRZAtwgV3cK2H5xSs/5eav+Tw8tqA3TwYDJ4A0E7jfIfXutfZOYq?=
 =?us-ascii?Q?kG3R9Sx4PrRdFaI=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2025 18:51:45.0146
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 87e74102-be40-42b4-3019-08dd76053e83
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB71.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9131

On Mon, Apr 07, 2025 at 01:35:00AM -0700, Nicolin Chen wrote:
> When falling back to standard SMMU CMDQ, impl_ops must be set to NULL, so
> tegra241_cmdqv_remove() will not be re-entered by arm_smmu_impl_remove(),
> which will trigger a UAF.
> 
> Fixes: 483e0bd8883a ("iommu/tegra241-cmdqv: Do not allocate vcmdq until dma_set_mask_and_coherent")
> Cc: stable@vger.kernel.org
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c b/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
> index ce7be8eeb43c..8249ef087af3 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
> @@ -803,6 +803,7 @@ static int tegra241_cmdqv_init_structures(struct arm_smmu_device *smmu)
>  	dev_info(smmu->impl_dev, "Falling back to standard SMMU CMDQ\n");
>  	smmu->options &= ~ARM_SMMU_OPT_TEGRA241_CMDQV;
>  	tegra241_cmdqv_remove(smmu);
> +	smmu->impl_ops = NULL;
>  	return 0;

Per discussion in the other patch, with a v2 this whole rewind
part would be dropped to ask SMMU driver to fail and then call 
tegra241_cmdqv_remove() via smmu->impl_ops->device_remove().

So we wouldn't need this patch after all.

Thanks
Nicolin
