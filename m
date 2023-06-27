Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CCB61396
	for <iommu@lists.linux.dev>; Tue, 27 Jun 2023 05:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687845024; x=1719381024;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=JzDWxQ27cvK+33XHKP6RuBX+jNRemQzvGCz5rUtlq+U=;
  b=FvV8gcu6NCc0WhJpVa89D50pCYQBh7+inSILaOONtlKkKbQn8E21cFCi
   34xY08DkyIJbP8UiiVufFLD2wJxasTUSWK2Ltq3JIePUv8AqyxRfKa3iq
   IvyI44hTwoqHAP7O12bBiVzEh/f+cf2vBVf8T7NfRUJz3eJgHx0bSH+x6
   xBmYqMJOOo+WmVf8dQJiwmLta3b1yUYGFAFKgIZBRI7fIqiltINk+GPxq
   HJc2BQ/xySSM/MSuNND3kE9jJAae6jT7RAXyjDTREoljedScQlzgSan7r
   mZ/pDzl9A08CrZylyaGGNMvsuD6eMDo4M56LRnHCwXA7lbJpS56MxkKO0
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10753"; a="341822537"
X-IronPort-AV: E=Sophos;i="6.01,161,1684825200"; 
   d="scan'208";a="341822537"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2023 22:50:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10753"; a="806326740"
X-IronPort-AV: E=Sophos;i="6.01,161,1684825200"; 
   d="scan'208";a="806326740"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by FMSMGA003.fm.intel.com with ESMTP; 26 Jun 2023 22:50:18 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 26 Jun 2023 22:50:18 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 26 Jun 2023 22:50:18 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 26 Jun 2023 22:50:18 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.109)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Mon, 26 Jun 2023 22:50:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=crDjvQ5Tl+2lBDiuTdtF6oDglALyFDCQYtxcHHg4x55VX5M5Tf2DmUjR6DWkEgxaLQ/itI3KcSOZZPtmu913gPXSxDXp/KjdIEQzcQxsvmXfe0fDhC8VIO3BUe0F6SAM7qPcWTRpRZ0aI6No29ZgBtUg2IF8ukhjEnC29ik9/K0nRSzera2aLU5lkWgsXeD1/aFTa7nM7HnGA1H4Y41fNXZ19KAcubY6dCnKTJifVio8zl3SJaC2jUvQk4UO6zkZLzSqDGCd4IA9xr0IjqtJKwz4NGCSLIVt2ZcWkbLWhqMsMFo9n/MOpm75L27p9S4GXJUV8vCbgi7evcMOP4gXuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gz1sHMIf0Aa0k3eCzSkPkAGPxrtq1Qpuy56MnGL2WM0=;
 b=T67dfhACI/zH0SAVLhBAG2ZddqdU/ii9/P8jfvjhn4eUnYnNdq95pvexXm2HiwyGEAlOJheGwbQ1R0fgpD2v7S9qpWiXLJi8cITb09TOo/YjmSWtFVAxaRnjEbht5W9m60hEE9zdbesNyOsKmfi7EvlPg/rpuFIQZsNaSLuZKH9nnjSecqi1sJZy+RrP0KHbzx9iwsuiVXqeiQ451P/5PgFbtzvKkQPdNYj+AWaS5FRK620T6bl6qXJk/aXUhSV/EB0COV8nQRCKFIQdTy/mjh3tUJqjsD9HUXSsVUcggbaYCjXobZkbOIWYV4UOC80KPZFFyqvCqK/ZVKHbafbl4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by PH8PR11MB6877.namprd11.prod.outlook.com (2603:10b6:510:22b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.21; Tue, 27 Jun
 2023 05:50:15 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::4f05:6b0b:dbc8:abbb]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::4f05:6b0b:dbc8:abbb%7]) with mapi id 15.20.6521.026; Tue, 27 Jun 2023
 05:50:15 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, Joerg Roedel <joro@8bytes.org>, Robin Murphy
	<robin.murphy@arm.com>, Will Deacon <will@kernel.org>
