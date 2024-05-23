Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B52C613B58E
	for <iommu@lists.linux.dev>; Thu, 23 May 2024 06:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716445417; cv=fail; b=FIEkWzcxoNKXmLRFQqM51iC7OpXLURQneh13c3F3uXg369ItUVbqcnGayrGlfN42+n/B0cLnUkKk6zq/Rstp2FmLhs+R6BTuHgyo1puio+m8ujmqXYPl6EkWYnukHuswZx0gD/+30FDIPXgMSJZVYJT2Dh3cvnsg62oAh4ytYjA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716445417; c=relaxed/simple;
	bh=tXVoGFXQM2Gx58lzOtQzZDVOeJOg112aCibDqBCBUc0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sTb3MDt6xqQNZhFmw1fHEczT8730KWjKDmtEZ2nrHVMos8B/7YoTzmaGdfMAwlAimLhf9pTIyrp8gZvDbm4w5EbNwLsrmLFkOzXo2wun1BlyjS2RgaMgvoqbK10GrFA6aG0b/deKgJKU5tlpr1qgXf771H3t0g0ARr6FAXMQ9fM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n/2ktVy1; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n/2ktVy1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716445416; x=1747981416;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=tXVoGFXQM2Gx58lzOtQzZDVOeJOg112aCibDqBCBUc0=;
  b=n/2ktVy1o0QdcVYfstbCPi4xY8OQsTJBC/R6lzYpVEiEmXljJqLM1ZPq
   V5bCcMKhY5qgtq0dtM6uUgRJalqwsalQ9Ahg1Ca+rJGh3w80gJRNwfhhP
   Yj6mQaA9mDkIqvMAN9noTaFVCwZd8inEpfvfCs3K/MK1Rf+421nF6ZsSw
   3OrcfFShJh2w46J4OqHg7wrG1U5fKs9PjvDpuX3NhHfMaUfWht/zSiSfh
   14dQDS/VGoPVtIq6It5hg2BTXnsonH/snDSPC6W4ShJL6VK9AHZverDk2
   2oCf7yGLxSOE5AIr4Oq/QUiFRXd5HH8SgmOfUuFNHht10oQn9k9tSDESs
   w==;
X-CSE-ConnectionGUID: yX1FY59rT3SXHeB97K8How==
X-CSE-MsgGUID: QqVYzWR2TWqNLtSQ9k/glw==
X-IronPort-AV: E=McAfee;i="6600,9927,11080"; a="16528400"
X-IronPort-AV: E=Sophos;i="6.08,181,1712646000"; 
   d="scan'208";a="16528400"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2024 23:23:35 -0700
X-CSE-ConnectionGUID: pJ7S66BdRW6M3o9e6rIloA==
X-CSE-MsgGUID: y7spsTAFR9u2xo4kvte6yg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,181,1712646000"; 
   d="scan'208";a="33448695"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 May 2024 23:23:35 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 22 May 2024 23:23:30 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 22 May 2024 23:23:03 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 22 May 2024 23:23:03 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.40) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 22 May 2024 23:22:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OKcZ32xW1MGinVMZYteglZ6VrcojTp0u349S8DNKaZGuBlq634uSWRzf6lXaCwlZY7uATkUVK/zgmWyWaaATe1O6PiaXBMAP4abEbBEGi/Mz5E6lmg9CezBuXkTTPxvEii3gCwJQqJyIy+s/4hvvfJag4wr1x6scYpmABHo9v5xtxDyTm6gh7UQKmwd3xN1EDKH3IwuBCdJ6iqoYBKZ/Op6PIiY81rUukpmOJoGy9W8Senb7wiBqP+4fETME4pcV+lHLPF1oxmWX54cdygAlj0LRAvOV5yAIKqctNcMJwz+foEBZsEEdLN4LoHHAjQh2CIsKXK39HGxqjmoTYMeKBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tXVoGFXQM2Gx58lzOtQzZDVOeJOg112aCibDqBCBUc0=;
 b=XjsARMVnW9chVVsQ3ILbZMZ3xv3qfRuyoeJ1mFYYEJgArRBAnLvmPnC1YqsLddEwU+4BmZ1PkfFX/ItV3v894+FTQbA6hcbnUaVOWToqSCYdCpiDqiTiquFUri7atxvaqCQ89wzLvq/0lI02X/q4ojBOeubPOPvK4SM1vh4FBaAtV7kUrMz/pSzFTKjsqSv25kM6+/zY+Ww7s6MspS9W84hhbizm6QK7brZLycK6e59/1bsEDOMX4kjG4cowouxLQtMWmTKwjcbuW3QwSU5Sc37PFks4phBOloSw/TyeSxvYUySORO5aXr9yMkjaX7N6mCJh0MjLyVbixK9gKXm4cQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by PH8PR11MB6973.namprd11.prod.outlook.com (2603:10b6:510:226::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.19; Thu, 23 May
 2024 06:22:33 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%5]) with mapi id 15.20.7611.016; Thu, 23 May 2024
 06:22:33 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Nicolin Chen <nicolinc@nvidia.com>
