Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013017.outbound.protection.outlook.com [40.93.201.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1364B3233F4
	for <iommu@lists.linux.dev>; Mon,  4 May 2026 20:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777928134; cv=fail; b=OJPUMVP6Ee9O1EQpNFBZ0qr8GPHnNOr1iZ6EZ7ngBFCeHfhF83hOwgXNdanZz9tg0sCpqofY+UrfPVwL1ic7xk2V03DH3daYmRP6vASI7cUXRQijw+zzSBJdX5dtXWvickMQR0oBBshhTmmIvuIeifrg9A2K0eXxrYsdJDfiKHQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777928134; c=relaxed/simple;
	bh=rsLWPPkZTRdmuvpQnVtzy71NOcVcUygfxQpN6o0IDZE=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GbDFt8/xr1dSci55vSrPmdT5b8K+lpOBo06N4NSLM7YViXSKUdFObrDWZPWEEBuC9addW9uzukcJx1WVHuS1wBep/DS5JGCzFxLtSw+P/cE8hnqLchBe+/5SnYND/VeOnQulO6dKvq6ALhmrDMqGJT8lLMs7HoV1Q64omsOvK9c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=l8s3TVir; arc=fail smtp.client-ip=40.93.201.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="l8s3TVir"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vxmdm7RexNyTUwbNCp9ib5qEZRLOOQ3JM++ISU4Vm1RhrQnzV9AXDf5sMlTWoC3ItKYmA1aul6MwVInGSoi43U4SCmZyc/dv1JXfjyqASJEfkUtRROAf2DbNuzrpaU60xppZ59wL62slZSHhS7b08pdMsSp0MQsLho9RwB4NADc8INAf3b1Xt1ywXTLAR8stu1fX1tUewRbKI1OZELDZkIaTHjObCbeRfCE6CVbp4XyTCECR55UYjwj5nifruBoMGp6XgRSd0Jt9KvkTAZVB9+Ml0zAQ/i/UFCEDTTQqu0n/QWUzARg+g5k0NKPIQNDeCTWGBhkO7I29H+vWOYtHZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LiLzENTyL47kyHqxfJg3ILuoX3gYHE4LeFFY+LgzpIU=;
 b=gCvRZfxiCa6eA1/VSUwklMtP2gBOUBVjL5emowvTx1eIvX0InSgav4hqdZvVS5WqGC0Qst1HydZhK9A5iLqcQSPwtoSucJxL6NiaD9hzzQ+SxYxEGtQIVJI7CfZqUaZzRpVZPjVec3pDtl9KRydkOI9aT10cul3wv8EcSupzKjG4Yv7SWeq1DhQB5W9LDYWes/6BtrLwCVHQS+YYzisvmWB0WY7bcffVobwMmpyoarJbYJMhbUNVblH5ozYeffyswWgeJf5domttY34o72EUikoQyRAKm/ouSUAYmAEBN10YbHcVtPbI9HT1oirDpgBvJXd9A+i0CSBwnqOIJPIQcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LiLzENTyL47kyHqxfJg3ILuoX3gYHE4LeFFY+LgzpIU=;
 b=l8s3TVirD51EANMkSoMM5TWNElLtJCP2xkRYPIv0kv/7IfT7/rssu4vJSFiheCkJ6ST6fVBhs5OZm2pdZpYquqXIccEaZ3gz9fRs9ABi10pMQBVtI4D1ZRz7R5+1TA90b0zy7UWsoAo5ROQ81qFzWxlBzYY59TfyGMFYJkjGh6n/1KYt5Ve8Uw2hjc2fAs3dyWkAVvkMzD3mN7bR1Z6I9P1UwJ1rsNIVuuKhR3Hvn9Q0XDAfYATCxxdx4b97ty8qitENNw9IZuvs2knqaKCIDlnOX0d1niretOQ752etgPtEODJnN1LHVXO7+SQ23SqqRZaMd/GFjzJCJpo2CFPiBw==
Received: from DS7PR03CA0056.namprd03.prod.outlook.com (2603:10b6:5:3b5::31)
 by BN7PPFD91879A44.namprd12.prod.outlook.com (2603:10b6:40f:fc02::6e5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.25; Mon, 4 May
 2026 20:55:27 +0000
Received: from SA2PEPF000015CA.namprd03.prod.outlook.com
 (2603:10b6:5:3b5:cafe::ae) by DS7PR03CA0056.outlook.office365.com
 (2603:10b6:5:3b5::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9870.25 via Frontend Transport; Mon,
 4 May 2026 20:55:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SA2PEPF000015CA.mail.protection.outlook.com (10.167.241.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Mon, 4 May 2026 20:55:27 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 4 May
 2026 13:55:04 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 4 May
 2026 13:55:04 -0700
Received: from nvidia.com (10.127.8.13) by mail.nvidia.com (10.129.68.7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 4 May 2026 13:55:01 -0700
Date: Mon, 4 May 2026 13:54:59 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Pranjal Shrivastava <praan@google.com>
CC: <iommu@lists.linux.dev>, Will Deacon <will@kernel.org>, Joerg Roedel
	<joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe
	<jgg@ziepe.ca>, Mostafa Saleh <smostafa@google.com>, Samiullah Khawaja
	<skhawaja@google.com>, Daniel Mentz <danielmentz@google.com>, Pasha Tatashin
	<pasha.tatashin@soleen.com>, David Matlack <dmatlack@google.com>
Subject: Re: [PATCH rc v2] iommu/arm-smmu-v3: Fix inconsistent ATS state
 tracking
Message-ID: <afkHo8MJMTY/JCnp@nvidia.com>
References: <20260504163842.2692314-1-praan@google.com>
 <afjfBi+vw/Ywkzid@nvidia.com>
 <afj0cyBZwkVLyIwK@google.com>
 <afkAKlu4nllduGCE@nvidia.com>
 <afkEQTSiP2WE_KdJ@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <afkEQTSiP2WE_KdJ@google.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CA:EE_|BN7PPFD91879A44:EE_
X-MS-Office365-Filtering-Correlation-Id: 71c3f29b-d1f0-4262-cc05-08deaa1f7888
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700016|7416014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	uR+tyIl5g4PAQr5RgcwMGTQczfsto2e7ZTgkVusWRf41xtzSnjJ4nvw7IDWakbJ3cBtrp5+B0FC9y844m9hSvREOK8NF8T65VUU73dK0E/xrI1fEDOSBB0yB5KViCvnt8Cb5/VLJ2UX03dUeNcK6fSMlNCc2J+nd6XIfIQAdOcQ0IznCGj/i9RLaUa6TmSB3avVYDi8GqLN2g9ZvPnevRih78CLGA4js9rh/xAQjkyYSGbQ/sXGIasDou86Jm+kaD0cWXn56LLSfyuMcqYEGV8sQsCAcV20AWnSralSricgT0L3VeP/KqZWokowUboCd1iUWSeBwYFKiwtt21/cBveFvUk7+XEfatC/Qf0QHGqlt4GWLYt4TprI99mUc2qJiPKui7FPA9J1e99dvTrDlGqIilDOFyxislqRvw8trO6mmDaa/rglhytm9SHRibMjgf7HkvriMZfly9o+io6V9ioyWMDjvty4Xzl2+jTJ/svS4qvfMoGjawI8uWqtOM9P+HUAAoJ07qpLMrdDJJBTjkTPirSNyEU47ijUsc5nPV8KVMbx/R/8FJXIq7BYShj2MoYcCznYHiDfmLZHNQgOwFBpBlRxUTxjOZdJ9zExTMQiUka6kDdMij73JiGSDPU/yUM3TRNJwLbYDaiLdPXhNt2CfW5w5wBdBV5FMQQtSr1Fw1Y9cxn8OHSZKopdwPGIxvtzelN4XEGc409AgsnfoppPrH8VZJfy/y98KIU/5xQA=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700016)(7416014)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Thoggmhv8lKgZfoTAlK7LGmw9VRZfVFMgiYBlsXk9FRInjXKAN8ZTPybEnpluSb5lcxOgKcDA5ToAlG/psbMJibredflMofv0En6BY9dGErNGTdt+mwAjuk7UzqwOcyR6RrLC9h+oXcp4LjHu0p9LNtkRBZY9KPGSwIDOJlMdDX0BgKe0asRP/3uPB3HGWIH6uEkm8bKyIQ1z6AYCibOxyqwxkxqiVhCacby29YXd7c0I6PhX5qGDXfX3mTXiMnIKVf2o0z64obuPn+GKnqIJk8FAuilmJnUGb8W0+myhk+AJhc/VTakPpWLAhuJSprM8+LKdhxJ/tHWNAMKbZvN06SOGu9Ujs8mrUMK/qb7VPY/+IEhACQUNEnVdw8j024Ncl4Pfc2vt1SzfbF+odrlErGyeW1wsbglzU2LAP2oEK1Drt5x/nmjRjPVtO4MwAZu
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2026 20:55:27.4735
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 71c3f29b-d1f0-4262-cc05-08deaa1f7888
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015CA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPFD91879A44

On Mon, May 04, 2026 at 08:40:33PM +0000, Pranjal Shrivastava wrote:
> On Mon, May 04, 2026 at 01:23:06PM -0700, Nicolin Chen wrote:
> > On Mon, May 04, 2026 at 07:33:07PM +0000, Pranjal Shrivastava wrote:
> > > On Mon, May 04, 2026 at 11:01:42AM -0700, Nicolin Chen wrote:
> > > > On Mon, May 04, 2026 at 04:38:42PM +0000, Pranjal Shrivastava wrote:
> > > and then in attach_prepare we can add the ats check for safety:
> > > 
> > >         if (!state->ats_enabled && master->ats_enabled) {
> > >                 pci_disable_ats(to_pci_dev(master->dev));
> > > 
> > > +               if (pdev->ats_enabled)
> > > +                       pci_disable_ats(to_pci_dev(master->dev));
> > 
> > master->ats_enabled is redundant if we check pdev->ats_enabled.
> > 
> 
> BTW, is it really redundant? I assume it represents the driver's state 
> machine? I believe the condition:
> 
> if (!state->ats_enabled && master->ats_enabled) 
> 
> translates to: The current state has ATS active, but the new target
> state is to have them inactive. Isn't that the case?

That's fair enough.

We would need an dev_is_pci(), so having master->ats_enabled makes
sense.

> > If we add a gate here, should add to pci_enable_ats() too?
> > 
> 
> I see that pci_enable_ats already checks for it:
> 
> 	if (WARN_ON(dev->ats_enabled))
> 		return -EBUSY;

I see, then we could probably leave that so future corner case can
warn us. IOW, yea, I think gating pci_disable_ats() only is fine.

Thanks
Nicolin
