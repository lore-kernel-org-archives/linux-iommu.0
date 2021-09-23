Return-Path: <SRS0=900o=ON=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4559CC43217
	for <iommu@archiver.kernel.org>; Thu, 23 Sep 2021 13:21:05 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A11161216
	for <iommu@archiver.kernel.org>; Thu, 23 Sep 2021 13:21:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0A11161216
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C6AEF84281;
	Thu, 23 Sep 2021 13:21:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id K2HMCHjivF4M; Thu, 23 Sep 2021 13:21:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 79A4084274;
	Thu, 23 Sep 2021 13:21:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 523C2C0011;
	Thu, 23 Sep 2021 13:21:03 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3CBD4C000D
 for <iommu@lists.linux-foundation.org>; Thu, 23 Sep 2021 13:21:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 29EE860612
 for <iommu@lists.linux-foundation.org>; Thu, 23 Sep 2021 13:21:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YtiZz6Igfg1G for <iommu@lists.linux-foundation.org>;
 Thu, 23 Sep 2021 13:21:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 196DF605FD
 for <iommu@lists.linux-foundation.org>; Thu, 23 Sep 2021 13:21:00 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10115"; a="211080122"
X-IronPort-AV: E=Sophos;i="5.85,316,1624345200"; d="scan'208";a="211080122"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Sep 2021 06:21:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,316,1624345200"; d="scan'208";a="436595068"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by orsmga003.jf.intel.com with ESMTP; 23 Sep 2021 06:20:59 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Thu, 23 Sep 2021 06:20:59 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Thu, 23 Sep 2021 06:20:59 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.174)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.12; Thu, 23 Sep 2021 06:20:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j38oVn5j/bqzoMkIFXTAUGJ49B2oaV87LVTKUHvCNsf6r1dOgoa7mKSbW0pU3u+cXgX7l6MFnvxCvqjkSCUJYK363KzyGDIe36OqeZWfqZTW4kY+EVNI8U/f8s8vItF3R2CVWzUtVQCHqRPGQ5B9oeoOzfiKa5bOoRaZ6kPW/m6OKwe5O703kc2REsPYDWxGcbwFRnlhyv6+1HCgPedJ3aXXZjdA0riBTXSYxWaoPN3bd2AMiMuVdo46ON1s3JUKcRgFEkdgCpGoGR1HOjJ0/Ci3QZugqTnyFonB/zPgdaxBvI2+dvkVZQaQQly8tt23cq+g3gHgIATitjnjI6o2BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=fzciJ0z+mWoRrtc0oFpebyaV5+Q8Pepdpm0ci2jY/As=;
 b=TX+SY2AwGQ7p2y7cAz5u8s7azalNVGTdyp4zlA+XzLDNEn4XSRiAC0MKvFeqLc8fMYDDfBqTwTFxqtXYLQBOz18cdPoKXJD4ZW7Kf++Fau/3fxhxymgGbfY7dqKC7E4R8DSLmbnAmU50bE/gTPwxTcr6WAgiHPFrJGvsEcw110hOi3j5wXj8jYVdht44ZWnrQ9ZzH46MqhCrBWwuDX2YraYfUEtzRTk/L1/WghcEMPybvitAUh5ut6uq8VM/PTPklZRyi++cQQCY+zbsnUalepyiYYGwQb4EgqpADm2PLQ7w6gymBKx2AK6qnf5WBGeiEaCUPd/6P+Vwac2/ECfX1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fzciJ0z+mWoRrtc0oFpebyaV5+Q8Pepdpm0ci2jY/As=;
 b=FIFEiiwBgdp8iRxNikNVEaMvWyL3MBxQFiVEearpU8o0nx9uHBYKMQye8cPr+SH+G3rwIMzLTL7Ibws6sreWROXItYtukjaHkruK6KZdpSS9tsX0yEar/wnxvfU+5VUtfkggc15H9TquDuvPtpt6zhbes7aYKo0zvY5NyCaoj+c=
