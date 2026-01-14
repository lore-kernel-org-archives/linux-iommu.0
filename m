Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8585B368269
	for <iommu@lists.linux.dev>; Wed, 14 Jan 2026 07:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768375953; cv=fail; b=cZui2z7joI8VAao5TuyldGil666DJ486LI1zzO0m/ulo9EBUeeP1QSyBedAWMtDcV503qFBW7m3MObq4/e9SPIL0URNStkh9T9GBdyeIzSbsgXU35BSktJwuWWYiAQm17C+kzshh26k49NiFhnrhHqy/scvTpI0MjpZ+Ea5bTsU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768375953; c=relaxed/simple;
	bh=MRzFwKDxbytgN/IFN6ASSQRuMy9GlT/FZ6XzgKCVyrs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jGy+3liWh7BrVB4uibO4RnjXcdKsW2pJZOmghXOuV7kWz4QzkB8DLyx11PsPPkiVrLME44ZM3WuMfTvd9BF6ELjpoO/oO6jkWFTEq6rpHXuwPFcavKeB1x3b1vqLnaSCEr9WcgCPIvLDnZA7lVg9zEaaWzAAbxMEb9EilzNBd7o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dkLkYq6h; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dkLkYq6h"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768375949; x=1799911949;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=MRzFwKDxbytgN/IFN6ASSQRuMy9GlT/FZ6XzgKCVyrs=;
  b=dkLkYq6hPFqmjXk/wMxP2/EQhu1PQpQBBqf+h5WZIie2AV2IBQIugL1r
   xrK/mt9vGDhwsc2uHB7f64xg0ewgpAVUBIkgjIaUn4XVlKWjLOJLtnztg
   mKfneUYT7EhyO7uHxgjAUP9Ugj8AxhUDhcn7i/fA4sgYubA5PdXCH2wkx
   0GCiEMQ9lhLCBrIjCNLA8lLjg3q4f68E6rNkw0jhUC4Lkn5RhgmVIr3j1
   mdCMxn/LVasixtXrio8rNAM/5TRKNBWpPXUe1lvNiRV1dmQ27jaS2EwIJ
   uBeNlA6KWZCewWMz0qUQXZ8v2Z+YVbxpMCes0pzyPHxYISywwxJqWu15f
   w==;
X-CSE-ConnectionGUID: wud4xuHqT1GRSu3TovI3fQ==
X-CSE-MsgGUID: yWuUcVnoQhia3ACj7YHNdA==
X-IronPort-AV: E=McAfee;i="6800,10657,11670"; a="73525188"
X-IronPort-AV: E=Sophos;i="6.21,225,1763452800"; 
   d="scan'208";a="73525188"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2026 23:32:27 -0800
X-CSE-ConnectionGUID: Rtikpk/PS7eMRM9xlOmB7A==
X-CSE-MsgGUID: u80cF4AOTyeAg/3KBRbMmg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,225,1763452800"; 
   d="scan'208";a="209653574"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2026 23:32:26 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 13 Jan 2026 23:32:25 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Tue, 13 Jan 2026 23:32:25 -0800
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.37) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 13 Jan 2026 23:32:25 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NcU62Vy9vB882Sgulqw9rX00MuGcnVIz1loPrVYAfWUgTkrrTq/z9pUf3BdEZH4rsrT0qIapyogoxU8uXgESHMUtO/7ekB/K0nNsLCylelJh8vIS8s3nc2r2pVRwdPpdhoWgJz7EO1LdYm0dzz9bIIcXwQRfdS1fOao+hTrZUj7hDY7VOmUjASW/5JcT07EuEdDg8odNrv7edCRda4vu/txgwtjfB6nQJD2aC0g8y3G2RNjvpmH85i4UjAKBd2IHrAkyexECImCOBU2E8d2cW6OfpQ47qvDcdIJyiGtow/g1mbauEjS3951gNQMI2G6/fTFImd9SV+ukoooQBub+Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MRzFwKDxbytgN/IFN6ASSQRuMy9GlT/FZ6XzgKCVyrs=;
 b=T4zcr0Q431dmrgqxy2UpdI9PDOYOdk2069qJDdRFhy35lt0TwUMHo/ruGry/r7L7OteE56k7HyQpb0U/8kZEtafCaJ0dAwRumaxR/pYtBZMUljfwMu4ncsWMkvIWJHbIuRDlaZy8ic0PQYICOinzKsgACX4ZsFPYe64A5rAwmiennvf0X7Azw4JktXHKmMapl0oNaysynCnJ3QMIIGjyScRY4/crZbbD7miVLSLd1pXt6bajHty7O42GokL4a4h2AX4BTetZBEFAonL9nWm5s0vcr13iR2ZE4iKvp9+EMwLxjZAgKUaxMwEVz1ovHtZ25tBsyiCRjcn3Tkd8aL5KGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by PH3PPFC852EF225.namprd11.prod.outlook.com (2603:10b6:518:1::d4c) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.6; Wed, 14 Jan
 2026 07:32:22 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::f997:762f:f079:134f]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::f997:762f:f079:134f%5]) with mapi id 15.20.9520.003; Wed, 14 Jan 2026
 07:32:22 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, "Will
 Deacon" <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, "Jason
 Gunthorpe" <jgg@nvidia.com>
