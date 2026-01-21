Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4DC63D333D
	for <iommu@lists.linux.dev>; Wed, 21 Jan 2026 06:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768976665; cv=fail; b=OhAbm5gZXO4WL7r/MUs3AoM48HIcCGEBVPxliJqfUWhRz8v55csNMhQwRVWKSB2pgCcJ9ZritUQ4roefwMm2341vfxXMgWYicrc4cRgMLEEAN8GEztsCexV057VXDRcAdrZ7v8SbDeJ6J6719XhID418sw0YChkHr+wJEiRdrLo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768976665; c=relaxed/simple;
	bh=uWb+1xzhcCB5cSVJFsshQ7KSz/NLmZFtmjE4zAKQrbY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EUvcIieK0yzBAffBoPMIjpWYoABINsYt7BY2OurbcZw1htbG+Io3wjkResjGnhPHRLR+fbc451plKvO5lxWREJ7jd8KlVkSe/voPj2vWKKMtopSuQ5A43sGtoYDzbNz2BUGyDcnuf+6dAfCBAlsuQS9PQSoPcnVFI3XPBUq4THc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Nz40ELtH; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Nz40ELtH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768976664; x=1800512664;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=uWb+1xzhcCB5cSVJFsshQ7KSz/NLmZFtmjE4zAKQrbY=;
  b=Nz40ELtHG/3AchKTsg82EMCxmbOFe4rQ8SWpwoGCliA7sR7DMoDd2a1i
   qiDmOb4d0L/yDtHHexFL9zR2P3b7L9H3aiyqQ7VMeSIyaEzvlWIORreSB
   2XXbBV038FiLAW9+1a+r2Yz++8qbVsyP97+WWFe1ayqDyhfe0V7r4scJa
   OqR3iIPXSPuxkl81cVyJLWxCB76ZOHXRk6dEl6LgLrmRvluLnHOjdTpDS
   KPkKAg/WlsKISmrKgyXB4zUxEv57FUMuswNhJqqCLzaGREBRhdnrJtocW
   qQR72781HzPw6pWYAE+4eHD72IEAgTMb6jFsiLIY4TzNehXXyyYPA7J4y
   g==;
X-CSE-ConnectionGUID: 2OMH5X9vTpmJ3a6X3re0tw==
X-CSE-MsgGUID: 2S28R3eGRg+kC52O1bFByA==
X-IronPort-AV: E=McAfee;i="6800,10657,11677"; a="70110102"
X-IronPort-AV: E=Sophos;i="6.21,242,1763452800"; 
   d="scan'208";a="70110102"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2026 22:23:56 -0800
