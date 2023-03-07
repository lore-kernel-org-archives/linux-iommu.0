Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C9DB36E
	for <iommu@lists.linux.dev>; Tue,  7 Mar 2023 02:32:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678156337; x=1709692337;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=nsLdJHg9kAbAQhpuMZA5P9Jig5s3jOmn2zg40WBaiJg=;
  b=WF6kKn8+HoIGvO1JoJFS28W27h7+xVJrdTvyGbjJioQ9q7RDrcMkWzQh
   zgAljlml9+bcbrJQZNB+3nTVNoIzHu2Xr9F60jDC4M80fuoD/QkMYgWeB
   BszDea8u2X+2eIuML3N8zfZIqKhzZgZ2or3G8RPFqD4KScS95Jrrpw0oU
   i3BZTOUeMRGyJ6sB45/QOYuFzhPb/g5krGpc7gG1ruuIaJMTLHslSepj/
   hi6ZIquh7xmZNs1gt3xxDG/gnAgW+P7J6snz+bmz23otSS8D10kdxY2mP
   HFtFblXkiQ8Z4hKn8WNoMFSAywOFeuWB7k0m+I8ANRjLVxcy0uOo4+U34
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10641"; a="334458740"
X-IronPort-AV: E=Sophos;i="5.98,238,1673942400"; 
   d="scan'208";a="334458740"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2023 18:32:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10641"; a="706655900"
X-IronPort-AV: E=Sophos;i="5.98,238,1673942400"; 
   d="scan'208";a="706655900"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga008.jf.intel.com with ESMTP; 06 Mar 2023 18:32:15 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 6 Mar 2023 18:32:15 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Mon, 6 Mar 2023 18:32:15 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.173)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Mon, 6 Mar 2023 18:32:15 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IoCBTVjoC1rSu87bjyK+y2c5f7ntdnrKkqj2X05VoFS2i4gY4WxgYQkb9nkSdgDWLHhzXic/ENbZY3eAqyJxwPL1YhjFAx2uOpJPVYHDy2RjgwmNcP+8iI76RV5SPzDCiuhCqq6BiFYqZugZ3IQfJpSWMAQGdP4Hgoloe1bIqI2FBGYE9T5ZMRBxyurxTbug9YIbcB7tgt5e8ELqLdjyFk+EhJPEgtqu7GBLnzYHrSx9dmKnsrFi0S4LW2nOKo8w5bvw5NsLkbTTptNT9Xd0Ky3dG0jzXoAzO4LwzG60xYdBBHqdUNNl1pEizBxjhc5k6ysKT6eVMBPE+s63nZiqwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qSXv76eWp40tLRDYs/xPfttIjt7oOD+YsrwBU2zO4sw=;
 b=ejejoYxp3llwzfHfjvwAi47JZ4PCK1ZxwVJuArgNQaRhYGMUN8Z5ehz2MpamQ74ccoh/yZyZtRni1NFjjd9PofgubugBKTGY7C/s4CLXBV8h2QCV1ljgqIozdhxbqbf0BVe6KQYc11yeqC+AqWvlEE/EBZUXvUxu9eXVfygJkykM8aw3L5ypj6OvcNYc2fL5qY66yB9GCaZLk720+7fmx123t32HMSIM49TchZ1o3vizM0xctliHlfuXbsiRbkdg3mS55oN3Bcg50hYJ3DzFgacZ86DehYPVXALIklbuFfNrek2V9UfsmuW+Aa5D58WCpVlOiZmX6awgJQqxYrLoww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by IA1PR11MB6514.namprd11.prod.outlook.com (2603:10b6:208:3a2::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.28; Tue, 7 Mar
 2023 02:32:13 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::1aac:b695:f7c5:bcac]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::1aac:b695:f7c5:bcac%9]) with mapi id 15.20.6156.028; Tue, 7 Mar 2023
 02:32:13 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>
