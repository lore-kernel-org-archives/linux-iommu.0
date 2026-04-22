Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84B81342173
	for <iommu@lists.linux.dev>; Wed, 22 Apr 2026 07:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776844761; cv=fail; b=CjPEVq39ovI2PgGNraP9NRIMideVIXc/TLzguBLdHx3693eqMSRBKvN1d8KZuPU5wEYzG812ETO0U1KLXHevUH9v3ksETJDu9lOGep2S6oQuagStx/JSqDUzibDqkQjCqk4ltGqGyEqkiHNQqlzXmlMHZU7d14RoTxZj2dJMTzY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776844761; c=relaxed/simple;
	bh=s12y3JUEzFSiFCTk8nsb8uAiLg+SU6LDz+y4zvpL0CI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=t/8iNW17fUCNyw8FlXQ56pF3QSbStjmSu2V4o9tyUzlfn/2eUwgVQcVtxnKcX5ZreH6upoBopoDuIkNQJmd2AkO1LJksng+e7qU722+55hnis8uRNZFzSLl5FZqWUu4Exx5hbRF0PY5OOQT13ZVvJroqbslKRE97zxwIvYJ5Sis=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VMy6Sjbd; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VMy6Sjbd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776844760; x=1808380760;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=s12y3JUEzFSiFCTk8nsb8uAiLg+SU6LDz+y4zvpL0CI=;
  b=VMy6SjbdiNYiuXHQmSa1jgjTRLzELuzSiqOKkWtzqVU2w4MtgelGaVUu
   3UXlgqFB+pMab1KHRE6QXcpoI/jV0DUjN1NPj4uwtOFGIOuAMFqmP0gRW
   cvsxClSPZlq1ASux/MK6WfgpThXcCuGZ81z/9gQtLUiZjHV5rVwDk065I
   uw/rE3yKuxPUMJOOrpqgcqhqhAXxqI5kWjTjLmm0e7yQupGWD5yyYGDQW
   U8mkiGade3KrWYoGrtyRRLT8+m/1Ci+lof9B6MvY7lJHnheXRaQS9C1GI
   RQoi1Y+PjehBDfU1/7yJnnlsnblciIPDr34wW4hguJkdhKQrkMFtGSihf
   Q==;
X-CSE-ConnectionGUID: L9xgNM39S86tTf3mX7+T1w==
X-CSE-MsgGUID: SH+fAIO8SXWPohnyRE8SUw==
X-IronPort-AV: E=McAfee;i="6800,10657,11763"; a="89178659"
X-IronPort-AV: E=Sophos;i="6.23,192,1770624000"; 
   d="scan'208";a="89178659"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2026 00:59:19 -0700
