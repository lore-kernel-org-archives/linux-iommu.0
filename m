Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2064.outbound.protection.outlook.com [40.107.220.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C50036AF5
	for <iommu@lists.linux.dev>; Tue,  6 Aug 2024 16:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722963069; cv=fail; b=eP4cEEooqDlqJdGxj5SogbDaJPr0mZi0Cx+BhSBdTR/az7ZhZ0+HbOrOBeGt/2Nj9MNgJCcSNXf/txhyOVKQAqU1WqVduXK01+1c+bEHU7mccpCi5TWD+h6pciEK+v+WadODqq7vN39hIPC1DCKvg0ai6/lOM1QksaDEid+mp/Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722963069; c=relaxed/simple;
	bh=CoKOzNvzx2Ac3DZ/5FS13ex8AuVY1TD6DVjYza4G4L4=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lBmrtJ2HRKx/p6U0+ITLYy9eR1w5hmniFuesGNTixkjCITSR5RsR8UiN6zqjh+n3HGD9rSeExhobBSraRhelQaE7e8vB25ZYNHtqa7TVb8kfcZ6aZh9iZm0LGdyD+MI1Cp87KzacVY8Y32P9XndX5gVsEv23NuV4XHhmoc9arR4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HpPl60oI; arc=fail smtp.client-ip=40.107.220.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HpPl60oI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PiDSjIM5ywDhArjHg+3xLkaBJvAIYJoP5PS6H6EX2aS5F3dMcuaxcDE8Fx/KWcQ2wDL/iA814UBaWek9/8llahdTl8En9+Woip/98g2SsfNBekEsTLDCzHow96YGeeKfLdvZwmzPdHEfyzJcG5yOEgbgvSYjaLgd2JVlD6sFye+CaIaf917RAqAwtcL9s8aLedSstN0EXfTB/p+9jWnFeVa/B5mUmNc/VvCrqMUmztgXdWiigv//NAnE9aACVmCMM0BkszmMsTBqWck+KCY51SAOjGYRlP5QGLeqy09dsAs4rCdQ0V/ZAMwdbR3idtbxC5Teqzd8iZ8DphiFtjJrcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MRyHeG2xlVcgGbeO3r5Lg1VfmVo2bDZbnMS7O4wMmz0=;
 b=t3PbivQXjMGggvPzH1LdoWzk+GKB4qVDNwC7KcGxnU2nn10Hfo1wpWi+rz9C+oXGxVkz7QS4vXtpR77SL2+O0mfC1j4X3kOAeOC5gPiSPrrwKhJ/J9OazFXyS06LofY8wDhE38gkwStFN1ffSR+IE8mYc5cyfD8gHq3NPyk2DzQtv1IO3skreW0ASdEd/mJOniWzu6mDNF/f09nQzUepUxBUpphj0SkLQ317waFyZh+dG3R/ya++ICBux63zS4PRIp1h9yx/M5FOXjmZZCjeyjKfaWniYtgnnkkq81IrZUPWciXx3Ltrv+r8mmDMCSe7/sV+ZfBKoylTOiw1tea4jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MRyHeG2xlVcgGbeO3r5Lg1VfmVo2bDZbnMS7O4wMmz0=;
 b=HpPl60oIi0eZSCoJVPYEHr8fI4bU8DbFWia9/k8W749K1UH+mjkaQHgoDXlAg4G/75jbwNuyIdFzUEEpP+g2QGyz52RDF3hkqdYbcQ2luyzvjVc4inijdnRWdjShG3zt7FOJarPEb1gVCCoIUsqexhJlvhY0wcXQ0sFhokEV7tvmHnbpaKaL10r2ykWpiLRxOvD76OWtmAmhRGSgL3mFb1rn9pCS3AnUNQYGCmQlCwDoWm0B9AvOci7lIZxQTT3MTtelmKZOM2mf2gsYpVqSzDPQmrT9wNOe3pw1jX1x7ALcOhIh4wJ4leFLWHBhfHLUkHxqgUrmuiJ0etxogpZfYg==
Received: from SA9PR13CA0095.namprd13.prod.outlook.com (2603:10b6:806:24::10)
 by SJ0PR12MB7066.namprd12.prod.outlook.com (2603:10b6:a03:4ae::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.26; Tue, 6 Aug
 2024 16:51:01 +0000
Received: from SN1PEPF00026367.namprd02.prod.outlook.com
 (2603:10b6:806:24:cafe::3d) by SA9PR13CA0095.outlook.office365.com
 (2603:10b6:806:24::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.6 via Frontend
 Transport; Tue, 6 Aug 2024 16:51:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF00026367.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7828.19 via Frontend Transport; Tue, 6 Aug 2024 16:51:01 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 6 Aug 2024
 09:50:42 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 6 Aug 2024
 09:50:42 -0700
Received: from Asurada-Nvidia (10.127.8.12) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Tue, 6 Aug 2024 09:50:41 -0700
Date: Tue, 6 Aug 2024 09:50:40 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
CC: "jgg@nvidia.com" <jgg@nvidia.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] iommufd/device: Enforce reserved IOVA also when
 attached to hwpt_nested
Message-ID: <ZrJUYDCxWJQCfOQA@Asurada-Nvidia>
References: <20240806050201.3717816-1-nicolinc@nvidia.com>
 <BN9PR11MB5276C2F39301A461FF84EB368CBF2@BN9PR11MB5276.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <BN9PR11MB5276C2F39301A461FF84EB368CBF2@BN9PR11MB5276.namprd11.prod.outlook.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00026367:EE_|SJ0PR12MB7066:EE_
X-MS-Office365-Filtering-Correlation-Id: 4bb596c8-ca3f-4fcd-746e-08dcb637f40a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lwW8aRVwIrpYfo531GNyNvZzKg8WteDQrm2DF1r6s+3N49s6NNJbdmhbOJ55?=
 =?us-ascii?Q?sS7RjZBsvyBeODJyiipHkyjBnvtOn4VScH/RiyLYM1YAQ8N3OwT1w1BcvxkR?=
 =?us-ascii?Q?xIGn4PaDtWgggcDAqsdCGysXIOSzS+aeNstW1naHxv++QEun+mSRVr2pS9wQ?=
 =?us-ascii?Q?4chq6BBHKjGaV9t3aMN7UeEwbhK8DxJ7+0npIsg35rLLo+QDDI0eVVQc2Vfs?=
 =?us-ascii?Q?Mvb7Fyvvo4ndftrks3lDbDugqSfu/Ky/n9zwhkh5m6ECBtsBO8ttFddYvbiO?=
 =?us-ascii?Q?pFEoFSQXSac9i5rrnyNIqfOcpE5Ek2HzcUs8zEZrG+3jYhZ+CEkkQOaf1lEK?=
 =?us-ascii?Q?jFCUGr5WxeieDvAzHfosHG4vxOr61+0Aw4tgldavThZZAcqdCVO68c+SHX7B?=
 =?us-ascii?Q?sEXjrhfK50U2N0CUuJhgwJ8DQCM+De3SHfIfwlstUR490qKTqlHjUCaCZn7Q?=
 =?us-ascii?Q?ArqjUzp9h9GF8vNjpeeUs4ol3JKPkBGb7XWDoj2hlXYUZ1mgkNzB+6H8VAnz?=
 =?us-ascii?Q?uKEQKrcn9y9nbd/6SCHRMszw8sI3hZC118i4kgeK0mM9V6BtKIiNsDhGPNCC?=
 =?us-ascii?Q?sSRIpX5CzyGDupEWH8zihMMj4Ksg+ONsrYFSZ+Bf43Uy55BQE7XXeMHOljZm?=
 =?us-ascii?Q?7gIni16lBwjrwbr6R9e4b3huP+rSJ3RUz9nc3wjT4CPpf5bxChPFgGUYMICA?=
 =?us-ascii?Q?Jy/fsORKZQSreIOsZrBSZEtr0jMTkMy4dbd6FP1KyYmJ2dVAWz4O39QBbydr?=
 =?us-ascii?Q?WAajGrRj6xJvjDsuXPrK5PrQOJZfrwT5MKfoTYXbek+UIcd02hscAdhmY4uz?=
 =?us-ascii?Q?4C2HnwkbE2xakzUXJ7VcOig+x5Q27Y6I0AOPOIohB0kx1UnEMLo4sU/3PWE0?=
 =?us-ascii?Q?7OqGd0lsr0atDm0YfoCjs973I78wrSOlKvnG5xCrOc3Jj54TX8QHY7FBetFJ?=
 =?us-ascii?Q?OiZ8JaioAOJ4i26YLvctFe/l+1+QjcLBGogDy218gR2L/Wa1CvLzUEsARTsU?=
 =?us-ascii?Q?RUrBRhfwa5t2QdMCrXwU8NfY3dGwE5/gbBUYyM4IirhUbG2OMuGyYaUbuJ1K?=
 =?us-ascii?Q?vy3pzsfQpooWrcoyvS+b1gq/brCmRH5ad6s4dNu6UL99cLcd/fBmUbU5jXYq?=
 =?us-ascii?Q?84JnDVAbA/gbUUOOa+o1J7REHTvBFihAcz4biSjM+TlX/TgTDhwIk2mvfAcY?=
 =?us-ascii?Q?iUfmj6geWODmOVHjMka3iDIy5+29nCN9TzpZV1jISGSuzaPjHvdBrZgYFgYZ?=
 =?us-ascii?Q?PS3MzhXXrLvFMdAuHXnG86UkGmQOibpAcSyE26B8gD/JMmJV7tUcKOUW0B89?=
 =?us-ascii?Q?2Mke2kjFvgUpVmhmNwVnq3lz0lm68SKDdP37h2yBli0HQ58cKpVb3loc/s11?=
 =?us-ascii?Q?jvdvErWdlZbGJ2qrIxn0YvrC5RONFdr07x5Yz9e8SV4Velt/2Ug/0W+MUNKq?=
 =?us-ascii?Q?6FXTiPvoOlPrn30i3BdEzS/zNmhaibw/?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2024 16:51:01.1206
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bb596c8-ca3f-4fcd-746e-08dcb637f40a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00026367.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7066

On Tue, Aug 06, 2024 at 08:08:49AM +0000, Tian, Kevin wrote:
> > From: Nicolin Chen <nicolinc@nvidia.com>
> > Sent: Tuesday, August 6, 2024 1:02 PM
> >
> > +iommufd_group_do_replace_reserved_iova(struct iommufd_group *igroup,
> > +                                    struct iommufd_hw_pagetable *hwpt)
> >  {
> > -     struct iommufd_hw_pagetable *old_hwpt = igroup->hwpt;
> > +     struct iommufd_hwpt_paging *hwpt_paging =
> > to_hwpt_paging(hwpt);
> >       struct iommufd_device *cur;
> >       int rc;
> >
> >       lockdep_assert_held(&igroup->lock);
> >
> > -     if (!hwpt_is_paging(old_hwpt) ||
> > -         hwpt_paging->ioas != to_hwpt_paging(old_hwpt)->ioas) {
> > +     if (!hwpt_paging)
> > +             return 0;
> > +
> > +     if (hwpt_to_ioas(hwpt) &&
> 
> this check is always true when hwpt_paging is valid.
> 
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>

I can drop it.

Thanks
Nicolin
