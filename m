Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8972E38836C
	for <iommu@lists.linux.dev>; Tue, 21 Apr 2026 09:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776764668; cv=fail; b=ZCjKb1/XadJB4HUV32iqxWA9cv4m6R67uguwYum9/oog/sgMBhLxQChzQrIfD9WjAKDNm4y7F9n1JYyT3id2VQZmLD8raUP2GsS4GD5UdQpx/SheHm2buN8Hqid5+KIZjpDNra1Y6fKq1DdAQ9nXeraq/J9lbz9+Klaf1oXWHzY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776764668; c=relaxed/simple;
	bh=51oBSqjunDwpcoOF9kMezb3sV0UA3MxZKfoacIZ12lE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Jd3L8tPNuZqhMXV6ORs7M17e3F3JH3gHlcrM56inf/OCOuXi9vbnANNY5cmnbrzgcUMdrSXMECkfKDRClR70+gfK+VoovpNPpLcyNSoS/XXJgcHhsnl9yWs5S3iTuHmXOPpUaTHFe2tBCMsmpA6bBKEVO1/NQAuDlGO+rlt5j/s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NMGLRIXY; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NMGLRIXY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776764666; x=1808300666;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=51oBSqjunDwpcoOF9kMezb3sV0UA3MxZKfoacIZ12lE=;
  b=NMGLRIXYZUQxvled84jL7CVJP7RAXEeviSywePt/JiKww7Zyc7tjEOkV
   eAFLdtdz9omAFWXDffiGqWhYpu81QIh2ZW5cvgUQdSro0Bks9SkzCFmzk
   1koVF3P8ChpQa8Si6U8faVUP0jLP6DSR7HsJGq2Fa0Z9CjyGgcxOFw29A
   n+tkiyZnbHC7EzsD/BOfFvNyE0C67nELWvV2xWpuYxSZiQHUQy3OFcBbU
   i5VUEiD8fXFiHv2VdZJutVQGgHTR64lfv943+JEcBrtOE/AOGN5FlQZ9k
   hoWNRV0RlFQ5lA9ni4SXnzexqStGBUJm4nzxbPgXu68KpzlhkOX6iCz2f
   g==;
X-CSE-ConnectionGUID: TFSCmMWETb+8wg0v8odiCw==
X-CSE-MsgGUID: /qiYUKXkRdyqxeMt7R/kbg==
X-IronPort-AV: E=McAfee;i="6800,10657,11762"; a="77568810"
X-IronPort-AV: E=Sophos;i="6.23,191,1770624000"; 
   d="scan'208";a="77568810"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2026 02:44:26 -0700
X-CSE-ConnectionGUID: 2AyPu5eOTy2i7RxJ79HMUw==
X-CSE-MsgGUID: /VGSeSjETtmAK+tz0EaZWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,191,1770624000"; 
   d="scan'208";a="232272098"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2026 02:44:26 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 21 Apr 2026 02:44:25 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 21 Apr 2026 02:44:25 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.68)
 by edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 21 Apr 2026 02:44:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CXXcBIvo7NvU21ncfMbeJsQ/VOhLlUcTk9Wgoq2AWQsulbiVbGA8qV98MUUJzetwBXPnTAiJbitr0+/LfvUxbhwIPi3pjx6p//4MJ7b0JV8gXVHOygor2GBuZm3PYyVMSv2bC90j3PjXA1VmUgWEAHehd/9ZHISKm3UcRy8uZacZFauo0ds3tcCr34eopXj0dgjrsvC7/gmw2mnrin94p86NuUsaQJTyPBfHvUQt1py4dw4Gn2/Gb13lTxeUVbEPzwD09dxll3KgbmVu784xoog8U30MjilAjMP5SqBHUXFxc+3sNAzjOqKsD2aoImxWL79NAxtW9+s//8wpogAXNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4M4JZjEdsNXxgecEcmEKCvYA6JRvE0Nx8qVIDwSvYDY=;
 b=nGhopLubVT6zC/eLZ2Lj1/5nnPNj7Lu7xE+yx+X9oBktu0zkEKPskZ7+CfU1ESWZfpnCy+fwq92rigXrfQLOGQFzsKZLvbvo/+/DGBEpXWg6ftQPuboQDYZExQ4cYBiH3YWohLhyA/64Zfte/3KAf/gEtXrwklBT7fPTYQote+j/i8wwpDsL98XiLfN8qWnv92KeMqtTsNYQc5wooLHp0x705ClEWMWptmf2gl3p14OxgKqJbNeOT/iDg4ET1hqMjaj8t1K9fmTl28esAO5KgDW8riFSErnH4Gbl1DLb8DSAvMOmzJyb7izAiLB81ePKoNd+/CF96FHXaGV11Idm4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by DS0PR11MB7928.namprd11.prod.outlook.com (2603:10b6:8:fe::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.16; Tue, 21 Apr 2026 09:44:22 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::37b4:37a9:4f3:518b]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::37b4:37a9:4f3:518b%5]) with mapi id 15.20.9846.011; Tue, 21 Apr 2026
 09:44:21 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: "Tian, Kevin" <kevin.tian@intel.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: "dwmw2@infradead.org" <dwmw2@infradead.org>, "baolu.lu@linux.intel.com"
	<baolu.lu@linux.intel.com>, "joro@8bytes.org" <joro@8bytes.org>,
	"will@kernel.org" <will@kernel.org>, "robin.murphy@arm.com"
	<robin.murphy@arm.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>, "Joerg
 Roedel" <jroedel@suse.de>
