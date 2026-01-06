Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B5A33242D2
	for <iommu@lists.linux.dev>; Tue,  6 Jan 2026 07:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767686172; cv=fail; b=jw4eb30VX8RgQfOEQT0ck+BuWFTOfugDqgnb3KQ3CKgILjxkncUDPVwlC07eaBiTkOdQZEV+nTVUKARibDSZt7pYOjHCWoL2qA8w7xEDjSKHbp83JZ8oA3WAXbnnFSNrAxkMKPY2Z+EBoCueoRoGhj63KWUnL1SPBs4TJp6QKkI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767686172; c=relaxed/simple;
	bh=AndnCg6EzXd/T55OiP+UHruNpTEbg5z6MAXX6Yps0ac=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tyX4chnb/bgmoHwcu1ZvX5vmgYzyQqkTvYM+GDF8gCZ7+WAO7/OBYZgcfQC3vrTWm2wfCO9cYtF/ul5/ZQ3Tvt7mbV6x1YmfLV8eMSd6qUYbZJz3/QM2RkYnH0ezdjbkdcNRVsVlL4riHtSh6Tw+xhFUgCFhleR8lCiOwUrWxsQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h5aLpRFF; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h5aLpRFF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767686170; x=1799222170;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=AndnCg6EzXd/T55OiP+UHruNpTEbg5z6MAXX6Yps0ac=;
  b=h5aLpRFFGmOzlwcLNVbQrtHDwb/Zn3dyM116KRDmf+vn6xboBTsBsKGp
   ws6Y3UzEwd+b9OFXHFrtjHzgEcuHyzEL94SXc2SgbH+HbTNMeZyrs9nUY
   vwFF1lHhdAGuBrmgaN20eG9X7zeNwZIWOJTlAmEvnpEKDAoCKq9aazs0/
   AWDnVOzZ+kyJivsWphurmcP+7WxGYUyzIqY+TTj4ZfPc2dwMfDXcAV1J5
   YQ7flIPn8wjkaegBmMq2BBc+QLF8IFNxzGIwlQX1tusTv7p18UI/k19eN
   wCGfEW0EnszBU0HBOOsWSzpBDxCQY4HUm7M89q4c6NMIbK9eagThN7BN9
   A==;
X-CSE-ConnectionGUID: pBEw9OibS52U2j7qYjuiSw==
X-CSE-MsgGUID: GhAg/GcSRRuByHEt0MjpNw==
X-IronPort-AV: E=McAfee;i="6800,10657,11662"; a="72896028"
X-IronPort-AV: E=Sophos;i="6.21,204,1763452800"; 
   d="scan'208";a="72896028"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2026 23:56:09 -0800
