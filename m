Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1FDD2571DA
	for <iommu@lists.linux.dev>; Tue, 25 Feb 2025 08:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740471397; cv=fail; b=HetYz27NFARST1VE5K1dnql/n2VXLvVYW7IoXthF7ABNmsm70TUZeT4WCKkSyXfQTggCEXr//1KIJdSfaL4/U/nP+/cXIR3YKNSR9XsblQYls7jtJFDGW5e8rFJwPNPRrIud4GEnY8K3duG8twsmIKR0qDgwCGrefmbM/LwyL+4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740471397; c=relaxed/simple;
	bh=9tALInEYkmO86FKGGS1uCZIpUrCytiYe0sxAqcc2ZNY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=eG/CTNgTICIZHbmvg3243c+6ojVBN/JmkFTh8RUXLfFHz2sgGNi63NP+B7hGP/QfNnVZ71Aya6Zu+T70svGSlDVcbA6zfRXlpWG0Be4uJzlOgXLOyN4gF+W2+OLW2E26lJ2uyFH9karKY8m3Kspq5nVFxMXPIueFjQyGTd/1pM0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NAZVaVvD; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NAZVaVvD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740471396; x=1772007396;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=9tALInEYkmO86FKGGS1uCZIpUrCytiYe0sxAqcc2ZNY=;
  b=NAZVaVvDo32RI1snaq2VhUV4lRkYr5x614HpILBIKttJDAbpLKy4HZwO
   V7n1k31N1Di3Eo4ib6OIbSJMtRbX+gxoixB/3frxZaH7wq03QkGXHaA03
   OlVVWbeV+ooxXhTYNOK6VhLKtChhx3CHqjQEriWeROBo9LuCqJTi2QJrj
   8KAEFcCqPuzO2bWl2RMVLeVHL7KDWSH8FZFnIbbFcJk6EpFv6CZnDRyGg
   5YAsEH3KVqJ79cS8836nL318/EhhW9rlCZQmJDKYIrX6KsKtgGk2QCbrf
   nOkCLvOwHN0B2IsySMWJ/ZwvSY8dL4FEpbF7qKOKrxdP/WJYmV524VosD
   A==;
X-CSE-ConnectionGUID: cuxB3/jvSdKRYZ2Q9rHARg==
X-CSE-MsgGUID: WyvWWbX8SaOzg1HZyq+YvQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11355"; a="40450782"
X-IronPort-AV: E=Sophos;i="6.13,313,1732608000"; 
   d="scan'208";a="40450782"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2025 00:16:35 -0800
X-CSE-ConnectionGUID: itE+CER/RJe94JT1DPQbGw==
X-CSE-MsgGUID: GT9DgnXHTJGi1mLj5C0ydg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,313,1732608000"; 
   d="scan'208";a="121260127"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2025 00:16:36 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 25 Feb 2025 00:16:34 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 25 Feb 2025 00:16:34 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.47) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 25 Feb 2025 00:16:32 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TO1WKJUQnuYUQ5Tg+k/SSaK5esLBMQtxdo5HJx1ljyOIfk4GKFOZwdjRAGoaPOeb99yyp4WNUqKwPBbWOgVgheUw/mwWXo4oMzSl5CheTKMKfLCws8Kn4Wx4C6fq3zHBkc4c4UmlfW399vV8ojmmjCX08MIq4kmpBZMpeTxnkxbKg/3oPzkGGAkAIYHpfFKWU9t+JWkgzQ43m87ExWVHhxF8ZdnlWXCj88brFK86guftlrh5jGhRnC83i2nxQ5BVMqRgJpmylWZgBjwiN+9nk/FyTn7j7vPpGIW5ejFcrn1Jir3psRTyJux2d5+BH81PDY9+HxmeHWs1/dhcB+DVaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d61zSwjNPDAtjlw5v/cthDSQD+uXuPqxc2Jay0gnR+g=;
 b=no2UQC25DXIwXNvlrVfH5HZbU8UPDvufvUc+0vnZWVen2CMJ8bQ7l9/3/pX0U6zy1WTqqB43g9aGP3EUd4wX9nP96ltA2jcOJgkSqvdtDBHlVp2Sm3kxdPT+RfwL2mjhHAot9ALNg7GlCJC0MYe3PV8/fJRjI6FtmUOcNxAvyxMuyEsqGGnOB+WcwpVax+4a9l3NtVwgUPOO4bEBi9PJFahGe9Iv5soZzVHecCHMd8jIf99hco6WUeVVvvm5CYjm/Z99rAycHFrlL343JlCDfTTgQK34vT6NYysayETkX0mBygDAbNdys8o6nW90b0hHaPkW2+P2korR24JnT2Utsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by MW3PR11MB4620.namprd11.prod.outlook.com (2603:10b6:303:54::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.21; Tue, 25 Feb
 2025 08:16:31 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%6]) with mapi id 15.20.8466.020; Tue, 25 Feb 2025
 08:16:31 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, "Will
 Deacon" <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, "Jason
 Gunthorpe" <jgg@ziepe.ca>
