Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52FD613AD2A
	for <iommu@lists.linux.dev>; Tue, 22 Oct 2024 07:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729583445; cv=fail; b=c61lC95toLkGtRhz8/3JQE8BEoo78spg1C189s4g0nc1yykF+bDYvIFKEMEUyzrKVAiFb7yjkKGLTLLFQhqd5bu7yxBBInue/ai3sDJLONQ4wmjmoYnEwRqIQ2fMDW+kvAZdDRdA8321dOCdBe6bpJOPx1nQkZStc5Vudc1j9lg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729583445; c=relaxed/simple;
	bh=ms9LkWBIN/AUpj5SVH/zBc//tKLgbHvQwnvHVCwjDYo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ep8ONRmXY97JXxuMYigGhf5rmcv609L8BXlQvXixByURgbb/ydvD+gd20SLoLOXkTUluAzNRcH/lNcPBo13EZsBFebRHWYybnKZd6fooWExyEMRCmbMIHYp1P3U2HY9j5p5x7jzJ0Z9jvR8+f7LQPYPgneefhF7jvLlHk5JfP2Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Cyq/tAyU; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Cyq/tAyU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729583444; x=1761119444;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ms9LkWBIN/AUpj5SVH/zBc//tKLgbHvQwnvHVCwjDYo=;
  b=Cyq/tAyUg9ESkowvcHU2aBosTowGb5Bi916MuT9YosYtzlUbOyYPulRb
   FBOfEZS3kfp67jlfK1mpFFLSOeO4JanZ67JKjWxI7Mcmbpg1fwE7pKm/7
   XPpjpcMnKmiqfNzls7vpBVRQPOdbT4SL26hqj4WMo3/Z0V0AZ9aVWFZWW
   fBsMm2+4NtBV1/Rz+mOESizS12gpCGhWTam/NEVhzjoV8BOjQC6IyBsJy
   28DBRUNxHh86YMFI/5t1b92GaB9CfRl1eRyDH5DHth+skyYDPFUPGSFY2
   RJSJ1TEV62Vc+gUX6KIGhDwwsoFpLGoubYqO77wopPJwnxZqHv06Abms+
   Q==;
X-CSE-ConnectionGUID: JxPTgESfQa6Uo2C72dHfjg==
X-CSE-MsgGUID: z+dmtF86S4SsKLwT+iFy8w==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="51639106"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="51639106"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2024 00:50:42 -0700
X-CSE-ConnectionGUID: ev+9sFUqSuSejnZrmJh0kg==
X-CSE-MsgGUID: ufW5eIxVQAeQADa0DvoBhQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,222,1725346800"; 
   d="scan'208";a="79346285"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Oct 2024 00:50:42 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 22 Oct 2024 00:50:41 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 22 Oct 2024 00:50:41 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.171)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 22 Oct 2024 00:50:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FPt4QVOoBbRUQy7AONSPWvqyJNfJpm3zQnxa1xevoq+PbuoF9oZfaQ1FJ5W3ieN1ykdJu2ytqSLYV0puRpdSPW89TRGz3iZKnr0K44HPHsW010wNzPD21iNGfjmkTF1oheApsv8Bzjsrg/xI6QTLFJzVFOV8RCcnK7xsakf+1JM7cNcL+J60S6nsRkGoZL8Hb+09g1ZAvjovDb2ebcyH8qN6aSSLsorJR+BXiozjXmxmZwzvMWaYRpnvtwSb8pOeXnNqY80seySQTRPKi27uooIQM1ypqmmlWOCpF7PrJQj7l+OJTeZO1g/o8UpK6OWRHbVxyrtpKsQLQxclXmbuYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ms9LkWBIN/AUpj5SVH/zBc//tKLgbHvQwnvHVCwjDYo=;
 b=v8M8wLd2NgOudJqpeIfH2Rx87iCUoktgjUfbqw6KbjeD8/2g5/14hI4NH8+XUE+p9f6NmNZAUSO+ISNax/ZPZ5jJzfpbBphJCPxYZKN1PiAfq3BcC/1DGMgBGJolbVmZSglVsyai/O8j0KT1b4WgSRRiOA9rU98CO+1MZY0rtlfLVEBY0TK4BWerkVwKrXycbg+SJ3lZyr/q8AgtzAxOycZPv2OtbCyBuO9Fo2IfUQXguLr4PBNRFGNRkZbwztDaMxDSjnQ+qWiVzYFIlsjlzrKbRjZZ98bZ66MVEaNxe1U849B3ylpokR4yHs2EtwlCsGYN7gdUN/9JiO8ClgqLxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by CO1PR11MB5041.namprd11.prod.outlook.com (2603:10b6:303:90::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.29; Tue, 22 Oct
 2024 07:50:32 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%6]) with mapi id 15.20.8069.027; Tue, 22 Oct 2024
 07:50:31 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Vasant Hegde <vasant.hegde@amd.com>, Jason Gunthorpe <jgg@ziepe.ca>
