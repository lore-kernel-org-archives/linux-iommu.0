Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FD3BC433EF
	for <iommu@archiver.kernel.org>; Thu, 24 Mar 2022 03:15:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E64D983E3E;
	Thu, 24 Mar 2022 03:15:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id f2yI4Nq3D2tj; Thu, 24 Mar 2022 03:15:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 6A34083E15;
	Thu, 24 Mar 2022 03:15:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 305B7C001A;
	Thu, 24 Mar 2022 03:15:28 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0408FC000B
 for <iommu@lists.linux-foundation.org>; Thu, 24 Mar 2022 03:15:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id DF3C24012F
 for <iommu@lists.linux-foundation.org>; Thu, 24 Mar 2022 03:15:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OGamyjF7usTj for <iommu@lists.linux-foundation.org>;
 Thu, 24 Mar 2022 03:15:25 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9962040128
 for <iommu@lists.linux-foundation.org>; Thu, 24 Mar 2022 03:15:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1648091725; x=1679627725;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=r/ZMXwqtblazos1zv7EqwAeBmqYZuHgjSsmfoeAkZjY=;
 b=FgDCVmxXG2CHY7mgsv+vJJ4geOIRltlqu/gDOU3vuPInNVSOOKTlCBU0
 vvuFPvzAiiLSZAuQfXR/qAZb4WYsrePLW0cbNxndrr8AbjvDXRqEQlyig
 fS8/y3EkFstj9FCe3SqpoJPYA5tn24/UCYhsR2t8KqBT8oucODaS+rjLo
 fYPVXZz4ADTmIpmx22Hlx934chm6BEYjfAQa3kNyTAGsflphaUS7bxkRT
 mxShioDWdt+bdx2YwOEJdbY/WCqX/I5W0JeN0K6VI1ST+ZnVFu7c6sQtB
 JnG0IuHPYLNxphh6sRGFo/y+eZSx4Znh336sQIwBBOwMOgU34oAcE8mEs Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10295"; a="258464414"
X-IronPort-AV: E=Sophos;i="5.90,206,1643702400"; d="scan'208";a="258464414"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Mar 2022 20:15:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,206,1643702400"; d="scan'208";a="583927417"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
 by orsmga001.jf.intel.com with ESMTP; 23 Mar 2022 20:15:23 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Wed, 23 Mar 2022 20:15:23 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 23 Mar 2022 20:15:23 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21 via Frontend Transport; Wed, 23 Mar 2022 20:15:23 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.104)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.21; Wed, 23 Mar 2022 20:15:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=loSn3JkTFKcm8v5KOBLU1FD+j1/hJM8WI82qd9m/oHj9dutaS+YyjnhqLRDUYKP4LV77zseUibEoVbPBQIYzqO5ASGMOLXbRhyj2QnRL0sIyC4ULCZJL7PfifU15TrS61ASYjh1pQ/cNGEnCYRjGf2qsk7XX1QX9u95sPSA9jtbI84EBRe5xXFdLADDb9cXIzRFi82bhOsb2JKggtLOU5d0uzVfMPDrr3cfcXTmCM/GSC8rBf1n/8DQ55yU4BVBBl4yNz8ZA9dq1X/ohaJr8VM1dKFWHv/pTsWde/GO00NDDZ1TKOJYYephyV9QqZS0iQrf2Kzb8jnCkehkOSPVwhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r/ZMXwqtblazos1zv7EqwAeBmqYZuHgjSsmfoeAkZjY=;
 b=CQn54nfcMnIoJF5nfjBUAGHLAviVWS9nE5bILLUMVWuwXhpj9sDoiX2INK5znw8u6/PuEKv3r823TgOyYwt0TOV0s7qxUD2fjacTQb91RIXEmKHPj19uZPVdh4czyp76oFb2bfVhF8AuPTs3lr8lVpCm1jcOJgGG/G4qw8rvJRnjBcXkxqRxTSWC84Ol4jnW24NmZAcEmE3p1TaYtfwPjJfSQhjUtmqh6sFTL2Nmw4XZIghTMashE4bZCCzaERVhBLbc8z9UPWUPB9ioJH62bkdHL1twyUkaBbJwY4HqwrBij32d0fhI4SH8waU+aEAHdt72KfW3Ya17qImt59Qr0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by BN8PR11MB3667.namprd11.prod.outlook.com (2603:10b6:408:88::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.18; Thu, 24 Mar
 2022 03:15:20 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::4df7:2fc6:c7cf:ffa0]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::4df7:2fc6:c7cf:ffa0%4]) with mapi id 15.20.5102.018; Thu, 24 Mar 2022
 03:15:20 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Wang <jasowang@redhat.com>
