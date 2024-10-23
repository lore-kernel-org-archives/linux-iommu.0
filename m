Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 850AB18953D
	for <iommu@lists.linux.dev>; Wed, 23 Oct 2024 09:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729676498; cv=fail; b=QS/hunJU3XwkuFuTyT2JHQHGMXC9+1p1PWatyyCN+6wu4qBcK2bbsl+9zwbitbrWGeceBUGkr2Qe2QPNDYqrmYv/P7//Xsideh3v92+oF+JfpYIGnEvWIkwKNcr3VdraBJJwLjsqLA+153GbXir+c9GiofyEbWV8Bfv2Bg/G9VI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729676498; c=relaxed/simple;
	bh=hDWpagJhH+MoNaUDG0EIHbwl9d+AJyHcF7ViC11ts4w=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=N47CTvvxuKGUICbYSR6GrpL2UuTDGECiQS8GTSc25hG+WY7kds5rlpTEyFdFN6mJ61ElJP77G5ufUmErY5q8biPxWPsZktVmUXRoYUKwclnERv5CqK984UqQfT7xYbFqpvMHKcjqpV/DNyDIFYJ7xMe1cnTXfE56/TkiKqFutWQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dFrtG42w; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dFrtG42w"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729676497; x=1761212497;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=hDWpagJhH+MoNaUDG0EIHbwl9d+AJyHcF7ViC11ts4w=;
  b=dFrtG42wfYzHDQUFsQjgXeMAvlT4AaUJtHQdilyf0nrwwAsNnKZHCOSa
   oMOIMbJkdTPBYjKAqG9gzr0bXunjZwLtkxZpzWimForMDPx/lk2vL2fWu
   AuOFGj+Uub07X73r02GChEy7YowXwkEbFKRWMDmxx+bCsBJYhoOgiOkLF
   QivBmlsidWRLcRhxBNOCJKcSLl9c8j4vwiwWPZCvzZgeCaVaSVfqTpSGN
   sswNR11d3lZtcps6Ps5S+5iGzlNyc0jedykRMnBToxiYVo7rpMwga0s0p
   5LqntRPm9TW+LyjrZA/RtVP3rdNvWTEg2+Z3p9QrZXX4L56nYwzqAvFQo
   w==;
X-CSE-ConnectionGUID: a45GPyN1T3+np3Igr6XZdg==
X-CSE-MsgGUID: BsP2DdrxRDuZQ68zejDe9Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11233"; a="46738004"
X-IronPort-AV: E=Sophos;i="6.11,225,1725346800"; 
   d="scan'208";a="46738004"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2024 02:41:36 -0700
X-CSE-ConnectionGUID: xCgyIU5PTLuE99XeOLo+mw==
X-CSE-MsgGUID: Az8jmhwbQHS0xglgB2EcEw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,225,1725346800"; 
   d="scan'208";a="80333603"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Oct 2024 02:41:35 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 23 Oct 2024 02:41:35 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 23 Oct 2024 02:41:35 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.44) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 23 Oct 2024 02:41:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s9JO8FGKtjaqZPCEqhWdAR2aGpw7rL2vZMXcGTL6L8yA0ItnXcZFfLhGNgo4bAZyFGdDCUoUDKJmtom1++miLhoLxIj8tuNiNv8+1TWaA02fdXVuzXpLAeDXLFPn/d2jPI+zYT2I5J2B0qWjTP9y4W6QeWjlhFJBfTaKyQwCf17eNhjDYc/WzMdE0tTO6Vy2+RkHKqIEea78HIuruA+HT3icEkBUyY276Yw3kBFbno3bpdv6SvvqEuHmaMGUTSxT8fUAZTyEArwBRC81ZxsnRQYGDZikOnON1EfKslhTKVUNBnSlWwwLQI3b3Ga8/JHC3JDDzXSc1wutMW07MAawCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gi6Nbu7KZh55cAhzXhp2fKgTIbY1HTCWN6sF148RlZg=;
 b=nUhEuwGNDFEogbGPClsAhEugGyeZHXBurp26EPw5elGig6pmtE6Ut76cmvJu89PkM5PPS1tUhMpxD5n4Xd2N7LeQUHRt+hPSc29KsdNPbzthlpBvahMuRfyfZybUexw458sS7501AmwMoNV0JeSA9QJDQ6DujatPwW0UK6tFtDKs6OgviAh73FmrYfSvFS6zcsvNr8jbmon/7z95IwFXKXm5oYViH6epY2b9GI3L538oBbBhfvEji4kB3MIhSZMErGcjkOVv4RY6nEZGxcSUMV9bQilGyhrgq1P2o6Ww/ibs2afiyTBexhCNBa4QaaaSLMLVX+S0EYEcc4WqT0s6Yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by DM4PR11MB6190.namprd11.prod.outlook.com (2603:10b6:8:ad::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.29; Wed, 23 Oct
 2024 09:41:28 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%5]) with mapi id 15.20.8069.027; Wed, 23 Oct 2024
 09:41:27 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: "dwmw2@infradead.org" <dwmw2@infradead.org>, "baolu.lu@linux.intel.com"
	<baolu.lu@linux.intel.com>, "joro@8bytes.org" <joro@8bytes.org>,
	"will@kernel.org" <will@kernel.org>, "robin.murphy@arm.com"
	<robin.murphy@arm.com>, "Peng, Chao P" <chao.p.peng@intel.com>, "Kyung Min
 Park" <kyung.min.park@intel.com>
