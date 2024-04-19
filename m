Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2040.outbound.protection.outlook.com [40.107.244.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3B2B184E
	for <iommu@lists.linux.dev>; Fri, 19 Apr 2024 15:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713540296; cv=fail; b=dX50xyJhh6bdDKAlCCSdhlEgS5MHFGPT7M3t5XKwBPCG6D5Sl46zqwdEWbrRjAo2iExfB/DLJ2CgEbxcWP6M8I2lo48zw+zikI8XACw+budmnAMvscnYtb9EQIcJQpIVVMcOT4KNHvbjDhACH25LkEMVwLPBtJ1W5h7NihclqUc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713540296; c=relaxed/simple;
	bh=oNVO6tpbLpN9mdqk4EVz2yLPTw+w/QAfi7lJEl1y3Xo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WDVgDUg+yiLtYdT+ES317I7oRQwv0MJs2iPE32S6DOIbKvUqV94dg/iFEMjgNmXuRwmZ9lf8H7XrO3wbUQEDl8GahHk9puJ/7mtvzKGDCp79Kxc+kAbbfehhG+Y7OEmDNR4Z3j7TU9ji4HwtCYwlfMr6tn2/Nm0tm8aLLpEgwpM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=z13acoGN; arc=fail smtp.client-ip=40.107.244.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="z13acoGN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Me8dpz/6cfuVa/PN4hUcxZZWeezYGJvJubzu1J4hCSTvsRbiHPYuOJq+NDRI9FWo51ZfDSiYU27zDXSA2aPFNblUA2HBr6T8jR61Wx6bgeISa4TbLq45imDtoSOmKY3n/USj4lpqJjQx8TtXRfC8dUI72N3hsSK7D3juWkQtrYBjbkVD4ah6GqXF83QlVraYrMDVlNAMBRDQiAY5Pg4ym37FymPDdxVTiWMfNgXlkn+vMdoQBOS0NxOkTuMTTiQenZms7XbHgoJW+KggWuGgjLt3S0t9B6HbuFJECmb/HlCkeFQUBo2tC9CyAPUHBKTAEKlnyvFT4h+uuldXnbQVyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=loPpg0IFmaYXOTW2Hx/CzelgDpknkpYntJlYOFafyAU=;
 b=ivSlALdaVfDZ6YHlYrBunNTlWm+h+Mrp//pbTSTWCW6B/L2Z73M+81FX2+ZiaPNNamD+Z44fx17rceUJgkvNGFb5GHaZxPQMZim0sxsj69N1dwdiiSd516TWM0yfO8VHbFmn/k2D4auAUwuTYU0AgOqAjx9FpnhFmFAgobGiUBBbUImAF8uvn/T7R9QHIKucvh5ig1vOe1mBmHJqwhOXWU3VeF1+brrzWQ26eCSdEFI3ToxmQ+tWw1765INza4+ZjXt3WZSn2jGiLYQWHnisiqCXZa5+ee2v5exQGF18weOO27odLFr8/loWmnfYYpldqvRv5wLLbRlTZPqC7615gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=loPpg0IFmaYXOTW2Hx/CzelgDpknkpYntJlYOFafyAU=;
 b=z13acoGNsExMWiV0lzsB+QuJc/78ZYGkq5nj3w+56dIOaJPSnP7AqYGVfbF1nt9XIbNUsDsZ2UXsXqwzWlmT+iHWbKMFvPys/Np4as+N+RoDwxkhFami70jdUan6mCWuYzutmLkUX3dOhB9Jio6d1JbdonC/WII/xitazNFDEsE=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by IA0PR12MB8714.namprd12.prod.outlook.com (2603:10b6:208:488::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.42; Fri, 19 Apr
 2024 15:24:50 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::491a:cce3:e531:3c42]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::491a:cce3:e531:3c42%7]) with mapi id 15.20.7472.037; Fri, 19 Apr 2024
 15:24:47 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Hegde, Vasant" <Vasant.Hegde@amd.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "joro@8bytes.org" <joro@8bytes.org>
CC: "Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com>, Eric Wagner
	<ewagner12@gmail.com>, Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe
	<jgg@ziepe.ca>, "stable@kernel.org" <stable@kernel.org>
Subject: RE: [PATCH] iommu/amd: Enhance def_domain_type to handle untrusted
 device
Thread-Topic: [PATCH] iommu/amd: Enhance def_domain_type to handle untrusted
 device
Thread-Index: AQHakk9v4p+I1nN4GUqiSg83mbi4zLFvtoQQ
Date: Fri, 19 Apr 2024 15:24:47 +0000
Message-ID:
 <BL1PR12MB514484CC63FA4A5193A6C580F70D2@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20240419114715.6028-1-vasant.hegde@amd.com>