CC: "iommu@lists.linux.dev" <iommu@lists.linux.dev>, "joro@8bytes.org"
	<joro@8bytes.org>, "will@kernel.org" <will@kernel.org>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>,
	"suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>, "Liu, Yi L"
	<yi.l.liu@intel.com>, "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
	"jacob.pan@linux.microsoft.com" <jacob.pan@linux.microsoft.com>
Subject: RE: [PATCH v3 00/12] iommu: Domain allocation enhancements
Thread-Topic: [PATCH v3 00/12] iommu: Domain allocation enhancements
Thread-Index: AQHbIJ07CxPRQt7mpkKA0oiVQurCOrKMd0eAgAR5FgCAAXwmEA==
Date: Tue, 22 Oct 2024 07:50:31 +0000
Message-ID: <BN9PR11MB5276C874735B30D48475C3B88C4C2@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20241017140137.6028-1-vasant.hegde@amd.com>
 <20241018125005.GF948948@ziepe.ca>
 <47b5397e-d706-4c72-b849-a91f6ef1f569@amd.com>
In-Reply-To: <47b5397e-d706-4c72-b849-a91f6ef1f569@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|CO1PR11MB5041:EE_
x-ms-office365-filtering-correlation-id: 2e308dce-1103-4283-c336-08dcf26e3460
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?bEdBR3VZSmhDVUNrRVZDWEJjYmh4UEp4LzhlTVF5SVdST0JEdHo4cjQrV2Jo?=
 =?utf-8?B?M1ZTWEZXMzl6dGpGWnJlNUZyRzMwN2xsS3Y4VVlCNmxIZ2RWMVJlV2d5Y0Q0?=
 =?utf-8?B?SnJpQWtKNWhkSGxETVM4MlpFNzdNMk5sVmxleFhDVXpTM0VaMnFRNTFqWHhl?=
 =?utf-8?B?Y1dIZWhvT29HaWNmMVpBR3c4TVB2Nm1PRzZTeGdGOFhja3VmU0lOL3R5V3Ar?=
 =?utf-8?B?VzlYbUFMdit1Y0xULzVJNlpTVHBldk1nQndHR3B5K1BTRjNaMEFIL09qdDlE?=
 =?utf-8?B?MzBPT0pYVnA0WE50SFROVWd4Nm5zQTJ5cTBiYlVvOW1DdGlySFI3cHJCS09v?=
 =?utf-8?B?NkVXZC9mWEZ3NVlYV2FRQ3RRL25RUlFHV3ZlblRKdkRlVWlNSFlLeVU4TWQ3?=
 =?utf-8?B?R3FRMk1icEJTUXk2MDRQV25jMkgwNmFtZGNZd1E4bjVCL3p2SXVuclh2MVN3?=
 =?utf-8?B?R2xKRUt0dno5SEsxUHFWbTUxV1N5ZkFBMExiTGU0K2d1TTdFTk1SdjZYam4z?=
 =?utf-8?B?alJ0dUJvb3ZQenNIbDVSbEFLZVFxTTlxUU8xYVVJbzhZcHRUbmh6YWl6dkFj?=
 =?utf-8?B?RGtsSmpDa25rZzhUdVorZ28wRnhJTzdvcG56UUdNTTNoTHBaWVRpYVVwWEtu?=
 =?utf-8?B?RWdQakR4bzhlRytZQm5qdFdzbFd3bTZmNDQyUFh0dGZ0dURTSmo1T21KcGNz?=
 =?utf-8?B?cDFydU81d3dqNE1jSUtZaDJBaEZwbEtIRE8rUnhGeUJRNjd6dGlpWWY3T3Nj?=
 =?utf-8?B?RGZ5Wm1GZmdZNGQybWhjbW1VbWt3TnkrZlZYeXRmUnlFL2ZzeTJUVjZIdmlN?=
 =?utf-8?B?ays0MjVXVUhhc244ZUhGaDE1dWtTdjY2MTlXU3A4Q0Y4QUpSOWU0S3NMczVh?=
 =?utf-8?B?RjRwNThoTVdKVm9yNmQ4VitnaEIyUXNUK3A2R3VFYlFIZW1HU3FSK2RLY3Na?=
 =?utf-8?B?cmdMTXB1bGdQalVZMXZHZmdNWENrWk0wYnpUL3RkZlhOY0wzclorUUZ2cjZy?=
 =?utf-8?B?ZjhDb2xVRkNJam9GK3krVm5rSGQxR2VQU2FJazJ3MUIzY2FjY2xrT1lxK3Bo?=
 =?utf-8?B?U1o5OTUrbkd1YVZmRnk1ekx5RFNNd2dxN2VlWUxTbzVGTjBMenpPYVBHSC9K?=
 =?utf-8?B?WlFtSVhDd25WVi9DTFR4TlAzck8zeDR3NFhDSjJNUGpmaXM4KzhUTTJLMFp2?=
 =?utf-8?B?b1JiMFhoeUdHRThkczFFbE9PNlVNYXhnRGVZOGQrMy96MTNoMlJvRWRNczZX?=
 =?utf-8?B?NFVZVkFIQXdGUWNCcDR0ODhRcVMvSXdmOXBZaHJ2SDZMRUlMZUtJSHdPcTFn?=
 =?utf-8?B?WjUwVmxTbWNFNTJsOGpCRXg2b0dZV0Y2cjVYcmZyMWgrM2dIWDE5SDA4VTFV?=
 =?utf-8?B?d3I0ZE9BZ1k0aWlGcGVadEh6Q1dwOFFVT3RlSzVwU2RRMkhDUGl2UkpyN25v?=
 =?utf-8?B?VHRsbExuVHN0SEU0UnYwZG4xaWFGU2NsZEhsZGRoaTFLdEI5ZWhCMDh3M3dJ?=
 =?utf-8?B?a29XcWJjT2FqakM0d1d1NlQ4SWFUajluV0pyNWRpcGdjY0NyYkdraENSMTh3?=
 =?utf-8?B?QVo4R2xYVURla3VlYXNLVnRwUFF3OVNkL2dnWXZGU09KYitETlRpa1h6bXdV?=
 =?utf-8?B?TnN3U0pKY1VwZ0V1aFo2aGZpWkF2b1lOVSt0UFltczhOQm1iQ3p3RERPc2Vo?=
 =?utf-8?B?bkRIL3Vlc0JaZDJMSklZcHU1NXpQSCtwNG5KV2QzTTNLbmZ2aU9JL0t1RHdn?=
 =?utf-8?B?aWhhajhrR0RJRDU3MlI0L1Rrb09VNlcrT3VIY21VUkFPaWdPcTdyYmVBYjIx?=
 =?utf-8?Q?zYLfaHzWngSICIdM6j4NLrN/Q2fY0vU5ue55M=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TE1PaURocXgxOHc2bEJ3QW5mbnNpWjBsekM3REVHUzgxTWxYTC9lWHBpM3Q0?=
 =?utf-8?B?Y0tsTmx2N3kvakMwL1BJUy83NnpxWnorcFRadi9ZSWx3U3pEN2hJV1UxS0VZ?=
 =?utf-8?B?UXNuaFhOUlNCOGF4OVZJcTBHSHByajNrOXRWRXdMZzJCdUk2a25PR0FnR2NB?=
 =?utf-8?B?cS9ZVFVOY1hGeVpUM2d4M05nTktteDNXcmkrclBrKzhPQ2RyYU9QaTJCSy96?=
 =?utf-8?B?d1RTMFRIa1VtdTRRczU1bC9nUWVvTGwzUDBWU2Y4K0ZBWUdUVXBOZEp6dWVX?=
 =?utf-8?B?bGZIdHRteDJmbzlDT0xtUlBvelhTaCtVTFFrQklQcEpRM2FZQmpBOVN2Y013?=
 =?utf-8?B?MDRMTzBncWh6VnRsU2NqTG5ocis4cFdpMnJxY1pTU1dBN0lMZ0ZoL3hyNG85?=
 =?utf-8?B?Wmp2OUxRRk9vR1p6QVlIaG5XMC9zcU9hZHExb2tOWTBZWU94akVqUjN2aHJD?=
 =?utf-8?B?c3N2Kzl2b3BxMlk5VU9FTGMyTCs2di9CeTYrNDZTWDVabTRBMGNmdnVpK1Ur?=
 =?utf-8?B?YllMWE5MRlZUUloyZE1WY1pLTWo4azhhMGF4WVQ4Mk5BbEcrNTdnRzUrcnd3?=
 =?utf-8?B?OFJOaHdHaWhlR2JPTVVjNEdRMEhmeVRkejNRS09mWWdqWUQ0Rmg0TVFGeHAz?=
 =?utf-8?B?M25WRFhRTzhiVi83UUR2YkpFc1RUelRJYzFVVkg0ditiRFpKRkJ4cWdYTU53?=
 =?utf-8?B?MVk4QkdWdWtMSjFpOTZpUGdRZStKSldVQ3ZuZDJBMG5mMzNJKzRtNFdFc0Np?=
 =?utf-8?B?ZHhpVVZyUXZlU012T1FvODh4SjNrMXp6VHhoTFhSaW4yb0FxWE42d3ZkYzVq?=
 =?utf-8?B?R05VVExvYU5LL240VWtkWFM0T1dZaUhjNFc5cHBTOFVlMG5LQ2lpMnExUWk1?=
 =?utf-8?B?TDJPZGJwU21FOEUyVm5EOEduNkdZOVpWM3hpb2RCc1RSamNXME5IUFcwcFJL?=
 =?utf-8?B?UFF1Yy8wYTV3dTBRUlNiRFNaWWJMbFgxQzdWUnRhMkVVR09sWWFrNjNVZ1dN?=
 =?utf-8?B?d29hSTlYOHVzUDhmSitSY0FVRWpscXh5OXRSK0VPRDlWWXkwcHZrdk0vMlFi?=
 =?utf-8?B?cXh3SzB0YXlqalV0dXBWYTIzTFdEZ2dDQXUwYlp1aVNyek5USDZUcGY4eTUr?=
 =?utf-8?B?TnRCamJKVStOZ1NJalY4T0VIMHpuV2RDYm1KaWdMRlV2VmMydWpKNncyZkVC?=
 =?utf-8?B?VWk4QXdDbHlhbG5ocVBGRlFZbzA1aHdmZDh4WnpDVnZWbmc5dktTZzNMKzFw?=
 =?utf-8?B?SDZGZmVsRXdtUWxNVHducGlUeDlnL0xzN00xNEY3QlNkZy94dzZ4Yjloek1j?=
 =?utf-8?B?YzRMNm5MYU1nRDFUam9MTGF4dmxFcXUxRVVJVXZDYzBDK1RWRDBUZWJsR3A5?=
 =?utf-8?B?Q1lGTC9MTVBxc3E0cTlvZUFrdHFlSlEyMThWNTRkTlEzR3pHK0xuQ2JISjNZ?=
 =?utf-8?B?dFN2VTJhSXNCbmhqK0p1ZmJLb25RNXZwM0pldzVFWmJtSFd4TDZ5eDBCdVpq?=
 =?utf-8?B?bzkwdmh2RFFvMnJlYVZGQ0tlN3RvTXN3cDJWd0dXK3hrQlRublNIVDZESnVs?=
 =?utf-8?B?VkJ1THdBMU9OUncrTHI3blBnR3VQU0NISEswNjB1bmJyQjZ4aGwyVE5nZEJp?=
 =?utf-8?B?VDZLRHU1b21rcUpYdUppdFBMUXFYV2lJU0ttc2ZoeVAwaU5UWUhPbkRiT3R0?=
 =?utf-8?B?ZzdZNnJxb1ZMbUlxRGRtZlUyd1p1cG4vcG5tcFVMVmQxMC84MExFTExZd25n?=
 =?utf-8?B?S0J6eEdVdE5RQTZGWXlsd2U3L25WRkhxSXh3azkvako2UmZiQmVQWHdCTTlE?=
 =?utf-8?B?T0J3ait2WDd2bDVlM2V2T3MwdHdRTHk5cnR6T2k4RnNKM25xazVQYzg3TVM1?=
 =?utf-8?B?RGhURHRXVCt5QmZVVDhWK3p5Q3lVRGQ2eEttUUZWSlE3V3pkVXdkL092TGh0?=
 =?utf-8?B?bGpsWW5LSWU5bXdpVktVMHNGTWExUW9LUG5LdGFTcWxHU05JUXE0eUw5WEZO?=
 =?utf-8?B?c1drbVllM2liOGtFOFhyNWVsbDFHb2FNaVc4S0U1M0hWVXlUSUtWQXp3NDBN?=
 =?utf-8?B?RVhvd0pzYVIzQmI2OGlKd2dJRVpQdGdVOGZvOVFRdThJN2k1VDBRSUN6R2w3?=
 =?utf-8?Q?f5LJfNcoEFnD3+XY61Rdat0K9?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e308dce-1103-4283-c336-08dcf26e3460
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2024 07:50:31.8235
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vRBaZEPvh2uotLPcIVBmdUuCOo67NJpysZNeEwj6GqDPymSkOZVBvfHEDGWiyUsf676YDhEqw0gCR+KSWYgK9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5041
X-OriginatorOrg: intel.com

