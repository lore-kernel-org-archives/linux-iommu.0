Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4959C16D32E
	for <iommu@lists.linux.dev>; Fri, 21 Jun 2024 09:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718960739; cv=fail; b=OSjhxuH2luq8ym/IMqFkbxXa2DIuQej87ng6V2bAcxziocpku2yNeh1IZMuxqLMH79rIvlLgDy0jntblxUbHgC0Omz7sZpd/Or2PKRngqXIQFp7xLVgS4OOBr/dd/z8UdmLFLEhulBFOtz8Pcktoq5Y37+EgKkdVS93cFSHOoHs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718960739; c=relaxed/simple;
	bh=tLnJ9eJb32TP0tvrdHqSOtz1GLX1PwoJxPkfNqQ5rkE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=q9+8iCT97rn08pId2mbC7Q2/5butnCeHogIBf2N6Ei5GijkLNTjeWpTz8HmiZbV9IrTdPQ0Ax+sva5LeCSavbKD/Yqvqk1X7z6SmXB7gF3e1hV2QlslWYjyDlD3Fp81FyzHkVmzCZ4HzsDaYW2vumIbSW2E2yX26wGGa9BhPEtc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KyXw7him; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KyXw7him"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718960737; x=1750496737;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=tLnJ9eJb32TP0tvrdHqSOtz1GLX1PwoJxPkfNqQ5rkE=;
  b=KyXw7himHFb9oSmGbTcErSqXkCLMaC4JmG+AKUyPWYPejk25pbS5CwvF
   Cd4sN7LaS3ZFOt3a4UiViWDgRwKGls526FC7wL+MxnNctn7srcnErAWaA
   bcdnaOFxIoIUKuZeGOIIK805nBM1lsGDsWF6WnjCgIFTLEHvZzKOQPCFL
   DKQDNUJUBCjPQ1qKfib6UEI+VmxuFqn5sZMjIyLxmUlbCIj7+CU1KL7cd
   Ddn3sJ1z0b3t9Gy1a2HzPSxLwy3/H177a6hQIPXs9zIizCHi1yDzXGSNM
   lX0APX2OY5NBxuxE5R3ZD04NfNftdk29FGZ56+8IQt7Oup35F+tjklG3j
   w==;
X-CSE-ConnectionGUID: q9kWuz2ySWqnG+7i6hv9Mg==
X-CSE-MsgGUID: WPgiLoUyRbyh3JMZq9sUYw==
X-IronPort-AV: E=McAfee;i="6700,10204,11109"; a="19760813"
X-IronPort-AV: E=Sophos;i="6.08,254,1712646000"; 
   d="scan'208";a="19760813"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2024 02:05:36 -0700
X-CSE-ConnectionGUID: 14veUNJXSM+Zs8t2PDE3KQ==
X-CSE-MsgGUID: zKnaKeDVQE+MY+54kzxRFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,254,1712646000"; 
   d="scan'208";a="46875539"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Jun 2024 02:05:37 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 21 Jun 2024 02:05:36 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 21 Jun 2024 02:05:35 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 21 Jun 2024 02:05:35 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.43) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 21 Jun 2024 02:05:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TgrzqL5EAZX9DLDZIe23ByDtIM0LgiLjrsvJ+nOx50v5PqsuSp0dZd0Nkx6mh0bYmyfh6TGdwQWJI3aBxchgAt8flanb+sWdOHFQbBEbDKiRy2hBV5lX4xkTx1ynWUVpxd99zMD6cLMHMIO1jWpmE0V1kmenqf/DVbco9Iku9RBOByfTmv4EbCDlweT0x4PC2HiLt6O+TWgzHzS4JiTgUiqkSgQwK+tVUQEAccoT8sxO5f2ylLvnoCRsOLK6gS2QFiS88cGuyxl6f3W8zw489rTJscJydwYPHJgAAKGMEho0v7AN27QfPcvis5VMMCkhS0RIYyyeZnyc5/LOxoOeJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tLnJ9eJb32TP0tvrdHqSOtz1GLX1PwoJxPkfNqQ5rkE=;
 b=GLKskRTkLHTfxN1d2YYbBTp67Xa8oNu4l6Pw5zXAC51LJbVB0NCC2Mym6gg2kKYP4Uo2XgKm1GDd9B8rBJhs5H75O+54q7wlRH3++d13JvOLzvSm99bmMQzJfq3/GlZc1wzN1HLmcdYCe7nLodsWoucpI7p+CdxEl0vGXQ6cgdBOVF2QohYp0IVU5vOytPm7XWJxDsHU530j18X5floPR6JNIB9Nhq4gpzox5CP23I9H3nCMga7YP8B3OFjDJzygZQUrGmSRr4GaViR8IoCOvHiImkkZAhD6bEPybj5SzdiPTxAoRU87eAuceGje5uIG3FnfYf3QbLvUrZ5PSF1FAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by BY1PR11MB8055.namprd11.prod.outlook.com (2603:10b6:a03:530::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.33; Fri, 21 Jun
 2024 09:05:33 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%5]) with mapi id 15.20.7698.020; Fri, 21 Jun 2024
 09:05:33 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, "Will
 Deacon" <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, "Jason
 Gunthorpe" <jgg@ziepe.ca>, Jacek Lawrynowicz
	<jacek.lawrynowicz@linux.intel.com>
