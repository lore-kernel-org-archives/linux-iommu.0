Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 320CA4A32
	for <iommu@lists.linux.dev>; Thu, 25 Jul 2024 00:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721868253; cv=fail; b=OYmI08NWO3hk3sEXcXWQyJ356hVNa54VNTZWTo3VAVcLaC3T5roxvRR2ecH9dkjHAjgGxlD3dWA/2y2n2bwckqurU9BfNubP9lDlEoz7VZ9Vri/nBfQUauitQ5KGk/Zq8Khx+wDpO+NcTYWR5i9NVo1HFbu7v6GaWVcU5nO9up0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721868253; c=relaxed/simple;
	bh=ddriNhIjxcmilj/iPrn66GsyLWvlsQfIlL0sPlMca6Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OvjiMkL7vyj3JjFfgSTgP5rlgne4p2m2pJytkbrirWara9+xOpzFVe4NSfybMNP01qEatCfoDcY2jwRmfXUch5+7riS8GREUTv7GVvARlXgRI86BKga1BhQ1b4e12nOidTwTBKBgj1s6JdRpp7wgCkPgMfwLCI98tH794eD96Io=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oJNOAbsU; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oJNOAbsU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721868250; x=1753404250;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ddriNhIjxcmilj/iPrn66GsyLWvlsQfIlL0sPlMca6Y=;
  b=oJNOAbsUY1foAqtcYQgZ3VyVrjB538F0TW3zIHBeK2ttwT1TNNt9ppaT
   N92HoDgcpklq5Ow+kBK7ZHOoHuCPidKZvw/62w4NB+1L4xtE0yLBF7CYz
   nuAAnxEuOYbmco4d/0cgo+nti283ev8GizUebPnEGjC2VxX7AwkNu6aoh
   Tb9ld8WJEtNRfHccYNe5jA/Oq1McyUfD84tB+yWQxHPFiZeD8Djkoopir
   jM7FVDIq1S5C4gM5TnxYrWfvpfj4VXR31gX93JG1bHTj5EAr+/mJo7P3x
   5QCU7C1V6Aan6CrmNzH63GiDnHISwBE29iQGZwYmhuS/hZZbPLnRARZ3p
   w==;
X-CSE-ConnectionGUID: CvBob9wHS06k5Xllm46gPA==
X-CSE-MsgGUID: eZv+cM9YRiO2spiXx8SoBQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11143"; a="23443578"
X-IronPort-AV: E=Sophos;i="6.09,234,1716274800"; 
   d="scan'208";a="23443578"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2024 17:44:10 -0700
