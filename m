Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBC0643E49C
	for <iommu@lists.linux.dev>; Wed, 21 Jan 2026 08:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768983149; cv=fail; b=U3t/UIghROeXsfblQqhZ5N27AKJ7MWtD8+ILHgYfm3w8xHrVk5T3Z9tO4rqwt5MxMo2GA1ySAOdKZkiBvs6swr+6a5Xy+2rDKoa+AWFWjpWmv2WgiyK5JmwfyZIC6LnrAlp1oT9EFiITM35Pzz1GOY6Ca/PRsXBnCdsfOBRBF2s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768983149; c=relaxed/simple;
	bh=wvskEoeXYiYvd5YSq88Ayz8aAwPNhKU/Yjn5SThfnv8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SbPeMSChjY9fzg181Rs/bhAepSfR3gbDAskGlifjtMuSVJcB4CosFuHEVclNnDjXrSja7dn+kyuvO7y848WjEuYa6rzVJBfeO4/4Ue2Fr70KkOmYR+d3tayeDEyrllFd9MwsP8dWtB7MJwWU+akBjJ7UxAg1N5kStHF8oNrdHm4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BPjnk4G2; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BPjnk4G2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768983147; x=1800519147;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=wvskEoeXYiYvd5YSq88Ayz8aAwPNhKU/Yjn5SThfnv8=;
  b=BPjnk4G2mPi4htsFPB2IU4BiVZhMnHZN//uhOC1NscbXwoPBU6e9l2/K
   7+XDCnG/8ZBqVaNDmvOe7iprfwmDJfZQFpiWP9scr9f29T0qJ3mEcpzL7
   xa0pMCz4HQLfa+32Ppt5orWvI3LFsv0+g2Wf1Os+hRgwVuEGq+gI6N4v5
   RMX097pUcZaA1atdh6znO3ljCSOfjUk1LVza6E1oEeGFglIjuYENyp653
   jNHWqvnkkA23MfCVWGAh1EvnMvLNGK0iw2wMErW/c2OAwrp7Ru6SL4vAN
   iJUFIjP8WvaHYrgJi+BGk81dVlZFZ4DGHA+a6RLbuVAk4BlXiPr0L00T4
   w==;
X-CSE-ConnectionGUID: 7PVRlIplT2mRvC+v1jMqfg==
X-CSE-MsgGUID: jqlKMyNdQcCngjJzAAy6Xg==
X-IronPort-AV: E=McAfee;i="6800,10657,11677"; a="87617965"
X-IronPort-AV: E=Sophos;i="6.21,242,1763452800"; 
   d="scan'208";a="87617965"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2026 00:12:26 -0800
X-CSE-ConnectionGUID: cGeGvUPoR/W0itG5uxlB3A==
X-CSE-MsgGUID: 5SmSDxKyQ1CrzSM0WICWvA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,242,1763452800"; 
   d="scan'208";a="211239237"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2026 00:12:25 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 21 Jan 2026 00:12:25 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Wed, 21 Jan 2026 00:12:25 -0800
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.47) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 21 Jan 2026 00:12:25 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I2ihMll3w1iguXDyQ+bSb/YCHlc4cbO6YHigAxu0GjAfXc9xDTGkVkvDTBfKIV31wGEjMOOxsOOtmIS8WA0BNIjIhnDZXiZI6NMVk9EniG56C/zrr3YPmPQ6/uoPWdCdUHWYIKidtsGbL79b28Hhsd7/gkxz1+zK10YXK2ZcA9f01z8uWWBCGSZredSK/PuD+dAwEVK15n5jDYt8iUO10jVSwiSFk4d/zf7L1B6pbMr8gLUIBKwWTYnkPN8Rs1g1o3Jkeq9H51HQ1VxU6g0OYuCOWqZXYhtjrJu9gvmJw/x1yUIPEBgFIRgmwx7fIIgO1OTtNNRBersaJm9zbRtcDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wvskEoeXYiYvd5YSq88Ayz8aAwPNhKU/Yjn5SThfnv8=;
 b=JSfgH4e4zVyAHJasQpCL2ml5g0BPf15LYa7H67RjJNzU7pfq9xUyGgi3kC247hirUo0Uw6nI0/X7jSe9zyAm6kBnQvTprOJB72K3ZYWgC4KOxT9I0yxvY7A1r/6mpx4OyFNibFygix7TcbuSXDV77GEA5/Lu07I6X3507v5na1cslbYHfGhrpplLkIV1qtCtKlO71vRf6Q6zMg1METTH/J4vQ6rYTa3wstkir40kEEL9R/GKmB6LVnWxKWecZuqNHLQCxYo3HnW2KeRSzG6jXqAVriKFwFLB2d9xAcGcRQbBZIHJkEfEWmncYkYLTwmELeOObYjow+HBIx5MUMZ+tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5271.namprd11.prod.outlook.com (2603:10b6:208:31a::21)
 by SJ5PPF8EC896901.namprd11.prod.outlook.com (2603:10b6:a0f:fc02::844) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Wed, 21 Jan
 2026 08:12:23 +0000
