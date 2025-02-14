Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2078.outbound.protection.outlook.com [40.107.101.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32B1B20CCFF
	for <iommu@lists.linux.dev>; Fri, 14 Feb 2025 07:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739516823; cv=fail; b=fxrD9EudtENAtw9E4s9HqRSoi/MeKKUaOUXJnrY/qQmuYx9PGY4aww028kjR/HhmSubbyuMCya/Hq8jgy7IyoG1ZqtkRomry493mv99iETYj0MlLnYKfYOmfpY6xZRMZGt/3pMz9nHIxXDZfT4m1K8PHDh3Yn/iUDlmYnqrsAb8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739516823; c=relaxed/simple;
	bh=nSIesr9xNyrkLptaA7lJ78vopXbxEORfZ/CrwszcAGI=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SsC1IchdJY98qqT0aRzGIg2+Is1vktYYYCnnAvn+E4CwTYhJaMS5VNFDxf3Csu//LsIwC2NspOjGZ0y1hO7Wrn9o4FlfZjpTQdM+/FiOzhT0o2A4WcVOszmQnK2Q+pKsRwNFMc8WWRLlJ2/pFc/IHz3IYTrJm/i80uyHshcVzQg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jQzZ7TSy; arc=fail smtp.client-ip=40.107.101.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jQzZ7TSy"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eybqNnVeJeFKcppyw0Ze1rr0NIVVtfLZ01h4V+Abp+ApzQ7fVPnRAHDc+jDg0Au8BGZqgcR8D2zPxCmfam+scrXg7efRyEqYdoWdGFwZF35Uvr0BZdA3NPhp2gey/NdcJsjf3YUgnbPwvvusXOFAxwyfnsabrmlZrJtlrb0tuGEZ+ZDM6Oz1Oob2xlowmMlyds29ZNUFs3Lmt1cQ+2uD3dhsFeFngks2hKs3ZXtwUTpl7Yc9yI8ZKDyls8FuknqPppsmMpPGoL27NOzq0d+OwwqGQCGNsgNVIj8ap6+v1709lezhDOSOizHrNF8T/3j0l83fD4TGXF0tVVOGG17sTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N6SOy36OG4azsDNoC3J2XXcWhy7s3TBZHgdIcK3PzHw=;
 b=ydW1qEbzlfDUG46gc0ExX2PxoPucBMUJsO8dxcRs5ThvmGK6J4foZg8BcE1JuQSHNvKwXFcQHH69zWYuLspOLDUMaAvzie3Wn+ram6FP8dTvfcsYh7gxGHUuWkwARtvdULHXu88rQtyUBaYek5WJsiMkY2GHT4S65mVCmZJmNmvA5syW98RGLgxkExOdvXEx3Rk1EKZT6mg1uSANPZnm0qqPKBeEoFAEjHp0bdsZKSMHcRFT4YdeYQ7IddlebzzV1W483DuLehXchfpw0I4GHZ85A75ljK1iNJadgPwdMKnc5qnidGy7bHjOlGhgYDbXbEAV0nKSRbZBBVXQXPtkCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N6SOy36OG4azsDNoC3J2XXcWhy7s3TBZHgdIcK3PzHw=;
 b=jQzZ7TSyU/2sDspDYdRd2ddw3K+xEG1oayDifSQK/FChyHMmEJOdtH87PqzhTKcNkPCr7O0uZ9C82PdgkVy36Jc2i0yeRcCcgaRQkrFK0rmSi4neUlTKcU6i6cHDTJp0ESKDSe224dBrv0Oe9Mys+VImkW/NmnL9/qQp6b6Jg5SCKZA3swa022M+j2qpQVi/dSSiHZQj5eRNTOu0fjHvO+dtvc99OzIOduPGCCbLIRqyKckbQjUN52PbKuncJ9oyKnV8zMXlY6cbtfDhX7YUCUE1jAjigHy/DdUoz5S3UKoYZ4IIPh8UHEw/KIEm33v4iq0hFVmq49mpORtj/f/v1g==
Received: from BYAPR07CA0107.namprd07.prod.outlook.com (2603:10b6:a03:12b::48)
 by PH8PR12MB6916.namprd12.prod.outlook.com (2603:10b6:510:1bd::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.16; Fri, 14 Feb
 2025 07:06:57 +0000
Received: from SJ1PEPF00002319.namprd03.prod.outlook.com
 (2603:10b6:a03:12b:cafe::20) by BYAPR07CA0107.outlook.office365.com
 (2603:10b6:a03:12b::48) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.13 via Frontend Transport; Fri,
 14 Feb 2025 07:06:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF00002319.mail.protection.outlook.com (10.167.242.229) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8445.10 via Frontend Transport; Fri, 14 Feb 2025 07:06:56 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 13 Feb
 2025 23:06:44 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 13 Feb
 2025 23:06:44 -0800
Received: from Asurada-Nvidia (10.127.8.10) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Thu, 13 Feb 2025 23:06:43 -0800
Date: Thu, 13 Feb 2025 23:06:42 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Lu Baolu <baolu.lu@linux.intel.com>
CC: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, "Robin
 Murphy" <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian
	<kevin.tian@intel.com>, Fenghua Yu <fenghua.yu@intel.com>, Dave Jiang
	<dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>, Zhangfei Gao
	<zhangfei.gao@linaro.org>, Zhou Wang <wangzhou1@hisilicon.com>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 11/12] iommufd: Remove unnecessary IOMMU_DEV_FEAT_IOPF
Message-ID: <Z67rghQyQrjb5sT1@Asurada-Nvidia>
References: <20250214061104.1959525-1-baolu.lu@linux.intel.com>
 <20250214061104.1959525-12-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250214061104.1959525-12-baolu.lu@linux.intel.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002319:EE_|PH8PR12MB6916:EE_
X-MS-Office365-Filtering-Correlation-Id: b9dd7ad5-c350-445f-c791-08dd4cc62b3b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|82310400026|36860700013|7053199007|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Dl58yX+4hdtuegi7JFWKl61F8s3/3WX7/pAaff6qr7bhF0xlmCA/TMvxQEaU?=
 =?us-ascii?Q?Llhyfi6IbCPDzx5p3bjAFnr3RnhqWSoJr42Waxl/sv5iH9jXtLfHzJeJWE2h?=
 =?us-ascii?Q?87oR1YgW3dwaspVXsuGSbK0ONNhPMPqsZ5KY6oZd4GB3C6GuYCmQ203d6K2v?=
 =?us-ascii?Q?hXVXB80f4G87FlYIusNYQa/j/eIhuwziRPuPOzlfCKNpnT0xKoLzKDn7L3wC?=
 =?us-ascii?Q?SYtzzbRHHfNeL5quhAV50PjIOz118REYuWqSunzIRAUBqEN3HUbMwNFZwNdi?=
 =?us-ascii?Q?z+6OqjB0D3HWkRBa7Fhund/NZaXKSNUm1amt1hIEj8ApoChPHlmd1aicUzQf?=
 =?us-ascii?Q?GASznW/G1GCCuJFn9pDUuFIqkLsFtkyNEgdZpMopeqsWcyLhYARjUvcSXQMo?=
 =?us-ascii?Q?iz4KO5Mn07IOBsUksOURiVjmFA1hQx+X0zT6L18g8U84v88dioE5l4B+YkaN?=
 =?us-ascii?Q?dS2vUZrJoP3QnstCgvpMtIvL3ZgVPzLbUYVBcEeHNbVuRxlZW4FdAUaLaZ1r?=
 =?us-ascii?Q?nRWo+0sgB4s866kWKXTPt8Tgj7gwsX4w0O161UKMZYosKOSDOizW4LiK/PTk?=
 =?us-ascii?Q?7a30FCiqfKMJhMWntSvs7l5Q0NHYr846OIXURmP0tR5/ns/LFDZRjCOtKBvG?=
 =?us-ascii?Q?4ZuDa5DNm7zOUqFqZSwCkkLzKEa4CnrvCxq2OTq5S3cfQtqPkyRjBBokSvEd?=
 =?us-ascii?Q?orimIu8+qKnJUBz+F30y+vmEC5ikxPf9AHuOUrFr1dTG9fVqPsHn+GBn8N9E?=
 =?us-ascii?Q?7qYM8ziyn/5tDYCEv9hT0l2cg9qbFD/jBRPqJOFL+LVo0l/PdKFlsztiNoRH?=
 =?us-ascii?Q?aHP8g2YPvXR5iUxIzv4FeN2sF198ymJ1mlEHw3FMsVUMrFz76LFiMAQUeQLR?=
 =?us-ascii?Q?LYJIVBIRwKOZILPgfHbNjoI1B6IzoKmQikoQK/bYkbvrxpDWTOJnxTJCSVjX?=
 =?us-ascii?Q?Z+5qEgAm5AMeTs/6jNeMJ7u3lPX1xYmqA30L7EK/dU/v2uOhJveF+TxWL1ED?=
 =?us-ascii?Q?oH2Z0mgkS7qKCM18u5svtpfQdjKn7L0HKQam4Npgk2z1tI5ulFNvVEadMRNd?=
 =?us-ascii?Q?lurwzNRAUACOWRws6V4kuHb/CWR4WDWSKC730jQxCFkRmVXt4QR3UZvH4ufc?=
 =?us-ascii?Q?w0Hym/25XH68J8TBKyp9O9Srz+NKMLtsrepO4VG/YgE2006CkUlgfGvqu4ox?=
 =?us-ascii?Q?HSQMEILlGcUW6YbC+9CJNiINb8F33YbQkbSItp2sZuHbgMWwsgbY2yES9RoQ?=
 =?us-ascii?Q?9q2xEquRGTQRPiUQL2rGjPQk8xnrjQh1CpaPzFccULNRCiTDfzTjDo/wXYkn?=
 =?us-ascii?Q?82TsNpQFqlFAXMQdsaLH0SQs8QDzzGONOFqoAlBtyFDxn1lKyr0C37rfBumC?=
 =?us-ascii?Q?MOuhx3lL2NvaRuhaZcwkLE76ArlcrJ2/tlpMmem4LpEkLlQybOZOloJNmLrD?=
 =?us-ascii?Q?ggIJXH1mDp9LEmXNGDCGVMZ0hlRRa3vbx/UVtnHo0tPur/XbXt1Ma5oQGbeO?=
 =?us-ascii?Q?zueKhOG5JQb1bNQ=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(82310400026)(36860700013)(7053199007)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2025 07:06:56.8739
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b9dd7ad5-c350-445f-c791-08dd4cc62b3b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002319.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6916

On Fri, Feb 14, 2025 at 02:11:03PM +0800, Lu Baolu wrote:
> The iopf enablement has been moved to the iommu drivers. It is unnecessary
> for iommufd to handle iopf enablement. Remove the iopf enablement logic to
> avoid duplication.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/iommufd/device.c          |   1 -
>  drivers/iommu/iommufd/fault.c           | 111 ++++++------------------
>  drivers/iommu/iommufd/iommufd_private.h |   3 -
>  3 files changed, 28 insertions(+), 87 deletions(-)

This is in conflict with my fault patches that Jason just took
a couple days ago:
https://git.kernel.org/pub/scm/linux/kernel/git/jgg/iommufd.git/log/?h=for-next

I think it needs a rebase, perhaps on the branch mentioned here:
https://lore.kernel.org/linux-iommu/20250213150836.GC3754072@nvidia.com/

Thanks
Nicolin
