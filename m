Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5813FC43334
	for <iommu@archiver.kernel.org>; Tue, 28 Jun 2022 08:50:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id DA885404A8;
	Tue, 28 Jun 2022 08:50:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org DA885404A8
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=OKAbof8K
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xVeeLPpHamOO; Tue, 28 Jun 2022 08:50:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 8ACAE4049A;
	Tue, 28 Jun 2022 08:50:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8ACAE4049A
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5439AC0039;
	Tue, 28 Jun 2022 08:50:26 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E212CC002D
 for <iommu@lists.linux-foundation.org>; Tue, 28 Jun 2022 08:50:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id AD756404A8
 for <iommu@lists.linux-foundation.org>; Tue, 28 Jun 2022 08:50:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org AD756404A8
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZIjNGQEYCKCM for <iommu@lists.linux-foundation.org>;
 Tue, 28 Jun 2022 08:50:23 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3E9A54049A
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3E9A54049A
 for <iommu@lists.linux-foundation.org>; Tue, 28 Jun 2022 08:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1656406223; x=1687942223;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=9a8cvSo4n/0WU6ain9aqV8Jx76a/gpcjYmGTQ+nnRS4=;
 b=OKAbof8KtxXRZ5HMZb7W2UGemb5+ju1G6UIkkpUSHtPMYj2aI5oXXVTX
 +XwNsmI4S9fMOuBtM79ZGc8ZblrEIOsPU6ojeM3oKMAUacdZuxph6vrqo
 YArmKtiRa7yg4nBqcukZAkdqbRZvIXnHrdeG3htYWuZwNW3SLeVI3Rt32
 Sddh8bwKQx9APuv4YWttiB0AH/zglegV89EghzSG2eVCCral4/SulwKO+
 Ld469s+P473WkgMthVyP2q/FoXoJrDQCbiAHL/47mKD35DZ+1gXgOPPoW
 mq3YZp874Y7on+/Bdr37ptJ9VSkb5ZdEqYiGeF8lj2cF2hVL9yIhe8VQI A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10391"; a="262089897"
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; d="scan'208";a="262089897"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Jun 2022 01:50:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; d="scan'208";a="540418970"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
 by orsmga003.jf.intel.com with ESMTP; 28 Jun 2022 01:50:19 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 28 Jun 2022 01:50:18 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Tue, 28 Jun 2022 01:50:18 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.107)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Tue, 28 Jun 2022 01:50:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cvw/a9vPiTijGwCnT0UCh47EQV+2VN6txiOAtu5CtFqNDYEYZiV5rcMjvoUX9lTZLkrHoTBYx9WMQQVLjo07jJI2CBqLMUy/muwK3Mj3Xg515TdCjJXoR0qRNBLYhRYBVaQnsTmnRH1IIwRbB+WXbQgWortlZ9V9jTF/7KRZYcOmMlHFUxwqtPRXwFL5qLZDanOm1YRJSKCvWXigXCGmF3P1l0XKcoDpL58LchanGCG7NhcJ8ztsL+6EIwCorwEQb/h1sda78h/JYpB6/AOgSSCcbTU5ZtQ5+N1F5O1WwBSOyl0ix0QtOyS8l5XI6YWp4FmXKSYdq6kdwbimyft7Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9a8cvSo4n/0WU6ain9aqV8Jx76a/gpcjYmGTQ+nnRS4=;
 b=ls+CLZrixrB/0zsN7kKhQruCeQ0blxEZoi4D9adGKOV56ifhMHNbZwqJUwJJ03TJSkbIR5XY+OOVsQXRoo35yzYRPViCNHshbPzU0sZdu50FiQMaqWlx2T3WatsvVTVrJGjzaIaoWa7Ag4eBXMnzW5BoGGAi8Dk8BX4S9ZFUzRVVBqRBo5Mko0RYwnyhWzXUkREO6neEZUa0fiFHUblrbfKFufMENXwwGT1uqtK3XtgnXx6iBtYH8wqo7nn2gs6yxekQSvrYiT+BM+6G3aq2WAaexz3RLDJdMosLYZypu/OITvqfLC0Xj3mjdj8n+mh8I+D2QnLA0dvuNJEDU00W6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by CH0PR11MB5377.namprd11.prod.outlook.com (2603:10b6:610:b8::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.15; Tue, 28 Jun
 2022 08:50:17 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::8435:5a99:1e28:b38c]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::8435:5a99:1e28:b38c%2]) with mapi id 15.20.5373.018; Tue, 28 Jun 2022
 08:50:17 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Baolu Lu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, Jason
 Gunthorpe <jgg@nvidia.com>, Christoph Hellwig <hch@infradead.org>, "Raj,
 Ashok" <ashok.raj@intel.com>, Will Deacon <will@kernel.org>, "Robin Murphy"
 <robin.murphy@arm.com>, Jean-Philippe Brucker <jean-philippe@linaro.com>,
 "Jiang, Dave" <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>