Received: from BN9PR11MB5433.namprd11.prod.outlook.com (2603:10b6:408:11e::13)
 by BN6PR11MB0050.namprd11.prod.outlook.com (2603:10b6:405:68::32)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13; Thu, 23 Sep
 2021 13:20:56 +0000
Received: from BN9PR11MB5433.namprd11.prod.outlook.com
 ([fe80::ddb7:fa7f:2cc:45df]) by BN9PR11MB5433.namprd11.prod.outlook.com
 ([fe80::ddb7:fa7f:2cc:45df%8]) with mapi id 15.20.4544.015; Thu, 23 Sep 2021
 13:20:56 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: RE: [RFC 11/20] iommu/iommufd: Add IOMMU_IOASID_ALLOC/FREE
Thread-Topic: [RFC 11/20] iommu/iommufd: Add IOMMU_IOASID_ALLOC/FREE
Thread-Index: AQHXrSGPLoYXtOF3o0iA7Cse+/LM66uuxm8AgACjoWCAALKBgIABNQdAgAA7IoCAAAByIIAABmEAgAAAUDCAAAgmgIAAAWow
Date: Thu, 23 Sep 2021 13:20:55 +0000
Message-ID: <BN9PR11MB5433B300CF82CB09326A00978CA39@BN9PR11MB5433.namprd11.prod.outlook.com>
References: <20210919063848.1476776-1-yi.l.liu@intel.com>
 <20210919063848.1476776-12-yi.l.liu@intel.com>
 <20210921174438.GW327412@nvidia.com>
 <BN9PR11MB543362CEBDAD02DA9F06D8ED8CA29@BN9PR11MB5433.namprd11.prod.outlook.com>
 <20210922140911.GT327412@nvidia.com>
 <BN9PR11MB5433A47FFA0A8C51643AA33C8CA39@BN9PR11MB5433.namprd11.prod.outlook.com>
 <20210923120653.GK964074@nvidia.com>
 <BN9PR11MB543309C4D55D628278B95E008CA39@BN9PR11MB5433.namprd11.prod.outlook.com>
 <20210923123118.GN964074@nvidia.com>
 <BN9PR11MB5433F297E3FA20DDC05020E18CA39@BN9PR11MB5433.namprd11.prod.outlook.com>
 <20210923130135.GO964074@nvidia.com>
