Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25A8B26E719
	for <iommu@lists.linux.dev>; Fri, 15 Aug 2025 09:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755249794; cv=fail; b=WO3HRF3TUgxgQAv7FgXMX62xPFZUIyTfhhr7TpaT6mpoRm/ugAJLaDvGUTr3zu9/jQU5oQmspWqDYoGWjK+Tb+N9zUtrD1kmY4jdNGIUHQQJcpqvS9snDm58UW8JBzzNUTg+PzVTseWtjvoSh2eMV5N9xX+xGNy8zPonrP2BOOA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755249794; c=relaxed/simple;
	bh=ihho+v5n+dmmZj47MmeiIraE2yMjvvENWhwHYgijH2U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bsJQCLC69GCHry6O6m1Fx0JpINjZ3M8P+6VGLQaZ35wNnha4XfW5N8AoN+Azeh/q0SXWs6QK92oRmVue4iB95vYRd2xbR1+GdSgbC3fWG/+3RjON5pFVAqDXWCk/3FVFzmNrvyTyjy0aeLvkHjv+vvn/et1n9AQ0vPVFvbFB/7I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UoKo7POU; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UoKo7POU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755249793; x=1786785793;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ihho+v5n+dmmZj47MmeiIraE2yMjvvENWhwHYgijH2U=;
  b=UoKo7POURjAG20S2trAVfGgZIJugPMu+zXGv+7CxeG0+5HS7zpIcp2cj
   9NN38sNnWYY1HXa/+AFwMEln4habDN4DZJ61Vd2MbgRkqI94uA4ADH/NN
   10MPwIOtsgC+DfGK4LUbKRdB2udl/ES+T13i+u5KKbC740pV7BkFmc/RL
   npcNiJEOv6K4UIv2h6Vh0VOXoSEv25W/24MGUM4x4nIapZ76v0LX7tYdf
   sNbi7LZ2xmXnQmn5UDXdTr1HXHe4BwOMpkdMuHdDuFystm3iyj2/6UjLw
   EnUVbTiTNlGVPHVFMUcDFW5wVvboXmaBTF5aJ0feNE3isy24j2UBcrffD
   g==;
X-CSE-ConnectionGUID: wQTghYcIRZCHeeqeQrU+rw==
X-CSE-MsgGUID: 4HDaUXyzR5OD8yfPYJAWYg==
X-IronPort-AV: E=McAfee;i="6800,10657,11522"; a="80153269"
X-IronPort-AV: E=Sophos;i="6.17,290,1747724400"; 
   d="scan'208";a="80153269"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2025 02:23:13 -0700
X-CSE-ConnectionGUID: Gh/Y6ZyRRcqcJ1Ya7FXhbA==
X-CSE-MsgGUID: LNsDNGHiR0S5n/XJJOKI6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,290,1747724400"; 
   d="scan'208";a="197828748"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2025 02:23:11 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 15 Aug 2025 02:23:10 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Fri, 15 Aug 2025 02:23:10 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (40.107.92.69) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 15 Aug 2025 02:23:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ed2j/qgtOscOnRZnb3J6z8bxni46fx1Auv8GqqHH2Cl8Nflm38ZTt/rQflPJyTM6K9LLIG6I5IY1pWOJ2pI65PTG9yr/iRsOQg1N6hVb+PvFnXNCGE4Ig+CeQVst2QvWo347thxbBk1LuKd0EPyMpkT+LpkamRH94S9jZFhI5XcxldTUt7Kc0yPNnCpzfxoc/4gOCHueoLXMjSRN8BmsdgcYszejgEdipm9Ga4AFPK8n0lpZF68eyR4czJ5pk+qV87dN1dJZyZFJ40jcTQB17nRcQBS3ssHWyow8Bj9MCIsiFvk6SKs775HjO7t06+2LNVBWQ19dKUvXsHrvl/lRrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ruUQG9KiLrs1G+P0/yLb+vsjrHM4KnKNZdpciFdsm4c=;
 b=holywlWC3fgVW19Pwt3oxuFmzWez9SeteKxual2aoSdkltyUBUtoOv4xiEd+DtHe3pyqwLa7B/zEdQrBvoofBU5TrlGnEB3DTnVP26g1QlHXQ5DbQ0kFpAfVsrNP5/tw0NOXrP5yGviShxLOy1SZYHJvmmQrNkrZ1CgcncY8jabGR6SAIeC1+yGQPS0EBuvNgS2s8tS5M+YpNGIy30Juep8vSI7SOAzkn5I8YvpG+qMgim8nNsmG/HY9EfObGTJb/XFZ13v51gJZ2oA1KIG/AdXhSbnftCyuwYnM1suf8rA0kBHaJ20pVZFpIVtXGeFjNF0DkYAnlLcjbcmH5FIPVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by DS0PR11MB8737.namprd11.prod.outlook.com (2603:10b6:8:1a1::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.18; Fri, 15 Aug
 2025 09:23:03 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%4]) with mapi id 15.20.9031.014; Fri, 15 Aug 2025
 09:23:03 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: "Vineeth Pillai (Google)" <vineeth@bitbyteword.org>, David Woodhouse
	<dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>