In-Reply-To: <20240419114715.6028-1-vasant.hegde@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=8eacaa25-6581-43ec-8b45-a9129a6e2e7e;MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2024-04-19T15:23:51Z;MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|IA0PR12MB8714:EE_
x-ms-office365-filtering-correlation-id: 017a6403-8692-4e68-283f-08dc6084d966
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 FEfYCECDhicm/ADAjTWPkAsPhPssECeAaOm3Jby0wSxLZYVfJ8p8bsxyxToSZcvbKvH4ln29omHevoRlAavEcZ2dJuItErDvD610PBTNEs0414dRJz82uyRtvjsg2OYm2G0Qrgo1772AICazf4o02YJEUKmQmfKhtWX9OvSoy/zBrKMon63hjSlLMnEN/XS+mM6NQ5dhyCbMT84EDFBRDfmz632RFMg2UhjHNyPqRvhkDF35iEk1TxKYMWtVkxlj/cWrjp7uAHUzoawTlhXAQ3GVxNqVQ71RJI4htscIqale66aLAB9GaW7HM8NNYNkNhVaBq8WqurdQ5tFWUPWzZ/+vuoSqUbj1cDYhETGAeq1PjS04nupFkOxjWYU2NYGW2J0ApLBBsYTQyV6t5CLx3jw/VVB4BtBrFMcAwOGgbJ48HTdXVSlVcBTsvEfaw6A9m+t6Nk48jJiYsZYraYlLBPB12Z5rvqca+9KVYPE9n1fV1XKW3oX4eOqfEdj2cUfFMiVjWJs9N35uAMessM97ujtmTs7UHhQemSW64oOgZwgun/vTa7rwxugXAaAu+rmbrp10Ev/mIWBQpd3QN/4LPL6Fc+mYTZdDY/cJtmfQ4ErQkzha63mz40/S30JQ6/cO8Ky1QRm8VO5WLsjbrI/q72xxeS7Fj24HDnnONua+Q9I0vK+VUALx8LvNn3w3Ss8W
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5144.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?cILPLzjJ7NlPaiKHwXIZZQoUyfhNnMEKQ2Cyg/eKlfYOIWkPfUVbJvK+omWR?=
 =?us-ascii?Q?uMc2ld+zNqVQ0bm86G3eRnN3Gzbg26/20RCXdd5tvzRGzfG2/K4TRK5NorqC?=
 =?us-ascii?Q?4zcOecIQLrDa8zXYr21PNNWuPJxuGBj6e4+0EaCSopR7FC8k01x8tK3iPLU8?=
 =?us-ascii?Q?MjSzm7k4+VIjfDEk0XEywpbSHg/WGxkTc9FNXAxl22nYD8Qacf8KWTTWbhX1?=
 =?us-ascii?Q?kKlRUCqt+gTbdpXHDRQrdkHz7LdiUrQiPLfHuDzfZuxVxUqKTPRbknweqQ7E?=
 =?us-ascii?Q?FdzU1KpLTK7+wRJFiOTrxBZCzKrcQh0/wo6TiHoYjEkG1HY8ZNbQM73QhZqs?=
 =?us-ascii?Q?E1f0nImMu85b/OkL9XdWm1xXIcErbS8ROjxdPRy8eedU3cp0mgOSkBHvSCBQ?=
 =?us-ascii?Q?wuAGbbi41bbztjWMNdvVlb8Vtrta3o3fRZXvGUu+B+563whIjY7fvAwJcaLP?=
 =?us-ascii?Q?UIe3oc8guINPeL6kzSM4e6I3NYIV2YBk17dwh5CmlVIo7yE1KiFDTdY6u+u0?=
 =?us-ascii?Q?5ege3Da6EaolAvMFW39sU2odyB3EGBcs1oXVY1uc1og3F+fRq94rH2EQgc9l?=
 =?us-ascii?Q?Y7FLfH9T7vB9LI2rlz1wjBaiIjOh3JCkv+mVZOPe/gVNNP38tWwFDP7D17LW?=
 =?us-ascii?Q?6M1cpyyU2erukTAZguo0rDWVJ/JneBa2bjoFyrEHdX2kz/hgl0CWVjHa3LUk?=
 =?us-ascii?Q?qCrvl2zfp7YGNrDRCeSOIDRyGZ3Ksa10KJRsR0uG2Pmg+TQaO9lo3VbxpkEU?=
 =?us-ascii?Q?nVjBoK5j2N2LaQ1LECIcRZRpZa/JNEg86jjEZjC7SfY/aoAvvgcQbEp5IYCU?=
 =?us-ascii?Q?wQNtCEelJapARyylbbWIZ32BfZNMM/sMkKJ7nyzTsA068iM3j4LPvePpKBcL?=
 =?us-ascii?Q?7tUUDAsz5uuzwleXWvDwD27Tx7sBzSBQtQQn+b6uk+bLGxJua6XC2MOXlJyq?=
 =?us-ascii?Q?3vL8e3H8VyuY0Plleu8eeURgMIAUa3ZCUdxv2kS4Sv97fORhgspfaOhDaUyj?=
 =?us-ascii?Q?UCNzEFbih/izMzAPHQ6Y/XcWPY3N7POrASoaxNyRDddw1fku0qMktnbJ8ktk?=
 =?us-ascii?Q?gmoVmItGh8mCqQzpWoT/JnNDZq2VMMpvLKhgQUzkl+7qnNA37jrkJZ0URlAS?=
 =?us-ascii?Q?1KHvPF73y/FNvWQnRLEMe425HJ3DaGCZIjuEq72GXDb5bt3y8wUuk/nh9958?=
 =?us-ascii?Q?XgGQ8aZ2JbBmicRsb/rys7kT1veZ84akM0Go2l+fzuiV64j0Ok7S4zdJDdG8?=
 =?us-ascii?Q?vLrpuehzad6vyGZnFX3Oc2TzXylyq8eTqlBsq6SNTV1r801sIV9Yfw0ORS4H?=
 =?us-ascii?Q?YysWNZEQfytM0xgOmSkf7WLv6edTFHvLKx8aqSieumyL0oVygtQOXe0X7aJD?=
 =?us-ascii?Q?SCDq5IKNdv1LQgXb5oN5UFTGpHIslAYmpwfXK71DVRTiFnNkBQ8R1X+V1Xu7?=
 =?us-ascii?Q?1tPQoFn7un+fYiaR2bbDaQiAszM9vj7voSy6ZVAJ0C3ZTB48g/PHoBvYWjxj?=
 =?us-ascii?Q?ZDUd5ah6HkVhlmpAenTOw5L6WQFlxSKK42wV/bJYbibSfoYp0nyTd+b/91n+?=
 =?us-ascii?Q?KKQpyL0oGIej/sCTljg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 017a6403-8692-4e68-283f-08dc6084d966
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Apr 2024 15:24:47.8451
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qMwrUUAWSu7hZoOHLa+biY5nrLZ/2ayJnIeG/+VrFkT5Kf5gypcxw+E4xG1XI95E+Yq8iSsSdl2KNfYR35i/1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8714

