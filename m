Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010054.outbound.protection.outlook.com [52.101.46.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 346F63783AE
	for <iommu@lists.linux.dev>; Mon,  1 Jun 2026 12:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780317889; cv=fail; b=ca5Bel1gV0jrdSFfbrbs8ztXWl8/jxBSRAwBhaxy5t0T2saPfNk0ZB8Cw7rL6SpgSWWoJ7ZW59s4dJCxeepBnP1sDA6bPRW7xTs/tUG9Wl+9v1H33f2Olz8G44eAHOQt3ChNXaK7h04eTElmtZtiS6G2jY9FV+zYKQm7KgfPFtI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780317889; c=relaxed/simple;
	bh=y4kaglSAa9OtcYtO7VcnH115hBhST9KZmxrIadUvtfs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=VBsgKAfuOrHN1k1IqEebTIdk39uF0o1du0uoclnmqJLez6+w9Qls//LjBX5XBtE58rr6cLrVhfvoeLpmae+bU2Nm61GQlsQQOjT7E7iYqFR/Nf9UOqQREOPQ8EYslVTqdCiA+8F8ZAVJbz2ww/8HBeRWbaTar91skOhBrqaDqE0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=IhceZAAH; arc=fail smtp.client-ip=52.101.46.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="IhceZAAH"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z7a7qThJsF4iWXixejYE+Ldbjc+FGPe5Q2DtUVJal4cPBr00IvTekmySlXdDwx1B6ahbGUZAaiv5OBG6hxAo3pI59P38bjAEbkyKpL5bdOteuwEA8y1Gei50xNnOaxwdnhBkfyWar8W3wjgTUH9YvRvimm9CrLpDg4Plxu4L7roUVgc7PNhQwxd9/rhp4F5m/6pBQmCbYmMqgNAsFmRzAmY81TOccu4MycmGIElY4gKlQONVtrc91IKYgXBdLc8qqIZMpvQH3h/k9PEuxYWEy3wvEELaXmnU9/wKNw/7L8KYcOh1x4BR0mPsRhRz8YT1QV45T29KtEsV9TTdrAaOyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rbmjXQXE5bR/5Q3jJY7ODtWQH0p6FDW+Kw+dr1hpgjQ=;
 b=UIY2FM4WLH9jdvl2zXta3HPtbvL6Y0gOg3e/A4nTt8foEJ5bZBptYtqj3LRs2nCNDc3UYZp+V57ASU+9SojltAhVXWpcQ9As11akcdT9AT47QQKrhtLmYtj5nrpurjZpgUOf/lVZb9/cp2bEgghXr2v48VyJ32U+McHtHfotpb4G/u0KHuCt0xbJq7jZrfSYsHoFo92jvp7JGSH/GH5NodG7jtMTcK7kOadB2Dq+ZpCgyAP9E4ubQv8xEnkQdcZCunNdACQJZbn/dsFU/44e8/gZ9YCiexoceFpyDlCzlMjUZkWjb8EGl+RhT4a97bF5p3SR0HKZp9ces1Yfb+tVKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rbmjXQXE5bR/5Q3jJY7ODtWQH0p6FDW+Kw+dr1hpgjQ=;
 b=IhceZAAHaBsFum+urcZ8V8jbU9mh1IF1d7xza5pA0PHRdQ09GnxC6N2B42uL0UnFicxii9CYT5RszYokfYtzSS9O2UZZdGhS3g3ct47380FP91uWRBv61Tc9kNYVxvLN9Vh3cFSL5KyGabBWIAx62YkCVeQplqUXRsjp6L82PRlI3DaX2IKtLjddvHjUPps5vaB5/YZ+hrUyADkWFljZHLYgkkZjL/Elvl8YSRNv18KZ+dNyHy3BIY2DAgbt2g4tIqkCF+fR+xcCSaszg7a0AA3wlLVuR0IrYRMWsgPK8HvuDmDSeFrAHhorWzQ45Oz+kCQFAL0qE/Q/LiVrUEWzeA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by PH8PR12MB6817.namprd12.prod.outlook.com (2603:10b6:510:1c8::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Mon, 1 Jun 2026
 12:44:44 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0071.011; Mon, 1 Jun 2026
 12:44:43 +0000
Date: Mon, 1 Jun 2026 09:44:42 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, joro@8bytes.org,
	yi.l.liu@intel.com, kevin.tian@intel.com, nicolinc@nvidia.com,
	vasant.hegde@amd.com, jon.grimm@amd.com, santosh.shukla@amd.com,
	sairaj.arunkodilkar@amd.com, jay.chen@amd.com, wvw@google.com,
	wnliu@google.com, dantuluris@google.com, chriscli@google.com,
	kpsingh@google.com
Subject: Re: [PATCH v2 04/26] iommu/amd: Introduce IOMMUFD vIOMMU support for
 AMD
Message-ID: <20260601124442.GI3195266@nvidia.com>
References: <20260528051738.596013-1-suravee.suthikulpanit@amd.com>
 <20260528051738.596013-5-suravee.suthikulpanit@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260528051738.596013-5-suravee.suthikulpanit@amd.com>
X-ClientProxiedBy: YT4PR01CA0318.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10a::9) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|PH8PR12MB6817:EE_
X-MS-Office365-Filtering-Correlation-Id: 165c2969-10ec-4c36-a6cf-08debfdb8e1c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|18002099003|22082099003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	18+0QYRIOsE6cpjXMrUD0fW1VGXjUDd1YfyPF1gDubgPryM6NcuF8LeIy5vUno+CHpfbms/MWL7cTTt4FYrgJz9WMbV1E/yrffmHiruAMr3XYpxMi8rufnbKuw1v2lj25yTbwIpNH2YUHqkq3z2txF3YLUBnJEYOm/sCvBp0S3lN/hXPabC9dDeMP+PGlcCt8o/h4tiB4tHCzckizngEQnBLOumDH16506Potf3A4Y3/WiwOs4R967LX2eRYw6FbwpEaiUh3rxRgLUSX4EP/Y7AvILfxw9jb70lARZHe24vfBT1Uf6mU0ytIyp3VZ+l+OoVF46FbBdOQhnmxvM6hYtqlJIN2pD3TP90scD0uahp039i6ckErDvMRDE3r4cpe4BpF+HyIP4iKGEFI+q/zxe9C+RZn/CcBT7x3CIT3RN52D+TztsS3ldwmYHzFhidXeWAHgeA90I45L6HW99mzFMly7IT8Ln8dPJ3mHb8nh3qnJUkiOLO0/J0t6Yv2T+0t2xTsjlqYP1dfg9HSxTRsDPqeSG5I78WgIjto+T4TDE70xo1YSZ7RypgHf91hJG7AedV7wyPeBB4L/5VWy/0zKmHP2P3uP+SQZJtwOKJ3ywbss9lYNbn5iniDdsaTq+lLvEAe4WhSJ6AUWxYr2zXoy75sMmqxeYLlHlX7nV3x3ZqYIpJas/OrITjxCov6eFRk
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(18002099003)(22082099003)(4143699003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?c6FzPLlaRmIaYusVmKV8uwYKh8tb9f1rFi7VmeQ9AJ5cO/luHOx5ruB5y51m?=
 =?us-ascii?Q?pGAQ5gZUaQx4l7653YptVRfQ5UQgEKowNIiY6m+6t/UNHJtsZAak4exVykAD?=
 =?us-ascii?Q?jNi850mbrbbTDeT5Rj42coJMonx8UZdhDPrFbt557uaYCel/YeacSlXXynat?=
 =?us-ascii?Q?FSOUtTZgihnJA2K6zcCfTIpXyHknISvixAkT6+cvFUQzBX/Ag+OSjvI4IXA3?=
 =?us-ascii?Q?/UvVSCe2q0Au8NiKFsKY+uhFM0qCwmejmuM1ZjNiMT1MHK7153os6tnzhx/W?=
 =?us-ascii?Q?ECDNTWCjhHRX6eqU+Hi822mNOKFE0tjbnY1Fyj4MehbnN8OFyAuMFvJSnqXV?=
 =?us-ascii?Q?j2/wu3059/jCv7L8w1vPR77M+pPdQTVtbvtzqWiLRIZBMKcR0c6zHZXF5KqF?=
 =?us-ascii?Q?536Ad7znfRQZW/s8MAy62Kvxo25f5mXj05ZRvcHS+BN1kk2RAW9/XwHSy/sN?=
 =?us-ascii?Q?AZ/1HxM8CP8+hs56p5OmxiXWePYhFOjCffvChmi0ARVwlK/L6OOCi9rMQch7?=
 =?us-ascii?Q?UCl8/xz/4tcvBNUXkqdWpYHh12gSwnQOrF/Fa7oCaMhHdnljcYkYFXGUJfA3?=
 =?us-ascii?Q?bSgQCwmQ8zdVRG7jpMzKyz1MtuVXMznJqFoaVJiG3nMhye7ux07ll+6HMiU+?=
 =?us-ascii?Q?Fl20R4HFAim0+uWs1IifiJjQYq9Ha8gxTPLPq4iuXUc0gZwsEOFfJFAiD42L?=
 =?us-ascii?Q?OVAVtsTxMASvp10L5U1Uy3HPsIW/pjQ5xnbWPxDCea/MwMghVWzqaELg7xOu?=
 =?us-ascii?Q?MXCc2Q/e2bXKD7hsreRe7QIfKPKuLjT0pMwpXC74BdJTtolUl9z4omEYS7ze?=
 =?us-ascii?Q?sb5X0P52UBdZOrvSiKS0evsM3qUCCOx0BmIDQtuLBaZnM9FhoC/JovBpBGc0?=
 =?us-ascii?Q?Kfk2HcTxMcoVqb22uJK0EXSOVJ75tQuzC9YErj3VGVSe5CovZr27VJPpBfii?=
 =?us-ascii?Q?gScIG2L8sVHnO4ItDJGNuXp/Izx7rJULup/QtUYZih+GaSg/OIURFq0WWKnU?=
 =?us-ascii?Q?pxg7ERM8XRWwyhseXSzDkMQY9ez6Y2DV6joizU8TFLVGrbcQgbMLfaJ13tFV?=
 =?us-ascii?Q?7gcF6o8Xp9sax9FDmXptyWKraDSBJw8iGp5itUqRjBmtL+AoLCVErEpIW3es?=
 =?us-ascii?Q?VSLIsg7PKEZpJIcYnamIi5vSVOhRi5wPuI4rlA+x7x+VZY0CqgD3HjxEkSPs?=
 =?us-ascii?Q?tR+IaYo887tPspdVADDmxjwuFA8w2f/3a/2Qu2sxSyiI5Jc+Sq+x2A1KMkaH?=
 =?us-ascii?Q?hGJmK0j7kht2jKyCKmPe4W/IoydddvgKiGeMzf19rvI1AwH+xcxH9DPhAUFu?=
 =?us-ascii?Q?LQ4dYrdLpX/S4ePgvNFWUIJoA8LWA478cx90e0LYKQgrZ5fOuAFgd/u3p2eZ?=
 =?us-ascii?Q?+VAm13tWYslYWey1zIWQSYJtBoIdE0bsQcxqwXcq7O1JUGA2MxppSu8voGUN?=
 =?us-ascii?Q?tj6in8aDFxKeOTT8TAr4r8ChYe1I0TdJPR+hlWWcOhceIfdIP61QqY5fqaXN?=
 =?us-ascii?Q?nBgCHY2rY3bEsOEvJRIblPxzxPJ/HfrSbRavnCvCYM1ji51o3eLJ7nj2XUOF?=
 =?us-ascii?Q?TeD8/5Nq1c9jNNLS7969xPWhapGqR3OADHrUKE03K/XdePvhRlB3yyfzz7cc?=
 =?us-ascii?Q?7nwO1MOSJ9ZhbzazK9/1qS9PDfgoYszfaPvWtaj91vTviqYkQfNR4Ayyu9CK?=
 =?us-ascii?Q?g2lrgiDgJeS4oNKNAsr/DnwKr2t1pGRdPR4loCdykuLzUNc0?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 165c2969-10ec-4c36-a6cf-08debfdb8e1c
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2026 12:44:43.8369
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hdduNJ9KHJ7+Gr0rIU5/jpLGAVlc7PyDfTNaDReNaajGKOXpG0zqYDBVpx/kn5Un
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6817

On Thu, May 28, 2026 at 05:17:16AM +0000, Suravee Suthikulpanit wrote:

> +/**
> + * struct iommu_viommu_amd - AMD vIOMMU Interface (IOMMU_VIOMMU_TYPE_AMD)
> + * @reserved: Must be zero
> + */
> +struct iommu_viommu_amd {
> +	__u32 reserved; /* must be last */
> +};

Do not structure patches like this, introduce the full and complete
ABI structure here.

Jason
