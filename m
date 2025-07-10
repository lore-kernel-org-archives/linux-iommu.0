Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEE4A28AAFC
	for <iommu@lists.linux.dev>; Thu, 10 Jul 2025 07:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752133279; cv=fail; b=DVNoBy9ghKu+Y7kEIiwopcuEe+vr3LTS6s5UOZ04NA4gEZFyEdnePK/YJoGWaEglPDov5veXfceAvTNqjehTimTFTkXyZWbqDLuU+iLu9vdMJwqzGzC5er1z+zACkDRZyVE4fRZHKzG6Bgo7jZebijuIiv3RCtoy2tU3e0vZ8Zw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752133279; c=relaxed/simple;
	bh=gMB+xRSgGe/aG3pV8HX6VAiK+G7Gl/lTHhWzASrpWlM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fZqVb0+9apUPN4UE1vbGcw88brHTZrjZETSYItXexty2M3VlKtvD7Wal40lB1ew0DuskCYDZd468Ucv8RsYz9FJI3roWg/geQCJPfGTi5hOInxvrooqEAnv6slgf29oZ10I5gfmOi/NHpT0Ls2GXetrkdb+8AxxbzCBltljBw7s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RqAGFZmu; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RqAGFZmu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752133277; x=1783669277;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=gMB+xRSgGe/aG3pV8HX6VAiK+G7Gl/lTHhWzASrpWlM=;
  b=RqAGFZmuRhnn50wIaBGkQjRXlYPz36bpS9VRSkWv23oVku734zDIWrfj
   jhEmiVPQ5v8SBPqzUxJBzpw3+njHuzmwxgO2SucQ0SaKRvaWaJjQOf0ap
   zo6eqVVe+s/MY67K1AJmTGJdsn7ZylLhceB3r+aXLEyc+6wxIUJMGJDtE
   pfdiQMiEis0U+Qn/FgGH+Jm56GPNem0arX9ctQIyhnxaJc2i7PolDyB9j
   n6PBHYKkeH4tUzwCEmzLJNg1OJU+4NIip0MeQVXAzMKyQZTWhej4SHg5B
   gKZDxtv2nP495owdCVDIPgz3EcX8Bs3+OjSuFefqDj/gDaVJyQMYQG2Q7
   w==;
X-CSE-ConnectionGUID: QapnizPvRQ2aUZu7dfIj4Q==
X-CSE-MsgGUID: VamMteIoSva3rFtoqFHiww==
X-IronPort-AV: E=McAfee;i="6800,10657,11489"; a="71990671"
X-IronPort-AV: E=Sophos;i="6.16,300,1744095600"; 
   d="scan'208";a="71990671"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2025 00:41:16 -0700
X-CSE-ConnectionGUID: porJ3AHrRqy63TeDwpM/nQ==
X-CSE-MsgGUID: 0wiVmkZVQ6aoHyYKh2tI0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,300,1744095600"; 
   d="scan'208";a="160287068"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2025 00:41:15 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 10 Jul 2025 00:41:14 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Thu, 10 Jul 2025 00:41:14 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (40.107.223.68)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 10 Jul 2025 00:41:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zNKo9ALJgRU5isJKUpjJW5n/8hv9PENtevmIupR+3f0DFXhbYCwmIxGSaTdYEqp2fbAMliVei7p/uxLc1/AoTVE9M5St9mzsEtzNLA7fUUqW+1xvnAttRINx6SPKevfNeOkZIzmzYH7UyUG78Hdfo3s6+nTzGHEJEcQBMoYju17vStA9ehLVnGkmFZ06whygKVlZCelhBYISTDstLmNNhI0ybQpaqmy7fGxlekWWXDEUGwAPKE+RqUvz6P/GNC6m6o1L82XWxtWgkRwcVN6k6yaI3n66C3Acn18mKJ2S5anmOinoqfmmJ25Dpt6zWZvH/21qOlccM5pM1fgjK+CXuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gMB+xRSgGe/aG3pV8HX6VAiK+G7Gl/lTHhWzASrpWlM=;
 b=Q+9CXnK+yRUjzN5+aHK+ocgOj9zJFYmZHOMMtgj4BCiRNn60EakDfzM9jfJe49S5WHARk5cp0dmpoXMApAVOVq4DQQ/Rup3TwMwIE0ZlihtOkh5A6W72pYwvUCGhVa5/8V5cNWqaGeyJ9vOI5dgozXDTxHUYnWWPXuDSLP1ojH+DZkNBVUM4kqucy7f/+CLB0xBaSVFVu5MWuUoQwmuPr8BKoY8D5WdkNQn8l3s2wOUNWfsdChDDv3G5HSqf00zYRflm82+RI8xe2dc80QnRmjAZZxeoMAQSpTGHezdAI+f1gKu+Okyc2ICiXIj1/lmfWnRAlaD2mVJrMO7+1v9xFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by DS0PR11MB9503.namprd11.prod.outlook.com (2603:10b6:8:297::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.28; Thu, 10 Jul
 2025 07:40:58 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%4]) with mapi id 15.20.8901.024; Thu, 10 Jul 2025
 07:40:58 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Xu Yilun <yilun.xu@linux.intel.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
	"jgg@ziepe.ca" <jgg@ziepe.ca>, "will@kernel.org" <will@kernel.org>,
	"aneesh.kumar@kernel.org" <aneesh.kumar@kernel.org>
