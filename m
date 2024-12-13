Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFD342F2F
	for <iommu@lists.linux.dev>; Fri, 13 Dec 2024 02:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734057886; cv=fail; b=OBCAMe89+wPBbdSfeKeB+KqY6w7bNrOeGHJEKIP8JiCHSMsmhDqPKFF71KEsIY4zcOeXIqPbUPi4OSnPY68yrXw3hPg3nNfPi6lHBtzJfJeFHLi6XvaqZ2vagMmY4rCtxDgF3aWmRh9IIPrhyel0MLR8tIHeYmlfLABpCMfjMok=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734057886; c=relaxed/simple;
	bh=aYUT08ggtV/1fsflZdCoXHPqmQWno8CcKP5CIJEeVLU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PwdedXmT2cunIKcw41bA1AD+BMhFZ+0ah0VAq33AVsMXUGaevBXhVsen4sy1KpOI2tfHKZdTo8EcKfKCwFfovIiaxMGCEymi5KoN4hkMigk84PkPP+3jAE2sMG0N30toOvq+z011QwLTXSDDeQA9e/DdaTWUqsQWlwEQbZYGS2w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oFcXqbqK; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oFcXqbqK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734057884; x=1765593884;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=aYUT08ggtV/1fsflZdCoXHPqmQWno8CcKP5CIJEeVLU=;
  b=oFcXqbqKX8dAAktdTnZkI6oeUOllzkBHQbBeLqaW0PSctiaxK8ZkQYXJ
   0nststvI67oS9a6kxrjXC8rgsyUHUBtJHh9y4M11HFdY4HsIHnp46/dom
   YJBEPpjEreFa8LYSxT/dLbgPLuPVGLJ16m6+YLFkt5pRKMdEJ4TLtNLCn
   XnB8pKFifPpnF12HGD7BUl575aaALYWztxqeJgqDAmP2Zyy43bpPM/6CN
   HiWmNQO7mhV/s0einuOaGQh+obOzUY4afLyj/rUmzcJ+3Wmuyisdi6Oad
   8I8Ni0LXm6Mk/hdFwE8GB8T+cDD7Y6We/OQA2s/10l/fvAWz873a3c40g
   Q==;
X-CSE-ConnectionGUID: OxP7PWJTRkiKFfroJPbbLA==
X-CSE-MsgGUID: RHx2MZvZT3Oxxfpf9oqmYw==
X-IronPort-AV: E=McAfee;i="6700,10204,11284"; a="45192459"
X-IronPort-AV: E=Sophos;i="6.12,230,1728975600"; 
   d="scan'208";a="45192459"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2024 18:44:43 -0800
X-CSE-ConnectionGUID: okk5PG+7QqeGQP2TCIf78w==
X-CSE-MsgGUID: r7GhEQTqSKGXuQ9OlVpTUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="97211083"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Dec 2024 18:44:42 -0800
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 12 Dec 2024 18:44:42 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Thu, 12 Dec 2024 18:44:42 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.177)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 12 Dec 2024 18:44:41 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WVMAZ6keK4FfJxQRZB22svg7OsRWVMLhpfBOFwfdjpMVwnpfqGi3zerNC4O365XrcXjsev3Q00tDtqh8tHiZ834fB8emhV50U/vzwR70U8HALF38sp0OnZ9Ov3zmjwR4gv3KdV0ql8+ossz/yRf/6W0ahISKdQdJyWPVphJF0cJMdbrWspkj6AMjDJ1yiQIcsGC8VB7FAmWM2IzlEOUODiOtBc89a2/VM5JkClodXTGga8iRkMnrqkG33UfPj1GybUUBDFaNsKAT51wks2YFxxErNHFHr0BWp/axjXUcvoYYy2yxMtegI1fYsgo6f0vWiTFh5jngAyfnVSX8EAFFCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aYUT08ggtV/1fsflZdCoXHPqmQWno8CcKP5CIJEeVLU=;
 b=Bglf7JLl4pYZ3HJGbKR/m9lzEd8YXe2MD1OVOVOS/XGwUEMWUE2t1BTK3/sLr6yXSm5HxSTGSBlUI5YCRGem9KC86YL79i/wI0wzURkTKJBdq4vcjDDuz5VAjjcqsXtI/VTtpQ2Tgflm2G2C8I5Myi4oL3oJ3voIh4aYiUKZ4v99SStLQ2+qoXCZnSttYSvtZUR9VC6odLWv8cmoYlXtmfafKN0T69Igrtj6bqL/8QEpfJ5HPn4oHMt9lExPtbEROfzaHkRfQAq1VUzaeLSPNYCjUUV850nOSvncblnPsKrNnNDU6CA0Ml8oCyjnjhaAwhl7X7xNoEQuTx1j5YRMsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by PH7PR11MB8250.namprd11.prod.outlook.com (2603:10b6:510:1a8::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.15; Fri, 13 Dec
 2024 02:43:58 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%5]) with mapi id 15.20.8251.008; Fri, 13 Dec 2024
 02:43:58 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Baolu Lu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, "Will
 Deacon" <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, "Liu, Yi L"
	<yi.l.liu@intel.com>
