Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B44818D65F
	for <iommu@lists.linux.dev>; Tue,  4 Mar 2025 08:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741075373; cv=fail; b=iV214QZQeyYVILmfjWU9qjHQNYHWvt9xDY3qj6+VKpWcz4m7swDiq89ej7Lo7QUPz0p7YlAX7CR30NbzRgZqOPW+h9Th0Ua3EoFCvRtT/b2DBg5JkDmRk0U/XUSr9umQo+d3nBzbpnXP/7Hvt8dkUp9nMMwkXbB57Y6oQtLo/6Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741075373; c=relaxed/simple;
	bh=eGeYn29TlomYoXd0QykqN2fw9mk4JheE4Xj5wCKCGrI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VfLdKYDN0tEy6BN7lSH+r3fTM9uvhuCr5ozuihx8q/vWFGtNBq0Xbw0bBTntbCrWQ97mcewH24jt8oZB8LWWiEUSRItzWx7ytUojhxyrumDccVqjZU70rEnshgZyIelPj2fhSg6QFFk1riXvuPVlW51SnnjLuoD5DyqLXwMZdLc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SMq3+0dW; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SMq3+0dW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741075372; x=1772611372;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=eGeYn29TlomYoXd0QykqN2fw9mk4JheE4Xj5wCKCGrI=;
  b=SMq3+0dWj7Y23kTioyZlVJxiIj/xsqMj1LsRZodIPkyLwfFU3Jzosdke
   Oa3JgOXvvZFzRg5kYfPgrcCNCjfjRQ4B0aAsmj9sSO7ri2WTBSuIuyH3G
   o1AqUWVXKBpkg8xmp+lv2cyOirCIC0BbOhl+MdnItoFcTitEzg+huNC1Q
   LHzxRSaeWtzc7S0RRR+lAzCglTsegnb63TdJ9kyjX6Q+48M9DktQ0vkNt
   5jH2vqug+43i3cdJEn6CxCA+pPeIFERty2b+RPxZ6Gro5olIG83MwsBcD
   jNlliSHacm7FPnTvaYciI50zjprzxVZqBpXEcoGWm/t5+0J/4NN6HtbJP
   Q==;
X-CSE-ConnectionGUID: vMWV5Z+qQfejQfyoiNsknw==
X-CSE-MsgGUID: /7DMhK4nT0mXERYctdD7iw==
X-IronPort-AV: E=McAfee;i="6700,10204,11362"; a="53375413"
X-IronPort-AV: E=Sophos;i="6.13,331,1732608000"; 
   d="scan'208";a="53375413"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2025 00:02:51 -0800
X-CSE-ConnectionGUID: SfP0+rxaTr2ko8qF5XfsxQ==
X-CSE-MsgGUID: rRmAtZ/ZTMuAcu3LghT8rQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,331,1732608000"; 
   d="scan'208";a="122914558"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Mar 2025 00:01:21 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 4 Mar 2025 00:01:20 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 4 Mar 2025 00:01:20 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.176)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 4 Mar 2025 00:01:19 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a/7E6Fd1R+GxUhVfewo0K+4uC41AGbOZSsUbLoCw/yHoIHYpAjf94V0WmOizRqy6yqfbWjqWH/M/ORM5NpeQIJg92rWIViUm40zZ3yYdedSKw2gy5ORBhGo6klt3dftYV/HBcQglI6bbrgkpbC5D1VgEMZwWgtu80zZ3FCMirSAk2LoSinwdY09HrEeAFhtsj1Nt66oI3X2lGIaN8laPLckMI8A2+xixROreOEn0Ga/5enLWyTqomK88DwbYOmzesTjsW44UQHhgdnZ9yZocdDYd5ShjvbknmZ3V8T/2ArzLp5r6atfDe2KhYvkWqLvr1bz1GZ4av0CNi57Pc3rTeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eGeYn29TlomYoXd0QykqN2fw9mk4JheE4Xj5wCKCGrI=;
 b=cWS+lUhCcZd+yUW68uSvTyrn1JbOk+nONVUQo1/kitKfonW3N5HH7cLF7ujPOqTYQL2dCTel84vl5dlKhItn9OxrUOb7mag9iHUsM+so2C50CCIAHq38TNsUh9jc+nd4NrA12xs4kZQsnJuUWjbTsgjDTLXECEMRkmXoDrJgHKjekhceXzcx33mIZml+v+QkrE3rJZIPn/3ejs4YzpkHWp+8vzbI0c+JgIF5jYYi9FR++8UpMMivTkrq6UYT8g1Y774dbB7bfPNZiTyDRDJaGgrw0OsX/fE0mTEZSzizMGiE78+whfAVKO6d6Cr5FIntJn3azdTTS5lJencYl1XN8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by CH0PR11MB5297.namprd11.prod.outlook.com (2603:10b6:610:bc::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.28; Tue, 4 Mar
 2025 08:00:59 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%6]) with mapi id 15.20.8511.015; Tue, 4 Mar 2025
 08:00:59 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: "Liu, Yi L" <yi.l.liu@intel.com>, "jgg@nvidia.com" <jgg@nvidia.com>
