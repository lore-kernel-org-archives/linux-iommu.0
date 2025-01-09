Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9CB41FDA
	for <iommu@lists.linux.dev>; Thu,  9 Jan 2025 08:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736411499; cv=fail; b=WAWHuqpuEcucJnAgbOPoOILtiwMD1kjF8l4CmFSSmQwBg1aYwjZtrInQ/xSzcBWE1XhaYI3JHBzvWhtP3b34NEw+gFMp+z/KvSeMhuv1b3NPlMFJdjw8UFUYIkJzFazqu5IkRMLPjjvOyRiHgZ3Eaz8MiUMrVL+2MC3OFHC/Do4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736411499; c=relaxed/simple;
	bh=78IDFd2nvuvfvQPVQCYZB3V/utd3zDS8mlAdah8Kufw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=R46PggYzwKtgiDy6awcfgAMdp3EBTmdt8nOHGbekPJk1Vr83zBnSzkxZ1L3yrtCS1w6TUTKvaz5LXSfqhyRY1gchwsWuiRbwOBwSnJmnsupHSIaudoFPz2Iq4qnej+4635LZ2Nnpc5V1OokI4/sU8l80X8dR8CCVaC+iQgqd4ME=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AJPN2Qbw; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AJPN2Qbw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736411498; x=1767947498;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=78IDFd2nvuvfvQPVQCYZB3V/utd3zDS8mlAdah8Kufw=;
  b=AJPN2QbwBTrEIWFziHNqai/xS24UWzFEppnKYjpSeWZL5LRNKUI2VhfM
   DRcf4DGruQnd69PEPMzw/m9QiPM9LIrAO5ZcQcPzLS6PKxy9aDqeCDVcM
   JWXaZWmcKnASUlvuu+NiO4sATf1WEf+VV+t5qsIk54JSV8M5o9gnZIWoL
   kBYMeWtx+x+nkPcPEyrCxKzboq+Ik3WncNgNh4kaRffqteZoCu6oCWYzX
   mUUU9hSXXrJ0c/LbcXd3I6s6eN+heMQUWzDOvvEQkBubp9R05wyc1PXKk
   SPoqwdR9Hi+pFz0M1JMfgQGM9+QuICPzz8UgW8v7EikEjzqWKQnov1USL
   w==;
X-CSE-ConnectionGUID: jyhT/f3/RgqZXtQSOIeQpQ==
X-CSE-MsgGUID: unZoWoxATXKqdSRK5cc17w==
X-IronPort-AV: E=McAfee;i="6700,10204,11309"; a="48071676"
X-IronPort-AV: E=Sophos;i="6.12,300,1728975600"; 
   d="scan'208";a="48071676"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2025 00:31:37 -0800
X-CSE-ConnectionGUID: 7Mnx//wLRja8Gz8gOtlSUA==
X-CSE-MsgGUID: t8vOBPDNTguMsJSreI0EWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="126632812"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Jan 2025 00:31:36 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 9 Jan 2025 00:31:36 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Thu, 9 Jan 2025 00:31:36 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.42) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 9 Jan 2025 00:31:34 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HHSqOPqVtPb31PpEZpZmfhmj/2BHxC56Rat+m+JkNVN+7//62PsU1pZ5vCuOWExV/DT0Y+BWApHYN3leGyejFw26ThC4Fw4t8qmvssdtZG/zd/RBsJh8o5/qvOAXLQFEbtXFx7AQeW5fQlrlmOQCqrgMy7YQ59ZDZTXPlvHWCeTY9gPkhGU8cJvuTk7SOXctyslTziVwMPOKJ26Ndu3Yy2eOKHpqcocLqKtdvapVycTaFWFS50tY+n4pY5hVbViOn4a0yjD3Q3pTH8B1Ieg1d9Gz5kPVdKPLWL+hyrd1gPqJXG6iSjy85muibb5T7CEkAcYknALuckImzG/SZJ1zhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jm/kfsgnGaZCQe3aSl8Kmj0B1j/HBYCpLvrh6/+i7oU=;
 b=wAUjDsyByvOezVjST/m5EDDUFuU4tpRBtdckHkvQ7ArkNP1qYtZcr9DKpJs0EeHSy4BBFlmteU7aO/iB/dK7ryoLrLAr2+NEJSwKlN8vTEoWr2mVPHwavrQ55v3Ctm1mbw//X2j5IpmELXv9yE2x9QDDykn7ywvtlLVdQFbZ+xVx12qNrwtpTfy71B2WTlpA4DTki2eV1JFAqe0Tho4/YOYW6MR0VPdvmoP9+vVlYoTjaTyWEFSlbee2u5WYfRuGxE664RY21DmOPkbN0xztuhOap3Fnhb38HjhJal22l6+Ee/a8AJKPZldE3jxGNzkERfbYjE6rzb4dAk+5vkzQUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SA1PR11MB5876.namprd11.prod.outlook.com (2603:10b6:806:22a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.11; Thu, 9 Jan
 2025 08:31:33 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%7]) with mapi id 15.20.8335.011; Thu, 9 Jan 2025
 08:31:33 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: "Liu, Yi L" <yi.l.liu@intel.com>, "joro@8bytes.org" <joro@8bytes.org>,
	"jgg@nvidia.com" <jgg@nvidia.com>, "baolu.lu@linux.intel.com"
	<baolu.lu@linux.intel.com>
