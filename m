Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85A1816F0E8
	for <iommu@lists.linux.dev>; Mon, 20 Jan 2025 05:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737352688; cv=fail; b=DtM9pzDqAtZkKTPk2JpK3bByk/op+9M3STFwaDS63OQFvXPbfl4DuZD0SgEhQeChJVToQcwrQvNkinoo1odh77LS3zaG/76tslrpj67kL0QUtBgYbGwu3JulxY9rtevaSU7b1Sf+O2tvVRShwTAFBTzLLjh0uQMfJu/AHyK66qU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737352688; c=relaxed/simple;
	bh=6ioSwlyLq9vaXRG2P8cLZP7+6TnjSwk+SLeWsc0E+tI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DAZNBK9tsomILCjv6ldtTI0/G2f2s33ILqrmacCBb0FP1cY1pebA5Z/ufZbX4W0aFh7SpmUg2WC6kVfKgSXx3taS6a3pdGFShL7cFFbc3Jp0IBilYSL/uERxTEpgukoChJW5iIlh8Mk4xgI5fZFO8K1i2BGSrku0RlN9DuMpgLI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GX6CBN5k; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GX6CBN5k"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737352686; x=1768888686;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=6ioSwlyLq9vaXRG2P8cLZP7+6TnjSwk+SLeWsc0E+tI=;
  b=GX6CBN5k4JtaxRJ+EgN6C/rFHHMKfIrlI78KymMDnrVlYi+2W6wWgAgP
   Bs4foUKGU7he04yxblwToGHuKpF5jmB2n3Hq889cFW3QfafMIIwZbEwlJ
   kRLPl8oEkcVaEi9wEBcsU6OFlpgdWXqrYV2KRJlt9dU3axvhKKG5v8co9
   77x9FINLFNQPdXEbJniNxPJgyIvN4mkfpd5mOQ7YdtdSVOPJGPUS7f20R
   cE+EBWIpQJWxnYifR1KO7lVuqY4B/qJc+giCbYCJnLzb98eciC/ugUL3X
   QtNrxebgZ1HABrg3CbTu9itgyJh1FdAYofnnBmL/iI952tLV/Spwg1mPP
   w==;
X-CSE-ConnectionGUID: QF84dGIKSqWMo621YSEs5w==
X-CSE-MsgGUID: 8kOcy9GrRW6Gvis9WdFqQA==
X-IronPort-AV: E=McAfee;i="6700,10204,11320"; a="55264466"
X-IronPort-AV: E=Sophos;i="6.13,218,1732608000"; 
   d="scan'208";a="55264466"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2025 21:58:05 -0800
X-CSE-ConnectionGUID: V3xsawpWSgeAa+kGLqJ7FA==
X-CSE-MsgGUID: l19Vx+3iRBCAo5ZMqiw2SA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,218,1732608000"; 
   d="scan'208";a="106228128"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Jan 2025 21:58:04 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Sun, 19 Jan 2025 21:58:04 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Sun, 19 Jan 2025 21:58:04 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.48) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Sun, 19 Jan 2025 21:58:04 -0800
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by PH7PR11MB5861.namprd11.prod.outlook.com (2603:10b6:510:133::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.21; Mon, 20 Jan
 2025 05:58:02 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%7]) with mapi id 15.20.8356.020; Mon, 20 Jan 2025
 05:58:02 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: "Liu, Yi L" <yi.l.liu@intel.com>, "joro@8bytes.org" <joro@8bytes.org>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>, "jgg@nvidia.com"
	<jgg@nvidia.com>
CC: "Liu, Yi L" <yi.l.liu@intel.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "jacob.pan@linux.microsoft.com"
	<jacob.pan@linux.microsoft.com>, "robin.murphy@arm.com"
	<robin.murphy@arm.com>, "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
	"will@kernel.org" <will@kernel.org>
Subject: RE: [PATCH 2/2] iommu: Swap the order of setting group->pasid_array
 and __iommu_set_group_pasid()
Thread-Topic: [PATCH 2/2] iommu: Swap the order of setting group->pasid_array
 and __iommu_set_group_pasid()
Thread-Index: AQHbauioAnukaS8lDkeIhlTCUvtQZLMfKiLA
Date: Mon, 20 Jan 2025 05:58:02 +0000
Message-ID: <BN9PR11MB5276B907CFD594D7A49349938CE72@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20250120030840.4171-1-yi.l.liu@intel.com>
 <20250120030840.4171-3-yi.l.liu@intel.com>
