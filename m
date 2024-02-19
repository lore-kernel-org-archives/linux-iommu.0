Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF919163
	for <iommu@lists.linux.dev>; Mon, 19 Feb 2024 00:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708301588; cv=fail; b=UcpoZJulRyTSkSHEfNDoQIzXag3L6FIjMJRbhooHV2sT1Vp4ZoAGYTaGKmmbvR8+2RrkpuUadUMoWfxEJ4Lv+Il1whWodgqIj0aA6hWjSJB3F9QFEPqtjxzbrgPTuIf07wkAiCoTcv+hs7r2lke2KJN8D3e7WV3QTCurePZQL0Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708301588; c=relaxed/simple;
	bh=/0j2GozWN0Vh1X14SkQkIQwSsq0QZBumptUGGEJBLj4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kPsAPLFO2SmbzDbk8zo1bkkXcgFEkmOtVv9FfoypGkdvcrj8JbrlabRGFkVBOUqj8a+orPYeHewQrjDx+aBKjzLUfFGnibLXfxVu8nb5oZG2y0X2LUEwtmb8OpcjDzmLgCL1PUfE96KqWt+LVA0Hl2yWOOT5Xs5ixOlQro5tdWA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ix4NM9s6; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ix4NM9s6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708301585; x=1739837585;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/0j2GozWN0Vh1X14SkQkIQwSsq0QZBumptUGGEJBLj4=;
  b=ix4NM9s6fxSxo/+bM7S+4fej0/0fS/6WnxxD57CSdUrafP5wI4pZFCGH
   tIXDY8s1Qr9xjFYHITKUcgcqkRNV45iPib/ErQPieoPBKFmAUrsxZZ8Mm
   8U83tU6WlM+Z+N9WFuVHs3dxHs1useyto0w4nrZNoUHVSAsz0Yg81bVjJ
   KYP7rIuttYB0zg+cFSwwvRA8SaekTavvHyth2w1Fp+gBPg7CVJEYoakqE
   GPw4zjTsWOrT2MqUqQbzWSLWmyeEA28z0JD0BUqTolV9qFZNxOQwfYMjm
   NR9XPporqNd+mfx4eyGlhDp0oBVlzIlhhezNedSrr17yel9mXo+tpaXro
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10988"; a="19897720"
X-IronPort-AV: E=Sophos;i="6.06,169,1705392000"; 
   d="scan'208";a="19897720"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2024 16:13:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,169,1705392000"; 
   d="scan'208";a="8948218"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Feb 2024 16:13:05 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 18 Feb 2024 16:13:04 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 18 Feb 2024 16:13:03 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Sun, 18 Feb 2024 16:13:03 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sun, 18 Feb 2024 16:13:03 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O0iQ7fmAVBhMkTeAJM2tSTKmQ4dp9CKGcvSE0RZ4lVp6PEZhDPtV6nd4zPLK94g81NmZfi3I170DiqX6sHyHLkQJzQ8TkAk8H4FOsnSZaKgvwkH7SQUaU0m0ZkIkq74m3nuOnwUMAvDAGd7IEL2fICB7ScRZxP1InIcbRKGw4JU7JyKSw9L9Y5wCGW1MCGFOR7oTpLrvwIFYJV2lmQo+/hdrEjS7AZW+MrHQpIh7GsKkfSBa0oFf37Psta1LD3ppYs2yZm6xqxEK7bpupbiFNxA8WtdzpPGaz/okF99tl869f75MCYzfgPKe6u1v7rZJqbYcPprUFNOA9kodVdW7Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/0j2GozWN0Vh1X14SkQkIQwSsq0QZBumptUGGEJBLj4=;
 b=cXFRezXFOLmTgYIDAEjTiyScuD1pDlbmXebJEplRZaWVMmoW7U4Pm1nlhWkEJJGJsT6rHJPAkxOYIoFUuqWM2zdDZxzzptBeZBrdhSXNh5/DoeyDrns6zXG2tfgepr1ANkr+jJ2MTIViOszw+lIo7UBmmAJ499ahlJ/I0R0gRaKkZWx5NX/sGTQ31HD/SChb5pYs2N+j0Ep7EZanHoWXIjlFQb4bq4PURBHQEAIhDenWjZTH3vQitX3VHKSDx0fMczOkV1bVtMUPxTsE/MxlzpXR2tTCgcL2dlk/ZXIQtJq2xLdVCo2Ey4bV/zysC3+9wN4lAGVuuTgQ7j4B6t+yng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW5PR11MB5881.namprd11.prod.outlook.com (2603:10b6:303:19d::14)
 by CO1PR11MB4819.namprd11.prod.outlook.com (2603:10b6:303:91::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.38; Mon, 19 Feb
 2024 00:13:02 +0000
Received: from MW5PR11MB5881.namprd11.prod.outlook.com
 ([fe80::2e1e:4cf0:f8ea:a9c7]) by MW5PR11MB5881.namprd11.prod.outlook.com
 ([fe80::2e1e:4cf0:f8ea:a9c7%4]) with mapi id 15.20.7292.036; Mon, 19 Feb 2024
 00:13:02 +0000
From: "Zhang, Tina" <tina.zhang@intel.com>
To: Baolu Lu <baolu.lu@linux.intel.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>
CC: "Tian, Kevin" <kevin.tian@intel.com>
Subject: RE: [PATCH 08/11] iommu/vt-d: Add domain_type_is_sva helper function
Thread-Topic: [PATCH 08/11] iommu/vt-d: Add domain_type_is_sva helper function
Thread-Index: AQHaSBkzqbCKfO9jvkuKF77T3CZgrrDdno6AgDNgpYA=
Date: Mon, 19 Feb 2024 00:13:01 +0000
Message-ID: <MW5PR11MB588131E52514CC9B552DCA7F89512@MW5PR11MB5881.namprd11.prod.outlook.com>
References: <20240116011146.18645-1-tina.zhang@intel.com>
 <20240116011146.18645-9-tina.zhang@intel.com>
 <eb13b149-729b-4b22-a6df-63e73ecd73a2@linux.intel.com>
In-Reply-To: <eb13b149-729b-4b22-a6df-63e73ecd73a2@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW5PR11MB5881:EE_|CO1PR11MB4819:EE_
x-ms-office365-filtering-correlation-id: 0fec8b4a-8e37-4d06-cdb3-08dc30df8960
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dd2ArwlqxewIu3glRjNVjdplhkBMSgYZjpu34OUPHFKXgX8U5fXUNNzwYwKMGdFrUcKTUQjOb39zrsrS5rPRhfhnvepkxog3M3NNTegEvHUZb4F+NlADpNr+PDwsL/ULhfC27M0o6X/EKHPfMvlj2CMjXcNGtMVf7nHq/Fdu9tFh5exjUXPF+h/CmsMIYQoQKS/OEja9/mLtjCkMzIv4Gqm+F5ztdF3mTJM33ETEjlyVLeEV+tDvreQjZyJ94KwX+NFkmyv75RCEMY7IXyWlDsgojzY9vWBhlrdi0RvHQt9hBgX0EGRJyXPeJVBklVGb6rMY6EOAyudzi3d6gnQkWVV+Cnnxuw31TZuDqO7HkXMa/tAJK1juyw88NKfUTw84Djx9RKtgX/Olis7rN8EHRLtKrmR3rveIrtPiSrU0risV8eACyeYSUdSt2BfdQ30TiWwDniniNzR6/W1GTicWGDL+7DTAyl0HuHOl7n3goOkiV2LJMMhQRqP/hYX2KB9YgYcWbHuVG2heIcUSIpdCckI1HVRCoocVbHNdjAF5/ktIotFqGBGr2Jjhr6UEA322aOQSy9HVK7ed/gxsoS5p9G4kjKO82RPiYIIwL8EK65jTfzRISM/iiAd9GgpH4x7+
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5881.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(39860400002)(346002)(376002)(136003)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(66946007)(76116006)(5660300002)(2906002)(52536014)(64756008)(66446008)(66476007)(8676002)(8936002)(4326008)(55016003)(66556008)(33656002)(86362001)(122000001)(82960400001)(38070700009)(38100700002)(41300700001)(83380400001)(71200400001)(26005)(6506007)(7696005)(53546011)(478600001)(110136005)(316002)(9686003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L1dqTHFCMDlSZksxbEgvdlY2dSs5TitXa1pFV0xwSW9FVlZqVzNVWDUzSmpZ?=
 =?utf-8?B?RWl1K0gvbmpkQmI5UytVRTBPUUtmNzg3S0NvN2FHbWkxTUtmYVBZUGx0dGpp?=
 =?utf-8?B?SlUzeVJnQmpzMnlUb0s1WXhaM0xrMno1MXl1L0ZKNXdMUllVTHpvc0dsNEg4?=
 =?utf-8?B?ZXNvWU01VVdPSkV0bTkrU2UrcVdjYndtK3FVMTZveC9XbVl4Vml1RE45VXZY?=
 =?utf-8?B?L2VaM01GOFQwQktNS2RVZ1lweTRKM2U1UTNScmZXcGZNNEI4SzE0SEVEWVBV?=
 =?utf-8?B?ODY3TnJkUFdYMHV1MnR5NTZRcDY5UjcveEJpMGs4QUdXN05XVHcyeFFBR3Rn?=
 =?utf-8?B?ME9FNTV3RUVXRDkxc1Ric1NOeUNPaDR2cURINm1wUDF2V0s5elVXTCtkR1Ez?=
 =?utf-8?B?Ty84cDRjODFXYldwd2JVaElsWDFZRHVlLzdPRGd0b1E2VzZNalpHMUNwZUZY?=
 =?utf-8?B?YW5STVMyaG5SbWttZVIrSWdRUlRDZlBOZE5TWldIM2Q2VlIxK2dxYUk2QStZ?=
 =?utf-8?B?eHVienI4Y0pIdnQyU0phSEcreXliK3JqVXd3VjR2NkRlQUpCRm90a0NGbDdy?=
 =?utf-8?B?c2dZcnpYdGcxUFhUYko0TFNra0REMWdTblhzRUdBL1RGMHJqbFNOMFErUisz?=
 =?utf-8?B?YjZ0Z3YvN3pKWXcyNXF0MlpjYnNUMDIweUVnU1JkeXg3V3FPTkc3VDJkdlZ0?=
 =?utf-8?B?dmhlT0I3RHJydXM1NEZTQzZtblJXSGp4bUpKL1BGSWJ1YXVKd2dqa0tHR0FD?=
 =?utf-8?B?bTcvUldqNVlTbG45MUM4NGRDbVVRaFVQZFI1UGlBckpjcDZXMXdpbnM2bVdu?=
 =?utf-8?B?T21HYmxyQjNMZDQ2R0FWTWFKYU8xVGpWQVlQWU5UeXBobjhXTGY1aEpVbWxM?=
 =?utf-8?B?YTlaRnQyQVQwUTNOdDhWNW1tK25NY0tTeTY0NUhDWUoyeiszUHZBeW5mSWFv?=
 =?utf-8?B?VUE0YThoVml0c25CRGsrSDNRVTNiYWdoT1EzbGsxa2VwUWd0eDNtU3JzZmtN?=
 =?utf-8?B?QWZ0Q05BdnlHSTdhVUVBTE03citlcmllNnJFWWQ0d3diVDdvb0RZNXF0ejQ4?=
 =?utf-8?B?cUxsR213MXpYSnV6QTZCUno1bnBjMGxQM1AxTmxMK3cvLzJwTzdRTExEMnQ2?=
 =?utf-8?B?Rk1CV3A0OGQzUUM0OElqZndBeHZKQzFNbU1HbWMzekxqVWc3ZUlIcUcvTjl6?=
 =?utf-8?B?MXJVSCt0dzVkRUpONHN6QUE2ZnRJdG1xd0Y1VWFsdVp3Rk15NFlQREl0b1A0?=
 =?utf-8?B?V1k0Nnh3K0dwOVdKUUJvV2FTUHBmd3ozb1RMbDRsSXl2bXdsSms5UkVyL05Q?=
 =?utf-8?B?YWVRaEZ5WkFjT0FYNFpUSWI5OWVrSS9Ubm5aRno5QVhPNEp3U1I5cXdtQU45?=
 =?utf-8?B?ckJEczZsNWgxM0dQZkgxcFBkc0NMeFVySUl2MTRiUFppeVNBdzNWMmZMK1pw?=
 =?utf-8?B?RDlDT1RZNy9nYzJRK3dtNGF1elh4RGtPSXFET0ZuTVdzVjQ5eVV6UmhkMzJk?=
 =?utf-8?B?ZXJUUml1RXpZeUhaZHNFRTl3OHNrWnpPMnVXN3ptWjF5dm5aUWRja296dTFk?=
 =?utf-8?B?dk55OURUalMreGovakVvem9vZ1R5WFlocURIUmhnQlV2Ymc5cXRpa3JvVEV4?=
 =?utf-8?B?Q29BTzk0UERtUlM4UlB5S3lKeDZ3TWlsVnhHY1NMRUk5TDc3a08ycXEvZTIy?=
 =?utf-8?B?bmc1VHkyaXVwYVhJYWFLRGpVaEJWc2hRTVIyeHpMemE2WDV4YUFwZXo1VTJh?=
 =?utf-8?B?V3NleEJENkR4RFB5TEJSL1FOOFVIMGh3OC9tbE9DQUZHeXV2OG1PTktmclly?=
 =?utf-8?B?SUx6R2phdHhEQ292ZjFrUmd4WDkvNHhvcDVmVnRLTUtQRFNwT1lFZmZhNUxN?=
 =?utf-8?B?TWN6ank5dHd4S0s5QlpWSUp3dE43SVY5NCtuU09VaFczdFpQakJOQ1g1RDZl?=
 =?utf-8?B?TkRkSjd3RGlPdjlOTFIvcTBBOUEzZm1DVHVtaU1zWkI2akxFbm1meHNzZHZ0?=
 =?utf-8?B?VXBRMitocEF1U01iZUc3SmhyaWRpNVpyOE4xVTREL3pLT2drN2hDNzJ2UVpk?=
 =?utf-8?B?TzdwKzN5bEdLWmdOQXA4VTluODA2blJkMGpaUHpGMlBPS1NYbmFEVENSV3p5?=
 =?utf-8?Q?fcIssu8FfxwcKUFd7WKtHOZ60?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW5PR11MB5881.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fec8b4a-8e37-4d06-cdb3-08dc30df8960
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2024 00:13:01.9818
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UIMkz861gzK8HT3T0zTEpnab3B8LkhQGfrzbgA9D407uxD5NVhSpDMt8UrzY6ON3zv34uJCrUPiYMkGdOEg4sQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4819
X-OriginatorOrg: intel.com

SGkgQmFvbHUsDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQmFvbHUg
THUgPGJhb2x1Lmx1QGxpbnV4LmludGVsLmNvbT4NCj4gU2VudDogV2VkbmVzZGF5LCBKYW51YXJ5
IDE3LCAyMDI0IDM6MzMgUE0NCj4gVG86IFpoYW5nLCBUaW5hIDx0aW5hLnpoYW5nQGludGVsLmNv
bT47IGlvbW11QGxpc3RzLmxpbnV4LmRldg0KPiBDYzogYmFvbHUubHVAbGludXguaW50ZWwuY29t
OyBUaWFuLCBLZXZpbiA8a2V2aW4udGlhbkBpbnRlbC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFU
Q0ggMDgvMTFdIGlvbW11L3Z0LWQ6IEFkZCBkb21haW5fdHlwZV9pc19zdmEgaGVscGVyDQo+IGZ1
bmN0aW9uDQo+IA0KPiBPbiAyMDI0LzEvMTYgOToxMSwgVGluYSBaaGFuZyB3cm90ZToNCj4gPiBJ
bnRyb2R1Y2UgYSBoZWxwZXIgZnVuY3Rpb24gdG8gdGVsbCBpZiB0aGUgdHlwZSBvZiBhIGRtYXJf
ZG9tYWluIGlzDQo+ID4gc3ZhIG9yIG5vdC4gSW4gZ2VuZXJhbCwgY29tcGFyaW5nIHdpdGggbm9y
bWFsIGlvbW11X2RvbWFpbiwgYSBzdmENCj4gPiBkb21haW4gc2hvdWxkbid0IGJlIHNwZWNpYWwg
b3RoZXIgdGhhbiBoYXZpbmcgYSBkaWZmZXJlbnQgc291cmNlIGZvcg0KPiA+IHRoZSBwYWdlIHRh
YmxlLiBUaHVzLCB0aGlzIGhlbHBlciBmdW5jdGlvbiBzaG91bGQgYmUgdXNlZCBhcyBsaXR0bGUg
YXMNCj4gPiBwb3NzaWJsZSAoaS5lLiBvbmx5IGluIHRoZSBjYXNlcyByZWxhdGVkIHRvIGhhbmRs
aW5nIHBhZ2UgdGFibGUgc291cmNlKS4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFRpbmEgWmhh
bmcgPHRpbmEuemhhbmdAaW50ZWwuY29tPg0KPiA+IC0tLQ0KPiA+ICAgZHJpdmVycy9pb21tdS9p
bnRlbC9pb21tdS5jIHwgNyArKysrKystDQo+ID4gICAxIGZpbGUgY2hhbmdlZCwgNiBpbnNlcnRp
b25zKCspLCAxIGRlbGV0aW9uKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9pb21t
dS9pbnRlbC9pb21tdS5jIGIvZHJpdmVycy9pb21tdS9pbnRlbC9pb21tdS5jDQo+ID4gaW5kZXgg
MGVlYzVkOTcxMzE1Li5hZjQ2NmJhMzAxYjcgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9pb21t
dS9pbnRlbC9pb21tdS5jDQo+ID4gKysrIGIvZHJpdmVycy9pb21tdS9pbnRlbC9pb21tdS5jDQo+
ID4gQEAgLTI0NCw2ICsyNDQsMTEgQEAgc3RhdGljIGludCBkb21haW5fdHlwZV9pc19zaShzdHJ1
Y3QgZG1hcl9kb21haW4NCj4gKmRvbWFpbikNCj4gPiAgIAlyZXR1cm4gZG9tYWluLT5kb21haW4u
dHlwZSA9PSBJT01NVV9ET01BSU5fSURFTlRJVFk7DQo+ID4gICB9DQo+ID4NCj4gPiArc3RhdGlj
IGlubGluZSBib29sIGRvbWFpbl90eXBlX2lzX3N2YShzdHJ1Y3QgZG1hcl9kb21haW4gKmRvbWFp
bikgew0KPiA+ICsJcmV0dXJuIGRvbWFpbi0+ZG9tYWluLnR5cGUgPT0gSU9NTVVfRE9NQUlOX1NW
QTsgfQ0KPiANCj4gTW92ZSB0aGUgaGVscGVyIGludG8gdGhlIGhlYWRlciBmaWxlIGFuZCBwdXQg
YXBwcm9wcmlhdGUgY29tbWVudHMgYXJvdW5kIGl0Lg0KSXMgdGhpcyBkb21haW5fdHlwZV9pc19z
dmEoKSBoZWxwZXIgZXhwZWN0ZWQgdG8gYmUgcmV1c2VkIGJ5IG90aGVycz8NCg0KUmVnYXJkcywN
Ci1UaW5hDQo+IA0KPiBCZXN0IHJlZ2FyZHMsDQo+IGJhb2x1DQo=
