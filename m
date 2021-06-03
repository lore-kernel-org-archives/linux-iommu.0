Return-Path: <SRS0=MHXQ=K5=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FF7DC47082
	for <iommu@archiver.kernel.org>; Thu,  3 Jun 2021 06:49:29 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3BABA61246
	for <iommu@archiver.kernel.org>; Thu,  3 Jun 2021 06:49:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BABA61246
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 05B1560B14;
	Thu,  3 Jun 2021 06:49:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9ovnWMSLAgAO; Thu,  3 Jun 2021 06:49:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id C49F8606E7;
	Thu,  3 Jun 2021 06:49:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8CB64C000E;
	Thu,  3 Jun 2021 06:49:26 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 54C3BC0001
 for <iommu@lists.linux-foundation.org>; Thu,  3 Jun 2021 06:49:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 43083404F5
 for <iommu@lists.linux-foundation.org>; Thu,  3 Jun 2021 06:49:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id poW8H_Y51ruI for <iommu@lists.linux-foundation.org>;
 Thu,  3 Jun 2021 06:49:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 995E8404EC
 for <iommu@lists.linux-foundation.org>; Thu,  3 Jun 2021 06:49:24 +0000 (UTC)
IronPort-SDR: ZqYBkvlwoDbLC6/oUh+MjxjOE3Iv92mdZbRmM5wc6dYhKod5YCCCnjKd6fZLsDDC2JhfsJ8bQF
 5TA3MXSsrMeg==
X-IronPort-AV: E=McAfee;i="6200,9189,10003"; a="289609762"
X-IronPort-AV: E=Sophos;i="5.83,244,1616482800"; d="scan'208";a="289609762"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jun 2021 23:49:23 -0700
IronPort-SDR: Q8GrBdGszXSpbWcV9ofgzMNXQeC4ZCIXAF/GxEt4/kblsJ1216BdUnU/eAKSiYdgeGDU63UDaW
 UL5sgb+gATyQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,244,1616482800"; d="scan'208";a="400270649"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
 by orsmga003.jf.intel.com with ESMTP; 02 Jun 2021 23:49:23 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Wed, 2 Jun 2021 23:49:22 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4
 via Frontend Transport; Wed, 2 Jun 2021 23:49:22 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.47) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.4; Wed, 2 Jun 2021 23:49:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VA0lHUjhFj65+M1N6N8H7vOXT/LCVNsLgqMF6e5qbXFCEvoEwcBflUX38Na3TPcDTm7G10f0pU4/YUsiiE89QdBC4s9t08b1wdw1DZbgA9gtnHDz9nqUZNxt5FNYdSnYq3r8XWPFLJ5jj35bZyyJzW7NLbxEfUlXEVydQtoWNyjRldq3Sbkhisd807jeEkxyLYRubrbQTrpTjYYeteEDg7yAwurCXHPEqa/zOJH8dm5dhj36Pc02mdgZrR4Ekdzu0rdft1mmiD2Wfh8J0xrj62ZNEs//LmQiJXTy0P7ATpNj5e9IQA6wjQQkhRTynEw6Gv8FPziNACRIw4+hx9rs3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l947YY+NQSM+sbup14PJc+m6SmtrL7snXOKptgWquUI=;
 b=BvFIF3KwoxiUdaGWUKDtQtOXvCfpDuFjD44Bx2icAIcvJRy+EbYU4JXRwuiA/LhvGgyKgxokLJ+EVloHg9DQ35Mq8nhD9KS1zaVVgKXYAldg1dlrFI31luITsjWjWl1uH4RXMddMQ0oPOKlNQbB0r8SqPbwJkBxRYlTEPwOPgbVpkBFNf3AyJH00zJhWKG5nZDRNL441J/uEEFTz+O+v76+lU2oH7Ds5nLP6tUP5dY7SOaM9nlIoBIOAyzneY5CAbly0cciiEKYW6kgeQYF2APOKBXYV5Mo+uV28huQ+kEchroddirXibEmQ6VBKeWJp5IQtfNfP4im6whJUD3qvoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l947YY+NQSM+sbup14PJc+m6SmtrL7snXOKptgWquUI=;
 b=nImWxmTLU/f1HXALVZ7Je6h8HhnEUbGDp197+OOZ1KQBFJeO0qqwee0FOnTelsjemB2dg0tM82sC4+in03/ouKSDrHLlbH2Nw0sW19vdK78GPWDQIYAphqqs9loyMxns7nkywpe9DivFfx5Tg/449yvqrnDujkHdpnk33QElJtg=