CC: Jason Gunthorpe <jgg@nvidia.com>, "will@kernel.org" <will@kernel.org>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>,
	"suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
	"joro@8bytes.org" <joro@8bytes.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-tegra@vger.kernel.org"
	<linux-tegra@vger.kernel.org>, "Liu, Yi L" <yi.l.liu@intel.com>,
	"eric.auger@redhat.com" <eric.auger@redhat.com>, "vasant.hegde@amd.com"
	<vasant.hegde@amd.com>, "jon.grimm@amd.com" <jon.grimm@amd.com>,
	"santosh.shukla@amd.com" <santosh.shukla@amd.com>, "Dhaval.Giani@amd.com"
	<Dhaval.Giani@amd.com>, "shameerali.kolothum.thodi@huawei.com"
	<shameerali.kolothum.thodi@huawei.com>
Subject: RE: [PATCH RFCv1 07/14] iommufd: Add viommu set/unset_dev_id ops
Thread-Topic: [PATCH RFCv1 07/14] iommufd: Add viommu set/unset_dev_id ops
Thread-Index: AQHajVVq/X0HjqCDvU+a/LkdwhCQ/LGT28sAgADojoCAD8kmgIAAB2yAgAABL2A=
Date: Thu, 23 May 2024 06:22:33 +0000
Message-ID: <BN9PR11MB5276DC89E13CCA16F9EC7D6D8CF42@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <cover.1712978212.git.nicolinc@nvidia.com>
 <6e57d7b5aa1705bdd547b1cd2aca93d3bf70dfa4.1712978212.git.nicolinc@nvidia.com>
 <ZkDWXnPW7CaX5TtA@nvidia.com> <ZkGZc5dvLigXcWib@nvidia.com>
 <BN9PR11MB52764728D4A8F54CCDE9B6C38CF42@BN9PR11MB5276.namprd11.prod.outlook.com>
 <Zk7dozLpy67ZY+RI@nvidia.com>
