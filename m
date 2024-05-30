Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25E261C68F
	for <iommu@lists.linux.dev>; Thu, 30 May 2024 03:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717038311; cv=fail; b=BaD4AKSjIm6LF08loLo8COtSnXrtEV9EglvXUO40bbnbTqLXb1ygrC6ynYiNhueONmwqttvcZkFE1Fe8lCnt50N0aDrB1WOOXbNCnGa3o7FgrOUxuR2/SJm9QiwCJwAyMqMUGzti1t/NWIu1NqitUa1/EJXA3zmQjKX1w25RIBU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717038311; c=relaxed/simple;
	bh=5ScWqFPuzJwdJkvMYqGjHsQfp1hssn5q9cvrn78ddPY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KQbPMVZoBB9ELUbozemn9udUaG9IHh5//2DB7HmeRfElKIHIDfzsLSRxDyY7pifvlj5kjt9R2isFvyb/3p0jE+ZCtO1XIWNwmLfcBsQx0BOu1FDNU7YOXAi1vKfUlmsRkdwB1VN2I6ssmXhqYOyLpRqW1V7YH+RWluSmnV9HSrs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N4VHl7mw; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N4VHl7mw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717038310; x=1748574310;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=5ScWqFPuzJwdJkvMYqGjHsQfp1hssn5q9cvrn78ddPY=;
  b=N4VHl7mwjOwYmLyeXuv8M6XTkEhHYr8fFpA1eNKdlyrgJq37Z1aiXcU0
   UCtRWC7Ym7dXDULfH44RtVZE3/+Lxe//DudSaGEs4s8um+wCQuQz+Gki6
   G6hPfaAImm4ApK5+N4D9JKcR9ZEvArywhgWZKVdqjdCnSsypBCMJHJdYK
   0zwQ8bHcbJdwJNtNTc9Lt+RH+jhYc+hJctkpkDwda2pBqSwtHMZeemcRn
   6m67FHPObBq4ZaJQ1PcgZ7KY1TLK6ShpfWYHIMe07tQb5NWJdyeWECqmx
   kBg2fZYGz8M+sZo5kH8e5lC8dGYhGXvBbeLH57KtyyQ0A9I1t3gbpU8Ey
   g==;
X-CSE-ConnectionGUID: wZGtR/OCT2CYeXNPQTXqDA==
X-CSE-MsgGUID: JsvOvRZ1QdCLz65rahA4PQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11087"; a="24145097"
X-IronPort-AV: E=Sophos;i="6.08,199,1712646000"; 
   d="scan'208";a="24145097"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2024 20:05:09 -0700