Received: from MWHPR11MB1886.namprd11.prod.outlook.com (2603:10b6:300:110::9)
 by MWHPR11MB1885.namprd11.prod.outlook.com (2603:10b6:300:111::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.27; Thu, 3 Jun
 2021 06:49:20 +0000
Received: from MWHPR11MB1886.namprd11.prod.outlook.com
 ([fe80::6597:eb05:c507:c6c1]) by MWHPR11MB1886.namprd11.prod.outlook.com
 ([fe80::6597:eb05:c507:c6c1%12]) with mapi id 15.20.4173.030; Thu, 3 Jun 2021
 06:49:20 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: RE: [RFC] /dev/ioasid uAPI proposal
Thread-Topic: [RFC] /dev/ioasid uAPI proposal
Thread-Index: AddSzQ970oLnVHLeQca/ysPD8zMJZwBGs/UAALTRUxAAFJZWgAAQLFRgAB7cjgAAE0ZXYAAH9s4AAANRJjA=
Date: Thu, 3 Jun 2021 06:49:20 +0000
Message-ID: <MWHPR11MB1886E929BD1414817E9247898C3C9@MWHPR11MB1886.namprd11.prod.outlook.com>
References: <MWHPR11MB1886422D4839B372C6AB245F8C239@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210528173538.GA3816344@nvidia.com>
 <MWHPR11MB18866C362840EA2D45A402188C3E9@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210601174229.GP1002214@nvidia.com>
 <MWHPR11MB1886283575628D7A2F4BFFAB8C3D9@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210602160914.GX1002214@nvidia.com>
 <MWHPR11MB18861FA1636BFB66E5E563508C3C9@MWHPR11MB1886.namprd11.prod.outlook.com>
 <YLhj9mi9J/f+rqkP@yekko>
In-Reply-To: <YLhj9mi9J/f+rqkP@yekko>
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
x-originating-ip: [192.198.142.24]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 82da9bed-6956-4952-ee8f-08d9265bb747
x-ms-traffictypediagnostic: MWHPR11MB1885:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR11MB18858BDAC658AC258C2FB53F8C3C9@MWHPR11MB1885.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rsapj1UaCDCl4CrMGPmdXqPeBXBLa0CKE0j0lw4yP88WnpywwKMj9Y50GHNF20O6lxaXEze4Dfrp3NxCvCJ9I4lKLUOpEHBluCaEPyOtmnhljin+lUXBthWmAeNHWoAYGEfVWkOjRKV/vwvXB/H1oa3JTECLbCRv76qpckrNehrhyadqFJ2GCkStl+ErhlcgoHfpnTIn0hK9WSwb1WD6TZByh7YUQhgArkSblBzR3bSOPQXk4nTiZ9yzUi+7m5ago+RWHW9kefrzYrX26RZ7pD9iMgLTgNDu/Uallo4zCy0z9wWcGH4i/2OjzWEMq5dxNXh91sDrdnSJI7sVHtf9/wcprwxDeyG3Am9qZbJPpY0goknTbPcMoHXa8E2CDy0TA8gpoUgBN02YmPAESQ/P4ejqviaE6ExKmtanzNyhGs5jG6aatzoEwt52tUH+12VP2WsDmHJVdNZNXDy83W73HQIp6zYFrd/ew8uZUEVllEUdjaS6rSbZ4hLmtuXfGtSx3csD9pMAEkMIgSkfpXOFv73F6TLSTrhYAR2IIRvE8smThk+HGkwEOuHxq58QvbviD0UGIggY4FXaJLeZrFTQUF1Ry2+4vIoEF7frBixk/IA=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR11MB1886.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(136003)(366004)(396003)(346002)(376002)(39860400002)(64756008)(5660300002)(7696005)(26005)(2906002)(76116006)(7416002)(9686003)(66446008)(66946007)(6506007)(55016002)(4326008)(478600001)(52536014)(86362001)(6916009)(8936002)(316002)(8676002)(71200400001)(54906003)(122000001)(66476007)(33656002)(38100700002)(66556008)(83380400001)(186003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?dwwJ0PjkHBDGcVaz2/YyNMn/xYoLn6zSjPtJWWqhHuoJzZ9Ry3WBvc0jT7A6?=
 =?us-ascii?Q?0+oAx6xYYIk+RrSjVqiqQiixMqDPqr+YlvfWk5pdW019UkYV7vuSQNZD0vUR?=
 =?us-ascii?Q?ApUPZxZ7nN0Ta6HyZFEZWsIh+5fhM98igYBlZc+lVnJrF4ms1D1pInKkkeZv?=
 =?us-ascii?Q?qBWTQ+j0zotIRU/E1Vs7BBDEmfHfiSqG4ASFUTw7c34I5dOP/9zwLIX5LYfT?=
 =?us-ascii?Q?Px1c4bZKdaDWNxoVP+Z6YD58Nj2lRJVc2b6Pu8B39DP+6e7adEJVWJEfYOBK?=
 =?us-ascii?Q?RZdDpJgZE20yYHCzQNVgG67OylvLJi2jdBLHsvtSG9lamESg8tyycfMTRUdF?=
 =?us-ascii?Q?2CfLh6t76BV3IfbPb3UvmWEv3VsOFdGDE53Qo0auz5AG06IJjAd6vzG0YQ5t?=
 =?us-ascii?Q?1jcmpv/oLcMA7jDqL8Sz9K8jMIkGoOLYqkjT9JjgZ1emBo4oS7dyhX/6xGTT?=
 =?us-ascii?Q?89mS1sMm9rPaNmAYp56Flthg3GHaeaoCAB0ww8t7aMBL5QEXaBlymfKVnSzY?=
 =?us-ascii?Q?F9hSze6OhyrlN0fbD9lWpn/zZ4h6HI8gxoC7H4T05tPgeGMDssql2LYPdKm6?=
 =?us-ascii?Q?v8t6IKe4ecVWWAxif6cerZ9cUSHcIiPYtXj+5gFg1k/FuG8EA8E8Lvok8pH5?=
 =?us-ascii?Q?d1i2Qk2tPEwIGqFsxueYY91E9gmxBqS/a6gw68fnMVJEtgqyFodUSaYOoqPE?=
 =?us-ascii?Q?3Uq+HbXMBXQfKFjeHy7YcEUyiK/kaLBPtGCOpBlBz2paimZSckdX888FiKIy?=
 =?us-ascii?Q?e2DgQ9GcpGr95f7mJP5K7tZG3Jz1V8aVz6cIdgysqzpmFClQHM4a6op3rmin?=
 =?us-ascii?Q?mUNXH1hkcLGzWz0XOKGz80ssM6oHwqD7URqxA4ZX4M6/PUWfn0yNnJADTvzV?=
 =?us-ascii?Q?hRr5zf6L9Y6pmnfRT5BDQwVuSpVAr8FFt3n7UqCIakzFIy1mCCE1wpxrbpOL?=
 =?us-ascii?Q?tsrLh1xEdfdnbnruWy6aXcFs7w4dBalDAuRC8+VEAR9tOFNl2pUNABPsvafi?=
 =?us-ascii?Q?zwb7KGHythcUdwpactbLmHfl0SOrlqGP/zvtoQ6r+bKNeOtQ6BwW/YG+SjGD?=
 =?us-ascii?Q?p2LMAvBTWCGDWgnMeN78Q5qxvXLYxVRy8IX0YeNrQ6iONVXgqH3R/QwgK1UX?=
 =?us-ascii?Q?DLr+JLOB/PlIlX1IPJfenwCs+9Q3j7+JG7CbifkwD3MX8iyLh5wbr8S6h3Hd?=
 =?us-ascii?Q?gGgacWhXZeu5esolxgF88/myUzCf+ollznTrYyXS8W9wFW41f0XMlzXmwSy5?=
 =?us-ascii?Q?WZpDqSGBQFaTXJLU8L6Er/JxP/UsNL/XIdL0tvlQFfCM1rMYNVKcO/Hg3+dM?=
 =?us-ascii?Q?vfm0EVQhH/ML7qgXkfIOklTS?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1886.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82da9bed-6956-4952-ee8f-08d9265bb747
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2021 06:49:20.6410 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ojyegcEot8UOItPWGvZqWRyvN/LwGC+P7RQwHyN5cd/k9dPwqQbKXjWYtWeMAvaY445zacPinNtLOovO1iYUhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1885
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

> From: David Gibson
> Sent: Thursday, June 3, 2021 1:09 PM
[...]
> > > In this way the SW mode is the same as a HW mode with an infinite
> > > cache.
> > >
> > > The collaposed shadow page table is really just a cache.
> > >
> >
> > OK. One additional thing is that we may need a 'caching_mode"
> > thing reported by /dev/ioasid, indicating whether invalidation is
> > required when changing non-present to present. For hardware
> > nesting it's not reported as the hardware IOMMU will walk the
> > guest page table in cases of iotlb miss. For software nesting
> > caching_mode is reported so the user must issue invalidation
> > upon any change in guest page table so the kernel can update
> > the shadow page table timely.
> 
> For the fist cut, I'd have the API assume that invalidates are
> *always* required.  Some bypass to avoid them in cases where they're
> not needed can be an additional extension.
> 

Isn't a typical TLB semantics is that non-present entries are not
cached thus invalidation is not required when making non-present
to present? It's true to both CPU TLB and IOMMU TLB. In reality
I feel there are more usages built on hardware nesting than software
nesting thus making default following hardware TLB behavior makes
more sense...

Thanks
Kevin 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
