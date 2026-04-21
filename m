Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B27781B3925
	for <iommu@lists.linux.dev>; Tue, 21 Apr 2026 07:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776755739; cv=fail; b=RwsrKl2jKD9ebIzcbvBbMWU3avTmtYWnWwaNoCuuW7u9sqQB8JQXjIWvtPXPA6PqDJm3050ADFBj2BMSHif7uMkCznN0rmJaASWzkXmjrvLDQqmuxCZe/L8k7s8N56jrEX4X7qMQ3LCSQauJzaFefSo0zcAQxxN8oPuGJYqmVyg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776755739; c=relaxed/simple;
	bh=RFfLbbrboyb9L9FjYzSSRYWng9BxTi8fzcJ6LIgJd+M=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Hmjl13DCN8ZJNeWmUmyv9N74lsKK7iA9yGuaT/yQvgY3p+S89uWDXEo4v0opnS3h1s9cA5VFBGG7bNtut8yleN8iLqKu7yxmlVGx2dCp/o+kNkJkWVLXqfMaHCuF5LvPl5UI/kqZqyL6zilx0clAEuPsR+S2e3d5d4i5H9w+KsU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Iw2qzeUI; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Iw2qzeUI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776755738; x=1808291738;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=RFfLbbrboyb9L9FjYzSSRYWng9BxTi8fzcJ6LIgJd+M=;
  b=Iw2qzeUIS/cJfJqIi7ZIwb5CmcuwqRrQvZhBE5GmCOO26zPt0bf/diS4
   MMCK/zGpR1suP0/dCYCwHIZLJUdvR3A7cfn09guxR5H/MZ7UiUA90WJjC
   jcJ9WKqCg7AA/ljHVdV8ypzFALDqJ6A8CQU/mQ8jSTH5LoM3QXSYd5XjK
   IX0/vpdGWP6qWdfyZ6xTlKOXAwmOS1evTS7Wke/TLJSwbBDwtyYpA66Eu
   LA+gtHVypehY7sAJeuFCJ57gs8dpzbqwWYCHtQhICJmUlr606YjQuueRQ
   XLzR5kC4VraJoyT+sUNic6kFG3RQOdKpilKOA1uH2wynjBK0HDHZSMIsC
   w==;
X-CSE-ConnectionGUID: 1gGF23UjQhufVPsNjcl6zA==
X-CSE-MsgGUID: ov+3B/thR8Kd0nDd/BLhNg==
X-IronPort-AV: E=McAfee;i="6800,10657,11762"; a="77555333"
X-IronPort-AV: E=Sophos;i="6.23,191,1770624000"; 
   d="scan'208";a="77555333"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2026 00:15:37 -0700
