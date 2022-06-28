Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AA337A
	for <iommu@lists.linux.dev>; Tue, 28 Jun 2022 08:53:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656406404; x=1687942404;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=j7RBLyOlka1iLMiwFTIdTRDvqa2H8mNDaHkfg+UpypI=;
  b=DhjlhhpHntMqZYro3hy4+jSOOannVLLwzk0HEfVCsm7Hrv9Fvcg9wBnK
   ot3MqbT6k4OL0G8axWtbJFPB8KbtgGSGw3fdtLfHhj/osGRlxWs6x7Ftb
   rP8DdjnsbpiphlTHxeI15dCUW9Jq54CEvN0jkh2vZfqfN+f/T5PEx6I4H
   Q1PtofQTjk22nnllLtDA6WFw+mNLlzp6MfNSIqmKquAxsfeDzmU0WTLMg
   NGS8SWqcSdtZQh1quMTHyph4aeJu7KRJnD4BmgiU2d/IQ5NrJAFSsgNpy
   wuKG4Z7k0BIpKUKO3rbOtVnWQNbqT/6vYJO6lf6qKxxvyXWdcDUvNnT70
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10391"; a="307159766"
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; 
   d="scan'208";a="307159766"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2022 01:53:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; 
   d="scan'208";a="717371502"
Received: from orsmsx604.amr.corp.intel.com ([10.22.229.17])
  by orsmga004.jf.intel.com with ESMTP; 28 Jun 2022 01:53:22 -0700
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 28 Jun 2022 01:53:22 -0700
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 28 Jun 2022 01:53:22 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Tue, 28 Jun 2022 01:53:22 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Tue, 28 Jun 2022 01:52:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hfp+fKAgPinUTc+EboRcvyGeAuUQa6Zub2kaW1qnLgga5r65ZF2ong94C+bw4ywqIgTeFoYKhN06cUTDxKBHosb6KGGObmrGecBw5qSs+mG44eBNG2dJa2E5BEL78T0iN9P5xK/W3dvsym+aqaBb4LrLx7XzW4rRQkAhgs1Hw7Ei13mPF22HisCkV/I44wjVkBwUuyJqD0Ps8/nTf17D4ZbtDK9hVufOfHiMVC0wHRa1mP9L/LYp02jvEYQiNmSj6H5sMjHm2Bk73c8ugJF2fzpYJy/5bkD0PJPoEw5J1KynDA6h2SbhnE8W/AngUZ8QLirbUKDxvSRGQvNi8rt5SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j7RBLyOlka1iLMiwFTIdTRDvqa2H8mNDaHkfg+UpypI=;
 b=d5OsYU8qzDVY2NmBSlrWwP0xQV8TsCB2wVrdcGtnvd0E3nrYM4cG+ciMewZk+HfwhXwvMasxiqFQIRN52qZHWt8DrKnBZ4szy7brLMYkk/f63eqdQtB15jSKTJNS0IHdDesmkJZVmrLPpimpSFHyOyFgHDEQ5DOnY6CTgpzLu2SqSYkOel/PQ2UwahQl5QFDHsTYZbGCeFFwgSIrQb5LnXzQGPPwxLFXWES2I8bZ+cbDwdXuxTcpajRWiafRXfBSUbZn8O6DKzYO5aNqEsFa/pdoIAtNr2IkfQ8rg0ZILzbkBvsj0zN2uvggDetbiqPyWgPryabbvprOXRzDGDGH8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by CH0PR11MB5377.namprd11.prod.outlook.com (2603:10b6:610:b8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.15; Tue, 28 Jun
 2022 08:52:37 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::8435:5a99:1e28:b38c]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::8435:5a99:1e28:b38c%2]) with mapi id 15.20.5373.018; Tue, 28 Jun 2022
 08:52:37 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Baolu Lu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
	"Jason Gunthorpe" <jgg@nvidia.com>, Christoph Hellwig <hch@infradead.org>,
	"Raj, Ashok" <ashok.raj@intel.com>, Will Deacon <will@kernel.org>, Robin
 Murphy <robin.murphy@arm.com>, Jean-Philippe Brucker
	<jean-philippe@linaro.com>, "Jiang, Dave" <dave.jiang@intel.com>, Vinod Koul
	<vkoul@kernel.org>
CC: Eric Auger <eric.auger@redhat.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
	"Pan, Jacob jun" <jacob.jun.pan@intel.com>,
	"iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v9 07/11] iommu/sva: Refactoring
 iommu_sva_bind/unbind_device()
Thread-Topic: [PATCH v9 07/11] iommu/sva: Refactoring
 iommu_sva_bind/unbind_device()
