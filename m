Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE03C5C96
	for <iommu@lists.linux.dev>; Sat, 14 Sep 2024 00:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726275387; cv=fail; b=XKP6P5R6HzWB3OgEo2fRaGaNy7HK3GEfDWHbUW3jcqnIsVJXs85drR1biBxSOzffymb2IL6qETLwmo7bFuaZRFXpmilj/JpP/sNyd2c52eoPI2scuhhf2coNhsXCp7yLogQZw8WTAFujPrfrEIHlZTGOYGhxoS02CnmekA66leI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726275387; c=relaxed/simple;
	bh=JZ6WFUmQ2LDWwffm87xaMBG3fwV03R5JvkmnjO+OGSY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=URYA0eOe16QxTNcKoGtVZfA1WtF/xVVrXDULthgyNRjRn+vlgANuvCJs2aow68gzPnludoiKEK0/MC8egmEtui8zdUb99lEWbx5NfJXnFjWq2NkjX/vanPtH2JRsWTfxEeVhk71MSTv3eO7jSoiUql4KXD6pwI1HM99EEWDXVEU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fA0IknAA; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fA0IknAA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726275386; x=1757811386;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=JZ6WFUmQ2LDWwffm87xaMBG3fwV03R5JvkmnjO+OGSY=;
  b=fA0IknAAggcpCiksIEXudh81NAnr0sSh/2nzjDtVrWFLJDeCpYK9yy6X
   68m5yuVOOyJRLQHr4Gye50DBrkkOZlZ8rg5BKqfjpIRMWNYitKZ2m1031
   AfdWPa01vo4vfLWR1572qYm2psC6RPcYzkzPymMJi1HZcaqpbdmsYNsUQ
   WCDqa7fYyJWvWqIwzhjT5nByrY+WKxHVVSFc/uX2H8Rxjo6Wjj4HUAYIy
   TqqUHkUHiFfsEy+vziPP/6XFqVh+6aZcEDTZaU9is4zMAipCgGMBYC11e
   X0vA8ynBZwWc3YFWGzB0mMgvim534rnGIi+yEtQcQilg8i6bJH5a7XBb1
   w==;
X-CSE-ConnectionGUID: Snn+JZnJScmn1WNV5HwLKw==
X-CSE-MsgGUID: 2MwG9sjqSE6wN4EF+4fOSQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11194"; a="25075331"
X-IronPort-AV: E=Sophos;i="6.10,227,1719903600"; 
   d="scan'208";a="25075331"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2024 17:56:25 -0700
X-CSE-ConnectionGUID: gmCKjtzbQU+y3TjXG0WUXw==
X-CSE-MsgGUID: 9DFDEUZFSH6M2uRvPuh73g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,227,1719903600"; 
   d="scan'208";a="69027979"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Sep 2024 17:56:25 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 13 Sep 2024 17:56:24 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 13 Sep 2024 17:56:24 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.172)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 13 Sep 2024 17:56:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nO+xctNHKOraYRWzfsPnFP0V2ELafQktr+vD9krc4yayZluRvjQtcNABwWJ8nRDZ4syAQ7kCIDh5Dh2QswomCMGXA8CAwgM1oZAZ6ParNzb+rtL5O+cEaynFai/512NqBD/B45ckQ8AQpYKIYnW67VQGwMiephHJoosDeJBIkJ/MPtyUfZ8bzweeFLN1eFolMjEUW6krYTPtve7f1RZcgTwzCmEnbDcumDdno+UCnEhHF3SKxPAzF21Nd5VJQ4nXEjfjp3O8ZWBKesnPfsV9GahEZPg4lOsCoHEFhor+26iH0SCpqTrlF5sf3GKEZgokqEKExtDA51s7wT2jOILLyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JZ6WFUmQ2LDWwffm87xaMBG3fwV03R5JvkmnjO+OGSY=;
 b=DMmKT6R4k3U3TfjstW0Tht/xixhH06fvefFakoS8y/gJxKKd+oJGeujFParHZYwLxvvmBvesvhJwR4gu52DEpJqddabCUyx/Q7h5Hnd8hWbqxNQCNQW9434bHnW62KBJZuAITJGXdisfZo56C6vVxJgHJogpvbIqtVsKvWMfIfs/jlnYo7fC6/aNXgF37qQJkSNbtiIiLMqk8bJFSQ/BEUR4IWLa2O2gXu8DbD2ylclhUi97y9MPFe8D/Npqa+3JQyjjGLkKXvJQmGZVlNVhzTlmhlSD+wVGwZH4bVoxsTaJWeM+BUepwSJYsNUrsFgyDrfy9c1se+LPnsZAdIWh0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by IA1PR11MB6490.namprd11.prod.outlook.com (2603:10b6:208:3a6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.20; Sat, 14 Sep
 2024 00:56:21 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%5]) with mapi id 15.20.7962.021; Sat, 14 Sep 2024
 00:56:19 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: "j.granados@samsung.com" <j.granados@samsung.com>, David Woodhouse
	<dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel
	<joro@8bytes.org>, Will Deacon <will@kernel.org>, Robin Murphy
	<robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>, Klaus Jensen
	<its@irrelevant.dk>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>, Klaus Jensen
	<k.jensen@samsung.com>
