Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010048.outbound.protection.outlook.com [52.101.61.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02E94EACD
	for <iommu@lists.linux.dev>; Sat, 22 Aug 2026 02:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787364475; cv=fail; b=rEh5yOsu5NAZkN1KyZvdXIvvBX3aotS4DS1Yu6/ImuQ+Pc/Lf3hL0YkJAQGQbnIvuURTlIh77Jx/OrsFB7RIOSWM6iDDAcdbaTfl9wYmon91ZEAlHsE6p2ZGF5akXuCxgoykvYYPfLsEZAwT4Hn0DRDZedBLBkPyhyUm1FTKQwc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787364475; c=relaxed/simple;
	bh=IphpTSHFznUevFfDYh/86qfIg+76WtlttWqmGg0MYH4=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GC0yMF+WoxpHt8PuHBqg6n1T5MOY7UUjUyctktSGHcWneo8GFo5hBHhK23Id03OGBYtEG/T4W6GU1HRQVxi08e8wycdkdmMbmFcqi6YuIfng4x8ZSlpHhk+TPW+lvDu38oWov7ZBaQyYjUJ+gshltp9l72C9MOWjqaodIeRTyZo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SJ7PX8Az; arc=fail smtp.client-ip=52.101.61.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SJ7PX8Az"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MWSDs2EsUFFzrKHXEtukzDwKHtgQmWiHv8KQPsR1ZGWbKWt9A06zKROvwlnupi2j+/yvsBQv+in6Y2KYT8Mp9ppmeyooBJHPtMTQf8d428iw/MSsmRskYOaHLCV1BmR+BQLd9rt7AwJNM56p6Pn1TnM3LP1Yt8/s/G7inNARwoelVQkE+N/B+XsBBF1q0j31AWdZBOwM8lkqWopDCBdtUQOsJD9TCdNwhKZG4/i4fMMsRMG+oPqziwG4bybiqXw6ww/xXc+I8jd3g5+bZDeDyuc8qRgkwuZl23h1PN0Sq/M8tgISBU62oQ5AEFXy9khx3+9FlE0HDQyhs9K7V4bKhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JpQzK2uzwXP/DEEdgbDNGAPShOCtQo7XQEPH4y28aoQ=;
 b=mLx5tEck2kLQI2XgHkgY5ccm9DmwQU8LBB+VspQhG/lA5LbXtEyUWcbqrGF0T7MTM3CUlKYmxClfrZNEdPL3R+2SxbVClOhwHcz9xG2o8995hcKi/euHKvIrVYbkGTSsxEMREdui9CNSdUw/JFKOQY22zar6h1WKN7uE3JEcD7u7gznxpNR/OsKOhK90w9NbnZOXu7hk5Ki5C3xYTOA11fk9RaoCsKxnpZhDm2/PNzb3u4nCYL64IzUmTe4yKZ8/eR4aCdhVYnEtVhweGMslpYztXWGwZ4bJUnakjqEujNSrkOT3UHYa7xR2Ogu8TQcCEWDIzu8sk2TFFJkpSVGNGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JpQzK2uzwXP/DEEdgbDNGAPShOCtQo7XQEPH4y28aoQ=;
 b=SJ7PX8Azxxshb4mkOiXo+TLeuAY7jWySIilE7BPVji2/qNN/hUmj/GCLIMOQw849pADCueQ1HPG/Ln8vp8uc8hVm27TkKzdXU5OksaUdUiMFyJM3YRNDIS0NxZgf6Ms0i65T0QBRt9sGPWlDtkFRUGmWpy22zC+sxMDSrd0eSBZNXtTpFdpPGUPw230qJcXRZviiebwA1gwZ7LD6iNoyF68ILYYr2QMkH4iq7AFdnJFZRfcIsuoWe5hX3LmlumCYeS7wNsVzSljDRJGL6EJGde024UhjETEriRYKdXxTV0YtqE/GohPZBmQRqbvdWJeLx+D1uyYUV/fsz99e8gA3mw==
Received: from SJ0PR03CA0027.namprd03.prod.outlook.com (2603:10b6:a03:33a::32)
 by LV3PR12MB9215.namprd12.prod.outlook.com (2603:10b6:408:1a0::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Sat, 22 Aug
 2026 02:07:47 +0000
Received: from SJ5PEPF000001F0.namprd05.prod.outlook.com
 (2603:10b6:a03:33a:cafe::af) by SJ0PR03CA0027.outlook.office365.com
 (2603:10b6:a03:33a::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.11 via Frontend Transport; Sat,
 22 Aug 2026 02:07:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SJ5PEPF000001F0.mail.protection.outlook.com (10.167.242.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Sat, 22 Aug 2026 02:07:47 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Fri, 21 Aug
 2026 19:07:42 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 21 Aug 2026 19:07:42 -0700
Received: from nvidia.com (10.127.8.14) by mail.nvidia.com (10.126.190.182)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46 via Frontend
 Transport; Fri, 21 Aug 2026 19:07:40 -0700
Date: Fri, 21 Aug 2026 19:07:40 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: <will@kernel.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<praan@google.com>, <kevin.tian@intel.com>, <smostafa@google.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <jamien@nvidia.com>
Subject: Re: [PATCH v9 07/12] iommu/arm-smmu-v3-kexec: Add ASID/VMID
 reservation helpers
Message-ID: <aokEbBb0q9/FA7pS@nvidia.com>
References: <cover.1784663183.git.nicolinc@nvidia.com>
 <9f9d227c0adf472e93293008e7083973688d015e.1784663184.git.nicolinc@nvidia.com>
 <178735412602.18212.13622444378152698190.b4-review@b4>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <178735412602.18212.13622444378152698190.b4-review@b4>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F0:EE_|LV3PR12MB9215:EE_
X-MS-Office365-Filtering-Correlation-Id: 48fa04ad-124a-4bb9-b60c-08defff2298d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|376014|23010399003|82310400026|11063799006|10067099003|4143699003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	bLdp4fSbeWLUB8xH2XcKbw6l7Wa3zDtlSXwTubpixstfSsqE33xrQPasyRkKSi8RQ+I8hVS4IYo2HbTMbo2bZ0H4P25jnozIyrUwuxbyppVdMhCD0rciLD0Ko/p0xXHIqQvlgHkBe+dT/attPzjn6mSUmqB8ch/oypE8lV0UHdtI7cQLCb75oF8gIADoaliQj6KZ1NAGf/q40lS01/CZVyuguHHaVvSfCDRKLwQCgoEEXKaplpH42g4GGnqMe1G3knJ1KbRD9EGQlNY6vkiFqxpAypk0R5uyBgb4OrAMQO6nhmGtB4l3OMcwHMZI4Gfm7wxmnqufQ4cG979s4Qh+cY/Fi+zQiqcHeXX5xcgpF+TDfhj2WHGKWB5Lbut6iqOPQ0sK/BIVOvXvOzqXGT89O6inGaHp65pa8aIXMETfcHz8Zxq9mSxpPjaakIpoRCKcqCr0YUK4BENXeT6KI8oZab8AUkOxgAGOIq9IVftUF7+b4dIx3JpXPOgxBWpl8w0bTKhZVW4oImkR8mPmwovqmc9hWmAFKAt7b4yMR53KBsPsZHisML4ZttGJiG7RVCAfjnYIaFQHcB8EP/Ao1n7dF+K56vZlr+WyIQswdbpgkRd697mYjmiGdr9s6nke4CDhftbj0J2iWlV+E+YetTV/siQZ/Mqui9mfvGl/HqvBb2U7hAh/Q+Wl4lAc97uUyLHfNlCGNFjx6M6krMwY8imI5Q==
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(376014)(23010399003)(82310400026)(11063799006)(10067099003)(4143699003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	zxW01dBIzZYNd9masFMbtHYzVhWSHTeCol2MjaA7iP7zCWeUKGdIcvXABI0dsZYLmtGOBcdst1fbzkRA0hablIZ3wCdSK0PRD6W7rNTvC1gyfyL1fNPJrCw8lcBEzFhAaBHDCnkz+S7PrhFF9jbau1IZsu5xBcgftWMxdovdfY+Xt0YeP+aIK5ElrKn7yWmJ0Po7XiAhlsr9kwPSlHQNPoETgQL0hZyXfZlQLRGD+3jKBx/HqLBfsnfh6d++qL0zwD8lXyoHoJxVIXUEurqOciHeih4Kc7A82EwjhpvZPIW2RaGhUMyA0yv0kmlV425RF10ZVYm3a+G0bwF/D1ROZsTth4mZq85mIMr8SQNl9m2kFCikC3TjSoFKpyzDrfPRhKxjEcS7yIFFH/ZdAFJjwglIvAObH5tYHo6KXq4+X23nGgZef+UEqXvy3OrmL39H
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2026 02:07:47.6732
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 48fa04ad-124a-4bb9-b60c-08defff2298d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001F0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9215

On Fri, Aug 21, 2026 at 08:15:26PM -0300, Jason Gunthorpe wrote:
> > +static int arm_smmu_kexec_resv_asid(struct arm_smmu_device *smmu, u32 asid)
> > +{
> > +	int ret;
> > +
> > +	/* A valid CD never has ASID 0; both kernels share the same HW limit */
> > +	if (!asid || asid >= 1UL << smmu->asid_bits)
> > +		return -EINVAL;
> > +
> > +	guard(mutex)(&arm_smmu_asid_lock);
> > +
> > +	/* The value entry marks the ASID as in-use and identifies its scan */
> > +	ret = xa_insert(&arm_smmu_asid_xa, asid,
> > +			xa_mk_value(arm_smmu_kexec_scan_id), GFP_KERNEL);
> > +	/*
> > +	 * An -EBUSY against a value entry safely shares a permanent reservation
> > +	 * made by another scan. A pointer entry means a live domain that will
> > +	 * free its ASID for reuse eventually: keep -EBUSY to fail the scan.
> > +	 */
> > +	if (ret == -EBUSY && xa_is_value(xa_load(&arm_smmu_asid_xa, asid)))
> > +		ret = 0;
> 
> Huh. Somewhere I had a patch to make ASID per smmu instance, just like vmid.
> I think you might actually need it here? Is it possible that one instance
> could probe, the core code could start changing domains and end up with an
> unintended ASID conflict on a later instance? Then things go sideways?

Yes. I've noticed a problem: SMMU-A allocates ASIDx from the global
space for a default domain, later SMMU-B wants to reserve ASIDx.

So my local v10 adds a new patch making ASID per smmu. If you would
like your version, I can swap that.

> 
> If you have that you can also drop the arm_smmu_kexec_resv_lock?

Yes. The entire thing ended up cleaner actually.

Thanks
Nicolin
