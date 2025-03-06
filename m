Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F1D436D
	for <iommu@lists.linux.dev>; Thu,  6 Mar 2025 06:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741240917; cv=fail; b=dpTy3qu2JY6muStvx/9CkpSkGtRs6hAgYBaot6P14GNCE2OmUJEjLwpU6Dyu4wC+9bjbIQWI1dOu7RfixZ9UauwZB+TfiswinQEQGWVMJS3/GiTyqAmUsM+JZl8BQ+4Q04WyQlb59y+IHHuBQY/i3iqUmorKA/BcyczHwJ9BUlo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741240917; c=relaxed/simple;
	bh=vkfvbpgAEEe0Ke/T/JikF7uJ0/zDH3GqQfBiW89Kizw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HK/kSLPnvtMoMizkibjASWUjpT1p/gO9u/y4nhQlf+sLi8P7HrDP/QtRT+z4oa1q6o8DifjXDrF0jc0QLrdnn76wIreNFkfxRraBAy5bDvO7RaF1TyFe+DduoKFlTqD+dxNJ12YgYkMP1fpTk9JgT+yKSkqCZG86KvVzYkGyT5g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OTI6ILkj; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OTI6ILkj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741240916; x=1772776916;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=vkfvbpgAEEe0Ke/T/JikF7uJ0/zDH3GqQfBiW89Kizw=;
  b=OTI6ILkjZIABpiz8366KLzUUzYILae5/4ZoC9D7f//Gq4eRdeIOK7DpG
   7SO9NB5p1ubJRwmLyCZ4kfQdIEEd50IfUDrH3ifZnAn3ITDJ5BkBJDS1P
   YDLv5makIqIN5Iz/LkLpjaM1od4r1bO2gkKv4KT0Bp61WZ40+RiThsZR1
   RTsTDzcq4V2+GYDZAeJeriodMCqWeH5uLZhiPrik/ceVPDoe/CzoqYK31
   k4tLBEenBdqv8oleBd0OBw9r0VhVQPlCLYKy4Qi2MC3FO9o8GlBk8clXd
   n/frNei1BTJ//r7gsxuHkkK/q4MN/lrpAwyMQwLxsUvDjw9Wct5XsUmpl
   A==;
X-CSE-ConnectionGUID: laoy/UFVR3GvOdZyZQPauw==
X-CSE-MsgGUID: 3wnqfSjlQWOFTSbpXnbhFA==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="41409564"
X-IronPort-AV: E=Sophos;i="6.14,225,1736841600"; 
   d="scan'208";a="41409564"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2025 22:01:55 -0800
X-CSE-ConnectionGUID: FiFA/WmxRTCU9HZ0JQCDNA==
X-CSE-MsgGUID: yrpZ+nXfT+OhuLVV5/762w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="123065391"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2025 22:01:55 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 5 Mar 2025 22:01:55 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 5 Mar 2025 22:01:55 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.173)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 5 Mar 2025 22:01:53 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tf+fG25z5/htbJIB811+vhnpTNxdH7Njoh3EGj1lxtrV4d8BT/gEsjAp6cXccgoX5eZRRknvxJuNEEkUWRjMmr1hJSKbtjhtRfUOiXrbKZvsSS/y/uWHQokur4JaSfqDyj1s+QWNzLPe/duYyhgeM6Y6OWrA0Ze50BzbrGqHx8KC3Up2H58a96X8FcsTkrCDCFQNd5zpegWb/yXCUPaXS9MNDRhUadphDNbjLJNKGkG8tLtOZU+3OHyQbR1tOyb3gHpT0CQkfCFJ0P0jcs31BSDoq0o7tsHxiAtkMWdsS2Bz37Meu27aisKXD3WgyMhc0SzUg5sNascjxd2nrxuVwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vkfvbpgAEEe0Ke/T/JikF7uJ0/zDH3GqQfBiW89Kizw=;
 b=yucDCH2ln0PGmLmyaiBIbcDJUs4cu+lGKU/0oleL/yVYiYP2rekGomMoljsdW5CmPTjFUxtmTc7f2kDp7pF+l5OABzqI0yzwyoIeYYxUP4iqjBoUUOnQ0iydhh9UhSKa8KuOHHuJ40UG0V3DmHxmNNsVWa5zERs9KOHARDSCgxKfZRaqqBGLY+GQbtG2KtiFo2n7K5hX7s7ciiwkyPAMtcPcUkqpEMDbu0z872w3jJCVVsPfF7GGVMSaWNT8dcM4uuw3wY+8oZeSxOQp9usfl/DTfjlYEf7kJa6jZXtoh73XH4tyj/xmLGd3H1F/OTwn3B/LVn08JZbsYVtO0mF82w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by CH3PR11MB8706.namprd11.prod.outlook.com (2603:10b6:610:1d1::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Thu, 6 Mar
 2025 06:01:51 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%6]) with mapi id 15.20.8511.017; Thu, 6 Mar 2025
 06:01:51 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Nicolin Chen <nicolinc@nvidia.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>, "joro@8bytes.org"
	<joro@8bytes.org>, "will@kernel.org" <will@kernel.org>