Subject: RE: [PATCH v2 1/2] iommu/vt-d: Fix checks in dmar_fault_dump_ptes()
Thread-Topic: [PATCH v2 1/2] iommu/vt-d: Fix checks in dmar_fault_dump_ptes()
Thread-Index: AQHbJSdPSnb4xC7NaEu/ihZ/UamZq7KUFG7g
Date: Wed, 23 Oct 2024 09:41:27 +0000
Message-ID: <SJ0PR11MB6744272E218E88BCB7F05956924D2@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20241023083715.582149-1-zhenzhong.duan@intel.com>
 <20241023083715.582149-2-zhenzhong.duan@intel.com>
In-Reply-To: <20241023083715.582149-2-zhenzhong.duan@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|DM4PR11MB6190:EE_
x-ms-office365-filtering-correlation-id: 2d3475cf-819c-4e16-bdfe-08dcf346dda0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?nKOsUlqLb/nHDYx/a+idOp/KrZ7U83SKNsN/MOss36oy1Ru/hAeKI615GSpu?=
 =?us-ascii?Q?61GqUrK/KgPciOGA/Dw3DWJ5NlWUL2myzrpYLUO6tau1OsKZpgUusEXg3IAT?=
 =?us-ascii?Q?LYkrTgh21EoCv1XBTdVYQS7AcL2MYDBOj1+JRdxt4JE9TndBJDa5gysj+N3O?=
 =?us-ascii?Q?Mivtk/RUP6BRK/OZZzvhbEwUmzQfBsZBYo3dkYQSgVZF3YBHJDRxyDAgg+rT?=
 =?us-ascii?Q?N7RLavjWxqC9IDoP5bK1nGv/I/0qJspdrc2Q9WbsexAKAt5R8CnBL4nOEXPE?=
 =?us-ascii?Q?kEpdi6PrqdNLUAkhahIbRW93s24INkf55PEGDLqKJ259p9aeNmaPIGNQWtiy?=
 =?us-ascii?Q?6JgsQ9Ij1HnAXbraVghpmKGvr+YEtQM6cIxjTtbiBDJNEIMm/nF6Ixv+gtO5?=
 =?us-ascii?Q?G6ELLoVXlKdGqQ+ssJTJJH5EhoeWT2ed6vdBOHuw9izbZh6Owlty45l7zcbr?=
 =?us-ascii?Q?CEaE6aV2c9eittVTeB/SCyxgxcL+0XuNI1JhTuHQQd9e1mT4pwIO8oxp6xa8?=
 =?us-ascii?Q?nQ1CcRBL5Pe+GLK45Aqizqq50z50ASz4WRcWXyWMHAsSOd+ZV61BQvsiG2x2?=
 =?us-ascii?Q?HVNZmv79Qpn9dFz467nTDru3NIIOkQ3mV/LsnS+Mv33fcXNt9v1vm472DTN8?=
 =?us-ascii?Q?bOegOhmrn9fOSn9IBu2gmAivYrLP2wH76McU0/wp6Q7DDiOIC+UsE73rn/q3?=
 =?us-ascii?Q?HW+hxEL7qaKs0htPT3kTzqmyhSKFck1CRRKccjv7dsu7s51fOeiEwYyXSJRr?=
 =?us-ascii?Q?yhcobJcsjBmTg6M05ngLjIDn4ljkZeYVhI89bfa7K39M+2WY22no2v0E22uT?=
 =?us-ascii?Q?EFHk7NRLAi3NomMA5KfewtUhACPWugLKRC3gmVxgNEplXn+qVFEHcvD35nae?=
 =?us-ascii?Q?LJbPKK/F8hIznopsowoYQPunIeZMDARzhowdpaHSgTk3QAzUnoRw/2iUJ9Ix?=
 =?us-ascii?Q?ENUTgLA408rO9RpErTKbdavBvmvVEg1/eJrpmf28zwJXcVfR16uqqmqcV4yR?=
 =?us-ascii?Q?rapTylYnAuvdZnmDqE/CJuQ7+7NxT0oroLmp4cCxEQbqoQStI+Az8UdkI+Wj?=
 =?us-ascii?Q?31dkLJPTq2YNtInWXp3V9X3XXM1boGjOjCsqUBHRIQTJW1kh9+YEnInmRrpZ?=
 =?us-ascii?Q?G/bZm/3z+cjyzAJaQJCPTE4UWhBu+wT+QHQ5E9MFjcfZrGqwJ2DRZXzrERlj?=
 =?us-ascii?Q?5NAU74bvjdW3U32+3OWnrWLSYtzBzziN445rrOV7TBB9BudtEN9s6zLmuh58?=
 =?us-ascii?Q?9LMkOfk3IG/dpn+v95Hs/N3wiM/EU7RLLpr/4elHsyLoBI3ezSwIeUhnSp1X?=
 =?us-ascii?Q?qUPDKql6rhiw28sMcOOxxlsHAC9fbQwUVpwi7QSjKB9iJ3DYRiwE+cXRLHsd?=
 =?us-ascii?Q?XkxLT8o=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB6744.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?KkqeQ7eSdytRJgNLcdrGLjo5MBxV4VjfIRgmIcPNcbMYm3EmpComOj9xPltB?=
 =?us-ascii?Q?9XV8bkj9GCrHVniC7bp52wrYXRi8Jm5gwdIJpEs/w0/ovsINvURzWcwNSDnv?=
 =?us-ascii?Q?fgkA7Xnr1dF7Afndj0ISL0RlXqhKUc0VrjBZRvhU0TZnBdp1KRarKNCZe+mY?=
 =?us-ascii?Q?TtTMqFYcHBEYhG1tOV6EmJhMg5itd8W4pUAc5T65+j+Kvan6pzt9UNFsJfsS?=
 =?us-ascii?Q?FqnUSDPDKLpqOzYU7TELGq9eVfS4lNgcIF4Q2xWHn99sP7GB87pjHMR+i8NX?=
 =?us-ascii?Q?osVU3W7DklsJ91K2CzGDSED/iPNuuuuzP26K+8daxZYDWafaITpsmxNWS8e7?=
 =?us-ascii?Q?HEUir2NvsniQZgXiBUdzu5cbbIA0xx+1bPm22AksnehRzDkQZEKwFS+yOodR?=
 =?us-ascii?Q?2oihuH2a3TCDWM9W7Pb6QAQLPh00rlrU+ZSpvM+jPVryjiIZBu7Nf2XGRWO2?=
 =?us-ascii?Q?GTuYNbAmGmkdCCqnvoSFxW/yKf10iA1EZzljSlLjrGNcgnsSXOjVxyxhiEl/?=
 =?us-ascii?Q?ut14CEaBqUcI+Z1d46QUzdSyi+bj5OotLv6IV5RmZjTfsQsG7QXNziuglM9e?=
 =?us-ascii?Q?aWL7FiWHvyAFSnm4hWyWU/L9eKW0aHG4GRLo6N2wF7TG+/XiNDS4H82Lr70P?=
 =?us-ascii?Q?xkQ2+VeF9f5QNPTeOmWu4VVZSYq/6aShYfp5LAKls6jX0oY9/AtbPH0SvYP/?=
 =?us-ascii?Q?tM0U0evRGgqwTCCPjU7ztq8+PPooz9q4Wgk6JXEl0TqloKX+lxKrxZlKCrFK?=
 =?us-ascii?Q?uvWabvurAofLkXOI0yotT1iJMUHQ86nAekjoeT6RYVJGrJpFPBpJ6y0RzJxt?=
 =?us-ascii?Q?7vl0ddF1emqsPqKos9egtae18cvboiJzMeFrwdQeTVQhc77/znA81xdiIouq?=
 =?us-ascii?Q?nZhXUPazx0Qymq+eA2gRIuenSdpXbBrLK4y6j/6qQ4hZAozF85X596HZZsok?=
 =?us-ascii?Q?TdL4Sb8wDlUV1nLJOCxlHt/k6KastaISMY9OQSLoImV1PNas+2oVDsaZZTPX?=
 =?us-ascii?Q?q9+MbE5gaB6DOz68ncyhBv1k4LECSMaaYReR18jY6QD6SbA5AQy4YMtdRDvd?=
 =?us-ascii?Q?czXPQManZF5PHTi4Aa2dzbPWfGfbggnH/hhqhZUDbjT/fJD9+7FWf/RsLxY1?=
 =?us-ascii?Q?1a8mbzQJCkyFFg9mZmObuNpDH2dWAkUMpHuaMOKIJfnQywCLBB8Q3Hhuv0xA?=
 =?us-ascii?Q?ReE6T5oZgQG1iQduA13lZlouBL7tzSKN9wrGVOAI8jsyjQSJSZsvOqaTSW8o?=
 =?us-ascii?Q?+QS9OQkwtgunIe9EOGdGts5G/P78pQrgJChplj1CSRWHSFSZUkrD/AL1BGTu?=
 =?us-ascii?Q?X8+2MmrBeJLT7bkmh0o+G91w2m8vIDvPNzKHRCAOveoCrgrllSGF/8niE/Ju?=
 =?us-ascii?Q?794MMuBVkTEyOBVL+qxZIcbbkDqUPAMdewT3NFXRhU+1IA8dyXVJYKkFcKfy?=
 =?us-ascii?Q?fBVovthny+d8HjZRTWiQCCbAEq+tYAQTKgTaQseuBjADOCNosNqJqhs6x7hO?=
 =?us-ascii?Q?nZY/HDdcmun9GeZtD63FKDS6nG5ybe8Vt1aTPUeAtqgDhSnNnjpEtOTgdO8m?=
 =?us-ascii?Q?xmg51q9sxeKiSaZZJ1qOiW4xr1tHI27KZ3azktCD?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d3475cf-819c-4e16-bdfe-08dcf346dda0
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2024 09:41:27.1306
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +e8+tFXHuyk6TSe66LxfQ+NFIJtNTqzU1e4nOuDD17LVwAROPsto8ZBhOhMaI+/5wbjYI3pDFuaxGZyXxHNfBj0U6a3z5M2x7Te8KIQlQj0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6190
X-OriginatorOrg: intel.com

