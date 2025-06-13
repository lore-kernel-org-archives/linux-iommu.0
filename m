Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EA161EFF80
	for <iommu@lists.linux.dev>; Fri, 13 Jun 2025 07:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749799915; cv=fail; b=fxltjL82q+GQhfxCr/qdsCgmndvM7KBsXiNFwc3uC8IgTc/dzRLnc6haKgEhriWY7lknVLr0V44QoDc1FiPmspvDL8pUVglE36xjF8fUbxxrDFuCbxYeomemEreQlrvTJs3kBrK4adNklveqb0FkM5fLN2OFzhfH6A0W4r+nt9o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749799915; c=relaxed/simple;
	bh=em0bd/Yip/Gc16MP583EajpZag1yYpZZowCWPh+IEBc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bADn+JYj1C2btikayRb9iHPcI+Joo5jyyIug/clRI1Db/KxTyG0yDJaySs6iKzoDPm/dzFyJs0lmx9XanvTDJbByQ+QU2GNol/gkjhLX/hLUBd290cwnbSkAumbv760DlBEYggXgDcJG1+kZZAyR/R+WYHPNAbOMBRhi1oFPQak=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ft5VK0k2; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ft5VK0k2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749799914; x=1781335914;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=em0bd/Yip/Gc16MP583EajpZag1yYpZZowCWPh+IEBc=;
  b=Ft5VK0k2yphVTJbJ3Yjp/j0ZI4lQZS3tfcJwqwcBGL1VvakmTiVQvLm2
   TdSCFSDwMSGZlg1EltGXJxQR1uDJI/pLfwv+M18tJCwY1331JQYhgmkY3
   9ikLFOpY9fSNvEgRRByZx7ewKQKgrkxrl+8gcQo56QQb093h139F/lkai
   bMEplLQuVRb+mxzCDAi6rej2i+r78NKlNNNCRD9KJSR1k+mvwsj/nx06Y
   zLDmUgbml0Q41TOU/N/wmCex41v43cGSLIYc3355cpJO64icr70Ac5FyU
   b9lcqbAKZhjkkrdvTVqjRq7v0t1nlLu0UaFzzfZnafVilJ8Ub710GKCfL
   g==;
X-CSE-ConnectionGUID: EeGzOzgbRYubBr4pmLW/4A==
X-CSE-MsgGUID: JD8yddXMSFGfTqLqKCoqiw==
X-IronPort-AV: E=McAfee;i="6800,10657,11462"; a="52153698"
X-IronPort-AV: E=Sophos;i="6.16,233,1744095600"; 
   d="scan'208";a="52153698"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2025 00:31:53 -0700
X-CSE-ConnectionGUID: ZZq74OMXQcmNJavpOMvo5A==
X-CSE-MsgGUID: j3zAb9KmSeSRGsqrvi5rIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,233,1744095600"; 
   d="scan'208";a="151580691"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2025 00:31:52 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 13 Jun 2025 00:31:52 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Fri, 13 Jun 2025 00:31:52 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (40.107.237.83)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 13 Jun 2025 00:31:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vmnxHKViThBnP+Ied2PLXvKhwZ2qkFQrpsZKNafvGGemmjY04J4aLez31apHDwpM+I8zIaoQDuKPEOnPkh+mgMK8CkXMALGHa/PS8YcCf2+ZQJuX6B6QXeg1oLgEzUZNd7inrGg/Fi6b8yLy7XxnERk4vEAt/9OPNo0kjjMfmpg0Kdw35aOHzyfV6q1I2Dq3auIPjtmt+9l3CotI3MmB0YNAQD9+9aak2aqGrXbdL/ERpctc0OXm+9yFSLQDam04Ro2uEDHt2cXgCUIw8UjAk0pYNZv3s7iSAgdZPqNyEGfgjk4g836FJlaIvDhhykO19F7oBQdROQhK1GoXz11MwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=em0bd/Yip/Gc16MP583EajpZag1yYpZZowCWPh+IEBc=;
 b=D5Q9cVOLc5RPfgxPsEZxf058m2EYXif6ypVIQwtNTz+qd2h6t9QGkXXMpntm3zJK//39NPI71BwIDhY7lXmtxviSaKb4XCgZFObsLwhnlohdGKXPXmknXRiqroG6HdPDlhL19gdSxEyD6LpPpQjYiNdVIbgHwfdfDiXxjCgbpeI7DwGO0EjEI+VK/LCnh005IbFDPWqLQuExxibk2eFlQjLS2VH1bKJRMfYebY+dCcuTirEZXB2mcMSFerLV5Ko2mlRXcDnCCCM9JRPRRlcB2Q1o/FA1U7V+vEhVBUIraW2lLoclvDgspmfabYGXBe1PcuMamUOuTCOttj0wLRFikg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SJ1PR11MB6202.namprd11.prod.outlook.com (2603:10b6:a03:45b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.29; Fri, 13 Jun
 2025 07:31:49 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%4]) with mapi id 15.20.8835.025; Fri, 13 Jun 2025
 07:31:49 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