X-CSE-ConnectionGUID: p6LlmD/1Q66w+m1ieFLrxQ==
X-CSE-MsgGUID: qSaKXmsVT9O+ujHDcqDmSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,199,1712646000"; 
   d="scan'208";a="66518181"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 May 2024 20:05:09 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 29 May 2024 20:05:08 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 29 May 2024 20:05:08 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 29 May 2024 20:05:08 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 29 May 2024 20:05:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l20YPSj1zM5mM2ZO7iuXiKevmTTh2M3F4RXyZ5qZo8r+B/KFiAsuzZPmSjoW1V7TwiyAmAlWlZVpL1fz1KS4bsETrTz/MMUiXYPhkAYAnS9Mks0IMX1oQZgRUOqGPK873Lsp2+EgrldeRZ6fN0cGxKyCdZSZgJ/AkJUlQ7U9q+F78HoUbHbCmAkvFuRfDxPeTqZAv9A5syWTbF+GbmAogci3DJMId11ct2Lj56lNbdbOe1UH9P64qQQ1r/Y/Q5hfNh0fIbJSzUE4Gp+NE+P7Ix8pBVuhhJjurR4vXiUKyAbX5hgaUdeJQFafzk/CqzO00V1+AAdxdMQ4A/6x4Hc3vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5ScWqFPuzJwdJkvMYqGjHsQfp1hssn5q9cvrn78ddPY=;
 b=Ji8zpMQ1YxDJ30d+3rkgan+xhRRZqDbBjlAksapIiyV5R65ZkUN1Pkt6PKu0KzeUjyhdGxdHxy0wfmIjZL1H+Wz0oOVg2R+gkkXb2h7HsLtUw7B7jTE14QRfph6MFclVrhb0gWV4dcb9LPCwTdVo5yJV34ro75hXtglrkjTeHNLvm0/o/Ki85e4v8xhXo2ouXwfF3+lwKbULN+D3unEvQJl/nJb2cdyMKbSL7cXBMeIZQ/ykxPx1wa+2BB6MxGu96INCZMyMCEepW/zd/eMoxRKOqYMnFVuVj/PEABB/uwgJwzlsfz2wRxX6k+svB1zlaEIlNNjtiiuK+SizAESDwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by CO1PR11MB5122.namprd11.prod.outlook.com (2603:10b6:303:95::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.17; Thu, 30 May
 2024 03:05:05 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%5]) with mapi id 15.20.7633.018; Thu, 30 May 2024
 03:05:05 +0000
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
Subject: RE: [PATCH RFCv1 08/14] iommufd: Add IOMMU_VIOMMU_SET_DEV_ID ioctl
Thread-Topic: [PATCH RFCv1 08/14] iommufd: Add IOMMU_VIOMMU_SET_DEV_ID ioctl
Thread-Index: AQHajVVl26WkVBqVE0qDV+tml8yTY7Gkmr6AgAGEQoCAABbGEIAAaX4AgAPpupCAAtXxAIAAbUsAgAAHhACAAV8OUIAAC42AgAAecdA=
Date: Thu, 30 May 2024 03:05:05 +0000
Message-ID: <BN9PR11MB5276DC3F8F085FE0E699D9448CF32@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <c97a98a72ee3498c587e5898d6b899553ccd9b27.1712978212.git.nicolinc@nvidia.com>
 <BN9PR11MB5276A897A5386DFAC9A35F9D8CF42@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZlAoN3s96HL7ROth@nvidia.com>
 <BN9PR11MB52762A0BC67B64D4171480C78CF52@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20240524131912.GT20229@nvidia.com>
 <BN9PR11MB5276BBD592021507C3A0EBB38CF02@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZlY886FT3HHLC8Cf@nvidia.com>
 <BN9PR11MB52762EA9B444DA71F551C3868CF22@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZlafEktUu5znDsNt@Asurada-Nvidia>
 <BN9PR11MB5276AC43120376A2502D3D148CF32@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZlfPPwsnY6P4SoGF@Asurada-Nvidia>
