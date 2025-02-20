Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4942D1EA7D3
	for <iommu@lists.linux.dev>; Thu, 20 Feb 2025 08:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740040307; cv=fail; b=ZXBY8jx1+bKb2ZHc5O08dIoH1QSaaFMRxPa/oxJMwrcjfdD06TFLH81dFkvVmGdSb22yevI2xSPYu2W7CwemehhMzVuTUDE3wSfcswON4oMsS+0CytRHOpnkfWU/w4j1wU5KkA/B5VBAqoH/y65ZEqmduRavyIZYvLVDv0XoEjA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740040307; c=relaxed/simple;
	bh=MIYq3FOq4Td+NMV7B/wfnC6kWI4UbDhc7wdtW4/CL3c=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=k/qKOXLKlhb6lVspKKslqn8eDOHq2QFrYelh4YVDfhXUR2cptd7NRavWayzPEOe2eSnSLDAwZLD+hjF2Ad3d0h/pbvTbwjyXvhm4nIIoGfoMdyKmNI4JPkwEnFKGjRXGsOgBSJHjQl/3f6xm8+xbPOA0I6v7pP0OVskpQRTkDZY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c3hwdd1G; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c3hwdd1G"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740040306; x=1771576306;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=MIYq3FOq4Td+NMV7B/wfnC6kWI4UbDhc7wdtW4/CL3c=;
  b=c3hwdd1G1Iw4teJHjNRIEZNsYm5JuuDiLZs/Yx4mm1L03ZYEBkGfCWDr
   GQpzYW5vlMPzoJZEFRvIjCdAViasyTkyI+eLm9Dy8yboBfTZMnNI5hXa3
   RH4DdJqjXP9tey9fP9yR1m103jFvHyNUYngrRVISMavHmFrcWa14Y2f7V
   Er28F5u2b4xTvAcOs64prIEirfBRjhx9SfCDCdGPRxGf8F7xeY08ZQTTF
   vCjqsrQyuIaYeV/TwfT4lBvbv/grBfO9RPmcg2UZTMF+uctOgjMDF1xM8
   2N+rKONIq8OxImce9HpjNlzmHy72viseit6FOQ3mEsiY7o7KF4zjv11pc
   A==;
X-CSE-ConnectionGUID: lHH0nzSiTwukFlaWmrH8Pw==
X-CSE-MsgGUID: J0c5sZZSTUu8cPM6nNQGkQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11350"; a="44457711"
X-IronPort-AV: E=Sophos;i="6.13,301,1732608000"; 
   d="scan'208";a="44457711"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2025 00:31:45 -0800
X-CSE-ConnectionGUID: dNkfUhbqRIaGCpAeqV7X8w==
X-CSE-MsgGUID: 4SgdXjBuS6mZSLJ9x586Lw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,301,1732608000"; 
   d="scan'208";a="119952842"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Feb 2025 00:31:45 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 20 Feb 2025 00:31:45 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 20 Feb 2025 00:31:45 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.170)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 20 Feb 2025 00:31:45 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qOivibL95fdR5p9WvHwyg4gsMLUmi/8GCG2V2ozn1f1/EbtDSb8oe6f4APJZzAMNds7psc59M79kX4m2UyqG3cZFal7LJYne1ENssE+6pIf9l761xiu5+vfusTbl0JWwo3VlpebYQxhYFBmhGCc3aEcyV73o/wWqkdY09lvjRYIvL8hV7DwFOXEom8xBJUWj/L1IKZHu81YBTMZXC44EzsVAU5AAro/e1rASm+nlc9ocCTUsPKIBs8tK6BRHiLxi6rMIcPBKHQE02GRr+8oLu2Jx503d6/779uvhvBu2P/uskG4Dxyloir0wkhldKTy/4OQwO086CZ5KmjMsGlfKWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=paQfWhLWGPEOpSyd3psXtfieTyu5/YJM8BaFosFc0MM=;
 b=AQVnMG+PHbfjwzQU55ES0PdwJC0VDqeJZt4DDyRMTlhUxY0V2GIsL7tIUNuBMp24yyeyvR6Z8wX31Li0NaswEDt+GkvapDBfSxRWXedxYAJtB/SlGkpoRhvBmyJMu4/S4yXESF41M8maCT+xHC2h16Tpc9XI2vvrecGK/PxB/mrvLc7DbERwm0dBzBykc7t8mfO4HDT1Kw5jJG2rnUWT1iWX2Nyfj7NlsQFC3ohr5l+eLQ2i5tCD0HdZuKoJyizmkOXK6Iql4mSL75bdVd7OfOdWcKQvNWvwbm7W/+fkrjPRa3XyuZqFpCf7ArKMxGkD6LZCo9oh4DsyUacegNDShQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by DS0PR11MB7802.namprd11.prod.outlook.com (2603:10b6:8:de::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.14; Thu, 20 Feb
 2025 08:31:02 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%6]) with mapi id 15.20.8466.016; Thu, 20 Feb 2025
 08:31:02 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>, "Liu, Yi L" <yi.l.liu@intel.com>
