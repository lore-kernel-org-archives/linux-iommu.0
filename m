Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.19
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793258334;
	b=nh6JCXrxclymQ1kNiZ42vSGT5F+EZlialrwYfgQokBL7L40vJhqluQypSmwN8D+cF1vx
	 6euhYQDPF863b67hKKhboXbQ0w9Z/PaqbOVmdRGbMqmg4qoXPjaTZjD1gr/5oPOEj7eVn
	 +29/o2YGcTC4QnKI5ybyiAOQKQDHovZLb6A3mrI7WO8N5csNgsm762/UvK/7/04qxmPWi
	 796ps6UnSHPrsRjQdUysRNOHQpy45pOFtdDixM5MUZixyCmWSki1DZX0B9QlKfDbEheuJ
	 tvkUDJAUtfTiDOyQZdIdw8xZrcpm52kk/XCg42N58xvgmF/bPenB4EL/LvZEMyx0UZA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793258334;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:Received:Received:From:To:CC:Subject:Thread-Topic:
	 Thread-Index:Date:Message-ID:References:In-Reply-To:Accept-Language:
	 Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:x-ms-exchange-senderadcheck:
	 x-ms-exchange-antispam-relay:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:
	 X-Exchange-RoutingPolicyChecked:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
	bh=u9pTTakfb7J1il/l8Hn6ttgOnyn6BJkJzcfCTGM5UGE=;
	b=Tu9LxOA1uVN76p0xPQz76OezsVmDbRCOnjhV9fh2IeeEwgyKgES+IOS8KqhmQ9H9Kqw2
	 S+zbtW63fZwHcvNP6shyeRQDTuOTA6Wypq26sblYWui3LkKHMF5b70CzkXZ5wa0S18KWv
	 VD2C9VscCwez0duc83cbLE0c5dBT7WiHWiQXOWCKpOzMXdAJHpZR1aSbEg7NcDovcwvLD
	 ump6JltQHSj6t1pGhMXDAOvKDpEgCjNiTujL4Gr5MZeWNTXt2WqXlvoBIlt+ckCpxH5zM
	 HuCdiMd3BKQIoHC7n9De7d8cHe4wAsEBvgnPvBMDfBM7mXvyRNaSEcvoNxZKsL12+SA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="aJ5e/wfG";
	arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.19
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11D21606A321
	for <iommu@lists.linux.dev>; Thu, 29 Oct 2026 07:18:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 11D21606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=aJ5e/wfG
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793258333; x=1824794333;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=u9pTTakfb7J1il/l8Hn6ttgOnyn6BJkJzcfCTGM5UGE=;
  b=aJ5e/wfGfSGwfRKcuRdL7ihQDEd1Lefd5/e9vjSGje/CgFGelK88nTWE
   njlkjcZW85chRNwPQplXYYvEcjsEGaV0C/yw8zFZefuNZTR08a2fyyN6s
   CpxKdSccFKmA79ONGe0QVYOS3yjGwiIfJKuvT3h1BmFj1Dx1QsdB+RLYd
   DgV9xxAJyx4fSUUU9xuaeZXf5zfxpXGdqo+pv1HhedC7poghTqeqeOOpI
   OR3ACHIl0zmu//rODHWoDD4x+h1j7xBRnNUXICTaKHSCcbw8066dFYmPg
   +o+c/Q4TAm/KlCjn3S+J0mY0ohXiYaA8KsReB2Fx6cvizhOqQIIGh4NbN
   w==;
X-CSE-ConnectionGUID: OIH1ny6OQAGLjzD+uOZdwg==
X-CSE-MsgGUID: WVDdhcnvQTKY2fzj3VvvEA==
X-IronPort-AV: E=McAfee;i="6800,10657,11949"; a="2019360"
X-IronPort-AV: E=Sophos;i="6.27,184,1787036400"; 
   d="scan'208";a="2019360"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2026 00:18:50 -0700