Subject: RE: [PATCH RFC 04/12] kernel/user: Allow user::locked_vm to be usable
 for iommufd
Thread-Topic: [PATCH RFC 04/12] kernel/user: Allow user::locked_vm to be
 usable for iommufd
Thread-Index: AQHYOu2DSsSjQi9eMEu6J1ns8GLP6azLfE8AgAAIMYCAAAjbgIAADNiAgAI1J0CAAAhSgIAAAkLwgAAF7YCAAAOIEA==
Date: Thu, 24 Mar 2022 03:15:20 +0000
Message-ID: <BN9PR11MB5276ECF1F1C7D0A80DA086D18C199@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <4-v1-e79cd8d168e8+6-iommufd_jgg@nvidia.com>
 <808a871b3918dc067031085de3e8af6b49c6ef89.camel@linux.ibm.com>
 <20220322145741.GH11336@nvidia.com>
 <20220322092923.5bc79861.alex.williamson@redhat.com>
 <20220322161521.GJ11336@nvidia.com>
 <BN9PR11MB5276BED72D82280C0A4C6F0C8C199@BN9PR11MB5276.namprd11.prod.outlook.com>
 <CACGkMEutpbOc_+5n3SDuNDyHn19jSH4ukSM9i0SUgWmXDydxnA@mail.gmail.com>
 <BN9PR11MB5276E3566D633CEE245004D08C199@BN9PR11MB5276.namprd11.prod.outlook.com>
 <CACGkMEvTmCFqAsc4z=2OXOdr7X--0BSDpH06kCiAP5MHBjaZtg@mail.gmail.com>