PiBGcm9tOiBWYXNhbnQgSGVnZGUgPHZhc2FudC5oZWdkZUBhbWQuY29tPg0KPiBTZW50OiBNb25k
YXksIE9jdG9iZXIgMjEsIDIwMjQgNTowOSBQTQ0KPiANCj4gT24gMTAvMTgvMjAyNCA2OjIwIFBN
LCBKYXNvbiBHdW50aG9ycGUgd3JvdGU6DQo+ID4gT24gVGh1LCBPY3QgMTcsIDIwMjQgYXQgMDI6
MDE6MjVQTSArMDAwMCwgVmFzYW50IEhlZ2RlIHdyb3RlOg0KPiA+PiBUaGlzIHNlcmllcyBhZGRz
IGlvbW11X3BhZ2luZ19kb21haW5fYWxsb2NfZmxhZ3MoKSB3aGljaCB0YWtlcyBmbGFncyB0bw0K
PiA+PiBwYXNzIGFkZGl0aW9uYWwgZGV0YWlscyBmb3IgZG9tYWluIGFsbG9jYXRpb24gKGxpa2Ug
ZG9tYWluIHdpdGggUEFTSUQNCj4gPj4gc3VwcG9ydCkuIEFsc28gYWRqdXN0cyBjb3JlIGNvZGUg
dG8gaGFuZGxlciB2YXJpdW9zIGRvbWFpbiBhbGxvY2F0aW9ucy4NCj4gPj4NCj4gPj4gQWxzbyB1
cGRhdGVzIEFNRCBJT01NVSBkcml2ZXIgZG9tYWluIGFsbG9jYXRpb24gY29kZS4gV2l0aCB0aGlz
IGJ5DQo+ID4+IGRlZmF1bHQgaXQgd2lsbCBhbGxvY2F0ZSBkb21haW4gd2l0aCBWMiBwYWdlIHRh
YmxlIGZvciBQQVNJRCBjYXBhYmxlDQo+ID4+IGRldmljZSBhbmQgdjEgcGFnZSB0YWJsZSBmb3Ig
cmVzdCBvZiB0aGUgZGV2aWNlcy4NCj4gPj4NCj4gPj4NCj4gPj4gVE9ETzoNCj4gPj4gQEphc29u
LCBAS2V2aW4sIEBCYW9sdSwNCj4gPj4gICBXaXRoIHRoaXMgc2VyaWVzIGlmIGRyaXZlciBpbXBs
ZW1lbnRzIGRvbWFpbl9hbGxvY191c2VyKCkgdGhlbiB3ZQ0KPiBhc3N1bWUNCj4gPj4gICBJT01N
VSBhbHdheXMgc3VwcG9ydHMgUEFTSUQuIElmIElPTU1VIGRvZXNuJ3Qgc3VwcG9ydCBQQVNJRCAo
ZXg6DQo+IEFNRCBkcml2ZXINCj4gPj4gICBub3Qgc3VwcG9ydGluZyBWMiBwYWdlIHRhYmxlKSBh
bmQgZGV2aWNlIGlzIFBBU0lEIGNhcGFibGUsIHRoZW4gZHJpdmVyDQo+IHdpbGwNCj4gPj4gICBy
ZXR1cm4gZXJyb3IuIERldmljZSBwcm9iZSB3aWxsIGZhaWwuDQo+ID4NCj4gPiBXZSBzaG91bGRu
J3QgZmFpbCBkZXZpY2UgcHJvYmUganVzdCBiZWNhdXNlIHNvbWVvbmUgcGx1Z3MgaW4gYSBkZXZp
Y2UNCj4gPiB3aXRoIGEgUENJIFBBU0lEIGNhcGFiaWxpdHkgaW50byBhbiBvbGQgQ1BVLi4NCj4g
Pg0KPiA+PiAgIEkgdGhpbmsgaWYgZHJpdmVyIHJldHVybiBlcnJvciwgY29yZSBsYXllciBzaG91
bGQgcmV0cnkgd2l0aG91dA0KPiA+PiAgIElPTU1VX0hXUFRfQUxMT0NfUEFTSUQgZmxhZy4NCj4g
Pg0KPiA+IEJ1dCB0aGlzIG1ha2VzIHNlbnNlLCBhbmQgaXQgc29sdmVzIHRoZSBvdGhlciBwcm9i
bGVtIHdoZXJlIGlmIHRoZQ0KPiA+IGRyaXZlciBkb2Vzbid0IGtub3cgaG93IHRvIHN1cHBvcnQg
SU9NTVVfSFdQVF9BTExPQ19QQVNJRCBpdCB3aWxsDQo+IGFsc28NCj4gPiBmYWlsLiBSZXRyeWlu
ZyB3aXRoIDAgZmxhZ3MgaXMgY29ycmVjdCB0aGVyZSB0b28uDQo+ID4NCj4gPj4gICBPdGhlciBv
cHRpb24gaXMgaW5kaXZpc3VhbCBkcml2ZXIgaW4gZXJyb3IgcGF0aA0KPiA+PiAgIG9mIGRvbWFp
bl9hbGxvY191c2VyIGFsbG9jYXRpbmcgbm9uLVBBU0lEIGNhcGFibGUgZG9tYWluLg0KPiA+DQo+
ID4gVGhpcyB3b3VsZCB0dXJuIElPTU1VX0hXUFRfQUxMT0NfUEFTSUQgaW50byBhIGhpbnQsIHdo
ZXJlIHlvdSBtaWdodA0KPiA+IG5vdCBnZXQgYmFjayBhIFBBU0lEIGNhcGFibGUgZG9tYWluIHR5
cGUuIFRoYXQgc2VlbXMgbGlrZSBhIHNsaWdodGx5DQo+ID4gd29yc2UgZGlyZWN0aW9uDQo+ID4N
Cj4gPj4gICBJIHByZWZlciBmaXJzdCBvcHRpb24uIEp1c3Qgd2FudGVkIHRvIGRpc2N1c3MgYmVm
b3JlIGltcGxlbWVudGluZy4gQW55DQo+IHByZWZlcnJlZA0KPiA+PiAgIG9wdGlvbiBoZXJlPyBP
UiBhbnkgb3RoZXIgYmV0dGVyIHdheSB0byBzb2x2ZSB0aGlzPw0KPiA+DQo+ID4gSSB0aGluayB5
b3Ugc2hvdWxkIGZhaWwgaW4gdGhlIGRyaXZlciB3aXRoIEVPUE5PVFNVUFAgYW5kIHRoZW4gdGhl
DQo+ID4gY29yZSBjb2RlIGFsbG9jYXRpbmcgYSBETUEgZG9tYWluIHNob3VsZCBkZXRlY3QgRU9Q
Tk9UU1VQUCBhbmQgdHJ5DQo+ID4gYWdhaW4gd2l0aCBhIDAgZmxhZ3MuIElzIHRoYXQgd2hhdCB5
b3UgbWVhbiBieSBmaXJzdCBvcHRpb24/DQo+IA0KPiBZZXAhIHRoaXMgaXMgd2hhdCBJIG1lYW50
LiBMZXQgbWUgZml4IHRoZSBjb2RlLg0KPiANCg0KSSdtIGdlbmVyYWxseSBPSyB3aXRoIHRoaXMg
dmVyc2lvbi4gV2l0aCBhYm92ZSBhbmQgb3RoZXJzJyBjb21tZW50cw0KZml4ZWQgdGhlIG5leHQg
dmVyc2lvbiBzaG91bGQgYmUgZ29vZCB0byBnby4NCg==
