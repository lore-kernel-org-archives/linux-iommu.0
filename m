Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE53C372B52
	for <iommu@lists.linux.dev>; Wed,  1 Apr 2026 08:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775031278; cv=fail; b=XLTHEhxaCJ2fKkRI7U1xtbKuP0IraKJpmjUTJGtCM/Dq4rFsFUkvpFeGEkCcIPQqFy3h++eZaSNeRfHAgY3x3sj0RsZNBCpQoFSMsENS+kY4yJWJVzxLTPXadIuMjAo9Wxw++wYcKqGB70Gy5ERO/Kb8467ucxtD7yNq4LbcoB4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775031278; c=relaxed/simple;
	bh=cPMQOY8VilPhH4yzYaI+A12/M8yXKk5y2rJtzB2S1po=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=O83HPfkSu54f78E9EJclflTXsHFJ3t9vlAsTy00kyotyEzyFhHHp2yRkeFJSppOOks1SuTSXwKBZr4Xl4gkn9gygTx0bRq8JTWOzGDKklV9WhoOKpSQahd0FbhSTpEprJMjHlOKu2UdIpDjBkH13wmvEi7Gg//hFmA6+qd+qKaU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UFGIPuHX; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UFGIPuHX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775031276; x=1806567276;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=cPMQOY8VilPhH4yzYaI+A12/M8yXKk5y2rJtzB2S1po=;
  b=UFGIPuHXL7YbOqerpBGo+skwLpRPIaYZbJLPFHj3GAxm3foKHIodcbZB
   STK9VZhsRrFhQi5HMFTqMgKYsBelihO29HacTRLad4h88jNCLztoZEPRN
   mo/KRFli7N2hAJqWIFsRQqX3BN06AGY3giK6adMZaMG4XSgifv5mfWI66
   ++6Bhw7u0RNyUYcQXaOGsGzIVqed9gGx3ljwa+L93XLXHH2wlzPl+tcYk
   ySuoRLmid3JykgI0ue6WbJfYkpjDz2foRplALCQlqXyuzs85shEpxDHIs
   ca6wmYy1E+F0kA8wV/sRABHhC9xsTHTrTj9TfLTrX4c9dyBCM/R6Ik+4L
   g==;
X-CSE-ConnectionGUID: cwzvDlDjRumc5rti2/S7oA==
X-CSE-MsgGUID: 3fODEA84RYuMcjlY7QxFDA==
X-IronPort-AV: E=McAfee;i="6800,10657,11745"; a="79667441"
X-IronPort-AV: E=Sophos;i="6.23,153,1770624000"; 
   d="scan'208";a="79667441"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2026 01:14:36 -0700
X-CSE-ConnectionGUID: mKvy+EbiQbq8zMYsoug4mw==
X-CSE-MsgGUID: rh9+Ld2dRo6l1kzk1fOc9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,153,1770624000"; 
   d="scan'208";a="221752772"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2026 01:14:35 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 1 Apr 2026 01:14:34 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 1 Apr 2026 01:14:34 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.39) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 1 Apr 2026 01:14:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UVhR/KQab/4KFAnnBXx8G/lxnJ+J6qaSUgXNrLaKTN4EdmTiIY8zzeJzqe4ASP+BpvzAIfdteprha8eUpGkNp/BBka820w/fw/dxpcg7ApGIeiKrdLE6YyXDhanynMBp6kngOLcIdtO8vdhvwnXz/LHdwC+ugL92gCd9qcg84E1kSYICBMI/1pgfSdeYCzGUugf49VkP+DIy1L8xHaGRkzUNF9uyKek2ohglnUHZXtqbbX4A6SGj9y2dJbiYPhU8Pl17cwGjQbOZvbkziEeo/BEV1VxIdp7DUZ3kezTkjG0u57heRXfz6+mUtPuGGoYdyEDHQKIG/3QMPeqv706z+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u4d86fteLNwhHwJUWKHmlUb+NwdPFS4N2ESALsSkJ4o=;
 b=Wa85sN4ychuT9urOl9m96agRS3hONRk+S355vpER9vlMDu2//xyPcFXm48cGs/pBbpnUlYijmUsZ0mUP5NdE8ad4zPNqYTL4l5Joa1+Gw7jGhrhDCetgSX4GGIJSMXXN3hjIsOO/2P8VUtSEOlAvz9BCgxe7i6ecvEjaBe7qEMepB+h48C0iWNhr12sLavaFa7ZzrudkvU19CfjtAGIL08euo5rA4RInHrfK7+zwFtVbe2ovPgCE2t0Ew2tI1ZnpYGmiH5pu1IawsOZuWENLy/+N3ZXvYBE7BT0UqhidwzKHC8bNtW0guTlbCCb4krnZBbiPi1Un5rMczb4pK+kBtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by MW4PR11MB6617.namprd11.prod.outlook.com (2603:10b6:303:20d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Wed, 1 Apr
 2026 08:14:32 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::f997:762f:f079:134f]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::f997:762f:f079:134f%5]) with mapi id 15.20.9769.015; Wed, 1 Apr 2026
 08:14:32 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Nicolin Chen <nicolinc@nvidia.com>
