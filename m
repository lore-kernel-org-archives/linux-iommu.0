Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A7DE2FE075
	for <iommu@lists.linux.dev>; Mon, 16 Mar 2026 07:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773645129; cv=fail; b=t/QpOmFU17R+6oMeEEBbmssFuoBEZ4waXsvb58sHXlQaFtfyoAsnwjwT+vKo79da1xdMjmR2Z7zvmk7zmJKFG2R3DrUFkJdXb3g1GOZ1R/dJxo8k8uGpuLzia12eieaZoBFqj+bRqhk3i7aVnxlMaAJWQ2NkRFmH7YcT8oDFTFw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773645129; c=relaxed/simple;
	bh=IJcAOQxNxNCHm/5hmaDIjNJrN9sAVwnHpJzd4cWsxAw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MNV8CnDFsmCDaTPRLNi78mihYDu+DTcE62Yuh2Y4LSpDohskNG/D8XQICZpKzz5vQIuwUKPA962iYPPe54PaOV6xBQI56erlkN8opdZc8yeO+Me9bZNs/IGR/Fo3kSV6UvcA0k1HZp/irkdxiT0MYKn9M3CwWuitEFa3tCdPwdw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ws3EWRsu; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ws3EWRsu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773645128; x=1805181128;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=IJcAOQxNxNCHm/5hmaDIjNJrN9sAVwnHpJzd4cWsxAw=;
  b=Ws3EWRsuPVb9eCNtSvyoO0JilpoGDsJiGTXZOse8k3qHIHmGTzb+xIdS
   3UwjzKqEVBz0CxgLkAHhgejBjxmWUFU1q5jNLou9VLCI87wszqZ3rJWwq
   ZcT/GD58paD8NyLDJTEz1DcwPF6VH9VX8QOibyBFTMRCCInFAaxI38OuB
   Nfyxyg7dcaViAp+8jL408GoN+ZBJBAy3d84V9bblwMzT4MvvMGG+KyPnx
   nlO8Pk7yM6IBdRC7pw4zY+DhTN0GpB7pBn1rJ/9Ab19ezwkb3JOdi1ctG
   +5M6DbzOrrfCHhreZVItp2k5iYB8bazndnbaOSU65U1VTZWBg9nRL68s/
   A==;
X-CSE-ConnectionGUID: KQhvWgTqQBK7MECWhVepcA==
X-CSE-MsgGUID: cJbGvsoySbCDE5Qf+fEfBQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11730"; a="74690494"
X-IronPort-AV: E=Sophos;i="6.23,123,1770624000"; 
   d="scan'208";a="74690494"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2026 00:12:08 -0700
X-CSE-ConnectionGUID: lM7D82F/Su6a5aKf+U68wA==
X-CSE-MsgGUID: 7tko6e+rQd+4SZU69OeGxg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,123,1770624000"; 
   d="scan'208";a="219425364"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2026 00:12:04 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 16 Mar 2026 00:12:04 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 16 Mar 2026 00:12:04 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.52) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 16 Mar 2026 00:12:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nTYSXUHSodQj6rSotAVV0twNMFF0IJCjv5GdgKzEYQC/InTBSyVqvERBUd/2A151gGrPm6+pXtWal+10aXKWdHX6v0Uc6KA1AZNwfKAb3qLywnuA5DAaaMGFL0ovuR5XUVhrwkTHcKWi+Bt8xLvN9u/50+PrmLgNo60NSqB0fKhPYaS//jpENlzQiF72UIj2mQbaRBAWIQdpTHwVnNj12n04YYo0ZT+SO0LPXv1G5jYPuJviIp1PtEZcKg+H+faA+DQayHWUSRfgAhRaWPSOzosUYSOR/ZGa2JwbYCtLkjynY9GRhNmA3Sv2j+TsUUfOJaww+4OpKOQbFcr1j3g4ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ajgrsTt7oPfiFmK0fwXevjNHLzUe9s3PKgqXaRqJyF8=;
 b=ZypsyItaNdIVVgUIIsix0F8XxQNIh0aSWllNJIL3GIfEFaJtO45/C5SeeKiqiZaxxNv2ijlC/FYZa61DS9CnWoUUDHm8F0ju16mIiLkqwhJrpPgWtlfFVo+sxtc/ydilL45WZ9krjV2nzkqWNWlLhVfMv4b4k2NLX320BdxHzWxiB8Ps6efGNRKfBiqBqdnjqTcQH2h2ysFCdsgoMVL8P2z8cfbh5jg9KQBMf7FTKGqvyUOZJnHBxU5sc3cNpIZqbGhZB/tr0y/ZHsIvARNn3R8lA6GnTsjcT8ZOjCtRlmLZaXDmUwOagyxVhsTfnuNFzHDY9c5s4b5wIgo7LAboAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by BN9PR11MB5322.namprd11.prod.outlook.com (2603:10b6:408:137::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.17; Mon, 16 Mar
 2026 07:12:02 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::f997:762f:f079:134f]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::f997:762f:f079:134f%5]) with mapi id 15.20.9723.016; Mon, 16 Mar 2026
 07:12:01 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>
