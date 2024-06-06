Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2080.outbound.protection.outlook.com [40.107.100.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 340084CB4B
	for <iommu@lists.linux.dev>; Thu,  6 Jun 2024 22:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717712053; cv=fail; b=STzdy08o6TJ1Y+HeZINYr8leASi4nzx3T8nkx/iIvPNpbRqcbKYAsvAjRtdLJOuoIuJiX0/yg93b59g1ck9014ybLOtVus23qLNAMr5xqnWr+nFXR8CNROGbN49cGFglGy461BhLLoMOr462MhBxTQxPbjShPT5dR+C/+DbvZwc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717712053; c=relaxed/simple;
	bh=rrWA60u93WQcmMIj9yQ3kz9bElsd9x8IO7X91Cnskfc=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NcE46rpLqJ59EINl/kZANhXE0pCJiRQdmnJWv7pqQX9b3wTyvXOI9M8NylWFiDv4GFG5vSosD17/YZvS59GGL1broyUwuihqJb/RDex9ZlFJJkxqjGtStIvu8rkmnko62FvBDe6xaDIQ3qN6Ko4z7jfKGuI36uju4+PINKslglI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pjwl+wEe; arc=fail smtp.client-ip=40.107.100.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pjwl+wEe"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fIABuQvVMhiMO2tEalrQK/2Rd9fL952/QErRfXIzVvM9EpsyN1VO+BM+wbLC/aGhgWJaNIJfPSjPEWxqN3hlkFRLnK3Ubo3duhtikvn80z7OuYMT2ugU/c8ilgX3/p+JpAKAyL+76pXA1jzotQt1Ab4S3YXwHGjfmVaJxBSG994nNf0pBFnr2a7P+ExelEaHMPLPM57PiR6VYQr5eSQh1c/dP0Yn4g6whIwHj5472HHCygW1SSUJ6CqLUo6d2yvz00Is5+qS4YkJc6xv9fgO8URhFU6DWrSfenadYszKxP31LZk2Lj95MagdAJedvgUSMjK/6Qgh2rt398dj8LEbpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WhN9Twss7G7LcjDxj0x0vpUQz1/7w3H19D6z/kXUfBk=;
 b=HELd09+eaRZigmm8rsbEwxP8FDsuUZ9VYX4ODgcaRt76ADGfJpDrJJoGzsEh9vlhtjKeb/qKLwFp95CRJnFanGQ4t5q32aMT0HDbR4jGfwDTDCJnYJNPOS4S3OHDUbITd/Ja+gZpHz9ZrKPZyRPomoCg04W4GBjcWN2Wrr501gy2gTbCtwOWUbW6n71bgXCh7yjKRVPyTtAONXpgbRw+PoKQDqnvILkOvRnCO7gx1o2FOXDXZIgH/6BaikeimGqZEfjnu+lhgvrMXbfUCVv7MiOZGrQrvS97m519zeaMF/tmHXFytNt6OqjhuhC1ZbnobHbYs7rtoaadC45CJhVt6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=huawei.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WhN9Twss7G7LcjDxj0x0vpUQz1/7w3H19D6z/kXUfBk=;
 b=pjwl+wEeqXM4A1l+h8rIfzNRVvYwHqtekSsgilZeZjjb/bzvngemlA2d9nuoKJ65CKr6X+IxM/h5Qr3Q+CghhkFHcg+jOSnG4ivZGM9KdGBRgzUQSPNoyYF12PFeMalcI0iNE6rErRa93mm0S5DBv6b+GhANGzkL1ZQ7Ey6lfrmj7ss0nv0YsmlS3kDHi2JUucp9u68XDCdgZxU+saeeny25QJ6mY5nDv6QHu0JXNb5/+/uE+33rWwTMO6OI+CGu72bA+JeCP6RX1EBv/4+e3+BoqyzroYWqwi2sLOYLFYd+ADFgnHQV1ZEllM9RIa9hpLsn88G2BhFEkdgy0UYBDg==
Received: from BL0PR02CA0001.namprd02.prod.outlook.com (2603:10b6:207:3c::14)
 by MN6PR12MB8516.namprd12.prod.outlook.com (2603:10b6:208:46f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.33; Thu, 6 Jun
 2024 22:14:06 +0000
Received: from BL6PEPF0001AB73.namprd02.prod.outlook.com
 (2603:10b6:207:3c:cafe::4d) by BL0PR02CA0001.outlook.office365.com
 (2603:10b6:207:3c::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7656.21 via Frontend
 Transport; Thu, 6 Jun 2024 22:14:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF0001AB73.mail.protection.outlook.com (10.167.242.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.15 via Frontend Transport; Thu, 6 Jun 2024 22:14:05 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 6 Jun 2024
 15:13:50 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 6 Jun 2024
 15:13:49 -0700
Received: from Asurada-Nvidia (10.127.8.11) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Thu, 6 Jun 2024 15:13:48 -0700
Date: Thu, 6 Jun 2024 15:13:47 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
CC: <iommu@lists.linux.dev>, <linux-arm-kernel@lists.infradead.org>,
	<robin.murphy@arm.com>, <will@kernel.org>, <joro@8bytes.org>,
	<jgg@nvidia.com>, <ryan.roberts@arm.com>, <kevin.tian@intel.com>,
	<mshavit@google.com>, <eric.auger@redhat.com>, <joao.m.martins@oracle.com>,
	<jiangkunkun@huawei.com>, <zhukeqian1@huawei.com>, <linuxarm@huawei.com>
Subject: Re: [PATCH v5 2/6] iommu/arm-smmu-v3: Add support for
 domain_alloc_user fn
Message-ID: <ZmI0m+3/iEwTTaIZ@Asurada-Nvidia>
References: <20240606133302.17540-1-shameerali.kolothum.thodi@huawei.com>
 <20240606133302.17540-3-shameerali.kolothum.thodi@huawei.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240606133302.17540-3-shameerali.kolothum.thodi@huawei.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB73:EE_|MN6PR12MB8516:EE_
X-MS-Office365-Filtering-Correlation-Id: cd8dec1a-a88f-49ae-ce10-08dc8675fb11
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|82310400017|1800799015|376005|7416005|36860700004;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hP0sWEWKM1ghmvHILwdjIXJrOWb7nnFJQZXirxqsKtMzbs4j0IJz3XuqJUf9?=
 =?us-ascii?Q?sNoNiED90UyALjFqcUTglRN5fAS2rLQCafs1sgSkdYtWwblu1RUHlQfH2K7o?=
 =?us-ascii?Q?xF3dudZ3TLYeYfUrDJzCUHuuxqmbB9feMAjuei79bERrWjnY2J7CBid31KlO?=
 =?us-ascii?Q?01b5RCxhblrhrHHGbnHthM72D7C6vXVXzhCrZyAS4pbxvXO1uYLbTGEGqHuI?=
 =?us-ascii?Q?7hSNfmjnLz2qQ50DEFlnm7yCOUUgc2tCnjAvi4LvfiVj6w4//pNQZ+GRKhWg?=
 =?us-ascii?Q?VZwT78axL3pHEYzIkQyZ9Izc9HT87JER9ihMVKqyZGF2DXIGo1aCm0QRpVIF?=
 =?us-ascii?Q?Mj5DUaY0EmpTNwpVHU5RmtCyiTEZoU/h3VeNd0E2I7cRNsrToP6yPPg7ugPC?=
 =?us-ascii?Q?jFsqKCoIdyDUtau3Y4H3nqsf3n74cTkPdENDFQ34BcKxb8m6P332pFzrUTUU?=
 =?us-ascii?Q?JMdyqg9ANoOUIEzsn6B9FjARSX+H4OgBb6yoSVb4892oor5DaUsxJrCo7ebQ?=
 =?us-ascii?Q?E7Je9LCHtyZ7lwSnNuZ+B+qckTFMggCjs0UTjWdpofpKw+KLg5WMrTdVI8hd?=
 =?us-ascii?Q?vs9RGEuRb9hi6GLM7uK4s+OAebHW8afxcJAx3LrHfLrwUzETXGQsvaRSrMZ8?=
 =?us-ascii?Q?2S+nFya2nlJdLm+/WYa+TaujhI0GCRqSzrIxxZMZivq3nkdtU/+Pypm8+K1F?=
 =?us-ascii?Q?cJnPHItKMPQ0GwU8cL6xz5ubfrzU+I0NU0pAcb8Hre7TFER5BgsTQXziPPvs?=
 =?us-ascii?Q?Tr6aSWQvAzLbXVyw2YeudRBH6TF11SEMttHugVhyuBrCC8pSspLKbPl41/hv?=
 =?us-ascii?Q?kxMQWyyb4dsi7Q8RdvkoJR/35+E9LF1BAOGsAODqCP9RZDP8LINnDcHI1F5l?=
 =?us-ascii?Q?WCDK8nPMpKgEwbPSXe30GATSg3hs8kHhnmueZiydBITcZol0UEkAq3wpi3eW?=
 =?us-ascii?Q?zB3nWXSS9Nd8PHG/VgnJDPYE6uHHgWeNBvjG9DUAnwojS5JjAqo191ygCwMo?=
 =?us-ascii?Q?rqmpWrouI8h77YazVB4symVlJerq5+11aD5zAOG+bjL6TUViv416ZdUoiFEh?=
 =?us-ascii?Q?R4kKnx9ejk55ib9iAi9MBuMCj60d/mT9vl30L9WrYu2awBYgj6ASPJe/pv+K?=
 =?us-ascii?Q?NsJCgpm+U3l7E7D+TVhLruxs9TFuiw+o23vDDAozsGcP4ERsTxX54Jbqjnb5?=
 =?us-ascii?Q?NINt9wdoy1IqHN506LZUEnGdqJ/omBG4tHXvRmL5T5llrfQUTwKUt7ZWHahj?=
 =?us-ascii?Q?UL21Gd9P7qgvPz6G6PRNXm2QcfqKALA3NRsV+CwTHXHHtPNvDuCuK+3oYjtz?=
 =?us-ascii?Q?YnHMh0fneEJW8mR61qr+eTeWNbxAKd2RJkaz436t6hmhtSo2vG8Er1Cr0KBf?=
 =?us-ascii?Q?7BeL/d3yiIT5XtyzoGLzw8o8OzpbX7oOerLe8w9wwJawc6c4aQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(82310400017)(1800799015)(376005)(7416005)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2024 22:14:05.9436
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cd8dec1a-a88f-49ae-ce10-08dc8675fb11
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB73.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8516

On Thu, Jun 06, 2024 at 02:32:58PM +0100, Shameer Kolothum wrote:
> This will be used by iommufd for allocating usr managed domains and is
> also required when we add support for iommufd based dirty tracking
> support.
> 
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