CC: "eric.auger@redhat.com" <eric.auger@redhat.com>, "nicolinc@nvidia.com"
	<nicolinc@nvidia.com>, "chao.p.peng@linux.intel.com"
	<chao.p.peng@linux.intel.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "vasant.hegde@amd.com" <vasant.hegde@amd.com>,
	"will@kernel.org" <will@kernel.org>
Subject: RE: [PATCH v6 08/14] iommufd: Enforce PASID-compatible domain for RID
Thread-Topic: [PATCH v6 08/14] iommufd: Enforce PASID-compatible domain for
 RID
Thread-Index: AQHbUhnQ3QesZrRPpkS++OQRVd9GyrMOO+jg
Date: Thu, 9 Jan 2025 08:31:32 +0000
Message-ID: <BN9PR11MB5276D87BD7EB3C043EF370D08C132@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20241219132746.16193-1-yi.l.liu@intel.com>
 <20241219132746.16193-9-yi.l.liu@intel.com>
In-Reply-To: <20241219132746.16193-9-yi.l.liu@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SA1PR11MB5876:EE_
x-ms-office365-filtering-correlation-id: a184e48d-b2c5-4b68-71ab-08dd308805f8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?T/+2jkx+mD35QyHSFEEJvx4xQoXOjGW8Cjng7g91PMKwI1XJUrjpiiSrDdxk?=
 =?us-ascii?Q?Osi9m+QTFarWRDfnJdJhxmPxOu1txSJoOgxEFyjP7krmdXdl/vj9nERu1n7M?=
 =?us-ascii?Q?7I4xNxos9nOxM4JIlr9/TmG9luEuup+EnnnUHKR+psPQv4GZjDAcXQVvwoJb?=
 =?us-ascii?Q?mZB00UfBwWUJFTYU5D0+KrBskS7hdUJV4raq3KZv3DtknG+lyCGgqpyNfuzi?=
 =?us-ascii?Q?5k4qNnQvirhWXt5ClJ2uuFfLRO/KPeOa2QVcWnFJ2yphzKsJxvXAJ/NAIF92?=
 =?us-ascii?Q?T5YuHTukL2LkDgYXNwec+iTcQWfPzdy8sMKd+oTr2WWmNfjYgX/rgY6wIMK5?=
 =?us-ascii?Q?t+2S+pnp02ZmLZRIxAeGuXLUf9ad9ZHg+fq/vyD7bPrLsVIWmt91RXUQ4Wza?=
 =?us-ascii?Q?P0iyPwXxC482h2JL67Q/SZUV8DvQjGgAJDobTUN6CjRi2aBAJJwe2Q/11Kww?=
 =?us-ascii?Q?N3c0VRGkaqpzgSkLb9T8hJgdHdaCnDPchGky5ajmDfP6AhAEFPXq3EN2eQ6f?=
 =?us-ascii?Q?9KFH9N4jBtDNhyUPFKewCxaS0AHeASYKU3VH+XW1rBsVG94Vzd01ixvTlNBK?=
 =?us-ascii?Q?7J5QV+b4+NBGxRYIMNGhShI0kuygkGhyz5PNcg2GudKjkwJh6Cuj/6ynb070?=
 =?us-ascii?Q?NTU76HCZVRTk0GiB09OoZyvfxGBOCKe0KgFwa4YjVBYy53jFWUvXijT9aNjL?=
 =?us-ascii?Q?HLJ86tnCwkxMjMMZBPaj4PwljYko0bwGU7dihLH0iEyY6DZ8oX2mopwdWYEL?=
 =?us-ascii?Q?tFr2wtvxubD4dyNXCi1EA8i9bAG2Z+R7NgKEo1NDOkqLWS5sKslHgq+uG1rg?=
 =?us-ascii?Q?FAZgMe2ILBEsBo41zHyQr6oJRsK4+ucPwji6NMEqZc3gX4KW8cT9d9h9mmK1?=
 =?us-ascii?Q?RbdbQLCYPE4sUudkJJp+VMm5lJFm1IoSaznjmSfbcic9YNzGpNFV6Wr2gYuS?=
 =?us-ascii?Q?zLajL3Szv2qzxRhZ3n/Iraa9EQsijRKGC55Lbhx6M3IXnimdtGMfdSk4XbmA?=
 =?us-ascii?Q?G19Q5vrAmoomeWs1UEJPeyOJK2Cwt0ua50enbfqonB5aOisalV/92nY57enb?=
 =?us-ascii?Q?l9vXTBHpAWk5S3+K6Xm8xoASOYK21M4Oyzi6VUsNAW6D3qoUindAmZ8bGFb+?=
 =?us-ascii?Q?jRhHcauA/gWWzNLvGULq8j+Y4WPvgDYMnJKM5Si0Ar9RlDVsAWbrrkGomoPU?=
 =?us-ascii?Q?zdAQxGr2732XPWFc/Vvbv9Aw1OtMfpcQ2VLzty5CszXywcSQowfpgES6K+x1?=
 =?us-ascii?Q?4cLDZ/v2XI4plNJZQt/jhBm93kkYLGJNsPFGCfMZsSz9glZKyVtMChMGAYDF?=
 =?us-ascii?Q?6eijNMIlNKnFS+UnrvALKmJLTJhxnbWE5rwW+6E+1LAii41T+4sM6TOwkSlN?=
 =?us-ascii?Q?Bmg2JnxN2dXjHVmEn64d5fPSet1+OAFkXA1CC2KGY9TG9UiK5KtdjYA00acF?=
 =?us-ascii?Q?g+XQLfCZka8=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ciEHnN//JwXnVcddPWvauypapegBcCfq/xE0dEq3cFR0LKcZAtoRnTk4x7t0?=
 =?us-ascii?Q?YPUfdsKqTIhnTxJrOLoIkPTjlxxpc0DbG8XxHhoQy+KY5a9E3ZZSNI5saD46?=
 =?us-ascii?Q?pGyKTSyWe3ZHL+NKqW7tfOo8CJD1XVEoXSyBASD2/36o6q0hVDhwlQJ7NWPB?=
 =?us-ascii?Q?L5qKqvZoYjqeLykdY/FRA6mPrHCdmzi2CqpMExVfIEOC8IPFmlb/LFZFfEKc?=
 =?us-ascii?Q?rVLx41JDL6mn12ieh/YSrdrAspbla/F2WuupUXB7ciEBUZn9z9Ye2gqpkDQE?=
 =?us-ascii?Q?6u1+AlDoc3fdEo5VlrLGt7J1Q0hYuz+01gqCs0UHWOlRDLzLCAkszR6LyYG/?=
 =?us-ascii?Q?GlK4Q8XEmIDjZpeItLp+wH7bR+4G0g0Xvgi+bOM+N8Sg11eMlidNriGgwi4Y?=
 =?us-ascii?Q?PY5p+HHKq+v67TLMMY1yTbpBcjKodWGqIyBhCPwYA3D3B5gXpYNAIKUoBZuV?=
 =?us-ascii?Q?KVUQ/FQ43Q+iEAH3yLb7HL5BnFbfwliu1D2e9suUL/xpmkaM5X5YrJI/3hZ7?=
 =?us-ascii?Q?t08lotfS0/mCPNp2A8MyhvDZxt6cJKKHshhLOsmceFi9RVT+CR9cN/L3FsO0?=
 =?us-ascii?Q?pvY/WFOw3Ya8b3cHBYqGjsw/LEd3YMHpDG0Uya1ovJ/UtZP+46YrjbXOXn8N?=
 =?us-ascii?Q?0DIaRLUxFZHbwmFT7qzfltjpEOl1ehiw7o4Eda12Xte68H7Wak7k9mmMo9zq?=
 =?us-ascii?Q?san71TVwMNW4RV1bGzNVv/sAg+2wwIbJ5S1moHYp8MWqselNOvdwf/u9m3Lh?=
 =?us-ascii?Q?mkplvED2xlx8h1w4+vMgrHwAuQDcIvvxug7snelkd1nEMAFDTl/xARzls6gy?=
 =?us-ascii?Q?CEUxMg1uZ7N4fdmznmkUNcF1mt52bSyfHn2RmA3Awl3epISgJ9prclP4DIH2?=
 =?us-ascii?Q?De2kprRYPM8VUD2ExXLFRveySgkT6dXxUBVuqBH8ulEh8mJe/MQa+Azw653Y?=
 =?us-ascii?Q?o7K5Wh6GmcW8Ptq000XqGIOpklGWXgd4V6aZRMozKL7Wl1+kuRJ0EcENX3xR?=
 =?us-ascii?Q?yKNkOY8JeKGbt0Y+wi8ynMuO7yGIm7R7VoCOwSGiA9VMf3M1OBfZlXQXIJQe?=
 =?us-ascii?Q?1BZa5n6OOFw0PTqfMPrP8HbTBOOlhlQjPaa1X5AxDNEoEd34HUu5blnM4FHD?=
 =?us-ascii?Q?PybtM1oQirwEwV7KLMtJF5ctwopqZVXkOxbRPFaWFC1SLXZRFxtqVrALluHp?=
 =?us-ascii?Q?06j/YvFBZypip/ayzBr/rYHc5GzH0+SHtUVhe2Kv9dmx1Z7c0lAVXeP4anvs?=
 =?us-ascii?Q?b0BHMeyw5C9Ovg7b7LEHG1wO8Kddr6PvQkK4oHBgoR20MLcmriPhPCQsNBDz?=
 =?us-ascii?Q?nCGZHFO+eDGViDvpHSCAYOTYxQuAD/z03xj8kIsZi87Pjd9h+UoeZLpk1cry?=
 =?us-ascii?Q?hjqIbfWsUTWagdB5jO95eckyC5VE3ngYNhxt6DjfEhvoxlmUYSbDfwqH903k?=
 =?us-ascii?Q?cZHnIjrZ8CDRZRAe3JEgeoVCGYPrIuuk525Nx6oeMiIlEEhgvIBHEKycOfuu?=
 =?us-ascii?Q?CCo8iprnOT5PmRfjyS6LhznD4zcic9KPgaHT7Zgt1Um4usNt0cIsur0vWl7U?=
 =?us-ascii?Q?lsb5cbfuKvHBM6qKHVBn9Qdh5tg2eRMecfraYL3y?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a184e48d-b2c5-4b68-71ab-08dd308805f8
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2025 08:31:32.9983
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OmWXd70429RbYJfMMM7XzUbBm+/Suy+uASO1VW2mJEJlkgSc/16dlSNmyAHy3k3b/giVDBMbfHhpOP5gfXsE3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB5876
X-OriginatorOrg: intel.com

