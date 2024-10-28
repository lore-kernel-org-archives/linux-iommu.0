Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63075374FF
	for <iommu@lists.linux.dev>; Mon, 28 Oct 2024 02:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730082431; cv=fail; b=lodKnVa9guT5uxg7K2EoiqfoA8gQlnrSRz9eqsTLBzcpQW7PQDi/fBra5JyWvyHH23FW8/4B2CYyIG2sH9rEe+CTwGlP5fWAgqq6DsFIkJ5FI4pTVIWEPNLNCNXuI4fxNLMhN4i2i9PiQT9N08q9PH3K2fK1ms4AIZm/BFTh++8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730082431; c=relaxed/simple;
	bh=iKNFmWvGCrt3GSI+2QAcuH/5nnSllx81Pc7QHZwPFIY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uVsWxxzojkLb5UQ9XYb9yaexWXr/ibEx2Pbuijb7zN9sS4vTRmZk14LFhuM+Vht2wj2A1BJ2VTRwVCOH1Pan04Kqkxo1FLthLGmIKhryMcclRu50Z6qs9VZuXtvWJEqJBL4FMGOv0Jo/p5bNOaUClE4E+ZEGkTTTWUIPwn5QW24=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DH3Gvduq; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DH3Gvduq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730082429; x=1761618429;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=iKNFmWvGCrt3GSI+2QAcuH/5nnSllx81Pc7QHZwPFIY=;
  b=DH3GvduqblnFfOzEhuO03A2QKR1yI6/zrOciEyY622yPKR0w4UBwoDgy
   u+M9bAMDte7AllQVx559M/od1RCvJ5HThbzMqfuqvZO21b517FOTC7i2i
   zwibD82ko/CStbkMmLvlOPfgl4gMTrWcoYInMaAznLyr1Mr+RiV/udNrd
   a1RzIUVni01Piq25aU/u/ra4Gs7WaNwHgqBYHV9k9i9QboMbdXeIGaErU
   aZtL6rxNNvWAc5rpnEt0uAw4YCJQgu2XRh9cKu1b0tQ0Oe7v5yUazEmqo
   1Iz2YAtXiBb5+1WTAajBkc8oTr0ytOFQ2Bv2AnbhDZe/nJvPqsqQEixMe
   w==;
X-CSE-ConnectionGUID: GoNKti/HQ3+xn+kyGMS6uw==
X-CSE-MsgGUID: GlMrcjFBT1+zS7O/4rY8jw==
X-IronPort-AV: E=McAfee;i="6700,10204,11238"; a="40288422"
X-IronPort-AV: E=Sophos;i="6.11,238,1725346800"; 
   d="scan'208";a="40288422"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2024 19:27:09 -0700
