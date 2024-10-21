Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 861A01E0DCF
	for <iommu@lists.linux.dev>; Mon, 21 Oct 2024 07:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729496568; cv=fail; b=rVwI9pj7U6tngIMHSvAYUIDAwVQmvEUoQRC036JRohxfEfypz7fcPcHUKJCds3sYyknMswtqhg4km/lueYyfA/QqSEr1Ud018YguTOjPZf+iQAVIC7YnivtWJaDAjIPtdcln1YjqYO3m/gGPqi3iUQrIWPq64h0Z0BGONB4tjOY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729496568; c=relaxed/simple;
	bh=UIX/2+bVLC5vuCkVttmhcRNOr+d6Wny7kgRk0FRWI3I=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=A45mg0tvurS9cz2fKt+Y/zCCp1gwu2zZBhY9bTo8bVQXMOAHYQg9xAw/U1A4vqbntDgkg31YVfVXgyygexJqgn6zX1HjG8YA1FBkwuf0fXQOVCLjhVRHEvX8uxMhPKG2eWvQ1LIdmS9WFZ0K/2gKSR28nomiZo2AmG4DHvJau7I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jo30acSY; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jo30acSY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729496567; x=1761032567;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=UIX/2+bVLC5vuCkVttmhcRNOr+d6Wny7kgRk0FRWI3I=;
  b=jo30acSYPdcGK49DkwOOsO1uykj35VdwLKknsicKYI/BaOG1MnRVEgrJ
   pXx4Zn0Yrtqf251RSA1ShqTTVJ1ygo1NFmqQENXyDuGOD//Svt+GQfL2+
   Epxd3Kn9+duwj3o81DlBRFeDMx/s4In93h1v/xXBIVM8Pf0Xe5wop5vPx
   fh/llsOsgvyQic0Oq1+J/d1k1zMjFCUxRv2XqGFTejSpTvWQSb5ONkziD
   goWpePrTOYgwMZv4X141DVje9Y1R73DCctb+IrHmEV1w9qR56HrZ6zH41
   JLAYW2rYC4hDrZ+1MxYVvvNBSf4riZHb8dHnkgs9Oo0ZPpqQwHWkRFlmG
   A==;
X-CSE-ConnectionGUID: Jqi8dAKrThW/PSJ6OeLhgw==
X-CSE-MsgGUID: bV6nmvALS5GXZ7VX9/rLoQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11231"; a="40359929"
X-IronPort-AV: E=Sophos;i="6.11,220,1725346800"; 
   d="scan'208";a="40359929"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2024 00:42:46 -0700
X-CSE-ConnectionGUID: lQwmRhEzRCevcl76EbDkvQ==
X-CSE-MsgGUID: y6K1x4o6SCOLBlMjkqa0dg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,220,1725346800"; 
   d="scan'208";a="79090575"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Oct 2024 00:42:46 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 21 Oct 2024 00:42:45 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 21 Oct 2024 00:42:45 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.172)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 21 Oct 2024 00:42:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AaurK1gpwe3sSGkjvUtPdaDpuy/WyTZVJQNBgrXE+LBGMYuv0gCt29G11xlt1q/HEg9S0gPyjj8wSEdUQUlY4PlnZ8dewovH+LWK4fD/1GEr7GeJ+x56oMM7tOXM6gTLpNUmOaPoY8SpyeOS8jMeZMLXUgGPYWk2gwDoo7YgKndU/bm11ZExiXoSypNJHUHR8XrDk4qlgMGxgo6jQyATYqvKa/C+OSUaBgrvl3S9Ua7AsDXIWRGK9Owt+yPeWGduppSN7Q07CswoF7MZ3P9J2iZIrVj7K+6NwdlnO2IvPWE1m8ekqRwfmdBHm4BoHZtzjz97Gbko2kMINOTAKPxAHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XT/sw9Hut3E/5Z1ljNG/m0mPI04zErTQotqgUqqXEWQ=;
 b=epfYjUVWx/ntWRYwUNs0IieC+NYpTt4GerQ9n9DWTY8gzr5FGOWDoNJJkZCJ3Q++Xr32qX4uSndd8zygIOvtHV2DJVscNA7Y4sLIhI/+MmhSXk54qVaTx4vj0N9zLQXIsD9oHikNMLZED9X9C7N99mXTVf7thA61VGi6yVN3OZuriyVdMOMXMa4fUqK5xBP+YtRetxs8FCm+BuLTKmxMD5hYbBV+CWVmrCO7PE5xUyBHIxwvtCRA60O0XtNh1uijXm9ebG6KrEumRi5tP0bzkbFQU4cBPV4BvdstnH0SKXYOJ0K185h17PKSIJ1BZQ967BVlnW+u4ndaVBucq/FBuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by SA3PR11MB7485.namprd11.prod.outlook.com (2603:10b6:806:31c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Mon, 21 Oct
 2024 07:42:42 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%4]) with mapi id 15.20.8069.024; Mon, 21 Oct 2024
 07:42:42 +0000
