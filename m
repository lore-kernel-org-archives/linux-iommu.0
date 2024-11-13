Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C38561F949
	for <iommu@lists.linux.dev>; Wed, 13 Nov 2024 08:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731484854; cv=fail; b=gKRCNEjEPmamSUET03KKYE1P2QWjzvPdsUtQwsc46Nq1KE8+M0K9WseJTV4H7atwViySGpHd45F+tY/i7mGhY4uJ88t9lLGMGh0GO/q2LZFPAb2IdOQP1naJlgUOgvX2BmmdMAmvvut0QllGz+1GbfD5TqK3uJXKIASlgfhahzU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731484854; c=relaxed/simple;
	bh=yH3lFGMyuIR3uMRQDhcfqrpAOXDDNY4Z4xID7Rrr5ss=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RP0dT5vNfNWuTZsRIAfFqi13jUCwiTeQReykubJ4NuPDY/oVoJVZHFcs1kHf45krSjdHcweR3JRYhBvvgcHs/5nYLRS+OHag+r9flgiGu0Lbtu6hXhhCnFri5VYTQaC4Hkfy0g77e4F765KxWk9m6wpW5Bv7R5cgDuOEm/X071E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Tz2QmGzs; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Tz2QmGzs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731484853; x=1763020853;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=yH3lFGMyuIR3uMRQDhcfqrpAOXDDNY4Z4xID7Rrr5ss=;
  b=Tz2QmGzsR377gfs7lXwIZFN5hhcTh/kG5Jg46TkqK+jUVNPN2Wx8nQ5z
   pt58BX8tkIB8Qsu0znhUK5wUce7KRKOJqxfMIWaXfjDhiFbKNFvqpkvME
   2qp9hsnFNiQcQQ+lcLKxEnZqVotPSR2GF3YEBtEkeQun4icrIy//y16Ry
   hm6Ds59sq5VA2jp3MFeG053zE0AT6O2iv0DVrDMWEE3dqT+PvPfBAlC+p
   wEXsYIFVtzUlg9ENzbrAQLrrY7Ty874PCw3QUo3X8VzTRYOOeEKU8PfaG
   NJTY/iXTNeSJd1VU3yejPaVPBAuG+Msob8rCm6/OrAlwKEI6h1FrUfFAX
   A==;
X-CSE-ConnectionGUID: spbALhliQ4K8pKz7bLA5CA==
X-CSE-MsgGUID: utXGPQlMQN2UavcQUWlYLw==
X-IronPort-AV: E=McAfee;i="6700,10204,11254"; a="34235776"
X-IronPort-AV: E=Sophos;i="6.12,150,1728975600"; 
   d="scan'208";a="34235776"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2024 00:00:52 -0800
X-CSE-ConnectionGUID: gTxvrawJTTeccLwpfk5WPQ==
X-CSE-MsgGUID: XNL/FFObTgqUxJBs2gg6lQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,150,1728975600"; 
   d="scan'208";a="88607162"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Nov 2024 00:00:52 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 13 Nov 2024 00:00:51 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 13 Nov 2024 00:00:51 -0800
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.46) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 13 Nov 2024 00:00:48 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sif2V3bZW3hdc7340Vn8vkUQaiIQpj7C2Peqw5M+UvmIOOiep/kClusHhOtts/Lc6jpaW+Iuk7zp1Ece72jQ35KXFZ1WFFTpP3BHRptsQV8882E4nPN+/J4pJGlTB4ty+1HMXv6oK3xf+M78pSpEqUQG2to1QECtMqjf9qkmH4NZvDMyyh+YdUMj85Dsrn5+nBjswnaXKp0GyA8rpZD1zE1kefA7AQJ/IK2oYi0YG0xRyFy5fnycQnxacFPf1q5Mi7Kf0m8MtR5twqPSC7YZOgh/tp9+5Ot4me1MPlBFHO9iNL2ryTd+YZOyipYcbDgWR+ezcKCp6ySePXJPmRDy6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9dFJUX9himLUNEMigKk79ZQOUN8aCqZeBaHMebOCq2M=;
 b=kikAgnUNNh/qjMg7sovWkUhQmfZeOSrPJPbgTB5W03rg/paDYb7/Sc6MTxrWmfXBE8NJRfOXz/+dpNq24LjjKbE70eS+LE3wgs9DgRd3U/i1onsTbIvxLi3bvqC7xObiG8LkZsAxd3eDiRH0DYcUHIqHB8Wah+GX8Jz6fk2cOT/2gRUmUYtVRKyZd6OR2NGqJCm9P46oYW+hxTmHnX04tLVeWvjnEUeMn7hjhYyNNyI6u+Ju7jc3Wju25wbXOvWcBPq4Tub6UEHySDIL2iAbX2DLx5sFEuAqjIu+5Y8shJl3S1v8PZOPraWVzk3FXfVsRRHqwyZX1pUtt7XG6Ao5wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SJ0PR11MB6790.namprd11.prod.outlook.com (2603:10b6:a03:483::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Wed, 13 Nov
 2024 08:00:45 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%5]) with mapi id 15.20.8158.013; Wed, 13 Nov 2024
 08:00:45 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Steve Sistare <steven.sistare@oracle.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>