In-Reply-To: <20250120030840.4171-3-yi.l.liu@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|PH7PR11MB5861:EE_
x-ms-office365-filtering-correlation-id: 09adf248-f078-4a0f-09a3-08dd3917665f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?DdxkvgOiV03Naz9OTUE2EglYXQ4fqxUDZZtKJbtwQEKBR6ERbBnIGhP21mZg?=
 =?us-ascii?Q?x3gBx+sg5JFqzeI6V5HjOJbrNqgycXrsklQ5mVNODwVHGjndqAdxFCGabh9X?=
 =?us-ascii?Q?FarwP8hYC2dX5cZwvoQQg8Tb1nvwSZ6RYdRmXtPtWv/vpzykfZkYO1wsbs+s?=
 =?us-ascii?Q?ImJ2CtQuCnq5tuoweQbIBu/JNtfEMAqkVNG5hUlilFjIWFGtNlGAFeYwLc4R?=
 =?us-ascii?Q?xJVeawJ4khYhPszOm6CiqIEMDH5MgVVmBYnaJPoIKx+Ksh49whtt+eo5aysE?=
 =?us-ascii?Q?VFg/QAM+DTIl/G4EwZX6RSGlee45h74hzirgUxCTXeFI5uoyBKFZ8A9wp3hR?=
 =?us-ascii?Q?t0BvhdFRhZa9VhIrxAk7g1AQ9EdkkAlZnYzRb1khQxNi3uIXF/lL5OIXmOVf?=
 =?us-ascii?Q?3yg9/5jRihU/S4NVLFcpuoSOnBLiOSMJL7jbPj/kZirOu4gd7+fyPJbd79N3?=
 =?us-ascii?Q?UEQxEgrWALEPehSZjC278WoyCYG2IsiqwJJnWhGFlJfhLR5H1aYMmv2z7gKu?=
 =?us-ascii?Q?B+3/pSoEeyunnXRDwPh6/hyf0Prp0E6YGHVIUIMXGQV+0KLxDAdHXHrrwojH?=
 =?us-ascii?Q?uFXIioufCII+OvK1ojj6nPtIZ41gC27A4cwXOkS6KVL+jnxvG5G9SvXuiESH?=
 =?us-ascii?Q?YU810Ls+NRkDHHqAiY4szqGmzVFR4mcc/X0RF4XyIJz2L/lCRYKgCzqkXy8G?=
 =?us-ascii?Q?t3LbQNJT7RXGtTXSnMNh+V6SpXqzjV7b2BD373ThcK0FT1bfaJRhlqCUN6j0?=
 =?us-ascii?Q?BeAfKtHKMxKf9ZuhEeNinJX0O5DUhIPdRo120qMx70ANV+jY64zjrLNzFHV1?=
 =?us-ascii?Q?tFOZ04afRVB6FffAe/5xSkeJXbWXKO5YCS1uduUCuLanRRjp7Vg+x24U2CB0?=
 =?us-ascii?Q?GidhzaYoaeiSkMLFa1P58l0s8a9+7o3tTfsUlsymRwKMQbBu9FKJWRQYUmce?=
 =?us-ascii?Q?4fJZlM832anRKOGPHPhMjjoZbjsvRNmkAeRjRIHqm8eyLfzmSZ9pTgpYfoWS?=
 =?us-ascii?Q?mS17Z3jOEwiMNgqkQOFKV4wc3Ts/uKiJZmv+RAjlsC9XlZBYpBOq5pCGJyG4?=
 =?us-ascii?Q?IY3dMsIX4RaCMqdBfDXCQhpuoygHKV7nxy5XsF0XEtU1+fZgZULGCIbTK89M?=
 =?us-ascii?Q?OIpVuRbSDiGPMg89S2nvOcXYuFBKuoC0FdoWfabd1FcQQzKycceY1OOXgP9F?=
 =?us-ascii?Q?CNsESPiC267rT/E5WglIol+JquXN57OX+GoNzXP1vktIeCy3nyukRTNjNCIt?=
 =?us-ascii?Q?+mw/S/lKOrgC+Cwhhmw1U0KJWDSpIop+PmF75dBNk0Qamy65DNcO9gzRXOPn?=
 =?us-ascii?Q?relMyMq7g74VhZa5iit6xdFjTqXJhV+HEA117ALtMElaK77UvukjpKWesVlh?=
 =?us-ascii?Q?FRNbtM8OyWxHtbYCJ1Xn73G78OWo10QbEQSZv905J2pT44lRqW0/OHlnY3NE?=
 =?us-ascii?Q?CEGVePhYHrxoUeIhxGp14GQJFKY7+GJu?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?nqdb8C1tFk3v5gT3YTTZzWxkRgrKchNluVxJOTD1sYn7nyYvrmOYgwPZmEpO?=
 =?us-ascii?Q?F6L44Ku31EjdpfzS8+MApME+beVk15FsesXPEMNrkllMtYvDyY8BVkHSdXos?=
 =?us-ascii?Q?d77KWHcUdtEYMA6IbfhRa0F+QuNNdcyKCxlZKmekVg9443BF/n00uDg9YMeV?=
 =?us-ascii?Q?smULQiBC+cLb/laE9ZjbEGjFQRPN6X0YHkrFSlK3PxoO1qiiUSw2rUDg0HyP?=
 =?us-ascii?Q?/oHCyKVKG7mC+4G7MDHAj9kmqn+9mN168r8qL6xEnC8EYP9BYfTwiZjANXs7?=
 =?us-ascii?Q?/5Acn4I9FSijJdpSIL8KDO9v0fGHh3QSzdWsILu/d/KPlwVLAV0xMymTSTN1?=
 =?us-ascii?Q?/pLq9aTWDpxuyaMU0wpJstx/4ROcjO96+3o8ghzEYMf9FE5WNiZ3llbdFOhO?=
 =?us-ascii?Q?4h/bkH7J+GF4d4D5Hum97++lXv+n6H/kAMoVGINhM1TmXin/xfU/N2U8B7xI?=
 =?us-ascii?Q?vCbox6wJ1IhnkJ4ScCkF5ggXkC83hIJJmdyChWQN0Jv1v1u6YB9MAUj6Bxrz?=
 =?us-ascii?Q?xisdTxNiyaZSlPqeOsDs5pWyqrfniZChNsRg+e8eJOxsOk49Bs301N8CNY92?=
 =?us-ascii?Q?vnig5DkLxj9bMsUivNyZx5SbtJpUWe5rXq5qjnyqqIkv+7Gtd87zfJCEwPqo?=
 =?us-ascii?Q?nJSx8zMWl7Ux1WdmkbLuTg30IXYOghL5Bks2DdJZavs9/flFg3qMUTYOL2nk?=
 =?us-ascii?Q?ua7HehAmf9yFlUZCtdZdJqCydnSB+o/N7DOafDdPWs1kum2T1whGZJj0//IL?=
 =?us-ascii?Q?b9aP3OFnAClLi2ZoEZUYG4rl1lW4DlEpCdcxYlCRDHA8/AgSpmwzXBFZ3s07?=
 =?us-ascii?Q?z5XHbd4dUhDYCV8Z46V2G6BGLEdW42wQgtJxeGPhH11Z26WWrgL6WUP/BVTV?=
 =?us-ascii?Q?zph9VKO9x+delAUMNAt1DNeVzQPVZB2273+AoHGRSVhfjzrqZa8dEYCs51lQ?=
 =?us-ascii?Q?9KyEMinaa1xzNygZdZP7MYKlJXQDnhRf5v/rFBU4wU9md3ekqyugq5SWiDBc?=
 =?us-ascii?Q?CBB0kdGiiEJ/B7BuXOerjY6bINrc4alBiG39edexlgXvLUgTIoCSiAJbxbyw?=
 =?us-ascii?Q?Ul7+oQ0PMWUo6d1KJF6J2FMdx24ll1kwydlNVMGNgelC8YWnClM+kf6W6rlr?=
 =?us-ascii?Q?540b03PJGHPotk1X6Y8Y5bpL/n6FAE0uE/rdUnWFh0UgLSw72KPjJtfA1+c1?=
 =?us-ascii?Q?cNknWcc6rL7EwYV0Fe+lY33blRZXEU6tGJWHNJ9Bnr1QM8SiAZiGsyHColzm?=
 =?us-ascii?Q?zvAcZQfDB9Znd6w0S2vs3BhmYSs4Vha2q6UpqEFSKWA6r4hAKptgfVt6JUSC?=
 =?us-ascii?Q?aBubzyjEKz0ZiQOGh0EgQCo4MsftynrxBs+xBz2/dN8pYmEOMnBbr/lVR0bw?=
 =?us-ascii?Q?mCQLyxVmGJZ1VuudBess+ZX7heFKYUeHB4DAQxSxoIsCPt8Buph5pb8aSom8?=
 =?us-ascii?Q?uxJ/MjatHJhNUOmRcrRYInKrYIKxCbjQ0l2L7M1iMNA/K8Wbs0b1XV7qKmdm?=
 =?us-ascii?Q?SAO/3EIm9hTHBY3UTTjnWniERXZkTHcUy4uGRugZkh6kTOG0yAmUod0beSHd?=
 =?us-ascii?Q?YDMWxRCDu1sfWm5nz5PqsZHkYpRPEpTVBBfueG0Y?=
