Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC817C433EF
	for <iommu@archiver.kernel.org>; Tue, 12 Apr 2022 07:37:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A1CEC410C6;
	Tue, 12 Apr 2022 07:37:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rAAVnpv6kkNU; Tue, 12 Apr 2022 07:37:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 19468410A4;
	Tue, 12 Apr 2022 07:37:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DF21CC0033;
	Tue, 12 Apr 2022 07:37:50 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A51ADC002C
 for <iommu@lists.linux-foundation.org>; Tue, 12 Apr 2022 07:37:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 830214011C
 for <iommu@lists.linux-foundation.org>; Tue, 12 Apr 2022 07:37:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id AoOKOq4i9uKy for <iommu@lists.linux-foundation.org>;
 Tue, 12 Apr 2022 07:37:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B5F75400EF
 for <iommu@lists.linux-foundation.org>; Tue, 12 Apr 2022 07:37:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1649749068; x=1681285068;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=C8LO8vYVLUon+ONyychkpKMpSrIqU1G8Lust1Omohy8=;
 b=ZPlgB7rP3PsichzL2HhjtcK1H6+q7ub/fwTcEmGTu8KT0ui7bwz2OoXh
 MoDybQvt/bnJw/oyx6yBMkC++gl+6j/tAztP9N5yyY26JW38OPGwDxajW
 SW6e2pEaNhgdktXMh24udpe2Le3R1uzdi1+FwAf1nswwKP84TlD9ar8Gc
 T3DOttvEQ1/55wstxVSn35csT/91XzxXXQyaG5g7GdCoCUkvtpN1+W9mh
 qWBiVRqleNNhICBv9PLXl2VzwL4WC9YT3wzTGNo+XnC5pqiX6GENwUkjI
 8Thunl3Q/I8oipPMC5H5n+6k4IW4lbM/aClWVoAjwy/15AUAgHZGMLf7r g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10314"; a="261149937"
X-IronPort-AV: E=Sophos;i="5.90,253,1643702400"; d="scan'208";a="261149937"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Apr 2022 00:37:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,253,1643702400"; d="scan'208";a="660379149"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
 by orsmga004.jf.intel.com with ESMTP; 12 Apr 2022 00:37:44 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 12 Apr 2022 00:37:44 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Tue, 12 Apr 2022 00:37:44 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.105)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Tue, 12 Apr 2022 00:37:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OyvSeWDQqNXNChq6XjvFYgFI4P9XI24nbddVU2IaoTMGQqhWHVNCxEnTCT6gIdFMdyH/AZW+K9NF/HkmK4mn83t7jsEZXnlpihpREWregezZWCQYM9bDvNUihc5EFFDoeIYQg4F+i7stSVaGOZ/dF1muMMrcfLXBBIgMPewSPUVClu+KbQKdJS7bTh9Fb8hgsWFxQLKRucxf07YSsJMtEGSrv1fDn/PjYO2uOj0QRUiowlITxxWGq536MDpGEjxxKmGrAvAoV+v+Ez8T+lqWU1blcs/uvaC4EeB/fwF0m9nJ1JuLtV4ExRjCO6fCVrdCsZ6EB/XwVyssvxtcwA6Ztw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C8LO8vYVLUon+ONyychkpKMpSrIqU1G8Lust1Omohy8=;
 b=BygPwC40zVgScNLa0Z52YlIOcN+ywYiqzA53296Ts7oPMBQFtodwD86F6vvBmeIXL76QvCJW5W6Y838Ss4q+pfLmzhAFvLu58nUhXpzU+OfjWdp0tirjB8hASFQ2T+KK6DA4D50dn/tP6A2sx9fB0HmG3Jfq5aie+izrq/+Z59XM94VgD7WmpEiUEo9xFHHe1s5tRE1f2t0uI2Zh2HFsxJRXgk4A+YKVxiEKuzgryyFYJQOp6Q8ZuXR0Fz2P2OrXrIvor1IAn6PoFPqA0pp59r2OAxV3h7k8JT/YEWx+91AVCiHqO8nig8bkkQqj/0ody4k6sfHHhHFFX+BDSngdyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by CY4PR11MB1462.namprd11.prod.outlook.com (2603:10b6:910:b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Tue, 12 Apr
 2022 07:37:41 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::c4ea:a404:b70b:e54e]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::c4ea:a404:b70b:e54e%8]) with mapi id 15.20.5164.018; Tue, 12 Apr 2022
 07:37:41 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, Jason
 Gunthorpe <jgg@nvidia.com>, Christoph Hellwig <hch@infradead.org>, "Raj,
 Ashok" <ashok.raj@intel.com>, Will Deacon <will@kernel.org>, "Robin Murphy"
 <robin.murphy@arm.com>, Jean-Philippe Brucker <jean-philippe@linaro.com>
