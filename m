Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.17
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793258769;
	b=KJ/tMCVxEeu+/5toUe+i0t8ytFDWHNBeWdlwlUxiYuipTFdLypS1B3qYExZ3q+SOLA9i
	 3QsFl1ZNpWn3vKNyJ7z+nzFsCG3ecelr6c2p6MdiOrPZCTreD46xOXXka9ivRE234bv1F
	 0F170UW2zGBE/aXHOKxCilC/yynLM3zZyBohPOdRBceTj7xFNw98g8KmbTGEcIKZIky34
	 qCd766NDd6UuE3qzdq7CStvFXGdgi8ceUiDJeSjw/NfDWtZFEMvH8rS1vzQpCX7OPNv3L
	 DsKlO+oGqM5QMRoDMf8LAiHM6itDyllJGgS8JXho0AvEaY2cQ/hB2JpBNZEjcmQOf/A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793258769;
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
	bh=0ePp5fcX2k79cncfPcgjWA0MW5OOgUEze0Fy5O8tF9c=;
	b=X0CZCpVzXtRhPCNKx7Z8rQCn4yK8zy/Jvz5zGLu3dP9KgLmckx+hs4mofNBF/pE4e2B9
	 EceaCoQAbhicRi/mpD8RvG8kDbNH9Hh0K+2AoC76szzZPdRliXacM6efWwkneqqRTuYL4
	 OewLBERt2zgxMAsibMtQzR3WoNL+d1WrQTSvnxMW+yyYY1i9XJuwVSuDpMDfNU++y5L21
	 lR7r1Ept/xHR7+liBUzR7Da9joY/w7PIYx1Qa63GZx3qvjglQyvQe1wxTufTCgV7puFz1
	 soAQwAlp/MVA5DGVsa4exiavPOR93clNQAaeHG0cZ95nYU0hgMKG1+wTjji3UgNpSvg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=DYtqEImY;
	arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.17
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7458606A33F
	for <iommu@lists.linux.dev>; Thu, 29 Oct 2026 07:26:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E7458606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=DYtqEImY
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793258769; x=1824794769;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=N/amPsVvFxTi4omGbFrVMVrS0TLWSLqCLH1y9NjAdT0=;
  b=DYtqEImYaRUSRBtAN6PW53h1F3F85FQoXjWBJWKSzmHl9uFfJ2cYrObF
   tXSPBGhRMAErgJN2AON/RbFUC1QUXoN2T1D1RovHxUUrlkEOIusul2vRh
   ewf7xtAAfgwT2Lxjgi5fPp15whUDPuLFdMpnMefGgDF1r31OdMIC9/3fS
   n+yaoH17VhPODXvSk2A6iK8fYCYgf0Pu6O2c7KIz8uKImr9MRVeFtR0sJ
   3c+cRjD7lyfYEQEs2wyo9dncElvJKb/InIWtk/wDWd7LwcNnzhLpvDIeu
   qbAc5bib2VLyZY0MoCd1EhmZcft074fWWFcBlV3IEfkhwqafc/mKoHRP/
   A==;
X-CSE-ConnectionGUID: 5nbUTEjxQdWyaazSyVa2Iw==
X-CSE-MsgGUID: Zljm4cX2Q3uW5/QHFSpD3w==
X-IronPort-AV: E=McAfee;i="6800,10657,11949"; a="2010182"
X-IronPort-AV: E=Sophos;i="6.27,184,1787036400"; 
   d="scan'208";a="2010182"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2026 00:26:09 -0700