CC: Dan Carpenter <dan.carpenter@linaro.org>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/1] iommu/vt-d: Avoid draining PRQ in sva mm release path
Thread-Topic: [PATCH 1/1] iommu/vt-d: Avoid draining PRQ in sva mm release
 path
Thread-Index: AQHbTDv3EGBJfd9NiU2L1xV26EC/BLLiIMKwgAANDQCAAUsuYA==
Date: Fri, 13 Dec 2024 02:43:58 +0000
Message-ID: <BN9PR11MB5276E04BF8F0C7F4123BE0598C382@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20241212021529.1104745-1-baolu.lu@linux.intel.com>
 <BN9PR11MB5276682CEF64D6D21658893D8C3F2@BN9PR11MB5276.namprd11.prod.outlook.com>
 <27c37e1d-7812-40db-a75f-d1641b5674d8@linux.intel.com>
In-Reply-To: <27c37e1d-7812-40db-a75f-d1641b5674d8@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|PH7PR11MB8250:EE_
x-ms-office365-filtering-correlation-id: 4808f3b3-91f3-4719-7ca6-08dd1b1ffe67
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?YmloWmRvMnFpUzhHZk5HUHNqSGRLWVgyNHE3K1d3NXhiWEQ1ZWJ1VWptRVlU?=
 =?utf-8?B?OStORTZVWUVXdGNGVGxTKytsTy9NQ2RnSE5WUXVWbHk5WFFPTjlVNVpUUnda?=
 =?utf-8?B?UVVoeUZrQUJuRVArek9ISVFtckZwS2NsS21jYW9ZaENPVCs2OXk3ekZYQ3gx?=
 =?utf-8?B?SVBoczIxRmVnZjI4QmFCZ2s0ejRJeGhSeUNIVmtPd0l1L2h3cUxzUVpRZy9F?=
 =?utf-8?B?dnBTTVppazQ2NDEvQ1NSOFQ1cTN0bmFWa0tOWEZnc3JwV0o1bWVxSktMSDB4?=
 =?utf-8?B?TE96WEpndTNQelpjdW5BWURqcHdNMldFNW5QT3doQmdabHFodUZDN1pSR0pB?=
 =?utf-8?B?bkVONU1xVGpYMmJldFJBR0l5L28ya3hYTUVZUE5WSUJPWHhycjF3MC9xcHhu?=
 =?utf-8?B?RWQwd0w3Y21TWHMwK2E0Vlo5R0lYUEVMcmplOXZ5eXkrb0ZXY1I0cHdjeHh1?=
 =?utf-8?B?czlUUnoyNk95SGVJaDhqcXY1UWxzQUU4SEVxRWp5ODFMZzQ0UEJMWGtjcnV6?=
 =?utf-8?B?blpldW9tZmRvYndGRUsyTE5CaVZzOW5JMVJkK0x1eWpRZFMrOVZNQjVMYTVC?=
 =?utf-8?B?WGxDR09UaS9uc1RsQUI0cGNSanJTUUNtU1NNRGZBdDVPeEtyTzdCc1pHVVl4?=
 =?utf-8?B?ZGpiVUVobWJXcExCSmpVNW1rSE1ITTFFM3J3aFVmdDR5UzBCSWlHbVF1cTh3?=
 =?utf-8?B?YVBCa3FGVlozRGxPSDBaLzNqbWx6bzlqVlhTVXd2UkhOQUFTYk45eEkzci9Y?=
 =?utf-8?B?dXhyYTg4a0M1b2F6K2lUZkxtNHd1Q2NvdG9EQlB4RWJTeENYRS9jYThtOTVa?=
 =?utf-8?B?M3lKZUVMQjZneGRwRS9NRTdaMllrYXRmd0MrelB2RXJoQkVJWS9JUVNBZGdY?=
 =?utf-8?B?eldkWDFzMWhtVTdPK2tQb0twNFdEVFJNRVNTTmJ5UGxoVGIvNFpUbEs0dGlN?=
 =?utf-8?B?YkR0emdyRWhGNzBXRGlrWEJqK1hKQU9MZDl3b2pRZHNoM3VhUFFkQm5GRDB5?=
 =?utf-8?B?UWtpZlFFbEJpdVNTcTRiTncvend5S1ZGdU95YXgzQ1hLeWVQVmIzM25jS09U?=
 =?utf-8?B?RSsxc3E2OElWQjVsK3A1Z3kwVHpqbVRuVm9heGJ0Rkx2N3NwQlk4dGE3dDQ0?=
 =?utf-8?B?VzlReHlHNkp1MUNxYlhsd2lZRytCcGZBRGdMU0I5MEF0ZDNMSWQ0MDVZYWY2?=
 =?utf-8?B?RWhONkM3V2pGQ3JPaDdsUlhLNmpyZEFjb2VnR0dFSWJRWDRLdzI1K1AvRzN4?=
 =?utf-8?B?SXdYd3VSUDRtY2pwV0ZXRlZCTGN2RGtwNG5vLzJmV2FidUdRY3FHYkxHaWZZ?=
 =?utf-8?B?VlRENEpuVDdoeWxnL2svZ0VSbXVxRmFDeHljc0dDSWZOaG9HTXNkc1ByOEQv?=
 =?utf-8?B?cTlWQUtHNkk0aUM3WVBYbjkwRDlGMWpjeGc3WGtlZDE0bENGMnY4RmVWeHZ1?=
 =?utf-8?B?Yk5TMXBnSVZRSDB3SFdIUjhOVVJDNVIzSmQzZlgwMi94eDBISTFabWZBYjdE?=
 =?utf-8?B?L0NoOWNlaEZkNi84UlRsZ2VDczJQT2tlYktLcDZyY21YYTRZTTdtSzFNRGtq?=
 =?utf-8?B?QUlObEg2YlJXQzNCaDgwaEpic0xkTk5qdGZWK2xDUzFRQVJLZy9nQzRWUXBZ?=
 =?utf-8?B?Mk9tbmkwNkVPbS9kRnNKS1FtTWtRVmdheXh3UmVZdS90bXNCOUE1bVZmcEtu?=
 =?utf-8?B?UkdjL2JjNFNQYXNZSFF3M0haMFZCWlllb2pXTElYNWZJUk9MU3AvWjl6SDl1?=
 =?utf-8?B?c2toT2N5UUdtQjRIN2xqd0h5M2YzbUNEdHVDdjVHcWpRUjlFaXBkaFhNQnI5?=
 =?utf-8?B?MG4xandtd2JjSFUwY25mWkUrOHdzczV1SEpobWVPaGVOdlo4VmpxT1Yrb0Y5?=
 =?utf-8?B?dUpoaEJoQ0xUTDl4ZGtZeXMrU1BrWFNncGRkczZvckhzUGc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dW9hUi8yQjArNGN0V1pvZUhVSS9aUGNlMTdianV6ekZYYU5SSjNMN0tQYm8x?=
 =?utf-8?B?RWlGaVVyV1Bvd3o3NmNETm53RjlCS3RWZ1RDRlo4MVMxMU9tT1VvME0zanpX?=
 =?utf-8?B?MHo1S1grZFVUb2ZPalRmOXJpRkRlanQ3M3pEa2ZISlduMGVvZVdGQjUyVXd4?=
 =?utf-8?B?SVVoWmFmSVBtM1RuZHdPM1QyUFI2eTQwaXh5R05ZVEM0YnlIU1FDdFd1Z0FM?=
 =?utf-8?B?SXEvNEVSa25ueUZBdjNVemN4QWFoeVhTa2w3S2dVT3pYQ2hJaUpqMUxoWVEz?=
 =?utf-8?B?VDRXUy9YZWFmamU0bW9GRWxsYnRZUjBoeVdrOTRwUmpVdU5rWFZFV1BwWGU2?=
 =?utf-8?B?Rmk2K0NtTFpCK3lGNm5uQVdtc0Nxdi9PcENoYUdtYS9VYUVDcWpQbUlYbHBq?=
 =?utf-8?B?c0huVDJ2NlZyZi83QUhrY3FCZXp3VFd6ZGRLd0Y3czRaU245S3Y3YTFuL3VM?=
 =?utf-8?B?UXd0MWljYWszV0RudW9pU0IvZXk0OFRwYWluSWc2aHVLSnVSRjFXUG55M3FX?=
 =?utf-8?B?YW9wYk5GWmhXa3VvWWMwS1RoblFzeERJYmUzOTEraHhUL0pxbG5FTHdxb0x4?=
 =?utf-8?B?enNkTjNTUUM4RkNPTlMvRG8wOE8vQmJQaHBKeEhCSVFxaFl0RjNhM3ZDSjh6?=
 =?utf-8?B?RzgvZWlaZkxQS2dTLzdrSXN4ZzV4WE1DdUtLd3pTM1Mzc2djWjdwd3hGK21r?=
 =?utf-8?B?S0oybEVHb3h6RUk5bERTV3hDZzRQbGJhWVF6cG9EOElMT210VlhtMU12TExC?=
 =?utf-8?B?UzErajZEMDNDNldieDQwNEFuazRzcUlsWE16ZzVsRnBLZXVmT2pFVUI3RG9u?=
 =?utf-8?B?UWpnSXVCRFpVSWlBc0JsWkg5djhZWHQ4MUx5a1U1QnVTanZjK1NuQWJnOGFW?=
 =?utf-8?B?SXJSTnZPOGt1L2J5WnkraFY1b014azZIeWNQd3VLVkQvZ1h5dHcva0E5RTBQ?=
 =?utf-8?B?d1RGZXQrUlIrYmF1cnR4RE5jM1JKS2Fla2V0V1pFckhFYUE2T2J2V1FyYmZa?=
 =?utf-8?B?U0FyeVV0TXdxZU9hL0VmWEg5NWphRTdudHZxTkZEQUNhU1gwTXd0RG9tMFU2?=
 =?utf-8?B?WjdlYmtCdlZ6QmFSVEJ1d2pLNVJNTHJkMDBKK2xSQ1QwODdSc3BKeVQvempV?=
 =?utf-8?B?aEdkb29jbkpvVjA0VWo0U1o2R0FBci9QWERRUVo3bGtoQStFOFdjc0xBUHdW?=
 =?utf-8?B?Yk9PN2pHOFI5OXpEQzR4Q0duQ3NwZm5LVXNXeTY2cGMwNUJHYzFVWHoycTVk?=
 =?utf-8?B?YTd4RWdMWVEyREhIeUdmSHJpbCtldCtUZXJCU3gyK3hRT3BTU2VPeUZOTkU3?=
 =?utf-8?B?ZmE1YTdmQmpLKzdxMVhSdFd5ZnRYRXVFS1pwZE92SVhOdmMvcjVVcnZJN092?=
 =?utf-8?B?c1ZXZnA1T093Q1VldS94RGNEdjFrdTRTK1hoWWpTSGs2dGl2WjU0Yi9lMlgy?=
 =?utf-8?B?NjRtZTd6eXpFWWxTU21GOGF1UmhNanRnTytPbTBoQXA2UWhuN1JUUkRFMStV?=
 =?utf-8?B?dW9WRndteWJPVE9GVGNuTTkwdmJSTlBaakRPc2U2Wm1YblBQbUpZWEs3SzFQ?=
 =?utf-8?B?M2hydGxpZG92NWs2RGJSNVlQVzVGV3VSKzRjNzhrK2pQcXNCOE8vRDUvQk5U?=
 =?utf-8?B?RHRiQlhXeVppS3lDdDBEUCtRb0JMMnFFWGF1dGQ0V2FKVlc2dEtqb2dlVHRl?=
 =?utf-8?B?bnorV1MyRXgrMWVkQmkrWUgxUkdVai9JMGNkcFQ0TGpsOGgybVkwNGtvVjRi?=
 =?utf-8?B?eThySTd2NGZCWGYzc0lFdkJRNThMRC9ONCtJM21FbUx5WFV4dkhxcDd2MjRO?=
 =?utf-8?B?aTVvc1RFTjA3aEpmN3dkTkoxalFqWDdxUTRoMGNjUGdkS3RyalRvSk9vNnRB?=
 =?utf-8?B?b0xPQ0x0d052R29zak5EYTN6UFBwbllQRDl4YUhJbVJkaHBSc3MxOERJdXFh?=
 =?utf-8?B?Nm5rTDZxckhqMHBZWmJIMDB5T0dnWjFOVkNIaWRhMkRCNEdKODJ0c3JOQVVU?=
 =?utf-8?B?SnhvYUtHb1dUVlZsVUlBUkZQTjZRS0tKcjIyZlBOM24rbG8xcVlTbEw4VlRF?=
 =?utf-8?B?RW9hc2ZQS2tHekJZbGcwQXZMT2YrRmo5ejNGQUVRdXpLNHQ3SGpSMUVwU0s0?=
 =?utf-8?Q?NfAmPq+2yugLMDAnQUBUspSgK?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 4808f3b3-91f3-4719-7ca6-08dd1b1ffe67
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2024 02:43:58.2008
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2XaV4yJkIjkiJ+r6qOvUh1zgH+ITJV7aB9YQC2rCsimhgFOp3ESHVlrVf036+H9MRXh3Cy7uT273iVNIylcrzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8250
X-OriginatorOrg: intel.com

