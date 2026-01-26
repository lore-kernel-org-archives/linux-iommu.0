Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2E2B26E711
	for <iommu@lists.linux.dev>; Mon, 26 Jan 2026 07:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769414120; cv=fail; b=V1ixM735NYaUVOS8lCK5H2o8txrtTZ7aWnHg2g7OTFweH3C7zW/nW+UU69i9jrqqWPRAprQc/qLm4TF+FYlweQlqzZXVWk8achcB4hGX7cMxpvlwiO7dPIj0mOFDlZuktDxs+OQD5Rmpm/34NutumiwFhPDbscRK/nc2VguwGro=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769414120; c=relaxed/simple;
	bh=857Q8OLUNOuH0r/rZIaOvPxE+NroyB05cYmt1iKDH7Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uZbLnIWPfGX+n/HPGjhP1hmDd8KtP19ZYHGnGLiezR/GGT6ksMZ7Q4DeLcD0oXmrbw77eV2FsAIK/VlLlm8h3kKNPJww9c2HXnKDDUFJZszSf6f3HbG4Wfm0T2EVqYVZe2nD7Ub6NHsJCgcvoNtsnTPhlZuFSAAelv6GMUsKNrU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Qy5LA7RN; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Qy5LA7RN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769414118; x=1800950118;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=857Q8OLUNOuH0r/rZIaOvPxE+NroyB05cYmt1iKDH7Y=;
  b=Qy5LA7RNWZ6aI7etsaZHv7DWHTPVCCQ+NBaQuLwsfR91Li7INGUPZYzy
   MsftH/aBbec+7juWYnSYhbO1KJpV+Hg+ojKOh19yA9drJExylx401I5J6
   GFMDqCwvX0mIGjtxRT3vD0vmOQX0o7DShgjNIY1wUYB9/m52lfacA8pt9
   sNTWMeZr9YG2ZvxrwWTVhdZUlll91H8ufrocoHiN05b8e9A1OIiRWldEZ
   TgyLwWIOOl34hKIi8zddkUwn/JISzofxP7QB1Y+AqmmW+TVhBTkhG/kim
   bPiZUawf5/jzDjJ1Jcud0rXblT0+W0pxd5VdslvylI/XPpjD/9VsrzKNF
   Q==;
X-CSE-ConnectionGUID: LVEI8egeQie9i9TQm096Rw==
X-CSE-MsgGUID: Lo3ylQKlTQCP3n8zz6n7VQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11682"; a="70645585"
X-IronPort-AV: E=Sophos;i="6.21,254,1763452800"; 
   d="scan'208";a="70645585"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2026 23:55:17 -0800
