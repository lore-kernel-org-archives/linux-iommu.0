Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2064.outbound.protection.outlook.com [40.107.101.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C4A11E0B70
	for <iommu@lists.linux.dev>; Wed,  4 Sep 2024 17:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725471593; cv=fail; b=nakvbLrEP4CNxMn7/m01B8hnkqVXaggHgtgwatMSWGVh2XUAyE5CH/ZKHmpkxBENmgVXa4alGVWsI5wG/NLIyyyUGPatLjBZlEhXb8Arj4PecXh81r09txA073H8P5SvuYQw2XXEtDxcDe3HyBJ5A57NeIYOPeyZ+jkFZQKAxu0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725471593; c=relaxed/simple;
	bh=17wMmWL03cbtFdBEsn7QBqlJxQujOdwG7TaM0f4mIQk=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KrWo/Hk8cSnQa5m8qjrjrgJggDUsLLq2VCopShO/gFuDKm8YwujdHN8xhQcdNclUIOYVOoEcN8xtY4XH6zam+1TbO1M73LhYD8QuVEy7Ex4gZJ/XeS2eX1KwZtee6a0e7knUHZ3n5WXhevsGIMEWLrLhIDoLEwoaPgU6UZ/RMxw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=G09pVa6b; arc=fail smtp.client-ip=40.107.101.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="G09pVa6b"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mME4TtK3jUrG1qvSK4M3y8q9u5cpCKczTqqh/IvdTnvfdABBqdbnvHzGFj/mpyZZIzzZoBNWefTDJ036AtYP1zY34uwbuhahZvJD/yXrmpUJnYaUa8DMUk3bmM3zfaJM2QzqPH5F4SXJ4pY86LQbQAVPeQWk8tQ/lECt7Rf2PUahsK8B7r2s4GedYPe5S/iE6SfSV3LVKLys16SLTaNq0xbPL76N+yUCGY13Of2/V49OIuLt7GJxu/+Npsggst1AkHittK+fF1cTeD9QWVLHU1ETIh5ioW4Lct4X4ExT/8aiqUDUAyD4eMjkEtSuOsw2+v80W+2QxR1bsSA1sBKPsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qh+Y1Gtsk4zqE+fCLLW7r23bdOTAhUzAI28q7F5RY1E=;
 b=bAN2esqf9ZBi5Nto+3d+m9+gHcYEc8xhL9fmFlfPFjpP/M4+GsQPlOPz/1bgtplUgIOEr+7H39FcDAOhAtpefmzyGYLj4qnVk/T4sriYiUpE5WEnKzk0kS3qXfmGRPvB6e1pXXKT9KWy7bXSTdMXZapc4BdUp9R+Z6iVxjMJUQxKs6hPD5iWuO+ODT9c6jgYXHZkA4wmaoeiifLxv0ZDGyOly7UklL66XUx0N567fmPWebPOjTO2xPEhGJrQpe1jkVyYcDI2JvlYKHiOa9xWnG4Xk7z0IfAdf4SSdLRAvqvlEO3uGLYV3iZL97Sj2gHKg9c8sjQoS6FW8uJRgZVV6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linaro.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qh+Y1Gtsk4zqE+fCLLW7r23bdOTAhUzAI28q7F5RY1E=;
 b=G09pVa6bkNX4rTMh0an9uB0SOApskIfxteL6BVXaOz7g9x/ac0fpG5X9HVuSRq6NYgb67FPTseQq+jSOSSkTM0AncirmBb+bXa/AAQrSZs1qkN4D7OiZi/ER3ZoKNOgszyzziDisO4rThCSyWAQz4OnoLFCVUTUoiP0fmv6AuNxDSvcnCLc89yNSBnzqTVoemRFAdwthFoFXleJb+0FvqatzNwRVNv4lpWajZhkPskvcl0o6YPx8AVkRTWPB/9wfYyQcLA8vBq50jcDGh2AF/gE/SRLFdUrl7SZdAbat10+wGLKsy6sQlXfhm/KTJeMC5+MFijJe95Ja8D1ZiSjozA==
Received: from CH0PR03CA0023.namprd03.prod.outlook.com (2603:10b6:610:b0::28)
 by CH3PR12MB7593.namprd12.prod.outlook.com (2603:10b6:610:141::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.28; Wed, 4 Sep
 2024 17:39:47 +0000
Received: from CH3PEPF0000000C.namprd04.prod.outlook.com
 (2603:10b6:610:b0:cafe::f9) by CH0PR03CA0023.outlook.office365.com
 (2603:10b6:610:b0::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.14 via Frontend
 Transport; Wed, 4 Sep 2024 17:39:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH3PEPF0000000C.mail.protection.outlook.com (10.167.244.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.13 via Frontend Transport; Wed, 4 Sep 2024 17:39:47 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 4 Sep 2024
 10:39:33 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 4 Sep 2024
 10:39:32 -0700
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Wed, 4 Sep 2024 10:39:31 -0700
Date: Wed, 4 Sep 2024 10:39:30 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
CC: <will@kernel.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<jgg@nvidia.com>, <thierry.reding@gmail.com>, <vdumpa@nvidia.com>,
	<jonathanh@nvidia.com>, <linux-kernel@vger.kernel.org>,
	<iommu@lists.linux.dev>, <linux-arm-kernel@lists.infradead.org>,
	<linux-tegra@vger.kernel.org>
Subject: Re: [PATCH v14 08/10] iommu/arm-smmu-v3: Add in-kernel support for
 NVIDIA Tegra241 (Grace) CMDQV
Message-ID: <ZtibUr0dRdAL7DjU@Asurada-Nvidia>
References: <cover.1724970714.git.nicolinc@nvidia.com>
 <dce50490b2c10b7254fb36aa73ed7ffd812b283a.1724970714.git.nicolinc@nvidia.com>
 <38b6ed33-886f-4ec7-9196-1728f1d8c1b3@stanley.mountain>
 <Zth59xLYZ4skc4yb@Asurada-Nvidia>
 <fcf44982-166a-4a25-acd0-02a142e205d7@stanley.mountain>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <fcf44982-166a-4a25-acd0-02a142e205d7@stanley.mountain>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000C:EE_|CH3PR12MB7593:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e82f60f-d2ad-4b2b-7c89-08dccd089232
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qtsTFcJ3JUM2l5TwOLQh5UKuxSATtRQF/KpHQk0SENbzGhgi2oJtzH9doSMB?=
 =?us-ascii?Q?+TB6ajd0k/6xolHYhSrCLekrwh8XMWcRqduwhrVuxPR11q+CESlsCS8BI2sN?=
 =?us-ascii?Q?ImP3cU2qMlGAEBvmmpNbXdZUrsNVmbscFYLTbYKX+Oan5TZkSdyKKV1a8mz9?=
 =?us-ascii?Q?ouX6vRO2PVGvM+iDuDpF+TIEyE0TzvrD4DhGoxM8fcMEhFWgS/sR0gtrkg5x?=
 =?us-ascii?Q?tcEfu7XNbBrott9p5MUIK87c+6Sjy/BFpW9koSDBwNyn8Sv4EV77tPO7BLue?=
 =?us-ascii?Q?LS8VGFuBBKPQ8mAhvH7lkGQrkfEKWPnaKWWF/8ZFE/Deup5CIXQRUHGwhHbQ?=
 =?us-ascii?Q?RkSyJIpZmuWkDjBoDFU2OYhJQQZ33CpxJN+3X3ezk0G7I6yeXL54qn0lENSx?=
 =?us-ascii?Q?UA3PQTk6znKdp0qS4oADb18Opvk60vsrXU06j97+gjyO6tuzPJ/DXgg93NiK?=
 =?us-ascii?Q?+WAG06ReIFIMv4/mBXoiBUy48JrgCzrC+u+TrzMTCAm6ZY2mBMh68jwzNH8o?=
 =?us-ascii?Q?fef0Zv0SxHyO633h07mYgI36mje02/BQdNPFAgnqilF993WODCX3xYmuK0Ry?=
 =?us-ascii?Q?AZha7RkyviAZ2Up8UKST1/5aU6bZct8xHKWGBt9bVdIcByspzYsuSwszeccW?=
 =?us-ascii?Q?NhXUAKJtuE1Dp40ZmBvtgrYiReJE3GtWNvZCZv4hKiNJvmKkf9AL7U5S5NHQ?=
 =?us-ascii?Q?Dn8MxBOdeE838X3BZv3ULWtfsMak0XzE6STCkTgUZTssr0g3Qp4p38Y2mGyx?=
 =?us-ascii?Q?P9J1XnXod4DZdKaI1wyhPdZ7djCR7vLT3YNfG9zvMOCV3q35bOAyiTNhrgUS?=
 =?us-ascii?Q?vZ/ihWboSREVccYdpDoTlViB0EzoXgsjufcY+aSceXcxvZGUqENCx8MfcMLj?=
 =?us-ascii?Q?tM6ZT98DA1aSoTXKbWTu6XBKmQ2Fa9BtTy4Fl3SyeySSSgIWRK3HIkfaut3X?=
 =?us-ascii?Q?6by4HbPbp+Hi3oUd+HOj8lUJq+hikdLpvrOjZJjklbMn0w79c3DnCbgnz+OL?=
 =?us-ascii?Q?v14LdiFmPsbI4T54AXofc7enpZ8AEdLa2qKvETkxleZH3HfYOFGS40JPNcr4?=
 =?us-ascii?Q?9nabeDzkqboG4hNHi1e5TqQtUcd9odO44SzXnPpQh+4/O+0F3UgfzjeqZ6kI?=
 =?us-ascii?Q?4BjmO5mSmCZPKkZkSf0iXZXkP1hJN1qcyG003mKDI1IMejsSmvrAD99yLDX+?=
 =?us-ascii?Q?LQ3c9is4OfGztsb/19cRcI2qjrRUBXlJ97ZJQ4AnR3ZKofQdjn6XlNWQGX1s?=
 =?us-ascii?Q?O7LcYDJV1NZcNGENyDDbZczessdjIdBtz2d7YGmhHc/0Cd3WtlYEoNmmpDD3?=
 =?us-ascii?Q?Y878g58ASGSzVx5VABtYqjlPLpwEj7z/SfS/EFuxT15UCqz1LCdCZPnK0An0?=
 =?us-ascii?Q?32hM7oBH9g7CZfisGgYGlR4Y/JhVv8E4xcjp823rm6TU0gXq3pRETVG8G8lT?=
 =?us-ascii?Q?/3gUINIkjRVlXlX3NRLSpOYb+eE9o4GD?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2024 17:39:47.4732
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e82f60f-d2ad-4b2b-7c89-08dccd089232
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF0000000C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7593

On Wed, Sep 04, 2024 at 08:12:19PM +0300, Dan Carpenter wrote:
 
> On Wed, Sep 04, 2024 at 08:17:11AM -0700, Nicolin Chen wrote:
> > Hi Dan,
> >
> > On Wed, Sep 04, 2024 at 10:29:26AM +0300, Dan Carpenter wrote:
> >
> > > I was reviewing Smatch warnings:
> > >
> > >     drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c:616 tegra241_cmdqv_init_vintf()
> > >     error: Calling ida_alloc_max() with a 'max' argument which is a power of 2. -1 missing?
> > >
> > > The problem is that we're calling ida_alloc_max() where max is always zero.
> > >
> > > > +static int tegra241_cmdqv_init_vintf(struct tegra241_cmdqv *cmdqv, u16 max_idx,
> > > > +                                  struct tegra241_vintf *vintf)
> > > > +{
> > > > +
> > > > +     u16 idx;
> > > > +     int ret;
> > > > +
> > > > +     ret = ida_alloc_max(&cmdqv->vintf_ids, max_idx, GFP_KERNEL);
> > > > +     if (ret < 0)
> > > > +             return ret;
> > > > +     idx = ret;
> > >
> > > max_idx is always zero so idx is always zero.
> >
> > There is a followup series adding support for max[1, max_vintf].
> > And I guess that would make Smatch happy. I'd personally prefer
> > keep this by ignoring the Smatch warning. But if you think the
> > common practice is to drop it and add back, I'd be okay with it.
> >
> 
> I'm just reviewing static checker warnings so I don't know the back story...
> How long are we going to have to wait for the follow on patchset?

There are a couple of dependencies we need to get merged first.
So, it might take a few months I think.

Perhaps I can make a small patch by changing the ida_alloc_max
in the common place here to iad_alloc_range(.., 1, max,..) in
the caller of the followup series. Then the existing caller for
vintf0 wouldn't need an ida_alloc().

> Generally if someone had noticed this in review they would have asked that it
> be dropped but now that it's in, you're probably in the clear.  No one else is
> going to volunteer to refactor this code if you don't.  ;)
> 
> With regards, to ignoring static checker warnings.  These are one time emails.
> There is always going to be a certain percent of false positives.  You're
> *encouraged* to ignore static checker warnings unless it's a bug or it makes the
> code cleaner.  The goal is never to silence the checker.

I see. Thanks for the note!

Nicolin
