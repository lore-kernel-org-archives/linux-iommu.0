Return-Path: <SRS0=sTZ6=KD=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AB74C433B4
	for <iommu@archiver.kernel.org>; Sat,  8 May 2021 05:46:23 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C06B861456
	for <iommu@archiver.kernel.org>; Sat,  8 May 2021 05:46:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C06B861456
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 77B87403F2;
	Sat,  8 May 2021 05:46:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hLOFeH7PYmfC; Sat,  8 May 2021 05:46:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id 5A4AF400D1;
	Sat,  8 May 2021 05:46:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 35688C000D;
	Sat,  8 May 2021 05:46:21 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 48EDBC0001
 for <iommu@lists.linux-foundation.org>; Sat,  8 May 2021 05:46:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 37D20403F1
 for <iommu@lists.linux-foundation.org>; Sat,  8 May 2021 05:46:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id EJKuRLK0XeC0 for <iommu@lists.linux-foundation.org>;
 Sat,  8 May 2021 05:46:18 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9DE2E400D1
 for <iommu@lists.linux-foundation.org>; Sat,  8 May 2021 05:46:17 +0000 (UTC)
IronPort-SDR: rU6Yi+fModCRn8Um4ZCB65MfCl6GPLOEMPDghSWmUiLFYoWgxT8oSaeRDEHoKrH53BL4ZSLcwQ
 W/sG2eoggdPw==
X-IronPort-AV: E=McAfee;i="6200,9189,9977"; a="195764633"
X-IronPort-AV: E=Sophos;i="5.82,282,1613462400"; d="scan'208";a="195764633"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 May 2021 22:46:14 -0700
IronPort-SDR: gSxN5uXElMsj2qT+yR8CJ4BcwHoUOxd83fYjg+j23bIb2uqUXHiws+hkDqagEo06tt+SJUNHZs
 QWhqiXmqxGPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,282,1613462400"; d="scan'208";a="390289653"
Received: from orsmsx604.amr.corp.intel.com ([10.22.229.17])
 by orsmga003.jf.intel.com with ESMTP; 07 May 2021 22:46:14 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Fri, 7 May 2021 22:46:14 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2
 via Frontend Transport; Fri, 7 May 2021 22:46:14 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.106)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2106.2; Fri, 7 May 2021 22:46:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U9lKDO2O9Ot1iksWU6k9V8RP5bpY7YX4Zml6h+btvax0tTfJRxi53Msht38aCjJDwhbevL1iL6t+W8fKn63LzDUJLZ5SVYvzTJvzg/S5FkEQCI1wf59MtljpKZoYjnxLpGrzZ2peADiNdPdm6rD8LukdP7q7wntYRPRLfROdSd3URjZ2JuwBR/H2wzHNDJhIyMezY6HOFJweM8t6Gp5IWhWoIC/voIt8hxsjnFKrPM+VV6UuRdtEpKlFYuOIEeUf5/MFbcRUmajUHMXo9McI2m8JvRmPHmEGc2CBKVIMIEQUCFGKPJtecMNW6upEGXeSLag5a6NDWw9miwST/WCBBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QifxiqKM68aD+Y4zhQAHqfPHngOrU7xs8nSqzNmvdjk=;
 b=BIbrcw+4F1bvOUfuXmfCIvn92IBiLa6TeBngjx5SsvKqQ7u64xT4Ck6CJ8K61nxD8jYdwGmmKak0p46HdNnKdjIhethPg2ySCRirK5UzV3CV/lypwqnMCxlO3+UAF/84XVipEntHaAVFTItzu/9jPIbIRQWP9TTVRyiLB98UuBWLrdLirV7QjWHaqHnWDjz4nI5bZJuBi+CzrcV5iDHB36SHTHpeB7GP04uxT0g82PFz+l2De0K2j6gZFPaIf9OtfHKhpknKnJPljpPV+L7Gq6PBXAAp74gLAMt6QHscvS+BmeWhXdJXNnjRxBXBpmoqhXtTMBmk6bnaJQkqnUDfyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QifxiqKM68aD+Y4zhQAHqfPHngOrU7xs8nSqzNmvdjk=;
 b=zMlZqR5yg1Z2aN2Va6OSrmGUVJggjdgzdD8HCMMSwO7CFO0XHtqq109N5y2rgOc0/XIzvnbe4Mr+PRqCxVXwab6AHnuIdIhjbEMNAaUshDkKjBEaL3J1U+ZZU5tpOyRQk6pL8uqVbxVURgGRbdalQbQWCNqOBRUSyyM5DCEniwU=