CC: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Joerg Roedel
	<joro@8bytes.org>, Will Deacon <will@kernel.org>, Robin Murphy
	<robin.murphy@arm.com>
Subject: RE: [RFC PATCH] iommufd: Destroy vdevice on device unbind
Thread-Topic: [RFC PATCH] iommufd: Destroy vdevice on device unbind
Thread-Index: AQHb2dRy0pZb6YCA9kCQvhSriVTQbbP/KocwgACgJoCAAOcYcA==
Date: Fri, 13 Jun 2025 07:31:48 +0000
Message-ID: <BN9PR11MB5276B467ADCC57BC6571CA458C77A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20250610065146.1321816-1-aneesh.kumar@kernel.org>
 <BN9PR11MB527606182417BB7A35349F598C74A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20250612172645.GA1011960@ziepe.ca>
In-Reply-To: <20250612172645.GA1011960@ziepe.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SJ1PR11MB6202:EE_
x-ms-office365-filtering-correlation-id: c51011ba-7d8a-437a-f586-08ddaa4c5bc2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?YC4MKwU2Zmbet5eij4YZFH759eyAOCX7z16W5PObuYkXXj8C9EqCwUvEdbsD?=
 =?us-ascii?Q?ERvXiwEZspiiGvExKXIGEP40Bx4hKLt//OC+QCbF5FOeuhrTW9jQHp0MRMZ0?=
 =?us-ascii?Q?TQznP/IaIbxMeLCoYzFQ2M3hmSdaE0RcYZU776Dtzyj++LzOAe8ouPy5BDLa?=
 =?us-ascii?Q?F6IRzJud5jwBLmGUNSSUvRisohYKYW5ce6kz3YQRvRxJTz8fQF/65GrjJOdQ?=
 =?us-ascii?Q?luIn3YV1kbx6XxyxcyIgEFqQ5/GkrMbNq3BsHmaEf0/Xd1+jG7aHST51kqyM?=
 =?us-ascii?Q?7pt4aTIHytnhrotXhR66NmffWRWuBKrLE8qV/hd9sw9RfEqYielGYiowTFVR?=
 =?us-ascii?Q?CqORIM5i1VnABNQe5spjMUDVD79gBKAIZIQKMOJ1bghwqbv3+Kr0VB8ycAk7?=
 =?us-ascii?Q?oicX29HJuNNa5CWnTFRyhOyXKPVJ9JZ2OuSGLLhyUO3j02KAKoUD6xq8tKir?=
 =?us-ascii?Q?2IQPwjt+UJ+wOaFPfiM/3CHmcXrv4X0PPLI+QYTn4fsst+8Bme6jB493Gr3Z?=
 =?us-ascii?Q?fqqyxLkxyIp+rlmbnsAZ4MaJKBYB5CN5jymyHrHT55Sxm5LHzvrO6c2sY5vY?=
 =?us-ascii?Q?JylpYvWEd1WvuB3RJimOZExLgs3mC5E2EmUgbKDI3rawXNDIld7zuVeMrdnh?=
 =?us-ascii?Q?R9kwCElaI+rJ8vb0d5VZYKkz3Lw3t25AluCieax96SbcVbFy0LY4AP7LaNxu?=
 =?us-ascii?Q?l2faqiAmEr5eS5EFrGj+/Tz1HEkkmSbA37s5VSfU9pGStvK1ZA7+QFXcHOdP?=
 =?us-ascii?Q?1E9I9bD7iXo7T0mhPG/ZSo/1VcaitojUiSTOEUhbTT5MLqpqfJYJLi5y/NEy?=
 =?us-ascii?Q?hIbd/d6aYk2YjNeoadROe2pwgn4MzEI/QcU1e8jRjWrw8CemU+Du8SYoXOfi?=
 =?us-ascii?Q?XIuJCzzNYaa4qHLw6e9x0Zulls5Z3S3+BppbECbVcvP0iVnhdSJ52IK+a22/?=
 =?us-ascii?Q?3hR57K/lvKmTHoGzjvJEjlKfpBTijOS3prollKRE7yyz1fyd56u2YyTYWvWB?=
 =?us-ascii?Q?cKvBrn2GTPhrBHi4wCGlGF2G5gZDY6YeLyRUUs8P9kHPc5448sen8B0lJJU6?=
 =?us-ascii?Q?yY/fp/QLQXWOP04XTps1Yc+cADerFeu/j41cyVpairPoyDk458CJtsCKZj+f?=
 =?us-ascii?Q?0sx5s/KsxTmMrdrCmKF+hqMECnN7BU86K1hwNV+sepHdlqETDCbTb7sr9VTu?=
 =?us-ascii?Q?3td5fSBWhiYoIRkUPwhtPzM+tGW6meT870rhPf5sSt4kwBm/ljNZjEVoho3m?=
 =?us-ascii?Q?T9fR2shioWtWAv4VVb+k739uQK+rKO4L0r2JtLNhZZ9RvVI+jdcZAHAOJW/U?=
 =?us-ascii?Q?nwyuMeEZSOR3DbIE8/Am0OpPB0t+QdXa9zN5MqWpYDSMRcX0/+vjOcK6VZK8?=
 =?us-ascii?Q?0jgd16s6Ddl3hRHzleBIpRUHvU6PpNlpkDS0kbowXxAqygzo62MphR+J85Yw?=
 =?us-ascii?Q?zUiE62alowgqyeDy1Rk97Fzbj4VSFNHa?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?n5taCWO/RBz6ZMihRMzCBfgJ6Se+GP20z/KjY9bMX+8KYf+4fa8n6ElXfzfq?=
 =?us-ascii?Q?yar/yz0+KkERTX1H4aXmFwtwxhXYlx7Ke92T74oigYbT1PRKezkAWXQgQRuE?=
 =?us-ascii?Q?gRc5tISUYg4qenZGi0sZh0EkiQTrFChRPCcm9OZflJxZ+EpF0HSXDfY1wqta?=
 =?us-ascii?Q?PcYoHoB0Bel8jaG5hch6yQ8A4W3YwbYEq2h85yOOrRl7Cpj0hwbRetc16Cdt?=
 =?us-ascii?Q?tsbXfS3Pah90hlmEjQCPDPotUUvfTUee1/3AMr+LOFR0CjTgTCgeK+zkR5YI?=
 =?us-ascii?Q?GM9khNt/E7OpbN0achwHJ8lcysYjY64W+km+kAt/CzEApzE/dPO76Yr811L8?=
 =?us-ascii?Q?WfD2DxrlUFdnRscT6IWYV3p3U4u5XahYY3pW+V5/vWvQ5/z4aEnvIUTcyAbL?=
 =?us-ascii?Q?FUFTueRRsmg3HTkVx95DIEtXsCtLLQbXij+g/3GU657AjqzGPbcUqUmvPb8b?=
 =?us-ascii?Q?TntWD1EoqmSzDUydWkmfQWiOc9eYsi5WIwH7lVlG2i+ggbJmm45WE4P9FNMJ?=
 =?us-ascii?Q?3KLCaxbfXXzBFo+ZLZFC5bF7F1vg21eycKE5TemnOeeRwNEGj9mQSQxYyRm7?=
 =?us-ascii?Q?rp9igVYi/yOPbSFQu3TOxbcIfMwC2dWHr7stp0+pWUaKj9yl/apMr2iBKhd2?=
 =?us-ascii?Q?qgWMmDb1EP/w9RsNdWAktkZQw6L0sOO9sXOc9wTpX5/7RS1FciyG2djZaSpE?=
 =?us-ascii?Q?IoKDQLSymU2jDfmxmSXbqYhwSv/TJ6xRS8qnonWBlCAJyUO7EGYtJy4Oc1DT?=
 =?us-ascii?Q?kGURkbrjSjzsQLhWjUVCXXXcB4xGfuN8j9ppDprOuquimSK//ZLtgM5SgfWf?=
 =?us-ascii?Q?oDdNz9/+1QOQo1pSFR7ngSSMkX52THzGKnBiGdgeboix7hnQNQRrQuUKTx2m?=
 =?us-ascii?Q?dXhaG4sFIonKIly5jZgDZv/1r2znqeftRycnzs1kVYrpbqkhxalTjZK8SBUE?=
 =?us-ascii?Q?m7qj4MCrUnHOA9fIfMmLepeUn6vriPbBWQyNky21WLUOZmd7nhbR2/jqY8Xq?=
 =?us-ascii?Q?ipXmOxU4VDJFFPvrHeN7dTbFExfpqUxwtR/1T3twMIBQo+LDAja9KraZpOYo?=
 =?us-ascii?Q?iSzejXe6bzRXhq/qNU4//xJaydA0CFsWJjdVi/CnSeBPiOfmDvapXIx+cL8X?=
 =?us-ascii?Q?JFCI+SIqVbqx3kb4fWyPOsAZ5us6aMdMTc/T6BoP+/a5OFGGuhScujysjd11?=
 =?us-ascii?Q?nYuKzlWaYMA2QQqL1nbrNEUHP/cNhwIlO20DTpOpmGSdQ7TyPmyq/NJz3wWH?=
 =?us-ascii?Q?4J9sjjxvM7dWDVa8frlPZ3k7KWgqoa8SVlGdRNhFjMJbj9vC5H3ov3FjWtoy?=
 =?us-ascii?Q?BfgiHX5DIJomRtm3vjILEdEoXr7IHDScNes1x48jbIA7be2NidfDogy4Bvqz?=
 =?us-ascii?Q?Xz5LntbgRRTMOvKgZRq08vJVnneoXtVIGkcthVVQpFG5EXXtarLa/2FCr5Rt?=
 =?us-ascii?Q?WW6AJr5LU+VJNP7slC4zL8+HgtpOooVfCWjzhh/xY2K3VkYrNreTkb0yaJz1?=
 =?us-ascii?Q?zNhVSlThVshBbuvBoDdJNZhKdjekceEJVA2WQUTg8SQRftWRa+nvk2IprI2N?=
 =?us-ascii?Q?gBj+1sF/RyOXsbJjVx9EsyA12hNedBb3YWuoCKJi?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c51011ba-7d8a-437a-f586-08ddaa4c5bc2
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2025 07:31:48.9826
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bFMBWxfCGrPkOW+JNMmghCuYilUQqTI/++gmlbYs9tndkNFQg9WHtbAlfEyUBmYFXd0gLKYhRh22TSZTcgjWlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6202
X-OriginatorOrg: intel.com

