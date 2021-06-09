Return-Path: <SRS0=g+Up=LD=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F8F0C48BCD
	for <iommu@archiver.kernel.org>; Wed,  9 Jun 2021 02:53:06 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0B0B61351
	for <iommu@archiver.kernel.org>; Wed,  9 Jun 2021 02:53:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0B0B61351
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 96992402B9;
	Wed,  9 Jun 2021 02:53:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8kJ8xLnyfHig; Wed,  9 Jun 2021 02:53:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 20ABD4024D;
	Wed,  9 Jun 2021 02:53:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DB41BC000E;
	Wed,  9 Jun 2021 02:53:03 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6E9D0C000B
 for <iommu@lists.linux-foundation.org>; Wed,  9 Jun 2021 02:53:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5B8A7402B9
 for <iommu@lists.linux-foundation.org>; Wed,  9 Jun 2021 02:53:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Rhqu8TdvrwQl for <iommu@lists.linux-foundation.org>;
 Wed,  9 Jun 2021 02:53:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5F25C4024D
 for <iommu@lists.linux-foundation.org>; Wed,  9 Jun 2021 02:53:01 +0000 (UTC)
IronPort-SDR: vhhzAi7AcmC7mdLk+fLHjsyaox3G1xyCcB8aOlNf2BEBR7Omyunzg0n7Fa+VqX740AkkjrZAx3
 /5s8YQ3GDp5Q==
X-IronPort-AV: E=McAfee;i="6200,9189,10009"; a="184678633"
X-IronPort-AV: E=Sophos;i="5.83,260,1616482800"; d="scan'208";a="184678633"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Jun 2021 19:53:00 -0700
IronPort-SDR: 5st/krb4mnb56RqNJPOOYNchg952TWwOtMoHp3kXcXslXXaMeuaLz0zmje7Lrr8a066nRafB1l
 kZ5WfSeueEnA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,259,1616482800"; d="scan'208";a="485554722"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
 by fmsmga002.fm.intel.com with ESMTP; 08 Jun 2021 19:53:00 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Tue, 8 Jun 2021 19:53:00 -0700
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Tue, 8 Jun 2021 19:52:59 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4
 via Frontend Transport; Tue, 8 Jun 2021 19:52:59 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.171)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.4; Tue, 8 Jun 2021 19:52:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gHe6AfFCbY0EkIb3XiP5b6LJTwPe0+2yqax17y/nikgCkatknYHFTN2LrJ76zeUIEzfx3Mo8K66TkukLQH+DVPoogtMBoQt4bZKCIHM97K/gV7h++btSsbf7wXxwfLSDRaHr5C5zlmmUvBKZxe2s2OXN9iMHUWb+3PA05Hm7lPOU+7ysyvEKmoS9Kq0yCD3qgrLuGWc0HU3PZRh3wbpUdhDUcTpeHNhNPelEMOV1Iv61gUqyBMGT19bCHBi31OB9F0JT2lZkRGRpKhd63XevYdnWMizmduswGJtcgxBNMqhoIr3MlPZ4QFcUK4c6GM/PdlpEj5GaO5ioHOgMbfEaGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D1h2mpdlqBRmhn2mtueaIrbTWwQ2V36EQFaTGAXA5tE=;
 b=B0WEYiYCFiF7y7PcKojPunlh9LeC32LEsiF2RIPs7n37Yx0WhyBAzqaOwOBspIK4E2d/dxsH7m82VPu8ktO72bwstku+ubgzHHem9Vv5zAtjBcGRRu/NFuAXTh1gGjpWFqlTcMjXJ689E3FUglN2YfCgWYImwCr6tFnVDhboLYXvs70AA1zwiRGucw6McYsDnpuOplJHeogOpZrV/Udds0glUNlEmR2/1H+SKYFIF+XC8wnBh9JMA6sVq0ak5bsvHHLmTNnII4ww0EF+742jpcCNnw4BwHekFBEYsSoyffeMyhgxCgET16WGzfd9uXnFXq1CvjRbk8jJBEEY9Ej4jA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D1h2mpdlqBRmhn2mtueaIrbTWwQ2V36EQFaTGAXA5tE=;
 b=kgbJmAWU+8eXUzIvQd8RjL6snGajfXQ2tAvN1nqQzdzPwj7b+vH6gBlMXfFCBQL6PjN4Nwrj+fAmSNIUdBbF0QtvUREEc0zbfWBtHa3fanCe+2y0gzCWFDS6AJE8t+OLBNfF/mkF4ozEYDs7//v3TVo5c0tft6N9Qymg/FVO1MA=