X-CSE-ConnectionGUID: UXH10m2XRq+m+EFVu66jKA==
X-CSE-MsgGUID: 0HerrIBTRoGgTxxkR0h57w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,238,1725346800"; 
   d="scan'208";a="81379461"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Oct 2024 19:27:08 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 27 Oct 2024 19:27:07 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sun, 27 Oct 2024 19:27:07 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.42) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sun, 27 Oct 2024 19:27:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XgEU1xsg1NEJDB0oP8kNjXD74ZDCrNbGQNYgzNvvRat7HJP4aiHvKooG+YWtkJcr8UwXlD5va8rbi9R+EdGXcaSAeKHnLyJ25gd4ti5vAKYT6q6JFat8PInaE+J0zvbRpfbIxu/4s6BFAEVPJaJgZPqbauVCodKIw/xuq3yL5spGgqxexNB97CB44GWK8RjYUZfqcDIDdkuJCuelZvFNHeq4inYPMg5Xioaddax3PaFMbyF5eo2IQsOSJUTFFkHnJ/a5PNP4DU6gg1/gQi4NnnNhwkwYcJWifOBQp3MBjL1IAVG2nHNsELhh9IerY7XYrPaFqZqOY9RCnw7ZrAsfZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iKNFmWvGCrt3GSI+2QAcuH/5nnSllx81Pc7QHZwPFIY=;
 b=uTIo/LmoWDn+MwFV40wgnp8JlQoTIwWAJh76TPcMbWIZ7Oc/KNG5wvLdn452PqEhkE1TGCH5W5lBEuK1Jm7Io1U8pUrFxru1WDceU90eTBiMCecmU3vCSVzG9IEzmGSNsXEWF0cy0QOX83mpMjmd+J8P56yYiIQZIr4gQfGNKN5iuD0pXXdV7ADj+CeXmrAYf6ZPjaIIWC5jMKePeZNbRWci1sTfsLigMsg/8IVI8j9yWJNiWFxWhBdMdnI/lAzp2+JVdngF+s0b18hrFFVeemdeoYQvrluQ1SBsrIdmQCtqdqYixLWxJLUwfTL4quCHksFGVJ8NBKYEZe8z4IGWVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by BL3PR11MB6459.namprd11.prod.outlook.com (2603:10b6:208:3be::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.25; Mon, 28 Oct
 2024 02:27:05 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%6]) with mapi id 15.20.8093.024; Mon, 28 Oct 2024
 02:27:04 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: "Liu, Yi L" <yi.l.liu@intel.com>, "joro@8bytes.org" <joro@8bytes.org>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>
