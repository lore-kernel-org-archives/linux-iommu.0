Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 528C342A9D
	for <iommu@lists.linux.dev>; Wed, 26 Feb 2025 01:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740532364; cv=fail; b=n5NbNRJ0Gtxb5/bpOiNerAX3paru8OK16syS64d7JHDgmb9B8kiY240XBKqGYoP1dTzz1mmVLKInuUYyByzyMtnzog2bbP1zaFOO52bVxwBSyL2DICnn79cZH93XyYCNT/gMcpbvG2MW4x0dHVxQ25wU3p5gZP53LSeQr4drxhQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740532364; c=relaxed/simple;
	bh=RKPyzoM8YLEo1wFoBmdDImXIzt99He0a4RCLh1poU24=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rkvvoIm2Yqm7VuxozSUEQePEEIzuwv9nQAVShIj0a1L5EMnBMT01GdbIl/KlDZevlX+L6Fi6LE3ZERTD8zX+0SsFmiT0Rbz4RWbVDMV6a0MmkS5AEPzjn/6n7HYLSFvu0bES2FlF2U+YBJuoWcbS4Z6ni68jA4Lm7cKBVhIhfr0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ECfi55hU; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ECfi55hU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740532364; x=1772068364;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=RKPyzoM8YLEo1wFoBmdDImXIzt99He0a4RCLh1poU24=;
  b=ECfi55hU67OoHn7WUz//U520XHWV0178y2XH7u1nkU78zhebNEQO/41b
   DIW9Jopb1CUV5/4J5zXvleZGxKKlDbIT230hreXkZgl+a4POiqxzgA4Xt
   zgZcLLHLndFI/gdN0Li40u+S8Il/X4H6QQb3K6CxJ5M7oyECvXy56ybIi
   KuGmFo986TBwY86KAFGjJ9HnclH/NpUI24bsEtRSmf01ZsxqVyrpk4D9t
   Ha37ZS/53qP+9e67hEy0B13Z5ZGJvvSU7+m+wM174mUHkyQBTG2O2NW1l
   hE9NtWKljHkWcXt6K4t21+u5fKgBRGwQJ8Oszh5JqJ393989nGoHn7Go2
   A==;
X-CSE-ConnectionGUID: I4yJ9cYBTK6SGohZpgwTpQ==
X-CSE-MsgGUID: kXRq7yI3Rp+3lx9S0RhbtQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11356"; a="41070066"
X-IronPort-AV: E=Sophos;i="6.13,316,1732608000"; 
   d="scan'208";a="41070066"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2025 17:12:43 -0800
X-CSE-ConnectionGUID: stJuFhe2TJy4Gs/jU6H+5w==
X-CSE-MsgGUID: /m1w0Z+LRQartZSPpetWyw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,316,1732608000"; 
   d="scan'208";a="117175529"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2025 17:12:42 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 25 Feb 2025 17:12:41 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 25 Feb 2025 17:12:41 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.173)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 25 Feb 2025 17:12:41 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hsy8VgGeqQMG/nfUilU0U5Q2MVmdc+3Y+lenQruOuZcUdvrx4Mc4XyLnqVE2Lds4UbFHM+G6QdATjnxl3lTGIWiGbgufDDgW6PXRI4FjrDclx97nSnND4AqHwxN9nFATaILm2tD2qjAf8rYWnhcGw37lY22CHCY92Yf3KfarrmIG7kGzRzlCyxjUIClD4XstTNbJlRcPHXBN/NCWRL1ERxWt7sgL2nb9oXDuETooMOe6Bo2eiG750DmsIWoOCBjAO32qIsNWkSZZvVEuKjwX7I0R3YlOdLng+PvsuObeNL1j6o216cfYWJPcxX040U9099g037IOFv5fIGN+mc/uww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RKPyzoM8YLEo1wFoBmdDImXIzt99He0a4RCLh1poU24=;
 b=uCLyDBIlWUQk8xX0ukykse+hzYWTzW+NpmCBWdelYXOIZSeIGoNneW5bD789OcQ5HiQkV1jkdDbVc59VxJvnMj0rVrw3hXMQbflbjC/PCgL8eK1uNffoQ2ZCOAxyCCmXJ+g1apckYEfRzBDhkmKuWytEoJaBzVftGb08ZOwk8gM1reURSQBfr0Nz1k5ywf15ykqkY4wn/BVDYFr1bQ2vYoSl3BIJUIptm5JYA/HVHMER5gkHqxtx9OlJf95U3R6NBm2cM6m9EwD0Ng1V1jlvaA2bU8B1LMCxS+fgaa9Kockmm4uzdXnFyOxI35EFyWmlIeuOJpzLVroqQ3hl6bSapA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by MW3PR11MB4522.namprd11.prod.outlook.com (2603:10b6:303:2d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Wed, 26 Feb
 2025 01:12:38 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%6]) with mapi id 15.20.8466.020; Wed, 26 Feb 2025
 01:12:38 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Gunthorpe <jgg@ziepe.ca>, Robin Murphy <robin.murphy@arm.com>