X-CSE-ConnectionGUID: EEAeGqc6SauJx367BMDfrA==
X-CSE-MsgGUID: QwKoOCKBSfyIC7g9Y37qaw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,254,1763452800"; 
   d="scan'208";a="212129070"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2026 23:55:17 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Sun, 25 Jan 2026 23:55:15 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Sun, 25 Jan 2026 23:55:15 -0800
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.0) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Sun, 25 Jan 2026 23:55:14 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aRCioBKd0GmnUqRvy7OX8KbYgUJ1fWkK88uPdfRgrEubTtIV63EWXiazJH+mxN6jjbVqVNcXsUXvZ4J3Lrm/LMBNpkDkO8dEWm9Imdc6BOl2NCQgdZr9rV4TW+WIEAYe+j9bFF/IYfzy2EZui2NjYJI8BdHm8vry/LCXQkcnub6CPGme3PMCR5ZH9pq9xd/hTgoDYjCiH8Cfi25u/AjhUVr0uenXV9nTBS3pXatAekaZgh9W56R0057vhQiCgzFXOeK6Wzc09HD1A+wAUG38tzN/HDJovimPfl4VJKLshUjcQKuH40bcTg3QJo73Cg0KUcMTdrMPhUUpFUYzUvwSww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yxqc+7Ly0fqZhzSR4E2Wj02Wo+RefVbxud733KAYMDk=;
 b=n6sxq8ubWZfviUSnNszjlj5SEcsuJmpm6iwos5PSEOYRo5mKc7lv8l7Io3yxNz8n2SA5X/r5kAdW2dwiDIm1JOpq5MASgRfRLmKldsc2X0KFHpSqEm1/zrEAGu22O0wKbjDmGm0y//Mqhxa3sK3AwlahGOmtkUzmwWQ079zgeHvcUzrhvR17VCMsx/5i0PtFHO7Voncm0SANC6lR9c8Gg87Sn4IYcjCgqGa0BbXTUJ5kUhAroKlziJRumq1zShJS0LIBDrMsEOUDF4GIwM0t26gMCHQpVMUlv+CS3BCV93x8p3Z+Xr94eH5RGy1rq+CrnZ2SckEarlCWOOmXkV2P9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by DS4PPFE396822D5.namprd11.prod.outlook.com (2603:10b6:f:fc02::59) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Mon, 26 Jan
 2026 07:55:07 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::f997:762f:f079:134f]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::f997:762f:f079:134f%5]) with mapi id 15.20.9542.010; Mon, 26 Jan 2026
 07:55:07 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Fushuai Wang <fushuai.wang@linux.dev>, "jgg@ziepe.ca" <jgg@ziepe.ca>,
	"joro@8bytes.org" <joro@8bytes.org>, "will@kernel.org" <will@kernel.org>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>, "nicolinc@nvidia.com"
	<nicolinc@nvidia.com>
CC: "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"wangfushuai@baidu.com" <wangfushuai@baidu.com>,
	"syzbot+a0c841e02f328005bbcc@syzkaller.appspotmail.com"
	<syzbot+a0c841e02f328005bbcc@syzkaller.appspotmail.com>