CC: "joro@8bytes.org" <joro@8bytes.org>, "baolu.lu@linux.intel.com"
	<baolu.lu@linux.intel.com>, "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"nicolinc@nvidia.com" <nicolinc@nvidia.com>
Subject: RE: [PATCH v8 08/12] iommu/vt-d: Add IOMMU_HWPT_ALLOC_PASID support
Thread-Topic: [PATCH v8 08/12] iommu/vt-d: Add IOMMU_HWPT_ALLOC_PASID support
Thread-Index: AQHbiENIAOPyhje4MUGnJYX8Y6mRUbNipohQ
Date: Tue, 4 Mar 2025 08:00:59 +0000
Message-ID: <BN9PR11MB5276656E2A9131C6DBB7F5DF8CC82@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20250226114032.4591-1-yi.l.liu@intel.com>
 <20250226114032.4591-9-yi.l.liu@intel.com>
In-Reply-To: <20250226114032.4591-9-yi.l.liu@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|CH0PR11MB5297:EE_
x-ms-office365-filtering-correlation-id: c9c38ef3-12ba-4d8b-4027-08dd5af2b334
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?0iinQHl4Gp3DsuSBdwrpzuL9PMraNLphYqyl+CppmzLUBqpoxo4nas8xk4TR?=
 =?us-ascii?Q?Xdz8P0xwe7mt9elnBIEM1PLCHafF90TD+hPwOo8QPvISJ90mgFvvt2mSKqA6?=
 =?us-ascii?Q?sS4BLzECUPyRSpMqwZZGNlT7tvS5F2dO2rUvRsFPYfvG5cW42qDseGU5J9kp?=
 =?us-ascii?Q?3f1dsPodl1zYWITuR+zloPQHnbC99W53QJOxyibMPMQLexVe79l4ad9q8Pp2?=
 =?us-ascii?Q?6/i/CO0TUZ6iVLRNRUT21hjxA8+551B+T5bDmqvP/mPN6zWgWuJPmlvu3bv7?=
 =?us-ascii?Q?SaPqopxbLR6ZKyiJM1MAs2VH8RMilkTItDSwL5FgHKce++/yV8U7SSgElvqv?=
 =?us-ascii?Q?mwd5eXJKAnOt73fIsw16w1Uod2GXvOWSofuyWZq8bxbHA8wUlWmTPKmHirdD?=
 =?us-ascii?Q?Ex05HJeETPs+ZZ7sBHHPyiopDFecaHTdtyLqK8MidI2egOmn1ClKZ4NdGm9K?=
 =?us-ascii?Q?I534GXrEELC3ih9Ifmp/wzna8upktErLGbTti4mXklKlnjhv8afg6WKuP01A?=
 =?us-ascii?Q?tCfgTISX4l+aFVzXmDwBYn8jvbMAYwgz3e+keXiBc/Hm5Ynm1E6D7FCdSLJw?=
 =?us-ascii?Q?R9/9QJIbH7u0zb59QxwO5qPKMFsUPpZfKKXcrw2urdgLJJdKlGZuiyk775x2?=
 =?us-ascii?Q?qhrtxeTPXzxXNDktWZ5nnmBV074kJdvG7Rl48r/0eqENN/c/wIS2Qal6SF76?=
 =?us-ascii?Q?P/V/+s0EsxfQ/3Wvo+oEjUUJEfo6PqaR8i9wwGuG2y1f2QGzA5RBQBE8/UPi?=
 =?us-ascii?Q?SsGjgUUALzi/cSpzaMCg+vVN586kOtFY/G5VYup7IA2tgUZdKrBCgdpwdJRb?=
 =?us-ascii?Q?/XJbCspp8AUZr+3gCxNUBUs+8UqV/a6sEe+pk3IaMHsUyxAPMbe74RukXQoU?=
 =?us-ascii?Q?RvcbujXGw29+0E3ix74IzhFqBwd1o4IhXwXaZP0m9pYCmSobBjcNo+5sTZ2r?=
 =?us-ascii?Q?zmk4pSxCykvNs8FPN10NW/4t9ZoKkcLN7VTg/zxOZyjiIc6AzKg0zzDD74tq?=
 =?us-ascii?Q?qcIWf8DYIYNwZLXHsu8KsTPWBfdA9UZaVUoYi4xzjfQFhez8z36bIQ3ptGzh?=
 =?us-ascii?Q?CrD+4tRXA3/d5Eq/7wcNNrJnGdeRz65DqCrWewL3vdzqxhH7tnfXiNIoh4Ar?=
 =?us-ascii?Q?HkRHLrTkh95ADK+9WiFpzGSrhmu3uqa97q4v7taLRwZCOEquLm0Gwld8fryV?=
 =?us-ascii?Q?pnn5zsICNWIHUATGvtUIs13wY/0KUeT+uI7y9Ekd86eM5DzGReb+IevwS9i2?=
 =?us-ascii?Q?xVU4kIa58n2yN1igNQATqEwyEg38NojY5P7Gya4g6aA8RHKEy37hN+T3T/Ph?=
 =?us-ascii?Q?a1HWUAQY3eASL3C8hxABzpv31znEaCGBlKPNx+bKEMyobA+Y9RFqHMH27Upg?=
 =?us-ascii?Q?t3GlR1KKdpr42eaFLoNSQp864W9LADN7M2hM/TE0CDxeOjaTqZvssO8isN6Q?=
 =?us-ascii?Q?RXhiIgZ8D3GOLTu+mdUXPG8KNe7oEMYZ?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?a8icAWN11xMYmkHE3FGAnDMrBn6SFnw4l+GmfeD1faQJcsUn6+dZCAoGDqB3?=
 =?us-ascii?Q?jGQzNf4yqW43jzBNFxw5IPYvVKu4u8dkVSTZc8DcIdc070aw8Gs9i5swOQKx?=
 =?us-ascii?Q?lfMojzFGE2SYYrjjk/639oxoBjgn37sXIw/TRgS7r6W8H/q4AzxLfxxPODrM?=
 =?us-ascii?Q?Q2H5a0g/dJ1wC6A11n0X7Q6bv7IuPQ4+F9lRL1HDkvFQ2b0NxCdN9pmdtwq1?=
 =?us-ascii?Q?e4zRzW6EDoORJsWA5JsnddWWMm3aD8l4v5itH90REc5LH0acAuvUZ6lgiqJL?=
 =?us-ascii?Q?SnaOGkPP1L3k/DzdodpyPwqmDepL1cIb1VPVKCto22M/jmfJ4YaaMtZSza0j?=
 =?us-ascii?Q?5M/4l0MxR4siqNbcsvhh5SYq0mYyRGf15AtnfKP0lAtnLGJIA2Xy4+yde+zX?=
 =?us-ascii?Q?Ker4XU4ctFrlIi6XKWevIT4V4lhbIVLyUB+0mP0HmXvRgmZoeYhgi498t18s?=
 =?us-ascii?Q?Ew2r/wuwNFaDLDY9Q4/u+26UpI4Gds5Lermbr4WZmGxzf1qpAmVhWG/RbfDy?=
 =?us-ascii?Q?cLfPDfA0ncSm0v10YXFVnVHuXCEwAdjzSesg4hy3FLaI10QHP0BMuykfLn8V?=
 =?us-ascii?Q?HFYgH915Uedi+056vlt+ZFmpnG0WRkcEe8r2sa2xR91efMG6Q4ra5c/ghhrI?=
 =?us-ascii?Q?jmtGS5C/iMebFjW52SPBxqlm8ncMxhaxdLaC8H6INvZPMDqPox0aeUGLEoi2?=
 =?us-ascii?Q?IzpwvjiBpj+xc/8aD9jgORdjt2vLtKsNk3u1ed8mhp3EcfcMt4eDrstClrj/?=
 =?us-ascii?Q?H5Clie5Rd7BUR7HVcgfJW3HbXwFtrXM3zoY4rIm3xYgWfC+U9XloJWF7gQXO?=
 =?us-ascii?Q?4IAp/5WXBL9nE9f42ZeIVy6FUJ8BvQftooHKUHxMguiLNQCVGp5x4ZRSWXgm?=
 =?us-ascii?Q?2fnYWqI3ybg595V4G1ajTnD+C1KHfu+Vk8yz99BfpI1QgOGawMneE7nhoCiT?=
 =?us-ascii?Q?aTPaA/UQV9tB4jWsktJ175q2FRSdahpbdDST8S1zZPZA+6Q4cWyO4MQqGvr+?=
 =?us-ascii?Q?thSH+yBtbprc08sNRuGe/Ud8eTPOnU62+NwQfJCeFKrDzsS59OLKeEyaqW50?=
 =?us-ascii?Q?wKqBouvr704I2uRjVkrI9E53fSl4KjPPkqYZ15WvbFEu8wLb7Q0xXm9HpdkU?=
 =?us-ascii?Q?VE5JVOZMjLyld6W5t27P3WQavGAJYGBgKwrc/6JDyPfCI3x4O2aVuMbYG1mO?=
 =?us-ascii?Q?rYLX1/pBuTcSF9RLhyEewahNiyB1GwBFaDfcG2RTN5FAc20tt12iu7alHFDu?=
 =?us-ascii?Q?VFOKkDDqGoGGT/PRSsOA8hhgJ0nR/egEiTs0B9yMt2FxrC3Nuj87zc8bmcNt?=
 =?us-ascii?Q?LF7JN/kkmpiaV7T/ArAFFR4aZMA3XZN/GTAvH3TNwMNt44acwYpQbr0FdITA?=
 =?us-ascii?Q?fqoItsfM7lRlJXgfyYeYOK9G66LUThJJyypIWQnuNJPiftsuKtHiJ9PH4jP9?=
 =?us-ascii?Q?F7LKQ6j114qqbFcJ/asc0pRRGN7F9YZgiomLUMehEd3Wn+p/BieRIhYwsDw9?=
 =?us-ascii?Q?tZxaZuEvpnd8N5VMnp8m3odrCLKanpJHWF64dGb1lDKb5CO4VVfb1uERge7v?=
 =?us-ascii?Q?7WQe1UX0tjrhkvNeGwCluQrOz6hsE9cwOdJuhJLF?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c9c38ef3-12ba-4d8b-4027-08dd5af2b334
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2025 08:00:59.1063
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: n1DcZRw3nnPhQR/4F0A6BcgyCnBB61dWh7ax4IcFX2Ck6Dis+wMl8qg8NFPumRS9UC2ZSLjWeP9ssUDWVIIcmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5297
X-OriginatorOrg: intel.com

> From: Liu, Yi L <yi.l.liu@intel.com>
> Sent: Wednesday, February 26, 2025 7:40 PM
>=20
> Intel iommu driver just treats it as a nop since Intel VT-d does not have
> special requirement on domains attached to either the PASID or RID of a
> PASID-capable device.
>=20
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