CC: "iommu@lists.linux.dev" <iommu@lists.linux.dev>
Subject: RE: [PATCH] iommu/vt-d: Drop s1_pgtbl from dmar_domain
Thread-Topic: [PATCH] iommu/vt-d: Drop s1_pgtbl from dmar_domain
Thread-Index: AQHbJurq5jJ1XA3D00Oc+qE8w99dgLKbc9dg
Date: Mon, 28 Oct 2024 02:27:04 +0000
Message-ID: <BN9PR11MB527626DFED59C82A35D8ACE48C4A2@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20241025143339.2328991-1-yi.l.liu@intel.com>
In-Reply-To: <20241025143339.2328991-1-yi.l.liu@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|BL3PR11MB6459:EE_
x-ms-office365-filtering-correlation-id: c171d057-b7d6-4cfa-ed33-08dcf6f8036b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?EkJsnSBEL03XHUJUtA9bO/jizHiW5WZ5Mg+Prqd1ui97wjgJGjeH2sR1Mjtx?=
 =?us-ascii?Q?MU7AMF28h3fv2KNXZXgvP24MrCZ5wPSSXbs1RcE3tp7RhUNqdhM7OosA+AHM?=
 =?us-ascii?Q?ssrdn5Y1r8fhW2YVAVTYeoZ/MR9ALm1Oh+R5AnXf4HPS0jMj06AWczEssP/2?=
 =?us-ascii?Q?n6xcBysS9ED0yo5jPWRjQHg/iVHQsnvIwR4W0oI71Qx0u7D9e7EMN+/OXM4B?=
 =?us-ascii?Q?iqmJyH/8qhyzsKmT0QkdC7UGpgktBFaKoos98qVMsAc1BVtslXcjFaf42dBR?=
 =?us-ascii?Q?gOTBKx+tnH2n1n14epY5amsiuuqtd07n1w7OdXHFRhpzh4+beNekavJonW6a?=
 =?us-ascii?Q?uCkISxrp7iieylH6dAFG7FrIpUbHifWEMNGx7Huq7fKdDL1zY//uoycjBCEQ?=
 =?us-ascii?Q?X1BjHcBTbcnm77gjXvR5k6evsf0l84q4+Dx6AW5tt586DBlpgm35P1Ung1Pv?=
 =?us-ascii?Q?a8fTn4fNsakUfAt+qaaZMW+OKK2QXErrJaGrvjSCQOYuPoeV2Jy3On9MxkRn?=
 =?us-ascii?Q?ZNprJxOBlQksY41jo8K12nX2QFUpLamG12woR3VA92MfxKpsxMS+4qBddSzX?=
 =?us-ascii?Q?cMLknucdpFUqt1/rqcXjzm0GeL7q49Q51MGxxbUIKhyJ3ecvGkZG1X/P9Cpw?=
 =?us-ascii?Q?N8cFAuwCoUU/N7gFeoqApAtbhirht8lMfTjyKhQfn+ZjN1QiHYOBNoWhobPV?=
 =?us-ascii?Q?0Y+HvIPWafT3HFS+psXiJQv45uq7f4osOsRjjeGSV7IXwfvjoJGFzcY4nUi2?=
 =?us-ascii?Q?lKVct+HIj0kHQd78fASR98RrMUMuEC01ihJDII4oZtl4hO+2MVW9DYLSwrZR?=
 =?us-ascii?Q?qwm3oOQclFJmsEsxwFEYq9h31CpJzKv9D5vRFhRJsIz/XOgOGG5jtNOUYFrs?=
 =?us-ascii?Q?Yjx3poZImQrNmLEpcim6JdewIl+uqvGhlpf1XKru9F++hDGPs2er+VM1CQgx?=
 =?us-ascii?Q?+HTIf7W6NjE32ndvQ13qnokT2R1L5qMiVvkyetyH3wWVpws0swnEHbLGED0Q?=
 =?us-ascii?Q?QJpJQtoOV90Z2iFzy5CxWEsNNudjZ+fX8umhxrpMp3ecmlIud2ZAXJ8NpwDJ?=
 =?us-ascii?Q?azCpNnicN2VnV1s7lX/5uhddjxq7cxD8fdnn50ICpLl0/i0VaeVgf8HMbPig?=
 =?us-ascii?Q?Lbn51oV2wIld2CZTCabiQEaFBUpIuyTC+OLmjNl5hL7Ljbj38BT3yy3XguTJ?=
 =?us-ascii?Q?Tevy2onUgqT90I8GyxVY8ZeFZeolpWcYnqdeyc1a/4KBhB6tfVXM4sVB+iyD?=
 =?us-ascii?Q?I5deUgFxBosxshbAlpjGLPQZoDnE6NMayaNGkFWj8alwxGDQkd8bito31Fkr?=
 =?us-ascii?Q?03tR18JF4w5KiXyyLarXJi7DJ3mHa2EAvnNA15n0oShR8jHpPk5U/dOM42Du?=
 =?us-ascii?Q?0LPwyPM=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?IdpzkDdycwGBubFOfSKlPybKXCFw5ouAlgobPP1St7DiFqtsX2DlGDN3JRtB?=
 =?us-ascii?Q?oodHNm9ldU5aLiY50mW6bZVmZsgmeCtsFZGM7Q0iJ2Gck/LNiPcElC5+1dRp?=
 =?us-ascii?Q?bynwFR1MIrTSslvWvfIrB4jaw6ouvsVN8vD04tIQciAoFL7ZbAS+0gc3uDPP?=
 =?us-ascii?Q?HKf+6Kq7tl1gNtdfxIpqjxD4hyYeiHwpp/oCNoDgz9WuAxmlpPl4dvlVWags?=
 =?us-ascii?Q?hCpr53F/PjxKE8I4fwBD90uvstGmlmtyiE0QbeClx/HE75uTViQ+n2dinsrI?=
 =?us-ascii?Q?jPNC1c36enlzIvAxyhhWd3c9tj1QMWcmBThgFVndUyprDiW4NUO+g1hicuI2?=
 =?us-ascii?Q?U2WEyM2evfK6VjN5pIKrnFJ6VmJN9u7/dqu7Si1qgve3TetBLxYybgI2B6gM?=
 =?us-ascii?Q?SE8OGed8rmT4jhKBBq9XnZdXyk3buG3dH6s+mao0RcwtqoWgN21UXLZdB/8t?=
 =?us-ascii?Q?c35qTJQPMf7QcMArORFrdlLm3Jb6sAvlgEiJrWJg/kL+mHhS5QRNmQMbfMe7?=
 =?us-ascii?Q?bQ89uWnnmDleE6XtBIdECna3oV5z/sgBuJHYGOeAkqgVl0iZnqTj1NN3w08p?=
 =?us-ascii?Q?P40bSs5REQZv7424hfOTWESZJT63nzk30O//g4FhRAmjFTlB5/cRBXXYVBCk?=
 =?us-ascii?Q?Zrn8GppLVPkGsJ872HwrdXBARQ020ir2bA0cWWNltlm5bUNAe3X9pVEPYHqW?=
 =?us-ascii?Q?5qLI0fJfpUozkV/n0aIjjdpigon5Sc4wgHQBd0QYNIl3k5DQ9MtUZVgx83X0?=
 =?us-ascii?Q?+WP6Ym7G8sYZqS8CCYFVQ5DaEaatEf+xjXGO2VgG2fG3OJlaTfZ/myNTaExA?=
 =?us-ascii?Q?WvslQu5PLdAF8MylEahC4RnFXxK+g7ha/wJHyXs5PJGnJc88Lmq23mJDKFUW?=
 =?us-ascii?Q?1gxj4oxEa+WXJD8sEg5LAczsPj7rl1KkgYTnXFKmANQedWVQaYoqOXYsC/q5?=
 =?us-ascii?Q?Sa1yHRT5kqx7N7/Ppe+Z/M+d3d6MAIWtMURirws6mQUhVMzY4e0nmPxVFFOR?=
 =?us-ascii?Q?YL1BthQxLxMNEVF2HwVx2DMhUeqlpBuurqtlxW8xL8XDzqJ+GVrrkhV9IyYt?=
 =?us-ascii?Q?j+zPNHNQQmNLQ1N+xKDmiA27HCx7ZviKYRspr26L+i462f8/XwQ0Uu+iUAJ8?=
 =?us-ascii?Q?7/N7dW1wFN5r6Bl7Qb2R84aLF/5/7dGCQvJp8o7Ty+Tv66/cDs+vWxROOIhI?=
 =?us-ascii?Q?ixfzmO8+Uox6k51CEh5VQv5JPEySP7gdJiWK4Yg3C7fWEP5F7jqG/Ar/0dBG?=
 =?us-ascii?Q?okcw5DrzQybQ8IEvlnY8wAXtIcwnsXWm2HnSE0O65qJuq8Aj/B5H8oadwH1+?=
 =?us-ascii?Q?r6tCfNZV4nKqKb8EVQ0vxo1qd4ClRFn79bp8HY8V09E3eFz6M9ovaQqeHOS+?=
 =?us-ascii?Q?YnzcKxUXWgbZ/40DnY2PZjnB9kMyCD8ZSh79Lbq4Xz4YpcsyqVSS6uATsGl7?=
 =?us-ascii?Q?NpzamCHZVgaKNxFyeoeY+8F7cQAcs7D0f5d3CdIWFd1xmdumiweOmUvyzFj+?=
 =?us-ascii?Q?LnFXvdrq6Mjs6SK4n8ycB/YOXOOLqvB64gadF+SHiOkIefjo/Xn4asFblmUp?=
 =?us-ascii?Q?0FnP6BsGvZHlCx/0/Pen55yiKjyKJhP/L7MVpnDA?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c171d057-b7d6-4cfa-ed33-08dcf6f8036b
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2024 02:27:04.8960
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JRw1kIGp45Mgt7NhxzrKBrp3+8BZIek1Jnjwkd1iT2F0t95W1EQIOQVmAThX7vjJliULMEGeNlETSYm/e//f6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6459
X-OriginatorOrg: intel.com

> From: Liu, Yi L <yi.l.liu@intel.com>
> Sent: Friday, October 25, 2024 10:34 PM
>=20
> dmar_domian has stored the s1_cfg which includes the s1_pgtbl info, so
> no need to store s1_pgtbl, hence drop it.
>=20
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
