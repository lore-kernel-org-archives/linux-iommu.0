Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E322A487BE
	for <iommu@lists.linux.dev>; Wed, 23 Oct 2024 07:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729667815; cv=fail; b=WXYapXNcKGjqiNJ9pFDDskWijMDnc+6lbgIQm9PfWE/1NlJ8juWKzBA2g7ESNu5Co/OL8mRJ2KJ5jNsSXK4TxaleNrlGoROSCWVcLkbG3vBm+LWdqXgQ7MFNflZjg9moer3qL1rfDKY7mJ3B7dS3Q4SwmhHQjICPZtFQgVxEz00=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729667815; c=relaxed/simple;
	bh=SxaU7gIhOd/3N/oVpstGUGII/pXxSQ9H7G723Vn7DDI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uLc9GeHY5LZN5BAepCfTF5MRwEOG2yyqPXluNg5v8iVIcYCNnY8V8IMdOOL5B2E5SsgIn5a0L2NuPhCdNua2X+ZlBm2vfhhxRNqrXjgwMd7MwXn4RAG2NFFEJkrXQl52hoHuPtdnxwkXkLxygDTgE5KvD4G/KKXt5/cuzPEiDhU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Myc/N57F; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Myc/N57F"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729667814; x=1761203814;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=SxaU7gIhOd/3N/oVpstGUGII/pXxSQ9H7G723Vn7DDI=;
  b=Myc/N57FL5mZ2HX2L+AwhCqci+KaIF1ujbFwkdauaMGPFkYxVOWnnDe5
   yUkKNjyHFEQi6rkC71EfsyBf4U+U3HsNuwlURvOv0lkSnug+NwCDFcqEi
   a5Z1+KjmbzyZX96Wwa7Pl/q/x5qrp8wAqM6s01M1S2Wm9CxrEPJUPmBHM
   BRNRnbaX+d8oNvalHNjVwKUf8p6JPFGLtjPkpj7oX+cBD7MJt2JG11vAv
   QD7zRlwxvnMnfivjxonslkeEcuFfZOcikIXRe/JVsKTsnNN0VuEEOEnwj
   kWXLQgaeICPXj0tvS4sMoKPhW/mPhQHKC1TMO8KgU1y7q1VCFLnCb1qz1
   w==;
X-CSE-ConnectionGUID: HwOcQovJRnmHL8Ht3bZzWQ==
X-CSE-MsgGUID: qmTVZPP6QoS6rz0Eia66Dg==
X-IronPort-AV: E=McAfee;i="6700,10204,11233"; a="28701101"
X-IronPort-AV: E=Sophos;i="6.11,225,1725346800"; 
   d="scan'208";a="28701101"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2024 00:16:51 -0700
X-CSE-ConnectionGUID: fX9jT4HAQTuKH/5j+Tb95g==
X-CSE-MsgGUID: Yz5UyJZhQYat0Gc6tY19lQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,225,1725346800"; 
   d="scan'208";a="84695972"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Oct 2024 00:16:48 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 23 Oct 2024 00:16:45 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 23 Oct 2024 00:16:45 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 23 Oct 2024 00:16:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BquSmhMpEoKkq3/E0wUGnqf4h8PExIMUQBXA5KOKyfNvjazJLcFfKYniPbXJmxGqEVyHN8aWvEBNccEQ8r7HR2AN4PattBpMhWrNgWl/1JHC2S00VTGfq0VaIgQXXcvQDuJc07Da9pxfbszF4j+JHP4y7sS3AimrAFRaigJlB7iyT4mgOd02FrsPEdNIJeM+0289qSM6gS+5J4kz/TlI4euW3U5hS0K7qkJno7R5b70EG2J/+OPHVEWYfWenmrmuLAGg3Qy9KreaINX5aJHxN2LFCtVYMoNKv6E4A6odbIedT3rVCMQwveuJ53I+y0ogv2Qpdt5r+1KwjDiXPEaNqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8LovFPzq930omiW5H1lzfi3NuZb2YKIiiD7qmKAPJk0=;
 b=TZTaDaw/sKz8NXaDwTBMrQAJn/P7FlWlwLtDW8PPvzu+fmV0uiWSx0QFrhQ4WwKPRbTRMM7zgC/O9np3KAxG0kyATLVXYol5w00Mq0Cp1+95FORgKv60STstm1SEa1zT+Y698crnrws42zdu92rqwOtVA9+EoqjlmppmezIxUXATRD37os4h8Yteg+8xLz2xofCEc2MJpTNgqAIJ32GdgHDW8I9FfdLHF05hj7EvDO8Z+VKmhzWruztkrAepD/kmCelofAd6+vnJ3loa5mSfOheO1YbPuA2TIviKVyDa/G4hlDeCNe+wePrJliiM2S5p7GzA9rmA1iupnWsQngtkew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by LV3PR11MB8579.namprd11.prod.outlook.com (2603:10b6:408:1b6::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.29; Wed, 23 Oct
 2024 07:16:35 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%6]) with mapi id 15.20.8093.018; Wed, 23 Oct 2024
 07:16:35 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Steve Sistare <steven.sistare@oracle.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>