In-Reply-To: <ZlfPPwsnY6P4SoGF@Asurada-Nvidia>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|CO1PR11MB5122:EE_
x-ms-office365-filtering-correlation-id: 7945e87a-25e5-4dbe-898d-08dc80554e65
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|7416005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?azdUUDQ0NHFuK2VEQ2w1ZWF0Z3lNcjhLT3Y5WjEwMU5FVUM1V0JqeHY3Q003?=
 =?utf-8?B?eUVrb0hYTVQ4NVlJR3VMNi84RksvVXNGcVFDL0E1MUg0RDA0RVZLZ04zeXcw?=
 =?utf-8?B?SENSNTdvOTdRREFQNk5CdFFjc2h6RXE2NEl1OGJnY2RPZ1lFbFNCMjVWZjln?=
 =?utf-8?B?emVLVUtXT2t5eWRNcitNSmNxRjFuOUJCSEdRN1d1cUdpbTNpRnlWRm05d3dr?=
 =?utf-8?B?Q3hnT3JzRGoxenc1Ym5oc1F3NTR3anR5OXZlTUtIYTZyU2JMNUw1NkZKNWdo?=
 =?utf-8?B?SVh6VTVUOE9VWkFzSmplSFcrNkwwQWU5K1BXbEFVMlF3ZStkY2wxT2F0L0xi?=
 =?utf-8?B?SzlmTk9reUhzSGZQM24zQmNyZmxsa0REa1NsWnQxR0tKaXJ1RFdWZkp5dWZ0?=
 =?utf-8?B?YTdDcTFIUmxQNkY1UlIxOFp0ak1MeDNWcktIcjJ2OHJ1OG9sc1R5YUlGcmtI?=
 =?utf-8?B?NGVrcllBYVNhZENiQ1p4dkI2U3BneTZVaG1oYWEwSVkrZjBxRHdLVVVkTTZj?=
 =?utf-8?B?OXJmWUhjSGlwTnZiajlXMUNZWGM1Q1B3bGFyRmlBT2xIK1YwUmRYdVUzeWJx?=
 =?utf-8?B?ZHh5VkVuRERDOHFQRzdvRkd3Q3dFVjJkR0RLVWlnbE51L0QrY280Myt3SGx4?=
 =?utf-8?B?Q09PZUVhY3VMY3A1d2pIS2pKcW5QcjRvS1VjQmgrZ0o5dlp1akg5blNBR1h1?=
 =?utf-8?B?VWJ3NnQxTWN0cEdLZnNKUVFDRVEzUzhKTUY2V1FBQXphaWthOUJGR0Frd3FP?=
 =?utf-8?B?cWF1TEhFdG02S1lOZ0puUktiY2hNVVR4SEJlZUlNNTlzcGtiVVNYTmNndzR6?=
 =?utf-8?B?MldxKzNYZkFSTEpyRG1temcwWjJPSTBGVmp0amNkaTd4Y0R1M2t4NmM5Ynpx?=
 =?utf-8?B?T1p4bEJjc3I1NjBCQnp6bGQ5YUNBRXhzZHFXMy9ETHMwWEZEbmsrUGtLRFVU?=
 =?utf-8?B?SkxXL1A1QnZtZmc1L3FGU1UxYkRpZCtucjJVL20zZTJtOWxESkRaanBkNitk?=
 =?utf-8?B?c29FWWNNVVNORDRPam9acEx0empPT0cxUmpwMzBxYmVDQW9uYUE1ci9vWlVx?=
 =?utf-8?B?L0s0ZU1KdlJBcnk3aUlLWDdicEV4YmJsZElsTEpWMlg0R1BXWkEyTDh2OW1Y?=
 =?utf-8?B?QlozOWF1VFhMNmlMS3NZZFAyTmluMTBQakhBdDZKWXFnazJ4NzRXR0hqMTRN?=
 =?utf-8?B?ZW1lS0ZmWnh5Q1lwM3JkUkhWMXRNQVJ3TlZNRFc3SDJJY0pBalB3MTdNTkZx?=
 =?utf-8?B?eXNCSytmdVFzamtva0FEM0NzaHk0MmNpVksya3lKSmtPUnlOc3Y4eENkakRZ?=
 =?utf-8?B?MnN6Tm41bFJ1dm9WcVZYSyt4V096bWh6K1lJNExCaW9PRlFiL1R2cXVpTUY0?=
 =?utf-8?B?b2ZxM2prN0RlMzF1VStTd0FiTUs0QXdDUVZXWjdPYTgwK2VmeXhEWm0zWk4r?=
 =?utf-8?B?YWhCRW5TbXhsaXR6MTZxTUdDTHc5VWM3SVN6ZFFlZ3UyOVYxYnVyc0VRcy9m?=
 =?utf-8?B?WmJ0REJZNll0emw4TUg2WXE1MThOZXZvU0JRRDFubHFnbzJvc3I1TE1QQnFz?=
 =?utf-8?B?NHpuSUQyM3Q0V3Jva2FFT0RtQnRMUkdBK1Y4UlpCamlLMXYwY2wyVFk3Q2hm?=
 =?utf-8?B?a2JvYmhReWx4ckR1MHIrbGF0cHhZblhJRC90SEdIUjdHd2xqQnJFSGQyQ2Z2?=
 =?utf-8?B?b1YvbFhCRmVUTTJTdVpFMjdxeFYvMFJmRWM3SG4zdXIzU0MvV3d2eXdPVkNR?=
 =?utf-8?B?ZWQrMVh2RjZZTGJlZlZUcGU0dU9WS2h4b0dsSlU1c2dwNUN0TmRRZ2ZoLzR2?=
 =?utf-8?B?SC9aUldMbEVnSjMwODc0dz09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OTRLTUJ6MU9jT1NobFNGdW9jWXRrRDl4QWM3QWdoM1JnRWVDL01BazRvNEpV?=
 =?utf-8?B?T2N0TGlTNU5acDVjZ1VFRTBVOFVhdURWei9hUXhTKzJ4VklVMTcwbzJwbGdB?=
 =?utf-8?B?cmlhcE40Q3o0ckoxOG1oZ3hXckswbEowbG1KelhhWUF0d3lKU2RwTlY2aGhk?=
 =?utf-8?B?emk2Z2FRbmxuQzRYb2Zsa281c3VvbEUxMi9YNlA2V2lXZ3VXWkFQeTBWVG4r?=
 =?utf-8?B?WVFoY2l4TXRNOEg1YStyWExoRXQweklWL25mVGd3Ym9jYjQwK1RncHd4OGVm?=
 =?utf-8?B?NEN5SmRQRHdma3FTcFpNS0RYNVdheTVOeW9DcnpFMzgwbTN0U2pTem9LWDJm?=
 =?utf-8?B?bGJ4RmwvV3lUbWNRNVkwZmFZNmhvK01KZlVRbHkxQVQrc3FUSDZ0aFZWKzVi?=
 =?utf-8?B?TFZTQk1scW9OWm42cWIvamlOdXhNZHhZOTUxSEpFLytyeUFPZWpsWFBzUTZj?=
 =?utf-8?B?L05aTFQ3bndGSTFwTU5vekFhTnBGVEJkenN3N0ZFd1doMyszeUJPanA4R2Ey?=
 =?utf-8?B?L2Fnbjc1RDM3LytBNWpGdVhSMDJvT00wVlAxMjg3U3JGK2lmTGl1SDlwUy8v?=
 =?utf-8?B?SlVXdjNBakkyY2hpUFo0bGlqODlGcUxzS2J5OVJEcTB5SGJ3T29KRjQzcWNj?=
 =?utf-8?B?NmxUSWtJTlEwQkJYZ2xqZHBpTllTZURMa0Uvc25ybmMzMHgxUlFYaFU4WHlF?=
 =?utf-8?B?ODdjSWlIZERGOUVwcjREOFpINEkzOWM5blc3RDJqcEUrbmd6RkNjWjRhT0ps?=
 =?utf-8?B?RXZZK25qZjc5cGZMbkg3aWc3RndQREp1VnlZY214Vm5IbHBDaXgwSThnN3lE?=
 =?utf-8?B?WTNOaGwxUlFaOGJwL1VMQWtrRk45K0tvYmdzZHlCK0FOR3QyTTR6dUZIek94?=
 =?utf-8?B?R05NWkwyU2VUTlNDQ2NPditpWWNqc21JalBzQlRxN1JHK1hkSXZGRzc2SW9p?=
 =?utf-8?B?L2FjYWU2S3ltbnlpQkJjWFVrY01wUVRHVXdCZW9OVDNsRUlzMGtCQTEzM01z?=
 =?utf-8?B?VjRxS0kvNjNndE1Jd2x5MGhXZVlURUtRN2RoNnZDNjQvVGxHakN6RWF4bWpS?=
 =?utf-8?B?T0p2VXl5cG5ONWpjS3hnREVpNFFyNC9BcDJCRThrQnV0UXozVjFEZmlYSjFJ?=
 =?utf-8?B?RFJHL2xKSkZTZ0hJQWpGR0NRMjBLY2tsdVB1dEJ5a0lhVDBkREpQRVV4SHF6?=
 =?utf-8?B?UFYycitHREVCYVY5RXJsY3l0MjR5TE41OXRpSlhadTdLMndyMkEzQ0tJZ1FI?=
 =?utf-8?B?R1dlMVFER2RSNWp2UzEwQldXMlF6MzB5Y2x2VWZsQVJBb2trTXRxZHJTV2Zl?=
 =?utf-8?B?REhqa1pvVHBLZnpHQXJZV2d4N3lWSFBlK1lqS1hoU2JCY2lYaVd2T0ZCS0M2?=
 =?utf-8?B?VkFmcXg2TjRxUzBKWS9tdjh5REY3TVA5NExuWXpkNEJON0tFRXdZanlmc0Iy?=
 =?utf-8?B?L0lrR1Voclp4bnNNa3o2NmU0bXpGQUcvdTJoYmhTcnhkV05CSkp6RVdsZTdM?=
 =?utf-8?B?VTFBcXNGdUJwa0tPdXBNLzg0ZGlRK2d3L0R3ekhRV1FDNDBwN1AzSXYwaUs1?=
 =?utf-8?B?UmxLb2xSckNlZ0JiNDVMVTBTODd3WnhWL3NhOGJrcEw4N3hnTk1PMUpRaGtS?=
 =?utf-8?B?Q2JhalcyUXgyYWtaVmNsRXlkckovOU9nTDBsVVc0aEg4dzJIQVdsQUpkTnRN?=
 =?utf-8?B?RWdTQjZXRjdxWk94MTBzcUNGVE1lVW05YkkyZzlTRG1vNnNRS0kwUjlsZHNZ?=
 =?utf-8?B?Mjc4LytUNkZsdVBsTGROV1RzTXRQeWNEalVEczY1WW9Zc0laNXM0NHBxNFBT?=
 =?utf-8?B?dGp0TU9IbUMxcFhnOG1JN0JvS1pWRUt1VGtsSTZRZFdReWF2SWZ1TVcwSXJN?=
 =?utf-8?B?cVkweXFSRXF4d3dHaXg4ZDYxY3FJSnZ1ZFdSc1dNQk1XcC82TGVubERhcUkx?=
 =?utf-8?B?WVRoMXE1UFhFdDhxVDBQQllrU082dm1lQVZyVVFIMGc3V2VUQ1VmK3ZKY2F2?=
 =?utf-8?B?aEIzcVk0UHNyWFNlajB5NjlMRmxKRWpRUUFqMzB1MlN5TXJKeVhEbG14NU8w?=
 =?utf-8?B?THRCUlFDaHp0dmRYajBPZi91OTV1UEFsblJLQ2JJOEdtMTlRMVJHV0FwWVpP?=
 =?utf-8?Q?mGRgKIsEk17GF6ayAcxQ7uHcS?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 7945e87a-25e5-4dbe-898d-08dc80554e65
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 May 2024 03:05:05.5359
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NR7ktFFBmzrNflEB1tNhw+QsKSMiCYZ+CsbVTsCyS28rCKHlBDSgF3lgLR1n111qjeq2FRR76V7qRDXE9n+zLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5122
X-OriginatorOrg: intel.com