In-Reply-To: <CACGkMEvTmCFqAsc4z=2OXOdr7X--0BSDpH06kCiAP5MHBjaZtg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cc550e21-a0c1-4560-97a3-08da0d448785
x-ms-traffictypediagnostic: BN8PR11MB3667:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <BN8PR11MB3667BA517B11BF84EDDB3FA78C199@BN8PR11MB3667.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2mdXykGL1HzckNbPPgN/lz6tuFtNCzlWjQogVHt7db/3R0MJlmBg8WCtR9R3AevjuQptLJtdl3pPzeIoEqGX8l+biR9yu9hf0XDceqmFcb59YIb4epz3ytPk6S/Reu1MGnNZhczHmERkJJ5KT0rFt8GVt+GZbQXni6Z/jt7zlyDM3MFd32VV+pelvTPN7XKu9X1o0LrZqNsB01ikb9SXrTft/yPgR1/8MdZeeW9L7LzEnyxg8FuLLVaDfSa/lFa8MAXFQMy9bW3w4rUOyaptF/wdXp3fEy6P57XagfMQj9coKQgnZci20+0ZkcbRDRnCGMIAtj4uBiicV0Lkqv9c9UnDxM91Esyf+3xlPMMeng4Z9XX5sD4N3/ko2CBxiC3ZVKwgLXc7+JoKGA7GK1nKGqPO2XPHglYRQVBWeN+GbE12Glh5IYznbZ4ckbubs4qC5QaG1Hm9hplHaC4uEOJ5mqoMIctkuG2AwGZZLNBe+uBEQ+t82vi43wJnjjBF0EUPnwc6kEOmnF00lljaI/fL2mlpEirI2Z8AHw4PmZNKu8lGbV2Ao71Whi/ZLgDhbWy9Lpbn0rX20O0QAo5hbBhQv4CBwetri7WLflQGvL9TYPNS7TYfT8gwZAPiv42Zntrw8df+VEIR5LXnuZvPuwG3X9omq0ejnZR7KJzsgklEg7SCafrD7dl2t+ixgfNL/GJFtMJUbdUEkHAxxWDGwi5L+w==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR11MB5276.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(366004)(83380400001)(186003)(26005)(316002)(55016003)(33656002)(53546011)(6506007)(9686003)(7696005)(122000001)(2906002)(86362001)(66946007)(52536014)(71200400001)(508600001)(38100700002)(54906003)(82960400001)(76116006)(6916009)(5660300002)(38070700005)(7416002)(8936002)(4326008)(8676002)(66556008)(66476007)(66446008)(64756008);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QzUwQmtsY0dQc0FhQUJwMGI0eTNubFZLYzF2L1pUOFVzaHdXYjdLK21NVDdM?=
 =?utf-8?B?bnM3RU1haVpqZVc3K29GZlQ2SjRpa21pZlN6dTJ2K0dEQXZkcjJLMFdUeUJC?=
 =?utf-8?B?bG94Rm56YkNSbTJkaGtZQjJOeWp0VlBNSjcyc2pvNkErK0J5OVhpQmZUbldR?=
 =?utf-8?B?WTU2R1hZMDBCSWU1cVFwa25yS2xVQ05Ob1NtdUp4L3RZZFI4SGRwcGRWRjFB?=
 =?utf-8?B?a2Q1cDBORFNHTXR0eXNQckV2cFRNNDZSZDgvVG1qUXNiRmdhdVhNREdoWWlr?=
 =?utf-8?B?b1cxUXpkOW1hd1FzclRyRnRoYnlERDA5OEZjSlRIdWl6N0NzbHdNck9wWVNC?=
 =?utf-8?B?Nk9Oa2tEaWlhN3pVem5oM3N2YzdYcnZtckk3c0lSUHlKK1NsbzlnejBVbG5z?=
 =?utf-8?B?TFVQTnNxWHgwZE04VmNidVM3N3FOejRHRnU5MS82Z2NSbzByUzNIUnNDY1Rr?=
 =?utf-8?B?QmhGVlY5bGdvMTVKdy9YU0duZFFUc2J0a05tTHhNam00UjBCd1hSNzkzUlhB?=
 =?utf-8?B?QmRBaHZWM2QwRUVwbVJkQ3ZMNVZTYzlzTjVBbXNVWE9rRkM1RGZNSXl0bm8y?=
 =?utf-8?B?bGJvZEF3U0YvanUweUFtQmpRLy9lVm15WnNmU0hXb2E5aW9GeFRWUE1wdEZu?=
 =?utf-8?B?dm9rT3JjM1JNaUljV0NtaUFBK0Z1cno0Z1k3Z1VxdWJmejc3TE0zY1NwamZI?=
 =?utf-8?B?UkIxeXc0VHhaUWdRR3pGSWorSWZFa0haMmxobXorUjZXZVpDc1RreGlWdnd5?=
 =?utf-8?B?L3AyaGpNQThuQkRjTGdFb0h2SHF3WHhoWFlsM3N1UWp3NXhuQjZBU1VwZ0N2?=
 =?utf-8?B?VzNiTlBHTU9HU3VLUHVMMkRCYVJUdDZ0TWpnTWswK0Ircjl1eWNEdGt6TjUz?=
 =?utf-8?B?Y0dML1NTSWhZOUVJOHF3Ni9ZZXdkc0RvYXpDZ3JwOVVETVJtWXNZME9qNkg1?=
 =?utf-8?B?cy9SZ1NGbDIrTUlIcGdpelBVbGZmRTEweXZZL1IxY2hJNWNKL0FJdWdzZkg4?=
 =?utf-8?B?cThHOFBaT012UElFcGNEMkRJa3Y5NkVyU1hmZGNFUk5ZL1lLZjFYZWZ5MHNj?=
 =?utf-8?B?ZXhyeXl0SDgrUk9sdCtsS01XYTdIZWxBMEtHcjA4VHNxQ0JiTjROc01TeGJR?=
 =?utf-8?B?eXNQY0tTV3NNdTI0Znh3dHYveUZMYlZqUzMyQ3l6bGpBRlVHMDROaWpyK1li?=
 =?utf-8?B?QVZnbGk0d3dpWVVISEF3dHpmR3BGQTJrK2JVTy9RTm5QNWhXY1FMS1hLaG0x?=
 =?utf-8?B?b21Tb2JpczRJS0pibW43ZXY5NW5jN1djT1dOd29JUGZJays1TEhHSGNIaXRh?=
 =?utf-8?B?dWxTeEIyUGRqQ1pQSTdyYktJMzlId0VzcGRCVHdxWHdQdVpabVpKUDdnbzE0?=
 =?utf-8?B?a2hHdnl1TXJ2R0lQam44WUxlVWsrK3MvTjFNVjV0dVVpU3E0Mzc0bk1wL0t5?=
 =?utf-8?B?TGd1NlRCZ280c0gySzZVd1VWTTl2eXJLaC9JQlQ5MExGTFRHTzdYOXg3cm1V?=
 =?utf-8?B?ZDVUNVI2cUdjTFF4V0cwTWUvMkw1bGhXZDJjN0JidzZ6RldvT2l5NTNpS3BS?=
 =?utf-8?B?cHZrT1ZWT3JZL2pMRWIyaHV6NVYweGtxTkNoY0lyYmZUMXJLWEh0MkdIUE16?=
 =?utf-8?B?Q1MrV3VGUURzSXBQTG5ZaVZ6cFZvOFhvdHVZcWRFV2V5MEc1UVJUMnJRNmtW?=
 =?utf-8?B?NW92ekltZW5JMURHZ0lTdmNhQzZPdWpPYlZYVEl1YU9LR2ptOGE2TGl0R2pr?=
 =?utf-8?B?SEcxaTdEZjVwcEhUZy9YdE95cFpFckFxNWNqRVNHU2Y0M0QzZkJzNENHVk81?=
 =?utf-8?B?c0lsUVpuQ3RrT1pFL2VwaDZORVgyUnlKSWo4b1M5a05OVXlKdUttZlY0eFlB?=
 =?utf-8?B?azBkSkEydG03YmNsYlhkNWV6dm9hbG54ZCtyYk4yMkF1WDhDTE1JRWpaTW4z?=
 =?utf-8?B?K21XUUtzQ2o3cmpZMWRTeUR0YTdidVV1ZUovM0UxT0tMQzBEV3VZNkpNWmRN?=
 =?utf-8?B?Slg5Rk04UHREWVQ1MklTai9ocE93V2d6OGdDMERiSHJWZjJVQnB6dWJ4VWx0?=
 =?utf-8?B?ZUN1V1VxOG4vbnd1VGpxSU5TSkwvQkhYUnV3NzgyZmNQZ0FYMWFZZklSS3NJ?=
 =?utf-8?B?bDVNbkU5ekpSZnMwTVVvQmxmQWwwUmxseXd1RXBnTE9aa1RvcGk2RCtwRDdm?=
 =?utf-8?B?ZkFPTmd6NnhlVlpJN3cwdVRlVzczMU5uc2p5S0Q2dGd0VHRzWGk4Si9KcFFY?=
 =?utf-8?B?MVNVS1BIWEFPTUFvNnZGck9WUlRqb3VrQjhiVzVtWU5XWENOKzhQemJwb01B?=
 =?utf-8?B?bit2YTZOMGJlM05QK1VIMEttYVBqMXYzM2FYRjZIWGtqWUtlaXhBQT09?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc550e21-a0c1-4560-97a3-08da0d448785
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2022 03:15:20.7869 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SeCAD44ApRV5aZfW0jwgjSKSc99AIxbHSpVstPn9yMVnowa9D1Etn19VqzX2vgKpDw2ycEF1hktTKA9Q7Jkvxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR11MB3667
X-OriginatorOrg: intel.com
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Chaitanya Kulkarni <chaitanyak@nvidia.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 Niklas Schnelle <schnelle@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Daniel Jordan <daniel.m.jordan@oracle.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Gunthorpe <jgg@nvidia.com>,
 "Martins, Joao" <joao.m.martins@oracle.com>,
 David Gibson <david@gibson.dropbear.id.au>
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