Message-ID: <942e7019-a477-496c-b04f-b0fb12283187@intel.com>
Date: Mon, 21 Oct 2024 15:47:17 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 02/12] iommu: Introduce
 iommu_paging_domain_alloc_flags()
To: Vasant Hegde <vasant.hegde@amd.com>, <iommu@lists.linux.dev>,
	<joro@8bytes.org>
CC: <will@kernel.org>, <robin.murphy@arm.com>,
	<suravee.suthikulpanit@amd.com>, <jgg@ziepe.ca>, <baolu.lu@linux.intel.com>,
	<kevin.tian@intel.com>, <jacob.pan@linux.microsoft.com>, Jason Gunthorpe
	<jgg@nvidia.com>
References: <20241017140137.6028-1-vasant.hegde@amd.com>
 <20241017140137.6028-3-vasant.hegde@amd.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20241017140137.6028-3-vasant.hegde@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR03CA0109.apcprd03.prod.outlook.com
 (2603:1096:4:91::13) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|SA3PR11MB7485:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b4c95cd-573c-4e3c-ef3c-08dcf1a3f1c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VThRL1BybDJZS0VKMjMycUdZQ3dMZ3hUeDFrbk0wOGFJZ2EvQTQ5UGF3ZW02?=
 =?utf-8?B?SGVmSEU5ZlB4QVJ2YjBBYzNyVTdQTTR1MjJvUlBpbEM5VWUvblVwbVlvTmhm?=
 =?utf-8?B?MWhtT21PUzhDU1hJdFdZZjZnU3poQTR5V3h5N3hrTFcwRHFuNFljZDJ4Q1U2?=
 =?utf-8?B?L1REOWlOQWhYYmloYjVOLzF5YjVkZzQ5cVQ4RkdnZTQrYUtxOUJ6YThTK0VH?=
 =?utf-8?B?UC9ya3JJVUZxb1g3TmtEclVYSm5CblV4azNCcWNrL0VFZEVuNVBoNDJoaFdT?=
 =?utf-8?B?YlJWc21JdVZmUG94a0JDdFhUYlp3WWxhWG5OZlhJTW1xbk0yUGY0STB2bEhG?=
 =?utf-8?B?S3ZKZnlFaUE1bW8yVW5oeCsvQU1hU3ZnYlIrSU5xbHFHcGFQekZQWU9SMHJI?=
 =?utf-8?B?MlJtcytVQmRVTTNVOGllczFVL1hQUWxWMXMxTXZGelhmaEt3K3V6NXViVUZB?=
 =?utf-8?B?S0gwTGlqdWZqMzViZnZ3Snd1S1dDTURnTlNlbGpBV2dYMU5XWUEvc092bUhh?=
 =?utf-8?B?MUk3c2pHS1BBZCt2WnpuZHJXd1NwYUh4ZmwwNzMyV04rNFl6Q0hDYlBwdDNm?=
 =?utf-8?B?ZmFrWHFUZjVJVW56L2RXMVR6TzRuVGdYQ3hhMHR2SEduWUFabUR0STNSSnd5?=
 =?utf-8?B?TVVERGxrcFdaNUpHZXdqSkoxWEpORzZQM0lVc25BYmhzWmxteHJacitjb0d0?=
 =?utf-8?B?U2JYemp4aWt6NHY2TGZOYmlxUCtwWEV3dzhaeEtLR2pBYWtBanhZZERoM3Rk?=
 =?utf-8?B?S1NtTjFLRjY0U3BQVHpTV3pDMUF2SmVyUDB4cDN4YUdxSVZ4engwakF1NmRn?=
 =?utf-8?B?bUVndDZncU9TaXZuTzhzc0dCdng2VmJWZ3VzNjNBVjBvWEsvNEVxMDJPS2pq?=
 =?utf-8?B?TE14SjlUenRndHZRdUswV20wNnNRMVVrRmdkRGNONGFrcnB3TzVSSWhQMWoz?=
 =?utf-8?B?OGVCODdSck9WYUtwVVN1bVNVei9XNUJVOVRjWkVpTGp3WEhVRmU5QVlpdlRW?=
 =?utf-8?B?a093eHZJMlluOWdqaStoKzduMzRHOWFFekZMdy91NVcrK2pUdmVWdk1WcmV1?=
 =?utf-8?B?L040WkFQbkErRGhpckVRSGVwU3BpSldNZ2hDVUpVRGNEZU5oYzRQYmZnMkc5?=
 =?utf-8?B?WmVPd1c3enBGd2M2Qjk4bFJQbnI2aXBCM004UVFUNStJYkNac1pmOEkyME02?=
 =?utf-8?B?OUNabmZ0NTZ2Y25pME4yNlIweVVjWjFlaitiZGlaRm1DRmFhWkxpYTdYWGth?=
 =?utf-8?B?RExvdjI1Y0hoeUh0M1R6ZW1JUGlqM0hJN3V1L2hZSmg0T3ZrYVRBb2JIN1dV?=
 =?utf-8?B?SjE0NllNdmtlVW1POVRFK3h1QW5VanBXcC9aQm9GREFPVTUxTnRuaEJmUDht?=
 =?utf-8?B?NStmdERLbXVKT2U3QlFhak1nc1VzRU8zM3FybVRqTG9KM3VXb3ZFb2ZNWmto?=
 =?utf-8?B?VmIzd0lxZG9IVlFCLzQvS21SVzk5eHErbktPRGVmZTVTaUg4djZ2ZzUzdGUr?=
 =?utf-8?B?MUJBR0hVc1prblVVK2hZMmcxTUZRdm5QUVYwalJ1TWtIVjh2a1E5enVzcW9B?=
 =?utf-8?B?M0o1Sm0wamRML3o4UVN0Q09ORGJlOGl3TndWWlBseHdmMmFSSWwxRnlTTmlp?=
 =?utf-8?B?aTBwTm45Mmg2Z2YyZDNjQVJwbVZNTzFMUmU2WmxBbTUzZS90NFEvdzM0ckhv?=
 =?utf-8?B?NE42N2JsVm0vNm10c1RBbmE4YU1yMFZCL2lpZE0yNG5wWHdEWTM0aEs2TXJE?=
 =?utf-8?Q?KMoruDQzh4biq0TPTWbozuXYw/Qby3etCh50X67?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dWErUXFTNG9rRmxyN3IzVW83Y3g5aDdNbUpUK0NicXNlMEpqMnVjb2R5Qlhq?=
 =?utf-8?B?d0hKOVh0NURHTWh5SEEwMFNkWERLQTJISXZ5QjNwYUtwTklOVlgwUE9adG5p?=
 =?utf-8?B?bmcrMXl5cmFUdENFSGJTem9YM2JhVG5wOUhGVTRObTMzN2lHMFlqOUtFdWFO?=
 =?utf-8?B?Zkx3ci8veWpVNCsvWXF6TG1wREJwRDIrRnprWU5hVjd3blpqenlOU0RDS3Vz?=
 =?utf-8?B?TkM2SE9BUllwTVVwa0h3ejZFajZ4Z2djcFdNYlBGVURmcWdOYXBhYkJsRE5k?=
 =?utf-8?B?dWJybHZRZE10SnRlNVlGeUl1NDEvTUJid0JXRGNEMXAyZWtXb1I4d0xIcUl0?=
 =?utf-8?B?WkJ1aXgvNWNLUEVHbWNHTE83RHhFeXdsL0lMdlFxZjhERkdESUt4ZENSblZt?=
 =?utf-8?B?TVJ6QVJ3Q0FkUytqay80K1ZJUzRDQnNVeEIzeEVuN0hlM0R0RFlaZW1mSU9o?=
 =?utf-8?B?bFkwQjVUTGd6TFIzZnpYbEFIdlUvVFZKYjRtbnJhT2xvWmVrUEhoVVJtTXdk?=
 =?utf-8?B?RGtENXZvaVdVWFA3SGdhbWRXZWF3WkttdGVKcGxYdnlYaFczbkxROUhPMkhr?=
 =?utf-8?B?OGVQK1JsRkd0WjhlVUNlL3MrL2dzQ3M1ejV4SzVBVzB3b2JpRWRDY3RoSjJ6?=
 =?utf-8?B?OWIrTEJHcjkwZjllbjNaMXlMRW5UcmFGZzdkWDZZS1ZObVlsOVpvQzFrbi85?=
 =?utf-8?B?RnVLTkh5T1Mzdno2ZjdZTHVVcWhyaUdWSTQwWEF4NWc5eWRad3l4cm16Q0xt?=
 =?utf-8?B?WnJGcUlzdnV6M3NXN0x3M25mNkcvc3FBTCtESkh5ZVdqNDJIQkZhSVRiWVNK?=
 =?utf-8?B?Z080TE5PcVU1eFR4aVQrWFlrNVBSc0JxdHBCeWFoMzlZZm1aUmZpR29hSWxj?=
 =?utf-8?B?V3JNWk5DNHFGYlhPRG1xOWUzTkgrMTJtWGpBMVZEV1dkZ0FsUWVDeFZ6Tnl0?=
 =?utf-8?B?UlJFU2tmZVQ5dXNXUWdaTmdXRHZhTThPemZYRXc5Wm9Gc2tTVkFhTFU4c0pT?=
 =?utf-8?B?dmVMWFpSZzg1azJPRTQrQXpTbGdLYk1OZ1BQeFdNd2l2T2k2MHljK1U2Tms2?=
 =?utf-8?B?V3NXay9WeWRaM3RFbUZRcDZncWdobnQ4ci83dXVFcVRtc3dvK3VMc3NwYTNH?=
 =?utf-8?B?aXJFdE9qQ0gvZEw2SjZibmJQRmpIOUpYdkRTUjQvdFY0WVRaNEFic3VaRFIw?=
 =?utf-8?B?OWZqVWhQTVI3Nk9MZVN0S3dTVGhIeFl5RXY0QzIzcmd3dkhJbmg0TGtCRXFt?=
 =?utf-8?B?amtpandieWtobTV3OGN5RXV1TW1rdU1nWUdyalpqVWtwWTUwb0dYdXlFYkRF?=
 =?utf-8?B?ZWo3d2lDazkvZVQ2YlBLV0d3cndLRmpWdGp4cUtIZis1cnhWMWQyMU5LTGg2?=
 =?utf-8?B?cTN1eHFHOGFtY0hpVlBXOHZCNzhFWjBjdktIV0x0WnhJaVlxQ3M5R2gxbkd4?=
 =?utf-8?B?ejN6VTZsbENCbFVFUm54K25SMDJpalVaSkErTjA3VmtRVkloOHNuYzN6Wnpz?=
 =?utf-8?B?ellXTHVvT2c2MVNTZi9DaU4yNWM1eUljTHRGMkViR2RhbFAwUGwvMmpYRGVD?=
 =?utf-8?B?YVowOWhRK1gvUWMwZjZRREF4d0lGalFIL2J4TkdQemQ0ZEV4aU1sVGVsMmhz?=
 =?utf-8?B?azdYci9YMUpjRDRvWVNjT0ZWc2hyVVBGSC9PNE5Zc0x0Um1ta05hWjNKT2hJ?=
 =?utf-8?B?UmdtcnVRYWVQTGlqdmVoQ3drd2l5RGlXS2RjemVXa1ZDTXVuS2JrYThVRm54?=
 =?utf-8?B?K3JYMVhjSFRHV2NteVBNM3hVaFEyK2lSVW5obTI2Y3FvMnJsUjN0OWNYbnBz?=
 =?utf-8?B?SWkyVVJQenlxV0RLV1hSczJJN1c2VGhIQ2RNUGhrRFM5bzBZbXlxOEpPdnJW?=
 =?utf-8?B?bkZVZ0VwUXo1ZXpuSnArYVJJM2ZUblpkVzd5Mmh1TTNLZW5BUndTOHZwWHdj?=
 =?utf-8?B?NTBZMVlyWDZiRVdpbVBWUkdHT3RNckhjd2NWTUZWMGxMcmVOdUpzajd5NFh4?=
 =?utf-8?B?T0VpaXIrZ2VCTVRhb3o5aXFYRXIzbkM3QmlrVzdXdkE0VWE1QlcxOC92Qkhq?=
 =?utf-8?B?eDcrRWNyVXNVcUhBVzE0MkV2UFVJSFhZZWFsR3N4RnExQlBQTW9MR05ESVU1?=
 =?utf-8?Q?gziBMUKV41Jb3+wGlOBLoiImN?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b4c95cd-573c-4e3c-ef3c-08dcf1a3f1c7
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2024 07:42:42.1702
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C+9Cxd4uZooCPVRgdsMowfbQH/nP5wVZ+//iGGz2vsBzgreN4NOLTgxfgRWRWnM+EzYRhKm1bXVx5rxxuOFsMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7485
X-OriginatorOrg: intel.com