CC: Dmytro Maluka <dmaluka@chromium.org>, Samiullah Khawaja
	<skhawaja@google.com>, "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 2/3] iommu/vt-d: Clear Present bit before tearing down
 PASID entry
Thread-Topic: [PATCH 2/3] iommu/vt-d: Clear Present bit before tearing down
 PASID entry
Thread-Index: AQHchDk99dS8zYs1cUWZyJOSO2CkmLVRRyEg
Date: Wed, 14 Jan 2026 07:32:22 +0000
Message-ID: <BN9PR11MB52765D0E2B4A39CA857900ED8C8FA@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20260113030052.977366-1-baolu.lu@linux.intel.com>
 <20260113030052.977366-3-baolu.lu@linux.intel.com>
In-Reply-To: <20260113030052.977366-3-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|PH3PPFC852EF225:EE_
x-ms-office365-filtering-correlation-id: a38a77c2-2e9e-47b4-85b8-08de533f0e99
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?dHlxN2NpOU41YlJVNEVBY2V3M2s1ZGMzVVo3UElmaCtWRlpPZ1U5VytTN1V1?=
 =?utf-8?B?N0dTRjYwVFFaMXlhcG9pNFlMdUVjQ2lrdUt1aXpCTm1lbUpGVUdzQ2FOMEdI?=
 =?utf-8?B?TjhQc1MxazNtV0xHR09EeVZRYVhPbnNjQUNjNXd0VDkzL2FDRzdIMnVFY21j?=
 =?utf-8?B?dGtvOFFTLytFdk5OR0NiQUpPdG5SYzNnNzZpZVkwcWlCT21LSU55QnVLQXNO?=
 =?utf-8?B?U3k2c0dNdE1JaVZtL3VScW1pZ1RZVUtWZjUwNEZ2QU1EcmRiZFVCZ2FDTXkx?=
 =?utf-8?B?WkpuVGZlYUx6VmdodDVnb0FZcGcxZk5JY1M3bE5UblRRQngyNHpnN01yRys5?=
 =?utf-8?B?OXlnbnk4MTduYno4SlFMYzFGMHNwUngwM3VIekpqL1VOWElzTldwbEY1U2lk?=
 =?utf-8?B?UEJ3bU5zTHVaV0pydlVVS2Fud0lkRWpPR1FlcFhEOUptNDZpRTZaaG9Bek1i?=
 =?utf-8?B?VlZxVG5jd0VpUUk0S3h5eXhrcFQ1ejNxUThFbDh6ME5SNzVJTU9GQW4rZWVH?=
 =?utf-8?B?d0I1Z0JmT3VENjROSWZISGdJWGZiTDdsUFZHVWRYdVA1cnVxL2U1OFd0MmJY?=
 =?utf-8?B?WlN6ZE5rMUNxdHUvUzIxSU1PbVYyd1ZpOEZlRDJlYitqOER6OXhUMXpPNytp?=
 =?utf-8?B?cHhBL0U0OWVCc1J3SjgzRk80QzBhSzUyanhpU1FoS3l5eFV2SktYV2xPcklM?=
 =?utf-8?B?NUNnd2RDaXUwNVUyZTBMeVF1U2h5dTVOM1FrSUZsZlhDc3VDTTVWdnVtT1hs?=
 =?utf-8?B?QkZPL1IvcWNHTVRZT0wrK2VjVmowamt3MVo1R2w4T3hJK3UxNEdjRG1vZFZz?=
 =?utf-8?B?WWdhbitLenlOSTh1RS9aZEtCQmc5VXFTTlN6WXBzYWpydGRLMTdiWUpUUnl5?=
 =?utf-8?B?VXBNZlNLMFo3U0Y2WUVmODVBYmNQQVNzUTFHMlVMKzhzY0c5ZjlYN2twdkF0?=
 =?utf-8?B?bWRPOG1Mb0x1QkhEUk00UHNpK0F4ME9mUEZjQ1U5dHo2VXlqMFhwcWIxY3RM?=
 =?utf-8?B?VDBFWmNTK2RLcXoxRHFpYzRKbjAxRE80MXJzZVpTbnc0OGJGTHhOUW1nK3Ar?=
 =?utf-8?B?TVo2ZDZPOWZ4NjFKMkpEWis3dk9tMDQvVzUvQ0Q3dHZhV0c4SFVHUFNtV0I1?=
 =?utf-8?B?bnFUOEsyTjlnSlU4TjgyV2Z6RWI1TGs2amJUczcwVFBWcHU5VU9WQ25wYmlt?=
 =?utf-8?B?Ti9YVnBteWd5YjZDK05zUEhhMUdOcHZKRmNGYXFDSzJSdmZGd1kyWGhKVUc5?=
 =?utf-8?B?L284T3F0T1NRaGhZdG1SKzJWSUxHNVlTSzRWMmRWc3lZR2Q1U04vWjRaQzJJ?=
 =?utf-8?B?Q21ST0tBdWNUaGtkUVQ2STdYMjBBUHA2RVYraUdDTXQ2M2RhWWRlbzVKT2o4?=
 =?utf-8?B?VzY1UHd5UWJNQkRnYiswUWNYcXZPSDdPR1dwY1kwU2lOQjFmRzRCZFFsaU1O?=
 =?utf-8?B?YVlyaXU3WFQzYWNLWC83dTluOHowQ2dQNEZtNC9IZ1VPT3lDZlViU1hXR0tI?=
 =?utf-8?B?T0JEYm5RUFVXT29vaXFQaFV1dGhHb3prcHBPOW54VjFSU0lpbzRUV0wvWnp6?=
 =?utf-8?B?OEFrQ2Qra3J1Sk0rOXVUVUdudzVrb2lZYW1TV3pWNlptUUpYM3JpSUVQTnZF?=
 =?utf-8?B?TDIzU0Q2RVpvaTI1UjJQc1ZSNmR6aEJST0E2bFl5S1d3RWpsc0M4RXFYb2lF?=
 =?utf-8?B?TE9OMUs3OWZNUnFYSnd3R29hdFlCZ3dlV0FnQ3VDWHhYdXVoeHdIQ3YyeWt2?=
 =?utf-8?B?aUhvNFpDcnE1dDJGNkxycjlUb1NIU0VOYTBwNGFCUGdHU3BLSzhpTjNicGh1?=
 =?utf-8?B?Mnd6V1BlWTdreGVjTXJqQkNXejdIbVVOczdrZkJwRVlFSVNPUnFXZVZDT1dM?=
 =?utf-8?B?Y2srYUQ2NGZad1JpWDg0ZHdGNDMweDRUZkhQa0ZsTVhabTUrdEoreTFKMVls?=
 =?utf-8?B?Rm9lL1QyeUcyV2F3L3BYM0EwL3d4dWgvMnFxd2taVlhVdENSZDNiaTROL2FR?=
 =?utf-8?B?TUFrOFVyZG5Vbk1kUnNTL29XR2V6VHdndTY3Z0Zub2lYYzduQTZPVEViMkxp?=
 =?utf-8?Q?yECCq5?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UVAxQTZtUUdsOGE0R1l0Y09kSXNTQjllZTFSalVULzc5VjUxcUFYeW1xSGxZ?=
 =?utf-8?B?bGtsM0E3L1FIL0NTZ0lOanlPRXpZWXVzd0RPWlJmcy9kakVtZ3pvbzZqT3d5?=
 =?utf-8?B?dThSVkMvT1VTTEdKT2w1WVI3dFVLR0h2c0hGd0ZjODkrWHB1dUx4RG1LbXRx?=
 =?utf-8?B?eGRieFJxL2N1TElDV3RZZUwxaCtvR0pLTEw3OXRvQzF1RVM5NDZqeU44OEh4?=
 =?utf-8?B?VGpEZWk2WWJSaEZ2R2NFWEVhWm11b0tRRm54Z01rRHhMUlFwUU1NMmhtUFZJ?=
 =?utf-8?B?SzdJN0ttendKTG8wb2ROSldrNGpJMHZhSnh1bWJISmFVdDZCSmhacUVxT1ZU?=
 =?utf-8?B?bjF4Ni9YbXhUbzhiU1lSb251MytFaTFsdmRMWFRKSjlMd01ubVhSaGxiZm5l?=
 =?utf-8?B?RVl0VFpjeTVNWnpQWkN0djlzVUp5TU1jeWdXRElwTkZ1U0Vlb2RSTlFRcUVK?=
 =?utf-8?B?RklFU2J2Nm5uR1Y4VzVYcGs4WStsaG9nRjNJOTJPdW9IbHNVSURkaHB3b3lG?=
 =?utf-8?B?SWxRZUtGcjlZbnhURDJ1RllyQlg4eUJ6em1NVmhObitUQzZublVlY2NteU5Y?=
 =?utf-8?B?dzE2TytYam5jWTNRVzlkeVZpTDVGT2pYbEhwdWVEdGlqTm43SjNOWVhvU2da?=
 =?utf-8?B?V3RrWDVoOXEwR1dWRFdpVXpZYjdmZXJRTkRoekgxNFg2dDl1ZUtXVERIdm96?=
 =?utf-8?B?RnNNdzg5V0U5Q1VFQjNNMWxPSm1FU3RlOHRhdjMycDY4L3hTWHdCZWpXczhk?=
 =?utf-8?B?Q3A3MnUyeEs4KzFDOXJ1V3NkTmNHa0ZBVng0WVRwMXFOU09YaGpJYXBaeXlF?=
 =?utf-8?B?WS8wei9rY3VLQVp2WFJUNXlFS1cySnNYaG84aXZVdTRVdVo3RnhyWXovVFk1?=
 =?utf-8?B?SGZxNGNIeXZKbWo5d2VQVUU4d2FxOVBDbm1YMm1RSWVXRzJvQnh3ZjcyRXRk?=
 =?utf-8?B?TEIwb1c1eHpVQ1Y3NU5nWjd6ZEs5dVpjK2xzZHZSWUlaY1BLd0tRZUlKcFA2?=
 =?utf-8?B?cmFzUHFZT0hMaldxRUgyRmVzTVZkamJsb2FQQTdtN3gxWkdOT08vR2NuRndP?=
 =?utf-8?B?TitmclZsb2NQL2NwVmxFN0ZMZFFvZFR4d0hyVUhNb20zRVFqdzZhbDJWa2tp?=
 =?utf-8?B?enZKRm12RVBBdUczcTBRWWpHL2FlM1BaRTdaUGRjYUVvOTBPSVpuS2U2VE5L?=
 =?utf-8?B?Sm50ekdKcG5pZzBDakg0UmVMNmYxcVIyU2RUYkJNZ3REYXp5NXR1WDYyVTNC?=
 =?utf-8?B?T2M4MFlmMzYyQjRNSjMzbmp3aVdza1BEZlFQNGp1enNkTjVOa0hUMXpzd2Fs?=
 =?utf-8?B?YTFGd2VKYnpERFh3WldjZlF2WTcvVHZOOFliaDZtK215VmR0Y2dtS3dPUlJU?=
 =?utf-8?B?OGpKajlFRnpUT3RVTnlGZkZzL0xWQ2FrRFhZVzhaUUhXc2QrS3VQY2tiZTRF?=
 =?utf-8?B?SjRJdnNwSUVITUpodloyaS9UTkNrMXhXZ2VCeWpGYUhoK2VNMThJclpvek5u?=
 =?utf-8?B?WVB4aVFZd3FNbFoyZ1VpN0pCeTRSS3NwQTFiejBVWWpBZjhFWVpVaXB0WTha?=
 =?utf-8?B?MGRGM3VHMW5BY05JVVU4RzJmcnVoS3ZkNG1PUmx0OHFxZ0RBb05CUGYzTjNT?=
 =?utf-8?B?bk92VjBUY25heFJLOXJMWXo4bUZWTEZNVnVNaUJKVE91Sjh4NFJhSTZ5bU1a?=
 =?utf-8?B?dmt3QkZtVGdHMXBqSFBoSkpKYUp2L05CZzI0a0RyU3kzSmFST0wzNzFxQkpq?=
 =?utf-8?B?dnhwVy9LYU5nSCtoNnovM0x2TENFMm84dnJINXRLby92M3lCcjJyT0xoT2ZH?=
 =?utf-8?B?VWF2cEpQQUw1N1d2Z2c3eDFIWDJMSVRvbkNlZHBzaVcyYlRWYTVKNFRjM3hZ?=
 =?utf-8?B?bitkd2ZxLzdXOUlTVDM4VFlYajJhdjRQZjl5L0Q5em1HcFRJZy9iM0hPbyth?=
 =?utf-8?B?WDRWTFB5bEswbG9lbGhvWUg2M0R1TmNzTnVQNUt5bTJhOEtsVmZDVk5Tb0Fr?=
 =?utf-8?B?THkvcDFadHZ4b1l1V2hZK0RQQTFaUm0yL3NWdFk0Ti9xWWFQd0RhTjdsYVIz?=
 =?utf-8?B?RjFtMlNQL2hUOUc0cWNkUTNnUHJmWkRXbm85QWIzaldkeU1ISytuOXVTM0pT?=
 =?utf-8?B?VmlkMEdnUUxZc2xOMmtha090ZGlIMWNZenREMEtiQzlidTlnYTBZZ290UFFX?=
 =?utf-8?B?WGxRSDZ0K1FSK0NBOWJlTjVWNjc5akhuZFJGYXhvUk9WMFdydnhZYldpVlJz?=
 =?utf-8?B?RnFKRWRFd0Z6R2hxdXRhdHNTMnhwdm1KVlFZNDlobjArMXVtZGFSY0JvbmZ5?=
 =?utf-8?B?R1VmSmhJSSs2S3gzUmJrZnVUYUtoSHVsbkh5L1F5NjZ0Y2lTZnFVQT09?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a38a77c2-2e9e-47b4-85b8-08de533f0e99
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jan 2026 07:32:22.5890
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BD29W1tDsYm7AMhQU9hVJOc3OIQGPFb4xtE2MYZGzM6E4fjhhHct5rJ9itJ9uNZjB2vQA9lAnkx6zs0AjVI/DA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPFC852EF225
X-OriginatorOrg: intel.com

