Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92B6513D28F
	for <iommu@lists.linux.dev>; Tue, 21 Jan 2025 01:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737422516; cv=fail; b=YrclBTXutD2AngOEUKtBhWH1zM6yegcnC2jviF+mZtMtvbkhw6AZ4mTW8HCH0Qwxqex30j/cfjh2nnLHivuoIscdjY+MY5dgJRixzi+YvThzo8veGsai+RHClwP17h3SFDIS4FH2iWKYJRb+LxhhPsUUYdJKIQyCESxjOWrW4ps=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737422516; c=relaxed/simple;
	bh=IBiv81xEI1kWP5rBCdpkm3JmDH/WuYFCqH5tl4JdmmU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LtzNJiGqoJ0MRTYcTLpva1YbsBESi/Jm4GD690+KQQOba+wXiDlPtDZ/GQiZvKs+TnuN4HzKqRT2uDXCCotzefUZziEQereKX7Snpqwpa+AvYxtPjP3YKwp4WLmrtOAvgIRP0Y6ap42aG6P4SFr4HQsOokkBqlpFjyj9rz4zOmY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CgO//9QS; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CgO//9QS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737422513; x=1768958513;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=IBiv81xEI1kWP5rBCdpkm3JmDH/WuYFCqH5tl4JdmmU=;
  b=CgO//9QSUNlssYpc7NhRoEaMHNKkwHG7mib/I5SFPql/4VV2xwf0n0SB
   IeqNdT55AgjjX/0Q/fJi9PLdwKnGxk6coQLfLyaX/CNK9nGavGzQmDmQX
   D3EtDd5PUR0gvM870QWu90XbqDUO4G2JsjWU90gOnWP02G0nJawfDkYvv
   RnwAci/qgCBPHduBQn93Ju1bOTOnSpuHir1JnnCongxWXzJUVjKtkfEzN
   loikoygF7BVcBas8vJFTUx4P75fSmjQ8Ov19na0RqfA/geE/AnB4FeJsF
   h5WDMMsMJoYmh1+9Jqkc7b8lgQoTIv5OhOUuKnv3PKF8732+ZMvk217K9
   A==;
X-CSE-ConnectionGUID: cd+2q0RwSAuJnlUWgmxdQw==
X-CSE-MsgGUID: LSk7A/r7SBipU8nBjCmFyA==
X-IronPort-AV: E=McAfee;i="6700,10204,11321"; a="37513503"
X-IronPort-AV: E=Sophos;i="6.13,220,1732608000"; 
   d="scan'208";a="37513503"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2025 17:21:53 -0800
X-CSE-ConnectionGUID: vf5DKHyCTeuwNsiRNX1WDA==
X-CSE-MsgGUID: RBo4V0HXTpiinoIrd5VEjw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,220,1732608000"; 
   d="scan'208";a="106591403"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Jan 2025 17:21:51 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 20 Jan 2025 17:21:51 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Mon, 20 Jan 2025 17:21:50 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.42) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 20 Jan 2025 17:21:50 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pf7COnP3OgI9ecv9rAH72wyAPngOruV6vXwMbRoBXDEWgZziGcYW8ud2hoiVghkC3ntP/AiM3g13XUbNAlQqbCP8bJ+ROV8R6xEDM6iwbxJWKjMnKKasSkPg1351jKdaaQRzvhSNHoWfBD+ygxJAICwnGdLR6KGKansF/JUijbNuwMGJTS4j/LW9KHrwdpAybYEAjzyzrrOko0Gvap6hal2A8b03JhPj7TGyEGdasGIrG8tridAD2zdITl8PsDcXw4x3YOSYjOWZvam0regyStz1BbrPi9eSEtwnar3OQukAZLLnD/7R6Jrbl3QQjuAKieNsxMkdS0V6odjC233nnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gmLsOa747GM1gAsX6oLMdavP54DJxBYwO+va3bVouys=;
 b=xZOWEKAleHfoF2Odc8T26aRXR4QB3aYtbDllKJK8v3X1BsoAUpKaXSUXTuhgyZb7iheV2ZbWcfPID1RJpN4ZIGn8zcpKUNal7h29R/Io5h2X9w144PQyOxylpOrPiJxiyezNNwO2jcFEtfw35XN9HIYJFYGsPp1SJZ6GWlqhwxax//Qr0pMO0MIhORDK5jcKmtCmBpcY6j4FnSIy8vbAeASqkq/b6SpiQlHVLoTSUjyKVSdpNwx+o8tkIA8J1sYEfechxrVQj3E3xnrvCQXTF46PjMLxLqoG4cg8Oz6lifOYtDULsece9D1hNe1wOJ1vn8IG6DMKNCQH93joPODw1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by MW4PR11MB6690.namprd11.prod.outlook.com (2603:10b6:303:1e8::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.20; Tue, 21 Jan
 2025 01:21:48 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%7]) with mapi id 15.20.8356.020; Tue, 21 Jan 2025
 01:21:48 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Nicolin Chen <nicolinc@nvidia.com>, "jgg@nvidia.com" <jgg@nvidia.com>