Subject: RE: [PATCH v9 04/11] iommu: Add sva iommu_domain support
Thread-Topic: [PATCH v9 04/11] iommu: Add sva iommu_domain support
Thread-Index: AQHYhX35xSpIBtEUJk2c4sDKhBGbeq1i8Q6wgAFnYgCAADJ2MA==
Date: Tue, 28 Jun 2022 08:50:16 +0000
Message-ID: <BN9PR11MB527679FF12B6D990A5E596A88CB89@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20220621144353.17547-1-baolu.lu@linux.intel.com>
 <20220621144353.17547-5-baolu.lu@linux.intel.com>
 <BN9PR11MB5276FA1A1A8C20786D958C048CB99@BN9PR11MB5276.namprd11.prod.outlook.com>
 <42825be5-e24c-0f95-f49d-5f50d608506d@linux.intel.com>
In-Reply-To: <42825be5-e24c-0f95-f49d-5f50d608506d@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.6.500.17
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9317c51a-c74e-45e4-5389-08da58e3394d
x-ms-traffictypediagnostic: CH0PR11MB5377:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tIIiBP0Wx3wRwtkztYwt5xYcWzpVedqq6iKdbQj/TEIn3k6jUgLg7HuYOQpJrUPg5+tuU6JV5V/FdYP0rtN1mk4qxsr3Viv52cBxJxXjbsA388LtbNsJQ7woYhgjfkGlmj/6nyHxA/Lqg25lEFEWuLIBCNFqFoz2hTQVpmhKGFba6O7g2Aeez63p4A9np2jgaHaXrAT+YvbFHCp1nICeTAELYmOqIHlEoRmUY70p3S0nPb+k3OX3oqLk9VMiotu5EJbkCD+z1Q8z/oE8ytO9Z9XieHMU+Fu/kxMUM4du2ff8XoJhzIO9oycoJ00x0Dzkrq1/rJRfMV4BrSRF7hsNTxAA8bIN/eKIbfv5IKo/YbXW/RdnwlRUGyz1WrsRnbPsjI3aWPrPPHlZWAtJkuE8bLdLGuk4v1V+KD2aqKxryL6Fbpl9Rupey2wBYYI4lz2yfBw67XKLoFXeROJTorD9+yTFzW04cMBNZw7yQgxknWI7M+raRX9cfdeTscr80jEKX+zIFSZpPyeMuwzOzDCcDk54tkGmVBT4NM9YsEcZPV8Dcwt8aN0cc8PLNhkSQhOlSN8WW3GD6L/Ez+Sxv/8mxNKzwWWJN9EmeoUyQNjwxhlffCUXQt6fBfwTIGp2xBajCBpIjRQL+xcKG9Ks3qA12Te8/iZ6U5TGp4NusWO2PrsQXDMn0Qk6hudiOuUmUCzEyi7+p681y0+oiA4D1o4wvKxELbHZnOOAtpFWu/49Bc7E2xKv7RRFbVOq2bCetahn5TIIduxQi6VhBiYp/Wu9dGxjihEWrCD49NpvD8f8tHPNpLU2zIvRhz4YnGYjdL0f0s/q3XPgkUNPO0JvleFWEurHSy/780XJQ70qzBEre3ZoDfoNy0FgYe3YOxoP7L0wJzSrlYDGPlTuA/1TtQdo5A==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR11MB5276.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(366004)(136003)(376002)(396003)(346002)(39860400002)(110136005)(76116006)(66556008)(83380400001)(52536014)(921005)(33656002)(122000001)(82960400001)(66946007)(54906003)(316002)(186003)(71200400001)(4326008)(64756008)(55016003)(66446008)(8676002)(38100700002)(5660300002)(66476007)(478600001)(2906002)(8936002)(7696005)(26005)(38070700005)(9686003)(6506007)(86362001)(41300700001)(7416002)(966005);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a0ZUSlFjclRGbWRnTkZxa04ybDhJajR4N1RSOURoUGtJMjZoNlZHQUpQeTdZ?=
 =?utf-8?B?d3l2WTlGZk1IM2t3WGswL3N0aGgyR2JZWjlFU29CYzg3VXREOUNPSldwVFZX?=
 =?utf-8?B?ZEdHdXpHaFoxNFZZclVyczZSaDRFUURKQXRETEVJU0c1SlNnSWN4ZzZQQk9m?=
 =?utf-8?B?RHhXQm9DdFhFaDBaNjNjY3dPWFFFUlQ2RTJSZmlYTCtoYUdOeEVhb2hGMFNJ?=
 =?utf-8?B?RFMwVTFQTjE4OTZZcC9abWI5SlZnQWp0YTc4T1JtL01hODBheXQreU85dVRO?=
 =?utf-8?B?eVh3SWZ6dVJ3YUtvdFY1d1o3dk9hc0FqTFdlZ3VNNnVpL0ZsazgydUt0N1dQ?=
 =?utf-8?B?bHlGcm4yY2w3YVNiQTVRdDEreFJhcmhpZG1MZ0hweTRwQWN4clpVQ1VtTTRz?=
 =?utf-8?B?cUhDL0tGTFVTN3NGWVJSMS9PVlVxRzFhZSt3Nzd6ZjdRV1NoZHNCZGJqVzZK?=
 =?utf-8?B?VUpCNXd1UjZOUWNOR0x5VzRyWldYWk5EVEhQUVNNd2pHVVRGYlgrWU9CWm5k?=
 =?utf-8?B?ZFJwWFMzU2NSOVFTc1k1QU5iWUloWEI4UlRxTXlCbXozM296RnpiUDB6cXRz?=
 =?utf-8?B?VUdaR05VeEZMVWJOY1kyTnhpM0ZoUk9rQUhLZkUzaHFFU0VDRXlXU1pTd21R?=
 =?utf-8?B?QUtjWTZZUGNEVXEraEgzWGNuN0V6SmE5bkdsTVFYbnhuK2FSZnpIZnJ4SW1H?=
 =?utf-8?B?L1NJQTJORTdFRXJVRmpuQ3ZrSTlrcFBadTFLc2JTOUhhbXFrZmswNlJGK1dh?=
 =?utf-8?B?NzQ1UUMxOXMyKzFKVkJNRUVNZzc0WXJmRElodEw0YlZ0VkRzTnhWN0JFQlps?=
 =?utf-8?B?SVdSVHpSVlpkdUVGc29uZU1NY2ZUOG1QUVQyekRWTi9SZ3RQa0g2WGd4THhL?=
 =?utf-8?B?NjNqWkxCRS9PNGNpRkFnRnJlMnltb3ZFT1pIT1U5ZzZFVldJeWlVT1ZxY3M5?=
 =?utf-8?B?bWxTemR0eGJ0L3pWMy9Za1JKQXRtZmZIbHhYeFpCa0V0QllNMXNqSTlycnli?=
 =?utf-8?B?blg0SVFjbDJDUXVDR2cvRUtpWjVoclBvMCtrdmdmUlM0OHhvYVpjZWw0S25Q?=
 =?utf-8?B?NWlUcFFQc2YrNjRlTWlDWXM4TkVxeDNKS1czMlZVSGkxRnJHd0dxbTFSWjVi?=
 =?utf-8?B?S2Z1emRpcUpyTEZVNGw4MTN0c3AwY1VOTi9PamFKb3dNZTRxelN4VGpsWEpJ?=
 =?utf-8?B?NlY3R0hUdXZsd0dhRjZqQmV3d3R4SXJUK1RnSVJUVEMvN2lrNlpoYWFuS2RK?=
 =?utf-8?B?TURreUNDWEpSQ3NYZXB0MS9kK1NMc2ptWlhyK3pkam1ZUjl3K0tmN2dyNEh0?=
 =?utf-8?B?aHBVMG03N05UU3VneU5nYnhQbzBFTGRYMUhSUkZSZGhsZEpUd2RXV25DSS9N?=
 =?utf-8?B?MUxjVk1lQ283VTM2TFExWk1CUWZzMHlYSERoM0xGZzFxaGQ5anFlWUtwRjRj?=
 =?utf-8?B?N1U0SUtUc1Z5dWNINlc5alBHVk9QSHE0Q0ppVVZYOHNqcGE5cU9Ua2plM2RR?=
 =?utf-8?B?KzJGVXRWQnRLcDl6YXFrMm9jKzhrTGY0T0YrMElUMTNxN0JJRnp3TERobmJx?=
 =?utf-8?B?dFVyMGR3NDd2MUxESkJyNnpOT3J6OEtxMkpHNVVseFRVSVhMcHdmbHlZVnd2?=
 =?utf-8?B?dFQreVhsNnhubHZDOU9TclhhWWxUMGpCS0VvOGJzdDdUV1d3TmRUR3Fnc1hq?=
 =?utf-8?B?S3BYRW5ScXF3UFVLa0hkS003QkxpWW5SNE5uWUFmWHFjeVE0TTFiY2ZidXhR?=
 =?utf-8?B?anFkMHhralNwRVJsczcxK1RpazE4TlVIM1ZTQ2JCb3dzSDhCNThZRHRBMkQ3?=
 =?utf-8?B?YXlpQTZDK29sQjdSbzJqRVdjS00rMzFHVDQzVmY1eWNreDl1Z2g2Q1JOM3hk?=
 =?utf-8?B?cml6TGZXRXZydWFlT3FuREl4NVVmYUV1MG8wRGhWTDNHYUtxVUd3Wm1uTDN6?=
 =?utf-8?B?LzlDa0ZZY3VtK256anpWMGFWZXovclNSa0svT29zbkhZb1JmdkdvREtDbHNm?=
 =?utf-8?B?M1RJUm9zbUcwcjFIT2FFZzdYQml6aVRYcmhMUTl3YWJzNFRDamFJWXovdDBa?=
 =?utf-8?B?OVZBTlRqblBQQXhVdlZCRGFBWDBUQjlyZG1nVlV0cjZOL3hXdUg0Y3pqalJs?=
 =?utf-8?Q?D5FCysJKxBTwry8FSi/HF91Ag?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9317c51a-c74e-45e4-5389-08da58e3394d
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jun 2022 08:50:16.8223 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KIbV5zTx32mOGcG2+RQxFxBWuOxTOpwrwpCOnhDVWjkGSQXtDu5lnSTIGnzNxKSESsLRHsoxvoZ1wYNY34D9ng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5377
X-OriginatorOrg: intel.com
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "Pan,
 Jacob jun" <jacob.jun.pan@intel.com>
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
> Sent: Tuesday, June 28, 2022 1:41 PM
> >
> >>   struct iommu_domain {
> >>   	unsigned type;
> >>   	const struct iommu_domain_ops *ops;
> >>   	unsigned long pgsize_bitmap;	/* Bitmap of page sizes in use */
> >> -	iommu_fault_handler_t handler;
> >> -	void *handler_token;
> >>   	struct iommu_domain_geometry geometry;
> >>   	struct iommu_dma_cookie *iova_cookie;
> >> +	union {
> >> +		struct {	/* IOMMU_DOMAIN_DMA */
> >> +			iommu_fault_handler_t handler;
> >> +			void *handler_token;
> >> +		};
> >
> > why is it DMA domain specific? What about unmanaged
> > domain? Unrecoverable fault can happen on any type
> > including SVA. Hence I think above should be domain type
> > agnostic.
> 
> The report_iommu_fault() should be replaced by the new
> iommu_report_device_fault(). Jean has already started this work.
> 
> https://lore.kernel.org/linux-iommu/Yo4Nw9QyllT1RZbd@myrica/
> 
> Currently this is only for DMA domains, hence Robin suggested to make it
> exclude with the SVA domain things.
> 
> https://lore.kernel.org/linux-iommu/f3170016-4d7f-e78e-db48-
> 68305f683349@arm.com/

Then it's worthy a comment that those two fields are for
some legacy fault reporting stuff and DMA type only.

> >
> >> +
> >> +	mutex_lock(&group->mutex);
> >> +	curr = xa_cmpxchg(&group->pasid_array, pasid, NULL, domain,
> >> GFP_KERNEL);
> >> +	if (curr)
> >> +		goto out_unlock;
> >
> > Need check xa_is_err(old).
> 
> Either
> 
> (1) old entry is a valid pointer, or

return -EBUSY in this case

> (2) xa_is_err(curr)

return xa_err(cur)

> 
> are failure cases. Hence, "curr == NULL" is the only check we need. Did
> I miss anything?
> 

But now you always return -EBUSY for all kinds of xa errors.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