CC: "Liu, Yi L" <yi.l.liu@intel.com>, Vasant Hegde <vasant.hegde@amd.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>, "joro@8bytes.org"
	<joro@8bytes.org>, "will@kernel.org" <will@kernel.org>,
	"suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>
Subject: RE: [PATCH] iommu/amd: Add Secure ATS support
Thread-Topic: [PATCH] iommu/amd: Add Secure ATS support
Thread-Index: AQHbh3UOCMVRgdan70yjYJFDyKuOHbNX8z2AgAANboCAABr8AIAApFIg
Date: Wed, 26 Feb 2025 01:12:38 +0000
Message-ID: <BN9PR11MB527624C1DED16B3C049D13438CC22@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20250225105829.52223-1-vasant.hegde@amd.com>
 <be9d2ad2-0f9e-4d06-952b-4cfd6ae53447@intel.com>
 <ce86ff90-377e-49fe-9c4e-d2ad7abeeec8@arm.com>
 <20250225145518.GJ545008@ziepe.ca>
In-Reply-To: <20250225145518.GJ545008@ziepe.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|MW3PR11MB4522:EE_
x-ms-office365-filtering-correlation-id: 255644e7-6f53-4a3e-f5a4-08dd5602a92a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?dVJrcGVYbHViMzk2TXlFSXlzbFNDY0xOTFlYMTN2QXB6Y2FkTWU0Zkk4MWhE?=
 =?utf-8?B?Z1R0WkNaaitlbjJDRE1yU216dU9jMS85RkVLb0NSU0VWRUhFVkJMTjR6cFNP?=
 =?utf-8?B?MEJRdHFDRnhJQlNJZy9wTkZGdVBvWnNOYlRtbk9aWHVycVBhQW1ET2NneTVt?=
 =?utf-8?B?Y2RaMWpycjdHOUxYWk9HTzEwSkNMeVpmQUx0V1g5NExFQW0rcm42L1hKbFVx?=
 =?utf-8?B?SlRFNGpveUdJeDdsanQ3QmlKUFFPSGt0d3VlWUtVSWJiSXpsNkNpQksyeFN2?=
 =?utf-8?B?WGVmejg1b1pGZ3g5cngxckxuMzhJaEZ4NndFSFVKL3I1WHZvZGMrNUduaE4z?=
 =?utf-8?B?WmJZU1hpeEV5SWMzQ0p2Y3RGYmVMWjdFeEk2SjYzckZTb0IzS1pqOUpBN3RW?=
 =?utf-8?B?d0FrWm94SHNkRVVhNEQ4Y29yUGpMYS9IMXU2bFJPdEJkdXdHbGUxaGExdkVF?=
 =?utf-8?B?YU9EdXN2Uk51eFZKbUY4Q3Njdm1sWDlHQTZHVVdpYmtMdC9md1lKa2srU2xH?=
 =?utf-8?B?d2Z4cTNad0l1R1JRbnRCbFZFSXNiNzdUZzRyNlNUQW1TYTNjQUd4RXhHYllw?=
 =?utf-8?B?UnBlYzdBZmpGVlVDOE1SLzlveExhZmZHWlFVZEtxWFJma3N4TmVZMDZxaWJL?=
 =?utf-8?B?YTAyL0RMMVRHbE83SnZtQVpZTHhZL3lranBlQlVCVHNPRnhKUzZnOWkzTHY3?=
 =?utf-8?B?VXFQVFI4T3R3cjRSY1pjbWFJeG1NclpQNmNHRXFYL1dBeEFhN2NPMXlxUkxX?=
 =?utf-8?B?NHNaM2ZXVHMzNVdhM3RaaFUxWkt6MmJXUFhTRzk3RGR0Z3JLR1ZSSUc2UmpY?=
 =?utf-8?B?MEJ3Zy9FUXpibVBzQ3JNT283L1FIZHFmZWhVbFY2QUd1UlQ1Nzh5Q2RITnow?=
 =?utf-8?B?Tk1VY1JNRVpLT053UzdVZTIrVVJXR05udVArcUlDeTRMRlRlcVYxOTJJVVFD?=
 =?utf-8?B?NnpkVjQ4emxuRTJRdm93NCt2dEF2TDV2TWhpQmVuY3Y4dkFqSzQvaDlad1V5?=
 =?utf-8?B?NTRZK3A3aExVZi9XZFhUWlBiWWRwTFBzMFpjdEhHalZiVHMramh3REhSWC9H?=
 =?utf-8?B?UTNiVFo1dnd6bmpDaUVieFE0UE43T0Z2enZyUVJRaWR5cmNVSGhaVFB1WFAy?=
 =?utf-8?B?aWhVNXZWMjhnRkhmOHJ5VlRXODlkcnNxNDFDakdWWDBXaTQyQlhHQ0FyLzJm?=
 =?utf-8?B?TjRMdHRGSXdIeGtTUUR5RHRSTlZtMkptM2pBWW5sR0VRRGlmNnpqeVV2QWJk?=
 =?utf-8?B?NklsVUVHMGlnS2Yxck5VR01lQ3J2Ym0xTTdmK2R4Z1pMVTQ0dVVDcDh1dGZZ?=
 =?utf-8?B?UmR2cDFoZjh1eGdXN2FHamUrVFNLN0dLNGhDMHYxQlBJeWk0azY1a3AvOGRY?=
 =?utf-8?B?OEJpZUVPb2loNVZ2VzdpOFZsbUZIcW8zU3dOdkg3bVltcGZqSjhxWGpyVHE4?=
 =?utf-8?B?R3dYWjIvMFQzVUgwb1N0eVJSQW44Ky9PenAycnR6WS9RRFBXM1dad2JlWVM1?=
 =?utf-8?B?YXI5VEpTbDVERmkvQkVKc3VRM2dkMER5eTdGRlZJRkNodldHTkI1cC90dG5n?=
 =?utf-8?B?WHNzMk53MTN4dlYrbWRyTlN0RmdrZnhYQnc4UzhNZVA0RTQ0b203ajg5Vk8v?=
 =?utf-8?B?aGE2MnFibWJpV2dQQlJvQzdIQlh1cTNqd0ZCM2VGYTZ2RkJkcVQwd0wrOEor?=
 =?utf-8?B?VlhMUnRjVTFiQmFWQmp0MzN4OUhVMmVlY20xNFZrMGpLWnRRT2Z5WU5Ka2t2?=
 =?utf-8?B?ekxVd2FWNE56Mnp0RUN3ejRXK1pKakMxQjgxMkxuSnFIMXBORUk3VGI1NG9z?=
 =?utf-8?B?SVJyNTY1b0NKUGZ5R1NkRE95K25JZElYYU0wK3VadWtCTG81SzVXNndPK2hH?=
 =?utf-8?B?cE1qRnd1b3NnbEdLU0ttK2tVclhPSkJyakE3ZDh2U3E1WnJZcTZ4ZHhMTEhz?=
 =?utf-8?Q?rqIq+7FQPI+ZIOOxHRMKngyOwRdWCkR6?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?akFQYVlzdVZySmRFRkJ1M2lJM2Q1WGRhQXlPZmVIcVppR0tWOE5ydTFWN3py?=
 =?utf-8?B?NFVVSTBva21DZUtYaDVmN0tmSUMxMU5jVmhQd2dycXRGdGtVY21LbmRWamZ6?=
 =?utf-8?B?K0lDNjRycHFtWDRGTWdpb0NZWG16TnUvSlhNYll4Wm54Mk9WNFRlc0M4eG1X?=
 =?utf-8?B?VS9qbGd3dUF4MlNOYUpmS0laOTJhdDh5MjJEUFlQVjBiclZRMWhnS3NNbHFQ?=
 =?utf-8?B?TzdFTWNjODBOWEhsY2ZRbFR3KzMxZm05NS9EWHRiNURaY3dyUDRsV1RTZDRp?=
 =?utf-8?B?cWRuMzBpbGU2am1UeE5DcWJPZktQVmNsaVBjL1BidU9RL0k5YTBXTWJoNXdx?=
 =?utf-8?B?S0JjYmI4RFE4OEk3YTVWZWZDNWdaaFFyRGFuKzg1TEZRcjU0QzE5S0kzNzE5?=
 =?utf-8?B?YnROM3U5WXhmSXJsOWllYUhGdy93Z1ZpSFhmaVo2UnFxWlNtYnFTZXlRVGJ3?=
 =?utf-8?B?K0NWTFlTbWNRckRzdzN0MWxJNGtzZTJlbmhYcHpxZmhRak5wYWRJYkcyY1VM?=
 =?utf-8?B?WER5QTVWQ3BzMm9zMSs1b3dOTnM5VzhpSkN2a2FNNi9CVUZVZTQ4b1V2RFlZ?=
 =?utf-8?B?enlJL3dDdGZuSzlkQXNBb05PTSs5R1ZGWGZwVGFha1FpYU1jQ014dkhPcy9G?=
 =?utf-8?B?MCs4Q1Q3dllMOXlETXcwbW04QTNVSlJiQzdJTWJ3YXM5L3NtbHB3N0U3ZlE0?=
 =?utf-8?B?NDFXUlY3OGpmTDlyQlliL20rWFVIUHVEQXZubU83UkJ5RVhycnNqMXc3TzRC?=
 =?utf-8?B?TWR6QXEyRGY4dFB2VzNEdGZOQXVjTDFvdjB3Y2psbkZIakxGaVBqQXFzblJP?=
 =?utf-8?B?TzYxWlZMZkk5Z2l2VFdJTEVhMnI4VlFKT2xMd1J2YVZKL29nVDhwRlJMcnlL?=
 =?utf-8?B?OEtMRERPbzdGcnlZbnFvc0JUUm0zMk91Yjc5WDRlT3RGNFpIVWc1R3c5T0Q0?=
 =?utf-8?B?dyszLzV3anFsYUVoN1ljZ1NDVlhlMnU1SWZwaVhTNmNFeHhJazN0ZVBRSnlI?=
 =?utf-8?B?MVViOW5QYWZuUE9GWm1oOUlubURKK3VBV1lnMDdNRlFGRWh2eWtwWVkyUEhX?=
 =?utf-8?B?cWR5S1JNSGkrVlFQZFFrOXBYelBBUXpIVnRXMzV2Uk4yQkxPcjN2S0dUeS9P?=
 =?utf-8?B?dE0xOVRoanhBREgrci8yeEdyb0paYWllWnV1aWdBMUZUVEVXejdUK0NORzl5?=
 =?utf-8?B?L1BxV1VvSHh2TVVvdGpIWFV2RjZYMlRabTNwNG9SakhkbXM2ZGRTWlRCMjZX?=
 =?utf-8?B?TEswMlBZT00rSVA0em1sSTJkUkI3d2RsekRSRlo0NldXZG5lRC9DMUJVMThl?=
 =?utf-8?B?TUUzNXNDSmJxTU52UWh4cHZ4Q2J6Q1djZTBmeU4zc2NTKzR2cklpeThrZVps?=
 =?utf-8?B?Wkx3WHdmNFFvY0FCeS9NdW54ZStIMGc5c3pVellwTTY3Y1BPM1dwN2t4cXp6?=
 =?utf-8?B?RXJVdk1PQ2lCS1FuUHRzMHFHWXRzL1F6ZlJVSjZhVktsays2MHltNXFBV21W?=
 =?utf-8?B?aUY0OTE1bjFYTVIvSWVOWUl1Nkc0MHN5MDM0V2JFVDRrMUYxMUFla2l5anVM?=
 =?utf-8?B?eTRzVUhTUFh2d2h0N1owWXR6MFBNRm9kUVpxTURWQ1B4YndUazExbFhGeEwz?=
 =?utf-8?B?MENSTW1BSkFaTmpNdjZ6UVpMTUV3TkhMLzUyejBuM0hxS0liRFQ2bnRPRXVG?=
 =?utf-8?B?eEdUUlV6Wk15Vm9lQlZjeGVGL0RPanZuYnRweUl1V2ZmS2dMNmtnNjlLMUgx?=
 =?utf-8?B?TDliRkRqSjRJanN4WnpMTzF0MndSTnFyQzd6WXhlUmk4Y2dnSjFEMHBKcjY0?=
 =?utf-8?B?Mm1SbktqWWNQYk9NdXpYcWtiZHlsQTFHWDdOMGQ2SEoybW43RExDZlRPZzVB?=
 =?utf-8?B?RHJ4UTZ4dEhNNHNvaVd2NE1aYXAzTEF2Umd6dGc3K05kcWlIY0xCMTRhajBX?=
 =?utf-8?B?cXlkcjUyRW1WV3VQUzVtbTY2aFRrZUJHNk5ua2FxcTNlUHZEOXFjNWFQT29v?=
 =?utf-8?B?VXFBRUZqODdaSHBJZThCV0pKb3A2TUZSM20zSEkvcEJKaUdKM1BaTTQwMk1h?=
 =?utf-8?B?ZkNmbWdRdFJTNTNWeFZtZnlDbC81VmpzWkp2aXkzZnlIakZXbHJYalRHT200?=
 =?utf-8?Q?1ubvVqewS/NGFJwkwLoVfgg4U?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 255644e7-6f53-4a3e-f5a4-08dd5602a92a
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2025 01:12:38.4372
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: e3firJ8y5RdOzV5eo5koW32X/wOrjVNbOl+TBF4BB33aaWmBag7PRVMudkVQQ+b30nIbs2xsm4dbJER3VVHSFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4522
X-OriginatorOrg: intel.com

