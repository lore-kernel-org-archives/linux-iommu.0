Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B085652
	for <iommu@lists.linux.dev>; Mon, 19 Feb 2024 01:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708304489; cv=fail; b=qkNobkkE6cnF9Xo4Lm8RitmYjppkiylX0ZOf4UILirqFg0Phq8zl7o39Y/Yz1C2y1EYUUhBwv/v8sjUT3KlvK5Q+hZAfXyC4fdIwYsDho2o8ILVLcHV0vwUVcdH8qC71/cawalA4P9u8prtVpkonl0kt2eDFP8Be33a4VCbG/VE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708304489; c=relaxed/simple;
	bh=NtOJEmcyu5sy43kfXSMpzTAlAk4IuvigO4OHzk88M8E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UbAu/jf5uYzVnXoFuFMWU0sdrsUpMoOMHQI51qcINTaI5Kz03sTBbUd8VYLftmHAIKkge0SPHq4zVZ63VUcJK9UEtsXXMONVfqaAzXQXeFO9u2XlhoYvPWPU7+I/QcWqnnJQo6Du8VLNL8Tz2ty88r1LIptapOkxbncFFTdXE6w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LjpkeZ84; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LjpkeZ84"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708304487; x=1739840487;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=NtOJEmcyu5sy43kfXSMpzTAlAk4IuvigO4OHzk88M8E=;
  b=LjpkeZ84zUdc6VJhO9IrIuJT0ChZCT8fkEg5Wb6YzYITL1VnEcK6idqk
   AU6JNMh/0GBnwq+YIucJf0Cm5huSURbNOjyGmuFnC6nygI2M7NkEc/11C
   LZNRiC96BmnsqyFwGSWB+c29RvhtWFf71P007NDmRESwk7+wRe6/ixa/l
   9b2NcSsEj+xzRHw0jvCN7Ujz3z/oVVgPa829NRz/yOEGInS1xdp3Tk7Vh
   LuIi+0P56nOwq3vEy2mprUHbHEYsZA3YNtTYnjDABwLCiW5H2o5wZ+u6d
   rDIRD48Z57nCUSrTUs1g77u54827HGFSDAM2wGKeQ8PsYYd8YvraIaR1K
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10988"; a="19795596"
X-IronPort-AV: E=Sophos;i="6.06,169,1705392000"; 
   d="scan'208";a="19795596"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2024 17:01:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10988"; a="826917778"