X-CSE-ConnectionGUID: kiiqwsGiQ7CNt7w4V4/mUQ==
X-CSE-MsgGUID: COsKY7rVTtmCMFcUJa+t7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,234,1716274800"; 
   d="scan'208";a="57053831"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Jul 2024 17:44:09 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 24 Jul 2024 17:44:08 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 24 Jul 2024 17:44:08 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.172)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 24 Jul 2024 17:44:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IOp5xbbXgiDtnpdAkTQO407k1/s9yDcTkaaD/0iFqcI8S+C5y1+qYwExmG7nsi4/OkGyd76ZLHqp5SgUZAvDYwF7gIT118vxLdwJ2s7h3MPmc6movswhvSPonBguowjkPfaKqcavA2SRFvdJ1S3sB9hIhkK20mw/FTv6dieFrkN+Vl7kV0yDfAKWOdFpiYiO+ggV9T8zDa/5COtlSYrEMQjEed38+fqMd8qwF6vsp0SQ/w7p/mYSJr7OnGrzcvnwPuOOg6Dfif2eC6nUsuUgXCH7PJgGM6AeJR4rqWBGyc20g4kfWGFoY/eXwJ+R/pI2tlE5KqhK5trlqMF+XwlKCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xH/vBIcx4jEAz/YBkRYw+6dqsDmMQKy8p86ZkwIkaLA=;
 b=f0OTP9Ve8NpaLOuLG+SvvraJrKWFoexDTwo1KhqGOYunkFDrNvyqaM87AJkyp5pQbeqcnqVlxXosWYhd3P4V9nBWrmWyYKF/4Ponon+Q1TtVlnKfnVtVT4OkBj+wyOO0tI273zv6dwrRsTS2t7kAXjMGj/5rpfy90sHTxwc/vzH41nK/JEH6pTcI7kAt4TZfF+ofcGsIO5B77u7LluTIHE3AalGIxYRtAnepai1EkZBNmFfmj5CzJtYAHx/WryOCRKfS/ND9ioNRff+A5PrgoFfhnVrNjf3LZ2u6kZd7i+7ZdOWCvQM7Zzfm+0OZD5K0Gv0aQTkR7mN62pXARA8uDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5271.namprd11.prod.outlook.com (2603:10b6:208:31a::21)
 by IA0PR11MB7693.namprd11.prod.outlook.com (2603:10b6:208:401::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.28; Thu, 25 Jul
 2024 00:44:05 +0000
Received: from BL1PR11MB5271.namprd11.prod.outlook.com
 ([fe80::5616:a124:479a:5f2a]) by BL1PR11MB5271.namprd11.prod.outlook.com
 ([fe80::5616:a124:479a:5f2a%4]) with mapi id 15.20.7784.017; Thu, 25 Jul 2024
 00:44:05 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
CC: "iommu@lists.linux.dev" <iommu@lists.linux.dev>, LKML
	<linux-kernel@vger.kernel.org>, Lu Baolu <baolu.lu@linux.intel.com>, "Liu, Yi
 L" <yi.l.liu@intel.com>, "Zhang, Tina" <tina.zhang@intel.com>, "Kumar, Sanjay
 K" <sanjay.k.kumar@intel.com>
Subject: RE: [PATCH] iommu/vt-d: Fix potential soft lockup due to reclaim
Thread-Topic: [PATCH] iommu/vt-d: Fix potential soft lockup due to reclaim
Thread-Index: AQHa2gc1KcNzc28ILkuz4h1++7d/drIFgnoQgACVtgCAAIi28A==
Date: Thu, 25 Jul 2024 00:44:05 +0000
Message-ID: <BL1PR11MB5271D3D84F93BA16852233F98CAB2@BL1PR11MB5271.namprd11.prod.outlook.com>
References: <20240719181725.1446021-1-jacob.jun.pan@linux.intel.com>
	<BN9PR11MB527638BC2FD50C4D90508D578CAA2@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20240724092540.6ef4d28a@jacob-builder>
In-Reply-To: <20240724092540.6ef4d28a@jacob-builder>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5271:EE_|IA0PR11MB7693:EE_
x-ms-office365-filtering-correlation-id: 2b4e39cc-6e96-419c-7473-08dcac42e32a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?lVA2W2mxn8yPnuOFjjy3Rp2r0xBOGVLW9FlhMngPe9QYrvgnsc96f9p0sNXt?=
 =?us-ascii?Q?/IoP8hMOMGx+jmFKVuAYTDxuYfExxbaghqi0eq+6d+VMZ4thaPnEtUL2nocj?=
 =?us-ascii?Q?0HdhXUxfRzcizPxIjDFzpfutn+xwjdErHOwvwyx8n7Ei+dTMopjOzwUVouzO?=
 =?us-ascii?Q?hmlicvTohEFu8tKzovsddnwOx7aOp1M0ojsG+ZNL1s42V4HX+frZk3RWTWSX?=
 =?us-ascii?Q?HSMTRjFbfwKjZq8vtaKaVbPlMmy+40KcsbqCoo5xkrMNQ4uJ5IAqilKjHxru?=
 =?us-ascii?Q?3GabAex+Ul8w/0XalfXFKM0uvy9F6SVPlBEnrdvs/JtAJT3OVgSD+jVAjlx5?=
 =?us-ascii?Q?9mNJ4h5AJ4gx6fMA7K9wpnRe4A6+CooXFCp9X2YwIm8XbXHfjYig2OWjxWmT?=
 =?us-ascii?Q?jgTndPWnhme3M5VPTfrEcgEfDXDBhT/kFPEti9Ehba52ShNIVfnQyVXTTh/x?=
 =?us-ascii?Q?ZEhWcWcjjOXSwIKK2kGacdB10D8dj7C3vWWmCmdefAXOg5vDTds1MMFDkHP8?=
 =?us-ascii?Q?HRbAZd2XOA0YzCQ2oWLBBtjKypD66k533NjHXR3i5eFmz7IXh1pqVLID8tuo?=
 =?us-ascii?Q?4lg5+18/7ymBTGW/5hE7edGKf0cj5bPIWjb6U5k62Ba6/IMQ4WukdSihPce6?=
 =?us-ascii?Q?eV5KfPqYEVhw+IVIrQmibhMICn7wuxKMaWi+Re7ib4ttsAzq1t/DYMyawYhj?=
 =?us-ascii?Q?Z26g3+LkE6M3iFrOEg9jT4mUgT1of2Q32W7uWDU9mjB2GDV9XdN8ChXSDkLo?=
 =?us-ascii?Q?vOg0KV9oLLMS2t1M/ejiBrXEbnEVftzagdZZyrj1LPLsky0iJD18pXfyLlt2?=
 =?us-ascii?Q?0/HUa/y/fQVGmAx6b55+EPP/TCOAM9vVpUeqVfHxhCRNQ19DmXe+tU/BNc2r?=
 =?us-ascii?Q?EilJyvKUcxTBlfM1b0S8HtbNSuhK9LU1jDxnXPfktyRpwT4HLHeQ5zxskZqo?=
 =?us-ascii?Q?NdNmTgzSO4ectVzqIBsh/7lbLOz8H60ekrvUjRw6Lr/TQ3mx95CkSwnn0pqP?=
 =?us-ascii?Q?wJlQLwMHSRnlCgEx0bKLfYrmbW/q/kLRmvvE817poDCwjaBiGATWjjhqqv6Q?=
 =?us-ascii?Q?rNrWTevZ59gyjtojkB7ouSNaZZYnRe1RHEecrX4il69t/Jn+EfX3TSDSSZLR?=
 =?us-ascii?Q?Hs6pKbaE9qMoJx758NgmjFKKZ1z5+LWZ4r+HZdKufdtGJj8C3qE38/wq9QzJ?=
 =?us-ascii?Q?a/to1T/GfHUiv+xQ+3ysSoviNh6ifXu2AIFdunQxs96NChKUMadkoNfSAE16?=
 =?us-ascii?Q?BPcJGbtpjO8L7HRcRmJA04PUgAcE5mA5TqHCO53KEHYJK5BzZV3YxGSEtW9F?=
 =?us-ascii?Q?LQeuL0oCFB5eUzfxuTMbYYQ/pq/3WBAUfoG82oetWiA+t2dxE5+wVlI0AeWi?=
 =?us-ascii?Q?EiXD1gThVZPBwjH+NB/Atf77whyVpxDY/Hyc+tM2vN+bflkXnw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5271.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?QCVSvOlc/JlpKmBkXojDDYv4WgH+lV7BT6q9jdM0ar3h+r37e0DA7cjBz4B4?=
 =?us-ascii?Q?kk0v/g6zNBCHmT8fjNl15e+lI4fg5+hYJ4VkB8IjPCDswc5FdEjgU7rm4ZcA?=
 =?us-ascii?Q?ezXOz2o/59Ds0gqFK9FyQLRq0akUx065xVSbcx/62DRr9iNn1EPrmJUDxKam?=
 =?us-ascii?Q?IhNvZ54brhjMUiyeztLX7hz6UQy/mjjqb3qqvCl2SYl5ElR8DKm2ssp86Vir?=
 =?us-ascii?Q?z8Y0AN4py6639gCBbzglAtpEw/k9cYX3ChsKX8x50BqNgWEcjHaF8xb+pc3M?=
 =?us-ascii?Q?Daj0xHA3YFLC8BjUqIK+ctu1G4ZiyTeuMlepSVFe42ys+Pz7oU07b/+ohrfX?=
 =?us-ascii?Q?8TaUvb7yHrguieCEGgPfJh18uZnS/xPT/zbTmY3moddFo5EywvoQOA4UNJXl?=
 =?us-ascii?Q?U2xGJeiBv48TyW3yXZ0wMm+hKErjFLQCwYyjSWKKtHN2rN7w+78at9wu+nKB?=
 =?us-ascii?Q?TLNrVy1K3jg7+MCcCB3NWH0OtbPNfN4ypxAPLW4wUPvtduMyEOF6ww6Ttf93?=
 =?us-ascii?Q?pMRxsfmHyUh2Xe0MDkofTNNZuC3VkHfnW/Dk/9IEsty8Xc/ODB9fjw9EDWcW?=
 =?us-ascii?Q?TsQIek34fsaxEZnotuNi4ZAJ/GR+BMN2OVULsk6g4ZCOxJBJTQi+eMpt4wQ2?=
 =?us-ascii?Q?eVhfbm1YeLCB//mvpXbyRKEKPW00m96BwxrvLs42ZBK0+8dXlLBVVJXEr5Np?=
 =?us-ascii?Q?E6i0KCMI8V1HDnA1VKTXHBdx62znWoorWAKB1ciFoblWQmrua0PZHNciBRXm?=
 =?us-ascii?Q?i9SugUfBkJSU9NY6ds2nmdnG96iJTcb9K6q5ElY+EmrXduoty+bu/CBJ6kf1?=
 =?us-ascii?Q?aN0B80Hb4jLXVisXEPiVBugEl6anZKYMQgufhLSy3C8273E2pdz3l4mUyRgR?=
 =?us-ascii?Q?9mWtet0AXH45iIfyK2bwptENWbVWlr2HH3uSCre0YkklqR6/msXD9ERlnPSP?=
 =?us-ascii?Q?xrIuLJ+1UvDswtOwW8mYZ9TXyyvM80IStgQ0D8HDW+vmR85Rb35k1yi6tl8n?=
 =?us-ascii?Q?5/UaXfhcPSZzT1McJe35zylRWl8yt2jkHm2y0S6PkdftJpk3jIA3Lxh58PBY?=
 =?us-ascii?Q?dxNGHaYVXOnPXqFNUdWYARzwzWjUjnP6dYhLSWu1wXs+V2e2gQf+llmKseE6?=
 =?us-ascii?Q?KJDxV/lqd0Wwpd2Cj8t+7ZVSfUwdzYU96ULF6EtqYZJrbU2vDmiO0PyQShpS?=
 =?us-ascii?Q?d9+iC35tiuwYkiHwJpuA/INcgztQ/4+1Jx5at9IBwDAfUMQqrH36ou0rS92e?=
 =?us-ascii?Q?+z0zSvhTMn24p9ajOc2dlaA5m4L8plVzl6rYBYfq/dA/ossNyD4411ksD8oD?=
 =?us-ascii?Q?PDD0XHaBt6UbWfFHnL7kLTKJdvZUCsWh7mYxXsEALyKr7zmR1Dlf7BrFO2eu?=
 =?us-ascii?Q?od5emXt84d66FsAg1uEciAN3oSXLQFPKdRSpUW+y3fRUTlMM/3C1hqjBgNfr?=
 =?us-ascii?Q?qOXn4XPF40TJ0Pgf9Hoo4JkcZuW7/vmyJrp/dDz5Xiq0aVcxhPHQ+mtopHBt?=
 =?us-ascii?Q?pOVFpsTuM9jkpYdZ9wjnyaj45NmL5NUouDEfdgka5hqXxe3HoOX6u9IhMqP/?=
 =?us-ascii?Q?Ett9hUPAV0HGn+doqoQivw8U/iq73z+nqknlOuyS?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5271.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b4e39cc-6e96-419c-7473-08dcac42e32a
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jul 2024 00:44:05.8655
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /17Qxe7XFv3MWg0nmPup2/ZFJgEs9KQeiQtJo/P1e7J6M3dVWKnNNkfEB/AGo+zLTGUbXDf2VBTrY3Hwd5sFIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7693
X-OriginatorOrg: intel.com

> From: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Sent: Thursday, July 25, 2024 12:26 AM
>=20
> On Wed, 24 Jul 2024 07:40:25 +0000, "Tian, Kevin" <kevin.tian@intel.com>
> wrote:
>=20
> > > From: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > > Sent: Saturday, July 20, 2024 2:17 AM
> > >
> > > Currently, there is no impact by this bug on the existing users becau=
se
> > > no callers are submitting invalidations with 0 descriptors.
> >
> > bug fix is for existing users. Please revise the subject line and this =
msg
> > to make it clear that it's for preparation of a new usage.
> The bug is in the qi_submit_sync function itself since it permits callers
> to give 0 as count. It is a bug regardless of users.
>=20
> I put "potential" in the subject line to indicate, perhaps it is too vagu=
e.
> How about just stating what it is fixing:
> "Fix potential lockup if qi_submit_sync called with 0 count"
>=20
> Also change this paragraph to:
> "Currently, there is no impact by this bug on the existing users because
>  no callers are submitting invalidations with 0 descriptors. This fix wil=
l
>  enable future users (such as DMA drain) calling qi_submit_sync() with 0
>  count."

Then please move it to the start.

> > > @@ -1463,8 +1462,14 @@ int qi_submit_sync(struct intel_iommu
> *iommu,
> > > struct qi_desc *desc,
> > >  		raw_spin_lock(&qi->q_lock);
> > >  	}
> > >
> > > -	for (i =3D 0; i < count; i++)
> > > -		qi->desc_status[(index + i) % QI_LENGTH] =3D QI_DONE;
> > > +	/*
> > > +	 * The reclaim code can free descriptors from multiple
> > > submissions
> > > +	 * starting from the tail of the queue. When count =3D=3D 0, the
> > > +	 * status of the standalone wait descriptor at the tail of the
> > > queue
> > > +	 * must be set to QI_TO_BE_FREED to allow the reclaim code to
> > > proceed.
> > > +	 */
> > > +	for (i =3D 0; i <=3D count; i++)
> > > +		qi->desc_status[(index + i) % QI_LENGTH] =3D
> > > QI_TO_BE_FREED;
> >
> > We don't really need a new flag. Just set them to QI_FREE and then
> > reclaim QI_FREE slots until hitting qi->head in reclaim_free_desc().
> We do need to have a separate state for descriptors pending to be freed.
> Otherwise, reclaim code will advance pass the intended range.
>=20

The commit msg said that QI_DONE is currently used for conflicting purpose.

Using QI_FREE keeps it only for signaling that a wait desc is completed.

The key is that reclaim() should not change a desc's state before it's
consumed by the owner. Instead we always let the owner to change the
state and reclaim() only does scan and adjust the tracking fields then
such race condition disappears.

In this example T2's slots are changed to QI_FREE by T2 after it completes
all the checks. Only at this point those slots can be reclaimed.
