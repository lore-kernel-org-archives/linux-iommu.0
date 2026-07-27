Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D80E3EF0DC
	for <iommu@lists.linux.dev>; Mon, 27 Jul 2026 09:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785145143; cv=fail; b=W5MeZkBUBVYjxwCPkQPzAddal7OgLzQhW36NfYUxiO95RhE5atustDVZf6IaELTa+WDoHGHfkrxVXAC+tFnC9yDFIia1nrLTnJA4OpIqUV2KZZytWKXuzQWlh3qPLYRlE6bmRiN8zgLBiU41RlKTvjZo8Z++KIV0BzOnDDAA/p4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785145143; c=relaxed/simple;
	bh=b7bBsE28agU8gHgeyE1WgGhZTUeuc6FW98mm51UzAss=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=iid5ktMXhOl32PnPDJsfQR595z8RgvVwfnhhkmpY8EuGbBSbQWqqO2c+X9/nnxJtkMJtzAdBeyRtaA+PyD06uYgKcVfKIXM1q5JyciYupq92cNHcDiCV4p8r70AKT6OgQMWN7zfqRZFxO9Vh3lrCqHh//8QfFq/Dv5NPr6ZMDLA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D+ncd6RE; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D+ncd6RE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785145142; x=1816681142;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=b7bBsE28agU8gHgeyE1WgGhZTUeuc6FW98mm51UzAss=;
  b=D+ncd6REgx+IvyFAt+SvjrY1zZqFAGNxgndkVM/GaZPtRBlf9zHgqjJy
   m3iwQHU1BKQ2bYzwCq0rj+sNA/mDEzc/ghG3eAwsUpHK1hpUFUZBo0buh
   Ielq9Yghd6G+o1vK+AtDFfPoi5fAJKdpMvQhoYdcklA2Wuonf62bnWUCU
   fUmYUSxGwmWE0x1YnBr9X229hqPGykfVe41UTvwKBPl/S2e9U4dDhVIes
   tjr1FAOQlY6L/ZHLCqx0VFfS/8TfTcSJb+YsD/9Uqz1VW0Jda4EBmgt07
   oBiR819zEJz0Fx7o7BlCXhhaq6rrQJN2pM2JN8iyF5wf+2HsKPvu/jJ8f
   g==;
X-CSE-ConnectionGUID: OZ6WJZzjTwKpOcL9Nu+Gzg==
X-CSE-MsgGUID: 79tIs9ExSSG4CJT/wA1Etw==
X-IronPort-AV: E=McAfee;i="6800,10657,11857"; a="85900400"
X-IronPort-AV: E=Sophos;i="6.25,188,1779174000"; 
   d="scan'208";a="85900400"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2026 02:39:01 -0700
