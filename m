Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B341E31716E
	for <iommu@lists.linux.dev>; Mon, 13 Apr 2026 06:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776062505; cv=fail; b=az/xJRNEIGayF7EuDV/ttJiECQB/Hc9hwYZViQPTaibJ6694Oh3T+ZhiP3djOpzR5DGnd0U2D5wlq6qKpZuMz29iEfg0bxWU0ptLAaqGH/YGgI7pSE0K2Yf+kZcK3MYwWAuNkx3cju4Anz71h8Uokxv6m+2VrJ1k1eSb5tMJkZ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776062505; c=relaxed/simple;
	bh=7j9QTZa3zclUTf+AlLB3RlIyMXfYPdNMp7XtSjzZUGo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dPXpX/QOjWNxpuoLaGKopvA4efs5ciY/eWVa+A52QmO2WQ0b910AKNFJvPYQqEBUn98Xg4KP50a19Q/7qrPNOF4laLjyhb3Xy33HODONiSkr404Y7xZQugMMMnYrvGjPwrZpNAP/5jNADDzCh08cXpxKIUjA4bHqiGXD39lRVkc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MHLQB96t; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MHLQB96t"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776062505; x=1807598505;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=7j9QTZa3zclUTf+AlLB3RlIyMXfYPdNMp7XtSjzZUGo=;
  b=MHLQB96tkfDaDh1Zi6fzjhPizuyKNViC1n2+U/T1t+BbwjAOoT3pzKAa
   wAJTEXgrHGcotXbQQbcWvyBHAPbkaLe1i5Wkq1VlcrwXPdB+HPXr9SGZh
   C+4P+ecs0flaT/vqI63et8AiLMmnuoWg1bGqcpRcQTctQOpJ6rU2jcfiT
   I+JzPpciEo4o4GuYsx/6FptgGluBeT1s1/lvq70+x+QON7kT7JVmy2yl7
   wSw09QiVnurTMbrR1z450nmZcaiGBq1GP7KWe1SfKCCqpWL9Q26ISxskr
   MkgfdENtPJGf21OFt9iXkA7Rm+eBNobB3AOTWnxxYJoYmHoKEcHWi6d8b
   A==;
X-CSE-ConnectionGUID: p4TYYe0pTMqB87PZo3sRQA==
X-CSE-MsgGUID: O0TseMAZRK6YGnxr61QIzg==
X-IronPort-AV: E=McAfee;i="6800,10657,11757"; a="87617215"
X-IronPort-AV: E=Sophos;i="6.23,176,1770624000"; 
   d="scan'208";a="87617215"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2026 23:41:44 -0700
X-CSE-ConnectionGUID: 24NUjJi8SKCtgeST+mN3Hg==
X-CSE-MsgGUID: +seO3gRdQWe4We7PlbWbdg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,176,1770624000"; 
   d="scan'208";a="223213600"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2026 23:41:43 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sun, 12 Apr 2026 23:41:43 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Sun, 12 Apr 2026 23:41:43 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.70) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sun, 12 Apr 2026 23:41:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ReF28SJ2etg3sqQFa56febspwbBux99l06vz/cuDClpNUF+QmyBrT44LelW7qvJuNCbdUAMmA9WXMxvJp/U6MeF/EW+j1Gs9VNUT9Pj5bKDIQ1mjLexF0RrmKaJHEn3PhrQ4OF46Y53/rArFCPzjDKRv+KfqLsGoGRaPjGfgKjF/G4sKDY7bDMnw7bMclB2/l0BT2+6oJhj3AzrP8+Kap3MMZf3/dRr/g4hyc3/RdFMOpYsugWcpWvvfLdr8NI/0oc2A2xrtXoZ7nR+4hCsUeo6HDAcp34TTxc6dYnI+hoxgk/GDaEyClv4YHXBWJKBpp5LFXi8ccvgzFx6Z38lIEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=apHw4HeUPkGXG7mmWcpmoj2G5uFyaOYPbmp7yhbKmWk=;
 b=VkAP23Ov9VfEy4H/548gfjDMnNEgvQ59crnhdHPtQ1li38DDeUkT5jrU4G/VsRN+ocIbpWemLl4FcZjr93SJSU7GviK9Rxz+cyOd81uWDUOq4C/lGoM41/XxPs9gTDdJmkN1yAgOjNVnzgus04IWw22ZJWs2igsE94/CBqNY0Se7BewdYBw4b8uTvYZCSh3Mtk9oh7K0JcyGdgAcvUtzwvG5coFl8RjwHQr2dhn/9m+NmeeGU9j8wUP3wzDmlb9S45IvxAhogY2o3gB7Tj70iErCfp5k3qtcY+ihGzK5pN89+9II0TIAcXlnLBlCvFh4NhwZ5I07pyS4AjMqmh846g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by IA4PR11MB8889.namprd11.prod.outlook.com (2603:10b6:208:565::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Mon, 13 Apr
 2026 06:41:40 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::f997:762f:f079:134f]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::f997:762f:f079:134f%5]) with mapi id 15.20.9818.017; Mon, 13 Apr 2026
 06:41:40 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Gunthorpe <jgg@ziepe.ca>, Pranjal Shrivastava <praan@google.com>
