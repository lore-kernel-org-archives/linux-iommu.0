Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BDA71891A9
	for <iommu@lists.linux.dev>; Fri, 12 Dec 2025 02:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765507017; cv=fail; b=XzSt3arDafjQF3CtLIb1uASut6qRbC0yMpxtV+O2wS++fFMIUQSb07Yiq+egTBC3UCnJLsCGzNHM/nJ2+fkJBdT+xbpmY7GDvnWQYWoGOfPha2FeW+Hq5F9uj8IseWH/BQ1SXdpspF4wv7B3WLyRvZj1A7bHQaJrzsifkGvOT54=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765507017; c=relaxed/simple;
	bh=cguO2FP9BphdUQEnMWSCL/7SEYDw7VUAKIAtUGozSKA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=W3Xj4VatkF43Jwlxpm4SV5Qciw0gHwIntacfzT6Qs3VuaAyMlwwx7n91twxC03EFmdOjQdRKuYvrDOisNOmkV5nXAzBwNho+Kh0Rym4Ei/6wR7ZI/TbEjHHUZDDgjqye/Exkfc6BOLzxAgud3YnhTXEExsFzhr7Ns+Yw58735TM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=elluPu/F; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="elluPu/F"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765507017; x=1797043017;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=cguO2FP9BphdUQEnMWSCL/7SEYDw7VUAKIAtUGozSKA=;
  b=elluPu/FRp4iFirgoI2mUtm315P1+TR3/4WU76pbfokyCZs7YmGxvFmC
   lF4kUZaDucSCHHLGvmGvCE4P8v853EyWtJwk0/VpwTzeG+TYTud8F+sIJ
   rLQD35A9kim0jRpSOU0Z27NqxaleocT4AnHep5cdTxgfWA+b1LLNt9PgO
   Zxza1+VHR9tsuFM1VVNZVY44QoFKj71+ykYun5UgJ75cTXQiUYiO6X1P3
   M9ASuqiMq1gDWuHMYp6JJOchVPdqZtaFTgLjCheNnrJXJWbYTHKIOi5Fz
   dPqBYONXjK5BUbBcLKRDzg9W9oTAZPuO/e5EVrbd3jcHFuu/wn1imGMm8
   g==;
X-CSE-ConnectionGUID: zXq6uKFBQraQ/no3CMBGiQ==
X-CSE-MsgGUID: xAFYMGlsT8idEecU+1DKYA==
X-IronPort-AV: E=McAfee;i="6800,10657,11639"; a="84906439"
X-IronPort-AV: E=Sophos;i="6.21,141,1763452800"; 
   d="scan'208";a="84906439"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2025 18:36:56 -0800
X-CSE-ConnectionGUID: 1vPspz9MSqK5WeBffujlpA==
X-CSE-MsgGUID: KYMO9YJqSEitzBcGMsLjyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,141,1763452800"; 
   d="scan'208";a="197012655"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2025 18:36:56 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 11 Dec 2025 18:36:54 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Thu, 11 Dec 2025 18:36:54 -0800
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.4) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 11 Dec 2025 18:36:48 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BIREFyFVROGPZZ4Lo1SAxiQUQFJY9bq0P4KUW//LJqBwWHtjeFoh/J8BBYV8upld2NNHdZ8lhqKkVM5Tby4aDaez0RyzJSpvDSn6H8eH3Jyxbn4H4AEMKR+EpkfHr93Q8ziQjB6yUSNI+okrLxUPTszLHcLPqzU9zyspTOvWSvrdtwSN7RkrvMDlb23TOORqZS04lgeaHWTvRpYJm1+uLSEZaGYYlWZPPN0ZueOaPVOVMDatqQ+Glw5YWJ2VQJbXeT2GSV8BqALlJaPRUBCF/bAWCg6SZe8ClAqFsdKH5tRBJoYzNqJ7e5VvBP+almetn0y+Do4rhxsWHtcD5rH/qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4GBFrHwOEJxVmfYlNMC6WNjbjO3myR7vUTHFUFWjD5o=;
 b=nta78ij7o+bHoo2bCjzW4Us/l3hiDE5fDhdwGoEZboKq/2utpkQrWlytlT2Og5+5Vxz7Z/yfRTtw8V8d4DC0Yn4kTlG14RTkwYVEooKyQN/oxg8Yw6UDM/weBDBOLVzNlAcevoozBhe2ngaCXJt0kjdisn6np4eF6F/K9hr33XQVGAVQLPX8+yrfPq2eaReod7av9AIHdlzOmIiFlDMQawsbfyt5YrGfZgs6JMLwLFYdqruyRtCds1ZnpLcGLSKcZxSSESAeR6VwcvOzytYfgdFcr5pAMOU6Lhx/NFxAogUpqFtjU1jDrWEbYnaZ+iTWiH7Y+uBFkWyIF9Ay+7adDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by DS4PPF2EEA5C68E.namprd11.prod.outlook.com (2603:10b6:f:fc02::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.9; Fri, 12 Dec
 2025 02:36:46 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%5]) with mapi id 15.20.9412.005; Fri, 12 Dec 2025
 02:36:46 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Wei Wang <wei.w.wang@hotmail.com>, "alex@shazbot.org" <alex@shazbot.org>,
	"jgg@nvidia.com" <jgg@nvidia.com>, "thomas.lendacky@amd.com"
	<thomas.lendacky@amd.com>, "vasant.hegde@amd.com" <vasant.hegde@amd.com>,
	"suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
	"joro@8bytes.org" <joro@8bytes.org>