[Public]

> -----Original Message-----
> From: Hegde, Vasant <Vasant.Hegde@amd.com>
> Sent: Friday, April 19, 2024 7:47 AM
> To: iommu@lists.linux.dev; joro@8bytes.org
> Cc: Suthikulpanit, Suravee <Suravee.Suthikulpanit@amd.com>; Deucher,
> Alexander <Alexander.Deucher@amd.com>; Hegde, Vasant
> <Vasant.Hegde@amd.com>; Eric Wagner <ewagner12@gmail.com>; Robin
> Murphy <robin.murphy@arm.com>; Jason Gunthorpe <jgg@ziepe.ca>;
> stable@kernel.org
> Subject: [PATCH] iommu/amd: Enhance def_domain_type to handle
> untrusted device
>
> Previously, IOMMU core layer was forcing IOMMU_DOMAIN_DMA domain
> for untrusted device. This always took precedence over driver's
> def_domain_type(). Commit 59ddce4418da ("iommu: Reorganize
> iommu_get_default_domain_type() to respect def_domain_type()") changed
> the behaviour. Current code calls def_domain_type() but if it doesn't ret=
urn
> IOMMU_DOMAIN_DMA for untrusted device it throws error. This results in
> IOMMU group (and potentially IOMMU itself) in undetermined sstate.
>
> This patch adds untrusted check in AMD IOMMU driver code. So that it lets
> eGPUs behind Thunderbolt work again.
>
> Fine tuning amd_iommu_def_domain_type() will be done later.
>
> Reported-by: Eric Wagner <ewagner12@gmail.com>
> Link: https://lore.kernel.org/linux-iommu/CAHudX3zLH6CsRmLE-yb+gRjhh-
> v4bU5_1jW_xCcxOo_oUUZKYg@mail.gmail.com
> Fixes: 59ddce4418da ("iommu: Reorganize
> iommu_get_default_domain_type() to respect def_domain_type()")
> Cc: Robin Murphy <robin.murphy@arm.com>
> Cc: Jason Gunthorpe <jgg@ziepe.ca>
> Cc: stable@kernel.org # v6.7+
> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>

Assuming it fixes the issue, please add:
Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3182

Alex

> ---
> @Eric,
>   Can you please test this patch?
>
> -Vasant
>
>  drivers/iommu/amd/iommu.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> index e692217fcb28..e405714640b0 100644
> --- a/drivers/iommu/amd/iommu.c
> +++ b/drivers/iommu/amd/iommu.c
> @@ -2754,6 +2754,10 @@ static int amd_iommu_def_domain_type(struct
> device *dev)
>       if (!dev_data)
>               return 0;
>
> +     /* Always use DMA domain for untrusted device */
> +     if (to_pci_dev(dev)->untrusted)
> +             return IOMMU_DOMAIN_DMA;
> +
>       /*
>        * Do not identity map IOMMUv2 capable devices when:
>        *  - memory encryption is active, because some of those devices
> --
> 2.31.1

