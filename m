Return-Path: <SRS0=bVsO=I6=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49276C433ED
	for <iommu@archiver.kernel.org>; Thu,  1 Apr 2021 07:04:12 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8DADD61057
	for <iommu@archiver.kernel.org>; Thu,  1 Apr 2021 07:04:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DADD61057
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2B38E40596;
	Thu,  1 Apr 2021 07:04:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id p23uxCYR2kT5; Thu,  1 Apr 2021 07:04:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTP id 692F940539;
	Thu,  1 Apr 2021 07:04:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4CCC8C000D;
	Thu,  1 Apr 2021 07:04:09 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3156FC000B
 for <iommu@lists.linux-foundation.org>; Thu,  1 Apr 2021 07:04:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0AD014052F
 for <iommu@lists.linux-foundation.org>; Thu,  1 Apr 2021 07:04:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZIWd5_OgyIgr for <iommu@lists.linux-foundation.org>;
 Thu,  1 Apr 2021 07:04:06 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 8DA314052E
 for <iommu@lists.linux-foundation.org>; Thu,  1 Apr 2021 07:04:06 +0000 (UTC)
IronPort-SDR: C1/yrqhvWXQxXDyUIU7B8a/C2+ho7r0vdHv0VIarQ/WUN271yK8Tb+JqVYotctqdme1UO/Okbg
 Ohb6QEZBCldA==
X-IronPort-AV: E=McAfee;i="6000,8403,9940"; a="188912312"
X-IronPort-AV: E=Sophos;i="5.81,296,1610438400"; d="scan'208";a="188912312"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Apr 2021 00:04:04 -0700
IronPort-SDR: 0vXiZJNks+gu+pagwTwxvojkIplwjDYbCV7P4hZw3G2qVwRg1YwHNZH5/isj8LnKONxSUfQrJS
 DPwFXQN/I1jA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,296,1610438400"; d="scan'208";a="419055684"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
 by orsmga008.jf.intel.com with ESMTP; 01 Apr 2021 00:04:03 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 1 Apr 2021 00:04:03 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 1 Apr 2021 00:04:02 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2
 via Frontend Transport; Thu, 1 Apr 2021 00:04:02 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.105)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2106.2; Thu, 1 Apr 2021 00:04:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QhVyENoTi8rG74D3pP58PSnNzwxbzu8K7u05+9CsvkTXsrYAcvTXbM+jGSlYagUM+LDSKXL4gKXouj/KXc1TbAwnTZJpWZbxuQ+wHgFaacyU+maZJyAaVPjPt6rVEORpXIwA8Z1+aGKZTqt9rnA/7YiO7p4aV/VlNffKI1dUlzbY/Ic2itntKJBNB4BMzcOP9MrZJ1c9x+rK0Jf/8ShbReGEk/n5FOvheNkoKOtnwSRaH8orsXgLnWBLjiL5/pGiLT7KqjVoWDDbVhGxiYa9RV/3HKGNNxFWfOdHrKau9UeFKXdFhbg31lu1vcy7qTKQS55biHIIvAYt/83CiaiF9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jgHqbNLo4sa9SlKco8MEBhBU/4sgm3IISeMBnw9CVDs=;
 b=R7GAnXneNOyc4z/RfO+a+upmZ8EOi3SyEFuY6cPuj/XxPV9v+0sXn0eeSGbXEKcZ8YlGSmjsxp/EmOKaWHX8vLEkOdK47qjkVA1c2p4NBa8TVcspKf9qiDtmnUaFzxgGcnirIHQ0uTpMrhb0Cha9Vlrr9G5T9UJn/aba/4IyNcNKMEK0eaJGCvPi5i39/YN2+C+jxejkEJeebzDUS0TPPXvq8BMjVlkBDh5/y3iHO58DN0HwauzGiM0myOV8IGjQHw3tan/ZjxyfJM+0uLZ+WggXoECWkVWKSz4RQApBXGAiEqNkUbDOXvM+a+4bQlpJUdvRux/U1OLqyOjBozVliA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jgHqbNLo4sa9SlKco8MEBhBU/4sgm3IISeMBnw9CVDs=;
 b=zEyOHs+1dZ5a/kCPaK93xCXrHPm3iRuyGHxTRZtpjxPzCRu8aZi8ho7aQ/C6FCrQD32hT+9lizjmkJB//lKTUrXpQHXQfwHPhDWNwb1Wr9wim5f4hO8Jc9m79GTLBb+1R6fkMvFsxsgIwJX7VWG2wT8XWexyZK228b6wDXw+tSs=