CC: "Xu, Pengfei" <pengfei.xu@intel.com>
Subject: RE: [PATCH] iommufd/selftest: Catch overflow of uptr and length
Thread-Topic: [PATCH] iommufd/selftest: Catch overflow of uptr and length
Thread-Index: AQHZUFDsjI7xugL7z0mmkU6tA1EOfa7umVWQ
Date: Tue, 7 Mar 2023 02:32:13 +0000
Message-ID: <BN9PR11MB5276A3C40858E1F1B9104FEE8CB79@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <0-v1-95390ed1df8d+8f-iommufd_mock_overflow_jgg@nvidia.com>
In-Reply-To: <0-v1-95390ed1df8d+8f-iommufd_mock_overflow_jgg@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|IA1PR11MB6514:EE_
x-ms-office365-filtering-correlation-id: 231ac7e9-6627-4e67-cf5e-08db1eb428e2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wVThlc520hA68aCVBJkp4OlCmBtaUHH+CrZ2WomhDG5Xhx75vFTcnec/EcbiJ/DLsqlwTXaqU5Rhi1urvAdKi0iTeJPvQwY+dBQ1/AzO52DBoB9IPSrt/GXYWkfmp6Ox/XA+Bzool1MJkBHw6fVJc6Vu/g3devzc20j5eSteB8d9k3SrEERthXSkSJ8V1gtk0vFZoWnlc+S0slugdhksKmxcEHEFgj1FSiDuR0nI8hWAd/+qbunuZIBOgPjTjLLSQIn2sWTOiuDlGZlEpGkCOWTeNW9SuC7DpRlp0vHem3QHv3l2hiWEGm2QOYakAHGlKB2tBivd55jHYq2l22G5IDkPnkGSttBQRNfC/EF6obcTrthpwoK2YEQeZvyB3cPFzQRHN8+b/EdY8NU2WmjRnTHUEdy/dmLRDvFCQBFdx8oyiQQTmH0/yvGBY+pR/DNbyFaY5jU+cCsvMkCCcisNmxAWrpdabJUSaPm33eDlz+MEB3jPtx7vMmzl1Yc746g4AZ5d7Xb7oDIitDdhkWCUavU5YfL4bymzd4pzXDMuJ6V/lc8TX1G0hwqVDdilUCxo2rTCt4jKp5hwschUj0NY4EdZHVaFad3KDNCuD2uWg3JhU7+qOzly/SK7oolPaprDM345L6zEvWcoV/u4Ju9dcIv2YTdtQT5CQgfjto43jqjfmRDexZxHMxT7mLCfrO0k
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(396003)(376002)(346002)(136003)(39860400002)(451199018)(52536014)(45080400002)(5660300002)(8936002)(66476007)(41300700001)(66446008)(66946007)(66556008)(76116006)(2906002)(64756008)(4326008)(8676002)(110136005)(316002)(478600001)(7696005)(71200400001)(107886003)(26005)(966005)(6506007)(186003)(55016003)(82960400001)(122000001)(33656002)(86362001)(38070700005)(83380400001)(38100700002)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?aNJKIxkncDbNzm8kPeMyb26oosFksbCLAy+Q9HsMvMcpGzuc3mym82SKAa6U?=
 =?us-ascii?Q?8SspwEUIU0cCzzzDfJIkYvNIKLm8+cBRPUSNOGifMYGmdoyXDcxNfFrmYfyU?=
 =?us-ascii?Q?7vcd2d3F1CkuXp5eLCVP7jUabRABwKV0QUecyyFjjrDUCcdqI3Ei6kb/5Pyo?=
 =?us-ascii?Q?LmA8U/jj8hgBT0n8CmHDpa1Fe/8ob+oDN34yOC4Jw4yXvhxUBODnVbDh3cg3?=
 =?us-ascii?Q?9v50So8Ewsm7BjcmY4tO1FczzHwEw4pTyasOQ3mR0qTGBg0XNFEdtJjq2Qko?=
 =?us-ascii?Q?GkRpJVidvlBvH92c8Z/839+yCSTykxLL0A4jSkhmfVWAkV3UKTM+pKifGQwJ?=
 =?us-ascii?Q?dCjPcOYU9ZpYzTqRcautHh7EK5FcK3zo5mOW0unAYU9So89L0m9W2YumTQRr?=
 =?us-ascii?Q?grr9pjFvL8gHyt593i3Jqz5+gR/6tjqDjCmfjbfxaJoUkOXhqDTrVvjuyPrS?=
 =?us-ascii?Q?EA9Q9uuLiB+gqtL/utjknt6hnPnz76zWoII+csMk9tf7yaGtNthCvxACdR/o?=
 =?us-ascii?Q?akhh/XWGijdBgzhNBjMICk3l8XAXVrs9QUFI76i48W/wMBGxfYCV8mWPPMMr?=
 =?us-ascii?Q?JzdE1bOS2vvnhsaihcAdB062UDZasc0YcofkY8c1gHAb/MZcHHOh9rht5Tbt?=
 =?us-ascii?Q?4THzP7KCecIu28zHmDX5OTVp3zPPbt+RUlDjqWROf+/F16q8N2yFXT/sUaqe?=
 =?us-ascii?Q?Axz9jypG4yj+hnavEp5ZHfvFrFR9MttvJSmFEPS4Rdc2X/rKoncFBi9H3tnf?=
 =?us-ascii?Q?ofHkAosEqMfmaTNGdSZNNbb4svPoAjkijFClfA0+2QLYLfdHhJ3RHUPuPsc3?=
 =?us-ascii?Q?CQJRhVXbX5w0xv7ND7QfWlML1b3IM/RXwBHRcpj+q7WauEH0VD/XRvcObEzA?=
 =?us-ascii?Q?ytcuTQDNX/ETQbwsPgzTKWZI5Upb3Il4MS8u7MaPoeBFbs5lb+oRgKOMjFH0?=
 =?us-ascii?Q?Z6PHHxnxxYyAqIeKzpI3mH64JLn18ZVuzF5VC0nhLe9LVN2ONQGyJFtuBAiT?=
 =?us-ascii?Q?0sXW01mvzDHdKbwntTSdQUXMfa7KlPQiLtUSr8+RzahxSmWpF32b0k2KzEEL?=
 =?us-ascii?Q?7c19jB2nANaKlniXutlFwCoYW/Lug6/Yhh63Ast8r5uXzMYypKSKxAoCyIni?=
 =?us-ascii?Q?4fJxVlPtPmQ9dH6vMuhOx0nGbXv2zX2os35/ZWCi4mCTJ3NsjPkXCEfon1c8?=
 =?us-ascii?Q?j8s4J5s3IRlkF5/V8PxHUskYkjXDIwB39dg6NKW7LNmvoYkYBrmuoGJ/oBkV?=
 =?us-ascii?Q?yXC0jyUI9ZmvSqndw4gstmpSQ8GtVGYpUP3LHpChkord+m9vadgNp2tcApDt?=
 =?us-ascii?Q?GRqGaqDVZzPhsMzQtO+sgSMZLunovh1M0EtNBECBBoPeWpi+axoTRKvIxYqj?=
 =?us-ascii?Q?oWJXIJsu+CmCRTXjnmlOx7wfsYfTpX6TQA7pc9EjVHHpk/ZivRLLiT4Mkt4I?=
 =?us-ascii?Q?+Zyb3cdm9YpjT8eXXp5cTN2gHK22QXxk+a8XQfN/+WXKR0eBA+5tSrLhL7/L?=
 =?us-ascii?Q?aXyjuyyzFF+sehzqjRyjTI+jdgc4pX5olbzWCh1vb7Gh1KOKzjbKlEm/NcCL?=
 =?us-ascii?Q?b50QyHwjqGiwTChqY8HLl44MHxDuTqXZzTAwifo8?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 231ac7e9-6627-4e67-cf5e-08db1eb428e2
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2023 02:32:13.1644
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uco0l2yf2Gkt++fWmGY2GRxWTH3AmzwQ4bQO8ZhGYp5EYbWfpd9SaYXtxaHlqHfJclRrXGkG1iF5MLa/l6yjhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6514
X-OriginatorOrg: intel.com

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Tuesday, March 7, 2023 1:27 AM
>=20
> syzkaller hits a WARN_ON when trying to have a uptr close to UINTPTR_MAX:
>=20
>   WARNING: CPU: 1 PID: 393 at drivers/iommu/iommufd/selftest.c:403
> iommufd_test+0xb19/0x16f0
>   Modules linked in:
>   CPU: 1 PID: 393 Comm: repro Not tainted 6.2.0-c9c3395d5e3d #1
>   Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-=
0-
> gd239552ce722-prebuilt.qemu.org 04/01/2014
>   RIP: 0010:iommufd_test+0xb19/0x16f0
>   Code: 94 c4 31 ff 44 89 e6 e8 a5 54 17 ff 45 84 e4 0f 85 bb 0b 00 00 41=
 be fb
