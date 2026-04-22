Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3BF42E8B8A
	for <iommu@lists.linux.dev>; Wed, 22 Apr 2026 01:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776823025; cv=fail; b=kz/n/5X+XcLFnwNSeXBj/7w2WO9FbYvdF1GuHaAkzCKQiuDjRpA5poUgB6xqiA5tF9uKHziGPziFa342tepfawjJsgdRDBOVR7lPQnvHYyVeSBeWPinePu0tJmVIF8x4IGA1etWmvDn2ouCcLxur1CyR4atH4+UAddVaWS1eAMg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776823025; c=relaxed/simple;
	bh=41w5v1r08qBb1qEDam0cg3Xg09M324rcOaTLyw45HSw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QODiw/ULADzqX6ScESVSBt6CNpyPmsW0eYDrzX35aRUIhzCEU+39gGfjb09OMfmhICV+rmDejv2j1lmDinC1AY61OIjS0NzW05kCKS6nuuJyZ0n346Xxn4WpceHEcxTUp1JE+/72tWOY3SDFV9SrX5C0V6i81AJ5z29Wxr2efjc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y191ht/Y; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y191ht/Y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776823023; x=1808359023;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=41w5v1r08qBb1qEDam0cg3Xg09M324rcOaTLyw45HSw=;
  b=Y191ht/Y8GMHEFmL4Tt23+ADZVx4miSpfeYZ+nKSWtzS6n/YpaPsL4ep
   EyQGxBHzwCt+BqP0xDL5SpWUX2NAByglnz8ROim6+bM2VY1I2uzFrL8gX
   xDwTcB4jJuHtnjzD8u88hPWIvPhe+aN8D4s6ZpjbtIgop0jeHO0yfRk8K
   8bJyhXPfet5esgRLeGmQivkfNFB7wW2wW4BEzMcRRk+SLeSQyihesUJpm
   ZY2rox4cJAFJl5UizcmnYWyZTdempTeIeHUu6snq10dJWEw+LISGch+6h
   /bhud3KicdAyTrYtihV0PuPS4Oq2l/3Qm4DYsKlphK2Qj2mLRdAMaQlf6
   A==;
X-CSE-ConnectionGUID: 3lUkHhTGQViAh4nk7RK5qg==
X-CSE-MsgGUID: I5octW5FQValaP+xDbwj7A==
X-IronPort-AV: E=McAfee;i="6800,10657,11763"; a="88841819"
X-IronPort-AV: E=Sophos;i="6.23,192,1770624000"; 
   d="scan'208";a="88841819"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2026 18:57:03 -0700
X-CSE-ConnectionGUID: 7Povw+vrQzSmevoFHQRaGA==
X-CSE-MsgGUID: WLesWzYKRgGlD45i+PJTOA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,192,1770624000"; 
   d="scan'208";a="233993155"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2026 18:57:00 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 21 Apr 2026 18:56:59 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 21 Apr 2026 18:56:59 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.35) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 21 Apr 2026 18:56:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=msFk5QY1yoU/qu39Pf2uV8Znqd2L0WxRY8BDED3Yv7bYgg8WrUYz5AOCROiuGQOWM/o55AqNBAnWRJkb5UfqMgu6ZrFDlDANC8llu9UBOcKFMLMA0fnZwrrbSaXKia1wrB2OMgXF/do+u8t3lOlCitquMwRIavAH+KNj5cUMzVQZ2i8qm0y9m8ZKb/+nroZqeltaDg2TpvCrCc+jUHgOjBT/xfiwLaVUKlA83L8p0HoALI4H7w5p6kIneyS/ljrfjPt188dDqADTkEQvTdPx9KcStV55PFERLNpwQweg2GYP4ZwsEk1MOKc+cO+jc8UlbmFX/Mp4W6LqRZxmwdPWMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uZ6cuSDWaNoUR8l6LpYARIs9DcnphvgEp8eFwpLuxnk=;
 b=MV1gBJcmyKx5RvzuPQDeJF/2IyNIgYWugq9Y2Wz08DmSDMKcUUOr3Q8YpfnVMJQ+T+rBkMhozowuAKV8lZ1bkkoP4e3hjaIvjATmFNkSnagp2tO/h84meljWcTbM5C9O8cgp8aafGBgLE2NmI+i3I+t9bCqW2MOGfus67Ai/yqRPOj+arwoeBzeCCoxKGomhkU7MY1KC34KJOlvl9s+ezOMY7OKyrCcG9pSvk9oAHzwkBtG4DN/d8C4tjJH8WpoeEOKI3QDPxjj1Flqz3BHAG9H1WAIN5q2odXV/snRhdfErgi+KhxKTxXfw1wf+2z5WLEC1apYGDX76Qh2TIPjDbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by CO1PR11MB5139.namprd11.prod.outlook.com (2603:10b6:303:95::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.17; Wed, 22 Apr
 2026 01:56:56 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::f997:762f:f079:134f]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::f997:762f:f079:134f%5]) with mapi id 15.20.9846.016; Wed, 22 Apr 2026
 01:56:56 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Nicolin Chen <nicolinc@nvidia.com>