CC: "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH rc v3] iommufd: Fix struct iommu_hwpt_pgfault init and
 padding
Thread-Topic: [PATCH rc v3] iommufd: Fix struct iommu_hwpt_pgfault init and
 padding
Thread-Index: AQHba3SvkA/rFI4wcUaN62UsbZQDOLMgbq1w
Date: Tue, 21 Jan 2025 01:21:48 +0000
Message-ID: <BN9PR11MB5276E8C09DF127D6B96FF7CB8CE62@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20250120195051.2450-1-nicolinc@nvidia.com>
In-Reply-To: <20250120195051.2450-1-nicolinc@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|MW4PR11MB6690:EE_
x-ms-office365-filtering-correlation-id: aff80052-3cea-42d5-cec6-08dd39b9fa4d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?GjkVYdRYo8xZwjuMZ10yJw35LvgnYMeejxmNzdYWGeo6tyaDPXjfnoI2Y39S?=
 =?us-ascii?Q?Qj2U+hlMHArGRHLE1UZmJD5tx9O/lu/gLNjya6EPY5BdyvVv3En8FNoACTZ8?=
 =?us-ascii?Q?OpbUOo96kFgbYCeomxluuGbRvmK9GjV1ASL1ZjmQFkzTlfY9QvX+ArdYSJ0h?=
 =?us-ascii?Q?Px7gCXmLi85gQ+SQRbZbVKABAb80pCPT0Mk3NdHkNzPnlIGU7J8PZKqI6qFK?=
 =?us-ascii?Q?ATcMerJeIVa+clDfOG8GSrS2Wd85agdb1LWx3NzFtH3/VUohRNcKJB5MMggh?=
 =?us-ascii?Q?gyByUIHomnVO+KTdzGBT8RQIikaT0YTYXyy55SEt9y/vK+qnOckhOQXvT/dJ?=
 =?us-ascii?Q?CSJmKe2uOGYb7ANUu/nFmTVq5DGfjl2ix1QBP4srTqZnLRygDtXCzCfulazA?=
 =?us-ascii?Q?kPxClBXMICW4qMhHa7ybRixlBD1zwGKfQdCIaCwf2pg3EHF26GPMw1wdqBez?=
 =?us-ascii?Q?4d3voDKO62+dbdPEOIZQWUCinEjPFo6XyicBL0ZB6u//LlRoifWJk7qPQHam?=
 =?us-ascii?Q?l0rxhrB/CwZrP3H0i2M3h68bG4jMNrYiDQU7U6WsbynUSY0ipjVcf48Sbjfu?=
 =?us-ascii?Q?aSMpf5ZdONAiSaHv0CN99eiGrFjlgcD3PjJYUFv/vinY8sJIJW/Wg9CD29Rz?=
 =?us-ascii?Q?GXJGbXpNE/7VlL4qNtg8MeSwLgSxsby5sUkGco2w8HtVwH5PofxPL82IotsM?=
 =?us-ascii?Q?6XFB+Q2ltR+gIPQbaKWLDAOtQGqGnvRYPMz5i134GejeYOFZYLcoscfeubsM?=
 =?us-ascii?Q?lwg75dq601XYrnm/Jl7NS7sfIbzhBo4ccDRslllZ/+w9NboKN1GvBxGgglJ4?=
 =?us-ascii?Q?kZZF4fso/z7IzPKxa7G3rnEyHQGE5CFfIe3gPsQtNcrInGkrATH/kiqUrTRI?=
 =?us-ascii?Q?SdGb0Xp9PAnPrAHfOJgoB9ZNxWuPm4Kx/BWH6783lV7Klp4OSdhpAahPaxS0?=
 =?us-ascii?Q?6KonUu8w2mxSIDTURzlhWrMoS4NBCWDDhBk1tf+WSux8DgHW1ubqejoyHZbz?=
 =?us-ascii?Q?VUximFNn9wy++VluYqyMjSa+PGYfcuvfOzHXWwbd8qUcDr0n21s4z0LEZzFA?=
 =?us-ascii?Q?1X0TVxczc9LbtIzBWzrJ3JcAh8fRtPW0/YcQt7rkrZYYCQSm25B6fqQzHCRB?=
 =?us-ascii?Q?sTd/j6ojLWqbKbM1IrhKGtYpliIDVTANcR7VhMCkLb7XwWpvMkU0cfys+yJ6?=
 =?us-ascii?Q?AZCSUu1L/otr1f6kLmwy+iMw9yd/Ki2vOPQMm7bEHudobqczlY6myhZDKH+Q?=
 =?us-ascii?Q?zTu2hVNkbNrNSFEsdhL+F4ggcKuSwLtNs+6mmsqvAfZypXUe2g95fYsWHfjk?=
 =?us-ascii?Q?MSrisKqfdY75MxlqHNesOl1jd/tIZB2xC7iZRiAGGlYgqHGXNTADOcA1ZuT1?=
 =?us-ascii?Q?xRhGYGvz4abm3ex4/otjvEOoCFt/3nhSoZ6gj20VwGMwSOV1pBzZb+fV2JWr?=
 =?us-ascii?Q?ID01t6GiL96+mYn3RFxiMbpGzTzfh1AV?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?S+oXnp8ljQ8iXI8SADdYESiGm1FWNceJsWc+27yRUSVcNBesNrCGUodw5s8l?=
 =?us-ascii?Q?J14kV8hLZZ5Ner6S7h0Lx5AfZDsDdj6kpb7cys+Ij/KyqhAFzyMQ7I97Hx45?=
 =?us-ascii?Q?6AaBKUDyxm78jvPBshMOYwQkH/81jEVWOLMEkPgeRNsdn2Eqmzw3e2yRIRsN?=
 =?us-ascii?Q?lVqLWx9wiypTOaMDc5yY8r7xxdxB3iFAWU9TP5c9LupKwNsJFHk7MHNuYYZ6?=
 =?us-ascii?Q?5dzhYYsMumAGgfRT8YD29JWuWut9UuPniNy6M8TuoPJj/bnrYI5ddTWDcIW3?=
 =?us-ascii?Q?U9b/mT63VD85TAwlaulOxdfwywO5yN9ZlsDAD+lbTggBvsRQIoyOg2KtYHlF?=
 =?us-ascii?Q?GXnq5q84gxiK+OMd12qj2Y5Z4W4zshlZbHimCiRxEdy8LeqN6CrPD2tYc9+y?=
 =?us-ascii?Q?QeL7nvGiBLGIX504tQ7de5YyM0ZV9uKt2DdHvgAgoA0B4ior6QFXOpU5s71Z?=
 =?us-ascii?Q?pFAG0whZ+rBcOUp5jW3bzYXP6Cphh9+gouHAqW2S7/NjR1brx5lZEjkDOIlX?=
 =?us-ascii?Q?3nKMeN0b6F9/hnTU1EKRSB8S9h8To8NTaUBNb7mdRLoYelPEMWNES00tjgNV?=
 =?us-ascii?Q?5m84mdY4D99Hm+cK547NTQFdiX7gcBxLE/MTyD5ZkMitE8LcySV5X3XgvnJB?=
 =?us-ascii?Q?hRa2TycLmHKEOJ/QowxRu3YEMFJ1fYkICfeLnWVM1JgVjfpn/m9mNrXL/A1M?=
 =?us-ascii?Q?BAwhTza/lPx8G7PxUnYHZ2B26OGdksZl2olmBJeph1FHvkWfgRyb8zyaCCP1?=
 =?us-ascii?Q?GoNSKp60EdnhHdo6VMBnCL1WPFdvtLtHnMMPe0N4yjZmLaRIsYJZmwEE28p2?=
 =?us-ascii?Q?77CzJwcpca+B8Rwo352cCeX9o+ui2FQvTlsZnLLsQkaLsVZWcZD5ZS9J9AGy?=
 =?us-ascii?Q?D9Zv+94rYhq8i3vREXyclcrNbm6zl67MarYrgPx7k/WqqYAm4Xlrgxhom/1K?=
 =?us-ascii?Q?WnMSJQ50D6vDqQBhgVhojgXKStrl75JA67d5ak4j8c3T2IcsVjyvS10vwVhl?=
 =?us-ascii?Q?yeSboAGNVopR7KjoOELAITp7uKLWXtoti9q7tRyqFwpsBgGXIjSYWLoixAWx?=
 =?us-ascii?Q?+quv629keCbBDWwD0Cri9Bnsmj0qXUGWc6ZUpzKnc/5b0utrD1KITHucg26P?=
 =?us-ascii?Q?FUAjd1LqjFydO9aN0aZT83HkhMVXqUu4LG27QNROr90rMurfiH9fl2j730Gz?=
 =?us-ascii?Q?vZVCW0B55mfCDR8tft5FtHarKyGJzu7+by+eAU5KWcMqFEhIH39jkkul1yd3?=
 =?us-ascii?Q?YIAyXw0ElKEcgFZDDpmHstsP6HcRp7lIpgDJaQKyX8CULW3zbZ5H18a8FNIY?=
 =?us-ascii?Q?tdZCXxLFlmGJJW4HWmHv4fdzbgS/a4tHXe97kuNVy9Nmsruyg0X190gEmn6B?=
 =?us-ascii?Q?hXoc09dXBhiCQ2t+Cl2IzXWqVSavO/mtTZ60NwGsG3ZJt2UkaknztMh3eMQI?=
 =?us-ascii?Q?n8Es+5J2g7Rf3W0mv2gSX51nqHfM9whLFvcSw2iI2/XIS8y7yFs2eYrQ16uC?=
 =?us-ascii?Q?TxVIUFpf+W1a1DkIqV9MUQFQb1DwJuWmc19VEPLTW5aBT8tMBNNYTNGUBgal?=
 =?us-ascii?Q?2ITM7Z6RoZv9fJmIErX4g4fLZ7q/4mzD8vuo2iS3?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: aff80052-3cea-42d5-cec6-08dd39b9fa4d
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jan 2025 01:21:48.7164
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iT3IiPWujcvMpiU0QOzccxfwT5dmkAIvSDp1PSb/U4okoYhUP9P95OdA9lbGh+q2FjDKpBfzcG/Pz/ijzU2YfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6690
X-OriginatorOrg: intel.com

> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Tuesday, January 21, 2025 3:51 AM
>=20
> The iommu_hwpt_pgfault is used to report IO page fault data to userspace,
> but iommufd_fault_fops_read was never zeroing its padding. This leaks the
> content of the kernel stack memory to userspace.
>=20
> Meanwhile, although the padding could be done by the compiler, explicitly
> add a 32-bit padding. Also, change the __u64 addr to __aligned_u64.
>=20
> pahole result, before:
> struct iommu_hwpt_pgfault {
>         __u32     flags;                /*     0     4 */
>         __u32     dev_id;               /*     4     4 */
>         __u32     pasid;                /*     8     4 */
>         __u32     grpid;                /*    12     4 */
>         __u32     perm;                 /*    16     4 */
>=20
>         /* XXX 4 bytes hole, try to pack */
>=20
>         __u64     addr;                 /*    24     8 */
>         __u32     length;               /*    32     4 */
>         __u32     cookie;               /*    36     4 */
>=20
>         /* size: 40, cachelines: 1, members: 8 */
>         /* sum members: 36, holes: 1, sum holes: 4 */
>         /* last cacheline: 40 bytes */
> };
>=20
> pahole result, after:
> struct iommu_hwpt_pgfault {
>         __u32      flags;                /*     0     4 */
>         __u32      dev_id;               /*     4     4 */
>         __u32      pasid;                /*     8     4 */
>         __u32      grpid;                /*    12     4 */
>         __u32      perm;                 /*    16     4 */
>         __u32      __reserved;           /*    20     4 */
>         __u64      addr __attribute__((__aligned__(8))); /*    24     8 *=
/
>         __u32      length;               /*    32     4 */
>         __u32      cookie;               /*    36     4 */
>=20
>         /* size: 40, cachelines: 1, members: 9 */
>         /* forced alignments: 1 */
>         /* last cacheline: 40 bytes */
> } __attribute__((__aligned__(8)));
>=20
> Fixes: c714f15860fc ("iommufd: Add fault and response message definitions=
")
> Cc: stable@vger.kernel.org
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
