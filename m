Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02CFB360EF4
	for <iommu@lists.linux.dev>; Fri,  3 Jul 2026 06:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783060530; cv=fail; b=hzI6cYrbG22zDAoAkZZr0H4XxyIomQSdP05pTii2IOYx0j2atPxBIvrMdaxAjPqtwqaIbL+ZVDiD1SMPfRIez+d/2HOMS6VZXRDEPy+Eb6AXW5e5KrC/Sjqyl0mvUi0cBIactLurFMffL7Sz4EJdc8D0Q4bVwaUD7q++YHT7I3A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783060530; c=relaxed/simple;
	bh=Z7+MrO/a6TS4NBrmnZVa9uvz85kZoR4w8Emxn/U0jBc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HrT855AHlfL3wx+1zuhg8BQoiR5ULAAx13+ZFw4xkAHsc49r9MEgLLmajoy98RWwuRokUvBPW+nLWBgR/ZlBrLYI1RP/ZPYYZ/CpHzKRUY2TAU6ipWPiBPk3L2LHS+YyTmjJYBG2Aa7CFwZz1hOUfYMB3oiQvYggJJmdhIehFNE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G5yYJ95P; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G5yYJ95P"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783060529; x=1814596529;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Z7+MrO/a6TS4NBrmnZVa9uvz85kZoR4w8Emxn/U0jBc=;
  b=G5yYJ95Pna5V+uGeD/3v8aZ2NSuUWxwM1zaZrWByhyUIn6ecEohhTSCn
   jN1NBW+e9LmEt7u0R/DZYyS3ArN+JLex2TvRGvQ7z7NhevQ0r+tiAUbg0
   4jYRUZGiBkBU79gXEFCRH3Zqvhy9vJqQwQILHFOjtf220Jhbq89jdooQS
   xsE9FqhbByIabgweV5y+4aXI7n8zddSzdipBFpgLJQIpQhCvfgpXcjZxP
   mb4VXQK2H1oOD9h/wFKWQ2AJU53ZHrCWIRwV1770AtZuTc3WgXM9KRHIf
   u3Ahf04DuMw+VSaQImqqnFsot81PVkQ4pqVnaare7XSi9lfDJLLqMgLyn
   g==;
X-CSE-ConnectionGUID: eCer3ktDR5yBc8tl8P3uKA==
X-CSE-MsgGUID: aPj8xpCRT2KHCMsT5QQSmQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11835"; a="94963964"
X-IronPort-AV: E=Sophos;i="6.25,145,1779174000"; 
   d="scan'208";a="94963964"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2026 23:35:29 -0700
X-CSE-ConnectionGUID: IIbWet6MQ3O07FK2MpV7iQ==
X-CSE-MsgGUID: mTIiQiauR7imgPbUH0ym8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,145,1779174000"; 
   d="scan'208";a="252583546"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2026 23:35:28 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 2 Jul 2026 23:35:28 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Thu, 2 Jul 2026 23:35:28 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.32) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 2 Jul 2026 23:35:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KiAGaeUNnNahvSVh2TfSXZKC4E3StBud3GGLZDX60+bue1/SJv3mYK1GwvY2y3FBIkBLVsfCoahFuHRPY467rNMaEPyuHpG4zbvr55C8nGtiR2wIBCtUsQImXN9ez0aQ41bHtMZewhO/vUx2fJeMPK7k47GJGmqCu1WuBy3MrM2KXUCYtDH/h5JwE6OcuVfZaw1LGJ5ZX/nof5PR4EU6kvckr6Y6ppQpDJVN408tvVAJpZsNraTlPeAsJ107jd3/eZscwPSOQ3aAhToqgm3HLeu+6utiiP//ClhFq1Bj7iRIJPe4Ay0h03QpPYGwBRr1TuJxjFNEdG1kA816xhSX0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3bOCDQNALq0eceQLMw1RZekYFxj/hX1cwFIYGhDhQJo=;
 b=txdwQ+kI7xZqs61U2dIt3Q2Jmst1/wDArVHKpsUlK1d5vFGrtRcH148bI1VGf4wMIez9naJjGwPozuqlnTSu9jBBYRlqHVxLD9Wx4HT2KKTJ730DrarF7clvjLDGlQOftBZ1rpzJSstXKFRtdwIx4JEZAsIFAto/xakX6QTuERTYC7nBy0H2MLxTKjVI8LzTYzGcwg85BHRlo5su5M5zigU3n/AqRpwvswla1+c3a0AZwF7XqdjHRzU+5SF+VaiTP7HJPMjwZTL6lNfIGhze8AY79ju9U1HKwkBMm1VZMD0IMAYJljigkUuBXAuGQdzM1/5oxmpwNJFFge1K+w201Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SA2PR11MB4844.namprd11.prod.outlook.com (2603:10b6:806:f9::6)
 by MN2PR11MB4663.namprd11.prod.outlook.com (2603:10b6:208:26f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.11; Fri, 3 Jul
 2026 06:35:25 +0000
Received: from SA2PR11MB4844.namprd11.prod.outlook.com
 ([fe80::61e5:7b38:b8a4:1abb]) by SA2PR11MB4844.namprd11.prod.outlook.com
 ([fe80::61e5:7b38:b8a4:1abb%4]) with mapi id 15.21.0181.010; Fri, 3 Jul 2026
 06:35:25 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Nicolin Chen <nicolinc@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>
CC: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	"joro@8bytes.org" <joro@8bytes.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v1 2/3] iommufd/viommu: Publish a vDEVICE only after
 vdevice_init() succeeds