CC: "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 1/1] iommu/vt-d: Fix missed device TLB cache tag
Thread-Topic: [PATCH v2 1/1] iommu/vt-d: Fix missed device TLB cache tag
Thread-Index: AQHawtuce5dzuL9V10u/YKgTw5MOwbHR7m/Q
Date: Fri, 21 Jun 2024 09:05:33 +0000
Message-ID: <BN9PR11MB52766D5D45C8A085FB9EF0698CC92@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20240620062940.201786-1-baolu.lu@linux.intel.com>
In-Reply-To: <20240620062940.201786-1-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|BY1PR11MB8055:EE_
x-ms-office365-filtering-correlation-id: b26664a3-6e8d-4e2f-b24f-08dc91d14e94
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230037|366013|376011|1800799021|38070700015;
x-microsoft-antispam-message-info: =?us-ascii?Q?+N2MSqucoi1m4y3Mb8XODqEFZc4AmT78YorZET82/0RSLktPIT/NWEkIsSoP?=
 =?us-ascii?Q?8rJi2RVoopUW08xP52fDUUf2J7eE1HafVcQ/cCwbs8LtU/0ispvurU1V9lsc?=
 =?us-ascii?Q?IgRxW9ShXXd9vGvPI5dTq06jr0f+S5Jyk/gD9o9EVzLttL2t0U+5gtObwuVX?=
 =?us-ascii?Q?KJcBF/w7OZ2Pt8dxYd/6lWgq/Am/MN4g0RbwudQlHBHyvWz32l0gjGJXojFo?=
 =?us-ascii?Q?BkqilXdPP3FO840xEtnEWWV6atjUkNk+nXBnWC1ZOSMkR9uSsNg7CmB1er51?=
 =?us-ascii?Q?PhXc2+DHKxxJF+HRdmQuWCUrlkgFekbVeSAW2F4twD/YavmZ4pSJFbJbJMeN?=
 =?us-ascii?Q?w0clEGg0V0Ks0CS4n6XprDQsR5jrRbrTasRSPJCmsv4xah1opJEceUToQjCa?=
 =?us-ascii?Q?CjFkxchIxAwLJ0b6NZ6tX1GKcLZlO3gTDIZK4FU5gD4wZe1cqURKjjweV70o?=
 =?us-ascii?Q?Zy+pqjXzwE+Mgl37Ta9KDEnfA6UIoo7CE7R6FcAc1ZGCGkTcSckzvLMyM3sJ?=
 =?us-ascii?Q?f14QJRRZO8pkoe+qcMV665FSEkceiCIQr7WJl61nUFplHIKul0iySpR/VuW8?=
 =?us-ascii?Q?LGN2TMA1MDMEzh+30qRTg3pLeJrLHAhcZGwCCDc3oTaTRLHylqmhp+h4Mj6J?=
 =?us-ascii?Q?1iHObSVN1vWaeapjwelMw0MdMoWWra/gOzAOUP+sHfyWR7ZSi2udyT8zcaC2?=
 =?us-ascii?Q?duYVDB5IBCWHxy+SZYjqkVelVzfL+yYTYpN1vaOnsrYM9ZQ0RCYNrCaXtwiC?=
 =?us-ascii?Q?olOuM9504jb+V7VL4FMmF6dn79KG1p17/PKLTfsXzDaUtgbwk8yfjAEZv/ZI?=
 =?us-ascii?Q?eCkLeD4wIE+ZIQ/5dioOabJD6vRHTrxXnOchu1EjE5B3wa9PUadi1YUq4FUk?=
 =?us-ascii?Q?eOH6GSf/zRi1LJUK+NLBFqcl2cjn3h4FGC+rJpV4s3Zohfh016Z/ytIiSq8f?=
 =?us-ascii?Q?A64Pc+i+UdMM50R8cw5ZdHYe40YUfn4cGAYhlJ4BEUavyWG6fgKZdt6bZFwj?=
 =?us-ascii?Q?rWpq+/AwSNuq3Ub/UM2rDXEE91XOkGqBR2ygmbreUJpSzByfOJ1TomrtzFSI?=
 =?us-ascii?Q?P+fIsHArAMcjCA0Zh/0Nmu2hZRmrixV5gwo+3dWGakn2iOGzJrCYZoNYr54o?=
 =?us-ascii?Q?eEqbqpKrN5YtxZ+uBMDvP4fOMO+WfTx9JzBwiblPKPG+2ZQ5HeZqodmSRKfA?=
 =?us-ascii?Q?PHRsyCw8kVJQFTi5fu/kj6qZT0qD5Y84K4JQiWx3QKDNlmGJHkPCwGFm8dmz?=
 =?us-ascii?Q?6/vqh8pWZTeB5lHjqi+2middd9P/ytbEjTw/59YIkOuRiIaEtC0+4HiY6P8Z?=
 =?us-ascii?Q?r9+wH7sOZILWCdHdQtkcg3ewM+jcRDl86DYUBIc7ZqD3kNu+/2KyNzZN+/aH?=
 =?us-ascii?Q?14uU3V0=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(376011)(1800799021)(38070700015);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?DSjiM+rib4+0LWK3UpXwJKwjEYSePjSi43Wcyv6REobJyUY8q/DQEEumyEcE?=
 =?us-ascii?Q?DuqeETh4Zr3BzAQ9slPfZrHS+NbM7dViCyG3Jfnb/cRAU0j3KGmCoA0LnP6y?=
 =?us-ascii?Q?B5e8UqctygrZWG0ZB/+higrq/uandVKqCs+dK/QhLEYAAYNkyeyC84L9HuVb?=
 =?us-ascii?Q?rKQctujbJdssaY06xgAHX0OSgpfCcPua2QHY63A3CkI4Ua9OQboSi1LYdoVV?=
 =?us-ascii?Q?+Xk8HLIKX1PkpJQ3Uo6JXW+jEry2tXmcnEEmhBjZHwaCqM3nOqHIcNSxCcBG?=
 =?us-ascii?Q?43NZUoH20rq5bRMKzlMcEz0i8K+itw8IKJ1RGlKXxcoRCcHZFjKbi4vCu13U?=
 =?us-ascii?Q?xOF48VnMb8U/N6FNKML3c3B7/uMTRQx7YBXjExczbg04eDqt0JFade6+pICK?=
 =?us-ascii?Q?4KH3Q2jdQV7YCvkXn1vrhY27zqmuViVXOTC+YS5Bo8O/s8ssxN27OE2Y3hhs?=
 =?us-ascii?Q?TjyhHlJip02nFHKttjH5nApbr5nH0vi2/CCZeglx0HjOa51KbX6SMyuNl6QH?=
 =?us-ascii?Q?Dp84FqWqcnjB7jUAkbe/vZEkKQf31TeKSVIa+R2qSqbt6eaQPmcf9kmTyS4g?=
 =?us-ascii?Q?HMWF8wSjakX1z6Hv545dBqFyQHx6ILLjfDAaQ2HfEoZisFnDvvYyhPkH1tkv?=
 =?us-ascii?Q?0a0MrOdJg9xhaCZipnmU+ly4mUrTJEaAFw2SnHs3G/q2ZHgtiVy6jXAoFCPA?=
 =?us-ascii?Q?1jOs+SnRP/xFTi6LIqThMxwfhoGdV/ktG0bhmO+p6uQTCGL0G4Mvt8Dh5uTk?=
 =?us-ascii?Q?HZmKC3WA5jQy35F3eAxXUXh3Kza81iAtRt3RMYc/vQjmGl1L4SySO/VM0BgN?=
 =?us-ascii?Q?aMG6lxfSDEsunyrIZJAKSeJLXjAyLUn8CE+y67KNuCN2f8aHa5N5AnG/G70C?=
 =?us-ascii?Q?JGIhIAxLJdBcRHA2BJhsRWAfslcV7UUn7QKUZwWY38//vUlK91Z72GRe/oWq?=
 =?us-ascii?Q?YLNjAlID5A3Ae4kIxRsl1RGbnBzROvCQXaG/cpnmm/SccCbpwsnVeNXY3CJ5?=
 =?us-ascii?Q?VLaj9nkbHOAdHL8eqb30sruXxTBdOsZp7rjOe25Yw7pE72cqOsSIlKyD7WKK?=
 =?us-ascii?Q?nTY16V36oX83jp6sRqTuGPzTWONDxAv+EsY9IZTDMGlViI+AVJIW+IxbQhmX?=
 =?us-ascii?Q?XyuqwRDWZJG1vOfvGFPCq1IbxyQ+1ym0nymNreDv5n2FwifQp2bZ+iqCamHo?=
 =?us-ascii?Q?U0zN5kZx3LBtQiM7SX0eSrvoXw4mHOnIGaLjGullX/td0S4o+olbOUnU38UR?=
 =?us-ascii?Q?8CPeP/NDlQ9VE8xO+p4723rGcUu/9bjK3UPQbVK4A9cX8kEjLbU7oIz0lmjM?=
 =?us-ascii?Q?0KUwJ/UIUgXr48kefyEVMCGsOeRUyz2D5p1M9LXIbDGufd1+Dqu2ViquyQx6?=
 =?us-ascii?Q?53JpEowj4ej9AAXFI8qaNz5yZAG7UatAzKIWz1jN7x/lIQZAk4Wu34D8aEUS?=
 =?us-ascii?Q?QqmarUrAOBhUc44b5oAZw0nacLi7AEQh2tISFTGmDIoEUZeDbGt4350rcYH0?=
 =?us-ascii?Q?S2JE0DRnNPyoiWvX+rXUygeIqnk7v1O+GV/4O7qyC8Rp0k/g17WbZxHrqLhY?=
 =?us-ascii?Q?tCd4Nn09jdrJSuBmj/qm9gPIWX2zB7qqf+gLlGcs?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b26664a3-6e8d-4e2f-b24f-08dc91d14e94
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2024 09:05:33.1695
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TcIKilvavvkK0LqxIsPeDWiBIukhaMsPb51BXowMSgDwi2vxvwfDqC29n1fmGPuAPcdeMnaiOwRXDlPllGs7Hw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR11MB8055
X-OriginatorOrg: intel.com

> From: Lu Baolu <baolu.lu@linux.intel.com>
> Sent: Thursday, June 20, 2024 2:30 PM
>=20
> When a domain is attached to a device, the required cache tags are
> assigned to the domain so that the related caches can be flushed
> whenever it is needed. The device TLB cache tag is created based
> on whether the ats_enabled field of the device's iommu data is set.
> This creates an ordered dependency between cache tag assignment and
> ATS enabling.
>=20
> The device TLB cache tag would not be created if device's ATS is
> enabled after the cache tag assignment. This causes devices with PCI
> ATS support to malfunction.
>=20
> The ATS control is exclusively owned by the iommu driver. Hence, move
> cache_tag_assign_domain() after PCI ATS enabling to make sure that the
> device TLB cache tag is created for the domain.
>=20
> Fixes: 3b1d9e2b2d68 ("iommu/vt-d: Add cache tag assignment interface")
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
