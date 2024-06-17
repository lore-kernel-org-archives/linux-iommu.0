Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A60A1C6A0
	for <iommu@lists.linux.dev>; Mon, 17 Jun 2024 03:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718593482; cv=fail; b=OuP/un+hpoULiP+dwJ+jcjbexsMEbxFKBHCLfTcvvCYvOfMZycrRC0lW8jGIo1tIzpKspScR+7zDM4FSTh9sP9gdGEEvCxzOTm7CcQF9mHoB8GgTSeFJHSt84RnBD5dgnEkP1T4DNo4+p6an45r34Gyf1s3mdoW0xuowKXWrOAw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718593482; c=relaxed/simple;
	bh=L2YW2hCBsfT6mb694vr9yFj6wJTmoXs3zVNabWMFOXY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fITzIB2RwuOl3Q0XgMtmaN3fmM1YE26BFFqVmD9LL8LYRdJDrwpWQpXOj007BPxGkMpKFE86PjsfwgyLXJK/l/nSW56T2AtvO11+/aEjY0RCeO8iRLQcM01pW5Aa3N6zpvKs0cP9VQCmZK6fDxpVxgikZkeeSfY7RagSillI/Q4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iuR/1SkP; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iuR/1SkP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718593480; x=1750129480;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=L2YW2hCBsfT6mb694vr9yFj6wJTmoXs3zVNabWMFOXY=;
  b=iuR/1SkPUz2K43uQKo3E/nCWnQ8nnNFU4H3pNhgIIy3GO0Z91+uq6AcO
   b+TiURlV35d9GzHCRFPcJcm4N12F0xaNZm9yMdENAAwbDP1MvZKYzrlA7
   eXJdNpx2bZZjOy8QiFCHnfW+JPyYP87KrW35Sy8Ttf/MBId9S1CN7ppwj
   +hklXS0JSJEteRfx9QBMtwyPfBuDQq8lxpLCENzbGScqin5ch8LJ05PqO
   gUun91yIsNF09gg7GG4ua3Xt7zTpCB47XsC0LPWsY9DMotXRLylmFbu/E
   udVWZwhFdWw97YtRm3E/szd0Z/r8l7x8ffTPFAhtzNtlo+uDj1LgCc23J
   w==;
X-CSE-ConnectionGUID: /j5wANpQRL+rE6eF3C7Q9g==
X-CSE-MsgGUID: 1dUbZetjSbW3IJwWi5HztQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11105"; a="19194908"
X-IronPort-AV: E=Sophos;i="6.08,244,1712646000"; 
   d="scan'208";a="19194908"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2024 20:04:39 -0700
X-CSE-ConnectionGUID: qe0z6MfFT2ec4Bx434+l1w==
X-CSE-MsgGUID: hK5DEbboTAu8kydWOh1urw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,244,1712646000"; 
   d="scan'208";a="41165247"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Jun 2024 20:04:39 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 16 Jun 2024 20:04:39 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 16 Jun 2024 20:04:38 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sun, 16 Jun 2024 20:04:38 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.43) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sun, 16 Jun 2024 20:04:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HeMNbFsHyOz94U4B7e4TiQxCGxqoj0Nl0j/OwS010dchSXOxNe0XHAvgkkSJl6pi6lEV9SSCRLIeb/wJtXOklDXbB6dQPXtQC/0GV2PYOXyala/fUpzBxwzuuJN67TjVH093mybRkADUAx1cSrqqz2SvyXEm47M+Hkaajn6URW4Naf2sDQhBPdjWZxpEEAgrDMk9lzDvC7hmoBnwsXJyOB8RUf/fSA2E4Pma2IPJ9QbKK6xUiNPj+9N2oMxeXs5kx9hIM9jHErYWi+XCHexpqKSE/ViW9cgVxvnxsmN1vE6N9wi6ujHn0evJJ/SJvPhTdnZfyL4CPuGD0F/hRNst0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HduPUIA3r1GvO8mRERnGZTWXVuBsVdNhSeRroCi8VCo=;
 b=GKxH5kEz7eBgtP0MdBr9vNfiqb7UZdHcZ9hh7h4CqTenZX0lxHKfLtDxeKeySK9o6KFKatFisw6JLZSEO/GinELFYO9VA1jMAb9YfOo0QKVMIzrkAfwjNRZWKME7jBSNyHqbRvErYRsywySp8cp/iN9ljsQBIZ5pNMcaLLVIAHOihzGDkxqWMbHzvofPUmzG+lRn8T8a7qKfnImnQb+oZfp9GudzCrd9rh0gs0zPhDC7jrAr5Oo+C2CWE9nF1JAQA2nEqX7YGqIDAl3VJXSGOtPLQOFZVZvS19HL7LqjiLTNo8V5i5SsL1TfPmXk2YN68RjnnrOsPAEy/X8jtzwHAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by DS0PR11MB7530.namprd11.prod.outlook.com (2603:10b6:8:146::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Mon, 17 Jun
 2024 03:04:36 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%5]) with mapi id 15.20.7677.030; Mon, 17 Jun 2024
 03:04:36 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jacob Pan <jacob.jun.pan@linux.intel.com>, Lu Baolu
	<baolu.lu@linux.intel.com>, LKML <linux-kernel@vger.kernel.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>
