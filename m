Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AF9A2AF12
	for <iommu@lists.linux.dev>; Tue,  6 Aug 2024 08:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722931736; cv=fail; b=LezuY42iZHWrKeEzIDdiWaAXHI0vWRrEAzOiWcUj3etkZl0rPJfPfurj2TdcdZ6uBII8OtMQTDGlDhPcuxFMAY+39Ny5yFIKR9MD2sSSELvMZk4708ay3NkBIPxN1vFTy8Kk402Xx952Bh0XWBjAtSJU/Jxf+ie/K9ttkhnzJDM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722931736; c=relaxed/simple;
	bh=1Cscehv3WwXtPR/TeCHPow3Rn1J7X2zqlJ27UDnG7Oo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=h1daDvw6yckXivVfPvq4W0+kvRW+/MsuJXerjVDDHFVDY200h1rbY/XdPOTX7aCgZWAhfiI7TxkeUHrHB7si0y7m8ZgYOaguTjHBDgaxvC1XCCneXF3j1UxuI/aZomGevuTaddIjxkfUK37WC0WibT2hOP2NtsOUvTW0ilgJbbs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ho6b8e/Z; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ho6b8e/Z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722931734; x=1754467734;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=1Cscehv3WwXtPR/TeCHPow3Rn1J7X2zqlJ27UDnG7Oo=;
  b=ho6b8e/ZuEhBNw16zWi0SCa4FGv5dP9ApiOAdBXimBe6/+SkmTHA2wq5
   RpHw3gMI7xRtFSpPrQa34WgJ1LeOFl0p6oLRLZStqjipm+8qEgQdmHTzQ
   LshRTNmOEYM+G32DuVNf2j3zHrTxJabVo0y+YAwrsafntfTH9oCcYjY+H
   rMQojC+sOp7OJFMl9ZDOEPdbb8gkAMwq8wEc0lPlIrBkkg6ZOw/vj/5K/
   Uo6mRdnTIqsJS2k0G2U6fWAG5YHJWS0JGj6vQFLwjGIInawF5fG8sA8yO
   F+dzMtFQnCCPoLdBeSxJyRXBDWwTUgYR5MYbzNIrUTa1l2vk1db8oVbya
   Q==;
X-CSE-ConnectionGUID: 06dyFHxKR6SbS6tX6J7ZbA==
X-CSE-MsgGUID: di6XH0dEQGaKdl++T87hyA==
X-IronPort-AV: E=McAfee;i="6700,10204,11155"; a="21098257"
X-IronPort-AV: E=Sophos;i="6.09,267,1716274800"; 
   d="scan'208";a="21098257"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2024 01:08:53 -0700
X-CSE-ConnectionGUID: ROUkJM4lSTWTOVCB+gKEYQ==
X-CSE-MsgGUID: +jyR42bXTeSZiHxxT72LVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,267,1716274800"; 
   d="scan'208";a="87367183"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 Aug 2024 01:08:53 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 6 Aug 2024 01:08:53 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 6 Aug 2024 01:08:52 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 6 Aug 2024 01:08:52 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 6 Aug 2024 01:08:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z4eNz6R4BSa8Sgzy19pQM8h44CQsdmDQQS47ZdR9vhTujY2RP0o0r3HW3mN5+SGF6D9y/oavRNG/ulZ+Rpmi7MWkRUWHWH7Q7bbjaBK6Zya6UpJU8Ts9O+zpbFoFbQaBgYPdp/GlxDvK2ZPOWNLfypdJ7XN4OKc2yVxFdfDNzaeQx9gCtfnov8M30721U/8XUlnsQqY2u3XqFAZ5WlZg8c/IMhPmsSSVyDU34C3nuSZ9u2skfbfahQycS8RBkpQTjH41VVyo0hcWRQILMFF/atvKLxkiT5SscPU3duqpxDyiRlBKAo0YSZiDFZSHwtkWsSDCIldcyw456tTm+RD3kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6fW60/JfnJfzDrzpwjn25iOhuyEMTxnbdbbLTKa1N5Y=;
 b=Zx7mxgB0Blwxvpc1IpNBCjAiRbJwrhfbzdxi0KFOvKFKcRPjmXKF0ZDBJUdchYFj4/gF/ce6aEQ1ePNP0LE0DAUqAzRSwoFzLlwOLY/eVpxlz1BdnPaQWvsPQVj2rp9bExrYzhum5V87NyzzOasTDl82D+FChG8dZFOQRtBpmj4OPpTy1hISy41cjXDRKQQxaYOTzZlrnioo3ivA15zvQtsMxLk9adA/oKWBFFVAfJkVtIjJmlO6n3+pRaRjhV7f0/l0Om7JXiPdZZ3Sf7qw4NC+ixT1e3JgM7kSst21OGdgZLD14CkH/f4jYbfw4nlw+EtpQtGVyV5yd2teHH6Fsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SJ1PR11MB6132.namprd11.prod.outlook.com (2603:10b6:a03:45d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.27; Tue, 6 Aug
 2024 08:08:50 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%3]) with mapi id 15.20.7828.023; Tue, 6 Aug 2024
 08:08:49 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Nicolin Chen <nicolinc@nvidia.com>, "jgg@nvidia.com" <jgg@nvidia.com>
