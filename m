Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8741A12B87
	for <iommu@lists.linux.dev>; Wed, 26 Jun 2024 01:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719366814; cv=fail; b=N/DdrQ1dpAqGYBR0zzQV+vtkUHA62347toiOLrZtiDV91bEVWk+RPRB7DAqClgiamd6gm6lK2xflg/KUKVaN2VJvFf4CUUY19/i9Nug64W3/LqCxaA1Cm+1dtrxrqgTJ6egqrEnBOBcgnrSjPlfAzoyJRUpFIQ/bU58/ETDDzjQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719366814; c=relaxed/simple;
	bh=CMD3sXBfUiheuu6fn6QRKw42XXGuFdM0XUwDJoX4r3A=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nwKYdZNYQhYLxbCeV7gSwvFVyWx3HtZLK8Wi5R/kYDu2+RKLOMbbfEhXbTeonYkrRKD1DMlPBNY70PgQdrdBlc1qZ/+tSeAt2Bz7DHxF68vQUVlvqH9A8lKkaO1vT76GHYEYggsWhye8Sx5ECRI1nA6BSdVytxcKvrN8d2LFhoE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U0UwcQdz; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U0UwcQdz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719366813; x=1750902813;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=CMD3sXBfUiheuu6fn6QRKw42XXGuFdM0XUwDJoX4r3A=;
  b=U0UwcQdz96G6K8jPiW9yyJXyLGCPIqhE/gjat/ZcEm83hFW6DtTmFq0Q
   elKNAI90n5f5KZGbnhBUka19nh/MpM6IwrFtQi760v26u/CrGoG0sLTFN
   VkcYqGm9DuQ7kzEodNETwiPWccN2ihU/ggD05on900+ILXw3dx6ho5Vrg
   NA+rU8TV98Sy7Em3q2CCCGFgI6UXdvUW8GZTOc3qZPFgQboO9x6LvW5uk
   txzNVoUwwcBBrz4UAeIT/nEfmWh2zWjmGhDtm0YEb0PbHdVVAjUu6ggDG
   60Trio2mZvmuYgRdTjkyTukdaGVUnv1aNDWr5WQu7m09r0t5UZr2EEh3I
   w==;
X-CSE-ConnectionGUID: 8xezpo1QTy2bUlbX4/3hDg==
X-CSE-MsgGUID: jHheHeKaRaeJGEaLJXNOTQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11114"; a="27558374"
X-IronPort-AV: E=Sophos;i="6.08,265,1712646000"; 
   d="scan'208";a="27558374"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2024 18:53:33 -0700
X-CSE-ConnectionGUID: B3dtRm+gT/e5feEMFUe6SQ==
X-CSE-MsgGUID: oaGwoESlQuWD9HUF9Eoa8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,265,1712646000"; 
   d="scan'208";a="67054195"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Jun 2024 18:53:32 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 25 Jun 2024 18:53:31 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 25 Jun 2024 18:53:31 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 25 Jun 2024 18:53:31 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 25 Jun 2024 18:53:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MTW+trdj5cXA8oc1P1/FSFPL5+0CCRUv5fU1/R/3ModqNBVOldzkm4TM5uVxs3Y2/BO0fo2uyaPsw6f+bcanUa4zuPqfVd0uLVtmmwsnlg5f+ZslwFXhkNZuI2gaHHE/ek+Smz4YzkTHsf/GAjP0vI0popyb1FPq80mGuLXWlAnk7O/aVEgZkdYfpBO+vbf+odMHPZs0oLhUKWSAcqZCej/V6yqWomF64H8VdR1ecqRNTh7EzQ/lolpuCvshVvk+qgP2pL+SDsZuPzffRqKNQx0WrRauG8vpDeKSEPKzrxJpf0znsGafZsCe3npU4s569TK+q6S2x3V8E23lIPmhmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CMD3sXBfUiheuu6fn6QRKw42XXGuFdM0XUwDJoX4r3A=;
 b=b703iepODhMrDI/3gYXLGV69d4Nr1rlNe01vfvRRSY7rYhZDiUuJAnl6vW9367g8Q/zJR3mmhOqQ/Ako4sMA6eYPfwx5MrLHXUd3mc51M2Hh7YZ/TujZuhnTDYQE13+u7CxO7JLPCeSHBSt9ceeM/PKk6mo1Is1JTjVvkXhD5Y/hBSELzi6O0V/BatyMIJGPGdpEbDS6tI8R+OyDu400uRpfrwAoVP6LcS6bB4ePKC8yMzAoLU05qkj2pXfVVqbpP8D+n8/k+8GhjO7ySyyCCtNQYV8kBYBlfeTqo9ofVyAKNJqywXdP5crDeSuJu6etliQA33ktRIGrXRFsuTEJuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by MW4PR11MB7005.namprd11.prod.outlook.com (2603:10b6:303:22e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.28; Wed, 26 Jun
 2024 01:53:23 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%5]) with mapi id 15.20.7698.025; Wed, 26 Jun 2024
 01:53:23 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Baolu Lu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, "Liu,
 Yi L" <yi.l.liu@intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>
