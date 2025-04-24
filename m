Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FFC21F4617
	for <iommu@lists.linux.dev>; Thu, 24 Apr 2025 07:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745480814; cv=fail; b=ZDeF9YbwyS3rf+aNBuFYgPBfDiBRjxlC9TbW+i3qeuEiZpevcFifXZxcLy2pkTTsOnzj8lzN/8Z9mlijzQlprgxyW2EPSGUfHLdd8zHk0hNk/pdzPCKoPwuRnpdJU0ozkOpoNsZO+jDbnJgSwQBw/MOSX6WY+hwlSNP8HuPudnw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745480814; c=relaxed/simple;
	bh=atjJq24rL9uT05IYlC/HMo9bPrpC16l/xV+0XUhU9jc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=obj6rScL7ECPay7j8vOLgMbTBnhc9ScbMkxxuuRY4MFfbgFFhYi+3OwIUsCw8a+yiS+6Nnbi8AdnIOxwJkTGSUP+F/m5ba4ucmHAwn6OI9McYki9PIzk4cmeEQiDHc7FcPakbU8yURg2qY8QxIlYlU6ue/thS3sPpvpbgKmhxVk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I/ZWpZcU; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I/ZWpZcU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745480813; x=1777016813;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=atjJq24rL9uT05IYlC/HMo9bPrpC16l/xV+0XUhU9jc=;
  b=I/ZWpZcU2WkDPsOEh72TrotlTNt2kLOQwRn2MJXWg61C7egpwB3KIaSB
   qG5IubszdLnEv1PTkdgMiUsNcsF897LcoBqht/FAMLL1uR8xgGQdRP7zc
   /mtL9aSZ10mbIOntWKT9850K5xUE+8NFGagPr4WI1loDhRd6dSvdY5owU
   jzE5zzKCglPhiVLNXP2L/oLhc+DD+KWKsSkQw7zpKa2k31c3kN+gCLEIy
   S2H+glU1A8EWn/DwVMkb3DAV3jNw+6/vrkFxZ1/55Y4FXPWEaWmC8GUXT
   0Y4piG4DjHe0r48FQtNQ1P3u+aXrExbkTDFKoRb8vhLxfipkXBDfTArzZ
   Q==;
X-CSE-ConnectionGUID: xKqfpwnxQoenVbi6Y1Mr3A==
X-CSE-MsgGUID: ZdF/CIveRPqIyj2Ut1lmtg==
X-IronPort-AV: E=McAfee;i="6700,10204,11412"; a="69585438"
X-IronPort-AV: E=Sophos;i="6.15,235,1739865600"; 
   d="scan'208";a="69585438"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2025 00:46:52 -0700
X-CSE-ConnectionGUID: cPlsM7AVRhaq7fJM5z76iQ==
X-CSE-MsgGUID: EgVa0LLsSYO9+6p8s6eORw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,235,1739865600"; 
   d="scan'208";a="132444662"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2025 00:46:52 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 24 Apr 2025 00:46:51 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 24 Apr 2025 00:46:51 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.170)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 24 Apr 2025 00:46:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UIM4AyN+0ihDgiAyf8Shy2OXH3K6VAhx5yEchsI79ASN6gBoPTYM1BnFVtS1ZTUBSpBSucUkdFXDj3WHRtTvbsaLLyEr+0rs3q+8k+kR1vHVRwyPlVJS7WKfe4PL5Z7K3aKMZMpotdiejVrWLnT3Ky5oFxYEEIuWaV4witumfhKNvsnBzfm7m4GWrDt4TflvZUY6+C01gAvuVHBJ5dY2cK9jc7IrLT3REi7Ww421V4bA/FmrYC+KFE75EIcfAWZUHcy5zxXsPSeecxCo+lGmTM5hC/QI8lt1czvN87M6ryBKXIk/ELhoo3wYjZtalgoDz3/oTxXghm9e8ICBxJtBZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1FMd9Q8hRvVs4Dl8pAvRMh89T+gfLJ0gptpumhO4e0c=;
 b=wvr2TNw0YajvjXsPQLwPSsb7ji37eSWh+LtPgrNThgTtaUIx6kS9Nw8cs/MbcaMr9OpuHvu/eMxeZSMBkQ9Ov3D4Ppt2FjjzFXaWXEUg5KGrnPuN2oMkOLND8bvfy508EscIzQPF6qONiA/NZeOuuIqsCTLyiIhzVrFXFX/vvhBpu4/BdGv+d4QffCqu4dnXGK27d0aCPE13c/gFnnkiCw8ZyCWX/xPbW8zau6RzMG93UrDF8LNJg4x2sXNmuc95DRGXKJTtbLsfIFpsASKJD+RMg3oxWs52ZtrlJ/amR1V6+B4GAWEfKuyfCwg69A6Bm0jPpYYjAZbAPHGtaEIpPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by PH7PR11MB6772.namprd11.prod.outlook.com (2603:10b6:510:1b6::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.23; Thu, 24 Apr
 2025 07:46:21 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%6]) with mapi id 15.20.8678.021; Thu, 24 Apr 2025
 07:46:21 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, "Will
 Deacon" <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, "Jason
 Gunthorpe" <jgg@ziepe.ca>
