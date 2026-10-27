Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793117621;
	b=H1gDsgUwe5fy4ITPkJz03+ths3NagerGexLRMix6dAa4qdy+83CwUmgJErqRoV02X7SS
	 5blRU+RNo7aF2R92qZFJlR0AnyN2bVk+cDlNSw6kYKVNEL5xlNCstrXXI3SxMD71pEd2p
	 ymJYs78aAF4xL7vadPuSW39qKIwGbxyDLau9GEOEC+ND+sGOje1+xZZDlU09Uh7VK93X0
	 71adRM63csjgQ90zAlFDYu6SrOWaenZwX+vdnwsESOT9Q+GuPN1ZROjIKK4MAe+DJ0qxi
	 /3bQiR4Pl5LGchsnFG3CN6HJnXbZXPldK3EWj8rKnWDOV9f1Lyiq+wU5u4VTYAJCZCA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793117621;
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
	bh=DbOYXwK3jDLiKq22ZvlWFfEu4oKx2ipNUUZISGty49U=;
	b=fg1by6Fai5AP1qbEAfsD75x2riSDte4hJTYYnBKua3xF0epvtGU+Sm/ifNw7U5OdcNE7
	 P8yhDbM67xTQ9eN7ypzOVHIUatu5UGLEbIZRtOji0OnuOQP0Qq2d4PNiuLHQcZ97XIMJc
	 7lS6ZVgQVpqoJTFBb5lFMpKz3lt8yGMogEsVILybwaw1QBDV08RdbUm9x8ZB1Zra+U6lO
	 BlfiMwm/2mYAZF0IQM3x08OoTsjLypNpUg+6vKKmhOqj51mqAD5DH1pOUVb50FSVrGSx6
	 HoRTfJaKMURLQOhqts5MFUtxKrkjTVPpsZa6E0eTnHPiQg3ml/iY1Ufk9i84FENTVng==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=fIMUTBek;
	arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.18
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E0D2606A324
	for <iommu@lists.linux.dev>; Tue, 27 Oct 2026 16:13:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4E0D2606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=fIMUTBek
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793117620; x=1824653620;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=7ZsLkKe77Nf3tQJOKM2SkFePZPj+22Bui816QczLb7s=;
  b=fIMUTBek9+a0FSsI4M+KWXgDJCygS1/SEWemT+DcTAOBbyCwp4C8MJuV
   wF4PTib9+7xO0aXSHeQa/WRZM6DI6SSnGeU9bqv0RCK6TidqS0urdrXZC
   vFjBc51hl/GZjpiuWO60VzTIHd3UAOgKkB+/z85mZ6Kn/9MQ2C3hhX1AM
   h3ddYVM5OrCmzYCDqqXsT14glGv7CrMu/jyeq/Lbi4lNllHzmKhR9Vo9C
   J+Ndxksz9kJFR4VJ/X3mMV9b66Zl5eaSQ191vlnuSaIRjPuRc0E3TmtBv
   UCc5rWpUwARKapFqNcrHPkgErkb9FfdOCAQxfc2h48dS2UNBLkkyq0lvn
   g==;
