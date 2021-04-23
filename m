Return-Path: <SRS0=1bbG=JU=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C34EDC433ED
	for <iommu@archiver.kernel.org>; Fri, 23 Apr 2021 10:31:57 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1DAA36145F
	for <iommu@archiver.kernel.org>; Fri, 23 Apr 2021 10:31:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DAA36145F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9B83A41825;
	Fri, 23 Apr 2021 10:31:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Nj2GVhCjZ14v; Fri, 23 Apr 2021 10:31:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id 29CE54059C;
	Fri, 23 Apr 2021 10:31:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 00F52C000E;
	Fri, 23 Apr 2021 10:31:55 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D2E08C000B
 for <iommu@lists.linux-foundation.org>; Fri, 23 Apr 2021 10:31:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B7F66843F5
 for <iommu@lists.linux-foundation.org>; Fri, 23 Apr 2021 10:31:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BfqOrl8viX8k for <iommu@lists.linux-foundation.org>;
 Fri, 23 Apr 2021 10:31:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 320E9843AE
 for <iommu@lists.linux-foundation.org>; Fri, 23 Apr 2021 10:31:51 +0000 (UTC)
IronPort-SDR: 5SIVKe3WeAMcP4UD3JgZyeMaTFy8UCZzeGgZzIe8oBFt4YmhLhFnWCv9OoKhjuucRngD7UWGnn
 JkJ7k85Z5QmQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9962"; a="281376735"
X-IronPort-AV: E=Sophos;i="5.82,245,1613462400"; d="scan'208";a="281376735"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Apr 2021 03:31:50 -0700
IronPort-SDR: 5kRCng3H+6sQcEWuq5pWNqFEgH1U7195zMqSvoM0VIvVdarYDPyScF0UoSr77glVBJf0ndJ4xc
 hzSOMOydq0tQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,245,1613462400"; d="scan'208";a="446551641"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
 by fmsmga004.fm.intel.com with ESMTP; 23 Apr 2021 03:31:50 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Fri, 23 Apr 2021 03:31:49 -0700
Received: from fmsmsx604.amr.corp.intel.com (10.18.126.84) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Fri, 23 Apr 2021 03:31:49 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2
 via Frontend Transport; Fri, 23 Apr 2021 03:31:49 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.176)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2106.2; Fri, 23 Apr 2021 03:31:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LPVPi3/KREIIvlOuzLvgmZ3wFFrWm2zC/ewDrwKvzJggs8WC2PnVPNAlUnIadEaIWF9/ngIURZWbXpOHPws5ZMuOxA0NusPoANTWw+snDiafvpto3iEEmuOUHKApdPoRDsLruBslw71nML4DvW/1LLYhbHYnjW+CXDsnADKM7pDOOsV7+a2Ebh/kCE+WNLqvBt7sGB9cf3O4VBSkzRTd7lM+6VVlvBl6PrlQfAcNVU/ud97jPXgjZ0VqO4cursHHIgnIkQJiMXM4UCBMasi63ai8izWmRAgsqG0wgFyMTRD6LpPEQGqpRjsksPBT+Vr5ZyXt7l1L0idn59iOhe70QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rtbw0XwQHPLtcOqCNsgcpL6rChQ3JJtsNWW01J5XlHs=;
 b=cKykRDj2La4vjWqmdRTU6L52VSInF4rqo9EkzcGMCXnPkQTXFXPNZFxcxwczPZdX8zFm7cOf7e27GFnXA9CFbFaiKduvFt56Cqm3wKwvLy6meaosIG+FuiYlw8F0iswHuOkIgnvhF1iqBJezmuprWFAACeQDDrAmGiBxU1NTO4UB5yAMxqdgbpM9SHisC0f/K7AiwHmOglxRkXXQpdkiQvsIR8NBtz97BMNWTiM8YiChyo2P0zBDniukws+yTKZin4VVWaAmhCHeS40iZf/y471pMov4BP25JOM8bNlZA7tbyKvdXYkfs1XEBVQvb+9/U1ofw5tfShNvI1T4X+Cm0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rtbw0XwQHPLtcOqCNsgcpL6rChQ3JJtsNWW01J5XlHs=;
 b=m2E31/1MgXERFszGjqpDTqKOTWkeNmU5+YZZ5GScBE3pIGc1cLBfNkuXHqXwZxQvNTpJIzVXiZJTUsX7VS0wRDlQWteU1xLe4vX+DPonM6XOZFUFmWrjfyJVxdmpW0gS6m06Thx7gfaQMj3fk1p1/I03NykMKp2Sim/dzwToiYs=
