Return-Path: <SRS0=xf59=C2=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8956C43461
	for <iommu@archiver.kernel.org>; Thu, 17 Sep 2020 06:01:48 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B698208A9
	for <iommu@archiver.kernel.org>; Thu, 17 Sep 2020 06:01:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="JJgRI4MF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B698208A9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 0FCBF877FB;
	Thu, 17 Sep 2020 06:01:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id G1HDCTBZg9Vt; Thu, 17 Sep 2020 06:01:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 08955876C0;
	Thu, 17 Sep 2020 06:01:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D5303C0859;
	Thu, 17 Sep 2020 06:01:46 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4AE38C0051
 for <iommu@lists.linux-foundation.org>; Thu, 17 Sep 2020 06:01:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 391728759D
 for <iommu@lists.linux-foundation.org>; Thu, 17 Sep 2020 06:01:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZiXa8TcL9nCQ for <iommu@lists.linux-foundation.org>;
 Thu, 17 Sep 2020 06:01:44 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by hemlock.osuosl.org (Postfix) with ESMTPS id EC5198759B
 for <iommu@lists.linux-foundation.org>; Thu, 17 Sep 2020 06:01:43 +0000 (UTC)
IronPort-SDR: 1NFATkh/iMbSHKD8YH6Zws4oAeAtnCiidy0pPzzclVND4z2SNizgunRJUoGQJ4AqhES9xKkWun
 v6Fv5SWaJthQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9746"; a="221184933"
X-IronPort-AV: E=Sophos;i="5.76,435,1592895600"; d="scan'208";a="221184933"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Sep 2020 23:01:42 -0700
IronPort-SDR: EMtaxIPgruL87xUvEbKGqwrzsBMsPGliCNZNctv40X/U/GNCFNRD6vCXr6yZ+CoG1tmdGAf9b1
 8m1Y5DbMid+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,435,1592895600"; d="scan'208";a="409796553"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
 by fmsmga001.fm.intel.com with ESMTP; 16 Sep 2020 23:01:41 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 16 Sep 2020 23:01:40 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Wed, 16 Sep 2020 23:01:40 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.173)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Wed, 16 Sep 2020 23:01:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YQvT/iQqSr4O4+AtxiMcX3hmh9rnhybq/KSFD0oRmBahrU90TrxH12x3ieCZYXKLDC3jhPBSEuohp/iY1U1Q/HpW7Uma3Rk2lJMIryFkWA580STgE9h5ItLncy7iSttJxkYpBBI5NzU/BwWabI6ljD+n477CNFNVsbcJi6ED/4g8kNjb6V7Cyy6piC/bgtY+j+3ENAQ9+aYgbcUzt0YhilPbM/L2AF10q8KsOKcqKxcl3bWiQ5zFVF2yFyivO2xG1daAgCmVSD54x4zP5e7QdAHhzj4/jU83wvJs8SLyPY3EyyPShXQROUQf77jN1acwwLIwbLpMLT4pJzfuj2NNvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CnMaM87QmKQ36aIobeliZh3HJorVcHgU5JsbFK4hcZU=;
 b=brLGiEofwzc8ARfkyJqAJi4gY5to/vkBuU2zOBTmyWB85QXRv+FftL3yJrrAmtHnYWaHx999o20c71uroNKEPYpOUr1THJuCzSKtak8b2faGcQ8Sxqp/aDE3rO5+aN4534vzkbH932Jq2l26OAeqXHO0ukFSZfaYT6RzkOF1O4yUGdSmYT52poUlpASpeofNAAnU68/3AZcruw1rMIzezgN5Y9qA+t4eELmKJK93nb9ogkBDnchba/w5SOHuvsBACUhDftDDaxbpyfpNcQCW+60i+D7+5NB699H/RkIJ1vpxWogsUlgd281clldG6nPHX06F5hpV8MTtrT1ZgtZj9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CnMaM87QmKQ36aIobeliZh3HJorVcHgU5JsbFK4hcZU=;
 b=JJgRI4MF7Iz1njLD0dW1No46gDe+T40sZIT65CDqZB8dctFECuZtz9ihwCi3KoTSj3kuZux3zOjcNaM6sTT5RRsbEtTgayIPsLIUXBUMBSWRefc4XuCCgh4gi9p901jY11Op1O5s4SW7Fty4PKdm4b/+Mwz3w3AC7MiwUGzxz3c=