X-CSE-ConnectionGUID: IqELQFOgSGGD0mk97byQ5A==
X-CSE-MsgGUID: Lqr2nqTgSFeKroqd14z7pA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,242,1763452800"; 
   d="scan'208";a="206592406"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2026 22:23:55 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 20 Jan 2026 22:23:54 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Tue, 20 Jan 2026 22:23:54 -0800
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.28)
 by edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 20 Jan 2026 22:23:54 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B42CmcqU+BZAG+bsEzskkoad5dtpAmZWHTr7JwvJUUh4GYMKJYBHPoJrjBs+eNnxFWOMoAHvsocsGOUkaWOkzxDiun4k11Awqgdat1v8v0nLn8mTozZ9S2D/gzUYuIcNL90Z6RkCE6jd3XNA4UD4ES5nMCF3ko2So5zxo8s9qQL4z1XTxZ2FJ+yigQ7l9vmyL6gR4aIpTUrySCR+HzAnrJ5f4Z6UPOhHUZr9xFl0jrtED2ADnjC4Rt/J8X0gvrF6gJ4zM7xikQAlG6+HiGnOWvZI+neXpOWbyrpp0LS6EADWHYDgdyWRA1julRxOXxalNHeaEZ8Cn36l4X6YaAVFUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uWb+1xzhcCB5cSVJFsshQ7KSz/NLmZFtmjE4zAKQrbY=;
 b=nepDTPewlCTL8fWeACxDqmc1kGBG6szfW4DAbxedAyenLVk5sUlx8Uv0iA0SZmm19bejJl4dj9q/WQCzDXX5KBBc1Z5nwpkhD058XtBFGaUG1lLTdEherybzsq6qkotXcCqvhQt4xYdtudxVIfSb0n5P8k0FpzYK+fD4btKEYlCZG8KX9T1AtTM1lTJ4izA5bywmGIhg08Uu4sdHCkFJOPRp6es5ISfeASdIePfaUqCIgGkX2DkiYYE5su/XNXeca1oACv7SgrBfReI/WIAjpt2NB3QNiSN7BWEMPRZzP15K/wdT64OSt9v+KMCDS+H8jD0NeAX1NCNhovjqUctnTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5271.namprd11.prod.outlook.com (2603:10b6:208:31a::21)
 by LV8PR11MB8486.namprd11.prod.outlook.com (2603:10b6:408:1e8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Wed, 21 Jan
 2026 06:23:47 +0000
Received: from BL1PR11MB5271.namprd11.prod.outlook.com
 ([fe80::780e:4379:6988:f48b]) by BL1PR11MB5271.namprd11.prod.outlook.com
 ([fe80::780e:4379:6988:f48b%6]) with mapi id 15.20.9542.008; Wed, 21 Jan 2026
 06:23:47 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, "Will
 Deacon" <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, "Jason
 Gunthorpe" <jgg@nvidia.com>
CC: Dmytro Maluka <dmaluka@chromium.org>, Samiullah Khawaja
	<skhawaja@google.com>, "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 3/3] iommu/vt-d: Fix race condition during PASID entry
 replacement
Thread-Topic: [PATCH v2 3/3] iommu/vt-d: Fix race condition during PASID entry
 replacement
Thread-Index: AQHcidT4TTPzUfD8PEmVVPuGl2KUKLVcKTnA
Date: Wed, 21 Jan 2026 06:23:47 +0000
Message-ID: <BL1PR11MB5271380A0B1F942169C578658C96A@BL1PR11MB5271.namprd11.prod.outlook.com>
References: <20260120061816.2132558-1-baolu.lu@linux.intel.com>
 <20260120061816.2132558-4-baolu.lu@linux.intel.com>
In-Reply-To: <20260120061816.2132558-4-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5271:EE_|LV8PR11MB8486:EE_
x-ms-office365-filtering-correlation-id: 436310cf-1c3c-4247-e91e-08de58b5a26c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?NGN1V0NXZ3k0U2ptdFpTN0psOW9QR0h4VFE2R3I4MkVnK2NxVG9NenJraFVQ?=
 =?utf-8?B?dDVMUzc2VDFTS2krWncvNllCcnlwTlJrclE5aE5PNVpRelM2SGQ4K1Noc29E?=
 =?utf-8?B?TXFhSTV2RlFSdXFCdUNZMWpvWGJQdWZ5VmZCdldaVjBWMHNFNVduanB4b1g1?=
 =?utf-8?B?UjdOSmZOdGVZRzhTL1FjMmEreGN5clhCVTB0ZHBmemc2MVI5U2ltNFlUWUw1?=
 =?utf-8?B?R1dFNVdkUyt4b3U0V3BUampOb2grTFBORGhoaW5lQWNmeC9rRFp5OHFJei85?=
 =?utf-8?B?d0RRaUx3SnFtZ1hubk5zZFAzTnZNb1l4R2pJc3dkR3owUTl3aG1XMGtRWWVs?=
 =?utf-8?B?L0dvNGhzdmNFckpoMjBJakFhZFZrejVwNGFiZE52cFBOQXdZNkNFQTRzKzVw?=
 =?utf-8?B?SzFmSngxaitTdjJJSUR6T2VGdDRDMm1YZnhBKzRpTGdzTVU0ZUxxbDJucC92?=
 =?utf-8?B?OHkzVXcwNUU3S08wS1Y5OWtUR1R4T1dmeXJWTW9DRVJsQ1R0YUVIanBOVEVs?=
 =?utf-8?B?cVFQaXNUcEJROHp6QUtLRktRMmtpTEtWNzM0eTdGT01JZFNuU0kxRjNialI5?=
 =?utf-8?B?ZS9XeVAzQjFPTUZ1eHY4Y1QraHRGTWxGY1Z2ZDZKTkpGY2ZNcGVManRIeWgr?=
 =?utf-8?B?WWduQytiVkluWHdVNTBDRnRNNWF0bTNvTkFPV1dRKzZkL0ZTZkRZM2FMdFpu?=
 =?utf-8?B?Q1BtMEgxVFVYdUJCQ1FMc294SjM1elcvQzRNcTBscU9RcTRnZGl2MllEUTlo?=
 =?utf-8?B?cVdWYXJNMndwREwySEZzWmVicFZKZEtCdWFFc3lHREdEWlpXY1RzS1hwbjhs?=
 =?utf-8?B?YWg1MHRLZVdDUzNjdk9yR0FkWFl5dDNuZ0liMW5FODc1UmxjNU1FeUtLeTR5?=
 =?utf-8?B?RzNZdXdoMDZGOWRhUTVYMUlmeEZLbDdhTG1jNDM4dzBidFg4NXEzQmhDRFZH?=
 =?utf-8?B?UzlWV3FXSXBSaXdRVVpDTjlVdUJmUjZtWkxJMGpOSlJFOU1YemppMExDK0Y1?=
 =?utf-8?B?QzZZR0p0UDhDM1NHd3ZIVS90MElhNnRTRHNMSWRicnc4d1JkQ1JyVkFzbVhs?=
 =?utf-8?B?dmxJVm5WUlJNb0krMG4rQzR6WDJXV2xNejRmUVI2RmdGNlNVNzZpUnMva2hl?=
 =?utf-8?B?Q1RsbzRWMDZjOFJBV01TVVlmd1YzemJvcGNJKzRQeUtNUisxcTFUVHZHN2ht?=
 =?utf-8?B?Mmc1NXVRLzFPYkV1R2ZUendVV3ZIRXVvQy9JU0ZEN21XTnJWMkMwQm1TSUJQ?=
 =?utf-8?B?RXNrSG5mVitKMXcxZUdubFVoaHFabldJZGNLSE9qRXRGTU14aHRWbUFSdmVO?=
 =?utf-8?B?MGE1VVR0MjFybWxQZXZGZEtMUjE2azhsWitKMTIzdGg2OFZqREZtTmFNVFV2?=
 =?utf-8?B?ZTFoSHBqeXZybHpYblcrUHJLcWR1REUwbktHbyttQy9YUDVVRlloREdIeXNG?=
 =?utf-8?B?TXVVd0hVeVFBbDRka2YxKzdyUG1aSDRHVFp0MTZkOVhHYnFDMDNVUHR0N3VW?=
 =?utf-8?B?R3Z3YmNSN1VaSEFqVjRERXh0WmozY1d5ZU5TWVJPUDVwTURCUlQ3U0dmZ3Jm?=
 =?utf-8?B?RHkwcVVuMFZTOHZmZHliRDlGSTlWVkcrc2JtMTZaYU1sektreWhDemY4SG11?=
 =?utf-8?B?L0lNSlpiWTBaMENrUzd4ZzJLQkpZczZ2WS9zQ2FUTGI2MkpueEhvMU1EMGZM?=
 =?utf-8?B?akh2U3dJbXU1UEZCYzd1dHpEVm05VlNmTGQ3WFBhNUFqRlh1b2NJcnl5QkZ4?=
 =?utf-8?B?NGRHcThPT1Q2b0dudFN5eFBQdnZSTVR6dnhNRHdxdTVlRS9xK25BNnUraHVD?=
 =?utf-8?B?S2xaTGwwcHE0TWI3QVhFR1crYy9CeU9pcTNHS0gxVjZ1S2RhbjVkNS9vUSs5?=
 =?utf-8?B?cnJHZGYvVU9KWTV2VmdWcGF4aUNtUitDKzQvODBsaXNhR3dIcXNydWc5MG5I?=
 =?utf-8?B?R1NaSk5KN2FZNTJ2bjBCSnI3Z3J5SUpuY2JPa2s0dDloNmN3bXdUOENHdkpn?=
 =?utf-8?B?U1o5a21LaVRLVUw1dUlnblpTWG1iTWgzcHY2VzluYVdiWEI4UVY3L2tXN2Uv?=
 =?utf-8?B?WkdoZEoramxVRzhPTklrUm1HeEE5N0Y4VWZ6a0Jwa0FKT0ZaRzV1WXFxSnZH?=
 =?utf-8?B?WGV4TTRMYUxMWTRVQnFZRHR2WXBEV0hpa3R4NjY2MWtndGhXOEZQVTdQaDVL?=
 =?utf-8?Q?D9kK6V1y27Zbkur/w9QM8xo=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5271.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dXBsYnNJQnVteXBhTjNxUldJcUdxS280dENmU1NRMnpyR0Y5Q2NuckZrTE5k?=
 =?utf-8?B?YTdYS092SjUvY0x3aEk5V1pjczJzY2FsVUlHWlpZL2x6dGkybGllQlYyRDVi?=
 =?utf-8?B?bG5RVmlrWUlyU3VYeCtHRlBudE94YXJacGdUY2taT1N1OEEyVFlsMnR0TFN3?=
 =?utf-8?B?SktFNGhVRXNLZkhiVkVwMjhvSWpPMUdubTJDNDFlbjdpaGwySVdRSDQwcW9F?=
 =?utf-8?B?ZU1aKzFGWVEwaGpJL1FObkNlZ1QweksyY1hGRnBTT3h2UGlNZlRnSCtsREFt?=
 =?utf-8?B?aXlEZ2tDWmpIdnVTOTRwaklwSE9ibTdCdEJ1SlNjVDBXSGdHMEhPMjM4V24x?=
 =?utf-8?B?RXVtNE8wWURtcDJ2TWtrS29NcXlSZWtGT3owNnNTVWtjdUVSZFNxQ1JSbXJa?=
 =?utf-8?B?Q1hCVXl6VTk5d29aYnVCMVFLd0RvRENaUnplTnpjb3JHUklsYlQ4Ync1cHdv?=
 =?utf-8?B?TkxlTkxMd2c5OVlRa2NpY0lsOEVBNmI5cEZ5bEw1RWMwSndJbzZheUtYUmNM?=
 =?utf-8?B?aDV6RThybDJaWnV3Zm5XL2pGelArUGlBN21BTGJwTXlidmJIb3VvZVdpQy96?=
 =?utf-8?B?b2VER3lYL3VtK2I2K09IRG5uU3RNVmphb0ZGT01nbGJhR0JBN2tRYTBkTEJM?=
 =?utf-8?B?RXkyMWxnWFpnVjVjUlIxcG5VMGNJdFdqWVJJdXA1cmM5S29kbzNGQnlaazgy?=
 =?utf-8?B?emZzSHp1b2NQUVRXS0VlM2YzK3hibVV2RDgyckZXN3ZuU1JEOEZkUHFvVWtZ?=
 =?utf-8?B?TFpWaXlmTGQ0bFRSckkxWU9kZElUTUorMGRtS3NnMnRLeDMxWkp0TjdDb0dx?=
 =?utf-8?B?c29RQjM1UUxpNytNSWhxVi8wdEUyREZlbnV5T3FidXI0TWV3YkNQbVMvNEln?=
 =?utf-8?B?ZnZBekh1a29tS0dnVWFPWGJueDJrYm0yeTNaQ2huSmVjSmxoL0NzS29abENj?=
 =?utf-8?B?YnpCYXdPTXlNZm5aTU12VDA3b1VBSSs4VS9pK1d4ek9kekJUWWRJdmluVTVt?=
 =?utf-8?B?L3c1WnVGUndGcW1VS0xaWXFVV0xnclZhYmxSY2NJQ3hMZ2srYy9DZ3ErYmZz?=
 =?utf-8?B?aWh5S1NYSHpRMWMzSnI3TG9uano1MkRxQ3VUMlBFQ0w0R0hUTTloeUpVLzIv?=
 =?utf-8?B?bTBWU09QSFowNHhuci9lN1hqdDhLdFhLamwxMW1KS3B1NWRKcTc0Q052cnNu?=
 =?utf-8?B?bU5tckwxV2FFajJPSzhoV1pDeTZ0TnI3Q3VrVTBtbzRjeVE4d2piTngxUVFx?=
 =?utf-8?B?SVRIZGlCSTZRNndPM1NpTUE3R1A1MjUrVjdrSmhHcGpYTzlxQlo5RnU5YnRj?=
 =?utf-8?B?YWlIU2dsbXVCa3NTN0hCeUZZUTNvY044WnZBNjU2NXRmRW1NR0hxcWpabW5y?=
 =?utf-8?B?ZkFKblpLd1g2K0VQYk9ZU2t6cytYRFBnUWF4dXdnR3R1SFRHajB1eDRaWlRQ?=
 =?utf-8?B?UXhuclN0YUJ5WGtTTU4rSit6bUlsQXM3T2Jpa1c4T0tkclVtRDM1dUdYR1J1?=
 =?utf-8?B?SG5adnlKZGxybkVKQVhFK0pNdHB5MTFxVXVoNm5uak8zT0JGUTM3OW1rWjBo?=
 =?utf-8?B?MUVqQWtSNERKV0xpWlA3eWFaOER6VUFoa0EwMmlpT2hnWUlvL08zWEdZL2Rz?=
 =?utf-8?B?cU1LMTZIYmx3WENVN0pueDVBQmRWeUJkOE5wNTB6S1NmaTdVQVdNZTBiWlF5?=
 =?utf-8?B?ZXBGWFAzM3VjY1BGUUZSdHlZWGswOTZrQTRoNnEzWGVlWjRyYUd3QmQrWnB1?=
 =?utf-8?B?SHBTQzFZdWFnTlBaOWljeTNrUldRYjZwVDVjVStNcGtMOXh5S25FYVBlWVV5?=
 =?utf-8?B?bW1kU2Y3KzVWOG5UUytFL3NZNjhGYVlmNmVZbXBRUXFtbFprUVZIMGxJaUo1?=
 =?utf-8?B?QlozYnl6czE0MjA5R25yeFlyVWxkeEsvR0ZHdms5Z0hXdDYxRW13cDd3aURS?=
 =?utf-8?B?bjNDa2RYNHV3TmlyQ3d1NFoyM1dMM2xyd2JaUEgxZFRtcXhtYjR6aGVEV05T?=
 =?utf-8?B?c0srSGhvMkRZS2hmUkI2Y1ByQysxZ2ZsNGZLVXlvbWNDTmZ4c21ycHk5TVE0?=
 =?utf-8?B?cVlFa2Rjc3VHQS9IZFVNeHNuUDQvYTlFbDMzWCtER0NUMkhtb0VJcWp1SVBX?=
 =?utf-8?B?MlV0YzRLYVZzeFdLaWtZUE5WWEpCTWloMDIrOFo0Z2UvZUhVcUNxRkRmN0kx?=
 =?utf-8?B?Rm5oNzFsWkVhY3NPbVRJMks5MnUzTVhlSGRyQUM2YjVQVHE5ZGpjeWNVVE8y?=
 =?utf-8?B?S0VvUk5JRzB6WnNtSENPcHRmc0VONU44S3UwcSs1WWNsVklSMlc4Ly9PZTR0?=
 =?utf-8?B?elVRL0tXcjlka0FvT1NBZlpKQ3g4N3gxUC9xaUk2OThhZXZHTStPUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5271.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 436310cf-1c3c-4247-e91e-08de58b5a26c
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jan 2026 06:23:47.0330
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fFnr0zkHD/qmcIx6qMmPNIgmzlCGB3ImR3iFiBTqdUE4ggjjasF5EL2c70Kp3I2EhFocO55aVCyFhXBHqZ29yQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8486
X-OriginatorOrg: intel.com

PiBGcm9tOiBMdSBCYW9sdSA8YmFvbHUubHVAbGludXguaW50ZWwuY29tPg0KPiBTZW50OiBUdWVz
ZGF5LCBKYW51YXJ5IDIwLCAyMDI2IDI6MTggUE0NCj4gDQo+IFRoZSBJbnRlbCBWVC1kIFBBU0lE
IHRhYmxlIGVudHJ5IGlzIDUxMiBiaXRzICg2NCBieXRlcykuIFdoZW4gcmVwbGFjaW5nDQo+IGFu
IGFjdGl2ZSBQQVNJRCBlbnRyeSAoZS5nLiwgZHVyaW5nIGRvbWFpbiByZXBsYWNlbWVudCksIHRo
ZSBjdXJyZW50DQo+IGltcGxlbWVudGF0aW9uIGNhbGN1bGF0ZXMgYSBuZXcgZW50cnkgb24gdGhl
IHN0YWNrIGFuZCBjb3BpZXMgaXQgdG8gdGhlDQo+IHRhYmxlIHVzaW5nIGEgc2luZ2xlIHN0cnVj
dHVyZSBhc3NpZ25tZW50Lg0KPiANCj4gICAgICAgICBzdHJ1Y3QgcGFzaWRfZW50cnkgKnB0ZSwg
bmV3X3B0ZTsNCj4gDQo+ICAgICAgICAgcHRlID0gaW50ZWxfcGFzaWRfZ2V0X2VudHJ5KGRldiwg
cGFzaWQpOw0KPiAgICAgICAgIHBhc2lkX3B0ZV9jb25maWdfZmlyc3RfbGV2ZWwoaW9tbXUsICZu
ZXdfcHRlLCAuLi4pOw0KPiAgICAgICAgICpwdGUgPSBuZXdfcHRlOw0KPiANCj4gQmVjYXVzZSB0
aGUgaGFyZHdhcmUgbWF5IGZldGNoIHRoZSA1MTItYml0IFBBU0lEIGVudHJ5IGluIG11bHRpcGxl
DQo+IDEyOC1iaXQgY2h1bmtzLCB1cGRhdGluZyB0aGUgZW50aXJlIGVudHJ5IHdoaWxlIGl0IGlz
IGFjdGl2ZSAoUHJlc2VudA0KPiBiaXQgc2V0KSByaXNrcyBhICJ0b3JuIiByZWFkLiBJbiB0aGlz
IHNjZW5hcmlvLCB0aGUgSU9NTVUgaGFyZHdhcmUNCj4gY291bGQgb2JzZXJ2ZSBhbiBpbmNvbnNp
c3RlbnQgc3RhdGUg4oCUIHBhcnRpYWxseSBuZXcgZGF0YSBhbmQgcGFydGlhbGx5DQo+IG9sZCBk
YXRhIOKAlCBsZWFkaW5nIHRvIHVucHJlZGljdGFibGUgYmVoYXZpb3Igb3Igc3B1cmlvdXMgZmF1
bHRzLg0KPiANCj4gRml4IHRoaXMgYnkgcmVtb3ZpbmcgdGhlIHVuc2FmZSAicmVwbGFjZSIgaGVs
cGVycyBhbmQgZm9sbG93aW5nIHRoZQ0KPiAiY2xlYXItdGhlbi11cGRhdGUiIGZsb3csIHdoaWNo
IGVuc3VyZXMgdGhlIFByZXNlbnQgYml0IGlzIGNsZWFyZWQgYW5kDQo+IHRoZSByZXF1aXJlZCBp
bnZhbGlkYXRpb24gaGFuZHNoYWtlIGlzIGNvbXBsZXRlZCBiZWZvcmUgdGhlIG5ldw0KPiBjb25m
aWd1cmF0aW9uIGlzIGFwcGxpZWQuDQo+IA0KPiBGaXhlczogNzU0M2VlNjNlODExICgiaW9tbXUv
dnQtZDogQWRkIHBhc2lkIHJlcGxhY2UgaGVscGVycyIpDQo+IFNpZ25lZC1vZmYtYnk6IEx1IEJh
b2x1IDxiYW9sdS5sdUBsaW51eC5pbnRlbC5jb20+DQoNClJldmlld2VkLWJ5OiBLZXZpbiBUaWFu
IDxrZXZpbi50aWFuQGludGVsLmNvbT4NCg==