CC: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 2/2] iommu/vt-d: Remove hardware automatic ATS dependency
Thread-Topic: [PATCH 2/2] iommu/vt-d: Remove hardware automatic ATS dependency
Thread-Index: AQHaxfdH2gEXDMHztk6a3sIg9ZSSarHXwtEQgABn4YCAARvW0A==
Date: Wed, 26 Jun 2024 01:53:23 +0000
Message-ID: <BN9PR11MB52769480729491394F4719728CD62@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20240624052501.253405-1-baolu.lu@linux.intel.com>
 <20240624052501.253405-2-baolu.lu@linux.intel.com>
 <BN9PR11MB5276C8112DEF56C11CFC6F198CD52@BN9PR11MB5276.namprd11.prod.outlook.com>
 <55d50738-cbb6-4bf5-8748-1b1c8c2de21e@linux.intel.com>
In-Reply-To: <55d50738-cbb6-4bf5-8748-1b1c8c2de21e@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|MW4PR11MB7005:EE_
x-ms-office365-filtering-correlation-id: 73a5e0d9-d5c5-4dce-698c-08dc9582c360
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230038|1800799022|366014|376012|38070700016;
x-microsoft-antispam-message-info: =?utf-8?B?NytxV082Uy9XWWpNT3V4UFl6ZDZoVUNVU1MyMHU5Q0JxeldJcDhwaCtXZndm?=
 =?utf-8?B?dDZLN1VjcExEZHdKZy9rbjNhY2YySlNhbEZUOFJVb3N3a2ZWVGZzVFRIbS9P?=
 =?utf-8?B?Nm00aHgyNDhhbTVrR3d0WjgyOXVvOGh4R2trRVVSWEc4NWp2MkxZaTlLRFdk?=
 =?utf-8?B?eUJmc2J5RG03WUFuSGcyVGtWUTVkQWQvTHdOUE5mTEhFYXlNNHA2MEp5K2E5?=
 =?utf-8?B?bE1VOUNpM0Jqa1dwckZ6Z0F6UVVBNlQ0OEtEN01seTVTS0ZyL1NqWnp3ekZi?=
 =?utf-8?B?cTYrSFVTc2crN1N4bEpEOG1lYy90Ry9RTkJmaFZiTFNHTlU1a1JtZUwvYUhh?=
 =?utf-8?B?RmdUMDR3MXZEbE1SUnEyWTNCZWNvdXM3L3k4VjdSNitzZEV0QnNUNVRLakFU?=
 =?utf-8?B?SmtleWJmY2tBOGZFb0ZZUGZKa3JvYTJpOTExU2hxNW9BalhTU2RLb0xHS2Qz?=
 =?utf-8?B?b21iaUpwc0NuL1B2Y2h4TytuSXhUTTd5dXdOTnZHekFZYTN3NmxFL3BFWmpo?=
 =?utf-8?B?YWdGOWlWbUIzMXdkMnB6Q0FZcXRWeTZpTjdJVTlKYzdjTkNZcVlOLy9pRi9L?=
 =?utf-8?B?dElIeHZpMWZxMmM1eGhidThTcCs4QUFiMFloeWp1VVBuRmN6cUVacGNHUndi?=
 =?utf-8?B?VGxuU0F4RmNzYnprSldYMStEME9BK2JOZlphOFFOUVhLWmZ1d05IcmVtNm9l?=
 =?utf-8?B?K2J5aDBybDRVNmdteHVOMkFVNm94c2pTM2tqOVB4NlNaYkRRTzNJYkJOSXRm?=
 =?utf-8?B?bWJqZEF4anIrY0xTdTR2SG1PU3dvQ1lOd0pNMnJCdS9zSnBHV0hyRytod3Bn?=
 =?utf-8?B?Y3duTlBDMGFiTkE0Tjg0cEZlcHh5a3BhdGFzTnBjUzJVc0psaEhFVDJhUi94?=
 =?utf-8?B?bUxOTHNQTENKTmovSDJoUkVHdTlaZnJDa0pjemMwb3EzTkkwRDJNK05RVnFk?=
 =?utf-8?B?VzVXaTg2UmxUZllQdGRKZjdROEIwaUJzMGN5UW5NZW9UUFdJTjR3ZDJjTmtG?=
 =?utf-8?B?QjRmQ3JaamZwZHA3cEY0MEtNdExqZWJxVEFNQnFRMFVXbFpjaEhaZW5vR1c2?=
 =?utf-8?B?eUt2K0FWdmNFWUtRalJrdHc2MlhvZ3p6OTljN1FJYXZSYmdZcGlERmxmK2tW?=
 =?utf-8?B?bzJodkpvdXBkWXVrcDM2dFkyYjNSL1p1SG1pQjh6Qmx4SFFaU25nVlRuVkph?=
 =?utf-8?B?eFpSNzlPcWJveEpucnB4RktRZzgrUlgwc09iNE45NHJJNGIxTDlKVDNQbnEv?=
 =?utf-8?B?Yi9ScWc5YUVoVEdjaHZiT25oeHkxSHFOcGRYOS9SUzBZTU5wa29XNmZUcHpX?=
 =?utf-8?B?cWxWZHpvR3hFTXFjOTJBWUkvTndObjBFWUcwSmIxSlpFVEVFWUhYd1dSRHZv?=
 =?utf-8?B?REZ5dWdOTy9XRmFrbld3VmlLYndhWXphT0s4Qy9jYzdINXdjSVVnVlpWQ0RH?=
 =?utf-8?B?MXFLNzE4RjF0TXlWek1GYXdBMHJsaVgvL1NnYVV6NzRSMUNnYmNwaVkyb3hi?=
 =?utf-8?B?YVRBTWxScUhLekhSaloxU09icklNNlI3ZFNaSWVFMzZJV2Y2d2plRi9XL1Ns?=
 =?utf-8?B?RVVPRXJPb25hSHhVUkRTNVRTUmE4WGpMY0sycUNGQVdNZ3hPaW1JSG1UWVV6?=
 =?utf-8?B?L0NYalFkZzNqcHppOU1CbEZqQVd3RVNERGMra0U5NVlVNHE2K2FmU1NDc1U2?=
 =?utf-8?B?ZVEyNzJGeExxc1F6RmtvZFYwbk5rY3NzSU5GWUVDYTkrMzBGQmJocGliMjg5?=
 =?utf-8?Q?Dx5IYOiefX4BiaMASQ24mg7A5L0JSJ7OrhCSZJV?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230038)(1800799022)(366014)(376012)(38070700016);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WVRCYlYwb05OM2VxTUFQZFNCMFhhcUF1UFRpcWZrOGphM1hXS3BVUVlhelJy?=
 =?utf-8?B?T3hNbWVNQ3RrV0MyMDNWZmpXN2lLUE91TFF6MzE3d09mdllQM0l2V3h6cm1q?=
 =?utf-8?B?YzUxNnl5aTJ6eWduclJNS0xOaFRZeDdKbDQ5ZEVtM0ZMbFJXbDhnOHZIMGRp?=
 =?utf-8?B?TEZ0c1hmSWVZM1dYa3JNSG1McVBoOXVjRCtFV1JtVTZHM2F6YS8xSXZpT0tJ?=
 =?utf-8?B?NUVCbjVoOHEyZ3ZiVlB3aGZ4MTNJRlhaSWd3VmJzMStZeDBCVHZWSFlNZFBq?=
 =?utf-8?B?NnZQVllDN2t1dE94MnZWNTdCSEJiMi9vcUpwdFBBK3RmOHh2aGdmSk1EL2tS?=
 =?utf-8?B?TEU3QlFjTWdRYXQ1bC9kb0VNTlVzRmxSLzJOYmJ1SXdMV2tkTEFBbXJtSW1W?=
 =?utf-8?B?VERuZ2Ywem55elh3TWRkV2Vycnd5bjdpd0l3M1c0RGRCNzFvQmMvUFo3cEZO?=
 =?utf-8?B?dGFxbGw3VUFEdHh5dkVPVURkY3RaUmVjLzJ6MzBaTFVFcDludVBTZHZDdFpx?=
 =?utf-8?B?MG50UllPaFJCanNyNzZ3dThodVJ1VWpyM2ErZGZNV2RnYlFSeUxIYkRicnlB?=
 =?utf-8?B?SDhLbG8xSmowbU1xeGhRUEJ4UkV0anc3RS9ZOEloVlFxT0JXRXJUNzJTUi9D?=
 =?utf-8?B?ZWowMTRQZmN2N1gvYkxrMHNmMXB3ajY5TjlDU3NGTVp6bWhPVGtUVStkVkNu?=
 =?utf-8?B?ZjVTdDlYWGYxQmpnd1VSeFVQL1dtc3N0L2M0Q2ZYb1RXb3pLZmRPN0ZRZ2lV?=
 =?utf-8?B?VytHcXlRU3RsUVM5ODJVY3UyR1lZaU9GL1RZOFVPTkxyYXdrelNuZUFEVTBo?=
 =?utf-8?B?K1loNlUzbW5YL01kT3RvTG1PNktJL2RzSHc1c0x5RHczY3RVQld1ZDg5VzRH?=
 =?utf-8?B?U2Q2OXhvUlFjeWhRV0E2QmhEK2RyOFJubjlSY2RaSEgwazIwMVY0N0VkMkRo?=
 =?utf-8?B?d2JkQUUyTnBuWmo0Yk5Ub0JESm9ncHFBSExBSjF6N0RBTFBNck03U3FqeUwv?=
 =?utf-8?B?dFA0Zy95dXk4TWhaaEZKTmtkQUFNVWJRblJQcjduZmloQkZoSmMwRG9rUURo?=
 =?utf-8?B?OXUzRWovQkpZd3J0anV1THIwa3ZIczNxdWtWK2tTUHpnaFhkN05pY1ZSVDl0?=
 =?utf-8?B?OWIya0tjMjdJYSszTmZrU2JiQnhtUFJEaTUvazd4M0FsWTEvOWNrRjJZOTNN?=
 =?utf-8?B?cnFGSmpiZXB1UlJiQkNXcjdQclFLa2ZKZmhPdlVvWXp4TEh6anZRVzRFN2s0?=
 =?utf-8?B?M1AzUlNtYitGQk12L2Z5d3hPSFlsdzhDNFBzRUdHNVNRUGxYOU4xLzJFMFZx?=
 =?utf-8?B?WEdOWENXYmN1Nm9pT3BNaG43VXN1dWx3d1BvNU51eE5sT0JCTnk0NVhHQWxq?=
 =?utf-8?B?UXpqK1diaHcyQUM4UjFnaDg4RVdsQTk0TFJkUmZlYXkwaTBGMWt1ei9NSGtJ?=
 =?utf-8?B?UUloaWl4eFZ5WWgvZVdMTmtsTTdvTlZxQ1pwRHlsZVEzSVZ4QTZjVDV3VFBR?=
 =?utf-8?B?MlJWbFR0SjF3bFNVMTcva2dtNjk5OXR5K2JrMzBacklNYkRyeU5QbVVPcFNC?=
 =?utf-8?B?S0Jyd0dYbURiRmxYdklnUmpmdE1LTVc2OU55MXVueldNRmJIdVQ4ZEFTY2Fs?=
 =?utf-8?B?dEJ0b2VNUEdiaVlKZ2NNQzFVNUQyaEY1eHgyVU43QkdrM1RaZ2dON0tHMXUv?=
 =?utf-8?B?R1A5UjMrcjFiTmpydTRIK1Y4d1FLM2t6ODdVMzd1dDh5blE1Mzk4Rm5FTGJu?=
 =?utf-8?B?K3lqYVRCUzVTczVnRk0vRGc3MlZnRlc0anVzc3J6VHNESE8rdlN6RmFrQzBs?=
 =?utf-8?B?T0piWTg2RXRTUXUxeUtHQ2p3UXdPbjhDUXZTVmY4dmNPRUY5SlZtUmNRdFFi?=
 =?utf-8?B?OFFTeG5seHhHemdVS0tRVVBhd3B5M3QrSUtoNkNZenZEUVJGK2NhZDJFaHJ2?=
 =?utf-8?B?bXZFYkk4R3FCODNrZWVkdEI5dFBNSVNIT014aGZQZVBBVVJRd1J3c3hFYnFO?=
 =?utf-8?B?R3VYWnVRdUcwZ3hqM1hHNXJKS3NvS3I2TFZabmpaOTIyK2F6RnVsZ1pjNThJ?=
 =?utf-8?B?Y1NvNXdpSzMwbVE4WlkwNWtaQTlCMGhZZitiZVVoU01MMkhIaE5TdmRyU254?=
 =?utf-8?Q?AtJxa3kXmgQhP68sLPIpzsCJ1?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 73a5e0d9-d5c5-4dce-698c-08dc9582c360
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2024 01:53:23.5377
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 38yewAUOF9vaEQSyxEO80rSoa47DJ+FxrVK1r4eeS7ZpqA41Cg7fRN3ViPx5Nix9F4jz+ziXT32AVGMPYv8tNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB7005
X-OriginatorOrg: intel.com