CC: Lu Baolu <baolu.lu@linux.intel.com>, Dheeraj Kumar Srivastava
	<dheerajkumar.srivastava@amd.com>, Heiko Stuebner <heiko@sntech.de>, "Rodel,
 Jorg" <jroedel@suse.de>, Niklas Schnelle <schnelle@linux.ibm.com>, "Vasant
 Hegde" <vasant.hegde@amd.com>
Subject: RE: [PATCH rc] iommu: Fix crash during syfs iommu_groups/N/type
Thread-Topic: [PATCH rc] iommu: Fix crash during syfs iommu_groups/N/type
Thread-Index: AQHZqEDF+SRB6t6UNESzONxGbjpLA6+eJdoQ
Date: Tue, 27 Jun 2023 05:50:14 +0000
Message-ID: <BN9PR11MB527693B1ED4A994E2E8E68808C27A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <0-v1-5bd8cc969d9e+1f1-iommu_set_def_fix_jgg@nvidia.com>
In-Reply-To: <0-v1-5bd8cc969d9e+1f1-iommu_set_def_fix_jgg@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|PH8PR11MB6877:EE_
x-ms-office365-filtering-correlation-id: b627cd76-5cd3-469c-9593-08db76d26117
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Z/Bt296KBT4QXaHRKg9kaggsUDBoAJ3cYwK1XmXzfn8g0S4VnKMOJ3UN9xK2TYO3dJHMaxuytaabaPsJFZWEoj2pWDW7eOEyNObzYo7Bu+aLnVFe1M2Si782MWgeYTWA/NGgXdlqUsW7hbHN1zS9JHbzqOt5UTAvP4nBSOdE3N26YGKwlpKxIiDTT+1z6sGGiLEjGmTzMprC//7BEuaLI5gimvH4UUSCwvmvtiW2AC/9vgQ2i/RmUbtNzmleNy/vbgGLyvp9JGpxR3Zz61JCC5CFhPlgQ8UCaz3iFYS6mAqWaKlW8RYGqzI/t02Afl2IZTIEPPR40g2P/KeE/INHJiEz5uww3l7VJODWtCMd0XnPT06bFwRccgzFv3iKlLirIUrPR6ypUiXv6WIW/1RdrIDwoN7Jiy4Kc6kHZo8wEqjPl70V4oyeG50pS2qCC5UyQ83aubeVgDDTh2Eu91jA7e0/mh5oAjrF6v10ReKXgqobAQoLbtmIg0YDD+bJFbBE0MFXN2SxMgvGS/s+vE/OwoG9JGvAbJ/8rvocadc5N9y+Upk8sP+ozXS4xhMY4qJPrEf74cE+WWMs4Bg5tiCwGHn1AhVxkeyr3MQy/3oDBGUY2LK5PpYL9Mv3/wRRBoYG
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(376002)(366004)(346002)(39860400002)(396003)(451199021)(83380400001)(52536014)(316002)(8936002)(7696005)(71200400001)(110136005)(8676002)(54906003)(4326008)(41300700001)(33656002)(55016003)(122000001)(86362001)(82960400001)(38100700002)(64756008)(9686003)(7416002)(5660300002)(66946007)(66556008)(66476007)(66446008)(2906002)(478600001)(76116006)(186003)(26005)(38070700005)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?C+hAfZ8EPx5OWaTf1aNWE76ivPeXCkzYOnfZSo7jRMQ8hha4pxEIQk6NRwWs?=
 =?us-ascii?Q?Gtif3PjfNmPc8ut/dpDs/6r60JEUT2xf9qqFOl76sLVFBflw6JHfYyA5N3g+?=
 =?us-ascii?Q?57U8GBwwDLR0ABu2/0eH3Ts1domdBWaAaDSTa5CmtVi9uWGi6e49t3QIQm26?=
 =?us-ascii?Q?xyBblk6bCyPEcWHsr70A7qObwUKu/tcLk0jSdyq2BVYrSRUbHfVZw9bpIZS3?=
 =?us-ascii?Q?IMpSyW+lOXr20H0eR1Qlnj9E2z+wrJw4fnWDlnFrWC1EHQguIj6lnmCS2CZn?=
 =?us-ascii?Q?646rcgvcVi3imfCCJD3zPNZU1+FkH1n2QRg+/AJBcCMej9Y1sSimF9HM3qPb?=
 =?us-ascii?Q?GNzOcV0KONAVTLIi8h1PZ/wZiBGR77lmiBOa5CZer3+KdNXWp8xpo/a0IM2R?=
 =?us-ascii?Q?FhBEDKU3RSE3x0tXu4LhQaIuuEwrsCc8kna0Gt5MFoWH2midNH/RI0LGWgKl?=
 =?us-ascii?Q?ePtVTrTRI2NaaonRqQkVWOhtofvHjNg8fpDIpn7obndbzOHuLBgWFBqZ2l42?=
 =?us-ascii?Q?6zRYlcfK46wQPDUY3HdMJCoeN8+HIfSSCXCX6DhGVcNSoaoz+o8pxmQNsTO4?=
 =?us-ascii?Q?nyvnH1TCzwteoRgL2oqxuljxDrYy91w5N06LKWs7G5rVPF+c/U6vkImLXouA?=
 =?us-ascii?Q?F2yOjCBt/QAkycNQinYZcRQb/Fzet49z+/I+sNQ2pUzDHbzEhiuRqpQhW0+p?=
 =?us-ascii?Q?w+SppUNJkJtgnwEkZ9soLihHZOZafQka4rsMSCawDz4+PidCR25vrgTsqDSS?=
 =?us-ascii?Q?ECj0Mg3m7/hxZfdadF5fTOvGy+tUkXHCkkIhM9q3ycY9GkYUM0Anp9M8Jfbt?=
 =?us-ascii?Q?etnOSwT9Z0ndIXMjyVB2MrH9q4rlrzxl+a6IDbAf3bhCGwYFwGqhNoRKLH8h?=
 =?us-ascii?Q?QKMB5ZgBIOxZWTwnx//2J8cHiWfJpitk45zZbiq0JtU4lb5tB1y6FfOl/xl7?=
 =?us-ascii?Q?jZTssDIoUCZlNk+9ocy17HRTxGjnnE8EpnMqFE58X5L7OwqiBV72AKVelJX6?=
 =?us-ascii?Q?lHOv+a7rsMNesh8FMX1BGMJAcHKJOUpGEqO2E3BGbkMl5aTMKIB26U00tKmk?=
 =?us-ascii?Q?qS65DhJXkx0B/YxzY9dLCYqxbZg1kDxjrp7qFYljQE0FLPK8VX6M1tcjr32X?=
 =?us-ascii?Q?SbiR4bym7FhE0AXZMZ3WxevLBFSM21YH4E8ohR26o+WOv8SZvYTd/LoSjMTM?=
 =?us-ascii?Q?W8A5QZFa2p32aT82av3ltp7kQDf1RYtM+6ILlJiH/3Cos4xUUXtmraiwLPS5?=
 =?us-ascii?Q?P7VOBlzUq15FSK9ivap1aHc1/jo0o+gVAq5D++rcox0mbtqP3XCM9Zi4T3Ix?=
 =?us-ascii?Q?G3SxQCvsGMMpmwDBRMCEu9asujth6wAF+KUoV+ImvvekWiwVPpBTuVa5MhRO?=
 =?us-ascii?Q?U99OQ/h4rgxEc/rjfsmWgHx6UwudsKeQY4I0M8GOe0MN9Vtz0cJNcCAUfatp?=
 =?us-ascii?Q?cd0az1LvidlIO8dFi1/6GTgcZNk2u2phJIrMfOl4W8RJBBPZ4ksSd8/D4GlS?=
 =?us-ascii?Q?A++8UOOXrd7OKl/BUwztS7QR5YCypwfjG/svfgJZCa2kMfSUpkoVbFhNgDFM?=
 =?us-ascii?Q?KH84aU8Wz3ItUNYwxeN20TvM1OofO0amBpEdoF/n?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b627cd76-5cd3-469c-9593-08db76d26117
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jun 2023 05:50:14.7155
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PgnoGp5YfC/chudxjPmNau7gtkhfuk7os4yEjSX0YDhMEXJZCshnvMBRx7H+esILbF/T43ifkqa6fjYfFyoKRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6877
X-OriginatorOrg: intel.com

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Monday, June 26, 2023 11:13 PM
>=20
> The err_restore_domain flow was accidently inserted into the success path
> in commit 1000dccd5d13 ("iommu: Allow IOMMU_RESV_DIRECT to work on
> ARM"). It should only happen if iommu_create_device_direct_mappings()
> fails. This caused the domains the be wrongly changed and freed whenever
> the sysfs is used, resulting in an oops:
>=20
>   BUG: kernel NULL pointer dereference, address: 0000000000000000
>   #PF: supervisor read access in kernel mode
>   #PF: error_code(0x0000) - not-present page
>   PGD 0 P4D 0
>   Oops: 0000 [#1] PREEMPT SMP NOPTI
>   CPU: 1 PID: 3417 Comm: avocado Not tainted 6.4.0-rc4-next-20230602 #3
>   Hardware name: Dell Inc. PowerEdge R6515/07PXPY, BIOS 2.3.6 07/06/2021
>   RIP: 0010:__iommu_attach_device+0xc/0xa0
>   Code: c0 c3 cc cc cc cc 48 89 f0 c3 cc cc cc cc 90 90 90 90 90 90 90 90=
 90 90 90
> 90 90 90 90 90 0f 1f 44 00 00 41 54 55 48 8b 47 08 <48> 8b 00 48 85 c0 74=
 74
> 48 89 f5 e8 64 12 49 00 41 89 c4 85 c0 74
>   RSP: 0018:ffffabae0220bd48 EFLAGS: 00010246
>   RAX: 0000000000000000 RBX: ffff9ac04f70e410 RCX: 0000000000000001
>   RDX: ffff9ac044db20c0 RSI: ffff9ac044fa50d0 RDI: ffff9ac04f70e410
>   RBP: ffff9ac044fa50d0 R08: 1000000100209001 R09: 00000000000002dc
>   R10: 0000000000000000 R11: 0000000000000000 R12: ffff9ac043d54700
>   R13: ffff9ac043d54700 R14: 0000000000000001 R15: 0000000000000001
>   FS:  00007f02e30ae000(0000) GS:ffff9afeb2440000(0000)
> knlGS:0000000000000000
>   CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>   CR2: 0000000000000000 CR3: 000000012afca006 CR4: 0000000000770ee0
>   PKRU: 55555554
>   Call Trace:
>    <TASK>
>    ? __die+0x24/0x70
>    ? page_fault_oops+0x82/0x150
>    ? __iommu_queue_command_sync+0x80/0xc0
>    ? exc_page_fault+0x69/0x150
>    ? asm_exc_page_fault+0x26/0x30
>    ? __iommu_attach_device+0xc/0xa0
>    ? __iommu_attach_device+0x1c/0xa0
>    __iommu_device_set_domain+0x42/0x80
>    __iommu_group_set_domain_internal+0x5d/0x160
>    iommu_setup_default_domain+0x318/0x400
>    iommu_group_store_type+0xb1/0x200
>    kernfs_fop_write_iter+0x12f/0x1c0
>    vfs_write+0x2a2/0x3b0
>    ksys_write+0x63/0xe0
>    do_syscall_64+0x3f/0x90
>    entry_SYSCALL_64_after_hwframe+0x6e/0xd8
>   RIP: 0033:0x7f02e2f14a6f
>=20
> Reorganize the error flow so that the success branch and error branches
> are clearer.
>=20
> Cc: <stable@vger.kernel.org>
> Fixes: 1000dccd5d13 ("iommu: Allow IOMMU_RESV_DIRECT to work on
> ARM")
> Reported-by: Dheeraj Kumar Srivastava
> <dheerajkumar.srivastava@amd.com>
> Tested-by: Vasant Hegde <vasant.hegde@amd.com>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