Subject: RE: [PATCH] iommufd: Initialize batch->kind field in pfn_batch
Thread-Topic: [PATCH] iommufd: Initialize batch->kind field in pfn_batch
Thread-Index: AQHcjnNmlYO45XXlKkWZkMw5tohV0bVkEyHQ
Date: Mon, 26 Jan 2026 07:55:07 +0000
Message-ID: <BN9PR11MB527624911E329D4B870380418C93A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20260126032438.63303-1-fushuai.wang@linux.dev>
In-Reply-To: <20260126032438.63303-1-fushuai.wang@linux.dev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|DS4PPFE396822D5:EE_
x-ms-office365-filtering-correlation-id: 2dc42b09-aba7-4357-5a3e-08de5cb03915
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?Uym7x+4bQvurLMEmDjbfcGoyUMP5+ozDeouQoO0WTZyzKNcJMTmkgIPrUfYS?=
 =?us-ascii?Q?hW9mA2i1EvM3b39NgsHtsdZVVnvSrSTihs3lVEd7Xry3kYJIz2bHIEgg9fcL?=
 =?us-ascii?Q?eYLDCxKCAqMkzrgEkfp9oP1iHgp7+ihazgUY2pH31tsisTLHwlaBcGpOCde7?=
 =?us-ascii?Q?yHhtU3JbWTRcHPQtsGohYWj/6cS9qKbhVrCN3HV8/BBiFwbCLh7GrYMYsA0x?=
 =?us-ascii?Q?oTWBbd34CLw1tjHsDD6ZnjvcGGpluUD4v9AEYadbMzOm/Pg8dxzvRaPwRaES?=
 =?us-ascii?Q?YFp9fScizzDCSYmH5+RrHAwJrtJ+A011q8fRR51tJjSlYyk0yjtZDZ1KFBkI?=
 =?us-ascii?Q?kU3xr2ATccaOv6bhuux4pjyeYvb3ut7GcWbhb7UoO3+w5RDsUYdhB1yyt6wR?=
 =?us-ascii?Q?bLs45G1mVFmcHmQFSQK/TwSbHZiMS5xPVCUHYqlzMoa+9WN5waQy73Jgmz2O?=
 =?us-ascii?Q?AkZ3vP0WeweuqqcnbVXPHTmBC4h560KLbytunQ8K3FScLHQmLd7Lcwok7YNP?=
 =?us-ascii?Q?AZLu+sxgU/PQ1cwp8lLA9l8MEbDiCiazMtIJM8TztmaP8rSzCaO9vSVBGgmi?=
 =?us-ascii?Q?HgN5XNMhovVgYLfOqakw/v34tWpOdT3oQHx95gFDZKMxbFCj2AzrAkZIKGvL?=
 =?us-ascii?Q?wYClnQTQ1KRsTjlGJ+hiIzqyLXApV/xXEnlXloMFGAnJSbSsfT6sXQJATlyD?=
 =?us-ascii?Q?RoGBOCQhTpj8WI32dVkth2ob5Yhl+Y+8rmpCwMCbL4wdLGWldNklzo6+9qY+?=
 =?us-ascii?Q?aDfdyVFsN9AgFI95R8qSDgc4hyq04ZMBMZbeo66vHNlw5a/beckspq/R2rpJ?=
 =?us-ascii?Q?6JBEhZ8EvIF/ds2Uj2fOI9CWUC75TI3VXNZkOPIKvH800bqenhr/Tp6IBXbw?=
 =?us-ascii?Q?VyrNilCe135qpuvUCmJgsuh7hYgYjNHV4781W/2/1lXB1UATg7z9HmGKuhj7?=
 =?us-ascii?Q?XiHp8VJgkj3Mu8jaIjVU38jA1fu/bKPXK2d8WDWNmqPUFvt8/TsOc4qm19F6?=
 =?us-ascii?Q?y6sv2EfXuYt1ANfxIOifrX8lz+LgWJK40sJAStzNlBtfNw7/8GlwXu8J7doQ?=
 =?us-ascii?Q?6AYVSbrcjGUzAZ7weaKAlwduAFfOE2hW7PcLIIynEfSI4szxjqm/KEEw4t7D?=
 =?us-ascii?Q?uP5NWeAHOOvNjLeYomESjh70vBgBwmO/vvNL7iDsjoqqjKkqzNAhR13qx80t?=
 =?us-ascii?Q?iM1590iPmCJUt1TmaJmoBVVYTBwnuQFvqB3oy3RshHsbuMPV6lbcW1t5mCxT?=
 =?us-ascii?Q?RA6y545MuFkwJKGnukRLmHdU/2S5mXFxQT3NMixM5kZ24FpTJDptdpD+epJ0?=
 =?us-ascii?Q?S3Sr7mW9ZNp4rJSW7Un80a/H1SD+pJqrAJ4rUYLTmwFT15YQoBIuz38L4pwy?=
 =?us-ascii?Q?kuL24hihA9HbwoRgJHzQHF11Xd9QwFeC6xt8Yf2rGVj0WOQGiPRAmPF0PmZ4?=
 =?us-ascii?Q?JpmItPUrBZ6HEAUETqKA0latGoLgMXQ7LJ9ZtHFKE4AYComy5S498UksO8IB?=
 =?us-ascii?Q?ksmIAsWYEwvHX6j7Bf0LiR0F5A9+Ti19uTtFCYGHU/b/g9DSyazFKYtiYa6D?=
 =?us-ascii?Q?0GWecCxlhwWUBfQJ8bRveaQAzGoAj6KlAEICx8j5q0BqfDUmbVIt6h+zAQhS?=
 =?us-ascii?Q?3ngt+TaNoHjY1Xdr8Pgk/zwvDRURaynIUyFKWaJSRu7N?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?rufOjrkLHyZFi/Ml2q0kdxNRziTknUx4wadx8q5FvQwd6r9ajGfwEMZlpr0a?=
 =?us-ascii?Q?xcgCA7sHWLlVPzWNJKFFsFvV/R6dkKFW1YsgU+6hJfXmLIHLBgfpRceSa5Rf?=
 =?us-ascii?Q?zxMoOP/W9xtSUwKYH0tlWBdos+dVBTX+PH6bSeDzE8pjqy1hcThDI30fjRU+?=
 =?us-ascii?Q?7Tjx6v3DDQe4GWxQBX/xLoly9AelQjfYh8tG1J1MHS3ddDqnInsMEQqoQzRN?=
 =?us-ascii?Q?DGTA8cNGsX6y6weLF42OaPtBAvg84YjOlLX3x29zn8tuhx5ree4HGW2HtIcq?=
 =?us-ascii?Q?pfb6d2WePsUchG92TVnkPxLhzBVqemdoY+wEyV+TNItrKMP9ZiymtAxTclmy?=
 =?us-ascii?Q?zKarF+n9yXlMAiVR4JRZe9z2FMiQVPpkdMBU7fdVhBqYIoacfxdshG5krf4+?=
 =?us-ascii?Q?+k1fAWu4aWlE2vgiyWM7W7Pg+Kyxkmadxi4GtdgTgfL024sQYB7DHtONT2C4?=
 =?us-ascii?Q?BM/pfFYfFjuN3i9NbLvxPkrixggHAlAqGC4tXxDy1XDJL/Dy2HT3ydMHwmQw?=
 =?us-ascii?Q?g8O3HKtYLGt+Fgz9r/owptbfosZpith/LT2YqDmkRNqv/pSCnt5fD4Iib1Ai?=
 =?us-ascii?Q?+Y+tI7/xE+d9dK7QykvkRKYmtfMF5KCZsMaQ1Hj7U1ws1e6sMJdteK/P0HEg?=
 =?us-ascii?Q?8QBzum3GlP/CxWZxdrNNt6CLWIG9sGCiry3N/3aS8jgZC6JGojDMAlHNBGOa?=
 =?us-ascii?Q?9ZE/HTsPCUebSrT/6lFEVjU2daz2PRvXMTwF+vKj3CHauea+sHoPXOBdfy/a?=
 =?us-ascii?Q?fsxyd+aPreJUSkmZlIQO6TClWQGuwqlZybRyqPeyM2U/dcRWxGqabjoquaV6?=
 =?us-ascii?Q?yBdBICiQlMLel7Df63gVBtRHZBoYiSj/KlGaTLR3mNkaAbrqzSKI1Lk6i0TG?=
 =?us-ascii?Q?qY0fsmCOSsHgmLCU33bRZOfHHp1zwEWtUQnqCETZ/hF2MJvsrTN3gjZpNl54?=
 =?us-ascii?Q?3EsriEfergJHcguClguj7iarLE58a7qN30/u9WgUMBvHfnxjmI1Jg35Tt0/l?=
 =?us-ascii?Q?1Yorh5DXCSBfvoS4jBwnnTvMJL1OLUbhM5O/7dC8xlkJKV6po4nLoJqnFi6y?=
 =?us-ascii?Q?uJXzN0/IFjVD7OhsB7e2FMqwjprP7JLMDLGWDZxgeJjm59GTj9NeDaRkG1GC?=
 =?us-ascii?Q?78QBIGH1mJyhfdOSAWlzQBKU4B57mDj2Cf4sTtEyQo3cQx3+o9kNqWl33NMr?=
 =?us-ascii?Q?aUJ2bh8TsDm48SqBZCD0XWRYsYlfu0yBxh9AoXmp3jRzVIVhZ13yYsZwB0XW?=
 =?us-ascii?Q?aSX+CIG8WHnejYMHZBUyRpcNVXNrGuFwB2flBMrgze71o6l1IwtsTdKkPTIz?=
 =?us-ascii?Q?BxhanwPPxNK3xLHIvz2n5+4JMP/n6V2LKZvDPh/vemv9mAx6JfjHH/Rpynlm?=
 =?us-ascii?Q?k/VFc9noFx6T+dUAEYupcxfHSkqrm4ArcArf8GioeRIbg/SfGU9uQBD6+bY9?=
 =?us-ascii?Q?YZtbQAZ3bkLejIjXrpdByCg5/BprUQfFaFMlVLVbavSg7q63m2sBOso7x/Aq?=
 =?us-ascii?Q?3UwdCBdFWzfb1rmvVHj1B38Nw8JLX0nAaou/rqWIKlmNZKDIc8pGrY0u5zqC?=
 =?us-ascii?Q?x4wUjPjLtpa19uWSV4IcHSgCA5UlAE2I2GCYDh+DpJtPMuJe/ocASzpwACiL?=
 =?us-ascii?Q?bZ0PSNMjwJe3FRiZsr5MtJqRA4IIfcaFHwW78aqidQuTYvMGAeMxQsEgJ7s9?=
 =?us-ascii?Q?blETw4llquPCnJropNNQaNMnAufmuNBinmWcmPion3K7WJ1jfXlMXPw270EK?=
 =?us-ascii?Q?Z9taE3PUkw=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 2dc42b09-aba7-4357-5a3e-08de5cb03915
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jan 2026 07:55:07.4500
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: g5JgXNLUNSPq3t/r6vgf7B2eWNX5KUF/l2GVu+H5QuiTywC2VlYI/TlKVfVOixSMfMg9PVqy3TYmTWSN8SmKzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPFE396822D5
X-OriginatorOrg: intel.com