X-CSE-ConnectionGUID: WQp0ilSKTvaG5FY/9Asx1g==
X-CSE-MsgGUID: b9p3NBbdR7ef8rZTTegX1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,192,1770624000"; 
   d="scan'208";a="229118286"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2026 00:59:14 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 22 Apr 2026 00:59:13 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 22 Apr 2026 00:59:13 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.70) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 22 Apr 2026 00:59:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FWV7d6dzhm+567xrSRYaG0VZkOstX7N1xRdsGRnha2eGaUl+HrZ2VkdBT2ktOcy9STJwGoOIBWs70t+p0h/s+kA8UI/yAOYp3ZyJwwp1BVfrGUz5DLCZB0CkhHMfYpZWQDUcA/7Ck5xOhfS9YJ8h5+Bed10zrDNLOqiUgU/9LgSGW/b8Zd6NId9YZOMK4vJ7aXn96kVabxEBVsY03HUHRVLOKPfU9sEZbTFH5CFOjJi2/CIOQV6j6Lc15RLJRO2r7+y0DTi/8As1wKVZqLhYXj9/mPxoMw0SJNV48yKwqprHmx1aIvpbOgY3kq3iTmPiSMk0x/2UjuQQY5glAnIiYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s12y3JUEzFSiFCTk8nsb8uAiLg+SU6LDz+y4zvpL0CI=;
 b=Fw0ZZybFqztRIKpCeNQgJUq90OC5GLAF3REkAs9WOWdVsGFuTgKqKzRpKSDZVX30+8/efB4+piaKyn/JhEXBaj+6Tp3LZBPZ+YKrfm0rmsCx3TkY4kSECCOjoTSDTSDC2XOzBvSceySY0C9UA/sZL3xoR1gq24MCC8sOxmqu9ayUJPeTvtyj5gy1d0t+MnTst7RplS0Trw1ceZX2PRLSks9pIvwNyPKy0O5+grGxbqewcBL3PSPsBI2DmLnakM6K59xKDPGdMhSjSZ7W4PbLW0LRUYbNnWfToCZYePsMntpMjWIuc1Ojn6G4RlIf77hzBdkjGoRSWx9c11dFdlr49w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by MW4PR11MB6714.namprd11.prod.outlook.com (2603:10b6:303:20f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Wed, 22 Apr
 2026 07:59:07 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::f997:762f:f079:134f]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::f997:762f:f079:134f%5]) with mapi id 15.20.9846.016; Wed, 22 Apr 2026
 07:59:07 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: "dwmw2@infradead.org" <dwmw2@infradead.org>, "baolu.lu@linux.intel.com"
	<baolu.lu@linux.intel.com>, "joro@8bytes.org" <joro@8bytes.org>,
	"will@kernel.org" <will@kernel.org>, "robin.murphy@arm.com"
	<robin.murphy@arm.com>, Kees Bakker <kees@ijzerbout.nl>, Joerg Roedel
	<jroedel@suse.de>
Subject: RE: [PATCH] iommu/vt-d: Avoid NULL pointer dereference or refcount
 corruption
Thread-Topic: [PATCH] iommu/vt-d: Avoid NULL pointer dereference or refcount
 corruption
