Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2064.outbound.protection.outlook.com [40.107.95.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE7942BEFF8
	for <iommu@lists.linux.dev>; Fri, 22 Aug 2025 21:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755899179; cv=fail; b=ZwrW6CHL7FVhzxwZgIAoEQK/Ef5E3f7YW6xO8+hIvaqwlcI6NUm2LpwoLB4XItJWZxbqRVN6sLHBMu/ZIVilFHozgKxYpr2N+21y9+E08dN2hErykXCYqPItts8ZKJZag11Zhmhd68Ydd1ud2Wcfly727go6PNPEWF2clQ+SD7Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755899179; c=relaxed/simple;
	bh=s6elOLiYtEvTIUDAh2xWlV6/zEA9q8aFi+gh2dUhvIc=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z7syuaUjyvAnU5M4j8xTGUb/cwmX7Bgi0K7NMW+Ljp4mxJPVMRit9PG8MVMWsTBMZ65U5CI1wfZpE8Xog3F6vjFbisNbdHynRh5gcrA1GxJnk63FYxhs91pKwCRHGYniZPs42S47QgaeuFWKKQri8dN5Zl+zB3AdQT+asNV9buw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VhB5DqGz; arc=fail smtp.client-ip=40.107.95.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VhB5DqGz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VXhTFchrkeiseONX9+aiX45dTiLRic1jFzQ3cCyC5zHxDkQHOkRQu1DXiOLtPIppJzCGl9mixyTDtn7NF1+zi4xCvmp/ziB1K7IKh6Wf9qAlgEe+nMBmIKMCnBNUnSDqGXx2s1vbAOsvK5QxiSDc7hCcIo6xGRuJ6Q34H8jFdwOUTAq9n7+2Gte6KJs6+T19NjlR7YozevRwH/8i3nHeLom79q/TjB3DGecaPRCKl3xjTiWXMe0TznP+DSmP2QMuPphUjTE3dnVqZofKHrRS9X+TpN8GoHMGhG0fkQ2wcVwGtqTox5xnWeH/DIzkpIMaAc6n9LLoP8PtBM903enWyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joN0AUFRBywYYtoulXZd8mgmm+Pr9V0gRcAQr6DkgKQ=;
 b=lGlQKAVW2Iz9QwF8qmWGTtdL03bBIPLlhL1VfGKvpcP0+/zdDX6oCtDuf0LJqWbJ2wWVIT0drJ4R/xRtmzAjSRbS1fkzZJlAJJ9Ikyi+SLOULN310bR7OLAy4zoiv5ZV3RhaNLgjtWGCpL7eyjP6xdrtikWqmWb3u0wyWfslgMDJgxVKEj/mId6iwHCSL9lU+bwX76KSuWGKgQsFj/ALUC3yUSjTWC/G60MW9Ci4DsP3Fy0y5s9dyYg6qwV0tUs1aN4WCWxxgM0y2XTiigkJk0eTSTa1oyqh/+60S/fSoe2gMnXS3xHq/ATxEI9Gie7GClxSltJVopOCK4DwW0SiOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joN0AUFRBywYYtoulXZd8mgmm+Pr9V0gRcAQr6DkgKQ=;
 b=VhB5DqGz0D4QWxiG4zIgZja/lE2JRbubfcfvFSSr2M5uEwzJjrHZUT2kDnLZtTgaYTTEPRpSNSVS5ZzEEAY1cJB9RZz/RDo7n4jcypgJfh1yzzYSRJ0EkL+tYIDObqgCi3bVFK03YgBG/sJLjzr6hkclyu0ZR2V8CxzasTKrag8a2t8kKqQorTtXmzwBheIWzy9LEw11YejqcLkMUy0Rs59vZjxjEV0NzjGgCLMG9owsArLGWwTX7CY3H/5+h10DCDCVfghkf2TDyzF2KfCfylKGTxImT9mOUh8E6iV5x+4i8F9TflA/R7Otm7tsGRsHSotppPMni/8NkmrskuSs3A==
Received: from SJ0PR13CA0104.namprd13.prod.outlook.com (2603:10b6:a03:2c5::19)
 by CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.16; Fri, 22 Aug
 2025 21:46:13 +0000
Received: from SJ1PEPF00001CE7.namprd03.prod.outlook.com
 (2603:10b6:a03:2c5:cafe::5) by SJ0PR13CA0104.outlook.office365.com
 (2603:10b6:a03:2c5::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.9 via Frontend Transport; Fri,
 22 Aug 2025 21:46:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF00001CE7.mail.protection.outlook.com (10.167.242.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9052.8 via Frontend Transport; Fri, 22 Aug 2025 21:46:13 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Fri, 22 Aug
 2025 14:46:01 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Fri, 22 Aug
 2025 14:46:01 -0700
Received: from Asurada-Nvidia (10.127.8.12) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Fri, 22 Aug 2025 14:46:00 -0700
Date: Fri, 22 Aug 2025 14:45:58 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	<linux-kernel@vger.kernel.org>, <robin.murphy@arm.com>, <will@kernel.org>,
	<joro@8bytes.org>, <kevin.tian@intel.com>, <jsnitsel@redhat.com>,
	<vasant.hegde@amd.com>, <iommu@lists.linux.dev>, <santosh.shukla@amd.com>,
	<sairaj.arunkodilkar@amd.com>, <jon.grimm@amd.com>,
	<prashanthpra@google.com>, <wvw@google.com>, <wnliu@google.com>,
	<gptran@google.com>, <kpsingh@google.com>
Subject: Re: [PATCH 7/8] iommu/amd: Add support for nested domain allocation
Message-ID: <aKjlFt80ltp3mjcp@Asurada-Nvidia>
References: <20250820113009.5233-1-suravee.suthikulpanit@amd.com>
 <20250820113009.5233-8-suravee.suthikulpanit@amd.com>
 <aKjKJhblxtnlrrPG@Asurada-Nvidia>
 <20250822211618.GF1405994@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250822211618.GF1405994@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE7:EE_|CH3PR12MB7548:EE_
X-MS-Office365-Filtering-Correlation-Id: fa182fb9-6a7d-469e-3931-08dde1c5507d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MMyc10EVEMkJlubuJS15A6Ng7rGl6uGwQcCu6VjgDkXLjeX48wdWZbmndJH1?=
 =?us-ascii?Q?ulbRnZJRdVQ/PnMyn5DGIT6L8AjSShgV1QRR6XDPdH/aoS+i/zTmGMY+HvYF?=
 =?us-ascii?Q?fcMReaYkMCufxHH1PU++oOM3wpwq/Pfp3g7N99qE/kqDhXbGH1Jvtc7W+ZAb?=
 =?us-ascii?Q?0wZJ5ooCEWaOqlz4Mpk6lxfDMyVlvyEZR0q1K2NKkkTG/U6Pju3P7Be4tx1p?=
 =?us-ascii?Q?7z4T+FcpKPGA1dPG1RLa3SZH6c8LC25hguTFAHj3QPUDFMsUQ77nsQd/kjRQ?=
 =?us-ascii?Q?J2ika6RGxVNxw8lqbty4gy9jXV0V175+obFmye5Rfbnnk+57PVEr2HmRfTZl?=
 =?us-ascii?Q?KKs6VzIxPGsEl5lqjM6Sqhlt89ykGS9nPajAIP405nP9SA+NNGkohHddDOq6?=
 =?us-ascii?Q?OB2f5QTIZSiNBapavVt/uym3snFYezjdzUmaGnJ8F6Mf68f7pirT+qnB74gB?=
 =?us-ascii?Q?CfgHqRgpSg3nyWNeQCzHE8v18zxmQ/3FBJk6B8LuJGtiLv/UfF5LhnTUjk+q?=
 =?us-ascii?Q?kPs/Bd46kAe5OSzk2eROCXWiBq6gHRdBM+fwm5Byd2SvD9/B19M7TCi0wSPF?=
 =?us-ascii?Q?zSGHJBnfOyDIDCDm8eF7JWRiZFkG34BSgthmWhb2jaaGJw7MiyXADjWCEzAD?=
 =?us-ascii?Q?fxYRttEMvquSaIwP5GYQdFnQlM8dXR5d2jnJfP/qkcS3P+QVukCEJj5XxhpV?=
 =?us-ascii?Q?1hJSGwYuCbvvs8YhI1OTqKAyRdpUXf+N9lLglcecUIQ4CNZnMzhvI++Iumu7?=
 =?us-ascii?Q?7OsdFrTwx7I/DBOYTN4mxumSNJI8Wz2waCtb9q/k0O8jgz+KQzEtzZQLpQRd?=
 =?us-ascii?Q?LypkpfeYKIyje+jGf+56WN9KF+gbjKzg/MULH3z3dbtoPISrS7tx9OQAEevR?=
 =?us-ascii?Q?CRHxR1I+7IIjLH9oXCBclcVeyoct/4xWjr50Wf/WCD7E6Y9P77omXet762Jg?=
 =?us-ascii?Q?6/6BsB2hBL5ngau+gmbq0DnHBuI3USVGahsVVl2h/54f5nub9eBcJ+fszEsc?=
 =?us-ascii?Q?C318g00KxS1nc/0HvKQM76bcWxGo7uQj5gSQ5jHmM9MOeSW3SfTUW4F5sqoq?=
 =?us-ascii?Q?WXMdYjBDTelWo1b7ViePF3dQJRneX2r5XtAwtkr70eIfIdEm6FRWVBAYW7wk?=
 =?us-ascii?Q?aySz7sFy6MezikJHWYTfZ9mXM0shECLGIu2A4kHTbPf7+kNkbW8mwFErGAoP?=
 =?us-ascii?Q?81yyr0zlJRY9VAzAcs95nYUmgdCmvSpuM8e/4g/ztD+W9RIfB7qLliIXqvUZ?=
 =?us-ascii?Q?pcrdNAFaYEB0Fe/XzC4Ob1pp3sMP1gEbWU8IZw6b/h9Ox7mZQDDY/i0qaSyD?=
 =?us-ascii?Q?XInWkO5s5rUKIMlPUf6F8MGCK8YOGn2xlFIjr5vXFQ12xU6Lrhax4yjlmsQv?=
 =?us-ascii?Q?XT1eMhOMynZz7XrdIRtyBZ4C91I6u0nWJVy33zxcQ8JR+CkY4lfZJtjEr5eF?=
 =?us-ascii?Q?lFPf0qz2WG3EoRjG+ybygR9Td1HUEnb6kOt2tu8d32AJ3rItLlIbZlhYIqUO?=
 =?us-ascii?Q?4pkUsl9vaCaBSYBNwbqB45gJvZ3ifNgjrjJG?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2025 21:46:13.0363
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fa182fb9-6a7d-469e-3931-08dde1c5507d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7548

On Fri, Aug 22, 2025 at 06:16:18PM -0300, Jason Gunthorpe wrote:
> On Fri, Aug 22, 2025 at 12:51:02PM -0700, Nicolin Chen wrote:
> > > @@ -3113,6 +3116,7 @@ const struct iommu_ops amd_iommu_ops = {
> > >  	.release_domain = &release_domain,
> > >  	.identity_domain = &identity_domain.domain,
> > >  	.domain_alloc_paging_flags = amd_iommu_domain_alloc_paging_flags,
> > > +	.domain_alloc_nested = amd_iommu_domain_alloc_nested,
> > >  	.domain_alloc_sva = amd_iommu_domain_alloc_sva,
> > >  	.probe_device = amd_iommu_probe_device,
> > >  	.release_device = amd_iommu_release_device,
> > 
> > This will be an HWPT-based nesting support, v.s. vIOMMU-based.
> > 
> > If AMD wants to enable its Command/Event Buffers, I think this
> > should follow the vIOMMU model instead.
> 
> I've been expecting drivers to do both, like ARM.. Nested is the basic
> infrastructure and then the viommu changes what domain id nested will
> use similar to how ARM constrains the VMID based on the viommu.

Hmm, we haven't implemented both in ARM but only the vIOMMU-based
one..

Yea, AMD could start with the HWPT-based one, but that would need
an invalidation op(?), which seems missing in this series. So, to
support direct invalidation via Command Buffers, vIOMMU should be
the only option, right?

Nicolin