CC: Jason Gunthorpe <jgg@nvidia.com>, Alex Williamson
	<alex.williamson@redhat.com>, Cornelia Huck <cohuck@redhat.com>
Subject: RE: [PATCH V4 1/4] iommufd: Export do_update_pinned
Thread-Topic: [PATCH V4 1/4] iommufd: Export do_update_pinned
Thread-Index: AQHbMV6f/kRtkuek40OiMPsqw5Ee5LK04UVg
Date: Wed, 13 Nov 2024 08:00:45 +0000
Message-ID: <BN9PR11MB52762776AB5354B8CC6419478C5A2@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <1731016017-430373-1-git-send-email-steven.sistare@oracle.com>
 <1731016017-430373-2-git-send-email-steven.sistare@oracle.com>
In-Reply-To: <1731016017-430373-2-git-send-email-steven.sistare@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SJ0PR11MB6790:EE_
x-ms-office365-filtering-correlation-id: a8870b6f-4db0-4507-4319-08dd03b94752
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?JIGd4yXo7YmImQAFIECH+aASm1xZ2vB/4NSjMGD+0Ig5dO5w7HJgm86T6t1d?=
 =?us-ascii?Q?6Ymiv2n6q4+17Hbczf2eWxf7jtrv5Q1R2KeYmiRxW/l4XjGFShbNAD7Rydlj?=
 =?us-ascii?Q?Nf7IPLYdxkAsTVJ8/FiSy8ll0wb8HlbH/5ir3tT818AmSZ4k+t+LoEmgEWVK?=
 =?us-ascii?Q?gff4/0Ik3i3VsEBmZsNsS4sQa+FcdjiRlSNtifOmoM+EsJVV9GkiAJLzTXOv?=
 =?us-ascii?Q?MS4fRU1V+xZ9i9cMJLjWdCtplSpJmWt01NYP8VA32ZPcpfsno/7P8NQhuDxQ?=
 =?us-ascii?Q?GvTyB77TzilVwO/+QmbB/Cy8dQIBEjd5wtDoYjo4h3nWGkVSIqJRP8krxtJc?=
 =?us-ascii?Q?P/wjLBm/gn8sZPM/5cnnfo/d4UKedbeanPSnpFis/2gbKeLCGEa5uXxqvhpI?=
 =?us-ascii?Q?gMNDOvJOYyO9QCa8jEzx1WZnTH/E3IRtQJ+ehTduHP+xQ3VG1PfHxgjbLq2a?=
 =?us-ascii?Q?GyYqtlK+k4YS/9GLU/iK8DS0Omj25g/59Ti5BwfsY0VIQmbJxLWHO0FMCAR0?=
 =?us-ascii?Q?6GNLoCh08lWp+v9+yd/uWM6UL08EF0anloXEke3NtPf4tuRg9wtXxWJ3ULqq?=
 =?us-ascii?Q?P1KXd3GEMOtzxMCtqLAKWdEuHhm72aP2yvORAoLlsLFPM7n2lEblhF7vNvr5?=
 =?us-ascii?Q?QK2neQGnpK4jJqSERJcY15meLfTEx+tI1sgdFn2kD5SF4+4UmOqhtHx98a7R?=
 =?us-ascii?Q?gFEWgCQ0wLyOphd+qyk6qyTRqFFFWHfgNo0CVYeyiOyBs8l5IVvVB11ECzY3?=
 =?us-ascii?Q?jn06MVrHgXBNLTlspw3eYfo73MlIzJOmcLE7kaK/e65J/GjP/GeWKoL0PKIg?=
 =?us-ascii?Q?/G7f2GmrlKv7MFyoIzz0GLzPFsBMWZoENXqRbn+iJAB8D1h/srd4SWGSXzT6?=
 =?us-ascii?Q?a2J0kux+Y3Ps/Gdp2mOqOTmClFBNQcP5aMWB/v26UZvAwidRBcKXaHspHItx?=
 =?us-ascii?Q?DwCHpqxqd6C658r+SMuzRlonpGCTAPt5zNZMwB5WcIhdhU0SInZkaOV0z+GC?=
 =?us-ascii?Q?TBLRYn7QnQMdNYitMjfwE82ANZhkIFMFLiHHUECzq0eNaULkFB965G0VvRGF?=
 =?us-ascii?Q?AaSgsb9VCq+MYySlcwbEvZWFW66CIqllE0Gr8yXfWURegEmgL2Q2nHp2TmgV?=
 =?us-ascii?Q?n4ogJN5gnPb82zNdx6r6vuzCKhtHjo96AeD1skXjQiwsJI67Cfg0sS8aulcZ?=
 =?us-ascii?Q?vtoFZuOG00bdr50z4e/8k3v48gDgmn7WldRIlUAGsMBmfAMsKL4oIOVwdWPx?=
 =?us-ascii?Q?uJVq73SdS/lXg6IzmAeia/oPNNczo8BATFLFWvjicokGa4/1+zE9lWSlxWwU?=
 =?us-ascii?Q?bHS+9dXRSD7pMIKayq/JRDW39GJ2zddtGlQ4Nat/5ZByKM2BIEI8h09E5Ok5?=
 =?us-ascii?Q?RFdjSYU=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?N4YROdVo53CAfsw1ASUxQlu9NF/8viaS0crnG0hk5+oUTlRR7H+tOJrO73CY?=
 =?us-ascii?Q?SJcZc6tstZSbu/dk/SXd24wfKbumbZHPJNLg6odQjzMZ0VOWDyZ0zjEe2cjX?=
 =?us-ascii?Q?Y7tCekKagAM+JWx1sMeBm9fcq6uE7OIvX/5bb3n2qJzDSy1tVe4v9ijop7KM?=
 =?us-ascii?Q?AUlvpsBSGM1pLR1fMv5G3h3ECX94DvMHHRdHHWOkCxBsXxRj/czoWa/nbbu9?=
 =?us-ascii?Q?8Uu/4oabpWoegdP00CQK6jIBmk3BIE9So8Fw0Vmq5Et8vjOmVWLPCrQdS6kK?=
 =?us-ascii?Q?e6FNwz+QQhptG2kmb4AKLZjL79lqv0x6fE9+T5ey+zcE/S0JLo4/5DWphOpt?=
 =?us-ascii?Q?zDWD9qoKzf5/ij8OIdsNnhlQgKRd8zvQ32lDXU5zKwnoBKDnTdpEyAs99F5a?=
 =?us-ascii?Q?a9yRZvjMpGUXvHcbkDm7LJZmh40wjdiM/RGcf6OgFJcpaqYdE57FAHc9WmCt?=
 =?us-ascii?Q?ZMx32tNuNVETv80TbtejCBLPZyMM5SMZwaUDTH5nPmZXFoHi3F1OIjCV5DYj?=
 =?us-ascii?Q?xKzdWDLAWMlW1TO3F51eZFPm5mcMLSpud/arZs4ueeXj+8lJLqflCMhbEXnT?=
 =?us-ascii?Q?lhjV/k44ltJkxNU2nOnZsljji3xpYFFy/lNTxuVzFz1hbfCEGAm0hszvS62e?=
 =?us-ascii?Q?0r8QFjfSq1X0WSjUZ3CqeFqOOUAweSoEICDT2/DwNzqOwdf+yWPYBDnFOiND?=
 =?us-ascii?Q?Ti4zQsMlvqyyY/nYLZs9hEPFdjiu81hx3hwN7DEeHnxcx/yEzxmVdtpGIJ8d?=
 =?us-ascii?Q?hqqku4O4LBC2pzhmMpa8LfBQw4agx1Fz6wA9PlnbuUYylhxQtbiDoCVAq8mG?=
 =?us-ascii?Q?Ryr6HiYJbuVBdnYJFC1rLxqqZ74nLCrfdOEsouc2P5xQb4FEH0EJYwiGd3kR?=
 =?us-ascii?Q?jmkkhns7K6oQgzEiHkTSfuzYZHoD/vSoyjkTvFL6U+mfXMkouRBN9+zb/bUo?=
 =?us-ascii?Q?GdaPg8bZ0O4orKtqJhiBX5qlGpIL771sbHarwSMtIf/mD/+IyIu3CSCQoZMQ?=
 =?us-ascii?Q?dUcxuHhxZl4uCIuOHqzIsnLbGR0Vh8rtFJW5pGbPVVe6Mdr8eR1q5msQPqJX?=
 =?us-ascii?Q?Ub/DjWsCHMAs+DSnJR70FcFOStRHIMiX4OGXm9tIleCrISfWhKO+dP7pi8Rm?=
 =?us-ascii?Q?stHTK7+zypzmd3rxG/bK2cLoGhjlRe9JEvLRD7m0Ug4uOjVpknmBYjKo1PSR?=
 =?us-ascii?Q?EzDom/1m6H+ta6gbQdZURn3Yj+KleDEzo0NlGekI54mfq9/6deZNr7t25BFP?=
 =?us-ascii?Q?Rm6ZV6mV6e+2xCVgDTkkJEMAMNigswc/gtAFmTgy8Ezo8KUzz9tPxsB7F3R9?=
 =?us-ascii?Q?jldWzW9CLEQZwZOvhWPwoRuej3jMLT1GTvrsWVL5ljR8OPtaLuy+jwsJTKdl?=
 =?us-ascii?Q?IJh5koO4hBj4fjmslRqsfLH3TypCvCoiBIvRAUuMWfj/vSZqx8sPQKIB8RDU?=
 =?us-ascii?Q?v6ZzqKCwEA3JevAiKuVnoeCWltfmFWzE3R20ajI8NW0eeqcKyMlH/mstj+yb?=
 =?us-ascii?Q?fRIvs1oJLOFmwDHrTZBeBYiQ6fc8UxrP7EFRbL/YO14vG+KCKpyoegyoc6Gv?=
 =?us-ascii?Q?kpaJHByHkyhljqFmr1YD0F+frxJd0ih87aJb+zVu?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a8870b6f-4db0-4507-4319-08dd03b94752
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2024 08:00:45.6290
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: adk+O2RzzJK84lUIt+eYh99/Hb/Qs4q0wvgaaemcEXTLlksy1aRT0Yd/+4MjLFl+m0ON5BjtFAOi1V73lMJoWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6790
X-OriginatorOrg: intel.com

> From: Steve Sistare <steven.sistare@oracle.com>
> Sent: Friday, November 8, 2024 5:47 AM
>=20
> @@ -985,8 +985,8 @@ static int update_mm_locked_vm(struct iopt_pages
> *pages, unsigned long npages,
>  	return rc;
>  }
>=20
> -static int do_update_pinned(struct iopt_pages *pages, unsigned long npag=
es,
> -			    bool inc, struct pfn_reader_user *user)
> +int iopt_update_pinned(struct iopt_pages *pages, unsigned long npages,
> bool inc,
> +		       struct pfn_reader_user *user)

iopt_pages_update_pinned()?

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
