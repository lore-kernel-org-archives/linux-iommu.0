Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 758E43DB63A;
	Thu, 24 Sep 2026 08:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790237857; cv=fail; b=K6V58dvMSSSDHBYodvID0+71+W5PzfP+P+w4lGONwFKIt0AMxef/0NX5HUz6cD0yqWHxJUTYlYsu0afxBivKTwpYtP4ju96d406f3saqQAMmLFmDacUoifAZmG+iyydJgXdBVkKCkhhcyK2VMzCjsbIsuWlVdvEUl9Vl3xOaLQc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790237857; c=relaxed/simple;
	bh=f8yfPz9lhsB2m5/ncZ/PAqJdUb5hOiV143x/EVV4gEc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MExdW3q+CO/2PwwV2fuPW8JzYbyW5a51LET78VNR54sXSsmYM1HFP264EW8RGFjlPLvUoan851AgfIm+sX2IAHAfEa9w/pVpdFTcUCzblRFk133NtZR1V66tzt6siWxWsnMS8KARGsPCoUWCJ0UDY1jX7VXV1SvlY0Rv2xOlkI4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OObXw0sB; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OObXw0sB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790237855; x=1821773855;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=f8yfPz9lhsB2m5/ncZ/PAqJdUb5hOiV143x/EVV4gEc=;
  b=OObXw0sB6sjXQ1CtbJOE1QxBKHyESstHhdf9QyEevqeZ7xy1CRoYx/1c
   A39V/ZeTfEbfPwrGXwLTJn+fj/y1h3AwEKti+TkxSM3yzlmXeyF4hTY1O
   WN/8/cR04QtOzOfI63ey6LUVFXBlfmQUtuu+vc+HXsFtdmBhjfSbL6cIn
   6M7hjCjhT8bk4s90oCEbRPvo8hgNhf5YkjZgfl32C5PK6foWC0ZyCRHY+
   VNUKJLNf8yiaxW9XDUYJsdYnj26uMzMPjK5W1FpfhnvbIhGWMKcXmrOze
   D0K3MLEESjVGlvuzOJeZuqd28T7gQTR6nKZvdUjf4pGTs/qXJqQcfmmb5
   Q==;
X-CSE-ConnectionGUID: t6h7A7qeTti78ekj71eK6A==
X-CSE-MsgGUID: UhmUdsVXRp2kCptZ/LUIzw==
X-IronPort-AV: E=McAfee;i="6800,10657,11914"; a="102360207"
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; 
   d="scan'208";a="102360207"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2026 01:17:34 -0700