Received: from BN6PR11MB4068.namprd11.prod.outlook.com (2603:10b6:405:7c::31)
 by BN9PR11MB5354.namprd11.prod.outlook.com (2603:10b6:408:11b::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.25; Thu, 1 Apr
 2021 07:04:01 +0000
Received: from BN6PR11MB4068.namprd11.prod.outlook.com
 ([fe80::5404:7a7d:4c2a:1c1d]) by BN6PR11MB4068.namprd11.prod.outlook.com
 ([fe80::5404:7a7d:4c2a:1c1d%3]) with mapi id 15.20.3977.033; Thu, 1 Apr 2021
 07:04:01 +0000
From: "Liu, Yi L" <yi.l.liu@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: RE: [PATCH V4 05/18] iommu/ioasid: Redefine IOASID set and allocation
 APIs
Thread-Topic: [PATCH V4 05/18] iommu/ioasid: Redefine IOASID set and
 allocation APIs
Thread-Index: AQHXDZuc1/oaTFwUU0WheDxUmLBHiqqKkLIAgACg94CAAC72gIAAD04AgAADogCAAErUgIAETQEAgAOaswCAB7C3gIAAmFuAgADGxQCAAR7PEIAAZiYAgAECgOCAACyd0A==
Date: Thu, 1 Apr 2021 07:04:01 +0000
Message-ID: <BN6PR11MB40687428F0D0F3B5F13EA3E0C37B9@BN6PR11MB4068.namprd11.prod.outlook.com>
References: <20210319124645.GP2356281@nvidia.com> <YFSqDNJ5yagk4eO+@myrica>
 <20210319135432.GT2356281@nvidia.com> <20210319112221.5123b984@jacob-builder>
 <20210322120300.GU2356281@nvidia.com> <20210324120528.24d82dbd@jacob-builder>
 <20210329163147.GG2356281@nvidia.com>
 <MWHPR11MB188639EE54B48B0E1321C8198C7D9@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210330132830.GO2356281@nvidia.com>
 <BN6PR11MB40688F5AA2323AB8CC8E65E7C37C9@BN6PR11MB4068.namprd11.prod.outlook.com>
 <20210331124038.GE1463678@nvidia.com>
 <BN6PR11MB406854CAE9D7CE86BEAB3E23C37B9@BN6PR11MB4068.namprd11.prod.outlook.com>
In-Reply-To: <BN6PR11MB406854CAE9D7CE86BEAB3E23C37B9@BN6PR11MB4068.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
authentication-results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.55.46.56]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f3fc5b80-d554-4d64-a93e-08d8f4dc540b
x-ms-traffictypediagnostic: BN9PR11MB5354:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN9PR11MB5354E06CF070E87441C3C25FC37B9@BN9PR11MB5354.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EMtmMElbJWzeTbC2I3HVOt82vmrV5pbxaAMF8Ou6Hp/Opk9T83RuHcHicEoT4av9o/TC4zeCJRTPZi2sphI7/4xU52qdWiOFyhKoGHU9NNxU2xyXpZiM2++bPwXEHg9YNu5TbFtYocZo7XOILP0+1qV8Ttr0yKm31eb4EzaQDDWDMZ6h1cD1GO0XRhj6OwKFmaKAOm8Yx60nqK0qLH4STc8pYGlF1oC4HiurLvv3Qsy9dAU0GYhRPR1BjmdNDcxevpK7ZFCqVZ5/LErV0EVCYPCr3jxrHmSx/ar6+QYMr1gAzTkNqizJ9/8wBska5UDWt+n9YmmxuojbFYJMdhZgxUty8TVWlv37gZzALQEheypNTDGIbTlCzdUu6xMx7NJpM90ztIQoMQ0UI6TiwloP7ApoWdlnPDOMtpPH9IScn01Kzv44Aa01G/hmiSZbS2e5Y6k83IbZ5gbExBrv3cnIzQlDodG5fOQ1fEQXHzNSxD0gJkdTMQZBGY5U7nukvqrkfdDsN5qyjpJsQqj6BhrvrYAHk5yHCAVLCuzQSjJGKKY5Za2vXbIz10JF8/9SJIZgffjtqsmHWQjwcQln7mLZcn9VEjUXLs1EJgI8VPQAmCcTgTBWvCd3lw5AYyFkrOLb2smtSPP1Tksin6niRbNiDt57ibqzrm50Vf83m0afX5D/keRyQTXMbcI1NwAHBDl/c+r8QnhkroGB/VEpJdFAXLarRtTJXIcb4U7Y3paqrEA1blXIKiXX4RiTUwrJ7feR
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN6PR11MB4068.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(376002)(396003)(346002)(136003)(366004)(39860400002)(6506007)(186003)(8936002)(8676002)(33656002)(4326008)(26005)(966005)(66556008)(478600001)(316002)(71200400001)(9686003)(55016002)(66946007)(2940100002)(66446008)(64756008)(66476007)(54906003)(7696005)(52536014)(86362001)(83380400001)(7416002)(6916009)(2906002)(38100700001)(5660300002)(76116006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?aCn0G+QBvZgNK2DF3pJS+dTVvL6AujbFyIdbBFeC4KK+P2QgPulmuYv5pGmK?=
 =?us-ascii?Q?Im94M9+CV+u50sH8zz1BxnINr5+yqgBR+aQcrOD+RiucTbCjgP8n2HTApFYZ?=
 =?us-ascii?Q?WqN3618bfQwtQxSCJvDlows/j/obIU2yVNopu/mzL+Vw7JBsQewpWtVimLY3?=
 =?us-ascii?Q?eNuW2vgNSo+3GS9zVPVz9GN5BWgCu2WKg11PGuj8wZIbh1UiwWs+q924wZfH?=
 =?us-ascii?Q?7NJZmyncyAXWb+LImYbeCKRBZAHwhgNjalF9qkrpZnkEq9KM+Qq2s6LA1zUk?=
 =?us-ascii?Q?aJXOdkOIgBkQkENYgkdMoWIrEEVjO5REq5nd5qaE4HIXTYZx1EbmJZhIkhx/?=
 =?us-ascii?Q?+aLpbYRWuVyZdD+CY3lvWSN3RPWwifbx4Uqf0RRHme5As9V9DhzeIO3FPTLV?=
 =?us-ascii?Q?7qQxsfVcijHb2JRUCDWBiHhOlLYXWVJPPis5pqzjFECeI3OX4o8wqw+lkmYd?=
 =?us-ascii?Q?jg4dw70Q+EK0yLnlZJU/sUu1a/0Ag8ytuYPWlMG9jVllBukw7hXyW7UTa6qD?=
 =?us-ascii?Q?2Zny/TNP/HCI+rlKdY18lifPOGMJOE+mSX18CUMm1Wac8AVQClR1zr4QhtRa?=
 =?us-ascii?Q?KHb9PZ9cgH4Nxk9Nx0RL2JXVq1maQefNLQ98JpT0jenvAUsj0tyciSfLpWTf?=
 =?us-ascii?Q?c+wDjTauedVlsDVqfkL2baqi6l7z3qmdBPEferAb7sM+uVCjlxEtAnT4EylC?=
 =?us-ascii?Q?UxtMJCXsmV4QH0c1ANc6M+LNAGZdhQXoHCU98k2K17Onute8Uf8d/E5VNg1E?=
 =?us-ascii?Q?2WRAqlKFURR7Q/TtOvwYuGPEN3pldjoxTXGWmZSjQxaVmrJHEEJv2achvdkq?=
 =?us-ascii?Q?5Gk3bFD9h0CEyf3Rk/Lbb7Tv8Qbh04y58vwg4EqIXsz+Mx5+saOGH5zpG/PR?=
 =?us-ascii?Q?9V5HqVnj5GFK7AsaIHNAKsDQvYwY4NHAXk8VeVHWSiv0ekfaqh9DwpPS++x6?=
 =?us-ascii?Q?aNgf8xvCCBuNLqJHNA5/skByLCHvKI1qnWv49ObcX1VWz4F95a+0MtYpX+IQ?=
 =?us-ascii?Q?mgqu/SArk0uUpGKcg9TT0cHY+1kEy0xbpH/tZo0HIHH4k93aaZEPokQHc3Vc?=
 =?us-ascii?Q?IoUWtWMUNzrWn0mCi8EhUZYbTnwKBmMqfKHGdlj9Xy1DXv3swj5JdZYTyFGS?=
 =?us-ascii?Q?p8TDSnB6kOGugJEW+CLdEEM5YR8dLgkA4PmYRRpZpAFnDOepyjcu9ZQEbrgT?=
 =?us-ascii?Q?xtK81D5F3VYuLJbNXMBdS4hcC17m/U6bo9j8lWEOLOXApDL7Xs7qkZz2Jgea?=
 =?us-ascii?Q?xgissCMpBv9C6lLZ2hzrh4nW6PlsxKrenB6Qe2uax8CYJx5+XSHOW45dLYsS?=
 =?us-ascii?Q?6ZTJYcKU092wqhZclnEKoLku?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR11MB4068.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3fc5b80-d554-4d64-a93e-08d8f4dc540b
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2021 07:04:01.2008 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WoQIXHUV1uvjsfD4C1ZPjOsG6mUq9XO+uaAA2drywO/APf3+2e4GQ2ab0aVVEL0tB302cjaoVJ6rzcthfCFa+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5354
X-OriginatorOrg: intel.com
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, "Tian,
 Kevin" <kevin.tian@intel.com>, Alex Williamson <alex.williamson@redhat.com>,
 "Raj, Ashok" <ashok.raj@intel.com>, Jonathan
 Corbet <corbet@lwn.net>, Jean-Philippe
 Brucker <jean-philippe@linaro.com>, LKML <linux-kernel@vger.kernel.org>, "Jiang,
 Dave" <dave.jiang@intel.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Li Zefan <lizefan@huawei.com>, Johannes Weiner <hannes@cmpxchg.org>,
 Tejun Heo <tj@kernel.org>, "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
 "Wu, Hao" <hao.wu@intel.com>, David Woodhouse <dwmw2@infradead.org>
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

Hi Jason,

> From: Liu, Yi L <yi.l.liu@intel.com>
> Sent: Thursday, April 1, 2021 12:39 PM
> 
> > From: Jason Gunthorpe <jgg@nvidia.com>
> > Sent: Wednesday, March 31, 2021 8:41 PM
> >
> > On Wed, Mar 31, 2021 at 07:38:36AM +0000, Liu, Yi L wrote:
> >
> > > The reason is /dev/ioasid FD is per-VM since the ioasid allocated to
> > > the VM should be able to be shared by all assigned device for the VM.
> > > But the SVA operations (bind/unbind page table, cache_invalidate)
> should
> > > be per-device.
> >
> > It is not *per-device* it is *per-ioasid*
> >
> > And as /dev/ioasid is an interface for controlling multiple ioasid's
> > there is no issue to also multiplex the page table manipulation for
> > multiple ioasids as well.
> >
> > What you should do next is sketch out in some RFC the exactl ioctls
> > each FD would have and show how the parts I outlined would work and
> > point out any remaining gaps.
> >
> > The device FD is something like the vfio_device FD from VFIO, it has
> > *nothing* to do with PASID beyond having a single ioctl to authorize
> > the device to use the PASID. All control of the PASID is in
> > /dev/ioasid.
> 
> good to see this reply. Your idea is much clearer to me now. If I'm getting
> you correctly. I think the skeleton is something like below:
> f
> 1) userspace opens a /dev/ioasid, meanwhile there will be an ioasid
>    allocated and a per-ioasid context which can be used to do bind page
>    table and cache invalidate, an ioasid FD returned to userspace.
> 2) userspace passes the ioasid FD to VFIO, let it associated with a device
>    FD (like vfio_device FD).
> 3) userspace binds page table on the ioasid FD with the page table info.
> 4) userspace unbinds the page table on the ioasid FD
> 5) userspace de-associates the ioasid FD and device FD
> 
> Does above suit your outline?
> 
> If yes, I still have below concern and wish to see your opinion.
> - the ioasid FD and device association will happen at runtime instead of
>   just happen in the setup phase.
> - how about AMD and ARM's vSVA support? Their PASID allocation and page
> table
>   happens within guest. They only need to bind the guest PASID table to
> host.
>   Above model seems unable to fit them. (Jean, Eric, Jacob please feel free
>   to correct me)
> - this per-ioasid SVA operations is not aligned with the native SVA usage
>   model. Native SVA bind is per-device.