CC: Samiullah Khawaja <skhawaja@google.com>, David Woodhouse
	<dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel
	<joro@8bytes.org>, Will Deacon <will@kernel.org>, Robin Murphy
	<robin.murphy@arm.com>, Alex Williamson <alex@shazbot.org>, Shuah Khan
	<shuah@kernel.org>, "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, Saeed Mahameed
	<saeedm@nvidia.com>, Adithya Jayachandran <ajayachandra@nvidia.com>, "Parav
 Pandit" <parav@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, William Tu
	<witu@nvidia.com>, Pratyush Yadav <pratyush@kernel.org>, Pasha Tatashin
	<pasha.tatashin@soleen.com>, David Matlack <dmatlack@google.com>, "Andrew
 Morton" <akpm@linux-foundation.org>, Chris Li <chrisl@kernel.org>, "Vipin
 Sharma" <vipinsh@google.com>, YiFei Zhu <zhuyifei@google.com>
Subject: RE: [PATCH 01/14] iommu: Implement IOMMU LU FLB callbacks
Thread-Topic: [PATCH 01/14] iommu: Implement IOMMU LU FLB callbacks
Thread-Index: AQHclVnbT7a0V7DOZEGfF3XM1LmFrLWqC00AgC6sR4CABD6b0A==
Date: Mon, 13 Apr 2026 06:41:40 +0000
Message-ID: <BN9PR11MB5276C5EBBEB80311B65648138C242@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20260203220948.2176157-1-skhawaja@google.com>
 <20260203220948.2176157-2-skhawaja@google.com> <abHZdOKyLmmmHADz@google.com>
 <20260410135133.GT2551565@ziepe.ca>