Received: from BL1PR11MB5271.namprd11.prod.outlook.com
 ([fe80::780e:4379:6988:f48b]) by BL1PR11MB5271.namprd11.prod.outlook.com
 ([fe80::780e:4379:6988:f48b%6]) with mapi id 15.20.9542.008; Wed, 21 Jan 2026
 08:12:23 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Baolu Lu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, "Will
 Deacon" <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, "Jason
 Gunthorpe" <jgg@nvidia.com>
CC: Dmytro Maluka <dmaluka@chromium.org>, Samiullah Khawaja
	<skhawaja@google.com>, "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 2/3] iommu/vt-d: Clear Present bit before tearing down
 context entry
Thread-Topic: [PATCH v2 2/3] iommu/vt-d: Clear Present bit before tearing down
 context entry
Thread-Index: AQHcidTzCfYiZ0yzRkeXiAiaNaQQUrVcJ3HQgAAUF4CAAAUHoIAABNSAgAACHLA=
Date: Wed, 21 Jan 2026 08:12:23 +0000
Message-ID: <BL1PR11MB52711FA152B59686DE3165648C96A@BL1PR11MB5271.namprd11.prod.outlook.com>
References: <20260120061816.2132558-1-baolu.lu@linux.intel.com>
 <20260120061816.2132558-3-baolu.lu@linux.intel.com>
 <BL1PR11MB5271F1F4DF8B6D4052D626088C96A@BL1PR11MB5271.namprd11.prod.outlook.com>
 <a2c1531a-f720-412f-9f39-6a6b9fabe5e7@linux.intel.com>
 <BL1PR11MB5271D3AE08DAF677E44449B78C96A@BL1PR11MB5271.namprd11.prod.outlook.com>
 <f5b1aa1a-5d20-40c8-9f3f-5bc37766fe75@linux.intel.com>