X-CSE-ConnectionGUID: 4qgPWaAsQze8HZB32RCcKQ==
X-CSE-MsgGUID: AZmqtEHvQgK3mtvE+Sarmw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,204,1763452800"; 
   d="scan'208";a="206736760"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2026 23:56:09 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 5 Jan 2026 23:56:08 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Mon, 5 Jan 2026 23:56:08 -0800
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.36) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 5 Jan 2026 23:56:08 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nzdj8HHWgY0HAtx8EIABRI+M3c0x498slybHh7ZHg6Dx/+7B5XFZCLPduhK04EM5U0EeAqBYzA0Bvd+mDRSw5pVwGxPCYwFW3UHE5vXLbDmpdZ8RqcZnGV0RQykdxeOknomR4D1DO6F2Rxfn57DlWUiss7fIYP9KhiA/3Xo/yu2eUZBY3MjGGTtmMyndYSmk3B06tDvHhZcCo3ZsrKFunWskIf7fA/cm0l6OyXZxaHfQfET9RAtGEcN5T9zpUig0lY8K9iDULR6u+hzsIjnvBh5bs4pAUEayxGsFyAtEHX8bbR9ZrpywX/yCmN/lqKsV0RhHEUihpieEx8Bmo6g7TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NvBgFxX7ATtvbyeUQTZb5EtBU54r/pjURbYm9KFyiD4=;
 b=oFACtEt4qeLtsxzG9SrgIxXfxdZl7C8i8m0XSu6pCR9s9q/9llvzqyMEdL/FnK3KbtYxux/4UGwmBmLnhwPrabEjBynz4a3NSG8bbavHum0L1j0umOBesRS9QBiIXnkML4oB+G2bkr/6VGlYpdUHr3QMKxICm4/K+jeyOledPUwDnrnCoF4TIx4OOR9qT4Xg211GeggqLiY35dG8e+vf2j8scfAn94kUcMuNUYNJ3cJm7DologFHdzOGEVOgyIeg31rNOx1FhFDF10z9Aoiw5KLri+ibBuGZAZJ2EfJ+bjf0fFrbiFgzKwkk6Ioyo4fUchVAnPg1w4JSxPOXcc4O3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5271.namprd11.prod.outlook.com (2603:10b6:208:31a::21)
 by PH0PR11MB5832.namprd11.prod.outlook.com (2603:10b6:510:141::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Tue, 6 Jan
 2026 07:56:06 +0000
Received: from BL1PR11MB5271.namprd11.prod.outlook.com
 ([fe80::780e:4379:6988:f48b]) by BL1PR11MB5271.namprd11.prod.outlook.com
 ([fe80::780e:4379:6988:f48b%6]) with mapi id 15.20.9478.004; Tue, 6 Jan 2026
 07:56:06 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: "Liu, Yi L" <yi.l.liu@intel.com>, "baolu.lu@linux.intel.com"
	<baolu.lu@linux.intel.com>
CC: "joro@8bytes.org" <joro@8bytes.org>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "jgg@nvidia.com" <jgg@nvidia.com>
Subject: RE: [PATCH v2] iommu/vt-d: Flush piotlb for SVM and Nested domain
Thread-Topic: [PATCH v2] iommu/vt-d: Flush piotlb for SVM and Nested domain
Thread-Index: AQHcc9mNWDZpjUK810SNXPnHiy9eJrVE221w
Date: Tue, 6 Jan 2026 07:56:06 +0000
Message-ID: <BL1PR11MB5271F0467C6CA56DCF9C78B58C87A@BL1PR11MB5271.namprd11.prod.outlook.com>
References: <20251223065824.6164-1-yi.l.liu@intel.com>
In-Reply-To: <20251223065824.6164-1-yi.l.liu@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5271:EE_|PH0PR11MB5832:EE_
x-ms-office365-filtering-correlation-id: 7a9b644c-67dd-49af-ab04-08de4cf90c08
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?KTRAJSIPddFeb+ycRHXLsaFK6GmWKsmaUEmYSnt3bAW9NK/A9E2fnglapz3K?=
 =?us-ascii?Q?sRnFWswTLBOOSiwiD6NLPdedEnkM8P2YrUz79yLhQKUiHA8GpJfFYG1tzirf?=
 =?us-ascii?Q?lzBmDeqOgyW/zlJa85t9TqAi4fL5bgGwxuUFDogC6GXn3jWO5RJJUCn6WGn6?=
 =?us-ascii?Q?1T9mVNcpWmoYezKAV0Yl0Le73obh8X8RMM9t6xgmSeVph9fjggf7XfD04P/g?=
 =?us-ascii?Q?T+VmeiG4uyPdeEOAQqMRxQiw2+PD5DYJRNANC08Xvhy09zsVCiaDzE66Fd//?=
 =?us-ascii?Q?CAJN6Xeswf2esgjWtGGzLwz/wIhelC1IUP44Ef3N8Bt5pZKA4RurLmPqibOB?=
 =?us-ascii?Q?LH4bxiAweCvIF1XxQIXijW5LZ8z+wI13wwfnDbVCmVCJL/P7Sq6nVa1b3UcV?=
 =?us-ascii?Q?xlKNCrp1nWJ0Vy5/VQi1M+6dhjX/X4djlMSX1LasxGTQFh/TeFYD/rXOUAez?=
 =?us-ascii?Q?WQ+Sc69QtA5vE/o/moD2ZCaQVI8CBxX49StLVCGdAN8EUFVGvYUtqA7On0Mf?=
 =?us-ascii?Q?iY/reX7rF2vbaFBjS4CAegPm6lkoGoqtrHK1nNtULg+8SL4y35pwGFcBq2Pz?=
 =?us-ascii?Q?cMrHsfjMY/qewyRMaRTXVwuh3q0R5/L/YABlg9JtKlYVmJTGThMILbX6/06y?=
 =?us-ascii?Q?B5b8fBCVlmfh/RZKD8vVpVS4Z1m0Nm2yl92TAr0kLOoaGibAg0sgIY06Rns4?=
 =?us-ascii?Q?T/X1FP+/GjHnmEgF9vntkVs5EkMOc0YHqZ7tS/ktcGn0Ub9S0VWzc8rBY0vL?=
 =?us-ascii?Q?VOMpMBE1/9LOZF+aDTs9Ch5e5v/oPYzNHV+o317tvkTTc+DS0DlHgSe8tDKs?=
 =?us-ascii?Q?RWgDbZztbAduirPbavVtLaNp05C2gB41jJ/t5RN4uxhtZ1/qOzGk3MhHsY35?=
 =?us-ascii?Q?4xSC77NGbuHn5byLukA3qkiZJ+1ZCmKHVA2G6UfQAEgozbxjm0JYDOESikPq?=
 =?us-ascii?Q?vw0W55ZXAYVyObTgSduDDxDOm5no/1cjotqh7YlQHmEEziUSNmYeBkF2ZIve?=
 =?us-ascii?Q?C/rE3vjaTQsIxlSBhmfvY2OTjvqFPLZjoJrDmnXT3HAggD9wPmLMd9CrtJDv?=
 =?us-ascii?Q?S5wC0XSH2hyrD7y7h1ccSrEoQRtOjFxHwI4AGfgvb91grS5wg76MqnKqjkQ7?=
 =?us-ascii?Q?JNiXz08jZkMjZI48VNKgl6MbSNrsTtmalOJ7iV8dhMHTtRHV1gwsFSdyBt65?=
 =?us-ascii?Q?paeIVvMNUGdRjhtw8cI794BC4TfODg1ujM9lxCnBQJawGJbm2+vWXewfwQ3d?=
 =?us-ascii?Q?TYvbOdDjk2IIY8xVw6599K4gyKhPHq7IPPYyyeL4D0R6UNRFUipjh21KoW6F?=
 =?us-ascii?Q?xNdXi8BsfmhTBJSoeJL44pbmjlpdC+VbYvgiuMiJ50eV3wOH79Z+wnUHQJ4x?=
 =?us-ascii?Q?6JlqP5YHxt9SRnaP+6nrcAoaorS7xgBozWJF9o281AU5d4KnL+VvBQBIFk8S?=
 =?us-ascii?Q?ijnqmaJHWUIdfE6obK+7hdwvo/d4stXjMf/rvpm6HRnvk2E7qlB9IzdW/wT4?=
 =?us-ascii?Q?+AGJRV+ElD3XexAXv1IQii4D0FXXfW4ATwWj?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5271.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?4gqdS77tdOWPbd82gAYJavMMZcxjfL8F4UQIaL31kz1g8rx3a8Q5kpb58PwR?=
 =?us-ascii?Q?nBW4DGagoknAGYf4CV3Z8GEtPmy+03migNZvYQdU/A2+IaCPGodjAW60CbMw?=
 =?us-ascii?Q?zdmokOXilIcaB3hzK2xzBO+n4YchhTz+p5w58x9N761nS3RXfNFYA07O4NEz?=
 =?us-ascii?Q?4xDH68vFhsyltssEi51omQzpEYc+l0P4VGu3cyIQRLIv+cy1PBidbzoBSY5M?=
 =?us-ascii?Q?nPrEojP05a22csRWAHNUt+FRrt+V9vMNFRFlc6+TLyOgOPGrEw3/HpIwQ8LB?=
 =?us-ascii?Q?n3wXMbzwACdtduy++xI9Dr+4kgQIHhmC7EOsM/ODhglouLSFc4E1EkwGCxgD?=
 =?us-ascii?Q?L/5v9ZcurbuqasEDGfR+uh2r1OdonqRMUdVecpoO41CE2RUh3e3Cqly7OFlQ?=
 =?us-ascii?Q?SAw3rSR/vO4D/A6DoTJoM//QBRQyZGa1pkOPR/bS7bqh5JjYRUnSqI/3osuT?=
 =?us-ascii?Q?/xTc4kO3MiS7X/v2+HlZS4XpElfrhlzgEvGLRZJUwVb5azX6RuBYNuwThylf?=
 =?us-ascii?Q?JLl7DBjgKKLgEFuV8ZRMf2q47348q9284FY9dbwAuSZkP4whgx0TVsWPIXtZ?=
 =?us-ascii?Q?h3HC0tT/q2PusO17+DASiF5DoT+nORSmnVtcJpBheongc0ZlaFFVRDEEIFFw?=
 =?us-ascii?Q?fA8dFFfBJoIHazQ/URQpszlvJlTFoLA9vnlCkBsr3mCDTNda109R0zPrO2Op?=
 =?us-ascii?Q?h/fzVFtAWQgnfLK99E9fMLmg9XAQvSpibf9djhraQrdZmmSrcftxaPyV+ht5?=
 =?us-ascii?Q?c3pBI5EofDxgvX5TpE+ZF4XJ/FXRzLKrkMsStt8+gNv8ZSRhHckOrMNjObor?=
 =?us-ascii?Q?5VmJvpx4pcwHV0j3zkPbawn1tMEtIv4FeupIcEM32xJnCcBMI2A7wNAw4ijY?=
 =?us-ascii?Q?ktwZtIY/As4XWyxfOb/eBEojxmOQaHbsacTvdifo3ZAJ52lvY8PYIKupD3pw?=
 =?us-ascii?Q?Zi3z/bd16gTWPX+yJP/dveY5kEl6oS4tlRjs0cUOE/qlrh8Av9cr6TC0vnm7?=
 =?us-ascii?Q?J+PS2w7vgasaFZRsRAPCN4nXUxueakns7qUMGl0zARyeRJOvOpR0HQPB4kEI?=
 =?us-ascii?Q?+FfZAW+wgt40EQwBHTWWsj+WmBZsD+Mja8XwiKk15hVDQmsxcx2Xjk2rfYF3?=
 =?us-ascii?Q?N6xy5YswiZw+G5BTnmlb5sDyZKtxWGV2tEaOZP6EIhmA1kTvhPPlSlQZwA7l?=
 =?us-ascii?Q?+0JfFXy/jFjlRU4KKh9h8NWNHAteayd7effl7cui+pkCtOHVR5HWP5xsKswL?=
 =?us-ascii?Q?PWVJBNvg4WPtLc/uWZ1RdYOLrF+fGHrwyn8yYeKSw9uf4FlrWLwDw0iY3Bd/?=
 =?us-ascii?Q?BwZvU+I6pURmZe06I/T3qUrySnUyNy0xXCOLFmP5JJiDtjq9rYdPFTT+gjes?=
 =?us-ascii?Q?XXnqi3hCcBmBdtrqh5rQAy6/f9rMAWg/WRwc4Pa/TLuH5lrTlUNQPh3bLQPM?=
 =?us-ascii?Q?Z+iuLLz1BFnHFulcmcYolifwNyyMxgKzIYyFaJC/Y2rVHSDXPrcNI0owZDjS?=
 =?us-ascii?Q?EFyMiGI7YMlJkNzF5z1Wr1aWHjUvW+BkHof3SET/b8X0Z1ewzu9q8Dtt3cPn?=
 =?us-ascii?Q?YEmZH5ZLD2iEv62CVSp52aBtoZeu8uKHvEUT/vmPPCGmZYIaoQ4g+ZNmHDhX?=
 =?us-ascii?Q?lQ/E8nkEuUQ/qq2MzY1x851JCC7YYGrBp+pRe5mjX0LeQ9J4LFJOw5cLJJZ/?=
 =?us-ascii?Q?tNGHQVkJ/voffTPnLsmo2uCh8Y5Y5JeWFVqsxt4lFAOPxhWraj8nnf50ADdo?=
 =?us-ascii?Q?aw26S+qqjA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5271.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a9b644c-67dd-49af-ab04-08de4cf90c08
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jan 2026 07:56:06.5227
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QDeNEoLAtIF1euevgcbctWpN6VAcJ/TUGy1ta3kpB7OkcmrJv50lJ4S6axotvS8eNliBhJd22284n9uWfHyoPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5832
X-OriginatorOrg: intel.com

> From: Liu, Yi L <yi.l.liu@intel.com>
> Sent: Tuesday, December 23, 2025 2:58 PM
>=20
> Besides the paging domains that use FS, SVM and Nested domains need to
> use piotlb invalidation descriptor as well.
>=20
> Fixes: b33125296b50 ("iommu/vt-d: Create unique domain ops for each
> stage")
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>

cc stable

> ---
> Change log:
> v2:
> - Use domain.type to filter nested and SVA type domain. This eliminates
>   the SVA domain ops reference issue when SVM is compiled out. (Kevin)
> - Add a intel_domain_use_piotlb() helper to cover the three cases which
>   need to flush piotlb. (Kevin)
>=20
> v1: https://lore.kernel.org/linux-iommu/20251208091907.74719-1-
> yi.l.liu@intel.com/
> ---
>  drivers/iommu/intel/cache.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/iommu/intel/cache.c b/drivers/iommu/intel/cache.c
> index 265e7290256b..385ae5cfb30d 100644
> --- a/drivers/iommu/intel/cache.c
> +++ b/drivers/iommu/intel/cache.c
> @@ -363,6 +363,13 @@ static void qi_batch_add_pasid_dev_iotlb(struct
> intel_iommu *iommu, u16 sid, u16
>  	qi_batch_increment_index(iommu, batch);
>  }
>=20
> +static bool intel_domain_use_piotlb(struct dmar_domain *domain)
> +{
> +	return domain->domain.type =3D=3D IOMMU_DOMAIN_SVA ||
> +			domain->domain.type =3D=3D IOMMU_DOMAIN_NESTED
> ||
> +			intel_domain_is_fs_paging(domain);

for readability:
	intel_domain_is_sva()
	intel_domain_is_nested()

otherwise,

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
