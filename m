Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F73C28EC
	for <iommu@lists.linux.dev>; Fri, 16 Feb 2024 05:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708061898; cv=fail; b=P/D1bV3lhOBCzUbZdL9OjoSQCGgzIrVY94bsZXNzYirr9EshycvHlD2KEIzbqd1alo8Ko0lNsk/9VGuoYbP8FuxFpvnBt+754HQAaWRTEmMOtt2e8mk6jZYajYVFQfa4ZDqGDARLctxP05ZocG7FrTZB72Dhmj/Wa0FBQBkaq3w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708061898; c=relaxed/simple;
	bh=U4mguP1MDQGRWfvcqUwtEBIHFdmwRkk4WLm4yPGW1Ms=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XMw+minmRcvVYBoggs3GnWeWFuX56CkmMlMIgWWWH87/+8//jPUCeakzjfGPO3Uq8CEtC2bky/DBBm5bDUlJWuDpCqPTJ8Cr3TNguSYIEGqO7EddnJz+KWrBhf2P1DfaFc3GUEQj15Etm8bt++6Mn4ckDh5nNkrjrD5vXctg3U0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R/cpbf84; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R/cpbf84"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708061896; x=1739597896;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=U4mguP1MDQGRWfvcqUwtEBIHFdmwRkk4WLm4yPGW1Ms=;
  b=R/cpbf84VPRaFZH8F7bzu1LC3YT4NCMy02OZfP8vcxO2scwEFBFMkIqT
   QENm4QKTUxZD0dA6YLjOR8pRZsi2+DC9FTh0LDHOC9/Wf3EHjki8mDQVt
   16+/YxpNB6v3VBEpIdNFvRCWfkF+R9AdOObsXxEz01uRaPQSuS8og3mVY
   0Nk0DtjV54Obi/exZDJeTZQpWysD880Zzx1T4TEx3BTr8jmPVOJFo1PLX
   mxPOvihszYt6m0DalVzT0FOcjaOYyJHysOe4mcNgB0OpXLxbxDA6Vw7AB
   fqtVIhJbwUKV5M11+NLAT7FEc7Hp+GWT5JsIU3GfYmo7yR9smW4YqMY7U
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10985"; a="2323101"
X-IronPort-AV: E=Sophos;i="6.06,163,1705392000"; 
   d="scan'208";a="2323101"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2024 21:38:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,163,1705392000"; 
   d="scan'208";a="4065882"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Feb 2024 21:38:15 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 15 Feb 2024 21:38:14 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 15 Feb 2024 21:38:13 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 15 Feb 2024 21:38:13 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 15 Feb 2024 21:38:13 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T9401aFcWziPqQ/MOZ76zSBH0alj151nsDUQZg4jygQCFw1DPMU3m9GmmTcJqWjB63SOc89JyseTBnmWHdAcVXjkI0hBKsFosKEyGvfwiEbhFqPB7WmgR6PsXa8LR1Mp/o0sCXmReL4M1JqCDPCGHzY3tFG2PxvBc9bTW55rf5myh4gAH30kmDabtiCTSiqZtCuwhcebgi3XKnzFq9FmD9yx6VFX6bGynSAVlnXu5wYlEN/pVFhLgjeIPKKukZpobnnVZ4fcKwTsiyr07+ePP3TvmGbyCeAR3Bdh67lcgwKtol8uSEpxHkBkM1u7mDOiYib2nwsB9qBTp7d2Dj9LJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U4mguP1MDQGRWfvcqUwtEBIHFdmwRkk4WLm4yPGW1Ms=;
 b=n45Iqwowme7pY2Eo1JycdBoZ0rOS8+V7f5pen0SZTdSzjIvPJds1xoiYGaiqMsKXKvyZfGVYMsdpFS/LSo0lPTDb2MVOIT/ZA4Pwmb2clbRHA3ZJrluFSE69vuFrBswMBkv2nK20oqQuDWE+v42b75uDry5uctQo4UfW82+viUeJHDivE/5JCJwPDOvdNf6joquuhTE7S8Omo3ftWdF4XvMk+FbZBzoTY2EDqregKDj3brleFqdyK5bUE9u6j/TmBWiJnrIkBM9Ke/jUX6JZk3J1qGKgS9RqNf695cTxqufULS+0UP8XMsCTltrUBnncjRMobhINuN0UTJKbJpO0PA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW5PR11MB5881.namprd11.prod.outlook.com (2603:10b6:303:19d::14)
 by DM4PR11MB5424.namprd11.prod.outlook.com (2603:10b6:5:39c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.31; Fri, 16 Feb
 2024 05:38:11 +0000
Received: from MW5PR11MB5881.namprd11.prod.outlook.com
 ([fe80::2e1e:4cf0:f8ea:a9c7]) by MW5PR11MB5881.namprd11.prod.outlook.com
 ([fe80::2e1e:4cf0:f8ea:a9c7%4]) with mapi id 15.20.7292.029; Fri, 16 Feb 2024
 05:38:11 +0000
From: "Zhang, Tina" <tina.zhang@intel.com>
To: Baolu Lu <baolu.lu@linux.intel.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>
CC: "Tian, Kevin" <kevin.tian@intel.com>
Subject: RE: [PATCH 11/11] iommu/vt-d: Remove superfluous IOMMU IOTLB
 invalidations
Thread-Topic: [PATCH 11/11] iommu/vt-d: Remove superfluous IOMMU IOTLB
 invalidations
Thread-Index: AQHaSBk2kfWQiW6erkedFcmmn80UVLDdpgwAgC75T6A=
Date: Fri, 16 Feb 2024 05:38:11 +0000
Message-ID: <MW5PR11MB5881721113BCB56830201188894C2@MW5PR11MB5881.namprd11.prod.outlook.com>
References: <20240116011146.18645-1-tina.zhang@intel.com>
 <20240116011146.18645-12-tina.zhang@intel.com>
 <a68120c9-9114-4312-b260-6b82303f2ef5@linux.intel.com>
In-Reply-To: <a68120c9-9114-4312-b260-6b82303f2ef5@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW5PR11MB5881:EE_|DM4PR11MB5424:EE_
x-ms-office365-filtering-correlation-id: 3cf9748c-eb64-42bc-5f8b-08dc2eb176d0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8zzxiFrA6uczQ33HwaXyiuSYcKvQewMTgGZDYOLVBwTaEmT5xdog+FWOua4/q9v9w2xQJMRYrPMBuXMzIL/GYgnc92Z1LVXXkUfZXcLX6UxSRa7pbY3wNzSqeHHut+eVK8ZvtaBEjfJUEHc2Ib1wNSDiq6YtG05O5gm/p5bXJeqNTpMdtSPM3tH5WJQs6n969or6DovFCaVK8VONFPG8+Bd1UXBruWvlme5JDOEdG05CvB8qoxw3swJSVw1vg6waef8NblOEfI/zf4ObWG2NtCjPGn60RoXa5ss+wO6tPFAe+OQ8DPCj+0yRy6h6n6dwzNxlQCZJVgpl5NRGfjnprFTclCd25uasHtuAk78xDjm+Ij2NPDX93Jq/a+BSzhJqwIwrrUf6EqnB5I2bvixLBwp/GIjkSwMKllSVFz9Iy0LqYUrrMc+d4fNEHENxGABrEEb9KRzT2tnjmcgWeth3FWzAMom1kjUIQOzC2DeRVzp5c9K/lMNNI7DynykoLDArAjIiT8Qwryhgaz1aOsl2UlOk1Cr21kd1fo1vHADGnQWISIlIJ3OhB1UzGaGJpe0p44O+LQrv2v/ZNFLTEOSPUgJtbhUH7CZPBPXO4iCtduk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5881.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(346002)(396003)(136003)(39860400002)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(71200400001)(9686003)(478600001)(966005)(41300700001)(55016003)(4326008)(2906002)(8936002)(8676002)(5660300002)(52536014)(83380400001)(53546011)(7696005)(6506007)(66476007)(76116006)(66446008)(64756008)(110136005)(66556008)(316002)(66946007)(38100700002)(122000001)(82960400001)(86362001)(33656002)(38070700009)(26005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Y29veFJzVFdjMitmeWxLdS9pL2FWTGNxRUpsSDdQTTFOa3ZVUkV2aGRMRnhL?=
 =?utf-8?B?Y1ZRYjIzc2NkWDYyL1c0b0N0VkJBOS9NcWo3T1llbSs2OUc4T1F1T3N6a1do?=
 =?utf-8?B?VXIvS2tabzNHOE9NaGxZN3UvSW5OalU3YzhrdkZjNkZkNTBNSHZpOStSeXha?=
 =?utf-8?B?RjdoT2ZhRnhFQnhOanFNS0hOOU9tRE1uL2tkSTBWMnVpUVA5MndraktKSWVv?=
 =?utf-8?B?d1pWQ2NSZWRQZWNIQW9kQUVQUE0zVmUvQ3lxZkJrZUFxZHVlSFBId2VZN2hm?=
 =?utf-8?B?elNaRlUzY2NDMkFlek8remkxcCtCR3AwVzM0K1JmTkNVRmZVNDJ6eEZpS05j?=
 =?utf-8?B?NXhvcHJYYlBEWHg1NjFFdzJwME05TFliOHlUMlFVd1AzVU9USFN3dWZhcWJ5?=
 =?utf-8?B?UnBaN3NLUG9jMGdhS2N1R1NiZXZJNWVxYnEyN1l3RTJMSmZKc2ZTN3RZMWxJ?=
 =?utf-8?B?OFNQWEluMUZhN3ZaTTFiTVlIMUQyUEFzbW52SnhxTGpURmtyZ2lITys1K050?=
 =?utf-8?B?L2U1ZVRZUDV4K1pJeGNWd0V2ZWdtd295WTlCazlrTy9Va08vazdVRkxwN0F5?=
 =?utf-8?B?bjRJZnIzbU1neFpVUUFMWXFsRzlrS2htM1FnZlZJdmVJOG5xLzNKZHVXeHFy?=
 =?utf-8?B?K3RIZzcrVFNwR3JsL1kwRWdwQzRkWmlVT1NiYTBBNXlhNFkzY2ttL05EV0x2?=
 =?utf-8?B?ODU3ZGQ2NVkyUjFZRnFqWEM3U2xPUTlIb0JuZ1lyZTFBcnYzT1JEL0JCd0tl?=
 =?utf-8?B?cjJlV0FtdXNhVzhna3FXTURMTW9YOG1YT3EwamNtZGlPNnh0V0o4K25JN1pO?=
 =?utf-8?B?UzRIeHBSdnJlbE5NS3pCdy9weEdTN0ZQSVFxOHhKNHN2MmFKcXVhK0h2eG1X?=
 =?utf-8?B?YXF3MXNlSStCdE5jZEExMWwycmhsY005S3A0d0J1Z2ZVN3FPYU1vSW5heDFy?=
 =?utf-8?B?d1I1L3g1NEtvUGI4WlQ1L1U3d3BRZC9QeFZPdEZpeWxEY0RrZm9MSDhrVENY?=
 =?utf-8?B?UUpxSUJuZ2M3V3hvc0Zla2tYdGZZeDVPazhBVmwvUmtwNDNoa3A4VFRvNjNB?=
 =?utf-8?B?RlgvdWlxVm9pdlRiNnFDbmkxaUg3alpBTllNZVYyZExlMXpSd3JlNzhFVFZy?=
 =?utf-8?B?VTdvM1ZRbzU1T1ErRzN5SU9OQ05XZ2NnY1piSkZPYmFJSTFyaUl5VlZUelN1?=
 =?utf-8?B?MHd1dlRzekNlUVFmeC9ZZFhXdnJUayt5UkVkcVB5ZitORERJZ0dCTnJoRlFI?=
 =?utf-8?B?aXppNGFKRXphZndibHBRaTRTRVNSdE9Pdy9WSkhnS3doNUUxdGxHWDQweW5D?=
 =?utf-8?B?OUpWL0RCS2pqOVNtdmlxWXBBKzZ3dkEvVWJKMWtMWmZiemNTeUIxY0RPZkpR?=
 =?utf-8?B?SDVPSCsxK05GM2s2YkZicThzbzE1ZzcwOFpBeHUvNk9Zc1RTcFpQNjV6ZDBP?=
 =?utf-8?B?cXkzakFDQWdqT2NSUDZuV2ZyODBENERGa2V1SmZaVXU0RFBmaW80YVdtbUdG?=
 =?utf-8?B?dS9NZTg3WHpQVnNDRk9icVFVbExHeVNQVGtzVUFOZDVFYjlldExVYmlBNDhR?=
 =?utf-8?B?QUJGY1FmcXNiejk0aEthVGprRWNjMlVoSi81Vm04SUlmd3BTV0c4NndDV0Zy?=
 =?utf-8?B?N0N0SXFOL2kweS9ZTnFaRzRyaEF1STJ4QjNKdGMycHhTa3dpRGFBWmRLdkVt?=
 =?utf-8?B?cnhKNVB1RHJlUEtpTzVsZXh5QTZjRDVUaWFMOWcxNmZrWlN6ZVFDREptbDBW?=
 =?utf-8?B?YnIxcFJIbU9YOWNUTUxvMEViUUFYRTRtQWhUbCtMTHJrT3VIZUVqN29hMFFu?=
 =?utf-8?B?RTVSNTdZNzVOc1BEOVNaaVZmdlVGZGpTT2xEcTdqNmQ1TDUvK1JwL1dadi9r?=
 =?utf-8?B?ZnFzblY5MERtUkhpdHhCUGJCZHBjV05jbmUvS1RZZ2duRGQ5UGNNOC9SSVRI?=
 =?utf-8?B?NU1EVmNianUyQ0VuS001VXl0aU9BZkpnTnByMnhadkI3ODU2aDU2b0p6RWd4?=
 =?utf-8?B?VVFuS3B3OVNrTUZyWFByUWhOWkVpWGZDblhrbDFFMlZ5MlRCcGpoRkVrNkMv?=
 =?utf-8?B?MUVjYXVTdUd1QWthcWw3U1pzRGs4WXJHY0FkYS9UZEUwRGtsSVNSV0NpNENu?=
 =?utf-8?Q?TW37bd/gG7qZJ+s3bliclTkCI?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cf9748c-eb64-42bc-5f8b-08dc2eb176d0
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Feb 2024 05:38:11.6942
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8BX133ifAVDr6PFIAaCxqhtL1t4cph1HfHmnSrPzF5MLJFE5BfMoo8hOyesxRb7gm5UQvLLcNHRwr9JAT8mTsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5424
X-OriginatorOrg: intel.com

SGkgQmFvbHUsDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQmFvbHUg
THUgPGJhb2x1Lmx1QGxpbnV4LmludGVsLmNvbT4NCj4gU2VudDogV2VkbmVzZGF5LCBKYW51YXJ5
IDE3LCAyMDI0IDQ6MDAgUE0NCj4gVG86IFpoYW5nLCBUaW5hIDx0aW5hLnpoYW5nQGludGVsLmNv
bT47IGlvbW11QGxpc3RzLmxpbnV4LmRldg0KPiBDYzogYmFvbHUubHVAbGludXguaW50ZWwuY29t
OyBUaWFuLCBLZXZpbiA8a2V2aW4udGlhbkBpbnRlbC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFU
Q0ggMTEvMTFdIGlvbW11L3Z0LWQ6IFJlbW92ZSBzdXBlcmZsdW91cyBJT01NVSBJT1RMQg0KPiBp
bnZhbGlkYXRpb25zDQo+IA0KPiBPbiAyMDI0LzEvMTYgOToxMSwgVGluYSBaaGFuZyB3cm90ZToN
Cj4gPiBEZXZpY2VzIGJlaGluZCBkaWZmZXJlbnQgSU9NTVVzIGNhbiBiZSBib3VuZCB0byBvbmUg
c3ZhIGRvbWFpbi4gV2hlbiBhDQo+ID4gcmFuZ2Ugb2YgYSBzdmEgZG9tYWluIGFkZHJlc3MgaXMg
YmVpbmcgaW52YWxpZGF0ZWQsIFZULWQgZHJpdmVyIG5lZWRzDQo+ID4gdG8gaXNzdWUgSU9NTVUg
SU9UTEIgYW5kIERldi1JT1RMQiBpbnZhbGlkYXRpb24gY29tbWFuZHMgdG8gYXNrIElPTU1VDQo+
ID4gaGFyZHdhcmUgYW5kIHJlbGF0ZWQgZGV2aWNlcyB0byBpbnZhbGlkYXRlIHRoZWlyIGNhY2hl
cy4NCj4gPg0KPiA+IFRoZSBjdXJyZW50IGxvZ2ljIGlzc3VlcyBib3RoIElPVExCIGludmFsaWRh
dGlvbiBjb21tYW5kIGFuZA0KPiA+IGRldmljZS1UTEIgY29tbWFuZCBwZXIgZGV2aWNlLCB3aGlj
aCBsZWFkcyB0byBzdXBlcmZsdW91cyBJT1RMQg0KPiA+IGludmFsaWRhdGlvbiAoZS5nLiwgaWYg
dGhlcmUgYXJlIGZvdXIgZGV2aWNlcyBiZWhpbmQgYSBJT01NVSBhcmUgYXR0YWNoZWQgdG8NCj4g
b25lIHN2YSBkb21haW4uDQo+ID4gSW4gdGhlIGN1cnJlbnQgbG9naWMsIGR1cmluZyBoYW5kaW5n
IGludGVsX2ludmFsaWRhdGVfcmFuZ2UoKSwgZm91cg0KPiA+IElPVExCIGludmFsaWRhdGlvbiBj
b21tYW5kcyBhbmQgZm91ciBEZXYtSU9UTEIgaW52YWxpZGF0aW9uIGNvbW1hbmRzDQo+ID4gd2ls
bCBiZSBpc3N1ZWQuIEhvd2V2ZXIsIG9ubHkgb25lIElPVExCIGludmFsaWRhdGlvbiBjb21tYW5k
IGFuZCBmb3VyDQo+ID4gRGV2LUlPVExCIGludmFsaWRhdGlvbiBjb21tYW5kIGFyZSBuZWNlc3Nh
cnkuKSwgYW5kIHRoZXJlZm9yZSBpbXBhY3RzDQo+ID4gcnVuLXRpbWUgcGVyZm9ybWFuY2UuDQo+
ID4NCj4gPiBUaGUgcGF0Y2ggcmVtb3ZlcyB0aGUgcmVkdW5kYW50IElPTU1VIElPVExCIGludmFs
aWRhdGlvbnMgYnkgYWxsb3dpbmcNCj4gPiBpc3N1aW5nIElPTU1VIElPVExCIGludmFsaWRhdGlv
biBjb21tYW5kIHBlciBpb21tdSBpbnN0ZWFkIG9mIHBlciBkZXZpY2UuDQo+ID4NCj4gPiBTdWdn
ZXN0ZWQtYnk6IFNhbmpheSBLdW1hcjxzYW5qYXkuay5rdW1hckBpbnRlbC5jb20+DQo+ID4gU2ln
bmVkLW9mZi1ieTogVGluYSBaaGFuZzx0aW5hLnpoYW5nQGludGVsLmNvbT4NCj4gPiAtLS0NCj4g
PiAgIGRyaXZlcnMvaW9tbXUvaW50ZWwvc3ZtLmMgfCA1MyArKysrKysrKysrKysrKysrKystLS0t
LS0tLS0tLS0tLS0tLS0tLS0NCj4gPiAgIDEgZmlsZSBjaGFuZ2VkLCAyNSBpbnNlcnRpb25zKCsp
LCAyOCBkZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2lvbW11L2lu
dGVsL3N2bS5jIGIvZHJpdmVycy9pb21tdS9pbnRlbC9zdm0uYw0KPiA+IGluZGV4IDc5ZDFmMzEw
Nzg0Ny4uYmY0OTYyZWIyMjljIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvaW9tbXUvaW50ZWwv
c3ZtLmMNCj4gPiArKysgYi9kcml2ZXJzL2lvbW11L2ludGVsL3N2bS5jDQo+ID4gQEAgLTEzNCwz
MSArMTM0LDM5IEBAIHZvaWQgaW50ZWxfc3ZtX2NoZWNrKHN0cnVjdCBpbnRlbF9pb21tdSAqaW9t
bXUpDQo+ID4gICAJaW9tbXUtPmZsYWdzIHw9IFZURF9GTEFHX1NWTV9DQVBBQkxFOw0KPiA+ICAg
fQ0KPiA+DQo+ID4gLXN0YXRpYyB2b2lkIF9fZmx1c2hfc3ZtX3JhbmdlX2RldihzdHJ1Y3QgZG1h
cl9kb21haW4gKmRvbWFpbiwNCj4gPiAtCQkJCSAgc3RydWN0IGRldl9wYXNpZF9pbmZvICpkZXZf
cGFzaWQsDQo+ID4gK3N0YXRpYyB2b2lkIF9fZmx1c2hfc3ZtX3JhbmdlKHN0cnVjdCBpb21tdV9k
b21haW4gKmRvbWFpbiwNCj4gPiAgIAkJCQkgIHVuc2lnbmVkIGxvbmcgYWRkcmVzcywNCj4gPiAg
IAkJCQkgIHVuc2lnbmVkIGxvbmcgcGFnZXMsIGludCBpaCkNCj4gPiAgIHsNCj4gPiAtCXN0cnVj
dCBkZXZpY2VfZG9tYWluX2luZm8gKmluZm8gPSBkZXZfaW9tbXVfcHJpdl9nZXQoZGV2X3Bhc2lk
LQ0KPiA+ZGV2KTsNCj4gPiAtCXUzMiBwYXNpZCA9IG1tX2dldF9lbnFjbWRfcGFzaWQoZG9tYWlu
LT5kb21haW4ubW0pOw0KPiA+ICsJdTMyIHBhc2lkID0gbW1fZ2V0X2VucWNtZF9wYXNpZChkb21h
aW4tPm1tKTsNCj4gPiArCXN0cnVjdCBkZXZpY2VfZG9tYWluX2luZm8gKmRldl9pbmZvOw0KPiA+
ICsJc3RydWN0IGlvbW11X2RvbWFpbl9pbmZvICppb21tdV9pbmZvOw0KPiA+ICsJc3RydWN0IGRl
dl9wYXNpZF9pbmZvICpkZXZfcGFzaWQ7DQo+ID4gKwl1bnNpZ25lZCBsb25nIGlkeDsNCj4gPg0K
PiA+ICAgCWlmIChXQVJOX09OKCFwYWdlcykpDQo+ID4gICAJCXJldHVybjsNCj4gPg0KPiA+IC0J
cWlfZmx1c2hfcGlvdGxiKGluZm8tPmlvbW11LCBkZXZfcGFzaWQtPmRpZCwgcGFzaWQsIGFkZHJl
c3MsIHBhZ2VzLCBpaCk7DQo+ID4gLQlpZiAoaW5mby0+YXRzX2VuYWJsZWQpIHsNCj4gPiAtCQlx
aV9mbHVzaF9kZXZfaW90bGJfcGFzaWQoaW5mby0+aW9tbXUsIGRldl9wYXNpZC0+c2lkLCBpbmZv
LQ0KPiA+cGZzaWQsDQo+ID4gLQkJCQkJIHBhc2lkLCBkZXZfcGFzaWQtPnFkZXAsIGFkZHJlc3Ms
DQo+ID4gLQkJCQkJIG9yZGVyX2Jhc2VfMihwYWdlcykpOw0KPiA+IC0JCXF1aXJrX2V4dHJhX2Rl
dl90bGJfZmx1c2goaW5mbywgYWRkcmVzcywgb3JkZXJfYmFzZV8yKHBhZ2VzKSwNCj4gPiAtCQkJ
CQkgIHBhc2lkLCBkZXZfcGFzaWQtPnFkZXApOw0KPiA+ICsJcmN1X3JlYWRfbG9jaygpOw0KPiA+
ICsJeGFfZm9yX2VhY2goJnRvX2RtYXJfZG9tYWluKGRvbWFpbiktPmlvbW11X2FycmF5LCBpZHgs
DQo+IGlvbW11X2luZm8pDQo+ID4gKwkJcWlfZmx1c2hfcGlvdGxiKGlvbW11X2luZm8tPmlvbW11
LCBkZXZfcGFzaWQtPmRpZCwNCj4gPiArCQkJCXBhc2lkLCBhZGRyZXNzLCBwYWdlcywgaWgpOw0K
PiANCj4gVGhlIHhhX2FycmF5IGZvciBpb21tdSBpcyBhbHJlYWR5IGJyb2tlbi4gV2Ugc2hvdWxk
IGZpeCBpdCBiZWZvcmUgZnVydGhlciB1c2UuDQo+IA0KPiBodHRwczovL2xvcmUua2VybmVsLm9y
Zy9saW51eC1pb21tdS8yMDI0MDEwMzEyNDQwMy5HTTUwNDA2QG52aWRpYS5jb20vDQpBZ3JlZSB0
aGF0IGRvbWFpbi0+aW9tbXVfYXJyYXkgbmVlZHMgdG8gcHJvdGVjdCB0aGUgZWxlbWVudCAoc3Ry
dWN0IGlvbW11X2RvbWFpbl9pbmZvKSBmcm9tIFVBRiBhcyB3ZWxsLiBUaGlzIGNvdWxkIGJlIGFu
b3RoZXIgdG9waWMuDQoNCkkgcmVhbGl6ZSB0aGF0IHdlIGRvbid0IG5lZWQgdG8gdXNlIGRvbWFp
bi0+aW9tbXVfYXJyYXkgaGVyZS4gV2hhdCB3ZSB3YW50IGhlcmUgaXMgYSBwb2ludGVyIHBvaW50
aW5nIHRvIGEgc3RydWN0IGludGVsX2lvbW11LiBXZSBjYW4gZ2V0IHRoZSBpbmZvIGZyb20gZGV2
aWNlIHVzaW5nIGRldl9pb21tdV9wcml2X2dldCgpLCBpbnN0ZWFkIG9mIGdldHRpbmcgdGhlIGlu
Zm8gZnJvbSBpb21tdV9hcnJheS4NCg0KQmVzaWRlcywgSSdtIHRoaW5raW5nIGFib3V0IHNvcnRp
bmcgdGhlIGRvbWFpbi0+ZGV2X3Bhc2lkcyBpbiBpbnRlbF9pb21tdV9zZXRfZGV2X3Bhc2lkKCkg
dG8gbWFrZSBzdHJ1Y3QgZGV2X3Bhc2lkX2luZm8gb2YgdGhlIGRldmljZXMgYmVoaW5kIHRoZSBz
YW1lIElPTU1VIHN0YXkgdG9nZXRoZXIuIEl0IGNhbiBiZSBoZWxwZnVsIHRvIHJlZHVjZSB0aGUg
cmVkdW5kYW50IElPTU1VIElPVExCIGludmFsaWRhdGlvbnMuDQoNClJlZ2FyZHMsDQotVGluYQ0K
DQo+IA0KPiBCZXN0IHJlZ2FyZHMsDQo+IGJhb2x1DQo=
