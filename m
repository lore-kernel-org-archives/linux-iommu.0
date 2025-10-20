Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011026.outbound.protection.outlook.com [52.101.57.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF1432264DC;
	Mon, 20 Oct 2025 19:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760987799; cv=fail; b=pTIDHWopFRGX6TDe8uc/uYSqllLoldpYwvHFwBvdWF82I04B2lGUakuebe5rXmJmyXmo30RgrDrkx1PDiA5EtrY2wVBsJPCpTuWGkl/9DPaU3lKiO+0LdfBK5tpTQLe9DHg/fqHtX1AEp1+VqLvCAoQZeOwQNRj407/w+Om03LE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760987799; c=relaxed/simple;
	bh=SF4VeQr/gPbDc7NehhhS7f1emU4cjhsU6YXy+k/sDqE=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H1ytN7Z35bIqRDpJIZiMAl7Co8J2eMmIkCgCX7nAWpKPSSf7wuLhSACpVEpxQPjozTw2qG53McDFgIHuZTq29hOy/aGyfckyxbAd+tHmiIHMEMxqNAOMS26YXI1COQcz+sj3L8bb9yBCYgo8aaB+lkWeROgloXnEEwg902R9/NA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=iREq6nXD; arc=fail smtp.client-ip=52.101.57.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="iREq6nXD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QSW+hyX4rvnUTuWS96gCYTOPF2OJcMUfmUlCNBgJIsjhZzAnm9EKnkszi9BhA33kTyMEAwmjN/6nHIGqLwW/CQx4hT6/+8hhSQUfdB0C9KFhKQE7yp+6ZnG22cXouB3FjXyViJXYpeq28+w60IL73EpWxCB4C8NPU5CBUE1SUjsL1DQs3BMoSOX7rpgPBoQs7Rp7dgfyahRCf7/g/FKGeDvGOgUvdoXm2ML0ZfXdMupt75FfNcCJqcLt0gYnF7uWmFxDUKXJTVSU2m7vWakkhCq/yqH88bYZHPZS5isxuxbMeoucX0uxSCzreIUNaHbSC5EveU5p1vpkRmj7OK9o9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gTifzaDtIeIGMUJPDNpHSblEN3/LU3gQrRGCekOirMU=;
 b=Jg9ohT1ZNWCN4DuFH0a431B07/A+DCrm0+IB+un3iYagYI3RcL+mo467Bu7s+HnMUWasqsiyDNpLwDKf6/Ao6FTJCZ3Hb6p0wuUYG7OQCRlT9gRsaDeU5uMTDNEzwyXUdzb2FPSVPmSC1sk2iDTl93lcyOmwugvAE1AD5h5dmw2a6hQZb47cpaTUBgrx29yMyhxR5dZRKY6losNzD1YnrEyI1Ts5f1KdX9YYyRBWJ54LRrT3i1bNp0xcRwDPYDP6Sm75gXOjyO6Nv7twh9uUecWw76zw5GaR1ruzaIpO44NlK5HiL/Cl+ig7Fllxqs7dJRtA3rJ1sZi+4qw14gMh6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gTifzaDtIeIGMUJPDNpHSblEN3/LU3gQrRGCekOirMU=;
 b=iREq6nXDggLOk0W9yexV8wYTMzk4m6BIMwwy3vzGhX6FoUmWV12leTyacAxeCENYy4is163lO6o9boOPhSWmq2iIgsiAW7F8iywigaFlo7gMD7a7Z/YrG1joJgpdCFNQAhHDeRqcvTrXcHxxXuu8A2rXqlCjvN8wccITbfJTtGIVVnuVHtFxmztn3R2phE8QRYAMTBQE92T35y1FF4/rgXEClZC5TKqg0RgPS5/9akrEGW9SYHhJPP4MVhQguWfo+pav1pOcwO+EkUpwbxXZappLQSrQZ5SFybYNL6C9Hrry2bHWhIGERLURJoiMk0G5ITmSlCyQFljpDk0krPQsJw==
Received: from CH2PR20CA0016.namprd20.prod.outlook.com (2603:10b6:610:58::26)
 by IA1PR12MB7543.namprd12.prod.outlook.com (2603:10b6:208:42d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.15; Mon, 20 Oct
 2025 19:16:34 +0000
Received: from CH2PEPF00000144.namprd02.prod.outlook.com
 (2603:10b6:610:58:cafe::c1) by CH2PR20CA0016.outlook.office365.com
 (2603:10b6:610:58::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.17 via Frontend Transport; Mon,
 20 Oct 2025 19:16:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CH2PEPF00000144.mail.protection.outlook.com (10.167.244.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.7 via Frontend Transport; Mon, 20 Oct 2025 19:16:34 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 20 Oct
 2025 12:16:29 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 20 Oct 2025 12:16:28 -0700
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.126.190.181)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 20 Oct 2025 12:16:28 -0700
Date: Mon, 20 Oct 2025 12:16:26 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: kernel test robot <lkp@intel.com>, <will@kernel.org>,
	<oe-kbuild-all@lists.linux.dev>, <jean-philippe@linaro.org>,
	<robin.murphy@arm.com>, <joro@8bytes.org>, <balbirs@nvidia.com>,
	<miko.lenczewski@arm.com>, <peterz@infradead.org>, <kevin.tian@intel.com>,
	<praan@google.com>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 3/7] iommu/arm-smmu-v3: Introduce a per-domain
 arm_smmu_invs array
Message-ID: <aPaKirLXdOtvuNgA@Asurada-Nvidia>
References: <345bb7703ebd19992694758b47e371900267fa0e.1760555863.git.nicolinc@nvidia.com>
 <202510172156.WHU485ad-lkp@intel.com>
 <aPKjEvxCJoRhzU7K@Asurada-Nvidia>
 <20251020121056.GJ316284@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251020121056.GJ316284@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000144:EE_|IA1PR12MB7543:EE_
X-MS-Office365-Filtering-Correlation-Id: 060faac0-bbe8-41be-8c69-08de100d2efc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|7416014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2QcmtfdHqDFkaxuUyvQpUL2RexRxcUieBCjXZe6Tz04hYe8Z81WEKnPRCNT/?=
 =?us-ascii?Q?KlSWR8vTy1mbnr1PGyOE2pKe3V3aaL01nuhJi1iPzdwYCgf/8RzzNF0cwhsv?=
 =?us-ascii?Q?XLFJcMvEveWoDUHnJVoKzfS0pAQ0CBklmF0ZTCB2JA7sfhgQuaDDKJ5tvFTx?=
 =?us-ascii?Q?2d8Oes9qhOg9YkJP1KpdYDAqhxpX2UmyVjclD+pVPKcKYzwbv6bhoIclv3wL?=
 =?us-ascii?Q?OHqQ8aYDxy4Q+98rIV3hJokTRZdpy6XjyydGnggO0pbeLUncwY5Ue8aecXkJ?=
 =?us-ascii?Q?8tIqmnXKGYxDneFk7n984s2iqpmP8wlbFd/Az2Q16rFSM6TUVOjNfgpG6FEC?=
 =?us-ascii?Q?tiMbC09z5i0lc5+Gn0Dv0KxzjOl7MaCAN57A1KDftRWrf9M+rOHD3/iRXD9n?=
 =?us-ascii?Q?M9sQT5rm7eWpqv7oQPBmZsoi7bO6H8P2uY/7Q7NhDsOYHSS2RhZsnUn/1B1+?=
 =?us-ascii?Q?YhYCHXXRlNTkBIjxLR2mJSghgOKboHQlkPMxSgK4ZQ6pyxsgd1qlmz4VKAM+?=
 =?us-ascii?Q?9p4uE6NivS+yPD3LrrVANPw+9BJoAJyouCypA7Our/SSLdePhserhnn545+i?=
 =?us-ascii?Q?oWo804hxsPnJENnZoJvmM+hfsxzBCDJwPIFHs9//INJdF8sYzQD3cnAr8IQS?=
 =?us-ascii?Q?o5sDizQsOVOAUW4T/24NKczem832cNb297ZDDdo2tdWKc6yF4rbhpRcmKFf/?=
 =?us-ascii?Q?1aeRSre3AeT2p8w4z9cf3ywKAJy9nHeUe9zJfZpHiPPj5tcnPnt+sD8PAMLS?=
 =?us-ascii?Q?hTzFcDqX6HgPwFM9tebVGhOLBKI4XWWdqDlp0FbXBI0OwwquO+itsP25o+OB?=
 =?us-ascii?Q?o7eB38MFzdCXCx6kE4dZeENISazDO1Jn3IftkZDU/wXNKd9Lj5GlCU56i6t2?=
 =?us-ascii?Q?bj8TMYvKR7LnOZqUNuuDtiqow9llAbpsCuVMqmyqtVTG55XArOgqvgCApo7a?=
 =?us-ascii?Q?oCH1oXkl0WIQ8DEgG+MburmV1+H28BKrZwz4P4y6tY17rufTbUe9GV0IfKlh?=
 =?us-ascii?Q?wYgcIMuom2U7iQSSg1A2WUyRGZcX3+2+Xh3Stt/qCCO8ebmc5XPKw/XoGldu?=
 =?us-ascii?Q?ug3S0iQnLob6jzNJlWtFYuqTnVYrFhm+lLVx/G4ef1teqS9SfOJAxGh7LLUD?=
 =?us-ascii?Q?GP8MB4Ps+hm+JU9J50OoYy1x11UJHCHo2U85TiavzBcp2Ae70uVSV0eu2FFx?=
 =?us-ascii?Q?+N42ztWMinQcF1LoAy3oMJbhZGOC7BpyE2HYtabI1bz+INtI+mLllWo2zNeZ?=
 =?us-ascii?Q?DwOoHVVyAF7nLfAj/6IMvlhJ89sTfBnw/a0bKq58zyPfj4zK2j6soywuJr3y?=
 =?us-ascii?Q?HSUL3p7OdCnvirDMQGihdaRtjaUxV2rfk3SNthlOej/mCEwUk5nEtPcWomvQ?=
 =?us-ascii?Q?ulzPod1lHNOD/I7Q+LBxx9cZ1kID6/WoK57m1bkV+HbHrmw2yF/bU3m5CqSM?=
 =?us-ascii?Q?nFc0XeojyN+Gl8/Qc0GXFmNM32k8fZD0w8e9lCeefq6kPoR8e0OMFguVqmBi?=
 =?us-ascii?Q?cC1VqY7BH1Rz0LWgTb7Xxy9PBG1UpaNIQUbdT5OsGK73CdyLj3gvbtjglWpH?=
 =?us-ascii?Q?c0i4mE3dLpXxD4u5kgo=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(7416014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2025 19:16:34.0570
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 060faac0-bbe8-41be-8c69-08de100d2efc
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000144.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7543

On Mon, Oct 20, 2025 at 09:10:56AM -0300, Jason Gunthorpe wrote:
> On Fri, Oct 17, 2025 at 01:12:02PM -0700, Nicolin Chen wrote:
> > On Fri, Oct 17, 2025 at 09:47:07PM +0800, kernel test robot wrote:
> > >    drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c: note: in included file:
> > > >> drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h:1048:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct callback_head *head @@     got struct callback_head [noderef] __rcu * @@
> > >    drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h:1048:9: sparse:     expected struct callback_head *head
> > >    drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h:1048:9: sparse:     got struct callback_head [noderef] __rcu *
> > > >> drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h:1048:9: sparse: sparse: cast removes address space '__rcu' of expression
> > ...
> > >   1045	
> > >   1046	static inline void arm_smmu_domain_free(struct arm_smmu_domain *smmu_domain)
> > >   1047	{
> > > > 1048		kfree_rcu(smmu_domain->invs, rcu);
> > 
> > Looks like it should be:
> >  static inline void arm_smmu_domain_free(struct arm_smmu_domain *smmu_domain)
> >  {
> > -       kfree_rcu(smmu_domain->invs, rcu);
> > +       struct arm_smmu_invs *invs = rcu_dereference(smmu_domain->invs);
> 
> rcu_derference_protected(,true) since we know there is no concurrency
> here..

Oh right, it's outside rcu_read_lock().

Thanks
Nicolin