X-CSE-ConnectionGUID: 3deDjnbmQo6gReo8Lpz/9A==
X-CSE-MsgGUID: jYvjhS42RtS7OeokqNBiNA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,188,1779174000"; 
   d="scan'208";a="258807197"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2026 02:39:00 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 27 Jul 2026 02:39:00 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Mon, 27 Jul 2026 02:39:00 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.58) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 27 Jul 2026 02:39:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aW4p3FJkwxHr/64z8w837I/Ys73ObqUDSBzNS+pWF1u/S24Zvn+7z+VdCjVnTspK3WJyWcOAZ1MZw2yQ+i0FVIk2hhvyibKmQuLJYQ0/cA0dRaUlo7VvQZakDfHuo/0T0Ksfn2PWHKGKtiW3p3tJO01qSsi/oKM91HmkIRW2iXl0uE3rzhuZmq/LkhPhyAhtKT2uSm+gOc75JSjUQY2NKT1Zxq1THx8xVo6/ypKg9brRtWtIeEDnDsY6x8hmgd1FgOqkHXbrMZypOPUrOmWeBVl+nBPvmKsrfnDGDHJIkqVK4lVJ8yry5Um7zAoY/CTOYH7FYbqoyPxTheZunD6XRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b7bBsE28agU8gHgeyE1WgGhZTUeuc6FW98mm51UzAss=;
 b=kzQ9BBMF1Dwa+dYKox/GwPRch+nW0YxJwi+neonfZVVS1phynwhH8Nk5FWtgEQ5szEC/qvkAN/8j1JHI0R7mdjltlGFsOogB/4PZmkXYSJqy1sSHP84Xb2PNZnmepwM6RPmrR/VaY3wONEH+DFqVkgIfxm7tju3KXGaeGktyKWQXl5m4Ij2Zv5GPMIeklx0COaSSGF+U1bE51GOu82/i0o08efKdnLaiQi53Ck9LtMBCTtK2f41CboX2F8aLBgu7pnhutDj3vCjkpwQSRtvc2ui8UT0MdGY1YVvSYGy82rZYTe7sLCAb+UyxS81wuaan9x+EQ6pqCSTY/jUEjI4YWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO1PR11MB4835.namprd11.prod.outlook.com (2603:10b6:303:9e::22)
 by DM4PR11MB7328.namprd11.prod.outlook.com (2603:10b6:8:104::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Mon, 27 Jul
 2026 09:38:53 +0000
Received: from CO1PR11MB4835.namprd11.prod.outlook.com
 ([fe80::d051:d948:c209:9225]) by CO1PR11MB4835.namprd11.prod.outlook.com
 ([fe80::d051:d948:c209:9225%7]) with mapi id 15.21.0245.012; Mon, 27 Jul 2026
 09:38:53 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Shuai Xue <xueshuai@linux.alibaba.com>, "joro@8bytes.org"
	<joro@8bytes.org>, "will@kernel.org" <will@kernel.org>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>
CC: "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"oliver.yang@linux.alibaba.com" <oliver.yang@linux.alibaba.com>,
	"zhuo.song@linux.alibaba.com" <zhuo.song@linux.alibaba.com>
Subject: RE: [PATCH 2/4] iommufd: Avoid locking internal accesses during unmap
Thread-Topic: [PATCH 2/4] iommufd: Avoid locking internal accesses during
 unmap
Thread-Index: AQHdHNKBj3sMtTWif0S+rZ9jPOCQVbaBHcEw
Date: Mon, 27 Jul 2026 09:38:53 +0000
Message-ID: <CO1PR11MB4835927975B6AC736D4122618CCC2@CO1PR11MB4835.namprd11.prod.outlook.com>
References: <cover.1785050951.git.xueshuai@linux.alibaba.com>
 <e1141361f8850ada55ba4435c5a36b1ccc4eb1a4.1785050951.git.xueshuai@linux.alibaba.com>
In-Reply-To: <e1141361f8850ada55ba4435c5a36b1ccc4eb1a4.1785050951.git.xueshuai@linux.alibaba.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR11MB4835:EE_|DM4PR11MB7328:EE_
x-ms-office365-filtering-correlation-id: 08ba5c1e-9256-43e1-113b-08deebc2df2b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|38070700021|6133799003|5023799004|56012099006|4143699003|11063799006|10067099003|22082099003|18002099003;
x-microsoft-antispam-message-info: O6g1NMp71rG80gnghWnVF8nh2ypiLcR2B74p51/nLDpSVsO+7Z/3kGEfZG09yfCaHRoek34guze/HSEm6EvNgByWi9R3Fq+Ya7fl+97PQZBKYVNs4RUsLubkIvnritlTa3j4c5BhoZXkD0xopBOX1ftAJeJd8h7CicExI0QZ1euDS6WKkyScwr2+BbXVfxipjiTtwcSTRc2dCeykDr6hUL9EqjD252Ncc4wf3DndVDbsYAz2Gd8s2wt67oZqWc98bH5Tad8MaJYUGummlTywBRsAtxJQWAx9K/DvPEyO/LiS7aSi44uF2DFMaeBy3aiT13EyIYxtj3osafTt7Bpv7Y7qi7gC3X6730wZCOQv3lxoX+cDEvkwRqDg/7bomRaIMjqxhAbu5aZnhaJc3L7+vAzi1Mb0mq6E0CFzuMqrWTcg9UFp7GayuC2BbDLogrzycvSFypi1tNvppNA7pnk8+2nYeXL0+9+fcz4/KrILVCAnsLAVqDKeV5advTw5YwKuTkd18hRx9g/cfbqOExIJlXQX4lyesu5nRy5lWThLA65F09q+C1tQKqMQSTCDTQiJTBYNch7H8P78bKGC3jMW0A3UQP9qy6zeYyL+p0D2PlqeK5XQUqT4C2Kz7Ul2/+LYsUYg0kDbI1gvc4CbpZd1VtJVNvWSe/0nffsUkOdmIcQgzSX5UShxSMEVQTmCCmvMokncp34FDHfATHj4yiYh9/9v6WW8KYPIIPwxpyf4xLI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4835.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(38070700021)(6133799003)(5023799004)(56012099006)(4143699003)(11063799006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?CkSdvuHSfatEYz34CHxWoTvQtuO7z4RhbZafwMWn8PTSICUw6v0P//nMtrFz?=
 =?us-ascii?Q?hceDNPU156CwIt9L8NOtiOxoVEn49e0PrMXQVq5tXUlLyNQ+TkcmJXY3zu3z?=
 =?us-ascii?Q?dQSY3Uzz+V3AdvaL4VoJ56x0oSQAHLFcgnxfe+nGisbxoBqmAJSUm4IK5QU6?=
 =?us-ascii?Q?Gy0bjAKxxLPbGT1e+Tz+4oFbgZiDLHacThQ9FH2EUGjQQzgEUM91xtHeXIRT?=
 =?us-ascii?Q?F/U01+jw0N15syqnjXuh69wp8PMkmAyWZdTqwPm8umIqVkZ6vXrxS7pFHnoK?=
 =?us-ascii?Q?OuWSCBrm66Q4oIgAphywup28R7lNbWhz19QG8a7AXfvcR3cr+LoUXbb70+GV?=
 =?us-ascii?Q?AqRiN8vGOJVifZ/jOCYKDSpHs7RcpQZbU10mj7IOFXJY8YKrD8xjnCrTBxMY?=
 =?us-ascii?Q?D+rZ42g4WkY6m1jvcJ2NzP5XTgJ5QNtc3X1SkbVoc/fiFzJRixam6hHS9/aw?=
 =?us-ascii?Q?z0d3NeAZLHpNlmaCYEQXGzrU1caFu3TM3s7gNGraQWtZ7+s830pPmuj8rOUC?=
 =?us-ascii?Q?54Hi1bYKaIADg0EBNBAFneJM/qj4xcIJrjhavlAMYXw0Peo/HBnfMRlavsU1?=
 =?us-ascii?Q?8O85jN5jLiYNaL2EKazSLJinEzGua8IOXYaeVsTAwbpIVqMTnJudw0dvvsuB?=
 =?us-ascii?Q?McOSsBYMMR2B8UL3kHlCVk0zWXtEA2jxXKdPecJktxo/G8mN/15YEQDwKMl9?=
 =?us-ascii?Q?CG314ICmRsZusp4QKN7toYd1vJA8HsiyTwgykIMQ1aVVQubdvjRrCDSU469s?=
 =?us-ascii?Q?YQZmaDtWRpmvW9qe67nlGCyp546RNdDt5YZr4cXSFSzw7FpIW2KU4IuPV8Mf?=
 =?us-ascii?Q?kh0Epm7Vq9ZSD/GZj6gmQuRnffERsQg9uqVMtgWgzaah78Ee1zVM5q6BvSrx?=
 =?us-ascii?Q?RZVDiJKytdPgZnZtpmXe6IIHZ/sZ2SFTR5AEAhuFab8rlBj3GUGTi0XyksTc?=
 =?us-ascii?Q?JzreKAQCtwLkg+xBL6PUAZ66Uf7HAR1P24sngpf4F/iJ15g+uHkucGw5L7rj?=
 =?us-ascii?Q?pOrNi3n2vau2wPsbfkpVc+PqFWQGiVj6PX+v3l1FGZ2upbKsfUqAjXHd17VS?=
 =?us-ascii?Q?8sF0qDf8wQB6COgStvf+0M7dj9ZDc4nFe3V4+M/t/Q7FUWg1JGPGVGOqOdhD?=
 =?us-ascii?Q?5Pt7Ik+kUV4V7dAc/I/zBPEIwhNrvsEhpmnd5Yn9gARwaeJSP0aVE5NZ7qzV?=
 =?us-ascii?Q?czIJxWv/oeUTrJ8ieTG1QQLZjlr5VuNnz55yJObKlDXXMORItGmFylYG8aW5?=
 =?us-ascii?Q?vAbaRxH6B6M2bYEQiPM7L7/dKVLTOYb6xnqan/mzl6+Tta5VlpXTUpFjFzRd?=
 =?us-ascii?Q?KzsGotQyg7gZguTG1y8haM9ZiWWuiOV3FAYPNmsbKU4fiLywRVQmGKaJ2nYS?=
 =?us-ascii?Q?f22g0+sqIRvHh/iaIGZ63u8SIQq3a38FOs3mJOe8MC89ykufQP8QjeybuNRn?=
 =?us-ascii?Q?CwBE77419BMTayFtx8PxDZWnRAOU/ZBjOWef629swtrJnCQ8TlmOddDIDyWl?=
 =?us-ascii?Q?b0ihrVli5gC8USmlymj5l9mp0/m5lxOp1n4ZQkT1j3gwtJTd+bUCb09OrOoe?=
 =?us-ascii?Q?kSpnDdgCXx7gju0EgJcHHAaU93I8DdnThvfZPG5/psAYJBffGL6BY1uXJQeY?=
 =?us-ascii?Q?aNydNIyAhApiCLxO3lKRCuAnOI82KdUMShogkzgIBBFVzX2045qilat9FeFP?=
 =?us-ascii?Q?z635/3zihNN9aMAGpVJuTm1SfhNMLS25pt6NLsloKRCeHwYJD0JhwiSGMUWW?=
 =?us-ascii?Q?rZyz0yJ28A=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: gtjkDvbJPrQt8/lLpWgFh6ZPDeySW3VJRmivBy7soUHFiwWu5M5NzyNZ31YSjJFVASGlypNbFFrADXLQWrAxrDGn3Ev0yIHCkY8lZL+demiM686QtVhVmjN/sXxNxdiWUPNhD+Y7+pjdVEvrlFwro0rwexruJBpuSxgHTugzaG6tfQ2fX8ivoxTKQTWwU/ZkXi+BRraGSS41MXqH7jbR+WJvV9XlGrv8hgBJaqbL0D9OG+WNaaks4w8rWMcAm3BkuU0Bs74WRn88MeErysoDc6ZmidOlSLCv35c1wRVVQd5rCICptw1EJvD+PN1C/Yirnt7972CAUq/UfWxf1IVM4w==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4835.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08ba5c1e-9256-43e1-113b-08deebc2df2b
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jul 2026 09:38:53.3069
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: r06Dic9soAXzlyfNkHnd2A0bV9Q9yya8+vptaqtieo2N8oPah+nchCdxv5kxrXuovQiCbEYHvOj4DNCkt/ZXcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7328
X-OriginatorOrg: intel.com

> From: Shuai Xue <xueshuai@linux.alibaba.com>
> Sent: Sunday, July 26, 2026 3:44 PM
>=20
> iommufd_access_notify_unmap() skips internal accesses because they do
> not have an external unmap callback to invoke.
>=20
> However, the current test calls iommufd_lock_obj() before checking
> whether the access is internal. If iommufd_lock_obj() succeeds, the loop
> then sees the internal access and continues, bypassing the matching
> iommufd_put_object() used by the normal unmap path. This leaks the
> object reference taken by iommufd_lock_obj().
>=20
> Check for internal accesses first so skipped entries are never locked.
>=20
> Fixes: 27b77ea5feaa ("iommufd/access: Bypass access->ops->unmap for
> internal use")
> Cc: stable@vger.kernel.org
> Assisted-by: Qoder:Qwen-3.8-MAX-Preview
> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