CC: "Liu, Yi L" <yi.l.liu@intel.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] iommufd/device: Enforce reserved IOVA also when
 attached to hwpt_nested
Thread-Topic: [PATCH v2] iommufd/device: Enforce reserved IOVA also when
 attached to hwpt_nested
Thread-Index: AQHa573hD9PUBMkL70Gw0JwVY8bJCbIZ31EQ
Date: Tue, 6 Aug 2024 08:08:49 +0000
Message-ID: <BN9PR11MB5276C2F39301A461FF84EB368CBF2@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20240806050201.3717816-1-nicolinc@nvidia.com>
In-Reply-To: <20240806050201.3717816-1-nicolinc@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SJ1PR11MB6132:EE_
x-ms-office365-filtering-correlation-id: 2fcd5b5c-d9ae-4889-b37f-08dcb5ef00d3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?hrmvTePOjzX4xJMDjaYnnC+77wEal16ec41L66r7iNIFK77GXXMINlLrtauL?=
 =?us-ascii?Q?IWrPXB4fvVb45kwcOxTA3IM2t3NGJDkqf8ApuVXLaXFTUOZnHD8h2hsPhhSW?=
 =?us-ascii?Q?H4sNJjHvefPmnDY01vJZo4Reig/KxuZ/lfg3ou4X/4ml5JBSdaf9hWS8bPS3?=
 =?us-ascii?Q?iqhQzvJe/a11NOYU8NJFCweGKplVYQqacfhA35h1BWcSmASHfb6jRticybc1?=
 =?us-ascii?Q?C2fUGExtHbH4f1UGbzmQD9UHiQRL4tNIfUqHWAzcLmKu2c4EjtIorc7wEVMp?=
 =?us-ascii?Q?shLOyuP8GAdpd8YwOfwjgcEwtVfWdCJmGww0Da8M66pCBMrUxwKq4FltlCAz?=
 =?us-ascii?Q?0JaUqgJnvfVzelae2reVmhdFxA7vjptDi1jnElEG94U9vFicnATsHV5B3cUB?=
 =?us-ascii?Q?YbHJKFPEtUq3IVT7Qb4wIFD4rMoFhwqiSdwvpmHy+PDGpDY1QnrdQBc8k0BQ?=
 =?us-ascii?Q?vHEM9PUiDRJFgBgwo2fxo3t++B8+Sx3FqTZCNkDFMPyeIMmgBElz2auV6bUq?=
 =?us-ascii?Q?X2fCeSvNPHkigpklfLnRYfHBtXaxn3CnX4Ttv3cT96jZJTlnqJeCyi65wknq?=
 =?us-ascii?Q?23Lqz7dVrJuy+35GbUst1zjcklEkWa1W2Cj10CNp1DI6SXEbXLnOWY8eg/mj?=
 =?us-ascii?Q?8LhmUlLsvBS2FqfleA2u8+e7xXM/++o09dbPCcr2/IaT+HDb1Ct/4h+lspPC?=
 =?us-ascii?Q?oER/yS5mv41nI3xu1mo7kxY6psV58fx2NNlELVsZZwa5KI0NWQvVvM7roivU?=
 =?us-ascii?Q?SRMGJgf6RsIMMN4mpg7GwQbtY+VJ1RAfZeLVJDvOgB7ha/eUX2YGq8y2Ks8g?=
 =?us-ascii?Q?dg+TG6/NaWwC+2K5+k0Lmm1tEb0GvtVZEied4FAKhtQ0GGDiwJJuP6SCyGC6?=
 =?us-ascii?Q?UqmvFtzgv21LDWhE2o47YseoLJJMiKIeth/SmBXLRvYtBVOOQiIDP+ZClp7v?=
 =?us-ascii?Q?Y450JqyKUWdBn6ZojIYtRKI/J4igmN3H70drsTRb5LQ5anftc36UKdIp2JEz?=
 =?us-ascii?Q?T7IeFOSdxGYWLIIPR2EudvP1vrHLINfDOtv5y7ZSuU9R75Fe5MrON2nGIhRy?=
 =?us-ascii?Q?JYq+T79s/Xvc0cIhV+auiXobQ9iVQgcBWrR9GU9ptcPLUK4KI6+5/1lVGVgo?=
 =?us-ascii?Q?5FvjLViep7KL2NbYyPf4KWtV01fY2PrW9v0oskapG6xFZlzbHxipbb9lsqM6?=
 =?us-ascii?Q?V73nhUOCtNoHG8ET/cGJQini1Yc2wHxgZo5Kru/t6R2zvvlz/Y+x0BRgpZhT?=
 =?us-ascii?Q?3l6fY06eLo4wIv4yZfI3k2ciG+2m8REoOGGlbS/Z+NYfeMiZgnyWlx8UjEQR?=
 =?us-ascii?Q?9kctBPgQqD20LvS6Tn8uPND976P35t9t/5CThZMIf/8SYttyu3YAYNrlA54B?=
 =?us-ascii?Q?F3uz8KhoXyeW+6pGD3wRUWNDjOi8n68H77MWMtgFKpkcUwNe4w=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?wmBYcKeXbLhpVl8na4ecZ2+jCJTpy4C9/Oi5mOPDQ9sVqy0a7ZMkST92kRsQ?=
 =?us-ascii?Q?1ZDdk3R2VW4qAyM6QwbnSITP2GKIN5b++X5jdtMQ3twDMWZTiEBZmtfiyiTc?=
 =?us-ascii?Q?9Nn4H9URJ2kMsI+LkrAsb66Y7cylAty8SWZf3DFn1sVrdSeGqb5uMEpdHsi+?=
 =?us-ascii?Q?Mqz1V7y9I+ahzGjAcD4yKUB5yPrUVsLumemLxp/lSGESHT7RLWGNDQHbj7wS?=
 =?us-ascii?Q?xfB2PzO231VESoO/BNJ7URbqh0BklrZmd4BgGXSRUUTsO+j5oFCoNde+quja?=
 =?us-ascii?Q?eYeLDaAJ3VmW+KUOmE3t4+06N/a1eRp6ttslM1gV5cXKm81yKMUyXZpVCJQm?=
 =?us-ascii?Q?nu2oc9MdNVd3EjE+XmsVX71fS+PliL4GG5UI0bemDiID+0po01Eb7LFYNEk6?=
 =?us-ascii?Q?mc2hPb2wIe2rVP+Va5OFjWM/U/THESDw2R6DB719vTnl5kfgN23eA5PD3Y0l?=
 =?us-ascii?Q?NCEHfIbjGeL5cCOzF+20BLc4GphZwuF0L5hcQmMSJomt7nPunNCcpKK8FKeB?=
 =?us-ascii?Q?VeZtHuHC8Xg9nTnyieaiJFeMYnd2umBl/OjbbD18MQ5imtW7QRPi9GY41TlH?=
 =?us-ascii?Q?+I6/S5TkTKhpdwGlB+Tr/N9a8VC2+zsje6hRcVUfhCGIdEOh4WxIewIbybhi?=
 =?us-ascii?Q?Bd9iOG1yxWE+5VQN3Ww0akxFpFzcWvCz+ehK+WpiZY6aX0TUB/rlzxlvtzLk?=
 =?us-ascii?Q?UtX9VUsIG4RkLluULpA5S95f0w5WRRVbVp7X/+GxBuXv8vQUAmsJTBHS8xp8?=
 =?us-ascii?Q?mUZlS+nwI9RzH2l/tRtqrXvlVU8z9Vji5T8EmkHsralKqetKtYroMT9gTMoE?=
 =?us-ascii?Q?AAB1XRkGh46W7YWz9Vzq3ANdUEYoEi/uWFQ8K2KbIyWlPl/2UHR/QbCpiWsK?=
 =?us-ascii?Q?yng+gnSM4NBvJdB3fHpEGazkw4Sgn2LZmLlVl3zn7jweIbYVmXIbpNB9XCN/?=
 =?us-ascii?Q?7PdhXEAOvc+HWfCDl79dPVCRAGMcKYXT+Ws0XrU03VwtoIUSEeUq7TR4fIaz?=
 =?us-ascii?Q?Gyfsen2v4Koc1s+HbQrPVybE5qATWZlwSSiCIzytzDMqFnYSkvZ0a9+8S90d?=
 =?us-ascii?Q?YN+Y4VNzaEBZ7mL6sBo6WSsml4OCZTkAfnB++oWPpBKkR+fUwvOoxwu9glrx?=
 =?us-ascii?Q?+jI1YNXZxYfIu0RI9Njysx0HXWpfFjlHC8VoqUxUq+qAO2XqJvtaBEE0V4+D?=
 =?us-ascii?Q?S3XPLdscRgsOmelXVZoaKlAR2fJUULtdDxWJbZ7AK7xlyWM8X0bDU0F/20zo?=
 =?us-ascii?Q?NycenhXiHu9weOR8qWMPR8wP7o+GZZFM47l74pyovdKn8m5XK6rSHlK2rvEK?=
 =?us-ascii?Q?zmkNrretqL7C51ZR4spTWujoB04xBy01P9CjBRSkWyvRELrIc+nUfaCgjzu+?=
 =?us-ascii?Q?e/vre5GMbZ/b0xo1EkqkuSk+5WRDVEV4j6XEXTy9on/4UVIT1WV7tQbOzxmK?=
 =?us-ascii?Q?vxrhjmR+c4HXfjrXZDxBobgj2iBoyepyIrAKmtLE7i2fKn5t3QQticxAz+sr?=
 =?us-ascii?Q?fNLua7KdqMcYWR+7EcvQfjXZN7N9J8J7LF0R0Ij7q856ySoUNonUYD24MPhQ?=
 =?us-ascii?Q?Pd/ZcGa9ojEYQfxiHowMAs0xQY7w7LmKThpPtDoB?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fcd5b5c-d9ae-4889-b37f-08dcb5ef00d3
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Aug 2024 08:08:49.5372
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 26moZuUJUiLtUSxmziOalw2LhERvx43p0ltLTRAIGlm4ddv0UI9sL13hyrC8xHK0FOJcwqFhXtOVDrGTL2jh4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6132
X-OriginatorOrg: intel.com

> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Tuesday, August 6, 2024 1:02 PM
>=20
> +iommufd_group_do_replace_reserved_iova(struct iommufd_group *igroup,
> +				       struct iommufd_hw_pagetable *hwpt)
>  {
> -	struct iommufd_hw_pagetable *old_hwpt =3D igroup->hwpt;
> +	struct iommufd_hwpt_paging *hwpt_paging =3D
> to_hwpt_paging(hwpt);
>  	struct iommufd_device *cur;
>  	int rc;
>=20
>  	lockdep_assert_held(&igroup->lock);
>=20
> -	if (!hwpt_is_paging(old_hwpt) ||
> -	    hwpt_paging->ioas !=3D to_hwpt_paging(old_hwpt)->ioas) {
> +	if (!hwpt_paging)
> +		return 0;
> +
> +	if (hwpt_to_ioas(hwpt) &&

this check is always true when hwpt_paging is valid.

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