X-CSE-ConnectionGUID: Ra+Ulkg/Qqi6zcPfEg8brw==
X-CSE-MsgGUID: PBsBVZ6nQO+eOLJ3X73SVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,191,1770624000"; 
   d="scan'208";a="229287431"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2026 00:15:37 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 21 Apr 2026 00:15:36 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 21 Apr 2026 00:15:36 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.69) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 21 Apr 2026 00:15:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RmhDAHBFlLdJAohXwdwlNyObi+rwln5bXkPAEzH77O0YI2C202tBHRXUH1prp0tdfDmuBxxbcIewMovERBgW8yMLOQUfpuHKH8eDvffgxy/z/ZaLEUc/BUWmSUg7H9vRTd2OAIBH24nOrO5B72wuSaNsgrCr09yjvDzs3gIXfKRIq9DUKiJVptdjbV1pTGRAis1eoJgqRtWfdGQnoBPjlIZTZ5WMPJnhr4laJCEEc8Nr6HqD7j0d4xYfBxGQrPvdEC2sp8zz+2HAkWUMb9PkVkn7xK0nlnIFUlpxjpniKzVpVQo3UBvvuvA4G2fvnqFdQXx14HLsbJvzKrB6qXZVMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RFfLbbrboyb9L9FjYzSSRYWng9BxTi8fzcJ6LIgJd+M=;
 b=ZX5Sbq+1BBRZPjz1MY4hpiFg8yW2FoCT4r9hd3QcLtHGQM4/V/dq144kt7bN6tMt3wsOiBNWLWqB11BVrcBjolg2U5RuoMxUZ1IxM9sv6VxhE2X5GWS5mskDSNQNosvH4jLu2aQCVT6phVTMdO/33iYdCxGwBuRX7/LOOqdOtX488f4qpoYZOmxEyjmO9pLmgo8p5J11gHDNfEAENvWsQHi1w9Sf9lWR51D6+nw1ZkAuqC/oZiha8ilBqDwqMcE9vZ0j9lSlA5kSV0D0Lpqkhr6AZwcxOdgYHhNvSDoZZXqyFBJMoK2ODrrCwy+YPatPtgp0SwXXlEXgSmcX31IDaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by DS3PR11MB9645.namprd11.prod.outlook.com (2603:10b6:8:38c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.16; Tue, 21 Apr
 2026 07:15:35 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::f997:762f:f079:134f]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::f997:762f:f079:134f%5]) with mapi id 15.20.9846.016; Tue, 21 Apr 2026
 07:15:34 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Nicolin Chen <nicolinc@nvidia.com>, "joro@8bytes.org" <joro@8bytes.org>,
	"jgg@nvidia.com" <jgg@nvidia.com>
CC: "will@kernel.org" <will@kernel.org>, "robin.murphy@arm.com"
	<robin.murphy@arm.com>, "baolu.lu@linux.intel.com"
	<baolu.lu@linux.intel.com>, "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"xueshuai@linux.alibaba.com" <xueshuai@linux.alibaba.com>
Subject: RE: [PATCH rc v7 5/6] iommu: Fix ATS invalidation timeouts during
 __iommu_remove_group_pasid()
Thread-Topic: [PATCH rc v7 5/6] iommu: Fix ATS invalidation timeouts during
 __iommu_remove_group_pasid()
Thread-Index: AQHcz4z8i5bfRAAe1k6gG163liM5i7XpHLow
Date: Tue, 21 Apr 2026 07:15:34 +0000
Message-ID: <BN9PR11MB5276FCFB54325CC9A3E048148C2C2@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <cover.1776551790.git.nicolinc@nvidia.com>
 <8914b746d0e19b05a26c1fc5d14f170336faa3d2.1776551790.git.nicolinc@nvidia.com>
