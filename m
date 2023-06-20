Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C1E61FA9
	for <iommu@lists.linux.dev>; Tue, 20 Jun 2023 05:34:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687239284; x=1718775284;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=aV9aimNHcSddhqd2tQMJIiBSxmE2s6CkXlclb8twzC8=;
  b=KM/gxf4KbuwynFlVYeCmc+6WMrjRv/L6aVdXZldr+u1S7zE1uPfLlLZ0
   xnBKtbaEsHsSm9przJ1BymDARB4ab1kigy0BsBT4RA5vas/6gTbsm/lDz
   IfAa01ZBQ2NCWAR9ENA+1uBrAblBkxM2ZqxVAiurdg1glonOGocOCt1cx
   k5/91vR10bzZKW8GuHXS3IBxdVCg2DwgizS4wKLxv/ShKfgysJtFVEt9/
   pEW8JDHe+LlgceDNuCV8UXVKjGgTqIIk13xgplQ/RMPihBB89rsh5RN30
   9ZVNNw/xuaxgTRV4RGWV2ECS0KOIMp4WqVClCL3IxqFUBTwcGNozmQXub
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10746"; a="423434579"
X-IronPort-AV: E=Sophos;i="6.00,256,1681196400"; 
   d="scan'208";a="423434579"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2023 22:34:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10746"; a="691303016"
X-IronPort-AV: E=Sophos;i="6.00,256,1681196400"; 
   d="scan'208";a="691303016"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga006.jf.intel.com with ESMTP; 19 Jun 2023 22:34:43 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 19 Jun 2023 22:34:43 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 19 Jun 2023 22:34:42 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Mon, 19 Jun 2023 22:34:42 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.172)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Mon, 19 Jun 2023 22:34:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BzLFINSHmn+0gWhhTBHsFlaxvJ5LXcvPBUJ0y0OOPwFnnI0ffaHgsflg3nW9pcHUbTuJPlpCQwHUpmTmP/tgdvC7tBxGZ5KOXRtBtaIZiwNsC5NAydSzuWmXbyI/QJC6nBvpxcuS+igZ0+goZukgES0xV/UTiNcZgT3DNN0Q3qS9gw6cx98P8/M+wOwid9zilChhl0FQLEKdNLj0imUWxbkOS6mFuCEQeTzY8ISDfZ1dv0eSgWV7Y3qPTlui/hApdlsIA8TFXJrah5XgJXkrwYJQNtOAkbhTN7ZuUkYVWxfm4lPLziA2Jkvyve4KprDLtyfPts8Trpj8/dfqNrv67Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SdChd0W1imQL47G8F40CmKm6Pn1BKKUwUZlBVGnx6UY=;
 b=O6fOlzoA3t45KTjsBYkj0yV1WrWBmLtaZTeLON7rlvS1sq5qpnoINaI+em6Jw89mUbOfY/NZur+c1KYfIMaJKYVDIxHttIc3iR8kpDo+kp/5tpQkyvx9Fwy7Jh3MBXZY2P1ERKFXUtlBaUPFHc4z6Yl+5So4OdsMU27olTOFegaZF45SrZbh8eOIZJgzy+O4Sp68qoLRI7r9OHx3iWpFIWVCOZRfBGySPuDP0PK/7I71+ivGcCp/PqJAMY1kjNmG+uJP2m2MjlcCzZD07BO9reTmzp3nCDEEKpvymr2uYrfCEOzczSoMb/gi2AQGGh3bcfcTsJ5NSDrneXbkZz5Sbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SA2PR11MB4937.namprd11.prod.outlook.com (2603:10b6:806:118::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37; Tue, 20 Jun
 2023 05:34:39 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::4f05:6b0b:dbc8:abbb]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::4f05:6b0b:dbc8:abbb%7]) with mapi id 15.20.6500.036; Tue, 20 Jun 2023
 05:34:39 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>
CC: Lixiao Yang <lixiao.yang@intel.com>, Matthew Rosato
	<mjrosato@linux.ibm.com>, Nicolin Chen <nicolinc@nvidia.com>,
	"syzbot+1ad12d16afca0e7d2dde@syzkaller.appspotmail.com"
	<syzbot+1ad12d16afca0e7d2dde@syzkaller.appspotmail.com>,
	"syzbot+6c8d756f238a75fc3eb8@syzkaller.appspotmail.com"
	<syzbot+6c8d756f238a75fc3eb8@syzkaller.appspotmail.com>, "Liu, Yi L"
	<yi.l.liu@intel.com>