arc-seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fMy+fRW0jxc4D41gs8I55lOkzY6clRh0eN98Uvsl4dKJbsKTBvRX+kVs4y/OgwYjrGl9poWHuw7fBc7Xhg3z/mmbRF7+pfxnzZpm/nLetfACeL9M4LhQ87Zaq8ONZHZr6wuxiLF+sPk9NWmnAgZ5bD5eS4VDclJRm0v438LH+Jss2d3FVV2ZnCagCIJ+WT2u4nDROAM4jbHBRWGNQ3WrAG3TOrWOVrYeChN6w8NNt6oCv4eHs0G1GblF8hblyD0KEwgdZg/qTlvAOlIuWYKv+rHtPvPXhyryoKQzfPldtq1+oCAxkHUDgEXRFMJjC4dtcs/ATpz+R+05BFBOjIbFBQ==
arc-message-signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hyLaexL3pCvEHpo6eym6Mp68e9WhxEAia+WhJcaGseU=;
 b=TLnVPPm8POl3DVzjy19G1kchTBMkHuLSZF1YQZ6XzWen//yWo/UAZ3BLfJjAPfQcG3U9+OhcyK1JUVRRbnjcUn0g1V7J93i3j46zYJ5ggSGlf8Lwf/NqRwDPoKfFbXcnh1E7Gp/82/Itmkfgjcpyd6ujKnfDq8UL2uhliiCjsAgbUAIFLvjDtZNAsjpUd1GOIZH31ddXFKXFte+ZZBVqysWldEpcFMEuvqLm7TQE7V6JSC3AEzI4ZfYgTP6O1cqjkECkK+2R7GgKWrAvTQJyhJMzxIO49Q+u3YUbGwYKDZpQr7NnnFsJ5CwXrc5FuJAx8h+bM4v38Ih2aTt0513XGw==