X-CSE-ConnectionGUID: 3eiXyx1eRkCdsNQb4UKblA==
X-CSE-MsgGUID: mrK6sD8MQq6+L16vGYm/LA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; 
   d="scan'208";a="274155023"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2026 01:17:35 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 24 Sep 2026 01:17:34 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Thu, 24 Sep 2026 01:17:34 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.25)
 by edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 24 Sep 2026 01:17:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O9y+zUO/4W6JcbgRRZabv2FssglGhfI9CbCkXuVyOop50uYllmuiRlsvULV00gV6xX1IBaE36Lqlp6YYAxhiB1QZGwZ8lig/4er/Sfab92+WyqOyS/EsNPb5vjN/KpcfAlYmnGJ9hHFvVyiz5MM7K5UnhUpYRROdrcB4d4ow+lrYTboWO8veTrhBThRlc5j62tHB7Q1kKR9MJVkfjbLNJnD6Z41m1Oosfo7bOltbib2hPcfe1LvYM3k25y7OjzXYnYLIrErsQQyk9BTen21gP/nPfGkP4G6siHe/PlHN1Xp+Iy2GsTB0S/+Ci70JQEahq4GHE9P1S8Z5SM4GX8vTsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Oti16NUvAEQBSpSQ2/Zji/gQTmLMWAFsmSfVVs12ySM=;
 b=Dy8Aop0cvwpfK8SFuO2FkIunAGYk2KPypZMxn+PksvZB5RXCgpoK7L8gA5KsU2Z4RjOFa3GSYluwsvik0rdzYUkgmII+e8Fjzd4bBScsjVy8hvP73vgKgu8/n2+3y+KTB3qMIPZCEafFqLj7eMRDnk45cD2p82JGWgyPoUK8olFID5SlOBWimAPQY9aHKYr/sms+Cr+BlZ8U0uiitrb04Kl3eY73n4Gm24UUhEHTsF1dkgUwPOMR+FLy4rKT2ZPYvRzFvGfagKoCJtXC4SQLkRwWasZNDbhJNpLTsC93O8yT/EYXt71KHSkTZnC7rr6BIAdGNTPG0jyERDQXslPiFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO1PR11MB4835.namprd11.prod.outlook.com (2603:10b6:303:9e::22)
 by LV3PR11MB8529.namprd11.prod.outlook.com (2603:10b6:408:1b3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Thu, 24 Sep
 2026 08:17:32 +0000
Received: from CO1PR11MB4835.namprd11.prod.outlook.com
 ([fe80::d051:d948:c209:9225]) by CO1PR11MB4835.namprd11.prod.outlook.com
 ([fe80::d051:d948:c209:9225%4]) with mapi id 15.21.0451.014; Thu, 24 Sep 2026
 08:17:31 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>
CC: Jason Gunthorpe <jgg@ziepe.ca>, Alexey Kardashevskiy <aik@amd.com>, "Bjorn
 Helgaas" <helgaas@kernel.org>, Joerg Roedel <joro@8bytes.org>, "Jonathan
 Cameron" <jic23@kernel.org>, Nicolin Chen <nicolinc@nvidia.com>, Samuel Ortiz
	<sameo@rivosinc.com>, Steven Price <steven.price@arm.com>, Suzuki K Poulose
	<Suzuki.Poulose@arm.com>, Will Deacon <will@kernel.org>, Xu Yilun
	<yilun.xu@linux.intel.com>, Shameer Kolothum
	<shameerali.kolothum.thodi@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: RE: [RFC PATCH v6 11/11] PCI/TSM: Add reference-counted contexts for
 vdevice providers
Thread-Topic: [RFC PATCH v6 11/11] PCI/TSM: Add reference-counted contexts for
 vdevice providers
Thread-Index: AQHdRq17l8CkYqolBEmbp0umMm2PoLbdbHqg
Date: Thu, 24 Sep 2026 08:17:31 +0000
Message-ID: <CO1PR11MB4835F4332940A2D2916DC9308C812@CO1PR11MB4835.namprd11.prod.outlook.com>
References: <20260917140159.1163281-1-aneesh.kumar@kernel.org>
 <20260917140159.1163281-12-aneesh.kumar@kernel.org>
In-Reply-To: <20260917140159.1163281-12-aneesh.kumar@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR11MB4835:EE_|LV3PR11MB8529:EE_
x-ms-office365-filtering-correlation-id: 80c3677d-09a2-465f-840e-08df1a1447f2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|23010399003|376014|7416014|1800799024|38070700021|10067099003|56012099006|11063799006|4143699003|18002099003|22082099003;
x-microsoft-antispam-message-info: wS+wEQi6PLchV7q7yb0rso6IMJgjDsvJSXWarwNHi/ZfuBiJo25+Hi8ya+buDUJUr2vh4bAauMYEIOlVs7ErT0fCE2Fye9YYvrwyMUXOlWI21VB8MA/JMUNtF9cN2h/q6a7wdTG+0aGTD5QTGBa3nWljoOpN8H+o1jZf8UKiWTTfxVJzmiO+TbGIHW5SYthlTOTRnXgOXcodFPw/vfVxC5HHEAig1RGmGNfo2yB+NcHBiENcEX7SA9DPPXQv664x71YwB0trNJXCpavZPTT2aG1kSZKklsfQik1MR4Pvr75jr5ejDLjfZHJqILuqtEOAfvZcaCKu8RjTEwH068nl1kOs0ZnsojaaVgk/qcj83PEWMz9BCp4egV/8RB7T89ct3MxqMLnO3IkMAltrflYZQBub2ec1sCyDyLQkteWjI9/iJf8DpcUS4qLsbiYu0sKFELOA6RIdJvF3JQnQV/r+c60IBrzn3CfQJ6oCitASwKppFwqbT+WbfpjmjUecOp57AbmKmrgOyaZvaLO4rmA7/YYTcbMaOBISnVJzD9Thao4BZJJL9hXqKDpXHb6zeFswNbrq43kCcjtY/yMg52oL1IYB2gYm3b3/KDqzRReWoxflkrcgz5g/Ldiw8u80sFFm88pxGfx6Rtve0Iu0cb3NfhNcFQx1ffQZLMTiiOQfBQZzICv1P2AnSPaY0wKEYneNA1Y++bPuuXqTsykB2CTgNw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4835.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(7416014)(1800799024)(38070700021)(10067099003)(56012099006)(11063799006)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?nCNmp/1ODR+5pzUn8s6QP7CJxLG0vK4jFM3D2AmtGxHqt0YBpYBiTrWsD9I+?=
 =?us-ascii?Q?jZox4cBY/+su8J1PdxAAjxDm1ReqKdrhLUbxfnJGuN/hq0YnYmG39byI0EMO?=
 =?us-ascii?Q?cAZe4pt9drsJAgsfuyVM+YVwMrxf9U5nO4v42wdkYM11BmCaP76Ebq3JERQy?=
 =?us-ascii?Q?bRaPqF+Op+1bIZ2Eg3MM6LsbxSU42K6s07NullE4USdGasJ1AnIdIOdiLTt9?=
 =?us-ascii?Q?SPiReAGeK3K+m05Os7DrJEDDy3/1goHVRdHV8M32mQQ34iVmstyaGkXUMY2S?=
 =?us-ascii?Q?Ncsw7vDL0yizwdEhbGz7/fHtfwpn1X8wG2DX8K5lZPaCvQY9VNDjSAQzrRWc?=
 =?us-ascii?Q?4SVaDMBGPbPE1OxPMmMs5Lbdoz51XyO0KFcvwMgJEVeJK117PeADoIdPbghF?=
 =?us-ascii?Q?DfgELJNNwFkAJxqvibVzZtcAAy5a01O9OqwAM/aY3Ej4JZK8PS/0XFXqNdN3?=
 =?us-ascii?Q?G/CpYe0JFRqG7yNW+T7bmy2CXRtCZpu+yBqLgYcGGKAaNeF7NXUx0SvqVg2W?=
 =?us-ascii?Q?EElyKZSir8Iv8ypJfQ2XeQCa+ovSH3ZirfSALPfVQq6wkbmRGwW8WyP5l0TN?=
 =?us-ascii?Q?hNACRqhnmmh0TZJIhpnvFhBP6BW3hFZk2aZQNBfPTSwCtfTsd0cXTgQSUN0i?=
 =?us-ascii?Q?L3ugmWP9lakZ2aD4FCPaKD04ZNfAzq+aSXfOGTJz565CB0Mx1uZAYf1wt7x/?=
 =?us-ascii?Q?k+1reiiayta5pq3Z5XEe+PBzKhYE+1/IOpVnqXJ1oz191J6n2o3jZ9j/1kJS?=
 =?us-ascii?Q?LR9IbrtvGpHLcIYQfEHzI412c/D58YmxzZyz0cTpJF5Q4h8VuGEl4fvS3ebi?=
 =?us-ascii?Q?Tz4N5Soe+kLth3hUPNtieOMvcEO1GlBOlBaV9DL3pAvi6035LLvFuW1FOVQ/?=
 =?us-ascii?Q?dmwap2BF8FU6noR4YesLTmT5Y59wKYRz9THgWPbnMN0ra55HGo7uE9sfSFbD?=
 =?us-ascii?Q?frajMGtYEQB9D2J0peHTWqDWe2r9xA9QmYhGAuF5K2ItdPcV18dEZA3fpwTq?=
 =?us-ascii?Q?ydwkC6++4JgPOzv7dhUAAC/lPjhuemk/gnwgCTd0GxxeAmN1a0L1BYkbBMA/?=
 =?us-ascii?Q?3sWfFnAzOTNq41vqHwgLNJfCBBZU78BA6YfZfVDWIitF1j8aLWJMVLoVjvPK?=
 =?us-ascii?Q?6N7dwx5GFtMVIvqNlw1DcSNXapCzX5t6+eGfdFWWybJrNiMCB2ULBc3Uckiv?=
 =?us-ascii?Q?xqz0f9hRktPvGhkzFEVFStMZ8k5/9f21pg74hDnV7Gg3NiIvoPgy3n1iAr/7?=
 =?us-ascii?Q?7aVbGhFcHrcUSnxIgnApKLvSspjaRgT2Dt9+TOVVobqhTXxuNXyZ1LiN9eCq?=
 =?us-ascii?Q?NtLp/zBXSZ9QFJ0X33rzeuBXepYu8c12FSYgTy0isD+8+CgMVxL4bZOq+/o7?=
 =?us-ascii?Q?cW3za7vHDzK1aZXQ5yj4f93eaKy67X4Sh8fQbdq62JexdJJXlP1NFhqQ3EXD?=
 =?us-ascii?Q?LkRq+6K6MlySh5dOK6QY0CVksyWnmIbvtPvfOgBW4tjzW+xZgiYqjgaKxGkw?=
 =?us-ascii?Q?RYqLFSv8TKKoh20rrUgtLBwEMRTcYKdyIDWS+g3Dfv0Q1vTX07OjgUEegsAD?=
 =?us-ascii?Q?u49jiJKGRqjd/53LFwdYuSZLwZU2+lhcUtAe7W+cSoB883eKOjK5itUsWUt+?=
 =?us-ascii?Q?qPHNm6qL51tZeYJQlNwAMU7S+9orS6z1JTAufjYEKoorc3vveFuHrdwtlsZv?=
 =?us-ascii?Q?v4EdgEz+t0KiscWU29/0aQk0rs6PgfC0vO/4eynqTCSZWLcz?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: VXuSYUTcFJ3GPMwXare7ULIGa7fpIYdYjjkYEm7zsBtofp6AFS8Gw1PINwwZt01RhgkWHPtgCn8F6joo4BRK+4Qzw2e7kJg30OveglkTVWjNwnA/EO4/hbjT0JhuGfXYurONycwCGFV7Lc4zA+qXrkPXaFN7mct/+qhYFJEKKFOZ8pYebqS60PV0cm+gTqgeUv4QO5RkJ6vxDdk6OKpQaRhvNjzNC95jrtg3wT9CwSmY/qaDnAPRO3jzIpA85mO/YcDy4cZmWtF1d3R8C5WWWytVGSvgfnQ76RiJNwtn3uJ25GbqSYA4QwuNFXpwvkJ6z2p1LFPDRD0b1fzyRKVwdg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4835.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80c3677d-09a2-465f-840e-08df1a1447f2
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2026 08:17:31.8041
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8DN2vLXMgM22rLxzCwIQ7ZvfWut86pTINJRGCW8kif/HkEHOUw3ALEenQ3gAwn8/PxeNmNO1QTHUXiLIRf+bnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8529
X-OriginatorOrg: intel.com

> From: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
> Sent: Thursday, September 17, 2026 10:02 PM
[...]
> +	pf0 =3D to_pci_tsm_pf0(pdev->tsm);
> +	if (!pf0)
> +		return ERR_PTR(-ENXIO);
> +
> +	context =3D kzalloc_obj(*context);
> +	if (!context)
> +		return ERR_PTR(-ENOMEM);
> +
> +	guard(mutex)(&pf0->lock);
> +	pf0->context_users++;
> +	context->pf0 =3D pf0;
> +	context->pdev =3D pci_dev_get(pdev);
> +	INIT_LIST_HEAD(&context->bound_node);
> +	context->dsm_dev =3D pci_dev_get(pf0->base_tsm.pdev);
> +	tsm_device =3D get_device(&pdev->tsm->tsm_dev->dev);

is it redundant? Ideally we just need hold one reference when
initializing the vIOMMU...

btw if it's indeed required, use tsm_get() instead?
