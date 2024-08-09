Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65F811552EB
	for <iommu@lists.linux.dev>; Fri,  9 Aug 2024 08:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723192184; cv=fail; b=ZfmDrQ47VgNrvFdJPffoP81y0wkSiI9xxf+ldjg3O4CAk6Bya0Ki1JJ6pADJqBwEJR7Y0JBlT3r95L9RuUbNJr/1OM8nGRVCMn5xnNClRR+cRl7yXeMuSpUV0PYln0tcGCkekRXy/sJGb/XPCF06AZ1GRuq/InDmYTD6edyEFYM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723192184; c=relaxed/simple;
	bh=3gjEmOmzMGp2PKPcDEwCM9Cwa2t/8NTYJEKGNZZRsnI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=j7Fg/x6yBudZGM5UO4Y96wwcO5FOGRA7Csq1P5P/nIof2CCeDDIRdZvSFfEkPhqyQSFLCK+6yn6S1AWdSNuNbLWvWz/vtqlgCN/C9H5FKMiaIFXnL77i4mMOb/x9aPF/8bxLZGcEy7Yu9+rjbGqqSKbxB3DB8XRPqFaCFb3BweU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BdjRFKGT; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BdjRFKGT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723192180; x=1754728180;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=3gjEmOmzMGp2PKPcDEwCM9Cwa2t/8NTYJEKGNZZRsnI=;
  b=BdjRFKGT0p1kTRb8i4jMnXMtv+CUv43B+W5xBB/2oksbrZ3vP4Jo/OLb
   zMAdvJVsRJWOrhTjILAZS+kDpHme+cO/zeRX94va6ak5X4PvaqRDdku91
   ufVt0O1FHsJMyVPsy0um6wLgQK91lcx+Be8rllIyMxVBKv8XdN2bhsnTL
   4DJ2foh+rYGgi6OBlpnKH9dx9O2vyh8RbPaqL3TlIKJlGMbFijPzv2rDX
   QqkrWTXTMx2u4TivzTruYm1TYEsFPSrjaGS7iNHQWF6WYwwloevjMrbLj
   ODz7/6+FRAymhJrHIUE1J/QFRMI0+KKQkNVqFSosAFsFO9LYHTE494mLS
   g==;
X-CSE-ConnectionGUID: 4yQds2DxSiOY2PeBsjw8XQ==
X-CSE-MsgGUID: Y6p5rY04Tc6Awo4Wtn80OA==
X-IronPort-AV: E=McAfee;i="6700,10204,11158"; a="12930922"
X-IronPort-AV: E=Sophos;i="6.09,275,1716274800"; 
   d="scan'208";a="12930922"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2024 01:29:40 -0700
X-CSE-ConnectionGUID: 28dv0duuS4KvrGPKnOYIzw==
X-CSE-MsgGUID: hKUljPsARO+8NgJKJVNdIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,275,1716274800"; 
   d="scan'208";a="62143224"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Aug 2024 01:29:39 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 9 Aug 2024 01:29:39 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 9 Aug 2024 01:29:38 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 9 Aug 2024 01:29:38 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 9 Aug 2024 01:29:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iujTIEyHQzDcdvgyVL8pyL9GfzAFpNMtaPDWbvKy+ABeSYWeO6p11QV0V+xTtteq7R7yqKcBUzjSa96tpv6AM8Q0WnToWOTuwl8cAxuQPYOeYGOnqfzjp3cO/5JKEzK0f4snck98SFqFr9smjeyJmzhdaD27NLqNOzUoWWgU004cqVUTVkjz3TvpEZUTUU4OW1a26Zb+C7ZjngAwyuaH2vlJ2fqUgEYODLiI0S18kww8cKKs7Vc21YnHTDza/48q8jik5/y5X4ktz1fG1Z6iY0NIIjaoGuFpf8CCVSvBcrWtXUernFRQZxuhyzfM/8yYqO1VruvapuYoDnjHPf/JVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=omGlrUng2L5cnRsyNWwog5dBX0CRAVsmbPJF28jITx8=;
 b=EK7mpPk+G9RIqhTNqYCbFbFSM9Ul3FDHJg+jbAlHNm9TtZhKOijH2aa2R13gs2O9OD+mHP6BnMq5cN89sebsjSB3irmfKJY3YpvEgHNe1f55hllIlLBKba5PL+2kPsnSfO+LUn0uWWMBpoKNAb/rvJj+nGxygyvjH/m4a7/LYPE66dP4ONd9XqIbgPUbs7w8yDqsevhp/8CRSDbIxRF4GulzzFpeHxX4kW6RQqZdwaj4dfw1Uuy1ot5WQukRvSAXsxzu5daF8LreC6sbL3Xj3fHWOBQ4aO5BCPO+4mbq79aw82++AjQ5OhvxbWtszGkYhl2fmxWEswrjGyFhZdnsuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by MW3PR11MB4761.namprd11.prod.outlook.com (2603:10b6:303:53::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.28; Fri, 9 Aug
 2024 08:29:36 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%3]) with mapi id 15.20.7828.023; Fri, 9 Aug 2024
 08:29:35 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, "Will
 Deacon" <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, "Jason
 Gunthorpe" <jgg@ziepe.ca>