CC: "Jiang, Dave" <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>,
	Fenghua Yu <fenghuay@nvidia.com>, Zhangfei Gao <zhangfei.gao@linaro.org>,
	Zhou Wang <wangzhou1@hisilicon.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 08/12] iommufd/selftest: Put iopf enablement in domain
 attach path
Thread-Topic: [PATCH v2 08/12] iommufd/selftest: Put iopf enablement in domain
 attach path
Thread-Index: AQHbhntO+YT/XCdzMk6tmzPhGWX2vrNXrbpQ
Date: Tue, 25 Feb 2025 08:16:31 +0000
Message-ID: <BN9PR11MB5276852398C05D067FEFB2DF8CC32@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20250224051627.2956304-1-baolu.lu@linux.intel.com>
 <20250224051627.2956304-9-baolu.lu@linux.intel.com>
In-Reply-To: <20250224051627.2956304-9-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|MW3PR11MB4620:EE_
x-ms-office365-filtering-correlation-id: 2e746c87-a940-403f-ad55-08dd5574b5c6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7416014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?G+EcI7vBHRsKBXZe034optXSl4+1Z+jIy/pvl8sq43ugU60mo2w81eoAOuhE?=
 =?us-ascii?Q?S/pLH46WRmDxPbrqCihZBccP99C8IM9Tgzh+gYIhbTgKC0TQ15xaPaA/hnvG?=
 =?us-ascii?Q?Az12dBra55zVXglz3f+XqXoTzRZB9FZLSUd86Kv6YDGkhfXTp9R2wloZ8II7?=
 =?us-ascii?Q?RHCawn3DtRNlHAnzOkUy53tFI5Zu0RpTPfe+1TGqVJ0pXicKzQpSaQtfmmKE?=
 =?us-ascii?Q?ZuJrdMoUMUmU/3aGEr+b9U/ufgEExALde7Qri+J8ET/ElMjTrNyw8OeIOr1h?=
 =?us-ascii?Q?YRkKCGPS9eaK2YNq3w8hAPtWi6FTMBtub7X/lXsWgTcMoBLgFx9RyXXTbkTF?=
 =?us-ascii?Q?P5vefJTw5P357FpY/1UTvKYAqvmlkn1PAaSewgcH0M2uroFRN4YJpL9IuheJ?=
 =?us-ascii?Q?Qo4Nys3SFuz0umKSxOPXhU5cFsIqWt4X/YiU7s6z7hwy6l9bQqvbwMAsb/PN?=
 =?us-ascii?Q?KPQYYh9UbYvDdKhiLQxisUByxEMMot9dkbAmlf/TSLsMthprUG8OBm62c7W9?=
 =?us-ascii?Q?WXCSsrHsTjBirgEFrOeoErfR+fehK/Lg1SliJmU9KoC78lKCJf9ep+MvsDTt?=
 =?us-ascii?Q?onhOQlAvpEz59Gt02TKWnBZfGuYNH7AxhCpG2AUBdhnMZeGl87XuduNGmXyH?=
 =?us-ascii?Q?1nYtqZhumREFzGmGWHOvxNVXDJJ89tXIm37uxE0TgUuJaKuQM1Ezur1W6jHB?=
 =?us-ascii?Q?1nSsIR36tHuqyfUFmJzvvSzAYZ7HVYAUHUo0/qALR/W1fMPGNSdAETGNIHaA?=
 =?us-ascii?Q?aYCVzchLJ5kAoZQXObNjFILttzeHEabM49jG8uCGaQoUHhut2BDahJM6JIdo?=
 =?us-ascii?Q?F8uqPLSF7Ir5gMWZM27MRMO2LsynRHIRK93mMGT8ZeuP5pYFVwqK75Mdp4+/?=
 =?us-ascii?Q?msCKLzF89p8TMGXFQ+T0dvsvp9ZKiVfICH0VTPvOjdn8ze8ubTSXaoxDIAPX?=
 =?us-ascii?Q?9OPBBZj5rFMMC8VguD/rK1NyUf4ipuddmyRR7faaenwNA8X38RFpv4JF2DVt?=
 =?us-ascii?Q?2Ggdc6nD5UxYTiMBsO7oH/nLNFlckE/zcWxoAwtpYPra0eErswhk+/xS+Zv6?=
 =?us-ascii?Q?VRxt8owWgRkDu+AGJPmhZQumlTED1wDIKMJClfyrnTubiQ9nNwq9jtIV+jPt?=
 =?us-ascii?Q?g/3d6jiUbYf035ZUz7rADRdP3giMRhv0pzyqYtdNhOTpA5MsmR5sv+JtZDXF?=
 =?us-ascii?Q?lzkCNDOYxRnjlyDdfbKHOsWAHGMLBkgxJnGv+nVBM11OaLOPLBQAT3anR+2e?=
 =?us-ascii?Q?GgXgeW9JNSRmIxTSZ+LxZYszD1XTy1GKBOfvLBj5ghLO9Pwz4728sZrAIniu?=
 =?us-ascii?Q?TZ3yG9+GjPttuqxzQrXEdt0REPcXrTP2tOijSTZLqi8lM6PajZAQYCOAq7UF?=
 =?us-ascii?Q?8ornbP7amxYpzHc5cAsGTVjsVvwJnoyIxyJt5gaRGek0ig9gSLdbOti3e9PX?=
 =?us-ascii?Q?GIyXanaKosppVePAZ4zIDhZ90hM3DfJE?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?IfeqOjnwn3i8FiTp0YXx1gBF1is7IvMT4wL4FYNxiz1+P634HhYmmS95PAfI?=
 =?us-ascii?Q?5YjczBDJD4yhsRg+8fj0hjbg2E6IA36l6toRl+5z+B6fTUTrAmUqYfSNDKe3?=
 =?us-ascii?Q?wybFodrfBqKeBjsNv4dUHty9IWnTCtSnuRqecvMGA+3hatiz5GMO5qbBLttG?=
 =?us-ascii?Q?isVJv0WBB6l+jI1CVOYFTmRTZaRNwF5nQXHYGwqG75wzMIouKEtkCK5d6B7i?=
 =?us-ascii?Q?iAVnNc4acO38QVlMzz+EpWMIahtcUMf5tsryDYsQGd/BXzyeMeh56fFKuH2t?=
 =?us-ascii?Q?h5xYRZUkGmT72tOgxxUo1y0g/e7B/fMGYYdGzaxUNpEN4PfM9RDAmh1diFgk?=
 =?us-ascii?Q?kPUPE28Ww52coW1IGaeSIAI5yNdrmbJR5wejgw0LJD0iGpXFZbqtM70gR8QJ?=
 =?us-ascii?Q?B5iU/UlX8nnW7ysibS0q2FLY+4mY7sx/czHoCuYNxT/3wGnCWIFGkO9FMfho?=
 =?us-ascii?Q?HAu8UyEC9rwr2YaiT75arCpDoPFvQ7AO55JAT6ANGUcaKZ420fUmpaqJTquc?=
 =?us-ascii?Q?S+KEDIwb9lraFgUWQSoCNgmT/eY1SdbFjhfNLQC1yuKgoxpgKaem9dwjzkv/?=
 =?us-ascii?Q?GaAd6VL/hL5p0kvWfGL8YIIj3C9Oh8oEAbGgQJ6UnDG0YyqaSTbUxCggP1XT?=
 =?us-ascii?Q?p3oN+DXzNjxtLi6IhXzIcj2NDENRdAICAciUAUAOmseInMw67JxAtTW42vND?=
 =?us-ascii?Q?jHfUNgWuotjChPllldTLAwqbPShq/+rktN9L9vD2K1ot4vdHFRlbcI0s9OyX?=
 =?us-ascii?Q?lzvOiVdDGadDhYToM/lNPigY6kyFrBICJIaoFrAH6/QeGIeEfZg78WsI/FB0?=
 =?us-ascii?Q?nXRxmNw/dS+W7lB3dH8cSKXVbvRny5j5C00Dl4VWjAmxlJLzwK+0PoKDnPFu?=
 =?us-ascii?Q?sMf+4a7CJxdKv2f6aN/LIu2y1T81QneV4dTa83V9DahTIKj/tKIF1MY4IORJ?=
 =?us-ascii?Q?4FZ559KFgbjA3srXduVr/wSv2+Uqnv4ZQyiyQXo6ASI0B3qvrnDUYxUEwGcA?=
 =?us-ascii?Q?qmt8gNemixBCXrYvLH+cTfHcVD/5Ty1+LSN/aP5tmyBg/6k6pHfwDqDrrbOq?=
 =?us-ascii?Q?Xjullb+Udzz6wvRZLUjH5fhhvOR45Dhf9pS2qF6lYci7NIXJ+TrDsLeleuEK?=
 =?us-ascii?Q?caziq6Kc3HyfY/LzH/k6daO7GgQnR2cjdZlTb+1JokXGYQaUxaP+rLAt5vfg?=
 =?us-ascii?Q?SDICqpjqdF8rmSTEqurxoGdOJ72+WaJvpJbU4fi04to4ktLLyt/1+UqrWPg+?=
 =?us-ascii?Q?rgfoDBbe8wbKvPjmk7KHLGBBDuSc/YThMCrdU2L8Y1No9Eny7ZlXanD+5fHk?=
 =?us-ascii?Q?8gm4d7iHy4oYINL3Ab0el7GMmqE3OOe2yEEbaqF9yda9tAKnzcJtBrTAhEpb?=
 =?us-ascii?Q?t1u4pX/B0TD6gWwPIcro7vPcMrUSIuK2UUyFsruppk2RjZLF60ABdbmZOGD5?=
 =?us-ascii?Q?kPGNcgRyNj5ZhJz5HL8/WVLuovkb0BlAKaILgPnh503qj1ADzytAdmVpOACx?=
 =?us-ascii?Q?2pvJmpMgqK9g8g+iI7Vzgb0kR1KBI1kIlrxur8UtCh4YxtuagXDyBwERsnOw?=
 =?us-ascii?Q?3/7I8QHvmJCpH3epyRJD6Lc2+QL5yeFJfwO1ICPF?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e746c87-a940-403f-ad55-08dd5574b5c6
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2025 08:16:31.0588
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0v6hbGAls6EQB73j8eP7GFvsV+tZsLi+VRtNL9NTMakpMDLoQeTdBv67E0YgPkQ+goYMXih1BHwCmMN4JeIAwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4620
X-OriginatorOrg: intel.com

> From: Lu Baolu <baolu.lu@linux.intel.com>
> Sent: Monday, February 24, 2025 1:16 PM
>=20
> Update iopf enablement in the iommufd mock device driver to use the new
> method, similar to the arm-smmu-v3 driver. Enable iopf support when any
> domain with an iopf_handler is attached, and disable it when the domain
> is removed.
>=20
> Add a refcount in the mock device state structure to keep track of the
> number of domains set to the device and PASIDs that require iopf.
>=20
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>

with a nit:

>=20
> +	ret =3D mock_dev_enable_iopf(dev, domain);
> +	if (ret)
> +		return ret;
> +
> +	mock_dev_disable_iopf(dev, mdev->domain);

You could use the same trick to simplify iopf_for_domain_replace()
in patch7?