In-Reply-To: <Zk7dozLpy67ZY+RI@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|PH8PR11MB6973:EE_
x-ms-office365-filtering-correlation-id: 1afd4a80-06a0-4b19-bbca-08dc7af0bb8f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|7416005|366007|376005|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?RzY3dE41YlV2aGw3OHJqUWMxZ0hpRU1VTWJJaG9XREQrdUR4azVIOGQxODFK?=
 =?utf-8?B?Y1NoZXZtaFQrQ0ZhOHRQQWhtNnYzR2lSWERhUzJGOHpOQjlSQjNjSHdWQ2p2?=
 =?utf-8?B?TjZHc2U5RVNLNWNkdTdkZ1lHS3hxYklUcnFmNWtvT1ZsNGhpL2N4RXBzazlh?=
 =?utf-8?B?VmgrU1lKOE9ORGhBQzRGbldaTjNZd01NTjRkSlFvRnEyUURMeXl2VU9od2lq?=
 =?utf-8?B?WXJQOENlOUZ1NmdZQ2FrTUFYZk0zd3hHK3lSdUdrYWM0U3FFRm11QVo5Q2Fp?=
 =?utf-8?B?dlN5bDZSOFlqY3orSW9qTzNiMUMrMG9YSG9YNFUxeWJZamJ2bWVEUklmTjhi?=
 =?utf-8?B?bGhLYkNEa3VVNTJlWHZPUHptRnkyeEcwSVZUYnhLb3hFM1A1elVQL0RYK2VT?=
 =?utf-8?B?T2xPOUhwaUtveGh2QlErQUhQM1RIRHhwMkdFdG5QbTk3ckx1ayt0M25ZSHI5?=
 =?utf-8?B?WjJjdXNnVGNIUUJmcmVJTklxNEpZTW56WGEyZXZmRzNRNnpVZUY5MklVNi85?=
 =?utf-8?B?V2Q2aHc3d25VUUJoU2RtOUFOUFcxS1J4MHVmc25JQ3oxd2hvSTZmcXk5V1Bo?=
 =?utf-8?B?Wk8vZUdJSHJ0MmpQeGdydmlPZ2pBeCsrZnVPMFlPWkFpYU9yam4yaTVpTDU5?=
 =?utf-8?B?djJ0d1lxWnNUWmo2d09YSkNoeWVGNWFvZWhxcU1PN2ZPVXZPcmEwM0gvdndn?=
 =?utf-8?B?aG1OZEVoY0xNRmdyS0l4SDVmOExyaExYQTZYR2RMTGd2TCtJQVlCZytVWS9h?=
 =?utf-8?B?c1dDeE40QlRRWS94YzFGQXpJbmNGT1FVc2xISWhIdktBN3puT0R3OWhYTVd1?=
 =?utf-8?B?ejFORVBXSndOcUJhZDJ1YjRzak43Nk1LVTNlVHVXOXpaK3dPZENJQ3A5d1lz?=
 =?utf-8?B?d2REUjdRSlVGM0txYjdTeUxuYXBLeXN1MmZQQ2wramg4K2dudGVmNWV5NWJY?=
 =?utf-8?B?RHdjYk1ZUmZYZ2JmckVwR2pLSWYyc3d1WmhjMVo0YmM1Ky82Q0g1VTgxSUNJ?=
 =?utf-8?B?ajc4bW0raElQRVYwMzhLbWprbi8yb2p3cHhsNWMzQ20yczNQTStQNG5RZG9E?=
 =?utf-8?B?SjI5dWMxQW41RnQ2ODM2WU01Ynhzcmx5MlhrcjkwTkRhelR4T04zN1hPR0lL?=
 =?utf-8?B?UnBQV2FZaVl0MjZ1OTY5bGRVRHhGWVc0S1hnOVp6Mkt6dnc1SFBRY3F0Z0Nx?=
 =?utf-8?B?em5zcUJPcTZta1M4WGNLZjlnQTlKekpCTHdVWERHa3lYeXN6QndNc25ialpy?=
 =?utf-8?B?Q28vWlJLYkRwTXBiWVJ4MVVoU25ST3c1U1I3SlRWaENqcWE0aUlwZnhUSmFH?=
 =?utf-8?B?aXhOUTFoSUk1Mnp3RDFOVkJaRkxTWXF5Ri8veGFkWUFUWjNDUWJaVmN0ZUlE?=
 =?utf-8?B?b3JYSzdselZJaHdkZHRRdUhxaXNxWnpBZGJacmJBcUVrek9WWjNVUTRLdTFp?=
 =?utf-8?B?TElWMnoxQlJIYVR6dkNEWXlnRnhFNG9sRUw3S01KZ2xaUGplOE1VM2FrdFp5?=
 =?utf-8?B?RU9iaEE3RU9qZ1pPWGNwdVcva2N5ZTFUQkdibWFIdzhsc2FPK3JjWHh2WmpV?=
 =?utf-8?B?N2dCTTAxZG1Kdm44K2p3YjlsdzVOdGEwd2JWTXBhbk5uUSsxcTRBdk5nVTg2?=
 =?utf-8?B?aDZSU0hEV01jNUR6a0tiOGxURXkvSXV4TnpWcmpRTHJxNDdWcWx4RmFKSm5t?=
 =?utf-8?B?a3VHMURYUE5XZXpUQ0hmMzlRYUhBeTRNYTA5elVsTTIzL1BvNzZ1TVVSZmV1?=
 =?utf-8?B?bzlZNkJQVFNkajYvMTZ3Yys5VU5KSVlOaWticHdDWWhxVlk5aGxUZEpZcnA5?=
 =?utf-8?B?V1YxVmYyd3lOeUt2WDRsQT09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(366007)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZlV0UHkzM2xTbkRiNnUweFBpOHZicmpVdW5aWXVDWlpkZ3dRa3RtWDJsWlJU?=
 =?utf-8?B?WEx0Y25lcG9ScHN3UVU4Sm9EYVM4UkRoZmphVlZOTzhBT2t3UDRqS3oycUNE?=
 =?utf-8?B?MFljaks4aENUSXdQbzBnR21COXFieklxY2U5eENDb2MwdzZ5L1J6R3pmWHEv?=
 =?utf-8?B?Nk5wc1BxbVRiNkZEWnNNR2dHUEYwK2Q3SFdkTi9oVS8vRmV5YnVMZnRwOTRX?=
 =?utf-8?B?YWZwUHpqL3J4enRXSHRuWStlMWR0Z3dMdUJwYlJDdHUwajVYL0tHSVRCenlV?=
 =?utf-8?B?UDdHNTM5bjNVYkZKaW9VNlowT3Qrb2J0TVZ5NlJxcXd4OFE5Z0o0T2xLRkpI?=
 =?utf-8?B?T0FoNjZNTTRKbmtvNG9QU0t2bkJvTHUxejN6NkxYOURQWmozTG9qbEpmQVhW?=
 =?utf-8?B?Vlo0OFpPbXAwcVNvbXdtdm9hOFNqK3VmbVZEVTAyMUpvdGRSRU9PYmNWa0Za?=
 =?utf-8?B?YUZaaHVlMXZIc203cmVGN2tUOWJJSlM3NzRLM2ttbytoS2FEYmRTMlVGWDUv?=
 =?utf-8?B?Y092RndwVWNRLzdXUndjVlBva292MmM4WU9SU3h2WFpRSEhtWXJEUFJMdTRy?=
 =?utf-8?B?R1VNb294RmQ1RjBValByS0huSnZIaU9zRmorbjJKamZPb0x4VHhMQy9aK0dS?=
 =?utf-8?B?LzlhMXlXdTZadnZZK09PWndnSm1SOElYSVhrTE1FRWVTVnp3RUUxTFNhR1Uy?=
 =?utf-8?B?RTY1RVJGVGhRd0xRcXB0c0dyS2dOZ0RvaVFpdkdMczBqK1Y0ZEhXQWUxdjVY?=
 =?utf-8?B?ZWl6RGNZM2ViWjBYelNrOHFvbzdhSmluNGxOYTUxcXl6dGR3dXJQZjZ3RjZU?=
 =?utf-8?B?ZnNLNDRTRVMrWWkwMURGRXl0MzgwaDVWYTdiZ2Y4M2dUUXFRdGsrRkFkVUNh?=
 =?utf-8?B?QVpMWHpvd3psMXZwcmFkZk5Wb2lVWVFFaXdkNjV2TkIyRCt2WGhzUUhzbUpz?=
 =?utf-8?B?K09IbUpUUDY5bTVFdGhlZGhhaXE2ME5tUng5TFhGcUZJcEkwdG1SSjIxSDhx?=
 =?utf-8?B?cUNhaHJCdThwT0U3dEdTZ0pyNVlFK3RLNTNhUzY5SGxVajNaSVdwWUdNVVc5?=
 =?utf-8?B?eXYzazVna3IyN1RzVlh4ZHhzeEpVeEFua2JNblluMkdVbzl2M2oxNFhJYUo3?=
 =?utf-8?B?M3BjM2pVVlQ2MVVORGJxTzNhekxMSEZKbEhGWVVSQVFzRDJpdHpYOFVvSWVh?=
 =?utf-8?B?dXJtUmJqam52bHI0bmo5MkdRcGQwc2d2clA3NUFPU1VRM1U2aFZQcEE0NEUv?=
 =?utf-8?B?TWs1T0hnUjQ3UmNBMlZudFRDVWNjQkhmTDcvQ0dvWGZ3WGlKOUJwbkw3dlpk?=
 =?utf-8?B?dGlvaERjNDEvMlJ2cTVWU0p4Y0xsWDhNdjJIdnRrdGFCNEdpc3JFN0hOeXQ2?=
 =?utf-8?B?Q2YzOHhiVE5DUUpPa09EL2VLQjA2SjlpeG5YUkZ2eUZQT3BvWGU1bGRJUTdF?=
 =?utf-8?B?b0ZlbSswY2xNdnY1WG5MZisraFFDblpJWXNZSXJQb1dqekJtbW5pSXZWWmoz?=
 =?utf-8?B?THJQYzRTd1hqd2lLbmJveWhqN3FIbDBCSDFrWTlibDJ2cERkV3lGRElVWjg3?=
 =?utf-8?B?NWtaWU9QM0pwbDBRMDgwTGpXTG12K21odUlzalhDd3hVSmVKSGlpdm8vK1dz?=
 =?utf-8?B?ZUlsUmJkbkRWVko3bFlHYnlQMXhEL0svODB2V0lyQXlQVGkvZTZyYnhHK08r?=
 =?utf-8?B?QjJ6eDkwTVBKT1dPNjlNSVIzNDVTRUlHU1lFVW82MDUwMitvU1ZNUlRFOW5P?=
 =?utf-8?B?S2x0YXgxRmxEbE5LTjlSSWxMZGJVMVVmQ3RWL1dUUzJLYkZraTVnMiszQzdF?=
 =?utf-8?B?VHVSUjVnangrb0Z2dkcvbm5JWnNnT29rMERINC9GbFIrUFBQdlBhZURQMUtL?=
 =?utf-8?B?TDBPdWVic01ORCtoUnFLdVRON05WTE1ubmdhM3FOVmhENjY3ZGZPWDZ2SDJo?=
 =?utf-8?B?dk5jMUxZdEJwUG1hZWs2bHRXYS9qY3liTWZOc0F5czhRN2JHTXcwRDhvV2Zy?=
 =?utf-8?B?Y0dDaEMrS3I5c1RwRlNNQmprVlZmMGVMeDhRbFBaYVQzaHEyRXQ1MG5Fd0FE?=
 =?utf-8?B?ekluODdDQlpUQWl2MlBOVmlLZmJoWjVsaGg1TWI4VXZpbHJFWGwwVUE0Q1FK?=
 =?utf-8?Q?Kxez5nq4T9vm49OLqoQIdrm4W?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 1afd4a80-06a0-4b19-bbca-08dc7af0bb8f
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 May 2024 06:22:33.6676
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SW5L1qLFMX5gwKKFJeuxG/rlM/T5wzKbiktdCQHKmCIGlQNoMbeE2GXBcfa2iQHHWH0SY/Uaqs/pIimbfgqtUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6973
X-OriginatorOrg: intel.com