Thread-Topic: [PATCH v1 2/3] iommufd/viommu: Publish a vDEVICE only after
 vdevice_init() succeeds
Thread-Index: AQHdCAyrLrj+ab7pbEuqs2uJZrNK6bZbW1ww
Date: Fri, 3 Jul 2026 06:35:25 +0000
Message-ID: <SA2PR11MB484418FC5C8B29B1E7CBB4268CF42@SA2PR11MB4844.namprd11.prod.outlook.com>
References: <cover.1782767110.git.nicolinc@nvidia.com>
 <8f29de140d86bf507f71c6c27aee8e23e1c3940d.1782767110.git.nicolinc@nvidia.com>
In-Reply-To: <8f29de140d86bf507f71c6c27aee8e23e1c3940d.1782767110.git.nicolinc@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA2PR11MB4844:EE_|MN2PR11MB4663:EE_
x-ms-office365-filtering-correlation-id: f08adc2c-16ca-4eab-f87e-08ded8cd43f4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|23010399003|1800799024|366016|4143699003|11063799006|56012099006|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: TMk8SSOU9I6aIcuvA257pRF9iLOoV+z7DCtW0EJEltlhvkJ6lfxfjheXiTvDHGjmDKWvddq/wmY5QqFXSkAqSsjxEC2HPspIj+FTPFzmQwx+G1yJLDnVcCsbbq+SPve4SnWn+L7KbJiYh7pfCAGwy3/T/o7KWIJza0bRUsmF++0r+1lr3j9Js27ay+18peBFz22vwjGORTll/+EvOqAOQhHDcevbCF9h05xLpYKvt3YT5bdXCZa0rNftqcbgASeaoI35QkTA+URub8WnpfV17DIaks3YdiLhfOn9/Bjg8YFzWv4JXTbx3kvio5Qb04Y2az4tb3/gls/GTylaagKQXxmrVxpdaRaKNS6jn7MRvHKh1ST1xiUP/yLDYa+UUH0Gnqzc+YPtaQLQ7mCf8bcf8KywJ2Vq7QgLqTFTuzLXgC09rO7utP+QmgODhL4Gca+iljznI6rN6bUZ12rHDfMvCQ/myCDX2D6HxQ7B4xVefOzEZqk3cFkBCPtjRlg4yj5wxdc7a6m0faQViTDqQVUl7yPxXxJERKbKpvuGvksoR1MiALLi4nmmgjtkXTQkvni7+UNPhMquBt2LbFc9GFtF6EKa3iPAu1C1g/6SlWj+noZ2tiZpAXES3XallLOmPbKNT4jYvbR2DSbbyjWLWfANvBmsq56MoTOGp4Yaclmw0Uc8qfICjJSh86fcD/o6FBa2mzSocLxx2SseXjxQM1zz7hFaOWeLYd4IA7iaHT92vZM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB4844.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(4143699003)(11063799006)(56012099006)(18002099003)(22082099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?rSJWlQGSSSMblZOPTvx3siKztGMol+uBXOBdw3iR4Nqe1Tywpo6xSlBPLwdf?=
 =?us-ascii?Q?wN8gJjwNOllDpOL0SPxq0FTTSo/HQEOUba/1CYlIBnOW4QXfbg2LR5nDwvyn?=
 =?us-ascii?Q?C1SSnL4e6ReJtY/g/ZKOqmqjYZ/zNpSCyKRrzAPcsqqy7QA/eg7tda3lFpq4?=
 =?us-ascii?Q?PDkwGK0tV7HozRQzYFgqXT8vYPQTIodDDFxhUmfa7cgaAY6kh42HKfJpl5L5?=
 =?us-ascii?Q?htEYLQj2r7EKVEXI09fZC3UXm14QElreL1MpJPyEtK72MB6qzCvYj2Y12P6a?=
 =?us-ascii?Q?B7m3oFOHqeNF3bjnW6GWJ0AqXWqWTCRu7y+TOpM7QNqsDKduz8mh8QPqtKeB?=
 =?us-ascii?Q?14d8Stx/9l6cs5K1tDCJeFWnFAExkmb6aEI4rK5DA9vymtV0ZZezHrXXh9M5?=
 =?us-ascii?Q?yLoEoceuKmXBIjpP4vNWR6/Vrb/8RtzYcRG9aB/yFsg3M1v1wak5gcr8vxGe?=
 =?us-ascii?Q?VntiPH9uGrVstEHSCZNLdspR9f7wtmidQjcqi4kYLc5SJJ195+ALDqVoFYEw?=
 =?us-ascii?Q?kKrBSpK9O8FaaCgJxug6y4KDiZ0DmPLRhYfV16owIkDZdx0k0uV19/mS909S?=
 =?us-ascii?Q?98fO6KnWjzgc8i4s5OUTgSZJS1SVJLXoTlATSCVE0yz5d8pefQGP10sX/ru0?=
 =?us-ascii?Q?RhfZy/uo5YcX08nkCY7afhueCMdxrHHHBY4R0VRSzYO4P2+5btFuduhTOV+Y?=
 =?us-ascii?Q?1Frshgf3nGYajl1q7PjLxZtDDpMYO7bUAKQE9339YQtRFlzwtwk7XuOzWSA2?=
 =?us-ascii?Q?HnOGreq9pUnIB2KXOkUunxhqhrtuno9GMgM30UiGBdpBwKnRu9BtZu+cVlUx?=
 =?us-ascii?Q?Sio/KsvYFggO0FnusPpsJz3ymNlsxkpBgiUkmeWw4Wz3jvxiKBv2XJc8b6M2?=
 =?us-ascii?Q?XWy9NqAwDMnwZ7EwmiwDYVe8iaUkSERfXqKXOL6OuRPoabNBLdn9cHRhaM1r?=
 =?us-ascii?Q?jdHGj1LrZ64mDjmcHsDzmh6c2Mx0n/autL4S5tswhzQl2e4dxr4ESEU9H5Bt?=
 =?us-ascii?Q?edYj5y5EtsDCctE1iMbCjNiDFyZNdZ9fRxnuSx30+uQ+Ji1x9I8UOK2fb14w?=
 =?us-ascii?Q?9SiZNnf04HPMH5u2bWA0Mlq0IRA1CbmgGKDDillVL/7Pd0U1YCaHIjPt/Mcb?=
 =?us-ascii?Q?j7lzU41tnw2aT2y0mhYgttDngjX8APGvgwDXrNkgrdYLxxc7t8A0qLF9XesG?=
 =?us-ascii?Q?gZiUO4j7wspW7kLAVn/EiKdSVR8BXpXKHl4FtuYjHbOajOfJM/xFa7Om4HxE?=
 =?us-ascii?Q?LMnS+tYrn4rO+jS1zAb/T0NOmbE1Gm2UUVfVQG1Jqfh1QZvKJD1B9OhjMg0P?=
 =?us-ascii?Q?5LdKVfRq5wP1C36bvK0+eO+DYLBPmut57ERtrkN4jaKAzS1s9fyEiwKmLmbe?=
 =?us-ascii?Q?JtAbar4NBug43d6XHQ+2+4WJNiYZeMJfxjd3myGfuWHUYm7dv749Ppcr9ZdC?=
 =?us-ascii?Q?1E6FIsUETtoZWF9eTTM5fLNPU8B7tZOVpUUsOTsr5FM6aCZNJsRIuXaOIu0K?=
 =?us-ascii?Q?QRktgTJk7gkHfqkIR6+GB9XQ55p5JMUsOeiwsMO9V/KJmxfzQTEagMvH0xI/?=
 =?us-ascii?Q?NniOVWOHaqOI0bqKkDpXD5HUNVFtZfOl78IKuDfugD8CIlcCuBr/l/Ojoimy?=
 =?us-ascii?Q?W+0D37CPK84sNibMdA4/u4YdmLCgeRUcxSDNbwF0jPthaYShFJwgeMGKrfhv?=
 =?us-ascii?Q?wzEU6DUoutOW1OWX2SAUVzHek2RcduoIWYOWsbBjUbX9EQay?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: irxBW80l157JVFmX0VB6X3WCbIL9AXkJ+xtb3/vIpFx3bEGrk+yN2wr2SHZ8/P5t9TEclE0NWWjKKD8yR0/sy0jBGIo1hJYkhFjevz9t000GzWJMrXAQDXuCy8gbxFza4cAj4mBIoIHh8X7knNFqSq223tBH/INVDfcXiA7wCtY3oqNrquwKH+AtOOJO+7KzgGR+a9cODPPvIjxIwIgMFeiE+Jaya9HgfF8A0BnbnySiFISgCIozlnRdhwB+VNREctYCJEFQp8j6KZhhLUfCK9/Y/8mFGSyMeWN65KTxLtqevnuUFxjaAqwrlwZiKJfrhIjjhLDA8tmriPCp+SLZPA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB4844.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f08adc2c-16ca-4eab-f87e-08ded8cd43f4
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2026 06:35:25.2691
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MfzuVNpXANZQwDGtLK7K+I1v09rfAU2qo+RYL38wHont7syGbgQeLjEMbSnfeLx0wrt/wRSbGhZDSg2ic4gnVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4663
X-OriginatorOrg: intel.com

> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Tuesday, June 30, 2026 5:16 AM
>=20
> iommufd_vdevice_alloc_ioctl() adds the vDEVICE to the viommu->vdevs
> xarray
> with xa_cmpxchg() before the driver's vdevice_init() op runs. That op is
> where a driver validates the device and may reject it, but the xarray ent=
ry
> is already live by then: a concurrent IOMMU_HWPT_INVALIDATE can look it
> up
> with iommufd_viommu_find_dev() and run the driver invalidation path
> against
> a device that vdevice_init() would have refused.
>=20
> Reserve the index with xa_insert(): it stores a zero entry that reads bac=
k
> as NULL, and returns -EBUSY on a duplicate virt_id. Run vdevice_init() an=
d
> store the vDEVICE pointer only once it succeeds. A failed vdevice_init()
> releases the reservation, so lookups observe the vDEVICE only after it is
> fully initialized and accepted.
>=20
> Fixes: ed42eee797ff3 ("iommufd/viommu: Add driver-defined vDEVICE
> support")
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>

cc stable

>=20
>  	if (viommu->ops && viommu->ops->vdevice_init) {
>  		rc =3D viommu->ops->vdevice_init(vdev);
>  		if (rc)
> -			goto out_abort;
> +			goto out_release;
>  	}

though correct, this causes an counter-intuitive error unwind
pattern with the following goto jumps to an outer label (out_abort).

It's cleaner to remove the new label by:

		if (rc) {
			xa_release(&viommu->vdevs, virt_id);
			goto out_abort;
		}

otherwise,

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