CC: Shuai Xue <xueshuai@linux.alibaba.com>, "joro@8bytes.org"
	<joro@8bytes.org>, "will@kernel.org" <will@kernel.org>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>, "baolu.lu@linux.intel.com"
	<baolu.lu@linux.intel.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH rc v2] iommu: Fix nested
 pci_dev_reset_iommu_prepare/done()
Thread-Topic: [PATCH rc v2] iommu: Fix nested
 pci_dev_reset_iommu_prepare/done()
Thread-Index: AQHct1nA8/bevmQlI06FieDQx+fC6rW1tF6AgACtTYCAC7R14IAA1ugAgAVeezCAAFghgIABTEQQ
Date: Wed, 1 Apr 2026 08:14:32 +0000
Message-ID: <BN9PR11MB5276FA21A9E1524DFBF512BB8C50A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20260319043135.1153534-1-nicolinc@nvidia.com>
 <dd72f3be-16d9-4386-82ac-1b8e06186e3d@linux.alibaba.com>
 <abxr7XrsK1WSmr7T@Asurada-Nvidia>
 <BN9PR11MB5276A9067B8D8FE3CB899B2F8C57A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <acbx0NYGq6BOiSDl@nvidia.com>
 <BN9PR11MB52763033F10069ECD005AAB08C53A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <acu8ve3mJ0loitQS@nvidia.com>
