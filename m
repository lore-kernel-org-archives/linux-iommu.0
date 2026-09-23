Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4BDE41A56F
	for <iommu@lists.linux.dev>; Wed, 23 Sep 2026 22:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790202125; cv=fail; b=Z2UoIry7sQTwgjVwGRJ94plmo6PvlfnvUHTy8W1cN6ilDMzm7vc2ovaPce4C/hMVACopqcHI+sexz2T2jQ+5TcZxU0oIE/ALCu2XldvYnHxvieCsNdIese7ZyZwFA1Iph30s64ESd0EzEKKxwG4fIHlYIsbLCMin3CfoK9JQClg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790202125; c=relaxed/simple;
	bh=puaXnXCfyXWlCgcep7tQXYgxdngkRB+2MTQ827KE9vk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=eaJ7z8UuXzpza9Cm86PE0yvQkZRDOgPn1slaMCZM9ZrOhsKlHPo2J0geh8oGlbzfB3qE+WhVBf/h8QzTdzpUEFBgdv3W+nFNIKAAeGocCsX76mAnUX389IFT7O0hqNOhHsY1UWxk9REymSmDh63caDaoouHKlzWXnCDuFom9WfI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=erCg9NNB; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="erCg9NNB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790202123; x=1821738123;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=puaXnXCfyXWlCgcep7tQXYgxdngkRB+2MTQ827KE9vk=;
  b=erCg9NNBNdVgTd3bveZbqPn6qPu6Fcs16EeIypDEq3a0G375ncd9Y9fc
   ZGDaUrlIvj9fGfiPI4GifpUwVt89pnAM7zH028/awcsXk0Inel69M8ozt
   y3Ja9BQ3+fxMIfQFe2o1Z1FnV597hFEzUB9czHgiNzJBsHIZ9efG3DQcc
   ueQeFQdKxpMM5qFSxd8QcXWjtg1tGGTG4L4pwpaIpPCj9ri/tela4Gf5z
   wHy2FgpBcxDcMEWZMqZTnfe/DAu3VoaL3fxz2ZGF/nMls3WvAy7vXP94q
   5jk+sKqBQyKThZXhAO3eDPehBeBz/3y+qTmrQuYN7oWihDcOeC0vMI4Mb
   Q==;
X-CSE-ConnectionGUID: tGeOJlVLTmWJymiQyN5zgQ==
X-CSE-MsgGUID: Rh8wytwTSxaSh+y1svr+zg==
X-IronPort-AV: E=McAfee;i="6800,10657,11914"; a="94767309"
X-IronPort-AV: E=Sophos;i="6.27,119,1787036400"; 
   d="scan'208";a="94767309"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2026 15:22:02 -0700