> From: Jason Wang <jasowang@redhat.com>
> Sent: Thursday, March 24, 2022 10:57 AM
> 
> On Thu, Mar 24, 2022 at 10:42 AM Tian, Kevin <kevin.tian@intel.com> wrote:
> >
> > > From: Jason Wang <jasowang@redhat.com>
> > > Sent: Thursday, March 24, 2022 10:28 AM
> > >
> > > On Thu, Mar 24, 2022 at 10:12 AM Tian, Kevin <kevin.tian@intel.com>
> wrote:
> > > >
> > > > > From: Jason Gunthorpe <jgg@nvidia.com>
> > > > > Sent: Wednesday, March 23, 2022 12:15 AM
> > > > >
> > > > > On Tue, Mar 22, 2022 at 09:29:23AM -0600, Alex Williamson wrote:
> > > > >
> > > > > > I'm still picking my way through the series, but the later compat
> > > > > > interface doesn't mention this difference as an outstanding issue.
> > > > > > Doesn't this difference need to be accounted in how libvirt manages
> VM
> > > > > > resource limits?
> > > > >
> > > > > AFACIT, no, but it should be checked.
> > > > >
> > > > > > AIUI libvirt uses some form of prlimit(2) to set process locked
> > > > > > memory limits.
> > > > >
> > > > > Yes, and ulimit does work fully. prlimit adjusts the value:
> > > > >
> > > > > int do_prlimit(struct task_struct *tsk, unsigned int resource,
> > > > >               struct rlimit *new_rlim, struct rlimit *old_rlim)
> > > > > {
> > > > >       rlim = tsk->signal->rlim + resource;
> > > > > [..]
> > > > >               if (new_rlim)
> > > > >                       *rlim = *new_rlim;
> > > > >
> > > > > Which vfio reads back here:
> > > > >
> > > > > drivers/vfio/vfio_iommu_type1.c:        unsigned long pfn, limit =
> > > > > rlimit(RLIMIT_MEMLOCK) >> PAGE_SHIFT;
> > > > > drivers/vfio/vfio_iommu_type1.c:        unsigned long limit =
> > > > > rlimit(RLIMIT_MEMLOCK) >> PAGE_SHIFT;
> > > > >
> > > > > And iommufd does the same read back:
> > > > >
> > > > >       lock_limit =
> > > > >               task_rlimit(pages->source_task, RLIMIT_MEMLOCK) >>
> > > > > PAGE_SHIFT;
> > > > >       npages = pages->npinned - pages->last_npinned;
> > > > >       do {
> > > > >               cur_pages = atomic_long_read(&pages->source_user-
> > > > > >locked_vm);
> > > > >               new_pages = cur_pages + npages;
> > > > >               if (new_pages > lock_limit)
> > > > >                       return -ENOMEM;
> > > > >       } while (atomic_long_cmpxchg(&pages->source_user->locked_vm,
> > > > > cur_pages,
> > > > >                                    new_pages) != cur_pages);
> > > > >
> > > > > So it does work essentially the same.
> > > > >
> > > > > The difference is more subtle, iouring/etc puts the charge in the user
> > > > > so it is additive with things like iouring and additively spans all
> > > > > the users processes.
> > > > >
> > > > > However vfio is accounting only per-process and only for itself - no
> > > > > other subsystem uses locked as the charge variable for DMA pins.
> > > > >
> > > > > The user visible difference will be that a limit X that worked with
> > > > > VFIO may start to fail after a kernel upgrade as the charge accounting
> > > > > is now cross user and additive with things like iommufd.
> > > > >
> > > > > This whole area is a bit peculiar (eg mlock itself works differently),
> > > > > IMHO, but with most of the places doing pins voting to use
> > > > > user->locked_vm as the charge it seems the right path in today's
> > > > > kernel.
> > > > >
> > > > > Ceratinly having qemu concurrently using three different subsystems
> > > > > (vfio, rdma, iouring) issuing FOLL_LONGTERM and all accounting for
> > > > > RLIMIT_MEMLOCK differently cannot be sane or correct.
> > > > >
> > > > > I plan to fix RDMA like this as well so at least we can have
> > > > > consistency within qemu.
> > > > >
> > > >
> > > > I have an impression that iommufd and vfio type1 must use
> > > > the same accounting scheme given the management stack
> > > > has no insight into qemu on which one is actually used thus
> > > > cannot adapt to the subtle difference in between. in this
> > > > regard either we start fixing vfio type1 to use user->locked_vm
> > > > now or have iommufd follow vfio type1 for upward compatibility
> > > > and then change them together at a later point.
> > > >
> > > > I prefer to the former as IMHO I don't know when will be a later
> > > > point w/o certain kernel changes to actually break the userspace
> > > > policy built on a wrong accounting scheme...
> > >
> > > I wonder if the kernel is the right place to do this. We have new uAPI
> >
> > I didn't get this. This thread is about that VFIO uses a wrong accounting
> > scheme and then the discussion is about the impact of fixing it to the
> > userspace.
> 
> It's probably too late to fix the kernel considering it may break the userspace.
> 
> > I didn't see the question on the right place part.
> 
> I meant it would be easier to let userspace know the difference than
> trying to fix or workaround in the kernel.

Jason already plans to fix RDMA which will also leads to user-aware
impact when Qemu uses both VFIO and RDMA. Why is VFIO so special
and left behind to carry the legacy misdesign?

> 
> >
> > > so management layer can know the difference of the accounting in
> > > advance by
> > >
> > > -device vfio-pci,iommufd=on
> > >
> >
> > I suppose iommufd will be used once Qemu supports it, as long as
> > the compatibility opens that Jason/Alex discussed in another thread
> > are well addressed. It is not necessarily to be a control knob exposed
> > to the caller.
> 
> It has a lot of implications if we do this, it means iommufd needs to
> inherit all the userspace noticeable behaviour as well as the "bugs"
> of VFIO.
> 
> We know it's easier to find the difference than saying no difference.
> 

In the end vfio type1 will be replaced by iommufd compat layer. With
that goal in mind iommufd has to inherit type1 behaviors.

Thanks
Kevin
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