> From: Liu, Yi L <yi.l.liu@intel.com>
> Sent: Thursday, December 19, 2024 9:28 PM
>=20
> Per the definition of IOMMU_HWPT_ALLOC_PASID, iommufd needs to
> enforce
> the RID to use PASID-compatible domain if PASID has been attached.

And vice versa.

>=20
> This enforcement requires a lock across the RID and PASID attach path,
> use the idev->igroup->lock for this sync.
>=20
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> ---
>  drivers/iommu/iommufd/iommufd_private.h | 18 ++++++++++++++++--
>  drivers/iommu/iommufd/pasid.c           | 14 +++++++++++++-
>  2 files changed, 29 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/iommu/iommufd/iommufd_private.h
> b/drivers/iommu/iommufd/iommufd_private.h
> index e9d6bd8b44bc..158d8e6d5a9a 100644
> --- a/drivers/iommu/iommufd/iommufd_private.h
> +++ b/drivers/iommu/iommufd/iommufd_private.h
> @@ -513,7 +513,14 @@ static inline int iommufd_hwpt_attach_device(struct
> iommufd_hw_pagetable *hwpt,
>  					     struct iommufd_device *idev,
>  					     ioasid_t pasid)
>  {
> -	if (pasid !=3D IOMMU_NO_PASID && !hwpt->pasid_compat)
> +	lockdep_assert_held(&idev->igroup->lock);
> +
> +	if (pasid =3D=3D IOMMU_NO_PASID &&
> +	    !xa_empty(&idev->pasid_hwpts) && !hwpt->pasid_compat)
> +		return -EINVAL;
> +
> +	if (pasid !=3D IOMMU_NO_PASID &&
> +	    (!idev->igroup->hwpt->pasid_compat || !hwpt->pasid_compat))
>  		return -EINVAL;
>=20
>  	if (hwpt->fault)
> @@ -549,7 +556,14 @@ static inline int
> iommufd_hwpt_replace_device(struct iommufd_device *idev,
>  	struct iommufd_attach_handle *curr;
>  	int ret;
>=20
> -	if (pasid !=3D IOMMU_NO_PASID && !hwpt->pasid_compat)
> +	lockdep_assert_held(&idev->igroup->lock);
> +
> +	if (pasid =3D=3D IOMMU_NO_PASID &&
> +	    !xa_empty(&idev->pasid_hwpts) && !hwpt->pasid_compat)
> +		return -EINVAL;
> +
> +	if (pasid !=3D IOMMU_NO_PASID &&
> +	    (!idev->igroup->hwpt->pasid_compat || !hwpt->pasid_compat))
>  		return -EINVAL;

Make above check into a helper as both attach/replace require it.

>=20
>  	if (old->fault || hwpt->fault)
> diff --git a/drivers/iommu/iommufd/pasid.c
> b/drivers/iommu/iommufd/pasid.c
> index fcdfbc01dcbb..fdf97f1d71ae 100644
> --- a/drivers/iommu/iommufd/pasid.c
> +++ b/drivers/iommu/iommufd/pasid.c
> @@ -15,6 +15,8 @@ iommufd_device_pasid_do_attach(struct
> iommufd_device *idev, ioasid_t pasid,
>  	int rc;
>=20
>  	refcount_inc(&hwpt->obj.users);
> +
> +	mutex_lock(&idev->igroup->lock);
>  	curr =3D xa_cmpxchg(&idev->pasid_hwpts, pasid, NULL, hwpt,
> GFP_KERNEL);
>  	if (curr) {
>  		if (curr =3D=3D hwpt)
> @@ -30,9 +32,11 @@ iommufd_device_pasid_do_attach(struct
> iommufd_device *idev, ioasid_t pasid,
>  		goto err_put_hwpt;
>  	}
>=20
> +	mutex_unlock(&idev->igroup->lock);
>  	return NULL;
>=20
>  err_put_hwpt:
> +	mutex_unlock(&idev->igroup->lock);
>  	refcount_dec(&hwpt->obj.users);
>  	return rc ? ERR_PTR(rc) : NULL;
>  }
> @@ -45,6 +49,8 @@ iommufd_device_pasid_do_replace(struct
> iommufd_device *idev, ioasid_t pasid,
>  	int rc;
>=20
>  	refcount_inc(&hwpt->obj.users);
> +
> +	mutex_lock(&idev->igroup->lock);
>  	curr =3D xa_store(&idev->pasid_hwpts, pasid, hwpt, GFP_KERNEL);
>  	rc =3D xa_err(curr);
>  	if (rc)
> @@ -70,10 +76,12 @@ iommufd_device_pasid_do_replace(struct
> iommufd_device *idev, ioasid_t pasid,
>  		goto out_put_hwpt;
>  	}
>=20
> +	mutex_unlock(&idev->igroup->lock);
>  	/* Caller must destroy old_hwpt */
>  	return curr;
>=20
>  out_put_hwpt:
> +	mutex_unlock(&idev->igroup->lock);
>  	refcount_dec(&hwpt->obj.users);
>  	return rc ? ERR_PTR(rc) : NULL;
>  }
> @@ -152,10 +160,14 @@ void iommufd_device_pasid_detach(struct
> iommufd_device *idev, ioasid_t pasid)
>  {
>  	struct iommufd_hw_pagetable *hwpt;
>=20
> +	mutex_lock(&idev->igroup->lock);
>  	hwpt =3D xa_erase(&idev->pasid_hwpts, pasid);
> -	if (WARN_ON(!hwpt))
> +	if (WARN_ON(!hwpt)) {
> +		mutex_unlock(&idev->igroup->lock);
>  		return;
> +	}
>  	iommufd_hwpt_detach_device(hwpt, idev, pasid);
> +	mutex_unlock(&idev->igroup->lock);
>  	iommufd_hw_pagetable_put(idev->ictx, hwpt);
>  }
>  EXPORT_SYMBOL_NS_GPL(iommufd_device_pasid_detach, "IOMMUFD");
> --
> 2.34.1

