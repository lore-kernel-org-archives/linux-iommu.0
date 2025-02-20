Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0039C1E991B
	for <iommu@lists.linux.dev>; Thu, 20 Feb 2025 08:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740039767; cv=fail; b=IOntLanoqM+9y5VImKkqvS0hPr0iwGTFzbVdJslluDy+pYF7cCzc9IQIfjhyYiOEEI2Hbfw994Zvk2336glV3e0O+97bngoESLImcN+DS67ALsofEc42BAliQLchDv9vaIOIn720TqHvEIjYpxndf/GC0a/3hZ61trIfKWLOklI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740039767; c=relaxed/simple;
	bh=erfW8ivxHpwJiEISTWzyU3qvopClLkbmdfXAQVKzGxg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lTfTQ2N5rf4mLNjtqDfTxzR9hvD7p259s5MQ1TxkQClIPWSGi6nDDJhfnG9RHdm5mnhdrL6AXn0NnruNqNIgWEMXZQf35Uq+5WANNnNs7H9wXiq59zT20nLpN7mm/udQAzP6I9hwmBGJK0habg1S+dsUTi/0cwCXXKJPJe6P1Og=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BL+ThsFw; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BL+ThsFw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740039766; x=1771575766;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=erfW8ivxHpwJiEISTWzyU3qvopClLkbmdfXAQVKzGxg=;
  b=BL+ThsFwYhLn0RH5aWY9NLPJIR3uPRPEFxltBRfbB8rfKorkf6ps+C0f
   qyow9p4QwGuGCFjrMgVIxMy9/IFqqfmXpvvZsbwmeiBAUlI2L5f8jRgtf
   K3o6kJ0Fk/jnrCOgxB+fTPnO+blI4CC8+UGbV+w0/Iwn3AW1K/Hyl3jJF
   GnoSrhTuiCgJF/jQGJ8hdbR0m4eUqoBV5pMBl1izei6ZyZNW2/4/i8RHB
   tXLq3tbfWbRE/+x+dgvr8dimXbpqSICPINKOwcw0nxWJlqUP+Ddb1ZaH6
   nVWzfXkZpANpUA6XmHHdePu7z0MgQlSZFNcuVI1luqfqfbVLfEZfbXRky
   w==;
X-CSE-ConnectionGUID: i1bMegcrSCymRAogYJfmfA==
X-CSE-MsgGUID: SWeXjCA1SPWlWxwxYrlP4A==
X-IronPort-AV: E=McAfee;i="6700,10204,11350"; a="39995843"
X-IronPort-AV: E=Sophos;i="6.13,301,1732608000"; 
   d="scan'208";a="39995843"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2025 00:22:44 -0800
X-CSE-ConnectionGUID: ASF7lYWERHG6qDNpCbmWng==
X-CSE-MsgGUID: dbuQO7eySIqLVdGnDYKKew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,301,1732608000"; 
   d="scan'208";a="114920164"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Feb 2025 00:22:44 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 20 Feb 2025 00:22:43 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 20 Feb 2025 00:22:43 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 20 Feb 2025 00:22:42 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q6M+8m18O0QjZRg5B638DouKB+YIQjfqFGmnYXO01sZ3vr3QJXSH5J+P+1YVVPSjm6jOrPeRzlQepDy92TcCu/pCxokwz6rKan9WhYvPdSYl/jVM1J+2o1jpLA32CoYRjqAQxCUqieStLO/nVh7iMKb9NhPeJyH5rtU3ZVtU/1J4+N29pebOo2Rh4WwH+p74vg6teAkvMlZ6jj/GxqpbJuxqNeqskU9sVm+BLPfVcZ0mourk4xtKaew6cSJxVKf/MOu5fTOU8tcfdAIQYpdFUqeN12u0nqj5vNOHr1hfsJstCoG372nNswGvsto7omfUZhiyuGAbOeGfe9Lv7V0aSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=erfW8ivxHpwJiEISTWzyU3qvopClLkbmdfXAQVKzGxg=;
 b=U7vkwHDCBwBnBYEVx6e8QByHs2BFGMnaFhyMpUD0TwSeSLgqzF+Kn09oGiFfMri6aver90/YoAJNF/odF7cygfVntI8tyZ78DLC3hMWOA2V4riOfb/20xOge8wFJymHOBUul5h5ZYKey+f4Q3fLfpmzNsiSPjBOSKrWvF+0xUNmXDH9CJWJPdzNBATglJSUiLxn6orE7F9P4EHiw38/eDXU14UNzEN2bewAikWHtgtg7K6X6w16u9d0p5WRl1mMQm0+zV/NgKUDztkjU93+zUcfVCpKnya6S+g8en8gndxfEcD4ivCVdiTzzJJ2eEiqnbdAZzxjDpwlA1eMAZEPMow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by IA0PR11MB7861.namprd11.prod.outlook.com (2603:10b6:208:3de::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.15; Thu, 20 Feb
 2025 08:22:35 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%6]) with mapi id 15.20.8466.016; Thu, 20 Feb 2025
 08:22:35 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: "Liu, Yi L" <yi.l.liu@intel.com>, "joro@8bytes.org" <joro@8bytes.org>,
	"jgg@nvidia.com" <jgg@nvidia.com>