CC: "joro@8bytes.org" <joro@8bytes.org>, "jgg@nvidia.com" <jgg@nvidia.com>,
	"will@kernel.org" <will@kernel.org>, "robin.murphy@arm.com"
	<robin.murphy@arm.com>, "baolu.lu@linux.intel.com"
	<baolu.lu@linux.intel.com>, "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"xueshuai@linux.alibaba.com" <xueshuai@linux.alibaba.com>
Subject: RE: [PATCH rc v7 6/6] iommu: Fix UAF in pci_dev_reset_iommu_done()
 due to concurrent detach
Thread-Topic: [PATCH rc v7 6/6] iommu: Fix UAF in pci_dev_reset_iommu_done()
 due to concurrent detach
Thread-Index: AQHcz40BheYeargagUmdr0A7c4I0KbXpHnTQgAC2sQCAAIEwYA==
Date: Wed, 22 Apr 2026 01:56:56 +0000
Message-ID: <BN9PR11MB527638E0BDEB9A3BFF3016E88C2D2@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <cover.1776551790.git.nicolinc@nvidia.com>
 <96a8ab981d365bdedc5dc705df10414ccf578c9d.1776551790.git.nicolinc@nvidia.com>
 <BN9PR11MB5276B1F1CF1BA54FE69B8D968C2C2@BN9PR11MB5276.namprd11.prod.outlook.com>
 <aee9kIdPftQC7/xT@Asurada-Nvidia>