CC: "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 3/3] iommu/vt-d: Simplify domain_attach_iommu()
Thread-Topic: [PATCH 3/3] iommu/vt-d: Simplify domain_attach_iommu()
Thread-Index: AQHbs/032+BId7gpGEaFMDyqoNne3LOyb7UA
Date: Thu, 24 Apr 2025 07:46:20 +0000
Message-ID: <BN9PR11MB527619613B8615A94A01FF598C852@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20250423031020.2189546-1-baolu.lu@linux.intel.com>
 <20250423031020.2189546-4-baolu.lu@linux.intel.com>
In-Reply-To: <20250423031020.2189546-4-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|PH7PR11MB6772:EE_
x-ms-office365-filtering-correlation-id: f52aca72-e8e9-4ce9-8c2b-08dd83041ad8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?VjAApa/xrGgVLfcXcUz1Fn34E7+VnQI3aCPsuZoTZaulDOcUnVMi/QrigtjZ?=
 =?us-ascii?Q?/jCXsm2mMbzrs1qZG0jBTIe0SbQnbR0GqWQ1oD8dOLdSWyEcX7vDG1taTRpE?=
 =?us-ascii?Q?OiJXxG7NS3RPL8cxogNvp6yJUQQ20rObra/bpcWpaOuIc1sE5sla0qHh9dDy?=
 =?us-ascii?Q?j1s+Hq4tBELZhiX87JY61ptDPqj/PLFahsmBmFOILJDFIoke3tlUsZO/MSgN?=
 =?us-ascii?Q?hj8PmjZtNO309Q13bl7/W/SjndfolnOnLGsRWExoMfYD/AY1gb0tr6dtyiN4?=
 =?us-ascii?Q?Bgd7zcU4ktvnl4FmFIuHhB+28uxCg/cQb1DPEFJapJu9gC6Koq2eIVB2o2jK?=
 =?us-ascii?Q?WEMKSlFYWyXLAcfzMLm9OYVyg1LYJrdAqbsL3iXrsCgPlp7IL/8njiegVLFE?=
 =?us-ascii?Q?sPzfL8oDzVC8ZwenuEW+zMuNhzo2RNbWpg4yldzW6iK4kI/Fy/xRklZP6u/3?=
 =?us-ascii?Q?e3d3hgzrSjGH7aZqaNLHygmoBP2XWDFJWMPKfOqdSae9qWcE7AYLm/iCE2ar?=
 =?us-ascii?Q?Lc31vrx7MvVNVJBFCAbKPcvYzxDDrA+nQYYtxGByOky4Qp8RL7NXpkjN+OJM?=
 =?us-ascii?Q?wsrB/qayQjr2PNV7UbGHL9MQfnpOGtVX4GRHxFBeixLhqohEEiQf9B+KMFI9?=
 =?us-ascii?Q?4bXxPG476eJpcjnHMpndTCanX1ulOMwye1akFmzoRth+NTC2qDnkWlS0y4wG?=
 =?us-ascii?Q?jy4fncmi3bzJtGOiAEHcNlmneX4EPlPnuiGIh/yATWTrnK2pteG4DQhDEE+n?=
 =?us-ascii?Q?juDyfq8aVV/Pggc7BNw8NzqxatDz0hAzIzpVj5Z1bWsHWxdz1O7VqWRNeKWf?=
 =?us-ascii?Q?8Tbez2LaHrdaUzSkFYadGAJjvBpNqUlfM5iYjo6p2AqWS0JmstzQhfsfkQUy?=
 =?us-ascii?Q?DgCkE2tMeAmx8VEjgA3hGoJIvrb0be6rAjyesIj5rKgCSysHTt120HyWbhgJ?=
 =?us-ascii?Q?IsxFh2pCw7n31HsqJMIKLg6Uf6r8HqcACTZaVRt3KnksSGscYOJelDMoj3ff?=
 =?us-ascii?Q?+KL/diPObUVLwmGDHK3tHEbwNfSOkq87ZiFycyGr4qFcVj0vDN5TnOjJn+/1?=
 =?us-ascii?Q?MTKHlp3TgHCPJ1Xqvkr/t9DvY5pCSqDl8LzYtAm/utcBF4fmgxfzelD1HkZS?=
 =?us-ascii?Q?P1eguYLS2xKxdbrUAsuwVm8C2eYhhH34VHyZ1alh2AX+hY+s9YkCkhAo95a4?=
 =?us-ascii?Q?LguotiKoGSvoN1Yq8ryCMTpleQP0H5KxUl42jOwc5PhC/xnXRRQmUZQDojGL?=
 =?us-ascii?Q?qeyq15T6FFSJdRzui2OoWfrF+Vzx/20ZU/8N+hgM7QrGZSHTDw/nYC3uaYEC?=
 =?us-ascii?Q?f/qXBpdMDxiEymPDmkWqedXdZMvOyyxwipEnjBb59Y2nmq5crEUO+V1FNArJ?=
 =?us-ascii?Q?JRQsbEI6Een974KzgWYbUs60+kNCNsKNRUCY6sQuEqY/i1R1d56FpxVSFB49?=
 =?us-ascii?Q?IEt40DICF1xYF/5h8b54a+I2BDIoV5PxbOulhb0Uxmbykn0ZhIIL7Q=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?bdUwV5XJjm7MWg8osWwhfuiOhoulHMJ7emJWfGKfSCicazEG3b0xB100hJKZ?=
 =?us-ascii?Q?enXhrwSdrczcEJV2iqEV3v8eRM3l06GWeHeqbovST2gTtQdRyEMdjMaTs5at?=
 =?us-ascii?Q?854iJg5bTatxnlXqA2o4DtG3MOfKfwUHSFKKRkwCnnUE/2du8YiKsiUyKjcb?=
 =?us-ascii?Q?tkJq/HDl+iCacgdK4r7iKifQcZxEhkbDyHeFrTwLOV6U5YSKnkkOSGc80lfQ?=
 =?us-ascii?Q?YL3E6ozLXB6FJdqrnV9wvYYRX1vo5dtVZLZUXNeyeYBC7/Fq83JQMDKGeIPK?=
 =?us-ascii?Q?zn///IST5yLzVdUWat/2OU8WdM8DahybMDfkWzZlbuGS9FcRwi+1nHHkV2X4?=
 =?us-ascii?Q?STCEm29Lq9jHlpnrWJsFvOXoByP9jluyMkjwQSA2NDRybbWWGsH3orHD9usP?=
 =?us-ascii?Q?kp4oTCi736n7MlR7LINQxQ8i/uhSAgWOD+ChRKbnt6IHMJlN9OcXQZyNJeJl?=
 =?us-ascii?Q?VhmSPz2vWvpYcXSzOgB2PJf6dOwJy+KGsO+co8oGQaIAJn8BrxbciZxVPOP3?=
 =?us-ascii?Q?1QCRC8G9SB+3YYPiZwEUNQjhwOWG6JR6Z5dGBFKnudqa0jBkIkjJQ9xqFVdh?=
 =?us-ascii?Q?1ItmNtCLaFkIU3XjxtXe3WD4vqSC9ClWpflTxhfY8u6hIRqg/a9ZpAl3JdDh?=
 =?us-ascii?Q?KHyIpTxBtoP636JPXX0Pw3p8BmXkrUKcbindmFSxTE2ZmvPcpo67Pwbs6wv+?=
 =?us-ascii?Q?rBHRCv1qSFp09HXyaCqHiKQoGAMmHx/gVVWTyO0uMLCE3FGJ9HLjH6Yr/9l/?=
 =?us-ascii?Q?lD82oYMPrQYnctyzru2UxMUeYPZVPWsWFbWHQz+0LySEZ87ISfWUUKd2XV0I?=
 =?us-ascii?Q?IIr9omftcaLaSlaEqhsg5IVjyk2LKYS0A/dxfzLr43M/Fo5btWyU4Km6dm2M?=
 =?us-ascii?Q?M0TqxUt33Z66BAPBQT+T/J/B8v02AK7R2RQqq8EU/0u4DaJ6wEbibwQbWov+?=
 =?us-ascii?Q?zIT9AOvQAbnW7i9vmPPQ7hx5a+UuVRQhZmkWUJ++vnZXDUVHTuRxkMa4h5BQ?=
 =?us-ascii?Q?e9T0BCr6mDQkufCBRRO40wPgzrAo1wGdVCpTdcgZ2OLkiOXND3wR8A7QdlSb?=
 =?us-ascii?Q?kgDH0Lm9Gt4sGrWpPtpYgVy6cP57dvyvt+6uyTE9/pBgQihxPXyaa3s5gOia?=
 =?us-ascii?Q?hKGYYrgMkPdG7nrKwodznXyRb9ln08+wCX7zraW5pgf50CM/pI5V+Acrzm9F?=
 =?us-ascii?Q?wrJkPdauQTpfkaHTUBQtPmluXogkxpBfwAo7UsdOLOl3nClBcWKmf9f/+wP7?=
 =?us-ascii?Q?rIOwHBOAfzCuw7sWDqhMavaDfeblhSCeDfKjUZSY704ZI23rvb2JZ6l08pVt?=
 =?us-ascii?Q?LpVopXPX+teOaB8frgsYBAGCP+2n1ssaXRDyjRwCVPOPOx8hpR/qqRFTGcuW?=
 =?us-ascii?Q?u9vE9Lmq9WEv5zFqY6fftVpZON6tWkGVT1gkY3854w/WyNatesJTlhn91PFy?=
 =?us-ascii?Q?G5Zv0GJReMkDQMBWIW18xN2EQI6C+ZvgN1Dg1lWUMexnBZTGmjt+qZJh4i6K?=
 =?us-ascii?Q?3egn1BPVYFWMsww1SBTEFC7lfufmtD9k533hD2zhIjTKFu9bvAk3KitkyC4E?=
 =?us-ascii?Q?BsN4iVZcDlbiHHgZU7b4p4bB16nyNkvPy3pY5ioI?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f52aca72-e8e9-4ce9-8c2b-08dd83041ad8
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2025 07:46:20.9794
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DBm197CKPUTTkRfyk8rFYMmq6RpxLbl/+7gkQzX7Y3nYTusALPXdtlGFqCM0xBo9vGfaTc+dWRG4uN4YC4eHAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6772
X-OriginatorOrg: intel.com