In-Reply-To: <acu8ve3mJ0loitQS@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|MW4PR11MB6617:EE_
x-ms-office365-filtering-correlation-id: dde196bd-f0b4-4a0a-7145-08de8fc6b449
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700021|22082099003|18002099003|56012099003;
x-microsoft-antispam-message-info: 53MVcEHLAkgsB9l0CvZGmJYJJGoVr3H9NyvaBL0afTuUgaVCwnmtDMtvHQQqlUKyFNPlyN5Aj/posqA7jgOAkDpADi+Sxn5ul8HHXjD6TS7owirBmEOO7QTUwnMBTJ64w5ja+kdSua7qW1LaG4rr8+cOR7J8Xp0Fs7hgylz+y7/NaLdfO3chcYZ1L3CnHc7DPOd5IGQDf4pnbQ9+3q+59toY2MpJk7OtcyBzSLl4xDxma2ZlyQlB62ZqSkbjEYHFOip24LnPsbznYmmh5dNMCeD6lKLDiC65g3GqFDrisMAxp9IKmknASfbBkYmSAsVzcH3NPFyG9YqjzaHSU6uosVOrJhi9oleLjfmTE+Ytnt8+Qzb0XtObMGgdWhu0GFcd8vPMi1ttZTTOfxNdVzaBU/Wglzu0mWla7YlT3Av75tvqW0sbKPhgf5OzARJg/HPVW3fIt4T+cuIXDsxQDRp1d4eL4t2w+2UMISSaBugHgdSNXO4fBtel7Oncdz3wB+jRHMGbXecnoJFtg6j2TXn7iuE+wBvV+V2Rcgt0cJN41TcuhGr3lvWF2nkjIQKoj89TBo1BwJC8HHRW7Zn02ufLLijDA0dKi+LX9AoqCL3ze77aoINvsA7TnG02hw21m6FrLBVR/G/0f3tuoW9+karfiVJOeZ/YFsrRJNDh0NPi1bRXUt8BhOfe9ObJT0/WZWZytPr9nuyuAfI+Lw8jF1fcVbdefQRR1klhEwW3YlY1N31F7Va3/6gwXaQjAXDMWy8pXZZBGf96ZSY4Cy/LsFAKRu6dG4UQQHl3vpZZNxhwVz0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?SZC0qfz6W0IY7APWH9PRX6QzFZ/ESr77Dmaw/KFVJwMwvDig1APFDlvL4Xe7?=
 =?us-ascii?Q?YBOk/FBbvpUQfZz31bSisFCIU4Nk66wfk+lSn6I86+GMT1WxPDpnJkSlmvrY?=
 =?us-ascii?Q?Nex0ujKuVqDH83kxMUEyFNJcIGphfQXe4Sx9wke2TNLWLnH5sFJ6JhOh45st?=
 =?us-ascii?Q?vA1Xxd/d/DybSTPGjraAwIpk6y48VAiEzCEnEqp7LqaHAelRTtjfb5ddtqlL?=
 =?us-ascii?Q?6jtVigQ2wIM2gSDHC3XkqkuOAVsOWMbpeVvKccmo/hayq0svOkCi6Xk0UMko?=
 =?us-ascii?Q?xMC5INBed31rRbTPHHXa1ThHRa0mCJc1IqtTIPn3a0Sg3asYgSfUPQdkAA8A?=
 =?us-ascii?Q?xxlJO/TIra5iTfIMxhUOet8LLohIXkJBcIbz1kIMYbT9VjIdOgPkRqaEpV4y?=
 =?us-ascii?Q?wcgD7cEUSx5DTkTrH4mMYDnRE8thwZN9YntBLV2MutOZf02AQsBwjAakl1uz?=
 =?us-ascii?Q?aWM5I7dU06+ULQR1LcNAoGimWTtN02EUt5SIDMx/BqERLJpBzuyxOp72uEJA?=
 =?us-ascii?Q?mT84yJL1talCwbbFwTcRRn48nsuYV1cM8kj45oDrpiio7qr5Wezfvw3Ld4lK?=
 =?us-ascii?Q?kPAxSvmsIg4G12I8eBorHuTSAk2ittqm+SDViPFilIrczHyiE/+2rI02/gVM?=
 =?us-ascii?Q?AXryuSaJNsvCNVvhG92TUeBVNjUCGmQPkrYsIG2izMjbPgN40JMDJYhCYQNW?=
 =?us-ascii?Q?2SZdroUA8MKdGl4kNt+VLF+JAoZzC9e0Ei3gmKKtnwHWsPFZrCwb7PWDkN0M?=
 =?us-ascii?Q?tsVgm/oi7gixmjP7ckD6UIBvtmyvtSp65EtsTR36pxpRIXaTR50eo/miYqa3?=
 =?us-ascii?Q?BpKvbYjMM85wZo2fgsH1UE3mu7QQYzLuo3Xo3Pcz3qUuvzVRc1vFs9TOvWIw?=
 =?us-ascii?Q?yDUaa2H7uojkQJb1IdCbawolIYZ7ibdEbH0IJhNbQQx7DmYSDFiS+volGa2V?=
 =?us-ascii?Q?XdInAT/T7Lk7/EhtjIXIb5CsVP8/t+rfmahyAK1euALSHplQcZGv4xjiaB7E?=
 =?us-ascii?Q?GOArxe97ETP1cngtlj4aLLLzlr0YaZCCBHPGg62QSa37NgHojFfGy7I4QzST?=
 =?us-ascii?Q?gcHbWbfbiExO2/IPas5Z6Lp/04/l7fBD7gwTSWTixxqVfxdbrXDdObngkEnC?=
 =?us-ascii?Q?b8EckUUWpBFKlHRJXaxirsA+k9XQpeBRqo1cGBPqDFBFcw9guHZT0rJhyhda?=
 =?us-ascii?Q?7aqxouqTJDvhJ7Xc5BkfrRIn/Dw0mzksY4hnZLiWi37XD9jiU7H1E3FNljre?=
 =?us-ascii?Q?CtzjmXtis4QbXmEpclWIQKbpKtKHYKxRnnbbfe2M/SQPtUJUaIrVX/AMTogU?=
 =?us-ascii?Q?AbeLGYUbDJNCYUwS7UUb/eCsozuRQa3TYtHy83A9/RFyA+3+z4Hz9NS2/jG+?=
 =?us-ascii?Q?JnUlpcroe/oqt4fxaIMmMv8u4FnNvq2gDU6n1C9GMwQxLuAGzs5f+UlOZAGC?=
 =?us-ascii?Q?u2kgP0qwTwPIQ4viGKplj53JuSHB980/atI9aFkCarJWXajKBgXawJ3oA0+p?=
 =?us-ascii?Q?Hz+wb3yVCC+3Rk9EpFSbdXp/xRRTpvxbSd7+HYJsFZ6kRhHDmJWdzXIczdUL?=
 =?us-ascii?Q?4P4sJU3DGqiK678Z+sPqMICWOLPWlXkbcKfAiWbN74ih1EurK0JLSEn0798l?=
 =?us-ascii?Q?6WhJT+EO678NIZ8QW2oaJbobMqViWBFJuFMIJIRY6k5jsorqFOtcTmT2o84J?=
 =?us-ascii?Q?8vMWV2Hd98BXl3oMFmH7gbZhxa78LvTjsvsgZrNO5gl45uTi?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: E/QtA1qmL+f/s80uaYGSh9dsxaX0iBBvmUGIVli0P60ImoyhwYSM+3QbXThB1+otOB1Q9LyuWl5vmOVfv7G2VEA4wDyV28aJ6AMQHekSPkhRfVNbpW5GRx5Tvs0ah/Duh6sD7CG+/wG0hC2TGlkQ/dX8RrkrpF8HUkd9Zv116J8GYYcZ9O1fCDpYvOQy/9QuBCa5p5bsRJVdMzCReMBx8+BZtGP1ykM0NEhCwF1WN0clktaAZltU511Df0UosFV1pRTtOFSFnOzj+xfyZ/aJsuvCs616/wKZHL+ZULPgF8KX5ZD3JiT3CtcHvDPQUb4zBPZXfely5YyBiB/klYGtyw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dde196bd-f0b4-4a0a-7145-08de8fc6b449
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2026 08:14:32.3574
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UcHiIexOCqx2e7b9mUf+yUIJ0QAy/McZGNr/FMNKBSV+PmaXHXY3/O0NQPD9EkoPg+6ujlHA2DoFdJEfbYVUNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6617
X-OriginatorOrg: intel.com

> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Tuesday, March 31, 2026 8:23 PM
>=20
> On Tue, Mar 31, 2026 at 07:12:19AM +0000, Tian, Kevin wrote:
> > > > > >   - prepare() only detaches the specific pdev, leaving other
> > > > > >     devices in the group still attached to the original domain
> > > >
> > > > no, attach is per-group. all devices are changed together.
> > >
> > > I think prepare() should use the per-device ops:
> > >     ops->attach_dev (via __iommu_attach_device)
> > >     ops->set_dev_pasid
> > > right?
> >
> > it's per-device op but the condition of calling it is per-group:
> >
> >         if (group->domain !=3D group->blocking_domain) {
> >                 ret =3D __iommu_attach_device(group->blocking_domain, &=
pdev-
> >dev,
> >                                             group->domain);
> >                 if (ret)
> >                         return ret;
> >         }
>=20
> If the group->domain is not blocking_domain, this device will
> move away from group->domain to blocking_domain, while other
> device (in the same group) are staying in group->domain. No?

yeah, obviously I was wrong here. will review v4.
