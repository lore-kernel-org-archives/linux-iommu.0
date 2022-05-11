Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E7CEC433EF
	for <iommu@archiver.kernel.org>; Wed, 11 May 2022 04:09:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id AF33060BAC;
	Wed, 11 May 2022 04:09:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5hNuQH3TaLm5; Wed, 11 May 2022 04:09:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 5989960A46;
	Wed, 11 May 2022 04:09:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 30349C0039;
	Wed, 11 May 2022 04:09:22 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 22ACDC002D
 for <iommu@lists.linux-foundation.org>; Wed, 11 May 2022 04:09:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0A3F94032B
 for <iommu@lists.linux-foundation.org>; Wed, 11 May 2022 04:09:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UkmTySnmUzuv for <iommu@lists.linux-foundation.org>;
 Wed, 11 May 2022 04:09:19 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by smtp2.osuosl.org (Postfix) with ESMTPS id BEE554011F
 for <iommu@lists.linux-foundation.org>; Wed, 11 May 2022 04:09:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1652242159; x=1683778159;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=CYgAm8VkIEi2Noe7oD7fCsCagGNt/QQ50bZOriRVA6Y=;
 b=bNx0HXbr84L9GiHYsKZhhmQWlqOTVsDMDa5H5tmbEGTMIOaHWngJsYjE
 FGtObwir5LRf3TacxdAI1zAfR+985zNXn9erUpTDEErtTFH/PXNx9GYUx
 Esb5MHsKjxVxuGhF+V5vnYWYT6sN4iO37fjsvrVe0YE+LOEHOWxr6JqYN
 bXEcFO5Sjz6GS7T1G++SErVsfl4Bqz1EXRn1/N+0k+Gu7B1VhaVGbmQ1R
 UYNYcTJD+KClxl4zwlYfmB+F/Yr7EP4NYPTZUygIUn3Vj8Y58LGEziA48
 +CkCqA0oKQsm2Tv+d/x3huqF4ajOe3WYbwsfGXYvSFxWu++mDeiUpygUL Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10343"; a="269513135"
X-IronPort-AV: E=Sophos;i="5.91,216,1647327600"; d="scan'208";a="269513135"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 May 2022 21:09:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,216,1647327600"; d="scan'208";a="565977800"
Received: from fmsmsx605.amr.corp.intel.com ([10.18.126.85])
 by orsmga007.jf.intel.com with ESMTP; 10 May 2022 21:09:17 -0700
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 10 May 2022 21:09:17 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 10 May 2022 21:09:16 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Tue, 10 May 2022 21:09:16 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.173)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Tue, 10 May 2022 21:09:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mPttDfyiKZOagg6602zEIBV4lp8AKvgGXIyTmvbKElp71cxoBifKo22/5ujdT2nCgt19u4K1WJwR5nvZGjDeFi4jKjdGEixTdw0NXFsOh5Yv9tuJb+OVU6WlTu8+L7NV+w5cA4o49gBjKjApsV562Z9EgWH9fdogd3sPpLw8k0VBZm5/HQdwIq/qtY4fgshG0Qb/EJoD5VqR3veOFDK60OzLmvMH9rQladXJTHYrkI8WU0D3DAtNT3B/e1GcAFQkmAeRG1bmtxqbsB5cQSfC78DCtKtVPwL53Ep0jeL/et5ZAHs4XCVThtRCb9coXqSGQFhGI3XMz4zMp0vulhvBHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CYgAm8VkIEi2Noe7oD7fCsCagGNt/QQ50bZOriRVA6Y=;
 b=PZ1djHx1eUp4doIGGjo+4mOvDgQaoAgnvLg+jtsuyKcaIx8K41IkLpKRHFZbv0dW7My6wd1zerO3uC1w+ILyhga7iGfCiL4U67ZT0bNhZCxe0D2DPP27VaGW2CmMcWkwxZqOxnKphI/3pC4J5QfjJuZb3kf0oajyFmYc+LcgP7Zi+Ey8DmtcT/z2IJYcW03LEKBjkiNcCl2lG2iH0196R1LA9lBo2i1Q7cuztlNLkhJP0C4MHy6uNYsGmnz4y/tJAP0dQCgDqPPIyjI9wTHnu0TKsJvyI2sInhA+zsJo4Pdm/KIOROgr0wHYYDFdK4EyIQ39LcCFkVAVkUXfAenTXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by BN6PR11MB1697.namprd11.prod.outlook.com (2603:10b6:404:41::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.22; Wed, 11 May
 2022 04:09:14 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::24dd:37c2:3778:1adb]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::24dd:37c2:3778:1adb%2]) with mapi id 15.20.5227.023; Wed, 11 May 2022
 04:09:14 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Baolu Lu <baolu.lu@linux.intel.com>, Jason Gunthorpe <jgg@nvidia.com>