CC: Jason Gunthorpe <jgg@nvidia.com>, Nicolin Chen <nicolinc@nvidia.com>
Subject: RE: [PATCH V5 5/9] iommufd: folio subroutines
Thread-Topic: [PATCH V5 5/9] iommufd: folio subroutines
Thread-Index: AQHbJMWJ2Ao8SRUSfkq0gkDLwqJNfLKT7M9A
Date: Wed, 23 Oct 2024 07:16:35 +0000
Message-ID: <BN9PR11MB527641B55F04B191432A4A928C4D2@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <1729630838-24586-1-git-send-email-steven.sistare@oracle.com>
 <1729630838-24586-6-git-send-email-steven.sistare@oracle.com>
In-Reply-To: <1729630838-24586-6-git-send-email-steven.sistare@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|LV3PR11MB8579:EE_
x-ms-office365-filtering-correlation-id: 9d5972b1-3e43-430e-8c00-08dcf332a123
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?43SYD14K4Rs+PhmPMO0VBiXq+Sn1r2+MkzUCmfWEsnqypQ7tTHWxOot+9cW1?=
 =?us-ascii?Q?U8gDzPugpIi1UHoVHQI2jMDDcWX26IF0SoBIkBOZMUEybQIYnmeLzlOcBJOK?=
 =?us-ascii?Q?Pnb3ygUj6IYxuTzJF77fno8opXKg2j3fYIbZNI+g/AelcuhdoqmxIYgy3+r7?=
 =?us-ascii?Q?xvKPI3o/SzoB2S5YmV/Pt//vSkxIdhvbCoMW11pCFeE5WcWWS1idQLk+zcza?=
 =?us-ascii?Q?pOfBIYh4PVmLu4oy9NiVpf4k7YOIrv9fJe/voDjaOWwPV2bgxUXygXv1dRbu?=
 =?us-ascii?Q?YIS977MlhgJpYcNFw+OWNXE4BfeZTEgb+YhWKJFNzlX8JBYZRVYCtXuNfMoQ?=
 =?us-ascii?Q?9iYvS9fkfvdbg++zMEkNdxKpuP7w/TJpXYT1PywLkUeZPGq7bWSs3yHg+lt1?=
 =?us-ascii?Q?L2/8Cshm9Zs5vsyBnBwWXXR75v63xy0pIzkMoeX1Hjxk9M6vulf4VqYD18Xr?=
 =?us-ascii?Q?NCSuCJsspfbLI949x+7IAfggIlpBSy2T+7UI76H3Cl7CeNGg8SAjd2hVfzDP?=
 =?us-ascii?Q?eoOQpu4TFV7uBwzCGy0KQgRUh5P6nBqlwi9gdI7tCv+4lMoKO1B6w6fLm6Kx?=
 =?us-ascii?Q?vCs/Mo2wUol9X8BGwY4LjxPUV2fNjdN6YuZKeiP/hbyAR/L16qjmOH3RAKUS?=
 =?us-ascii?Q?7mw9QWkmmBapldh2OpcRiOPJVlvluox7RFGKIc/j/BeR3J4A0i2pz5EkKAhk?=
 =?us-ascii?Q?4LmcLAP1/yDz7z0pfXKfdC3z+A0WewKGU9ID6PkzDNjowRB/WhM93/D3aZRW?=
 =?us-ascii?Q?avJo0HF8QSmN7SVTNs21xx6HYHHtBFAS9xYvlFzrODzP4t+pzqqqfa1ZeZkq?=
 =?us-ascii?Q?v7hO/GPolxutY2sSXjC1YRlRyhKN2ycnE/SU4JYpyYEPU5RPRKtmxJSOnn52?=
 =?us-ascii?Q?8QJX/HV72341PVVzXmZnP+wF0YgSO+SDoFqnwFymMQg5nBw8piq654KfI8lh?=
 =?us-ascii?Q?h3Mp52sYc5kXVqTsGWovbQwTiLOqoa9TK1S2wmMGzkbyOKS3mhDxyB1PEwgo?=
 =?us-ascii?Q?D+aAT97rZ5o9n4fFdeMCn3T5RGvmBLCxZPIzfZnUxERzkS5BUk9DJBETTcE0?=
 =?us-ascii?Q?jSbNH57aXx4UcMAmioyMjHLY59GTcje1/I9+YdJsIyz+YyeGZl7aUjcVlM09?=
 =?us-ascii?Q?//uYwAbYjFTxFnCvQ0fFnhE/C5Sacn/CqZrsqlu6MxSMDs72JwhiqpxJoUDR?=
 =?us-ascii?Q?hOap2YG6lWXPjipZwYIdIoIMsuFwEKwdxmfFHA80ZeIDU0f687TlS3b5oj6G?=
 =?us-ascii?Q?vsF5p+Bc/d9rFH9mMnwigKu6zcmywRPCh1Nf5UF/JqAs8h1PGxfqfzyfubt9?=
 =?us-ascii?Q?ZbOs39IBA0280TrYZJqnMfZzGfPigexhkosLnhUSiYcIZugrvmmX2s4ICAi8?=
 =?us-ascii?Q?lQXRIgI=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?JBWfJYD1bONdPlp8cKxAbmLzoToi+J23mdMsos96kyU5J/qgrRnJJFfGPW1s?=
 =?us-ascii?Q?i81rlYcn7a5YS7uj/BNqgjA29PKnTDfqnCpfiDeianqgkkLxfWq+Qyofr2KN?=
 =?us-ascii?Q?s1CfkslVZxs4UPJYXua/Et4TUKYgjdk3kHM8nEFhkYdD1DWnWFTRUOINzDMu?=
 =?us-ascii?Q?eNSCnQk1+ajyf8diqRpTpaIHbu0xoru8WIF50ObLNIN+og8j07TR4Aps7TSr?=
 =?us-ascii?Q?ODrzAOYfgOIs5H1GUB07kFPymQFAwXspbMAgOLdWsc6bmgKpIF34t32tfunQ?=
 =?us-ascii?Q?S018waE++IT+EyYT7c1GFk1npOPBsP2d3NaBXSXbD3CsYHc/xORE9JbERi3t?=
 =?us-ascii?Q?b/8XVl2JsQwiwolx75RPX35rly8X5bmk3YOSqLAmYf8YpwTZaUcSBd4+o6Q6?=
 =?us-ascii?Q?wXC94ImcUsdO7LAW/4kGESYU8deTf5AaP3bhbRyYY51sA/FrWBazf+P8VQSk?=
 =?us-ascii?Q?blO1S88rpeinV8dH/sDQznjnWLl5GdDEfxRE90EJxZv+8tdCUX6jYjgl7nUM?=
 =?us-ascii?Q?ULOnQhYqONTa+HGNjJCK3VL4NjZMjlKnlngdZKtYI/UI3bsnibzHhQ9dujOF?=
 =?us-ascii?Q?wqzlSRdWJWNELA5TKyS4GvxvWkqW8SBtebcHUFQiPNjA/Xp8YDzQ+8QNxkYL?=
 =?us-ascii?Q?uXGiRer6HaEaq7Iemq6r6vFA2dCLM3wpY6cRtnmw3tPM9TfbPTxszm88OrdG?=
 =?us-ascii?Q?bapEKD12Ps5wLFXYNG0A4CsU715fiMkZnBlKqjo62nKIvjGxpv/iHcA7YFv4?=
 =?us-ascii?Q?BmU+25/hC71UH0N37scUhpwejR+XmKkfpfyNE1XhpPMMv5a1oyNNMe6bOXpa?=
 =?us-ascii?Q?p8Nn4M7PozU3rAmG4dfodO3CR7K0WTekjeXjox6+UTHZFEFNBiLWffaaGycs?=
 =?us-ascii?Q?U/dAhvX9hOUvrhBS6zYEjNblQoEZ37NzgWQ/ilvZuyke6LeKWXzUz/+v3So0?=
 =?us-ascii?Q?2SSYgX6xj+8JUGJQ+mX0MblfFO8Ekvk2KHBLQLDiCfL6fXtGOJy2HPN1xZIC?=
 =?us-ascii?Q?xj05qwwNsXIwsXmEpmTzS/EsZjVnh0So8Kzag/VyuviVbrwmSN3QqcyswHCj?=
 =?us-ascii?Q?yMo5N22K45hEs30a7yED1X7JppKTXAExuRoeL/E2wZBi41FL70k3dXGvmc8a?=
 =?us-ascii?Q?939UIE9XT+ql7YT+xMBjnjZWVobwNKXwCNRctlgQk4QGmPqoYV3zunhORiAS?=
 =?us-ascii?Q?dnVCF5UeU4OAbR25UEV8YI00KYjdx/uSIpAypq6jhHiJ6opt15Vg3v91j0Jm?=
 =?us-ascii?Q?w1f38iUV8ngqWdEB1zs3fQ+zOg5uuGuSO4Yx0WBB8ZZVE+lUmJ3x3n2eEeZi?=
 =?us-ascii?Q?ZwXMli3VkUZHvQ8JPQhOET7zKRp8ee96pAV8gFYfQiG18fLpjc1PHZYIsGct?=
 =?us-ascii?Q?cHikZKmSREXSfof1GhaVoSNwXbHn29KxoxFmLhDdce82kjyn7t8jQSPGfb8m?=
 =?us-ascii?Q?Q1LNaMkv7wGZYnQGc+Pfal+B+iDa1c2ZERFdngj34dpFv9/J+oWz3yz87f5X?=
 =?us-ascii?Q?z02yTEhAZJ3euDSWJrI9GKQeuG4AawGCEngwbiY0czYQGS9cUhyO09nnJLY7?=
 =?us-ascii?Q?hR+wUD2uxm9RusmGLmUab8md9ERTuDqje2uUsY7K?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d5972b1-3e43-430e-8c00-08dcf332a123
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2024 07:16:35.7102
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: klwQqsKzLk4ADvns2z2H3Q5F+OJOKEvBAW5Fk8xBeKuvAJ1r7/zIg3Eb2IBU3j6vrm54doR8SrR6ZXdjmFqgyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8579
X-OriginatorOrg: intel.com

> From: Steve Sistare <steven.sistare@oracle.com>
> Sent: Wednesday, October 23, 2024 5:01 AM
>=20
> -/* true if the pfn was added, false otherwise */
> -static bool batch_add_pfn(struct pfn_batch *batch, unsigned long pfn)
> +static bool batch_add_pfn_num(struct pfn_batch *batch, unsigned long pfn=
,
> +			      unsigned long nr)
>  {
> -	const unsigned int MAX_NPFNS =3D type_max(typeof(*batch->npfns));
> +	const unsigned long MAX_NPFNS =3D type_max(typeof(*batch->npfns));

why changing to 'unsigned long'?

except that,

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