CC: "aik@amd.com" <aik@amd.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>
Subject: RE: [PATCH v3 2/2] vfio/type1: Set IOMMU_MMIO in dma->prot for
 MMIO-backed addresses
Thread-Topic: [PATCH v3 2/2] vfio/type1: Set IOMMU_MMIO in dma->prot for
 MMIO-backed addresses
Thread-Index: AQHcVLXXOAUEiVu2dUG4qr4e/uuVALUdcjlA
Date: Fri, 12 Dec 2025 02:36:46 +0000
Message-ID: <BN9PR11MB5276D5D7338261F48FB863188CAEA@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <SI2PR01MB439337D5513729BAC122F526DCCDA@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
 <SI2PR01MB4393BFD04F698501F19013B4DCCDA@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
In-Reply-To: <SI2PR01MB4393BFD04F698501F19013B4DCCDA@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|DS4PPF2EEA5C68E:EE_
x-ms-office365-filtering-correlation-id: e5716d7a-7beb-429f-a048-08de39274b84
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?yf9zzhOG9SFAJJfg1+lZP6BS/VTeVFtYJFtFDHP6oXRojRORUZ5+KegHd1PF?=
 =?us-ascii?Q?lGXy/Tp9mz9YLAvfnnBY7Hfb/4kJAVBuW4jN4XqejcE+JEG50xGUKs8NHRsl?=
 =?us-ascii?Q?L8G1UHpW8OEmEzg0B9wLo7OjKzABHMRGq4zIU+taLmhovzmqR/vkiXS172ep?=
 =?us-ascii?Q?x4sF/CvHUbK3ECv4IdyesgyhPS2kjnMcuMZexK7ePBja2rpkkkqi4e7xMb8k?=
 =?us-ascii?Q?rpTHCffVtq/lPvFZS5gR8UXMDFcPa9u1F0QfEAY/Ab6MOxE3p4yHjum7ZK0G?=
 =?us-ascii?Q?HbWvEf4j/6Mlp70NZcq1bI74lDsotKKFydo/a+pEz2urgxBbPYsZjz9tgdBj?=
 =?us-ascii?Q?WkrAVzQTnQVlMuEsNQYmBnpoT21hilkPLWm4TIRbigzPEAof9TUjKemY3OSI?=
 =?us-ascii?Q?B9dnFQ3yY2Wa1SD6b0E/AgWkasOXrctaHS05TP8U/6StxzFwzX93U2ucfj+S?=
 =?us-ascii?Q?JAOlN5y+cBfStNymRJF//bjDH+fi4q6bXLo4IkWW+vr7uLGXlDzTtG+g4mf3?=
 =?us-ascii?Q?la4DJYx1O0/5cPJv9JbwIBN3EJ/zJXbBpbIuj0AN3dlkTsY+NPgeePqjFgCp?=
 =?us-ascii?Q?HsiiWFnQBa28ZIqeOU+It4BYYWIT/auOKHXpy35pFX49sOf2q8jtXqJG2KHM?=
 =?us-ascii?Q?hsT1Gmw/MQUi9dz4N9Fq9wge+JaK35UttMBadqoOhSu/kyFlteqbAglvjWPf?=
 =?us-ascii?Q?myCxC4g+c12bj0aXqwgQOZ8C5QgTWUng8IqyIUVCIkLLQwOp641uXxmfTG3w?=
 =?us-ascii?Q?KBR00GqmwhULPP8aWaBcBPEk2xgH+A/lJK3TWixfVIOBhPpPh9KbwFQ2tqud?=
 =?us-ascii?Q?2dtjM9FG6+oSsbalVzX/ygPjpjLQ5eFYQmKxyYkUONidoWAS7cNZbPGrdjfu?=
 =?us-ascii?Q?+CImZtZKjWdgYMiX9HMHR99ZQdMZErgd9lKxzd7lKh7YlSYfEXdZ7/+FkL0l?=
 =?us-ascii?Q?H+Zu1kFTzwLvwaHh60aFZqUIAqHourwlZPhL2Eu7tsYpq2LG4tgFrZUy8TAf?=
 =?us-ascii?Q?DgatrnN26L0OIdGIO7TFhcuWidEXysK2Rjdy90EwNeoXDpcXaYDJql3Qi3fZ?=
 =?us-ascii?Q?muF/226h9bJ9nD7m8kxUxG7RPYbuPOZ0z6HMTbSNVbDU5HjNrjcUirncbnKN?=
 =?us-ascii?Q?aD0J45koxBhW9uVGQZ75tcLHf79Lqjzk4PAEw96VpPEihhHzaVF52ZI2gAZm?=
 =?us-ascii?Q?q82UjyLwVkRhwBrTGsLeQUCrqXqLK+4xmVdq34GFcn6SSCtb0fYV94HhOEqA?=
 =?us-ascii?Q?4tAdqxnL+OCR/DgO0gwQmI07h77YkentT8KZ3gUwmvK9DmZuE9gAX6q0JC1o?=
 =?us-ascii?Q?DdSeOr5B7turGe3uioHuUBycDoO41+TBh9UpBmdYu2U9eXmYFguxXxNFdWPh?=
 =?us-ascii?Q?diu23sjN30ExebyGDYeO5A7iELsAClasZQbxK9sH/M63geGSa/Ji/sKO753v?=
 =?us-ascii?Q?dG+u3apMp4mOpyTLfkeF5GF8e7lpWG7ncX2cj8OjcApxCK4Ae2abqJBtUjEM?=
 =?us-ascii?Q?swk+T3SXlGyKlm4/QWwvKtVYkAy2JTj9bQtr?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?sFdkwZi395YAzsv7GLsco3NS7AWWF8gGNuMPZdgA5JhffS2xarIAzYkQQzAg?=
 =?us-ascii?Q?b3hc8g+wOBQdXg0zjp1gqYhBdwKqV39FBL1pwvRoCH5AZfOo6jridiTly+bN?=
 =?us-ascii?Q?19Aoyzna//HyPMwV+aM/8gNRmj8hLpPtSvyPrCCY/vwFBiyXjUOLcCNNOM+d?=
 =?us-ascii?Q?sqTUyE3zvZi3RRdwDX7QkLrM50XyICpbvGGVs9Krjr8LJYacPHj2I5oyXLca?=
 =?us-ascii?Q?RYvqVaxt3Aa2bSMPr22hWNDXbQ/av3SI2acYYwSJeYeL6jLMtI+97e7i3DV7?=
 =?us-ascii?Q?yp+K5mgL+L31zRdMObsDL1F+fNMNadWa1tMSbU9mf2yVy8y0/cl4/sNP27hQ?=
 =?us-ascii?Q?Mr2Qm9KYmFh7dl09n6HGGF2u0b3asgR9dwlVY1q15CD1ANlOSjYvYo12dVf9?=
 =?us-ascii?Q?OF640lP43S5Cv00cXGyXkBbN/cwgi5HpGOU4ZbOaainCEy0dtSufCYIc+aU/?=
 =?us-ascii?Q?FlnIOfRXtqldn0quHXyC2imBSrZgJ2rD/7XU9fGUwoIoCsiol6lTAmnDLFLk?=
 =?us-ascii?Q?TLLd4j40/nFMc1FFoYImuUcVhqjO3QzKU9sFO7IAJxC780N1g/q1Qo7H6fD9?=
 =?us-ascii?Q?9y/qQrvSTXfN1B9Z+6oHiXHXWz2zeTvwjij1fHCluvb7Uz/UboycXsUk0Zx/?=
 =?us-ascii?Q?SNBi3hZ8ylC751BU61lxFLZDIGLPBcKd9TNDh4g7dE3umNCTVigbE9AH4Tnf?=
 =?us-ascii?Q?skc4xCXR+pyeu8hgw1EwC/fitR4Bwd3WNO03Zdeq0OZePLAb85acUB37rI/7?=
 =?us-ascii?Q?aiX8JG1VevwbL5TE5d1oGV5+u/aiYbTWIMBXUflQO58coW0BF2BP96yBLBAT?=
 =?us-ascii?Q?Bkv35/qOraQWpJPaY50V21FakzGeS3dqlo+6n+a0dPO1K1eaf2L9pkFK4uya?=
 =?us-ascii?Q?iKQYh0YyO4lWn8xDjBoc6ppqdjybU1EvHqJb06XMcCf4qZ/17mEBkvrILTT5?=
 =?us-ascii?Q?cJSJfU8wbXKjSItyxoqAcYSFNNzFxNpLT+CARfe4hQPXvagjuYe1DO9klgCb?=
 =?us-ascii?Q?a48X3hMP3Q7ix2HvPME5b9x+S4SYC044OuJi4wzVU+kB+MFKEP9Sh2pNiNZm?=
 =?us-ascii?Q?YS3q+Hv+Cjl9Idd7v6AjyfZM0D484wFtvlie5mjK29O91Y8fdkNJtZFLldC8?=
 =?us-ascii?Q?vALATEfC0pxYAIqtvst2uqqQPacNfClIKodFcthWntc+oBkqb+vEABOo3saW?=
 =?us-ascii?Q?eYbbJ7DWpzrGvYmnIxY3SdrkzbcSK+EUmI9Nxf3I0Ug/7569LYIQFXdqKylS?=
 =?us-ascii?Q?cQOitzgAUo+bkewha5z8VwfW0WiPuaxTwIek2cGqOXo8jD1lX4Udc9dkodTb?=
 =?us-ascii?Q?evYyFFwD73aRd8PnwL23bYE1afxt7vGp62dsXHqh4J0eErYEAyorWW+f67GG?=
 =?us-ascii?Q?ZvlMnpZSSIh9MJsySNj1y+rW88bxf1YFz9ECWUWdzh44lARlMA4xm0YDpaVK?=
 =?us-ascii?Q?rTT1Fk0LvyMge31pBmYDIaMrhF9Jt742rObVqcpd32DQy+tqWdLJ6OxL/olP?=
 =?us-ascii?Q?Un3DknMQEL+4MUy0/ljEU2mWF1I7iKQgx4WLLvUzpwGl5SlvVvN9voslkbb5?=
 =?us-ascii?Q?K4A6wHaH7WP7XDx3xUon4AilPVJ6D2P3PjHXv4fb?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e5716d7a-7beb-429f-a048-08de39274b84
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2025 02:36:46.6547
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GoU35O6ZMtJOBOR3nzzdMXTXBP4RQ+CYfM/w8kCN6ieZZC29tazwrJerEGnBarUpTwx1uqe8wtzAGOMWBAxKQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF2EEA5C68E
X-OriginatorOrg: intel.com

> From: Wei Wang <wei.w.wang@hotmail.com>
> Sent: Thursday, November 13, 2025 11:54 PM
>=20
> @@ -629,6 +630,8 @@ static long vaddr_get_pfns(struct mm_struct *mm,
> unsigned long vaddr,
>  				ret =3D -EFAULT;
>  			}
>  		}
> +		if (vma->vm_flags & VM_IO)
> +			*prot |=3D IOMMU_MMIO;

move into "if (is_invalid_reserved_pfn(*pfn)) {}". it's pointless to set
it in the error path.

Reviewed-by: Kevin Tian <kevin.tian@intel.com>

btw another alternative is letting userspace set a map flag explicitly
e.g. introducing a new VFIO_DMA_MAP_FLAG_MMIO flag bit. It's
not considered because your use case requires existing VMMs to
work?