Just found I mixed the present bit processing with non-present entry in thi=
s patch,
I'll resend after fix, please ignore it. Sorry for the noise.

Thanks
Zhenzhong

>-----Original Message-----
>From: Duan, Zhenzhong <zhenzhong.duan@intel.com>
>Subject: [PATCH v2 1/2] iommu/vt-d: Fix checks in dmar_fault_dump_ptes()
>
>In dmar_fault_dump_ptes(), return value of phys_to_virt() is used for
>checking if an entry is present. It's never NULL on x86 platform at least.
>This makes some zero entries are dumped like below:
>
>[  442.240357] DMAR: pasid dir entry: 0x000000012c83e001
>[  442.246661] DMAR: pasid table entry[0]: 0x0000000000000000
>[  442.253429] DMAR: pasid table entry[1]: 0x0000000000000000
>[  442.260203] DMAR: pasid table entry[2]: 0x0000000000000000
>[  442.266969] DMAR: pasid table entry[3]: 0x0000000000000000
>[  442.273733] DMAR: pasid table entry[4]: 0x0000000000000000
>[  442.280479] DMAR: pasid table entry[5]: 0x0000000000000000
>[  442.287234] DMAR: pasid table entry[6]: 0x0000000000000000
>[  442.293989] DMAR: pasid table entry[7]: 0x0000000000000000
>[  442.300742] DMAR: PTE not present at level 2
>
>Fix it by checking present bit of an entry before dump its content.
>
>Fixes: 914ff7719e8a ("iommu/vt-d: Dump DMAR translation structure when DMA
>fault occurs")
>Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>---
> drivers/iommu/intel/iommu.c | 31 ++++++++++++++++++++-----------
> 1 file changed, 20 insertions(+), 11 deletions(-)
>
>diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
>index a564eeaf2375..8288b0ee7a61 100644
>--- a/drivers/iommu/intel/iommu.c
>+++ b/drivers/iommu/intel/iommu.c
>@@ -733,12 +733,17 @@ void dmar_fault_dump_ptes(struct intel_iommu
>*iommu, u16 source_id,
> 	u8 devfn =3D source_id & 0xff;
> 	u8 bus =3D source_id >> 8;
> 	struct dma_pte *pgtable;
>+	u64 entry;
>
> 	pr_info("Dump %s table entries for IOVA 0x%llx\n", iommu->name, addr);
>
> 	/* root entry dump */
> 	rt_entry =3D &iommu->root_entry[bus];
>-	if (!rt_entry) {
>+	entry =3D rt_entry->lo;
>+	if (sm_supported(iommu) && devfn >=3D 0x80)
>+		entry =3D rt_entry->hi;
>+
>+	if (!(entry & 1)) {
> 		pr_info("root table entry is not present\n");
> 		return;
> 	}
>@@ -766,28 +771,32 @@ void dmar_fault_dump_ptes(struct intel_iommu
>*iommu, u16 source_id,
> 		goto pgtable_walk;
> 	}
>
>+	/* For request-without-pasid, get the pasid from context entry */
>+	if (pasid =3D=3D IOMMU_PASID_INVALID)
>+		pasid =3D IOMMU_NO_PASID;
>+
> 	/* get the pointer to pasid directory entry */
> 	dir =3D phys_to_virt(ctx_entry->lo & VTD_PAGE_MASK);
>-	if (!dir) {
>+	dir_index =3D pasid >> PASID_PDE_SHIFT;
>+	pde =3D &dir[dir_index];
>+
>+	if (!pasid_pde_is_present(pde)) {
> 		pr_info("pasid directory entry is not present\n");
> 		return;
> 	}
>-	/* For request-without-pasid, get the pasid from context entry */
>-	if (intel_iommu_sm && pasid =3D=3D IOMMU_PASID_INVALID)
>-		pasid =3D IOMMU_NO_PASID;
>
>-	dir_index =3D pasid >> PASID_PDE_SHIFT;
>-	pde =3D &dir[dir_index];
> 	pr_info("pasid dir entry: 0x%016llx\n", pde->val);
>
> 	/* get the pointer to the pasid table entry */
>-	entries =3D get_pasid_table_from_pde(pde);
>-	if (!entries) {
>+	entries =3D phys_to_virt(READ_ONCE(pde->val) & PDE_PFN_MASK);
>+	index =3D pasid & PASID_PTE_MASK;
>+	pte =3D &entries[index];
>+
>+	if (!pasid_pte_is_present(pte)) {
> 		pr_info("pasid table entry is not present\n");
> 		return;
> 	}
>-	index =3D pasid & PASID_PTE_MASK;
>-	pte =3D &entries[index];
>+
> 	for (i =3D 0; i < ARRAY_SIZE(pte->val); i++)
> 		pr_info("pasid table entry[%d]: 0x%016llx\n", i, pte->val[i]);
>
>--
>2.34.1