PiBGcm9tOiBOaWNvbGluIENoZW4gPG5pY29saW5jQG52aWRpYS5jb20+DQo+IFNlbnQ6IFRodXJz
ZGF5LCBNYXkgMzAsIDIwMjQgODo1OSBBTQ0KPiANCj4gT24gVGh1LCBNYXkgMzAsIDIwMjQgYXQg
MTI6Mjg6NDNBTSArMDAwMCwgVGlhbiwgS2V2aW4gd3JvdGU6DQo+ID4gPiBGcm9tOiBOaWNvbGlu
IENoZW4gPG5pY29saW5jQG52aWRpYS5jb20+DQo+ID4gPiBTZW50OiBXZWRuZXNkYXksIE1heSAy
OSwgMjAyNCAxMToyMSBBTQ0KPiA+ID4gT24gV2VkLCBNYXkgMjksIDIwMjQgYXQgMDI6NTg6MTFB
TSArMDAwMCwgVGlhbiwgS2V2aW4gd3JvdGU6DQo+ID4gPiA+IE15IHF1ZXN0aW9uIGlzIHdoeSB0
aGF0IG9wdGlvbiBpcyBjaG9zZW4gaW5zdGVhZCBvZiBnb2luZyB3aXRoIDE6MQ0KPiA+ID4gPiBt
YXBwaW5nIGJldHdlZW4gdlNNTVUgYW5kIHZpb21tdSBpLmUuIGxldHRpbmcgdGhlIGtlcm5lbCB0
bw0KPiA+ID4gPiBmaWd1cmUgb3V0IHdoaWNoIHBTTU1VIHNob3VsZCBiZSBzZW50IGFuIGludmFs
aWRhdGlvbiBjbWQgdG8sIGFzDQo+ID4gPiA+IGhvdyBWVC1kIGlzIHZpcnR1YWxpemVkLg0KPiA+
ID4gPg0KPiA+ID4gPiBJIHdhbnQgdG8ga25vdyB3aGV0aGVyIGRvaW5nIHNvIGlzIHNpbXBseSB0
byBiZSBjb21wYXRpYmxlIHdpdGgNCj4gPiA+ID4gd2hhdCBWQ01EUSByZXF1aXJlcywgb3IgZHVl
IHRvIGFub3RoZXIgdW50b2xkIHJlYXNvbi4NCj4gPiA+DQo+ID4gPiBCZWNhdXNlIHdlIHVzZSB2
aW9tbXUgYXMgYSBWTUlEIGhvbGRlciBmb3IgU01NVS4gU28gYSBwU01NVSBtdXN0DQo+ID4gPiBo
YXZlIGl0cyBvd24gdmlvbW11IHRvIHN0b3JlIGl0cyBWTUlEIGZvciBhIHNoYXJlZCBzMl9od3B0
Og0KPiA+ID4gICAgICAgICB8LS0gdmlvbW11MCAoVk1JRHgpIC0tfC0tIHBTTU1VMCAtLXwNCj4g
PiA+ICB2U01NVS0tfC0tIHZpb21tdTEgKFZNSUR5KSAtLXwtLSBwU01NVTEgLS18LS1zMl9od3B0
DQo+ID4gPiAgICAgICAgIHwtLSB2aW9tbXUyIChWTUlEeikgLS18LS0gcFNNTVUyIC0tfA0KPiA+
ID4NCj4gPg0KPiA+IHRoZXJlIGFyZSBvdGhlciBvcHRpb25zLCBlLmcuIHlvdSBjYW4gaGF2ZSBv
bmUgdmlvbW11IGhvbGRpbmcgbXVsdGlwbGUNCj4gPiBWTUlEcyBlYWNoIGFzc29jaWF0aW5nIHRv
IGEgcFNNTVUuDQo+IA0KPiBXZWxsLCBwb3NzaWJseS4gQnV0IGV2ZXJ5dGhpbmcgcHJldmlvdXNs
eSBpbiBhIHZpb21tdSB3b3VsZCBoYXZlDQo+IHRvIGJlIGEgbGlzdCAoZm9yIG51bWJlciBvZiBW
TUlEcykgaW4gdGhlIGtlcm5lbCBsZXZlbDogbm90IG9ubHkNCj4gYSBWTUlEIGxpc3QsIGJ1dCBh
bHNvIGEgMkQgdmlydHVhbCBJRCBsaXN0cywgc29tZXRoaW5nIGxpa2U6DQo+IA0KPiBzdHJ1Y3Qg
eGFycmF5IHZkZXZfaWRzW251bV9vZl92bWlkXTsgLy8gcGVyLUlPTU1VIHZJRCB0byBwSUQgbG9v
a3VwDQoNCmFoIGRvZXMgaXQgbWVhbiB0aGF0IGRldiBJRCBzcGFjZSBvbiBBUk0gaXMgbG9jYWwg
dG8gU01NVT8NCg0KSXQncyBub3QgdGhlIGNhc2Ugb24geDg2IHBsYXRmb3JtcyB3aGVyZSB0aGUg
UklEIGlzIHBsYXRmb3JtLXdpc2UuDQoNCj4gDQo+IEFuZCBhIGRyaXZlciBpbiB0aGlzIGNhc2Ug
d291bGQgYmUgZGlmZmljdWx0IHRvIGdldCBhIGNvbXBsZXRlDQo+IGNvbmNlcHQgb2YgYSB2aW9t
bXUgb2JqZWN0IHNpbmNlIGl0J3MgY29yZSBvYmplY3QgYW5kIHNoYXJlZCBieQ0KPiBhbGwga2Vy
bmVsLWxldmVsIElPTU1VIGluc3RhbmNlcy4gSWYgYSBkcml2ZXIgd2FudHMgdG8gZXh0ZW5kIGEN
Cj4gdmlvbW11IG9iamVjdCBmb3Igc29tZSBhZGRpdGlvbmFsIGZlYXR1cmUsIGUuZy4gVklOVEYg
aW4gdGhpcw0KPiBzZXJpZXMsIGl0IHdvdWxkIGxpa2VseSBoYXZlIHRvIGNyZWF0ZSBhbm90aGVy
IHBlci1kcml2ZXIgb2JqZWN0DQo+IGFuZCBhZ2FpbiBhbm90aGVyIGxpc3Qgb2YgdGhpcyBraW5k
IG9mIG9iamVjdHMgaW4gc3RydWN0IHZpb21tdS4NCj4gDQo+IEF0IHRoZSBlbmQgb2YgZGF5LCB3
ZSBoYXZlIHRvIGR1cGxpY2F0ZSBpdCBvbmUgd2F5IG9yIGFub3RoZXIgZm9yDQo+IHRoZSBhbW91
bnQgb2YgcGh5c2ljYWwgSU9NTVVzLiBBbmQgaXQgc2VlbXMgdG8gY2xlYW5lciBieSBkb2luZw0K
PiBpdCB3aXRoIG11bHRpcGxlIHZpb21tdSBvYmplY3RzLg0KPiANCj4gPiBzbyBpdCdzIHJlYWxs
eSBhbiBpbXBsZW1lbnRhdGlvbiBjaG9pY2UgdGhhdCB5b3Ugd2FudCBhIHNhbWUgdmlvbW11DQo+
ID4gdG9wb2xvZ3kgc2NoZW1lIHcvIG9yIHcvbyBWQ01EUS4NCj4gPg0KPiA+IHdlIGFsbCBrbm93
IHRoZXJlIGFyZSBzb21lIGNvbnN0cmFpbnRzIG9mIGNvcHlpbmcgdGhlIHBoeXNpY2FsIHRvcG9s
b2d5LA0KPiA+IGUuZy4gaG90cGx1Z2dpbmcgYSBkZXZpY2Ugb3IgbWlncmF0aW9uLiBmb3IgVkNN
RFEgaXQncyBjbGVhcmx5IGFuDQo+ID4gYWNjZXB0YWJsZSB0cmFkZW9mZiBmb3IgcGVyZm9ybWFu
Y2UuIHcvbyBWQ01EUSBJJ20gbm90IHN1cmUgd2hldGhlcg0KPiA+IHlvdSB3YW50IHRvIGtlZXAg
bW9yZSBmbGV4aWJpbGl0eSBmb3IgdGhlIHVzZXIuIPCfmIoNCj4gDQo+IE9oLiBXaXRoIHJlZ3Vs
YXIgbmVzdGVkIFNNTVUsIHRoZXJlIGlzIG9ubHkgb25lIHZpcnR1YWwgU01NVSBpbg0KPiB0aGUg
Z3Vlc3QgVk0uIE5vIG5lZWQgb2YgY29weWluZyBwaHlzaWNhbCB0b3BvbG9neS4gSnVzdCB0aGUg
Vk1NDQo+IG5lZWRzIHRvIGFsbG9jYXRlIHRocmVlIHZpb21tdXMgdG8gYWRkIHRoZW0gdG8gYSBs
aXN0IG9mIGl0cyBvd24uDQo+IA0KDQpPa2F5IEkgbWlzc2VkIHRoaXMgcG9pbnQuIFRoZW4gdGhl
IG51bWJlciBvZiB2aW9tbXVzIGlzIHJlYWxseSBhYm91dA0KdGhlIGNvbnRyYWN0IGJldHdlZW4g
dGhlIHZtbSBhbmQgdGhlIGtlcm5lbCwgd2hpY2ggaXMgaW52aXNpYmxlIHRvDQp0aGUgZ3Vlc3Qg
b3IgdGhlIGFkbWluIHdobyBsYXVuY2hlcyB0aGUgUWVtdS4NCg0KYnV0IHdhaXQsIGlzbid0IHRo
ZXJlIGFub3RoZXIgcHJvYmxlbSAtIGRvZXMgdGhlIFZNTSBoYXZlIHRoZQ0KcGVybWlzc2lvbiB0
byBlbnVtZXJhdGUgdGhlIHRvcG9sb2d5IG9mIHBoeXNpY2FsIFNNTVVzPyBPciBwcm9iYWJseQ0K
dGhlIFZNTSBvbmx5IG5lZWRzIHRvIGtub3cgdGhlIG51bWJlciBvZiByZWxldmFudCBTTU1VcyBm
b3INCmFzc2lnbmVkIGRldmljZXMgYW5kIHN1Y2ggaW5mbyBjYW4gYmUgaW5kaXJlY3RseSBjb21w
b3NlZCBieSBleHRlbmRpbmcgIEdFVF9IV19JTkZPLi4uDQo=