PiBGcm9tOiBKYXNvbiBHdW50aG9ycGUgPGpnZ0B6aWVwZS5jYT4NCj4gU2VudDogVHVlc2RheSwg
RmVicnVhcnkgMjUsIDIwMjUgMTA6NTUgUE0NCj4gDQo+IE9uIFR1ZSwgRmViIDI1LCAyMDI1IGF0
IDAxOjE4OjQzUE0gKzAwMDAsIFJvYmluIE11cnBoeSB3cm90ZToNCj4gDQo+ID4gPiBNeSB0aG91
Z2h0IGlzIHRvIGFkZCBhIGZsYWcgaW4gaW9tbXVmZF9od19jYXBhYmlsaXRpZXMgdG8gcmVwb3J0
IHRoZQ0KPiA+ID4gY2FwYWJpbGl0eSwgYW5kIGFkZCBhIGZsYWcgaW4gaW9tbXVmZF9od3B0X2Fs
bG9jX2ZsYWdzIHRvIGxldCBpb21tdQ0KPiBkcml2ZXINCj4gPiA+IGtub3cgaWYgSFBUIGlzIG5l
ZWRlZCB3aGVuIGFsbG9jYXRpbmcgUzIgZG9tYWluLiBVc2Vyc3BhY2UgYXR0YWNoZXMgdGhlDQo+
ID4gPiB1bi10cnVzdGVkIGRldmljZXMgdG8gdGhlIGRvbWFpbnMgd2l0aCBIUFQuIFdoaWxlIHRy
dXN0ZWQgZGV2aWNlcyBjYW4gYmUNCj4gPiA+IGF0dGFjaGVkIHRvICdub3JtYWwnIFMyIGRvbWFp
bnMuwqAgV2lsbCB0byBzZW5kIGl0IG91dCBzb29uLjopDQo+ID4gPg0KPiA+ID4gPiBXaXRoIFNl
Y3VyZSBBVFMsIGZvciBBVFMgcmVxdWVzdHMgSU9NTVUgcmV0dXJuIEdQQSB0byBkZXZpY2UgaW5z
dGVhZA0KPiA+ID4gPiBvZiBTUEEuDQo+ID4gPg0KPiA+ID4gSSBzdXBwb3NlIEFNRCBTZWN1cmUg
QVRTIG9ubHkgd29ya3MgdW5kZXIgbmVzdGVkIHRyYW5zbGF0aW9uDQo+IGNvbmZpZ3VyYXRpb24u
DQo+ID4gPiBpcyBpdD8gSSBndWVzcyBhZG1pbiBtYXkgd2FudCBzb21lIGZsZXhpYmlsaXR5IHRv
IG9wdC1pbiBpdC4gOikNCj4gPg0KPiA+IEhlaCwgYW5kIGluIFNNTVV2MyB3ZSBoYXZlIGJvdGgg
b3B0aW9ucywgd2l0aCBzcGxpdC1zdGFnZSBBVFMgZm9yIG5lc3RlZA0KPiA+IHRyYW5zbGF0aW9u
LCBhbmQgb3VyIERldmljZSBQZXJtaXNzaW9uIFRhYmxlIGZvciBmdWxsIEFUUywgc28gaXQgc2Vl
bXMgbGlrZQ0KPiA+IHRoZXJlIHNob3VsZCBiZSByb29tIGZvciBzb21lIGtpbmQgb2YgZ2VuZXJh
bGlzZWQgY2FwYWJpbGl0eS4NCj4gDQo+IFllcywgbGV0cyBub3QgaGF2ZSBhbm90aGVyIGRyaXZl
ci1vbmx5IGNvbW1hbmQgbGluZSBwYXJhbWV0ZXIgYnV0DQo+IHNvbXRoaW5nIGdsb2JhbCBtYW5h
Z2VkIGJ5IHRoZSBjb3JlIGNvZGUuDQo+IA0KPiBXaGF0IGFyZSB0aGUgb3B0aW9ucyBoZXJlPw0K
PiAgMSkgVHJhbnNsYXRlZCBBZGRyZXNzIChUQSkgaXMgYSBmdWxsIHBoeXNpY2FsIGFkZHJlc3Mg
YW5kIElPTU1VIGRvZXMNCj4gICAgIGRvIGFueXRoaW5nICh0b2RheSkNCj4gDQo+ICAyKSBJT01N
VSBjb252ZXJ0cyBhIFMxIElPVkEgaW50byBhIFRBIGFzIGEgUzIgSU9WQSBhZGRyZXNzIGFuZCB0
aGUNCj4gICAgIElPTU1VIHJ1bnMgaXQgdGhyb3VnaCB0aGUgUzIgdG8gdmFsaWRhdGUgaXQuIChB
Uk0gY2FsbHMgdGhpcw0KPiAgICAgc3BsaXQtc3RhZ2UpLiBSZXF1aXJlcyBuZXN0aW5nDQoNCmFu
ZCB0aGlzIHdvbid0IHN1cHBvcnQgQ1hMLmNhY2hlIHdoaWNoIHdvcmtzIG9uIHBoeXNpY2FsIGFk
ZHJlc3MuDQoNCj4gDQo+ICAzKSBUQSBpcyBhbiBJT1ZBIGFuZCB0aGUgSU9NTVUgcnVucyBpdCB0
aHJvdWdoIHRoZSBmdWxsIHRyYW5zbGF0aW9uDQo+ICAgICB0byB2YWxpZGF0ZSBpdC4gQVRTIGlz
IGp1c3QgdXNlZCB0byBzaWduYWwgbm9uLXByZXNlbnQNCj4gDQo+ICA0KSBUQSBpcyBhbiBmdWxs
IHBoeXNpY2FsIGFkZHJlc3MgYW5kIHRoZSBJT01NVSB2YWxpZGF0ZXMgdGhlIGZ1bGwNCj4gICAg
IHBoeXNpY2FsIHVzaW5nIHNvbWUga2luZCBvZiBwZXJtaXNzaW9uIHN0cnVjdHVyZSAoQVJNIGNh
bGxzIHRoaXMNCj4gICAgIERldmljZSBQZXJtaXNzaW9uIFRhYmxlKQ0KPiANCj4gV2hhdCBhcmUg
dGhlIHRocmVlIEhXcyBkb2luZz8NCj4gDQo+IEkgc2VlICMyIGFuZCAjNCBjbGVhcmx5IGluIHRo
ZSBTTU0gc3BlYy4gSXMgIzMgYSBzcGVjaWFsIGNhc2Ugb2YgIzIgKGENCj4gU1RFIHdpdGggYSBT
MiBhbmQgUzFEU1MgYnlwYXNzKT8NCj4gDQo+IEkgdGhpbmsgQU1EIGlzIGRvaW5nICMzIGZyb20g
dGhlIGRvY3MuDQoNCm15IHJlYWRpbmcgb2YgQU1EIHNwZWMgd2FzICMyLiBhbHNvIGJhY2tlZCBi
eSBWYXNhbnQncyB3b3JkczoNCg0KIg0KV2l0aCBTZWN1cmUgQVRTLCBmb3IgQVRTIHJlcXVlc3Rz
IElPTU1VIHJldHVybiBHUEEgdG8gZGV2aWNlIGluc3RlYWQgb2YgU1BBLg0KV2hlbiByZWNlaXZp
bmcgVHJhbnNsYXRlZCBETUEgZnJvbSBhIGRldmljZSB0aGUgSU9NTVUgcGVyZm9ybXMgaW4tbGlu
ZQ0KR1BBIHRvIFNQQSB0cmFuc2xhdGlvbi4NCiINCg0KPiANCj4gV2hhdCBpcyBJbnRlbCBkb2lu
Zz8NCg0KSW50ZWwgaXMgZG9pbmcgIzQuIFRoZSBwZXJtaXNzaW9uIHN0cnVjdHVyZSBpcyBjYWxs
ZWQgSG9zdCBQZXJtaXNzaW9uIFRhYmxlLg0KDQo+IA0KPiBBIGRvbWFpbiBhbGxvYyBmbGFnIHRv
IHB1dCB0aGUgZG9tYWluIGludG8gIzMgbW9kZSBzZWVtcyBsaWtlIGEgZ29vZA0KPiBzdGFydCB0
byBtZS4gVGhlIGNvcmUgY29kZSBjYW4gZGVjaWRlIHRvIGFjdGl2YXRlIHRoZSBmbGFnIGZvciB0
aGUNCj4gZGVmYXVsdCBkb21haW4uIFN1Z2dlc3Qgc3RhcnRpbmcgZnJvbSBwY2ktPnVudHJ1c3Rl
ZC4NCj4gDQo+IEFsc28sICMzIHJlcXVpcmVzIFBDSSB0b3BvbG9neSBzdXBwb3J0LCB0aGUgQUNT
IGZsYWdzIG5lZWQgdG8gYmUgc2V0DQo+IHRvIHJvdXRlIGFsbCBUQSdzIHRvIHRoZSBob3N0LiBU
aGUgY29yZSBjb2RlIHNob3VsZCBjaGVjayBhbmQgdmFsaWRhdGUNCj4gdGhpcyBiZWZvcmUgdHVy
bmluZyBpdCBvbi4NCj4gDQo+IEkgdGhpbmsgIzIgY2FuIGJlIHJlcXVlc3RlZCB0aHJvdWdoIHRo
ZSB2U1RFIG9uIEFSTT8NCj4gDQo+IE5vdCBzdXJlIGhvdyB0byBzZXR1cCAjND8gVGhlIGNvcmUg
Y29kZSBhbHNvIG5lZWRzIHRvIGRldGVjdCBjb2hlcmVudA0KPiBzeXN0ZW1zIChpZSBDWEwvZXRj
KSBhbmQgcmVmdXNlIHRvIGRvIGFueXRoaW5nIG90aGVyIHRoYW4gIzEvIzQuLg0KPiANCg0KSWYg
YWJvdmUgdW5kZXJzdGFuZGluZyBpcyB0cnVlLCBteSBwcmVmZXJlbmNlIGlzIHRvIHN1cHBvcnQg
YSBzYXRzIGZsYWcgDQppbiBkb21haW4gYWxsb2MgKG5lc3RlZF9wYXJlbnQgb25seSBhbmQgUENJ
L0NYTC5pbyBvbmx5LCBhcyB0aGUgc3RhcnQpLiBGb3INCkFNRCBpdCB0dXJucyBvbiB0aGUgc2F0
cyBiaXQgaW4gdGhlIERURS4gZm9yIEludGVsL0FSTSB0aGUgcGVybWlzc2lvbg0Kc3RydWN0dXJl
IGlzIGNyZWF0ZWQgYW5kIHVwZGF0ZWQgYWNjb3JkaW5nIHRvIHRoZSBtYXAvdW5tYXAgY2FsbHMN
Cm9uIHRoZSBwYXJlbnQgUzIuDQoNCkl0IHByb3ZpZGVzIGEgbmljZSBtaW5pbWFsIHN0YXJ0IGZv
ciBhbGwgMyBwbGF0Zm9ybXMuDQoNCkxhdGVyIHdlIGNhbiBlbmFibGUgbW9yZSBkb21haW4vZGV2
aWNlIHR5cGVzIGZvciAjNCBhbmQgYmV5b25kDQppb21tdWZkIGlmIG5lY2Vzc2FyeS4NCg0KVGhh
bmtzDQpLZXZpbg0KDQoNCg==
