Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72D00227EB9
	for <iommu@lists.linux.dev>; Thu, 10 Jul 2025 07:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752132754; cv=fail; b=G2FvFH/OVkjV0kpoa2fsa69hDMeqAyrshqz7Ws0nawiVNBxKzTW5hYHXY3YPRIdbRln2g12Cql9Tpstf65ha88lHM5VP65gwn+HmWV7+i4pvsWf2T62Aq06PsNV2DTvdW/cqFjrXLj+0AulGmY9XTeqZwYtG67j0itahwgZPyBA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752132754; c=relaxed/simple;
	bh=Jpi+beuX24BhHFoxz2C8XTlmdTIsU+nx7fiSD6zoIfs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZmrTtF71TjFt3rg5Tunvi5yWbXARIcyamWSioqVCUIsWaYMSDOSRpHVVTmdKAHHCMlyb0ot1maiW6a5x8W1CEl/97HKJJqTMw1gmPEApEPN6X7fHkfReFdyDpIZ3/GQmYsAUNy73+U5IvgnyF4EiJZotNZTnIEY6ogmiqzJTBQc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IkepUfS/; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IkepUfS/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752132753; x=1783668753;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Jpi+beuX24BhHFoxz2C8XTlmdTIsU+nx7fiSD6zoIfs=;
  b=IkepUfS/hR2wiMy+Ae2Mmk4mgiuqlsM+Udf1+BJUa9Sp+i5NLlT0ayXH
   DgVMK6xC6xtvcUvmDzF1Ua6778YAPjglOerWQ1cCdb0rhlHOVu2ykiavW
   R7vv/+fp7sPDgrFEARB4CUMKT0rbaDtymJoDIy5/0lRs80z3iZGaZbbTe
   EaLzbeEVr3c6V5S5MW5lKYG3T371R+YHuwDu9uzEUjpAQsdNn/S/6Cjvp
   DYeDvkKNhl59nVpDt09K+2Pp98qHg/5Mrgmu9BfdnjT9HxEsVg+RbPWat
   Hwawt3TMKdtRAcN5suvw3tEJExTgkLUcawkrTUSbg6nR5FSigEPzSuk3M
   g==;
X-CSE-ConnectionGUID: WVZqDzCQTjujAfJmMg6V5Q==
X-CSE-MsgGUID: jUGJ4D8cSpOvGZur5LkhSA==
X-IronPort-AV: E=McAfee;i="6800,10657,11489"; a="54258441"
X-IronPort-AV: E=Sophos;i="6.16,300,1744095600"; 
   d="scan'208";a="54258441"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2025 00:32:29 -0700
X-CSE-ConnectionGUID: j+eiw06wQrSN9YSAhSGOZw==
X-CSE-MsgGUID: rEAO0kIZRmWBw3nqzLy4Ww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,300,1744095600"; 
   d="scan'208";a="186998419"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2025 00:32:29 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 10 Jul 2025 00:32:27 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Thu, 10 Jul 2025 00:32:27 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (40.107.220.44)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 10 Jul 2025 00:32:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xRmZuKexOLypPK2/oHI4RzJp0dQSZujzGoHQN1rJP9sgjPA9CeK0/bTGpl4bmLtPcLBfbE+alGxpFrdjOU33CDB6SXcCbQzX+ZOQWT/MpMF8JziiYLa9ACJPQGiMMCBFPJY0lXSRJo3vaNEt71+8wgoAVFgUxqkgfkHmt1NvUUd3tTYxmtguXMHZpxTiqL8wuQoMoygyLTx5cPlLF44gIOOhAs/nLXDS2IQOCE8J0TV8yZELCQ4SuSP1k+ZG7LPlgrZVLC6KXqE+9pb9PazYPcRADiahHuKgkrJ0Mr6/4GjxzNW6dLfKm3e5NBxoH5K3t/MMhPNnhfkXXEEPvVn2RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jpi+beuX24BhHFoxz2C8XTlmdTIsU+nx7fiSD6zoIfs=;
 b=nnh/pk3WIpqIsDMEgHyntOBykIVBf+1rSGnB3cIt86kHy85KWObuMjN8+8HXsj5UCPwHmf/NhHYnMBX/bMHIXAQawxyGmymXwc2B/nPGhzPAnHNCN4KvdpixCPv/6xXxKpSgIo7C5hV0xFQHQBu/uQ35VhKK8jBVw5hR+UB/vU1hTKQpCtzrNwcOwi7vPDslIqMZauAnBjiqUlKkjTk3+pPmYoPBArl5OKNxK3vMzZABa24QIeDnudqvZ7uVzCLcr7rW/DL1+BsQjOjp0xJZBjiBUJ6ft8PUdi3ihzvk2Topeh4vSt65zf3J9fpjnUNYnqBDbmlWII7sZC5PtqKahg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by DS0PR11MB9503.namprd11.prod.outlook.com (2603:10b6:8:297::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.28; Thu, 10 Jul
 2025 07:32:26 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%4]) with mapi id 15.20.8901.024; Thu, 10 Jul 2025
 07:32:25 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Xu Yilun <yilun.xu@linux.intel.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
	"jgg@ziepe.ca" <jgg@ziepe.ca>, "will@kernel.org" <will@kernel.org>,
	"aneesh.kumar@kernel.org" <aneesh.kumar@kernel.org>