In-Reply-To: <20210923130135.GO964074@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 36be0240-1cc3-4fd2-9226-08d97e94f9c8
x-ms-traffictypediagnostic: BN6PR11MB0050:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN6PR11MB00506A154A9AD3657750EC518CA39@BN6PR11MB0050.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uLzoYySy3vbyYZZoWN042uUFPzLUu7qa+qUODDpZ6HLQqVEtgNYPjJd7kn48q7wozWQW2X6hvYsMs/hE4g8Goi82XVh5o2VA4+iJDq8oMlW+YnRB9s0Hz871RMJFilaEa9Mt5Lfg/MuyxuUIMP0Bh/41pKpyY7GZZrVSd8M2zrEWnXxdZCw2SERdO/qcS7GsbC3ho/cTSp9io4dW86hdqEH9npOeEYUwtuYbSWN2BWk/XgkhXKasVRMdJSs4LeY1Pd6OvrcHngt1M4q+xqk7epICw4IpG8HwOBpQgLkT1yzab0y1taXhtz+yXkql6BKgnPd3oKIMDQ8Njn39Th9a0mfFKFOacDy109jGMQUIB9JTn0/NMQALct99/g8zdf9u5rLwgWQn6bLQi4oGoIz15SRj4ddJWpxe68C1AqwyEgU2Ekw2aVsIC9efAlTCJ+AXAudOz6a64jXdwTbV5iJQy5bXRipxoOJ4UaDlVHbfRQzQYJ+jXitZwBZfDAmQx7CTvB/miiuUMsU5DQ7N0G3YMGD+OyocR/iA5cXkb7jGprqw6x5msw5azkhjQMiu0a5JXVzsS14GdajTY/IIbOjFNuyJn/8GG5ulSMshgkLtzRdj72qSj4CFN3BuYLNttqr/ueDe1FFqBGc5cZLHdUGK4DbkA7Tn1mDsoI7kfCC66jb48sWtC12/oY/av3vsU8pek+GJUfJRGlLhMYzaa8lWUScEyj9iouSodujaPvpXLK4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR11MB5433.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(33656002)(316002)(8676002)(26005)(6916009)(7416002)(6506007)(38070700005)(66446008)(66556008)(508600001)(64756008)(122000001)(54906003)(7696005)(186003)(66946007)(55016002)(76116006)(4326008)(66476007)(2906002)(38100700002)(8936002)(52536014)(71200400001)(86362001)(5660300002)(9686003)(84603001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?MfxVJVmnxPx3js8xza1BV//MG8BgX0O+vddwk0WJj+3/1Qua9oUt2lPSXTpp?=
 =?us-ascii?Q?9sgum8XxJOso2Q8OXZe5RqVnPUKpk0cIccyY630Atzwqcwx1838qPSvaquMl?=
 =?us-ascii?Q?lBQMF/9sKVx0TXNkT2N0YNmJqCg4ZFTjBpIhdsc2b1iypiaf3UXRQtZ6dwTa?=
 =?us-ascii?Q?XJbnMAS9vs9UWoQjcbv+fp+yfEiFnURDbuuGkquETI/Rp40xhG8d8G/e93U3?=
 =?us-ascii?Q?bUsNUQq4qBcN7rv4RJBKvtdihSVR7vER+kgy/aj2iz+LySQ/CYW9QJw6lp3e?=
 =?us-ascii?Q?YrU6J9hdzeiKZ5wCZ3CHHpgZEArOA/EfiAI7xrDOJK58WJRx5lg6K7vQOEbV?=
 =?us-ascii?Q?vYXBguuZS390ugT6+VcQTYuQVjVo663wDz3t1ggo55oNhIKQQpovmcssg+sq?=
 =?us-ascii?Q?LEkazK6I1ZDrQeFLE7IKd2qIDXzTZM+xrCJn8bYp3Nr/TlOaHPhOf15OMBsf?=
 =?us-ascii?Q?OCnXWQ7mA0/hDBH7I5Vi2kzoFl716NQumsXjSb+BNqNI+VNAgkjdtO91s5/h?=
 =?us-ascii?Q?g7fZKg/BJxKTlSp2XPJ5u3hdVXXHOeCYWayTYyh63VEXNUoM3jti7417iMmV?=
 =?us-ascii?Q?AsjQvfRfnGd7mMtM4FU+m73+RioapCoNA9pgfdVXRqFE51N1GrsqKhfPBGRs?=
 =?us-ascii?Q?s2sjcK7FrXlAtl3PocjBZ6RKtiSlLsmVpb9GX9PrL4s9W90OaqJspsFLp5g2?=
 =?us-ascii?Q?Y7mGW/dR3+gq7v5/3a3NDqMTQ4YlSjWpEKLdC6LWA9D/QqYt4dYB2hNhdNlX?=
 =?us-ascii?Q?z9NA2wGpXJ4bx4k3HKhbyVP9EqgCi+SPLlLwMfDr3vZ598NtzB2FHnK97WFQ?=
 =?us-ascii?Q?OTMc6CuBXqnqaD19XQyQhlQIXNszGRbk439Cwg9UwCZLKL5JekYkq+onoQ79?=
 =?us-ascii?Q?5nBtJAi43WxOcC4SUaZgMx+unVgOSwUuzim0nBKFOLNVVIduBT4BKhldpq+C?=
 =?us-ascii?Q?IFTMNR39MquGgThJZnL6sVzmlKEDmhYYxQLivOeS72L2DTpwUyEpgY72ytYv?=
 =?us-ascii?Q?p35Z3wxIsA5dl2DGtAW+kIq+S0vSAyjCa/wXccb38th1EBB6rmTyfmwoSKgI?=
 =?us-ascii?Q?LnqB0qVeXZcIIYMt1DAtsgm68qs32MYD/Ls+7AcFqFRq1EFqqpqRgcIwqcxu?=
 =?us-ascii?Q?Y3NHrIrl97xhvj2xkXGppBJ9ciF+/XlAz9IJu/DpTNP1dqz8ToBnta6Wkc0b?=
 =?us-ascii?Q?Y1QMjQMWMSgtUAWv88OYijN31wWKqRc8GBt9Jg8ZxTANyAREwsgvNXt2Z1/4?=
 =?us-ascii?Q?RRwEwq7urX6Azdjdd+tvMXzH9BUIhMsEVkDy08lTkefENxr0lIJq2o2HyTc1?=
 =?us-ascii?Q?XFRA9B/JAiWg7IUsnL8i6hle?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5433.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36be0240-1cc3-4fd2-9226-08d97e94f9c8
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Sep 2021 13:20:55.8993 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BXumsiC8jmV5DdxzAfMLtkdV1cEipC4zYLm8V2YrqwkJi18dzxGcnipp/4MUNC0Ph1uDqxgkDd2UTn6o1lvR6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB0050
X-OriginatorOrg: intel.com
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "jasowang@redhat.com" <jasowang@redhat.com>,
 "kwankhede@nvidia.com" <kwankhede@nvidia.com>, "hch@lst.de" <hch@lst.de>,
 "jean-philippe@linaro.org" <jean-philippe@linaro.org>, "Jiang,
 Dave" <dave.jiang@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 "corbet@lwn.net" <corbet@lwn.net>, "parav@mellanox.com" <parav@mellanox.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "lkml@metux.net" <lkml@metux.net>,
 "david@gibson.dropbear.id.au" <david@gibson.dropbear.id.au>,
 "dwmw2@infradead.org" <dwmw2@infradead.org>, "Tian,
 Jun J" <jun.j.tian@intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "lushenming@huawei.com" <lushenming@huawei.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>
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
> Sent: Thursday, September 23, 2021 9:02 PM
> 
> On Thu, Sep 23, 2021 at 12:45:17PM +0000, Tian, Kevin wrote:
> > > From: Jason Gunthorpe <jgg@nvidia.com>
> > > Sent: Thursday, September 23, 2021 8:31 PM
> > >
> > > On Thu, Sep 23, 2021 at 12:22:23PM +0000, Tian, Kevin wrote:
> > > > > From: Jason Gunthorpe <jgg@nvidia.com>
> > > > > Sent: Thursday, September 23, 2021 8:07 PM
> > > > >
> > > > > On Thu, Sep 23, 2021 at 09:14:58AM +0000, Tian, Kevin wrote:
> > > > >
> > > > > > currently the type is aimed to differentiate three usages:
> > > > > >
> > > > > > - kernel-managed I/O page table
> > > > > > - user-managed I/O page table
> > > > > > - shared I/O page table (e.g. with mm, or ept)
> > > > >
> > > > > Creating a shared ios is something that should probably be a different
> > > > > command.
> > > >
> > > > why? I didn't understand the criteria here...
> > >
> > > I suspect the input args will be very different, no?
> >
> > yes, but can't the structure be extended to incorporate it?
> 
> You need to be thoughtful, giant structures with endless combinations
> of optional fields turn out very hard. I haven't even seen what args
> this shared thing will need, but I'm guessing it is almost none, so
> maybe a new call is OK?

To judge this looks we may have to do some practice on this front
e.g. coming up an example structure for future intended usages and
then see whether one structure can fit? 

> 
> If it is literally just 'give me an ioas for current mm' then it has
> no args or complexity at all.

for mm, yes, should be simple. for ept it might be more complex e.g.
requiring a handle in kvm and some other format info to match ept
page table.

> 
> > > > > > we can remove 'type', but is FORMAT_KENREL/USER/SHARED a good
> > > > > > indicator? their difference is not about format.
> > > > >
> > > > > Format should be
> > > > >
> > > > >
> FORMAT_KERNEL/FORMAT_INTEL_PTE_V1/FORMAT_INTEL_PTE_V2/etc
> > > >
> > > > INTEL_PTE_V1/V2 are formats. Why is kernel-managed called a format?
> > >
> > > So long as we are using structs we need to have values then the field
> > > isn't being used. FORMAT_KERNEL is a reasonable value to have when we
> > > are not creating a userspace page table.
> > >
> > > Alternatively a userspace page table could have a different API
> >
> > I don't know. Your comments really confused me on what's the right
> > way to design the uAPI. If you still remember, the original v1 proposal
> > introduced different uAPIs for kernel/user-managed cases. Then you
> > recommended to consolidate everything related to ioas in one allocation
> > command.
> 
> This is because you had almost completely duplicated the input args
> between the two calls.
> 
> If it turns out they have very different args, then they should have
> different calls.
> 
> > > > - open iommufd
> > > > - create an ioas
> > > > - attach vfio device to ioasid, with vPASID info
> > > > 	* vfio converts vPASID to pPASID and then call
> > > iommufd_device_attach_ioasid()
> > > > 	* the latter then installs ioas to the IOMMU with RID/PASID
> > >
> > > This was your flow for mdev's, I've always been talking about wanting
> > > to see this supported for all use cases, including physical PCI
> > > devices w/ PASID support.
> >
> > this is not a flow for mdev. It's also required for pdev on Intel platform,
> > because the pasid table is in HPA space thus must be managed by host
> > kernel. Even no translation we still need the user to provide the pasid info.
> 
> There should be no mandatory vPASID stuff in most of these flows, that
> is just a special thing ENQCMD virtualization needs. If userspace
> isn't doing ENQCMD virtualization it shouldn't need to touch this
> stuff.

No. for one, we also support SVA w/o using ENQCMD. For two, the key
is that the PASID table cannot be delegated to the userspace like ARM
or AMD. This implies that for any pasid that the userspace wants to
enable, it must be configured via the kernel.

> 
> > as explained earlier, on Intel platform the user always needs to provide
> > a PASID in the attaching call. whether it's directly used (for pdev)
> > or translated (for mdev) is the underlying driver thing. From kernel
> > p.o.v, since this PASID is provided by the user, it's fine to call it vPASID
> > in the uAPI.
> 
> I've always disagreed with this. There should be an option for the
> kernel to pick an appropriate PASID for portability to other IOMMUs
> and simplicity of the interface.
> 
> You need to keep it clear what is in the minimum basic path and what
> is needed for special cases, like ENQCMD virtualization.
> 
> Not every user of iommufd is doing virtualization.
> 

just for a short summary of PASID model from previous design RFC:

for arm/amd:
	- pasid space delegated to userspace
	- pasid table delegated to userspace
	- just one call to bind pasid_table() then pasids are fully managed by user

for intel:
	- pasid table is always managed by kernel
	- for pdev,
		- pasid space is delegated to userspace
		- attach_ioasid(dev, ioasid, pasid) so the kernel can setup the pasid entry
	- for mdev,
		- pasid space is managed by userspace
		- attach_ioasid(dev, ioasid, vpasid). vfio converts vpasid to ppasid. iommufd setups the ppasid entry
		- additional a contract to kvm for setup CPU pasid translation if enqcmd is used
	- to unify pdev/mdev, just always call it vpasid in attach_ioasid(). let underlying driver to figure out whether vpasid should be translated.

Thanks
Kevin
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
