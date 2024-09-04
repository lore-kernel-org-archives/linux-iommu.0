Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2085.outbound.protection.outlook.com [40.107.220.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C89B1DA2FD
	for <iommu@lists.linux.dev>; Wed,  4 Sep 2024 14:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725461472; cv=fail; b=X+QzX1H4vNOAIjrRF2k85Y2E9Y7XDhzBkoyaff4lmcEDrsUwAmvIsHlQtkIdkHb03VF+W4dU31Rh8p882k+WU4szZra8XDdEeSwM/OepGfkfmr4R2mMCrAoULa4EuC3f2AjPIg9serqGFfnHRkHKcL83ltLiSx231rcA6uWrkFo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725461472; c=relaxed/simple;
	bh=n2Rqw8vl0YBx+YD80PjfVx0tCiDU8kdvnYRSqcDcxK8=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rz7Q5gsf63HVNBO627WREE4oZ9PmRPrII94CHlGXybGK1VveOjEAiG93ZZGGNOO4CsaRPzIM0OUyK/VVaOGvleAGdBSXV3DFo3AJzRoNie2nn/myWk6hU2nn0eduZirVrPyEFndmVFDxCEYc+ZCr1m5srKKe6CDZCQW7ENNk+5A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XuqZKLlG; arc=fail smtp.client-ip=40.107.220.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XuqZKLlG"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G9XyH3JNI0jysIDvPZfjkRH01K79nhasrZICBqnMf5LbKuf7km++2/mDd+i5X7zZoeW2+TFdZHctAgtownOOU+wP6/YI52ipgLi3UVmNZDRhliuIj4r4ol4ByCSSh5xcrnGCagvBHfenP4o2tErseAqZXqyv7/up1BlgCcT7Y+70s5WTB5ucC4ALIjDVImpH1KdJKO84Xj6GyCRYoxAzCWh6Jqrc4xy4hubbDVtplZA3i4O38XyGWW3/28bRFJrrE89jRYqGCBZmZpArWjgiS30D/7CUQ5r0TAj2HL8mDPqZv35LmgPAf1j2pxqYMqmcaVcpZHJj+GJkeNR1e86Z5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I+bG+zeJ/DwHwhkzkrhIE6ZfSfIQNLp3o8ruvVhFs4k=;
 b=Xax4mIRnhPJQ1X0Lwa1ujNewl/1O/45iNwRbt8pkUMFbe5/3eL0ycyCWic98v84ZAGeOG70DVYCi7a9Cvm2lMdeML2+OiQ3bxikjY64iVe7f32TnsQnUn6WN5ExrIHKhtX40MrTpaMUxFXto6Og4Diqh0zVbAC+YCZZIqL6l2l41wa4DcrZoNaKwx7gQ2X5A7U1Ahnu6+9mf5vIS3yq3tBtOLxGscp2g7MKkQ5bOvjlcnCwDjAgv5hZ9jlgo6L9I3TqPMfLL8FqpvJ9nESvgqT5vr5bgPGXEAAwIwrPpk4FJbxpyD0wDAA+AMWeC9mNSCzqO9valqwMdX76jE5E/tA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linaro.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I+bG+zeJ/DwHwhkzkrhIE6ZfSfIQNLp3o8ruvVhFs4k=;
 b=XuqZKLlGI0VkYCjKIYZkmoTi6nsWkN/msTHIPSdZQ34UPKYbv3uF0u5cHBqSFQXuOhcAjoIxtNjgFQh5mKAuKfCuUzIRhWbeiIFvZ7f7JqB01Y9VS5Dd7GEOCvfAXIxF3WHxMxYBC3aKBfEo53ZyZ8NZFKac3rucfuxTV78aiGu3eCI/3aU1HPZSfsJ/oKI/LpHHC/qAAC3oo7H5tUvms2xJ9rTtrHjk54LuWNEJ1yD/EG31bpy/GzpNeFc8x0aqx/xFUU5qWHCfvvdACv0wuJ79taew561NdVw9KQgkhZll+XQJaG9sBsTlmYEPLlRukKC4oDmfpd0ZdIRERoQAZA==
Received: from CY5PR13CA0002.namprd13.prod.outlook.com (2603:10b6:930::10) by
 MW6PR12MB7085.namprd12.prod.outlook.com (2603:10b6:303:238::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.27; Wed, 4 Sep 2024 14:51:07 +0000
Received: from CY4PEPF0000FCBF.namprd03.prod.outlook.com
 (2603:10b6:930:0:cafe::8f) by CY5PR13CA0002.outlook.office365.com
 (2603:10b6:930::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.14 via Frontend
 Transport; Wed, 4 Sep 2024 14:51:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000FCBF.mail.protection.outlook.com (10.167.242.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.13 via Frontend Transport; Wed, 4 Sep 2024 14:51:07 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 4 Sep 2024
 07:50:50 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 4 Sep 2024
 07:50:49 -0700
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Wed, 4 Sep 2024 07:50:48 -0700
Date: Wed, 4 Sep 2024 07:50:47 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
CC: Nate Watterson <nwatterson@nvidia.com>, Thierry Reding
	<thierry.reding@gmail.com>, Krishna Reddy <vdumpa@nvidia.com>, Will Deacon
	<will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Joerg Roedel
	<joro@8bytes.org>, Jonathan Hunter <jonathanh@nvidia.com>, Jason Gunthorpe
	<jgg@ziepe.ca>, <linux-tegra@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
Subject: Re: [PATCH next] iommu/tegra241-cmdqv: Fix ioremap() error handling
 in probe()
Message-ID: <Zthzx06kZv+FyXJT@Asurada-Nvidia>
References: <5a6c1e9a-0724-41b1-86d4-36335d3768ea@stanley.mountain>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <5a6c1e9a-0724-41b1-86d4-36335d3768ea@stanley.mountain>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCBF:EE_|MW6PR12MB7085:EE_
X-MS-Office365-Filtering-Correlation-Id: 386db542-abb9-4c0b-e1a5-08dcccf10224
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|7416014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QxMWuZ3jQELLbkYHEAkX+rmjYsC670/Nj90adwYhU3m6k7ZNZ9nlz9ivhBiP?=
 =?us-ascii?Q?LUiqd4Zs20EyWifmqX+uOtR5n6hl7dGCyneTy5CLmlhRnKgS5bULL8I3k7tu?=
 =?us-ascii?Q?PsGeCptzj2bQ8QSPqhKyK6uu6jcYuaZfXHq1lK40MbJ61nUymxiY/NNcrtpw?=
 =?us-ascii?Q?DbBPHLIKMboylZ6bJ8Q1pqjo/BMD/29Q7UT2eA+qL52gUJ9pfQMEl2jIIG5Z?=
 =?us-ascii?Q?LR+rgtMKTifENBgA3Qj2adQLhTLOpPDzHW9WFwJBXmvSco7abLLDrqJNWF2N?=
 =?us-ascii?Q?UGQVu7/fXyCsegSp0j+/jBdJMzWo7oHKLpCrKfJAOKqgvtqqqK3LcpyjoxuT?=
 =?us-ascii?Q?S5IOpNDY1/3U73Uj0mQv/gL3r/jnLAqzT+ILW5P0iLlRDSU7N3RhXUPxdScu?=
 =?us-ascii?Q?yrp1ga9xt/IEou0EqCgUYX9n4muYaNDbmEQCuH2pInzji9T05+CAhb9NCJCx?=
 =?us-ascii?Q?XRLNLaA7qej8YXQDS9UnjGBFzbmUFCHsX2lxXDTEg5AxV6LYNUlNAwJTyXyv?=
 =?us-ascii?Q?zJU82maZ8ioyPYKk2eujhDbUIwuGTvUVWtzVBFR1KWxMHjn25Q/l7VsSVV6u?=
 =?us-ascii?Q?HxIu1aB1Ef1bOD8Rutz4X0aXVBXqelVxkcIPlB/lUxM+nTpN+VtrM+FarmJt?=
 =?us-ascii?Q?IYsmVFw0jkbOYUwsjkSyR0JO/GDQpQZo9UCoQF0iR08c8czWv7FKEwRb7LHd?=
 =?us-ascii?Q?Ko/EiSeGisB2tOs5QVdz+tWplvt3P11Vj9Vg0F0ZAdx+ZTpGCZCJgXT4EMG3?=
 =?us-ascii?Q?7dclzWZZfJj2i/X1W/gR/6mZlIcm7J2tyht16OXSjzRHkGx9G9gkh6VRdyY+?=
 =?us-ascii?Q?4/7WcrbLgTlU3wKTzmHVZGLe9RyAOhCkQ45XGbKeSWGJqz8Xe+yns5iaJEi6?=
 =?us-ascii?Q?7szmTXEw+ApDfIMQKkfTeKHokQNadI4/j8ar/aY4KFEo8o5sGpjMvdEFv21e?=
 =?us-ascii?Q?Esa+3wNgHCES53c7u3uVZh+73I1Z61EDrc9NB8xH9/UK5hTqnXRecr+QOgmk?=
 =?us-ascii?Q?iVGwxToUGTAukD8eI7U5OGJLpqYkXmV3nTkvQoubkzdOXzL3lxy1gQZIA9G+?=
 =?us-ascii?Q?aGwnO9LqaL83CQ5AN/TD2EcRyE0h03lGNWDYfleSvaS8XjV4qCZQlUKdKAwM?=
 =?us-ascii?Q?g9STLKl8y/sMfb181aOSYhJ4XeMPjWkDgUvsUnC6ICqbuyuA5oNS1cRV1yyM?=
 =?us-ascii?Q?4zL7RWQUoWnJKCs4Q/Nd49GX0pqiRxdFK1iEOectyCmMJseSBFNl9VxgtdqU?=
 =?us-ascii?Q?RyCTkjV3EsNLRcc3ILoiZSVr1XnTmpfP75ZAhmHe6g3F0E5Giipv+KC5pFXs?=
 =?us-ascii?Q?YwtpUuu+SvUixoWXT5hgycSSlCaNhnl+OsquJ+5GqZK1F6WVQWKqkG1sl6Mi?=
 =?us-ascii?Q?fxGfpiKuFUBIYqGsRgnF3S8BNMFSVFlolbkgCgXfFvUGnssuB1dH+d/jThKw?=
 =?us-ascii?Q?hmoBRB7cdO52RTi203nYIfUIrZ22jlD9?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(7416014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2024 14:51:07.3517
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 386db542-abb9-4c0b-e1a5-08dcccf10224
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCBF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB7085

On Wed, Sep 04, 2024 at 11:02:43AM +0300, Dan Carpenter wrote:
> The ioremap() function doesn't return error pointers, it returns NULL
> on error so update the error handling.  Also just return directly
> instead of calling iounmap() on the NULL pointer.  Calling
> iounmap(NULL) doesn't cause a problem on ARM but on other architectures
> it can trigger a warning so it'a bad habbit.
> 
> Fixes: 918eb5c856f6 ("iommu/arm-smmu-v3: Add in-kernel support for NVIDIA Tegra241 (Grace) CMDQV")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>

Thanks!
