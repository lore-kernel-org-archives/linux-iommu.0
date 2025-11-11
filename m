Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013050.outbound.protection.outlook.com [40.93.196.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 769712C3248
	for <iommu@lists.linux.dev>; Tue, 11 Nov 2025 18:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762887532; cv=fail; b=cJz75oqmdo5oeR8Af2YKF/u/a2Zsl8rZ7z/CkQNYhS5XJEVPUPCDm73OPbGrc/Jj8OaHQRPP7FHzmxhlTbGEB/jCTBdJz4iiTPNopewZWps/IwlLNc5COek3MH3gzJsTk0WopBAR9PhbAYSvYl/3Sq0IelzMqg+fizfToW5wLd4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762887532; c=relaxed/simple;
	bh=9Nu4R+0F8ZcnLWlDGKzNL6c+dnCbYNwb54P5ce7NyJk=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aibkb9r/jUlFBP4onBRad6qpehgTqre6Hu2R3ZywgBIh+kQzZpnpWKJIt4aiyR9sLD3jiQLGmJghqg/BpswHbob+GbuUYMtDb9nAViZdvZ7gAmOYdaKvxidfykBxiijmXgHYvFGFHOvyZhO2PtN9A8dpFvfGkh24AkV/zlM+jsA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=aJrTsvU1; arc=fail smtp.client-ip=40.93.196.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="aJrTsvU1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZedP4+k3xCSGLc3V1ktMEhdDQ2aOTNL2t0liRSlCt7g/hglhInEIv2B7HrR+N1JHcuCW9FET8k4tIFOQyr49F/+16/B8VjH98p4wBmpGu7bFhBCZpG/FxSygCESMD59GbnR4/T0pxQkhTbVjDelUJ1WIfr53kKpCgpl++Avc8yP3bQXjq7Wt4c8bTPZUbj7LjuDs5egSy5FicvbdVPPTI4m7wEfiYIF51mUfXB+gvCFSczJjyUBjyxwBAVw2xQva1CyNrhWH3b75dVySrh5cvjfNFG/Dp6o7Sz/DG8NWViwsbv4r5s5VQ9+I9j9Vt9bXwLN0Sx23QyFxJek1IQuxig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/iD4k/xZTQif7mnDs1zdkrlwfB7QpZExtxp0siXwevU=;
 b=K3X74MQk0vYxKhu47K+vwrL0GdNaaGG+lhRVb5gQFj7W11iDAFsvlSp6BhVrMx1DR9DQg4GucvCVBbj98JYKYUDthVJ1cvaX3CSQ2rqNAFk8RfJIn8wnunoA1QPohKkY5IOP8et/2mY8Zx4ngsW0YvCn8Dl8FMNDSb4z69Lb9mEyCL0Bx2lXFr1vL87g0sS0XsLoF56hwWGjwx43gAb7JAt1KA2f9ocl9yCV4y7oPrItw/Y1qB8b3TCQBiCzIN/wsJHDZnbZNhkucItZK1SdA7Bhp0l28HsTILauut3qI+nXDxXWgC+/2ad5HfEd3u6CwETaO+tF86nJYmU5685vRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=embeddedor.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/iD4k/xZTQif7mnDs1zdkrlwfB7QpZExtxp0siXwevU=;
 b=aJrTsvU1xy3hfLgFjzhoMyCns5dPxAFHGBhpKHPhPGV/qkecoC0Dt+K1pF7iYjK545OZOWLCfZKT4I3VDFIxZFIhXvS6rA61lGs/hSt0ctg5NYQaZpvbQTDZdmjvpJixWP+9srfjVeTkH79xf1fRHcZnaRX7tlZM0gdWSMchVix+QT4It5H2OrDINO08dBPXBSOwpxmjJMXSviYB3KiVHjf+81qVFTbVpVw0S5Tr2WqSK+6h0vghsMSqrt0PUFcTe6NvIw1dFm333R9/s1Slzmf527IHC+YIoSZuOVwZui3JvS/JziQbyMUSvcYwVzkwPC7C00C+6sZQ6dnktdCBlA==
Received: from BY5PR13CA0003.namprd13.prod.outlook.com (2603:10b6:a03:180::16)
 by DS4PR12MB9658.namprd12.prod.outlook.com (2603:10b6:8:280::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Tue, 11 Nov
 2025 18:58:45 +0000
Received: from SJ1PEPF0000231B.namprd03.prod.outlook.com
 (2603:10b6:a03:180:cafe::fe) by BY5PR13CA0003.outlook.office365.com
 (2603:10b6:a03:180::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.15 via Frontend Transport; Tue,
 11 Nov 2025 18:58:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF0000231B.mail.protection.outlook.com (10.167.242.232) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Tue, 11 Nov 2025 18:58:45 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 11 Nov
 2025 10:58:33 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 11 Nov
 2025 10:58:33 -0800
Received: from Asurada-Nvidia (10.127.8.11) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 11 Nov 2025 10:58:32 -0800
Date: Tue, 11 Nov 2025 10:58:30 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
CC: "Gustavo A. R. Silva" <gustavoars@kernel.org>, Jason Gunthorpe
	<jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>, Joerg Roedel
	<joro@8bytes.org>, Will Deacon <will@kernel.org>, Robin Murphy
	<robin.murphy@arm.com>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-hardening@vger.kernel.org>
Subject: Re: [PATCH][next] iommufd/iommufd_private.h: Avoid
 -Wflex-array-member-not-at-end warning
Message-ID: <aROHVpn76XexYMPX@Asurada-Nvidia>
References: <aRHOAwpATIE0oajj@kspp>
 <aRIoufDcyohFWQz1@Asurada-Nvidia>
 <36cc3b51-601d-4412-9dca-9752e2d77a51@embeddedor.com>
 <3d50e0a2-77fd-4c87-bf74-8ab8b6b15ce2@embeddedor.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <3d50e0a2-77fd-4c87-bf74-8ab8b6b15ce2@embeddedor.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231B:EE_|DS4PR12MB9658:EE_
X-MS-Office365-Filtering-Correlation-Id: 148a8440-bbd8-494f-938b-08de215456e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XUX0OK32QFERryW0P0Z7yPmW3mtsuJlweU/7qsgrRhfu+XwmEZxnWn5lpdOb?=
 =?us-ascii?Q?8ZREmP+r1RPC6rPY17oKJLpiqXnRonWTwxLNvsb74Ma9MniuNzjJQ0R7Mwkl?=
 =?us-ascii?Q?egHVRq+1EixTEKFmQIaPQ78RrjpIccNlP9IJKPM5oW1GFJ8s4X6oe5/rBer0?=
 =?us-ascii?Q?kBFq40aZrMF3v8/aQvu7oIc1xc05GGlthAEZPdNGmRTlR3zqCngrpWfXF0P6?=
 =?us-ascii?Q?sRGYTEJyrsrZMPkFG9LjCXwgIVeeciYOYBydUDozsPF8BaiiEctxK3vI/Rb/?=
 =?us-ascii?Q?nku9IgHbAsYVwL21IZMb3dxCGK3Rsqm9qH/Vn+hcv7aJCEiI5656ui1/LFD0?=
 =?us-ascii?Q?9HngqmcWFij8ToaraE00JkJOI/wN6UT9Jkaoy+XM2cigR8xWqbjLdfAwmefE?=
 =?us-ascii?Q?JKYUDEiBEzLTtKQN4N8GBdwFFgq3DJh5WaPqeDwwF2sSV0pABZEXxjZbaFAY?=
 =?us-ascii?Q?e/PwRxmocltKdR9Wp6FGLufwEranxkbTATbmQLDw7k42g55a6j+ho4rDDBG8?=
 =?us-ascii?Q?a06dtyuNXzcXRKgxu5XrN3s3VXfyo6oXfg10XOzmUYYpFPxJB2A55mfFZzMM?=
 =?us-ascii?Q?fDQzpYgraH8uYDnG2PXz0Ph7FaouB+jcW+4z5162ganO/SuU9RjpKG25a7D3?=
 =?us-ascii?Q?4eNNpv5X2IarjW9Qp5CvG3htpBor9tQ7e5TOddj8wC+jy6akwOcu83rg3gpy?=
 =?us-ascii?Q?y6SDLcO8ohea6poP0EvfxRd3Vc1Jc2B4hmOPb8iEi/NXnQ8+HLAsrAFB2nDW?=
 =?us-ascii?Q?SqXzmu4on1UiqdKI3Wt2W8xv4W0dbZcowSNGY2CK5j0ZiRN1izFGTaBJ+PO/?=
 =?us-ascii?Q?8Na+KzbWwPykXSWHjFPGJbhONry44aWq9H8SyHVYeJdfwR1Qqg+0cETGh278?=
 =?us-ascii?Q?jT3GiI/nSotFnPORkpFdJ93ZuQJS2foicQ7STKTys+M6YNJqKIAeXZw8xBLb?=
 =?us-ascii?Q?Qjycg2VPTQxYZYOlmLSZSyG6OdG4PTu3jTAjR6ev0kHAlSn6Dq+LCoTU+33B?=
 =?us-ascii?Q?otc5+RaAOs29zYM1InMtuF0w/aicuVj8wtlM6pU3OSXEMgdX3ChkeYooJ4H5?=
 =?us-ascii?Q?N1/T+Xbltml/4HQYWNuh64X2hls2nx+7IlGK7f1NxdcmutKKt9VsEzkkzCb1?=
 =?us-ascii?Q?asMx2xeuYZhEMgnHSNGZS3wrWD0+tw2YlncUZPOVgD6uYU8UFJ+jcL+iFcKs?=
 =?us-ascii?Q?q+ZN171HamYTZo6rwwDKv3FNQt0XA9WCsviMWXsNzHT56KLknmF/23WW9uFz?=
 =?us-ascii?Q?4To3vk/OrniHEABdJgS1fZGnur1qIaiC6IWmlHo5xPlxqSeoexC8OVedRwqG?=
 =?us-ascii?Q?Kv7YWmpWX/nxygTAimOaDaPlNN2pzmBB7KvI/eeo/gYSgT3XDXI1Ap6PJmHt?=
 =?us-ascii?Q?lyobwMr92pQOa65W+0AtpAWQ2v1AEVMFhBo5mHWVRuC8if93dDUUT2GMJJkS?=
 =?us-ascii?Q?ZEr2bq7ePI0zTtDQvOvH6NAa20t+40+f7Lqo5Z6PFxNuzkwAkTPbUwP3bfXr?=
 =?us-ascii?Q?Fg0/5iyhLQdTaSpLJJOWFNU+XlUMB3mGh2ujVnGMdHNg0huH81nRRNm/odbi?=
 =?us-ascii?Q?hK4fN4gt/GHnp7ci/0I=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2025 18:58:45.1977
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 148a8440-bbd8-494f-938b-08de215456e8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF0000231B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9658

On Tue, Nov 11, 2025 at 05:49:20PM +0900, Gustavo A. R. Silva wrote:
> On 11/11/25 16:20, Gustavo A. R. Silva wrote:
> > On 11/11/25 03:02, Nicolin Chen wrote:
> > > On Mon, Nov 10, 2025 at 08:35:31PM +0900, Gustavo A. R. Silva wrote:
> > > > -Wflex-array-member-not-at-end was introduced in GCC-14, and we are
> > > > getting ready to enable it, globally.
> > > > 
> > > > Move the conflicting declaration to the end of the corresponding
> > > > structure. Notice that struct iommufd_vevent is a flexible
> > > > structure, this is a structure that contains a flexible-array
> > > > member.
> > > > 
> > > > Fix the following warning:
> > > > 
> > > > drivers/iommu/iommufd/iommufd_private.h:621:31: warning:
> > > > structure containing a flexible array member is not at the end
> > > > of another structure [-Wflex-array- member-not-at-end]
> > > 
> > > IIUIC, there might be data corruption due to this? If so, I think
> 
> Okay, I didn't find evidence of data corruption. So, this patch can be applied to
> a -next tree.

Revisiting the design, the "lost_events_header" doesn't allocate
data but only uses its internal header to raise a flag. So there
should not be any data corruption.

Yea, I think we are fine with your for-next patch.

Thanks
Nicolin