CC: "Liu, Yi L" <yi.l.liu@intel.com>, "Kumar, Sanjay K"
	<sanjay.k.kumar@intel.com>
Subject: RE: [PATCH] iommu/vt-d: Handle volatile descriptor status read
Thread-Topic: [PATCH] iommu/vt-d: Handle volatile descriptor status read
Thread-Index: AQHauQDa+Lr2zHTOfEugChh18h1np7HLU0Gw
Date: Mon, 17 Jun 2024 03:04:36 +0000
Message-ID: <BN9PR11MB52765C0508922F9CDEAE7E9D8CCD2@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20240607173817.3914600-1-jacob.jun.pan@linux.intel.com>
In-Reply-To: <20240607173817.3914600-1-jacob.jun.pan@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|DS0PR11MB7530:EE_
x-ms-office365-filtering-correlation-id: 11f9119a-f0fe-49f4-5763-08dc8e7a385c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230037|366013|376011|1800799021|38070700015;
x-microsoft-antispam-message-info: =?us-ascii?Q?/xcntcTmMDXiez5kXpktDVZRKoUcuEeNS/x1NQ03ZQ4JlrGBLmilScDSTSV7?=
 =?us-ascii?Q?0cTEn3YsoPUvy2XfjhBf5XEfmVTErpPVssXrbfdrie960bceSKJwFVoLjEdM?=
 =?us-ascii?Q?hmuUxG6IUb5JfybFdGknWDpCqQQN/kT4C8lH0ilOIJg0vAw3Pq1unwweaJZo?=
 =?us-ascii?Q?LOTEyuFyNf1JSfxolpgm2iSbPojrVCN9uPFOvb8GM8kIOmjBqM/PHgL5GvYn?=
 =?us-ascii?Q?yHY9N0zfeexDkFIfK5AP2BA1TmxpaLE77JKygxqpkS2jLpLlp+ggtFlSSUGE?=
 =?us-ascii?Q?qleWKm9iNoumww9KMs4YJIYM1fF3O5lktZWaM0xHakG2my/lNXFGFK3Smxc+?=
 =?us-ascii?Q?cQoBSBYh8iIUovnL+eO4nLLoKQF7CzUwIgzteSjPT6EoSWT8mY9GniYB+XpA?=
 =?us-ascii?Q?mokOdoaEdfR64auXRhlmzq9aN1Mne0SPQy6fFUquBh+cCo0qKiDfaaN3zNWp?=
 =?us-ascii?Q?42J89Clq/J4X9BMYoxrnMKROHW2WzrnT3+pcXKPdzB2xXH2rczy3qlPWVq4k?=
 =?us-ascii?Q?5eh1dmm576S3Z4BYbpJcF+nq9aZ3eQXtoZGjEeYVjQXXKnMys+vXm6gUrDQS?=
 =?us-ascii?Q?4lESa4U4GRQ1o/Qx5hz1mqvbsYvcbMvT7bu+puEooAPTY+0qEf9sBW+8lyZ1?=
 =?us-ascii?Q?d+Q87NPqPxO5V3wziakIT/SUK4fmcLOcF5nJQbYYcSO6wVwWoJDIfAvw7xuj?=
 =?us-ascii?Q?iTEEdE3ntG/ynpcWtXZ9x9x93awRlDrNVQHW1wvu1pDJQ/1BQsVzQoQkeKZK?=
 =?us-ascii?Q?bvQklZPwL9oaZ85G9WkbZaClKk9yGWb5j9D/7hqdJCdxuLDBcEXv5GFAVIGN?=
 =?us-ascii?Q?Qde5EwVAa2K9TVd/gaNwe5LOZ7Hd9gSuheXFv0k4BomfMDXUkR2H1oI4y/9l?=
 =?us-ascii?Q?YSGulZMaD7j7vWyxSbdgVPRKr2UDbKrwYTY63fGgPj96dlcXtZxYi3Hs8TVT?=
 =?us-ascii?Q?tIdPosm9Ht+Ndo8V6N3SGvQQHB8I9NvF3tblEaY9ASRXl7Lu9PL6rr2pTMC5?=
 =?us-ascii?Q?w2/p/7C4rvJ9DYRdLWBKE8DHlIrAIQbuyhlIBkRfuH84E+k/VVR8U+8Z6Lvx?=
 =?us-ascii?Q?ahfWXYPEhK995HoDnb4ZnqPeSfAB4qhBav4GpFHu7g5ioXHtX+Xhr8zEAM9P?=
 =?us-ascii?Q?GRpNwF+zmPDrFT8TEg+6YsWDdgDr/uJRXjwjn47jmhSFN4jFmDV0pV+mJHT/?=
 =?us-ascii?Q?XXVq5lN9WUwb4e16sUgZo9jtyyTRQuzZHagr2YF6AgvAfWfNlO8bOCC+6ME9?=
 =?us-ascii?Q?qz5wyuCJxh5QwJTdJkefuy5N2U/Ghz2QD9vo5vB3pme4MYj5xVrnyQbdtyFq?=
 =?us-ascii?Q?DMvEYHqc4lQN3WpJY17cQdGGQXR+QYvOW9og4QDfI1d9p5cyY0BB8xTVNbqj?=
 =?us-ascii?Q?foHIK2c=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(376011)(1800799021)(38070700015);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?fQKhzc5Jat1abFkiyenhIkSuHVkidAQdvw26/1sJzrfHutbg50dBdhwVC9GI?=
 =?us-ascii?Q?xLrSYQOi0MeozJ55tzWt8xjWPbW7jRxwC7IV2IP7vj2k/d0lBF05oElw09lF?=
 =?us-ascii?Q?YCR5JtXKrNmOi+xvY96tWTcPBdhiDWI3kHOvexFvhSkmUsMRJEFUnKrqCuBm?=
 =?us-ascii?Q?EObxdwvYoSZ3PWOs4uO6MnaPm/PnXRIIqHsyheF21B7kaSy5K2ZZnQgqDZZF?=
 =?us-ascii?Q?RGsC81lZVj54axdiSP695lGu/zP7FPtkvLQG792eUVN9WBC8SbSh9p/2VE5m?=
 =?us-ascii?Q?DUman3JjG0CI8ARSnXWV8vMfn/zJkN/wlVEjy9SrGyCcSxo9AU2+BKIarsd5?=
 =?us-ascii?Q?/jGPlAlQnheSB1gPgdKtzLOqycxzDPRDV5OKP9aq0ojlyuAtfSbTCl1fuP7I?=
 =?us-ascii?Q?9GYQ7M1hAf8LJ4W6WKKIXghIqvJDe5WtV5hmGfgTs+n9Hwr8mV7rjA5vuiks?=
 =?us-ascii?Q?bUog0pbKkonO9WUX3/gBK31oHpA0Pl641zBrbh8zk0rsbWi87lDKIlFPWkK8?=
 =?us-ascii?Q?1NSnOt7fouxWTHo0NyiDaAy7baZZNa0AQsWXIoJwZi1gHsqHgH9zCG87afah?=
 =?us-ascii?Q?2mTwdgfSbIKbX7WWgmzPZ+JVDaBJO0m1LhbINSR5JtPgKJCj88re8xsyUtUo?=
 =?us-ascii?Q?/mIcNAcx2wD/p8yZ6H7oQqDpSSmu4OEfLWYQaagK4GZo6kaDIOye8DimSay5?=
 =?us-ascii?Q?8N6YxZk1jRiwxjs+BdO0N8Jyj8AD0QcArmpT8gi1T1VfW1Bk8hrKZP+ehwuE?=
 =?us-ascii?Q?OAUITWlxM0fUDXxuymKDSrfWFprGt64pDFsAD0Ijei8V4dOARsOg771WjSKS?=
 =?us-ascii?Q?sWIcIHmkUl74jDfTSNARzhIE18S3E62eKSgzGIQLInynqIAGwJI3OfffWPRZ?=
 =?us-ascii?Q?KuM7ZY8P8gppPE3e4p9bFcHYeFLfz1d9vrTLV+ImZ6S7ETkIXw7LjFaYZ8/v?=
 =?us-ascii?Q?vAOYgHztXkcOZsHhJJpy/KUr3FKwAZx1ApC5eaYes2Bl03Tqh/ZaAO2HTLAj?=
 =?us-ascii?Q?zvuymAyFxNF/31b2z5fhcrOiWDOU4qynFS8WNDrGXb6R2QBKQn9TCvJzNFzN?=
 =?us-ascii?Q?x+9OwfzPEvybBqIN/wvaUxc6gSSgGLm6XPT7l246wx/Dyid50wXeRZ25zMHi?=
 =?us-ascii?Q?gUXZtrPZ4WoYxFVloUmRuKcYzYgikVEpcijvrbrSUbAzUfZ+rZIWd9M+cwYv?=
 =?us-ascii?Q?PB7jSp6KqPP8DAa9tOMthP6jr1sDgxfaTeUgDnh1RS9Ppmpmk+Q3BiG4RYen?=
 =?us-ascii?Q?FG0cYRIF2p0CU00WtyIwa7I4XVBWPLPMHaraBU1RYUmCKMeKa09WMHBpNNQR?=
 =?us-ascii?Q?vnB8rkGn+hE7p2lRHt5gKlzvjhesXpUB9YneP5CTAC5fjFtuHSQzbNDAphqh?=
 =?us-ascii?Q?vQC5fFH5tFWfeHjJrVBcES60GUWIs6YRZYFQOWyMmqgwmdDPFHmMwL3/zzh3?=
 =?us-ascii?Q?H5OS3G9FYa1i7yd5jVYwExQOJf3Rx83KjAChOQyrSIotZeIWRkvqU7tDvgCA?=
 =?us-ascii?Q?/2sdwgPGzT4+7LuU7u9phv+9d9kx1lHKUtjT+Dn7T7VGdktTxKsS5Bs5MMTU?=
 =?us-ascii?Q?YYQF1RfLFXEw/eXXBGxBVuHzAP+BWNjizHJV0Wb6?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 11f9119a-f0fe-49f4-5763-08dc8e7a385c
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jun 2024 03:04:36.2383
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: e6tPuOUDNN+3JUJoUgLg9CtFdDBjwRljnJRSB7bKRgb8fLydoHuOGR3wpB2K4PnZhgN3LLTiPFSEO67ICbFVmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7530
X-OriginatorOrg: intel.com

> From: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Sent: Saturday, June 8, 2024 1:38 AM
>=20
> Queued invalidation wait descriptor status is volatile in that IOMMU
> hardware
> writes the data upon completion.
>=20
> Use READ_ONCE() to prevent compiler optimizations which ensures memory
> reads every time. As a side effect, READ_ONCE() also enforces strict type=
s
> and
> may add an extra instruction. But it should not have negative
> performance impact since we use cpu_relax anyway and the extra time(by
> adding an instruction) may allow IOMMU HW request cacheline ownership
> easier.

I didn't get the meaning of the last sentence.

>=20
> e.g. gcc 12.3
> BEFORE:
> 	81 38 ad de 00 00       cmpl   $0x2,(%rax)
>=20
> AFTER (with READ_ONCE())
>     772f:       8b 00                   mov    (%rax),%eax
>     7731:       3d ad de 00 00          cmp    $0x2,%eax //status data is=
 32 bit
>=20
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>

Do we need a fix tag here?

otherwise looks good to me:

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