In-Reply-To: <20260410135133.GT2551565@ziepe.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|IA4PR11MB8889:EE_
x-ms-office365-filtering-correlation-id: 4df1e933-288c-4c15-6d50-08de9927b80c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024|38070700021|18002099003|56012099003|22082099003;
x-microsoft-antispam-message-info: o5tnt8UozZFIVSrwRNoSSSeHS6I9h1ok21MhbhVaVKZeXC9TT7ZEYMS12E5cNWXkXrQKy1vMXB/Uwt49b9i9zmy1YXuXc0IIPFeV7c1P9SZWIjLI06D9JjsBgU+6cp34DJVyW8mN5f8Dn0M34ErEufPH4DNr16i3G+yCWBMdEB86MRd+cRu64wAV2k2rdR2Z719fJvlelPhMhy6T/PMOqkaE+lR92bb6Tpgn5Yj1WPYHEi29yQvUrI7tPFdh7vJAOwGzVQZ/gi8V2V6oUXA5pnXKRaKrMuGkcOaGoHa9x/1/V57QZ3eQ9svUexl1dEAmswq89FYUOCzBfr8M3l85UWkB0NOpHv9TCwBFK7QclZUAR3gs68jw5+I6l1y2RA442xM+2a8vYlgd8/wjAsoGnLbC8baqsmJkDR0fz/CFGy1Vzp5N1lxPXYqmckKGvpyvHyE1CamR+zywWzbDZssym0KVtFKQeNFoDC0h8vqFBITC4LLtIktQtg8m3ymSK4qj5aye8Fz3m6aydCXyCwFSUwLoCetTWaMfp7QhJl1f16qQCuVrq4BOeGM6LNloERiHAaIuiGpO+OiOn92RkClgBa5pDnsbbHFLnA50IhdSAx5mFiiRq0O2VaJkaNOdzzE0bNJibIwqOcRakZYoCT8RkC9+oeiH8JtMHbPm//9XV8aC60pdneXMYb53Be0J+Jb8AyI+vkQEe/b+I8klko7K8V1pCwN5qPoyZ+9S9xXWXVst+IYEUP6SOEl1ttELK4KN4Jnjut/8feQ5STUK60DSXCulj6FHnDjKxxVOWMkOt4g=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700021)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?wt108He5kZnLwcgll8n01wzwlTnZfGKyCuMjEFyLFIrZe88zkkkaeGJzFmi5?=
 =?us-ascii?Q?VSsw8vZXJJsMkVAolz+/SsYpdGRVS8FJ0mwZqhaaXm+dvCk09K58M1RtIs36?=
 =?us-ascii?Q?w+HGAkQ+xOCbp0iGowx64AC0nwrjPyc8JD/Bp4XhvsXpgTbMKHOfh7ILKWtk?=
 =?us-ascii?Q?M5mBwH4mDgrxZ+ivwVAvFc+1HLkMnGdGNWUUK8JqSCnr5k4bAFp5GGvMO0Qv?=
 =?us-ascii?Q?EyfyUGVWl0C8y2dfieHGfic9SilsXEJ0JSoFQo4b9A5g29KnXL5qn2oASU0x?=
 =?us-ascii?Q?iGqBz7cloVfdYp7AeWxbw66s/ehZSklE8I/Oi8QgJQH6mgjIjCPQM4KxjGDL?=
 =?us-ascii?Q?t3MlD9kD+NADKaGKbZIVvBmZ9Fw2Y3hEC3SLJv4KEZeP06mymnTfsF5a1WDy?=
 =?us-ascii?Q?w8zMFyoQLR9jh9ONpzGqeFNHNH4Kg+ZRnb3Ub3q7wMW21reqx1gH9lLtmHB2?=
 =?us-ascii?Q?VXVvvlCTnPuUdBcdv8MQ4NrSBv2SR+y+N6kn0sxlBPfFU0lQ6LU4EP1Tpsle?=
 =?us-ascii?Q?LhfAnzIbYhaI/XiT8xCWE+jujy5C+2nTUJzg2D16vsolxMjfbzNEWaN0QwQ/?=
 =?us-ascii?Q?R4qGmNqCOOLLYeAvLqhqCY7CyF45NfD0RZexrDIMfpY9ylBHpWdFu38On+s9?=
 =?us-ascii?Q?lzbtnkKBFWvGtepbNKLZsbKeg7/Eb3P+w5zK8R5drVS6tBRbnRzUPXrOoOSZ?=
 =?us-ascii?Q?XRMsoPkQwUl+vTb7HocYH3mUWkYjYj47kJ3mKQiifJftbRpNhCf2gHQU03J6?=
 =?us-ascii?Q?xE8oZLFBy39/e3kbiAXC0UGwjqRB3zvmXdmY15phM+41viUeIPnYFhIKylTJ?=
 =?us-ascii?Q?KqGDWPcgsql5YB2PXDrEF0pJCM3tgOGDuGtZUllX04hlBjymzkPRKpSj9jKu?=
 =?us-ascii?Q?1ZqeIjp+xfVG2wROY64AVGRRGvtKZNtKDLiXGXCu54SYlE0J/t8ffscBjL2d?=
 =?us-ascii?Q?V11VRgWK0Zl1xykxF5GNkon9EPB/Lb/fR23X8tvENu5H5LMuswSTxA6C5Sle?=
 =?us-ascii?Q?uDm5Un36MEOLvSVx+f5hIV2txJXki2V6FpPkUOa2u/CxcoDkDcrXHMMtBxd3?=
 =?us-ascii?Q?Oi6hVCJ2C1gS8koQ6lqrBqOmPgRwJxWI9BmFLK5wgb4k/uo43Z9oaMlxv0Ii?=
 =?us-ascii?Q?q+PA9CAnwypvHVvO9Q/dQMbD2KQz2iRty2QMTD7WLgDPGKAoMjy4ANXT0OMF?=
 =?us-ascii?Q?z0e9ypspnF5pypYY3KnLx0P6XL8+zpKSqNIQEQOzpkd9TIdztHumPZyGQw+d?=
 =?us-ascii?Q?pLF9JKJL6vYIlAnvORyk8ZobKrRpu92VYjFIc5okqInHMWddJuuxvYfeNQ1D?=
 =?us-ascii?Q?S8yi4K6+84LpYyRxe/7Hx0zQkMkkEvDyAhjUrhFRR26uFTSYvWCGgI3otce7?=
 =?us-ascii?Q?mBFIiTe4GpozxLwDykmbbgjgZ8mMEVw30mzJeXYg+YaamOLoDijw3QzBE/F0?=
 =?us-ascii?Q?RUk+u+evDzu2yjW7LMVUXDGnTxXqCv1bew6EQBugWYmS0X+2PJYaR3htJtny?=
 =?us-ascii?Q?Csxx5LiXY5olbf1esFFCsrvlEb4x7HESsgcAdkbdqpwNhOIaS9t2Yd6PVUO9?=
 =?us-ascii?Q?6B8rNkAbl0xhm/+anO6OlwbukTpKrxspswDKYFu2J1h84W8mXTLlXkVFzWyC?=
 =?us-ascii?Q?RXWVyhbVs0MIk+9B52hmFb8iOpyeR1GKwulOtWMruXQrUV6Z+HXhWih0mnkd?=
 =?us-ascii?Q?zQytslaJhTC2LaFV4lIqUQISs9mW9jP8G5kEYDFTA/sEsu2t?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: hqnvCUBsdoingIGpdKZYQpFX8ZFlR0VYdBRdTRmRMDs8l9+IUHr11KLfhV+cN0NK5NSh0pCZ/26ykBLjFSbv9bN0G3Pfp0IClgaShkY5X2zcgfOfO3BmMfXrf9OyPMhC1iI8x6FHJz4ptGBjA+VBWbYRceCsJW2Mb/u9OZvEHGuRXN74HWY/dDHoF3RopWAXX7wiuZa0FOpSXyLYf5aguTDcWs9f8P2g0Qx89NTyUQOMJzdVerHp7PUTOWaoJc2rSSFEyLUkyZMF2TcWE+FZ6jIaxJsdB/sNuKIIJZ3grY/YG1teZKnme5JmWE0tzgocame9lVexwmqbbNAZ32Bv+w==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4df1e933-288c-4c15-6d50-08de9927b80c
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Apr 2026 06:41:40.3591
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 76W/eLcypKNp15/99cetrqM80PmLgr2xUIJ2T4AGyUab0ncHV/TKs+qveLZTfpb+E+sWUi3620f0/3AyjCNb9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR11MB8889
X-OriginatorOrg: intel.com

> From: Jason Gunthorpe <jgg@ziepe.ca>
> Sent: Friday, April 10, 2026 9:52 PM
>=20
> On Wed, Mar 11, 2026 at 09:07:00PM +0000, Pranjal Shrivastava wrote:
> > > +	if (!obj)
> > > +		return -ENOMEM;
> > > +
> > > +	mutex_init(&obj->lock);
> > > +	BUG_ON(!kho_restore_folio(argp->data));
> >
> > The use of BUG_ON in new code is heavily discouraged [1].
> > If KHO can't restore the folio for whatever reason, we can be treat it
> > as a corruption of the handover data. I believe crashing the kernel for
> > it would be an overkill?
>=20
> There should not be any new BUG_ON's added at least they need some
> better wrapper function or design so they are not in end-users like
> this.
>=20
> But these cases need to fail by preventing the kernel from leaving the
> initial safe boot memory space (ie it is going to crash anyhow). If we
> can't recover things then we can't guarentee memory is not being
> scribbled on and we can't use it.
>=20

sounds in a constrained context similar to kdump...=20