Subject: RE: [PATCH RFC v3 02/12] iommu: Add a flag to indicate immutable
 singleton group
Thread-Topic: [PATCH RFC v3 02/12] iommu: Add a flag to indicate immutable
 singleton group
Thread-Index: AQHYTMWQdMRj1LtW7ESP7xJUKRpqwqzrmnCQgAAi0gCAACVF0A==
Date: Tue, 12 Apr 2022 07:37:41 +0000
Message-ID: <BN9PR11MB5276246A53447854DDA8920D8CED9@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20220410102443.294128-1-baolu.lu@linux.intel.com>
 <20220410102443.294128-3-baolu.lu@linux.intel.com>
 <BN9PR11MB527679E5CE0516B2786F57518CED9@BN9PR11MB5276.namprd11.prod.outlook.com>
 <7c70a136-6871-b48c-8e46-852bb1b62958@linux.intel.com>
In-Reply-To: <7c70a136-6871-b48c-8e46-852bb1b62958@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.6.401.20
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9bddad8f-8316-4001-6775-08da1c57537d
x-ms-traffictypediagnostic: CY4PR11MB1462:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <CY4PR11MB1462FB67FB48F832D61D829F8CED9@CY4PR11MB1462.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SwM0jI2j5YQoaJ5dGnte3c1a+2o7aWFCCnbjDgjr/m5ojEzfNewMiEGbvqA4kMT6keDgBUlhUabLpfs9WEbYzSuzK5hd9/Sn5VN0v1A/8d88NcUzXJwQ8njNG0sXgRjLx54pUnRpELgpIbb6NDLS7LG74nv/+85FzQdpOLht5Mijaj01bhJ0R6HXYVv93M0Xq0bjSCvp9eMlcDQpH9NZqOexVBQ0WcuC2buBWpAToCZoFMI/GQ/7CIwwy0WEitDEzJrN+Tj7Xp1RBePjzAHqJSy14StINEeogrMuTcnkxxnnm2/BdRdEk10HEEpYOfXe8LtjGxDcz8iZazOrfxAIe3hdqqufnlKLLZb4pEDmvL+3+5BEbjEbYs7j47fN+tPAB9GmuPxtTaX4CNgLuXkJQW1K1SWmZzLPqcuPd48ZSsb4k0Bh6Z0RroSoNRM2tdX32m9gGiMp59oUoVv+JWP2k0t/3XQlO90cRqdlF86y7tUMCv8SWdmsFykgvU2XNuO5cnSzAeZgK1kcZIiZObUf7XdYckSnD1tE0qFkVEAJM+QJC0atpXmaqHVc48h4WM1HiXsIBAbWqDPE8GwcIui5Jix4Gf297IaSKStT56TwZrbDmMR+64lGobeTYc3uXUZIDJGEMNYrGlfJdnhmAP7nb0rHzGJDie+z4oPXe6l3qua72jdei1KD3HVsynSCZQEWZ4XYVob/+F7y5OS9MhmV3Q==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR11MB5276.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(366004)(508600001)(122000001)(8676002)(4326008)(7416002)(54906003)(110136005)(5660300002)(186003)(2906002)(55016003)(316002)(71200400001)(52536014)(8936002)(86362001)(82960400001)(26005)(6506007)(53546011)(7696005)(66476007)(9686003)(66446008)(66556008)(38070700005)(76116006)(38100700002)(64756008)(33656002)(66946007);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SStkdWdUc1NHVWpkdGtXczlSR29MVzZ0M0lpakNJTFBNb2RiYlR5bmlNTnJh?=
 =?utf-8?B?WWFBVEs5TlpoUVIzMUFyc2JjVDNsYWpGR2gySDdJMUNFejR3OU5VUTBoc2xi?=
 =?utf-8?B?UUJjUTdUQXdFSFRIMElKOVN2S1BFY2pMeEpmN0p4NDRnclBZWUxKaWNxSGNW?=
 =?utf-8?B?bERjM29rWTNpS3NIMDhvcmpySy92R3VHeGQ1bHJ4Y2ZuV00zb1JVcXlUZEI0?=
 =?utf-8?B?a1dRa0F0dkNmdXpOY3NLVE5pbnNQODlUNWJ2M2JxdU1BUkZwSkFYZmpydkRa?=
 =?utf-8?B?cy8zWXBQSVJEMXFQNDRESDVtK0JRNkl4RzQySW1raUdGbFZBN1lOK2pUSEUr?=
 =?utf-8?B?ajVsQ1p0SHlFOENCMFhlU3ZIS1VTaDBBYmpzSi91R2lFUjBqQWlyQzQ2VWo1?=
 =?utf-8?B?ZkVvanZZVkdxQUY0WTJFRmhYSXBXMnkyVysvMzM5d3oyano0bktsYXNuVW9x?=
 =?utf-8?B?bm1DOXBKc1lwdk1yREFuNjcxV3I5UDlIeVRwZUxueFpBYStjTkVjSm0wZFFE?=
 =?utf-8?B?VUo4ZU1lOVRia0lvYlFlNU80SVhNWTR4Qjd6ZVBUcHo1QS8vRHdlMHJSOXR6?=
 =?utf-8?B?QlZpRkFCK3BjeHVTMEZQU1JMME94SDA4Zm04ZWVkTjlwYmJXOEdacHMxckRk?=
 =?utf-8?B?ZlJ0OFZFTE0xQVJqWmVmN0RJRVNUSjdjVjVJaytoOTk0SFRYemhwZXQ4dTJu?=
 =?utf-8?B?Q2IxU3J1OUZvcURTSUJIOFk3NHRrb21jbWV3eFZrNi9UeFQyQVRKVXJDMFh6?=
 =?utf-8?B?eHc5VDlYSFk1UmltTy9vUStOdUI0ZVh4SDV5N1FzUC9MSWVHb2J0TWtnbGdO?=
 =?utf-8?B?cTg1THEyTzl1enVMdnJTa1RWcXJUYnloZWtjMzVFZmpVOXk5aENwclZIQno0?=
 =?utf-8?B?L0xUSlpWLzN6bDhnQ0lIWCt6MmVlWEJkNTI0KzM2UiszeFdCaXpWbCtrWVN6?=
 =?utf-8?B?R0tlOVJ1MmdXb3pMQmluT2ZtQ2o3bGlQc0MrVWNTMjlxaVN1RmNEMGc2ZHUy?=
 =?utf-8?B?NmdsU25CVE1sclppOGc3ZlZRZ2tGVCt1VFFwcXVGTW5zUGhIb0ZCTmNNbmZU?=
 =?utf-8?B?ZDZHQ3ZnR0REdG91ZFM1WEs3UkRaQjdsYnpmUDVHeERNb2w5TGU1WFpZZ2w0?=
 =?utf-8?B?TTJxUGx4K3dvSUFjYkM4Y2NqdHpCamFrWFIzYVM0WlVybHNTeUFINVAydDJN?=
 =?utf-8?B?LzJleUlMTkF6UFlkM2x2cjBaRDZRT25xSU94cDI4OEpKNEEzUks5YmpvV0ZU?=
 =?utf-8?B?elppaGtjY1k1Y2VsS1VsOXF5a2RCY3haQ3VudDFDbFZPYVZFR2k5Y0JhUEQ0?=
 =?utf-8?B?V3FDUVJJN09tMFVCMjdRQW9FSytLRnhnaUE3V3ArMlBxYytCMHh2aEQra1dV?=
 =?utf-8?B?NlJ6cVp0c3Z3cXdaMTZWaklLQ2ZTS1B0NmtYTEZJZGNuYkhVdU43YTl1S2JZ?=
 =?utf-8?B?MkgwbnhneCsxek9DNkNWbjg5dEovTFVwa1ZuNXhsZzNKakdCOU14WkJqUXd2?=
 =?utf-8?B?V1AxZW5CVFhUOGVmUmcyaVBpR1JmMDNNdHFhdDc2NWFNOU9HZ2V0T0l4TTI0?=
 =?utf-8?B?ZUIyeHdTMDBmZ3JzK0c2NVQvcG9xTkc3Rlo4OW1LRzNIbjA0WkE0K0cwQ0oy?=
 =?utf-8?B?c2RVRjFPanArZnAzNnM4ck9WdkRKTlhSK1Q1YVBUd2ZjQlBrZTlJbE4xNHBY?=
 =?utf-8?B?Y0VITjh0V3RrRExYNGlFaEJ2ajcrc0NRYnlHcFhYbnF6bjhIbHM3TzEvZDc4?=
 =?utf-8?B?T2RGNEtGem1zRlpkSEFhUEpxQjEvQzdkS0pFaUJSTEdNUThkRFFoN3krUThs?=
 =?utf-8?B?QzIxVGEzOTJ1Ny9aVFNDNnR4amhIdzV6c0ZGa1R0S1NTZWJFQVJRVlEwMmhU?=
 =?utf-8?B?UHJiREhNc2xLb0prNkxza05HR2lub25IOGhLL0VxbHU1YjhCR0FwRFRTTGV1?=
 =?utf-8?B?S1RaMFo3aGpwMW9Ka0svLzlqVmZOa0s5WnZpUm8wNHFSdnJkSjZjM0JWbFFn?=
 =?utf-8?B?V3BhZ3R3RWMwS0Jva2ZyMStRL09QRGdRaXZkakhLbk1rWDc5eUswaXlVcTlj?=
 =?utf-8?B?R3BGSkZ0Y3JSWGE5ZERCdmZlWjB2UFFQbUUzR2xkL0RiOXRpYjlVd2N1d0NE?=
 =?utf-8?B?SXJLUWVuS0hSY2x4b3U3MFdINnI0VitIaWdOTm1zN0ZnZ1JxTGk5cUpWMmxZ?=
 =?utf-8?B?VkUzZnF5SXBxMFJsdUw1TnY5R3A3MGlyTnB6T2hZU0hnYUsyOStNeXRJUWQ0?=
 =?utf-8?B?dEJ4eDBDR3ZDYWVCc0FEYkxCNitIYlVvL0cyS2hnQ2NZeWd2S0ZWRTJBMFdz?=
 =?utf-8?B?Um5rcXo3b20xVFNyZ2Jqb2F2RytnNEJuczZ5MXpoSVdxTkNRNGVxZz09?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bddad8f-8316-4001-6775-08da1c57537d
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2022 07:37:41.3869 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dVaYC0YWqqyDQJHsE55TLmuOiNTXvqcx1jL21qE3iN2g5gHUOsZMsuLMLZ9u8iXEyGbdUEhV8woF3SbiL7w+5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB1462
X-OriginatorOrg: intel.com
Cc: "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "Pan,
 Jacob jun" <jacob.jun.pan@intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
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