CC: "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>, "robin.murphy@arm.com"
	<robin.murphy@arm.com>, "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
	"will@kernel.org" <will@kernel.org>
Subject: RE: [PATCH 2/5] iommu: Drop iommu_group_replace_domain()
Thread-Topic: [PATCH 2/5] iommu: Drop iommu_group_replace_domain()
Thread-Index: AQHbfRQs5TW3PS6fXUGyhpMfVj/k1rNP5ukA
Date: Thu, 20 Feb 2025 08:22:34 +0000
Message-ID: <BN9PR11MB52769350A6CD7A7E67E022698CC42@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20250212060540.261436-1-yi.l.liu@intel.com>
 <20250212060540.261436-3-yi.l.liu@intel.com>
In-Reply-To: <20250212060540.261436-3-yi.l.liu@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|IA0PR11MB7861:EE_
x-ms-office365-filtering-correlation-id: cf1f855b-4ad6-41bd-cd11-08dd5187baa7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?I0scWQyUCP9+KCA2mPaHKoM7aGjLJmOiwJ6RGF5ZMQgChf849FjlHtD8uWGF?=
 =?us-ascii?Q?ExUc9bzOnc49d0hItMXvEDPkD8o8VFeCXmHQ1JQ/0akRerP+r150UCFJeBlx?=
 =?us-ascii?Q?zFgCSu+ckNP9Jn/haKXNdQapJw8ayQU0TQMeD5n1h7Ua37ud+4dnMv1adOXw?=
 =?us-ascii?Q?HZxjAJXSuhssLjt8oyKesweWNXVv8Rwmqyi+LZR1q17PsHmEFfu3jIKk7Dq+?=
 =?us-ascii?Q?be+VULK4bFqSIJyETjZ1Zftg64XiAyThB7XhQyknk46Hu91JiKK54HskIWwL?=
 =?us-ascii?Q?GkW64nbaThshU52sv3z1hHhWmQ565wWLQMbyFYhm7AMGM8LxZ0mxfcT28m9f?=
 =?us-ascii?Q?xytdW4z0Vma9qc+aTyMsoJ14urianmXEVSLq9E6L7aOr3VtS0xmiIW1fQGl7?=
 =?us-ascii?Q?8waxweTBXv/vsMH8bPiq+r6TXpG+92p8vY6lAFa8EzBRExhdcUvl5PiE3mGU?=
 =?us-ascii?Q?8wbqOtc+nnx77/qvR4T8Rq+MMHfTSACvs39jVO6lWcKb98LksZiS64aHAK0P?=
 =?us-ascii?Q?IUZwrtxb/DlHTP2Dcodm/luJ1Pm2/uLs+Zw4c7ankyJGnAsPbSsO3tqV7F5x?=
 =?us-ascii?Q?b92TgdKHvXEZ/qvbLDe18OHU52Ha+Nno4ELQmLOYbx62lJi0+8I1t6MXlV9r?=
 =?us-ascii?Q?tO9KgfkoCd+5FMeE6p+c11/ne+eT0i+q1P+0j54uh0drPj1sha70i05n8bdj?=
 =?us-ascii?Q?3c9le/2dYnlwnqPDBenWe1B4wP0oAxrtUpiUJHZLF99eB0o+xn8BYgTJRRLB?=
 =?us-ascii?Q?NyGiFqJlVa1tExoR80yU3nxRwAKfZ+bDR/gIh6zjengUUle7kkltlQtKJvl+?=
 =?us-ascii?Q?BdxSlWwI61HE1ErP5bjFmLBBKEw3CypYabEYkrucu09Wa0SdIQ2VqmdyWZ2V?=
 =?us-ascii?Q?6Dm1hTSsyEQXtPloOdGFbLzUgJDQBvrt+kS5ZYl0WP4VMjgBSQ2/psLfYrW6?=
 =?us-ascii?Q?dwjvYcLm5o+ZZG2fMAcdSwEOmpa7YOVD1WqpFlUw4MlLVxfpY1iFjvTHgcAa?=
 =?us-ascii?Q?t62Cxa6x54S66sb0W/BtCpOtu3/lkYA1jZQT8zbeXWiZTOiM2cDatCrrXe4l?=
 =?us-ascii?Q?OgWjQujU5ZIpFqNx3Z+qKFgLXiGXui99TF67qH2cvo5SRHMCYZepavaBsj/i?=
 =?us-ascii?Q?0MkrEu2wB2AEDwunLjXcXpZrg975o1FdNpcnC490H6VUpKT/V2Bl2TVRtCcT?=
 =?us-ascii?Q?5FctEOfSvMk4HbzIu7jBYDamNGnFsuTKbaNYNqLoPJohXzVAnc4VA0C4l0nQ?=
 =?us-ascii?Q?NR9A6vlBbYvYPZQZJM8lPcRU0eOAy+eZ40RkUykapu+50SMmzpMrYDqL51U+?=
 =?us-ascii?Q?SXDcOr833BcaVdtPeUPPdDOrTol5dGDoU0Cxc3t0zqMgs1qrY2GJRO0EXsyA?=
 =?us-ascii?Q?ScqGEWrCQokF7aCmwxJYSDC+cEKO9fl/rtC+UhDVvEy1psuS7y+vmi9xJ3tz?=
 =?us-ascii?Q?6cJqNNxHU97QpQ21kIGTA4qxYh9KvvWo?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?frPFnsqy/Qtj2hor1a8JVxM4ez/9p6kwYAxaP74DvCq4alvBv0kvgUYsvQ8i?=
 =?us-ascii?Q?NA979POk84CykhiJHrq6LiSn7hMhLwcorFWgwnuEariTpQqkYuhXxl9qMglf?=
 =?us-ascii?Q?L0do41e8E+ulRiiPBAPvstSb/cJz7blU8kI93CxqnWkJ/jIXGJUIcmA1ruM0?=
 =?us-ascii?Q?z1fzRMRdhh7TaBizuNe0JUtNSuI2YuieJ/TosEc0mAxjkBo76FgetjVJNNzb?=
 =?us-ascii?Q?ZtdL4Py8TvN8hg5BxT8jiTX+IFVP9L4TjM1CzRU9qgNJq3hmo0vYuMffXoIs?=
 =?us-ascii?Q?d1TrKWgFcfe7tFKWqstHNXZc5gPvaDmF5S+WffhFFbM6dkXSITCauEs+bqil?=
 =?us-ascii?Q?m0i1zxhPXtrZL/tWUOiqerQsiP+OfaFyqHbh7cIZRweqWI26h2VEh/W8lRdv?=
 =?us-ascii?Q?dGUWR1hF0VIgweCQLtsNnSlMLn/hzJugnsLVCTWsVN/RziSTyKObY/PkDVFE?=
 =?us-ascii?Q?jNy62q19ktjMhdO9271rHRHa5bGjmDWFU6gLbr+11X6i1ftq+0aceJqCGzId?=
 =?us-ascii?Q?8iLcM7O2mu1cwACur99X2yDG+jYxCchjfwo0HAFzcEkFgprY/opo1I0GdePW?=
 =?us-ascii?Q?LtpRSfYWfb663Q1X/6IFWSl3TV0n0xUsaSf61I1Ejg128JnCiLneNbO/UG+A?=
 =?us-ascii?Q?YyMBWNrp2Nt8tmDkTgGYVuJr3zXR1ZNOl5GuwdM3Nkuh0HWI9N5s6wpPzwN9?=
 =?us-ascii?Q?Zdq7Dr2KxoEAFUqbNgByWLv0MJFeH0Lbk6eqmngQK8XwL8Nhkt3dCtBn/xdD?=
 =?us-ascii?Q?3nQRqOKtnK+idi9KJH6F9CVagPMLDFFQ8+kTLyVLfLGg4KTknTDcw6/84AW+?=
 =?us-ascii?Q?jebFU/5nt+UXr34ayXsqEYhEcnKx2++DnbBcoL01ZLpC1HW3Tvd6bpibit9J?=
 =?us-ascii?Q?33GvUjInfxU04y4DS4t6zkWIHuLg3riI3ht31LtwDQg5BsQ/+99VPkzNQUgM?=
 =?us-ascii?Q?BqiUXAugFnBvo2QHjJg43t7Xz34TCuCeZFbTWPtjHzr3zmnPnggCk6LgZHG7?=
 =?us-ascii?Q?z9Iof73bJY1x/5tvu0BxlR71veKSa78yiva4ddZmAh8blopZxqSnWZKjESiL?=
 =?us-ascii?Q?GWRmUjpPcBkaId520zRRc0weyAkfe85Zv1gddyQ1ogguAsKpWHAKxZI7r/12?=
 =?us-ascii?Q?39Hm6GfnZ1ZV5kRIzPWF19KVdPjBVDdqFiQL6vrD+QIj0YKSS9jF9ie7+V/n?=
 =?us-ascii?Q?c/IJlCgFZV6s/l4Qz1ZhKgwtYmMB3yOCLgQm8gokZWwifXwmqnyDTfc7b/Xl?=
 =?us-ascii?Q?tMOpRisklY0lLRzBq0xEormiYV+fA7F2hNIA9LVByBtmg51ME0RP+JY9vU0V?=
 =?us-ascii?Q?nzJRdaDMfCsI76GLz3yzI4JbvbhmY2HwjGPHxo751P30pzOboCBr8kBbXVQv?=
 =?us-ascii?Q?/DPuK5/BsqiWDirkjzJKADrt8CS3yq4XqffYGHbVnsaCSHUxeJYDaMMaxdq9?=
 =?us-ascii?Q?9CXjtsXseXdFpkaA0lytbosmxycaTw59GRaz+mJVbZz/TlHmmZFNIMpCnoNR?=
 =?us-ascii?Q?HY9jze/CkZT+xK1sngFpppK6c0hXXkQtbwnuX+IKT19fCig4cct89jUVWrLI?=
 =?us-ascii?Q?G9o60Kr5JFqAfE9JOAU4YgqazSCu41GtA4qLnHsA?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: cf1f855b-4ad6-41bd-cd11-08dd5187baa7
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2025 08:22:34.9930
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mj7x3aOwlglJYqTIHHd6FYQxiN9wD81mpsMU3uwjIaRN45FRU8M+2OPPQ+TELlvsZ1D3LfTKKWD8ngrwarkoAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7861
X-OriginatorOrg: intel.com

> From: Liu, Yi L <yi.l.liu@intel.com>
> Sent: Wednesday, February 12, 2025 2:06 PM
>=20
> iommufd does not use it now, so drop it.
>=20
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
