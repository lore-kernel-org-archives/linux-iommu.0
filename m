Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E19D838E11E
	for <iommu@lists.linux.dev>; Thu, 16 Apr 2026 08:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776326568; cv=fail; b=AaCtkG5+0kHE8uP9lha3OrNPCMyBZ43fwYVAz5Daz0qM02w4PDdTcIt4Ee26fm04t3oVZ2eEocSFAFFdPt7tytSEu+/eUAgYygOI4rEG5mHpNElRDR+M1ZZt3zoNpIt1lLlVaqiDyoB5QKyCWTiChB5+lFuTeiHZtG2pfmnJGNM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776326568; c=relaxed/simple;
	bh=PhGrVFAGCl4A8Iy9EgukhhLbNZz7HU/dLEPTbPWRM40=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=biox/Yum3g9F+SX78lrVbuk+CdwCv35j6Z2T/KeKaM4HVZ7cAZRvJT+IWuHsj09wvA5G7lXGVcEEbVHCZhOx24/fJtLPMSntl0kAzSFvjU8iCdYx4k/CayffFxyCq50YomG/a6d3c6tJ3SlDWsnxbItXRBNK/udp0/eaNG0VMpg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HisU9U26; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HisU9U26"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776326564; x=1807862564;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=PhGrVFAGCl4A8Iy9EgukhhLbNZz7HU/dLEPTbPWRM40=;
  b=HisU9U2694ud3hRK1sIwl8T9QfEHCtgqedBv7eYsvScUS4suoWZbmOkM
   9Lcy4o+UllF7JPV0nN58qhqW20joWaRF16nGFozHVMFhYbccLV/R1WIfU
   uWWejRXXKuHrt/Logu/zMUuLX33s7xXWwGQxPcVDRiVGrg/QsRtw7z8Sv
   ltDYu0ZTlO2yXR3ig3KGXRQvpFIHpNe9KkWBi3lF0RrEwHm4sp45ACxKm
   ypLWoDdDaH211lEqGBP4uTeGsb2mWdLLS1JZyCt38kBaaL8As3lJZmLBw
   MTEIGkxY6YeiqcOAwDjuvO2/4ZkfASCN+RKEGeX0OhNkqORuSHCehJSEf
   w==;
X-CSE-ConnectionGUID: ph2wB7ZIRpqhm6x3gItkAQ==
X-CSE-MsgGUID: ye7dR1TfQrylQr/29UXTNQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11760"; a="77018608"
X-IronPort-AV: E=Sophos;i="6.23,181,1770624000"; 
   d="scan'208";a="77018608"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2026 01:02:44 -0700