arc-authentication-results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
x-ms-exchange-crosstenant-authas: Internal
x-ms-exchange-crosstenant-authsource: BN9PR11MB5276.namprd11.prod.outlook.com
x-ms-exchange-crosstenant-network-message-id: 09adf248-f078-4a0f-09a3-08dd3917665f
x-ms-exchange-crosstenant-originalarrivaltime: 20 Jan 2025 05:58:02.0575 (UTC)
x-ms-exchange-crosstenant-fromentityheader: Hosted
x-ms-exchange-crosstenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
x-ms-exchange-crosstenant-mailboxtype: HOSTED
x-ms-exchange-crosstenant-userprincipalname: uYOgjAMfaOkfEMrSHNdoaF4Y35es4+ta6quqB5hyKt2rZw57fAwoB4GPoa0SaVWn3k3sSf3eBSWQ0Pfec6odEA==
x-ms-exchange-transport-crosstenantheadersstamped: PH7PR11MB5861
x-originatororg: intel.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

> From: Yi Liu <yi.l.liu@intel.com>
> Sent: Monday, January 20, 2025 11:09 AM
>
> -     ret =3D xa_insert(&group->pasid_array, pasid, xa_entry, GFP_KERNEL)=
;
> -     if (ret)
> -             goto out_unlock;
> +     curr =3D xa_store(&group->pasid_array, pasid, handle, GFP_KERNEL);
> +     if (curr) {
> +             __iommu_remove_group_pasid(group, pasid, domain);
> +             ret =3D xa_err(curr);
> +     }
>

s/handle/xa_entry/

btw you may continue to use xa_insert() to save one line for xa_err()
