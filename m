Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A0AC40DFA1
	for <iommu@lists.linux.dev>; Wed, 22 Apr 2026 02:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776823390; cv=fail; b=TbAuxLMtH0NbVCJShy0VKcdlOIfNOVfZeYUEWlhQSwDfOw4z7Fd00PyoBJEWeBV0bZsRMTuDa8H7y49CnL2kW6AS52isWNGn3h/6wr5EzxlRsuJErNJvyyt/56Z1OlhcyQ8/hbaQFclqJEV61dQZBghc+f50Yavnqq68nxceWjY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776823390; c=relaxed/simple;
	bh=IhsKwrlelYDyuHVSecs9g1nLJBXj/5dNA9StNKmuu1c=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HYTonhirymqqbZl+Y6aF+YTdq/aeQ+EHtTkRWFPjfGJSwU+tVwapK342JUxjIhwh8dBiiEVKDfma00O+IYp5ZxeqXz7r52+EIttdyttheCUTSad4GUbup2ttzi10IowAmS/IBpnFJ0Erx5RIC74PInYPwOcUTZ4fzJP2VwkaVzg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Uof3OPbf; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Uof3OPbf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776823388; x=1808359388;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=IhsKwrlelYDyuHVSecs9g1nLJBXj/5dNA9StNKmuu1c=;
  b=Uof3OPbfsaUlOhK8izzIGX/1gMD5/eOThcS7ZHB56GkJgFmGEf3v3eTK
   VQ4MPb8iP22JHdIBnN246ryIMAPLzKWUS6NgfdwsjAKuICwjbNyM/Gxmq
   a8e+ni+8jixjxNGQ9q3QH9TFMTEVZg5YhzZZOZpJDeiiYtH5A3bE+GH36
   5WlwvRkT6yTjoCgZkmnQ4vZ1Hraso5r/+ZQCVqWATg7043BOJG/Aok2gi
   pIBt1biMGFPRTcVvyUJo+R83FriYQjOg5O3ORZYVREzBCZd1bwWuOpK/m
   l/0t90NmjbHgw5IBL6tIAThmnHVsTuJeezfgZw5Bmb3ohgz1FAJihmKAT
   Q==;
X-CSE-ConnectionGUID: LnrtuB7JT/6/JJUHNUmfaA==
X-CSE-MsgGUID: Nva7vm6qTyewNHGfyBUVRA==
X-IronPort-AV: E=McAfee;i="6800,10657,11763"; a="77838773"
X-IronPort-AV: E=Sophos;i="6.23,192,1770624000"; 
   d="scan'208";a="77838773"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2026 19:03:08 -0700
X-CSE-ConnectionGUID: 0flE/o1vRTmypB1vEtZWHA==
X-CSE-MsgGUID: IHvOpbziSHmbbV+NNHr8Ew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,192,1770624000"; 
   d="scan'208";a="232076207"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2026 19:03:08 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 21 Apr 2026 19:03:07 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 21 Apr 2026 19:03:07 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.12) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 21 Apr 2026 19:03:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OJ0veOFeDxSfdi33zRb3XQGedYdB6BzvrH6wivvOoUH0Dh6YvnwAghBfcChkIeLlxHkJE6MWO5RyaTd3zhs/u6ASF1cjCWnH8V+AAkKGN6fesnNS8RbsaESARbYwTDCLRwmg68g5+jM6a9hObzIcAk8C8nvZxH/LCPqXtmp/0byra3XS+0cOofPc2xduLdOfada8IDUkmcmIMSt4VvP/EPMf+pPSzVk04c8Ch4RA8YfyOx8Ie47h+0S/NfJ7W379EV1u+1oqU/73Vc0hlztYIZeWtFTRZqb/t9fpbAlphNpAdYnd/+R+Ztrl5oHt7H2ZgS+Hl1F4J3IpqLf6cJTDHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IhsKwrlelYDyuHVSecs9g1nLJBXj/5dNA9StNKmuu1c=;
 b=XjrBTO0KwTxWbH3KfoesIRy5kbdKkl16zGkopRLW1Abzy6qZplhlSap4npM3m/VO8thL6bgvjtlijiW2KK5aF3KkrOvvkm23iaGSG/uZgThAJwrG6D6RVg2wdYT1QLMUB3DI/q+VBDN4wq2b9NYVAXJf/gtGOSzWKQ0gG69U1womQRqYTGS8mGyzkBQoHCXPhyDCiWEsgTWKeqFn/NfGuDUj/xfXJCG0yyogIUvhUVHklFlfxJ0D8iQt4LRaIIMP1B76ks0TTTO1FkTg7UtQ+jrMmvmNEmHZvj2KRoBvv49FcQV0Sdlcbivs7eiu/kN7i8YXcSvutHuIUe+sQitZBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by CO1PR11MB5139.namprd11.prod.outlook.com (2603:10b6:303:95::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.17; Wed, 22 Apr
 2026 02:03:03 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::f997:762f:f079:134f]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::f997:762f:f079:134f%5]) with mapi id 15.20.9846.016; Wed, 22 Apr 2026
 02:03:03 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Nicolin Chen <nicolinc@nvidia.com>
