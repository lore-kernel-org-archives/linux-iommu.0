Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2084.outbound.protection.outlook.com [40.107.92.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4349B22F08
	for <iommu@lists.linux.dev>; Mon, 13 May 2024 04:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715575302; cv=fail; b=S+5TQgUdx9jLYYY7D6nzas5EV9fdDj+fDCRX/UZpybuWlQwkhFnxOyvSDLgLd/1a3FKj65ecQsyGJGf/du7M7PfbgDubUc0NNjXfAAkaRyk5I0XLXF8DXpFWUfz9esg/uslJU/ifsf348vDeBMZkbCJO1vhDSR+RCFvudE4EiiQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715575302; c=relaxed/simple;
	bh=g0YPbXI/ven5yTYtDhlAorCYFSdl3hYGQJYdJwKhMNU=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m3zv5OlBHtw+Ku9hh5V5r/bWhiZ1eQ6gdmMrREctMWuhUHAekb/wbR5Q+LZG7ftTnlhRkMQxqt79h12SVPo0KMQA6keBoaw21bd/5uRVo/JOre8yFK49gEESdop2dZZiQqHgvqYBUSbQx0CuvQWBFy6QKN6ykp1lanMBqcZQTz4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=eLKSFZvi; arc=fail smtp.client-ip=40.107.92.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="eLKSFZvi"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VPZ/D47yXezXa1GpHJ03kulTBWgii7P9YehgUIkYuLgtdeKnNuSEOg+PFhsY3hr9lfWdqjO87xSU4mfJBzHk7VSjNwvK8i9B9tq4grfh1MCPdqGL5xHpb+St7IGnZrXOQSp1bKhMx5FqJFXi8eyQIFN71cu2QuvM5hX0p+u7n4rlibDxzGQ7Tabd2xnTU1W4ry4cVBPDbEREHbQiUnbGbzAenRUgoWymYWbAhkBffO7MgpkUKTZcEiQZ1McV2YdQTNpFK4420C8pJI4/68qxaOyWjUUEVHSY3HQNcKaPm0WxO890o0/nAuq270rCHfqn7KLvVTzyrBdhaVP+rlIwLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9BiAkJDe4FT7gkzs2WEROXalACr1RS5l+mknpigm4gE=;
 b=ntu77oXzOrSRa7J9fqoYsz5KSHhKbp6lC/PqllMesT8EDpITqNanB7h//EsE/gdMyczqCVBSvAceh2c5jdwoz02q3FycrONgG8GsOMYhZiu+mhbzHc90000GyJ+SSK4yCJaFidCDOV+WD/dpsWroOIBTXpCy6cvT30ziMIJ81l6Fl9F9iN0IaluOCXnGB5Scz493Ap13Y3mhzGRnAt8QFQsipDqAUKnhQZbyreig6Z44ILo6iUh8dqXVzYwaMQa749Jo1goalici9p2Haw+1gytnYbOELB4UnRuWQh38ac7oCaDVrivzcciQE4FzXjRrL3b/OxDV3ahzIEjC58wZ0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9BiAkJDe4FT7gkzs2WEROXalACr1RS5l+mknpigm4gE=;
 b=eLKSFZviyqlCqN+skz/WIoACkkzxB+e8La0RQafF14CzunAOXICjINgxMcR/q9sojC4LQ0dmCmWFu//3gocU7HNN4VHjOR4g3u5E6TGFty1X52M3kmoIZ+dV0IrcAvXmwPK9StQlFZloP6zMSQfvWZZSchcQhKhmighGD8519Ztp0SkCbMQ9tB+0/ygxQZfz0FDtvM1UjXzUVeU2J6bnY6EGxxyn/kBAozlyvQBsijRBMtGB3CPEkwMlCdq6+CGLyTzX79u3IcgotJDcNnq1cJ7H+RZPqiSV6cs1G8Lydh3DhlXsqTT1LUydK3GM0JO9WTCYfaD7TNvA5jTBjol0TA==
Received: from SJ0PR03CA0108.namprd03.prod.outlook.com (2603:10b6:a03:333::23)
 by MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Mon, 13 May
 2024 04:41:37 +0000
Received: from SJ1PEPF00001CE8.namprd03.prod.outlook.com
 (2603:10b6:a03:333:cafe::ca) by SJ0PR03CA0108.outlook.office365.com
 (2603:10b6:a03:333::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.54 via Frontend
 Transport; Mon, 13 May 2024 04:41:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF00001CE8.mail.protection.outlook.com (10.167.242.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7587.21 via Frontend Transport; Mon, 13 May 2024 04:41:37 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 12 May
 2024 21:41:28 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 12 May
 2024 21:41:27 -0700
Received: from nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Sun, 12 May 2024 21:41:22 -0700
Date: Sun, 12 May 2024 21:41:19 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: <will@kernel.org>, <robin.murphy@arm.com>, <kevin.tian@intel.com>,
	<suravee.suthikulpanit@amd.com>, <joro@8bytes.org>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-tegra@vger.kernel.org>,
	<yi.l.liu@intel.com>, <eric.auger@redhat.com>, <vasant.hegde@amd.com>,
	<jon.grimm@amd.com>, <santosh.shukla@amd.com>, <Dhaval.Giani@amd.com>,
	<shameerali.kolothum.thodi@huawei.com>
Subject: Re: [PATCH RFCv1 12/14] iommufd: Add IOMMUFD_OBJ_VQUEUE and
 IOMMUFD_CMD_VQUEUE_ALLOC
Message-ID: <ZkGZ7+37HnLlT6Jn@nvidia.com>
References: <cover.1712978212.git.nicolinc@nvidia.com>
 <b0ee53af3f59602834e67ddf86c748ca304da175.1712978213.git.nicolinc@nvidia.com>
 <ZkDZ/YO0jqZOlRtA@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZkDZ/YO0jqZOlRtA@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE8:EE_|MW4PR12MB6873:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a2b4760-8b87-41ad-e00f-08dc7306f97f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|7416005|376005|1800799015|36860700004|82310400017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jBFqUFoatkBznTin2qJwkVR7tUDCKQdOKBaUyMzEjgCl6FsO9kwnB5Q8n3Sp?=
 =?us-ascii?Q?B3YRaOMvfsiBmBx/PXhDN4ud5C0BqzHMIeNb8GBlyhDAEW8YjOPbmOhIQayJ?=
 =?us-ascii?Q?AU6nP8NMCnOyQ4HHLvNJzxmrg2a8khooxyGOsts6SpHL/LfANiw17liEC6yJ?=
 =?us-ascii?Q?0mxcCY5IZkDkwz9ayIH1qnK9e6sB+eo5OEi7Kfgq+19x4t8ke5j3O46tbE/s?=
 =?us-ascii?Q?5ZgkSnosMgS7hCJyaVHIJOxdXJX/3N6IoRH1A5FbuFBJY3k6o2DDsyyt6IO5?=
 =?us-ascii?Q?kOMh3J2Anxt00gXFZQn2MTa+bowzRGaxqd/CMFdCZ2PLEHvMPqMRPcafVBav?=
 =?us-ascii?Q?P/k7nUzihY66+zJ6dPSwhVZhZFFs9P69rgvdu+CAAdwgkOKM+xbj0YXLwuOg?=
 =?us-ascii?Q?pfazUpEnJ1nHorJcp9AXB0IgsnUXJBrTyCc2s+hhJf4TIow/k7zKUsaXqDhv?=
 =?us-ascii?Q?ONF6UAfkG33VTvYux9fZnrqf6xZ2+zYLe8jUJjqL3h0SdQ0iGN2aKXGtRAZ4?=
 =?us-ascii?Q?+cHT3Nd8b9TZ+yK7WgPwzmP4BPh1O17rkfCtzKAjwuUJVJTdnS/HyI1SPAKV?=
 =?us-ascii?Q?IWqOvXHTga8oJUch9+9gPnt15kyJI5sYJ5DOJbqhTqtUlVvJJESVX+wgNnJd?=
 =?us-ascii?Q?KujbURERXg6L1UrnCJdcuFoTyV4xs3WXbN/SgcpIvl8G4QbmWurTyEYC9wpj?=
 =?us-ascii?Q?HR99iq2Pdxfc1ka9U3IZncJ9Laq5u2lPaXhdOLs+PtErZ9x0v/a7NVzbwRCz?=
 =?us-ascii?Q?15h4a16N4LEiT+/VPruajEPZCX3TICp3MlmvUaWUcjx0Q9mv/b6ambvS2OhT?=
 =?us-ascii?Q?4/d5uy0K6DZUmDhYS9cHrXlIAwKF6VWjFFqkZzeAOls9dPxSB7UfuKwhgyHn?=
 =?us-ascii?Q?AFf9cwS+Oeh33tn82TPH0c/mOstXKUtg1RivcSFnd9bz3ALjXIZ9OUm2Z4eh?=
 =?us-ascii?Q?x2ym/k9A1KQ02qZgOGy1qmyRyU1j667IBUPy6y0f4OOwMisbPub/XLFkBv2Z?=
 =?us-ascii?Q?o/RiYdJV0eySyljN/ny2bQNg3DNARKfUeW1OwEEVyHDW0intVNuGURUzXJ3r?=
 =?us-ascii?Q?zyX9K4woXy6KTJZtDQIxxb2R/tNpFrhq1PE0XbhOEx+vcqOGL4117vEhdQS5?=
 =?us-ascii?Q?GMYkNZDPloUeNabFM+afUh2uUhd2DT+gH/k0ycjPn2xf/B3LDxO1T5a6Gbvv?=
 =?us-ascii?Q?TK3DQrfd3fIdOPK2fKXGRdsI56lpaeR+HI5kqq7cTx9aAduRGobIl3cwqu5Q?=
 =?us-ascii?Q?FUU7RiOq/FDa98N/KaKRUcb2qJ82eYwr7OsA6X0WsZQTYUZzbRmjjJmMUJdZ?=
 =?us-ascii?Q?yC7Gq6Z31xRf4/VoUt8tSgbBBQCsKYetDZeJlCDTNUx4fZCerQsy1/3c7ys4?=
 =?us-ascii?Q?UxGk1yMntzeloBYJUmv1Ed+EN2jo?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(7416005)(376005)(1800799015)(36860700004)(82310400017);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2024 04:41:37.0641
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a2b4760-8b87-41ad-e00f-08dc7306f97f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6873

On Sun, May 12, 2024 at 12:02:21PM -0300, Jason Gunthorpe wrote:
> On Fri, Apr 12, 2024 at 08:47:09PM -0700, Nicolin Chen wrote:
> 
> > +/**
> > + * struct iommu_vqueue_alloc - ioctl(IOMMU_VQUEUE_ALLOC)
> > + * @size: sizeof(struct iommu_vqueue_alloc)
> > + * @flags: Must be 0
> > + * @viommu_id: viommu ID to associate the virtual queue with
> > + * @out_vqueue_id: The ID of the new virtual queue
> > + * @data_type: One of enum iommu_vqueue_data_type
> > + * @data_len: Length of the type specific data
> > + * @data_uptr: User pointer to the type specific data
> > + *
> > + * Allocate an virtual queue object for driver-specific HW-accelerated queue
> > + */
> > +
> > +struct iommu_vqueue_alloc {
> > +	__u32 size;
> > +	__u32 flags;
> > +	__u32 viommu_id;
> > +	__u32 out_vqueue_id;
> > +	__u32 data_type;
> > +	__u32 data_len;
> > +	__aligned_u64 data_uptr;
> 
> Some of the iommus will want an IPA here not a user pointer. I think
> it is fine API wise, we'd just add a flag to indicate data_uptr is an
> IPA.

Ack.

Nicolin