After reading your reply in https://lore.kernel.org/linux-iommu/20210331123801.GD1463678@nvidia.com/#t
So you mean /dev/ioasid FD is per-VM instead of per-ioasid, so above skeleton
doesn't suit your idea. I draft below skeleton to see if our mind is the
same. But I still believe there is an open on how to fit ARM and AMD's
vSVA support in this the per-ioasid SVA operation model. thoughts?

+-----------------------------+-----------------------------------------------+
|      userspace              |               kernel space                    |
+-----------------------------+-----------------------------------------------+
| ioasid_fd =                 | /dev/ioasid does below:                       |
| open("/dev/ioasid", O_RDWR);|   struct ioasid_fd_ctx {                      |
|                             |       struct list_head ioasid_list;           |
|                             |       ...                                     |
|                             |   } ifd_ctx; // ifd_ctx is per ioasid_fd      |
+-----------------------------+-----------------------------------------------+
| ioctl(ioasid_fd,            | /dev/ioasid does below:                       |
|       ALLOC, &ioasid);      |   struct ioasid_data {                        |
|                             |       ioasid_t ioasid;                        |
|                             |       struct list_head device_list;           |
|                             |       struct list_head next;                  |
|                             |       ...                                     |
|                             |   } id_data; // id_data is per ioasid         |
|                             |                                               |
|                             |   list_add(&id_data.next,                     |
|                             |            &ifd_ctx.ioasid_list);             |
+-----------------------------+-----------------------------------------------+
| ioctl(device_fd,            | VFIO does below:                              |
|       DEVICE_ALLOW_IOASID,  | 1) get ioasid_fd, check if ioasid_fd is valid |
|       ioasid_fd,            | 2) check if ioasid is allocated from ioasid_fd|
|       ioasid);              | 3) register device/domain info to /dev/ioasid |
|                             |    tracked in id_data.device_list             |
|                             | 4) record the ioasid in VFIO's per-device     |
|                             |    ioasid list for future security check      |
+-----------------------------+-----------------------------------------------+
| ioctl(ioasid_fd,            | /dev/ioasid does below:                       |
|       BIND_PGTBL,           | 1) find ioasid's id_data                      |
|       pgtbl_data,           | 2) loop the id_data.device_list and tell iommu|
|       ioasid);              |    give ioasid access to the devices          |
+-----------------------------+-----------------------------------------------+
| ioctl(ioasid_fd,            | /dev/ioasid does below:                       |
|       UNBIND_PGTBL,         | 1) find ioasid's id_data                      |
|       ioasid);              | 2) loop the id_data.device_list and tell iommu|
|                             |    clear ioasid access to the devices         |
+-----------------------------+-----------------------------------------------+
| ioctl(device_fd,            | VFIO does below:                              |
|      DEVICE_DISALLOW_IOASID,| 1) check if ioasid is associated in VFIO's    |
|       ioasid_fd,            |    device ioasid list.                        |
|       ioasid);              | 2) unregister device/domain info from         |
|                             |    /dev/ioasid, clear in id_data.device_list  |
+-----------------------------+-----------------------------------------------+
| ioctl(ioasid_fd,            | /dev/ioasid does below:                       |
|       FREE, ioasid);        |  list_del(&id_data.next);                     |
+-----------------------------+-----------------------------------------------+

Regards,
Yi Liu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