CC: "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Jason
 Gunthorpe" <jgg@nvidia.com>
Subject: RE: [PATCH v4 6/7] iommu/vt-d: Add support for static identity domain
Thread-Topic: [PATCH v4 6/7] iommu/vt-d: Add support for static identity
 domain
Thread-Index: AQHa6iErS+XrOqfZj06v0mD/V22fg7Iel+IA
Date: Fri, 9 Aug 2024 08:29:35 +0000
Message-ID: <BN9PR11MB5276BCEC41AA08D80CE985F18CBA2@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20240809055431.36513-1-baolu.lu@linux.intel.com>
 <20240809055431.36513-7-baolu.lu@linux.intel.com>
In-Reply-To: <20240809055431.36513-7-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|MW3PR11MB4761:EE_
x-ms-office365-filtering-correlation-id: ec628035-7b40-44b4-a4a5-08dcb84d66ff
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?+jE5b98a7zUy78CQqtIaGI6A/ldPW8umB658Rd9Dpfczo2x7MfFGSv5B7XLn?=
 =?us-ascii?Q?QvOSPhCuDGoK8CXg4q8n90Gng5Z7o5zWzggN9qU3UJ7nckECnVzzMGDnU3ND?=
 =?us-ascii?Q?FpVkuaesct46WT9jrq4EABp2wWWPmxz38eHL0XpGbM3E4S09vkEX+xulF83C?=
 =?us-ascii?Q?Ydb3X4QOdbZ5N/aF7W9bnG3PQVUYnYChLn8SEdcUaSqBWPvHGZxVqj1Bjm9o?=
 =?us-ascii?Q?q5z7RRZdFxIIBMRzv/ziuYcvy4UUX2u+tOUhEDwpArJL0gIHBdVkeIvfNb5I?=
 =?us-ascii?Q?ThEyRGy4v40gvfPr2Q7l3v1FTXr+xL71/T/gykx06AjFYkwlIsf/3pYlGP90?=
 =?us-ascii?Q?fooEmpwi1yxU1VxxFx0CmQsy+oAlN4cFIVfb84lpN0VNIk8tWV9hhzd9BC40?=
 =?us-ascii?Q?LiYnB6hZsk2Nmak2yddJFhvJVl7yO47qPNYkoK6NBnuWNHw2arVxqDkKQFa5?=
 =?us-ascii?Q?kB/ZpiTYkFlP6OQsWsAloaqFypVuEXstEZZodruONh+6s6K8C4bIlXqBPovm?=
 =?us-ascii?Q?7O2YF1CHxqd0iHqUv7mJ8DMakOucddyyyytNtmhF6J+/RSahItNEZdUeEQHO?=
 =?us-ascii?Q?U853ev//AUXO7s3iHHqUR0Hxxydv/kkDzc/CaHYXkJGANPJfyqZWbN63D0bx?=
 =?us-ascii?Q?IlHMOLJSH0QjZ85lFmc2g52KXV/N/zedA8axrRFaenYHvHp/UuB5GoBAtKvV?=
 =?us-ascii?Q?UtHjBE93SA1EBpc/0cdbAQSe3qSP0nXnfK9nu8O3A2RGFAKp9EsSwpZPDGlP?=
 =?us-ascii?Q?8gR7dGx7hFxVnbxWSi3YY1Dw3BCRxEtiZCjvh34u/Rb962G1c5pVFG4+xt1I?=
 =?us-ascii?Q?l1geoFtkv4BAT+agvmYBZz6bRtYOm77rgy9lZlHQIYOCguoiT1M7GUqFFT1d?=
 =?us-ascii?Q?8Yq35L7DoOYsVzbDQ1W+SgOwuIMnlrTU/NcduK6F6TtJVsjwv8zuQa3F4MeE?=
 =?us-ascii?Q?7Ih5Q6IxagM9cn9q+X/Ja+ULIIe2breVVf3nXROX2ZfxHSigkdzjsdrf9r91?=
 =?us-ascii?Q?/CHP4BA1qFi3bgL6c8kDd6PBwzxjXki2cc/zw1jco+iyqklZJyNAmMeXL/VT?=
 =?us-ascii?Q?eSaf89MG+ynexx3EFevKqHnhF/Yf65nyEfOtdwEdNZr2Ukp++rrNCyh9CDmv?=
 =?us-ascii?Q?f+J2VsZ1B4H/kVbdlLJgDPe1j52CJ9rvKiy8G46GDnR9uXzVscWoDj9qF0Xq?=
 =?us-ascii?Q?sBNG8g6GcmtRiNN5mAMs5nLrKXABC3VjeuQOKZjg/NHdLRAlgVpPApgkTauL?=
 =?us-ascii?Q?jTbnj4Jzd9pn3WjPRV/+RW+Z4Cz6Sg+b6tkUl3ZmfSTfnVmhIO4QgFYwOxHv?=
 =?us-ascii?Q?BzCKUU8KS8E/j9995LoblD0/TtK9y1UEji4O2ulKSmIJnGjwvJKzp5KBi4cJ?=
 =?us-ascii?Q?dP8LnQ3mRCqN7Oc9oLpUrc3DXqm6d/mjpazPl8WJntNwl/xODg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?y7WV4k6YA23eHDZe46/OXIdE+fuNg3yctsAb/7vdqLWkdbBmdfarTEFRloL/?=
 =?us-ascii?Q?76Msci7LiMW70qQp1KfFQt7ZWKNI94wESi1MaYNMZB/ueULl0d5OZD2rZw8X?=
 =?us-ascii?Q?5kvA/BPiMsR+qiEQC2m5kct04O24Pyrk2FUEBC1msZDXVIPGgGCyjXgDyBen?=
 =?us-ascii?Q?xiWPQ83xuoMfc+h068E7QcXdja9dm7VPgot8nFIj2gYZx63vx8sB3HwqtC17?=
 =?us-ascii?Q?FXfB8qqisBLOX9iGLVlIAt4hh8pDI4XLZ55kYEIeGdU/h2uajkUjrtB0CD1L?=
 =?us-ascii?Q?PL0EG16xNA9q98f+J6IgE6j9xs8zjOQbbIc75xeP9TMNxA9wZ1Xrz3QO7sKf?=
 =?us-ascii?Q?za9GgEGeY+dEA7TZzWz9Y4xNJoUwhebhmQdyzXGg68auUAG1XNlHHuEAQkAo?=
 =?us-ascii?Q?J+JaZROvkQnduXWZIHj+Edt3NKNWiP5oEauq7rvijTknXuCnT/6gju+Z4eGV?=
 =?us-ascii?Q?+Nl4DkjSM2iAwbiszc96E9IOv8QKMtPxdW1/SeWvtidEXM0N7DROIZ/YiUN6?=
 =?us-ascii?Q?FA9GWTibR7c1TW2fxF/a8ecyYd0RJOUY9msX+he5e8eBP58yTYXVm7pOqcyz?=
 =?us-ascii?Q?L2uZY+VtKyEjEL6CtEezCYNyf81cgKNxfVDLUdmd0yjFVMuEeGhD7Rbas6l0?=
 =?us-ascii?Q?py6AaaTQTP3Etcf+WwWddMD4cfK+zDQWfV+LSsZTW8KoFl0HJGMqvxd5eIt9?=
 =?us-ascii?Q?3ij6sLc16uZsWCdNx6I15pp9Lcxd/fpWJub3JJP+ZY7EvvQARvCC9yVNkg/w?=
 =?us-ascii?Q?TEbsNPtWZ1QC1VjK8d6F7cKMSNKUZbQ96AAEunNrKYEALPa1V6S535rAgPxB?=
 =?us-ascii?Q?aMyOc5PptkBMFnUvKpwRvZDjE0bJpaDz3jb8nka6A79fHju3ZEISjd8/03+w?=
 =?us-ascii?Q?etOmhEvC3fy3wOKORD1o4S90eyN0Uz88eGKFYaM6tM7+Ucpb0CEvZ6v9ZelY?=
 =?us-ascii?Q?wvj0WK5nZM0HtJDx5bMMFGQV95XK5OwLcDtooEAjZgrlPZiuMyHZXPrT1bmw?=
 =?us-ascii?Q?hlNg+qctq1P4hkOcwdaxPViE3573nrSFAYssZs93LV/1nDrdftxfeqIkSahx?=
 =?us-ascii?Q?uzO7MFREHQGfvKmqKubDp3LBUt94TzD2ukM6eDd1Cc6QTjCfTN1R6lcuBNjm?=
 =?us-ascii?Q?+M7WIg2U4QdGBOf7iM+FWsPtFLLwUb9/7mi9qChqbIwYrL676yfzaOhrKRjk?=
 =?us-ascii?Q?md5S2RjTcu2GWUSC2Cod5okSoOvcQsDfTLO2H2lck4XNgzkCRTzq6pbWSVNy?=
 =?us-ascii?Q?JpwXTAs9yAlOlV7MyPelDNosZtnBsjkjFMa05bhWjEbZv+XipzWh+Q8o7ziv?=
 =?us-ascii?Q?PpaR48aRbv7Mh2xjnAHwLcQSF5V91W8vKvjTgmis1Agmcx3FeNuG1yfqn8BC?=
 =?us-ascii?Q?z/GxWSHj3RnP/HMOpCOWTt9wFcQChoU2SJo9FEWQfB+F9ifUVQaoqoJHD0Fl?=
 =?us-ascii?Q?pSkmq0A6srRvXdIqfzhV4a6hJUu3Ut/02V4n+X8MHMyl4smIar4sUdnBdHnd?=
 =?us-ascii?Q?cPwIRGsRZnlj85x64R16R/HrR8oqPYSNBCO0jSoe7h0vA5PyntItGED8X73h?=
 =?us-ascii?Q?+hTb8GkvLTVeokRJnrbAs9p1vTj/wy5HaiaOMuJq?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ec628035-7b40-44b4-a4a5-08dcb84d66ff
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2024 08:29:35.9685
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /qFiL3/9/stRTr3WGFjQlyR9AdSIDaozosaqzyKLYNTRZgUMPm7UXCfwoPGJYtJrrfeMg4FmaQXmOXYjPvCkiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4761
X-OriginatorOrg: intel.com

> From: Lu Baolu <baolu.lu@linux.intel.com>
> Sent: Friday, August 9, 2024 1:55 PM
>=20
> +static int context_setup_pass_through(struct device *dev, u8 bus, u8 dev=
fn)
> +{
> +	struct device_domain_info *info =3D dev_iommu_priv_get(dev);
> +	struct intel_iommu *iommu =3D info->iommu;
> +	struct context_entry *context;
> +
> +	spin_lock(&iommu->lock);
> +	context =3D iommu_context_addr(iommu, bus, devfn, 1);
> +	if (!context) {
> +		spin_unlock(&iommu->lock);
> +		return -ENOMEM;
> +	}
> +
> +	if (context_present(context) && !context_copied(iommu, bus, devfn))
> {
> +		spin_unlock(&iommu->lock);
> +		return 0;
> +	}

Is it a valid case to setup passthrough on a present entry?