Received: from MWHPR11MB1886.namprd11.prod.outlook.com (2603:10b6:300:110::9)
 by CO1PR11MB5140.namprd11.prod.outlook.com (2603:10b6:303:95::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.20; Fri, 23 Apr
 2021 10:31:47 +0000
Received: from MWHPR11MB1886.namprd11.prod.outlook.com
 ([fe80::75b0:a8e9:60cb:7a29]) by MWHPR11MB1886.namprd11.prod.outlook.com
 ([fe80::75b0:a8e9:60cb:7a29%9]) with mapi id 15.20.4042.026; Fri, 23 Apr 2021
 10:31:47 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>, Alex Williamson
 <alex.williamson@redhat.com>
Subject: RE: [PATCH V4 05/18] iommu/ioasid: Redefine IOASID set and allocation
 APIs
Thread-Topic: [PATCH V4 05/18] iommu/ioasid: Redefine IOASID set and
 allocation APIs
Thread-Index: AQHXDZub0CDG82VGXUmLEYgvMuPs4KqKkLIAgACg94CAAC72gIAAD04AgAADogCAAErUgIAETQEAgAOaswCAB7C3gIAAhxQwgADYDACAATCSAIAAVGMAgAELsQCAACiXgIAAVBgAgAAaMwCAAAESAIAABy2AgAAgOYCAFdCAgIAAppUAgADsNgCAACqygIAHsmaAgAAzsYCAAAjdgIAAD/yAgAAcQgCAADqggIABMLWAgAAMMYCAABwXgIAABlIAgAAsEgCAABE9AIAAqw3A
Date: Fri, 23 Apr 2021 10:31:46 +0000
Message-ID: <MWHPR11MB1886A98D9176B5571530EF1D8C459@MWHPR11MB1886.namprd11.prod.outlook.com>
References: <20210421162307.GM1370958@nvidia.com>
 <20210421105451.56d3670a@redhat.com> <20210421175203.GN1370958@nvidia.com>
 <20210421133312.15307c44@redhat.com> <20210421230301.GP1370958@nvidia.com>
 <20210422111337.6ac3624d@redhat.com> <20210422175715.GA1370958@nvidia.com>
 <20210422133747.23322269@redhat.com> <20210422200024.GC1370958@nvidia.com>
 <20210422163808.2d173225@redhat.com> <20210422233950.GD1370958@nvidia.com>
In-Reply-To: <20210422233950.GD1370958@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.198.147.203]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 80f1cb79-32e2-4e6f-58ca-08d90642ff65
x-ms-traffictypediagnostic: CO1PR11MB5140:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CO1PR11MB51406B90B67DE93CF2F559938C459@CO1PR11MB5140.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Xt6SAYU1yXBjhoMRQ2hNlIyAyLXjL2RWLYkGOA4hgSWnFXm2Ajnf7Jmv/1thvlOMjukVdQJBrycnOF6rUCl/nP44P4E/5aIVvIw8SZXBqpJlQYYw+MKMKDnuqkTXhEQeGAq9601Y0fjOOIYnZzYL2L2s4Yl8OzyQUQpsfd9bsoaHVme5FSOB9ZjIQ55+wr5upU9s1WP4K67BsJfkR0jPjO3ZkTk635d45E0MMwA5OB4CaUkCDpRvyjfCUuPIWGtLu0lkdQ1xDQJsgolPFFVcgCYpVwIdI58soUnKMFmAElf9Oodz6v5Ed/our+teT+4quoD4HdoGW8yDDMAW0sSzUe+QcaDazmLGdbpHiuMkTY33o0KV3TlaM9pVZLXyMXOWRUQtE3qnEcxi97qfetxWYMYd0QvVLMmYRj/GLOHxxKif3s+p+afl+I4v5YZE80NrwVk534OfQ14nUzAUV8nFQ8CCRWFl+TOh5qJBzcoe61JGlEjVNk/NuCN0r9UXvVaGcYis9EK0cQZyk0jS03jMFTo8W58273QuOLZ1Z7MY5z9LfUFbYRF6iTFC3Qjc/y+jTc62bU0oMFY5hZKZjt2YtafJSlO7u6h80Toraa0i964=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR11MB1886.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(346002)(39860400002)(366004)(136003)(376002)(396003)(8936002)(86362001)(76116006)(83380400001)(71200400001)(38100700002)(26005)(316002)(122000001)(7416002)(8676002)(478600001)(9686003)(66556008)(66476007)(64756008)(55016002)(66446008)(66946007)(110136005)(33656002)(5660300002)(52536014)(6506007)(54906003)(2906002)(4326008)(186003)(7696005);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?omqgyC4cLObf2BckkuZLx0/ZY7z679ELs7hlH9oaYqX0KER346EfTeHia1sr?=
 =?us-ascii?Q?xtPUk5+4C8gbaF0h0wTrhT9rBUHV4GFdxkMUJXg4mzq4/enzb0ZX461X1TFd?=
 =?us-ascii?Q?ipI7OVJ3ZZi9GqkU4wkN+WpTxNJo2O/ffvj4C/cWNdjefcls+KFVDV+ZVhwf?=
 =?us-ascii?Q?aYfkoX+eV16fsUIyMP4bmWAZainY165IemO4sB+RyOxqf5ATLv4aeBjrlcdz?=
 =?us-ascii?Q?YDURoq9ApM1kPJmOA86+oBALGzkar77lW+S20PII1uMJ/51VMy0Zk9E4xrsA?=
 =?us-ascii?Q?0Ww3Pz7cDjtrY8UAfD6AMg9XBrh8KEgEDtp9DQd0D/CNfacd6YM07kBZCKTT?=
 =?us-ascii?Q?y9ggHskc+xxZrrmcmKkr0G0X+a/xEbqPwTp9qIoe2lfzC4c3gmtRs84aiLNq?=
 =?us-ascii?Q?WyMHjrWkb8kwgr5cb/twaNWWo/wIwxdlxEEZsoz19NqcpkC+Iz7WuX2QbqHk?=
 =?us-ascii?Q?rquKafisS222hFnMqFHzekJ9dUvEDiTtI3NxKCegqDve3A27dffXhJHIPzac?=
 =?us-ascii?Q?VlopgyndNVBbCquvcFTi3/ULZY93YesCeg4MNi/tvZj/v7S00ij04qEq8iIM?=
 =?us-ascii?Q?yk5FM7bDMAQW8kzFdQ+3Wx7W5yQXa6vHlIT56sR5bcNVeQtTbZHYcmEVpXdx?=
 =?us-ascii?Q?n1k1Y3pPj9s16lFmtNXBDOTa8Hox++kN63gpXChxuZnOhZLwAJ91ctPweTlm?=
 =?us-ascii?Q?akZDR29E/7SQiSGURCIzt9H79JcGWmJK2Z2sOl+LyX73c3U9cTgWjRxA9tdw?=
 =?us-ascii?Q?yxu7fg3YoRwJFVb9TeldbS5fCkih7IWoJVOwu5L6AcMfQoJuPYdozVeFI/ne?=
 =?us-ascii?Q?qH8AMHvx8FY8PDdcJpq9ghiX++nZ1XfaOWboHy/tRoDt2hWeoZW8ggtA4eQ7?=
 =?us-ascii?Q?7XGlexhx2ctbWdWHel6HSjpeH7XYt2X+ExIU+w8JG/4BriXIBJa6GIkiIvIm?=
 =?us-ascii?Q?DhwafZblkJmiwzzSdI6shunGlLmtAXV10oAE9o3KE2CnHbE2a+IIc86Idxr/?=
 =?us-ascii?Q?w1/YOObAp3q5Z095FlIHZhbDY7MiJotSuWGcEhozVbgSDf4Jk3qer4SeS0hu?=
 =?us-ascii?Q?+uZngyB0/IzDBNMESBoioCHLQESSxxrZnB+Pfo/SnkkdBW4FDw3PfJFu0vi8?=
 =?us-ascii?Q?Fcf+TXfOrqG+fQrLqck/4HMSz1hgcj8q2WDoCugq57Q29jDWD+Si/vSEB7P/?=
 =?us-ascii?Q?Xpurp0DDWLtWRT8COkHaPXomYazDH80Od30zfksyhx0rCCgw8q1HV6wFGmp7?=
 =?us-ascii?Q?Xbm05WCtLza7LQ9eFQyGhiJA++mB/tnmjhksfk+pkdm87t8O58fKKEAZpPXG?=
 =?us-ascii?Q?uUtkcXwCdpqlNQzLZ41Vf9SB?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1886.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80f1cb79-32e2-4e6f-58ca-08d90642ff65
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2021 10:31:46.6288 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: k4Xnx4jcszpmWzy98wHbXTV6wXPwoHpue+7RgoAYWuYdz63lNN6jh214y0yeMF9sdPCTcfPkuu9d1x5gEZUr3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5140
X-OriginatorOrg: intel.com
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Li Zefan <lizefan@huawei.com>, "Jiang, Dave" <dave.jiang@intel.com>, "Raj,
 Ashok" <ashok.raj@intel.com>, Jonathan Corbet <corbet@lwn.net>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 LKML <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 David Gibson <david@gibson.dropbear.id.au>,
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
> Sent: Friday, April 23, 2021 7:40 AM
> 
> On Thu, Apr 22, 2021 at 04:38:08PM -0600, Alex Williamson wrote:
> 
> > Because it's fundamental to the isolation of the device?  What you're
> > proposing doesn't get around the group issue, it just makes it implicit
> > rather than explicit in the uapi.
> 
> I'm not even sure it makes it explicit or implicit, it just takes away
> the FD.
> 
> There are four group IOCTLs, I see them mapping to /dev/ioasid follows:
>  VFIO_GROUP_GET_STATUS -
>    + VFIO_GROUP_FLAGS_CONTAINER_SET is fairly redundant
>    + VFIO_GROUP_FLAGS_VIABLE could be in a new sysfs under
>      kernel/iomm_groups, or could be an IOCTL on /dev/ioasid
>        IOASID_ALL_DEVICES_VIABLE
> 
>  VFIO_GROUP_SET_CONTAINER -
>    + This happens implicitly when the device joins the IOASID
>      so it gets moved to the vfio_device FD:
>       ioctl(vifo_device_fd, JOIN_IOASID_FD, ioasifd)
> 
>  VFIO_GROUP_UNSET_CONTAINER -
>    + Also moved to the vfio_device FD, opposite of JOIN_IOASID_FD
> 
>  VFIO_GROUP_GET_DEVICE_FD -
>    + Replaced by opening /dev/vfio/deviceX
>      Learn the deviceX which will be the cdev sysfs shows as:
>       /sys/devices/pci0000:00/0000:00:01.0/0000:01:00.0/vfio/deviceX/dev
>     Open /dev/vfio/deviceX
> 
> > > How do we model the VFIO group security concept to something like
> > > VDPA?
> >
> > Is it really a "VFIO group security concept"?  We're reflecting the
> > reality of the hardware, not all devices are fully isolated.
> 
> Well, exactly.
> 
> /dev/ioasid should understand the group concept somehow, otherwise it
> is incomplete and maybe even security broken.
> 
> So, how do I add groups to, say, VDPA in a way that makes sense? The
> only answer I come to is broadly what I outlined here - make
> /dev/ioasid do all the group operations, and do them when we enjoin
> the VDPA device to the ioasid.
> 
> Once I have solved all the groups problems with the non-VFIO users,
> then where does that leave VFIO? Why does VFIO need a group FD if
> everyone else doesn't?
> 
> > IOMMU group.  This is the reality that any userspace driver needs to
> > play in, it doesn't magically go away because we drop the group file
> > descriptor.
> 
> I'm not saying it does, I'm saying it makes the uAPI more regular and
> easier to fit into /dev/ioasid without the group FD.
> 
> > It only makes the uapi more difficult to use correctly because
> > userspace drivers need to go outside of the uapi to have any idea
> > that this restriction exists.
> 
> I don't think it makes any substantive difference one way or the
> other.
> 
> With the group FD: the userspace has to read sysfs, find the list of
> devices in the group, open the group fd, create device FDs for each
> device using the name from sysfs.
> 
> Starting from a BDF the general pseudo code is
>  group_path = readlink("/sys/bus/pci/devices/BDF/iommu_group")
>  group_name = basename(group_path)
>  group_fd = open("/dev/vfio/"+group_name)
>  device_fd = ioctl(VFIO_GROUP_GET_DEVICE_FD, BDF);
> 
> Without the group FD: the userspace has to read sysfs, find the list
> of devices in the group and then open the device-specific cdev (found
> via sysfs) and link them to a /dev/ioasid FD.
> 
> Starting from a BDF the general pseudo code is:
>  device_name = first_directory_of("/sys/bus/pci/devices/BDF/vfio/")
>  device_fd = open("/dev/vfio/"+device_name)
>  ioasidfd = open("/dev/ioasid")
>  ioctl(device_fd, JOIN_IOASID_FD, ioasidfd)
> 
> These two routes can have identical outcomes and identical security
> checks.
> 
> In both cases if userspace wants a list of BDFs in the same group as
> the BDF it is interested in:
>    readdir("/sys/bus/pci/devices/BDF/iommu_group/devices")
> 
> It seems like a very small difference to me.
> 
> I still don't see how the group restriction gets surfaced to the
> application through the group FD. The applications I looked through
> just treat the group FD as a step on their way to get the device_fd.
> 

