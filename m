Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AD7D286889
	for <iommu@lists.linux.dev>; Thu, 10 Jul 2025 08:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752134701; cv=fail; b=HxZXWsxQrMcthmiEnEpUDM+ngWK+tCbqA+x2JYNNHUGlr+/R3IqxJRUKyNmBIAC3MUfy+6lZKIcAG0HIpsJSZgAijOtB8gpFNj6wn6MlLBRIliMzktcqBKyD3siboMlOOL9jfHK+Q0mLog4S/3oUHY/WCZ+MFLR7x2aQnhEFhNI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752134701; c=relaxed/simple;
	bh=khKGmUaVAdROhOP5lh4xO/UFI9g485oFZE9yzrIn8nU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AyN0PS1FINAo/Gvaksap+BfYmYZCHVb5yrur7ZE8x74UhzCjlTmPSgUkMvXbBn/rmJq5fuHNCcbe8RIY3XqsUg6/bOg79tOVrqC57gqfxPQOLKmLpPCE3Sya+JJFzr5DCIGUu1S8Wqhv7SD/EadvV4DGskybIf1s2hakMyqCKso=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YhEVblpi; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YhEVblpi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752134699; x=1783670699;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=khKGmUaVAdROhOP5lh4xO/UFI9g485oFZE9yzrIn8nU=;
  b=YhEVblpivoXOG8xUbmLkKnuxYf7PWN53tBZGhQYQ2T8PN5cQt4sHHEis
   w3zI3sS6ccgZtF9SM9C+Bo+lXcc2PAS8f61ds01spQWjH2RPlujdknECw
   O2rAldDdiFeBYoqZKqce8iWKljMUt6qESrj6EDCIy8koieVWX68XsFO++
   GGMR51gdaPkATNe/R2v0oqo9qJeAhrSr2tFod/cTbUJNtbVDarEBJZ9mK
   VUc7gSdos9NSxW3NvxvER3V7wnJL5MVojh3tYeqlx5MFDxnIhawN0uFyW
   Egg2PVFvkvLjeqsuxH7/rus2fdFdAcabNyo1QCi7QwiMS/TpT0SjxkqCR
   g==;
X-CSE-ConnectionGUID: wlmYLqRpT2KlFGZ9ptCW4g==
X-CSE-MsgGUID: mcNJ+W/LTkKnpcIim3JNsA==
X-IronPort-AV: E=McAfee;i="6800,10657,11489"; a="54281897"
X-IronPort-AV: E=Sophos;i="6.16,300,1744095600"; 
   d="scan'208";a="54281897"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2025 01:04:58 -0700
X-CSE-ConnectionGUID: ygQziwB3Sw2plyrH9rfv7g==
X-CSE-MsgGUID: 16vcZzzxTxyBrg3TNHgR5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,300,1744095600"; 
   d="scan'208";a="156334224"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2025 01:04:55 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 10 Jul 2025 01:04:39 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Thu, 10 Jul 2025 01:04:39 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (40.107.223.79)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 10 Jul 2025 01:04:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U9D5SpDMTwrypdw/D3U9lL09qED1I5/Y0Gj/QKqGXuzK95z4oz2pXI2S/unP0feVT0KaawQPFwzmczG8NSCPWN0UXlm271k/7XeHc7KtzpYAAhzTesTRmcZv9UH2RvJIGcTLe/AKBditGmnIMkFbBGcjWc5W1N1R0HHkdvn1kPL2BMwIQoNNIPjO3+EQQ3WEkZbzAhelpwCx6CbcixU9lNbdFahcw4qR+A+mTTixnA5q81OZW91X+cmByWwjGOT+kkcBI2/OiVAa+oGWjyfzoGECCNQhYZbb4uKJNC8RIOdnUqs42hWqnfJKG0nE2+ZLx1x3H18gMjotGT5X3aHjNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=khKGmUaVAdROhOP5lh4xO/UFI9g485oFZE9yzrIn8nU=;
 b=Ia94yWpx5Os0PWS8juAbg7dj8Lp+qiDwM8Xm6fQYj0QnBnKU7xeluhihX47VBFZRqMl6tTECmU4cyai9QAW2971GY7URbeL2CUxIL9DzF49R1Gv04EKyGvJ9zyGcKKNI875bb2DkSAcsGzTVsb3LpzjJkxSKLysNoyL94Zy/FTpDIN42l9Hj2gCcSyk/poo6Z5uvABbwnWbyuFGrx7ICONA/TokeaP3yEg6HQ5dgLsgcq51IieaoX8tPBipzxMy8/tkT7aAbnV4iBOJzJcPFlz8PaocRw1ROIR7M+cnsBzfj27AlD7fnKO/aay1cRca4yPOSBsdRS/HBI6yfmvPLRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by PH0PR11MB5141.namprd11.prod.outlook.com (2603:10b6:510:3c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.26; Thu, 10 Jul
 2025 08:04:37 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%4]) with mapi id 15.20.8901.024; Thu, 10 Jul 2025
 08:04:37 +0000
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
Subject: RE: [PATCH v4 5/7] iommufd/vdevice: Remove struct device reference
 from struct vdevice