Subject: RE: [PATCH v2 5/5] iommu/vt-d: drop pasid requirement for prq
 initialization
Thread-Topic: [PATCH v2 5/5] iommu/vt-d: drop pasid requirement for prq
 initialization
Thread-Index: AQHbBdJ3zwfJYP/3xkyb1ssbarloprJWda+w
Date: Sat, 14 Sep 2024 00:56:19 +0000
Message-ID: <BN9PR11MB5276D2F51900EFA89B55AA788C662@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20240913-jag-iopfv8-v2-0-dea01c2343bc@samsung.com>
 <20240913-jag-iopfv8-v2-5-dea01c2343bc@samsung.com>
In-Reply-To: <20240913-jag-iopfv8-v2-5-dea01c2343bc@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|IA1PR11MB6490:EE_
x-ms-office365-filtering-correlation-id: 324c9870-e3de-48c6-dccc-08dcd4580b86
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?WkNrcTVGeVNXQ0NPeThHQ2t1OW1GQmZrM2RyQjNiYjFQRTZ6MVNWVDZNQW12?=
 =?utf-8?B?NG83c1BPTmlDbC9HZWFFSFFvRmVQL2w3R1UvelVTZUxob3lHK1NmeWZzeUhE?=
 =?utf-8?B?Y1dhNk5paDd4TDJMZFhjd0JtTms0SEFGMkk2THpmNnQ0dGxsVG96cCtCUXdk?=
 =?utf-8?B?R24wRFpCY1dmcnhTbk1hK0Fud1A4UytOVFc2THZwdXgyNVpiaWZxTTV0ZXM2?=
 =?utf-8?B?REJTRldNelA4RUpMaWlJOWVOb2FtL0U0dkNJQ2hJeWxqUmY3UUx5OW5FOFhZ?=
 =?utf-8?B?VHJoaW0yUHlTZkxXVFIwNDhoaW1Sc05jR1p6cDAyVnFuRHJQTWZrVVFrdGtT?=
 =?utf-8?B?K001andnaDN4cy9zUHIySURrU0kwMXc1ZXlRUGJiQ0Y0SHh4NzZUdkRtU3Br?=
 =?utf-8?B?Q0RnSExTdzBGMjZyQ2VTUGNVR1hsb215WVh0Ti95QUpvQUxHTExzbXFsVVMr?=
 =?utf-8?B?N2dhaXFzd1Yva3F1anA5VDFzTHVEa1B1MHR1NVJiRHVqaUlxcHJTL09vMDJw?=
 =?utf-8?B?VDdOeUVSRWRHWGM4Q3UwVUVOdFN5VzEya011dzZYS0prWVR5NmRYRkxTTHg1?=
 =?utf-8?B?a2p5eG9YcjlhUGxuRGt3MHRlL0VGSVY3Y1Q3aGV5OHNKaXlMNVJKTXJ0bEdZ?=
 =?utf-8?B?bkd0emQvL012dXRIOFBES2dvRThsVEtQZEljOUUxeG9JNkFwK2JOMHoydmli?=
 =?utf-8?B?SUJQb3VydVdOQnFjYzFsaU1mUjhyZXNRektwSDc4WVZqQy9oZ1p0UVpnRmMw?=
 =?utf-8?B?aXpPaGcxaUpoT2xEbzJEeExxTitkazNXSGwwTkFJQVZKRHU5ZVFMbVYzV2dh?=
 =?utf-8?B?RFdod1F3cjBySUx6Z041VnFla3RCR0pnTXBxOGc3MGhNZ25JbnhaWkYzaWNr?=
 =?utf-8?B?QTBGV09KaFo4Q0s0ZExmNk55NHAraVdFcEhhWnJqVnUraDQrOTlicTRCOUZY?=
 =?utf-8?B?cXljdTl1OGRyVkMzczFyQVVmRkNIT0hRMlNPWjhsYy9PMVNtTjNMWDVjNzU0?=
 =?utf-8?B?cjRlbm51VFR4TFdrdll4YmU5d05DOTBKNW5Od29aVEpCek5NMjJhVmhnRDRP?=
 =?utf-8?B?UjArcnRpZlRUYXMwY3lVcVlWU1lzTkRKVy9BYjBydVZqSURPSDhLNmwrUjJs?=
 =?utf-8?B?WEtqOWZSRWU4NXhNREFNcitLTEhxRW44SHkycUN5QnRrNzhpaFRRc3h1TWNl?=
 =?utf-8?B?T3RVUEFJcjMrYWlrR05QWGdoSmQyb1NUNUtKN0w2Y0ZucjE3SVR1OXFIOE9R?=
 =?utf-8?B?ZHo4SmMrWk1QSjFSbGZnSDBzUmtEd2VuK3l3QUJFb0FwSHRNbjBIb2QwZnRT?=
 =?utf-8?B?V3YwdlZIN0RNU2tySFVIUTd0Vkl3SDhxTC92dk5QeUJ3bHErenRMQ3dzdDBT?=
 =?utf-8?B?VHFlWWtXanNoc1B6N3dxZFpMUXVmQ2xOUTZEMnZENWNtSnAzY0ZuSW52c2hn?=
 =?utf-8?B?SVQ1UWRQQ0hRU2dudnYycTUvdU9wUlAwSHdKVG5MZzkrUTNRSmlJckNoTGt3?=
 =?utf-8?B?RHdhYzg5ei9OdUNyODkwbUxLRjhYY2FCZC9WOGwzY3ZlZWRBSHVPbzRFU0N6?=
 =?utf-8?B?VDB1SEk4Z1ZwVVZiTzdnN2hEVzJPamtUMVJmbGh6dFAwNHJaV055OUVKanFB?=
 =?utf-8?B?aEF5SkZ6R3Y0VEYzNTI4T2lPZk12ZVlOTHBFQkJaOUVnRTFKSGhMZzdGZ09T?=
 =?utf-8?B?bnlnYnRkVkVRZjcxVWxONStLMVAwU3A4SU9MM0NlNTZYbzBhdzBMNjVKRnhH?=
 =?utf-8?B?c0hoSlcxN05GcUtKTzZjaXU0alM1SmJ1VFNTSWNpTFNWQy9sRldiVUlLUnNp?=
 =?utf-8?B?dmFGS3lZUHN1cVcxZlhOM283azNHaFJTbEI4Q3RxU3ZCM0ZJeithQUZDblQy?=
 =?utf-8?B?c0R0WXdyRkhaMHFIZzdtS0twNk5GTzdqY0NaTWpvTmxnckE9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OGMxWFhvclVMeTU0Qm96OXpKQlVWdGNHbG5TVUFybHM4VlZ1ZHZycFRNeE5i?=
 =?utf-8?B?UUlWSXMyTkRHYmRrbkU0SndxSjlwcE9Pa2svU3dGNkZ3L3hmRklROERNME10?=
 =?utf-8?B?SDlocExLa3ZXdkdWZWp3UjkrQWVzcEZxTDRzTlgvbUNtUFdKSlROc1B1aUY3?=
 =?utf-8?B?NjNick9LUmplZXFqbHB0QVpqcTdydjdiMDhaS0VNeDF4QkxOK05SNllwRXpX?=
 =?utf-8?B?ak00TFJWVGRXUGtIVUEzTDM1MGhVVFFWYmxzd3JPTTdkSEF3OGw4TkNXa1pK?=
 =?utf-8?B?T21LMmExckU5L1ltbFZ3MUViTHhIb0hFdENhOWNBdDMwOFErdnlZVklqSEI1?=
 =?utf-8?B?L3pac2krNzMwYnI3ZmZhcnI1blc0SXRQejViQSt3QmxHRmhqam5YOWxySWEz?=
 =?utf-8?B?WkZuUjJlU045OVJLaFNra2I0amJnRTdqM29FVk9oZ0d4U0IwZ1dxdkExT3FD?=
 =?utf-8?B?YUhPZmVFYjZzRVZyMk1ERWVSaVIzc3JtRjB5UzB6c2s5NWI2QVVwWmRNNk1H?=
 =?utf-8?B?UzhINmhJdktlTGR0UTBpMGozUUdxa1oyd1NMZHIzSkI1aDhDcmgrdkM1N3dx?=
 =?utf-8?B?dERYcHZoVG0rb1NiT1o4RUkrMXpFRGp3M1ZwMUd5UTZXT0IzaHloODhlZEl5?=
 =?utf-8?B?U0xnU2tyQkVQbVh5Z1FqeXlsYm83QXA0WHhXbDVzeE5sL1ZqK0IxYlR0elg1?=
 =?utf-8?B?OUZJNVo0Q3FSK0hRVFVLQmNsWUx6Qk0rc1ROVHRjTGJOSk9pdlYzQnpHZHp3?=
 =?utf-8?B?alBaQ2NsWnppQVJOVTdkWVNGSnVsaE54blNLbzlaaW1EZWhtSlFtUHhTajVL?=
 =?utf-8?B?ZVArMFQxaTBHcHVWdnExQ21kcnUrSnhsamp4VTN1ZFN2eVpmZkxaMVQ4Mkg4?=
 =?utf-8?B?Q1FWMHdNRW9kbG11Zy9ZYUJ2RGpsajk0MXRNQ3FpQU5ZOUFQS2ZidFNleTRi?=
 =?utf-8?B?clY1VjExVVhPSURWb05FLzRWMDh4K0FsNHBaNzFrWEw0M3l6SHEwNW1jaCt2?=
 =?utf-8?B?a0o4TDVSUzB3NnNod0xJK0xNRkkwRnk1QW41QXJYWkEwdTZqNHR2ckdwN281?=
 =?utf-8?B?a3dVeGRUVk45RTJPTkFzUGJNelpSLzA1OUJSaDhoc1NjdTNpOXlmYkdYRkpv?=
 =?utf-8?B?V1puZGtUUysvdnZGVWNTSVlmMFUxbktac3Y5WXovaW5yQ0Z1RCtsbUlpc1Bk?=
 =?utf-8?B?NUorU1duNFR6YUMrSENCNXNOWGQ5eXh0dHZDWHJFNjNWZEliUmcxL01lUkNE?=
 =?utf-8?B?cis5Z1RDZms2WnU1OEU5aVBvK2lYMTZVOXpEQ2hyWkk3OWc5VSsva2Fjc25u?=
 =?utf-8?B?a0pPMzh6YndKSlZPNFI0dTlkazhSNE1JMVU4c1kySEZabTJZOGh4Unh3M00w?=
 =?utf-8?B?b0p3MWlaVE45dFN5NGRmRE16NVB4WjV1RCtkMk1GWitkZUYwcmxvMEJodk8r?=
 =?utf-8?B?WnFLZUpZbTIyKzR4VHNDdUw4RFNHVnllYStyanFuZ29yU2Z3dlBaK3JFaEdJ?=
 =?utf-8?B?TWtxZTdLeXhPWGY0YytwVm8zTm8wWHM0YWRieGdmWTVtTmptUzNlTHI1Qy8w?=
 =?utf-8?B?UVo3dW1UWk1xaUsySmZqNTNYbnI1cWcxNlN1UE5kaDNuU2dUUnkyb0tPemFO?=
 =?utf-8?B?b04rODRFbllIdVhqWmljRnY3SXZzRmFtWmR0NGVUNWNINE1hRWZkdW1ObGFz?=
 =?utf-8?B?UnRBVFZkTXpOM2NmR3hvcU14SzkrNEc2Q21Hc1RaYlVlOWFGNDQ0bHpPUGZG?=
 =?utf-8?B?cENaYlpiV1ErVm8xa1FUaEtNRmt0MzduaWlLS3RINzRvTzRsZi9UMVA5ZVpk?=
 =?utf-8?B?Q0p3NlZkc2k4NUJlaWN3eDNGZDhPL2VvZHVvTHNYallEZTBYTTFiU0N3WTMz?=
 =?utf-8?B?Qk94RHdRNFFieHkrQUtKaVBmeGM3RTNwV3dNemxIWFZsUDFnVnJPeDJ2MlN6?=
 =?utf-8?B?RDRiVlk5TG5LMzZRUXlqcHU2dDV1bHdqM2kwQ1VNSktFVmJhc1p3VkJGZG95?=
 =?utf-8?B?SDgxRVRkaGhIZFYxcXRRWXU5TmtMdDhkUFVLUEtYejE5QWFzbVUvL0M3WjdI?=
 =?utf-8?B?ZWt5MGF3Vis0VnF0aWFuVTNpYU0xZHBJUHhibkdxUVB6WDY0ZnB3Unh5bWRp?=
 =?utf-8?Q?xlMmze5ofTjl5rfg2T3Bh4cWS?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 324c9870-e3de-48c6-dccc-08dcd4580b86
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Sep 2024 00:56:19.5259
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4gk5Q0OVNwG0xlK+spJK08A/cw1P+Tqzc9IYTMVvO4IUmAoOAAA/nRhSr9n3K2Aonwg0I3VzOPy0BJHrOozwGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6490
X-OriginatorOrg: intel.com

PiBGcm9tOiBKb2VsIEdyYW5hZG9zIHZpYSBCNCBSZWxheQ0KPiA8ZGV2bnVsbCtqLmdyYW5hZG9z
LnNhbXN1bmcuY29tQGtlcm5lbC5vcmc+DQo+IA0KPiBGcm9tOiBLbGF1cyBKZW5zZW4gPGsuamVu
c2VuQHNhbXN1bmcuY29tPg0KPiANCj4gUEFTSUQgc3VwcG9ydCB3aXRoaW4gdGhlIElPTU1VIGlz
IG5vdCByZXF1aXJlZCB0byBlbmFibGUgdGhlIFBhZ2UNCj4gUmVxdWVzdCBRdWV1ZSwgb25seSB0
aGUgUFJTIGNhcGFiaWxpdHkuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBLbGF1cyBKZW5zZW4gPGsu
amVuc2VuQHNhbXN1bmcuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBKb2VsIEdyYW5hZG9zIDxqLmdy
YW5hZG9zQHNhbXN1bmcuY29tPg0KDQpSZXZpZXdlZC1ieTogS2V2aW4gVGlhbiA8a2V2aW4udGlh
bkBpbnRlbC5jb20+DQo=