CC: "joro@8bytes.org" <joro@8bytes.org>, "baolu.lu@linux.intel.com"
	<baolu.lu@linux.intel.com>, "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>, "nicolinc@nvidia.com"
	<nicolinc@nvidia.com>, "will@kernel.org" <will@kernel.org>
Subject: RE: [PATCH 4/5] iommu: Swap the order of setting group->pasid_array
 and calling attach op of iommu drivers
Thread-Topic: [PATCH 4/5] iommu: Swap the order of setting group->pasid_array
 and calling attach op of iommu drivers
Thread-Index: AQHbfRQws/elE+KnI0CWLOYk3yRXi7NNfBYAgAJtKLA=
Date: Thu, 20 Feb 2025 08:31:02 +0000
Message-ID: <BN9PR11MB5276C3C4C55A11F76E28E8788CC42@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20250212060540.261436-1-yi.l.liu@intel.com>
 <20250212060540.261436-5-yi.l.liu@intel.com>
 <20250218192718.GE4183890@nvidia.com>
In-Reply-To: <20250218192718.GE4183890@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|DS0PR11MB7802:EE_
x-ms-office365-filtering-correlation-id: 19ac50c3-7b62-4a65-8b05-08dd5188e8ef
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?pS+l4XtW9K5gGSZeMjQ/dQrdHBA5K1soekLin7Xc4x3NIc3uGxUdAOvMkyuV?=
 =?us-ascii?Q?VnqWnRS0vKmxrBBkM6mX4AxCDk5omGxFszGN13bJP99Z6+d7MmF1QV9hSI3K?=
 =?us-ascii?Q?ewRcOagFVZ7mZQXHSOOcNvIl6IvBIUsjhDj51JGUiJ8BKoUOfm6RVnCeGiat?=
 =?us-ascii?Q?ZbhO7u3o3Bwp3VqOJfUrp0fKE04PHVMToKWezj2Ky1Vf48lf2sIql+mFmtrP?=
 =?us-ascii?Q?rUKI1E25OD7t4kz3OfnoZJ8uSNBzImRi5CRPyBt6mMihlHF8r+U69dGPHSSI?=
 =?us-ascii?Q?i+raDd078cxjtazLi91a4cLXOB5k1Lb19zcJKCZValWYxngZaZpMggxKJ1ax?=
 =?us-ascii?Q?YiPac5XCgybtaaOGrFNnEnZZRkv9WYTbXbY/wUCH077FXV30+fUonrbp4kfb?=
 =?us-ascii?Q?1mC9eu42TsBVwXyOjx5U0/qFECAMNbpb65afmCVU9JBveaVO4wZrHSB9ANjz?=
 =?us-ascii?Q?Shd4QjwEXcrUVoaCsVsXYwdAcwO+7j75KDCMZOy+w69pNu4x6CcF09Riy/jE?=
 =?us-ascii?Q?0y4y7NdPdzuLM7DT+mOOzi8LgRZBL7l7L8hDrDPgthKOm39BZ2w/Ob9bu7mM?=
 =?us-ascii?Q?usgNveyzWYnkTO2MrvCv6imVNTOSQKSJYAVwly0PPfHx/+qL4jX45yxNa0jh?=
 =?us-ascii?Q?mmw4+gNK6yAr5tqSsHCP3rBb5P4a+cTDc8GO6bFduZMAjIdL1SPuPG4Gyxox?=
 =?us-ascii?Q?CT94Ps38EfiV9JIpgnE4Do/BvwEVW1Bzy354+YRSubiUMcz8AJTYDoA0RqU1?=
 =?us-ascii?Q?GrbtTFEkn/QzfBwJnVv1oLgfpau9OdlrsFDYzoyY4Wa5H01i8zBSN4HmKXzy?=
 =?us-ascii?Q?qsvun3KE4wB5iA0pKWwc97GsQUGHPOkqFddQbwuRnb+F552jAzwWQLODPe3e?=
 =?us-ascii?Q?7rTGI18rLyKfoZsPbaGhygqLORbePGFW/jqFUqZD8rrucxQPA0+m1lyRiyMb?=
 =?us-ascii?Q?kOWNxmFDfBP4cd88bLQJC1oksQVglnH66bWBE+HuUKwXn4R1k+FESzVWh8zM?=
 =?us-ascii?Q?7TuoWVJhpuDlaYaHkhtuJWbbtuzOCh7UZA1K70pu4DkfIm0Zzk7WpBm/pMxb?=
 =?us-ascii?Q?NuO6JLFd8RW7ZiFh/3FuKnVmyJJVaQKGSOs/FxLHWekTiJib0PNK/yh5ozlA?=
 =?us-ascii?Q?vopJyhA6oKGMD7NNRE0belT5fsRHFi8q3DU4z9W45gVowkZSNELUvLf9HstX?=
 =?us-ascii?Q?GFtVy7NPrLVeUzaABmwNbipg9yyVROjaSprP8uR93bL+uGDNkT+kfqzKSLCi?=
 =?us-ascii?Q?f5LtoAQzQ1EIFyW9p3gRuRuFDOVMc6mZevUdGFWtkqcIMuBzA0LK+iUmAn/w?=
 =?us-ascii?Q?fFej4paWx/6qFsX8zpabCRPzsdnbaZHJR1MsvmVb8GI1Qiav4fVyzWr67xse?=
 =?us-ascii?Q?Eq4gekZRJdfxwGZ1hHkYujAkVGRKXa/Sx2qhxmSZxOPyzZH32OoQngL5CNv7?=
 =?us-ascii?Q?NH9lol7rJIP14YCYGtEAD9Q/K+cNRcn1?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?vfTPTLprz9XOGsGLF24EJimz97XBr8h7qcdvjp2oHKzyLRqjeXOZgNAozcN1?=
 =?us-ascii?Q?DWEAJg3sH4tMavwmn/oj+7ffpQyYwaW/YABTTIGFpq3A+rf4v0zEFePHiaN9?=
 =?us-ascii?Q?Hf85ru4VRz+Q9xRuuwuJwmqDGqU+3ERRp80S+hjZqzQE48fsLLonQbtVjbgs?=
 =?us-ascii?Q?PpntpqH6T+QtvISTD0ix43QdhbMoNhH2pAa3HrDtcpeFdejI/GcOUvsl/imc?=
 =?us-ascii?Q?2x4xb/7SVPhJtEQ9b8P2389lyOxGNUtsq+WUcDtKzwb5y5RkRTDnPAVV6/Km?=
 =?us-ascii?Q?YzqV9wwN8EtOgdOLgfV97oI6f3qtdZ0ILJWjVXlbHnRnIbflnlslYYakWPfc?=
 =?us-ascii?Q?60xUs/8vfVaIX5IAVRWXx3l1wWjyF7YjkFDSKf0GwWaC+OYtH/AGd3sJvqBp?=
 =?us-ascii?Q?VUO0Rrjwr/bf2bTRHMuvprEIWMqTUnR0OMs6fkzsKQCemgdhLpim6Bq4hoA0?=
 =?us-ascii?Q?yKYmlxlY8Wm3IrHXg/SoFl9XVNNTVDB2dnOspXgx5fx/m2RJuXJRgUzVmGax?=
 =?us-ascii?Q?J+aICliSieEvUlUN2pwP0q3Qk/Ty7GmrthkJ6MVSLWjWYfiq6+SVaoViwD4E?=
 =?us-ascii?Q?E0AfDclCFUnok46N3venM5z4yipSYYCebTlhc9PKfXaQ4DZUTFF19s5KpfXx?=
 =?us-ascii?Q?YO2/rINP/HZFqQ5NC6e8g838JJN17IVE8ccDpNG69jn2lhnPJWuK/oI4chM9?=
 =?us-ascii?Q?Qu9A3OLZmMsqC+jYDdSmheSEr56wxAdNyo3yomSj0croLar4fq/XXNfGWQ3p?=
 =?us-ascii?Q?DOTqAGQ2zPvcrPgznqmB8vRldD987AjOBygc1KOc4gyvWVmDDppzfWJZIGwc?=
 =?us-ascii?Q?cqsPASjIHXYFTBbx2sylGcEU3DXcPoVci/xCEq999P968b51EqkgQ0LaGuZ3?=
 =?us-ascii?Q?K+lQJglpQ0HbXslkPjrnmC73kOOm9iPjGmVBoA41j4i2EqGALZkoYvqmN53k?=
 =?us-ascii?Q?Wjk2SFm7+yIMJq6x8E+0hRgF1kz8Yk8zslLOAnCPRa+2+vKfr1Jn1OEJv7PD?=
 =?us-ascii?Q?WUggv11vlwarKOBaVuCJMUflc+aX5eVk4dgVHfL3gQoZZAf3vG9V+YJJZi0P?=
 =?us-ascii?Q?yRqbkGOYs4zWQPHz/ehd3pfDcAkZObawivR4Jv/NWXBdT6O9ESvzl3PkjzOD?=
 =?us-ascii?Q?2kQWwKsDefQMVLlQStNEH9EhrjRVmhQwowDOwTzjGrwT7imzjQuJwZeb2Hck?=
 =?us-ascii?Q?hdxm6TrzAOdew3/w5lA05I08FnNErZ4i2P6mqggCvrjt+ipO9g19UTorQRF4?=
 =?us-ascii?Q?MSHlnnBthZCCsaLUY6yYjj8i8Ld+i3I/BLdVbOxOddcH0wIBgwbE9xxWvcwr?=
 =?us-ascii?Q?qw+bqtmxnxBmPp2y45kA4bGDnXN6R7yvYWF5wo0cZ5qdJxosBlVoB3Onfres?=
 =?us-ascii?Q?trR+t+txTdzR9bwjNt9Iv7RxVHMpDWsdZk/RitVnk93YHwdA5+hpkIROQzKx?=
 =?us-ascii?Q?Hum7DppIJYvmnd5wjP3m8UvAGfJHnFGB5Iv1qK6xe8U1/IOeMzjmxOw4pYb8?=
 =?us-ascii?Q?aJnDJEK6q6nFaUF9SloPsr01H58x6Oe3Ps+A2CRVot6XePnwxwAyn/6XGpM/?=
 =?us-ascii?Q?MGN8aTZUrc3Sn5pqbLbmchIZqUtLmVUl4La9ETY1?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 19ac50c3-7b62-4a65-8b05-08dd5188e8ef
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2025 08:31:02.1398
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gkcpP/KHVBY78eVeYnpEr1RrYdxjM6BvsHQvogQBfuPUefB6kZDONTUogPjd+jjFC3Ogr/OQIYgQxtByJCP83Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7802
X-OriginatorOrg: intel.com

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Wednesday, February 19, 2025 3:27 AM
>=20
> On Tue, Feb 11, 2025 at 10:05:39PM -0800, Yi Liu wrote:
> > The current implementation stores group->pasid_array before the
> underlying
> > iommu driver has successfully set the new domain. This can lead to issu=
es
> > where PRIs are received on the new domain before the attach operation i=
s
> > completed. This patch swaps the order of operations to ensure that the
> > domain is set in the iommu driver before updating group->pasid_array.
>=20
> I think I would drop this note in a comment since it is subtle and
> important..
>=20
> > -	ret =3D xa_insert(&group->pasid_array, pasid, pasid_entry,
> GFP_KERNEL);
> > -	if (ret)
> > +	if (xa_load(&group->pasid_array, pasid)) {
> > +		ret =3D -EBUSY;
> >  		goto out_unlock;
> > +	}
>=20
> Let's write it like this:
>=20
> 	ret =3D xa_insert(&group->pasid_array, pasid, XA_ZERO_ENTRY,
> GFP_KERNEL);
> 	if (ret)
> 		goto out_unlock;
>=20
> 	ret =3D __iommu_set_group_pasid(domain, group, pasid);
> 	if (ret) {
> 		xa_release(&group->pasid_array, pasid);
> 		goto out_unlock;
> 	}
>=20
> 	/*
> 	 * The xa_insert() above reserved the memory, and the group-
> >mutex is
> 	 * held, this cannot fail. The new domain cannot be visible until the
> 	 * operation succeeds as we cannot tolerate PRIs becoming
> concurrently
> 	 * queued and then failing attach.
> 	 */
> 	ret =3D xa_err(
> 		xa_store(&group->pasid_array, pasid, pasid_entry,
> GFP_KERNEL));
> 	WARN_ON(ret);
> 	ret =3D 0;
>=20

with above change:

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