CC: "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"joro@8bytes.org" <joro@8bytes.org>, "robin.murphy@arm.com"
	<robin.murphy@arm.com>, "shuah@kernel.org" <shuah@kernel.org>,
	"nicolinc@nvidia.com" <nicolinc@nvidia.com>, "aik@amd.com" <aik@amd.com>,
	"Williams, Dan J" <dan.j.williams@intel.com>, "baolu.lu@linux.intel.com"
	<baolu.lu@linux.intel.com>, "Xu, Yilun" <yilun.xu@intel.com>
Subject: RE: [PATCH v4 1/7] iommufd/viommu: Roll back to use
 iommufd_object_alloc() for vdevice
Thread-Topic: [PATCH v4 1/7] iommufd/viommu: Roll back to use
 iommufd_object_alloc() for vdevice
Thread-Index: AQHb8IeBHfAI2AdBW0mcvgQ96XMy0LQq+AGA
Date: Thu, 10 Jul 2025 07:32:25 +0000
Message-ID: <BN9PR11MB52768CA161530E711579E0C58C48A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20250709040234.1773573-1-yilun.xu@linux.intel.com>
 <20250709040234.1773573-2-yilun.xu@linux.intel.com>
In-Reply-To: <20250709040234.1773573-2-yilun.xu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|DS0PR11MB9503:EE_
x-ms-office365-filtering-correlation-id: e2c19748-da28-4ab7-353c-08ddbf83eac9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?iDgSb/XA1WjF6vgrojZmuPSnIO/cB0Qpa0XDu04UUg384BndLjBLDeLoX896?=
 =?us-ascii?Q?9WA8Lfq/Taenot6xIA456HKc0y/gf3mUerqJHgIHWdF0SRvbN2ybdbib3jra?=
 =?us-ascii?Q?At0agpxg5zbEtSLojytAKdYB9+bEw+VXGv0GE45i/S+8yJN25iNfoxMUTMI7?=
 =?us-ascii?Q?VhlJCFXt1kXkA5M5MAn+8ISHvWJQPlzkDQxvwSvH1g8fgCtWOmH69m03Jnc/?=
 =?us-ascii?Q?fzcaQZhoLJW4nTttsInkaB/5XzpILFby44X05oaw9olQfLXkLTUidgllsp4G?=
 =?us-ascii?Q?T9V2slTBzsAmwPukj7s7l/a5DqAZm+P1J/z3Ws/86LBWaw0TvAKN2w9v+2mo?=
 =?us-ascii?Q?IUdquW9yOCIdgyuiYlHWDGuyrgaWkrnttw8nCl/p+pqunpJKuzeyvZEx3GBa?=
 =?us-ascii?Q?1jZqFaoZ/YorD2MElMzqd6zoJPfPqu0m/ShFQV0FylWsoVA2lCCjtLaKjFTR?=
 =?us-ascii?Q?Ecnui8RR80IYmO86jBWi1OXEqag0SS8Xmb+zQ4Nq2MyR3/cm+7Q6vAyym35Z?=
 =?us-ascii?Q?SSxr1uNwGsM5Us2gKBZ9c6A07zgJsa4F8dx6+MTL0QO/V6q4nzjcvNYmhotK?=
 =?us-ascii?Q?GL87U3Wij7ngPXC4t18oo3cVa5/Nkd0bB5YDaUhiIijUqb9RtFZn2ZgLvMJg?=
 =?us-ascii?Q?+TIe7LU5Bv8Mr0XgCjaJg+E/VX5fP4AYJC3VImthqBstIIxkQ7mbHEEGZKTc?=
 =?us-ascii?Q?u3M4ZwV3pLg5ufhmVdRNrEGTi/pKY8t2nxIGv0PXgctLq+cQ2+Qs6z4Yf0oe?=
 =?us-ascii?Q?0EW3Amd360CJFjbFMAaEFLFRS/xbMN62nurtbkt4/h5ZK2NBta1JEnzfotMC?=
 =?us-ascii?Q?oH0pZZJCP3z5Tg7qVLZMXRAud5w4aSeY6EHtATtDKb8ufM5ksJEMaskvr3y9?=
 =?us-ascii?Q?vrmR3gwM7KIVH6MZUR6PVQB7zXY567JqcNURjqbb4RFUcbwthX5cmdgjqyS2?=
 =?us-ascii?Q?JnUIelzeBvaVfQWECsx0gHQ1cVWPmBnQXExVui21eyoLpVac8RSRFbbJM8ws?=
 =?us-ascii?Q?D2exyUKQRkq3eAxyE5bNhr97EcMW2a2lE3kVKi3Nvs4kehBRkoKgFAXuK8VJ?=
 =?us-ascii?Q?LAuVnf1Ev2uuAVNqZjLRDbTamlGmWkfdQ/6pFVVe0Pluu7T3yyqAMjUKh82p?=
 =?us-ascii?Q?oC+a5f3PZBNtZJLZihY8oUiF82ejsMsXj95lpUG8PvQM9s9b4VaBOsZSEdP9?=
 =?us-ascii?Q?+hlAfjZv6c/Fr98evgsLvhEtWiNU9CENkBESf3FSS+/MOx7f2Svr6gZQwmRn?=
 =?us-ascii?Q?w08qHLHHeFsh+pFFK85/gmATCje0KZoFdmuZ2jS2JFut9tPu1dM0DDaFLuUP?=
 =?us-ascii?Q?T+VNY2qlWROYRyd7KsNLtOmbAPmTqb23UBcMXMs07tbwOSn2rAX+dJLYExr2?=
 =?us-ascii?Q?VF6MeUql51MKMVQd0I1Butyk8V+qw8sXYxI3vQ0zVqfM7nc2l1QF+3gHV/i4?=
 =?us-ascii?Q?6TqrmUpBAGwMixB2ltDKEWdGZ9j8ej9ztho10xDqo/ogw4uYNCqEHA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?l4hKkm5setFUxMXhsgegYBDh2wGOzjJcK8rmCaycf2Q+Ku0Pdr+Uo5yMKraE?=
 =?us-ascii?Q?4zc8PwquRtY7/kCXGOUBEtEWxbz/i8W1Fp/co6WUyocYEifmX7bRXmx1L3TM?=
 =?us-ascii?Q?xx0GQ61kQz1oyYEq6Hcr1abjU/7pVJ6pv4WUIN0ZoQ//vfz0/RFz2IdZk7dQ?=
 =?us-ascii?Q?ZxWQNI3mOzRkCB9Imfo3uKWIYB/f1uqdNcthaxS1eg/RzoQCGGBev8TN0m72?=
 =?us-ascii?Q?8SYcWgKuSugCVwf1RI9u8Pj25B2rT5d8QE4dJrL5aBoERlMyknoYcAN4cLVn?=
 =?us-ascii?Q?/AjkJwQm/fVQl/px8w1NExl/vgxjHLUWdGUe+Vp0g3RA0TsQ7nti44tQ7K8y?=
 =?us-ascii?Q?XnlX+Q2NyvJvOZ+4dnUs2ToduCNSc7CjocV3XZMXWgmOOqhtz0VL/u4AN7VV?=
 =?us-ascii?Q?DLNNtmlQ+oQ55EJleyXh4hEr2l0xke7+uvABdfdIIlgMdooMfLQqJw74TGL1?=
 =?us-ascii?Q?ljKirzK6m+0b60R4hxGAzwUuDj4dktv42Sy0jCsoVPp1TaTrANw1aMDg+ybb?=
 =?us-ascii?Q?mU/Q8QJnA11IigPesOyGknuYgmNpBgtel7x9Tar9SHgQrGi52+yK2d2wXegV?=
 =?us-ascii?Q?a6foFDu2RICZ5ycbjnyEZcLL0ZB0X8iHssDr7F/95ptG8Ft+Mor6AhILbVM+?=
 =?us-ascii?Q?LE6Oq+d+aTqMvnc/IRoPO8gxYUqf//azgXKTpvkDdpJx38NFaYoO7ORUNh7/?=
 =?us-ascii?Q?0oIxwT9Y758rVueSVKFwCFYvAB9HxuldA4icTN8jabWS12w72xX0EMDT27cK?=
 =?us-ascii?Q?o7bP5jqgAQKJ4qmtuMZGYX6wc0UErsLqy+yCk75audRUydFGZUdPEsmcjRJy?=
 =?us-ascii?Q?b6K8Ip4mzvJQ7YXes9UchOpPFnLY9vbn94wmyK2qy72uORTlrhepkW5sfas0?=
 =?us-ascii?Q?BPygddSMuJjjfr0vQ3mCyAI0m84M5tFWyD55tg3YU/zNFlohPaFecyMmY/we?=
 =?us-ascii?Q?6o69qjqTA5GdxKSq+qCTjmWNV0fxx3wa9wr4cAJDDzLJD9+nGf++SWtBVfbu?=
 =?us-ascii?Q?oDegXGA3n2DB81CSX/yNeywsDbSP0ga/4WAzDpSZhiw7SwvxIhSKcLHUOSCi?=
 =?us-ascii?Q?lHurkACnwBp9eL6rZMWPJzN/XUuCgpuyGIBkoJD0dXgrmvWy+STTeLy3IHdz?=
 =?us-ascii?Q?JpxV0wdRZxBBblZ/BYUXgPanKsJ7egA2kMldXMhhDdpLQjsiWijGfJEkdn8E?=
 =?us-ascii?Q?IB602DTYEPk1793LFV/cZEVsCM+LZYxaGoRcGep1Ws/YVh4PalPPy1E9nKAi?=
 =?us-ascii?Q?SMOn3UJTvxGyJz0H2s6obIEbgR0iC7wsGt6St+cmiRF2u5odSvTHzN+5UUfm?=
 =?us-ascii?Q?qoDYWxrI9qGpGc2fF6o6YN/7uMzHypVEbqZLIIpWav0KYAuZ+SQ8irCNqG8k?=
 =?us-ascii?Q?9hLSayMHfzszlpD925Fl65J5yg4c1/FQVnLxKfnaGEOlhxjnSxj+NJL23Akq?=
 =?us-ascii?Q?P952h5bwE3ZNata9avy6TrJHv37LlJeDKDUgMp+MY9j6K75xJvVylq6Y6zvB?=
 =?us-ascii?Q?8mmpnT31LqC/mYPUryE2HckGXpgzWr6tk2UPUqXnPxu1CymqAhqOcFe3a6Jf?=
 =?us-ascii?Q?at7z+qb9/KubCMV5CKgjsrJLZcAz/5//JNhL4cPe?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e2c19748-da28-4ab7-353c-08ddbf83eac9
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2025 07:32:25.6746
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZXjDLLIUxzmr4TasFbUlj+87uqjVk/UIV4LrAqtU4zbXMYE+LH/An+9WLwVSEIJY8p/+tyzJQtfVTo4T14EQUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB9503
X-OriginatorOrg: intel.com

> From: Xu Yilun <yilun.xu@linux.intel.com>
> Sent: Wednesday, July 9, 2025 12:02 PM
>=20
> To solve the vdevice lifecycle issue, future patches make the vdevice
> allocation protected by lock. That will make
> iommufd_object_alloc_ucmd() not applicable for vdevice. Roll back to
> use iommufd_object_alloc() for preparation.
>=20
> Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