> ff ff ff e8 31 53 17 ff e9 a0 f7 ff ff e8 27 53 17 ff <0f> 0b 41 be 8
>   RSP: 0018:ffffc90000eabdc0 EFLAGS: 00010246
>   RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffffff8214c487
>   RDX: 0000000000000000 RSI: ffff88800f5c8000 RDI: 0000000000000002
>   RBP: ffffc90000eabe48 R08: 0000000000000000 R09: 0000000000000001
>   R10: 0000000000000001 R11: 0000000000000000 R12: 00000000cd2b0000
>   R13: 00000000cd2af000 R14: 0000000000000000 R15: ffffc90000eabe68
>   FS:  00007f94d76d5740(0000) GS:ffff88807dd00000(0000)
> knlGS:0000000000000000
>   CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>   CR2: 0000000020000043 CR3: 0000000006880006 CR4: 0000000000770ee0
>   PKRU: 55555554
>   Call Trace:
>    <TASK>
>    ? write_comp_data+0x2f/0x90
>    iommufd_fops_ioctl+0x1ef/0x310
>    __x64_sys_ioctl+0x10e/0x160
>    ? __pfx_iommufd_fops_ioctl+0x10/0x10
>    do_syscall_64+0x3b/0x90
>    entry_SYSCALL_64_after_hwframe+0x72/0xdc
>=20
> Check that the user memory range doesn't overflow.
>=20
> Fixes: f4b20bb34c83 ("iommufd: Add kernel support for testing iommufd")
> Link: https://lore.kernel.org/r/Y/hOiilV1wJvu/Hv@xpf.sh.intel.com
> Reported-by: Pengfei Xu <pengfei.xu@intel.com>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