Received: from MWHPR11MB1886.namprd11.prod.outlook.com (2603:10b6:300:110::9)
 by MWHPR11MB1935.namprd11.prod.outlook.com (2603:10b6:300:10c::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25; Sat, 8 May
 2021 05:46:09 +0000
Received: from MWHPR11MB1886.namprd11.prod.outlook.com
 ([fe80::75b0:a8e9:60cb:7a29]) by MWHPR11MB1886.namprd11.prod.outlook.com
 ([fe80::75b0:a8e9:60cb:7a29%9]) with mapi id 15.20.4108.030; Sat, 8 May 2021
 05:46:09 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: RE: [PATCH V4 05/18] iommu/ioasid: Redefine IOASID set and allocation
 APIs
Thread-Topic: [PATCH V4 05/18] iommu/ioasid: Redefine IOASID set and
 allocation APIs
Thread-Index: AQHXDZub0CDG82VGXUmLEYgvMuPs4KqKkLIAgACg94CAAC72gIAAD04AgAADogCAAErUgIAETQEAgAOaswCAB7C3gIAAhxQwgADYDACAATCSAIAAVGMAgAELsQCAACiXgIAAVBgAgAAaMwCAAAESAIAABy2AgAAgOYCAFdCAgIAAppUAgADsNgCAACqygIAHsmaAgAAzsYCAAAjdgIAAD/yAgAAcQgCAADqggIAAk6nQgABIUACAASsnkIAAYWwAgALs9qCAAdeZgIACip7wgAEiVwCADrrawA==
Date: Sat, 8 May 2021 05:46:09 +0000
Message-ID: <MWHPR11MB18861BF1CEA9AEA0B8CB2B0C8C569@MWHPR11MB1886.namprd11.prod.outlook.com>
References: <20210421175203.GN1370958@nvidia.com>
 <20210421133312.15307c44@redhat.com> <20210421230301.GP1370958@nvidia.com>
 <MWHPR11MB1886188698A6E20338196F788C469@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210422121020.GT1370958@nvidia.com>
 <MWHPR11MB1886E688D2128C98A1F240B18C459@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210423114944.GF1370958@nvidia.com>
 <MWHPR11MB18861FE6982D73AFBF173E048C439@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210426123817.GQ1370958@nvidia.com>
 <MWHPR11MB188625137D5B7423822396C88C409@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210428204606.GX1370958@nvidia.com>
In-Reply-To: <20210428204606.GX1370958@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [101.80.65.46]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 04fb36bc-af60-4673-e5cd-08d911e494e7
x-ms-traffictypediagnostic: MWHPR11MB1935:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR11MB19352275E4B23ADD601143BF8C569@MWHPR11MB1935.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oqac7lqgG0g0apDgAsNyM5IkIAoLB/fhAPSsHHSk/MSXSDE2OTVLg8ogpGdytWVEKZs0Zqgyu/bU08lEnKU4NTjKiyn6JbJLWpdqFFtrIwfT1ZowNIi0nCnWWMJP5o/7YwGclnMgEufWvcbBxDGtsGPsi67/D5L6zGggx9oP3x3Pn+alrSuilB+plWXIJhPSUEagZ0epwPbaDWJWIdya7yONgSVnYWTKqz7HCzVpTcKI7pFYXFfeL1mP0tZxOqtjolbakCZzW+s0ygxCK+xGI+rOLiv5oX4MgbPWMfk0bPh78/vRmbhvpm8aORr0jvDWaCXao1azuVsFR6uq+u6jMLRWp+6SndUYw2hpsIimlDFmNlS+FtmTv/XNQpRB9AyYPoZjCinZhmLYaixmoOoxZDtFbmkeokv9XNAfS6Mzk3JU8vmrbFAY3KL4IT17lDWMZrr7ankQGcdKOeAiCCJP4uxR2KXMKMVtNSz9FgQ/3vSOyG04VsaHvoce6yMxuBHRd02y7HX5Ysjte3rvtlrQeyY1jijT3nCOSmb8asWYpgewkhl2ijQTXBqcIRF6z1XMXLyYwIIESdGpZRPralSDeCfIvQLE3aCj4C3vmoogSM0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR11MB1886.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(396003)(39860400002)(376002)(136003)(346002)(366004)(8676002)(7696005)(6916009)(6506007)(9686003)(66476007)(64756008)(71200400001)(66946007)(76116006)(66556008)(5660300002)(55016002)(4326008)(2906002)(8936002)(86362001)(7416002)(186003)(478600001)(33656002)(38100700002)(26005)(122000001)(54906003)(66446008)(316002)(52536014);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?utf-8?B?NUpYbnc0UHkyMlhNbmxmVkpwVURpL0VoN3pMN0FjejhjYnFCTEJ0cEd5ejVR?=
 =?utf-8?B?TndsbnFlN1MzdlJ0UUlpUll4cGQxcXhIbzFmMjZuRm5aWDA0UnNSZWxkSUdR?=
 =?utf-8?B?cWkrVFgyKzF0SzNVcGNmT0NvWHl2bTN0K3VLdVRidTRxVGRsV1puK2ZKeTYy?=
 =?utf-8?B?MWVkVE55VTIrZ01KV1NZdSt1RzZFVU1oZjdxcnkwOVh1ZGVxOERDVmkvOHhW?=
 =?utf-8?B?Y3VqYWE1YzBkd3F4WFRpak1MOHkxL0pHUlFGSDFZTHV0blpLZUhKUjBTOVQv?=
 =?utf-8?B?TFNGa3h6eHc2aW9Tb3g1MTVFMkQwU2djNGY4eHlMeXJreWRTc0EycXN3MWdF?=
 =?utf-8?B?WWtRaFc3VzUyVHIrWkpRdU9weXF5aEZ3eldBQUF0WFBmSTI3aWlDS0htOThR?=
 =?utf-8?B?SFhyOWRwMkFobDQrSTkzYkQxaXlyMWZIRW1DbEJOcHYwYmdIUGhadzd1d0Fo?=
 =?utf-8?B?aTZZaUw4S0tvdm1mNGtWR3lIY2hZUCttREZ2RTd5enpoRU1WMGo3MGk0ak1Q?=
 =?utf-8?B?cE0rZVk1S1V4QWpCcXYxSHFJNVBITlVGcVB2L3hqNEk2L2d3aWtkWTZLYlNK?=
 =?utf-8?B?enBXSnJwdUxRQ1Fta1Y1VllLaEdRaUdjeXRsZmxnaXJQVlFwdzRza044anlv?=
 =?utf-8?B?dGtFTEtoZGRLVnYyOVVaZEJ2cXJxSE9tL0Uva2xUSkRlZDFuRzkyK1ZvNzVL?=
 =?utf-8?B?MDVBSndFcmlvU0krMDMzY1hWM2xNT2Y5K1ZvVy9YbEdnZlFEWXIvK1Y4Zzhn?=
 =?utf-8?B?TGFmUGlreWQyZGlTempScVI4U2ZNSnRqTUlTZHduMm5wQTNNSUZSMGhjMWhu?=
 =?utf-8?B?a0IraUV5a2ZTN3JadG5OTUgvakVRNEQ5bnRZck9vY2RKa0JqNzFGRW1lcGpQ?=
 =?utf-8?B?NERUdGx3bXE0VnRBbzh6cTFyM3o4N2hEVUx1OVVkdWtMNEhwQmNVckhiV0Nr?=
 =?utf-8?B?N0ducFhzb3pnaDY2RVdXWDFFWklER0lvQThxV085N3hJS2RiZDV0bFAzWU10?=
 =?utf-8?B?ZWQxL0xlV3B2R0hyTE95NnViZWRNcG9tRzl1TVBCbUNVT0FwdjU2Y3orWmxw?=
 =?utf-8?B?aU15bis0Vk5Sb2VGZXhjVC9xT0lNNFBtL2w0ZEY5Y1RCL05HcTFHOFljeEdV?=
 =?utf-8?B?TjVQMDVIQ3gvSFZ5ekU2eStITDM0aDNWZXFkNC9oZGtBT0JoTlovNnFWcEla?=
 =?utf-8?B?TlpIc3BuM0E3L3BJRVNQd1NVNjdNVkFmN3ZZN0tYdDBOZ0Q4a2ZNNUFlUFhr?=
 =?utf-8?B?VTlNby9nbnVSeDExYXhNOHd2cU92M1VzUnpDalNNeWgwdk1KSU5HTnBuSGk1?=
 =?utf-8?B?aWxiTFRKYUMreTd6SnJicytHdVlwY05CYlNEVWhnVGRMV0dSNDk0eFlINDNh?=
 =?utf-8?B?S0pwNnFjZWw3YWMyVVlzR2czRDBxRjJBNHJqUkw0dHlsSDJybjE5am5mWWtQ?=
 =?utf-8?B?dXNPL1JoN3pVMlRFYWp5V3htajUzd2pZRkc5czBteUZ6NUpzNk9MWTF0dEZG?=
 =?utf-8?B?Y3lqQjVoUmdsaUM4ZTNNRzVCdzNhMVlmUHFjSHRQbnBJMHZBdHlkckc4dm14?=
 =?utf-8?B?T1dBWnE3T2xBdHV4eDFEc0xBR0lTamdxTmlONlZ5QjMrQnFFSjRIYms3T0pt?=
 =?utf-8?B?OXZ5NktRR3Q1d1ppbnJ6T2xoOGluQ2gyTHdycmsveUpnWC81WTA5OUl4aTRK?=
 =?utf-8?B?ektLcmRnVWR1UjcvSXB2Q2tlbGhDN1ZySlkvcW1HYnRlb1IxL2ZDYkpMa2dw?=
 =?utf-8?Q?xTVa/PX/sy/l9peDFE=3D?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1886.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04fb36bc-af60-4673-e5cd-08d911e494e7
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2021 05:46:09.6837 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xEEsZJIo0fI5e2LwB26M/BIcV8Ty9zxvVQTNqiC2o20JmqJMtMDMbQxPjAeDYoMycv4RjVlDAPdgub3h/crbFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1935
X-OriginatorOrg: intel.com
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Li Zefan <lizefan@huawei.com>, "Jiang, Dave" <dave.jiang@intel.com>, "Raj,
 Ashok" <ashok.raj@intel.com>, Jonathan Corbet <corbet@lwn.net>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 LKML <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Johannes Weiner <hannes@cmpxchg.org>, Tejun Heo <tj@kernel.org>,
 "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>, "Wu, 
 Hao" <hao.wu@intel.com>, David Woodhouse <dwmw2@infradead.org>
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

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Thursday, April 29, 2021 4:46 AM
> 
> > > I think the name IOASID is fine for the uAPI, the kernel version can
> > > be called ioasid_id or something.
> >
> > ioasid is already an id and then ioasid_id just adds confusion. Another
> > point is that ioasid is currently used to represent both PCI PASID and
> > ARM substream ID in the kernel. It implies that if we want to separate
> > ioasid and pasid in the uAPI the 'pasid' also needs to be replaced with
> > another general term usable for substream ID. Are we making the
> > terms too confusing here?
> 
> This is why I also am not so sure about exposing the PASID in the API
> because it is ultimately a HW specific item.
> 
> As I said to David, one avenue is to have some generic uAPI that is
> very general and keep all this deeply detailed stuff, that really only
> matters for qemu, as part of a more HW specific vIOMMU driver
> interface.
> 

OK, so the general uAPI will not expose hw_id and just provide everything
generic for managing I/O page table (map/unmap, nesting, etc.) through 
IOASID and then specific uAPI is provided to handle platform specific
requirements (hw_id, iova windows, etc.)

Thanks
Kevin
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