CC: "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] iommu/vt-d: debugfs: fix legacy mode page table dump
 logic
Thread-Topic: [PATCH] iommu/vt-d: debugfs: fix legacy mode page table dump
 logic
Thread-Index: AQHcDTkVp4VZsWmFikaggFppSOKHTrRjcdvw
Date: Fri, 15 Aug 2025 09:23:02 +0000
Message-ID: <BN9PR11MB527622B2EC5B254C074F36988C34A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20250814163153.634680-1-vineeth@bitbyteword.org>
In-Reply-To: <20250814163153.634680-1-vineeth@bitbyteword.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|DS0PR11MB8737:EE_
x-ms-office365-filtering-correlation-id: aeb3856e-4171-4855-3b91-08dddbdd55d2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?DxcTNOaU9vt4PYK8yWBJrA6+H9ceUHjuIL+b2sZeXNCRsAp5fGFv6DHY2VmT?=
 =?us-ascii?Q?LcKNKlWh/Q2hM3Lrt0+DE4mV+VZ9C1PkJob907jOkuYF+VQ00vN01GivB9hC?=
 =?us-ascii?Q?41valPFrtDbF+IxX/85/tv7WUwjg3Ycu2W9b6DXi2fTLLas5p6ttFtI5EZde?=
 =?us-ascii?Q?HAcOs+FJVN4cBJAoQXT8UXs8oJwbDmcRuvp2iWofqNX1zFm36DrFvTMoOdbX?=
 =?us-ascii?Q?nbvHEeNDjDZRPtLcC2iuVBV25qPjnQRRtL9gzC1VXUhrceZt1y2oQNB2Krke?=
 =?us-ascii?Q?edkMw8AaJMdZpqgiHdz7JL9oyy7JFdZ9P6Sa5yJep3CYmGdVItkZBjix/9xI?=
 =?us-ascii?Q?6omxVvglexU07jRJyB6wHsM6A3OTNxGil5OSRsQBpF3H+pyJg4/qzz71BkVB?=
 =?us-ascii?Q?x0lZKFiiPJSI+vJFZ4yirLrn+zX1LDGAiM4JL8m8A7Dk6eCw5KHpzybfrCeG?=
 =?us-ascii?Q?bNe1TBqZl2aYNqLQ/arkA1+QjnrYITxrsdBarW251UQfFtoLmtIjSVNxksjF?=
 =?us-ascii?Q?snw4QcjK768y4XzsQWl9v8rl7rYo3rn2uW9TsHZWQs2R66oA0nT7qH5nGvc3?=
 =?us-ascii?Q?Mum8cHY/P1uAXVt+inogAC1QSDRE5ppEqTAVFSx+qSpoTB3knmBCqHXFEtXP?=
 =?us-ascii?Q?zlQh5OSLSMx4RyN9IFAFRcg33TGMr1b9XhpCfI3xVR47vW3Ax2AhI4nFYuj5?=
 =?us-ascii?Q?om5dBXZxYDk1HIonB4fWYjAVqDwjzpssasxwBHl9PhvmCM/wUwy1AyZoWBfu?=
 =?us-ascii?Q?q1r4dFs3qZlSDvxCdTK8E2c+qmJmdYuoVqOFcTJgdLN5VYjQtEIMN6qobS2A?=
 =?us-ascii?Q?1QxTp+nr+5hSM4dfmHM6RSKRdcup3HxKAuq9gxq3nVhm3Ug2YxZuWMzvBzfx?=
 =?us-ascii?Q?Sv3w7fkaxmYIY41mq9RSOO5c6WKyalblV3sP5lq/Hfgy9q+PAE+KGaOTZORc?=
 =?us-ascii?Q?+J8//RtV/r73iOor66+L1Er1e8ariZLoLj4o9KzhOnC/YggrpZHeolrQMiVD?=
 =?us-ascii?Q?/uwtOjxnyN5UaTFsBD+xQHa8ePGN6GS13djBe+VpkLvojNaXdloQUvKsFnO5?=
 =?us-ascii?Q?F8Uq3MxuOPfXZ7s/LUFvbWPtHi43HhMkf+Tr8JBwrHG4YNGwfQoRnX1nsLdg?=
 =?us-ascii?Q?6zKJ82m6a2ngiphIWsY1bcwCf8f/fxbBMpoBQ/n+kexkmRw4sFYMXK8yZvyB?=
 =?us-ascii?Q?UYW7ZkKu09t9TqoE4Ck6Ti5te3lM1YoXKuGldvfelPfxu/7dg55y5b83UUNO?=
 =?us-ascii?Q?wdUlmcV4AaJAgSqoUOeieAxhx48N88nYH1b1veu1K00vwg32kmizjMQc/0o1?=
 =?us-ascii?Q?CvyP1dOnZ79yqfxCpTaeFD2zlVZ7YzYXn5m4ZW7Bmd7jrqnQTI4gLN7IyVG/?=
 =?us-ascii?Q?GXgCPX+Scg2Vk/cax/UQjuPqLEQmbUIWzy1AqR1DH4DbR1nJiRCiwa92iW86?=
 =?us-ascii?Q?lQF7tZA+l6q0P7TsMM8vQsAYaDQG6xg42SQWod89Uuo5MNRB5JAXXA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?3S5n5wHVU7Eq8gZc1mVCsD7Zp741w/07CUS9g+Rfu4UL03qObw8nnjQnDRhS?=
 =?us-ascii?Q?IKLkspmt9YpLBuspM3JzVq+4UXjTIz8wtMCiQt1Zpux15zZS/TmhuC/qh18N?=
 =?us-ascii?Q?0wNLJ1lMjcO3WO6BVhFOHnqcNB3rURxwty5Uarg7oI7KHwfSnPQKAhE8c2nz?=
 =?us-ascii?Q?P0Ef3dLKORO0w/XUlfJMh7jr3Zc7uNU9/XoyGDpZ7W1PrYk621nYTc6yRyao?=
 =?us-ascii?Q?xwfyfNoOSuc9HqCFh9KaqXd0ESwhzb9MPFBs4j2xLCNx9Dy+Y8WQ7ImKFYP0?=
 =?us-ascii?Q?Sob+Bcde9lhDeAcz7ryEi1eRlT8r14WiDfZjTmJ5QP1UzLblvIMU2LrmkCds?=
 =?us-ascii?Q?D9Wi/7v/D8hdk5/qOLBpiYVP8q6hQnwxN9IapfDyHXZTF5gM6YkYTTA8+jB3?=
 =?us-ascii?Q?uew8oyxWRvXdwckiUaBH85UtulM5zbR5LxuOjexo5vPX4378ttPfsVqRMrLi?=
 =?us-ascii?Q?HU07y0AGOWxWJWCxQ8wLIwWrOoWhOEtf0VWBZJNSsdr8aE3GkL2yvqnXv6KE?=
 =?us-ascii?Q?5EDI2IVInUTaONsZ3aVs4PA+SsQvYRscfLIE4u87t39Xrs35di9PubKCxynd?=
 =?us-ascii?Q?15LL363h5jX2jU+27Ch8DeIV4kba/NrVBlkmnRiyWuK2CFmU+8x4ys919m1/?=
 =?us-ascii?Q?MbiaIW7J5qwBkwrhHq36dkYrc8mAAs7eXPWMTjDWUaLVSueg7iV9RL4LynBu?=
 =?us-ascii?Q?wuQrEs42X+T9Lu0yi2sge2iapa0m2VPsIs20M8FsT7nU6iXVVx2gKAig/tVp?=
 =?us-ascii?Q?K6MpCEEVNOM0JRg0PI8Ox8WxWMUKANCMOJZsAZWohAFrojj7kT0X/UVoI43m?=
 =?us-ascii?Q?JMhRAwo6gqJ+Tjm7dPLji0OVSIzL8Ds0RkTqd7RoiKspHlxXRveSjPSK8iyT?=
 =?us-ascii?Q?eUPWJ7hp99oweRJ+PH+w49uCZQ5kwffqt/VojtD/7F93rkNYq4Gre8zeDD90?=
 =?us-ascii?Q?81cjIyc3PfeDO1uaFdRM+l1PsNwrh0AzLvac8axaxCEPUhcbqK8PuU/481Ti?=
 =?us-ascii?Q?q9Jc6okhJqxPbLyVUxYyEJ394JC2bGvqmvCjM7HcHNXIKB+c4X/X7Odmztih?=
 =?us-ascii?Q?yjZ+qx1TpxmJPqAeFpadMueMMjb+O/uyqbtkux5K8YAPZsb+zYoiH41YBAZR?=
 =?us-ascii?Q?UmjR46uXzUPAKyDYcpk7IV3Alw7qeActQ890sHkNB9e9ymR3Y7C57/RL9DDs?=
 =?us-ascii?Q?tP4NdnuVcab8dDnbO/oRcxOa8DhGaRIv70gKU/Ka7wQyJ+/Rp4Rr1ym2E3J7?=
 =?us-ascii?Q?QEM1sa9eHmuhsLFsPBoRFfImHiHXc97N89G7TeGrjkN291p4iFwdPERVduqO?=
 =?us-ascii?Q?I/nk40MgMybczd6uwkVDO/eSWXlsJFKQjmJvX8R3Nz09vN4h/VTBq5p6melb?=
 =?us-ascii?Q?aHXHKOFUbbpooU0fI+JrqrOwMjHY8AEryXPqHZvo18C4z/LJEHluELGLO9R1?=
 =?us-ascii?Q?3gmUbDiDRedCUJdCPYYBbFeIuf3e0fo/ll/IleG2Z7Y+03LeqbXepPDBpq8i?=
 =?us-ascii?Q?7lExbYpF2SgOL0QlFOeC1oepnvKn3IlmygyKzhjvkTdj2klOQIPTWJuQL5RU?=
 =?us-ascii?Q?161J27QcjqCx+vhzG/BjOe+8+O0EVICbf1uZD9nS?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: aeb3856e-4171-4855-3b91-08dddbdd55d2
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Aug 2025 09:23:02.9988
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JsGSnV2fxS4+llKmn4oGBasNipC4d2X7UIb83uVNF1+wuPVgXSVsiMn09aMBAXP+LmFfm/BP6v1Va7mmPkU3Rg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8737
X-OriginatorOrg: intel.com