PiBGcm9tOiBCYW9sdSBMdSA8YmFvbHUubHVAbGludXguaW50ZWwuY29tPg0KPiBTZW50OiBUaHVy
c2RheSwgRGVjZW1iZXIgMTIsIDIwMjQgMjo1OCBQTQ0KPiANCj4gT24gMjAyNC8xMi8xMiAxNDox
OCwgVGlhbiwgS2V2aW4gd3JvdGU6DQo+ID4+IEZyb206IEx1IEJhb2x1PGJhb2x1Lmx1QGxpbnV4
LmludGVsLmNvbT4NCj4gPj4gU2VudDogVGh1cnNkYXksIERlY2VtYmVyIDEyLCAyMDI0IDEwOjE1
IEFNDQo+ID4+DQo+ID4+IFdoZW4gYSBQQVNJRCBpcyB1c2VkIGZvciBTVkEgYnkgYSBkZXZpY2Us
IGl0J3MgcG9zc2libGUgdGhhdCB0aGUgUEFTSUQNCj4gPj4gZW50cnkgaXMgY2xlYXJlZCBiZWZv
cmUgdGhlIGRldmljZSBmbHVzaGVzIGFsbCBvbmdvaW5nIERNQSByZXF1ZXN0cyBhbmQNCj4gPj4g
cmVtb3ZlcyB0aGUgU1ZBIGRvbWFpbi4gVGhpcyBjYW4gb2NjdXIgd2hlbiBhbiBleGNlcHRpb24g
aGFwcGVucyBhbmQNCj4gPj4gdGhlDQo+ID4+IHByb2Nlc3MgdGVybWluYXRlcyBiZWZvcmUgdGhl
IGRldmljZSBkcml2ZXIgc3RvcHMgRE1BIGFuZCBjYWxscyB0aGUNCj4gPj4gaW9tbXUgZHJpdmVy
IHRvIHVuYmluZCB0aGUgUEFTSUQuDQo+ID4+DQo+ID4+IFRoZXJlJ3Mgbm8gbmVlZCB0byBkcmFp
biB0aGUgUFJRIGluIHRoZSBtbSByZWxlYXNlIHBhdGguIEluc3RlYWQsIHRoZQ0KPiBQUlENCj4g
Pj4gd2lsbCBiZSBkcmFpbmVkIGluIHRoZSBTVkEgdW5iaW5kIHBhdGguDQo+ID4+DQo+ID4+IFVu
Zm9ydHVuYXRlbHksIGNvbW1pdCBjNDNlMWNjZGViZjIgKCJpb21tdS92dC1kOiBEcmFpbiBQUlFz
IHdoZW4NCj4gPj4gZG9tYWluDQo+ID4+IHJlbW92ZWQgZnJvbSBSSUQiKSBjaGFuZ2VkIHRoaXMg
YmVoYXZpb3IgYnkgdW5jb25kaXRpb25hbGx5IGRyYWluaW5nDQo+IHRoZQ0KPiA+PiBQUlEgaW4g
aW50ZWxfcGFzaWRfdGVhcl9kb3duX2VudHJ5KCkuIFRoaXMgY2FuIGxlYWQgdG8gYSBwb3RlbnRp
YWwNCj4gPj4gc2xlZXBpbmctaW4tYXRvbWljLWNvbnRleHQgaXNzdWUuDQo+ID4+DQo+ID4+IFNt
YXRjaCBzdGF0aWMgY2hlY2tlciB3YXJuaW5nOg0KPiA+Pg0KPiA+PiAJZHJpdmVycy9pb21tdS9p
bnRlbC9wcnEuYzo5NSBpbnRlbF9pb21tdV9kcmFpbl9wYXNpZF9wcnEoKQ0KPiA+PiAJd2Fybjog
c2xlZXBpbmcgaW4gYXRvbWljIGNvbnRleHQNCj4gPj4NCj4gPj4gVG8gYXZvaWQgdGhpcyBpc3N1
ZSwgcHJldmVudCBkcmFpbmluZyB0aGUgUFJRIGluIHRoZSBTVkEgbW0gcmVsZWFzZSBwYXRoDQo+
ID4+IGFuZCByZXN0b3JlIHRoZSBwcmV2aW91cyBiZWhhdmlvci4NCj4gPj4NCj4gPj4gRml4ZXM6
IGM0M2UxY2NkZWJmMiAoImlvbW11L3Z0LWQ6IERyYWluIFBSUXMgd2hlbiBkb21haW4gcmVtb3Zl
ZA0KPiBmcm9tDQo+ID4+IFJJRCIpDQo+ID4+IFJlcG9ydGVkLWJ5OiBEYW4gQ2FycGVudGVyPGRh
bi5jYXJwZW50ZXJAbGluYXJvLm9yZz4NCj4gPj4gQ2xvc2VzOmh0dHBzOi8vbG9yZS5rZXJuZWwu
b3JnL2xpbnV4LWlvbW11L2M1MTg3Njc2LTJmYTItNGUyOS05NGUwLQ0KPiA+PiA0YTI3OWRjODhi
NDlAc3RhbmxleS5tb3VudGFpbi8NCj4gPj4gU2lnbmVkLW9mZi1ieTogTHUgQmFvbHU8YmFvbHUu
bHVAbGludXguaW50ZWwuY29tPg0KPiA+PiAtLS0NCj4gPj4gICBkcml2ZXJzL2lvbW11L2ludGVs
L3Bhc2lkLmMgfCAzICsrLQ0KPiA+PiAgIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyks
IDEgZGVsZXRpb24oLSkNCj4gPj4NCj4gPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaW9tbXUvaW50
ZWwvcGFzaWQuYyBiL2RyaXZlcnMvaW9tbXUvaW50ZWwvcGFzaWQuYw0KPiA+PiBpbmRleCAwZjJh
OTI2ZDNiZDUuLjViN2Q4NWYxZTE0MyAxMDA2NDQNCj4gPj4gLS0tIGEvZHJpdmVycy9pb21tdS9p
bnRlbC9wYXNpZC5jDQo+ID4+ICsrKyBiL2RyaXZlcnMvaW9tbXUvaW50ZWwvcGFzaWQuYw0KPiA+
PiBAQCAtMjY1LDcgKzI2NSw4IEBAIHZvaWQgaW50ZWxfcGFzaWRfdGVhcl9kb3duX2VudHJ5KHN0
cnVjdA0KPiA+PiBpbnRlbF9pb21tdSAqaW9tbXUsIHN0cnVjdCBkZXZpY2UgKmRldiwNCj4gPj4g
ICAJCWlvbW11LT5mbHVzaC5mbHVzaF9pb3RsYihpb21tdSwgZGlkLCAwLCAwLA0KPiA+PiBETUFf
VExCX0RTSV9GTFVTSCk7DQo+ID4+DQo+ID4+ICAgCWRldnRsYl9pbnZhbGlkYXRpb25fd2l0aF9w
YXNpZChpb21tdSwgZGV2LCBwYXNpZCk7DQo+ID4+IC0JaW50ZWxfaW9tbXVfZHJhaW5fcGFzaWRf
cHJxKGRldiwgcGFzaWQpOw0KPiA+PiArCWlmICghZmF1bHRfaWdub3JlKQ0KPiA+PiArCQlpbnRl
bF9pb21tdV9kcmFpbl9wYXNpZF9wcnEoZGV2LCBwYXNpZCk7DQo+ID4+ICAgfQ0KPiA+Pg0KPiA+
IEFzIGEgcmVncmVzc2lvbiBmaXg6DQo+ID4NCj4gPiBSZXZpZXdlZC1ieTogS2V2aW4gVGlhbjxr
ZXZpbi50aWFuQGludGVsLmNvbT4NCj4gPg0KPiA+IEJ1dCBJIGRvdWJ0IHdoZXRoZXIgaXQncyB3
b3JraW5nIGFzIGV4cGVjdGVkLiBBY2NvcmRpbmcgdG8gdGhlDQo+ID4gZGVzY3JpcHRpb24gYW5k
IGNvZGUsIGludGVsX3Bhc2lkX3RlYXJfZG93bl9lbnRyeSgpIGlzIGNhbGxlZA0KPiA+IHR3aWNl
OiB0aGUgMXN0IGluIHRoZSBtbSByZWxlYXNlIHBhdGggYW5kIHRoZSAybmQgaW4gdGhlIHVuYmlu
ZA0KPiA+IHBhdGguIFBSUSBkcmFpbmluZyBpcyBza2lwcGVkIGluIHRoZSBmb3JtZXIuDQo+ID4N
Cj4gPiBCdXQgaW50ZWxfcGFzaWRfdGVhcl9kb3duX2VudHJ5KCkgaGFzIGEgY2hlY2sgYXQgdGhl
IGJlZ2lubmluZzoNCj4gPg0KPiA+IAlwdGUgPSBpbnRlbF9wYXNpZF9nZXRfZW50cnkoZGV2LCBw
YXNpZCk7DQo+ID4gCWlmIChXQVJOX09OKCFwdGUpIHx8ICFwYXNpZF9wdGVfaXNfcHJlc2VudChw
dGUpKSB7DQo+ID4gCQlzcGluX3VubG9jaygmaW9tbXUtPmxvY2spOw0KPiA+IAkJcmV0dXJuOw0K
PiA+IAl9DQo+ID4NCj4gPiBUaGUgMXN0IGludm9jYXRpb24gYWxyZWFkeSBjbGVhcnMgdGhlIHBh
c2lkIGVudHJ5IHdpdGggRlBEIHNldC4NCj4gPg0KPiA+IFRoZW4gdGhlIDJuZCBpbnZvY2F0aW9u
IHdpbGwgcmV0dXJuIGVhcmx5IGluc3RlYWQgb2YgbW92aW5nIHRvDQo+ID4gdGhlIHBvaW50IG9m
IFBSUSBkcmFpbmluZy4NCj4gDQo+IFlvdSBhcmUgcmlnaHQuDQo+IA0KPiBXZSBuZWVkIHRvIGNs
ZWFyIHRoZSBGYXVsdCBQcm9jZXNzaW5nIERpc2FibGVkIGJpdCBpbiB0aGUgdW5iaW5kIHBhdGgg
aWYNCj4gaXQgaXMgc2V0IGFuZCBkcmFpbiB0aGUgUFJRLiBXaGF0IGFib3V0IGJlbG93IGNvZGU/
DQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9pb21tdS9pbnRlbC9wYXNpZC5jIGIvZHJpdmVy
cy9pb21tdS9pbnRlbC9wYXNpZC5jDQo+IGluZGV4IDViN2Q4NWYxZTE0My4uNDViZDFiNjg5Njc0
IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2lvbW11L2ludGVsL3Bhc2lkLmMNCj4gKysrIGIvZHJp
dmVycy9pb21tdS9pbnRlbC9wYXNpZC5jDQo+IEBAIC0yNDQsMTEgKzI0NCwyNSBAQCB2b2lkIGlu
dGVsX3Bhc2lkX3RlYXJfZG93bl9lbnRyeShzdHJ1Y3QNCj4gaW50ZWxfaW9tbXUgKmlvbW11LCBz
dHJ1Y3QgZGV2aWNlICpkZXYsDQo+IA0KPiAgIAlzcGluX2xvY2soJmlvbW11LT5sb2NrKTsNCj4g
ICAJcHRlID0gaW50ZWxfcGFzaWRfZ2V0X2VudHJ5KGRldiwgcGFzaWQpOw0KPiAtCWlmIChXQVJO
X09OKCFwdGUpIHx8ICFwYXNpZF9wdGVfaXNfcHJlc2VudChwdGUpKSB7DQo+ICsJaWYgKFdBUk5f
T04oIXB0ZSkpIHsNCj4gICAJCXNwaW5fdW5sb2NrKCZpb21tdS0+bG9jayk7DQo+ICAgCQlyZXR1
cm47DQo+ICAgCX0NCj4gDQo+ICsJaWYgKCFwYXNpZF9wdGVfaXNfcHJlc2VudChwdGUpKSB7DQoN
CmFkZCBhIGNvbW1lbnQgaGVyZS4gb3RoZXJ3aXNlIGxvb2tzIGdvb2QNCg0KPiArCQlpZiAoIXBh
c2lkX3B0ZV9pc19mYXVsdF9kaXNhYmxlZChwdGUpKSB7DQo+ICsJCQlXQVJOX09OKFJFQURfT05D
RShwdGUtPnZhbFswXSkgIT0gMCk7DQo+ICsJCQlzcGluX3VubG9jaygmaW9tbXUtPmxvY2spOw0K
PiArCQkJcmV0dXJuOw0KPiArCQl9DQo+ICsNCj4gKwkJcGFzaWRfY2xlYXJfZW50cnkocGUpOw0K
PiArCQlzcGluX3VubG9jaygmaW9tbXUtPmxvY2spOw0KPiArCQlpbnRlbF9pb21tdV9kcmFpbl9w
YXNpZF9wcnEoZGV2LCBwYXNpZCk7DQo+ICsNCj4gKwkJcmV0dXJuOw0KPiArCX0NCj4gKw0KPiAg
IAlkaWQgPSBwYXNpZF9nZXRfZG9tYWluX2lkKHB0ZSk7DQo+ICAgCXBndHQgPSBwYXNpZF9wdGVf
Z2V0X3BndHQocHRlKTsNCj4gICAJaW50ZWxfcGFzaWRfY2xlYXJfZW50cnkoZGV2LCBwYXNpZCwg
ZmF1bHRfaWdub3JlKTsNCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaW9tbXUvaW50ZWwvcGFzaWQu
aCBiL2RyaXZlcnMvaW9tbXUvaW50ZWwvcGFzaWQuaA0KPiBpbmRleCAwODJmNGZlMjAyMTYuLjY2
OGQ4ZWNlNmIxNCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9pb21tdS9pbnRlbC9wYXNpZC5oDQo+
ICsrKyBiL2RyaXZlcnMvaW9tbXUvaW50ZWwvcGFzaWQuaA0KPiBAQCAtNzMsNiArNzMsMTIgQEAg
c3RhdGljIGlubGluZSBib29sIHBhc2lkX3B0ZV9pc19wcmVzZW50KHN0cnVjdA0KPiBwYXNpZF9l
bnRyeSAqcHRlKQ0KPiAgIAlyZXR1cm4gUkVBRF9PTkNFKHB0ZS0+dmFsWzBdKSAmIFBBU0lEX1BU
RV9QUkVTRU5UOw0KPiAgIH0NCj4gDQo+ICsvKiBHZXQgRlBEKEZhdWx0IFByb2Nlc3NpbmcgRGlz
YWJsZSkgYml0IG9mIGEgUEFTSUQgdGFibGUgZW50cnkgKi8NCj4gK3N0YXRpYyBpbmxpbmUgYm9v
bCBwYXNpZF9wdGVfaXNfZmF1bHRfZGlzYWJsZWQoc3RydWN0IHBhc2lkX2VudHJ5ICpwdGUpDQo+
ICt7DQo+ICsJcmV0dXJuIFJFQURfT05DRShwdGUtPnZhbFswXSkgJiBQQVNJRF9QVEVfRlBEOw0K
PiArfQ0KPiArDQo+ICAgLyogR2V0IFBHVFQgZmllbGQgb2YgYSBQQVNJRCB0YWJsZSBlbnRyeSAq
Lw0KPiAgIHN0YXRpYyBpbmxpbmUgdTE2IHBhc2lkX3B0ZV9nZXRfcGd0dChzdHJ1Y3QgcGFzaWRf
ZW50cnkgKnB0ZSkNCj4gICB7DQo+IA0KPiBUaGFua3MsDQo+IGJhb2x1DQo=