CC: "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"joro@8bytes.org" <joro@8bytes.org>, "robin.murphy@arm.com"
	<robin.murphy@arm.com>, "shuah@kernel.org" <shuah@kernel.org>,
	"nicolinc@nvidia.com" <nicolinc@nvidia.com>, "aik@amd.com" <aik@amd.com>,
	"Williams, Dan J" <dan.j.williams@intel.com>, "baolu.lu@linux.intel.com"
	<baolu.lu@linux.intel.com>, "Xu, Yilun" <yilun.xu@intel.com>
Subject: RE: [PATCH v4 3/7] iommufd: Add a pre_destroy() op for objects
Thread-Topic: [PATCH v4 3/7] iommufd: Add a pre_destroy() op for objects
Thread-Index: AQHb8IeFZvbtNefsaU2/A3f+EpS6fbQq+hSQ
Date: Thu, 10 Jul 2025 07:40:58 +0000
Message-ID: <BN9PR11MB5276CA77E378CB3173CA76888C48A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20250709040234.1773573-1-yilun.xu@linux.intel.com>
 <20250709040234.1773573-4-yilun.xu@linux.intel.com>
In-Reply-To: <20250709040234.1773573-4-yilun.xu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|DS0PR11MB9503:EE_
x-ms-office365-filtering-correlation-id: 728ec988-38a0-4465-d721-08ddbf851c9a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?f/HxS4zhVwZfAHbrQyb7HggxR+246ytLiNjxbjtFDktN2wqh3aerN3rdsxyP?=
 =?us-ascii?Q?uH+7AMvLEx9E63Maw0KB+Iou2z/WhrhX2ienjL0iufp+lg4cVR8qhfC/jT1t?=
 =?us-ascii?Q?lufw+1XBW36OuSRIVN/Nnq8d/vY5jTWuFEDUIlP9ZLaLrIMhSe4Rg028/g2s?=
 =?us-ascii?Q?DhZvpNf6RNEBxm8s13Hq4md1lNISdQnIbE4LZdgO4C8TwM+Lk/Y1CQ6einCU?=
 =?us-ascii?Q?HOAayoefSnbqzH8XZsWKUcQpYmrBHp396aMquZrX4rBvLrQdBGkm3pjwy+DJ?=
 =?us-ascii?Q?e1NxwM1NRpCNDUZiL/BPPw2D3Se97/Nlp8q0j5n1WONiSYiiBbPj4dU4fXp8?=
 =?us-ascii?Q?Xe2B7gtx6nkRA6K8cOkh2aDaQvLnOcfSiL37CP/H+r2wK3MKclLZXnCjoZh5?=
 =?us-ascii?Q?ExZBLeosdGIZE1jIcnE5y5aEnU4xTAgTwXA25ZQV/6aHuum+6g9GksXucnX4?=
 =?us-ascii?Q?AL2a2ThKCybfg2hEAEJs3QdkZZw4madRhqRDEX+5Wgvgip75ayu1uyEGjLt2?=
 =?us-ascii?Q?OY1U8I62PQg51GH+m51bkqlv5jv3NoMaMnltVAHmbyNQ1BHrnD3405bj1Rs6?=
 =?us-ascii?Q?P5B2cmuk9tusQKA64CErpFnxdhtqVp2hb6C2xjuTrxJvTpVqeiyn9UeDg7kK?=
 =?us-ascii?Q?cXZbb/j1oZEGZBix6ZddVhZ5B124fD7WKhW6WluFobybY/txWqreXoRvF29H?=
 =?us-ascii?Q?uAJVPCNgbq3WLeSxbnmqBote3NpYB0d4M8sFlESByGTiv/unojzv4vf4dKkl?=
 =?us-ascii?Q?Oxi3vCsVnHD7SrIkzwq1ODPP6E0m9jTFW6HlGIDNgprVbfy+P7hppawzW2qX?=
 =?us-ascii?Q?9ZuEdAuV6AElJEqZp4OkM3tCnsjJAI7aEigmPyJp8b3YUxlqo2xc/sxhHuQP?=
 =?us-ascii?Q?n2I4/HEfhb6e4lkkNfY2q9Jre2hXTIwrgnhPD1vXrCVi4GYG/vDnzKk7zJbi?=
 =?us-ascii?Q?oS4zzjKwJer5uJM3KHySRCjw5Et3YKlsgZ4SmLN8fD8sqeKH48NTzU7g1ktF?=
 =?us-ascii?Q?BjSA7AOK7aQhBFeCjCIIPzvoDSo+015gG6PQUCFBF1+pycpbFl1JN3mpUaCn?=
 =?us-ascii?Q?EeJ9/waJmevjMwLmOtZEu6Y04F4JmXdqlqrc/XfND5JRs54MajrEzKj4X9ad?=
 =?us-ascii?Q?POXsMz1EEZ9yXpR2xCHoCzN2pzwIY/2tlXgAgNC8qwV10aro/j82SFtjDW69?=
 =?us-ascii?Q?EfzE3gTvqwYvE63+7Egyym1ljsIb5f7uA1ZJrEyiQlF+sR5fXuCjxX8Jr2V9?=
 =?us-ascii?Q?LVgCJXp6NPgF6QLP6AMHpiieau7UGhuHAd1hsMyb8m/aZTa2018nx9AeqrFv?=
 =?us-ascii?Q?fc1cNVVfz4C7ZtWA+2wrlBnMq1sR5TvBOATPNSXIMjSMO66nPAug0YvZXI8c?=
 =?us-ascii?Q?hKkEMtV21mb1aqTuU15IH6WVlrlJf4SH8KSYMCRVx7bUL8jj/0U6y6KFbFhq?=
 =?us-ascii?Q?BEmMqM2T6LR3c3OPXsZhdzxT9DmFAPMxW4w+8vG8TtmSAp+UdJz25w=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?wpoyK+OkDmiQt9hqv+KYZrqY5Ohk/B61ee17Dcry6yzqSuD1yya80UWs58N4?=
 =?us-ascii?Q?fumceisuyEQEYA2mafYkEtP8b5loJ7vbCwoY0ZoabfV34abHY0CGfBC79EiU?=
 =?us-ascii?Q?WAxUPON8yBtQm3TIdHSair7mGETvY9ZpcTG0Omxf1uKBHFWM3++CQ0aK2o6i?=
 =?us-ascii?Q?STNBVqS8jpIh7c4JVoNp4LdDB2y9K8BWxw2ObRQ1lckR1as0FB6Rh4Im/vbU?=
 =?us-ascii?Q?RI3OlAHorQtPYXvtlEZn1Q/Qnehoqb2E3Hz9roc0pfxaElswmW3b2Tsekeh/?=
 =?us-ascii?Q?F5UhZxoNAs9USLcGwNM9ZT2qwr+eaJRoiViDBLDsLN8sVjGMzyetJppD+0kr?=
 =?us-ascii?Q?pD85bSpS5KlyiRvyynJxVS8rtTxrnXy1OltrkamdFO8Pwi/kpq22fxzK8Ih1?=
 =?us-ascii?Q?9g5TB1z5w8emJTkHcDbbhFePZWBCRF4EX/3KVHaf0cUtUrQSSwLcyLptvLtZ?=
 =?us-ascii?Q?1M6ufNil1GZnPBgDxMEPsP/sBt2+sbv6Mydx0sjuKU7t7fCtwPJwvAWEdYo5?=
 =?us-ascii?Q?Tq04jix6v1RlUPPq0+uVyTvK4IxkTRh8oU5Fw24Tlm08XkgbkaYm3jpnzZq+?=
 =?us-ascii?Q?HjSBJE8L7FLUHubLbfYnG6q1oPGfFq6saN/cgrHOpFAru668H8lSzrqR/5v4?=
 =?us-ascii?Q?xfFUy30KlbOMc/nHLgVO3nxwEtnok/6GuW48xHuh347Sale2SaekUh0z2Ch9?=
 =?us-ascii?Q?hTeVouRlv1WF4sMNUrJPVi2aY3Sm394mWpAIucawnSZqyrIU+T7NxKBCvQu5?=
 =?us-ascii?Q?VxlLfWtSkhuFVd+A6NUu7/yq1Nrq9P+Ti+fmOMmKE3oPgSTnsFns5l9n3uE6?=
 =?us-ascii?Q?ajTEKf78bmxoxmwFawOkN7bNbZROMzUzUvyyCbOQMn0CZy8lXEyJfMc4VW7w?=
 =?us-ascii?Q?HRV8QbHn6u9FlgLRt0uCqC8IeKxw0rgAi5vFa4Mdja+gijJqaUWpilVi3Tvy?=
 =?us-ascii?Q?neKC24gBe1BJhQnODaNFWHBwTcZL44tuTtCgGQbyahTDIsMWgDNDZ2x4JYAi?=
 =?us-ascii?Q?H1NSoz+s+BMzH+qVy4D8KOrRPNsRHCrqwR7PKW5lSq2PjuQRbzusWIiFFvXb?=
 =?us-ascii?Q?fi38zbM9EJnEQOPG4R3CtfSa3Rz6dq1LNwRNwGecrrci18lrho5M/qnlYHhA?=
 =?us-ascii?Q?4NPefqEd0c5SSnLIwAe+8D8sd+LVj/3Eo21K1MRFSXZKax+icZTV5yMSpAmP?=
 =?us-ascii?Q?zlJUaS7XpeA0+tt3LD0zOKviAGzUwufgGVulIi+eeVGSTleYDSGnjzeGEpb6?=
 =?us-ascii?Q?HSlvp1EHHNGM2cK7wY1QcituFjpN07m84nXS25cJLygAXQoRNdPsVSeS5gpP?=
 =?us-ascii?Q?78aZriWYzBGePvhZXJNV7ge8u3BTG3CweogEJvlOJ9lylYma81nBsJ416dOn?=
 =?us-ascii?Q?9fw1eSLtFxtExGP53bRaGKV+jAxJwkRErpEmy9d4+4z3t/qIQjgAK+2atc4K?=
 =?us-ascii?Q?VHOTZiqNBouYt+ySSF2Pqk1lo7loHu8NDIyVlBcfyNFid1/snnbEY3pVS/0p?=
 =?us-ascii?Q?7iKtf+9O9Fwbnw2P3R6+z42YsTaslFK0oHOUqMaGmS00XJweEvtDhg0jxWUJ?=
 =?us-ascii?Q?t/g6k0GBAquGLDHVG6ja6rxjk4udjVqKf70unYAl?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 728ec988-38a0-4465-d721-08ddbf851c9a
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2025 07:40:58.7554
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: phNErQ/d/aAI88W2Js8UHjfvnF5UkFFVRhq9VXAON9OsxToGS/6WiY9rQBKnI/vl5zDKgg5YRcWGE8qywI5LqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB9503
X-OriginatorOrg: intel.com

> From: Xu Yilun <yilun.xu@linux.intel.com>
> Sent: Wednesday, July 9, 2025 12:03 PM
>=20
> Add a pre_destroy() op which gives objects a chance to clear their
> short term users references before destruction. This op is intended for
> external driver created objects (e.g. idev) which does deterministic
> destruction.
>=20
> In order to manage the lifecycle of interrelated objects as well as the
> deterministic destruction (e.g. vdev can't outlive idev, and idev
> destruction can't fail), short term users references are allowed to
> live out of an ioctl execution. An immediate use case is, vdev holds
> idev's short term user reference until vdev destruction completes, idev
> leverages existing wait_shortterm mechanism to ensure it is destroyed
> after vdev.
>=20
> This extended usage makes the referenced object unable to just wait for
> its reference gone. It needs to actively trigger the reference removal,
> as well as prevent new references before wait. Should implement these
> work in pre_destroy().
>=20
> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>

btw is it clearer to rename 'shortterm_users' as 'wait_cnt', as the
meaning now is beyond shortterm and is really about the need of
waiting?