Received: from MWHPR11MB1645.namprd11.prod.outlook.com (2603:10b6:301:b::12)
 by MWHPR1101MB2207.namprd11.prod.outlook.com (2603:10b6:301:58::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.14; Thu, 17 Sep
 2020 06:01:36 +0000
Received: from MWHPR11MB1645.namprd11.prod.outlook.com
 ([fe80::6dfe:feb8:25f1:ac9c]) by MWHPR11MB1645.namprd11.prod.outlook.com
 ([fe80::6dfe:feb8:25f1:ac9c%7]) with mapi id 15.20.3391.011; Thu, 17 Sep 2020
 06:01:36 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: RE: [PATCH v7 00/16] vfio: expose virtual Shared Virtual Addressing
 to VMs
Thread-Topic: [PATCH v7 00/16] vfio: expose virtual Shared Virtual Addressing
 to VMs
Thread-Index: AQHWh19AhgenwZ1qREOwvjqrd6cs+KlnjewAgACZ9oCAAASWAIAAK1qAgAADGwCAAAb/gIAAC9mAgAALxACAAAp5gIAAO0sAgAELFgCAAK+vwIAA5xaAgADtp3A=
Date: Thu, 17 Sep 2020 06:01:35 +0000
Message-ID: <MWHPR11MB16452F3E64E6D028C9A37B048C3E0@MWHPR11MB1645.namprd11.prod.outlook.com>
References: <20200914134738.GX904879@nvidia.com>
 <20200914162247.GA63399@otc-nc-03> <20200914163354.GG904879@nvidia.com>
 <20200914105857.3f88a271@x1.home> <20200914174121.GI904879@nvidia.com>
 <20200914122328.0a262a7b@x1.home> <20200914190057.GM904879@nvidia.com>
 <20200914163310.450c8d6e@x1.home> <20200915142906.GX904879@nvidia.com>
 <MWHPR11MB1645934DB27033011316059B8C210@MWHPR11MB1645.namprd11.prod.outlook.com>
 <20200916144459.GC6199@nvidia.com>
In-Reply-To: <20200916144459.GC6199@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.198.147.212]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a6038f19-cb24-40f8-4f42-08d85acf22c2
x-ms-traffictypediagnostic: MWHPR1101MB2207:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR1101MB22075677AC45D8BA32575BF68C3E0@MWHPR1101MB2207.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: x3tT4n88k4jSCj6JPEWLriMzVm0gdGwqNPHCjHjgAlB+MLVqoLu2wr0OXVkQv4+FaupJbqizaVPQ9LsBeJSFm7Msdl86KilTDWqo3HOvYIra9rJkmz1aY5WcnnbP0MbOQesgIzkmq9ui2bjg5CruzejmSU4cVaADecaprqBlgbjwhKwJEYWRmH5vhqMYM2WI5VWlcsqR5aOyDAEvJvIP+3BpLQvgt1GsXqXn7eeTAQYDCphIMBh7mIBPDYg/VH4etUUrvn7JleD4v4Y7Ev1jqR1JSXxRfaW+Gcd1pcOp1D3bcuqSrc/F+dlVPHcTdjMzu3MosuK96weKYMeQARiNVg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR11MB1645.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(346002)(366004)(136003)(396003)(39860400002)(71200400001)(8936002)(478600001)(8676002)(83380400001)(316002)(186003)(26005)(86362001)(7696005)(6916009)(33656002)(9686003)(4326008)(7416002)(52536014)(55016002)(54906003)(66556008)(5660300002)(66446008)(66946007)(66476007)(64756008)(2906002)(76116006)(6506007);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: l5PbuOdRDaKCTbxAZO+4EXRJNVMXk/ugWg2EkBdEGmsBV+gFlTysLbluGehNuM0ITPzGepzHy/8Sblusq1BZjB6mkS1QnO+Y5EJnug2AOTSQzN//D/ywMcnE5dARnNdL6gYaoLQ94BS/V+5b+orEZ0zvpvvH4cu4jDQCB4M7/W2k4XfWKe2YyFfRLNXCc5xHYyAPzXfEnO6zoNPTs+DGiu/5RiVOfHw42eNoSvA4LDLRtRBRB8OBLE1GWm7GGE2a0q/c7dxXD1c0FFEqguHIvuR9WeswtQG2dSEX1q9Fejuikwj1kZ8Y8V6G0lBHosH/gPQsEHs1rln82cidU4QC2y+tThdC2iO7XSgtIJSt3yeFa3qW7Jr2QUgcaGmDg4p+CmiZT1jCD29P/k6vBAIH9slQ688NRn/iiOD5JNRNcev9DGgl5N5srZatjHnjrw9De46L2781j0tOTHkyB7Ypyy4OJfBZS9gjrXjrUdIn96X7hClxeULfvTtD1HcNTMAQYR/tBOmCfue2HUG0QzbgxTS6tyKJHnuRT3UV2ldfX/08vWii5uruqAyHDwO65dbtzNTp0NqIi3eIW8p8G9Aeq0YUJoWe/pNAdfEOZA2JyD/UHmDUodubS19o+n1CqYnUJ8OaPmdTSfLwFYlWIrTGcA==
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1645.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6038f19-cb24-40f8-4f42-08d85acf22c2
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2020 06:01:35.8805 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: loEGl/RQf3jzvEMy2o+e8kscapBZAfEDCWXR8IVpryGPfqaXHZffQT0H6s/AYRDi5KzWgCCZD+kPHhzFzW9b8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1101MB2207
X-OriginatorOrg: intel.com
Cc: "Sun, Yi Y" <yi.y.sun@intel.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>, "Raj,
 Ashok" <ashok.raj@intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "stefanha@gmail.com" <stefanha@gmail.com>, Jason Wang <jasowang@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, "Tian, Jun
 J" <jun.j.tian@intel.com>, Alex Williamson <alex.williamson@redhat.com>, "Wu,
 Hao" <hao.wu@intel.com>
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
> Sent: Wednesday, September 16, 2020 10:45 PM
> 
> On Wed, Sep 16, 2020 at 01:19:18AM +0000, Tian, Kevin wrote:
> > > From: Jason Gunthorpe <jgg@nvidia.com>
> > > Sent: Tuesday, September 15, 2020 10:29 PM
> > >
> > > > Do they need a device at all?  It's not clear to me why RID based
> > > > IOMMU management fits within vfio's scope, but PASID based does not.
> > >
> > > In RID mode vfio-pci completely owns the PCI function, so it is more
> > > natural that VFIO, as the sole device owner, would own the DMA
> mapping
> > > machinery. Further, the RID IOMMU mode is rarely used outside of VFIO
> > > so there is not much reason to try and disaggregate the API.
> >
> > It is also used by vDPA.
> 
> A driver in VDPA, not VDPA itself.