Thread-Index: AQHc0gkrvafGQkljCUmV85DXoRg4g7Xqt18g
Date: Wed, 22 Apr 2026 07:59:07 +0000
Message-ID: <BN9PR11MB5276F810A1B3D037A19D9C668C2D2@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20260422033538.95000-1-zhenzhong.duan@intel.com>
In-Reply-To: <20260422033538.95000-1-zhenzhong.duan@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|MW4PR11MB6714:EE_
x-ms-office365-filtering-correlation-id: 7f79a423-85d2-415e-a6f2-08dea0450775
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700021|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info: 4g1zbtI+XvIO79YipTwXrxzBpn47uVsfAIatd9d+oI6vh24Lq+EfuDwMSWwRE8UW1Ze6MHXw64OMp/qa/HtzKy5AByw0MLmxkKR1KxIV8QkOdbjf8PdeBSynl2KGaR3LXeB0CzQ7Wsvma/eyfnOdZTCAQll8WUwxlSUCXD7oxpLGTgcEuv5KmcpVh1cv+ZaCWtP1v5yFKeq1fIkFtHgBTeSqlNruhADAsYt9Nh3Q0ImOj5WSBRuMfUOT5Zd0sx19j2sz0j45TgUjXLTfFlkOpNbpnPnjthLpYRW+zu05v0aOvCZwclX7A/CgmMpE1HPgeDiIeivKoDh3xKWIi6OxHDzCR9LHhGJoUnHEO04LU2rLuUFWeKH2+ElDCvvLB+KMAIduWcmd6eIiFVscrHnG5FpuUNkd1M4ngA8NcHWgtlMqbs157rCPHqEYDaCy0NGzVuc6VzhhFqfNsLkpqL9xsmu4OEytElddHFitne5A5+4jD97ydcSHn3tZq/J+d8c2h2zJ75Yzww+1j/i4Eki7dUp8yeYjxSReCiOVGdVjqFzicACBmdIvsraPF7vs/m0yCI9e2Akzl/nMynQvVjxp8n9v73GqKm4QsfE/qGajQ9aPC92fc9bA/HP0sgLd2yLlpsWMG9rfzOFC4kZnORXjuVAEQSCKbxrynTdIB1qWlP8yMLK/kEJSxVK/7rjC02mzoWPznsYr7RhbgBHzE9zExXKX4U2HmDpK3Gc1RhqXBj0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?92qZOG0dLOi1tgdth5OdL2YHwcGWzmTLm3Ativte6EW87JQqpl1UIk30whYf?=
 =?us-ascii?Q?58//toDPPtoZld8uUbk/p82QVe+gN6hr7J13HreZjQKhh0us+FfzSFJPPudp?=
 =?us-ascii?Q?DsiK2yq6/bekZUAyWEFPhm970tmHQWR2zhfNjCpocTL+4eK73wGc2+XAYmue?=
 =?us-ascii?Q?bRJRF+oMeRYo/Tsap7idz65eMpj9AZpdB4Up/EBwNcjG96au7SlmgzW2EH9s?=
 =?us-ascii?Q?LCkwn0VMpjo0HCbFJtchjQc9gQ0hBjSopd/Yek/E4eC+NiDxTgveQ/NLfuJo?=
 =?us-ascii?Q?PzHLsvn/BRDXWc8jnVeiSKBvNtjCQ1zA/hLJmcqbaEKVcPoJbWBh+UvV4fje?=
 =?us-ascii?Q?HuX1tqRaFDewXcXVaxS7QU8ZOL2WVSTEx7fw6qjC/L+k8NGY6PCusMcAOAQ0?=
 =?us-ascii?Q?8xATuFqLK8eF84p1v7w/f7Kkl787KhLFZuAsqBm8gMkDZ1AM6LAKfu88h8C+?=
 =?us-ascii?Q?CVQNqfi9MzyB3mHK9LPGdbJtNbZGkw55fBz+VIrrkY7dH+IcMFqZtykLd0EV?=
 =?us-ascii?Q?2eZXg66vNqoA37AwLXZQVL7lIiHvLl1UhflzWBYM0FfNSNb/3FPA4Xjf5ebc?=
 =?us-ascii?Q?6b3ma3ihUE2PV5zd0uQdm/QZq+zLcw0fCIzLt3yk6Xu38Vkr+k8+8QBNRC0L?=
 =?us-ascii?Q?wJaHCTFr+yMgcNQhwUMKHy1GUKZUTKR9TW2GQXopu3sQvMfAdzb7OwJbHIPe?=
 =?us-ascii?Q?zmy+fgJbjpfVvu8wKiGnNjGHf9ja8zDniOqvBsiiyEnlbk47d2LFS6SfmXjd?=
 =?us-ascii?Q?jlPebvY5sBYOeAuKg7zQmmIb5g9P/kJyuTHCKlqK9ecG5a41AyoX4gwE1FI6?=
 =?us-ascii?Q?cuzuIm6QeWO38pKF8vpQ/g2gNt4bRIy4VCT0VUqs3ISAknB1ZSl3bfNRJwhm?=
 =?us-ascii?Q?61wWCjf5KvIbXOyQgpVuuGOYfWhwADTfX7BopwA75AwEVbg2mSMOmUHD/3cx?=
 =?us-ascii?Q?1COjp5sYuNE/w79b/GYnfSkgI+A8eK9w7m8beICThddwd9jBpM44BFYFm+Mk?=
 =?us-ascii?Q?P48JdbJu1eyQ8P6qQVj4awx4g7RBBv29HoexV8aySbY3YPk6lRpDAzwO8ygC?=
 =?us-ascii?Q?RmjJtKWk16KfBOdBuCIUjpFnaoIDTIAnypNaI1iB736vYI6NlwqRaVK6sz/I?=
 =?us-ascii?Q?6Wkcz60QacoRZki1uaOFC/JggbDV6HmwRfk93lAQABl5qQQegeOTJYJkoNu1?=
 =?us-ascii?Q?7Oh0mCT77KoKeIxzGMy8Ma2O+mGi8PrD1P7xn4KhZkllF7kdm27myKf/5RGp?=
 =?us-ascii?Q?Gp3k6FEJDuVKc+Z/ttMXqnlz1dxjPVjtCA6D5eXxZ3TpR8vnnx7ix42CGdb7?=
 =?us-ascii?Q?2KvGDpbtaEY7wLWJ6A6wsM1o+PDyG6NjyYrV8kSA8Us7arE5eORySxoxcMJJ?=
 =?us-ascii?Q?Z4OtnjCDkVgMnECTfPTrso94gh0jPiNYCKmlc/8UWWVuW5v+qSHdiyIpYMlB?=
 =?us-ascii?Q?iY/j+fp6vbFWpw1tk/RRKv2eqX/G0bOIdqpTROwKJWD37QUNmpKaM/FtQsif?=
 =?us-ascii?Q?8RuNyWT/AmN2+bjXLmjpKoVWGqUu6HzAhrMDm2t1t+znXwhrr5zLWKrdE66F?=
 =?us-ascii?Q?XOIzHusf/Qzown5/G7pL0Omw752XbmYNHHzK3LsoJL3A9zUGWgLjHFTSKKhv?=
 =?us-ascii?Q?uWIm2msS4tf+DHtFI009r/g6xeLI1nw3JQk1xRUrHG8K/LQXQJD0TJTvZaZ5?=
 =?us-ascii?Q?27yV7WwgPOW4CkCeq9in8C+3ZmXdUtYt+ec/hA4zazd8Q9dU?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: OdhgCvYozdw4LX7agIYWdRHPdfr+L4WUARscHEM7MjDvPtGmV/L2fLp5UdjEMF7vZqsIjyUESi2WrzzjHPFEDWrRTOC68x+wkxIJdIAJyTAmy4i1JHRcQSCmlG7kVMVTiFHSKe3b7yUH0SzIXMFwYXbH8FZ1clfJvUpT9D3E/7LLGrLTqH2t4mJZBrxIAI98sjg9Fl7c+pYsS9Qvo/gB/hPFHkMjLXYHBezF97Rgvd19nMlE/rdWKX3+ID9/5X/o1VXJZvjgU5O30o7hsWE+cC4o/1VKuCd+5SpC6ksiaVoARVkpzTIk5xC8XtFPhjMsqIrIrfOu/dKEbZ9pNBJhfg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f79a423-85d2-415e-a6f2-08dea0450775
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2026 07:59:07.1097
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7XAEHJMG7hat9CUUdavCgXCJaLocAk/mn2MDCPBjBFymYZXnAMoPjmpOiCG+HVrq3MiE071G6k/e3RVHPxkiBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6714
X-OriginatorOrg: intel.com