X-CSE-ConnectionGUID: 7MIx+gV4SEivaRL/4/O2FQ==
X-CSE-MsgGUID: KRHqxLJdTfmiffeQNs3SxA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,184,1787036400"; 
   d="scan'208";a="5152261"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2026 00:26:07 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 29 Oct 2026 00:26:07 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Thu, 29 Oct 2026 00:26:07 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.5) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 29 Oct 2026 00:26:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hAOmrr3DT4BzP1pb5xrV0rJSZBRIOp642HMtOBikmOwDULSmuMBFLgvEqEFYp1BKIb8bFp98zBqgF7W3gvva4sXFX6ahe2p1xXOL/W6zH3sEbBIv16kO+0TeM876K7Ewuqs3IFvVm1NtP5H3L9bejRLh/2H58CnKVt+jkQP8t6wdIhnfrOZuMQWR19ondSEgEqClLrNLZI//zCBP6UhoYCzVDVuj1uBEFYecZ8tvAm620v7wGQFIfF92R/K6BiL1tZihGMjb3PHxiIWg5hlruBgp+J/r2efdqVJTmZgQuXjrWGuqYBGqy7NQcFmOI/3ZF5haOEjXrK9C0K44FVnyDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0ePp5fcX2k79cncfPcgjWA0MW5OOgUEze0Fy5O8tF9c=;
 b=VW06CP+RLgzS7JXvIBAvuvDJEMH1CIcfLRFYzgQXy3/Rl72rKzYO0jazypicbbtqUXJ4nDNJK0FdvhxftZrzgdS+jxcHA/zOozhdTevtJCEfu+eyxJKc40/M5SyMhc+s5tYyUKNAfUnpB3F1NbXMOnVvln7/pIDsJnYNfsD6JR5JygYy5SqVGvJjJPMPQAtkl9995bGZAqiMDMPpvdNutjQHv90gTlmWTwimWTSD3m/oB2ftMC/QuDxH56SYmOH8eZIyWpYUvd2JJouaGHWQJOl/GFwdvT9Qu6tyCDb13E21XeUT7NOQCtaL/NY2b2TLY/dhy4MW3wP2J90ek9zIfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO1PR11MB4835.namprd11.prod.outlook.com (2603:10b6:303:9e::22)
 by CO1PR11MB5203.namprd11.prod.outlook.com (2603:10b6:303:98::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.8; Thu, 29 Oct
 2026 07:26:05 +0000
Received: from CO1PR11MB4835.namprd11.prod.outlook.com
 ([fe80::d051:d948:c209:9225]) by CO1PR11MB4835.namprd11.prod.outlook.com
 ([fe80::d051:d948:c209:9225%6]) with mapi id 15.21.0569.008; Thu, 29 Oct 2026
 07:26:05 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Nicolin Chen <nicolinc@nvidia.com>, "joro@8bytes.org" <joro@8bytes.org>,
	Lu Baolu <baolu.lu@linux.intel.com>, Jason Gunthorpe <jgg@nvidia.com>
CC: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Jean-Philippe Brucker <jpb@kernel.org>, "Liu, Yi L" <yi.l.liu@intel.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v1 4/4] iommu: Unpublish the old attach handle before the
 PASID replace callback
Thread-Topic: [PATCH v1 4/4] iommu: Unpublish the old attach handle before the
 PASID replace callback
Thread-Index: AQHdUFzgN98AomkIfEG6gm1e/sqJEbcUTL6g
Date: Thu, 29 Oct 2026 07:26:05 +0000
Message-ID: <CO1PR11MB48359CE145332CE7F647B5AE8C6E2@CO1PR11MB4835.namprd11.prod.outlook.com>
References: <cover.1790718296.git.nicolinc@nvidia.com>
 <af5be72574fff8c81c2c199886fc67b688ccc3ba.1790718296.git.nicolinc@nvidia.com>