> From: Fushuai Wang <fushuai.wang@linux.dev>
> Sent: Monday, January 26, 2026 11:25 AM
>=20
> From: Fushuai Wang <wangfushuai@baidu.com>
>=20
> The commit 3114c674401e ("iommufd: Allow MMIO pages in a batch")
> added a new 'kind' field to struct pfn_batch but failed to initialize
> it.
>=20
> This leads to KMSAN detecting uninitialized-value usage when
> batch->kind is first read in batch_add_pfn_num():
> 	iopt_pages_unfill_xarray+0x86/0x1660
> 	iopt_area_remove_access+0x508/0x650
>=20
> Initialize batch->kind to BATCH_CPU_MEMORY in batch_clear{_array}.
>=20
> Fixes: 3114c674401e ("iommufd: Allow MMIO pages in a batch")
> Reported-by: syzbot+a0c841e02f328005bbcc@syzkaller.appspotmail.com
> Closes:
> https://lore.kernel.org/all/6975b1f4.a00a0220.33ccc7.001f.GAE@google.co
> m/T/
> Signed-off-by: Fushuai Wang <wangfushuai@baidu.com>
> ---
>  drivers/iommu/iommufd/pages.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/iommu/iommufd/pages.c
> b/drivers/iommu/iommufd/pages.c
> index dbe51ecb9a20..064f2cf32cc1 100644
> --- a/drivers/iommu/iommufd/pages.c
> +++ b/drivers/iommu/iommufd/pages.c
> @@ -289,6 +289,7 @@ static void batch_clear(struct pfn_batch *batch)
>  	batch->end =3D 0;
>  	batch->pfns[0] =3D 0;
>  	batch->npfns[0] =3D 0;
> +	batch->kind =3D BATCH_CPU_MEMORY;
>  }
>=20
>  /*
> @@ -309,6 +310,7 @@ static void batch_clear_carry(struct pfn_batch
> *batch, unsigned int keep_pfns)
>  			 (batch->npfns[batch->end - 1] - keep_pfns);
>  	batch->npfns[0] =3D keep_pfns;
>  	batch->end =3D 1;
> +	batch->kind =3D BATCH_CPU_MEMORY;
>  }
>=20

this is incorrect. 'carry' means a portion of previous batch was handed
over to the new batch, and it already initializes the array with a valid
item#0. So the old 'kind' type should be kept.

From this angle Deepanshu's patch [1] is correct.

Strictly speaking it's not a real bug though caught by syzbot. The logic
in batch_add_pfn_num() doesn't really care about the initial value of
batch->kind when the entire batch is empty:

        if (batch->kind !=3D kind) {
                /* One kind per batch */
                if (batch->end !=3D 0)
                        return false;
                batch->kind =3D kind;
        }

It works correctly even if batch->kind is uninitialized.

[1] https://lore.kernel.org/all/20260124132214.624041-1-kartikey406@gmail.c=
om/