> From: Duan, Zhenzhong <zhenzhong.duan@intel.com>
> Sent: Wednesday, April 22, 2026 11:36 AM
>=20
> Commit 60f030f7418d ("iommu/vt-d: Avoid use of NULL after
> WARN_ON_ONCE")
> fixed a NULL pointer dereference in an unlikely situation partly.
>=20
> If dev_pasid is not found in the dev_pasids list, it remains NULL.
> However, the teardown operations are executed unconditionally, this lead
> to a NULL pointer dereference or refcount corruption.
>=20
> If the domain was never attached to this IOMMU, info will be NULL, which
> would cause an immediate dereference when checking --info->refcnt.
>=20
> Even if info is not NULL, decrementing the refcount without having remove=
d
> a valid PASID might unbalance the count. This could lead to premature
> dropping of the refcount to 0, potentially causing a use-after-free for t=
he
> remaining active devices sharing the domain.
>=20
> Fix it by returning early if dev_pasid is NULL, before executing the
> teardown operations.
>=20
> Issue found by AI review and suggested by Kevin Tian.
> https://sashiko.dev/#/patchset/20260421031347.1408890-1-
> zhenzhong.duan%40intel.com
>=20
> Fixes: 60f030f7418d ("iommu/vt-d: Avoid use of NULL after
> WARN_ON_ONCE")
> Suggested-by: Kevin Tian <kevin.tian@intel.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