CC: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, "Bjorn
 Helgaas" <helgaas@kernel.org>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>, "Williams, Dan J" <dan.j.williams@intel.com>,
	Alexey Kardashevskiy <aik@amd.com>, Samuel Ortiz <sameo@rivosinc.com>, "Xu
 Yilun" <yilun.xu@linux.intel.com>, Jason Gunthorpe <jgg@ziepe.ca>, "Suzuki K
 Poulose" <Suzuki.Poulose@arm.com>, Steven Price <steven.price@arm.com>
Subject: RE: [PATCH v2 2/3] iommufd/tsm: add vdevice TSM bind/unbind ioctl
Thread-Topic: [PATCH v2 2/3] iommufd/tsm: add vdevice TSM bind/unbind ioctl
Thread-Index: AQHcr7Zd6PCT7CXd3U+POC29TSGUorWwxrMg
Date: Mon, 16 Mar 2026 07:12:01 +0000
Message-ID: <BN9PR11MB5276585EAEC4C80D4D45DD8A8C40A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20260309111704.2330479-1-aneesh.kumar@kernel.org>
 <20260309111704.2330479-3-aneesh.kumar@kernel.org>
In-Reply-To: <20260309111704.2330479-3-aneesh.kumar@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|BN9PR11MB5322:EE_
x-ms-office365-filtering-correlation-id: fa26d838-749f-4329-0b00-08de832b5205
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700021|22082099003|56012099003|18002099003;
x-microsoft-antispam-message-info: GOVgSQoKSqypQp/9ae658J16hmZRCeTexGGWMYYDZa57+3m5r9GZv0V+Gb290JZF11573s5PgA12V+ziiCBmQZEbApXtNc6jBZxM2oKRqUnU1Qm1qFzKh3sxqgwKAWgrSiz6PhDEiDuIjJhlPnogjkfRHd0Espzww1swQI5EgwUhSfsxv8XVgfOXKSe8eFSRNko4towD3kTi9/1GX2v2DOtqxoemurd9TGzeSKUiEQ9L8cknFigiaGNEJZYNG2byZMAypQdhOs7Xh8SwUu53/J/WjGifY7B+LTFE7oimoUC4VYXOtkKs1waJXVkltfWjCxDQBaywARxkKZrHp3PB20r98NRaM3xuXCBW2HLYT3rmUQ4WU4+mqSY+HLWPwT+/A/bB7NY9Z2CQnwFAzV5rt2TdWlJgZPXaurJks7QrGKMKMUEYoK88w2tI0xd9LoiUxHvxjB6qRAMkQVdjROLDW60bti+WNo0PEkcAUqJdHqS4EKGrjhiqA31lYJ3Fa8Iu0lOaIR7ORPYX7uSvM9tDAg0nnjUoVrEnGLEVXzizOaRPX8JUZRlHPZOtVG+qTRqFwozNK0BsNHn/lnRTefnivl/uR/xIuaDzK9UZs+53ZS2/Y/f0Y5fYWaHVlO5+A93jjrLHj/XLHavqE7BB7whZtJj17Uuo/jizQnMs9In7swnwxVlDRhWiwRz9uguRhJs6U/oBYTYwJiBSgdDftMOn2TgHwrZDmrUJj875eSMX5WypjIMiqvF0E2qxWg9zweDLHZ+Pb6AsucmR/jK7tSwE+/himS6ov+1oqyRP7g2ofro=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700021)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?bH7euxc4oi2OBgjSa6jsEqfbPi+BLMXkg9VVTCKY5Y0az5Hpd+cv3n3NIofj?=
 =?us-ascii?Q?SMZQ8N7nW6G5hDQQ+zNTukGNr03Za+SpbOBQ2hxOPg1EewGTubrwZX7mjyv8?=
 =?us-ascii?Q?doqws5r8/xj5UtRvAVrhozrhliixISgWRw9MXzRpb6buvbGdwA28hi2TaqUN?=
 =?us-ascii?Q?Tj4EO5iKw7IFjc5u4LeREAbmQt+JzNLvcKT0RRRg5efsoZxO4/uKC522LaL1?=
 =?us-ascii?Q?lyc9IWEDOMsmcifd1OyUta7Y2u0ZCXVCLsE8q8wpB8KMUPITsdL4bu5kQ3G7?=
 =?us-ascii?Q?ecMmZT8inhujENyoERMHCHq2VeGXanEOte7YpoCDP9beMm4BCqVxJGhrsfx3?=
 =?us-ascii?Q?FcDddsX289qUHXfrbFxYh7qzprritsB0KlXXo7Prvtd2udKXoZPkSet6p0G5?=
 =?us-ascii?Q?Zx3Yvlq3XYKkWcyaT48dr1gwquaV+bygiQ8Cg/jX67W/ZNbL0RHmnsHM33YZ?=
 =?us-ascii?Q?SfCsPWMo6hcgMjZnQepURo8MYdcCCfwfofgCPckSqVlpJq3GLx3AFSokjVUL?=
 =?us-ascii?Q?EZmvWiFfArCxNBElnC371eGSEbBFYwNjcBLYD7Hq+yYU1C3/EjpivpRzkTif?=
 =?us-ascii?Q?/dSvN62n9v2woQ9JPqHR7y+HD3nI5eX/SMRKTrwCc9YMno5EZOGG6xUFTuu6?=
 =?us-ascii?Q?BgWuYZaYLviOgUNjpbBB2A7hj4yLKQSezjA6JenCyV6W1UECV9S3tMf0xyiV?=
 =?us-ascii?Q?thzpR9dgAcbeiAuwxvD3ywYIri4ePYggGPA8O+YykwGBJFFKpkWnPLQ5Ahqm?=
 =?us-ascii?Q?uYIeOZipL6I+MXQu3mb/H/lUXK0UWPY1O3Pq3ZMyTJIIsu6V5xGU4haTJ5eV?=
 =?us-ascii?Q?G3kcKSsgh8tR3s/Eehcfh+P8+1hyIuGxfIetTzCcT+s1yD1xkjfLQ8BLXTbR?=
 =?us-ascii?Q?3yGw/pwsCOg/1+DCap4VhgZXh+x4SwVseQ3AN9Bv8JVCKvW9h/rTE2a3WzeL?=
 =?us-ascii?Q?DnFi/tVXd0jr5T3yR/ZMrcKFyDkq7/bsZad6Q9lDL1Z5k/XEXlKKtJQBN26z?=
 =?us-ascii?Q?D3F7yjdZ65QRjk29JaLYf+w3KBAdN/EAhgWcEMAGip6tEPsASRQlZ6eCaEEO?=
 =?us-ascii?Q?QivK6e/vlhfk73DCepRwNm+r0giPwWU1MUN5mtsfa2s6tKjycGuuUtF+7kxL?=
 =?us-ascii?Q?g4jWSVyRZRbOOQhxLZNCjOX4Qo5RLww0A+HIcBF7Jfvr+jnUwxlP93X9RFOc?=
 =?us-ascii?Q?iMSF3SkE6Gfqul5eiUk5I5Lvi64iLpifB/Kga/wiwsZzXywC7qJPLDcYl2G6?=
 =?us-ascii?Q?W93CK5fyZRhyPITlb5+QfRCSPWBtQe1PiR78NZ8k0kF9sw/Rf1ANOz0kgK5g?=
 =?us-ascii?Q?dJWIiXrtMzrC+yJcBbxLZz6d6a0AzKROMvxTwBbYPil21EmbVh2H24gPJUah?=
 =?us-ascii?Q?f85U90YiSqYRlxKOWcYsIPFV3OXDLhulUBuuZRaL4XvoZ/woj+krjUIIsBqg?=
 =?us-ascii?Q?R1nc2pdrjik1Y5eREl1mhCwH4lxLsXjwA+fTlBqxkyz247vTJ6DEYu+X3Cdc?=
 =?us-ascii?Q?HCbryVjZMB3FhujR5iMS9IV08V037BvY9wmk2jQ/hpNn8P5ix+8R4N20TEAP?=
 =?us-ascii?Q?HJ8aT8F1tRU63Y//26cSedW0Lb1bafpIrpM6WnSE27usJ98AVrk0evd2IwAv?=
 =?us-ascii?Q?ulYrbFyrCPA3Yfi6gvLNWomJhJQTVXoXe3l6nV61TCH8wu0cZtmDZP/VJe6L?=
 =?us-ascii?Q?OcoZLeZn3TlL7KzgTLemfONXobY2mxEeOocNf91KPYUpkngv8pomxjn9n24t?=
 =?us-ascii?Q?YCAXuLZvmQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: q73Evblu8znCIwHG+rKfUBmlWMbFpOCjscb/G+pQfTrDTXnRjQZpHtt/H1FQ0DyWkO9OcmbcPoniZUQ6W+FrH4/jV1NDvIL7WIhIPYHxZWXOCbeJW5CRifSqQsxdvZMQhnV19al0d62WdMpbW+nnhjzcGatk2qYgMvNn62AYSrQD7tPT5FMXJWj8Q7nUQ0IQx1VaXrAD0EwYonU0VJxiFRbRCMIc2DYimc/CIq5F9MCFALHwcaDBMCS8krcqVw4Xf99Wksj/xlkIJ20eThH9fhBujxaqnP7hQNvSbWWNPynBkVF2lRNZxmAGQhN7xZOJLRY8eEhyPe/wbi+3uzQ0nQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa26d838-749f-4329-0b00-08de832b5205
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2026 07:12:01.4946
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rDESAK6KxvoEOIMu/LIUxAxza2iffB24qYQNi7SYq7w1dHIAZbgSHorpemgVVdkg9zj0vNZ5zpCwfHPodyYSjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5322
X-OriginatorOrg: intel.com

