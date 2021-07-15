Return-Path: <SRS0=9Lhb=MH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B025BC07E96
	for <iommu@archiver.kernel.org>; Thu, 15 Jul 2021 16:26:07 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B8C6613D3
	for <iommu@archiver.kernel.org>; Thu, 15 Jul 2021 16:26:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B8C6613D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 1BFFE40E79;
	Thu, 15 Jul 2021 16:26:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5u8aDCO5YG82; Thu, 15 Jul 2021 16:26:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 9F9E140E7E;
	Thu, 15 Jul 2021 16:26:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 520C2C000E;
	Thu, 15 Jul 2021 16:26:05 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5F020C000E
 for <iommu@lists.linux-foundation.org>; Thu, 15 Jul 2021 16:26:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 74614415EF
 for <iommu@lists.linux-foundation.org>; Thu, 15 Jul 2021 16:23:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yirGUFEGq3CO for <iommu@lists.linux-foundation.org>;
 Thu, 15 Jul 2021 16:23:36 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5828A40238
 for <iommu@lists.linux-foundation.org>; Thu, 15 Jul 2021 16:23:36 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10046"; a="210569061"
X-IronPort-AV: E=Sophos;i="5.84,242,1620716400"; d="scan'208";a="210569061"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jul 2021 09:22:09 -0700
X-IronPort-AV: E=Sophos;i="5.84,242,1620716400"; d="scan'208";a="413692583"
Received: from otc-nc-03.jf.intel.com (HELO otc-nc-03) ([10.54.39.36])
 by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jul 2021 09:22:08 -0700
Date: Thu, 15 Jul 2021 09:21:41 -0700
From: "Raj, Ashok" <ashok.raj@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [RFC v2] /dev/iommu uAPI proposal
Message-ID: <20210715162141.GA593686@otc-nc-03>
References: <BN9PR11MB5433B1E4AE5B0480369F97178C189@BN9PR11MB5433.namprd11.prod.outlook.com>
 <7ea349f8-8c53-e240-fe80-382954ba7f28@huawei.com>
 <BN9PR11MB5433A9B792441CAF21A183A38C129@BN9PR11MB5433.namprd11.prod.outlook.com>
 <a8edb2c1-9c9c-6204-072c-4f1604b7dace@huawei.com>
 <BN9PR11MB54336D6A8CAE31F951770A428C129@BN9PR11MB5433.namprd11.prod.outlook.com>
 <20210715124813.GC543781@nvidia.com>
 <20210715135757.GC590891@otc-nc-03>
 <20210715152325.GF543781@nvidia.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210715152325.GF543781@nvidia.com>
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

On Thu, Jul 15, 2021 at 12:23:25PM -0300, Jason Gunthorpe wrote:
> On Thu, Jul 15, 2021 at 06:57:57AM -0700, Raj, Ashok wrote:
> > On Thu, Jul 15, 2021 at 09:48:13AM -0300, Jason Gunthorpe wrote:
> > > On Thu, Jul 15, 2021 at 06:49:54AM +0000, Tian, Kevin wrote:
> > > 
> > > > No. You are right on this case. I don't think there is a way to 
> > > > differentiate one mdev from the other if they come from the
> > > > same parent and attached by the same guest process. In this
> > > > case the fault could be reported on either mdev (e.g. the first
> > > > matching one) to get it fixed in the guest.
> > > 
> > > If the IOMMU can't distinguish the two mdevs they are not isolated
> > > and would have to share a group. Since group sharing is not supported
> > > today this seems like a non-issue
> > 
> > Does this mean we have to prevent 2 mdev's from same pdev being assigned to
> > the same guest? 
> 
> No, it means that the IOMMU layer has to be able to distinguish them.

Ok, the guest has no control over it, as it see 2 separate pci devices and
thinks they are all different.

Only time when it can fail is during the bind operation. From guest
perspective a bind in vIOMMU just turns into a write to local table and a
invalidate will cause the host to update the real copy from the shadow.

There is no way to fail the bind? and Allocation of the PASID is also a
separate operation and has no clue how its going to be used in the guest.

> 
> This either means they are "SW mdevs" which does not involve the IOMMU
> layer and puts both the responsibility for isolation and idenfication
> on the mdev driver.

When you mean SW mdev, is it the GPU like case where mdev is purely a SW
construct? or SIOV type where RID+PASID case?

> 
> Or they are some "PASID mdev" which does allow the IOMMU to isolate
> them.
> 
> What can't happen is to comingle /dev/iommu control over the pdev
> between two mdevs.
> 
> ie we can't talk about faults for IOMMU on SW mdevs - faults do not
> come from the IOMMU layer, they have to come from inside the mdev it
> self, somehow.

Recoverable faults for guest needs to be sent to guest? A page-request from
mdev1 and from mdev2 will both look alike when the process is sharing it.

Do we have any isolation requirements here? its the same process. So if the
page-request it sent to guest and even if you report it for mdev1, after
the PRQ is resolved by guest, the request from mdev2 from the same guest
should simply work?


_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
