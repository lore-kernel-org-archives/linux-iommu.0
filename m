Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010053.outbound.protection.outlook.com [52.101.193.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DDF927FB21
	for <iommu@lists.linux.dev>; Fri, 23 Jan 2026 17:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769190209; cv=fail; b=OcYKZj8XcWPDbfcEkUMCSB/KlkV9SQlOuMxQOlYFhJRCwhZ46tq/ylHrJTUJMj4sRNA6G/20it+iyxpcLh1xvcjpKyrzYJJ9aldTEuq3dbjZTS3UUfmUmOMXzwHM+ggiCvPIRqu2oH6EGEZ2zFUkXtUFg40/Dv66R37H4KVdErE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769190209; c=relaxed/simple;
	bh=9UBmJ0JopnTi5SrUVKn+ktHMOKuU7yovO+eUXQAZHgY=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TzGNj0uDGQrvNkoWjB+l+gPTLxDjt7NFK8M5cepbEtGbLiRt39ml4u+fv/P9DteXXMelApz2N/kHDiFJ2tBs82W4+OcLEdMEEhM2f8y2aJcQnrPXPWdnnm86Ss85ztrSZLx4iOusR2i58YSLvNpO2d28PRafCxD8HmK5yiBuh9Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nFOdGvYF; arc=fail smtp.client-ip=52.101.193.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nFOdGvYF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mcSKhkNamuQY/y6INloDI7m5TYx1RHY6ejPOi/YEKAahr9sy9gjjokySSapkQoZYV6Olts5/DzjQgJ4NpjAXq1FVRDeeGcjYiNssKCchYNkKMaXdkyZliqWqrBoZjIEtS875fyBqa5dVBHdIqdPWWEsLoyR2mP7KpVM2hRiYAcoBDr14tTbxFBWk425b3ISidOn3N2FwdbH5gIvS2AD+yeT7gdLUJaXbm/bbEviYJpeKF9ctQJ1W+MZcpgY2MbQAey+D1tJAivPsKWWmcSOz04e7/feqkAMrterPELad/Mtxo+JHJsAIh50r60KN97xcOpy0NHmpk3kDEiovkcx+aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4ljao5ViJq6W7qt0/lxFs7Wy1IQIoqrGV5TOWwOAv5s=;
 b=nxSslU9vIQpRf68SY0gJGOqV2seXLWJxueQFBgWKOW7eymu93q4tSIltoZHYxicwnYFpIVezufDP1fLjPZVncbvR6Zk3+aDVcNcnnI/YE943ZH6Cim3d9Z2/vzbOv5uK532LA3xudn4gLc23PGtG6EpqhHNOzZ3HThdXsfoidT7WQ0T+ExzFp5JHma+9PFfViwS+ywdi1PZD02JBG8FkQ+wRZ5Mw7MAJQrBCK+LiWIGoTkLE02+oQJcmzOU2VzS0Bqg4xZ83bmawggqMH6+AkdHYkbmckYz+fU+v3/TrVG6uskbnxSjP0re0JewQNZwbbHxxuJz7w12F+Bum/SJG8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4ljao5ViJq6W7qt0/lxFs7Wy1IQIoqrGV5TOWwOAv5s=;
 b=nFOdGvYF+6esDulMEhd3REOAzZebCK+aTWGGbAl0e+ocyIdfIWZgYw8ApKdrKFOhTvdzA7YQzirGS6BAfPbETF8optSdP3RkzNcTrXWgTyVRe+ePr2+bqA1VVPD92KvexBnr5rAfxNuWmzLesSbhz7cBF8auWX6urvrfeiBZ5Ac51V9XjD+Tp79+mFeS17T1Q/m+Z67nlWK1gYroQxbR0GNkPOLt8WQrV6OOfYptPrn7WOWac4iO2ZG95rfz+7mtOi7I8W3TZdrjWPboVnMj4z9xZMoV6T4+0LUcWHHt1zWEnm8X8FWs608z/oh1QCznb2eXvm29XxDcT8dZXUyYJw==
Received: from CH2PR04CA0008.namprd04.prod.outlook.com (2603:10b6:610:52::18)
 by CY8PR12MB7436.namprd12.prod.outlook.com (2603:10b6:930:50::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Fri, 23 Jan
 2026 17:43:22 +0000
Received: from CH2PEPF00000141.namprd02.prod.outlook.com
 (2603:10b6:610:52:cafe::47) by CH2PR04CA0008.outlook.office365.com
 (2603:10b6:610:52::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.11 via Frontend Transport; Fri,
 23 Jan 2026 17:43:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH2PEPF00000141.mail.protection.outlook.com (10.167.244.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Fri, 23 Jan 2026 17:43:22 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 23 Jan
 2026 09:43:06 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 23 Jan
 2026 09:43:06 -0800
Received: from Asurada-Nvidia (10.127.8.11) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 23 Jan 2026 09:43:05 -0800
Date: Fri, 23 Jan 2026 09:43:03 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Will Deacon <will@kernel.org>
CC: <jean-philippe@linaro.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<jgg@nvidia.com>, <balbirs@nvidia.com>, <miko.lenczewski@arm.com>,
	<peterz@infradead.org>, <kevin.tian@intel.com>, <praan@google.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v9 6/7] iommu/arm-smmu-v3: Add arm_smmu_invs based
 arm_smmu_domain_inv_range()
Message-ID: <aXOzJwQJ7z8qKcEH@Asurada-Nvidia>
References: <cover.1766174731.git.nicolinc@nvidia.com>
 <06999367d001283744fd98eb7c1823afd516ce84.1766174731.git.nicolinc@nvidia.com>
 <aXOqVcX9YEC-Ikdt@willie-the-truck>
 <aXOrnMLLzZL9BtRT@willie-the-truck>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aXOrnMLLzZL9BtRT@willie-the-truck>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000141:EE_|CY8PR12MB7436:EE_
X-MS-Office365-Filtering-Correlation-Id: cd33ac59-a2f5-4dd2-8c51-08de5aa6e724
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|36860700013|1800799024|3613699012;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6i87ZF5EzUyEyz4Ar3oqXT6dWP5Q4yxMS5adzlkT+CXCdcFJsS7VRk/Xa/Um?=
 =?us-ascii?Q?wRXVRExL9EaRA7BuX2lfX8I5alaP/yrB8DGKXAjyyuaDvCBwLQpklq9ENooY?=
 =?us-ascii?Q?Qs6JfMAHALs4CYso7blIkFf+PUH7HJxS21LtZNH9xSjdR3BYdxXfAhI3gEbd?=
 =?us-ascii?Q?lrcC6UX7xGdadJDEMj2zFNa5hy7VNy1mpuuAH9y6VYc/0ZBG8IseOP9vQ03X?=
 =?us-ascii?Q?W0KGatbHmLwiYSfPj/Lffyj+hIfb0PnWjpQ3ZzpPhHfASSdOns6UBwcqlQ/3?=
 =?us-ascii?Q?Am2py9LjHG2iSyVIFvWtzSRoywvMj8S+SCXgu0DAoaVDhew1a9YHR7lFah9t?=
 =?us-ascii?Q?Rp16OAwrl84L57LXlECznf0Q6MyC5RCJUpGc/aMaaurxR4V1MkClDkjV+DlN?=
 =?us-ascii?Q?tJx0mdolmLxuvOWujH1djmP14nAMLUyGTZIhmSJ5Eh1Ei6RpLzk02LNtfJl0?=
 =?us-ascii?Q?XHA6wilE4xCxojQQkl1bykczLy0n235eUoyaYL0x71zaW4yyNs0dXCHdug3V?=
 =?us-ascii?Q?8fxfCJ73sTTgFJ0cwpbQAgG7j/r2r0zElsFPw3oYt6Tv4/8IQG9QV4tGuGZU?=
 =?us-ascii?Q?OXJrAF/0UzCWybpXemjA7h5TcKIS9N2g3JvN99MAv4WD1h8PEKpIDqs7ztm+?=
 =?us-ascii?Q?yjOlZ7lDJGJ1SPA7WTXXxLprWIk71SgnRFaaelTdfq8KlzpyNRgMj3pnGZwe?=
 =?us-ascii?Q?Q2uTY0CG5tKfl0HvoR0qLJCQPG7SIReesNMK9FbyHnVjnFHvjgeeECPaVCaw?=
 =?us-ascii?Q?n0d3rDCVdRBDK5yn7J30z3/XxPQV3pmnjmEoxzqCR25mi2U87gykB8Kcl5dJ?=
 =?us-ascii?Q?pSm+FKuyOEBSl5rMb84VL9hfWGXCQ4Pb0rU2YlKDAkiis6/BSIuAx8Meurdj?=
 =?us-ascii?Q?g8g19iYCA8b2wLFKZZeRb82Z6ROOXVwHg5rotJ8SPozVmr5VsLX0lWbZperx?=
 =?us-ascii?Q?yrodu5gXyLN47tswsuArew7M1u92g6QCWZmsZMpC5UbYfoWlIHCTJvzCA4UN?=
 =?us-ascii?Q?aag1H5z+wXs/hK93QOPtw0ydkS3Y0TRXlsmwv7GSZMJdnBtRrfvrAHugmI3t?=
 =?us-ascii?Q?XHz+l/eLY571qqAt9qZsb1HCPzhqZMAb0vf0Gq+z4Hwn4j17Q9Zuukxa8k2Z?=
 =?us-ascii?Q?r1K2vARoRx0Rki635epS0AKkftNV3U7FZYqYg1iEtrCBOEmO5DpLNCoVP4pO?=
 =?us-ascii?Q?o+stpYNBVy5vAKFi9zpSlEtlu3Jjd2wogmqIivgHu18oYIc1pPaTIkYJR0sq?=
 =?us-ascii?Q?0ncesXWXsGNmBKqhUKAYT1T/iPINxcEfChVMVTuRxvs2PpSkEOojezddBtZR?=
 =?us-ascii?Q?mAK8cjqUq+SjL9DTvhV/dSnaTNRQb5MBpYUpstDbKMQkUiXYKTUXAYACrDHq?=
 =?us-ascii?Q?fF1y9ApMw48GLMKMKd6AthaZ/AxxTfPLZOYimPOoeR/JvLNd0M6JZ2XIeVUx?=
 =?us-ascii?Q?1BxMMNkydVR2xXj6VHOkv4XkUx63la6sOL+FXfV3AteFXFZ248NA4RwEwVAG?=
 =?us-ascii?Q?uHp5QP5EeqSV26hTy+pvvuag6AHatrQqWhfg08xaTzGeGYDAxcpQE4DXt3sB?=
 =?us-ascii?Q?w6aosbOwU0SfuEjjNgOhttvDEjOtpCwhM23yeuq/dLPp56WG7Kb4SuTDYKdn?=
 =?us-ascii?Q?JHUgRggiqIpkEvJmvzm6allyRtISXFzfYni1Xe1oRo/YcyXHbzoxYb7dYaWm?=
 =?us-ascii?Q?lAp1xBtTixoL52+0YaYCa3wP3Ew=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(36860700013)(1800799024)(3613699012);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2026 17:43:22.0621
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cd33ac59-a2f5-4dd2-8c51-08de5aa6e724
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000141.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7436

On Fri, Jan 23, 2026 at 05:10:52PM +0000, Will Deacon wrote:
> On Fri, Jan 23, 2026 at 05:05:31PM +0000, Will Deacon wrote:
> > On Fri, Dec 19, 2025 at 12:11:28PM -0800, Nicolin Chen wrote:
> > > +	/*
> > > +	 * We are committed to updating the STE. Ensure the invalidation array
> > > +	 * is visible to concurrent map/unmap threads, and acquire any racing
> > > +	 * IOPTE updates.
> > > +	 *
> > > +	 *  [CPU0]                        | [CPU1]
> > > +	 *                                |
> > > +	 *  change IOPTEs and TLB flush:  |
> > > +	 *  arm_smmu_domain_inv_range() { | arm_smmu_install_old_domain_invs {
> > > +	 *    ...                         |   rcu_assign_pointer(new_invs);
> > > +	 *    smp_mb(); // ensure IOPTEs  |   smp_mb(); // ensure new_invs
> > > +	 *    ...                         |   kfree_rcu(old_invs, rcu);
> > > +	 *    // load invalidation array  | }
> > > +	 *    invs = rcu_dereference();   | arm_smmu_install_ste_for_dev {
> > > +	 *                                |   STE = TTB0 // read new IOPTEs
> > > +	 */
> > > +	smp_mb();
> > 
> > I don't think we need to duplicate this comment three times, you can just
> > refer to the first function (e.g. "See ordering comment in
> > arm_smmu_domain_inv_range()").

I'll drop the duplicates.

> > However, isn't the comment above misleading for this case?
> > arm_smmu_install_old_domain_invs() has the sequencing the other way
> > around on CPU 1: we should update the STE first.

Ah, that's true. It installs new domain invs first then ste, and
lastly updates the old domain invs.

> I also think we probably want a dma_mb() instead of an smp_mb() for all
> of these examples? It won't make any practical difference but I think it
> helps readability given that one of the readers is the PTW.

OK. I'll change to dma_mb().

Nicolin
