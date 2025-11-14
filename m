Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013035.outbound.protection.outlook.com [40.107.201.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A605347BCB
	for <iommu@lists.linux.dev>; Fri, 14 Nov 2025 18:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763145004; cv=fail; b=Z01VNrt2n+edkW78u4/9xcb1nbwIeqOl8fHA/kdhvg4MYkvr9Ft/aphhYSvdyZitRJTlpeDGs4l9+xFuGEHs+GUcurXF3Aw5YsaEDjXO6MSI02eaaCOAYmPc2kMhTU9OoLT42aRXRjIrDAeOmSWXHQaqROBLVrK7tS+l6t6Z7LI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763145004; c=relaxed/simple;
	bh=BHQ7E0NG/8Hzlo0tH9MGIE/xs0EJa2ozIiKInIlLw0A=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I3jKmNGUG60aXovnxtyntL79e6RTwreqcRJtskUKYOWVD8xLbxLqzj6YX1O/ncyMFfxK9iGQuH31ZT+zpFrK9uPeMWCX4GBKIuqQyq3bOGX0KuZOOwTsW9KPulmtabbuoPkob8RZoKIFv7MSlnnNQgqnP7NHxBNQOdbzFKqq9ZE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Hc+A5+lM; arc=fail smtp.client-ip=40.107.201.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Hc+A5+lM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=odDP4vdO64x7z5CJCBN3ny/hxTURHEu648hhmR2iSAFEmTkJzrfIhlyUBw3dOir7BXuHwh9WC7q2i3vd1lEtNEOma5+gb7hFL9vCeHPP3wDcmW7ufCiSQCQKMN8ygUsvEw79U9PPPp3Bozxt0KFHV6qlxBTRaK6HMF6KTYMM0Dr2xdd/t6BPjvfjtBvNl5lmzaq59ZMRNC5j0eQaJDIEdLZ3YNdhEAgDqEiAJgXyQhKN1MYuaGXItfzVhGIcAxCAnbXj8oQ1D+C6n4t11AtTf8neg4WPD6kQiQAUAHChvDry120/3nDaCMJ3EzwSEyv1IswcWoVJMo4l1Asb7N+qZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yBNnf3pwWXqF8bR4kthcVktKNM635aKZo3LTBXa9Nyk=;
 b=sJKvzhjdROJffUYZIuHcKy42w42OS5Uk47/SSx1J1qfXhJNma+fCZJh+VjPRurrss8GZ+3CvLopMrfshy6R2m0CD3by72R5vTCGortWMXWguPmkXSFFFNNc1BRZJafd0HXvzhUPa0NnHE8uNqCKhzD6D5oK0ZqDKjTtnGf4PVhHpV2imYHRbQ9bt1LpnpWpd5ChBGJ9pcqd2Wt7e3632K9e1BGObcEI/HPCA5OolW7cLvjtCuGWHnui5t2HcynE4ajkUlL/Nn2ie0zWdtEupIbWyRVDw2GHRiU95/BT0PjVVmTZKIIObq/A15ZHyacLtBNnzljGY+lQlUZPdpK0v5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=linux.microsoft.com
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yBNnf3pwWXqF8bR4kthcVktKNM635aKZo3LTBXa9Nyk=;
 b=Hc+A5+lMYwjSDxfzgKZiJ7h729epVyEkYdBBBAmjMx+tGsE3rmn+LE5dtgwhhAL4FxgVeig2QJ9vjD0UsHHWS3mdqC7zfvKRyBy2V60RPfbQmvpZKDxxV4bZk9gPOVWW6JqahsR9TCdcagYXlM+/F6jQuEDd4TSj7r1rrlPa4f+0djqjSfEQZs9I4YHV5kAQDojThhAhYL0MysZiBo7hs5Pu8HIA+0XQpLHLg/WykU9Ysi41fCkJozaWbFhIPYpgWprmBiAZSCRtM7pgZlpx6mbB+0Jt7StbCz6rX4y1iRXbim+4O2TVN5KTJsymyWx0mzRYy/K3+TG3Kj36r7ZCvw==
Received: from DM6PR03CA0078.namprd03.prod.outlook.com (2603:10b6:5:333::11)
 by SA3PR12MB8045.namprd12.prod.outlook.com (2603:10b6:806:31d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Fri, 14 Nov
 2025 18:29:58 +0000
Received: from DS1PEPF00017090.namprd03.prod.outlook.com
 (2603:10b6:5:333:cafe::e2) by DM6PR03CA0078.outlook.office365.com
 (2603:10b6:5:333::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.18 via Frontend Transport; Fri,
 14 Nov 2025 18:29:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 DS1PEPF00017090.mail.protection.outlook.com (10.167.17.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Fri, 14 Nov 2025 18:29:57 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 14 Nov
 2025 10:29:38 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Fri, 14 Nov 2025 10:29:37 -0800
Received: from Asurada-Nvidia (10.127.8.11) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 14 Nov 2025 10:29:36 -0800
Date: Fri, 14 Nov 2025 10:29:35 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jacob Pan <jacob.pan@linux.microsoft.com>
CC: <linux-kernel@vger.kernel.org>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, Will Deacon <will@kernel.org>, Joerg Roedel
	<joro@8bytes.org>, Mostafa Saleh <smostafa@google.com>, Jason Gunthorpe
	<jgg@nvidia.com>, Robin Murphy <robin.murphy@arm.com>, Zhang Yu
	<zhangyu1@linux.microsoft.com>, Jean Philippe-Brucker
	<jean-philippe@linaro.org>, Alexander Grest <Alexander.Grest@microsoft.com>
Subject: Re: [PATCH v4 1/2] iommu/arm-smmu-v3: Fix CMDQ timeout warning
Message-ID: <aRd1D5L1bLesPjeG@Asurada-Nvidia>
References: <20251114171718.42215-1-jacob.pan@linux.microsoft.com>
 <20251114171718.42215-2-jacob.pan@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251114171718.42215-2-jacob.pan@linux.microsoft.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017090:EE_|SA3PR12MB8045:EE_
X-MS-Office365-Filtering-Correlation-Id: 64e6f739-0581-4922-a62c-08de23abd09b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|82310400026|376014|36860700013|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?H0mllopFyCqEj4kvGQgXayEkns9Jmc2pl2thDAnG2MPal9+3Jhs37aKqH2sf?=
 =?us-ascii?Q?ck96e6GNiM+DwAWNsEA7HR21o4EV+xhyZZLZ7gi67e/Ews1FnkL6idftR9il?=
 =?us-ascii?Q?FfyH0zw7LbMOzCV7JKSPDDYyLiAKe3RJ1YJBQZlCoxdsOuLLwKXCZKZxDDtn?=
 =?us-ascii?Q?KeAYJOPtaOP9bZcN+HPx5pkn4Wm+7/41fWSyDPWibGmpPmEHFNeBDNY67p22?=
 =?us-ascii?Q?iF+sa6CoCCcfW7Ie1CUkm1rogpae0+IV7qc0xb3yEeISOl/bkLWmLKJoCnUA?=
 =?us-ascii?Q?xPZB+zhnEmw16uEq9f377vDCV7CSc2VzHgSURV9c36mtTlT2MM0kubVyR1hQ?=
 =?us-ascii?Q?VHlt8os4KQ7/BoM8Xp7+BuduoRG46C6H3PRj9ePNh71RkPVlWO0n0xIFUDuN?=
 =?us-ascii?Q?m4IjmJwoKPb43sYh/IJtoeTyEDMPmzus1UyuLPkcJc4wNfu25tH9LNuWMPCt?=
 =?us-ascii?Q?V8cuqce0NByjOKXIZGGu/raeFOSxig9FhI+ZUf5937BP8RwwYIHTmv198RUp?=
 =?us-ascii?Q?HyO6zdcNRLYuDHGQTR0fSIt7iKx9IKMXDSMyQxlzloeLsCpUPKLPNIFezaPZ?=
 =?us-ascii?Q?Rm/RUGPQcf++tzjJ2gh3+ufYIwpUcb/Ms0UAXAvhgmIxWUnXFkwugSBemKwt?=
 =?us-ascii?Q?pcl/ZaFs8kyUvDyuC+80Gcpgxh7+hyPDKQFEL5ftlQ6AvFWjDwVzCxTS6Iwf?=
 =?us-ascii?Q?korqg6FgemVOKcpgqA25T8/UPi2dxKEnSBXwK8bHD44G6xUJ3g48clrlmfRg?=
 =?us-ascii?Q?woah9/ZmGwhgqVvXEc9kgpggF+ShOzm2Haj/n9iDwwk9BiDk3HT6VdRFmQ5O?=
 =?us-ascii?Q?fnHoP2CSyNlOqUhJphwdRHOZSM5+mNFIYZmq4G9qYmnanJCqRbBhHImNGXA8?=
 =?us-ascii?Q?+he8Un40H33HymohLouiP4QXq5RrI4hMqI+TPueWZ4isS0xSKZI9K89xy05N?=
 =?us-ascii?Q?L4vKNkhk7KiHQt98EWfo+RbhqmPvoyUDkAuY0X9V5ZWL/jPOfStmR+uswqnB?=
 =?us-ascii?Q?3c7QSJqcwdySGOsbAqWzsWZehU+04OToOUDMpTdr1HQ8Y0G0Ofmqk6drRgYj?=
 =?us-ascii?Q?gDvvF4uUXRJsRdExZcF/PT6/E9iDeY+obW5x6pVnvhpK6xj/As0TJhBsNuVT?=
 =?us-ascii?Q?Sxo2a6EPFz7CY5mTtfAUDG75h9Ot6+orbt4jVR8j/U12uPnbPVLkYCrJSQg7?=
 =?us-ascii?Q?5PUh4P6ONNrhzfhwmjIWpQEY6DhdgqZerQ3wkF0haiGblnxB49lA+lMrQC6W?=
 =?us-ascii?Q?HKPztOlkbHN9tWQlioj356ehHGKLUDLy106v/Wlm0ySQyTO58b9joEgwl7hb?=
 =?us-ascii?Q?3tbcUNEBrdpJWwpvmVBxXW7ONaqtwCKIOAT/GVfoD0mU+TtP3WTADW7Hw1p/?=
 =?us-ascii?Q?EFrfuikV5Z7jJCCXVG5zUWDov6k6IX0Z2BL9UiPVPcnt+Nw8dPUCf16jECQU?=
 =?us-ascii?Q?bDCtGXogx6DeznWi+vQttV84s+1PbZu+9iD37tpODZfF2sRx/F5rGKGy21hM?=
 =?us-ascii?Q?MXik81AJbMV/VV8Lv/wX8UewyV72K1XZhNen4oQ3BX48jGwkn/O4jPNQydaX?=
 =?us-ascii?Q?LQSEbT2IRHpzSEbNCqI=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(82310400026)(376014)(36860700013)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2025 18:29:57.8116
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 64e6f739-0581-4922-a62c-08de23abd09b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017090.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8045

On Fri, Nov 14, 2025 at 09:17:17AM -0800, Jacob Pan wrote:
> While polling for n spaces in the cmdq, the current code instead checks
> if the queue is full. If the queue is almost full but not enough space
> (<n), then the CMDQ timeout warning is never triggered even if the
> polling has exceeded timeout limit.
> 
> The existing arm_smmu_cmdq_poll_until_not_full() doesn't fit efficiently
> nor ideally to the only caller arm_smmu_cmdq_issue_cmdlist():
>  - It uses a new timer at every single call, which fails to limit to the
>    preset ARM_SMMU_POLL_TIMEOUT_US per issue.
> - It has a redundant internal queue_full(), which doesn't detect whether
>    there is a enough space for number of n commands.
> 
> This patch polls for the availability of exact space instead of full and
> emit timeout warning accordingly.
> 
> Fixes: 587e6c10a7ce ("iommu/arm-smmu-v3: Reduce contention during command-queue insertion")
> Co-developed-by: Yu Zhang <zhangyu1@linux.microsoft.com>
> Signed-off-by: Yu Zhang <zhangyu1@linux.microsoft.com>
> Signed-off-by: Jacob Pan <jacob.pan@linux.microsoft.com>

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