X-CSE-ConnectionGUID: 6Pk/7+4nQb23RRU5nj40Mg==
X-CSE-MsgGUID: YKlLbvA6Qj+4fET0Ea24Eg==
X-IronPort-AV: E=McAfee;i="6800,10657,11948"; a="1853206"
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="1853206"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2026 09:13:39 -0700
X-CSE-ConnectionGUID: BEyDGukLQDOD6RWWxMJcNA==
X-CSE-MsgGUID: 0uGzH9j7RVOdvHvsM0Pxpg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="5113392"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2026 09:13:39 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 27 Oct 2026 09:13:38 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Tue, 27 Oct 2026 09:13:38 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.36) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 27 Oct 2026 09:13:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=efEmofmQjtORseetlrijafeWVOOjutv9GgKJAI7yq75NEuWomiax2gKeMSrfXSnUVshd0EahsgFx+KbzH5185SbXBUfXuCmZiLFnb/G7j30fCHlZjOjzEKVvzz2hkIKBmp1y/wvfahPM0RU7la7INyrgNykdxMSzU3tLH0XklFF5s594Pl9n7RcrPK3TGOcZ3D6zLTjorCNMZIdivEmUGVjOtB/fLFIDVgyx6OZSsR1GO/vUzIxq/B8iUOXp/DUflF+zHLfz76C3lNHqib8a7/n0NgjIinfNRZYrMrty5twOMoXDCFV4Vts9X7IbFZbZ1mLh4cVVLZ+c2Z0RpkrSJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DbOYXwK3jDLiKq22ZvlWFfEu4oKx2ipNUUZISGty49U=;
 b=II4n/6YXq+/Boc6NzEMW5jtwbdXRCTms7JbWmqj/wd4G4Jsv5Hdnpi2yMqEp7rz8elaCxFZJjh/+EkHIeqOHuzIYm1jTDIUzHVIa+hOnOBVo6M83Rdj5hVUMYyXxhZuU1qADQgqRJwZsWEhRiPghrvcK7ZMamQ6O7yg3N7cqyPTQR+orDCrB7vGmjQYKP27pMHlX5RZfS1HASDE1YTJv5MyWeoNiwia1xa3vOHmLyfV455bCiFvhMeWwK2gjBzo1nhG94Rp1pQhs7OjSqFvleEs2/og566ilb4XI3DHO3dLTTveTj5AnoAMRKtDm1AHi+pj6jgXJL6e4OHee9wISPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH8PR11MB6878.namprd11.prod.outlook.com (2603:10b6:510:22a::7)
 by SA2PR11MB4828.namprd11.prod.outlook.com (2603:10b6:806:110::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 16:13:29 +0000
Received: from PH8PR11MB6878.namprd11.prod.outlook.com
 ([fe80::1b78:2633:3b3:e4ca]) by PH8PR11MB6878.namprd11.prod.outlook.com
 ([fe80::1b78:2633:3b3:e4ca%4]) with mapi id 15.21.0546.021; Tue, 27 Oct 2026
 16:13:29 +0000
From: "Sun, Ning" <ning.sun@intel.com>
To: Michal Camacho Romero <michal.camacho.romero@linux.intel.com>
CC: Baolu Lu <baolu.lu@linux.intel.com>, Thomas Gleixner <tglx@kernel.org>,
	"Camacho Romero, Michal" <michal.camacho.romero@intel.com>, "x86@kernel.org"
	<x86@kernel.org>, "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"tboot-devel@lists.sourceforge.net" <tboot-devel@lists.sourceforge.net>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Mowka,
 Mateusz" <mateusz.mowka@intel.com>, "Pawlicki, AdamX"
	<adamx.pawlicki@intel.com>, "Randzio, Pawel" <pawel.randzio@intel.com>
Subject: RE: [PATCH v6 1/2] x86/tboot: Add support for parsing DTPR table and
 disabling TPRs
Thread-Topic: [PATCH v6 1/2] x86/tboot: Add support for parsing DTPR table and
 disabling TPRs
Thread-Index: AQHdWi0a5hgsA+Mc/U+BxcT2UNvKJ7cRpw7g
Date: Tue, 27 Oct 2026 16:13:29 +0000
Message-ID: <PH8PR11MB6878A61EA3A0B73721D1CB2E87602@PH8PR11MB6878.namprd11.prod.outlook.com>
References: <PH8PR11MB687819AC0462AEC8B83E480987962@PH8PR11MB6878.namprd11.prod.outlook.com>
 <20261012093540.1737905-1-michal.camacho.romero@linux.intel.com>
In-Reply-To: <20261012093540.1737905-1-michal.camacho.romero@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH8PR11MB6878:EE_|SA2PR11MB4828:EE_
x-ms-office365-filtering-correlation-id: 08d28941-b63a-4b14-e073-08df34453d0b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|18002099003|6133799003|22082099003|261026121527099003|10067099003|261022105027099003|56012099006|11063799006|4143699003|261009223027099003|261021123027099003|261022075727099003|261021121427099003|261021135927099003|261026140227099003|38070700021;
x-microsoft-antispam-message-info: PquMpymjZbP5b4aOPT3GyBJ+cTXmM1ftywzLrKkd8YCiPkZEGVuzWYl8ZQymlIiEEmk7niwaFJUfq+JLR7eV9nmBdfeu8lIxGd3rgpMJ/UKmTmwefKgMd6zrqOHWvtRGZfHPCThXiXJcGehfCWexnSN/Mp7LY9t78UdTFQRUQCVEdpGCimUqexAIB6Kop4BvTez1UVsHVQTlfmXfccMyd77zDq8z7j9/qrszu7qKvcydoCP+0X58zQGfw7dZ9WPfpnWgjUwrdkHyP9niQzJMrhu/kh6dqpxFm0UrZFyQNoDoGO+sWtW+HlwKniQhh7Tv3naJkqlk2/jlY4N7oQsKRaAxV4nF7oPLw2f6Q7eklYj/n7m+PF4XhiaUgj/5WbGzx8v48wOARRLgS5U9tF+crsuiavQWwUnMzRqPOOgwkCUD/Hx/5FZpDhvnxS9q3Lo5vvTqt2MzMvcVnkv2VIkL8RgQqTTPqxrstYLAdhfLvyaBdlFvMyy5C57QyzdX3Taw4NJ1ods7V1x2W2gqF++W6fd4XyyIIg2k7BX85CX2NQoKSKq+6ppJJPtfCm3p+XTIbLcSMY4kckxnMoyEm2HlWvjEcpwZC02K4Z4BNlqeke2PZraIaYBrp8eZiVpfAzE50y+OCIfA+yJLBUdh9FiW4sn/vvrz8HLa2culCyelSQI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB6878.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(18002099003)(6133799003)(22082099003)(261026121527099003)(10067099003)(261022105027099003)(56012099006)(11063799006)(4143699003)(261009223027099003)(261021123027099003)(261022075727099003)(261021121427099003)(261021135927099003)(261026140227099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?xVDfy3Bslf4/oVxNv9BVbyuGVl0dKbOxXTRKVnKHTCEKC8bFWQ6qCdmnQ9mM?=
 =?us-ascii?Q?KruoSCeVfT/gh/AB5ripmQNNjHSIKtHs3VNKbR1zSgDny6RPBd364nxRvhoU?=
 =?us-ascii?Q?74+i2QXyHCrdlgIi6J32HLGxPUUAhB+ih0KN2uB3E5OGoHcw7czfuIBMBeWF?=
 =?us-ascii?Q?4ooASXNX49bhgVC8r2wYiQ4Kvc+7DBa9oXmVg1ZmpZG6KC1VaCnUQhwdtpq9?=
 =?us-ascii?Q?1kU4VciQKNMxfnlvz+I76QJr1fD/jBRaRC1ER/uSnJ1CHAo08HXE/tFaIk7S?=
 =?us-ascii?Q?MjllnsVOL9bkrOxrJ5UOT/vLmOcotXHRKDkpZFON6XedU9JkD6dRHHKekt/O?=
 =?us-ascii?Q?Vx+7AzgRvfVczv1Ej0x1p3tdGe0fOLxcNOLn+6jUMnElz36jB9L7iLrcEIy/?=
 =?us-ascii?Q?djlrq/NIPxje0YMvsanqfBiYy1THoXGYhAyiShqbmUV9DN9De28ie8MQ4cSl?=
 =?us-ascii?Q?r2GW8cIecQhjMm9FBEKDxUCIOmIs6/iUessPy3XzM47F5QwY4wHvUlbID3Uh?=
 =?us-ascii?Q?z/EXXi+93ed8tFbRPAxNQpmxrGkmASzrBbGwD23PG8c2xptntgqENZ/InoTP?=
 =?us-ascii?Q?vN4m5gJRM4dwwdIsvozpMRed+AQDayB0lwQhKKmF/+PYNsgOyXO3lreBe1jD?=
 =?us-ascii?Q?DihpTUvaNx9fi7kgmq160PvfYKTNyHV/GTWueUY9jPOrwbBWgsVvT8R6e427?=
 =?us-ascii?Q?RGflMguuioT3WPr1zQy/MFLcmepV8ivgG7hldiQNhGmmJkSPrhRFRsMEoGPv?=
 =?us-ascii?Q?I0rqZ/LE+xMLrMZtOV9HHEZRkDzEEiMI1IycoCtnaWaWCVCz9+rPAY9m34X/?=
 =?us-ascii?Q?RWJM8U91mhxLYkZeaRvfiO+cPY+lhFthSMNdt+5NAbjIjz0eKLZZc7DZnR1a?=
 =?us-ascii?Q?j13heVByvmOylYzrNTmAvKMRtwtvWGC11pvuKHUDbT2CxzYpPlvD6Vg5ZxqY?=
 =?us-ascii?Q?mIpS9RbFAEAOTNDhQ8i4X+OoDUUly849SViLpX9klfQNo3ZMGLOwv0xKBnOH?=
 =?us-ascii?Q?adH2iJqhWlTher5Ec7tezPgHRBMtxzJd4OyNdu3vBBcZZlc3QgwVI2gcHjTF?=
 =?us-ascii?Q?hCpGtGLXQ+1SXIfP/6wfj97JWgVsoF1uVqz8JcoZ634jOebr+QdrEL0rbI3K?=
 =?us-ascii?Q?HZCew1eytNEAOiytt2MWt22o3L6uuf97qFfMMF/3INZHtLToeQzqEstpIh2o?=
 =?us-ascii?Q?7szGTCVHkMjHOrhfDF81LffQSjFOlC7hfhX5htVoRxW8M//GPnIFaKra9VqX?=
 =?us-ascii?Q?r4ax+Fb0w/mKw5E1blJXdMR3J4qBF5g3O0VdR7/2QrpE/+jFQqWA5AHGGnAq?=
 =?us-ascii?Q?nQhnkLvGBBpH5G/xf4++Ig8bJ3PM6i521oX74qJl5roIsE23e2M6zYoRXe8v?=
 =?us-ascii?Q?2zNghASpObhNyKLNg7F71DET9QHXqezWEYXrRgwZ9jRPpFrNpwGFWaTidDvG?=
 =?us-ascii?Q?DrzMy/tP3UP9ZNbmhFgWDsuGuh5mV+xQ2Bg2UPmkXuNYHriDzf8vUQ129Ocx?=
 =?us-ascii?Q?MNXQuW70Tt1anxLgWfF5r4rDokg/iQus0tQFw/QRxl8nGq2xxFywrvYUhmx6?=
 =?us-ascii?Q?A4j9HS5P8jABwhFJtldDRc9pibCtCtYdXz5l+2zxcz7GAWcThkMVfJBIz2//?=
 =?us-ascii?Q?H8rXiaPbcBeebkD4yCW8ZLlulsrsdnJyLP9zlkDNvfNfcWbYQF0eHA6Y2x5I?=
 =?us-ascii?Q?W5cg6GpVAkoTeCWg9VFSquEe14iUP5SYZ1x6WIw0AEx/HRUw?=
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
X-Exchange-RoutingPolicyChecked: ePIvrPU2IUDqpTFy6IcOamxLBug3FKiDk6aQQg8GsOOd+V9LUu7qnXQ4TmqtKbSjqmkrCEy93h+sHDdNikUH60ppwZTSWP9O3+B9einebHNRWMgvuf4J81GUp3aeCgA9odr21sRdbEcXlZviyHkiJ2Ntp6/+U94X2Tel6ug8vmDboOCr5eumYAwIvgGxHZ8FUPLRV3DlBQj6J0OTHduLZJRKbcoDsybEFRjv41Anc4Pd3w4xuq7M/ILcH0ZepmxoP2H324zbrtm2o1iq/z4pm8+GadkpW4oDXmg56U9nF1oMJtgBJKcnbHd+JsP4/2POwoBkKBUfrhtTgdT51Y9Uaw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6878.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08d28941-b63a-4b14-e073-08df34453d0b
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2026 16:13:29.1275
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SD2We8ymiWlHxKar/tYUgyQ8ZYY+sbtfHuE8v+hJFnu6PocdVJu5jkW/sL2nd3ElavPnpTYmPI2lnqiJinkFoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4828
X-OriginatorOrg: intel.com

The patch looks good to me.

Reviewed-by: Ning Sun <ning.sun@intel.com>

> -----Original Message-----
> From: Michal Camacho Romero <michal.camacho.romero@linux.intel.com>
> Sent: Monday, October 12, 2026 2:36 AM
> To: Sun, Ning <ning.sun@intel.com>
> Cc: Baolu Lu <baolu.lu@linux.intel.com>; Thomas Gleixner <tglx@kernel.org=
>; Camacho Romero, Michal
> <michal.camacho.romero@intel.com>; x86@kernel.org; iommu@lists.linux.dev;=
 tboot-devel@lists.sourceforge.net; linux-
> kernel@vger.kernel.org; Mowka, Mateusz <mateusz.mowka@intel.com>; Pawlick=
i, AdamX <adamx.pawlicki@intel.com>; Randzio,
> Pawel <pawel.randzio@intel.com>
> Subject: [PATCH v6 1/2] x86/tboot: Add support for parsing DTPR table and=
 disabling TPRs
>=20
> From: Michal Camacho Romero <michal.camacho.romero@intel.com>
>=20
> Add functions to locate and parse the DMA TXT Protection Ranges (DTPR) ta=
ble from the TXT heap's SinitMleData extended data
> elements (requires SINIT MLE version >=3D 9).
>=20
> * tboot_check_tprs()                    - function iterates over
>                                           TPR instances and counts
>                                           number of the enabled TPRs.
>=20
> * tboot_check_txt_heap_section_bounds() - function checks if a given
>                                           TXT heap section is within
>                                           the bounds of the heap.
>=20
> * tboot_disable_tprs()                  - function iterates over TPR
>                                           instances and disables each
>                                           active TPR region by setting
>                                           bit 4 in the TPRn_BASE
>                                           register via MMIO.
>=20
> * tboot_free_txt_heap_mem()             - function frees the memory
>                                           allocated for the TXT heap.
>=20
> * tboot_get_dtpr_table()                - function walks through the
>                                           TXT heap to find the DTPR
>                                           extended data element (type
>                                           HEAP_EXTDATA_TYPE_DTPR) and
>                                           returns pointer to the DTPR
>                                           table.
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
> Hi Ning Sun,
>=20
> Thanks for review. Recently, Lu Baolu (IOMMU code maintainer)- has pointe=
d me the additional requirements for the DTPR table
> handling, which required me to introduce another modification in the DTPR=
 Table handling functions:
>=20
> 1) Improvement of the TPRs activity verification mechanism, by counting t=
he
>    number of enabled TPRs and ensuring it matches the expected configurat=
ion.
> 2) Defining function, responsible for TXT Heap memory releas
>    - tboot_free_txt_heap_mem function
> 3) Improvement of the TPRs disabling mechanism, by iterating over TPR ins=
tances,
>    disabling each active TPR region and their status verification.
>=20
> Please review this changes.
>=20
> Regards,
> Michal Camacho Romero
>=20
>  arch/x86/kernel/tboot.c | 502 ++++++++++++++++++++++++++++++++++++++--
>  include/linux/tboot.h   |  26 +++
>  2 files changed, 513 insertions(+), 15 deletions(-)
>=20
> diff --git a/arch/x86/kernel/tboot.c b/arch/x86/kernel/tboot.c index 46b8=
f1f16676..c46399bbe7f8 100644
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
> @@ -223,6 +224,143 @@ static int tboot_setup_sleep(void)
>=20
>  #endif
>=20
> +static bool tboot_check_txt_heap_section_bounds(const u64 heap_end,
> +                                                void *heap_section,
> +                                                u64* heap_section_size,
> +                                                const char
> +*section_name) {
> +	if (!heap_section) {
> +		pr_err("%s section is NULL\n", section_name);
> +		return false;
> +	}
> +
> +	if (!heap_section_size) {
> +		pr_err("%s section size pointer is NULL\n", section_name);
> +		return false;
> +	}
> +
> +	*heap_section_size =3D 0;
> +
> +	if ((u64)heap_section > heap_end || heap_end - (u64)heap_section < 8) {
> +		pr_err("%s size field exceeds heap boundary\n", section_name);
> +		return false;
> +	}
> +
> +	/* Read the size of the current TXT Heap section */
> +	*heap_section_size =3D *(u64 __force *)heap_section;
> +
> +	if (*heap_section_size < 8) {
> +		pr_err("%s size is too small\n", section_name);
> +		return false;
> +	}
> +
> +	if (*heap_section_size > heap_end - (u64)heap_section) {
> +		pr_err("%s exceeds heap boundary\n", section_name);
> +		return false;
> +	}
> +
> +	return true;
> +}
> +
> +static bool tboot_check_dtpr_size(const struct heap_ext_data_elt *elt)
> +{
> +	u64 dtpr_payload_size, dtpr_offset;
> +	u32 i, ref_tpr_cnt;
> +
> +	struct acpi_table_dtpr   *dtpr        =3D NULL;
> +	struct acpi_tpr_instance *tpr_inst    =3D NULL;
> +	struct acpi_tpr_aux_sr   *tpr_aux_srl =3D NULL;
> +
> +	if (!elt) {
> +		pr_err("DTPR element heap extension data is NULL\n");
> +		return false;
> +	}
> +
> +	dtpr              =3D (struct acpi_table_dtpr *)elt->data;
> +	dtpr_payload_size =3D elt->size - sizeof(*elt);
> +
> +	if (dtpr_payload_size < sizeof(struct acpi_table_dtpr)) {
> +		pr_err("DTPR element payload too small for a DTPR header\n");
> +		return false;
> +	}
> +
> +	if (dtpr->header.length !=3D dtpr_payload_size) {
> +		pr_err("Mismatch between DTPR table length and payload size\n");
> +		return false;
> +	}
> +
> +	dtpr_offset =3D sizeof(struct acpi_table_dtpr);
> +
> +	if (dtpr_offset > dtpr_payload_size) {
> +		pr_err("TPR header exceeds table's declared size\n");
> +		return false;
> +	}
> +
> +	if (dtpr->ins_cnt < 1) {
> +		pr_err("DTPR table declares no TPR instances\n");
> +		return false;
> +	}
> +
> +	for (i =3D 0; i < dtpr->ins_cnt; i++) {
> +		/* prove this instance's header is in bounds before reading it */
> +		if (dtpr_offset + sizeof(struct acpi_tpr_instance) > dtpr_payload_size=
) {
> +			pr_err("TPR instance No.%u header exceeds DTPR table size\n", i);
> +			return false;
> +		}
> +
> +		/* iterate to the current TPR instance */
> +		tpr_inst =3D (struct acpi_tpr_instance *)((u8 *)dtpr + dtpr_offset);
> +
> +		if (tpr_inst->tpr_cnt < 2) {
> +			pr_err("TPR Instance %u has less than 2 TPRs, further DTPR "
> +			       "processing interrupted.\n", i);
> +			return false;
> +		}
> +
> +		/* all instances must carry the same TPR count as the first */
> +		if (i =3D=3D 0)
> +			ref_tpr_cnt =3D tpr_inst->tpr_cnt;
> +		else if (tpr_inst->tpr_cnt !=3D ref_tpr_cnt) {
> +			pr_err("TPR Instance %u has inconsistent TPR count: expected %u,"
> +			       " found %u\n", i, ref_tpr_cnt, tpr_inst->tpr_cnt);
> +			return false;
> +		}
> +
> +		/* iterate over each TPR instance */
> +		dtpr_offset +=3D sizeof(struct acpi_tpr_instance) +
> +		               (u64)tpr_inst->tpr_cnt * sizeof(struct
> +acpi_tpr_array);
> +
> +		/* verify TPR array size for this instance */
> +		if (dtpr_offset > dtpr_payload_size) {
> +			pr_err("TPR instance No.%u TPR entries exceed DTPR table size\n",
> +			       i);
> +			return false;
> +		}
> +	}
> +
> +	tpr_aux_srl =3D (struct acpi_tpr_aux_sr *)((u8 *)dtpr + dtpr_offset);
> +	dtpr_offset +=3D sizeof(u32);
> +
> +	if (dtpr_offset > dtpr_payload_size) {
> +		pr_err("TPR SRL count field exceeds DTPR table size\n");
> +		return false;
> +	}
> +
> +	dtpr_offset +=3D (u64)tpr_aux_srl->srl_cnt *
> +	               sizeof(struct acpi_tpr_serialize_request);
> +	if (dtpr_offset > dtpr_payload_size) {
> +		pr_err("TPR SRL entries exceed DTPR table size\n");
> +		return false;
> +	}
> +
> +	if (dtpr_offset < dtpr_payload_size) {
> +		pr_err("DTPR table is smaller than expected\n");
> +		return false;
> +	}
> +
> +	return true;
> +}
> +
>  void tboot_shutdown(u32 shutdown_type)
>  {
>  	void (*shutdown)(void);
> @@ -454,21 +592,23 @@ struct sha1_hash {  };
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
*dmar_tbl) @@ -514,3 +654,335 @@ struct
> acpi_table_header *tboot_get_dmar_table(struct acpi_table_header *dmar_tb
>=20
>  	return dmar_tbl;
>  }
> +
> +struct acpi_table_dtpr *tboot_get_dtpr_table(void __iomem **heap_base)
> +{
> +	void *heap_ptr, *config, *sinit_mle_end;
> +	struct sinit_mle_data *sinit_mle;
> +	struct heap_ext_data_elt *elt;
> +	u64 heap_end, heap_size, sinit_mle_size, heap_section_size;
> +
> +	if (!heap_base) {
> +		pr_warn("Heap base pointer is NULL.\n");
> +		return NULL;
> +	}
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
> +	heap_size  =3D *(u64 __force *)(config + TXTCR_HEAP_SIZE);
> +	*heap_base =3D ioremap(*(u64 __force *)(config + TXTCR_HEAP_BASE), heap=
_size);
> +	iounmap(config);
> +
> +	if (!(*heap_base))
> +		return NULL;
> +
> +	if (heap_size =3D=3D 0 || (u64)(*heap_base) + heap_size < (u64)(*heap_b=
ase)) {
> +		pr_err("TXT heap size invalid or overflows\n");
> +		goto teardown;
> +	}
> +
> +	heap_end   =3D (u64)(*heap_base) + heap_size;
> +
> +	/* walk heap to SinitMleData */
> +	/* skip BiosData */
> +	/* get BiosData section size */
> +	if (!tboot_check_txt_heap_section_bounds(heap_end, *heap_base,
> +	                                         &heap_section_size, "BiosData"=
)) {
> +		goto teardown;
> +	}
> +
> +	/* skip OsMleData */
> +	heap_ptr =3D *heap_base + heap_section_size;
> +	/* get OsMleData section size */
> +	if (!tboot_check_txt_heap_section_bounds(heap_end, heap_ptr,
> +	                                         &heap_section_size, "OsMleData=
")) {
> +		goto teardown;
> +	}
> +
> +	/* skip OsSinitData */
> +	heap_ptr +=3D heap_section_size;
> +	/* get OsSinitData section size */
> +	if (!tboot_check_txt_heap_section_bounds(heap_end, heap_ptr,
> +	                                         &heap_section_size, "OsSinitDa=
ta")) {
> +		goto teardown;
> +	}
> +
> +	/* jump to the SinitMleData */
> +	heap_ptr +=3D heap_section_size;
> +	sinit_mle_size =3D 0;
> +	/* now points to SinitMleDataSize; set to SinitMleData */
> +	if (!tboot_check_txt_heap_section_bounds(heap_end, heap_ptr,
> +	                                        &sinit_mle_size, "SinitMleData"=
)) {
> +		goto teardown;
> +	}
> +
> +	heap_ptr +=3D sizeof(u64);
> +	sinit_mle =3D (struct sinit_mle_data *)heap_ptr;
> +	sinit_mle_end =3D (void *)sinit_mle + sinit_mle_size;
> +	if (sizeof(struct sinit_mle_data) > sinit_mle_size) {
> +		pr_err("SinitMleData size is smaller than expected.\n");
> +		goto teardown;
> +	}
> +
> +	if (sinit_mle->version < 9) {
> +		pr_err("Unsupported SinitMleData version: %u\n", sinit_mle->version);
> +		goto teardown;
> +	}
> +
> +	heap_ptr +=3D sizeof(struct sinit_mle_data);
> +	if (heap_ptr > sinit_mle_end) {
> +		pr_err("SinitMleData header out of bounds.\n");
> +		goto teardown;
> +	}
> +
> +	/*
> +	 * The SinitMleData extended-data area is a self-describing list of
> +	 * variable-length elements with no stored element count; it is
> +	 * terminated only by a HEAP_EXTDATA_TYPE_END element. Traversal must
> +	 * therefore be driven by each element's own size field. Forward
> +	 * progress and termination are guaranteed on every iteration:
> +	 *   - the 8-byte header is bounds-checked before type/size are read,
> +	 *   - elt->size >=3D sizeof(*elt) enforces a strictly-positive advance=
,
> +	 *   - the "elt <=3D sinit_mle_end" cap bounds the number of steps.
> +	 */
> +	elt =3D sinit_mle->ext_data_elts;
> +	do {
> +		if ((u8 *)elt + sizeof(*elt) > (u8 *)sinit_mle_end) {
> +			pr_err("SinitMleData element header out of bounds.\n");
> +			goto teardown;
> +		}
> +
> +		if (elt->size < sizeof(*elt)) {
> +			pr_err("Invalid SinitMleData element size: %u\n", elt->size);
> +			goto teardown;
> +		}
> +
> +		if (elt->type =3D=3D HEAP_EXTDATA_TYPE_END ||
> +		    elt->type =3D=3D HEAP_EXTDATA_TYPE_DTPR) {
> +		    break;
> +		}
> +
> +		elt =3D (void *)elt + elt->size;
> +	} while ((void *)elt <=3D sinit_mle_end);
> +
> +	if ((void *)elt >=3D sinit_mle_end){
> +		pr_err("Reached the end of SinitMleData without finding DTPR nor END"
> +		       " element.\n");
> +		goto teardown;
> +	}
> +
> +	if (elt->type =3D=3D HEAP_EXTDATA_TYPE_END) {
> +		pr_err("DTPR element not found in SinitMleData\n");
> +		goto teardown;
> +	}
> +
> +	if ((u8 *)elt + elt->size > (u8 *)sinit_mle_end) {
> +		pr_err("DTPR Table exceeds SinitMleData bounds.\n");
> +		goto teardown;
> +	}
> +
> +	if (!tboot_check_dtpr_size(elt)) {
> +		pr_err("Invalid DTPR Table size.\n");
> +		goto teardown;
> +	}
> +
> +	return (struct acpi_table_dtpr *)elt->data;
> +
> +teardown:
> +	tboot_free_txt_heap_mem(heap_base);
> +	return NULL;
> +}
> +
> +s64 tboot_check_tprs(struct acpi_table_dtpr *dtpr, void __iomem
> +**heap_base) {
> +	struct acpi_tpr_instance *tpr_inst;
> +	struct acpi_tpr_array    *tpr_arr;
> +	u32 *instance_cnt;
> +	void __iomem *base;
> +	u32 i, j;
> +	u64 tpr_base_val;
> +	s64 num_of_enabled_tprs =3D 0;
> +
> +	if (!heap_base) {
> +		pr_warn("Heap base pointer is NULL.\n");
> +		return -1;
> +	}
> +
> +	if (!(*heap_base)) {
> +		pr_warn("Heap base is NULL.\n");
> +		return -1;
> +	}
> +
> +	if (dtpr =3D=3D NULL) {
> +		pr_warn("DTPR Table is NULL.\n");
> +		goto teardown;
> +	}
> +
> +	if (!tboot_enabled()) {
> +		pr_warn("TBOOT is not enabled. TPRs weren't set by TBOOT nor"
> +		        " SINIT ACM.\n");
> +		goto teardown;
> +	}
> +
> +	instance_cnt =3D (u32 *)(&dtpr->ins_cnt);
> +	tpr_inst =3D (struct acpi_tpr_instance *)(instance_cnt + 1);
> +
> +	for (i =3D 0; i < *instance_cnt; ++i) {
> +		for (j =3D 0; j < tpr_inst->tpr_cnt; ++j) {
> +			tpr_arr =3D  (struct acpi_tpr_array *)((u8 *) tpr_inst +
> +			            sizeof(struct acpi_tpr_instance) +
> +			            j * sizeof(struct acpi_tpr_array));
> +
> +			/*
> +			 * Each TPR base address has already been verified by the SINIT ACM,
> +			 * so it can be treated as trustworthy and used safely for I/O
> +			 * mapping.
> +			 */
> +			base =3D ioremap(tpr_arr->base, 16);
> +			if (!base) {
> +				pr_warn("TPR Instance %u, TPR No.%u verification failure.\n",
> +				        i, j);
> +				continue;
> +			}
> +
> +			tpr_base_val =3D readq(base);
> +			pr_info("TPR instance %u, TPR %u:base 0x%llx, limit 0x%llx\n", i, j,
> +			        tpr_base_val, readq((u8 __iomem *)base + 8));
> +
> +			/* Verify if the TPR base is enabled */
> +			if ((tpr_base_val & (u64)TPR_BASE_DISABLE_BIT) =3D=3D 0)
> +				num_of_enabled_tprs++;
> +
> +			iounmap(base);
> +		}
> +
> +		tpr_inst =3D (struct acpi_tpr_instance *)((u8 *)tpr_inst +
> +		            sizeof(*tpr_inst) + j * sizeof(struct acpi_tpr_array));
> +	}
> +
> +	pr_info("Number of enabled TPRs: %lld\n", num_of_enabled_tprs);
> +	if (num_of_enabled_tprs > 0) {
> +		pr_info("TPR protection is active. PMR will be disabled\n");
> +	}
> +
> +	return num_of_enabled_tprs;
> +
> +teardown:
> +	tboot_free_txt_heap_mem(heap_base);
> +	return -1;
> +}
> +
> +s64 tboot_disable_tprs(struct acpi_table_dtpr *dtpr,
> +                       void __iomem **heap_base, s64
> +num_of_enabled_tprs) {
> +	struct acpi_tpr_instance *tpr_inst;
> +	struct acpi_tpr_array    *tpr_arr;
> +	u32 *instance_cnt;
> +	void __iomem *base;
> +	u32 i, j;
> +	u64 tpr_base_val;
> +	s64 ret =3D 0;
> +
> +	if (!heap_base) {
> +		pr_warn("Heap base pointer is NULL.\n");
> +		return -1;
> +	}
> +
> +	if (!(*heap_base)) {
> +		pr_warn("Heap base is NULL.\n");
> +		return -1;
> +	}
> +
> +	if (dtpr =3D=3D NULL) {
> +		pr_warn("DTPR Table is NULL.\n");
> +		ret =3D -1;
> +		goto teardown;
> +	}
> +
> +	if (!tboot_enabled()) {
> +		pr_warn("TBOOT is not enabled. TPR weren't set by TBOOT and"
> +		        " SINIT ACM.\n");
> +		ret =3D -1;
> +		goto teardown;
> +	}
> +
> +	instance_cnt =3D (u32 *)(&dtpr->ins_cnt);
> +	tpr_inst =3D (struct acpi_tpr_instance *)(instance_cnt + 1);
> +
> +	for (i =3D 0; i < *instance_cnt; ++i) {
> +		for (j =3D 0; j < tpr_inst->tpr_cnt; ++j) {
> +			tpr_arr =3D (struct acpi_tpr_array *)((u8 *) tpr_inst +
> +			           sizeof(struct acpi_tpr_instance) +
> +			           j * sizeof(struct acpi_tpr_array));
> +
> +			/*
> +			 * Each TPR base address has already been verified by the SINIT ACM,
> +			 * so it can be treated as trustworthy and used safely for I/O
> +			 * mapping.
> +			 */
> +			base =3D ioremap(tpr_arr->base, 16);
> +			if (!base) {
> +				pr_warn("TPR Instance %u, TPR No.%u disabling failure.\n",
> +				        i, j);
> +				continue;
> +			}
> +
> +			tpr_base_val =3D readq(base);
> +			pr_info("TPR instance %u, TPR %u:base 0x%llx, limit 0x%llx\n", i, j,
> +			        tpr_base_val, readq((u8 __iomem *)base + 8));
> +
> +			/* If the given TPR is active, disable it */
> +			if ((tpr_base_val & (u64)TPR_BASE_DISABLE_BIT) =3D=3D 0) {
> +				writeq(tpr_base_val | TPR_BASE_DISABLE_BIT, base);
> +				num_of_enabled_tprs--;
> +			}
> +			iounmap(base);
> +		}
> +
> +		tpr_inst =3D (struct acpi_tpr_instance *)((u8 *)tpr_inst +
> +		            sizeof(*tpr_inst) + j * sizeof(struct acpi_tpr_array));
> +	}
> +
> +	if (num_of_enabled_tprs > 0) {
> +		pr_err("TPR disabling failed for some instances.\n");
> +		pr_err("Number of still enabled TPRs: %lld\n", num_of_enabled_tprs);
> +	} else if (num_of_enabled_tprs < 0) {
> +		pr_err("Number of enabled TPRs is negative, which indicates an "
> +		       "error.\n");
> +		pr_err("TPR disabling resulted in a negative count: %lld\n",
> +		       num_of_enabled_tprs);
> +	} else
> +		pr_info("All of TPRs have been successfully disabled.\n");
> +
> +	ret =3D num_of_enabled_tprs;
> +	goto teardown;
> +
> +teardown:
> +	tboot_free_txt_heap_mem(heap_base);
> +	return ret;
> +}
> +
> +void tboot_free_txt_heap_mem(void __iomem **heap_base) {
> +	if (heap_base && *heap_base) {
> +		iounmap(*heap_base);
> +		*heap_base =3D NULL;
> +	}
> +}
> +
> +bool tboot_is_tpr_protection_enabled(s64 num_of_enabled_tprs) {
> +	return num_of_enabled_tprs > 0;
> +}
> diff --git a/include/linux/tboot.h b/include/linux/tboot.h index d2279160=
ef39..5a5544dcfaad 100644
> --- a/include/linux/tboot.h
> +++ b/include/linux/tboot.h
> @@ -24,10 +24,17 @@ enum {
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
>=20
> +/*TPR Base Disable BIT*/
> +#define TPR_BASE_DISABLE_BIT  BIT(4)
> +
>  struct tboot_mac_region {
>  	u64  start;         /* must be 64 byte -aligned */
>  	u32  size;          /* must be 64 byte -granular */
> @@ -58,6 +65,15 @@ struct tboot_acpi_sleep_info {
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
> @@ -122,19 +138,29 @@ struct tboot {
>  			 0xaa, 0x19, 0xea, 0x4d, 0x5, 0x7a, 0x8}
>=20
>  bool tboot_enabled(void);
> +extern s64 tboot_check_tprs(struct acpi_table_dtpr *, void __iomem **);
> +extern s64 tboot_disable_tprs(struct acpi_table_dtpr *, void __iomem
> +**, s64); extern void tboot_free_txt_heap_mem(void __iomem **);
>  extern void tboot_probe(void);
>  extern void tboot_shutdown(u32 shutdown_type);  extern struct acpi_table=
_header *tboot_get_dmar_table(
>  				      struct acpi_table_header *dmar_tbl);
> +extern struct acpi_table_dtpr *tboot_get_dtpr_table(void __iomem **);
> +extern bool tboot_is_tpr_protection_enabled(s64);
>=20
>  #else
>=20
>  #define tboot_enabled()			0
> +#define tboot_check_tprs(dtpr, heap_base)   0
> +#define tboot_disable_tprs(dtpr, heap_base, num_of_enabled_tprs) 0
>  #define tboot_probe()			do { } while (0)
>  #define tboot_shutdown(shutdown_type)	do { } while (0)
>  #define tboot_sleep(sleep_state, pm1a_control, pm1b_control)	\
>  					do { } while (0)
>  #define tboot_get_dmar_table(dmar_tbl)	(dmar_tbl)
> +#define tboot_get_dtpr_table(heap_base) NULL #define
> +tboot_free_txt_heap_mem(heap_base) do { } while (0) #define
> +tboot_is_tpr_protection_enabled(num_of_enabled_tprs) 0
>=20
>  #endif /* !CONFIG_INTEL_TXT */
>=20
> --
> 2.55.0