In-Reply-To: <aee9kIdPftQC7/xT@Asurada-Nvidia>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|CO1PR11MB5139:EE_
x-ms-office365-filtering-correlation-id: 77bbf6a5-02ed-42c5-b967-08dea0126ed6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|22082099003|38070700021|56012099003|18002099003;
x-microsoft-antispam-message-info: cjPwSZlnXBRSzw/heK5gtXhRN+O8Xmj1H1YvZGYT0ZPOzuqyVfYcFgbS7aTz03iWmK0OjWab4wp1KwiqdUcEyknyOGJTkr5RH+zTlyXxuDDlsyAaDeuZ9tVu6xtMkcybels7M+avHdX0RH2UOATV/LXGbaQMsWei1Qg1Tzcv29EqNVILPByV3Mcdouz9aU04dhmn6tLy4uf+HBxm6aW/0SnH5Kl7vhZ4PT9PTqbg2TQBh4XM3tONwcpam9AHT5uYwqTt0+v4Ig3ziTHvc1Z1TSYvEWrgOZWTW5SF5F474b0YMl9HcqQ1JECwcIKAntaSUJx+SBEvUUomO6HpmMWtFfgKaQMFh4v0LGL3/nMYEKFsHv8E7V3/pqzRwPp9IM2tDr1VvGIQJLQh110QIIOY2TYK4bl5JQAcGKZOjS1gJr6joRiB+x5YmfNEco9wb0G1YLy5d8M0KoaflJ0WVcP4oXGikUntt3yyMORturLZmjcIO1BJ993Tegt1hdna000oDL6EfrSuSp9etSKkmJzpFcMOKg0tW5dxpa+to0RvU1Tex9fAk7ePCM45NvpVf1tt1qmJZicmyOJbhrk5J1PakZ67PdFcwcl2LlgMX+tspjXcF8Khw7+Fo2tsc8gLoltWRbi/6MxaxHzLFy+N30Cu4PidxQwv9DLg4rAySJHcxoppakEb+19LVZifzbjb2sJQzYCIcLsnzylItnl9c+xRtT0HIC8xBK226rMFwQZ1kldzqiyfzScam4cFATawMiy0GqtL4l+p/jC/xCf++kl7XLoZrwWelyy9lVgrjgS8WSU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(22082099003)(38070700021)(56012099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?IVY/7VpWeMqOJYEuBaEfDFQvFrR6r3EwiUWtdq+Kh3uiKSOCrKGEg+GICsQS?=
 =?us-ascii?Q?AeoA2GIQW8ziY1kr2D6DyahV7ZpibfCTsDxCf/GNKlXzcI2DRotTPKIzHuGN?=
 =?us-ascii?Q?xLGHVIeTXFLTV3ZYMPeV9tmlqh04OgVMdOHV4bqbKKtqbpLPJLB6Eswz0/A7?=
 =?us-ascii?Q?8hDLWaB1+cZJZGZutyQwk25JG0G15Lb+9yvGXsIdvEdaLElMOhT7IYZ3lU+z?=
 =?us-ascii?Q?wGDtebqap9p/oaRVM6urWfnlg/t3OdOHQan9CuyS7Ts2tShU+0I7dwmUsWSY?=
 =?us-ascii?Q?wc4BXG3TrExUY36HLN6kNSG0pLSaCZVecVlqf8gIjYW+n8ut2zf+kql6ilr2?=
 =?us-ascii?Q?6X1QY7dng663A7LNvtZAfRDhXDbquDEeR3XEvGRdW9wXAcmZq5V36mZC/guB?=
 =?us-ascii?Q?R13s+LByZAoKI0FCpRKCodxFxBn7OSKvr0xFgso8HJsu0JyYtJMgCbpd6cA3?=
 =?us-ascii?Q?kjQMbtBJD0C8jOQZK2PXidK8DIkQi1SJMNXmqBnUCBLp0OqyCbKV6mVj0uKX?=
 =?us-ascii?Q?eiYWfNlPiU7Au43tsV3aD5OIPyOP8AetUyv4NARvk4pG+im0FtKRPYYRtCYm?=
 =?us-ascii?Q?7AUbl2fu6C6hW+26D4cv7OSmQTWxfy1BaGcDT0l6C35V+V6xnkTdI3DBqc9j?=
 =?us-ascii?Q?2YqQ/GfD3S5p9M09e4p260GuDwAhpeubMEAlqq3oY5Bc1S07y/PKZs15TElW?=
 =?us-ascii?Q?uU0qb99HfWddwG/mtSJ0bjkGY6qcVK+qY4K62Xtt14/u/OgKa7ttjZEYVgZH?=
 =?us-ascii?Q?/lzXMOh4Jx1Vans86fyhLxGrpFYmuIHPNxYs7PLDAxe87a+Fd+CvoapVzyDO?=
 =?us-ascii?Q?y5KNOKV/UKy1Et5ShlnsuEIYqZfXmBauq8er47JDRhLfw8RxjYdNpYsMgaca?=
 =?us-ascii?Q?8TnPB/WCBIV/ZR+uvflMBgJVYkVRr33Z38+UxV7db7CyiVPgEj10xcm4n65N?=
 =?us-ascii?Q?JyouPK/6plzGl3ouvMC4voLGvXQBkZTDKqtlubmxcJJv5hud974E/iIQWT1w?=
 =?us-ascii?Q?++W2JGrQrSovUBKpHEAypEAoK1gn3gTnBfFz8i/+w5tn6PCyVeD+YVvBpuUr?=
 =?us-ascii?Q?qrur/OOjlfGZ0/9sBY7x3r5uOSFb9SyXxPicUwevnuBtVNRb8gPf6CaJrsKB?=
 =?us-ascii?Q?5U+vNrnGSXX70luZWTrkXQfZObIGW45+RCofITmeLND4U3ZrRfP4cLziH1Cx?=
 =?us-ascii?Q?to1uVfAyv/kiCSKqUSQkEusiTpF6wq2nCj9cEEFydHM+6O5OoVcNoD5E5Fzs?=
 =?us-ascii?Q?L3GNxzHchqcAuI4ewfyq46sglzc9yl9Kc5++bxl6sVpFhQMcx1S1Zo23oo+2?=
 =?us-ascii?Q?+BYjAIH675sU0c1nYuZ7ZOz5ikwT+b9qzlNegsL71Gr9OIxvwdXFOSzfZb7R?=
 =?us-ascii?Q?bqXmocFq1fmhG5bGn5ve/3YMFkrb978Qa5YenR96Mnz9RjzSiiGO081dS9IH?=
 =?us-ascii?Q?XNrX0TFTqmD3ejhklkzx5qC+BX/cM1nNEfD+JhqZRku6SxIdOj15V0NDCY0/?=
 =?us-ascii?Q?i03A5UOsOb1hszrf79vL3bnRe7lTV6WZ7YJQDcSW2yiQL1cVfo16mZH3gU4K?=
 =?us-ascii?Q?guDUkQii7wP63dOOOzk7Z0VR2gRrocvxl8IKr4KxwrYRe1WxxLJYepbuhmVR?=
 =?us-ascii?Q?FdxdyZkoWTgpdAEsJbbhoe290XzDpDGAoKOgNFA9LK7D5VYPVw4KQy+IAXqu?=
 =?us-ascii?Q?Ft4pZj5hg5DYXiQHutwyrmqZxqTXXD0zKnDuZ8jEzPQN8ebz?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: t5r1430gvN4zzLKzTvgpviNiWja7MaNoSjp4oikUVzjb1jzt5Ul2hW+gkzljofyYLRwH8P0ahxN9Xk+iShqODvjRgxJ/9ZY8U6ksBkTnvDc+bb8JfiiJChj3rYMJDa2PuJoUF/SW0JJ+4f9oB0D3GK+M+Vz5lpZxENmqodyCRlq1QHvxQgDT2QGGi4QGY2+b6PojoISnwENDaJJW1YmxskvkrgbZ01RrNhvGCjr+sr43evlO67+yd6ka+aJLPImHjd33nQYi+r5II+hJEXjd78fWYBXWwf65qZcvh9SGjjm4Kafu4Pgi8RPzz/kDmGUFiofGlPSh2wugHzpNVEfvMQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77bbf6a5-02ed-42c5-b967-08dea0126ed6
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2026 01:56:56.2124
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZvFjHL2EBTEfYPD85URhHIaLFtHG937GWa9DFo/GkRE0FKpkbXWXRAi7sr1zyIY9b54LE9WePMQI0Z2hoiLdQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5139
X-OriginatorOrg: intel.com

> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Wednesday, April 22, 2026 2:10 AM
>=20
> On Tue, Apr 21, 2026 at 07:41:03AM +0000, Tian, Kevin wrote:
> > > From: Nicolin Chen <nicolinc@nvidia.com>
> > > Sent: Sunday, April 19, 2026 7:42 AM
> > >
> > > @@ -2482,6 +2485,13 @@ static int
> > > __iommu_group_set_domain_internal(struct iommu_group *group,
> > >  	 */
> > >  	result =3D 0;
> > >  	for_each_group_device(group, gdev) {
> > > +		/*
> > > +		 * Device under recovery is attached to group-
> > > >blocking_domain.
> > > +		 * Don't change that. pci_dev_reset_iommu_done() will re-
> > > attach
> > > +		 * its domain to the updated group->domain, after the
> > > recovery.
> > > +		 */
> > > +		if (gdev->blocked)
> > > +			continue;
> >
> > This reminds me one thing. Ideally the blocked device really doesn't ca=
re
> > whether group->domain is the one before resetting or a different one
> > changed in middle. It's blocked then doesn't refer to any non-blocking
> > domains. After reset is done it's re-attached to whatever group->domain
> > is at that time.
> >
> > Then sounds there is no reason to block attach/replace too. Just skip
> > the blocked device and update group->domain then it will be picked up
> > later at reset done, just like done here for detach.
>=20
> There might be devices in the same group sharing RID?

I don't know what else can be done for it unless we introduce a new
structure to track those devices then apply attach/replace/detach/
reset_preapre/done()/... to all of them. otherwise it's not different from
the problem below.

>=20
> > Sashiko [1] gave another interesting comment about dma aliasing caused
> > by PCIe to PCI/PCI-X bridge - devices behind the bridge share a same
> > RID (then same device/context entry in IOMMU). In this case unblocking
> > devA could prematurely unblock devB which is actively undergoing a rese=
t.
>=20
> Exactly. I recall we talked about it when introducing this entire
> reset piece: there was a piece of condition in the reset helpers
> skipping aliasing groups, then we dropped it to focus on singleton
> groups for the first version. Maybe we can resume the discussion,
> but I doubt we could exclude those RID sharing cases...
>=20
> Nicolin