In-Reply-To: <af5be72574fff8c81c2c199886fc67b688ccc3ba.1790718296.git.nicolinc@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR11MB4835:EE_|CO1PR11MB5203:EE_
x-ms-office365-filtering-correlation-id: 779c1894-c022-44b8-65a5-08df358de4d3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|38070700021|261028144727099003|56012099006|4143699003|11063799006|261009223027099003|261022105027099003|261022075727099003|261026121527099003|261021135927099003|261026140227099003|10067099003|18002099003|22082099003;
x-microsoft-antispam-message-info: EZfalindGyvsa/314E/ljRPx5n2mNYRbM4RXCibr3M2U7gXdkGI9mG0K4Q2Jioyl5RYGa8y8x9FFogqkE8phk8fZZ3L6GN6EOHt2bwE0bxSfeT8h2+bO5yzzfwHmamaID/DoiIsMXKLVXdaT8rrUZv1u1l5O5edmdymXHneYOXMoMb+hfdbeIpqYrzT8mUB8Mv+Ja6meo90TZ1giivln/9dyh9nH7WaaDIpe6RMAtXdpRWnJb5zqusbsWOxt6FOBquinT+kAlayozb40HdCjsXcbIKrO+Da3drZrwFKBZOBgWmxl6BRV/mk/L5UDxscQo0ylticXYWizmduzQpV7RyKgUStTt/dWSc4qv4KwYTTtjynPTuFMKQYi50sZX0zPve7E0v2JOK40aCefgBZZ0jN3k6Vg54FEcDB7gdIwgMeNBH8BnJoGAoMbyyKLXutMB6tsClRGJUmBAVweiBxH+5Be3rorukqhp5sYgi9nHwGRZRlmbW8UoauJPfngY0fEAse7FwpHeb303m1aosr32SIo1ePoDPuliluLnb6r0GSewO+eVF4HKVyZWl9e4x1w/dK0TUQBn/nod95Um5WGQg6rQbchvFZMakcV966Qtn9N55yOfm07yaOZwm8Bq8YGXnsHtpDVhfKbjeG28njH8v0TmCSZth7LW9fUhIEBMqDH188wypI0a2B8blgveQIMbT+GvBIOcpQkzaVauz/HUxK9UsDtdWoqHphcC9d+UKo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4835.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(38070700021)(261028144727099003)(56012099006)(4143699003)(11063799006)(261009223027099003)(261022105027099003)(261022075727099003)(261026121527099003)(261021135927099003)(261026140227099003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?5IUe7LbQulObNCUoMwMiS5KytvtmdbeAa+iO7O7PvYjM5+tdzLMFqgNY00Ci?=
 =?us-ascii?Q?NsHSGxQIBJhDRYBFXl82nb2BOV/ncmdDH/LvTFCYWRejZW7cCd7sIzc1t4Lo?=
 =?us-ascii?Q?TbGsdiokKEi1T8LtC04w5VANB7ufPtnwYM88kqm3ZsQ6p0e0byoI6HOJq2tL?=
 =?us-ascii?Q?2edSm6gEOwnqG31bHWgPtigAEQn7Un/EI9y7kQ5tiXkjvg8fiCuq8m+KW9h6?=
 =?us-ascii?Q?H/kxLxPWTVn4NFtML3SZFqzzwEu/mWJjHzHsw/pjmsiDY/gCvARC/KDYn5ni?=
 =?us-ascii?Q?C440EZSqvdueRyJqeK8RvnqYFI3rWcSy+k08AEdlptV92/zw2J669RIjXSvp?=
 =?us-ascii?Q?nybjL2Z3ZMclOCbqq9PgWtXnwAS+3lJQhahyPu5qKB6dgDERaqpvAnDXQggo?=
 =?us-ascii?Q?PTw3lU2Co+zKpV+G0r5jZGoiDqlH3u9KRZxKmyp4FeH7l7zVcJ8m1cbdbdFa?=
 =?us-ascii?Q?xCOYtjsOvHljf8HK0nUkvAimaVhn/HV8/V7vT45RPcWhT+Xbrw2mZHtOA5Ue?=
 =?us-ascii?Q?/e4XGLhr0aK0POnrIBgVuuvw0BkVQVZ3Jb23pcbDxlq0OmNRXG/H/16dqO2T?=
 =?us-ascii?Q?rusEOo+9cWDvCueWrcEqKQxJUY/GeckotNrdn1VTiLKeIV5+viXRdFACHUDi?=
 =?us-ascii?Q?xF3fwQOrXUqskqgef7OC4WDilrlU92y6iUMQ7UmphxhImoh36NT0jZCwil05?=
 =?us-ascii?Q?UIZ6YAdc9vcXmN9c+r+6DG5LWylzo8/v4ibsJSMbgoeOJHEOwRcskQTUaWsG?=
 =?us-ascii?Q?Co1G5k5vQSuAR6BPN8zHP7jKa16J2ABG9MyaN1keiLDWX3FRlVMXn9GbFXuo?=
 =?us-ascii?Q?qPhNstCGy6SPpNxxszanG8nwPQEvNcRmUXE1ZvSLaizop9yox9LdS+BRXmWW?=
 =?us-ascii?Q?8L6WlCr5DHsUfXwhdkRkSEq77BPuzeE2RvKakwSeTA5hgacSKoBYtixhwg42?=
 =?us-ascii?Q?I6eACfoRTGHBADGcNfx/ObxLEpoMK2pKI+qPp3VZ07DMjpQPBdiRYBvoH0HR?=
 =?us-ascii?Q?GagD9ZL6/JfWy/LE1EvlEd52s88PrCcgvdOu+zJ9XXuCOW8V54ng3nyPgdvi?=
 =?us-ascii?Q?EWNfmHU/oOD7Y4FMDak9StOfe+LUqYcrDqxgaoC7kqsqX4NW4zLEio9EWgOz?=
 =?us-ascii?Q?nl4YXbs7n9rpX1TcUqu0HPSeSZwpm+BWzurcbwIRCF98WHuvr82YXTSjAHqD?=
 =?us-ascii?Q?pG+Yp72ZvkThFIbkiol8t3khyquBYIYV7mlVnKMK8pp+bPgWaOI4L5ADB4jp?=
 =?us-ascii?Q?JmG4t84BCYppjvl4tcq6AIkUz1GO/NK6eUx9VjLVijYNCCtxACEFuEDVID8f?=
 =?us-ascii?Q?+0KV1xB7Ob1m8YkGUKsv+jQr1W01a3aJTCnQlpIkl0JqmfnKE+JEQX6DisLJ?=
 =?us-ascii?Q?ttc5IxdcWWIKjbnuL+svHVZ0JMQurXynmjcrbvExTqXCnjarcLA34OZtodPD?=
 =?us-ascii?Q?eVnNUNA7dzXB4UkIxNd5rfLjbmLzZm2wjSpnLZxyGmanrSIgmb+F4POPfSjQ?=
 =?us-ascii?Q?8RvjM4XVaFXH5QIW5wz5wQQK3GS63OS10xHeL2HVkeV/zt+JGiULS3ADbcqi?=
 =?us-ascii?Q?YgC0K2WPsHNDzT4xnvlrwra/pEIf87/vTWw0HNnd7mTjKXVimyqRWfMHvZdy?=
 =?us-ascii?Q?UHVakHRNxQuzufzcgOQD4wzJyCEcRjfkQDzTiUo2MgwgnmDHd70OldbkJQZp?=
 =?us-ascii?Q?uYa4oPKHDcqte+uMXrcgUEJaL0l8YayXPCkNTuEHyqQlRtOs?=
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
X-Exchange-RoutingPolicyChecked: fiKX/bEhVlc8Z7NnboD5Sv+utntdan5l1hvHQih67xJ8UntK56Z88ZvJAYa+EEBq5N0s38IjLtM96zqUiWaDOdksi8L1lBqawmb6dA0zTk9URp+DaGRWAuReEYegTUBdUzHFpX4O6mkCkRlSwd78TP+az7wbAIJVzw28ZSL6AQeZMlbC2uXIh7O7c8Wz61D764xK3+cr+raJXZM9jILMwL9ozCO8LzADp4/ev6lcVx8W1WqhDxsO5slsWlWXLCLSQKwsAfPfzI/KPZ5VQ4i10du+zDm+bVqAPAHcknh5PAK+k2sUnbC4xksmLsXT7e9tbmZbECejAhL7uAJHExpUEw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4835.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 779c1894-c022-44b8-65a5-08df358de4d3
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2026 07:26:05.5032
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 77UIr2r3GMZ32dJLiPZ8hBxD0rSLdYjDD8D03KKGp8veSc2aaixwEIrZZnsD8tJsoUBgP0odmgtgIATlcBTPhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5203
X-OriginatorOrg: intel.com

> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Wednesday, September 30, 2026 5:52 AM
>=20
> Similar to iommu_replace_group_handle(), iommu_replace_device_pasid() has
> the same inert reserve as the group path and the UAF window:
>=20
>   core, holding group->mutex          fault path, no group->mutex
>   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D          =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
>   xa_cmpxchg()                    ,-- old handle stays published
>     no-op, the slot is occupied   |
>   __iommu_set_group_pasid()       |
>     driver attach/detach ops      |
>         iopf_queue_flush_dev()    |
>                                   |   iommu_attach_handle_get()
>                                   |     reads old_handle
>   xa_store(new entry)             `-- window closes
>   mutex_unlock()
>   kfree(old_handle)  [caller]
>                                   UAF: old_handle->domain->iopf_handler()
>=20
> Store XA_ZERO_ENTRY outright, just as the group path now does.
>=20
> Fixes: 8a9e1e773f60 ("iommu: Introduce a replace API for device pasid")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