Subject: RE: [PATCH rc 2/2] iommufd: Call iopt_area_contig_done() under the
 lock
Thread-Topic: [PATCH rc 2/2] iommufd: Call iopt_area_contig_done() under the
 lock
Thread-Index: AQHZotttLRq87ZOpCUijxTgMObyUX6+TK/fg
Date: Tue, 20 Jun 2023 05:34:39 +0000
Message-ID: <BN9PR11MB5276F495C8F98E098EE9EA898C5CA@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <0-v1-9f7c19e02561+31-iommufd_syz2_jgg@nvidia.com>
 <2-v1-9f7c19e02561+31-iommufd_syz2_jgg@nvidia.com>
In-Reply-To: <2-v1-9f7c19e02561+31-iommufd_syz2_jgg@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SA2PR11MB4937:EE_
x-ms-office365-filtering-correlation-id: c5a65e2d-cc55-4ac8-e54d-08db71500aa7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lq/tQgxtCqd5nGsAcoWMpfzArYv0/Gh4xiXCVX9uVPVIY89J8fvJ/MmUoTeXx7fb9aEOLsT1LY3CmLiUWyTgnKlArHUgdld3zM/Ru25ujGXhN9wX1aa5XVsHwmseqhPExz9qzg0rVOVXuonWmSmn4g+iCtVaiz31Rl43GkNpKV7vzZPLYVeYs82n3Sq+S0dRkq7GHBFYXrwry3sLw689ASEnh9CH4ExBYNqshFi3BIhhP4DnJ4j9RNH5WuoNaHDnlMin3luFjfa0jqIxOPwtRyCtB4BYNHZ5VOd2h3jMxwIU8Yp6jePNKczGz1UaM7DP6OlpETPbdRbXcF6sltt6KE9DdRFYOj94RmmKlWu3DWMPjV2hyZy8hdl7lr62uMedHc989hY2NSRhveWeJMT8dJ3VSEywPECKXOAOXoPakE+zuQETXRtLzwTtG39yX2q4i02R2ApwDfRCesATlIJ9rZchgd+QnZ6gLeDXfcRMMwCSe3tpSuMg5tr5vGHIR+eSajNlpERlEpGbMKP3Ytf3B81uLBqgHM8wtQFvyujlQ1kCh29nWxpDIpi9dbr6vwjVbhR7MVJFe55FQ8GyzGBYRlJ0xCIzG5hzGWK4Hj0D29c=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(366004)(396003)(346002)(39860400002)(136003)(451199021)(9686003)(6506007)(107886003)(186003)(26005)(966005)(7696005)(71200400001)(83380400001)(478600001)(54906003)(110136005)(82960400001)(122000001)(66446008)(4326008)(64756008)(66556008)(66946007)(76116006)(66476007)(38100700002)(316002)(55016003)(41300700001)(8676002)(8936002)(33656002)(52536014)(5660300002)(38070700005)(2906002)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?BTSOctQwNtSFPwVUeZFdfrHFld87zaK+WhVzLMP87Mk7w7prIWZGSMmb5+4Q?=
 =?us-ascii?Q?sNCEl2eNmVejPdjZhkzP6y57aZCVjFHKfat0VMYQva2qr8siPyABKuRDyR47?=
 =?us-ascii?Q?abngSAZK3Hw7OwiZhu9jmrW4AIXVcJAUbvvWJNNvsaQQTN0NK3rg8HWGWgQZ?=
 =?us-ascii?Q?8U6DfN22gkwCZBtMREZnm/udSdhEQ1i8Pst70s/SrLZrfxPSdgaxgedB5rYQ?=
 =?us-ascii?Q?Kw4+743TOpS6sgL+PH64I0+Xe/cguHb1Ahj6CATrY/XhaBDevFNqlkngmfVo?=
 =?us-ascii?Q?a0YQdn3ZzjmnlbeY+2hTqK831McL4u89FloWq7pq3FIob+BKAzd5XVyc4nVi?=
 =?us-ascii?Q?jnsEmNgyPFSllrJVUFbalTU4N8tWjRp/QL9jjigdqvVPo4oM4ViPSN3sGZb9?=
 =?us-ascii?Q?6/tUa81IbIJkMEjBUSRA5QcUiuMsG4qBwEPVX6g3uKN+43acuOuWU/piJEnY?=
 =?us-ascii?Q?TZushS+wwwX30WGTqppu/YcOXP0cUoMi6cK49TjCoDSSVpwk4WfpOuzL3D0J?=
 =?us-ascii?Q?YCAQ/yteg7fGeoq1ZhwHHo4Zc+YRtkHkShrZXvsleYOrYNyy+nQfIGrdgXcg?=
 =?us-ascii?Q?4y/2KhEH+yS92D1/maVu3o/g7xV1m35ycP4eFTyr5eove/cKOao6+M6D7uRC?=
 =?us-ascii?Q?oYu4rvZAJlsyDtYWe1LHtBVQxSXIEaXTyNIbZHTRDUiAc9rRK2Oujgxv8fvk?=
 =?us-ascii?Q?7alouMxGr+S6cc6+T1wne+cIQQDwSnsEB5j7n1tnTK+Cd8fSTg9G139+mwf2?=
 =?us-ascii?Q?PnD51sza5KuzkUykRY2S8x+ftDxhEgYww9CU0bk0DrJyILI6l62b3vV64Vfa?=
 =?us-ascii?Q?vIpVKPlLj4ka9ZEgqjNsM0JMTNBDz+f80JqJD+OlvKpDZnRKDMepwBg606YL?=
 =?us-ascii?Q?obrks3J/mvaE84iIsJ5mPUkLe+HPWtTr+HEPb3t/9z9DAxEm30t/vaP4pmha?=
 =?us-ascii?Q?+TnY2eaeU88fmfo8SL2tN+6MsJl63OKyMcDLRjoUju0TE8LC8SbiaoUs7BhQ?=
 =?us-ascii?Q?lcIyOKJfbkrTNfYiXvPiiM7/UcpcBSvSgLd5WmILgW3PLpkw/+wNQ7Z3v993?=
 =?us-ascii?Q?pGxD5ldv3ZOwU8INFFqcRwi23uqNlNQC7ZprbSZIPGTd5e4kW5CJmWx32CSJ?=
 =?us-ascii?Q?MsOaEtrYVbEKFXqyqGoeD1IpUY5IcuqmPr30o4dTXsID2Cyg4uc09lM4/PYn?=
 =?us-ascii?Q?5GeWRiBFtaBrY1e1W6qoe1I+uXgbCPfyqRdSfoU5DFdrYlrVjuGt1nHm2+qX?=
 =?us-ascii?Q?OcCsAv8jXFEdD67plIIkDSJQDolt+ebGEbXMsIBxhfXBOsNB76zd4Kc2kT7o?=
 =?us-ascii?Q?g+1nQPgvVn1kG1Xbe1Lh273/yb4bjfIuBL/RzToVc7tHtDvGCT9uKj9ammpL?=
 =?us-ascii?Q?2PezmcFrNd1PTl5A3PLBoUTvkhdaBkKdNEcSj/WqY9CLtqTCMu2Y3fT5oNnj?=
 =?us-ascii?Q?pYmBXi2kBLiH1kJp4CRaA2uFs0p0XsVDIqqmn9fkcFfQJoDAWHN3Vm1lwFfg?=
 =?us-ascii?Q?QSugtbFpcwQ1TPY4zB1g0bwjxziqAYkRz7gCgpQMf8jz2d7hRJzvna3CD2wQ?=
 =?us-ascii?Q?ByeGJj8chm7sfhYElXk6mx8Wnp1gWXJPjlaltBUi?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c5a65e2d-cc55-4ac8-e54d-08db71500aa7
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jun 2023 05:34:39.2644
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zGYPRl5B0DXAdMo4YZdaFhJ1bS2IiziY+gVsZBNZvwfM3bzoqkK7UsH9bVDV17QwI/F5cj1IJW0jhvcrbBd5CA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4937
X-OriginatorOrg: intel.com

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Tuesday, June 20, 2023 2:25 AM
>=20
> The iter internally holds a pointer to the area and
> iopt_area_contig_done() will dereference it. The pointer is not valid
> outside the iova_rwsem.
>=20
> syzkaller reports:
>=20
>   BUG: KASAN: slab-use-after-free in
> iommufd_access_unpin_pages+0x363/0x370
>   Read of size 8 at addr ffff888022286e20 by task syz-executor669/5771
>=20
>   CPU: 0 PID: 5771 Comm: syz-executor669 Not tainted 6.4.0-rc5-syzkaller-
> 00313-g4c605260bc60 #0
>   Hardware name: Google Google Compute Engine/Google Compute Engine,
> BIOS Google 05/25/2023
>   Call Trace:
>    <TASK>
>    dump_stack_lvl+0xd9/0x150
>    print_address_description.constprop.0+0x2c/0x3c0
>    kasan_report+0x11c/0x130
>    iommufd_access_unpin_pages+0x363/0x370
>    iommufd_test_access_unmap+0x24b/0x390
>    iommufd_access_notify_unmap+0x24c/0x3a0
>    iopt_unmap_iova_range+0x4c4/0x5f0
>    iopt_unmap_all+0x27/0x50
>    iommufd_ioas_unmap+0x3d0/0x490
>    iommufd_fops_ioctl+0x317/0x4b0
>    __x64_sys_ioctl+0x197/0x210
>    do_syscall_64+0x39/0xb0
>    entry_SYSCALL_64_after_hwframe+0x63/0xcd
>   RIP: 0033:0x7fec1dae3b19
>   Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 11 15 00 00 90 48 89 f8 48 89=
 f7 48