Thread-Index: AQHYhX4BFOtH7b1yFE6Yv4ZQbmv7RK1jDeuggAFN6ICAADFm8A==
Date: Tue, 28 Jun 2022 08:52:37 +0000
Message-ID: <BN9PR11MB5276EBFC3D990EA8EDEDF8C38CB89@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20220621144353.17547-1-baolu.lu@linux.intel.com>
 <20220621144353.17547-8-baolu.lu@linux.intel.com>
 <BN9PR11MB5276297FAEB8C9774AABAD208CB99@BN9PR11MB5276.namprd11.prod.outlook.com>
 <543603e3-9d08-59ee-01f2-8dd6e7c73a15@linux.intel.com>
In-Reply-To: <543603e3-9d08-59ee-01f2-8dd6e7c73a15@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 996dc67b-4a5a-4487-2838-08da58e38d1e
x-ms-traffictypediagnostic: CH0PR11MB5377:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zrzVwjXleT65KtdmSwcvRZLgEYaZKv4nLae10E8y5pU1NqWFUBiQjavLEcrm5pQ/Wt5BLANEq5qMutd+arvchWD+roF0WXThFK9JhmI1hlQ5FSlWTrgA7Jwzwdy4VqShc4FBuhQB6TC4xUDEh3866EPfCd7qSE4OQ5zSZ6ruI0ObPbZHbnD58AeGLOw5Iv/DLYiirBUpd/OI2VgjZsYzcUSL1f2QttTkauGFIxQhJJ2QCNHVbrn0JwaaMGoSebRrJUzmbQaWVe/GX4F5QE3MJY8VBUfceghXr1xSdpgobj/+z68RqB8zngoCyI7n5dZpy1IAYKu5Mmdz0pRLSu+vcI19QQqrSYSgnaaoXfH9XlFO19jOiD66g88ZZYe5pmbfRSg0l+R4Qp2nzTi4huUQeSxL5wbgbdQ6mO4i2vpwz5B6oDt0uf+xdJLC0x8u7mqGPtGI/5jRCuQCBAlSB0Eq1npCtt+8imxnOArRpBz9IN8QBMYnTDlHrVJtBgIaeg+XiyyByjsztzRVCG5hhcUoWBD608eRanElphvSuFPgpREBZ6INa8qeN2StUfk9pVaRDflHM00MwvRZhglOlMA0nVsTYJiReQ1zf8yw1UjTzsnUU6hDP16F/Kh98Hv2+DWa8AFuEj44vBxAN6iNGokDSKSCAelO3BJXb7so1ibN8V5eV+fsWHb4jnj8di79qttwBYLrwQ/r/lZmMXQSGkzrUI7EGXSvwoBvqif/uAlj9xMPpK3nErLKucySNFKdcbO034te0POL+2YczxlMpOA6qk4QGgpR8fLuLlY/QVG3gDOrBiqyo/yxjM8MB3/n/kul
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(346002)(396003)(136003)(366004)(376002)(8936002)(7696005)(2906002)(6506007)(86362001)(26005)(38070700005)(9686003)(5660300002)(38100700002)(66476007)(478600001)(7416002)(41300700001)(122000001)(33656002)(52536014)(921005)(82960400001)(110136005)(76116006)(66556008)(66446008)(64756008)(55016003)(8676002)(66946007)(316002)(71200400001)(54906003)(4326008)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bnhyZk9naDcvZFJMRVZxOFEwU0wrV3pGYUs4K2ZpZWU5U3hWbEE1VUJLZ2Ni?=
 =?utf-8?B?MHJsMnF4WVN3bzV4US9MNGlTV0I1NTBzSC96alhCT0ZnbEpRbkl6Z3Y4QkxE?=
 =?utf-8?B?S2VZeWtsc3NVZ0RJRG9JN0c4MGhGb1lUcS9TWk9tSnRTZ2pnaWFlcG1YU0Jn?=
 =?utf-8?B?Qk85TzRRNmhmdkY3bUpYZ0xZVDh1MENncW5sTGVIQjkxbXFjOC9oZkhLdXQ0?=
 =?utf-8?B?a3VoQ2t1aE00K1EvbHJWajY0ZXhIaDZaMTdxV2l6ZkMxRDJBb2pUdkxZQ3Bh?=
 =?utf-8?B?OFl3YlFFS1FvdmtpUlc4Yk1aOURhMG1YaXA0blpTdndrODdabERVN1lLWkhR?=
 =?utf-8?B?bU1JTFRIcytyWXpGenFURUtqdmM4K2NkS0JQd0dhUWtoTU1HY2lvZEV2OU1S?=
 =?utf-8?B?T3E4NTBtTlBYZzhPWGwzaFRKR09zL3JMY0JPRzVaTXZVQ1lpeGhyOHQrVXMw?=
 =?utf-8?B?eXVHQWlmV3MvZTVpbERFOGt6YWZ4NEVxcUd0MWVpSVpnUUJWcjZybm1iSk1o?=
 =?utf-8?B?OEpmSTVCSnBsZWxvMkwyV2FuVkQ0TFVBcTNDNU5EUm0rQjFDWmJHVENPQkhl?=
 =?utf-8?B?a1hZMFFWZzVPRTNteVZxOGxiTm1FQjRIbVNSR0RnZ21KaXhLRUpFSldsSlEr?=
 =?utf-8?B?Y2YvTkJ5eGwzOEhEeXZxTytLY1FiNENPaFh3dFBQZm1mQklERzdJMHZyZG95?=
 =?utf-8?B?T21DWCtBaHV5b0F5RmRYRld3TUVLRXpHRjVlY2RHbWFCNGluNlBnS25WUnAv?=
 =?utf-8?B?YUlEeVdYRFVsL3VhNklUZnJsU3FuMFBJU1A4cFBmMmZ6bWJTY1BLMzAvOTBm?=
 =?utf-8?B?Z1ppcXFLL3huS1ZmZTF5WStTVktScVE0QXJLRk1JTDZ0SUFpdmQ0ZkJLYnhS?=
 =?utf-8?B?MzMydmlCdEJoNHhjN05FUTAyUzFwRXpJMGlIdmhwU3VWM2JlckZ1a2dab3lw?=
 =?utf-8?B?SXdyUnhYUGsxRnkzR0FudU8vS0ZtVDUxdHV1SmVpdzJ2V01yeExJZmgvV1BY?=
 =?utf-8?B?VkVTN2hoaVdRMDRYZDYyRUc1V0ZvdSs3R1pvRS9lbmhySG95a1hLYnZKUzNR?=
 =?utf-8?B?dHVSajg2bW83MUQ0QUFjNHZCWGFlbHRhT1dIeGlYcHB5OTdNU0hLQ1Y3RmE5?=
 =?utf-8?B?RVMydGN3U1IvZkdzalpFNzllY3JIeXY3cTB0RkZaNEFOeVdsTkxrcnFlRUZT?=
 =?utf-8?B?dUtkYXdKd0R1MFdZbmRBeUJMZjU3OHZ4cXNCdHFsZkdYM081ZmMzUHluREsv?=
 =?utf-8?B?OVlIdnIvRDhBckdzNWVNS1k5cXRnSU9PVjBlbitzQ3FGeUUrMWp1UFN3L0o0?=
 =?utf-8?B?aUFxZWtYOFZiZ3pXcGVzeitSc080bGtLWHlscTZCei9WVzM5U2RuQXhhVFMz?=
 =?utf-8?B?RzZDa1hEVUxIU0NBOXUyUEh2YkRWVG5iTU9CZGQxYVp5Vm16b2xrcVFzdWpZ?=
 =?utf-8?B?WitGVS9EODYrUElhM1pHYzc1dEh3VHJheXViVEhlN0FyMDVueEtWMk9mcFhJ?=
 =?utf-8?B?dEVtR2VCUkZ3eXJNRmE3YThmdnZpSDdqZWFIaFVVL1NFejIxM1VBbWVERWZF?=
 =?utf-8?B?T1h2bEw2Wks1amhydnpveHJHVWtlRGZRckNWSEVMNGpwUHVLQlhBL3dkcExT?=
 =?utf-8?B?WGo5elQxbkx6MGxaK3plVGxORHFLV2daRFd3N3lpdTRZR2hUcGw2R2lMMEE4?=
 =?utf-8?B?WlVIQnR2bEpuSm9OMUx2RjB1STd6L2lSKzkrMzhYU0xmZXFocVlwZmxYMWE1?=
 =?utf-8?B?VUFXS2k0T2szVklGamNtOWtWTi9RZnpIQUtYaVlFbTEyTHJsMEJOejNHeUVF?=
 =?utf-8?B?ZDhwODV2OEZibWJPQU9wRU02ckhpTDVjbUIzWk9UNnV3Z1BRam9TdTk0SHZN?=
 =?utf-8?B?M1hVbTBuRG1VRXVJT1Z3bUgrL2NKSWhMZkFvQmg3N3R3UHR4Z3VFaC9mNXJS?=
 =?utf-8?B?TVNlZngyOHZYVlJsb2RBNSs4UldyZ1RLZnlzTW8wWUhjRzViWUE0b3ppNEFv?=
 =?utf-8?B?aXFENlZkbWtPRkpIOWRUWWgzcUFyNzlPRE5uR0hLazd6WjMvWFZzdmhqbjIx?=
 =?utf-8?B?dHlQU2xMengzRVpzUmd2RDRWMzV6NllJS3FQSVNhdk01SWllVTBrVmhLdTVL?=
 =?utf-8?Q?vwFPra5jHVvnNeb6gqsYbLQJN?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 996dc67b-4a5a-4487-2838-08da58e38d1e
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jun 2022 08:52:37.4105
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eSUZoy6kycn6yvImfrhoQLLNEfUaTGwWN2QLlddxfv7nhgtI8PAnGUJivswM8n02WxlNJVF3o31M5W1m9Ow0cA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5377
X-OriginatorOrg: intel.com
Message-ID: <20220628085237.j8gcOcD6_F3mFPpNuSbrsnwEm0Uhn4pngCbDCxATQm8@z>