what is the difference? It is still the example of using RID IOMMU mode
outside of VFIO (and just implies that vDPA even doesn't do a good
abstraction internally).

> 
> > > PASID on the other hand, is shared. vfio-mdev drivers will share the
> > > device with other kernel drivers. PASID and DMA will be concurrent
> > > with VFIO and other kernel drivers/etc.
> >
> > Looks you are equating PASID to host-side sharing, while ignoring
> > another valid usage that a PASID-capable device is passed through
> > to the guest through vfio-pci and then PASID is used by the guest
> > for guest-side sharing. In such case, it is an exclusive usage in host
> > side and then what is the problem for VFIO to manage PASID given
> > that vfio-pci completely owns the function?
> 
> This is no different than vfio-pci being yet another client to
> /dev/sva
> 

My comment was to echo Alex's question about "why RID based
IOMMU management fits within vfio's scope, but PASID based 
does not". and when talking about generalization we should look
bigger beyond sva. What really matters here is the iommu_domain
which is about everything related to DMA mapping. The domain
associated with a passthru device is marked as "unmanaged" in 
kernel and allows userspace to manage DMA mapping of this 
device through a set of iommu_ops:

- alloc/free domain;
- attach/detach device/subdevice;
- map/unmap a memory region;
- bind/unbind page table and invalidate iommu cache;
- ... (and lots of other callbacks)

map/unmap or bind/unbind are just different ways of managing
DMAs in an iommu domain. The passthrough framework (VFIO 
or VDPA) has been providing its uAPI to manage every aspect of 
iommu_domain so far, and sva is just a natural extension following 
this design. If we really want to generalize something, it needs to 
be /dev/iommu as an unified interface for managing every aspect 
of iommu_domain. Asking SVA abstraction alone just causes 
unnecessary mess to both kernel (sync domain/device association 
between /dev/vfio and /dev/sva) and userspace (talk to two 
interfaces even for same vfio-pci device). Then it sounds like more 
like a bandaid for saving development effort in VDPA (which 
instead should go proposing /dev/iommu when it was invented 
instead of reinventing its own bits until such effort is unaffordable 
and then ask for partial abstraction to fix its gap).

Thanks
Kevin
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