Subject: RE: [PATCH] iommu/vt-d: Fix oops due to out of scope access
Thread-Topic: [PATCH] iommu/vt-d: Fix oops due to out of scope access
Thread-Index: AQHc0Tztk5djPT69z0eizKm9VFOZ6LXpKGqAgAAEvfA=
Date: Tue, 21 Apr 2026 09:44:21 +0000
Message-ID: <IA3PR11MB913642CCF52993F0A60A8399922C2@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20260421031347.1408890-1-zhenzhong.duan@intel.com>
 <BN9PR11MB5276573397EB4D4DD8820ED98C2C2@BN9PR11MB5276.namprd11.prod.outlook.com>
In-Reply-To: <BN9PR11MB5276573397EB4D4DD8820ED98C2C2@BN9PR11MB5276.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|DS0PR11MB7928:EE_
x-ms-office365-filtering-correlation-id: 22fb76ab-c152-4bc4-5b9a-08de9f8a90eb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700021|56012099003|22082099003|18002099003;
x-microsoft-antispam-message-info: 70cTCiZraVUd5qUZPJLxWNVPpkin8/hsHKICc0oxb4a3vwZ1m4nJ+JZO5rF4UE/+8ShBeJSNGugvV6Hng1WitxjuaHs3ck+1I0GiQZDFnjOc/D1O7wbQnVmsXrmCXAz9kQbF2zndsTb++2wnuI1om1FdenlbxVHwpuAYiOB7y66Gsw1/ZiRuAq4TSxypM9N+pqGzZIyNJEfsgT/KHBT+qrWO1QeWMRCo5WtLCgRTQh03Dw2LekccIETuy+COFnqBaYQwif9qyIIL+uYWYIGKGq/USUQGRH+rv+GNLlXXDXIJa91KOPrJu/G1NHk8nyHicqL5bjJLz31PI1rqsnWqgDZxT+VNluHF01Omm+85peXhLRkY9+57OTF9RHk78XSZ1gfMYs+aIebFxbn4aqj7JbSyLJsv4P+v71scECMXr8tLZG8O1UeHJCvK9iG4RXeEqt0YaMoIaQ6oIU0z6udqyev+Oa+oQuCTmDCJthdtQm7U7C/sgl2giHW3EhFbukLsKetZC1TolCywLXKsM93fvMBnd4fBsw3PkzS8xrJEfqCn7pQEhshO+UAPmx4rpjLDOafnAFIbathfQVc8Ze8g+sXK61S2Aw7TsMDu+WOJSK8z3meI/3JL9fY1vNm2b0/2UqtpLivxTkW41bc0D/fxE+nBZoHHQJeWWn2paF1HppoeMGeY2BUURzgCLleoa+sXq5lw3Vx41AwdSTyMHtoE5Fw4yhVg1bINzjKzVrphAME=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB9136.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+QoAydcLKGy0wGwIklw21+nT9phhnujHPLcNvPhhdT6Uss/b+ccQpZTlOARI?=
 =?us-ascii?Q?dRzLz4/yAwQFBwMnMurWHijbLYKOXyol4oMkz/unMLG7PyLI18OwZdj0GlXg?=
 =?us-ascii?Q?uLmFJwt6LK2GOar19GNtzYTQi1uU9sG/PGZEi527Q5sip1SzOsqMz3NmVowF?=
 =?us-ascii?Q?Ab8I6oICEWVLssD4PGBCogQd7olEdvgRaT8rMMAxQSSZusQfh49ImdlNPowm?=
 =?us-ascii?Q?YaEgRKa4LzvKA6Fx32XtKfbCYflwtYOhgV4vETLkyNLdswWtKyfsHeGmbeFJ?=
 =?us-ascii?Q?fQa9nnH1frjlV3OUOf6L/FAOOmstd5cym0ubaEkaXW8rxi45ttcdxLmCcW/+?=
 =?us-ascii?Q?TGWf6LFbPtHWHdAd2ny+xYajQZurov31ZNOyu71it7a8vfVx+ynXWEaQDz0x?=
 =?us-ascii?Q?JlQarJ5dpga1sDPnX+tXwe/Z9Izht/1NKmJ2BIyfZfnUrxWZLS8x78SIp+a8?=
 =?us-ascii?Q?m9uxb8gPlMUP19seeExQcXYEcTMae3NnO/ONI5TvqWOVlxn2CwnhXubULEG+?=
 =?us-ascii?Q?wXd414FSCig5LV1q/TCMHboN+zeEN4PoS8QYHWVYLa7A+l7qk0GMbisy1HJF?=
 =?us-ascii?Q?N5xJt36Tq1xT3I6UMmSNVvRQR9NRvgbB0XLR8aDIv9JJVh/Q8WOO/+o5C7b/?=
 =?us-ascii?Q?0iKPomt4L+mVs+kRxvDzeDXMHky8ALh1FqQVdOU8vzXwzRst2yBWQ//6cxgv?=
 =?us-ascii?Q?bEWesXMAu+05ySVkG3h8MGRNTjxtj7grOOR3A2l41spM8YGlyFUbAu39kDdW?=
 =?us-ascii?Q?/WKm7aqVkkQGZo5zDpJF0Hrk0MCUkVqashrCvf4EwRc7tOLtlX1UPZ7V1aPu?=
 =?us-ascii?Q?GO9QLj/jXMnvB/NEEX+xXj4H+b3FbSRIXi0jOJnjqRl+e0U8o2XX/gQAurAF?=
 =?us-ascii?Q?kizQWXqJ3RwRT+dUD5VNtRzBhmMXG86c1Z+BVwz1dzaXKCLEzJeeu14q7/7M?=
 =?us-ascii?Q?LDjbftOA/eDOfxtMaAZGjOlB/FRztTNPIPGrnVh4Tot50N2TxyGUajtzD8hr?=
 =?us-ascii?Q?VvycPq9amzkoe6HqGW4DbclPINmno/s88dHlZquR8z49cmlxbaLIrS6F41Bn?=
 =?us-ascii?Q?8GrcXSSv0MP45Wm8vMmUo8XTxhQcj75WbFei3ycTQoBPTdPhIYCnylIbVyzQ?=
 =?us-ascii?Q?5iFxQwvwxPS2m+Ga4/sOgZPR0QMD9H8fKiqrzRO/VD9oFKLmzbzKP+8FfmEz?=
 =?us-ascii?Q?Zm+mD+JSYz3/0QV3X76dds4YUgRyQOclsLM9xA8kGRAY4PqrcqqL8EE3MJvS?=
 =?us-ascii?Q?xWSRVtzytnjWqt+NvabvRinegzBYMKloytGgml5DBl+1UA3As4VXEu2l73bM?=
 =?us-ascii?Q?KiC7O2p1VoWhk7zDpVaPeLHe3vUQpm1MqXp1NgXw024d+FdXV/w5iA2Dlaot?=
 =?us-ascii?Q?Ed46Y0rvCdLWrrMfatia6hEfh7npONjH5C2wckOP2eGHuxvODClrIyMzRBuD?=
 =?us-ascii?Q?z8oCS5YoXx+vDMZVUl0OPAnuweC1VMZYKzDXHyfFsiZrxxtcyWBxbMdr+UgK?=
 =?us-ascii?Q?HFDEliITO6l3M3T8SgVYC/8xcxztBOjvNxl+r+ftlpJdSVWZzU79U4piU8Kk?=
 =?us-ascii?Q?s//dLvHN/MpNHpiSW7OyNfa+S5QqIM6R1skROeZXBvt2RLgiCx6ErbFbz4lo?=
 =?us-ascii?Q?10kbxqJ1HcOPIa3hvoB4Cpk0L4Mro9mkodTKDgNTvbAG/MMbfTnRTUDSIyYM?=
 =?us-ascii?Q?cFRqNj0CFDsC59S5eVlHNINwVgpNxcZkjCJqcnQveOHNd2yoqgBTsB8ttR11?=
 =?us-ascii?Q?y691WUVeDg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: SrLLmkHleWfptyaBrN2c/hz86QXEWOozNFkqzrraTuNoGzzYdNY/mNkcamY2UvJTZGp5iGbTvA604gOSOLjipQ9WwdZVG38RvWbBW8Oye3sq6unmsKkEof3IgCGzQVVg+N0ev74ncEqhsEJLjLZh1gsCknTTwg54eHZJi5LOzvOUGakrcLD9qWifxBgOUrwWC4koLo+bXZkmgmKIS6Rhi0NUUV16IU3tTNTxk2MQ72EJCjtrmlk5KMm0AuxiqCPkiu5wrvpaauxYc8kjZ4VY0FeUmWJxjbIioOadKizV66eLvX1CIRRf6xW+eKRMNZnvp+g50YH6vqch5niB+FQGeQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22fb76ab-c152-4bc4-5b9a-08de9f8a90eb
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Apr 2026 09:44:21.8725
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HBhP8jzWYwt6I97o74koiKusilFGoZd5XUSavo++tOsIAzYhE4IknF44pvFGV6uaF4WUMi3EMoBf53r7qWNel4tiLhy4ERnr945G77DuFzQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7928
X-OriginatorOrg: intel.com



