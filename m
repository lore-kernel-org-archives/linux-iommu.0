Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011018.outbound.protection.outlook.com [52.101.57.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E61A5470E88
	for <iommu@lists.linux.dev>; Wed, 22 Jul 2026 19:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784747020; cv=fail; b=OTPEHfatJYbXsmITCtA/NwORq0ie7ibkEZN5OGvhZ1ZJCeLFtZcX6SjZbd+hOuJ8NfF48CkNGc/h5nv07QyURuiEKZuCDlSIJgCsq+xNI17dCgo5wr0bocsXPlo0ZWH2PvLRox7si+KKfJ4znCzGFLHYf4qcf0qFjbIM5wnL1Wk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784747020; c=relaxed/simple;
	bh=engaHWERp9cX/gscSBpxDl0S9rv4LGVZCtHOYiG767U=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LLdd/Kas6BGCReMPbv3+I+tQlxA1q6CuON/UCw7oJLghwHwJVmTFiIzBefEjq5JR4kVR8eYBRqeh/YfNiw5L3GajWDFgCHZ9k8j8d7L1mRxjyPNufSMNMKX75Snxlpwumqp5DdkSR/r9paKIvzHZR9SugmYHU2OKE6q++O6+J0I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UowvK/OP; arc=fail smtp.client-ip=52.101.57.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UowvK/OP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wniiWiFSfBmzPCBjjUK4gKPwpePlO1avKT5jZ/tgW99kXBhvYIZQSOyZf0zbP7oWHWIbAeQgDPh4BkMNOlpweA0k9tXi8kwICLswdy2u8ngqZsz1VA13hr3ttAPW3Dhk1TLHBpFqzNkDZrZ/GdgWyNeXjFakR9/POCYLYKow/FSR8O0fwz8sq1Mrox8/x9O41ufRcCz+U8KkdTpTFBHxtilXe5BSlPEygul4WxzbVw4VMdNh5Uj2HWMdZ8f+sYT1RXO1LHvvZW8svjn1Hlub1KUT65ojj10f9xIL55GJ0meB3m/QT2OFX5BoBHUWUP+fblNnq8L9yvdA790F/aGF0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5KicxVulK3HqmHrROj2ARhu8cuKUS1FsISSK81263eY=;
 b=TLum72O6HvyC/AvaMi/VGj/k0wKqpJwOj/ltGTxS+5FztrNsF4oRbfrlo9ekWR0yeZFqAA22Ce35IrYNakOI3zTd3c+zxBthvZrKK+TBavL/gd51gR8MwBCCI3l/lbMQxYwVE4deyCnrg8Zu2ncPUURFKQPZKeDN+LiIesLyHAE7aPPRj+AuRebu+B4BqHZIyyoF21g7mGHy4pezcTmzF91XP/HAFRvxAsTpa0kN0JwaU0qGyTk8kDnBLP85vEIBxxKCxu4Ta2pTURd2WyUdDYhvzw5gyLEwYKX9FHvy6OF8JcFl9ulTMC/w8MebuNuIgWHUdsULVXi119S9saeeuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5KicxVulK3HqmHrROj2ARhu8cuKUS1FsISSK81263eY=;
 b=UowvK/OPqtivwpD74pxtRzuRkEn6J9yibrjEeJaRzMaX4TlCct1r+ru/sSHmXopkn2mYQuLw3VbqfZ757Z70OtouxetQGJ55BkoUJ9gtVAtVyF9n33YTVmRtk4G8ruBESN2bILoOJ3AiqLPDG5BSQYnOa5DotegjzwOEiFnyg1Wc5KCkV3EfIl1MmWS2I+e93nDYxD62IBJZy23AFS8iJ/nhj/v4aYYLPo1noymkMwhKkWE7IIU1yLk5gNTRbkyLs2HMjsixGiBxe9Rm5RwMF/PYTL0Pya745t3+idnVGnViAwuFvVK3wxvY/1Wk18F0xdLWuYTULSyxr2L2d2aA+A==
Received: from SJ0PR13CA0106.namprd13.prod.outlook.com (2603:10b6:a03:2c5::21)
 by SN7PR12MB7204.namprd12.prod.outlook.com (2603:10b6:806:2ab::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Wed, 22 Jul
 2026 19:03:28 +0000
Received: from SJ1PEPF000026C5.namprd04.prod.outlook.com
 (2603:10b6:a03:2c5:cafe::8e) by SJ0PR13CA0106.outlook.office365.com
 (2603:10b6:a03:2c5::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.10 via Frontend Transport; Wed,
 22 Jul 2026 19:03:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF000026C5.mail.protection.outlook.com (10.167.244.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.5 via Frontend Transport; Wed, 22 Jul 2026 19:03:28 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 22 Jul
 2026 12:03:00 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 22 Jul
 2026 12:03:00 -0700
Received: from nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 22 Jul 2026 12:02:59 -0700
Date: Wed, 22 Jul 2026 12:02:58 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Ashish Mhetre <amhetre@nvidia.com>
CC: <catalin.marinas@arm.com>, <will@kernel.org>, <corbet@lwn.net>,
	<skhan@linuxfoundation.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<jgg@ziepe.ca>, <linux-arm-kernel@lists.infradead.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<iommu@lists.linux.dev>, <linux-tegra@vger.kernel.org>, Jason Gunthorpe
	<jgg@nvidia.com>
Subject: Re: [PATCH v8 2/3] iommu/arm-smmu-v3: Introduce CFGI/TLBI-repeat
 workaround infrastructure
Message-ID: <amETqr7ZBtgt2DKu@nvidia.com>
References: <20260722102033.1122277-1-amhetre@nvidia.com>
 <20260722102033.1122277-3-amhetre@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260722102033.1122277-3-amhetre@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C5:EE_|SN7PR12MB7204:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f23fddd-d67c-4d7a-7140-08dee823ea18
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|82310400026|23010399003|36860700016|22082099003|18002099003|11063799006|10067099003|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info:
	v9Fjq+3Gku4JNpMuypQ9962zCf31x3T0R4Cb2MUBpGgi8zjSr1WfDLxoUjKgAqfXi8JWxo1jbhKleXf0bjdGtUZcGXg1+gEGR3yPpwgT5WjU8ajqY/lFtayoDrAt4dnqKvj5iZP+SGdvfyqSmK47bDcpdmCf1b2nznon+TFQ3T7yeK9QpBOXammnb70N9DzIOSih6igBdATpH6O/7aROq9HXvbXFRneBCeWwtqFF6GtsYNVdAwbb07tCX6Omirtmz97KxR3gbgkgM45FV+E89HDUwtnc/WF9p30HcsTij/r1KZsOp2++4wceKi4n0fCa57SMebx3bG+q9lBE034ZpHMiNmW4j9OR4g/xGcJVQEIICt7JZ++K0KE/glZNH5JeFdY9FajvMNOb4vTRuaDzrcqWqwWfexEDA1ILPLctk6pYxeR2dL40SpYuGZjSwa0ThlLltZG82CLtQpJTAnEvrOVdJ9OE5dpAO6zI6lXUtl/ezXYdo9Tyb6bo4Ro93rFeIKZAIornqX3gQRQc13HK6e+bo1t6dQGnC22870oYXJe38PtGGnkmQaFVaTuvd5OXA4HjHYbYXmNN1z9MOw2i2stAZR/t4Qrk3KooxLULjTnP1eYa4X5+ce8ol3wWkWqsUi7vwWqbhjr0Sj0Shl10j5Wn91xkQGnBkPqRH+GL/7i1JpwPQWF2tNAKXv/5L7zb+VwMeKMnk09RWpjjvfI2HA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(82310400026)(23010399003)(36860700016)(22082099003)(18002099003)(11063799006)(10067099003)(56012099006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	J4Jp6cdtqM7XZx+htLaP5Juh2BvsN5SiNSbPa5/7JHRDGo8TNfaO+oNlHaheqKAx9EaWVpPt67Ro6F0srqR+85a+MdKh35LEttKWklu+Udjf+5IDvf4kEBjhdHZbm3jvCajD6vprBjKbd+UYjCf5zwqJQkGaUF4uYjUeGT8y9lCY6SvnmZw6y1tblmu43sijZOUlWUMP2uBpV2H9g07DmfYF3tyD1vdwnQiSCWFaS23rWRBYkXqVy9zBzmtGDM/20D+ZEsf+ubUmk1GhMDgLS8D1buTgjqX3cyQPibkr+ALRHq6Bp1cpfixlBmuG0Shfgfbj8RMqsqMrzudPCM5nkKFcRZhIzONges9AtoLjj9BCGVRMNhdmWrl3bryQFRR2Bj98uhFfmJEUX+gQWPqLVieksHzr0RgdOAPwtv9uRp3feqcLAXgbNz75iZewGYna
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2026 19:03:28.1853
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f23fddd-d67c-4d7a-7140-08dee823ea18
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000026C5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7204

On Wed, Jul 22, 2026 at 10:20:32AM +0000, Ashish Mhetre wrote:
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> index c909c9a88538..9508bf50d14c 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> @@ -1207,10 +1207,15 @@ void arm_smmu_attach_commit(struct arm_smmu_attach_state *state);
>  int arm_smmu_cmdq_issue_cmdlist(struct arm_smmu_device *smmu,
>  				struct arm_smmu_cmdq *cmdq,
>  				struct arm_smmu_cmd *cmds, int n,
>  				bool sync);
> +bool arm_smmu_erratum_cmd_needs_repeating(struct arm_smmu_cmd *cmd);
 
Is this needed?

Nicolin