> 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff=
 73 01
> c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
>   RSP: 002b:00007fec1da74308 EFLAGS: 00000246 ORIG_RAX:
> 0000000000000010
>   RAX: ffffffffffffffda RBX: 00007fec1db6b438 RCX: 00007fec1dae3b19
>   RDX: 0000000020000100 RSI: 0000000000003b86 RDI: 0000000000000003
>   RBP: 00007fec1db6b430 R08: 00007fec1da74700 R09: 0000000000000000
>   R10: 00007fec1da74700 R11: 0000000000000246 R12: 00007fec1db6b43c
>   R13: 00007fec1db39074 R14: 6d6f692f7665642f R15: 0000000000022000
>    </TASK>
>=20
>   Allocated by task 5770:
>    kasan_save_stack+0x22/0x40
>    kasan_set_track+0x25/0x30
>    __kasan_kmalloc+0xa2/0xb0
>    iopt_alloc_area_pages+0x94/0x560
>    iopt_map_user_pages+0x205/0x4e0
>    iommufd_ioas_map+0x329/0x5f0
>    iommufd_fops_ioctl+0x317/0x4b0
>    __x64_sys_ioctl+0x197/0x210
>    do_syscall_64+0x39/0xb0
>    entry_SYSCALL_64_after_hwframe+0x63/0xcd
>=20
>   Freed by task 5770:
>    kasan_save_stack+0x22/0x40
>    kasan_set_track+0x25/0x30
>    kasan_save_free_info+0x2e/0x40
>    ____kasan_slab_free+0x160/0x1c0
>    slab_free_freelist_hook+0x8b/0x1c0
>    __kmem_cache_free+0xaf/0x2d0
>    iopt_unmap_iova_range+0x288/0x5f0
>    iopt_unmap_all+0x27/0x50
>    iommufd_ioas_unmap+0x3d0/0x490
>    iommufd_fops_ioctl+0x317/0x4b0
>    __x64_sys_ioctl+0x197/0x210
>    do_syscall_64+0x39/0xb0
>    entry_SYSCALL_64_after_hwframe+0x63/0xcd
>=20
> The parallel unmap free'd iter->area the instant the lock was released.
>=20
> Fixes: 51fe6141f0f6 ("iommufd: Data structure to provide IOVA to PFN
> mapping")
> Reported-by: syzbot+6c8d756f238a75fc3eb8@syzkaller.appspotmail.com
> Closes:
> https://lore.kernel.org/r/000000000000905eba05fe38e9f2@google.com
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