In-Reply-To: <8914b746d0e19b05a26c1fc5d14f170336faa3d2.1776551790.git.nicolinc@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|DS3PR11MB9645:EE_
x-ms-office365-filtering-correlation-id: d95709d8-b439-42d0-05b1-08de9f75c810
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700021|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info: vgCXaroWsEPk1hLdiIRwwRO0f9GB7awJTZJefQGCJPM3yX/nFt2O1zdf/BXXrqWxTWROEUxrt9b0E35gtygGRF/1pLdNzssTRbTxWBprQ/n7B44E4PUrqSDoJdHd8LYdmeB3RSy31/P9c3QiUaS0PKpltkQqO3QER93KFYmD5bnET8AxHv9ppq+icgCgvSguDkDVoSbEtOxLI+0X1KzMaZJKOUNaGzCIWegwgqjTmTASwmIJACtgfv492mWvnpxYhtzCztXgcZZG6bk7BxCeL9lHWjoJHq3K46cLfCT9O5dYWxCldZ8mE3FfjWaxop6pKYwvlRDHd/cDDSSrcjjJVo1qmWPRQnMQBrY1sWqyHxbpHzBS9spdecp7fxU8eDPBHAby1OIDpTXfZiaQrN3ZshSFzpwpoZNXRI2mTgMHCkI6Xzrl2zKckdurJ3sNWCeVm2nof0Zoyyr5JPByHrGTLQY9TcGvYX0XIOpSyO8TGQhgfA/0mFABJP0fGi6Y+ZM2UlxdyHcPofAspkLfd88QdaaClRiWsSjNpbDFVJ8uQD3WNse6XUHwP/wLBnIHJC0JTVqrp95UO2nRkolIfEjQRK2WC/thH+b5B2iqHP6b4zqCutW3s+Vm4xUkfGD3BeW0Qqvl4X3if3yW7D26exEhSHdYm4Hr8tl/wDNGTiI85Z9Qa5E6HvFILNS6wuQ/2tB555GjdPtBu4ZShvb2dgH71iSmKMv5JBSFwJtH4C0Q7O7wgj19EcyqqaFXdNzX3KS2f0Q0rq/Na7d93Huh4iks0A9+Ed1tiyC/Wpu14duriOA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?kGuTQL/y9q3bbmg10J3fGJ2JOvYjoqtL9Cn0T1krYBekgUEJpN4/vxAY4uKv?=
 =?us-ascii?Q?ErD3HDPSR7gDAWgXfbaRQZrjOOe5s911Fm7LkeKVL5bY26jULmjSgtMe6wbu?=
 =?us-ascii?Q?7dzv5CIokytAhEPeXgRvRwMwToMfNTEi7mJ+Cxg8DprwqhhojDWKYLcjvL3a?=
 =?us-ascii?Q?M/IyqNFyc0mhypB8pCCLIvS5IUqDVKp4O/XyG1DRrg1AbEJR284dtIjB32KZ?=
 =?us-ascii?Q?RVabpxZE5vJZAIARJDN3xQepNCHu1zZkaQLpPg+xZ+MTBN7fg9xymF1wHlQ7?=
 =?us-ascii?Q?SP7mrdczK566CW17DpPyjtwXnjhXz1xASkvC/QFnmBhoEr8UbcGE+y0xe8D8?=
 =?us-ascii?Q?/iH0i3AZo4yf3kil6dwm2jlObNfN2nRYVlqnoZS8t7E2B1yyXyQk+5vTdw29?=
 =?us-ascii?Q?at2FcNqWeZyxN7qEhbGWQkRnqcIJg6XDACVcLzCUKgXu8k7mOuluKYAputli?=
 =?us-ascii?Q?9KR+dI0UBRIw4eUaQjgviRrc/CUclFcmN7sf0jg3N6T2zvhUdMVWwSmyS5w5?=
 =?us-ascii?Q?9KmrUp55P5VspF+UbtWgYW3IUtzDNslQWgMJ6DxLAYVexjf6I89ZfYQMJRFy?=
 =?us-ascii?Q?yL5UjUgJvxsRRq4y77dNnHJII+v9+eBn2YrJ3382fJUbkpkVJoI3EODpUUZH?=
 =?us-ascii?Q?u1ZhYGMjSMsS2PjffVwlqClgG6jCcDnUhvQ1s8msRSkYWojIWIiFhhQrK9KJ?=
 =?us-ascii?Q?ItuS//kcmmlDGjzy4C/oQiuCQtaQTWpw90rl2bhOcjE2fjZrxIqF290BzqIX?=
 =?us-ascii?Q?52VhytSMqyJO2zVJFqlTu/VKpOwRbz8S7g17VgmXwoQnJAYSc/RHXhlK2C50?=
 =?us-ascii?Q?pWcMCFkmZXwm2ZVM2NJMCBdzRotcMpQ1K2d18J6POCUjuvEw6Smd/uWymijE?=
 =?us-ascii?Q?+xDFtfp9ANb4+VtMouuWFuhqYOUfILCKM3BawUBcmPTdFi7IBNsLfxM9KU+N?=
 =?us-ascii?Q?6tG59OcouCGjMOaKO6VUu3Ir1hLXRqjXOIZP4iwJ7iefpQ8zcq7WBWmWWRfC?=
 =?us-ascii?Q?FALJGukXY68dBGKt+DaRbMj8cApRh4mU9iqf5jOjBbISPai47+u7fuf4mdz7?=
 =?us-ascii?Q?0Le7Ga7lp/oQUDO7kL/p1dnZXr7Qej0K37rnXLHVDtx7TaaA8aaaPo81SlVf?=
 =?us-ascii?Q?t32lvcbMg/tOkmC3FEi1L3uivyPWJXNx28VaPBkZEMGLlzMm9n/rgDTKzJNe?=
 =?us-ascii?Q?z8tqDherF1q5D89SLr/Sma/ENb8zgpqt0OkKTzeUbgT+FftO0waQYnwPS6sw?=
 =?us-ascii?Q?A6ptwjKu0Nz7HPeBDQnBh5bBdUrE9pULfYcaZK2S88rGWLuUigk/1uxgyfnw?=
 =?us-ascii?Q?qM+20xzRdVyIdxqXtsA03MqK/kBHLGIpZsdtogEdgyKz28ipccPiWk1WmaIA?=
 =?us-ascii?Q?/qd3EZxDCEa5Nx8dLCG1LT2CkYZZE59AuUR4Nn7rEfnsGkm4Pk/MZzJDWM+8?=
 =?us-ascii?Q?gKSW73zS8FoiMenKxtQF1YPbpzZdsbcIOctGoAwTQRKSlrQhfE3ugFRUcf/Y?=
 =?us-ascii?Q?cMfGYa846DmzhWPOlhLbSx2Pc9r2Uy1CppO8t3BuQukb4wTV6W1tiQIPQTUM?=
 =?us-ascii?Q?WjTXvd3qTjcomAo7XXVW3LXztW8AZzM3fxUru8EEC3UHKVairZau7vSBVjdV?=
 =?us-ascii?Q?xDT7mwXvZsf0CdFfORdAAXMQ46G9T7R8p1KICYATlAUysv03gBS/yxqat48z?=
 =?us-ascii?Q?FjgPikME7VZOOfsW//zZBbvGohvWP4xBotId9XrcbXU0IWW5?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: bwgvWpnwBCS576flnPChMeniaX36/5pBtsUopvwRnnNm8Q8A6WDHZz4Yv9F6JmEvh6eKOB9MLYQqFKK57l3VKuj2i+9h8ucjgiQ1UBB0Cdd6FXFB2EAlctSDHkYyjpLukKC8KSYfoWmnz9R3AhObvtey54NDhkb27EOUS/yMYB5R+3XbQMCDvBr5dRjwwCxnEolXYzPM+Z+e9KQW5alXON1aShwtmo8L/4atidXlYle4sZMTo5h7IFNhhxaFq0XP8805guQav1SUgcZgaGKXQS2TN+ThvXDavBm3hJdiMxAD8VoREmUw1pELP7OoGafyxw1GQTzjtdCxx0xbtXsTPQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d95709d8-b439-42d0-05b1-08de9f75c810
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Apr 2026 07:15:34.9566
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3NYY9QQVVjQc/l09aRJ3mL3Us73hQpuFs+KJbOkk52RQqrBq5AW/OTIZF+fZ9NTK756UE2q0NOmhpjbqO3S0eA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS3PR11MB9645
X-OriginatorOrg: intel.com

> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Sunday, April 19, 2026 7:42 AM
>=20
> If a device is blocked, its PASID domains are already detached. Repeating
> iommu_remove_dev_pasid() is unnecessary and might trigger ATS
> invalidation
> timeouts.
>=20
> Skip the iommu_remove_dev_pasid() call upon the blocked flag.
>=20
> Fixes: c279e83953d9 ("iommu: Introduce
> pci_dev_reset_iommu_prepare/done()")
> Cc: stable@vger.kernel.org
> Reported-by: Kevin Tian <kevin.tian@intel.com>

It's not reported by me. Instead, I just tried to copy the words from Sashi=
ko (same
in next patch).

with that fixed:

Reviewed-by: Kevin Tian <kevin.tian@intel.com>

btw not sure whether Joerg plans to enable Sashiko auto-reply to the iommu
list. I feel most suggestions there are positive.=20

If it won't happen near term, suggest you find a way to check Sashilo manua=
lly
for future patches.