CC: "joro@8bytes.org" <joro@8bytes.org>, "jgg@nvidia.com" <jgg@nvidia.com>,
	"will@kernel.org" <will@kernel.org>, "robin.murphy@arm.com"
	<robin.murphy@arm.com>, "baolu.lu@linux.intel.com"
	<baolu.lu@linux.intel.com>, "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"xueshuai@linux.alibaba.com" <xueshuai@linux.alibaba.com>
Subject: RE: [PATCH rc v7 5/6] iommu: Fix ATS invalidation timeouts during
 __iommu_remove_group_pasid()
Thread-Topic: [PATCH rc v7 5/6] iommu: Fix ATS invalidation timeouts during
 __iommu_remove_group_pasid()
Thread-Index: AQHcz4z8i5bfRAAe1k6gG163liM5i7XpHLowgAC0sQCAAIYb8A==
Date: Wed, 22 Apr 2026 02:03:03 +0000
Message-ID: <BN9PR11MB52769DFDF1D81355B4D92E9A8C2D2@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <cover.1776551790.git.nicolinc@nvidia.com>
 <8914b746d0e19b05a26c1fc5d14f170336faa3d2.1776551790.git.nicolinc@nvidia.com>
 <BN9PR11MB5276FCFB54325CC9A3E048148C2C2@BN9PR11MB5276.namprd11.prod.outlook.com>
 <aee6cCAoHt2Vhv4y@Asurada-Nvidia>