X-IronPort-AV: E=Sophos;i="6.06,169,1705392000"; 
   d="scan'208";a="826917778"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Feb 2024 17:01:22 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 18 Feb 2024 17:01:22 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Sun, 18 Feb 2024 17:01:22 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sun, 18 Feb 2024 17:01:21 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=of6rL9XQz5W+UZrKvJHOI7UNHnviZGnVgUWUMC+cIDWuvMMxITuisAu3z9XQXoRh8ZgXYCFfX9aagw4PbFDZHmdZIIwGg8bxrpnqrhSDZodpgDJVdMqcep892IYIHWRuo3yEVUJ6cSsFGfOrZtev6fBtzEDacsHeoAAw4RzaGM3k9QHKdaEVNRbiOlu1Rbogyob7qVlF9bpZsSZUNFnyJq5QbhLJO9VdOima6g0s98v3DGmBRT3fa/xUe9kLCsIaI9OKqQv7ojPTt/ui4G7fWcJWKXwm4UQbvrfUEpnbjn8oT7HS/z9DuNlWtZGbcdCDhUt1F/HpIbycCKH8uZ2w1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NtOJEmcyu5sy43kfXSMpzTAlAk4IuvigO4OHzk88M8E=;
 b=UCK0wuxVTW+1qB1WWU054i6cEWA/MFMvw4kfhF8GeQXKLlL0ZOuncdXc+SzOaDX+D9ZvWBDxvW0a5bV9fjNwq0UsJqAj65nvp2Wcw2PKUewwg7Ka1LZx93lt8/dJThSam8NbYdLzanPIONopnWXS7tZ/8NTDcNA+XbgtqYajSjd1Owcx38B4s6YcH6N/jS4G/MDs6JwGwM+WC+KRUwminQQeBXjxG8k1F6cF0CCVratbdVP1IqKAcgbVJ4fiUaP5tTcVbAsXv75GZf3iL/eu2bG623HVvsPiBmtW3xUlaDWN1khPf8dXOq3ZiaR0Hv3fHTN7BLLZjp2y6OTOpWeaMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW5PR11MB5881.namprd11.prod.outlook.com (2603:10b6:303:19d::14)
 by BN9PR11MB5385.namprd11.prod.outlook.com (2603:10b6:408:11a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.38; Mon, 19 Feb
 2024 01:01:13 +0000
Received: from MW5PR11MB5881.namprd11.prod.outlook.com
 ([fe80::2e1e:4cf0:f8ea:a9c7]) by MW5PR11MB5881.namprd11.prod.outlook.com
 ([fe80::2e1e:4cf0:f8ea:a9c7%4]) with mapi id 15.20.7292.036; Mon, 19 Feb 2024
 01:01:13 +0000
From: "Zhang, Tina" <tina.zhang@intel.com>
To: Baolu Lu <baolu.lu@linux.intel.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>
CC: "Tian, Kevin" <kevin.tian@intel.com>
Subject: RE: [PATCH 09/11] iommu/vt-d: Reuse intel_iommu_set_dev_pasid
 function
Thread-Topic: [PATCH 09/11] iommu/vt-d: Reuse intel_iommu_set_dev_pasid
 function
Thread-Index: AQHaSBk1vXqSsPZJ7kiKD6DlPnip5LDdoJsAgDNoKeA=
Date: Mon, 19 Feb 2024 01:01:13 +0000
Message-ID: <MW5PR11MB5881593A3C0398E97F6B07A589512@MW5PR11MB5881.namprd11.prod.outlook.com>
References: <20240116011146.18645-1-tina.zhang@intel.com>
 <20240116011146.18645-10-tina.zhang@intel.com>
 <5f57c685-04ab-4c70-b305-aa42b97b703a@linux.intel.com>
In-Reply-To: <5f57c685-04ab-4c70-b305-aa42b97b703a@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW5PR11MB5881:EE_|BN9PR11MB5385:EE_
x-ms-office365-filtering-correlation-id: 735c4e59-242f-4e12-09f9-08dc30e644f9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KJsFwf+sHQzeIr4UhgdXgrALuWpnD1JLL7Jb2iLOaYu3B5m2TLJuwO1CFU3EaCDh8ri7GKSwP/OMphsBH1Ve2qGumA1WIyfa6fz20Um2UbZV2Vq5Mq3c5BYxs0PeCUASWmc+OpczkzIu47OJYyvlEkpYKSDPXCVVokCQgRtY0yipBC3KT7ytMxrQA1AsM34HyimoKKZ0Bm2o4ShSAIadDf5cEAuDmqiytbYQSZfGZqt2UU+/XHCWEtdphn5o1OUI6hRjT+Xu6VRnBQoJMkk2sjJgr4XgsnoPsT8VvEEfPh8nE2jn3ctDgh01Lm/CLyOViSbsga6v3mSyYjZ9/zgKLDd/bxvwgQvwz4FFV8j7SfDrL2ppWzVbfO7Ep5MolczMaz9W1m5N+VkOc5YiawypdFMSkzM5DEKY5+CPWGdeQb4eOoPiYnfzEXJQ7xpHW0U7XV6ZdDO+X9zPIGHu/p3mmBY/77mumUeKwloRAfQK1d0lYAg4+6gqU9k+Nv+KP2MAp0n5UXAeihF4+LebNvOovCTrxRrZxJIYm2+NtpaI9BPi025ZaPLAFJpqrnH6XdiI7JxumFOUo5SPld8bK21dGToBbD9SmGp7lLVl0ApbFSMER9+A6qt4VY6Jb/pByGTH
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5881.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(39860400002)(396003)(366004)(376002)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(122000001)(38100700002)(82960400001)(55016003)(26005)(86362001)(33656002)(83380400001)(9686003)(478600001)(2906002)(5660300002)(53546011)(7696005)(6506007)(8676002)(4326008)(8936002)(52536014)(64756008)(66446008)(76116006)(66946007)(66556008)(66476007)(38070700009)(41300700001)(316002)(110136005)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WG03eEZsUS9lK0k4ZEdYZVd5ZjhWSmM5UFZ5OFB4TG9jbzFzdDZ1cUMxOW83?=
 =?utf-8?B?RkNKN05ZZWxEUzRWazQvR3hjdGExZEFlcGNCcktDYzBwQ2l6YTBKb1hhc0U0?=
 =?utf-8?B?aHJRYWc4WkYxSUV0VDQyYVZPM0hxMjRpZUlxU3pLWXY3UVU0VlZJUUlhYXlX?=
 =?utf-8?B?SEFrK2ppRWlmeHA5NGp6MVdrTFUveXEzdlc5TWlPdGFrYVZzNTBHTTc3NlMx?=
 =?utf-8?B?SnZkL0QrVGVJaGNpc3ZPSldhRmdRUkF3R0tZK0htRnpRQXlyZ2pEQlUzcU5R?=
 =?utf-8?B?SERqeE1ZWWZHMkVrcUxDcEZoVGpZSjdWVmJYVXdjRWVvRVlCTkV3WlZ2akFs?=
 =?utf-8?B?WEtCeFY4Yy9Wb01MSC80UEdZbmVEaXM4YTExMllwOWpFb0NkOHoza2FqNjNE?=
 =?utf-8?B?WlVqY1Q2Y3RVSGJYdzFwYWczMFNzcUhNOWhVTWY1ODNtaHM1YlNmMG1EY2lO?=
 =?utf-8?B?ei80V3MyZE1CSWR2enBCWVJrcUFTbkdHT09YcWxmcloxcllSTW1XRlFjNklW?=
 =?utf-8?B?U1kzM01uNlVZUzJkMjEyelBDaGRKdnNObGpnU3RIYnA2WWVoVCtiN01VVFUy?=
 =?utf-8?B?dU11U09JdDFISUdMM3B2cEUrYTh3ZmlZQkc0RDhEM0JUajZyTmtYK2JMZ3Jy?=
 =?utf-8?B?MGxDT2YrSGVpSXlsWmx0eVh3bTlNa2IvNFN5MmpPZVh0RmdyazNLZEJqWTJ3?=
 =?utf-8?B?MVJ3UUlxcE1aKzlFNkN4SjVKNzF6bGxOVXpkaVJBcU40RGNwWVNscXY1cXhr?=
 =?utf-8?B?RkUwOEhKbTV2c0hRZFZaT1VWd1l4b2gvQkRWdFBvRE5UQVdCWTJ3L3BCeVJS?=
 =?utf-8?B?VUVRcm1NSVl5VjJoZmJTOTFRbGdoZFliM1RYU3c0bHM4dVR5QjR5bUZUSnRB?=
 =?utf-8?B?Q09BQWVCeDNUNFY4Z2lBMElLWXVLbHEyVzhCTWFSblBzNGJ4VlZiZlc3aXBo?=
 =?utf-8?B?OWxwQkFNVGxlZVBzRHpIY0o0TW1zcldIeGZ2SFJjMWFZUTJRR0JtemY3WTV4?=
 =?utf-8?B?bTNQcUpkWHVFaXArQkRPc0tHWjI3Y3VoYUhYRmlHQ1RpZUtJbDVRN0JIbkw0?=
 =?utf-8?B?Yk9BdXdlcTdRM2o4Z3ZpenZJUW5Hd016UW8zQ3Brd2hxZ0JRYi9iV1JMSDB6?=
 =?utf-8?B?bzhqeUQ4dkFqMVBHQzNEVHJvSmp1MXJqUjU1b0haUENzTnF2bFJCVUJETWVB?=
 =?utf-8?B?RTVyR09ibEJiT2RkakM0SU4zSlo0cm9VZ2NrWkpid0pGcDhieEtORkptUDB0?=
 =?utf-8?B?a3NWdjVoY25WUENmVGdtbFY5d1U0cVVrVk01aGJBUEs4a0x5WnhMQXlJdm1y?=
 =?utf-8?B?cHhhdDlpaklzdll1WkVkRkxiREU0dTA3UTZYTG1WTmt2T1FLTXZCRGltQlpC?=
 =?utf-8?B?VnMzWExiYzQ2ZStFY1laVGdralpZZm1uOVJKUkpzdWFxTDFMMm5SbjBPbW5a?=
 =?utf-8?B?R0hFTlZlSXY4eXczMG8yR2lpUS9pVzR6RkFobWdvT2RCTlkxQVlveDljNS9N?=
 =?utf-8?B?QU02SmlBK0pJQVhlYmtuKzRzN0lDSnZlNGxtdzY3SVBRNFhScEdZNENQaWdm?=
 =?utf-8?B?Q1l2ZFRidW0vZVkyZE03ZVE4VzJrNW1GUi9UOUtFVzdrTDZNeGQ0OVMzN3J5?=
 =?utf-8?B?YzE1ejdWQ0VDWEZCS2VIVS8vRmtVTmxCOEY2MllzUnNhNUxubndLc2twTHdZ?=
 =?utf-8?B?Y3NMVGdNYnNhQVZnbTl3UHJGSmNwQ2hPT0tWV0lncVBDd3lNdGpxeDdlWEc4?=
 =?utf-8?B?RHo3d3pMOE55dEtKcDZxdVdadXFTcW5CYTM0NHJscHVncnBzRmQvaUVQUjhL?=
 =?utf-8?B?TGtFNTk5UCs5V0pheG5uU1RSeitGMkJpVGx1dWdzeDJxb3dKWmY1TVAwS3lM?=
 =?utf-8?B?L29CWUJnNTE4N0U2SDNVWEFVRVVMNEI3OVl4NnNyMzBhTkNwZ0lBdFo0M3pq?=
 =?utf-8?B?SG10OUUyeVVsWnBhS3Y1OW5CNjRENzdWL2xMZHA1WGNMTXFNMmg2WjBQM2ZO?=
 =?utf-8?B?eUVhV1pYcVROSE1SSkwrbGlvTDljMWNNWEtmTWY2WEJUTGF2WTlMSXFBQ3pK?=
 =?utf-8?B?cVYzZk5rUVBUUFRDbDFMUVRwdGdXRlpDb1d2NlJva0NXZ2JUMGlZUEREa1J0?=
 =?utf-8?Q?5TN1KQvvTWRsTGTpC4k4d/z3U?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 735c4e59-242f-4e12-09f9-08dc30e644f9
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2024 01:01:13.7363
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oP4Ns6Iq1nrFi0lkKzFycnDMdLy798HHCxyfEGyd2yp5JC7Eg2D9PSoygHr3xLCr7YyZBjdxeeaXdCKc1a8bpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5385
X-OriginatorOrg: intel.com

SGkgQmFvbHUsDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQmFvbHUg
THUgPGJhb2x1Lmx1QGxpbnV4LmludGVsLmNvbT4NCj4gU2VudDogV2VkbmVzZGF5LCBKYW51YXJ5
IDE3LCAyMDI0IDM6NDAgUE0NCj4gVG86IFpoYW5nLCBUaW5hIDx0aW5hLnpoYW5nQGludGVsLmNv
bT47IGlvbW11QGxpc3RzLmxpbnV4LmRldg0KPiBDYzogYmFvbHUubHVAbGludXguaW50ZWwuY29t
OyBUaWFuLCBLZXZpbiA8a2V2aW4udGlhbkBpbnRlbC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFU
Q0ggMDkvMTFdIGlvbW11L3Z0LWQ6IFJldXNlIGludGVsX2lvbW11X3NldF9kZXZfcGFzaWQNCj4g
ZnVuY3Rpb24NCj4gDQo+IE9uIDIwMjQvMS8xNiA5OjExLCBUaW5hIFpoYW5nIHdyb3RlOg0KPiA+
IFJlZmFjdG9yIGludGVsX2lvbW11X3NldF9kZXZfcGFzaWQoKSBhbmQgbWFrZSBpdCBiZSByZXVz
ZWQgYnkgc3ZhDQo+ID4gZG9tYWluIGFzIHRoZSBzZXRfZGV2X3Bhc2lkIG9wZXJhdGlvbi4NCj4g
Pg0KPiA+IFNpZ25lZC1vZmYtYnk6IFRpbmEgWmhhbmcgPHRpbmEuemhhbmdAaW50ZWwuY29tPg0K
PiA+IC0tLQ0KPiA+ICAgZHJpdmVycy9pb21tdS9pbnRlbC9pb21tdS5jIHwgNDMgKysrKysrKysr
KysrKysrKysrKysrKysrKystLS0tLS0tLQ0KPiAtLS0NCj4gPiAgIGRyaXZlcnMvaW9tbXUvaW50
ZWwvaW9tbXUuaCB8ICAyICsrDQo+ID4gICBkcml2ZXJzL2lvbW11L2ludGVsL3N2bS5jICAgfCA0
MiArLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gPiAgIDMgZmlsZXMgY2hh
bmdlZCwgMzMgaW5zZXJ0aW9ucygrKSwgNTQgZGVsZXRpb25zKC0pDQo+ID4NCj4gPiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy9pb21tdS9pbnRlbC9pb21tdS5jIGIvZHJpdmVycy9pb21tdS9pbnRlbC9p
b21tdS5jDQo+ID4gaW5kZXggYWY0NjZiYTMwMWI3Li44ZDFiOWRlNzhhNDMgMTAwNjQ0DQo+ID4g
LS0tIGEvZHJpdmVycy9pb21tdS9pbnRlbC9pb21tdS5jDQo+ID4gKysrIGIvZHJpdmVycy9pb21t
dS9pbnRlbC9pb21tdS5jDQo+ID4gQEAgLTQ1NzQsNyArNDU3NCw3IEBAIHN0YXRpYyB2b2lkDQo+
IGludGVsX2lvbW11X3JlbW92ZV9kZXZfcGFzaWQoc3RydWN0IGRldmljZSAqZGV2LCBpb2FzaWRf
dCBwYXNpZCkNCj4gPiAgIAlpbnRlbF9kcmFpbl9wYXNpZF9wcnEoZGV2LCBwYXNpZCk7DQo+ID4g
ICB9DQo+ID4NCj4gPiAtc3RhdGljIGludCBpbnRlbF9pb21tdV9zZXRfZGV2X3Bhc2lkKHN0cnVj
dCBpb21tdV9kb21haW4gKmRvbWFpbiwNCj4gPiAraW50IGludGVsX2lvbW11X3NldF9kZXZfcGFz
aWQoc3RydWN0IGlvbW11X2RvbWFpbiAqZG9tYWluLA0KPiA+ICAgCQkJCSAgICAgc3RydWN0IGRl
dmljZSAqZGV2LCBpb2FzaWRfdCBwYXNpZCkNCj4gPiAgIHsNCj4gPiAgIAlzdHJ1Y3QgZGV2aWNl
X2RvbWFpbl9pbmZvICppbmZvID0gZGV2X2lvbW11X3ByaXZfZ2V0KGRldik7IEBADQo+ID4gLTQ1
OTMsMzEgKzQ1OTMsNDggQEAgc3RhdGljIGludCBpbnRlbF9pb21tdV9zZXRfZGV2X3Bhc2lkKHN0
cnVjdA0KPiBpb21tdV9kb21haW4gKmRvbWFpbiwNCj4gPiAgIAlpZiAoY29udGV4dF9jb3BpZWQo
aW9tbXUsIGluZm8tPmJ1cywgaW5mby0+ZGV2Zm4pKQ0KPiA+ICAgCQlyZXR1cm4gLUVCVVNZOw0K
PiA+DQo+ID4gLQlyZXQgPSBwcmVwYXJlX2RvbWFpbl9hdHRhY2hfZGV2aWNlKGRvbWFpbiwgZGV2
KTsNCj4gPiAtCWlmIChyZXQpDQo+ID4gLQkJcmV0dXJuIHJldDsNCj4gPiAtDQo+ID4gICAJZGV2
X3Bhc2lkID0ga3phbGxvYyhzaXplb2YoKmRldl9wYXNpZCksIEdGUF9LRVJORUwpOw0KPiA+ICAg
CWlmICghZGV2X3Bhc2lkKQ0KPiA+ICAgCQlyZXR1cm4gLUVOT01FTTsNCj4gPg0KPiA+IC0JcmV0
ID0gZG9tYWluX2F0dGFjaF9pb21tdShkbWFyX2RvbWFpbiwgaW9tbXUpOw0KPiA+IC0JaWYgKHJl
dCkNCj4gPiAtCQlnb3RvIG91dF9mcmVlOw0KPiA+ICsJZGV2X3Bhc2lkLT5kZXYgPSBkZXY7DQo+
ID4gKwlkZXZfcGFzaWQtPnBhc2lkID0gcGFzaWQ7DQo+ID4gKwlpZiAoZG9tYWluX3R5cGVfaXNf
c3ZhKGRtYXJfZG9tYWluKSkgew0KPiA+ICsJCWRldl9wYXNpZC0+ZGlkID0gRkxQVF9ERUZBVUxU
X0RJRDsNCj4gPiArCQlkZXZfcGFzaWQtPnNpZCA9IFBDSV9ERVZJRChpbmZvLT5idXMsIGluZm8t
PmRldmZuKTsNCj4gPiArCQlpZiAoaW5mby0+YXRzX2VuYWJsZWQpIHsNCj4gPiArCQkJZGV2X3Bh
c2lkLT5xZGVwID0gaW5mby0+YXRzX3FkZXA7DQo+ID4gKwkJCWlmIChkZXZfcGFzaWQtPnFkZXAg
Pj0gUUlfREVWX0VJT1RMQl9NQVhfSU5WUykNCj4gPiArCQkJCWRldl9wYXNpZC0+cWRlcCA9IDA7
DQo+ID4gKwkJfQ0KPiANCj4gVGhpcyBpcyBnZW5lcmljIGRldmljZSBpbmZvcm1hdGlvbi4gVGhl
cmUncyBubyBuZWVkIHRvIGRvIGl0IG9ubHkgZm9yIHRoZSBTVkENCj4gZG9tYWluOyBvdGhlcndp
c2UsIHlvdSdsbCBoYXZlIHRvIGNoZWNrIHRoZSBkb21haW4gdHlwZSBldmVyeSB0aW1lIHlvdSB1
c2UNCj4gdGhlc2UgZmllbGRzLg0KUmlnaHQuDQoNCj4gDQo+ID4gKwl9IGVsc2Ugew0KPiA+ICsJ
CXJldCA9IHByZXBhcmVfZG9tYWluX2F0dGFjaF9kZXZpY2UoZG9tYWluLCBkZXYpOw0KPiANCj4g
VGhlIHByZXBhcmVfZG9tYWluX2F0dGFjaF9kZXZpY2UoKSBmdW5jdGlvbiBpcyBjYWxsZWQgdG8g
Y2hlY2sgd2hldGhlciB0aGUNCj4gZGV2aWNlIGlzIGNvbXBhdGlibGUgd2l0aCB0aGUgZG9tYWlu
IHRvIGJlIGF0dGFjaGVkLiBZb3UgY291bGQgbWFrZSBpdCB3b3JrDQo+IGZvciB0aGUgU1ZBIGRv
bWFpbiBhcyB3ZWxsLCByYXRoZXIgdGhhbiBpZ25vcmluZyBpdC4NCk9LLg0KDQo+IA0KPiA+ICsJ
CWlmIChyZXQpDQo+ID4gKwkJCWdvdG8gb3V0X2ZyZWU7DQo+ID4gKw0KPiA+ICsJCXJldCA9IGRv
bWFpbl9hdHRhY2hfaW9tbXUoZG1hcl9kb21haW4sIGlvbW11KTsNCj4gDQo+IFRoZSBzYW1lIGhl
cmUuDQo+IA0KPiBUaGUgZG9tYWluX2F0dGFjaF9pb21tdSgpIGlzIGNhbGxlZCB0byBzZXR1cCB0
aGUgcmVsYXRpb25zaGlwIGJldHdlZW4gYQ0KPiBkb21haW4gYW5kIGFuIGlvbW11LiBZb3Ugc2hv
dWxkIG1ha2UgaXQgY29tcGF0aWJsZSB3aXRoIHN2YSBkb21haW4gYXMNCj4gd2VsbC4NClRoZSBw
cm9ibGVtIGlzIHdoZXRoZXIgd2UgbmVlZCBzdHJ1Y3QgaW9tbXVfZG9tYWluX2luZm8gZm9yIHN2
YSBkb21haW4uIEkgZGlkbid0IHNlZSBhbnkgbmVjZXNzYXJ5IHRvIGFsbG9jYXRlIHN0cnVjdCBp
b21tdV9kb21haW5faW5mbyBpbnN0YW5jZSBmb3Igc3ZhIGRvbWFpbiwgYXMgYWxsIHRoZSBmaWVs
ZHMgb2Ygc3RydWN0IGlvbW11X2RvbWFpbl9pbmZvIGNhbiBiZSBnb3R0ZW4gZnJvbSBkZXZfcGFz
aWRzLg0KDQpTaW5jZSB3ZSB3YW50IHRvIG1ha2UgdGhlIGRvbWFpbl9hdHRhY2hfaW9tbXUoKSBn
ZW5lcmljIChpLmUuLCBhbGwgZG9tYWlucywgbm8gbWF0dGVyIHdoYXQgdHlwZSB0aGV5IGFyZSwg
bmVlZCB0byBjYWxsIHRoaXMgZnVuY3Rpb24pLCBJIHRoaW5rIHdlIGNhbiBjaGVjayB0aGUgZG9t
YWluIHR5cGUgd2l0aGluIHRoZSBmdW5jdGlvbiBhbmQgYWRkIGNvbW1lbnRzIHRoZXJlIHRvIHRl
bGwgdGhhdCB3ZSBkaWRuJ3Qgc2VlIGFueSBuZWNlc3NhcnkgdG8gbGV0IHN2YSBkb21haW4gaGF2
ZSBhIHN0cnVjdCBpb21tdV9kb21haW5faW5mbyBhbmQgdGhlcmVmb3JlIHRoZSBmdW5jdGlvbiBy
ZXR1cm5zIGltbWVkaWF0ZWx5IGlmIGl0IG1lZXRzIGEgc3ZhIGRvbWFpbi4gV2hhdCBkbyB5b3Ug
dGhpbms/DQoNClJlZ2FyZHMsDQotVGluYQ0KDQo+IA0KPiBCZXN0IHJlZ2FyZHMsDQo+IGJhb2x1
DQo=
