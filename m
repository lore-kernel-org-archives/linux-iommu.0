Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2065.outbound.protection.outlook.com [40.107.212.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 501911DFE0B
	for <iommu@lists.linux.dev>; Fri, 11 Jul 2025 22:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752271492; cv=fail; b=tYGYIArDlljVL5skwkgbbmb5tQIXrIe9ueSgp+RqfN3pylAhRHg1Xu3bTEAeAm3GFjZ9yUh8dxFGHLughlSbsLF3j36n9twzjRya1wxb7VSaXIs6YJwB/0k9aoIHuVqTKluLJfX9ZPbwyHBr/Z5iz655U+7zfCFTFjR2pbs4CHI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752271492; c=relaxed/simple;
	bh=L2iDUkebJQx/EKIxhwC7XM338kq84k7Dkq+RO9z3Nyg=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pZXDVR3ixwHiy4eR8fjB+Jehpe21fjXPuTfmdKFFBq6Vr+kPgRpbeBmz2I975G13ZG0xBEo3mGXh8iL/OXXDwibFeQFFoshbpdwAKWxiDIMjENeJit0icDqgZbLK1OgHHYCtNwZMWw/AUnnh/nyTRZE/EJi+roSzyk8SLl4FpdY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lZ0zxW79; arc=fail smtp.client-ip=40.107.212.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lZ0zxW79"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gtan/hOiYLwmrrZpaVR76A3tgkjb3NjIm+XHRqZSyKqZOhQvOdEpPUpnAeocYCJdso61TDBCDXiEPccCoRTGx8sVp0tt2/+2WTfkAsyGOSLGW3XCK2a8k/lIIuLQ6OQYRbAQPKEAzg5C46gNoHFO1vATKmU5V1YygdgqilCxT3vHazvN36zrJKciBTftJpmTvXWCoieV5pAVTBW3IjCdAzJ9mMGDP5V1P0P0qwTF15LcG4D+B7C4Oh2oq7yaaK/UpJxVP723LtvLIZQddAJxTT7SZWGtgUSPNDQqna4V+cj/wPau5WHn/J5PRRwYiKU3vuBbg8/iijrnDtlXmrJz9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eUZBCCbZZ3GumoyqZp/xL6rmv3Bvm4s/4O0mGvxaQj4=;
 b=zVnFPnKgwxXpR8uRGvw0wVYaMUgOxkYoYuqTaqzdNMkNQro8/LkjMofGTZRma+ZcWWGsBm7hd1+IgrUpkvVPQSyDIxRNemfelEunVyLUs61RvN/j/jNiw1YPCgWQqDqvW/Lri0whOOXCJOrNdeY8AnHv/EPpEzTXBpFG+kXFVo1n9X9rS/l1Xu4AfPnnn56BNJFbn64WP4JJbyRr4Fe/3OKVuVjikRrBNtKcsBO4f3zHcjPG9yl8WmCaF58aiSDeE1OU32OS//f4x+LMNwzkJeEiHIV5InUbuPSOdgsriLfEi9s+KZGzEddPLzlcXkiyVlacVCJc1+Z2tDmc0YsNRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eUZBCCbZZ3GumoyqZp/xL6rmv3Bvm4s/4O0mGvxaQj4=;
 b=lZ0zxW793NhMZGCNMrS0+DvKGG9X+HtyL/PVUCUY7SsgztLfKWWe8FsvqZgL5HzDhdvHkvZayRGJxPCNAOxXZd23bDER/jnBVDonBoza4CgHsdpTO7zCT77EL+xkjk2NolV3YCDrN92YcnC3O6/NkyapTKP659pqhOGj7n3IBgb9a2PqaAgUfGSt38U8XE2BMfBga7OX3Dnyk+zZSSXP7zmYgBbLaYNQFelb/OaTGFUCAuk4DYCq1A8BpeEeMSeyTPNmuniTCOwd0cppkIqBHh0QTGxUu4K0sjDHRSzNFGXh4tV+uYJMwi76FnAtJuZj53yI+vWJT3CFvL3KObxoIw==
Received: from SJ0PR03CA0239.namprd03.prod.outlook.com (2603:10b6:a03:39f::34)
 by SN7PR12MB7979.namprd12.prod.outlook.com (2603:10b6:806:32a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.29; Fri, 11 Jul
 2025 22:04:48 +0000
Received: from SJ1PEPF000023D9.namprd21.prod.outlook.com
 (2603:10b6:a03:39f:cafe::5a) by SJ0PR03CA0239.outlook.office365.com
 (2603:10b6:a03:39f::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.25 via Frontend Transport; Fri,
 11 Jul 2025 22:04:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF000023D9.mail.protection.outlook.com (10.167.244.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8964.1 via Frontend Transport; Fri, 11 Jul 2025 22:04:46 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 11 Jul
 2025 15:04:39 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Fri, 11 Jul
 2025 15:04:38 -0700
Received: from Asurada-Nvidia (10.127.8.14) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Fri, 11 Jul 2025 15:04:37 -0700
Date: Fri, 11 Jul 2025 15:04:36 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: Xu Yilun <yilun.xu@linux.intel.com>, <kevin.tian@intel.com>,
	<will@kernel.org>, <aneesh.kumar@kernel.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <joro@8bytes.org>, <robin.murphy@arm.com>,
	<shuah@kernel.org>, <aik@amd.com>, <dan.j.williams@intel.com>,
	<baolu.lu@linux.intel.com>, <yilun.xu@intel.com>
Subject: Re: [PATCH v4 2/7] iommufd: Add iommufd_object_tombstone_user()
 helper
Message-ID: <aHGKdEr8CQwHsuB0@Asurada-Nvidia>
References: <20250709040234.1773573-1-yilun.xu@linux.intel.com>
 <20250709040234.1773573-3-yilun.xu@linux.intel.com>
 <aHAPqdZKfdeEMDs2@Asurada-Nvidia>
 <aHEnnesvLL5te5rf@yilunxu-OptiPlex-7050>
 <20250711213323.GH1951027@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250711213323.GH1951027@nvidia.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D9:EE_|SN7PR12MB7979:EE_
X-MS-Office365-Filtering-Correlation-Id: b251c8c8-c309-4165-056e-08ddc0c6f2f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9lc3qhkdYreISd07jWqJEm0HVIZBi0bBwFW9hyNl3RZ9NzQLxtCuuZRgtKK/?=
 =?us-ascii?Q?qWxcaf19zm635Q22Bdj8rjhsIi9MlTgNDPRd806ZdAgh/c0Ed9h+GzClDLvz?=
 =?us-ascii?Q?SqFe7yOPBJfIdU6FirgBapDXU29tw5XhG/zGK1dK1rSqE1Nm3dgDZC8bUqrQ?=
 =?us-ascii?Q?/AC3EO/CplTKloLWq4Z7hJIO4AQE/Hx1zwJEJlb8+g533ZOQCZR3CD6PZqvy?=
 =?us-ascii?Q?Itj2/Tn7XgPVdzrCaBSmLX+zqUpB6VbLA6YpnGIJKQpDK1sjywOEgOMOYH7v?=
 =?us-ascii?Q?bxf+58FmrczgcJMHwLSqe3aAsDclx2m5Gv9ZrfxCOMwMCNA8BKEAG5w3Srge?=
 =?us-ascii?Q?LSSqmwPQ6COUgLPpdfEmlNOT329krWPC1ag7yfohlUUjK5KEkdGTqGQxoBh4?=
 =?us-ascii?Q?mjEFyfpIjqFbUgCWBSAUAa9y34kd2rWb4liVv05zejAKbUIDPpRgEgLkfqEs?=
 =?us-ascii?Q?pK3tppq6DDnCJuBXZaVHS38v/w5oUCIwBUx4a7PobQgbB3pS/T7Nj3FsTVeV?=
 =?us-ascii?Q?ppDu7hcF2ZDBGYkr8Iown8tzqskzsXZ3aU2ZqqdgJYos2NlAqAJR3Xf/hWcP?=
 =?us-ascii?Q?AZZgOjZdNSDK5oawh6XMHSNX1/7cu0ShOca5juXKPRMbiqI21mRDt3dCAbYh?=
 =?us-ascii?Q?jvS1+pAdo0+gZ+xq0xFfJDqtnh72DT2yAPplGvdYIop/HdjZxKJLV8kS1960?=
 =?us-ascii?Q?JqTJPD/aLNjjfzy85uq5Yy2zrPB/aFqrNUXg/Z5mQcP7PvcUF3UjOTWL0zcb?=
 =?us-ascii?Q?G3NVZHfGuy/BfICMlp3aOPnjsNXJYkQWeJ9JnwY+nw0N9ervALK3g/2tWLWZ?=
 =?us-ascii?Q?JK5d9ntzpUcJKj7XSAuA8sFYHkfBAOPTIXUGjVi8eHDAmGuuB2h9LXuP2jLh?=
 =?us-ascii?Q?04Rnw44nCJpB/NjJW57aA+nqAWRM27A04RZ0y8lidkpsvVqV6Dzswm0p2S4N?=
 =?us-ascii?Q?9z3adYA740JtcdBGWfIJYEecjh4bMHrFK8F0kLqFMbu3IXdgIcL/mcym/IHp?=
 =?us-ascii?Q?tcsZ3fdzNa9ubjqhgt5PGvCfy6WsQXTJThoP608B3NoRjwI+7584z7Q9zXMO?=
 =?us-ascii?Q?Ju/jGcfLX0XfZhm+5HUd+ViQs0Qs5jClzxwkqmNusr4Med8rABeUfTc8cfKv?=
 =?us-ascii?Q?UMGjxak6X3bCI06ofSwJ+rwvhwOCoTKUzEnFjbZwnxbPtOEFAONGd5QKqQ1g?=
 =?us-ascii?Q?O7ggOimdBz/GcXU1fdWxDO0nZsYYPHj6JuiG8ihyLv+NM9sl/ch+/W8Ytzc7?=
 =?us-ascii?Q?243VISjbkSBg5cwNVi0OZU472pTnD4WCF3gjEwW+XLnXUlNuKy83N+GlmnAp?=
 =?us-ascii?Q?dadzxHbKhbzSBA/5zR2hLobpykIl1vy2pjaUt68+aLQn2uI1fsDiSHCVQgJE?=
 =?us-ascii?Q?fppZ2gscU9WRD3r1uFPTvh2Uwr7Jr9q7+lhZ8B/P4tmigt33NIYmG14JP8Dl?=
 =?us-ascii?Q?rXJNV+IM608spyOBgsMBhncXiNePokVSXRFlg1JjgCOwvBqaGUmsOw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2025 22:04:46.7907
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b251c8c8-c309-4165-056e-08ddc0c6f2f0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D9.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7979

On Fri, Jul 11, 2025 at 06:33:23PM -0300, Jason Gunthorpe wrote:
> On Fri, Jul 11, 2025 at 11:02:53PM +0800, Xu Yilun wrote:
> > > let's write something like this (correcting typos too):
> > > 
> > > 		/*
> > > 		 * We can't use xa_empty(), as a tombstone (NULLed entry) would
> >                                                             ^
> > > 		 * prevent it returning true, unlike xa_for_each() ignoring the
> > > 		 * NULLed entries. So use an empty flag instead of xa_empty() to
> >                    ^
> > s/NULLed/zeroed, are they?
> 
> Maybe:
> 
>  We can't use xa_empty() to end the loop as the tombstones are stored
>  as XA_ZERO_ENTRY in the xarray. However xa_for_each() automatically
>  converts them to NULL and skips them causing xa_empty() to be kept
>  false. Thus once xa_for_each() finds no further !NULL entries the
>  loop is done.
> 
> ?

+1