In-Reply-To: <f5b1aa1a-5d20-40c8-9f3f-5bc37766fe75@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5271:EE_|SJ5PPF8EC896901:EE_
x-ms-office365-filtering-correlation-id: 7dc6edd7-45a7-4c22-7d5d-08de58c4ce7a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?Wm9jK25IRHd5Q0o1L1dqZG1iTjJWVkd4RDFVVTRXemg3cWJDQ01zY2xxdjdn?=
 =?utf-8?B?cHRhN0p2Rm52RmFTcGNSZHdaK1lSdFVHNFpUU1hiVUJTSE9MWFc5MlBnckIw?=
 =?utf-8?B?VTJYYWQxcTVXYnh4Vld5RlNuMFR2eW5HU25YdG5TZlQ2dUNwZ1crZDM0SG01?=
 =?utf-8?B?QlN3Q1AwamJkZmtHZ2JnTXZKT2p2ejNzUUtZOUtrd1BXcytRZTI1dVBOV1FV?=
 =?utf-8?B?ckVCZmxwNXE5aDg0czhEWWpHR3hsVHFCSThXRmxUZzdpdnFpU3BId2pUWWJm?=
 =?utf-8?B?V1FXOTIxelo3OGtoTGJ1UHVZUVVZYUR3SWFnZENhR3hUb1F3UWcxalBzWSs0?=
 =?utf-8?B?THV6STJmbWcvcXBSWmZzSm9MR294eVZ1aVJnaitvVnhhdGRwOGppVmpJKzBs?=
 =?utf-8?B?S1Rod0k5TTFlYVZQRlliWTNxbjF0bXR4YURjZWJIT3hxZnlROVQrYy9DMURP?=
 =?utf-8?B?MkNhVWs4cGxZak5hZnczSVFtSFdER0hsU2IyUUlSQy92UXdwVFozYTVDVVVT?=
 =?utf-8?B?TVBMbTFGeXV1aUU4VDFEbm1hVzh6L2N4c2c2MkRyb1ZpQy8xUHBYMDdHcWQw?=
 =?utf-8?B?SnFxMjJlbWg4dE5LR1FBU1liWVZ0N2U3VzJYVjUra285dS9PUnFmRjBxQzg2?=
 =?utf-8?B?UktPNDB6RG5xcUppOVNqaVBiRnZtcVlWcFBDaTN6cEp5M08wa0hVMWQ5cVcz?=
 =?utf-8?B?eCtMYlluNEhCUFhURU1vUy8rb293OTV2NUpWYU5ObzF3SmwrczFQbWZrbU1a?=
 =?utf-8?B?THhPRGdCQzBIS1VJeHFUSE9Gd3NLcW52emh2RzZmV2VaSCtGWGdHRWFmYkQy?=
 =?utf-8?B?UGVVbVZ5cWhLWFltS3h4RmEyYjB1M2I5dDMwOHp3SCs4VDBtSkxCQkEvZG5h?=
 =?utf-8?B?eWRtK0k1RUpGV0kzS2NDajErbkM3WXNxTVBnV3RuNkVJMUt6NDVJcU9haE9s?=
 =?utf-8?B?aTJkWWJ0L1R1L2xGYm5yQ1FIbjZUT1ptdnBFdWluWnFPMGRMbVFEQjFVR1BT?=
 =?utf-8?B?d0l1NXllcjkxRjdLT09HL1lXR2VwYjNmTlYyTEJWbENNbjJuZWNEU0ZHMkpp?=
 =?utf-8?B?VW5Ka3NBSzhNNk5hSXMrWG0ydHRYSkhLSVJmaUdhSzZ5aDFueXp5M0hpcnN2?=
 =?utf-8?B?ZE91VmZVV1BncFRPTVRXTDhFQ0Z6UXFnR2pTaEFFcFoxeUdPanFXZkh0eFNi?=
 =?utf-8?B?K3dnREs2dkp0QjlMSUJDOUlCVHFTRHg1WW8ybTRUcWI3Y0V4VjAyQWhhWW85?=
 =?utf-8?B?Q1ZuRmNnVVlhemJIK3d3bnBhVEpwM3h0VkJLYTVRUkwvNHRyVGhMZDJSWXlT?=
 =?utf-8?B?RkU4NWVCQys5Skdhc0NESUNrMGkvZmNjN3k1RDRvS0hENGVoMGprc2hWblhB?=
 =?utf-8?B?cThhelBxWDNuM0lBSWN1N1dKRXY5bUxwdmE5dHk1cXZyTkF1UlBuYU5PRVQy?=
 =?utf-8?B?eFNBWDlkcXMrbnpFN2NVM1FESEdVNmNqV2NzSElzTGlHL1UyYlhiSW52RDg2?=
 =?utf-8?B?OWdEWDJERWsrTHNSWkkwdEE4RnVoQTZpYzNPRTJGeEJ4UjNSZG5QMktOcDMr?=
 =?utf-8?B?d3B0N082U2p2dnl3MFdBR0paMHlVRUNVSGFzeTBpVTdzaWxHeUdOa0lzZ0ZK?=
 =?utf-8?B?cm1nR0FZTmZwQWtqamplWlM1ZlpKdkJPekNmTEhpRytpTnRqb1dWNEd3WkFQ?=
 =?utf-8?B?L1pCeHdzYk9EeU01aXNnU1FTcEpIMW9qaTFZSGZhWUd4dlVybTg2eFdtcE5o?=
 =?utf-8?B?U1pCa2JLRDJLcHpiamY3bzI5OTNmU200MGhBT3F4TW5YQ2VySExNYW94Vmxp?=
 =?utf-8?B?dUJYcTgzY3lvQkZ4aGdUbEQ0TCtrejVNWXdLWk5CQUpwTzdXYW4vMVpaVUor?=
 =?utf-8?B?d2c3TXpuVnFCTFVJYjFBZWN0Z0I0bFA3RlpPaG9TdThXSVNacjF6Y0ZQYjg5?=
 =?utf-8?B?aEl5RG4yVHI5Tk5Db2pkSGhXZlNQT1RoOW5aMFQwLzJmcnNIM0ZqUlVZQ1Zn?=
 =?utf-8?B?S0tGT1NuNkpMQzdYTE5mdW1odDRtTDZRakJlKytRaVJ4WDdQL25mRVFXalda?=
 =?utf-8?B?M2QvY0FrT2ZaR3lJWkZLNllhNjBESEpkN25xdXBnbngwZlViWjZIYnRvSnpC?=
 =?utf-8?B?M25LbUQ2TlZobmlFRGFuWmpaa01PZlRBUDl0SWhzV1JuQ09SMlVKRGlDZkdF?=
 =?utf-8?Q?6jDvRX0Lvh9jaA0dptHdry8=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5271.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QldSZTcwdEZFWlJBNEI2SGFza2hRaXJkVW52QktzSjdWd0FRbTFDQm1OTm40?=
 =?utf-8?B?NWlhYndvL2tYaHkwNDhxSmtvMytMd0RlT29GenZrN2hJWWxuZVRSL3FiY0RD?=
 =?utf-8?B?QmZIYmtxcHJPcHBRaDdkclcyMmVkayswR3R4S0lTVjIxK3F4L1hyRjg3QldG?=
 =?utf-8?B?bnJWVlNiczlaSUhsUTR2NlAzTk42eFo2UU85ckEzZ1NPeFphWlVGd2xwWUsw?=
 =?utf-8?B?Tmh4UnZBSEFIajFVUHE5MnRMYmhvbkdPdG54UEtRQVBySW1tZ2U5UjVFcll5?=
 =?utf-8?B?MkNVcGJuQ3VIUUtJUTJnSGpGYUFXVXlZMkZKNThMaTJVSExZc0ZadS9aRUE2?=
 =?utf-8?B?V3RreklEVXkvYzVSRnMwVlZQQmJxb3JiZWlRMlg5WEU1Q2hZU2R1S2krU1l6?=
 =?utf-8?B?U2k2WHV1MkoxUHRUTm10QzlMT0ZEWlhWVG5WcGRHMGhmNE9wL3VvMWpIZjF6?=
 =?utf-8?B?SmRsM0YzeWw0d1pDdWpJSnJHUXVXWTNFMHQra2hnMG1Ha1FwdWEvYWt6RzVH?=
 =?utf-8?B?S1hrME9USHlDVitZeTNzT01ia05YSFN2U3JNM204TUxjdXZDMWV5SjVQTkk5?=
 =?utf-8?B?d3NXYTlkT2RWUFh5aUZEaGN0OURRTHR3SzhmZjYyVzdCc0poYVc1ZlFRVDFq?=
 =?utf-8?B?MmJMRXVLbFZLTTBrT3d0Ri9oRkJDWXVzVk11bVIzVk8wRnNRck1MQjVZZkhY?=
 =?utf-8?B?Tjcra0dLMU43THNROTlYUXB3ZGZpTndaWUJ1M0o4NzRmeWxSajNKQU9ScElw?=
 =?utf-8?B?QTdzZ084YkxoeHo0eUtEL3h6QzM5UWpaVHgvSTFlZnp1MzN6WmgyaHN5ay9S?=
 =?utf-8?B?U3RpVk4vS2hKSkxIeGVhWjAzb3RoTE5KWXRPYWpMaWxYczYrdlk5ZTdRTnpO?=
 =?utf-8?B?MVVEUkdFL3hJZTdORm4rN3ZKbVJEUHlpeXJaWFVySUJDZ3RwaUJPMEMyMUd1?=
 =?utf-8?B?SnNuNS9nb243SjBMOUtxQ3k4M0sycmtWK1JPTXREaG5Lb0dVTU0xeUNvREp5?=
 =?utf-8?B?aXNpWmlESEI3UVZKMCtXN2g0QTJFTjZTZHlpME0wcS9OVTQ3RWZVSEZUWXZU?=
 =?utf-8?B?cVQwSmZEd245VkoxYXRUdHFHWm42TGFvMFMvQm9oYStlZFY5UDVXSWFkSEln?=
 =?utf-8?B?KzJ3Qi9yV0pBSzg4V2F3MTYvWThpeDFPdGUyMi9VZ2hUbDN5Ykdsb2JHbWpR?=
 =?utf-8?B?Z2t0RCtvUllIMUhxK2tndFJ4Wks3L09nM1dac2FYOGIyNTMwL1BGWGZtMFFP?=
 =?utf-8?B?RFUyUjV6bThTT2xham50MXg5NEswK3dXeHNMalllT3pPdnBOTXdaRXJqVStw?=
 =?utf-8?B?SkQ5cVJDT1g5QjN3OGh6QlVmWXJ4ZDhtTGZHSUt2dmNJa1B0TnBRS2o2ckJE?=
 =?utf-8?B?S1RZSDNGMzZxMW5WZ1pNQXNEQkR6amNNSEV3MjQxb1N1MzlvMGp3WE5pSU5u?=
 =?utf-8?B?bUgzVDBiY1hWeG4yVTJ3dXB5a1NseVh4MFRxSnlrRVJQNzRJYXV4d0N1OUxL?=
 =?utf-8?B?ais2YzU4bUEzWGVoWmZXVHd0WG03MHhpUk9CNWNzc3FscUkwRVB3dks0QUto?=
 =?utf-8?B?cy96SlFTNE1FRlUwNFV3MkJvZ1VNb1Rjd1lLUUdSYlF2RWJnR3FJcUlmSVFm?=
 =?utf-8?B?aTFkaUI0cXpCUEZmUk1DN3ZBS3FxdUtLUlZTaG4yMk5yRlRuV3FEWkJuT3BC?=
 =?utf-8?B?MDdvb3hZQTh5MkYwcGFmenpVV29qYnBzMHQxbGlNbUd0ak9uRTNjQWtZbkEr?=
 =?utf-8?B?eXVsMmVkT0VBemJ4bUw3UCtaL3NJVkwvQU5yWEVaM3JrZ1FxVEZQSkZDVjNS?=
 =?utf-8?B?RDlqTklKR2NuR21FRjNXM0RsY1VWT3Q0K0VqTUxXcnVLT21BeU9EbW9mY0N2?=
 =?utf-8?B?dHlLMzlDcXl1K1RmcTBxQ2xybmUzRDNGenNtN3Fkck40ZXpWOXpvMnU2K2Ru?=
 =?utf-8?B?eVhlcHg0MEl6N0JxL0NlNm1uSEZxU3E2MnBGVk9HVUo2amIrZDV4cFA3bWhC?=
 =?utf-8?B?NjZ2aW9ac0JxNTRiTFpBMjArSjZ6VjZBd29PcDlXQ2RuN1R0dWRhQmRJeEEy?=
 =?utf-8?B?R1ZEcmRXeVpEWWtJY0N0aS85STZFNk13bEJVeUJqNFczYVBsM1N4bXRKa0Jk?=
 =?utf-8?B?WVJVYXZyQ0lya2ZwaWxUU0VUK1U3SElHTk5XUENVLy9IOUpERFBTQlU3YTNO?=
 =?utf-8?B?aUlIWldvMUdEdmltS0JMYVk3V2NEZ1VzcEEwMGx1NHhDWXBCcHgwa1Vkbk5v?=
 =?utf-8?B?VXYxYTNXdTlhTzBDRU41WlA4R2JJRnMwYldFekJrSk9NaldrK2tQYy94MnRu?=
 =?utf-8?B?eTRlYmQyMExaR0h2RmZnUXR5WkRhcWF2MzdPN2xTZ2tHOTBaY3paZz09?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 7dc6edd7-45a7-4c22-7d5d-08de58c4ce7a
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jan 2026 08:12:23.3829
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OKEEKBofMbJRkrIBwjPSjaQ2SLIB73L4tvDR+zO2lfdSa+8Dg3v98OWU8Kn+ERNsrlzyclK8mdFbxMgNkGaPhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF8EC896901
X-OriginatorOrg: intel.com