Thread-Topic: [PATCH v4 5/7] iommufd/vdevice: Remove struct device reference
 from struct vdevice
Thread-Index: AQHb8IeJs7mIqm7u7Uqm8jMEfDr9grQrAWyQ
Date: Thu, 10 Jul 2025 08:04:37 +0000
Message-ID: <BN9PR11MB52766C782428DE4D7913A3CF8C48A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20250709040234.1773573-1-yilun.xu@linux.intel.com>
 <20250709040234.1773573-6-yilun.xu@linux.intel.com>
In-Reply-To: <20250709040234.1773573-6-yilun.xu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|PH0PR11MB5141:EE_
x-ms-office365-filtering-correlation-id: 372dda57-e86f-41db-f538-08ddbf886a28
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?qbyWvwYwym7RgWD/triFt2hYCkANhoXdLQrxK+dhhjsn8h/O/jlIIDDpD14l?=
 =?us-ascii?Q?QdkGflu0La0A2Ii+LlGm2lbMszOZZ3OKp9EhxD1R2PZ/GqDFtH8CyqWr9/y/?=
 =?us-ascii?Q?ihxc2a5vGrZLa3AATl9rL5x3fYZlRzHhYIh+C05mNdLAj87zJVnbKVpdIw1p?=
 =?us-ascii?Q?KLA5XrXf3sR3IkA8+GlBTIrhj4EFT2xL1t4OzD8csJihMDVg8cnIcbvgKCCy?=
 =?us-ascii?Q?E7pg2T1Bmv5CRwTWFHsxDesexLLMYw7ireC3hMqY+fQ8z3CxgzPK8tRvV/go?=
 =?us-ascii?Q?5Y8ogpQeUamyq8nPGALdOozzQPW3wHiUllkfRXpBkKqi6MKmsbqJelch4otY?=
 =?us-ascii?Q?9NJEkf7Nj85oDrJPvM4OM3Ad+z9XpmE/YbF8iw36MxSpmsxRt6BJ7o/AK77Y?=
 =?us-ascii?Q?bGCGYpyw+XD12JOfYI5c6YSNwt0QglVQvT69AKiNREu/Uo7GwQnM0u4ILl1d?=
 =?us-ascii?Q?DjI8ukKY775pubnSvvCIhgdlHlClt9bAUTEqCu5dM/+9nXHWKMY6QIMUgNKX?=
 =?us-ascii?Q?SJISSfT6EFJ6iYd9A4IGV/EmcLExv7SP1HCVMZSQh9enGEQVc3nRXUwM6Otl?=
 =?us-ascii?Q?ZY+lPRe6x8yd0Feu+g7hbE/EIUNSygMpRlO2xuwFvQhcMC5/6rgMDlZp4F2f?=
 =?us-ascii?Q?TB425qJvQmHXyuesT9rGxa0TobO9MoHonoddfcsGoNcjq7vizMGS7na/YPjO?=
 =?us-ascii?Q?fT5y/GEcrc/kqy9mC9TQ8+c6TCPrO8eRjdgf4JihmHPTjwCw64EUlOG3snba?=
 =?us-ascii?Q?CTirN4AgXZ6Xt0Uba3LjlXQdbro016w8AsSmGmdQV+p8/etBQxKu39npjh9L?=
 =?us-ascii?Q?aY2vYGnNod8kvBp6d/SHx6JAS+jzcGATdjYwnHiIPt4SGWcmrP5vhnf0IGQ1?=
 =?us-ascii?Q?c8Y2O8ACR9hA7RelVmtDJDng9yfUthw5KVgqN1p9yo/QQuqVsg5FJ2fQORo9?=
 =?us-ascii?Q?zkrflDqqPqB0BxahVfpmgfg6SIJ/0N5h74QquV87/Kgly2CdYrwF1iv+qLeS?=
 =?us-ascii?Q?GK8rKASwlKOxm/NRhkUOBiZXSeHJ4qYcfuMCweAShf2c6GZaHURT92TNv2i3?=
 =?us-ascii?Q?iVsMhrIFAbMUaP3Yp+oyyQyOGFlLiXuk38KgqhnuJNwNgtxWj0drKIclGRq5?=
 =?us-ascii?Q?VabEtzkkWq3BSU6AKcfJ7S79Z+mw4X9RBfJ9FPnYDrU9BErD+I6PWDr338DN?=
 =?us-ascii?Q?Bx1nslceN9GgITkZjtcA4510PJPDDxDXvJIYqnF6YBYs7unuKcsQ4WXwzNSs?=
 =?us-ascii?Q?IALozOcW+/+NEwBDCx+SMdCUzAds25gqh7+MqgEBQbGQgSFYaPdy6M3hvKya?=
 =?us-ascii?Q?iH5mHRR7Cr8mQaZ6oWiH5/EeAdid5Ah+D8ysmm3m6NdDA7SHiGuCNEbLoPis?=
 =?us-ascii?Q?OKoc0FwhceHetOMsQ2MiPMo6lbXz7UUUa5vXq31e+nSBokmKkS3OGI0bXIeY?=
 =?us-ascii?Q?2URNYbiMpBZQWwh9BdY9s5XPGpRUj5GzSC+53AF3KO56dbscUKa64w=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Wk3biRpbi985UJ5w9DF5BYtsgI1EZrvt4ISkWM7Jaur9IoMlEXVUAfqX1SIF?=
 =?us-ascii?Q?mjrZVE9BE9mSEQxkl+k0kVe1OY7k29HTlp7tf3y390Qt7K12BlFPrNBTjNT3?=
 =?us-ascii?Q?ZDog+IYlr0vw7LUmTYoH2abqRd9uwVhuL4iV1bqZjq271cx/LKYXLHCt6pwA?=
 =?us-ascii?Q?yShS6sHk5+eRNdGEO/XcT7cGD0I/by7mvdnHmEUdZtJmsVmtN5yZ2vPfjjIt?=
 =?us-ascii?Q?EZpuJ25lsusCSuPn1dI97Ap+Jh09aq2KTntntkXFMU5u60dtdHKoCTEfCeAU?=
 =?us-ascii?Q?U5ajh54OQf0oi9mriSZgb/vJaqO43KxafJ3eLQD63VS+SXAb9Yp8R72CwmfK?=
 =?us-ascii?Q?WqWr0C2EJ7v+AUcD+Jvv3j995zLk9ivF9tP+i798gpOU0WHljqG9MwiWMh3/?=
 =?us-ascii?Q?WGd5b/Ffgd53CJdJcSvyJVz1tCX1jVgaE4mvcXITDwnaJJ4bot2rjC982CNc?=
 =?us-ascii?Q?Suyp0ZRiXGEIgug7QHTqwQNVAyYfMd7CXh4HtNRxIolKszq5jBaeOVBBDiO7?=
 =?us-ascii?Q?uY2xVQn3xFZD4bY8QZUYyFVL1WljY+IFak2Dxgvgy0ue6urG5wU4PcDKerKg?=
 =?us-ascii?Q?iEZ9kA5OpGjQ8YzMeH7tWDypZu9HB7W7ySTLdTJFThbsxpSTkJAQI/6+iUd3?=
 =?us-ascii?Q?js46xHmlS6m/3HrIrHWInlzWoFAwCcthEiwPJjfWj/2uLC1PO9jzJS1OKqDu?=
 =?us-ascii?Q?RxkGRNOj50UJokle/t/GiN+CyWYkN6zRbBz7ddoCI4O/PS5j91kGwG2kFgbu?=
 =?us-ascii?Q?aA7WQqmNFI8hy65Y0Gonsap5U5XfWjg5Km+GsBg0hA49QcgZX6B4dI0itp+k?=
 =?us-ascii?Q?Zn9mpAbcWZ/V0ZUTQOhTObG54NkmZGJCvn4dHhSBYNEiuXv/5JTjYSZ4R6wJ?=
 =?us-ascii?Q?KEdw37rEkXZKRpOTroFU6J3GXu0qKthd2LuprD16r/Flk2/EtEE4Ps/dEXDv?=
 =?us-ascii?Q?QGc1Fi1kGPNNDBM6crU2C+Jc8Z6PupFlo8HvXftHGVpyqGW7u5Mty7iczq+Q?=
 =?us-ascii?Q?VQZKBLGfss3kNNoUeu4AsNc44oPkJMhWhtA8VPo3uGWZln2vQgSyYSEtmOxX?=
 =?us-ascii?Q?PLHfVKQyezjMGdh9nTJcwUmWEcoWjY9b9XYPLNaXKH1/Vyu7ft43YD5jhiyX?=
 =?us-ascii?Q?kjivkPSC5EthqcO+SofJv1/nc2/G8nerNx0hzhPevLv3+a4pdDqU4gHH8TRh?=
 =?us-ascii?Q?9E1uK19IkYCPYcyVWSCCjzhJRs7WFdqMO0b+WCiVmoK+xDnjK3PcclH+JQUo?=
 =?us-ascii?Q?Ivz4BSFsz8VmFl+IasOnLYUe9FjHxIYSgrJIe8ox5xOHbt51ZsyRC3gu35Vh?=
 =?us-ascii?Q?Dm3TAifvSIfJt58lwM65gGeh17YJx4xHm/VVMi5CVUQ9tLGD0n7rdX1ufeo1?=
 =?us-ascii?Q?uCvEFV+F637TNs5e6m3fSp2Pe7FMS7/Zt4JXyC69YjzD6SBrlOhfkJ0bZmm5?=
 =?us-ascii?Q?bZDKyZbfSP4rkRa1uVmGDzjpOFOYppZrz5gCm2FCBcn8IqcKFBRSuE0+H24I?=
 =?us-ascii?Q?n6nwgCU6K8E+AoxUuPVrGcNePxmRbqiCo2U2zr+k6t6VoFcZlE+XH3j6VCik?=
 =?us-ascii?Q?zBox2dJM8wLIGY5jvKou9h7YoXW+D/DyHJYv2PbP?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 372dda57-e86f-41db-f538-08ddbf886a28
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2025 08:04:37.3411
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iDRfnbZFXMUXqUo+yk4muuCumKhPzFWb4EWYoi4nKKx4Satdu+J/mQUklZrPLPQxdQTHGCtg72wNIh7/0pIAWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5141
X-OriginatorOrg: intel.com

> From: Xu Yilun <yilun.xu@linux.intel.com>
> Sent: Wednesday, July 9, 2025 12:03 PM
>=20
> Remove struct device *dev from struct vdevice.
>=20
> The dev pointer is the Plan B for vdevice to reference the physical
> device. As now vdev->idev is added without refcounting concern, just
> use vdev->idev->dev when needed.
>=20
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
> Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