On 2024/10/17 22:01, Vasant Hegde wrote:
> From: Jason Gunthorpe <jgg@ziepe.ca>
> 
> Currently drivers calls iommu_paging_domain_alloc(dev) to get an
> UNMANAGED domain. This is not sufficient to support PASID with
> UNMANAGED domain as some HW like AMD requires certain page table type
> to support PASIDs.
> 
> Also domain_alloc_paging() passes device as param for domain

The below may look clearer to reader. :)
"Also the domain_alloc_paging op only passes device as param for domain"

> allocation. This is not sufficient for AMD driver to decide the right
> page table.
> > Hence add iommu_paging_domain_alloc_flags() API which takes flags as
> parameter. Driver can pass additional parameter to indicate type of
> domain required, etc. iommu_paging_domain_alloc_flags() internally calls
> appropriate callback function to allocate a domain.

how about mentioning that the domain_alloc_user op accepts flags from
user which meets the AMD driver's requirement? Hence, it's clear why
we are not extending the domain_alloc_paging op to accept flags. :)

> 
> Signed-off-by: Jason Gunthorpe <jgg@ziepe.ca>
> [Added description - Vasant]
> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>   drivers/iommu/iommu.c | 30 ++++++++++++++++++++++++++----
>   include/linux/iommu.h | 14 +++++++++++---
>   2 files changed, 37 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 811748bec4b0..e13d64ffd14f 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -2027,20 +2027,42 @@ struct iommu_domain *iommu_domain_alloc(const struct bus_type *bus)
>   EXPORT_SYMBOL_GPL(iommu_domain_alloc);
>   
>   /**
> - * iommu_paging_domain_alloc() - Allocate a paging domain
> + * iommu_paging_domain_alloc_flags() - Allocate a paging domain
>    * @dev: device for which the domain is allocated
> + * @flags: Bitmap of iommufd_hwpt_alloc_flags

maybe "enum iommufd_hwpt_alloc_flags" would be more accurate.

>    *
>    * Allocate a paging domain which will be managed by a kernel driver. Return
>    * allocated domain if successful, or a ERR pointer for failure.

nit: s/a/an/

with above minor comments, this patch LGTM.

Reviewed-by: Yi Liu <yi.l.liu@intel.com>

>    */
> -struct iommu_domain *iommu_paging_domain_alloc(struct device *dev)
> +struct iommu_domain *iommu_paging_domain_alloc_flags(struct device *dev,
> +						     unsigned int flags)
>   {
> +	const struct iommu_ops *ops;
> +	struct iommu_domain *domain;
> +
>   	if (!dev_has_iommu(dev))
>   		return ERR_PTR(-ENODEV);
>   
> -	return __iommu_domain_alloc(dev_iommu_ops(dev), dev, IOMMU_DOMAIN_UNMANAGED);
> +	ops = dev_iommu_ops(dev);
> +
> +	if (ops->domain_alloc_paging && !flags)
> +		domain = ops->domain_alloc_paging(dev);
> +	else if (ops->domain_alloc_user)
> +		domain = ops->domain_alloc_user(dev, flags, NULL, NULL);
> +	else if (ops->domain_alloc && !flags)
> +		domain = ops->domain_alloc(IOMMU_DOMAIN_UNMANAGED);
> +	else
> +		return ERR_PTR(-EOPNOTSUPP);
> +
> +	if (IS_ERR(domain))
> +		return domain;
> +	if (!domain)
> +		return ERR_PTR(-ENOMEM);
> +
> +	iommu_domain_init(domain, IOMMU_DOMAIN_UNMANAGED, ops);
> +	return domain;
>   }
> -EXPORT_SYMBOL_GPL(iommu_paging_domain_alloc);
> +EXPORT_SYMBOL_GPL(iommu_paging_domain_alloc_flags);
>   
>   void iommu_domain_free(struct iommu_domain *domain)
>   {
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index bd722f473635..42243183e81d 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -511,8 +511,6 @@ static inline int __iommu_copy_struct_from_user_array(
>    *                the caller iommu_domain_alloc() returns.
>    * @domain_alloc_user: Allocate an iommu domain corresponding to the input
>    *                     parameters as defined in include/uapi/linux/iommufd.h.
> - *                     Unlike @domain_alloc, it is called only by IOMMUFD and
> - *                     must fully initialize the new domain before return.
>    *                     Upon success, if the @user_data is valid and the @parent
>    *                     points to a kernel-managed domain, the new domain must be
>    *                     IOMMU_DOMAIN_NESTED type; otherwise, the @parent must be
> @@ -789,7 +787,11 @@ extern bool iommu_present(const struct bus_type *bus);
>   extern bool device_iommu_capable(struct device *dev, enum iommu_cap cap);
>   extern bool iommu_group_has_isolated_msi(struct iommu_group *group);
>   extern struct iommu_domain *iommu_domain_alloc(const struct bus_type *bus);
> -struct iommu_domain *iommu_paging_domain_alloc(struct device *dev);
> +struct iommu_domain *iommu_paging_domain_alloc_flags(struct device *dev, unsigned int flags);
> +static inline struct iommu_domain *iommu_paging_domain_alloc(struct device *dev)
> +{
> +	return iommu_paging_domain_alloc_flags(dev, 0);
> +}
>   extern void iommu_domain_free(struct iommu_domain *domain);
>   extern int iommu_attach_device(struct iommu_domain *domain,
>   			       struct device *dev);
> @@ -1096,6 +1098,12 @@ static inline struct iommu_domain *iommu_domain_alloc(const struct bus_type *bus
>   	return NULL;
>   }
>   
> +struct iommu_domain *iommu_paging_domain_alloc_flags(struct device *dev,
> +						     unsigned int flags)
> +{
> +	return ERR_PTR(-ENODEV);
> +}
> +
>   static inline struct iommu_domain *iommu_paging_domain_alloc(struct device *dev)
>   {
>   	return ERR_PTR(-ENODEV);

-- 
Regards,
Yi Liu