PiBGcm9tOiBCYW9sdSBMdSA8YmFvbHUubHVAbGludXguaW50ZWwuY29tPg0KPiBTZW50OiBUdWVz
ZGF5LCBKdW5lIDI4LCAyMDIyIDE6NTQgUE0NCj4gPj4gK3UzMiBpb21tdV9zdmFfZ2V0X3Bhc2lk
KHN0cnVjdCBpb21tdV9zdmEgKmhhbmRsZSkNCj4gPj4gK3sNCj4gPj4gKwlzdHJ1Y3QgaW9tbXVf
ZG9tYWluICpkb21haW4gPQ0KPiA+PiArCQkJY29udGFpbmVyX29mKGhhbmRsZSwgc3RydWN0IGlv
bW11X2RvbWFpbiwgYm9uZCk7DQo+ID4+ICsNCj4gPj4gKwlyZXR1cm4gZG9tYWluLT5tbS0+cGFz
aWQ7DQo+ID4+ICt9DQo+ID4+ICtFWFBPUlRfU1lNQk9MX0dQTChpb21tdV9zdmFfZ2V0X3Bhc2lk
KTsNCj4gPg0KPiA+IExvb2tzIHRoaXMgaXMgb25seSB1c2VkIGJ5IHVuYmluZF9kZXZpY2UuIEp1
c3Qgb3BlbiBjb2RlIGl0Lg0KPiANCj4gSXQncyBwYXJ0IG9mIGN1cnJlbnQgSU9NTVUvU1ZBIGlu
dGVyZmFjZXMgZm9yIHRoZSBkZXZpY2UgZHJpdmVycywgYW5kDQo+IGhhcyBiZWVuIHVzZWQgaW4g
dmFyaW91cyBkcml2ZXJzLg0KPiANCj4gJCBnaXQgZ3JlcCBpb21tdV9zdmFfZ2V0X3Bhc2lkDQo+
IGRyaXZlcnMvZG1hL2lkeGQvY2Rldi5jOiAgICAgICAgICAgICAgICBwYXNpZCA9IGlvbW11X3N2
YV9nZXRfcGFzaWQoc3ZhKTsNCj4gZHJpdmVycy9pb21tdS9pb21tdS1zdmEtbGliLmM6ICBpb2Fz
aWRfdCBwYXNpZCA9DQo+IGlvbW11X3N2YV9nZXRfcGFzaWQoaGFuZGxlKTsNCj4gZHJpdmVycy9p
b21tdS9pb21tdS1zdmEtbGliLmM6dTMyIGlvbW11X3N2YV9nZXRfcGFzaWQoc3RydWN0DQo+IGlv
bW11X3N2YQ0KPiAqaGFuZGxlKQ0KPiBkcml2ZXJzL2lvbW11L2lvbW11LXN2YS0NCj4gbGliLmM6
RVhQT1JUX1NZTUJPTF9HUEwoaW9tbXVfc3ZhX2dldF9wYXNpZCk7DQo+IGRyaXZlcnMvbWlzYy91
YWNjZS91YWNjZS5jOiAgICAgcGFzaWQgPSBpb21tdV9zdmFfZ2V0X3Bhc2lkKGhhbmRsZSk7DQo+
IGluY2x1ZGUvbGludXgvaW9tbXUuaDp1MzIgaW9tbXVfc3ZhX2dldF9wYXNpZChzdHJ1Y3QgaW9t
bXVfc3ZhDQo+ICpoYW5kbGUpOw0KPiBpbmNsdWRlL2xpbnV4L2lvbW11Lmg6c3RhdGljIGlubGlu
ZSB1MzIgaW9tbXVfc3ZhX2dldF9wYXNpZChzdHJ1Y3QNCj4gaW9tbXVfc3ZhICpoYW5kbGUpDQo+
IA0KPiBPciwgSSBtaXNzZWQgYW55dGhpbmc/DQo+IA0KDQpGb3JnZXQgaXQuIEkgdGhvdWdodCBp
dCdzIGEgbmV3IGZ1bmN0aW9uIGludHJvZHVjZWQgaW4gdGhpcyBzZXJpZXMuIDovDQo=