X-CSE-ConnectionGUID: c+VsHGjsQBSDwvaaMOJxvg==
X-CSE-MsgGUID: vJ9SZPaiRPmo/eOgmn6kVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,119,1787036400"; 
   d="scan'208";a="300064151"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2026 15:22:02 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 23 Sep 2026 15:22:01 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Wed, 23 Sep 2026 15:22:01 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.44) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 23 Sep 2026 15:21:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p+zE8k2UehKwOtnie4KzW4lyDmQKv381nGoVu72cBgtD0Fel2ItkgEM/C5f2V7SMJLTzjeNQNLJ1XZ+0oMkFJzFP4GQ4A5pXytE4SoAnJ+RAHClwJA0cI2G/xvxcfZkYBJlPhHQ3NsL9Vn7wKyP5V3VZXC2OCs/ekAOKkqXoSfBWIgonEUr0yUmKRJk2YpYXzum43drxm+ATSpYQ343pGPBGLL2qfURngXmC3JsWbcuEYMlGl8uxM7ocFFSq3s8OMRGJ5PEfu/e/eddX/dA1NDQrNc2r7UOIHlzALHjrNtzGIEHxEX1MolthSUmPyOUY4QFSuPPtBoXqso/I3l3GSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aRCJcUisQUitso4WUQ9ASP2mwJETlqspxYCI7oapZzg=;
 b=f3445koRIPLEUy9TSx2N7+6V4jGIEb3JDJF/RofsJvi1Cp7omGdxgO85HMK39OtBU61msLNCQoAJxNvgxMMvr0jfM5bBNhrwY5Q3xFnKTg3E4tpDVDNZw7Spfci7MIAF0cAS+RmdU1aC9Zaw7jRdPpzOvf/877LVqZ6plkqRFPr5MPLmhb2k0f1RvWC6QvicAxv6qRGZ2YTDwlwE/RFK3Z57up9/w0YVl7dzSt9ykyDWGwbxRD4RPMXIgUEryQvbOo8iM8p7oRziOozEpgMjptV41sXFshZnNFRQxRpGNRVzTzSe4SZzqtXWEtZeQXf63eVdCeRAkx2twGVZvhfgNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH8PR11MB6878.namprd11.prod.outlook.com (2603:10b6:510:22a::7)
 by CH3PR11MB8465.namprd11.prod.outlook.com (2603:10b6:610:1bc::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.17; Wed, 23 Sep
 2026 22:21:50 +0000
Received: from PH8PR11MB6878.namprd11.prod.outlook.com
 ([fe80::1b78:2633:3b3:e4ca]) by PH8PR11MB6878.namprd11.prod.outlook.com
 ([fe80::1b78:2633:3b3:e4ca%4]) with mapi id 15.21.0451.014; Wed, 23 Sep 2026
 22:21:50 +0000
From: "Sun, Ning" <ning.sun@intel.com>
To: "michal.camacho.romero@linux.intel.com"
	<michal.camacho.romero@linux.intel.com>
CC: Baolu Lu <baolu.lu@linux.intel.com>, Thomas Gleixner <tglx@kernel.org>,
	"Camacho Romero, Michal" <michal.camacho.romero@intel.com>, "x86@kernel.org"
	<x86@kernel.org>, "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"tboot-devel@lists.sourceforge.net" <tboot-devel@lists.sourceforge.net>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Mowka,
 Mateusz" <mateusz.mowka@intel.com>, "Pawlicki, AdamX"
	<adamx.pawlicki@intel.com>, "Randzio, Pawel" <pawel.randzio@intel.com>
Subject: RE: [PATCH v4 1/2] x86/tboot: Add support for parsing DTPR table and
 disabling TPRs
Thread-Topic: [PATCH v4 1/2] x86/tboot: Add support for parsing DTPR table and
 disabling TPRs
Thread-Index: AQHdSnlPE0uKOsloZEK+B5xwfgKEarbcvWmg
Date: Wed, 23 Sep 2026 22:21:49 +0000
Message-ID: <PH8PR11MB6878606C78E0D2096C8DAEAD87822@PH8PR11MB6878.namprd11.prod.outlook.com>
References: <20260917094333.765643-1-michal.camacho.romero@linux.intel.com>
 <20260922100048.908468-1-michal.camacho.romero@linux.intel.com>
In-Reply-To: <20260922100048.908468-1-michal.camacho.romero@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH8PR11MB6878:EE_|CH3PR11MB8465:EE_
x-ms-office365-filtering-correlation-id: 4eac1a26-f72d-4410-2360-08df19c1103b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|23010399003|10067099003|11063799006|4143699003|6133799003|56012099006|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: y30O25C4rPYEzLeNDOg55cQlBQ8LWfLZoc94y0l+nvK/qSJxHGtPfYgFcRLVqupi8ke0hrB9/JU/dyxuOfEfdb6iVGR1kSkslOyENCMZqpIiuOqiuXVEg4o4kmjnwUiKhrg0XY9x3o7Rc0doNgZ+eQxKQIf8F/BTXJAvtrSfYFnCpSlFhaUgtw75LJwjbbPv6cMyNH/Y54pxjkpb1urJGOzyg/eMNDYVb1Cjif7hzfbBT8HgdfHdbBGl7nhAcJHW9ZfjP+zk29H/HQ92Sf5vcv+fNOPHCBsVUjy3Tt1k8RxWBYSVyDirtWoj5Qm5+e5/8xAhYXRbxt0XgOTYoxQk49qVn7V72asJZi0V1KU6PJ1qNCXeBVYEnjfRi+o9gPIEbEN/9QWh9i6mdzWeNRBtBE2Ge0pInl5650UdMDvK6c+dq1NW2Vw3my5jQaXT+NRvQrr3w8Ysjy2GuToQbe7ZCu9xX7XSx73G/Q5hXyjGqTpkfWtijvoZnekUrwGFNU+Ef1bU13CmznB6HUU8E69K73yQn2s+owvlEJ2kEfx2sF9aLWsczpt8bojoAVi/qKxmJX+QqgnOSPqGQYd7n75x5JEyYwhk3AyHpuPP9hrIHfGNevsLyvp9lzYnnbw6hyQDegsG+C51aUh/NFyW+11eXVWYe7/KFu0loAm2fdcNYXc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB6878.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(10067099003)(11063799006)(4143699003)(6133799003)(56012099006)(18002099003)(22082099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?CnpiU6jQqw5FX17DMpC4KhnV03ZIhYtW08J1gObeiGQ8XrzG1xiBWXlPSBkB?=
 =?us-ascii?Q?dilVa72eGXf45yqbPa+ZojdUHe9ELWthYkTyDO+tarU/gA1dJnkdRW7IgHlJ?=
 =?us-ascii?Q?Xr0+f0x2l7pNvlV3jk7+Nurk1YmJAGdw1zf9lt3GXoQ5tANerDg3TqcosqOL?=
 =?us-ascii?Q?2mrmIRf3RSAYH4FAC/Ut/QCr7NkkQ9evxmnMwdwN1DWjtmvjRaV6f0KK3qMV?=
 =?us-ascii?Q?8/oDFyL3raTZaFIIFQ3ZojcfiPGH5NR3kLwcOeF9wUl7mPcYNG356zCrLkOJ?=
 =?us-ascii?Q?Rk4VOPchRYvCe0ClaD7YbG+UY0jZcFRRi9CqhL3nENVR5QVbVy1Kd6U1LAo3?=
 =?us-ascii?Q?MYHUCGxf4cenE+XyeOw1zC5q/75aLcSueY1BWIoO20Jg+hekGGPIgzM6RzBh?=
 =?us-ascii?Q?DUZFr2L+zw+Gq2WxVdKMzYnxerJRUmij3H/GInuCK9MGxMWJGhM9Cj4JR5w/?=
 =?us-ascii?Q?oMxVIFKnCMZqj+9L1mF7c60bOOrG2Nqj9l1LSHNQNL28+WOHvxWkMLEDhXPW?=
 =?us-ascii?Q?fLqDC7xbIUyq60uA/xJYyh+9WFF392RVkZYaNDwgZhvik+Gc+ADULaMNHqN1?=
 =?us-ascii?Q?Ja9vhoF2MKKJuBM/flxPcPf9X1TgnggoY3rZDxvtAkqPr//FusgmHwGkn7ty?=
 =?us-ascii?Q?FwhVU9sJZm4uc3Rh3M/Boc+sgEH+RLlF4ceKKXIW7o0qrbcM17TfGtyAkKsO?=
 =?us-ascii?Q?0S4dM/mhv+CHbksC1vXrOP7HNrkhH7wYbfak7ZoAN7GxtencdflhelNvZ/eh?=
 =?us-ascii?Q?GU06Bw98y5xMrqnzOdoQf3xoPFIwYa9tsZL5dvGYK3KaEWw3/vVeNsmCGlti?=
 =?us-ascii?Q?HAP0OpGHqK8gRrvK9pijUNBLh6oNihyIOGHQqQq8PkVXOWC6CFDh63pdyEPH?=
 =?us-ascii?Q?zM/gnM/mAZPCY1BsLjJ+XwqtgZAELR4acMCoIera8IvqAOVYYT2Sy0TZVyMn?=
 =?us-ascii?Q?U2VN8QrhzhzTKLlAkO8c2SZCbybciMESpneBwZ6GXQ6WM74e0WXKfmU/5isO?=
 =?us-ascii?Q?wb0ytZaVVbse3saVvZc0WMPTzjmGnNy6/7MvBWh+Cy6aNXM3Sa6M9r6NtyD/?=
 =?us-ascii?Q?WyigH4NubV4EibueMg6JWo0ElK2Q+Smeyz9OAhumeCm8bfD7WeU8bt5YLTSz?=
 =?us-ascii?Q?7ksN3Y1C51TUlNEh8FXF//5yzx+pBioaYoAxlcwX+7o2Lv9Qu4mCz0e1PsZu?=
 =?us-ascii?Q?hUILAcuZb6q45z38xAQBykUWhTvQ+YbAZCcrzr6GzXyguCmjvfuUugAcjmiW?=
 =?us-ascii?Q?ZJvvtvNyIn6cPt9MpYgAc9oueBMWH25Ehqnfh/Gzgtg2jlHurqB0g2uyeQSU?=
 =?us-ascii?Q?266Oiw3Dg57ajkAEOBv7zngx62Mti04WLbFhW2FPV5sy/ZIORBa++J4L2gci?=
 =?us-ascii?Q?HG1cPjImNu0VwqHmQReVEr1u3PJCQq2T45x+B67EBav8u/IK+0J4683q7plU?=
 =?us-ascii?Q?3FEC7Gr4nYZA0TEXFElpSrKytJ9NM/zaPo6UvrbUGfE00J3bGV2n7PpQvtVW?=
 =?us-ascii?Q?a8I8bKveb8XhcJ9TD4zDReD1Y44e/Vg+EH3kFwZwhJQZft6dHI9hcJiKA7r0?=
 =?us-ascii?Q?vh3s3n3zNgXpRGficUZ/9EYwbOJBteRYu2HWt7d78Hhc7Vb20Dsz3Z3G7Uc8?=
 =?us-ascii?Q?kolnDl3P0gWdnogNCEvuJyq+ZEOC5fM2REnI51qLu+ePsy6h2cmQVUXm2WVN?=
 =?us-ascii?Q?Tc0CCC52irlu73k3IfN8SdCkJua9ChIhPylKiTpy39RtQH2T?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 1vE9o4mMHVQDiUU4C456xKhdgPRX/pQC8jv2EHV6KZx3vTgzCCgFvVqckrLmST0q7XpJkfJF3KtRgnKsMd7qydMExcvTNiN3b8PuJSFG01sl+QsHdsKkuVhOqt7Fknon5NrkL2yiPniR2kCWqGcr5sN7+YMFzC7kLAdxvyAvm1O/wWT6/Qb+9dAlBgVrQFvX0NxLAk3Om+p5VejSwHba8cAZ10X6CaYccrIlOkDZkEwUg0OItH5sxhWx5lOUdi+aC816RKpw1F+HS2Ta0UW30i7HlPRLTpCkqONDWTr1w7yXAgYbRBqzKgyeH1j17RLQ5Npsup5u/eYKmbh2JvFLkg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6878.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4eac1a26-f72d-4410-2360-08df19c1103b
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Sep 2026 22:21:50.1023
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 93J83FhbVgknEsQsOFWKvSH/hCnAiCdBPPLmbcewDHfpTVavna2AoJLq+HS+5jGKfo79sQUU+7loGP8YWaXW7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8465
X-OriginatorOrg: intel.com

Hi Michal,

Thanks for posting v4. This version is clearly stronger from a parser-harde=
ning perspective.=20

The added TXT heap boundary checks, SinitMleData version gating, extended e=
lement validation, and DTPR size/layout checks are all good improvements an=
d make the overall flow much easier to review. =20

I think the following issues should be addressed in the next revision:

1. Please address the trust model for tpr_arr->base before issuing MMIO acc=
esses.
In tboot_parse_dtpr_table(), tpr_arr->base is taken from the parsed DTPR co=
ntents, passed to ioremap(), and then written via writeq(). The patch does =
a good job validating the structure of the table, but I do not see semantic=
 validation that the target address is actually within the valid TPR MMIO r=
egister range. As written, the code is trusting parsed firmware/TXT metadat=
a to select the MMIO write target. If that trust assumption is intentional,=
 I think it should be justified explicitly in the changelog/comments. Other=
wise, I think the code should validate tpr_arr->base against the architectu=
rally valid TPR MMIO aperture before mapping and writing it. =20

2. Please tighten the parser structure around the instance/SRL handling.
In tboot_check_dtpr_size(), the combination of dtpr_offset updates, tpr_ins=
t pointer advancement, and the transition into SRL parsing is fairly subtle=
 and hard to audit. The code computes the next instance pointer even on the=
 final iteration, and the SRL count handling is mixed into that same offset=
-driven flow. The later checks help, but I think this path should be rework=
ed so the parser first proves the current instance header is in bounds, the=
n validates tpr_cnt, then validates the TPR array, and only after that adva=
nces to the next structure. Likewise, the SRL count field should be proven =
in bounds before it is used to size the remaining SRL payload. I think rest=
ructuring this would make the parser much easier to verify and less fragile=
. =20
A couple of follow-up robustness/readability points:

3. Please tighten the DTPR payload-size handling.
The call into tboot_check_dtpr_size() uses elt->size - sizeof(*elt) as the =
payload length. The earlier elt->size < sizeof(*elt) check prevents the obv=
ious bad cases, but I think the code should make the payload contract more =
explicit and ensure the DTPR element really contains a valid payload before=
 passing the derived size downstream. =20

4. The extended-element walk depends entirely on elt->size for forward prog=
ress.
The existing elt->size < sizeof(*elt) check does cover the zero-size case, =
so I am not saying there is a direct infinite-loop bug here as written. But=
 the forward-progress guarantee is fairly implicit and depends on the curre=
nt ordering of the checks. I think this should either be documented more ex=
plicitly or structured in a way that makes the guarantee obvious to future =
readers. =20

Overall though, this is good progress in v4, and I think with the items abo=
ve addressed the patch will be in much better shape.

Thanks,
Ning


> -----Original Message-----
> From: michal.camacho.romero@linux.intel.com <michal.camacho.romero@linux.=
intel.com>
> Sent: Tuesday, September 22, 2026 3:01 AM
> To: Sun, Ning <ning.sun@intel.com>
> Cc: Baolu Lu <baolu.lu@linux.intel.com>; Thomas Gleixner <tglx@kernel.org=
>; Camacho Romero, Michal
> <michal.camacho.romero@intel.com>; x86@kernel.org; iommu@lists.linux.dev;=
 tboot-devel@lists.sourceforge.net; linux-
> kernel@vger.kernel.org; Mowka, Mateusz <mateusz.mowka@intel.com>; Pawlick=
i, AdamX <adamx.pawlicki@intel.com>; Randzio,
> Pawel <pawel.randzio@intel.com>
> Subject: [PATCH v4 1/2] x86/tboot: Add support for parsing DTPR table and=
 disabling TPRs
>=20
> From: Michal Camacho Romero <michal.camacho.romero@intel.com>
>=20
> Add functions to locate and parse the DMA TXT Protection Ranges (DTPR) ta=
ble from the TXT heap's SinitMleData extended data
> elements (requires SINIT MLE version >=3D 9).
>=20
> * tboot_get_dtpr_table() - function walks through the TXT heap to find
>                            the DTPR extended data element
>                            (type HEAP_EXTDATA_TYPE_DTPR) and returns
>                            pointer to the DTPR table.
>=20
> * tboot_parse_dtpr_table() - function iterates over TPR instances and
>                              disables each TPR region by setting bit 4
>                              in the TPRn_BASE register via MMIO.
>=20
> Using these functions will allow the kernel to deactivate SINIT ACM-estab=
lished TPRs prior to the Linux OS launch.
>=20
> Link: https://uefi.org/sites/default/files/resources/633933_Intel_TXT_DMA=
_Protection_Ranges_rev_0p73.pdf
> Link: https://cdrdv2-public.intel.com/315168/315168_TXT_MLE_DG_rev_017_7.=
pdf
> Signed-off-by: Michal Camacho Romero <michal.camacho.romero@intel.com>
> ---
>  arch/x86/kernel/tboot.c | 352 ++++++++++++++++++++++++++++++++++++++--
>  include/linux/tboot.h   |  19 +++
>  2 files changed, 356 insertions(+), 15 deletions(-)
>=20
> diff --git a/arch/x86/kernel/tboot.c b/arch/x86/kernel/tboot.c index 46b8=
f1f16676..1cd4a198755c 100644
> --- a/arch/x86/kernel/tboot.c
> +++ b/arch/x86/kernel/tboot.c
> @@ -18,6 +18,7 @@
>  #include <linux/mm.h>
>  #include <linux/tboot.h>
>  #include <linux/debugfs.h>
> +#include <acpi/actbl1.h>
>=20
>  #include <asm/realmode.h>
>  #include <asm/processor.h>
> @@ -223,6 +224,132 @@ static int tboot_setup_sleep(void)
>=20
>  #endif
>=20
> +static bool tboot_check_txt_heap_section_bounds(const u64 heap_end,
> +                                                void **heap_base,
> +                                                void *heap_section,
> +                                                const u64 heap_section_s=
ize,
> +                                                const char
> +*section_name) {
> +	if (heap_section_size < 8)
> +	{
> +		pr_err("%s size is too small\n", section_name);
> +		iounmap(*heap_base);
> +		*heap_base =3D NULL;
> +		return false;
> +	}
> +
> +	if ((u64)heap_section + heap_section_size > heap_end) {
> +		pr_err("%s exceeds heap boundary\n", section_name);
> +		iounmap(*heap_base);
> +		*heap_base =3D NULL;
> +		return false;
> +	}
> +
> +	return true;
> +}
> +
> +static bool tboot_check_dtpr_size(const struct acpi_table_dtpr *dtpr,
> +                                  const u64 dtpr_payload_size) {
> +	u64 dtpr_offset, dtpr_ref_size;
> +	u32 i, ref_tpr_cnt;
> +
> +	struct acpi_tpr_instance *tpr_inst    =3D NULL;
> +	struct acpi_tpr_aux_sr   *tpr_aux_srl =3D NULL;
> +
> +	if (!dtpr)
> +		return false;
> +
> +	if (dtpr_payload_size < sizeof(struct acpi_table_dtpr)) {
> +		pr_err("DTPR element payload too small for a DTPR header\n");
> +		return false;
> +	}
> +
> +	dtpr_ref_size =3D dtpr->header.length;
> +	dtpr_offset   =3D 0;
> +
> +	if (dtpr_ref_size < sizeof(struct acpi_table_dtpr)) {
> +		pr_err("DTPR table header exceeds expected size\n");
> +		return false;
> +	}
> +
> +	dtpr_offset +=3D sizeof(struct acpi_table_dtpr);
> +	tpr_inst =3D (struct acpi_tpr_instance *)((u8 *)dtpr + dtpr_offset);
> +	if (dtpr_offset + sizeof(struct acpi_tpr_instance) > dtpr_ref_size) {
> +		pr_err("TPR instance No.0 header exceeds DTPR table size\n");
> +		return false;
> +	}
> +
> +	ref_tpr_cnt =3D tpr_inst->tpr_cnt;
> +	if (ref_tpr_cnt < 2) {
> +		pr_err("Reference TPR count is less than 2, further DTPR processing "
> +		       "interrupted.\n");
> +		return false;
> +	}
> +
> +	for (i =3D 0; i < dtpr->ins_cnt; i++) {
> +		/* iterate over each TPR instance */
> +		dtpr_offset +=3D sizeof(struct acpi_tpr_instance);
> +		if (dtpr_offset > dtpr_ref_size && i !=3D 0) {
> +			pr_err("TPR instance No.%d header exceeds DTPR table size\n", i);
> +			return false;
> +		}
> +
> +		/* verify TPR count for the given Instance. It should be 2 at least*/
> +		if (tpr_inst->tpr_cnt < 2 && i !=3D 0) {
> +			pr_err("TPR Instance %d has less than 2 TPRs, further DTPR "
> +			       "processing interrupted.\n", i);
> +			return false;
> +		}
> +
> +		/* compare TPR count for the given Instance with the expected one */
> +		/* each TPR Instance should have the equal number of TPRs */
> +		if (tpr_inst->tpr_cnt !=3D ref_tpr_cnt && i !=3D 0) {
> +			pr_err("TPR Instance %d has inconsistent TPR count: expected %d,"
> +			       " found %d\n", i, ref_tpr_cnt, tpr_inst->tpr_cnt);
> +			return false;
> +		}
> +
> +		/* verify TPR array size for this instance */
> +		dtpr_offset +=3D tpr_inst->tpr_cnt * sizeof(struct acpi_tpr_array);
> +		if (dtpr_offset > dtpr_ref_size) {
> +			pr_err("TPR instance No.%d TPR entries exceed DTPR table size\n",
> +			       i);
> +			return false;
> +		}
> +
> +		/* move to the next TPR instance */
> +		tpr_inst =3D (struct acpi_tpr_instance *)((u8 *)dtpr + dtpr_offset);
> +	}
> +
> +	tpr_aux_srl =3D (struct acpi_tpr_aux_sr *)((u8 *)dtpr + dtpr_offset);
> +	dtpr_offset +=3D sizeof(u32);
> +
> +	if (dtpr_offset > dtpr_ref_size) {
> +		pr_err("TPR SRL count field exceeds DTPR table size\n");
> +		return false;
> +	}
> +
> +	dtpr_offset +=3D tpr_aux_srl->srl_cnt *
> +	               sizeof(struct acpi_tpr_serialize_request);
> +	if (dtpr_offset > dtpr_ref_size) {
> +		pr_err("TPR SRL entries exceed DTPR table size\n");
> +		return false;
> +	}
> +
> +	if (dtpr_offset < dtpr_ref_size) {
> +		pr_err("DTPR table is smaller than expected\n");
> +		return false;
> +	}
> +
> +	if (dtpr_offset !=3D dtpr_payload_size) {
> +		pr_err("DTPR table size mismatch\n");
> +		return false;
> +	}
> +
> +	return true;
> +}
> +
>  void tboot_shutdown(u32 shutdown_type)
>  {
>  	void (*shutdown)(void);
> @@ -454,21 +581,23 @@ struct sha1_hash {  };
>=20
>  struct sinit_mle_data {
> -	u32               version;             /* currently 6 */
> -	struct sha1_hash  bios_acm_id;
> -	u32               edx_senter_flags;
> -	u64               mseg_valid;
> -	struct sha1_hash  sinit_hash;
> -	struct sha1_hash  mle_hash;
> -	struct sha1_hash  stm_hash;
> -	struct sha1_hash  lcp_policy_hash;
> -	u32               lcp_policy_control;
> -	u32               rlp_wakeup_addr;
> -	u32               reserved;
> -	u32               num_mdrs;
> -	u32               mdrs_off;
> -	u32               num_vtd_dmars;
> -	u32               vtd_dmars_off;
> +	u32                      version;             /* currently 9 */
> +	struct sha1_hash         bios_acm_id;
> +	u32                      edx_senter_flags;
> +	u64                      mseg_valid;
> +	struct sha1_hash         sinit_hash;
> +	struct sha1_hash         mle_hash;
> +	struct sha1_hash         stm_hash;
> +	struct sha1_hash         lcp_policy_hash;
> +	u32                      lcp_policy_control;
> +	u32                      rlp_wakeup_addr;
> +	u32                      reserved;
> +	u32                      num_mdrs;
> +	u32                      mdrs_off;
> +	u32                      num_vtd_dmars;
> +	u32                      vtd_dmars_off;
> +	u32                      proc_scrtm_status; /* version 8 or later only*=
/
> +	struct heap_ext_data_elt ext_data_elts[];
>  } __packed;
>=20
>  struct acpi_table_header *tboot_get_dmar_table(struct acpi_table_header =
*dmar_tbl) @@ -514,3 +643,196 @@ struct
> acpi_table_header *tboot_get_dmar_table(struct acpi_table_header *dmar_tb
>=20
>  	return dmar_tbl;
>  }
> +
> +struct acpi_table_dtpr *tboot_get_dtpr_table(void **heap_base) {
> +	void *heap_ptr, *config, *sinit_mle_end;
> +	struct sinit_mle_data *sinit_mle;
> +	struct heap_ext_data_elt *elt;
> +	u64 heap_end, heap_size, sinit_mle_size, heap_section_size;
> +
> +	if (!heap_base)
> +		return NULL;
> +
> +	if (!tboot_enabled())
> +		return NULL;
> +	/*
> +	 * ACPI tables may not be DMA protected by tboot, so use DMAR copy
> +	 * SINIT saved in SinitMleData in TXT heap (which is DMA protected)
> +	 */
> +
> +	/* map config space in order to get heap addr */
> +	config =3D ioremap(TXT_PUB_CONFIG_REGS_BASE, NR_TXT_CONFIG_PAGES *
> +			 PAGE_SIZE);
> +	if (!config)
> +		return NULL;
> +
> +	/* now map TXT heap */
> +	*heap_base =3D ioremap(*(u64 *)(config + TXTCR_HEAP_BASE),
> +			    *(u64 *)(config + TXTCR_HEAP_SIZE));
> +	heap_size =3D *(u64 *)(config + TXTCR_HEAP_SIZE);
> +	heap_end =3D (u64)*heap_base + heap_size;
> +	iounmap(config);
> +
> +	if (!(*heap_base))
> +		return NULL;
> +
> +	/* walk heap to SinitMleData */
> +	/* skip BiosData */
> +	/* get BiosData section size */
> +	heap_section_size =3D *(u64 *) (*heap_base);
> +	if (!tboot_check_txt_heap_section_bounds(heap_end, heap_base, *heap_bas=
e,
> +	                                         heap_section_size, "BiosData")=
) {
> +		return NULL;
> +	}
> +
> +	/* skip OsMleData */
> +	heap_ptr =3D *heap_base + heap_section_size;
> +	/* get OsMleData section size */
> +	heap_section_size =3D *(u64 *)heap_ptr;
> +	if (!tboot_check_txt_heap_section_bounds(heap_end, heap_base, heap_ptr,
> +	                                         heap_section_size, "OsMleData"=
)) {
> +		return NULL;
> +	}
> +
> +	/* skip OsSinitData */
> +	heap_ptr +=3D heap_section_size;
> +	/* get OsSinitData section size */
> +	heap_section_size =3D *(u64 *)heap_ptr;
> +	if (!tboot_check_txt_heap_section_bounds(heap_end, heap_base, heap_ptr,
> +	                                         heap_section_size, "OsSinitDat=
a")) {
> +		return NULL;
> +	}
> +
> +	/* jump to the SinitMleData */
> +	heap_ptr +=3D heap_section_size;
> +	/* now points to SinitMleDataSize; set to SinitMleData */
> +	sinit_mle_size =3D *(u64 *)heap_ptr;
> +	if(!tboot_check_txt_heap_section_bounds(heap_end, heap_base, heap_ptr,
> +	                                        sinit_mle_size, "SinitMleData")=
) {
> +		return NULL;
> +	}
> +
> +	heap_ptr +=3D sizeof(u64);
> +	sinit_mle =3D (struct sinit_mle_data *)heap_ptr;
> +	sinit_mle_end =3D (void *)sinit_mle + sinit_mle_size;
> +	if (sizeof(struct sinit_mle_data) > sinit_mle_size) {
> +		pr_err("SinitMleData size is smaller than expected.\n");
> +		goto err;
> +	}
> +
> +	if (sinit_mle->version < 9) {
> +		pr_err("Unsupported SinitMleData version: %u\n", sinit_mle->version);
> +		goto err;
> +	}
> +
> +	heap_ptr +=3D sizeof(struct sinit_mle_data);
> +	if (heap_ptr > sinit_mle_end) {
> +		pr_err("SinitMleData header out of bounds.\n");
> +		goto err;
> +	}
> +
> +	elt =3D sinit_mle->ext_data_elts;
> +	do {
> +		if ((u8 *)elt + sizeof(*elt) > (u8 *)sinit_mle_end) {
> +			pr_err("SinitMleData element header out of bounds.\n");
> +			goto err;
> +		}
> +
> +		if (elt->size < sizeof(*elt)) {
> +			pr_err("Invalid SinitMleData element size: %u\n", elt->size);
> +			goto err;
> +		}
> +
> +		if (elt->type =3D=3D HEAP_EXTDATA_TYPE_END || elt->type =3D=3D HEAP_EX=
TDATA_TYPE_DTPR) {
> +			break;
> +		}
> +
> +		elt =3D (void *)elt + elt->size;
> +	} while ((void *)elt <=3D sinit_mle_end);
> +
> +	if ((void *)elt >=3D sinit_mle_end){
> +		pr_err("Reached the end of SinitMleData without finding DTPR nor END"
> +		       " element.\n");
> +		goto err;
> +	}
> +
> +	if (elt->type =3D=3D HEAP_EXTDATA_TYPE_END) {
> +		pr_err("DTPR element not found in SinitMleData\n");
> +		iounmap(*heap_base);
> +		*heap_base =3D NULL;
> +		return NULL;
> +	}
> +
> +	if ((u8 *)elt + elt->size > (u8 *)sinit_mle_end) {
> +		pr_err("DTPR Table exceeds SinitMleData bounds.\n");
> +		goto err;
> +	}
> +
> +	if (!tboot_check_dtpr_size((struct acpi_table_dtpr *)elt->data,
> +	                           elt->size - sizeof(*elt))) {
> +		pr_err("Invalid DTPR Table size.\n");
> +		goto err;
> +	}
> +
> +	return (struct acpi_table_dtpr *)elt->data;
> +
> +err:
> +	iounmap(*heap_base);
> +	*heap_base =3D NULL;
> +	return NULL;
> +}
> +
> +static bool tboot_tpr_enabled =3D false;
> +void tboot_parse_dtpr_table(struct acpi_table_dtpr *dtpr) {
> +	struct acpi_tpr_instance *tpr_inst;
> +	struct acpi_tpr_array    *tpr_arr;
> +	u32 *instance_cnt;
> +	u64 *base;
> +	u32 i, j;
> +	u32 ref_tpr_cnt;
> +
> +	if (dtpr =3D=3D NULL)
> +		return;
> +
> +	if (!tboot_enabled())
> +		return;
> +
> +	instance_cnt =3D (u32*)(&dtpr->ins_cnt);
> +	tpr_inst =3D (struct acpi_tpr_instance *)(instance_cnt + 1);
> +	ref_tpr_cnt =3D tpr_inst->tpr_cnt;
> +
> +	for (i =3D 0; i < *instance_cnt; ++i) {
> +		for (j =3D 0; j < tpr_inst->tpr_cnt; ++j) {
> +			tpr_arr =3D  (struct acpi_tpr_array*)((u8*) tpr_inst +
> +			            sizeof(struct acpi_tpr_instance) +
> +			            j * sizeof(struct acpi_tpr_array));
> +
> +			base =3D ioremap(tpr_arr->base, 16);
> +			if (!base) {
> +				pr_warn("TPR Instance %d, TPR No.%d disabling failure.\n",
> +				        i, j);
> +				continue;
> +			}
> +
> +			pr_info("TPR instance %d, TPR %d:base %llx limit %llx\n", i, j,
> +			        readq(base), readq(base + 1));
> +			writeq(readq(base) | BIT(4), base);
> +			if (tboot_tpr_enabled =3D=3D false)
> +				tboot_tpr_enabled =3D true;
> +			iounmap(base);
> +		}
> +
> +		tpr_inst =3D (struct acpi_tpr_instance *)((u8*)tpr_inst +
> +		            sizeof(*tpr_inst) + j * sizeof(struct acpi_tpr_array));
> +	}
> +
> +	if (tboot_tpr_enabled)
> +		pr_debug("TPR protection detected, PMR will be disabled\n"); }
> +
> +bool tboot_is_tpr_enabled(void)
> +{
> +	return tboot_tpr_enabled;
> +}
> diff --git a/include/linux/tboot.h b/include/linux/tboot.h index d2279160=
ef39..aad3e8c70ab3 100644
> --- a/include/linux/tboot.h
> +++ b/include/linux/tboot.h
> @@ -24,6 +24,10 @@ enum {
>  #include <linux/acpi.h>
>  /* used to communicate between tboot and the launched kernel */
>=20
> +/*TXT Extended Data Element Types*/
> +#define HEAP_EXTDATA_TYPE_END   0
> +#define HEAP_EXTDATA_TYPE_DTPR 14
> +
>  #define TB_KEY_SIZE             64   /* 512 bits */
>=20
>  #define MAX_TB_MAC_REGIONS      32
> @@ -58,6 +62,15 @@ struct tboot_acpi_sleep_info {
>  	u64 kernel_s3_resume_vector;
>  } __packed;
>=20
> +/*
> + * structure for tboot extended data elements  */ struct
> +heap_ext_data_elt {
> +	u32 type;
> +	u32 size;
> +	u8  data[];
> +} __packed;
> +
>  /*
>   * shared memory page used for communication between tboot and kernel
>   */
> @@ -126,6 +139,9 @@ extern void tboot_probe(void);  extern void tboot_shu=
tdown(u32 shutdown_type);  extern struct
> acpi_table_header *tboot_get_dmar_table(
>  				      struct acpi_table_header *dmar_tbl);
> +extern struct acpi_table_dtpr *tboot_get_dtpr_table(void **); extern
> +void tboot_parse_dtpr_table(struct acpi_table_dtpr *); extern bool
> +tboot_is_tpr_enabled(void);
>=20
>  #else
>=20
> @@ -135,6 +151,9 @@ extern struct acpi_table_header *tboot_get_dmar_table=
(
>  #define tboot_sleep(sleep_state, pm1a_control, pm1b_control)	\
>  					do { } while (0)
>  #define tboot_get_dmar_table(dmar_tbl)	(dmar_tbl)
> +#define tboot_get_dtpr_table(txt_heap) NULL #define
> +tboot_parse_dtpr_table(dtpr) do { } while (0) #define
> +tboot_is_tpr_enabled() 0
>=20
>  #endif /* !CONFIG_INTEL_TXT */
>=20
> --
> 2.55.0