> From: Jason Gunthorpe <jgg@ziepe.ca>
> Sent: Friday, June 13, 2025 1:27 AM
>=20
> On Thu, Jun 12, 2025 at 08:05:37AM +0000, Tian, Kevin wrote:
> > The initial v5 patch [1] from Nicolin was similar to what this
> > patch does. Jason explained [2] why it's unsafe to destroy "userspace
> > created" objects behind the scene. And a general rule in iommufd is
> > to not take long term references on kernel owned objects.
> >
> > [1]
> https://lore.kernel.org/all/53025c827c44d68edb6469bfd940a8e8bc6147a5.1
> 729897278.git.nicolinc@nvidia.com/
> > [2] https://lore.kernel.org/all/20241029184801.GW6956@nvidia.com/
>=20
> Yes, we have a problem here where we both can't let VFIO go away while
> the vdevice is present nor can we let the vdevice be fully deleted.
>=20
> At that point it wasn't such a big deal, but the new stuff seems to
> make vdevice more complicated that it cannot out live the idevice.
>=20
> Probably the answer is to tombstone the vdevice in the xarray so the
> ID is still there and userspace can still destroy it while destroying
> everything linked to it?
>=20

yeah that seems to be the option if the said life-cycle dependency
cannot be removed...

conceptually it's still a bit unclean as the user needs to know that
the vdevice object is special after idevice is unbound i.e. it can only
be destroyed instead of supporting any other kind of operations.

hmm if the user needs to build certain knowledge anyway can we=20
go one step further to state that the vdevice will be destroyed
automatically once its idevice is unbound so the user shouldn't
attempt to explicitly destroy it again after unbind?