Received: from MWHPR11MB1886.namprd11.prod.outlook.com (2603:10b6:300:110::9)
 by CO1PR11MB4852.namprd11.prod.outlook.com (2603:10b6:303:9f::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.20; Wed, 9 Jun
 2021 02:52:54 +0000
Received: from MWHPR11MB1886.namprd11.prod.outlook.com
 ([fe80::6597:eb05:c507:c6c1]) by MWHPR11MB1886.namprd11.prod.outlook.com
 ([fe80::6597:eb05:c507:c6c1%12]) with mapi id 15.20.4195.030; Wed, 9 Jun 2021
 02:52:54 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: RE: [RFC] /dev/ioasid uAPI proposal
Thread-Topic: [RFC] /dev/ioasid uAPI proposal
Thread-Index: AddSzQ970oLnVHLeQca/ysPD8zMJZwBGs/UAALTRUxAAFJZWgAAQLFRgAB7cjgAAE0ZXYAAH9s4AAANRJjAA7xYlAAA2jyxw
Date: Wed, 9 Jun 2021 02:52:53 +0000
Message-ID: <MWHPR11MB18864D52718BD84E32F7E1B78C369@MWHPR11MB1886.namprd11.prod.outlook.com>
References: <MWHPR11MB1886422D4839B372C6AB245F8C239@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210528173538.GA3816344@nvidia.com>
 <MWHPR11MB18866C362840EA2D45A402188C3E9@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210601174229.GP1002214@nvidia.com>
 <MWHPR11MB1886283575628D7A2F4BFFAB8C3D9@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210602160914.GX1002214@nvidia.com>
 <MWHPR11MB18861FA1636BFB66E5E563508C3C9@MWHPR11MB1886.namprd11.prod.outlook.com>
 <YLhj9mi9J/f+rqkP@yekko>
 <MWHPR11MB1886E929BD1414817E9247898C3C9@MWHPR11MB1886.namprd11.prod.outlook.com>
 <YL6+tBc+Xq7pgb/z@yekko>
In-Reply-To: <YL6+tBc+Xq7pgb/z@yekko>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: gibson.dropbear.id.au; dkim=none (message not signed)
 header.d=none; gibson.dropbear.id.au;
 dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.198.143.24]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6a16ce82-09dd-4a3f-9f23-08d92af1ae01