>-----Original Message-----
>From: Tian, Kevin <kevin.tian@intel.com>
>Subject: RE: [PATCH] iommu/vt-d: Fix oops due to out of scope access
>
>> From: Duan, Zhenzhong <zhenzhong.duan@intel.com>
>> Sent: Tuesday, April 21, 2026 11:14 AM
>>
>> Below oops triggers when kill QEMU process:
>>
>>   Oops: general protection fault, probably for non-canonical address
>> 0x7fffffff844eaaa7: 0000 [#1] SMP NOPTI
>>   Call Trace:
>>    <TASK>
>>    do_raw_spin_lock+0xaa/0xc0
>>    _raw_spin_lock_irqsave+0x21/0x40
>>    domain_remove_dev_pasid+0x52/0x160
>>    intel_nested_set_dev_pasid+0x1b9/0x1e0
>>    __iommu_set_group_pasid+0x56/0x120
>>    pci_dev_reset_iommu_done+0xe3/0x180
>>    pcie_flr+0x65/0x160
>>    __pci_reset_function_locked+0x5b/0x120
>>    vfio_pci_core_close_device+0x63/0xe0 [vfio_pci_core]
>>    vfio_df_close+0x4f/0xa0
>>    vfio_df_unbind_iommufd+0x2d/0x60
>>    vfio_device_fops_release+0x3e/0x40
>>    __fput+0xe5/0x2c0
>>    task_work_run+0x58/0xa0
>>    do_exit+0x2c8/0x600
>>    do_group_exit+0x2f/0xa0
>>    get_signal+0x863/0x8c0
>>    arch_do_signal_or_restart+0x24/0x100
>>    exit_to_user_mode_loop+0x87/0x380
>>    do_syscall_64+0x2ff/0x11e0
>>    entry_SYSCALL_64_after_hwframe+0x76/0x7e
>>
>> The global static blocked domain is a dummy domain without corresponding
>> dmar_domain structure, accessing beyond iommu_domain structure triggers
>> oops easily. Fix it by return early in domain_remove_dev_pasid() like
>> identity domain.
>
>It's interesting why this doesn't hurt us in normal attach/detach paths...

IIUC, other call path never pass in blocked domain as old domain.

>
>>
>> Fixes: 7d0c9da6c150 ("iommu/vt-d: Add set_dev_pasid callback for dma
>> domain")
>> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>
>Reviewed-by: Kevin Tian <kevin.tian@intel.com>
>
>btw Sashiko captured another issue in existing code. Could you help fix it=
 too?

Will do.

Thanks
Zhenzhong

>
>https://sashiko.dev/#/patchset/20260421031347.1408890-1-
>zhenzhong.duan%40intel.com