PiBGcm9tOiBMdSBCYW9sdSA8YmFvbHUubHVAbGludXguaW50ZWwuY29tPg0KPiBTZW50OiBUdWVz
ZGF5LCBKYW51YXJ5IDEzLCAyMDI2IDExOjAxIEFNDQo+IA0KPiBUaGUgSW50ZWwgVlQtZCBTY2Fs
YWJsZSBNb2RlIFBBU0lEIHRhYmxlIGVudHJ5IGNvbnNpc3RzIG9mIDUxMiBiaXRzICg2NA0KPiBi
eXRlcykuIFdoZW4gdGVhcmluZyBkb3duIGFuIGVudHJ5LCB0aGUgY3VycmVudCBpbXBsZW1lbnRh
dGlvbiB6ZXJvcyB0aGUNCj4gZW50aXJlIDY0LWJ5dGUgc3RydWN0dXJlIGltbWVkaWF0ZWx5Lg0K
PiANCj4gSG93ZXZlciwgdGhlIElPTU1VIGhhcmR3YXJlIG1heSBmZXRjaCB0aGVzZSA2NCBieXRl
cyB1c2luZyBtdWx0aXBsZQ0KPiBpbnRlcm5hbCB0cmFuc2FjdGlvbnMgKGUuZy4sIGZvdXIgMTI4
LWJpdCBidXJzdHMpLiBJZiBhIGhhcmR3YXJlIGZldGNoDQo+IG9jY3VycyBzaW11bHRhbmVvdXNs
eSB3aXRoIHRoZSBDUFUgemVyb2luZyB0aGUgZW50cnksIHRoZSBoYXJkd2FyZSBjb3VsZA0KPiBv
YnNlcnZlIGEgInRvcm4iIGVudHJ5IOKAlCB3aGVyZSBzb21lIGNodW5rcyBhcmUgemVyb2VkIGFu
ZCBvdGhlcnMgc3RpbGwNCj4gY29udGFpbiBvbGQgZGF0YSDigJQgbGVhZGluZyB0byB1bnByZWRp
Y3RhYmxlIGJlaGF2aW9yIG9yIHNwdXJpb3VzIGZhdWx0cy4NCj4gDQo+IEZvbGxvdyB0aGUgIkd1
aWRhbmNlIHRvIFNvZnR3YXJlIGZvciBJbnZhbGlkYXRpb25zIiBpbiB0aGUgVlQtZCBzcGVjDQo+
IChTZWN0aW9uIDYuNS4zLjMpIGJ5IGltcGxlbWVudGluZyBhIHByb3BlciBvd25lcnNoaXAgaGFu
ZHNoYWtlOg0KPiANCj4gMS4gQ2xlYXIgb25seSB0aGUgJ1ByZXNlbnQnIChQKSBiaXQgb2YgdGhl
IFBBU0lEIGVudHJ5LiBUaGlzIHRlbGxzIHRoZQ0KPiAgICBoYXJkd2FyZSB0aGF0IHRoZSBlbnRy
eSBpcyBubyBsb25nZXIgdmFsaWQuDQo+IDIuIEV4ZWN1dGUgdGhlIHJlcXVpcmVkIGludmFsaWRh
dGlvbiBzZXF1ZW5jZSAoUEFTSUQgY2FjaGUsIElPVExCLCBhbmQNCj4gICAgRGV2aWNlLVRMQiBm
bHVzaCkgdG8gZW5zdXJlIHRoZSBoYXJkd2FyZSBoYXMgcmVsZWFzZWQgYWxsIGNhY2hlZA0KPiAg
ICByZWZlcmVuY2VzIHRvIHRoZSBlbnRyeS4NCj4gMy4gT25seSBhZnRlciB0aGUgZmx1c2hlcyBh
cmUgY29tcGxldGUsIHplcm8gb3V0IHRoZSByZW1haW5pbmcgZmllbGRzIG9mDQo+ICAgIHRoZSBQ
QVNJRCBlbnRyeS4NCj4gDQo+IEFkZGl0aW9uYWxseSwgYWRkIGFuIGV4cGxpY2l0IGNsZmx1c2gg
aW4gaW50ZWxfcGFzaWRfY2xlYXJfZW50cnkoKSB0bw0KPiBlbnN1cmUgdGhhdCB0aGUgY2xlYXJl
ZCBlbnRyeSBpcyB2aXNpYmxlIHRvIHRoZSBJT01NVSBvbiBzeXN0ZW1zIHdoZXJlDQo+IG1lbW9y
eSBjb2hlcmVuY3kgKGVjYXBfY29oZXJlbnQpIGlzIG5vdCBzdXBwb3J0ZWQuDQo+IA0KDQpiZXR0
ZXIgc3BsaXQgdGhlIGNsZmx1c2ggcGFydCBpbnRvIGEgc2VwYXJhdGUgcGF0Y2gNCg==