x-ms-traffictypediagnostic: CO1PR11MB4852:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CO1PR11MB485216221A03B999044F87388C369@CO1PR11MB4852.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Dx1JLf5qPdT8wEY/CwL90ctaJDnvdkeMOzIr02QLAaZJzaa5JobeVRjuYwRLnOnAXKb7xYdl6F0yhnXgOu4wtbzVlYSDTw4r7pKK4Vyorq2jxHuFE9CuYdYrWzx4zUna6agDNAf2tnICnb89i+QkTFic3zVN7+uRQu9cKtGcQ6uncgy35e8I3xrmKevLYYF72/J9nhtfhPjXcida7QSX0nlVcZ4YA5pkTaSbUvRenWoCpfVebjJCnm3s3+I7kqN1h5HV8fofNjo0Q/06n7cJnFZn+K+Hxmsx9SMvFgR6h03/HKFjXdhfXhk3nwAcEbd9LTNZNDk3C0TJV4YkIPTUu2ngyGhgXi9JT0si9w2Lsn44kKgE620F+Cd3ZYRhbLj7O0w9l5w7k/IAQaHXFtRvO5SjNodbCjkBhFycd52eYQvL0dV646TrUEQqmYMmJYc9Lqb2q4X613J7EYpC4swd0n6WcT6bS+Czywp36MPLUtlWohAluxG3/IshvhWx8YNOReKsqPNmO3nVY9OturWvsEG7Y9FMekYrxYq5C5taY8Guc8ayuIiYvMQ3qXhDGwXDMK17vuGd/3sr3oSSVfR48L2efdGXE0ZDPCXBqXrWTAE=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR11MB1886.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(396003)(366004)(346002)(39860400002)(376002)(136003)(66946007)(76116006)(52536014)(7416002)(64756008)(4326008)(86362001)(6506007)(66446008)(8676002)(66556008)(66476007)(33656002)(38100700002)(6916009)(5660300002)(316002)(54906003)(122000001)(55016002)(8936002)(9686003)(7696005)(83380400001)(2906002)(478600001)(26005)(71200400001)(186003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?jDB1je4QP+a7xemHZsnM9Sa4sHPsrddwp2Yk6jAHY3v+CxCVcFW5CzrW10zB?=
 =?us-ascii?Q?Cn3d3xznAZRIGWq91wrb4ETc96Tdynn815fK5VD2QzP5KT4cCOpt6KnNzxvl?=
 =?us-ascii?Q?STnazBr5wxi1GPwl0Kf7SAcToA4Iu/zR6KUHemJOtY5Cd18y2xeTW67+Ao6l?=
 =?us-ascii?Q?6Zewk8/WRoe2FbHvk4SN2ppCsv0Y6ss93XLl7fZv3a+KsHmcvsVqbQGkHsZG?=
 =?us-ascii?Q?mgbSG0fql9KdXH9CxR5SLHe2ACskSHi8JgRqMG0tXOAUU3qBH0GuJofvEOHl?=
 =?us-ascii?Q?unQ/VtPIUJCC/eWOR1WzOJLlaKX3YYuN5hDKKy8s7WazDQJgPe31qyBph3WK?=
 =?us-ascii?Q?VZu8lz+o0qFsyiov859T++OL3AZPt9qtkEPpkQNjqsUxDMloegmobkxrlOgj?=
 =?us-ascii?Q?Zn8CX5IfHKQL9d2erwY772epJ8/oMgvxZo8VPUy1XFevyCRgOIaG0AMB1oFc?=
 =?us-ascii?Q?MCWSD7LgvJwd/5gw77JP7GyfAift0jxUwfhJS2M5Q21cCpHkN7BlYDiPkLu+?=
 =?us-ascii?Q?FhFBO9BZx46FanTlTiaPLW/mXBWRWa4CoFDVdTz4ajmjDEevT8d+aZn7spjG?=
 =?us-ascii?Q?RwDTMAM6G5uzjbMMx+McM0U7h5D0W8llCaS4zEgAj/kI+z+WdRWXaadRlPik?=
 =?us-ascii?Q?o6WFXDqa7kLy5gNKjAZ8n7YI2Z8aZy/CEK+zgPgOzRTM3kK2kNlQCTWEIF/r?=
 =?us-ascii?Q?3uWit49qpD+FWvgVjtc/ShcuClb7yqI1kU5UUbNiMm3f1j8+ZXs48cZ86La4?=
 =?us-ascii?Q?fDvagZhplBxK0vyfCf+JrmUqeAr5Fsivr0TLYQIYmYzIhXub9sPg3q9DvAMA?=
 =?us-ascii?Q?YWp1T3vbgNnskt93/uTr+LdttoecHxIKRQaYGQhYy4YrQJfvofiYueAEP81z?=
 =?us-ascii?Q?qeToAQvX4GZ2D7TTeFVf1nTn+CWMklXZwxs0lPwR8enmSySvXQuLNmJIkohb?=
 =?us-ascii?Q?Sgq7Cb3rrtQgHj6n4rYBn2hQGD7+F1W+rBQrR8+ctziDzlCRoNjIIskbOTCR?=
 =?us-ascii?Q?jMz+YOcvpE2Ygl+3uIWhnanA0V9Ck25yjEXpP+6hb9uOken9jKIjddATk3D+?=
 =?us-ascii?Q?NM8AD17zxJJI5wpt7sTqGQxwarLmUJZYGD9Icd8MAKmKBa4RWcByWRsK98D+?=
 =?us-ascii?Q?qrErnbMq0uuhi/ebJsLorX9PsgbzkanwKUJ9V4KNx4eAwpTHwfqRRix82qPZ?=
 =?us-ascii?Q?NbqbL++faRFRM9iG+v2E6lFgz8rVITiuGff+I3qVoqGGA/r2RVbXr2/bCyD/?=
 =?us-ascii?Q?A7qd6LyDn4hlETKAecjmUiHrHoBZRaMsKiXjZTQs+uZiT1q0BPex3JCxq5tI?=
 =?us-ascii?Q?i4rV9czs8cgMA2ImRtXi00j7?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1886.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a16ce82-09dd-4a3f-9f23-08d92af1ae01
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jun 2021 02:52:53.8755 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fbGudecMqLrZxeQSy/tAKemdmy0WV80AkSFPQg2Y3rDZdcb5eMSyntU+/IQDbWbTakrsBsQzqFPdL/QXxL9K5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4852
X-OriginatorOrg: intel.com
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, "Jiang,
 Dave" <dave.jiang@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Robin Murphy <robin.murphy@arm.com>, Jason Wang <jasowang@redhat.com>,
 LKML <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Kirti Wankhede <kwankhede@nvidia.com>,
 "Alex Williamson \(alex.williamson@redhat.com\)" <alex.williamson@redhat.com>,
 Jason Gunthorpe <jgg@nvidia.com>, David Woodhouse <dwmw2@infradead.org>
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

> From: David Gibson <david@gibson.dropbear.id.au>
> Sent: Tuesday, June 8, 2021 8:50 AM
> 
> On Thu, Jun 03, 2021 at 06:49:20AM +0000, Tian, Kevin wrote:
> > > From: David Gibson
> > > Sent: Thursday, June 3, 2021 1:09 PM
> > [...]
> > > > > In this way the SW mode is the same as a HW mode with an infinite
> > > > > cache.
> > > > >
> > > > > The collaposed shadow page table is really just a cache.
> > > > >
> > > >
> > > > OK. One additional thing is that we may need a 'caching_mode"
> > > > thing reported by /dev/ioasid, indicating whether invalidation is
> > > > required when changing non-present to present. For hardware
> > > > nesting it's not reported as the hardware IOMMU will walk the
> > > > guest page table in cases of iotlb miss. For software nesting
> > > > caching_mode is reported so the user must issue invalidation
> > > > upon any change in guest page table so the kernel can update
> > > > the shadow page table timely.
> > >
> > > For the fist cut, I'd have the API assume that invalidates are
> > > *always* required.  Some bypass to avoid them in cases where they're
> > > not needed can be an additional extension.
> > >
> >
> > Isn't a typical TLB semantics is that non-present entries are not
> > cached thus invalidation is not required when making non-present
> > to present?
> 
> Usually, but not necessarily.
> 
> > It's true to both CPU TLB and IOMMU TLB.
> 
> I don't think it's entirely true of the CPU TLB on all ppc MMU models
> (of which there are far too many).
> 
> > In reality
> > I feel there are more usages built on hardware nesting than software
> > nesting thus making default following hardware TLB behavior makes
> > more sense...
> 
> I'm arguing for always-require-invalidate because it's strictly more
> general.  Requiring the invalidate will support models that don't
> require it in all cases; we just make the invalidate a no-op.  The
> reverse is not true, so we should tackle the general case first, then
> optimize.
> 

It makes sense. Will adopt this way.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