In-Reply-To: <aee6cCAoHt2Vhv4y@Asurada-Nvidia>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|CO1PR11MB5139:EE_
x-ms-office365-filtering-correlation-id: 2df7d9b9-09b8-4a18-d07a-08dea0134985
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700021|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info: EcZ4dXgHJXyvXgNYPdu4/HIaygxy9OzpgG+gxMu/gJg3d0cKZc0iu8WGDXSmn9vO4ZPTyfxYue1vt2U/juM8EUcvyRjbPxLKnStNDdvojp50zPwWLs1RoHdvDm00nguOKtVX0rRP/V9QQ06tdsbJ26q5a0srAFH9GKfnkNdbMeBNM8PE2KfPMGdbT4SgBdpLi5ntQNar71CnA2IlC52FAuGxps97EOMWnpL7C3kxqAuNW7MseWhnIhGJLsPAjWVmkFYffDcE8ZXbz8a7uz+kmFJSh7x1l+SDzy//RSmfJEtVzwDMC2E1/nuRV52OrnQnViTT1HAvdRTJVZivi9b97FV1ltPlKfHZzkkI91pVxpNE0IAQgCK9i2z5h4h6X5Bge/7aNtsRy6y114KKFjtdeMy7ZOIWm6zb0i5ahZ+DdfAxb1odm2nlGhZMnXJW9tRn3uuC99ZVL33IRcfhoBcw0gAaQOv9upaZTU0AUaTg1XOs7s7MCoF+b0k80ii1W3NSc5DyRL0flHMEtwp7SwigFfSB1TWR4cp9Zr54tOU/loCoqFqTLehxvlWFHpa/kkyBxTdqIdrrH4ilgsz9q+ocjiG7Mv81OgxBzy3UZGlzQ5UYhVgYogCRaxWBzwzKBVuGUtVJgggg7XYN0mUQRCyrBKcRIDYPi5iYM7Rp79J3dvrttu/JD9a9Zre3kijDd748jV7imoLhJW/6ewidWAyiAqzUc4pnwtvAsnJujqn6VlWZ0dQYNYm7kqU5c+HUCnLf3E8FzG9/gOFiAvKB3lWgM6ay+z2gjw1H+A56ZkRK0QA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?o4nO3yf1GrXTg52rgWvvo1H7O91wS8uXAHWIR2ELvdAoSNwcM40qjFnObJFQ?=
 =?us-ascii?Q?rzhE5vpCYqCjfX1dKXPZ0MmRHrgBOnoo4ng3aEcQqex4wRtx1zd+VtWJc6xH?=
 =?us-ascii?Q?EZZO6Rn7WLNsCXZdEttrNVJy4uQvWfHko3DRFvhoQ794NIyE+/W5KaOzOeLN?=
 =?us-ascii?Q?80nMhzj/YMkjPofMn10WzuOsEPpgw6K0jRE75vUeBqNPp1nCvFtEf078u5Vx?=
 =?us-ascii?Q?f1RSUrxswpGYywyexJbWBBejaRm56ij/q680LuSNePXK2vuc07hlPVaUXmAr?=
 =?us-ascii?Q?3HLgdwbw7Tvp9foCUmE5GxxUyDfZya74SL03ddv4QGbFm/WfrD+3GSOLzypF?=
 =?us-ascii?Q?xT5qBd7oQgTjBbR1dtOmwfw0/HDLZwG/ECOxq2V4/11HgM9SSRLYH4MDDqvT?=
 =?us-ascii?Q?4Ctu8RmSSRmUJnBdN+JacP5n1A+NzC1l2/SwkfDRs+DyRMK0/jb1i+9yb4q3?=
 =?us-ascii?Q?RZK91ZqLFxCa4igLMymRjRLgKbYG0mrsl1wOp9VF4Fi0tnVMXQvEXL4PFid5?=
 =?us-ascii?Q?tU13zVmpATqFfY1i0KFh93OS7V17WDXdBJlWMMTM1mAhR5Pj3stCEy3754Zu?=
 =?us-ascii?Q?kj6bvbSNAv7o8HC/65SxBj5JdQVisNiXAsFiucWXpy6jZZG3SA8LsyZFJZgA?=
 =?us-ascii?Q?ac6lKEkVKCMUPFvIIuj1mlR5U+po+XXqEesiMn1cvo07M2ogrs0rZHfhWDje?=
 =?us-ascii?Q?j64290Md1eqOlaO8NW58D2AkysDfYzPbGYhVYPhBD8IrmjrTnawEGle8EsmD?=
 =?us-ascii?Q?EhXfRsFJJeNXEem7cBVQmLHaFmaXCozxGRE4eKBOQmrQI90kDZ2QAC613D4K?=
 =?us-ascii?Q?Z5lyu83gSXPShE5jnl8guBZ/zpgkLCE7GMBNo7Rb3F5zvLFfF1KSSdF216a3?=
 =?us-ascii?Q?hMP7UNjztJ+Jp6CmowdjrIAsnSmfRE55XyYCjgt5bY4s8cP8CWqqJiZyW2Q+?=
 =?us-ascii?Q?9E8trlK2IrOlMJDSy+DTjBhWEAfDJn6kyQgB3YW5fVLkZDLMcbIJPJADoLCK?=
 =?us-ascii?Q?InFsu5d/lfDvJ3IxsuWg87bz0ZrhaBcrJePwlRZ55mFLPnnZFGDZ4Lu5B3FT?=
 =?us-ascii?Q?IBjCF1SIhJyOvkhOoHLDtUlW6riKE5+5uVhGeYAEzQQ6/vZVmY8yQ1wYDDMO?=
 =?us-ascii?Q?kOUx3qSDbtwxx3JfEVeoQipe9rrZVunx7oR/kv+Mb55ljlWd3KDDM6t4EnDS?=
 =?us-ascii?Q?N64NkCeQ2WXHH02kvnYpz8QONwrvljSpjSl0w4eeqccnZY3Kv3tWAY7U9rSj?=
 =?us-ascii?Q?rfzXSk5QuAspA+08kfXnVXUITQdz9t7xM6KiER5eEPDm0sIDnMplqL0BLjk4?=
 =?us-ascii?Q?jKTiYyW23PDVJWW48N6vKJ9kc4RIdc3A+HsK3DcK1yzw2VcIOqISNys7wsWu?=
 =?us-ascii?Q?q24oGVrYyzt7Io/XdMt/xZQNtVQCVC8rkEofUd9Bp3Ena4Izqr30K/UMhNSv?=
 =?us-ascii?Q?2ESxxAjFhDe/SONks/bEo4GMWqOEAqUa+PU3XXex4UKZD/z7Soj3LqGyzS1U?=
 =?us-ascii?Q?pKyTE8cDHJ3AizhCK2L1Nup++w4Y9PMW7qRshmiRPb+dmUJfXKvAjPh+U6EF?=
 =?us-ascii?Q?k0UMfPJa5aEoiZ8qTmUqHsd6BghavsJAmtj/40gOB5wdvQlTULvw8ljKBWFc?=
 =?us-ascii?Q?ahp7d4fFmga+wSZHgYZZwWBCknixIwLtFCAYUT4XhiYVXd+8urKWZY4RYQ5M?=
 =?us-ascii?Q?dXkryCrLlMvIzEVwK/dos4t1U/yvOtWj54HZSkLkvEqBFyhM?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: AwJP/3nyJEzUmAOhWh52meJ42Bp5HerCiDwMnOWHgVtTsrj096yqngar1PtGcWkFhtZSE01WyHMX13J1X1A0LD6xNZvvPU6QNgvefZny3ktJs5pGbeveGc1cCTxMHNfxAkj9WcEAKte+R+y6q6V3PvRswfNELTRqFpFVeOIGtwfZ8ORKqVDsRdC1uNO2813njQoJE8v3A02DvKg4e7TNOwjLcEKv4AUBjxyUm6TY/z2Zg6iEzzMfPjx+BwaKWws9n6egMJG+tMY9Y+7d9XXjS6RqwlPnBbv/8U7l+hzX6lzvFwY373HrN+7Uk4BZOJwItm9O5jCjJnfq8p/1UY5K0A==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2df7d9b9-09b8-4a18-d07a-08dea0134985
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2026 02:03:03.0960
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QeDOlpDzQ28B94DkSC48TRlPg7X9ojvU/MX1MSWUP+2VdssD4y2miQ51sCb5XcKQ+erkf9NDFOKb1lJvWwbm6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5139
X-OriginatorOrg: intel.com

> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Wednesday, April 22, 2026 1:57 AM
>=20
> On Tue, Apr 21, 2026 at 07:15:34AM +0000, Tian, Kevin wrote:
> > > From: Nicolin Chen <nicolinc@nvidia.com>
> > > Sent: Sunday, April 19, 2026 7:42 AM
> > >
> > > If a device is blocked, its PASID domains are already detached. Repea=
ting
> > > iommu_remove_dev_pasid() is unnecessary and might trigger ATS
> > > invalidation
> > > timeouts.
> > >
> > > Skip the iommu_remove_dev_pasid() call upon the blocked flag.
> > >
> > > Fixes: c279e83953d9 ("iommu: Introduce
> > > pci_dev_reset_iommu_prepare/done()")
> > > Cc: stable@vger.kernel.org
> > > Reported-by: Kevin Tian <kevin.tian@intel.com>
> >
> > It's not reported by me. Instead, I just tried to copy the words from S=
ashiko
> (same
> > in next patch).
>=20
> I think you should take the credit, though maybe we could add:
>=20
> Assisted-by: Gemini:gemini-3.1-pro-preview
>=20

I'd prefer to removing Reported-by and change the Closed link to the
Sashiko one.
