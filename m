Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012007.outbound.protection.outlook.com [40.93.195.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1B7C2874F7
	for <iommu@lists.linux.dev>; Thu,  2 Oct 2025 20:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759435565; cv=fail; b=JfDxEiKZVbn67dOw22/1ZRSkrAs/L+DpjhEg+9Sq6sMlPyMVep1Fm5h9vD147kd0w8XKbFWfOeMK0eSU5csMe44pwYzMFzqr2df3iZR9Ret/6R5Fkmg5yrempWZYMHyfIDhyrcNx0MGan58Z9wA+uA9GiD4MO/3jx2btrMU+gcc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759435565; c=relaxed/simple;
	bh=EEMNVO+9IbRM4NQ9fUgz63GM6Xl7T6Z6J5+aabM9mjA=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FO7EwOHbVg+WkV+lNhN8z6O9NQaHb5vB6fpUX0IYsW+4suE7ONPbwXon1cT5WFJoVr9UDkpLTTZl9uwEqk95neiiUy5VjqRHSD4sa+oU83NtGozlaUgRG7NQ227CwRuGk6n0f1MzVRo/fJBScc0flVCC+9mUcUDNBdb694U2MFU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QMth4Ych; arc=fail smtp.client-ip=40.93.195.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QMth4Ych"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H5ZtVdLoVmqeiUOXmgOmxaApkOoVbqLXrCyDbK2xjWn7gQUI1JQD5CHmzIRkVE4/7a8FeckDlbeWJ/vapM1l5aaqCkOw8owLgwe0n1EYnChjlAjUrmmFdu2LGXMUYXzHWwN5pGSq03JVxU1RSeAVBKAqakQnzcLSbOfjBkBab1kO4TKGkKIPkdW1qimTApK6m9MDf8Rx7Gd/Sf6o51NfE1RYVkInpGZ3U57P7ql89DtVjIopxfUWqsm2jaGbHgvRXPDlui4ZsF8NoJSFU3JlsV9d3lYGJGSXVu6UM/WS+c97cSTdph6detGkL4yDCtBhcqnV/eSxr7xFBzG6v2eyRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G455p5152CFs0+diOuSOC55cJDaFpeova0zmMI2iCzI=;
 b=cop2s0K/2Gnv/t3/fQxpqBlC4Mkdf4J+czXNfoyiRFMq3cIWA3AOWoNbaw2+Ejr840V98sWZxjk+JSK2WXs76SWtMdJBj5K0HUIp19dxyC7zbtWZCoJ3vDp7pPdBw/lTyLCN4N52TJyDWRHKgDbAnK9HUffeCF590yiOOcCE6QEUidWqxRdRhndwP+NR4TCIlKiJEhNZrHg9U1BT0IkGCWIcZ4UWs/BO3rq68xXhPC6W6+PQC/4QrAh2i3WsxLwQkVOGrwQtP/E6PUaLbLnAwVRQFHIWQIWdIKFmikrsXvtw0bFfAMC730c5cakvffa/vi32ptmiBiEBWDXxmX2owg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G455p5152CFs0+diOuSOC55cJDaFpeova0zmMI2iCzI=;
 b=QMth4Ych8mSts1/BcU/7T9Mc1vtb6h/3K/IX59L1L3Ouix+cdalwwTSjOcztsa5u66Ho+KiWYJT6JkKOJEi/4mWZzGfG52spmXDVsswvXC5qWgqX57/IqFuz+h1cFDzeIK2p3tXwTM1RYmZu7nd/LKXQ2+w8yXmMdLEPdUBgAwWf5l9UYcPfIooX0mG9JvzjV7q5KgNzsekVrn8TYLpgrEx/vFgkjMADY6aQ9pcLjL1se/ESJ4sOI1fl+aFHpYF5KDbYSnLPP+dfE/S+2bv3zG4egskCRhu8nnJhc+LsiyKkUBRcbTFgcPATH9oegNv0CtEb+S2ho7KxLXWr8c3oiA==
Received: from MW4PR04CA0111.namprd04.prod.outlook.com (2603:10b6:303:83::26)
 by SJ5PPF183341E5B.namprd12.prod.outlook.com (2603:10b6:a0f:fc02::98c) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.18; Thu, 2 Oct
 2025 20:05:58 +0000
Received: from SJ5PEPF000001D3.namprd05.prod.outlook.com
 (2603:10b6:303:83:cafe::34) by MW4PR04CA0111.outlook.office365.com
 (2603:10b6:303:83::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9182.14 via Frontend Transport; Thu,
 2 Oct 2025 20:05:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ5PEPF000001D3.mail.protection.outlook.com (10.167.242.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9182.15 via Frontend Transport; Thu, 2 Oct 2025 20:05:57 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 2 Oct
 2025 13:05:35 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 2 Oct
 2025 13:05:34 -0700
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 2 Oct 2025 13:05:33 -0700
Date: Thu, 2 Oct 2025 13:05:32 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
CC: <jgg@nvidia.com>, <linux-kernel@vger.kernel.org>, <robin.murphy@arm.com>,
	<will@kernel.org>, <joro@8bytes.org>, <kevin.tian@intel.com>,
	<jsnitsel@redhat.com>, <vasant.hegde@amd.com>, <iommu@lists.linux.dev>,
	<santosh.shukla@amd.com>, <sairaj.arunkodilkar@amd.com>, <jon.grimm@amd.com>,
	<prashanthpra@google.com>, <wvw@google.com>, <wnliu@google.com>,
	<gptran@google.com>, <kpsingh@google.com>, <joao.m.martins@oracle.com>,
	<alejandro.j.jimenez@oracle.com>
Subject: Re: [PATCH v2 12/12] iommu/amd: Introduce IOMMUFD vIOMMU support for
 AMD
Message-ID: <aN7bDNTAadHI/+qn@Asurada-Nvidia>
References: <20251001060954.5030-1-suravee.suthikulpanit@amd.com>
 <20251001060954.5030-13-suravee.suthikulpanit@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251001060954.5030-13-suravee.suthikulpanit@amd.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D3:EE_|SJ5PPF183341E5B:EE_
X-MS-Office365-Filtering-Correlation-Id: 85ee8307-d065-47ef-6203-08de01ef19ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uD2aNrupzz7MSYssyFH8EPrhCPLUk8dlTNRDHJVUJ7x6ZiISfYCjdEO53CMP?=
 =?us-ascii?Q?Dys+6M6rpXG8YJnl+gCDoMZ9zY3FENGZN+MLKYpdNRg6xqlmitOTCKCXvkg4?=
 =?us-ascii?Q?3fThNd3k90kLd+nxZy4ka1jVisEzr9nJaaSzptzL2n0N2aGfHwyA7NNCRiNC?=
 =?us-ascii?Q?zuMTzttA/OmnVB6bY4Oj3RCo8/ezFUpXuvEaHa6kwuRWiFMJimpEzR4CMY/f?=
 =?us-ascii?Q?8dEWkiAjfpEYNfmPiz1FfMFSnEUr2jWQUXmzxL3AJWUF+z3aXqbcj0hgIVsg?=
 =?us-ascii?Q?I8s17AF6Y6CQM4MhqGP6BsNJ1YO1fZN2GYCRRFC4o37OFu5zi2EuGJFMv64Z?=
 =?us-ascii?Q?hIYXCEXgbn8VE8iXkwVtDNmGDPYCqx6WLAn4OyEVDhCopKEIe9T9gyYduN57?=
 =?us-ascii?Q?JTMrUJ3oQO6sbGmtvlV46LdVrTM9dJd8Eby/ch4yHqLr9scdmXWv9ThoA93t?=
 =?us-ascii?Q?W8mkXDhqQQc8qFUn8FnV+sSf1CrptQrqSSPNyk5nBtxIEqtqB3saCrUoPQJC?=
 =?us-ascii?Q?kgcadjENvGx3M+JB8Id1MXBUMFnE21cXr87rgCoOZDnxCmhxtT7WWebRYNrr?=
 =?us-ascii?Q?BMlgdj6rzysD6SxKgb3y7DE2g2sqQ301no6Ubwup80SklwUftfhHcu16wgEE?=
 =?us-ascii?Q?Mkc4vm182fajLXr/4aC7ii4rGFPyUvYW0RVQPyc1sz5Fn59t6JELUwKhMzer?=
 =?us-ascii?Q?5yO4F4JZ8gUN8ziZzc27dBjNLS2JHcEp2YVaaJwRgMvtU9NCmlg5ge4Y8DyC?=
 =?us-ascii?Q?BEBR9g4UTQC2o8WTfJLhYJjEsH6u36jGfMilFQu8bzc4rCsLyTBCFp4liba7?=
 =?us-ascii?Q?OJ6lv5TwbPAfh+J2ws6gUvYdPv/WiLxwWDUEIuL4EQUtiPk1yflXWQhrByt2?=
 =?us-ascii?Q?KO8qq5aiVwAntQn+0XcnBOef0MQBTKZCbIKjUAPvcmOH5MTk0kfvyHI+JyBi?=
 =?us-ascii?Q?5noXKi+eD9fHOwvKLSVPjchybbqWB5SL7hH9KuKxz7DeT+Dle/DZIv61x1Wc?=
 =?us-ascii?Q?OKESz55B31P74Zz+Pfy5RxWi5Bo1ILqlXVwGQO6Jrbbz0i+T08RIBfbZtLN7?=
 =?us-ascii?Q?+a7xRdEwm1QPMl5R63ccCpP+Y6NGFsCFiyVjBwU0rIzyRjR6afoovBbPBdH1?=
 =?us-ascii?Q?lxyKuy3Kmoj0BTyKB0LBoSrOzcKa8z/Qc9vyKlkBjd/MHgSwLMqG343Ilrpf?=
 =?us-ascii?Q?2l4Gi14pnngpTOgJ4JfiJ8DXDhtqsFQxmiCitv2fkV36yhMqLnAMygFDDO1O?=
 =?us-ascii?Q?PGwU/HiCgf9s7tW3vCrZ203rbn2qkhUKoB4KaKlgKFMZUdreh3JfEmDAw5Gr?=
 =?us-ascii?Q?txw1a9qBm50YIaKn2DF3E/AC8gjBtygRkJfGdXZVswnyDB7wQpGgFrA1aIKm?=
 =?us-ascii?Q?PsmmM0L1PEN7pEPZPji1IcRRvcAT0r5ub1acNW23IL0Hot3SOeIUTGFwGTIz?=
 =?us-ascii?Q?DFS4nFSHQZzRiZF2XsrxUYiRZU4T2I5GZrPY3letj+SeWElDlg687Xq5V3hk?=
 =?us-ascii?Q?gGO21tHDpQwH+3cwlGS4alfNRXwR67nd55S7VGVqfg14wPJS6nmKlXCKHClj?=
 =?us-ascii?Q?mDwDSJIadYDOpF46t1g=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2025 20:05:57.5988
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 85ee8307-d065-47ef-6203-08de01ef19ed
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF183341E5B

On Wed, Oct 01, 2025 at 06:09:54AM +0000, Suravee Suthikulpanit wrote:
> Introduce struct amd_iommu_vminfo to store AMD HW-vIOMMU per-IOMMU data,
> which is initialized when calling struct iommu_ops.viommu_init().
> 
> Currently, the struct amd_iommu_vminfo and amd_iommu_viommu_init() contain
> base code to support nested domain allocation for vIOMMU using the struct
> iommufd_viommu_ops.alloc_domain_nested.
> 
> Additional initialization will be added in subsequent patches.

This is the last patch in the series. You mean some future patch?

And pls briefly elaborate what is the additional initialization for.

> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> index c1abb06126c1..e3503091cd65 100644
> --- a/drivers/iommu/amd/iommu.c
> +++ b/drivers/iommu/amd/iommu.c
> @@ -3063,6 +3063,61 @@ static const struct iommu_dirty_ops amd_dirty_ops = {
>  	.read_and_clear_dirty = amd_iommu_read_and_clear_dirty,
>  };
>  
> +static size_t amd_iommu_get_viommu_size(struct device *dev, enum iommu_viommu_type viommu_type)
> +{
> +	if (viommu_type != IOMMU_VIOMMU_TYPE_AMD)
> +		return 0;
> +
> +	return VIOMMU_STRUCT_SIZE(struct amd_iommu_vminfo, core);
> +}
> +
> +/*
> + * This is called from the drivers/iommu/iommufd/viommu.c: iommufd_viommu_alloc_ioctl
> + */
> +static int amd_iommu_viommu_init(struct iommufd_viommu *viommu,
> +static int amd_iommu_viommu_init(struct iommufd_viommu *viommu,
> +				 struct iommu_domain *parent,
> +				 const struct iommu_user_data *user_data)
> +{
> +#if IS_ENABLED(CONFIG_AMD_IOMMU_IOMMUFD)

These two should be put in the iommufd.c file, and the header
should define the followings (next to amd_iommufd_hw_info):

 #if IS_ENABLED(CONFIG_AMD_IOMMU_IOMMUFD)
 void *amd_iommufd_hw_info(struct device *dev, u32 *length, u32 *type);
+size_t amd_iommu_get_viommu_size(struct device *dev,
+				 enum iommu_viommu_type viommu_type);
+int amd_iommu_viommu_init(struct iommufd_viommu *viommu,
+			  struct iommu_domain *parent,
+			  const struct iommu_user_data *user_data);
 else
 #define amd_iommufd_hw_info NULL
+#define amd_iommu_get_viommu_size NULL
+#define amd_iommu_viommu_init NULL
 #endif

The core would return -EOPNOTSUPP if either of them is NULL.

> +	if (ret)
> +		return ret;
> +
> +	iommu = get_amd_iommu_from_devid(data.iommu_devid);
> +	if (!iommu)
> +		return -ENODEV;
> +
> +	vminfo->iommu_devid = data.iommu_devid;

If you want the struct amd_iommu pointer, do this instead:

	iommu = container_of(viommu->iommu_dev, struct amd_iommu, iommu);

Then iommu_devid and get_amd_iommu_from_devid() aren't used anywhere
else. So both could be dropped.

> +/*
> + * See include/linux/iommufd.h
> + * struct iommufd_viommu_ops - vIOMMU specific operations
> + */
> +const struct iommufd_viommu_ops amd_viommu_ops = {
> +	.alloc_domain_nested = amd_iommu_alloc_domain_nested,
> +};

Unfortunately, a viommu_ops with alloc_domain_nested is incomplete,
IMHO. If this series gets merged alone, it declares that the kernel
now supports AMD IOMMU's virtualization, which actually won't work
without a cache invalidation op (SW) or hw_queue (HW-acceleration).

> diff --git a/drivers/iommu/amd/iommufd.h b/drivers/iommu/amd/iommufd.h
> index f880be80a30d..0d59ef160780 100644
> --- a/drivers/iommu/amd/iommufd.h
> +++ b/drivers/iommu/amd/iommufd.h
> @@ -7,6 +7,8 @@
>  #define AMD_IOMMUFD_H
>  
>  #if IS_ENABLED(CONFIG_AMD_IOMMU_IOMMUFD)
> +extern const struct iommufd_viommu_ops amd_viommu_ops;

You don't need this if defining the amd_iommu_get_viommu_size and
amd_iommu_viommu_init here.

> +/**
> + * struct iommu_viommu_amd - AMD vIOMMU Interface (IOMMU_VIOMMU_TYPE_AMD)
> + * @iommu_devid: Host IOMMU PCI device ID

Though I don't think you need this, just curious, how does user
space know the host PCI device ID?

> + * @viommu_devid: Guest vIOMMU PCI device ID

This isn't used in the patch, so I am not sure. But it sounds like
a vDEVICE virt_id to me. Though it probably works for the AMD case
because AMD IOMMU is per PCI device (IIRC), I think it'd be better
to define a vDEVICE forwarding this ID. I don't know, but for CC,
AMD might end up with a vDEVICE object anyway?

> + * @trans_devid: GPA->GVA translation device ID (host)

This is unclear to me either, and it's not being used, so I cannot
tell what it is for. But it feels like a part of vDEVICE object..

> + * @out_gid: (out) Guest ID

Again, not being used, needs some elaboration.

> + * @out_vfmmio_mmap_offset: (out) mmap offset for vIOMMU VF-MMIO

"(out)" is redudant.

@out_vfmmio_mmap_offset: mmap offset argument for vIOMMU VF-MMIO

And you could have an @out_vfmmio_mmap_length too, even if it is
just for validation in the iommufd core.

> + */
> +struct iommu_viommu_amd {
> +	__u32 iommu_devid;
> +	__u32 viommu_devid;
> +	__u32 trans_devid;
> +	__u32 out_gid;
> +	__aligned_u64 out_vfmmio_mmap_offset;
> +	__u32 reserved; /* must be last */

"reserved" is useless here.

Usually we add reserved field for paddings, and we usually call
it "__reserved".

struct iommu_viommu_amd is perfectly 64-bit aligned without the
last "reserved" field. I would drop it.

Nicolin