X-CSE-ConnectionGUID: Y5uForvqSBWpIowJ8l/lMw==
X-CSE-MsgGUID: lHVyKo+bQa6eIkgon50kWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,181,1770624000"; 
   d="scan'208";a="230508097"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2026 01:02:43 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 16 Apr 2026 01:02:43 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 16 Apr 2026 01:02:43 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.26) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 16 Apr 2026 01:02:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vd15OTSFUYCxii7WZaH/MkAFV8JzMcACTDQiuxLQ/VzpplfZ3sKAQX8lipxOfYna6pvr9jRR57FVUp1JPCO7Ah90s0USf2HEYCEYbDPaDqx11UFrGd6WTTWjpt1eiWVi/xaTHRmy/pj1/2rf27DAt0wjawn/7cwboF0KpMzk0ZYQFBnrlsIyASuPGimz0tLPlWxkimKOPcDHia83P9gvgwX4OkJ8yHhLfcLvGvcqqJvCNdfBZT6C0Gv548lLYQD8wcmGaqFmHMRelpsS0ymqq6fHy9P9P1bmNB+VfqfuhkPz8oEbOrv4q3xmas7YW4ts2s7NSZMGwzyp4l1dfw420g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t2lblrUX1CmCAQrKNro1oIbzYCKZXS3OB2pamzsG/I8=;
 b=g8Lxa0y0+aYMd8B3UKs2Ij+Jbv8mlVyliHlKg9MJOVXu5gZLypAsvCPs5Vb4METzCHCmqz6AlbRx+faZC1huMHhrGmmzihl0ZjCcMNyNCAjVbdJWqPjCYmuztJ5ukXZythZZbcwf7/+g52Zz+PHMHSa/vlpe0dZ3D6vzrV2tmji2qG6Dm8/Kt8LHMghc56dFVcZv74G1GPK9rVsOEpLRaZvGZcylIBlQMqx5FgIVlRnGAL4MM6sXZUJnJPRlH3DNHzgH7VFeZrHbvznQDJ7DHOWmlki++5tnv/O8Sjw32JUAmsUCGqJS8VViby73Zl69+TyUuazMdPSntl9yd1/5Eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5271.namprd11.prod.outlook.com (2603:10b6:208:31a::21)
 by SA0PR11MB4734.namprd11.prod.outlook.com (2603:10b6:806:99::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.21; Thu, 16 Apr
 2026 08:02:40 +0000
Received: from BL1PR11MB5271.namprd11.prod.outlook.com
 ([fe80::780e:4379:6988:f48b]) by BL1PR11MB5271.namprd11.prod.outlook.com
 ([fe80::780e:4379:6988:f48b%4]) with mapi id 15.20.9818.017; Thu, 16 Apr 2026
 08:02:34 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jacob Pan <jacob.pan@linux.microsoft.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, Jason Gunthorpe <jgg@nvidia.com>, Alex Williamson
	<alex@shazbot.org>, Joerg Roedel <joro@8bytes.org>, Mostafa Saleh
	<smostafa@google.com>, David Matlack <dmatlack@google.com>, Robin Murphy
	<robin.murphy@arm.com>, Nicolin Chen <nicolinc@nvidia.com>, "Liu, Yi L"
	<yi.l.liu@intel.com>
CC: "skhawaja@google.com" <skhawaja@google.com>, "pasha.tatashin@soleen.com"
	<pasha.tatashin@soleen.com>, Will Deacon <will@kernel.org>, Baolu Lu
	<baolu.lu@linux.intel.com>
Subject: RE: [PATCH V4 04/10] iommufd: Add an ioctl IOMMU_IOAS_GET_PA to query
 PA from IOVA
Thread-Topic: [PATCH V4 04/10] iommufd: Add an ioctl IOMMU_IOAS_GET_PA to
 query PA from IOVA
Thread-Index: AQHczFO0j4ADkNVwHkehEbq8G0jDLrXhVKnQ
Date: Thu, 16 Apr 2026 08:02:33 +0000
Message-ID: <BL1PR11MB52714A18A767F7C5C1985DF48C232@BL1PR11MB5271.namprd11.prod.outlook.com>
References: <20260414211412.2729-1-jacob.pan@linux.microsoft.com>
 <20260414211412.2729-5-jacob.pan@linux.microsoft.com>
In-Reply-To: <20260414211412.2729-5-jacob.pan@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5271:EE_|SA0PR11MB4734:EE_
x-ms-office365-filtering-correlation-id: 2882387b-f239-43ff-3bbb-08de9b8e8443
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024|18002099003|56012099003|22082099003|38070700021|921020;
x-microsoft-antispam-message-info: o8sO2IvWyUhiSyMtO1LzqAADmYzm7p5pL1oSMfCxIlaWFoLOawiTcVG6jkgCBW7ot/XyWxln/K+I8qDEbYG1XYXLQqMxVZ7mTW7LmjyAksNtFsJPKCeUCT6VJlVr3CNxn2oynIMiA6lmoLfMFTH+QD6wjRZ1CTU6jdLGhLCenSIU93n3kk11XAe8XdwvohEfqpLrbVhZtAx1gdYv6wAz1jyILw+E0KeNQgmzM69qfS4ZZYagpsJCazkE2iJf/pCIUUePkvqekTGFnO2FBRz/bx34P8EGtFHs2GTmwb1IX/eRK7SxacUn9x0H2T+qPqMlWOh7SQP5SI7zNs+hSy+crUsMuwMn+n9hRZ0C3XsbleJL5DQ9e3RMqFQY5y/dyVD9oSI7FS4V50ixN1v9xMvUwck12GMq8JcrLyOLIQtHhhGN+OAlulXmkbwZb7P8FuRGzYJSw7c0ldPknGT4yRGr53d9Iiz+7bShbHhg+e4VGCOTqY213Umviz6GonHDrPcAl5NTuy09bEe7h+FkMvIx//6pON0S9eqw7eGtc1PmGiZRRs4DeQrNdMrCEE02jU1Z55Uo73YKbIcBCFf9cmn8Jm9J1QGDLsTANhtGJ1CYCl3zkn/kri/2BPUplZrH0awxLJex+PvmA0r4NFC0rG65n9d94iJwEWhGvPujeb2mFAxEmX+iprO+R6tRLkW+Edfy1bit3xE0M5Ar0/3wADnph8wDlycc473TB4ipABokJXbRbeKKdyzC2AN+eL9OUTlvcrDBdI41zIh6sKmoM2/rWasBA+7eFaxE0naJs2Kjhv/E04s06sh6Uir/5LhSKWEM
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5271.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(18002099003)(56012099003)(22082099003)(38070700021)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?6tKO4mOiaY6TICnNsXUf45VdV0QvTRCw+DEvnqLfseq8SjGG7L1StKHLFsPB?=
 =?us-ascii?Q?Pfn9Dwg1Aeh513PQvEBcxmgunwb8TA294f3o7h4toc68JENq/tfC/Ch+cVQX?=
 =?us-ascii?Q?DnSN1BXjmMvc6I+BDfT5iXqwy2TpivT8OFmA5P7OLUJWALbCOyjR7rQ+dyur?=
 =?us-ascii?Q?F7NFrqJ/YKq5SoC94BaxT7Cv1KJEOBJVcOPM2eR26zlGlCgJVUEaY+fltAF9?=
 =?us-ascii?Q?N7W1Wjtv7ujJqkrQmaz6xDVNVGN6SlTwW1UGil0DenBNMhxOnbtPAEMWxuf8?=
 =?us-ascii?Q?9tXTfEITMI8LNshN2ocJr4SXmnsOgADWOtm7/LUHePLU7PK1FvcJmE5KhKnV?=
 =?us-ascii?Q?y3synGbd99R9rRWT5zb/c7igXCWi22KNbQUynVjs/XMutRBWicDbM34ZmxFd?=
 =?us-ascii?Q?+WMBmB9C5M6eQWFxTjEUFdla1z41Uqw6jWevx5cB+bHVFrSG4QMb0OdHSU1U?=
 =?us-ascii?Q?WokS0Z5hi0qXjCI2M39yorOFINIjL9eUCOJPTSxz7NYi2sk/yxR6cFQQUXjN?=
 =?us-ascii?Q?Z7ObtIyhyZWvF3k9jjuF8BYmoF99g6tiw3/v+7lRnrEbQzzp8eW6HNh8RDVU?=
 =?us-ascii?Q?3OTbBWgCnuKznZVsCihPjOetIr2eNjaPDctj8xTmj5d6k2CXzr22vfT5KnME?=
 =?us-ascii?Q?cAQK+IejRHqsEqUfaobc0Ko4ziQMs5gCH64HTWrLi2uShdpPoqfCNvpTKAox?=
 =?us-ascii?Q?wrlTIVWIhZMMONyHQzN9WXqVoiPxtG5MA6NuOfUFaekBWkoHnNr1vG13rZMb?=
 =?us-ascii?Q?JdtOmYM0yN7Ke9d0oHZvZLyj0TVwGBpkkSLTVjhpsjF7Z7wUt6ng7qeOrbOo?=
 =?us-ascii?Q?KmUXvmHKsYA62d668KwJL1BtmVnEVFrTi5IF5lJo29wo4QkUbm06aQy5Mhvn?=
 =?us-ascii?Q?hmOjXpoPTALbLeERr5IM4E6XR2eJGg2OUfvd6a+ZFxH1gZcwRz2nOnLup8pg?=
 =?us-ascii?Q?5GgPE4HBtx7BKILOIaPWFknTIlwnMpJEwQZmxZjqft1F0l6F5B1O11xBVRwg?=
 =?us-ascii?Q?JPVO7cHXmVYyoo1YXXW9Epzk8euzTfir6m9PHGzUbdQZhi/qwu/fv0LddzFw?=
 =?us-ascii?Q?R5Dm9jLW2BGSLcDxphCf3GEbcymRrGiw3djfeJBnSkTFER0PWc06tiM6SBhF?=
 =?us-ascii?Q?H0DaLQ3UsoA5nuxaQwHfOxlJeWRUKufII9JhoTHR9T8ub9d5bixwUpfurnM/?=
 =?us-ascii?Q?xLBQwcQEyl+DQk3Tf2bxq7FWkKumcGhde+gRUk1qCQ2mik59thodEKOgnp5r?=
 =?us-ascii?Q?Pqo9D8AYqLq43gtC4uolAukg2mQhuC42Y2iGg3mkTqPyt0WrRLlTglNVwd4Q?=
 =?us-ascii?Q?61JUl3fBwtPUfqsTUQJNc0MYpN/tID1J0Ggortj8Ch0tQRhHrPXtyGoxVGdG?=
 =?us-ascii?Q?9BjRzX752ARf+jLVI+5BMzXVVOZOYS6GnbBwpwciBJ9bQzxqnZFgoa8Xbg6z?=
 =?us-ascii?Q?tlCzKlpPQFpqtKL4McysAMhQ0wmgiDV4+V4EMWF1yqzOHbgDrgVrVjnDkp2B?=
 =?us-ascii?Q?FulTVSwZ7d2gkfgcpG+fmRl8apJdaCLQe4yyfDLliItPMnxJQ0G9nPP+FekL?=
 =?us-ascii?Q?hkut3Ef/3eSeLGP3SnBK0YpbH87sRp+dB7bLKO6EgvbsRaB3gGCsBV8ITIq4?=
 =?us-ascii?Q?d/9xIIlWZTP7pEtOjAEP1DLrktE7stYRM1rjM4as0+fVjByVivr3bUtN/IK6?=
 =?us-ascii?Q?eUdm39d1/wEtt6yevqqGAns3NNbdWZeAdDPASlpBGj1zrLd7?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: BFGZ+0elDI5XMgLquJezp/MNUq6PX+RI20jGmkUEiPlMhKMBZA1aZgyeNQ1pL+7uX2fFU4RehE9UqO09Dl+E3U0VIMMEToonZH8Zj837MXkJYX17g644E9Wx2BADl07dT/nouZxOiB3DXJPaDDRHx5/TTiZMqn9b+d33fN09Sy1XBejb3qwGILkucgwcBnNH6r0WQ3NDlJflX8JF15E9nIj7zyVz2/D/WHCXQyTH2usb/X7eXUy6O1bXFrKymGtIRhL8K8Uth+/Aask6TNUlEA/XeQncqBmDA8rlm8n6lueq7WzbWSQOY77cvAdUngHsMwoAdFWOOO2Q7lKOD9iiJA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5271.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2882387b-f239-43ff-3bbb-08de9b8e8443
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2026 08:02:33.9550
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sNYSyn/c182gSgs2ybrQGR9ZvtAD3Q2/qbhmN6bcCc/J/+0F8xJiD/ch32TU8mifXn/Wo0lVoV63mP3yA8GM/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4734
X-OriginatorOrg: intel.com

> From: Jacob Pan <jacob.pan@linux.microsoft.com>
> Sent: Wednesday, April 15, 2026 5:14 AM
>=20
> To support no-IOMMU mode where userspace drivers perform unsafe DMA
> using physical addresses, introduce a new API to retrieve the
> physical address of a user-allocated DMA buffer that has been mapped to
> an IOVA via IOAS. The mapping is backed by mock I/O page tables
> maintained
> by generic IOMMUPT framework.
>=20
> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Jacob Pan <jacob.pan@linux.microsoft.com>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

Your s-o-b should be the last=20

> +	/*
> +	 * Scan the domain for the contiguous physical address length so that
> +	 * userspace search can be optimized for fewer ioctls.
> +	 */
> +	while (iova < iopt_area_last_iova(area)) {
> +		unsigned long next_iova;
> +		u64 next_paddr;
> +
> +		if (check_add_overflow(iova, PAGE_SIZE, &next_iova))
> +			break;
> +
> +		next_paddr =3D iommu_iova_to_phys(area->storage_domain,
> next_iova);
> +
> +		if (!next_paddr || next_paddr !=3D tmp_paddr + PAGE_SIZE)
> +			break;

the 2nd condition should be WARN_ON?=20

> @@ -432,6 +432,7 @@ union ucmd_buffer {
>  	struct iommu_veventq_alloc veventq;
>  	struct iommu_vfio_ioas vfio_ioas;
>  	struct iommu_viommu_alloc viommu;
> +	struct iommu_ioas_get_pa get_pa;

alphabetic order

>  #ifdef CONFIG_IOMMUFD_TEST
>  	struct iommu_test_cmd test;
>  #endif
> @@ -484,6 +485,8 @@ static const struct iommufd_ioctl_op
> iommufd_ioctl_ops[] =3D {
>  		 struct iommu_ioas_map_file, iova),
>  	IOCTL_OP(IOMMU_IOAS_UNMAP, iommufd_ioas_unmap, struct
> iommu_ioas_unmap,
>  		 length),
> +	IOCTL_OP(IOMMU_IOAS_GET_PA, iommufd_ioas_get_pa, struct
> iommu_ioas_get_pa,
> +		 out_phys),

ditto

>=20
> +/**
> + * struct iommu_ioas_get_pa - ioctl(IOMMU_IOAS_GET_PA)
> + * @size: sizeof(struct iommu_ioas_get_pa)
> + * @flags: Reserved, must be 0 for now
> + * @ioas_id: IOAS ID to query IOVA to PA mapping from
> + * @__reserved: Must be 0
> + * @iova: IOVA to query
> + * @out_length: Number of bytes contiguous physical address starting fro=
m
> phys
> + * @out_phys: Output physical address the IOVA maps to
> + *
> + * Query the physical address backing an IOVA range. The entire range mu=
st
> be
> + * mapped already. For noiommu devices doing unsafe DMA only.
> + */
> +struct iommu_ioas_get_pa {
> +	__u32 size;
> +	__u32 flags;
> +	__u32 ioas_id;
> +	__u32 __reserved;
> +	__aligned_u64 iova;
> +	__aligned_u64 out_length;
> +	__aligned_u64 out_phys;
> +};
> +#define IOMMU_IOAS_GET_PA _IO(IOMMUFD_TYPE,
> IOMMUFD_CMD_IOAS_GET_PA)
> +

Based on its purpose let's make the restriction in the name, e.g.

IOMMUFD_CMD_IOAS_NOIOMMU_GET_PA