> From: Lu Baolu <baolu.lu@linux.intel.com>
> Sent: Tuesday, April 12, 2022 1:09 PM
> On 2022/4/12 11:15, Tian, Kevin wrote:
> >> From: Lu Baolu <baolu.lu@linux.intel.com>
> >> Sent: Sunday, April 10, 2022 6:25 PM
> >
> >>
> >> This adds a flag in the iommu_group struct to indicate an immutable
> >> singleton group, and uses standard PCI bus topology, isolation features,
> >> and DMA alias quirks to set the flag. If the device came from DT, assume
> >> it is static and then the singleton attribute can know from the device
> >> count in the group.
> >
> > where does the assumption come from?
> 
> Hotplug is the only factor that can dynamically affect the
> characteristics of IOMMU group singleton as far as I can see. If a
> device node was created from the DT, it could be treated as static,
> hence we can judge the singleton in iommu probe phase during boot.

I didn't get this. Let's look at your code in iommu_group_add_device():

 +	else if (is_of_node(dev_fwnode(dev)))
 +		group->immutable_singleton =
 +				(iommu_group_device_count(group) == 1);

Even if there is a multi-devices group above logic will set the flag when
the first device in the group is added since at that time there is only
one device in the group. We need other concrete information  to tell
it similar to how you walk PCI hierarchy to find out the fact... 

> >> +	/*
> >> +	 * The device could be considered to be fully isolated if
> >> +	 * all devices on the path from the parent to the host-PCI
> >> +	 * bridge are protected from peer-to-peer DMA by ACS.
> >> +	 */
> >> +	if (!pci_is_root_bus(pdev->bus) &&
> >> +	    !pci_acs_path_enabled(pdev->bus->self, NULL, REQ_ACS_FLAGS))
> >> +		return false;
> >> +
> >> +	/* Multi-function devices should have ACS enabled. */
> >> +	if (pdev->multifunction && !pci_acs_enabled(pdev, REQ_ACS_FLAGS))
> >> +		return false;
> >
> > Looks my earlier comment was lost, i.e. you can just use
> > pci_acs_path_enabled(pdev) to cover above two checks.
> 
> If a device is directly connected to the root bridge and it is not an
> MFD, do we still need ACS on it? The Intel idxd device seems to be such
> a device. I had a quick check with lspci, it has no ACS support.
> 
> I probably missed anything.
> 

single-function RCiEP doesn't need to implement ACS but this has
been covered by pci_acs_enabled() and pci_acs_path_enabled().
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