PiBGcm9tOiBCYW9sdSBMdSA8YmFvbHUubHVAbGludXguaW50ZWwuY29tPg0KPiBTZW50OiBXZWRu
ZXNkYXksIEphbnVhcnkgMjEsIDIwMjYgNDowNCBQTQ0KPiANCj4gT24gMS8yMS8yNiAxNTo1MCwg
VGlhbiwgS2V2aW4gd3JvdGU6DQo+ID4+IEZyb206IEJhb2x1IEx1IDxiYW9sdS5sdUBsaW51eC5p
bnRlbC5jb20+DQo+ID4+IFNlbnQ6IFdlZG5lc2RheSwgSmFudWFyeSAyMSwgMjAyNiAzOjI5IFBN
DQo+ID4+DQo+ID4+IE9uIDEvMjEvMjYgMTQ6MjMsIFRpYW4sIEtldmluIHdyb3RlOg0KPiA+Pj4+
IEZyb206IEx1IEJhb2x1IDxiYW9sdS5sdUBsaW51eC5pbnRlbC5jb20+DQo+ID4+Pj4gU2VudDog
VHVlc2RheSwgSmFudWFyeSAyMCwgMjAyNiAyOjE4IFBNDQo+ID4+Pj4NCj4gPj4+PiBXaGVuIHRl
YXJpbmcgZG93biBhIGNvbnRleHQgZW50cnksIHRoZSBjdXJyZW50IGltcGxlbWVudGF0aW9uIHpl
cm9zDQo+ID4+IHRoZQ0KPiA+Pj4+IGVudGlyZSAxMjgtYml0IGVudHJ5IHVzaW5nIG11bHRpcGxl
IDY0LWJpdCB3cml0ZXMuIFRoaXMgY3JlYXRlcyBhIHdpbmRvdw0KPiA+Pj4+IHdoZXJlIHRoZSBo
YXJkd2FyZSBjYW4gZmV0Y2ggYSAidG9ybiIgZW50cnkg4oCUIHdoZXJlIHNvbWUgZmllbGRzIGFy
ZQ0KPiA+Pj4+IGFscmVhZHkgemVyb2VkIHdoaWxlIHRoZSAnUHJlc2VudCcgYml0IGlzIHN0aWxs
IHNldCDigJQgbGVhZGluZyB0bw0KPiA+Pj4+IHVucHJlZGljdGFibGUgYmVoYXZpb3Igb3Igc3B1
cmlvdXMgZmF1bHRzLg0KPiA+Pj4+DQo+ID4+Pj4gV2hpbGUgeDg2IHByb3ZpZGVzIHN0cm9uZyB3
cml0ZSBvcmRlcmluZywgdGhlIGNvbXBpbGVyIG1heSByZW9yZGVyDQo+ID4+IHdyaXRlcw0KPiA+
Pj4+IHRvIHRoZSB0d28gNjQtYml0IGhhbHZlcyBvZiB0aGUgY29udGV4dCBlbnRyeS4gRXZlbiB3
aXRob3V0IGNvbXBpbGVyDQo+ID4+Pj4gcmVvcmRlcmluZywgdGhlIGhhcmR3YXJlIGZldGNoIGlz
IG5vdCBndWFyYW50ZWVkIHRvIGJlIGF0b21pYyB3aXRoDQo+ID4+Pj4gcmVzcGVjdCB0byBtdWx0
aXBsZSBDUFUgd3JpdGVzLg0KPiA+Pj4+DQo+ID4+Pj4gQWxpZ24gd2l0aCB0aGUgIkd1aWRhbmNl
IHRvIFNvZnR3YXJlIGZvciBJbnZhbGlkYXRpb25zIiBpbiB0aGUgVlQtZCBzcGVjDQo+ID4+Pj4g
KFNlY3Rpb24gNi41LjMuMykgYnkgaW1wbGVtZW50aW5nIHRoZSByZWNvbW1lbmRlZCBvd25lcnNo
aXANCj4gPj4gaGFuZHNoYWtlOg0KPiA+Pj4+DQo+ID4+Pj4gMS4gQ2xlYXIgb25seSB0aGUgJ1By
ZXNlbnQnIChQKSBiaXQgb2YgdGhlIGNvbnRleHQgZW50cnkgZmlyc3QgdG8NCj4gPj4+PiAgICAg
IHNpZ25hbCB0aGUgdHJhbnNpdGlvbiBvZiBvd25lcnNoaXAgZnJvbSBoYXJkd2FyZSB0byBzb2Z0
d2FyZS4NCj4gPj4+PiAyLiBVc2UgZG1hX3dtYigpIHRvIGVuc3VyZSB0aGUgY2xlYXJlZCBiaXQg
aXMgdmlzaWJsZSB0byB0aGUgSU9NTVUuDQo+ID4+Pj4gMy4gUGVyZm9ybSB0aGUgcmVxdWlyZWQg
Y2FjaGUgYW5kIGNvbnRleHQtY2FjaGUgaW52YWxpZGF0aW9uIHRvIGVuc3VyZQ0KPiA+Pj4+ICAg
ICAgaGFyZHdhcmUgbm8gbG9uZ2VyIGhhcyBjYWNoZWQgcmVmZXJlbmNlcyB0byB0aGUgZW50cnku
DQo+ID4+Pj4gNC4gRnVsbHkgemVybyBvdXQgdGhlIGVudHJ5IG9ubHkgYWZ0ZXIgdGhlIGludmFs
aWRhdGlvbiBpcyBjb21wbGV0ZS4NCj4gPj4+Pg0KPiA+Pj4+IEFsc28sIGFkZCBhIGRtYV93bWIo
KSB0byBjb250ZXh0X3NldF9wcmVzZW50KCkgdG8gZW5zdXJlIHRoZSBlbnRyeQ0KPiA+Pj4+IGlz
IGZ1bGx5IGluaXRpYWxpemVkIGJlZm9yZSB0aGUgJ1ByZXNlbnQnIGJpdCBiZWNvbWVzIHZpc2li
bGUuDQo+ID4+Pj4NCj4gPj4+PiBGaXhlczogYmEzOTU5Mjc2NGVkMiAoIkludGVsIElPTU1VOiBJ
bnRlbCBJT01NVSBkcml2ZXIiKQ0KPiA+Pj4+IFJlcG9ydGVkLWJ5OiBEbXl0cm8gTWFsdWthIDxk
bWFsdWthQGNocm9taXVtLm9yZz4NCj4gPj4+PiBDbG9zZXM6IGh0dHBzOi8vbG9yZS5rZXJuZWwu
b3JnL2FsbC9hVEc3Z2M3STV3RXhhaTNTQGdvb2dsZS5jb20vDQo+ID4+Pj4gU2lnbmVkLW9mZi1i
eTogTHUgQmFvbHUgPGJhb2x1Lmx1QGxpbnV4LmludGVsLmNvbT4NCj4gPj4+DQo+ID4+PiBSZXZp
ZXdlZC1ieTogS2V2aW4gVGlhbiA8a2V2aW4udGlhbkBpbnRlbC5jb20+DQo+ID4+Pg0KPiA+Pj4g
YnR3IHRoZXJlIGlzIGEgY29udGV4dF9jbGVhcl9lbnRyeSgpIGZvciBjb3BpZWQgY29udGV4dCBl
bnRyeSBpbg0KPiA+Pj4gZGV2aWNlX3Bhc2lkX3RhYmxlX3NldHVwKCksIGJ1dCB0aGlzIHBhdGNo
IGRvZXNuJ3QgdG91Y2ggdGhhdA0KPiA+Pj4gcGF0aC4gSXQgc2VlbXMgdG8gYXNzdW1lIHRoYXQg
bm8gaW4tZmxpZ2h0IERNQSB3aWxsIGV4aXN0IGF0IHRoYXQNCj4gPj4+IHBvaW50Og0KPiA+Pj4N
Cj4gPj4+ICAgICAgICAgICBpZiAoY29udGV4dF9jb3BpZWQoaW9tbXUsIGJ1cywgZGV2Zm4pKSB7
DQo+ID4+PiAgICAgICAgICAgICAgICAgICBjb250ZXh0X2NsZWFyX2VudHJ5KGNvbnRleHQpOw0K
PiA+Pj4gICAgICAgICAgICAgICAgICAgLi4uDQo+ID4+PiAgICAgICAgICAgICAgICAgICAvKg0K
PiA+Pj4gICAgICAgICAgICAgICAgICAgICogQXQgdGhpcyBwb2ludCwgdGhlIGRldmljZSBpcyBz
dXBwb3NlZCB0byBmaW5pc2ggcmVzZXQgYXQNCj4gPj4+ICAgICAgICAgICAgICAgICAgICAqIGl0
cyBkcml2ZXIgcHJvYmUgc3RhZ2UsIHNvIG5vIGluLWZsaWdodCBETUEgd2lsbCBleGlzdCwNCj4g
Pj4+ICAgICAgICAgICAgICAgICAgICAqIGFuZCB3ZSBkb24ndCBuZWVkIHRvIHdvcnJ5IGFueW1v
cmUgaGVyZWFmdGVyLg0KPiA+Pj4gICAgICAgICAgICAgICAgICAgICovDQo+ID4+PiAgICAgICAg
ICAgICAgICAgICBjbGVhcl9jb250ZXh0X2NvcGllZChpb21tdSwgYnVzLCBkZXZmbik7DQo+ID4+
Pg0KPiA+Pj4gSXMgdGhhdCBndWFyYW50ZWVkIGJ5IGFsbCBkZXZpY2VzPyBmcm9tIGtkdW1wIGZl
YXR1cmUgcC5vLnYuIGlmDQo+ID4+PiB0aGF0IGFzc3VtcHRpb24gaXMgYnJva2VuIGl0IGp1c3Qg
bWVhbnMgcG90ZW50aWFsIERNQSBlcnJvcnMNCj4gPj4+IGluIHRoaXMgdHJhbnNpdGlvbiB3aW5k
b3cuIEJ1dCByZWdhcmRpbmcgdG8gdGhlIGlzc3VlIHdoaWNoIHRoaXMNCj4gPj4+IHBhdGNoIHRy
aWVzIHRvIGZpeCwgaW4tZmx5IERNQXMgbWF5IGxlYWQgdG8gdW5kZXNpcmVkIGJlaGF2aW9ycw0K
PiA+Pj4gaW5jbHVkaW5nIG1lbW9yeSBjb3JydXB0aW9uIGV0Yy4NCj4gPj4+DQo+ID4+PiBTbywg
c2hvdWxkIGl0IGJlIGZpeGVkIHRvbz8NCj4gPj4NCj4gPj4gVGhpcyBwYXRoIGlzIHRyaWdnZXJl
ZCB3aGVuIHRoZSBkZXZpY2UgZHJpdmVyIGhhcyBwcm9iZWQgdGhlIGRldmljZQ0KPiA+PiAoZW5z
dXJpbmcgaXQgaGFzIGJlZW4gcmVzZXQpIGFuZCB0aGVuIGNhbGxzIHRoZSBrZXJuZWwgRE1BIEFQ
SSBmb3IgdGhlDQo+ID4+IGZpcnN0IHRpbWUuIEF0IHRoaXMgc3RhZ2UsIHRoZXJlIHNob3VsZCBi
ZSBubyBpbi1mbGlnaHQgRE1Bcy4gV2UgY2FuDQo+ID4+IGFwcGx5IHRoZSBzYW1lIGxvZ2ljIGhl
cmUgdG8gaW1wcm92ZSBjb2RlIHJlYWRhYmlsaXR5LCBidXQgdGhpcyBpcyBub3QgYQ0KPiA+PiBi
dWcgdGhhdCByZXF1aXJlcyBhIGZpeC4gT3Igbm90Pw0KPiA+Pg0KPiA+DQo+ID4gZGV2aWNlIGNv
dWxkIGJlIGluIHdoYXRldmVyIHN0YXRlIHdoZW4ga2R1bXAgaXMgdHJpZ2dlcmVkLiBJJ20gbm90
DQo+ID4gc3VyZSB3aGV0aGVyIGFsbCBkZXZpY2UgZHJpdmVycyB3aWxsIHJlc2V0IHRoZSBkZXZp
Y2UgYXQgcHJvYmUgdGltZS4NCj4gDQo+IE9rYXksIGFncmVlZC4NCj4gDQo+ID4gSnVzdCB0aG91
Z2h0IHRoYXQgYXBwbHlpbmcgdGhlIHNhbWUgZHVlIGRpbGlnZW5jZSBoZXJlIGNvdWxkIHByZXZl
bnQNCj4gPiBhbnkgdW5kZXNpcmVkIGRhbWFnZSBqdXN0IGluIGNhc2UuIE5vdCBleGFjdGx5IGZv
ciBiYWNrcG9ydGluZywgYnV0DQo+ID4gaXQncyBhbHdheXMgZ29vZCB0byBoYXZlIGNvbnNpc3Rl
bnQgbG9naWMgdG8gYXZvaWQgc3BlY2lhbCBjYXNlIGJhc2VkDQo+ID4gb24gc3VidGxlIGFzc3Vt
cHRpb25zLi4uDQo+IA0KPiBTbyBJIHdpbGwgYWRkIHRoZSBmb2xsb3dpbmcgYWRkaXRpb25hbCBj
aGFuZ2U6DQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9pb21tdS9pbnRlbC9wYXNpZC5jIGIv
ZHJpdmVycy9pb21tdS9pbnRlbC9wYXNpZC5jDQo+IGluZGV4IDM0ZjRhZjRlOWI1Yy4uYjYzYTcx
OTA0Y2ZiIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2lvbW11L2ludGVsL3Bhc2lkLmMNCj4gKysr
IGIvZHJpdmVycy9pb21tdS9pbnRlbC9wYXNpZC5jDQo+IEBAIC04NDAsNyArODQwLDcgQEAgc3Rh
dGljIGludCBkZXZpY2VfcGFzaWRfdGFibGVfc2V0dXAoc3RydWN0IGRldmljZQ0KPiAqZGV2LCB1
OCBidXMsIHU4IGRldmZuKQ0KPiAgICAgICAgICB9DQo+IA0KPiAgICAgICAgICBpZiAoY29udGV4
dF9jb3BpZWQoaW9tbXUsIGJ1cywgZGV2Zm4pKSB7DQo+IC0gICAgICAgICAgICAgICBjb250ZXh0
X2NsZWFyX2VudHJ5KGNvbnRleHQpOw0KPiArICAgICAgICAgICAgICAgY29udGV4dF9jbGVhcl9w
cmVzZW50KGNvbnRleHQpOw0KPiAgICAgICAgICAgICAgICAgIF9faW9tbXVfZmx1c2hfY2FjaGUo
aW9tbXUsIGNvbnRleHQsIHNpemVvZigqY29udGV4dCkpOw0KPiANCj4gICAgICAgICAgICAgICAg
ICAvKg0KPiBAQCAtODYwLDYgKzg2MCw5IEBAIHN0YXRpYyBpbnQgZGV2aWNlX3Bhc2lkX3RhYmxl
X3NldHVwKHN0cnVjdCBkZXZpY2UNCj4gKmRldiwgdTggYnVzLCB1OCBkZXZmbikNCj4gICAgICAg
ICAgICAgICAgICBpb21tdS0+Zmx1c2guZmx1c2hfaW90bGIoaW9tbXUsIDAsIDAsIDAsDQo+IERN
QV9UTEJfR0xPQkFMX0ZMVVNIKTsNCj4gICAgICAgICAgICAgICAgICBkZXZ0bGJfaW52YWxpZGF0
aW9uX3dpdGhfcGFzaWQoaW9tbXUsIGRldiwgSU9NTVVfTk9fUEFTSUQpOw0KPiANCj4gKyAgICAg
ICAgICAgICAgIGNvbnRleHRfY2xlYXJfZW50cnkoY29udGV4dCk7DQo+ICsgICAgICAgICAgICAg
ICBfX2lvbW11X2ZsdXNoX2NhY2hlKGlvbW11LCBjb250ZXh0LCBzaXplb2YoKmNvbnRleHQpKTsN
Cj4gKw0KPiAgICAgICAgICAgICAgICAgIC8qDQo+ICAgICAgICAgICAgICAgICAgICogQXQgdGhp
cyBwb2ludCwgdGhlIGRldmljZSBpcyBzdXBwb3NlZCB0byBmaW5pc2ggcmVzZXQgYXQNCj4gICAg
ICAgICAgICAgICAgICAgKiBpdHMgZHJpdmVyIHByb2JlIHN0YWdlLCBzbyBubyBpbi1mbGlnaHQg
RE1BIHdpbGwgZXhpc3QsDQo+IA0KPiBBcHBlYXJzIGdvb2QgdG8geW91Pw0KPiANCg0KeWVzDQo=