PiBGcm9tOiBOaWNvbGluIENoZW4gPG5pY29saW5jQG52aWRpYS5jb20+DQo+IFNlbnQ6IFRodXJz
ZGF5LCBNYXkgMjMsIDIwMjQgMjoxMCBQTQ0KPiANCj4gT24gVGh1LCBNYXkgMjMsIDIwMjQgYXQg
MDU6NDQ6NDBBTSArMDAwMCwgVGlhbiwgS2V2aW4gd3JvdGU6DQo+ID4gPiBGcm9tOiBOaWNvbGlu
IENoZW4gPG5pY29saW5jQG52aWRpYS5jb20+DQo+ID4gPiBTZW50OiBNb25kYXksIE1heSAxMywg
MjAyNCAxMjozOSBQTQ0KPiA+ID4NCj4gPiA+IE9uIFN1biwgTWF5IDEyLCAyMDI0IGF0IDExOjQ2
OjU0QU0gLTAzMDAsIEphc29uIEd1bnRob3JwZSB3cm90ZToNCj4gPiA+ID4gT24gRnJpLCBBcHIg
MTIsIDIwMjQgYXQgMDg6NDc6MDRQTSAtMDcwMCwgTmljb2xpbiBDaGVuIHdyb3RlOg0KPiA+ID4g
PiA+IEFkZCBhIHBhaXIgb2Ygb3BzIHRvIHNldCBhbmQgdW5ldCBkZXZpY2UncyB2aXJ0dWFsIElE
IHRoYXQgYmVsb25ncyB0bw0KPiA+ID4gPiA+IGEgdmlvbW11IG9iamVjdC4gVGhleSB3aWxsIGJl
IHVzZWQsIGluIHRoZSBmb2xsb3dpbmcgcGF0Y2gsIGJ5DQo+IGlvbW11ZmQNCj4gPiA+ID4gPiB0
byBzdXBwb3J0IHNvbWUgSFctYWNjZWxlcmF0aW9uIGZlYXR1cmUgZnJvbSB0aGUgaG9zdCBsZXZl
bC4NCj4gPiA+ID4gPg0KPiA+ID4gPiA+IEZvciBpbnN0YW5jZSwgZXZlcnkgZGV2aWNlIGJlaGlu
ZCBhbiBBUk0gU01NVSBoYXMgYSBTdHJlYW0gSUQuIFRoZQ0KPiBJRA0KPiA+ID4gPiA+IGlzIHVz
ZWQgYnkgQVRDIGludmFsaWRhdGlvbiBjb21tYW5kcyBzbyBTTU1VIEhXIGNhbiBkaXJlY3QNCj4g
PiA+IGludmFsaWRhdGlvbg0KPiA+ID4gPiA+IHJlcXVlc3RzIHRvIHRoZSBjb3JyZXNwb25kaW5n
IFBDSSBkZXZpY2Ugd2hlcmUgdGhlIElEIGJlbG9uZ3MgdG8uIEluIGENCj4gPiA+ID4gPiB2aXJ0
dWFsaXphdGlvbiB1c2UgY2FzZSwgYSBwYXNzdGhyb3VnaGVkIGRldmljZSBpbiB0aGUgVk0gd2ls
bCBoYXZlIGENCj4gPiA+ID4gPiB2aXJ0dWFpbCBTdHJlYW0gSUQsIHVzZWQgYnkgdGhlIEFUQyBp
bnZhbGlkYXRpb24gY29tbWFuZHMgaW4gdGhlDQo+IGd1ZXN0DQo+ID4gPiA+ID4gc3lzdGVtLiBO
VklESUEncyBDTURRViBleHRlbnNpb24gZm9yIFNNTVV2MyBwcm92aWRlcyBhIHYtDQo+IGludGVy
ZmFjZQ0KPiA+ID4gdG8NCj4gPiA+ID4gPiBleGVjdXRlIHRoZSBndWVzdC1sZXZlbCBBVEMgaW52
YWxpZGF0aW9uIGNvbW1hbmRzIGRpcmVjdGx5LCB5ZXQgbmVlZHMNCj4gPiA+ID4gPiB0aGUgSFcg
dG8gYmUgYXdhcmUgb2YgaXRzIHZpcnR1YWwgU3RyZWFtIElEIHNvIGl0IGNhbiByZXBsYWNlIHdp
dGggaXRzDQo+ID4gPiA+ID4gcGh5c2ljYWwgU3RyZWFtIElELg0KPiA+ID4gPg0KPiA+ID4gPiBJ
IGltYWdpbmUgdXNpbmcgdGhpcyBhcyB3ZWxsIGZvciB0aGUgQVRDIGludmFsaWRhdGlvbiBjb21t
YW5kcy4gSXQNCj4gPiA+ID4gd291bGQgYmUgdmVyeSBlYXN5IGFuZCBzaW1wbGlmeWluZyBpZiB0
aGUgY29tbWFuZCBmaXh1cCBqdXN0IGV4dHJhY3RlZA0KPiA+ID4gPiB0aGUgdlNJRCBmcm9tIHRo
ZSBBVEMgaW52YWxpZGF0aW9uIGFuZCB1c2VkIGFuIHhhcnJheSB0byB0dXJuIGl0IGludG8NCj4g
PiA+ID4gYSBwU0lEIGFuZCB0aGVuIHB1c2hlZCB0aGUgcmVzdWx0aW5nIGNvbW1hbmQuDQo+ID4g
Pg0KPiA+ID4gWW91IG1lYW4gdGhlIG5lc3RlZCBTTU1VIHNlcmllcyByaWdodD8gQWN0dWFsbHkg
dGhlIHNldF9kZXZfaWQNCj4gPiA+IGlvY3RsIHdhcyBhIHBhcnQgb2YgdGhhdCB1bnRpbCB3ZSB3
YW50ZWQgdG8gdHJ5IERFVl9JTlZBTElEQVRFLg0KPiA+ID4NCj4gPiA+IFNvIGFnYWluLCB5ZXMs
IGl0IG1ha2VzIHNlbnNlIHRvIG1lIHRoYXQgd2UgbW92ZSB2aW9tbXUgYW5kIHRoZQ0KPiA+ID4g
c2V0X2Rldl9pZCB0byB0aGUgbmVzdGVkIHNlcmllcywgYW5kIHRoZW4gZHJvcCBERVZfSU5WQUxJ
REFURS4NCj4gPg0KPiA+IEknbSByaWdodCBhYm91dCB0byBhc2sgaG93IHRoZSBuZXN0aW5nIHNl
cmllcyBpcyBnb2luZy4gUGVyIGVhcmxpZXINCj4gPiBkaXNjdXNzaW9uIGlpcmMgdGhlIG5lc3Rp
bmcgc2VyaWVzIHdpbGwgZ28gaW4gYmVmb3JlIFZDTURRPw0KPiANCj4gWWVzLiBJdCBzdGlsbCBz
aG91bGQuIFlldCB3ZSBlbmRlZCB1cCB3aXRoIGFkZGluZyBWSU9NTVUgdG8gdGhlDQo+IG5lc3Rl
ZCBTTU1VIHNlcmllcyB0b28uIEEgc2hhcmVkIFMyIGRvbWFpbi9od3B0IGlzbid0IGV4Y2x1c2l2
ZQ0KPiBmb3IgVkNNRFEgdXNlIGNhc2UgYnV0IGFsc28gZm9yIHJlZ3VsYXIgbmVzdGluZyBvbiBh
IG11bHRpLVNNTVUNCj4gc2V0dXAuIFNvLCBWSU9NTVUgdHVybnMgb3V0IHRvIGJlIHRoZSBiZXN0
IG9iamVjdCB0aGF0IHdlIGhhdmUNCj4gYXQgdGhpcyBtb21lbnQgdG8gaG9sZCBpbmRpdmlkdWFs
IFZNSURzIGZvciBkaWZmZXJlbnQgcGh5c2ljYWwNCj4gU01NVXMgc2hhcmluZyBhIHNpbmdsZSBT
MiBkb21haW4uIEl0cyB2aXJ0dWFsIGRldmljZSBJRCBsb29rdXANCj4gZmVhdHVyZSBjYW4gYWxz
byBhbGxvdyB1cyB0byBmb3JnZXQgYWJvdXQgREVWX0lOVkFMSURBVEUgaW9jdGwNCj4gZm9yIG5v
dy4NCg0KWWVhaCwgdGhhdCBtYWtlcyBzZW5zZS4gYnR3IGl0J3MgcHJvYmFibHkgaGVscGZ1bCB0
byBmdXR1cmUgcmV2aWV3cw0KaWYgeW91IGNhbiB0cnkgdG8gaW5jbHVkZSBtb3JlIGV4cGxhbmF0
aW9ucyBhYm91dCB0aGUgZGVzaWduDQp0cmFkZW9mZiBiYXNlZCBvbiB0aG9zZSBkaXNjdXNzaW9u
cy4gU29tZWhvdyBpdCdzIG5vdCBlYXN5IGZvciBtZQ0KdG8gY2F0Y2ggdXAgd2l0aCB0aG9zZSBk
aXNjdXNzaW9ucyBiZWluZyBsYWNraW5nIG9mIG1hbnkgY29udGV4dHMNCmhlcmUuIPCfmIoNCg0K
PiANCj4gSmFzb24gbGlzdGVkIGFsbCB0aGUgdGFza3MgYWhlYWQgaW4gdGhpcyB0aHJlYWQgdG9v
LCB1c2luZyBTTU1VDQo+IGFzIGFuIGV4YW1wbGU6DQo+ID4gU28gd2UgaGF2ZSB0aGlzIHN0dWZm
IHN0aWxsIG9wZW46DQo+ID4gIC0gSWRlbnRpdHkgU1RFIHdpdGggUEFTSUQgKHBhcnQgMmIpDQo+
ID4gIC0gSU9NTVVfR0VUX0hXX0lORk8gKHBhcnQgMykNCj4gPiAgLSBJT01NVV9IV1BUX0FMTE9D
X05FU1RfUEFSRU5UIChwYXJ0IDMpDQo+ID4gIC0gSU9NTVVfSFdQVF9EQVRBX0FSTV9TTU1VVjMg
KHBhcnQgMykNCj4gPiAgLSBJT01NVV9IV1BUX0lOVkFMSURBVEVfREFUQV9BUk1fU01NVVYzDQo+
ID4gIC0gVklPTU1VX0FMTE9DLCBWSU9NTVVfQVRUQUNIDQo+ID4gIC0gVklPTU1VX0lOVkFMSURB
VEUNCj4gDQo+IEJ5IHRoaXMgc2VyaWVzIG5lc3Rpbmcgc2V0dXAgaXMgZG9uZS4gV2UgbmVlZCBC
YW9sdSdzIHNvbHV0aW9uDQo+IG9yIFZRVUVVRSBmb3IgZmF1bHQgcmVwb3J0aW5nIGFmdGVyIHRo
YXQuDQo+IA0KDQp0aGlzIGlzIGEgY2xlYXIgcGxhbi4NCg==