> From: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
> Sent: Monday, March 9, 2026 7:17 PM
>=20
> Introduce IOMMU_VDEVICE_TSM_OP to allow userspace to issue TSM
> bind/unbind
> operations for an iommufd vdevice.

How many ops are planned? If just a few I'd prefer to openly defining
it:

	IOMMU_VDEVICE_ALLOC,
	IOMMU_VDEVICE_TSM_BIND,
	IOMMU_VDEVICE_TSM_UNBIND,

just like how we did for IOAS.

> @@ -432,6 +432,7 @@ union ucmd_buffer {
>  	struct iommu_veventq_alloc veventq;
>  	struct iommu_vfio_ioas vfio_ioas;
>  	struct iommu_viommu_alloc viommu;
> +	struct iommu_vdevice_tsm_op tsm_op;

please follow the alphabetical order

> @@ -493,6 +494,8 @@ static const struct iommufd_ioctl_op
> iommufd_ioctl_ops[] =3D {
>  		 __reserved),
>  	IOCTL_OP(IOMMU_VIOMMU_ALLOC, iommufd_viommu_alloc_ioctl,
>  		 struct iommu_viommu_alloc, out_viommu_id),
> +	IOCTL_OP(IOMMU_VDEVICE_TSM_OP,
> iommufd_vdevice_tsm_op_ioctl,
> +		 struct iommu_vdevice_tsm_op, vdevice_id),

ditto

> +int iommufd_vdevice_tsm_op_ioctl(struct iommufd_ucmd *ucmd)
> +{
> +	int rc;
> +	struct kvm *kvm;
> +	struct iommufd_vdevice *vdev;
> +	struct iommu_vdevice_tsm_op *cmd =3D ucmd->cmd;
> +
> +	if (cmd->flags)
> +		return -EOPNOTSUPP;
> +
> +	vdev =3D container_of(iommufd_get_object(ucmd->ictx, cmd-
> >vdevice_id,
> +					       IOMMUFD_OBJ_VDEVICE),
> +			    struct iommufd_vdevice, obj);
> +	if (IS_ERR(vdev))
> +		return PTR_ERR(vdev);
> +
> +	if (!vdev->viommu->kvm_filp) {
> +		rc =3D -ENODEV;
> +		goto out_put_vdev;
> +	}
> +
> +	kvm =3D vdev->viommu->kvm_filp->private_data;
> +	if (!kvm) {
> +		rc =3D -ENODEV;
> +		goto out_put_vdev;
> +	}

	if (!vdev->viommu->kvm_filp ||
	    !vdev->viommu->kvm_filp->private_data) {
		rc =3D -ENODEV;
		goto out_put_vdev;
	}

	kvm =3D vdev->viommu->kvm_filp->private_data;