So your proposal sort of moves the entire container/group/domain 
managment into /dev/ioasid and then leaves vfio only provide device
specific uAPI. An ioasid represents a page table (address space), thus 
is equivalent to the scope of VFIO container. Having the device join 
an ioasid is equivalent to attaching a device to VFIO container, and 
here the group integrity must be enforced. Then /dev/ioasid anyway 
needs to manage group objects and their association with ioasid and 
underlying iommu domain thus it's pointless to keep same logic within
VFIO. Is this understanding correct?

btw one remaining open is whether you expect /dev/ioasid to be 
associated with a single iommu domain, or multiple. If only a single 
domain is allowed, the ioasid_fd is equivalent to the scope of VFIO 
container. It is supposed to have only one gpa_ioasid_id since one 
iommu domain can only have a single 2nd level pgtable. Then all other 
ioasids, once allocated, must be nested on this gpa_ioasid_id to fit 
in the same domain. if a legacy vIOMMU is exposed (which disallows 
nesting), the userspace has to open an ioasid_fd for every group. 
This is basically the VFIO way. On the other hand if multiple domains 
is allowed, there could be multiple ioasid_ids each holding a 2nd level 
pgtable and an iommu domain (or a list of pgtables and domains due to
incompatibility issue as discussed in another thread), and can be
nested by other ioasids respectively. The application only needs
to open /dev/ioasid once regardless of whether vIOMMU allows 
nesting, and has a single interface for ioasid allocation. Which way
do you prefer to?

Thanks
Kevin
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
