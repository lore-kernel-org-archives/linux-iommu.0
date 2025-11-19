Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012067.outbound.protection.outlook.com [40.107.209.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BFB617D2
	for <iommu@lists.linux.dev>; Wed, 19 Nov 2025 01:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763514670; cv=fail; b=lppoNKscBvJAUCaMaH7FWNL4QorY7LjgBS1olwOC3Mz/k8Z/HIOwRY7NmhZ3HNSySh1jqbEnYWeKQ5WDxdlhDrl9nYDpvB7HlkAhpNHJEJo9Y8I7A4kmYVVkBgBrsYwBgAq2dQN9dPnzEgVexuYlg0tKXrCRg8gDR4gvCQx+caU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763514670; c=relaxed/simple;
	bh=Lfyyo/9A2mIrEhmqkoO46FH/QQ2kgRAmSwkurnXiIxc=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b1LwmIInwzZYOyJ5Wm7g+Ln9N3jSTTJfvuuKZC6im48b4itv8KLWauYpmkcm90v5M9Y/iH38NifsMHflnpXAugoqq/2NQrTBN2SIQDMPKICShIlLPIGMQNQbtwuAnrhNwPUobVw68zCoVv4h0Qs7IzULHqP5WLpVNcUvSdNIz0g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kA6sHQV6; arc=fail smtp.client-ip=40.107.209.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kA6sHQV6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WxqppHEZENDnjrxuPKhUFrcNJnkmS9M/9uwJ2iBw3TG+H5mUVL9ELmdT3hBzgQZSdZ2LF+hajgrCDlOqmDBHU/nQhhB8yo6BIKLSjnSpueYvxEnyJ3zwEi8Heqh+zSznqWNPZklP9wLvilO2zJURzTnjqLyHnhk03GJr5Zng/LoVyosPbKmloEZZXM5eJw79n2FLPfwnDcwjrm4+40/7FaydLz/dmzXSoRokVcvjCeoLCXQB0fDELqBFlWoGvU8Ba4oKLH1EsAgYbW8TK9/HGk/53gkHue2ZBL7rcWwe+R+a8vfKad2V1Q/VtQ+j2DZQQlGNOdLtZPpP8/WPgK/A9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TrMlTepv6SUExmHTUlJwf9+tc5n/YI9yzRtcoCO8TeY=;
 b=dzIgaKy3RR0xN29ajBDr5MQKfaVRzOp4bkM1vd9A2PofvMRVGN1nk7C+XWm09wCGurnTb4CV/1vYqb+BrGMRhUGwxH1iARAJfWdIsLwqKlMun2xdOtPtFy4Uxqyinfjp2xxMrpJzrO/jxTiJ9mT+J9SOhQFSe1GT6gTKwST7Hp4KS3+7Y5ojOQ8oyf5vPEOZtz+dNAnsJILtOk/1q1E2phxFYlLjnRWPaX2gc15Uc//Xvcjj8jOe63qxehi/dB2UHboyrq7FiY/CPlTQ16bpkZ1HIoRqY4IFV64cXGiCQfpvRzfNVbqM+FunKRA8ZGRvl0h3WAkvRR0H+9lC3NgIRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TrMlTepv6SUExmHTUlJwf9+tc5n/YI9yzRtcoCO8TeY=;
 b=kA6sHQV6dEyDgrwQbl3h52ZGrGVCVBQ9XtEwzbux259UyC/dEIFD8cWshH0hva2SdNECSs5G1u9B/4GzfW9f1X89act/xr8yFH43ZNw1iIx6BUGnXzeiyivcQPEyPXPgVQ0uCXn8isNdRhnAbGHCCtkLRIuoWaDnFKE/M/qbDjkbnelzyu06rAelqcTpGLXE0qjsx+P1fcpVgAdCurVjoKFkxt4Mloa2kg0DjFMDGZQW2VBcHSV44jDj2aCGYVJKLjPoI2ufCGRW1kYwbSR/z5wGCFofpcHfg826NC/R2FNRzoT3drGcbFlV0On/MaAXCBty/4VK5cEG0IWVaIZ8jg==
Received: from SJ0PR13CA0051.namprd13.prod.outlook.com (2603:10b6:a03:2c2::26)
 by BY5PR12MB4308.namprd12.prod.outlook.com (2603:10b6:a03:20a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Wed, 19 Nov
 2025 01:10:56 +0000
Received: from SJ1PEPF00002321.namprd03.prod.outlook.com
 (2603:10b6:a03:2c2:cafe::60) by SJ0PR13CA0051.outlook.office365.com
 (2603:10b6:a03:2c2::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.10 via Frontend Transport; Wed,
 19 Nov 2025 01:10:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF00002321.mail.protection.outlook.com (10.167.242.91) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Wed, 19 Nov 2025 01:10:56 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 18 Nov
 2025 17:10:36 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 18 Nov
 2025 17:10:34 -0800
Received: from Asurada-Nvidia (10.127.8.11) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 18 Nov 2025 17:10:33 -0800
Date: Tue, 18 Nov 2025 17:10:32 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	<linux-kernel@vger.kernel.org>, <robin.murphy@arm.com>, <will@kernel.org>,
	<joro@8bytes.org>, <kevin.tian@intel.com>, <jsnitsel@redhat.com>,
	<vasant.hegde@amd.com>, <iommu@lists.linux.dev>, <santosh.shukla@amd.com>,
	<sairaj.arunkodilkar@amd.com>, <jon.grimm@amd.com>,
	<prashanthpra@google.com>, <wvw@google.com>, <wnliu@google.com>,
	<gptran@google.com>, <kpsingh@google.com>, <joao.m.martins@oracle.com>,
	<alejandro.j.jimenez@oracle.com>
Subject: Re: [PATCH v5 11/14] iommu/amd: Introduce gDomID-to-hDomID Mapping
 and handle parent domain invalidation
Message-ID: <aR0ZCPcxZBV9iUVy@Asurada-Nvidia>
References: <20251112182506.7165-1-suravee.suthikulpanit@amd.com>
 <20251112182506.7165-12-suravee.suthikulpanit@amd.com>
 <20251119001151.GH120075@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251119001151.GH120075@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002321:EE_|BY5PR12MB4308:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d2aa5f8-0f3c-49d5-4bdc-08de27087e6e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|7416014|1800799024|82310400026|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jMZldd/28YvbstOOvCTYviren3kxadMYJTaf9i7ffklpo//1i7IaTZsG9lUn?=
 =?us-ascii?Q?YsZzmKJBiuay8+eOcTdkA48+YPdbutVtcotaCbXFex5cIdVoD5tXdkl8RnQN?=
 =?us-ascii?Q?tt/dAaMqNv0X5zvYXIufjnmTlsFBZimRG0a/RZ1WWlD6go2cNk9rFX4sVYvr?=
 =?us-ascii?Q?8zVDr9+JQLqwEtKiP+IkmblDH3odM7JpJ3eqbWqXeZiVyq7zXKTvvr/K8tMZ?=
 =?us-ascii?Q?zTVZPWa9Hi3p3dKNpplZOcndrQGQexIrijo2FxHynph4UnANEWwpuIp/HZO7?=
 =?us-ascii?Q?TaJcRJG/VPeIzJIRufG/7AJzspbmKDdn9kVcnNvP0AAEaL8+F3mWGYI88Rl3?=
 =?us-ascii?Q?3szcD+R80k9CXPuEtAXE0H3ShBa6+JNjTlMyTqhHZSHjXYAIBnLs5SEVmqMK?=
 =?us-ascii?Q?pqWg/5+GolQHFOH1SSdqwpUt0MLhaCcuNt/nCHA3s4oEv/BT256m8ZPiY+vb?=
 =?us-ascii?Q?90KZlpfnKUJh1uw9zlmd1Kbsrwn/p22QyrGZZHPbYb79JbldUiJUbB37yh48?=
 =?us-ascii?Q?Ctapmy/23j2Zr2Goe49xS2fJqWO57imJHIkNIdCohxBAn3JASEmmabQDsMGK?=
 =?us-ascii?Q?JUgU1VGQmTI2SDE/auBoZJR2YnU7plh91i0YS1xQYH5YRwgHC+x0FJHJtbHz?=
 =?us-ascii?Q?f0wzvkf5U0Kbf2Uls+MiNwMZ4CMlfGg2dK2+OvjUejlvIxS0iI9tTgat910E?=
 =?us-ascii?Q?f+kdVA09iR1/qveWA2bQIdVK13iBzW293O+0y/IvQg8Rhce5MmyyRIory1mM?=
 =?us-ascii?Q?I5SUhX3lkN2EcvDAw0mtW8UtSU3tMHxRIBOmE+mgnOmNFXV7zkkM9FNe4kJ7?=
 =?us-ascii?Q?+vcnUyeFPt3uPXnaPPKiBfIiK3sB+1P1OnCO29cUH3yHCB2yK7rLA+AvkHeZ?=
 =?us-ascii?Q?e4wmERRUM0JsFIGJeRuyO3VTNBulTdXgEXzoH1xndUO3K0moAkfRWur7yZAZ?=
 =?us-ascii?Q?T43fBW+O4AKh6d1pPi2LEzCUNj+aCQOxGiIlwIT9N3EIslTfAaWsKIdE8HRi?=
 =?us-ascii?Q?0eZf0iuBqahlzo9bzzTlHvjP22u/hGcl/uq/AEk6/dYe2voE9EqeQUzVGRtL?=
 =?us-ascii?Q?s873c4hGM0XJ2an7kVzfVcwTedcIZWWo1DgZ2GtsgtVcTpTK6R1tJmZ0p1ge?=
 =?us-ascii?Q?79rec83i4umtzbbOljhwjaLDRMPPswq5B+/rjg/mMl/rd4Heh3uKVCUs+TmX?=
 =?us-ascii?Q?e1PoM3T8A9FSNIT0LLdhzPWB9opFGW225DcZm1lm2IfE7FmQtBwcW9v89z5q?=
 =?us-ascii?Q?D6+v4y7xI60pNmCQjkTcia8cDIu9v6h7GWLD9gokWaJTj87K1hXoZveX4sCl?=
 =?us-ascii?Q?2vJOKCWbJ3zzw1tNYsEv7gXlIwpUqThOuFqw74iIhwrtNGbffvVI1RKyCLUI?=
 =?us-ascii?Q?YCwpJYRp7UqJgD9FGzW+sttvyd0gn0bBGCau7DbGgUgiOcv5MJG1UZrtJjWw?=
 =?us-ascii?Q?3Imclv6u8hv766WPa8DDmWL4umfbhQsekjT0m9fDHZ4Lr5gVzzopyFWcceVC?=
 =?us-ascii?Q?81ggNAYoGxeSOYiD8GWU+uMllof7a2mm9W2I8Wz+dqWlGpvF3oMsgR6LKJTB?=
 =?us-ascii?Q?d3GDc3HCsEnzG8Op2tc=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(7416014)(1800799024)(82310400026)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2025 01:10:56.5246
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d2aa5f8-0f3c-49d5-4bdc-08de27087e6e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002321.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4308

On Tue, Nov 18, 2025 at 08:11:51PM -0400, Jason Gunthorpe wrote:
> On Wed, Nov 12, 2025 at 06:25:03PM +0000, Suravee Suthikulpanit wrote:
> > +static int iommu_flush_pages_v1_hdom_ids(struct protection_domain *pdom, u64 address, size_t size)
> > +{
> > +	int ret = 0;
> > +	struct amd_iommu_viommu *aviommu;
> > +
> > +	list_for_each_entry(aviommu, &pdom->viommu_list, pdom_list) {
> > +		unsigned long i;
> > +		struct guest_domain_mapping_info *gdom_info;
> > +		struct amd_iommu *iommu = container_of(aviommu->core.iommu_dev, struct amd_iommu, iommu);
> > +
> > +		xa_for_each(&aviommu->gdomid_array, i, gdom_info) {

> This is kind of painfully slow for invalidation but OK for now, we
> don't really expect alot of parent invalidation traffic..
> 
> I think after we get this landed:
> 
> https://lore.kernel.org/r/cover.1762588839.git.nicolinc@nvidia.com
> 
> We should take a serious run at trying to make it shared code and have
> AMD use it. That would resolve the performance concern..

Yea. I had the same feeling when looking at AMD's patch, and
realized that you did foresee all of these.

I've started work on the VMID sharing using the invs. Perhaps
I can add some patches prior to generalize those helpers.

Thanks
Nicolin