PiBGcm9tOiBCYW9sdSBMdSA8YmFvbHUubHVAbGludXguaW50ZWwuY29tPg0KPiBTZW50OiBUdWVz
ZGF5LCBKdW5lIDI1LCAyMDI0IDQ6NDAgUE0NCj4gDQo+IE9uIDIwMjQvNi8yNSAxMDozMiwgVGlh
biwgS2V2aW4gd3JvdGU6DQo+ID4+IEZyb206IEx1IEJhb2x1PGJhb2x1Lmx1QGxpbnV4LmludGVs
LmNvbT4NCj4gPj4gU2VudDogTW9uZGF5LCBKdW5lIDI0LCAyMDI0IDE6MjUgUE0NCj4gPj4NCj4g
Pj4gSWYgYSBkZXZpY2UgaXMgbGlzdGVkIGluIHRoZSBTQVRDIHRhYmxlIHdpdGggQVRDX1JFUVVJ
UkVEIGZsYWcgc2V0LCBpdA0KPiA+PiBpbmRpY2F0ZXMgdGhhdCB0aGUgZGV2aWNlIGhhcyBhIGZ1
bmN0aW9uYWwgcmVxdWlyZW1lbnQgdG8gZW5hYmxlIGl0cyBBVEMNCj4gPj4gKHZpYSB0aGUgQVRT
IGNhcGFiaWxpdHkpIGZvciBkZXZpY2Ugb3BlcmF0aW9uLiBIb3dldmVyLCB3aGVuIElPTU1VIGlz
DQo+ID4+IHJ1bm5pbmcgaW4gdGhlIGxlZ2FjeSBtb2RlLCBBVFMgY291bGQgYmUgYXV0b21hdGlj
YWxseSBzdXBwb3J0ZWQgYnkgdGhlDQo+ID4+IGhhcmR3YXJlIHNvIHRoYXQgdGhlIE9TIGhhcyBu
byBuZWVkIHRvIHN1cHBvcnQgdGhlIEFUUyBmdW5jdGlvbmFsaXR5Lg0KPiA+IGhtbSBJIGRvbid0
IHRoaW5rICJoYXMgbm8gbmVlZCB0byBzdXBwb3J0IiBtYXRjaGVzLi4uDQo+ID4NCj4gPj4gVGhp
cyBpcyBhIGJhY2t3YXJkIGNvbXBhdGliaWxpdHkgZmVhdHVyZSB3aGljaCBlbmFibGVzIG9sZGVy
IE9Tcy4gU2luY2UNCj4gPj4gTGludXggVlQtZCBpbXBsZW1lbnRhdGlvbiBoYXMgYWxyZWFkeSBz
dXBwb3J0ZWQgQVRTIGZlYXR1cmVzIGZvciBhIGxvbmcNCj4gPj4gdGltZSwgdGhlcmUgaXMgbm8g
bmVlZCB0byByZWx5IG9uIHRoaXMgY29tcGF0aWJpbGl0eSBoYXJkd2FyZS4gUmVtb3ZlIGl0DQo+
ID4+IHRvIG1ha2UgdGhlIGRyaXZlciBmdXR1cmUtcHJvb2YuDQo+ID4+DQo+ID4+IFNpZ25lZC1v
ZmYtYnk6IEx1IEJhb2x1PGJhb2x1Lmx1QGxpbnV4LmludGVsLmNvbT4NCj4gPj4gLS0tDQo+ID4+
ICAgZHJpdmVycy9pb21tdS9pbnRlbC9pb21tdS5jIHwgOSArLS0tLS0tLS0NCj4gPj4gICAxIGZp
bGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDggZGVsZXRpb25zKC0pDQo+ID4+DQo+ID4+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL2lvbW11L2ludGVsL2lvbW11LmMgYi9kcml2ZXJzL2lvbW11L2lu
dGVsL2lvbW11LmMNCj4gPj4gaW5kZXggMDdlMzk0ZGZjY2MxLi5iNjMzNDdjOGJmNWQgMTAwNjQ0
DQo+ID4+IC0tLSBhL2RyaXZlcnMvaW9tbXUvaW50ZWwvaW9tbXUuYw0KPiA+PiArKysgYi9kcml2
ZXJzL2lvbW11L2ludGVsL2lvbW11LmMNCj4gPj4gQEAgLTMwNTYsMTQgKzMwNTYsNyBAQCBzdGF0
aWMgYm9vbCBkbWFyX2F0c19zdXBwb3J0ZWQoc3RydWN0IHBjaV9kZXYNCj4gPj4gKmRldiwgc3Ry
dWN0IGludGVsX2lvbW11ICppb21tdSkNCj4gPj4gICAJZGV2ID0gcGNpX3BoeXNmbihkZXYpOw0K
PiA+PiAgIAlzYXRjdSA9IGRtYXJfZmluZF9tYXRjaGVkX3NhdGNfdW5pdChkZXYpOw0KPiA+PiAg
IAlpZiAoc2F0Y3UpDQo+ID4+IC0JCS8qDQo+ID4+IC0JCSAqIFRoaXMgZGV2aWNlIHN1cHBvcnRz
IEFUUyBhcyBpdCBpcyBpbiBTQVRDIHRhYmxlLg0KPiA+PiAtCQkgKiBXaGVuIElPTU1VIGlzIGlu
IGxlZ2FjeSBtb2RlLCBlbmFibGluZyBBVFMgaXMgZG9uZQ0KPiA+PiAtCQkgKiBhdXRvbWF0aWNh
bGx5IGJ5IEhXIGZvciB0aGUgZGV2aWNlIHRoYXQgcmVxdWlyZXMNCj4gPj4gLQkJICogQVRTLCBo
ZW5jZSBPUyBzaG91bGQgbm90IGVuYWJsZSB0aGlzIGRldmljZSBBVFMNCj4gPj4gLQkJICogdG8g
YXZvaWQgZHVwbGljYXRlZCBUTEIgaW52YWxpZGF0aW9uLg0KPiA+PiAtCQkgKi8NCj4gPiAuLi53
aGF0IGFib3ZlIGNvbW1lbnQgdHJpZXMgdG8gY29udmV5Lg0KPiA+DQo+ID4gSWYgdGhpcyBjb21t
ZW50IGlzIHZhbGlkLCBpdCdzIG5vdCBhYm91dCB3aGV0aGVyIHRoZSBPUyBpdHNlbGYgc3VwcG9y
dHMNCj4gPiBBVFMuIGluc3RlYWQgaXQncyBhIHJlcXVpcmVtZW50IGZvciB0aGUgT1MgdG8gbm90
IG1hbmFnZSBBVFMgd2hlbg0KPiA+IGl0J3MgYWxyZWFkeSBtYW5hZ2VkIGJ5IEhXLg0KPiA+DQo+
ID4gVW5sZXNzIHRoZXJlIGlzIGEgd2F5IHRvIGRpc2FibGUgaHcgbWFuYWdlbWVudCB3aXRoIHRo
aXMgY2hhbmdlLi4uDQo+IA0KPiBUaGlzIGNvbW1lbnQgaXMgbm90IGNvcnJlY3QuIFRoZSBoYXJk
d2FyZSBhdXRvbWF0aWMgQVRTIGlzIGZvciBvbGRlciBPUw0KPiBjb21wYXRpYmxlIHB1cnBvc2Vz
LCB3aGVyZSB0aGUgQVRTIGlzIG5vdCBhd2FyZSBvZiBieSB0aGUgT1MgeWV0LCBidXQNCj4gQVRT
IGlzIGZ1bmN0aW9uYWxseSByZXF1aXJlZCBmb3Igc29tZSBTT0MtaW50ZWdyYXRlZCBhY2NlbGVy
YXRvcnMuDQo+IA0KPiBUaGUgSEFTIHNwZWNpZmljYXRpb24gZm9yIHRob3NlIHBsYXRmb3JtcyBz
dGF0ZXMgdGhhdCBPU3Mgc3VwcG9ydGluZyBBVFMNCj4gKHNvLWNhbGxlZCBlbmxpZ2h0ZW5lZCBP
U3MpIGRvbid0IHJlcXVpcmUgYXV0b21hdGljIEFUUyBhbnltb3JlLg0KPiANCj4gIEZyb20gdGhl
IGlvbW11IGRyaXZlcidzIHBvaW50IG9mIHZpZXcsIGF1dG9tYXRpYyBBVFMgaXMgbm90IHBhcnQg
b2YgdGhlDQo+IFZULWQgc3BlYyBhbmQgYWxzbyBub3QgZW51bWVyYWJsZSwgaGVuY2UgaXQgc2hv
dWxkIGJlIHRyYW5zcGFyZW50Lg0KPiANCg0KSSdtIGN1cmlvdXMgaG93IGF1dG9tYXRpYyBBVFMg
Y2FuIGJlIGRpc2FibGVkIG90aGVyd2lzZSB0aGUgb2xkDQpjb21tZW50IHN0aWxsIG1ha2VzIHNl
bnNlIGFzIHlvdSB3aWxsIGhhdmUgYm90aCBIVyBhbmQgU1cNCm1hbmFnaW5nIEFUUyBhbmQgdGhl
biBkdXBsaWNhdGVkIGludmFsaWRhdGlvbnMuDQoNCklzIHRoZXJlIGEgQklPUyBvcHRpb24gdG8g
ZGlzYWJsZSBhdXRvbWF0aWMgQVRTPyBUaGVuIHRoZSB1c2VyIHdpbGwNCm5lZWQgdG8ga25vdyB3
aGljaCBrZXJuZWwgdmVyc2lvbiBzdXBwb3J0cyBBVFMgdG8gZGVjaWRlLg0KDQpPciBpcyBpdCBh
dXRvbWF0aWNhbGx5IGVuYWJsZWQvZGlzYWJsZWQgYmFzZWQgb24gd2hldGhlciB0aGUNCklPTU1V
IGlzIGluIGxlZ2FjeSBvciBzY2FsYWJsZSBtb2RlPyBJZiB5ZXMgdGhlbiB3ZSBtYXkgc3RpbGwg
d2FudA0KdG8gZGlzYWJsZSBTVy1tYW5hZ2VkIEFUUyB3aGVuIHRoZSBJT01NVSBpcyBpbiBsZWdh
Y3kgbW9kZSB0bw0KYXZvaWQgZHVwbGljYXRlZCBpbnZhbGlkYXRpb25zLg0KDQpidHcgQVRTIHN1
cHBvcnQgd2FzIGludHJvZHVjZWQgbG9uZyBsb25nIHRpbWUgYWdvOg0KDQpjb21taXQgOTNhMjNh
NzI3MWRmYjgxMWIzYWRiNzI3NzkwNTRjM2EyNDQzMzExMg0KQXV0aG9yOiBZdSBaaGFvIDx5dS56
aGFvQGludGVsLmNvbT4NCkRhdGU6ICAgTW9uIE1heSAxOCAxMzo1MTozNyAyMDA5ICswODAwDQoN
CiAgICBWVC1kOiBzdXBwb3J0IHRoZSBkZXZpY2UgSU9UTEINCg0KICAgIEVuYWJsZSB0aGUgZGV2
aWNlIElPVExCIChpLmUuIEFUUykgZm9yIGJvdGggdGhlIGJhcmUgbWV0YWwgYW5kIEtWTQ0KICAg
IGVudmlyb25tZW50cy4NCg0KICAgIFNpZ25lZC1vZmYtYnk6IFl1IFpoYW8gPHl1LnpoYW9AaW50
ZWwuY29tPg0KICAgIFNpZ25lZC1vZmYtYnk6IERhdmlkIFdvb2Rob3VzZSA8RGF2aWQuV29vZGhv
dXNlQGludGVsLmNvbT4NCg0Kd2hpbGUgdGhpcyBody1tYW5hZ2VkIEFUUyB3YXMgc3VwcG9ydGVk
IG11Y2ggbGF0ZXI6DQoNCmNvbW1pdCA5N2YyZjJjNTMxN2Y1NWFlMzQ0MDczM2EwOTBhOTZhMjUx
ZGEyMjJiDQpBdXRob3I6IFlpYW4gQ2hlbiA8eWlhbi5jaGVuQGludGVsLmNvbT4NCkRhdGU6ICAg
VHVlIE1hciAxIDEwOjAxOjU5IDIwMjIgKzA4MDANCg0KICAgIGlvbW11L3Z0LWQ6IEVuYWJsZSBB
VFMgZm9yIHRoZSBkZXZpY2VzIGluIFNBVEMgdGFibGUNCg0KICAgIFN0YXJ0aW5nIGZyb20gSW50
ZWwgVlQtZCB2My4yLCBJbnRlbCBwbGF0Zm9ybSBCSU9TIGNhbiBwcm92aWRlIGFkZGl0aW9uYWwN
CiAgICBTQVRDIHRhYmxlIHN0cnVjdHVyZS4gU0FUQyB0YWJsZSBpbmNsdWRlcyBhIGxpc3Qgb2Yg
U29DIGludGVncmF0ZWQgZGV2aWNlcw0KICAgIHRoYXQgc3VwcG9ydCBBVEMgKEFkZHJlc3MgdHJh
bnNsYXRpb24gY2FjaGUpLg0KDQogICAgRW5hYmxpbmcgQVRDICh2aWEgQVRTIGNhcGFiaWxpdHkp
IGNhbiBiZSBhIGZ1bmN0aW9uYWwgcmVxdWlyZW1lbnQgZm9yIFNBVEMNCiAgICBkZXZpY2Ugb3Bl
cmF0aW9uIG9yIG9wdGlvbmFsIHRvIGVuaGFuY2UgZGV2aWNlIHBlcmZvcm1hbmNlL2Z1bmN0aW9u
YWxpdHkuDQogICAgVGhpcyBpcyBkZXRlcm1pbmVkIGJ5IHRoZSBiaXQgb2YgQVRDX1JFUVVJUkVE
IGluIFNBVEMgdGFibGUuIFdoZW4gSU9NTVUgaXMNCiAgICB3b3JraW5nIGluIHNjYWxhYmxlIG1v
ZGUsIHNvZnR3YXJlIGNob29zZXMgdG8gYWx3YXlzIGVuYWJsZSBBVFMgZm9yIGV2ZXJ5DQogICAg
ZGV2aWNlIGluIFNBVEMgdGFibGUgYmVjYXVzZSBJbnRlbCBTb0MgZGV2aWNlcyBpbiBTQVRDIHRh
YmxlIGFyZSB0cnVzdGVkIHRvDQogICAgdXNlIEFUUy4NCg0KICAgIE9uIHRoZSBvdGhlciBoYW5k
LCBpZiBJT01NVSBpcyBpbiBsZWdhY3kgbW9kZSwgQVRTIG9mIFNBVEMgY2FwYWJsZSBkZXZpY2Vz
DQogICAgY2FuIHdvcmsgdHJhbnNwYXJlbnRseSB0byBzb2Z0d2FyZSBhbmQgYmUgYXV0b21hdGlj
YWxseSBlbmFibGVkIGJ5IElPTU1VDQogICAgaGFyZHdhcmUuIEFzIHRoZSByZXN1bHQsIHRoZXJl
IGlzIG5vIG5lZWQgZm9yIHNvZnR3YXJlIHRvIGVuYWJsZSBBVFMgb24NCiAgICB0aGVzZSBkZXZp
Y2VzLg0KDQogICAgVGhpcyBhbHNvIHJlbW92ZXMgZG1hcl9maW5kX21hdGNoZWRfYXRzcl91bml0
KCkgaGVscGVyIGFzIGl0IGJlY29tZXMgZGVhZA0KICAgIGNvZGUgbm93Lg0KDQogICAgU2lnbmVk
LW9mZi1ieTogWWlhbiBDaGVuIDx5aWFuLmNoZW5AaW50ZWwuY29tPg0KICAgIExpbms6IGh0dHBz
Oi8vbG9yZS5rZXJuZWwub3JnL3IvMjAyMjAyMjIxODU0MTYuMTcyMjYxMS0xLXlpYW4uY2hlbkBp
bnRlbC5jb20NCiAgICBTaWduZWQtb2ZmLWJ5OiBMdSBCYW9sdSA8YmFvbHUubHVAbGludXguaW50
ZWwuY29tPg0KICAgIExpbms6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3IvMjAyMjAzMDEwMjAx
NTkuNjMzMzU2LTEzLWJhb2x1Lmx1QGxpbnV4LmludGUNCiAgICBTaWduZWQtb2ZmLWJ5OiBKb2Vy
ZyBSb2VkZWwgPGpyb2VkZWxAc3VzZS5kZT4NCg0KVGhhdCBoaXN0b3J5IGRvZXNuJ3QgYXBwZWFy
IHRvIHN1cHBvcnQgeW91ciBhcmd1bWVudCB0aGF0IGl0J3Mgb25seQ0KZm9yIG9sZCBPUyB3aGlj
aCBpcyBub3QgYXdhcmUgb2YgQVRTLi4uDQo=
