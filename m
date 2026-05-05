Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010000.outbound.protection.outlook.com [52.101.46.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 487C6495504
	for <iommu@lists.linux.dev>; Tue,  5 May 2026 21:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778017491; cv=fail; b=KEXFVBesmGJ7KnUF2wuuWmDI5PbZxnLo833SXWpzSGcWifYp0bTT3QIZW6LZamcJ1tPNzeMCZdFQ+WLjy3eXyEo6e5PK5HLN5Y3LEOtIt8d2J22m5V8gtbnEjMFauhnRxd6NOVOo4AQ9OfaNQt2miyxo46hn/nDO2J14CDX+wvg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778017491; c=relaxed/simple;
	bh=VBmlt3XMVwFQzPwEPfmIZoaxQk/qP+s+yhoComt9K5w=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eWOUMrensC1aoyusu+uppKqYjnYXMF3olXjHq9r/H1N2zrg/fZGpAd+djDCPqpSbkzsmCCyTpYAXCku1x3pv49PkEQJZsBxfDjhuEHl7JPJYC1GxpftOnuahZzRzN9IZ15MYV6lHf5uDQg0YV8rR5TbH39jvoSBeJADA1JIJIvg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=aYc4ezII; arc=fail smtp.client-ip=52.101.46.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="aYc4ezII"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H1fefR1MsG8rEw5mzksqC+IhbSvzkhtxJ0G2I8XPc07mOjfjebszIxM57G8RY7tukyFmG0cI6QKuTXgtM0l0HU6dRKzg34oEvf5RZ+v7HAnlPYNaMTKZ21wyIG2QTUrFhwvBS8t62uuXpbE7/dnXsDfFRJcCv/GgEbwGOKZo5agIq8IEPLH2KxQDGNuFqmDIaEc5lQOauXaHIE0TUPxnwRWJgiB/iA0MwVUPVlbhTHpKPt9rolRLwfzh5YUbRgN9IWl7AzHmseoo5COVfi3aJdsOxQFyq0+S7IYDK6tEOXxSXRrpavb8Q4Id4b9LK2799SlT3wL53KbFqQqmoqeJkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R+kg6JwXPCF0Am+lYiDknhP6jQMM4864KhdgkOBkxts=;
 b=ifq5nF8f+X6E0d4b/i/tTyHmihCggLmOe/H7QxxZ2VgbzALsqV7uNMzcEGvGeGdZ0SuJgWr3nA+Ndo8Z4AJELk96eX2HOSoTWtduxtutH6g3SKNHpZqIyWuwWseOG3FzOmTNpBlALVKuYP4hfaLM6MzhOdt2hKb80MxYO8PwRaENdNzYcDZllL56MDe8U+AU4c4FNzhZ4IT6ktBegNOX6pm8hQESYea9H1OghBQXZCgZFUP12glSPSQFFZuGK2llaTTXFN3TmzRGtIzJKVnmxnjXCI6DXZkfooSgDJwAE1uL9z189C1q+MPSU53Mi38KnU0ktCjkEil+bn5YPqVpEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R+kg6JwXPCF0Am+lYiDknhP6jQMM4864KhdgkOBkxts=;
 b=aYc4ezIIEgizRvBq3MiPKX9nkmByyZ68TTDf7R8+pnpHAtsBsaUz1s8afw5ELN5sl720hXZQU+CncJizCh9WGZzl6u4yk8FP9lrGcF9AI0cw6+UIs9NoS66kSlFYBzg8O32JJz4+y8z/OjIYRviJQhBDsMtF8lLigWUEkOPOHvjJBelpeN5aVOvaznpgv1HXvP8Hb85MtxaodQOepJrwhaNSgU/sv931rpt9I7tM2JDw1Ih9RXT95rcNNld+C9YT+q33tY/fTBQ3hoirSxZrc41IdhRDRF1FuyToCokyTmsMTKDYPrkdPQX88eCBfJu+X8sRzc8+SxnnyORisnublw==
Received: from BL1P222CA0014.NAMP222.PROD.OUTLOOK.COM (2603:10b6:208:2c7::19)
 by SJ0PR12MB7081.namprd12.prod.outlook.com (2603:10b6:a03:4ae::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Tue, 5 May
 2026 21:44:43 +0000
Received: from BN1PEPF0000468D.namprd05.prod.outlook.com
 (2603:10b6:208:2c7:cafe::c1) by BL1P222CA0014.outlook.office365.com
 (2603:10b6:208:2c7::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9870.27 via Frontend Transport; Tue,
 5 May 2026 21:44:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN1PEPF0000468D.mail.protection.outlook.com (10.167.243.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Tue, 5 May 2026 21:44:42 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 5 May
 2026 14:44:33 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Tue, 5 May 2026 14:44:33 -0700
Received: from nvidia.com (10.127.8.13) by mail.nvidia.com (10.126.190.182)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 5 May 2026 14:44:30 -0700
Date: Tue, 5 May 2026 14:44:27 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Pranjal Shrivastava <praan@google.com>
CC: Jason Gunthorpe <jgg@ziepe.ca>, <iommu@lists.linux.dev>, Will Deacon
	<will@kernel.org>, Joerg Roedel <joro@8bytes.org>, Robin Murphy
	<robin.murphy@arm.com>, Mostafa Saleh <smostafa@google.com>, "Samiullah
 Khawaja" <skhawaja@google.com>, Daniel Mentz <danielmentz@google.com>, "Pasha
 Tatashin" <pasha.tatashin@soleen.com>, David Matlack <dmatlack@google.com>
Subject: Re: [PATCH rc v2] iommu/arm-smmu-v3: Fix inconsistent ATS state
 tracking
Message-ID: <afpkuz31tGtCZ2rT@nvidia.com>
References: <20260504163842.2692314-1-praan@google.com>
 <afjfBi+vw/Ywkzid@nvidia.com>
 <afj0cyBZwkVLyIwK@google.com>
 <afoWrn/RXxDmcHsS@ziepe.ca>
 <afpRUaciIEGvD3Bi@nvidia.com>
 <afpfwwmUeNbs1juV@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <afpfwwmUeNbs1juV@google.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468D:EE_|SJ0PR12MB7081:EE_
X-MS-Office365-Filtering-Correlation-Id: 743b444b-df6c-45ed-510e-08deaaef842f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|82310400026|36860700016|376014|1800799024|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	Qt9n3XxFvfcepJaO9a7vALRikJhmTB0c5L3CI0tQVl8rbSQWKVE8V+geXK7O4077oEWQn0b0wxlQxkVwIDFy8+k7tCzYWWkughaBvh0oaoC45uUdaCA4+8s+bonIAM7wScYpdfK/QAniUvrMdDV8xXJQmm1fEBnsAyqav1EQ72Ahcpfcw+KXVAc8agYqgHSIGyBKo9GZWK2M1CVoDtBsfaOl9iExyxReWTG8yUFOtScbC6/itJJpJr1kApkp+eRCvtbj6twFDVBTovP++aFCIrwII1sRxdPE6C3Y0rgzutOa+7gSPHzEuYCgB/m+WPzc+0k9wym4G70yYNqA6hQzk5a5sH+yz97OL6ExLF4FB7vXsEdoz3kNywLk3Vn6j4lY0YnzhOM7YtLqSPNRDVJR1T7M5ajb38sEsFnTB7pczT5briueACIYLcmY6IVzk44EFZdbLJYn9SkltDdBaZPjzKkiisPu5baM70tMQwZz74O6Ka+IamPLQIVHX2HTzoijN3RzwvuY+bciGYsuPK0wWmblgjB0GeJd9Q+spHgBLPvmOCnLCTJjhwu12z00IHx2QwFmExKuZKSIQxW6uHiR6m9uKb4P/mxTCapKfKNNeV/RMor2dYN10oc/w1h0qqbQOo4B3IMk039yzIlBQSd5cbvuX5Xy49ZGCwWViSJpboCWq4y0gsH268N9R2eX0GrSzTdXub50F8qLzFAObf0yHGtuDU0RS7OGemyE7s6F4ro=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(82310400026)(36860700016)(376014)(1800799024)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	xzwWLPdIJFmN0qMNVdiRJ7/nXyUSuQt0jtrO2DaBwwOyCvMZ35HEm+QjOfEEZKpqzuWjtSRL2wZmHYs+eRf3t76n/asOGX+fa/CwzLr1Tn3ro5Cn095VuAVE4VQ0+lg3qgmS2e9lJDobxYWpPPwzt+zbXnc02TSbny+XAL4PBOrhrrAkD1F2Fa7vXvk9Qx+iL0G+SRtTrhoyHUj/r5Cw5nn6N0v3XNcgN6ShIQTILIS6liZB5CYiTZkzIrGuUwllyJOrLc0JOK8b3ZLkCF0o8mYXJqzDD//Y8LmmEsDMisefWombA05Wit57fMYomymjcupIRC1qdUxLDIUNpsHZ7d9xdiMfZjm7TpXSr0xSUp5RVjLT+nYNvMeKdy1Dr5jVfZiyx9kK3sUrciD6H3fu+uWFOqlsU868qFnqGjQpcB7qJYI7frsjfTFWAiX4HVW5
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2026 21:44:42.3449
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 743b444b-df6c-45ed-510e-08deaaef842f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF0000468D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7081

On Tue, May 05, 2026 at 09:23:15PM +0000, Pranjal Shrivastava wrote:
> On Tue, May 05, 2026 at 01:21:37PM -0700, Nicolin Chen wrote:
> > /**
> >  * pci_prepare_ats - Setup the PS for ATS
> >  * @dev: the PCI device
> >  * @ps: the IOMMU page shift
> >  *
> >  * This must be done by the IOMMU driver on the PF before any VFs are created to
> >  * ensure that the VF can have ATS enabled.
> > 
> > But it returns 0 directly on dev->is_virtfn.
> > 
> > I wonder if this function itself should just fail if dev->is_virtfn
> > and !pci_physfn(dev)->ats_stu?
> > 
> 
> Just wondering if there's a use-case that might break?

Well, even a break would be what the kdoc statement demands :-/

> Otherwise, in
> current context I agree that we should fail if ats_stu == 0 / mis-match

Yea, should check mis-match. "== 0" doesn't guarantee the enable
success.


> > Then, arm_smmu_probe_device() must fail if pci_prepare_ats() fails.
> 
> I don't think probe device should fail, we should just mark that ATS
> isn't supported for the function? right?

PF must be probed() first with ats_stu set correctly. If VF gets
probed before that or with a different ats_stu, something must be
wrong.

Again, following the kdoc statement, VF should not be "created"
in this case. Or should we read it differently? :-/

Nicolin