X-CSE-ConnectionGUID: SxuJwDY0RyGyCaM1vlLHqQ==
X-CSE-MsgGUID: 6Cd8Gs/NQqSwNSCmZlWMMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,184,1787036400"; 
   d="scan'208";a="5399700"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2026 00:18:48 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 29 Oct 2026 00:18:45 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Thu, 29 Oct 2026 00:18:45 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.32) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 29 Oct 2026 00:18:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NDEjnGWvlMQX+Mc515VEhE3VuyVu9rd3xpGxaX1glR/YZ81cPqPb0e9RbNQR05XnM/jFW+fzERz2zJxq/96uYaUGFHrWgICFbqMBrrf4s9+ARaril7lQR6papq9xpjE6UnYJzWkf0775XNSrQQ10iUEwsqXBgW6XnZnZocFoymWfK94m1jpIHLpp9YQSWKA6Y5ibBHu4EFi+OLrtSAc0rezS2hN5WiqjUormFrqU62R59h8jGVqNor+Ed2l6Qf5IK7SMz9H4nbR2FpvEzd0855MrQXvxKLZK8BMMsJ/NBK8H934woU83TPOUHesxLGsGKlei9zkJnWJyWjQ/27B24g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u9pTTakfb7J1il/l8Hn6ttgOnyn6BJkJzcfCTGM5UGE=;
 b=RLTb1I11R0l1nc5N1c3MXnR+CGi0Pt6YDAI2KdJ/N1rkA5eEpWBhdC/lU9J9y9Gw73NLSJMDxXpySq69+twE4aU0kouciQrDYpB3LOsP8obzOk7ZSF3OahkRRdG88NOqp2uRIr1YqPNVbiehtsLIlCqmcDoDgx0q+GLHSRIyaf3SWvqsuqMdEnsO3/0wfx7tm8pUFy2vHBrq0yugem6vbkbpBVKrdSTL1DGe9PtehAR6wKt75cxjNkqJu6kJ5h0FzmnrQ/T3vmIwFZNUzkD9Lo/5KaXE922FFrkY+qLKacwy2mIiWwtoA6IhDnVfi5VBCb+ocZhB+NR28S1AyCDqKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO1PR11MB4835.namprd11.prod.outlook.com (2603:10b6:303:9e::22)
 by CO1PR11MB5203.namprd11.prod.outlook.com (2603:10b6:303:98::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.8; Thu, 29 Oct
 2026 07:18:43 +0000
Received: from CO1PR11MB4835.namprd11.prod.outlook.com
 ([fe80::d051:d948:c209:9225]) by CO1PR11MB4835.namprd11.prod.outlook.com
 ([fe80::d051:d948:c209:9225%6]) with mapi id 15.21.0569.008; Thu, 29 Oct 2026
 07:18:43 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Nicolin Chen <nicolinc@nvidia.com>, "joro@8bytes.org" <joro@8bytes.org>,
	Lu Baolu <baolu.lu@linux.intel.com>, Jason Gunthorpe <jgg@nvidia.com>
CC: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Jean-Philippe Brucker <jpb@kernel.org>, "Liu, Yi L" <yi.l.liu@intel.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v1 2/4] iommu: Unpublish the attach handle before the
 PASID detach callback
Thread-Topic: [PATCH v1 2/4] iommu: Unpublish the attach handle before the
 PASID detach callback
Thread-Index: AQHdUFzh6VCHj8TuIEyS59FDtDegGLcUSq0g
Date: Thu, 29 Oct 2026 07:18:43 +0000
Message-ID: <CO1PR11MB4835523A03FF2CA41033E88F8C6E2@CO1PR11MB4835.namprd11.prod.outlook.com>
References: <cover.1790718296.git.nicolinc@nvidia.com>
 <3d6731c5c3502380b4de3c90a1f6ba5547f0dd85.1790718296.git.nicolinc@nvidia.com>