Subject: RE: [PATCH v6 03/12] iommu: Add attach/detach_dev_pasid domain ops
Thread-Topic: [PATCH v6 03/12] iommu: Add attach/detach_dev_pasid domain ops
Thread-Index: AQHYZDYp0YNk67Vgl0egzm2/EdQR2K0YJMoAgADRbwCAABi8UA==
Date: Wed, 11 May 2022 04:09:14 +0000
Message-ID: <BN9PR11MB5276100AC9BBB7DE5CB800CF8CC89@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20220510061738.2761430-1-baolu.lu@linux.intel.com>
 <20220510061738.2761430-4-baolu.lu@linux.intel.com>
 <20220510140238.GD49344@nvidia.com>
 <f56ea479-aa82-37ae-91c3-754816a4ed8b@linux.intel.com>
In-Reply-To: <f56ea479-aa82-37ae-91c3-754816a4ed8b@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c052ef86-335a-4611-5007-08da330402e7
x-ms-traffictypediagnostic: BN6PR11MB1697:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <BN6PR11MB1697C1E088250A32298BBD678CC89@BN6PR11MB1697.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: D2jqEUymicOtWZcKUMMzmZvSEWJSkwWGfCrMhIzxoG8Odyz2bnWsRPKXGM3oKJvoZ+K1sg5riAQhyNBCF9bFXyQOLiZkwhL3QOucmQfLVJUDSU6OB97400/yuGmRD7kUaflWnPsRjuhpTUiHJd+zl20hLCOBa6CGoby3WkWJKBWaYXzAbG0dHgfWLktU9xScKfMwWZJDFju7vv/3WjvpLN5ybMdkS82Is6AR2zge5sRb8DZMBpth6IaFH+VRsPcnIYJ/BmTNR/yjQ5U2Ok0kVGZQf1Pb3ObrK/339uFAi4+eASr0pvMWB2L25jdbaLC2firvgw0AooKXm30KBUu9GYn7bswoSid5QBVwoq5XA7X39bS8pgSiOwwTCrwSM2sgIihzCRvcIblnCu6aWi92NXt8nvtbKgwpW0u3LjiKZcnVir4olLmWqHhTmjslUaHZahry4UD52wEDaphbiLeVXdaOsbDCGLZUQ+W+vfyEuuXgl2PnHhyVb+ScSghcLNQHF9cI/8YXILSKAjzMMUzVNmZSa7phf2/J8RtR4VJg5WWaFZ2+DdSUILFFWBM4fZ3qNv/nQq1y2gf/kRWv5Sd2f+Ln7/Am3fCJB4Hl9eOWKUZfSl9JfS5UfT9TOSHD9LqzfZoTVuY9DxOHopyaQSHhKX8qLZPx2WVVOe8mNBtQlNdkkPi1mhLQzXjQJmZ9nN0gBZ5ZzUEslaU67YhPYC4GTg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR11MB5276.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(366004)(316002)(6506007)(122000001)(38070700005)(86362001)(186003)(9686003)(53546011)(5660300002)(38100700002)(26005)(7416002)(4326008)(8936002)(52536014)(71200400001)(55016003)(508600001)(66946007)(66556008)(66476007)(2906002)(64756008)(33656002)(66446008)(76116006)(83380400001)(7696005)(54906003)(82960400001)(110136005)(8676002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RXF6Q3hCTktWdDVpbGtaRHpmbFhKVC9kMjRTaEl5aWFSKzIvZ3NDb1UyaWlQ?=
 =?utf-8?B?aVZTQ2NNRWJSRS9JUDkvL0d2TExnSEZGVTBPbWhBeUJZajhnNmIyakFyaXFW?=
 =?utf-8?B?OHBmU3o5aU80WThXck81WEdXSEFFV01QNUdPRTczSFh3Z05RWFY0c00xSU1G?=
 =?utf-8?B?cTQ1L1c0aHE5dXBrRGJmd1VzMVg4dk9WZlVxZjZwL2JmQ3kzUDhSMnJqWG5B?=
 =?utf-8?B?L1Y2VmtmS1l3U29laFFrczlLekVXYmpqZWNyYlVEQzdUc2dTUXpWV3RGa1ZO?=
 =?utf-8?B?VU50Nk1iZVl6L3AxSmxaVlBySWZsOXgxMUpEQWVuTzhTb3h5aklCWXNRZkht?=
 =?utf-8?B?cHcxamxzQjVWVnJQRkdmSlBrRTM0VERZT1lCUENic2dVcTFSVy9HamxFamEy?=
 =?utf-8?B?UkZMNSsxMEtZSmNXNFlZREpteVNpb0x5ZFFRR0ZDdUpGeHBJOG1VWFFEVU1W?=
 =?utf-8?B?WlRLT1lsaGYvNnEwY2JscFBFczIwUTZiOC9xNFhXM3JhNWphbnc1d2tZOE96?=
 =?utf-8?B?MjJBTTJzd29vY2IreWhpaHpNVmc2QWo3MEw4K3JqWUsvRWg0Y2NnOXpCN0dy?=
 =?utf-8?B?NGNVeG9pZG9KUm11TndKMXcrMHd5b2oyK2pqRnhyeDFtTk15bENjV2lOVlI2?=
 =?utf-8?B?bVpnVUtkcUFHRGVpNXlFbUFXeDBTOFZjV3o0Wkhub0hPcFBTSGZWQlRreTIw?=
 =?utf-8?B?Umt6ZjVrZDZyU2hzRGdveFNYblpXTEhaOHZReE02MjVWeS9HWUlkdzFCYzM1?=
 =?utf-8?B?SkhjbGxCR3N2VWlPTFRXcjZWVlhQK3o3dGF4eHFLVyt6TlJkNUw0TFlPVGZW?=
 =?utf-8?B?TjNpWUk2NU5WVmtONTBhc0tWa0dxYkhxSjE2bHFKbUNXdG9Ybll4bzN4ZXJP?=
 =?utf-8?B?SnZmZ3NSYnhSVXczY2puaUlyazV5VDkwZHNSNWxzU3VKQnl4VkFOQmFjaFRr?=
 =?utf-8?B?eXJyNXcra3RTYm83b2paSDArTEJwYnc5Z3dmaFhrWUpCTUc4RDR5MU5LRTF6?=
 =?utf-8?B?Z3J1WHZnNWRxaVhwVEJyMXEvOEhXQVkxTGd3RDl3VThsMFpiY201dVh3blpS?=
 =?utf-8?B?N0tUTlF1ODdMSVZEZVpQbEphSytSUi9hbEMwdnJMM0RjcmN3K0ZIYkRWVFFE?=
 =?utf-8?B?NlA5d09La0JFWHFzZkduMWJ6dVhEcnBtY1Y1SXR2alZmNzByV1lNMitYbUEz?=
 =?utf-8?B?a3dReFo4SEhJOURZTkg1WkMyU1E5eFZCQkFRTE0ySDBqdXRTTjhOSWNlU0Zm?=
 =?utf-8?B?ZGluR3Rqa05rWmh6VlZaVjFTQjVVdThmbTE4S2FXOFl4eUpiMzFFY2h1TUVS?=
 =?utf-8?B?dk5mcjVZTXN0dmxaOHJDeWl0bjY0QmJQK2lFdnZOL1N6MGx5bzVPc3hYOExi?=
 =?utf-8?B?czVnREpsUnVxMUEzcGo1aGluc09lVlEyM2YzSVlmRDJaejM0TThkcVA0M1dQ?=
 =?utf-8?B?ay85Ym84LzhIYlBzYlBmMG8ycW9KZ3ZvelBYTHIzSkRpWFlIVitiN0ZBZ3RR?=
 =?utf-8?B?anhaZFRtWi9oTytMdEN4YVNJLzRSSnJITnFMQ1NPems3bmhMMkgrYmhGSmRk?=
 =?utf-8?B?cnhzZDMrTzNaMVoweGFNNmJxczh1MTBBaXMvYytIdENIMlNyY2cvQnZRMGw5?=
 =?utf-8?B?dm1BVVJhdkJUU1JpK0pvdmpMOS9EZnliYm1mY0FXdzU2NHdBcXJPUmxvcG9p?=
 =?utf-8?B?RFV1WjNsbE84THc2d05yTTQ2M0x3SzNCVFdhZkFKSStsbUxBTC9ZY096MDBr?=
 =?utf-8?B?blQyNy9BcTlhYmpuN1RMWWluQmovU2ZIYnM0enJpZ3ozY1VMTGJCeWRBK3A3?=
 =?utf-8?B?WVZsNDV5MmlOT0x3SDd4RVVEaGQ3S3ZNR2FHK1U2WWpJd0FPbkRDVXJpbTk0?=
 =?utf-8?B?OUxISXF0UXNiS0psNU1aQmNZMXBESXZzUkozY0RrRVR5c0xWV0RLazcxR25i?=
 =?utf-8?B?em9EWFdtZDF3bDNNVk1vNHNQeWZrZjhWWTlrandJU0I3UVNWeTNtR2g4cUVZ?=
 =?utf-8?B?R0gzUHhkcDltRUdtR3dCUkdHSWN4TUJoZEFEbTFxbC9Ub3ZVZENKRVJOa3I4?=
 =?utf-8?B?TWhDZjBHVGgwQWNLdHcxZ3NBK0JwclM1TDExc3ppelRyN2pmMXRlVmVSRis4?=
 =?utf-8?B?K0pNRUFESC9HN3QzN1JPNFZYWDd6V0xaQnNYUjJmWVhYQWFQTzQrR0I2TEVI?=
 =?utf-8?B?dUNyK3NEb3BnSkRybThCMEdKcmZGdndGd24wVWlTaHNLLzJpMWFMM2g1K25i?=
 =?utf-8?B?UUladTZ5ZHgyWFVDanlMY3hjVkh4MGduTjZ6TTB6aXgrZVh6bTE2R3RMK1BY?=
 =?utf-8?B?OG1sRmRmYkVrVHRIWDNJV1BWZHZ1K0Vhcll3RkR3TE02M2Z6REVudz09?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c052ef86-335a-4611-5007-08da330402e7
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 May 2022 04:09:14.7321 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gqpyMsq2iXiI9By7t+VGofCx5NDqZNDivD+wMXeF7xXcHqtfYL1gHgeUNEee00C4z+MJ74eTmydx6IbE0pz8AQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1697
X-OriginatorOrg: intel.com
Cc: Jean-Philippe
 Brucker <jean-philippe@linaro.org>, "Jiang, Dave" <dave.jiang@intel.com>, "Raj,
 Ashok" <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Christoph Hellwig <hch@infradead.org>, Vinod Koul <vkoul@kernel.org>, "Pan,
 Jacob jun" <jacob.jun.pan@intel.com>, Robin Murphy <robin.murphy@arm.com>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

> From: Baolu Lu <baolu.lu@linux.intel.com>
> Sent: Wednesday, May 11, 2022 10:32 AM
> 
> On 2022/5/10 22:02, Jason Gunthorpe wrote:
> > On Tue, May 10, 2022 at 02:17:29PM +0800, Lu Baolu wrote:
> >
> >> This adds a pair of common domain ops for this purpose and adds
> helpers
> >> to attach/detach a domain to/from a {device, PASID}.
> >
> > I wonder if this should not have a detach op - after discussing with
> > Robin we can see that detach_dev is not used in updated
> > drivers. Instead attach_dev acts as 'set_domain'
> >
> > So, it would be more symmetrical if attaching a blocking_domain to the
> > PASID was the way to 'detach'.
> >
> > This could be made straightforward by following the sketch I showed to
> > have a static, global blocing_domain and providing a pointer to it in
> > struct iommu_ops
> >
> > Then 'detach pasid' is:
> >
> > iommu_ops->blocking_domain->ops->attach_dev_pasid(domain, dev,
> pasid);
> >
> > And we move away from the notion of 'detach' and in the direction that
> > everything continuously has a domain set. PASID would logically
> > default to blocking_domain, though we wouldn't track this anywhere.
> 
> I am not sure whether we still need to keep the blocking domain concept
> when we are entering the new PASID world. Please allow me to wait and
> listen to more opinions.
> 

I'm with Jason on this direction. In concept after a PASID is detached it's
essentially blocked. Implementation-wise it doesn't prevent the iommu
driver from marking the PASID entry as non-present as doing in this
series instead of actually pointing to the empty page table of the block
domain. But api-wise it does make the entire semantics more consistent.

Thanks
Kevin
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
