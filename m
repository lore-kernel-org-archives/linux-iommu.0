Return-Path: <SRS0=9Lhb=MH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FB8EC636C9
	for <iommu@archiver.kernel.org>; Thu, 15 Jul 2021 18:06:23 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3400613C7
	for <iommu@archiver.kernel.org>; Thu, 15 Jul 2021 18:06:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3400613C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6DF6F42399;
	Thu, 15 Jul 2021 18:06:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tlzEOL4XQRh0; Thu, 15 Jul 2021 18:06:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 1AF7942284;
	Thu, 15 Jul 2021 18:06:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E9947C001A;
	Thu, 15 Jul 2021 18:06:20 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 613C0C000E
 for <iommu@lists.linux-foundation.org>; Thu, 15 Jul 2021 18:06:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4F5CC60C03
 for <iommu@lists.linux-foundation.org>; Thu, 15 Jul 2021 18:06:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id B0EsE5etEdCd for <iommu@lists.linux-foundation.org>;
 Thu, 15 Jul 2021 18:06:17 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 87F5260BF6
 for <iommu@lists.linux-foundation.org>; Thu, 15 Jul 2021 18:06:17 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10046"; a="197865470"
X-IronPort-AV: E=Sophos;i="5.84,243,1620716400"; d="scan'208";a="197865470"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jul 2021 11:06:12 -0700
X-IronPort-AV: E=Sophos;i="5.84,243,1620716400"; d="scan'208";a="460476517"
Received: from otc-nc-03.jf.intel.com (HELO otc-nc-03) ([10.54.39.36])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jul 2021 11:06:12 -0700
Date: Thu, 15 Jul 2021 11:05:45 -0700
From: "Raj, Ashok" <ashok.raj@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [RFC v2] /dev/iommu uAPI proposal
Message-ID: <20210715180545.GD593686@otc-nc-03>
References: <BN9PR11MB5433A9B792441CAF21A183A38C129@BN9PR11MB5433.namprd11.prod.outlook.com>
 <a8edb2c1-9c9c-6204-072c-4f1604b7dace@huawei.com>
 <BN9PR11MB54336D6A8CAE31F951770A428C129@BN9PR11MB5433.namprd11.prod.outlook.com>
 <20210715124813.GC543781@nvidia.com>
 <20210715135757.GC590891@otc-nc-03>
 <20210715152325.GF543781@nvidia.com>
 <20210715162141.GA593686@otc-nc-03>
 <20210715171826.GG543781@nvidia.com>
 <20210715174836.GB593686@otc-nc-03>
 <20210715175336.GH543781@nvidia.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210715175336.GH543781@nvidia.com>
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 Jason Wang <jasowang@redhat.com>, Kirti Wankhede <kwankhede@nvidia.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>, "Jiang,
 Dave" <dave.jiang@intel.com>, Jonathan Corbet <corbet@lwn.net>,
 "wanghaibin.wang@huawei.com" <wanghaibin.wang@huawei.com>, "Tian,
 Kevin" <kevin.tian@intel.com>, "parav@mellanox.com" <parav@mellanox.com>,
 "Alex Williamson \(alex.williamson@redhat.com\)" <alex.williamson@redhat.com>,
 "Enrico Weigelt, metux IT consult" <lkml@metux.net>,
 David Gibson <david@gibson.dropbear.id.au>,
 Robin Murphy <robin.murphy@arm.com>, LKML <linux-kernel@vger.kernel.org>,
 Shenming Lu <lushenming@huawei.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Paolo Bonzini <pbonzini@redhat.com>, David Woodhouse <dwmw2@infradead.org>
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

On Thu, Jul 15, 2021 at 02:53:36PM -0300, Jason Gunthorpe wrote:
> On Thu, Jul 15, 2021 at 10:48:36AM -0700, Raj, Ashok wrote:
> 
> > > > Do we have any isolation requirements here? its the same process. So if the
> > > > page-request it sent to guest and even if you report it for mdev1, after
> > > > the PRQ is resolved by guest, the request from mdev2 from the same guest
> > > > should simply work?
> > > 
> > > I think we already talked about this and said it should not be done.
> > 
> > I get the should not be done, I'm wondering where should that be
> > implemented?
> 
> The iommu layer cannot have ambiguity. Every RID or RID,PASID slot
> must have only one device attached to it. Attempting to connect two
> devices to the same slot fails on the iommu layer.

I guess we are talking about two different things. I was referring to SVM
side of things. Maybe you are referring to the mdev.

A single guest process should be allowed to work with 2 different
accelerators. The PASID for the process is just 1. Limiting that to just
one accelerator per process seems wrong.

Unless there is something else to prevent this, the best way seems never
expose more than 1 mdev from same pdev to the same guest. I think this is a
reasonable restriction compared to limiting a process to bind to no more
than 1 accelerator.


> 
> So the 2nd mdev will fail during IOASID binding when it tries to bind
> to the same PASID that the first mdev is already bound to.
> 
> Jason

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