> From: Lu Baolu <baolu.lu@linux.intel.com>
> Sent: Wednesday, April 23, 2025 11:10 AM
>=20
>  	num =3D ida_alloc_range(&iommu->domain_ida, FLPT_DEFAULT_DID +
> 1,
>  			      cap_ndoms(iommu->cap) - 1, GFP_KERNEL);
> -	if (num < 0) {
> -		pr_err("%s: No free domain ids\n", iommu->name);

this error message could be kept.

> -		goto err_unlock;
> -	}
> +	if (num < 0)
> +		return num;
>=20
>  	info->refcnt	=3D 1;
>  	info->did	=3D num;
>  	info->iommu	=3D iommu;
> -	curr =3D xa_cmpxchg(&domain->iommu_array, iommu->seq_id,
> -			  NULL, info, GFP_KERNEL);
> -	if (curr) {
> -		ret =3D xa_err(curr) ? : -EBUSY;
> -		goto err_clear;
> -	}
>=20
> -	return 0;
> -
> -err_clear:
> -	ida_free(&iommu->domain_ida, info->did);
> -err_unlock:
> -	kfree(info);
> -	return ret;
> +	return xa_err(xa_store(&domain->iommu_array, iommu->seq_id,
> +			       no_free_ptr(info), GFP_KERNEL));
>  }

no_free_ptr() should be used before successful return. Here xa_store()
could return error but at that point no auto free as no_free_ptr() already
changes 'info' to NULL. then memory leak.
