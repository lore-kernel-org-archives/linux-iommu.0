Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2057.outbound.protection.outlook.com [40.107.244.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6BC86F06A
	for <iommu@lists.linux.dev>; Thu, 13 Jun 2024 17:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718301041; cv=fail; b=XS16ktK+mx1yr7CETmdlFG/GMG32J3rSAQxye3oc9q7m++7HS2hZgbgJKThV42SLfkVAvvJCdSEZiYRxdGgbky+33r48WwB0aq6qGxfZZeCbdh9rKLwNNmQQ07v3OBn/LV53sIICfAlDKQ1DBjcgZXUXlk5jeaKOWKbqaoAPceg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718301041; c=relaxed/simple;
	bh=ORu2C9HvVf5KHw3uuqCUTsK33SridGLvBudDlHiZWDs=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WHLsHrXjp5JCgcwlqmzdmFozmbhMrgTlC4rmp2PWRzfkZW0wnsf5JyzfTi50ThWRbT12OjiCSWMvx4Sf7yockqjPY+AeBK+6xEnCn8QI3IkT8Na5Q95DxhxXTXFM6ze/T6zxcAtC5s1vEQAl1RwV10PATRbgM9GKDAWq9f2pm/c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GWCbSyd9; arc=fail smtp.client-ip=40.107.244.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GWCbSyd9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HTa2V1d1FmbP5/49QTAo1uCv+HfXZOe1Gc/70v3EBFY7T9ivUA/tWy1lnyrv7weFub54uCNDNRsHPfxhCjATcg6NrP3hDWX3AQcm7XMXNAXUdfUfXwuk6BhNWnG/e/AQpiZeuXDMAuX9XLjJJsK5e+JxVAoaMFLNz56FY3L/Fy7TVdN1rH3eQIZX9sDBGN2Uck5hGOM8QdRz7vyePqNzU9j0/4T+CzlqLbG7JfS201bm514HA12R3ZKki6aMnLu4tVJ8EI5GdriHehYAwyoJno5Mh+bV3QP6Fnd76hWO8oAXPHCN1M9XiyOUvXgz9b4g2TFtNS1XOVJLMl/2Y4Nm+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=45TuE/GLIiHzBKokL/tPaymWOIlQcBj9oih0BIFF86g=;
 b=XFJAUHkqUBz3lau47Bti+HL6CkQ8Wm1SLCelFfx6ebqk4jOfxARCJxyNkfV53NNWeYVkIXucoNpnm2bWWjBJmvJ72h1VgqprEVin6uBUeEIkySJbzJUmSXKHh0OzKq9PqBIYy8wUW4nEkhGxydI095ki8G7TcnLV8fVpZzO5Ysy0ei+jRS4tEZHgAOtYvpHJPSz/MGov9ww22bb0ROrDUEBqVSmNN7RL5MzwRIRTok9yRr0oJbzkV1lDblGBhjOXLCyyYSOD4SINc/HghpCNp5f5dNh3oDo1n4mnzUCbyXuGdHK0Sd+rRmbDdZyU0reaVaFr4klQG+fUiTPMxEd9qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=huawei.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=45TuE/GLIiHzBKokL/tPaymWOIlQcBj9oih0BIFF86g=;
 b=GWCbSyd9psWv9rHOWa9cQg47cuJRkXIV4CLMA2Zv+RM9odWocPTwSOfL4sG9xG6yZ1jW27ZhKzHnxDHce9TE2iUc7lpeDVOERBysRog4SxYT/tTsMAdaZTxygRErlM6WEdeMTDPe46zujSJ4/BIn8hZEEdeO4nNhiVVuJLnpGfY3N+uiYgEoonGUWhkau/13re56k0NhGMPWVgMiNHcVdzvjVJTnkVWcDacUUhNPD5bsvEdLxFUzmVGEZn2D6uHTaTiuTpR8Fm2DaSUThuYPfSzqTNPC8XQRmKdW+NM3mL4f84+disN7BB1fVntQCzgEkcJ149c6cgMvqIi0B1DAIA==
Received: from BY3PR04CA0027.namprd04.prod.outlook.com (2603:10b6:a03:217::32)
 by PH7PR12MB7162.namprd12.prod.outlook.com (2603:10b6:510:201::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.37; Thu, 13 Jun
 2024 17:50:35 +0000
Received: from SJ5PEPF000001D3.namprd05.prod.outlook.com
 (2603:10b6:a03:217:cafe::80) by BY3PR04CA0027.outlook.office365.com
 (2603:10b6:a03:217::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.25 via Frontend
 Transport; Thu, 13 Jun 2024 17:50:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ5PEPF000001D3.mail.protection.outlook.com (10.167.242.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.15 via Frontend Transport; Thu, 13 Jun 2024 17:50:34 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 13 Jun
 2024 10:50:19 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 13 Jun
 2024 10:50:18 -0700
Received: from Asurada-Nvidia (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Thu, 13 Jun 2024 10:50:17 -0700
Date: Thu, 13 Jun 2024 10:50:16 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
CC: <iommu@lists.linux.dev>, <linux-arm-kernel@lists.infradead.org>,
	<robin.murphy@arm.com>, <will@kernel.org>, <joro@8bytes.org>,
	<jgg@nvidia.com>, <ryan.roberts@arm.com>, <mark.rutland@arm.com>,
	<kevin.tian@intel.com>, <mshavit@google.com>, <eric.auger@redhat.com>,
	<joao.m.martins@oracle.com>, <jiangkunkun@huawei.com>,
	<zhukeqian1@huawei.com>, <linuxarm@huawei.com>
Subject: Re: [PATCH v6 3/6] iommu/arm-smmu-v3: Add feature detection for HTTU
Message-ID: <ZmsxWOmR13KyLc9S@Asurada-Nvidia>
References: <20240613144149.38672-1-shameerali.kolothum.thodi@huawei.com>
 <20240613144149.38672-4-shameerali.kolothum.thodi@huawei.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240613144149.38672-4-shameerali.kolothum.thodi@huawei.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D3:EE_|PH7PR12MB7162:EE_
X-MS-Office365-Filtering-Correlation-Id: c5e67a43-a295-43d3-fb8c-08dc8bd15362
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230035|36860700008|82310400021|1800799019|7416009|376009;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zuIm4gP4NjG4NFzSMKk8MG7rZxKS09KiqsA9A72iEQYEMa+DNE3uCK3gYMik?=
 =?us-ascii?Q?+hGR8LtcZrh5i5Xs9/wGdeTESs+VCc3pgKuRKk8KHTopf5BiyhhUx/noxm+U?=
 =?us-ascii?Q?IKxcj94hIbf4sRfa2t60bf5m4Ai3lPk6uuY2L+4A7HfopMePqRQ+Ovohl0No?=
 =?us-ascii?Q?CBI4LX7RdosjfUsLKKh1EEginOspz01J8BgwemD9E2VoS0+JgJxziDTibHPG?=
 =?us-ascii?Q?fCKoMberfkth5Q/2WzQPY50He8SXSvczeaDpkHa1mHLkjs01r1rmvPqebAio?=
 =?us-ascii?Q?w2QTHj+8r54MR6ritS5F/rFXrltzudW6kHh9A/27VAulGJLOe0GOtfN/jytB?=
 =?us-ascii?Q?TB3xCr4gEQz5T8pq+XeRDoJtZSrQuhY1mcJSn42FeIjZ3fY4vf69rVsJgsSz?=
 =?us-ascii?Q?RhFUq02+zXn7CAE5CwRQZfOauxI6K0VCg7t7vf3szf3TDKcKYE/ZDTt9sDB4?=
 =?us-ascii?Q?sjr5CGSgAfJE3WVZJsvv8ZVZkFxQ9jMz35zlif0BXeUvZsGxh6/b9Y2Xx36t?=
 =?us-ascii?Q?scMur4v26UbPt3IaJPOGlM507l7oPr7HonuhaJTL2b3cKEoTyiAeAchr4Mdj?=
 =?us-ascii?Q?fL8pgdkBx2eHvOkNmV9jkIvPdNj2P6JwC7eTJfGXoPoanG3YLSd7Ozc5bt1l?=
 =?us-ascii?Q?SngYsUfm7lDCNNgNYuvMAMJYl5/3CRrXhh0lTR+zr6ZPCE+H82rZodo8yf+j?=
 =?us-ascii?Q?c60MnSStkI37bpbLedE1lVWr34tVD8SInL1le/uu/KiLQK+H7zVuuZjBHzo3?=
 =?us-ascii?Q?Mf8R4xSoQAoo/Nyw28UUqH8JpVF6eAVzS0qnezckloqWi5dZspUPHpi7opEy?=
 =?us-ascii?Q?d/msm0r+lmQ41SUJkV9jcA3EatyX1uAvLDZWsABN3A0EEqm/gNbPBPOrVSre?=
 =?us-ascii?Q?AFl02u6bTv+rkCL2FJFi4ouCRYa+QWZaEx/Ae4aGWezUUYvovgDPIl3TKfF3?=
 =?us-ascii?Q?z+Gc6K60sVbJlViUwxr6jVBm2BIFHy1jiJIdOyc/zNPs1R3XE47eyNSBBJ23?=
 =?us-ascii?Q?N4CTKlz+LbBT8iSzmarJ6NNjHPPLngnQrD6EaaBLF/6jgF2KDi77P0rWZlHN?=
 =?us-ascii?Q?glEdZA78r6zyIGVQ9+nqG/A15zKzuCDVL7W2PKRi1ON5cf/DKIRKFHpsMATU?=
 =?us-ascii?Q?bHQdD2hFV7QlLivdiX04iI/KzeDPVr9bnRTta6svTuq5tS2vfoSKCy/5ej0U?=
 =?us-ascii?Q?C6JfttgtOanbx4dmxT91OuYJlttU3mlF4AWIwf7rzHVcS7hfrhoNJ6TWK7N3?=
 =?us-ascii?Q?4Xeil44TJTy2P0+HoTSpG5KRgCVnjBS3J/QtwHsAAavDnOP1A3GIe0E2KtQr?=
 =?us-ascii?Q?SKodTANqf6p7nM2Wb17W/SqvtunIpV1iFPPWcwG13urbXbWcYUy4OtuIE4xo?=
 =?us-ascii?Q?g2yAHI28mF/DcvGXhMZ1YnoIURZd3fsxyLg5OiyNf+2iG2Isxw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230035)(36860700008)(82310400021)(1800799019)(7416009)(376009);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2024 17:50:34.2720
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c5e67a43-a295-43d3-fb8c-08dc8bd15362
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7162

On Thu, Jun 13, 2024 at 03:41:46PM +0100, Shameer Kolothum wrote:
> From: Jean-Philippe Brucker <jean-philippe@linaro.org>
> 
> If the SMMU supports it and the kernel was built with HTTU support,
> Probe support for Hardware Translation Table Update (HTTU) which is
> essentially to enable hardware update of access and dirty flags.
> 
> Probe and set the smmu::features for Hardware Dirty and Hardware Access
> bits. This is in preparation, to enable it on the context descriptors of
> stage 1 format.
> 
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>

> +static void arm_smmu_get_httu(struct arm_smmu_device *smmu, u32 reg)
> +{
> +       u32 fw_features = smmu->features & (ARM_SMMU_FEAT_HA | ARM_SMMU_FEAT_HD);
> +       u32 httu = FIELD_GET(IDR0_HTTU, reg);
> +       u32 hw_features = 0;
> +
> +       switch (httu) {

It seems that we can drop the httu variable too. But it's quite
unimportant, so let's have it as-is if there is no other reason
to respin the series.