In-Reply-To: <3d6731c5c3502380b4de3c90a1f6ba5547f0dd85.1790718296.git.nicolinc@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR11MB4835:EE_|CO1PR11MB5203:EE_
x-ms-office365-filtering-correlation-id: b6145b1e-79d3-4b84-9376-08df358cdd7e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|38070700021|261028144727099003|260925021311599003|260925021911599003|260925022911599003|56012099006|4143699003|11063799006|261009223027099003|261022105027099003|261026121527099003|261021135927099003|261026140227099003|10067099003|18002099003|22082099003;
x-microsoft-antispam-message-info: IzNX8OyzE4r9/EZ1UsPP3J/sjvyzfhPwY7eMRcOsYfo0ThNKEQ9/UgEjboytDlAavPAMPXTra1ecdyp6bfwCLvYXXbYkqmU+DYWpBXXYhxmP3bpP2eYfj1+iXfureZgjNn5Tm67ewC1n3zItnpcK73SaaET2hif+9NU5cMQP+lDjqCskvwHWZLmgH0aO0NhqI1tm+PpbMgIkRcEdkyuaOf3sVV/NiakPhHB4tPmnsO2VKrswGUSYe2vfXssTqEP8V7Yh5wVC141/NHJluwj0obBklCV7jOVWLn21LtYvAs1gNvljXDQdTRZ+lu8EhSd4018IflkxnMQFnB5xg8JXRTRFJRVk49prJ4klfX7k4+EeCUeBNR+qwPNBl5Xgh++2vMOzcwrygnJkwldREuj1swhx3EYaTIQalubpdgGotV5Fy/CTH2XUhxtGGSkou38G6Np4211QM/GVmJ+CIA8Uub5Cx1CLBNJEOlm8wPXurNbhvZu6LuiHQU9Ot0Bs8DTYJUcX+DIrXxIPlkuh1gAdFGOAJjniz1GurLwRVJf3lu8NF0jQFSXlGFlKnvJYUsSLbmW3RxdQ1/Wuzh9PE1BZB1XeeMYTMC/zU6kuQUISNrulzj/QPrCZKy9PZP9YGltHz1bO+DsFqnjhews03hjHIsVJzD0787cb4/Y+Q8NstNZYOyZCp6IH8GrJNI08qxH8tHNjMiDhbZEqxeIb8GiY9Ij+pp5EM3lKBoXYS6RauTg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4835.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(38070700021)(261028144727099003)(260925021311599003)(260925021911599003)(260925022911599003)(56012099006)(4143699003)(11063799006)(261009223027099003)(261022105027099003)(261026121527099003)(261021135927099003)(261026140227099003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?UhdiJAYNpNYV6kk3gbaVWpPDQyQaNXVVEheoB1xsSX37umZoqO/k1WitY4S9?=
 =?us-ascii?Q?vN6ldR76ZLht4ESXPpuHjW+4bS4ikjfjZ4Fpe6Tqh6rUr0Dj5+QdHQFLTgnt?=
 =?us-ascii?Q?GDLiHnyJDH1yQyfnbrsAJ1v4F/ptnjR7PsxA67IcJosEdsAtVcD0RxB1ITtD?=
 =?us-ascii?Q?4Wg/G2BHTwKGBTfMdOx7vcF27eiCOc/9UFg3ZUSzHt3I30u06miehhrc1gjD?=
 =?us-ascii?Q?amKAdV1LngbVMKP8+eUaVkEuY9IXaxxFz2D88ok1Xe1Dzz4nXwfDaAGWmSPo?=
 =?us-ascii?Q?H6DdLpAsXerVY+HBp/KhbLSEsa2OKxftSXGDlEf6tKVSt1e0HNeAu2+39bzX?=
 =?us-ascii?Q?85g9t81YEXCrft9/ouKdzwtuGlLFhmYBbvvRqhXwUMss7vMPE1c20qZbPzIr?=
 =?us-ascii?Q?6mDiXIjycNG7tSdtTc9IXmAxrel6vcNn68fu+cak/C/VmPERuzxIPtUe7j5A?=
 =?us-ascii?Q?RyQnEZQcphxu8U8b3hfma5+ybKrixQ91yi/1Kt8pAoQQ3WF3CNYX2Ipdp55A?=
 =?us-ascii?Q?C4pMm1vKKMrFTyJPjuHlivAzQlLPihGJCsoGCh3mY1UchuPqP+QKP0wFLsGs?=
 =?us-ascii?Q?T6j1xOP+nnQIMcQvAoLZg+PLCEYtM3vHPkP7mQ3y+PHvPsm/bD+veaTjHoVW?=
 =?us-ascii?Q?7cDGnjRFW9fwEUSLid9J696wngVaaLmf9B2iQuWl9TdT3v2y0axmMUhg6gzM?=
 =?us-ascii?Q?iCz8hJoXlYpPZTzSw2mNt7oE4fdRtC1v+bVg76NzFbOSPnLdlPMr5mL5+IQV?=
 =?us-ascii?Q?OT8Tfu0T7j1dEFu2pN11GSM2wpNOCsRcP6jXp2/zU7l8rgJMh+JjSl0DR2mO?=
 =?us-ascii?Q?eNZSHt3AaQej12Giw8pXRY3KbMZNgX7MNLPjaaUJx0AdiBnt+Y3cLMhI8P7w?=
 =?us-ascii?Q?D+Dnq1fiqyow6o+xnK9N0jqkDcBGiA1n9BxMzkO4TDvHffuOhpBpayqnMPL5?=
 =?us-ascii?Q?G5zCozPqgfiVBdjTcvhu76Xo+GwbZtgn/5OzLfhXw8tbnSSFEVFuIVeJIMWz?=
 =?us-ascii?Q?eSepyFA4yuGtSFN7/S0rS7gv5AZ3DqFo52LOzvBEngZ8MRV4nOZiPUplr6G8?=
 =?us-ascii?Q?Y/zhXtg8OZw5aAq4ZqB5SoZ4VCok8tyDtL+ygy/Rt0yaMi2avAjetnMeh4wX?=
 =?us-ascii?Q?jdA77OiKZJFbt11XJJbF3zAnzL/HlovFnc4bhaY52d8QiGTHL8FR25TPQ6k/?=
 =?us-ascii?Q?cI0PjVX5iiAP1IuxtejXm+jvG/O/Jpp6rF/NzetY9Db9V+voUbaVxRRoloKp?=
 =?us-ascii?Q?qC6/Vve/fiwE4rlcFyfDGj0Nt47lvrmIXhHBPC38KMwBOV2zj52B6fwxfJr5?=
 =?us-ascii?Q?9XEES1vlDyXnrS7c78DZ1cttU1K8/asSVcj+LThyOzriQB8ZHkJ9ti85xUT8?=
 =?us-ascii?Q?uDpqREO1lP+inq0IFsbx2rpNgK9EZHawIqbxEREASUR6TzMjHwuOdbb+y99l?=
 =?us-ascii?Q?/jHSNIwMtm9GcbcP8dw/gNUwGMiC6x0c/v5gUtc3R1+99jgzL3C+wahnjaXw?=
 =?us-ascii?Q?OoALarzBIpOJg7OBUod2qrDgAbDcYDYiE8jgJ/eolLOZ3VcRtUodir/Fi4GV?=
 =?us-ascii?Q?KHRvgWRX4fKzbIkZsgDLh0eK8XxV8tiRIE+V0xZn+m/F4HcAAB2qKwNkSfGl?=
 =?us-ascii?Q?WLEOviefCwDtMBsaP6Oijg/L0b8WUWxJKFefp7j0qMiulqU5AEdhnmgFglBn?=
 =?us-ascii?Q?Jv9Dc4+b/AvzfR16q/KcL1Mc3JwkBgZr0HiqBUOfzTwG70bo?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: t9LCn5MFJqfe4OvB3PNpDP2uCPVrNOwrukIe3q94tVCb3eK7M8dV+sEvOcDSisDhwRTFTeTA+qlg6uq6uQPY96WZgEePYslqPGxiCvtmla64ZERNqA1xKwnAvLxqDAKs1MQullHU2XdAODOGQVuW1tAjfU7JfA8JbwN0FH83bQJ6JlHqE1HJpOOToVh4lv1pm9ukK+aDxYtczUL2oQKe9vYFD87AyraKBtKw7IoSxoVwZAR0DypUI81ZK/nTCEFWJwgatGmiHTBfV98V1LWvPoGurdNMTxKJXlmCLCwk07AZAJAIZeklqPTBB9QS1Ul9R8wk+LmSS0U44yIr+7zoQw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4835.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6145b1e-79d3-4b84-9376-08df358cdd7e
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2026 07:18:43.6808
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JPM2GS86NbujSgI81ZONYGMCP/K5EJsT5PyVjbCG5jBixs48EDnriM5yxyQ/iCHG/tsHC3oQ19hMLPw7fRk71g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5203
X-OriginatorOrg: intel.com

> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Wednesday, September 30, 2026 5:52 AM
>=20
> iommu_detach_device_pasid() erases the group->pasid_array entry only once
> __iommu_remove_group_pasid() has returned, so the detaching handle stays
> visible to iommu_attach_handle_get() for the whole of that callback, and
> the caller frees it as soon as the detach returns.
>=20
> Erase the entry ahead of the callback, for the same reason the group path
> does: a fault raised in the meantime must not resolve to a domain that is
> on its way out.
>=20
> Fixes: 16603704559c ("iommu: Add attach/detach_dev_pasid iommu
> interfaces")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