CC: "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 3/3] iommu: Drop sw_msi from iommu_domain
Thread-Topic: [PATCH v3 3/3] iommu: Drop sw_msi from iommu_domain
Thread-Index: AQHbjH5TCimyxm71bUuenjSkPehwbrNloVpA
Date: Thu, 6 Mar 2025 06:01:51 +0000
Message-ID: <BN9PR11MB5276F45A0E75831D0DB8BCF28CCA2@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <cover.1741034885.git.nicolinc@nvidia.com>
 <17eead28dcf8ae6b246471c05c2cf1eb0774236b.1741034886.git.nicolinc@nvidia.com>
In-Reply-To: <17eead28dcf8ae6b246471c05c2cf1eb0774236b.1741034886.git.nicolinc@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|CH3PR11MB8706:EE_
x-ms-office365-filtering-correlation-id: 98dbfd73-2d3b-4a25-96c9-08dd5c746372
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?7WKffw9YfBvSOl/Z9YDAIKEF/+qrWlybwvn382mf2h93xpGZujSNClByDri2?=
 =?us-ascii?Q?q7MzdZFo79C6ysF5E5IFRTtA/SU8sX2h8b61Qlz7/Ba3b8JWdI05FQgs0Qow?=
 =?us-ascii?Q?eKUCSh5n70FSOyOoz++MB6eVplWxg8o4rGBKPIcOPHC7WXSoJStrEG/1WbA+?=
 =?us-ascii?Q?FiyiAlKOD3la5LXuP7OMQwdP9AzNCM2bTyPQLp5yf9SmrZV6uUz+8lLFKxrI?=
 =?us-ascii?Q?WEKc1rLGRK62QHtMcAGrO2BlIh2kSbDX/7uLPdOfZ8VA3Orm2zhTys6n4q44?=
 =?us-ascii?Q?dAz51ALWtVO49rMkvoBhDLkvO07Ze45Fov5ptIDDCCGSzP2GsXlhHuJUQz9W?=
 =?us-ascii?Q?NYPaNAxX1691pExpy5uj5CrJ7X6DlDBQwVz1VyXyUFYxBGFZFcrZzRp/zzhn?=
 =?us-ascii?Q?cmXBJWvRDGz1LymLftsl+U3Xb9BjkBjDc1x8B3TOlsQCi13O9oU7izBgR8Z1?=
 =?us-ascii?Q?MuRPfaPfu7NzArpxjpTU3NAcRsidrabmUuEv+LPW7Jy/r/eZmgs47jHlX7o9?=
 =?us-ascii?Q?8375RKNCZ4CTz13i5sr03DQ9u5nJKgHu3tRVTRf2/DahUu05zIH1kU+snEUc?=
 =?us-ascii?Q?pFVS0rTPNjY0t2CcZX44hDPyVIyyhCXEbSyTv+3pTDDwGZ1eCaRpKMC/E1fv?=
 =?us-ascii?Q?AfP9MlcbuUrE8iKOpKIZzC4UxC/zxCi6C7qfrGoY+qhJ4MZOf64UUKpk8bL5?=
 =?us-ascii?Q?7RK2Od76DFFpncSxR9ElyyjNJiWx0cA3y7a76K2HaW/ejbnCPSY46SDWm3lm?=
 =?us-ascii?Q?Xq5wgmow16kZCbCzmzUX0dLruMkM2XRfXvIq0i0GNw3V9XjCa/MtbYM6qmA+?=
 =?us-ascii?Q?zIGC+6SGBuHb3S6Iqwcl/vk4YtYxIUc+wHSaxRJL1jFnIYpKcsNp1k/vb9r4?=
 =?us-ascii?Q?57ufRqFCioF8t3lfKRkPmzkNRk4DUeu/aXtLEBcEcMizniTj7OmV6z+otIvT?=
 =?us-ascii?Q?Ig9Lf933DhjllOlEa63AeVcxsu9YkQAqXqAO2TTA5tx0XBVzLMT5ONP6CHAu?=
 =?us-ascii?Q?0iSKFYBv75EjGSHYGwKfsmFiqAG2RDT+fYHZr6blC7DDkFbs0wNU7tUcTrlY?=
 =?us-ascii?Q?0nooDCmAM3lh1Z+j2Uchr2xaCVlqGvD6cSOHiKKbEyWBQnXl+KQlHPzjAfJZ?=
 =?us-ascii?Q?gPAo39h0vJfG4ua8LEB0CN6f2UZzeyTtuYDIPfl7NykfG7+MiUH1Mx6y0mzR?=
 =?us-ascii?Q?4SovzHYwN+rYCv/p6rJKJmo4O+/tGbHFbeY3OhD7tvNcVnBVE80G+BMQXEcK?=
 =?us-ascii?Q?2SPN1FWw4Oj67Usm9W0rXaBvLhNGl98wEJeBvwGPwfVf6NRoLA9CtK7EWI0Y?=
 =?us-ascii?Q?k74KeaZd6GuyuXErCaxR7l8p8AjQeDZ5dK6vkk8URk16FAQAsm91YcNbUBhf?=
 =?us-ascii?Q?wgXtacNLC672UqBO6j9NZf8hp0cMllRUGUeOGixV/0seIkyiWOemTe1F5PzS?=
 =?us-ascii?Q?gKzIaHuZmf8=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?5CfxlzEPisDyt+WqeKE7fu9WCOZvt1d1eUy+e89B68JU53gLSH4THZJ5bbJU?=
 =?us-ascii?Q?oiC66aiJYhNyr5Pm72ZvPDKhavJJJeA8GKQsfJ6pvGZ2KkbAzEF2RUIYpvtO?=
 =?us-ascii?Q?ZS91c0XMrS4zTPaViosIOB35mKvo6wXhOkQYMjtGuwL/GGDYNuS4W7P7B1+J?=
 =?us-ascii?Q?dxyWMhoko4ooMQ23STfoRKbNxo2XEWkxiNU+lBrm7eEIkwwZbQdfMIRt9Iu9?=
 =?us-ascii?Q?G2uG3K+Dq3Bj8M2sxtQDxvZwG5vQ0yxPF+ChEnQDiIEvssHgjSWWdt5uBHdo?=
 =?us-ascii?Q?Mbyf+/WlMyupZnhIBk1yPnJ7BR9QuuH3ijMAZoKxoZOqelUMupATiYVUc8oK?=
 =?us-ascii?Q?Fy7Fr3+u6FF7B56Rn+0Hmg8dClK0ZUJS1kReKSd437/lbFTrQRUa8jeEoH4Z?=
 =?us-ascii?Q?//w7SjVoN4QrffVGAMqjHHbjLMekd3jnQEJAIpImzizp1s08HHfPx0eMNaAl?=
 =?us-ascii?Q?0YXHCc6VCmU7mqITOOmDTAwVaK2QldAk+Rj3UpEiDMM2P0GU6j1aMSMkLmLj?=
 =?us-ascii?Q?dMlCG9Bp5VVqvt4IaUFMLvisyLj1PdFEriB8k672Dz7byAJClsR/oUk/B5HM?=
 =?us-ascii?Q?KUwRE2w+cv2xcKzX+mgn18zBI7wg6/nSDUYeQE966CWqT2OLgrSkC+6QukyZ?=
 =?us-ascii?Q?u2ZYxWstoaXRxt6XB2CMZUJqrybcv2jgtI1OLYqCXUyPDu8HSrYPjYEC2ZvV?=
 =?us-ascii?Q?N+KaD7Z06jjo4grvT+ygoCcCuTL+tYdzLJiGLHnsG4nN8PhzG3ObkActa5bz?=
 =?us-ascii?Q?vVcjzj7LTdbB2Wpfg0BmHMmGUzPfzHwdcX07yH8h5CggQhI1/WkyMruxZ11X?=
 =?us-ascii?Q?PBn84XtCRsKUNC6Jiaem4VELkXh+QZe+uWItIIGa+o4fGhuAvnoSZH9VMMny?=
 =?us-ascii?Q?WmZ+OIBhtnGZuUCNP5SyJFppLoMxfPvJLg5QD9xaeokQrLoEa+PxifMcpz+b?=
 =?us-ascii?Q?vmY5DhX9dWal/Y1W85AVd499T+7QojSZJ1mkcbou2rP3qmlsPuBk4BUAzHVW?=
 =?us-ascii?Q?rPxOPRFlbgMOC5Us9V3YcQ65VS1zpXqGDw/bjoEUM2Y4HXd7H5kbnhkT26eP?=
 =?us-ascii?Q?AJ9e8SXGOYEmYoYIhJ6Nyr1dbaXXS4EvnKTYcYnwNW7ioHKB52RaK6s1DKEO?=
 =?us-ascii?Q?yN2bmn+LXvuSQmpcM3JAwJmfv7yPXWLPUaEnl1VdMMOw3WYu+nVySM/pdCQE?=
 =?us-ascii?Q?8sIaJQXgMgZ8FrL1qO4nK/KUE831u/q+4pjz6e+Aw4ggHizHThl6WMOgRYlr?=
 =?us-ascii?Q?VTHlLmtp7CtVtvoqyssk0Ap7B1m8LHpszgAVEe1ZfjQGiXbzgpFEc3XxuMl8?=
 =?us-ascii?Q?GRJFGvB7ujRSyPmsLnrQ3FL4gOIy35PDih/SXZUXlkM75PuxFBf4n+7SWL+P?=
 =?us-ascii?Q?VH5+6LPy0n4Kg1hQEqWCelT00cC5z4F3/+IDaxgXj0zz2vaD7gDkjfukzilq?=
 =?us-ascii?Q?5KVzqmVbKDqkAOL96Ikj6R8sVmPJC32iI81eYXE7ZysKiiNHuQAoET+qwXgl?=
 =?us-ascii?Q?VuL0CLTgkts1P8KONFb0/gZdacIiYVze5loHaN/xK22sR3d6dqqKbhzqKzte?=
 =?us-ascii?Q?vVAZXVv0zcSproifhBpj7WptUmg2FFlJUDlwif88?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 98dbfd73-2d3b-4a25-96c9-08dd5c746372
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2025 06:01:51.0855
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: n8rKk5RFBFHr7pWpGAH+so5gZOlPE88q2e8TGbACMfuoc3tCEGtab79DblRaZRc6cgQo65UQQNnMAxQ88DbguA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8706
X-OriginatorOrg: intel.com

> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Tuesday, March 4, 2025 4:53 AM
>=20
> There are only two sw_msi implementations in the entire system, thus it's
> not very necessary to have an sw_msi pointer.
>=20
> Instead, check domain->private_data_owner to call the two implementations
> directly from the core code.

s/private_data_owner/cookie_type/

>=20
> Suggested-by: Robin Murphy <robin.murphy@arm.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