> From: Vineeth Pillai (Google) <vineeth@bitbyteword.org>
> Sent: Friday, August 15, 2025 12:32 AM
>=20
> In legacy mode, SSPTPTR is ignored if TT is not 00b or 01b. SSPTPTR
> maybe uninitialized or zero in that case and may cause oops like:
>=20
>  Oops: general protection fault, probably for non-canonical address
> 0xf00087d3f000f000: 0000 [#1] SMP NOPTI
>  CPU: 2 UID: 0 PID: 786 Comm: cat Not tainted 6.16.0 #191
> PREEMPT(voluntary)
>  Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.17.0-5.fc42
> 04/01/2014
>  RIP: 0010:pgtable_walk_level+0x98/0x150
>  RSP: 0018:ffffc90000f279c0 EFLAGS: 00010206
>  RAX: 0000000040000000 RBX: ffffc90000f27ab0 RCX: 000000000000001e
>  RDX: 0000000000000003 RSI: f00087d3f000f000 RDI: f00087d3f0010000
>  RBP: ffffc90000f27a00 R08: ffffc90000f27a98 R09: 0000000000000002
>  R10: 0000000000000000 R11: 0000000000000000 R12: f00087d3f000f000
>  R13: 0000000000000000 R14: 0000000040000000 R15: ffffc90000f27a98
>  FS:  0000764566dcb740(0000) GS:ffff8881f812c000(0000)
> knlGS:0000000000000000
>  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>  CR2: 0000764566d44000 CR3: 0000000109d81003 CR4: 0000000000772ef0
>  PKRU: 55555554
>  Call Trace:
>   <TASK>
>   pgtable_walk_level+0x88/0x150
>   domain_translation_struct_show.isra.0+0x2d9/0x300
>   dev_domain_translation_struct_show+0x20/0x40
>   seq_read_iter+0x12d/0x490
> ...
>=20
> Avoid walking the page table if TT is not 00b or 01b.
>=20
> Signed-off-by: Vineeth Pillai (Google) <vineeth@bitbyteword.org>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
